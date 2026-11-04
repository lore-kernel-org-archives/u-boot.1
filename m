Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01A606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ySfbXu+P;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=H+DrBXkJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68B7F6080C;
	Wed,  4 Nov 2026 08:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9R2ES1DZA2T; Wed,  4 Nov 2026 08:52:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A1B9A6083D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782347;
	b=lf9ojgWNqYIp9Mo6tW19nQRXbY+K6rsC/8Hi716OF2vtdhoNN/x4ko4BdK26s7nBJWt2
	 Zq914HPCnhiikExEP0PQ9aq5M9gh0s2aggW+oxx4OIsnjT4w3KkFwDUiJN4gWT5NJM+C2
	 Z5tGfxHLXYU6dLtVAhcomMg/wYMblMD/edqE16OQDMl1yat4LneE0HFH43kTOg1bAe3NY
	 PyUBNys6LvLJ19zYli36Ja8oE14FW5yzJyTxujwYAa1+fV8WAzTsvU0CyGybQml5YI7tE
	 fOZ79h49dofFGkgap6tBQFhADS0lDpDHAHTCQJdTohzQXcQQDsLmSLSBe+kJJN8Yj6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xZ9FsyfPdZ6iGSrKPs1jC0Z7Hw52O0Ux55keqWX/NpM=;
	b=n3803DTOOTo6FsNqwV50Ud1r6yqJw1zW06ndh/m5BL4xlrmAgE3r8GK7mlF2Ull0eGrk
	 wXXSdciRvY4FAj/2A+41NszG5DT2mcbx7mANiZV6IeKt06qJR3VenIBVkDpjtERCuqMDk
	 sFXJAQDNyepozhDYJA963L6tQPOuqFEI/uf+oVfNpStezXFGfGBauNCKv76b8P2EmT/BI
	 djBwELBwRbEw39X5yJEuTRzJPy+ARfal82CMDdXYTldaDs7XTupaz61AOlLfj+BOlrvZn
	 vlvlQwfu2+yDjjBxRL6JqGGZt7WHd32WZPWmRMaUQVgSFx3SVvxOr4qZ+u+RSK/vjCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=H+DrBXkJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782347;
	bh=xZ9FsyfPdZ6iGSrKPs1jC0Z7Hw52O0Ux55keqWX/NpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ySfbXu+PtJAb9jhqT89FyJoH91oQImSErIrLDyZ2sAoDzVz15Jf6jspukKOGN7SBz
	 AI0PirIApQKCVCjV52Q0VdMZJfnjoHQzW1E/OuFA9UOSaQ8YJ8Jc5sSplgkqV9w9PF
	 /TV1DNhO7H7vMz4808eR1iE+adOoppNLqk9keLThXUqez04UhGfoVMHbs7TcsQDkyg
	 FPuzfre+rKLCMyXE88/rNtwMHHKo11qXB9H+iSDgtNW+QGcb90ZLJr8p0wmDhjtN0j
	 4g4xoplj9Xcq3zUFzlGhLORT0c3KiKniDeXxdpf9g1CO3cHqNTvJ1SRuMj3nn7fkuc
	 tmgh3VC4p4inA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1B9A6083D;
	Wed,  4 Nov 2026 08:52:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9872B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDCC360878
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c3xz81EV1Iui for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCEC660873
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782343;
 b=P6nY9v9PbMgr6lrECEw/DZkG8h9nUE9QdewcjGmcLWaBT+CigAYOyY/ztzd2uVgsUFC0
 /l83jAMs52ckvNU+vgIXQFBNDeoCJH4UcpkRy2n72F5IaQAObH/upKrRsI5OIZauATrSP
 nql1xduDr1CRMHnGCTNZAtURRmO8RbSZDdv9S4K5HDQ+F79ehlV48i0+OPTiFkK3RdQQN
 K8zbzMYULIMA6rdk5ev34NU2k9y6DMRh7QK0qGrS6r9UcTVxWxzzJ4CXBxfvT2diT7UgC
 qv872KOpj8uWpS77Qv6WmKIqezKrMg6P8xxcYvGn1b+1u77Sx2+ht7DFCNejaZYjuSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782343;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=xZ9FsyfPdZ6iGSrKPs1jC0Z7Hw52O0Ux55keqWX/NpM=;
 b=S9QZA7BpSm3MKTpZoAxsd6UByyAs5FgOjrQoBYjbqNofGNtVINWucCFndbzw8HndsZ+e
 Y9GahHOc2uHGK05OmN73MpDVgfA6ok/6aNBqSqfaobeWSSw3VZjKB70WTZKqTBtPJrgC6
 +ctpfFoFhXrDlfGyQj5+uo2eLi4flU1KeWIYMqVwqx1OzMmtcxfQ5JaqnT4psHA+6HRMQ
 0gHOYrbI8k1zHVfmzBBh6J5qu+anlJJ6uBe2HBe5gFGWwzzVaD5hidojWd2srd199rS40
 C+A33xN/veEbqoJ2zR38wLwhG+k0lpBLDikXjU5PGZC5hxS3MbPcuasLVPiPIAZB4Ag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=H+DrBXkJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=H+DrBXkJ
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCEC660873
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:22 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so2376755e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782340; x=1794387140;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xZ9FsyfPdZ6iGSrKPs1jC0Z7Hw52O0Ux55keqWX/NpM=;
 b=H+DrBXkJNvKroxMDoyCEn7C16r7EWvM7CxgRrm/ZgoTxv60VihZKYLKDVCOf1QhCfJ
 gfFRZIySoFqcsiDmGfUJgJ/OupBediDmAdYxmhrt07SeHhNCZvnm5Vm38wyFDioKJjX3
 xlMUD0TGq2uxFQILGr0N7iNDDvFol6N6iagz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782340; x=1794387140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xZ9FsyfPdZ6iGSrKPs1jC0Z7Hw52O0Ux55keqWX/NpM=;
 b=VDSSPlka1glDz6MQLN9op+hy5mZs5x2WCxFjJoqiwSNI3hsE7uVs5hYi8OfNJysbT4
 R2D17CLAlxDezHO5CvFVCsz/CQ+Y6Ii+Hg46HX0iWB5fz6QoKKcLDvd/b1lHi1uRqF/p
 Gr3mJz81mYQNmA2ni8FWy/fpftTdf2nz1c2fUAa6K9bihbxEt6q7Bwb3uny99emhu4Hg
 3BUU/hxi16yM75o7iPNAjgeNf6xJvEaLwp9Ak2OirWZc+5GwxVa1jGzQt6o8IHYkMfnp
 vmxirdcZXALTrTTJ56ECzKwFl985ijBw4KbiihaqoAMCEaDySIEjzxf9tYOHHY0yaKHu
 9WwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBycdtUf3l1Y4zTgrDf/0G5zN2a/JapvDKukezqWF9pToaKrlzBi1v1zXs1qXernaFnX9SdbdNc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z871QAWvwkJYKuK0hAg5Kv7Ha2Wzm7eGnqE/xT9CiiD0utfLBkU
 wmMDa//Vi9uffz11nDEfR9wcEb3F8oCeDxY/KNUX4Dil4P/4bkgN3cMbEzPMXo+q7yXRWVzbY1h
 Q4iiD
