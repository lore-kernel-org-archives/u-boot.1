Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E12C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E0C80C91;
	Sat, 25 Jan 2025 22:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QiP+QnCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D30380C7E; Sat, 25 Jan 2025 22:32:05 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FAC2807FE
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-844ee166150so76541739f.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737840720; x=1738445520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yf3pCEV9tCLtFdnGlAC8rzndkMCZW32M1Efyq/TNnW4=;
 b=QiP+QnCaxhzjHlwz0zsrIyr3JCKfV3JmEjpqWWF/8fcxcUJwdc3iWdeBzaOfBkp89/
 I9jbTkSw1TmBh229JlXRy8aAhTtLizqtk9R41oqyBulVEcp8O41gHkfIUxgfnzTjLU2Q
 VGMqsm1pOM7U/1uZsopBydMaP/LVGYI6otQfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737840720; x=1738445520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yf3pCEV9tCLtFdnGlAC8rzndkMCZW32M1Efyq/TNnW4=;
 b=oJ+09vrLKvFWzi0z+3lOH3VAFmrv7oAOGNBOLxdfwheF95jAA8e9s+KfGKenxRwAFc
 raxCY55i+2gbZiiYU6/Out4+XzkemB3xaAzOYDGvLIqOEL9CKaWmR1ymdsTPPthStd8A
 DgekS8LA+l9a3i41nXiETOhqPjlamkI74lU7S0V816lw35Xy7qMufax5k4MWs5MbPykr
 1TWqSxHm4ggWagoIAllx2r3SGXaNgp/NK2DSCcI24wOYxnFxufbs4MY5yP+t5c0pJjyc
 bRNzevBgN7Un4RtMhCXcqa2X0zZ/kbDrY2u/Tf23umOtPpFe6kXDlumuNlLOEvEjOHtn
 HKuw==
X-Gm-Message-State: AOJu0YzAGvjnn9Iqi0fG3NDA55HFAFBVNMjKEs7Z/gxvL/iPY2Tulx7F
 2VgeJ2aYTRVQZzP29pD58ClqChxgZNgwn3OGv5lTx0DAZn60sa5br3vExutQup8Ov7/rSDrCIAU
 =
X-Gm-Gg: ASbGncu7ta+O+JkGazO09jJ5NcwNLYE2XE32ToBXhvutiwIGN3i5UpDXDiH7Vkx8nl5
 mRcd8zo4VO/hdwGHdXiWx8MAvXOqnwYGCi4n9gVWhLQcmFF0qFWA10KWo4VHotzJM+BNLc10hP7
 5SGErubYjonblQm4AsaUcbK9FtXKUhIP3Re2G8ROd7FFRwdNy2RIG7FFW0r69779/CzXsPR1jl3
 yDEWzFWGTkfw2YvRV4JM75u5ot6aNucI8RhB4un4zBDXMpAxdDh2PMQCuHWwSs+kro4i2n/wYom
 EiVVy02+NGEkd+3rSZbiAWgEwTHTkKnYkbE731+rbA==
X-Google-Smtp-Source: AGHT+IG96iaY6rFI0mi9H3r777n+HmLXfkjEw+hfWKyir1wImjB1XM46lJ8BGD3n2nxr+bPkEo8FuA==
X-Received: by 2002:a05:6602:4186:b0:84f:5345:1800 with SMTP id
 ca18e2360f4ac-851b6165b7cmr2754707739f.2.1737840720072; 
 Sat, 25 Jan 2025 13:32:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521e01754dsm164103539f.32.2025.01.25.13.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 13:31:58 -0800 (PST)
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
Subject: [PATCH 0/4] test: A few quality-of-life improvements
Date: Sat, 25 Jan 2025 14:31:35 -0700
Message-ID: <20250125213150.1608395-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Jan 2025 22:33:55 +0100
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


