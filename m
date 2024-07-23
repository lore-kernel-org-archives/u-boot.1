Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA6EC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 10:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB9478865D;
	Tue, 23 Jul 2024 12:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="H0YriGDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8492F88681; Tue, 23 Jul 2024 12:46:54 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3AC88602
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 12:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E4E973F730
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721731606;
 bh=MXt0I/gKud944IgI/iksjKSDVUlr1FlhnUuSCeT3koA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=H0YriGDd7rTVGuqfLIJReFSzYBt0GHlDFG8EYIj+7NvA6PZp05/L3eOpK2OYexNzc
 rc31usE3G1ZBIwqhm1IYcaVhKDdrrnNntOldgCwOI/T7WCVm+K3gjea13CFwHKBB30
 jcdMG/QSnbYA48i0i2ySpWK8QBKukJty5+Ni2o8zzhy+qDWzZfFp7Ukckox1a9CSGw
 v/97K60O6COUXsO34LowCrFItMSYQ7le7sDsRhtvVYNIapGh6ZnQTwkLHmJDbqBvo5
 CljSMFmVnUPZm/+zV2D9rxECVCzpZCYTCZ3/dXZL+pmJjvvvdrK4MIzu5t3JIiTHZP
 3+zFN5XgfZ56w==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-427a7a65e7dso21523745e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 03:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721731606; x=1722336406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MXt0I/gKud944IgI/iksjKSDVUlr1FlhnUuSCeT3koA=;
 b=EMlrkzfa8rsDEWVTxUtBKzepQD/Kw+PMeiAlwy4wlBaEYL2DGfFTON6UhLtp4XlWX6
 A8/FxKyXXJDxsESbKXzxNJZjVhjuq2Hi630hLTh9/1qX26rBwWkteTr20LPy/4CNkfRk
 4kvY5xqnLIY5fMdcROp1JmNGI6psnCEvLhbEkzKF34lszinXiJxLAQKL1MVnwfeUk3+8
 ZOOkO4Uhhu7Nmim/ao0pTXbv3fxvOm3FSvJ7UPUye55F0EfEEBGazzUz7o55bCr3qyFC
 nEQAiC/oRdnE3YWeqpmK4i32dogdL0LJ0zNP9m4L3eGoyIPGBCasAjNUQAyAZC0DHjr/
 fUwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmsajBbfHvRMYC9fIwMTVst1eg+QMxpPS6whcd6yAF8V2EaRpDh9T1QP7bIR2FY3etyXn5zGe0cD5FBfUl5vynlaMOug==
X-Gm-Message-State: AOJu0YzPworRiF9jMHQ+Z2B9gp5jODxsHRgOcpI4fTTEow1lrtiPfUTl
 m3tIuQV6GFATU6K5lW7EenwbpS5Rtwr8MvB0+4GWyR+Rag7ij/pGUhGNJ2iH82dwn32iWMPxXTU
 EL8wVCSSzJhorMOnxei76pv7z3Zs/NOFtaZR4jAvg+WqdbG0YL7fBwtIRyczMAHS9A5c=
X-Received: by 2002:a05:600c:190d:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-427efa0729emr11559285e9.4.1721731606547; 
 Tue, 23 Jul 2024 03:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE3KpXg8H3qwio+vMTqYyzOtupXUc5TkwXcbT70YmxAYlkW3IszYN2A6mmAk/8KgZnvaDBYw==
X-Received: by 2002:a05:600c:190d:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-427efa0729emr11559095e9.4.1721731606161; 
 Tue, 23 Jul 2024 03:46:46 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69385ddsm166137345e9.48.2024.07.23.03.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:46:45 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] smbios: add extended Extended BIOS ROM Size
Date: Tue, 23 Jul 2024 12:46:34 +0200
Message-ID: <20240723104634.116082-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

U-Boot claims to create SMBIOS 3.7 tables. The type 0 table has
a field Extended BIOS ROM Size since version 3.1.

BIOS ROM sizes of 16 MiB or above must be written to this field.

Add and fill the missing field.

This patch does not cover the case of a ROM >= 8 GiB which cannot
be configured in U-Boot.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/smbios.h | 1 +
 lib/smbios.c     | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/smbios.h b/include/smbios.h
index a4fda9df7bd..00119d7a60c 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -105,6 +105,7 @@ struct __packed smbios_type0 {
 	u8 bios_minor_release;
 	u8 ec_major_release;
 	u8 ec_minor_release;
+	u16 extended_bios_rom_size;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
diff --git a/lib/smbios.c b/lib/smbios.c
index 4126466e34a..e2a2f873a94 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -348,7 +348,14 @@ static int smbios_write_type0(ulong *current, int handle,
 #endif
 	t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
 #ifdef CONFIG_ROM_SIZE
-	t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
+	if (CONFIG_ROM_SIZE < 0x1000000) {
+		/* CONFIG_ROM_SIZE < 16 MiB */
+		t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
+	} else {
+		/* CONFIG_ROM_SIZE < 8 GiB */
+		t->bios_rom_size = 0xff;
+		t->extended_bios_rom_size = CONFIG_ROM_SIZE >> 20;
+	}
 #endif
 	t->bios_characteristics = BIOS_CHARACTERISTICS_PCI_SUPPORTED |
 				  BIOS_CHARACTERISTICS_SELECTABLE_BOOT |
-- 
2.45.2

