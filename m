Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6D2E784A8
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 03:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9896C87165;
	Tue,  3 Oct 2023 05:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="At9YnI3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7AE869D8; Tue,  3 Oct 2023 05:58:13 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89CD586DD9
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 05:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c328b53aeaso3609795ad.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 20:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696305489; x=1696910289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mzgM/sYMM0sjd4of5sG56k8jyEs9VKt0b2+rmNoUcfg=;
 b=At9YnI3gfOJjOPKaUKuyaVxIZcKZvUAY5uSiZt+PHcbtxG11qCP6b6t6yXdfW8vhzN
 KzpOfSt/i0olDnVh8Cp1nM/ycVFI1uYzyWJ3TKbd9sku1MsSNqMPyCBL8Ewy9F6zVADp
 ysCih8n4Ol47VAkIVuu/X0ze4gPGBGdkDYUHX/SiRBwR2V31VpwNmNcHaCb0jf5hBq9t
 GPv/oD25fUAo71dsc+ty2eOX9AJZ9NM6endqWYsSLyQpLz2bFQqdBJDmyOa1zF64sybN
 6UCxAC5cddl6w5G3f98kY2HWym/DZAPR9jPQHzP8kVeqosIWF8BvpS3o1mdR6Dnn+Uq5
 Twsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696305489; x=1696910289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mzgM/sYMM0sjd4of5sG56k8jyEs9VKt0b2+rmNoUcfg=;
 b=O24Rpp7iTWB+8j7Vj8+oqUv8JnLJT8zEnPLPI1YHjdSL/H+tLnHiCe99YA5i4PWNuQ
 OSqx/n83GELoByuqTmQKD0Uejo+pqy7hL5+8CZTRwaDLu9rVJXTMOAffU72CKGPHnrxo
 VLE5NmdHT7neZZM3uSQ8QGaCxN+Sw7QXqHB2SBUu13tI6nPYFsxWjzS1ULWBmpOqFrL7
 DW+MNn5bMD5DMw+/I/McyKlsL13v8MSYxdu19CESGjXxiZLdWu5Yy3weZRZ5H/KoTYo4
 btEOe5xZEeMKYTl/Hcyfe76u7FQ0GpOwjSwW8yFyWMTR5Ce+dBb2zgSoL6gXwKnweP47
 DxRA==
X-Gm-Message-State: AOJu0Ywb1jQC/HI/MP5S3ey8gha7ReAfAlQ3OHIccPkTrdT0/pKu9fae
 5Xl7P6yJx3qDGXxY1QT3/VgmQvefJ3FzvA==
X-Google-Smtp-Source: AGHT+IHY+bAnqPeynOVZf3IwgpMcnPe0I1u6LhN6736FHFkpCKSJt2OG2S7M0DKP/edREGQemIW7Dg==
X-Received: by 2002:a17:902:d2ce:b0:1c3:ed30:ce0a with SMTP id
 n14-20020a170902d2ce00b001c3ed30ce0amr17933614plc.19.1696305489201; 
 Mon, 02 Oct 2023 20:58:09 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:f6be:e369:f897:f543])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a17090341c200b001b86492d724sm270112ple.223.2023.10.02.20.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 20:58:08 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm: mvebu: x240: Disable SMBIOS
Date: Tue,  3 Oct 2023 16:57:38 +1300
Message-ID: <20231003035800.2626121-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.42.0
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

The x240 doesn't make use of EFI or SMBIOS. Recently we started seeing
boot failures such as

    WARNING: SMBIOS table_address overflow 23f60c020
    Failed to write SMBIOS table
    initcall failed at event 10/(unknown) (err=-22)
    ### ERROR ### Please RESET the board ###

The error is because the physical address of the RAM on the AC5X SoC is
above the 32GiB boundary. As we don't need SMBIOS or EFI this can be
safely disabled.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 configs/x240_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/x240_defconfig b/configs/x240_defconfig
index 7d2b8603e6f4..0d5a19df25aa 100644
--- a/configs/x240_defconfig
+++ b/configs/x240_defconfig
@@ -84,3 +84,4 @@ CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 # CONFIG_FAT_WRITE is not set
+# CONFIG_SMBIOS is not set
-- 
2.42.0

