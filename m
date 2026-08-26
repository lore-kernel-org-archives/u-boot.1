Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735D4C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BF9E40636;
	Wed, 26 Aug 2026 16:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZgOZ2Z1z_xwT; Wed, 26 Aug 2026 16:35:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762106;
	bh=JjwwmFVRwsELldJjFVNZEyvsggI2W1mJFGnjEGxjSiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sy48H+TjxQzFm8ajxDRKFbbDjJgqwZ9IZShKW+z6Vhim6P0LvQTj31v6DE0PQKpGr
	 UUDlEsJPLJVIVQ370eBQqsBvZ8uI+AzKK8GouHMNJoCz0yed9ZrhFj9VksXhTyaMRk
	 kcgJ7AhGsJ1NL8c8dsrVObGDDnu9C4jq/hm/MnJujnHnfK/CMNtT9usuhpkjxTYNAX
	 AYJ9u0iDYI8AHo30R8ynJ0NMFyX9xhFlCmxmJD/IwoAp3yy0yI25vn0MTGSO9vCMuU
	 mQ7ps1zZyo/RQGOe1Uupx10jcWC6/V2SRnPIbQ+k6IexPzUl1XoVSRScJS36ThIDqr
	 +V2HkEP8d5sqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B511840697;
	Wed, 26 Aug 2026 16:35:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D6B639E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13C6580B48
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9LfitxlrYbcP for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:35:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=KlCWQrTh
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C12C780AAB
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:35:02 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c253425b253so30421966b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762100; x=1788366900;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JjwwmFVRwsELldJjFVNZEyvsggI2W1mJFGnjEGxjSiU=;
 b=KlCWQrThpKDiPIw1VQ5VLiyn1cSS+X8iwZ1U/xVlChdfYHDlVR4DyPm+4jnwnqaFEJ
 mlPquj7LgnEZEuifo9koJQlyyijInMdZayAjVI1uekElkidNtLhnIDTaYN7l2SXvIfJ5
 bSwJFBXk9BeldTfv5ZgBkongoJYNCb3Idh+V9UShPwqrf320gvG+ERocRJU7wMHfTy3b
 8NvYvBjuNXo2w5TDzvNwu97cGEm7UQEN+wRjjgE8WLWugwWMPHh7p0QETWHmv3fw+ECf
 b4KSikyBftHCss9DaW1LetNn8qqMMf+C0TjXS1ALBd//WBlMF3ojtdim1yiRRRcoQ6JT
 tQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762100; x=1788366900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjwwmFVRwsELldJjFVNZEyvsggI2W1mJFGnjEGxjSiU=;
 b=dgoFf/e/WDIOP1w2E2TCyA2mLlWBnDLURmcdfYF779UT9aswk8kmziS4+JjImuWnbb
 aKFVZQi/sgA8NicxyODTOoo7O1xfFsbu/fg0MYw0+ckJa5mOCHqcFdGCaXiJMJF7nzxa
 gIVP8v1hJKPOsZYVEDFXdpx3kb9cnAUDOvFCnCqNYYOjX9suC7OMRQlhMFHW7a1WbEH3
 AwrfB0Jg/wpPAKUitidFlU4m+GgbjcYIivXGJqpIn7qOYaV8N4+xuuUmoyyaRonXwWwn
 mBKImq1OYqWSvV03rBMSMAZpEudO8GwnyEMFol+pIMsbWk9PttnffrtEtKs4MC9A6cOw
 PoPg==
X-Gm-Message-State: AFuF++k5VOjTmUGmPDOhPckdVLuxwsUVwyVlTEyWwBjqB/JN+rz09KAM
 iy5fAAVbcXtRAdMkKuBTiUFm4TVeSsbBdwaJc6pTw6QWuXlNn+Qe4UBJA2s/W15hJXU=
X-Gm-Gg: AR+sD10to4dQh+XFLVOirIxHOmnHx7Fz1i7NwC09jTBTNT0HMcnlCGMf4YeOM+ESMiy
 vlDja2KqIZwCdmpEh4ZqI0ydXmLx2JZQASYkmBN0/NvEgkJsBaOhpAZ1FI9w67TKmvoV0B/XFdz
 ig0uBjZzXgV8587ekntihTEILJWQfrQs7mghqu/oGVIx+ef8Uvs9n2XlEz/twFmUe7s84LcL69+
 14ME9CZ7JKD8brmws2e4KK568Ss/nixZM9WdizR/fNF4GL0cafxYtG6ZKycLw4GTfrn7PWIol3G
 hJICCyFaRqiCJ2IWOQq6U7AujjjFbZWvdbSkDjrn64mwGpkOWMEqElUxo8JdzWDgQJ+Xk37iYVI
 sDe32FYG+2UN0pnV/LMkhceHUfQCqOG8oBTJlL6nyIToWHdvsfIvoZj6sh08J6yBvMZzkxiHJfz
 kB94ymKH3KHN9Kay9opc/JM7yakBSX6rYOx71XJAJzmCyldic+bGV5EPNkMt4dP05TEzrU5rP+v
 E28jFw8UX5uv/sKpL/sNaDfOXQv1f8CuxJDA7fndSE=
