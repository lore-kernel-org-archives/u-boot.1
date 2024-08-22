Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8DBC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE7288969;
	Thu, 22 Aug 2024 15:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="exyiASd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA970889C1; Thu, 22 Aug 2024 15:58:22 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B658B88915
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-81f8f01981aso32539339f.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335098; x=1724939898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFHcNHGA+JhvHk848mhhs4S/DJ+ylS7B84GQNSS2oKw=;
 b=exyiASd2kNHdACdflutGSflIJlKbgO9xRdPg/MZsYRNTxPjzzNZ4kp/LT5fUkU1zn6
 ijgO14jCWB6o09pAr3pXv6RqYqGk/oAz9r2uZ+DIN68GjZRFH+9EXUdU/ZTXTfucz0VI
 g4vef2VKE4KEg878eZvt7tgElrTRhCqWMgrhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335098; x=1724939898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFHcNHGA+JhvHk848mhhs4S/DJ+ylS7B84GQNSS2oKw=;
 b=O4AbY/3jL8HeRndbo5IpBvCkzYkfIqS9MVkPtoZAJcsQFcov1MBdeDTHpiubL0rJKS
 daykFN4YOsvNMC41bup6dmXhrZceI3v1emaXoBczPBJBL61hMiyQU8RY7p95tqVtAXQz
 8kjNhDAyusUVRG/Kg8Aoo3Vxf6/KQ3OT9v8RWDXqrx4hfQOQP6jMB4l0tqA1AlmF2NyU
 2h43ovFU6dlUMoaHF02j6ugwvIYFbiW80mm8oy80MDp/wqtgiLo/YK0sWQcdy+gdPKPl
 EvVgKdnCE7GrNZkR1LfT7J6Um2a18034gx4sJcToyFpTQZq2k8L4uo4snVznXeDsn2vT
 qKKg==
X-Gm-Message-State: AOJu0Yz9P5RaP65bMpWhTdS7S6A9l0OwiuYfVZOczzKyH9Kb8OkyhhW1
 u9vPrxQzj6zwXHxRn/NcRrBcrXi0iGI9ASCUx0F9NOVBS110nMwAFjATK77xBEHfiXlRXnQVySY
 =
X-Google-Smtp-Source: AGHT+IGdq049z3mr7TXOu9KAqrMoV2z7/mPIk3m4fAvGYJpBXHGTElO6oA6VHXJ6/Fn/GoOC9m7DRA==
X-Received: by 2002:a92:c54f:0:b0:398:f487:5a04 with SMTP id
 e9e14a558f8ab-39d74c6c4bcmr23685195ab.11.1724335097816; 
 Thu, 22 Aug 2024 06:58:17 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 04/19] test: Drop the blank line before test macros
Date: Thu, 22 Aug 2024 07:57:49 -0600
Message-Id: <20240822135804.2375959-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

