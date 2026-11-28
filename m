Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1E606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jz2A4ayd;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=P2uB777F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5527D60623;
	Sat, 28 Nov 2026 13:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g1IOy15-1PvO; Sat, 28 Nov 2026 13:12:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 972926064A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871549;
	b=L9MGX7V2pAjgowumcuiQ+P7dQBgT4Bfk8LBROgWx1UkyjzBmEpM7SG8R0cyfkv5gviki
	 gJA1JYZcvVDgR0IH/4FjnzlexVwBKKZE9UMcg+rq3KEQGC1B1SH3OWjjAQD8pHW+XzqmC
	 aBiH8q8AjLBj7F0WbbuVqzpwnh4Fa9zPUtC+Vfc7/s6CpvQdsrw+STcnO/J/ezxSFFB2S
	 i/EsyfkvCZNmTpUTTa6SZURJfXanOgTysoKqJqBtYkqx3RzwItvNnmtCXHHRJjlXn/tIP
	 b7jTSzu4fA2sW22+AYRytjZTrn+JVpPAgkrXotfEKs829zaNsx/YDWSf4+ivBaEM0NQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GAW0NRolBh3yUamszvjDh9X36PpjtFD++BtDyUBsyLA=;
	b=WVqfOB3lIWeJ2zh/qUrmbgTiYoqMhT9+KFYqG0FpFYXRjYVRJEBAp7V5UBiy7xEt/6VC
	 AFu1t8Y5Oby0xs1ep+CdaNCQIFzxpwMbdSqrj54wuI1xnxFgp8rTQ+lVpJBHLw24uLNNh
	 t+EcB52Y3gzL8FU+/smna6b7qfd/dn1xh92j2xK2vzzQGjOliEIycJ0L2CHEMHVDC/Kot
	 auWXiJwbCWM0hQLIRiAORe6J84XlGP2OZ1+z/W3m9lkNJX2/POEshZlIgb/OkJH03jsuh
	 7GusWfeOCx0Z84EHNTJ6tM5zwHVZxCKlUfbsXS0+tHwq3dtO4SSKaiAMYyCnFFpixeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871549;
	bh=GAW0NRolBh3yUamszvjDh9X36PpjtFD++BtDyUBsyLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jz2A4aydlhARXRXUuKjGX7vlU6axFGiNeJdJaWqqpCqzmZQRCaCekv4MUQo6PJEXE
	 o2RalAOuQGze4dXTKtRb2SCBsd0aJODDRK+vpOy8IDBJ4luQlQQwl0DfGkmUA3cjZg
	 qr77fjy80DS/SHo73bwS0gm0pSGwW4BiCIRwF4rFECTwJ0LRh/9nnJlvHhC2oPFEBg
	 i3ZFDvxC8rpzs/+52uoMGZct33o/+ugjFm8r/OL+gfns40HTlMpGvzv7fQThBDp5e5
	 /RegMSpHFRQwQB7KhV1jwwRsxqCf+4wSkrZC5abxeHvipz9e4hLHk2GU6Y/uRujo/f
	 QMs5WSsufG1fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 972926064A;
	Sat, 28 Nov 2026 13:12:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E7F43D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FD6880E3D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BPSQY3_ldtsY for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4924181110
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=P2uB777F
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4924181110
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:08 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so80834855e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871526; x=1796476326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GAW0NRolBh3yUamszvjDh9X36PpjtFD++BtDyUBsyLA=;
 b=P2uB777F6elhUdPs9vHlNCsYfm8jIMFSwC4QLMWjraqdIINSPRrmsAG9t4lwFCh7N5
 GvrXdW/RfWLmwO2t23WFF1FAq0Hi5OO/EUQOJKlXhYNe2nVE/u1Xo7Ijl5QWh45CKWHx
 8fN8exnm1ahugmkpG3hGNyaolLdiJFfL66NuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871526; x=1796476326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GAW0NRolBh3yUamszvjDh9X36PpjtFD++BtDyUBsyLA=;
 b=tQf+AVRIUtv5/kByjeICfPSI1RXjinUrvpHpmL1vH4Mu2UqP6iTCWYxwkSPTcqcLbh
 NPZe1D7Cwz7tsBGhktP6sLYvRohdFhJs3PpZ2TukBqzgcy51fdgUBDeWtIbeTpI2Qju5
 URrCgOZv5wqa3XhigwL5VxY9cKRMFDGMP4uRy2H1hY8TMvOK3HajB3pXaHlSWprjtX7P
 PVyG2V4XDOXy0raft6lVzGSM5eV7oBGPUh+MCs0v10D4LqNXrSXX22LLq6FyUeVAuyxV
 6O1Uq8ywHTbf5tebbms4AUhoDNC05zyBBXwfefrRfgR9J4p3syTNFMdnET7OJA8ZoyjG
 ObuA==
X-Forwarded-Encrypted: i=1;
 AL+hErFk7nSjAQ3GPWbsQsf2rWzntobqiK46WeV9xIMBISFLjSGyCM6CRSkQXubz3BhudIbgHkxJn9Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z859hhPsN7a76e9Ly4J88ZTBHtqDDRVt3M+NOTL5vncCDHt/0yu
 cgxsRyL+HOH0DenbzlYKvlJWusJyxSv8exClGg/zio3Q0/L3JNw+/PJHBzX8opxrvbs=
