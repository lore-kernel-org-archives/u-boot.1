Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3678CC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969F8870F9;
	Sat, 18 Nov 2023 22:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="X173Bj9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C468711D; Sat, 18 Nov 2023 22:17:18 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142CD87083
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9de7a43bd1aso423913166b.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700342223; x=1700947023;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZdPtonXVBlj+zLa61oZRcshT/+Uz7M7VKPQjasr3z0=;
 b=X173Bj9/DzSMPPNZGm872KHg9Wzt8rMI70PjmMRnU1BbjoaBEu2rtdoI/UXRy8ejht
 jINdwLhh2ug1v1qTYBpr9USG40Y2x7m0DY7V88bDllElJ1qEy6hG8E47Jaynj479y6b7
 TfVDt9PQ/vMPCrI8+Iz+4FhCJtkUKc2KThhHZDskqkgZ6zmOlfgqKzneNaoKEFGH4TUE
 oGsD4n2ljVNRAle1kgsBa6JrsqatRBPgvbmNGVheCNUc2Pa005PKpkBIa/qBKrFVr76c
 rKFNX50GfUxn4JIi1Thux+lJ+8RrrYx8Xzza/FvFKfhBzZYZ/ABfleJqPrjBQKpvNceU
 z6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700342223; x=1700947023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZdPtonXVBlj+zLa61oZRcshT/+Uz7M7VKPQjasr3z0=;
 b=f1SdtxXsZfodl+i/QpcmxPpdYKkTyK7pMpiiprBlvPqeiDsBSkL5LGbJc2l630RbxU
 WzKV7QJc4d0bqPWrDsyqTWCRdxBPrKRcZJdyEEJb1Z5bBJkAOGMys7pp4ocqgk5MzVo4
 DFVr2z+nkqDJnw3CWVapppGgyV/oyOYgQt02k4tx/1GecVryhtTv4Cp0xVYxejFdVd7d
 O4NaUPjT6sQMXWZl3zZJcXkwFqPZJsBEgppDWxy/QzdNFru8pSDioF8I/LObmwxsm1tF
 mdQ5QiXsWwjZUsxKmgI2wWL/Uu9D4HnHH6feUwCnweZv72xbCSSslWSZL9TjR8XJXv5u
 awFg==
X-Gm-Message-State: AOJu0Yy0jejAsxxmoUP2fr94CvOsIYii0zithmQC8OWe36WJ7/ku/Lyw
 W8tCGLIh6mil9WSbIA5475i+tznQS67aPMal7nu+tQ==
X-Google-Smtp-Source: AGHT+IEb1+mHASDBmZduAIVhFtt6Ef1s1TeG0xD6n6iQqGtg1xe2SR5pSHOGVUzneb3LLge4q95WOg==
X-Received: by 2002:a17:906:5345:b0:9b2:6d09:847c with SMTP id
 j5-20020a170906534500b009b26d09847cmr1983916ejo.10.1700342223246; 
 Sat, 18 Nov 2023 13:17:03 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com.
 [209.85.208.47]) by smtp.gmail.com with ESMTPSA id
 p27-20020a1709060ddb00b009fc50ebb062sm240013eji.4.2023.11.18.13.17.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 13:17:02 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so4465251a12.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:17:02 -0800 (PST)
X-Received: by 2002:aa7:c994:0:b0:53e:8972:1d4f with SMTP id
 c20-20020aa7c994000000b0053e89721d4fmr2056503edt.5.1700342222011; Sat, 18 Nov
 2023 13:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-3-i@shantur.com>
 <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 18 Nov 2023 21:16:50 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1rR0gjkP2z=CQh0zy3hYUf734fVUq8eKjG1i2V3h0Hsw@mail.gmail.com>
Message-ID: <CAHc5_t1rR0gjkP2z=CQh0zy3hYUf734fVUq8eKjG1i2V3h0Hsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bootflow: bootmeth_efi: Don't set bootdev again
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sat, Nov 18, 2023 at 5:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> +Ilias too as this involves a design decision
>
> Hi Shantur,
>
> On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
> >
> > efi_set_bootdev is already called as part of tftp while doing dhcp_run(=
)
>
> Is that in tftp_complete() ?
>
> > Doing this again crashes U-boot and we don't need to call again.
>
> U-Boot
>
> The problem is that we might scan for 4 bootflows, then later decide
> which one to boot. So we cannot know which one it will be until that
> point.
>
> The hack is needed so that it actually tells EFI about the right one.
>
> The addition of EFI hacks when reading files (i.e. the code in
> tftp_complete()) is a real problem, unfortunately. I understand that
> it was a convenient hack, but with standard boot we really don't want
> it to do that. We end up calling it multiple times for bootflows that
> won't be used.
>
> So I believe the fix is to be able to disable those calls, leaving it
> to bootstd.
>
> I'm not sure of the best way to do that. Perhaps we should have a
> function like bootstd_scanning() which returns a bool indicating that
> bootstd is scanning? If that is true then no efi_set_bootdev() calls
> are made? We could have a flag in 'struct bootstd_priv' which is set
> before bootflow_check() is called and cleared afterwards.
>
> As to how this should be done with standard boot, we should create a
> function like efi_start_app() and pass it the information we need.
> That function should do the equivalent of the 'bootefi' command,
> except programmatically, with no prior state hanging around.
>
> As to when we might be able to do that, we need more refactoring of
> the bootm code. There is a start on this [1] but it likely needs 2-3
> more series before it might be possible.
>
> So for now, I think bootstd_scanning() is the best approach. If you
> are not sure about that, I can send a patch.
>

My apologies, the fix I submitted is incorrect.
After reading your explanation, I started thinking on why dhcp can
call this multiple times but bootmethod can't.

There it was clear that the issue bflow->fname is null when we call
this function.
The correct fix should be below

+       /* bootfile should be setup by dhcp by now*/
+       bootfile_name =3D env_get("bootfile");
+       if (!bootfile_name)
+               return log_msg_ret("bootfile_name", ret);
+       bflow->fname =3D strdup(bootfile_name);
+
    /* do the hideous EFI hack */
    efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
                    bflow->size);

I have a patch ready for this which I will send but I have some
queries regarding that.
As I sent this a series of patches out of which 2 were reviewed,
should I send a new version for the whole series even though 2 are not
going to be changed?
Another thing, should I send them as a reply to the original email or
a new thread?

Kind regards,
Shantur
