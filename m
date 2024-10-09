Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B28CEDDA4
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD8D89196;
	Wed,  9 Oct 2024 16:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cAYQ9PyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1641C88CF1; Wed,  9 Oct 2024 16:50:43 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1F989189
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37cc9aeb01dso4537068f8f.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728485440; x=1729090240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5G+9QtFQpBdFjhMWrV1vO4Z5+gjUnIBRwFl+FYgTv68=;
 b=cAYQ9PyUa0uCVoE1YP+jGl1IEOriBSVOakVNhTEyYBJT8w77+E0CyESOx61C2KNdTw
 vlRGUzslXZgNErYbbTEjhTIVESvUC1NRz1k5AQUg2fvXwZDQQaUuCjuG37p1UBcOOBS9
 lhxIdm/Tg9W6dXhf6tFiJkBLgASxKwRvqfmry8CvniyNFplGBnqReFQ19TDSDKP99Bno
 HiJ0656xP21ytTiS0CNlZhgC+OTPNhbWAa4N1vFd1TdtlU+Qt7vaQPggYo8Q1TgwjU7k
 SiThol/IBPeCGx5mHvk8i2xhWJntyPEI1hJKL3I0TcLRmuuZzS91QyCEPzd40UxL8xCf
 /N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728485440; x=1729090240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5G+9QtFQpBdFjhMWrV1vO4Z5+gjUnIBRwFl+FYgTv68=;
 b=VA9PVBYWvZt6WlvU+WyC2D2kJTwSjS5ZP/o1WYMB7C/ZK6LOhKycixWxPtaCxxs5Ai
 WVrLmVUXDxAVCHYGBq36z6bgQUD3mbGF+2YQSXaoy1nlNXmI2kNOd4TvJARpX05IL8NG
 hCk0wsvLdiNkDNqfSpdHGGfnH/gklrczXbbNNoq0whP7zappEfFiLVTi+aUc7y9N1EPo
 Jh8LsS+/MgiJjNHZS7yi9uU358DIUuV8hq5RRMhHBDjORoL1GACPWgOOpmXZ571Oq7Xl
 jXUBFV5xwvKR9lfV1lGtc0FWPdCCVuqw9nN/9sMROwWXlQa76OKy4BN9K6RKQ2+Qcyfh
 ZHYQ==
X-Gm-Message-State: AOJu0Yzh3eOUwKs0FZOV2J+MMvBLDvLUU3uXoYInkFQAPqoBEhGW0o9l
 lgzHz5IbguDsVMvcN0JUTeRLl5ZPguqm8luv1M1rVUMNduKS5x7allnG7/Mki7+sz5qVK51RHC0
 b0utFmr+L
X-Google-Smtp-Source: AGHT+IH93+SiiTEHs2FednmxSvOvVETvkkVlmS43tuTA9oLs29DF5c2CbDK8thafR2u8cgCMR29Vyw==
X-Received: by 2002:a5d:4991:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-37d3aab7873mr1726593f8f.48.1728485440347; 
 Wed, 09 Oct 2024 07:50:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b5ddsm10700957f8f.47.2024.10.09.07.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:50:40 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>,
 Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v12 19/21] net: lwip: add TFTP_BLOCKSIZE
Date: Wed,  9 Oct 2024 16:50:00 +0200
Message-Id: <faa422f4ae8cbeec2ac339d1959085f0d1fd6441.1728482473.git.jerome.forissier@linaro.org>
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

