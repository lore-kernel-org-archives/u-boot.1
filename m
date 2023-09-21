Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DC2CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9C786D7D;
	Thu, 21 Sep 2023 03:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L1CeH7z7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3588C86D21; Thu, 21 Sep 2023 03:06:16 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8CCA86D45
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59c0281d72dso5507487b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258365; x=1695863165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=upZ4t1eH1vX8mnjW7waJdzyIfU2ukBLgI1xlHfs6zoc=;
 b=L1CeH7z7Z4hnTovVxz1Zms4uGupVeMK/u7UEQZU50Qf3xWZWFDNIsqYNvYBRuw/TRh
 LaDnLGfzh6HX7+4iiQqxdBzGVu3xy5OcbW8VLz1JF5jGnM4hfgBdAwEkZ8EnQZwcaZj7
 a038Q9G7T8UoI+lTYZ3hZna88Bj1k7KHCME0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258365; x=1695863165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=upZ4t1eH1vX8mnjW7waJdzyIfU2ukBLgI1xlHfs6zoc=;
 b=v2R49qM4Sh5Sl7Zui/Lih7EkF9tg4I5KhJliYOvIuJB2kUUVlMWa5qGjaQi3tqtSbg
 4OKtya2nBk1/Gpad031OjlqcJucpyt74HWt41n/L1wZZWfnSAPy8DokTK+wRLJ4H4J5r
 Sd8agIbeURxZ/4dBAe3wFw3boR4oRciNkeh87uzvnk19Npgswu2yaka+TAHQz0Fl+qa8
 A3lk43FL7Tbj22Nbtl1TndZHou3BpdjOUP9s93kWeFwNTAiu6rEEwN/gLVfFWxd9g0LQ
 ydoS9U3LVUsitFkkhle01lKUrxEp5Iidqp022wdtrQdzu+s9r4rhBZsUR89rUEhy/TnS
 W6uQ==
X-Gm-Message-State: AOJu0YxJDHOIEj0LJk+G4pMBeF7Kuu+wAQWfMgduvtFY5KIOXDvPWJtW
 n6w6N8q3CmhdnD4tw/fHcNlsPIBAGmWgKNQtU6Stv7lLnDGgWy3VTYA=
X-Google-Smtp-Source: AGHT+IHEoaZ06juWbGpuDmqkSTQ5LQfcrnFnJ72Nmj+6e2YC6BGOwNNBI/++MAAbl7xAkdjSab+97HfApZt4WiS8q1U=
X-Received: by 2002:a81:5e89:0:b0:577:3d46:f90e with SMTP id
 s131-20020a815e89000000b005773d46f90emr5301964ywb.32.1695258365306; Wed, 20
 Sep 2023 18:06:05 -0700 (PDT)
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
In-Reply-To: <CAC_iWj+-Om7Aqh7YQf1LhSZOSETeZgtBMRZKp4_AaixA5RfbHA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:37 -0600
Message-ID: <CAPnjgZ1ydE7y4UZPmvyaDTBVZdeQr=ftCnR1QtXB9TtewFkbxw@mail.gmail.com>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi,

