Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE2CCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703F886776;
	Fri,  1 Sep 2023 12:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HuG81n/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7645986776; Fri,  1 Sep 2023 12:26:26 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB52A81970
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf7423ef3eso13484215ad.3
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693563978; x=1694168778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qwPFduRrwDV+8AbiYPYN4lz6o84q16nOE81vedhRgOY=;
 b=HuG81n/C3owik98pSK9W1FAOgnBeJCs7rKHgUwuiJDYEKA8rZB8TVv4970KAlXbpJ0
 CeqVU9NlJFoL9+cDFOKEYHqXhDoIsLBWV6tkclI9ZqPxaFW29bEzwhhjzjoknT73PCsc
 koy5b55oS5dEhSClh9qVyHxufYUxh2hWTlVQTzzJnk2o0Z34gVrzsKqk4BgmSsAGaGPX
 jmTTX8EaYVGXN7eTipFFFYDHaJEuEDj/7xKRtBRlJ/L7bEa0q/Fktbr79GmKYUa/jqVi
 OW8W9txuI6TmRlTQ46JvflOypctP9I2eHPy14mWB3xF2ROOTALwLLP8XoZ/T9PvPGG6f
 YTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693563978; x=1694168778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qwPFduRrwDV+8AbiYPYN4lz6o84q16nOE81vedhRgOY=;
 b=M8fQjM7IQ6wL7ihU9SztpJ6rDux20Ajnx78TmOtVsrXurGccLPCnUxm1w7ys5nlzMH
 gwWtAcOKQAiKik5ein2TIIUQ3SHg+DI8nsB2qp42Eh5HYKpbaAmSvZiBvxUyo2mSEdsM
 +QSD4ycwudIW1mWqV5o0K/oBLMgo4Qju7AHvigJPA5qh3XwalHRc08UpksDPJ59u5h3S
 uYq1G2M9a076Tq8x3uL1X8Sv5bJxqB+hOwfIlKW2CI1sEBUK3wru06sRJy1heS9Ouizb
 acqqQSY9fy2ZgPwI8xqrXuTHG8fYkmHDvcFbZUpDEz/cHeQb2qjlFxTB857U1t61tiXv
 JIYA==
X-Gm-Message-State: AOJu0YxeV9TZGlx5/4os5C1g1/LnsVqJiOObrvQ/4CZ4V0asNFDog/l6
 x+RoboFERsYtHFb4ElZtVgluy/8QyFDUC31XSeA=
X-Google-Smtp-Source: AGHT+IEDNUvs39C8G3wjZ0qWTL2rnmNC/G5Oh4pk5pLbnyM2/tQblTlvhoglsIJkzlr8fqEFlgm22Q==
X-Received: by 2002:a17:903:26ce:b0:1c0:cb4d:df7c with SMTP id
 jg14-20020a17090326ce00b001c0cb4ddf7cmr1936588plb.1.1693563977676; 
 Fri, 01 Sep 2023 03:26:17 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 bd10-20020a170902830a00b001a80ad9c599sm2671120plb.294.2023.09.01.03.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 03:26:16 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 0/6] Add EFI HTTP boot support
Date: Fri,  1 Sep 2023 19:25:36 +0900
Message-Id: <20230901102542.609239-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This series adds the EFI HTTP boot support.
User can add the URI device path with "efidebug boot add" command.
efibootmgr handles the URI device path, download the
specified file using wget, mount the downloaded image with
blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).

This version still does not include the test.

To enable EFI HTTP boot, we need to enable the following Kconfig options.
 CONFIG_CMD_DNS
 CONFIG_CMD_WGET
 CONFIG_BLKMAP

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

[change log]
v1 -> v2
- carve out the network handling(wget and dns code) under net/wget.c
- carve out ramdisk creation code under drivers/block/blkmap_helper.c
- wget supports the valid range check to store the received blocks using lmb
- support when the downloaded image have no partiton table but a file system
- not start the .efi file in try_load_entry()
- call efi_check_pe() for .efi file to check the file is PE-COFF image
- add documentation for EFI HTTP Boot

Masahisa Kojima (6):
  net: wget: prevent overwriting reserved memory
  net: wget: add wget with dns utility function
  blk: blkmap: add ramdisk creation utility function
  efi_loader: support boot from URI device path
  cmd: efidebug: add uri device path
  doc: uefi: add HTTP Boot support

 cmd/efidebug.c                |  50 +++++++++
 doc/develop/uefi/uefi.rst     |  21 ++++
 drivers/block/Makefile        |   1 +
 drivers/block/blkmap.c        |  15 ---
 drivers/block/blkmap_helper.c |  53 +++++++++
 include/blkmap.h              |  29 +++++
 include/net.h                 |   8 ++
 lib/efi_loader/efi_bootmgr.c  | 197 +++++++++++++++++++++++++++++++++
 net/wget.c                    | 202 ++++++++++++++++++++++++++++++++--
 9 files changed, 554 insertions(+), 22 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c


base-commit: cc889bd0754e50a3cd50e8ed3094388480fbec86
-- 
2.34.1

