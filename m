Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052EDC47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3443C879F4;
	Wed, 17 Jan 2024 16:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="es623yDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27F6876D3; Wed, 17 Jan 2024 16:34:05 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C05879B2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EBC0C3F276
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705505638;
 bh=dAU6fzBubYU/BoQZYees/HT9dP/++1vqorQEjD8tUpw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=es623yDXt62g4BuuMx0Dzt9ZBjtf0j7jMK2zHqnoOrSF8UimwCgz4JdGlavcAkbuq
 UQlZALf8OgXls5wS7vXJIthvebV2Q6TTMeULPH/u/4GhVIZIeZmObyvpZGk993rQ7i
 ssJ6J+MbtAe8IHSnRJ9fgVbBx8Fvq8hSPeUQh1gWC8RMjmjJN4ZCt+PeZRA0UtXqzB
 El/bzS165VD+lTOxXZpae8Y8qwGNkp0k1/ZMNHCYBQdBajNNEpOMU+E2F/XHdfAcY0
 lsfb/T0/xBEInPCOAjBZJm7l41tur2/S4UefP9mwX9Y5rMbAJEO4KnvQtXT3/O6R2O
 3nROk8JiRui7Q==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e419b52d5so83740235e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 07:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705505638; x=1706110438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAU6fzBubYU/BoQZYees/HT9dP/++1vqorQEjD8tUpw=;
 b=CnhcX5HiyA0qNHm85N4TNknPbplVNcIqiKTDWnSTVW07mp5d2Hbw0SyFadN4r4eAUT
 pj9T3MQb9L+s4lfEMYlWzo/wpuo1LfiJoCi+Pmi96psEpROzOYtU1HuXDvNa0MUI2cTh
 JW6E9TRckGO0NxtUTiz0qBVtRdqjKTGGVoR/a6ZBorvpTqv7O73tN0kiwY2isrTuprpT
 8E8gtAKhyb7632i+Qgp3uD2ubTt9OaCm0k1d2oRL8tDvIjDppnGn+njNHvu9OOTeo2CQ
 b7lpAshLhXjB+rMC6wpKxpdmi+NeJSPC2wjSMVPMRR0WYNCeUqb8klK5bas3GuVmMl32
 t5Zg==
X-Gm-Message-State: AOJu0Yyh3uJXkger922NzUlHgznBC71P5dYXdP1k/C6PnBfTy0nMeH1O
 vIefigwrU79JgRBnU1cDmiBKuHHnNxdgf4qnlT3Oj6YfkJIuPibmcQq/3Sm6KMCfNQToY7OE/+L
 feReBVd9F2Vw8BU7S8y3pXPlJmAQjKG98yO2Ftg==
X-Received: by 2002:a7b:c3c6:0:b0:40e:67a5:8666 with SMTP id
 t6-20020a7bc3c6000000b0040e67a58666mr4302596wmj.49.1705505638531; 
 Wed, 17 Jan 2024 07:33:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNxXugEPxRoSJUuMYuRTjQCfOSRbMZ8SYCqKEeR61SF9uThhEYfswrAOGRibeJD2cJDe7LdA==
X-Received: by 2002:a7b:c3c6:0:b0:40e:67a5:8666 with SMTP id
 t6-20020a7bc3c6000000b0040e67a58666mr4302590wmj.49.1705505638146; 
 Wed, 17 Jan 2024 07:33:58 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4f07000000b00337876596d1sm1897499wru.111.2024.01.17.07.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:33:57 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/4] doc: man-page for smbios command
Date: Wed, 17 Jan 2024 16:33:46 +0100
Message-ID: <20240117153347.85074-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
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

Provide a man-page for the smbios command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v2:
	no change
---
 doc/usage/cmd/smbios.rst | 93 ++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst      |  1 +
 2 files changed, 94 insertions(+)
 create mode 100644 doc/usage/cmd/smbios.rst

diff --git a/doc/usage/cmd/smbios.rst b/doc/usage/cmd/smbios.rst
new file mode 100644
index 00000000000..1ffd706d7de
--- /dev/null
+++ b/doc/usage/cmd/smbios.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later:
+
+smbios command
+==============
+
+Synopsis
+--------
+
+::
+
+        smbios
+
+Description
+-----------
+
+The smbios command displays information from the SMBIOS tables.
+
+Examples
+--------
+
+The example below shows an example output of the smbios command.
+
+::
+
+    => smbios
+    SMBIOS 2.8.0 present.
+    8 structures occupying 81 bytes
+    Table at 0x6d35018
+
+    Handle 0x0100, DMI type 1, 27 bytes at 0x6d35018
+    System Information
+        Manufacturer: QEMU
+        Product Name: Standard PC (i440FX + PIIX, 1996)
+        Version: pc-i440fx-2.5
+        Serial Number:
+        UUID 00000000-0000-0000-0000-000000000000
+        Wake Up Type:
+        Serial Number:
+        SKU Number:
+
+    Handle 0x0300, DMI type 3, 22 bytes at 0x6d35069
+    Header and Data:
+        00000000: 03 16 00 03 01 01 02 00 00 03 03 03 02 00 00 00
+        00000010: 00 00 00 00 00 00
+    Strings:
+        String 1: QEMU
+        String 2: pc-i440fx-2.5
+
+    Handle 0x0400, DMI type 4, 42 bytes at 0x6d35093
+    Header and Data:
+        00000000: 04 2a 00 04 01 03 01 02 63 06 00 00 fd ab 81 07
+        00000010: 03 00 00 00 d0 07 d0 07 41 01 ff ff ff ff ff ff
+        00000020: 00 00 00 01 01 01 02 00 01 00
+    Strings:
+        String 1: CPU 0
+        String 2: QEMU
+        String 3: pc-i440fx-2.5
+
+    Handle 0x1000, DMI type 16, 23 bytes at 0x6d350d7
+    Header and Data:
+        00000000: 10 17 00 10 01 03 06 00 00 02 00 fe ff 01 00 00
+        00000010: 00 00 00 00 00 00 00
+
+    Handle 0x1100, DMI type 17, 40 bytes at 0x6d350f0
+    Header and Data:
+        00000000: 11 28 00 11 00 10 fe ff ff ff ff ff 80 00 09 00
+        00000010: 01 00 07 02 00 00 00 02 00 00 00 00 00 00 00 00
+        00000020: 00 00 00 00 00 00 00 00
+    Strings:
+        String 1: DIMM 0
+        String 2: QEMU
+
+    Handle 0x1300, DMI type 19, 31 bytes at 0x6d35125
+    Header and Data:
+        00000000: 13 1f 00 13 00 00 00 00 ff ff 01 00 00 10 01 00
+        00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+
+    Handle 0x2000, DMI type 32, 11 bytes at 0x6d35146
+    Header and Data:
+        00000000: 20 0b 00 20 00 00 00 00 00 00 00
+
+    Handle 0x7f00, DMI type 127, 4 bytes at 0x6d35153
+    End Of Table
+
+Configuration
+-------------
+
+The command is only available if CONFIG_CMD_SMBIOS=y.
+
+Return value
+------------
+
+The return value $? is 0 (true) on success, 1 (false) otherwise.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index c171c029b80..0d174eefaa5 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -103,6 +103,7 @@ Shell commands
    cmd/size
    cmd/sleep
    cmd/sm
+   cmd/smbios
    cmd/sound
    cmd/source
    cmd/temperature
-- 
2.43.0