On Mon, 11 Sept 2023 at 05:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Michal,
>
> On Mon, 11 Sept 2023 at 13:58, Michal Simek <michal.simek@amd.com> wrote:
> >
> > Hi Ilias,
> >
> > On 9/11/23 09:56, Ilias Apalodimas wrote:
> > > Hi Michal,
> > >
> > > On Mon, 11 Sept 2023 at 09:38, Michal Simek <michal.simek@amd.com> wrote:
> > >>
> > >>
> > >>
> > >> On 9/11/23 08:17, Ilias Apalodimas wrote:
> > >>> Hi Simon,
> > >>>
> > >>> On Sun, 10 Sept 2023 at 22:14, Simon Glass <sjg@chromium.org> wrote:
> > >>>>
> > >>>> Hi Ilias,
> > >>>>
> > >>>> On Mon, 4 Sept 2023 at 03:31, Ilias Apalodimas
> > >>>> <ilias.apalodimas@linaro.org> wrote:
> > >>>>>
> > >>>>> Hi Simon,
> > >>>>>
> > >>>>> On Fri, 1 Sept 2023 at 18:51, Simon Glass <sjg@chromium.org> wrote:
> > >>>>>>
> > >>>>>> Hi Ilias,
> > >>>>>>
> > >>>>>> On Fri, 1 Sept 2023 at 01:50, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > >>>>>>>
> > >>>>>>> [...]
> > >>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>> +config OF_BLOBLIST
> > >>>>>>>>>> +     bool "DTB is provided by a bloblist"
> > >>>>>>>>>> +     help
> > >>>>>>>>>> +       Select this to read the devicetree from the bloblist. This allows
> > >>>>>>>>>> +       using a bloblist to transfer the devicetree between  U-Boot phases.
> > >>>>>>>>>> +       The devicetree is stored in the bloblist by an early phase so that
> > >>>>>>>>>> +       U-Boot can read it.
> > >>>>>>>>>> +
> > >>>>>>>>>
> > >>>>>>>>> I dont think this is a good idea.  We used to have 4-5 different options
> > >>>>>>>>> here, which we tried to clean up and ended up with two very discrete
> > >>>>>>>>> options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> > >>>>>>>>> have a header of some sort?  The bloblist literally comes from a previous
> > >>>>>>>>> stage bootloader which is what OF_BOARD is here for. So why can't we just
> > >>>>>>>>> read the header and figure out if the magic of the bloblist matches?
> > >>>>>>>>
> > >>>>>>>> No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
> > >>>>>>>>
> > >>>>>>>> This patch is a standard mechanism to pass the DT from one firmware
> > >>>>>>>> phase to the next. We have spent quite a bit of time creating a spec
> > >>>>>>>> for it, and we should use it.
> > >>>>>>>
> > >>>>>>> Where exactly am I objecting using the spec?   Can you please re-read my email?
> > >>>>>>> I am actually pointing out we should use the spec *properly*.  So
> > >>>>>>> instead of having a Kconfig option for the DT, which is pretty
> > >>>>>>> pointless,  we should parse the bloblist.  If the header defined by
> > >>>>>>> the *spec* is found, we should just search for the DT in there.
> > >>>>>>> What you are doing here, is take the spec, pick a very specific item
> > >>>>>>> that the list contains, and create a Kconfig option out of it.  Which
> > >>>>>>> basically ignores the discoverable options of the bloblist.  For
> > >>>>>>> example, that bloblist can also contain an entry to a TPM eventlog.
> > >>>>>>> Should we start creating Kconfig options for all the firmware handoff
> > >>>>>>> entries that are defined on that spec?
> > >>>>>>
> > >>>>>> OK so that is a different thing. What should it do if it expects to find a bloblist but cannot? I want it to throw an error, because I am trying to make the boot deterministic. What do you think?
> > >>>>>
> > >>>>> That's fine by me.  You can even put that under IS_ENABLED for the
> > >>>>> bloblist inside the existing OF_BOARD check.  So I was thinking
> > >>>>> - If no bloblist is required in Kconfig options we do the hacks we used to
> > >>>>> - if bloblist is selected and the config option is OF_BOARD, throw an
> > >>>>> error and mention that the previous stage loader should hand over a DT
> > >>>>>
> > >>>>> Is that what you had in mind?
> > >>>>
> > >>>> Yes, that sounds good to me.
> > >>>>
> > >>>> But I still think we need an OF_BLOBLIST option to control whether the
> > >>>> devicetree comes from there.
> > >>>>    Otherwise we will end up with people
> > >>>> using OF_BOARD to work around it. We also have the SPL case which does
> > >>>> not pass the DT in a bloblist...in fact SPL typically doesn't even
> > >>>> have the full DT.
> > >>>
> > >>> Wouldn't IS_ENABLED(BLOBLIST) || IS_ENABLED(SPL_BLOBLIST) be enough?
> > >>> Inside the OF_BOARD portion of the function, search for a bloblist if
> > >>> the option is enabled.  If you can't find a bloblist and the DT within
> > >>> that bloblist, then error out
> > >>
> > >> Just my 2c here.
> > >> I think all options should be possible to disable. It means I can imagine to
> > >> disable u-boot not to take care about DT provided from previous stage. The same
> > >> is for TPM event log. IMHO every stage should have an option to simply ignore
> > >> data pass from previous stage. I don't really mind how it is done but there
> > >> should be an option to by purpose say to ignore the part of pass data.
> > >
> > > That would be done by disabling BLOBLIST.  I don't think having a Kconfig to say
> > > "I want a bloblist, but I only want the DT from there" is reasonable
> > > (or for any other item the bloblist can carry).   OF_BOARD means the
> > > DT will come from a previous stage loader. If bloblist is enabled then
> > > the DT must come from there.
> >
> > I don't agree on this. If bloblist is enabled and DT is passed SW should have a
> > freedom to ignore it.
> >
> > At start everything is likely in sync but later stages before U-Boot can stay at
> > certain version but there could be a need to update u-boot where DT from
> > previous stage could be broken.
>
> But you *can* ignore it and load a different one later.  The only
> restriction is that if you compile u-boot with the assumption an early
> stage bootloader provides a DT you *must* find it.  But we will still
> just keep 2 options in U-Boot of how you get a DT.
> A previous loader provided it or U-Boot provided it.  Whether that
> comes from a bloblist or a register is irrelevant no ?

I'm not sure what is being requested here, so I'll leave this as is for v2.

The main struggle I have is how to tell whether you expect to
*receive* the DT in the bloblist, or expect it to be attached to the
image and be *sent* to the next phase.

SPL - attached to image, send in bloblist
U-Boot proper - not attached to image, receive it from bloblist

This is exactly the problem that is solved by the 'standard passage'
stuff [1] but that depends on Firmware Handoff and [2] which are not
ready yet...

So I think what I have is the best we can do for now.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=365719
