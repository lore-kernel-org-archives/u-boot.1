Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DC9F46115
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 903B784144;
	Mon, 23 Mar 2026 14:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mQ/vHnTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF1284148; Mon, 23 Mar 2026 14:43:14 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7BE84099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D1544380B;
 Mon, 23 Mar 2026 13:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F782C4CEF7;
 Mon, 23 Mar 2026 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774273390;
 bh=ELGN7+2FkkSaWxcngu7PqeaKwb7oORMOp5q3h9ev+yE=;
 h=From:To:Cc:Subject:Date:From;
 b=mQ/vHnTI+5/ocVZu6/DtuwXC+ncf1aOx9n2EGhd9s8JOCYBpx3jZ4FU7FBdkG1NEg
 Hv7bZh10/m3KVXApZGmRD9i8n1Y38nFSheL6GewYYbACh7Swd+Woc0Y73XxEqfigNe
 aXOZcA5jtEp7uMjenW2EgAnA2Rja1VI0qYtWl9ShCwlWNBImzKCnqR7McnoSOGsHJX
 EMs37+qPjjVmq4JTrRMadUQqBwj7QBYucwAvXiSfP2k8CVE+AOVqIC/SSPbp6pcq2F
 lAatED/aKy75MDEjuK4dIEistVg+hEUaPMbw9/o2tRdZvD+1w6uywtF0xHb7xx5Ss5
 F+6Z+ItqtSIYQ==
From: Michael Walle <mwalle@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/4] fs/erofs: major alignment fixes
Date: Mon, 23 Mar 2026 14:42:16 +0100
Message-ID: <20260323134305.2675822-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Throughout the whole fs code, large (4k) data buffers are allocated
on the stack. While it is not nice, to allocate that large buffers on
the stack, there is a much more fundamental problem: it's not
aligned.

This will result in a huge amount of cache misaligned messages on
arm32 SoCs, e.g.:

 CACHE: Misaligned operation at range [x, y]

While this is more or less a warning, as it will only invalidate
surrounding data, DMA is more of a problem. Some DMA controllers
have address restrictions and because of that there is
ARCH_DMA_MINALIGN. Thus as a first fix, move all the data buffers
from the stack to the heap with proper alignment.

There are still some misalignment warnings. I've traced it to
fs_devread(). Most of the calls to blk_dread() will pass an aligned
buffer. But the main blk_dread() will just pass buf, which might
have previously been advanced by readlen. Not sure how that could be
fixed in an elegant way. The simplest would probably be just a
bounce buffer, which there is already one in blk_read() if
BOUNCE_BUFFERS is enabled. But I haven't managed to get that
working. And now, I'm running out of time.

Michael Walle (4):
  fs/erofs: align the malloc'ed data
  fs/erofs: allocate data buffers on heap with alignment (1/3)
  fs/erofs: allocate data buffers on heap with alignment (2/3)
  fs/erofs: allocate data buffers on heap with alignment (3/3)

 fs/erofs/data.c     | 125 +++++++++++++++++++++++++++++---------------
 fs/erofs/fs.c       |  14 ++++-
 fs/erofs/internal.h |   5 +-
 fs/erofs/namei.c    |  47 ++++++++++++-----
 fs/erofs/super.c    |  40 ++++++++++----
 fs/erofs/zmap.c     |  61 +++++++++++++++------
 6 files changed, 205 insertions(+), 87 deletions(-)

-- 
2.47.3

