Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55322C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8418888112;
	Tue, 23 Jul 2024 16:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="X672G+K/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9238D87DAD; Tue, 23 Jul 2024 16:44:46 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB12879C1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3E10E400E2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721745880;
 bh=bPecfUX14AZ3by7Joblw4n4wmultG97feotGpqJymos=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=X672G+K/HfcbM623xME8VSHC6rRkLVKYj1XNw+bQgGlYZFqQ0+QDPiUvE7Z24knud
 TbD+Sz0/USs5ir5PX3tvRpP1kNOMDKDIoIsd5Z5WmrjylBvry+GwvTjiw3FAyuy6dW
 kFi80mQCmpsk723Ayce5jmYATGaBfLZCOhr35x3wly5GT0EuY832kInPbEGw5dCdRu
 7D5IBITxXp8cxleVyGrU1Sj8raga9TCjQCnoZbtktYl1MfOjvGgLESy5lFvZbFzX3E
 gL5DGwL7AAw3ofXgZ8lbf0bToOYDRbb31nW5oZPPpdIfgtZf53eD3LhbTixLshMKpG
 ClnFhPAWBTA8A==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426703ac975so25387655e9.0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721745879; x=1722350679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPecfUX14AZ3by7Joblw4n4wmultG97feotGpqJymos=;
 b=EttKUIv4fWmExFrRxun0DZGq5mlyMDt/d98tkgzhhe1ClHxkYL8Rz1yYBVhGbugFXx
 PZUfBibja9gRgNq/7B+XwTlEmkz6wgl3a3WdednWEQn+UEwNGbSxLJOx0Uju++e3v9x6
 t7rr5TrxN4UOgEfXO51pimQTuhIlSSps9Qi7IdBN75CH31HNvzHfhnT9wwep2RihNii1
 zB1lXrysZ3zWPa1V2LDe2M2YGo7CVccEglP/1/YuHw0Q8Sh+yk3SzZq2hnI7FrK7i1qJ
 BR0HkMC64FHhHXBzhkp0mg7DIa3D/FUCDo2t63H3ZpTwTnwQet8xbcRQ4i/5SWoCMM5F
 eHyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMq0U8pcJrTEVisJmmD+9ew5eQIA7jZBbLQ680mxF0KLsVhj8Ro8jTkOx/g3E/Rdd0i/AekJLek7tRWcMkyx51BN3epQ==
X-Gm-Message-State: AOJu0YxO4ABKrzCP0HfOLOGHC4H+IQClmrriEwsIRz4Kt4sxhYqo3yLR
 DARjHITtKp8HLjMjf5wihTPYtznwYbFtvHo8Bcr9dNTkfN+mrm3vKOJXyogZNxa+hj7frTgD3aI
 +hvurAh14XZvS1cbkqYYu0645wbXVVz32EFteOkcS5xEy5ltCmbjrv1NnAB9aynHeAm8=
X-Received: by 2002:a05:600c:1f8c:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-427eef58524mr19463745e9.0.1721745879695; 
 Tue, 23 Jul 2024 07:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqGtRUzXUjYu3Oo312fioHKmzvxF0C3hDP+ZwTlV28qLEDcJtwJ07F/c92GH0e5nX/1Q75kQ==
X-Received: by 2002:a05:600c:1f8c:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-427eef58524mr19463625e9.0.1721745879295; 
 Tue, 23 Jul 2024 07:44:39 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6906a96sm180042065e9.22.2024.07.23.07.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:44:38 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] smbios: add extended Extended BIOS ROM Size
Date: Tue, 23 Jul 2024 16:44:23 +0200
Message-ID: <20240723144423.191677-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Replace 0x01000000 by SZ_16M
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
index 4126466e34a..7c24ea129eb 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -22,6 +22,7 @@
 #include <cpu.h>
 #include <dm/uclass-internal.h>
 #endif
+#include <linux/sizes.h>
 
 /* Safeguard for checking that U_BOOT_VERSION_NUM macros are compatible with U_BOOT_DMI */
 #if U_BOOT_VERSION_NUM < 2000 || U_BOOT_VERSION_NUM > 2099 || \
@@ -348,7 +349,13 @@ static int smbios_write_type0(ulong *current, int handle,
 #endif
 	t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
 #ifdef CONFIG_ROM_SIZE
-	t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
+	if (CONFIG_ROM_SIZE < SZ_16M) {
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

