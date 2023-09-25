Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8529ECE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 10:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A41C86BD3;
	Mon, 25 Sep 2023 12:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u5RjdHRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FB186B18; Mon, 25 Sep 2023 12:19:37 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1468386BD3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50435a9f800so8183451e87.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695637171; x=1696241971; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cbbnTUHczSMoyG4uWiyzgRbqw/7qAig+pW7PzyyqUlk=;
 b=u5RjdHRxihJrOgCRhJhX8Xs4D/dALOZfnARJqNNSDtYWw4hKRcEy88EoaaABkW6j3Q
 5nm5o1odfvSIypf2iMxjn7RRHGD5P0d6BcR4Q1HOQPQ+m91iJv7SmJUED6yQRkRMfN7F
 uPyY0Aubtr9nqm+TJCRx+zaSG2RlRDwgD63cK9Ek2FWFs0yhkt43UR3lq7X+d/M0BRSr
 Ke5jvkQIj4CYAKcCw1iXiaElidXOe9diyul2SCPwV+qdstbkre3LspMvhFNDKoHnkFmX
 xRh9StycfEqFfLrf3NaEIgRlqM//6sYU20yrvX0EizSfPaoMbMc9TWP5xXbcMdzS1gBF
 tHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695637171; x=1696241971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cbbnTUHczSMoyG4uWiyzgRbqw/7qAig+pW7PzyyqUlk=;
 b=i5QBpcJIg/Y/XGY5kDTrrsvLdgnwcTLnPDkt3VZjpwXsqIkkq8ihoQXzIx1JOiS8XZ
 DCfamwNni86G+q1wClb3sn4cCj8OeB9nN1jRPWDQfwI17Jxkwby+a4b6uG+O4T2YgyJ1
 VZBzfML4zUKraR3dWxhjkE6qwDlc317O8f1tZQJ7hnmjlYwu5KG3N1VzQdbGJmEzHhQ+
 GriehLRaFI/i7VXb07yV/zv2OCxwkEwhX6CmFpJaIXhw1bO2fEQX4nCIW2GK6Y2N3jSM
 nkPsOxmKK9gAWAeWa1qz30rt5UhcvJfdcYef2R9mOCCUDG+O3yH9tJhEJ4V11m/deKpi
 nhUQ==
X-Gm-Message-State: AOJu0Yx6ijeS7BSU1IpaPMcuVjqGich4DdM/L9rnYwBVyBS/4bmKnSBE
 Ccs04+OM05yQOd7pPQ3CAqDHprgDuwFju2lF3MQnOQ==
X-Google-Smtp-Source: AGHT+IHMVQo4e8nZhp2K5D10q6mLhncOfjS9uX305Wzs0WxEOnp/mu9QhK8L68bnwKeYozQiE0Mi9qfMm6ySiEJn5Ps=
X-Received: by 2002:a05:6512:3582:b0:4fb:7675:1c16 with SMTP id
 m2-20020a056512358200b004fb76751c16mr4520007lfr.49.1695637171142; Mon, 25 Sep
 2023 03:19:31 -0700 (PDT)
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
 <CAC_iWj+-Om7Aqh7YQf1LhSZOSETeZgtBMRZKp4_AaixA5RfbHA@mail.gmail.com>
 <CAPnjgZ1ydE7y4UZPmvyaDTBVZdeQr=ftCnR1QtXB9TtewFkbxw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1ydE7y4UZPmvyaDTBVZdeQr=ftCnR1QtXB9TtewFkbxw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Sep 2023 13:18:55 +0300
Message-ID: <CAC_iWjLyupx5XUUm99qJg2Zt-G4KeZpTBoxWKOeXZ9nNw8roeg@mail.gmail.com>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi Simon,

[...]

