Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0F3C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680B4889FD;
	Sun, 11 Aug 2024 16:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g82axpfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA596889ED; Sun, 11 Aug 2024 16:52:39 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14CD9887E8
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39b0826298cso13071775ab.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387955; x=1723992755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVyTDmUvuhTVv38JnbN24w4MSW3iJraazcROZtvVKiM=;
 b=g82axpfi4yO0O9UFM0/3jKNi5091pVqE2lt88KryJiGZRtGNrDl+gNs1sApwj5+Hlu
 41j2BN9gjlV4ynyzHBDpVxt9CvtZvjzQIcz4T8XrdJI/5q3Zp6xyk8NM1WtiNP1iDaZw
 rBv1oaJsYoZe/65RlzteW6jsaZq2oV4o/wfeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387955; x=1723992755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVyTDmUvuhTVv38JnbN24w4MSW3iJraazcROZtvVKiM=;
 b=Bv/BSQAxBhUcpGJxxIVhuIGmn1SkYyKJdPndms69tZnrx1l/vzj+7b/HmUSJqUcLyF
 R12XzKn2WdI8lobcBqW4jFHW08t6doC5sHeidqZq+OYrWHSzFGLGoTiGEuapJMAZmZdB
 Oj0Ofdy1uUUEmy8CV5AhxJLIkxaO0kgCq6YRiCZqpHCkeqyhWWkGkGwpaAhyADCwkJTJ
 qTU9aspZYU/KFDRnAMw5/ilbkPUF3WDXTisFy+zT+7zjwCZ2miNkKupOF5xb5Tpif3In
 CCzWHixtf5znGvqu0of+BpOLIfRuGQiDXMbuUCgdnXDii9TlfH+6EbUtkQC5Ti4DlheN
 whEA==
X-Gm-Message-State: AOJu0YwViABjHGa9Usw5DBnuM1LW7OXwkJ9f11lv8yZiKqHx2O2TTTyA
 hsXUzURBUIK2sqfsLivxNZvsbtkTTvQSUwWyG32rTyT6+fOsWsGvVlKOKuzWBtYbi4qammeOGL0
 =
X-Google-Smtp-Source: AGHT+IGHlQGpCrUIyrs2AaryVZqLXrFE+vmSLwurQV9AyxXYRD2xOP+vw2A0g4NYrxmdXKM6EuPvlw==
X-Received: by 2002:a92:ca4a:0:b0:382:b3f8:9f72 with SMTP id
 e9e14a558f8ab-39b7a416772mr104507335ab.15.1723387955466; 
 Sun, 11 Aug 2024 07:52:35 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 05/40] scripts: Update pylint.base
Date: Sun, 11 Aug 2024 08:51:34 -0600
Message-Id: <20240811145209.4191404-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

There have been quite a few changes in the Python scripts, so update the
pylint baseline.

This was created using:

   make pylint
   cp pylint.cur scripts/pylint.base

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/pylint.base | 462 ++++++++++++++++++++++++++------------------
 1 file changed, 272 insertions(+), 190 deletions(-)

diff --git a/scripts/pylint.base b/scripts/pylint.base
index c7d141ed393..bc39e2385a3 100644
--- a/scripts/pylint.base
+++ b/scripts/pylint.base
@@ -1,229 +1,311 @@
-test_conftest.py 6.56
-test_multiplexed_log.py 7.49
-test_test.py 8.18
+test_conftest.py 6.78
+test_multiplexed_log.py 7.68
+test_test.py 9.00
+test_tests_fit_util.py 7.19
+test_tests_fs_helper.py 10.00
 test_tests_test_000_version.py 7.50
-test_tests_test_android_test_ab.py 6.50
-test_tests_test_android_test_abootimg.py 6.09
-test_tests_test_android_test_avb.py 5.52
-test_tests_test_bind.py -2.99
+test_tests_test_android_test_ab.py 7.00
+test_tests_test_android_test_abootimg.py 6.52
+test_tests_test_android_test_avb.py 6.38
+test_tests_test_bind.py 8.89
 test_tests_test_bootmenu.py 10.00
