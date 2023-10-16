Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31986CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA3786537;
	Mon, 16 Oct 2023 08:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iucwfdkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D642086784; Mon, 16 Oct 2023 08:46:32 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB3528477A
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 08:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d9a64ca9cedso4144254276.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697438788; x=1698043588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C8Olm2aD4F65wVFbJxy84ip9+fJGVRna2ht+VTEDv1g=;
 b=iucwfdkwBixXIPfeUlHqtS5Rs4hOz+7e5Q15vpB6/jIEikH0KPH6Mst91/4TVh8SOa
 MmngNacHDzel3F+q/kVRAQp0sD0dQgK1VKLlp8zaAqPJCqSXahmDSfM9gPZ37eZ7k0C/
 6E3eURY7M09CnPlKSf6BSUm1+V8PvlJ2gLFoEXcEgvBblzDNsJkG/mVLefO3kaHGpzww
 aSkxiA8bdCLb0j1mHx5TNK4asL9BPxjUL4CLaDA6AXaAELGa4sSteVi6GwNoEYeYCEmR
 GITcOT7c0rv4fFAd8tJydRbKvsgoeinrsS+4065yOOqfZnp+IKrFCaS6A/wN84xamZNu
 lJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438788; x=1698043588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C8Olm2aD4F65wVFbJxy84ip9+fJGVRna2ht+VTEDv1g=;
 b=FQSPlOpnKA53uDsQCyY66ayeWP3uD0JI0Okq7iq/B6U9IHBEfKM45/puUijg5PUt2U
 aYlOSm0dmJeLIB6w21Mhwr81va9SzQeffGBhnxz/VZLu87zxF4T+Arwjd5FeKn7Cxil1
 TMmWYaBWFEbVoqR1VuXDQO4sunF/BCk0W0rtyytXXkBlqCawYbH2sv0OcdgdCwtjrGXu
 iVbyyVCiEb2hxgNUWdplxgwmF3SdM+XxuqrdUGTfw9NZV5hx4YPfUE92L4r4zNlCS7EK
 MpA8dxojIWt+0kNPt6mj86Jr1NOhG6UQZuEf/NYJT5zkJpKAtAanGgqoxZXs+hHYh7AF
 VDIA==
X-Gm-Message-State: AOJu0YwvTrpGBeHW0bmVY6RsWAuogAbhd9ql/awfpLOcDNTLZsL2ybYd
 eNCBTDy6RAa7TT4wjpTRV76OFq9aA5xdNDFQwr4=
X-Google-Smtp-Source: AGHT+IGx5f9rpVBAL7+dVzsXepoSDAQE8z3d7fjiNefrrCHqgzbFkldudzAS8Uy8k8C81IbZSyHRjA==
X-Received: by 2002:a25:f301:0:b0:d9b:8172:8683 with SMTP id
 c1-20020a25f301000000b00d9b81728683mr3833752ybs.40.1697438788222; 
 Sun, 15 Oct 2023 23:46:28 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 g3-20020aa796a3000000b006be121dd730sm1386799pfk.161.2023.10.15.23.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:46:27 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v7 0/9] Add EFI HTTP boot support
Date: Mon, 16 Oct 2023 15:45:17 +0900
Message-Id: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds the EFI HTTP boot support.
User can add the URI device path with "efidebug boot add" command.
efibootmgr handles the URI device path, download the
specified file using wget, mount the downloaded image with
blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI)
by selecting automatically created boot option when the new disk is
detected.

This version still does not include the test.

To enable EFI HTTP boot, we need to enable the following Kconfig options.
 CONFIG_CMD_DNS
 CONFIG_CMD_WGET
 CONFIG_BLKMAP
 CONFIG_EFI_HTTP_BOOT

On the Socionext Developerbox, enter the following commands then
debian installer is downloaded into "loadaddr" and installer
automatically starts.
 => dhcp
 => setenv serverip 192.168.1.1
 => efidebug boot add -u 3 debian-netinst http://ftp.riken.jp/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
 => efidebug boot order 3
 => bootefi bootmgr

Note that this debian installer can not proceed the installation
bacause RAM disk of installer image is not recogniged by the kernel.
I'm still investigating this issue, but drivers/nvdimm/of_pmem.c in linux
will be one of the solution to recognize RAM disk from kernel.
(In EDK2, the equivalent solution is called ACPI NFIT.)

