Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BE1CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3CF839E8;
	Mon, 27 Oct 2025 18:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E8x2ea91";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xCHS12P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E27D839F1; Mon, 27 Oct 2025 18:09:58 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE6A83955
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cwKkX2Q3dz9spj;
 Mon, 27 Oct 2025 18:09:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jRA83ZdY3k8tExJhL+oG5+NI+jYir6lBXUg1TUilF8w=;
 b=E8x2ea91mAt5/+ZU3f0Q7QNOgpwi0BaGqXucaHxEJZ3GQM504LVx/+CZoNxyY5OVa3alSc
 35DImTN946ewLjwPMX7kCpXhdBAiyEIv7AOkfyTJPiQk0EpRpYIy2wIeQkbKZk9zW8LwZg
 FNSE676MlDbkIj6B7AahSc6hawXMDvaNLk+VfP2TLVww4/gHtgQtvps7OULXNQ9j76HTBz
 IZzm8t+NlodOCClWdi7RN+CsTkDuEHE5ck2tFAJtTENquR7neRLryvmLhuBuwOsnh1kUVN
 0UNMLyR2KfqqUcmVNswCUTG54XM3NNIRTX1/0vQmnpAMwLoE5fPRQV5qcnK4Eg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xCHS12P3;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jRA83ZdY3k8tExJhL+oG5+NI+jYir6lBXUg1TUilF8w=;
 b=xCHS12P3ZdeTxtC5X2d3QMn7ikSE+Pp7z6oUYrJhFja/WjFiFwFRdC8Jh5aS5LSOvBnGLy
 o3S4VOs4uEKUjnWDO+ZkAQ80IQvCWHlvYv7TmKSTiy2lpSg8hSaUHsr6sKcqq1Pmco691i
 pVxizA/5LKc2QpCSKlEAZ/GJNZbHpLepwaCkpy2cNPSI1FWq1KjRTA6EZm0GC+lHLg2iep
 5aviOAqzp5mg9MFVIsGwt2pr792rCfA9sxrhCVAaMWPF9EK3S8zFCtQbcKuvBzZqn96zqo
 CEIAOBxt0QXtxxJkb75/2hKShIhyb1xbgg5vbPaEWdWh4Zp82uMs/OyBfNrO0w==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Make CONFIG_SYS_LOAD_ADDR family-specific
Date: Mon, 27 Oct 2025 18:09:24 +0100
Message-ID: <20251027170951.29495-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9488b8c6982e4b34294
X-MBO-RS-META: fdyipczw1euowtxiqrt365bchi4hetr9
X-Rspamd-Queue-Id: 4cwKkX2Q3dz9spj
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

From: Hai Pham <hai.pham.ud@renesas.com>

Make CONFIG_SYS_LOAD_ADDR family-specific to prepare for R-Car Gen5
support. R-Car Gen5 uses different memory map compared to the current
R-Car Gen3 and Gen4 and also different CONFIG_SYS_LOAD_ADDR. This is
a preparatory change for R-Car Gen5. No functional change.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Upport
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar3.config  | 1 +
 configs/renesas_rcar4.config  | 1 +
 configs/renesas_rcar64.config | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/renesas_rcar3.config b/configs/renesas_rcar3.config
index 9f2413ae928..f4713898bc6 100644
--- a/configs/renesas_rcar3.config
+++ b/configs/renesas_rcar3.config
@@ -1,4 +1,5 @@
 #include <configs/renesas_rcar64.config>
 
 CONFIG_BITBANGMII=y
+CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_SYS_PBSIZE=2068
diff --git a/configs/renesas_rcar4.config b/configs/renesas_rcar4.config
index 085d02b51c3..6ebd93ede9f 100644
--- a/configs/renesas_rcar4.config
+++ b/configs/renesas_rcar4.config
@@ -12,6 +12,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_RENESAS_SDHI=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SYS_I2C_RCAR_I2C=y
+CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/renesas_rcar64.config b/configs/renesas_rcar64.config
index 073f728bf09..c2cb88dc157 100644
--- a/configs/renesas_rcar64.config
+++ b/configs/renesas_rcar64.config
@@ -11,7 +11,6 @@ CONFIG_REMAKE_ELF=y
 CONFIG_RENESAS_RPC_SPI=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_SYSCON=y
-CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_SYS_MALLOC_BOOTPARAMS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MONITOR_LEN=1048576
-- 
2.51.0

