Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0162EC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 09:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2BEC4053C;
	Thu,  6 Aug 2026 09:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l0WP51sx6oww; Thu,  6 Aug 2026 09:27:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A27FD40542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786008442;
	bh=3hrVlvQ3qMFvKVzHPmG6zqerbPAERLhjJqbIoKiayhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PItf8B/U3KnYXVi7xihF9Rzky3AOrnr9EQTASxbCxN08fc2QzU3fh5npUhwqjbzlY
	 VQFcY57qm95fylr9VXHxublCeWHSDt96Kttg6SxXN7nBjsQP0A6MX1qjQPilmiZKUE
	 Y6+NoBYHUYrYC10p+UgJHCh2XxYxQYe/J9TJRZAr9P8a9D9uCoIv136j0KUDeaYySF
	 zQmk920qQxb5ZD5SqQK2Hl3Nklp2PbOKQ0BWZFSc2EHnaWvIHGT3COnKVqveApWKpj
	 t+6UxV0IkdVVXwWgDiyeH4AL8vhl1rRfg9AFKl3OkZmGSbGBbrje8L9vCPFFwa9LRO
	 Kbp+SbbUseQbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A27FD40542;
	Thu,  6 Aug 2026 09:27:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 178C3282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 095F1404EE
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UYJ4ywq1wcIO for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:27:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CF9F4404DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF9F4404DE
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF9F4404DE
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:17 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so1190369f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786008435; x=1786613235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3hrVlvQ3qMFvKVzHPmG6zqerbPAERLhjJqbIoKiayhQ=;
 b=rHbx/RqEGok+UKQzDwnEQnT0EuwELD09KFqTSoUxD9qvMCSq8Rc5UHSsL+MnvLAw4g
 7edG7drTySBaiWfcTBkv2jzyPu0Ukio7eAJr5nq4HCB6PMq9OlUKFoEFMRVSYosisx2y
 BL84N/VATV8ZaVkWODtPtccu8dvs1nUpJCvJtX7kgOYVaBAaHdF4xXlVbFn1nEapdwHi
 /d754JJx7k2qhwsq+1QtWNUrXgxx86IMiINwxQ8SGllnn52JqfTw1NOY7wuY5f7HGnW0
 OkCGuInHdl4Q0Y+tC2GAUoPIwqCJ1jThAjpqQOTQbNnirBIowNCEw67HwRoM2brya+Tw
 qo4g==
X-Gm-Message-State: AOJu0Yxryb0PWYDtuL9wEZs6bI7cY55e1wYz+7co1b1udMfZpXtch82n
 r1rv/qTE9Q+H3HQKIbXxXTfEtYgDTIQ6yqUzPSpCiu4UCBqM1QE2ZM8Es1nUO1hZnQw=
X-Gm-Gg: AR+sD135UwfCVImrzTIRHeExOg3xoEByHyxg6wVkktZ7uZuCs//rHfOT9E1zPEZrTP9
 DtYgTSwtVvWRqnLoHsHhQQfX9/HQD38ugvetzsmkkJY7Zd6Jlreca7I6G8++2U+Ei7bfq027cPj
 mP0NE74Cg6BMFnQb7P9prA5BSbuLOTthB0lmNH6hiITUHec/r+4SviibyfKZzdv+bMkD+9Rerfa
 lug+2FzwK+5fZ0PI/Seb2Gs7FZAqDtK4PqC+H16wTx+RwzexipBnYNhLEElDQzapegg0XEQMoVk
 5o1mwi8cq3Y1mgb2drrMLEufsx7bfMBdJNCkMzLSzptf6ATgLvuoXxtw3dy/W8JFqHuK3SBwAir
 07XLabfa6W/2Dh++L0eOaxgwLFqCDfYJ01J6E4iC3P3ujl5DtORTGU1X/rj7QSeBTk7d4c1e+nM
 SSe7xFVKNeDYEo9NTWMh2asZjcuW1Z/hSd0dLyi0xur51xfXoRplwvrZMV2564w7CeTi1lHv37T
 nwY2cvXWVAdsk5EpvK+3c//RJQy1nP+u20ANwZYiltuCxhIeEimScZeKkRVwbAutn8pAqsq7OiE
 wShgOi0MHh2ispPm1BNCJGkvJAVoXb7HxX3Dr2lY7EtDFw==
