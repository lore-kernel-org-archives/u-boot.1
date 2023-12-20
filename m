Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F1C46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 17:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2D7877CB;
	Wed, 20 Dec 2023 18:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AQ+6v7Mf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E937877CB; Wed, 20 Dec 2023 18:32:42 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC4B87650
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 18:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cc8fd5d54bso11193191fa.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703093559; x=1703698359; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGSTTv4iAvHRWOum0CrAGh5UaJ7tC6HBsF8Kr9fEU58=;
 b=AQ+6v7Mf0YIn/Tk4rwbj7yTaUAkeen5c1Mho4APzePX5gvAjMWr5M19fNHuHzttSSk
 uzLvkCEC9Z/ZaBLSn43qTYw7/xUbxjhwEseOq/qIxE7a1iybdCogoU//rbqMygBIUt2N
 NIX2+/pDx1ihBGWcPp4cZWtjVXOWkkB+ugQnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703093559; x=1703698359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGSTTv4iAvHRWOum0CrAGh5UaJ7tC6HBsF8Kr9fEU58=;
 b=KoT02IBqkspz8+7DLEHKlt50QyYd0AuL99WCJKe1Fob7xZq7lqcc4m8dJcDNIu+Zu/
 x2//n1wUsYH/7ergcJLhWeHwe8z6wQhCwESKo6mqT+ikkyzlax/5p3udSAkboOjvLS/L
 84NYdP9KB3wrMYaydGcBfGp3xB/ue1qhwD0skgo8ky2K2pWGznRiweN0EN2iN3VsKJOO
 JjHzn8xAnRbSNYy5BzRtwpynfFtSShYk3/AoUXh0MwbSnerGDSQWAMhM0RwmWG9Sm6Sk
 h37Z8K7z35ZuV4Te4q3WGMHP+pMNqll/doT4CTFRDNMdSseAlF52YSF6IbpXVapL+yTn
 skJA==
X-Gm-Message-State: AOJu0Yz8MZcJF2UGdBtf5xn+xe0TldERZ7CYqojgYJ+RHzt3j/s3EGpD
 9BK0ZS6S6P0PR3FAjwrEzCWQwZ2G3A+8wdInltJipw==
X-Google-Smtp-Source: AGHT+IHyw1yDQpadxmKouIj+5ICdVC3zTAEg8J5rdHmZc/a2RATxA6Vn98OVR1eytNc/+qkK1X8uRjgDiBR6svDy4Gs=
X-Received: by 2002:a2e:2204:0:b0:2cc:5e32:bd87 with SMTP id
 i4-20020a2e2204000000b002cc5e32bd87mr4008192lji.99.1703093558993; Wed, 20 Dec
 2023 09:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
 <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
 <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
 <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
 <CALeDE9Moypi85cM8H2z+7nxZPVvJzj5DWWej0Qvdebpdp1qR1A@mail.gmail.com>
In-Reply-To: <CALeDE9Moypi85cM8H2z+7nxZPVvJzj5DWWej0Qvdebpdp1qR1A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Dec 2023 10:32:26 -0700
Message-ID: <CAPnjgZ0o7QENx3yFEx2SNpm0A7Li_qqvTeUmdDXNaCVuEA++Jg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com,
 sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peter,

On Tue, 19 Dec 2023 at 13:40, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> On Mon, Dec 18, 2023 at 3:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Ilias,
> >
> > On Wed, 6 Dec 2023 at 04:36, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > >
> > > >>
> > > >> >                 str =3D "Unknown";
> > > >> >
> > > >> >         for (;;) {
> > > >> > @@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbios_=
ctx *ctx, const char *prop,
> > > >> >                 const char *str;
> > > >> >
> > > >> >                 str =3D ofnode_read_string(ctx->node, prop);
> > > >> > -               if (str)
> > > >> > -                       return smbios_add_string(ctx, str);
> > > >> > +               return smbios_add_string(ctx, str);
> > > >> >         }
> > > >> >
> > > >> >         return 0;
> > > >> > @@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *current=
, int handle,
> > > >> >         t->vendor =3D smbios_add_string(ctx, "U-Boot");
> > > >> >
> > > >> >         t->bios_ver =3D smbios_add_prop(ctx, "version");
> > > >> > -       if (!t->bios_ver)
> > > >> > +       if (!strcmp(ctx->last_str, "Unknown"))
> > > >>
> > > >> That is really ugly...checking the ctx value looking for a side ef=
fect.
> > > >>
> > > >> Can you not have smbios_add_prop() continue to return NULL in this=
 case?
> > > >
> > > >
> > > > Hmm I don't know, but I wonder why I am not just checking t->bios_v=
er for Unknown.
> > > > I'll have a look and change it
> > >
> > > Ok, this can't be changed as easily.  smbios_add_prop() will not
> > > return NULL in any case. It returns an integer. With the cleanup, it
> > > will always writes 'Uknown' and not return 0 anymore.
> > > I can add that default value you suggested but the ctx->last_str is
> > > still used on the next line anyway.
> >
> > Would you mind if I tried to create a version of the patch which does
> > the same thing but with less code, and perhaps a test? It might be
> > easier to discuss it then. I can't claim to understand all the
> > different code paths at this point.
> >
> > My main concern is that with so many code paths it will be hard even
> > to refactor the code in the future, since it will become
> > 'load-bearing' and anyone might turn up and say it breaks their board
> > because different information is provided.
>
> I don't buy this argument at all, sorry.

OK.

>
> > Overall, so long as the information isn't used for anything important
> > in userspace, and we find a way to report SMBIOS to Linux without EFI,
>
> No, you can't tie random requirements to improving the SMBIOS support.
> We *already* report SMBIOS to Linux, reporting SMBIOS to Linux without
> EFI is changing things that will need different or extra standards,
> that could take years.
>
> You are arbitrarily adding extra requirements just to suite yourself,
> please STOP trying to hold things like this hostage.

Isn't that what is happening with Linux and ffi? My understanding is
that there is no way to pass SMBIOS to Linux without EFI. Is that
correct? I know some people at their wit's end about that.

You may know that I have tried for years to get bindings upstream to
Linux....right now there is a reserved-memory binding which has been
held up for longer than I can remember, because of EFI. How about a
little give and take?

>
> > it is OK to enable this feature (with a new Kconfig so it can be
> > disabled). But there is already authoritative info in the DT, so this
>
> There is two types of information in DT, the smbios "entries" in DT
> are not standardised in the dtschema and in most cases they're
> unnecessarily replicating data ALREADY in DT which is being produced
> automatically with these patches, making it zero effort for vendors to
> produce.
>
> > transformation into SMBIOS really should just be used for user
> > display, etc., not for anything which affects operation of the device.
>
> Well SMBIOS tables are used for a number of different things already
> in the kernel.
>
> > Do you agree? If you do, how to ensure that? Perhaps a special string
> > in the table like 'GENERATED'?
>
> Nope, I do not agree, at all.

OK, well there it is.

Anyway, as I said, I am happy for this to go in with a Kconfig
controlling it (so it can be enabled/disabled). Then SoCs that don't
want to go to the bother of adding authoritative info can just enable
this Kconfig.

I would very much like to see some signal that it is not
authoritative. That should not be a big imposition.

For my own interest, I would like to understand what actually uses it
as I suspect it is just for display. The two programs I managed to
find both handle devicetree and don't need SMBIOS.

Regards,
Simon
