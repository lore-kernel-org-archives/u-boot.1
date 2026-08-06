Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B842EC56203
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 09:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 765436082B;
	Thu,  6 Aug 2026 09:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v58Dvkpi5JjK; Thu,  6 Aug 2026 09:27:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8870160811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786008449;
	bh=Rllp3jZGcVymcY4idtb3Y21K1z8TlxST37AAumiuntg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wmETO02+9AHhwU30s+3RIhQh5RzFga2u6xeTEMucanf3lmSJfTbY0Ob8VMDYPfYCZ
	 8P+E6pdv1euzlSvpsOPhiFC+ShMAZI9ls4yLI7Nk1qydmKYbwVB80mZJODwC5uEC99
	 sqgGRAqFZO80ms3lLkZAmdcsqvlLnBhm3T6OIES/jcGt8FNh+xLsEQK37BZC18uCc6
	 R9AsVkQmWo8BLwo23St0BWdCsbSpEZpBEhERxW+8sG9CgK8XgQBxdgl0ZnzY6G72I/
	 PURYF9kknOGAw1S/hhlXEctwFB4M5Va1KtF4jtwQTEpwIbrafQcLFckViiX4PAl9kl
	 HDP3g7Qrm+W8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8870160811;
	Thu,  6 Aug 2026 09:27:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25C94198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BD5580D81
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REXx5lGaWEnD for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:27:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DF0AE80D7D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF0AE80D7D
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF0AE80D7D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:20 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47362928f65so1630400f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786008439; x=1786613239;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rllp3jZGcVymcY4idtb3Y21K1z8TlxST37AAumiuntg=;
 b=GJ4s9qxjw1VzTXtOFXJRaC0Bs9FF3ffUoFaS/dJbhAWhLitS5C6VJ7KjRw1Irw0Owa
 Broi2nixBXg/RDEaTRXjHOms5ZpPgRRQBnGBaNVhE4JaTIyP0tkrdfnZmLQTVG2VxvMm
 3TGn9HRc9uWZloEgtt0WmpLmG33v7WgsY0U0F0INif33+Q1vvBFU1BsO02E1zAUwBj2N
 j7JDq2Xo36TnPNxBepdokpoE35UNTP02BgIHLrl3goyhISCLoNkbcjreiW9JCwhE4gVN
 VI8KXrbD3XIku86H3qOh4kYrKRohxggulCv4dGyvcCTOCq9yuqtsvlwwAcHcvzC62QIs
 G4Xw==
X-Gm-Message-State: AOJu0YxnxGvHVgoi0UB/OTq64p6NdTLznZfVqutIg89hpz+tRXsLa62G
 ght8yt90V4LqjvxjizcJlAEP+Kb1DaPs/0bZ8Ktcxs/XdFe8cp9dGkjkImxjwp5gwLo=
X-Gm-Gg: AR+sD10V5y7P6tp+h6yl46ezajtqDZWGGh3c3WKitADtRvKftGLdWNWFZFvAbxTtP+z
 7fxfJkpoNwTTJGHpdLKPh0kED+WQTPspiMd/tfrxQTYIdQcwVnMeGeQdPuhU3Ncpbx2wBNI3o4d
 lH3Ua4tgu/wf91FznKTGE0+Q8fKu+fBpQ5FbY4uBxIfzgADnu7DnZ59p4a37fg0RVmnmk0xt//9
 Fc5hPtrsym5ce6GEnBbyu14WNSu6Aglq3tPSMd4RpmbhgTNVaiYks01sYNTStI1UxFEbPSIDQjk
 bKY3XQwGcCfAvge06hEynQM7SK69GYioMZIHqPn70H8+GI+Q3wtNJTeVlalN2rJ4vvm5215L1sw
 0VpmGgG/0fvbGCBj2qLMqAxGxoJnvn3ao+nFZMjw222iYIhJgKwhcU4pjgM3qUYOkToSneDG+/M
 HuTs01yjnYMkzGsGCfuIoovKZzUeRlICi+0eIpSBKR2rfjOHpIvqVRXf4ia5ZBuTzPCrq3ombKM
 TfLnU0/yjQ1x0onvGFRo+C1b0mnehs7n/YNMZASl9t1axAvu+VAYKzW9nX+C9RGX1xTRpsOjN4y
 clh72IPgdVZIGTMOols8TiDZNI0g4PKTBTtkxGN4kNWi+w==
X-Received: by 2002:adf:e6cc:0:b0:47f:97e9:fe60 with SMTP id
 ffacd0b85a97d-47fec51a252mr14300956f8f.15.1786008438805; 
 Thu, 06 Aug 2026 02:27:18 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b31975sm4147248f8f.33.2026.08.06.02.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:27:18 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 11:27:12 +0200
