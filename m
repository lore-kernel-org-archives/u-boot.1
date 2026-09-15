Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF23C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E3E76078A;
	Tue, 15 Sep 2026 12:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I4oBTGQ72tv4; Tue, 15 Sep 2026 12:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2205260779
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476818;
	b=DkByOtllioJaLICSuPNCqYSPgjFK4SLbC9g+E6FCXld+0NDf7iwN6vTmK3hs2swR20j8
	 JkLm7ntRQ+jA58GGkKuSWz7uMYLsGHTWjjAh7HzsdO9IUScxvJ2wbu2tWCmwR7RIHNOkM
	 sgWQ9gBVghI8oZ+E+TB17rTSiabHA17oLzw1xgtk6Az/xm+zAVFy7bxIr+kYyVXf6suMs
	 rFPtBvVci1uDGiOnlZXoxrffIKh+k3QBIQQF0+yg6aafFMZL+Zqw9nrTU7ND3V2aZUaPp
	 aJJt61gvvr5hvExIzAzYSaHu1izsMEIzC/XY7AbXHpgQQB96AV5F6JfF1KYUdFZ65WA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GJ/HANso560EIa6gZ4Iy0FJj8Dv7L3QwFpCkLp3Wovk=;
	b=r+ysXv+OMYJxvLwuo4oFqTZ7oZubkla7XBUf+hV5ERFfLy6/IKfgUREd+bOsa59bnnGb
	 vk/tGLB+QT4iYuuXCePyrzLmkiHkprQQbVxo9adjcTP1OtYs5XdFPR3Iq8aMeb8olp7cL
	 T7Dg2dTSIHGn7piGRZeiNYDi6YsIS5fkjfPvJt6wi6IG9UoV4idcqJ1UX/FDHDZLqzyPi
	 Ws5gAQaCv5mTJSphOlaak/asiDQR94tCNPVNATrKhZbGqkY2pYPPiqnHX1cSy3gtjGb9K
	 LE0Yzl7hV7JppskalkgmDiAKhFjsSbvA4klWeMClfkd75bpKw7/YscVHmlEhT9Ldi1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=siemens.com;
	spf=fail smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=PaaTvw8x;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476818;
	bh=GJ/HANso560EIa6gZ4Iy0FJj8Dv7L3QwFpCkLp3Wovk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uBBRb1lkseqMyE4pwVl8j3jnf0afmmli0kA2BIfds9rcskzPwOKW0x6i2uTBcOS9b
	 08ajh7XfvwzscKsNVL1gxX/gxDaiQPa/HaHi/5TIluha7svJ4HE5Un2bfSjYuCmFp+
	 zRAA0TdP6aVvkWff8FW3TMs2niN7/WDASDKYaEa/wt+5tDNu806dbOj4CxIyj7yhHC
	 inXt6hyAujuW6uVKLZXdaZEwA9B7tvOaIGKkiWRqTFRap4WA0lWRT9V37StCtjyNSn
	 rKCzVasbDarCGWi4v9EiNQvb7S/akgymHJh6ejPnFJS6MGlZGsR/nJVSbHeqwaVpzP
	 VJhEEKTb5ZLsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2205260779;
	Tue, 15 Sep 2026 12:53:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CFABA259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5A786074D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UAUVmqjnakH5 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 44D9D60760
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476811;
 b=cKPjFCUd3TlgAUmLZWkxDT5ADrSW9hAQXSFsXpYgSvyxGMa9ggl/Yhgquw1KmUnTwU8t
 ShCFhJdyY8slFEQiOu/+zruolA4LZlW2QVNraX2U+tpFfm5AlvFisGK6kZc0zOAmR7pmn
 +xNOeCfdbpp7srBOEWduZeXxDSSto7tPX4VNT9o5Nc+q2/RvminbRzLzGd3ru/ApVx0lm
 yiG+3LHalSjvf1IvBE2oDVpFC8vqYpR2IGyWpyo+qy9Vx4EsuMnaefWRgPu3JjHgymycL
 ByR1NlkouBvPMvUj1bVmYqv8yNiv1P1SBYF/NOlfY2j3O6jkZ3JNt1UG3OBhHdlbt2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476811;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=GJ/HANso560EIa6gZ4Iy0FJj8Dv7L3QwFpCkLp3Wovk=;
 b=E1hUbXw7rWwFMru1kC84ttMy0G5O/eN36WtkuiwixpoH+sTMEveb8fMb4vU/4y3tluHr
 u2dRme3l/z0XsVscPrkX52rvgco405TbcRWKZ4VDLQUOn62me3HxThIKe77le+doLFIdH
 f2YvqW87nznarKzTCG6Yy5whfD10PnhMXSMYJgljUMOnO1g10Ww9Pok4fgDBIF8BlfSMr
 kP0F5vZLo26AQFjRTckaADSR6bh7cXyvtnG+hm6nqKzuRFeHdtYliVXHqdpFECcW6tlxu
 /GCiIOsf1eR/1oLOoQOkyKJwNTOFYhQL+qwj3UEyOocQfKSm/2G1w71Zb/D98T2n20A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=PaaTvw8x; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=PaaTvw8x
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44D9D60760
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E47847E5; Tue, 15 Sep 2026 14:53:26 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FA7847DF
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="PaaTvw8x"; dkim-atps=neutral
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 2026091512532219223dcafb00020720 for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GJ/HANso560EIa6gZ4Iy0FJj8Dv7L3QwFpCkLp3Wovk=;
 b=PaaTvw8x6n71GBQvgjO+NWC0OeJ3in+oHso7GilVpS2OWF9BKeVjjXUWl2gW2vJRN2hYeu
 MwBVGDvWAklLnrvxV3K5JZoNBCzzuOxBvUM7j+xxXWzZ7Q2KUZeVZGzyrSSQvpAfwQNSVWuR
 atc72PC3NdM0uuHQ1tK82cQ/KJAonI++Q5/zeVwo1EQrSd/PpGKRZd/qrADvq2EA70LnwJAK
 fowpP33t0ZpcD/mt56ITQUH8ka6aeFfcf+UsGv+XLkvpwCV9VQ1Vk9m9AtwUFeLoqY3gGPgr
 XuJmCmQLgM1XvIITc0/Ja6b1jglMzq0ctDHrOtpVsymliqpZqHcetzww==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de
