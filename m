Return-Path: <u-boot-bounces@lists.denx.de>
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2DFC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FE580C96;
	Sun,  9 Feb 2025 17:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eYNjWtNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC1B80A2A; Sun,  9 Feb 2025 17:07:42 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 829E880821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-84cdacbc3dbso290058439f.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739117259; x=1739722059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRCbodiEbmYXR7cXs4EQsrv1JDZjnDJkzmjoW/v1EZg=;
 b=eYNjWtNu1vhgfrIQ8071lug/FwpkFm/txnz7FGm9788++MywnzwdMTBpd2pU3IpKtf
 g4+ZOs1oFV4rvpmmJuHQylOSfUH+/2xxpYr17TGv1mdkxWSg7kfYdIx26O2PHWo5TFzr
 DgOogTN7gaUnqZsEhTrlAQP4VzGY77vgLzCBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739117259; x=1739722059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRCbodiEbmYXR7cXs4EQsrv1JDZjnDJkzmjoW/v1EZg=;
 b=oiumsmAY5H34MA1x8da//dbFjoWiqh7hQVOMAdYle+TtzYLRi7bDiXDhovJYluEZpb
 xoA2yUcwOxU8tOJMLGdLTYsZ2MVgCJ82riR1wCffNci+/C55kVgYYFWmlmjw2dZRZjXH
 LpDz/MYDSTJZkLQ73EagXuWK/+vS+wohs34Vkc/36JSR1blWaW5F7agOH5xTsk46WALz
 qGQonGe5mh4317RVK7ILbLEAzTRHtQhePKLO8FoKMilOlP0j9BaTCnyiuvXrKuLR0DWI
 aV/VUR2d+cCIoO7aoW2OrnewdqoXLWLpk71Vp1vsuDb60xORE1OYug77AQG6lsMBBMoG
 gaFQ==
X-Gm-Message-State: AOJu0Yxex/LnxMJQgBFH+nsVb5SH4peYv2n0uSv/1hELRWnjUIRnnX2p
 64mApNt/qONz7H7vuy5+NPBRx/VsnsGWDudY5KYZJYQ3166aC/mCvOgpJ7VSfTkkgi0clSzmy9s
 =
X-Gm-Gg: ASbGncsfm//sJPFYrvXw5VWV/XUIyJIHibz/2DCFmUDtodSoCpxzxh4llpc+88Brh61
 x2jSeu2QY1RBsHuXcooJsaL9gZOrAf5MldttyC8nyc8tdPoo4C/xxpyV31LMd17eAvXF1cVAW5z
 nVe+bfJVfnqDb7SkcRH01SplTiaC4eeytOO9nVLxsID+rMQmWEbWKl5ObK5XbkNoDqWNTAGW9tg
 agG6hRJFzQVDdFcuiCcJkWK32dgioY+Av1k31J99GWtIJYIFU5grSUgb+CRiWUM+KR1FKPKODoO
 G82zSfTZb4P4GHidBEAaANMGtcdCb5OLvFGWzR5uDCncoiVuFN+2
X-Google-Smtp-Source: AGHT+IH6eDEUVS7/mQS1BBi5Z5Xn3HFH9iA51pLNymJXljJe0XjnFn2ZF10ZruNDt9ZQNqTlM03FqA==
X-Received: by 2002:a05:6602:6081:b0:855:1c54:d0e1 with SMTP id
 ca18e2360f4ac-8551c54d245mr258355639f.6.1739117258412; 
 Sun, 09 Feb 2025 08:07:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ecf2d08b0dsm354812173.59.2025.02.09.08.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:07:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huang Jianan <jnhuang95@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Richard Weinberger <richard@nod.at>,
 Roger Knecht <rknecht@pm.me>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Weizhao Ouyang <o451686892@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/6] test/py: Shorten u_boot_console
Date: Sun,  9 Feb 2025 09:07:14 -0700
Message-ID: <20250209160725.1054845-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209160725.1054845-1-sjg@chromium.org>
References: <20250209160725.1054845-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Feb 2025 17:33:22 +0100
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

This fixture name is quite long and results in lots of verbose code.
We know this is U-Boot so the 'u_boot_' part is not necessary.

But it is also a bit of a misnomer, since it provides access to all the
information available to tests. It is not just the console.

It would be too confusing to use con as it would be confused with
config and it is probably too short.

So shorten it to 'ubman'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Link: https://lore.kernel.org/u-boot/CAFLszTgPa4aT_J9h9pqeTtLCVn4x2JvLWRcWRD8NaN3uoSAtyA@mail.gmail.com/
---

Changes in v2:
- Use 'ubman' instead

 doc/develop/py_testing.rst                    |  12 +-
 doc/develop/tests_writing.rst                 |  12 +-
 test/py/conftest.py                           |   4 +-
 test/py/tests/fit_util.py                     |  42 +--
 test/py/tests/test_000_version.py             |   8 +-
 test/py/tests/test_android/test_ab.py         |  46 +--
 test/py/tests/test_android/test_abootimg.py   |  90 +++---
 test/py/tests/test_android/test_avb.py        |  48 +--
 test/py/tests/test_bind.py                    |  72 ++---
 test/py/tests/test_bootmenu.py                |  46 +--
 test/py/tests/test_bootstage.py               |  18 +-
 test/py/tests/test_button.py                  |  16 +-
 test/py/tests/test_cat/test_cat.py            |   6 +-
 test/py/tests/test_dfu.py                     |  42 +--
 test/py/tests/test_dm.py                      |  28 +-
 .../test_efi_bootmgr/test_efi_bootmgr.py      |  34 +--
 .../tests/test_efi_capsule/capsule_common.py  |  60 ++--
 .../test_capsule_firmware_fit.py              | 100 +++----
 .../test_capsule_firmware_raw.py              | 126 ++++----
 .../test_capsule_firmware_signed_fit.py       | 104 +++----
 .../test_capsule_firmware_signed_raw.py       | 104 +++----
 test/py/tests/test_efi_fit.py                 |   4 +-
 test/py/tests/test_efi_loader.py              |  82 +++---
 .../py/tests/test_efi_secboot/test_authvar.py | 120 ++++----
 test/py/tests/test_efi_secboot/test_signed.py | 148 +++++-----
 .../test_efi_secboot/test_signed_intca.py     |  46 +--
 .../tests/test_efi_secboot/test_unsigned.py   |  42 +--
 test/py/tests/test_efi_selftest.py            | 180 ++++++------
 .../py/tests/test_eficonfig/test_eficonfig.py | 106 +++----
 test/py/tests/test_env.py                     |  62 ++--
 test/py/tests/test_event_dump.py              |   4 +-
 test/py/tests/test_extension.py               |  30 +-
 test/py/tests/test_fit.py                     |   4 +-
 test/py/tests/test_fit_auto_signed.py         |   4 +-
 test/py/tests/test_fit_ecdsa.py               |   4 +-
 test/py/tests/test_fit_hashes.py              |   4 +-
 test/py/tests/test_fpga.py                    | 278 +++++++++---------
 test/py/tests/test_fs/test_basic.py           | 104 +++----
 test/py/tests/test_fs/test_erofs.py           |  76 ++---
 test/py/tests/test_fs/test_ext.py             | 124 ++++----
 test/py/tests/test_fs/test_fs_cmd.py          |   4 +-
 test/py/tests/test_fs/test_fs_fat.py          |   6 +-
 test/py/tests/test_fs/test_mkdir.py           |  48 +--
 .../test_fs/test_squashfs/test_sqfs_load.py   |  54 ++--
 .../test_fs/test_squashfs/test_sqfs_ls.py     |  64 ++--
 test/py/tests/test_fs/test_symlink.py         |  46 +--
 test/py/tests/test_fs/test_unlink.py          |  50 ++--
 test/py/tests/test_gpio.py                    | 104 +++----
 test/py/tests/test_gpt.py                     | 176 +++++------
 test/py/tests/test_handoff.py                 |   4 +-
 test/py/tests/test_help.py                    |  18 +-
 test/py/tests/test_i2c.py                     |  44 +--
 test/py/tests/test_kconfig.py                 |   8 +-
 test/py/tests/test_log.py                     |  10 +-
 test/py/tests/test_lsblk.py                   |   4 +-
 test/py/tests/test_md.py                      |  20 +-
 test/py/tests/test_mdio.py                    |  32 +-
 test/py/tests/test_memtest.py                 |  26 +-
 test/py/tests/test_mii.py                     |  50 ++--
 test/py/tests/test_mmc.py                     | 146 ++++-----
 test/py/tests/test_mmc_rd.py                  |  52 ++--
 test/py/tests/test_mmc_wr.py                  |  18 +-
 test/py/tests/test_net.py                     | 138 ++++-----
 test/py/tests/test_net_boot.py                | 142 ++++-----
 test/py/tests/test_of_migrate.py              |  12 +-
 test/py/tests/test_ofplatdata.py              |   4 +-
 test/py/tests/test_optee_rpmb.py              |   8 +-
 test/py/tests/test_part.py                    |   4 +-
 test/py/tests/test_pinmux.py                  |  30 +-
 test/py/tests/test_pstore.py                  |  46 +--
 test/py/tests/test_qfw.py                     |   8 +-
 test/py/tests/test_reset.py                   |  24 +-
 test/py/tests/test_sandbox_exit.py            |  28 +-
 test/py/tests/test_sandbox_opts.py            |   8 +-
 test/py/tests/test_saveenv.py                 |  70 ++---
 test/py/tests/test_scp03.py                   |   6 +-
 test/py/tests/test_scsi.py                    |  48 +--
 test/py/tests/test_semihosting/test_hostfs.py |  14 +-
 test/py/tests/test_sf.py                      |  64 ++--
 test/py/tests/test_shell_basics.py            |  30 +-
 test/py/tests/test_sleep.py                   |  26 +-
 test/py/tests/test_smbios.py                  |  12 +-
 test/py/tests/test_source.py                  |   4 +-
 test/py/tests/test_spi.py                     | 240 +++++++--------
 test/py/tests/test_spl.py                     |  12 +-
 test/py/tests/test_stackprotector.py          |   8 +-
 test/py/tests/test_tpm2.py                    | 188 ++++++------
 test/py/tests/test_trace.py                   |   4 +-
 test/py/tests/test_ums.py                     |  40 +--
 test/py/tests/test_unknown_cmd.py             |   6 +-
 test/py/tests/test_upl.py                     |   4 +-
 test/py/tests/test_usb.py                     | 204 ++++++-------
 test/py/tests/test_ut.py                      |  42 +--
 test/py/tests/test_vbe.py                     |   4 +-
 test/py/tests/test_vbe_vpl.py                 |   4 +-
 test/py/tests/test_vboot.py                   |  10 +-
 test/py/tests/test_vpl.py                     |   8 +-
 test/py/tests/test_xxd/test_xxd.py            |   6 +-
 test/py/tests/test_zynq_secure.py             |  94 +++---
 test/py/tests/test_zynqmp_rpu.py              | 106 +++----
 test/py/tests/test_zynqmp_secure.py           |  40 +--
 test/py/u_boot_utils.py                       |  44 +--
 102 files changed, 2607 insertions(+), 2607 deletions(-)

diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index b50473039be..b88d7e3c8d4 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -506,24 +506,24 @@ Writing tests
 Please refer to the pytest documentation for details of writing pytest tests.
 Details specific to the U-Boot test suite are described below.
 
-A test fixture named `u_boot_console` should be used by each test function. This
+A test fixture named `ubman` should be used by each test function. This
 provides the means to interact with the U-Boot console, and retrieve board and
 environment configuration information.
 
-The function `u_boot_console.run_command()` executes a shell command on the
+The function `ubman.run_command()` executes a shell command on the
 U-Boot console, and returns all output from that command. This allows
 validation or interpretation of the command output. This function validates
 that certain strings are not seen on the U-Boot console. These include shell
 error messages and the U-Boot sign-on message (in order to detect unexpected
 board resets). See the source of `u_boot_console_base.py` for a complete list of
 "bad" strings. Some test scenarios are expected to trigger these strings. Use
-`u_boot_console.disable_check()` to temporarily disable checking for specific
+`ubman.disable_check()` to temporarily disable checking for specific
 strings. See `test_unknown_cmd.py` for an example.
 
 Board- and board-environment configuration values may be accessed as sub-fields
-of the `u_boot_console.config` object, for example
-`u_boot_console.config.ram_base`.
+of the `ubman.config` object, for example
+`ubman.config.ram_base`.
 
 Build configuration values (from `.config`) may be accessed via the dictionary
-`u_boot_console.config.buildconfig`, with keys equal to the Kconfig variable
+`ubman.config.buildconfig`, with keys equal to the Kconfig variable
 names.
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 5f3c43d5da2..d5917fe674c 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -116,19 +116,19 @@ below are approximate, as measured on an AMD 2950X system. Here is is the test
 in Python::
 
    @pytest.mark.buildconfigspec('cmd_memory')
-   def test_md(u_boot_console):
+   def test_md(ubman):
        """Test that md reads memory as expected, and that memory can be modified
        using the mw command."""
 
-       ram_base = u_boot_utils.find_ram_base(u_boot_console)
+       ram_base = u_boot_utils.find_ram_base(ubman)
        addr = '%08x' % ram_base
        val = 'a5f09876'
        expected_response = addr + ': ' + val
-       u_boot_console.run_command('mw ' + addr + ' 0 10')
-       response = u_boot_console.run_command('md ' + addr + ' 10')
+       ubman.run_command('mw ' + addr + ' 0 10')
+       response = ubman.run_command('md ' + addr + ' 10')
        assert(not (expected_response in response))
-       u_boot_console.run_command('mw ' + addr + ' ' + val)
-       response = u_boot_console.run_command('md ' + addr + ' 10')
+       ubman.run_command('mw ' + addr + ' ' + val)
+       response = ubman.run_command('md ' + addr + ' 10')
        assert(expected_response in response)
 
 This runs a few commands and checks the output. Note that it runs a command,
diff --git a/test/py/conftest.py b/test/py/conftest.py
index 31043a697e2..863f56c1152 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -486,8 +486,8 @@ def u_boot_config(request):
      return console.config
 
 @pytest.fixture(scope='function')
-def u_boot_console(request):
-    """Generate the value of a test's u_boot_console fixture.
+def ubman(request):
+    """Generate the value of a test's ubman fixture.
 
     Args:
         request: The pytest request.
diff --git a/test/py/tests/fit_util.py b/test/py/tests/fit_util.py
index 79718d431a0..22b971131b8 100644
--- a/test/py/tests/fit_util.py
+++ b/test/py/tests/fit_util.py
@@ -5,25 +5,25 @@
 
 import os
 
-import u_boot_utils as util
+import utils as util
 
-def make_fname(cons, basename):
+def make_fname(ubman, basename):
     """Make a temporary filename
 
     Args:
-        cons (ConsoleBase): u_boot_console to use
+        ubman (ConsoleBase): ubman to use
         basename (str): Base name of file to create (within temporary directory)
     Return:
         Temporary filename
     """
 
-    return os.path.join(cons.config.build_dir, basename)
+    return os.path.join(ubman.config.build_dir, basename)
 
-def make_its(cons, base_its, params, basename='test.its'):
+def make_its(ubman, base_its, params, basename='test.its'):
     """Make a sample .its file with parameters embedded
 
     Args:
-        cons (ConsoleBase): u_boot_console to use
+        ubman (ConsoleBase): ubman to use
         base_its (str): Template text for the .its file, typically containing
             %() references
         params (dict of str): Parameters to embed in the %() strings
@@ -31,19 +31,19 @@ def make_its(cons, base_its, params, basename='test.its'):
     Returns:
         str: Filename of .its file created
     """
-    its = make_fname(cons, basename)
+    its = make_fname(ubman, basename)
     with open(its, 'w', encoding='utf-8') as outf:
         print(base_its % params, file=outf)
     return its
 
-def make_fit(cons, mkimage, base_its, params, basename='test.fit', base_fdt=None):
+def make_fit(ubman, mkimage, base_its, params, basename='test.fit', base_fdt=None):
     """Make a sample .fit file ready for loading
 
     This creates a .its script with the selected parameters and uses mkimage to
     turn this into a .fit image.
 
     Args:
-        cons (ConsoleBase): u_boot_console to use
+        ubman (ConsoleBase): ubman to use
         mkimage (str): Filename of 'mkimage' utility
         base_its (str): Template text for the .its file, typically containing
             %() references
@@ -52,25 +52,25 @@ def make_fit(cons, mkimage, base_its, params, basename='test.fit', base_fdt=None
     Return:
         Filename of .fit file created
     """
-    fit = make_fname(cons, basename)
-    its = make_its(cons, base_its, params)
-    util.run_and_log(cons, [mkimage, '-f', its, fit])
+    fit = make_fname(ubman, basename)
+    its = make_its(ubman, base_its, params)
+    util.run_and_log(ubman, [mkimage, '-f', its, fit])
     if base_fdt:
-        with open(make_fname(cons, 'u-boot.dts'), 'w') as fd:
+        with open(make_fname(ubman, 'u-boot.dts'), 'w') as fd:
             fd.write(base_fdt)
     return fit
 
-def make_kernel(cons, basename, text):
+def make_kernel(ubman, basename, text):
     """Make a sample kernel with test data
 
     Args:
-        cons (ConsoleBase): u_boot_console to use
+        ubman (ConsoleBase): ubman to use
         basename (str): base name to write to (will be placed in the temp dir)
         text (str): Contents of the kernel file (will be repeated 100 times)
     Returns:
         str: Full path and filename of the kernel it created
     """
-    fname = make_fname(cons, basename)
+    fname = make_fname(ubman, basename)
     data = ''
     for i in range(100):
         data += f'this {text} {i} is unlikely to boot\n'
@@ -78,16 +78,16 @@ def make_kernel(cons, basename, text):
         print(data, file=outf)
     return fname
 
-def make_dtb(cons, base_fdt, basename):
+def make_dtb(ubman, base_fdt, basename):
     """Make a sample .dts file and compile it to a .dtb
 
     Returns:
-        cons (ConsoleBase): u_boot_console to use
+        ubman (ConsoleBase): ubman to use
         Filename of .dtb file created
     """
-    src = make_fname(cons, f'{basename}.dts')
-    dtb = make_fname(cons, f'{basename}.dtb')
+    src = make_fname(ubman, f'{basename}.dts')
+    dtb = make_fname(ubman, f'{basename}.dtb')
     with open(src, 'w', encoding='utf-8') as outf:
         outf.write(base_fdt)
-    util.run_and_log(cons, ['dtc', src, '-O', 'dtb', '-o', dtb])
+    util.run_and_log(ubman, ['dtc', src, '-O', 'dtb', '-o', dtb])
     return dtb
diff --git a/test/py/tests/test_000_version.py b/test/py/tests/test_000_version.py
index bd089ab5439..b95ceae2346 100644
--- a/test/py/tests/test_000_version.py
+++ b/test/py/tests/test_000_version.py
@@ -7,13 +7,13 @@
 # first, simply as a very basic sanity check of the functionality of the U-Boot
 # command prompt.
 
-def test_version(u_boot_console):
+def test_version(ubman):
     """Test that the "version" command prints the U-Boot version."""
 
     # "version" prints the U-Boot sign-on message. This is usually considered
     # an error, so that any unexpected reboot causes an error. Here, this
     # error detection is disabled since the sign-on message is expected.
-    with u_boot_console.disable_check('main_signon'):
-        response = u_boot_console.run_command('version')
+    with ubman.disable_check('main_signon'):
+        response = ubman.run_command('version')
     # Ensure "version" printed what we expected.
-    u_boot_console.validate_version_string_in_text(response)
+    ubman.validate_version_string_in_text(response)
diff --git a/test/py/tests/test_android/test_ab.py b/test/py/tests/test_android/test_ab.py
index 9bf1a0eb00a..739b7ce695d 100644
--- a/test/py/tests/test_android/test_ab.py
+++ b/test/py/tests/test_android/test_ab.py
@@ -10,11 +10,11 @@ import u_boot_utils
 class ABTestDiskImage(object):
     """Disk Image used by the A/B tests."""
 
-    def __init__(self, u_boot_console):
+    def __init__(self, ubman):
         """Initialize a new ABTestDiskImage object.
 
         Args:
-            u_boot_console: A U-Boot console.
+            ubman: A U-Boot console.
 
         Returns:
             Nothing.
@@ -22,40 +22,40 @@ class ABTestDiskImage(object):
 
         filename = 'test_ab_disk_image.bin'
 
-        persistent = u_boot_console.config.persistent_data_dir + '/' + filename
-        self.path = u_boot_console.config.result_dir  + '/' + filename
+        persistent = ubman.config.persistent_data_dir + '/' + filename
+        self.path = ubman.config.result_dir  + '/' + filename
 
-        with u_boot_utils.persistent_file_helper(u_boot_console.log, persistent):
+        with u_boot_utils.persistent_file_helper(ubman.log, persistent):
             if os.path.exists(persistent):
-                u_boot_console.log.action('Disk image file ' + persistent +
+                ubman.log.action('Disk image file ' + persistent +
                     ' already exists')
             else:
-                u_boot_console.log.action('Generating ' + persistent)
+                ubman.log.action('Generating ' + persistent)
                 fd = os.open(persistent, os.O_RDWR | os.O_CREAT)
                 os.ftruncate(fd, 524288)
                 os.close(fd)
                 cmd = ('sgdisk', persistent)
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
 
                 cmd = ('sgdisk', '--new=1:64:512', '--change-name=1:misc',
                     persistent)
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
                 cmd = ('sgdisk', '--load-backup=' + persistent)
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
 
         cmd = ('cp', persistent, self.path)
-        u_boot_utils.run_and_log(u_boot_console, cmd)
+        u_boot_utils.run_and_log(ubman, cmd)
 
 di = None
 @pytest.fixture(scope='function')
-def ab_disk_image(u_boot_console):
+def ab_disk_image(ubman):
     global di
     if not di:
-        di = ABTestDiskImage(u_boot_console)
+        di = ABTestDiskImage(ubman)
     return di
 
-def ab_dump(u_boot_console, slot_num, crc):
-    output = u_boot_console.run_command('bcb ab_dump host 0#misc')
+def ab_dump(ubman, slot_num, crc):
+    output = ubman.run_command('bcb ab_dump host 0#misc')
     header, slot0, slot1 = output.split('\r\r\n\r\r\n')
     slots = [slot0, slot1]
     slot_suffixes = ['_a', '_b']
@@ -79,20 +79,20 @@ def ab_dump(u_boot_console, slot_num, crc):
 @pytest.mark.buildconfigspec('android_ab')
 @pytest.mark.buildconfigspec('cmd_bcb')
 @pytest.mark.requiredtool('sgdisk')
-def test_ab(ab_disk_image, u_boot_console):
+def test_ab(ab_disk_image, ubman):
     """Test the 'bcb ab_select' command."""
 
-    u_boot_console.run_command('host bind 0 ' + ab_disk_image.path)
+    ubman.run_command('host bind 0 ' + ab_disk_image.path)
 
-    output = u_boot_console.run_command('bcb ab_select slot_name host 0#misc')
+    output = ubman.run_command('bcb ab_select slot_name host 0#misc')
     assert 're-initializing A/B metadata' in output
     assert 'Attempting slot a, tries remaining 7' in output
-    output = u_boot_console.run_command('printenv slot_name')
+    output = ubman.run_command('printenv slot_name')
     assert 'slot_name=a' in output
-    ab_dump(u_boot_console, 0, '0xd438d1b9')
+    ab_dump(ubman, 0, '0xd438d1b9')
 
-    output = u_boot_console.run_command('bcb ab_select slot_name host 0:1')
+    output = ubman.run_command('bcb ab_select slot_name host 0:1')
     assert 'Attempting slot b, tries remaining 7' in output
-    output = u_boot_console.run_command('printenv slot_name')
+    output = ubman.run_command('printenv slot_name')
     assert 'slot_name=b' in output
-    ab_dump(u_boot_console, 1, '0x011ec016')
+    ab_dump(ubman, 1, '0x011ec016')
diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
index 6a8ff34538b..fd3e08fa899 100644
--- a/test/py/tests/test_android/test_abootimg.py
+++ b/test/py/tests/test_android/test_abootimg.py
@@ -105,78 +105,78 @@ dtb2_addr = vloadaddr + dtb2_offset
 class AbootimgTestDiskImage(object):
     """Disk image used by abootimg tests."""
 
-    def __init__(self, u_boot_console, image_name, hex_img):
+    def __init__(self, ubman, image_name, hex_img):
         """Initialize a new AbootimgDiskImage object.
 
         Args:
-            u_boot_console: A U-Boot console.
+            ubman: A U-Boot console.
 
         Returns:
             Nothing.
         """
 
-        gz_hex = u_boot_console.config.persistent_data_dir + '/' + image_name  + '.gz.hex'
-        gz = u_boot_console.config.persistent_data_dir + '/' + image_name + '.gz'
+        gz_hex = ubman.config.persistent_data_dir + '/' + image_name  + '.gz.hex'
+        gz = ubman.config.persistent_data_dir + '/' + image_name + '.gz'
 
         filename = image_name
-        persistent = u_boot_console.config.persistent_data_dir + '/' + filename
-        self.path = u_boot_console.config.result_dir  + '/' + filename
-        u_boot_console.log.action('persistent is ' + persistent)
-        with u_boot_utils.persistent_file_helper(u_boot_console.log, persistent):
+        persistent = ubman.config.persistent_data_dir + '/' + filename
+        self.path = ubman.config.result_dir  + '/' + filename
+        ubman.log.action('persistent is ' + persistent)
+        with u_boot_utils.persistent_file_helper(ubman.log, persistent):
             if os.path.exists(persistent):
-                u_boot_console.log.action('Disk image file ' + persistent +
+                ubman.log.action('Disk image file ' + persistent +
                     ' already exists')
             else:
-                u_boot_console.log.action('Generating ' + persistent)
+                ubman.log.action('Generating ' + persistent)
 
                 f = open(gz_hex, "w")
                 f.write(hex_img)
                 f.close()
                 cmd = ('xxd', '-r', '-p', gz_hex, gz)
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
                 cmd = ('gunzip', '-9', gz)
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
 
         cmd = ('cp', persistent, self.path)
-        u_boot_utils.run_and_log(u_boot_console, cmd)
+        u_boot_utils.run_and_log(ubman, cmd)
 
 gtdi1 = None
 @pytest.fixture(scope='function')
-def abootimg_disk_image(u_boot_console):
+def abootimg_disk_image(ubman):
     """pytest fixture to provide a AbootimgTestDiskImage object to tests.
-    This is function-scoped because it uses u_boot_console, which is also
+    This is function-scoped because it uses ubman, which is also
     function-scoped. However, we don't need to actually do any function-scope
     work, so this simply returns the same object over and over each time."""
 
     global gtdi1
     if not gtdi1:
-        gtdi1 = AbootimgTestDiskImage(u_boot_console, 'boot.img', img_hex)
+        gtdi1 = AbootimgTestDiskImage(ubman, 'boot.img', img_hex)
     return gtdi1
 
 gtdi2 = None
 @pytest.fixture(scope='function')
-def abootimgv4_disk_image_vboot(u_boot_console):
+def abootimgv4_disk_image_vboot(ubman):
     """pytest fixture to provide a AbootimgTestDiskImage object to tests.
-    This is function-scoped because it uses u_boot_console, which is also
+    This is function-scoped because it uses ubman, which is also
     function-scoped. However, we don't need to actually do any function-scope
     work, so this simply returns the same object over and over each time."""
 
     global gtdi2
     if not gtdi2:
-        gtdi2 = AbootimgTestDiskImage(u_boot_console, 'vendor_boot.img', vboot_img_hex)
+        gtdi2 = AbootimgTestDiskImage(ubman, 'vendor_boot.img', vboot_img_hex)
     return gtdi2
 
 gtdi3 = None
 @pytest.fixture(scope='function')
-def abootimgv4_disk_image_boot(u_boot_console):
+def abootimgv4_disk_image_boot(ubman):
     """pytest fixture to provide a AbootimgTestDiskImage object to tests.
-    This is function-scoped because it uses u_boot_console, which is also
+    This is function-scoped because it uses ubman, which is also
     function-scoped. However, we don't need to actually do any function-scope
     work, so this simply returns the same object over and over each time."""
 
     global gtdi3
     if not gtdi3:
-        gtdi3 = AbootimgTestDiskImage(u_boot_console, 'bootv4.img', boot_img_hex)
+        gtdi3 = AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_hex)
     return gtdi3
 
 @pytest.mark.boardspec('sandbox')
@@ -185,42 +185,42 @@ def abootimgv4_disk_image_boot(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fdt')
 @pytest.mark.requiredtool('xxd')
 @pytest.mark.requiredtool('gunzip')
-def test_abootimg(abootimg_disk_image, u_boot_console):
+def test_abootimg(abootimg_disk_image, ubman):
     """Test the 'abootimg' command."""
 
-    u_boot_console.log.action('Loading disk image to RAM...')
-    u_boot_console.run_command('setenv loadaddr 0x%x' % (loadaddr))
-    u_boot_console.run_command('host load hostfs - 0x%x %s' % (loadaddr,
+    ubman.log.action('Loading disk image to RAM...')
+    ubman.run_command('setenv loadaddr 0x%x' % (loadaddr))
+    ubman.run_command('host load hostfs - 0x%x %s' % (loadaddr,
         abootimg_disk_image.path))
 
-    u_boot_console.log.action('Testing \'abootimg get ver\'...')
-    response = u_boot_console.run_command('abootimg get ver')
+    ubman.log.action('Testing \'abootimg get ver\'...')
+    response = ubman.run_command('abootimg get ver')
     assert response == "2"
-    u_boot_console.run_command('abootimg get ver v')
-    response = u_boot_console.run_command('env print v')
+    ubman.run_command('abootimg get ver v')
+    response = ubman.run_command('env print v')
     assert response == 'v=2'
 
-    u_boot_console.log.action('Testing \'abootimg get recovery_dtbo\'...')
-    response = u_boot_console.run_command('abootimg get recovery_dtbo a')
+    ubman.log.action('Testing \'abootimg get recovery_dtbo\'...')
+    response = ubman.run_command('abootimg get recovery_dtbo a')
     assert response == 'Error: recovery_dtbo_size is 0'
 
-    u_boot_console.log.action('Testing \'abootimg dump dtb\'...')
-    response = u_boot_console.run_command('abootimg dump dtb').replace('\r', '')
+    ubman.log.action('Testing \'abootimg dump dtb\'...')
+    response = ubman.run_command('abootimg dump dtb').replace('\r', '')
     assert response == dtb_dump_resp
 
-    u_boot_console.log.action('Testing \'abootimg get dtb_load_addr\'...')
-    u_boot_console.run_command('abootimg get dtb_load_addr a')
-    response = u_boot_console.run_command('env print a')
+    ubman.log.action('Testing \'abootimg get dtb_load_addr\'...')
+    ubman.run_command('abootimg get dtb_load_addr a')
+    response = ubman.run_command('env print a')
     assert response == 'a=11f00000'
 
-    u_boot_console.log.action('Testing \'abootimg get dtb --index\'...')
-    u_boot_console.run_command('abootimg get dtb --index=1 dtb1_start')
-    response = u_boot_console.run_command('env print dtb1_start')
+    ubman.log.action('Testing \'abootimg get dtb --index\'...')
+    ubman.run_command('abootimg get dtb --index=1 dtb1_start')
+    response = ubman.run_command('env print dtb1_start')
     correct_str = "dtb1_start=%x" % (dtb1_addr)
     assert response == correct_str
-    u_boot_console.run_command('fdt addr $dtb1_start')
-    u_boot_console.run_command('fdt get value v / model')
-    response = u_boot_console.run_command('env print v')
+    ubman.run_command('fdt addr $dtb1_start')
+    ubman.run_command('fdt get value v / model')
+    response = ubman.run_command('env print v')
     assert response == 'v=x2'
 
 @pytest.mark.boardspec('sandbox')
@@ -229,10 +229,10 @@ def test_abootimg(abootimg_disk_image, u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fdt')
 @pytest.mark.requiredtool('xxd')
 @pytest.mark.requiredtool('gunzip')
-def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, u_boot_console):
+def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubman):
     """Test the 'abootimg' command with boot image header v4."""
 
-    cons = u_boot_console
+    cons = ubman
     cons.log.action('Loading disk image to RAM...')
     cons.run_command('setenv loadaddr 0x%x' % (loadaddr))
     cons.run_command('setenv vloadaddr 0x%x' % (vloadaddr))
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 865efbca4de..451a476da76 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -24,34 +24,34 @@ temp_addr2 = 0x90002000
 
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_avb_verify(u_boot_console):
+def test_avb_verify(ubman):
     """Run AVB 2.0 boot verification chain with avb subset of commands
     """
 
     success_str = "Verification passed successfully"
 
-    response = u_boot_console.run_command('avb init %s' %str(mmc_dev))
+    response = ubman.run_command('avb init %s' %str(mmc_dev))
     assert response == ''
-    response = u_boot_console.run_command('avb verify')
+    response = ubman.run_command('avb verify')
     assert response.find(success_str)
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.notbuildconfigspec('sandbox')
-def test_avb_mmc_uuid(u_boot_console):
+def test_avb_mmc_uuid(ubman):
     """Check if 'avb get_uuid' works, compare results with
     'part list mmc 1' output
     """
 
-    response = u_boot_console.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %s' % str(mmc_dev))
     assert response == ''
 
-    response = u_boot_console.run_command('mmc rescan; mmc dev %s' %
+    response = ubman.run_command('mmc rescan; mmc dev %s' %
                                           str(mmc_dev))
     assert response.find('is current device')
 
-    part_lines = u_boot_console.run_command('mmc part').splitlines()
+    part_lines = ubman.run_command('mmc part').splitlines()
     part_list = {}
     cur_partname = ''
 
@@ -67,72 +67,72 @@ def test_avb_mmc_uuid(u_boot_console):
 
     # lets check all guids with avb get_guid
     for part, guid in part_list.items():
-        avb_guid_resp = u_boot_console.run_command('avb get_uuid %s' % part)
+        avb_guid_resp = ubman.run_command('avb get_uuid %s' % part)
         assert guid == avb_guid_resp.split('UUID: ')[1]
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
-def test_avb_read_rb(u_boot_console):
+def test_avb_read_rb(ubman):
     """Test reading rollback indexes
     """
 
-    response = u_boot_console.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %s' % str(mmc_dev))
     assert response == ''
 
-    response = u_boot_console.run_command('avb read_rb 1')
+    response = ubman.run_command('avb read_rb 1')
     assert response == 'Rollback index: 0'
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
-def test_avb_is_unlocked(u_boot_console):
+def test_avb_is_unlocked(ubman):
     """Test if device is in the unlocked state
     """
 
-    response = u_boot_console.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %s' % str(mmc_dev))
     assert response == ''
 
-    response = u_boot_console.run_command('avb is_unlocked')
+    response = ubman.run_command('avb is_unlocked')
     assert response == 'Unlocked = 1'
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.notbuildconfigspec('sandbox')
-def test_avb_mmc_read(u_boot_console):
+def test_avb_mmc_read(ubman):
     """Test mmc read operation
     """
 
-    response = u_boot_console.run_command('mmc rescan; mmc dev %s 0' %
+    response = ubman.run_command('mmc rescan; mmc dev %s 0' %
                                           str(mmc_dev))
     assert response.find('is current device')
 
-    response = u_boot_console.run_command('mmc read 0x%x 0x100 0x1' % temp_addr)
+    response = ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr)
     assert response.find('read: OK')
 
-    response = u_boot_console.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %s' % str(mmc_dev))
     assert response == ''
 
-    response = u_boot_console.run_command('avb read_part xloader 0 100 0x%x' %
+    response = ubman.run_command('avb read_part xloader 0 100 0x%x' %
                                            temp_addr2)
     assert response.find('Read 512 bytes')
 
     # Now lets compare two buffers
-    response = u_boot_console.run_command('cmp 0x%x 0x%x 40' %
+    response = ubman.run_command('cmp 0x%x 0x%x 40' %
                                           (temp_addr, temp_addr2))
     assert response.find('64 word')
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('optee_ta_avb')
-def test_avb_persistent_values(u_boot_console):
+def test_avb_persistent_values(ubman):
     """Test reading/writing persistent storage to avb
     """
 
-    response = u_boot_console.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %s' % str(mmc_dev))
     assert response == ''
 
-    response = u_boot_console.run_command('avb write_pvalue test value_value')
+    response = ubman.run_command('avb write_pvalue test value_value')
     assert response == 'Wrote 12 bytes'
 
-    response = u_boot_console.run_command('avb read_pvalue test 12')
+    response = ubman.run_command('avb read_pvalue test 12')
     assert response == 'Read 12 bytes, value = value_value'
diff --git a/test/py/tests/test_bind.py b/test/py/tests/test_bind.py
index 1376ab5ed28..16c63ae9684 100644
--- a/test/py/tests/test_bind.py
+++ b/test/py/tests/test_bind.py
@@ -27,82 +27,82 @@ def in_tree(response, name, uclass, drv, depth, last_child):
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_bind')
-def test_bind_unbind_with_node(u_boot_console):
+def test_bind_unbind_with_node(ubman):
 
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test', 'simple_bus', 'simple_bus', 0, True)
     assert in_tree(tree, 'bind-test-child1', 'phy', 'phy_sandbox', 1, False)
     assert in_tree(tree, 'bind-test-child2', 'simple_bus', 'simple_bus', 1, True)
 
     #bind usb_ether driver (which has no compatible) to usb@1 node.
     ##New entry usb_ether should appear in the dm tree
-    response = u_boot_console.run_command('bind  /usb@1 usb_ether')
+    response = ubman.run_command('bind  /usb@1 usb_ether')
     assert response == ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'usb@1', 'ethernet', 'usb_ether', 1, True)
 
     #Unbind child #1. No error expected and all devices should be there except for bind-test-child1
-    response = u_boot_console.run_command('unbind  /bind-test/bind-test-child1')
+    response = ubman.run_command('unbind  /bind-test/bind-test-child1')
     assert response == ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test', 'simple_bus', 'simple_bus', 0, True)
     assert 'bind-test-child1' not in tree
     assert in_tree(tree, 'bind-test-child2', 'simple_bus', 'simple_bus', 1, True)
 
     #bind child #1. No error expected and all devices should be there
-    response = u_boot_console.run_command('bind  /bind-test/bind-test-child1 phy_sandbox')
+    response = ubman.run_command('bind  /bind-test/bind-test-child1 phy_sandbox')
     assert response == ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test', 'simple_bus', 'simple_bus', 0, True)
     assert in_tree(tree, 'bind-test-child1', 'phy', 'phy_sandbox', 1, True)
     assert in_tree(tree, 'bind-test-child2', 'simple_bus', 'simple_bus', 1, False)
 
     #Unbind child #2. No error expected and all devices should be there except for bind-test-child2
-    response = u_boot_console.run_command('unbind  /bind-test/bind-test-child2')
+    response = ubman.run_command('unbind  /bind-test/bind-test-child2')
     assert response == ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test', 'simple_bus', 'simple_bus', 0, True)
     assert in_tree(tree, 'bind-test-child1', 'phy', 'phy_sandbox', 1, True)
     assert 'bind-test-child2' not in tree
 
 
     #Bind child #2. No error expected and all devices should be there
-    response = u_boot_console.run_command('bind /bind-test/bind-test-child2 simple_bus')
+    response = ubman.run_command('bind /bind-test/bind-test-child2 simple_bus')
     assert response == ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test', 'simple_bus', 'simple_bus', 0, True)
     assert in_tree(tree, 'bind-test-child1', 'phy', 'phy_sandbox', 1, False)
     assert in_tree(tree, 'bind-test-child2', 'simple_bus', 'simple_bus', 1, True)
 
     #Unbind parent. No error expected. All devices should be removed and unbound
-    response = u_boot_console.run_command('unbind  /bind-test')
+    response = ubman.run_command('unbind  /bind-test')
     assert response == ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert 'bind-test' not in tree
     assert 'bind-test-child1' not in tree
     assert 'bind-test-child2' not in tree
 
     #try binding invalid node with valid driver
-    response = u_boot_console.run_command('bind  /not-a-valid-node simple_bus')
+    response = ubman.run_command('bind  /not-a-valid-node simple_bus')
     assert response != ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert 'not-a-valid-node' not in tree
 
     #try binding valid node with invalid driver
-    response = u_boot_console.run_command('bind  /bind-test not_a_driver')
+    response = ubman.run_command('bind  /bind-test not_a_driver')
     assert response != ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert 'bind-test' not in tree
 
     #bind /bind-test. Device should come up as well as its children
-    response = u_boot_console.run_command('bind  /bind-test simple_bus')
+    response = ubman.run_command('bind  /bind-test simple_bus')
     assert response == ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test', 'simple_bus', 'simple_bus', 0, True)
     assert in_tree(tree, 'bind-test-child1', 'phy', 'phy_sandbox', 1, False)
     assert in_tree(tree, 'bind-test-child2', 'simple_bus', 'simple_bus', 1, True)
 
-    response = u_boot_console.run_command('unbind  /bind-test')
+    response = ubman.run_command('unbind  /bind-test')
     assert response == ''
 
 def get_next_line(tree, name):
@@ -120,13 +120,13 @@ def get_next_line(tree, name):
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_bind')
 @pytest.mark.singlethread
-def test_bind_unbind_with_uclass(u_boot_console):
+def test_bind_unbind_with_uclass(ubman):
     #bind /bind-test
-    response = u_boot_console.run_command('bind  /bind-test simple_bus')
+    response = ubman.run_command('bind  /bind-test simple_bus')
     assert response == ''
 
     #make sure bind-test-child2 is there and get its uclass/index pair
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     child2_line = [x.strip() for x in tree.splitlines() if '-- bind-test-child2' in x]
     assert len(child2_line) == 1
 
@@ -134,11 +134,11 @@ def test_bind_unbind_with_uclass(u_boot_console):
     child2_index = int(child2_line[0].split()[1])
 
     #bind simple_bus as a child of bind-test-child2
-    response = u_boot_console.run_command(
+    response = ubman.run_command(
                     'bind  {} {} simple_bus'.format(child2_uclass, child2_index))
 
     #check that the child is there and its uclass/index pair is right
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
 
     child_of_child2_line = get_next_line(tree, 'bind-test-child2')
     assert child_of_child2_line
@@ -147,20 +147,20 @@ def test_bind_unbind_with_uclass(u_boot_console):
     assert child_of_child2_index == child2_index + 1
 
     #unbind the child and check it has been removed
-    response = u_boot_console.run_command('unbind  simple_bus {}'.format(child_of_child2_index))
+    response = ubman.run_command('unbind  simple_bus {}'.format(child_of_child2_index))
     assert response == ''
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test-child2', 'simple_bus', 'simple_bus', 1, True)
     assert not in_tree(tree, 'simple_bus', 'simple_bus', 'simple_bus', 2, True)
     child_of_child2_line = get_next_line(tree, 'bind-test-child2')
     assert child_of_child2_line == ''
 
     #bind simple_bus as a child of bind-test-child2
-    response = u_boot_console.run_command(
+    response = ubman.run_command(
                     'bind  {} {} simple_bus'.format(child2_uclass, child2_index))
 
     #check that the child is there and its uclass/index pair is right
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     treelines = [x.strip() for x in tree.splitlines() if x.strip()]
 
     child_of_child2_line = get_next_line(tree, 'bind-test-child2')
@@ -170,24 +170,24 @@ def test_bind_unbind_with_uclass(u_boot_console):
     assert child_of_child2_index == child2_index + 1
 
     #unbind the child and check it has been removed
-    response = u_boot_console.run_command(
+    response = ubman.run_command(
                     'unbind  {} {} simple_bus'.format(child2_uclass, child2_index))
     assert response == ''
 
-    tree = u_boot_console.run_command('dm tree')
+    tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test-child2', 'simple_bus', 'simple_bus', 1, True)
 
     child_of_child2_line = get_next_line(tree, 'bind-test-child2')
     assert child_of_child2_line == ''
 
     #unbind the child again and check it doesn't change the tree
-    tree_old = u_boot_console.run_command('dm tree')
-    response = u_boot_console.run_command(
+    tree_old = ubman.run_command('dm tree')
+    response = ubman.run_command(
                     'unbind  {} {} simple_bus'.format(child2_uclass, child2_index))
-    tree_new = u_boot_console.run_command('dm tree')
+    tree_new = ubman.run_command('dm tree')
 
     assert response == ''
     assert tree_old == tree_new
 
-    response = u_boot_console.run_command('unbind  /bind-test')
+    response = ubman.run_command('unbind  /bind-test')
     assert response == ''
diff --git a/test/py/tests/test_bootmenu.py b/test/py/tests/test_bootmenu.py
index 70f51de699f..66f3fb8a131 100644
--- a/test/py/tests/test_bootmenu.py
+++ b/test/py/tests/test_bootmenu.py
@@ -5,42 +5,42 @@
 import pytest
 
 @pytest.mark.buildconfigspec('cmd_bootmenu')
-def test_bootmenu(u_boot_console):
+def test_bootmenu(ubman):
     """Test bootmenu
 
-    u_boot_console -- U-Boot console
+    ubman -- U-Boot console
     """
 
-    with u_boot_console.temporary_timeout(500):
-        u_boot_console.run_command('setenv bootmenu_default 1')
-        u_boot_console.run_command('setenv bootmenu_0 test 1=echo ok 1')
-        u_boot_console.run_command('setenv bootmenu_1 test 2=echo ok 2')
-        u_boot_console.run_command('setenv bootmenu_2 test 3=echo ok 3')
-        u_boot_console.run_command('bootmenu 2', wait_for_prompt=False)
+    with ubman.temporary_timeout(500):
+        ubman.run_command('setenv bootmenu_default 1')
+        ubman.run_command('setenv bootmenu_0 test 1=echo ok 1')
+        ubman.run_command('setenv bootmenu_1 test 2=echo ok 2')
+        ubman.run_command('setenv bootmenu_2 test 3=echo ok 3')
+        ubman.run_command('bootmenu 2', wait_for_prompt=False)
         for i in ('U-Boot Boot Menu', 'test 1', 'test 2', 'test 3', 'autoboot'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         # Press enter key to execute default entry
-        response = u_boot_console.run_command(cmd='\x0d', wait_for_echo=False, send_nl=False)
+        response = ubman.run_command(cmd='\x0d', wait_for_echo=False, send_nl=False)
         assert 'ok 2' in response
-        u_boot_console.run_command('bootmenu 2', wait_for_prompt=False)
-        u_boot_console.p.expect(['autoboot'])
+        ubman.run_command('bootmenu 2', wait_for_prompt=False)
+        ubman.p.expect(['autoboot'])
         # Press up key to select prior entry followed by the enter key
-        response = u_boot_console.run_command(cmd='\x1b\x5b\x41\x0d', wait_for_echo=False,
+        response = ubman.run_command(cmd='\x1b\x5b\x41\x0d', wait_for_echo=False,
                                               send_nl=False)
         assert 'ok 1' in response
-        u_boot_console.run_command('bootmenu 2', wait_for_prompt=False)
-        u_boot_console.p.expect(['autoboot'])
+        ubman.run_command('bootmenu 2', wait_for_prompt=False)
+        ubman.p.expect(['autoboot'])
         # Press down key to select next entry followed by the enter key
-        response = u_boot_console.run_command(cmd='\x1b\x5b\x42\x0d', wait_for_echo=False,
+        response = ubman.run_command(cmd='\x1b\x5b\x42\x0d', wait_for_echo=False,
                                               send_nl=False)
         assert 'ok 3' in response
-        u_boot_console.run_command('bootmenu 2; echo rc:$?', wait_for_prompt=False)
-        u_boot_console.p.expect(['autoboot'])
+        ubman.run_command('bootmenu 2; echo rc:$?', wait_for_prompt=False)
+        ubman.p.expect(['autoboot'])
         # Press the escape key
-        response = u_boot_console.run_command(cmd='\x1b', wait_for_echo=False, send_nl=False)
+        response = ubman.run_command(cmd='\x1b', wait_for_echo=False, send_nl=False)
         assert 'ok' not in response
         assert 'rc:0' in response
-        u_boot_console.run_command('setenv bootmenu_default')
-        u_boot_console.run_command('setenv bootmenu_0')
-        u_boot_console.run_command('setenv bootmenu_1')
-        u_boot_console.run_command('setenv bootmenu_2')
+        ubman.run_command('setenv bootmenu_default')
+        ubman.run_command('setenv bootmenu_0')
+        ubman.run_command('setenv bootmenu_1')
+        ubman.run_command('setenv bootmenu_2')
diff --git a/test/py/tests/test_bootstage.py b/test/py/tests/test_bootstage.py
index bd71a1af3a2..379c1cae6dd 100644
--- a/test/py/tests/test_bootstage.py
+++ b/test/py/tests/test_bootstage.py
@@ -24,8 +24,8 @@ env__bootstage_cmd_file = {
 
 @pytest.mark.buildconfigspec('bootstage')
 @pytest.mark.buildconfigspec('cmd_bootstage')
-def test_bootstage_report(u_boot_console):
-    output = u_boot_console.run_command('bootstage report')
+def test_bootstage_report(ubman):
+    output = ubman.run_command('bootstage report')
     assert 'Timer summary in microseconds' in output
     assert 'Accumulated time:' in output
     assert 'dm_r' in output
@@ -33,8 +33,8 @@ def test_bootstage_report(u_boot_console):
 @pytest.mark.buildconfigspec('bootstage')
 @pytest.mark.buildconfigspec('cmd_bootstage')
 @pytest.mark.buildconfigspec('bootstage_stash')
-def test_bootstage_stash_and_unstash(u_boot_console):
-    f = u_boot_console.config.env.get('env__bootstage_cmd_file', None)
+def test_bootstage_stash_and_unstash(ubman):
+    f = ubman.config.env.get('env__bootstage_cmd_file', None)
     if not f:
         pytest.skip('No bootstage environment file is defined')
 
@@ -43,11 +43,11 @@ def test_bootstage_stash_and_unstash(u_boot_console):
     bootstage_magic = f.get('bootstage_magic_addr')
     expected_text = 'dm_r'
 
-    u_boot_console.run_command('bootstage stash %x %x' % (addr, size))
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('bootstage stash %x %x' % (addr, size))
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-    output = u_boot_console.run_command('md %x 100' % addr)
+    output = ubman.run_command('md %x 100' % addr)
 
     # Check BOOTSTAGE_MAGIC address at 4th byte address
     assert '0x' + output.split('\n')[0].split()[4] == hex(bootstage_magic)
@@ -57,6 +57,6 @@ def test_bootstage_stash_and_unstash(u_boot_console):
     assert expected_text in output_last_col
 
     # Check that unstash works as expected
-    u_boot_console.run_command('bootstage unstash %x %x' % (addr, size))
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('bootstage unstash %x %x' % (addr, size))
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
diff --git a/test/py/tests/test_button.py b/test/py/tests/test_button.py
index 3b7f148c8fc..f0d85be896d 100644
--- a/test/py/tests/test_button.py
+++ b/test/py/tests/test_button.py
@@ -4,10 +4,10 @@ import pytest
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_button')
-def test_button_list(u_boot_console):
+def test_button_list(ubman):
     """Test listing buttons"""
 
-    response = u_boot_console.run_command('button list; echo rc:$?')
+    response = ubman.run_command('button list; echo rc:$?')
     assert('button1' in response)
     assert('button2' in response)
     assert('rc:0' in response)
@@ -15,23 +15,23 @@ def test_button_list(u_boot_console):
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_button')
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_button_return_code(u_boot_console):
+def test_button_return_code(ubman):
     """Test correct reporting of the button status
 
     The sandbox gpio driver reports the last output value as input value.
     We can use this in our test to emulate different input statuses.
     """
 
-    u_boot_console.run_command('gpio set a3; gpio input a3');
-    response = u_boot_console.run_command('button button1; echo rc:$?')
+    ubman.run_command('gpio set a3; gpio input a3');
+    response = ubman.run_command('button button1; echo rc:$?')
     assert('on' in response)
     assert('rc:0' in response)
 
-    u_boot_console.run_command('gpio clear a3; gpio input a3');
-    response = u_boot_console.run_command('button button1; echo rc:$?')
+    ubman.run_command('gpio clear a3; gpio input a3');
+    response = ubman.run_command('button button1; echo rc:$?')
     assert('off' in response)
     assert('rc:1' in response)
 
-    response = u_boot_console.run_command('button nonexistent-button; echo rc:$?')
+    response = ubman.run_command('button nonexistent-button; echo rc:$?')
     assert('not found' in response)
     assert('rc:1' in response)
diff --git a/test/py/tests/test_cat/test_cat.py b/test/py/tests/test_cat/test_cat.py
index 132527bd4c2..883803fece7 100644
--- a/test/py/tests/test_cat/test_cat.py
+++ b/test/py/tests/test_cat/test_cat.py
@@ -7,14 +7,14 @@ import pytest
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_cat')
-def test_cat(u_boot_console, cat_data):
+def test_cat(ubman, cat_data):
     """ Unit test for cat
 
     Args:
-        u_boot_console -- U-Boot console
+        ubman -- U-Boot console
         cat_data -- Path to the disk image used for testing.
     """
-    response = u_boot_console.run_command_list([
+    response = ubman.run_command_list([
         f'host bind 0 {cat_data}',
         'cat host 0 hello'])
     assert 'hello world' in response
diff --git a/test/py/tests/test_dfu.py b/test/py/tests/test_dfu.py
index 5d87eb349bf..6efb69990d4 100644
--- a/test/py/tests/test_dfu.py
+++ b/test/py/tests/test_dfu.py
@@ -113,13 +113,13 @@ first_usb_dev_port = None
 
 @pytest.mark.buildconfigspec('cmd_dfu')
 @pytest.mark.requiredtool('dfu-util')
-def test_dfu(u_boot_console, env__usb_dev_port, env__dfu_config):
+def test_dfu(ubman, env__usb_dev_port, env__dfu_config):
     """Test the "dfu" command; the host system must be able to enumerate a USB
     device when "dfu" is running, various DFU transfers are tested, and the
     USB device must disappear when "dfu" is aborted.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__usb_dev_port: The single USB device-mode port specification on
             which to run the test. See the file-level comment above for
             details of the format.
@@ -151,7 +151,7 @@ def test_dfu(u_boot_console, env__usb_dev_port, env__dfu_config):
             fh.close()
             raise Exception('USB device present before dfu command invoked')
 
-        u_boot_console.log.action(
+        ubman.log.action(
             'Starting long-running U-Boot dfu shell command')
 
         dfu_alt_info_env = env__dfu_config.get('alt_info_env_name', \
@@ -159,11 +159,11 @@ def test_dfu(u_boot_console, env__usb_dev_port, env__dfu_config):
 
         cmd = 'setenv "%s" "%s"' % (dfu_alt_info_env,
                                     env__dfu_config['alt_info'])
-        u_boot_console.run_command(cmd)
+        ubman.run_command(cmd)
 
         cmd = 'dfu 0 ' + env__dfu_config['cmd_params']
-        u_boot_console.run_command(cmd, wait_for_prompt=False)
-        u_boot_console.log.action('Waiting for DFU USB device to appear')
+        ubman.run_command(cmd, wait_for_prompt=False)
+        ubman.log.action('Waiting for DFU USB device to appear')
         fh = u_boot_utils.wait_until_open_succeeds(
             env__usb_dev_port['host_usb_dev_node'])
         fh.close()
@@ -185,10 +185,10 @@ def test_dfu(u_boot_console, env__usb_dev_port, env__dfu_config):
         """
 
         try:
-            u_boot_console.log.action(
+            ubman.log.action(
                 'Stopping long-running U-Boot dfu shell command')
-            u_boot_console.ctrlc()
-            u_boot_console.log.action(
+            ubman.ctrlc()
+            ubman.log.action(
                 'Waiting for DFU USB device to disappear')
             u_boot_utils.wait_until_file_open_fails(
                 env__usb_dev_port['host_usb_dev_node'], ignore_errors)
@@ -213,8 +213,8 @@ def test_dfu(u_boot_console, env__usb_dev_port, env__dfu_config):
         cmd = ['dfu-util', '-a', alt_setting, up_dn_load_arg, fn]
         if 'host_usb_port_path' in env__usb_dev_port:
             cmd += ['-p', env__usb_dev_port['host_usb_port_path']]
-        u_boot_utils.run_and_log(u_boot_console, cmd)
-        u_boot_console.wait_for('Ctrl+C to exit ...')
+        u_boot_utils.run_and_log(ubman, cmd)
+        ubman.wait_for('Ctrl+C to exit ...')
 
     def dfu_write(alt_setting, fn):
         """Write a file to the target board using DFU.
@@ -261,23 +261,23 @@ def test_dfu(u_boot_console, env__usb_dev_port, env__dfu_config):
             Nothing.
         """
 
-        test_f = u_boot_utils.PersistentRandomFile(u_boot_console,
+        test_f = u_boot_utils.PersistentRandomFile(ubman,
             'dfu_%d.bin' % size, size)
-        readback_fn = u_boot_console.config.result_dir + '/dfu_readback.bin'
+        readback_fn = ubman.config.result_dir + '/dfu_readback.bin'
 
-        u_boot_console.log.action('Writing test data to DFU primary ' +
+        ubman.log.action('Writing test data to DFU primary ' +
             'altsetting')
         dfu_write(alt_setting_test_file, test_f.abs_fn)
 
-        u_boot_console.log.action('Writing dummy data to DFU secondary ' +
+        ubman.log.action('Writing dummy data to DFU secondary ' +
             'altsetting to clear DFU buffers')
         dfu_write(alt_setting_dummy_file, dummy_f.abs_fn)
 
-        u_boot_console.log.action('Reading DFU primary altsetting for ' +
+        ubman.log.action('Reading DFU primary altsetting for ' +
             'comparison')
         dfu_read(alt_setting_test_file, readback_fn)
 
-        u_boot_console.log.action('Comparing written and read data')
+        ubman.log.action('Comparing written and read data')
         written_hash = test_f.content_hash
         read_back_hash = u_boot_utils.md5sum_file(readback_fn, size)
         assert(written_hash == read_back_hash)
@@ -295,7 +295,7 @@ def test_dfu(u_boot_console, env__usb_dev_port, env__dfu_config):
     else:
         sizes = []
 
-    dummy_f = u_boot_utils.PersistentRandomFile(u_boot_console,
+    dummy_f = u_boot_utils.PersistentRandomFile(ubman,
         'dfu_dummy.bin', 1024)
 
     alt_setting_test_file = env__dfu_config.get('alt_id_test_file', '0')
@@ -305,16 +305,16 @@ def test_dfu(u_boot_console, env__usb_dev_port, env__dfu_config):
     try:
         start_dfu()
 
-        u_boot_console.log.action(
+        ubman.log.action(
             'Overwriting DFU primary altsetting with dummy data')
         dfu_write(alt_setting_test_file, dummy_f.abs_fn)
 
         for size in sizes:
-            with u_boot_console.log.section('Data size %d' % size):
+            with ubman.log.section('Data size %d' % size):
                 dfu_write_read_check(size)
                 # Make the status of each sub-test obvious. If the test didn't
                 # pass, an exception was thrown so this code isn't executed.
-                u_boot_console.log.status_pass('OK')
+                ubman.log.status_pass('OK')
         ignore_cleanup_errors = False
     finally:
         stop_dfu(ignore_cleanup_errors)
diff --git a/test/py/tests/test_dm.py b/test/py/tests/test_dm.py
index be94971e455..f4c2ccd1101 100644
--- a/test/py/tests/test_dm.py
+++ b/test/py/tests/test_dm.py
@@ -4,15 +4,15 @@
 import pytest
 
 @pytest.mark.buildconfigspec('cmd_dm')
-def test_dm_compat(u_boot_console):
+def test_dm_compat(ubman):
     """Test that each driver in `dm tree` is also listed in `dm compat`."""
-    response = u_boot_console.run_command('dm tree')
+    response = ubman.run_command('dm tree')
     driver_index = response.find('Driver')
     assert driver_index != -1
     drivers = (line[driver_index:].split()[0]
                for line in response[:-1].split('\n')[2:])
 
-    response = u_boot_console.run_command('dm compat')
+    response = ubman.run_command('dm compat')
     bad_drivers = set()
     for driver in drivers:
         if not driver in response:
@@ -29,7 +29,7 @@ def test_dm_compat(u_boot_console):
     # checking sorting only after UCLASS_AXI_EMUL after which the names should
     # be sorted.
 
-    response = u_boot_console.run_command('dm tree -s')
+    response = ubman.run_command('dm tree -s')
     lines = response.split('\n')[2:]
     stack = []   # holds where we were up to at the previous indent level
     prev = ''    # uclass name of previous line
@@ -58,27 +58,27 @@ def test_dm_compat(u_boot_console):
 
 
 @pytest.mark.buildconfigspec('cmd_dm')
-def test_dm_drivers(u_boot_console):
+def test_dm_drivers(ubman):
     """Test that each driver in `dm compat` is also listed in `dm drivers`."""
-    response = u_boot_console.run_command('dm compat')
+    response = ubman.run_command('dm compat')
     drivers = (line[:20].rstrip() for line in response[:-1].split('\n')[2:])
-    response = u_boot_console.run_command('dm drivers')
+    response = ubman.run_command('dm drivers')
     for driver in drivers:
         assert driver in response
 
 @pytest.mark.buildconfigspec('cmd_dm')
-def test_dm_static(u_boot_console):
+def test_dm_static(ubman):
     """Test that each driver in `dm static` is also listed in `dm drivers`."""
-    response = u_boot_console.run_command('dm static')
+    response = ubman.run_command('dm static')
     drivers = (line[:25].rstrip() for line in response[:-1].split('\n')[2:])
-    response = u_boot_console.run_command('dm drivers')
+    response = ubman.run_command('dm drivers')
     for driver in drivers:
         assert driver in response
 
 @pytest.mark.buildconfigspec("cmd_dm")
-def test_dm_uclass(u_boot_console):
-    response = u_boot_console.run_command("dm uclass")
+def test_dm_uclass(ubman):
+    response = ubman.run_command("dm uclass")
 
 @pytest.mark.buildconfigspec("cmd_dm")
-def test_dm_devres(u_boot_console):
-    response = u_boot_console.run_command("dm devres")
+def test_dm_devres(ubman):
+    response = ubman.run_command("dm devres")
diff --git a/test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py b/test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py
index 1bb59d8fcf8..8800e9de5b4 100644
--- a/test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py
+++ b/test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py
@@ -8,37 +8,37 @@ import pytest
 @pytest.mark.buildconfigspec('cmd_efidebug')
 @pytest.mark.buildconfigspec('cmd_bootefi_bootmgr')
 @pytest.mark.singlethread
-def test_efi_bootmgr(u_boot_console, efi_bootmgr_data):
+def test_efi_bootmgr(ubman, efi_bootmgr_data):
     """ Unit test for UEFI bootmanager
     The efidebug command is used to set up UEFI load options.
     The bootefi bootmgr loads initrddump.efi as a payload.
     The crc32 of the loaded initrd.img is checked
 
     Args:
-        u_boot_console -- U-Boot console
+        ubman -- U-Boot console
         efi_bootmgr_data -- Path to the disk image used for testing.
     """
-    u_boot_console.run_command(cmd = f'host bind 0 {efi_bootmgr_data}')
+    ubman.run_command(cmd = f'host bind 0 {efi_bootmgr_data}')
 
-    u_boot_console.run_command(cmd = 'efidebug boot add ' \
+    ubman.run_command(cmd = 'efidebug boot add ' \
         '-b 0001 label-1 host 0:1 initrddump.efi ' \
         '-i host 0:1 initrd-1.img -s nocolor')
-    u_boot_console.run_command(cmd = 'efidebug boot dump')
-    u_boot_console.run_command(cmd = 'efidebug boot order 0001')
-    u_boot_console.run_command(cmd = 'bootefi bootmgr')
-    response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
+    ubman.run_command(cmd = 'efidebug boot dump')
+    ubman.run_command(cmd = 'efidebug boot order 0001')
+    ubman.run_command(cmd = 'bootefi bootmgr')
+    response = ubman.run_command(cmd = 'load', wait_for_echo=False)
     assert 'crc32: 0x181464af' in response
-    u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
+    ubman.run_command(cmd = 'exit', wait_for_echo=False)
 
-    u_boot_console.run_command(cmd = 'efidebug boot add ' \
+    ubman.run_command(cmd = 'efidebug boot add ' \
         '-B 0002 label-2 host 0:1 initrddump.efi ' \
         '-I host 0:1 initrd-2.img -s nocolor')
-    u_boot_console.run_command(cmd = 'efidebug boot dump')
-    u_boot_console.run_command(cmd = 'efidebug boot order 0002')
-    u_boot_console.run_command(cmd = 'bootefi bootmgr')
-    response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
+    ubman.run_command(cmd = 'efidebug boot dump')
+    ubman.run_command(cmd = 'efidebug boot order 0002')
+    ubman.run_command(cmd = 'bootefi bootmgr')
+    response = ubman.run_command(cmd = 'load', wait_for_echo=False)
     assert 'crc32: 0x811d3515' in response
-    u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
+    ubman.run_command(cmd = 'exit', wait_for_echo=False)
 
-    u_boot_console.run_command(cmd = 'efidebug boot rm 0001')
-    u_boot_console.run_command(cmd = 'efidebug boot rm 0002')
+    ubman.run_command(cmd = 'efidebug boot rm 0001')
+    ubman.run_command(cmd = 'efidebug boot rm 0002')
diff --git a/test/py/tests/test_efi_capsule/capsule_common.py b/test/py/tests/test_efi_capsule/capsule_common.py
index fc0d851c619..40b3fca809e 100644
--- a/test/py/tests/test_efi_capsule/capsule_common.py
+++ b/test/py/tests/test_efi_capsule/capsule_common.py
@@ -6,15 +6,15 @@
 
 from capsule_defs import CAPSULE_DATA_DIR, CAPSULE_INSTALL_DIR
 
-def capsule_setup(u_boot_console, disk_img, osindications):
+def capsule_setup(ubman, disk_img, osindications):
     """setup the test
 
     Args:
-        u_boot_console -- A console connection to U-Boot.
+        ubman -- A console connection to U-Boot.
         disk_img -- A path to disk image to be used for testing.
         osindications -- String of osindications value.
     """
-    u_boot_console.run_command_list([
+    ubman.run_command_list([
         f'host bind 0 {disk_img}',
         'printenv -e PlatformLangCodes', # workaround for terminal size determination
         'efidebug boot add -b 1 TEST host 0:1 /helloworld.efi',
@@ -23,22 +23,22 @@ def capsule_setup(u_boot_console, disk_img, osindications):
         'u-boot-env raw 0x150000 0x200000"'])
 
     if osindications is None:
-        u_boot_console.run_command('env set -e OsIndications')
+        ubman.run_command('env set -e OsIndications')
     else:
-        u_boot_console.run_command(f'env set -e -nv -bs -rt OsIndications ={osindications}')
+        ubman.run_command(f'env set -e -nv -bs -rt OsIndications ={osindications}')
 
-    u_boot_console.run_command('env save')
+    ubman.run_command('env save')
 
-def init_content(u_boot_console, target, filename, expected):
+def init_content(ubman, target, filename, expected):
     """initialize test content
 
     Args:
-        u_boot_console -- A console connection to U-Boot.
+        ubman -- A console connection to U-Boot.
         target -- Target address to place the content.
         filename -- File name of the content.
         expected -- Expected string of the content.
     """
-    output = u_boot_console.run_command_list([
+    output = ubman.run_command_list([
         'sf probe 0:0',
         f'fatload host 0:1 4000000 {CAPSULE_DATA_DIR}/{filename}',
         f'sf write 4000000 {target} 10',
@@ -46,34 +46,34 @@ def init_content(u_boot_console, target, filename, expected):
         'md.b 5000000 10'])
     assert expected in ''.join(output)
 
-def place_capsule_file(u_boot_console, filenames):
+def place_capsule_file(ubman, filenames):
     """place the capsule file
 
     Args:
-        u_boot_console -- A console connection to U-Boot.
+        ubman -- A console connection to U-Boot.
         filenames -- File name array of the target capsule files.
     """
     for name in filenames:
-        u_boot_console.run_command_list([
+        ubman.run_command_list([
             f'fatload host 0:1 4000000 {CAPSULE_DATA_DIR}/{name}',
             f'fatwrite host 0:1 4000000 {CAPSULE_INSTALL_DIR}/{name} $filesize'])
 
-    output = u_boot_console.run_command(f'fatls host 0:1 {CAPSULE_INSTALL_DIR}')
+    output = ubman.run_command(f'fatls host 0:1 {CAPSULE_INSTALL_DIR}')
     for name in filenames:
         assert name in ''.join(output)
 
-def exec_manual_update(u_boot_console, disk_img, filenames, need_reboot = True):
+def exec_manual_update(ubman, disk_img, filenames, need_reboot = True):
     """execute capsule update manually
 
     Args:
-        u_boot_console -- A console connection to U-Boot.
+        ubman -- A console connection to U-Boot.
         disk_img -- A path to disk image to be used for testing.
         filenames -- File name array of the target capsule files.
         need_reboot -- Flag indicates whether system reboot is required.
     """
     # make sure that dfu_alt_info exists even persistent variables
     # are not available.
-    output = u_boot_console.run_command_list([
+    output = ubman.run_command_list([
         'env set dfu_alt_info '
                 '"sf 0:0=u-boot-bin raw 0x100000 0x50000;'
                 'u-boot-env raw 0x150000 0x200000"',
@@ -83,60 +83,60 @@ def exec_manual_update(u_boot_console, disk_img, filenames, need_reboot = True):
         assert name in ''.join(output)
 
     # need to run uefi command to initiate capsule handling
-    u_boot_console.run_command(
+    ubman.run_command(
         'env print -e Capsule0000', wait_for_reboot = need_reboot)
 
-def check_file_removed(u_boot_console, disk_img, filenames):
+def check_file_removed(ubman, disk_img, filenames):
     """check files are removed
 
     Args:
-        u_boot_console -- A console connection to U-Boot.
+        ubman -- A console connection to U-Boot.
         disk_img -- A path to disk image to be used for testing.
         filenames -- File name array of the target capsule files.
     """
-    output = u_boot_console.run_command_list([
+    output = ubman.run_command_list([
         f'host bind 0 {disk_img}',
         f'fatls host 0:1 {CAPSULE_INSTALL_DIR}'])
     for name in filenames:
         assert name not in ''.join(output)
 
-def check_file_exist(u_boot_console, disk_img, filenames):
+def check_file_exist(ubman, disk_img, filenames):
     """check files exist
 
     Args:
-        u_boot_console -- A console connection to U-Boot.
+        ubman -- A console connection to U-Boot.
         disk_img -- A path to disk image to be used for testing.
         filenames -- File name array of the target capsule files.
     """
-    output = u_boot_console.run_command_list([
+    output = ubman.run_command_list([
         f'host bind 0 {disk_img}',
         f'fatls host 0:1 {CAPSULE_INSTALL_DIR}'])
     for name in filenames:
         assert name in ''.join(output)
 
-def verify_content(u_boot_console, target, expected):
+def verify_content(ubman, target, expected):
     """verify the content
 
     Args:
-        u_boot_console -- A console connection to U-Boot.
+        ubman -- A console connection to U-Boot.
         target -- Target address to verify.
         expected -- Expected string of the content.
     """
-    output = u_boot_console.run_command_list([
+    output = ubman.run_command_list([
         'sf probe 0:0',
         f'sf read 4000000 {target} 10',
         'md.b 4000000 10'])
     assert expected in ''.join(output)
 
-def do_reboot_dtb_specified(u_boot_config, u_boot_console, dtb_filename):
+def do_reboot_dtb_specified(u_boot_config, ubman, dtb_filename):
     """do reboot with specified DTB
 
     Args:
         u_boot_config -- U-boot configuration.
-        u_boot_console -- A console connection to U-Boot.
+        ubman -- A console connection to U-Boot.
         dtb_filename -- DTB file name.
     """
     mnt_point = u_boot_config.persistent_data_dir + '/test_efi_capsule'
-    u_boot_console.config.dtb = mnt_point + CAPSULE_DATA_DIR \
+    ubman.config.dtb = mnt_point + CAPSULE_DATA_DIR \
                                 + f'/{dtb_filename}'
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
index a726c71c113..016274533cd 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
@@ -33,7 +33,7 @@ class TestEfiCapsuleFirmwareFit():
     """
 
     def test_efi_capsule_fw1(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 1
         Update U-Boot and U-Boot environment on SPI Flash
         but with an incorrect GUID value in the capsule
@@ -44,34 +44,34 @@ class TestEfiCapsuleFirmwareFit():
         # other tests might have run and the
         # system might not be in a clean state.
         # Restart before starting the tests.
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
 
         disk_img = efi_capsule_data
         capsule_files = ['Test05']
-        with u_boot_console.log.section('Test Case 1-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            init_content(u_boot_console, '150000', 'u-boot.env.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 1-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
 
         # reboot
-        u_boot_console.restart_uboot(expect_reset = capsule_early)
+        ubman.restart_uboot(expect_reset = capsule_early)
 
-        with u_boot_console.log.section('Test Case 1-b, after reboot'):
+        with ubman.log.section('Test Case 1-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
             # deleted anyway
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
-            verify_content(u_boot_console, '150000', 'u-boot-env:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
+            verify_content(ubman, '150000', 'u-boot-env:Old')
 
     def test_efi_capsule_fw2(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 2
         Update U-Boot and U-Boot environment on SPI Flash
         0x100000-0x150000: U-Boot binary (but dummy)
@@ -80,11 +80,11 @@ class TestEfiCapsuleFirmwareFit():
 
         disk_img = efi_capsule_data
         capsule_files = ['Test04']
-        with u_boot_console.log.section('Test Case 2-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            init_content(u_boot_console, '150000', 'u-boot.env.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 2-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
@@ -92,22 +92,22 @@ class TestEfiCapsuleFirmwareFit():
             'config_efi_capsule_authenticate')
 
         # reboot
-        u_boot_console.restart_uboot(expect_reset = capsule_early)
+        ubman.restart_uboot(expect_reset = capsule_early)
 
-        with u_boot_console.log.section('Test Case 2-b, after reboot'):
+        with ubman.log.section('Test Case 2-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
             expected = 'u-boot:Old' if capsule_auth else 'u-boot:New'
-            verify_content(u_boot_console, '100000', expected)
+            verify_content(ubman, '100000', expected)
 
             expected = 'u-boot-env:Old' if capsule_auth else 'u-boot-env:New'
-            verify_content(u_boot_console, '150000', expected)
+            verify_content(ubman, '150000', expected)
 
     def test_efi_capsule_fw3(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """ Test Case 3
         Update U-Boot on SPI Flash, raw image format with fw_version and lowest_supported_version
         0x100000-0x150000: U-Boot binary (but dummy)
@@ -115,47 +115,47 @@ class TestEfiCapsuleFirmwareFit():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test104']
-        with u_boot_console.log.section('Test Case 3-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            init_content(u_boot_console, '150000', 'u-boot.env.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 3-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         # reboot
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_ver.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_ver.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
         capsule_auth = u_boot_config.buildconfig.get(
             'config_efi_capsule_authenticate')
-        with u_boot_console.log.section('Test Case 3-b, after reboot'):
+        with ubman.log.section('Test Case 3-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
             # deleted anyway
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
             # make sure the dfu_alt_info exists because it is required for making ESRT.
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000;'
                 'u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
             if capsule_auth:
                 # capsule authentication failed
-                verify_content(u_boot_console, '100000', 'u-boot:Old')
-                verify_content(u_boot_console, '150000', 'u-boot-env:Old')
+                verify_content(ubman, '100000', 'u-boot:Old')
+                verify_content(ubman, '150000', 'u-boot-env:Old')
             else:
                 # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
                 assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
                 assert 'ESRT: fw_version=5' in ''.join(output)
                 assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
-                verify_content(u_boot_console, '100000', 'u-boot:New')
-                verify_content(u_boot_console, '150000', 'u-boot-env:New')
+                verify_content(ubman, '100000', 'u-boot:New')
+                verify_content(ubman, '150000', 'u-boot-env:New')
 
     def test_efi_capsule_fw4(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """ Test Case 4
         Update U-Boot on SPI Flash, raw image format with fw_version and lowest_supported_version
         but fw_version is lower than lowest_supported_version
@@ -164,20 +164,20 @@ class TestEfiCapsuleFirmwareFit():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test105']
-        with u_boot_console.log.section('Test Case 4-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 4-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         # reboot
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_ver.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_ver.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 4-b, after reboot'):
+        with ubman.log.section('Test Case 4-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index 8a790405c7c..b8cb483b380 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -34,7 +34,7 @@ class TestEfiCapsuleFirmwareRaw:
     """
 
     def test_efi_capsule_fw1(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """ Test Case 1
         Update U-Boot and U-Boot environment on SPI Flash
         but with an incorrect GUID value in the capsule
@@ -46,34 +46,34 @@ class TestEfiCapsuleFirmwareRaw:
         # other tests might have run and the
         # system might not be in a clean state.
         # Restart before starting the tests.
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
 
         disk_img = efi_capsule_data
         capsule_files = ['Test03']
-        with u_boot_console.log.section('Test Case 1-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            init_content(u_boot_console, '150000', 'u-boot.env.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 1-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         # reboot
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
 
-        with u_boot_console.log.section('Test Case 1-b, after reboot'):
+        with ubman.log.section('Test Case 1-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
             # deleted anyway
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
-            verify_content(u_boot_console, '150000', 'u-boot-env:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
+            verify_content(ubman, '150000', 'u-boot-env:Old')
 
     def test_efi_capsule_fw2(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """ Test Case 2
         Update U-Boot and U-Boot environment on SPI Flash but with OsIndications unset
         No update should happen unless CONFIG_EFI_IGNORE_OSINDICATIONS is set
@@ -82,14 +82,14 @@ class TestEfiCapsuleFirmwareRaw:
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test01', 'Test02']
-        with u_boot_console.log.section('Test Case 2-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, None)
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            init_content(u_boot_console, '150000', 'u-boot.env.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 2-a, before reboot'):
+            capsule_setup(ubman, disk_img, None)
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         # reboot
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
 
         ignore_os_indications = u_boot_config.buildconfig.get(
             'config_efi_ignore_osindications')
@@ -100,32 +100,32 @@ class TestEfiCapsuleFirmwareRaw:
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 2-b, after reboot'):
+        with ubman.log.section('Test Case 2-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files, need_reboot)
+                exec_manual_update(ubman, disk_img, capsule_files, need_reboot)
 
             if not ignore_os_indications:
-                check_file_exist(u_boot_console, disk_img, capsule_files)
+                check_file_exist(ubman, disk_img, capsule_files)
 
             expected = 'u-boot:New' if (ignore_os_indications and not capsule_auth) else 'u-boot:Old'
-            verify_content(u_boot_console, '100000', expected)
+            verify_content(ubman, '100000', expected)
 
             expected = 'u-boot-env:New' if (ignore_os_indications and not capsule_auth) else 'u-boot-env:Old'
-            verify_content(u_boot_console, '150000', expected)
+            verify_content(ubman, '150000', expected)
 
     def test_efi_capsule_fw3(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """ Test Case 3
         Update U-Boot on SPI Flash, raw image format
         0x100000-0x150000: U-Boot binary (but dummy)
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test01', 'Test02']
-        with u_boot_console.log.section('Test Case 3-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            init_content(u_boot_console, '150000', 'u-boot.env.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 3-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
@@ -133,14 +133,14 @@ class TestEfiCapsuleFirmwareRaw:
             'config_efi_capsule_authenticate')
 
         # reboot
-        u_boot_console.restart_uboot(expect_reset = capsule_early)
+        ubman.restart_uboot(expect_reset = capsule_early)
 
-        with u_boot_console.log.section('Test Case 3-b, after reboot'):
+        with ubman.log.section('Test Case 3-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
             # make sure the dfu_alt_info exists because it is required for making ESRT.
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000;u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
@@ -150,16 +150,16 @@ class TestEfiCapsuleFirmwareRaw:
             # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
             assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
             expected = 'u-boot:Old' if capsule_auth else 'u-boot:New'
-            verify_content(u_boot_console, '100000', expected)
+            verify_content(ubman, '100000', expected)
 
             expected = 'u-boot-env:Old' if capsule_auth else 'u-boot-env:New'
-            verify_content(u_boot_console, '150000', expected)
+            verify_content(ubman, '150000', expected)
 
     def test_efi_capsule_fw4(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """ Test Case 4
         Update U-Boot on SPI Flash, raw image format with fw_version and lowest_supported_version
         0x100000-0x150000: U-Boot binary (but dummy)
@@ -167,36 +167,36 @@ class TestEfiCapsuleFirmwareRaw:
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test101', 'Test102']
-        with u_boot_console.log.section('Test Case 4-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            init_content(u_boot_console, '150000', 'u-boot.env.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 4-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            init_content(ubman, '150000', 'u-boot.env.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         # reboot
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_ver.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_ver.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
         capsule_auth = u_boot_config.buildconfig.get(
             'config_efi_capsule_authenticate')
-        with u_boot_console.log.section('Test Case 4-b, after reboot'):
+        with ubman.log.section('Test Case 4-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
             # deleted anyway
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
             # make sure the dfu_alt_info exists because it is required for making ESRT.
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000'
                 'u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
             if capsule_auth:
                 # capsule authentication failed
-                verify_content(u_boot_console, '100000', 'u-boot:Old')
-                verify_content(u_boot_console, '150000', 'u-boot-env:Old')
+                verify_content(ubman, '100000', 'u-boot:Old')
+                verify_content(ubman, '150000', 'u-boot-env:Old')
             else:
                 # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
                 assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
@@ -208,11 +208,11 @@ class TestEfiCapsuleFirmwareRaw:
                 assert 'ESRT: fw_version=10' in ''.join(output)
                 assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
 
-                verify_content(u_boot_console, '100000', 'u-boot:New')
-                verify_content(u_boot_console, '150000', 'u-boot-env:New')
+                verify_content(ubman, '100000', 'u-boot:New')
+                verify_content(ubman, '150000', 'u-boot-env:New')
 
     def test_efi_capsule_fw5(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """ Test Case 5
         Update U-Boot on SPI Flash, raw image format with fw_version and lowest_supported_version
         but fw_version is lower than lowest_supported_version
@@ -221,20 +221,20 @@ class TestEfiCapsuleFirmwareRaw:
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test103']
-        with u_boot_console.log.section('Test Case 5-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 5-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
         # reboot
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_ver.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_ver.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 5-b, after reboot'):
+        with ubman.log.section('Test Case 5-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
index debbce8bdbd..29545c5080a 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
@@ -36,7 +36,7 @@ class TestEfiCapsuleFirmwareSignedFit():
     """
 
     def test_efi_capsule_auth1(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 1
         Update U-Boot on SPI Flash, FIT image format
         x150000: U-Boot binary (but dummy)
@@ -46,25 +46,25 @@ class TestEfiCapsuleFirmwareSignedFit():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test13']
-        with u_boot_console.log.section('Test Case 1-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 1-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_sig.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 1-b, after reboot'):
+        with ubman.log.section('Test Case 1-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            verify_content(u_boot_console, '100000', 'u-boot:New')
+            verify_content(ubman, '100000', 'u-boot:New')
 
     def test_efi_capsule_auth2(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 2
         Update U-Boot on SPI Flash, FIT image format
         0x100000-0x150000: U-Boot binary (but dummy)
@@ -75,28 +75,28 @@ class TestEfiCapsuleFirmwareSignedFit():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test14']
-        with u_boot_console.log.section('Test Case 2-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 2-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_sig.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 2-b, after reboot'):
+        with ubman.log.section('Test Case 2-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
             # deleted any way
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
             # TODO: check CapsuleStatus in CapsuleXXXX
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
 
     def test_efi_capsule_auth3(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 3
         Update U-Boot on SPI Flash, FIT image format
         0x100000-0x150000: U-Boot binary (but dummy)
@@ -106,28 +106,28 @@ class TestEfiCapsuleFirmwareSignedFit():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test02']
-        with u_boot_console.log.section('Test Case 3-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 3-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_sig.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 3-b, after reboot'):
+        with ubman.log.section('Test Case 3-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
             # deleted any way
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
             # TODO: check CapsuleStatus in CapsuleXXXX
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
 
     def test_efi_capsule_auth4(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 4 - Update U-Boot on SPI Flash, raw image format with version information
         0x100000-0x150000: U-Boot binary (but dummy)
 
@@ -136,22 +136,22 @@ class TestEfiCapsuleFirmwareSignedFit():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test114']
-        with u_boot_console.log.section('Test Case 4-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 4-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_ver.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_ver.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 4-b, after reboot'):
+        with ubman.log.section('Test Case 4-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000;'
                 'u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
@@ -161,11 +161,11 @@ class TestEfiCapsuleFirmwareSignedFit():
             assert 'ESRT: fw_version=5' in ''.join(output)
             assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
-            verify_content(u_boot_console, '100000', 'u-boot:New')
-            verify_content(u_boot_console, '150000', 'u-boot-env:New')
+            verify_content(ubman, '100000', 'u-boot:New')
+            verify_content(ubman, '150000', 'u-boot-env:New')
 
     def test_efi_capsule_auth5(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 5 - Update U-Boot on SPI Flash, raw image format with version information
         0x100000-0x150000: U-Boot binary (but dummy)
 
@@ -175,19 +175,19 @@ class TestEfiCapsuleFirmwareSignedFit():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test115']
-        with u_boot_console.log.section('Test Case 5-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 5-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_ver.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_ver.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 5-b, after reboot'):
+        with ubman.log.section('Test Case 5-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
index 439bd71b3a7..a500c499bb9 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
@@ -34,7 +34,7 @@ class TestEfiCapsuleFirmwareSignedRaw():
     """
 
     def test_efi_capsule_auth1(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 1 - Update U-Boot on SPI Flash, raw image format
         0x100000-0x150000: U-Boot binary (but dummy)
 
@@ -43,25 +43,25 @@ class TestEfiCapsuleFirmwareSignedRaw():
         """
         disk_img = efi_capsule_data
         capsule_files =  ['Test11']
-        with u_boot_console.log.section('Test Case 1-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 1-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_sig.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 1-b, after reboot'):
+        with ubman.log.section('Test Case 1-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            verify_content(u_boot_console, '100000', 'u-boot:New')
+            verify_content(ubman, '100000', 'u-boot:New')
 
     def test_efi_capsule_auth2(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 2 - Update U-Boot on SPI Flash, raw image format
         0x100000-0x150000: U-Boot binary (but dummy)
 
@@ -71,27 +71,27 @@ class TestEfiCapsuleFirmwareSignedRaw():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test12']
-        with u_boot_console.log.section('Test Case 2-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 2-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_sig.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 2-b, after reboot'):
+        with ubman.log.section('Test Case 2-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
             # TODO: check CapsuleStatus in CapsuleXXXX
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
 
     def test_efi_capsule_auth3(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 3 - Update U-Boot on SPI Flash, raw image format
         0x100000-0x150000: U-Boot binary (but dummy)
 
@@ -100,28 +100,28 @@ class TestEfiCapsuleFirmwareSignedRaw():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test02']
-        with u_boot_console.log.section('Test Case 3-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 3-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_sig.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 3-b, after reboot'):
+        with ubman.log.section('Test Case 3-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
             # deleted anyway
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
             # TODO: check CapsuleStatus in CapsuleXXXX
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
 
     def test_efi_capsule_auth4(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 4 - Update U-Boot on SPI Flash, raw image format with version information
         0x100000-0x150000: U-Boot binary (but dummy)
 
@@ -130,22 +130,22 @@ class TestEfiCapsuleFirmwareSignedRaw():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test111', 'Test112']
-        with u_boot_console.log.section('Test Case 4-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 4-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_ver.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_ver.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 4-b, after reboot'):
+        with ubman.log.section('Test Case 4-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000;'
                 'u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
@@ -160,11 +160,11 @@ class TestEfiCapsuleFirmwareSignedRaw():
             assert 'ESRT: fw_version=10' in ''.join(output)
             assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
 
-            verify_content(u_boot_console, '100000', 'u-boot:New')
-            verify_content(u_boot_console, '150000', 'u-boot-env:New')
+            verify_content(ubman, '100000', 'u-boot:New')
+            verify_content(ubman, '150000', 'u-boot-env:New')
 
     def test_efi_capsule_auth5(
-            self, u_boot_config, u_boot_console, efi_capsule_data):
+            self, u_boot_config, ubman, efi_capsule_data):
         """Test Case 5 - Update U-Boot on SPI Flash, raw image format with version information
         0x100000-0x150000: U-Boot binary (but dummy)
 
@@ -174,19 +174,19 @@ class TestEfiCapsuleFirmwareSignedRaw():
         """
         disk_img = efi_capsule_data
         capsule_files = ['Test113']
-        with u_boot_console.log.section('Test Case 5-a, before reboot'):
-            capsule_setup(u_boot_console, disk_img, '0x0000000000000004')
-            init_content(u_boot_console, '100000', 'u-boot.bin.old', 'Old')
-            place_capsule_file(u_boot_console, capsule_files)
+        with ubman.log.section('Test Case 5-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
 
-        do_reboot_dtb_specified(u_boot_config, u_boot_console, 'test_ver.dtb')
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_ver.dtb')
 
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
-        with u_boot_console.log.section('Test Case 5-b, after reboot'):
+        with ubman.log.section('Test Case 5-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files)
+                exec_manual_update(ubman, disk_img, capsule_files)
 
-            check_file_removed(u_boot_console, disk_img, capsule_files)
+            check_file_removed(ubman, disk_img, capsule_files)
 
-            verify_content(u_boot_console, '100000', 'u-boot:Old')
+            verify_content(ubman, '100000', 'u-boot:Old')
diff --git a/test/py/tests/test_efi_fit.py b/test/py/tests/test_efi_fit.py
index 550058a30fd..4a464382126 100644
--- a/test/py/tests/test_efi_fit.py
+++ b/test/py/tests/test_efi_fit.py
@@ -123,7 +123,7 @@ FDT_DATA = '''
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.notbuildconfigspec('generate_acpi_table')
 @pytest.mark.requiredtool('dtc')
-def test_efi_fit_launch(u_boot_console):
+def test_efi_fit_launch(ubman):
     """Test handling of UEFI binaries inside FIT images.
 
     The tests are trying to launch U-Boot's helloworld.efi embedded into
@@ -428,7 +428,7 @@ def test_efi_fit_launch(u_boot_console):
             assert '## Application failed' not in output
             cons.restart_uboot()
 
-    cons = u_boot_console
+    cons = ubman
     # Array slice removes leading/trailing quotes.
     sys_arch = cons.config.buildconfig.get('config_sys_arch', '"sandbox"')[1:-1]
     if sys_arch == 'arm':
diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 33434935fe9..ff880ffa527 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -59,65 +59,65 @@ PROTO_TFTP, PROTO_HTTP = range(0, 2)
 
 net_set_up = False
 
-def test_efi_pre_commands(u_boot_console):
+def test_efi_pre_commands(ubman):
     """Execute any commands required to enable network hardware.
 
     These commands are provided by the boardenv_* file; see the comment at the
     beginning of this file.
     """
 
-    init_usb = u_boot_console.config.env.get('env__net_uses_usb', False)
+    init_usb = ubman.config.env.get('env__net_uses_usb', False)
     if init_usb:
-        u_boot_console.run_command('usb start')
+        ubman.run_command('usb start')
 
-    init_pci = u_boot_console.config.env.get('env__net_uses_pci', False)
+    init_pci = ubman.config.env.get('env__net_uses_pci', False)
     if init_pci:
-        u_boot_console.run_command('pci enum')
+        ubman.run_command('pci enum')
 
 @pytest.mark.buildconfigspec('cmd_dhcp')
-def test_efi_setup_dhcp(u_boot_console):
+def test_efi_setup_dhcp(ubman):
     """Set up the network using DHCP.
 
     The boardenv_* file may be used to enable/disable this test; see the
     comment at the beginning of this file.
     """
 
-    test_dhcp = u_boot_console.config.env.get('env__net_dhcp_server', False)
+    test_dhcp = ubman.config.env.get('env__net_dhcp_server', False)
     if not test_dhcp:
-        env_vars = u_boot_console.config.env.get('env__net_static_env_vars', None)
+        env_vars = ubman.config.env.get('env__net_static_env_vars', None)
         if not env_vars:
             pytest.skip('No DHCP server available')
         return
 
-    u_boot_console.run_command('setenv autoload no')
-    output = u_boot_console.run_command('dhcp')
+    ubman.run_command('setenv autoload no')
+    output = ubman.run_command('dhcp')
     assert 'DHCP client bound to address ' in output
 
     global net_set_up
     net_set_up = True
 
 @pytest.mark.buildconfigspec('net')
-def test_efi_setup_static(u_boot_console):
+def test_efi_setup_static(ubman):
     """Set up the network using a static IP configuration.
 
     The configuration is provided by the boardenv_* file; see the comment at
     the beginning of this file.
     """
 
-    env_vars = u_boot_console.config.env.get('env__net_static_env_vars', None)
+    env_vars = ubman.config.env.get('env__net_static_env_vars', None)
     if not env_vars:
-        test_dhcp = u_boot_console.config.env.get('env__net_dhcp_server', False)
+        test_dhcp = ubman.config.env.get('env__net_dhcp_server', False)
         if not test_dhcp:
             pytest.skip('No static network configuration is defined')
         return None
 
     for (var, val) in env_vars:
-        u_boot_console.run_command('setenv %s %s' % (var, val))
+        ubman.run_command('setenv %s %s' % (var, val))
 
     global net_set_up
     net_set_up = True
 
-def fetch_file(u_boot_console, env_conf, proto):
+def fetch_file(ubman, env_conf, proto):
     """Grab an env described file via TFTP or HTTP and return its address
 
     A file as described by an env config <env_conf> is downloaded from the
@@ -126,13 +126,13 @@ def fetch_file(u_boot_console, env_conf, proto):
     if not net_set_up:
         pytest.skip('Network not initialized')
 
-    f = u_boot_console.config.env.get(env_conf, None)
+    f = ubman.config.env.get(env_conf, None)
     if not f:
         pytest.skip('No %s binary specified in environment' % env_conf)
 
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     fn = f['fn']
     if proto == PROTO_TFTP:
@@ -141,7 +141,7 @@ def fetch_file(u_boot_console, env_conf, proto):
         cmd = 'wget'
     else:
         assert False
-    output = u_boot_console.run_command('%s %x %s' % (cmd, addr, fn))
+    output = ubman.run_command('%s %x %s' % (cmd, addr, fn))
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
     if sz:
@@ -152,18 +152,18 @@ def fetch_file(u_boot_console, env_conf, proto):
     if not expected_crc:
         return addr
 
-    if u_boot_console.config.buildconfig.get('config_cmd_crc32', 'n') != 'y':
+    if ubman.config.buildconfig.get('config_cmd_crc32', 'n') != 'y':
         return addr
 
-    output = u_boot_console.run_command('crc32 %x $filesize' % addr)
+    output = ubman.run_command('crc32 %x $filesize' % addr)
     assert expected_crc in output
 
     return addr
 
-def do_test_efi_helloworld_net(u_boot_console, proto):
-    addr = fetch_file(u_boot_console, 'env__efi_loader_helloworld_file', proto)
+def do_test_efi_helloworld_net(ubman, proto):
+    addr = fetch_file(ubman, 'env__efi_loader_helloworld_file', proto)
 
-    output = u_boot_console.run_command('bootefi %x' % addr)
+    output = ubman.run_command('bootefi %x' % addr)
     expected_text = 'Hello, world'
     assert expected_text in output
     expected_text = '## Application failed'
@@ -172,65 +172,65 @@ def do_test_efi_helloworld_net(u_boot_console, proto):
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('bootefi_hello_compile')
 @pytest.mark.buildconfigspec('cmd_tftpboot')
-def test_efi_helloworld_net_tftp(u_boot_console):
+def test_efi_helloworld_net_tftp(ubman):
     """Run the helloworld.efi binary via TFTP.
 
     The helloworld.efi file is downloaded from the TFTP server and is executed
     using the fallback device tree at $fdtcontroladdr.
     """
 
-    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
+    do_test_efi_helloworld_net(ubman, PROTO_TFTP);
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('bootefi_hello_compile')
 @pytest.mark.buildconfigspec('cmd_wget')
-def test_efi_helloworld_net_http(u_boot_console):
+def test_efi_helloworld_net_http(ubman):
     """Run the helloworld.efi binary via HTTP.
 
     The helloworld.efi file is downloaded from the HTTP server and is executed
     using the fallback device tree at $fdtcontroladdr.
     """
-    if u_boot_console.config.env.get('env__efi_helloworld_net_http_test_skip', True):
+    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', True):
         pytest.skip('helloworld.efi HTTP test is not enabled!')
 
-    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
+    do_test_efi_helloworld_net(ubman, PROTO_HTTP);
 
 @pytest.mark.buildconfigspec('cmd_bootefi_hello')
-def test_efi_helloworld_builtin(u_boot_console):
+def test_efi_helloworld_builtin(ubman):
     """Run the builtin helloworld.efi binary.
 
     The helloworld.efi file is included in U-Boot, execute it using the
     special "bootefi hello" command.
     """
 
-    output = u_boot_console.run_command('bootefi hello')
+    output = ubman.run_command('bootefi hello')
     expected_text = 'Hello, world'
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('cmd_bootefi')
 @pytest.mark.buildconfigspec('cmd_tftpboot')
-def test_efi_grub_net(u_boot_console):
+def test_efi_grub_net(ubman):
     """Run the grub.efi binary via TFTP.
 
     The grub.efi file is downloaded from the TFTP server and gets
     executed.
     """
 
-    addr = fetch_file(u_boot_console, 'env__efi_loader_grub_file', PROTO_TFTP)
+    addr = fetch_file(ubman, 'env__efi_loader_grub_file', PROTO_TFTP)
 
-    u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=False)
+    ubman.run_command('bootefi %x' % addr, wait_for_prompt=False)
 
     # Verify that we have an SMBIOS table
-    check_smbios = u_boot_console.config.env.get('env__efi_loader_check_smbios', False)
+    check_smbios = ubman.config.env.get('env__efi_loader_check_smbios', False)
     if check_smbios:
-        u_boot_console.wait_for('grub>')
-        u_boot_console.run_command('lsefisystab', wait_for_prompt=False, wait_for_echo=False)
-        u_boot_console.wait_for('SMBIOS')
+        ubman.wait_for('grub>')
+        ubman.run_command('lsefisystab', wait_for_prompt=False, wait_for_echo=False)
+        ubman.wait_for('SMBIOS')
 
     # Then exit cleanly
-    u_boot_console.wait_for('grub>')
-    u_boot_console.run_command('exit', wait_for_prompt=False, wait_for_echo=False)
-    u_boot_console.wait_for(u_boot_console.prompt)
+    ubman.wait_for('grub>')
+    ubman.run_command('exit', wait_for_prompt=False, wait_for_echo=False)
+    ubman.wait_for(ubman.prompt)
     # And give us our U-Boot prompt back
-    u_boot_console.run_command('')
+    ubman.run_command('')
diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/py/tests/test_efi_secboot/test_authvar.py
index d5aeb650480..7b45f8fb814 100644
--- a/test/py/tests/test_efi_secboot/test_authvar.py
+++ b/test/py/tests/test_efi_secboot/test_authvar.py
@@ -17,119 +17,119 @@ import pytest
 @pytest.mark.buildconfigspec('cmd_nvedit_efi')
 @pytest.mark.slow
 class TestEfiAuthVar(object):
-    def test_efi_var_auth1(self, u_boot_console, efi_boot_env):
+    def test_efi_var_auth1(self, ubman, efi_boot_env):
         """
         Test Case 1 - Install signature database
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 1a'):
+        with ubman.log.section('Test Case 1a'):
             # Test Case 1a, Initial secure state
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'printenv -e SecureBoot'])
             assert '00000000: 00' in ''.join(output)
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'printenv -e SetupMode')
             assert '00000000: 01' in output
 
-        with u_boot_console.log.section('Test Case 1b'):
+        with ubman.log.section('Test Case 1b'):
             # Test Case 1b, PK without AUTHENTICATED_WRITE_ACCESS
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 1c'):
+        with ubman.log.section('Test Case 1c'):
             # Test Case 1c, install PK
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
                 'printenv -e -n PK'])
             assert 'PK:' in ''.join(output)
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'printenv -e SecureBoot')
             assert '00000000: 01' in output
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'printenv -e SetupMode')
             assert '00000000: 00' in output
 
-        with u_boot_console.log.section('Test Case 1d'):
+        with ubman.log.section('Test Case 1d'):
             # Test Case 1d, db/dbx without KEK
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 1e'):
+        with ubman.log.section('Test Case 1e'):
             # Test Case 1e, install KEK
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 KEK.auth',
                 'setenv -e -nv -bs -rt -i 4000000:$filesize KEK'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 KEK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
                 'printenv -e -n KEK'])
             assert 'KEK:' in ''.join(output)
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'printenv -e SecureBoot')
             assert '00000000: 01' in output
 
-        with u_boot_console.log.section('Test Case 1f'):
+        with ubman.log.section('Test Case 1f'):
             # Test Case 1f, install db
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert 'db:' in ''.join(output)
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'printenv -e SecureBoot')
             assert '00000000: 01' in output
 
-        with u_boot_console.log.section('Test Case 1g'):
+        with ubman.log.section('Test Case 1g'):
             # Test Case 1g, install dbx
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 dbx.auth',
                 'setenv -e -nv -bs -rt -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 dbx.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
                 'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert 'dbx:' in ''.join(output)
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'printenv -e SecureBoot')
             assert '00000000: 01' in output
 
-    def test_efi_var_auth2(self, u_boot_console, efi_boot_env):
+    def test_efi_var_auth2(self, ubman, efi_boot_env):
         """
         Test Case 2 - Update database by overwriting
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 2a'):
+        with ubman.log.section('Test Case 2a'):
             # Test Case 2a, update without AUTHENTICATED_WRITE_ACCESS
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
@@ -141,36 +141,36 @@ class TestEfiAuthVar(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert 'db:' in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db1.auth',
                 'setenv -e -nv -bs -rt -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 2b'):
+        with ubman.log.section('Test Case 2b'):
             # Test Case 2b, update without correct signature
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.esl',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 2c'):
+        with ubman.log.section('Test Case 2c'):
             # Test Case 2c, update with correct signature
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db1.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert 'db:' in ''.join(output)
 
-    def test_efi_var_auth3(self, u_boot_console, efi_boot_env):
+    def test_efi_var_auth3(self, ubman, efi_boot_env):
         """
         Test Case 3 - Append database
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 3a'):
+        with ubman.log.section('Test Case 3a'):
             # Test Case 3a, update without AUTHENTICATED_WRITE_ACCESS
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
@@ -182,36 +182,36 @@ class TestEfiAuthVar(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert 'db:' in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -a -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 3b'):
+        with ubman.log.section('Test Case 3b'):
             # Test Case 3b, update without correct signature
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.esl',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 3c'):
+        with ubman.log.section('Test Case 3c'):
             # Test Case 3c, update with correct signature
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db',
                 'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert 'db:' in ''.join(output)
 
-    def test_efi_var_auth4(self, u_boot_console, efi_boot_env):
+    def test_efi_var_auth4(self, ubman, efi_boot_env):
         """
         Test Case 4 - Delete database without authentication
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 4a'):
+        with ubman.log.section('Test Case 4a'):
             # Test Case 4a, update without AUTHENTICATED_WRITE_ACCESS
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
@@ -223,29 +223,29 @@ class TestEfiAuthVar(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert 'db:' in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'setenv -e -nv -bs -rt db',
                 'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f db'])
             assert 'Failed to set EFI variable' in ''.join(output)
             assert 'db:' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 4b'):
+        with ubman.log.section('Test Case 4b'):
             # Test Case 4b, update without correct signature/data
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'setenv -e -nv -bs -rt -at db',
                 'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f db'])
             assert 'Failed to set EFI variable' in ''.join(output)
             assert 'db:' in ''.join(output)
 
-    def test_efi_var_auth5(self, u_boot_console, efi_boot_env):
+    def test_efi_var_auth5(self, ubman, efi_boot_env):
         """
         Test Case 5 - Uninstall(delete) PK
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 5a'):
+        with ubman.log.section('Test Case 5a'):
             # Test Case 5a, Uninstall PK without correct signature
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
@@ -257,25 +257,25 @@ class TestEfiAuthVar(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert 'PK:' in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 PK_null.esl',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
                 'printenv -e -n PK'])
             assert 'Failed to set EFI variable' in ''.join(output)
             assert 'PK:' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 5b'):
+        with ubman.log.section('Test Case 5b'):
             # Test Case 5b, Uninstall PK with correct signature
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 PK_null.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
                 'printenv -e -n PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             assert '\"PK\" not defined' in ''.join(output)
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'printenv -e SecureBoot')
             assert '00000000: 00' in output
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'printenv -e SetupMode')
             assert '00000000: 01' in output
diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
index f604138a356..e8aaef7090c 100644
--- a/test/py/tests/test_efi_secboot/test_signed.py
+++ b/test/py/tests/test_efi_secboot/test_signed.py
@@ -18,83 +18,83 @@ import pytest
 @pytest.mark.buildconfigspec('cmd_nvedit_efi')
 @pytest.mark.slow
 class TestEfiSignedImage(object):
-    def test_efi_signed_image_auth1(self, u_boot_console, efi_boot_env):
+    def test_efi_signed_image_auth1(self, ubman, efi_boot_env):
         """
         Test Case 1 - Secure boot is not in force
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 1a'):
+        with ubman.log.section('Test Case 1a'):
             # Test Case 1a, run signed image if no PK
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.efi.signed -s ""',
                 'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 1b'):
+        with ubman.log.section('Test Case 1b'):
             # Test Case 1b, run unsigned image if no PK
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi -s ""',
                 'efidebug boot order 2',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-    def test_efi_signed_image_auth2(self, u_boot_console, efi_boot_env):
+    def test_efi_signed_image_auth2(self, ubman, efi_boot_env):
         """
         Test Case 2 - Secure boot is in force,
                       authenticated by db (TEST_db certificate in db)
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 2a'):
+        with ubman.log.section('Test Case 2a'):
             # Test Case 2a, db is not yet installed
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 KEK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.efi.signed -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert('\'HELLO1\' failed' in ''.join(output))
             assert('efi_bootmgr_load() returned: 26' in ''.join(output))
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi -s ""',
                 'efidebug boot order 2',
                 'efidebug test bootmgr'])
             assert '\'HELLO2\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 2b'):
+        with ubman.log.section('Test Case 2b'):
             # Test Case 2b, authenticated by db
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 2',
                 'efidebug test bootmgr'])
             assert '\'HELLO2\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-    def test_efi_signed_image_auth3(self, u_boot_console, efi_boot_env):
+    def test_efi_signed_image_auth3(self, ubman, efi_boot_env):
         """
         Test Case 3 - rejected by dbx (TEST_db certificate in dbx)
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 3a'):
+        with ubman.log.section('Test Case 3a'):
             # Test Case 3a, rejected by dbx
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
@@ -103,34 +103,34 @@ class TestEfiSignedImage(object):
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 3b'):
+        with ubman.log.section('Test Case 3b'):
             # Test Case 3b, rejected by dbx even if db allows
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-    def test_efi_signed_image_auth4(self, u_boot_console, efi_boot_env):
+    def test_efi_signed_image_auth4(self, ubman, efi_boot_env):
         """
         Test Case 4 - revoked by dbx (digest of TEST_db certificate in dbx)
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 4'):
+        with ubman.log.section('Test Case 4'):
             # Test Case 4, rejected by dbx
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 dbx_hash.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
@@ -141,25 +141,25 @@ class TestEfiSignedImage(object):
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-    def test_efi_signed_image_auth5(self, u_boot_console, efi_boot_env):
+    def test_efi_signed_image_auth5(self, ubman, efi_boot_env):
         """
         Test Case 5 - multiple signatures
                         one signed with TEST_db, and
                         one signed with TEST_db1
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 5a'):
+        with ubman.log.section('Test Case 5a'):
             # Test Case 5a, authenticated even if only one of signatures
             # is verified
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
@@ -168,54 +168,54 @@ class TestEfiSignedImage(object):
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 5b'):
+        with ubman.log.section('Test Case 5b'):
             # Test Case 5b, authenticated if both signatures are verified
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 5c'):
+        with ubman.log.section('Test Case 5c'):
             # Test Case 5c, rejected if one of signatures (digest of
             # certificate) is revoked
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 dbx_hash.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 5d'):
+        with ubman.log.section('Test Case 5d'):
             # Test Case 5d, rejected if both of signatures are revoked
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 dbx_hash2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         # Try rejection in reverse order.
-        u_boot_console.restart_uboot()
-        with u_boot_console.log.section('Test Case 5e'):
+        ubman.restart_uboot()
+        with ubman.log.section('Test Case 5e'):
             # Test Case 5e, authenticated even if only one of signatures
             # is verified. Same as before but reject dbx_hash1.auth only
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
@@ -228,22 +228,22 @@ class TestEfiSignedImage(object):
                 'fatload host 0:1 4000000 dbx_hash1.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-    def test_efi_signed_image_auth6(self, u_boot_console, efi_boot_env):
+    def test_efi_signed_image_auth6(self, ubman, efi_boot_env):
         """
         Test Case 6 - using digest of signed image in database
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 6a'):
+        with ubman.log.section('Test Case 6a'):
             # Test Case 6a, verified by image's digest in db
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db_hello_signed.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
@@ -252,47 +252,47 @@ class TestEfiSignedImage(object):
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
                 'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 6b'):
+        with ubman.log.section('Test Case 6b'):
             # Test Case 6b, rejected by TEST_db certificate in dbx
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 dbx_db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 6c'):
+        with ubman.log.section('Test Case 6c'):
             # Test Case 6c, rejected by image's digest in dbx
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 dbx_hello_signed.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-    def test_efi_signed_image_auth7(self, u_boot_console, efi_boot_env):
+    def test_efi_signed_image_auth7(self, ubman, efi_boot_env):
         """
         Test Case 7 - Reject images based on the sha384/512 of their x509 cert
         """
         # sha384 of an x509 cert in dbx
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 7a'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 7a'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
@@ -305,7 +305,7 @@ class TestEfiSignedImage(object):
                 'fatload host 0:1 4000000 dbx_hash384.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
@@ -313,9 +313,9 @@ class TestEfiSignedImage(object):
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         # sha512 of an x509 cert in dbx
-        u_boot_console.restart_uboot()
-        with u_boot_console.log.section('Test Case 7b'):
-            output = u_boot_console.run_command_list([
+        ubman.restart_uboot()
+        with ubman.log.section('Test Case 7b'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
@@ -328,34 +328,34 @@ class TestEfiSignedImage(object):
                 'fatload host 0:1 4000000 dbx_hash512.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-    def test_efi_signed_image_auth8(self, u_boot_console, efi_boot_env):
+    def test_efi_signed_image_auth8(self, ubman, efi_boot_env):
         """
         Test Case 8 - Secure boot is in force,
                       Same as Test Case 2 but the image binary to be loaded
                       was willfully modified (forged)
                       Must be rejected.
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 8a'):
+        with ubman.log.section('Test Case 8a'):
             # Test Case 8a, Secure boot is not yet forced
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld_forged.efi.signed -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert('hELLO, world!' in ''.join(output))
 
-        with u_boot_console.log.section('Test Case 8b'):
+        with ubman.log.section('Test Case 8b'):
             # Test Case 8b, Install signature database and verify the image
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 KEK.auth',
@@ -363,7 +363,7 @@ class TestEfiSignedImage(object):
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert(not 'hELLO, world!' in ''.join(output))
diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test/py/tests/test_efi_secboot/test_signed_intca.py
index cf906205bc2..58f7be03b8b 100644
--- a/test/py/tests/test_efi_secboot/test_signed_intca.py
+++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
@@ -20,15 +20,15 @@ import pytest
 @pytest.mark.buildconfigspec('cmd_nvedit_efi')
 @pytest.mark.slow
 class TestEfiSignedImageIntca(object):
-    def test_efi_signed_image_intca1(self, u_boot_console, efi_boot_env_intca):
+    def test_efi_signed_image_intca1(self, ubman, efi_boot_env_intca):
         """
         Test Case 1 - authenticated by root CA in db
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env_intca
-        with u_boot_console.log.section('Test Case 1a'):
+        with ubman.log.section('Test Case 1a'):
             # Test Case 1a, with no Int CA and not authenticated by root CA
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db_c.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
@@ -38,30 +38,30 @@ class TestEfiSignedImageIntca(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO_a host 0:1 /helloworld.efi.signed_a -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_a\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 1b'):
+        with ubman.log.section('Test Case 1b'):
             # Test Case 1b, signed and authenticated by root CA
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 2 HELLO_ab host 0:1 /helloworld.efi.signed_ab -s ""',
                 'efidebug boot order 2',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-    def test_efi_signed_image_intca2(self, u_boot_console, efi_boot_env_intca):
+    def test_efi_signed_image_intca2(self, ubman, efi_boot_env_intca):
         """
         Test Case 2 - authenticated by root CA in db
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env_intca
-        with u_boot_console.log.section('Test Case 2a'):
+        with ubman.log.section('Test Case 2a'):
             # Test Case 2a, unsigned and not authenticated by root CA
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 KEK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
@@ -69,16 +69,16 @@ class TestEfiSignedImageIntca(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO_abc host 0:1 /helloworld.efi.signed_abc -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 2b'):
+        with ubman.log.section('Test Case 2b'):
             # Test Case 2b, signed and authenticated by root CA
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db_b.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'efidebug boot order 1',
@@ -86,24 +86,24 @@ class TestEfiSignedImageIntca(object):
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 2c'):
+        with ubman.log.section('Test Case 2c'):
             # Test Case 2c, signed and authenticated by root CA
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db_c.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-    def test_efi_signed_image_intca3(self, u_boot_console, efi_boot_env_intca):
+    def test_efi_signed_image_intca3(self, ubman, efi_boot_env_intca):
         """
         Test Case 3 - revoked by dbx
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env_intca
-        with u_boot_console.log.section('Test Case 3a'):
+        with ubman.log.section('Test Case 3a'):
             # Test Case 3a, revoked by int CA in dbx
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 dbx_b.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
@@ -115,7 +115,7 @@ class TestEfiSignedImageIntca(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO_abc host 0:1 /helloworld.efi.signed_abc -s ""',
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
@@ -124,9 +124,9 @@ class TestEfiSignedImageIntca(object):
             # assert '\'HELLO_abc\' failed' in ''.join(output)
             # assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 3b'):
+        with ubman.log.section('Test Case 3b'):
             # Test Case 3b, revoked by root CA in dbx
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 dbx_c.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
                 'efidebug boot order 1',
diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/tests/test_efi_secboot/test_unsigned.py
index b4320ae4054..bd6e1b2dadd 100644
--- a/test/py/tests/test_efi_secboot/test_unsigned.py
+++ b/test/py/tests/test_efi_secboot/test_unsigned.py
@@ -18,15 +18,15 @@ import pytest
 @pytest.mark.buildconfigspec('cmd_nvedit_efi')
 @pytest.mark.slow
 class TestEfiUnsignedImage(object):
-    def test_efi_unsigned_image_auth1(self, u_boot_console, efi_boot_env):
+    def test_efi_unsigned_image_auth1(self, ubman, efi_boot_env):
         """
         Test Case 1 - rejected when not digest in db or dbx
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 1'):
+        with ubman.log.section('Test Case 1'):
             # Test Case 1
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 KEK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
@@ -34,26 +34,26 @@ class TestEfiUnsignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
                 'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
 
-    def test_efi_unsigned_image_auth2(self, u_boot_console, efi_boot_env):
+    def test_efi_unsigned_image_auth2(self, ubman, efi_boot_env):
         """
         Test Case 2 - authenticated by digest in db
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 2'):
+        with ubman.log.section('Test Case 2'):
             # Test Case 2
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db_hello.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
@@ -63,21 +63,21 @@ class TestEfiUnsignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
                 'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
-    def test_efi_unsigned_image_auth3(self, u_boot_console, efi_boot_env):
+    def test_efi_unsigned_image_auth3(self, ubman, efi_boot_env):
         """
         Test Case 3 - rejected by digest in dbx
         """
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
         disk_img = efi_boot_env
-        with u_boot_console.log.section('Test Case 3a'):
+        with ubman.log.section('Test Case 3a'):
             # Test Case 3a, rejected by dbx
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'fatload host 0:1 4000000 db_hello.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
@@ -87,30 +87,30 @@ class TestEfiUnsignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
                 'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
 
-        with u_boot_console.log.section('Test Case 3b'):
+        with ubman.log.section('Test Case 3b'):
             # Test Case 3b, rejected by dbx even if db allows
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'fatload host 0:1 4000000 db_hello.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
                 'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
index 310d8ed294a..12cbe5caa9b 100644
--- a/test/py/tests/test_efi_selftest.py
+++ b/test/py/tests/test_efi_selftest.py
@@ -7,191 +7,191 @@
 import pytest
 
 @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
-def test_efi_selftest_base(u_boot_console):
+def test_efi_selftest_base(ubman):
     """Run UEFI unit tests
 
-    u_boot_console -- U-Boot console
+    ubman -- U-Boot console
 
     This function executes all selftests that are not marked as on request.
     """
-    u_boot_console.run_command(cmd='setenv efi_selftest')
-    u_boot_console.run_command(cmd='bootefi selftest', wait_for_prompt=False)
-    if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
+    ubman.run_command(cmd='setenv efi_selftest')
+    ubman.run_command(cmd='bootefi selftest', wait_for_prompt=False)
+    if ubman.p.expect(['Summary: 0 failures', 'Press any key']):
         raise Exception('Failures occurred during the EFI selftest')
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
 @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
 @pytest.mark.buildconfigspec('hush_parser')
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.notbuildconfigspec('generate_acpi_table')
-def test_efi_selftest_device_tree(u_boot_console):
+def test_efi_selftest_device_tree(ubman):
     """Test the device tree support in the UEFI sub-system
 
-    u_boot_console -- U-Boot console
+    ubman -- U-Boot console
 
     This test executes the UEFI unit test by calling 'bootefi selftest'.
     """
-    u_boot_console.run_command(cmd='setenv efi_selftest list')
-    output = u_boot_console.run_command('bootefi selftest')
+    ubman.run_command(cmd='setenv efi_selftest list')
+    output = ubman.run_command('bootefi selftest')
     assert '\'device tree\'' in output
-    u_boot_console.run_command(cmd='setenv efi_selftest device tree')
+    ubman.run_command(cmd='setenv efi_selftest device tree')
     # Set serial# if it is not already set.
-    u_boot_console.run_command(cmd='setenv efi_test "${serial#}x"')
-    u_boot_console.run_command(cmd='test "${efi_test}" = x && setenv serial# 0')
-    u_boot_console.run_command(cmd='bootefi selftest ${fdtcontroladdr}', wait_for_prompt=False)
-    if u_boot_console.p.expect(['serial-number:', 'U-Boot']):
+    ubman.run_command(cmd='setenv efi_test "${serial#}x"')
+    ubman.run_command(cmd='test "${efi_test}" = x && setenv serial# 0')
+    ubman.run_command(cmd='bootefi selftest ${fdtcontroladdr}', wait_for_prompt=False)
+    if ubman.p.expect(['serial-number:', 'U-Boot']):
         raise Exception('serial-number missing in device tree')
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
 @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
-def test_efi_selftest_watchdog_reboot(u_boot_console):
+def test_efi_selftest_watchdog_reboot(ubman):
     """Test the watchdog timer
 
-    u_boot_console -- U-Boot console
+    ubman -- U-Boot console
 
     This function executes the 'watchdog reboot' unit test.
     """
-    u_boot_console.run_command(cmd='setenv efi_selftest list')
-    output = u_boot_console.run_command('bootefi selftest')
+    ubman.run_command(cmd='setenv efi_selftest list')
+    output = ubman.run_command('bootefi selftest')
     assert '\'watchdog reboot\'' in output
-    u_boot_console.run_command(cmd='setenv efi_selftest watchdog reboot')
-    u_boot_console.run_command(cmd='bootefi selftest', wait_for_prompt=False)
-    if u_boot_console.p.expect(['resetting', 'U-Boot']):
+    ubman.run_command(cmd='setenv efi_selftest watchdog reboot')
+    ubman.run_command(cmd='bootefi selftest', wait_for_prompt=False)
+    if ubman.p.expect(['resetting', 'U-Boot']):
         raise Exception('Reset failed in \'watchdog reboot\' test')
-    u_boot_console.run_command(cmd='', send_nl=False, wait_for_reboot=True)
+    ubman.run_command(cmd='', send_nl=False, wait_for_reboot=True)
 
 @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
-def test_efi_selftest_text_input(u_boot_console):
+def test_efi_selftest_text_input(ubman):
     """Test the EFI_SIMPLE_TEXT_INPUT_PROTOCOL
 
-    u_boot_console -- U-Boot console
+    ubman -- U-Boot console
 
     This function calls the text input EFI selftest.
     """
-    u_boot_console.run_command(cmd='setenv efi_selftest text input')
-    u_boot_console.run_command(cmd='bootefi selftest', wait_for_prompt=False)
-    if u_boot_console.p.expect([r'To terminate type \'x\'']):
+    ubman.run_command(cmd='setenv efi_selftest text input')
+    ubman.run_command(cmd='bootefi selftest', wait_for_prompt=False)
+    if ubman.p.expect([r'To terminate type \'x\'']):
         raise Exception('No prompt for \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # EOT
-    u_boot_console.run_command(cmd=chr(4), wait_for_echo=False,
+    ubman.run_command(cmd=chr(4), wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 4 \(unknown\), scan code 0 \(Null\)']):
+    if ubman.p.expect([r'Unicode char 4 \(unknown\), scan code 0 \(Null\)']):
         raise Exception('EOT failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # BS
-    u_boot_console.run_command(cmd=chr(8), wait_for_echo=False,
+    ubman.run_command(cmd=chr(8), wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 8 \(BS\), scan code 0 \(Null\)']):
+    if ubman.p.expect([r'Unicode char 8 \(BS\), scan code 0 \(Null\)']):
         raise Exception('BS failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # TAB
-    u_boot_console.run_command(cmd=chr(9), wait_for_echo=False,
+    ubman.run_command(cmd=chr(9), wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 9 \(TAB\), scan code 0 \(Null\)']):
+    if ubman.p.expect([r'Unicode char 9 \(TAB\), scan code 0 \(Null\)']):
         raise Exception('BS failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # a
-    u_boot_console.run_command(cmd='a', wait_for_echo=False, send_nl=False,
+    ubman.run_command(cmd='a', wait_for_echo=False, send_nl=False,
                                wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 97 \(\'a\'\), scan code 0 \(Null\)']):
+    if ubman.p.expect([r'Unicode char 97 \(\'a\'\), scan code 0 \(Null\)']):
         raise Exception('\'a\' failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # UP escape sequence
-    u_boot_console.run_command(cmd=chr(27) + '[A', wait_for_echo=False,
+    ubman.run_command(cmd=chr(27) + '[A', wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 0 \(Null\), scan code 1 \(Up\)']):
+    if ubman.p.expect([r'Unicode char 0 \(Null\), scan code 1 \(Up\)']):
         raise Exception('UP failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # Euro sign
-    u_boot_console.run_command(cmd=b'\xe2\x82\xac'.decode(), wait_for_echo=False,
+    ubman.run_command(cmd=b'\xe2\x82\xac'.decode(), wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 8364 \(\'']):
+    if ubman.p.expect([r'Unicode char 8364 \(\'']):
         raise Exception('Euro sign failed in \'text input\' test')
-    u_boot_console.drain_console()
-    u_boot_console.run_command(cmd='x', wait_for_echo=False, send_nl=False,
+    ubman.drain_console()
+    ubman.run_command(cmd='x', wait_for_echo=False, send_nl=False,
                                wait_for_prompt=False)
-    if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
+    if ubman.p.expect(['Summary: 0 failures', 'Press any key']):
         raise Exception('Failures occurred during the EFI selftest')
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
 @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
-def test_efi_selftest_text_input_ex(u_boot_console):
+def test_efi_selftest_text_input_ex(ubman):
     """Test the EFI_SIMPLE_TEXT_INPUT_EX_PROTOCOL
 
-    u_boot_console -- U-Boot console
+    ubman -- U-Boot console
 
     This function calls the extended text input EFI selftest.
     """
-    u_boot_console.run_command(cmd='setenv efi_selftest extended text input')
-    u_boot_console.run_command(cmd='bootefi selftest', wait_for_prompt=False)
-    if u_boot_console.p.expect([r'To terminate type \'CTRL\+x\'']):
+    ubman.run_command(cmd='setenv efi_selftest extended text input')
+    ubman.run_command(cmd='bootefi selftest', wait_for_prompt=False)
+    if ubman.p.expect([r'To terminate type \'CTRL\+x\'']):
         raise Exception('No prompt for \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # EOT
-    u_boot_console.run_command(cmd=chr(4), wait_for_echo=False,
+    ubman.run_command(cmd=chr(4), wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 100 \(\'d\'\), scan code 0 \(CTRL\+Null\)']):
+    if ubman.p.expect([r'Unicode char 100 \(\'d\'\), scan code 0 \(CTRL\+Null\)']):
         raise Exception('EOT failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # BS
-    u_boot_console.run_command(cmd=chr(8), wait_for_echo=False,
+    ubman.run_command(cmd=chr(8), wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 8 \(BS\), scan code 0 \(\+Null\)']):
+    if ubman.p.expect([r'Unicode char 8 \(BS\), scan code 0 \(\+Null\)']):
         raise Exception('BS failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # TAB
-    u_boot_console.run_command(cmd=chr(9), wait_for_echo=False,
+    ubman.run_command(cmd=chr(9), wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 9 \(TAB\), scan code 0 \(\+Null\)']):
+    if ubman.p.expect([r'Unicode char 9 \(TAB\), scan code 0 \(\+Null\)']):
         raise Exception('TAB failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # a
-    u_boot_console.run_command(cmd='a', wait_for_echo=False, send_nl=False,
+    ubman.run_command(cmd='a', wait_for_echo=False, send_nl=False,
                                wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 97 \(\'a\'\), scan code 0 \(Null\)']):
+    if ubman.p.expect([r'Unicode char 97 \(\'a\'\), scan code 0 \(Null\)']):
         raise Exception('\'a\' failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # UP escape sequence
-    u_boot_console.run_command(cmd=chr(27) + '[A', wait_for_echo=False,
+    ubman.run_command(cmd=chr(27) + '[A', wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 0 \(Null\), scan code 1 \(\+Up\)']):
+    if ubman.p.expect([r'Unicode char 0 \(Null\), scan code 1 \(\+Up\)']):
         raise Exception('UP failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # Euro sign
-    u_boot_console.run_command(cmd=b'\xe2\x82\xac'.decode(), wait_for_echo=False,
+    ubman.run_command(cmd=b'\xe2\x82\xac'.decode(), wait_for_echo=False,
                                send_nl=False, wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 8364 \(\'']):
+    if ubman.p.expect([r'Unicode char 8364 \(\'']):
         raise Exception('Euro sign failed in \'text input\' test')
-    u_boot_console.drain_console()
+    ubman.drain_console()
     # SHIFT+ALT+FN 5
-    u_boot_console.run_command(cmd=b'\x1b\x5b\x31\x35\x3b\x34\x7e'.decode(),
+    ubman.run_command(cmd=b'\x1b\x5b\x31\x35\x3b\x34\x7e'.decode(),
                                wait_for_echo=False, send_nl=False,
                                wait_for_prompt=False)
-    if u_boot_console.p.expect([r'Unicode char 0 \(Null\), scan code 15 \(SHIFT\+ALT\+FN 5\)']):
+    if ubman.p.expect([r'Unicode char 0 \(Null\), scan code 15 \(SHIFT\+ALT\+FN 5\)']):
         raise Exception('SHIFT+ALT+FN 5 failed in \'text input\' test')
-    u_boot_console.drain_console()
-    u_boot_console.run_command(cmd=chr(24), wait_for_echo=False, send_nl=False,
+    ubman.drain_console()
+    ubman.run_command(cmd=chr(24), wait_for_echo=False, send_nl=False,
                                wait_for_prompt=False)
-    if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
+    if ubman.p.expect(['Summary: 0 failures', 'Press any key']):
         raise Exception('Failures occurred during the EFI selftest')
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
 @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
 @pytest.mark.buildconfigspec('efi_tcg2_protocol')
-def test_efi_selftest_tcg2(u_boot_console):
+def test_efi_selftest_tcg2(ubman):
     """Test the EFI_TCG2 PROTOCOL
 
-    u_boot_console -- U-Boot console
+    ubman -- U-Boot console
 
     This function executes the 'tcg2' unit test.
     """
-    u_boot_console.restart_uboot()
-    u_boot_console.run_command(cmd='setenv efi_selftest list')
-    output = u_boot_console.run_command('bootefi selftest')
+    ubman.restart_uboot()
+    ubman.run_command(cmd='setenv efi_selftest list')
+    output = ubman.run_command('bootefi selftest')
     assert '\'tcg2\'' in output
-    u_boot_console.run_command(cmd='setenv efi_selftest tcg2')
-    u_boot_console.run_command(cmd='bootefi selftest', wait_for_prompt=False)
-    if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
+    ubman.run_command(cmd='setenv efi_selftest tcg2')
+    ubman.run_command(cmd='bootefi selftest', wait_for_prompt=False)
+    if ubman.p.expect(['Summary: 0 failures', 'Press any key']):
         raise Exception('Failures occurred during the EFI selftest')
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
diff --git a/test/py/tests/test_eficonfig/test_eficonfig.py b/test/py/tests/test_eficonfig/test_eficonfig.py
index d98de5249df..3ca8e27c76b 100644
--- a/test/py/tests/test_eficonfig/test_eficonfig.py
+++ b/test/py/tests/test_eficonfig/test_eficonfig.py
@@ -8,47 +8,47 @@ import time
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_eficonfig')
 @pytest.mark.buildconfigspec('cmd_bootefi_bootmgr')
-def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
+def test_efi_eficonfig(ubman, efi_eficonfig_data):
 
     def send_user_input_and_wait(user_str, expect_str):
         time.sleep(0.1) # TODO: does not work correctly without sleep
-        u_boot_console.run_command(cmd=user_str, wait_for_prompt=False,
+        ubman.run_command(cmd=user_str, wait_for_prompt=False,
                                    wait_for_echo=True, send_nl=False)
-        u_boot_console.run_command(cmd='\x0d', wait_for_prompt=False,
+        ubman.run_command(cmd='\x0d', wait_for_prompt=False,
                                    wait_for_echo=False, send_nl=False)
         if expect_str is not None:
             for i in expect_str:
-                u_boot_console.p.expect([i])
+                ubman.p.expect([i])
 
     def press_up_down_enter_and_wait(up_count, down_count, enter, expect_str):
         # press UP key
         for i in range(up_count):
-            u_boot_console.run_command(cmd='\x1b\x5b\x41', wait_for_prompt=False,
+            ubman.run_command(cmd='\x1b\x5b\x41', wait_for_prompt=False,
                                        wait_for_echo=False, send_nl=False)
         # press DOWN key
         for i in range(down_count):
-            u_boot_console.run_command(cmd='\x1b\x5b\x42', wait_for_prompt=False,
+            ubman.run_command(cmd='\x1b\x5b\x42', wait_for_prompt=False,
                                        wait_for_echo=False, send_nl=False)
         # press ENTER if requested
         if enter:
-            u_boot_console.run_command(cmd='\x0d', wait_for_prompt=False,
+            ubman.run_command(cmd='\x0d', wait_for_prompt=False,
                                        wait_for_echo=False, send_nl=False)
         # wait expected output
         if expect_str is not None:
             for i in expect_str:
-                u_boot_console.p.expect([i])
+                ubman.p.expect([i])
 
     def press_escape_key(wait_prompt):
-        u_boot_console.run_command(cmd='\x1b', wait_for_prompt=wait_prompt, wait_for_echo=False, send_nl=False)
+        ubman.run_command(cmd='\x1b', wait_for_prompt=wait_prompt, wait_for_echo=False, send_nl=False)
 
     def press_enter_key(wait_prompt):
-        u_boot_console.run_command(cmd='\x0d', wait_for_prompt=wait_prompt,
+        ubman.run_command(cmd='\x0d', wait_for_prompt=wait_prompt,
                                    wait_for_echo=False, send_nl=False)
 
     def check_current_is_maintenance_menu():
         for i in ('UEFI Maintenance Menu', 'Add Boot Option', 'Edit Boot Option',
                   'Change Boot Order', 'Delete Boot Option', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
 
     """ Unit test for "eficonfig" command
     The menu-driven interface is used to set up UEFI load options.
@@ -56,7 +56,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
     The crc32 of the loaded initrd.img is checked
 
     Args:
-        u_boot_console -- U-Boot console
+        ubman -- U-Boot console
         efi__data -- Path to the disk image used for testing.
                      Test disk image has following files.
                          initrd-1.img
@@ -69,21 +69,21 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
     return
 
     # Restart the system to clean the previous state
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
-    with u_boot_console.temporary_timeout(500):
+    with ubman.temporary_timeout(500):
         #
         # Test Case 1: Check the menu is displayed
         #
-        u_boot_console.run_command('eficonfig', wait_for_prompt=False)
+        ubman.run_command('eficonfig', wait_for_prompt=False)
         for i in ('UEFI Maintenance Menu', 'Add Boot Option', 'Edit Boot Option',
                   'Change Boot Order', 'Delete Boot Option', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         # Select "Add Boot Option"
         press_enter_key(False)
         for i in ('Add Boot Option', 'Description:', 'File', 'Initrd File', 'Optional Data',
                   'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         press_escape_key(False)
         check_current_is_maintenance_menu()
         # return to U-Boot console
@@ -94,16 +94,16 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         #
 
         # bind the test disk image for succeeding tests
-        u_boot_console.run_command(cmd = f'host bind 0 {efi_eficonfig_data}')
+        ubman.run_command(cmd = f'host bind 0 {efi_eficonfig_data}')
 
-        u_boot_console.run_command('eficonfig', wait_for_prompt=False)
+        ubman.run_command('eficonfig', wait_for_prompt=False)
 
         # Change the Boot Order
         press_up_down_enter_and_wait(0, 2, True, 'Quit')
         for i in ('host 0:1', 'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         # disable auto generated boot option for succeeding test
-        u_boot_console.run_command(cmd=' ', wait_for_prompt=False,
+        ubman.run_command(cmd=' ', wait_for_prompt=False,
                                        wait_for_echo=False, send_nl=False)
         # Save the BootOrder
         press_up_down_enter_and_wait(0, 1, True, None)
@@ -143,7 +143,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         send_user_input_and_wait('nocolor', None)
         for i in ('Description: test 1', 'File: host 0:1/initrddump.efi',
                   'Initrd File: host 0:1/initrd-1.img', 'Optional Data: nocolor', 'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
 
         # Save the Boot Option
         press_up_down_enter_and_wait(0, 4, True, None)
@@ -152,15 +152,15 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         # Check the newly added Boot Option is handled correctly
         # Return to U-Boot console
         press_escape_key(True)
-        u_boot_console.run_command(cmd = 'bootefi bootmgr')
-        response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
+        ubman.run_command(cmd = 'bootefi bootmgr')
+        response = ubman.run_command(cmd = 'load', wait_for_echo=False)
         assert 'crc32: 0x181464af' in response
-        u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
+        ubman.run_command(cmd = 'exit', wait_for_echo=False)
 
         #
         # Test Case 4: Add second Boot Option and load it
         #
-        u_boot_console.run_command('eficonfig', wait_for_prompt=False)
+        ubman.run_command('eficonfig', wait_for_prompt=False)
 
         # Select 'Add Boot Option'
         press_up_down_enter_and_wait(0, 0, True, 'Quit')
@@ -192,7 +192,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         send_user_input_and_wait('nocolor', None)
         for i in ('Description: test 2', 'File: host 0:1/initrddump.efi',
                   'Initrd File: host 0:1/initrd-2.img', 'Optional Data: nocolor', 'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
 
         # Save the Boot Option
         press_up_down_enter_and_wait(0, 4, True, 'Quit')
@@ -201,10 +201,10 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         press_up_down_enter_and_wait(0, 2, True, 'Quit')
         press_up_down_enter_and_wait(0, 1, False, 'Quit')
         # move 'test 1' to the second entry
-        u_boot_console.run_command(cmd='+', wait_for_prompt=False,
+        ubman.run_command(cmd='+', wait_for_prompt=False,
                                        wait_for_echo=False, send_nl=False)
         for i in ('test 2', 'test 1', 'host 0:1', 'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         # Save the BootOrder
         press_up_down_enter_and_wait(0, 3, True, None)
         check_current_is_maintenance_menu()
@@ -212,52 +212,52 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         # Check the newly added Boot Option is handled correctly
         # Return to U-Boot console
         press_escape_key(True)
-        u_boot_console.run_command(cmd = 'bootefi bootmgr')
-        response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
+        ubman.run_command(cmd = 'bootefi bootmgr')
+        response = ubman.run_command(cmd = 'load', wait_for_echo=False)
         assert 'crc32: 0x811d3515' in response
-        u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
+        ubman.run_command(cmd = 'exit', wait_for_echo=False)
 
         #
         # Test Case 5: Change BootOrder and load it
         #
-        u_boot_console.run_command('eficonfig', wait_for_prompt=False)
+        ubman.run_command('eficonfig', wait_for_prompt=False)
 
         # Change the Boot Order
         press_up_down_enter_and_wait(0, 2, True, None)
         # Check the current BootOrder
         for i in ('test 2', 'test 1', 'host 0:1', 'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         # move 'test 2' to the second entry
-        u_boot_console.run_command(cmd='-', wait_for_prompt=False,
+        ubman.run_command(cmd='-', wait_for_prompt=False,
                                        wait_for_echo=False, send_nl=False)
         for i in ('test 1', 'test 2', 'host 0:1', 'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         # Save the BootOrder
         press_up_down_enter_and_wait(0, 2, True, None)
         check_current_is_maintenance_menu()
 
         # Return to U-Boot console
         press_escape_key(True)
-        u_boot_console.run_command(cmd = 'bootefi bootmgr')
-        response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
+        ubman.run_command(cmd = 'bootefi bootmgr')
+        response = ubman.run_command(cmd = 'load', wait_for_echo=False)
         assert 'crc32: 0x181464af' in response
-        u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
+        ubman.run_command(cmd = 'exit', wait_for_echo=False)
 
         #
         # Test Case 6: Delete Boot Option(label:test 2)
         #
-        u_boot_console.run_command('eficonfig', wait_for_prompt=False)
+        ubman.run_command('eficonfig', wait_for_prompt=False)
 
         # Select 'Delete Boot Option'
         press_up_down_enter_and_wait(0, 3, True, None)
         # Check the current BootOrder
         for i in ('test 1', 'test 2', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
 
         # Delete 'test 2'
         press_up_down_enter_and_wait(0, 1, True, None)
         for i in ('test 1', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         press_escape_key(False)
         check_current_is_maintenance_menu()
         # Return to U-Boot console
@@ -266,16 +266,16 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         #
         # Test Case 7: Edit Boot Option
         #
-        u_boot_console.run_command('eficonfig', wait_for_prompt=False)
+        ubman.run_command('eficonfig', wait_for_prompt=False)
         # Select 'Edit Boot Option'
         press_up_down_enter_and_wait(0, 1, True, None)
         # Check the current BootOrder
         for i in ('test 1', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
         press_up_down_enter_and_wait(0, 0, True, None)
         for i in ('Description: test 1', 'File: host 0:1/initrddump.efi',
                   'Initrd File: host 0:1/initrd-1.img', 'Optional Data: nocolor', 'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
 
         # Press the enter key to select 'Description:' entry, then enter Description
         press_up_down_enter_and_wait(0, 0, True, 'Enter description:')
@@ -304,7 +304,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         send_user_input_and_wait('', None)
         for i in ('Description: test 3', 'File: host 0:1/initrddump.efi',
                   'Initrd File: host 0:1/initrd-2.img', 'Optional Data:', 'Save', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
 
         # Save the Boot Option
         press_up_down_enter_and_wait(0, 4, True, 'Quit')
@@ -314,21 +314,21 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         # Check the updated Boot Option is handled correctly
         # Return to U-Boot console
         press_escape_key(True)
-        u_boot_console.run_command(cmd = 'bootefi bootmgr')
-        response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
+        ubman.run_command(cmd = 'bootefi bootmgr')
+        response = ubman.run_command(cmd = 'load', wait_for_echo=False)
         assert 'crc32: 0x811d3515' in response
-        u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
+        ubman.run_command(cmd = 'exit', wait_for_echo=False)
 
         #
         # Test Case 8: Delete Boot Option(label:test 3)
         #
-        u_boot_console.run_command('eficonfig', wait_for_prompt=False)
+        ubman.run_command('eficonfig', wait_for_prompt=False)
 
         # Select 'Delete Boot Option'
         press_up_down_enter_and_wait(0, 3, True, None)
         # Check the current BootOrder
         for i in ('test 3', 'Quit'):
-            u_boot_console.p.expect([i])
+            ubman.p.expect([i])
 
         # Delete 'test 3'
         press_up_down_enter_and_wait(0, 0, True, 'Quit')
@@ -338,12 +338,12 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         press_escape_key(True)
 
         # remove the host device
-        u_boot_console.run_command(cmd = f'host bind -r 0')
+        ubman.run_command(cmd = f'host bind -r 0')
 
         #
         # Test Case 9: No block device found
         #
-        u_boot_console.run_command('eficonfig', wait_for_prompt=False)
+        ubman.run_command('eficonfig', wait_for_prompt=False)
 
         # Select 'Add Boot Option'
         press_up_down_enter_and_wait(0, 0, True, 'Quit')
diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index 4471db7d9cb..6f75e107bbe 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -23,17 +23,17 @@ class StateTestEnv(object):
     names.
     """
 
-    def __init__(self, u_boot_console):
+    def __init__(self, ubman):
         """Initialize a new StateTestEnv object.
 
         Args:
-            u_boot_console: A U-Boot console.
+            ubman: A U-Boot console.
 
         Returns:
             Nothing.
         """
 
-        self.u_boot_console = u_boot_console
+        self.ubman = ubman
         self.get_env()
         self.set_var = self.get_non_existent_var()
 
@@ -47,12 +47,12 @@ class StateTestEnv(object):
             Nothing.
         """
 
-        if self.u_boot_console.config.buildconfig.get(
+        if self.ubman.config.buildconfig.get(
                 'config_version_variable', 'n') == 'y':
-            with self.u_boot_console.disable_check('main_signon'):
-                response = self.u_boot_console.run_command('printenv')
+            with self.ubman.disable_check('main_signon'):
+                response = self.ubman.run_command('printenv')
         else:
-            response = self.u_boot_console.run_command('printenv')
+            response = self.ubman.run_command('printenv')
         self.env = {}
         for l in response.splitlines():
             if not '=' in l:
@@ -92,12 +92,12 @@ class StateTestEnv(object):
 
 ste = None
 @pytest.fixture(scope='function')
-def state_test_env(u_boot_console):
+def state_test_env(ubman):
     """pytest fixture to provide a StateTestEnv object to tests."""
 
     global ste
     if not ste:
-        ste = StateTestEnv(u_boot_console)
+        ste = StateTestEnv(ubman)
     return ste
 
 def unset_var(state_test_env, var):
@@ -114,7 +114,7 @@ def unset_var(state_test_env, var):
         Nothing.
     """
 
-    state_test_env.u_boot_console.run_command('setenv %s' % var)
+    state_test_env.ubman.run_command('setenv %s' % var)
     if var in state_test_env.env:
         del state_test_env.env[var]
 
@@ -133,7 +133,7 @@ def set_var(state_test_env, var, value):
         Nothing.
     """
 
-    bc = state_test_env.u_boot_console.config.buildconfig
+    bc = state_test_env.ubman.config.buildconfig
     if bc.get('config_hush_parser', None):
         quote = '"'
     else:
@@ -141,7 +141,7 @@ def set_var(state_test_env, var, value):
         if ' ' in value:
             pytest.skip('Space in variable value on non-Hush shell')
 
-    state_test_env.u_boot_console.run_command(
+    state_test_env.ubman.run_command(
         'setenv %s %s%s%s' % (var, quote, value, quote))
     state_test_env.env[var] = value
 
@@ -155,7 +155,7 @@ def validate_empty(state_test_env, var):
         Nothing.
     """
 
-    response = state_test_env.u_boot_console.run_command('echo ${%s}' % var)
+    response = state_test_env.ubman.run_command('echo ${%s}' % var)
     assert response == ''
 
 def validate_set(state_test_env, var, value):
@@ -171,13 +171,13 @@ def validate_set(state_test_env, var, value):
 
     # echo does not preserve leading, internal, or trailing whitespace in the
     # value. printenv does, and hence allows more complete testing.
-    response = state_test_env.u_boot_console.run_command('printenv %s' % var)
+    response = state_test_env.ubman.run_command('printenv %s' % var)
     assert response == ('%s=%s' % (var, value))
 
 @pytest.mark.boardspec('sandbox')
-def test_env_initial_env_file(u_boot_console):
+def test_env_initial_env_file(ubman):
     """Test that the u-boot-initial-env make target works"""
-    cons = u_boot_console
+    cons = ubman
     builddir = 'O=' + cons.config.build_dir
     envfile = cons.config.build_dir + '/u-boot-initial-env'
 
@@ -215,7 +215,7 @@ def test_env_printenv_non_existent(state_test_env):
     """Test printenv error message for non-existant variables."""
 
     var = state_test_env.set_var
-    c = state_test_env.u_boot_console
+    c = state_test_env.ubman
     with c.disable_check('error_notification'):
         response = c.run_command('printenv %s' % var)
     assert response == '## Error: "%s" not defined' % var
@@ -277,8 +277,8 @@ def test_env_import_checksum_no_size(state_test_env):
     """Test that omitted ('-') size parameter with checksum validation fails the
        env import function.
     """
-    c = state_test_env.u_boot_console
-    ram_base = u_boot_utils.find_ram_base(state_test_env.u_boot_console)
+    c = state_test_env.ubman
+    ram_base = u_boot_utils.find_ram_base(state_test_env.ubman)
     addr = '%08x' % ram_base
 
     with c.disable_check('error_notification'):
@@ -290,8 +290,8 @@ def test_env_import_whitelist_checksum_no_size(state_test_env):
     """Test that omitted ('-') size parameter with checksum validation fails the
        env import function when variables are passed as parameters.
     """
-    c = state_test_env.u_boot_console
-    ram_base = u_boot_utils.find_ram_base(state_test_env.u_boot_console)
+    c = state_test_env.ubman
+    ram_base = u_boot_utils.find_ram_base(state_test_env.ubman)
     addr = '%08x' % ram_base
 
     with c.disable_check('error_notification'):
@@ -302,8 +302,8 @@ def test_env_import_whitelist_checksum_no_size(state_test_env):
 @pytest.mark.buildconfigspec('cmd_importenv')
 def test_env_import_whitelist(state_test_env):
     """Test importing only a handful of env variables from an environment."""
-    c = state_test_env.u_boot_console
-    ram_base = u_boot_utils.find_ram_base(state_test_env.u_boot_console)
+    c = state_test_env.ubman
+    ram_base = u_boot_utils.find_ram_base(state_test_env.ubman)
     addr = '%08x' % ram_base
 
     set_var(state_test_env, 'foo1', 'bar1')
@@ -339,8 +339,8 @@ def test_env_import_whitelist_delete(state_test_env):
        deletion if a var A that is passed to env import is not in the
        environment to be imported.
     """
-    c = state_test_env.u_boot_console
-    ram_base = u_boot_utils.find_ram_base(state_test_env.u_boot_console)
+    c = state_test_env.ubman
+    ram_base = u_boot_utils.find_ram_base(state_test_env.ubman)
     addr = '%08x' % ram_base
 
     set_var(state_test_env, 'foo1', 'bar1')
@@ -373,7 +373,7 @@ def test_env_info(state_test_env):
 
     """Test 'env info' command with all possible options.
     """
-    c = state_test_env.u_boot_console
+    c = state_test_env.ubman
 
     response = c.run_command('env info')
     nb_line = 0
@@ -410,7 +410,7 @@ def test_env_info_sandbox(state_test_env):
     """Test 'env info' command result with several options on sandbox
        with a known ENV configuration: ready & default & persistent
     """
-    c = state_test_env.u_boot_console
+    c = state_test_env.ubman
 
     response = c.run_command('env info')
     assert 'env_ready = true' in response
@@ -435,7 +435,7 @@ def test_env_info_sandbox(state_test_env):
 def mk_env_ext4(state_test_env):
 
     """Create a empty ext4 file system volume."""
-    c = state_test_env.u_boot_console
+    c = state_test_env.ubman
     filename = 'env.ext4.img'
     persistent = c.config.persistent_data_dir + '/' + filename
     fs_img = c.config.result_dir  + '/' + filename
@@ -467,7 +467,7 @@ def mk_env_ext4(state_test_env):
 def test_env_ext4(state_test_env):
 
     """Test ENV in EXT4 on sandbox."""
-    c = state_test_env.u_boot_console
+    c = state_test_env.ubman
     fs_img = ''
     try:
         fs_img = mk_env_ext4(state_test_env)
@@ -545,7 +545,7 @@ def test_env_ext4(state_test_env):
         if fs_img:
             call('rm -f %s' % fs_img, shell=True)
 
-def test_env_text(u_boot_console):
+def test_env_text(ubman):
     """Test the script that converts the environment to a text file"""
 
     def check_script(intext, expect_val):
@@ -567,7 +567,7 @@ def test_env_text(u_boot_console):
             else:
                 assert result == ''
 
-    cons = u_boot_console
+    cons = ubman
     script = os.path.join(cons.config.source_dir, 'scripts', 'env2string.awk')
 
     # simple script with a single var
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index 45143c1c7d9..af911770bc6 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -9,9 +9,9 @@ import u_boot_utils as util
 # This is only a partial test - coverting 64-bit sandbox. It does not test
 # big-endian images, nor 32-bit images
 @pytest.mark.boardspec('sandbox')
-def test_event_dump(u_boot_console):
+def test_event_dump(ubman):
     """Test that the "help" command can be executed."""
-    cons = u_boot_console
+    cons = ubman
     sandbox = cons.config.build_dir + '/u-boot'
     out = util.run_and_log(cons, ['scripts/event_dump.py', sandbox])
     expect = '''.*Event type            Id                              Source location
diff --git a/test/py/tests/test_extension.py b/test/py/tests/test_extension.py
index 267cf2ff27c..070b39832c1 100644
--- a/test/py/tests/test_extension.py
+++ b/test/py/tests/test_extension.py
@@ -13,41 +13,41 @@ overlay_addr = 0x1000
 SANDBOX_DTB='arch/sandbox/dts/sandbox.dtb'
 OVERLAY_DIR='arch/sandbox/dts/'
 
-def load_dtb(u_boot_console):
-    u_boot_console.log.action('Loading devicetree to RAM...')
-    u_boot_console.run_command('host load hostfs - $fdt_addr_r %s' % (os.path.join(u_boot_console.config.build_dir, SANDBOX_DTB)))
-    u_boot_console.run_command('fdt addr $fdt_addr_r')
+def load_dtb(ubman):
+    ubman.log.action('Loading devicetree to RAM...')
+    ubman.run_command('host load hostfs - $fdt_addr_r %s' % (os.path.join(ubman.config.build_dir, SANDBOX_DTB)))
+    ubman.run_command('fdt addr $fdt_addr_r')
 
 @pytest.mark.buildconfigspec('cmd_fdt')
 @pytest.mark.boardspec('sandbox')
-def test_extension(u_boot_console):
+def test_extension(ubman):
     """Test the 'extension' command."""
 
-    load_dtb(u_boot_console)
+    load_dtb(ubman)
 
-    output = u_boot_console.run_command('extension list')
+    output = ubman.run_command('extension list')
     assert('No extension' in output)
 
-    output = u_boot_console.run_command('extension scan')
+    output = ubman.run_command('extension scan')
     assert output == 'Found 2 extension board(s).'
 
-    output = u_boot_console.run_command('extension list')
+    output = ubman.run_command('extension list')
     assert('overlay0.dtbo' in output)
     assert('overlay1.dtbo' in output)
 
-    u_boot_console.run_command_list([
+    ubman.run_command_list([
         'setenv extension_overlay_addr %s' % (overlay_addr),
-        'setenv extension_overlay_cmd \'host load hostfs - ${extension_overlay_addr} %s${extension_overlay_name}\'' % (os.path.join(u_boot_console.config.build_dir, OVERLAY_DIR))])
+        'setenv extension_overlay_cmd \'host load hostfs - ${extension_overlay_addr} %s${extension_overlay_name}\'' % (os.path.join(ubman.config.build_dir, OVERLAY_DIR))])
 
-    output = u_boot_console.run_command('extension apply 0')
+    output = ubman.run_command('extension apply 0')
     assert('bytes read' in output)
 
-    output = u_boot_console.run_command('fdt print')
+    output = ubman.run_command('fdt print')
     assert('button3' in output)
 
-    output = u_boot_console.run_command('extension apply all')
+    output = ubman.run_command('extension apply all')
     assert('bytes read' in output)
 
-    output = u_boot_console.run_command('fdt print')
+    output = ubman.run_command('fdt print')
     assert('button4' in output)
 
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 8f9c4b26411..459be5af39d 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -118,7 +118,7 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
-def test_fit(u_boot_console):
+def test_fit(ubman):
     def make_fname(leaf):
         """Make a temporary filename
 
@@ -397,7 +397,7 @@ def test_fit(u_boot_console):
             check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdist not loaded')
 
 
-    cons = u_boot_console
+    cons = ubman
     # We need to use our own device tree file. Remember to restore it
     # afterwards.
     old_dtb = cons.config.dtb
diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
index 9ea3351619f..72f39edacf8 100644
--- a/test/py/tests/test_fit_auto_signed.py
+++ b/test/py/tests/test_fit_auto_signed.py
@@ -120,7 +120,7 @@ class SignedFitHelper(object):
 
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('fdtget')
-def test_fit_auto_signed(u_boot_console):
+def test_fit_auto_signed(ubman):
     """Test that mkimage generates auto-FIT with signatures/hashes as expected.
 
     The mkimage tool can create auto generated (i.e. without an ITS file
@@ -133,7 +133,7 @@ def test_fit_auto_signed(u_boot_console):
 
     The test does not run the sandbox. It only checks the host tool mkimage.
     """
-    cons = u_boot_console
+    cons = ubman
     mkimage = cons.config.build_dir + '/tools/mkimage'
     tempdir = os.path.join(cons.config.result_dir, 'auto_fit')
     os.makedirs(tempdir, exist_ok=True)
diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index cc6c0c4dc42..428d3e76a18 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -69,7 +69,7 @@ class SignableFitImage(object):
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
-def test_fit_ecdsa(u_boot_console):
+def test_fit_ecdsa(ubman):
     """ Test that signatures generated by mkimage are legible. """
     def generate_ecdsa_key():
         return ECC.generate(curve='prime256v1')
@@ -82,7 +82,7 @@ def test_fit_ecdsa(u_boot_console):
         dtb = dts.replace('.dts', '.dtb')
         util.run_and_log(cons, f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
 
-    cons = u_boot_console
+    cons = ubman
     mkimage = cons.config.build_dir + '/tools/mkimage'
     datadir = cons.config.source_dir + '/test/py/tests/vboot/'
     tempdir = os.path.join(cons.config.result_dir, 'ecdsa')
diff --git a/test/py/tests/test_fit_hashes.py b/test/py/tests/test_fit_hashes.py
index 4891e77ca2d..7bc24a7c870 100644
--- a/test/py/tests/test_fit_hashes.py
+++ b/test/py/tests/test_fit_hashes.py
@@ -80,7 +80,7 @@ class ReadonlyFitImage(object):
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
-def test_mkimage_hashes(u_boot_console):
+def test_mkimage_hashes(ubman):
     """ Test that hashes generated by mkimage are correct. """
 
     def assemble_fit_image(dest_fit, its, destdir):
@@ -91,7 +91,7 @@ def test_mkimage_hashes(u_boot_console):
         dtb = dts.replace('.dts', '.dtb')
         util.run_and_log(cons, f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
 
-    cons = u_boot_console
+    cons = ubman
     mkimage = cons.config.build_dir + '/tools/mkimage'
     datadir = cons.config.source_dir + '/test/py/tests/vboot/'
     tempdir = os.path.join(cons.config.result_dir, 'hashes')
diff --git a/test/py/tests/test_fpga.py b/test/py/tests/test_fpga.py
index 460ff227f6f..7450b13945f 100644
--- a/test/py/tests/test_fpga.py
+++ b/test/py/tests/test_fpga.py
@@ -63,8 +63,8 @@ env__fpga_under_test = {
 
 import test_net
 
-def check_dev(u_boot_console):
-    f = u_boot_console.config.env.get('env__fpga_under_test', None)
+def check_dev(ubman):
+    f = ubman.config.env.get('env__fpga_under_test', None)
     if not f:
         pytest.skip('No FPGA to test')
 
@@ -74,20 +74,20 @@ def check_dev(u_boot_console):
 
     return dev, f
 
-def load_file_from_var(u_boot_console, name):
-    dev, f = check_dev(u_boot_console)
+def load_file_from_var(ubman, name):
+    dev, f = check_dev(ubman)
 
     addr = f.get('addr', -1)
     if addr < 0:
         pytest.fail('No address specified via env__fpga_under_test')
 
-    test_net.test_net_dhcp(u_boot_console)
-    test_net.test_net_setup_static(u_boot_console)
+    test_net.test_net_dhcp(ubman)
+    test_net.test_net_setup_static(ubman)
     bit = f['%s' % (name)]
     bit_size = f['%s_size' % (name)]
 
     expected_tftp = 'Bytes transferred = %d' % bit_size
-    output = u_boot_console.run_command('tftpboot %x %s' % (addr, bit))
+    output = ubman.run_command('tftpboot %x %s' % (addr, bit))
     assert expected_tftp in output
 
     return f, dev, addr, bit, bit_size
@@ -97,158 +97,158 @@ expected_usage = 'fpga - loadable FPGA image support'
 
 @pytest.mark.xfail
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_fail(u_boot_console):
+def test_fpga_fail(ubman):
     # Test non valid fpga subcommand
     expected = 'fpga: non existing command'
-    output = u_boot_console.run_command('fpga broken 0')
+    output = ubman.run_command('fpga broken 0')
     #assert expected in output
     assert expected_usage in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_help(u_boot_console):
+def test_fpga_help(ubman):
     # Just show help
-    output = u_boot_console.run_command('fpga')
+    output = ubman.run_command('fpga')
     assert expected_usage in output
 
 
 ###### FPGA DUMP tests ######
 
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_dump(u_boot_console):
+def test_fpga_dump(ubman):
     pytest.skip('Not implemented now')
 
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_dump_variable(u_boot_console):
+def test_fpga_dump_variable(ubman):
     # Same as above but via "fpga" variable
     pytest.skip('Not implemented now')
 
 ###### FPGA INFO tests ######
 
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_info_fail(u_boot_console):
+def test_fpga_info_fail(ubman):
     # Maybe this can be skipped completely
-    dev, f = check_dev(u_boot_console)
+    dev, f = check_dev(ubman)
 
     # Multiple parameters to fpga info should fail
     expected = 'fpga: more parameters passed'
-    output = u_boot_console.run_command('fpga info 0 0')
+    output = ubman.run_command('fpga info 0 0')
     #assert expected in output
     assert expected_usage in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_info_list(u_boot_console):
+def test_fpga_info_list(ubman):
     # Maybe this can be skipped completely
-    dev, f = check_dev(u_boot_console)
+    dev, f = check_dev(ubman)
 
     # Code is design in a way that if fpga dev is not passed it should
     # return list of all fpga devices in the system
-    u_boot_console.run_command('setenv fpga')
-    output = u_boot_console.run_command('fpga info')
+    ubman.run_command('setenv fpga')
+    output = ubman.run_command('fpga info')
     assert expected_usage not in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_info(u_boot_console):
-    dev, f = check_dev(u_boot_console)
+def test_fpga_info(ubman):
+    dev, f = check_dev(ubman)
 
-    output = u_boot_console.run_command('fpga info %x' % (dev))
+    output = ubman.run_command('fpga info %x' % (dev))
     assert expected_usage not in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_info_variable(u_boot_console):
-    dev, f = check_dev(u_boot_console)
+def test_fpga_info_variable(ubman):
+    dev, f = check_dev(ubman)
 
     #
     # fpga variable is storing device number which doesn't need to be passed
     #
-    u_boot_console.run_command('setenv fpga %x' % (dev))
+    ubman.run_command('setenv fpga %x' % (dev))
 
-    output = u_boot_console.run_command('fpga info')
+    output = ubman.run_command('fpga info')
     # Variable cleanup
-    u_boot_console.run_command('setenv fpga')
+    ubman.run_command('setenv fpga')
     assert expected_usage not in output
 
 ###### FPGA LOAD tests ######
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_load_fail(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'bitstream_load')
+def test_fpga_load_fail(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'bitstream_load')
 
     for cmd in ['dump', 'load', 'loadb']:
         # missing dev parameter
         expected = 'fpga: incorrect parameters passed'
-        output = u_boot_console.run_command('fpga %s %x $filesize' % (cmd, addr))
+        output = ubman.run_command('fpga %s %x $filesize' % (cmd, addr))
         #assert expected in output
         assert expected_usage in output
 
         # more parameters - 0 at the end
         expected = 'fpga: more parameters passed'
-        output = u_boot_console.run_command('fpga %s %x %x $filesize 0' % (cmd, dev, addr))
+        output = ubman.run_command('fpga %s %x %x $filesize 0' % (cmd, dev, addr))
         #assert expected in output
         assert expected_usage in output
 
         # 0 address
         expected = 'fpga: zero fpga_data address'
-        output = u_boot_console.run_command('fpga %s %x 0 $filesize' % (cmd, dev))
+        output = ubman.run_command('fpga %s %x 0 $filesize' % (cmd, dev))
         #assert expected in output
         assert expected_usage in output
 
         # 0 filesize
         expected = 'fpga: zero size'
-        output = u_boot_console.run_command('fpga %s %x %x 0' % (cmd, dev, addr))
+        output = ubman.run_command('fpga %s %x %x 0' % (cmd, dev, addr))
         #assert expected in output
         assert expected_usage in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_load(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'bitstream_load')
+def test_fpga_load(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'bitstream_load')
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga load %x %x $filesize && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga load %x %x $filesize && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadp')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadp(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'bitstream_load')
+def test_fpga_loadp(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'bitstream_load')
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga load %x %x $filesize && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga load %x %x $filesize && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
     # And load also partial bistream
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'bitstream_loadp')
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'bitstream_loadp')
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadp %x %x $filesize && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga loadp %x %x $filesize && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadb(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'bitstream_loadb')
+def test_fpga_loadb(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'bitstream_loadb')
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadb %x %x $filesize && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga loadb %x %x $filesize && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadbp')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadbp(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'bitstream_loadb')
+def test_fpga_loadbp(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'bitstream_loadb')
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadb %x %x $filesize && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga loadb %x %x $filesize && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
     # And load also partial bistream in bit format
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'bitstream_loadbp')
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'bitstream_loadbp')
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadbp %x %x $filesize && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga loadbp %x %x $filesize && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
 ###### FPGA LOADMK tests ######
@@ -257,18 +257,18 @@ def test_fpga_loadbp(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('legacy_image_format')
-def test_fpga_loadmk_fail(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
+def test_fpga_loadmk_fail(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_legacy')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
     # load image but pass incorrect address to show error message
     expected = 'Unknown image type'
-    output = u_boot_console.run_command('fpga loadmk %x %x' % (dev, addr + 0x10))
+    output = ubman.run_command('fpga loadmk %x %x' % (dev, addr + 0x10))
     assert expected in output
 
     # Pass more parameters then command expects - 0 at the end
-    output = u_boot_console.run_command('fpga loadmk %x %x 0' % (dev, addr))
+    output = ubman.run_command('fpga loadmk %x %x 0' % (dev, addr))
     #assert expected in output
     assert expected_usage in output
 
@@ -276,13 +276,13 @@ def test_fpga_loadmk_fail(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('legacy_image_format')
-def test_fpga_loadmk_legacy(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
+def test_fpga_loadmk_legacy(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_legacy')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk %x %x && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga loadmk %x %x && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
 @pytest.mark.xfail
@@ -290,53 +290,53 @@ def test_fpga_loadmk_legacy(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('legacy_image_format')
-def test_fpga_loadmk_legacy_variable_fpga(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
+def test_fpga_loadmk_legacy_variable_fpga(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_legacy')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
-    u_boot_console.run_command('setenv fpga %x' % (dev))
+    ubman.run_command('setenv fpga %x' % (dev))
 
     # this testcase should cover case which looks like it is supported but dev pointer is broken by loading mkimage address
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk %x && echo %s' % (addr, expected_text))
-    u_boot_console.run_command('setenv fpga')
+    output = ubman.run_command('fpga loadmk %x && echo %s' % (addr, expected_text))
+    ubman.run_command('setenv fpga')
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('legacy_image_format')
-def test_fpga_loadmk_legacy_variable_fpgadata(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
+def test_fpga_loadmk_legacy_variable_fpgadata(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_legacy')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
-    u_boot_console.run_command('setenv fpgadata %x' % (addr))
+    ubman.run_command('setenv fpgadata %x' % (addr))
 
     # this testcase should cover case which looks like it is supported but dev pointer is broken by loading mkimage address
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk %x && echo %s' % (dev, expected_text))
-    u_boot_console.run_command('setenv fpgadata')
+    output = ubman.run_command('fpga loadmk %x && echo %s' % (dev, expected_text))
+    ubman.run_command('setenv fpgadata')
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('legacy_image_format')
-def test_fpga_loadmk_legacy_variable(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
+def test_fpga_loadmk_legacy_variable(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_legacy')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
-    u_boot_console.run_command('setenv fpga %x' % (dev))
-    u_boot_console.run_command('setenv fpgadata %x' % (addr))
+    ubman.run_command('setenv fpga %x' % (dev))
+    ubman.run_command('setenv fpgadata %x' % (addr))
 
     # this testcase should cover case which looks like it is supported but dev pointer is broken by loading mkimage address
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk && echo %s' % (expected_text))
-    u_boot_console.run_command('setenv fpga')
-    u_boot_console.run_command('setenv fpgadata')
+    output = ubman.run_command('fpga loadmk && echo %s' % (expected_text))
+    ubman.run_command('setenv fpga')
+    ubman.run_command('setenv fpgadata')
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
@@ -344,96 +344,96 @@ def test_fpga_loadmk_legacy_variable(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('legacy_image_format')
 @pytest.mark.buildconfigspec('gzip')
-def test_fpga_loadmk_legacy_gz(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy_gz')
+def test_fpga_loadmk_legacy_gz(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_legacy_gz')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk %x %x && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga loadmk %x %x && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadmk_fit_external(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_fit_external')
+def test_fpga_loadmk_fit_external(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_fit_external')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk %x %x:fpga && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga loadmk %x %x:fpga && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadmk_fit(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_fit')
+def test_fpga_loadmk_fit(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_fit')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk %x %x:fpga && echo %s' % (dev, addr, expected_text))
+    output = ubman.run_command('fpga loadmk %x %x:fpga && echo %s' % (dev, addr, expected_text))
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadmk_fit_variable_fpga(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_fit')
+def test_fpga_loadmk_fit_variable_fpga(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_fit')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
     # FIXME this should fail - broken support in past
-    u_boot_console.run_command('setenv fpga %x' % (dev))
+    ubman.run_command('setenv fpga %x' % (dev))
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk %x:fpga && echo %s' % (addr, expected_text))
-    u_boot_console.run_command('setenv fpga')
+    output = ubman.run_command('fpga loadmk %x:fpga && echo %s' % (addr, expected_text))
+    ubman.run_command('setenv fpga')
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadmk_fit_variable_fpgadata(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_fit')
+def test_fpga_loadmk_fit_variable_fpgadata(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_fit')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
     # FIXME this should fail - broken support in past
-    u_boot_console.run_command('setenv fpgadata %x:fpga' % (addr))
+    ubman.run_command('setenv fpgadata %x:fpga' % (addr))
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk %x && echo %s' % (dev, expected_text))
-    u_boot_console.run_command('setenv fpgadata')
+    output = ubman.run_command('fpga loadmk %x && echo %s' % (dev, expected_text))
+    ubman.run_command('setenv fpgadata')
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadmk_fit_variable(u_boot_console):
-    f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_fit')
+def test_fpga_loadmk_fit_variable(ubman):
+    f, dev, addr, bit, bit_size = load_file_from_var(ubman, 'mkimage_fit')
 
-    u_boot_console.run_command('imi %x' % (addr))
+    ubman.run_command('imi %x' % (addr))
 
-    u_boot_console.run_command('setenv fpga %x' % (dev))
-    u_boot_console.run_command('setenv fpgadata %x:fpga' % (addr))
+    ubman.run_command('setenv fpga %x' % (dev))
+    ubman.run_command('setenv fpgadata %x:fpga' % (addr))
 
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadmk && echo %s' % (expected_text))
-    u_boot_console.run_command('setenv fpga')
-    u_boot_console.run_command('setenv fpgadata')
+    output = ubman.run_command('fpga loadmk && echo %s' % (expected_text))
+    ubman.run_command('setenv fpga')
+    ubman.run_command('setenv fpgadata')
     assert expected_text in output
 
 ###### FPGA LOAD tests ######
 
 @pytest.mark.buildconfigspec('cmd_fpga')
-def test_fpga_loadfs_fail(u_boot_console):
-    dev, f = check_dev(u_boot_console)
+def test_fpga_loadfs_fail(ubman):
+    dev, f = check_dev(ubman)
 
     addr = f.get('addr', -1)
     if addr < 0:
@@ -445,49 +445,49 @@ def test_fpga_loadfs_fail(u_boot_console):
 
     # less params - dev number removed
     expected = 'fpga: incorrect parameters passed'
-    output = u_boot_console.run_command('fpga loadfs %x %x %x %s' % (addr, bit_size, block_size, bit))
+    output = ubman.run_command('fpga loadfs %x %x %x %s' % (addr, bit_size, block_size, bit))
     #assert expected in output
     assert expected_usage in output
 
     # one more param - 0 at the end
     # This is the longest command that's why there is no message from cmd/fpga.c
-    output = u_boot_console.run_command('fpga loadfs %x %x %x %x %s 0' % (dev, addr, bit_size, block_size, bit))
+    output = ubman.run_command('fpga loadfs %x %x %x %x %s 0' % (dev, addr, bit_size, block_size, bit))
     assert expected_usage in output
 
     # zero address 0
     expected = 'fpga: zero fpga_data address'
-    output = u_boot_console.run_command('fpga loadfs %x %x %x %x %s' % (dev, 0, bit_size, block_size, bit))
+    output = ubman.run_command('fpga loadfs %x %x %x %x %s' % (dev, 0, bit_size, block_size, bit))
     #assert expected in output
     assert expected_usage in output
 
     # bit_size 0
     expected = 'fpga: zero size'
-    output = u_boot_console.run_command('fpga loadfs %x %x %x %x %s' % (dev, addr, 0, block_size, bit))
+    output = ubman.run_command('fpga loadfs %x %x %x %x %s' % (dev, addr, 0, block_size, bit))
     #assert expected in output
     assert expected_usage in output
 
     # block size 0
     # FIXME this should pass but it failing too
-    output = u_boot_console.run_command('fpga loadfs %x %x %x %x %s' % (dev, addr, bit_size, 0, bit))
+    output = ubman.run_command('fpga loadfs %x %x %x %x %s' % (dev, addr, bit_size, 0, bit))
     assert expected_usage in output
 
     # non existing bitstream name
     expected = 'Unable to read file noname'
-    output = u_boot_console.run_command('fpga loadfs %x %x %x %x mmc 0 noname' % (dev, addr, bit_size, block_size))
+    output = ubman.run_command('fpga loadfs %x %x %x %x mmc 0 noname' % (dev, addr, bit_size, block_size))
     assert expected in output
     assert expected_usage in output
 
     # -1 dev number
     expected = 'fpga_fsload: Invalid device number -1'
-    output = u_boot_console.run_command('fpga loadfs %d %x %x %x mmc 0 noname' % (-1, addr, bit_size, block_size))
+    output = ubman.run_command('fpga loadfs %d %x %x %x mmc 0 noname' % (-1, addr, bit_size, block_size))
     assert expected in output
     assert expected_usage in output
 
 
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_echo')
-def test_fpga_loadfs(u_boot_console):
-    dev, f = check_dev(u_boot_console)
+def test_fpga_loadfs(ubman):
+    dev, f = check_dev(ubman)
 
     addr = f.get('addr', -1)
     if addr < 0:
@@ -499,7 +499,7 @@ def test_fpga_loadfs(u_boot_console):
 
     # This should be done better
     expected_text = 'FPGA loaded successfully'
-    output = u_boot_console.run_command('fpga loadfs %x %x %x %x %s && echo %s' % (dev, addr, bit_size, block_size, bit, expected_text))
+    output = ubman.run_command('fpga loadfs %x %x %x %x %s && echo %s' % (dev, addr, bit_size, block_size, bit, expected_text))
     assert expected_text in output
 
 @pytest.mark.buildconfigspec('cmd_fpga')
@@ -507,26 +507,26 @@ def test_fpga_loadfs(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_dhcp')
 @pytest.mark.buildconfigspec('net')
-def test_fpga_secure_bit_auth(u_boot_console):
+def test_fpga_secure_bit_auth(ubman):
 
-    test_net.test_net_dhcp(u_boot_console)
-    test_net.test_net_setup_static(u_boot_console)
+    test_net.test_net_dhcp(ubman)
+    test_net.test_net_setup_static(ubman)
 
-    f = u_boot_console.config.env.get('env__fpga_secure_readable_file', None)
+    f = ubman.config.env.get('env__fpga_secure_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file to read')
 
     addr = f.get('addr', None)
     if not addr:
-      addr = u_boot_utils.find_ram_base(u_boot_console)
+      addr = u_boot_utils.find_ram_base(ubman)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    output = ubman.run_command('tftpboot %x %s' % (addr, fn))
     assert expected_tftp in output
 
     expected_zynqmpsecure = 'Bitstream successfully loaded'
-    output = u_boot_console.run_command('fpga loads 0 %x $filesize 0 2' % (addr))
+    output = ubman.run_command('fpga loads 0 %x $filesize 0 2' % (addr))
     assert expected_zynqmpsecure in output
 
 
@@ -535,31 +535,31 @@ def test_fpga_secure_bit_auth(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_dhcp')
 @pytest.mark.buildconfigspec('net')
-def test_fpga_secure_bit_img_auth_kup(u_boot_console):
+def test_fpga_secure_bit_img_auth_kup(ubman):
 
-    test_net.test_net_dhcp(u_boot_console)
-    test_net.test_net_setup_static(u_boot_console)
+    test_net.test_net_dhcp(ubman)
+    test_net.test_net_setup_static(ubman)
 
-    f = u_boot_console.config.env.get('env__fpga_secure_readable_file', None)
+    f = ubman.config.env.get('env__fpga_secure_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file to read')
 
     keyaddr = f.get('keyaddr', None)
     if not keyaddr:
-      addr = u_boot_utils.find_ram_base(u_boot_console)
+      addr = u_boot_utils.find_ram_base(ubman)
     expected_tftp = 'Bytes transferred = '
     keyfn = f['keyfn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (keyaddr, keyfn))
+    output = ubman.run_command('tftpboot %x %s' % (keyaddr, keyfn))
     assert expected_tftp in output
 
     addr = f.get('addr', None)
     if not addr:
-      addr = u_boot_utils.find_ram_base(u_boot_console)
+      addr = u_boot_utils.find_ram_base(ubman)
     expected_tftp = 'Bytes transferred = '
     fn = f['enckupfn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    output = ubman.run_command('tftpboot %x %s' % (addr, fn))
     assert expected_tftp in output
 
     expected_zynqmpsecure = 'Bitstream successfully loaded'
-    output = u_boot_console.run_command('fpga loads 0 %x $filesize 0 1 %x' % (addr, keyaddr))
+    output = ubman.run_command('fpga loads 0 %x $filesize 0 1 %x' % (addr, keyaddr))
     assert expected_zynqmpsecure in output
diff --git a/test/py/tests/test_fs/test_basic.py b/test/py/tests/test_fs/test_basic.py
index b5f4704172a..5a02348bb94 100644
--- a/test/py/tests/test_fs/test_basic.py
+++ b/test/py/tests/test_fs/test_basic.py
@@ -16,110 +16,110 @@ from fstest_helpers import assert_fs_integrity
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.slow
 class TestFsBasic(object):
-    def test_fs1(self, u_boot_console, fs_obj_basic):
+    def test_fs1(self, ubman, fs_obj_basic):
         """
         Test Case 1 - ls command, listing a root directory and invalid directory
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 1a - ls'):
+        with ubman.log.section('Test Case 1a - ls'):
             # Test Case 1 - ls
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sls host 0:0' % fs_type])
             assert(re.search('2621440000 *%s' % BIG_FILE, ''.join(output)))
             assert(re.search('1048576 *%s' % SMALL_FILE, ''.join(output)))
 
-        with u_boot_console.log.section('Test Case 1b - ls (invalid dir)'):
+        with ubman.log.section('Test Case 1b - ls (invalid dir)'):
             # In addition, test with a nonexistent directory to see if we crash.
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sls host 0:0 invalid_d' % fs_type)
             assert('' == output)
 
-    def test_fs2(self, u_boot_console, fs_obj_basic):
+    def test_fs2(self, ubman, fs_obj_basic):
         """
         Test Case 2 - size command for a small file
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 2a - size (small)'):
+        with ubman.log.section('Test Case 2a - size (small)'):
             # 1MB is 0x0010 0000
             # Test Case 2a - size of small file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%ssize host 0:0 /%s' % (fs_type, SMALL_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
-        with u_boot_console.log.section('Test Case 2b - size (/../<file>)'):
+        with ubman.log.section('Test Case 2b - size (/../<file>)'):
             # Test Case 2b - size of small file via a path using '..'
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%ssize host 0:0 /SUBDIR/../%s' % (fs_type, SMALL_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
-    def test_fs3(self, u_boot_console, fs_obj_basic):
+    def test_fs3(self, ubman, fs_obj_basic):
         """
         Test Case 3 - size command for a large file
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 3 - size (large)'):
+        with ubman.log.section('Test Case 3 - size (large)'):
             # 2.5GB (1024*1024*2500) is 0x9C40 0000
             # Test Case 3 - size of big file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%ssize host 0:0 /%s' % (fs_type, BIG_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=9c400000' in ''.join(output))
 
-    def test_fs4(self, u_boot_console, fs_obj_basic):
+    def test_fs4(self, ubman, fs_obj_basic):
         """
         Test Case 4 - load a small file, 1MB
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 4 - load (small)'):
+        with ubman.log.section('Test Case 4 - load (small)'):
             # Test Case 4a - Read full 1MB of small file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, SMALL_FILE),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
             # Test Case 4b - Read full 1MB of small file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
 
-    def test_fs5(self, u_boot_console, fs_obj_basic):
+    def test_fs5(self, ubman, fs_obj_basic):
         """
         Test Case 5 - load, reading first 1MB of 3GB file
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 5 - load (first 1MB)'):
+        with ubman.log.section('Test Case 5 - load (first 1MB)'):
             # Test Case 5a - First 1MB of big file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x0' % (fs_type, ADDR, BIG_FILE, LENGTH),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
             # Test Case 5b - First 1MB of big file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[1] in ''.join(output))
 
-    def test_fs6(self, u_boot_console, fs_obj_basic):
+    def test_fs6(self, ubman, fs_obj_basic):
         """
         Test Case 6 - load, reading last 1MB of 3GB file
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 6 - load (last 1MB)'):
+        with ubman.log.section('Test Case 6 - load (last 1MB)'):
             # fails for ext as no offset support
             # Test Case 6a - Last 1MB of big file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x9c300000'
                     % (fs_type, ADDR, BIG_FILE, LENGTH),
@@ -127,20 +127,20 @@ class TestFsBasic(object):
             assert('filesize=100000' in ''.join(output))
 
             # Test Case 6b - Last 1MB of big file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[2] in ''.join(output))
 
-    def test_fs7(self, u_boot_console, fs_obj_basic):
+    def test_fs7(self, ubman, fs_obj_basic):
         """
         Test Case 7 - load, 1MB from the last 1MB in 2GB
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 7 - load (last 1MB in 2GB)'):
+        with ubman.log.section('Test Case 7 - load (last 1MB in 2GB)'):
             # fails for ext as no offset support
             # Test Case 7a - One from the last 1MB chunk of 2GB
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x7ff00000'
                     % (fs_type, ADDR, BIG_FILE, LENGTH),
@@ -148,20 +148,20 @@ class TestFsBasic(object):
             assert('filesize=100000' in ''.join(output))
 
             # Test Case 7b - One from the last 1MB chunk of 2GB
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[3] in ''.join(output))
 
-    def test_fs8(self, u_boot_console, fs_obj_basic):
+    def test_fs8(self, ubman, fs_obj_basic):
         """
         Test Case 8 - load, reading first 1MB in 2GB
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 8 - load (first 1MB in 2GB)'):
+        with ubman.log.section('Test Case 8 - load (first 1MB in 2GB)'):
             # fails for ext as no offset support
             # Test Case 8a - One from the start 1MB chunk from 2GB
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x80000000'
                     % (fs_type, ADDR, BIG_FILE, LENGTH),
@@ -169,20 +169,20 @@ class TestFsBasic(object):
             assert('filesize=100000' in ''.join(output))
 
             # Test Case 8b - One from the start 1MB chunk from 2GB
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[4] in ''.join(output))
 
-    def test_fs9(self, u_boot_console, fs_obj_basic):
+    def test_fs9(self, ubman, fs_obj_basic):
         """
         Test Case 9 - load, 1MB crossing 2GB boundary
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 9 - load (crossing 2GB boundary)'):
+        with ubman.log.section('Test Case 9 - load (crossing 2GB boundary)'):
             # fails for ext as no offset support
             # Test Case 9a - One 1MB chunk crossing the 2GB boundary
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x7ff80000'
                     % (fs_type, ADDR, BIG_FILE, LENGTH),
@@ -190,20 +190,20 @@ class TestFsBasic(object):
             assert('filesize=100000' in ''.join(output))
 
             # Test Case 9b - One 1MB chunk crossing the 2GB boundary
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[5] in ''.join(output))
 
-    def test_fs10(self, u_boot_console, fs_obj_basic):
+    def test_fs10(self, ubman, fs_obj_basic):
         """
         Test Case 10 - load, reading beyond file end'):
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 10 - load (beyond file end)'):
+        with ubman.log.section('Test Case 10 - load (beyond file end)'):
             # Generic failure case
             # Test Case 10 - 2MB chunk from the last 1MB of big file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s 0x00200000 0x9c300000'
                     % (fs_type, ADDR, BIG_FILE),
@@ -212,16 +212,16 @@ class TestFsBasic(object):
                 'setenv filesize'])
         assert('filesize=100000' in ''.join(output))
 
-    def test_fs11(self, u_boot_console, fs_obj_basic):
+    def test_fs11(self, ubman, fs_obj_basic):
         """
         Test Case 11 - write'
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 11 - write'):
+        with ubman.log.section('Test Case 11 - write'):
             # Read 1MB from small file
             # Write it back to test the writes
             # Test Case 11a - Check that the write succeeded
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, SMALL_FILE),
                 '%swrite host 0:0 %x /%s.w $filesize'
@@ -230,39 +230,39 @@ class TestFsBasic(object):
 
             # Test Case 11b - Check md5 of written to is same
             # as the one read from
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%sload host 0:0 %x /%s.w' % (fs_type, ADDR, SMALL_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs12(self, u_boot_console, fs_obj_basic):
+    def test_fs12(self, ubman, fs_obj_basic):
         """
         Test Case 12 - write to "." directory
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 12 - write (".")'):
+        with ubman.log.section('Test Case 12 - write (".")'):
             # Next test case checks writing a file whose dirent
             # is the first in the block, which is always true for "."
             # The write should fail, but the lookup should work
             # Test Case 12 - Check directory traversal
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%swrite host 0:0 %x /. 0x10' % (fs_type, ADDR)])
             assert('Unable to write' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs13(self, u_boot_console, fs_obj_basic):
+    def test_fs13(self, ubman, fs_obj_basic):
         """
         Test Case 13 - write to a file with "/./<filename>"
         """
         fs_type,fs_img,md5val = fs_obj_basic
-        with u_boot_console.log.section('Test Case 13 - write  ("./<file>")'):
+        with ubman.log.section('Test Case 13 - write  ("./<file>")'):
             # Read 1MB from small file
             # Write it via "same directory", i.e. "." dirent
             # Test Case 13a - Check directory traversal
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, SMALL_FILE),
                 '%swrite host 0:0 %x /./%s2 $filesize'
@@ -271,7 +271,7 @@ class TestFsBasic(object):
 
             # Test Case 13b - Check md5 of written to is same
             # as the one read from
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
                 '%sload host 0:0 %x /./%s2' % (fs_type, ADDR, SMALL_FILE),
                 'md5sum %x $filesize' % ADDR,
@@ -280,7 +280,7 @@ class TestFsBasic(object):
 
             # Test Case 13c - Check md5 of written to is same
             # as the one read from
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
                 '%sload host 0:0 %x /%s2' % (fs_type, ADDR, SMALL_FILE),
                 'md5sum %x $filesize' % ADDR,
diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
index 87ad8f2d5fd..a2bb6b505f2 100644
--- a/test/py/tests/test_fs/test_erofs.py
+++ b/test/py/tests/test_fs/test_erofs.py
@@ -65,64 +65,64 @@ def clean_erofs_image(build_dir):
     image_path = os.path.join(build_dir, EROFS_IMAGE_NAME)
     os.remove(image_path)
 
-def erofs_ls_at_root(u_boot_console):
+def erofs_ls_at_root(ubman):
     """
     Test if all the present files and directories were listed.
     """
-    no_slash = u_boot_console.run_command('erofsls host 0')
-    slash = u_boot_console.run_command('erofsls host 0 /')
+    no_slash = ubman.run_command('erofsls host 0')
+    slash = ubman.run_command('erofsls host 0 /')
     assert no_slash == slash
 
     expected_lines = ['./', '../', '4096   f4096', '7812   f7812', 'subdir/',
                       '<SYM>   symdir', '<SYM>   symfile', '4 file(s), 3 dir(s)']
 
-    output = u_boot_console.run_command('erofsls host 0')
+    output = ubman.run_command('erofsls host 0')
     for line in expected_lines:
         assert line in output
 
-def erofs_ls_at_subdir(u_boot_console):
+def erofs_ls_at_subdir(ubman):
     """
     Test if the path resolution works.
     """
     expected_lines = ['./', '../', '100   subdir-file', '1 file(s), 2 dir(s)']
-    output = u_boot_console.run_command('erofsls host 0 subdir')
+    output = ubman.run_command('erofsls host 0 subdir')
     for line in expected_lines:
         assert line in output
 
-def erofs_ls_at_symlink(u_boot_console):
+def erofs_ls_at_symlink(ubman):
     """
     Test if the symbolic link's target resolution works.
     """
-    output = u_boot_console.run_command('erofsls host 0 symdir')
-    output_subdir = u_boot_console.run_command('erofsls host 0 subdir')
+    output = ubman.run_command('erofsls host 0 symdir')
+    output_subdir = ubman.run_command('erofsls host 0 subdir')
     assert output == output_subdir
 
     expected_lines = ['./', '../', '100   subdir-file', '1 file(s), 2 dir(s)']
     for line in expected_lines:
         assert line in output
 
-def erofs_ls_at_non_existent_dir(u_boot_console):
+def erofs_ls_at_non_existent_dir(ubman):
     """
     Test if the EROFS support will crash when get a nonexistent directory.
     """
-    out_non_existent = u_boot_console.run_command('erofsls host 0 fff')
-    out_not_dir = u_boot_console.run_command('erofsls host 0 f1000')
+    out_non_existent = ubman.run_command('erofsls host 0 fff')
+    out_not_dir = ubman.run_command('erofsls host 0 f1000')
     assert out_non_existent == out_not_dir
     assert '' in out_non_existent
 
-def erofs_load_files(u_boot_console, files, sizes, address):
+def erofs_load_files(ubman, files, sizes, address):
     """
     Loads files and asserts their checksums.
     """
-    build_dir = u_boot_console.config.build_dir
+    build_dir = ubman.config.build_dir
     for (file, size) in zip(files, sizes):
-        out = u_boot_console.run_command('erofsload host 0 {} {}'.format(address, file))
+        out = ubman.run_command('erofsload host 0 {} {}'.format(address, file))
 
         # check if the right amount of bytes was read
         assert size in out
 
         # calculate u-boot file's checksum
-        out = u_boot_console.run_command('md5sum {} {}'.format(address, hex(int(size))))
+        out = ubman.run_command('md5sum {} {}'.format(address, hex(int(size))))
         u_boot_checksum = out.split()[-1]
 
         # calculate original file's checksum
@@ -134,54 +134,54 @@ def erofs_load_files(u_boot_console, files, sizes, address):
         # compare checksum
         assert u_boot_checksum == original_checksum
 
-def erofs_load_files_at_root(u_boot_console):
+def erofs_load_files_at_root(ubman):
     """
     Test load file from the root directory.
     """
     files = ['f4096', 'f7812']
     sizes = ['4096', '7812']
     address = '$kernel_addr_r'
-    erofs_load_files(u_boot_console, files, sizes, address)
+    erofs_load_files(ubman, files, sizes, address)
 
-def erofs_load_files_at_subdir(u_boot_console):
+def erofs_load_files_at_subdir(ubman):
     """
     Test load file from the subdirectory.
     """
     files = ['subdir/subdir-file']
     sizes = ['100']
     address = '$kernel_addr_r'
-    erofs_load_files(u_boot_console, files, sizes, address)
+    erofs_load_files(ubman, files, sizes, address)
 
-def erofs_load_files_at_symlink(u_boot_console):
+def erofs_load_files_at_symlink(ubman):
     """
     Test load file from the symlink.
     """
     files = ['symfile']
     sizes = ['7812']
     address = '$kernel_addr_r'
-    erofs_load_files(u_boot_console, files, sizes, address)
+    erofs_load_files(ubman, files, sizes, address)
 
-def erofs_load_non_existent_file(u_boot_console):
+def erofs_load_non_existent_file(ubman):
     """
     Test if the EROFS support will crash when load a nonexistent file.
     """
     address = '$kernel_addr_r'
     file = 'non-existent'
-    out = u_boot_console.run_command('erofsload host 0 {} {}'.format(address, file))
+    out = ubman.run_command('erofsload host 0 {} {}'.format(address, file))
     assert 'Failed to load' in out
 
-def erofs_run_all_tests(u_boot_console):
+def erofs_run_all_tests(ubman):
     """
     Runs all test cases.
     """
-    erofs_ls_at_root(u_boot_console)
-    erofs_ls_at_subdir(u_boot_console)
-    erofs_ls_at_symlink(u_boot_console)
-    erofs_ls_at_non_existent_dir(u_boot_console)
-    erofs_load_files_at_root(u_boot_console)
-    erofs_load_files_at_subdir(u_boot_console)
-    erofs_load_files_at_symlink(u_boot_console)
-    erofs_load_non_existent_file(u_boot_console)
+    erofs_ls_at_root(ubman)
+    erofs_ls_at_subdir(ubman)
+    erofs_ls_at_symlink(ubman)
+    erofs_ls_at_non_existent_dir(ubman)
+    erofs_load_files_at_root(ubman)
+    erofs_load_files_at_subdir(ubman)
+    erofs_load_files_at_symlink(ubman)
+    erofs_load_non_existent_file(ubman)
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
@@ -190,11 +190,11 @@ def erofs_run_all_tests(u_boot_console):
 @pytest.mark.requiredtool('mkfs.erofs')
 @pytest.mark.requiredtool('md5sum')
 
-def test_erofs(u_boot_console):
+def test_erofs(ubman):
     """
     Executes the erofs test suite.
     """
-    build_dir = u_boot_console.config.build_dir
+    build_dir = ubman.config.build_dir
 
     # If the EFI subsystem is enabled and initialized, EFI subsystem tries to
     # add EFI boot option when the new disk is detected. If there is no EFI
@@ -203,15 +203,15 @@ def test_erofs(u_boot_console):
     # Restart U-Boot to clear the previous state.
     # TODO: Ideally EFI test cases need to be fixed, but it will
     # increase the number of system reset.
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
     try:
         # setup test environment
         make_erofs_image(build_dir)
         image_path = os.path.join(build_dir, EROFS_IMAGE_NAME)
-        u_boot_console.run_command('host bind 0 {}'.format(image_path))
+        ubman.run_command('host bind 0 {}'.format(image_path))
         # run all tests
-        erofs_run_all_tests(u_boot_console)
+        erofs_run_all_tests(ubman)
     except:
         clean_erofs_image(build_dir)
         raise AssertionError
diff --git a/test/py/tests/test_fs/test_ext.py b/test/py/tests/test_fs/test_ext.py
index 05fefa53a0e..9c213f2da55 100644
--- a/test/py/tests/test_fs/test_ext.py
+++ b/test/py/tests/test_fs/test_ext.py
@@ -29,14 +29,14 @@ def str2fat(long_filename):
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.slow
 class TestFsExt(object):
-    def test_fs_ext1(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext1(self, ubman, fs_obj_ext):
         """
         Test Case 1 - write a file with absolute path
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 1 - write with abs path'):
+        with ubman.log.section('Test Case 1 - write with abs path'):
             # Test Case 1a - Check if command successfully returned
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x /dir1/%s.w1 $filesize'
@@ -44,7 +44,7 @@ class TestFsExt(object):
             assert('20480 bytes written' in ''.join(output))
 
             # Test Case 1b - Check md5 of file content
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
                 '%sload host 0:0 %x /dir1/%s.w1' % (fs_type, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
@@ -52,14 +52,14 @@ class TestFsExt(object):
             assert(md5val[0] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext2(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext2(self, ubman, fs_obj_ext):
         """
         Test Case 2 - write to a file with relative path
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 2 - write with rel path'):
+        with ubman.log.section('Test Case 2 - write with rel path'):
             # Test Case 2a - Check if command successfully returned
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x dir1/%s.w2 $filesize'
@@ -67,7 +67,7 @@ class TestFsExt(object):
             assert('20480 bytes written' in ''.join(output))
 
             # Test Case 2b - Check md5 of file content
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
                 '%sload host 0:0 %x dir1/%s.w2' % (fs_type, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
@@ -75,14 +75,14 @@ class TestFsExt(object):
             assert(md5val[0] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext3(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext3(self, ubman, fs_obj_ext):
         """
         Test Case 3 - write to a file with invalid path
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 3 - write with invalid path'):
+        with ubman.log.section('Test Case 3 - write with invalid path'):
             # Test Case 3 - Check if command expectedly failed
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x /dir1/none/%s.w3 $filesize'
@@ -90,32 +90,32 @@ class TestFsExt(object):
             assert('Unable to write file /dir1/none/' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext4(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext4(self, ubman, fs_obj_ext):
         """
         Test Case 4 - write at non-zero offset, enlarging file size
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 4 - write at non-zero offset, enlarging file size'):
+        with ubman.log.section('Test Case 4 - write at non-zero offset, enlarging file size'):
             # Test Case 4a - Check if command successfully returned
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x /dir1/%s.w4 $filesize'
                     % (fs_type, ADDR, MIN_FILE)])
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%swrite host 0:0 %x /dir1/%s.w4 $filesize 0x1400'
                     % (fs_type, ADDR, MIN_FILE))
             assert('20480 bytes written' in output)
 
             # Test Case 4b - Check size of written file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%ssize host 0:0 /dir1/%s.w4' % (fs_type, MIN_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=6400' in ''.join(output))
 
             # Test Case 4c - Check md5 of file content
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
                 '%sload host 0:0 %x /dir1/%s.w4' % (fs_type, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
@@ -123,32 +123,32 @@ class TestFsExt(object):
             assert(md5val[1] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext5(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext5(self, ubman, fs_obj_ext):
         """
         Test Case 5 - write at non-zero offset, shrinking file size
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 5 - write at non-zero offset, shrinking file size'):
+        with ubman.log.section('Test Case 5 - write at non-zero offset, shrinking file size'):
             # Test Case 5a - Check if command successfully returned
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x /dir1/%s.w5 $filesize'
                     % (fs_type, ADDR, MIN_FILE)])
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%swrite host 0:0 %x /dir1/%s.w5 0x1400 0x1400'
                     % (fs_type, ADDR, MIN_FILE))
             assert('5120 bytes written' in output)
 
             # Test Case 5b - Check size of written file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%ssize host 0:0 /dir1/%s.w5' % (fs_type, MIN_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=2800' in ''.join(output))
 
             # Test Case 5c - Check md5 of file content
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
                 '%sload host 0:0 %x /dir1/%s.w5' % (fs_type, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
@@ -156,57 +156,57 @@ class TestFsExt(object):
             assert(md5val[2] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext6(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext6(self, ubman, fs_obj_ext):
         """
         Test Case 6 - write nothing at the start, truncating to zero
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 6 - write nothing at the start, truncating to zero'):
+        with ubman.log.section('Test Case 6 - write nothing at the start, truncating to zero'):
             # Test Case 6a - Check if command successfully returned
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x /dir1/%s.w6 $filesize'
                     % (fs_type, ADDR, MIN_FILE)])
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%swrite host 0:0 %x /dir1/%s.w6 0 0'
                     % (fs_type, ADDR, MIN_FILE))
             assert('0 bytes written' in output)
 
             # Test Case 6b - Check size of written file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%ssize host 0:0 /dir1/%s.w6' % (fs_type, MIN_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=0' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext7(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext7(self, ubman, fs_obj_ext):
         """
         Test Case 7 - write at the end (append)
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 7 - write at the end (append)'):
+        with ubman.log.section('Test Case 7 - write at the end (append)'):
             # Test Case 7a - Check if command successfully returned
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x /dir1/%s.w7 $filesize'
                     % (fs_type, ADDR, MIN_FILE)])
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%swrite host 0:0 %x /dir1/%s.w7 $filesize $filesize'
                     % (fs_type, ADDR, MIN_FILE))
             assert('20480 bytes written' in output)
 
             # Test Case 7b - Check size of written file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%ssize host 0:0 /dir1/%s.w7' % (fs_type, MIN_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=a000' in ''.join(output))
 
             # Test Case 7c - Check md5 of file content
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
                 '%sload host 0:0 %x /dir1/%s.w7' % (fs_type, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
@@ -214,32 +214,32 @@ class TestFsExt(object):
             assert(md5val[3] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext8(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext8(self, ubman, fs_obj_ext):
         """
         Test Case 8 - write at offset beyond the end of file
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 8 - write beyond the end'):
+        with ubman.log.section('Test Case 8 - write beyond the end'):
             # Test Case 8a - Check if command expectedly failed
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x /dir1/%s.w8 $filesize'
                     % (fs_type, ADDR, MIN_FILE)])
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%swrite host 0:0 %x /dir1/%s.w8 0x1400 %x'
                     % (fs_type, ADDR, MIN_FILE, 0x100000 + 0x1400))
             assert('Unable to write file /dir1' in output)
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext9(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext9(self, ubman, fs_obj_ext):
         """
         Test Case 9 - write to a non-existing file at non-zero offset
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 9 - write to non-existing file with non-zero offset'):
+        with ubman.log.section('Test Case 9 - write to non-existing file with non-zero offset'):
             # Test Case 9a - Check if command expectedly failed
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
                 '%swrite host 0:0 %x /dir1/%s.w9 0x1400 0x1400'
@@ -247,98 +247,98 @@ class TestFsExt(object):
             assert('Unable to write file /dir1' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext10(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext10(self, ubman, fs_obj_ext):
         """
         'Test Case 10 - create/delete as many directories under root directory
         as amount of directory entries goes beyond one cluster size)'
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 10 - create/delete (many)'):
+        with ubman.log.section('Test Case 10 - create/delete (many)'):
             # Test Case 10a - Create many files
             #   Please note that the size of directory entry is 32 bytes.
             #   So one typical cluster may holds 64 (2048/32) entries.
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'host bind 0 %s' % fs_img)
 
             for i in range(0, 66):
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     '%swrite host 0:0 %x /FILE0123456789_%02x 100'
                     % (fs_type, ADDR, i))
-            output = u_boot_console.run_command('%sls host 0:0 /' % fs_type)
+            output = ubman.run_command('%sls host 0:0 /' % fs_type)
             assert('FILE0123456789_00' in output)
             assert('FILE0123456789_41' in output)
 
             # Test Case 10b - Delete many files
             for i in range(0, 66):
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     '%srm host 0:0 /FILE0123456789_%02x'
                     % (fs_type, i))
-            output = u_boot_console.run_command('%sls host 0:0 /' % fs_type)
+            output = ubman.run_command('%sls host 0:0 /' % fs_type)
             assert(not 'FILE0123456789_00' in output)
             assert(not 'FILE0123456789_41' in output)
 
             # Test Case 10c - Create many files again
             # Please note no.64 and 65 are intentionally re-created
             for i in range(64, 128):
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     '%swrite host 0:0 %x /FILE0123456789_%02x 100'
                     % (fs_type, ADDR, i))
-            output = u_boot_console.run_command('%sls host 0:0 /' % fs_type)
+            output = ubman.run_command('%sls host 0:0 /' % fs_type)
             assert('FILE0123456789_40' in output)
             assert('FILE0123456789_79' in output)
 
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext11(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext11(self, ubman, fs_obj_ext):
         """
         'Test Case 11 - create/delete as many directories under non-root
         directory as amount of directory entries goes beyond one cluster size)'
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 11 - create/delete (many)'):
+        with ubman.log.section('Test Case 11 - create/delete (many)'):
             # Test Case 11a - Create many files
             #   Please note that the size of directory entry is 32 bytes.
             #   So one typical cluster may holds 64 (2048/32) entries.
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 'host bind 0 %s' % fs_img)
 
             for i in range(0, 66):
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     '%swrite host 0:0 %x /dir1/FILE0123456789_%02x 100'
                     % (fs_type, ADDR, i))
-            output = u_boot_console.run_command('%sls host 0:0 /dir1' % fs_type)
+            output = ubman.run_command('%sls host 0:0 /dir1' % fs_type)
             assert('FILE0123456789_00' in output)
             assert('FILE0123456789_41' in output)
 
             # Test Case 11b - Delete many files
             for i in range(0, 66):
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     '%srm host 0:0 /dir1/FILE0123456789_%02x'
                     % (fs_type, i))
-            output = u_boot_console.run_command('%sls host 0:0 /dir1' % fs_type)
+            output = ubman.run_command('%sls host 0:0 /dir1' % fs_type)
             assert(not 'FILE0123456789_00' in output)
             assert(not 'FILE0123456789_41' in output)
 
             # Test Case 11c - Create many files again
             # Please note no.64 and 65 are intentionally re-created
             for i in range(64, 128):
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     '%swrite host 0:0 %x /dir1/FILE0123456789_%02x 100'
                     % (fs_type, ADDR, i))
-            output = u_boot_console.run_command('%sls host 0:0 /dir1' % fs_type)
+            output = ubman.run_command('%sls host 0:0 /dir1' % fs_type)
             assert('FILE0123456789_40' in output)
             assert('FILE0123456789_79' in output)
 
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_fs_ext12(self, u_boot_console, fs_obj_ext):
+    def test_fs_ext12(self, ubman, fs_obj_ext):
         """
         Test Case 12 - write plain and mangle file
         """
         fs_type,fs_img,md5val = fs_obj_ext
-        with u_boot_console.log.section('Test Case 12 - write plain and mangle file'):
+        with ubman.log.section('Test Case 12 - write plain and mangle file'):
             # Test Case 12a - Check if command successfully returned
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%swrite host 0:0 %x /%s 0'
                     % (fs_type, ADDR, PLAIN_FILE),
diff --git a/test/py/tests/test_fs/test_fs_cmd.py b/test/py/tests/test_fs/test_fs_cmd.py
index 700cf3591de..c925547c7bc 100644
--- a/test/py/tests/test_fs/test_fs_cmd.py
+++ b/test/py/tests/test_fs/test_fs_cmd.py
@@ -6,8 +6,8 @@ import pytest
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
-def test_fstypes(u_boot_console):
+def test_fstypes(ubman):
     """Test that `fstypes` prints a result which includes `sandbox`."""
-    output = u_boot_console.run_command('fstypes')
+    output = ubman.run_command('fstypes')
     assert "Supported filesystems:" in output
     assert "sandbox" in output
diff --git a/test/py/tests/test_fs/test_fs_fat.py b/test/py/tests/test_fs/test_fs_fat.py
index 4009d0b63a3..b61d8ab9eac 100644
--- a/test/py/tests/test_fs/test_fs_fat.py
+++ b/test/py/tests/test_fs/test_fs_fat.py
@@ -14,12 +14,12 @@ import re
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.slow
 class TestFsFat(object):
-    def test_fs_fat1(self, u_boot_console, fs_obj_fat):
+    def test_fs_fat1(self, ubman, fs_obj_fat):
         """Test that `fstypes` prints a result which includes `sandbox`."""
         fs_type,fs_img = fs_obj_fat
-        with u_boot_console.log.section('Test Case 1 - fatinfo'):
+        with ubman.log.section('Test Case 1 - fatinfo'):
             # Test Case 1 - ls
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 'fatinfo host 0:0'])
             assert(re.search('Filesystem: %s' % fs_type.upper(), ''.join(output)))
diff --git a/test/py/tests/test_fs/test_mkdir.py b/test/py/tests/test_fs/test_mkdir.py
index fa9561ec359..df680a87d57 100644
--- a/test/py/tests/test_fs/test_mkdir.py
+++ b/test/py/tests/test_fs/test_mkdir.py
@@ -14,107 +14,107 @@ from fstest_helpers import assert_fs_integrity
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.slow
 class TestMkdir(object):
-    def test_mkdir1(self, u_boot_console, fs_obj_mkdir):
+    def test_mkdir1(self, ubman, fs_obj_mkdir):
         """
         Test Case 1 - create a directory under a root
         """
         fs_type,fs_img = fs_obj_mkdir
-        with u_boot_console.log.section('Test Case 1 - mkdir'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 1 - mkdir'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%smkdir host 0:0 dir1' % fs_type,
                 '%sls host 0:0 /' % fs_type])
             assert('dir1/' in ''.join(output))
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sls host 0:0 dir1' % fs_type)
             assert('./'   in output)
             assert('../'  in output)
             assert_fs_integrity(fs_type, fs_img)
 
 
-    def test_mkdir2(self, u_boot_console, fs_obj_mkdir):
+    def test_mkdir2(self, ubman, fs_obj_mkdir):
         """
         Test Case 2 - create a directory under a sub-directory
         """
         fs_type,fs_img = fs_obj_mkdir
-        with u_boot_console.log.section('Test Case 2 - mkdir (sub-sub directory)'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 2 - mkdir (sub-sub directory)'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%smkdir host 0:0 dir1/dir2' % fs_type,
                 '%sls host 0:0 dir1' % fs_type])
             assert('dir2/' in ''.join(output))
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sls host 0:0 dir1/dir2' % fs_type)
             assert('./'   in output)
             assert('../'  in output)
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_mkdir3(self, u_boot_console, fs_obj_mkdir):
+    def test_mkdir3(self, ubman, fs_obj_mkdir):
         """
         Test Case 3 - trying to create a directory with a non-existing
         path should fail
         """
         fs_type,fs_img = fs_obj_mkdir
-        with u_boot_console.log.section('Test Case 3 - mkdir (non-existing path)'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 3 - mkdir (non-existing path)'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%smkdir host 0:0 none/dir3' % fs_type])
             assert('Unable to create a directory' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_mkdir4(self, u_boot_console, fs_obj_mkdir):
+    def test_mkdir4(self, ubman, fs_obj_mkdir):
         """
         Test Case 4 - trying to create "." should fail
         """
         fs_type,fs_img = fs_obj_mkdir
-        with u_boot_console.log.section('Test Case 4 - mkdir (".")'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 4 - mkdir (".")'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%smkdir host 0:0 .' % fs_type])
             assert('Unable to create a directory' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_mkdir5(self, u_boot_console, fs_obj_mkdir):
+    def test_mkdir5(self, ubman, fs_obj_mkdir):
         """
         Test Case 5 - trying to create ".." should fail
         """
         fs_type,fs_img = fs_obj_mkdir
-        with u_boot_console.log.section('Test Case 5 - mkdir ("..")'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 5 - mkdir ("..")'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%smkdir host 0:0 ..' % fs_type])
             assert('Unable to create a directory' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_mkdir6(self, u_boot_console, fs_obj_mkdir):
+    def test_mkdir6(self, ubman, fs_obj_mkdir):
         """
         'Test Case 6 - create as many directories as amount of directory
         entries goes beyond a cluster size)'
         """
         fs_type,fs_img = fs_obj_mkdir
-        with u_boot_console.log.section('Test Case 6 - mkdir (create many)'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 6 - mkdir (create many)'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%smkdir host 0:0 dir6' % fs_type,
                 '%sls host 0:0 /' % fs_type])
             assert('dir6/' in ''.join(output))
 
             for i in range(0, 20):
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     '%smkdir host 0:0 dir6/0123456789abcdef%02x'
                     % (fs_type, i))
-            output = u_boot_console.run_command('%sls host 0:0 dir6' % fs_type)
+            output = ubman.run_command('%sls host 0:0 dir6' % fs_type)
             assert('0123456789abcdef00/'  in output)
             assert('0123456789abcdef13/'  in output)
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sls host 0:0 dir6/0123456789abcdef13/.' % fs_type)
             assert('./'   in output)
             assert('../'  in output)
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sls host 0:0 dir6/0123456789abcdef13/..' % fs_type)
             assert('0123456789abcdef00/'  in output)
             assert('0123456789abcdef13/'  in output)
diff --git a/test/py/tests/test_fs/test_squashfs/test_sqfs_load.py b/test/py/tests/test_fs/test_squashfs/test_sqfs_load.py
index 6ec6ccec6c9..33093f61ac3 100644
--- a/test/py/tests/test_fs/test_squashfs/test_sqfs_load.py
+++ b/test/py/tests/test_fs/test_squashfs/test_sqfs_load.py
@@ -27,11 +27,11 @@ def original_md5sum(path):
 
     return checksum
 
-def uboot_md5sum(u_boot_console, address, count):
+def uboot_md5sum(ubman, address, count):
     """ Runs U-Boot's md5sum command.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
         address: address where the file was loaded (e.g.: $kernel_addr_r).
         count: file's size. It was named 'count' to match md5sum's respective
         argument name.
@@ -39,89 +39,89 @@ def uboot_md5sum(u_boot_console, address, count):
         The checksum of the file loaded with sqfsload as a string.
     """
 
-    out = u_boot_console.run_command('md5sum {} {}'.format(address, count))
+    out = ubman.run_command('md5sum {} {}'.format(address, count))
     checksum = out.split()[-1]
 
     return checksum
 
-def sqfs_load_files(u_boot_console, files, sizes, address):
+def sqfs_load_files(ubman, files, sizes, address):
     """ Loads files and asserts their checksums.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
         files: list of files to be loaded.
         sizes: the sizes of each file.
         address: the address where the files should be loaded.
     """
-    build_dir = u_boot_console.config.build_dir
+    build_dir = ubman.config.build_dir
     for (file, size) in zip(files, sizes):
-        out = u_boot_console.run_command('sqfsload host 0 {} {}'.format(address, file))
+        out = ubman.run_command('sqfsload host 0 {} {}'.format(address, file))
 
         # check if the right amount of bytes was read
         assert size in out
 
         # compare original file's checksum against u-boot's
-        u_boot_checksum = uboot_md5sum(u_boot_console, address, hex(int(size)))
+        u_boot_checksum = uboot_md5sum(ubman, address, hex(int(size)))
         original_file_path = os.path.join(build_dir, SQFS_SRC_DIR + '/' + file)
         original_checksum = original_md5sum(original_file_path)
         assert u_boot_checksum == original_checksum
 
-def sqfs_load_files_at_root(u_boot_console):
+def sqfs_load_files_at_root(ubman):
     """ Calls sqfs_load_files passing the files at the SquashFS image's root.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
 
     files = ['f4096', 'f5096', 'f1000']
     sizes = ['4096', '5096', '1000']
     address = '$kernel_addr_r'
-    sqfs_load_files(u_boot_console, files, sizes, address)
+    sqfs_load_files(ubman, files, sizes, address)
 
-def sqfs_load_files_at_subdir(u_boot_console):
+def sqfs_load_files_at_subdir(ubman):
     """ Calls sqfs_load_files passing the files at the SquashFS image's subdir.
 
     This test checks if the path resolution works, since the file is not at the
     root directory.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
     files = ['subdir/subdir-file']
     sizes = ['100']
     address = '$kernel_addr_r'
-    sqfs_load_files(u_boot_console, files, sizes, address)
+    sqfs_load_files(ubman, files, sizes, address)
 
-def sqfs_load_non_existent_file(u_boot_console):
+def sqfs_load_non_existent_file(ubman):
     """ Calls sqfs_load_files passing an non-existent file to raise an error.
 
     This test checks if the SquashFS support won't crash if it doesn't find the
     specified file.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
     address = '$kernel_addr_r'
     file = 'non-existent'
-    out = u_boot_console.run_command('sqfsload host 0 {} {}'.format(address, file))
+    out = ubman.run_command('sqfsload host 0 {} {}'.format(address, file))
     assert 'Failed to load' in out
 
-def sqfs_run_all_load_tests(u_boot_console):
+def sqfs_run_all_load_tests(ubman):
     """ Runs all the previously defined test cases.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
-    sqfs_load_files_at_root(u_boot_console)
-    sqfs_load_files_at_subdir(u_boot_console)
-    sqfs_load_non_existent_file(u_boot_console)
+    sqfs_load_files_at_root(ubman)
+    sqfs_load_files_at_subdir(ubman)
+    sqfs_load_non_existent_file(ubman)
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
 @pytest.mark.buildconfigspec('cmd_squashfs')
 @pytest.mark.buildconfigspec('fs_squashfs')
 @pytest.mark.requiredtool('mksquashfs')
-def test_sqfs_load(u_boot_console):
+def test_sqfs_load(ubman):
     """ Executes the sqfsload test suite.
 
     First, it generates the SquashFS images, then it runs the test cases and
@@ -129,9 +129,9 @@ def test_sqfs_load(u_boot_console):
     cleaned before exiting.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
-    build_dir = u_boot_console.config.build_dir
+    build_dir = ubman.config.build_dir
 
     # setup test environment
     check_mksquashfs_version()
@@ -142,8 +142,8 @@ def test_sqfs_load(u_boot_console):
     for image in STANDARD_TABLE:
         try:
             image_path = os.path.join(build_dir, image)
-            u_boot_console.run_command('host bind 0 {}'.format(image_path))
-            sqfs_run_all_load_tests(u_boot_console)
+            ubman.run_command('host bind 0 {}'.format(image_path))
+            sqfs_run_all_load_tests(ubman)
         except:
             clean_all_images(build_dir)
             clean_sqfs_src_dir(build_dir)
diff --git a/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py b/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
index a20a7d1a663..adda3b98cda 100644
--- a/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
+++ b/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
@@ -10,70 +10,70 @@ from sqfs_common import generate_sqfs_src_dir, make_all_images
 from sqfs_common import clean_sqfs_src_dir, clean_all_images
 from sqfs_common import check_mksquashfs_version
 
-def sqfs_ls_at_root(u_boot_console):
+def sqfs_ls_at_root(ubman):
     """ Runs sqfsls at image's root.
 
     This test checks if all the present files and directories were listed. Also,
     it checks if passing the slash or not changes the output, which it shouldn't.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
 
-    no_slash = u_boot_console.run_command('sqfsls host 0')
-    slash = u_boot_console.run_command('sqfsls host 0 /')
+    no_slash = ubman.run_command('sqfsls host 0')
+    slash = ubman.run_command('sqfsls host 0 /')
     assert no_slash == slash
 
     expected_lines = ['empty-dir/', '1000   f1000', '4096   f4096', '5096   f5096',
                       'subdir/', '<SYM>   sym', '4 file(s), 2 dir(s)']
 
-    output = u_boot_console.run_command('sqfsls host 0')
+    output = ubman.run_command('sqfsls host 0')
     for line in expected_lines:
         assert line in output
 
-def sqfs_ls_at_empty_dir(u_boot_console):
+def sqfs_ls_at_empty_dir(ubman):
     """ Runs sqfsls at an empty directory.
 
     This tests checks if sqfsls will print anything other than the 'Empty directory'
     message.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
-    assert u_boot_console.run_command('sqfsls host 0 empty-dir') == 'Empty directory.'
+    assert ubman.run_command('sqfsls host 0 empty-dir') == 'Empty directory.'
 
-def sqfs_ls_at_subdir(u_boot_console):
+def sqfs_ls_at_subdir(ubman):
     """ Runs sqfsls at the SquashFS image's subdir.
 
     This test checks if the path resolution works, since the directory is not the
     root.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
     expected_lines = ['100   subdir-file', '1 file(s), 0 dir(s)']
-    output = u_boot_console.run_command('sqfsls host 0 subdir')
+    output = ubman.run_command('sqfsls host 0 subdir')
     for line in expected_lines:
         assert line in output
 
-def sqfs_ls_at_symlink(u_boot_console):
+def sqfs_ls_at_symlink(ubman):
     """ Runs sqfsls at a SquashFS image's symbolic link.
 
     This test checks if the symbolic link's target resolution works.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
     # since sym -> subdir, the following outputs must be equal
-    output = u_boot_console.run_command('sqfsls host 0 sym')
-    output_subdir = u_boot_console.run_command('sqfsls host 0 subdir')
+    output = ubman.run_command('sqfsls host 0 sym')
+    output_subdir = ubman.run_command('sqfsls host 0 subdir')
     assert output == output_subdir
 
     expected_lines = ['100   subdir-file', '1 file(s), 0 dir(s)']
     for line in expected_lines:
         assert line in output
 
-def sqfs_ls_at_non_existent_dir(u_boot_console):
+def sqfs_ls_at_non_existent_dir(ubman):
     """ Runs sqfsls at a file and at a non-existent directory.
 
     This test checks if the SquashFS support won't crash if it doesn't find the
@@ -81,24 +81,24 @@ def sqfs_ls_at_non_existent_dir(u_boot_console):
     directory. In both cases, the output should be the same.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
-    out_non_existent = u_boot_console.run_command('sqfsls host 0 fff')
-    out_not_dir = u_boot_console.run_command('sqfsls host 0 f1000')
+    out_non_existent = ubman.run_command('sqfsls host 0 fff')
+    out_not_dir = ubman.run_command('sqfsls host 0 f1000')
     assert out_non_existent == out_not_dir
     assert '** Cannot find directory. **' in out_non_existent
 
-def sqfs_run_all_ls_tests(u_boot_console):
+def sqfs_run_all_ls_tests(ubman):
     """ Runs all the previously defined test cases.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
-    sqfs_ls_at_root(u_boot_console)
-    sqfs_ls_at_empty_dir(u_boot_console)
-    sqfs_ls_at_subdir(u_boot_console)
-    sqfs_ls_at_symlink(u_boot_console)
-    sqfs_ls_at_non_existent_dir(u_boot_console)
+    sqfs_ls_at_root(ubman)
+    sqfs_ls_at_empty_dir(ubman)
+    sqfs_ls_at_subdir(ubman)
+    sqfs_ls_at_symlink(ubman)
+    sqfs_ls_at_non_existent_dir(ubman)
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
@@ -106,7 +106,7 @@ def sqfs_run_all_ls_tests(u_boot_console):
 @pytest.mark.buildconfigspec('fs_squashfs')
 @pytest.mark.requiredtool('mksquashfs')
 @pytest.mark.singlethread
-def test_sqfs_ls(u_boot_console):
+def test_sqfs_ls(ubman):
     """ Executes the sqfsls test suite.
 
     First, it generates the SquashFS images, then it runs the test cases and
@@ -114,9 +114,9 @@ def test_sqfs_ls(u_boot_console):
     cleaned before exiting.
 
     Args:
-        u_boot_console: provides the means to interact with U-Boot's console.
+        ubman: provides the means to interact with U-Boot's console.
     """
-    build_dir = u_boot_console.config.build_dir
+    build_dir = ubman.config.build_dir
 
     # If the EFI subsystem is enabled and initialized, EFI subsystem tries to
     # add EFI boot option when the new disk is detected. If there is no EFI
@@ -125,7 +125,7 @@ def test_sqfs_ls(u_boot_console):
     # Restart U-Boot to clear the previous state.
     # TODO: Ideally EFI test cases need to be fixed, but it will
     # increase the number of system reset.
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
     # setup test environment
     check_mksquashfs_version()
@@ -136,8 +136,8 @@ def test_sqfs_ls(u_boot_console):
     for image in STANDARD_TABLE:
         try:
             image_path = os.path.join(build_dir, image)
-            u_boot_console.run_command('host bind 0 {}'.format(image_path))
-            sqfs_run_all_ls_tests(u_boot_console)
+            ubman.run_command('host bind 0 {}'.format(image_path))
+            sqfs_run_all_ls_tests(ubman)
         except:
             clean_all_images(build_dir)
             clean_sqfs_src_dir(build_dir)
diff --git a/test/py/tests/test_fs/test_symlink.py b/test/py/tests/test_fs/test_symlink.py
index 9ced101a294..9ffd7e6e54d 100644
--- a/test/py/tests/test_fs/test_symlink.py
+++ b/test/py/tests/test_fs/test_symlink.py
@@ -18,38 +18,38 @@ from fstest_helpers import assert_fs_integrity
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.slow
 class TestSymlink(object):
-    def test_symlink1(self, u_boot_console, fs_obj_symlink):
+    def test_symlink1(self, ubman, fs_obj_symlink):
         """
         Test Case 1 - create a link. and follow it when reading
         """
         fs_type, fs_img, md5val = fs_obj_symlink
-        with u_boot_console.log.section('Test Case 1 - create link and read'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 1 - create link and read'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 'setenv filesize',
                 'ln host 0:0 %s /%s.link ' % (SMALL_FILE, SMALL_FILE),
             ])
             assert('' in ''.join(output))
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%sload host 0:0 %x /%s.link' % (fs_type, ADDR, SMALL_FILE),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
             # Test Case 4b - Read full 1MB of small file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_symlink2(self, u_boot_console, fs_obj_symlink):
+    def test_symlink2(self, ubman, fs_obj_symlink):
         """
         Test Case 2 - create chained links
         """
         fs_type, fs_img, md5val = fs_obj_symlink
-        with u_boot_console.log.section('Test Case 2 - create chained links'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 2 - create chained links'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 'setenv filesize',
                 'ln host 0:0 %s /%s.link1 ' % (SMALL_FILE, SMALL_FILE),
@@ -60,25 +60,25 @@ class TestSymlink(object):
             ])
             assert('' in ''.join(output))
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%sload host 0:0 %x /%s.link3' % (fs_type, ADDR, SMALL_FILE),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
             # Test Case 4b - Read full 1MB of small file
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_symlink3(self, u_boot_console, fs_obj_symlink):
+    def test_symlink3(self, ubman, fs_obj_symlink):
         """
         Test Case 3 - replace file/link with link
         """
         fs_type, fs_img, md5val = fs_obj_symlink
-        with u_boot_console.log.section('Test Case 1 - create link and read'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 1 - create link and read'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 'setenv filesize',
                 'ln host 0:0 %s /%s ' % (MEDIUM_FILE, SMALL_FILE),
@@ -86,45 +86,45 @@ class TestSymlink(object):
             ])
             assert('' in ''.join(output))
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, SMALL_FILE),
                 'printenv filesize'])
             assert('filesize=a00000' in ''.join(output))
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[1] in ''.join(output))
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'ln host 0:0 %s.link /%s ' % (MEDIUM_FILE, SMALL_FILE),
                 '%sload host 0:0 %x /%s' % (fs_type, ADDR, SMALL_FILE),
                 'printenv filesize'])
             assert('filesize=a00000' in ''.join(output))
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[1] in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_symlink4(self, u_boot_console, fs_obj_symlink):
+    def test_symlink4(self, ubman, fs_obj_symlink):
         """
         Test Case 4 - create a broken link
         """
         fs_type, fs_img, md5val = fs_obj_symlink
-        with u_boot_console.log.section('Test Case 1 - create link and read'):
+        with ubman.log.section('Test Case 1 - create link and read'):
 
-            output = u_boot_console.run_command_list([
+            output = ubman.run_command_list([
                 'setenv filesize',
                 'ln host 0:0 nowhere /link ',
             ])
             assert('' in ''.join(output))
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sload host 0:0 %x /link' %
                 (fs_type, ADDR))
-            with u_boot_console.disable_check('error_notification'):
-                output = u_boot_console.run_command('printenv filesize')
+            with ubman.disable_check('error_notification'):
+                output = ubman.run_command('printenv filesize')
             assert('"filesize" not defined' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
diff --git a/test/py/tests/test_fs/test_unlink.py b/test/py/tests/test_fs/test_unlink.py
index 97aafc63bb5..7e911f02413 100644
--- a/test/py/tests/test_fs/test_unlink.py
+++ b/test/py/tests/test_fs/test_unlink.py
@@ -15,103 +15,103 @@ from fstest_helpers import assert_fs_integrity
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.slow
 class TestUnlink(object):
-    def test_unlink1(self, u_boot_console, fs_obj_unlink):
+    def test_unlink1(self, ubman, fs_obj_unlink):
         """
         Test Case 1 - delete a file
         """
         fs_type,fs_img = fs_obj_unlink
-        with u_boot_console.log.section('Test Case 1 - unlink (file)'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 1 - unlink (file)'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%srm host 0:0 dir1/file1' % fs_type,
                 '%sls host 0:0 dir1/file1' % fs_type])
             assert('' == ''.join(output))
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sls host 0:0 dir1/' % fs_type)
             assert(not 'file1' in output)
             assert('file2' in output)
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_unlink2(self, u_boot_console, fs_obj_unlink):
+    def test_unlink2(self, ubman, fs_obj_unlink):
         """
         Test Case 2 - delete many files
         """
         fs_type,fs_img = fs_obj_unlink
-        with u_boot_console.log.section('Test Case 2 - unlink (many)'):
-            output = u_boot_console.run_command('host bind 0 %s' % fs_img)
+        with ubman.log.section('Test Case 2 - unlink (many)'):
+            output = ubman.run_command('host bind 0 %s' % fs_img)
 
             for i in range(0, 20):
-                output = u_boot_console.run_command_list([
+                output = ubman.run_command_list([
                     '%srm host 0:0 dir2/0123456789abcdef%02x' % (fs_type, i),
                     '%sls host 0:0 dir2/0123456789abcdef%02x' % (fs_type, i)])
                 assert('' == ''.join(output))
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sls host 0:0 dir2' % fs_type)
             assert('0 file(s), 2 dir(s)' in output)
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_unlink3(self, u_boot_console, fs_obj_unlink):
+    def test_unlink3(self, ubman, fs_obj_unlink):
         """
         Test Case 3 - trying to delete a non-existing file should fail
         """
         fs_type,fs_img = fs_obj_unlink
-        with u_boot_console.log.section('Test Case 3 - unlink (non-existing)'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 3 - unlink (non-existing)'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%srm host 0:0 dir1/nofile' % fs_type])
             assert('nofile: doesn\'t exist' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_unlink4(self, u_boot_console, fs_obj_unlink):
+    def test_unlink4(self, ubman, fs_obj_unlink):
         """
         Test Case 4 - delete an empty directory
         """
         fs_type,fs_img = fs_obj_unlink
-        with u_boot_console.log.section('Test Case 4 - unlink (directory)'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 4 - unlink (directory)'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%srm host 0:0 dir4' % fs_type])
             assert('' == ''.join(output))
 
-            output = u_boot_console.run_command(
+            output = ubman.run_command(
                 '%sls host 0:0 /' % fs_type)
             assert(not 'dir4' in output)
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_unlink5(self, u_boot_console, fs_obj_unlink):
+    def test_unlink5(self, ubman, fs_obj_unlink):
         """
         Test Case 5 - trying to deleting a non-empty directory ".."
         should fail
         """
         fs_type,fs_img = fs_obj_unlink
-        with u_boot_console.log.section('Test Case 5 - unlink ("non-empty directory")'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 5 - unlink ("non-empty directory")'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%srm host 0:0 dir5' % fs_type])
             assert('directory is not empty' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_unlink6(self, u_boot_console, fs_obj_unlink):
+    def test_unlink6(self, ubman, fs_obj_unlink):
         """
         Test Case 6 - trying to deleting a "." should fail
         """
         fs_type,fs_img = fs_obj_unlink
-        with u_boot_console.log.section('Test Case 6 - unlink (".")'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 6 - unlink (".")'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%srm host 0:0 dir5/.' % fs_type])
             assert('directory is not empty' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
-    def test_unlink7(self, u_boot_console, fs_obj_unlink):
+    def test_unlink7(self, ubman, fs_obj_unlink):
         """
         Test Case 7 - trying to deleting a ".." should fail
         """
         fs_type,fs_img = fs_obj_unlink
-        with u_boot_console.log.section('Test Case 7 - unlink ("..")'):
-            output = u_boot_console.run_command_list([
+        with ubman.log.section('Test Case 7 - unlink ("..")'):
+            output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%srm host 0:0 dir5/..' % fs_type])
             assert('directory is not empty' in ''.join(output))
diff --git a/test/py/tests/test_gpio.py b/test/py/tests/test_gpio.py
index 3e16e636574..5c9d0b60bf5 100644
--- a/test/py/tests/test_gpio.py
+++ b/test/py/tests/test_gpio.py
@@ -14,51 +14,51 @@ import u_boot_utils
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_input(u_boot_console):
+def test_gpio_input(ubman):
     """Test that gpio input correctly returns the value of a gpio pin."""
 
-    response = u_boot_console.run_command('gpio input 0; echo rc:$?')
+    response = ubman.run_command('gpio input 0; echo rc:$?')
     expected_response = 'rc:0'
     assert(expected_response in response)
-    response = u_boot_console.run_command('gpio toggle 0; gpio input 0; echo rc:$?')
+    response = ubman.run_command('gpio toggle 0; gpio input 0; echo rc:$?')
     expected_response = 'rc:1'
     assert(expected_response in response)
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_exit_statuses(u_boot_console):
+def test_gpio_exit_statuses(ubman):
     """Test that non-input gpio commands correctly return the command
     success/failure status."""
 
     expected_response = 'rc:0'
-    response = u_boot_console.run_command('gpio clear 0; echo rc:$?')
+    response = ubman.run_command('gpio clear 0; echo rc:$?')
     assert(expected_response in response)
-    response = u_boot_console.run_command('gpio set 0; echo rc:$?')
+    response = ubman.run_command('gpio set 0; echo rc:$?')
     assert(expected_response in response)
-    response = u_boot_console.run_command('gpio toggle 0; echo rc:$?')
+    response = ubman.run_command('gpio toggle 0; echo rc:$?')
     assert(expected_response in response)
-    response = u_boot_console.run_command('gpio status -a; echo rc:$?')
+    response = ubman.run_command('gpio status -a; echo rc:$?')
     assert(expected_response in response)
 
     expected_response = 'rc:1'
-    response = u_boot_console.run_command('gpio nonexistent-command; echo rc:$?')
+    response = ubman.run_command('gpio nonexistent-command; echo rc:$?')
     assert(expected_response in response)
-    response = u_boot_console.run_command('gpio input 200; echo rc:$?')
+    response = ubman.run_command('gpio input 200; echo rc:$?')
     assert(expected_response in response)
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_read(u_boot_console):
+def test_gpio_read(ubman):
     """Test that gpio read correctly sets the variable to the value of a gpio pin."""
 
-    u_boot_console.run_command('gpio clear 0')
-    response = u_boot_console.run_command('gpio read var 0; echo val:$var,rc:$?')
+    ubman.run_command('gpio clear 0')
+    response = ubman.run_command('gpio read var 0; echo val:$var,rc:$?')
     expected_response = 'val:0,rc:0'
     assert(expected_response in response)
-    response = u_boot_console.run_command('gpio toggle 0; gpio read var 0; echo val:$var,rc:$?')
+    response = ubman.run_command('gpio toggle 0; gpio read var 0; echo val:$var,rc:$?')
     expected_response = 'val:1,rc:0'
     assert(expected_response in response)
-    response = u_boot_console.run_command('setenv var; gpio read var nonexistent-gpio; echo val:$var,rc:$?')
+    response = ubman.run_command('setenv var; gpio read var nonexistent-gpio; echo val:$var,rc:$?')
     expected_response = 'val:,rc:1'
     assert(expected_response in response)
 
@@ -97,7 +97,7 @@ env__gpio_dev_config = {
 
 
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_status_all_generic(u_boot_console):
+def test_gpio_status_all_generic(ubman):
     """Test the 'gpio status' command.
 
 	Displays all gpio pins available on the Board.
@@ -108,7 +108,7 @@ def test_gpio_status_all_generic(u_boot_console):
         number of such pins and mention that count in 'gpio_str_count'.
     """
 
-    f = u_boot_console.config.env.get('env__gpio_dev_config',False)
+    f = ubman.config.env.get('env__gpio_dev_config',False)
     if not f:
         pytest.skip("gpio not configured")
 
@@ -116,14 +116,14 @@ def test_gpio_status_all_generic(u_boot_console):
 
     #Display all the GPIO ports
     cmd = 'gpio status -a'
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
 
     for str_value in range(1,gpio_str_count + 1):
         assert f["gpio_str_%d" %(str_value)] in response
 
 
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_set_generic(u_boot_console):
+def test_gpio_set_generic(ubman):
     """Test the 'gpio set' command.
 
 	A specific gpio pin configured by user as output
@@ -132,7 +132,7 @@ def test_gpio_set_generic(u_boot_console):
 
     """
 
-    f = u_boot_console.config.env.get('env__gpio_dev_config',False)
+    f = ubman.config.env.get('env__gpio_dev_config',False)
     if not f:
         pytest.skip("gpio not configured")
 
@@ -141,14 +141,14 @@ def test_gpio_set_generic(u_boot_console):
 
 
     cmd = 'gpio set ' + gpio_pin_adr
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     good_response = gpio_set_value
     assert good_response in response
 
 
 
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_clear_generic(u_boot_console):
+def test_gpio_clear_generic(ubman):
     """Test the 'gpio clear' command.
 
 	A specific gpio pin configured by user as output
@@ -156,7 +156,7 @@ def test_gpio_clear_generic(u_boot_console):
 	'clear' option
     """
 
-    f = u_boot_console.config.env.get('env__gpio_dev_config',False)
+    f = ubman.config.env.get('env__gpio_dev_config',False)
     if not f:
         pytest.skip("gpio not configured")
 
@@ -165,13 +165,13 @@ def test_gpio_clear_generic(u_boot_console):
 
 
     cmd = 'gpio clear ' + gpio_pin_adr
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     good_response = gpio_clear_value
     assert good_response in response
 
 
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_toggle_generic(u_boot_console):
+def test_gpio_toggle_generic(ubman):
     """Test the 'gpio toggle' command.
 
 	A specific gpio pin configured by user as output
@@ -180,7 +180,7 @@ def test_gpio_toggle_generic(u_boot_console):
     """
 
 
-    f = u_boot_console.config.env.get('env__gpio_dev_config',False)
+    f = ubman.config.env.get('env__gpio_dev_config',False)
     if not f:
         pytest.skip("gpio not configured")
 
@@ -189,18 +189,18 @@ def test_gpio_toggle_generic(u_boot_console):
     gpio_clear_value = f['gpio_clear_value'];
 
     cmd = 'gpio set ' + gpio_pin_adr
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     good_response = gpio_set_value
     assert good_response in response
 
     cmd = 'gpio toggle ' + gpio_pin_adr
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     good_response = gpio_clear_value
     assert good_response in response
 
 
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_input_generic(u_boot_console):
+def test_gpio_input_generic(ubman):
     """Test the 'gpio input' command.
 
 	Specific gpio pins configured by user as input
@@ -208,7 +208,7 @@ def test_gpio_input_generic(u_boot_console):
 	is verified for logic '1' and logic '0' states
     """
 
-    f = u_boot_console.config.env.get('env__gpio_dev_config',False)
+    f = ubman.config.env.get('env__gpio_dev_config',False)
     if not f:
         pytest.skip("gpio not configured")
 
@@ -217,7 +217,7 @@ def test_gpio_input_generic(u_boot_console):
 
 
     cmd = 'gpio input ' + gpio_pin_adr
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     good_response = gpio_clear_value
     assert good_response in response
 
@@ -227,12 +227,12 @@ def test_gpio_input_generic(u_boot_console):
 
 
     cmd = 'gpio input ' + gpio_pin_adr
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     good_response = gpio_set_value
     assert good_response in response
 
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_pins_generic(u_boot_console):
+def test_gpio_pins_generic(ubman):
     """Test various gpio related functionality, such as the input, set, clear,
        and toggle for the set of gpio pin list.
 
@@ -241,7 +241,7 @@ def test_gpio_pins_generic(u_boot_console):
        commands.
     """
 
-    f = u_boot_console.config.env.get('env__gpio_dev_config', False)
+    f = ubman.config.env.get('env__gpio_dev_config', False)
     if not f:
         pytest.skip('gpio not configured')
 
@@ -251,31 +251,31 @@ def test_gpio_pins_generic(u_boot_console):
 
     for gpin in gpio_pins:
         # gpio input
-        u_boot_console.run_command(f'gpio input {gpin}')
+        ubman.run_command(f'gpio input {gpin}')
         expected_response = f'{gpin}: input:'
-        response = u_boot_console.run_command(f'gpio status -a {gpin}')
+        response = ubman.run_command(f'gpio status -a {gpin}')
         assert expected_response in response
 
         # gpio set
-        u_boot_console.run_command(f'gpio set {gpin}')
+        ubman.run_command(f'gpio set {gpin}')
         expected_response = f'{gpin}: output: 1'
-        response = u_boot_console.run_command(f'gpio status -a {gpin}')
+        response = ubman.run_command(f'gpio status -a {gpin}')
         assert expected_response in response
 
         # gpio clear
-        u_boot_console.run_command(f'gpio clear {gpin}')
+        ubman.run_command(f'gpio clear {gpin}')
         expected_response = f'{gpin}: output: 0'
-        response = u_boot_console.run_command(f'gpio status -a {gpin}')
+        response = ubman.run_command(f'gpio status -a {gpin}')
         assert expected_response in response
 
         # gpio toggle
-        u_boot_console.run_command(f'gpio toggle {gpin}')
+        ubman.run_command(f'gpio toggle {gpin}')
         expected_response = f'{gpin}: output: 1'
-        response = u_boot_console.run_command(f'gpio status -a {gpin}')
+        response = ubman.run_command(f'gpio status -a {gpin}')
         assert expected_response in response
 
 @pytest.mark.buildconfigspec('cmd_gpio')
-def test_gpio_pins_input_output_generic(u_boot_console):
+def test_gpio_pins_input_output_generic(ubman):
     """Test gpio related functionality such as input and output for the list of
        shorted gpio pins provided as a pair of input and output pins. This test
        will fail, if the gpio pins are not shorted properly.
@@ -285,7 +285,7 @@ def test_gpio_pins_input_output_generic(u_boot_console):
        pair to be tested for gpio input output case.
     """
 
-    f = u_boot_console.config.env.get('env__gpio_dev_config', False)
+    f = ubman.config.env.get('env__gpio_dev_config', False)
     if not f:
         pytest.skip('gpio not configured')
 
@@ -294,22 +294,22 @@ def test_gpio_pins_input_output_generic(u_boot_console):
         pytest.skip('gpio pin list for input and output are not configured')
 
     for gpins in gpio_pins:
-        u_boot_console.run_command(f'gpio input {gpins[0]}')
+        ubman.run_command(f'gpio input {gpins[0]}')
         expected_response = f'{gpins[0]}: input:'
-        response = u_boot_console.run_command(f'gpio status -a {gpins[0]}')
+        response = ubman.run_command(f'gpio status -a {gpins[0]}')
         assert expected_response in response
 
-        u_boot_console.run_command(f'gpio set {gpins[1]}')
+        ubman.run_command(f'gpio set {gpins[1]}')
         expected_response = f'{gpins[1]}: output:'
-        response = u_boot_console.run_command(f'gpio status -a {gpins[1]}')
+        response = ubman.run_command(f'gpio status -a {gpins[1]}')
         assert expected_response in response
 
-        u_boot_console.run_command(f'gpio clear {gpins[1]}')
+        ubman.run_command(f'gpio clear {gpins[1]}')
         expected_response = f'{gpins[0]}: input: 0'
-        response = u_boot_console.run_command(f'gpio status -a {gpins[0]}')
+        response = ubman.run_command(f'gpio status -a {gpins[0]}')
         assert expected_response in response
 
-        u_boot_console.run_command(f'gpio set {gpins[1]}')
+        ubman.run_command(f'gpio set {gpins[1]}')
         expected_response = f'{gpins[0]}: input: 1'
-        response = u_boot_console.run_command(f'gpio status -a {gpins[0]}')
+        response = ubman.run_command(f'gpio status -a {gpins[0]}')
         assert expected_response in response
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 6e135b663e8..0bd6a21278a 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -48,11 +48,11 @@ def parse_gpt_parts(disk_str):
 class GptTestDiskImage(object):
     """Disk Image used by the GPT tests."""
 
-    def __init__(self, u_boot_console):
+    def __init__(self, ubman):
         """Initialize a new GptTestDiskImage object.
 
         Args:
-            u_boot_console: A U-Boot console.
+            ubman: A U-Boot console.
 
         Returns:
             Nothing.
@@ -60,62 +60,62 @@ class GptTestDiskImage(object):
 
         filename = 'test_gpt_disk_image.bin'
 
-        persistent = u_boot_console.config.persistent_data_dir + '/' + filename
-        self.path = u_boot_console.config.result_dir  + '/' + filename
+        persistent = ubman.config.persistent_data_dir + '/' + filename
+        self.path = ubman.config.result_dir  + '/' + filename
 
-        with u_boot_utils.persistent_file_helper(u_boot_console.log, persistent):
+        with u_boot_utils.persistent_file_helper(ubman.log, persistent):
             if os.path.exists(persistent):
-                u_boot_console.log.action('Disk image file ' + persistent +
+                ubman.log.action('Disk image file ' + persistent +
                     ' already exists')
             else:
-                u_boot_console.log.action('Generating ' + persistent)
+                ubman.log.action('Generating ' + persistent)
                 fd = os.open(persistent, os.O_RDWR | os.O_CREAT)
                 os.ftruncate(fd, 4194304)
                 os.close(fd)
                 cmd = ('sgdisk',
                     '--disk-guid=375a56f7-d6c9-4e81-b5f0-09d41ca89efe',
                     persistent)
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
                 # part1 offset 1MB size 1MB
                 cmd = ('sgdisk', '--new=1:2048:4095', '--change-name=1:part1',
                     '--partition-guid=1:33194895-67f6-4561-8457-6fdeed4f50a3',
                     '-A 1:set:2',
                     persistent)
                 # part2 offset 2MB size 1.5MB
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
                 cmd = ('sgdisk', '--new=2:4096:7167', '--change-name=2:part2',
                     '--partition-guid=2:cc9c6e4a-6551-4cb5-87be-3210f96c86fb',
                     persistent)
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
                 cmd = ('sgdisk', '--load-backup=' + persistent)
-                u_boot_utils.run_and_log(u_boot_console, cmd)
+                u_boot_utils.run_and_log(ubman, cmd)
 
         cmd = ('cp', persistent, self.path)
-        u_boot_utils.run_and_log(u_boot_console, cmd)
+        u_boot_utils.run_and_log(ubman, cmd)
 
 @pytest.fixture(scope='function')
-def state_disk_image(u_boot_console):
+def state_disk_image(ubman):
     """pytest fixture to provide a GptTestDiskImage object to tests.
-    This is function-scoped because it uses u_boot_console, which is also
+    This is function-scoped because it uses ubman, which is also
     function-scoped. A new disk is returned each time to prevent tests from
     interfering with each other."""
 
-    return GptTestDiskImage(u_boot_console)
+    return GptTestDiskImage(ubman)
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.buildconfigspec('cmd_part')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_read(state_disk_image, u_boot_console):
+def test_gpt_read(state_disk_image, ubman):
     """Test the gpt read command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('gpt read host 0')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('gpt read host 0')
     assert 'Start 1MiB, size 1MiB' in output
     assert 'Block size 512, name part1' in output
     assert 'Start 2MiB, size 1MiB' in output
     assert 'Block size 512, name part2' in output
-    output = u_boot_console.run_command('part list host 0')
+    output = ubman.run_command('part list host 0')
     assert '0x00000800	0x00000fff	"part1"' in output
     assert '0x00001000	0x00001bff	"part2"' in output
 
@@ -123,14 +123,14 @@ def test_gpt_read(state_disk_image, u_boot_console):
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.buildconfigspec('partition_type_guid')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_read_var(state_disk_image, u_boot_console):
+def test_gpt_read_var(state_disk_image, ubman):
     """Test the gpt read command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('gpt read host 0 gpt_parts')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('gpt read host 0 gpt_parts')
     assert 'success!' in output
 
-    output = u_boot_console.run_command('echo ${gpt_parts}')
+    output = ubman.run_command('echo ${gpt_parts}')
     parts = parse_gpt_parts(output.rstrip())
 
     assert parts == [
@@ -157,99 +157,99 @@ def test_gpt_read_var(state_disk_image, u_boot_console):
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_verify(state_disk_image, u_boot_console):
+def test_gpt_verify(state_disk_image, ubman):
     """Test the gpt verify command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('gpt verify host 0')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('gpt verify host 0')
     assert 'Verify GPT: success!' in output
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_repair(state_disk_image, u_boot_console):
+def test_gpt_repair(state_disk_image, ubman):
     """Test the gpt repair command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('gpt repair host 0')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('gpt repair host 0')
     assert 'Repairing GPT: success!' in output
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_guid(state_disk_image, u_boot_console):
+def test_gpt_guid(state_disk_image, ubman):
     """Test the gpt guid command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('gpt guid host 0')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_setenv(state_disk_image, u_boot_console):
+def test_gpt_setenv(state_disk_image, ubman):
     """Test the gpt setenv command."""
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('gpt setenv host 0 part1')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('gpt setenv host 0 part1')
     assert 'success!' in output
-    output = u_boot_console.run_command('echo ${gpt_partition_addr}')
+    output = ubman.run_command('echo ${gpt_partition_addr}')
     assert output.rstrip() == '800'
-    output = u_boot_console.run_command('echo ${gpt_partition_size}')
+    output = ubman.run_command('echo ${gpt_partition_size}')
     assert output.rstrip() == '800'
-    output = u_boot_console.run_command('echo ${gpt_partition_name}')
+    output = ubman.run_command('echo ${gpt_partition_name}')
     assert output.rstrip() == 'part1'
-    output = u_boot_console.run_command('echo ${gpt_partition_entry}')
+    output = ubman.run_command('echo ${gpt_partition_entry}')
     assert output.rstrip() == '1'
-    output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
+    output = ubman.run_command('echo ${gpt_partition_bootable}')
     assert output.rstrip() == '1'
 
-    output = u_boot_console.run_command('gpt setenv host 0 part2')
+    output = ubman.run_command('gpt setenv host 0 part2')
     assert 'success!' in output
-    output = u_boot_console.run_command('echo ${gpt_partition_addr}')
+    output = ubman.run_command('echo ${gpt_partition_addr}')
     assert output.rstrip() == '1000'
-    output = u_boot_console.run_command('echo ${gpt_partition_size}')
+    output = ubman.run_command('echo ${gpt_partition_size}')
     assert output.rstrip() == 'c00'
-    output = u_boot_console.run_command('echo ${gpt_partition_name}')
+    output = ubman.run_command('echo ${gpt_partition_name}')
     assert output.rstrip() == 'part2'
-    output = u_boot_console.run_command('echo ${gpt_partition_entry}')
+    output = ubman.run_command('echo ${gpt_partition_entry}')
     assert output.rstrip() == '2'
-    output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
+    output = ubman.run_command('echo ${gpt_partition_bootable}')
     assert output.rstrip() == '0'
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_save_guid(state_disk_image, u_boot_console):
+def test_gpt_save_guid(state_disk_image, ubman):
     """Test the gpt guid command to save GUID into a string."""
 
-    if u_boot_console.config.buildconfig.get('config_cmd_gpt', 'n') != 'y':
+    if ubman.config.buildconfig.get('config_cmd_gpt', 'n') != 'y':
         pytest.skip('gpt command not supported')
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('gpt guid host 0 newguid')
-    output = u_boot_console.run_command('printenv newguid')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('gpt guid host 0 newguid')
+    output = ubman.run_command('printenv newguid')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_part_type_uuid(state_disk_image, u_boot_console):
+def test_gpt_part_type_uuid(state_disk_image, ubman):
     """Test the gpt partittion type UUID command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('part type host 0:1')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('part type host 0:1')
     assert '0fc63daf-8483-4772-8e79-3d69d8477de4' in output
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_part_type_save_uuid(state_disk_image, u_boot_console):
+def test_gpt_part_type_save_uuid(state_disk_image, ubman):
     """Test the gpt partittion type to save UUID into a string."""
 
-    if u_boot_console.config.buildconfig.get('config_cmd_gpt', 'n') != 'y':
+    if ubman.config.buildconfig.get('config_cmd_gpt', 'n') != 'y':
         pytest.skip('gpt command not supported')
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('part type host 0:1 newguid')
-    output = u_boot_console.run_command('printenv newguid')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('part type host 0:1 newguid')
+    output = ubman.run_command('printenv newguid')
     assert '0fc63daf-8483-4772-8e79-3d69d8477de4' in output
 
 @pytest.mark.boardspec('sandbox')
@@ -257,17 +257,17 @@ def test_gpt_part_type_save_uuid(state_disk_image, u_boot_console):
 @pytest.mark.buildconfigspec('cmd_gpt_rename')
 @pytest.mark.buildconfigspec('cmd_part')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_rename_partition(state_disk_image, u_boot_console):
+def test_gpt_rename_partition(state_disk_image, ubman):
     """Test the gpt rename command to write partition names."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    u_boot_console.run_command('gpt rename host 0 1 first')
-    output = u_boot_console.run_command('gpt read host 0')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    ubman.run_command('gpt rename host 0 1 first')
+    output = ubman.run_command('gpt read host 0')
     assert 'name first' in output
-    u_boot_console.run_command('gpt rename host 0 2 second')
-    output = u_boot_console.run_command('gpt read host 0')
+    ubman.run_command('gpt rename host 0 2 second')
+    output = ubman.run_command('gpt read host 0')
     assert 'name second' in output
-    output = u_boot_console.run_command('part list host 0')
+    output = ubman.run_command('part list host 0')
     assert '0x00000800	0x00000fff	"first"' in output
     assert '0x00001000	0x00001bff	"second"' in output
 
@@ -276,15 +276,15 @@ def test_gpt_rename_partition(state_disk_image, u_boot_console):
 @pytest.mark.buildconfigspec('cmd_gpt_rename')
 @pytest.mark.buildconfigspec('cmd_part')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_swap_partitions(state_disk_image, u_boot_console):
+def test_gpt_swap_partitions(state_disk_image, ubman):
     """Test the gpt swap command to exchange two partition names."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('part list host 0')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('part list host 0')
     assert '0x00000800	0x00000fff	"part1"' in output
     assert '0x00001000	0x00001bff	"part2"' in output
-    u_boot_console.run_command('gpt swap host 0 part1 part2')
-    output = u_boot_console.run_command('part list host 0')
+    ubman.run_command('gpt swap host 0 part1 part2')
+    output = ubman.run_command('part list host 0')
     assert '0x00000800	0x00000fff	"part2"' in output
     assert '0x00001000	0x00001bff	"part1"' in output
 
@@ -292,19 +292,19 @@ def test_gpt_swap_partitions(state_disk_image, u_boot_console):
 @pytest.mark.buildconfigspec('cmd_gpt_rename')
 @pytest.mark.buildconfigspec('cmd_part')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_set_bootable(state_disk_image, u_boot_console):
+def test_gpt_set_bootable(state_disk_image, ubman):
     """Test the gpt set-bootable command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
     parts = ('part2', 'part1')
     for bootable in parts:
-        output = u_boot_console.run_command(f'gpt set-bootable host 0 {bootable}')
+        output = ubman.run_command(f'gpt set-bootable host 0 {bootable}')
         assert 'success!' in output
 
         for p in parts:
-            output = u_boot_console.run_command(f'gpt setenv host 0 {p}')
+            output = ubman.run_command(f'gpt setenv host 0 {p}')
             assert 'success!' in output
-            output = u_boot_console.run_command('echo ${gpt_partition_bootable}')
+            output = ubman.run_command('echo ${gpt_partition_bootable}')
             if p == bootable:
                 assert output.rstrip() == '1'
             else:
@@ -314,37 +314,37 @@ def test_gpt_set_bootable(state_disk_image, u_boot_console):
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.buildconfigspec('cmd_part')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_write(state_disk_image, u_boot_console):
+def test_gpt_write(state_disk_image, ubman):
     """Test the gpt write command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('gpt write host 0 "name=all,size=0"')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('gpt write host 0 "name=all,size=0"')
     assert 'Writing GPT: success!' in output
-    output = u_boot_console.run_command('part list host 0')
+    output = ubman.run_command('part list host 0')
     assert '0x00000022	0x00001fde	"all"' in output
-    output = u_boot_console.run_command('gpt write host 0 "uuid_disk=375a56f7-d6c9-4e81-b5f0-09d41ca89efe;name=first,start=1M,size=1M;name=second,start=0x200000,size=0x180000;"')
+    output = ubman.run_command('gpt write host 0 "uuid_disk=375a56f7-d6c9-4e81-b5f0-09d41ca89efe;name=first,start=1M,size=1M;name=second,start=0x200000,size=0x180000;"')
     assert 'Writing GPT: success!' in output
-    output = u_boot_console.run_command('part list host 0')
+    output = ubman.run_command('part list host 0')
     assert '0x00000800	0x00000fff	"first"' in output
     assert '0x00001000	0x00001bff	"second"' in output
-    output = u_boot_console.run_command('gpt guid host 0')
+    output = ubman.run_command('gpt guid host 0')
     assert '375a56f7-d6c9-4e81-b5f0-09d41ca89efe' in output
 
 @pytest.mark.buildconfigspec('cmd_gpt')
 @pytest.mark.buildconfigspec('cmd_gpt_rename')
 @pytest.mark.buildconfigspec('cmd_part')
 @pytest.mark.requiredtool('sgdisk')
-def test_gpt_transpose(state_disk_image, u_boot_console):
+def test_gpt_transpose(state_disk_image, ubman):
     """Test the gpt transpose command."""
 
-    u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
-    output = u_boot_console.run_command('part list host 0')
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
+    output = ubman.run_command('part list host 0')
     assert '1\t0x00000800\t0x00000fff\t"part1"' in output
     assert '2\t0x00001000\t0x00001bff\t"part2"' in output
 
-    output = u_boot_console.run_command('gpt transpose host 0 1 2')
+    output = ubman.run_command('gpt transpose host 0 1 2')
     assert 'success!' in output
 
-    output = u_boot_console.run_command('part list host 0')
+    output = ubman.run_command('part list host 0')
     assert '2\t0x00000800\t0x00000fff\t"part1"' in output
     assert '1\t0x00001000\t0x00001bff\t"part2"' in output
diff --git a/test/py/tests/test_handoff.py b/test/py/tests/test_handoff.py
index 038f03064a6..c0cfa3b3398 100644
--- a/test/py/tests/test_handoff.py
+++ b/test/py/tests/test_handoff.py
@@ -8,8 +8,8 @@ TEST_HANDOFF_MAGIC = 0x14f93c7b
 
 @pytest.mark.boardspec('sandbox_spl')
 @pytest.mark.buildconfigspec('spl')
-def test_handoff(u_boot_console):
+def test_handoff(ubman):
     """Test that of-platdata can be generated and used in sandbox"""
-    cons = u_boot_console
+    cons = ubman
     response = cons.run_command('sb handoff')
     assert ('SPL handoff magic %x' % TEST_HANDOFF_MAGIC) in response
diff --git a/test/py/tests/test_help.py b/test/py/tests/test_help.py
index 2325ff69229..72f7282478c 100644
--- a/test/py/tests/test_help.py
+++ b/test/py/tests/test_help.py
@@ -4,35 +4,35 @@
 
 import pytest
 
-def test_help(u_boot_console):
+def test_help(ubman):
     """Test that the "help" command can be executed."""
 
-    lines = u_boot_console.run_command('help')
-    if u_boot_console.config.buildconfig.get('config_cmd_2048', 'n') == 'y':
+    lines = ubman.run_command('help')
+    if ubman.config.buildconfig.get('config_cmd_2048', 'n') == 'y':
         assert lines.splitlines()[0] == "2048      - The 2048 game"
     else:
         assert lines.splitlines()[0] == "?         - alias for 'help'"
 
 @pytest.mark.boardspec('sandbox')
-def test_help_no_devicetree(u_boot_console):
+def test_help_no_devicetree(ubman):
     try:
-        cons = u_boot_console
+        cons = ubman
         cons.restart_uboot_with_flags([], use_dtb=False)
         cons.run_command('help')
         output = cons.get_spawn_output().replace('\r', '')
         assert 'print command description/usage' in output
     finally:
         # Restart afterward to get the normal device tree back
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
 
 @pytest.mark.boardspec('sandbox_vpl')
-def test_vpl_help(u_boot_console):
+def test_vpl_help(ubman):
     try:
-        cons = u_boot_console
+        cons = ubman
         cons.restart_uboot()
         cons.run_command('help')
         output = cons.get_spawn_output().replace('\r', '')
         assert 'print command description/usage' in output
     finally:
         # Restart afterward to get the normal device tree back
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
diff --git a/test/py/tests/test_i2c.py b/test/py/tests/test_i2c.py
index 825d0c2e6eb..69b11930ce7 100644
--- a/test/py/tests/test_i2c.py
+++ b/test/py/tests/test_i2c.py
@@ -31,8 +31,8 @@ env__i2c_eeprom_device_test = {
 }
 """
 
-def get_i2c_test_env(u_boot_console):
-    f = u_boot_console.config.env.get("env__i2c_device_test", None)
+def get_i2c_test_env(ubman):
+    f = ubman.config.env.get("env__i2c_device_test", None)
     if not f:
         pytest.skip("No I2C device to test!")
     else:
@@ -43,34 +43,34 @@ def get_i2c_test_env(u_boot_console):
         return bus_list, probe_all
 
 @pytest.mark.buildconfigspec("cmd_i2c")
-def test_i2c_bus(u_boot_console):
-    bus_list, probe = get_i2c_test_env(u_boot_console)
+def test_i2c_bus(ubman):
+    bus_list, probe = get_i2c_test_env(ubman)
     bus = random.choice(bus_list)
     expected_response = f"Bus {bus}:"
-    response = u_boot_console.run_command("i2c bus")
+    response = ubman.run_command("i2c bus")
     assert expected_response in response
 
 @pytest.mark.buildconfigspec("cmd_i2c")
-def test_i2c_dev(u_boot_console):
-    bus_list, probe = get_i2c_test_env(u_boot_console)
+def test_i2c_dev(ubman):
+    bus_list, probe = get_i2c_test_env(ubman)
     expected_response = "Current bus is"
-    response = u_boot_console.run_command("i2c dev")
+    response = ubman.run_command("i2c dev")
     assert expected_response in response
 
 @pytest.mark.buildconfigspec("cmd_i2c")
-def test_i2c_probe(u_boot_console):
-    bus_list, probe = get_i2c_test_env(u_boot_console)
+def test_i2c_probe(ubman):
+    bus_list, probe = get_i2c_test_env(ubman)
     bus = random.choice(bus_list)
     expected_response = f"Setting bus to {bus}"
-    response = u_boot_console.run_command(f"i2c dev {bus}")
+    response = ubman.run_command(f"i2c dev {bus}")
     assert expected_response in response
     expected_response = "Valid chip addresses:"
-    response = u_boot_console.run_command("i2c probe")
+    response = ubman.run_command("i2c probe")
     assert expected_response in response
 
 @pytest.mark.buildconfigspec("cmd_i2c")
-def test_i2c_eeprom(u_boot_console):
-    f = u_boot_console.config.env.get("env__i2c_eeprom_device_test", None)
+def test_i2c_eeprom(ubman):
+    f = ubman.config.env.get("env__i2c_eeprom_device_test", None)
     if not f:
         pytest.skip("No I2C eeprom to test!")
 
@@ -89,17 +89,17 @@ def test_i2c_eeprom(u_boot_console):
         )
 
     # Enable i2c mux bridge
-    u_boot_console.run_command("i2c dev %x" % bus)
-    u_boot_console.run_command("i2c probe")
-    output = u_boot_console.run_command("i2c md %x 0 5" % addr)
+    ubman.run_command("i2c dev %x" % bus)
+    ubman.run_command("i2c probe")
+    output = ubman.run_command("i2c md %x 0 5" % addr)
     assert value in output
 
 @pytest.mark.buildconfigspec("cmd_i2c")
-def test_i2c_probe_all_buses(u_boot_console):
-    bus_list, probe = get_i2c_test_env(u_boot_console)
+def test_i2c_probe_all_buses(ubman):
+    bus_list, probe = get_i2c_test_env(ubman)
     bus = random.choice(bus_list)
     expected_response = f"Bus {bus}:"
-    response = u_boot_console.run_command("i2c bus")
+    response = ubman.run_command("i2c bus")
     assert expected_response in response
 
     # Get all the bus list
@@ -109,8 +109,8 @@ def test_i2c_probe_all_buses(u_boot_console):
 
     for dev in bus_list:
         expected_response = f"Setting bus to {dev}"
-        response = u_boot_console.run_command(f"i2c dev {dev}")
+        response = ubman.run_command(f"i2c dev {dev}")
         assert expected_response in response
         expected_response = "Valid chip addresses:"
-        response = u_boot_console.run_command("i2c probe")
+        response = ubman.run_command("i2c probe")
         assert expected_response in response
diff --git a/test/py/tests/test_kconfig.py b/test/py/tests/test_kconfig.py
index 0b9e6bc3bd1..9aeffa748c4 100644
--- a/test/py/tests/test_kconfig.py
+++ b/test/py/tests/test_kconfig.py
@@ -11,9 +11,9 @@ TMPDIR = '/tmp/test_kconfig'
 
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
-def test_kconfig(u_boot_console):
+def test_kconfig(ubman):
     """Test build failures when IF_ENABLED_INT() option is not enabled"""
-    cons = u_boot_console
+    cons = ubman
 
     # This detects build errors in test/lib/kconfig.c
     out = util.run_and_log(
@@ -24,9 +24,9 @@ def test_kconfig(u_boot_console):
 
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox_spl')
-def test_kconfig_spl(u_boot_console):
+def test_kconfig_spl(ubman):
     """Test build failures when IF_ENABLED_INT() option is not enabled"""
-    cons = u_boot_console
+    cons = ubman
 
     # This detects build errors in test/lib/kconfig_spl.c
     out = util.run_and_log(
diff --git a/test/py/tests/test_log.py b/test/py/tests/test_log.py
index 79808674bbe..292f5b31675 100644
--- a/test/py/tests/test_log.py
+++ b/test/py/tests/test_log.py
@@ -11,7 +11,7 @@ and checks that the output is correct.
 import pytest
 
 @pytest.mark.buildconfigspec('cmd_log')
-def test_log_format(u_boot_console):
+def test_log_format(ubman):
     """Test the 'log format' and 'log rec' commands"""
     def run_with_format(fmt, expected_output):
         """Set up the log format and then write a log record
@@ -25,9 +25,9 @@ def test_log_format(u_boot_console):
         output = cons.run_command('log rec arch notice file.c 123 func msg')
         assert output == expected_output
 
-    cons = u_boot_console
+    cons = ubman
     with cons.log.section('format'):
-        pad = int(u_boot_console.config.buildconfig.get('config_logf_func_pad'))
+        pad = int(ubman.config.buildconfig.get('config_logf_func_pad'))
         padding = ' ' * (pad - len('func'))
 
         run_with_format('all', f'NOTICE.arch,file.c:123-{padding}func() msg')
@@ -42,10 +42,10 @@ def test_log_format(u_boot_console):
 
 @pytest.mark.buildconfigspec('debug_uart')
 @pytest.mark.boardspec('sandbox')
-def test_log_dropped(u_boot_console):
+def test_log_dropped(ubman):
     """Test dropped 'log' message when debug_uart is activated"""
 
-    cons = u_boot_console
+    cons = ubman
     cons.restart_uboot()
     output = cons.get_spawn_output().replace('\r', '')
     assert (not 'debug: main' in output)
diff --git a/test/py/tests/test_lsblk.py b/test/py/tests/test_lsblk.py
index a719a48e6ee..babd4f9528b 100644
--- a/test/py/tests/test_lsblk.py
+++ b/test/py/tests/test_lsblk.py
@@ -7,8 +7,8 @@ import pytest
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('blk')
 @pytest.mark.buildconfigspec('cmd_lsblk')
-def test_lsblk(u_boot_console):
+def test_lsblk(ubman):
     """Test that `lsblk` prints a result which includes `host`."""
-    output = u_boot_console.run_command('lsblk')
+    output = ubman.run_command('lsblk')
     assert "Block Driver" in output
     assert "sandbox_host_blk" in output
diff --git a/test/py/tests/test_md.py b/test/py/tests/test_md.py
index 83e3c546f4a..69e12eb625f 100644
--- a/test/py/tests/test_md.py
+++ b/test/py/tests/test_md.py
@@ -6,31 +6,31 @@ import pytest
 import u_boot_utils
 
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_md(u_boot_console):
+def test_md(ubman):
     """Test that md reads memory as expected, and that memory can be modified
     using the mw command."""
 
-    ram_base = u_boot_utils.find_ram_base(u_boot_console)
+    ram_base = u_boot_utils.find_ram_base(ubman)
     addr = '%08x' % ram_base
     val = 'a5f09876'
     expected_response = addr + ': ' + val
-    u_boot_console.run_command('mw ' + addr + ' 0 10')
-    response = u_boot_console.run_command('md ' + addr + ' 10')
+    ubman.run_command('mw ' + addr + ' 0 10')
+    response = ubman.run_command('md ' + addr + ' 10')
     assert(not (expected_response in response))
-    u_boot_console.run_command('mw ' + addr + ' ' + val)
-    response = u_boot_console.run_command('md ' + addr + ' 10')
+    ubman.run_command('mw ' + addr + ' ' + val)
+    response = ubman.run_command('md ' + addr + ' 10')
     assert(expected_response in response)
 
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_md_repeat(u_boot_console):
+def test_md_repeat(ubman):
     """Test command repeat (via executing an empty command) operates correctly
     for "md"; the command must repeat and dump an incrementing address."""
 
-    ram_base = u_boot_utils.find_ram_base(u_boot_console)
+    ram_base = u_boot_utils.find_ram_base(ubman)
     addr_base = '%08x' % ram_base
     words = 0x10
     addr_repeat = '%08x' % (ram_base + (words * 4))
-    u_boot_console.run_command('md %s %x' % (addr_base, words))
-    response = u_boot_console.run_command('')
+    ubman.run_command('md %s %x' % (addr_base, words))
+    response = ubman.run_command('')
     expected_response = addr_repeat + ': '
     assert(expected_response in response)
diff --git a/test/py/tests/test_mdio.py b/test/py/tests/test_mdio.py
index 89711e70b55..5345f1f4c40 100644
--- a/test/py/tests/test_mdio.py
+++ b/test/py/tests/test_mdio.py
@@ -22,8 +22,8 @@ env__mdio_util_test = {
 }
 """
 
-def get_mdio_test_env(u_boot_console):
-    f = u_boot_console.config.env.get("env__mdio_util_test", None)
+def get_mdio_test_env(ubman):
+    f = ubman.config.env.get("env__mdio_util_test", None)
     if not f or len(f) == 0:
         pytest.skip("No PHY device to test!")
     else:
@@ -31,9 +31,9 @@ def get_mdio_test_env(u_boot_console):
 
 @pytest.mark.buildconfigspec("cmd_mii")
 @pytest.mark.buildconfigspec("phylib")
-def test_mdio_list(u_boot_console):
-    f = get_mdio_test_env(u_boot_console)
-    output = u_boot_console.run_command("mdio list")
+def test_mdio_list(ubman):
+    f = get_mdio_test_env(ubman)
+    output = ubman.run_command("mdio list")
     for dev, val in f.items():
         phy_addr = val.get("phy_addr")
         dev_name = val.get("device_name")
@@ -43,24 +43,24 @@ def test_mdio_list(u_boot_console):
 
 @pytest.mark.buildconfigspec("cmd_mii")
 @pytest.mark.buildconfigspec("phylib")
-def test_mdio_read(u_boot_console):
-    f = get_mdio_test_env(u_boot_console)
-    output = u_boot_console.run_command("mdio list")
+def test_mdio_read(ubman):
+    f = get_mdio_test_env(ubman)
+    output = ubman.run_command("mdio list")
     for dev, val in f.items():
         phy_addr = hex(val.get("phy_addr"))
         dev_name = val.get("device_name")
         reg = hex(val.get("reg"))
         reg_val = hex(val.get("reg_val"))
 
-        output = u_boot_console.run_command(f"mdio read {phy_addr} {reg}")
+        output = ubman.run_command(f"mdio read {phy_addr} {reg}")
         assert f"PHY at address {int(phy_addr, 16):x}:" in output
         assert f"{int(reg, 16):x} - {reg_val}" in output
 
 @pytest.mark.buildconfigspec("cmd_mii")
 @pytest.mark.buildconfigspec("phylib")
-def test_mdio_write(u_boot_console):
-    f = get_mdio_test_env(u_boot_console)
-    output = u_boot_console.run_command("mdio list")
+def test_mdio_write(ubman):
+    f = get_mdio_test_env(ubman)
+    output = ubman.run_command("mdio list")
     for dev, val in f.items():
         phy_addr = hex(val.get("phy_addr"))
         dev_name = val.get("device_name")
@@ -68,12 +68,12 @@ def test_mdio_write(u_boot_console):
         reg_val = hex(val.get("reg_val"))
         wr_val = hex(val.get("write_val"))
 
-        u_boot_console.run_command(f"mdio write {phy_addr} {reg} {wr_val}")
-        output = u_boot_console.run_command(f"mdio read {phy_addr} {reg}")
+        ubman.run_command(f"mdio write {phy_addr} {reg} {wr_val}")
+        output = ubman.run_command(f"mdio read {phy_addr} {reg}")
         assert f"PHY at address {int(phy_addr, 16):x}:" in output
         assert f"{int(reg, 16):x} - {wr_val}" in output
 
-        u_boot_console.run_command(f"mdio write {phy_addr} {reg} {reg_val}")
-        output = u_boot_console.run_command(f"mdio read {phy_addr} {reg}")
+        ubman.run_command(f"mdio write {phy_addr} {reg} {reg_val}")
+        output = ubman.run_command(f"mdio read {phy_addr} {reg}")
         assert f"PHY at address {int(phy_addr, 16):x}:" in output
         assert f"{int(reg, 16):x} - {reg_val}" in output
diff --git a/test/py/tests/test_memtest.py b/test/py/tests/test_memtest.py
index 0618d96f1be..0340edbea5a 100644
--- a/test/py/tests/test_memtest.py
+++ b/test/py/tests/test_memtest.py
@@ -24,8 +24,8 @@ env__memtest = {
 }
 """
 
-def get_memtest_env(u_boot_console):
-    f = u_boot_console.config.env.get("env__memtest", None)
+def get_memtest_env(ubman):
+    f = ubman.config.env.get("env__memtest", None)
     if not f:
         pytest.skip("memtest is not enabled!")
     else:
@@ -38,31 +38,31 @@ def get_memtest_env(u_boot_console):
         return start, end, pattern, iteration, timeout
 
 @pytest.mark.buildconfigspec("cmd_memtest")
-def test_memtest_negative(u_boot_console):
+def test_memtest_negative(ubman):
     """Negative testcase where end address is smaller than starting address and
     pattern is invalid."""
-    start, end, pattern, iteration, timeout = get_memtest_env(u_boot_console)
+    start, end, pattern, iteration, timeout = get_memtest_env(ubman)
     expected_response = "Refusing to do empty test"
-    response = u_boot_console.run_command(
+    response = ubman.run_command(
         f"mtest 2000 1000 {pattern} {hex(iteration)}"
     )
     assert expected_response in response
-    output = u_boot_console.run_command("echo $?")
+    output = ubman.run_command("echo $?")
     assert not output.endswith("0")
-    u_boot_console.run_command(f"mtest {start} {end} 'xyz' {hex(iteration)}")
-    output = u_boot_console.run_command("echo $?")
+    ubman.run_command(f"mtest {start} {end} 'xyz' {hex(iteration)}")
+    output = ubman.run_command("echo $?")
     assert not output.endswith("0")
 
 @pytest.mark.buildconfigspec("cmd_memtest")
-def test_memtest_ddr(u_boot_console):
+def test_memtest_ddr(ubman):
     """Test that md reads memory as expected, and that memory can be modified
     using the mw command."""
-    start, end, pattern, iteration, timeout = get_memtest_env(u_boot_console)
+    start, end, pattern, iteration, timeout = get_memtest_env(ubman)
     expected_response = f"Tested {str(iteration)} iteration(s) with 0 errors."
-    with u_boot_console.temporary_timeout(timeout):
-        response = u_boot_console.run_command(
+    with ubman.temporary_timeout(timeout):
+        response = ubman.run_command(
             f"mtest {start} {end} {pattern} {hex(iteration)}"
         )
         assert expected_response in response
-    output = u_boot_console.run_command("echo $?")
+    output = ubman.run_command("echo $?")
     assert output.endswith("0")
diff --git a/test/py/tests/test_mii.py b/test/py/tests/test_mii.py
index 7b6816d1089..e282add5ee8 100644
--- a/test/py/tests/test_mii.py
+++ b/test/py/tests/test_mii.py
@@ -22,21 +22,21 @@ env__mii_device_test = {
 """
 
 @pytest.mark.buildconfigspec("cmd_mii")
-def test_mii_info(u_boot_console):
-    if u_boot_console.config.env.get("env__mii_device_test_skip", False):
+def test_mii_info(ubman):
+    if ubman.config.env.get("env__mii_device_test_skip", False):
         pytest.skip("MII device test is not enabled!")
     expected_output = "PHY"
-    output = u_boot_console.run_command("mii info")
+    output = ubman.run_command("mii info")
     if not re.search(r"PHY (.+?):", output):
         pytest.skip("PHY device does not exist!")
     assert expected_output in output
 
 @pytest.mark.buildconfigspec("cmd_mii")
-def test_mii_list(u_boot_console):
-    if u_boot_console.config.env.get("env__mii_device_test_skip", False):
+def test_mii_list(ubman):
+    if ubman.config.env.get("env__mii_device_test_skip", False):
         pytest.skip("MII device test is not enabled!")
 
-    f = u_boot_console.config.env.get("env__mii_device_test", None)
+    f = ubman.config.env.get("env__mii_device_test", None)
     if not f:
         pytest.skip("No MII device to test!")
 
@@ -45,7 +45,7 @@ def test_mii_list(u_boot_console):
         pytest.fail("No MII device list provided via env__mii_device_test!")
 
     expected_output = "Current device"
-    output = u_boot_console.run_command("mii device")
+    output = ubman.run_command("mii device")
     mii_devices = (
         re.search(r"MII devices: '(.+)'", output).groups()[0].replace("'", "").split()
     )
@@ -54,39 +54,39 @@ def test_mii_list(u_boot_console):
     assert expected_output in output
 
 @pytest.mark.buildconfigspec("cmd_mii")
-def test_mii_set_device(u_boot_console):
-    test_mii_list(u_boot_console)
-    f = u_boot_console.config.env.get("env__mii_device_test", None)
+def test_mii_set_device(ubman):
+    test_mii_list(ubman)
+    f = ubman.config.env.get("env__mii_device_test", None)
     dev_list = f.get("device_list")
-    output = u_boot_console.run_command("mii device")
+    output = ubman.run_command("mii device")
     current_dev = re.search(r"Current device: '(.+?)'", output).groups()[0]
 
     for dev in dev_list:
-        u_boot_console.run_command(f"mii device {dev}")
-        output = u_boot_console.run_command("echo $?")
+        ubman.run_command(f"mii device {dev}")
+        output = ubman.run_command("echo $?")
         assert output.endswith("0")
 
-    u_boot_console.run_command(f"mii device {current_dev}")
-    output = u_boot_console.run_command("mii device")
+    ubman.run_command(f"mii device {current_dev}")
+    output = ubman.run_command("mii device")
     dev = re.search(r"Current device: '(.+?)'", output).groups()[0]
     assert current_dev == dev
 
 @pytest.mark.buildconfigspec("cmd_mii")
-def test_mii_read(u_boot_console):
-    test_mii_list(u_boot_console)
-    output = u_boot_console.run_command("mii info")
+def test_mii_read(ubman):
+    test_mii_list(ubman)
+    output = ubman.run_command("mii info")
     eth_addr = hex(int(re.search(r"PHY (.+?):", output).groups()[0], 16))
-    u_boot_console.run_command(f"mii read {eth_addr} 0")
-    output = u_boot_console.run_command("echo $?")
+    ubman.run_command(f"mii read {eth_addr} 0")
+    output = ubman.run_command("echo $?")
     assert output.endswith("0")
 
 @pytest.mark.buildconfigspec("cmd_mii")
-def test_mii_dump(u_boot_console):
-    test_mii_list(u_boot_console)
+def test_mii_dump(ubman):
+    test_mii_list(ubman)
     expected_response = "PHY control register"
-    output = u_boot_console.run_command("mii info")
+    output = ubman.run_command("mii info")
     eth_addr = hex(int(re.search(r"PHY (.+?):", output).groups()[0], 16))
-    response = u_boot_console.run_command(f"mii dump {eth_addr} 0")
+    response = ubman.run_command(f"mii dump {eth_addr} 0")
     assert expected_response in response
-    output = u_boot_console.run_command("echo $?")
+    output = ubman.run_command("echo $?")
     assert output.endswith("0")
diff --git a/test/py/tests/test_mmc.py b/test/py/tests/test_mmc.py
index 46240433884..4ecd999c02c 100644
--- a/test/py/tests/test_mmc.py
+++ b/test/py/tests/test_mmc.py
@@ -61,16 +61,16 @@ def setup_mmc_modes(cons):
         # Set mmc mode to default mode (legacy), if it is not defined in env
         mmc_modes = [0]
 
-def setup_mmc(u_boot_console):
-    if u_boot_console.config.env.get('env__mmc_device_test_skip', True):
+def setup_mmc(ubman):
+    if ubman.config.env.get('env__mmc_device_test_skip', True):
         pytest.skip('MMC device test is not enabled')
 
-    setup_mmc_modes(u_boot_console)
+    setup_mmc_modes(ubman)
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_list(u_boot_console):
-    setup_mmc(u_boot_console)
-    output = u_boot_console.run_command('mmc list')
+def test_mmc_list(ubman):
+    setup_mmc(ubman)
+    output = ubman.run_command('mmc list')
     if 'No MMC device available' in output:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -90,7 +90,7 @@ def test_mmc_list(u_boot_console):
     mmc_set_up = True
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_dev(u_boot_console):
+def test_mmc_dev(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -99,7 +99,7 @@ def test_mmc_dev(u_boot_console):
         devices[x]['detected'] = 'yes'
 
         for y in mmc_modes:
-            output = u_boot_console.run_command('mmc dev %d 0 %d' % x, y)
+            output = ubman.run_command('mmc dev %d 0 %d' % x, y)
 
             if 'Card did not respond to voltage select' in output:
                 fail = 1
@@ -115,15 +115,15 @@ def test_mmc_dev(u_boot_console):
             pytest.fail('Card not present')
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmcinfo(u_boot_console):
+def test_mmcinfo(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             for y in mmc_modes:
-                u_boot_console.run_command('mmc dev %d 0 %d' % x, y)
-                output = u_boot_console.run_command('mmcinfo')
+                ubman.run_command('mmc dev %d 0 %d' % x, y)
+                output = ubman.run_command('mmcinfo')
                 if 'busy timeout' in output:
                     pytest.skip('No SD/MMC/eMMC device present')
 
@@ -139,16 +139,16 @@ def test_mmcinfo(u_boot_console):
                     pytest.fail('MMC capacity not recognized')
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_info(u_boot_console):
+def test_mmc_info(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             for y in mmc_modes:
-                u_boot_console.run_command('mmc dev %d 0 %d' % x, y)
+                ubman.run_command('mmc dev %d 0 %d' % x, y)
 
-                output = u_boot_console.run_command('mmc info')
+                output = ubman.run_command('mmc info')
                 assert mmc_modes_name[mmc_modes.index(y)] in output
 
                 obj = re.search(r'Capacity: (\d+|\d+[\.]?\d)', output)
@@ -162,7 +162,7 @@ def test_mmc_info(u_boot_console):
                     pytest.fail('MMC capacity not recognized')
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_rescan(u_boot_console):
+def test_mmc_rescan(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -172,15 +172,15 @@ def test_mmc_rescan(u_boot_console):
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             for y in mmc_modes:
-                u_boot_console.run_command('mmc dev %d 0 %d' % x, y)
-                output = u_boot_console.run_command('mmc rescan')
+                ubman.run_command('mmc dev %d 0 %d' % x, y)
+                output = ubman.run_command('mmc rescan')
                 if output:
                     pytest.fail('mmc rescan has something to check')
-                output = u_boot_console.run_command('echo $?')
+                output = ubman.run_command('echo $?')
                 assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_part(u_boot_console):
+def test_mmc_part(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -189,8 +189,8 @@ def test_mmc_part(u_boot_console):
 
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
-            output = u_boot_console.run_command('mmc part')
+            ubman.run_command('mmc dev %d' % x)
+            output = ubman.run_command('mmc part')
 
             lines = output.split('\n')
             part_fat = []
@@ -209,7 +209,7 @@ def test_mmc_part(u_boot_console):
                         part_fat.append(part_id)
                     elif part_type == '83':
                         print('ext(2/4) detected')
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             'fstype mmc %d:%d' % x, part_id
                         )
                         if 'ext2' in output:
@@ -227,7 +227,7 @@ def test_mmc_part(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_fat')
-def test_mmc_fatls_fatinfo(u_boot_console):
+def test_mmc_fatls_fatinfo(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -246,8 +246,8 @@ def test_mmc_fatls_fatinfo(u_boot_console):
 
             for part in partitions:
                 for y in mmc_modes:
-                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
-                    output = u_boot_console.run_command(
+                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    output = ubman.run_command(
                             'fatls mmc %d:%s' % (x, part))
                     if 'Unrecognized filesystem type' in output:
                         partitions.remove(part)
@@ -255,7 +255,7 @@ def test_mmc_fatls_fatinfo(u_boot_console):
 
                     if not re.search(r'\d file\(s\), \d dir\(s\)', output):
                         pytest.fail('%s read failed on device %d' % (fs.upper, x))
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                             'fatinfo mmc %d:%s' % (x, part))
                     string = 'Filesystem: %s' % fs.upper
                     if re.search(string, output):
@@ -269,7 +269,7 @@ def test_mmc_fatls_fatinfo(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_fat')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_mmc_fatload_fatwrite(u_boot_console):
+def test_mmc_fatload_fatwrite(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -288,14 +288,14 @@ def test_mmc_fatload_fatwrite(u_boot_console):
 
             for part in partitions:
                 for y in mmc_modes:
-                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    addr = u_boot_utils.find_ram_base(ubman)
                     devices[x]['addr_%d' % part] = addr
                     size = random.randint(4, 1 * 1024 * 1024)
                     devices[x]['size_%d' % part] = size
                     # count CRC32
-                    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                    output = ubman.run_command('crc32 %x %x' % (addr, size))
                     m = re.search('==> (.+?)', output)
                     if not m:
                         pytest.fail('CRC32 failed')
@@ -304,7 +304,7 @@ def test_mmc_fatload_fatwrite(u_boot_console):
                     # do write
                     file = '%s_%d' % ('uboot_test', size)
                     devices[x]['file_%d' % part] = file
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         '%swrite mmc %d:%s %x %s %x' % (fs, x, part, addr, file, size)
                     )
                     assert 'Unable to write' not in output
@@ -314,12 +314,12 @@ def test_mmc_fatload_fatwrite(u_boot_console):
                     assert expected_text in output
 
                     alignment = int(
-                        u_boot_console.config.buildconfig.get(
+                        ubman.config.buildconfig.get(
                             'config_sys_cacheline_size', 128
                         )
                     )
                     offset = random.randrange(alignment, 1024, alignment)
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         '%sload mmc %d:%s %x %s' % (fs, x, part, addr + offset, file)
                     )
                     assert 'Invalid FAT entry' not in output
@@ -328,7 +328,7 @@ def test_mmc_fatload_fatwrite(u_boot_console):
                     expected_text = '%d bytes read' % size
                     assert expected_text in output
 
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         'crc32 %x $filesize' % (addr + offset)
                     )
                     assert expected_crc32 in output
@@ -338,7 +338,7 @@ def test_mmc_fatload_fatwrite(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_ext4')
-def test_mmc_ext4ls(u_boot_console):
+def test_mmc_ext4ls(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -357,8 +357,8 @@ def test_mmc_ext4ls(u_boot_console):
 
             for part in partitions:
                 for y in mmc_modes:
-                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
-                    output = u_boot_console.run_command(
+                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    output = ubman.run_command(
                         '%sls mmc %d:%s' % (fs, x, part)
                     )
                     if 'Unrecognized filesystem type' in output:
@@ -373,7 +373,7 @@ def test_mmc_ext4ls(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_ext4')
 @pytest.mark.buildconfigspec('ext4_write')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_mmc_ext4load_ext4write(u_boot_console):
+def test_mmc_ext4load_ext4write(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -392,14 +392,14 @@ def test_mmc_ext4load_ext4write(u_boot_console):
 
             for part in partitions:
                 for y in mmc_modes:
-                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    addr = u_boot_utils.find_ram_base(ubman)
                     devices[x]['addr_%d' % part] = addr
                     size = random.randint(4, 1 * 1024 * 1024)
                     devices[x]['size_%d' % part] = size
                     # count CRC32
-                    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                    output = ubman.run_command('crc32 %x %x' % (addr, size))
                     m = re.search('==> (.+?)', output)
                     if not m:
                         pytest.fail('CRC32 failed')
@@ -409,7 +409,7 @@ def test_mmc_ext4load_ext4write(u_boot_console):
                     # do write
                     file = '%s_%d' % ('uboot_test', size)
                     devices[x]['file_%d' % part] = file
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         '%swrite mmc %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
                     )
                     assert 'Unable to write' not in output
@@ -419,13 +419,13 @@ def test_mmc_ext4load_ext4write(u_boot_console):
                     assert expected_text in output
 
                     offset = random.randrange(128, 1024, 128)
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         '%sload mmc %d:%s %x /%s' % (fs, x, part, addr + offset, file)
                     )
                     expected_text = '%d bytes read' % size
                     assert expected_text in output
 
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         'crc32 %x $filesize' % (addr + offset)
                     )
                     assert expected_crc32 in output
@@ -435,7 +435,7 @@ def test_mmc_ext4load_ext4write(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_ext2')
-def test_mmc_ext2ls(u_boot_console):
+def test_mmc_ext2ls(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -454,9 +454,9 @@ def test_mmc_ext2ls(u_boot_console):
 
             for part in partitions:
                 for y in mmc_modes:
-                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
                     part_detect = 1
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         '%sls mmc %d:%s' % (fs, x, part)
                     )
                     if 'Unrecognized filesystem type' in output:
@@ -472,7 +472,7 @@ def test_mmc_ext2ls(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_ext4')
 @pytest.mark.buildconfigspec('ext4_write')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_mmc_ext2load(u_boot_console):
+def test_mmc_ext2load(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -491,7 +491,7 @@ def test_mmc_ext2load(u_boot_console):
 
             for part in partitions:
                 for y in mmc_modes:
-                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
                     part_detect = 1
                     addr = devices[x]['addr_%d' % part]
                     size = devices[x]['size_%d' % part]
@@ -499,13 +499,13 @@ def test_mmc_ext2load(u_boot_console):
                     file = devices[x]['file_%d' % part]
 
                     offset = random.randrange(128, 1024, 128)
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         '%sload mmc %d:%s %x /%s' % (fs, x, part, addr + offset, file)
                     )
                     expected_text = '%d bytes read' % size
                     assert expected_text in output
 
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         'crc32 %x $filesize' % (addr + offset)
                     )
                     assert expected_crc32 in output
@@ -515,7 +515,7 @@ def test_mmc_ext2load(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
-def test_mmc_ls(u_boot_console):
+def test_mmc_ls(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -534,9 +534,9 @@ def test_mmc_ls(u_boot_console):
 
                 for part in partitions:
                     for y in mmc_modes:
-                        u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                        ubman.run_command('mmc dev %d %d %d' % x, part, y)
                         part_detect = 1
-                        output = u_boot_console.run_command('ls mmc %d:%s' % (x, part))
+                        output = ubman.run_command('ls mmc %d:%s' % (x, part))
                         if re.search(r'No \w+ table on this device', output):
                             pytest.fail(
                                 '%s: Partition table not found %d' % (fs.upper(), x)
@@ -547,7 +547,7 @@ def test_mmc_ls(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
-def test_mmc_load(u_boot_console):
+def test_mmc_load(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -566,7 +566,7 @@ def test_mmc_load(u_boot_console):
 
                 for part in partitions:
                     for y in mmc_modes:
-                        u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                        ubman.run_command('mmc dev %d %d %d' % x, part, y)
                         part_detect = 1
                         addr = devices[x]['addr_%d' % part]
                         size = devices[x]['size_%d' % part]
@@ -574,13 +574,13 @@ def test_mmc_load(u_boot_console):
                         file = devices[x]['file_%d' % part]
 
                         offset = random.randrange(128, 1024, 128)
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             'load mmc %d:%s %x /%s' % (x, part, addr + offset, file)
                         )
                         expected_text = '%d bytes read' % size
                         assert expected_text in output
 
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             'crc32 %x $filesize' % (addr + offset)
                         )
                         assert expected_crc32 in output
@@ -590,7 +590,7 @@ def test_mmc_load(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
-def test_mmc_save(u_boot_console):
+def test_mmc_save(ubman):
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -609,14 +609,14 @@ def test_mmc_save(u_boot_console):
 
                 for part in partitions:
                     for y in mmc_modes:
-                        u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                        ubman.run_command('mmc dev %d %d %d' % x, part, y)
                         part_detect = 1
                         addr = devices[x]['addr_%d' % part]
                         size = 0
                         file = devices[x]['file_%d' % part]
 
                         offset = random.randrange(128, 1024, 128)
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             'save mmc %d:%s %x /%s %d'
                             % (x, part, addr + offset, file, size)
                         )
@@ -629,11 +629,11 @@ def test_mmc_save(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_fat')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_mmc_fat_read_write_files(u_boot_console):
-    test_mmc_list(u_boot_console)
-    test_mmc_dev(u_boot_console)
-    test_mmcinfo(u_boot_console)
-    test_mmc_part(u_boot_console)
+def test_mmc_fat_read_write_files(ubman):
+    test_mmc_list(ubman)
+    test_mmc_dev(ubman)
+    test_mmcinfo(ubman)
+    test_mmc_part(ubman)
     if not mmc_set_up:
         pytest.skip('No SD/MMC/eMMC controller available')
 
@@ -656,9 +656,9 @@ def test_mmc_fat_read_write_files(u_boot_console):
 
             for part in partitions:
                 for y in mmc_modes:
-                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    addr = u_boot_utils.find_ram_base(ubman)
                     count_f = 0
                     addr_l = []
                     size_l = []
@@ -671,7 +671,7 @@ def test_mmc_fat_read_write_files(u_boot_console):
                         size_l.append(random.randint(4, 1 * 1024 * 1024))
 
                         # CRC32 count
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             'crc32 %x %x' % (addr_l[count_f], size_l[count_f])
                         )
                         m = re.search('==> (.+?)', output)
@@ -683,7 +683,7 @@ def test_mmc_fat_read_write_files(u_boot_console):
                         file_l.append(
                             '%s_%d_%d' % ('uboot_test', count_f, size_l[count_f])
                         )
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             '%swrite mmc %d:%s %x %s %x'
                             % (
                                 fs,
@@ -706,14 +706,14 @@ def test_mmc_fat_read_write_files(u_boot_console):
                     count_f = 0
                     while count_f < num_files:
                         alignment = int(
-                            u_boot_console.config.buildconfig.get(
+                            ubman.config.buildconfig.get(
                                 'config_sys_cacheline_size', 128
                             )
                         )
                         offset_l.append(random.randrange(alignment, 1024, alignment))
 
                         # Read operation
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             '%sload mmc %d:%s %x %s'
                             % (
                                 fs,
@@ -729,7 +729,7 @@ def test_mmc_fat_read_write_files(u_boot_console):
                         expected_text = '%d bytes read' % size_l[count_f]
                         assert expected_text in output
 
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             'crc32 %x $filesize' % (addr_l[count_f] + offset_l[count_f])
                         )
                         assert crc32_l[count_f] in output
diff --git a/test/py/tests/test_mmc_rd.py b/test/py/tests/test_mmc_rd.py
index ea652f91361..3c8356f872f 100644
--- a/test/py/tests/test_mmc_rd.py
+++ b/test/py/tests/test_mmc_rd.py
@@ -105,11 +105,11 @@ env__mmc_rd_configs = (
 )
 """
 
-def mmc_dev(u_boot_console, is_emmc, devid, partid):
+def mmc_dev(ubman, is_emmc, devid, partid):
     """Run the "mmc dev" command.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         is_emmc: Whether the device is eMMC
         devid: Device ID
         partid: Partition ID
@@ -122,7 +122,7 @@ def mmc_dev(u_boot_console, is_emmc, devid, partid):
     cmd = 'mmc dev %d' % devid
     if is_emmc:
         cmd += ' %d' % partid
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     assert 'no card present' not in response
     if is_emmc:
         partid_response = '(part %d)' % partid
@@ -132,11 +132,11 @@ def mmc_dev(u_boot_console, is_emmc, devid, partid):
     assert good_response in response
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_dev(u_boot_console, env__mmc_dev_config):
+def test_mmc_dev(ubman, env__mmc_dev_config):
     """Test the "mmc dev" command.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__mmc_dev_config: The single MMC configuration on which
             to run the test. See the file-level comment above for details
             of the format.
@@ -150,14 +150,14 @@ def test_mmc_dev(u_boot_console, env__mmc_dev_config):
     partid = env__mmc_dev_config.get('partid', 0)
 
     # Select MMC device
-    mmc_dev(u_boot_console, is_emmc, devid, partid)
+    mmc_dev(ubman, is_emmc, devid, partid)
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_rescan(u_boot_console, env__mmc_dev_config):
+def test_mmc_rescan(ubman, env__mmc_dev_config):
     """Test the "mmc rescan" command.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__mmc_dev_config: The single MMC configuration on which
             to run the test. See the file-level comment above for details
             of the format.
@@ -171,19 +171,19 @@ def test_mmc_rescan(u_boot_console, env__mmc_dev_config):
     partid = env__mmc_dev_config.get('partid', 0)
 
     # Select MMC device
-    mmc_dev(u_boot_console, is_emmc, devid, partid)
+    mmc_dev(ubman, is_emmc, devid, partid)
 
     # Rescan MMC device
     cmd = 'mmc rescan'
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     assert 'no card present' not in response
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_info(u_boot_console, env__mmc_dev_config):
+def test_mmc_info(ubman, env__mmc_dev_config):
     """Test the "mmc info" command.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__mmc_dev_config: The single MMC configuration on which
             to run the test. See the file-level comment above for details
             of the format.
@@ -201,11 +201,11 @@ def test_mmc_info(u_boot_console, env__mmc_dev_config):
     info_buswidth = env__mmc_dev_config['info_buswidth']
 
     # Select MMC device
-    mmc_dev(u_boot_console, is_emmc, devid, partid)
+    mmc_dev(ubman, is_emmc, devid, partid)
 
     # Read MMC device information
     cmd = 'mmc info'
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     good_response = "Device: %s" % info_device
     assert good_response in response
     good_response = "Bus Speed: %s" % info_speed
@@ -216,11 +216,11 @@ def test_mmc_info(u_boot_console, env__mmc_dev_config):
     assert good_response in response
 
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_mmc_rd(u_boot_console, env__mmc_rd_config):
+def test_mmc_rd(ubman, env__mmc_rd_config):
     """Test the "mmc read" command.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__mmc_rd_config: The single MMC configuration on which
             to run the test. See the file-level comment above for details
             of the format.
@@ -238,32 +238,32 @@ def test_mmc_rd(u_boot_console, env__mmc_rd_config):
     read_duration_max = env__mmc_rd_config.get('read_duration_max', 0)
 
     count_bytes = count_sectors * 512
-    bcfg = u_boot_console.config.buildconfig
+    bcfg = ubman.config.buildconfig
     has_cmd_memory = bcfg.get('config_cmd_memory', 'n') == 'y'
     has_cmd_crc32 = bcfg.get('config_cmd_crc32', 'n') == 'y'
-    ram_base = u_boot_utils.find_ram_base(u_boot_console)
+    ram_base = u_boot_utils.find_ram_base(ubman)
     addr = '0x%08x' % ram_base
 
     # Select MMC device
-    mmc_dev(u_boot_console, is_emmc, devid, partid)
+    mmc_dev(ubman, is_emmc, devid, partid)
 
     # Clear target RAM
     if expected_crc32:
         if has_cmd_memory and has_cmd_crc32:
             cmd = 'mw.b %s 0 0x%x' % (addr, count_bytes)
-            u_boot_console.run_command(cmd)
+            ubman.run_command(cmd)
 
             cmd = 'crc32 %s 0x%x' % (addr, count_bytes)
-            response = u_boot_console.run_command(cmd)
+            response = ubman.run_command(cmd)
             assert expected_crc32 not in response
         else:
-            u_boot_console.log.warning(
+            ubman.log.warning(
                 'CONFIG_CMD_MEMORY or CONFIG_CMD_CRC32 != y: Skipping RAM clear')
 
     # Read data
     cmd = 'mmc read %s %x %x' % (addr, sector, count_sectors)
     tstart = time.time()
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     tend = time.time()
     good_response = 'MMC read: dev # %d, block # %d, count %d ... %d blocks read: OK' % (
         devid, sector, count_sectors, count_sectors)
@@ -273,14 +273,14 @@ def test_mmc_rd(u_boot_console, env__mmc_rd_config):
     if expected_crc32:
         if has_cmd_crc32:
             cmd = 'crc32 %s 0x%x' % (addr, count_bytes)
-            response = u_boot_console.run_command(cmd)
+            response = ubman.run_command(cmd)
             assert expected_crc32 in response
         else:
-            u_boot_console.log.warning('CONFIG_CMD_CRC32 != y: Skipping check')
+            ubman.log.warning('CONFIG_CMD_CRC32 != y: Skipping check')
 
     # Check if the command did not take too long
     if read_duration_max:
         elapsed = tend - tstart
-        u_boot_console.log.info('Reading %d bytes took %f seconds' %
+        ubman.log.info('Reading %d bytes took %f seconds' %
                                 (count_bytes, elapsed))
         assert elapsed <= (read_duration_max - 0.01)
diff --git a/test/py/tests/test_mmc_wr.py b/test/py/tests/test_mmc_wr.py
index 05e5c1ee85d..533bae04fd2 100644
--- a/test/py/tests/test_mmc_wr.py
+++ b/test/py/tests/test_mmc_wr.py
@@ -38,11 +38,11 @@ env__mmc_wr_configs = (
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.buildconfigspec('cmd_memory')
 @pytest.mark.buildconfigspec('cmd_random')
-def test_mmc_wr(u_boot_console, env__mmc_wr_config):
+def test_mmc_wr(ubman, env__mmc_wr_config):
     """Test the "mmc write" command.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__mmc_wr_config: The single MMC configuration on which
             to run the test. See the file-level comment above for details
             of the format.
@@ -60,8 +60,8 @@ def test_mmc_wr(u_boot_console, env__mmc_wr_config):
 
 
     count_bytes = count_sectors * 512
-    bcfg = u_boot_console.config.buildconfig
-    ram_base = u_boot_utils.find_ram_base(u_boot_console)
+    bcfg = ubman.config.buildconfig
+    ram_base = u_boot_utils.find_ram_base(ubman)
     src_addr = '0x%08x' % ram_base
     dst_addr = '0x%08x' % (ram_base + count_bytes)
 
@@ -69,7 +69,7 @@ def test_mmc_wr(u_boot_console, env__mmc_wr_config):
     for i in range(test_iterations):
         # Generate random data
         cmd = 'random %s %x' % (src_addr, count_bytes)
-        response = u_boot_console.run_command(cmd)
+        response = ubman.run_command(cmd)
         good_response = '%d bytes filled with random data' % (count_bytes)
         assert good_response in response
 
@@ -77,7 +77,7 @@ def test_mmc_wr(u_boot_console, env__mmc_wr_config):
         cmd = 'mmc dev %d' % devid
         if is_emmc:
             cmd += ' %d' % partid
-        response = u_boot_console.run_command(cmd)
+        response = ubman.run_command(cmd)
         assert 'no card present' not in response
         if is_emmc:
             partid_response = "(part %d)" % partid
@@ -88,18 +88,18 @@ def test_mmc_wr(u_boot_console, env__mmc_wr_config):
 
         # Write data
         cmd = 'mmc write %s %x %x' % (src_addr, sector, count_sectors)
-        response = u_boot_console.run_command(cmd)
+        response = ubman.run_command(cmd)
         good_response = 'MMC write: dev # %d, block # %d, count %d ... %d blocks written: OK' % (devid, sector, count_sectors, count_sectors)
         assert good_response in response
 
         # Read data
         cmd = 'mmc read %s %x %x' % (dst_addr, sector, count_sectors)
-        response = u_boot_console.run_command(cmd)
+        response = ubman.run_command(cmd)
         good_response = 'MMC read: dev # %d, block # %d, count %d ... %d blocks read: OK' % (devid, sector, count_sectors, count_sectors)
         assert good_response in response
 
         # Compare src and dst data
         cmd = 'cmp.b %s %s %x' % (src_addr, dst_addr, count_bytes)
-        response = u_boot_console.run_command(cmd)
+        response = ubman.run_command(cmd)
         good_response = 'Total of %d byte(s) were the same' % (count_bytes)
         assert good_response in response
diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index ad143c19b0d..52ecf93d41d 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -91,37 +91,37 @@ env__router_on_net = True
 net_set_up = False
 net6_set_up = False
 
-def test_net_pre_commands(u_boot_console):
+def test_net_pre_commands(ubman):
     """Execute any commands required to enable network hardware.
 
     These commands are provided by the boardenv_* file; see the comment at the
     beginning of this file.
     """
 
-    init_usb = u_boot_console.config.env.get('env__net_uses_usb', False)
+    init_usb = ubman.config.env.get('env__net_uses_usb', False)
     if init_usb:
-        u_boot_console.run_command('usb start')
+        ubman.run_command('usb start')
 
-    init_pci = u_boot_console.config.env.get('env__net_uses_pci', False)
+    init_pci = ubman.config.env.get('env__net_uses_pci', False)
     if init_pci:
-        u_boot_console.run_command('pci enum')
+        ubman.run_command('pci enum')
 
-    u_boot_console.run_command('net list')
+    ubman.run_command('net list')
 
 @pytest.mark.buildconfigspec('cmd_dhcp')
-def test_net_dhcp(u_boot_console):
+def test_net_dhcp(ubman):
     """Test the dhcp command.
 
     The boardenv_* file may be used to enable/disable this test; see the
     comment at the beginning of this file.
     """
 
-    test_dhcp = u_boot_console.config.env.get('env__net_dhcp_server', False)
+    test_dhcp = ubman.config.env.get('env__net_dhcp_server', False)
     if not test_dhcp:
         pytest.skip('No DHCP server available')
 
-    u_boot_console.run_command('setenv autoload no')
-    output = u_boot_console.run_command('dhcp')
+    ubman.run_command('setenv autoload no')
+    output = ubman.run_command('dhcp')
     assert 'DHCP client bound to address ' in output
 
     global net_set_up
@@ -129,43 +129,43 @@ def test_net_dhcp(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_dhcp')
 @pytest.mark.buildconfigspec('cmd_mii')
-def test_net_dhcp_abort(u_boot_console):
+def test_net_dhcp_abort(ubman):
     """Test the dhcp command by pressing ctrl+c in the middle of dhcp request
 
     The boardenv_* file may be used to enable/disable this test; see the
     comment at the beginning of this file.
     """
 
-    test_dhcp = u_boot_console.config.env.get('env__net_dhcp_server', False)
+    test_dhcp = ubman.config.env.get('env__net_dhcp_server', False)
     if not test_dhcp:
         pytest.skip('No DHCP server available')
 
-    if u_boot_console.config.env.get('env__dhcp_abort_test_skip', True):
+    if ubman.config.env.get('env__dhcp_abort_test_skip', True):
         pytest.skip('DHCP abort test is not enabled!')
 
-    u_boot_console.run_command('setenv autoload no')
+    ubman.run_command('setenv autoload no')
 
     # Phy reset before running dhcp command
-    output = u_boot_console.run_command('mii device')
+    output = ubman.run_command('mii device')
     if not re.search(r"Current device: '(.+?)'", output):
         pytest.skip('PHY device does not exist!')
     eth_num = re.search(r"Current device: '(.+?)'", output).groups()[0]
-    u_boot_console.run_command(f'mii device {eth_num}')
-    output = u_boot_console.run_command('mii info')
+    ubman.run_command(f'mii device {eth_num}')
+    output = ubman.run_command('mii info')
     eth_addr = hex(int(re.search(r'PHY (.+?):', output).groups()[0], 16))
-    u_boot_console.run_command(f'mii modify {eth_addr} 0 0x8000 0x8000')
+    ubman.run_command(f'mii modify {eth_addr} 0 0x8000 0x8000')
 
-    u_boot_console.run_command('dhcp', wait_for_prompt=False)
+    ubman.run_command('dhcp', wait_for_prompt=False)
     try:
-        u_boot_console.wait_for('Waiting for PHY auto negotiation to complete')
+        ubman.wait_for('Waiting for PHY auto negotiation to complete')
     except:
         pytest.skip('Timeout waiting for PHY auto negotiation to complete')
 
-    u_boot_console.wait_for('done')
+    ubman.wait_for('done')
 
     try:
         # Sending Ctrl-C
-        output = u_boot_console.run_command(
+        output = ubman.run_command(
             chr(3), wait_for_echo=False, send_nl=False
         )
         assert 'TIMEOUT' not in output
@@ -174,49 +174,49 @@ def test_net_dhcp_abort(u_boot_console):
     finally:
         # Provide a time to recover from Abort - if it is not performed
         # There is message like: ethernet@ff0e0000: No link.
-        u_boot_console.run_command('sleep 1')
+        ubman.run_command('sleep 1')
         # Run the dhcp test to setup the network configuration
-        test_net_dhcp(u_boot_console)
+        test_net_dhcp(ubman)
 
 @pytest.mark.buildconfigspec('cmd_dhcp6')
-def test_net_dhcp6(u_boot_console):
+def test_net_dhcp6(ubman):
     """Test the dhcp6 command.
 
     The boardenv_* file may be used to enable/disable this test; see the
     comment at the beginning of this file.
     """
 
-    test_dhcp6 = u_boot_console.config.env.get('env__net_dhcp6_server', False)
+    test_dhcp6 = ubman.config.env.get('env__net_dhcp6_server', False)
     if not test_dhcp6:
         pytest.skip('No DHCP6 server available')
 
-    u_boot_console.run_command('setenv autoload no')
-    output = u_boot_console.run_command('dhcp6')
+    ubman.run_command('setenv autoload no')
+    output = ubman.run_command('dhcp6')
     assert 'DHCP6 client bound to ' in output
 
     global net6_set_up
     net6_set_up = True
 
 @pytest.mark.buildconfigspec('net')
-def test_net_setup_static(u_boot_console):
+def test_net_setup_static(ubman):
     """Set up a static IP configuration.
 
     The configuration is provided by the boardenv_* file; see the comment at
     the beginning of this file.
     """
 
-    env_vars = u_boot_console.config.env.get('env__net_static_env_vars', None)
+    env_vars = ubman.config.env.get('env__net_static_env_vars', None)
     if not env_vars:
         pytest.skip('No static network configuration is defined')
 
     for (var, val) in env_vars:
-        u_boot_console.run_command('setenv %s %s' % (var, val))
+        ubman.run_command('setenv %s %s' % (var, val))
 
     global net_set_up
     net_set_up = True
 
 @pytest.mark.buildconfigspec('cmd_ping')
-def test_net_ping(u_boot_console):
+def test_net_ping(ubman):
     """Test the ping command.
 
     The $serverip (as set up by either test_net_dhcp or test_net_setup_static)
@@ -227,11 +227,11 @@ def test_net_ping(u_boot_console):
     if not net_set_up:
         pytest.skip('Network not initialized')
 
-    output = u_boot_console.run_command('ping $serverip')
+    output = ubman.run_command('ping $serverip')
     assert 'is alive' in output
 
 @pytest.mark.buildconfigspec('IPV6_ROUTER_DISCOVERY')
-def test_net_network_discovery(u_boot_console):
+def test_net_network_discovery(ubman):
     """Test the network discovery feature of IPv6.
 
     An IPv6 network command (ping6 in this case) is run to make U-Boot send a
@@ -244,18 +244,18 @@ def test_net_network_discovery(u_boot_console):
     the beginning of this file.
     """
 
-    router_on_net = u_boot_console.config.env.get('env__router_on_net', False)
+    router_on_net = ubman.config.env.get('env__router_on_net', False)
     if not router_on_net:
         pytest.skip('No router on network')
 
     fake_host_ip = 'fe80::215:5dff:fef6:2ec6'
-    output = u_boot_console.run_command('ping6 ' + fake_host_ip)
+    output = ubman.run_command('ping6 ' + fake_host_ip)
     assert 'ROUTER SOLICITATION 1' in output
     assert 'Set gatewayip6:' in output
     assert '0000:0000:0000:0000:0000:0000:0000:0000' not in output
 
 @pytest.mark.buildconfigspec('cmd_tftpboot')
-def test_net_tftpboot(u_boot_console):
+def test_net_tftpboot(ubman):
     """Test the tftpboot command.
 
     A file is downloaded from the TFTP server, its size and optionally its
@@ -268,7 +268,7 @@ def test_net_tftpboot(u_boot_console):
     if not net_set_up:
         pytest.skip('Network not initialized')
 
-    f = u_boot_console.config.env.get('env__net_tftp_readable_file', None)
+    f = ubman.config.env.get('env__net_tftp_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file to read')
 
@@ -276,9 +276,9 @@ def test_net_tftpboot(u_boot_console):
 
     fn = f['fn']
     if not addr:
-        output = u_boot_console.run_command('tftpboot %s' % (fn))
+        output = ubman.run_command('tftpboot %s' % (fn))
     else:
-        output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+        output = ubman.run_command('tftpboot %x %s' % (addr, fn))
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
     if sz:
@@ -289,14 +289,14 @@ def test_net_tftpboot(u_boot_console):
     if not expected_crc:
         return
 
-    if u_boot_console.config.buildconfig.get('config_cmd_crc32', 'n') != 'y':
+    if ubman.config.buildconfig.get('config_cmd_crc32', 'n') != 'y':
         return
 
-    output = u_boot_console.run_command('crc32 $fileaddr $filesize')
+    output = ubman.run_command('crc32 $fileaddr $filesize')
     assert expected_crc in output
 
 @pytest.mark.buildconfigspec('cmd_nfs')
-def test_net_nfs(u_boot_console):
+def test_net_nfs(ubman):
     """Test the nfs command.
 
     A file is downloaded from the NFS server, its size and optionally its
@@ -309,16 +309,16 @@ def test_net_nfs(u_boot_console):
     if not net_set_up:
         pytest.skip('Network not initialized')
 
-    f = u_boot_console.config.env.get('env__net_nfs_readable_file', None)
+    f = ubman.config.env.get('env__net_nfs_readable_file', None)
     if not f:
         pytest.skip('No NFS readable file to read')
 
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     fn = f['fn']
-    output = u_boot_console.run_command('nfs %x %s' % (addr, fn))
+    output = ubman.run_command('nfs %x %s' % (addr, fn))
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
     if sz:
@@ -329,14 +329,14 @@ def test_net_nfs(u_boot_console):
     if not expected_crc:
         return
 
-    if u_boot_console.config.buildconfig.get('config_cmd_crc32', 'n') != 'y':
+    if ubman.config.buildconfig.get('config_cmd_crc32', 'n') != 'y':
         return
 
-    output = u_boot_console.run_command('crc32 %x $filesize' % addr)
+    output = ubman.run_command('crc32 %x $filesize' % addr)
     assert expected_crc in output
 
 @pytest.mark.buildconfigspec("cmd_pxe")
-def test_net_pxe_get(u_boot_console):
+def test_net_pxe_get(ubman):
     """Test the pxe get command.
 
     A pxe configuration file is downloaded from the TFTP server and interpreted
@@ -349,31 +349,31 @@ def test_net_pxe_get(u_boot_console):
     if not net_set_up:
         pytest.skip("Network not initialized")
 
-    test_net_setup_static(u_boot_console)
+    test_net_setup_static(ubman)
 
-    f = u_boot_console.config.env.get("env__net_pxe_readable_file", None)
+    f = ubman.config.env.get("env__net_pxe_readable_file", None)
     if not f:
         pytest.skip("No PXE readable file to read")
 
     addr = f.get("addr", None)
-    timeout = f.get("timeout", u_boot_console.p.timeout)
+    timeout = f.get("timeout", ubman.p.timeout)
 
     pxeuuid = uuid.uuid1()
-    u_boot_console.run_command(f"setenv pxeuuid {pxeuuid}")
+    ubman.run_command(f"setenv pxeuuid {pxeuuid}")
     expected_text_uuid = f"Retrieving file: pxelinux.cfg/{pxeuuid}"
 
-    ethaddr = u_boot_console.run_command("echo $ethaddr")
+    ethaddr = ubman.run_command("echo $ethaddr")
     ethaddr = ethaddr.replace(':', '-')
     expected_text_ethaddr = f"Retrieving file: pxelinux.cfg/01-{ethaddr}"
 
-    ip = u_boot_console.run_command("echo $ipaddr")
+    ip = ubman.run_command("echo $ipaddr")
     ip = ip.split('.')
     ipaddr_file = "".join(['%02x' % int(x) for x in ip]).upper()
     expected_text_ipaddr = f"Retrieving file: pxelinux.cfg/{ipaddr_file}"
     expected_text_default = f"Retrieving file: pxelinux.cfg/default"
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command("pxe get")
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command("pxe get")
 
     assert "TIMEOUT" not in output
     assert expected_text_uuid in output
@@ -392,7 +392,7 @@ def test_net_pxe_get(u_boot_console):
 @pytest.mark.buildconfigspec("cmd_crc32")
 @pytest.mark.buildconfigspec("cmd_tftpboot")
 @pytest.mark.buildconfigspec("cmd_tftpput")
-def test_net_tftpput(u_boot_console):
+def test_net_tftpput(ubman):
     """Test the tftpput command.
 
     A file is downloaded from the TFTP server and then uploaded to the TFTP
@@ -405,35 +405,35 @@ def test_net_tftpput(u_boot_console):
     if not net_set_up:
         pytest.skip("Network not initialized")
 
-    f = u_boot_console.config.env.get("env__net_tftp_readable_file", None)
+    f = ubman.config.env.get("env__net_tftp_readable_file", None)
     if not f:
         pytest.skip("No TFTP readable file to read")
 
     addr = f.get("addr", None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     sz = f.get("size", None)
-    timeout = f.get("timeout", u_boot_console.p.timeout)
+    timeout = f.get("timeout", ubman.p.timeout)
     fn = f["fn"]
     fnu = f.get("fnu", "_".join([datetime.datetime.now().strftime("%y%m%d%H%M%S"), fn]))
     expected_text = "Bytes transferred = "
     if sz:
         expected_text += "%d" % sz
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command("tftpboot %x %s" % (addr, fn))
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command("tftpboot %x %s" % (addr, fn))
 
     assert "TIMEOUT" not in output
     assert expected_text in output
 
     expected_tftpb_crc = f.get("crc32", None)
 
-    output = u_boot_console.run_command("crc32 $fileaddr $filesize")
+    output = ubman.run_command("crc32 $fileaddr $filesize")
     assert expected_tftpb_crc in output
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command(
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command(
             "tftpput $fileaddr $filesize $serverip:%s" % (fnu)
         )
 
@@ -445,8 +445,8 @@ def test_net_tftpput(u_boot_console):
     assert "Access violation" not in output
     assert expected_text in output
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command("tftpboot %x %s" % (addr, fnu))
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command("tftpboot %x %s" % (addr, fnu))
 
     expected_text = "Bytes transferred = "
     if sz:
@@ -454,5 +454,5 @@ def test_net_tftpput(u_boot_console):
     assert "TIMEOUT" not in output
     assert expected_text in output
 
-    output = u_boot_console.run_command("crc32 $fileaddr $filesize")
+    output = ubman.run_command("crc32 $fileaddr $filesize")
     assert expected_tftpb_crc in output
diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index d7d74356928..d0230808b9f 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -117,26 +117,26 @@ env__pxe_boot_test_skip = False
         initrd rootfs.cpio.gz.u-boot
 """
 
-def setup_networking(u_boot_console):
-    test_net.test_net_dhcp(u_boot_console)
+def setup_networking(ubman):
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
-def setup_tftpboot_boot(u_boot_console):
-    f = u_boot_console.config.env.get('env__net_tftp_bootable_file', None)
+def setup_tftpboot_boot(ubman):
+    f = ubman.config.env.get('env__net_tftp_bootable_file', None)
     if not f:
         pytest.skip('No TFTP bootable file to read')
 
-    setup_networking(u_boot_console)
+    setup_networking(ubman)
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     fn = f['fn']
     timeout = f.get('timeout', 50000)
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command('tftpboot %x %s' % (addr, fn))
 
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
@@ -145,7 +145,7 @@ def setup_tftpboot_boot(u_boot_console):
     assert expected_text in output
 
     expected_crc = f.get('crc32', None)
-    output = u_boot_console.run_command('crc32 %x $filesize' % addr)
+    output = ubman.run_command('crc32 %x $filesize' % addr)
     if expected_crc:
         assert expected_crc in output
 
@@ -157,7 +157,7 @@ def setup_tftpboot_boot(u_boot_console):
     return addr, timeout, pattern, chk_type, chk_pattern, config
 
 @pytest.mark.buildconfigspec('cmd_tftpboot')
-def test_net_tftpboot_boot(u_boot_console):
+def test_net_tftpboot_boot(ubman):
     """Boot the loaded image
 
     A boot file (fit image) is downloaded from the TFTP server and booted using
@@ -167,11 +167,11 @@ def test_net_tftpboot_boot(u_boot_console):
     The details of the file to download are provided by the boardenv_* file;
     see the comment at the beginning of this file.
     """
-    if u_boot_console.config.env.get('env__tftp_boot_test_skip', True):
+    if ubman.config.env.get('env__tftp_boot_test_skip', True):
         pytest.skip('TFTP boot test is not enabled!')
 
     addr, timeout, pattern, chk_type, chk_pattern, imcfg = setup_tftpboot_boot(
-        u_boot_console
+        ubman
     )
 
     if imcfg:
@@ -179,38 +179,38 @@ def test_net_tftpboot_boot(u_boot_console):
     else:
         bootcmd = 'bootm %x' % addr
 
-    with u_boot_console.enable_check(
+    with ubman.enable_check(
         chk_type, chk_pattern
-    ), u_boot_console.temporary_timeout(timeout):
+    ), ubman.temporary_timeout(timeout):
         try:
             # wait_for_prompt=False makes the core code not wait for the U-Boot
             # prompt code to be seen, since it won't be on a successful kernel
             # boot
-            u_boot_console.run_command(bootcmd, wait_for_prompt=False)
+            ubman.run_command(bootcmd, wait_for_prompt=False)
 
             # Wait for boot log pattern
-            u_boot_console.wait_for(pattern)
+            ubman.wait_for(pattern)
         finally:
             # This forces the console object to be shutdown, so any subsequent
             # test will reset the board back into U-Boot. We want to force this
             # no matter whether the kernel boot passed or failed.
-            u_boot_console.drain_console()
-            u_boot_console.cleanup_spawn()
+            ubman.drain_console()
+            ubman.cleanup_spawn()
 
-def setup_pxe_boot(u_boot_console):
-    f = u_boot_console.config.env.get('env__net_pxe_bootable_file', None)
+def setup_pxe_boot(ubman):
+    f = ubman.config.env.get('env__net_pxe_bootable_file', None)
     if not f:
         pytest.skip('No PXE bootable file to read')
 
-    setup_networking(u_boot_console)
-    bootfile = u_boot_console.run_command('echo $bootfile')
+    setup_networking(ubman)
+    bootfile = ubman.run_command('echo $bootfile')
     if not bootfile:
         bootfile = '<NULL>'
 
     return f, bootfile
 
 @pytest.mark.buildconfigspec('cmd_pxe')
-def test_net_pxe_boot(u_boot_console):
+def test_net_pxe_boot(ubman):
     """Test the pxe boot command.
 
     A pxe configuration file is downloaded from the TFTP server and interpreted
@@ -219,19 +219,19 @@ def test_net_pxe_boot(u_boot_console):
     The details of the file to download are provided by the boardenv_* file;
     see the comment at the beginning of this file.
     """
-    if u_boot_console.config.env.get('env__pxe_boot_test_skip', True):
+    if ubman.config.env.get('env__pxe_boot_test_skip', True):
         pytest.skip('PXE boot test is not enabled!')
 
-    f, bootfile = setup_pxe_boot(u_boot_console)
+    f, bootfile = setup_pxe_boot(ubman)
     addr = f.get('addr', None)
-    timeout = f.get('timeout', u_boot_console.p.timeout)
+    timeout = f.get('timeout', ubman.p.timeout)
     fn = f['fn']
 
     if addr:
-        u_boot_console.run_command('setenv pxefile_addr_r %x' % addr)
+        ubman.run_command('setenv pxefile_addr_r %x' % addr)
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command('pxe get')
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command('pxe get')
 
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
@@ -250,18 +250,18 @@ def test_net_pxe_boot(u_boot_console):
     else:
         pxe_boot_cmd = 'pxe boot %x' % addr
 
-    with u_boot_console.enable_check(
+    with ubman.enable_check(
         chk_type, chk_pattern
-    ), u_boot_console.temporary_timeout(timeout):
+    ), ubman.temporary_timeout(timeout):
         try:
-            u_boot_console.run_command(pxe_boot_cmd, wait_for_prompt=False)
-            u_boot_console.wait_for(pattern)
+            ubman.run_command(pxe_boot_cmd, wait_for_prompt=False)
+            ubman.wait_for(pattern)
         finally:
-            u_boot_console.drain_console()
-            u_boot_console.cleanup_spawn()
+            ubman.drain_console()
+            ubman.cleanup_spawn()
 
 @pytest.mark.buildconfigspec('cmd_pxe')
-def test_net_pxe_boot_config(u_boot_console):
+def test_net_pxe_boot_config(ubman):
     """Test the pxe boot command by selecting different combination of labels
 
     A pxe configuration file is downloaded from the TFTP server and interpreted
@@ -270,12 +270,12 @@ def test_net_pxe_boot_config(u_boot_console):
     The details of the file to download are provided by the boardenv_* file;
     see the comment at the beginning of this file.
     """
-    if u_boot_console.config.env.get('env__pxe_boot_test_skip', True):
+    if ubman.config.env.get('env__pxe_boot_test_skip', True):
         pytest.skip('PXE boot test is not enabled!')
 
-    f, bootfile = setup_pxe_boot(u_boot_console)
+    f, bootfile = setup_pxe_boot(ubman)
     addr = f.get('addr', None)
-    timeout = f.get('timeout', u_boot_console.p.timeout)
+    timeout = f.get('timeout', ubman.p.timeout)
     fn = f['fn']
     local_label = f['local_label']
     empty_label = f['empty_label']
@@ -283,10 +283,10 @@ def test_net_pxe_boot_config(u_boot_console):
     exp_str_empty = f['exp_str_empty']
 
     if addr:
-        u_boot_console.run_command('setenv pxefile_addr_r %x' % addr)
+        ubman.run_command('setenv pxefile_addr_r %x' % addr)
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command('pxe get')
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command('pxe get')
 
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
@@ -305,20 +305,20 @@ def test_net_pxe_boot_config(u_boot_console):
     else:
         pxe_boot_cmd = 'pxe boot %x' % addr
 
-    with u_boot_console.enable_check(
+    with ubman.enable_check(
         chk_type, chk_pattern
-    ), u_boot_console.temporary_timeout(timeout):
+    ), ubman.temporary_timeout(timeout):
         try:
-            u_boot_console.run_command(pxe_boot_cmd, wait_for_prompt=False)
+            ubman.run_command(pxe_boot_cmd, wait_for_prompt=False)
 
             # pxe config is loaded where multiple labels are there and need to
             # select particular label to boot and check for expected string
             # In this case, local label is selected and it should look for
             # localcmd env variable and if that variable is not defined it
             # should not boot it and come out to u-boot prompt
-            u_boot_console.wait_for('Enter choice:')
-            u_boot_console.run_command(local_label, wait_for_prompt=False)
-            expected_str = u_boot_console.p.expect([exp_str_local])
+            ubman.wait_for('Enter choice:')
+            ubman.run_command(local_label, wait_for_prompt=False)
+            expected_str = ubman.p.expect([exp_str_local])
             assert (
                 expected_str == 0
             ), f'Expected string: {exp_str_local} did not match!'
@@ -326,21 +326,21 @@ def test_net_pxe_boot_config(u_boot_console):
             # In this case, empty label is selected and it should look for
             # kernel image path and if it is not set it should fail it and load
             # default label to boot
-            u_boot_console.run_command(pxe_boot_cmd, wait_for_prompt=False)
-            u_boot_console.wait_for('Enter choice:')
-            u_boot_console.run_command(empty_label, wait_for_prompt=False)
-            expected_str = u_boot_console.p.expect([exp_str_empty])
+            ubman.run_command(pxe_boot_cmd, wait_for_prompt=False)
+            ubman.wait_for('Enter choice:')
+            ubman.run_command(empty_label, wait_for_prompt=False)
+            expected_str = ubman.p.expect([exp_str_empty])
             assert (
                 expected_str == 0
             ), f'Expected string: {exp_str_empty} did not match!'
 
-            u_boot_console.wait_for(pattern)
+            ubman.wait_for(pattern)
         finally:
-            u_boot_console.drain_console()
-            u_boot_console.cleanup_spawn()
+            ubman.drain_console()
+            ubman.cleanup_spawn()
 
 @pytest.mark.buildconfigspec('cmd_pxe')
-def test_net_pxe_boot_config_invalid(u_boot_console):
+def test_net_pxe_boot_config_invalid(ubman):
     """Test the pxe boot command by selecting invalid label
 
     A pxe configuration file is downloaded from the TFTP server and interpreted
@@ -349,21 +349,21 @@ def test_net_pxe_boot_config_invalid(u_boot_console):
     The details of the file to download are provided by the boardenv_* file;
     see the comment at the beginning of this file.
     """
-    if u_boot_console.config.env.get('env__pxe_boot_test_skip', True):
+    if ubman.config.env.get('env__pxe_boot_test_skip', True):
         pytest.skip('PXE boot test is not enabled!')
 
-    f, bootfile = setup_pxe_boot(u_boot_console)
+    f, bootfile = setup_pxe_boot(ubman)
     addr = f.get('addr', None)
-    timeout = f.get('timeout', u_boot_console.p.timeout)
+    timeout = f.get('timeout', ubman.p.timeout)
     fn = f['fn']
     invalid_label = f['invalid_label']
     exp_str_invalid = f['exp_str_invalid']
 
     if addr:
-        u_boot_console.run_command('setenv pxefile_addr_r %x' % addr)
+        ubman.run_command('setenv pxefile_addr_r %x' % addr)
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command('pxe get')
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command('pxe get')
 
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
@@ -379,22 +379,22 @@ def test_net_pxe_boot_config_invalid(u_boot_console):
     else:
         pxe_boot_cmd = 'pxe boot %x' % addr
 
-    with u_boot_console.temporary_timeout(timeout):
+    with ubman.temporary_timeout(timeout):
         try:
-            u_boot_console.run_command(pxe_boot_cmd, wait_for_prompt=False)
+            ubman.run_command(pxe_boot_cmd, wait_for_prompt=False)
 
             # pxe config is loaded where multiple labels are there and need to
             # select particular label to boot and check for expected string
             # In this case invalid label is selected, it should load invalid
             # label and if it fails it should load the default label to boot
-            u_boot_console.wait_for('Enter choice:')
-            u_boot_console.run_command(invalid_label, wait_for_prompt=False)
-            expected_str = u_boot_console.p.expect([exp_str_invalid])
+            ubman.wait_for('Enter choice:')
+            ubman.run_command(invalid_label, wait_for_prompt=False)
+            expected_str = ubman.p.expect([exp_str_invalid])
             assert (
                 expected_str == 0
             ), f'Expected string: {exp_str_invalid} did not match!'
 
-            u_boot_console.wait_for(pattern)
+            ubman.wait_for(pattern)
         finally:
-            u_boot_console.drain_console()
-            u_boot_console.cleanup_spawn()
+            ubman.drain_console()
+            ubman.cleanup_spawn()
diff --git a/test/py/tests/test_of_migrate.py b/test/py/tests/test_of_migrate.py
index 910f7c05510..3b0fa2f871b 100644
--- a/test/py/tests/test_of_migrate.py
+++ b/test/py/tests/test_of_migrate.py
@@ -61,9 +61,9 @@ def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
 
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
-def test_of_no_migrate(u_boot_console):
+def test_of_no_migrate(ubman):
     """Test sandbox with old boot phase tags like u-boot,dm-pre-proper"""
-    cons = u_boot_console
+    cons = ubman
 
     build_for_migrate(cons, ['bootph-some-ram', 'u-boot,dm-pre-proper'],
                       'sandbox', TMPDIR1)
@@ -80,9 +80,9 @@ def test_of_no_migrate(u_boot_console):
 @pytest.mark.boardspec('sandbox_spl')
 @pytest.mark.boardspec('spl_of_platdata_inst')
 @pytest.mark.boardspec('!sandbox_tpl')
-def test_of_no_migrate_spl(u_boot_console):
+def test_of_no_migrate_spl(ubman):
     """Test sandbox with old boot phase tags like u-boot,dm-spl"""
-    cons = u_boot_console
+    cons = ubman
 
     out = build_for_migrate(cons, ['bootph-pre-ram', 'u-boot,dm-spl'],
                             'sandbox_spl', TMPDIR2)
@@ -94,9 +94,9 @@ def test_of_no_migrate_spl(u_boot_console):
 
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
-def test_of_migrate(u_boot_console):
+def test_of_migrate(ubman):
     """Test sandbox shows a message when tags were migrated"""
-    cons = u_boot_console
+    cons = ubman
 
     build_for_migrate(cons, ['bootph-some-ram', 'u-boot,dm-pre-proper'],
                       'sandbox', TMPDIR3, disable_migrate=False)
diff --git a/test/py/tests/test_ofplatdata.py b/test/py/tests/test_ofplatdata.py
index 51a188454f3..47d6ddc8a50 100644
--- a/test/py/tests/test_ofplatdata.py
+++ b/test/py/tests/test_ofplatdata.py
@@ -6,9 +6,9 @@ import u_boot_utils as util
 
 @pytest.mark.boardspec('sandbox_spl')
 @pytest.mark.buildconfigspec('spl_of_platdata')
-def test_spl_devicetree(u_boot_console):
+def test_spl_devicetree(ubman):
     """Test content of spl device-tree"""
-    cons = u_boot_console
+    cons = ubman
     dtb = cons.config.build_dir + '/spl/u-boot-spl.dtb'
     fdtgrep = cons.config.build_dir + '/tools/fdtgrep'
     output = util.run_and_log(cons, [fdtgrep, '-l', dtb])
diff --git a/test/py/tests/test_optee_rpmb.py b/test/py/tests/test_optee_rpmb.py
index 8a081b5c494..d20d4bc4828 100644
--- a/test/py/tests/test_optee_rpmb.py
+++ b/test/py/tests/test_optee_rpmb.py
@@ -10,11 +10,11 @@ import pytest
 import u_boot_utils as util
 
 @pytest.mark.buildconfigspec('cmd_optee_rpmb')
-def test_optee_rpmb_read_write(u_boot_console):
+def test_optee_rpmb_read_write(ubman):
     """Test OP-TEE RPMB cmd read/write
     """
-    response = u_boot_console.run_command('optee_rpmb write_pvalue test_variable test_value')
+    response = ubman.run_command('optee_rpmb write_pvalue test_variable test_value')
     assert response == 'Wrote 11 bytes'
 
-    response = u_boot_console.run_command('optee_rpmb read_pvalue test_variable 11')
-    assert response == 'Read 11 bytes, value = test_value'
\ No newline at end of file
+    response = ubman.run_command('optee_rpmb read_pvalue test_variable 11')
+    assert response == 'Read 11 bytes, value = test_value'
diff --git a/test/py/tests/test_part.py b/test/py/tests/test_part.py
index 2b5184654db..04c95a6d3cc 100644
--- a/test/py/tests/test_part.py
+++ b/test/py/tests/test_part.py
@@ -7,8 +7,8 @@ import pytest
 @pytest.mark.buildconfigspec('cmd_part')
 @pytest.mark.buildconfigspec('partitions')
 @pytest.mark.buildconfigspec('efi_partition')
-def test_part_types(u_boot_console):
+def test_part_types(ubman):
     """Test that `part types` prints a result which includes `EFI`."""
-    output = u_boot_console.run_command('part types')
+    output = ubman.run_command('part types')
     assert "Supported partition tables:" in output
     assert "EFI" in output
diff --git a/test/py/tests/test_pinmux.py b/test/py/tests/test_pinmux.py
index 794994e12d1..f8c3f0dfbef 100644
--- a/test/py/tests/test_pinmux.py
+++ b/test/py/tests/test_pinmux.py
@@ -4,24 +4,24 @@ import pytest
 import u_boot_utils
 
 @pytest.mark.buildconfigspec('cmd_pinmux')
-def test_pinmux_usage_1(u_boot_console):
+def test_pinmux_usage_1(ubman):
     """Test that 'pinmux' command without parameters displays
     pinmux usage."""
-    output = u_boot_console.run_command('pinmux')
+    output = ubman.run_command('pinmux')
     assert 'Usage:' in output
 
 @pytest.mark.buildconfigspec('cmd_pinmux')
-def test_pinmux_usage_2(u_boot_console):
+def test_pinmux_usage_2(ubman):
     """Test that 'pinmux status' executed without previous "pinmux dev"
     command displays error message."""
-    output = u_boot_console.run_command('pinmux status')
+    output = ubman.run_command('pinmux status')
     assert 'pin-controller device not selected' in output
 
 @pytest.mark.buildconfigspec('cmd_pinmux')
 @pytest.mark.boardspec('sandbox')
-def test_pinmux_status_all(u_boot_console):
+def test_pinmux_status_all(ubman):
     """Test that 'pinmux status -a' displays pin's muxing."""
-    output = u_boot_console.run_command('pinmux status -a')
+    output = ubman.run_command('pinmux status -a')
 
     assert ('pinctrl-gpio:' in output)
     assert ('a5        : gpio output .' in output)
@@ -40,36 +40,36 @@ def test_pinmux_status_all(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_pinmux')
 @pytest.mark.boardspec('sandbox')
-def test_pinmux_list(u_boot_console):
+def test_pinmux_list(ubman):
     """Test that 'pinmux list' returns the pin-controller list."""
-    output = u_boot_console.run_command('pinmux list')
+    output = ubman.run_command('pinmux list')
     assert 'sandbox_pinctrl' in output
 
 @pytest.mark.buildconfigspec('cmd_pinmux')
-def test_pinmux_dev_bad(u_boot_console):
+def test_pinmux_dev_bad(ubman):
     """Test that 'pinmux dev' returns an error when trying to select a
     wrong pin controller."""
     pincontroller = 'bad_pin_controller_name'
-    output = u_boot_console.run_command('pinmux dev ' + pincontroller)
+    output = ubman.run_command('pinmux dev ' + pincontroller)
     expected_output = 'Can\'t get the pin-controller: ' + pincontroller + '!'
     assert (expected_output in output)
 
 @pytest.mark.buildconfigspec('cmd_pinmux')
 @pytest.mark.boardspec('sandbox')
-def test_pinmux_dev(u_boot_console):
+def test_pinmux_dev(ubman):
     """Test that 'pinmux dev' select the wanted pin controller."""
     pincontroller = 'pinctrl'
-    output = u_boot_console.run_command('pinmux dev ' + pincontroller)
+    output = ubman.run_command('pinmux dev ' + pincontroller)
     expected_output = 'dev: ' + pincontroller
     assert (expected_output in output)
 
 @pytest.mark.buildconfigspec('cmd_pinmux')
 @pytest.mark.boardspec('sandbox')
-def test_pinmux_status(u_boot_console):
+def test_pinmux_status(ubman):
     """Test that 'pinmux status' displays selected pincontroller's pin
     muxing descriptions."""
-    u_boot_console.run_command('pinmux dev pinctrl')
-    output = u_boot_console.run_command('pinmux status')
+    ubman.run_command('pinmux dev pinctrl')
+    output = ubman.run_command('pinmux status')
 
     assert (not 'pinctrl-gpio:' in output)
     assert (not 'pinctrl:' in output)
diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 5a35724f60a..69b13fb0e4b 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -15,63 +15,63 @@ PSTORE_PANIC2='test/py/tests/test_pstore_data_panic2.hex'
 PSTORE_CONSOLE='test/py/tests/test_pstore_data_console.hex'
 ADDR=0x01000008
 
-def load_pstore(u_boot_console):
+def load_pstore(ubman):
     """Load PStore records from sample files"""
 
-    output = u_boot_console.run_command_list([
+    output = ubman.run_command_list([
         'host load hostfs - 0x%x %s' % (PSTORE_ADDR,
-            os.path.join(u_boot_console.config.source_dir, PSTORE_PANIC1)),
+            os.path.join(ubman.config.source_dir, PSTORE_PANIC1)),
         'host load hostfs - 0x%x %s' % (PSTORE_ADDR + 4096,
-            os.path.join(u_boot_console.config.source_dir, PSTORE_PANIC2)),
+            os.path.join(ubman.config.source_dir, PSTORE_PANIC2)),
         'host load hostfs - 0x%x %s' % (PSTORE_ADDR + 253 * 4096,
-            os.path.join(u_boot_console.config.source_dir, PSTORE_CONSOLE)),
+            os.path.join(ubman.config.source_dir, PSTORE_CONSOLE)),
         'pstore set 0x%x 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH)])
 
-def checkfile(u_boot_console, path, filesize, checksum):
+def checkfile(ubman, path, filesize, checksum):
     """Check file against MD5 checksum"""
 
-    output = u_boot_console.run_command_list([
+    output = ubman.run_command_list([
         'load hostfs - %x %s' % (ADDR, path),
         'printenv filesize'])
     assert('filesize=%x' % (filesize) in ''.join(output))
 
-    output = u_boot_console.run_command_list([
+    output = ubman.run_command_list([
         'md5sum %x $filesize' % ADDR,
         'setenv filesize'])
     assert(checksum in ''.join(output))
 
 @pytest.mark.buildconfigspec('cmd_pstore')
-def test_pstore_display_all_records(u_boot_console):
+def test_pstore_display_all_records(ubman):
     """Test that pstore displays all records."""
 
-    u_boot_console.run_command('')
-    load_pstore(u_boot_console)
-    response = u_boot_console.run_command('pstore display')
+    ubman.run_command('')
+    load_pstore(ubman)
+    response = ubman.run_command('pstore display')
     assert('**** Dump' in response)
     assert('**** Console' in response)
 
 @pytest.mark.buildconfigspec('cmd_pstore')
-def test_pstore_display_one_record(u_boot_console):
+def test_pstore_display_one_record(ubman):
     """Test that pstore displays only one record."""
 
-    u_boot_console.run_command('')
-    load_pstore(u_boot_console)
-    response = u_boot_console.run_command('pstore display dump 1')
+    ubman.run_command('')
+    load_pstore(ubman)
+    response = ubman.run_command('pstore display dump 1')
     assert('Panic#2 Part1' in response)
     assert('**** Console' not in response)
 
 @pytest.mark.buildconfigspec('cmd_pstore')
-def test_pstore_save_records(u_boot_console):
+def test_pstore_save_records(ubman):
     """Test that pstore saves all records."""
 
     outdir = tempfile.mkdtemp()
 
-    u_boot_console.run_command('')
-    load_pstore(u_boot_console)
-    u_boot_console.run_command('pstore save hostfs - %s' % (outdir))
+    ubman.run_command('')
+    load_pstore(ubman)
+    ubman.run_command('pstore save hostfs - %s' % (outdir))
 
-    checkfile(u_boot_console, '%s/dmesg-ramoops-0' % (outdir), 3798, '8059335ab4cfa62c77324c491659c503')
-    checkfile(u_boot_console, '%s/dmesg-ramoops-1' % (outdir), 4035, '3ff30df3429d81939c75d0070b5187b9')
-    checkfile(u_boot_console, '%s/console-ramoops-0' % (outdir), 4084, 'bb44de4a9b8ebd9b17ae98003287325b')
+    checkfile(ubman, '%s/dmesg-ramoops-0' % (outdir), 3798, '8059335ab4cfa62c77324c491659c503')
+    checkfile(ubman, '%s/dmesg-ramoops-1' % (outdir), 4035, '3ff30df3429d81939c75d0070b5187b9')
+    checkfile(ubman, '%s/console-ramoops-0' % (outdir), 4084, 'bb44de4a9b8ebd9b17ae98003287325b')
 
     shutil.rmtree(outdir)
diff --git a/test/py/tests/test_qfw.py b/test/py/tests/test_qfw.py
index 8b668c9721a..844cd3d9367 100644
--- a/test/py/tests/test_qfw.py
+++ b/test/py/tests/test_qfw.py
@@ -6,20 +6,20 @@
 import pytest
 
 @pytest.mark.buildconfigspec('cmd_qfw')
-def test_qfw_cpus(u_boot_console):
+def test_qfw_cpus(ubman):
     "Test QEMU firmware config reports the CPU count."
 
-    output = u_boot_console.run_command('qfw cpus')
+    output = ubman.run_command('qfw cpus')
     # The actual number varies depending on the board under test, so only
     # assert a non-zero output.
     assert 'cpu(s) online' in output
     assert '0 cpu(s) online' not in output
 
 @pytest.mark.buildconfigspec('cmd_qfw')
-def test_qfw_list(u_boot_console):
+def test_qfw_list(ubman):
     "Test QEMU firmware config lists devices."
 
-    output = u_boot_console.run_command('qfw list')
+    output = ubman.run_command('qfw list')
     # Assert either:
     # 1) 'test-one', from the sandbox driver, or
     # 2) 'bootorder', found in every real QEMU implementation.
diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
index 00fc31da57d..af079a70664 100644
--- a/test/py/tests/test_reset.py
+++ b/test/py/tests/test_reset.py
@@ -24,15 +24,15 @@ env__reset_test = {
 import pytest
 import test_000_version
 
-def setup_reset_env(u_boot_console):
-    if u_boot_console.config.env.get('env__reset_test_skip', False):
+def setup_reset_env(ubman):
+    if ubman.config.env.get('env__reset_test_skip', False):
         pytest.skip('reset test is not enabled')
 
-    output = u_boot_console.run_command('echo $modeboot')
+    output = ubman.run_command('echo $modeboot')
     if output:
         bootmode = output
     else:
-        f = u_boot_console.config.env.get('env__reset_test', None)
+        f = ubman.config.env.get('env__reset_test', None)
         if not f:
             pytest.skip('bootmode cannot be determined')
         bootmode = f.get('bootmode', 'jtagboot')
@@ -41,23 +41,23 @@ def setup_reset_env(u_boot_console):
         pytest.skip('skipping reset test due to jtag bootmode')
 
 @pytest.mark.buildconfigspec('hush_parser')
-def test_reset(u_boot_console):
+def test_reset(ubman):
     """Test the reset command in non-JTAG bootmode.
     It does COLD reset, which resets CPU, DDR and peripherals
     """
-    setup_reset_env(u_boot_console)
-    u_boot_console.run_command('reset', wait_for_reboot=True)
+    setup_reset_env(ubman)
+    ubman.run_command('reset', wait_for_reboot=True)
 
     # Checks the u-boot command prompt's functionality after reset
-    test_000_version.test_version(u_boot_console)
+    test_000_version.test_version(ubman)
 
 @pytest.mark.buildconfigspec('hush_parser')
-def test_reset_w(u_boot_console):
+def test_reset_w(ubman):
     """Test the reset -w command in non-JTAG bootmode.
     It does WARM reset, which resets CPU but keep DDR/peripherals active.
     """
-    setup_reset_env(u_boot_console)
-    u_boot_console.run_command('reset -w', wait_for_reboot=True)
+    setup_reset_env(ubman)
+    ubman.run_command('reset -w', wait_for_reboot=True)
 
     # Checks the u-boot command prompt's functionality after reset
-    test_000_version.test_version(u_boot_console)
+    test_000_version.test_version(ubman)
diff --git a/test/py/tests/test_sandbox_exit.py b/test/py/tests/test_sandbox_exit.py
index 706f5fa3594..9610adf1fe7 100644
--- a/test/py/tests/test_sandbox_exit.py
+++ b/test/py/tests/test_sandbox_exit.py
@@ -7,39 +7,39 @@ import signal
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('sysreset_cmd_poweroff')
-def test_poweroff(u_boot_console):
+def test_poweroff(ubman):
     """Test that the "poweroff" command exits sandbox process."""
 
-    u_boot_console.run_command('poweroff', wait_for_prompt=False)
-    assert(u_boot_console.validate_exited())
+    ubman.run_command('poweroff', wait_for_prompt=False)
+    assert(ubman.validate_exited())
 
 @pytest.mark.boardspec('sandbox')
-def test_ctrl_c(u_boot_console):
+def test_ctrl_c(ubman):
     """Test that sending SIGINT to sandbox causes it to exit."""
 
-    u_boot_console.kill(signal.SIGINT)
-    assert(u_boot_console.validate_exited())
+    ubman.kill(signal.SIGINT)
+    assert(ubman.validate_exited())
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_exception')
 @pytest.mark.buildconfigspec('sandbox_crash_reset')
-def test_exception_reset(u_boot_console):
+def test_exception_reset(ubman):
     """Test that SIGILL causes a reset."""
 
-    u_boot_console.run_command('exception undefined', wait_for_prompt=False)
-    m = u_boot_console.p.expect(['resetting ...', 'U-Boot'])
+    ubman.run_command('exception undefined', wait_for_prompt=False)
+    m = ubman.p.expect(['resetting ...', 'U-Boot'])
     if m != 0:
         raise Exception('SIGILL did not lead to reset')
-    m = u_boot_console.p.expect(['U-Boot', '=>'])
+    m = ubman.p.expect(['U-Boot', '=>'])
     if m != 0:
         raise Exception('SIGILL did not lead to reset')
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_exception')
 @pytest.mark.notbuildconfigspec('sandbox_crash_reset')
-def test_exception_exit(u_boot_console):
+def test_exception_exit(ubman):
     """Test that SIGILL causes a reset."""
 
-    u_boot_console.run_command('exception undefined', wait_for_prompt=False)
-    assert(u_boot_console.validate_exited())
+    ubman.run_command('exception undefined', wait_for_prompt=False)
+    assert(ubman.validate_exited())
diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
index 422b43cb3bc..a6dc394e554 100644
--- a/test/py/tests/test_sandbox_opts.py
+++ b/test/py/tests/test_sandbox_opts.py
@@ -11,9 +11,9 @@ TMPDIR = '/tmp/test_cmdline'
 
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
-def test_sandbox_cmdline(u_boot_console):
+def test_sandbox_cmdline(ubman):
     """Test building sandbox without CONFIG_CMDLINE"""
-    cons = u_boot_console
+    cons = ubman
 
     out = util.run_and_log(
         cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
@@ -21,9 +21,9 @@ def test_sandbox_cmdline(u_boot_console):
 
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
-def test_sandbox_lto(u_boot_console):
+def test_sandbox_lto(ubman):
     """Test building sandbox without CONFIG_LTO"""
-    cons = u_boot_console
+    cons = ubman
 
     out = util.run_and_log(
         cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
diff --git a/test/py/tests/test_saveenv.py b/test/py/tests/test_saveenv.py
index 7faa3bdf93d..019b229d30e 100644
--- a/test/py/tests/test_saveenv.py
+++ b/test/py/tests/test_saveenv.py
@@ -28,15 +28,15 @@ import string
 import uuid
 
 # Setup the env
-def setup_saveenv_env(u_boot_console):
-    if u_boot_console.config.env.get('env__saveenv_test_skip', False):
+def setup_saveenv_env(ubman):
+    if ubman.config.env.get('env__saveenv_test_skip', False):
         pytest.skip('saveenv test is not enabled')
 
-    output = u_boot_console.run_command('echo $modeboot')
+    output = ubman.run_command('echo $modeboot')
     if output:
         bootmode = output
     else:
-        f = u_boot_console.config.env.get('env__saveenv_test', None)
+        f = ubman.config.env.get('env__saveenv_test', None)
         if not f:
             pytest.skip('bootmode cannot be determined')
         bootmode = f.get('bootmode', 'jtagboot')
@@ -45,39 +45,39 @@ def setup_saveenv_env(u_boot_console):
         pytest.skip('skipping saveenv test due to jtag bootmode')
 
 # Check return code
-def ret_code(u_boot_console):
-    return u_boot_console.run_command('echo $?')
+def ret_code(ubman):
+    return ubman.run_command('echo $?')
 
 # Verify env variable
-def check_env(u_boot_console, var_name, var_value):
+def check_env(ubman, var_name, var_value):
     if var_value:
-        output = u_boot_console.run_command(f'printenv {var_name}')
+        output = ubman.run_command(f'printenv {var_name}')
         var_value = str(var_value)
         if (var_value.startswith("'") and var_value.endswith("'")) or (
             var_value.startswith('"') and var_value.endswith('"')
         ):
             var_value = var_value.split(var_value[-1])[1]
         assert var_value in output
-        assert ret_code(u_boot_console).endswith('0')
+        assert ret_code(ubman).endswith('0')
     else:
-        u_boot_console.p.send(f'printenv {var_name}\n')
-        output = u_boot_console.p.expect(['not defined'])
+        ubman.p.send(f'printenv {var_name}\n')
+        output = ubman.p.expect(['not defined'])
         assert output == 0
-        assert ret_code(u_boot_console).endswith('1')
+        assert ret_code(ubman).endswith('1')
 
 # Set env variable
-def set_env(u_boot_console, var_name, var_value):
-    u_boot_console.run_command(f'setenv {var_name} {var_value}')
-    assert ret_code(u_boot_console).endswith('0')
-    check_env(u_boot_console, var_name, var_value)
+def set_env(ubman, var_name, var_value):
+    ubman.run_command(f'setenv {var_name} {var_value}')
+    assert ret_code(ubman).endswith('0')
+    check_env(ubman, var_name, var_value)
 
 @pytest.mark.buildconfigspec('cmd_saveenv')
 @pytest.mark.buildconfigspec('hush_parser')
-def test_saveenv(u_boot_console):
+def test_saveenv(ubman):
     """Test the saveenv command in non-JTAG bootmode.
     It saves the U-Boot environment in persistent storage.
     """
-    setup_saveenv_env(u_boot_console)
+    setup_saveenv_env(ubman)
 
     # Set env for random mac address
     rand_mac = '%02x:%02x:%02x:%02x:%02x:%02x' % (
@@ -88,50 +88,50 @@ def test_saveenv(u_boot_console):
         random.randint(0, 255),
         random.randint(0, 255),
     )
-    set_env(u_boot_console, 'mac_addr', rand_mac)
+    set_env(ubman, 'mac_addr', rand_mac)
 
     # Set env for random IPv4 address
     rand_ipv4 = ipaddress.IPv4Address._string_from_ip_int(
         random.randint(0, ipaddress.IPv4Address._ALL_ONES)
     )
-    set_env(u_boot_console, 'ipv4_addr', rand_ipv4)
+    set_env(ubman, 'ipv4_addr', rand_ipv4)
 
     # Set env for random IPv6 address
     rand_ipv6 = ipaddress.IPv6Address._string_from_ip_int(
         random.randint(0, ipaddress.IPv6Address._ALL_ONES)
     )
-    set_env(u_boot_console, 'ipv6_addr', rand_ipv6)
+    set_env(ubman, 'ipv6_addr', rand_ipv6)
 
     # Set env for random number
     rand_num = random.randrange(1, 10**9)
-    set_env(u_boot_console, 'num_var', rand_num)
+    set_env(ubman, 'num_var', rand_num)
 
     # Set env for uuid
     uuid_str = uuid.uuid4().hex.lower()
-    set_env(u_boot_console, 'uuid_var', uuid_str)
+    set_env(ubman, 'uuid_var', uuid_str)
 
     # Set env for random string including special characters
     sc = "!#%&()*+,-./:;<=>?@[\\]^_`{|}~"
     rand_str = ''.join(
         random.choices(' ' + string.ascii_letters + sc + string.digits, k=300)
     )
-    set_env(u_boot_console, 'str_var', f'"{rand_str}"')
+    set_env(ubman, 'str_var', f'"{rand_str}"')
 
     # Set env for empty string
-    set_env(u_boot_console, 'empty_var', '')
+    set_env(ubman, 'empty_var', '')
 
     # Save the env variables
-    u_boot_console.run_command('saveenv')
-    assert ret_code(u_boot_console).endswith('0')
+    ubman.run_command('saveenv')
+    assert ret_code(ubman).endswith('0')
 
     # Reboot
-    u_boot_console.run_command('reset', wait_for_reboot=True)
+    ubman.run_command('reset', wait_for_reboot=True)
 
     # Verify the saved env variables
-    check_env(u_boot_console, 'mac_addr', rand_mac)
-    check_env(u_boot_console, 'ipv4_addr', rand_ipv4)
-    check_env(u_boot_console, 'ipv6_addr', rand_ipv6)
-    check_env(u_boot_console, 'num_var', rand_num)
-    check_env(u_boot_console, 'uuid_var', uuid_str)
-    check_env(u_boot_console, 'str_var', rand_str)
-    check_env(u_boot_console, 'empty_var', '')
+    check_env(ubman, 'mac_addr', rand_mac)
+    check_env(ubman, 'ipv4_addr', rand_ipv4)
+    check_env(ubman, 'ipv6_addr', rand_ipv6)
+    check_env(ubman, 'num_var', rand_num)
+    check_env(ubman, 'uuid_var', uuid_str)
+    check_env(ubman, 'str_var', rand_str)
+    check_env(ubman, 'empty_var', '')
diff --git a/test/py/tests/test_scp03.py b/test/py/tests/test_scp03.py
index 1a104b365f7..799754ac54b 100644
--- a/test/py/tests/test_scp03.py
+++ b/test/py/tests/test_scp03.py
@@ -14,14 +14,14 @@ import pytest
 import u_boot_utils as util
 
 @pytest.mark.buildconfigspec('cmd_scp03')
-def test_scp03(u_boot_console):
+def test_scp03(ubman):
     """Enable and provision keys with SCP03
     """
 
     success_str1 = "SCP03 is enabled"
     success_str2 = "SCP03 is provisioned"
 
-    response = u_boot_console.run_command('scp03 enable')
+    response = ubman.run_command('scp03 enable')
     assert success_str1 in response
-    response = u_boot_console.run_command('scp03 provision')
+    response = ubman.run_command('scp03 provision')
     assert success_str2 in response
diff --git a/test/py/tests/test_scsi.py b/test/py/tests/test_scsi.py
index 445693cafd7..2a35e47e558 100644
--- a/test/py/tests/test_scsi.py
+++ b/test/py/tests/test_scsi.py
@@ -19,8 +19,8 @@ env__scsi_device_test = {
 }
 """
 
-def scsi_setup(u_boot_console):
-    f = u_boot_console.config.env.get('env__scsi_device_test', None)
+def scsi_setup(ubman):
+    f = ubman.config.env.get('env__scsi_device_test', None)
     if not f:
         pytest.skip('No SCSI device to test')
 
@@ -39,54 +39,54 @@ def scsi_setup(u_boot_console):
     return dev_num, dev_type, dev_size
 
 @pytest.mark.buildconfigspec('cmd_scsi')
-def test_scsi_reset(u_boot_console):
-    dev_num, dev_type, dev_size = scsi_setup(u_boot_console)
-    output = u_boot_console.run_command('scsi reset')
+def test_scsi_reset(ubman):
+    dev_num, dev_type, dev_size = scsi_setup(ubman)
+    output = ubman.run_command('scsi reset')
     assert f'Device {dev_num}:' in output
     assert f'Type: {dev_type}' in output
     assert f'Capacity: {dev_size}' in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_scsi')
-def test_scsi_info(u_boot_console):
-    dev_num, dev_type, dev_size = scsi_setup(u_boot_console)
-    output = u_boot_console.run_command('scsi info')
+def test_scsi_info(ubman):
+    dev_num, dev_type, dev_size = scsi_setup(ubman)
+    output = ubman.run_command('scsi info')
     assert f'Device {dev_num}:' in output
     assert f'Type: {dev_type}' in output
     assert f'Capacity: {dev_size}' in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_scsi')
-def test_scsi_scan(u_boot_console):
-    dev_num, dev_type, dev_size = scsi_setup(u_boot_console)
-    output = u_boot_console.run_command('scsi scan')
+def test_scsi_scan(ubman):
+    dev_num, dev_type, dev_size = scsi_setup(ubman)
+    output = ubman.run_command('scsi scan')
     assert f'Device {dev_num}:' in output
     assert f'Type: {dev_type}' in output
     assert f'Capacity: {dev_size}' in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_scsi')
-def test_scsi_dev(u_boot_console):
-    dev_num, dev_type, dev_size = scsi_setup(u_boot_console)
-    output = u_boot_console.run_command('scsi device')
+def test_scsi_dev(ubman):
+    dev_num, dev_type, dev_size = scsi_setup(ubman)
+    output = ubman.run_command('scsi device')
     assert 'no scsi devices available' not in output
     assert f'device {dev_num}:' in output
     assert f'Type: {dev_type}' in output
     assert f'Capacity: {dev_size}' in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
-    output = u_boot_console.run_command('scsi device %d' % dev_num)
+    output = ubman.run_command('scsi device %d' % dev_num)
     assert 'is now current device' in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_scsi')
-def test_scsi_part(u_boot_console):
-    test_scsi_dev(u_boot_console)
-    output = u_boot_console.run_command('scsi part')
+def test_scsi_part(ubman):
+    test_scsi_dev(ubman)
+    output = ubman.run_command('scsi part')
     assert 'Partition Map for scsi device' in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
diff --git a/test/py/tests/test_semihosting/test_hostfs.py b/test/py/tests/test_semihosting/test_hostfs.py
index 51f6fa7702c..1bead69b507 100644
--- a/test/py/tests/test_semihosting/test_hostfs.py
+++ b/test/py/tests/test_semihosting/test_hostfs.py
@@ -6,28 +6,28 @@
 import pytest
 
 @pytest.mark.buildconfigspec('semihosting')
-def test_semihosting_hostfs(u_boot_console, semihosting_data):
+def test_semihosting_hostfs(ubman, semihosting_data):
     """ Unit test for semihosting
 
     Args:
-        u_boot_console -- U-Boot console
+        ubman -- U-Boot console
         semihosting_data -- Path to the disk image used for testing.
     """
-    response = u_boot_console.run_command(
+    response = ubman.run_command(
         f'load hostfs - $loadaddr {semihosting_data}')
     assert '11 bytes read' in response
 
-    response = u_boot_console.run_command(
+    response = ubman.run_command(
         'crc32 $loadaddr $filesize')
     assert '==> 60cfccfc' in response
 
-    u_boot_console.run_command(
+    ubman.run_command(
         f'save hostfs - $loadaddr {semihosting_data} 11 11')
 
-    response = u_boot_console.run_command(
+    response = ubman.run_command(
         f'load hostfs - $loadaddr {semihosting_data} 4 13')
     assert '4 bytes read' in response
 
-    response = u_boot_console.run_command(
+    response = ubman.run_command(
         'crc32 $loadaddr $filesize')
     assert '==> e29063ea' in response
diff --git a/test/py/tests/test_sf.py b/test/py/tests/test_sf.py
index adf8b7dc893..9c3b8927c0f 100644
--- a/test/py/tests/test_sf.py
+++ b/test/py/tests/test_sf.py
@@ -44,11 +44,11 @@ env__sf_configs = (
 )
 """
 
-def sf_prepare(u_boot_console, env__sf_config):
+def sf_prepare(ubman, env__sf_config):
     """Check global state of the SPI Flash before running any test.
 
    Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__sf_config: The single SPI Flash device configuration on which to
             run the tests.
 
@@ -57,7 +57,7 @@ def sf_prepare(u_boot_console, env__sf_config):
     """
 
     sf_params = {}
-    sf_params['ram_base'] = u_boot_utils.find_ram_base(u_boot_console)
+    sf_params['ram_base'] = u_boot_utils.find_ram_base(ubman)
 
     probe_id = env__sf_config.get('id', 0)
     speed = env__sf_config.get('speed', 0)
@@ -69,7 +69,7 @@ def sf_prepare(u_boot_console, env__sf_config):
 
     cmd = 'sf probe %d %d' % (probe_id, sf_params['speed'])
 
-    output = u_boot_console.run_command(cmd)
+    output = ubman.run_command(cmd)
     assert 'SF: Detected' in output, 'No Flash device available'
 
     m = re.search('page size (.+?) Bytes', output)
@@ -101,12 +101,12 @@ def sf_prepare(u_boot_console, env__sf_config):
 
     return sf_params
 
-def sf_read(u_boot_console, env__sf_config, sf_params):
+def sf_read(ubman, env__sf_config, sf_params):
     """Helper function used to read and compute the CRC32 value of a section of
     SPI Flash memory.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__sf_config: The single SPI Flash device configuration on which to
             run the tests.
         sf_params: SPI Flash parameters.
@@ -122,26 +122,26 @@ def sf_read(u_boot_console, env__sf_config, sf_params):
     crc_expected = env__sf_config.get('crc32', None)
 
     cmd = 'mw.b %08x %02x %x' % (addr, pattern, count)
-    u_boot_console.run_command(cmd)
-    crc_pattern = u_boot_utils.crc32(u_boot_console, addr, count)
+    ubman.run_command(cmd)
+    crc_pattern = u_boot_utils.crc32(ubman, addr, count)
     if crc_expected:
         assert crc_pattern != crc_expected
 
     cmd = 'sf read %08x %08x %x' % (addr, offset, count)
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     assert 'Read: OK' in response, 'Read operation failed'
-    crc_readback = u_boot_utils.crc32(u_boot_console, addr, count)
+    crc_readback = u_boot_utils.crc32(ubman, addr, count)
     assert crc_pattern != crc_readback, 'sf read did not update RAM content.'
     if crc_expected:
         assert crc_readback == crc_expected
 
     return crc_readback
 
-def sf_update(u_boot_console, env__sf_config, sf_params):
+def sf_update(ubman, env__sf_config, sf_params):
     """Helper function used to update a section of SPI Flash memory.
 
    Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__sf_config: The single SPI Flash device configuration on which to
            run the tests.
 
@@ -155,63 +155,63 @@ def sf_update(u_boot_console, env__sf_config, sf_params):
     pattern = int(random.random() * 0xFF)
 
     cmd = 'mw.b %08x %02x %x' % (addr, pattern, count)
-    u_boot_console.run_command(cmd)
-    crc_pattern = u_boot_utils.crc32(u_boot_console, addr, count)
+    ubman.run_command(cmd)
+    crc_pattern = u_boot_utils.crc32(ubman, addr, count)
 
     cmd = 'sf update %08x %08x %x' % (addr, offset, count)
-    u_boot_console.run_command(cmd)
-    crc_readback = sf_read(u_boot_console, env__sf_config, sf_params)
+    ubman.run_command(cmd)
+    crc_readback = sf_read(ubman, env__sf_config, sf_params)
 
     assert crc_readback == crc_pattern
 
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_crc32')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_sf_read(u_boot_console, env__sf_config):
-    sf_params = sf_prepare(u_boot_console, env__sf_config)
-    sf_read(u_boot_console, env__sf_config, sf_params)
+def test_sf_read(ubman, env__sf_config):
+    sf_params = sf_prepare(ubman, env__sf_config)
+    sf_read(ubman, env__sf_config, sf_params)
 
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_crc32')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_sf_read_twice(u_boot_console, env__sf_config):
-    sf_params = sf_prepare(u_boot_console, env__sf_config)
+def test_sf_read_twice(ubman, env__sf_config):
+    sf_params = sf_prepare(ubman, env__sf_config)
 
-    crc1 = sf_read(u_boot_console, env__sf_config, sf_params)
+    crc1 = sf_read(ubman, env__sf_config, sf_params)
     sf_params['ram_base'] += 0x100
-    crc2 = sf_read(u_boot_console, env__sf_config, sf_params)
+    crc2 = sf_read(ubman, env__sf_config, sf_params)
 
     assert crc1 == crc2, 'CRC32 of two successive read operation do not match'
 
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_crc32')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_sf_erase(u_boot_console, env__sf_config):
+def test_sf_erase(ubman, env__sf_config):
     if not env__sf_config.get('writeable', False):
         pytest.skip('Flash config is tagged as not writeable')
 
-    sf_params = sf_prepare(u_boot_console, env__sf_config)
+    sf_params = sf_prepare(ubman, env__sf_config)
     addr = sf_params['ram_base']
     offset = env__sf_config['offset']
     count = sf_params['len']
 
     cmd = 'sf erase %08x %x' % (offset, count)
-    output = u_boot_console.run_command(cmd)
+    output = ubman.run_command(cmd)
     assert 'Erased: OK' in output, 'Erase operation failed'
 
     cmd = 'mw.b %08x ff %x' % (addr, count)
-    u_boot_console.run_command(cmd)
-    crc_ffs = u_boot_utils.crc32(u_boot_console, addr, count)
+    ubman.run_command(cmd)
+    crc_ffs = u_boot_utils.crc32(ubman, addr, count)
 
-    crc_read = sf_read(u_boot_console, env__sf_config, sf_params)
+    crc_read = sf_read(ubman, env__sf_config, sf_params)
     assert crc_ffs == crc_read, 'Unexpected CRC32 after erase operation.'
 
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_crc32')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_sf_update(u_boot_console, env__sf_config):
+def test_sf_update(ubman, env__sf_config):
     if not env__sf_config.get('writeable', False):
         pytest.skip('Flash config is tagged as not writeable')
 
-    sf_params = sf_prepare(u_boot_console, env__sf_config)
-    sf_update(u_boot_console, env__sf_config, sf_params)
+    sf_params = sf_prepare(ubman, env__sf_config)
+    sf_update(ubman, env__sf_config, sf_params)
diff --git a/test/py/tests/test_shell_basics.py b/test/py/tests/test_shell_basics.py
index 68a3f892f6b..97e22af5da5 100644
--- a/test/py/tests/test_shell_basics.py
+++ b/test/py/tests/test_shell_basics.py
@@ -7,39 +7,39 @@ import pytest
 
 pytestmark = pytest.mark.buildconfigspec('cmd_echo')
 
-def test_shell_execute(u_boot_console):
+def test_shell_execute(ubman):
     """Test any shell command."""
 
-    response = u_boot_console.run_command('echo hello')
+    response = ubman.run_command('echo hello')
     assert response.strip() == 'hello'
 
-def test_shell_semicolon_two(u_boot_console):
+def test_shell_semicolon_two(ubman):
     """Test two shell commands separate by a semi-colon."""
 
     cmd = 'echo hello; echo world'
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     # This validation method ignores the exact whitespace between the strings
     assert response.index('hello') < response.index('world')
 
-def test_shell_semicolon_three(u_boot_console):
+def test_shell_semicolon_three(ubman):
     """Test three shell commands separate by a semi-colon, with variable
     expansion dependencies between them."""
 
     cmd = 'setenv list 1; setenv list ${list}2; setenv list ${list}3; ' + \
         'echo ${list}'
-    response = u_boot_console.run_command(cmd)
+    response = ubman.run_command(cmd)
     assert response.strip() == '123'
-    u_boot_console.run_command('setenv list')
+    ubman.run_command('setenv list')
 
-def test_shell_run(u_boot_console):
+def test_shell_run(ubman):
     """Test the "run" shell command."""
 
-    u_boot_console.run_command('setenv foo \'setenv monty 1; setenv python 2\'')
-    u_boot_console.run_command('run foo')
-    response = u_boot_console.run_command('echo ${monty}')
+    ubman.run_command('setenv foo \'setenv monty 1; setenv python 2\'')
+    ubman.run_command('run foo')
+    response = ubman.run_command('echo ${monty}')
     assert response.strip() == '1'
-    response = u_boot_console.run_command('echo ${python}')
+    response = ubman.run_command('echo ${python}')
     assert response.strip() == '2'
-    u_boot_console.run_command('setenv foo')
-    u_boot_console.run_command('setenv monty')
-    u_boot_console.run_command('setenv python')
+    ubman.run_command('setenv foo')
+    ubman.run_command('setenv monty')
+    ubman.run_command('setenv python')
diff --git a/test/py/tests/test_sleep.py b/test/py/tests/test_sleep.py
index 8965fc3fea9..f1bf34e05b2 100644
--- a/test/py/tests/test_sleep.py
+++ b/test/py/tests/test_sleep.py
@@ -19,43 +19,43 @@ env__sleep_margin = 0.25
 
 """
 
-def test_sleep(u_boot_console):
+def test_sleep(ubman):
     """Test the sleep command, and validate that it sleeps for approximately
     the correct amount of time."""
 
-    sleep_skip = u_boot_console.config.env.get('env__sleep_accurate', True)
+    sleep_skip = ubman.config.env.get('env__sleep_accurate', True)
     if not sleep_skip:
         pytest.skip('sleep is not accurate')
 
-    if u_boot_console.config.buildconfig.get('config_cmd_sleep', 'n') != 'y':
+    if ubman.config.buildconfig.get('config_cmd_sleep', 'n') != 'y':
         pytest.skip('sleep command not supported')
 
     # 3s isn't too long, but is enough to cross a few second boundaries.
-    sleep_time = u_boot_console.config.env.get('env__sleep_time', 3)
-    sleep_margin = u_boot_console.config.env.get('env__sleep_margin', 0.25)
+    sleep_time = ubman.config.env.get('env__sleep_time', 3)
+    sleep_margin = ubman.config.env.get('env__sleep_margin', 0.25)
     tstart = time.time()
-    u_boot_console.run_command('sleep %d' % sleep_time)
+    ubman.run_command('sleep %d' % sleep_time)
     tend = time.time()
     elapsed = tend - tstart
     assert elapsed >= (sleep_time - 0.01)
-    if not u_boot_console.config.gdbserver:
+    if not ubman.config.gdbserver:
         # margin is hopefully enough to account for any system overhead.
         assert elapsed < (sleep_time + sleep_margin)
 
 @pytest.mark.buildconfigspec("cmd_time")
-def test_time(u_boot_console):
+def test_time(ubman):
     """Test the time command, and validate that it gives approximately the
     correct amount of command execution time."""
 
-    sleep_skip = u_boot_console.config.env.get("env__sleep_accurate", True)
+    sleep_skip = ubman.config.env.get("env__sleep_accurate", True)
     if not sleep_skip:
         pytest.skip("sleep is not accurate")
 
-    sleep_time = u_boot_console.config.env.get("env__sleep_time", 10)
-    sleep_margin = u_boot_console.config.env.get("env__sleep_margin", 0.25)
-    output = u_boot_console.run_command("time sleep %d" % sleep_time)
+    sleep_time = ubman.config.env.get("env__sleep_time", 10)
+    sleep_margin = ubman.config.env.get("env__sleep_margin", 0.25)
+    output = ubman.run_command("time sleep %d" % sleep_time)
     execute_time = float(output.split()[1])
     assert sleep_time >= (execute_time - 0.01)
-    if not u_boot_console.config.gdbserver:
+    if not ubman.config.gdbserver:
         # margin is hopefully enough to account for any system overhead.
         assert sleep_time < (execute_time + sleep_margin)
diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
index 82b0b689830..8d10e0aeaaa 100644
--- a/test/py/tests/test_smbios.py
+++ b/test/py/tests/test_smbios.py
@@ -7,9 +7,9 @@ import pytest
 @pytest.mark.buildconfigspec('cmd_smbios')
 @pytest.mark.notbuildconfigspec('qfw_smbios')
 @pytest.mark.notbuildconfigspec('sandbox')
-def test_cmd_smbios(u_boot_console):
+def test_cmd_smbios(ubman):
     """Run the smbios command"""
-    output = u_boot_console.run_command('smbios')
+    output = ubman.run_command('smbios')
     assert 'DMI type 127,' in output
 
 @pytest.mark.buildconfigspec('cmd_smbios')
@@ -19,18 +19,18 @@ def test_cmd_smbios(u_boot_console):
 # QEMU v8.2.0 lacks SMBIOS support for RISC-V
 # Once support is available in our Docker image we can remove the constraint.
 @pytest.mark.notbuildconfigspec('riscv')
-def test_cmd_smbios_qemu(u_boot_console):
+def test_cmd_smbios_qemu(ubman):
     """Run the smbios command on QEMU"""
-    output = u_boot_console.run_command('smbios')
+    output = ubman.run_command('smbios')
     assert 'DMI type 1,' in output
     assert 'Manufacturer: QEMU' in output
     assert 'DMI type 127,' in output
 
 @pytest.mark.buildconfigspec('cmd_smbios')
 @pytest.mark.buildconfigspec('sandbox')
-def test_cmd_smbios_sandbox(u_boot_console):
+def test_cmd_smbios_sandbox(ubman):
     """Run the smbios command on the sandbox"""
-    output = u_boot_console.run_command('smbios')
+    output = ubman.run_command('smbios')
     assert 'DMI type 0,' in output
     assert 'String 1: U-Boot' in output
     assert 'DMI type 1,' in output
diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
index bbc311df6d1..30160d06dc6 100644
--- a/test/py/tests/test_source.py
+++ b/test/py/tests/test_source.py
@@ -9,9 +9,9 @@ import u_boot_utils as util
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('cmd_source')
 @pytest.mark.buildconfigspec('fit')
-def test_source(u_boot_console):
+def test_source(ubman):
     # Compile our test script image
-    cons = u_boot_console
+    cons = ubman
     mkimage = os.path.join(cons.config.build_dir, 'tools/mkimage')
     its = os.path.join(cons.config.source_dir, 'test/py/tests/source.its')
     fit = os.path.join(cons.config.build_dir, 'source.itb')
diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index 0abdfa78b76..3dbe2c5d81d 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -71,9 +71,9 @@ EXPECTED_WRITE_ERRORS = [
     'Written: ERROR',
 ]
 
-def get_params_spi(u_boot_console):
+def get_params_spi(ubman):
     ''' Get SPI device test parameters from boardenv file '''
-    f = u_boot_console.config.env.get('env__spi_device_test', None)
+    f = ubman.config.env.get('env__spi_device_test', None)
     if not f:
         pytest.skip('No SPI test device configured')
 
@@ -88,9 +88,9 @@ def get_params_spi(u_boot_console):
 
     return bus, cs, mode, part_name, timeout
 
-def spi_find_freq_range(u_boot_console):
+def spi_find_freq_range(ubman):
     '''Find out minimum and maximum frequnecies that SPI device can operate'''
-    f = u_boot_console.config.env.get('env__spi_device_test', None)
+    f = ubman.config.env.get('env__spi_device_test', None)
     if not f:
         pytest.skip('No SPI test device configured')
 
@@ -107,11 +107,11 @@ def spi_find_freq_range(u_boot_console):
 
     return min_f, max_f, iterations
 
-def spi_pre_commands(u_boot_console, freq):
+def spi_pre_commands(ubman, freq):
     ''' Find out SPI family flash memory parameters '''
-    bus, cs, mode, part_name, timeout = get_params_spi(u_boot_console)
+    bus, cs, mode, part_name, timeout = get_params_spi(ubman)
 
-    output = u_boot_console.run_command(f'sf probe {bus}:{cs} {freq} {mode}')
+    output = ubman.run_command(f'sf probe {bus}:{cs} {freq} {mode}')
     if not 'SF: Detected' in output:
         pytest.fail('No SPI device available')
 
@@ -180,27 +180,27 @@ def get_timeout():
     ''' Get the SPI timeout from spi data '''
     return SPI_DATA['timeout']
 
-def spi_erase_block(u_boot_console, erase_size, total_size):
+def spi_erase_block(ubman, erase_size, total_size):
     ''' Erase SPI flash memory block wise '''
     for start in range(0, total_size, erase_size):
-        output = u_boot_console.run_command(f'sf erase {hex(start)} {hex(erase_size)}')
+        output = ubman.run_command(f'sf erase {hex(start)} {hex(erase_size)}')
         assert EXPECTED_ERASE in output
 
 @pytest.mark.buildconfigspec('cmd_sf')
-def test_spi_erase_block(u_boot_console):
+def test_spi_erase_block(ubman):
     ''' Test case to check SPI erase functionality by erasing memory regions
     block-wise '''
 
-    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    min_f, max_f, loop = spi_find_freq_range(ubman)
     i = 0
     while i < loop:
-        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
-        spi_erase_block(u_boot_console, get_erase_size(), get_total_size())
+        spi_pre_commands(ubman, random.randint(min_f, max_f))
+        spi_erase_block(ubman, get_erase_size(), get_total_size())
         i = i + 1
 
-def spi_write_twice(u_boot_console, page_size, erase_size, total_size, timeout):
+def spi_write_twice(ubman, page_size, erase_size, total_size, timeout):
     ''' Random write till page size, random till size and full size '''
-    addr = u_boot_utils.find_ram_base(u_boot_console)
+    addr = u_boot_utils.find_ram_base(ubman)
 
     old_size = 0
     for size in (
@@ -212,7 +212,7 @@ def spi_write_twice(u_boot_console, page_size, erase_size, total_size, timeout):
         offset = offset & ~3
         size = size & ~3
         size = size - old_size
-        output = u_boot_console.run_command(f'crc32 {hex(addr + total_size)} {hex(size)}')
+        output = ubman.run_command(f'crc32 {hex(addr + total_size)} {hex(size)}')
         m = re.search('==> (.+?)$', output)
         if not m:
             pytest.fail('CRC32 failed')
@@ -230,23 +230,23 @@ def spi_write_twice(u_boot_console, page_size, erase_size, total_size, timeout):
         eraseoffset *= erase_size
 
         timeout = 100000000
-        with u_boot_console.temporary_timeout(timeout):
-            output = u_boot_console.run_command(
+        with ubman.temporary_timeout(timeout):
+            output = ubman.run_command(
                 f'sf erase {hex(eraseoffset)} {hex(erasesize)}'
             )
             assert EXPECTED_ERASE in output
 
-        with u_boot_console.temporary_timeout(timeout):
-            output = u_boot_console.run_command(
+        with ubman.temporary_timeout(timeout):
+            output = ubman.run_command(
                 f'sf write {hex(addr + total_size)} {hex(old_size)} {hex(size)}'
             )
             assert EXPECTED_WRITE in output
-        with u_boot_console.temporary_timeout(timeout):
-            output = u_boot_console.run_command(
+        with ubman.temporary_timeout(timeout):
+            output = ubman.run_command(
                 f'sf read {hex(addr + total_size + offset)} {hex(old_size)} {hex(size)}'
             )
             assert EXPECTED_READ in output
-        output = u_boot_console.run_command(
+        output = ubman.run_command(
             f'crc32 {hex(addr + total_size + offset)} {hex(size)}'
         )
         assert expected_crc32 in output
@@ -255,14 +255,14 @@ def spi_write_twice(u_boot_console, page_size, erase_size, total_size, timeout):
 @pytest.mark.buildconfigspec('cmd_bdi')
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_spi_write_twice(u_boot_console):
+def test_spi_write_twice(ubman):
     ''' Test to write data with random size twice for SPI '''
-    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    min_f, max_f, loop = spi_find_freq_range(ubman)
     i = 0
     while i < loop:
-        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        spi_pre_commands(ubman, random.randint(min_f, max_f))
         spi_write_twice(
-            u_boot_console,
+            ubman,
             get_page_size(),
             get_erase_size(),
             get_total_size(),
@@ -270,12 +270,12 @@ def test_spi_write_twice(u_boot_console):
         )
         i = i + 1
 
-def spi_write_continues(u_boot_console, page_size, erase_size, total_size, timeout):
+def spi_write_continues(ubman, page_size, erase_size, total_size, timeout):
     ''' Write with random size of data to continue SPI write case '''
-    spi_erase_block(u_boot_console, erase_size, total_size)
-    addr = u_boot_utils.find_ram_base(u_boot_console)
+    spi_erase_block(ubman, erase_size, total_size)
+    addr = u_boot_utils.find_ram_base(ubman)
 
-    output = u_boot_console.run_command(f'crc32 {hex(addr + 0x10000)} {hex(total_size)}')
+    output = ubman.run_command(f'crc32 {hex(addr + 0x10000)} {hex(total_size)}')
     m = re.search('==> (.+?)$', output)
     if not m:
         pytest.fail('CRC32 failed')
@@ -289,20 +289,20 @@ def spi_write_continues(u_boot_console, page_size, erase_size, total_size, timeo
     ):
         size = size & ~3
         size = size - old_size
-        with u_boot_console.temporary_timeout(timeout):
-            output = u_boot_console.run_command(
+        with ubman.temporary_timeout(timeout):
+            output = ubman.run_command(
                 f'sf write {hex(addr + 0x10000 + old_size)} {hex(old_size)} {hex(size)}'
             )
             assert EXPECTED_WRITE in output
         old_size += size
 
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command(
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command(
             f'sf read {hex(addr + 0x10000 + total_size)} 0 {hex(total_size)}'
         )
         assert EXPECTED_READ in output
 
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         f'crc32 {hex(addr + 0x10000 + total_size)} {hex(total_size)}'
     )
     assert expected_crc32 in output
@@ -310,14 +310,14 @@ def spi_write_continues(u_boot_console, page_size, erase_size, total_size, timeo
 @pytest.mark.buildconfigspec('cmd_bdi')
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_spi_write_continues(u_boot_console):
+def test_spi_write_continues(ubman):
     ''' Test to write more random size data for SPI '''
-    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    min_f, max_f, loop = spi_find_freq_range(ubman)
     i = 0
     while i < loop:
-        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        spi_pre_commands(ubman, random.randint(min_f, max_f))
         spi_write_twice(
-            u_boot_console,
+            ubman,
             get_page_size(),
             get_erase_size(),
             get_total_size(),
@@ -325,28 +325,28 @@ def test_spi_write_continues(u_boot_console):
         )
         i = i + 1
 
-def spi_read_twice(u_boot_console, page_size, total_size, timeout):
+def spi_read_twice(ubman, page_size, total_size, timeout):
     ''' Read the whole SPI flash twice, random_size till full flash size,
     random till page size '''
     for size in random.randint(4, page_size), random.randint(4, total_size), total_size:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
         size = size & ~3
-        with u_boot_console.temporary_timeout(timeout):
-            output = u_boot_console.run_command(
+        with ubman.temporary_timeout(timeout):
+            output = ubman.run_command(
                 f'sf read {hex(addr + total_size)} 0 {hex(size)}'
             )
             assert EXPECTED_READ in output
-        output = u_boot_console.run_command(f'crc32 {hex(addr + total_size)} {hex(size)}')
+        output = ubman.run_command(f'crc32 {hex(addr + total_size)} {hex(size)}')
         m = re.search('==> (.+?)$', output)
         if not m:
             pytest.fail('CRC32 failed')
         expected_crc32 = m.group(1)
-        with u_boot_console.temporary_timeout(timeout):
-            output = u_boot_console.run_command(
+        with ubman.temporary_timeout(timeout):
+            output = ubman.run_command(
                 f'sf read {hex(addr + total_size + 10)} 0 {hex(size)}'
             )
             assert EXPECTED_READ in output
-        output = u_boot_console.run_command(
+        output = ubman.run_command(
             f'crc32 {hex(addr + total_size + 10)} {hex(size)}'
         )
         assert expected_crc32 in output
@@ -354,49 +354,49 @@ def spi_read_twice(u_boot_console, page_size, total_size, timeout):
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_bdi')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_spi_read_twice(u_boot_console):
+def test_spi_read_twice(ubman):
     ''' Test to read random data twice from SPI '''
-    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    min_f, max_f, loop = spi_find_freq_range(ubman)
     i = 0
     while i < loop:
-        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
-        spi_read_twice(u_boot_console, get_page_size(), get_total_size(), get_timeout())
+        spi_pre_commands(ubman, random.randint(min_f, max_f))
+        spi_read_twice(ubman, get_page_size(), get_total_size(), get_timeout())
         i = i + 1
 
-def spi_erase_all(u_boot_console, total_size, timeout):
+def spi_erase_all(ubman, total_size, timeout):
     ''' Erase the full chip SPI '''
     start = 0
-    with u_boot_console.temporary_timeout(timeout):
-        output = u_boot_console.run_command(f'sf erase {start} {hex(total_size)}')
+    with ubman.temporary_timeout(timeout):
+        output = ubman.run_command(f'sf erase {start} {hex(total_size)}')
         assert EXPECTED_ERASE in output
 
 @pytest.mark.buildconfigspec('cmd_sf')
-def test_spi_erase_all(u_boot_console):
+def test_spi_erase_all(ubman):
     ''' Test to check full chip erase for SPI '''
-    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
+    min_f, max_f, loop = spi_find_freq_range(ubman)
     i = 0
     while i < loop:
-        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
-        spi_erase_all(u_boot_console, get_total_size(), get_timeout())
+        spi_pre_commands(ubman, random.randint(min_f, max_f))
+        spi_erase_all(ubman, get_total_size(), get_timeout())
         i = i + 1
 
 def flash_ops(
-    u_boot_console, ops, start, size, offset=0, exp_ret=0, exp_str='', not_exp_str=''
+    ubman, ops, start, size, offset=0, exp_ret=0, exp_str='', not_exp_str=''
 ):
     ''' Flash operations: erase, write and read '''
 
-    f = u_boot_console.config.env.get('env__spi_device_test', None)
+    f = ubman.config.env.get('env__spi_device_test', None)
     if not f:
         timeout = 1000000
 
     timeout = f.get('timeout', 1000000)
 
     if ops == 'erase':
-        with u_boot_console.temporary_timeout(timeout):
-            output = u_boot_console.run_command(f'sf erase {hex(start)} {hex(size)}')
+        with ubman.temporary_timeout(timeout):
+            output = ubman.run_command(f'sf erase {hex(start)} {hex(size)}')
     else:
-        with u_boot_console.temporary_timeout(timeout):
-            output = u_boot_console.run_command(
+        with ubman.temporary_timeout(timeout):
+            output = ubman.run_command(
                 f'sf {ops} {hex(offset)} {hex(start)} {hex(size)}'
             )
 
@@ -405,15 +405,15 @@ def flash_ops(
     if not_exp_str:
         assert not_exp_str not in output
 
-    ret_code = u_boot_console.run_command('echo $?')
+    ret_code = ubman.run_command('echo $?')
     if exp_ret >= 0:
         assert ret_code.endswith(str(exp_ret))
 
     return output, ret_code
 
-def spi_unlock_exit(u_boot_console, addr, size):
+def spi_unlock_exit(ubman, addr, size):
     ''' Unlock the flash before making it fail '''
-    u_boot_console.run_command(f'sf protect unlock {hex(addr)} {hex(size)}')
+    ubman.run_command(f'sf protect unlock {hex(addr)} {hex(size)}')
     assert False, 'FAIL: Flash lock is unable to protect the data!'
 
 def find_prot_region(lock_addr, lock_size):
@@ -442,49 +442,49 @@ def find_prot_region(lock_addr, lock_size):
 
     return prot_start, prot_size, unprot_start, unprot_size
 
-def protect_ops(u_boot_console, lock_addr, lock_size, ops="unlock"):
+def protect_ops(ubman, lock_addr, lock_size, ops="unlock"):
     ''' Run the command to lock or Unlock the flash '''
-    u_boot_console.run_command(f'sf protect {ops} {hex(lock_addr)} {hex(lock_size)}')
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command(f'sf protect {ops} {hex(lock_addr)} {hex(lock_size)}')
+    output = ubman.run_command('echo $?')
     if ops == "lock" and not output.endswith('0'):
-        u_boot_console.run_command(f'sf protect unlock {hex(lock_addr)} {hex(lock_size)}')
+        ubman.run_command(f'sf protect unlock {hex(lock_addr)} {hex(lock_size)}')
         assert False, "sf protect lock command exits with non-zero return code"
     assert output.endswith('0')
 
-def erase_write_ops(u_boot_console, start, size):
+def erase_write_ops(ubman, start, size):
     ''' Basic erase and write operation for flash '''
-    addr = u_boot_utils.find_ram_base(u_boot_console)
-    flash_ops(u_boot_console, 'erase', start, size, 0, 0, EXPECTED_ERASE)
-    flash_ops(u_boot_console, 'write', start, size, addr, 0, EXPECTED_WRITE)
+    addr = u_boot_utils.find_ram_base(ubman)
+    flash_ops(ubman, 'erase', start, size, 0, 0, EXPECTED_ERASE)
+    flash_ops(ubman, 'write', start, size, addr, 0, EXPECTED_WRITE)
 
-def spi_lock_unlock(u_boot_console, lock_addr, lock_size):
+def spi_lock_unlock(ubman, lock_addr, lock_size):
     ''' Lock unlock operations for SPI family flash '''
-    addr = u_boot_utils.find_ram_base(u_boot_console)
+    addr = u_boot_utils.find_ram_base(ubman)
     erase_size = get_erase_size()
 
     # Find the protected/un-protected region
     prot_start, prot_size, unprot_start, unprot_size = find_prot_region(lock_addr, lock_size)
 
     # Check erase/write operation before locking
-    erase_write_ops(u_boot_console, prot_start, prot_size)
+    erase_write_ops(ubman, prot_start, prot_size)
 
     # Locking the flash
-    protect_ops(u_boot_console, lock_addr, lock_size, 'lock')
+    protect_ops(ubman, lock_addr, lock_size, 'lock')
 
     # Check erase/write operation after locking
-    output, ret_code = flash_ops(u_boot_console, 'erase', prot_start, prot_size, 0, -1)
+    output, ret_code = flash_ops(ubman, 'erase', prot_start, prot_size, 0, -1)
     if not any(error in output for error in EXPECTED_ERASE_ERRORS) or ret_code.endswith(
         '0'
     ):
-        spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+        spi_unlock_exit(ubman, lock_addr, lock_size)
 
     output, ret_code = flash_ops(
-        u_boot_console, 'write', prot_start, prot_size, addr, -1
+        ubman, 'write', prot_start, prot_size, addr, -1
     )
     if not any(error in output for error in EXPECTED_WRITE_ERRORS) or ret_code.endswith(
         '0'
     ):
-        spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+        spi_unlock_exit(ubman, lock_addr, lock_size)
 
     # Check locked sectors
     sect_lock_start = random.randrange(prot_start, (prot_start + prot_size), erase_size)
@@ -497,20 +497,20 @@ def spi_lock_unlock(u_boot_console, lock_addr, lock_size):
     sect_write_size = random.randint(1, sect_lock_size)
 
     output, ret_code = flash_ops(
-        u_boot_console, 'erase', sect_lock_start, sect_lock_size, 0, -1
+        ubman, 'erase', sect_lock_start, sect_lock_size, 0, -1
     )
     if not any(error in output for error in EXPECTED_ERASE_ERRORS) or ret_code.endswith(
         '0'
     ):
-        spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+        spi_unlock_exit(ubman, lock_addr, lock_size)
 
     output, ret_code = flash_ops(
-        u_boot_console, 'write', sect_lock_start, sect_write_size, addr, -1
+        ubman, 'write', sect_lock_start, sect_write_size, addr, -1
     )
     if not any(error in output for error in EXPECTED_WRITE_ERRORS) or ret_code.endswith(
         '0'
     ):
-        spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+        spi_unlock_exit(ubman, lock_addr, lock_size)
 
     # Check unlocked sectors
     if unprot_size != 0:
@@ -526,22 +526,22 @@ def spi_lock_unlock(u_boot_console, lock_addr, lock_size):
         sect_write_size = random.randint(1, sect_unlock_size)
 
         output, ret_code = flash_ops(
-            u_boot_console, 'erase', sect_unlock_start, sect_unlock_size, 0, -1
+            ubman, 'erase', sect_unlock_start, sect_unlock_size, 0, -1
         )
         if EXPECTED_ERASE not in output or ret_code.endswith('1'):
-            spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+            spi_unlock_exit(ubman, lock_addr, lock_size)
 
         output, ret_code = flash_ops(
-            u_boot_console, 'write', sect_unlock_start, sect_write_size, addr, -1
+            ubman, 'write', sect_unlock_start, sect_write_size, addr, -1
         )
         if EXPECTED_WRITE not in output or ret_code.endswith('1'):
-            spi_unlock_exit(u_boot_console, lock_addr, lock_size)
+            spi_unlock_exit(ubman, lock_addr, lock_size)
 
     # Unlocking the flash
-    protect_ops(u_boot_console, lock_addr, lock_size, 'unlock')
+    protect_ops(ubman, lock_addr, lock_size, 'unlock')
 
     # Check erase/write operation after un-locking
-    erase_write_ops(u_boot_console, prot_start, prot_size)
+    erase_write_ops(ubman, prot_start, prot_size)
 
     # Check previous locked sectors
     sect_lock_start = random.randrange(prot_start, (prot_start + prot_size), erase_size)
@@ -554,10 +554,10 @@ def spi_lock_unlock(u_boot_console, lock_addr, lock_size):
     sect_write_size = random.randint(1, sect_lock_size)
 
     flash_ops(
-        u_boot_console, 'erase', sect_lock_start, sect_lock_size, 0, 0, EXPECTED_ERASE
+        ubman, 'erase', sect_lock_start, sect_lock_size, 0, 0, EXPECTED_ERASE
     )
     flash_ops(
-        u_boot_console,
+        ubman,
         'write',
         sect_lock_start,
         sect_write_size,
@@ -569,16 +569,16 @@ def spi_lock_unlock(u_boot_console, lock_addr, lock_size):
 @pytest.mark.buildconfigspec('cmd_bdi')
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_spi_lock_unlock(u_boot_console):
+def test_spi_lock_unlock(ubman):
     ''' Test to check the lock-unlock functionality for SPI family flash '''
-    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
-    flashes = u_boot_console.config.env.get('env__spi_lock_unlock', False)
+    min_f, max_f, loop = spi_find_freq_range(ubman)
+    flashes = ubman.config.env.get('env__spi_lock_unlock', False)
     if not flashes:
         pytest.skip('No SPI test device configured for lock/unlock')
 
     i = 0
     while i < loop:
-        spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+        spi_pre_commands(ubman, random.randint(min_f, max_f))
         total_size = get_total_size()
         flash_part = get_flash_part()
 
@@ -590,31 +590,31 @@ def test_spi_lock_unlock(u_boot_console):
         # For lower half of memory
         lock_addr = random.randint(0, (total_size // 2) - 1)
         lock_size = random.randint(1, ((total_size // 2) - lock_addr))
-        spi_lock_unlock(u_boot_console, lock_addr, lock_size)
+        spi_lock_unlock(ubman, lock_addr, lock_size)
 
         # For upper half of memory
         lock_addr = random.randint((total_size // 2), total_size - 1)
         lock_size = random.randint(1, (total_size - lock_addr))
-        spi_lock_unlock(u_boot_console, lock_addr, lock_size)
+        spi_lock_unlock(ubman, lock_addr, lock_size)
 
         # For entire flash
         lock_addr = random.randint(0, total_size - 1)
         lock_size = random.randint(1, (total_size - lock_addr))
-        spi_lock_unlock(u_boot_console, lock_addr, lock_size)
+        spi_lock_unlock(ubman, lock_addr, lock_size)
 
         i = i + 1
 
 @pytest.mark.buildconfigspec('cmd_bdi')
 @pytest.mark.buildconfigspec('cmd_sf')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_spi_negative(u_boot_console):
+def test_spi_negative(ubman):
     ''' Negative tests for SPI '''
-    min_f, max_f, loop = spi_find_freq_range(u_boot_console)
-    spi_pre_commands(u_boot_console, random.randint(min_f, max_f))
+    min_f, max_f, loop = spi_find_freq_range(ubman)
+    spi_pre_commands(ubman, random.randint(min_f, max_f))
     total_size = get_total_size()
     erase_size = get_erase_size()
     page_size = get_page_size()
-    addr = u_boot_utils.find_ram_base(u_boot_console)
+    addr = u_boot_utils.find_ram_base(ubman)
     i = 0
     while i < loop:
         # Erase negative test
@@ -627,28 +627,28 @@ def test_spi_negative(u_boot_console):
 
         error_msg = 'Erased: ERROR'
         flash_ops(
-            u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
+            ubman, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
         )
 
         # If eraseoffset exceeds beyond flash size
         eoffset = random.randint(total_size, (total_size + int(0x1000000)))
         error_msg = 'Offset exceeds device limit'
         flash_ops(
-            u_boot_console, 'erase', eoffset, esize, 0, 1, error_msg, EXPECTED_ERASE
+            ubman, 'erase', eoffset, esize, 0, 1, error_msg, EXPECTED_ERASE
         )
 
         # If erasesize exceeds beyond flash size
         esize = random.randint((total_size - start), (total_size + int(0x1000000)))
         error_msg = 'ERROR: attempting erase past flash size'
         flash_ops(
-            u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
+            ubman, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
         )
 
         # If erase size is 0
         esize = 0
         error_msg = None
         flash_ops(
-            u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
+            ubman, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
         )
 
         # If erasesize is less than flash's page size
@@ -656,7 +656,7 @@ def test_spi_negative(u_boot_console):
         start = random.randint(0, (total_size - page_size))
         error_msg = 'Erased: ERROR'
         flash_ops(
-            u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
+            ubman, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
         )
 
         # Write/Read negative test
@@ -665,10 +665,10 @@ def test_spi_negative(u_boot_console):
         size = random.randint((total_size - offset), (total_size + int(0x1000000)))
         error_msg = 'Size exceeds partition or device limit'
         flash_ops(
-            u_boot_console, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
+            ubman, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
         )
         flash_ops(
-            u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
+            ubman, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
         )
 
         # if Write/Read offset exceeds beyond flash size
@@ -676,10 +676,10 @@ def test_spi_negative(u_boot_console):
         size = random.randint(0, total_size)
         error_msg = 'Offset exceeds device limit'
         flash_ops(
-            u_boot_console, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
+            ubman, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
         )
         flash_ops(
-            u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
+            ubman, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
         )
 
         # if Write/Read size is 0
@@ -687,14 +687,14 @@ def test_spi_negative(u_boot_console):
         size = 0
         error_msg = None
         flash_ops(
-            u_boot_console, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
+            ubman, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
         )
         flash_ops(
-            u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
+            ubman, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
         )
 
         # Read to relocation address
-        output = u_boot_console.run_command('bdinfo')
+        output = ubman.run_command('bdinfo')
         m = re.search(r'relocaddr\s*= (.+)', output)
         res_area = int(m.group(1), 16)
 
@@ -702,7 +702,7 @@ def test_spi_negative(u_boot_console):
         size = 0x2000
         error_msg = 'ERROR: trying to overwrite reserved memory'
         flash_ops(
-            u_boot_console, 'read', start, size, res_area, 1, error_msg, EXPECTED_READ
+            ubman, 'read', start, size, res_area, 1, error_msg, EXPECTED_READ
         )
 
         i = i + 1
diff --git a/test/py/tests/test_spl.py b/test/py/tests/test_spl.py
index 474f430a344..6b226c256b7 100644
--- a/test/py/tests/test_spl.py
+++ b/test/py/tests/test_spl.py
@@ -6,16 +6,16 @@ import os.path
 import pytest
 
 @pytest.mark.buildconfigspec('spl_unit_test')
-def test_ut_spl_init(u_boot_console):
+def test_ut_spl_init(ubman):
     """Initialize data for ut spl tests."""
 
-    fn = u_boot_console.config.source_dir + '/spi.bin'
+    fn = ubman.config.source_dir + '/spi.bin'
     if not os.path.exists(fn):
         data = b'\x00' * (2 * 1024 * 1024)
         with open(fn, 'wb') as fh:
             fh.write(data)
 
-def test_spl(u_boot_console, ut_spl_subtest):
+def test_spl(ubman, ut_spl_subtest):
     """Execute a "ut" subtest.
 
     The subtests are collected in function generate_ut_subtest() from linker
@@ -29,11 +29,11 @@ def test_spl(u_boot_console, ut_spl_subtest):
     implemented in C function foo_test_bar().
 
     Args:
-        u_boot_console (ConsoleBase): U-Boot console
+        ubman (ConsoleBase): U-Boot console
         ut_subtest (str): SPL test to be executed (e.g. 'dm platdata_phandle')
     """
     try:
-        cons = u_boot_console
+        cons = ubman
         cons.restart_uboot_with_flags(['-u', '-k', ut_spl_subtest.split()[1]])
         output = cons.get_spawn_output().replace('\r', '')
         assert 'failures: 0' in output
@@ -41,4 +41,4 @@ def test_spl(u_boot_console, ut_spl_subtest):
         # Restart afterward in case a non-SPL test is run next. This should not
         # happen since SPL tests are run in their own invocation of test.py, but
         # the cost of doing this is not too great at present.
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
diff --git a/test/py/tests/test_stackprotector.py b/test/py/tests/test_stackprotector.py
index b87392c54ff..a7e20d6307c 100644
--- a/test/py/tests/test_stackprotector.py
+++ b/test/py/tests/test_stackprotector.py
@@ -6,10 +6,10 @@ import signal
 
 @pytest.mark.buildconfigspec('cmd_stackprotector_test')
 @pytest.mark.notbuildconfigspec('asan')
-def test_stackprotector(u_boot_console):
+def test_stackprotector(ubman):
     """Test that the stackprotector function works."""
 
-    u_boot_console.run_command('stackprot_test',wait_for_prompt=False)
+    ubman.run_command('stackprot_test',wait_for_prompt=False)
     expected_response = 'Stack smashing detected'
-    u_boot_console.wait_for(expected_response)
-    u_boot_console.restart_uboot()
+    ubman.wait_for(expected_response)
+    ubman.restart_uboot()
diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index 75f5d31fc67..47e0e7a1b6d 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -31,24 +31,24 @@ skipped.
 
 updates = 0
 
-def force_init(u_boot_console, force=False):
+def force_init(ubman, force=False):
     """When a test fails, U-Boot is reset. Because TPM stack must be initialized
     after each reboot, we must ensure these lines are always executed before
     trying any command or they will fail with no reason. Executing 'tpm init'
     twice will spawn an error used to detect that the TPM was not reset and no
     initialization code should be run.
     """
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
+    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    output = u_boot_console.run_command('tpm2 autostart')
+    output = ubman.run_command('tpm2 autostart')
     if force or not 'Error' in output:
-        u_boot_console.run_command('echo --- start of init ---')
-        u_boot_console.run_command('tpm2 clear TPM2_RH_LOCKOUT')
-        output = u_boot_console.run_command('echo $?')
+        ubman.run_command('echo --- start of init ---')
+        ubman.run_command('tpm2 clear TPM2_RH_LOCKOUT')
+        output = ubman.run_command('echo $?')
         if not output.endswith('0'):
-            u_boot_console.run_command('tpm2 clear TPM2_RH_PLATFORM')
-        u_boot_console.run_command('echo --- end of init ---')
+            ubman.run_command('tpm2 clear TPM2_RH_PLATFORM')
+        ubman.run_command('echo --- end of init ---')
 
 def is_sandbox(cons):
     # Array slice removes leading/trailing quotes.
@@ -56,84 +56,84 @@ def is_sandbox(cons):
     return sys_arch == 'sandbox'
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_init(u_boot_console):
+def test_tpm2_init(ubman):
     """Init the software stack to use TPMv2 commands."""
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
+    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    u_boot_console.run_command('tpm2 autostart')
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 autostart')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_startup(u_boot_console):
+def test_tpm2_startup(ubman):
     """Execute a TPM2_Startup command.
 
     Initiate the TPM internal state machine.
     """
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
+    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 startup TPM2_SU_CLEAR')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-def tpm2_sandbox_init(u_boot_console):
+def tpm2_sandbox_init(ubman):
     """Put sandbox back into a known state so we can run a test
 
     This allows all tests to run in parallel, since no test depends on another.
     """
-    u_boot_console.restart_uboot()
-    u_boot_console.run_command('tpm2 autostart')
-    output = u_boot_console.run_command('echo $?')
+    ubman.restart_uboot()
+    ubman.run_command('tpm2 autostart')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
+    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_sandbox_self_test_full(u_boot_console):
+def test_tpm2_sandbox_self_test_full(ubman):
     """Execute a TPM2_SelfTest (full) command.
 
     Ask the TPM to perform all self tests to also enable full capabilities.
     """
-    if is_sandbox(u_boot_console):
-        u_boot_console.restart_uboot()
-        u_boot_console.run_command('tpm2 autostart')
-        output = u_boot_console.run_command('echo $?')
+    if is_sandbox(ubman):
+        ubman.restart_uboot()
+        ubman.run_command('tpm2 autostart')
+        output = ubman.run_command('echo $?')
         assert output.endswith('0')
 
-        u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
-        output = u_boot_console.run_command('echo $?')
+        ubman.run_command('tpm2 startup TPM2_SU_CLEAR')
+        output = ubman.run_command('echo $?')
         assert output.endswith('0')
 
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
+    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    u_boot_console.run_command('tpm2 self_test full')
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 self_test full')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_continue_self_test(u_boot_console):
+def test_tpm2_continue_self_test(ubman):
     """Execute a TPM2_SelfTest (continued) command.
 
     Ask the TPM to finish its self tests (alternative to the full test) in order
     to enter a fully operational state.
     """
 
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
+    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-    u_boot_console.run_command('tpm2 self_test continue')
-    output = u_boot_console.run_command('echo $?')
+    if is_sandbox(ubman):
+        tpm2_sandbox_init(ubman)
+    ubman.run_command('tpm2 self_test continue')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_clear(u_boot_console):
+def test_tpm2_clear(ubman):
     """Execute a TPM2_Clear command.
 
     Ask the TPM to reset entirely its internal state (including internal
@@ -144,22 +144,22 @@ def test_tpm2_clear(u_boot_console):
     not have a password set, otherwise this test will fail. ENDORSEMENT and
     PLATFORM hierarchies are also available.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
+    if is_sandbox(ubman):
+        tpm2_sandbox_init(ubman)
 
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
+    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    u_boot_console.run_command('tpm2 clear TPM2_RH_LOCKOUT')
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 clear TPM2_RH_LOCKOUT')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-    u_boot_console.run_command('tpm2 clear TPM2_RH_PLATFORM')
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 clear TPM2_RH_PLATFORM')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_change_auth(u_boot_console):
+def test_tpm2_change_auth(ubman):
     """Execute a TPM2_HierarchyChangeAuth command.
 
     Ask the TPM to change the owner, ie. set a new password: 'unicorn'
@@ -167,22 +167,22 @@ def test_tpm2_change_auth(u_boot_console):
     Use the LOCKOUT hierarchy for this. ENDORSEMENT and PLATFORM hierarchies are
     also available.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-    force_init(u_boot_console)
+    if is_sandbox(ubman):
+        tpm2_sandbox_init(ubman)
+    force_init(ubman)
 
-    u_boot_console.run_command('tpm2 change_auth TPM2_RH_LOCKOUT unicorn')
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 change_auth TPM2_RH_LOCKOUT unicorn')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-    u_boot_console.run_command('tpm2 clear TPM2_RH_LOCKOUT unicorn')
-    output = u_boot_console.run_command('echo $?')
-    u_boot_console.run_command('tpm2 clear TPM2_RH_PLATFORM')
+    ubman.run_command('tpm2 clear TPM2_RH_LOCKOUT unicorn')
+    output = ubman.run_command('echo $?')
+    ubman.run_command('tpm2 clear TPM2_RH_PLATFORM')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_get_capability(u_boot_console):
+def test_tpm2_get_capability(ubman):
     """Execute a TPM_GetCapability command.
 
     Display one capability. In our test case, let's display the default DAM
@@ -193,19 +193,19 @@ def test_tpm2_get_capability(u_boot_console):
     There is no expected default values because it would depend on the chip
     used. We can still save them in order to check they have changed later.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
+    if is_sandbox(ubman):
+        tpm2_sandbox_init(ubman)
 
-    force_init(u_boot_console)
-    ram = u_boot_utils.find_ram_base(u_boot_console)
+    force_init(ubman)
+    ram = u_boot_utils.find_ram_base(ubman)
 
-    read_cap = u_boot_console.run_command('tpm2 get_capability 0x6 0x20e 0x200 1') #0x%x 1' % ram)
-    output = u_boot_console.run_command('echo $?')
+    read_cap = ubman.run_command('tpm2 get_capability 0x6 0x20e 0x200 1') #0x%x 1' % ram)
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
     assert 'Property 0x0000020e: 0x00000000' in read_cap
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_dam_parameters(u_boot_console):
+def test_tpm2_dam_parameters(ubman):
     """Execute a TPM2_DictionaryAttackParameters command.
 
     Change Dictionary Attack Mitigation (DAM) parameters. Ask the TPM to change:
@@ -217,38 +217,38 @@ def test_tpm2_dam_parameters(u_boot_console):
     the authentication, otherwise the lockout will be engaged after the first
     failed authentication attempt.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-    force_init(u_boot_console)
-    ram = u_boot_utils.find_ram_base(u_boot_console)
+    if is_sandbox(ubman):
+        tpm2_sandbox_init(ubman)
+    force_init(ubman)
+    ram = u_boot_utils.find_ram_base(ubman)
 
     # Set the DAM parameters to known values
-    u_boot_console.run_command('tpm2 dam_parameters 3 10 0')
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 dam_parameters 3 10 0')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
     # Check the values have been saved
-    read_cap = u_boot_console.run_command('tpm2 get_capability 0x6 0x20f 0x%x 3' % ram)
-    output = u_boot_console.run_command('echo $?')
+    read_cap = ubman.run_command('tpm2 get_capability 0x6 0x20f 0x%x 3' % ram)
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
     assert 'Property 0x0000020f: 0x00000003' in read_cap
     assert 'Property 0x00000210: 0x0000000a' in read_cap
     assert 'Property 0x00000211: 0x00000000' in read_cap
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_pcr_read(u_boot_console):
+def test_tpm2_pcr_read(ubman):
     """Execute a TPM2_PCR_Read command.
 
     Perform a PCR read of the 10th PCR. Must be zero.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
+    if is_sandbox(ubman):
+        tpm2_sandbox_init(ubman)
 
-    force_init(u_boot_console)
-    ram = u_boot_utils.find_ram_base(u_boot_console)
+    force_init(ubman)
+    ram = u_boot_utils.find_ram_base(ubman)
 
-    read_pcr = u_boot_console.run_command('tpm2 pcr_read 10 0x%x' % ram)
-    output = u_boot_console.run_command('echo $?')
+    read_pcr = ubman.run_command('tpm2 pcr_read 10 0x%x' % ram)
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
     # Save the number of PCR updates
@@ -261,7 +261,7 @@ def test_tpm2_pcr_read(u_boot_console):
     assert '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00' in read_pcr
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_pcr_extend(u_boot_console):
+def test_tpm2_pcr_extend(ubman):
     """Execute a TPM2_PCR_Extend command.
 
     Perform a PCR extension with a known hash in memory (zeroed since the board
@@ -270,25 +270,25 @@ def test_tpm2_pcr_extend(u_boot_console):
     No authentication mechanism is used here, not protecting against packet
     replay, yet.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-    force_init(u_boot_console)
-    ram = u_boot_utils.find_ram_base(u_boot_console)
+    if is_sandbox(ubman):
+        tpm2_sandbox_init(ubman)
+    force_init(ubman)
+    ram = u_boot_utils.find_ram_base(ubman)
 
-    read_pcr = u_boot_console.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
-    output = u_boot_console.run_command('echo $?')
+    read_pcr = ubman.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
     str = re.findall(r'\d+ known updates', read_pcr)[0]
     updates = int(re.findall(r'\d+', str)[0])
 
-    u_boot_console.run_command('tpm2 pcr_extend 10 0x%x' % ram)
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 pcr_extend 10 0x%x' % ram)
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
     # Read the value back into a different place so we can still use 'ram' as
     # our zero bytes
-    read_pcr = u_boot_console.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
-    output = u_boot_console.run_command('echo $?')
+    read_pcr = ubman.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
     assert 'f5 a5 fd 42 d1 6a 20 30 27 98 ef 6e d3 09 97 9b' in read_pcr
     assert '43 00 3d 23 20 d9 f0 e8 ea 98 31 a9 27 59 fb 4b' in read_pcr
@@ -297,12 +297,12 @@ def test_tpm2_pcr_extend(u_boot_console):
     new_updates = int(re.findall(r'\d+', str)[0])
     assert (updates + 1) == new_updates
 
-    u_boot_console.run_command('tpm2 pcr_extend 10 0x%x' % ram)
-    output = u_boot_console.run_command('echo $?')
+    ubman.run_command('tpm2 pcr_extend 10 0x%x' % ram)
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-    read_pcr = u_boot_console.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
-    output = u_boot_console.run_command('echo $?')
+    read_pcr = ubman.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
     assert '7a 05 01 f5 95 7b df 9c b3 a8 ff 49 66 f0 22 65' in read_pcr
     assert 'f9 68 65 8b 7a 9c 62 64 2c ba 11 65 e8 66 42 f5' in read_pcr
@@ -312,7 +312,7 @@ def test_tpm2_pcr_extend(u_boot_console):
     assert (updates + 2) == new_updates
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_cleanup(u_boot_console):
+def test_tpm2_cleanup(ubman):
     """Ensure the TPM is cleared from password or test related configuration."""
 
-    force_init(u_boot_console, True)
+    force_init(ubman, True)
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index ec1e624722c..8889aabe966 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -277,9 +277,9 @@ check_flamegraph
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('trace')
-def test_trace(u_boot_console):
+def test_trace(ubman):
     """Test we can build sandbox with trace, collect and process a trace"""
-    cons = u_boot_console
+    cons = ubman
 
     if not os.path.exists(TMPDIR):
         os.mkdir(TMPDIR)
diff --git a/test/py/tests/test_ums.py b/test/py/tests/test_ums.py
index 749b1606235..d7f991ddd12 100644
--- a/test/py/tests/test_ums.py
+++ b/test/py/tests/test_ums.py
@@ -74,13 +74,13 @@ writable_fs_partition value.
 """
 
 @pytest.mark.buildconfigspec('cmd_usb_mass_storage')
-def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
+def test_ums(ubman, env__usb_dev_port, env__block_devs):
     """Test the "ums" command; the host system must be able to enumerate a UMS
     device when "ums" is running, block and optionally file I/O are tested,
     and this device must disappear when "ums" is aborted.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         env__usb_dev_port: The single USB device-mode port specification on
             which to run the test. See the file-level comment above for
             details of the format.
@@ -96,7 +96,7 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
     if not have_writable_fs_partition:
         # If 'writable_fs_subdir' is missing, we'll skip all parts of the
         # testing which mount filesystems.
-        u_boot_console.log.warning(
+        ubman.log.warning(
             'boardenv missing "writable_fs_partition"; ' +
             'UMS testing will be limited.')
 
@@ -109,14 +109,14 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
     tgt_dev_type = env__block_devs[0]['type']
     tgt_dev_id = env__block_devs[0]['id']
     if have_writable_fs_partition:
-        mount_point = u_boot_console.config.env['env__mount_points'][0]
+        mount_point = ubman.config.env['env__mount_points'][0]
         mount_subdir = env__block_devs[0]['writable_fs_subdir']
         part_num = env__block_devs[0]['writable_fs_partition']
         host_ums_part_node = '%s-part%d' % (host_ums_dev_node, part_num)
     else:
         host_ums_part_node = host_ums_dev_node
 
-    test_f = u_boot_utils.PersistentRandomFile(u_boot_console, 'ums.bin',
+    test_f = u_boot_utils.PersistentRandomFile(ubman, 'ums.bin',
         1024 * 1024);
     if have_writable_fs_partition:
         mounted_test_fn = mount_point + '/' + mount_subdir + test_f.fn
@@ -133,13 +133,13 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
             Nothing.
         """
 
-        u_boot_console.log.action(
+        ubman.log.action(
             'Starting long-running U-Boot ums shell command')
         cmd = 'ums %s %s %s' % (tgt_usb_ctlr, tgt_dev_type, tgt_dev_id)
-        u_boot_console.run_command(cmd, wait_for_prompt=False)
-        u_boot_console.wait_for(re.compile('UMS: LUN.*[\r\n]'))
+        ubman.run_command(cmd, wait_for_prompt=False)
+        ubman.wait_for(re.compile('UMS: LUN.*[\r\n]'))
         fh = u_boot_utils.wait_until_open_succeeds(host_ums_part_node)
-        u_boot_console.log.action('Reading raw data from UMS device')
+        ubman.log.action('Reading raw data from UMS device')
         fh.read(4096)
         fh.close()
 
@@ -153,9 +153,9 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
             Nothing.
         """
 
-        u_boot_console.log.action('Mounting exported UMS device')
+        ubman.log.action('Mounting exported UMS device')
         cmd = ('/bin/mount', host_ums_part_node)
-        u_boot_utils.run_and_log(u_boot_console, cmd)
+        u_boot_utils.run_and_log(ubman, cmd)
 
     def umount(ignore_errors):
         """Unmount the block device that U-Boot exports.
@@ -170,9 +170,9 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
             Nothing.
         """
 
-        u_boot_console.log.action('Unmounting UMS device')
+        ubman.log.action('Unmounting UMS device')
         cmd = ('/bin/umount', host_ums_part_node)
-        u_boot_utils.run_and_log(u_boot_console, cmd, ignore_errors)
+        u_boot_utils.run_and_log(ubman, cmd, ignore_errors)
 
     def stop_ums(ignore_errors):
         """Stop U-Boot's ums shell command from executing.
@@ -190,9 +190,9 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
             Nothing.
         """
 
-        u_boot_console.log.action(
+        ubman.log.action(
             'Stopping long-running U-Boot ums shell command')
-        u_boot_console.ctrlc()
+        ubman.ctrlc()
         u_boot_utils.wait_until_file_open_fails(host_ums_part_node,
             ignore_errors)
 
@@ -204,13 +204,13 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
             return
         try:
             mount()
-            u_boot_console.log.action('Writing test file via UMS')
+            ubman.log.action('Writing test file via UMS')
             cmd = ('rm', '-f', mounted_test_fn)
-            u_boot_utils.run_and_log(u_boot_console, cmd)
+            u_boot_utils.run_and_log(ubman, cmd)
             if os.path.exists(mounted_test_fn):
                 raise Exception('Could not rm target UMS test file')
             cmd = ('cp', test_f.abs_fn, mounted_test_fn)
-            u_boot_utils.run_and_log(u_boot_console, cmd)
+            u_boot_utils.run_and_log(ubman, cmd)
             ignore_cleanup_errors = False
         finally:
             umount(ignore_errors=ignore_cleanup_errors)
@@ -222,10 +222,10 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
         start_ums()
         try:
             mount()
-            u_boot_console.log.action('Reading test file back via UMS')
+            ubman.log.action('Reading test file back via UMS')
             read_back_hash = u_boot_utils.md5sum_file(mounted_test_fn)
             cmd = ('rm', '-f', mounted_test_fn)
-            u_boot_utils.run_and_log(u_boot_console, cmd)
+            u_boot_utils.run_and_log(ubman, cmd)
             ignore_cleanup_errors = False
         finally:
             umount(ignore_errors=ignore_cleanup_errors)
diff --git a/test/py/tests/test_unknown_cmd.py b/test/py/tests/test_unknown_cmd.py
index 8fc284a9249..b40c57f8a10 100644
--- a/test/py/tests/test_unknown_cmd.py
+++ b/test/py/tests/test_unknown_cmd.py
@@ -2,12 +2,12 @@
 # Copyright (c) 2015 Stephen Warren
 # Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
 
-def test_unknown_command(u_boot_console):
+def test_unknown_command(ubman):
     """Test that executing an unknown command causes U-Boot to print an
     error."""
 
     # The "unknown command" error is actively expected here,
     # so error detection for it is disabled.
-    with u_boot_console.disable_check('unknown_command'):
-        response = u_boot_console.run_command('non_existent_cmd')
+    with ubman.disable_check('unknown_command'):
+        response = ubman.run_command('non_existent_cmd')
     assert('Unknown command \'non_existent_cmd\' - try \'help\'' in response)
diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index d94359d8b9b..e7d79f6b9a4 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -9,7 +9,7 @@ import pytest
 import u_boot_utils
 
 @pytest.mark.boardspec('sandbox_vpl')
-def test_upl_handoff(u_boot_console):
+def test_upl_handoff(ubman):
     """Test of UPL handoff
 
     This works by starting up U-Boot VPL, which gets to SPL and then sets up a
@@ -19,7 +19,7 @@ def test_upl_handoff(u_boot_console):
     The entire FIT is loaded into memory in SPL (in upl_load_from_image()) so
     that it can be inpected in upl_test_info_norun
     """
-    cons = u_boot_console
+    cons = ubman
     ram = os.path.join(cons.config.build_dir, 'ram.bin')
     fdt = os.path.join(cons.config.build_dir, 'u-boot.dtb')
 
diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index e1f203b5cbc..dcb0b7d4be0 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -20,20 +20,20 @@ For example:
 env__usb_device_test_skip = False
 """
 
-def setup_usb(u_boot_console):
-    if u_boot_console.config.env.get('env__usb_device_test_skip', True):
+def setup_usb(ubman):
+    if ubman.config.env.get('env__usb_device_test_skip', True):
         pytest.skip('USB device test is not enabled')
 
 @pytest.mark.buildconfigspec('cmd_usb')
-def test_usb_start(u_boot_console):
-    setup_usb(u_boot_console)
-    output = u_boot_console.run_command('usb start')
+def test_usb_start(ubman):
+    setup_usb(ubman)
+    output = ubman.run_command('usb start')
 
     # if output is empty, usb start may already run as part of preboot command
     # re-start the usb, in that case
     if not output:
-        u_boot_console.run_command('usb stop')
-        output = u_boot_console.run_command('usb start')
+        ubman.run_command('usb stop')
+        output = ubman.run_command('usb start')
 
     if 'No USB device found' in output:
         pytest.skip('No USB controller available')
@@ -61,26 +61,26 @@ def test_usb_start(u_boot_console):
     if 'Starting the controller' in output:
         assert 'USB XHCI' in output
 
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
     return controllers, storage_device
 
 @pytest.mark.buildconfigspec('cmd_usb')
-def test_usb_stop(u_boot_console):
-    setup_usb(u_boot_console)
-    output = u_boot_console.run_command('usb stop')
+def test_usb_stop(ubman):
+    setup_usb(ubman)
+    output = ubman.run_command('usb stop')
     assert 'stopping USB..' in output
 
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-    output = u_boot_console.run_command('usb dev')
+    output = ubman.run_command('usb dev')
     assert "USB is stopped. Please issue 'usb start' first." in output
 
 @pytest.mark.buildconfigspec('cmd_usb')
-def test_usb_reset(u_boot_console):
-    setup_usb(u_boot_console)
-    output = u_boot_console.run_command('usb reset')
+def test_usb_reset(ubman):
+    setup_usb(ubman)
+    output = ubman.run_command('usb reset')
 
     if 'No USB device found' in output:
         pytest.skip('No USB controller available')
@@ -107,13 +107,13 @@ def test_usb_reset(u_boot_console):
     if 'Starting the controller' in output:
         assert 'USB XHCI' in output
 
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_usb')
-def test_usb_info(u_boot_console):
-    controllers, storage_device = test_usb_start(u_boot_console)
-    output = u_boot_console.run_command('usb info')
+def test_usb_info(ubman):
+    controllers, storage_device = test_usb_start(ubman)
+    output = ubman.run_command('usb info')
 
     num_controller = len(re.findall(': Hub,', output))
     num_mass_storage = len(re.findall(': Mass Storage,', output))
@@ -121,22 +121,22 @@ def test_usb_info(u_boot_console):
     assert num_controller == controllers - 1
     assert num_mass_storage == storage_device
 
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
     for i in range(0, storage_device + controllers - 1):
-        output = u_boot_console.run_command('usb info %d' % i)
+        output = ubman.run_command('usb info %d' % i)
         num_controller = len(re.findall(': Hub,', output))
         num_mass_storage = len(re.findall(': Mass Storage,', output))
         assert num_controller + num_mass_storage == 1
         assert 'No device available' not in output
-        output = u_boot_console.run_command('echo $?')
+        output = ubman.run_command('echo $?')
         assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_usb')
-def test_usb_tree(u_boot_console):
-    controllers, storage_device = test_usb_start(u_boot_console)
-    output = u_boot_console.run_command('usb tree')
+def test_usb_tree(ubman):
+    controllers, storage_device = test_usb_start(ubman)
+    output = ubman.run_command('usb tree')
 
     num_controller = len(re.findall('Hub', output))
     num_mass_storage = len(re.findall('Mass Storage', output))
@@ -144,14 +144,14 @@ def test_usb_tree(u_boot_console):
     assert num_controller == controllers - 1
     assert num_mass_storage == storage_device
 
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('usb_storage')
-def test_usb_storage(u_boot_console):
-    controllers, storage_device = test_usb_start(u_boot_console)
-    output = u_boot_console.run_command('usb storage')
+def test_usb_storage(ubman):
+    controllers, storage_device = test_usb_start(ubman)
+    output = ubman.run_command('usb storage')
 
     obj = re.findall(r'Capacity: (\d+|\d+[\.]?\d)', output)
     devices = {}
@@ -167,17 +167,17 @@ def test_usb_storage(u_boot_console):
         except ValueError:
             pytest.fail('USB storage device capacity not recognized')
 
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_usb')
-def test_usb_dev(u_boot_console):
-    controllers, storage_device = test_usb_start(u_boot_console)
-    output = u_boot_console.run_command('usb dev')
+def test_usb_dev(ubman):
+    controllers, storage_device = test_usb_start(ubman)
+    output = ubman.run_command('usb dev')
 
     assert 'no usb devices available' not in output
 
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
     devices = {}
@@ -188,7 +188,7 @@ def test_usb_dev(u_boot_console):
     fail = 0
     for x in range(0, storage_device):
         devices[x]['detected'] = 'yes'
-        output = u_boot_console.run_command('usb dev %d' % x)
+        output = ubman.run_command('usb dev %d' % x)
 
         if 'Card did not respond to voltage select' in output:
             fail = 1
@@ -201,7 +201,7 @@ def test_usb_dev(u_boot_console):
             devices[x]['detected'] = 'no'
 
         assert 'is now current device' in output
-        output = u_boot_console.run_command('echo $?')
+        output = ubman.run_command('echo $?')
         assert output.endswith('0')
 
     if fail:
@@ -210,20 +210,20 @@ def test_usb_dev(u_boot_console):
     return devices, controllers, storage_device
 
 @pytest.mark.buildconfigspec('cmd_usb')
-def test_usb_part(u_boot_console):
-    devices, controllers, storage_device = test_usb_dev(u_boot_console)
+def test_usb_part(ubman):
+    devices, controllers, storage_device = test_usb_dev(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
-    u_boot_console.run_command('usb part')
+    ubman.run_command('usb part')
 
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
     for i in range(0, storage_device):
         if devices[i]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % i)
-            output = u_boot_console.run_command('usb part')
+            ubman.run_command('usb dev %d' % i)
+            output = ubman.run_command('usb part')
 
             lines = output.split('\n')
             part_fat = []
@@ -241,7 +241,7 @@ def test_usb_part(u_boot_console):
                         part_fat.append(part_id)
                     elif part_type == '83':
                         print('ext(2/4) detected')
-                        output = u_boot_console.run_command(
+                        output = ubman.run_command(
                             'fstype usb %d:%d' % i, part_id
                         )
                         if 'ext2' in output:
@@ -261,8 +261,8 @@ def test_usb_part(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_fat')
-def test_usb_fatls_fatinfo(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_fatls_fatinfo(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
@@ -270,7 +270,7 @@ def test_usb_fatls_fatinfo(u_boot_console):
     fs = 'fat'
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -278,7 +278,7 @@ def test_usb_fatls_fatinfo(u_boot_console):
                 continue
 
             for part in partitions:
-                output = u_boot_console.run_command('fatls usb %d:%s' % (x, part))
+                output = ubman.run_command('fatls usb %d:%s' % (x, part))
                 if 'Unrecognized filesystem type' in output:
                     partitions.remove(part)
                     pytest.fail('Unrecognized filesystem')
@@ -286,7 +286,7 @@ def test_usb_fatls_fatinfo(u_boot_console):
                 if not re.search(r'\d file\(s\), \d dir\(s\)', output):
                     pytest.fail('%s read failed on device %d' % (fs.upper, x))
 
-                output = u_boot_console.run_command('fatinfo usb %d:%s' % (x, part))
+                output = ubman.run_command('fatinfo usb %d:%s' % (x, part))
                 string = 'Filesystem: %s' % fs.upper
                 if re.search(string, output):
                     pytest.fail('%s FS failed on device %d' % (fs.upper(), x))
@@ -295,17 +295,17 @@ def test_usb_fatls_fatinfo(u_boot_console):
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
 
-def usb_fatload_fatwrite(u_boot_console, fs, x, part):
-    addr = u_boot_utils.find_ram_base(u_boot_console)
+def usb_fatload_fatwrite(ubman, fs, x, part):
+    addr = u_boot_utils.find_ram_base(ubman)
     size = random.randint(4, 1 * 1024 * 1024)
-    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+    output = ubman.run_command('crc32 %x %x' % (addr, size))
     m = re.search('==> (.+?)', output)
     if not m:
         pytest.fail('CRC32 failed')
     expected_crc32 = m.group(1)
 
     file = '%s_%d' % ('uboot_test', size)
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         '%swrite usb %d:%s %x %s %x' % (fs, x, part, addr, file, size)
     )
     assert 'Unable to write' not in output
@@ -315,12 +315,12 @@ def usb_fatload_fatwrite(u_boot_console, fs, x, part):
     assert expected_text in output
 
     alignment = int(
-        u_boot_console.config.buildconfig.get(
+        ubman.config.buildconfig.get(
             'config_sys_cacheline_size', 128
         )
     )
     offset = random.randrange(alignment, 1024, alignment)
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         '%sload usb %d:%s %x %s' % (fs, x, part, addr + offset, file)
     )
     assert 'Invalid FAT entry' not in output
@@ -329,7 +329,7 @@ def usb_fatload_fatwrite(u_boot_console, fs, x, part):
     expected_text = '%d bytes read' % size
     assert expected_text in output
 
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         'crc32 %x $filesize' % (addr + offset)
     )
     assert expected_crc32 in output
@@ -339,8 +339,8 @@ def usb_fatload_fatwrite(u_boot_console, fs, x, part):
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_fat')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_usb_fatload_fatwrite(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_fatload_fatwrite(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
@@ -348,7 +348,7 @@ def test_usb_fatload_fatwrite(u_boot_console):
     fs = 'fat'
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -357,15 +357,15 @@ def test_usb_fatload_fatwrite(u_boot_console):
 
             for part in partitions:
                 part_detect = 1
-                usb_fatload_fatwrite(u_boot_console, fs, x, part)
+                usb_fatload_fatwrite(ubman, fs, x, part)
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
 
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_ext4')
-def test_usb_ext4ls(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_ext4ls(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
@@ -379,9 +379,9 @@ def test_usb_ext4ls(u_boot_console):
                 print('No %s table on this device' % fs.upper())
                 continue
 
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             for part in partitions:
-                output = u_boot_console.run_command('%sls usb %d:%s' % (fs, x, part))
+                output = ubman.run_command('%sls usb %d:%s' % (fs, x, part))
                 if 'Unrecognized filesystem type' in output:
                     partitions.remove(part)
                     pytest.fail('Unrecognized filesystem')
@@ -390,17 +390,17 @@ def test_usb_ext4ls(u_boot_console):
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
 
-def usb_ext4load_ext4write(u_boot_console, fs, x, part):
-    addr = u_boot_utils.find_ram_base(u_boot_console)
+def usb_ext4load_ext4write(ubman, fs, x, part):
+    addr = u_boot_utils.find_ram_base(ubman)
     size = random.randint(4, 1 * 1024 * 1024)
-    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+    output = ubman.run_command('crc32 %x %x' % (addr, size))
     m = re.search('==> (.+?)', output)
     if not m:
         pytest.fail('CRC32 failed')
     expected_crc32 = m.group(1)
     file = '%s_%d' % ('uboot_test', size)
 
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         '%swrite usb %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
     )
     assert 'Unable to write' not in output
@@ -410,13 +410,13 @@ def usb_ext4load_ext4write(u_boot_console, fs, x, part):
     assert expected_text in output
 
     offset = random.randrange(128, 1024, 128)
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
     )
     expected_text = '%d bytes read' % size
     assert expected_text in output
 
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         'crc32 %x $filesize' % (addr + offset)
     )
     assert expected_crc32 in output
@@ -427,8 +427,8 @@ def usb_ext4load_ext4write(u_boot_console, fs, x, part):
 @pytest.mark.buildconfigspec('cmd_ext4')
 @pytest.mark.buildconfigspec('cmd_ext4_write')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_usb_ext4load_ext4write(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_ext4load_ext4write(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
@@ -436,7 +436,7 @@ def test_usb_ext4load_ext4write(u_boot_console):
     fs = 'ext4'
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -445,15 +445,15 @@ def test_usb_ext4load_ext4write(u_boot_console):
 
             for part in partitions:
                 part_detect = 1
-                usb_ext4load_ext4write(u_boot_console, fs, x, part)
+                usb_ext4load_ext4write(ubman, fs, x, part)
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
 
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_ext2')
-def test_usb_ext2ls(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_ext2ls(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
@@ -461,7 +461,7 @@ def test_usb_ext2ls(u_boot_console):
     fs = 'ext2'
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -470,7 +470,7 @@ def test_usb_ext2ls(u_boot_console):
 
             for part in partitions:
                 part_detect = 1
-                output = u_boot_console.run_command('%sls usb %d:%s' % (fs, x, part))
+                output = ubman.run_command('%sls usb %d:%s' % (fs, x, part))
                 if 'Unrecognized filesystem type' in output:
                     partitions.remove(part)
                     pytest.fail('Unrecognized filesystem')
@@ -484,8 +484,8 @@ def test_usb_ext2ls(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_ext4')
 @pytest.mark.buildconfigspec('cmd_ext4_write')
 @pytest.mark.buildconfigspec('cmd_memory')
-def test_usb_ext2load(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_ext2load(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
 
     if not devices:
         pytest.skip('No devices detected')
@@ -494,7 +494,7 @@ def test_usb_ext2load(u_boot_console):
     fs = 'ext2'
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -504,17 +504,17 @@ def test_usb_ext2load(u_boot_console):
             for part in partitions:
                 part_detect = 1
                 file, size, expected_crc32 = \
-                    usb_ext4load_ext4write(u_boot_console, fs, x, part)
-                addr = u_boot_utils.find_ram_base(u_boot_console)
+                    usb_ext4load_ext4write(ubman, fs, x, part)
+                addr = u_boot_utils.find_ram_base(ubman)
 
                 offset = random.randrange(128, 1024, 128)
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
                 )
                 expected_text = '%d bytes read' % size
                 assert expected_text in output
 
-                output = u_boot_console.run_command(
+                output = ubman.run_command(
                     'crc32 %x $filesize' % (addr + offset)
                 )
                 assert expected_crc32 in output
@@ -524,15 +524,15 @@ def test_usb_ext2load(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
-def test_usb_ls(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_ls(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
     part_detect = 0
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             for fs in ['fat', 'ext2', 'ext4']:
                 try:
                     partitions = devices[x][fs]
@@ -542,7 +542,7 @@ def test_usb_ls(u_boot_console):
 
                 for part in partitions:
                     part_detect = 1
-                    output = u_boot_console.run_command('ls usb %d:%s' % (x, part))
+                    output = ubman.run_command('ls usb %d:%s' % (x, part))
                     if re.search(r'No \w+ table on this device', output):
                         pytest.fail(
                             '%s: Partition table not found %d' % (fs.upper(), x)
@@ -554,15 +554,15 @@ def test_usb_ls(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_ext4_write')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
-def test_usb_load(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_load(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
     part_detect = 0
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             for fs in ['fat', 'ext2', 'ext4']:
                 try:
                     partitions = devices[x][fs]
@@ -572,23 +572,23 @@ def test_usb_load(u_boot_console):
 
                 for part in partitions:
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    addr = u_boot_utils.find_ram_base(ubman)
 
                     if fs == 'fat':
                         file, size, expected_crc32 = \
-                            usb_fatload_fatwrite(u_boot_console, fs, x, part)
+                            usb_fatload_fatwrite(ubman, fs, x, part)
                     elif fs in ['ext4', 'ext2']:
                         file, size, expected_crc32 = \
-                            usb_ext4load_ext4write(u_boot_console, fs, x, part)
+                            usb_ext4load_ext4write(ubman, fs, x, part)
 
                     offset = random.randrange(128, 1024, 128)
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         'load usb %d:%s %x /%s' % (x, part, addr + offset, file)
                     )
                     expected_text = '%d bytes read' % size
                     assert expected_text in output
 
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         'crc32 %x $filesize' % (addr + offset)
                     )
                     assert expected_crc32 in output
@@ -598,15 +598,15 @@ def test_usb_load(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
-def test_usb_save(u_boot_console):
-    devices, controllers, storage_device = test_usb_part(u_boot_console)
+def test_usb_save(ubman):
+    devices, controllers, storage_device = test_usb_part(ubman)
     if not devices:
         pytest.skip('No devices detected')
 
     part_detect = 0
     for x in range(0, int(storage_device)):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('usb dev %d' % x)
+            ubman.run_command('usb dev %d' % x)
             for fs in ['fat', 'ext2', 'ext4']:
                 try:
                     partitions = devices[x][fs]
@@ -616,12 +616,12 @@ def test_usb_save(u_boot_console):
 
                 for part in partitions:
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    addr = u_boot_utils.find_ram_base(ubman)
                     size = random.randint(4, 1 * 1024 * 1024)
                     file = '%s_%d' % ('uboot_test', size)
 
                     offset = random.randrange(128, 1024, 128)
-                    output = u_boot_console.run_command(
+                    output = ubman.run_command(
                         'save usb %d:%s %x /%s %x'
                         % (x, part, addr + offset, file, size)
                     )
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index d2d8ce10755..3bcdc7ac954 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -506,36 +506,36 @@ def setup_cedit_file(cons):
         cons, f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
 
 @pytest.mark.buildconfigspec('ut_dm')
-def test_ut_dm_init(u_boot_console):
+def test_ut_dm_init(ubman):
     """Initialize data for ut dm tests."""
 
-    fn = u_boot_console.config.source_dir + '/testflash.bin'
+    fn = ubman.config.source_dir + '/testflash.bin'
     if not os.path.exists(fn):
         data = b'this is a test'
         data += b'\x00' * ((4 * 1024 * 1024) - len(data))
         with open(fn, 'wb') as fh:
             fh.write(data)
 
-    fn = u_boot_console.config.source_dir + '/spi.bin'
+    fn = ubman.config.source_dir + '/spi.bin'
     if not os.path.exists(fn):
         data = b'\x00' * (2 * 1024 * 1024)
         with open(fn, 'wb') as fh:
             fh.write(data)
 
     # Create a file with a single partition
-    fn = u_boot_console.config.source_dir + '/scsi.img'
+    fn = ubman.config.source_dir + '/scsi.img'
     if not os.path.exists(fn):
         data = b'\x00' * (2 * 1024 * 1024)
         with open(fn, 'wb') as fh:
             fh.write(data)
         u_boot_utils.run_and_log(
-            u_boot_console, f'sfdisk {fn}', stdin=b'type=83')
+            ubman, f'sfdisk {fn}', stdin=b'type=83')
 
-    fs_helper.mk_fs(u_boot_console.config, 'ext2', 0x200000, '2MB', None)
-    fs_helper.mk_fs(u_boot_console.config, 'fat32', 0x100000, '1MB', None)
+    fs_helper.mk_fs(ubman.config, 'ext2', 0x200000, '2MB', None)
+    fs_helper.mk_fs(ubman.config, 'fat32', 0x100000, '1MB', None)
 
     mmc_dev = 6
-    fn = os.path.join(u_boot_console.config.source_dir, f'mmc{mmc_dev}.img')
+    fn = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
     data = b'\x00' * (12 * 1024 * 1024)
     with open(fn, 'wb') as fh:
         fh.write(data)
@@ -568,21 +568,21 @@ def setup_efi_image(cons):
 
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
-def test_ut_dm_init_bootstd(u_boot_console):
+def test_ut_dm_init_bootstd(ubman):
     """Initialise data for bootflow tests"""
 
-    setup_bootflow_image(u_boot_console)
-    setup_bootmenu_image(u_boot_console)
-    setup_cedit_file(u_boot_console)
-    setup_cros_image(u_boot_console)
-    setup_android_image(u_boot_console)
-    setup_efi_image(u_boot_console)
+    setup_bootflow_image(ubman)
+    setup_bootmenu_image(ubman)
+    setup_cedit_file(ubman)
+    setup_cros_image(ubman)
+    setup_android_image(ubman)
+    setup_efi_image(ubman)
 
     # Restart so that the new mmc1.img is picked up
-    u_boot_console.restart_uboot()
+    ubman.restart_uboot()
 
 
-def test_ut(u_boot_console, ut_subtest):
+def test_ut(ubman, ut_subtest):
     """Execute a "ut" subtest.
 
     The subtests are collected in function generate_ut_subtest() from linker
@@ -595,16 +595,16 @@ def test_ut(u_boot_console, ut_subtest):
     implemented in C function foo_test_bar().
 
     Args:
-        u_boot_console (ConsoleBase): U-Boot console
+        ubman (ConsoleBase): U-Boot console
         ut_subtest (str): test to be executed via command ut, e.g 'foo bar' to
             execute command 'ut foo bar'
     """
 
     if ut_subtest == 'hush hush_test_simple_dollar':
         # ut hush hush_test_simple_dollar prints "Unknown command" on purpose.
-        with u_boot_console.disable_check('unknown_command'):
-            output = u_boot_console.run_command('ut ' + ut_subtest)
+        with ubman.disable_check('unknown_command'):
+            output = ubman.run_command('ut ' + ut_subtest)
         assert 'Unknown command \'quux\' - try \'help\'' in output
     else:
-        output = u_boot_console.run_command('ut ' + ut_subtest)
+        output = ubman.run_command('ut ' + ut_subtest)
     assert output.endswith('failures: 0')
diff --git a/test/py/tests/test_vbe.py b/test/py/tests/test_vbe.py
index 861df3f8266..876d22fa809 100644
--- a/test/py/tests/test_vbe.py
+++ b/test/py/tests/test_vbe.py
@@ -90,8 +90,8 @@ ut bootstd -f vbe_test_fixup_norun
 
 @pytest.mark.boardspec('sandbox_flattree')
 @pytest.mark.requiredtool('dtc')
-def test_vbe(u_boot_console):
-    cons = u_boot_console
+def test_vbe(ubman):
+    cons = ubman
     kernel = fit_util.make_kernel(cons, 'vbe-kernel.bin', 'kernel')
     fdt = fit_util.make_dtb(cons, base_fdt, 'vbe-fdt')
     fdt_out = fit_util.make_fname(cons, 'fdt-out.dtb')
diff --git a/test/py/tests/test_vbe_vpl.py b/test/py/tests/test_vbe_vpl.py
index ed12d3a4618..11389176335 100644
--- a/test/py/tests/test_vbe_vpl.py
+++ b/test/py/tests/test_vbe_vpl.py
@@ -10,8 +10,8 @@ import u_boot_utils
 
 @pytest.mark.boardspec('sandbox_vpl')
 @pytest.mark.requiredtool('dtc')
-def test_vbe_vpl(u_boot_console):
-    cons = u_boot_console
+def test_vbe_vpl(ubman):
+    cons = ubman
     #cmd = [cons.config.build_dir + fname, '-v']
     ram = os.path.join(cons.config.build_dir, 'ram.bin')
     fdt = os.path.join(cons.config.build_dir, 'arch/sandbox/dts/test.dtb')
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 7e0e8e44750..724833dc976 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -113,7 +113,7 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.requiredtool('openssl')
 @pytest.mark.parametrize("name,sha_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
                          TESTDATA)
-def test_vboot(u_boot_console, name, sha_algo, padding, sign_options, required,
+def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                full_test, algo_arg, global_sign):
     """Test verified boot signing with mkimage and verification with 'bootm'.
 
@@ -371,7 +371,7 @@ def test_vboot(u_boot_console, name, sha_algo, padding, sign_options, required,
         # Create a new properly signed fit and replace header bytes
         make_fit('sign-configs-%s%s.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
-        bcfg = u_boot_console.config.buildconfig
+        bcfg = ubman.config.buildconfig
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
         existing_size = replace_fit_totalsize(max_size + 1)
         run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
@@ -508,7 +508,7 @@ def test_vboot(u_boot_console, name, sha_algo, padding, sign_options, required,
         # Check that the boot fails if the global signature is not provided
         run_bootm(sha_algo, 'global image signature', 'signature is mandatory', False)
 
-    cons = u_boot_console
+    cons = ubman
     tmpdir = os.path.join(cons.config.result_dir, name) + '/'
     if not os.path.exists(tmpdir):
         os.mkdir(tmpdir)
@@ -577,7 +577,7 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('openssl')
 @pytest.mark.parametrize("name,sha_algo,padding,sign_options,algo_arg", TESTDATA)
-def test_fdt_add_pubkey(u_boot_console, name, sha_algo, padding, sign_options, algo_arg):
+def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
     """Test fdt_add_pubkey utility with bunch of different algo options."""
 
     def sign_fit(sha_algo, options):
@@ -625,7 +625,7 @@ def test_fdt_add_pubkey(u_boot_console, name, sha_algo, padding, sign_options, a
         # Check with fit_check_sign that FIT is signed with key
         util.run_and_log(cons, [fit_check_sign, '-f', fit, '-k', dtb])
 
-    cons = u_boot_console
+    cons = ubman
     tmpdir = os.path.join(cons.config.result_dir, name) + '/'
     if not os.path.exists(tmpdir):
         os.mkdir(tmpdir)
diff --git a/test/py/tests/test_vpl.py b/test/py/tests/test_vpl.py
index 8c472ca7a92..735e2c3bbbe 100644
--- a/test/py/tests/test_vpl.py
+++ b/test/py/tests/test_vpl.py
@@ -5,7 +5,7 @@
 import os.path
 import pytest
 
-def test_vpl(u_boot_console, ut_vpl_subtest):
+def test_vpl(ubman, ut_vpl_subtest):
     """Execute a "ut" subtest.
 
     The subtests are collected in function generate_ut_subtest() from linker
@@ -19,11 +19,11 @@ def test_vpl(u_boot_console, ut_vpl_subtest):
     implemented in C function foo_test_bar().
 
     Args:
-        u_boot_console (ConsoleBase): U-Boot console
+        ubman (ConsoleBase): U-Boot console
         ut_subtest (str): VPL test to be executed (e.g. 'dm platdata_phandle')
     """
     try:
-        cons = u_boot_console
+        cons = ubman
         cons.restart_uboot_with_flags(['-u', '-k', ut_vpl_subtest.split()[1]])
         output = cons.get_spawn_output().replace('\r', '')
         assert 'failures: 0' in output
@@ -31,4 +31,4 @@ def test_vpl(u_boot_console, ut_vpl_subtest):
         # Restart afterward in case a non-VPL test is run next. This should not
         # happen since VPL tests are run in their own invocation of test.py, but
         # the cost of doing this is not too great at present.
-        u_boot_console.restart_uboot()
+        ubman.restart_uboot()
diff --git a/test/py/tests/test_xxd/test_xxd.py b/test/py/tests/test_xxd/test_xxd.py
index 06b9cfc0003..c04bf8b7a25 100644
--- a/test/py/tests/test_xxd/test_xxd.py
+++ b/test/py/tests/test_xxd/test_xxd.py
@@ -7,14 +7,14 @@ import pytest
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_xxd')
-def test_xxd(u_boot_console, xxd_data):
+def test_xxd(ubman, xxd_data):
     """ Unit test for xxd
 
     Args:
-        u_boot_console -- U-Boot console
+        ubman -- U-Boot console
         xxd_data -- Path to the disk image used for testing.
     """
-    response = u_boot_console.run_command_list([
+    response = ubman.run_command_list([
         f'host bind 0 {xxd_data}',
         'xxd host 0 hello'])
 
diff --git a/test/py/tests/test_zynq_secure.py b/test/py/tests/test_zynq_secure.py
index 0ee5aebc484..0261d62a307 100644
--- a/test/py/tests/test_zynq_secure.py
+++ b/test/py/tests/test_zynq_secure.py
@@ -36,8 +36,8 @@ env__zynq_rsa_readable_file = {
 }
 """
 
-def zynq_secure_pre_commands(u_boot_console):
-    output = u_boot_console.run_command('print modeboot')
+def zynq_secure_pre_commands(ubman):
+    output = ubman.run_command('print modeboot')
     if not 'modeboot=' in output:
         pytest.skip('bootmode cannnot be determined')
     m = re.search('modeboot=(.+?)boot', output)
@@ -48,8 +48,8 @@ def zynq_secure_pre_commands(u_boot_console):
         pytest.skip('skipping due to jtag bootmode')
 
 @pytest.mark.buildconfigspec('cmd_zynq_aes')
-def test_zynq_aes_image(u_boot_console):
-    f = u_boot_console.config.env.get('env__zynq_aes_readable_file', None)
+def test_zynq_aes_image(ubman):
+    f = ubman.config.env.get('env__zynq_aes_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file for zynq secure aes case to read')
 
@@ -61,130 +61,130 @@ def test_zynq_aes_image(u_boot_console):
     if not dstsize:
         pytest.skip('No dstlen specified in env file to read')
 
-    zynq_secure_pre_commands(u_boot_console)
-    test_net.test_net_dhcp(u_boot_console)
+    zynq_secure_pre_commands(ubman)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fn))
+    output = ubman.run_command('tftpboot %x %s' % (srcaddr, fn))
     assert expected_tftp in output
 
     expected_op = 'zynq aes [operation type] <srcaddr>'
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         'zynq aes %x $filesize %x %x' % (srcaddr, dstaddr, dstsize)
     )
     assert expected_op not in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_zynq_aes')
-def test_zynq_aes_bitstream(u_boot_console):
-    f = u_boot_console.config.env.get('env__zynq_aes_readable_file', None)
+def test_zynq_aes_bitstream(ubman):
+    f = ubman.config.env.get('env__zynq_aes_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file for zynq secure aes case to read')
 
-    zynq_secure_pre_commands(u_boot_console)
-    test_net.test_net_dhcp(u_boot_console)
+    zynq_secure_pre_commands(ubman)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fnbit']
-    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fn))
+    output = ubman.run_command('tftpboot %x %s' % (srcaddr, fn))
     assert expected_tftp in output
 
     expected_op = 'zynq aes [operation type] <srcaddr>'
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         'zynq aes load %x $filesize' % (srcaddr)
     )
     assert expected_op not in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_zynq_aes')
-def test_zynq_aes_partial_bitstream(u_boot_console):
-    f = u_boot_console.config.env.get('env__zynq_aes_readable_file', None)
+def test_zynq_aes_partial_bitstream(ubman):
+    f = ubman.config.env.get('env__zynq_aes_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file for zynq secure aes case to read')
 
-    zynq_secure_pre_commands(u_boot_console)
-    test_net.test_net_dhcp(u_boot_console)
+    zynq_secure_pre_commands(ubman)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fnpbit']
-    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fn))
+    output = ubman.run_command('tftpboot %x %s' % (srcaddr, fn))
     assert expected_tftp in output
 
     expected_op = 'zynq aes [operation type] <srcaddr>'
-    output = u_boot_console.run_command('zynq aes loadp %x $filesize' % (srcaddr))
+    output = ubman.run_command('zynq aes loadp %x $filesize' % (srcaddr))
     assert expected_op not in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_zynq_rsa')
-def test_zynq_rsa_image(u_boot_console):
-    f = u_boot_console.config.env.get('env__zynq_rsa_readable_file', None)
+def test_zynq_rsa_image(ubman):
+    f = ubman.config.env.get('env__zynq_rsa_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file for zynq secure rsa case to read')
 
-    zynq_secure_pre_commands(u_boot_console)
-    test_net.test_net_dhcp(u_boot_console)
+    zynq_secure_pre_commands(ubman)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fn))
+    output = ubman.run_command('tftpboot %x %s' % (srcaddr, fn))
     assert expected_tftp in output
 
     expected_op = 'zynq rsa <baseaddr>'
-    output = u_boot_console.run_command('zynq rsa %x ' % (srcaddr))
+    output = ubman.run_command('zynq rsa %x ' % (srcaddr))
     assert expected_op not in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_zynq_rsa')
-def test_zynq_rsa_image_invalid(u_boot_console):
-    f = u_boot_console.config.env.get('env__zynq_rsa_readable_file', None)
+def test_zynq_rsa_image_invalid(ubman):
+    f = ubman.config.env.get('env__zynq_rsa_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file for zynq secure rsa case to read')
 
-    zynq_secure_pre_commands(u_boot_console)
-    test_net.test_net_dhcp(u_boot_console)
+    zynq_secure_pre_commands(ubman)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     expected_tftp = 'Bytes transferred = '
     fninvalid = f['fninvalid']
-    output = u_boot_console.run_command('tftpboot %x %s' % (srcaddr, fninvalid))
+    output = ubman.run_command('tftpboot %x %s' % (srcaddr, fninvalid))
     assert expected_tftp in output
 
     expected_op = 'zynq rsa <baseaddr>'
-    output = u_boot_console.run_command('zynq rsa %x ' % (srcaddr))
+    output = ubman.run_command('zynq rsa %x ' % (srcaddr))
     assert expected_op in output
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert not output.endswith('0')
diff --git a/test/py/tests/test_zynqmp_rpu.py b/test/py/tests/test_zynqmp_rpu.py
index 479a612b4ec..bbacaddc46a 100644
--- a/test/py/tests/test_zynqmp_rpu.py
+++ b/test/py/tests/test_zynqmp_rpu.py
@@ -33,8 +33,8 @@ env__zynqmp_rpu_apps = {
 """
 
 # Get rpu apps params from env
-def get_rpu_apps_env(u_boot_console):
-    rpu_apps = u_boot_console.config.env.get('env__zynqmp_rpu_apps', False)
+def get_rpu_apps_env(ubman):
+    rpu_apps = ubman.config.env.get('env__zynqmp_rpu_apps', False)
     if not rpu_apps:
         pytest.skip('ZynqMP RPU application info not defined!')
 
@@ -65,101 +65,101 @@ def get_rpu_apps_env(u_boot_console):
     return apps, procs, cpu_nums, addrs, outputs, tftp_addrs
 
 # Check return code
-def ret_code(u_boot_console):
-    return u_boot_console.run_command('echo $?')
+def ret_code(ubman):
+    return ubman.run_command('echo $?')
 
 # Initialize tcm
-def tcminit(u_boot_console, rpu_mode):
-    output = u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
+def tcminit(ubman, rpu_mode):
+    output = ubman.run_command('zynqmp tcminit %s' % rpu_mode)
     assert 'Initializing TCM overwrites TCM content' in output
-    return ret_code(u_boot_console)
+    return ret_code(ubman)
 
 # Load application in DDR
-def load_app_ddr(u_boot_console, tftp_addr, app):
-    output = u_boot_console.run_command('tftpboot %x %s' % (tftp_addr, app))
+def load_app_ddr(ubman, tftp_addr, app):
+    output = ubman.run_command('tftpboot %x %s' % (tftp_addr, app))
     assert 'TIMEOUT' not in output
     assert 'Bytes transferred = ' in output
 
     # Load elf
-    u_boot_console.run_command('bootelf -p %x' % tftp_addr)
-    assert ret_code(u_boot_console).endswith('0')
+    ubman.run_command('bootelf -p %x' % tftp_addr)
+    assert ret_code(ubman).endswith('0')
 
 # Disable cpus
-def disable_cpus(u_boot_console, cpu_nums):
+def disable_cpus(ubman, cpu_nums):
     for num in cpu_nums:
-        u_boot_console.run_command(f'cpu {num} disable')
+        ubman.run_command(f'cpu {num} disable')
 
 # Load apps on RPU cores
-def rpu_apps_load(u_boot_console, rpu_mode):
+def rpu_apps_load(ubman, rpu_mode):
     apps, procs, cpu_nums, addrs, outputs, tftp_addrs = get_rpu_apps_env(
-        u_boot_console)
-    test_net.test_net_dhcp(u_boot_console)
+        ubman)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     try:
-        assert tcminit(u_boot_console, rpu_mode).endswith('0')
+        assert tcminit(ubman, rpu_mode).endswith('0')
 
         for i in range(len(apps)):
             if rpu_mode == 'lockstep' and procs[i] != 'rpu0':
                 continue
 
-            load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
+            load_app_ddr(ubman, tftp_addrs[i], apps[i])
             rel_addr = int(addrs[i] + 0x3C)
 
             # Release cpu at app load address
             cpu_num = cpu_nums[i]
             cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
-            output = u_boot_console.run_command(cmd)
+            output = ubman.run_command(cmd)
             exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
             assert exp_op in output
             assert f'R5 {rpu_mode} mode' in output
-            u_boot_console.wait_for(outputs[i])
-            assert ret_code(u_boot_console).endswith('0')
+            ubman.wait_for(outputs[i])
+            assert ret_code(ubman).endswith('0')
     finally:
-        disable_cpus(u_boot_console, cpu_nums)
+        disable_cpus(ubman, cpu_nums)
 
 @pytest.mark.buildconfigspec('cmd_zynqmp')
-def test_zynqmp_rpu_app_load_split(u_boot_console):
-    rpu_apps_load(u_boot_console, 'split')
+def test_zynqmp_rpu_app_load_split(ubman):
+    rpu_apps_load(ubman, 'split')
 
 @pytest.mark.buildconfigspec('cmd_zynqmp')
-def test_zynqmp_rpu_app_load_lockstep(u_boot_console):
-    rpu_apps_load(u_boot_console, 'lockstep')
+def test_zynqmp_rpu_app_load_lockstep(ubman):
+    rpu_apps_load(ubman, 'lockstep')
 
 @pytest.mark.buildconfigspec('cmd_zynqmp')
-def test_zynqmp_rpu_app_load_negative(u_boot_console):
+def test_zynqmp_rpu_app_load_negative(ubman):
     apps, procs, cpu_nums, addrs, outputs, tftp_addrs = get_rpu_apps_env(
-        u_boot_console)
+        ubman)
 
     # Invalid commands
-    u_boot_console.run_command('zynqmp tcminit mode')
-    assert ret_code(u_boot_console).endswith('1')
+    ubman.run_command('zynqmp tcminit mode')
+    assert ret_code(ubman).endswith('1')
 
     rand_str = ''.join(random.choices(string.ascii_lowercase, k=4))
-    u_boot_console.run_command('zynqmp tcminit %s' % rand_str)
-    assert ret_code(u_boot_console).endswith('1')
+    ubman.run_command('zynqmp tcminit %s' % rand_str)
+    assert ret_code(ubman).endswith('1')
 
     rand_num = random.randint(2, 100)
-    u_boot_console.run_command('zynqmp tcminit %d' % rand_num)
-    assert ret_code(u_boot_console).endswith('1')
+    ubman.run_command('zynqmp tcminit %d' % rand_num)
+    assert ret_code(ubman).endswith('1')
 
-    test_net.test_net_dhcp(u_boot_console)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     try:
         rpu_mode = 'split'
-        assert tcminit(u_boot_console, rpu_mode).endswith('0')
+        assert tcminit(ubman, rpu_mode).endswith('0')
 
         for i in range(len(apps)):
-            load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
+            load_app_ddr(ubman, tftp_addrs[i], apps[i])
 
             # Run in split mode at different load address
             rel_addr = int(addrs[i]) + random.randint(200, 1000)
             cpu_num = cpu_nums[i]
             cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
-            output = u_boot_console.run_command(cmd)
+            output = ubman.run_command(cmd)
             exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
             assert exp_op in output
             assert f'R5 {rpu_mode} mode' in output
@@ -168,41 +168,41 @@ def test_zynqmp_rpu_app_load_negative(u_boot_console):
             # Invalid rpu mode
             rand_str = ''.join(random.choices(string.ascii_lowercase, k=4))
             cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rand_str)
-            output = u_boot_console.run_command(cmd)
+            output = ubman.run_command(cmd)
             assert exp_op in output
             assert f'Unsupported mode' in output
-            assert not ret_code(u_boot_console).endswith('0')
+            assert not ret_code(ubman).endswith('0')
 
         # Switch to lockstep mode, without disabling CPUs
         rpu_mode = 'lockstep'
-        u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
-        assert not ret_code(u_boot_console).endswith('0')
+        ubman.run_command('zynqmp tcminit %s' % rpu_mode)
+        assert not ret_code(ubman).endswith('0')
 
         # Disable cpus
-        disable_cpus(u_boot_console, cpu_nums)
+        disable_cpus(ubman, cpu_nums)
 
         # Switch to lockstep mode, after disabling CPUs
-        output = u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
+        output = ubman.run_command('zynqmp tcminit %s' % rpu_mode)
         assert 'Initializing TCM overwrites TCM content' in output
-        assert ret_code(u_boot_console).endswith('0')
+        assert ret_code(ubman).endswith('0')
 
         # Run lockstep mode for RPU1
         for i in range(len(apps)):
             if procs[i] == 'rpu0':
                 continue
 
-            load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
+            load_app_ddr(ubman, tftp_addrs[i], apps[i])
             rel_addr = int(addrs[i] + 0x3C)
             cpu_num = cpu_nums[i]
             cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
-            output = u_boot_console.run_command(cmd)
+            output = ubman.run_command(cmd)
             exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
             assert exp_op in output
             assert f'R5 {rpu_mode} mode' in output
-            assert u_boot_console.p.expect([outputs[i]])
+            assert ubman.p.expect([outputs[i]])
     finally:
-        disable_cpus(u_boot_console, cpu_nums)
+        disable_cpus(ubman, cpu_nums)
         # This forces the console object to be shutdown, so any subsequent test
         # will reset the board back into U-Boot.
-        u_boot_console.drain_console()
-        u_boot_console.cleanup_spawn()
+        ubman.drain_console()
+        ubman.cleanup_spawn()
diff --git a/test/py/tests/test_zynqmp_secure.py b/test/py/tests/test_zynqmp_secure.py
index 570bd2439c1..7549e2cc39f 100644
--- a/test/py/tests/test_zynqmp_secure.py
+++ b/test/py/tests/test_zynqmp_secure.py
@@ -30,75 +30,75 @@ env__zynqmp_secure_readable_file = {
 """
 
 @pytest.mark.buildconfigspec('cmd_zynqmp')
-def test_zynqmp_secure_boot_image(u_boot_console):
+def test_zynqmp_secure_boot_image(ubman):
     """This test verifies secure boot image at the DDR address for
     authentication only case.
     """
 
-    f = u_boot_console.config.env.get('env__zynqmp_secure_readable_file', None)
+    f = ubman.config.env.get('env__zynqmp_secure_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file for zynqmp secure cases to read')
 
-    test_net.test_net_dhcp(u_boot_console)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    output = ubman.run_command('tftpboot %x %s' % (addr, fn))
     assert expected_tftp in output
 
-    output = u_boot_console.run_command('zynqmp secure %x $filesize' % (addr))
+    output = ubman.run_command('zynqmp secure %x $filesize' % (addr))
     assert 'Verified image at' in output
     ver_addr = re.search(r'Verified image at 0x(.+)', output).group(1)
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
-    output = u_boot_console.run_command('print zynqmp_verified_img_addr')
+    output = ubman.run_command('print zynqmp_verified_img_addr')
     assert f'zynqmp_verified_img_addr={ver_addr}' in output
     assert 'Error' not in output
 
 
 @pytest.mark.buildconfigspec('cmd_zynqmp')
-def test_zynqmp_secure_boot_img_kup(u_boot_console):
+def test_zynqmp_secure_boot_img_kup(ubman):
     """This test verifies secure boot image at the DDR address for encryption
     with kup key case.
     """
 
-    f = u_boot_console.config.env.get('env__zynqmp_secure_readable_file', None)
+    f = ubman.config.env.get('env__zynqmp_secure_readable_file', None)
     if not f:
         pytest.skip('No TFTP readable file for zynqmp secure cases to read')
 
-    test_net.test_net_dhcp(u_boot_console)
+    test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-        test_net.test_net_setup_static(u_boot_console)
+        test_net.test_net_setup_static(ubman)
 
     keyaddr = f.get('keyaddr', None)
     if not keyaddr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
     expected_tftp = 'Bytes transferred = '
     keyfn = f['keyfn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (keyaddr, keyfn))
+    output = ubman.run_command('tftpboot %x %s' % (keyaddr, keyfn))
     assert expected_tftp in output
 
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(u_boot_console)
+        addr = u_boot_utils.find_ram_base(ubman)
     expected_tftp = 'Bytes transferred = '
     fn = f['enckupfn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    output = ubman.run_command('tftpboot %x %s' % (addr, fn))
     assert expected_tftp in output
 
-    output = u_boot_console.run_command(
+    output = ubman.run_command(
         'zynqmp secure %x $filesize %x' % (addr, keyaddr)
     )
     assert 'Verified image at' in output
     ver_addr = re.search(r'Verified image at 0x(.+)', output).group(1)
-    output = u_boot_console.run_command('echo $?')
+    output = ubman.run_command('echo $?')
     assert output.endswith('0')
-    output = u_boot_console.run_command('print zynqmp_verified_img_addr')
+    output = ubman.run_command('print zynqmp_verified_img_addr')
     assert f'zynqmp_verified_img_addr={ver_addr}' in output
     assert 'Error' not in output
diff --git a/test/py/u_boot_utils.py b/test/py/u_boot_utils.py
index 9e161fbc238..ca80e4b0b0a 100644
--- a/test/py/u_boot_utils.py
+++ b/test/py/u_boot_utils.py
@@ -55,7 +55,7 @@ class PersistentRandomFile:
     """Generate and store information about a persistent file containing
     random data."""
 
-    def __init__(self, u_boot_console, fn, size):
+    def __init__(self, ubman, fn, size):
         """Create or process the persistent file.
 
         If the file does not exist, it is generated.
@@ -66,7 +66,7 @@ class PersistentRandomFile:
         the current test run.
 
         Args:
-            u_boot_console: A console connection to U-Boot.
+            ubman: A console connection to U-Boot.
             fn: The filename (without path) to create.
             size: The desired size of the file in bytes.
 
@@ -76,14 +76,14 @@ class PersistentRandomFile:
 
         self.fn = fn
 
-        self.abs_fn = u_boot_console.config.persistent_data_dir + '/' + fn
+        self.abs_fn = ubman.config.persistent_data_dir + '/' + fn
 
         if os.path.exists(self.abs_fn):
-            u_boot_console.log.action('Persistent data file ' + self.abs_fn +
+            ubman.log.action('Persistent data file ' + self.abs_fn +
                 ' already exists')
             self.content_hash = md5sum_file(self.abs_fn)
         else:
-            u_boot_console.log.action('Generating ' + self.abs_fn +
+            ubman.log.action('Generating ' + self.abs_fn +
                 ' (random, persistent, %d bytes)' % size)
             data = os.urandom(size)
             with open(self.abs_fn, 'wb') as fh:
@@ -157,11 +157,11 @@ def wait_until_file_open_fails(fn, ignore_errors):
         return
     raise Exception('File can still be opened')
 
-def run_and_log(u_boot_console, cmd, ignore_errors=False, stdin=None, env=None):
+def run_and_log(ubman, cmd, ignore_errors=False, stdin=None, env=None):
     """Run a command and log its output.
 
     Args:
-        u_boot_console: A console connection to U-Boot.
+        ubman: A console connection to U-Boot.
         cmd: The command to run, as an array of argv[], or a string.
             If a string, note that it is split up so that quoted spaces
             will not be preserved. E.g. "fred and" becomes ['"fred', 'and"']
@@ -177,25 +177,25 @@ def run_and_log(u_boot_console, cmd, ignore_errors=False, stdin=None, env=None):
     """
     if isinstance(cmd, str):
         cmd = cmd.split()
-    runner = u_boot_console.log.get_runner(cmd[0], sys.stdout)
+    runner = ubman.log.get_runner(cmd[0], sys.stdout)
     output = runner.run(cmd, ignore_errors=ignore_errors, stdin=stdin, env=env)
     runner.close()
     return output
 
-def run_and_log_expect_exception(u_boot_console, cmd, retcode, msg):
+def run_and_log_expect_exception(ubman, cmd, retcode, msg):
     """Run a command that is expected to fail.
 
     This runs a command and checks that it fails with the expected return code
     and exception method. If not, an exception is raised.
 
     Args:
-        u_boot_console: A console connection to U-Boot.
+        ubman: A console connection to U-Boot.
         cmd: The command to run, as an array of argv[].
         retcode: Expected non-zero return code from the command.
         msg: String that should be contained within the command's output.
     """
     try:
-        runner = u_boot_console.log.get_runner(cmd[0], sys.stdout)
+        runner = ubman.log.get_runner(cmd[0], sys.stdout)
         runner.run(cmd)
     except Exception:
         assert retcode == runner.exit_status
@@ -207,7 +207,7 @@ def run_and_log_expect_exception(u_boot_console, cmd, retcode, msg):
         runner.close()
 
 ram_base = None
-def find_ram_base(u_boot_console):
+def find_ram_base(ubman):
     """Find the running U-Boot's RAM location.
 
     Probe the running U-Boot to determine the address of the first bank
@@ -218,22 +218,22 @@ def find_ram_base(u_boot_console):
     actively read once.
 
     Args:
-        u_boot_console: A console connection to U-Boot.
+        ubman: A console connection to U-Boot.
 
     Returns:
         The address of U-Boot's first RAM bank, as an integer.
     """
 
     global ram_base
-    if u_boot_console.config.buildconfig.get('config_cmd_bdi', 'n') != 'y':
+    if ubman.config.buildconfig.get('config_cmd_bdi', 'n') != 'y':
         pytest.skip('bdinfo command not supported')
     if ram_base == -1:
         pytest.skip('Previously failed to find RAM bank start')
     if ram_base is not None:
         return ram_base
 
-    with u_boot_console.log.section('find_ram_base'):
-        response = u_boot_console.run_command('bdinfo')
+    with ubman.log.section('find_ram_base'):
+        response = ubman.run_command('bdinfo')
         for l in response.split('\n'):
             if '-> start' in l or 'memstart    =' in l:
                 ram_base = int(l.split('=')[1].strip(), 16)
@@ -311,11 +311,11 @@ def persistent_file_helper(u_boot_log, filename):
     statement
 
     Usage:
-        with persistent_file_helper(u_boot_console.log, filename):
+        with persistent_file_helper(ubman.log, filename):
             code to generate the file, if it's missing.
 
     Args:
-        u_boot_log: u_boot_console.log.
+        u_boot_log: ubman.log.
         filename: The filename of the generated file.
 
     Returns:
@@ -324,11 +324,11 @@ def persistent_file_helper(u_boot_log, filename):
 
     return PersistentFileHelperCtxMgr(u_boot_log, filename)
 
-def crc32(u_boot_console, address, count):
+def crc32(ubman, address, count):
     """Helper function used to compute the CRC32 value of a section of RAM.
 
     Args:
-        u_boot_console: A U-Boot console connection.
+        ubman: A U-Boot console connection.
         address: Address where data starts.
         count: Amount of data to use for calculation.
 
@@ -336,10 +336,10 @@ def crc32(u_boot_console, address, count):
         CRC32 value
     """
 
-    bcfg = u_boot_console.config.buildconfig
+    bcfg = ubman.config.buildconfig
     has_cmd_crc32 = bcfg.get('config_cmd_crc32', 'n') == 'y'
     assert has_cmd_crc32, 'Cannot compute crc32 without CONFIG_CMD_CRC32.'
-    output = u_boot_console.run_command('crc32 %08x %x' % (address, count))
+    output = ubman.run_command('crc32 %08x %x' % (address, count))
 
     m = re.search('==> ([0-9a-fA-F]{8})$', output)
     assert m, 'CRC32 operation failed.'
-- 
2.43.0

