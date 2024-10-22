Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A75D17151
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 00:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0714588606;
	Tue, 22 Oct 2024 02:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aXbNyGUx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QgS1khkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B368899C; Tue, 22 Oct 2024 02:56:02 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7861688599
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 02:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XXYdV1gPFz9scH;
 Tue, 22 Oct 2024 02:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729558558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OKW8nkuppk1KdrR+n1pVCPMGmi7Q3eCULyegOueVQh8=;
 b=aXbNyGUxBmAtgrRRWq5nIAUjwYCyNeesk8xWYr/mV5W4vXGLwLrBOrED3dhF5/8ChrL2yS
 X5XXra2SZF57yXDctP3lUl9v2FDLqQVMXIa1ypKBSEDwGK3NJ+5HIavR4lpyK5Op09zVqG
 OCZbBFxSXQRa5C6Eo1Zs60HOIDxiL0V5PzbS5iEFzGs4UcBdZWHJUkc1mlLIFamWYzuT3s
 gTR99f2C4RyZOryF59KDkjtfVQIbiP9HxzaQ5J5tE4WQR/uOdUgaTTF4/qkKh0srXCoNkv
 lrHn1yzOKuvjzQwA84GSQyVW+kYgpGIhzUHZM4qLAYzLiLcmMByZQCKJEFYr/Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729558556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OKW8nkuppk1KdrR+n1pVCPMGmi7Q3eCULyegOueVQh8=;
 b=QgS1khkRpkpq2e5GTEamGAjKIL9Tof9N5IktxFZpmxNjxPi/RAlZWhO67ZawBA29gsbneT
 mRcoB0afPGx/dSF+aS196q1/2uVj1AjqT1HrwBuhFa4Acy17mWznAWUSlCxw8cfZ3IOs/i
 e8Q5bvhcfnUHfPN8WEzr0G36S2UyjOTmcS5gDs/yk+ks/d7biEOl+JKviZrubkFisnrKKA
 q26y6ANrF3tIXjtrE/5csGAvqYPmzdAQAVv1o1VjFQF36ZS0DYUvsKOlLsLlXoiVtU44BP
 2udKNEAo09s0kVgzoNW3vMtxVB3tu6tBanAV+mei88FUHCygmwWkGbRewugcoQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: renesas: Add top level boards/renesas/ MAINTAINERS file
Date: Tue, 22 Oct 2024 02:55:32 +0200
Message-ID: <20241022005543.239308-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sjj7cg19m551dwfqpiwyjt9r11qjmagc
X-MBO-RS-ID: ee39b9a067508636a72
X-Rspamd-Queue-Id: 4XXYdV1gPFz9scH
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

Add top level boards/renesas/ MAINTAINERS file to catch all the common
Renesas file patterns and put people on CC via get_maintainer.pl script.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 board/renesas/MAINTAINERS

diff --git a/board/renesas/MAINTAINERS b/board/renesas/MAINTAINERS
new file mode 100644
index 00000000000..d96be7d8520
--- /dev/null
+++ b/board/renesas/MAINTAINERS
@@ -0,0 +1,15 @@
+RENESAS BOARDS
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
+M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+S:	Maintained
+N:	grpeach
+N:	r2dplus
+N:	r7s72100
+N:	r8a66597
+N:	r8a77
+N:	rcar
+N:	renesas
+N:	rza1
+N:	serial_sh
+N:	sh77
+N:	sh_eth
-- 
2.45.2

