Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD2EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 07:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B04867D2;
	Mon, 11 Sep 2023 09:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Do6h0gEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C2DE86660; Mon, 11 Sep 2023 09:57:14 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE00586CEB
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 09:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-501bd7711e8so7092877e87.1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694419028; x=1695023828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6IFGsl2yf2S3d+elVC3eYRkNtkS36UuZ6x89ferm5TE=;
 b=Do6h0gEBvL8qZ2zRBfigR/Zu52CAQSPBRoiacdkWqDJ1buTPFFj1pg7j+WJVcMIepq
 mPEWPygS0bnjoUwKnb3SnEkX1KxZuI+MsgzPm9LAq+Y4MDrUR5q+u0v/9pN1zfY6+R51
 ZDTnNcjknuBpDVJWQbNaotXahykV05ro+JmbztM6JIZDllmBbto+saC61pQiss9c1T4K
 APGkQhi5sV0fUEnhMQmEPY4kY2gxqO0QsPdp+d16bvl4gpJHXAp/OlJrY2odiiXvk/St
 FGFaMnUHgIO8Ww0QI3IxwyQFfvUXMg0K5Qu55jtLwMz68RokYJnnasnGp/KFlGD3JROo
 twwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694419028; x=1695023828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6IFGsl2yf2S3d+elVC3eYRkNtkS36UuZ6x89ferm5TE=;
 b=w1j2pLc6cLdoJIb2ugAXXvvRZqBxK7yLiqAx045sTiBQeFPRKDla2dgKxmzmZolUDB
 4N46eR08PtGVjTAb6/J2DiY7B2I16R8kXLCFoxsn7V0Kbo8hBXlM/Fz0gKAVK+YmIHwe
 qIhZLS3trsqXyfFk6kMyDMxnlmTg7cKDPkEMP3enZyEQh9CmEmiIp6tPqYYPXwq1V7yL
 ZXGDpoHQBojBCBfNg3Tsuqq3XK7exfZc8kRhbydflsyINcmdMDKbdYpLhlxWucW93aZo
 FiwBv1OITyON6ueq8bGvGboBkCYibEtifvTLJMyiCShrmwmM1aV7a3+qh/Qf8lKsL4sF
 IG5Q==
X-Gm-Message-State: AOJu0YxR1EyaY9ouYuPFzzKBzOuC91qJqGj/rgvD3co04Fy3qhFceWW+
 yccWlQnjA7XfGp87xas8p0QBXeg19Gs+t2h9jGW32A==
X-Google-Smtp-Source: AGHT+IG1RJ/XJXrky7bkqaPol9myHE2VJV7Va6bWgV7Z6zoV5nE+1tVtBvMJsuJDzsYepMbwo/dTDD2+vH6E/JatQbU=
X-Received: by 2002:a05:6512:78e:b0:4f4:b13a:d683 with SMTP id
 x14-20020a056512078e00b004f4b13ad683mr5833566lfr.69.1694419027802; Mon, 11
 Sep 2023 00:57:07 -0700 (PDT)
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
In-Reply-To: <700c3677-6fc1-40b0-9ca2-9f9e2cc824b0@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Sep 2023 10:56:31 +0300
Message-ID: <CAC_iWjJUbads2Trqxm_chnhypyZ+tTT2mXUw56z0Py9bgyBhZg@mail.gmail.com>
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