Subject: [PATCH 6/6] video: panel: himax-hx8394: use common
 mipi_dsi_dcs_write_seq macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-6-6b533788d0ac@baylibre.com>
References: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
In-Reply-To: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Julien Stephan <jstephan@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786008439; x=1786613239;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rllp3jZGcVymcY4idtb3Y21K1z8TlxST37AAumiuntg=;
 b=bHbXnTSzVZoJ9o0a+8wLdffvplDCvd6ja5krErUVfAylyDKn5Nq21mOep6t4sc9dwn
 uLFLhahCMVlrs6lxiHrxYn6qoZOLUT3AGip+Il+hu9d26dAi/wfhbJXZKMeRHR6e8sF5
 1FEDFtt8O/OUudldPuYpbduHgvYuN2MH3NahI84E4bNWmZIgfKHaxYgFXFM1Q3ld/N2k
 AaRxmAy3ec3LuDnatRoEhtcLJ8qFccbLD/85ktApvKJprKD6rIRL0ahVgP6k8dr5KTCu
 I8c3lpBdfu/BMH52nkWW/VCWcCDuo4EVzQJ62ct7CfRTTvxJ2/kBmaGUV5Oo20hXcmG0
 P6Ww==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bHbXnTSz
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

The current driver defines dsi_dcs_write_seq as a wrapper around
mipi_dsi_dcs_write_buffer.

Now that mipi_dsi.h defines such macro, we can use the common one.

No functional changes intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/himax-hx8394.c | 86 ++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 47 deletions(-)

diff --git a/drivers/video/himax-hx8394.c b/drivers/video/himax-hx8394.c
index cb7f93e9c99..1107070bd1a 100644
--- a/drivers/video/himax-hx8394.c
+++ b/drivers/video/himax-hx8394.c
@@ -31,59 +31,51 @@ static const struct display_timing default_timing = {
 	.flags			= DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
 };
 
