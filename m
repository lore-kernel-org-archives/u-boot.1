Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F159DCEDD99
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66478924D;
	Wed,  9 Oct 2024 16:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x21rreQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A278924B; Wed,  9 Oct 2024 16:03:46 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63F989241
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42e5e758093so60969285e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728482622; x=1729087422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1f3amPh9ObQpkp4lRVh54Ids70l7HQ905iISzEE+AaE=;
 b=x21rreQiMmtykeBdtCbAKLxeXIqDU8WZ2AJLXHniAEyt2B1QeR4GV7gMaknh6sKTYK
 hiE49Gj8BFcauZGUbGckFzRIFzal2WcdAAPwh8jkxbGHtVaj1dpWxZOgueDKhyhT6occ
 8nJk4bH6oOFYKfBvp1eXy5VvJsQM4k+IuVvdrAP9+na8T4q2Cv3nkd4xybAajWFLXYCM
 1UijcIVxGpvfQdJTq0LYPpWphuEncsyxvr/D33c+BHtmOPKpqbz7QM24A3BkDIHyuYmA
 rKzlR89h9Ltqqd8UzMmcZn/BiD8Livdk/Q3Yzg6pF6MJ+n18p9fYENC4sXZWQqkrSPqA
 zr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728482622; x=1729087422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1f3amPh9ObQpkp4lRVh54Ids70l7HQ905iISzEE+AaE=;
 b=uSkcsxZuDPdsIHjXWZyCBU/orcr/LoEOfGHfpbSULNUdJ0WtNs5kdmdv9n+g1ZpoyQ
 tQtv0hnY/FqEAmRueMl23yrFCWCoPas/dFyyk7A0RgMS/n4/Ifkdf80dna2Yer9tXy1e
 GjKA2aoZkUfm3Dhph9/kgNjr1uWvyFIZqcWwZhTGo4ppcRWuP8mjxqJdA3kx9avKkNDw
 DCr0KnpxJc3T8H2zqWlFzsBLtcX/AjpFIxyYqxJJirSZdwvo5gpQXcBrV54FXJRwjU/0
 X6CF8QjtcYycFwyWyrddlplmO8DlauvgXp9X4xByV1HO9IJ9bX4i6a67raTeaonH6ZIE
 EgKw==
X-Gm-Message-State: AOJu0YxRnC4HMR7Z/iNAavWAh3DopiYrRKXidsQvHCLExcT6AlTYY07F
 SZHYs4K0PpDf4Z+q4DrIG35JlIEAHTdCzet/xrWUHjPsKO1T2vSXNiVkGhaybJvMpuH0euKGKNd
 JCJlctw==
X-Google-Smtp-Source: AGHT+IH6i9kSzipMRukHqV/j9QNxQy+aZjWMPyfWLkNJ5aeC5YRut4x2CMAqhmY6WlEu36BmDKkWhg==
X-Received: by 2002:a05:600c:1f11:b0:426:689b:65b7 with SMTP id
 5b1f17b1804b1-430d59b7820mr19811905e9.25.1728482622087; 
 Wed, 09 Oct 2024 07:03:42 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f0b2sm10581728f8f.9.2024.10.09.07.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:03:41 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v12 03/21] test: boot: fix bootdev_test_any for when
 DSA_SANDBOX is disabled
Date: Wed,  9 Oct 2024 16:02:53 +0200
Message-Id: <adbd7e6b79450ed136b27920f25ac7ef4b79a340.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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

When DSA_SANDBOX is not set, the sandbox tests fail as follows:

 $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
 [...]
 Test: bootdev_test_any: bootdev.c
 test/boot/bootdev.c:156, bootdev_test_any(): "mmc2" = media->name: Expected "mmc2", got "mmc0"
 [...]

This is due to the device list containing two less entries than
expected. Therefore, adjust the expected index to be two less when
DSA_SANDBOX is disabled.

The actual use case is NET_LWIP=y (to be introduced in later patches)
which implies DSA_SANDBOX=n for the time being.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 test/boot/bootdev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index c635d06ec25..369105ca4cf 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -128,6 +128,7 @@ BOOTSTD_TEST(bootdev_test_labels, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
 static int bootdev_test_any(struct unit_test_state *uts)
 {
 	struct udevice *dev, *media;
+	char *seq;
 	int mflags;
 
 	/*
@@ -147,8 +148,16 @@ static int bootdev_test_any(struct unit_test_state *uts)
 	 * 8   [   ]      OK  mmc       mmc2.bootdev
 	 * 9   [ + ]      OK  mmc       mmc1.bootdev
 	 * a   [   ]      OK  mmc       mmc0.bootdev
+	 *
+	 * However if DSA_SANDBOX is disabled the dsa-test@{0,1} devices
+	 * are not there.
 	 */
-	ut_assertok(bootdev_find_by_any("8", &dev, &mflags));
+	if (CONFIG_IS_ENABLED(DSA_SANDBOX))
+		seq = "8";
+	else
+		seq = "6";
+
+	ut_assertok(bootdev_find_by_any(seq, &dev, &mflags));
 	ut_asserteq(UCLASS_BOOTDEV, device_get_uclass_id(dev));
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_DEV, mflags);
 	media = dev_get_parent(dev);
-- 
2.40.1

