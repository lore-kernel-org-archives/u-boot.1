Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C95C56203
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 09:27:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7A2B60759;
	Thu,  6 Aug 2026 09:27:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gr0mmcOGJNqf; Thu,  6 Aug 2026 09:27:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3AFA6080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786008444;
	bh=YlV+BJ8Q2OVTAbafhJg5XKE0ZAXUHaOG+5oY9vq18k8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T/U4LL0OZ1LWkkOcREbwNkBxu7F6mFnW5iJVAP1EFGjzp3sxzBeHyqDKZFKXgAw5w
	 F/xE95gdBZLJVpPAuHMYyXi4db9E7MjRS6P1mtk6wnHA7b9/kC18fvk4rUOqe6iuH8
	 oxuK3uJkP7a6EvE4T2XejBKLWtpAAgTcINpwm1ZNhARGk+BGiumJFyWQK3Xm2j5dw6
	 A79TjqzPo5V+VYW21Wv/ggtVqWnc+0sMGR3WHXC1WFU9z0VJH6MhBcjRfq1bZY21Uh
	 QfuKcaDcRaQIJmrKuDG/sBVSH+ik/HWdlLKllcyAfZ8MRle/xYIxuGMvHMToLqpW1l
	 myaqbRz2+G6ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3AFA6080C;
	Thu,  6 Aug 2026 09:27:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF4F5282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5DC840207
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XFTdllvMTvnh for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B231640167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B231640167
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B231640167
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:18 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso916101f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786008436; x=1786613236;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YlV+BJ8Q2OVTAbafhJg5XKE0ZAXUHaOG+5oY9vq18k8=;
 b=niv8ZBYS2e3MO7xOrTkVNfDsKAOr9mbuZP+Djh4XdfMr8os20tCg4I53lYuQxFhnDz
 KnKNPTgKi/vnirPGa0Pe1JaTQ6tMHrpdZBW2nevLBHFyVJelppSRmgvQQAqyTnhjK2/U
 hgyo0VzICO38WO7rAekvqkeONNEiAWl5+ZrwTwz4wr8gHUtdiPYPntQgPubGu0xE9Gvm
 uNXWRmBDQM4gAA62CSFv9XBJLgKoiK3cidBXfubFX1l3ci6xOXDddBfa+o7yefSG/Zy3
 eIjJ6vgbAbnqN8Z/AyFacrIcAcaSbuxrKcrz0HMYTGjGu5d+KlHOX4TSNg1uI/wI6SkC
 BHWg==
X-Gm-Message-State: AOJu0Ywn6wSBksfYDwCwkAjPo0OrHuhO7w6lfJONHgPRkmZWSFXMDdO4
 OQ2h92EUSzk/+ZNRxIdiA7iHhn0l7bgg681AcRS3MKhk3/DtG3o+nFy9kYRAEyPzxTU=
X-Gm-Gg: AR+sD11A0lHO0ZodVCs9Ct3z8o/9kjNctUuVCuWoZJha3PjZWyc1QujiGGDR+IFFYEC
 Cryt0JfnCULp7wW0kRVkYFVlUY/Sm89LeaBTWF9IJYeYCbKTtgJ251sUHMM8DToousNxhii/k53
 PDgvMJ2qdSwusEcIWzTtcGCPBsnqlitLd/bi9Y6rsNinmJvcbcloeE10Q/u3K6e9+2Zwo05Cfvs
 bwgGYU3GYYJBcQ2e4ARlwN5q27x1ToK50pHVogiTDlRvePTpDOJ7aDBYYHoHtpyB6hVKh5nW1Sy
 dC6wOndB+x5/X3F48jllMY8Sc6DlHNUKxmJof93Pq2W3QfwIHeiGhp0wmxXfowl3CB84N6ESHC7
 v94CaTPdKSdSI/DdK8Z0aetlBj6yt+BFbb+zhfT3jzKh/1XcuMe4EGaCL+dt7yl6sPSGKSyOgYy
 tUuQYN6/2ZGQ+P9kgoCBMGmi9QQC4RdYaK9ZlbICelFqC2mg+iEBpU8kHoBLitq3iGr+lzLhdTD
 NahEOzDsAtJMO56IgY8Y+PYf4oW6Ruw3N1fIOlROJ3tFihhd1oO3AC0GT5Uv2OFAeUg6UMwaF4r
 8oNw4H2S+92MDKzmGkt0XMSMtIYttegYyqNSqCrml5+M4g==