Subject: [PATCH v9 2/8] qemu-arm64: merge built-in DT
Date: Tue, 15 Sep 2026 14:52:13 +0200
Message-ID: <20260915145217.v9.2.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
In-Reply-To: <20260915125317.180911-1-ludwig.nussel@siemens.com>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

The keys trusted for FIT signature verification are supposed to be
embedded in the device tree built into u-boot. When running in Qemu it's
convenient to use the device tree provided by the VM which doesn't know
about signatures though. So merge both device trees at startup.

Make sure CONFIG_OF_OMIT_DTB is not set in qemu_arm64_defconfig to take
advantage of the feature by default.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v8)

Changes in v8:
- fix smbios test

Changes in v7:
- add guard for OF_LIBFDT_OVERLAY

Changes in v6:
- fix comment style and typos
- fix error message
- return error from board_fdt_blob_setup() if dt couldn't be resized or
  merged. Unfortunately fdtdec_ret_to_errno() is static elsewere so
  -EINVAL has to suffice
- mention CONFIG_OF_OMIT_DTB in commit message

Changes in v4:
- mention arm in subject
- correctly change defconfig

Changes in v3:
- enable CONFIG_OF_OMIT_DTB=n in defconfig
- add error returns
- document decission about dt merging direction

 board/emulation/qemu-arm/qemu-arm.c | 51 +++++++++++++++++++++++++++--
 configs/qemu_arm64_defconfig        |  1 +
 test/py/tests/test_smbios.py        |  3 +-
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 38f0ec5f2fb..590a336380b 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -144,10 +144,57 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+/*
+ * QEMU loads a generated DTB for us at the start of RAM.
+ * When using signatures we may have a built-in FDT that contains
+ * our known public keys nevertheless. So merge the built-in FDT
+ * into QEMU's. We cannot merge the other way around (e.g. in
+ * fdtdec_board_setup()) or board_fix_fdt() at this stage as U-Boot
+ * might be started from a ROM location. At the same time U-Boot
+ * needs QEMU's FDT to initialize serial devices even before
+ * relocation.
+ */
 int board_fdt_blob_setup(void **fdtp)
 {
-	/* QEMU loads a generated DTB for us at the start of RAM. */
-	*fdtp = (void *)CFG_SYS_SDRAM_BASE;
+	void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
+	int ret;
+
+	if (fdt_check_header(qemu_fdt) != 0) {
+		log_err("Invalid QEMU FDT at %p\n", qemu_fdt);
+		return -EINVAL;
+	}
+
+	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY))
+		goto out;
+
+	if (fdt_check_header(*fdtp) != 0) {
+		/* this was a perfectly normal condition before
+		 * (CONFIG_OF_OMIT_DTB was set for qemu). So to avoid
+		 * breaking existing configs don't error out. This
+		 * might mean that we don't have keys in case
+		 * FIT_SIGNATURE is on. We can't know though as
+		 * existing setups might have injected them into
+		 * QEMU's FDT already.
+		 */
+		goto out;
+	}
+
+	log_debug("Found built-in FDT at %p. Merging into %p...\n", *fdtp, qemu_fdt);
+
+	ret = fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
+	if (ret) {
+		log_err("Failed to grow QEMU FDT: %s\n", fdt_strerror(ret));
+		return -EINVAL;
+	}
+
+	ret = fdt_overlay_apply_node(qemu_fdt, 0, *fdtp, 0);
+	if (ret) {
+		log_err("Failed to apply FDT overlay: %s\n", fdt_strerror(ret));
+		return -EINVAL;
+	}
+
+out:
+	*fdtp = qemu_fdt;
 
 	return 0;
 }
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5bdbd6fb59a..0fd7016c045 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_SPAWN=y
+# CONFIG_OF_OMIT_DTB is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_AHCI=y
 CONFIG_SCSI_AHCI=y
diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
index 3b85a7cc661..607cd3d8cba 100644
--- a/test/py/tests/test_smbios.py
+++ b/test/py/tests/test_smbios.py
@@ -49,7 +49,8 @@ def test_cmd_smbios_sysinfo_verbose(ubman):
     assert 'DMI type 0,' in output
     assert 'Vendor: U-Boot' in output
     assert 'DMI type 1,' in output
-    assert 'Manufacturer: linux' in output
+    # QEMU fdt shows up as emulation, fallback in u-boot is linux
+    assert ('Manufacturer: emulation' or 'Manufacturer: linux') in output
     assert 'DMI type 2,' in output
     assert 'DMI type 3,' in output
     assert 'DMI type 7,' in output
-- 
2.43.0

