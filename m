Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8278C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 12:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEAA880C93;
	Sat, 15 Mar 2025 13:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RZkL/G0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1308580ECC; Sat, 15 Mar 2025 13:45:06 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CEE808A2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 13:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so3818877a12.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742042701; x=1742647501; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qgsxVVVdkN3oWaISZmMXsv+77ulndW8BdW9IczsbNYM=;
 b=RZkL/G0GD4IpeS0/tslN5RVcxZys5d5zcy+mdQQ5ZARp/MhzQUsrV/2GIMX1ZI9gg9
 yHqWpON/nqsoaDrPauLmbjtwDZj8K4au5KYz7w20oL4yYOS9ryNOsSN7L14B8f03aV4V
 OqzZoip7l3L7o3ejtf/na5Vel+RRgyTv0R3xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742042701; x=1742647501;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qgsxVVVdkN3oWaISZmMXsv+77ulndW8BdW9IczsbNYM=;
 b=O5N6Ir6n0d6YnjjfdgTCV/nEbXqUZiGLF6cq3hyD9Hnn/yLMg1jTtZMYVLdST7SrxG
 K4u6pOXPRGygrQuk+sZBouTIVu1lCBrtVCTMife5elOWKJbjju/3NRZKRPabi2B921RO
 fggTpQLf0MKhHij3h+sG5q7dHZ0t+QJeCGC+cDE0gJ5Cw4W/QAPFYrYRaEf+f2Jy1tJi
 8NVL9UYtirK1yP93Adq2pc8CJQSoyTfoWfJrEBAOJw8V8qOAqC6OcjhOfQjRmzW2bORK
 jC/XkpMzMgXc6DFHNNS8you9YrFZx2k77gF6hn5ViSpgMVyMIxL2pAXKlWWIiNqtG1Hl
 ZLtw==
X-Gm-Message-State: AOJu0YxX+fKj1jUs6TN3JikmfWto6rnbnVQ5iOcKXuU9OcJj91WVzif9
 1ZecqTaE3S737vLLLYXBMf3LFMi0rPmNiADuJbcrjERw/iv8pTdDGghGla+P3mvaz4mju2rIhrH
 CcclttvPwT9TmkE86dWqBnNvHHvY0KspkinRZgJBVhghPuCLehSWq
X-Gm-Gg: ASbGncu0dSe66084WZkEbJAG1kXcx51wY00a6e9AUaaa7AvmJxMh9w91Uj6H4vc78yf
 Rdgd0YUyK+ykzEgjxAOzX67FhnHBz2wc+d7HDB5r6o3HWlxOUPuagcl0qFgVNJEBSUTc1A6W+Xl
 nRbmj2LW6OXQVL7CIXiE8mStoDQhxQMI/CCVKB0w==
X-Google-Smtp-Source: AGHT+IHlRL0UwKraLRBPvgzNmpNVT3xnFKrAD1w4XQf2wewE77FksgiqJsQISIxhEpHM9QxuLCX+pay/dPqNqzT+0jo=
X-Received: by 2002:a05:6402:40c4:b0:5dc:c531:e5c0 with SMTP id
 4fb4d7f45d1cf-5e8a09faca8mr6612205a12.27.1742042701538; Sat, 15 Mar 2025
 05:45:01 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 12:44:50 +0000
X-Gm-Features: AQ5f1Jobwdf2ZaS0EW6VDxu_Bc0YTgKR9qVS-YW3HmydaMaynoN2g81UHqQhZGE
Message-ID: <CAFLszTiy_23MXgSB4U8P5WyDxM-AKu6wO=4G+u1Wv6P6YpPvPw@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

Here is my attempt to get the test-rename stuff landed in your tree.
If you would rather do another round of patches, PTML.


https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/25171

The following changes since commit 00dfb7038ea4dfe9d9667143bfecd11c05cab6fa:

  Merge patch series "Enable USB MSC Boot for AM62, AM62A and AM62P"
