Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB06AC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44EBE86504;
	Thu, 24 Aug 2023 16:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QYKf1ooq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E336B86414; Thu, 24 Aug 2023 16:49:50 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0C286504
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so2107966a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692888587; x=1693493387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jo5yTwACgNKISyKoQ2ECwBq1iLOWfVnl1zj2mZwxM9w=;
 b=QYKf1ooqy9V5vh753H8lwarnxJ+HNQyBFllVWO0/zwxuAQmH/YVJYRIItc/Fw4NAZz
 VUeuD7hUcRn6Ww94MR4lBaIohVKLO/fRhUpkogW3jaQn1I3uCAiFKxQbAJZL8ZvQSaPA
 +miM+GtN/lEnCQdu0otaN8IAm90gNrrH4Ar2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888587; x=1693493387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jo5yTwACgNKISyKoQ2ECwBq1iLOWfVnl1zj2mZwxM9w=;
 b=BBzBC54hIxHqu4y9IaV8tg6OTg9ce+oUuWyxzyOZWmmE287EZxWFnnlAXpkrJSa3W5
 1IRd16ehsbjWZd9YeYJPzvQugn14mb7Hq0k3sCTclfak5gU7xcdqhWf2EdZ22UE3XueT
 TfkftzLKGJPi69MmR8lqhh2YIVUDjfdELcmiEXIzLxK1SzCIkryW1xweQCcPOqnMw4ec
 AWIA3o6V2VUKwActyQ8Mp5yRFPoZ+LGMVjKZUEw8GgYx7RogAmbB7J9g4/otILz+thsZ
 TQ/t7DA/99oWVlOveQhK7sjQ+QB8rRQ2incAyGzkO5syEa28dA1oYjI8PbpW4EDqUIKx
 EBNg==
X-Gm-Message-State: AOJu0YwlWEuJ6pvbsUG9NdBpoWBT73WGYegVgyOn1qsW72AVMy46Rrlq
 KKJLxXo9H4Xwlh92laDHVxrk2sEznAKY7///8K4Low==
X-Google-Smtp-Source: AGHT+IHndDXK/FnrEo2bTH1g2H/6fCkujZCmn8E942aV70u6PP3xC79HP3cxfSRmjlq6f86KQO5GMtHnzMT6ZlJ9WA8=
X-Received: by 2002:a05:6402:d56:b0:525:4d74:be8c with SMTP id
 ec22-20020a0564020d5600b005254d74be8cmr14675349edb.14.1692888587523; Thu, 24
 Aug 2023 07:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824133814.GH3953269@bill-the-cat>
 <CAPnjgZ1oY9SRWNj9RUe2L8=1ndE2LfxkmqqEj-MNtxL_ff-QyQ@mail.gmail.com>
 <20230824144535.GP3953269@bill-the-cat>
In-Reply-To: <20230824144535.GP3953269@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Aug 2023 08:49:36 -0600
Message-ID: <CAPnjgZ3Xh0HY3psNbWSZViLgECuDSfdg1zmh7c=OsaiL4a_TjA@mail.gmail.com>
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

