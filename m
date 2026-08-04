Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBE5C561E6
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 22:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B7516076C;
	Tue,  4 Aug 2026 22:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pO5_wTkth6mv; Tue,  4 Aug 2026 22:33:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AA466078B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785882788;
	bh=T0u7vwLQHwYB1iBiaEReRHFvL9HgKfdOEH9cCouBB/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HUN8t5lvSwd6R2qCwedIprolZy+80bYNX7jF2jSdlh0f7qD4t7ZxkgkaetO3ZIcdh
	 hJYEhfDqfmNeIxdyqqw1D57oFbXbVCUChS4OZwTTwBIEhOMa+pLHM3dec7Ngqdhcql
	 Q0bQxKoQlJuPoV5owEh8+XdSUvNNVPznVseG4Zkxf7JFHDEntzuuWid+l0reDf3TdV
	 aLE5mz7/ouOJGD0p/pzaeXNs8DvQvuYxrH9G1MoVfMsYBqgbd5cWLasWB//gDCTTjw
	 CTakYe7qQscchh/0/VIDDmnFX5YOtpKs+4RR2wiNytm458TPT1KjEJI4FQgHfUiWDm
	 KKLVma/I6UFOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AA466078B;
	Tue,  4 Aug 2026 22:33:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7B742B6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B942980AEC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ddwS1eFFgEh6 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 22:33:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 017ED80AA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 017ED80AA6
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 017ED80AA6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:03 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a168dc590cso275666eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 15:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785882783; x=1786487583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T0u7vwLQHwYB1iBiaEReRHFvL9HgKfdOEH9cCouBB/M=;
 b=QbQdSR0E1j4yOEhyiCjw4fo+HztzJssYeRnEt7yv7VN5LmNakpBZSmSjvkwqWYHMNs
 k25vhy20ZZrcRoEGiutRCnAm9ZwR1DIRuKpjRClWowGYGiUFfknSaAruRlgiyl3JPLNH
 4p65gYV0/VD8RsXpOCZ4zt3ZJGkoNCU2Tna1gXU5LEQxW+3K2RaukrhbR0lWoBio0r5w
 H91zXMeO/7Sc0anrTMc1Nq5DOeZ7Hsqnq3Od7X5F0lTbc50h9WKQcga2BrZQUT0fHB2r
 kij8Wwz5W/LKzckdTR6298nXW4cqwEVk5vKXhap9SSGEr+xO8e0UhGYYv57VWyut1dtD
 zqAg==
X-Gm-Message-State: AOJu0YyLVtRPhiYG39dEmIKSSSdF/1XliYOLdRqZApk58uhHAbn25qIk
 NvT6NmTpnxCQlTJk33jyPP8EdCmfsSI0i9hqQBHazCDjoiAcJJwQs3dWGR9aFAlodFs=
X-Gm-Gg: AR+sD118TT2mmV+Aq5hyCYQqm6hVxJEbpuWa3DWQJRIVsDnQ/WU9L3IfMSXk7uJJVL/
 bKZBcuP4d3Yk3zS4KKHbkIsJ5b+RKvZfUlUOxRC5oDaaha3uSW4ChvzRUTtPBINy4FXEOhRw9Ou
 ULg3tzj3wO1QA1hwJdWFLbVfrXZHKH2BUB/0No9ddWpwjj6Mo7pIUNkANrERMD1x0/whLsBf8i+
 +MZR9U2tcUmDk7yqd0AMK8cewJJNdAXjyXp+2C8b6G35YkY7tVosVivF3zrA6FQWRVtvPc0TvPd
 rF77bI2EsrVFaUd1jzwdkLvMqRvfCXxWR3Cc2XHZ0wjQ7IpBDmDU/vcPrcGEOjgPpfD7RFTRlmU
 bDY/EgMt5DEHtSmfU5WmHfq5tiDc12lCo2JNFi4Ed6lHvOS5A7aqnlfjap2s0xPNJLxGH99ZOXQ
 XITRAvNd8fxbvKEhRZIkqUJEtNtoGZKwjDO/6rRUJJ3Mj2RLsCZeCkS36hKKm56yzRXw==
X-Received: by 2002:a05:6820:c87:b0:69e:3d6d:375b with SMTP id
 006d021491bc7-6ae96f95532mr1351088eaf.27.1785882782860; 
 Tue, 04 Aug 2026 15:33:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a444:841f:6b21:eaf5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae93d524d3sm1016111eaf.6.2026.08.04.15.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 15:33:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 04 Aug 2026 17:32:03 -0500
