Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D749CEF16C
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E20881A2;
	Tue,  8 Oct 2024 15:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iLrv1k9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82AF288CF1; Tue,  8 Oct 2024 15:13:30 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4795881A2
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5398e7dda5fso5630511e87.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728393207; x=1728998007;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=S7qwKArmsXcqSmfBwhXEAkwjnNsA2JLgCDsHxboQbRo=;
 b=iLrv1k9P16jdLc6lbxfOHxDZ6640Lj+A8Ep9KS+62etDA6RykLj9NSqshGl3No2K60
 ZzqVSxmfwcHJYnewppsSFXTOoPSlKyTbH3SNU2icJWRrIa1e6AWivxJ37c4uEOHZp9B1
 PvaLyAO6M6GEZd06sFMi6vXXfG7Yq0FifvxXnsG11p6HrP6pdItk4uuY7MYndpZpfFI+
 HRuhxbpbwJ8/OFPxUYQKfKwW66b4Le2PtRxWtR07E8n98kI0qXd+zUnbvYhcibOk7Ewf
 ZDM4rlx0lkrP1ophZw37dPxzFcu95/Zb/lyDD5rnfk66k1JUukqPqN217HppgevWKufg
 b+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728393207; x=1728998007;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S7qwKArmsXcqSmfBwhXEAkwjnNsA2JLgCDsHxboQbRo=;
 b=dm90JAWfenPyW0vNE8ek1iKqy/laDTKP1G9NG9cvx/TAgcQ5lVXKkfzHte5vcNvEfN
 fkZpq0fvju0pAzcQ6l3XJ3WJyBWDSFSrA1SttGikyQgNDzuL/Hjjsq+35nxjsFvAaaNh
 2F3jdYlmjMYcPY+fKJ9mQXZwhM7EbEb0986t8dG4CNOd94c2qAvxwYZO55+Z9Qrv2CT0
 Xu/nUSxCbatFnVepgLOFC6FYFGunUbNpRB95I/L2re/+waryCKQ4UGLJA7oK2icKqsuV
 hkHSdX+FhhZs+I3RdLtw832PJ5+Yrr2K2MYxfj9wRyceNK5W+d67ya7y2E+NXBUyD7jB
 3snA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk6QItPQsAQADbZQLbw8/4lSjgLAzhJN0JxwO0f2sHAIi83XWu9ckQg/vRdc/CB13Dyfctu/c=@lists.denx.de
X-Gm-Message-State: AOJu0YwJQ6S5Y2Z5rbSkgbhPWWFFvfQ6hDHfh2tRqbcTbok+Ipmk6cFz
 8+2kAPR1StpXlJcEf3BRs5OX3Xfe6MHMHRGD8p20urxZR6ojgJXuBOocMgH9mnE=
X-Google-Smtp-Source: AGHT+IEBVkXDB/jHXjHcYs42CqPyn9J1UxGZe0KgobBtxdTsILAo1HrTV9TYSy6BVxP0DgpoPCugdQ==
X-Received: by 2002:a05:6512:1326:b0:538:9e24:a3c9 with SMTP id
 2adb3069b0e04-539ab876ed9mr6802203e87.20.1728393206727; 
 Tue, 08 Oct 2024 06:13:26 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430520e8c60sm19631695e9.8.2024.10.08.06.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:13:26 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Brian Ruley
 <brian.ruley@gehealthcare.com>, Marek Vasut <marex@denx.de>, Simon Glass
 <sjg@chromium.org>, Alexander Dahl <ada@thorsis.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Joao Marcos Costa <jmcosta944@gmail.com>, Neha
 Malcom Francis <n-francis@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Sumit Garg
 <sumit.garg@linaro.org>
Subject: Re: [PATCH 3/3] binman: Add a tutorial on resolving test-coverage bugs
In-Reply-To: <20240930185139.2185983-3-sjg@chromium.org>
References: <20240930185139.2185983-1-sjg@chromium.org>
 <20240930185139.2185983-3-sjg@chromium.org>
Date: Tue, 08 Oct 2024 15:13:23 +0200
Message-ID: <87frp6g2ks.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

It's really great to have this documented.
I found a couple of small typos, hope that helps.

On lun., sept. 30, 2024 at 12:51, Simon Glass <sjg@chromium.org> wrote:

