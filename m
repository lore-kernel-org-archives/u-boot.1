Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C63D41D47
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D26FB8931C;
	Tue, 12 Nov 2024 03:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J3K8e1ly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4174B89395; Mon, 11 Nov 2024 22:09:13 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F84589308
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso52894315ad.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359349; x=1731964149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P63Vsgtcvl2TudwahpTpDUIBZwb2CA4sfIhYo+JwR30=;
 b=J3K8e1ly1ZlWyUzPcBzC7RbVaEHI5dJ+3/FhkvyRtj8nRbbkRA4dXEVTX26ahcSGb7
 c3rrUI+KdeNiLN47T5xMZm1p9FY5smsMSa5JyYKvB8osiEwdGYgLyGObQqssibddYQY8
 zyK7DlagCoU35mbs8qzoK668IaAU5/Niplo+lYaM5vdDo3jNEI4eHQmaHmo1nZTU5Yyw
 +OeuGs7wQCc6Fj6iOsK1PYmnW5NMljKyZsapIFG+Ej7dNt8e60xyno0u2agWNKsRpQDI
 I8fhgmFPTvq5lHdB7NvqiF2Hr3tZR7tcRXfY0zGzIG6i5FWmwjy7TpNX69pX2kFATZHc
 DbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359349; x=1731964149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P63Vsgtcvl2TudwahpTpDUIBZwb2CA4sfIhYo+JwR30=;
 b=nnueqD1lvsR1sD7DtRlMw1cHUlkdOHmg6c3HMwqZBG7zXrr8YuEw/rfBUk8LyyhtmK
 qOGjKMJonaRn4JnXc73SIesf8eYe0Q+U1B4UHIKgTuCJOi5xhBfZRcLdLa5w2+8Ewxcc
 Z0sS8x6ISd6QHmEPaggIjA8wU6wrAK7ttBkBIkffylb1per9Hr7hsILlJQcVy39DI+yt
 Y4FAsNYIi3aXuP9Htyza6CT0cjyHtappxpkbtC5NAJnkYiIymHu5iE6vFseWe0bNGRCE
 /3B0yeefhisk6GOrDcWpC5Qrr2z/sWOABkJy/LN7dW5T6yKN99WFFp4AsOAng+Bk7axB
 sI1A==
X-Gm-Message-State: AOJu0YzqHvWZk0bOhUxZ+CIAtHEhKkFCmyQXUjKt98zlaOMyQTlmmdEk
 UrNVgZj5qsP3GFhea9coXKOaQMaAO/WdmcFAcmrQ8UbnqYxmMa7LnXP6CUhh
X-Google-Smtp-Source: AGHT+IGjHU95/KK4278ufIczRqxL7wd8F8cGlf34bu48C14VroWwu633OtSAmZ9HS1DOjrYSPpR6Pg==
X-Received: by 2002:a17:902:f54a:b0:20c:b485:eda3 with SMTP id
 d9443c01a7336-21183cbe6a2mr162677885ad.20.1731359348831; 
 Mon, 11 Nov 2024 13:09:08 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9068sm79807415ad.2.2024.11.11.13.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:09:08 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 1/7] net: Kconfig: add CONFIG_WGET symbol
Date: Mon, 11 Nov 2024 18:08:55 -0300
Message-ID: <20241111210901.560691-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210901.560691-1-adrianox@gmail.com>
References: <20241111210901.560691-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

(no changes since v1)

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