On Mon, 11 Sept 2023 at 09:38, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 9/11/23 08:17, Ilias Apalodimas wrote:
> > Hi Simon,
> >
> > On Sun, 10 Sept 2023 at 22:14, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Ilias,
> >>
> >> On Mon, 4 Sept 2023 at 03:31, Ilias Apalodimas
> >> <ilias.apalodimas@linaro.org> wrote:
> >>>
> >>> Hi Simon,
> >>>
> >>> On Fri, 1 Sept 2023 at 18:51, Simon Glass <sjg@chromium.org> wrote:
> >>>>
> >>>> Hi Ilias,
> >>>>
> >>>> On Fri, 1 Sept 2023 at 01:50, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>>
> >>>>>>>> +config OF_BLOBLIST
> >>>>>>>> +     bool "DTB is provided by a bloblist"
> >>>>>>>> +     help
> >>>>>>>> +       Select this to read the devicetree from the bloblist. This allows
> >>>>>>>> +       using a bloblist to transfer the devicetree between  U-Boot phases.
> >>>>>>>> +       The devicetree is stored in the bloblist by an early phase so that
> >>>>>>>> +       U-Boot can read it.
> >>>>>>>> +
> >>>>>>>
> >>>>>>> I dont think this is a good idea.  We used to have 4-5 different options
> >>>>>>> here, which we tried to clean up and ended up with two very discrete
> >>>>>>> options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> >>>>>>> have a header of some sort?  The bloblist literally comes from a previous
> >>>>>>> stage bootloader which is what OF_BOARD is here for. So why can't we just
> >>>>>>> read the header and figure out if the magic of the bloblist matches?
> >>>>>>
> >>>>>> No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
> >>>>>>
> >>>>>> This patch is a standard mechanism to pass the DT from one firmware
> >>>>>> phase to the next. We have spent quite a bit of time creating a spec
> >>>>>> for it, and we should use it.
> >>>>>
> >>>>> Where exactly am I objecting using the spec?   Can you please re-read my email?
> >>>>> I am actually pointing out we should use the spec *properly*.  So
> >>>>> instead of having a Kconfig option for the DT, which is pretty
> >>>>> pointless,  we should parse the bloblist.  If the header defined by
> >>>>> the *spec* is found, we should just search for the DT in there.
> >>>>> What you are doing here, is take the spec, pick a very specific item
> >>>>> that the list contains, and create a Kconfig option out of it.  Which
> >>>>> basically ignores the discoverable options of the bloblist.  For
> >>>>> example, that bloblist can also contain an entry to a TPM eventlog.
> >>>>> Should we start creating Kconfig options for all the firmware handoff
> >>>>> entries that are defined on that spec?
> >>>>
> >>>> OK so that is a different thing. What should it do if it expects to find a bloblist but cannot? I want it to throw an error, because I am trying to make the boot deterministic. What do you think?
> >>>
> >>> That's fine by me.  You can even put that under IS_ENABLED for the
> >>> bloblist inside the existing OF_BOARD check.  So I was thinking
> >>> - If no bloblist is required in Kconfig options we do the hacks we used to
> >>> - if bloblist is selected and the config option is OF_BOARD, throw an
> >>> error and mention that the previous stage loader should hand over a DT
> >>>
> >>> Is that what you had in mind?
> >>
> >> Yes, that sounds good to me.
> >>
> >> But I still think we need an OF_BLOBLIST option to control whether the
> >> devicetree comes from there.
> >>   Otherwise we will end up with people
> >> using OF_BOARD to work around it. We also have the SPL case which does
> >> not pass the DT in a bloblist...in fact SPL typically doesn't even
> >> have the full DT.
> >
> > Wouldn't IS_ENABLED(BLOBLIST) || IS_ENABLED(SPL_BLOBLIST) be enough?
> > Inside the OF_BOARD portion of the function, search for a bloblist if
> > the option is enabled.  If you can't find a bloblist and the DT within
> > that bloblist, then error out
>
> Just my 2c here.
> I think all options should be possible to disable. It means I can imagine to
> disable u-boot not to take care about DT provided from previous stage. The same
> is for TPM event log. IMHO every stage should have an option to simply ignore
> data pass from previous stage. I don't really mind how it is done but there
> should be an option to by purpose say to ignore the part of pass data.

That would be done by disabling BLOBLIST.  I don't think having a Kconfig to say
"I want a bloblist, but I only want the DT from there" is reasonable
(or for any other item the bloblist can carry).   OF_BOARD means the
DT will come from a previous stage loader. If bloblist is enabled then
the DT must come from there.

>
> Regarding DT part. We are experimenting with TF-A injecting for example DDR
> memory reservation to DT.
> Injection is working properly if you are using single DT but in SOM case we are
> using FIT image with a lot of DTBs inside (issue with checksums calculation).
> I see couple of platforms (IIRC renesas/imx) which are using DT overlays and
> passing it via specific registers. For these using bloblist might be right way
> to go.

Yes that's in fact the purpose of that spec.

> I wasn't aware about the whole fdt bloblist discussion but based on my
> experiments you can create multiple FDT entries that's why I expect that there
> could be DT overlays from different stages. And I even think that all of them
> can be overlays without base DT which can be select later on.

If the bloblist has overlays, then we shouldn't be compiling with
OF_BOARD.  You will get a DT from u-boot and tghe adding this
overlays, is an matter of parsing the bloblist and appending the,

Thanks
/Ilias
>
> Thanks,
> Michal
>
>
