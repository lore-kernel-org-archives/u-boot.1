Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A04C36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01DA81F54;
	Wed, 19 Mar 2025 15:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jKu2hN1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163CD81FC8; Wed, 19 Mar 2025 15:55:35 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A53E81EC9
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so34330565e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396132; x=1743000932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YEBvDbsq3ogqQMqUiRiB8tPhgsnlaqLBjep5lb+LKA=;
 b=jKu2hN1pobvcwELgSCYKpNsNDJqhpNf9OpWm+83S9XloctfxD5pj5gP0UhkmLMXb44
 5/VHRv0bOcriJjgkRmOo0n9JL4Qzdb7pFCFQA7Arc3kujoWwbCclrq3ssL6Ae3OkAvDX
 a9HH7Oazt7X1Vvxog8IU3VnrCWjTHk4sPrQeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396132; x=1743000932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YEBvDbsq3ogqQMqUiRiB8tPhgsnlaqLBjep5lb+LKA=;
 b=q9lySq72eEKHkVpIEEOkaHwXnGiJWXQ+6fgLeNFc/8BaSzZzbYKg0gw+MdzYP0OY8u
 fvU7+NgSWVHCFpVT8lRsa2KU/6ZxTOt2hNueOj+KLjwdR9AhzNrCMMooDRO8o67xj0c/
 tBZJaGPjLy6p2Nup6uZWr9aFTq8q80D0G/LK++muEJgvO2DivuMLAYa0uMZPsdG6wiYW
 u/fiXaeLmpRzavBkgfBIGQdqp9UP3+gmdofKPjKLVa29ve2pBeIj7vK+nP6ETIzFhBRW
 PMSQDDxKAAFo5K5+v5LyvAk2WpROVA1NiJQNnlbwX5mcuwLsrgOTAhD9KbwAi7HporqR
 iILg==
X-Gm-Message-State: AOJu0Yzh0aYecnmetB2Hqzhfx8dL504J2yx1hKb++CZIkJ1WI2t5EZGZ
 29tJQHHAjnVFqW8GYKupSPDW3ntWQrMq2PeP9TFWcyo/5Z+zjDFbuk4YitPISzdqHwHS6+/mxww
 =
X-Gm-Gg: ASbGnctLcc8mxUOxO3puu70Gtb8NqFM+/rvHz1oWFY4hGD7IkgJAuDCPWHqXiZqAmYC
 7uwy6M0LZh3bqlFuNoWvjdq10mr90vvLWGSLEAsxWxIOMScVqJB+yk+ukLMVYdjq79C207QEAHf
 XoSmTXE9F+iaSU4mHO47f3RA1PmSodRSYyR3FaybWAl8uczPKW/cPvOB1dTHHVObAVHID1XF7Oo
 ROQls1HBCkKjuFcczrUQFOiEBX/GQ9rqSUUYU/e5RfufmCqRjjXbQG0AbuVPfkt8KljjqkwZdLw
 OrU1mV5z2xtrCeu8zfrrTK77312CBvB7802dLsnKEQ==
X-Google-Smtp-Source: AGHT+IFHF2UbtsFYnTBrOLeWAmtun8tuQVfOXNXJ8HyecFP58od5mO1rKMW1gaqkInFycgl0EGBGgQ==
X-Received: by 2002:a05:600c:4ec6:b0:43d:4e9:27fe with SMTP id
 5b1f17b1804b1-43d4378e781mr23276155e9.8.1742396131846; 
 Wed, 19 Mar 2025 07:55:31 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/52] video: Add a test for font measurement
Date: Wed, 19 Mar 2025 15:54:08 +0100
Message-ID: <20250319145512.2391122-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a simple test which measures a line of text using a Truetype font.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/dm/video.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/test/dm/video.c b/test/dm/video.c
index 929fc16d0ef..6ce1a756e25 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -777,3 +777,32 @@ static int dm_test_video_damage(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_video_damage, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test font measurement */
+static int dm_test_font_measure(struct unit_test_state *uts)
+{
+	const char *test_string = "There is always much to be said for not "
+		"attempting more than you can do and for making a certainty of "
+		"what you try. But this principle, like others in life and "
+		"war, has its exceptions.";
+	struct vidconsole_bbox bbox;
+	struct video_priv *priv;
+	struct udevice *dev, *con;
+
+	ut_assertok(uclass_get_device(UCLASS_VIDEO, 0, &dev));
+	priv = dev_get_uclass_priv(dev);
+	ut_asserteq(1366, priv->xsize);
+	ut_asserteq(768, priv->ysize);
+
+	/* this is using the Nimbus font with size of 18 pixels */
+	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
+	vidconsole_position_cursor(con, 0, 0);
+	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox));
+	ut_asserteq(0, bbox.x0);
+	ut_asserteq(0, bbox.y0);
+	ut_asserteq(0x47a, bbox.x1);
+	ut_asserteq(0x12, bbox.y1);
+
+	return 0;
+}
+DM_TEST(dm_test_font_measure, UTF_SCAN_FDT);
-- 
2.43.0

