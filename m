Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4FED69119
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2671289891;
	Thu, 28 Nov 2024 16:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="R2+4KXF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D1B89369; Thu, 28 Nov 2024 16:12:40 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA8388DFE
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alicja.michalska@9elements.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-382433611d0so841498f8f.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1732806757; x=1733411557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ny8oI1di6epMiDHVngTxm7VNAuhdNWptxaA2xlvVb3I=;
 b=R2+4KXF8wSp6O04PB2X1o6Pv9tm6P5DcqbkXIzraiCg7EgFeRI8jIPMuNQTlVQEzUd
 WX/VMUCkCGh4FSqf5gB8ve/8czvqLUUNm3QyCGb2YlGkMIozUAg4t0ZJz5NouriBA05m
 k1m3wSzlcKNf5/XKvTBapyGlrXcC25Ec7RegqH7NTe4YK/FfS5rxYf6FnFF6Ukv69+Qp
 DRJ0px42A8ilYqwdUazKElQQCrFjyLNXGBh/8lM8JEPiOzJkQb6+98zZwPhJ4KKwn/fq
 OJF65HfzcJY4CJaR5pCjlz5HPmmnpbesaSa6o9sPh7onQyc+vdvMJq3ZQ9FAQ8IS1+B4
 BgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732806757; x=1733411557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ny8oI1di6epMiDHVngTxm7VNAuhdNWptxaA2xlvVb3I=;
 b=dqk9c+LuYfFoKalqP95wpg+7iNegjYz09FTwegXMu4ZOpnsiBQ5wl0CtiSeBRlW1h7
 C6cKYU7dkZtDhGHifl+EBYvLon0zHIWBgMUE4gdCGW1mQ8u2fIg/rzI8YHY6Ku8+GZJr
 etWdgcQaV/0kklRZGkimTqa3SeAokjK1MpAENVTOJdPXKjOqA2M28lpZdcEDXQindLf0
 i3/TZWKmUxdy/Ff6MIRBMxfr6KbuxpoHWfx1WH2vkbG3ohfwJt99vqwi11CkYSo4jbKS
 DI3Xz9t+qs+SzMjfiyDM5vMLa2/e1Gc4wL65EsfF5xBaol40vJqfQ9ntMDXWPwqBTM1A
 fbFw==
X-Gm-Message-State: AOJu0Yy9uRlAwWt+3MNQcq0hXuIEEymQcRITpGPhp8b8FuGX5eugP23B
 g4tz+CfT7lQHCcsTqRoTtnDiq7DYxUHB5/bkT1ZjX/e6TyDTqy/Jh0csOTJVveJ03rWFnvYa6IP
 Uq2VRDK345ME=
X-Gm-Gg: ASbGnctVCeU24OfPwtWmcpaSuBzH8xK1r/5z8g2A0CgmAbCHIsO05nhiyULNrF9qsaR
 gX+hqUz22jzEFnHsRF0iT7wFJ4P6w8Fi20SAjEvyhkbOvu/rG5/fBE30zQ1jR8UmtpAeXtINrkm
 9GtqD9YH8sGL5vZ9QGmxCyqFSQ+n6tcCepfVHQ0KfrvfnndHJuwHIAZiSnehNsXRp+1JI5U3q1s
 wI1fMEavDqIWMC4slpA8ZfMvEnK0qCH47B5W8Y1gDOEOpW1r9Z2H9Arz5nfq3blmrMCrOqPUbhX
 dm3fe8836+h/wjoqe5rZY0T446lC33SCNqQac1wod0ey
X-Google-Smtp-Source: AGHT+IFRIQMpyJ1zhR8ofeE/J3GhxdlsUkfXHSdZBqKoSvMyFpMoV68JyWDHbcMqpnb9FrPgieY0ag==
X-Received: by 2002:a05:6000:2a5:b0:385:bc53:b2af with SMTP id
 ffacd0b85a97d-385c6ed9381mr6350970f8f.42.1732806757316; 
 Thu, 28 Nov 2024 07:12:37 -0800 (PST)
Received: from tora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-385ccd3a71bsm1849936f8f.55.2024.11.28.07.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:12:36 -0800 (PST)
From: Alicja Michalska <alicja.michalska@9elements.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, sjg@chromium.org,
 Alicja Michalska <alicja.michalska@9elements.com>
Subject: [PATCH] Environment: Change reporting "nowhere" as "magic hat" to user
Date: Thu, 28 Nov 2024 16:12:33 +0100
Message-ID: <20241128151233.1962926-1-alicja.michalska@9elements.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Nov 2024 16:46:26 +0100
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

