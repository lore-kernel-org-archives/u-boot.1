Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643A5C7EE43
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6EF865AF;
	Thu, 24 Aug 2023 16:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g+EFOOV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133A68522C; Thu, 24 Aug 2023 16:41:39 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E240486604
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-523b066d7ceso8592627a12.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692888094; x=1693492894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QmASuGLsFXPZGYQTVN/ZvkeattiPcp0s5R3XOCfrqCw=;
 b=g+EFOOV+7qlp6m3fXwRhIVnb9i9mxFBED7C7aZm+YF8q33ft1NnDsR3EGITlLw4Wu5
 Ny04lgxY8V5lx2Y+yT8jFr610gAtgQWfa5c+uLmkMcIkoSd6WV5mLAVXdz8uZmM/KOWH
 xBPweCzpVtCaNVuUHjS5UjSYbkR9qGso1ba9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888094; x=1693492894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QmASuGLsFXPZGYQTVN/ZvkeattiPcp0s5R3XOCfrqCw=;
 b=b3Ou3Jcx1OJMSz8Ny7UKPY7rlFXb+q24CYRhJVFnDJXwgN329geUHGtS7gYbVejyU8
 GxIGlTgj2ddFG3a4+g3sCWYmxi+jNLP8fSMvx/NGSU6MlqnbQDcJESefuSCimR4WIMcG
 o78y4lwNW+iKkbCTqA9SUwnOaig4ry4NmJ4OU6Cr+8cJasITqO9GCTcsAf6ljkmek/JR
 jVuxQZe+bZSBJTsQQhS8MT4yLo+tL4xE5yolkCoKfAMOx19m+YGdHYivOLqxQB4UhmgN
 W0jUvCNQiFKi/K5/FyoV/S/XsL9mfwlngY2ZH9sbhj4OgE79E3pE9MZS/DfF2qeKIh43
 Y9gA==
X-Gm-Message-State: AOJu0YyCxi24CWIOfJa/VtamiC0I2htE78fKaKt5UCTsAV61dnIEQ2oU
 ADZ0aAlUMcvSz56pDXdZ1/loWEOmcyWV7PrqBVAZcA==
X-Google-Smtp-Source: AGHT+IGKO7oElkao32t6ejJDI9IY552stF77URpGFQm6fkzYN8+qdr3VKQZDOsZqFRPSsY8QRPd3zPAoFlGaEZdeiVE=
X-Received: by 2002:aa7:c648:0:b0:525:7e46:940 with SMTP id
 z8-20020aa7c648000000b005257e460940mr13477843edr.24.1692888094318; Thu, 24
 Aug 2023 07:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824133814.GH3953269@bill-the-cat>
In-Reply-To: <20230824133814.GH3953269@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Aug 2023 08:41:21 -0600
Message-ID: <CAPnjgZ1oY9SRWNj9RUe2L8=1ndE2LfxkmqqEj-MNtxL_ff-QyQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Dillon Min <dillon.minfei@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>,
 Marek Vasut <marex@denx.de>, 
 Michael Walle <michael@walle.cc>, Neha Malcom Francis <n-francis@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
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

