Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD6AC0032E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 13:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BEA874B8;
	Fri, 20 Oct 2023 15:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kC3TJxis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9701B874C0; Fri, 20 Oct 2023 15:59:55 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5002086F5D
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7dd65052aso9847357b3.0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697810392; x=1698415192; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CF1CO5GFA+WmIy8gMzZxDsXGHBlfK8tQkvGZe3vEZro=;
 b=kC3TJxisDtcS3wXKcSQCiqG+MY73hEqt3RfIecuKPvoN/7ky8R0NucH6XWeK2lLJso
 iyT6m+eW64ydu76hkai/We52qvCYiff5LZ4wXV4afyyqwnsaheglrEnoEs80QN0679gu
 a+5g8KmZfCkE/l5R3kG0UjPk6hwyZf+e4bN+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697810392; x=1698415192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CF1CO5GFA+WmIy8gMzZxDsXGHBlfK8tQkvGZe3vEZro=;
 b=mpGKD9ZqNDoV0j9EsMPV0B9jBANHKqd615kQXVEUHZDLEbHgPR+KNNryo0GKtId0Jz
 9ZMt70HnseB13o25GszXUuOEwojStK5k4RgTAh3l6btAYThI/wzGi40Eeoljy1hVpz91
 RvDOhVrmSRdujEVYE+hg1e9+m/7q8o3uBr/CVSg81teyFqJcmn8KUZERQ1h8zjxCoDBq
 GR0AjjcWmPEqOQnsIcUTpgRsuDAAMU7lPJ9WDBrIxK3x+LmYfOh5oXts4Bl6Fq/3PuYt
 kxSpjZNPJR80VT9fFsJsm2kr6dBQhAwtsd6z3iYD3SEsm4NnHJLRi1SbIVt9pPx4dS5u
 JvHw==
X-Gm-Message-State: AOJu0YzHDE9Nya+7QpXqVQTnEuOyFQ7Fzj85XwRDzEMsNCDdja8dVaXF
 eZO70UL4Orlr+lVIy88FyHou7A==
X-Google-Smtp-Source: AGHT+IGgZc8UKWUyQy/f6sN2nI0CLtr/Ty+K2UiUGnUJ6VrcPOkZCHHJ39c1b8b9D8ZoObozfDHz/A==
X-Received: by 2002:a81:9211:0:b0:5a7:e6fb:39b with SMTP id
 j17-20020a819211000000b005a7e6fb039bmr2142754ywg.1.1697810392035; 
 Fri, 20 Oct 2023 06:59:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 y10-20020a81a10a000000b005a7cc149e3asm698510ywg.2.2023.10.20.06.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 06:59:51 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:59:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231020135949.GI3119521@bill-the-cat>
References: <CAPnjgZ2QV3t9FnY_7VBJ4NAYW8zPL9p1bktfcEP86AnXrFoA1w@mail.gmail.com>
 <CAC_iWjKd60b2pPdQf195ef+a8_3jEHtXh085Sd7uPAik1mCu+Q@mail.gmail.com>
 <700c3677-6fc1-40b0-9ca2-9f9e2cc824b0@amd.com>
 <CAC_iWjJUbads2Trqxm_chnhypyZ+tTT2mXUw56z0Py9bgyBhZg@mail.gmail.com>
 <8528ca89-16a7-48ba-95d3-72e7f3b107eb@amd.com>
 <CAC_iWj+-Om7Aqh7YQf1LhSZOSETeZgtBMRZKp4_AaixA5RfbHA@mail.gmail.com>
 <CAPnjgZ1ydE7y4UZPmvyaDTBVZdeQr=ftCnR1QtXB9TtewFkbxw@mail.gmail.com>
 <CAC_iWjLyupx5XUUm99qJg2Zt-G4KeZpTBoxWKOeXZ9nNw8roeg@mail.gmail.com>
 <CAPnjgZ1GGz6v8FzKOfNqqkZsVpQOzoM=Zz9hKcxpKgOt7oNssA@mail.gmail.com>
 <CAC_iWjJwLtF7L-NRo-nkO4qM8wotd0FyePYVS9mGewCjQkjbRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EPaPnzLCcYeDPp9l"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJwLtF7L-NRo-nkO4qM8wotd0FyePYVS9mGewCjQkjbRQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--EPaPnzLCcYeDPp9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 11:21:29AM +0300, Ilias Apalodimas wrote:
