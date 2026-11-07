Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2F606D806
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Is5yczyN;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=mwFaXEe5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14F5B81B83;
	Sat,  7 Nov 2026 14:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0TaMyUvSpTzZ; Sat,  7 Nov 2026 14:34:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0AC8C81A27
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062056;
	b=F+IdhhJyVarpiSspMSfx8mS8JckHdNiYb3FmO8LwlfaXOXWNBufRuo0zkwI6HsoLoLLk
	 h3YmkMtaVQE7wdeditoe82epxEx11/O9aWWDaqCElVnR+ThDQSBtmcdR4hK5TBNVNS94p
	 m1Ygx7mhgTqDxB6jTbBgSqsDBUAwBhDFAjqQVGPF4QGBwK38m4qpzwj/5rlSBGCZpC7gE
	 qzVnvoI0I689dGE3NGQ3UO46SkClWjZ0gs95gwJ7sdQ6WCbO2uK9a/Ju/eUS9VrWUXJ2a
	 WEyHMBG01ll1kHH/QtiaVleCkuzulW7XW+fjBj1o8ALuVs6GIpiPc2y/jrezDMEJaCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062056;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VJOsk7ubnH1CBsFM/kXPSVHvbivVyvafGIh3t0g+CqE=;
	b=jpOHL4ail3oV+DYP9Is+RMC0wC/q/KrgQbG5hJEBBLVoEGNFRGb9pOK74RnqBbjisvrd
	 CYHTPzKfsLgm3HrfjSxEvjcMSbY80HjTGoXsVix3xCpNfM9jw4b4Tl02TQ+8FJI2jb0+e
	 T36jTkucz+h+kjnUWDLvEXnqqQRQuTh7DFYzzOkYHJ4hYRiD2DSfa8LvcuLf0RD/gNxlV
	 bDbw7pOCwhdwldWUqnf9IqiWjl4bEXxNXft0EP7gxmTSAnNY1UfLW1jQQ7da13NFYfywp
	 nTOa3WpMlfPHgvLPk/wuc1gb/ewtnma09qkZ4tG5HNX2Wx9dxDpdedk1vOlKj9h2CRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=mwFaXEe5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062056;
	bh=VJOsk7ubnH1CBsFM/kXPSVHvbivVyvafGIh3t0g+CqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Is5yczyNjnDWDWe/t1gep2vkmi9w28OFvWRgpm6pwSu5FFHTK0WOyKTwDMdoPOGyX
	 Q5BkgajS4y0m+mpqZe0e7Cm4l6Y707/TfRXT77HIVc0mUK3wX0M7742bQ4q74Ws+o1
	 9pSDqc5+7LNlFfa5Gk4AaE+Y1tUgumuUwwUmAS4gncaHBHEw1eLG3L3ypkQKnC87xq
	 Xb2DBPZTQ4VgfXtfPeNwVwFZYwaIoXhCv4NNg942fXxZVC8LH/yvuyeAHJetNZbaug
	 EiqF3aeuOeGh6CSFIRuStIkg93PW/jZm1G58fTrkEMsGbbugLGAlogsvcV1GOf+tPL
	 cO28ye+3LFBQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AC8C81A27;
	Sat,  7 Nov 2026 14:34:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 406FB4B8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 262E081764
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hh261p85o9pi for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B0B8816F6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=mwFaXEe5
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B0B8816F6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:45 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso866207f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062024; x=1794666824;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VJOsk7ubnH1CBsFM/kXPSVHvbivVyvafGIh3t0g+CqE=;
 b=mwFaXEe5Bhroh2YxaidD40J2i/H2RPIakFOWPG81I27DOWe0FNAx1ifjsD677inSxb
 F8QsAWdQsZg+Eg4cAoKdYX0EpIdt8tv/5I7t0biqDLcjDyERaM0aV2Q4a1qKoOdmXK8P
 cJ5EONhWsWrYXn6HLsAKTA8IjUWmc+7CRI89Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062024; x=1794666824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJOsk7ubnH1CBsFM/kXPSVHvbivVyvafGIh3t0g+CqE=;
 b=1UmOXomg9+5LhtS4idoLofpFE7TAI/7NEJSBvnxUojmHgyDGVSaw/pbraYvObfYCc2
 LGkOS+yYyTpkISKtsQv0LkuvDhaaTG/J0P9c2IYTyWM+RYe4ybcYyddl6yjLa/VSjLZC
 34gqPzWQ4z/HTuv0bsR+PL2V3yFs6KCwC9es8IMN/9D/YDPBGHNDJRIQGt+vAewCz2lH
 8+8+PTec2C3gh5rmZ5l4iHuVl3noPtP2EAHKNV0mFiXYPKhSjSRh70Y3bFF1A0d5aCOH
 NtOiMyzNNICQGb+5Zo69hoVmee0nOa/DKQLKadYF0Ji26/vcUPA5rUSa9ylvPjYE9ejY
 BRUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFd/Dn98ux7TLo9Hf2LYv3Byw1ClCawb39I2YRSGEqTn9KhDmN05rXIIVn3Uu3SU8FIOAXbQvg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8VVTKmw9SBPoqgxZWYupoUvHCaXFis7hK75eSKyA3ZIY7G/CHx
 mGzs6FZqsw2IvUXw9PtJzX2E5ugfta5/C9BlSxhI3ndiLp4c7rDfx38RypawLNeIWHY=