+test_tests_test_bootstage.py 7.14
 test_tests_test_button.py 3.33
-test_tests_test_dfu.py 5.45
-test_tests_test_dm.py 9.52
-test_tests_test_efi_capsule_capsule_defs.py 6.67
-test_tests_test_efi_capsule_conftest.py 1.86
-test_tests_test_efi_capsule_test_capsule_firmware.py 4.52
-test_tests_test_efi_capsule_test_capsule_firmware_signed.py 4.85
-test_tests_test_efi_fit.py 8.16
-test_tests_test_efi_loader.py 7.38
-test_tests_test_efi_secboot_conftest.py -3.29
-test_tests_test_efi_secboot_defs.py 6.67
-test_tests_test_efi_secboot_test_authvar.py 8.93
-test_tests_test_efi_secboot_test_signed.py 8.41
-test_tests_test_efi_secboot_test_signed_intca.py 8.10
-test_tests_test_efi_secboot_test_unsigned.py 8.00
-test_tests_test_efi_selftest.py 6.36
-test_tests_test_env.py 7.15
-test_tests_test_extension.py 2.14
-test_tests_test_fit.py 6.83
-test_tests_test_fit_ecdsa.py 7.94
-test_tests_test_fit_hashes.py 7.70
-test_tests_test_fpga.py 1.81
-test_tests_test_fs_conftest.py 5.13
+test_tests_test_cat_conftest.py 10.00
+test_tests_test_cat_test_cat.py 10.00
+test_tests_test_cleanup_build.py 10.00
+test_tests_test_dfu.py 6.23
+test_tests_test_dm.py 8.98
+test_tests_test_efi_bootmgr_conftest.py 10.00
+test_tests_test_efi_bootmgr_test_efi_bootmgr.py 10.00
+test_tests_test_efi_capsule_capsule_common.py 10.00
+test_tests_test_efi_capsule_capsule_defs.py 10.00
+test_tests_test_efi_capsule_conftest.py 3.26
+test_tests_test_efi_capsule_test_capsule_firmware_fit.py 10.00
+test_tests_test_efi_capsule_test_capsule_firmware_raw.py 9.62
+test_tests_test_efi_capsule_test_capsule_firmware_signed_fit.py 9.74
+test_tests_test_efi_capsule_test_capsule_firmware_signed_raw.py 9.75
+test_tests_test_efi_fit.py 8.84
+test_tests_test_efi_loader.py 8.00
+test_tests_test_efi_secboot_conftest.py 0.00
+test_tests_test_efi_secboot_defs.py 10.00
+test_tests_test_efi_secboot_test_authvar.py 9.38
+test_tests_test_efi_secboot_test_signed.py 8.60
+test_tests_test_efi_secboot_test_signed_intca.py 8.81
+test_tests_test_efi_secboot_test_unsigned.py 8.75
+test_tests_test_efi_selftest.py 8.07
+test_tests_test_eficonfig_conftest.py 10.00
+test_tests_test_eficonfig_test_eficonfig.py 9.47
+test_tests_test_env.py 7.76
+test_tests_test_event_dump.py 2.22
+test_tests_test_extension.py 2.50
+test_tests_test_fit.py 7.54
+test_tests_test_fit_auto_signed.py 9.09
+test_tests_test_fit_ecdsa.py 8.29
+test_tests_test_fit_hashes.py 7.94
+test_tests_test_fpga.py 2.94
+test_tests_test_fs_conftest.py 5.21
 test_tests_test_fs_fstest_defs.py 8.33
 test_tests_test_fs_fstest_helpers.py 4.29
-test_tests_test_fs_test_basic.py 0.60
-test_tests_test_fs_test_ext.py 0.00
+test_tests_test_fs_test_basic.py 1.90
+test_tests_test_fs_test_erofs.py 8.97
+test_tests_test_fs_test_ext.py 1.48
 test_tests_test_fs_test_fs_cmd.py 8.00
