Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FF606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yrOSBQzN;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fc4fxLqH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 221A380E20;
	Mon, 26 Oct 2026 14:04:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfHPWnZtTrsD; Mon, 26 Oct 2026 14:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05A5E80DD7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793023496;
	b=SiuQ6TcEANTLAif+vMd/0xzn/vNbjRkdmUitcw1KKcApjkpV2gjrnjm5WUFU3UDfQ6nv
	 Eoaw+MG4vKJIcftj122xtyrAP8CCymr6ui31ttJBXbkXM9Z9A1PRrmegyB7Tdo2AO1ub+
	 EgflTAkGYhx+XUCILKal3AaYTdxZAOhR0Cw3sTA4O/w94LdGPX9AFuQs69dOLKvgFg/jM
	 0b95ihUOMZVFJb7Z/sw+FOVJdeoIdlX0eLN6k7hS1brlM0FiWXcDDQXx5/fGIXNf57NTa
	 LmzyKF9H5aYslistKCz+khqUY8W8MaIREJ9lmk+V8fJnP8zlFAVje2clDz5KwlVcSiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793023496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I0hXooi+vJJKUxNg9/hzA9dqlmOiPEL+4cdxQHSsaHk=;
	b=BS2KJEC4E+O4NaVXEdL+vT/DNO5nOZtp7onSU3C6LvZO6MMSTU0tm0M4k/6hKPvnbTCU
	 FH1+0Bt3WBgiZ+1orb2Pe9Y2kHhJ3//tb8SdEBzJPYEhTg7ASESn1Kku8gbFmU8xWwLXG
	 aNewvppktoBIy359nEklwtm9P6gb790ynJATBJCXmf47iMqLkGzJbr9fFDDLQ859ON+He
	 vmX0kpojYRaIUW49e3Kid+7bl7eIFbU71zs5Pbs49U+4AwXrrMHMk6Fhy6f0NXOO1y57n
	 9iHhtCtSK261Yq1nnbb1i0DP4HXVgxDOA8EjZi7XPx5fkyi5651AMtSEgifkQ2of8zw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793023496;
	bh=I0hXooi+vJJKUxNg9/hzA9dqlmOiPEL+4cdxQHSsaHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yrOSBQzNW8bCw38VdmeB/WgVhjqBCnqwmPVz/sAuQ87HoFdZ1a+afSyoG1quKPGry
	 MbYvfZSzvi8xFurk2GHAmVF8nvW4fhv6zR5wovZNaQvQxcM9jNqP8AD+wLXsbL8Y8X
	 +AA2VxPuVqiTHVojGlQt+Psc1rw2MdueiYzJoCU3AEx53pWevqJDz5E4kU2j9csO9M
	 urOf9oh410H7gNWfyhJiMX4XH9rqbAtegZAKbRxRYO1VPMj4f+5pzqhYE2KrvWD2Wj
	 tDMowvWcCmzyW43cO1IqQGz2ZWy1T3CD5gLdcc3W7Z1BvfjDmr6oY2uTtzkd4zaB2s
	 EVt97gmPa8rpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05A5E80DD7;
	Mon, 26 Oct 2026 14:04:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BBF4F4B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4FA840653
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJGEFYKgCRq0 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:04:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8BB2640311
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793023491;
 b=CnI8iLAIGJqK4x8c3oEAWK8+HFFPwooACo9XIr4zZrr0eNB5+7ukp/9y1gCoTK9T7dYk
 hOD7n2FkQbOYgGL0kNq/lu+4sHxoYdJXIUk6neoJBCrkP4y0uuubhBCCzrljT98FYiIy/
 KGuOJr10F3skV5SOemSYCUTHSy3OtxlSo4AdyPqbP/Fwtpa95VoXcMZm5mSEq1fgp8WJG
 JO3aTN1s05rb0HjbmanQeZ8bSGE3+8JAAbtApozu6PUB6lxAEpyHTqmu06V2CLZbAUCSm
 C0SCDo2FajVYv6a4kN553xVaXUiz2owL4V66+ZBvU9ntlrGBGic+dZEXMqtYp2y5MiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793023491;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=I0hXooi+vJJKUxNg9/hzA9dqlmOiPEL+4cdxQHSsaHk=;
 b=pS8EP01wiDQCLNx8vBnFK551pNx4y+r9LVmwIP9UqYtmwoiihDT3zcsJSyhL6sBHxNWg
 fbObTU92dvSHUDwokxrLSGHpeP5oosM9/lKZhl0m0DUlOmHLOagR5LM7jZ53nhrPlUGMV
 P8MYYnoV1+MgG4YhcL4Mmi3E2aXBjjNrdv6nrifJnslWHVRRQR5D+v8C2YhoFefTNzIGN
 ilEPMkOskv8EVWvT1hgvUZn3fQ6pRsONi+hlXAYQpkR5X4KbKIwp7RlaDKZKk9elhj+VQ
 NEr+kusQ7f1cI6+09tBPY9cMHS3EcS6xi6hmX7r6GJGkJbRn57Vte3Z53G0131nUR2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=fc4fxLqH; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=fc4fxLqH
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BB2640311
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=I0
 hXooi+vJJKUxNg9/hzA9dqlmOiPEL+4cdxQHSsaHk=; b=fc4fxLqHUmLvdRpKtQ
 AxDdEWjp8imy2M4S1Od/4F2+oW6uj7JjFtm2n8p+XhaJ9+nlMN3wbAGl52VsX0sa
 H5LzkjSfWUZdvDbyb4eMhSBHS1x/Fa5Mrr95EP44t+XgIEha3EHon33AI1OhNvJW
 nKX09AD4KGznTRfiA6CKlieXw=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3N95qXd9qrufGCw--.5946S6; 
 Mon, 26 Oct 2026 22:02:20 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/4] test: bootstd: Cover scripts in raw partitions on
 sandbox
