Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D458CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94F2831BB;
	Wed, 27 Aug 2025 09:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qj0s0dlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D219831C2; Wed, 27 Aug 2025 09:50:22 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E03831B4
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b6b5ccad6so3895405e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756281020; x=1756885820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ghrg7/2AC8niHD/wYpdFdFW5XcnJACrRG8rMwCpyFeY=;
 b=Qj0s0dlTiVQy/BmUOsD/QvhEWQyKfT7+yoQ+gkugn1jpySZ2ncNImRyn7f4OzPdcCg
 mKeIe/y9jeYYS/tVU0+adgCNHDArQnGYv9wWQrLsecI+hhS+TNRaeuf6i5NfKlJ6k0Zq
 7M9Uxv9eBAZDOkuueQxBMnaSBNse1KfToPTl8DII5+qzAaSQyVy3oCS8B9xBABnby57i
 bB2qyMmB1xTFqhP98T0l+CAOI+fMCQfODMqn6kI7wrduGFEpM61prNnBIhy5gmNTTWFw
 qpPoQSQiBWyon94wZwcw6SBc942ctSX4yCbd+OJFXBgUQQtZVRhCYeKxi27Dx/MEQc0Q
 Ivcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756281020; x=1756885820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ghrg7/2AC8niHD/wYpdFdFW5XcnJACrRG8rMwCpyFeY=;
 b=RIjYVefFeitOJquEBfqxZ5YT6CfrS+NJK2Xb8MYMwlW4QQHyD535BNHTigHey2bfbN
 2JGmRlJ0bpkQU6q9hlfDxH5ObUowIdvuFEbab4z58wKptPoohl89TEzxfaIvd5tvifRR
 KaXGswvNc3sWnOkQeCO7rY5vuxZWoh0MlWv9iUjLI4oimDyIC/y79P5U0K6wAfob0q8Q
 Rl4BGwQqVj4W690UdnER/j4YvymDW9Z6xjEHzC291SXbALuBww5P8NjfEuxD7QV7tNp2
 ag1xUyYQ5IZG1XuFG+aWPTjXhaoi1Hb6z2hgvVSEalsfoe9UiW7dbFPfIPg66WiBVram
 QkKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxqG5o5RRw2//1K42bCcdgEy7NMkmAy0E6qGN3+gE8vtQ81kBtrMFyexZD/x8UXT06QWueH2w=@lists.denx.de
X-Gm-Message-State: AOJu0YzLZmnWNUhPIAdICo71ySMKQIuOYRBmXKjPh2uE1qEuZmgEPUsa
 jowlRa6Ijq+YjIFcFoglV6CQC4HioHHGx0GSvCiBHMBvcbYVqwcsBjkc
X-Gm-Gg: ASbGnct/VSS+ELT+jwSfGMYN/e9jAyUHqEjKOSpqDmc7KYfQ/8tC300AM8+uwhC8TX/
 q48ae5QUAww/2JzzjGJFrFsstaZ1GBxBG0JkqxYFhC3En1ST2ZkjLj4bJXAWCosFKN3Z1X0KFKb
 XcdUrkny98sBJSBu3oM4awLRagJ9y73OmW+SF0r2Bc4cFPXfdGxSRH0fAPKOBNuLPxz8cfCoQIZ
 qt9H2PtT5ZI5XVRKRJDGlSu/A7utJyDWV769LnQV6mjipcNNerrq4i4IxRuo8//sQfYRRKzuHf+
 3muWlviB55JGdCEWyuUxSX85cd9/mSIr0gzTW26JQA4AiJkBlzx/p5KnL9YzlcjuL0EryfjhHHa
 0BbR5acAZaFfY+BSKqpWzj4YK7T/qCgkyojXn/9p8D1urgHVnY2G7S3V3o0/Gu0G5NvHCbT+gaQ
 ACmgYhkpegXeS/KsEfEdW0PjV5l2/hTcoLPvnp9Oaf9FsgwnzaNsNs
X-Google-Smtp-Source: AGHT+IHVZ6xYLzCp/WbqBfFW0LDpAZs7F+THm62hjyobEjwSuX5gBt8t4rrbfeKyif2nW2udYGM66w==
X-Received: by 2002:a05:600c:358a:b0:45b:6b0f:caf3 with SMTP id
 5b1f17b1804b1-45b6b0fcd17mr20420325e9.4.1756281019458; 
 Wed, 27 Aug 2025 00:50:19 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45b6b1cdf05sm14707125e9.1.2025.08.27.00.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 00:50:19 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] Allwinner: fix booting on a number of devices
Date: Wed, 27 Aug 2025 08:50:14 +0100
Message-ID: <20250827075017.1583168-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Revert "sunxi: enable MMU_PGPROT proper page table protection"

This reverts commit 16cfccda4dbf0b53473b8212897f5c63bfbeb6e1.

This causes the follow issue on the A64 boards I have including
Pine64+, Pine64-LTS and the Pinephone. Revert until the issue
can be properly investigated.

CPU:   Allwinner A64 (SUN50I)
Model: Pine64+
DRAM:  2 GiB
Insufficient RAM for page table: 0x5000 > 0x4000. Please increase the size in get_page_table_size()
resetting ...
System reset not supported on this platform

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 40368abc297..b8be270e4d7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1207,7 +1207,6 @@ config ARCH_SUNXI
 	select DM_SPI_FLASH if SPI && MTD
 	select DM_KEYBOARD
 	select DM_SERIAL
-	select MMU_PGPROT if ARM64
 	select OF_BOARD_SETUP
 	select OF_CONTROL
 	select PINCTRL
-- 
2.51.0

