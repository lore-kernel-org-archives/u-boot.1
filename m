Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D25CE7B05
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8458088D1C;
	Fri,  6 Sep 2024 14:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XUyLA1hM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E867688D2F; Fri,  6 Sep 2024 14:35:22 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC4588D04
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42bbf138477so17070565e9.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626120; x=1726230920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5Ti40FD60twAqgTogRIah0zrrRbOJ+6aN+DRYhjcLI=;
 b=XUyLA1hMQi5msT/FC9+rY9tyzD7j5ghe6kfR0BZTl7D+ShTUCN4rUuptJc782cssvV
 SW6cFUceSEInXpQrP3qOwgHHikr5pEGvSAYNcSBJ1Q2rselW+9VaQ41VYg2AyrK160kv
 wcdne49oqRFBx3xpVk9n9fi2BOOEU8HPXhJETfoni7HYxG4yJ0N/ZQDsGlcwErRpyRfK
 yazaNccLfK2l/Pj0WZpvefeRrELxM8JbmpoDY+fcrjn5ZGl1DFk8BPEI9nR0Ht3Pf8Fp
 UVz1H5yUO6AogHSCqPC2MeQxUFIvkvcGTI8h+JbTGJwffgEQZrMYjWWf3wxyTjrz1vLC
 zGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626120; x=1726230920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5Ti40FD60twAqgTogRIah0zrrRbOJ+6aN+DRYhjcLI=;
 b=FpLeRS/2OHGaRdp8u/vkm4upMcPkauw/4jmVx9paZCXxCvvXSrZDXS1roVB1e6BCGh
 b5AS/uaL/P9MJm3sUOJ9Clek4m7nTTx74wqwJYMHAj//SBeofqe5S2Ay82jgbE2lrNot
 ACBGxBmI67Vx+jr46feDuk4yR4gLmJbTrMyfVIvhEC76vtN7RlH/82IQv7yad5FpxNVG
 bBsIkDkxKzhXYm/8fUWw3+5MtRebnRjDosBy8S94bhLkfFfYFHTot7zmQHs7pEXEOTTy
 N6k/3mXsV1qQ7Mrk4GZimgbw2XdN0zMJavaHBFRdaWoUF2dI+9eMhX2+JZIPID44N7zh
 7YWw==
X-Gm-Message-State: AOJu0YyUkVAfxN77u7aIo5VKb6DkGqbDSlmQQYOrhWe9VBPGAcHU8QTE
 ykffKiD455GWB3IeA3grdczqv1aYHvfab84xThKFoUsgp5gX4qgTWQrq1f6gkgksGIK2rBn6D6X
 g1UWzSN16
X-Google-Smtp-Source: AGHT+IEYh+j/iC5rBWcJ1HKKqAaUkDzFsZiM6pi88ZSn0ath0hlCmQcM1P2I2+75Ewkjs2HrsalHIA==
X-Received: by 2002:a05:600c:1c01:b0:42b:ac94:692c with SMTP id
 5b1f17b1804b1-42c9f8eede2mr19209765e9.0.1725626120302; 
 Fri, 06 Sep 2024 05:35:20 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:19 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v10 18/25] net-lwip: add TFTP_BLOCKSIZE
Date: Fri,  6 Sep 2024 14:33:34 +0200
Message-Id: <318048700dfb511c4634505adb1e95ce8be189c0.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

Add support for setting the TFTP block size. The default value (1468)
is fine for Ethernet and allows a better throughput than the TFTP
default (512), if the server supports the blksize option of course.

I tested this change with qemu_arm64_lwip_defconfig. The throughput is
now 875 KiB/s vs. 313 KiB/s before. That is still a low number, but I
think we can't expect more without implementing the windowsize option.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/Kconfig     | 20 ++++++++++----------
 net/lwip/tftp.c |  2 ++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 16a9de47e94..76ab7d91eeb 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -60,16 +60,6 @@ config SYS_FAULT_ECHO_LINK_DOWN
 	  this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
 	  be configured.
 
-config TFTP_BLOCKSIZE
-	int "TFTP block size"
-	default 1468
-	help
-	  Default TFTP block size.
-	  The MTU is typically 1500 for ethernet, so a TFTP block of
-	  1468 (MTU minus eth.hdrs) provides a good throughput with
-	  almost-MTU block sizes.
-	  You can also activate CONFIG_IP_DEFRAG to set a larger block.
-
 config TFTP_PORT
 	bool "Set TFTP UDP source/destination ports via the environment"
 	help
@@ -254,6 +244,16 @@ config NET_RANDOM_ETHADDR
 	  generated. It will be saved to the appropriate environment variable,
 	  too.
 
+config TFTP_BLOCKSIZE
+	int "TFTP block size"
+	default 1468
+	help
+	  Default TFTP block size.
+	  The MTU is typically 1500 for ethernet, so a TFTP block of
+	  1468 (MTU minus eth.hdrs) provides a good throughput with
+	  almost-MTU block sizes.
+	  You can also activate CONFIG_IP_DEFRAG to set a larger block.
+
 endif   # if NET || NET_LWIP
 
 config SYS_RX_ETH_BUFFER
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 50b8fbad00d..51cd1e0207c 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -138,6 +138,8 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!(err == ERR_OK || err == ERR_USE))
 		log_err("tftp_init_client err: %d\n", err);
 
+	tftp_client_set_blksize(CONFIG_TFTP_BLOCKSIZE);
+
 	ctx.start_time = get_timer(0);
 	err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
 	/* might return different errors, like routing problems */
-- 
2.40.1

