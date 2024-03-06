Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD26C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 22:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D29D8752B;
	Wed,  6 Mar 2024 23:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cCEUj/0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4078D875FC; Wed,  6 Mar 2024 23:55:21 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546B686FCE
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 23:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob.wolff68@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a44628725e3so40574166b.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 14:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709765718; x=1710370518; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Dy38wDawSAQvCHeacPsx/MR1AK6a8ybFaUzqd8T+Eg=;
 b=cCEUj/0EA401jhadyNhJCAmizNV04NMMjPMn3kzHQOySoEdGH4NeXQ6YPUBkurdY4G
 XkaIawulZL0lWXMOVhgf53hXLN7aiEGXSYtix2CsW7MWuqREuegSsFhJoQvrXqAY2m/o
 Ck9Lg7KqYwrb0ttkmmmVRz/Yiu5OaxQicnjPfrvAC3TeVSQSYODFK5RspDpmtglk1N8b
 kPIYTGVUEPQSn54vojWkuUXJPWmB0PkCKTMsYoi9vsfuR9+mc/8sbbGuRwJTVMokFBRJ
 oT2GUC6TcFmFVOg0pwQwZZPZ/huC9EV4JCLNxm0HIUGB3hCf4cA+YIVJG0gllu4ax6+m
 JAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709765718; x=1710370518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Dy38wDawSAQvCHeacPsx/MR1AK6a8ybFaUzqd8T+Eg=;
 b=EsZn9nbZmM1/f85iLSrEupM32ACSsUobY9oa9MM1RWxjiyLjyEBf2cvfnyCLN0xOlH
 a+0CYBd/SJ2H/+uBm8jPGJmgCTEGnipBX2Mgt57+RlssVBYDjpV3i+YhkqangOeoZ0Vx
 0e7G1s419vDggXA8I09KBr+tlUXMwAAAp18wXaK4wLyFvJ78oOcZQPSSvUlrvwLSXjSA
 XehinSgndXWlFbZL8RnAyIyXp357bgE63EXWVxFJ7+wEETlO1UjM+yYfdan7AJ1LjW4V
 esZNtr5oogSntM4O6MrFzHrlIYeVD/QdE/S7j9OBMJv6ABQELnROL1soFSL2fYKuSyUJ
 99Ug==
X-Gm-Message-State: AOJu0YxSYogqCz+tnPEDGbJhEKrrhWAD5JrJ9me2bC6P7JqVmizhIwIa
 TlZWdKcUZ/QqbatqFk6Iud6vuBi+N+1RFb60DzKW2X3lwxYxucMrNdYEOWLkxv+fxsF8EHYKcmz
 MoeL01MeECDyxEvOvVBAJCpFoN5c4XH4/
X-Google-Smtp-Source: AGHT+IFt7nxCukR5hTAwPCJHywev/7BX7YjfADw1qRbpEmkYAYYMwpwHWvqX++CoQ3ZShjaY4YIh5ugUZYZVEB/pWDA=
X-Received: by 2002:a17:906:3941:b0:a43:f825:ef57 with SMTP id
 g1-20020a170906394100b00a43f825ef57mr11446555eje.49.1709765718282; Wed, 06
 Mar 2024 14:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20240227235704.48386-1-bob.wolff68@gmail.com>
In-Reply-To: <20240227235704.48386-1-bob.wolff68@gmail.com>
From: Bob Wolff <bob.wolff68@gmail.com>
Date: Wed, 6 Mar 2024 14:55:07 -0800
Message-ID: <CAF1iuRqtaZbPkPbzUdMrfzyZvNwkbvXuZoM0EgKgaJOhAXz2Pw@mail.gmail.com>
Subject: Re: [PATCH] Check curve_name for null to avoid crash
To: u-boot@lists.denx.de
Cc: seanga2@gmail.com, pbrobinson@gmail.com, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey all,
I think I addressed the nit of the missing blank line in my last email on
this thread. Wondering if there's more action to be had on my part or if
this just gets accepted etc.

Thanks!
Bob Wolff

On Tue, Feb 27, 2024 at 3:57=E2=80=AFPM Bob Wolff <bob.wolff68@gmail.com> w=
rote:

> If mixed rsa and ecdsa keys are specified in dtsi, an rsa key can be sent
> into the ecdsa verify. Without the ecdsa,curve property, this function wi=
ll
> crash due to lack of checking the null pointer return.
>
> Signed-off-by: Bob Wolff <bob.wolff68@gmail.com>
> ---
>
>  lib/ecdsa/ecdsa-verify.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index 0601700c4f..4d1835b598 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -31,6 +31,11 @@ static int fdt_get_key(struct ecdsa_public_key *key,
> const void *fdt, int node)
>         int x_len, y_len;
>
>         key->curve_name =3D fdt_getprop(fdt, node, "ecdsa,curve", NULL);
> +       if (!key->curve_name) {
> +               debug("Error: ecdsa cannot get 'ecdsa,curve' property fro=
m
> key. Likely not an ecdsa key.\n");
> +               return -ENOMSG;
> +       }
> +
>         key->size_bits =3D ecdsa_key_size(key->curve_name);
>         if (key->size_bits =3D=3D 0) {
>                 debug("Unknown ECDSA curve '%s'", key->curve_name);
> --
> 2.39.3 (Apple Git-145)
>
>
