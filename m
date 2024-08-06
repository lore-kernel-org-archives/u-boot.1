Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0856C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983D688AEE;
	Tue,  6 Aug 2024 14:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EAIFuOss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E190588ACB; Tue,  6 Aug 2024 14:59:49 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B140D88A65
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39b3c36d3adso1890395ab.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949183; x=1723553983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEEYW3Rd0sm66i8TvT1qei5KPB0sKRYH365a5bohqng=;
 b=EAIFuOssDYX35X3ma7UFrdpVwaOZnR9Z0MXhygB81D+V6wMs+emrU9QQ0npcLiBN6j
 Vr6USxDjDa69vrv9EUZElFci/npwiA5lFcWfGKJh/k6epO6b66Ap4ytRqM2L43HymDIk
 FydfFAneOK1bVI31PdiI9Gk7KjA4uYzsugMiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949183; x=1723553983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEEYW3Rd0sm66i8TvT1qei5KPB0sKRYH365a5bohqng=;
 b=tT6uew16GoYKVshllFu3qiVxuOq/AoAA2xXu4jFRfGKRxct3gUiQuWxmbjiecsQdsD
 iSBdwRNQosPGq2iQjN582EQXp5mNk9K8DHzE4UYJUPfcd7qP98gPI81xay4CLUOTtcgC
 x3QRP6LvURHTVN8bmbWwkASa9nEvhTpQxMkztBh9LsT40zL8MHQPrOLhKTIVfdPk+0CG
 J4Yqz8GwyFGuZkM3w4ivYFdRQ/Jmj1pY7RQo2lfZj82P/VINqbg9JW4ulpO6fTYHrw++
 Fw9Db22E7G2TO1VyEpZmTNUxcuQDHxF50jHdb3/I8nP3vxZY1jzSLw82jzZIjDeDU5AL
 2DTw==
X-Gm-Message-State: AOJu0YyJXPnj1d+tealXuzPhudTZAOMMmLjb9FKsiPtCtPDaT1YkKTmy
 Z9RzZ2jiJy+HhepzDkCdKkNhSXxOZPh0yhLv4Z/DFCfIIUWx/pADNlcVy8ZWliXFT6dbn+xUGzQ
 =
X-Google-Smtp-Source: AGHT+IEB6h0iL28B9SGsAdmhg4DnZPzn0XM2DuhRr2Mw52/340l3tTvVmUmAGIRNk3S8SQF59uqR8g==
X-Received: by 2002:a92:c10b:0:b0:39b:4ec2:c5be with SMTP id
 e9e14a558f8ab-39b4ec2c848mr9590865ab.27.1722949183360; 
 Tue, 06 Aug 2024 05:59:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 28/39] efi_loader: Shorten the app rules
Date: Tue,  6 Aug 2024 06:58:39 -0600
Message-Id: <20240806125850.2316956-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

We have quite a few apps now, so create a way to specify them as a list
rather than repeating the same rules again and again.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/Makefile | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 27dbd9e760d..660368b9d8f 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -22,29 +22,13 @@ CFLAGS_REMOVE_dtbdump.o := $(CFLAGS_NON_EFI)
 CFLAGS_initrddump.o := $(CFLAGS_EFI) -Os -ffreestanding
 CFLAGS_REMOVE_initrddump.o := $(CFLAGS_NON_EFI)
 
-ifdef CONFIG_RISCV
-always += boothart.efi
-targets += boothart.o
-endif
-
-ifneq ($(CONFIG_BOOTEFI_HELLO_COMPILE),)
-always += helloworld.efi
-targets += helloworld.o
-endif
-
-ifneq ($(CONFIG_GENERATE_SMBIOS_TABLE),)
-always += smbiosdump.efi
-targets += smbiosdump.o
-endif
-
+# These are the apps that are built
+apps-$(CONFIG_RISCV) += boothart
+apps-$(CONFIG_BOOTEFI_HELLO_COMPILE) += helloworld
+apps-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbiosdump
+apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
-always += dtbdump.efi
-targets += dtbdump.o
-endif
-
-ifdef CONFIG_EFI_LOAD_FILE2_INITRD
-always += initrddump.efi
-targets += initrddump.o
+apps-y += dtbdump
 endif
 
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
@@ -95,3 +79,6 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
 
 EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
 $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
+
+always += $(foreach f,$(apps-y),$(f).efi)
+targets += $(foreach f,$(apps-y),$(f).o)
-- 
2.34.1

