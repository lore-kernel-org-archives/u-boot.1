Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D6606A333
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cXixhMqH;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=R+Rscs48
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AF66406C5;
	Sat,  7 Nov 2026 16:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id il7MwsRBYq2K; Sat,  7 Nov 2026 16:04:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B4E9140753
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794067488;
	b=Xt4pE46uCFuKAdVcozLMUZGi8j+eGiAFYs/xpD0b/U+CFO5VqB+Ep3/tTIdAcS4dfQ63
	 xDpugDDKfvBMJjJ9YjvEI2W3oBIY5i20yIeApndc4etG9+eKXwlO4znBvPSAAxRSr6/4X
	 0eH569PCEwOGmICkPODuAosq6jn5HgXV7ne4cMvHNsaQR9Hxv5g/nsrmPkZUlUl21jHXU
	 9xT0Q/CqgIX+6+CEPothmsTJzK12t6F9xkryeZcwblLDNxJLUcFnh+oJ33wJHFAdAsuym
	 Ueb9er8LWxNRqHgxPOGhbLJLUhO2ZpvMGmnbJ3RkOH5htfRAjdlhxS9HdaXOUCZh93w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794067488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gYkmjPIpBQTP0xcm6X4yS8kMJU+QkOiAWtSjrAMJneE=;
	b=WGvF5a1f/X5+nVu3rD1Xuf9GPZl1XQ09W/6Jml0d9ZK9dCoymhMT2zU1rKJEDUUAA2Sy
	 xKjsZwTY9WxPdgDyiw1yfYEgg9Pdwx1+dmljNFxbjY9yd5lVHGnl4Cob3ijU3UN3URwep
	 UIC8yohb8l4lIiVP7tbXaoZip7Atu5tc4ghRwkNsG63b37dPRcqlmTGtDVlaQhQOZdvvW
	 wn+fs1dIpcAa/w7GBm+IGblPSpUbRgjwHBDrWHcxfSnPDE29G+PDWbxSZBPQd1MROn66U
	 c+s73Ot/AOhRtkyUWVnjub1yykxfn+E/tD/ImlfEoLViFk+154ZqveU0rM0sKQbA39Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794067488;
	bh=gYkmjPIpBQTP0xcm6X4yS8kMJU+QkOiAWtSjrAMJneE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cXixhMqHtBvMUn+5SFsBZLUsgRBL/+r5Y+puzF49HzrPLcSiBnVaJ6H/bM3xWjQ+6
	 AvepteecDpBhajD6lsmiXzR49KiXgMwRGm4ThjWM+GAOC9tc1VLmztKw3cPI+LTA7u
	 FUiGeJJRZrVAJvI8++fyO4lRYeGR/o5mW4RpRqjnq+7QRf+oSCfgJD6VUm0BG9KXdv
	 5NDmLZ7adG/mpvQ/OSra4JYKoSnTwdxLdlExS/hkF+MCpv0J56YKg3W7l46wFQxG7w
	 rgsKt/4gcNmlNmY12dJ79QVFMX5FaC/OKP6FNHdfeYuOkWOzHvq1drrP+H3PwoEma4
	 qWfUXKv67vs3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4E9140753;
	Sat,  7 Nov 2026 16:04:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D7E3D1C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE5346065A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AqK0WgNjb92O for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 16:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DDF7860665
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.5;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=R+Rscs48
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DDF7860665
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gY
 kmjPIpBQTP0xcm6X4yS8kMJU+QkOiAWtSjrAMJneE=; b=R+Rscs48vXa2a4Xb69
 O+ysQTzlZvvpYfnZhxpU+HFXLsDKXya5w6OhdP0nWQaOGQ00JaFgJttUo7w0MApG
 uAJ767uchPt3odfh6aQFTsjFfJfQGllJx0ZYKIZ+JNwpsbLh1j711tUzGDLZQH3B
 xVG+tUCs8kwUlD/qyBkUX6B20=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wA3FCH3S+9q+f2SFw--.1483S7; 
 Sun, 08 Nov 2026 00:04:09 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH v4 5/5] test: bootstd: Cover scripts in raw partitions on
 sandbox
Date: Sun,  8 Nov 2026 00:04:06 +0800
Message-ID: <20261107160406.3943071-6-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107160406.3943071-1-hyyoxhk@163.com>
References: <20261107160406.3943071-1-hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3FCH3S+9q+f2SFw--.1483S7
X-Coremail-Antispam: 1Uf129KBjvJXoW3uw4DJF17Xr48Zr4fuFyDKFg_yoWkGFyrpa
 97C39Yk3y8GF1fZ3yrC3WDCr4fCrs5JFy5Wry3Ja4YyrnxtFZ7trnayw15Aw47XFWkX343
 uF10vFWUGr1DK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8hmnemrvS-kugwAA3s
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

