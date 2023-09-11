Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FFEEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 06:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B9E86D1E;
	Mon, 11 Sep 2023 08:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uEgkLRD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A820A86D1E; Mon, 11 Sep 2023 08:17:42 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFBB386D18
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 08:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-502b1bbe5c3so1788065e87.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 23:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694413059; x=1695017859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RYDBZpb9UW9VDF6MV4Uz7fUJm0zj0f9TEfD/FeF57Qs=;
 b=uEgkLRD0LD8rfqyHD1tdQdnTs0xVvOirPRAZdn+8Pm2aYb6p+2A6c57XPO6h3pRPlq
 E4jVwVqukdVov/M46cz2lWdTgbdbw0nLsROdQgFWT2r+WHDGHSkPtkf+8W0HzFR0WCUs
 02v6KZuBrYelppne3PvFwGkyeCF92oAyWnMmrUZb4Aj46i2ywiuNV44mFLoZ31Q7eZnp
 ckKOODqO1AS+GECIBeJXHVoqWL6FYsBZxNtQ3CmX6vV/Ioanc2MOr3uA++qn3fYnihML
 wCxK5S63GVAMqTJl6Sew/T3lCYdlhTzska3Bhz6/7joKQHzKFEbW75gq8RmLy6OvaZo+
 izew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694413059; x=1695017859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RYDBZpb9UW9VDF6MV4Uz7fUJm0zj0f9TEfD/FeF57Qs=;
 b=qjUAj22g5Jj+JD0MyclSJS7kmzRCXm4eMbEOvd4BiZt0VgBXNeCaqOLzfJkZ/HmW5O
 170/px55xflmCmKHd8EyX523vGWtObD/1Tmy+3igo1j4vIciexfeMekknjgMkuAg0EDn
 fJPKkWyU/vvNeppIg2XbiJBIY8+dqa8My6neY9d9tKOdjZOsV3boko1tm0q+QfHlve5s
 MOP5rqEFMRadNJCKdvHwW9YMoXS04e5Qke4q2VaijVcSlO6p0atwpu8adYJ9TqW4MnK9
 zJLa6Tk9ArQMR3AaokRjyOndQWEW0PPxHXa8Ux1hTukq8PL3y4OCtV+oahKQlbIQTbTH
 hAEw==
X-Gm-Message-State: AOJu0YyR5/mR26Ehah9HLaZP1TkEle/3lRWHYPO3UYOxUuSpPr1gU5kC
 +wN0H0wdpjgOsh93FHEat/Kjxm6rXFvu+Z+MxKDOuQ==
X-Google-Smtp-Source: AGHT+IE8xUMcRoMnWE7x1tGvPPPT4XFlAg3Gw+9vhsjDQoq4OU2IjGLejDwFW5Vjd8WZPi7/R1DU5gMjpsNkhVk+LH0=
X-Received: by 2002:a19:7701:0:b0:4fe:347d:7c4b with SMTP id
 s1-20020a197701000000b004fe347d7c4bmr5247699lfc.7.1694413059108; Sun, 10 Sep
 2023 23:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org>
 <ZPA8AtGOel8pko6y@hades>
 <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
 <CAC_iWj+HQSGfntZV_5ccUXfi8w6AGp3ETxUUORtm+bhXBuX3gQ@mail.gmail.com>
 <CAPnjgZ0JkXkr+0ZPt5Om1-XzjY3rWjjDd8B5grqmUqGUxf7u_Q@mail.gmail.com>
 <CAC_iWjL-F7Vo+oL0aJG=A4a3es__8S-krt7dBs77Snh1pFkPHQ@mail.gmail.com>
 <CAPnjgZ2QV3t9FnY_7VBJ4NAYW8zPL9p1bktfcEP86AnXrFoA1w@mail.gmail.com>
In-Reply-To: <CAPnjgZ2QV3t9FnY_7VBJ4NAYW8zPL9p1bktfcEP86AnXrFoA1w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Sep 2023 09:17:03 +0300
Message-ID: <CAC_iWjKd60b2pPdQf195ef+a8_3jEHtXh085Sd7uPAik1mCu+Q@mail.gmail.com>
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

On Sun, 10 Sept 2023 at 22:14, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Mon, 4 Sept 2023 at 03:31, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 1 Sept 2023 at 18:51, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Fri, 1 Sept 2023 at 01:50, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > [...]
> > > >
> > > > > >
> > > > > > > +config OF_BLOBLIST
> > > > > > > +     bool "DTB is provided by a bloblist"
> > > > > > > +     help
> > > > > > > +       Select this to read the devicetree from the bloblist. This allows
> > > > > > > +       using a bloblist to transfer the devicetree between  U-Boot phases.
> > > > > > > +       The devicetree is stored in the bloblist by an early phase so that
> > > > > > > +       U-Boot can read it.
> > > > > > > +
> > > > > >
> > > > > > I dont think this is a good idea.  We used to have 4-5 different options
> > > > > > here, which we tried to clean up and ended up with two very discrete
> > > > > > options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> > > > > > have a header of some sort?  The bloblist literally comes from a previous
> > > > > > stage bootloader which is what OF_BOARD is here for. So why can't we just
> > > > > > read the header and figure out if the magic of the bloblist matches?
> > > > >
> > > > > No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
> > > > >
> > > > > This patch is a standard mechanism to pass the DT from one firmware
> > > > > phase to the next. We have spent quite a bit of time creating a spec
> > > > > for it, and we should use it.
> > > >
> > > > Where exactly am I objecting using the spec?   Can you please re-read my email?
> > > > I am actually pointing out we should use the spec *properly*.  So
> > > > instead of having a Kconfig option for the DT, which is pretty
> > > > pointless,  we should parse the bloblist.  If the header defined by
> > > > the *spec* is found, we should just search for the DT in there.
> > > > What you are doing here, is take the spec, pick a very specific item
> > > > that the list contains, and create a Kconfig option out of it.  Which
> > > > basically ignores the discoverable options of the bloblist.  For
> > > > example, that bloblist can also contain an entry to a TPM eventlog.
> > > > Should we start creating Kconfig options for all the firmware handoff
> > > > entries that are defined on that spec?
> > >
> > > OK so that is a different thing. What should it do if it expects to find a bloblist but cannot? I want it to throw an error, because I am trying to make the boot deterministic. What do you think?
> >
> > That's fine by me.  You can even put that under IS_ENABLED for the
> > bloblist inside the existing OF_BOARD check.  So I was thinking
> > - If no bloblist is required in Kconfig options we do the hacks we used to
> > - if bloblist is selected and the config option is OF_BOARD, throw an
> > error and mention that the previous stage loader should hand over a DT
> >
> > Is that what you had in mind?
>
> Yes, that sounds good to me.
>
> But I still think we need an OF_BLOBLIST option to control whether the
> devicetree comes from there.
>  Otherwise we will end up with people
> using OF_BOARD to work around it. We also have the SPL case which does
> not pass the DT in a bloblist...in fact SPL typically doesn't even
> have the full DT.

Wouldn't IS_ENABLED(BLOBLIST) || IS_ENABLED(SPL_BLOBLIST) be enough?
Inside the OF_BOARD portion of the function, search for a bloblist if
the option is enabled.  If you can't find a bloblist and the DT within
that bloblist, then error out

Thanks
/Ilias
>
> [..]
>
> Regards,
> Simon