Date: Mon, 26 Oct 2026 22:02:18 +0800
Message-ID: <1f06dcba8237a74da16903141924fb0f96b3b265.1793020986.git.hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793020986.git.hyyoxhk@163.com>
References: <cover.1793020986.git.hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3N95qXd9qrufGCw--.5946S6
X-Coremail-Antispam: 1Uf129KBjvAXoW3tF1kCr1DXw4xZFyfKrW5GFg_yoW8JrWrAo
 Z3KFZYganYgr47uFZ5uFsrKF48Wr48Kry3XFW5XrnxX3WDZw4fCw1j9an8XFykArWFgr98
 ZF9rKa4fAr4Dtan5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7NVyUUUUU
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8gwF12rfXWxk1gAA3a
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable script_raw for sandbox and add a GPT disk with valid legacy and
FIT scripts, as well as malformed and unsupported images. Bind the
bootmeth inside the new C test so existing bootmeth lists and bootflow
tests, including bootflow scan -G coverage, remain unchanged.

Introduce test/py/img/ as a package for disk-image generators. Existing
C-test image setup lives in test/py/tests/test_ut.py; keep the raw-script
case definitions and image generation in the new module and call it
from the existing test_ut_dm_init_bootstd() initialization.

Allow fs_helper.setup_image() to accept an sfdisk partition specification
and reuse it for the named GPT partitions. This avoids a dependency on
sgdisk or a separate initialization test. Annotate each expected C error
with its Python case name to keep the two lists in sync.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
Changes in v3:
- Split sandbox coverage into its own patch.
- Bind script_raw only inside its test and preserve existing scan -G coverage.
- Annotate expected errors with Python case names.
- Reuse fs_helper and sfdisk from the existing bootstd initialization test.

 arch/sandbox/dts/test.dts  |  8 ++++
 configs/sandbox_defconfig  |  1 +
 test/boot/bootflow.c       | 81 +++++++++++++++++++++++++++++++
 test/py/img/__init__.py    |  2 +
 test/py/img/script_raw.py  | 98 ++++++++++++++++++++++++++++++++++++++
 test/py/tests/fs_helper.py | 19 +++++---
 test/py/tests/test_ut.py   |  3 ++
 7 files changed, 205 insertions(+), 7 deletions(-)
 create mode 100644 test/py/img/__init__.py
 create mode 100644 test/py/img/script_raw.py

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef8147..3470e4368d3 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -50,6 +50,7 @@
 		mmc9 = "/mmc9";
 		mmc10 = "/mmc10";
 		mmc11 = "/mmc11";
+		mmc12 = "/mmc12";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1398,6 +1399,13 @@
 		filename = "mmc11.img";
 	};
 
+	/* This is used for raw script bootflow tests */
+	mmc12 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc12.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a2708e6fb33..09b2980f79b 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -28,6 +28,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
 CONFIG_BOOTMETH_BLS=y
 CONFIG_BOOTMETH_RAUC=y
+CONFIG_BOOTMETH_SCRIPT_RAW=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index c4b41668a62..d7e5a51f7b5 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -35,6 +35,7 @@ extern U_BOOT_DRIVER(bootmeth_android);
 extern U_BOOT_DRIVER(bootmeth_cros);
 extern U_BOOT_DRIVER(bootmeth_rauc);
 extern U_BOOT_DRIVER(bootmeth_2script);
+extern U_BOOT_DRIVER(bootmeth_2script_raw);
 
 /* Use this as the vendor for EFI to tell the app to exit boot services */
 static u16 __efi_runtime_data test_vendor[] = u"U-Boot testing";
@@ -1908,4 +1909,84 @@ static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootdev_hunt_fallthrough,
              UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV | UTF_CONSOLE);
