Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EFAC67861
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 02:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B0587BA8;
	Sun,  7 Apr 2024 04:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mailtundra.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailtundra.com header.i=@mailtundra.com header.b="CQLbFhd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5CA87FE0; Sun,  7 Apr 2024 03:47:48 +0200 (CEST)
Received: from mail-40110.protonmail.ch (mail-40110.protonmail.ch
 [185.70.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF8087FBF
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 03:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mailtundra.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwleeds@mailtundra.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailtundra.com;
 s=protonmail2; t=1712454466; x=1712713666;
 bh=Tlfo6jmAs/CaD2+mOiA93p8oXVYlRDK/W+yxQAa32yg=;
 h=From:To:Subject:Date:Message-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID:BIMI-Selector;
 b=CQLbFhd+j51ElQmH+rfdUJtBrG1hqtdSrgZEnD0SJqAfw0Sy0y6Yg2eHKBoKsGn/L
 z+TjenoPpzXGDXmmrKGYINliK5FUW+2Fu8evSQtkaQHKL2sIM/nYmfBLYBhZz/vXct
 OTPyI4MYGIhkNV7tkMy0ftcz6ETM3DvC2TIzMN1R0eORuxQ9ZJM+K1zQ3IH3WIqZQp
 KytuYUZ3eHDIiO78KxJD3Qa3GnvvYvqGXnzymYGVlA1M8rdz5jJJtfRWL2vLjvexIc
 RwmE9Hf46KJnThuwFiqS1pav1Id5vf8TehUR1Ezt5MOVX9OrgQSNhzhJmU03AYuMoD
 9LM5CfwF4q3+Q==
X-Pm-Submission-Id: 4VBw8c5ZFMz4wwdR
From: mwleeds@mailtundra.com
To: u-boot@lists.denx.de
Subject: [PATCH 0/5] zfs: Fix zfs support on aarch64
Date: Sat,  6 Apr 2024 18:47:24 -0700
Message-ID: <20240407014743.13872-1-mwleeds@mailtundra.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Apr 2024 04:00:03 +0200
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

This patch series is needed to get U-Boot to boot from a ZFS filesystem
on an aarch64 computer. Some of the patches are not architecture specific
and would be needed to boot ZFS on other platforms as well. The ZFS
support in U-Boot hasn't been substantively touched in several years and
to me it seems like it must have been broken for a long time on all
platforms, but I have only tested on aarch64.

Since there doesn't seem to be a mantainer for this area who I can cc,
I'm hoping these patches get seen and pulled in by a general U-Boot
maintainer.

Phaedrus Leeds (5):
  zfs: Fix malloc() success check
  zfs: Add a comment to clarify nvlist memory layout
  zfs: Fix unaligned read of uint64
  zfs: Fix return value of fs_devread()
  zfs: Fix zfs_read() to actually work

 fs/zfs/dev.c |  2 +-
 fs/zfs/zfs.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.44.0

