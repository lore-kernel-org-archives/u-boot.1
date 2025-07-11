Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86AFC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 058B082F6D;
	Fri, 11 Jul 2025 17:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X5/tbcsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3AE82063; Fri, 11 Jul 2025 17:20:14 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E1F826AA
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60402c94319so1185918eaf.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247211; x=1752852011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W2JVIShp5uY/jNPaqHy5qJZEGuLcqfT0DF3KS6tgPk8=;
 b=X5/tbcsvHg4yO7nQ5+qIQykf3yM+Bhy6TaBLM8jMH6Qttmn7PgSSluYGHv/E4tMJt5
 ZY0c11Whhl6yYAbLfL/UkgvEzXIIAh4u1pFUpmeAJfK9rGl6wg1iom9QDZxF987SY9af
 jnt6/bbZk45Q9+ZmdyXTlvdcZ/W1dBkfERtCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247211; x=1752852011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W2JVIShp5uY/jNPaqHy5qJZEGuLcqfT0DF3KS6tgPk8=;
 b=fb9zVUJZUiKsVHALKLZ2u4OPPvYfoJKPr0zdROd7zwHhPeCJbtBjIRWqH7+v3FxoM6
 UQ0w4x3eiso3SsvVnvgSUFl20nZsvMJhahvEsst29q4D7XTzC4x58Hn7Mkej4UtsJq8v
 AKVfVKHMCQ5B6MRT/jf/0oj80SEKFQ3YgINXuJxP1Ic0PwaB4R+TCMrg8a3IUKvlkFK6
 JdbxIBPJndW93K+xgH6gO8rL/crwlvwDNX287kTwuLV9w8uAQxWpehW8a//2ONRSCIps
 dgmW1YUdwunjVCYjM4aUjzkdQArpvjA7dwT3RWi7pBLqTYk9W7I06K6X3FTT23zee7bC
 hsgQ==
X-Gm-Message-State: AOJu0YzFy9cmxpvUalK5r9u2sN+7Snks8+tFg6ZQXJ6nsE81GaQWll4T
 mk5kviLD25Fwslc8ltgYslR4BPwoNK3aviidQiwfjcomzMj5H0+b0+5/vdQGYtODeYvbhGUl2Rh
 wsTWGyzQ=
X-Gm-Gg: ASbGnct71R2R8UpIeIoB8vsUr1f3dq5UwsWg8MjBZ518XJDS0tLTqdDChlCe3huClYI
 WUA3Jpwaq+ZlEe7cbBHdCDdoTJlnuDrBY96hlk/KcuCqLpO5O1VljqE1z5AGrQd0TSzAnxJl2Dq
 wo1DrcVCO1RDsV12XWmsYMwnGeyAHCta66NhsD+zeLZCgREJGIQSEM6BW/QZ9oKY4+NLtqmDu6u
 fV63gwMX5mXM7NWMVcRPkvnXNXYAO5uFuboiK1N8ShM5ZQufwmzmzFnyMi4jYL4cfbvySwRmksZ
 eKmCql9NO1pFDt53/uIrUhYC0z4bsgUoY7EAG6bqLJtSOampsPnGQgNYwi5B1/6THFnoZw1TngA
 lxjNNVaOBRqJs2B/GmFrJMxU+4/41kpRk5mw3nwgklDSpn2zyQj4snsxhmIA=
X-Google-Smtp-Source: AGHT+IGzaNTEzTqT4BJj6YWQtv56QpPQ3u15XU1wHrS+D3+kCOku+naSa8po9119waiRIFulCVtUnw==
X-Received: by 2002:a05:6870:6c14:b0:2d5:2955:aa6b with SMTP id
 586e51a60fabf-2ff2b4d9b3fmr1929382fac.5.1752247210608; 
 Fri, 11 Jul 2025 08:20:10 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff111c3769sm760782fac.3.2025.07.11.08.20.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] misc: Tighten requirements on IHS_FPGA driver
Date: Fri, 11 Jul 2025 09:20:09 -0600
Message-ID: <20250711152009.2225445-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This driver requires that the gdsys legacy driver option also be enabled
in order to build. Express that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e9866fbcdd7a..966783e4b622 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -629,7 +629,7 @@ config GDSYS_SOC
 
 config IHS_FPGA
 	bool "Enable IHS FPGA driver"
-	depends on MISC
+	depends on MISC && (GDSYS_LEGACY_DRIVERS || SYS_FPGA_FLAVOR_GAZERBEAM)
 	help
 	  Support IHS (Integrated Hardware Systems) FPGA, the main FPGAs on
 	  gdsys devices, which supply the majority of the functionality offered
-- 
2.43.0