X-Received: by 2002:a05:6000:46d4:b0:47f:85d6:9e7f with SMTP id
 ffacd0b85a97d-47fec4e88cbmr15085204f8f.3.1786008435320; 
 Thu, 06 Aug 2026 02:27:15 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b31975sm4147248f8f.33.2026.08.06.02.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:27:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 11:27:08 +0200
Subject: [PATCH 2/6] video: panel: hitachi-tx10d07vm0baa: use common
 mipi_dsi_dcs_write_seq macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-2-6b533788d0ac@baylibre.com>
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
 d=baylibre.com; s=google; t=1786008435; x=1786613235;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hrVlvQ3qMFvKVzHPmG6zqerbPAERLhjJqbIoKiayhQ=;
 b=ZhgNk1i4AGAZVhpEbuF3SKC/A9Vg65Yh6pbgVx07HMORF2fQWPeFl5KgEIf/Lxwm97
 DtIiUHnGMzTmqcBgBJoHpIWMcqKl26qHKk5tFD+IRL10yKPeQKzSX43TxxcR6qzyIwPg
 DTdIm/ws9lbJtqJUrAXcuIeOUsfFjKrtLFVQpn/PdHg0C/nuynVq3DV+xosKJPEw/sQs
 jsgRdRMlew/pEdbOA9QvCDUbnpVbDqS9bY+N3h0xocz73CDpp5KaOiQ/NFMKzv6ygl6y
 PuXTYh0sosnhTEz5TOUdwzwaQ8PV/SA5XCW6RFOuMee8wrv5tzR9pBaB9pSyIwFGxhPR
 MC9g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZhgNk1i4
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

The current driver defines dsi_generic_write_seq as a wrapper around
mipi_dsi_dcs_write_buffer.

Now that mipi_dsi.h defines such macro, we can use the common one.
Note that we use mipi_dsi_dcs_write_seq instead of
mipi_dsi_generic_write_seq to keep the same behaviour.

No functional changes intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/hitachi-tx10d07vm0baa.c | 180 ++++++++++++++++------------------
 1 file changed, 86 insertions(+), 94 deletions(-)

diff --git a/drivers/video/hitachi-tx10d07vm0baa.c b/drivers/video/hitachi-tx10d07vm0baa.c
index 95b2f7bfc41..9e800c324b4 100644
--- a/drivers/video/hitachi-tx10d07vm0baa.c
+++ b/drivers/video/hitachi-tx10d07vm0baa.c
@@ -35,28 +35,20 @@ static struct display_timing default_timing = {
 	.vsync_len.typ		= 4,
 };
 
-#define dsi_generic_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 b[] = { cmd, seq };			\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int hitachi_tx10d07vm0baa_enable_backlight(struct udevice *dev)
 {
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
 	struct mipi_dsi_device *dsi = plat->device;
 	int ret;
 
-	dsi_generic_write_seq(dsi, MIPI_DCS_SET_PARTIAL_AREA, 0x00,
-			      0x00, 0x03, 0x1f);
-	dsi_generic_write_seq(dsi, MIPI_DCS_SET_SCROLL_AREA, 0x00,
-			      0x00, 0x03, 0x20, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PARTIAL_AREA, 0x00,
+			       0x00, 0x03, 0x1f);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_SCROLL_AREA, 0x00,
+			       0x00, 0x03, 0x20, 0x00, 0x00);
 
-	dsi_generic_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
-	dsi_generic_write_seq(dsi, MIPI_DCS_SET_SCROLL_START, 0x00,
-			      0x00);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_SCROLL_START, 0x00,
+			       0x00);
 
 	ret = mipi_dsi_dcs_set_pixel_format(dsi, MIPI_DCS_PIXEL_FMT_24BIT);
 	if (ret) {
@@ -70,59 +62,59 @@ static int hitachi_tx10d07vm0baa_enable_backlight(struct udevice *dev)
 		return ret;
 	}
 
