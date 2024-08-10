Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A1DC3DA7F
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 01:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E6348852A;
	Sun, 11 Aug 2024 03:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I7fXcbgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA7B8890D; Sat, 10 Aug 2024 22:52:32 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A298B88881
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f860c6015so125643339f.0
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323144; x=1723927944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skp8GjGm85LetViSsi0n5OnFZUmyHa49ZUSuxVZpaAY=;
 b=I7fXcbgKpwCyH837nGCBia7EJUc0jyu3a+SmkgYV5b1WSghmJlz4sEUsqTMncaTKsl
 dVdfkXGBgHNiWlKMhx2SvQq9EjXskMx+GUEjt69/NlwEm1TfKg9ip2GPEgl+FioFeHyo
 9kY1zqo81a0kmuz7FLHUORlo7YKwqjg+xy6ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323144; x=1723927944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skp8GjGm85LetViSsi0n5OnFZUmyHa49ZUSuxVZpaAY=;
 b=R7hk/YmF90tQsaCkMG6nQkBAg+IG7KiWhHEOZJdPs1+EmZz5FbAEqE/td/ET93O2Xu
 JVoBmMPAZOZWLaY4f8dthab1So8Jyn2tuPMTPh34aEK79IXZVNGRlYAjn53TB7gChfa6
 UJgaPRjobNnnGCVBAsGv6vOCE1rQe/nYtpARbpykoLzK0MiJ7MOjMO0U5c3ZvFRrMyYZ
 C5zh3j990rSu2iyoYOUnJauBPa/Qa+uuPWopcgjMUuZ4O6WSY8GH1QU6q7+UrAtlc/1N
 lMkX5cJN8d89pGL7P6qY3K+HAujh7Fbg+ixbXvqJGOMKzOS5fTycbG8vRM9eNj80Itoy
 fyFA==
X-Gm-Message-State: AOJu0YxA/Lm2tdpFpEVHqQx6oPz+kI43XitHOHAZkwirxdVwdYuQQINd
 Q1SoYMJ3zjrjpZ63ezKyDY9VvwiCfR5Jv4ms/LkKkYSsexgpU0u0B0aYPO2IVVNApoSZWo6atFs
 =
X-Google-Smtp-Source: AGHT+IHtxGzeFXVYXs8TuH/EoZ3yjOQV2QhwR4BFrdoUky7FW3rPh1kBUB9ZFD+wMe9/hTXPNHSmjA==
X-Received: by 2002:a05:6602:6b82:b0:812:9c27:357c with SMTP id
 ca18e2360f4ac-8225ee7a17fmr812666039f.8.1723323142962; 
 Sat, 10 Aug 2024 13:52:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Dahl <ada@thorsis.com>, Alexander Gendin <agendin@matrox.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Stephen Carlson <stcarlso@linux.microsoft.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 03/21] test: Rename unit-test flags
Date: Sat, 10 Aug 2024 14:51:47 -0600
Message-Id: <20240810205205.3403177-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Aug 2024 03:30:10 +0200
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

The UT_TESTF_ macros read as 'unit test test flags' which is not right.
Rename to UTF ('unit test flags').

This has the benefit of being shorter, which helps keep UNIT_TEST()
declarations on a single line.

Give the enum a name and reference it from the UNIT_TEST() macros while
we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/commands.rst      |   2 +-
 doc/develop/tests_writing.rst |  14 ++---
 doc/usage/cmd/ut.rst          |   2 +-
 include/dm/test.h             |   2 +-
 include/test/spl.h            |   2 +-
 include/test/test.h           |  32 +++++-----
 include/test/ut.h             |   2 +-
 test/boot/bootdev.c           |  36 +++++-------
 test/boot/bootflow.c          |  38 ++++++------
 test/boot/bootmeth.c          |  10 ++--
 test/boot/expo.c              |  14 ++---
 test/boot/upl.c               |   6 +-
 test/boot/vbe_fixup.c         |   4 +-
 test/boot/vbe_simple.c        |   2 +-
 test/cmd/addrmap.c            |   2 +-
 test/cmd/armffa.c             |   2 +-
 test/cmd/bdinfo.c             |   8 +--
 test/cmd/exit.c               |   2 +-
 test/cmd/fdt.c                |  38 ++++++------
 test/cmd/font.c               |   4 +-
 test/cmd/history.c            |   2 +-
 test/cmd/loadm.c              |   4 +-
 test/cmd/mbr.c                |   4 +-
 test/cmd/mem_search.c         |  18 +++---
 test/cmd/pci_mps.c            |   2 +-
 test/cmd/pinmux.c             |   2 +-
 test/cmd/pwm.c                |   2 +-
 test/cmd/rw.c                 |   2 +-
 test/cmd/seama.c              |   6 +-
 test/cmd/setexpr.c            |  22 +++----
 test/cmd/temperature.c        |   2 +-
 test/common/event.c           |   2 +-
 test/dm/acpi.c                |  32 +++++-----
 test/dm/acpi_dp.c             |   2 +-
 test/dm/acpigen.c             |  19 +++---
 test/dm/adc.c                 |  16 ++---
 test/dm/audio.c               |   2 +-
 test/dm/axi.c                 |   6 +-
 test/dm/blk.c                 |  16 ++---
 test/dm/bootcount.c           |   6 +-
 test/dm/bus.c                 |  26 ++++-----
 test/dm/button.c              |  12 ++--
 test/dm/cache.c               |   2 +-
 test/dm/clk.c                 |   6 +-
 test/dm/clk_ccf.c             |   2 +-
 test/dm/core.c                |  46 +++++++--------
 test/dm/cpu.c                 |   2 +-
 test/dm/cros_ec.c             |  12 ++--
 test/dm/cros_ec_pwm.c         |   2 +-
 test/dm/devres.c              |  12 ++--
 test/dm/dma.c                 |   6 +-
 test/dm/dsa.c                 |   4 +-
 test/dm/dsi_host.c            |   2 +-
 test/dm/ecdsa.c               |   2 +-
 test/dm/efi_media.c           |   2 +-
 test/dm/eth.c                 |  20 +++----
 test/dm/extcon.c              |   2 +-
 test/dm/fastboot.c            |   2 +-
 test/dm/fdtdec.c              |   4 +-
 test/dm/ffa.c                 |   4 +-
 test/dm/firmware.c            |   2 +-
 test/dm/fpga.c                |   2 +-
 test/dm/fwu_mdata.c           |   4 +-
 test/dm/gpio.c                |  32 +++++-----
 test/dm/host.c                |   6 +-
 test/dm/hwspinlock.c          |   2 +-
 test/dm/i2c.c                 |  18 +++---
 test/dm/i2s.c                 |   2 +-
 test/dm/iommu.c               |   8 +--
 test/dm/irq.c                 |  10 ++--
 test/dm/led.c                 |  12 ++--
 test/dm/mailbox.c             |   2 +-
 test/dm/mdio.c                |   2 +-
 test/dm/mdio_mux.c            |   2 +-
 test/dm/memory.c              |   2 +-
 test/dm/misc.c                |   2 +-
 test/dm/mmc.c                 |   4 +-
 test/dm/mux-cmd.c             |   6 +-
 test/dm/mux-emul.c            |   4 +-
 test/dm/mux-mmio.c            |   4 +-
 test/dm/nand.c                |   4 +-
 test/dm/nop.c                 |   2 +-
 test/dm/nvmxip.c              |   2 +-
 test/dm/of_platdata.c         |  16 ++---
 test/dm/ofnode.c              | 106 +++++++++++++++++-----------------
 test/dm/ofread.c              |   2 +-
 test/dm/osd.c                 |   4 +-
 test/dm/p2sb.c                |   2 +-
 test/dm/panel.c               |   2 +-
 test/dm/part.c                |   6 +-
 test/dm/pch.c                 |   4 +-
 test/dm/pci.c                 |  31 +++++-----
 test/dm/pci_ep.c              |   2 +-
 test/dm/phy.c                 |  10 ++--
 test/dm/phys2bus.c            |   2 +-
 test/dm/pinmux.c              |   6 +-
 test/dm/pmc.c                 |   2 +-
 test/dm/pmic.c                |  12 ++--
 test/dm/power-domain.c        |   2 +-
 test/dm/pwm.c                 |   2 +-
 test/dm/qfw.c                 |   4 +-
 test/dm/ram.c                 |   2 +-
 test/dm/read.c                |   2 +-
 test/dm/reboot-mode.c         |   4 +-
 test/dm/regmap.c              |  17 +++---
 test/dm/regulator.c           |  20 +++----
 test/dm/remoteproc.c          |   4 +-
 test/dm/reset.c               |  10 ++--
 test/dm/rkmtd.c               |   6 +-
 test/dm/rng.c                 |   4 +-
 test/dm/rtc.c                 |  14 ++---
 test/dm/scmi.c                |  14 ++---
 test/dm/scsi.c                |   2 +-
 test/dm/serial.c              |   2 +-
 test/dm/sf.c                  |   4 +-
 test/dm/simple-bus.c          |   2 +-
 test/dm/simple-pm-bus.c       |   2 +-
 test/dm/sm.c                  |   2 +-
 test/dm/smem.c                |   2 +-
 test/dm/soc.c                 |   2 +-
 test/dm/sound.c               |   4 +-
 test/dm/spi.c                 |   6 +-
 test/dm/spmi.c                |   6 +-
 test/dm/syscon-reset.c        |   2 +-
 test/dm/syscon.c              |   6 +-
 test/dm/sysinfo-gpio.c        |   2 +-
 test/dm/sysinfo.c             |   2 +-
 test/dm/sysreset.c            |   8 +--
 test/dm/tee.c                 |   2 +-
 test/dm/test-fdt.c            |  57 +++++++++---------
 test/dm/timer.c               |   4 +-
 test/dm/tpm.c                 |   8 +--
 test/dm/usb.c                 |  12 ++--
 test/dm/video.c               |  42 +++++++-------
 test/dm/virtio.c              |   2 +-
 test/dm/virtio_device.c       |   8 +--
 test/dm/virtio_rng.c          |   2 +-
 test/dm/wdt.c                 |   8 +--
 test/log/log_filter.c         |   4 +-
 test/log/log_test.c           |  32 +++++-----
 test/print_ut.c               |   6 +-
 test/test-main.c              |  40 ++++++-------
 142 files changed, 633 insertions(+), 653 deletions(-)

diff --git a/doc/develop/commands.rst b/doc/develop/commands.rst
index 5ad4e59c838..6427844f143 100644
--- a/doc/develop/commands.rst
+++ b/doc/develop/commands.rst
@@ -223,4 +223,4 @@ Here is an example:
 
         return 0;
     }
-    DM_TEST(dm_test_acpi_cmd_items, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+    DM_TEST(dm_test_acpi_cmd_items, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 44b544fa78b..655eb95110d 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -81,7 +81,7 @@ The best of both worlds is sometimes to have a Python test set things up and
 perform some operations, with a 'checker' C unit test doing the checks
 afterwards. This can be achieved with these steps:
 
-- Add the `UT_TESTF_MANUAL` flag to the checker test so that the `ut` command
+- Add the `UTF_MANUAL` flag to the checker test so that the `ut` command
   does not run it by default
 - Add a `_norun` suffix to the name so that pytest knows to skip it too
 
@@ -95,7 +95,7 @@ test to run it, e.g.::
    # Run the checker to make sure that everything worked
    ut -f bootstd vbe_test_fixup_norun
 
-Note that apart from the `UT_TESTF_MANUAL` flag, the code in a 'manual' C test
+Note that apart from the `UTF_MANUAL` flag, the code in a 'manual' C test
 is just like any other C test. It still uses ut_assert...() and other such
 constructs, in this case to check that the expected things happened in the
 Python test.
@@ -167,7 +167,7 @@ There is no exactly equivalent C test, but here is a similar one that tests 'ms'
 
       return 0;
    }
-   MEM_TEST(mem_test_ms_b, UT_TESTF_CONSOLE_REC);
+   MEM_TEST(mem_test_ms_b, UTF_CONSOLE_REC);
 
 This runs the command directly in U-Boot, then checks the console output, also
 directly in U-Boot. If run by itself this takes 100ms. For 1000 runs it takes
@@ -226,14 +226,14 @@ Declare the test with::
 
       return 0;
    }
-   DM_TEST(dm_test_uclassname_what, UT_TESTF_SCAN_FDT);
+   DM_TEST(dm_test_uclassname_what, UTF_SCAN_FDT);
 
 Replace 'uclassname' with the name of your uclass, if applicable. Replace 'what'
 with what you are testing.
 
 The flags for DM_TEST() are defined in test/test.h and you typically want
-UT_TESTF_SCAN_FDT so that the devicetree is scanned and all devices are bound
-and ready for use. The DM_TEST macro adds UT_TESTF_DM automatically so that
+UTF_SCAN_FDT so that the devicetree is scanned and all devices are bound
+and ready for use. The DM_TEST macro adds UTF_DM automatically so that
 the test runner knows it is a driver model test.
 
 Driver model tests are special in that the entire driver model state is
@@ -263,7 +263,7 @@ with the suite. For example, to add a new mem_search test::
 
          return 0;
    }
-   MEM_TEST(mem_test_ms_new_thing, UT_TESTF_CONSOLE_REC);
+   MEM_TEST(mem_test_ms_new_thing, UTF_CONSOLE_REC);
 
 Note that the MEM_TEST() macros is defined at the top of the file.
 
diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index 45bc9ffbdc5..afeafa824d6 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -32,7 +32,7 @@ to run some tests on real boards.
 
 For a list of available test suites, type `ut` by itself.
 
-Each test is normally run once, although those marked with `UT_TESTF_DM` are
+Each test is normally run once, although those marked with `UTF_DM` are
 run with livetree and flattree where possible. To run a test more than once,
 use the `-r` flag.
 
diff --git a/include/dm/test.h b/include/dm/test.h
index 02737411a16..61776c8dda1 100644
--- a/include/dm/test.h
+++ b/include/dm/test.h
@@ -143,7 +143,7 @@ extern struct unit_test_state global_dm_test_state;
 
 /* Declare a new driver model test */
 #define DM_TEST(_name, _flags) \
-	UNIT_TEST(_name, UT_TESTF_DM | UT_TESTF_CONSOLE_REC | (_flags), dm_test)
+	UNIT_TEST(_name, UTF_DM | UTF_CONSOLE_REC | (_flags), dm_test)
 
 /*
  * struct sandbox_sdl_plat - Platform data for the SDL video driver
diff --git a/include/test/spl.h b/include/test/spl.h
index a2a5f33e328..5fd28d92706 100644
--- a/include/test/spl.h
+++ b/include/test/spl.h
@@ -154,6 +154,6 @@ SPL_TEST(func##_##type, flags)
 #define SPL_TEST_DATA_SIZE	4099
 
 /* Flags necessary for accessing DM devices */
-#define DM_FLAGS (UT_TESTF_DM | UT_TESTF_SCAN_FDT)
+#define DM_FLAGS (UTF_DM | UTF_SCAN_FDT)
 
 #endif /* TEST_SPL_H */
diff --git a/include/test/test.h b/include/test/test.h
index 838e3ce8a8f..9ad73daf7f8 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -24,11 +24,11 @@
  * @fdt_chksum: crc8 of the device tree contents
  * @fdt_copy: Copy of the device tree
  * @fdt_size: Size of the device-tree copy
- * @other_fdt: Buffer for the other FDT (UT_TESTF_OTHER_FDT)
- * @other_fdt_size: Size of the other FDT (UT_TESTF_OTHER_FDT)
+ * @other_fdt: Buffer for the other FDT (UTF_OTHER_FDT)
+ * @other_fdt_size: Size of the other FDT (UTF_OTHER_FDT)
  * @of_other: Live tree for the other FDT
  * @runs_per_test: Number of times to run each test (typically 1)
- * @force_run: true to run tests marked with the UT_TESTF_MANUAL flag
+ * @force_run: true to run tests marked with the UTF_MANUAL flag
  * @expect_str: Temporary string used to hold expected string value
  * @actual_str: Temporary string used to hold actual string value
  */
@@ -55,24 +55,24 @@ struct unit_test_state {
 };
 
 /* Test flags for each test */
-enum {
-	UT_TESTF_SCAN_PDATA	= BIT(0),	/* test needs platform data */
-	UT_TESTF_PROBE_TEST	= BIT(1),	/* probe test uclass */
-	UT_TESTF_SCAN_FDT	= BIT(2),	/* scan device tree */
-	UT_TESTF_FLAT_TREE	= BIT(3),	/* test needs flat DT */
-	UT_TESTF_LIVE_TREE	= BIT(4),	/* needs live device tree */
-	UT_TESTF_CONSOLE_REC	= BIT(5),	/* needs console recording */
+enum ut_flags {
+	UTF_SCAN_PDATA	= BIT(0),	/* test needs platform data */
+	UTF_PROBE_TEST	= BIT(1),	/* probe test uclass */
+	UTF_SCAN_FDT	= BIT(2),	/* scan device tree */
+	UTF_FLAT_TREE	= BIT(3),	/* test needs flat DT */
+	UTF_LIVE_TREE	= BIT(4),	/* needs live device tree */
+	UTF_CONSOLE_REC	= BIT(5),	/* needs console recording */
 	/* do extra driver model init and uninit */
-	UT_TESTF_DM		= BIT(6),
-	UT_TESTF_OTHER_FDT	= BIT(7),	/* read in other device tree */
+	UTF_DM		= BIT(6),
+	UTF_OTHER_FDT	= BIT(7),	/* read in other device tree */
 	/*
 	 * Only run if explicitly requested with 'ut -f <suite> <test>'. The
 	 * test name must end in "_norun" so that pytest detects this also,
 	 * since it cannot access the flags.
 	 */
-	UT_TESTF_MANUAL		= BIT(8),
-	UT_TESTF_ETH_BOOTDEV	= BIT(9),	/* enable Ethernet bootdevs */
-	UT_TESTF_SF_BOOTDEV	= BIT(10),	/* enable SPI flash bootdevs */
+	UTF_MANUAL	= BIT(8),
+	UTF_ETH_BOOTDEV	= BIT(9),	/* enable Ethernet bootdevs */
+	UTF_SF_BOOTDEV	= BIT(10),	/* enable SPI flash bootdevs */
 };
 
 /**
@@ -109,7 +109,7 @@ struct unit_test {
  * @_name:	concatenation of name of the test suite, "_test_", and the name
  *		of the test
  * @_flags:	an integer field that can be evaluated by the test suite
- *		implementation
+ *		implementation (see enum ut_flags)
  * @_suite:	name of the test suite concatenated with "_test"
  */
 #define UNIT_TEST(_name, _flags, _suite)				\
diff --git a/include/test/ut.h b/include/test/ut.h
index d3172af8083..c8838dad096 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -495,7 +495,7 @@ void test_set_state(struct unit_test_state *uts);
  * @select_name: Name of a single test to run (from the list provided). If NULL
  *	then all tests are run
  * @runs_per_test: Number of times to run each test (typically 1)
- * @force_run: Run tests that are marked as manual-only (UT_TESTF_MANUAL)
+ * @force_run: Run tests that are marked as manual-only (UTF_MANUAL)
  * @test_insert: String describing a test to run after n other tests run, in the
  * format n:name where n is the number of tests to run before this one and
  * name is the name of the test to run. This is used to find which test causes
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 1bf5929c396..9a364d0f267 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -49,7 +49,7 @@ static int bootdev_test_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_cmd_list, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_cmd_list, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootdev select' and 'info' commands */
 static int bootdev_test_cmd_select(struct unit_test_state *uts)
@@ -99,7 +99,7 @@ static int bootdev_test_cmd_select(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_cmd_select, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_cmd_select, UTF_DM | UTF_SCAN_FDT);
 
 /* Check bootdev labels */
 static int bootdev_test_labels(struct unit_test_state *uts)
@@ -131,8 +131,7 @@ static int bootdev_test_labels(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_labels, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
-	     UT_TESTF_ETH_BOOTDEV);
+BOOTSTD_TEST(bootdev_test_labels, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
 
 /* Check bootdev_find_by_any() */
 static int bootdev_test_any(struct unit_test_state *uts)
@@ -186,8 +185,7 @@ static int bootdev_test_any(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_any, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
-	     UT_TESTF_ETH_BOOTDEV);
+BOOTSTD_TEST(bootdev_test_any, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
 
 /*
  * Check bootdev ordering with the bootdev-order property and boot_targets
@@ -274,7 +272,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_order, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_order, UTF_DM | UTF_SCAN_FDT);
 
 /* Check default bootdev ordering  */
 static int bootdev_test_order_default(struct unit_test_state *uts)
@@ -301,7 +299,7 @@ static int bootdev_test_order_default(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_order_default, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_order_default, UTF_DM | UTF_SCAN_FDT);
 
 /* Check bootdev ordering with the uclass priority */
 static int bootdev_test_prio(struct unit_test_state *uts)
@@ -350,7 +348,7 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_prio, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_prio, UTF_DM | UTF_SCAN_FDT);
 
 /* Check listing hunters */
 static int bootdev_test_hunter(struct unit_test_state *uts)
@@ -390,7 +388,7 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_hunter, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_hunter, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootdev hunt' command */
 static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
@@ -464,8 +462,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_cmd_hunt, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
-	     UT_TESTF_ETH_BOOTDEV);
+BOOTSTD_TEST(bootdev_test_cmd_hunt, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
 
 /* Check searching for bootdevs using the hunters */
 static int bootdev_test_hunt_scan(struct unit_test_state *uts)
@@ -485,7 +482,7 @@ static int bootdev_test_hunt_scan(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_hunt_scan, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_hunt_scan, UTF_DM | UTF_SCAN_FDT);
 
 /* Check that only bootable partitions are processed */
 static int bootdev_test_bootable(struct unit_test_state *uts)
@@ -522,7 +519,7 @@ static int bootdev_test_bootable(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_bootable, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_bootable, UTF_DM | UTF_SCAN_FDT);
 
 /* Check hunting for bootdev of a particular priority */
 static int bootdev_test_hunt_prio(struct unit_test_state *uts)
@@ -547,7 +544,7 @@ static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_hunt_prio, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_hunt_prio, UTF_DM | UTF_SCAN_FDT);
 
 /* Check hunting for bootdevs with a particular label */
 static int bootdev_test_hunt_label(struct unit_test_state *uts)
@@ -600,7 +597,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_hunt_label, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootdev_test_hunt_label, UTF_DM | UTF_SCAN_FDT);
 
 /* Check iterating to the next label in a list */
 static int bootdev_test_next_label(struct unit_test_state *uts)
