Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818F7E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 22:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161828007A;
	Sat, 14 Dec 2024 23:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wogYzf8H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YKTUQFTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C81980098; Sat, 14 Dec 2024 23:46:21 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 740DC8006C
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y9hBz1W1pz9sbh;
 Sat, 14 Dec 2024 23:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BFw/XqMVo05esRuas4i0H3aXOYLY5MS5f0NLrA+hQ8g=;
 b=wogYzf8HzZa+vlwpW3bRiXTGt617kiINtizukRNDO3saffa+DIqBnOAk7uJ9UTE+PrzvUS
 9uSEYvhWdEIrrs9yYHwrKDllmwAGF/z5MoBsZhWOBlK3/IV1h/c12DalYF1zQxcnlwkKo+
 eTLrT1ZfzdfrDvQZX8VTh1vdWszK1aXGaa2CA7KmvPXK0DrJpODcBjhJ92ayjUePneD2I4
 9OmnexKv36lHnq58PdN8uXuhuk7C303TLsQv0z+yzuMakGVfg/3ZK2WdEL7hW3vMmmYX21
 nB8QMZgufBssnkEoCvaUpOMPjVQytKHg/OEwdnc/rpCcT1sCrB3le+wKHwaP0g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BFw/XqMVo05esRuas4i0H3aXOYLY5MS5f0NLrA+hQ8g=;
 b=YKTUQFTmFEj6Xu5bozmyj3AMLohl8VhV3jWBkhXVWnbdGuU6R1Iwo2Y8BVqJN24LaUvBLH
 et8nA+lWoCNfRYyMfCytbKBzAl2jbDAGcJeqC0DzVNsGFthwTey5xdbX70YNIDMIxcbqad
 CcxGh3r9tMyZUpHxkRTndwxZp20nNBYnjYlnikLI1801X+FLnUJ/SxrQhp6foN+fvcbvBT
 1oojuVbactHelhCrA6RIAfNZHCcRiTojJIdzoknPAsFaYC5F3WvWNEco4g8tdByajiXVWh
 kcj6f4u8cgpgoWgNVXFwIgM5M6lfesiyRbRWjY44U+PgJt+IJk0GOxobN/9h2Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: Drop OF_UPSTREAM conversion remnant
Date: Sat, 14 Dec 2024 23:45:52 +0100
Message-ID: <20241214224607.303903-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fgc6cip99zimj7jokrfp55fp84fewk8h
X-MBO-RS-ID: 5efdb6421d2b50c356e
X-Rspamd-Queue-Id: 4Y9hBz1W1pz9sbh
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

This DTC_FLAGS assignment is no longer necessary as all R-Car Gen2/Gen3/Gen4
platforms have been converted to OF_UPSTREAM and matching DTC_FLAGS assignment
is present in dts/upstream/src/arm64/Makefile . Drop the remnant.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 99d775fd382..3763e34dea3 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -978,10 +978,6 @@ dtb-$(CONFIG_ARCH_IMXRT) += imxrt1050-evk.dtb \
 	imxrt1020-evk.dtb \
 	imxrt1170-evk.dtb \
 
-ifdef CONFIG_RCAR_64
-DTC_FLAGS += -R 4 -p 0x1000
-endif
-
 dtb-$(CONFIG_RZA1) += \
 	r7s72100-gr-peach.dtb
 
-- 
2.45.2

