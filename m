Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F448C52D6F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778C588C19;
	Fri,  2 Aug 2024 18:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iDwGiyOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA4588BDA; Fri,  2 Aug 2024 18:28:36 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA7A88BCE
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368526b1333so2069341f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616114; x=1723220914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMonADCFkYBkdZiETOljKnqrydSlaLb0tgjLLX28Kzc=;
 b=iDwGiyOhLgxkKWxNOjeNhdS4Khew9bp2jANb+yTiGQKvp8k2BuVXEYLuarwW35cc96
 SksQnnoT2Ls9YHx2WaGJwT+k2CvNsbQpihaBl/zhXsGB0eBnixqtW+2uG0VX/CqdRV5U
 PizpxBMyou2wgZYIE+1SVIW4E4C26YjQ3uI62f+UYGyC7/3OLfaTac1GX4V4h/CLQ14b
 DCX3szmFt7CeRi9hPJ7GItW+3iTtLRPyPZxhppuH2T/7HoOHf8vr1DHYr6FSWqeV1Tfm
 kKQKa+x3AoDSdahA9Fu5akpY9HQIuD4/f8BNe0O6czSfu1oKVMipcDL7o4Uj6G97uw8F
 Y+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616114; x=1723220914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMonADCFkYBkdZiETOljKnqrydSlaLb0tgjLLX28Kzc=;
 b=FPNQ01Uhripuv965Smk1hOOb93GxklEWQz95uqh30arpPGcW2Ha1fVqgP0HnBAs+zs
 lWw5J5NMncfcA0F2OgRXWmpBHvvdaeixYM2Q0y3Y/cDo89kqcu/lkvJ5fw6iU2HrJudO
 LqEOOXBh31OoaV/73hW4fihXKBQXR88Gd6p1cO0j8egO6GTna43YL3muXHvP2xrur8X6
 8Fx5UPY/S6+xoC0yJZDMu2JyjX0deAJKZ6C1yKlUBlCVp6zpsnfBv7zj5Zhw3j3PVPJ4
 0hN8uPcG7++vpF/RvUppllbVJie4nyA4plrA+0h6BNWG97v0/5IKMdPDMvfnCQ3/0iJV
 ozEg==
X-Gm-Message-State: AOJu0Ywq4vf+n64+IPSwjtNxxQ6Qzl2wDgPFhI2eg7utBQhBTN+Pvxif
 XDJlxbY3ehBxRlz9se29jcbJVPlNuVjeL9SYW3zOx4hHdngYXSQpk0CtmxzwIM5AsHuofWVKlZW
 sXMwV8grC
X-Google-Smtp-Source: AGHT+IETzz7muF2diy2xQOIfpbGsTvn3GXNDgnSauijTI/eJTYyemxz2qOWUF/GN08Piu5oQRej14A==
X-Received: by 2002:a5d:6d0f:0:b0:367:940b:b662 with SMTP id
 ffacd0b85a97d-36bbbeefe1cmr3388897f8f.31.1722616114266; 
 Fri, 02 Aug 2024 09:28:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v7 18/20] net-lwip: add TFTP_BLOCKSIZE
Date: Fri,  2 Aug 2024 18:26:45 +0200
Message-Id: <b98b031277bb98a39e6b4521e95082d5832ddc2b.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

