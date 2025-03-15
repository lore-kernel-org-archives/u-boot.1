Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C06C35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83D3811DF;
	Sat, 15 Mar 2025 23:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E5o14acE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939A681100; Sat, 15 Mar 2025 23:18:23 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ABB28058A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223959039f4so66751365ad.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077100; x=1742681900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdBdtT/tZDocWsNJDE80Vl0rKR4EhGfgbqzhzPglR1s=;
 b=E5o14acE9GETSTl9fLF3OqjHjIF38A9F6gCGhtaSmkkNpJVywZmaJ1tPrtecABZzE2
 qQfdPWUXRC+O3jm7G06ey9B6XFnj3tWxX3TpVNtokB3k7Z4IEGvqcnkXfRCZV9hD/s7N
 8ZS2YFgMIjoMfbsha1zVTIXPZFLsYRPwKS7jWTSucvdQOCJ2EYIGqyuLBLYy7M3ok0Jt
 N8AB1cBBWKAiN/QxgN1Nbo4dIUzsxrabZB4KIxy+GCK3s9jFJipNQaq0ntl42vnPe7n0
 UBdl4fqkIamaLZVRyfUcv0mgJLXhInyP07pKwliBgj8mCr65nPgxZ6wyETK7LwIzkoRj
 bJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077100; x=1742681900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdBdtT/tZDocWsNJDE80Vl0rKR4EhGfgbqzhzPglR1s=;
 b=iIxHk3I1T9+f7uoX8ubfkOckxXivnbDDXNpv44nk0wK2iNTeBVkG5iJEHOGGHg/xec
 iE/pWHSqI7NcaKh+NgOwncEru4BlgaTW+OUEj3kJYPm+J2Yw3ouJ9I47yUVw8fSY4qlU
 0gfDUoDTp+5YhGlcy9hS4ybTYvOxMX3gUecpQnH4WsLV5j50IWg849bRnP2G1MYf0xfM
 CfTqM+/S2oexNHxEudv3fMz41kbGC19UIINP+q/1+LkgEk9QTiG4t5qCQuOUWdBI+uXZ
 t9AzNBocCn6X2J1nLGvgUKfNSirljfuOpEiKWdZo2nCa2/LJJCDsfI5ji8uyfGxGqA2U
 yvtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmMuaOTfeKwZMTBzI7IBxFKeLfW/8wtDrCErxyNzy283yAdIp7s9AsxdEtO3cPG2TPin8hznY=@lists.denx.de
X-Gm-Message-State: AOJu0YwscePVwcS6WOKY6m36I0SEFDXT9e9/qceXRhHj0wZrsaD6sc4G
 rcagnQiADpPL2mHXcQ4j9evmoWWq4t+kiqX4ZsEDSp+VckK3Q5BbF48RERtfcPM=
X-Gm-Gg: ASbGncuPTZcCv1YHVTMAHgM8C7ni6h/2VdIFIDClZV59eH4kCOFSeHGI/RNByWM7d84
 +MkYZ5SfFJ8Y01k1yMs2zN2EHbxbZMF1nmV4sN6h1859Us+vd+IEb9zWK4zQC9VAW1f7X4ClvEw
 Y6uXOpFwGZTSJmp8CoJPcEJDSSsUe/KbLy7GkRgQHBH6AMuE+qiHOmvWABpl6UaVeGSoLVeaQ+R
 UsY6BE6P9ocGxi6olGxjOc+dDvt92fRDRmNTdYy+ricTanbdvJ7ewnig6yy2A+ZI9AEMB/21K2U
 vEZ/JEFCPrNUvKY3ollm7C+gebJFRI7VUkrtFCAP+VOr/EIWUV4qi6CJlV/TorMTTQ==
X-Google-Smtp-Source: AGHT+IEoLYnGqPbGtUKsFOu5Xj2j36f0wsI1pt08mFguBKxOFqhPMbX54yQizWFmB2K3U4SQAGZ+iA==
X-Received: by 2002:a05:6a00:4f92:b0:736:532b:7c10 with SMTP id
 d2e1a72fcca58-737223fccabmr9033223b3a.21.1742077099853; 
 Sat, 15 Mar 2025 15:18:19 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:19 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 02/15] arm: Exclude eabi_compat from LTO
Date: Sat, 15 Mar 2025 15:18:00 -0700
Message-ID: <20250315221813.1265193-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

These symbols need to survive the IR-level dead function elimination pass,
since nothing at the IR level is referencing them (calls to these are inserted
later, at codegen time).

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 1c95dd6fed2..74cd5051552 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
 # For EABI conformant tool chains, provide eabi_compat()
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
 extra-y	+= eabi_compat.o
+CFLAGS_REMOVE_eabi_compat.o := $(LTO_CFLAGS)
 endif
 
 # some files can only build in ARM or THUMB2, not THUMB1
-- 
2.48.1

