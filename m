Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6A1C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0BE80C83;
	Sun,  9 Feb 2025 17:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PrS3Tyke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0435C80A0A; Sun,  9 Feb 2025 17:07:38 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3915680821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d144f1f68bso7227205ab.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739117253; x=1739722053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YmKtnQHKRholwFHa+YijHKNOUVC3AK/Ojbuy6b4kkqY=;
 b=PrS3Tyke44VkRnl6Dad7haCT75dbGDdbeTPvZwpXUYfgkp6nmbishGbDVX+CClPeib
 t/oSr5clZJWC/h68mZ9FWo97iWYGMOE1d6wV7L3pPQh8Er4KnzVGlpi3MO147BSI3Znc
 X+2OXsLxE+0haXy3Gijv9sYSaf0iygJ7eMhcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739117253; x=1739722053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmKtnQHKRholwFHa+YijHKNOUVC3AK/Ojbuy6b4kkqY=;
 b=DLmxLuQeZmwszZwtxFGSzYNnuz+fpTl0gOcg8sYLSQAy7dI97YSY96SfR+9uaU4dQP
 PwjmjvBhCfjbt1wFIz0JqKfOvXT0pCReFNcrVSvWENC3SxXfLrf21xPdVWDGP8S6ak6b
 YxtV3Eig/5p+6gfxctzvoOLtvEmDkrMN7/KryPgH/BwBsyejfZFRgoCsejv9CtvV6+aU
 y2J1f6vEYff6S0rxIIbjCjKHmue78cZ9VAx2U6y7z6VGFCx0tcj5cxwkNYVs9SPWwUam
 fXVAuLOEQXvGa/obub79UAOQCzpsjJYcDyBq61C5TuBc6OOgsGtL+rNfRO0B462xP+hH
 IMQw==
X-Gm-Message-State: AOJu0YzVWn3RvJlHweErQP0U1bKJHGHnE0EGMxKhNq5jl1tGuAB3decs
 Q7fOT2B0o2TOXs5PVL/KKWsq0KVD7stibfytDBHQTrJ/Nud8wzxDK9MPXfjMqge9ELC+4ty8vwY
 =
X-Gm-Gg: ASbGnctJqhi/kjYt88/uUAzBUvzimDad7OKsWCgm0nIfhcjzfS7nQvgcu6YaZflsqja
 yl6yPnfDAL1OZtes6LTmFBL6Uhaw3QvFFzfrHxcv3UxqNBNEbRgeQ4TepFvlC5glI4Y2IM7wI4X
 LDTp92JpFCVRCR+DkGDwcc7qOxbBsGRrGyHPtS5n0WGFpjjw8BwOLqH+l9+fx6VBaWIgInKNtgD
 VqesojKQkfDGKxY6JCSQ1yIXepCwoXChqB7GhrNetTFQ5UnVCJmh9s1Cx2bQnZVcZQJr13rz/ga
 AJIrS8JK/xgR3ujRaJ4ZprIEQlY8MAQz3bwwi+5fJLM7E2d24cHH
X-Google-Smtp-Source: AGHT+IG3WOLuUmqaJl4Dj7D8rhctPByaR/qlOW1MhO5fhmcUrHAa6o6oERw+alIUyc5RPI+em+Y4Kg==
X-Received: by 2002:a05:6e02:1a23:b0:3d0:10ec:cc36 with SMTP id
 e9e14a558f8ab-3d13dd3bce4mr67029865ab.11.1739117253370; 
 Sun, 09 Feb 2025 08:07:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ecf2d08b0dsm354812173.59.2025.02.09.08.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:07:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huang Jianan <jnhuang95@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Richard Weinberger <richard@nod.at>,
 Roger Knecht <rknecht@pm.me>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Weizhao Ouyang <o451686892@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/6] test: A few quality-of-life improvements
Date: Sun,  9 Feb 2025 09:07:13 -0700
Message-ID: <20250209160725.1054845-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Feb 2025 17:33:22 +0100
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

This little series includes a few patches to make it easier to work with
the Python tests, by shortening identifiers and renaming the 'console'
fixture to reflect its role as the top-level fixture.

