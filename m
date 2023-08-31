Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30313C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A18286580;
	Thu, 31 Aug 2023 05:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bimcovng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7E986582; Thu, 31 Aug 2023 05:53:38 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B5648656A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-44eb98a2da3so235172137.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454014; x=1694058814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QB8G1yC6OmvUM8RRItHXqFGfmSnYRRf1ZO5drcV3MVI=;
 b=bimcovnguq52T6Z97rn5EzF7ylDVb7sNhfbPGh7UGA9CQxEdQK6IOdDET8bVamAAJ8
 EiBL8MyxZnCrQRJIKsmEEHGF4r2GHtGjjveM+rC+l8hCrgnCsn2+gNVDQD8M7cjbG0mK
 MUTezH6rF0B531j0712jwJb2EXdNeV1iQz5ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454014; x=1694058814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QB8G1yC6OmvUM8RRItHXqFGfmSnYRRf1ZO5drcV3MVI=;
 b=BGubcEVZJEjI7BN0jEIOETKIkStxe3tzu5k168RcprxyIeaIR1lZSAxM/nrd7cWUJ4
 pxKwX67Di4AVSZmGDmF1nsfwgMLuUggy8eYxBpLfF4oNe36fP0p5p+4hsMNoNcIPZ1Gv
 fXQMrHlt3PkG7Rv3MHeH68WWJs54yMgnMGjwb8Oa/9DVr5uUVsrUjJ3VXaEiI2O0V7MT
 30DdOtMQ/GmvKyDvD8/W4VzLaX64ogXosv8dya4XFLb81WzqhOW71kYCI4exe8iqJ9Qz
 k7C+OPsj6XJ7oYp9cyfADc5VkS+gztADOPZ3pgreO/eRCk5dYMyNldrXet5KUmp/S3Lh
 kMLQ==
X-Gm-Message-State: AOJu0YwwADTZPvNvxqgEOHMqvUd+50Uk59Sk7LP+daGmcG2OZpYl/Q4P
 FbUMCFhHCZJlXd9AIcRcJvNXZKrigcC5SkBjUoc=
X-Google-Smtp-Source: AGHT+IEMPaExMeYEV/4qpjpxwNANZxUG+BaRqYsho+kZVKqTkNv8LpVyV+ipz0Pft/xYYnRK0KZlJg==
X-Received: by 2002:a05:6102:3a70:b0:44d:4b34:af92 with SMTP id
 bf16-20020a0561023a7000b0044d4b34af92mr3801702vsb.7.1693454014258; 
 Wed, 30 Aug 2023 20:53:34 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v2 05/19] net: Move SYS_RX_ETH_BUFFER into the network menu
Date: Wed, 30 Aug 2023 21:52:59 -0600
Message-ID: <20230831035319.2316665-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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

(no changes since v1)

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
2.42.0.rc2.253.gd59a3bf2b4-goog