Most tests don't have this. It helps to keep the test declaration
clearly associated with the function it relates to, rather than the next
one in the file. Remove the extra blank line and mention this in the
docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/develop/tests_writing.rst | 3 +++
 test/cmd/armffa.c             | 1 -
 test/cmd/bdinfo.c             | 4 ----
 test/cmd/exit.c               | 1 -
 test/cmd/mbr.c                | 1 -
 test/cmd/pci_mps.c            | 1 -
 test/cmd/pinmux.c             | 1 -
 test/cmd/pwm.c                | 1 -
 test/cmd/rw.c                 | 1 -
 test/cmd/setexpr.c            | 1 -
 test/cmd/temperature.c        | 1 -
 test/cmd/test_echo.c          | 1 -
 test/cmd/wget.c               | 1 -
 test/common/test_autoboot.c   | 1 -
 test/dm/axi.c                 | 3 ---
 test/dm/bootcount.c           | 6 +-----
 test/dm/clk.c                 | 1 -
 test/dm/clk_ccf.c             | 1 -
 test/dm/core.c                | 1 -
 test/dm/cpu.c                 | 1 -
 test/dm/dsa.c                 | 2 --
 test/dm/dsi_host.c            | 1 -
 test/dm/eth.c                 | 4 ----
 test/dm/extcon.c              | 1 -
 test/dm/ffa.c                 | 2 --
 test/dm/fpga.c                | 1 -
 test/dm/hwspinlock.c          | 1 -
 test/dm/i2c.c                 | 1 -
 test/dm/mdio.c                | 1 -
 test/dm/mdio_mux.c            | 1 -
 test/dm/memory.c              | 1 -
 test/dm/misc.c                | 1 -
 test/dm/nop.c                 | 1 -
 test/dm/nvmxip.c              | 1 -
 test/dm/osd.c                 | 2 --
 test/dm/pci_ep.c              | 1 -
 test/dm/pmic.c                | 1 -
 test/dm/qfw.c                 | 2 --
 test/dm/reboot-mode.c         | 2 --
 test/dm/regmap.c              | 1 -
 test/dm/reset.c               | 1 -
 test/dm/scmi.c                | 3 ---
 test/dm/serial.c              | 1 -
 test/dm/sm.c                  | 1 -
 test/dm/soc.c                 | 1 -
 test/dm/sysinfo.c             | 1 -
 test/dm/tag.c                 | 4 ----
 test/dm/tee.c                 | 1 -
 test/dm/test-fdt.c            | 1 -
 test/env/hashtable.c          | 2 --
 test/lib/asn1.c               | 3 ---
 test/lib/efi_device_path.c    | 1 -
 test/lib/efi_image_region.c   | 2 --
 test/lib/hexdump.c            | 3 ---
 test/lib/lmb.c                | 1 -
 test/lib/rsa.c                | 2 --
 test/lib/sscanf.c             | 1 -
 test/lib/string.c             | 3 ---
 test/lib/test_aes.c           | 1 -
 test/lib/test_crc8.c          | 1 -
 test/lib/test_crypt.c         | 1 -
 test/lib/test_errno_str.c     | 1 -
 test/lib/test_print.c         | 2 --
 test/lib/uuid.c               | 1 -
 64 files changed, 4 insertions(+), 95 deletions(-)

diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 655eb95110d..c277c8dd44f 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -228,6 +228,9 @@ Declare the test with::
    }
    DM_TEST(dm_test_uclassname_what, UTF_SCAN_FDT);
 
+Note that the convention is to NOT add a blank line before the macro, so that
+the function it relates to is more obvious.
+
 Replace 'uclassname' with the name of your uclass, if applicable. Replace 'what'
 with what you are testing.
 
diff --git a/test/cmd/armffa.c b/test/cmd/armffa.c
index f5d5a1b54a3..d7b076cfe7c 100644
--- a/test/cmd/armffa.c
+++ b/test/cmd/armffa.c
@@ -28,5 +28,4 @@ static int dm_test_armffa_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_armffa_cmd, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 973544f63f6..cb88d2ee11b 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -244,7 +244,6 @@ static int bdinfo_test_full(struct unit_test_state *uts)
 
 	return 0;
 }
-
 BDINFO_TEST(bdinfo_test_full, UTF_CONSOLE_REC);
 
 static int bdinfo_test_help(struct unit_test_state *uts)
@@ -266,7 +265,6 @@ static int bdinfo_test_help(struct unit_test_state *uts)
 
 	return 0;
 }
-
 BDINFO_TEST(bdinfo_test_help, UTF_CONSOLE_REC);
 
 static int bdinfo_test_memory(struct unit_test_state *uts)
@@ -282,7 +280,6 @@ static int bdinfo_test_memory(struct unit_test_state *uts)
 
 	return 0;
 }
-
 BDINFO_TEST(bdinfo_test_memory, UTF_CONSOLE_REC);
 
 static int bdinfo_test_eth(struct unit_test_state *uts)
@@ -298,7 +295,6 @@ static int bdinfo_test_eth(struct unit_test_state *uts)
 
 	return 0;
 }
-
 BDINFO_TEST(bdinfo_test_eth, UTF_CONSOLE_REC);
 
 int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index d4aac0facf6..e7e454c7631 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -121,7 +121,6 @@ static int cmd_exit_test(struct unit_test_state *uts)
 
 	return 0;
 }
