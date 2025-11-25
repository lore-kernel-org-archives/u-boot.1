Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADBED0E6C4
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ADE983FFE;
	Tue, 25 Nov 2025 13:25:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJUhlfyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CD584019; Tue, 25 Nov 2025 13:25:12 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E158783FF4
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so2487921b3a.2
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764073508; x=1764678308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KlNzITtGT7R1c2iv2JTn5oo+yMgQDzI/73MueOGy/0g=;
 b=MJUhlfyNOjt7wDPACNO0ywB2aFLXC1iYOWUj0g/wFixYjRmNe0TcFfUZGVmnBBMj98
 WtxRsnabqI8l8D6gDTY8yDcO7pQdF2MdXurkgyMa6ELsUkR1L2bFdr2aBRz9uBVfka7v
 4o96ulfcRG/ZUgYzJOBjR+9SHIyGamzwp7ssYaLOg/w8GCLyzC0ws5hHZjomCsGYDt7S
 whByW3xd1WXV6qAdb4u2F3C8sfmKQMonsye1Wri2ifJr6GWz5n8aCSwg62+ol6CLQTov
 36oHSOLEEBT7qlj1D6wSh3ZT9nRMKiHpwadPjwV1L/MBzce39odj/84U6b0s8prb2/AH
 eSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764073508; x=1764678308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlNzITtGT7R1c2iv2JTn5oo+yMgQDzI/73MueOGy/0g=;
 b=uxtgLGrlVHbNwxGQbC+3SZA3rxXJX+PJQzk4gr22RqRNGpa6oELbgPTzLNvjgi0MP9
 IaERS7m1UJQRgPXX4jMG9hdWT7fjF3y6ISJBMf/NmfDzY6/2PjkKHlFqMgy36V+MOUsg
 jPyBpMIdQG4unLNEeXU1f3tKQ0mNOMYDv/8NZ6oQkudRrroVhui9UeVTRcwskBwblm2h
 609que5lyhaa5LnKxnSber9ladTKTPxE6e8G2OuHHkkWEo7Nk7wr8ecJ06UtfTV/OWgw
 awQQT7DkH7uT0lVPAgnkCzSs2W9mdYlXkD67KkLRme/Jix/8FCAWc3+Qnbb1pvjeo1Fa
 fk9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKVzL2/dt8rW5C0YpMfeRF3ZV6sY+h9wkqWHhLSjOkIZJ0OfVNLdkpfd34kPVcZRPyQ8Bh5G0=@lists.denx.de
X-Gm-Message-State: AOJu0YzekCcBjEmDIC8Sf1EPA0NgZT4onBlv16S59pwHxwFFqCfsjEBP
 V7TOgGF4Y/1Iav9jugv1uFn/XBISDd5FeI+r8lDb5i/7MPMDHljjeTs3/DB1tnhNykSvmA==
X-Gm-Gg: ASbGnct9/AQdL0GU0xpOfqBW3adpk4tcwd63qiwN7Ziu103Xx4HqwfL+9nOayTIASEi
 GJiLCRgVdm22RVkJ+d7W7lLDa1nbtz+/C7HPu5Aq+DhYDlOZxQpcnN8OBM0nB9qjr/09QA+HbmA
 BQisVZAUiM6OJAAe9yNVpNPUuTaVcKEDQPdlT2ecDWIxy4T/fgtNeJwnY0X+ngqdLKhEfy+QkZc
 0QvzRfSszvxMu+KPpBiR/F8LDYefa7fYJBKBvM+xxFz+zbx14rHjlXJzne8RH8kzINOe//7JFNR
 LtV7bKhTofZDGG3WIzI6WoXI5NQqUhQM8el0PxqZOVwyPjvlpbZrrU8eSaCps+jDuFkzc/vieIR
 /LuPQAgbBAxQV8z0EMeeTrVQ3ByCEZw13ObjqZLIeXa4GIwN40cidW3RZbniswl6vJNkcQyb4Hc
 G+tok6vFyyV0ugSEbHbHp5S5L0nKI9pnjwI7K4OGBsG5cROg==
X-Google-Smtp-Source: AGHT+IGVkLZfw9LgbhP82AjNNBs0RW2aaW0q+H1rUhG30TyDjFNN82Cn7jVqLSQaXeIYrivdwESvjA==
X-Received: by 2002:a05:6a21:e082:b0:35d:3533:3dc3 with SMTP id
 adf61e73a8af0-3637d7ab5c5mr3039976637.0.1764073508349; 
 Tue, 25 Nov 2025 04:25:08 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd75e4c73a2sm16021079a12.8.2025.11.25.04.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 04:25:08 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2] SDRAM Calibration Failed fix for GEN5 SoCFPGA
Date: Tue, 25 Nov 2025 20:24:52 +0800
Message-ID: <20251125122452.1689-1-briansune@gmail.com>
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
index f2e959b5662..4011fe4784b 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -117,6 +117,9 @@ config TARGET_SOCFPGA_CYCLONE5
 
 config TARGET_SOCFPGA_GEN5
 	bool
+	select CMD_CYCLIC
+	select CYCLIC
+	select SPL_CYCLIC
 	select SPL_ALTERA_SDRAM
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
-- 
2.34.1

