Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ED1C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 561E5805C4;
	Mon, 24 Feb 2025 06:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YuZk/FFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB04805C3; Mon, 24 Feb 2025 06:55:59 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9241805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2210d92292eso119078125ad.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376556; x=1740981356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cSPcegYwcON9eutk8vrtOgqScq2PVHefA/vm5vKyIY=;
 b=YuZk/FFX6IRl+e1HkD65UMOqfAwfJvsnGaSVJZvDhTZyRLiT6pg9L+KWU1jQWDwxHF
 KgEnDG+3XDGGNIwslF93N/wMF0W67MAnJII6VGjfJHYTO1sagROvHK2gMVRAJaxHGiAl
 ZSOOL5BqKTqhpno2IKgWlMX/6bbpwUieV56Dj5Kb1SZfHN3y8hKWDMn5d26P8KSpZuzI
 OP6WGtcSmU4UTJadsfRaGa098wa9dYGKMpxZ5ONNaWhc4r/mMsCjHaUY+ss/Q1crDqOC
 gYMn67KSF1GCEHEFkak0cV9uPVwdgpToNH363Jegl5h7EOjvRNPPW4O+ZzxpdMiGdl04
 SzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376556; x=1740981356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cSPcegYwcON9eutk8vrtOgqScq2PVHefA/vm5vKyIY=;
 b=L/INa9jXCqVQDrE5HZ+IftOxw/f8c9bPXfXw162r3dzerb8lQiY+oBSWMmOztoKNM1
 AAdKPomCQt9GOvB5MbgB2OUbxCMeoOU9BCnor49UtOQyvx8moXkt5JHGV71Ey6d9r7ko
 VCNuSed84Qg+SC6v2OSu1/79TfDxVXXtjE1NDY4XbvsfqWDRJCIEE12fm6KYrpetB5xx
 vc8YSd+QnuJktVhf54HWkqhXnjiZ0asGyxeHZPTCsUBr9Jsai02IcdWkWHFoww2S/7JV
 wrwGrs9R1QLQKE8wVbaIv2xfsXIHJVjFG3w4ljHMttOTW13Y4qJeULQO202f20OJUvt0
 jaqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlaxlLiBPkvI8IZKoXQjdtRqLgfSTXQ7TFZ9qM0c4oi3s7lBffuEozMmFQHRxGlgnftu7UldE=@lists.denx.de
X-Gm-Message-State: AOJu0YwEm4G7sh79opHZZUADCBvS3qDNkmRSaca2nnD8YQk1qgLAXj6c
 vcSQ+mMnkme3yxbRtA+PMYkFtPfeONPO+AwMfb4HztdKZdExK+in
X-Gm-Gg: ASbGncsFEiEf63i6PwhN8oSzx1zXVPe2UoBGfaPRwRNlLx5W9SEtOWEFA17TNUwFsCq
 K3wJUCLwPcYU9DYD7BIzCAZ7mBuSJDUCuISCpBC1jkUWcw1WB4caUFJ7Rkl3gTjmreOUzqgsq88
 V4sDpSPNFyZ9UNF8twG6Db5Vr58nGhhUhlkgpswcALXt9yaRsDbmhzm9tERZECTAsnWJzxvxDgy
 I0C91JmU1ASLYRrKAzCH9PXIXHExaDa+uyQQyxhPREi/53YDN+aymmBZ55vEbAN6UeqaNqUFohE
 TdVUYSEV3bVt16cQL6v3u8aH16zrzfKSyYpG6Q==
X-Google-Smtp-Source: AGHT+IGBT79QOZ3toWv+8Dlvf0G2WwtmJXCM+7CokTuinNEXQv7SawGhmQiFpuxAKwmZEJ8G3vsaoA==
X-Received: by 2002:a05:6a00:b84:b0:732:2170:b696 with SMTP id
 d2e1a72fcca58-73426daad91mr19839807b3a.22.1740376556093; 
 Sun, 23 Feb 2025 21:55:56 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:55:55 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 01/17] arm: Remove stray .mmutable reference in linker script
Date: Sun, 23 Feb 2025 21:55:08 -0800
Message-ID: <20250224055524.1334929-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

The .mmutable section was deprecated in 2012 [1] and finally removed
entirely from U-Boot in 2022 [2], so this special handling is no longer
necessary. Remove it to tidy up the linker script.

[1]: dde3b70dcf3d ("arm: add a common .lds link script")
[2]: 3135ba642f9a ("arm: pxa: Remove CONFIG_CPU_PXA25X")

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/cpu/u-boot.lds | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 2f50087f57a..63e82a09fad 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -169,15 +169,6 @@ SECTIONS
 	_end = .;
 	_image_binary_end = .;
 
-	/*
-	 * Deprecated: this MMU section is used by pxa at present but
-	 * should not be used by new boards/CPUs.
-	 */
-	. = ALIGN(4096);
-	.mmutable : {
-		*(.mmutable)
-	}
-
 /*
  * These sections occupy the same memory, but their lifetimes do
  * not overlap: U-Boot initializes .bss only after applying dynamic
-- 
2.45.2

