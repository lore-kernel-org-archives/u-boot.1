Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE575D1AD3E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A9589024;
	Wed, 16 Oct 2024 12:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YZudyCAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2300689043; Wed, 16 Oct 2024 12:05:15 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E0688FCF
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43140a2f7f7so14955765e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073112; x=1729677912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5G+9QtFQpBdFjhMWrV1vO4Z5+gjUnIBRwFl+FYgTv68=;
 b=YZudyCAfJOvDLvDMeoQv1aCH0N/O8KmTz+TPs9AaJBMbLQSQQyMj8wtUcZmDLlHxtr
 GVkU3yaBwe+VAkcF5we7eOv65eW7nDPHKViczbaE7v0j+FGf6eWGk5e85AGnOwucAy9I
 Vbv7qCZ2Cw8unQipONzLuFSZekKZjbc2XajkXql0++WaRMJPoNFlZQBNVyYbD8Gb7rQ2
 muCm+i+55MNoZ/R45UDtqZfBtZ37pwYFdTLgbTkPzbwuIr/TKjFiCCWW5GIlncgN/0CR
 hdjHJas+PGWFM6DGx/k9uo1hZdNQv5KwZt1tj3k9YuiBjVE0fZPnVErOO2y4qj6g4BDB
 hyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073112; x=1729677912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5G+9QtFQpBdFjhMWrV1vO4Z5+gjUnIBRwFl+FYgTv68=;
 b=eqz1aSJrHwub6qBxk7SriuHW2bV5RNnXjFWxWWG1X327I3ptBwwFcZmqcl4XIHLcpd
 M5DOHvAkh8yptPRNiuT1/taouaYlEU0GSDMrUXYlz3kv7IykgOMfveUqsAGSEhBteMf8
 SrLTwQPlemADmP5gtK/11C/U27xn5mYJqI+mRy2n55AeXTbYSliHda6bDXXCpjv2d4SP
 lmWLcEBHMW+h1aNHZYAANDMd/e/ECtcqvmh2J07yzwi3MGH0PPDxUjyLxgiyCpbZlTrz
 fDebIl3vy1XngmhIovhHbjgFmnpAPkEmrtdlkOnMJ/omwEjvAEhtiMk0Z/+htaWsu+H8
 NTfg==
X-Gm-Message-State: AOJu0Yws2QpkimhgFh2pvLxFLnGVT/sUDR5mCly53XvFXvm/CCcEYSod
 Lk4fLT4SntvYJY3nodWo74s1srY1Xu0InGYC53TZBTxt9cI0qU4CSbnAfNOfkxWoSqimaFEPbka
 T1mqu5mlu
X-Google-Smtp-Source: AGHT+IHZzMFBgFVLEBX0niwC/Z+96Yopb1QzmrmVxVrRXVJ0HaD/M0fOd+ePfzEv6PcZSb6Od1CZVw==
X-Received: by 2002:a05:600c:348d:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-4314a283c84mr32736995e9.1.1729073112357; 
 Wed, 16 Oct 2024 03:05:12 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:05:12 -0700 (PDT)
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
Subject: [PATCH v13 19/21] net: lwip: add TFTP_BLOCKSIZE
Date: Wed, 16 Oct 2024 12:04:13 +0200
Message-Id: <73f71d0e474d581a693e980ab95beccd23e8f646.1729070678.git.jerome.forissier@linaro.org>
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
index 26978643313..f4d0a6aa19a 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -139,6 +139,8 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!(err == ERR_OK || err == ERR_USE))
 		log_err("tftp_init_client err: %d\n", err);
 
+	tftp_client_set_blksize(CONFIG_TFTP_BLOCKSIZE);
+
 	ctx.start_time = get_timer(0);
 	err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
 	/* might return different errors, like routing problems */
-- 
2.40.1

