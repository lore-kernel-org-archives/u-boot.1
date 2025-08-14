Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFB5CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B48FA83A25;
	Thu, 14 Aug 2025 20:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6OQfHrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3011F83A1F; Thu, 14 Aug 2025 20:14:46 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233E18399C
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76e2e8e54f8so1115757b3a.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755195282; x=1755800082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YA+NB2gofxTArnSMWf8x5CbNRFY99E/WMN3vIrvmwX4=;
 b=N6OQfHrMK9q+gQ0EByWWHDObTcgKbad+hCvuDGyUgTIIg/y0fjVTOSNMfm1FG6vSiv
 jVctS7+ANFgH1WEeb6LikqIPKI+USQIFAa2Mnb9QYloM3YiE4xgnmtP4k0vycdPfev8V
 oH+na9BY8UzUTTzNFedfR4bSvkZal8Tk6p2U4mwQJncSyIsbpqiLZO8Jb1D0LdMhMcp9
 cO2/uKWjMSOZAMsLK17t3aHIDbhNM6b6E9kU9XD9Kr4DY9lWMEkf0c9r/jSJ7VtPnpFg
 /Ce/mEgbWc5vSr2WG556f027PosQZglFfZOVkLnSBDHxnKKmzcVBZC2PLbL4Ztq6sqsn
 2TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755195282; x=1755800082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YA+NB2gofxTArnSMWf8x5CbNRFY99E/WMN3vIrvmwX4=;
 b=UCxjq4tWiVEs+3npDKTWTOf2Ex7Hht0QbMS0JRAe6hz8M+TbhoJVihffSBA0/yUDWP
 X/LynJsoea7iofrbn2TIWadqQYFRcqZvX9VagnHwilhgzk+gh9P2szR1CHOHj51+VnRB
 aIPOwraTS/kRE1tYmGoxT1M00zO9LmkL++ZjH2M3rZgA9iMwp3XGX641yE/4jdS+6xGz
 7RDfaoo3UMRhQAuhM1zMYm3cxUramAFnwxWRp0gQtcZ5gWxL3q8m67UJ2XdgCOr8ffWs
 H+n7GrnY9UYuipwb5LCKQ0XiDjC1U7y1gcc/NzaBOyuPSky/muasPWB3UzJTJcD+Cqcv
 hBIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw6uzntO5qiQl4MaNtUI48VQo18V8Tzz6rqLMy3Okw+WLWcX0HYTS1XBodGiq/jwm9AzJ5oKk=@lists.denx.de
X-Gm-Message-State: AOJu0YzbcRdt4eh5nIzX9GQhFY0AZ7s15CqMgc/yyu1+VL4fVnpOqS6I
 jGFQbI70S5lZGMr1I6bFTRzJ7bnwPJmqY3NN3BXYM6ycYmsOWcW2yDgs
X-Gm-Gg: ASbGncvp0R0tklWiwDxuG3rRagjL0nxonSAvJv5zaQz+JSBAo0e49c+CDwOf13ZLqpm
 Me6aIF2uYKL4FO0GMac6tArJlsHyzDiN5ZSQyYYXpcpZfOknv5kssdKBTTfo5HKD1lFunDJ+XmY
 g4O6jHl3HCk+YBUq66c4cMYW+b9qoTNRZVFFMGEY6BOc1fRScvj9Ing/wg2n3aeSqcQ8x+Jg4TA
 1yrqIKHSyh3bDrLKXLPSaol/q8R35yEIVvH92t4si5pnxwEI9XxdJZ9FFZzCcDFa0p0Sb5w5cBn
 lIlfQwzvx/czfu3hGjm5CAVyYtNhmmgE7Krkzhn/BpkqP5eVjyo+DukvYEBtqutsyOmlDloiuwI
 ZwfDg+7Jkd2bEj7AdnAd5i5FCndVgKx0/piGr4ofMUipF0g==
X-Google-Smtp-Source: AGHT+IH85cm00A8o+ZUZSuCsVlqli8npH7YCsZasHdf1mq7iVDBdGeu+AcP0/2ATguys1nFIIvwxcQ==
X-Received: by 2002:a05:6a00:3ccc:b0:740:a023:5d60 with SMTP id
 d2e1a72fcca58-76e2fb1400emr6470554b3a.19.1755195282327; 
 Thu, 14 Aug 2025 11:14:42 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f50d:900e:961:a245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbce4bsm34713327b3a.77.2025.08.14.11.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:14:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: tuomas.tynkkynen@iki.fi, jan.kiszka@siemens.com, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] Kconfig: Convert SYS_EARLY_PCI_INIT to Kconfig
Date: Thu, 14 Aug 2025 15:14:35 -0300
Message-Id: <20250814181436.1598067-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The CONFIG_SYS_EARLY_PCI_INIT symbol is currently not supported
by Kconfig.

Make it a Kconfig symbol so that users could select it via defconfig.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes since v1:
- Only collected Tom's RB tag.

 common/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index a2f653f7e722..cb17f0561537 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -833,6 +833,13 @@ config PCI_INIT_R
 	  case of DM PCI-based Ethernet devices, which will not be detected
 	  without having the enumeration performed earlier.
 
+config SYS_EARLY_PCI_INIT
+	bool "Enumerate PCI buses early during init"
+	depends on PCI
+	help
+	  Do early PCI configuration before the eMMC gets initialised,
+	  because PCI resources are crucial for eMMC access on some boards.
+
 config RESET_PHY_R
 	bool "Reset ethernet PHY during init"
 	help
-- 
2.34.1

