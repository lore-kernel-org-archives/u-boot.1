Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FEAC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73AF387B8A;
	Thu, 25 Jan 2024 16:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="M54Vi4fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A525E87B6C; Thu, 25 Jan 2024 16:54:57 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 965B5878CB
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 41B8040588
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706198094;
 bh=9t6Y4fssieyLhdAICmgDBbYCvyS7fRRMzlIFUVbeXWc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=M54Vi4fzlM1y20IxOAIOD4y35TuNKqoqGTnGfY1Ba9KJ2BBU62klcHeNypMx7ucpM
 6aDkrTTjFqh1l4XZ660WIirrvNcWvjNq7FP+fJDMzvZhel098Q9G6b7ACmp9dbwgW3
 OWmfFIhop++03hxu2Mmbkz8/5biOrHSBwfO2PLje1h3lbCp0itoScVezYGeXuZC9PU
 wKthBQPYRg4nCseTEA8+Tn0LwC4irva7QmV/UEVLC9t5iupPRBVxIuUUQKdm9kynPO
 nbtHDpxqB6YiAv2fBT/CZbbE1iO5ynyTUwjrKXNloVzVtXgzbYkBJQikOBncrUh0Vs
 ZeC8xlIQ/W7Kg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-337bf78ef28so2768213f8f.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198092; x=1706802892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9t6Y4fssieyLhdAICmgDBbYCvyS7fRRMzlIFUVbeXWc=;
 b=d3P+7rsep6g8aPnQjqmaolD1V3HANPUiBFpmc5v4FVuFe5+bPjDTXE0Jj/S3jgYCG3
 QCNmhDjtIDyYxLEvwMASCxx1pRZuAcwK5eYcu69SIx5tB4OOR/IjoOU+bdimSU35FCpr
 SmVpa3rRTGmDSNo6DxGaUodurvxZTHBjo2rO0WgLp2VVRD/hxhKCUbmw1UfFwzbSOoey
 tlp0zLWI3UgbHe+Cyj6WG9HuGHLaYZ4ELJRPF0qwv5nnl5e8rABCQoUMUiD1MIpZRdJM
 ba1OnDcICfvMjgR7SpafJ/ZkVWPXP4qBEfGN7JELrx8bNW8EZmS2Iv4X6wzfBT+MPf2D
 wM/w==
X-Gm-Message-State: AOJu0Yxr3oMGm+bODw7rQkbXlYqH5zEZAYltE9KSczWKxAO4zdxR/Y+U
 MkfXKCddxjKSkYWufZZG77c23MhxN5C/tLCDTU0B18rNEOJXn+qmjEmXsZkqv1Qlb8AfK7Dj41b
 YAxoOBQfT9ASDPDCxezYyq1aEe6g4WSLZEYs5PUQpr9LsqJwkuy1qtntCfImNLy56XRs=
X-Received: by 2002:adf:ce88:0:b0:337:c267:7642 with SMTP id
 r8-20020adfce88000000b00337c2677642mr587474wrn.140.1706198092416; 
 Thu, 25 Jan 2024 07:54:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGrpuzw0lkVNkMWMk1HsmXsIKoY/Jju6jJkuSfTpUGUnnteOuYiDu52CQoLeJFpyspe+UBag==
X-Received: by 2002:adf:ce88:0:b0:337:c267:7642 with SMTP id
 r8-20020adfce88000000b00337c2677642mr587469wrn.140.1706198091928; 
 Thu, 25 Jan 2024 07:54:51 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b003393592ef8dsm10557471wru.54.2024.01.25.07.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 07:54:51 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/6] test: unit test for smbios command
Date: Thu, 25 Jan 2024 16:54:36 +0100
Message-ID: <20240125155438.47617-5-heinrich.schuchardt@canonical.com>
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

Provide a unit test for the smbios command.

Provide different test functions for QEMU, sandbox, and other systems.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	no change
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