-	dsi_generic_write_seq(dsi, 0x71, 0x00);		/* Ex_Vsync_en */
-
-	dsi_generic_write_seq(dsi, 0xb2, 0x00);		/* VCSEL */
-	dsi_generic_write_seq(dsi, 0xb4, 0xaa);		/* setvgmpm */
-	dsi_generic_write_seq(dsi, 0xb5, 0x33);		/* rbias1 */
-	dsi_generic_write_seq(dsi, 0xb6, 0x03);		/* rbias2 */
-
-	dsi_generic_write_seq(dsi, 0xb7, 0x1a, 0x33, 0x03, 0x03,
-			      0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
-			      0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
-	dsi_generic_write_seq(dsi, 0xb8, 0x1c, 0x53, 0x03, 0x03,
-			      0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
-			      0x00, 0x01, 0x01);			/* set_ddvdhm */
-
-	dsi_generic_write_seq(dsi, 0xb9, 0x0a, 0x01, 0x01, 0x00,
-			      0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
-	dsi_generic_write_seq(dsi, 0xba, 0x0f, 0x01, 0x01, 0x00,
-			      0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
-	dsi_generic_write_seq(dsi, 0xbb, 0x00, 0x00, 0x00, 0x00,
-			      0x01, 0x02, 0x01);			/* set_vcl */
-
-	dsi_generic_write_seq(dsi, 0xc1, 0x01);		/* number of lines */
-	dsi_generic_write_seq(dsi, 0xc2, 0x08);		/* number of fp lines */
-	dsi_generic_write_seq(dsi, 0xc3, 0x04);		/* gateset(1) */
-	dsi_generic_write_seq(dsi, 0xc4, 0x4c);		/* 1h period */
-	dsi_generic_write_seq(dsi, 0xc5, 0x03);		/* source precharge */
-	dsi_generic_write_seq(dsi, 0xc6, 0xc4, 0x04);	/* source precharge timing */
-	dsi_generic_write_seq(dsi, 0xc7, 0x00);		/* source level */
-	dsi_generic_write_seq(dsi, 0xc8, 0x02);		/* number of bp lines */
-	dsi_generic_write_seq(dsi, 0xc9, 0x10);		/* gateset(2) */
-	dsi_generic_write_seq(dsi, 0xca, 0x04, 0x04);	/* gateset(3) */
-	dsi_generic_write_seq(dsi, 0xcb, 0x03);		/* gateset(4) */
-	dsi_generic_write_seq(dsi, 0xcc, 0x12);		/* gateset(5) */
-	dsi_generic_write_seq(dsi, 0xcd, 0x12);		/* gateset(6) */
-	dsi_generic_write_seq(dsi, 0xce, 0x30);		/* gateset(7) */
-	dsi_generic_write_seq(dsi, 0xcf, 0x30);		/* gateset(8) */
-	dsi_generic_write_seq(dsi, 0xd0, 0x40);		/* gateset(9) */
-	dsi_generic_write_seq(dsi, 0xd1, 0x22);		/* flhw */
-	dsi_generic_write_seq(dsi, 0xd2, 0x22);		/* vckhw */
-	dsi_generic_write_seq(dsi, 0xd3, 0x04);		/* flt */
-	dsi_generic_write_seq(dsi, 0xd4, 0x14);		/* tctrl */
-	dsi_generic_write_seq(dsi, 0xd6, 0x02);		/* dotinv */
-	dsi_generic_write_seq(dsi, 0xd7, 0x00);		/* on/off sequence period */
-
-	dsi_generic_write_seq(dsi, 0xd8, 0x01, 0x05, 0x06, 0x0d,
-			      0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
-	dsi_generic_write_seq(dsi, 0xd9, 0x24, 0x01);			/* ponseqb */
-	dsi_generic_write_seq(dsi, 0xde, 0x09, 0x0f, 0x21, 0x12,
-			      0x04);					/* ponseqc */
-
-	dsi_generic_write_seq(dsi, 0xdf, 0x02, 0x06, 0x06, 0x06,
-			      0x06, 0x00);				/* pofseqa */
-	dsi_generic_write_seq(dsi, 0xe0, 0x01);				/* pofseqb */
+	mipi_dsi_dcs_write_seq(dsi, 0x71, 0x00);		/* Ex_Vsync_en */
+
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x00);		/* VCSEL */
+	mipi_dsi_dcs_write_seq(dsi, 0xb4, 0xaa);		/* setvgmpm */
+	mipi_dsi_dcs_write_seq(dsi, 0xb5, 0x33);		/* rbias1 */
+	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x03);		/* rbias2 */
+
+	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x1a, 0x33, 0x03, 0x03,
+			       0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
+			       0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
+	mipi_dsi_dcs_write_seq(dsi, 0xb8, 0x1c, 0x53, 0x03, 0x03,
+			       0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
+			       0x00, 0x01, 0x01);			/* set_ddvdhm */
+
+	mipi_dsi_dcs_write_seq(dsi, 0xb9, 0x0a, 0x01, 0x01, 0x00,
+			       0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
+	mipi_dsi_dcs_write_seq(dsi, 0xba, 0x0f, 0x01, 0x01, 0x00,
+			       0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
+	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x00, 0x00, 0x00, 0x00,
+			       0x01, 0x02, 0x01);			/* set_vcl */
+
+	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x01);		/* number of lines */
+	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x08);		/* number of fp lines */
+	mipi_dsi_dcs_write_seq(dsi, 0xc3, 0x04);		/* gateset(1) */
+	mipi_dsi_dcs_write_seq(dsi, 0xc4, 0x4c);		/* 1h period */
+	mipi_dsi_dcs_write_seq(dsi, 0xc5, 0x03);		/* source precharge */
+	mipi_dsi_dcs_write_seq(dsi, 0xc6, 0xc4, 0x04);	/* source precharge timing */
+	mipi_dsi_dcs_write_seq(dsi, 0xc7, 0x00);		/* source level */
+	mipi_dsi_dcs_write_seq(dsi, 0xc8, 0x02);		/* number of bp lines */
+	mipi_dsi_dcs_write_seq(dsi, 0xc9, 0x10);		/* gateset(2) */
+	mipi_dsi_dcs_write_seq(dsi, 0xca, 0x04, 0x04);	/* gateset(3) */
+	mipi_dsi_dcs_write_seq(dsi, 0xcb, 0x03);		/* gateset(4) */
+	mipi_dsi_dcs_write_seq(dsi, 0xcc, 0x12);		/* gateset(5) */
+	mipi_dsi_dcs_write_seq(dsi, 0xcd, 0x12);		/* gateset(6) */
+	mipi_dsi_dcs_write_seq(dsi, 0xce, 0x30);		/* gateset(7) */
+	mipi_dsi_dcs_write_seq(dsi, 0xcf, 0x30);		/* gateset(8) */
+	mipi_dsi_dcs_write_seq(dsi, 0xd0, 0x40);		/* gateset(9) */
+	mipi_dsi_dcs_write_seq(dsi, 0xd1, 0x22);		/* flhw */
+	mipi_dsi_dcs_write_seq(dsi, 0xd2, 0x22);		/* vckhw */
+	mipi_dsi_dcs_write_seq(dsi, 0xd3, 0x04);		/* flt */
+	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x14);		/* tctrl */
+	mipi_dsi_dcs_write_seq(dsi, 0xd6, 0x02);		/* dotinv */
+	mipi_dsi_dcs_write_seq(dsi, 0xd7, 0x00);		/* on/off sequence period */
+
+	mipi_dsi_dcs_write_seq(dsi, 0xd8, 0x01, 0x05, 0x06, 0x0d,
+			       0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
+	mipi_dsi_dcs_write_seq(dsi, 0xd9, 0x24, 0x01);			/* ponseqb */
+	mipi_dsi_dcs_write_seq(dsi, 0xde, 0x09, 0x0f, 0x21, 0x12,
+			       0x04);					/* ponseqc */
+
+	mipi_dsi_dcs_write_seq(dsi, 0xdf, 0x02, 0x06, 0x06, 0x06,
+			       0x06, 0x00);				/* pofseqa */
+	mipi_dsi_dcs_write_seq(dsi, 0xe0, 0x01);				/* pofseqb */
 
 	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0xff);
 	if (ret) {
@@ -130,32 +122,32 @@ static int hitachi_tx10d07vm0baa_enable_backlight(struct udevice *dev)
 		return ret;
 	}
 