-
 EXIT_TEST(cmd_exit_test, UTF_CONSOLE_REC);
 
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index fd601ee5f53..e4b694b728f 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -479,5 +479,4 @@ static int dm_test_cmd_mbr(struct unit_test_state *uts)
 {
 	return mbr_test_run(uts);
 }
-
 DM_TEST(dm_test_cmd_mbr, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index f7f77e73a30..755a0649770 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -27,7 +27,6 @@ static int test_pci_mps_safe(struct unit_test_state *uts)
 
 	return 0;
 }
-
 PCI_MPS_TEST(test_pci_mps_safe, UTF_CONSOLE_REC);
 
 int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/test/cmd/pinmux.c b/test/cmd/pinmux.c
index 23f9b9a9f3a..0b4e001fa1e 100644
--- a/test/cmd/pinmux.c
+++ b/test/cmd/pinmux.c
@@ -36,5 +36,4 @@ static int dm_test_cmd_pinmux_status_pinname(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_cmd_pinmux_status_pinname, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/cmd/pwm.c b/test/cmd/pwm.c
index 494f31f4dae..44f52e15cbb 100644
--- a/test/cmd/pwm.c
+++ b/test/cmd/pwm.c
@@ -71,5 +71,4 @@ static int dm_test_pwm_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_pwm_cmd, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/rw.c b/test/cmd/rw.c
index 3dcf4228ee6..eeda87b53ed 100644
--- a/test/cmd/rw.c
+++ b/test/cmd/rw.c
@@ -99,5 +99,4 @@ static int dm_test_read_write(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_read_write, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index f024a335763..a4086c9451c 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -478,7 +478,6 @@ static int setexpr_test_fmt(struct unit_test_state *uts)
 
 	return 0;
 }
-
 SETEXPR_TEST(setexpr_test_fmt, UTF_CONSOLE_REC);
 #endif
 
diff --git a/test/cmd/temperature.c b/test/cmd/temperature.c
index fc0c95f3d81..b86c7d44b33 100644
--- a/test/cmd/temperature.c
+++ b/test/cmd/temperature.c
@@ -34,5 +34,4 @@ static int dm_test_cmd_temperature(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_cmd_temperature, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
index cde74ebeb61..ee07ab22933 100644
--- a/test/cmd/test_echo.c
+++ b/test/cmd/test_echo.c
@@ -56,5 +56,4 @@ static int lib_test_hush_echo(struct unit_test_state *uts)
 	}
 	return 0;
 }