> Hi Simon,
>=20
> On Wed, 18 Oct 2023 at 18:26, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Mon, 25 Sept 2023 at 04:19, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > [...]
> > >
> > > > > > >>>>>>>>>> +config OF_BLOBLIST
> > > > > > >>>>>>>>>> +     bool "DTB is provided by a bloblist"
> > > > > > >>>>>>>>>> +     help
> > > > > > >>>>>>>>>> +       Select this to read the devicetree from the =
bloblist. This allows
> > > > > > >>>>>>>>>> +       using a bloblist to transfer the devicetree =
between  U-Boot phases.
> > > > > > >>>>>>>>>> +       The devicetree is stored in the bloblist by =
an early phase so that
> > > > > > >>>>>>>>>> +       U-Boot can read it.
> > > > > > >>>>>>>>>> +
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> I dont think this is a good idea.  We used to have 4-=
5 different options
> > > > > > >>>>>>>>> here, which we tried to clean up and ended up with tw=
o very discrete
> > > > > > >>>>>>>>> options.  Why do we have to reintroduce a new one?  D=
oesn't that bloblist
> > > > > > >>>>>>>>> have a header of some sort?  The bloblist literally c=
omes from a previous
> > > > > > >>>>>>>>> stage bootloader which is what OF_BOARD is here for. =
So why can't we just
> > > > > > >>>>>>>>> read the header and figure out if the magic of the bl=
oblist matches?
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> No, OF_BOARD is a hack to allow boards to do what they=
 like with the FDT.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> This patch is a standard mechanism to pass the DT from=
 one firmware
> > > > > > >>>>>>>> phase to the next. We have spent quite a bit of time c=
reating a spec
> > > > > > >>>>>>>> for it, and we should use it.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Where exactly am I objecting using the spec?   Can you =
please re-read my email?
> > > > > > >>>>>>> I am actually pointing out we should use the spec *prop=
erly*.  So
> > > > > > >>>>>>> instead of having a Kconfig option for the DT, which is=
 pretty
> > > > > > >>>>>>> pointless,  we should parse the bloblist.  If the heade=
r defined by
> > > > > > >>>>>>> the *spec* is found, we should just search for the DT i=
n there.
> > > > > > >>>>>>> What you are doing here, is take the spec, pick a very =
specific item
> > > > > > >>>>>>> that the list contains, and create a Kconfig option out=
 of it.  Which
> > > > > > >>>>>>> basically ignores the discoverable options of the blobl=
ist.  For
> > > > > > >>>>>>> example, that bloblist can also contain an entry to a T=
PM eventlog.
> > > > > > >>>>>>> Should we start creating Kconfig options for all the fi=
rmware handoff
> > > > > > >>>>>>> entries that are defined on that spec?
> > > > > > >>>>>>
> > > > > > >>>>>> OK so that is a different thing. What should it do if it=
 expects to find a bloblist but cannot? I want it to throw an error, becaus=
e I am trying to make the boot deterministic. What do you think?
> > > > > > >>>>>
> > > > > > >>>>> That's fine by me.  You can even put that under IS_ENABLE=
D for the
> > > > > > >>>>> bloblist inside the existing OF_BOARD check.  So I was th=
inking
> > > > > > >>>>> - If no bloblist is required in Kconfig options we do the=
 hacks we used to
> > > > > > >>>>> - if bloblist is selected and the config option is OF_BOA=
RD, throw an
> > > > > > >>>>> error and mention that the previous stage loader should h=
and over a DT
> > > > > > >>>>>
> > > > > > >>>>> Is that what you had in mind?
> > > > > > >>>>
> > > > > > >>>> Yes, that sounds good to me.
> > > > > > >>>>
> > > > > > >>>> But I still think we need an OF_BLOBLIST option to control=
 whether the
> > > > > > >>>> devicetree comes from there.
> > > > > > >>>>    Otherwise we will end up with people
> > > > > > >>>> using OF_BOARD to work around it. We also have the SPL cas=
e which does
> > > > > > >>>> not pass the DT in a bloblist...in fact SPL typically does=
n't even
> > > > > > >>>> have the full DT.
> > > > > > >>>
> > > > > > >>> Wouldn't IS_ENABLED(BLOBLIST) || IS_ENABLED(SPL_BLOBLIST) b=
e enough?
> > > > > > >>> Inside the OF_BOARD portion of the function, search for a b=
loblist if
> > > > > > >>> the option is enabled.  If you can't find a bloblist and th=
e DT within
> > > > > > >>> that bloblist, then error out
> > > > > > >>
> > > > > > >> Just my 2c here.
> > > > > > >> I think all options should be possible to disable. It means =
I can imagine to
> > > > > > >> disable u-boot not to take care about DT provided from previ=
ous stage. The same
> > > > > > >> is for TPM event log. IMHO every stage should have an option=
 to simply ignore
> > > > > > >> data pass from previous stage. I don't really mind how it is=
 done but there
