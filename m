Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21132D63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB5A891E8;
	Wed, 20 Nov 2024 14:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MARrKD8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4027789001; Wed, 20 Nov 2024 14:03:58 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 740B688DC6
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visechelle@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-72483f6e2fbso3575144b3a.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732107834; x=1732712634; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rAv6xjcjdWkWXyIg23lca4lgwuBUJA/A46ysO8azIbY=;
 b=MARrKD8M75IfSJ+ZLySUpjZYypBPEDelws0/GSBzJRgr3SsqF7RaMc95ah4dHWGDY1
 WXYYlAdwJwgeca+yznegy1ZhDBa4r0BBbsa8UPPQdFnht56tYn3uZRxiEqHzX/QLs7VN
 w1VyfjPVwVMILTTfr2aN+2NQAUK6AbAnxDPpELb2mIKYubnkeZTqYkzpOsPdSplCx+ca
 3oDJRMxNXQkeY1jSKN9NvC8CRRD8ch2+m4GGQNoopcf//Yvh58asmEzbEJHsSJbAFp04
 pesdmOSY/VLCy5w8lXBCGV7WByFZNWLb8rW6wu9Dh/xO9EwBPyqM59u4UCQU2I2GH+Qw
 msMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732107834; x=1732712634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rAv6xjcjdWkWXyIg23lca4lgwuBUJA/A46ysO8azIbY=;
 b=RLEZm9z7EOmon5jHSxlt08R40rNEKITqj5GQRNwtyZI8VhPmHUeDMGLU2FPCt3ryzz
 B0TtFekgsvAJVrQo2XscNzermzfqKKvrRS6hrddvEQ2S3M+GOXMjc0u5E/rK1I5YuLN0
 IEowPYpYWTIefI8M9lFLjCHUX2NQCrqI+ZnTUm4ZT8dYESLMqCt/ZiL1CXLcG2gW+aPo
 /T7WqPt51lZUIINVhYoYGNcXPK9dgWwjHpo7TnjNmFxDxd/R5HY1JQ6vIa4bI2St/VXq
 PdLay0eg/uscDxn6nf1JWmWCxA0gbsGINUKQJ/8uvvMqo0bkGKfV/991I4KzN11rnjaJ
 pK2g==
X-Gm-Message-State: AOJu0YyEbyQ6zZvf/U+xkUM8QlorHIK4MNiSZVr21HqrdO1FlbDyPXpz
 WPIYJM2vuIBpB2CqBzMB+4qGjh9+fdLjxCyXMVEbgVpFS0RSVPimvLSn8RWR09hkRTCA3+1Unjh
 hOSLpEJBUk01clc5Q5GDQg/Kuq7Y=
X-Google-Smtp-Source: AGHT+IF7jp7hZO+iHs/OwqSyuJPWX0qY5JgDWXbjr2TPszG6xWtVI2VCdgWB+a1EkrB7bPGD/COXX7CdGksoWubGdwk=
X-Received: by 2002:a05:6a00:4f8f:b0:71e:8046:2728 with SMTP id
 d2e1a72fcca58-724bed160a6mr3635185b3a.17.1732107833843; Wed, 20 Nov 2024
 05:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20241120103943.886802-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20241120103943.886802-1-paul.henrys_ext@softathome.com>
From: "Paul HENRYS d'AUBIGNY" <paul.henrysd@gmail.com>
Date: Wed, 20 Nov 2024 14:03:42 +0100
Message-ID: <CAOTsJ7oYArwpXks9bwMcn3FdGjV0ogRHqAC-2_qF1vqx99j8Cg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch: x86: lib: Add support of legacy 64-bit entry
 point at 0x200
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org
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

Hi Simon, all,

I am really sorry about this automatic footer added by SoftAtHome's mail
server. I complained about it but the legal and IT departments did not
agree to remove it.
I will now send such a patch with my private email address and notify
SoftAtHome of it.
Sorry again for the inconvenience.

Best regards,
Paul HENRYS
PGP fingerprint: 1C45 321A 7830 4DCD 8453 2CE4 DF32 6222 6747 82F7
PGP key: https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0xDF326222674782F=
7


Le mer. 20 nov. 2024 =C3=A0 11:39, Paul HENRYS <paul.henrys_ext@softathome.=
com>
a =C3=A9crit :