-
 LIB_TEST(lib_test_hush_echo, 0);
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index b0feb21dc41..1ce167c4ab4 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -223,5 +223,4 @@ static int net_test_wget(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(net_test_wget, 0);
diff --git a/test/common/test_autoboot.c b/test/common/test_autoboot.c
index 4ba1dcc8091..a556cbf8e33 100644
--- a/test/common/test_autoboot.c
+++ b/test/common/test_autoboot.c
@@ -91,5 +91,4 @@ static int test_autoboot(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-
 COMMON_TEST(test_autoboot, 0);
diff --git a/test/dm/axi.c b/test/dm/axi.c
index 1138a46aca1..45c46a19739 100644
--- a/test/dm/axi.c
+++ b/test/dm/axi.c
@@ -21,7 +21,6 @@ static int dm_test_axi_base(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_axi_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that sandbox PCI bus numbering works correctly */
@@ -33,7 +32,6 @@ static int dm_test_axi_busnum(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_axi_busnum, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we can use the store device correctly */
@@ -74,5 +72,4 @@ static int dm_test_axi_store(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_axi_store, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/bootcount.c b/test/dm/bootcount.c
index 4b0a4b37931..f66927a5d37 100644
--- a/test/dm/bootcount.c
+++ b/test/dm/bootcount.c
@@ -35,7 +35,6 @@ static int dm_test_bootcount_rtc(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_bootcount_rtc, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_bootcount_syscon_four_bytes(struct unit_test_state *uts)
@@ -55,7 +54,6 @@ static int dm_test_bootcount_syscon_four_bytes(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_bootcount_syscon_four_bytes,
 	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
@@ -76,6 +74,4 @@ static int dm_test_bootcount_syscon_two_bytes(struct unit_test_state *uts)
 
 	return 0;
 }
-
-DM_TEST(dm_test_bootcount_syscon_two_bytes,
-	UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_bootcount_syscon_two_bytes, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/clk.c b/test/dm/clk.c
index 922b0536154..790968e6477 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -46,7 +46,6 @@ static int dm_test_clk_base(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_clk_base, UTF_SCAN_FDT);
 
 static int dm_test_clk(struct unit_test_state *uts)
diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index 95c0f42caab..ac56f17b775 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -208,5 +208,4 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 
 	return 1;
 }
-
 DM_TEST(dm_test_clk_ccf, UTF_SCAN_FDT);
diff --git a/test/dm/core.c b/test/dm/core.c
index 5d4678437e6..e0c5b9e0017 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -188,7 +188,6 @@ static int dm_test_compare_node_name(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_compare_node_name, UTF_SCAN_PDATA);
 
 /* Test that binding with uclass plat setting occurs correctly */
diff --git a/test/dm/cpu.c b/test/dm/cpu.c
index 885cddb8690..9b2f90ee1e5 100644
--- a/test/dm/cpu.c
+++ b/test/dm/cpu.c
@@ -47,5 +47,4 @@ static int dm_test_cpu(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_cpu, UTF_SCAN_FDT);
diff --git a/test/dm/dsa.c b/test/dm/dsa.c
index 2537605fdce..c6b4e12a758 100644
--- a/test/dm/dsa.c
+++ b/test/dm/dsa.c
@@ -56,7 +56,6 @@ static int dm_test_dsa_probe(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_dsa_probe, UTF_SCAN_FDT);
 
 /* This test sends ping requests with the local address through each DSA port
@@ -78,5 +77,4 @@ static int dm_test_dsa(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_dsa, UTF_SCAN_FDT);
diff --git a/test/dm/dsi_host.c b/test/dm/dsi_host.c
index bf3fd99a18b..b92742472d4 100644
--- a/test/dm/dsi_host.c
+++ b/test/dm/dsi_host.c
@@ -54,5 +54,4 @@ static int dm_test_dsi_host(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_dsi_host, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/eth.c b/test/dm/eth.c
index 8479ebd3f21..467495863e1 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -528,7 +528,6 @@ static int dm_test_eth_async_arp_reply(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_eth_async_arp_reply, UTF_SCAN_FDT);
 
 static int sb_check_ping_reply(struct udevice *dev, void *packet,
@@ -613,7 +612,6 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_eth_async_ping_reply, UTF_SCAN_FDT);
 
 #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
@@ -659,7 +657,6 @@ static int dm_test_validate_ra(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_validate_ra, 0);
 
 static int dm_test_process_ra(struct unit_test_state *uts)
@@ -698,7 +695,6 @@ static int dm_test_process_ra(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_process_ra, 0);
 
 #endif
diff --git a/test/dm/extcon.c b/test/dm/extcon.c
index 0f77b3d34b7..91358abb5f0 100644
--- a/test/dm/extcon.c
+++ b/test/dm/extcon.c
@@ -17,5 +17,4 @@ static int dm_test_extcon(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_extcon, UTF_SCAN_FDT);
diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 450e3e41562..1937d0eecb0 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -197,7 +197,6 @@ static int dm_test_ffa_ack(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_ffa_ack, UTF_SCAN_FDT | UTF_CONSOLE_REC);
 
 static int dm_test_ffa_nack(struct unit_test_state *uts)
@@ -256,5 +255,4 @@ static int dm_test_ffa_nack(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_ffa_nack, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/dm/fpga.c b/test/dm/fpga.c
index 28215a3a5bf..fe9f287f8c7 100644
--- a/test/dm/fpga.c
+++ b/test/dm/fpga.c
@@ -16,5 +16,4 @@ static int dm_test_fpga(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_fpga, UTF_SCAN_FDT);
diff --git a/test/dm/hwspinlock.c b/test/dm/hwspinlock.c
index d6c786e93dd..58bba52182e 100644
--- a/test/dm/hwspinlock.c
+++ b/test/dm/hwspinlock.c
@@ -36,5 +36,4 @@ static int dm_test_hwspinlock_base(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_hwspinlock_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/i2c.c b/test/dm/i2c.c
index 50a2cd0c1be..40f1f26b671 100644
--- a/test/dm/i2c.c
+++ b/test/dm/i2c.c
@@ -301,7 +301,6 @@ static int dm_test_i2c_addr_offset(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_i2c_addr_offset, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_i2c_reg_clrset(struct unit_test_state *uts)
diff --git a/test/dm/mdio.c b/test/dm/mdio.c
index 325b2122822..6760c98898a 100644
--- a/test/dm/mdio.c
+++ b/test/dm/mdio.c
@@ -53,5 +53,4 @@ static int dm_test_mdio(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_mdio, UTF_SCAN_FDT);
diff --git a/test/dm/mdio_mux.c b/test/dm/mdio_mux.c
index 864bc0c3190..866feb26381 100644
--- a/test/dm/mdio_mux.c
+++ b/test/dm/mdio_mux.c
@@ -76,5 +76,4 @@ static int dm_test_mdio_mux(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_mdio_mux, UTF_SCAN_FDT);
diff --git a/test/dm/memory.c b/test/dm/memory.c
index 64ceb99f8df..34e64ba0187 100644
--- a/test/dm/memory.c
+++ b/test/dm/memory.c
@@ -17,5 +17,4 @@ static int dm_test_memory(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_memory, UTF_SCAN_FDT);
diff --git a/test/dm/misc.c b/test/dm/misc.c
index 1abc9eee045..250885dcf51 100644
--- a/test/dm/misc.c
+++ b/test/dm/misc.c
@@ -79,5 +79,4 @@ static int dm_test_misc(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_misc, UTF_SCAN_FDT);
diff --git a/test/dm/nop.c b/test/dm/nop.c
index 7eac16703d7..a6f5f820f6a 100644
--- a/test/dm/nop.c
+++ b/test/dm/nop.c
@@ -69,5 +69,4 @@ static int dm_test_nop(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_nop, UTF_FLAT_TREE | UTF_SCAN_FDT);
diff --git a/test/dm/nvmxip.c b/test/dm/nvmxip.c
index 67e19f2a30e..5c455ddbf04 100644
--- a/test/dm/nvmxip.c
+++ b/test/dm/nvmxip.c
@@ -142,5 +142,4 @@ static int dm_test_nvmxip(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-
 DM_TEST(dm_test_nvmxip, UTF_SCAN_FDT | UTF_CONSOLE_REC);
diff --git a/test/dm/osd.c b/test/dm/osd.c
index 5e77d3b5264..5fb27a3d822 100644
--- a/test/dm/osd.c
+++ b/test/dm/osd.c
@@ -130,7 +130,6 @@ static int dm_test_osd_basics(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_osd_basics, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 static int dm_test_osd_extended(struct unit_test_state *uts)
@@ -214,5 +213,4 @@ static int dm_test_osd_extended(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_osd_extended, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/pci_ep.c b/test/dm/pci_ep.c
index 244fefa40bf..068b72a20c0 100644
--- a/test/dm/pci_ep.c
+++ b/test/dm/pci_ep.c
@@ -59,5 +59,4 @@ static int dm_test_pci_ep_base(struct unit_test_state *uts)
 	ut_asserteq(sandbox_get_pci_ep_irq_count(bus), 10);
 	return 0;
 }
-
 DM_TEST(dm_test_pci_ep_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/pmic.c b/test/dm/pmic.c
index 146aedf8f93..70dd18f5df0 100644
--- a/test/dm/pmic.c
+++ b/test/dm/pmic.c
@@ -52,7 +52,6 @@ static int dm_test_power_pmic_mc34708_get(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_power_pmic_mc34708_get, UTF_SCAN_FDT);
 
 /* Test PMIC I/O */
diff --git a/test/dm/qfw.c b/test/dm/qfw.c
index a7dfe8f8daa..b6be5c5baa5 100644
--- a/test/dm/qfw.c
+++ b/test/dm/qfw.c
@@ -23,7 +23,6 @@ static int dm_test_qfw_cpus(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_qfw_cpus, UTF_SCAN_PDATA);
 
 static int dm_test_qfw_firmware_list(struct unit_test_state *uts)
@@ -37,5 +36,4 @@ static int dm_test_qfw_firmware_list(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_qfw_firmware_list, UTF_SCAN_PDATA);
diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
index c5949092c58..9a3b2bf0a43 100644
--- a/test/dm/reboot-mode.c
+++ b/test/dm/reboot-mode.c
@@ -39,7 +39,6 @@ static int dm_test_reboot_mode_gpio(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_reboot_mode_gpio,
 	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
 
@@ -65,6 +64,5 @@ static int dm_test_reboot_mode_rtc(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_reboot_mode_rtc,
 	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
diff --git a/test/dm/regmap.c b/test/dm/regmap.c
index 436b711b85d..5024b47c7a2 100644
--- a/test/dm/regmap.c
+++ b/test/dm/regmap.c
@@ -157,7 +157,6 @@ static int dm_test_regmap_getset(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_regmap_getset, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Read polling test */
diff --git a/test/dm/reset.c b/test/dm/reset.c
index 99f46fead6d..dceb6a1dad3 100644
--- a/test/dm/reset.c
+++ b/test/dm/reset.c
@@ -66,7 +66,6 @@ static int dm_test_reset_base(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_reset_base, UTF_SCAN_FDT);
 
 static int dm_test_reset(struct unit_test_state *uts)
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 93e275e0650..5c540fc0583 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -202,7 +202,6 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_scmi_base, UTF_SCAN_FDT);
 
 static int dm_test_scmi_cmd(struct unit_test_state *uts)
@@ -282,7 +281,6 @@ static int dm_test_scmi_cmd(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_scmi_cmd, UTF_SCAN_FDT);
 
 static int dm_test_scmi_power_domains(struct unit_test_state *uts)
@@ -388,7 +386,6 @@ static int dm_test_scmi_power_domains(struct unit_test_state *uts)
 
 	return release_sandbox_scmi_test_devices(uts, dev);
 }
-
 DM_TEST(dm_test_scmi_power_domains, UTF_SCAN_FDT);
 
 static int dm_test_scmi_clocks(struct unit_test_state *uts)
diff --git a/test/dm/serial.c b/test/dm/serial.c
index 456799a9eb8..4acb14f41bc 100644
--- a/test/dm/serial.c
+++ b/test/dm/serial.c
@@ -87,5 +87,4 @@ static int dm_test_serial(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_serial, UTF_SCAN_FDT);
diff --git a/test/dm/sm.c b/test/dm/sm.c
index 30985717fed..cf4dab6a722 100644
--- a/test/dm/sm.c
+++ b/test/dm/sm.c
@@ -60,5 +60,4 @@ static int dm_test_sm(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_sm, UTF_SCAN_FDT);
diff --git a/test/dm/soc.c b/test/dm/soc.c
index c01b062970d..a6b82e5376d 100644
--- a/test/dm/soc.c
+++ b/test/dm/soc.c
@@ -115,5 +115,4 @@ static int dm_test_soc(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_soc, UTF_SCAN_FDT);
diff --git a/test/dm/sysinfo.c b/test/dm/sysinfo.c
index adb2f366d2c..6c0d2d7e4df 100644
--- a/test/dm/sysinfo.c
+++ b/test/dm/sysinfo.c
@@ -59,5 +59,4 @@ static int dm_test_sysinfo(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_sysinfo, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/dm/tag.c b/test/dm/tag.c
index bce8a35acfb..1412171738c 100644
--- a/test/dm/tag.c
+++ b/test/dm/tag.c
@@ -29,7 +29,6 @@ static int dm_test_tag_ptr(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_tag_ptr, 0);
 
 /*
@@ -49,7 +48,6 @@ static int dm_test_tag_val(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_tag_val, 0);
 
 /*
@@ -63,7 +61,6 @@ static int dm_test_tag_inval(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_tag_inval, 0);
 
 /*
@@ -79,5 +76,4 @@ static int dm_test_tag_del_all(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_tag_del_all, 0);
diff --git a/test/dm/tee.c b/test/dm/tee.c
index fb890c1bdd4..b56c982eb75 100644
--- a/test/dm/tee.c
+++ b/test/dm/tee.c
@@ -215,5 +215,4 @@ out:
 
 	return rc;
 }
-
 DM_TEST(dm_test_tee, UTF_SCAN_FDT);
diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
index d9c49312f5e..af8cd617108 100644
--- a/test/dm/test-fdt.c
+++ b/test/dm/test-fdt.c
@@ -1224,5 +1224,4 @@ static int dm_test_read_resource(struct unit_test_state *uts)
 
 	return 0;
 }
-
 DM_TEST(dm_test_read_resource, UTF_SCAN_PDATA | UTF_SCAN_FDT);
diff --git a/test/env/hashtable.c b/test/env/hashtable.c
index ccdf0138c4b..16e49358888 100644
--- a/test/env/hashtable.c
+++ b/test/env/hashtable.c
@@ -101,7 +101,6 @@ static int env_test_htab_fill(struct unit_test_state *uts)
 	hdestroy_r(&htab);
 	return 0;
 }
-
 ENV_TEST(env_test_htab_fill, 0);
 
 /* Fill the hashtable up halfway an repeateadly delete/create elements
@@ -122,5 +121,4 @@ static int env_test_htab_deletes(struct unit_test_state *uts)
 	hdestroy_r(&htab);
 	return 0;
 }
-
 ENV_TEST(env_test_htab_deletes, 0);
diff --git a/test/lib/asn1.c b/test/lib/asn1.c
index 4842b7058ac..f0c7819e408 100644
--- a/test/lib/asn1.c
+++ b/test/lib/asn1.c
@@ -135,7 +135,6 @@ static int lib_asn1_x509(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-
 LIB_TEST(lib_asn1_x509, 0);
 #endif /* CONFIG_X509_CERTIFICATE_PARSER */
 
@@ -324,7 +323,6 @@ static int lib_asn1_pkcs7(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-
 LIB_TEST(lib_asn1_pkcs7, 0);
 #endif /* CONFIG_PKCS7_MESSAGE_PARSER */
 
@@ -386,6 +384,5 @@ static int lib_asn1_pkey(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-
 LIB_TEST(lib_asn1_pkey, 0);
 #endif /* CONFIG_RSA_PUBLIC_KEY_PARSER */
diff --git a/test/lib/efi_device_path.c b/test/lib/efi_device_path.c
index 290c8768fa4..5cc001e209e 100644
--- a/test/lib/efi_device_path.c
+++ b/test/lib/efi_device_path.c
@@ -45,5 +45,4 @@ static int lib_test_efi_dp_check_length(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_test_efi_dp_check_length, 0);
diff --git a/test/lib/efi_image_region.c b/test/lib/efi_image_region.c
index 3ca49dc4a2e..2102539ea70 100644
--- a/test/lib/efi_image_region.c
+++ b/test/lib/efi_image_region.c
@@ -65,7 +65,6 @@ static int lib_test_efi_image_region_add(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_test_efi_image_region_add, 0);
 
 static int lib_test_efi_image_region_sort(struct unit_test_state *uts)
@@ -158,5 +157,4 @@ static int lib_test_efi_image_region_sort(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_test_efi_image_region_sort, 0);
diff --git a/test/lib/hexdump.c b/test/lib/hexdump.c
index d531a830398..7b4592d175f 100644
--- a/test/lib/hexdump.c
+++ b/test/lib/hexdump.c
@@ -31,7 +31,6 @@ static int lib_test_hex_to_bin(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_test_hex_to_bin, 0);
 
 static int lib_test_hex2bin(struct unit_test_state *uts)
@@ -61,7 +60,6 @@ static int lib_test_hex2bin(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_test_hex2bin, 0);
 
 static int lib_test_bin2hex(struct unit_test_state *uts)
@@ -91,5 +89,4 @@ static int lib_test_bin2hex(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_test_bin2hex, 0);
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 4b5b6e5e209..3c66138f732 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -360,7 +360,6 @@ static int lib_test_lmb_noreserved(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_noreserved(uts, 0xE0000000, 4, 1);
 }
-
 LIB_TEST(lib_test_lmb_noreserved, 0);
 
 static int lib_test_lmb_unaligned_size(struct unit_test_state *uts)
diff --git a/test/lib/rsa.c b/test/lib/rsa.c
index 40f70010c78..129d03ab7dd 100644
--- a/test/lib/rsa.c
+++ b/test/lib/rsa.c
@@ -158,7 +158,6 @@ static int lib_rsa_verify_valid(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-
 LIB_TEST(lib_rsa_verify_valid, 0);
 
 /**
@@ -200,6 +199,5 @@ static int lib_rsa_verify_invalid(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-
 LIB_TEST(lib_rsa_verify_invalid, 0);
 #endif /* RSA_VERIFY_WITH_PKEY */
diff --git a/test/lib/sscanf.c b/test/lib/sscanf.c
index 9fe5521749f..3a2ec8ffa5f 100644
--- a/test/lib/sscanf.c
+++ b/test/lib/sscanf.c
@@ -169,5 +169,4 @@ static int lib_sscanf(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_sscanf, 0);
diff --git a/test/lib/string.c b/test/lib/string.c
index d08dbca9291..8d22f3fd68f 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -93,7 +93,6 @@ static int lib_memset(struct unit_test_state *uts)
 	}
 	return 0;
 }
-
 LIB_TEST(lib_memset, 0);
 
 /**
@@ -157,7 +156,6 @@ static int lib_memcpy(struct unit_test_state *uts)
 	}
 	return 0;
 }
-
 LIB_TEST(lib_memcpy, 0);
 
 /**
@@ -192,7 +190,6 @@ static int lib_memmove(struct unit_test_state *uts)
 	}
 	return 0;
 }
-
 LIB_TEST(lib_memmove, 0);
 
 /** lib_memdup() - unit test for memdup() */
diff --git a/test/lib/test_aes.c b/test/lib/test_aes.c
index cfd9d8ca5a9..6d9068c4f79 100644
--- a/test/lib/test_aes.c
+++ b/test/lib/test_aes.c
@@ -163,5 +163,4 @@ static int lib_test_aes(struct unit_test_state *uts)
 
 	return ret;
 }
-
 LIB_TEST(lib_test_aes, 0);
diff --git a/test/lib/test_crc8.c b/test/lib/test_crc8.c
index 0dac97bc5bf..52be2dc06c4 100644
--- a/test/lib/test_crc8.c
+++ b/test/lib/test_crc8.c
@@ -25,5 +25,4 @@ static int lib_crc8(struct unit_test_state *uts) {
 
 	return 0;
 }
-
 LIB_TEST(lib_crc8, 0);
diff --git a/test/lib/test_crypt.c b/test/lib/test_crypt.c
index dcdadd992c1..b6dd5f07b86 100644
--- a/test/lib/test_crypt.c
+++ b/test/lib/test_crypt.c
@@ -59,5 +59,4 @@ static int lib_crypt(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-
 LIB_TEST(lib_crypt, 0);
diff --git a/test/lib/test_errno_str.c b/test/lib/test_errno_str.c
index 67f76442b27..967ecfd56f1 100644
--- a/test/lib/test_errno_str.c
+++ b/test/lib/test_errno_str.c
@@ -41,5 +41,4 @@ static int lib_errno_str(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_errno_str, 0);
diff --git a/test/lib/test_print.c b/test/lib/test_print.c
index c7fc50a1de1..e356afc22ba 100644
--- a/test/lib/test_print.c
+++ b/test/lib/test_print.c
@@ -41,7 +41,6 @@ static int lib_test_print_freq(struct unit_test_state *uts)
 	ut_assertok(test_print_freq(uts, 54321987654321, "54321.99 GHz;"));
 	return 0;
 }
-
 LIB_TEST(lib_test_print_freq, 0);
 
 static int test_print_size(struct unit_test_state *uts,
@@ -74,5 +73,4 @@ static int lib_test_print_size(struct unit_test_state *uts)
 	ut_assertok(test_print_size(uts, 54321987654321, "49.4 TiB;"));
 	return 0;
 }
-
 LIB_TEST(lib_test_print_size, 0);
diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 0914f2c47e7..8fe65dbf78b 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -36,5 +36,4 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
 
 	return 0;
 }
-
 LIB_TEST(lib_test_uuid_to_le, 0);
-- 
2.34.1