Make string more user-friendly

Signed-off-by: Alicja Michalska <alicja.michalska@9elements.com>
---
 doc/arch/sandbox/sandbox.rst       | 2 +-
 doc/board/emulation/qemu-x86.rst   | 2 +-
 doc/board/sophgo/milkv_duo.rst     | 2 +-
 doc/board/starfive/visionfive2.rst | 2 +-
 doc/develop/uefi/u-boot_on_efi.rst | 2 +-
 env/nowhere.c                      | 2 +-
 test/py/tests/test_env.py          | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index a8b0d7f039..d88f05285e 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -469,7 +469,7 @@ Here is an example trace::
    Address in environment is	02:00:11:22:33:44
    Core:  103 devices, 51 uclasses, devicetree: board
    MMC:
-   Loading Environment from nowhere... OK
+   Loading Environment from a magic hat... OK
    In:    serial,cros-ec-keyb,usbkbd
    Out:   serial,vidconsole
    Err:   serial,vidconsole
diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
index c604e42990..06e9dcd999 100644
--- a/doc/board/emulation/qemu-x86.rst
+++ b/doc/board/emulation/qemu-x86.rst
@@ -142,7 +142,7 @@ The output will be something like this::
    CPU:   QEMU Virtual CPU version 2.5+
    DRAM:  8 GiB
    Core:  20 devices, 13 uclasses, devicetree: separate
-   Loading Environment from nowhere... OK
+   Loading Environment from a magic hat... OK
    Model: QEMU x86 (I440FX)
    Net:   e1000: 52:54:00:12:34:56
           eth0: e1000#0
diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
index cb2ed1ad98..243468bf10 100644
--- a/doc/board/sophgo/milkv_duo.rst
+++ b/doc/board/sophgo/milkv_duo.rst
@@ -53,7 +53,7 @@ Sample boot log from Milk-V Duo board
 
    DRAM:  63.3 MiB
    Core:  10 devices, 8 uclasses, devicetree: separate
-   Loading Environment from nowhere... OK
+   Loading Environment from a magic hat... OK
    In:    serial@4140000
    Out:   serial@4140000
    Err:   serial@4140000
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 2c68df3ce4..7a926dc021 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -209,7 +209,7 @@ Sample boot log from StarFive VisionFive2 board
 	DRAM:  8 GiB
 	Core:  107 devices, 18 uclasses, devicetree: separate
 	MMC:   mmc@16010000: 0, mmc@16020000: 1
-	Loading Environment from nowhere... OK
+	Loading Environment from a magic hat... OK
 	In:    serial@10000000
 	Out:   serial@10000000
 	Err:   serial@10000000
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 245b4af1fa..dbc2b74c6e 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -230,7 +230,7 @@ This shows running with serial enabled (see `include/configs/efi-x86_app.h`)::
    DRAM:  32 MiB
     0: efi_media_0  PciRoot(0x0)/Pci(0x3,0x0)/Sata(0x0,0xFFFF,0x0)
     1: <partition>  PciRoot(0x0)/Pci(0x3,0x0)/Sata(0x0,0xFFFF,0x0)/HD(1,GPT,0FFD5E61-3B0C-4326-8049-BDCDC910AF72,0x800,0xB000)
-   Loading Environment from nowhere... OK
+   Loading Environment from a magic hat... OK
    Model: EFI x86 Application
    Hit any key to stop autoboot:  0
 
diff --git a/env/nowhere.c b/env/nowhere.c
index 6b9b6e2fe0..63fc4647f6 100644
--- a/env/nowhere.c
+++ b/env/nowhere.c
@@ -45,5 +45,5 @@ U_BOOT_ENV_LOCATION(nowhere) = {
 	.location	= ENVL_NOWHERE,
 	.init		= env_nowhere_init,
 	.load		= env_nowhere_load,
-	ENV_NAME("nowhere")
+	ENV_NAME("a magic hat")
 };
diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index 4471db7d9c..3cd06c5c90 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -527,10 +527,10 @@ def test_env_ext4(state_test_env):
 
         # restore env location: NOWHERE (prio 0 in sandbox)
         response = c.run_command('env select nowhere')
-        assert 'Select Environment on nowhere: OK' in response
+        assert 'Select Environment from a magic hat: OK' in response
 
         response = c.run_command('env load')
-        assert 'Loading Environment from nowhere... OK' in response
+        assert 'Loading Environment from a magic hat... OK' in response
 
         response = c.run_command('env info')
         assert 'env_valid = invalid' in response
-- 
2.47.0

