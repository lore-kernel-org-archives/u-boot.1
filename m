Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB0ACAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CBC8344E;
	Thu, 25 Sep 2025 22:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XwCG2p/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3447E82A9E; Thu, 25 Sep 2025 22:44:21 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055AC832AD
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-638ac2981b9so566702eaf.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833058; x=1759437858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THaVmH7DjWhYVchgIAEeamrYGNX1koDXUGFfkwERezI=;
 b=XwCG2p/F0Vu2VBMGWR+BnwFjt908PByH9hEcW2eEr92SrwP6fivDD6zozO6LUY7xbv
 EFuPTzo/pP7NPMU3bBIlnQeg8rbRQOA6oo71e3WO+xSYMLEqer6GvI3Ox9pz/OsmS8Fn
 cWdVoyods0dH9g/iCS0+CBdcf6JpB4cSGbENw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833058; x=1759437858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THaVmH7DjWhYVchgIAEeamrYGNX1koDXUGFfkwERezI=;
 b=MYqKokYjhEpOjx0sZZAldgbluYmhX56jq9Xo7Czr/mXK39pbmDloB7aRhpmashC8mM
 6CLxfIh6W5o0BJvjKgpwbnnhMQR1AbZLXBEGZ/ZiQge3BXKZRasMAkVoZtyUuql9Nx8p
 KQYiXG2pG5SC0cMgOvDagu2fT7B3cS3t2HV4wv6svtgbX/Prr0pwUHaOZeKY5RIMNtnB
 szkl8EfgfyLCEHnMEQMCmCPGl/yyPDr1WLYjtccWuklg0SMXzWLXmtqbwIeyDZDhu5kG
 /Tzr4xwLuXb9GLXAi9yFsVG/BcTQv3Z/6JUVqSNjhB6UmdWqI8ItZ4t8A56L1hgS+RCM
 m07Q==
X-Gm-Message-State: AOJu0YyYMwYi0rDjh61EOGbN8A4MrcEoL3OmCr3yT8wAlGVWqSOjWtP2
 8H5LsYhY42jXvWKT93ou/wHTSmSo8cx34z7vmk3NEOZIKA4TimNYmd2sHgnJ9K7ZlFeLVoh7ikE
 79ytlh0c=
X-Gm-Gg: ASbGncuMIdMseIQg494c/02c8TWvG1pdTT0OtuZtbm48BJgBfEh4e1GomyDYLwvQ6yG
 BTmg5tYcO/6LknLKqpc6QtzhXdknOTSOJjzQLzxbntF+Bt/XKDbWCkEcQYiJ7d9B1mucx6fR/mS
 35fBbwG7hJw/+wyhWhIS3HZ0nYW8woKcTKLVDxoFUyTswLijDFn6P/wvIK1027ph4MdrISM6fwI
 73HNagl9Y77qfRb1sv00wfTw0xn+zNg6QsJCm+FRSmKOPh+Vm9ClSnRF2HlCa/ziDW4wSSTycOi
 47GcYLrqSaK/xwwzh9iiDtXXHlc/dWYF2sU8Vgk05kGyFsTfrJ//sDW9xgqu0S6X7FOre/nH5s5
 r4sTm7Aaqx9OUWhH4JvQO0GGcZJz5rFzAneLiLLFtQRUx2HtuQf+2auIR77U=
X-Google-Smtp-Source: AGHT+IEcL6hkS4QdYYzjP/lX0/AdQviKmdtm713qBXXGaPitIOvcvRTkN2SIjsLh+gJ/7i4q9MDkww==
X-Received: by 2002:a05:6808:50a6:b0:43f:4190:bcb7 with SMTP id
 5614622812f47-43f4cfc6d10mr2797566b6e.37.1758833057741; 
 Thu, 25 Sep 2025 13:44:17 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193d01bsm605790a34.8.2025.09.25.13.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:44:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 2/4] net: Add SYS_FAULT_MII_ADDR to Kconfig
Date: Thu, 25 Sep 2025 14:44:12 -0600
Message-ID: <20250925204414.3561033-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925204414.3561033-1-trini@konsulko.com>
References: <20250925204414.3561033-1-trini@konsulko.com>
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

The support found under SYS_FAULT_ECHO_LINK_DOWN requires that the
SYS_FAULT_MII_ADDR symbol also be set. This wasn't previously found in
Kconfig, so add it now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>

Changes in v2:
- Add missing dependency on LED_STATUS_RED_ENABLE as well.
---
 README      | 3 ---
 net/Kconfig | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 07cfded6be53..27cde241bef4 100644
--- a/README
+++ b/README
@@ -1238,9 +1238,6 @@ Note: once the monitor has been relocated, then it will complain if
 the default environment is used; a new CRC is computed as soon as you
 use the "saveenv" command to store a valid environment.
 
-- CONFIG_SYS_FAULT_MII_ADDR:
-		MII address of the PHY to check for the Ethernet link state.
-
 - CONFIG_DISPLAY_BOARDINFO
 		Display information about the board that U-Boot is running on
 		when U-Boot starts up. The board function checkboard() is called
diff --git a/net/Kconfig b/net/Kconfig
index 40ec6bbce761..5768fab6f8fb 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -60,6 +60,10 @@ config SYS_FAULT_ECHO_LINK_DOWN
 	  this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
 	  be configured.
 
+config SYS_FAULT_MII_ADDR
+	hex "MII address of the PHY to check for the Ethernet link state"
+	depends on SYS_FAULT_ECHO_LINK_DOWN && LED_STATUS_RED_ENABLE
+
 config TFTP_PORT
 	bool "Set TFTP UDP source/destination ports via the environment"
 	help
-- 
2.43.0