> > > > > > >> should be an option to by purpose say to ignore the part of =
pass data.
> > > > > > >
> > > > > > > That would be done by disabling BLOBLIST.  I don't think havi=
ng a Kconfig to say
> > > > > > > "I want a bloblist, but I only want the DT from there" is rea=
sonable
> > > > > > > (or for any other item the bloblist can carry).   OF_BOARD me=
ans the
> > > > > > > DT will come from a previous stage loader. If bloblist is ena=
bled then
> > > > > > > the DT must come from there.
> > > > > >
> > > > > > I don't agree on this. If bloblist is enabled and DT is passed =
SW should have a
> > > > > > freedom to ignore it.
> > > > > >
> > > > > > At start everything is likely in sync but later stages before U=
-Boot can stay at
> > > > > > certain version but there could be a need to update u-boot wher=
e DT from
> > > > > > previous stage could be broken.
> > > > >
> > > > > But you *can* ignore it and load a different one later.  The only
> > > > > restriction is that if you compile u-boot with the assumption an =
early
> > > > > stage bootloader provides a DT you *must* find it.  But we will s=
till
> > > > > just keep 2 options in U-Boot of how you get a DT.
> > > > > A previous loader provided it or U-Boot provided it.  Whether that
> > > > > comes from a bloblist or a register is irrelevant no ?
> > > >
> > > > I'm not sure what is being requested here, so I'll leave this as is=
 for v2.
> > >
> > > Please don't.   A few mails above there's a discussion of how I'd
> > > prefer things to look like, please have a look and let me know if
> > > something isn't clear.
> > > tl;dr
> > >  "That's fine by me.  You can even put that under IS_ENABLED for the
> > >  bloblist inside the existing OF_BOARD check.  So I was thinking
> > >  - If no bloblist is required in Kconfig options we do the hacks we u=
sed to
> > >  - if bloblist is selected and the config option is OF_BOARD, throw an
> > > error and mention that the previous stage loader should hand over a D=
T"
> > >
> > > >
> > > > The main struggle I have is how to tell whether you expect to
> > > > *receive* the DT in the bloblist, or expect it to be attached to the
> > > > image and be *sent* to the next phase.
> > >
> > > bloblist
> > >
> > > >
> > > > SPL - attached to image, send in bloblist
> > > > U-Boot proper - not attached to image, receive it from bloblist
> > > >
> > > > This is exactly the problem that is solved by the 'standard passage'
> > > > stuff [1] but that depends on Firmware Handoff and [2] which are not
> > > > ready yet...
> > > >
> > > > So I think what I have is the best we can do for now.
> > >
> > > We can avoid the extra complication in Kconfigs.  The DT either comes
> > > from u-boot itself or from a previous stage loader. we don't need the
> > > extra "it comes from a bloblist".
> > > If they come from a previous stage loader and BLOBLIST *is* enabled,
> > > then just scan for the DT, if you don't find it error out.
> >
> > Are you planning to send a patch for this? Otherwise, what do you
> > think about going with this one and dealing with OF_BOARD board by
> > board?
>=20
> Yes, I can do that.  Since this patch is part of your series, I'll
> send it over to you and carry it there

The rest of this series, minus this patch has been merged.  We should
just start a new series I think.

--=20
Tom

--EPaPnzLCcYeDPp9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUyh9UACgkQFHw5/5Y0
tywfcgv/Z9cyIHLXyE6fVRUNQQ5mpVRTHdlWGwrUeIH6i+m8Pjup505k6cZlHRQn
6HGLO2wVuvy4voX8OGrIca9X9oGmYIRT/3ZdVUaYRRyodx/2M3RL2lxKLZfgxEBo
jNmMrdaJtrDjpDW33D/FkniRqqFdDxWsYb0CTtJs6+WKWe9Dq9PaAhNYqM54IO+h
yiJFBlGrYs7w6GsxhHKRZ8ccwoRZs39DbddJ25aU12b3sMpoM6TxbFFWqDdWTcxb
Gqn0Zha0slxG/Og+OrcSlTvymJSjZcFAEUSk0jttaXdfiJgCaJs/yhUprFt2vhL+
NtzhlQhPs/SqtR1uR9o848U3TikyLEBrGtDnjS6MNbox0wpiDvpEs7eKXoEhNhIZ
PxbiNFI2skT+8odgFNcCDH6GyEwgTJbF215koWuSiVmUwBaTbyqNnHCPALMMEjNv
qKuREaITDWpTYFWuEKXuscG41QeNiVQ1s84Pf5GbU7/uiMxtxJVqBNLpftpZaXaL
ZAHt8MTb
=XbUI
-----END PGP SIGNATURE-----

--EPaPnzLCcYeDPp9l--