-	dsi_generic_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
-
-	dsi_generic_write_seq(dsi, 0xe2, 0x00, 0x00);		/* cabc pwm */
-	dsi_generic_write_seq(dsi, 0xe3, 0x03);			/* cabc */
-	dsi_generic_write_seq(dsi, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
-			      0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
-	dsi_generic_write_seq(dsi, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
-			      0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
-	dsi_generic_write_seq(dsi, 0xe7, 0x2a);			/* cabc */
-	dsi_generic_write_seq(dsi, 0xe8, 0x00);			/* brt_rev */
-	dsi_generic_write_seq(dsi, 0xe9, 0x00);			/* tefreq */
-
-	dsi_generic_write_seq(dsi, 0xea, 0x01);			/* high speed ram */
-
-	dsi_generic_write_seq(dsi, 0xeb, 0x00, 0x33, 0x0e, 0x15,
-			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
-	dsi_generic_write_seq(dsi, 0xec, 0x00, 0x33, 0x0e, 0x15,
-			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
-	dsi_generic_write_seq(dsi, 0xed, 0x00, 0x33, 0x0e, 0x15,
-			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
-	dsi_generic_write_seq(dsi, 0xee, 0x00, 0x33, 0x0e, 0x15,
-			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
-	dsi_generic_write_seq(dsi, 0xef, 0x00, 0x33, 0x0e, 0x15,
-			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
-	dsi_generic_write_seq(dsi, 0xf0, 0x00, 0x33, 0x0e, 0x15,
-			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
+
+	mipi_dsi_dcs_write_seq(dsi, 0xe2, 0x00, 0x00);		/* cabc pwm */
+	mipi_dsi_dcs_write_seq(dsi, 0xe3, 0x03);			/* cabc */
+	mipi_dsi_dcs_write_seq(dsi, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
+			       0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
+	mipi_dsi_dcs_write_seq(dsi, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
+			       0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
+	mipi_dsi_dcs_write_seq(dsi, 0xe7, 0x2a);			/* cabc */
+	mipi_dsi_dcs_write_seq(dsi, 0xe8, 0x00);			/* brt_rev */
+	mipi_dsi_dcs_write_seq(dsi, 0xe9, 0x00);			/* tefreq */
+
+	mipi_dsi_dcs_write_seq(dsi, 0xea, 0x01);			/* high speed ram */
+
+	mipi_dsi_dcs_write_seq(dsi, 0xeb, 0x00, 0x33, 0x0e, 0x15,
+			       0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
+	mipi_dsi_dcs_write_seq(dsi, 0xec, 0x00, 0x33, 0x0e, 0x15,
+			       0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
+	mipi_dsi_dcs_write_seq(dsi, 0xed, 0x00, 0x33, 0x0e, 0x15,
+			       0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
+	mipi_dsi_dcs_write_seq(dsi, 0xee, 0x00, 0x33, 0x0e, 0x15,
+			       0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
+	mipi_dsi_dcs_write_seq(dsi, 0xef, 0x00, 0x33, 0x0e, 0x15,
+			       0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x00, 0x33, 0x0e, 0x15,
+			       0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret) {

-- 
2.54.0

