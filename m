Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDCAC36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505B981F7E;
	Tue,  1 Apr 2025 19:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3p9+IKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D1B81F7E; Tue,  1 Apr 2025 19:30:27 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5762817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3032aa1b764so7534303a91.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528622; x=1744133422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YEBvDbsq3ogqQMqUiRiB8tPhgsnlaqLBjep5lb+LKA=;
 b=k3p9+IKQGikvonIrKKPmjX44qK9gv2t3B5kI5M4Qz1MkH/Jk1YC7iCkPJjJ1jj5G5a
 XnptIWCNuXdN+PA1qtElYAG4LB2BrKpAPMu8QUI2FkIBAymVBGuXb4ogyM3goy+nFO2N
 rEGkZMZtQWVAFKacoW+cOVPk1Et5lMS6SABJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528622; x=1744133422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YEBvDbsq3ogqQMqUiRiB8tPhgsnlaqLBjep5lb+LKA=;
 b=O7h8SGYtMAROAuUQBP5S3nzIl4dCmhBTz0wKCI3Qxhdb6NZieCFY4FrMGdOYw83YSE
 rLtfggUdNhe+sGwXwYcv1dQo3C+C+5It/mMRfU4YECWBIYJlvQrRFREP3lbUDFzD031W
 IhCeuyNMSPOUgq27NDiGl3M1uNO2O2w2xOyA9cWVGssCl6riuVvC1xaoxQCoUhQC9/4e
 jQCVKRFYX/K6VVez+0CJZ5HMOdXc7rUw7mo2yZA2D0hrI3Wlew4I5Bj+ougaFt6MZDiz
 Ao8hQjF/Aph9BmgHa+O/4SnlvzxJ7uFDKjeau57XYlrMKb+QG1WseL5zVJRk1875wBPw
 /S/w==
X-Gm-Message-State: AOJu0Yyot1tb+e0tfB4YJiGLSOU04ZxqBvZm8qIOvBzLC+gWYYwRunLM
 v0riUyZIOAzuDIBqzidCv7cK/tLCNSWhNEA1UIAicmx1Vehd9Ksn0c4Y/Ujuu/uDxm+Ksmy5clx
 ykg==
X-Gm-Gg: ASbGncu4MfKIpTcSM4P9fxX5190T0DIzKooeRzc6WPrtwNi/zHccQfhJqgocRUiPqXE
 ynyTVGg+KMcF3uPFz1CYW2PDw0j7Kd/2aufh1asCxSj4sL/btFntTMpIHKHDZrn6SxCYvEDuPmf
 v3CRoLhDmrmVIVPMevkklVPaFdsS2W4IsiDaVsKUk6sc35I164IIR3yiQcsq157R5PxXtE04nNk
 UuhjpbAGZXbTJvL6nto9nhUSCCAxaUmIUIkMiM6oy/GyBEU7SR2KQsvAd4yqV1ggmT4jhxe1PNk
 NTurY9D7u/kCqmLiDCdCF9HqSt6TsSW1dgGpwxOc5vYJLX5N5CwuYQ==
X-Google-Smtp-Source: AGHT+IEHtVWH4NcbRLgRLF5BeIRnOZivVlcOIFTOTC7SaydI9aQVt+w4IJR+ramQNelQ/tl79nSSyA==
X-Received: by 2002:a17:90b:2ed0:b0:2ff:62f8:9a12 with SMTP id
 98e67ed59e1d1-30532147235mr17487484a91.23.1743528622413; 
 Tue, 01 Apr 2025 10:30:22 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/13] video: Add a test for font measurement
Date: Wed,  2 Apr 2025 06:29:35 +1300
Message-ID: <20250401172948.1236000-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
References: <20250401172948.1236000-1-sjg@chromium.org>
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