@@ -677,8 +674,8 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_next_label, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
-	     UT_TESTF_ETH_BOOTDEV | UT_TESTF_SF_BOOTDEV);
+BOOTSTD_TEST(bootdev_test_next_label, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV |
+	     UTF_SF_BOOTDEV);
 
 /* Check iterating to the next prioirty in a list */
 static int bootdev_test_next_prio(struct unit_test_state *uts)
@@ -762,5 +759,4 @@ static int bootdev_test_next_prio(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootdev_test_next_prio, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
-	     UT_TESTF_SF_BOOTDEV);
+BOOTSTD_TEST(bootdev_test_next_prio, UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV);
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8bfc2a1b9b4..a97f4f877e9 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -76,7 +76,7 @@ static int bootflow_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootflow scan' with a label / seq */
 static int bootflow_cmd_label(struct unit_test_state *uts)
@@ -123,8 +123,7 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_label, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
-	     UT_TESTF_ETH_BOOTDEV);
+BOOTSTD_TEST(bootflow_cmd_label, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
 
 /* Check 'bootflow scan/list' commands using all bootdevs */
 static int bootflow_cmd_glob(struct unit_test_state *uts)
@@ -156,7 +155,7 @@ static int bootflow_cmd_glob(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_glob, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_glob, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootflow scan -e' */
 static int bootflow_cmd_scan_e(struct unit_test_state *uts)
@@ -207,7 +206,7 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_scan_e, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_scan_e, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootflow info' */
 static int bootflow_cmd_info(struct unit_test_state *uts)
@@ -248,7 +247,7 @@ static int bootflow_cmd_info(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_info, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_info, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootflow scan -b' to boot the first available bootdev */
 static int bootflow_scan_boot(struct unit_test_state *uts)
@@ -270,7 +269,7 @@ static int bootflow_scan_boot(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_scan_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_scan_boot, UTF_DM | UTF_SCAN_FDT);
 
 /* Check iterating through available bootflows */
 static int bootflow_iter(struct unit_test_state *uts)
@@ -368,7 +367,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
 /* Check using the system bootdev */
@@ -396,8 +395,7 @@ static int bootflow_system(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_system, UT_TESTF_DM | UT_TESTF_SCAN_PDATA |
-	     UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_system, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #endif
 
 /* Check disabling a bootmethod if it requests it */
@@ -438,7 +436,7 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter_disable, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter_disable, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootflow scan' with a bootmeth ordering including a global bootmeth */
 static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
@@ -479,7 +477,7 @@ static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_scan_glob_bootmeth, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_scan_glob_bootmeth, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootflow boot' to boot a selected bootflow */
 static int bootflow_cmd_boot(struct unit_test_state *uts)
@@ -508,7 +506,7 @@ static int bootflow_cmd_boot(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_boot, UTF_DM | UTF_SCAN_FDT);
 
 /**
  * prep_mmc_bootdev() - Set up an mmc bootdev so we can access other distros
@@ -675,7 +673,7 @@ static int bootflow_cmd_menu(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_menu, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_menu, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootflow scan -m' to select a bootflow using a menu */
 static int bootflow_scan_menu(struct unit_test_state *uts)
@@ -723,8 +721,7 @@ static int bootflow_scan_menu(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_scan_menu,
-	     UT_TESTF_DM | UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+BOOTSTD_TEST(bootflow_scan_menu, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE_REC);
 
 /* Check 'bootflow scan -mb' to select and boot a bootflow using a menu */
 static int bootflow_scan_menu_boot(struct unit_test_state *uts)
@@ -770,8 +767,7 @@ static int bootflow_scan_menu_boot(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_scan_menu_boot,
-	     UT_TESTF_DM | UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+BOOTSTD_TEST(bootflow_scan_menu_boot, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE_REC);
 
 /* Check searching for a single bootdev using the hunters */
 static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
@@ -794,7 +790,7 @@ static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_hunt_single, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_hunt_single, UTF_DM | UTF_SCAN_FDT);
 
 /* Check searching for a uclass label using the hunters */
 static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
@@ -831,7 +827,7 @@ static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_hunt_label, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_hunt_label, UTF_DM | UTF_SCAN_FDT);
 
 /**
  * check_font() - Check that the font size for an item matches expectations
@@ -891,7 +887,7 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_menu_theme, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_menu_theme, UTF_DM | UTF_SCAN_FDT);
 
 /**
  * check_arg() - Check both the normal case and the buffer-overflow case
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index 113b789ea79..ae133cdb423 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -31,7 +31,7 @@ static int bootmeth_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_cmd_list, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_cmd_list, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootmeth order' command */
 static int bootmeth_cmd_order(struct unit_test_state *uts)
@@ -104,7 +104,7 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_cmd_order, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_cmd_order, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootmeth order' command with global bootmeths */
 static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
@@ -128,7 +128,7 @@ static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_cmd_order_glob, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_cmd_order_glob, UTF_DM | UTF_SCAN_FDT);
 
 /* Check 'bootmeths' env var */
 static int bootmeth_env(struct unit_test_state *uts)
@@ -154,7 +154,7 @@ static int bootmeth_env(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_env, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_env, UTF_DM | UTF_SCAN_FDT);
 
 /* Check the get_state_desc() method */
 static int bootmeth_state(struct unit_test_state *uts)
@@ -170,4 +170,4 @@ static int bootmeth_state(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootmeth_state, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootmeth_state, UTF_DM | UTF_SCAN_FDT);
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 6ea0184373d..3fe06a4436e 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -114,7 +114,7 @@ static int expo_base(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(expo_base, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(expo_base, UTF_DM | UTF_SCAN_FDT);
 
 /* Check creating a scene */
 static int expo_scene(struct unit_test_state *uts)
@@ -165,7 +165,7 @@ static int expo_scene(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(expo_scene, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(expo_scene, UTF_DM | UTF_SCAN_FDT);
 
 /* Check creating a scene with objects */
 static int expo_object(struct unit_test_state *uts)
@@ -225,7 +225,7 @@ static int expo_object(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(expo_object, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(expo_object, UTF_DM | UTF_SCAN_FDT);
 
 /* Check setting object attributes and using themes */
 static int expo_object_attr(struct unit_test_state *uts)
@@ -286,7 +286,7 @@ static int expo_object_attr(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(expo_object_attr, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(expo_object_attr, UTF_DM | UTF_SCAN_FDT);
 
 /**
  * struct test_iter_priv - private data for expo-iterator test
@@ -432,7 +432,7 @@ static int expo_object_menu(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(expo_object_menu, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(expo_object_menu, UTF_DM | UTF_SCAN_FDT);
 
 /* Check rendering a scene */
 static int expo_render_image(struct unit_test_state *uts)
@@ -633,7 +633,7 @@ static int expo_render_image(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(expo_render_image, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(expo_render_image, UTF_DM | UTF_SCAN_FDT);
 
 /* Check building an expo from a devicetree description */
 static int expo_test_build(struct unit_test_state *uts)
@@ -712,4 +712,4 @@ static int expo_test_build(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(expo_test_build, UT_TESTF_DM);
+BOOTSTD_TEST(expo_test_build, UTF_DM);
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 364fb0526e4..6ef29a98f05 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -374,7 +374,7 @@ static int upl_test_info(struct unit_test_state *uts)
 
 	return 0;
 }
-UPL_TEST(upl_test_info, UT_TESTF_CONSOLE_REC);
+UPL_TEST(upl_test_info, UTF_CONSOLE_REC);
 
 /* Test 'upl read' and 'upl_write' commands */
 static int upl_test_read_write(struct unit_test_state *uts)
@@ -396,7 +396,7 @@ static int upl_test_read_write(struct unit_test_state *uts)
 
 	return 0;
 }
-UPL_TEST(upl_test_read_write, UT_TESTF_CONSOLE_REC);
+UPL_TEST(upl_test_read_write, UTF_CONSOLE_REC);
 
 /* Test UPL passthrough */
 static int upl_test_info_norun(struct unit_test_state *uts)
@@ -425,7 +425,7 @@ static int upl_test_info_norun(struct unit_test_state *uts)
 
 	return 0;
 }
-UPL_TEST(upl_test_info_norun, UT_TESTF_CONSOLE_REC | UT_TESTF_MANUAL);
+UPL_TEST(upl_test_info_norun, UTF_CONSOLE_REC | UTF_MANUAL);
 
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/test/boot/vbe_fixup.c b/test/boot/vbe_fixup.c
index 540816e42b0..5bc026dbb59 100644
--- a/test/boot/vbe_fixup.c
+++ b/test/boot/vbe_fixup.c
@@ -51,5 +51,5 @@ static int vbe_test_fixup_norun(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(vbe_test_fixup_norun, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
-	     UT_TESTF_FLAT_TREE | UT_TESTF_MANUAL);
+BOOTSTD_TEST(vbe_test_fixup_norun, UTF_DM | UTF_SCAN_FDT | UTF_FLAT_TREE |
+	     UTF_MANUAL);
diff --git a/test/boot/vbe_simple.c b/test/boot/vbe_simple.c
index 3672b744e5f..4fe4323b401 100644
--- a/test/boot/vbe_simple.c
+++ b/test/boot/vbe_simple.c
@@ -85,4 +85,4 @@ static int vbe_simple_test_base(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(vbe_simple_test_base, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(vbe_simple_test_base, UTF_DM | UTF_SCAN_FDT);
diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index 7b8f49fd375..fb4ec316781 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -24,7 +24,7 @@ static int addrmap_test_basic(struct unit_test_state *uts)
 
 	return 0;
 }
-ADDRMAP_TEST(addrmap_test_basic, UT_TESTF_CONSOLE_REC);
+ADDRMAP_TEST(addrmap_test_basic, UTF_CONSOLE_REC);
 
 int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/test/cmd/armffa.c b/test/cmd/armffa.c
index 38f40b72f5e..f5d5a1b54a3 100644
--- a/test/cmd/armffa.c
+++ b/test/cmd/armffa.c
@@ -29,4 +29,4 @@ static int dm_test_armffa_cmd(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_armffa_cmd, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_armffa_cmd, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 027848c3e24..973544f63f6 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -245,7 +245,7 @@ static int bdinfo_test_full(struct unit_test_state *uts)
 	return 0;
 }
 
-BDINFO_TEST(bdinfo_test_full, UT_TESTF_CONSOLE_REC);
+BDINFO_TEST(bdinfo_test_full, UTF_CONSOLE_REC);
 
 static int bdinfo_test_help(struct unit_test_state *uts)
 {
@@ -267,7 +267,7 @@ static int bdinfo_test_help(struct unit_test_state *uts)
 	return 0;
 }
 
-BDINFO_TEST(bdinfo_test_help, UT_TESTF_CONSOLE_REC);
+BDINFO_TEST(bdinfo_test_help, UTF_CONSOLE_REC);
 
 static int bdinfo_test_memory(struct unit_test_state *uts)
 {
@@ -283,7 +283,7 @@ static int bdinfo_test_memory(struct unit_test_state *uts)
 	return 0;
 }
 
-BDINFO_TEST(bdinfo_test_memory, UT_TESTF_CONSOLE_REC);
+BDINFO_TEST(bdinfo_test_memory, UTF_CONSOLE_REC);
 
 static int bdinfo_test_eth(struct unit_test_state *uts)
 {
@@ -299,7 +299,7 @@ static int bdinfo_test_eth(struct unit_test_state *uts)
 	return 0;
 }
 
-BDINFO_TEST(bdinfo_test_eth, UT_TESTF_CONSOLE_REC);
+BDINFO_TEST(bdinfo_test_eth, UTF_CONSOLE_REC);
 
 int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index d310ec8531b..d4aac0facf6 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -122,7 +122,7 @@ static int cmd_exit_test(struct unit_test_state *uts)
 	return 0;
 }
 
-EXIT_TEST(cmd_exit_test, UT_TESTF_CONSOLE_REC);
+EXIT_TEST(cmd_exit_test, UTF_CONSOLE_REC);
 
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index e09a929a5e4..4f935d053c6 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -213,7 +213,7 @@ static int fdt_test_addr(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_addr, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_addr, UTF_CONSOLE_REC);
 
 /* Test 'fdt addr' resizing an fdt */
 static int fdt_test_addr_resize(struct unit_test_state *uts)
@@ -247,7 +247,7 @@ static int fdt_test_addr_resize(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_addr_resize, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_addr_resize, UTF_CONSOLE_REC);
 
 static int fdt_test_move(struct unit_test_state *uts)
 {
@@ -281,7 +281,7 @@ static int fdt_test_move(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_move, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_move, UTF_CONSOLE_REC);
 
 static int fdt_test_resize(struct unit_test_state *uts)
 {
@@ -305,7 +305,7 @@ static int fdt_test_resize(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_resize, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_resize, UTF_CONSOLE_REC);
 
 static int fdt_test_print_list_common(struct unit_test_state *uts,
 				      const char *opc, const char *node)
@@ -442,13 +442,13 @@ static int fdt_test_print(struct unit_test_state *uts)
 {
 	return fdt_test_print_list(uts, true);
 }
-FDT_TEST(fdt_test_print, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_print, UTF_CONSOLE_REC);
 
 static int fdt_test_list(struct unit_test_state *uts)
 {
 	return fdt_test_print_list(uts, false);
 }
-FDT_TEST(fdt_test_list, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_list, UTF_CONSOLE_REC);
 
 /* Test 'fdt get value' reading an fdt */
 static int fdt_test_get_value_string(struct unit_test_state *uts,
@@ -554,7 +554,7 @@ static int fdt_test_get_value(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_get_value, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_get_value, UTF_CONSOLE_REC);
 
 static int fdt_test_get_name(struct unit_test_state *uts)
 {
@@ -633,7 +633,7 @@ static int fdt_test_get_name(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_get_name, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_get_name, UTF_CONSOLE_REC);
 
 static int fdt_test_get_addr_common(struct unit_test_state *uts, char *fdt,
 				    const char *path, const char *prop)
@@ -700,7 +700,7 @@ static int fdt_test_get_addr(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_get_addr, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_get_addr, UTF_CONSOLE_REC);
 
 static int fdt_test_get_size_common(struct unit_test_state *uts,
 				     const char *path, const char *prop,
@@ -787,7 +787,7 @@ static int fdt_test_get_size(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_get_size, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_get_size, UTF_CONSOLE_REC);
 
 static int fdt_test_set_single(struct unit_test_state *uts,
 			       const char *path, const char *prop,
@@ -929,7 +929,7 @@ static int fdt_test_set(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_set, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_set, UTF_CONSOLE_REC);
 
 static int fdt_test_mknode(struct unit_test_state *uts)
 {
@@ -997,7 +997,7 @@ static int fdt_test_mknode(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_mknode, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_mknode, UTF_CONSOLE_REC);
 
 static int fdt_test_rm(struct unit_test_state *uts)
 {
@@ -1081,7 +1081,7 @@ static int fdt_test_rm(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_rm, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_rm, UTF_CONSOLE_REC);
 
 static int fdt_test_bootcpu(struct unit_test_state *uts)
 {
@@ -1114,7 +1114,7 @@ static int fdt_test_bootcpu(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_bootcpu, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_bootcpu, UTF_CONSOLE_REC);
 
 static int fdt_test_header_get(struct unit_test_state *uts,
 			       const char *field, const unsigned long val)
@@ -1173,7 +1173,7 @@ static int fdt_test_header(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_header, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_header, UTF_CONSOLE_REC);
 
 static int fdt_test_memory_cells(struct unit_test_state *uts,
 				 const unsigned int cells)
@@ -1256,7 +1256,7 @@ static int fdt_test_memory(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_memory, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_memory, UTF_CONSOLE_REC);
 
 static int fdt_test_rsvmem(struct unit_test_state *uts)
 {
@@ -1319,7 +1319,7 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_rsvmem, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_rsvmem, UTF_CONSOLE_REC);
 
 static int fdt_test_chosen(struct unit_test_state *uts)
 {
@@ -1375,7 +1375,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_chosen, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_chosen, UTF_CONSOLE_REC);
 
 static int fdt_test_apply(struct unit_test_state *uts)
 {
@@ -1527,7 +1527,7 @@ static int fdt_test_apply(struct unit_test_state *uts)
 
 	return 0;
 }
-FDT_TEST(fdt_test_apply, UT_TESTF_CONSOLE_REC);
+FDT_TEST(fdt_test_apply, UTF_CONSOLE_REC);
 
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/test/cmd/font.c b/test/cmd/font.c
index a8905ce617e..3ea262bb703 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -69,8 +69,8 @@ static int font_test_base(struct unit_test_state *uts)
 
 	return 0;
 }
-FONT_TEST(font_test_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT |
-	  UT_TESTF_CONSOLE_REC | UT_TESTF_DM);
+FONT_TEST(font_test_base, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE_REC |
+	  UTF_DM);
 
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/test/cmd/history.c b/test/cmd/history.c
index 6964bfa9e1e..9fec4a811f4 100644
--- a/test/cmd/history.c
+++ b/test/cmd/history.c
@@ -45,4 +45,4 @@ static int lib_test_history(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_history, UT_TESTF_CONSOLE_REC);
+LIB_TEST(lib_test_history, UTF_CONSOLE_REC);
diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
index dff8a97d139..0b6390ebc53 100644
--- a/test/cmd/loadm.c
+++ b/test/cmd/loadm.c
@@ -41,7 +41,7 @@ static int loadm_test_params(struct unit_test_state *uts)
 
 	return 0;
 }
-LOADM_TEST(loadm_test_params, UT_TESTF_CONSOLE_REC);
+LOADM_TEST(loadm_test_params, UTF_CONSOLE_REC);
 
 static int loadm_test_load (struct unit_test_state *uts)
 {
@@ -59,7 +59,7 @@ static int loadm_test_load (struct unit_test_state *uts)
 
 	return 0;
 }
-LOADM_TEST(loadm_test_load, UT_TESTF_CONSOLE_REC);
+LOADM_TEST(loadm_test_load, UTF_CONSOLE_REC);
 
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 235b363290e..fd601ee5f53 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -465,7 +465,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 }
 
 /* Declare mbr test */
-UNIT_TEST(mbr_test_run, UT_TESTF_CONSOLE_REC, mbr_test);
+UNIT_TEST(mbr_test_run, UTF_CONSOLE_REC, mbr_test);
 
 int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
@@ -480,4 +480,4 @@ static int dm_test_cmd_mbr(struct unit_test_state *uts)
 	return mbr_test_run(uts);
 }
 
-DM_TEST(dm_test_cmd_mbr, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_cmd_mbr, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/mem_search.c b/test/cmd/mem_search.c
index 55ad2fac1e3..9ad0c18152f 100644
--- a/test/cmd/mem_search.c
+++ b/test/cmd/mem_search.c
@@ -43,7 +43,7 @@ static int mem_test_ms_b(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_b, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_b, UTF_CONSOLE_REC);
 
 /* Test 'ms' command with 16-bit values */
 static int mem_test_ms_w(struct unit_test_state *uts)
@@ -68,7 +68,7 @@ static int mem_test_ms_w(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_w, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_w, UTF_CONSOLE_REC);
 
 /* Test 'ms' command with 32-bit values */
 static int mem_test_ms_l(struct unit_test_state *uts)
@@ -102,7 +102,7 @@ static int mem_test_ms_l(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_l, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_l, UTF_CONSOLE_REC);
 
 /* Test 'ms' command with continuation */
 static int mem_test_ms_cont(struct unit_test_state *uts)
@@ -152,7 +152,7 @@ static int mem_test_ms_cont(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_cont, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_cont, UTF_CONSOLE_REC);
 
 /* Test that an 'ms' command with continuation stops at the end of the range */
 static int mem_test_ms_cont_end(struct unit_test_state *uts)
@@ -196,7 +196,7 @@ static int mem_test_ms_cont_end(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_cont_end, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_cont_end, UTF_CONSOLE_REC);
 
 /* Test 'ms' command with multiple values */
 static int mem_test_ms_mult(struct unit_test_state *uts)
@@ -225,7 +225,7 @@ static int mem_test_ms_mult(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_mult, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_mult, UTF_CONSOLE_REC);
 
 /* Test 'ms' command with string */
 static int mem_test_ms_s(struct unit_test_state *uts)
@@ -268,7 +268,7 @@ static int mem_test_ms_s(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_s, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_s, UTF_CONSOLE_REC);
 
 /* Test 'ms' command with limit */
 static int mem_test_ms_limit(struct unit_test_state *uts)
@@ -297,7 +297,7 @@ static int mem_test_ms_limit(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_limit, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_limit, UTF_CONSOLE_REC);
 
 /* Test 'ms' command in quiet mode */
 static int mem_test_ms_quiet(struct unit_test_state *uts)
@@ -321,4 +321,4 @@ static int mem_test_ms_quiet(struct unit_test_state *uts)
 
 	return 0;
 }
-MEM_TEST(mem_test_ms_quiet, UT_TESTF_CONSOLE_REC);
+MEM_TEST(mem_test_ms_quiet, UTF_CONSOLE_REC);
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index 2a64143eecd..f7f77e73a30 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -28,7 +28,7 @@ static int test_pci_mps_safe(struct unit_test_state *uts)
 	return 0;
 }
 
-PCI_MPS_TEST(test_pci_mps_safe, UT_TESTF_CONSOLE_REC);
+PCI_MPS_TEST(test_pci_mps_safe, UTF_CONSOLE_REC);
 
 int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char * const argv[])
diff --git a/test/cmd/pinmux.c b/test/cmd/pinmux.c
index 4253baa5646..23f9b9a9f3a 100644
--- a/test/cmd/pinmux.c
+++ b/test/cmd/pinmux.c
@@ -37,4 +37,4 @@ static int dm_test_cmd_pinmux_status_pinname(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_cmd_pinmux_status_pinname, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_pinmux_status_pinname, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/cmd/pwm.c b/test/cmd/pwm.c
index cf7ee0e0e65..494f31f4dae 100644
--- a/test/cmd/pwm.c
+++ b/test/cmd/pwm.c
@@ -72,4 +72,4 @@ static int dm_test_pwm_cmd(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_pwm_cmd, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_pwm_cmd, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/rw.c b/test/cmd/rw.c
index edd762e4d58..3dcf4228ee6 100644
--- a/test/cmd/rw.c
+++ b/test/cmd/rw.c
@@ -100,4 +100,4 @@ static int dm_test_read_write(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_read_write, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_read_write, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/seama.c b/test/cmd/seama.c
index b60f6550b13..235135118cf 100644
--- a/test/cmd/seama.c
+++ b/test/cmd/seama.c
@@ -26,7 +26,7 @@ static int seama_test_noargs(struct unit_test_state *uts)
 	ut_assert_console_end();
 	return 0;
 }
-SEAMA_TEST(seama_test_noargs, UT_TESTF_CONSOLE_REC);
+SEAMA_TEST(seama_test_noargs, UTF_CONSOLE_REC);
 
 static int seama_test_addr(struct unit_test_state *uts)
 {
@@ -42,7 +42,7 @@ static int seama_test_addr(struct unit_test_state *uts)
 	ut_assert_console_end();
 	return 0;
 }
-SEAMA_TEST(seama_test_addr, UT_TESTF_CONSOLE_REC);
+SEAMA_TEST(seama_test_addr, UTF_CONSOLE_REC);
 
 static int seama_test_index(struct unit_test_state *uts)
 {
@@ -58,7 +58,7 @@ static int seama_test_index(struct unit_test_state *uts)
 	ut_assert_console_end();
 	return 0;
 }
-SEAMA_TEST(seama_test_index, UT_TESTF_CONSOLE_REC);
+SEAMA_TEST(seama_test_index, UTF_CONSOLE_REC);
 
 int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 4c6cc3cf09e..f024a335763 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -63,7 +63,7 @@ static int setexpr_test_int(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_int, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_int, UTF_CONSOLE_REC);
 
 /* Test 'setexpr' command with + operator */
 static int setexpr_test_plus(struct unit_test_state *uts)
@@ -105,7 +105,7 @@ static int setexpr_test_plus(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_plus, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_plus, UTF_CONSOLE_REC);
 
 /* Test 'setexpr' command with other operators */
 static int setexpr_test_oper(struct unit_test_state *uts)
@@ -148,7 +148,7 @@ static int setexpr_test_oper(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_oper, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_oper, UTF_CONSOLE_REC);
 
 /* Test 'setexpr' command with regex */
 static int setexpr_test_regex(struct unit_test_state *uts)
@@ -192,7 +192,7 @@ static int setexpr_test_regex(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_regex, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_regex, UTF_CONSOLE_REC);
 
 /* Test 'setexpr' command with regex replacement that expands the string */
 static int setexpr_test_regex_inc(struct unit_test_state *uts)
@@ -209,7 +209,7 @@ static int setexpr_test_regex_inc(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_regex_inc, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_regex_inc, UTF_CONSOLE_REC);
 
 /* Test setexpr_regex_sub() directly to check buffer usage */
 static int setexpr_test_sub(struct unit_test_state *uts)
@@ -249,7 +249,7 @@ static int setexpr_test_sub(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_sub, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_sub, UTF_CONSOLE_REC);
 
 /* Test setexpr_regex_sub() with back references */
 static int setexpr_test_backref(struct unit_test_state *uts)
@@ -292,7 +292,7 @@ static int setexpr_test_backref(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_backref, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_backref, UTF_CONSOLE_REC);
 
 /* Test 'setexpr' command with setting strings */
 static int setexpr_test_str(struct unit_test_state *uts)
@@ -327,7 +327,7 @@ static int setexpr_test_str(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_str, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_str, UTF_CONSOLE_REC);
 
 /* Test 'setexpr' command with concatenating strings */
 static int setexpr_test_str_oper(struct unit_test_state *uts)
@@ -376,7 +376,7 @@ static int setexpr_test_str_oper(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_str_oper, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_str_oper, UTF_CONSOLE_REC);
 
 /* Test 'setexpr' command with a string that is too long */
 static int setexpr_test_str_long(struct unit_test_state *uts)
@@ -396,7 +396,7 @@ static int setexpr_test_str_long(struct unit_test_state *uts)
 
 	return 0;
 }
-SETEXPR_TEST(setexpr_test_str_long, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_str_long, UTF_CONSOLE_REC);
 
 #ifdef CONFIG_CMD_SETEXPR_FMT
 /* Test 'setexpr' command with simply setting integers */
@@ -479,7 +479,7 @@ static int setexpr_test_fmt(struct unit_test_state *uts)
 	return 0;
 }
 
-SETEXPR_TEST(setexpr_test_fmt, UT_TESTF_CONSOLE_REC);
+SETEXPR_TEST(setexpr_test_fmt, UTF_CONSOLE_REC);
 #endif
 
 int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/test/cmd/temperature.c b/test/cmd/temperature.c
index 364972626b1..fc0c95f3d81 100644
--- a/test/cmd/temperature.c
+++ b/test/cmd/temperature.c
@@ -35,4 +35,4 @@ static int dm_test_cmd_temperature(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_cmd_temperature, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_cmd_temperature, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/common/event.c b/test/common/event.c
index de433d34f22..bfbbf019768 100644
--- a/test/common/event.c
+++ b/test/common/event.c
@@ -106,4 +106,4 @@ static int test_event_probe(struct unit_test_state *uts)
 
 	return 0;
 }
-COMMON_TEST(test_event_probe, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+COMMON_TEST(test_event_probe, UTF_DM | UTF_SCAN_FDT);
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 7da381f1a54..4c5f8b593c7 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -195,7 +195,7 @@ static int dm_test_acpi_get_name(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_get_name, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_get_name, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test acpi_get_table_revision() */
 static int dm_test_acpi_get_table_revision(struct unit_test_state *uts)
@@ -207,8 +207,7 @@ static int dm_test_acpi_get_table_revision(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_get_table_revision,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_get_table_revision, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test acpi_create_dmar() */
 static int dm_test_acpi_create_dmar(struct unit_test_state *uts)
@@ -225,7 +224,7 @@ static int dm_test_acpi_create_dmar(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_create_dmar, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_create_dmar, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test acpi_fill_header() */
 static int dm_test_acpi_fill_header(struct unit_test_state *uts)
@@ -251,7 +250,7 @@ static int dm_test_acpi_fill_header(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_fill_header, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_fill_header, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test ACPI write_tables() */
 static int dm_test_acpi_write_tables(struct unit_test_state *uts)
@@ -297,7 +296,7 @@ static int dm_test_acpi_write_tables(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_write_tables, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_write_tables, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test basic ACPI functions */
 static int dm_test_acpi_basic(struct unit_test_state *uts)
@@ -325,7 +324,7 @@ static int dm_test_acpi_basic(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_basic, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_basic, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test setup_ctx_and_base_tables */
 static int dm_test_acpi_ctx_and_base_tables(struct unit_test_state *uts)
@@ -374,8 +373,7 @@ static int dm_test_acpi_ctx_and_base_tables(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_ctx_and_base_tables,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_ctx_and_base_tables, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test 'acpi list' command */
 static int dm_test_acpi_cmd_list(struct unit_test_state *uts)
@@ -418,7 +416,7 @@ static int dm_test_acpi_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_cmd_list, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_cmd_list, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test 'acpi dump' command */
 static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
@@ -450,7 +448,7 @@ static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_cmd_dump, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_cmd_dump, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test acpi_device_path() */
 static int dm_test_acpi_device_path(struct unit_test_state *uts)
@@ -487,7 +485,7 @@ static int dm_test_acpi_device_path(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_device_path, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_device_path, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test acpi_device_status() */
 static int dm_test_acpi_device_status(struct unit_test_state *uts)
@@ -499,7 +497,7 @@ static int dm_test_acpi_device_status(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_device_status, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_device_status, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test acpi_fill_ssdt() */
 static int dm_test_acpi_fill_ssdt(struct unit_test_state *uts)
@@ -530,7 +528,7 @@ static int dm_test_acpi_fill_ssdt(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_fill_ssdt, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_fill_ssdt, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test acpi_inject_dsdt() */
 static int dm_test_acpi_inject_dsdt(struct unit_test_state *uts)
@@ -561,7 +559,7 @@ static int dm_test_acpi_inject_dsdt(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_inject_dsdt, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_inject_dsdt, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test 'acpi items' command */
 static int dm_test_acpi_cmd_items(struct unit_test_state *uts)
@@ -610,7 +608,7 @@ static int dm_test_acpi_cmd_items(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_cmd_items, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_cmd_items, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test 'acpi set' command */
 static int dm_test_acpi_cmd_set(struct unit_test_state *uts)
@@ -648,7 +646,7 @@ static int dm_test_acpi_cmd_set(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_cmd_set, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_cmd_set, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /**
  * dm_test_write_test_table() - create test ACPI table
diff --git a/test/dm/acpi_dp.c b/test/dm/acpi_dp.c
index 87bd8ae6749..eaeda2b8a7a 100644
--- a/test/dm/acpi_dp.c
+++ b/test/dm/acpi_dp.c
@@ -488,4 +488,4 @@ static int dm_test_acpi_dp_copy(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_dp_copy, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_dp_copy, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/acpigen.c b/test/dm/acpigen.c
index 7113219792e..3e912fadaef 100644
--- a/test/dm/acpigen.c
+++ b/test/dm/acpigen.c
@@ -167,7 +167,7 @@ static int dm_test_acpi_interrupt(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_interrupt, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_interrupt, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test emitting a GPIO descriptor */
 static int dm_test_acpi_gpio(struct unit_test_state *uts)
@@ -212,7 +212,7 @@ static int dm_test_acpi_gpio(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_gpio, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_gpio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test emitting a GPIO descriptor with an interrupt */
 static int dm_test_acpi_gpio_irq(struct unit_test_state *uts)
@@ -257,7 +257,7 @@ static int dm_test_acpi_gpio_irq(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_gpio_irq, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_gpio_irq, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test emitting either a GPIO or interrupt descriptor */
 static int dm_test_acpi_interrupt_or_gpio(struct unit_test_state *uts)
@@ -296,8 +296,7 @@ static int dm_test_acpi_interrupt_or_gpio(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_interrupt_or_gpio,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_interrupt_or_gpio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test emitting an I2C descriptor */
 static int dm_test_acpi_i2c(struct unit_test_state *uts)
@@ -329,7 +328,7 @@ static int dm_test_acpi_i2c(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_i2c, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_i2c, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test emitting a SPI descriptor */
 static int dm_test_acpi_spi(struct unit_test_state *uts)
@@ -365,7 +364,7 @@ static int dm_test_acpi_spi(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_spi, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_spi, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test emitting a length */
 static int dm_test_acpi_len(struct unit_test_state *uts)
@@ -806,7 +805,7 @@ static int dm_test_acpi_gpio_toggle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_gpio_toggle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_gpio_toggle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test writing ACPI code to output power-sequence info */
 static int dm_test_acpi_power_seq(struct unit_test_state *uts)
@@ -873,7 +872,7 @@ static int dm_test_acpi_power_seq(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_power_seq, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_power_seq, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test writing values */
 static int dm_test_acpi_write_values(struct unit_test_state *uts)
@@ -947,7 +946,7 @@ static int dm_test_acpi_scope(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_acpi_scope, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_acpi_scope, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test writing a resource template */
 static int dm_test_acpi_resource_template(struct unit_test_state *uts)
diff --git a/test/dm/adc.c b/test/dm/adc.c
index a26a677074a..e27302b449e 100644
--- a/test/dm/adc.c
+++ b/test/dm/adc.c
@@ -32,7 +32,7 @@ static int dm_test_adc_bind(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_adc_bind, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_adc_bind, UTF_SCAN_FDT);
 
 static int dm_test_adc_wrong_channel_selection(struct unit_test_state *uts)
 {
@@ -43,7 +43,7 @@ static int dm_test_adc_wrong_channel_selection(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_adc_wrong_channel_selection, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_adc_wrong_channel_selection, UTF_SCAN_FDT);
 
 static int dm_test_adc_supply(struct unit_test_state *uts)
 {
@@ -79,7 +79,7 @@ static int dm_test_adc_supply(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_adc_supply, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_adc_supply, UTF_SCAN_FDT);
 
 struct adc_channel adc_channel_test_data[] = {
 	{ 0, SANDBOX_ADC_CHANNEL0_DATA },
@@ -104,7 +104,7 @@ static int dm_test_adc_single_channel_conversion(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_adc_single_channel_conversion, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_adc_single_channel_conversion, UTF_SCAN_FDT);
 
 static int dm_test_adc_multi_channel_conversion(struct unit_test_state *uts)
 {
@@ -127,7 +127,7 @@ static int dm_test_adc_multi_channel_conversion(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_adc_multi_channel_conversion, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_adc_multi_channel_conversion, UTF_SCAN_FDT);
 
 static int dm_test_adc_single_channel_shot(struct unit_test_state *uts)
 {
@@ -143,7 +143,7 @@ static int dm_test_adc_single_channel_shot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_adc_single_channel_shot, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_adc_single_channel_shot, UTF_SCAN_FDT);
 
 static int dm_test_adc_multi_channel_shot(struct unit_test_state *uts)
 {
@@ -163,7 +163,7 @@ static int dm_test_adc_multi_channel_shot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_adc_multi_channel_shot, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_adc_multi_channel_shot, UTF_SCAN_FDT);
 
 static const int dm_test_adc_uV_data[SANDBOX_ADC_CHANNELS] = {
 	((u64)SANDBOX_ADC_CHANNEL0_DATA * SANDBOX_BUCK2_INITIAL_EXPECTED_UV) /
@@ -194,4 +194,4 @@ static int dm_test_adc_raw_to_uV(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_adc_raw_to_uV, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_adc_raw_to_uV, UTF_SCAN_FDT);
diff --git a/test/dm/audio.c b/test/dm/audio.c
index 3d1d821f323..f4d3346c90a 100644
--- a/test/dm/audio.c
+++ b/test/dm/audio.c
@@ -31,4 +31,4 @@ static int dm_test_audio(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_audio, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_audio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/axi.c b/test/dm/axi.c
index 0900a9b5485..1138a46aca1 100644
--- a/test/dm/axi.c
+++ b/test/dm/axi.c
@@ -22,7 +22,7 @@ static int dm_test_axi_base(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_axi_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_axi_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that sandbox PCI bus numbering works correctly */
 static int dm_test_axi_busnum(struct unit_test_state *uts)
@@ -34,7 +34,7 @@ static int dm_test_axi_busnum(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_axi_busnum, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_axi_busnum, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can use the store device correctly */
 static int dm_test_axi_store(struct unit_test_state *uts)
@@ -75,4 +75,4 @@ static int dm_test_axi_store(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_axi_store, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_axi_store, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/blk.c b/test/dm/blk.c
index d03aec32f6c..aa5cbc63777 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -43,7 +43,7 @@ static int dm_test_blk_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_blk_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_blk_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int count_blk_devices(void)
 {
@@ -92,7 +92,7 @@ static int dm_test_blk_usb(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_blk_usb, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_blk_usb, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can find block devices without probing them */
 static int dm_test_blk_find(struct unit_test_state *uts)
@@ -114,7 +114,7 @@ static int dm_test_blk_find(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_blk_find, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_blk_find, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that block device numbering works as expected */
 static int dm_test_blk_devnum(struct unit_test_state *uts)
@@ -149,7 +149,7 @@ static int dm_test_blk_devnum(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_blk_devnum, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_blk_devnum, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can get a block from its parent */
 static int dm_test_blk_get_from_parent(struct unit_test_state *uts)
@@ -167,7 +167,7 @@ static int dm_test_blk_get_from_parent(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_blk_get_from_parent, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_blk_get_from_parent, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test iteration through block devices */
 static int dm_test_blk_iter(struct unit_test_state *uts)
@@ -222,7 +222,7 @@ static int dm_test_blk_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_blk_iter, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_blk_iter, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test finding fixed/removable block devices */
 static int dm_test_blk_flags(struct unit_test_state *uts)
@@ -287,7 +287,7 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_blk_flags, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_blk_flags, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test blk_foreach() and friend */
 static int dm_test_blk_foreach(struct unit_test_state *uts)
@@ -333,4 +333,4 @@ static int dm_test_blk_foreach(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_blk_foreach, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_blk_foreach, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/bootcount.c b/test/dm/bootcount.c
index 9cfc7d48aac..4b0a4b37931 100644
--- a/test/dm/bootcount.c
+++ b/test/dm/bootcount.c
@@ -36,7 +36,7 @@ static int dm_test_bootcount_rtc(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_bootcount_rtc, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_bootcount_rtc, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_bootcount_syscon_four_bytes(struct unit_test_state *uts)
 {
@@ -57,7 +57,7 @@ static int dm_test_bootcount_syscon_four_bytes(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_bootcount_syscon_four_bytes,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_bootcount_syscon_two_bytes(struct unit_test_state *uts)
 {
@@ -78,4 +78,4 @@ static int dm_test_bootcount_syscon_two_bytes(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_bootcount_syscon_two_bytes,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/bus.c b/test/dm/bus.c
index 95326f23dad..166a8427406 100644
--- a/test/dm/bus.c
+++ b/test/dm/bus.c
@@ -41,7 +41,7 @@ static int dm_test_bus_children(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_bus_children, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_bus_children, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test our functions for accessing children */
 static int dm_test_bus_children_funcs(struct unit_test_state *uts)
@@ -81,7 +81,7 @@ static int dm_test_bus_children_funcs(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_bus_children_funcs, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_bus_children_funcs, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_bus_children_of_offset(struct unit_test_state *uts)
 {
@@ -105,7 +105,7 @@ static int dm_test_bus_children_of_offset(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_bus_children_of_offset,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
 /* Test that we can iterate through children */
 static int dm_test_bus_children_iterators(struct unit_test_state *uts)
@@ -136,7 +136,7 @@ static int dm_test_bus_children_iterators(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_bus_children_iterators,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that the bus can store data about each child */
 static int test_bus_parent_data(struct unit_test_state *uts)
@@ -203,7 +203,7 @@ static int dm_test_bus_parent_data(struct unit_test_state *uts)
 {
 	return test_bus_parent_data(uts);
 }
-DM_TEST(dm_test_bus_parent_data, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_bus_parent_data, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* As above but the size is controlled by the uclass */
 static int dm_test_bus_parent_data_uclass(struct unit_test_state *uts)
@@ -233,7 +233,7 @@ static int dm_test_bus_parent_data_uclass(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_bus_parent_data_uclass,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that the bus ops are called when a child is probed/removed */
 static int dm_test_bus_parent_ops(struct unit_test_state *uts)
@@ -270,7 +270,7 @@ static int dm_test_bus_parent_ops(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_bus_parent_ops, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_bus_parent_ops, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int test_bus_parent_plat(struct unit_test_state *uts)
 {
@@ -345,7 +345,7 @@ static int dm_test_bus_parent_plat(struct unit_test_state *uts)
 {
 	return test_bus_parent_plat(uts);
 }
-DM_TEST(dm_test_bus_parent_plat, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_bus_parent_plat, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* As above but the size is controlled by the uclass */
 static int dm_test_bus_parent_plat_uclass(struct unit_test_state *uts)
@@ -374,7 +374,7 @@ static int dm_test_bus_parent_plat_uclass(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_bus_parent_plat_uclass,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that the child post_bind method is called */
 static int dm_test_bus_child_post_bind(struct unit_test_state *uts)
@@ -395,7 +395,7 @@ static int dm_test_bus_child_post_bind(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_bus_child_post_bind, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_bus_child_post_bind, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that the child post_bind method is called */
 static int dm_test_bus_child_post_bind_uclass(struct unit_test_state *uts)
@@ -417,7 +417,7 @@ static int dm_test_bus_child_post_bind_uclass(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_bus_child_post_bind_uclass,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /*
  * Test that the bus' uclass' child_pre_probe() is called before the
@@ -451,7 +451,7 @@ static int dm_test_bus_child_pre_probe_uclass(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_bus_child_pre_probe_uclass,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /*
  * Test that the bus' uclass' child_post_probe() is called after the
@@ -484,4 +484,4 @@ static int dm_test_bus_child_post_probe_uclass(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_bus_child_post_probe_uclass,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/button.c b/test/dm/button.c
index 9157ec92878..3612f308f02 100644
--- a/test/dm/button.c
+++ b/test/dm/button.c
@@ -37,7 +37,7 @@ static int dm_test_button_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_button_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_button_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of the button uclass using the button_gpio driver */
 static int dm_test_button_gpio(struct unit_test_state *uts)
@@ -62,7 +62,7 @@ static int dm_test_button_gpio(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_button_gpio, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_button_gpio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test obtaining a BUTTON by label */
 static int dm_test_button_label(struct unit_test_state *uts)
@@ -83,7 +83,7 @@ static int dm_test_button_label(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_button_label, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_button_label, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test button has linux,code */
 static int dm_test_button_linux_code(struct unit_test_state *uts)
@@ -95,7 +95,7 @@ static int dm_test_button_linux_code(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_button_linux_code, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_button_linux_code, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test adc-keys driver */
 static int dm_test_button_keys_adc(struct unit_test_state *uts)
@@ -129,7 +129,7 @@ static int dm_test_button_keys_adc(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_button_keys_adc, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_button_keys_adc, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of the button uclass using the button_gpio driver */
 static int dm_test_button_cmd(struct unit_test_state *uts)
@@ -225,4 +225,4 @@ static int dm_test_button_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_button_cmd, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_button_cmd, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/cache.c b/test/dm/cache.c
index d2f3bfe2caf..e03e029f1dd 100644
--- a/test/dm/cache.c
+++ b/test/dm/cache.c
@@ -18,4 +18,4 @@ static int dm_test_reset(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_reset, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_reset, UTF_SCAN_FDT);
diff --git a/test/dm/clk.c b/test/dm/clk.c
index a966471dbd9..922b0536154 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -47,7 +47,7 @@ static int dm_test_clk_base(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_clk_base, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_clk_base, UTF_SCAN_FDT);
 
 static int dm_test_clk(struct unit_test_state *uts)
 {
@@ -187,7 +187,7 @@ static int dm_test_clk(struct unit_test_state *uts)
 	ut_assertok(device_remove(dev_test, DM_REMOVE_NORMAL));
 	return 0;
 }
-DM_TEST(dm_test_clk, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_clk, UTF_SCAN_FDT);
 
 static int dm_test_clk_bulk(struct unit_test_state *uts)
 {
@@ -225,4 +225,4 @@ static int dm_test_clk_bulk(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_clk_bulk, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_clk_bulk, UTF_SCAN_FDT);
diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index 15fba31b962..95c0f42caab 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -209,4 +209,4 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	return 1;
 }
 
-DM_TEST(dm_test_clk_ccf, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_clk_ccf, UTF_SCAN_FDT);
diff --git a/test/dm/core.c b/test/dm/core.c
index 5bc5e8e82ec..5d4678437e6 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -175,7 +175,7 @@ static int dm_test_autobind_uclass_pdata_alloc(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_autobind_uclass_pdata_alloc, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_autobind_uclass_pdata_alloc, UTF_SCAN_PDATA);
 
 /* compare node names ignoring the unit address */
 static int dm_test_compare_node_name(struct unit_test_state *uts)
@@ -189,7 +189,7 @@ static int dm_test_compare_node_name(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_compare_node_name, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_compare_node_name, UTF_SCAN_PDATA);
 
 /* Test that binding with uclass plat setting occurs correctly */
 static int dm_test_autobind_uclass_pdata_valid(struct unit_test_state *uts)
@@ -215,7 +215,7 @@ static int dm_test_autobind_uclass_pdata_valid(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_autobind_uclass_pdata_valid, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_autobind_uclass_pdata_valid, UTF_SCAN_PDATA);
 
 /* Test that autoprobe finds all the expected devices */
 static int dm_test_autoprobe(struct unit_test_state *uts)
@@ -282,7 +282,7 @@ static int dm_test_autoprobe(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_autoprobe, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_autoprobe, UTF_SCAN_PDATA);
 
 /* Check that we see the correct plat in each device */
 static int dm_test_plat(struct unit_test_state *uts)
@@ -300,7 +300,7 @@ static int dm_test_plat(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_plat, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_plat, UTF_SCAN_PDATA);
 
 /* Test that we can bind, probe, remove, unbind a driver */
 static int dm_test_lifecycle(struct unit_test_state *uts)
@@ -369,7 +369,7 @@ static int dm_test_lifecycle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_lifecycle, UT_TESTF_SCAN_PDATA | UT_TESTF_PROBE_TEST);
+DM_TEST(dm_test_lifecycle, UTF_SCAN_PDATA | UTF_PROBE_TEST);
 
 /* Test that we can bind/unbind and the lists update correctly */
 static int dm_test_ordering(struct unit_test_state *uts)
@@ -424,7 +424,7 @@ static int dm_test_ordering(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ordering, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_ordering, UTF_SCAN_PDATA);
 
 /* Check that we can perform operations on a device (do a ping) */
 int dm_check_operations(struct unit_test_state *uts, struct udevice *dev,
@@ -482,7 +482,7 @@ static int dm_test_operations(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_operations, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_operations, UTF_SCAN_PDATA);
 
 /* Remove all drivers and check that things work */
 static int dm_test_remove(struct unit_test_state *uts)
@@ -504,7 +504,7 @@ static int dm_test_remove(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_remove, UT_TESTF_SCAN_PDATA | UT_TESTF_PROBE_TEST);
+DM_TEST(dm_test_remove, UTF_SCAN_PDATA | UTF_PROBE_TEST);
 
 /* Remove and recreate everything, check for memory leaks */
 static int dm_test_leak(struct unit_test_state *uts)
@@ -1033,7 +1033,7 @@ static int dm_test_uclass_devices_find(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_uclass_devices_find, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_uclass_devices_find, UTF_SCAN_PDATA);
 
 static int dm_test_uclass_devices_find_by_name(struct unit_test_state *uts)
 {
@@ -1070,7 +1070,7 @@ static int dm_test_uclass_devices_find_by_name(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_uclass_devices_find_by_name, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_uclass_devices_find_by_name, UTF_SCAN_FDT);
 
 static int dm_test_uclass_devices_get(struct unit_test_state *uts)
 {
@@ -1086,7 +1086,7 @@ static int dm_test_uclass_devices_get(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_uclass_devices_get, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_uclass_devices_get, UTF_SCAN_PDATA);
 
 static int dm_test_uclass_devices_get_by_name(struct unit_test_state *uts)
 {
@@ -1129,7 +1129,7 @@ static int dm_test_uclass_devices_get_by_name(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_uclass_devices_get_by_name, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_uclass_devices_get_by_name, UTF_SCAN_FDT);
 
 static int dm_test_device_get_uclass_id(struct unit_test_state *uts)
 {
@@ -1140,7 +1140,7 @@ static int dm_test_device_get_uclass_id(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_device_get_uclass_id, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_device_get_uclass_id, UTF_SCAN_PDATA);
 
 static int dm_test_uclass_names(struct unit_test_state *uts)
 {
@@ -1151,7 +1151,7 @@ static int dm_test_uclass_names(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_uclass_names, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_uclass_names, UTF_SCAN_PDATA);
 
 static int dm_test_inactive_child(struct unit_test_state *uts)
 {
@@ -1181,7 +1181,7 @@ static int dm_test_inactive_child(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_inactive_child, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_inactive_child, UTF_SCAN_PDATA);
 
 /* Make sure all bound devices have a sequence number */
 static int dm_test_all_have_seq(struct unit_test_state *uts)
@@ -1200,7 +1200,7 @@ static int dm_test_all_have_seq(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_all_have_seq, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_all_have_seq, UTF_SCAN_PDATA);
 
 #if CONFIG_IS_ENABLED(DM_DMA)
 static int dm_test_dma_offset(struct unit_test_state *uts)
@@ -1231,7 +1231,7 @@ static int dm_test_dma_offset(struct unit_test_state *uts)
 
        return 0;
 }
-DM_TEST(dm_test_dma_offset, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dma_offset, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #endif
 
 /* Test dm_get_stats() */
@@ -1245,7 +1245,7 @@ static int dm_test_get_stats(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_get_stats, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_get_stats, UTF_SCAN_FDT);
 
 /* Test uclass_find_device_by_name() */
 static int dm_test_uclass_find_device(struct unit_test_state *uts)
@@ -1260,7 +1260,7 @@ static int dm_test_uclass_find_device(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_uclass_find_device, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_uclass_find_device, UTF_SCAN_FDT);
 
 /* Test getting information about tags attached to devices */
 static int dm_test_dev_get_attach(struct unit_test_state *uts)
@@ -1288,7 +1288,7 @@ static int dm_test_dev_get_attach(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_dev_get_attach, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dev_get_attach, UTF_SCAN_FDT);
 
 /* Test getting information about tags attached to bus devices */
 static int dm_test_dev_get_attach_bus(struct unit_test_state *uts)
@@ -1340,7 +1340,7 @@ static int dm_test_dev_get_attach_bus(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_dev_get_attach_bus, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dev_get_attach_bus, UTF_SCAN_FDT);
 
 /* Test getting information about tags attached to bus devices */
 static int dm_test_dev_get_mem(struct unit_test_state *uts)
@@ -1351,4 +1351,4 @@ static int dm_test_dev_get_mem(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_dev_get_mem, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dev_get_mem, UTF_SCAN_FDT);
diff --git a/test/dm/cpu.c b/test/dm/cpu.c
index 8af25316cea..885cddb8690 100644
--- a/test/dm/cpu.c
+++ b/test/dm/cpu.c
@@ -48,4 +48,4 @@ static int dm_test_cpu(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_cpu, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cpu, UTF_SCAN_FDT);
diff --git a/test/dm/cros_ec.c b/test/dm/cros_ec.c
index ac0055f0acd..1108af4396c 100644
--- a/test/dm/cros_ec.c
+++ b/test/dm/cros_ec.c
@@ -28,7 +28,7 @@ static int dm_test_cros_ec_hello(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_hello, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_hello, UTF_SCAN_FDT);
 
 static int dm_test_cros_ec_sku_id(struct unit_test_state *uts)
 {
@@ -45,7 +45,7 @@ static int dm_test_cros_ec_sku_id(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_sku_id, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_sku_id, UTF_SCAN_FDT);
 
 static int dm_test_cros_ec_features(struct unit_test_state *uts)
 {
@@ -75,7 +75,7 @@ static int dm_test_cros_ec_features(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_features, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_features, UTF_SCAN_FDT);
 
 static int dm_test_cros_ec_switches(struct unit_test_state *uts)
 {
@@ -101,7 +101,7 @@ static int dm_test_cros_ec_switches(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_switches, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_switches, UTF_SCAN_FDT);
 
 static int dm_test_cros_ec_events(struct unit_test_state *uts)
 {
@@ -138,7 +138,7 @@ static int dm_test_cros_ec_events(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_events, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_events, UTF_SCAN_FDT);
 
 static int dm_test_cros_ec_vstore(struct unit_test_state *uts)
 {
@@ -174,4 +174,4 @@ static int dm_test_cros_ec_vstore(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_vstore, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_vstore, UTF_SCAN_FDT);
diff --git a/test/dm/cros_ec_pwm.c b/test/dm/cros_ec_pwm.c
index f68ee6f33b8..0b6ca8b8861 100644
--- a/test/dm/cros_ec_pwm.c
+++ b/test/dm/cros_ec_pwm.c
@@ -56,4 +56,4 @@ static int dm_test_cros_ec_pwm(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cros_ec_pwm, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cros_ec_pwm, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/devres.c b/test/dm/devres.c
index 7a3a669ddd4..efc5c72ae2a 100644
--- a/test/dm/devres.c
+++ b/test/dm/devres.c
@@ -39,7 +39,7 @@ static int dm_test_devres_alloc(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_devres_alloc, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_devres_alloc, UTF_SCAN_PDATA);
 
 /* Test devm_kfree() can be used to free memory too */
 static int dm_test_devres_free(struct unit_test_state *uts)
@@ -67,7 +67,7 @@ static int dm_test_devres_free(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_devres_free, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_devres_free, UTF_SCAN_PDATA);
 
 /* Test that kzalloc() returns memory that is zeroed */
 static int dm_test_devres_kzalloc(struct unit_test_state *uts)
@@ -86,7 +86,7 @@ static int dm_test_devres_kzalloc(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_devres_kzalloc, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_devres_kzalloc, UTF_SCAN_PDATA);
 
 /* Test that devm_kmalloc_array() allocates an array that can be set */
 static int dm_test_devres_kmalloc_array(struct unit_test_state *uts)
@@ -109,7 +109,7 @@ static int dm_test_devres_kmalloc_array(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_devres_kmalloc_array, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_devres_kmalloc_array, UTF_SCAN_PDATA);
 
 /* Test that devm_kcalloc() allocates a zeroed array */
 static int dm_test_devres_kcalloc(struct unit_test_state *uts)
@@ -138,7 +138,7 @@ static int dm_test_devres_kcalloc(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_devres_kcalloc, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_devres_kcalloc, UTF_SCAN_PDATA);
 
 /* Test devres releases resources automatically as expected */
 static int dm_test_devres_phase(struct unit_test_state *uts)
@@ -181,4 +181,4 @@ static int dm_test_devres_phase(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_devres_phase, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_devres_phase, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/dma.c b/test/dm/dma.c
index 949710fdb4e..be3862963b1 100644
--- a/test/dm/dma.c
+++ b/test/dm/dma.c
@@ -34,7 +34,7 @@ static int dm_test_dma_m2m(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_dma_m2m, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dma_m2m, UTF_SCAN_FDT);
 
 static int dm_test_dma(struct unit_test_state *uts)
 {
@@ -76,7 +76,7 @@ static int dm_test_dma(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_dma, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dma, UTF_SCAN_FDT);
 
 static int dm_test_dma_rx(struct unit_test_state *uts)
 {
@@ -121,4 +121,4 @@ static int dm_test_dma_rx(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_dma_rx, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dma_rx, UTF_SCAN_FDT);
diff --git a/test/dm/dsa.c b/test/dm/dsa.c
index c857106eaf4..2537605fdce 100644
--- a/test/dm/dsa.c
+++ b/test/dm/dsa.c
@@ -57,7 +57,7 @@ static int dm_test_dsa_probe(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_dsa_probe, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dsa_probe, UTF_SCAN_FDT);
 
 /* This test sends ping requests with the local address through each DSA port
  * via the sandbox DSA master Eth.
@@ -79,4 +79,4 @@ static int dm_test_dsa(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_dsa, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dsa, UTF_SCAN_FDT);
diff --git a/test/dm/dsi_host.c b/test/dm/dsi_host.c
index 68686a40d9f..bf3fd99a18b 100644
--- a/test/dm/dsi_host.c
+++ b/test/dm/dsi_host.c
@@ -55,4 +55,4 @@ static int dm_test_dsi_host(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_dsi_host, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dsi_host, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index da535c98b59..d7eac7115f7 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -35,4 +35,4 @@ static int dm_test_ecdsa_verify(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ecdsa_verify, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ecdsa_verify, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/efi_media.c b/test/dm/efi_media.c
index 9d0ed0f0755..0cf7e37e987 100644
--- a/test/dm/efi_media.c
+++ b/test/dm/efi_media.c
@@ -20,4 +20,4 @@ static int dm_test_efi_media(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_efi_media, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_efi_media, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/eth.c b/test/dm/eth.c
index 820b8cbfc29..8479ebd3f21 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -166,7 +166,7 @@ static int dm_test_ip6_make_lladdr(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ip6_make_lladdr, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ip6_make_lladdr, UTF_SCAN_FDT);
 #endif
 
 static int dm_test_eth(struct unit_test_state *uts)
@@ -187,7 +187,7 @@ static int dm_test_eth(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_eth, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_eth, UTF_SCAN_FDT);
 
 static int dm_test_eth_alias(struct unit_test_state *uts)
 {
@@ -211,7 +211,7 @@ static int dm_test_eth_alias(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_eth_alias, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_eth_alias, UTF_SCAN_FDT);
 
 static int dm_test_eth_prime(struct unit_test_state *uts)
 {
@@ -231,7 +231,7 @@ static int dm_test_eth_prime(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_eth_prime, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_eth_prime, UTF_SCAN_FDT);
 
 /**
  * This test case is trying to test the following scenario:
@@ -296,7 +296,7 @@ static int dm_test_eth_act(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_eth_act, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_eth_act, UTF_SCAN_FDT);
 
 /* Ensure that all addresses are loaded properly */
 static int dm_test_ethaddr(struct unit_test_state *uts)
@@ -329,7 +329,7 @@ static int dm_test_ethaddr(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ethaddr, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ethaddr, UTF_SCAN_FDT);
 
 /* The asserts include a return on fail; cleanup in the caller */
 static int _dm_test_eth_rotate1(struct unit_test_state *uts)
@@ -401,7 +401,7 @@ static int dm_test_eth_rotate(struct unit_test_state *uts)
 
 	return retval;
 }
-DM_TEST(dm_test_eth_rotate, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_eth_rotate, UTF_SCAN_FDT);
 
 /* The asserts include a return on fail; cleanup in the caller */
 static int _dm_test_net_retry(struct unit_test_state *uts)
@@ -444,7 +444,7 @@ static int dm_test_net_retry(struct unit_test_state *uts)
 
 	return retval;
 }
-DM_TEST(dm_test_net_retry, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_net_retry, UTF_SCAN_FDT);
 
 static int sb_check_arp_reply(struct udevice *dev, void *packet,
 			      unsigned int len)
@@ -529,7 +529,7 @@ static int dm_test_eth_async_arp_reply(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_eth_async_arp_reply, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_eth_async_arp_reply, UTF_SCAN_FDT);
 
 static int sb_check_ping_reply(struct udevice *dev, void *packet,
 			       unsigned int len)
@@ -614,7 +614,7 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_eth_async_ping_reply, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_eth_async_ping_reply, UTF_SCAN_FDT);
 
 #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
 
diff --git a/test/dm/extcon.c b/test/dm/extcon.c
index 6a4e22bfdc5..0f77b3d34b7 100644
--- a/test/dm/extcon.c
+++ b/test/dm/extcon.c
@@ -18,4 +18,4 @@ static int dm_test_extcon(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_extcon, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_extcon, UTF_SCAN_FDT);
diff --git a/test/dm/fastboot.c b/test/dm/fastboot.c
index 5d938eb7f12..73c43f82924 100644
--- a/test/dm/fastboot.c
+++ b/test/dm/fastboot.c
@@ -91,4 +91,4 @@ static int dm_test_fastboot_mmc_part(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fastboot_mmc_part, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fastboot_mmc_part, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
index b484414f5f0..1f24f1d5dff 100644
--- a/test/dm/fdtdec.c
+++ b/test/dm/fdtdec.c
@@ -55,7 +55,7 @@ static int dm_test_fdtdec_set_carveout(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdtdec_set_carveout,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
 static int dm_test_fdtdec_add_reserved_memory(struct unit_test_state *uts)
 {
@@ -128,4 +128,4 @@ static int dm_test_fdtdec_add_reserved_memory(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdtdec_add_reserved_memory,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index fa6d54d00d6..450e3e41562 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -198,7 +198,7 @@ static int dm_test_ffa_ack(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_ffa_ack, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_ffa_ack, UTF_SCAN_FDT | UTF_CONSOLE_REC);
 
 static int dm_test_ffa_nack(struct unit_test_state *uts)
 {
@@ -257,4 +257,4 @@ static int dm_test_ffa_nack(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_ffa_nack, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_ffa_nack, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/dm/firmware.c b/test/dm/firmware.c
index ec68e816999..795f6d5e403 100644
--- a/test/dm/firmware.c
+++ b/test/dm/firmware.c
@@ -19,4 +19,4 @@ static int dm_test_firmware_probe(struct unit_test_state *uts)
 					      "sandbox-firmware", &dev));
 	return 0;
 }
-DM_TEST(dm_test_firmware_probe, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_firmware_probe, UTF_SCAN_FDT);
diff --git a/test/dm/fpga.c b/test/dm/fpga.c
index 8bb35358532..28215a3a5bf 100644
--- a/test/dm/fpga.c
+++ b/test/dm/fpga.c
@@ -17,4 +17,4 @@ static int dm_test_fpga(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_fpga, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fpga, UTF_SCAN_FDT);
diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index 6154480ba83..b7680632f95 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -111,7 +111,7 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fwu_mdata_read, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fwu_mdata_read, UTF_SCAN_FDT);
 
 static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 {
@@ -142,4 +142,4 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fwu_mdata_write, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fwu_mdata_write, UTF_SCAN_FDT);
diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index 957ab25c8d3..b45946c143c 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -145,7 +145,7 @@ static int dm_test_gpio(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that GPIO open-drain/open-source emulation works correctly */
 static int dm_test_gpio_opendrain_opensource(struct unit_test_state *uts)
@@ -244,7 +244,7 @@ static int dm_test_gpio_opendrain_opensource(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_gpio_opendrain_opensource,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that sandbox anonymous GPIOs work correctly */
 static int dm_test_gpio_anon(struct unit_test_state *uts)
@@ -266,7 +266,7 @@ static int dm_test_gpio_anon(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio_anon, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_anon, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that gpio_requestf() works as expected */
 static int dm_test_gpio_requestf(struct unit_test_state *uts)
@@ -284,7 +284,7 @@ static int dm_test_gpio_requestf(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio_requestf, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_requestf, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that gpio_request() copies its string */
 static int dm_test_gpio_copy(struct unit_test_state *uts)
@@ -306,7 +306,7 @@ static int dm_test_gpio_copy(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio_copy, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_copy, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we don't leak memory with GPIOs */
 static int dm_test_gpio_leak(struct unit_test_state *uts)
@@ -318,7 +318,7 @@ static int dm_test_gpio_leak(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio_leak, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_leak, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can find GPIOs using phandles */
 static int dm_test_gpio_phandles(struct unit_test_state *uts)
@@ -392,7 +392,7 @@ static int dm_test_gpio_phandles(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio_phandles, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_phandles, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Check the gpio pin configuration get from device tree information */
 static int dm_test_gpio_get_dir_flags(struct unit_test_state *uts)
@@ -428,7 +428,7 @@ static int dm_test_gpio_get_dir_flags(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio_get_dir_flags, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_get_dir_flags, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of gpio_get_acpi() */
 static int dm_test_gpio_get_acpi(struct unit_test_state *uts)
@@ -457,7 +457,7 @@ static int dm_test_gpio_get_acpi(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio_get_acpi, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_get_acpi, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of gpio_get_acpi() with an interrupt GPIO */
 static int dm_test_gpio_get_acpi_irq(struct unit_test_state *uts)
@@ -489,7 +489,7 @@ static int dm_test_gpio_get_acpi_irq(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_gpio_get_acpi_irq, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_get_acpi_irq, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can get/release GPIOs using managed API */
 static int dm_test_gpio_devm(struct unit_test_state *uts)
@@ -590,7 +590,7 @@ static int dm_test_gpio_devm(struct unit_test_state *uts)
 	device_remove(dev2, DM_REMOVE_NORMAL);
 	return 0;
 }
-DM_TEST(dm_test_gpio_devm, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_gpio_devm, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_clrset_flags(struct unit_test_state *uts)
 {
@@ -631,7 +631,7 @@ static int dm_test_clrset_flags(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_clrset_flags, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_clrset_flags, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Check that an active-low GPIO works as expected */
 static int dm_test_clrset_flags_invert(struct unit_test_state *uts)
@@ -678,7 +678,7 @@ static int dm_test_clrset_flags_invert(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_clrset_flags_invert, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_clrset_flags_invert, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int set_gpios(struct unit_test_state *uts, struct gpio_desc *desc,
 		     int count, uint value)
@@ -719,7 +719,7 @@ static int dm_test_gpio_get_values_as_int(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_gpio_get_values_as_int,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Check that an active-low GPIO works as expected */
 static int dm_test_gpio_get_values_as_int_base3(struct unit_test_state *uts)
@@ -776,7 +776,7 @@ static int dm_test_gpio_get_values_as_int_base3(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_gpio_get_values_as_int_base3,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Check that gpio_get_status return the label of a GPIO configured as GPIOD_AF */
 static int dm_test_gpio_function(struct unit_test_state *uts)
@@ -806,4 +806,4 @@ static int dm_test_gpio_function(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_gpio_function,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/host.c b/test/dm/host.c
index e514f8409cf..ff6f43b3e31 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -72,7 +72,7 @@ static int dm_test_host(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_host, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_host, UTF_SCAN_FDT);
 
 /* reusing the same label should work */
 static int dm_test_host_dup(struct unit_test_state *uts)
@@ -106,7 +106,7 @@ static int dm_test_host_dup(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_host_dup, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_host_dup, UTF_SCAN_FDT);
 
 /* Basic test of 'host' command */
 static int dm_test_cmd_host(struct unit_test_state *uts)
@@ -199,4 +199,4 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cmd_host, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_host, UTF_SCAN_FDT);
diff --git a/test/dm/hwspinlock.c b/test/dm/hwspinlock.c
index a05b183b8bc..d6c786e93dd 100644
--- a/test/dm/hwspinlock.c
+++ b/test/dm/hwspinlock.c
@@ -37,4 +37,4 @@ static int dm_test_hwspinlock_base(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_hwspinlock_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_hwspinlock_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/i2c.c b/test/dm/i2c.c
index e9cf9f7819a..50a2cd0c1be 100644
--- a/test/dm/i2c.c
+++ b/test/dm/i2c.c
@@ -38,7 +38,7 @@ static int dm_test_i2c_find(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2c_find, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_find, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_read_write(struct unit_test_state *uts)
 {
@@ -55,7 +55,7 @@ static int dm_test_i2c_read_write(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2c_read_write, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_read_write, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_speed(struct unit_test_state *uts)
 {
@@ -77,7 +77,7 @@ static int dm_test_i2c_speed(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2c_speed, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_speed, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_offset_len(struct unit_test_state *uts)
 {
@@ -94,7 +94,7 @@ static int dm_test_i2c_offset_len(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2c_offset_len, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_offset_len, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_probe_empty(struct unit_test_state *uts)
 {
@@ -109,7 +109,7 @@ static int dm_test_i2c_probe_empty(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2c_probe_empty, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_probe_empty, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_bytewise(struct unit_test_state *uts)
 {
@@ -164,7 +164,7 @@ static int dm_test_i2c_bytewise(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2c_bytewise, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_bytewise, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_offset(struct unit_test_state *uts)
 {
@@ -237,7 +237,7 @@ static int dm_test_i2c_offset(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2c_offset, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_offset, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_addr_offset(struct unit_test_state *uts)
 {
@@ -302,7 +302,7 @@ static int dm_test_i2c_addr_offset(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_i2c_addr_offset, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_addr_offset, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_reg_clrset(struct unit_test_state *uts)
 {
@@ -331,4 +331,4 @@ static int dm_test_i2c_reg_clrset(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2c_reg_clrset, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2c_reg_clrset, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/i2s.c b/test/dm/i2s.c
index a3d3a31b6fb..cc336690e60 100644
--- a/test/dm/i2s.c
+++ b/test/dm/i2s.c
@@ -29,4 +29,4 @@ static int dm_test_i2s(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_i2s, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_i2s, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/iommu.c b/test/dm/iommu.c
index acea5f28971..c5dd917f00c 100644
--- a/test/dm/iommu.c
+++ b/test/dm/iommu.c
@@ -38,7 +38,7 @@ static int dm_test_iommu(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_iommu, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_iommu, UTF_SCAN_FDT);
 
 static int dm_test_iommu_noiommu(struct unit_test_state *uts)
 {
@@ -66,7 +66,7 @@ static int dm_test_iommu_noiommu(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_iommu_noiommu, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_iommu_noiommu, UTF_SCAN_FDT);
 
 static int dm_test_iommu_pci(struct unit_test_state *uts)
 {
@@ -81,7 +81,7 @@ static int dm_test_iommu_pci(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_iommu_pci, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_iommu_pci, UTF_SCAN_FDT);
 
 static int dm_test_iommu_pci_noiommu(struct unit_test_state *uts)
 {
@@ -96,4 +96,4 @@ static int dm_test_iommu_pci_noiommu(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_iommu_pci_noiommu, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_iommu_pci_noiommu, UTF_SCAN_FDT);
diff --git a/test/dm/irq.c b/test/dm/irq.c
index d22772ab769..836f2d82e71 100644
--- a/test/dm/irq.c
+++ b/test/dm/irq.c
@@ -30,7 +30,7 @@ static int dm_test_irq_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_irq_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_irq_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of irq_first_device_type() */
 static int dm_test_irq_type(struct unit_test_state *uts)
@@ -42,7 +42,7 @@ static int dm_test_irq_type(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_irq_type, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_irq_type, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of irq_read_and_clear() */
 static int dm_test_read_and_clear(struct unit_test_state *uts)
@@ -59,7 +59,7 @@ static int dm_test_read_and_clear(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_read_and_clear, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_read_and_clear, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of irq_request() */
 static int dm_test_request(struct unit_test_state *uts)
@@ -74,7 +74,7 @@ static int dm_test_request(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_request, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_request, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of irq_get_acpi() */
 static int dm_test_irq_get_acpi(struct unit_test_state *uts)
@@ -96,4 +96,4 @@ static int dm_test_irq_get_acpi(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_irq_get_acpi, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_irq_get_acpi, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/led.c b/test/dm/led.c
index c28fa044f45..e1509c397d8 100644
--- a/test/dm/led.c
+++ b/test/dm/led.c
@@ -24,7 +24,7 @@ static int dm_test_led_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_led_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_led_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of the LED 'default-state' device tree property */
 static int dm_test_led_default_state(struct unit_test_state *uts)
@@ -41,7 +41,7 @@ static int dm_test_led_default_state(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_led_default_state, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_led_default_state, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of the led uclass using the led_gpio driver */
 static int dm_test_led_gpio(struct unit_test_state *uts)
@@ -66,7 +66,7 @@ static int dm_test_led_gpio(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_led_gpio, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_led_gpio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can toggle LEDs */
 static int dm_test_led_toggle(struct unit_test_state *uts)
@@ -91,7 +91,7 @@ static int dm_test_led_toggle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_led_toggle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_led_toggle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test obtaining an LED by label */
 static int dm_test_led_label(struct unit_test_state *uts)
@@ -112,7 +112,7 @@ static int dm_test_led_label(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_led_label, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_led_label, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test LED blinking */
 #ifdef CONFIG_LED_BLINK
@@ -135,5 +135,5 @@ static int dm_test_led_blink(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_led_blink, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_led_blink, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #endif
diff --git a/test/dm/mailbox.c b/test/dm/mailbox.c
index 14f72d58d1c..4a0648b9277 100644
--- a/test/dm/mailbox.c
+++ b/test/dm/mailbox.c
@@ -28,4 +28,4 @@ static int dm_test_mailbox(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_mailbox, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_mailbox, UTF_SCAN_FDT);
diff --git a/test/dm/mdio.c b/test/dm/mdio.c
index 7ececf37ccc..325b2122822 100644
--- a/test/dm/mdio.c
+++ b/test/dm/mdio.c
@@ -54,4 +54,4 @@ static int dm_test_mdio(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_mdio, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_mdio, UTF_SCAN_FDT);
diff --git a/test/dm/mdio_mux.c b/test/dm/mdio_mux.c
index 33a7e972609..864bc0c3190 100644
--- a/test/dm/mdio_mux.c
+++ b/test/dm/mdio_mux.c
@@ -77,4 +77,4 @@ static int dm_test_mdio_mux(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_mdio_mux, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_mdio_mux, UTF_SCAN_FDT);
diff --git a/test/dm/memory.c b/test/dm/memory.c
index 7d9500aa91d..64ceb99f8df 100644
--- a/test/dm/memory.c
+++ b/test/dm/memory.c
@@ -18,4 +18,4 @@ static int dm_test_memory(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_memory, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_memory, UTF_SCAN_FDT);
diff --git a/test/dm/misc.c b/test/dm/misc.c
index ad856fd01b6..1abc9eee045 100644
--- a/test/dm/misc.c
+++ b/test/dm/misc.c
@@ -80,4 +80,4 @@ static int dm_test_misc(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_misc, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_misc, UTF_SCAN_FDT);
diff --git a/test/dm/mmc.c b/test/dm/mmc.c
index c0abea797d9..cdebb955196 100644
--- a/test/dm/mmc.c
+++ b/test/dm/mmc.c
@@ -22,7 +22,7 @@ static int dm_test_mmc_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_mmc_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_mmc_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_mmc_blk(struct unit_test_state *uts)
 {
@@ -50,4 +50,4 @@ static int dm_test_mmc_blk(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_mmc_blk, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_mmc_blk, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/mux-cmd.c b/test/dm/mux-cmd.c
index d4bb8befa38..3aadc159ae8 100644
--- a/test/dm/mux-cmd.c
+++ b/test/dm/mux-cmd.c
@@ -109,7 +109,7 @@ static int dm_test_cmd_mux_list(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cmd_mux_list, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_mux_list, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_cmd_mux_select(struct unit_test_state *uts)
 {
@@ -143,7 +143,7 @@ static int dm_test_cmd_mux_select(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cmd_mux_select, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_mux_select, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_cmd_mux_deselect(struct unit_test_state *uts)
 {
@@ -174,4 +174,4 @@ static int dm_test_cmd_mux_deselect(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cmd_mux_deselect, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_mux_deselect, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/mux-emul.c b/test/dm/mux-emul.c
index febd521104a..de231e4e5b2 100644
--- a/test/dm/mux-emul.c
+++ b/test/dm/mux-emul.c
@@ -79,7 +79,7 @@ static int dm_test_mux_emul_default_state(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_mux_emul_default_state, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_mux_emul_default_state, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_mux_emul_select_deselect(struct unit_test_state *uts)
 {
@@ -102,4 +102,4 @@ static int dm_test_mux_emul_select_deselect(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_mux_emul_select_deselect, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_mux_emul_select_deselect, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/mux-mmio.c b/test/dm/mux-mmio.c
index 3a871a19c7e..3bb1e49b8c9 100644
--- a/test/dm/mux-mmio.c
+++ b/test/dm/mux-mmio.c
@@ -85,7 +85,7 @@ static int dm_test_mux_mmio_select(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_mux_mmio_select, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_mux_mmio_select, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that managed API for mux work correctly */
 static int dm_test_devm_mux_mmio(struct unit_test_state *uts)
@@ -134,4 +134,4 @@ static int dm_test_devm_mux_mmio(struct unit_test_state *uts)
 	device_remove(dev_b, DM_REMOVE_NORMAL);
 	return 0;
 }
-DM_TEST(dm_test_devm_mux_mmio, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_devm_mux_mmio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/nand.c b/test/dm/nand.c
index 0b992fdce1c..397cc88567c 100644
--- a/test/dm/nand.c
+++ b/test/dm/nand.c
@@ -93,12 +93,12 @@ static int dm_test_nand##dev##_start(struct unit_test_state *uts) \
 { \
 	return dm_test_nand(uts, dev, false); \
 } \
-DM_TEST(dm_test_nand##dev##_start, UT_TESTF_SCAN_FDT); \
+DM_TEST(dm_test_nand##dev##_start, UTF_SCAN_FDT); \
 static int dm_test_nand##dev##_end(struct unit_test_state *uts) \
 { \
 	return dm_test_nand(uts, dev, true); \
 } \
-DM_TEST(dm_test_nand##dev##_end, UT_TESTF_SCAN_FDT)
+DM_TEST(dm_test_nand##dev##_end, UTF_SCAN_FDT)
 
 DM_NAND_TEST(0);
 DM_NAND_TEST(1);
diff --git a/test/dm/nop.c b/test/dm/nop.c
index 0c79431d9d8..7eac16703d7 100644
--- a/test/dm/nop.c
+++ b/test/dm/nop.c
@@ -70,4 +70,4 @@ static int dm_test_nop(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_nop, UT_TESTF_FLAT_TREE | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_nop, UTF_FLAT_TREE | UTF_SCAN_FDT);
diff --git a/test/dm/nvmxip.c b/test/dm/nvmxip.c
index 537959a0930..67e19f2a30e 100644
--- a/test/dm/nvmxip.c
+++ b/test/dm/nvmxip.c
@@ -143,4 +143,4 @@ static int dm_test_nvmxip(struct unit_test_state *uts)
 	return CMD_RET_SUCCESS;
 }
 
-DM_TEST(dm_test_nvmxip, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_nvmxip, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/dm/of_platdata.c b/test/dm/of_platdata.c
index d4939e88516..6e35bcaf62c 100644
--- a/test/dm/of_platdata.c
+++ b/test/dm/of_platdata.c
@@ -20,7 +20,7 @@ static int dm_test_of_plat_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_of_plat_base, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_of_plat_base, UTF_SCAN_PDATA);
 
 /* Test that we can read properties from a device */
 static int dm_test_of_plat_props(struct unit_test_state *uts)
@@ -91,7 +91,7 @@ static int dm_test_of_plat_props(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_of_plat_props, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_of_plat_props, UTF_SCAN_PDATA);
 
 /*
  * find_driver_info - recursively find the driver_info for a device
@@ -173,7 +173,7 @@ static int dm_test_of_plat_dev(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_of_plat_dev, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_of_plat_dev, UTF_SCAN_PDATA);
 
 /* Test handling of phandles that point to other devices */
 static int dm_test_of_plat_phandle(struct unit_test_state *uts)
@@ -206,7 +206,7 @@ static int dm_test_of_plat_phandle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_of_plat_phandle, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_of_plat_phandle, UTF_SCAN_PDATA);
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA_PARENT)
 /* Test that device parents are correctly set up */
@@ -220,7 +220,7 @@ static int dm_test_of_plat_parent(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_of_plat_parent, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_of_plat_parent, UTF_SCAN_PDATA);
 #endif
 
 /* Test clocks with of-platdata */
@@ -239,7 +239,7 @@ static int dm_test_of_plat_clk(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_of_plat_clk, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_of_plat_clk, UTF_SCAN_PDATA);
 
 /* Test irqs with of-platdata */
 static int dm_test_of_plat_irq(struct unit_test_state *uts)
@@ -258,7 +258,7 @@ static int dm_test_of_plat_irq(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_of_plat_irq, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_of_plat_irq, UTF_SCAN_PDATA);
 
 /* Test GPIOs with of-platdata */
 static int dm_test_of_plat_gpio(struct unit_test_state *uts)
@@ -277,4 +277,4 @@ static int dm_test_of_plat_gpio(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_of_plat_gpio, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_of_plat_gpio, UTF_SCAN_PDATA);
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 39191d7f52b..859fc3ae0d0 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -47,7 +47,7 @@ oftree get_other_oftree(struct unit_test_state *uts)
 
 	/* An invalid tree may cause failure or crashes */
 	if (!oftree_valid(tree))
-		ut_reportf("test needs the UT_TESTF_OTHER_FDT flag");
+		ut_reportf("test needs the UTF_OTHER_FDT flag");
 
 	return tree;
 }
@@ -103,7 +103,7 @@ static int dm_test_ofnode_compatible(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_ofnode_compatible,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* check ofnode_device_is_compatible() with the 'other' FDT */
 static int dm_test_ofnode_compatible_ot(struct unit_test_state *uts)
@@ -116,7 +116,7 @@ static int dm_test_ofnode_compatible_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_compatible_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_compatible_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 static int dm_test_ofnode_get_by_phandle(struct unit_test_state *uts)
 {
@@ -134,7 +134,7 @@ static int dm_test_ofnode_get_by_phandle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_by_phandle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_get_by_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test oftree_get_by_phandle() with a the 'other' oftree */
 static int dm_test_ofnode_get_by_phandle_ot(struct unit_test_state *uts)
@@ -150,7 +150,7 @@ static int dm_test_ofnode_get_by_phandle_ot(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_ofnode_get_by_phandle_ot,
-	UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+	UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 static int check_prop_values(struct unit_test_state *uts, ofnode start,
 			     const char *propname, const char *propval,
@@ -189,7 +189,7 @@ static int dm_test_ofnode_by_prop_value(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_by_prop_value, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_by_prop_value, UTF_SCAN_FDT);
 
 /* test ofnode_by_prop_value() with a the 'other' oftree */
 static int dm_test_ofnode_by_prop_value_ot(struct unit_test_state *uts)
@@ -202,7 +202,7 @@ static int dm_test_ofnode_by_prop_value_ot(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_ofnode_by_prop_value_ot,
-	UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+	UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 /* test ofnode_read_fmap_entry() */
 static int dm_test_ofnode_fmap(struct unit_test_state *uts)
@@ -218,7 +218,7 @@ static int dm_test_ofnode_fmap(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_fmap, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_fmap, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_read_prop() */
 static int dm_test_ofnode_read(struct unit_test_state *uts)
@@ -248,7 +248,7 @@ static int dm_test_ofnode_read(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_read, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read, UTF_SCAN_FDT);
 
 /* test ofnode_read_prop() with the 'other' tree */
 static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
@@ -271,7 +271,7 @@ static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_read_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_read_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 /* test ofnode_count_/parse_phandle_with_args() */
 static int dm_test_ofnode_phandle(struct unit_test_state *uts)
@@ -347,7 +347,7 @@ static int dm_test_ofnode_phandle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_phandle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_count_/parse_phandle_with_args() with 'other' tree */
 static int dm_test_ofnode_phandle_ot(struct unit_test_state *uts)
@@ -376,7 +376,7 @@ static int dm_test_ofnode_phandle_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_phandle_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_phandle_ot, UTF_OTHER_FDT);
 
 /* test ofnode_read_chosen_string/node/prop() */
 static int dm_test_ofnode_read_chosen(struct unit_test_state *uts)
@@ -406,7 +406,7 @@ static int dm_test_ofnode_read_chosen(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_read_chosen, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read_chosen, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_get_aliases_node/prop() */
 static int dm_test_ofnode_read_aliases(struct unit_test_state *uts)
@@ -429,7 +429,7 @@ static int dm_test_ofnode_read_aliases(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_read_aliases, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read_aliases, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_ofnode_get_child_count(struct unit_test_state *uts)
 {
@@ -450,7 +450,7 @@ static int dm_test_ofnode_get_child_count(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_ofnode_get_child_count,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_get_child_count() with 'other' tree */
 static int dm_test_ofnode_get_child_count_ot(struct unit_test_state *uts)
@@ -473,7 +473,7 @@ static int dm_test_ofnode_get_child_count_ot(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_ofnode_get_child_count_ot,
-	UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+	UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 static int dm_test_ofnode_is_enabled(struct unit_test_state *uts)
 {
@@ -485,7 +485,7 @@ static int dm_test_ofnode_is_enabled(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_is_enabled, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_is_enabled, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_is_enabled() with 'other' tree */
 static int dm_test_ofnode_is_enabled_ot(struct unit_test_state *uts)
@@ -499,7 +499,7 @@ static int dm_test_ofnode_is_enabled_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_is_enabled_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_is_enabled_ot, UTF_OTHER_FDT);
 
 /* test ofnode_get_addr/size() */
 static int dm_test_ofnode_get_reg(struct unit_test_state *uts)
@@ -536,7 +536,7 @@ static int dm_test_ofnode_get_reg(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_reg, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_get_reg, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_get_addr() with 'other' tree */
 static int dm_test_ofnode_get_reg_ot(struct unit_test_state *uts)
@@ -550,7 +550,7 @@ static int dm_test_ofnode_get_reg_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_reg_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_get_reg_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 static int dm_test_ofnode_get_path(struct unit_test_state *uts)
 {
@@ -571,7 +571,7 @@ static int dm_test_ofnode_get_path(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_path, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_get_path, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_get_path() with 'other' tree */
 static int dm_test_ofnode_get_path_ot(struct unit_test_state *uts)
@@ -591,7 +591,7 @@ static int dm_test_ofnode_get_path_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_path_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_get_path_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 /* test ofnode_conf_read_bool/int/str() */
 static int dm_test_ofnode_conf(struct unit_test_state *uts)
@@ -607,7 +607,7 @@ static int dm_test_ofnode_conf(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_conf, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_conf, UTF_SCAN_FDT);
 
 static int dm_test_ofnode_options(struct unit_test_state *uts)
 {
@@ -644,7 +644,7 @@ static int dm_test_ofnode_for_each_compatible_node(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_for_each_compatible_node, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_for_each_compatible_node, UTF_SCAN_FDT);
 
 /* test dm_test_ofnode_string_count/index/list() */
 static int dm_test_ofnode_string(struct unit_test_state *uts)
@@ -692,7 +692,7 @@ static int dm_test_ofnode_string(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_string, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_string, UTF_SCAN_FDT);
 
 /* test error returns from ofnode_read_string_count/index/list() */
 static int dm_test_ofnode_string_err(struct unit_test_state *uts)
@@ -742,7 +742,7 @@ static int dm_test_ofnode_string_err(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_string_err, UT_TESTF_LIVE_TREE);
+DM_TEST(dm_test_ofnode_string_err, UTF_LIVE_TREE);
 
 static int dm_test_ofnode_read_phy_mode(struct unit_test_state *uts)
 {
@@ -764,7 +764,7 @@ static int dm_test_ofnode_read_phy_mode(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_read_phy_mode, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read_phy_mode, UTF_SCAN_FDT);
 
 /**
  * make_ofnode_fdt() - Create an FDT for testing with ofnode
@@ -811,7 +811,7 @@ static int dm_test_ofnode_aliases(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_aliases, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_aliases, UTF_SCAN_FDT);
 
 /**
  * dm_test_ofnode_root_mult() - Check aliaes on control and 'other' tree
@@ -850,7 +850,7 @@ static int dm_test_ofnode_root_mult(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_root_mult, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_root_mult, UTF_SCAN_FDT);
 
 /* test ofnode_set_enabled(), ofnode_write_prop() on a livetree */
 static int dm_test_ofnode_livetree_writing(struct unit_test_state *uts)
@@ -897,7 +897,7 @@ static int dm_test_ofnode_livetree_writing(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_ofnode_livetree_writing,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int check_write_prop(struct unit_test_state *uts, ofnode node)
 {
@@ -940,7 +940,7 @@ static int dm_test_ofnode_write_copy(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_write_copy, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_write_copy, UTF_SCAN_FDT);
 
 /* test writing a property to the 'other' tree */
 static int dm_test_ofnode_write_copy_ot(struct unit_test_state *uts)
@@ -957,7 +957,7 @@ static int dm_test_ofnode_write_copy_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_write_copy_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_write_copy_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 /* test ofnode_read_u32_index/default() */
 static int dm_test_ofnode_u32(struct unit_test_state *uts)
@@ -985,7 +985,7 @@ static int dm_test_ofnode_u32(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_u32, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_u32, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_read_u32_array() */
 static int dm_test_ofnode_u32_array(struct unit_test_state *uts)
@@ -1012,7 +1012,7 @@ static int dm_test_ofnode_u32_array(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_u32_array, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_u32_array, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test ofnode_read_u64() and ofnode_write_u64() */
 static int dm_test_ofnode_u64(struct unit_test_state *uts)
@@ -1046,7 +1046,7 @@ static int dm_test_ofnode_u64(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_u64, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_u64, UTF_SCAN_FDT);
 
 static int dm_test_ofnode_add_subnode(struct unit_test_state *uts)
 {
@@ -1115,7 +1115,7 @@ static int dm_test_ofnode_add_subnode(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_add_subnode, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_add_subnode, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_ofnode_for_each_prop(struct unit_test_state *uts)
 {
@@ -1139,7 +1139,7 @@ static int dm_test_ofnode_for_each_prop(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_for_each_prop, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_for_each_prop, UTF_SCAN_FDT);
 
 static int dm_test_ofnode_by_compatible(struct unit_test_state *uts)
 {
@@ -1155,7 +1155,7 @@ static int dm_test_ofnode_by_compatible(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_by_compatible, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_by_compatible, UTF_SCAN_FDT);
 
 /* check ofnode_by_compatible() on the 'other' tree */
 static int dm_test_ofnode_by_compatible_ot(struct unit_test_state *uts)
@@ -1173,7 +1173,7 @@ static int dm_test_ofnode_by_compatible_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_by_compatible_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_by_compatible_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 static int dm_test_ofnode_find_subnode(struct unit_test_state *uts)
 {
@@ -1190,7 +1190,7 @@ static int dm_test_ofnode_find_subnode(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_find_subnode, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_find_subnode, UTF_SCAN_FDT);
 
 /* test ofnode_find_subnode() on the 'other' tree */
 static int dm_test_ofnode_find_subnode_ot(struct unit_test_state *uts)
@@ -1209,7 +1209,7 @@ static int dm_test_ofnode_find_subnode_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_find_subnode_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_find_subnode_ot, UTF_OTHER_FDT);
 
 static int dm_test_ofnode_get_name(struct unit_test_state *uts)
 {
@@ -1222,7 +1222,7 @@ static int dm_test_ofnode_get_name(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_name, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_get_name, UTF_SCAN_FDT);
 
 /* try to access more FDTs than is supported */
 static int dm_test_ofnode_too_many(struct unit_test_state *uts)
@@ -1259,7 +1259,7 @@ static int dm_test_ofnode_too_many(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_too_many, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_too_many, UTF_SCAN_FDT);
 
 static int check_copy_props(struct unit_test_state *uts, ofnode dst, ofnode src)
 {
@@ -1304,7 +1304,7 @@ static int dm_test_ofnode_copy_props(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_copy_props, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_copy_props, UTF_SCAN_FDT);
 
 /* test ofnode_copy_props() with the 'other' tree */
 static int dm_test_ofnode_copy_props_ot(struct unit_test_state *uts)
@@ -1318,7 +1318,7 @@ static int dm_test_ofnode_copy_props_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_copy_props_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_copy_props_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 /* check that the livetree is aligned to a structure boundary */
 static int dm_test_livetree_align(struct unit_test_state *uts)
@@ -1344,7 +1344,7 @@ static int dm_test_livetree_align(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_livetree_align, UT_TESTF_SCAN_FDT | UT_TESTF_LIVE_TREE);
+DM_TEST(dm_test_livetree_align, UTF_SCAN_FDT | UTF_LIVE_TREE);
 
 /* check that it is possible to load an arbitrary livetree */
 static int dm_test_livetree_ensure(struct unit_test_state *uts)
@@ -1363,7 +1363,7 @@ static int dm_test_livetree_ensure(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_livetree_ensure, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_livetree_ensure, UTF_SCAN_FDT);
 
 static int dm_test_oftree_new(struct unit_test_state *uts)
 {
@@ -1379,7 +1379,7 @@ static int dm_test_oftree_new(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_oftree_new, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_oftree_new, UTF_SCAN_FDT);
 
 static int check_copy_node(struct unit_test_state *uts, ofnode dst, ofnode src,
 			   ofnode *nodep)
@@ -1428,7 +1428,7 @@ static int dm_test_ofnode_copy_node(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_copy_node, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_copy_node, UTF_SCAN_FDT);
 
 /* test ofnode_copy_node() with the 'other' tree */
 static int dm_test_ofnode_copy_node_ot(struct unit_test_state *uts)
@@ -1442,7 +1442,7 @@ static int dm_test_ofnode_copy_node_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_copy_node_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_copy_node_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
 static int dm_test_ofnode_delete(struct unit_test_state *uts)
 {
@@ -1473,7 +1473,7 @@ static int dm_test_ofnode_delete(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_delete, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_delete, UTF_SCAN_FDT);
 
 static int dm_test_oftree_to_fdt(struct unit_test_state *uts)
 {
@@ -1495,7 +1495,7 @@ static int dm_test_oftree_to_fdt(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_oftree_to_fdt, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_oftree_to_fdt, UTF_SCAN_FDT);
 
 /* test ofnode_read_bool() and ofnode_write_bool() */
 static int dm_test_bool(struct unit_test_state *uts)
@@ -1520,4 +1520,4 @@ static int dm_test_bool(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_bool, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_bool, UTF_SCAN_FDT);
diff --git a/test/dm/ofread.c b/test/dm/ofread.c
index 69d03c49107..069551a31af 100644
--- a/test/dm/ofread.c
+++ b/test/dm/ofread.c
@@ -45,4 +45,4 @@ static int dm_test_ofprop_get_property(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofprop_get_property, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofprop_get_property, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/osd.c b/test/dm/osd.c
index cf4a3a545ed..5e77d3b5264 100644
--- a/test/dm/osd.c
+++ b/test/dm/osd.c
@@ -131,7 +131,7 @@ static int dm_test_osd_basics(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_osd_basics, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_osd_basics, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_osd_extended(struct unit_test_state *uts)
 {
@@ -215,4 +215,4 @@ static int dm_test_osd_extended(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_osd_extended, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_osd_extended, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/p2sb.c b/test/dm/p2sb.c
index 3ada1fcb362..4cc374e04ed 100644
--- a/test/dm/p2sb.c
+++ b/test/dm/p2sb.c
@@ -24,4 +24,4 @@ static int dm_test_p2sb_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_p2sb_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_p2sb_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/panel.c b/test/dm/panel.c
index 8be7c397a46..ce835c96ed0 100644
--- a/test/dm/panel.c
+++ b/test/dm/panel.c
@@ -76,4 +76,4 @@ static int dm_test_panel(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_panel, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_panel, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/part.c b/test/dm/part.c
index cabb31d18ca..c5c4b3fdba1 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -93,7 +93,7 @@ static int dm_test_part(struct unit_test_state *uts)
 	env_set("bootdevice", oldbootdevice);
 	return ret;
 }
-DM_TEST(dm_test_part, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_part, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_part_bootable(struct unit_test_state *uts)
 {
@@ -106,7 +106,7 @@ static int dm_test_part_bootable(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_part_bootable, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_part_bootable, UTF_SCAN_FDT);
 
 static int do_get_info_test(struct unit_test_state *uts,
 			    struct blk_desc *dev_desc, int part, int part_type,
@@ -193,4 +193,4 @@ static int dm_test_part_get_info_by_type(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_part_get_info_by_type, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_part_get_info_by_type, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/pch.c b/test/dm/pch.c
index b37b856d5da..88e924dc2a6 100644
--- a/test/dm/pch.c
+++ b/test/dm/pch.c
@@ -33,7 +33,7 @@ static int dm_test_pch_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pch_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pch_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test sandbox PCH ioctl */
 static int dm_test_pch_ioctl(struct unit_test_state *uts)
@@ -52,4 +52,4 @@ static int dm_test_pch_ioctl(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pch_ioctl, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pch_ioctl, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/pci.c b/test/dm/pci.c
index 9b97f2e0544..6eb19f6fea3 100644
--- a/test/dm/pci.c
+++ b/test/dm/pci.c
@@ -19,7 +19,7 @@ static int dm_test_pci_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that sandbox PCI bus numbering and device works correctly */
 static int dm_test_pci_busdev(struct unit_test_state *uts)
@@ -54,7 +54,7 @@ static int dm_test_pci_busdev(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_busdev, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_busdev, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can use the swapcase device correctly */
 static int dm_test_pci_swapcase(struct unit_test_state *uts)
@@ -107,7 +107,7 @@ static int dm_test_pci_swapcase(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_swapcase, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_swapcase, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can dynamically bind the device driver correctly */
 static int dm_test_pci_drvdata(struct unit_test_state *uts)
@@ -129,7 +129,7 @@ static int dm_test_pci_drvdata(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_drvdata, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_drvdata, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that devices on PCI bus#2 can be accessed correctly */
 static int dm_test_pci_mixed(struct unit_test_state *uts)
@@ -192,7 +192,7 @@ static int dm_test_pci_mixed(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_mixed, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_mixed, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test looking up PCI capability and extended capability */
 static int dm_test_pci_cap(struct unit_test_state *uts)
@@ -244,7 +244,7 @@ static int dm_test_pci_cap(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_cap, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_cap, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test looking up BARs in EA capability structure */
 static int dm_test_pci_ea(struct unit_test_state *uts)
@@ -293,7 +293,7 @@ static int dm_test_pci_ea(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_ea, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_ea, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test the dev_read_addr_pci() function */
 static int dm_test_pci_addr_flat(struct unit_test_state *uts)
@@ -318,14 +318,14 @@ static int dm_test_pci_addr_flat(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_addr_flat, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT |
-		UT_TESTF_FLAT_TREE);
+DM_TEST(dm_test_pci_addr_flat, UTF_SCAN_PDATA | UTF_SCAN_FDT |
+		UTF_FLAT_TREE);
 
 /*
  * Test the dev_read_addr_pci() function with livetree. That function is
  * not currently fully implemented, in that it fails to return the BAR address.
  * Once that is implemented this test can be removed and dm_test_pci_addr_flat()
- * can be used for both flattree and livetree by removing the UT_TESTF_FLAT_TREE
+ * can be used for both flattree and livetree by removing the UTF_FLAT_TREE
  * flag above.
  */
 static int dm_test_pci_addr_live(struct unit_test_state *uts)
@@ -343,8 +343,7 @@ static int dm_test_pci_addr_live(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_addr_live, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT |
-		UT_TESTF_LIVE_TREE);
+DM_TEST(dm_test_pci_addr_live, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_LIVE_TREE);
 
 /* Test device_is_on_pci_bus() */
 static int dm_test_pci_on_bus(struct unit_test_state *uts)
@@ -358,7 +357,7 @@ static int dm_test_pci_on_bus(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_on_bus, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_on_bus, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /*
  * Test support for multiple memory regions enabled via
@@ -380,7 +379,7 @@ static int dm_test_pci_region_multi(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_region_multi, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_region_multi, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /*
  * Test the translation of PCI bus addresses to physical addresses using the
@@ -433,7 +432,7 @@ static int dm_test_pci_bus_to_phys(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_bus_to_phys, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_bus_to_phys, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /*
  * Test the translation of physical addresses to PCI bus addresses using the
@@ -486,4 +485,4 @@ static int dm_test_pci_phys_to_bus(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pci_phys_to_bus, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_phys_to_bus, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/pci_ep.c b/test/dm/pci_ep.c
index e82fc53f84b..244fefa40bf 100644
--- a/test/dm/pci_ep.c
+++ b/test/dm/pci_ep.c
@@ -60,4 +60,4 @@ static int dm_test_pci_ep_base(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_pci_ep_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pci_ep_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/phy.c b/test/dm/phy.c
index d14117f6f7a..9b4cff60e6a 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -68,7 +68,7 @@ static int dm_test_phy_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_phy_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_phy_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of the phy uclass using the sandbox phy driver operations */
 static int dm_test_phy_ops(struct unit_test_state *uts)
@@ -140,7 +140,7 @@ static int dm_test_phy_ops(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_phy_ops, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_phy_ops, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_phy_bulk(struct unit_test_state *uts)
 {
@@ -173,7 +173,7 @@ static int dm_test_phy_bulk(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_phy_bulk, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_phy_bulk, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_phy_multi_exit(struct unit_test_state *uts)
 {
@@ -232,7 +232,7 @@ static int dm_test_phy_multi_exit(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_phy_multi_exit, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_phy_multi_exit, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_phy_setup(struct unit_test_state *uts)
 {
@@ -261,4 +261,4 @@ static int dm_test_phy_setup(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_phy_setup, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_phy_setup, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/phys2bus.c b/test/dm/phys2bus.c
index 1ee2150482c..0f30c7e37fd 100644
--- a/test/dm/phys2bus.c
+++ b/test/dm/phys2bus.c
@@ -33,4 +33,4 @@ static int dm_test_phys_to_bus(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_phys_to_bus, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_phys_to_bus, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/pinmux.c b/test/dm/pinmux.c
index cfbe3ef5d1e..92e5bc83802 100644
--- a/test/dm/pinmux.c
+++ b/test/dm/pinmux.c
@@ -68,8 +68,7 @@ static int dm_test_pinmux(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(dm_test_pinmux, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pinmux, UTF_SCAN_FDT);
 
 static int dm_test_pinctrl_single(struct unit_test_state *uts)
 {
@@ -143,5 +142,4 @@ static int dm_test_pinctrl_single(struct unit_test_state *uts)
 	ut_asserteq(-EINVAL, ret);
 	return 0;
 }
-
-DM_TEST(dm_test_pinctrl_single, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pinctrl_single, UTF_SCAN_FDT);
diff --git a/test/dm/pmc.c b/test/dm/pmc.c
index bbad1ee2741..00122798b71 100644
--- a/test/dm/pmc.c
+++ b/test/dm/pmc.c
@@ -29,4 +29,4 @@ static int dm_test_pmc_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pmc_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pmc_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/pmic.c b/test/dm/pmic.c
index 53a6f0369e8..146aedf8f93 100644
--- a/test/dm/pmic.c
+++ b/test/dm/pmic.c
@@ -43,7 +43,7 @@ static int dm_test_power_pmic_get(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_pmic_get, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_pmic_get, UTF_SCAN_FDT);
 
 /* PMIC get method - MC34708 - for 3 bytes transmission */
 static int dm_test_power_pmic_mc34708_get(struct unit_test_state *uts)
@@ -53,7 +53,7 @@ static int dm_test_power_pmic_mc34708_get(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_power_pmic_mc34708_get, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_pmic_mc34708_get, UTF_SCAN_FDT);
 
 /* Test PMIC I/O */
 static int dm_test_power_pmic_io(struct unit_test_state *uts)
@@ -82,7 +82,7 @@ static int dm_test_power_pmic_io(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_pmic_io, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_pmic_io, UTF_SCAN_FDT);
 
 #define MC34708_PMIC_REG_COUNT 64
 #define MC34708_PMIC_TEST_VAL 0x125534
@@ -99,8 +99,7 @@ static int dm_test_power_pmic_mc34708_regs_check(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(dm_test_power_pmic_mc34708_regs_check, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_pmic_mc34708_regs_check, UTF_SCAN_FDT);
 
 static int dm_test_power_pmic_mc34708_rw_val(struct unit_test_state *uts)
 {
@@ -126,5 +125,4 @@ static int dm_test_power_pmic_mc34708_rw_val(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(dm_test_power_pmic_mc34708_rw_val, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_pmic_mc34708_rw_val, UTF_SCAN_FDT);
diff --git a/test/dm/power-domain.c b/test/dm/power-domain.c
index 120a9059c8e..896cf5b2ae9 100644
--- a/test/dm/power-domain.c
+++ b/test/dm/power-domain.c
@@ -45,4 +45,4 @@ static int dm_test_power_domain(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_domain, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_domain, UTF_SCAN_FDT);
diff --git a/test/dm/pwm.c b/test/dm/pwm.c
index 80133347ec7..5ccd8bc89b9 100644
--- a/test/dm/pwm.c
+++ b/test/dm/pwm.c
@@ -41,4 +41,4 @@ static int dm_test_pwm_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_pwm_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_pwm_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/qfw.c b/test/dm/qfw.c
index 3c354163ef3..a7dfe8f8daa 100644
--- a/test/dm/qfw.c
+++ b/test/dm/qfw.c
@@ -24,7 +24,7 @@ static int dm_test_qfw_cpus(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_qfw_cpus, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_qfw_cpus, UTF_SCAN_PDATA);
 
 static int dm_test_qfw_firmware_list(struct unit_test_state *uts)
 {
@@ -38,4 +38,4 @@ static int dm_test_qfw_firmware_list(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_qfw_firmware_list, UT_TESTF_SCAN_PDATA);
+DM_TEST(dm_test_qfw_firmware_list, UTF_SCAN_PDATA);
diff --git a/test/dm/ram.c b/test/dm/ram.c
index 188c7c32758..f3710b1f691 100644
--- a/test/dm/ram.c
+++ b/test/dm/ram.c
@@ -25,4 +25,4 @@ static int dm_test_ram_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ram_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ram_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/read.c b/test/dm/read.c
index 4ecf18110d0..0aa822195a8 100644
--- a/test/dm/read.c
+++ b/test/dm/read.c
@@ -45,4 +45,4 @@ static int dm_test_dma_ranges(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_dma_ranges, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_dma_ranges, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
index 160b4da07f2..c5949092c58 100644
--- a/test/dm/reboot-mode.c
+++ b/test/dm/reboot-mode.c
@@ -41,7 +41,7 @@ static int dm_test_reboot_mode_gpio(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_reboot_mode_gpio,
-	UT_TESTF_PROBE_TEST | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
 static int dm_test_reboot_mode_rtc(struct unit_test_state *uts)
 {
@@ -67,4 +67,4 @@ static int dm_test_reboot_mode_rtc(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_reboot_mode_rtc,
-	UT_TESTF_PROBE_TEST | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
diff --git a/test/dm/regmap.c b/test/dm/regmap.c
index 1398f8f6573..436b711b85d 100644
--- a/test/dm/regmap.c
+++ b/test/dm/regmap.c
@@ -69,7 +69,7 @@ static int dm_test_regmap_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_regmap_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_regmap_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test we can access a regmap through syscon */
 static int dm_test_regmap_syscon(struct unit_test_state *uts)
@@ -94,8 +94,7 @@ static int dm_test_regmap_syscon(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(dm_test_regmap_syscon, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_regmap_syscon, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Read/Write/Modify test */
 static int dm_test_regmap_rw(struct unit_test_state *uts)
@@ -128,8 +127,7 @@ static int dm_test_regmap_rw(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(dm_test_regmap_rw, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_regmap_rw, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Get/Set test */
 static int dm_test_regmap_getset(struct unit_test_state *uts)
@@ -160,7 +158,7 @@ static int dm_test_regmap_getset(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_regmap_getset, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_regmap_getset, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Read polling test */
 static int dm_test_regmap_poll(struct unit_test_state *uts)
@@ -187,8 +185,7 @@ static int dm_test_regmap_poll(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(dm_test_regmap_poll, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_regmap_poll, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 struct regmaptest_priv {
 	struct regmap *cfg_regmap; /* For testing regmap_config options. */
@@ -324,7 +321,7 @@ static int dm_test_devm_regmap(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_devm_regmap, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_devm_regmap, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int test_one_field(struct unit_test_state *uts,
 			  struct regmap *regmap,
@@ -383,4 +380,4 @@ static int dm_test_devm_regmap_field(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_devm_regmap_field, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_devm_regmap_field, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 9e45fd177b9..532bbd82376 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -89,7 +89,7 @@ static int dm_test_power_regulator_get(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_get, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_get, UTF_SCAN_FDT);
 
 /* Test regulator set and get Voltage method */
 static int dm_test_power_regulator_set_get_voltage(struct unit_test_state *uts)
@@ -116,7 +116,7 @@ static int dm_test_power_regulator_set_get_voltage(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_set_get_voltage, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_set_get_voltage, UTF_SCAN_FDT);
 
 /* Test regulator set and get Current method */
 static int dm_test_power_regulator_set_get_current(struct unit_test_state *uts)
@@ -155,7 +155,7 @@ static int dm_test_power_regulator_set_get_current(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_set_get_current, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_set_get_current, UTF_SCAN_FDT);
 
 /* Test regulator set and get Enable method */
 static int dm_test_power_regulator_set_get_enable(struct unit_test_state *uts)
@@ -174,7 +174,7 @@ static int dm_test_power_regulator_set_get_enable(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_set_get_enable, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_set_get_enable, UTF_SCAN_FDT);
 
 /* Test regulator set and get enable if allowed method */
 static
@@ -195,7 +195,7 @@ int dm_test_power_regulator_set_enable_if_allowed(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_set_enable_if_allowed, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_set_enable_if_allowed, UTF_SCAN_FDT);
 
 /* Test regulator set and get mode method */
 static int dm_test_power_regulator_set_get_mode(struct unit_test_state *uts)
@@ -214,7 +214,7 @@ static int dm_test_power_regulator_set_get_mode(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_set_get_mode, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_set_get_mode, UTF_SCAN_FDT);
 
 /* Test regulator set and get suspend Voltage method */
 static int dm_test_power_regulator_set_get_suspend_voltage(struct unit_test_state *uts)
@@ -244,7 +244,7 @@ static int dm_test_power_regulator_set_get_suspend_voltage(struct unit_test_stat
 	}
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_set_get_suspend_voltage, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_set_get_suspend_voltage, UTF_SCAN_FDT);
 
 /* Test regulator set and get suspend Enable method */
 static int dm_test_power_regulator_set_get_suspend_enable(struct unit_test_state *uts)
@@ -271,7 +271,7 @@ static int dm_test_power_regulator_set_get_suspend_enable(struct unit_test_state
 	}
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_set_get_suspend_enable, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_set_get_suspend_enable, UTF_SCAN_FDT);
 
 /* Test regulator autoset method */
 static int dm_test_power_regulator_autoset(struct unit_test_state *uts)
@@ -304,7 +304,7 @@ static int dm_test_power_regulator_autoset(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_autoset, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_autoset, UTF_SCAN_FDT);
 
 /*
  * Struct setting: to keep the expected output settings.
@@ -400,4 +400,4 @@ static int dm_test_power_regulator_autoset_list(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_power_regulator_autoset_list, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_power_regulator_autoset_list, UTF_SCAN_FDT);
diff --git a/test/dm/remoteproc.c b/test/dm/remoteproc.c
index 444c4dce083..921314ba930 100644
--- a/test/dm/remoteproc.c
+++ b/test/dm/remoteproc.c
@@ -68,7 +68,7 @@ static int dm_test_remoteproc_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_remoteproc_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_remoteproc_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 #define DEVICE_TO_PHYSICAL_OFFSET	0x1000
 /**
@@ -256,4 +256,4 @@ static int dm_test_remoteproc_elf(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_remoteproc_elf, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_remoteproc_elf, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/reset.c b/test/dm/reset.c
index d3158bf4a72..99f46fead6d 100644
--- a/test/dm/reset.c
+++ b/test/dm/reset.c
@@ -67,7 +67,7 @@ static int dm_test_reset_base(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_reset_base, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_reset_base, UTF_SCAN_FDT);
 
 static int dm_test_reset(struct unit_test_state *uts)
 {
@@ -94,7 +94,7 @@ static int dm_test_reset(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_reset, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_reset, UTF_SCAN_FDT);
 
 static int dm_test_reset_devm(struct unit_test_state *uts)
 {
@@ -119,7 +119,7 @@ static int dm_test_reset_devm(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_reset_devm, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_reset_devm, UTF_SCAN_FDT);
 
 static int dm_test_reset_bulk(struct unit_test_state *uts)
 {
@@ -149,7 +149,7 @@ static int dm_test_reset_bulk(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_reset_bulk, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_reset_bulk, UTF_SCAN_FDT);
 
 static int dm_test_reset_bulk_devm(struct unit_test_state *uts)
 {
@@ -181,4 +181,4 @@ static int dm_test_reset_bulk_devm(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_reset_bulk_devm, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_reset_bulk_devm, UTF_SCAN_FDT);
diff --git a/test/dm/rkmtd.c b/test/dm/rkmtd.c
index 3dc9ca1add1..e77c43b247a 100644
--- a/test/dm/rkmtd.c
+++ b/test/dm/rkmtd.c
@@ -85,7 +85,7 @@ static int dm_test_rkmtd(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rkmtd, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rkmtd, UTF_SCAN_FDT);
 
 /* Reusing the same label should work */
 static int dm_test_rkmtd_dup(struct unit_test_state *uts)
@@ -112,7 +112,7 @@ static int dm_test_rkmtd_dup(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rkmtd_dup, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rkmtd_dup, UTF_SCAN_FDT);
 
 /* Basic test of the 'rkmtd' command */
 static int dm_test_rkmtd_cmd(struct unit_test_state *uts)
@@ -196,4 +196,4 @@ static int dm_test_rkmtd_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rkmtd_cmd, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_rkmtd_cmd, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/dm/rng.c b/test/dm/rng.c
index c8ed6cadf58..d249e0218fe 100644
--- a/test/dm/rng.c
+++ b/test/dm/rng.c
@@ -23,7 +23,7 @@ static int dm_test_rng_read(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rng_read, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rng_read, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test the rng command */
 static int dm_test_rng_cmd(struct unit_test_state *uts)
@@ -52,4 +52,4 @@ static int dm_test_rng_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rng_cmd, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
+DM_TEST(dm_test_rng_cmd, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/dm/rtc.c b/test/dm/rtc.c
index a8aa41955c2..e52abbc49da 100644
--- a/test/dm/rtc.c
+++ b/test/dm/rtc.c
@@ -27,7 +27,7 @@ static int dm_test_rtc_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static void show_time(const char *msg, struct rtc_time *time)
 {
@@ -142,7 +142,7 @@ static int dm_test_rtc_set_get(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_set_get, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_set_get, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_rtc_read_write(struct unit_test_state *uts)
 {
@@ -186,7 +186,7 @@ static int dm_test_rtc_read_write(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_read_write, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_read_write, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test 'rtc list' command */
 static int dm_test_rtc_cmd_list(struct unit_test_state *uts)
@@ -200,7 +200,7 @@ static int dm_test_rtc_cmd_list(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_cmd_list, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_cmd_list, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test 'rtc read' and 'rtc write' commands */
 static int dm_test_rtc_cmd_rw(struct unit_test_state *uts)
@@ -243,7 +243,7 @@ static int dm_test_rtc_cmd_rw(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_cmd_rw, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_cmd_rw, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Reset the time */
 static int dm_test_rtc_reset(struct unit_test_state *uts)
@@ -280,7 +280,7 @@ static int dm_test_rtc_reset(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_reset, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_reset, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Check that two RTC devices can be used independently */
 static int dm_test_rtc_dual(struct unit_test_state *uts)
@@ -312,4 +312,4 @@ static int dm_test_rtc_dual(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_rtc_dual, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_rtc_dual, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index c9a03523184..93e275e0650 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -95,7 +95,7 @@ static int dm_test_scmi_sandbox_agent(struct unit_test_state *uts)
 
 	return ret;
 }
-DM_TEST(dm_test_scmi_sandbox_agent, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_scmi_sandbox_agent, UTF_SCAN_FDT);
 
 static int dm_test_scmi_base(struct unit_test_state *uts)
 {
@@ -203,7 +203,7 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_scmi_base, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_scmi_base, UTF_SCAN_FDT);
 
 static int dm_test_scmi_cmd(struct unit_test_state *uts)
 {
@@ -283,7 +283,7 @@ static int dm_test_scmi_cmd(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_scmi_cmd, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_scmi_cmd, UTF_SCAN_FDT);
 
 static int dm_test_scmi_power_domains(struct unit_test_state *uts)
 {
@@ -389,7 +389,7 @@ static int dm_test_scmi_power_domains(struct unit_test_state *uts)
 	return release_sandbox_scmi_test_devices(uts, dev);
 }
 
-DM_TEST(dm_test_scmi_power_domains, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_scmi_power_domains, UTF_SCAN_FDT);
 
 static int dm_test_scmi_clocks(struct unit_test_state *uts)
 {
@@ -458,7 +458,7 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
 
 	return release_sandbox_scmi_test_devices(uts, dev);
 }
-DM_TEST(dm_test_scmi_clocks, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_scmi_clocks, UTF_SCAN_FDT);
 
 static int dm_test_scmi_resets(struct unit_test_state *uts)
 {
@@ -496,7 +496,7 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
 
 	return release_sandbox_scmi_test_devices(uts, dev);
 }
-DM_TEST(dm_test_scmi_resets, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_scmi_resets, UTF_SCAN_FDT);
 
 static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
 {
@@ -551,4 +551,4 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
 
 	return release_sandbox_scmi_test_devices(uts, dev);
 }
-DM_TEST(dm_test_scmi_voltage_domains, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_scmi_voltage_domains, UTF_SCAN_FDT);
diff --git a/test/dm/scsi.c b/test/dm/scsi.c
index 5180159fb27..fbc36a74244 100644
--- a/test/dm/scsi.c
+++ b/test/dm/scsi.c
@@ -35,4 +35,4 @@ static int dm_test_scsi_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_scsi_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_scsi_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/serial.c b/test/dm/serial.c
index 34c0d4db879..456799a9eb8 100644
--- a/test/dm/serial.c
+++ b/test/dm/serial.c
@@ -88,4 +88,4 @@ static int dm_test_serial(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_serial, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_serial, UTF_SCAN_FDT);
diff --git a/test/dm/sf.c b/test/dm/sf.c
index 0e3a0f13f9e..3684d021709 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -72,7 +72,7 @@ static int dm_test_spi_flash(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_spi_flash, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_spi_flash, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Functional test that sandbox SPI flash works correctly */
 static int dm_test_spi_flash_func(struct unit_test_state *uts)
@@ -100,4 +100,4 @@ static int dm_test_spi_flash_func(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_spi_flash_func, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_spi_flash_func, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/simple-bus.c b/test/dm/simple-bus.c
index 8a730ba2fce..d9534830b16 100644
--- a/test/dm/simple-bus.c
+++ b/test/dm/simple-bus.c
@@ -29,4 +29,4 @@ static int dm_test_simple_bus(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_simple_bus, UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+DM_TEST(dm_test_simple_bus, UTF_SCAN_FDT | UTF_FLAT_TREE);
diff --git a/test/dm/simple-pm-bus.c b/test/dm/simple-pm-bus.c
index 9949cb34d59..8ae5e7754a9 100644
--- a/test/dm/simple-pm-bus.c
+++ b/test/dm/simple-pm-bus.c
@@ -41,4 +41,4 @@ static int dm_test_simple_pm_bus(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_simple_pm_bus, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_simple_pm_bus, UTF_SCAN_FDT);
diff --git a/test/dm/sm.c b/test/dm/sm.c
index 4d95c2ad75b..30985717fed 100644
--- a/test/dm/sm.c
+++ b/test/dm/sm.c
@@ -61,4 +61,4 @@ static int dm_test_sm(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_sm, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sm, UTF_SCAN_FDT);
diff --git a/test/dm/smem.c b/test/dm/smem.c
index adcbfe574ab..89e74cccc57 100644
--- a/test/dm/smem.c
+++ b/test/dm/smem.c
@@ -23,4 +23,4 @@ static int dm_test_smem_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_smem_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_smem_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/soc.c b/test/dm/soc.c
index cb0ac1545f7..c01b062970d 100644
--- a/test/dm/soc.c
+++ b/test/dm/soc.c
@@ -116,4 +116,4 @@ static int dm_test_soc(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_soc, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_soc, UTF_SCAN_FDT);
diff --git a/test/dm/sound.c b/test/dm/sound.c
index f4e6215e683..7b5556738dc 100644
--- a/test/dm/sound.c
+++ b/test/dm/sound.c
@@ -43,7 +43,7 @@ static int dm_test_sound(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_sound, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sound, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test of the 'start beep' operations */
 static int dm_test_sound_beep(struct unit_test_state *uts)
@@ -64,4 +64,4 @@ static int dm_test_sound_beep(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_sound_beep, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sound_beep, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/spi.c b/test/dm/spi.c
index 1ab2dd78324..249a9238fed 100644
--- a/test/dm/spi.c
+++ b/test/dm/spi.c
@@ -89,7 +89,7 @@ static int dm_test_spi_find(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_spi_find, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_spi_find, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* dm_test_spi_switch_slaves - Helper function to check whether spi_claim_bus
  *                             operates correctly with two spi slaves.
@@ -168,7 +168,7 @@ static int dm_test_spi_claim_bus(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_spi_claim_bus, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_spi_claim_bus, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that sandbox SPI works correctly */
 static int dm_test_spi_xfer(struct unit_test_state *uts)
@@ -199,4 +199,4 @@ static int dm_test_spi_xfer(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_spi_xfer, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_spi_xfer, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/spmi.c b/test/dm/spmi.c
index ee444f3b9b1..d706fc981ca 100644
--- a/test/dm/spmi.c
+++ b/test/dm/spmi.c
@@ -43,7 +43,7 @@ static int dm_test_spmi_probe(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_spmi_probe, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_spmi_probe, UTF_SCAN_FDT);
 
 /* Test if it's possible to read bus directly and indirectly */
 static int dm_test_spmi_access(struct unit_test_state *uts)
@@ -68,7 +68,7 @@ static int dm_test_spmi_access(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_spmi_access, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_spmi_access, UTF_SCAN_FDT);
 
 /* Test if it's possible to access GPIO that should be in pmic */
 static int dm_test_spmi_access_peripheral(struct unit_test_state *uts)
@@ -108,4 +108,4 @@ static int dm_test_spmi_access_peripheral(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_spmi_access_peripheral, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_spmi_access_peripheral, UTF_SCAN_FDT);
diff --git a/test/dm/syscon-reset.c b/test/dm/syscon-reset.c
index ba19504573f..5f51c1b96f1 100644
--- a/test/dm/syscon-reset.c
+++ b/test/dm/syscon-reset.c
@@ -55,4 +55,4 @@ static int dm_test_syscon_reset(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_syscon_reset, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_syscon_reset, UTF_SCAN_FDT);
diff --git a/test/dm/syscon.c b/test/dm/syscon.c
index 04d324e87d4..9855859721b 100644
--- a/test/dm/syscon.c
+++ b/test/dm/syscon.c
@@ -28,7 +28,7 @@ static int dm_test_syscon_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_syscon_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_syscon_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test system controller finding */
 static int dm_test_syscon_by_driver_data(struct unit_test_state *uts)
@@ -45,7 +45,7 @@ static int dm_test_syscon_by_driver_data(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_syscon_by_driver_data, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_syscon_by_driver_data, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test system controller by phandle */
 static int dm_test_syscon_by_phandle(struct unit_test_state *uts)
@@ -80,4 +80,4 @@ static int dm_test_syscon_by_phandle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_syscon_by_phandle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_syscon_by_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/sysinfo-gpio.c b/test/dm/sysinfo-gpio.c
index 24a99dafb15..155da3b6344 100644
--- a/test/dm/sysinfo-gpio.c
+++ b/test/dm/sysinfo-gpio.c
@@ -65,4 +65,4 @@ static int dm_test_sysinfo_gpio(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_sysinfo_gpio, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sysinfo_gpio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/sysinfo.c b/test/dm/sysinfo.c
index 7444a580df6..adb2f366d2c 100644
--- a/test/dm/sysinfo.c
+++ b/test/dm/sysinfo.c
@@ -60,4 +60,4 @@ static int dm_test_sysinfo(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_sysinfo, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sysinfo, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/sysreset.c b/test/dm/sysreset.c
index f3a859be787..8431aaa0a9e 100644
--- a/test/dm/sysreset.c
+++ b/test/dm/sysreset.c
@@ -45,7 +45,7 @@ static int dm_test_sysreset_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_sysreset_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sysreset_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_sysreset_get_status(struct unit_test_state *uts)
 {
@@ -64,7 +64,7 @@ static int dm_test_sysreset_get_status(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_sysreset_get_status, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sysreset_get_status, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can walk through the sysreset devices */
 static int dm_test_sysreset_walk(struct unit_test_state *uts)
@@ -95,7 +95,7 @@ static int dm_test_sysreset_walk(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_sysreset_walk, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sysreset_walk, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_sysreset_get_last(struct unit_test_state *uts)
 {
@@ -114,4 +114,4 @@ static int dm_test_sysreset_get_last(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_sysreset_get_last, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_sysreset_get_last, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/tee.c b/test/dm/tee.c
index bb02a9b3c98..fb890c1bdd4 100644
--- a/test/dm/tee.c
+++ b/test/dm/tee.c
@@ -216,4 +216,4 @@ out:
 	return rc;
 }
 
-DM_TEST(dm_test_tee, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_tee, UTF_SCAN_FDT);
diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
index 31effff59c2..d9c49312f5e 100644
--- a/test/dm/test-fdt.c
+++ b/test/dm/test-fdt.c
@@ -296,7 +296,7 @@ static int dm_test_fdt_uclass_seq(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fdt_uclass_seq, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fdt_uclass_seq, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* More tests for sequence numbers */
 static int dm_test_fdt_uclass_seq_manual(struct unit_test_state *uts)
@@ -321,7 +321,7 @@ static int dm_test_fdt_uclass_seq_manual(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fdt_uclass_seq_manual, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fdt_uclass_seq_manual, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_fdt_uclass_seq_more(struct unit_test_state *uts)
 {
@@ -360,7 +360,7 @@ static int dm_test_fdt_uclass_seq_more(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fdt_uclass_seq_more, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fdt_uclass_seq_more, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can find a device by device tree offset */
 static int dm_test_fdt_offset(struct unit_test_state *uts)
@@ -390,7 +390,7 @@ static int dm_test_fdt_offset(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_offset,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
 /**
  * Test various error conditions with uclass_first_device(),
@@ -455,7 +455,7 @@ static int dm_test_first_next_device_probeall(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_first_next_device_probeall,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test iteration through devices in a uclass */
 static int dm_test_uclass_foreach(struct unit_test_state *uts)
@@ -476,7 +476,7 @@ static int dm_test_uclass_foreach(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_uclass_foreach, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_uclass_foreach, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /**
  * check_devices() - Check return values and pointers
@@ -556,7 +556,7 @@ static int dm_test_first_next_ok_device(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_first_next_ok_device, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_first_next_ok_device, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static const struct udevice_id fdt_dummy_ids[] = {
 	{ .compatible = "denx,u-boot-fdt-dummy", },
@@ -611,7 +611,7 @@ static int dm_test_fdt_translation(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fdt_translation, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fdt_translation, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_fdt_get_addr_ptr_flat(struct unit_test_state *uts)
 {
@@ -632,7 +632,7 @@ static int dm_test_fdt_get_addr_ptr_flat(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_get_addr_ptr_flat,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
 static int dm_test_fdt_remap_addr_flat(struct unit_test_state *uts)
 {
@@ -652,7 +652,7 @@ static int dm_test_fdt_remap_addr_flat(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_remap_addr_flat,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
 static int dm_test_fdt_remap_addr_index_flat(struct unit_test_state *uts)
 {
@@ -674,7 +674,7 @@ static int dm_test_fdt_remap_addr_index_flat(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_remap_addr_index_flat,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
 static int dm_test_fdt_remap_addr_name_flat(struct unit_test_state *uts)
 {
@@ -696,7 +696,7 @@ static int dm_test_fdt_remap_addr_name_flat(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_remap_addr_name_flat,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT | UT_TESTF_FLAT_TREE);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
 static int dm_test_fdt_remap_addr_live(struct unit_test_state *uts)
 {
@@ -716,7 +716,7 @@ static int dm_test_fdt_remap_addr_live(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_remap_addr_live,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_fdt_remap_addr_index_live(struct unit_test_state *uts)
 {
@@ -738,7 +738,7 @@ static int dm_test_fdt_remap_addr_index_live(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_remap_addr_index_live,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_fdt_remap_addr_name_live(struct unit_test_state *uts)
 {
@@ -760,7 +760,7 @@ static int dm_test_fdt_remap_addr_name_live(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_remap_addr_name_live,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_fdt_disable_enable_by_path(struct unit_test_state *uts)
 {
@@ -787,8 +787,7 @@ static int dm_test_fdt_disable_enable_by_path(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fdt_disable_enable_by_path, UT_TESTF_SCAN_PDATA |
-					    UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fdt_disable_enable_by_path, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test a few uclass phandle functions */
 static int dm_test_fdt_phandle(struct unit_test_state *uts)
@@ -810,7 +809,7 @@ static int dm_test_fdt_phandle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_fdt_phandle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_fdt_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test device_find_first_child_by_uclass() */
 static int dm_test_first_child(struct unit_test_state *uts)
@@ -837,7 +836,7 @@ static int dm_test_first_child(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_first_child, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_first_child, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test integer functions in dm_read_...() */
 static int dm_test_read_int(struct unit_test_state *uts)
@@ -901,7 +900,7 @@ static int dm_test_read_int(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_read_int, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_read_int, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_read_int_index(struct unit_test_state *uts)
 {
@@ -930,7 +929,7 @@ static int dm_test_read_int_index(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_read_int_index, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_read_int_index, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_read_phandle(struct unit_test_state *uts)
 {
@@ -995,7 +994,7 @@ static int dm_test_read_phandle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_read_phandle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_read_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test iteration through devices by drvdata */
 static int dm_test_uclass_drvdata(struct unit_test_state *uts)
@@ -1016,7 +1015,7 @@ static int dm_test_uclass_drvdata(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_uclass_drvdata, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_uclass_drvdata, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test device_first_child_ofdata_err(), etc. */
 static int dm_test_child_ofdata(struct unit_test_state *uts)
@@ -1035,7 +1034,7 @@ static int dm_test_child_ofdata(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_child_ofdata, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_child_ofdata, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test device_first_child_err(), etc. */
 static int dm_test_first_child_probe(struct unit_test_state *uts)
@@ -1054,7 +1053,7 @@ static int dm_test_first_child_probe(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_first_child_probe, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_first_child_probe, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that ofdata is read for parents before children */
 static int dm_test_ofdata_order(struct unit_test_state *uts)
@@ -1079,7 +1078,7 @@ static int dm_test_ofdata_order(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofdata_order, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofdata_order, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test dev_decode_display_timing() */
 static int dm_test_decode_display_timing(struct unit_test_state *uts)
@@ -1159,7 +1158,7 @@ static int dm_test_decode_display_timing(struct unit_test_state *uts)
 	ut_assert(dev_decode_display_timing(dev, 3, &timing));
 	return 0;
 }
-DM_TEST(dm_test_decode_display_timing, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_decode_display_timing, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test dev_decode_panel_timing() */
 static int dm_test_decode_panel_timing(struct unit_test_state *uts)
@@ -1194,7 +1193,7 @@ static int dm_test_decode_panel_timing(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_decode_panel_timing, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_decode_panel_timing, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test read_resourcee() */
 static int dm_test_read_resource(struct unit_test_state *uts)
@@ -1226,4 +1225,4 @@ static int dm_test_read_resource(struct unit_test_state *uts)
 	return 0;
 }
 
-DM_TEST(dm_test_read_resource, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_read_resource, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/timer.c b/test/dm/timer.c
index 7fcefc42e59..a32059d560d 100644
--- a/test/dm/timer.c
+++ b/test/dm/timer.c
@@ -23,7 +23,7 @@ static int dm_test_timer_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_timer_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_timer_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /*
  * Test of timebase fallback
@@ -46,4 +46,4 @@ static int dm_test_timer_timebase_fallback(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_timer_timebase_fallback,
-	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+	UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/tpm.c b/test/dm/tpm.c
index 0e413c0eedd..962a3fd1943 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -56,7 +56,7 @@ static int dm_test_tpm(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_tpm, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_tpm, UTF_SCAN_FDT);
 
 /* Test report_state */
 static int dm_test_tpm_report_state(struct unit_test_state *uts)
@@ -77,7 +77,7 @@ static int dm_test_tpm_report_state(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_tpm_report_state, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_tpm_report_state, UTF_SCAN_FDT);
 
 /**
  * test_tpm_autostart() - check the tpm_auto_start() call
@@ -114,7 +114,7 @@ static int dm_test_tpm_autostart(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_tpm_autostart, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_tpm_autostart, UTF_SCAN_FDT);
 
 static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
 {
@@ -123,4 +123,4 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_tpm_autostart_reinit, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_tpm_autostart_reinit, UTF_SCAN_FDT);
diff --git a/test/dm/usb.c b/test/dm/usb.c
index 0bbea219ec9..fa894c1096e 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -33,7 +33,7 @@ static int dm_test_usb_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_usb_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_usb_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /*
  * Test that we can use the flash stick. This is more of a functional test. It
@@ -82,7 +82,7 @@ static int dm_test_usb_flash(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_usb_flash, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_usb_flash, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test that we can handle multiple storage devices */
 static int dm_test_usb_multi(struct unit_test_state *uts)
@@ -98,7 +98,7 @@ static int dm_test_usb_multi(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_usb_multi, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_usb_multi, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* test that we have an associated ofnode with the usb device */
 static int dm_test_usb_fdt_node(struct unit_test_state *uts)
@@ -120,7 +120,7 @@ static int dm_test_usb_fdt_node(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_usb_fdt_node, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_usb_fdt_node, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int count_usb_devices(void)
 {
@@ -164,7 +164,7 @@ static int dm_test_usb_stop(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_usb_stop, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_usb_stop, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /**
  * dm_test_usb_keyb() - test USB keyboard driver
@@ -455,4 +455,4 @@ static int dm_test_usb_keyb(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_usb_keyb, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_usb_keyb, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/video.c b/test/dm/video.c
index 7dfbeb9555d..e347c1403fd 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -42,7 +42,7 @@ static int dm_test_video_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /**
  * compress_frame_buffer() - Compress the frame buffer and return its size
@@ -175,7 +175,7 @@ static int dm_test_video_text(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_text, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_text, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_video_text_12x22(struct unit_test_state *uts)
 {
@@ -211,7 +211,7 @@ static int dm_test_video_text_12x22(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_text_12x22, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_text_12x22, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test handling of special characters in the console */
 static int dm_test_video_chars(struct unit_test_state *uts)
@@ -228,7 +228,7 @@ static int dm_test_video_chars(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_chars, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_chars, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 #ifdef CONFIG_VIDEO_ANSI
 #define ANSI_ESC "\x1b"
@@ -262,7 +262,7 @@ static int dm_test_video_ansi(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_ansi, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_ansi, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #endif
 
 /**
@@ -320,7 +320,7 @@ static int dm_test_video_context(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_context, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_context, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test rotated text output through the console uclass */
 static int dm_test_video_rotation1(struct unit_test_state *uts)
@@ -329,7 +329,7 @@ static int dm_test_video_rotation1(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_rotation1, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_rotation1, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test rotated text output through the console uclass */
 static int dm_test_video_rotation2(struct unit_test_state *uts)
@@ -338,7 +338,7 @@ static int dm_test_video_rotation2(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_rotation2, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_rotation2, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test rotated text output through the console uclass */
 static int dm_test_video_rotation3(struct unit_test_state *uts)
@@ -347,7 +347,7 @@ static int dm_test_video_rotation3(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_rotation3, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_rotation3, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Read a file into memory and return a pointer to it */
 static int read_file(struct unit_test_state *uts, const char *fname,
@@ -385,7 +385,7 @@ static int dm_test_video_bmp(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_bmp, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_bmp, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test drawing a bitmap file on a 8bpp display */
 static int dm_test_video_bmp8(struct unit_test_state *uts)
@@ -404,7 +404,7 @@ static int dm_test_video_bmp8(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_bmp8, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_bmp8, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test drawing a bitmap file on a 16bpp display */
 static int dm_test_video_bmp16(struct unit_test_state *uts)
@@ -427,7 +427,7 @@ static int dm_test_video_bmp16(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_bmp16, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_bmp16, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test drawing a 24bpp bitmap file on a 16bpp display */
 static int dm_test_video_bmp24(struct unit_test_state *uts)
@@ -450,7 +450,7 @@ static int dm_test_video_bmp24(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_bmp24, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_bmp24, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test drawing a 24bpp bitmap file on a 32bpp display */
 static int dm_test_video_bmp24_32(struct unit_test_state *uts)
@@ -473,7 +473,7 @@ static int dm_test_video_bmp24_32(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_bmp24_32, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_bmp24_32, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test drawing a bitmap file on a 32bpp display */
 static int dm_test_video_bmp32(struct unit_test_state *uts)
@@ -491,7 +491,7 @@ static int dm_test_video_bmp32(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_bmp32, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_bmp32, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test drawing a compressed bitmap file */
 static int dm_test_video_bmp_comp(struct unit_test_state *uts)
@@ -507,7 +507,7 @@ static int dm_test_video_bmp_comp(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_bmp_comp, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_bmp_comp, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test drawing a bitmap file on a 32bpp display */
 static int dm_test_video_comp_bmp32(struct unit_test_state *uts)
@@ -526,7 +526,7 @@ static int dm_test_video_comp_bmp32(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_comp_bmp32, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_comp_bmp32, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test drawing a bitmap file on a 8bpp display */
 static int dm_test_video_comp_bmp8(struct unit_test_state *uts)
@@ -545,7 +545,7 @@ static int dm_test_video_comp_bmp8(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_comp_bmp8, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_comp_bmp8, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test TrueType console */
 static int dm_test_video_truetype(struct unit_test_state *uts)
@@ -560,7 +560,7 @@ static int dm_test_video_truetype(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_truetype, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_truetype, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test scrolling TrueType console */
 static int dm_test_video_truetype_scroll(struct unit_test_state *uts)
@@ -581,7 +581,7 @@ static int dm_test_video_truetype_scroll(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_truetype_scroll, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_truetype_scroll, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test TrueType backspace, within and across lines */
 static int dm_test_video_truetype_bs(struct unit_test_state *uts)
@@ -602,4 +602,4 @@ static int dm_test_video_truetype_bs(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_video_truetype_bs, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_video_truetype_bs, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/virtio.c b/test/dm/virtio.c
index 3efd7c74f42..2574c4da624 100644
--- a/test/dm/virtio.c
+++ b/test/dm/virtio.c
@@ -29,4 +29,4 @@ static int dm_test_virtio_missing_ops(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_virtio_missing_ops, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_virtio_missing_ops, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/virtio_device.c b/test/dm/virtio_device.c
index 63dc53415b7..53414e4d3a4 100644
--- a/test/dm/virtio_device.c
+++ b/test/dm/virtio_device.c
@@ -44,7 +44,7 @@ static int dm_test_virtio_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_virtio_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_virtio_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test all of the virtio uclass ops */
 static int dm_test_virtio_all_ops(struct unit_test_state *uts)
@@ -93,7 +93,7 @@ static int dm_test_virtio_all_ops(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_virtio_all_ops, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_virtio_all_ops, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test removal of virtio device driver */
 static int dm_test_virtio_remove(struct unit_test_state *uts)
@@ -122,7 +122,7 @@ static int dm_test_virtio_remove(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_virtio_remove, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_virtio_remove, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test all of the virtio ring */
 static int dm_test_virtio_ring(struct unit_test_state *uts)
@@ -194,4 +194,4 @@ static int dm_test_virtio_ring(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_virtio_ring, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_virtio_ring, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/virtio_rng.c b/test/dm/virtio_rng.c
index ab7d862d79e..e404b08484e 100644
--- a/test/dm/virtio_rng.c
+++ b/test/dm/virtio_rng.c
@@ -48,4 +48,4 @@ static int dm_test_virtio_rng_check_len(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_virtio_rng_check_len, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_virtio_rng_check_len, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index 1df2da23c6c..541bcba1b53 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -43,7 +43,7 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_wdt_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_wdt_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 {
@@ -75,7 +75,7 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_wdt_gpio_toggle, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_wdt_gpio_toggle, UTF_SCAN_FDT);
 
 static int dm_test_wdt_gpio_level(struct unit_test_state *uts)
 {
@@ -107,7 +107,7 @@ static int dm_test_wdt_gpio_level(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_wdt_gpio_level, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_wdt_gpio_level, UTF_SCAN_FDT);
 
 static int dm_test_wdt_watchdog_reset(struct unit_test_state *uts)
 {
@@ -159,4 +159,4 @@ static int dm_test_wdt_watchdog_reset(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_wdt_watchdog_reset, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_wdt_watchdog_reset, UTF_SCAN_FDT);
diff --git a/test/log/log_filter.c b/test/log/log_filter.c
index 9cc891dc48c..149eef05426 100644
--- a/test/log/log_filter.c
+++ b/test/log/log_filter.c
@@ -24,7 +24,7 @@ static int log_test_filter_invalid(struct unit_test_state *uts)
 
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_filter_invalid, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_filter_invalid, UTF_CONSOLE_REC);
 
 /* Test adding and removing filters */
 static int log_test_filter(struct unit_test_state *uts)
@@ -105,4 +105,4 @@ static int log_test_filter(struct unit_test_state *uts)
 
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_filter, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_filter, UTF_CONSOLE_REC);
diff --git a/test/log/log_test.c b/test/log/log_test.c
index 855353a9c40..d2c062e1323 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -121,7 +121,7 @@ int log_test_cat_allow(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_cat_allow, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_cat_allow, UTF_CONSOLE_REC);
 
 /* Check a category filter that should block log entries */
 int log_test_cat_deny_implicit(struct unit_test_state *uts)
@@ -141,7 +141,7 @@ int log_test_cat_deny_implicit(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_cat_deny_implicit, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_cat_deny_implicit, UTF_CONSOLE_REC);
 
 /* Check passing and failing file filters */
 int log_test_file(struct unit_test_state *uts)
@@ -162,7 +162,7 @@ int log_test_file(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_file, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_file, UTF_CONSOLE_REC);
 
 /* Check a passing file filter (second in list) */
 int log_test_file_second(struct unit_test_state *uts)
@@ -179,7 +179,7 @@ int log_test_file_second(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_file_second, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_file_second, UTF_CONSOLE_REC);
 
 /* Check a passing file filter (middle of list) */
 int log_test_file_mid(struct unit_test_state *uts)
@@ -197,7 +197,7 @@ int log_test_file_mid(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_file_mid, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_file_mid, UTF_CONSOLE_REC);
 
 /* Check a log level filter */
 int log_test_level(struct unit_test_state *uts)
@@ -215,7 +215,7 @@ int log_test_level(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_level, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_level, UTF_CONSOLE_REC);
 
 /* Check two filters, one of which passes everything */
 int log_test_double(struct unit_test_state *uts)
@@ -235,7 +235,7 @@ int log_test_double(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt2));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_double, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_double, UTF_CONSOLE_REC);
 
 /* Check three filters, which together pass everything */
 int log_test_triple(struct unit_test_state *uts)
@@ -258,7 +258,7 @@ int log_test_triple(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt3));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_triple, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_triple, UTF_CONSOLE_REC);
 
 int do_log_test_helpers(struct unit_test_state *uts)
 {
@@ -292,7 +292,7 @@ int log_test_helpers(struct unit_test_state *uts)
 	gd->log_fmt = log_get_default_format();
 	return ret;
 }
-LOG_TEST_FLAGS(log_test_helpers, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_helpers, UTF_CONSOLE_REC);
 
 int do_log_test_disable(struct unit_test_state *uts)
 {
@@ -319,7 +319,7 @@ int log_test_disable(struct unit_test_state *uts)
 	gd->log_fmt = log_get_default_format();
 	return ret;
 }
-LOG_TEST_FLAGS(log_test_disable, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_disable, UTF_CONSOLE_REC);
 
 /* Check denying based on category */
 int log_test_cat_deny(struct unit_test_state *uts)
@@ -343,7 +343,7 @@ int log_test_cat_deny(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt2));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_cat_deny, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_cat_deny, UTF_CONSOLE_REC);
 
 /* Check denying based on file */
 int log_test_file_deny(struct unit_test_state *uts)
@@ -364,7 +364,7 @@ int log_test_file_deny(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt2));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_file_deny, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_file_deny, UTF_CONSOLE_REC);
 
 /* Check denying based on level */
 int log_test_level_deny(struct unit_test_state *uts)
@@ -387,7 +387,7 @@ int log_test_level_deny(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt2));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_level_deny, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_level_deny, UTF_CONSOLE_REC);
 
 /* Check matching based on minimum level */
 int log_test_min(struct unit_test_state *uts)
@@ -410,7 +410,7 @@ int log_test_min(struct unit_test_state *uts)
 	ut_assertok(log_remove_filter("console", filt2));
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_min, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_min, UTF_CONSOLE_REC);
 
 /* Check dropped traces */
 int log_test_dropped(struct unit_test_state *uts)
@@ -432,7 +432,7 @@ int log_test_dropped(struct unit_test_state *uts)
 
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_dropped, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_dropped, UTF_CONSOLE_REC);
 
 /* Check log_buffer() */
 int log_test_buffer(struct unit_test_state *uts)
@@ -459,4 +459,4 @@ int log_test_buffer(struct unit_test_state *uts)
 
 	return 0;
 }
-LOG_TEST_FLAGS(log_test_buffer, UT_TESTF_CONSOLE_REC);
+LOG_TEST_FLAGS(log_test_buffer, UTF_CONSOLE_REC);
diff --git a/test/print_ut.c b/test/print_ut.c
index 53d3354ea69..eef85d16218 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -246,7 +246,7 @@ static int print_display_buffer(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_display_buffer, UT_TESTF_CONSOLE_REC);
+PRINT_TEST(print_display_buffer, UTF_CONSOLE_REC);
 
 static int print_hexdump_line(struct unit_test_state *uts)
 {
@@ -272,7 +272,7 @@ static int print_hexdump_line(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_hexdump_line, UT_TESTF_CONSOLE_REC);
+PRINT_TEST(print_hexdump_line, UTF_CONSOLE_REC);
 
 static int print_do_hex_dump(struct unit_test_state *uts)
 {
@@ -365,7 +365,7 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 
 	return 0;
 }
-PRINT_TEST(print_do_hex_dump, UT_TESTF_CONSOLE_REC);
+PRINT_TEST(print_do_hex_dump, UTF_CONSOLE_REC);
 
 static int snprint(struct unit_test_state *uts)
 {
diff --git a/test/test-main.c b/test/test-main.c
index 3fa6f6e32ec..2ee703ef5a8 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -181,7 +181,7 @@ static bool ut_test_run_on_flattree(struct unit_test *test)
 {
 	const char *fname = strrchr(test->file, '/') + 1;
 
-	if (!(test->flags & UT_TESTF_DM))
+	if (!(test->flags & UTF_DM))
 		return false;
 
 	return !strstr(fname, "video") || strstr(test->name, "video_base");
@@ -240,14 +240,14 @@ static bool test_matches(const char *prefix, const char *test_name,
  *
  * @tests: List of tests to run
  * @count: Number of tests to ru
- * Return: true if any of the tests have the UT_TESTF_DM flag
+ * Return: true if any of the tests have the UTF_DM flag
  */
 static bool ut_list_has_dm_tests(struct unit_test *tests, int count)
 {
 	struct unit_test *test;
 
 	for (test = tests; test < tests + count; test++) {
-		if (test->flags & UT_TESTF_DM)
+		if (test->flags & UTF_DM)
 			return true;
 	}
 
@@ -289,26 +289,26 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 {
 	ut_assertok(event_init());
 
-	if (test->flags & UT_TESTF_DM)
+	if (test->flags & UTF_DM)
 		ut_assertok(dm_test_pre_run(uts));
 
 	ut_set_skip_delays(uts, false);
 
 	uts->start = mallinfo();
 
-	if (test->flags & UT_TESTF_SCAN_PDATA)
+	if (test->flags & UTF_SCAN_PDATA)
 		ut_assertok(dm_scan_plat(false));
 
-	if (test->flags & UT_TESTF_PROBE_TEST)
+	if (test->flags & UTF_PROBE_TEST)
 		ut_assertok(do_autoprobe(uts));
 
 	if (CONFIG_IS_ENABLED(OF_REAL) &&
-	    (test->flags & UT_TESTF_SCAN_FDT)) {
+	    (test->flags & UTF_SCAN_FDT)) {
 		/*
 		 * only set this if we know the ethernet uclass will be created
 		 */
-		eth_set_enable_bootdevs(test->flags & UT_TESTF_ETH_BOOTDEV);
-		test_sf_set_enable_bootdevs(test->flags & UT_TESTF_SF_BOOTDEV);
+		eth_set_enable_bootdevs(test->flags & UTF_ETH_BOOTDEV);
+		test_sf_set_enable_bootdevs(test->flags & UTF_SF_BOOTDEV);
 		ut_assertok(dm_extended_scan(false));
 	}
 
@@ -316,10 +316,10 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 	 * Do this after FDT scan since dm_scan_other() in bootstd-uclass.c
 	 * checks for the existence of bootstd
 	 */
-	if (test->flags & UT_TESTF_SCAN_PDATA)
+	if (test->flags & UTF_SCAN_PDATA)
 		ut_assertok(dm_scan_other(false));
 
-	if (IS_ENABLED(CONFIG_SANDBOX) && (test->flags & UT_TESTF_OTHER_FDT)) {
+	if (IS_ENABLED(CONFIG_SANDBOX) && (test->flags & UTF_OTHER_FDT)) {
 		/* make sure the other FDT is available */
 		ut_assertok(test_load_other_fdt(uts));
 
@@ -333,7 +333,7 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 		}
 	}
 
-	if (test->flags & UT_TESTF_CONSOLE_REC) {
+	if (test->flags & UTF_CONSOLE_REC) {
 		int ret = console_record_reset_enable();
 
 		if (ret) {
@@ -356,7 +356,7 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 static int test_post_run(struct unit_test_state *uts, struct unit_test *test)
 {
 	ut_unsilence_console(uts);
-	if (test->flags & UT_TESTF_DM)
+	if (test->flags & UTF_DM)
 		ut_assertok(dm_test_post_run(uts));
 	ut_assertok(cyclic_unregister_all());
 	ut_assertok(event_uninit());
@@ -403,7 +403,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
 	const char *note = "";
 	int ret;
 
-	if ((test->flags & UT_TESTF_DM) && !uts->of_live)
+	if ((test->flags & UTF_DM) && !uts->of_live)
 		note = " (flat tree)";
 	printf("Test: %s: %s%s\n", test_name, fname, note);
 
@@ -450,13 +450,13 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 {
 	int runs;
 
-	if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
+	if ((test->flags & UTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
 		return skip_test(uts);
 
 	/* Run with the live tree if possible */
 	runs = 0;
 	if (CONFIG_IS_ENABLED(OF_LIVE)) {
-		if (!(test->flags & UT_TESTF_FLAT_TREE)) {
+		if (!(test->flags & UTF_FLAT_TREE)) {
 			uts->of_live = true;
 			ut_assertok(ut_run_test(uts, test, test->name));
 			runs++;
@@ -476,10 +476,10 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	 *    boards)
 	 */
 	if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
-	     (test->flags & UT_TESTF_SCAN_FDT)) &&
-	    !(test->flags & UT_TESTF_LIVE_TREE) &&
+	     (test->flags & UTF_SCAN_FDT)) &&
+	    !(test->flags & UTF_LIVE_TREE) &&
 	    (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
-	     !(test->flags & UT_TESTF_OTHER_FDT)) &&
+	     !(test->flags & UTF_OTHER_FDT)) &&
 	    (!runs || ut_test_run_on_flattree(test)) &&
 	    !(gd->flags & GD_FLG_FDT_CHANGED)) {
 		uts->of_live = false;
@@ -540,7 +540,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		if (!test_matches(prefix, test_name, select_name))
 			continue;
 
-		if (test->flags & UT_TESTF_MANUAL) {
+		if (test->flags & UTF_MANUAL) {
 			int len;
 
 			/*
-- 
2.34.1

