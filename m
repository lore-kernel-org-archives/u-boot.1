Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F56D44D75
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A400891E3;
	Wed,  6 Nov 2024 15:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E4QDFPga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1766788C7C; Wed,  6 Nov 2024 14:03:04 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E9A891BC
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71ec997ad06so5388101b3a.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730898180; x=1731502980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZlPUz7aCKgGULHI6YF2jOoKlukgWCucAuSDsUlQjlQ=;
 b=E4QDFPgaKKZXKVLKRqzRQI1DYt3xWwGIY6TD6dkIZA7qJFSMHMSxgDkw8eYEdJA+ml
 IUWHzvWztfFlCJUKpXWHfA7elXtEkNak78uPtqzLmufT9dUbjWf59I72QcwBVLJhAy9k
 Ch8U+QlpQ1D/a0y6ko5SXRbfdUDkb2N9G4rkNJXLq2zrs9zN7FvtX/2qLS7gyCAMT0E9
 0lk2QUzdzaAsS9aRY7xnYF26UqcxCs5NZfMy1Uf0nAoguUcWov3dlx14mHOOeZV9XGes
 3an1fedw/dRgLBG8gJagR+x/g1C2oUNRwJVrm9I7Vrt/pQpalpv3313VgxxzhRHij3f0
 BTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898180; x=1731502980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ZlPUz7aCKgGULHI6YF2jOoKlukgWCucAuSDsUlQjlQ=;
 b=fjLleFK+QklLdfjJWJSTxQ7siXjgKaJJ4E0PNqUqrN+vr72IBYCX9ZOABqd/+6HdCU
 ULRlVlJ5WPzfWKuvBIevdUlDRqTTn1yRJPdtfHeAzkbwqEL+gWkK6hzcYJsTmChmYgEV
 IZiLL8hIa1yMPJoLwwUKTnD0Qh3x/XO6y3W4zKmHlgZ5eF+UL0pWgvlYkZC9aSiKgNbR
 buUkKAK64x0acbpPSCsor7EGXRWJgR7abt12S+BECgTwf2SqopVjOkWanvlvAzz0CYXe
 a+Wjv7ly4EnXqZevtIKVlxDbpmjlvWMf3NNmTZGQxnkAeOcO8zi2OyrB9uEf+tAUn8p1
 LDaw==
X-Gm-Message-State: AOJu0YzOPVKwcSjEfRhZuoR1cTwASqHoAF/v+hJohXiAwhDUUoH8dc9q
 yHqJQaKenpgNiWg234KVsKlLEi6zniiNAyDoMOwZNWzrbB0ATQIAo4klfM9Ia7E=
X-Google-Smtp-Source: AGHT+IH/YZqQZ5OUd3hZu1BlF3PDNhZgihFHTyGbJGeYeK7Y7wyhs0KIbGqdvUrIVYlFXTaQUCaqcw==
X-Received: by 2002:a05:6a00:4644:b0:71e:7636:3323 with SMTP id
 d2e1a72fcca58-720ab3babdemr34706090b3a.7.1730898180248; 
 Wed, 06 Nov 2024 05:03:00 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1c9fd4sm11650134b3a.22.2024.11.06.05.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:02:59 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 1/7] net: Kconfig: add CONFIG_WGET symbol
Date: Wed,  6 Nov 2024 10:02:55 -0300
Message-ID: <20241106130255.211041-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Nov 2024 15:13:43 +0100
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

Let net/wget.c and net/lwip/wget.c depend on CONFIG_WGET, and
cmd/wget.c depend on CONFIG_CMD_WGET. This way, the wget code
can be used regardless of whether the wget command is available.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 cmd/Kconfig       | 5 +----
 net/Kconfig       | 9 +++++++++
 net/Makefile      | 2 +-
 net/lwip/Makefile | 2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 636833646f..8f3ad94089 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2115,11 +2115,8 @@ config CMD_TFTPBOOT
 
 config CMD_WGET
 	bool "wget"
-	depends on CMD_NET
 	default y if SANDBOX
-	select PROT_TCP if NET
-	select PROT_TCP_LWIP if NET_LWIP
-	select PROT_DNS_LWIP if NET_LWIP
+	select WGET
 	help
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
diff --git a/net/Kconfig b/net/Kconfig
index 76ab7d91ee..b4bb68dd61 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -244,6 +244,15 @@ config NET_RANDOM_ETHADDR
 	  generated. It will be saved to the appropriate environment variable,
 	  too.
 
+config WGET
+	bool "Enable wget"
+	select PROT_TCP if NET
+	select PROT_TCP_LWIP if NET_LWIP
+	select PROT_DNS_LWIP if NET_LWIP
+	help
+	  Selecting this will enable wget, an interface to send HTTP requests
+	  via the network stack.
+
 config TFTP_BLOCKSIZE
 	int "TFTP block size"
 	default 1468
diff --git a/net/Makefile b/net/Makefile
index 209377aeb2..7c917b318c 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_$(PHASE_)TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
 obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
-obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_WGET) += wget.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index f2558f8763..79dd6b3fb5 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
-obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_WGET) += wget.o
-- 
2.43.0