+
+/* Exercise valid and rejected images without restarting U-Boot per case. */
+static int check_script_raw(struct unit_test_state *uts,
+			    struct bootflow_iter *iter)
+{
+	static const int errors[] = {
+		/* Keep in sync with CASES in test/py/img/script_raw.py. */
+		0,		/* legacy */
+		0,		/* fit */
+		-EINVAL,	/* external */
+		-EINVAL,	/* bad_crc */
+		-E2BIG,		/* too_large */
+		-ENOENT,	/* wrong_name */
+		-ENOEXEC,	/* empty */
+		-EINVAL,	/* bad_header */
+		-E2BIG,		/* partition_size */
+		-EINVAL,	/* bad_fit */
+	};
+	struct bootflow bflow;
+	int ret, part;
+
+	ret = bootflow_scan_first(NULL, NULL, iter, BOOTFLOWIF_ALL, &bflow);
+	/* A raw script belongs to a partition, never to the whole disk. */
+	ut_asserteq(-ENOENT, ret);
+	ut_asserteq(0, bflow.part);
+	bootflow_free(&bflow);
+	for (part = 1; part <= ARRAY_SIZE(errors); part++) {
+		ret = bootflow_scan_next(iter, &bflow);
+		ut_asserteq(part, bflow.part);
+		ut_asserteq(errors[part - 1], ret);
+		if (!ret) {
+			ut_asserteq(BOOTFLOWST_READY, bflow.state);
+			ut_asserteq_str("uboot_scr", bflow.fname);
+			/* A script returning successfully did not boot an OS. */
+			ut_asserteq(-EFAULT, bootflow_run_boot(iter, &bflow));
+			ut_assert_skip_to_line("%sraw-script-ok mmc c %d",
+					       part == 2 ? "sha256+ " : "", part);
+			ut_asserteq_str("mmc", env_get("devtype"));
+		} else {
+			ut_assert(bflow.state < BOOTFLOWST_READY);
+			ut_assertnull(bflow.buf);
+		}
+		bootflow_free(&bflow);
+	}
+
+	return 0;
+}
+
+static int bootflow_script_raw(struct unit_test_state *uts)
+{
+	static const char *order[] = {"mmc12", NULL};
+	struct bootflow_iter iter;
+	struct bootstd_priv *std;
+	struct udevice *bootstd;
+	const char **old_order;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW))
+		return -EAGAIN;
+
+	/* Bind only for this test, leaving the default bootmeth list intact. */
+	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_2script_raw),
+				"script_raw", 0, ofnode_null(), NULL));
+
+	ut_assertok(prep_mmc_bootdev(uts, "mmc12", false, &old_order));
+	ut_assertok(bootstd_get_priv(&std));
+	std->bootdev_order = order;
+	ut_assertok(bootmeth_set_order("script_raw"));
+	ut_assertok(env_set("verify", "yes"));
+	ret = check_script_raw(uts, &iter);
+	bootflow_iter_uninit(&iter);
+	std->bootdev_order = old_order;
+	/* Restore verify even if a scan or boot assertion failed. */
+	ut_assertok(env_set("verify", NULL));
+	ut_assertok(ret);
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_script_raw, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 #endif /* CONFIG_SANDBOX */
diff --git a/test/py/img/__init__.py b/test/py/img/__init__.py
new file mode 100644
index 00000000000..526c5dda958
--- /dev/null
+++ b/test/py/img/__init__.py
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+"""Disk-image generators for U-Boot C tests."""
diff --git a/test/py/img/script_raw.py b/test/py/img/script_raw.py
new file mode 100644
index 00000000000..671c5917d6d
--- /dev/null
+++ b/test/py/img/script_raw.py
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 He Yong <hyyoxhk@163.com>
+
+"""Create a GPT disk containing valid and malformed raw script images."""
+
+import os
+import struct
+import zlib
+
+import utils
+from tests import fs_helper
+
+
+CASES = ('legacy', 'fit', 'external', 'bad_crc',
+         'too_large', 'wrong_name', 'empty', 'bad_header', 'partition_size',
+         'bad_fit')
+
+
+def script_image(ubman, case):
+    """Build one script image, optionally corrupting its header or data."""
+    workdir = ubman.config.build_dir
+    script = os.path.join(workdir, 'raw-script.cmd')
+    image = os.path.join(workdir, 'raw-script.scr')
+    mkimage = os.path.join(ubman.config.build_dir, 'tools', 'mkimage')
+    with open(script, 'w', encoding='utf-8') as outf:
+        outf.write('echo raw-script-ok ${devtype} ${devnum} '
+                   '${distro_bootpart}\n')
+    if case in ('fit', 'external', 'bad_fit'):
+        its = os.path.join(workdir, 'raw-script.its')
+        with open(its, 'w', encoding='utf-8') as outf:
+            outf.write('''/dts-v1/;
+/ {
+    description = "Raw script test";
+    #address-cells = <1>;
+    images {
+        script {
+            description = "Boot script";
+            data = /incbin/("raw-script.cmd");
+            type = "script";
+            arch = "sandbox";
+            compression = "none";
+            hash { algo = "sha256"; };
+        };
+    };
+    configurations {
+        default = "conf";
+        conf {
+            script = "script";
+        };
+    };
+};
+''')
+        args = [mkimage, '-f', its]
+        if case == 'external':
+            args.append('-E')
+        utils.run_and_log(ubman, args + [image])
+    else:
+        utils.run_and_log(ubman, [mkimage, '-A', 'sandbox', '-T', 'script',
+                                  '-C', 'none', '-d', script, image])
+    with open(image, 'rb') as inf:
+        data = bytearray(inf.read())
+    if case == 'bad_crc':
+        data[-1] ^= 1
+    elif case == 'too_large':
+        struct.pack_into('>I', data, 12, 2 * 1024 * 1024)
+    elif case == 'empty':
+        data = bytearray(512)
+    if case == 'too_large':
+        struct.pack_into('>I', data, 4, 0)
+        struct.pack_into('>I', data, 4, zlib.crc32(data[:64]))
+    return data
+
+
+def setup_script_raw_image(ubman):
+    """Create one disk for all cases, with 512 KiB non-bootable partitions."""
+    spec = 'label: gpt\n'
+    for part, case in enumerate(CASES, 1):
+        start = part * 2048
+        label = 'other' if case == 'wrong_name' else 'uboot_scr'
+        spec += f'start={start}, size=1024, name="{label}"\n'
+    disk, _ = fs_helper.setup_image(ubman, 12, None, img_size=16,
+                                    part_spec=spec)
+    with open(disk, 'r+b') as outf:
+        for part, case in enumerate(CASES, 1):
+            data = script_image(ubman, case)
+            if case == 'bad_header':
+                data[4] ^= 1
+            elif case == 'partition_size':
+                struct.pack_into('>I', data, 12, 512 * 1024)
+            elif case == 'bad_fit':
+                # Keep the header valid but corrupt the structure block.
+                offset = struct.unpack_from('>I', data, 8)[0]
+                struct.pack_into('>I', data, offset, 0xffffffff)
+            if case == 'partition_size':
+                struct.pack_into('>I', data, 4, 0)
+                struct.pack_into('>I', data, 4, zlib.crc32(data[:64]))
+            outf.seek(part * 1024 * 1024)
+            outf.write(data)
diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index e3824b2c1fd..7c9577e28b1 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -8,7 +8,7 @@
 import re
 import os
 import shutil
