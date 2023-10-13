Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB073CDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 00:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A0786EF6;
	Sat, 14 Oct 2023 01:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H/ON7/4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F5C80422; Sat, 14 Oct 2023 00:07:03 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C5C86F72
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d9a7a3e17d1so2854532276.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234490; x=1697839290; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KGg1ZBDxAk8ndgGM54ywwdNLTMlGqJdJnk4QO3OHTVk=;
 b=H/ON7/4b2edLz8AGotyretIMmInGnC1YWaxGhco+9FrraZdBqcojrm5lXwUrqUSCuV
 jTk55QvP9rJ0qe2+CkSAsyE1vnBQNKkoXVhocN+ww+9rnxhK38HDh47DM66N2m/BQWLW
 kHNyGuQCexkJ2MsYDEizr+F2VUru6pqc/21ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234490; x=1697839290;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KGg1ZBDxAk8ndgGM54ywwdNLTMlGqJdJnk4QO3OHTVk=;
 b=xEoPCnx/vK163oTqXNSamuBHXALIEm/wqv7bJutOfd/TiyFFVvusnHvOHVZ5raSRdA
 tFVZjvEm2d/y7VjLb0psgP6ZqLCOAMIWXCG1QNVg+mtyvb/NVTZ0sdDLMF7R0+uCwHK4
 2I/WtD6c9n+Lbx3WBQfUtjoWQU3gcY6Q8dJJMf3IZQ9Zu7/W5fdXmt2X2G8L+tZNsui1
 q/aPBRqfv9DOW8CI2Eo6AFNYMVGHjUD6TeMn5mBrfsbfH9jXfjIzBSjRhQWcrsauZ3wC
 Ae82x+bYu9EleWotsvMDZZAK/eLUDVk4toXA2eKjJxiXlZYo4fdRSNu+91KJjQCjnfJD
 wP7Q==
X-Gm-Message-State: AOJu0YxRW2XaSMKJ2t1vbLbVjgpWWDqPKWKqQwmh0KumUGD2+iA7hXi4
 77BM0srbqyIQ1NqRSHzsUFmWFAJb8rXZFy+IV+mbfLINhDRSC/8Q0s2d4g==
X-Google-Smtp-Source: AGHT+IFevDtM+dp7PpOntfhHZT68eDI19Uv0OyYyos5N+1K+7vs7e8JBn3EUl4OD2/neyrvbR/45bKFYn5CncS195Ds=
X-Received: by 2002:a25:4050:0:b0:d9a:43ec:2dc with SMTP id
 n77-20020a254050000000b00d9a43ec02dcmr194553yba.22.1697234489727; Fri, 13 Oct
 2023 15:01:29 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 15:01:12 -0700
Message-ID: <CAPnjgZ3GrxALQ12Ne3fAZT_dWRbCJu93+0L185z5T2KD9FoLaQ@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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


https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/18115

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=53&view=results


The following changes since commit d5d24e2e0a3f54175e458d89acd626da939e1130:

  Merge tag 'efi-2024-01-rc1' of
https://source.denx.de/u-boot/custodians/u-boot-efi (2023-10-13
11:08:10 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-13oct23

for you to fetch changes up to 74aae507bc4d5726308c191d3191d9cd624ba0d2:

  binman: capsule: Add support for generating EFI empty capsules
(2023-10-13 14:01:42 -0600)

----------------------------------------------------------------
improvements with dev_read_addr_..._ptr()
scan all entries in multi-device boot_targets
EFI empty-capsule support

----------------------------------------------------------------
Heinrich Schuchardt (1):
      sandbox: fix spl_board_init

Lukas Funke (1):
      binman: bintool: Change make target arg type from string to list

Matthias Schiffer (5):
      core: fix doc comments of dev_read_addr*() and related functions
      core: return FDT_ADDR_T_NONE from devfdt_get_addr_[size_]name() on errors
      core: introduce dev_read_addr_name[_size]_ptr() functions
      pinctrl: single: fix compile warnings with PHYS_64BIT on 32bit
      treewide: use dev_read_addr_*_ptr() where appropriate