X-Gm-Gg: AZFdTZd4Wpam6gXH0A7MgmkwsyBkD2fly+bXbEJj1egYDOe8wi9iSeidxUgvpYQDotc
 /tFizEJ+Mn5ZQezzBwGs9r1vSBd5C2T1HRP9aH1gsbCFN9+1wPyobMJ8ARdIadjgl0yAWigCl1H
 NtxhlFXHirseXawrt3M2cB/dugrYg+uBEbY1sc/Y1LfGaIeW3HSsWK+0Ry+gvLK07cge0p7wlAQ
 1fzGaFB79o7UsH0HxvdCiPKHu09CMQc7sPsf5uAtdFjmfDw9F71kjJIpgB5UELyIs6zytb6Jm15
 fwmVqRqJgoWOBrZP+JH1956+tovKI+fGqfLMPYFjlSGdpQfmv/wki1zU9JFht+X8lnYSs/Qilzl
 k8VmToFqx2oBEVJoB8VuZWPRoSO7Sm8QZbTNXS8WYcX1LSFzzHfixjGJmH7NJwl3/UH/GYA0m3v
 xE/nEvgR3xhwTQ6596MLUbp/KLiW2SHuJvzywENFtRaBQ306FuhuKucB3xgEqet7eRigI05n4ml
 oPAJiD8Ps29TJ5tauy0+FY91ywJ2xOfS7t5Im9hFIdUxTxqNQJHUDGYSS3onBPYLYcwyiL9kOPU
 +LGN4fFeoBPTaw7RA/7Mroibg9FedmDN3v8GubzsHYyrkHtzJA9lD/SO+lzUD69J2X3jinPhojm
 6TGhKJOWEiB4s/0XojGsj0wCyC/wzplZhQrhAg9NutpYMwe22qMC1QIEURxy8W04dBT5O9O1gLd
 xGfOYpB3c27D3QK+GCnnCHmOZM/5k=
X-Received: by 2002:a05:600c:c086:b0:4bb:a5e1:8288 with SMTP id
 5b1f17b1804b1-4bba5e1b76amr187293655e9.6.1795871526309; 
 Sat, 28 Nov 2026 05:12:06 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:05 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 23/29] video: stm32: ltdc: select the pixel clock source on
 STM32MP25
Date: Sat, 28 Nov 2026 14:10:40 +0100
Message-ID: <20261128131125.2141352-24-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On STM32MP25 the LTDC pixel clock is selected by the SYSCFG DISPLAYCLKCR
mux, referenced by the "ref" clock of the LTDC, whose reset value is the
LVDS PHY clock. As nothing programs it, a panel connected directly to
the LTDC gets no pixel clock.

Select the LTDC kernel clock when a panel is connected directly to the
LTDC, and the LVDS PHY clock when the LTDC feeds the LVDS bridge.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Select the pixel clock source only on st,stm32mp255-ltdc

 drivers/video/stm32/stm32_ltdc.c | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index da580a78a5db..c6e1b519fec5 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -12,7 +12,9 @@
 #include <dm.h>
 #include <log.h>
 #include <panel.h>
+#include <regmap.h>
 #include <reset.h>
+#include <syscon.h>
 #include <video.h>
 #include <video_bridge.h>
 #include <asm/io.h>
@@ -275,6 +277,12 @@ static const u32 layer_regs_a2[] = {
 #define HWVER_40100 0x040100
 #define HWVER_40101 0x040101
 
+/* STM32MP25 SYSCFG pixel clock mux, described by the "ref" clock */
+#define SYSCFG_DISPLAYCLKCR		0x5000
+#define DISPLAYCLKCR_DPIVSLVDS		GENMASK(1, 0)
+#define DISPLAYCLKCR_LVDS		1
+#define DISPLAYCLKCR_DPI		2
+
 enum stm32_ltdc_pix_fmt {
 	PF_ARGB8888 = 0,	/* ARGB [32 bits] */
 	PF_ABGR8888,		/* ABGR [32 bits] */
@@ -709,6 +717,44 @@ static int stm32_ltdc_of_to_plat(struct udevice *dev)
 	return ret;
 }
 
+/*
+ * On STM32MP25 the LTDC pixel clock is selected in SYSCFG_DISPLAYCLKCR
+ * among the DSI byte lane clock, the LVDS PHY pixel clock (reset value)
+ * and the LTDC kernel clock, which is used with the RGB output. Select
+ * it according to the device connected to the LTDC.
+ */
+static int stm32_ltdc_set_pixel_clock_source(struct udevice *dev)
+{
+	struct stm32_ltdc_plat *plat = dev_get_plat(dev);
+	struct ofnode_phandle_args args;
+	struct regmap *regmap;
+	int index, ret;
+	u32 src;
+
+	index = dev_read_stringlist_search(dev, "clock-names", "ref");
+	if (index < 0)
+		return 0;
+
+	if (!plat->bridge)
+		src = DISPLAYCLKCR_DPI;
+	else if (device_is_compatible(plat->bridge, "st,stm32mp25-lvds"))
+		src = DISPLAYCLKCR_LVDS;
+	else
+		return 0;
+
+	ret = dev_read_phandle_with_args(dev, "clocks", "#clock-cells", 0,
+					 index, &args);
+	if (ret)
+		return ret;
+
+	regmap = syscon_node_to_regmap(args.node);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return regmap_update_bits(regmap, SYSCFG_DISPLAYCLKCR,
+				  DISPLAYCLKCR_DPIVSLVDS, src);
+}
+
 static int stm32_ltdc_probe(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
@@ -719,6 +765,15 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	ulong rate;
 	int ret;
 
+	if (device_is_compatible(dev, "st,stm32mp255-ltdc")) {
+		ret = stm32_ltdc_set_pixel_clock_source(dev);
+		if (ret) {
+			dev_err(dev, "pixel clock source selection error %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	ret = clk_enable(&plat->bclk);
 	if (ret) {
 		dev_err(dev, "bus clock enable error %d\n", ret);
-- 
2.43.0

