Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA30C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9013A87E3F;
	Thu, 25 Jul 2024 14:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tFcOjH0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E0E87C38; Thu, 25 Jul 2024 14:59:12 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6B086D4C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42808baddf9so3183245e9.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912347; x=1722517147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvW3OZyLlgGhViWdAZgyIdV+5Tzq1NS7JKnwkn1M2EM=;
 b=tFcOjH0dbX/zK9Nv9N06nEfysa2sfs6pP9d1hVx7w8V9LXWGspXyNb4adYgz51P26C
 EcpuG8j1ZhbWHVpZ4hNsl6rakAIOuxO3qcbU13B4Ce+IGP6ztfAVRfHVU7MyJoLguBFZ
 1l2jtZUUXxituUqcKUlxz2uy4MoNdhUgzUOXNGe8TJSVT+1D2T7tHVw2p4aes1qjJOJS
 pa6rW4iUkbLu7M/nu8QVwCkNgyCWfchwt+0cskXfY/lhH67vXz9V2N8uGN8d3H+v3MR1
 nq3LVPhzp8I3fREIIfBAtTMOBvkvB+Zep8LsH1iGVymfa0EuRId87RTkjmFY1vNvdYvV
 1D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912347; x=1722517147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvW3OZyLlgGhViWdAZgyIdV+5Tzq1NS7JKnwkn1M2EM=;
 b=sLUzK2VBoI6fqbw9Rom9CQGTYQry0VrvwRJxiNqBagpkOGJARABVwQTl4i5y/KGHzu
 AjxARVNRNbzOIEtTT2NGXXQoCRKjwAyQp//AuqW7xLs9UKGGtmGJ33yQzHGxs7TDcqTk
 HR2tRCSFbfbX6A+3QOb5a6owhNMUUbDTsIowKLmGRpXxpeVbdwH2KEGLpQfmgDmcL4So
 nH0lJ/L4fTMH4I4GSguMHehXVET83oQFzvKvizlXu/cganCmRLRl0HFSOkyTuEn2fV8W
 VDG1YqA59H8ZKgpsohiSturfx2Af+Psr8DmSkr/Mk74wFPfmXIH3222swTQPY9HopqYW
 ikag==
X-Gm-Message-State: AOJu0YxUn0aRAFvVrnMWJ8jQRzHhQwuQz54tmM2uSXL435JN3WOKA4iw
 605+lEHxenfe7lziAN+X0GvHfUqSECxtqyU7acYPHgfcFLnUbQ1NpenOcZGBLO/7O6qQlbqGmUW
 ltzbvsA==
X-Google-Smtp-Source: AGHT+IEqaSzqo8x+9x1/wdmSAE/3Cc5m8D+G2p5CnRmVSG2A+IXFx4Ur7hwCZ9Izd4Mf15LvQlQ6hw==
X-Received: by 2002:adf:fd41:0:b0:367:9c46:198 with SMTP id
 ffacd0b85a97d-36b363b2ddfmr1585704f8f.1.1721912347656; 
 Thu, 25 Jul 2024 05:59:07 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:59:07 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v5 18/20] net-lwip: add TFTP_BLOCKSIZE
Date: Thu, 25 Jul 2024 14:57:39 +0200
Message-Id: <4dee5a89157f3dd0e0a8d17ab6ff42292bb7ce79.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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
---
 net/Kconfig     | 20 ++++++++++----------
 net/lwip/tftp.c |  2 ++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 952690d677d..7e5406bb923 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -69,16 +69,6 @@ config SYS_FAULT_ECHO_LINK_DOWN
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
@@ -263,4 +253,14 @@ config SYS_RX_ETH_BUFFER
 	  since all buffers can be full shortly after enabling the interface on
 	  high Ethernet traffic.
 
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
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 78de0bd0dba..1fe948c84ec 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -136,6 +136,8 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!(err == ERR_OK || err == ERR_USE))
 		log_err("tftp_init_client err: %d\n", err);
 
+	tftp_client_set_blksize(CONFIG_TFTP_BLOCKSIZE);
+
 	ctx.start_time = get_timer(0);
 	err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
 	/* might return different errors, like routing problems */
-- 
2.40.1