Reuse fs_helper.setup_image() for the named GPT partitions. Check both
errors and diagnostic messages for rejected script images, and ensure the
scan ends after the final partition. Keep per-case image changes together
and share the legacy header CRC fix-up.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
 MAINTAINERS               |   1 +
 arch/sandbox/dts/test.dts |   8 +++
 configs/sandbox_defconfig |   1 +
 test/boot/bootflow.c      |  98 ++++++++++++++++++++++++++++++++++++
 test/py/img/__init__.py   |   2 +
 test/py/img/script_raw.py | 101 ++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  |   3 ++
 7 files changed, 214 insertions(+)
 create mode 100644 test/py/img/__init__.py
 create mode 100644 test/py/img/script_raw.py

diff --git a/MAINTAINERS b/MAINTAINERS
index d1f51d9197d..6870298ee0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -846,6 +846,7 @@ F:	include/bootflow.h
 F:	include/bootmeth.h
 F:	include/bootstd.h
 F:	test/boot/
+F:	test/py/img/script_raw.py
 
 BOOTMETH_ANDROID
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
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
index c4b41668a62..fc7d3c8f267 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -35,6 +35,7 @@ extern U_BOOT_DRIVER(bootmeth_android);
 extern U_BOOT_DRIVER(bootmeth_cros);
 extern U_BOOT_DRIVER(bootmeth_rauc);
 extern U_BOOT_DRIVER(bootmeth_2script);
+extern U_BOOT_DRIVER(bootmeth_2script_raw);
 
 /* Use this as the vendor for EFI to tell the app to exit boot services */
 static u16 __efi_runtime_data test_vendor[] = u"U-Boot testing";
@@ -1908,4 +1909,101 @@ static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootdev_hunt_fallthrough,
              UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV | UTF_CONSOLE);
+
+/* Exercise valid and rejected images without restarting U-Boot per case. */
+static int check_script_raw(struct unit_test_state *uts,
+			    struct bootflow_iter *iter)
+{
+	static const struct {
+		int err;
+		const char *msg;
+	} cases[] = {
+		/* Keep in sync with CASES in test/py/img/script_raw.py. */
+		{ 0, NULL },	/* legacy */
+		{ 0, NULL },	/* fit */
+		{ -EINVAL, "FIT image 'script' data is outside the image" },	/* external */
+		{ -EINVAL, "Bad data crc" },	/* bad_crc */
+		{ -E2BIG, NULL },	/* too_large */
+		{ -ENOENT, NULL },	/* wrong_name */
+		{ -ENOEXEC, NULL },	/* empty */
+		{ -EINVAL, NULL },	/* bad_header */
+		{ -E2BIG, NULL },	/* partition_size */
+		{ -EINVAL, "Bad FIT image format" },	/* bad_fit */
+	};
+	struct bootflow bflow;
+	int ret, part;
+
+	ret = bootflow_scan_first(NULL, NULL, iter, BOOTFLOWIF_ALL, &bflow);
+	/* A raw script belongs to a partition, never to the whole disk. */
+	ut_asserteq(-ENOENT, ret);
+	ut_asserteq(0, bflow.part);
+	bootflow_free(&bflow);
+	for (part = 1; part <= ARRAY_SIZE(cases); part++) {
+		ret = bootflow_scan_next(iter, &bflow);
+		ut_asserteq(part, bflow.part);
+		ut_asserteq(cases[part - 1].err, ret);
+		if (cases[part - 1].msg)
+			ut_assert_skip_to_line("%s", cases[part - 1].msg);
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
+	/* The scanner also visits unused partition slots. */
+	for (; part < iter->max_part; part++) {
+		ut_asserteq(-ENOENT, bootflow_scan_next(iter, &bflow));
+		ut_asserteq(part, bflow.part);
+		bootflow_free(&bflow);
+	}
+	ut_asserteq(-ENODEV, bootflow_scan_next(iter, &bflow));
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
+	ofnode node;
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
+	node = ofnode_find_subnode(oftree_root(oftree_default()), "mmc12");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false));
+	ut_assertok(bootstd_get_priv(&std));
+	old_order = std->bootdev_order;
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
index 00000000000..5fbd432332d
--- /dev/null
+++ b/test/py/img/script_raw.py
@@ -0,0 +1,101 @@
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
+def update_header_crc(data):
+    """Update the legacy image header CRC after changing its fields."""
+    struct.pack_into('>I', data, 4, 0)
+    struct.pack_into('>I', data, 4, zlib.crc32(data[:64]))
+
+
+def script_image(ubman, case):
+    """Build one script image, optionally corrupting its header or data."""
+    if case == 'empty':
+        return bytearray(512)
+
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
+        update_header_crc(data)
+    elif case == 'bad_header':
+        data[4] ^= 1
+    elif case == 'partition_size':
+        struct.pack_into('>I', data, 12, 512 * 1024)
+        update_header_crc(data)
+    elif case == 'bad_fit':
+        # Keep the header valid but corrupt the structure block.
+        offset = struct.unpack_from('>I', data, 8)[0]
+        struct.pack_into('>I', data, offset, 0xffffffff)
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
+            outf.seek(part * 1024 * 1024)
+            outf.write(data)
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

