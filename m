Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B478CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6B886E4F;
	Thu, 12 Oct 2023 04:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="igZ78b4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4CB86EC0; Thu, 12 Oct 2023 03:59:39 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D7C86E69
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-66d0ceba445so2805366d6.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075804; x=1697680604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFBvNGiRBVrGSy4pKBGElDLBRNXx8tGH7zTLsTFx2lM=;
 b=igZ78b4Zoqzhmtkq3+X6beTwOmOtSzYlVWW+xzAvoHuqUWJi1syqjhwoQaMF4rtjc/
 8QuRumnZRK0E+8E8zJ8L4zwD4is6d5fTuQU/eOgLE9jTUfIULAbuH1Ia9TRk3cnJTSd2
 1FQ4hiJBo61KeAagQYIrFydhQTAq9NhFJI3cCtqVGBnW+LNPlrU8kjxJZ87PAgG1m3Wv
 gfO2vAdyEq+GFsdZl9BCmPvxWUPcWaiqYB5HGeSaHL/Rtn8W0V6ZDOK/WVORPNQclPGj
 vBbqo6JwC6dwbu1j9wgQUqQ63Tf4hMBZpJw9eKdGFE95PntViuygEeKJno2N/ejH2os/
 ok3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075804; x=1697680604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFBvNGiRBVrGSy4pKBGElDLBRNXx8tGH7zTLsTFx2lM=;
 b=W9Fm6pTfZ+OFWncDoWuvUJ/zBL2YjBwxmbfVJvU7lkADYBtG+CeDzVmXcaUOCnwxlq
 /ERMRzGb5lv+L8j7huZB7muIbi6N0hKVb2gy+gUYl1YSHbIaR5IT5gJ61jC9WKEJqF5D
 jspvkRx7el9BJcPPdqWhuya15pjDnFTlWgFfGkRcLUfsr+S/gGJKnxJ2ooJw85DP1+/K
 YTsYKvtM4KyFnhnLBUPqp2VTPhuXsMhMKUznYgZ87PYggUxsv8hQjLrLeFbtVvTzWMj1
 n+siKim2+us/oMBjznHQRCXuqRKEt+cdkf4MnGUru6d6UrvnCMi83U0EOFuisCjHGO9F
 zFHQ==
X-Gm-Message-State: AOJu0YwxRKP/UpGmOBnlQNgCqp5y3HhPse3Tp8Lns+bA/nkYEXARbKDL
 ac6g3B0tuyf1wr2lFp7AODD2hAK68xziVA==
X-Google-Smtp-Source: AGHT+IESWzzLc8VQu9wBymfIvr5m7eZ+x2ZwLEWCF21KlMp5wm9e5aGmz6vT2YbTyAhJSZvOwcH1uQ==
X-Received: by 2002:a0c:f4cf:0:b0:65b:11b3:6ef5 with SMTP id
 o15-20020a0cf4cf000000b0065b11b36ef5mr19945053qvm.17.1697075804217; 
 Wed, 11 Oct 2023 18:56:44 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 l12-20020a0ce08c000000b0066d0f35554asm587541qvk.79.2023.10.11.18.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:43 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 13/26] net: Fix compiling SPL when fastboot is enabled
Date: Wed, 11 Oct 2023 21:56:13 -0400
Message-Id: <20231012015626.3487451-14-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

When fastboot is enabled in U-Boot proper and SPL_NET is enabled, we will
try to (unsuccessfully) reference it in SPL. Fix these linker errors by
conditioning on SPL_UDP/TCP_FUNCTION_FASTBOOT.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 net/Makefile | 4 ++--
 net/net.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/Makefile b/net/Makefile
index 3e2d061338d..5ea58eef7e4 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -27,8 +27,8 @@ obj-$(CONFIG_CMD_PCAP) += pcap.o
 obj-$(CONFIG_CMD_RARP) += rarp.o
 obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
-obj-$(CONFIG_UDP_FUNCTION_FASTBOOT)  += fastboot_udp.o
-obj-$(CONFIG_TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
+obj-$(CONFIG_$(SPL_)UDP_FUNCTION_FASTBOOT)  += fastboot_udp.o
+obj-$(CONFIG_$(SPL_)TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
 obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
diff --git a/net/net.c b/net/net.c
index e6f61f0f8f6..8357f084101 100644
--- a/net/net.c
+++ b/net/net.c
@@ -511,12 +511,12 @@ restart:
 			tftp_start_server();
 			break;
 #endif
-#if defined(CONFIG_UDP_FUNCTION_FASTBOOT)
+#if CONFIG_IS_ENABLED(UDP_FUNCTION_FASTBOOT)
 		case FASTBOOT_UDP:
 			fastboot_udp_start_server();
 			break;
 #endif
-#if defined(CONFIG_TCP_FUNCTION_FASTBOOT)
+#if CONFIG_IS_ENABLED(TCP_FUNCTION_FASTBOOT)
 		case FASTBOOT_TCP:
 			fastboot_tcp_start_server();
 			break;
-- 
2.37.1

