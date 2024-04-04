Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24D1CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D798844D;
	Thu,  4 Apr 2024 13:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YfCKVjtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22EC8844F; Thu,  4 Apr 2024 13:49:50 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81118842E
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A3FBD3FFDE
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712231316;
 bh=VOX/44WriPS/J7RlAnw7/10halyOzFRbps6l/49tGVE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=YfCKVjtd9JM85eBehvo3DEBgbKZ5Y6+efjYeVnoCtf4NSJFSKnQgCgqDRTY9DtIU5
 FcJTQ3S1pjsUqBe6ie4Ax3thncZ6dxP8xLWm2H6R3KPToTAiVkQ2FcjsHm8jGItesT
 zLgxK+3cB77V2llms7lgyKTgd/qzDFJKKovlULWUBo7MqWbBDvXpH1HIcLLEg7m4Uc
 BZq0LwG70tCt88JEh0x7JbyU3s6LTLCeEjXBF/lh5vgeQBBwQUOrASW7oNQwF/ckjO
 vOd5sPE2zeU+dKQKOV4EDi6h+h7UTewKIk2SPfIJ6S4i1fijrCxv5b+lGai1Mj/lTM
 7Ai99xo2FeBEA==
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-515bbb9a73aso843302e87.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712231276; x=1712836076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOX/44WriPS/J7RlAnw7/10halyOzFRbps6l/49tGVE=;
 b=VIQULSpb40ILodIjDaoE7+oTD/z8RaASWExZbJEt04FfRAKFRpyPmwtKCi+rIWtFgJ
 oDKohUy7cL1lwhuYj7tQWobCMvvCxob513WmdpMXUKhJD2jlJ2A6fktNQkko0GiaBK8S
 ERqM/tF6Ur+wNJ2bTjOC7qJrT27mBRNiOdm0P3hO+9S6sF2qosS/nzsU5fh8W17M6Iph
 dxk6dKUjNHZHVfegtLTusvjs2ZhbuXaeZf18BOy46tVXx0qEcS+88UlQl3mf7mmpdQXl
 5ti5FSV+hfqBed2uoUFSYfUNBkuPBYG6fZUI81TfSqeWfAg2jkh91UJQkALOXUlT/Wyo
 RG6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE9COnSgUfz9XN67vS4hiO9xYEJCUGvJ2X8z1YYrQ2F7rSDiZjZHAMNXyJAi08eYptmDnyio2ZD1nj7FQz7F0EqNloIQ==
X-Gm-Message-State: AOJu0Yxq2Qos8y+9WoGAIHY77kSWyQWGCWgJh/J+C2m0EAgWAHAXgpd/
 Mvh76Dt9vzToXAt/vhMbKPdeOcekml8JD8BDft8THHD9HF9bQ63GNHkl9Geecj4pzaZ//IjAzhZ
 3kXtpVuzdeFsjfoArYOAlj10xO/1FW0F5df3tRwqaJEY2/KviZYn0ZkdTbaMgwV9W440=
X-Received: by 2002:ac2:4886:0:b0:515:d326:9e0c with SMTP id
 x6-20020ac24886000000b00515d3269e0cmr1360849lfc.3.1712231276497; 
 Thu, 04 Apr 2024 04:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI8atC1kMmS47zcFYQJNWNhyJSaGFVNt5WH+P3E+JpCTZtYVtwhBrbrP5YOlb1LHCw6c4NQw==
X-Received: by 2002:ac2:4886:0:b0:515:d326:9e0c with SMTP id
 x6-20020ac24886000000b00515d3269e0cmr1360836lfc.3.1712231276078; 
 Thu, 04 Apr 2024 04:47:56 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a05600c350200b00414906f1ea1sm2422134wmq.17.2024.04.04.04.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 04:47:55 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>,
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/4] efi_loader: move HOST_ARCH to version_autogenerated.h
Date: Thu,  4 Apr 2024 13:47:41 +0200
Message-ID: <20240404114742.81187-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
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

efi_default_filename.h requires HOST_ARCH to be defined. Up to now we
defined it via a CFLAGS. This does not scale. Add the symbol to
version_autogenerated.h instead.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 Makefile                | 1 +
 arch/sandbox/config.mk  | 2 --
 include/host_arch.h     | 2 ++
 lib/efi_loader/Makefile | 3 +--
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ba660976547..1069adca91e 100644
--- a/Makefile
+++ b/Makefile
@@ -1963,6 +1963,7 @@ define filechk_version.h
 	echo \#define U_BOOT_VERSION_NUM $(VERSION); \
 	echo \#define U_BOOT_VERSION_NUM_PATCH $$(echo $(PATCHLEVEL) | \
 		sed -e "s/^0*//"); \
+	echo \#define HOST_ARCH $(HOST_ARCH); \
 	echo \#define CC_VERSION_STRING \"$$(LC_ALL=C $(CC) --version | head -n 1)\"; \
 	echo \#define LD_VERSION_STRING \"$$(LC_ALL=C $(LD) --version | head -n 1)\"; )
 endef
diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index 1d50991f8d2..405843800e9 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -69,5 +69,3 @@ EFI_LDS := ${SRCDIR}/../../../arch/riscv/lib/elf_riscv64_efi.lds
 endif
 EFI_CRT0 := crt0_sandbox_efi.o
 EFI_RELOC := reloc_sandbox_efi.o
-AFLAGS_crt0_sandbox_efi.o += -DHOST_ARCH="$(HOST_ARCH)"
-CFLAGS_reloc_sandbox_efi.o += -DHOST_ARCH="$(HOST_ARCH)"
diff --git a/include/host_arch.h b/include/host_arch.h
index 169d4945136..261194bd7c6 100644
--- a/include/host_arch.h
+++ b/include/host_arch.h
@@ -16,6 +16,8 @@ export HOST_ARCH_X86=0x0386
 export HOST_ARCH_X86_64=0x8664
 #endif
 
+#include <version.h>
+
 #define HOST_ARCH_AARCH64 0xaa64
 #define HOST_ARCH_ARM 0x00a7
 #define HOST_ARCH_RISCV32 0x5032
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index fcb0af7e7d6..086521fb287 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -6,8 +6,7 @@
 # This file only gets included with CONFIG_EFI_LOADER set, so all
 # object inclusion implicitly depends on it
 
-asflags-y += -DHOST_ARCH="$(HOST_ARCH)" -I.
-ccflags-y += -DHOST_ARCH="$(HOST_ARCH)"
+asflags-y += -I.
 
 CFLAGS_efi_boottime.o += \
   -DFW_VERSION="0x$(VERSION)" \
-- 
2.43.0

