Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FEDC54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 20:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733B886F2A;
	Sat, 18 Nov 2023 21:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jBgYxGhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7A986BFA; Sat, 18 Nov 2023 21:29:57 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0AA86F87
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 21:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so5928786a12.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 12:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700339388; x=1700944188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=95MEEn6SeNp/ZlSaZJsx9+PIGaX/dVce5H4ZMRrd1Rg=;
 b=jBgYxGhxVHISxETj7Vwlz00Az8VIlfR4EADFUFNA6j1Z3ySqr6halSbe9jilm9Xb9g
 7z/18IOvzk4fEFH1vvXel/VifXNw3Rfuwm/9LnmbO3aMR81ekNQJN1yF7W87LT3Vm/dn
 zy0s94D9zzDfqs9lTbr6lBEAEAcfuYqJz6JgpX3UZdAqcnKtzi0JKKGNYTOCrVQAD+bs
 xkWfdp/ULuUTXLuY7RgEZp2fxWcfzZksdOgRtMd8+6COAjc1lQxo53MFbHiQyFeG5qQb
 H/86W86cdozYT/c05WK4sUhPFf2yGbTPQnj3yJ+yC00YhZ2L0OIBUAPoH4uh67gFmENx
 q+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700339388; x=1700944188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=95MEEn6SeNp/ZlSaZJsx9+PIGaX/dVce5H4ZMRrd1Rg=;
 b=hy+glLEqgxCxr7IGNxSmfaI/r+g56MfNSuSjLOsY1YRdRgj42PDrdUxpoNk/O6kkyM
 CdXHw/+XPMWPhbeEIht7FBdPTrytDEM1zdELJ9+8XKBiFKyUnpDPd5QrBVgVdgrK+JQX
 WS9+Zz+7cnkPBzH19QRwTL/TWld3IWNCNVVPYMr4grXicJ+j+uofDxtzvcXr7XcdfzOs
 E+mBt21Sx9AITEv0U+7ohIay+o51oC3QWxVRz3cwHFEdNR51Xl+103DNMbPbjplXxnyn
 7SPTjcSuNWjsKko/9nuGqSB5mdVf9ujaUv4ulBFlFCtgc2MjV4Dp0hf31gaUBYNaB/8x
 aK7w==
X-Gm-Message-State: AOJu0Yw6Wt7KJ5oCDoC/eJ/La+b54DZni3oaLk3ApSgdQHEPn0iZ7YWa
 DMepMhNBb2s8WU9mkb0KFQ+cPwFiUGn4lJzISIY=
X-Google-Smtp-Source: AGHT+IFRMxag63SUar0lAGh6G5Kmr+isY3mGc5QlG71uZXsgO0mjzqdLzvMMx9iOlWfv0NA/hpnHlQ==
X-Received: by 2002:a05:6402:1815:b0:540:911b:72b1 with SMTP id
 g21-20020a056402181500b00540911b72b1mr2799978edy.7.1700339388076; 
 Sat, 18 Nov 2023 12:29:48 -0800 (PST)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 a21-20020a50ff15000000b0053de19620b9sm1953661edu.2.2023.11.18.12.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 12:29:47 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: xypron.glpk@gmx.de,
	masahisa.kojima@linaro.org,
	raymond.mao@linaro.org
Subject: Pull request for efi-next-18112023
Date: Sat, 18 Nov 2023 22:29:45 +0200
Message-Id: <20231118202945.265566-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Hi Tom,

The following changes since commit ae7ec8b0be41b59ef323f7531c0fe6745e8fef45:

  Merge branch '2023-11-16-assorted-updates' into next (2023-11-17 08:38:05 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/efi-next-18112023

for you to fetch changes up to c022eed4bedf2e16e737fde22b03289d2a48cb27:

  doc: uefi: add HTTP Boot support (2023-11-18 10:08:09 +0200)

EFI HTTP Boot is currently supported by using a combination of
wget, blkmap and bootefi commands. The user has to download the
image, mount it using blkmap and then execute the efi installer
using bootefi.
This series simplifies the user experience. Instead of doing all the
steps manually, users can now enable a new Kconfig (EFI_HTTP_BOOT)
which will select wget, blkmap and dns options. They can then use
efidebug command to add a boot option for the EFI Bootmanager using
=> efidebug boot add -u 3 netinst http://<path>
=> efidebug boot order 3
=> bootefi bootmgr

The boot manager will automatically download and mount the image.
Once it's mounted it will locate and launch the installer.

It's worth noting that this rarely fails, but the reason is irrelevant
to the current patchset. More information can be found here
https://lore.kernel.org/u-boot/CAOMZO5CoduEgwgdQiybmoKh6qQZOezUtRRQO4ecaGdZBBz5dDw@mail.gmail.com/
The tl;dr is that wget sometimes fails to download the file correctly
or set the size env variables. We expect all these to be solved once
LWIP is stable and pulled

The CI reported no issues
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/18623
Please consider pulling!

----------------------------------------------------------------
Add EFI HTTP Boot support options for the EFI Bootmanager

----------------------------------------------------------------
Masahisa Kojima (8):
      net: wget: prevent overwriting reserved memory
      net: wget: add wget with dns utility function
      blk: blkmap: add ramdisk creation utility function
      efi_loader: add missing const classifier for event service
      efi_loader: add return to efibootmgr event group
      efi_loader: support boot from URI device path
      cmd: efidebug: add uri device path
      doc: uefi: add HTTP Boot support

Raymond Mao (1):
      efi_loader: Boot var automatic management

 cmd/bootefi.c                                      |  12 +
 cmd/efidebug.c                                     |  78 +++++
 doc/develop/uefi/uefi.rst                          |  34 ++
 drivers/block/Makefile                             |   3 +-
 drivers/block/blkmap.c                             |  15 -
 drivers/block/blkmap_helper.c                      |  53 +++
 include/blkmap.h                                   |  29 ++
 include/efi_api.h                                  |   5 +-
 include/efi_loader.h                               |   4 +-
 include/net.h                                      |  17 +
 lib/efi_loader/Kconfig                             |   9 +
 lib/efi_loader/efi_bootmgr.c                       | 386 +++++++++++++++++++++
 lib/efi_loader/efi_boottime.c                      |   7 +-
 lib/efi_loader/efi_disk.c                          |  18 +
 lib/efi_loader/efi_setup.c                         |   7 +
 net/wget.c                                         | 205 ++++++++++-
 test/py/tests/test_efi_secboot/test_signed.py      |  42 +--
 .../py/tests/test_efi_secboot/test_signed_intca.py |  14 +-
 test/py/tests/test_efi_secboot/test_unsigned.py    |  14 +-
 test/py/tests/test_fs/test_erofs.py                |   9 +
 .../py/tests/test_fs/test_squashfs/test_sqfs_ls.py |   9 +
 21 files changed, 908 insertions(+), 62 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c
