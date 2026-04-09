Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA4FF364B8
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D818419C;
	Thu,  9 Apr 2026 22:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="seTwIXX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B909B84198; Thu,  9 Apr 2026 22:32:11 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52A784201
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-47018d34159so1077199b6e.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766717; x=1776371517;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YDyQDLGMdqUletDsc30qTzqtglhw4D1rGJgxVpC3dRk=;
 b=seTwIXX1o0o8PmMPeRbuswoHQYQ5R8uQolfiKUJsWSSeU94mHhVhBB3xgkbiQIs2tG
 xE8TPGly4pi5mrlKoDBqssYSaXGMH7+R/Il9pP1Nv1EJQRjn4pzpfy/Z2mktUSWLhJ++
 0feIxvUIouW08C7et7re/MpszoxSGm0CzNwZLNuk4+8qpRAAHVsLYZ7U7Zjd730QQ+op
 kEyuCYTnZgLKxm1O63RmDB1mNcp3v6At89GO66ZiRSVrMCxYixnlaC7SC3Kz95ojN/a3
 AIZpGMwP+TZEZOSZ6XTV0FHvkiPEQ25c2Lx3irDmn03EjRMYWk3idEzgLC6gl14HgNAX
 PJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766717; x=1776371517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YDyQDLGMdqUletDsc30qTzqtglhw4D1rGJgxVpC3dRk=;
 b=KBDi8FUiqf0m68IRHG4nyyNIs6HQSNLyMm92VbjfqvNFdOhCecNSTVpiu0TkQhhzso
 eAI4ln6DJC0XcijwiVO/5u1BjbKA2vfgyumypsvVG/pNUZIfRGugurDfZSr3nA46dadp
 DGTf5lEvg47bO+/FMOK8plHaL0z3ss70muWmv8mLnv84/udH78RIzShh9H6+Emj+G/hM
 b9WS+6sqIqa0DqnWFB0J3Nx1jimTGx1J1webd8SKCOOlAvj1EutSfWbew52bSH1hLSKE
 vGLkph9g0YG8Jt6hqdzbAojlQrW5so67DfpHb04YfzsSn66c3oszBbNRamn5QrtFTubU
 +MGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiJ+YhktxJjm5wUDWo/0AO1b+oKMxCm603r5rgPreD/kPhEWtVEqRp8zfl3Qrfq2Xe6WoNXrc=@lists.denx.de
X-Gm-Message-State: AOJu0YzF8vG7mWetV4mi0s9l16eNct8/ZWUNhyh5nzwQ1cmTjAS0e+s+
 Sci5MQOFUJOIn0h5D+t7YDiwBWGwHwnBpHPFMG50QC1bi5hpgw3aiesWWECtCZsnjKo=
X-Gm-Gg: AeBDiesllnUcJaxP1wHlhSG1GpU/pgf70V33rKgUJW6A4cmPparn+1aU8gfruP85dXs
 86qyizbZqawhh5f7sEkBIKB/obTe8s8QXp81JOYj4t7pjL1oQCUNkXAZxx4ZU4rw9TMoOSzx5uw
 AekKKVAyRQ73u7SXb4GlQY0rbDgdJ69cvxN9QcSJ7pbJfno2x39DsSS4zmTO4o4fw2exonRbXiz
 //tujPzUY7hD35a562+tuxFECXQ3yQ4JGI+72runkFqAdkfB/pF5WWdfpU4Xs2IKaMuysAxHuvL
 7RtCRUUO+iBQR8CVac6/SdOFLrDBIU7lbN/vSD+e6yRTWKVyzRPi+13EwqOYHkJituEOPP5jD6n
 CnMNYFxeQTH09HylnBhEtG8m/m3/yPbD1wScE3B8QoM0ZT0Asaz4PfQXD0XpDFdcniV9AZuPfbn
 SaS3Lt5QKU53fEA825SMF/hxkh+JPf
X-Received: by 2002:a05:6808:c168:b0:468:b01:c28c with SMTP id
 5614622812f47-4789f909351mr419868b6e.46.1775766717388; 
 Thu, 09 Apr 2026 13:31:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 09 Apr 2026 15:30:38 -0500