X-Gm-Gg: AYBFou0bInvc4Qw5H/EqC/fgCC43yx80gS+JYB7GlHsMF8FHX7bYXgUetVHaCvtBoVy
 Ka6A+J2KGH5XGh0E3xwHzbf8pEAklGXloV1ZJBEk2X4p1qpcjsx/JTfqmWnHXDLP53Zulvt/N72
 WZ171aYPM+ynBoUIZXqyRMwXAfCajWHRa6ab3r7vcrlOvTiNsRUfvtOYNz9T7zYpaN/8bMLVLo+
 lgM28jLyh7s1GblVKxmki1Ibk8it/5mg2o+QxdxeNYkNwv34jrWHxasN0xF9UWTrJSvHmlMw/SQ
 lKuVpDw9ZwEboIV0gJvUMtE/Mx6tGVW6MtJ1McGdLZaurNowlj/gh+vCS0SrB7tGjDpUvIccka4
 mo/Nlm/p2tSQrYodoBkmsYwaEueHQmKWfJKM8m2+FyQMzemzOuf1bkcA17dOJCKQbvKQ9rvW+2y
 JlUNw5FGofv/ZnOXhLiEzVgrtG4B5ZrtIYeu2+XTpefiuPy8hKIaSZ09Z7sA81S3scwYROuGaFt
 EYTbwCihqzTPnk5/iXKxwBtAh3pCXS+XcI+csHCYzVpjj3ORIAE+yRMixPdsxH7wyFjIPYGJ1tF
 wt4mgt61aGgw+FvpvJcT1MWofwgX2CFOXQrU1iw9tcZmcY2m0W2NcDT0kFFyPVc+gFf5ZtG8wVB
 KDgQcZ96KKlqBXBwTyfmoDyM0NP4zVu2cQ/f1ZLssT5M5LV7v6KbQsAVfiuCCVQnerOcMzQsH5y
 vRrgl4CHCjJb5c4U1g6YK3JxIjnA==
X-Received: by 2002:a05:6000:2583:b0:490:76de:c78b with SMTP id
 ffacd0b85a97d-492778d0a14mr12285319f8f.34.1794062023915; 
 Sat, 07 Nov 2026 06:33:43 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:42 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 29/35] video: stm32: ltdc: select the pixel clock source on
 STM32MP25
Date: Sat,  7 Nov 2026 15:32:19 +0100
Message-ID: <20261107143241.2236511-30-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

 drivers/video/stm32/stm32_ltdc.c | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index da580a78a5db..997042233171 100644
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
@@ -719,6 +765,12 @@ static int stm32_ltdc_probe(struct udevice *dev)
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

