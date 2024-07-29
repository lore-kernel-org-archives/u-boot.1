Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68B2C3DA7E
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D3988677;
	Mon, 29 Jul 2024 18:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AlVh+BXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9C3887B9; Mon, 29 Jul 2024 18:19:14 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6B08855C
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e05eccfcdb3so2050668276.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269951; x=1722874751; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Pm7VZSxN2kyG5svSSU2nLSdyRcvry9lFisvSwjnqv+k=;
 b=AlVh+BXByojytNjm5Mk1MAeUsxrpKchT3geOoyoIC3DklVM8ZFt5RP14qck0S7fEAr
 zyB2fBs4n4UBIu6twEN3vWM1Lr77y0NVKSJkNi99w0EOr3max3erol17AZZmByCUN246
 F8EedSKkmtKlFxCa4zo4NzV4rwW1j0AL5I0A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269951; x=1722874751;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pm7VZSxN2kyG5svSSU2nLSdyRcvry9lFisvSwjnqv+k=;
 b=UPTSEnvIDUULcInsApfNt8fQRTTTQyKWyseXpYMUxFdkC7XQXu1ytp4NZL+zgPabw1
 Llk0prva7hquMZgMcc3PZc7yYrW1/8YStq/k6pgNLOoqWTqlLFrPVxVEnbx441flQBwb
 PdXVyWRjSeHuEhya2ng1lPIUhY6A6cg1nqXa2xFUdS5ixvBy5i7++kBKYrUGCcn2jx61
 XsD1kEBR/Un9Po/5l//takUpxTfrtcHHktOLafbEISUgOeZzxdZTP+y8zEnf8XvoSz9G
 QAF+DjQmm6a5596t9Aa6HXqljh3wDhQdr3ZkbHiDEsnUYMP3cTdRhQzAUMa2WOt3oUxc
 dtUA==
X-Gm-Message-State: AOJu0Yy9dmIyNGhAm1h3mWERS9rJZNi6iUplSLlRZwiX6ttduhRRo0hn
 H9IY3zDQY/ThxwQMnbI/deT3KLo8tnlzPGALMtXFn+Gf41xEH5GdbNMVM5L4zOkZ6XkIMrkzUSu
 Yhhg7VbSCUN476HFCXAUmoqXddvmJJ4Dtm1z6BSuJHKgbEW0=
X-Google-Smtp-Source: AGHT+IGWUXZ6uw8IFbm3qBmED92x8UcPlOuD1zETSYLaiBAHhUBT6cE85PU1TzrCTxbN10h4tHPh0GTjw8SHNsW2PuE=
X-Received: by 2002:a05:6902:2289:b0:e0b:496c:26ea with SMTP id
 3f1490d57ef6-e0b542451d2mr9420047276.0.1722269950847; Mon, 29 Jul 2024
 09:19:10 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 10:19:00 -0600
Message-ID: <CAFLszTi5FHj_ZE=-BUYGrOS-Gxd=gBLi1CZdxF51UTqh-g2skg@mail.gmail.com>
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

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/21789
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=66&view=results

The following changes since commit 9366640449ac3ef702b624e2f6f7604754a9082b:

  Merge tag 'dm-pull-26jul24' of
https://gitlab.denx.de/u-boot/custodians/u-boot-dm (2024-07-26
10:35:44 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-29jul24

for you to fetch changes up to 20e5399a311eb3aca5cebfd3e494047ed1ceacb8:

  Makefile: Pass OF_SPL_REMOVE_PROPS to binman (2024-07-29 08:42:18 -0600)

----------------------------------------------------------------
qconfig minor improvement
binman support for alternate entries