Simon Glass (4):
  test/py: Shorten u_boot_console
  test: Drop u_boot_ prefix on test files
  test/py: Show info about module-loading
  test: Make net tests depend on CONFIG_CMD_NET

 doc/develop/py_testing.rst                    |  16 +-
 doc/develop/tests_writing.rst                 |  12 +-
 test/py/conftest.py                           |  89 +++---
 ...u_boot_console_base.py => console_base.py} |   8 +-
 ...onsole_exec_attach.py => console_board.py} |   6 +-
 ..._console_sandbox.py => console_sandbox.py} |   8 +-
 test/py/{u_boot_spawn.py => spawn.py}         |   0
 test/py/tests/fit_util.py                     |  12 +-
 test/py/tests/test_000_version.py             |   8 +-
 test/py/tests/test_android/test_ab.py         |  48 +--
 test/py/tests/test_android/test_abootimg.py   |  92 +++---
 test/py/tests/test_android/test_avb.py        |  50 ++--
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
 test/py/tests/test_efi_fit.py                 |   6 +-
 test/py/tests/test_efi_loader.py              |  84 +++---
 .../py/tests/test_efi_secboot/test_authvar.py | 120 ++++----
 test/py/tests/test_efi_secboot/test_signed.py | 148 ++++-----
 .../test_efi_secboot/test_signed_intca.py     |  46 +--
 .../tests/test_efi_secboot/test_unsigned.py   |  42 +--
 test/py/tests/test_efi_selftest.py            | 180 +++++------
 .../py/tests/test_eficonfig/test_eficonfig.py | 106 +++----
 test/py/tests/test_env.py                     |  78 ++---
 test/py/tests/test_event_dump.py              |   6 +-
 test/py/tests/test_extension.py               |  32 +-
 test/py/tests/test_fit.py                     |   6 +-
 test/py/tests/test_fit_auto_signed.py         |   6 +-
 test/py/tests/test_fit_ecdsa.py               |   6 +-
 test/py/tests/test_fit_hashes.py              |   6 +-
 test/py/tests/test_fpga.py                    | 280 +++++++++---------
 test/py/tests/test_fs/conftest.py             |   2 +-
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
 test/py/tests/test_handoff.py                 |   4 +-
 test/py/tests/test_help.py                    |  18 +-
 test/py/tests/test_i2c.py                     |  44 +--
 test/py/tests/test_kconfig.py                 |  10 +-
 test/py/tests/test_log.py                     |  10 +-
 test/py/tests/test_lsblk.py                   |   4 +-
 test/py/tests/test_md.py                      |  22 +-
 test/py/tests/test_mdio.py                    |  32 +-
 test/py/tests/test_memtest.py                 |  26 +-
 test/py/tests/test_mii.py                     |  50 ++--
 test/py/tests/test_mmc.py                     | 148 ++++-----
 test/py/tests/test_mmc_rd.py                  |  54 ++--
 test/py/tests/test_mmc_wr.py                  |  20 +-
 test/py/tests/test_net.py                     | 142 ++++-----
 test/py/tests/test_net_boot.py                | 144 ++++-----
 test/py/tests/test_of_migrate.py              |  14 +-
 test/py/tests/test_ofplatdata.py              |   6 +-
 test/py/tests/test_optee_rpmb.py              |  10 +-
 test/py/tests/test_part.py                    |   4 +-
 test/py/tests/test_pinmux.py                  |  32 +-
 test/py/tests/test_pstore.py                  |  48 +--
 test/py/tests/test_qfw.py                     |   8 +-
 test/py/tests/test_reset.py                   |  24 +-
 test/py/tests/test_sandbox_exit.py            |  28 +-
 test/py/tests/test_sandbox_opts.py            |  10 +-
 test/py/tests/test_saveenv.py                 |  70 ++---
 test/py/tests/test_scp03.py                   |   8 +-
 test/py/tests/test_scsi.py                    |  48 +--
 test/py/tests/test_semihosting/test_hostfs.py |  14 +-
 test/py/tests/test_sf.py                      |  66 ++---
 test/py/tests/test_shell_basics.py            |  30 +-
 test/py/tests/test_sleep.py                   |  26 +-
 test/py/tests/test_smbios.py                  |  12 +-
 test/py/tests/test_source.py                  |   6 +-
 test/py/tests/test_spi.py                     | 242 +++++++--------
 test/py/tests/test_spl.py                     |  12 +-
 test/py/tests/test_stackprotector.py          |   8 +-
 test/py/tests/test_tpm2.py                    | 190 ++++++------
 test/py/tests/test_trace.py                   |   6 +-
 test/py/tests/test_ums.py                     |  48 +--
 test/py/tests/test_unknown_cmd.py             |   6 +-
 test/py/tests/test_upl.py                     |   6 +-
 test/py/tests/test_usb.py                     | 206 ++++++-------
 test/py/tests/test_ut.py                      | 128 ++++----
 test/py/tests/test_vbe.py                     |   4 +-
 test/py/tests/test_vbe_vpl.py                 |  14 +-
 test/py/tests/test_vboot.py                   |  12 +-
 test/py/tests/test_vpl.py                     |   8 +-
 test/py/tests/test_xxd/test_xxd.py            |   6 +-
 test/py/tests/test_zynq_secure.py             |  96 +++---
 test/py/tests/test_zynqmp_rpu.py              | 106 +++----
 test/py/tests/test_zynqmp_secure.py           |  42 +--
 test/py/{u_boot_utils.py => utils.py}         |  44 +--
 107 files changed, 2758 insertions(+), 2749 deletions(-)
 rename test/py/{u_boot_console_base.py => console_base.py} (99%)
 rename test/py/{u_boot_console_exec_attach.py => console_board.py} (95%)
 rename test/py/{u_boot_console_sandbox.py => console_sandbox.py} (93%)
 rename test/py/{u_boot_spawn.py => spawn.py} (100%)
 rename test/py/{u_boot_utils.py => utils.py} (89%)

-- 
2.43.0

