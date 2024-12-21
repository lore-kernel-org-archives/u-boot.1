Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB30FE7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 23:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040A78056A;
	Sun, 22 Dec 2024 00:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lnimPKsc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pPPPW8pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75818805FC; Sun, 22 Dec 2024 00:59:09 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197D580516
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 00:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YG1Tk3RHBz9sWS;
 Sun, 22 Dec 2024 00:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734825546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yFh/BvrTt/Gf7OK3GAUmN4UAmaw8iAToUbCZ4qLeh9c=;
 b=lnimPKscv6D3rfNKLOb+eVqReOV4PoDo750vIRrGZ4M8iR3RjJaZhW81agzsKTC8YdAcm9
 PNunwIC6HRAWiSoEGkNHvIiGGt3vVH3A4xoPFAuW70JXRzrf60KlNi3OnPEqbs9JJ9I/Hp
 8vYdIkYmHEF5QIxwpDICOw4sksheC0fsoiS0LjB61AZgORY3WVsiYbe5zl0c5mpJC2I7FW
 8umviMXLjx/AfjFXBFfm0uqUls6WLE86PQrevX1QHZs0yLWGhiqrQAvHgWoAYmq0ceOQJq
 hBdct6yym1Cf36nZg9dZG2fdJudO/f56ZuGSu4whbE3ufi8o6ZeaWXH6rtG2Wg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734825544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yFh/BvrTt/Gf7OK3GAUmN4UAmaw8iAToUbCZ4qLeh9c=;
 b=pPPPW8peHpUIakJJXc7yAWmaLHqtsNZEeWcoFw1AvQcdUvIXzwXcjEN5jPaiouJ9YIAm10
 HJetTsSGBXy4DaBLcJgaYt/+HY1hWrCs5eQiYRPMFZstX3C8ZdukyD3KrnNBgeE3qoeCLY
 xIZcdIG9bOB4GtNb7XA1TpnYnxisljQ8UQUEaituURSICya+4Ku0vyyEQxPWaP/sFiwznr
 GV8IWMLeJx0Y1WgzhOKcXZ6WJfXPkkDV1Ll7V19i6K8FhB4ZXpl5IcTDGrMka08ZTOCgOv
 7BzgXIhix36L7DZBz5nncIlHzBaeebYv2ufwuLQb/82tQDMBOkY+1EDXDoMTJQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: renesas: Consistently enable ENV_OVERWRITE on Renesas
 R-Car
Date: Sun, 22 Dec 2024 00:58:24 +0100
Message-ID: <20241221235847.383312-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 531iuwuif7o1333ukrqhe9m3nybkm54f
X-MBO-RS-ID: 6b585276cb64a00d1c8
X-Rspamd-Queue-Id: 4YG1Tk3RHBz9sWS
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

Move CONFIG_ENV_OVERWRITE=y into commont renesas_rcar.config to make sure
this configuration option is consistently enabled on all of Renesas R-Car
Gen2, Gen3, Gen4. Currently this option is not enabled on Gen4, this fix
corrects that omission.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar.config  | 1 +
 configs/renesas_rcar2.config | 1 -
 configs/renesas_rcar3.config | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index 351803b743a..d0a12f266aa 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -17,6 +17,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SPI=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_ENV_OVERWRITE=y
 CONFIG_FIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_MTD=y
diff --git a/configs/renesas_rcar2.config b/configs/renesas_rcar2.config
index 74dfd41f1a3..4ffc4d05882 100644
--- a/configs/renesas_rcar2.config
+++ b/configs/renesas_rcar2.config
@@ -14,7 +14,6 @@ CONFIG_CMD_USB=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4f000000
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/renesas_rcar3.config b/configs/renesas_rcar3.config
index 228e1b4c679..7f7fab7df1d 100644
--- a/configs/renesas_rcar3.config
+++ b/configs/renesas_rcar3.config
@@ -2,5 +2,4 @@
 
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
-CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_PBSIZE=2068
-- 
2.45.2

