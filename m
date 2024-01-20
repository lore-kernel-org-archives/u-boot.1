Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23151C47DAF
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 00:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB23D87C08;
	Sat, 20 Jan 2024 01:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EWhtbqu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18CC6879E6; Sat, 20 Jan 2024 01:14:26 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE90187842
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 01:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malu.bertsch@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so11862145e9.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705709663; x=1706314463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4l5bEtTHFf/4I9UXrwL1/ZLwC3EOF5jP4JPC88NNWSs=;
 b=EWhtbqu7hqgXbQd/h/01z1ktgoikLQJTsywpQ5NiUigMofKtv5j6o7FJviV4lbSeI9
 z6HlDBerKsdxQUuHQ5w5cEUQSf1CcxyeADf7jWdc6g5KCM9ORCPdat7VIOrYQ965/152
 QUviZdWcTGeeFEAup4rX4G9vLL40742m9Gi13USgQT3VZoctD/xOyJ273vJ8e4k203Fw
 AydP46tTmmpa8Orqqmu/OG7FEPlzd2NwRtiDuZxEB0CwUeC4BEZdlI/AvvK2zBEuSv8f
 dpMBXktVxSdSXLVydbQQXm7HNXT2OVaHqbZ0ULUOLoKajZ6heNpQesGVtgI/Yk/wiHXE
 6VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705709663; x=1706314463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4l5bEtTHFf/4I9UXrwL1/ZLwC3EOF5jP4JPC88NNWSs=;
 b=kIB52kbjLKtLDqVy4kR81Lke7R+rxSvpz4lj/sOdVwNoesINp0Js8usgCVieSH+5XD
 TUd8AZ+Mrk7rkg3VGQzhkvcWbsZP+ffEYqvqd4r6jPsOlCq7tMb7RDSdbwxqzduKvf6U
 CFtW0Y1Zv+UOMUP7y4clkAG8BwXpfvSH5FqMlQf14OexcyCNgfEP4Dn7lQFW3kvJcony
 guvBpPVjf9XU6V1ioE2ziu2PeDCg6tGdMx8lzlLxLCLA25Ou3R/bT32Ym8M3hxxPbgqo
 8UL6SZvLEd8F1rxDSydHbYmZ7lpWuQ8Q3ZNrFYiJjZihEvPKV4np8a5fOlQo1jZopAJW
 qMPQ==
X-Gm-Message-State: AOJu0Yzk3FetxdiL1Gf51xMhjaCizXcDRRUb7egozq7aRfnNJ/LC0xPI
 y6L2dGkn9fJDJzUCgfxp26oHBRuKMR/UdpvMHaX/QrGREp0neFwTpTism+0WzzQ=
X-Google-Smtp-Source: AGHT+IEKbR17I93GIpTevqF9QYjcznXfRN77cp/w4s2XwgcW2C4tLm9yIgG72TROcrkB2JD5LOZnJA==
X-Received: by 2002:a05:600c:1d24:b0:40e:6227:175e with SMTP id
 l36-20020a05600c1d2400b0040e6227175emr324221wms.61.1705709663132; 
 Fri, 19 Jan 2024 16:14:23 -0800 (PST)
Received: from localhost.localdomain (pd9fafaa6.dip0.t-ipconnect.de.
 [217.250.250.166]) by smtp.gmail.com with ESMTPSA id
 w4-20020a05600c474400b0040d5ae2906esm34705140wmo.30.2024.01.19.16.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 16:14:22 -0800 (PST)
From: "=?UTF-8?q?kleines=20Filmr=C3=B6llchen?=" <malu.bertsch@gmail.com>
X-Google-Original-From: =?UTF-8?q?kleines=20Filmr=C3=B6llchen?=
 <filmroellchen@serenityos.org>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?kleines=20Filmr=C3=B6llchen?= <filmroellchen@serenityos.org>,
 Bin Meng <bmeng@tinylab.org>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] riscv: Support building with Clang
Date: Sat, 20 Jan 2024 01:14:04 +0100
Message-Id: <20240120001405.29294-2-filmroellchen@serenityos.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120001405.29294-1-filmroellchen@serenityos.org>
References: <20240120001405.29294-1-filmroellchen@serenityos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jan 2024 01:15:27 +0100
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

The -ffixed-gp option of GCC has an exact equivalent of -ffixed-x3 in
Clang.

Signed-off-by: kleines Filmröllchen <filmroellchen@serenityos.org>
---

 arch/riscv/config.mk | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/config.mk b/arch/riscv/config.mk
index 9cf2aef0a4..dc4f30d673 100644
--- a/arch/riscv/config.mk
+++ b/arch/riscv/config.mk
@@ -9,6 +9,9 @@
 # Copyright (C) 2017 Andes Technology Corporation
 # Rick Chen, Andes Technology Corporation <rick@andestech.com>
 #
+# Copyright (C) 2024 the SerenityOS project
+# kleines Filmröllchen <filmroellchen@serenityos.org>
+#
 
 32bit-emul		:= elf32lriscv
 64bit-emul		:= elf64lriscv
@@ -25,7 +28,12 @@ EFI_LDS			:= elf_riscv64_efi.lds
 PLATFORM_ELFFLAGS	+= -B riscv -O elf64-littleriscv
 endif
 
-PLATFORM_CPPFLAGS	+= -ffixed-gp -fpic
+PLATFORM_CPPFLAGS	+= -fpic
+ifeq ($(cc-name),clang)
+PLATFORM_CPPFLAGS   += -ffixed-x3
+else
+PLATFORM_CPPFLAGS   += -ffixed-gp
+endif
 PLATFORM_RELFLAGS	+= -fno-common -ffunction-sections -fdata-sections
 LDFLAGS_u-boot		+= --gc-sections -static -pie
 
-- 
2.39.2
