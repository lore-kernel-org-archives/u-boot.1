Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E2FD1AD39
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858AD88F57;
	Wed, 16 Oct 2024 11:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lklod/5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBAFB88EE0; Wed, 16 Oct 2024 11:57:15 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D52E588D1B
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so4133998f8f.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729072633; x=1729677433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1f3amPh9ObQpkp4lRVh54Ids70l7HQ905iISzEE+AaE=;
 b=Lklod/5ykVBSCeEyHmapwwnmEuZA59m8z4j7bmoVv0EtLZST6i8tSxq47qSsqKkWKb
 pFiUpKRiTHogd1mOk5bL2/0TMF9JBkEExepLq2EyCD2Vu+YobQu1ZYkyXybfqujjXjMP
 npE+1i97z8onIyKlo9C1gYCnr2Mkf/AWt4YYWOj/Fhs7vQjseFQ+xyWavkeiODYMYE5h
 iG8s/Jlttzd/Ej5SvqDB+Nnjd8qoCEcbMJQGwusFm9TMEbdad/4++uWo4QXqMPQMF9A8
 Gbq34JDGuZ8utNYzpb1J+3PC0sgTcufjlP2act7PIawU5KaTfBXoE51KDjNwgP6owsEV
 JdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729072633; x=1729677433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1f3amPh9ObQpkp4lRVh54Ids70l7HQ905iISzEE+AaE=;
 b=ZDHnDUwmQMy5Joqx3E5g78eRyemUa/0+K3Zwlp6TUhtsw9ljqghODXP3k7hJMzgFvv
 G3fTBDnk8jPcWxetTNs3OS0JXtphEOXpEwR4eWM2M29aGN2E/OHyvBJ2v8SEC4KQEDLs
 ePpDpJTg9DktDgEyW4On24gWnzxw5WBETkuxvWpt/HfXewAQKtamJhVtMlTnNuo1SGlD
 AM3MlcBjNi7HGwo5Ayb/uDOUE3R9SRpsSqm42qffa/Npm8n5j32BuQ/yiun3F9eoEBM1
 nt9jNnG2m9HnoMHdoWlJ1UasreJf/+ZaxpGXC5ONXO1T+Tl14T+KKdNkJBC9Kr99vEhB
 xWww==
X-Gm-Message-State: AOJu0YwgjtzsryZn8BQ0rTVxoyMspnL39OdRHi3IBsM6rAP8PxEQsIhA
 KjMyvVf+zdvOJGAX1drsyPe8cuhvXdvZ9r9px3lAqs12I0PLjToJAS+HZfYwzNPHwgMRQlI//8W
 nj69EbQ==
X-Google-Smtp-Source: AGHT+IH6z6OJ2kIppR3vJKYecBzZsZpwzyqoabny0/XJDZp665iJmzrXp2qeoezlo0t7NEwoKmSuBQ==
X-Received: by 2002:adf:f3c9:0:b0:37d:3280:203a with SMTP id
 ffacd0b85a97d-37d55184cdbmr13538107f8f.10.1729072632996; 
 Wed, 16 Oct 2024 02:57:12 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b1ebfsm45236335e9.34.2024.10.16.02.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 02:57:12 -0700 (PDT)
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
Subject: [PATCH v13 03/21] test: boot: fix bootdev_test_any for when
 DSA_SANDBOX is disabled
Date: Wed, 16 Oct 2024 11:56:25 +0200
Message-Id: <37694587e362f96d2e5179c27fd7e75990eaf4f2.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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

