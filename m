Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A975FEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 11:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03E986DB6;
	Mon, 11 Sep 2023 13:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BZdGqtL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4068186D77; Mon, 11 Sep 2023 13:48:33 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68B186DC0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 13:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-501be2d45e0so7281726e87.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694432907; x=1695037707; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UUjs00j8Z2ZoEZhqXR3UUEjk8bY1pyECQMgj5j9fIN0=;
 b=BZdGqtL02FtAn5ivORgUMKQCM5n0lDDEY4Jg1qe/fKPJPst1HmTAZBLg2ZncLMeQOt
 cPPaRbw0z2y8gIR1XABYF1Mbwb0sQ5OfTG42AuA/6ncmzBaZZB8Suxy9MksLM+L2vvwi
 8ybwGQRXc4tT2OehYnzdIFJBGzv75K0gEoNe00KoM3lXSrJd4BlMp8kcS0VKOsOVQE9U
 7LMKdGdj2wG5sfd31p3hIMRyxuKZnPMHmppJlBeg5Pg2FLkUuzSuKR0ivHLgE4CgS2h+
 sGYyzv6rLC++RiTReFoo6N4+QV+FBwuuN53PT+Os3UxVDtQVTAFjTd1P16wiv1ohUT2Y
 IOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694432907; x=1695037707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UUjs00j8Z2ZoEZhqXR3UUEjk8bY1pyECQMgj5j9fIN0=;
 b=dZXyycOrRay+cWp3gdIq7GI9yC09405oTOIew/fOVq8Ub77WFJeuzo6KKWUxBNs4oO
 PdoJG6doj87PxgvZZcCR2JqrLUYl8tH+w5eYOXUKC+vjKewknwBHa3mwNhgagfVm2Tzu
 Z0X0KIDRds/FXcZuIlV28gOSpWt0F2v2ydyxECicl2ooFIdsoD2EXsDZ0tGSuxQTFc37
 iCnbp+UmuKQVb6CWi5MJX6QE36gsFLLRQ5m8N21EgYe/LsWquBN35cIuoo2N66oJZif9
 R45hUMdFHqrK3qRxKSwm+WmAxjgz2aHNA1CNoYlfG2DVsi5cGQ9ZCBpXAQgh5hJlSpiA
 MzLQ==
X-Gm-Message-State: AOJu0YwilYWZ+mjvtWTiGZBCdS+sfOGF/l6TSPYewq67Pq1UyeFYog4q
 GyNxejjkujL4GP60y1s9uCrMr7KS3jhzEsVWk/N4cA==
X-Google-Smtp-Source: AGHT+IFEwIxZCTs9NZbhkt51xjO7HizahpyxlRcKlQ0MDC4FOzmsANA7qeRMGbzrUgh2xOtbaj36hQfj6WkrDLfrqJ8=
X-Received: by 2002:a05:6512:10c7:b0:4fe:3724:fdae with SMTP id
 k7-20020a05651210c700b004fe3724fdaemr9001510lfg.66.1694432906799; Mon, 11 Sep
 2023 04:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org>
 <ZPA8AtGOel8pko6y@hades>
 <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
 <CAC_iWj+HQSGfntZV_5ccUXfi8w6AGp3ETxUUORtm+bhXBuX3gQ@mail.gmail.com>
 <CAPnjgZ0JkXkr+0ZPt5Om1-XzjY3rWjjDd8B5grqmUqGUxf7u_Q@mail.gmail.com>
 <CAC_iWjL-F7Vo+oL0aJG=A4a3es__8S-krt7dBs77Snh1pFkPHQ@mail.gmail.com>
 <CAPnjgZ2QV3t9FnY_7VBJ4NAYW8zPL9p1bktfcEP86AnXrFoA1w@mail.gmail.com>
 <CAC_iWjKd60b2pPdQf195ef+a8_3jEHtXh085Sd7uPAik1mCu+Q@mail.gmail.com>
 <700c3677-6fc1-40b0-9ca2-9f9e2cc824b0@amd.com>
 <CAC_iWjJUbads2Trqxm_chnhypyZ+tTT2mXUw56z0Py9bgyBhZg@mail.gmail.com>
 <8528ca89-16a7-48ba-95d3-72e7f3b107eb@amd.com>
In-Reply-To: <8528ca89-16a7-48ba-95d3-72e7f3b107eb@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Sep 2023 14:47:50 +0300
Message-ID: <CAC_iWj+-Om7Aqh7YQf1LhSZOSETeZgtBMRZKp4_AaixA5RfbHA@mail.gmail.com>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nikhil M Jain <n-jain1@ti.com>, 
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

Hi Michal,