On Thu, 24 Aug 2023 at 07:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 23, 2023 at 09:02:53PM -0600, Simon Glass wrote:
>
> > In this early stage of using binman to produce output files, we are mostly
> > seeing people using common extensions such as '.bin' and '.rom'
> >
> > But unusual extensions appear in some places.
> >
> > We would like 'buildman -k' to keep the build outputs, but this is hard if
> > there is no consistency as to the extension used.
> >
> > This series adjusts binman to enforce just 4 extensions for output images:
> >
> >    .bin
> >    .rom
> >    .itb
> >    .img
> >
> > Other extensions will produce an error. With this rule observed, buildman
> > can keep the required files.
> >
> > Some patches are included to fix up some easy problems. But the following
> > boards generate 'custMpk.pem' and it is not clear how to fix this, so I am
> > asking for help from the maintainers:
> >
> >    am62ax_evm_r5 am62x_evm_r5 am64x_evm_r5 am65x_evm_r5
> >    am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc am65x_hs_evm_r5
> >    j7200_evm_r5 j721e_evm_r5 j721s2_evm_r5 verdin-am62_r5
> >    am62ax_evm_a53 am62x_evm_a53 am64x_evm_a53 am65x_evm_a53
> >    am65x_hs_evm_a53 j7200_evm_a72 j721e_evm_a72 j721s2_evm_a72
> >    verdin-am62_a53
> >
> > It looks like the .pem files are listed as top-level images, e.g.:
> >
> >    &custmpk_pem {
> >       filename = "../../ti/keys/custMpk.pem";
> >    };
> >
> > but if the only objective is to pick up an existing file, it is better to
> > set BINMAN_INDIRS to include that directory. Also we should only have
> > simple leafnames in the 'filename' property, so the '../../ti/keys' is not
> > correct. It makes it harder for people to get the files from other places.
> > Making this easier is one of binman's goals.
> >
> > Most likely the custmpk_pem node can be removed and the .pem file can be
> > included directly in the place that needs it, e.g. by adjusting the
> > ti-secure-rom etype (or ex509_cert) to use tools.get_input_filename() when
> > reading the key file.
> >
> > For example, this:
> >
> >    custMpk {
> >       filename = "custMpk.pem";
> >       custmpk_pem: blob-ext {
> >          filename = "../keys/custMpk.pem";
> >       };
> >    };
> >
> > is really just copying a file from '../keys/custMpk.pem' to 'custMpk.pem'
> > so is equivalent to:
> >
> >    custMpk {
> >       type = "blob";
> >       filename = "custMpk.pem";
> >    }
> >
> > (note that blob-ext implies that the blob may be missing, so blob is a
> > better choice, since the key cannot be missing)
> >
> > The fact that the .pem files are at the top level means that they are
> > output images, which surely is not intended. They should be buried in the
> > image description, at a lower level, as part of something else.
> >
> > So please take a loke at the above and see if the binman descriptions can
> > be reworked slightly to follow these new rules.
> >
> >
> > Simon Glass (6):
> >   binman: Require image filenames to have certain extensions
> >   buildman: Keep all permitted output files
> >   buildman: Show progress when regenerating the board.cfg file
> >   buildman: Start the clock when the build starts
> >   kontron_sl28: Use u-boot-update.bin instead of u-boot.update
> >   stm32mp15: Use u-boot-spl-stm32.bin instead of u-boot-spl.stm32
> >
> >  .../dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi   |  2 +-
> >  arch/arm/dts/stm32mp15-u-boot.dtsi             |  2 +-
> >  doc/board/kontron/sl28.rst                     |  4 ++--
> >  doc/board/st/stm32mp1.rst                      | 18 +++++++++---------
> >  include/configs/stm32mp15_dh_dhsom.h           |  2 +-
> >  tools/binman/binman.rst                        |  5 +++++
> >  tools/binman/etype/section.py                  |  3 +--
> >  tools/binman/ftest.py                          | 12 ++++++++++--
> >  tools/binman/image.py                          |  9 +++++++++
> >  tools/binman/test/022_image_name.dts           |  4 ++--
> >  tools/binman/test/311_bad_image_name.dts       | 17 +++++++++++++++++
> >  tools/buildman/boards.py                       | 15 ++++++++++++---
> >  tools/buildman/builder.py                      |  3 ++-
> >  tools/buildman/builderthread.py                | 11 +++++++----
> >  tools/buildman/control.py                      |  3 ++-
> >  15 files changed, 81 insertions(+), 29 deletions(-)
> >  create mode 100644 tools/binman/test/311_bad_image_name.dts
>
> This doesn't seem to address the ones I pointed out on IRC as being the
> first order (to me anyhow) problem of needing the _unsigned files on the
> platforms you list above for PEM files.

I think it should be xxx-unsigned.bin instead of xxx.bin_unsigned

Regards,
Simon
