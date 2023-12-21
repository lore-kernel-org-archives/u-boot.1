Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2CFC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 09:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8498F87527;
	Thu, 21 Dec 2023 10:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="irh67iQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F2F876AE; Thu, 21 Dec 2023 10:13:25 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29305874D5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 10:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55322dbabf6so604259a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703150002; x=1703754802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=80Wno80/ux2aaX8ntmKp5L9bfTHADnaijQjEMbAwVeE=;
 b=irh67iQJ5GhHNGM9BExXNtr0+wOc8S6Uuyp7DOECL2mdU7wsPRy1InlINx8pqqM5Qj
 ssgSx0XeIQYhpL3xhmA5wee9aIdd2UeqqSLrW72DdspekFhehCsvNl6CPff0RaYozUUS
 UleBiPrkc5Lb51mv7b8+qokh8VqKLOPv8cKD5SjD0IjUstT01xd6PitSiF5ZBNSgrV3e
 7oCR2BgjT/jWsJ9glnNplH+tU01qty+VMZApuntw3LXQxQORRByUAE5mHURS7QttgyOm
 VPvSnaPrQ1uapNpwExFKlfS+HjPuict1UbY3PLvEYO6nPvOO6+FJdf5aUJ3Qv1v+YNUc
 UiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703150002; x=1703754802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=80Wno80/ux2aaX8ntmKp5L9bfTHADnaijQjEMbAwVeE=;
 b=hu3Ratml504fbH+24q2kcGkHBLHebLl+t9ybNJDIDpGU+HMur3gd2TZ2AZlIuZfYnG
 Z2zeUQ+xmBc3CHTdW8uP2dYD+SRUzNxeN7A1/pIDdryEew/UuoW1rveXBOO0+JvN8+OA
 CGrJwD+fsoehu/zDNaz4BrVod5QcFtM4erBWPkHJMSyRAY9+OhiMvKCKf65lhggK31Kg
 qGxxagSqNjITrJNE8b0LtDf2JzFyPZhD8cCWraZLWjYe3sw6Ohcy0JEiz1OKNX9+prMX
 Qo+BdPsK4ufivDnyUoPYSj8rnEGy2qhGIQ/yk5mTqihvfmHMT50qav6+q0D5PZed5PtD
 zehQ==
X-Gm-Message-State: AOJu0Yw/uUljVRtFy9bd53ceD9Qr1W/fLFGU2miHXV4oZ/Gw/ftLGqSD
 e4LWiQYrEP6iMxp7nrCKGXLAo1bpr4ae40kLBA4=
X-Google-Smtp-Source: AGHT+IH50XsACYLOPJlQxoHuu31yhdEq1GIZQrItcDqCraz18Sbymza2fxnk0Pm+eFHUQS7TPxQ8gOsMuSCwL4IIlDk=
X-Received: by 2002:a50:d51b:0:b0:553:29ef:4f86 with SMTP id
 u27-20020a50d51b000000b0055329ef4f86mr3939231edi.69.1703150002383; Thu, 21
 Dec 2023 01:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
 <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
 <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
 <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
 <CALeDE9Moypi85cM8H2z+7nxZPVvJzj5DWWej0Qvdebpdp1qR1A@mail.gmail.com>
 <CAPnjgZ0o7QENx3yFEx2SNpm0A7Li_qqvTeUmdDXNaCVuEA++Jg@mail.gmail.com>
In-Reply-To: <CAPnjgZ0o7QENx3yFEx2SNpm0A7Li_qqvTeUmdDXNaCVuEA++Jg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 21 Dec 2023 09:13:11 +0000
Message-ID: <CALeDE9Pc5Z0x1PED3u+OQ0agNUWE7f=DCa5eoRsgWCVHPLAiYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com,
 sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
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

> > > > > Hmm I don't know, but I wonder why I am not just checking t->bios_ver for Unknown.
> > > > > I'll have a look and change it
> > > >
> > > > Ok, this can't be changed as easily.  smbios_add_prop() will not
> > > > return NULL in any case. It returns an integer. With the cleanup, it
> > > > will always writes 'Uknown' and not return 0 anymore.
> > > > I can add that default value you suggested but the ctx->last_str is
> > > > still used on the next line anyway.
> > >
> > > Would you mind if I tried to create a version of the patch which does
> > > the same thing but with less code, and perhaps a test? It might be
> > > easier to discuss it then. I can't claim to understand all the
> > > different code paths at this point.
> > >
> > > My main concern is that with so many code paths it will be hard even
> > > to refactor the code in the future, since it will become
> > > 'load-bearing' and anyone might turn up and say it breaks their board
> > > because different information is provided.
> >
> > I don't buy this argument at all, sorry.
>
> OK.
>
> >
> > > Overall, so long as the information isn't used for anything important
> > > in userspace, and we find a way to report SMBIOS to Linux without EFI,
> >
> > No, you can't tie random requirements to improving the SMBIOS support.
> > We *already* report SMBIOS to Linux, reporting SMBIOS to Linux without
> > EFI is changing things that will need different or extra standards,
> > that could take years.
> >
> > You are arbitrarily adding extra requirements just to suite yourself,
> > please STOP trying to hold things like this hostage.
>
> Isn't that what is happening with Linux and ffi? My understanding is
> that there is no way to pass SMBIOS to Linux without EFI. Is that
> correct? I know some people at their wit's end about that.

Maybe the uses that want to go from a minimal firmware straight to a
minimal kernel don't care about SMBIOS tables for their use cases,
things don't need to be full parity to move forward the existing well
defined usecase.

> You may know that I have tried for years to get bindings upstream to
> Linux....right now there is a reserved-memory binding which has been
> held up for longer than I can remember, because of EFI. How about a
> little give and take?

I actually caught up on the reserved-memory binding thread a week or
so ago and my general thoughts from that thread was that there was a
lot of outstanding questions being asked of you that you haven't
clearly articulated or even replied to and the thread ended with you
asking a number of times "can this be merged now?" and my thought at
the time was "No, because there's a bunch of outstanding details". May
I suggest you re-read that thread and take some notes while you do so
and make sure all the outstanding questions have been answered and
reply with a single response addressing the remaining details, from
there we may be able to move on.

> >
> > > it is OK to enable this feature (with a new Kconfig so it can be
> > > disabled). But there is already authoritative info in the DT, so this
> >
> > There is two types of information in DT, the smbios "entries" in DT
> > are not standardised in the dtschema and in most cases they're
> > unnecessarily replicating data ALREADY in DT which is being produced
> > automatically with these patches, making it zero effort for vendors to
> > produce.
> >
> > > transformation into SMBIOS really should just be used for user
> > > display, etc., not for anything which affects operation of the device.
> >
> > Well SMBIOS tables are used for a number of different things already
> > in the kernel.
> >
> > > Do you agree? If you do, how to ensure that? Perhaps a special string
> > > in the table like 'GENERATED'?
> >
> > Nope, I do not agree, at all.
>
> OK, well there it is.
>
> Anyway, as I said, I am happy for this to go in with a Kconfig
> controlling it (so it can be enabled/disabled). Then SoCs that don't
> want to go to the bother of adding authoritative info can just enable
> this Kconfig.
>
> I would very much like to see some signal that it is not
> authoritative. That should not be a big imposition.
>
> For my own interest, I would like to understand what actually uses it
> as I suspect it is just for display. The two programs I managed to
> find both handle devicetree and don't need SMBIOS.
>
> Regards,
> Simon
