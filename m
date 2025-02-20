Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2143C021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 07:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75FD6801DE;
	Thu, 20 Feb 2025 08:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H7ndFVDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFBCE80EC0; Thu, 20 Feb 2025 08:57:44 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3945801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f6c90b51c3so6013217b3.2
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 23:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740038261; x=1740643061; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EncVfHHRtfTxVnR7wNw74dN4u8HucAXMVpATDC8n0EE=;
 b=H7ndFVDsauVGFHNz4ylqXDQvuRl1cydI8g3nbv6so6e1EUqTKn1jsR7sBLzcyKIy57
 3nrQYU/hnmGztAhpv0/2CyVy4r71qKyZwZP+ybBhQgZhE9JNQ+WCIgPhDHbulYydGuB4
 Omk3A7k80/J9wIMzE4E6K3LLJ0GvHsE/KGTEnDXFJncTbBfSJgXDy3INMgKEJlYjszA/
 7R/LgKsFL7b77BIHHP6jvDJVOnSRAkdxuAqtquUp5x8/flihLzggXzY30cOTkFFZPyau
 avkfvN/ihXPrRn2w/M0Sc4QcYJku8gomNMQGtFnD2HRbZ34NTv3/JP2PrS+2YKt9qLl6
 u10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038261; x=1740643061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EncVfHHRtfTxVnR7wNw74dN4u8HucAXMVpATDC8n0EE=;
 b=aprvTB4CdJq5wT37OERaDASD0hxS5htaSw+TjsVJsI1VwMuPXub12if0QkgGbhXSO1
 WW0zcujh9U4QjCgfjYgvEOBii5qP95JOjZA/KL92p/3jau75HzCYR/cKU5ukppgdu7JP
 uqFCrDJ2c3pVnWwPOcNuAUfufLn+RwIh0gB/E2iMEq3sy1P0pDlsQ/DerUuzl6qQy3BF
 7aXa/G+GO1cSo4CQogauNLg2sDY7pjbNMimMsuebNmobMJmRsgCsKq4gxYDOCn0zpgaL
 H7h1IvS98pG28smrorM7/KKiDDGHR+TJcy8oQ8xgefs5EnFLmRxzj9/proY0goiHR0b5
 qZ1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp5LF4J59UXqfd+wdEd6oZYROmbSofJwlXZRBK2TWadhXUByRLgqEf1mO2NYqx0J/N9OU1YXs=@lists.denx.de
X-Gm-Message-State: AOJu0YyzdTxBQ3EHiDOWqViRjeBQ1fuv+tpmUt6sJO1N2t0LP0uMmvV0
 xOZS8CaiTNg8rA+g0zoi5FTTJqIjxLgrkvSxXuLj8hcn2D5Ha3NsxQ1+tTA+r2pydRuliJcgyaO
 C+i/0SZixKytBUU4DYr2dg2CxJHvWPz2BskXIJRpu6YuK7D8Wtrc=
X-Gm-Gg: ASbGncvqR5mh/3cjQ5DtHvAhJakgL16yFzKZbhwykABBdR8Djz4SEgSNz1deYfpvkhr
 /bt5RTy6c7zPfZKCPi+q/0112DzkSpIrzO/QXRZHaVI+8c43FZFoaSHPWcSEGCZxhn7PHHguVlg
 ==
X-Google-Smtp-Source: AGHT+IFczEvG4bIAh7U6iWuKt6XSSONcpsO2JQiH2sAVccSqFuOdt+7UcKUiF1lP0FAH6YKXlQdOkam4Z733uRjHkv0=
X-Received: by 2002:a05:6902:1442:b0:e5d:b13a:5ad5 with SMTP id
 3f1490d57ef6-e5dc930d306mr16428232276.46.1740038260714; Wed, 19 Feb 2025
 23:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20250117171327.1641490-1-vincent.stehle@arm.com>
 <6731f7f2-25c0-433f-8bb1-2cb31f204d48@gmx.de>
In-Reply-To: <6731f7f2-25c0-433f-8bb1-2cb31f204d48@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 09:57:05 +0200
X-Gm-Features: AWEUYZlur1f9VLFOcoUJBcnamFmMBbcpeTO0q1ukP3vPgxFaKCgNJaLdfPB7H2U
Message-ID: <CAC_iWjKQemGMX2MDhxiOcP8MpnG-Hj=B3H+A0o=QxCu7rGs3+w@mail.gmail.com>
Subject: Re: [PATCH] lib: uuid: support more efi protocols in
 uuid_guid_get_str()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Thanks for the CC Heinrich

I actually lost that on the ML

On Thu, 20 Feb 2025 at 09:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
> On 1/17/25 18:13, Vincent Stehl=C3=A9 wrote:
> > Add more EFI protocols GUIDs to the translation table used by
> > uuid_guid_get_str().
> >
> > Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> > Cc: Tom Rini <trini@konsulko.com>
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> > ---
> >
> > Hi,
> >
> > While the EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID, the
> > EFI_HII_CONFIG_ACCESS_PROTOCOL_GUID and the EFI_LOAD_FILE_PROTOCOL_GUID=
 are
> > actually used by the efi_loader, this is not the case with the
> > EFI_DISK_IO_PROTOCOL_GUID.
> > I think we should add this GUID to the table nonetheless, as it can hel=
p
> > with debugging EFI applications and we already have this GUID's definit=
ion
> > in the headers.
> > If that is not desired, please do not hesitate to drop the first hunk o=
f
> > this patch.
> >
> > Best regards,
> > Vincent.
> >
> >   lib/uuid.c | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> >
> > diff --git a/lib/uuid.c b/lib/uuid.c
> > index 97388f597a6..75658778044 100644
> > --- a/lib/uuid.c
> > +++ b/lib/uuid.c
> > @@ -119,6 +119,10 @@ static const struct {
> >               "Block IO",
> >               EFI_BLOCK_IO_PROTOCOL_GUID,
> >       },
> > +     {
> > +             "Disk IO",
> > +             EFI_DISK_IO_PROTOCOL_GUID,
> > +     },
> >       {
> >               "Simple File System",
> >               EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID,
> > @@ -127,6 +131,10 @@ static const struct {
> >               "Loaded Image",
> >               EFI_LOADED_IMAGE_PROTOCOL_GUID,
> >       },
> > +     {
> > +             "Loaded Image Device Path",
> > +             EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID,
> > +     },
> >       {
> >               "Graphics Output",
> >               EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID,
> > @@ -139,10 +147,18 @@ static const struct {
> >               "HII Database",
> >               EFI_HII_DATABASE_PROTOCOL_GUID,
> >       },
> > +     {
> > +             "HII Config Access",
> > +             EFI_HII_CONFIG_ACCESS_PROTOCOL_GUID,
> > +     },
> >       {
> >               "HII Config Routing",
> >               EFI_HII_CONFIG_ROUTING_PROTOCOL_GUID,
> >       },
> > +     {
> > +             "Load File",
> > +             EFI_LOAD_FILE_PROTOCOL_GUID,
> > +     },
> >       {
> >               "Load File2",
> >               EFI_LOAD_FILE2_PROTOCOL_GUID,
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
