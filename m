Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED55EC8748
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 12:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83AE786A4B;
	Fri,  8 Sep 2023 14:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE4A866AA; Fri,  8 Sep 2023 14:00:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8750B86A54
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 14:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F09D4D75;
 Fri,  8 Sep 2023 05:01:20 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9453F67D;
 Fri,  8 Sep 2023 05:00:40 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 6/8] test: capsule: Generate capsules through config file
Date: Fri,  8 Sep 2023 17:30:00 +0530
Message-Id: <20230908120002.29851-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908120002.29851-1-sughosh.ganu@linaro.org>
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
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

Add logic to generate capsules through a config file while testing the
EFI capsule update functionality. Capsule generation through config
file is enabled on the sandbox variant.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 .../test_efi_capsule/capsule_gen_binman.dts    |  8 ++++++++
 test/py/tests/test_efi_capsule/conftest.py     | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
index e8a1858509..9bde81cbad 100644
--- a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
+++ b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
@@ -54,6 +54,13 @@
 		};
 	};
 
+#ifdef CONFIG_EFI_USE_CAPSULE_CFG_FILE
+	capsule {
+		efi-capsule-cfg-file {
+			cfg-file = "sandbox_capsule_cfg.txt";
+		};
+	};
+#else
 	capsule1 {
 		filename = "Test01";
 		efi-capsule {
@@ -318,4 +325,5 @@
 			};
 		};
 	};
+#endif /* !CONFIG_EFI_USE_CAPSULE_CFG_FILE */
 };
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index dd41da9284..dba3114e58 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -76,15 +76,25 @@ def efi_capsule_data(request, u_boot_config):
         check_call('cd %s; echo -n u-boot:Old > u-boot.bin.old; echo -n u-boot:New > u-boot.bin.new; echo -n u-boot-env:Old > u-boot.env.old; echo -n u-boot-env:New > u-boot.env.new' % data_dir,
                    shell=True)
 
+        capsule_cfg_file_gen = u_boot_config.buildconfig.get('config_efi_use_capsule_cfg_file')
+        capsule_cfg_file_flag=""
+        if capsule_cfg_file_gen:
+            capsule_cfg_flag="-DCONFIG_EFI_USE_CAPSULE_CFG_FILE"
+            check_call('cd %s; '
+                       'cp u-boot.bin.* %s; cp u-boot.env.* %s'
+                       % (data_dir, u_boot_config.build_dir, u_boot_config.build_dir), shell=True)
+            check_call('cp %s/test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt %s'
+                       % (u_boot_config.source_dir, data_dir), shell=True)
+
         pythonpath = os.environ.get('PYTHONPATH', '')
         os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/scripts/dtc/pylibfdt' % u_boot_config.build_dir
         check_call('cd %s; '
-                   'cc -E -I %s/include -x assembler-with-cpp -o capsule_gen_tmp.dts %s/test/py/tests/test_efi_capsule/capsule_gen_binman.dts; '
+                   'cc -E -I %s/include -x assembler-with-cpp %s -o capsule_gen_tmp.dts %s/test/py/tests/test_efi_capsule/capsule_gen_binman.dts; '
                    'dtc -I dts -O dtb capsule_gen_tmp.dts -o capsule_binman.dtb;'
-                   % (data_dir, u_boot_config.source_dir, u_boot_config.source_dir), shell=True)
+                   % (data_dir, u_boot_config.source_dir, capsule_cfg_file_flag, u_boot_config.source_dir), shell=True)
         check_call('cd %s; '
-                   './tools/binman/binman --toolpath %s/tools build -u -d %s/capsule_binman.dtb -O %s -m --allow-missing -I %s -I ./board/sandbox -I ./arch/sandbox/dts'
-                   % (u_boot_config.source_dir, u_boot_config.build_dir, data_dir, data_dir, data_dir), shell=True)
+                   '%s/tools/binman/binman --toolpath %s/tools build -u -d capsule_binman.dtb -O . -m --allow-missing -I . -I %s/board/sandbox -I %s/arch/sandbox/dts'
+                   % (data_dir, u_boot_config.source_dir, u_boot_config.build_dir, u_boot_config.source_dir, u_boot_config.source_dir), shell=True)
         os.environ['PYTHONPATH'] = pythonpath
 
         # Create a disk image with EFI system partition
-- 
2.34.1