Subject: [PATCH v2 6/8] power: pmic: mtk-pwrap: use pmic compatible to
 select child info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mtk-pmic-fixes-v2-6-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2945; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=DCtW/6ItScysX8t+HymZdjuv554Mm7J+MxPKaM/lc3M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2AyeCzhHA/83E5C5iT866ajls8/lV18rv7O+D
 MJD2x3HaQGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMnhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnhsH/0/a1PxC6F4pJ6Lsr4de3cQBJMe0e0AMFrKrSRZ
 egpq2M+8CH07RcM8e+Mcjl5BXm56TeYH5CPb+oeoZTsu1NgWJl8zShTLkoBdvF8Vg44w/z/A6ay
 cXDRTlc3a1wNYwp1eSsZI7v9oC9/YBOzHMhcC7RbitKhLelrMK2mLSpA6//j5Wfk+mmH7yO1htm
 OyeVleHMgctgPgQ96xZ7hY4HaEk2L6CUHrmPbv8mi0O2ltHDRem6+eOwWe+awXyY2X2skL7qZzf
 0ziOjG6NSp4NyCfAfqQswjHMscGDaUWQnX1De4cZ+B/PbCvMptHiRpVJPUabXZBuzmTtrBPoTwv
 Qi+E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change the logic for selecting pmic_children_info to use the compatible
string from the devicetree instead of expecting the pwrap (part of the
MCU) to correspond to the separate PMIC chip.

In addition to being more correct, it also saves a few lines of code for
each MCU type that is added by dropping the enum and type field.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index c41ebeb62cc..7d84ab1f6d3 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -341,12 +341,6 @@ static int mt8365_regs[] = {
 	[PWRAP_WDT_SRC_EN_1] =		0xf8,
 };
 
-enum pwrap_type {
-	PWRAP_MT8188,
-	PWRAP_MT8189,
-	PWRAP_MT8365,
-};
-
 struct pwrap_slv_type {
 	const u32 *dew_regs;
 	u32 caps;
@@ -365,7 +359,6 @@ struct pmic_wrapper {
 
 struct pmic_wrapper_type {
 	int *regs;
-	enum pwrap_type type;
 	u32 arb_en_all;
 	u32 spi_w;
 	u32 wdt_src;
@@ -780,7 +773,6 @@ static int mtk_pwrap_bind(struct udevice *dev)
 	ofnode pmic_node, regulators_node;
 	int children;
 	const struct pmic_child_info *pmic_children_info;
-	struct pmic_wrapper_type *pw_type = (void *)dev_get_driver_data(dev);
 
 	pmic_node = dev_read_first_subnode(dev);
 	if (!ofnode_valid(pmic_node)) {
@@ -788,16 +780,13 @@ static int mtk_pwrap_bind(struct udevice *dev)
 		return -ENXIO;
 	}
 
-	switch (pw_type->type) {
-	case PWRAP_MT8365:
+	if (ofnode_device_is_compatible(pmic_node, "mediatek,mt6357")) {
 		pmic_children_info = mt6357_pmic_children_info;
-		break;
-	case PWRAP_MT8188:
-	case PWRAP_MT8189:
+	} else if (ofnode_device_is_compatible(pmic_node, "mediatek,mt6359")) {
 		pmic_children_info = mt6359_pmic_children_info;
-		break;
-	default:
-		dev_err(dev, "pwrap type %d not supported\n", pw_type->type);
+	} else {
+		dev_err(dev, "pmic type %s not supported\n",
+			ofnode_read_string(pmic_node, "compatible"));
 		return -ENXIO;
 	}
 
@@ -846,7 +835,6 @@ static struct dm_pmic_ops mtk_pwrap_ops = {
 
 static struct pmic_wrapper_type pwrap_mt8188 = {
 	.regs = mt8188_regs,
-	.type = PWRAP_MT8188,
 	.arb_en_all = 0x777f,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
@@ -855,7 +843,6 @@ static struct pmic_wrapper_type pwrap_mt8188 = {
 
 static struct pmic_wrapper_type pwrap_mt8189 = {
 	.regs = mt8189_regs,
-	.type = PWRAP_MT8189,
 	.arb_en_all = 0x777f,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
@@ -864,7 +851,6 @@ static struct pmic_wrapper_type pwrap_mt8189 = {
 
 static const struct pmic_wrapper_type pwrap_mt8365 = {
 	.regs = mt8365_regs,
-	.type = PWRAP_MT8365,
 	.arb_en_all = 0x3ffff,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,

-- 
2.43.0

