Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE43CDE03B
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68AB88DB6;
	Thu, 26 Sep 2024 23:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I+DmA3GG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF0B288DB8; Thu, 26 Sep 2024 23:22:16 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B64A8641A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso8702906d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727385733; x=1727990533; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lH2Fsy49SpdvJ3X8kblIDtVETXD992/udmCNSqJqqB0=;
 b=I+DmA3GGC8Ji3e454j9HBMu2v++6FfQPiBW2lypkDjUpiEODYn2g1Ha/KErertJBlg
 jhSO0/4fyfvjK4S22BhdCaX7roooNOFED8RdnjuC6E1NCqrNOP2QH/I0bdl6rt/D3Ns0
 SvuWmYmbYWu2fk6dxUDoXJRdwGelwU6/4ca18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727385733; x=1727990533;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lH2Fsy49SpdvJ3X8kblIDtVETXD992/udmCNSqJqqB0=;
 b=IOuAMdYitr+UbqpUGUjt3jcz1UEDOEO06OzTY+PN1QKRl7a33Y+Hf8bACamHr2nOKK
 ih5BIPoPdBaT9t2j0V8mSTtFORMzQ1u30q67wJOlDJ/9+WHdd+gJWGNEm9LS2Ykuwg8+
 aqbYVaZRxn3TsAPhhtRx78pkGRoZDbM0jl+9lWBGwZLzurdydi3BtharPpCrXoTVV083
 Pe0axwgAHhSTsH25s1BUPOM6/rLUuA3EF86v+T+PD1S31YVGLWNbPo81lv3VC9z6Thjr
 JYd6OVIiQXH28c0fVDz0Z4SlWHqhuvrp1932qKRd01jvoulX82IWqM727xhIJxe8rC8Z
 yclw==
X-Gm-Message-State: AOJu0YxbvSh6tak9bfJhZQ/I+ZfqGBNBFfhk9aj9QR6jmWRZhRbzBH/L
 7YW34ARwdz4Ut1utOmF/GeDxvpET2CaWnziMuZULBrlLWv7aDmkJ6IKdwW56RSqywG4B6NtIELQ
 lBIRLZMOTjC57lhSBbbJRblEdjeVSegUM/rJD9M1SPG8pTXGWw5s/FcI36Q==
X-Google-Smtp-Source: AGHT+IEn7hQWXf9Z1VttJ6cEtmYlZx4PlCIFXWmYS9o/XII5uBI0E2OqxsSTj/dPCFwUgHAIRSAgA5ZcmCeR775tYFs=
X-Received: by 2002:a05:6214:5684:b0:6cb:20f4:30eb with SMTP id
 6a1803df08f44-6cb3b645139mr14374176d6.36.1727385732925; Thu, 26 Sep 2024
 14:22:12 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:22:01 +0200
Message-ID: <CAFLszTi-vwb90vZMDAou=-gdZzSeJvRYPWG6V0=BCLLjYWn7Gg@mail.gmail.com>
Subject: Please pull u-boot-dm/next
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

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/22430
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=68&view=results


The following changes since commit 4386ab9118e7b405829fbcb3bbbaf2f47ddf0b44:

  power: regulator: Consistently return -ENOSYS when ops is
unimplemented (2024-09-25 08:54:03 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-next-26sep24

for you to fetch changes up to ac0876c890c2dcaa4e21ce36bfa2ea3e02139a01:

  binman: Make a start on an iMX8 test (2024-09-26 12:40:31 +0200)

----------------------------------------------------------------
Simon Glass (17):
      buildman: Retry the build for current source
      buildman: Allow skipping the dtc build
      binman: Fix up test coverage for mkeficapsule
      binman: Correct the comment for fdtgrep
      binman: Tidy up comments for Entry.GetEntryArgsOrProps()
      binman: Tidy up comments and pylint warnings in fit
      binman: Avoid setting the image_pos attribute directly
      binman: Update fdt-list-dir to use the provided directory
      binman: fit: Avoid assuming that a FIT member is a section
      binman: fit: Set the image_pos attributes only once
      binman: fit: Refine handling of devicetrees for OF_UPSTREAM
      binman: Adjust naming for reading symbols
      binman: Add minor improvements to symbol-writing
      binman: Provide a way to set the symbol base address
      binman: Unwind the end-at-4gb special-case a little
      binman: Allow image_pos to be None when writing symbols
      binman: Make a start on an iMX8 test

 tools/binman/binman.rst                       |  19 +++++++-
 tools/binman/btool/fdtgrep.py                 |   3 +-
 tools/binman/elf.py                           |  14 ++++--
 tools/binman/elf_test.py                      |   4 +-
 tools/binman/entry.py                         |  25 +++++++++-
 tools/binman/etype/atf_fip.py                 |   2 +-
 tools/binman/etype/blob_phase.py              |   5 ++
 tools/binman/etype/cbfs.py                    |   2 +-
 tools/binman/etype/efi_capsule.py             |   2 +
 tools/binman/etype/fit.py                     | 116
++++++++++++++++++++++++++++-----------------
 tools/binman/etype/nxp_imx8mimage.py          |   3 +-
 tools/binman/etype/section.py                 |  31 ++++++------
 tools/binman/ftest.py                         | 152
+++++++++++++++++++++++++++++++++++++++++++++++++++--------
 tools/binman/image.py                         |  21 ++++-----
 tools/binman/image_test.py                    |   8 ++--
 tools/binman/test/336_symbols_base.dts        |  23 +++++++++
 tools/binman/test/337_symbols_base_expand.dts |  24 ++++++++++
 tools/binman/test/338_symbols_comp.dts        |  26 ++++++++++
 tools/binman/test/339_nxp_imx8.dts            |  17 +++++++
 tools/buildman/builder.py                     |  27 ++++++++++-
 tools/buildman/builderthread.py               |  12 ++++-
 tools/buildman/buildman.rst                   |   3 ++
 tools/buildman/cmdline.py                     |   2 +
 tools/buildman/control.py                     |   3 +-
 tools/buildman/test.py                        |  31 ++++++++++++
 25 files changed, 460 insertions(+), 115 deletions(-)
 create mode 100644 tools/binman/test/336_symbols_base.dts
 create mode 100644 tools/binman/test/337_symbols_base_expand.dts
 create mode 100644 tools/binman/test/338_symbols_comp.dts
 create mode 100644 tools/binman/test/339_nxp_imx8.dts


Regards,
Simon
