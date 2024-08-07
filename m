Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522C9C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB77588D7B;
	Wed,  7 Aug 2024 19:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FYaqA6u5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA04388D46; Wed,  7 Aug 2024 19:13:27 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF38A88D56
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso50844f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050805; x=1723655605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIupqn8gZsJuV8zcCyN0aoIXkIlH+B0Qni9GvTETpug=;
 b=FYaqA6u5sNufwPkGmXiWeDwgLgbJIlS1XdDbrNbpINubmQFfgeu05G6Af/Lc3hEYxE
 xMdU/z22SFmS5ELQDQOrggQAwg1eIBDKsZT6rLs9G2Hling15cHxiQ4s7lOV/wemaFsm
 WY6RQfEOPmk9PCdGzS56AHBJVog7vaX6GCo79sLcueHuO+/HR4HZJdfaz9IgJfXfbJy2
 lwnaG/LaHbUsiQT52phtrlNk7tCEUvDdheRkWuZcg3rWTootXAFJ0cwjpql7f5YbQnq0
 +B3YW0CkNDg5SHsHlCiooEay8fi0dAz35q07Bt9FjREjC7j9a9MlrEAjYMvbyL6P6OzP
 V8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050805; x=1723655605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIupqn8gZsJuV8zcCyN0aoIXkIlH+B0Qni9GvTETpug=;
 b=X+xAg0W7LGnodPsB4umCWKYFyqv1Sdmq4ndAple1m2qzJK9uX1tCPa68oXGXJQxPi1
 +oN2ztCm311MbJWXOk3vYbq3awX4S2zYd40+VSVwIWQ1g8VDN/ExIefiX2xiCHm5xmDj
 2Z5QLmgYFr8h5Csd9JQZS+3yZaA8LDtcjjRJnKdvH7bCYHZ5Dre35UE35nq1iDt33QoJ
 lBhKStPnsZqjkUavnaqi9ykAv37yf2lb0tuH6hKpq+0Ox7Tn7q7L3Wrwrb2KiWLTBqUj
 daoRO6FuLvhSXpcOeuEGAN3KRIxBHYqSF+ZUCGM8DEAoWGiVEpCPsJPT8uD7QaFzdppL
 gR/A==
X-Gm-Message-State: AOJu0YzhPSQMOXu4atIJkRe9TGriy3cppThadedlasgUGwN9atXFQXS/
 TbwMggPiLImfPY+LOe8Jze8gwTZl4J1BpsrImiHuxV95NFtc5PNXZAz9LPvMa0JPBe51BCps48Z
 6W8uz9eWz
X-Google-Smtp-Source: AGHT+IG87vtb5O3UQpmOvRJfccN0a8d65hsaLRU5yLKVjW/hkQ9yCkZ2dypQ7rQsAKqcF/Pk6rGVYg==
X-Received: by 2002:adf:fa07:0:b0:368:303b:8fe7 with SMTP id
 ffacd0b85a97d-36bbc0cdd5bmr11485932f8f.7.1723050805114; 
 Wed, 07 Aug 2024 10:13:25 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>,
 Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v8 20/23] net-lwip: add TFTP_BLOCKSIZE
Date: Wed,  7 Aug 2024 19:12:04 +0200
Message-Id: <bd212457062dc316cbdc1c99690fc5adba108717.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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
index 06986d10b22..8bf23d127fb 100644
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