Subject: [PATCH 3/7] power: pmic: mtk-pwrap: use mt8195 fallback for mt8188/9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-mtk-pmic-mt6366-v1-3-f3b36b8a1a47@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2656; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=CnpBDam4tdlUGw2E/K6ai56yvjzL6cklk78IC81zDC0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcmh45HixHJ0DaeIu4mQ3YjTTvPbT9p1umRfZk
 IAcb/EbS32JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanJoeBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnYsIAJ6dvtdx+vGCmnIv4H2PebOJJXq2tPJrVc6P2d0
 zLk0a29l4Be8UZuSsuM49GJ+JXt1VZrY23GDoUPxkCzFJ6QwJ6M5YQBRiucrJJt1JiM+IatuA66
 oFC4+JaAIFEED8nXNxC9nEgPHgZddhlQ+YoEF4h2ZhvqJIpkvTSflMdpzxEoI7ItSmf/rP7G6Yx
 AUgfWa5YqTrAWWQwNefBMQwnh0j8wedPVzVJbIG6aZb4/BIKIp9AwQ76VKbELUwOUZOeuVg/Ehv
 P8aVkxdMxFBleav4ubEXtII4PZnpTBJr7/TWM9+Le6raiwvwxuo9If3zehqGDBNdrHvxKqkZxrw
 RoGc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785882783; x=1786487583;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T0u7vwLQHwYB1iBiaEReRHFvL9HgKfdOEH9cCouBB/M=;
 b=Wo0MOgqM5G5ZcGKjws4ILU46E/YivOEB4LBHO5fq4SSYZc+Oaxzfql2up5mYyYCkBK
 LwaS7r4k9F2AmW8l4SB9SUtTpMw35X+cl2ymGSzKWOb8JcUnJLOLubZxA2fnliO77t9U
 +NvCeXXiID7+puO2DpQsmBzs9jSzJQyHNZIwsX3oK4UFJiQKwJBuUMhbf9W0GmH8hDqt
 Oc/MlHpcTVmFZxAcTfQRxKTMwVKIfk3iDpe/WAcppdhtEhyCcOupWKqvK8bg37Yg9ijQ
 Y7toNndWQ6aC5YzxJ45YFM/ZWcaAHfqEkI2rqFbZBe7WjZp86s2MRmQPmUzDdLqbYWE4
 7GoQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Wo0MOgqM
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

Remove the duplicated info for mt8188 and mt8189 platforms in the
MediaTek PMIC wrapper driver. These both have a devicetree fallback
to mt8195. There are no differences relevant to U-Boot, so we can
avoid the duplication.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 46 ------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index f648a784019..3320e3cfdc0 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -250,34 +250,6 @@ enum pwrap_regs {
 	PWRAP_WDT_SRC_EN_1,
 };
 
-static int mt8188_regs[] = {
-	[PWRAP_INIT_DONE2] =		0x0,
-	[PWRAP_STAUPD_CTRL] =		0x4C,
-	[PWRAP_TIMER_EN] =		0x3E4,
-	[PWRAP_INT_EN] =		0x420,
-	[PWRAP_INT_FLG] =		0x428,
-	[PWRAP_INT_CLR] =		0x42C,
-	[PWRAP_INT1_EN] =		0x450,
-	[PWRAP_INT1_FLG] =		0x458,
-	[PWRAP_INT1_CLR] =		0x45C,
-	[PWRAP_WACS2_CMD] =		0x880,
-	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
-	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
-	[PWRAP_WACS2_VLDCLR] =		0x8A4,
-	[PWRAP_WACS2_RDATA] =		0x8A8,
-};
-
-static int mt8189_regs[] = {
-	[PWRAP_INIT_DONE2] =		0x0,
-	[PWRAP_TIMER_EN] =		0x3E4,
-	[PWRAP_INT_EN] =		0x450,
-	[PWRAP_WACS2_CMD] =		0x880,
-	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
-	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
-	[PWRAP_WACS2_VLDCLR] =		0x8A4,
-	[PWRAP_WACS2_RDATA] =		0x8A8,
-};
-
 static int mt8195_regs[] = {
 	[PWRAP_INIT_DONE2] =		0x0,
 	[PWRAP_STAUPD_CTRL] =		0x4C,
@@ -849,22 +821,6 @@ static struct dm_pmic_ops mtk_pwrap_ops = {
 	.write = mtk_pwrap_write,
 };
 
-static struct pmic_wrapper_type pwrap_mt8188 = {
-	.regs = mt8188_regs,
-	.arb_en_all = 0x777f,
-	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
-	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.caps = PWRAP_CAP_ARB,
-};
-
-static struct pmic_wrapper_type pwrap_mt8189 = {
-	.regs = mt8189_regs,
-	.arb_en_all = 0x777f,
-	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
-	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.caps = PWRAP_CAP_ARB,
-};
-
 static const struct pmic_wrapper_type pwrap_mt8195 = {
 	.regs = mt8195_regs,
 	.arb_en_all = 0x777f, /* NEED CONFIRM */
@@ -882,8 +838,6 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 };
 
 static const struct udevice_id mtk_pwrap_ids[] = {
-	{ .compatible = "mediatek,mt8188-pwrap", .data = (ulong)&pwrap_mt8188 },
-	{ .compatible = "mediatek,mt8189-pwrap", .data = (ulong)&pwrap_mt8189 },
 	{ .compatible = "mediatek,mt8195-pwrap", .data = (ulong)&pwrap_mt8195 },
 	{ .compatible = "mediatek,mt8365-pwrap", .data = (ulong)&pwrap_mt8365 },
 	{ }

-- 
2.43.0