X-Received: by 2002:a05:6000:2086:b0:474:b860:b7b1 with SMTP id
 ffacd0b85a97d-47fec51892bmr19426669f8f.9.1786008436332; 
 Thu, 06 Aug 2026 02:27:16 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b31975sm4147248f8f.33.2026.08.06.02.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:27:15 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 11:27:09 +0200
Subject: [PATCH 3/6] video: panel: lg-lh400wv3-sd04: use common
 mipi_dsi_dcs_write_seq macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-3-6b533788d0ac@baylibre.com>
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
 d=baylibre.com; s=google; t=1786008436; x=1786613236;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YlV+BJ8Q2OVTAbafhJg5XKE0ZAXUHaOG+5oY9vq18k8=;
 b=eb2/NuoL9p1lo9SpjpcdOqc/ftqq3XPJ0Amq3GWnvhykj1P0IfNx52I3JIe+brtN7g
 jOPDa1zlMKurEpRTKNo2yfOodxhWXGuCQW70cCaSMAL/6MCHD2d8y/acfIERoMXk7yRp
 6STX6auJN22G3GEv7o7GLv+164toGeS2uRWMc04GUyJUYz1tqyS76aChrW0IbN1RRIZd
 +z5o8Nzj7jNcL5a4ulWzuKcwiWRRaooYRhncphraGTNHLaNW/IMAy95tGeqScJNjTepJ
 EphgMZaThCCFCmvvIaIVIEbIg8LA+38Yexo7LiKXhw72cOngWF3PhkBoitmWCXI+St0V
 ibTA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eb2/NuoL
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
 drivers/video/lg-lh400wv3-sd04.c | 58 +++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/video/lg-lh400wv3-sd04.c b/drivers/video/lg-lh400wv3-sd04.c
index 0385b39867f..8e6b5d2d723 100644
--- a/drivers/video/lg-lh400wv3-sd04.c
+++ b/drivers/video/lg-lh400wv3-sd04.c
@@ -35,22 +35,14 @@ static struct display_timing default_timing = {
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
 static int lg_lh400wv3_enable_backlight(struct udevice *dev)
 {
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
 	struct mipi_dsi_device *dsi = plat->device;
 	int ret;
 
-	dsi_generic_write_seq(dsi, MIPI_DCS_EXIT_INVERT_MODE);
-	dsi_generic_write_seq(dsi, MIPI_DCS_SET_TEAR_ON);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_EXIT_INVERT_MODE);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_TEAR_ON);
 
 	ret = mipi_dsi_dcs_set_pixel_format(dsi, MIPI_DCS_PIXEL_FMT_24BIT |
 					    MIPI_DCS_PIXEL_FMT_24BIT << 4);
@@ -59,28 +51,28 @@ static int lg_lh400wv3_enable_backlight(struct udevice *dev)
 		return ret;
 	}
 
-	dsi_generic_write_seq(dsi, 0xb2, 0x00, 0xc8);
-	dsi_generic_write_seq(dsi, 0xb3, 0x00);
-	dsi_generic_write_seq(dsi, 0xb4, 0x04);
-	dsi_generic_write_seq(dsi, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
-	dsi_generic_write_seq(dsi, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
-	dsi_generic_write_seq(dsi, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
-
-	dsi_generic_write_seq(dsi, 0xc0, 0x01, 0x11);
-	dsi_generic_write_seq(dsi, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
-	dsi_generic_write_seq(dsi, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
-	dsi_generic_write_seq(dsi, 0xc5, 0x65);
-	dsi_generic_write_seq(dsi, 0xc6, 0x41, 0x63);
-
-	dsi_generic_write_seq(dsi, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
-	dsi_generic_write_seq(dsi, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
-	dsi_generic_write_seq(dsi, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
-	dsi_generic_write_seq(dsi, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
-	dsi_generic_write_seq(dsi, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
-	dsi_generic_write_seq(dsi, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
-
-	dsi_generic_write_seq(dsi, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
-	dsi_generic_write_seq(dsi, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0xc8);
+	mipi_dsi_dcs_write_seq(dsi, 0xb3, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xb4, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
+	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
+	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, 0xc0, 0x01, 0x11);
+	mipi_dsi_dcs_write_seq(dsi, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
+	mipi_dsi_dcs_write_seq(dsi, 0xc5, 0x65);
+	mipi_dsi_dcs_write_seq(dsi, 0xc6, 0x41, 0x63);
+
+	mipi_dsi_dcs_write_seq(dsi, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
@@ -90,7 +82,7 @@ static int lg_lh400wv3_enable_backlight(struct udevice *dev)
 
 	mdelay(120);
 
-	dsi_generic_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {

-- 
2.54.0