It also adds a command to fix testing on samus_tpl

This series is based on the previous 'test' series[1]

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=441124

Changes in v2:
- Use 'ubman' instead
- Add new patch to drop importing utils as util
- Add new patch to drop assigning ubman to cons

Simon Glass (6):
  test/py: Shorten u_boot_console
  test/py: Drop u_boot_ prefix on test files
  test/py: Drop importing utils as util
  test/py: Drop assigning ubman to cons
  test/py: Show info about module-loading
  test: Make net tests depend on CONFIG_CMD_NET

 doc/develop/py_testing.rst                    |  16 +-
 doc/develop/tests_writing.rst                 |  12 +-
 test/py/conftest.py                           |  89 +++---
 ...u_boot_console_base.py => console_base.py} |   8 +-
 ...onsole_exec_attach.py => console_board.py} |   6 +-
 ..._console_sandbox.py => console_sandbox.py} |   8 +-
 test/py/{u_boot_spawn.py => spawn.py}         |   0
 test/py/tests/fit_util.py                     |  42 +--
 test/py/tests/test_000_version.py             |   8 +-
 test/py/tests/test_android/test_ab.py         |  48 +--
 test/py/tests/test_android/test_abootimg.py   | 133 +++++----
 test/py/tests/test_android/test_avb.py        |  49 ++-
 test/py/tests/test_bind.py                    |  72 ++---
 test/py/tests/test_bootmenu.py                |  46 +--
 test/py/tests/test_bootstage.py               |  18 +-
 test/py/tests/test_button.py                  |  16 +-
 test/py/tests/test_cat/test_cat.py            |   6 +-
 test/py/tests/test_dfu.py                     |  54 ++--
 test/py/tests/test_dm.py                      |  28 +-
 .../test_efi_bootmgr/test_efi_bootmgr.py      |  34 +--
 .../tests/test_efi_capsule/capsule_common.py  |  60 ++--
 .../test_capsule_firmware_fit.py              | 100 +++----
 .../test_capsule_firmware_raw.py              | 126 ++++----
 .../test_capsule_firmware_signed_fit.py       | 104 +++----
 .../test_capsule_firmware_signed_raw.py       | 104 +++----
 test/py/tests/test_efi_fit.py                 |  93 +++---
 test/py/tests/test_efi_loader.py              |  84 +++---
 .../py/tests/test_efi_secboot/test_authvar.py | 120 ++++----
 test/py/tests/test_efi_secboot/test_signed.py | 148 ++++-----
 .../test_efi_secboot/test_signed_intca.py     |  46 +--
 .../tests/test_efi_secboot/test_unsigned.py   |  42 +--
 test/py/tests/test_efi_selftest.py            | 180 +++++------
 .../py/tests/test_eficonfig/test_eficonfig.py | 106 +++----
 test/py/tests/test_env.py                     |  82 +++--
 test/py/tests/test_event_dump.py              |   9 +-
 test/py/tests/test_extension.py               |  32 +-
 test/py/tests/test_fit.py                     |  67 +++--
 test/py/tests/test_fit_auto_signed.py         |  35 ++-
 test/py/tests/test_fit_ecdsa.py               |  31 +-
 test/py/tests/test_fit_hashes.py              |  29 +-
 test/py/tests/test_fpga.py                    | 280 +++++++++---------
 test/py/tests/test_fs/conftest.py             |   1 -
 test/py/tests/test_fs/test_basic.py           | 104 +++----
 test/py/tests/test_fs/test_erofs.py           |  76 ++---
 test/py/tests/test_fs/test_ext.py             | 124 ++++----
 test/py/tests/test_fs/test_fs_cmd.py          |   4 +-
 test/py/tests/test_fs/test_fs_fat.py          |   6 +-
 test/py/tests/test_fs/test_mkdir.py           |  48 +--
 .../test_fs/test_squashfs/test_sqfs_load.py   |  54 ++--
 .../test_fs/test_squashfs/test_sqfs_ls.py     |  64 ++--
 test/py/tests/test_fs/test_symlink.py         |  46 +--
 test/py/tests/test_fs/test_unlink.py          |  50 ++--
 test/py/tests/test_gpio.py                    | 106 +++----
 test/py/tests/test_gpt.py                     | 178 +++++------
 test/py/tests/test_handoff.py                 |   5 +-
 test/py/tests/test_help.py                    |  28 +-
 test/py/tests/test_i2c.py                     |  44 +--
 test/py/tests/test_kconfig.py                 |  16 +-
 test/py/tests/test_log.py                     |  20 +-
 test/py/tests/test_lsblk.py                   |   4 +-
 test/py/tests/test_md.py                      |  22 +-
 test/py/tests/test_mdio.py                    |  32 +-
 test/py/tests/test_memtest.py                 |  26 +-
 test/py/tests/test_mii.py                     |  50 ++--
 test/py/tests/test_mmc.py                     | 156 +++++-----
 test/py/tests/test_mmc_rd.py                  |  54 ++--
 test/py/tests/test_mmc_wr.py                  |  20 +-
 test/py/tests/test_net.py                     | 142 ++++-----
 test/py/tests/test_net_boot.py                | 144 ++++-----
 test/py/tests/test_of_migrate.py              |  43 ++-
 test/py/tests/test_ofplatdata.py              |  11 +-
 test/py/tests/test_optee_rpmb.py              |  10 +-
 test/py/tests/test_part.py                    |   4 +-
 test/py/tests/test_pinmux.py                  |  32 +-
 test/py/tests/test_pstore.py                  |  48 +--
 test/py/tests/test_qfw.py                     |   8 +-
 test/py/tests/test_reset.py                   |  24 +-
 test/py/tests/test_sandbox_exit.py            |  28 +-
 test/py/tests/test_sandbox_opts.py            |  16 +-
 test/py/tests/test_saveenv.py                 |  70 ++---
 test/py/tests/test_scp03.py                   |   8 +-
 test/py/tests/test_scsi.py                    |  48 +--
 test/py/tests/test_semihosting/test_hostfs.py |  14 +-
 test/py/tests/test_sf.py                      |  66 ++---
 test/py/tests/test_shell_basics.py            |  30 +-
 test/py/tests/test_sleep.py                   |  26 +-
 test/py/tests/test_smbios.py                  |  12 +-
 test/py/tests/test_source.py                  |  45 ++-
 test/py/tests/test_spi.py                     | 242 +++++++--------
 test/py/tests/test_spl.py                     |  15 +-
 test/py/tests/test_stackprotector.py          |   8 +-
 test/py/tests/test_suite.py                   |  68 ++---
 test/py/tests/test_tpm2.py                    | 194 ++++++------
 test/py/tests/test_trace.py                   |  69 +++--
 test/py/tests/test_ums.py                     |  48 +--
 test/py/tests/test_unknown_cmd.py             |   6 +-
 test/py/tests/test_upl.py                     |  15 +-
 test/py/tests/test_usb.py                     | 206 ++++++-------
 test/py/tests/test_ut.py                      | 224 +++++++-------
 test/py/tests/test_vbe.py                     |  17 +-
 test/py/tests/test_vbe_vpl.py                 |  33 +--
 test/py/tests/test_vboot.py                   | 188 ++++++------
 test/py/tests/test_vpl.py                     |  11 +-
 test/py/tests/test_xxd/test_xxd.py            |   6 +-
 test/py/tests/test_zynq_secure.py             |  96 +++---
 test/py/tests/test_zynqmp_rpu.py              | 106 +++----
 test/py/tests/test_zynqmp_secure.py           |  42 +--
 test/py/{u_boot_utils.py => utils.py}         |  44 +--
 108 files changed, 3180 insertions(+), 3196 deletions(-)
 rename test/py/{u_boot_console_base.py => console_base.py} (99%)
 rename test/py/{u_boot_console_exec_attach.py => console_board.py} (95%)
 rename test/py/{u_boot_console_sandbox.py => console_sandbox.py} (93%)
 rename test/py/{u_boot_spawn.py => spawn.py} (100%)
 rename test/py/{u_boot_utils.py => utils.py} (89%)

-- 
2.43.0