-test_tests_test_fs_test_mkdir.py 1.96
-test_tests_test_fs_test_squashfs_sqfs_common.py 8.41
-test_tests_test_fs_test_squashfs_test_sqfs_load.py 7.46
-test_tests_test_fs_test_squashfs_test_sqfs_ls.py 8.00
-test_tests_test_fs_test_symlink.py 1.22
-test_tests_test_fs_test_unlink.py 2.78
-test_tests_test_gpio.py 6.09
-test_tests_test_gpt.py 7.67
+test_tests_test_fs_test_fs_fat.py 2.50
+test_tests_test_fs_test_mkdir.py 3.04
+test_tests_test_fs_test_squashfs_sqfs_common.py 8.38
+test_tests_test_fs_test_squashfs_test_sqfs_load.py 7.63
+test_tests_test_fs_test_squashfs_test_sqfs_ls.py 8.04
+test_tests_test_fs_test_symlink.py 2.04
+test_tests_test_fs_test_unlink.py 4.07
+test_tests_test_gpio.py 7.60
+test_tests_test_gpt.py 8.55
 test_tests_test_handoff.py 5.00
-test_tests_test_help.py 5.00
-test_tests_test_hush_if_test.py 9.27
-test_tests_test_log.py 8.64
+test_tests_test_help.py 8.64
+test_tests_test_i2c.py 7.42
+test_tests_test_kconfig.py 5.38
+test_tests_test_log.py 8.75
 test_tests_test_lsblk.py 8.00
 test_tests_test_md.py 3.64
+test_tests_test_mdio.py 6.82
+test_tests_test_memtest.py 8.39
+test_tests_test_mii.py 8.55
+test_tests_test_mmc.py 7.01
 test_tests_test_mmc_rd.py 6.05
 test_tests_test_mmc_wr.py 3.33
-test_tests_test_net.py 6.84
+test_tests_test_net.py 8.43
+test_tests_test_net_boot.py 8.23
+test_tests_test_of_migrate.py 7.86
 test_tests_test_ofplatdata.py 5.71
+test_tests_test_optee_rpmb.py 0.00
 test_tests_test_part.py 8.00
-test_tests_test_pinmux.py 3.27
+test_tests_test_pinmux.py 3.40
 test_tests_test_pstore.py 2.31
 test_tests_test_qfw.py 8.75
+test_tests_test_reset.py 9.55
 test_tests_test_sandbox_exit.py 6.50
+test_tests_test_sandbox_opts.py 1.11
+test_tests_test_saveenv.py 7.87
 test_tests_test_scp03.py 3.33
-test_tests_test_sf.py 7.13
+test_tests_test_scsi.py 8.47
+test_tests_test_semihosting_conftest.py 10.00
+test_tests_test_semihosting_test_hostfs.py 10.00
+test_tests_test_sf.py 7.45
 test_tests_test_shell_basics.py 9.58
-test_tests_test_sleep.py 7.78
-test_tests_test_spl.py 2.22
+test_tests_test_sleep.py 8.28
+test_tests_test_smbios.py 9.47
+test_tests_test_source.py 7.20
+test_tests_test_spl.py 6.67
 test_tests_test_stackprotector.py 5.71
-test_tests_test_tpm2.py 8.51
-test_tests_test_ums.py 6.32
+test_tests_test_tpm2.py 8.45
+test_tests_test_trace.py 8.70
+test_tests_test_ums.py 5.92
 test_tests_test_unknown_cmd.py 5.00
-test_tests_test_ut.py 7.06
-test_tests_test_vboot.py 6.01
-test_tests_vboot_evil.py 8.95
+test_tests_test_upl.py 5.33
+test_tests_test_usb.py 7.08
+test_tests_test_ut.py 9.44
+test_tests_test_vbe.py 7.22
+test_tests_test_vbe_vpl.py 6.11
+test_tests_test_vboot.py 5.37
+test_tests_test_vpl.py 2.22
+test_tests_test_xxd_conftest.py 10.00
+test_tests_test_xxd_test_xxd.py 10.00
+test_tests_test_zynq_secure.py 7.60
+test_tests_test_zynqmp_rpu.py 7.54
+test_tests_test_zynqmp_secure.py 7.68
+test_tests_vboot_evil.py 9.45
 test_tests_vboot_forge.py 9.22
