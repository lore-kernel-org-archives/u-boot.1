Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BAECF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CBE88EAB;
	Thu,  3 Oct 2024 17:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yDyV6C7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E953588E7A; Thu,  3 Oct 2024 17:23:45 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00CD888E19
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so11162155e9.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969023; x=1728573823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9X4um2R6dVMJH/vlbJbwmbiVPamSmz2YnJf/D866L60=;
 b=yDyV6C7rqT1uGptv+2PvH64Zo+/qmtJu5GA2WuN9Y7jW20rQRYCjgnrbuPEGFxEMUx
 qoV3eWDe+xVBuXDyeThtWoBaOIHlZG9zZ2gZLRvIqzNOnGPnuwy4drfcTGji2yS6gsSs
 a0CamMG86/aezPH9S2b0XKgxLLaF3RA6Egiq1JnVp2mO2ojyUALMdzb8eYS/qopuWCPf
 XsgcRjGvd4AyXN5PFVHbWsrKygG9QeE1zyCuV8tkudEk6/7gJ1bIIHZQSS63tkMMNLGM
 kH5me5FUxHYeXe0wbilefJL/csm4XWqbqfS/D1odc7Ik6vblmh58bvoMBsamY711ezcL
 SZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969023; x=1728573823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9X4um2R6dVMJH/vlbJbwmbiVPamSmz2YnJf/D866L60=;
 b=DbhKABvpzFMgCdNJJs5pp+0MwFwN0FWZ5GaknwMrWbjF3aJ64orFelZQ9FVHuIhEqz
 LIrtThhKqGQLDrIuRFkK8ZoN2MrDw+Tenvd/pLVuJdZreXmDBwZ8TF5OofGm7FuRKCu8
 LehDuFRrLf9E/U6lYWk6UmkuRWZhK3ddq2fBU9R2fRE1KktbYGHBGZzFb+/3ud8S0Dp+
 09EOeEU2mWgR6w4XV/yT4hU+JvAroHknrXhjvsDZV9GLJK3SRqXF/ZA0Ug+el4dKDier
 ymgS+1A9fGysOOBjSbsWi96olS3p7emPGrGK9xnPQAvjqzv/lt11kDdFFwDx/1W8hhsE
 royg==
X-Gm-Message-State: AOJu0YxZPTr+LTcmX0krJ60P/G4YmKo21YQ4gANY/NQXw8pNlu8JADKT
 oz9v5QQchcZnzqYteR8qTffLbDxTJx444Q6wp7EXtiQa81bb8+zSAZeLXlgkKlNwcSz8Df+/VVr
 7uGyAHQ==
X-Google-Smtp-Source: AGHT+IETVLMws4VrTYp8tUZpK1w7SB4XwmywUDsv5xlIlVuXdjkvhsKJ7uR/+uWD0B1bbxZXNVYHog==
X-Received: by 2002:a05:600c:230c:b0:42c:bdb0:c61e with SMTP id
 5b1f17b1804b1-42f7a12bb01mr50224415e9.13.1727969023230; 
 Thu, 03 Oct 2024 08:23:43 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:23:43 -0700 (PDT)
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
Subject: [PATCH v11 05/29] test: boot: fix bootdev_test_any for when
 DSA_SANDBOX is disabled
Date: Thu,  3 Oct 2024 17:22:51 +0200
Message-Id: <ec9e9d1eff4404d2615e825d2f35af0720c29a92.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

