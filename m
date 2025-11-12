Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E77CD4847
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 21:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05C183D7A;
	Wed, 12 Nov 2025 22:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lC7ux/jK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E4A83D8A; Wed, 12 Nov 2025 22:21:45 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3051083D0D
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 22:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-373b7e07182so41908fac.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 13:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762982502; x=1763587302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FpkTPJwW5Ggj4Pk8lNspWWMVtVKf8JP4Y4CK1Dr3hKs=;
 b=lC7ux/jK4923OT4B+2WCYzjZBQei1erbiCewNlj9K8vOX4PGbSy7ALWzZX3jQaz53W
 OfWTBSYCHYkG+e1aGnv/SCRw/rFsI4FUyLnMqVD/ZgbEC0cq46gmdzkVTK45SfwIYdKb
 23Eu4NxXTuFkkYddyGki+m7QKPQVkTOI+HLwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762982502; x=1763587302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FpkTPJwW5Ggj4Pk8lNspWWMVtVKf8JP4Y4CK1Dr3hKs=;
 b=PwA+pDomsFC4O7TTgR30JuM3oT9iXby+OucJS8dealu3A+pBu1pXqhZA0/IKK+omQ7
 6BPE35efAqi9UQvsfWTSjGyqIU7ouYXgESwfRnZ1dcuc1/nfCTuuiD2x6WIKLsF4SoBR
 I6givGtP6b+T9Hhyst8834ZpzKbvJ/ZmoXvjq8kaJ8PTeybBqrpqGKbp4teV3V54DtqU
 fpB2MW1V23Z3yiESc6EOYB1zX3dY6Ip6+biXrIrJGGU7guvIWAlun6sAg1DPH71mireT
 JlNC29FYuzbgxoie3V7c8IxWZT+onsBJ4Q6X/ETCClVnyqfTeI6gQYpQTtpb/G7C2OM8
 TECg==
X-Gm-Message-State: AOJu0Yy7hJibfCV0MSqUjRNR7WSnSkwewZvWutFmhN08VJmJq1xGJQib
 SahkzwUaeclnv8AUrgP7q1LGIkk5T+yF1AvF5FCEV5iYtfhN3iULfKI4UfBpeCnluBcfNIOcETp
 KsuY5Mdgjww==
X-Gm-Gg: ASbGncuZbLuZL6DWNY30H5YkxRspA2IQfYjOTwEtprc6C+6VlmZx9bHABNOffPcYmMn
 ZcT+LZByIALz1MPyEocMwXIZjBp2SvLLrKTR43Oj+HfRzOR9s1SlLZ4rD+YoMUTofv6zCGAsfGw
 Dk2QcLPBIgoejt5aiC/ChNy5l7+3Fs/s88q8QoRlcd3luxQVHA6BcIS2sZq+cNswemgPld2VS9I
 uff2hYyXCGCDkPxahNH9dkcUA8YB4up8ugzHYuG6+t1piMZ7xMguH1p6EGlWvBtUTTY/GFXqJ0M
 QRV8YxtmxillJCu1FY894uFI7gFzvE+ATotH/tNVQpzSo/Bio/X0Jd0Tr4MqQYs8TufpMQyLlYo
 GlpjRK1/2hRFt4FNZBm3rNE+U5Jr+3jLk/g91zfIXhQXQXpiDqZN7D5NSuUzkMS79o0g8ouCm/H
 SZ6DK1JBZlZHo9Z9zS3c74mOovHZv54H4lhxKgAp+Oesjcu9EHKVPr
X-Google-Smtp-Source: AGHT+IFoHhnjJ9RchiE7RWXLwayGUVsTfDqoWy0FTBrna4M5WZQvhYLV89ZkINcMiWh5IfU24oW0hw==
X-Received: by 2002:a05:6870:b28c:b0:377:77cb:e091 with SMTP id
 586e51a60fabf-3e833fc05b9mr2287433fac.14.1762982501904; 
 Wed, 12 Nov 2025 13:21:41 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e852044005sm131501fac.7.2025.11.12.13.21.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 13:21:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] net: phy: Disallow PHY_MSCC and PHY_VITESSE under COMPILE_TEST
Date: Wed, 12 Nov 2025 15:21:40 -0600
Message-ID: <20251112212140.1429629-1-trini@konsulko.com>
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

These two PHY drivers have some overlap of supported PHYs. A longer term
effort is needed to both remove duplication and enhance support by
dealing with some issues that downstream vendor drivers address. For
now, make both of these depend on !COMPILE_TEST so that we can enable
"allyesconfig".

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/net/phy/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 018be98705a2..791bb58b0482 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -236,6 +236,7 @@ config PHY_MOTORCOMM
 	  Currently supports the YT8511 and YT8531 Gigabit Ethernet PHYs.
 
 config PHY_MSCC
+	depends on !COMPILE_TEST
 	bool "Microsemi Corp Ethernet PHYs support"
 
 config PHY_NATSEMI
@@ -340,6 +341,7 @@ config PHY_TI_GENERIC
 
 config PHY_VITESSE
 	bool "Vitesse Ethernet PHYs support"
+	depends on !COMPILE_TEST
 
 config PHY_XILINX
 	bool "Xilinx Ethernet PHYs support"
-- 
2.43.0

