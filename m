Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B27C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C86BD83022;
	Thu, 22 May 2025 01:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j73yDO6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C4AA82FAB; Thu, 22 May 2025 01:01:43 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF7A83015
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4033c70577fso4370763b6e.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868498; x=1748473298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zK05UYy5mQR0BDp/9H2xFWyHOrRTovkeL7i30RRZx0o=;
 b=j73yDO6m6/sO5OIFf2EZopLJ+fvlzNwsZN9ktc9yy4vKytnOi/5gHA/tCzCIEqpGnP
 iCcRMlwnjpBGvZkTKYu+QZ0fQEEv4nNHcjZlP7Pt2M9d6VGVjohvzv6+QRSvY2+rjFB/
 Cezr8da955G1kgUcESWKFNpbjwK8Y3yBAVRRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868498; x=1748473298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zK05UYy5mQR0BDp/9H2xFWyHOrRTovkeL7i30RRZx0o=;
 b=afYiWPK5AzjcpIMNv8ZpAW2TLVDgXe6Z4aon2Mhx8lrGHW32NCUFH6Q+JdI1XagtAs
 f22dcy/HOHwlo0Vc203+if2wdpplWZNwGO/OC3yKJOD2ociA4tEvd4OpD9ENPS3iQL//
 r7KeaWtATeLx/S5XuCu0jzMECexLRxaTP7PNR+Q5sLkcE5xtIPGcz5nFHc1nDHB9PMBm
 G594Gpa/USJq8x7fZuk0AFnH2Qq6C/wHC9HO/Hr5RW7jQVC/LU3XDNF1K2Giq4Ku1E0F
 EfxubqW9G73G85+1hqQrfegAhnQWrmE2g5AQv322mC8Uy/tKF0XqeN7b+5tY4am7TY6Y
 lLhw==
X-Gm-Message-State: AOJu0YyJ4UVd/cR1L7wl5uPs3hOVwrVx/vJUuA3ma/lLEc8L7J3oe6rU
 Ak6nkncycZaBPby71XM/iIYF4wP/tOlvU9lhI5/XnBvnVEWk2E3Q85lMMUTS4zHpmkrfxHXR20u
 Jjf3ChBU=
X-Gm-Gg: ASbGncuq+hEznCfb8/7AKo/lptFM4zUYwBfORIfw8Y/2MJiDgwKMXyswXpzy+Q/wdQF
 gLZTqiCLZmxphTeOevVj7KtmecMOylLue9eP68oi7Au8RlcAgMgX4EcV379DcUWBe4ZoJa1IAR7
 7glLGd48yJ0rh/RuiSZmXHTE1h9ik+rQPHOhf2WqdP9wfAWoemQuTaG3ohe/J4FuiQgdSE1iSC0
 zSEN45FC7ZmE7+Mx7k9hRQlQxx6xbAxv+KJgqFlvSJJTPTzS5EuDcctuBxKrKKk9jKpeBAw46pN
 hf5zoj/E3Y2xUXkT452ZhyeHcUgeIAnfoSH0/4xZZ6sf50aT+w97HfGGXRSurF3wF/Zm3+qB2cG
 A6JNwJeo0V3uWH8k=
X-Google-Smtp-Source: AGHT+IG6tYqXjTRS9aSiIbsiEtIO852wu3taF4l/z7MfHhbwuawee62TPdMkxdc0ET2RoebrUplFVw==
X-Received: by 2002:a05:6808:80a9:b0:400:32b9:7926 with SMTP id
 5614622812f47-404d863751cmr14438175b6e.6.1747868498379; 
 Wed, 21 May 2025 16:01:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 10/17] include/dw_hdmi.h: Audit include list
Date: Wed, 21 May 2025 16:51:15 -0600
Message-ID: <20250521230119.2084088-11-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <edid.h> so remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/dw_hdmi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index b73518207ef5..fab5aafea194 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -9,8 +9,6 @@
 #ifndef _DW_HDMI_H
 #define _DW_HDMI_H
 
-#include <edid.h>
-
 #define HDMI_EDID_BLOCK_SIZE            128
 
 /* Identification Registers */
-- 
2.43.0