Simon Glass (1):
      bootstd: Scan all bootdevs in a boot_targets entry

Sughosh Ganu (6):
      tools: mkeficapsule: Add support to print capsule headers
      doc: capsule: Add documentation for the capsule dump feature
      binman: capsule: Remove superfluous [address, size]-cells properties
      binman: capsule: Use dumped capsule header contents for verification
      btool: mkeficapsule: Add support for EFI empty capsule generation
      binman: capsule: Add support for generating EFI empty capsules

 arch/arm/mach-k3/sysfw-loader.c                         |  16 +--
 arch/sandbox/cpu/spl.c                                  |   3 +
 boot/bootdev-uclass.c                                   |   3 +-
 boot/bootflow.c                                         |  21 +++-
 doc/develop/uefi/uefi.rst                               |  17 +++
 drivers/core/fdtaddr.c                                  |  25 ++++-
 drivers/core/read.c                                     |  21 ++++
 drivers/dma/ti/k3-udma.c                                |   5 +-
 drivers/gpio/tegra186_gpio.c                            |   4 +-
 drivers/mailbox/k3-sec-proxy.c                          |  18 +--
 drivers/phy/allwinner/phy-sun4i-usb.c                   |  12 +-
 drivers/phy/phy-bcm-sr-pcie.c                           |   4 +-
 drivers/pinctrl/pinctrl-single.c                        |  34 +++---
 drivers/ram/k3-am654-ddrss.c                            |  20 ++--
 drivers/ram/k3-ddrss/k3-ddrss.c                         |  23 ++--
 drivers/soc/ti/k3-navss-ringacc.c                       |  12 +-
 include/dm/fdtaddr.h                                    |  47 ++++++--
 include/dm/read.h                                       |  47 +++++++-
 test/boot/bootdev.c                                     |  10 ++
 tools/binman/btool/bootgen.py                           |   2 +-
 tools/binman/btool/fiptool.py                           |   2 +-
 tools/binman/btool/futility.py                          |   2 +-
 tools/binman/btool/mkeficapsule.py                      |  26 +++++
 tools/binman/entries.rst                                |  44 ++++++++
 tools/binman/etype/efi_capsule.py                       |  24 +++-
 tools/binman/etype/efi_empty_capsule.py                 |  86 +++++++++++++++
 tools/binman/ftest.py                                   | 160
++++++++++++++++++++-------
 tools/binman/test/311_capsule.dts                       |   3 -
 tools/binman/test/312_capsule_signed.dts                |   3 -
 tools/binman/test/313_capsule_version.dts               |   3 -
 tools/binman/test/314_capsule_signed_ver.dts            |   3 -
 tools/binman/test/315_capsule_oemflags.dts              |   3 -
 tools/binman/test/316_capsule_missing_key.dts           |   3 -
 tools/binman/test/317_capsule_missing_index.dts         |   3 -
 tools/binman/test/318_capsule_missing_guid.dts          |   3 -
 tools/binman/test/319_capsule_accept.dts                |  13 +++
 tools/binman/test/320_capsule_revert.dts                |  11 ++
 tools/binman/test/321_capsule_accept_missing_guid.dts   |  11 ++
 tools/binman/test/322_empty_capsule_type_missing.dts    |  12 ++
 tools/binman/test/323_capsule_accept_revert_missing.dts |  13 +++
 tools/eficapsule.h                                      |   2 +
 tools/mkeficapsule.c                                    | 227
+++++++++++++++++++++++++++++++++++++-
 42 files changed, 837 insertions(+), 164 deletions(-)
 create mode 100644 tools/binman/etype/efi_empty_capsule.py
 create mode 100644 tools/binman/test/319_capsule_accept.dts
 create mode 100644 tools/binman/test/320_capsule_revert.dts
 create mode 100644 tools/binman/test/321_capsule_accept_missing_guid.dts
 create mode 100644 tools/binman/test/322_empty_capsule_type_missing.dts
 create mode 100644 tools/binman/test/323_capsule_accept_revert_missing.dts

Regards,
Sion
