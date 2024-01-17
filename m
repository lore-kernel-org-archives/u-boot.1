Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089E8C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7108487B85;
	Wed, 17 Jan 2024 16:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aMKHFiHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C4587835; Wed, 17 Jan 2024 16:34:04 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B5B9876D3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 792983F274
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705505640;
 bh=pmLeMLBlTG0PM+Vb6ZEU4cVKAzJJSCtIBQuOmDTn9KQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=aMKHFiHGmkvU5CepLojmKEJcg9hR1HD6HW+vH/TxdPf6pm+edAnVxZy4aGu09OP/1
 YUgrfwVr1zWTY5m3ARkqx60BEtMGiKIulSVaPDwiq40y7WHvLidhTUKcMSl3LqOfgo
 MoeXph1bVrD8B+ZlcA00sABLZoqYFJUe/K+coIDXZzmcE4vtILEKTIOlOFlgGl+YHC
 mTbsyaHoXsh01ZBJurRMOjvnMMlOSfmlAgPzIK/sIFD7sCTV2wo7MdquIqdSFexrId
 TdMeJl4ssGaJBeGVubfIl8XEZW226iDHLQZ0EuOMN6W98kYyXPYSdRrMfIR6L4WSV1
 yqO1f97lu2whQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-337c6559cc2so160491f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 07:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705505639; x=1706110439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmLeMLBlTG0PM+Vb6ZEU4cVKAzJJSCtIBQuOmDTn9KQ=;
 b=WLfBZjHsh6tmBJWc4j7OqG0i1xO5czP5U25WTo4vYlZSUe6FxOEp1cH5hGy7z5n9Dz
 grswMsKNpDntMbjy434uIyeFABdPfAaRd4yuycplDAlYKGPtwqgt7deK9LM2IuOwT+EK
 hvo/iG/eUi3TX8dcraLYAt7srnghrCim1dwN3r6j30nWfXCJZdbEjydmD/4YvOOH9YZ0
 SXZQvPClAJoOPtFSMiJLDY67ctoUQMwbdibT6HdlGzl+bx659H4HMO/MVkjSVH4J/6PU
 wVI0W1X8PKbfx+Zl9bDFFIyzPHtLe6ywBOGojMp5PUpIscGg0DhbzffUvT9+llwl9TVt
 ft+Q==
X-Gm-Message-State: AOJu0YyA7pfZjdy4WzzfV3cN07J7TpdyI8UHV7WYwAK/LSs/0yDfKdHe
 tw+0N4qmsGZZT2/IYcjrHnBRcciNgX/d1QLldXya3dQy3aub18t1yrV1XRB9BXE3YW1/OQVyLrY
 uMOz4rr7j6y0AjXAanGyFOD5AVBhOJoI8oPN6Eg==
X-Received: by 2002:a5d:5982:0:b0:337:aa5e:2def with SMTP id
 n2-20020a5d5982000000b00337aa5e2defmr3711754wri.81.1705505639083; 
 Wed, 17 Jan 2024 07:33:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG75Sr9KdRxDDAleUYNn2+YDzYf6EHW1WEQz+06KZzQv2L7dKLN6ytTY6mO7KZWWFGA10fldA==
X-Received: by 2002:a5d:5982:0:b0:337:aa5e:2def with SMTP id
 n2-20020a5d5982000000b00337aa5e2defmr3711745wri.81.1705505638866; 
 Wed, 17 Jan 2024 07:33:58 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4f07000000b00337876596d1sm1897499wru.111.2024.01.17.07.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:33:58 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] test: unit test for smbios command
Date: Wed, 17 Jan 2024 16:33:47 +0100
Message-ID: <20240117153347.85074-4-heinrich.schuchardt@canonical.com>
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

Provide a unit test for the smbios command.

Provide different test functions for QEMU, sandbox, and other systems.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	for generic boards we only can assume that a type 127 table exists
	email address updated
---
 test/py/tests/test_smbios.py | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 test/py/tests/test_smbios.py

diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
new file mode 100644
index 00000000000..82b0b689830
--- /dev/null
+++ b/test/py/tests/test_smbios.py
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""Test smbios command"""
+
+import pytest
+
+@pytest.mark.buildconfigspec('cmd_smbios')
+@pytest.mark.notbuildconfigspec('qfw_smbios')
+@pytest.mark.notbuildconfigspec('sandbox')
+def test_cmd_smbios(u_boot_console):
+    """Run the smbios command"""
+    output = u_boot_console.run_command('smbios')
+    assert 'DMI type 127,' in output
+
+@pytest.mark.buildconfigspec('cmd_smbios')
+@pytest.mark.buildconfigspec('qfw_smbios')
+@pytest.mark.notbuildconfigspec('sandbox')
+# TODO:
+# QEMU v8.2.0 lacks SMBIOS support for RISC-V
+# Once support is available in our Docker image we can remove the constraint.
+@pytest.mark.notbuildconfigspec('riscv')
+def test_cmd_smbios_qemu(u_boot_console):
+    """Run the smbios command on QEMU"""
+    output = u_boot_console.run_command('smbios')
+    assert 'DMI type 1,' in output
+    assert 'Manufacturer: QEMU' in output
+    assert 'DMI type 127,' in output
+
+@pytest.mark.buildconfigspec('cmd_smbios')
+@pytest.mark.buildconfigspec('sandbox')
+def test_cmd_smbios_sandbox(u_boot_console):
+    """Run the smbios command on the sandbox"""
+    output = u_boot_console.run_command('smbios')
+    assert 'DMI type 0,' in output
+    assert 'String 1: U-Boot' in output
+    assert 'DMI type 1,' in output
+    assert 'Manufacturer: sandbox' in output
+    assert 'DMI type 2,' in output
+    assert 'DMI type 3,' in output
+    assert 'DMI type 4,' in output
+    assert 'DMI type 127,' in output
-- 
2.43.0

