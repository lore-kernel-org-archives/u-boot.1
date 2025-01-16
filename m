Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4754BC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482248022B;
	Thu, 16 Jan 2025 12:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="auAE64r0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB2180708; Thu, 16 Jan 2025 12:39:45 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 949CE80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 29EB43F680
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737027578;
 bh=2POAWF7KsHWoPrYHjPbA/tOnYMYnO/tGr/7MMi+IwaU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=auAE64r0pD/eVRbOZxFsR8iunWP6jZaPrMplqJbooNO/g0a1tWsW8yNNf4mIwWvVN
 l71CZIT58hV9eqlo1+XbYON+4JthdMok9LNV9wEzxRfmpDllALV3bSmU/H4l2bWaMa
 0YsGo6a2wbwenZVz2R90yiJZFGbM4rCnHfevXV2JuhrzzJsox7ACPGE8p2WClNoKhw
 sUvtuJmAm7+sK0HZbyn2iFaN+cf9wGFnMW/EXINabiL9mPGEdQuhx7g/pT0FHCU9ir
 FWkEDWdbi22qnDaim8eATizgSmKQArLn6RAAfrOOeQmzJReC/8S1yUhyWZT2OVDbaS
 g6XlMuQXa0OFQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso3622655e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 03:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737027561; x=1737632361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2POAWF7KsHWoPrYHjPbA/tOnYMYnO/tGr/7MMi+IwaU=;
 b=ZPmCkQjq62r3bRKQFTRZrRNrMC2zk1enhpHSwcOAKV+RKRgUHdaf1RvTPZlE2NowO+
 sby4V7B0VbJNlFm405+V2VJsr5DztyIwuQfcL6YSmgXPcX5MI6u/uFVLwTYjLAAz6x4D
 MI96VzFMTyWCz+GmTOETY14XTuaFTsWxEjNd+MugUG2/fBpeBy688cCv6M1SqKNcnlZM
 8U5yt+cZLhMJ/NYMnaAX65Jx7rsHE1htGyLd+Njh15KJag7Y4ELwjyNvX+HmmSf13OZp
 mIE9JwchtyzIn8cj/N5B3bg+WIBXKc1LItTiJZOfjy/PwovJxm39mWO3y/2eHULY9VSM
 Gzcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbv9qmkt55uLEL1LBdsAU1EQNYQ2DPgBmzTYAW7TSarTD0GcaDgC8WyVZHh/zOvlQGgOxdeIk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7RL2MwpuADXZ+QXAfBfGEsV8JbucEl7z/kb18VRRglx3FgapX
 4dkHj68hx2zg6oi20pSZAz2MFI1EoqKVq2gBOgiEGY3TdjbZLRpKX8pXC0lmZmAKbDRiUaTti0B
 lwc8Zyes0quwRR4Nn6PRd/11htjclE0a34KwMMiOMKNICb8VTpg1ma48gq1dOJoahBJg=
X-Gm-Gg: ASbGncsioEjWVYFXNYbwjBpLVCeN8VcNegnGxWbVgr/pgA9fRCP80icX/JGgPyw1EXV
 QKJ/C2dSh+icBfg0Vn+zMqQhENX95Rki58WVgsMIatikDtEe8yMG603KxW15HODkde3GArTMy7J
 aHfR+hDaeyb08pWhtd9k3uWvbgFrTzkR6s3xYcdxzHudeJ+t8eeotJqgAp0Y9xw7KSxlbbCnyUb
 WVfwQ3cqOSNgeAeG7XrF+yDChun/ubQDsf7SNqfIzPJzQ7dgNct0e4eVYVSK+K3evtsRhTl7n43
 meSrO97Dbfa66w==
X-Received: by 2002:a05:600c:45c3:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-436e26e554dmr15927595e9.24.1737027561423; 
 Thu, 16 Jan 2025 03:39:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2T73Pt/jswXeG699taKpClc8qvqYeJ5teEsuHUY9GyeC14gedsnAnZ4hn1ewurWEnPAac8Q==
X-Received: by 2002:a05:600c:45c3:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-436e26e554dmr15927355e9.24.1737027561009; 
 Thu, 16 Jan 2025 03:39:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm20606320f8f.39.2025.01.16.03.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:39:20 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/5] efi_loader: correct SizeOfCode, SizeOfInitializedData
Date: Thu, 16 Jan 2025 12:39:08 +0100
Message-ID: <20250116113909.113950-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
References: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
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

The fields SizeOfCode, SizeOfInitializedData, and SizeOfUninitializedData
are define in the PE-COFF specification [1].

* SizeOfCode must match the size of all .text sections.
* SizeOfInitializedData must match the size of all .data sections.
* SizeOfUninitializedData must match the size of all .bss sections.

We only have one .text and one .data section. SizeOfCode and
SizeOfInitializedData have to be calculated as the difference between
the end and the start of the respective section.

As we don't have any .bss sections in the generated EFI binaries.
SizeOfUninitializedData must remain 0.

[1] https://learn.microsoft.com/en-us/windows/win32/debug/pe-format

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 arch/arm/lib/crt0_aarch64_efi.S | 2 +-
 arch/arm/lib/crt0_arm_efi.S     | 4 ++--
 arch/riscv/lib/crt0_riscv_efi.S | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64_efi.S
index fe6eca576ec..e21b54fdbcb 100644
--- a/arch/arm/lib/crt0_aarch64_efi.S
+++ b/arch/arm/lib/crt0_aarch64_efi.S
@@ -41,7 +41,7 @@ optional_header:
 	.byte	0x02				/* MajorLinkerVersion */
 	.byte	0x14				/* MinorLinkerVersion */
 	.long	_etext - _start			/* SizeOfCode */
-	.long	0				/* SizeOfInitializedData */
+	.long	_data_size			/* SizeOfInitializedData */
 	.long	0				/* SizeOfUninitializedData */
 	.long	_start - ImageBase		/* AddressOfEntryPoint */
 	.long	_start - ImageBase		/* BaseOfCode */
diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index b5dfd4e3819..3664cce8412 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -38,8 +38,8 @@ optional_header:
 	.short	IMAGE_NT_OPTIONAL_HDR32_MAGIC	/* PE32 format */
 	.byte	0x02				/* MajorLinkerVersion */
 	.byte	0x14				/* MinorLinkerVersion */
-	.long	_edata - _start			/* SizeOfCode */
-	.long	0				/* SizeOfInitializedData */
+	.long	_etext - _start			/* SizeOfCode */
+	.long	_data_size			/* SizeOfInitializedData */
 	.long	0				/* SizeOfUninitializedData */
 	.long	_start - image_base		/* AddressOfEntryPoint */
 	.long	_start - image_base		/* BaseOfCode */
diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv_efi.S
index c7a4559eac8..9eacbe4a859 100644
--- a/arch/riscv/lib/crt0_riscv_efi.S
+++ b/arch/riscv/lib/crt0_riscv_efi.S
@@ -63,8 +63,8 @@ optional_header:
 	.short	PE_MAGIC			/* PE32(+) format */
 	.byte	0x02				/* MajorLinkerVersion */
 	.byte	0x14				/* MinorLinkerVersion */
-	.long	_edata - _start			/* SizeOfCode */
-	.long	0				/* SizeOfInitializedData */
+	.long	_etext - _start			/* SizeOfCode */
+	.long	_data_size			/* SizeOfInitializedData */
 	.long	0				/* SizeOfUninitializedData */
 	.long	_start - ImageBase		/* AddressOfEntryPoint */
 	.long	_start - ImageBase		/* BaseOfCode */
-- 
2.47.1

