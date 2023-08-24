Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FEDC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E69E86A6D;
	Thu, 24 Aug 2023 21:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MlFJSec/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD9986A24; Thu, 24 Aug 2023 21:59:38 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B8186989
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-792388ea4b3so7394939f.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907171; x=1693511971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gn7X5Z6j/PtuWnkweo7DGJ7AK7rtR4esR16Akl9Bg38=;
 b=MlFJSec/loRYenPo6GDcy2rL4cwN3moA8P0W08qMyKgbtr0kJnLtNbfIcMcd00IWJg
 rALxVDNHsIYlXLnhqKF10bJ3q0D3BvNvUAk0D6xl9rPtFkeWYt/381VDbMnasctTcMF6
 z9Ymy1S/3lekDLC65/35WLn3LW81hxzTC89sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907171; x=1693511971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gn7X5Z6j/PtuWnkweo7DGJ7AK7rtR4esR16Akl9Bg38=;
 b=PDjayTkPejE3osBN8mtizOwD0P4Z/yGjk6Gyx6co1xFHi5ijcrFh//CmRjNx8BUbkf
 Jdkqx8uRraEcebuf23TA05rbkuY5smEts5c7tRbbKXajHtWCmihaehM69QJxz3imXY44
 znHCf6ADCDI4oemM/JdPrlwiwLOwKxVqevhkI+nhV9AHfUSJxKolPM2h1THlnpgvw86x
 FBOyHnBrCM08d7zpKUhe7EIQFSuIkUCCXTRnCUBgeCdmdknxEO7aXl+/2TGsbmySoS4l
 5m/nMFghlSsZVE+GCrCcJJw9ThAGww3kRf0CP0bbWnn4KekESC2sgv75G8x/RJlwjigZ
 OgsQ==
X-Gm-Message-State: AOJu0Yzuv3L1hrOb4dEUK1sIZ3kTNb+HK/ni/ATzbNwOO7pCr4D8v0zW
 UCPNerJ3ed40aRa1QlYM3tj1Lc1PnHD9pjosqwo=
X-Google-Smtp-Source: AGHT+IHE0aj3+2rfzhs4KMa2++wbQosILGYH1qOV0iKRimf9peE/+uxOKFsJRaIH3RwUoni5QARnNQ==
X-Received: by 2002:a5e:d801:0:b0:787:1568:5df7 with SMTP id
 l1-20020a5ed801000000b0078715685df7mr6858924iok.9.1692907171691; 
 Thu, 24 Aug 2023 12:59:31 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 05/19] net: Move SYS_RX_ETH_BUFFER into the network menu
Date: Thu, 24 Aug 2023 13:58:56 -0600
Message-ID: <20230824195917.1687886-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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

Move this Kconfig option into the correct place, so it doesn't show up
in the top-level menu.

Unfortunately this makes the CONFIG undefined on some boards which don't
enable CONFIG_NET but do include the net.h header file. In fact that
header is included from a lot of common places. So use a fallback in the
header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/net.h | 9 ++++++---
 net/Kconfig   | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net.h b/include/net.h
index e254df7d7f43..f70396c74ba5 100644
--- a/include/net.h
+++ b/include/net.h
@@ -31,11 +31,14 @@ struct udevice;
 #define DEBUG_INT_STATE 0	/* Internal network state changes */
 
 /*
- *	The number of receive packet buffers, and the required packet buffer
- *	alignment in memory.
- *
+ * The number of receive packet buffers, and the required packet buffer
+ * alignment in memory.
  */
+#ifdef CONFIG_SYS_RX_ETH_BUFFER
 #define PKTBUFSRX	CONFIG_SYS_RX_ETH_BUFFER
+#else
+#define PKTBUFSRX	4
+#endif
 #define PKTALIGN	ARCH_DMA_MINALIGN
 
 /* Number of packets processed together */
diff --git a/net/Kconfig b/net/Kconfig
index 4215889127c9..a13ab1d80a0d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -252,8 +252,6 @@ config IPV6
 	  ip6addr, serverip6. If a u-boot command is capable to parse an IPv6
 	  address and find it, it will force using IPv6 in the network stack.
 
-endif   # if NET
-
 config SYS_RX_ETH_BUFFER
 	int "Number of receive packet buffers"
 	default 4
@@ -262,3 +260,5 @@ config SYS_RX_ETH_BUFFER
 	  controllers it is recommended to set this value to 8 or even higher,
 	  since all buffers can be full shortly after enabling the interface on
 	  high Ethernet traffic.
+
+endif   # if NET
-- 
2.42.0.rc1.204.g551eb34607-goog

