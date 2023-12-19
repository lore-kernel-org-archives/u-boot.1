Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B8FC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 20:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A15BC86FF4;
	Tue, 19 Dec 2023 21:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PPOvLmuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7371186FF4; Tue, 19 Dec 2023 21:40:29 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A43386F56
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 21:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cc7d80324dso15254981fa.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703018426; x=1703623226; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlaUf6VsDOfhZQ3/HeMr7dpLwXEn6TiF4y8xI78fbTU=;
 b=PPOvLmuK6G2hdIdw7YLtOTnkf49kMyzvqrzFe4BLwNHDtUAlZYcf2G7/SpeeYPvUCN
 VsilkCjQfkAVNk/z0X/vM4lnmRly6jyPTiJzrGkBC30NELv+V1vkHilzP0IWH+vYK48r
 PWEftNykMd782yTrQVDA6x+8sF0Evp9xbdRS4iXKaUSgSgBhCTTKNej/p18PogJIEQfq
 mJ7CPD6HtAwPSaYsr/kHJ/GWrmZQGM8nnsVoe/Yyl7+XVlnQ7bPHkShRVGVamqxJ5XW7
 l2sXLNqiLfp9xmsxDCGIGYYfmNS8WdPUWdMagu95JgVAVeqjsE6wOWeWumb+q0teRsTT
 DSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703018426; x=1703623226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dlaUf6VsDOfhZQ3/HeMr7dpLwXEn6TiF4y8xI78fbTU=;
 b=aP9J0m2tinX4BjwrgZIOHnH67a6zLxB+qhsEiNlMSpPqqSSz7Nhv/Kqb6afUKzuTMJ
 C4k/RET2ct9zwLsp+YgwNWn+gGl2GaXPQ36tqaz/RcwYp2PT7yyA4LxX2tIXMEjrmy4h
 rlkEXyGSv/0GW7lGzN4BsaafzNnSNlB5trYUdencR4rmV32nPipzAB9p8qTtzjRidjGy
 vetJxPP5qXM1k7Lf0bZA8ciTB7xAdlwrqRhXeoxCiYib62cqQic6QWMYX0DuwNTEQRd7
 kWhHFAJl3jrPDwJ1R05yzMZ8emm3/5s6hNCa8hMAsHOZcfiEDgKY21JpCJsNnG39R2se
 QfyQ==
X-Gm-Message-State: AOJu0YwmCfQfjkLYXWS8kykW4qEX2wuLZMJS64D4g/FSv3s93s4xuQwx
 CXv11CwAUv59AItptnhfE+bTLas93gIDlG8n+i4=
X-Google-Smtp-Source: AGHT+IEw0eFYlq2lRwFqnNGMrXL2Eu5RE8+UMNt8VfmeMQ+a8lkke90OFFOSO1enZ+aKwKbKfu8LmHtF5nXlUnwfbp4=
X-Received: by 2002:a05:6512:3f23:b0:50b:f924:71dc with SMTP id
 y35-20020a0565123f2300b0050bf92471dcmr6830662lfa.124.1703018426330; Tue, 19
 Dec 2023 12:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
 <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
 <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
 <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Dec 2023 20:40:10 +0000
Message-ID: <CALeDE9Moypi85cM8H2z+7nxZPVvJzj5DWWej0Qvdebpdp1qR1A@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Mon, Dec 18, 2023 at 3:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Ilias,
>
> On Wed, 6 Dec 2023 at 04:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > [...]
> >
> > >
> > >>
> > >> >                 str =3D "Unknown";
> > >> >
> > >> >         for (;;) {
> > >> > @@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbios_ct=
x *ctx, const char *prop,
> > >> >                 const char *str;
> > >> >
> > >> >                 str =3D ofnode_read_string(ctx->node, prop);
> > >> > -               if (str)
> > >> > -                       return smbios_add_string(ctx, str);
> > >> > +               return smbios_add_string(ctx, str);
> > >> >         }
> > >> >
> > >> >         return 0;
> > >> > @@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *current, =
int handle,
> > >> >         t->vendor =3D smbios_add_string(ctx, "U-Boot");
> > >> >
> > >> >         t->bios_ver =3D smbios_add_prop(ctx, "version");
> > >> > -       if (!t->bios_ver)
> > >> > +       if (!strcmp(ctx->last_str, "Unknown"))
> > >>
> > >> That is really ugly...checking the ctx value looking for a side effe=
ct.
> > >>
> > >> Can you not have smbios_add_prop() continue to return NULL in this c=
ase?
> > >
> > >
> > > Hmm I don't know, but I wonder why I am not just checking t->bios_ver=
 for Unknown.
> > > I'll have a look and change it
> >
> > Ok, this can't be changed as easily.  smbios_add_prop() will not
> > return NULL in any case. It returns an integer. With the cleanup, it
> > will always writes 'Uknown' and not return 0 anymore.
> > I can add that default value you suggested but the ctx->last_str is
> > still used on the next line anyway.
>
> Would you mind if I tried to create a version of the patch which does
> the same thing but with less code, and perhaps a test? It might be
> easier to discuss it then. I can't claim to understand all the
> different code paths at this point.
>
> My main concern is that with so many code paths it will be hard even
> to refactor the code in the future, since it will become
> 'load-bearing' and anyone might turn up and say it breaks their board
> because different information is provided.

I don't buy this argument at all, sorry.

> Overall, so long as the information isn't used for anything important
> in userspace, and we find a way to report SMBIOS to Linux without EFI,

No, you can't tie random requirements to improving the SMBIOS support.
We *already* report SMBIOS to Linux, reporting SMBIOS to Linux without
EFI is changing things that will need different or extra standards,
that could take years.

You are arbitrarily adding extra requirements just to suite yourself,
please STOP trying to hold things like this hostage.

> it is OK to enable this feature (with a new Kconfig so it can be
> disabled). But there is already authoritative info in the DT, so this

There is two types of information in DT, the smbios "entries" in DT
are not standardised in the dtschema and in most cases they're
unnecessarily replicating data ALREADY in DT which is being produced
automatically with these patches, making it zero effort for vendors to
produce.

> transformation into SMBIOS really should just be used for user
> display, etc., not for anything which affects operation of the device.

Well SMBIOS tables are used for a number of different things already
in the kernel.

> Do you agree? If you do, how to ensure that? Perhaps a special string
> in the table like 'GENERATED'?

Nope, I do not agree, at all.

Regards,
Peter
