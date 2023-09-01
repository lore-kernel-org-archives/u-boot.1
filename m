Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6E1CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0051D86824;
	Fri,  1 Sep 2023 09:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ph7JW2zR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 286FD8669D; Fri,  1 Sep 2023 09:50:30 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED96867EA
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4ff9b389677so2886525e87.3
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693554625; x=1694159425; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+97UdMNF+enWFaHMaqp3+8Rb2U8+X4o/03puA0bisGk=;
 b=Ph7JW2zRx906Pz+EsLUifEwvWysai3f9GsBHEdUiXtExu9v5tiCLEz2mrXs1uPjGJh
 u+jWKYrd9Mi1XpNhjxRKreHK2v3V21RW3owKLRYCzH864P0kyrn8szbUIHg3FEupixzt
 ThEXLevoonBHXBTcBChfRd8U1vpfk6+lrRFtSL2d2iSULhdZCmjFy/sWpa/iVCqGyA9T
 Y+lO/njh2RdjOBPu5/XbxfE1ZN1tC84ls/1Xf/rDTP8bkAKPwDTzsa+XLWnoTx+1kLm7
 HkgeJXoFs4jvLnbSXBl08Y472m1pNpjNY+arKWKlRqSC1ipCur5S+HTnf0m17k905Afp
 12BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693554625; x=1694159425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+97UdMNF+enWFaHMaqp3+8Rb2U8+X4o/03puA0bisGk=;
 b=V62GuXfJBLsuvPc9XrygouxTBjcbHxn/jnfMYXXjHaiYZNuP1BisR4y3xG2RZNgPZF
 /yQ4lalTFV4hu9Jt+L32v30rLVoHudY3O54FfxAYeziHdeSpzUQk/imcHMVpNJAbME5s
 FoRqjwVigHcZtJRrJHLK22jfgDPRyzcsbKLQNskRR5S+QMJs4pZaRLjKcNzyi/BOFb/f
 Jq7hpQYYPihmULfIPuUUhbj5a1Wb1qtwSBMNGKSlWtgwV+jua064jcM1OutCStRYTdK+
 rljFKDlwY+9Zx+DygppSOFn+lAewJSDFpJZyCkXnPotn1kojc76Q4AqeouQBw2PgfcnF
 USbA==
X-Gm-Message-State: AOJu0YzNrEd3N/aCcYhyr8fat6OOcN8siUGnvoBykkVXFqBhzunvD37w
 mL2J6ZgWUFfdwn2OR0G8A6lziaB1oNmAezqmu0Ak/w==
X-Google-Smtp-Source: AGHT+IGMErHxkiCSYFxccz9gdNjqperpdYy6LzbWByjZ1bbnystnpv9peeuu80IzFps+ADPDOYvzJsM6qKW+0M649yw=
X-Received: by 2002:a05:6512:220b:b0:500:b63f:4db3 with SMTP id
 h11-20020a056512220b00b00500b63f4db3mr1292149lfu.35.1693554625111; Fri, 01
 Sep 2023 00:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org>
 <ZPA8AtGOel8pko6y@hades>
 <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Sep 2023 10:49:46 +0300
Message-ID: <CAC_iWj+HQSGfntZV_5ccUXfi8w6AGp3ETxUUORtm+bhXBuX3gQ@mail.gmail.com>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>
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

[...]

> >
> > > +config OF_BLOBLIST
> > > +     bool "DTB is provided by a bloblist"
> > > +     help
> > > +       Select this to read the devicetree from the bloblist. This allows
> > > +       using a bloblist to transfer the devicetree between  U-Boot phases.
> > > +       The devicetree is stored in the bloblist by an early phase so that
> > > +       U-Boot can read it.
> > > +
> >
> > I dont think this is a good idea.  We used to have 4-5 different options
> > here, which we tried to clean up and ended up with two very discrete
> > options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> > have a header of some sort?  The bloblist literally comes from a previous
> > stage bootloader which is what OF_BOARD is here for. So why can't we just
> > read the header and figure out if the magic of the bloblist matches?
>
> No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
>
> This patch is a standard mechanism to pass the DT from one firmware
> phase to the next. We have spent quite a bit of time creating a spec
> for it, and we should use it.

Where exactly am I objecting using the spec?   Can you please re-read my email?
I am actually pointing out we should use the spec *properly*.  So
instead of having a Kconfig option for the DT, which is pretty
pointless,  we should parse the bloblist.  If the header defined by
the *spec* is found, we should just search for the DT in there.
What you are doing here, is take the spec, pick a very specific item
that the list contains, and create a Kconfig option out of it.  Which
basically ignores the discoverable options of the bloblist.  For
example, that bloblist can also contain an entry to a TPM eventlog.
Should we start creating Kconfig options for all the firmware handoff
entries that are defined on that spec?

Thanks
/Ilias

>
> The patches to align bloblist with the spec have been sent, but there
> is a late-breaking change that we are trying to resolve. Once that is
> sorted out, I will send v2 of those patches.
>
> >
> > >  config OF_BOARD
> > >       bool "Provided by the board (e.g a previous loader) at runtime"
> > >       default y if SANDBOX || OF_HAS_PRIOR_STAGE
> > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > index 080cc46a126..e16d122f4fb 100644
> > > --- a/include/bloblist.h
> > > +++ b/include/bloblist.h
> > > @@ -103,6 +103,11 @@ enum bloblist_tag_t {
> > >       BLOBLISTT_ACPI_TABLES = 0x104,  /* ACPI tables for x86 */
> > >       BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
> > >       BLOBLISTT_VBOOT_CTX = 0x106,    /* Chromium OS verified boot context */
> > > +     /*
> >
> > [...]
> >
> > >
> > [0] https://github.com/FirmwareHandoff/firmware_handoff
>
> Regards,
> Simon