----------------------------------------------------------------
Simon Glass (23):
      qconfig: Allow searching for CONFIG values
      qconfig: Sort the boards by name when finding
      qconfig: Support a 'list' format
      fixdep: Support VPL
      binman: Correct an error in the FIT-template example
      binman: Tidy up bintool docs
      binman: Tidy up comment for Bintoolfdt_add_pubkey.run()
      binman: Move problem-checking code into a function
      binman: elf: Add more debugging to LookupAndWriteSymbols()
      binman: Write the compressed output to a file
      binman: Correct comment in blob_dtb GetFdtEtype()
      binman: Mention expanded entries in u-boot-vpl
      binman: Fix a comment typo in _DoReadFileDtb()
      binman: Correct indentation in testSplPubkeyDtb
      binman: Add a bintool for fdtgrep
      binman: Remove dependency on pylibfdt for entry-docs
      binman: Allow entry types to override FDT contents
      binman: Add support for alternative FDTs
      binman: fit: Allow providing FDT filenames in a directory
      binman: fit: Write the compatible string to configuration
      binman: fit: Allow running fdtgrep on devicetree blobs
      Makefile: Provide VPL devicetree and padding to binman
      Makefile: Pass OF_SPL_REMOVE_PROPS to binman

 Makefile                                     |   3 +
 doc/develop/qconfig.rst                      |  14 ++++
 doc/develop/spl.rst                          |   2 +
 scripts/basic/fixdep.c                       |   2 +
 tools/binman/binman.rst                      |   4 +-
 tools/binman/bintools.rst                    |  69 ++++++++++------
 tools/binman/btool/fdt_add_pubkey.py         |   4 +
 tools/binman/btool/fdtgrep.py                | 137
+++++++++++++++++++++++++++++++
 tools/binman/control.py                      |  77 +++++++++++-------
 tools/binman/elf.py                          |   2 +-
 tools/binman/entries.rst                     |  94 ++++++++++++++++++++--
 tools/binman/entry.py                        |  17 ++++
 tools/binman/etype/alternates_fdt.py         | 132
++++++++++++++++++++++++++++++
 tools/binman/etype/blob_dtb.py               |   8 +-
 tools/binman/etype/fit.py                    |  93 ++++++++++++++++++++-
 tools/binman/etype/u_boot_spl_nodtb.py       |   2 -
 tools/binman/etype/u_boot_tpl_nodtb.py       |   2 -
 tools/binman/etype/u_boot_vpl.py             |   3 +
 tools/binman/etype/u_boot_vpl_nodtb.py       |   4 +-
 tools/binman/ftest.py                        | 255
++++++++++++++++++++++++++++++++++++++++++++++++++++------
 tools/binman/image.py                        |  24 ++++++
 tools/binman/main.py                         |   2 +
 tools/binman/test/328_alternates_fdt.dts     |  28 +++++++
 tools/binman/test/329_alternates_fdtgrep.dts |  29 +++++++
 tools/binman/test/330_alternates_vpl.dts     |  29 +++++++
 tools/binman/test/331_alternates_spl.dts     |  29 +++++++
 tools/binman/test/332_alternates_inval.dts   |  29 +++++++
 tools/binman/test/333_fit_fdt_dir.dts        |  58 +++++++++++++
 tools/binman/test/334_fit_fdt_compat.dts     |  60 ++++++++++++++
 tools/binman/test/335_fit_fdt_phase.dts      |  61 ++++++++++++++
 tools/binman/test/alt_dts/model1.dts         |  24 ++++++
 tools/binman/test/alt_dts/model2.dts         |  24 ++++++
 tools/qconfig.py                             |  29 +++++--
 33 files changed, 1243 insertions(+), 107 deletions(-)
 create mode 100644 tools/binman/btool/fdtgrep.py
 create mode 100644 tools/binman/etype/alternates_fdt.py
 create mode 100644 tools/binman/test/328_alternates_fdt.dts
 create mode 100644 tools/binman/test/329_alternates_fdtgrep.dts
 create mode 100644 tools/binman/test/330_alternates_vpl.dts
 create mode 100644 tools/binman/test/331_alternates_spl.dts
 create mode 100644 tools/binman/test/332_alternates_inval.dts
 create mode 100644 tools/binman/test/333_fit_fdt_dir.dts
 create mode 100644 tools/binman/test/334_fit_fdt_compat.dts
 create mode 100644 tools/binman/test/335_fit_fdt_phase.dts
 create mode 100644 tools/binman/test/alt_dts/model1.dts

Regards,
Simon