X-Received: by 2002:a17:907:9701:b0:c1c:4db0:8314 with SMTP id
 a640c23a62f3a-c250bc2dbfcmr925202366b.13.1787762100503; 
 Wed, 26 Aug 2026 09:35:00 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:00 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:34:04 +0400
Subject: [PATCH v2 12/13] test: bootstd: cover BLS entries below a prefix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-12-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8891; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Qxp6Efr9iJBx5xwKQPx9W1xbyshdNGKiwmFz3FW0lnY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/bJRPmohOWlNd8PVE6aYnrd97a+8KTKiedm7l7vf
 MTRVeBzx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFP9WZnhf1Q/x2W9o8pH/u9M21W/kDkqga/j7PXEV5GtzCvCpnJefMXwz1om5Yi
 f6pT6q/ckD3+YkMle8t/3eWDRR20fPw6be3unswEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Fedora image places its BLS entry at the root of the filesystem, so
the second entry in the bootstd prefix list is never what finds it. Add an
image for the other layout, where $BOOT is a '/boot/' directory on a
larger filesystem and only the '/boot/' prefix turns the entry up.

Its paths still name the kernel, initrd and devicetree relative to the
partition root, matching what systemd's 90-loaderentry.install writes when
$BOOT is not a mount point of its own, and booting it checks they are used
as written rather than rebased onto the prefix. The rescan before booting
covers freeing a bootflow that is still selected, which is the path a
retained bootmeth_priv would double-free.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/sandbox/dts/test.dts |  8 +++++
 test/boot/bootflow.c      | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 66 +++++++++++++++++++++++++++++++++-
 3 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 189d83a81cf6..78d52c1eabb7 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -49,6 +49,7 @@
 		mmc8 = "/mmc8";
 		mmc9 = "/mmc9";
 		mmc10 = "/mmc10";
+		mmc11 = "/mmc11";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1372,6 +1373,13 @@
 		filename = "mmc10.img";
 	};
 