-test_u_boot_console_base.py 7.08
-test_u_boot_console_exec_attach.py 9.23
-test_u_boot_console_sandbox.py 8.06
-test_u_boot_spawn.py 7.65
-test_u_boot_utils.py 6.94
-tools_binman_bintool 8.59
+test_u_boot_console_base.py 7.73
+test_u_boot_console_exec_attach.py 9.62
+test_u_boot_console_sandbox.py 8.64
+test_u_boot_spawn.py 8.57
+test_u_boot_utils.py 7.83
+tools_binman_bintool 9.16
 tools_binman_bintool_test 9.87
-tools_binman_btool__testing 6.09
+tools_binman_btool__testing 6.52
+tools_binman_btool_bootgen 4.50
+tools_binman_btool_btool_gzip 0.00
+tools_binman_btool_bzip2 0.00
 tools_binman_btool_cbfstool 7.83
-tools_binman_btool_fiptool 7.62
-tools_binman_btool_futility 7.39
+tools_binman_btool_cst 5.00
+tools_binman_btool_fdt_add_pubkey 7.00
+tools_binman_btool_fdtgrep 5.20
+tools_binman_btool_fiptool 7.22
+tools_binman_btool_futility 6.67
 tools_binman_btool_ifwitool 3.81
-tools_binman_btool_lz4 6.30
+tools_binman_btool_lz4 4.76
 tools_binman_btool_lzma_alone 6.97
-tools_binman_btool_mkimage 7.86
-tools_binman_cbfs_util 8.46
-tools_binman_cbfs_util_test 9.38
-tools_binman_cmdline 9.03
-tools_binman_comp_util 6.88
-tools_binman_control 5.01
-tools_binman_elf 6.98
-tools_binman_elf_test 5.62
-tools_binman_entry 3.55
-tools_binman_entry_test 5.34
-tools_binman_etype__testing 0.83
-tools_binman_etype_atf_bl31 -6.00
-tools_binman_etype_atf_fip 0.29
-tools_binman_etype_blob -1.58
-tools_binman_etype_blob_dtb -10.00
-tools_binman_etype_blob_ext -19.09
+tools_binman_btool_lzop 0.00
+tools_binman_btool_mkeficapsule 7.69
+tools_binman_btool_mkimage 6.36
+tools_binman_btool_openssl 4.63
+tools_binman_btool_xz 0.00
+tools_binman_btool_zstd 0.00
+tools_binman_cbfs_util 8.93
+tools_binman_cbfs_util_test 9.81
+tools_binman_cmdline 9.33
+tools_binman_control 6.92
+tools_binman_elf 7.52
+tools_binman_elf_test 8.40
+tools_binman_entry 6.40
+tools_binman_entry_test 6.99
+tools_binman_etype__testing 2.02
+tools_binman_etype_alternates_fdt 5.09
+tools_binman_etype_atf_bl31 0.00
+tools_binman_etype_atf_fip 0.44
+tools_binman_etype_blob 0.41
+tools_binman_etype_blob_dtb 0.21
+tools_binman_etype_blob_ext 0.00
 tools_binman_etype_blob_ext_list 0.00
-tools_binman_etype_blob_named_by_arg -7.78
-tools_binman_etype_blob_phase -5.00
-tools_binman_etype_cbfs -1.44
+tools_binman_etype_blob_named_by_arg 0.00
+tools_binman_etype_blob_phase 0.50
+tools_binman_etype_cbfs 1.86
 tools_binman_etype_collection 2.67