(2025-03-14 14:36:18 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-15mar25

for you to fetch changes up to 13e8d14442a85a8556211a9950a5b6f80b447901:

  test: Make net tests depend on CONFIG_CMD_NET (2025-03-15 11:47:05 +0000)

----------------------------------------------------------------
Sync up on test renames

----------------------------------------------------------------
Simon Glass (6):
      test/py: Shorten u_boot_console
      test/py: Drop u_boot_ prefix on test files
      test/py: Drop importing utils as util
      test/py: Drop assigning ubman to cons
      test/py: Show info about module-loading
      test: Make net tests depend on CONFIG_CMD_NET

 README                                                             |   2 +-
 doc/develop/py_testing.rst                                         |  16 +-
 doc/develop/tests_writing.rst                                      |  12 +-
 test/py/conftest.py                                                |
89 +++++-----
 test/py/{u_boot_console_base.py => console_base.py}                |   8 +-
 test/py/{u_boot_console_exec_attach.py => console_board.py}        |   6 +-
 test/py/{u_boot_console_sandbox.py => console_sandbox.py}          |   8 +-
 test/py/{u_boot_spawn.py => spawn.py}                              |   0
 test/py/tests/fit_util.py                                          |  42 ++---
 test/py/tests/test_000_version.py                                  |   8 +-
 test/py/tests/test_android/test_ab.py                              |  48 +++---
 test/py/tests/test_android/test_abootimg.py                        |
133 ++++++++-------
 test/py/tests/test_android/test_avb.py                             |  49 +++---
 test/py/tests/test_bind.py                                         |
72 ++++----
 test/py/tests/test_bootmenu.py                                     |  46 ++---
 test/py/tests/test_bootstage.py                                    |  18 +-
 test/py/tests/test_button.py                                       |  16 +-
 test/py/tests/test_cat/test_cat.py                                 |   6 +-
 test/py/tests/test_dfu.py                                          |  54 +++---
 test/py/tests/test_dm.py                                           |  28 ++--
 test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py                 |  34 ++--
 test/py/tests/test_efi_capsule/capsule_common.py                   |
60 +++----
 test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py        |
100 +++++------
 test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py        |
126 +++++++-------
 test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py |
104 ++++++------
 test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py |
104 ++++++------
 test/py/tests/test_efi_fit.py                                      |
93 +++++-----
 test/py/tests/test_efi_loader.py                                   |
84 +++++-----
 test/py/tests/test_efi_secboot/test_authvar.py                     |
120 ++++++-------
 test/py/tests/test_efi_secboot/test_signed.py                      |
148 ++++++++--------
 test/py/tests/test_efi_secboot/test_signed_intca.py                |  46 ++---
 test/py/tests/test_efi_secboot/test_unsigned.py                    |  42 ++---
 test/py/tests/test_efi_selftest.py                                 |
180 ++++++++++----------
 test/py/tests/test_eficonfig/test_eficonfig.py                     |
106 ++++++------
 test/py/tests/test_env.py                                          |
82 +++++----
 test/py/tests/test_event_dump.py                                   |   9 +-
 test/py/tests/test_extension.py                                    |  32 ++--
 test/py/tests/test_fit.py                                          |
67 ++++----
 test/py/tests/test_fit_auto_signed.py                              |  35 ++--
 test/py/tests/test_fit_ecdsa.py                                    |  31 ++--
 test/py/tests/test_fit_hashes.py                                   |  29 ++--
 test/py/tests/test_fpga.py                                         |
280 +++++++++++++++----------------
 test/py/tests/test_fs/conftest.py                                  |   1 -
 test/py/tests/test_fs/test_basic.py                                |
104 ++++++------
 test/py/tests/test_fs/test_erofs.py                                |
76 ++++-----
 test/py/tests/test_fs/test_ext.py                                  |
124 +++++++-------
 test/py/tests/test_fs/test_fs_cmd.py                               |   4 +-
 test/py/tests/test_fs/test_fs_fat.py                               |   6 +-
 test/py/tests/test_fs/test_mkdir.py                                |  48 +++---
 test/py/tests/test_fs/test_rename.py                               |
132 +++++++--------
 test/py/tests/test_fs/test_squashfs/test_sqfs_load.py              |  54 +++---
 test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py                |
64 +++----
 test/py/tests/test_fs/test_symlink.py                              |  46 ++---
 test/py/tests/test_fs/test_unlink.py                               |  50 +++---
 test/py/tests/test_gpio.py                                         |
106 ++++++------
 test/py/tests/test_gpt.py                                          |
178 ++++++++++----------
 test/py/tests/test_handoff.py                                      |   5 +-
 test/py/tests/test_help.py                                         |  28 ++--
 test/py/tests/test_i2c.py                                          |  44 ++---
 test/py/tests/test_kconfig.py                                      |  16 +-
 test/py/tests/test_log.py                                          |  20 +--
 test/py/tests/test_lsblk.py                                        |   4 +-
 test/py/tests/test_md.py                                           |  22 +--
 test/py/tests/test_mdio.py                                         |  32 ++--
 test/py/tests/test_memtest.py                                      |  26 +--
 test/py/tests/test_mii.py                                          |  50 +++---
 test/py/tests/test_mmc.py                                          |
156 ++++++++---------
 test/py/tests/test_mmc_rd.py                                       |  54 +++---
 test/py/tests/test_mmc_wr.py                                       |  20 +--
 test/py/tests/test_net.py                                          |
142 ++++++++--------
 test/py/tests/test_net_boot.py                                     |
144 ++++++++--------
 test/py/tests/test_of_migrate.py                                   |  43 +++--
 test/py/tests/test_ofplatdata.py                                   |  11 +-
 test/py/tests/test_optee_rpmb.py                                   |  10 +-
 test/py/tests/test_part.py                                         |   4 +-
 test/py/tests/test_pinmux.py                                       |  32 ++--
 test/py/tests/test_pstore.py                                       |  48 +++---
 test/py/tests/test_qfw.py                                          |   8 +-
 test/py/tests/test_reset.py                                        |  24 +--
 test/py/tests/test_sandbox_exit.py                                 |  28 ++--
 test/py/tests/test_sandbox_opts.py                                 |  16 +-
 test/py/tests/test_saveenv.py                                      |
70 ++++----
 test/py/tests/test_scp03.py                                        |   8 +-
 test/py/tests/test_scsi.py                                         |  48 +++---
 test/py/tests/test_semihosting/test_hostfs.py                      |  14 +-
 test/py/tests/test_sf.py                                           |
66 ++++----
 test/py/tests/test_shell_basics.py                                 |  30 ++--
 test/py/tests/test_sleep.py                                        |  26 +--
 test/py/tests/test_smbios.py                                       |  16 +-
 test/py/tests/test_source.py                                       |  45 +++--
 test/py/tests/test_spi.py                                          |
242 +++++++++++++-------------
 test/py/tests/test_spl.py                                          |  15 +-
 test/py/tests/test_stackprotector.py                               |   8 +-
 test/py/tests/test_suite.py                                        |
71 ++++----
 test/py/tests/test_tpm2.py                                         |
194 ++++++++++-----------
 test/py/tests/test_trace.py                                        |
81 +++++----
 test/py/tests/test_ums.py                                          |  49 +++---
 test/py/tests/test_unknown_cmd.py                                  |   6 +-
 test/py/tests/test_upl.py                                          |  15 +-
 test/py/tests/test_usb.py                                          |
206 +++++++++++------------
 test/py/tests/test_ut.py                                           |
224 ++++++++++++-------------
 test/py/tests/test_vbe.py                                          |  17 +-
 test/py/tests/test_vbe_vpl.py                                      |  33 ++--
 test/py/tests/test_vboot.py                                        |
188 ++++++++++-----------
 test/py/tests/test_vpl.py                                          |  11 +-
 test/py/tests/test_xxd/test_xxd.py                                 |   6 +-
 test/py/tests/test_zynq_secure.py                                  |
96 +++++------
 test/py/tests/test_zynqmp_rpu.py                                   |
100 +++++------
 test/py/tests/test_zynqmp_secure.py                                |  42 ++---
 test/py/{u_boot_utils.py => utils.py}                              |  44 ++---
 110 files changed, 3253 insertions(+), 3271 deletions(-)
 rename test/py/{u_boot_console_base.py => console_base.py} (99%)
 rename test/py/{u_boot_console_exec_attach.py => console_board.py} (95%)
 rename test/py/{u_boot_console_sandbox.py => console_sandbox.py} (93%)
 rename test/py/{u_boot_spawn.py => spawn.py} (100%)
 rename test/py/{u_boot_utils.py => utils.py} (89%)

Regards,
Simon
