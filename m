Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F54AC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 22:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B1CA4078F;
	Tue,  4 Aug 2026 22:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id raajcN26BePj; Tue,  4 Aug 2026 22:33:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E77A140741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785882790;
	bh=Mv+oKJ+2EQ+XJ/DzrX3ZF7vRTEIVDS9fogqkhC/KSH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kYWOkQ31N8vbv9ae+TcjISj8/e8Sslvaau/mZw2dZcv0wyw7U6nel6ltllgBvPqwT
	 OoWw3f5TogjxqGD0dniqbj8XhqxqFl9xx6OwaE23+9+R7GKQ3RIhT3muHuBcxXlycd
	 nANqlbK2GOzNyF3/+e7LRBkzGa2DMc8xz85XrtKtAiVPbd4ghu4frX8zJA7my0hHQj
	 lOUe2XN65twSITM1vrMDVcQRSoUqy19lfvt6l8wmSPQ6IJSOO8bk4zvaPMpns6ie3M
	 3Pm9pqVOeGv13XSb0nNg2lNJz7PMiGLLwhr9QtnEpibqk24rjlgOrDG88YRh17v/z1
	 TGOpVWSKun+0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E77A140741;
	Tue,  4 Aug 2026 22:33:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 34BC0296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26C0C80AEC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpMUgzKcBZKL for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 22:33:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 495F480AA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 495F480AA6
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 495F480AA6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:05 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so347945a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 15:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785882785; x=1786487585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mv+oKJ+2EQ+XJ/DzrX3ZF7vRTEIVDS9fogqkhC/KSH8=;
 b=sBw0k1FUbb6ii32T3tQJYlF0iR+xGxR3iww8faUvKlNnfB8XBX08dwjfzaU6B2iFdO
 5aBeOdfz9bxiUD7BqnVQ4jqAZSqg9BFw+C0wK6NWEQLpgdCZDEBh+vQZIByTixnno/oc
 UwVv3h3CHuFCpcwLMj1vLeRaJ8O5W6eU+SjREqMYWHn3LWucwzsgMLbRQQyk1MgBG5Ub
 38GBRckLcIPQfbH12yg1Zxt95O6MPazmUutywxfL6vJaIvm2PTju2/gS1r/2mJhk/htd
 u2Al57r/Fbgiid04a5ZI6EhVX5/cn56PV8TCshquXnRLZc61Rj7WRM0Tgj0pbU6SXVvE
 yVaw==
X-Gm-Message-State: AOJu0YwnHENKY9wkYOsUdruZSo082aTf1HMa74frHBtPDC5qTK+orNOh
 zQo4bQYfSvkaa6WE490hqLoGO1dMhEoaTvpKlfwfQAxCTBnaNJoCyrfwBgCX7fYd9kM=
X-Gm-Gg: AR+sD13d8vhcU5altOUSdxooAr6hkKkclxG2HbubGiX2gqMUxK7a/FbOdXeHeabFjws
 3rkTXlnB1Yjn/HNgo9mtT0lYY+kLn23RkJ7a1R7eq720rPCCGWppIvNud7RbUEk7GtIw60k6Wmf
 eBOEglQcW8n2npEgkGWpVDn4Ha7OmUD17/SDl5BigzGSKfkSlps+/M87cLtNrFFQcXTaAmSAyBq
 dmkC6NTe25EJVhKRwmmmgCX03nQuNOUo7sgoKIhxkQTAcZrN0oHNI0PBoSc/1A83oC5OoF6a5Gu
 26d1CGLh0/UxwLyVmZXsorEKP4xeZqe4nhwK70z/AeMZJBovTEBhBllzRLwf7vAAWBFE661PufO
 NxAJC/88vR3qJ44stMczpxiq/DPIyKUowagP7nvqkUorC6ZKZb0ydXgVdCHncRLIX01cK39h4qS
 DeMYXX0YZwRs/V3H6QajAplgOc0NcUTtk2KN868hOHqkRyKOA/ulfDG0pduQx3LLODug==
X-Received: by 2002:a05:6820:1a05:b0:6ae:774d:45ab with SMTP id
 006d021491bc7-6ae96f87a73mr1425832eaf.27.1785882784957; 
 Tue, 04 Aug 2026 15:33:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a444:841f:6b21:eaf5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae93d524d3sm1016111eaf.6.2026.08.04.15.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 15:33:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 04 Aug 2026 17:32:04 -0500
Subject: [PATCH 4/7] power: pmic: mtk-pwrap: add mt6358 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-mtk-pmic-mt6366-v1-4-f3b36b8a1a47@baylibre.com>
References: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
In-Reply-To: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
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
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3174; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=kPharr9Lm2NIy0OvAjNKPQH5KB79ThQNJ2HihsN7CyA=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGpyaH+hHSHsjbUFXZ4AV4gn2VGtA7AVdhljlZdMTK03rheNZ
 IkBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqcmh/FhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8BRPwgAlSgPRcEbJ4rAEElH18CX4/RphoahW8pjxfuiq54sm+eTTPC
 WI9L1rR0O78Ee0GoHjGWSJuXfJkeRhchiEsAnZz3YkyhdJa8rwk1DnAEobvgFeSnpbUTF3J7GAa
 R4D24Xu0fFju0k1ugdilZKgtI67tNq++RgsCzmO9ASG2aKnkJkTIS8nbYVeUVcwAf0pDqJZama0
 +FvDGi8UTunllYetqnAnZdPCnY+fGzOZOQ728aFRT8fiOlT2nxgITUMWOFvykkBmft/VG43OwGb
 b8bO96asW6AI7x6mGartu0ShAvQ7Q6Qpd7QqyCZkXcauWMPFufEKOL2RmIj0sb+tWAXJIg==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785882785; x=1786487585;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mv+oKJ+2EQ+XJ/DzrX3ZF7vRTEIVDS9fogqkhC/KSH8=;
 b=M+yW2iu3KTdYDSjpce9HrlkL+c7t/Y2lh6cu5XG1hwvqpxq3JnsRBVnkgM5W/3favn
 IZWE/nBi23RCYt7osuecdAA06yYCpr8sj3CHM8p7eoORrvd3o3dErIBZzsJ6+vOcqEqK
 zUw/mAZdtA4V1JgWPj/Ipvmw6eQ5owKLotygII4xN/S8t+GsFnw/LhvClBhTznOIwWoA
 aPhnEr48kCTRb9s9TdRfqdYW6TUOnBCGRojdSI6/6G7yKMuDw0zrN30y9qIGiSxW7g06
 hPng3tLkYSkQsl/SZTGtbj+piwIFtTJ7NYRpWsZLi27Ne0Ust79Iqpwtpn2wkBi/E4Zm
 gWaA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M+yW2iu3
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