> Provide a short description of how tests work, why they are so critical
> and how to resolve gaps in Binman's test coverage.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  MAINTAINERS                  |   1 +
>  doc/develop/binman_tests.rst | 734 +++++++++++++++++++++++++++++++++++
>  doc/develop/index.rst        |   1 +
>  tools/binman/binman.rst      |   5 +
>  4 files changed, 741 insertions(+)
>  create mode 100644 doc/develop/binman_tests.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ab39d91a55..65a9ea1face 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -909,6 +909,7 @@ BINMAN
>  M:	Simon Glass <sjg@chromium.org>
>  M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
>  S:	Maintained
> +F:	doc/develop/binman_tests.rst
>  F:	tools/binman/
>  
>  BLKMAP
> diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
> new file mode 100644
> index 00000000000..a632694a6fe
> --- /dev/null
> +++ b/doc/develop/binman_tests.rst
> @@ -0,0 +1,734 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +Binman Tests
> +============
> +
> +.. contents::
> +   :depth: 2
> +   :local:
> +
> +There is some material on writing tests in the main Binman documentation
> +(see :doc:`package/index`). This short guide is separate so people don't
> +feel they have to read as much.
> +
> +Code and output is mostly included verbatim, which makes the doc longer, but
> +avoids its becoming confusing when the output or referenced code changes in the
> +future.
> +
> +Purpose
> +-------
> +
> +The main purpose of tests in Binman is to make sure that Binman actually does
> +what it is supposed to. Various people contribute code, refactoring is done
> +over time, but U-Boot users (developers, SoC vendors, board vendors) rely on
> +Binman producing images which function correctly. Without tests, a one-line
> +change could unintentionally break a corner-case and the problem might not be
> +noticed for months. Debugging an image-generation problem with a board you
> +don't have can be very hard.
> +
> +A secondary purpose is productivity. U-Boot contributors are busy and often
> +have too much on their plate. Trying to figure out why their patch broke
> +some other vendor's workflow can be very time-consuming and frustrating. By
> +building in tests from the start, this is largely avoided. If your change has
> +full test coverage and doesn't break any test, all is well and no one can
> +complain.
> +
> +A lessor purpose is to document what Binman actually does. If a test covers a

Lessor? I think this should be lesser ?

> +feature, it works. If there is no test coverage, no one can say for sure
> +whether it works in all expected situations, certainly not wihout manual

s/wihout/without

> +effort.
> +
> +In fact, strictly speaking it isn't completely clear what 'works' even means in
> +the case where these is no test to cover the code. We are often left guessing

s/these/there