> Support of legacy 64-bit entry point was already present when booting a
> bzimage
> with 'zboot' but not supported with 'bootm' when the x86_64 Linux kernel =
is
> embedded in a FIT image.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  arch/x86/lib/bootm.c  | 6 ++++++
>  arch/x86/lib/zimage.c | 1 -
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index 55f581836d..38b4ebf759 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -189,6 +189,12 @@ int boot_linux_kernel(ulong setup_base, ulong entry,
> bool image_64bit)
>                 if (CONFIG_IS_ENABLED(X86_64)) {
>                         typedef void (*h_func)(ulong zero, ulong setup);
>                         h_func func;
> +                       struct setup_header *hdr =3D &(((struct boot_para=
ms
> *)(setup_base))->hdr);
> +
> +                       /* Handle kernel with legacy 64-bit entry point a=
t
> 0x200 */
> +                       if (hdr->xloadflags & XLF_KERNEL_64) {
> +                               entry +=3D 0x200;
> +                       }
>
>                         /* jump to Linux with rdi=3D0, rsi=3Dsetup_base *=
/
>                         func =3D (h_func)entry;
> diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
> index 73a21bc8f0..2eece34a07 100644
> --- a/arch/x86/lib/zimage.c
> +++ b/arch/x86/lib/zimage.c
> @@ -426,7 +426,6 @@ int zboot_go(void)
>         image_64bit =3D false;
>         if (IS_ENABLED(CONFIG_X86_RUN_64BIT) &&
>             (hdr->xloadflags & XLF_KERNEL_64)) {
> -               entry +=3D 0x200;
>                 image_64bit =3D true;
>         }
>
> --
> 2.43.0
>
> -- This message and any attachments herein are, unless otherwise stated,
> confidential, intended solely for the addressees and are SoftAtHome=E2=80=
=99s
> ownership. Any unauthorized use, reproduction or dissemination is
> prohibited unless formaly agreed beforehand by the sender. If you are not
> the intended addressee of this message, please immediately delete it and
> all its attachments from your computer system and notify the sender.
> SoftAtHome reserves the right to monitor all email communications through
> its networks. Any views or opinions presented are solely those of its
> author and do not necessarily represent those of SoftAtHome. The internet
> cannot guarantee the integrity of this message. SoftAtHome not shall be
> liable for the message if altered, changed or falsified. While we take al=
l
> reasonable precautions to ensure that viruses are not transmitted via
> emails, we recommend that you take your own measures to prevent viruses
> from entering your computer system. SoftAtHome is a French Soci=C3=A9t=C3=
=A9 Anonyme
> with a Board of Directors, having a capital of 6 450 699 Euros having its
> registered office located at 9-11 rue du d=C3=A9barcad=C3=A8re =E2=80=93 =
92700 =E2=80=93 Colombes =E2=80=93
> France =E2=80=93 Tel + 33 (0)1 57 66 88 88 =E2=80=93 Fax + 33 (0)1 57 66 =
88 89 - RCS
> Nanterre B 500 440 813 =E2=80=93 Intra-Community VAT: FR 04500440813 -- C=
e message
> et toutes les pi=C3=A8ces jointes qui y sont incluses sont, sauf indicati=
on
> contraire, confidentiels, destin=C3=A9s uniquement aux destinataires et s=
ont la
> propri=C3=A9t=C3=A9 de SoftAtHome. Toute utilisation non autoris=C3=A9e, =
reproduction ou
> diffusion est interdite, sauf accord formel pr=C3=A9alable de l'exp=C3=A9=
diteur. Si
> vous n'=C3=AAtes pas le destinataire pr=C3=A9vu de ce message, veuillez l=
e supprimer
> imm=C3=A9diatement ainsi que toutes ses pi=C3=A8ces jointes de votre syst=
=C3=A8me
> informatique et en informer l'exp=C3=A9diteur. SoftAtHome se r=C3=A9serve=
 le droit de
> surveiller toutes les communications par e-mail via ses r=C3=A9seaux. Les
> opinions exprim=C3=A9es dans ce message sont celles de leur auteur et ne
> repr=C3=A9sentent pas n=C3=A9cessairement celles de SoftAtHome. L=E2=80=
=99Internet ne
> permettant pas d=E2=80=99assurer l=E2=80=99int=C3=A9grit=C3=A9 de ce mess=
age, SoftAtHome d=C3=A9cline
> toute responsabilit=C3=A9 =C3=A0 ce titre, dans l=E2=80=99hypoth=C3=A8se =
o=C3=B9 il aurait =C3=A9t=C3=A9 alt=C3=A9r=C3=A9,
> d=C3=A9form=C3=A9 ou falsifi=C3=A9. Par ailleurs et malgr=C3=A9 toutes le=
s pr=C3=A9cautions prises
> pour =C3=A9viter la pr=C3=A9sence de virus dans nos envois, nous vous rec=
ommandons de
> prendre, de votre c=C3=B4t=C3=A9, les mesures permettant d'assurer la
> non-introduction de virus dans votre syst=C3=A8me informatique. SoftAtHom=
e est
> une Soci=C3=A9t=C3=A9 Anonyme fran=C3=A7aise =C3=A0 Conseil d=E2=80=99Adm=
inistration ayant un capital
> de 6 450 699 euros, dont le si=C3=A8ge social est situ=C3=A9 au 9-11 rue =
du
> d=C3=A9barcad=C3=A8re - 92700 - Colombes - France - Tel + 33 (0)1 57 66 8=
8 88 - Fax +
> 33 (0)1 57 66 88 89 RCS Nanterre B 500 440 813 - TVA intracommunautaire :
> FR 04500440813
>