On Mon, 11 Sept 2023 at 13:58, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Ilias,
>
> On 9/11/23 09:56, Ilias Apalodimas wrote:
> > Hi Michal,
> >
> > On Mon, 11 Sept 2023 at 09:38, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 9/11/23 08:17, Ilias Apalodimas wrote:
> >>> Hi Simon,
> >>>
> >>> On Sun, 10 Sept 2023 at 22:14, Simon Glass <sjg@chromium.org> wrote:
> >>>>
> >>>> Hi Ilias,
> >>>>
> >>>> On Mon, 4 Sept 2023 at 03:31, Ilias Apalodimas
> >>>> <ilias.apalodimas@linaro.org> wrote:
> >>>>>
> >>>>> Hi Simon,
> >>>>>
> >>>>> On Fri, 1 Sept 2023 at 18:51, Simon Glass <sjg@chromium.org> wrote:
> >>>>>>
> >>>>>> Hi Ilias,
> >>>>>>
> >>>>>> On Fri, 1 Sept 2023 at 01:50, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +config OF_BLOBLIST
> >>>>>>>>>> +     bool "DTB is provided by a bloblist"
> >>>>>>>>>> +     help
> >>>>>>>>>> +       Select this to read the devicetree from the bloblist. This allows
> >>>>>>>>>> +       using a bloblist to transfer the devicetree between  U-Boot phases.
> >>>>>>>>>> +       The devicetree is stored in the bloblist by an early phase so that
> >>>>>>>>>> +       U-Boot can read it.
> >>>>>>>>>> +
> >>>>>>>>>
> >>>>>>>>> I dont think this is a good idea.  We used to have 4-5 different options
> >>>>>>>>> here, which we tried to clean up and ended up with two very discrete
> >>>>>>>>> options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> >>>>>>>>> have a header of some sort?  The bloblist literally comes from a previous
> >>>>>>>>> stage bootloader which is what OF_BOARD is here for. So why can't we just
> >>>>>>>>> read the header and figure out if the magic of the bloblist matches?
> >>>>>>>>
> >>>>>>>> No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
> >>>>>>>>
> >>>>>>>> This patch is a standard mechanism to pass the DT from one firmware
> >>>>>>>> phase to the next. We have spent quite a bit of time creating a spec
> >>>>>>>> for it, and we should use it.
> >>>>>>>
> >>>>>>> Where exactly am I objecting using the spec?   Can you please re-read my email?
> >>>>>>> I am actually pointing out we should use the spec *properly*.  So
> >>>>>>> instead of having a Kconfig option for the DT, which is pretty
> >>>>>>> pointless,  we should parse the bloblist.  If the header defined by
> >>>>>>> the *spec* is found, we should just search for the DT in there.
> >>>>>>> What you are doing here, is take the spec, pick a very specific item
> >>>>>>> that the list contains, and create a Kconfig option out of it.  Which
> >>>>>>> basically ignores the discoverable options of the bloblist.  For
> >>>>>>> example, that bloblist can also contain an entry to a TPM eventlog.
> >>>>>>> Should we start creating Kconfig options for all the firmware handoff
> >>>>>>> entries that are defined on that spec?
> >>>>>>
> >>>>>> OK so that is a different thing. What should it do if it expects to find a bloblist but cannot? I want it to throw an error, because I am trying to make the boot deterministic. What do you think?
> >>>>>
> >>>>> That's fine by me.  You can even put that under IS_ENABLED for the
> >>>>> bloblist inside the existing OF_BOARD check.  So I was thinking
> >>>>> - If no bloblist is required in Kconfig options we do the hacks we used to
> >>>>> - if bloblist is selected and the config option is OF_BOARD, throw an
> >>>>> error and mention that the previous stage loader should hand over a DT
> >>>>>
> >>>>> Is that what you had in mind?
> >>>>
> >>>> Yes, that sounds good to me.
> >>>>
> >>>> But I still think we need an OF_BLOBLIST option to control whether the
> >>>> devicetree comes from there.
> >>>>    Otherwise we will end up with people
> >>>> using OF_BOARD to work around it. We also have the SPL case which does
> >>>> not pass the DT in a bloblist...in fact SPL typically doesn't even
> >>>> have the full DT.
> >>>
> >>> Wouldn't IS_ENABLED(BLOBLIST) || IS_ENABLED(SPL_BLOBLIST) be enough?
> >>> Inside the OF_BOARD portion of the function, search for a bloblist if
> >>> the option is enabled.  If you can't find a bloblist and the DT within
> >>> that bloblist, then error out
> >>
> >> Just my 2c here.
> >> I think all options should be possible to disable. It means I can imagine to
> >> disable u-boot not to take care about DT provided from previous stage. The same
> >> is for TPM event log. IMHO every stage should have an option to simply ignore
> >> data pass from previous stage. I don't really mind how it is done but there
> >> should be an option to by purpose say to ignore the part of pass data.
> >
> > That would be done by disabling BLOBLIST.  I don't think having a Kconfig to say
> > "I want a bloblist, but I only want the DT from there" is reasonable
> > (or for any other item the bloblist can carry).   OF_BOARD means the
> > DT will come from a previous stage loader. If bloblist is enabled then
> > the DT must come from there.
>
> I don't agree on this. If bloblist is enabled and DT is passed SW should have a
> freedom to ignore it.
>
> At start everything is likely in sync but later stages before U-Boot can stay at
> certain version but there could be a need to update u-boot where DT from
> previous stage could be broken.

But you *can* ignore it and load a different one later.  The only
restriction is that if you compile u-boot with the assumption an early
stage bootloader provides a DT you *must* find it.  But we will still
just keep 2 options in U-Boot of how you get a DT.
A previous loader provided it or U-Boot provided it.  Whether that
comes from a bloblist or a register is irrelevant no ?

[...]


Thanks

/Ilias
