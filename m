Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA13C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C10B381312;
	Fri,  7 Aug 2026 16:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id th2gl8PJpehb; Fri,  7 Aug 2026 16:02:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5ADB88137E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786118549;
	bh=mzScyui2wTqVdy2f3O0+s3dFnPWw1FS2MwsSLG0QF6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fb45+Qd7zTq9oWzBidSd2e6fcVB1QdHQHi/6KOj97T6mdECr7cKICwA0ApFiISgXP
	 MO9H60rEvXU+ICov08mEKhAVjW8TO/bjTTlB+etrPItu0XcZHnSVd+lhbAJPfpuYeB
	 lWHJbAGKK7b+o+BO7yPVdoU4Y851CH9u9UnVsZrVW3GJ4eMbQ6U6NZ8gRwrKEAEFar
	 U8iGnK88qhpW8QjCjsTyWXApEPCCZmHKqYIXUAZXR/LTxu/DlVsvaYIqw+z+M5eDK1
	 5spN58pq1gMO0AZ+K/8NGVZQjIO6MS5so1/KEZx8S04US3yexzZKn8hlOmxhKpSbqi
	 /PxpCdt5Pn+IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ADB88137E;
	Fri,  7 Aug 2026 16:02:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B669218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61DD74008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZiMpSQxi6QJA for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:02:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 706EA400D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 706EA400D1
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 706EA400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:23 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6ae5baaef5dso1708617eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118542; x=1786723342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mzScyui2wTqVdy2f3O0+s3dFnPWw1FS2MwsSLG0QF6s=;
 b=ORiW1uHzSTphiIlVH/C6UbFHR8RGO1K6J4yWMq4B7jsJf8fpBlGpW0BxBFqZiYO1Z8
 R2vmMqW+iPMdiouitksfLtvS4HL6T4z5fV2fO0AJHbE/1AtDwrYsgLlaJ2vT69TD7DB+
 2IhnoFF7MSXOK5U+JRMJ+DrKCP8PGH12z/8M7IvEsKKF2p0cNOdV32lrweJuahqgttQx
 aUmF84IQX5lpqaJDwGd7mhx6jGsaRvz334AzvujJO+tvJyBVyKYOYkjSqM4Hm088gYva
 cV1vurPCBYZXLjeZi+h04lGmXrsOLb2iAvRDBhUs56aZekiDed5A6hC+fsRgUrsXJOT5
 VKgg==
X-Gm-Message-State: AOJu0YzlS9RPiRPaT+tsV2U+hHW2yWUNjFafAgAG/uliEeifSpRxZ4al
 BabAcaWazKifCYiYRaNkJiQw9+PXrGW1xH0Yei1CGNv86LNWwVGbgrfTPD3SeWv3O0g=
X-Gm-Gg: AR+sD13u+MS0M/vCbSfPjdDM7D0xj/mnJh8dHSqauu3HcTPhPr53s9S4iaMmY4B2zuq
 nq8WQRnL/AZ9kfM5bq/w0LrCQRU0LjBf2TXKHEDfrXYz30Pl9t703FExb8RkwshAbFg0elEtJoe
 xkQ3pxcvjQD2JVJb0mPwOI+UEXHIRTRKD5q19fS+6ZwNvOspVDP0ya/ih/Jd0oryHrnQMWT2M3S
 HJKq2l8MHL0VJ29PkYWX7TCZjMdkT6W0imYK1dqvFt0sxNB+/IdTvJjxjy9+rceVl7Rc0HAFVD0
 LkCH8hCoiVCU/IC9tVpG1bK/OQ2G8Ue84tOdUYD3l/mN2fg5r9PcjXhmk8qkf+ioUaBzQwHoWVt
 6dBfTDfp6jtUgrFa64Qrma4GLM/xtysGaU9uAAxEgELJBtMsZFCJfeqRIx+HPIJyju4e9oQK2Rk
 aKjLc554Bhyd5M51tstL2138HYCygwt0ySHF3Y3W8QYMz3o7+PvAPVcyr5gHUbIWlT
X-Received: by 2002:a05:6820:1c83:b0:6ae:875e:3958 with SMTP id
 006d021491bc7-6b042f7aa87mr294989eaf.14.1786118542105; 
 Fri, 07 Aug 2026 09:02:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2679993eaf.5.2026.08.07.09.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:02:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:01:31 -0500
