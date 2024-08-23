Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A7FC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E158C88C15;
	Fri, 23 Aug 2024 15:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Srfv0ADQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE62688C6D; Fri, 23 Aug 2024 15:50:12 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F388E88C13
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3719398eafcso1043388f8f.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421010; x=1725025810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5Ti40FD60twAqgTogRIah0zrrRbOJ+6aN+DRYhjcLI=;
 b=Srfv0ADQMWrxUDvTEvjlS2ps2Mvm+f9/T9YgUyAWaMixc3qngAMc7EuSQsT66UF8ei
 1X55UU3iKefvJmof+5lu0rs8ulq7hvDG4ge6eUnnfQARV4XtGHBPiq7wz2VOuBZ11Oy3
 FwlnNqWIm33Fquwy1UUN0mFvxfNkG6bmyg3joprT7xxz9Np8OSE62HF+rRYdsi+J1Ky3
 GDMeaUl2IZamy6+RMubmIlruBLJTUbv2YOCp05zw9ofOVmdqBeJaITYh9O9SE/xiLyEw
 YBh50DnK1FD/moSaA21RjOcjQUZ8JIMIcm9anW44E39VyZU2OPWsQc90kopwWLJMa38v
 CtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421010; x=1725025810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5Ti40FD60twAqgTogRIah0zrrRbOJ+6aN+DRYhjcLI=;
 b=CorjnwZaAfIC9OPVkF3ToOnNvJXTTJ+8JZ7Ei9Uzn4aRjhHsIaylAdAA8wHm0/MFQM
 h8hDrQ/9TglXwCbv9+kJfJDro62KPD3fvIlVPspOQaqi2g2Q9zxaN59PtendGYtYSHI5
 P2BX2NwWZHqEfJhpUIKOqhW5RCPBPEGl4haVffWkFvcoQOaonmxpp9H7ypoZrsfaokkv
 hOrJd6WQlyxf/u7FhLDJ+Y4MtMh1ZeV+Y2ZwWHobg7ZNLe1ZQydFg5xhp46fWIwGE4vo
 lkm0Lt1ZTgfeEiOArrE4QkYJpaj4N1yU4FMAW26ki94wASuSXEpITrYgCFJEx5ZAu4et
 4PVg==
X-Gm-Message-State: AOJu0YyvEOXdZsChA3/aqE/pdNn+rA23qPMSoA3MK1goQazo/kDEatcX
 bxDyj3bkkjK1ZsFlIzaCoIv8pFUDjgqnjLi8Uby3ZOJ4erUceMnWsfDf7m1AT2ceyjYa0FNYGpg
 jzwLPCLbH
X-Google-Smtp-Source: AGHT+IH2bGzWMTQN9FnuUAX9z/UBBprzuy/LmDZ/j9ZncxsLvheN3h+K3AenBoITouSAB56lP5g0pA==
X-Received: by 2002:adf:fd41:0:b0:367:8a87:ada2 with SMTP id
 ffacd0b85a97d-37311876fadmr1505479f8f.26.1724421010155; 
 Fri, 23 Aug 2024 06:50:10 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:09 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Baruch Siach <baruch@tkos.co.il>, Simon Glass <sjg@chromium.org>,
 Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v9 30/37] net-lwip: add TFTP_BLOCKSIZE
Date: Fri, 23 Aug 2024 15:48:34 +0200
Message-Id: <86cbe8adc7cd7130571f5b4d4eaf3828c222d6fe.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