-#define dsi_dcs_write_seq(device, seq...) do {					\
-		static const u8 d[] = { seq };					\
-		int ret;							\
-		ret = mipi_dsi_dcs_write_buffer(device, d, ARRAY_SIZE(d));	\
-		if (ret < 0)							\
-			return ret;						\
-	} while (0)
-
 static int hx8394_init_sequence(struct udevice *dev)
 {
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
 	struct mipi_dsi_device *device = plat->device;
 	int ret;
 
-	dsi_dcs_write_seq(device, 0xb9, 0xff, 0x83, 0x94);
-	dsi_dcs_write_seq(device, 0xb1, 0x48, 0x11, 0x71, 0x09, 0x32, 0x24,
-			  0x71, 0x31, 0x55, 0x30);
-	dsi_dcs_write_seq(device, 0xba, 0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
-	dsi_dcs_write_seq(device, 0xb2, 0x00, 0x80, 0x78, 0x0c, 0x07);
-	dsi_dcs_write_seq(device, 0xb4, 0x12, 0x63, 0x12, 0x63, 0x12, 0x63,
-			  0x01, 0x0c, 0x7c, 0x55, 0x00, 0x3f, 0x12, 0x6b, 0x12,
-			  0x6b, 0x12, 0x6b, 0x01, 0x0c, 0x7c);
-	dsi_dcs_write_seq(device, 0xd3, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x1c,
-			  0x00, 0x00, 0x32, 0x10, 0x09, 0x00, 0x09, 0x32, 0x15,
-			  0xad, 0x05, 0xad, 0x32, 0x00, 0x00, 0x00, 0x00, 0x37,
-			  0x03, 0x0b, 0x0b, 0x37, 0x00, 0x00, 0x00, 0x0c, 0x40);
-	dsi_dcs_write_seq(device, 0xd5, 0x19, 0x19, 0x18, 0x18, 0x1b, 0x1b,
-			  0x1a, 0x1a, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
-			  0x07, 0x20, 0x21, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			  0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x24, 0x25, 0x18,
-			  0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			  0x18, 0x18);
-	dsi_dcs_write_seq(device, 0xd6, 0x18, 0x18, 0x19, 0x19, 0x1b, 0x1b,
-			  0x1a, 0x1a, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
-			  0x00, 0x25, 0x24, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			  0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x21, 0x20, 0x18,
-			  0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			  0x18, 0x18);
-	dsi_dcs_write_seq(device, 0xe0, 0x00, 0x04, 0x0c, 0x12, 0x14, 0x18,
-			  0x1a, 0x18, 0x31, 0x3f, 0x4d, 0x4c, 0x54, 0x65, 0x6b,
-			  0x70, 0x7f, 0x82, 0x7e, 0x8a, 0x99, 0x4a, 0x48, 0x49,
-			  0x4b, 0x4a, 0x4c, 0x4b, 0x7f, 0x00, 0x04, 0x0c, 0x11,
-			  0x13, 0x17, 0x1a, 0x18, 0x31, 0x3f, 0x4d, 0x4c, 0x54,
-			  0x65, 0x6b, 0x70, 0x7f, 0x82, 0x7e, 0x8a, 0x99, 0x4a,
-			  0x48, 0x49, 0x4b, 0x4a, 0x4c, 0x4b, 0x7f);
-	dsi_dcs_write_seq(device, 0xcc, 0x0b);
-	dsi_dcs_write_seq(device, 0xc0, 0x1f, 0x31);
-	dsi_dcs_write_seq(device, 0xb6, 0x7d, 0x7d);
-	dsi_dcs_write_seq(device, 0xd4, 0x02);
-	dsi_dcs_write_seq(device, 0xbd, 0x01);
-	dsi_dcs_write_seq(device, 0xb1, 0x00);
-	dsi_dcs_write_seq(device, 0xbd, 0x00);
-	dsi_dcs_write_seq(device, 0xc6, 0xed);
+	mipi_dsi_dcs_write_seq(device, 0xb9, 0xff, 0x83, 0x94);
+	mipi_dsi_dcs_write_seq(device, 0xb1, 0x48, 0x11, 0x71, 0x09, 0x32, 0x24,
+			       0x71, 0x31, 0x55, 0x30);
+	mipi_dsi_dcs_write_seq(device, 0xba, 0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
+	mipi_dsi_dcs_write_seq(device, 0xb2, 0x00, 0x80, 0x78, 0x0c, 0x07);
+	mipi_dsi_dcs_write_seq(device, 0xb4, 0x12, 0x63, 0x12, 0x63, 0x12, 0x63,
+			       0x01, 0x0c, 0x7c, 0x55, 0x00, 0x3f, 0x12, 0x6b, 0x12,
+			       0x6b, 0x12, 0x6b, 0x01, 0x0c, 0x7c);
+	mipi_dsi_dcs_write_seq(device, 0xd3, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x1c,
+			       0x00, 0x00, 0x32, 0x10, 0x09, 0x00, 0x09, 0x32, 0x15,
+			       0xad, 0x05, 0xad, 0x32, 0x00, 0x00, 0x00, 0x00, 0x37,
+			       0x03, 0x0b, 0x0b, 0x37, 0x00, 0x00, 0x00, 0x0c, 0x40);
+	mipi_dsi_dcs_write_seq(device, 0xd5, 0x19, 0x19, 0x18, 0x18, 0x1b, 0x1b,
+			       0x1a, 0x1a, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
+			       0x07, 0x20, 0x21, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x24, 0x25, 0x18,
+			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			       0x18, 0x18);
+	mipi_dsi_dcs_write_seq(device, 0xd6, 0x18, 0x18, 0x19, 0x19, 0x1b, 0x1b,
+			       0x1a, 0x1a, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
+			       0x00, 0x25, 0x24, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x21, 0x20, 0x18,
+			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			       0x18, 0x18);
+	mipi_dsi_dcs_write_seq(device, 0xe0, 0x00, 0x04, 0x0c, 0x12, 0x14, 0x18,
+			       0x1a, 0x18, 0x31, 0x3f, 0x4d, 0x4c, 0x54, 0x65, 0x6b,
+			       0x70, 0x7f, 0x82, 0x7e, 0x8a, 0x99, 0x4a, 0x48, 0x49,
+			       0x4b, 0x4a, 0x4c, 0x4b, 0x7f, 0x00, 0x04, 0x0c, 0x11,
+			       0x13, 0x17, 0x1a, 0x18, 0x31, 0x3f, 0x4d, 0x4c, 0x54,
+			       0x65, 0x6b, 0x70, 0x7f, 0x82, 0x7e, 0x8a, 0x99, 0x4a,
+			       0x48, 0x49, 0x4b, 0x4a, 0x4c, 0x4b, 0x7f);
+	mipi_dsi_dcs_write_seq(device, 0xcc, 0x0b);
+	mipi_dsi_dcs_write_seq(device, 0xc0, 0x1f, 0x31);
+	mipi_dsi_dcs_write_seq(device, 0xb6, 0x7d, 0x7d);
+	mipi_dsi_dcs_write_seq(device, 0xd4, 0x02);
+	mipi_dsi_dcs_write_seq(device, 0xbd, 0x01);
+	mipi_dsi_dcs_write_seq(device, 0xb1, 0x00);
+	mipi_dsi_dcs_write_seq(device, 0xbd, 0x00);
+	mipi_dsi_dcs_write_seq(device, 0xc6, 0xed);
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(device);
 	if (ret)

-- 
2.54.0

