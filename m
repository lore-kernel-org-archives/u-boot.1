Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472D5CDB47E
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 02:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1283F85DFA;
	Mon, 16 Oct 2023 04:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J5TOCny+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6678634D; Mon, 16 Oct 2023 04:40:12 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B71800D2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 04:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27d425a2dd0so2070099a91.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 19:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697423998; x=1698028798; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+W3CpOtWxhrgiYZvSUcEO0O3fw/JXXn+1TumwXbiVWQ=;
 b=J5TOCny+dx6aJW8IFSKvw3l7cHjUKwPQU1OVHvoJKVvek1T/XyH6FuEskG+Ywp2sXK
 OBLDPTZ3kNh4bMZQa04id9zEEnB+4MXr+FkimqTkbjZMVBj1t/LpsWi/yUMBbApU7wkn
 A5sy9XH2+oGwFw3opEucRovavSCPLbP/3CDOinGhFS4SF0oPAk6ihJeAgOydCFeVGLr9
 p1KecnUVSoBpk5TTxofznvAqTT3kYKrIZG435rtBSxZ4qsN539NYIujwDxPL+6zXEB1s
 ReFAx02KETVGs11wtezkBqd9XSf5yn6AozTGYo/UxiRXgbLuTj6Ku67qwUTnY1+OvFyM
 sjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697423998; x=1698028798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+W3CpOtWxhrgiYZvSUcEO0O3fw/JXXn+1TumwXbiVWQ=;
 b=SsmqHoeVy7k88mx35JKZ+rE24y2N5DWFUSyRZD/JCDglxjoR8xJdpwWI3D6Ui2gBfG
 y7tqMPl8XJ1XTA+xtlOHejt6o8WRDYNTAfL+sEScQBODnUwX5Gu9XLWrYy/NMDkYa8Bz
 TMugjuY4zUh15TX1ftr05JWBYSWd4YuAKxC02LTAlzch7OUSn4WFPhR1QirAyL8yAahW
 5e0JJPHB2h9F77lazZYzlk+d7rG99tFHyQmzsGH5cNZEB4erF4LHBKVfzb9UFi6Bw0HF
 y8j+WMaD4s1vehXG3LHscsNgZg0B2FoxC4CX41T8rsz/8Rv5NFDVz7zaecKoOnQ/MOcM
 d0lA==
X-Gm-Message-State: AOJu0YzuxCKmnGcuhut645avag/2aqDe+/DQR+7P4MTsKpw379+0oAFH
 vJNKJdp5viU7/jmm/tkrLS4Gn3IemAFCTuT45E1OdNAMJ1tC6/Mo
X-Google-Smtp-Source: AGHT+IHJIpgsvJD91+4LXQNHdD9trOQwDUh/TCj1Y8d8hIJjasYOZa4l2/qwjy7KPrdx40r0tNgr4Q0REaJpLbJsC7M=
X-Received: by 2002:a17:90a:eb04:b0:27d:63ae:f378 with SMTP id
 j4-20020a17090aeb0400b0027d63aef378mr3929778pjz.42.1697423998151; Sun, 15 Oct
 2023 19:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
In-Reply-To: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 16 Oct 2023 11:39:47 +0900
Message-ID: <CADQ0-X-=4q7dCeny2F_J6DqY9bVxQ01p-zLyu4rnwVXmE=iiEA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Add EFI HTTP boot support
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