On Thu, 24 Aug 2023 at 08:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 24, 2023 at 08:41:21AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 24 Aug 2023 at 07:38, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 23, 2023 at 09:02:53PM -0600, Simon Glass wrote:
> > >
> > > > In this early stage of using binman to produce output files, we are mostly
> > > > seeing people using common extensions such as '.bin' and '.rom'
> > > >
> > > > But unusual extensions appear in some places.
> > > >
> > > > We would like 'buildman -k' to keep the build outputs, but this is hard if
> > > > there is no consistency as to the extension used.
> > > >
> > > > This series adjusts binman to enforce just 4 extensions for output images:
> > > >
> > > >    .bin
> > > >    .rom
> > > >    .itb
> > > >    .img
> > > >
> > > > Other extensions will produce an error. With this rule observed, buildman
> > > > can keep the required files.
> > > >
> > > > Some patches are included to fix up some easy problems. But the following
> > > > boards generate 'custMpk.pem' and it is not clear how to fix this, so I am
> > > > asking for help from the maintainers:
> > > >
> > > >    am62ax_evm_r5 am62x_evm_r5 am64x_evm_r5 am65x_evm_r5
> > > >    am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc am65x_hs_evm_r5
> > > >    j7200_evm_r5 j721e_evm_r5 j721s2_evm_r5 verdin-am62_r5
> > > >    am62ax_evm_a53 am62x_evm_a53 am64x_evm_a53 am65x_evm_a53
> > > >    am65x_hs_evm_a53 j7200_evm_a72 j721e_evm_a72 j721s2_evm_a72
> > > >    verdin-am62_a53
> > > >
> > > > It looks like the .pem files are listed as top-level images, e.g.:
> > > >
> > > >    &custmpk_pem {
> > > >       filename = "../../ti/keys/custMpk.pem";
> > > >    };
> > > >
> > > > but if the only objective is to pick up an existing file, it is better to
> > > > set BINMAN_INDIRS to include that directory. Also we should only have
> > > > simple leafnames in the 'filename' property, so the '../../ti/keys' is not
> > > > correct. It makes it harder for people to get the files from other places.
> > > > Making this easier is one of binman's goals.
> > > >
> > > > Most likely the custmpk_pem node can be removed and the .pem file can be
> > > > included directly in the place that needs it, e.g. by adjusting the
> > > > ti-secure-rom etype (or ex509_cert) to use tools.get_input_filename() when
> > > > reading the key file.
> > > >
> > > > For example, this:
> > > >
> > > >    custMpk {
> > > >       filename = "custMpk.pem";
> > > >       custmpk_pem: blob-ext {
> > > >          filename = "../keys/custMpk.pem";
> > > >       };
> > > >    };
> > > >
> > > > is really just copying a file from '../keys/custMpk.pem' to 'custMpk.pem'
> > > > so is equivalent to:
> > > >
> > > >    custMpk {
> > > >       type = "blob";
> > > >       filename = "custMpk.pem";
> > > >    }
> > > >
> > > > (note that blob-ext implies that the blob may be missing, so blob is a
> > > > better choice, since the key cannot be missing)
> > > >
> > > > The fact that the .pem files are at the top level means that they are
> > > > output images, which surely is not intended. They should be buried in the
> > > > image description, at a lower level, as part of something else.
> > > >
> > > > So please take a loke at the above and see if the binman descriptions can
> > > > be reworked slightly to follow these new rules.
> > > >
> > > >
> > > > Simon Glass (6):
> > > >   binman: Require image filenames to have certain extensions
> > > >   buildman: Keep all permitted output files
> > > >   buildman: Show progress when regenerating the board.cfg file
> > > >   buildman: Start the clock when the build starts
> > > >   kontron_sl28: Use u-boot-update.bin instead of u-boot.update
> > > >   stm32mp15: Use u-boot-spl-stm32.bin instead of u-boot-spl.stm32
> > > >
> > > >  .../dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi   |  2 +-
> > > >  arch/arm/dts/stm32mp15-u-boot.dtsi             |  2 +-
> > > >  doc/board/kontron/sl28.rst                     |  4 ++--
> > > >  doc/board/st/stm32mp1.rst                      | 18 +++++++++---------
> > > >  include/configs/stm32mp15_dh_dhsom.h           |  2 +-
> > > >  tools/binman/binman.rst                        |  5 +++++
> > > >  tools/binman/etype/section.py                  |  3 +--
> > > >  tools/binman/ftest.py                          | 12 ++++++++++--
> > > >  tools/binman/image.py                          |  9 +++++++++
> > > >  tools/binman/test/022_image_name.dts           |  4 ++--
> > > >  tools/binman/test/311_bad_image_name.dts       | 17 +++++++++++++++++
> > > >  tools/buildman/boards.py                       | 15 ++++++++++++---
> > > >  tools/buildman/builder.py                      |  3 ++-
> > > >  tools/buildman/builderthread.py                | 11 +++++++----
> > > >  tools/buildman/control.py                      |  3 ++-
> > > >  15 files changed, 81 insertions(+), 29 deletions(-)
> > > >  create mode 100644 tools/binman/test/311_bad_image_name.dts
> > >
> > > This doesn't seem to address the ones I pointed out on IRC as being the
> > > first order (to me anyhow) problem of needing the _unsigned files on the
> > > platforms you list above for PEM files.
> >
> > I think it should be xxx-unsigned.bin instead of xxx.bin_unsigned
>
> As I was saying on IRC, you need to make that change then, if we're
> going to go down this path, before v2023.10 is out.

Yes I can do that one...but I am stuck on the PEM files so need the
maintainer there to figure out what is up, as described in detail in
the cover letter.

>
> And to repeat what I said inside another part of the thread, the u-boot*
> glob is hiding other "arbitrary" extensions that we've had in-use for
> forever.

Yes, understood. Do you think that is a problem? I should improve the
docs for buildman -k too.

Regrads,
Simon
