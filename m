Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B96C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECDF81F0D;
	Fri, 28 Mar 2025 14:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cMDgm3AH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CA28003E; Fri, 28 Mar 2025 14:07:30 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484B581E1F
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b3f92c866so35149139f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167245; x=1743772045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9aZ20JCg8XZRZtCzo2y/J02t9J3UecyfGNU6wktKts=;
 b=cMDgm3AHRNVGjeo6FIB+or84E74/ha7j9Zj1rVErN8u+FzZ2unADTJREMyTwADEyaq
 dp/NoGLi2m9ahQxojnKKjAFD2gVMdqYqN5I1dKUTcO2cfLVgf7XkQROuPLNOszOfHeTo
 WqoFwJCNREqImIi9n3Ws/erpBaWhxtT31hk7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167245; x=1743772045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9aZ20JCg8XZRZtCzo2y/J02t9J3UecyfGNU6wktKts=;
 b=cLk/RkolbZdq7LYU0Nr6h+GS3o7BeYR0bZMBMbW6wa0gisf0KsNtJus5C5CL5hM2Qr
 T1gQsgPKoLiSBEVgGe7vZyS1C7fO6aloSlzoUWCvcdMxhxsRVXB1+AdJiTyaghwjiFn/
 FUzCSCjmsMgGScFRzDcjmUNY5yKpvHo2wcpUhhQGjKIYlSyHfdCW1GvXTRd98To88Ee7
 jn0TeqZRurAX19XAZiA6ZQO9FM4LRU3z3Ho+c2VVVvWkFYPXP6SpqOqke2XoJrm3bwTB
 GYUG0SlguNmdQnpKV9wwtxBnVZL4CeBVxWoZI5+l5f6xHuYwwIBlrLnQwZJ1Lh5O+q7N
 4P1A==
X-Gm-Message-State: AOJu0YzAzBLJMBViQ/eAW0oyI2AXvCqZzdscrABapHM/YXKNLwJekT8s
 lbzWlSNuPnV4mTEyKO9QFzWNR3oUfDmsBZlf3VYIOvDMWUdjzuzeYQUw3LgVMJWQZ1FCURTLGDA
 =
X-Gm-Gg: ASbGnct8lfdGGjIAuCF/LfppHohb0b6zUDvEhajzvUz3ZJUsSltxsGKy6sQdeAHFJav
 nNOl06vawaB/yU9Wah82gG89QnO7oC+6p5qnQgX5HWVAKvww0Vden10XYsHVpEx47HgfXIukKaS
 t/UTd0w4g6V06K7Y4UeAOhWUNzvs6lEw4sHnLyUqUNtWQRjuZ2YhENn2gDXaYPgR4Vdb+GE1Jx2
 kuSzn5Hhf6mmihglZAURkx5zi12wE1MCYJJY/ZPvdWX29KTOaK5jUiGcpCUZg01gqVUS4S3rvv0
 1tDO0qQGP1HEE0C23evyOfvgSqNzQP1qRW6/rJtI6unx3rN/+wh3XsJ2dmepJyzF9cx5V2a9GBn
 lmgGfgw==
X-Google-Smtp-Source: AGHT+IG0tzg+56BoBKkM3s8hQFLyW/P6v23Tf0aC70wRKUEJlm4L+dlY2/l8jZRNFv6LibTtsWbInA==
X-Received: by 2002:a05:6602:6a87:b0:85b:538e:1fad with SMTP id
 ca18e2360f4ac-85e8209741emr865353139f.6.1743167245245; 
 Fri, 28 Mar 2025 06:07:25 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/56] video: Add a test for font measurement
Date: Fri, 28 Mar 2025 07:05:50 -0600
Message-ID: <20250328130713.2612648-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

(no changes since v1)

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

