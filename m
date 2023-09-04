Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3871C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC4B86926;
	Mon,  4 Sep 2023 11:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QLw1uUs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A5B86907; Mon,  4 Sep 2023 11:31:40 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B3C857BF
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so2045402e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693819895; x=1694424695; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vs330YR8lYz1NuHEF3qumcG/K45JwX+zXrf4QZ74YrI=;
 b=QLw1uUs6QpeKQgcuy8UxIl7uJSKrVnVP0WcCtlD4wx/PU+uYRL6rIjMcj3hj9MfqU0
 OMbTU8t6r7FVlopC5VABQ7I8iXoJJxX6tIGqccPI8zrgAbSVLvG6+ryZU6E87MugjNU3
 1C44oBlUMB+3Qz8Glv60isISQ5eFnU8YPTl3DBOSRbdLnY5WI7aZaWxEgfBkC3JvFb01
 qdSp7lboHVIIVm95Ib5YweCYg9g7YdjHeAY8csBQpuPyFk30rmME1iLgwybuSjc/tSJ2
 R5GOpkjuU3JwWjGJcwNgn7KtA4/3ihyjgCbSYrLXMeLW3f/NAor86xXJbtboUWF3M7/z
 bX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819895; x=1694424695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vs330YR8lYz1NuHEF3qumcG/K45JwX+zXrf4QZ74YrI=;
 b=KZZO/1MGtR7QcrhokZhWh1yv/EKsJdcVptpbfxYUkzf8V8yO6LCCJReqc6ZxOwMpXT
 N6Bcp1ihEG/KjgFv35BHT9kppf2Zjv+u0o6hVcmLb0iFNRx9kTD9v6o/+Qcc0WnU2aLA
 QnF2pEtrmkYwk7ZWpwkL90IAoku6cAplFdByUFCHthEXbI3NrUTTg+JC89PvuSgGoDqc
 K1J3L/W3evSQ7ennvzpiiQ32Hn4e+tZTdxRLhDirC/xRPiFpZ3TfZMR8+Q13eRUUEc4q
 25Jg1xRw7utGp2Vqv3nr+ej2ZAm+ItqbK+UoC+rqaYS7jnHByMtwLyccD8ZT8o6OM6j2
 oPmQ==
X-Gm-Message-State: AOJu0YyzJccGok5gKNjJYrfs/TCezZOtaHidoytQ/C/hy/2OgqHwPRik
 LctxUiVmfQ5tuhy8YG9x9kJig4Fa9OnngcfVS3w9BQ==
X-Google-Smtp-Source: AGHT+IFJPGPSSj2QtkXzzSA03G3CeMWrmdHWovkAbWCuBwMIiOlKMta3Of2ra1avOYSP6vqtCik/ygtlTPoA8HLonhw=
X-Received: by 2002:a05:6512:742:b0:500:7f51:d129 with SMTP id
 c2-20020a056512074200b005007f51d129mr5057626lfs.34.1693819895442; Mon, 04 Sep
 2023 02:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org>
 <ZPA8AtGOel8pko6y@hades>
 <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
 <CAC_iWj+HQSGfntZV_5ccUXfi8w6AGp3ETxUUORtm+bhXBuX3gQ@mail.gmail.com>
 <CAPnjgZ0JkXkr+0ZPt5Om1-XzjY3rWjjDd8B5grqmUqGUxf7u_Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ0JkXkr+0ZPt5Om1-XzjY3rWjjDd8B5grqmUqGUxf7u_Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Sep 2023 12:30:59 +0300
Message-ID: <CAC_iWjL-F7Vo+oL0aJG=A4a3es__8S-krt7dBs77Snh1pFkPHQ@mail.gmail.com>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>
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

Hi Simon,

On Fri, 1 Sept 2023 at 18:51, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Fri, 1 Sept 2023 at 01:50, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >
> > [...]
> >
> > > >
> > > > > +config OF_BLOBLIST
> > > > > +     bool "DTB is provided by a bloblist"
> > > > > +     help
> > > > > +       Select this to read the devicetree from the bloblist. This allows
> > > > > +       using a bloblist to transfer the devicetree between  U-Boot phases.
> > > > > +       The devicetree is stored in the bloblist by an early phase so that
> > > > > +       U-Boot can read it.
> > > > > +
> > > >
> > > > I dont think this is a good idea.  We used to have 4-5 different options
> > > > here, which we tried to clean up and ended up with two very discrete
> > > > options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> > > > have a header of some sort?  The bloblist literally comes from a previous
> > > > stage bootloader which is what OF_BOARD is here for. So why can't we just
> > > > read the header and figure out if the magic of the bloblist matches?
> > >
> > > No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
> > >
> > > This patch is a standard mechanism to pass the DT from one firmware
> > > phase to the next. We have spent quite a bit of time creating a spec
> > > for it, and we should use it.
> >
> > Where exactly am I objecting using the spec?   Can you please re-read my email?
> > I am actually pointing out we should use the spec *properly*.  So
> > instead of having a Kconfig option for the DT, which is pretty
> > pointless,  we should parse the bloblist.  If the header defined by
> > the *spec* is found, we should just search for the DT in there.
> > What you are doing here, is take the spec, pick a very specific item
> > that the list contains, and create a Kconfig option out of it.  Which
> > basically ignores the discoverable options of the bloblist.  For
> > example, that bloblist can also contain an entry to a TPM eventlog.
> > Should we start creating Kconfig options for all the firmware handoff
> > entries that are defined on that spec?
>
> OK so that is a different thing. What should it do if it expects to find a bloblist but cannot? I want it to throw an error, because I am trying to make the boot deterministic. What do you think?

That's fine by me.  You can even put that under IS_ENABLED for the
bloblist inside the existing OF_BOARD check.  So I was thinking
- If no bloblist is required in Kconfig options we do the hacks we used to
- if bloblist is selected and the config option is OF_BOARD, throw an
error and mention that the previous stage loader should hand over a DT

Is that what you had in mind?

Thanks
/Ilias
>
> >
> > Thanks
> > /Ilias
> >
> > >
> > > The patches to align bloblist with the spec have been sent, but there
> > > is a late-breaking change that we are trying to resolve. Once that is
> > > sorted out, I will send v2 of those patches.
> > >
> > > >
> > > > >  config OF_BOARD
> > > > >       bool "Provided by the board (e.g a previous loader) at runtime"
> > > > >       default y if SANDBOX || OF_HAS_PRIOR_STAGE
> > > > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > > > index 080cc46a126..e16d122f4fb 100644
> > > > > --- a/include/bloblist.h
> > > > > +++ b/include/bloblist.h
> > > > > @@ -103,6 +103,11 @@ enum bloblist_tag_t {
> > > > >       BLOBLISTT_ACPI_TABLES = 0x104,  /* ACPI tables for x86 */
> > > > >       BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
> > > > >       BLOBLISTT_VBOOT_CTX = 0x106,    /* Chromium OS verified boot context */
> > > > > +     /*
> > > >
> > > > [...]
> > > >
> > > > >
> > > > [0] https://github.com/FirmwareHandoff/firmware_handoff
> > >
>
> Regards,
> Simon