-from subprocess import call, check_call, check_output, CalledProcessError
+from subprocess import call, check_call, check_output, CalledProcessError, run
 from subprocess import DEVNULL
 import tempfile
 
@@ -262,8 +262,8 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
         raise
 
 def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
-                basename='mmc'):
-    """Create a disk image with one or two partitions
+                basename='mmc', part_spec=None):
+    """Create a disk image with default or caller-specified partitions
 
     Args:
         ubman (ConsoleBase): Console to use
@@ -272,6 +272,8 @@ def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
         img_size (int): Image size in MiB
         second_part (bool): True to contain a small second partition
         basename (str): Base name to use in the filename, e.g. 'mmc'
+        part_spec (str): Optional sfdisk partition specification, overriding
+            part_type and second_part
 
     Returns:
         tuple:
@@ -281,14 +283,17 @@ def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
     fname = os.path.join(ubman.config.source_dir, f'{basename}{devnum}.img')
     mnt = os.path.join(ubman.config.persistent_data_dir, 'scratch')
 
-    spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
-    if second_part:
-        spec += '\ntype=c'
+    spec = part_spec
+    if spec is None:
+        spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
+        if second_part:
+            spec += '\ntype=c'
 
     try:
         check_call(f'mkdir -p {mnt}', shell=True)
         check_call(f'qemu-img create {fname} {img_size}M', shell=True)
-        check_call(f'printf "{spec}" | sfdisk {fname}', shell=True)
+        # Pass the specification directly, including quoted GPT names.
+        run(['sfdisk', fname], input=spec.encode(), check=True)
     except CalledProcessError:
         call(f'rm -f {fname}', shell=True)
         raise
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 2a5acc18c61..c52d7f46ac2 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -16,6 +16,7 @@ import re
 import pytest
 
 import utils
+from img.script_raw import setup_script_raw_image
 # pylint: disable=E0611
 from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
@@ -755,6 +756,8 @@ def test_ut_dm_init_bootstd(ubman):
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
     setup_bls_prefix_image(ubman)
+    if ubman.config.buildconfig.get('config_bootmeth_script_raw') == 'y':
+        setup_script_raw_image(ubman)
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()
-- 
2.43.0