-tools_binman_etype_cros_ec_rw -6.00
-tools_binman_etype_fdtmap -3.28
-tools_binman_etype_files -7.43
-tools_binman_etype_fill -6.43
-tools_binman_etype_fit 6.31
-tools_binman_etype_fmap -0.29
-tools_binman_etype_gbb 0.83
-tools_binman_etype_image_header 5.77
-tools_binman_etype_intel_cmc -12.50
+tools_binman_etype_cros_ec_rw 0.00
+tools_binman_etype_efi_capsule 3.33
+tools_binman_etype_efi_empty_capsule 0.00
+tools_binman_etype_encrypted 1.43
+tools_binman_etype_fdtmap 0.16
+tools_binman_etype_files 0.00
+tools_binman_etype_fill 0.00
+tools_binman_etype_fit 7.52
+tools_binman_etype_fmap 0.54
+tools_binman_etype_gbb 1.35
+tools_binman_etype_image_header 4.81
+tools_binman_etype_intel_cmc 0.00
 tools_binman_etype_intel_descriptor 4.62
 tools_binman_etype_intel_fit 0.00
 tools_binman_etype_intel_fit_ptr 2.35
-tools_binman_etype_intel_fsp -12.50
-tools_binman_etype_intel_fsp_m -12.50
-tools_binman_etype_intel_fsp_s -12.50
-tools_binman_etype_intel_fsp_t -12.50
-tools_binman_etype_intel_ifwi 2.88
-tools_binman_etype_intel_me -12.50
-tools_binman_etype_intel_mrc -10.00
-tools_binman_etype_intel_refcode -10.00
-tools_binman_etype_intel_vbt -12.50
-tools_binman_etype_intel_vga -12.50
-tools_binman_etype_mkimage 1.47
-tools_binman_etype_opensbi -6.00
-tools_binman_etype_powerpc_mpc85xx_bootpg_resetvec -10.00
-tools_binman_etype_scp -6.00
-tools_binman_etype_section 4.57
-tools_binman_etype_tee_os -6.00
-tools_binman_etype_text -0.48
-tools_binman_etype_u_boot -15.71
-tools_binman_etype_u_boot_dtb -12.22
-tools_binman_etype_u_boot_dtb_with_ucode 0.39
-tools_binman_etype_u_boot_elf -8.42
+tools_binman_etype_intel_fsp 0.00
+tools_binman_etype_intel_fsp_m 0.00
+tools_binman_etype_intel_fsp_s 0.00
+tools_binman_etype_intel_fsp_t 0.00
+tools_binman_etype_intel_ifwi 3.13
+tools_binman_etype_intel_me 0.00
+tools_binman_etype_intel_mrc 0.00
+tools_binman_etype_intel_refcode 0.00
+tools_binman_etype_intel_vbt 0.00
+tools_binman_etype_intel_vga 0.00
+tools_binman_etype_mkimage 4.88
+tools_binman_etype_null 0.00
+tools_binman_etype_nxp_imx8mcst 2.44
+tools_binman_etype_nxp_imx8mimage 0.00
+tools_binman_etype_opensbi 0.00
+tools_binman_etype_powerpc_mpc85xx_bootpg_resetvec 0.00
+tools_binman_etype_pre_load 3.68
+tools_binman_etype_rockchip_tpl 0.00
+tools_binman_etype_scp 0.00
+tools_binman_etype_section 6.04
+tools_binman_etype_tee_os 4.00
+tools_binman_etype_text 0.00
+tools_binman_etype_ti_board_config 5.40
+tools_binman_etype_ti_dm 0.00
+tools_binman_etype_ti_secure 4.22
+tools_binman_etype_ti_secure_rom 2.22
+tools_binman_etype_u_boot 0.00
+tools_binman_etype_u_boot_dtb 0.00
+tools_binman_etype_u_boot_dtb_with_ucode 1.73
+tools_binman_etype_u_boot_elf 0.00
 tools_binman_etype_u_boot_env 0.74
