Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F263ED0EE3D
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 21:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2701C84101;
	Tue, 25 Nov 2025 22:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UmxiUUqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF3384121; Tue, 25 Nov 2025 22:30:12 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 547AC840E6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 22:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7aa9be9f03aso5232061b3a.2
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764106209; x=1764711009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+4C78FifQ/xaK3+mvub3bcFgpRMQnW93phKlX0XdPM4=;
 b=UmxiUUqUmIMR47/99CcR6HQ0RZZtb1ipkVPT1uMCY7wTNig1RGEPzfQLLcvdDqNQIL
 AcKiL4zPIOlpHQGZeokU1pBFJyW7aDe7xPuZf0fZISeKcnYBtRcBA3n+gI+S9JV8ocT5
 VhI3BqBhDYfW83wMeqt5HJRFEz+5VQEzviP+h1WUHo7Mx2KkJ5I2m6wqXCXkjl4BSEsL
 a8QVQqNNhS6HvA/mc5l1ml5l9A5D1clD0vHVB77oL7K+rvAk9WZKCOLn1ty/pxobKrwt
 dr0EfT3qWPpfjOyZMl8pBfCIPO1rpD2O4gsMk7OzS0M4B6Dm2NuGIME2q7KtPtkxPU71
 tWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764106209; x=1764711009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+4C78FifQ/xaK3+mvub3bcFgpRMQnW93phKlX0XdPM4=;
 b=D5REFNzTvQXNxS4N/YkuC5eNcoC4FFUkQKWwZDGplWCx+kLY9btbZAaDrt9Cq92jFN
 CdQgVf7bAyrS+Gm0xm4qtcvRINC1Cm+TxqH6mDpsoIqfWWbkxtSjnkkclKfMY/bISzrw
 F2Bji9+TzyXNugCkcLgdFJ57LEA4yttMxLYwU6Xu2KJPU+Y/3Qpkva+yxl4z7LH6PZf4
 w1uPtwwhdfHT+IF1/skj6NU/Or+/1gB27KuEtJaVVs80uyRrQ7HSrwLMH6DYLlQgWStj
 ZqhMqyRK3aVrT+lgBBk4KC6grm4X4ku6QBeHntezjvUORzNHwieHMXDPAwqAyewGULg2
 CBPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOolLC2pt/SlEh0/rgdqeUVDZecYjpKVbpCzW4SwQEJ7FmWfK5mUhIDUcwRizl7v0nQjHJsnc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7shXA8WKy+jzMl3at6e/BskMZRDwGkbGKjXVLvQ41NBpgGC13
 Mgc4c/uwxWbJlF9wYE7gvQlHub1jDMFDBqpqQkW512JU0eHiz/ZOi6CVbPzfO0+CwEMvPQ==
X-Gm-Gg: ASbGncuo6KYMAHPSk0Mv2P93Vs0g/574AAaF3B5M6n0AYzLS/BvXx+CJNXHk2+b328g
 oNJc/oLQAJ4ct1d9HaPnUWhmMK9xc9a6ju6qD6hlWG0OZb6iKQ3qHOdHTa7qoFv/+WLSKnW3RCX
 DR1Fo653cZv6BEAfg1HCrK7uuAK0QtlEYPoAmvs66dSlCw6RMHk0X9Velt/+1HKyLgorU3VD7rn
 LtprfwQdkp+GTdMg5NxP27jWN+LPL2h6stEc0NEOtoJyhL/6RgHwXw/pv1xC7SKeJrfRRQAc87G
 ep4Co9Yf5yxV77VXdR3/V094hK+30JkeVyF8DxHvbZ0pTw4KYLMDIgLet2fkHwJZknrQfhVjKUD
 A/i9i6mgsN8AMbafmEFCynWn+/eHwyprOYT5b8kfvW8dcgF32MoLL5/p0uZCVwlp8b4aR0luzWb
 JxFClyyz1NU0/rtoo0cYdsp1m+m2i9urfkBrE=
X-Google-Smtp-Source: AGHT+IHTN+n21/C2RyOJTCuUiWIcRN7VNitIRRXCj4Xc2iH3tMnBnrdPtAAXxQ1Kzr4rJprwIxV+RQ==
X-Received: by 2002:a05:6a00:230a:b0:7ba:13f4:a99a with SMTP id
 d2e1a72fcca58-7c58e6032f4mr17915224b3a.27.1764106208689; 
 Tue, 25 Nov 2025 13:30:08 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3ed379558sm18915255b3a.25.2025.11.25.13.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 13:30:08 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
Date: Wed, 26 Nov 2025 05:29:53 +0800
Message-ID: <20251125212953.1733-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

New SPL introduce cyclic and without initial
the interrupt of SDRAM calibration could fail.
Initialize the default CYCLIC setup fix it.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..1f536c7ea74 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -117,6 +117,8 @@ config TARGET_SOCFPGA_CYCLONE5
 
 config TARGET_SOCFPGA_GEN5
 	bool
+	select CYCLIC
+	select SPL_CYCLIC
 	select SPL_ALTERA_SDRAM
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
-- 
2.34.1