> +as to what the documentation means, what was actually intended, etc.
> +
> +Finally, code-coverage helps to remove 'zombie code', copied from elsewhere
> +because it looks reasonable, but not actually needed. The same situation arises
> +in silicon-chip design, where a part of the chip is not validated. If it isn't
> +validated, it can be assumed not to work, either now or later, so it is best to
> +remove that logic to avoid it causing problems.
> +
> +Setting up
> +----------
> +
> +Binman tests use various utility programs. Most of these are documented in
> +:doc:`../build/gcc`. But some are SoC-specific. To fetch these, tell Binman to
> +fetch or build any missing tools:
> +
> +.. code-block:: bash
> +
> +    $ binman tool -f missing
> +
> +When this completes successfully, you can list the tools. You should see
> +something like this:
> +
> +.. code-block:: bash
> +
> +    $ binman tool -l
> +    Name             Version      Description                Path
> +    ---------------  -----------  -------------------------  ------------------------------
> +    bootgen          ****** Bootg Xilinx Bootgen             /home/sglass/.binman-tools/bootgen
> +    bzip2            1.0.8        bzip2 compression          /usr/bin/bzip2
> +    cbfstool         unknown      Manipulate CBFS files      /home/sglass/bin/cbfstool
> +    fdt_add_pubkey   unknown      Generate image for U-Boot  /home/sglass/bin/fdt_add_pubkey
> +    fdtgrep          unknown      Grep devicetree files      /home/sglass/bin/fdtgrep
> +    fiptool          v2.11.0(rele Manipulate ATF FIP files   /home/sglass/.binman-tools/fiptool
> +    futility         v0.0.1-9f2e9 Chromium OS firmware utili /home/sglass/.binman-tools/futility
> +    gzip             1.12         gzip compression           /usr/bin/gzip
> +    ifwitool         unknown      Manipulate Intel IFWI file /home/sglass/.binman-tools/ifwitool
> +    lz4              v1.9.4       lz4 compression            /usr/bin/lz4
> +    lzma_alone       9.22 beta    lzma_alone compression     /usr/bin/lzma_alone
> +    lzop             v1.04        lzo compression            /usr/bin/lzop
> +    mkeficapsule     2024.10-rc5- mkeficapsule tool for gene /home/sglass/bin/mkeficapsule
> +    mkimage          2024.10-rc5- Generate image for U-Boot  /home/sglass/bin/mkimage
> +    openssl          3.0.13 30 Ja openssl cryptography toolk /usr/bin/openssl
> +    xz               5.4.5        xz compression             /usr/bin/xz
> +    zstd             v1.5.5       zstd compression           /usr/bin/zstd
> +
> +The tools are written to ``~/.binman-tools`` so add that to your ``PATH``.
> +It's fine to have some of the tools elsewhere (e.g. ``~/bin``) so long as they
> +are up-to-date. This allows you use the version of the tools intended for
> +running tests.
> +
> +Now you should be able to actually run the tests:
> +
> +.. code-block:: bash
> +
> +    $ binman test
> +    ======================== Running binman tests ========================
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ........
> +    ----------------------------------------------------------------------
> +    Ran 568 tests in 2.578s
> +
> +    OK
> +
> +If this doesn't work, see if you can have some missing tools. Check that the
> +dependencies are all there as above. If it is very slow, try installing
> +concurrencytest so that the tests run in parallel.
> +
> +The next thing to set up is code coverage, using the -T flag:
> +
> +.. code-block:: bash
> +
> +    $ binman test -T
> +    ======================== Running binman tests ========================
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ......................................................................
> +    ........
> +    ----------------------------------------------------------------------
> +    Ran 568 tests in 17.367s
> +
> +    OK
> +
> +    99%
> +    Name                                                    Stmts   Miss  Cover
> +    ---------------------------------------------------------------------------
> +    tools/binman/__init__.py                                    0      0   100%
> +    tools/binman/bintool.py                                   263      0   100%
> +    tools/binman/btool/bootgen.py                              21      0   100%
> +    tools/binman/btool/btool_gzip.py                            5      0   100%
> +    tools/binman/btool/bzip2.py                                 5      0   100%
> +    tools/binman/btool/cbfstool.py                             24      0   100%
> +    tools/binman/btool/cst.py                                  15      4    73%
> +    tools/binman/btool/fdt_add_pubkey.py                       21      0   100%
> +    tools/binman/btool/fdtgrep.py                              26      0   100%
> +    tools/binman/btool/fiptool.py                              19      0   100%
> +    tools/binman/btool/futility.py                             19      0   100%
> +    tools/binman/btool/ifwitool.py                             22      0   100%
> +    tools/binman/btool/lz4.py                                  22      0   100%
> +    tools/binman/btool/lzma_alone.py                           34      0   100%
> +    tools/binman/btool/lzop.py                                  5      0   100%
> +    tools/binman/btool/mkeficapsule.py                         27      0   100%
> +    tools/binman/btool/mkimage.py                              23      0   100%
> +    tools/binman/btool/openssl.py                              42      0   100%
> +    tools/binman/btool/xz.py                                    5      0   100%
> +    tools/binman/btool/zstd.py                                  5      0   100%
> +    tools/binman/cbfs_util.py                                 376      0   100%
> +    tools/binman/cmdline.py                                    90      0   100%
> +    tools/binman/control.py                                   409      0   100%
> +    tools/binman/elf.py                                       241      0   100%
> +    tools/binman/entry.py                                     548      0   100%
> +    tools/binman/etype/alternates_fdt.py                       58      0   100%
> +    tools/binman/etype/atf_bl31.py                              5      0   100%
> +    tools/binman/etype/atf_fip.py                              67      0   100%
> +    tools/binman/etype/blob.py                                 49      0   100%
> +    tools/binman/etype/blob_dtb.py                             46      0   100%
> +    tools/binman/etype/blob_ext.py                              9      0   100%
> +    tools/binman/etype/blob_ext_list.py                        32      0   100%
> +    tools/binman/etype/blob_named_by_arg.py                     9      0   100%
> +    tools/binman/etype/blob_phase.py                           22      0   100%
> +    tools/binman/etype/cbfs.py                                101      0   100%
> +    tools/binman/etype/collection.py                           30      0   100%
> +    tools/binman/etype/cros_ec_rw.py                            5      0   100%
> +    tools/binman/etype/efi_capsule.py                          59      0   100%
> +    tools/binman/etype/efi_empty_capsule.py                    33      0   100%
> +    tools/binman/etype/encrypted.py                            34      0   100%
> +    tools/binman/etype/fdtmap.py                               62      0   100%
> +    tools/binman/etype/files.py                                35      0   100%
> +    tools/binman/etype/fill.py                                 13      0   100%
> +    tools/binman/etype/fit.py                                 311      0   100%
> +    tools/binman/etype/fmap.py                                 37      0   100%
> +    tools/binman/etype/gbb.py                                  37      0   100%
> +    tools/binman/etype/image_header.py                         53      0   100%
> +    tools/binman/etype/intel_cmc.py                             4      0   100%
> +    tools/binman/etype/intel_descriptor.py                     39      0   100%
> +    tools/binman/etype/intel_fit.py                            12      0   100%
> +    tools/binman/etype/intel_fit_ptr.py                        17      0   100%
> +    tools/binman/etype/intel_fsp.py                             4      0   100%
> +    tools/binman/etype/intel_fsp_m.py                           4      0   100%
> +    tools/binman/etype/intel_fsp_s.py                           4      0   100%
> +    tools/binman/etype/intel_fsp_t.py                           4      0   100%
> +    tools/binman/etype/intel_ifwi.py                           67      0   100%
> +    tools/binman/etype/intel_me.py                              4      0   100%
> +    tools/binman/etype/intel_mrc.py                             6      0   100%
> +    tools/binman/etype/intel_refcode.py                         6      0   100%
> +    tools/binman/etype/intel_vbt.py                             4      0   100%
> +    tools/binman/etype/intel_vga.py                             4      0   100%
> +    tools/binman/etype/mkimage.py                              84      0   100%
> +    tools/binman/etype/null.py                                  9      0   100%
> +    tools/binman/etype/nxp_imx8mcst.py                         78     59    24%
> +    tools/binman/etype/nxp_imx8mimage.py                       38      6    84%
> +    tools/binman/etype/opensbi.py                               5      0   100%
> +    tools/binman/etype/powerpc_mpc85xx_bootpg_resetvec.py       6      0   100%
> +    tools/binman/etype/pre_load.py                             76      0   100%
> +    tools/binman/etype/rockchip_tpl.py                          5      0   100%
> +    tools/binman/etype/scp.py                                   5      0   100%
> +    tools/binman/etype/section.py                             418      0   100%
> +    tools/binman/etype/tee_os.py                               31      0   100%
> +    tools/binman/etype/text.py                                 21      0   100%
> +    tools/binman/etype/ti_board_config.py                     139      0   100%
> +    tools/binman/etype/ti_dm.py                                 5      0   100%
> +    tools/binman/etype/ti_secure.py                            65      0   100%
> +    tools/binman/etype/ti_secure_rom.py                       117      0   100%
> +    tools/binman/etype/u_boot.py                                7      0   100%
> +    tools/binman/etype/u_boot_dtb.py                            9      0   100%
> +    tools/binman/etype/u_boot_dtb_with_ucode.py                51      0   100%
> +    tools/binman/etype/u_boot_elf.py                           19      0   100%
> +    tools/binman/etype/u_boot_env.py                           27      0   100%
> +    tools/binman/etype/u_boot_expanded.py                       4      0   100%
> +    tools/binman/etype/u_boot_img.py                            7      0   100%
> +    tools/binman/etype/u_boot_nodtb.py                          7      0   100%
> +    tools/binman/etype/u_boot_spl.py                            8      0   100%
> +    tools/binman/etype/u_boot_spl_bss_pad.py                   14      0   100%
> +    tools/binman/etype/u_boot_spl_dtb.py                        9      0   100%
> +    tools/binman/etype/u_boot_spl_elf.py                        8      0   100%
> +    tools/binman/etype/u_boot_spl_expanded.py                  12      0   100%
> +    tools/binman/etype/u_boot_spl_nodtb.py                      8      0   100%
> +    tools/binman/etype/u_boot_spl_pubkey_dtb.py                32      0   100%
> +    tools/binman/etype/u_boot_spl_with_ucode_ptr.py             8      0   100%
> +    tools/binman/etype/u_boot_tpl.py                            8      0   100%
> +    tools/binman/etype/u_boot_tpl_bss_pad.py                   14      0   100%
> +    tools/binman/etype/u_boot_tpl_dtb.py                        9      0   100%
> +    tools/binman/etype/u_boot_tpl_dtb_with_ucode.py             8      0   100%
> +    tools/binman/etype/u_boot_tpl_elf.py                        8      0   100%
> +    tools/binman/etype/u_boot_tpl_expanded.py                  12      0   100%
> +    tools/binman/etype/u_boot_tpl_nodtb.py                      8      0   100%
> +    tools/binman/etype/u_boot_tpl_with_ucode_ptr.py            12      0   100%
> +    tools/binman/etype/u_boot_ucode.py                         33      0   100%
> +    tools/binman/etype/u_boot_vpl.py                            8      0   100%
> +    tools/binman/etype/u_boot_vpl_bss_pad.py                   14      0   100%
> +    tools/binman/etype/u_boot_vpl_dtb.py                        9      0   100%
> +    tools/binman/etype/u_boot_vpl_elf.py                        8      0   100%
> +    tools/binman/etype/u_boot_vpl_expanded.py                  12      0   100%
> +    tools/binman/etype/u_boot_vpl_nodtb.py                      8      0   100%
> +    tools/binman/etype/u_boot_with_ucode_ptr.py                42      0   100%
> +    tools/binman/etype/vblock.py                               38      0   100%
> +    tools/binman/etype/x86_reset16.py                           7      0   100%
> +    tools/binman/etype/x86_reset16_spl.py                       7      0   100%
> +    tools/binman/etype/x86_reset16_tpl.py                       7      0   100%
> +    tools/binman/etype/x86_start16.py                           7      0   100%
> +    tools/binman/etype/x86_start16_spl.py                       7      0   100%
> +    tools/binman/etype/x86_start16_tpl.py                       7      0   100%
> +    tools/binman/etype/x509_cert.py                            71      0   100%
> +    tools/binman/etype/xilinx_bootgen.py                       72      0   100%
> +    tools/binman/fip_util.py                                  202      0   100%
> +    tools/binman/fmap_util.py                                  49      0   100%
> +    tools/binman/image.py                                     181      0   100%
> +    tools/binman/state.py                                     201      0   100%
> +    ---------------------------------------------------------------------------
> +    TOTAL                                                    5954     69    99%
> +
> +    To get a report in 'htmlcov/index.html', type: python3-coverage html
> +    Coverage error: 99%, but should be 100%
> +    ValueError: Test coverage failure
> +
> +Unfortunately the run failed. As it suggests, create a report:
> +
> +.. code-block:: bash
> +
> +    $ python3-coverage html
> +    Wrote HTML report to htmlcov/index.html
> +
> +If you open that file in the browser, you can see which files are not reaching
> +100% and click on them. Here is ``nxp_imx8mimage.py``, for example:
> +
> +.. code-block:: python
> +
> +    43        # Generate mkimage configuration file similar to imx8mimage.cfg
> +    44        # and pass it to mkimage to generate SPL image for us here.
> +    45        cfg_fname = tools.get_output_filename('nxp.imx8mimage.cfg.%s' % uniq)
> +    46        with open(cfg_fname, 'w') as outf:
> +    47            print('ROM_VERSION v%d' % self.rom_version, file=outf)
> +    48            print('BOOT_FROM %s' % self.boot_from, file=outf)
> +    49            print('LOADER %s %#x' % (input_fname, self.loader_address), file=outf)
> +    50
> +    51        output_fname = tools.get_output_filename(f'cfg-out.{uniq}')
> +    52        args = ['-d', input_fname, '-n', cfg_fname, '-T', 'imx8mimage',
> +    53                output_fname]
> +    54        if self.mkimage.run_cmd(*args) is not None:
> +    55            return tools.read_file(output_fname)
> +    56        else:
> +    57            # Bintool is missing; just use the input data as the output
> +    58 x          self.record_missing_bintool(self.mkimage)
> +    59 x          return data
> +    60
> +    61    def SetImagePos(self, image_pos):
> +    62        # Customized SoC specific SetImagePos which skips the mkimage etype
> +    63        # implementation and removes the 0x48 offset introduced there. That
> +    64        # offset is only used for uImage/fitImage, which is not the case in
> +    65        # here.
> +    66        upto = 0x00
> +    67        for entry in super().GetEntries().values():
> +    68 x          entry.SetOffsetSize(upto, None)
> +    69
> +    70            # Give up if any entries lack a size
> +    71 x          if entry.size is None:
> +    72 x              return
> +    73 x          upto += entry.size
> +    74
> +    75        Entry_section.SetImagePos(self, image_pos)
> +
> +Most of the file is covered, but the lines marked with ``x`` indicate missing
> +coverage. The will show up red in your browser.

The what? The line ?


With those addressed, feel free to add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> +
> +What is a test?

[...]

