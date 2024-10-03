Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF05CF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C184388EF7;
	Thu,  3 Oct 2024 17:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zh+KgQvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0D688EE8; Thu,  3 Oct 2024 17:47:33 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 950E688F3D
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cde6b5094so11349385e9.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970450; x=1728575250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5G+9QtFQpBdFjhMWrV1vO4Z5+gjUnIBRwFl+FYgTv68=;
 b=Zh+KgQvPS9qXyjUYV/rKdHE5VwXnaNoaJrvVPYxNI02B8SUXxZLihk91ClFy2sAHQv
 rRpNUaJvCQcGpFujeI4K1sal7lE7yWplJ8vnIH3NXgvs63BSNp05eshtLh17s1Nzm/q6
 WK3mZRnwhXz03+Bp5mT61VYtw3SigcoWsilgJdgeN49xToxPr9ChcW/xmQ+o4/C60Mjp
 lgGFyz3mNptvZITxiHLgZCRWA/R3Ulur+cyjWgU0r2BoM8H4kjAShQ5vXJMc9AXaRh7q
 /0KHzbn2w/LROFYaEOMV8hxgFF0yoxxGkdEH20q7JumglF/j4PZfBQM7CFR3WwxoV69c
 ZPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970450; x=1728575250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5G+9QtFQpBdFjhMWrV1vO4Z5+gjUnIBRwFl+FYgTv68=;
 b=Lvw4tRlb8j7F0twAgpjmQbNOXbuS68+sdL1eW1WE117zf0FHzNVLozgmbtqG/4VDwL
 FYJbzOpQdc4PyxCU8Ee0HHHExuxXEy2R4EqCRMlF4XviGGjnNhfHqSpqKagNZb/FxrQz
 uH2NOxBaL6uGUiey50/rGjP4o+8lnB4mz0/eE1uU/vQH+5JazqUrhAXHf4FJlQaEWu5A
 fg0F0UN1Bw75SSZN8I6A8Kqal6VLWDUhSFjIDpChE8+VS6gtkNjWX4bwFMLypM0Ntymy
 61WMW1PBcwHG3Od9E58Nttx2SqP6xVkmexCrMcZz8YKI3Ag6AQxJIEJ08Q6jQWNiV1tN
 zLsw==
X-Gm-Message-State: AOJu0YwvNi6hSHeybVe0w9kOhBATI3QHPvkLyo1UdUBU2vz2BXSiotaX
 S7ChAN9IBmroCYW2msA3uZpPfgym2SUpWUeEPzjZJDsGh0reZoMUwzEJvpr92dxbUcu8PeiPr71
 PQjX0ynvo
X-Google-Smtp-Source: AGHT+IFHEjzMwroVxqvAnh6sFxdhuwXbLfpYxZJ0us4gFLOdz5otkC6mKMHudVp1C04M5GNkLifsgw==
X-Received: by 2002:adf:9bcf:0:b0:374:c847:83a with SMTP id
 ffacd0b85a97d-37cfb8b536cmr4373984f8f.8.1727970450523; 
 Thu, 03 Oct 2024 08:47:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v11 24/29] net-lwip: add TFTP_BLOCKSIZE
Date: Thu,  3 Oct 2024 17:46:28 +0200
Message-Id: <ca30b1dfcc06e695ffe1b6e33e60fc0ed72daaa3.1727968902.git.jerome.forissier@linaro.org>
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

