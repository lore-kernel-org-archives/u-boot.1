Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A71AE65D0B
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F8189774;
	Fri, 22 Nov 2024 01:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="atZeHtCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A126D8970A; Fri, 22 Nov 2024 01:31:30 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFAA189768
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-211fb27cc6bso16645565ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235486; x=1732840286; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zc/VMMwNHVlX47T7NlPeQ6C05BzIlKwkDUvZQBGJ2I=;
 b=atZeHtCzKRFZw0671c/ynbNMRZ6cwRXLHuBTLXNn9v2g0GSvNd+bDKscLga+yjmgFL
 JGZTboL7yPyna1empEZfUBkXw76nz15lb5Jfr/K/DqXx5j90Gmq7/P1b32x8veQ39BBT
 Tb4CWzhczmoIK24e7RycpbUa7dAWcbN0mAXgWCSJaeW4Q2CKez09767uOPaB76ImDNA9
 ficXqA9M2jMVtAFwhvy/20dfG3KUSJz2iZi0AG7VhX/12RJVOuOzDU4T3CAQSDE+9wsp
 Sh1p1eJoH509IUWopsiR+oVFoxIOLAX8fW3TTiDTtcfewEWWn33Eee5OjK2zEpFiOZxl
 ncDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235486; x=1732840286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1zc/VMMwNHVlX47T7NlPeQ6C05BzIlKwkDUvZQBGJ2I=;
 b=XyOdkAV6aFeIzZPjC9W9VUtJd5edZvYhK3myF98f9mgc/aXKqrpXIjGyDrv7DCn/MB
 Ti65Jb0/xnQnevDGFYneZKcdfANi2T7ZBu53FpaQH4/co7dChY5I3qGxuFv3IcSIbPw6
 deNiT/oX1bgVdvIXLLzAy00G6jqHTdyIlVhT47fvogyfY+PCrtZKskrBfbA8kfIZ4Oqu
 OQbmQRquqfcvtE9UK1NKUVUr53UmtEWu9HIxV/1QJVKsJEQGey3m/WTsohG4OotSpaeP
 GdIGeKCl/3DbIlmNNbWJvRWdSTcjemSM2XJ1vNatNpUQgLjo2lqY9yChG2uDBANAdQwv
 EW+A==
X-Gm-Message-State: AOJu0YxrBluOMJF/QfqJG4AIFnjLSQgiR2dpbDXEHa8PL+8YtsOHVYLG
 uNY05adSIC5nqeXbW2N0WvKAqxINcLPOb4xjIv9bwMrqQ0TngX4jp/z8Gnpg
X-Gm-Gg: ASbGnctJe0T3DUJZSQdyRb+LLCMJtdgYTHaXlQrtvMU6mSV27dvNzhy2fUue75nUlEC
 7EjcxVuL2WGUT8w9LkSNTFs6Nn+aKykKzyhXNnh3s0Ush5Mtimcf4H1yoRDB150tFIxNj7cOONQ
 K0hzX+SzWWH5AcGuTWT5ggOb82/m1GbC3NWdaSJASYLGXEngD4s1WU0l/RO6HOpnF/j0xFezhke
 GKFSliL3N/fjITSod5bpYp7waSxxSncNyi4u9LuVFh2prF4BXQdogC19eIsXH97
X-Google-Smtp-Source: AGHT+IGAjnr4Omi9vJdD1P8kpqkuRziyI7g2xaMl7jRrfjLyfGFRFuhbe/2b5k9nH3HYl0YbQ/tFtg==
X-Received: by 2002:a17:903:240a:b0:20c:b606:d014 with SMTP id
 d9443c01a7336-2129f68abe7mr11879305ad.44.1732235486340; 
 Thu, 21 Nov 2024 16:31:26 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:db1b:7332:ce96:46a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc225d5sm4181075ad.258.2024.11.21.16.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 16:31:25 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/7] arm: mvebu: x530: Remove dead comments
Date: Fri, 22 Nov 2024 13:30:19 +1300
Message-ID: <20241122003058.270163-6-judge.packham@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122003058.270163-1-judge.packham@gmail.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
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

As things have been moved to Kconfig there are a number of dead comments
left over in x530.h. Remove them.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 include/configs/x530.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/configs/x530.h b/include/configs/x530.h
index 982b12928734..c7bfd1de17c5 100644
--- a/include/configs/x530.h
+++ b/include/configs/x530.h
@@ -18,30 +18,14 @@
 #define CFG_SYS_NS16550_COM1		MV_UART_CONSOLE_BASE
 #endif
 
-/*
- * Serial Port configuration
- * The following definitions let you select what serial you want to use
- * for your console driver.
- */
-
 /* NAND */
 
 #define BBT_CUSTOM_SCAN
 #define BBT_CUSTOM_SCAN_PAGE 0
 #define BBT_CUSTOM_SCAN_POSITION 2048
 
-/* SPI NOR flash default params, used by sf commands */
-
 #define MTDPARTS_MTDOOPS		"errlog"
 
-/* Partition support */
-
-/* Additional FS support/configuration */
-
-/* Environment in SPI NOR flash */
-
-/* NAND */
-
 #include <asm/arch/config.h>
 
 /* Keep device tree and initrd in low memory so the kernel can access them */
-- 
2.47.0