> > > >>>>>>>>>> +config OF_BLOBLIST
> > > >>>>>>>>>> +     bool "DTB is provided by a bloblist"
> > > >>>>>>>>>> +     help
> > > >>>>>>>>>> +       Select this to read the devicetree from the bloblist. This allows
> > > >>>>>>>>>> +       using a bloblist to transfer the devicetree between  U-Boot phases.
> > > >>>>>>>>>> +       The devicetree is stored in the bloblist by an early phase so that
> > > >>>>>>>>>> +       U-Boot can read it.
> > > >>>>>>>>>> +
> > > >>>>>>>>>
> > > >>>>>>>>> I dont think this is a good idea.  We used to have 4-5 different options
> > > >>>>>>>>> here, which we tried to clean up and ended up with two very discrete
> > > >>>>>>>>> options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> > > >>>>>>>>> have a header of some sort?  The bloblist literally comes from a previous
> > > >>>>>>>>> stage bootloader which is what OF_BOARD is here for. So why can't we just
> > > >>>>>>>>> read the header and figure out if the magic of the bloblist matches?
> > > >>>>>>>>
> > > >>>>>>>> No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
> > > >>>>>>>>
> > > >>>>>>>> This patch is a standard mechanism to pass the DT from one firmware
> > > >>>>>>>> phase to the next. We have spent quite a bit of time creating a spec
> > > >>>>>>>> for it, and we should use it.
> > > >>>>>>>
> > > >>>>>>> Where exactly am I objecting using the spec?   Can you please re-read my email?
> > > >>>>>>> I am actually pointing out we should use the spec *properly*.  So
> > > >>>>>>> instead of having a Kconfig option for the DT, which is pretty
> > > >>>>>>> pointless,  we should parse the bloblist.  If the header defined by
> > > >>>>>>> the *spec* is found, we should just search for the DT in there.
> > > >>>>>>> What you are doing here, is take the spec, pick a very specific item
> > > >>>>>>> that the list contains, and create a Kconfig option out of it.  Which
> > > >>>>>>> basically ignores the discoverable options of the bloblist.  For
> > > >>>>>>> example, that bloblist can also contain an entry to a TPM eventlog.
> > > >>>>>>> Should we start creating Kconfig options for all the firmware handoff
> > > >>>>>>> entries that are defined on that spec?
> > > >>>>>>
> > > >>>>>> OK so that is a different thing. What should it do if it expects to find a bloblist but cannot? I want it to throw an error, because I am trying to make the boot deterministic. What do you think?
> > > >>>>>
> > > >>>>> That's fine by me.  You can even put that under IS_ENABLED for the
> > > >>>>> bloblist inside the existing OF_BOARD check.  So I was thinking
> > > >>>>> - If no bloblist is required in Kconfig options we do the hacks we used to
> > > >>>>> - if bloblist is selected and the config option is OF_BOARD, throw an
> > > >>>>> error and mention that the previous stage loader should hand over a DT
> > > >>>>>
> > > >>>>> Is that what you had in mind?
> > > >>>>
> > > >>>> Yes, that sounds good to me.
> > > >>>>
> > > >>>> But I still think we need an OF_BLOBLIST option to control whether the
> > > >>>> devicetree comes from there.
> > > >>>>    Otherwise we will end up with people
> > > >>>> using OF_BOARD to work around it. We also have the SPL case which does
> > > >>>> not pass the DT in a bloblist...in fact SPL typically doesn't even
> > > >>>> have the full DT.
> > > >>>
> > > >>> Wouldn't IS_ENABLED(BLOBLIST) || IS_ENABLED(SPL_BLOBLIST) be enough?
> > > >>> Inside the OF_BOARD portion of the function, search for a bloblist if
> > > >>> the option is enabled.  If you can't find a bloblist and the DT within
> > > >>> that bloblist, then error out
> > > >>
> > > >> Just my 2c here.
> > > >> I think all options should be possible to disable. It means I can imagine to
> > > >> disable u-boot not to take care about DT provided from previous stage. The same
> > > >> is for TPM event log. IMHO every stage should have an option to simply ignore
> > > >> data pass from previous stage. I don't really mind how it is done but there
> > > >> should be an option to by purpose say to ignore the part of pass data.
> > > >
> > > > That would be done by disabling BLOBLIST.  I don't think having a Kconfig to say
> > > > "I want a bloblist, but I only want the DT from there" is reasonable
> > > > (or for any other item the bloblist can carry).   OF_BOARD means the
> > > > DT will come from a previous stage loader. If bloblist is enabled then
> > > > the DT must come from there.
> > >
> > > I don't agree on this. If bloblist is enabled and DT is passed SW should have a
> > > freedom to ignore it.
> > >
> > > At start everything is likely in sync but later stages before U-Boot can stay at
> > > certain version but there could be a need to update u-boot where DT from
> > > previous stage could be broken.
> >
> > But you *can* ignore it and load a different one later.  The only
> > restriction is that if you compile u-boot with the assumption an early
> > stage bootloader provides a DT you *must* find it.  But we will still
> > just keep 2 options in U-Boot of how you get a DT.
> > A previous loader provided it or U-Boot provided it.  Whether that
> > comes from a bloblist or a register is irrelevant no ?
>
> I'm not sure what is being requested here, so I'll leave this as is for v2.

Please don't.   A few mails above there's a discussion of how I'd
prefer things to look like, please have a look and let me know if
something isn't clear.
tl;dr
 "That's fine by me.  You can even put that under IS_ENABLED for the
 bloblist inside the existing OF_BOARD check.  So I was thinking
 - If no bloblist is required in Kconfig options we do the hacks we used to
 - if bloblist is selected and the config option is OF_BOARD, throw an
error and mention that the previous stage loader should hand over a DT"

>
> The main struggle I have is how to tell whether you expect to
> *receive* the DT in the bloblist, or expect it to be attached to the
> image and be *sent* to the next phase.

bloblist

>
> SPL - attached to image, send in bloblist
> U-Boot proper - not attached to image, receive it from bloblist
>
> This is exactly the problem that is solved by the 'standard passage'
> stuff [1] but that depends on Firmware Handoff and [2] which are not
> ready yet...
>
> So I think what I have is the best we can do for now.

We can avoid the extra complication in Kconfigs.  The DT either comes
from u-boot itself or from a previous stage loader. we don't need the
extra "it comes from a bloblist".
If they come from a previous stage loader and BLOBLIST *is* enabled,
then just scan for the DT, if you don't find it error out.

Thanks
/Ilias
>
> Regards,
> Simon
>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=365719
