Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AC5C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1B7878CB;
	Thu, 25 Jan 2024 16:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fMUE2zi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AED87BAD; Thu, 25 Jan 2024 16:55:03 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D654187B5F
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 293CA40A18
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706198098;
 bh=mqy2vGRTIJMikBsB0z6kifgOtLGqI0Mgx+viCPyZi48=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fMUE2zi+T9SErBNJztsbGASFl07xxIfftH7r95Ie5qz8cyDLNRKmR+BiHdQBPif18
 wLoz3FRBsxusdV/w/4Zx2BAP4HJqIqnmBrG4gNIFAOch2cGlCNVYM05TzN9TYFJ968
 6VbNk94M55EUiM6RBGV9+zny5ti9cfuCXlo35xKSNk0gdKCR84Bxx9oPdT3mut3s3l
 BCwN1lcC9GEUlVXAWUM01RGncY1SppibzG3SSLPfLOpFwvab6ucSv2PL6UH5gOJlCj
 gSnu/VnLgNyNxTHy896cOJj6EIQrkEezXlKvaunfIcTg8DSoeoL2MatKrb8meweRDW
 2yH3IagPzi2oA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3392d419c7dso3050696f8f.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198091; x=1706802891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqy2vGRTIJMikBsB0z6kifgOtLGqI0Mgx+viCPyZi48=;
 b=xMz1dYaVRQzIqXnOoaxwg81xPaB8o1+l4S3QrMNa7OaXbkBZCffOOIZVdqFhzut8tv
 GvHit5NIXzE7RvYcTypYdu10Od/0Fs0qxvLUY1vWfI55eWSeAVBjBK+I/8bD3A80Gr3V
 vit6XiorgY65v0/curQfaePzC4xALl0JyEi26GLxfRb3z+N1VbWj0mWcWmT3Es6w7Ahp
 M+Q59WSsaMugboxIZQkcIRQuqvcsCC5gykEiKLvTcqZ6O85qzGDQ+Fu0on+vWcLFmXac
 f2Mtddxn3J6RrolbschRes7tonjGQF9t+c6F0MyddWRgsYfEgk6vFOMDo+8s2PXavgrb
 EHqg==
X-Gm-Message-State: AOJu0YzU0WfNJ59jFtME5qLqqWC0flf6Bp9Qqxb5FBFwQHaIHb8vy5X/
 rY/yMKswZZWV7Fl83Rz/x6Mb1G9o1ROqnVS/z4Z0FP5CO3uBHxptXy0dcXv74giM6f9JRvSg4T3
 Kb5HSVwOsz+FbYY/JlDy+89u6vQlmAwjw+6doYLx4+AvcAtbHZEe7wiNM/VE2woEVvTk=
X-Received: by 2002:a5d:518b:0:b0:337:c435:8d4c with SMTP id
 k11-20020a5d518b000000b00337c4358d4cmr725029wrv.7.1706198091321; 
 Thu, 25 Jan 2024 07:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk8PHTDpyJcjY6M+/AentFXIAwhzl3gDB5xNQFkcpiS/EV5KcLfjzATZAR10ib+eu7TOEqvQ==
X-Received: by 2002:a5d:518b:0:b0:337:c435:8d4c with SMTP id
 k11-20020a5d518b000000b00337c4358d4cmr725022wrv.7.1706198091063; 
 Thu, 25 Jan 2024 07:54:51 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b003393592ef8dsm10557471wru.54.2024.01.25.07.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 07:54:50 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/6] doc: man-page for smbios command
Date: Thu, 25 Jan 2024 16:54:35 +0100
Message-ID: <20240125155438.47617-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
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
v3:
	no change
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