-tools_binman_etype_u_boot_expanded -10.00
-tools_binman_etype_u_boot_img -15.71
-tools_binman_etype_u_boot_nodtb -15.71
-tools_binman_etype_u_boot_spl -10.91
-tools_binman_etype_u_boot_spl_bss_pad -9.29
-tools_binman_etype_u_boot_spl_dtb -12.22
-tools_binman_etype_u_boot_spl_elf -15.71
-tools_binman_etype_u_boot_spl_expanded -9.09
-tools_binman_etype_u_boot_spl_nodtb -10.91
-tools_binman_etype_u_boot_spl_with_ucode_ptr -5.00
-tools_binman_etype_u_boot_tpl -10.91
-tools_binman_etype_u_boot_tpl_bss_pad -9.29
-tools_binman_etype_u_boot_tpl_dtb -12.22
-tools_binman_etype_u_boot_tpl_dtb_with_ucode -7.50
-tools_binman_etype_u_boot_tpl_elf -15.71
-tools_binman_etype_u_boot_tpl_expanded -9.09
-tools_binman_etype_u_boot_tpl_nodtb -10.91
-tools_binman_etype_u_boot_tpl_with_ucode_ptr -20.83
+tools_binman_etype_u_boot_expanded 0.00
+tools_binman_etype_u_boot_img 0.00
+tools_binman_etype_u_boot_nodtb 0.00
+tools_binman_etype_u_boot_spl 0.00
+tools_binman_etype_u_boot_spl_bss_pad 0.00
+tools_binman_etype_u_boot_spl_dtb 0.00
+tools_binman_etype_u_boot_spl_elf 0.00
+tools_binman_etype_u_boot_spl_expanded 0.00
+tools_binman_etype_u_boot_spl_nodtb 0.00
+tools_binman_etype_u_boot_spl_pubkey_dtb 1.21
+tools_binman_etype_u_boot_spl_with_ucode_ptr 0.00
+tools_binman_etype_u_boot_tpl 0.00
+tools_binman_etype_u_boot_tpl_bss_pad 0.00
+tools_binman_etype_u_boot_tpl_dtb 0.00
+tools_binman_etype_u_boot_tpl_dtb_with_ucode 0.00
+tools_binman_etype_u_boot_tpl_elf 0.00
+tools_binman_etype_u_boot_tpl_expanded 0.00
+tools_binman_etype_u_boot_tpl_nodtb 0.00
+tools_binman_etype_u_boot_tpl_with_ucode_ptr 0.00
 tools_binman_etype_u_boot_ucode 1.52
-tools_binman_etype_u_boot_with_ucode_ptr -0.71
-tools_binman_etype_vblock 0.27
-tools_binman_etype_x86_reset16 -15.71
-tools_binman_etype_x86_reset16_spl -15.71
-tools_binman_etype_x86_reset16_tpl -15.71
-tools_binman_etype_x86_start16 -15.71
-tools_binman_etype_x86_start16_spl -15.71
-tools_binman_etype_x86_start16_tpl -15.71
-tools_binman_fdt_test 10.00
+tools_binman_etype_u_boot_vpl 0.00
+tools_binman_etype_u_boot_vpl_bss_pad 0.00
+tools_binman_etype_u_boot_vpl_dtb 0.00
+tools_binman_etype_u_boot_vpl_elf 0.00
+tools_binman_etype_u_boot_vpl_expanded 0.00
+tools_binman_etype_u_boot_vpl_nodtb 0.00
+tools_binman_etype_u_boot_with_ucode_ptr 0.00
+tools_binman_etype_vblock 0.79
+tools_binman_etype_x509_cert 3.10
+tools_binman_etype_x86_reset16 0.00
+tools_binman_etype_x86_reset16_spl 0.00
+tools_binman_etype_x86_reset16_tpl 0.00
+tools_binman_etype_x86_start16 0.00
+tools_binman_etype_x86_start16_spl 0.00
+tools_binman_etype_x86_start16_tpl 0.00
+tools_binman_etype_xilinx_bootgen 6.06
+tools_binman_fdt_test 7.74
 tools_binman_fip_util 9.85
 tools_binman_fip_util_test 10.00
