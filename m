Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575C7C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571DA88BF2;
	Fri,  2 Aug 2024 15:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D2Nq0pBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB6088BCD; Fri,  2 Aug 2024 15:15:13 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBC788BE6
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso4115506f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604510; x=1723209310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFyvia68oA+yp5hRrErKqUY/G9MdJK7JA2lQKkHbrgc=;
 b=D2Nq0pBSOxxEX1vhLuOZVwz6GqwOp/DgdxsWGkCTXdU227U0aC3zG4rYUxPK2y/Uou
 oXaQbS1y31RrOXL/isTqIODJOZzSemWkPJDxpDAAS6+Inc/W1qgrGj6/Xx17Q07uDzf/
 PVLZ4NNeQ3KtVrMXVgJYGPq7UI0blsP2OzJNfG6xMjJi1YfD9VibXO26hbgTCFyjspkv
 a3ABydBJrO/W/20G2EoX0iU2G6PjCyYALwpncoTPrk/AxYYBoO1g3LRAwBimlBfF+61u
 DoUBlR+bicw2Z/zdX8axSz0WDaFiiU8VPwdBQilq/XDwekzEQHoLJIoWs3UAFhdbREL9
 z2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604510; x=1723209310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFyvia68oA+yp5hRrErKqUY/G9MdJK7JA2lQKkHbrgc=;
 b=SpD5Burhw29eW/61VUZIrYQxP0IuOzgFUGOatu+yPO7qfIniOoWQU5c3OX8SO/aZm2
 a8JTjtALOp/XnYfBrSp40nCvp7sKhs/AvQiNU1bkSwY036hCD+7B94HPWiDU7KjoORLc
 pmBHJi5LDGWDoGDIObkljBIe2X8sAgLBmQzNsC0hOKDDH9uH+wGgFlzjzBflCg+U9zB6
 ojOuKfP/7Vsl+gcmLNtlD8DHvlCBIZ2Ls0PJYMiWvMyIhZ7PEinZoCMk2jo++wYE3Y7A
 v4P/m9M1n66YeilJqSDpXN3X7VFP2hiK26Qfmuz7iOlQC4cVUkDGTVvKwTtDzNYBlS9V
 HAgQ==
X-Gm-Message-State: AOJu0YyzrMSFr9R8NUxXV1lNizrnVcM7OPhuy1CygNILuu5p/NrNuNFS
 UKG2VMoakhm3a78FTGYhpBHIJyv9GTk6AaX6mcm1/PWBfLGxGh8OfdLHnlev4nR+UO41HYT5skq
 JHfA3jlOE
X-Google-Smtp-Source: AGHT+IGPEoOWW8WlTUJy6TvG1KqFKssxvKv7eo3HKlGDEVvCR8L9Ar9d6TujBUcF6Hab5iNRSuODzQ==
X-Received: by 2002:adf:ee86:0:b0:369:9358:4634 with SMTP id
 ffacd0b85a97d-36bbc1090f4mr2432337f8f.19.1722604510544; 
 Fri, 02 Aug 2024 06:15:10 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:15:10 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v6 18/20] net-lwip: add TFTP_BLOCKSIZE
Date: Fri,  2 Aug 2024 15:14:05 +0200
Message-Id: <1b4841717d6e7c19ad779164b562172f7425d14b.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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
index 0e9f2b4cc5b..0a516694780 100644
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