X-Gm-Gg: AYBFou1iQQhT20evFJuAJXyaZCStcDY1KemsFHR90TBeARY3GADmQGqba4mx+t3OScq
 IDt3Yrx4NGfAyymVHGNvqL4yVqeRJ7QnW+v94jHLYXUW+2RS1UbetupIHREuUCX1s3HEEADNweQ
 wYRI/qauAgKoGe+mCK38jySdvCUjwyiGH4U/V2HOzEf9MT/W0X0M5MfnLVyu8zqEPL0g2+3etor
 Z62zBJ/SBBy0SuFvmKrVDg0E7a5klSVNpfOrKS1Ls3L2XcHzjh7/WtIb3iW1FYIR+K7GVXm1C+2
 gn+LPuJYB93cvpb/5ZpcAOnMKssz698BMR8TXN/1EUClYoSSHDWaVKewzMaAF36aD9fkfQhC/2V
 gce5WI8NTvQfdjmDR9kZmgj01TNeQla/50PXJiim3tcP0UYxC7oMSnOXba7Kwe5DLppWgkstNU8
 S2vbvcf8di3KNO0cTGs4MwJC16dCT+o0MHd/PCsd5p69u5LkIM+s5U1+WKajY+txXbEIALPYKYQ
 kqHJphEZX6yGNkoLGhXW8zNhr62nsRtai9Sd3Nw8LAZr1fu0+ZEiEyGF7RrkmtI3Wn/GosREJwV
 2ZRXedJIO74u/IUFuqGGw1ReqirXEe76+BfB3baatEnyQY7bQULvFEQFzQchcDk9OJe6Trues7e
 DrN7Ae3oUGCS7qrJNS4Cxs/wHUd0=
X-Received: by 2002:a05:600c:818e:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4ac1932aa2amr344065665e9.34.1793782340434; 
 Wed, 04 Nov 2026 00:52:20 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:19 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 28/33] video: stm32: ltdc: select the pixel clock source on
 STM32MP25
Date: Wed,  4 Nov 2026 09:50:01 +0100
Message-ID: <20261104085036.4012238-29-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

 drivers/video/stm32/stm32_ltdc.c | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index 7bd6724bc2a7..92952b105f99 100644
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
@@ -707,6 +715,44 @@ static int stm32_ltdc_of_to_plat(struct udevice *dev)
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
@@ -717,6 +763,12 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	ulong rate;
 	int ret;
 
+	ret = stm32_ltdc_set_pixel_clock_source(dev);
+	if (ret) {
+		dev_err(dev, "pixel clock source selection error %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_enable(&plat->bclk);
 	if (ret) {
 		dev_err(dev, "bus clock enable error %d\n", ret);
-- 
2.43.0