-tools_binman_fmap_util 6.88
-tools_binman_ftest 7.46
-tools_binman_image 7.12
-tools_binman_image_test 4.48
-tools_binman_main 4.86
-tools_binman_setup 5.00
-tools_binman_state 4.15
-tools_buildman_board 7.82
-tools_buildman_bsettings 1.71
-tools_buildman_builder 6.92
-tools_buildman_builderthread 7.48
-tools_buildman_cfgutil 7.83
-tools_buildman_cmdline 8.89
-tools_buildman_control 8.12
-tools_buildman_func_test 7.18
-tools_buildman_kconfiglib 7.49
-tools_buildman_main -1.11
-tools_buildman_test 6.56
-tools_buildman_toolchain 6.44
-tools_concurrencytest_concurrencytest 7.26
-tools_dtoc_dtb_platdata 7.90
-tools_dtoc_fdt 4.46
-tools_dtoc_fdt_util 6.80
-tools_dtoc_main 7.78
-tools_dtoc_setup 5.00
-tools_dtoc_src_scan 8.91
-tools_dtoc_test_dtoc 8.56
-tools_dtoc_test_fdt 6.88
-tools_dtoc_test_src_scan 9.43
-tools_efivar 6.71
+tools_binman_fmap_util 6.94
+tools_binman_ftest 8.04
+tools_binman_image 7.29
+tools_binman_image_test 5.52
+tools_binman_main 5.63
+tools_binman_setup 0.00
+tools_binman_state 4.88
+tools_buildman_board 6.36
+tools_buildman_boards 9.72
+tools_buildman_bsettings 5.00
+tools_buildman_builder 7.66
+tools_buildman_builderthread 9.63
+tools_buildman_cfgutil 10.00
+tools_buildman_cmdline 10.00
+tools_buildman_control 9.26
+tools_buildman_func_test 8.38
+tools_buildman_kconfiglib 8.33
+tools_buildman_main 8.10
+tools_buildman_test 7.16
+tools_buildman_toolchain 6.99
+tools_dtoc_dtb_platdata 8.10
+tools_dtoc_fdt 6.31
+tools_dtoc_fdt_util 7.62
+tools_dtoc_main 8.54
+tools_dtoc_setup 0.00
+tools_dtoc_src_scan 9.14
+tools_dtoc_test_dtoc 8.97
+tools_dtoc_test_fdt 9.93
+tools_dtoc_test_src_scan 9.46
+tools_efivar 7.39
 tools_endian-swap 9.29
-tools_microcode-tool 7.25
-tools_moveconfig 8.34
+tools_expo 9.72
+tools_key2dtsi 7.14
+tools_microcode-tool 6.55
 tools_patman___init__ 0.00
-tools_patman_checkpatch 8.48
-tools_patman_command 5.51
-tools_patman_commit 4.50
-tools_patman_control 8.14
-tools_patman_cros_subprocess 7.76
-tools_patman_func_test 8.51
-tools_patman_get_maintainer 7.06
-tools_patman_gitutil 6.65
-tools_patman_main 7.90
-tools_patman_patchstream 9.11
+tools_patman___main__ 9.44
+tools_patman_checkpatch 8.90
+tools_patman_cmdline 10.00
+tools_patman_commit 6.43
+tools_patman_control 8.29
+tools_patman_func_test 9.02
+tools_patman_get_maintainer 7.50
+tools_patman_gitutil 7.37
+tools_patman_patchstream 9.21
 tools_patman_project 7.78
-tools_patman_series 6.16
-tools_patman_settings 5.89
+tools_patman_series 7.54
+tools_patman_settings 7.94
 tools_patman_setup 5.00
-tools_patman_status 8.62
-tools_patman_terminal 8.00
-tools_patman_test_checkpatch 7.75
-tools_patman_test_util 7.64
-tools_patman_tools 5.68
-tools_patman_tout 5.31
-tools_rkmux 6.90
-tools_rmboard 7.76
+tools_patman_status 8.52
+tools_patman_test_checkpatch 8.51
+tools_patman_test_settings 8.78
+tools_qconfig 9.79
+tools_rkmux 7.10
+tools_rmboard 8.06
+tools_u_bootlib___init__.py 0.00
+tools_u_bootlib___main__.py 7.78
+tools_u_bootlib_command.py 6.48
+tools_u_bootlib_cros_subprocess.py 9.25
+tools_u_bootlib_terminal.py 8.50
+tools_u_bootlib_test_util.py 7.31
+tools_u_bootlib_tools.py 6.97
+tools_u_bootlib_tout.py 6.56
 tools_zynqmp_pm_cfg_obj_convert 6.67
-- 
2.34.1