On Mon, 16 Oct 2023 at 08:50, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This series adds the EFI HTTP boot support.
> User can add the URI device path with "efidebug boot add" command.
> efibootmgr handles the URI device path, download the
> specified file using wget, mount the downloaded image with
> blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI)
> by selecting automatically created boot option when the new disk is
> detected.
>
> This version still does not include the test.
>
> To enable EFI HTTP boot, we need to enable the following Kconfig options.
>  CONFIG_CMD_DNS
>  CONFIG_CMD_WGET
>  CONFIG_BLKMAP
>  CONFIG_EFI_HTTP_BOOT
>
> On the Socionext Developerbox, enter the following commands then
> debian installer is downloaded into "loadaddr" and installer
> automatically starts.
>  => dhcp
>  => setenv serverip 192.168.1.1
>  => efidebug boot add -u 3 debian-netinst http://ftp.riken.jp/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
>  => efidebug boot order 3
>  => bootefi bootmgr
>
> Note that this debian installer can not proceed the installation
> bacause RAM disk of installer image is not recogniged by the kernel.
> I'm still investigating this issue, but drivers/nvdimm/of_pmem.c in linux
> will be one of the solution to recognize RAM disk from kernel.
> (In EDK2, the equivalent solution is called ACPI NFIT.)
>
> On QEMU, I can not make DNS work from the QEMU guest.
> The following commands work on qemu_arm64(manually set the http server ip in URI).
>   => dhcp
>   => setenv gatewayip 10.0.2.2
>   => setenv httpserverip 134.160.38.1
>   => efidebug boot add -u 3 debian-netinst http://134.160.38.1/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
>   => efidebug boot order 3
>   => bootefi bootmgr
>
> [TODO]
> - add test
> - stricter wget uri check
> - omit the dns process if the given uri has ip address
>    -> this will be supported when the lwip migration completes
> - uri device path support in eficonfig
>
> [change log]
> v5 -> v6
> - add patch #4 "Boot var automatic management for removable medias"
> - boot from automatically created boot option
>   rather than searching default file on the fly
> - introduce new CONFIG_EFI_HTTP_BOOT Kconfig option
> - comment in one place
> - use log_err() rather than printf()
> - use env_get_hex("filesize", 0) instead of return value of net_loop()
> - use more suitable error code
> - blkmap can be build for SPL/TPL
> - add CDROM short-form device path support

Sorry but I forgot to include the necessary changes.
I will resend this series soon.

Thanks,
Masahisa Kojima


>
> v4 -> v5
> - add missing else statement
> - add NULL check of efi_dp_find_obj() call
> - update document to remove "limitation"
>
> v3 -> v4
> - patch#8 is added to simplify the bootmgr default boot process
> - add function comments
>
> v2 -> v3
> - Patch#6 is added, reserve the whole ramdisk memory region
> - remove .efi file extension check for PE-COFF image
> - use "if IS_ENABLED(..)" as much as possible
> - 1024 should be sizeof(net_boot_file_name)
> - call net_set_state(NETLOOP_FAIL) when wget encounters error
> - describe DNS ip address host name limitation in document
>
> v1 -> v2
> - carve out the network handling(wget and dns code) under net/wget.c
> - carve out ramdisk creation code under drivers/block/blkmap_helper.c
> - wget supports the valid range check to store the received blocks using lmb
> - support when the downloaded image have no partiton table but a file system
> - not start the .efi file in try_load_entry()
> - call efi_check_pe() for .efi file to check the file is PE-COFF image
> - add documentation for EFI HTTP Boot
>
> Masahisa Kojima (8):
>   net: wget: prevent overwriting reserved memory
>   net: wget: add wget with dns utility function
>   blk: blkmap: add ramdisk creation utility function
>   efi_loader: create default file boot option
>   efi_loader: support boot from URI device path
>   efi_loader: add CDROM short-form device path
>   cmd: efidebug: add uri device path
>   doc: uefi: add HTTP Boot support
>
> Raymond Mao (1):
>   Boot var automatic management for removable medias
>
>  cmd/efidebug.c                                |  50 ++++
>  doc/develop/uefi/uefi.rst                     |  30 ++
>  drivers/block/Makefile                        |   3 +-
>  drivers/block/blkmap.c                        |  15 -
>  drivers/block/blkmap_helper.c                 |  53 ++++
>  include/blkmap.h                              |  29 ++
>  include/efi_loader.h                          |   2 +
>  include/net.h                                 |  17 ++
>  lib/efi_loader/Kconfig                        |   9 +
>  lib/efi_loader/efi_bootmgr.c                  | 282 ++++++++++++++++--
>  lib/efi_loader/efi_device_path.c              |   3 +-
>  lib/efi_loader/efi_disk.c                     |  18 ++
>  lib/efi_loader/efi_dt_fixup.c                 |   2 +-
>  lib/efi_loader/efi_setup.c                    |   7 +
>  net/wget.c                                    | 205 ++++++++++++-
>  test/py/tests/test_efi_secboot/test_signed.py |  42 +--
>  .../test_efi_secboot/test_signed_intca.py     |  14 +-
>  .../tests/test_efi_secboot/test_unsigned.py   |  14 +-
>  .../test_fs/test_squashfs/test_sqfs_ls.py     |   6 +
>  19 files changed, 718 insertions(+), 83 deletions(-)
>  create mode 100644 drivers/block/blkmap_helper.c
>
>
> base-commit: c1ab04626d6b05c6e82dfe4d97d3f62f7310d612
> prerequisite-patch-id: 386e2563ffafe7f80fda169076d2835ea071b3f9
> --
> 2.34.1
>
