Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858A606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m4gtSIg5;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=2GTqFc3+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C0C8606BB;
	Thu, 29 Oct 2026 16:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrXcZftW4N91; Thu, 29 Oct 2026 16:23:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8508E6071F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291024;
	b=tR9vYv6McZxrs8LP6284srqcp06fOpxFRhuyiQhInIaKqUkWE+SiUyfp6It0FrsSBm19
	 WICFuVyfosti8xU62stTbNjn3bLyF0MAYPo7lu6xjiMTY3G49cA1CFheE29fskPGaABvM
	 6EsU9+AFpLQGeNpLul2F7Zp5ieoB7eBL2ZmHh2+YmcWFPYSvUT7jx77m4r2YTCupXwAXj
	 Snen1d2FVhMmbCZSSfkebeM3JohTRi7vxJWfNVmjX+ujWHfMofgKZifDEFLmM0iFyodYu
	 wenKTa+99JdiLWpXtzbUoxpd3Mbjhj+AddrGOPflaTD6StTGigCcvS0xxRdnKqXEfWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5eHKodIrjO3JFqbbg+l1psjirv2E002AOFznxvF/EOs=;
	b=FInbODNEDXWEC8YcIf81dQw9aqTzEaqO+9Q2Ee09c04Mq+sNtP4sBkYRLaiVsIIbMcOn
	 Nm+ctEvrQ/momTxzfhNr4Q9WAtnJvl+qKSDr+pvkBYg+TjBjtZRKahE/DQUH1eofaL1no
	 /6CJkk73urz7pIENieJs4zezvAKwveJBuhy/y/UYC2o9uTOvf6l9X+Q3aVf18dCOjIkUI
	 ZlyFGUuX+kPidSSMaSP01GVxvnHVxdTZhshnLOK+lX24yLKXy0v9JsDssB7mJAFry37eP
	 8AUtE1yKwTFoz5tws51ytfZ0ZmqyeaKVM4WMSgM97h1XW5rU4x0OQEjPiLMDUTMferg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291024;
	bh=5eHKodIrjO3JFqbbg+l1psjirv2E002AOFznxvF/EOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m4gtSIg5B5V1wKKjTijhWEqvCMc/78h9CyAzpXbHTaqsilk+bw79Mb1GPU4aqX3iZ
	 shNKtLI036y6YJkY9EqJuXq/bjUXi7YIxlG6yRc/e6lgnCqwW+xNzJcW2dxp46Q6l6
	 O6xTUAa/PA+InLftSUkFAkRRQiamhQko9f9eoqy5fmNI6ZCLbNhLQ0NNoSETg/otKm
	 iDVYx+xd0i76Y+PxkxSVPLwKCStC7YEmap8qCLtgN83FJkDz3bW2L/i5oHw16mqG3d
	 6cq7QcfJf9HUT8yfzgKARSZxw+Yq2YiOlH55NxXyyZMGlHElDpSnG4IzulF4wi/EDb
	 v+R/C0sZA8hEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8508E6071F;
	Thu, 29 Oct 2026 16:23:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 060D22E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E01F740243
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L2ALrz-FKGmJ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1927540012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291011;
 b=nWIohK1iktSIzBIb3lURSwidIdcWKCJxquSe4bcjhRfhj+RKoeET5ErgN7P3+j6OCdhN
 Epd10AhsewvFMzpRGQfcNO2Hv0ivtY/5fx72DRzWRegC1Or8GPWurTNrQSnk2tE35bCcb
 jaE5wJGXBnjeFeWeV02fhv4qZ6o45iLtBIhAOn+k8cgfevWX6+uH1Jyt/FmWsZ8+OTImx
 YIelNwF+gO3PoQHQMgKwohMYqxYF9odEzv1Y4i0iFNZHTNNjkcNQ7RPYlsyMUmV/uIeUv
 ZSQch6OcqGXFQP57LTrL1qWGncTj9GVHoOdmLCHkOdwfVB5KvXGIQtVqxIddKeUyRpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291011;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=5eHKodIrjO3JFqbbg+l1psjirv2E002AOFznxvF/EOs=;
 b=pnZs7ECMRuqyiGRJHV0FgZs5Dcvyp3GIikRWOKE+ry6bBFToAZOFqVzQyjdicFdo9j8Y
 CpoHPJa+u2Wlpb3xH35cz9sIOX4q9AwRC5fWHx7L3YT659jq/af4fFVXVEdHyCJHBPol/
 OXfT+8+iEnOsobZveAF4ADETpPjoVkiTKFex4RyXEyeXEfj4sXoGO0ARf87jBIOzwBb9B
 S5tE+MNEgq3wiEe+oS0D30QLwjbnRqq4gJZClUjo5ZBusTxqz0DHN+A3z6BprVmhGRRbM
 nPTfMGLzeqxZGIGonT7Vk1k94EttKvmeG6QV5Rr4cBKJFOxohJyyA7qPud9eta76OyA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=2GTqFc3+; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=2GTqFc3+
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1927540012
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eHKodIrjO3JFqbbg+l1psjirv2E002AOFznxvF/EOs=;
 b=2GTqFc3+WePVuzMXdYzj6PpH9mrcTahRchc0ATYFGBwv1S+Bx0Xahf0i5K9vrXcNY+uGki
 EHdWSFnjIwn6dvhxOoP72UxSpGSVIFFvYzvW2n4/9QES36OpSm+e6JfG0jzA3sD/dqVMHb
 a+juVNg7pSWFuNsouPSvP/5FpGDBXTJT3fxUNTBonjWeZZVXimbgJngRR1ybrUndZ19mnU
 UNdQULRwPohETqdGQcv3XsgSk9hXQm6paGH8uf1Mw/V7X1aHCVrPk0cGfsVNCYqGoAs6EC
 Iu3gX2C7IKlpdLD2MEJGVqo1BIfGWluSDNNuzc74usBvwzF38+6nb0spb7Hmwg==