+	/* This is used for BLS boot tests */
+	mmc11 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc11.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index eb8e27fa2253..a1247e7a9e82 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1666,6 +1666,96 @@ static int bootflow_rauc(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_rauc, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
+/*
+ * Test the BLS bootmeth against entries that live below a '/boot/' prefix,
+ * so that they are only found via the second bootstd prefix. The Fedora
+ * image used by the other tests covers the unprefixed layout.
+ */
+static int bootflow_bls_prefix(struct unit_test_state *uts)
+{
+	static const char *order[] = {NULL, NULL};
+	const char *mmc_dev = "mmc11";
+	struct bootstd_priv *std;
+	struct udevice *bootstd;
+	const char **old_order;
+	ofnode root;
+	ofnode node;
+
+	if (!CONFIG_IS_ENABLED(BOOTMETH_BLS))
+		return -EAGAIN;
+
+	order[0] = mmc_dev;
+
+	/* Enable the requested mmc node since we need a different bootflow */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, mmc_dev);
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false));
+
+	/* Change the device and bootmeth order */
+	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+	std = dev_get_priv(bootstd);
+	old_order = std->bootdev_order;
+	std->bootdev_order = order;
+
+	ut_assertok(bootmeth_set_order("bls"));
+
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootflow list", 0));
+	ut_assert_nextlinen("Showing all");
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  bls          ready   mmc          1  mmc11.bootdev.part_1      /boot/loader/entries/aabbccdd-6.17.0-bls.conf");
+	ut_assert_nextlinen("---");
+	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+	ut_assert_console_end();
+
+	/*
+	 * The prefix the entry was found under must be recorded, and the BLS
+	 * 'title' key must surface as the OS name
+	 */
+	ut_assertok(run_command("bootflow select 0", 0));
+	ut_assert_console_end();
+	ut_assertok(run_command("bootflow info", 0));
+	ut_assert_skip_to_line("Subdir:    /boot/");
+	ut_assert_skip_to_line("OS:        BLS prefix test");
+	ut_assert_skip_to_line("Error:     0");
+	ut_assert_console_end();
+
+	/*
+	 * Rescan on top of a selected bootflow. This frees the previous
+	 * bootflow, so it walks the path that would double-free a retained
+	 * bootmeth_priv: the bootflow is shallow-copied into the bootflow list,
+	 * leaving the iterator's temporary and the stored copy sharing it.
+	 */
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_console_end();
+	ut_assertok(run_command("bootflow select 0", 0));
+	ut_assert_console_end();
+
+	/*
+	 * Paths inside the entry stay relative to the partition root even
+	 * though the entry itself was found under '/boot/', so they are used
+	 * as written rather than rebased onto the prefix.
+	 */
+	ut_asserteq(1, run_command("bootflow boot", 0));
+	ut_assert_nextline("** Booting bootflow 'mmc11.bootdev.part_1' with bls");
+	ut_assert_skip_to_line("Retrieving file: /boot/vmlinuz-6.17.0-bls");
+	ut_assert_skip_to_line("Retrieving file: /boot/initramfs-6.17.0-bls.img");
+	ut_assert_skip_to_line("Retrieving file: /boot/dtb-6.17.0-bls/sandbox.dtb");
+	ut_assert_skip_to_line("sandbox: continuing, as we cannot run Linux");
+	ut_assert_nextline("Boot failed (err=-22)");
+	ut_assert_console_end();
+
+	/* Restore the order used by the device tree */
+	std->bootdev_order = old_order;
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_bls_prefix, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+
 /* Check 'bootflow scan' provides a list of images */
 static int bootstd_images(struct unit_test_state *uts)
 {
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 28f028453ea9..3035c7095bd7 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -261,6 +261,68 @@ def setup_fedora_image(ubman, devnum, basename):
     dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
     setup_extlinux_bls_image(ubman, devnum, basename, vmlinux, initrd, dtbdir)
 
+def setup_bls_prefix_image(ubman):
+    """Create a disk image holding BLS entries below a '/boot/' prefix
+
+    This is the layout where $BOOT is a directory on a larger filesystem
+    rather than a partition of its own, so the entries are only found via
+    the second bootstd prefix. The Fedora image covers the other layout,
+    where they sit at the root of the filesystem.
+
+    Paths inside the entry stay relative to the partition root either way,
+    which is both what the spec requires and what systemd's
+    90-loaderentry.install writes: it strips the mount point from the entry
+    directory, so a $BOOT that is not its own mount keeps the '/boot'
+    component.
+    """
+    mmc_dev = 11
+    vmlinux = 'vmlinuz-6.17.0-bls'
+    initrd = 'initramfs-6.17.0-bls.img'
+    dtbdir = 'dtb-6.17.0-bls'
+
+    fsh = FsHelper(ubman.config, 'ext4', 8, prefix='bls')
+    fsh.setup()
+
+    boot = os.path.join(fsh.srcdir, 'boot')
+    mkdir_cond(boot)
+    bls = os.path.join(boot, 'loader')
+    mkdir_cond(bls)
+    bls = os.path.join(bls, 'entries')
+    mkdir_cond(bls)
+
+    # Paths are relative to the partition root, so they keep the '/boot'
+    script = '''title BLS prefix test
+version 6.17.0-bls
+linux /boot/%s
+initrd /boot/%s
+devicetree /boot/%s/sandbox.dtb
+options ro root=/dev/sda1''' % (vmlinux, initrd, dtbdir)
+
+    conf = os.path.join(bls, 'aabbccdd-6.17.0-bls.conf')
+    with open(conf, 'w', encoding='ascii') as fd:
+        print(script, file=fd)
+
+    inf = os.path.join(ubman.config.persistent_data_dir, 'inf')
+    with open(inf, 'wb') as fd:
+        fd.write(gzip.compress(b'vmlinux'))
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    utils.run_and_log(
+        ubman, f'{mkimage} -f auto -d {inf} {os.path.join(boot, vmlinux)}')
+
+    with open(os.path.join(boot, initrd), 'w', encoding='ascii') as fd:
+        print('initrd', file=fd)
+
+    mkdir_cond(os.path.join(boot, dtbdir))
+    dtb_file = os.path.join(boot, f'{dtbdir}/sandbox.dtb')
+    utils.run_and_log(ubman, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
+
+    fsh.mk_fs()
+
+    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
+    img.add_fs(fsh, DiskHelper.EXT4)
+    img.create()
+    fsh.cleanup()
+
 def setup_cros_image(ubman):
     """Create a 20MB disk image with ChromiumOS partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
@@ -648,6 +710,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_android_image(ubman)
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
+    setup_bls_prefix_image(ubman)
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()
@@ -665,7 +728,8 @@ def ut_ubman_fixture(ubman, ut_subtest):
 
     yield ubman
 
-    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_scan_boot"):
+    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_scan_boot",
+                      "bootstd bootflow_bls_prefix"):
         ubman.restart_uboot()
 
 

-- 
2.54.0