On QEMU, I can not make DNS work from the QEMU guest.
The following commands work on qemu_arm64(manually set the http server ip in URI).
  => dhcp
  => setenv gatewayip 10.0.2.2
  => setenv httpserverip 134.160.38.1
  => efidebug boot add -u 3 debian-netinst http://134.160.38.1/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
  => efidebug boot order 3
  => bootefi bootmgr

[TODO]
- add test
- stricter wget uri check
- omit the dns process if the given uri has ip address
   -> this will be supported when the lwip migration completes
- uri device path support in eficonfig

[change log]
v6 -> v7
- rename the funtion name from load_default_file_boot_option()
  to load_mounted_image()
- move some fix from patch #5 "efi_loader: support boot from URI device path" to
  patch #4 "efi_loader: create default file boot option".
- fix missing free() of default_file_path

v5 -> v6
- add patch #4 "Boot var automatic management for removable medias"
- boot from automatically created boot option
  rather than searching default file on the fly
- introduce new CONFIG_EFI_HTTP_BOOT Kconfig option
- comment in one place
- use log_err() rather than printf()
- use env_get_hex("filesize", 0) instead of return value of net_loop()
- use more suitable error code
- blkmap can be build for SPL/TPL
- add CDROM short-form device path support

v4 -> v5
- add missing else statement
- add NULL check of efi_dp_find_obj() call
- update document to remove "limitation"

v3 -> v4
- patch#8 is added to simplify the bootmgr default boot process
- add function comments

v2 -> v3
- Patch#6 is added, reserve the whole ramdisk memory region
- remove .efi file extension check for PE-COFF image
- use "if IS_ENABLED(..)" as much as possible
- 1024 should be sizeof(net_boot_file_name)
- call net_set_state(NETLOOP_FAIL) when wget encounters error
- describe DNS ip address host name limitation in document

v1 -> v2
- carve out the network handling(wget and dns code) under net/wget.c
- carve out ramdisk creation code under drivers/block/blkmap_helper.c
- wget supports the valid range check to store the received blocks using lmb
- support when the downloaded image have no partiton table but a file system
- not start the .efi file in try_load_entry()
- call efi_check_pe() for .efi file to check the file is PE-COFF image
- add documentation for EFI HTTP Boot


Masahisa Kojima (8):
  net: wget: prevent overwriting reserved memory
  net: wget: add wget with dns utility function
  blk: blkmap: add ramdisk creation utility function
  efi_loader: create default file boot option
  efi_loader: support boot from URI device path
  efi_loader: add CDROM short-form device path
  cmd: efidebug: add uri device path
  doc: uefi: add HTTP Boot support

Raymond Mao (1):
  Boot var automatic management for removable medias

 cmd/efidebug.c                                |  50 +++
 doc/develop/uefi/uefi.rst                     |  30 ++
 drivers/block/Makefile                        |   3 +-
 drivers/block/blkmap.c                        |  15 -
 drivers/block/blkmap_helper.c                 |  53 ++++
 include/blkmap.h                              |  29 ++
 include/efi_loader.h                          |   2 +
 include/net.h                                 |  17 ++
 lib/efi_loader/Kconfig                        |   9 +
 lib/efi_loader/efi_bootmgr.c                  | 284 ++++++++++++++++--
 lib/efi_loader/efi_device_path.c              |   3 +-
 lib/efi_loader/efi_disk.c                     |  18 ++
 lib/efi_loader/efi_dt_fixup.c                 |   2 +-
 lib/efi_loader/efi_setup.c                    |   7 +
 net/wget.c                                    | 205 ++++++++++++-
 test/py/tests/test_efi_secboot/test_signed.py |  42 +--
 .../test_efi_secboot/test_signed_intca.py     |  14 +-
 .../tests/test_efi_secboot/test_unsigned.py   |  14 +-
 .../test_fs/test_squashfs/test_sqfs_ls.py     |   6 +
 19 files changed, 720 insertions(+), 83 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c


base-commit: c1ab04626d6b05c6e82dfe4d97d3f62f7310d612
-- 
2.34.1