Subject: [PATCH v2 4/5] power: pmic: mtk-pwrap: add mt6358 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pmic-mt6366-v2-4-d9fdef581fb1@baylibre.com>
References: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
In-Reply-To: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3227; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hYsYV678fCi20YTavMQdea/UOjR1WSrGrMClVGWGnig=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgF7Wf53A8NrlNZ6ceE8IDqR4pPjayshQ9zNr
 hRlohMozEyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYBexYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ANxYH/jGqkztCv4xC+ulyZgHakjiv0Sui1t/0fknW85C
 LwRpnukSYZd4YQRkhIxLffFhAYdeGxfpOEO1f0SC24zlTaUgi+fgrk8PTyclGWQHi2Z8srwuIww
 w2XHQEBLZqARGlstOpolqwKdn7zoIZPkbJapkBCupqmk4bB4F2Q+EURG+/hj6RkHxT6ajgP0cUq
 Pj0YF7qgF4i+I4XY+x3t29ZTnfcWQ8W34WL+EqMaRmSOIhpXlx/DfLNObcJFklyxB6p/hif/SpN
 1Q9/lS+UiOxnXRgu62diIP2jkFDBV3Qhc0WYdRcHCRosj+Z5Yh0zevxrBGrWvboBFsxBqUOGooc
 IQWQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786118542; x=1786723342;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mzScyui2wTqVdy2f3O0+s3dFnPWw1FS2MwsSLG0QF6s=;
 b=ZI2s4pBaNoxZZ8oC+pEjSYAEJt6iKCTB1DYq6yWhQoKYxYqvIuYPMu/YMpxunbsfLi
 NMi6tOFDaZWiIWzwO2CWvatoI/jL9xrWyMNHxcIc+yHG6fSVzBwvZ0+O/0NERUpQya6D
 yDEQgtgzOV7Yzv2btAduFMDWKtrgzkdsVE+XwtqtK0iPQxJ8xx31eDAlXxJ5N787as1M
 xMkhLTgPN32K/33wyo4rd6VVQF8jF9uPgp3aW6lRuGT3/HSwuPO3Bl6v5bzkD67A4XRz
 zOvd7e6M4SMfHSsvQxDuET1dwRmLxZVStjikrDNk6fHxTlm8FXg8AQ8Vph4oMcERWiav
 7w7Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZI2s4pBa
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add support for MT6358 compatible PMICs to the MediaTek PMIC wrapper
driver. This has a different register map compared to other already
supported PMICs. It will be used initially for Genio 360 EVK support.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 3320e3cfdc0..e899990465d 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -13,6 +13,7 @@
 #include <linux/bitfield.h>
 #include <linux/err.h>
 #include <power/pmic.h>
+#include <power/mt6358.h>
 #include <power/mt6357.h>
 #include <power/mt6359.h>
 #include <time.h>
@@ -29,6 +30,11 @@ static const struct pmic_child_info mt6359_pmic_children_info[] = {
 	{ }
 };
 
+static const struct pmic_child_info mt6358_pmic_children_info[] = {
+	{ .prefix = "v", .driver = MT6358_REGULATOR_DRIVER },
+	{ }
+};
+
 /* macro for wrapper status */
 #define PWRAP_GET_WACS_RDATA		GENMASK(15, 0)
 #define PWRAP_GET_WACS_FSM		GENMASK(18, 16)
@@ -175,6 +181,34 @@ static const u32 mt6359_regs[] = {
 	[PWRAP_SPISLV_KEY] =		0x044a,
 };
 
+static const u32 mt6358_regs[] = {
+	[PWRAP_SMT_CON1] =		0x0030,
+	[PWRAP_DRV_CON1] =		0x0038,
+	[PWRAP_FILTER_CON0] =		0x0040,
+	[PWRAP_GPIO_PULLEN0_CLR] =	0x0098,
+	[PWRAP_RG_SPI_CON0] =		0x0408,
+	[PWRAP_RG_SPI_RECORD0] =	0x040a,
+	[PWRAP_DEW_DIO_EN] =		0x040c,
+	[PWRAP_DEW_READ_TEST] =		0x040e,
+	[PWRAP_DEW_WRITE_TEST] =	0x0410,
+	[PWRAP_DEW_CRC_EN] =		0x0414,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x041a,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x041c,
+	[PWRAP_DEW_CIPHER_EN] =		0x041e,
+	[PWRAP_DEW_CIPHER_RDY] =	0x0420,
+	[PWRAP_DEW_CIPHER_MODE] =	0x0422,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x0424,
+	[PWRAP_RG_SPI_CON2] =		0x0432,
+	[PWRAP_RG_SPI_CON3] =		0x0434,
+	[PWRAP_RG_SPI_CON4] =		0x0436,
+	[PWRAP_RG_SPI_CON5] =		0x0438,
+	[PWRAP_RG_SPI_CON6] =		0x043a,
+	[PWRAP_RG_SPI_CON7] =		0x043c,
+	[PWRAP_RG_SPI_CON8] =		0x043e,
+	[PWRAP_RG_SPI_CON13] =		0x0448,
+	[PWRAP_SPISLV_KEY] =		0x044a,
+};
+
 enum pwrap_regs {
 	PWRAP_MUX_SEL,
 	PWRAP_WRAP_EN,
@@ -629,9 +663,15 @@ static const struct pwrap_slv_type pmic_mt6359 = {
 	.caps = 0,
 };
 
+static const struct pwrap_slv_type pmic_mt6366 = {
+	.dew_regs = mt6358_regs,
+	.caps = 0,
+};
+
 static const struct udevice_id mtk_pmic_ids[] = {
 	{ .compatible = "mediatek,mt6357", .data = (ulong)&pmic_mt6357 },
 	{ .compatible = "mediatek,mt6359", .data = (ulong)&pmic_mt6359 },
+	{ .compatible = "mediatek,mt6366", .data = (ulong)&pmic_mt6366 },
 	{ }
 };
 
@@ -770,6 +810,8 @@ static int mtk_pwrap_bind(struct udevice *dev)
 
 	if (ofnode_device_is_compatible(pmic_node, "mediatek,mt6357")) {
 		pmic_children_info = mt6357_pmic_children_info;
+	} else if (ofnode_device_is_compatible(pmic_node, "mediatek,mt6358")) {
+		pmic_children_info = mt6358_pmic_children_info;
 	} else if (ofnode_device_is_compatible(pmic_node, "mediatek,mt6359")) {
 		pmic_children_info = mt6359_pmic_children_info;
 	} else {

-- 
2.43.0