Date: Thu, 29 Oct 2026 17:23:15 +0100
Subject: [PATCH 09/10] test: boot: Test the RAUC partition name check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-9-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5377;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=l716XbHebDMluzOxRT19ySoWQ9cgI+Ov/iY99UjnkZ0=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a9f694w7Bdt5JXyXjk5UMVI+aHOot9tCZplrMqdP
 mH+aw50lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATOR6JCPDh3VpXuvns6d+Ov3q
 cQp7/pf3hs/Yy43Y9AIjv2/5OjtwPSPD5G+/Y/3X77jP8XbCZs85SuU/Xa70qbEfUP3WU7bhk84
 NDgA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Set CONFIG_BOOTMETH_RAUC_PART_NAMES on sandbox and give the
partitions of the RAUC test image (mmc10) matching names. As only GPT
has partition names, DiskHelper now creates the image with GPT instead
of MBR. The existing test passes with or without the option, as the
names match.

Add a second image (mmc13) with the same layout but other names, and
a test that the RAUC bootmeth finds no bootflow on it. The test is
skipped if the option is empty. It needs an #ifdef, since the string
option does not exist without BOOTMETH_RAUC and IS_ENABLED() cannot
check a string.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/sandbox/dts/test.dts |  8 ++++++++
 configs/sandbox_defconfig |  1 +
 test/boot/bootflow.c      | 27 +++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 26 +++++++++++++++++---------
 4 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 02a9ca29b79..c64769c543f 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -51,6 +51,7 @@
 		mmc10 = "/mmc10";
 		mmc11 = "/mmc11";
 		mmc12 = "/mmc12";
+		mmc13 = "/mmc13";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1406,6 +1407,13 @@
 		filename = "mmc12.img";
 	};
 
+	/* This is used for RAUC boot tests, with other partition names */
+	mmc13 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc13.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a3fa5246082..b952622b403 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -28,6 +28,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
 CONFIG_BOOTMETH_BLS=y
 CONFIG_BOOTMETH_RAUC=y
+CONFIG_BOOTMETH_RAUC_PART_NAMES="boot_a,root_a boot_b,root_b"
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index d2d4edb0add..e0a3c8a28b1 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1824,6 +1824,33 @@ static int bootflow_bls_prefix(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_bls_prefix, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
+static int bootflow_rauc_part_names_check(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_nextline("No bootflows found; try again with -l");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootflow list", 0));
+	ut_assert_skip_to_line("(0 bootflows, 0 valid)");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+/* Test that the RAUC bootmeth ignores a device with other partition names */
+static int bootflow_rauc_part_names(struct unit_test_state *uts)
+{
+	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC))
+		return -EAGAIN;
+#ifdef CONFIG_BOOTMETH_RAUC_PART_NAMES
+	if (!CONFIG_BOOTMETH_RAUC_PART_NAMES[0])
+		return -EAGAIN;
+#endif
+
+	return bootflow_rauc_run(uts, "mmc13", bootflow_rauc_part_names_check);
+}
+BOOTSTD_TEST(bootflow_rauc_part_names, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+
 /* Check 'bootflow scan' provides a list of images */
 static int bootstd_images(struct unit_test_state *uts)
 {
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index a33f188d984..a1a00c5a716 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -583,10 +583,15 @@ def setup_efi_image(ubman):
     fsh.cleanup()
 
 
-def setup_rauc_image(ubman):
-    """Create a 40MB disk image with an A/B RAUC system on it"""
-    mmc_dev = 10
+def setup_rauc_image(ubman, mmc_dev, part_names):
+    """Create a disk image with an A/B RAUC system on it
 
+    Args:
+        ubman (ConsoleBase): Console to use
+        mmc_dev (int): MMC device number, e.g. 10
+        part_names (tuple of str): GPT names of the boot A, root A, boot B
+            and root B partitions
+    """
     boot = FsHelper(ubman.config, 'fat32', 8, 'rauc_boot')
     boot.setup()
 
@@ -606,11 +611,12 @@ def setup_rauc_image(ubman):
     root = FsHelper(ubman.config, 'ext4', 10, 'rauc_root')
     root.mk_fs()
 
-    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
-    img.add_fs(boot, DiskHelper.VFAT, bootable=True)
-    img.add_fs(root, DiskHelper.EXT4)
-    img.add_fs(boot, DiskHelper.VFAT, bootable=True)
-    img.add_fs(root, DiskHelper.EXT4)
+    boot_a, root_a, boot_b, root_b = part_names
+    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True, gpt=True)
+    img.add_fs(boot, DiskHelper.VFAT, bootable=True, name=boot_a)
+    img.add_fs(root, DiskHelper.EXT4, name=root_a)
+    img.add_fs(boot, DiskHelper.VFAT, bootable=True, name=boot_b)
+    img.add_fs(root, DiskHelper.EXT4, name=root_b)
     img.create()
     boot.cleanup()
     root.cleanup()
@@ -626,7 +632,9 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cros_image(ubman)
     setup_android_image(ubman)
     setup_efi_image(ubman)
-    setup_rauc_image(ubman)
+    # The names of mmc10 match CONFIG_BOOTMETH_RAUC_PART_NAMES in sandbox
+    setup_rauc_image(ubman, 10, ('boot_a', 'root_a', 'boot_b', 'root_b'))
+    setup_rauc_image(ubman, 13, ('boot', 'rootfs', 'boot2', 'rootfs2'))
     setup_bls_prefix_image(ubman)
 
     # Restart so that the new mmc1.img is picked up

-- 
2.56.0

