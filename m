Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C459CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 15:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DBA847D9;
	Fri,  1 Sep 2023 17:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DTcYcNvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420C3847C3; Fri,  1 Sep 2023 17:51:55 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DCD847D9
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so214104a12.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693583508; x=1694188308; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uQIR8WIRIooj21DTQ3znxJ0yyEkMpheVAIIz02UZmGM=;
 b=DTcYcNvuaW8IuHqDVw5As/oJEdGIkDTDgq1WvnMylJu0sKQA/R68+of6RmENRgQXmA
 rs/jh5KizTA6XdoOOtKKcUTfE7Fa5Xn2eu9mITKN7B2R1PNXbn//L/pOI5OoxKZS9sdO
 Gr8wHYHLiEAtVvggh7xLk3208mtxD0+MC+k3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693583508; x=1694188308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uQIR8WIRIooj21DTQ3znxJ0yyEkMpheVAIIz02UZmGM=;
 b=FfJOhHzyclMHNk+JcYGmrDEtYFv7JN94YyPr93IyGr7+L4EnjWn80c8/45+eMu73Y/
 FM9tqm9KBtlfR4a7AXCL6LQDO0nRX7FFPNkGmfhB0VbUK2DLFK3tR0l+jmkZFYXXesNW
 Pd5Pc7y9/wn4D5auBoaqr4o15MRbtE3fmOP9d2+PLbyv1Kdx/H3RJUXKjcKAHVuSuHOQ
 FnFlGeeOW4YjNJvcg4p7dh5W4pBj0Fm/NPaq7uqigs09zGbNHYWwUlAoyHToZPzFWXsO
 vJlWUdJKmkBd6zl/HXE3zx4sgkC1QU/hC0+Y3N2Sr4+aHvqSsz26bwDKe8cJLsQhdIA1
 Wnzw==
X-Gm-Message-State: AOJu0Yzf9AtggZ+Z1EosbIYHTrTaA4zf8HAOcY7FmOEoKmz3yeHXiKcc
 W3FzbAoi83/XLi4QbdsEGK9DAnDLrrGQxpv3Z1JfvQ==
X-Google-Smtp-Source: AGHT+IEBEuffI/rtLJ1uuhiMoOe/AZqoKK6o0pSlXRZglNltFq6tyDRldn2Ln7tcP7n1t30rAPLTYRmS8vL3OG1Ngsc=
X-Received: by 2002:a05:6402:5212:b0:51d:cf7b:c9f0 with SMTP id
 s18-20020a056402521200b0051dcf7bc9f0mr8343977edd.12.1693583507495; Fri, 01
 Sep 2023 08:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org>
 <ZPA8AtGOel8pko6y@hades>
 <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
 <CAC_iWj+HQSGfntZV_5ccUXfi8w6AGp3ETxUUORtm+bhXBuX3gQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+HQSGfntZV_5ccUXfi8w6AGp3ETxUUORtm+bhXBuX3gQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Sep 2023 09:51:30 -0600
Message-ID: <CAPnjgZ0JkXkr+0ZPt5Om1-XzjY3rWjjDd8B5grqmUqGUxf7u_Q@mail.gmail.com>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Fri, 1 Sept 2023 at 01:50, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:
>
> [...]
>
> > >
> > > > +config OF_BLOBLIST
> > > > +     bool "DTB is provided by a bloblist"
> > > > +     help
> > > > +       Select this to read the devicetree from the bloblist. This
allows
> > > > +       using a bloblist to transfer the devicetree between  U-Boot
phases.
> > > > +       The devicetree is stored in the bloblist by an early phase
so that
> > > > +       U-Boot can read it.
> > > > +
> > >
> > > I dont think this is a good idea.  We used to have 4-5 different
options
> > > here, which we tried to clean up and ended up with two very discrete
> > > options.  Why do we have to reintroduce a new one?  Doesn't that
bloblist
> > > have a header of some sort?  The bloblist literally comes from a
previous
> > > stage bootloader which is what OF_BOARD is here for. So why can't we
just
> > > read the header and figure out if the magic of the bloblist matches?
> >
> > No, OF_BOARD is a hack to allow boards to do what they like with the
FDT.
> >
> > This patch is a standard mechanism to pass the DT from one firmware
> > phase to the next. We have spent quite a bit of time creating a spec
> > for it, and we should use it.
>
> Where exactly am I objecting using the spec?   Can you please re-read my
email?
> I am actually pointing out we should use the spec *properly*.  So
> instead of having a Kconfig option for the DT, which is pretty
> pointless,  we should parse the bloblist.  If the header defined by
> the *spec* is found, we should just search for the DT in there.
> What you are doing here, is take the spec, pick a very specific item
> that the list contains, and create a Kconfig option out of it.  Which
> basically ignores the discoverable options of the bloblist.  For
> example, that bloblist can also contain an entry to a TPM eventlog.
> Should we start creating Kconfig options for all the firmware handoff
> entries that are defined on that spec?

OK so that is a different thing. What should it do if it expects to find a
bloblist but cannot? I want it to throw an error, because I am trying to
make the boot deterministic. What do you think?

>
> Thanks
> /Ilias
>
> >
> > The patches to align bloblist with the spec have been sent, but there
> > is a late-breaking change that we are trying to resolve. Once that is
> > sorted out, I will send v2 of those patches.
> >
> > >
> > > >  config OF_BOARD
> > > >       bool "Provided by the board (e.g a previous loader) at
runtime"
> > > >       default y if SANDBOX || OF_HAS_PRIOR_STAGE
> > > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > > index 080cc46a126..e16d122f4fb 100644
> > > > --- a/include/bloblist.h
> > > > +++ b/include/bloblist.h
> > > > @@ -103,6 +103,11 @@ enum bloblist_tag_t {
> > > >       BLOBLISTT_ACPI_TABLES = 0x104,  /* ACPI tables for x86 */
> > > >       BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
> > > >       BLOBLISTT_VBOOT_CTX = 0x106,    /* Chromium OS verified boot
context */
> > > > +     /*
> > >
> > > [...]
> > >
> > > >
> > > [0] https://github.com/FirmwareHandoff/firmware_handoff
> >

Regards,
Simon
