Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2162C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC0887EAB;
	Mon, 26 Feb 2024 22:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AybymaHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E33E87FB1; Mon, 26 Feb 2024 22:24:10 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B47587F57
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-150.46.114.pool.telefonica.de
 [46.114.105.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 239D840EB8; 
 Mon, 26 Feb 2024 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708982645;
 bh=mAf4cayDNhN6FzEIzQZuBPqznWcnLRxkbSItqsOpGIg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AybymaHtVw4mFRpYhf4ht06w5gjxtZqaQmHt6I995IdQOHPAl63J9PpNgPy8OJbqH
 LLymWCuhzmOfdGBDRqmP75Sf0bthWf6KoNlA5tlmztJ7kju0sk9Futj0hXW6hvDgpR
 X/DBuUDZHZrgCrhVjgv/jhooe0c+2pIlkRdslZEIYcCImxa/zNVmlB7uabQ2TAgAdU
 4UKARBH875ymOksltjm92kBX0R8Dub5H3H+NQIgNez+TNlXoyqLJRZO3Ra6T1traDX
 wSswQFUCaXaWr4E1A1FwKnQw2uOHIBExvhSYLt63qWzFHQyv6IUkAOUpYA4FyZLSCB
 nTmO4G7j4ezJA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] arm: separate .data and .text sections of EFI binaries
Date: Mon, 26 Feb 2024 22:24:06 +0100
Message-ID: <20240226212408.7535-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

For security it is preferable that memory pages for executable code are not
writable. So there should be only RX and RW pages. To enable this sections
of EFI binaries must be page aligned. Furthermore .text and .data sections
must be separated.

We already made the necessary changes for arm64 and riscv64. This series
addresses the arm32 architecture.

v2:
	New patch to page align EFI binary section.
	Consider that 32-bit arm uses .rel and not .rela relocations
	and discard them as they are cannot be used in EFI binaries.

Heinrich Schuchardt (2):
  arm: page align EFI binary section
  arm: separate .data and .text sections of EFI binaries

 arch/arm/lib/crt0_arm_efi.S  | 44 +++++++++++++++++++++++++++---------
 arch/arm/lib/elf_arm_efi.lds | 28 +++++++++++++++++------
 2 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.43.0

