Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BA1D63935
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080A789353;
	Wed, 20 Nov 2024 13:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QTj++zbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3039894F9; Wed, 20 Nov 2024 13:49:41 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7AF89347
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 13:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso706539966b.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 04:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732106979; x=1732711779; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10n2cCo6r+gD8FdMHFnNLxdOyn/onJobyn4qqjn6CYs=;
 b=QTj++zbqfEhpyl9gNLuPXk5s+o3ehPjUeZ1WYDcb3z52hHPueiIiyU9kGedA0g1YKz
 9T3wwtMZ7rGPi0GQR4nC8OTb1XovqmEBmsz9xaPe4TqtP0TPTatmDt2dybqTi+tUz3fo
 74Xj4nd6ptOkRnZSvVWCywKxx9rfehCCqXoSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732106979; x=1732711779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10n2cCo6r+gD8FdMHFnNLxdOyn/onJobyn4qqjn6CYs=;
 b=LxqFA9NoZDn6If+Jia1U70uv6WuIJ7fDQsVXM4/kHBw+5gbNS6zwu0Oy7Z70BIK6BD
 +AICnszA0y8wDaxViIpzpm8hz5kwNC1C4Oz22b20Cv93KzqRY7oV/SFUG45G32+wGF0p
 Y64AV463pfqUEmmOUJiK3qMeEQG9YFp2iMCN4eiFWOD9vOaCbS5j4knjlcwWFU+hDag8
 sUirb/GAwVQml0AEIQF2A38GG+zKrVRAZ3g3+BveM6XTrQXQtrK1rf6i3Mruc+OTw5Va
 2qncKrxTNpWq4jNNFRTs103p/iI7bU/P09gK3uqPqd3SQBNPN1o/ymSa0C2FN8QZxJjG
 GU7Q==
X-Gm-Message-State: AOJu0YzP49G6gqHraO+UeDifD02jT8+dBUNvsTA6bbDWQNuwOR7UgQZO
 sFc1sg/ykOrnRcKeISZoRETvLdtZyoCuqTOXjsUNtjNZT/kqoBX7GduqbUd94ZG1YwpuqZW7Euy
 H39V71ZJu7sE6fzuBY1qIvd/B3+pjROqHVOm/
X-Google-Smtp-Source: AGHT+IG8hqy9Yfb6Ou1pnqgFD2oOKnK7c2uTMAJoxJisHGWaEt+E9zqlZJFQUr2exZ/dcr0kzkD2aQB/mthNWY5bN00=
X-Received: by 2002:a17:907:3f9b:b0:a9a:19c8:740c with SMTP id
 a640c23a62f3a-aa4dd70b6f2mr237437566b.47.1732106979263; Wed, 20 Nov 2024
 04:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20241120103943.886802-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20241120103943.886802-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 05:49:27 -0700
Message-ID: <CAFLszTh4Dr2x=6XWBuXEXcg1CkB+0OyvpkYUknLgYNfyKgG2MA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch: x86: lib: Add support of legacy 64-bit entry
 point at 0x200
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd@gmail.com
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

On Wed, 20 Nov 2024 at 03:39, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Support of legacy 64-bit entry point was already present when booting a b=
zimage
> with 'zboot' but not supported with 'bootm' when the x86_64 Linux kernel =
is
> embedded in a FIT image.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  arch/x86/lib/bootm.c  | 6 ++++++
>  arch/x86/lib/zimage.c | 1 -
>  2 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index 55f581836d..38b4ebf759 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -189,6 +189,12 @@ int boot_linux_kernel(ulong setup_base, ulong entry,=
 bool image_64bit)
>                 if (CONFIG_IS_ENABLED(X86_64)) {
>                         typedef void (*h_func)(ulong zero, ulong setup);
>                         h_func func;
> +                       struct setup_header *hdr =3D &(((struct boot_para=
ms *)(setup_base))->hdr);
> +
> +                       /* Handle kernel with legacy 64-bit entry point a=
t 0x200 */
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
> -- This message and any attachments herein are, unless otherwise stated, =
confidential, intended solely for the addressees and are SoftAtHome=E2=80=
=99s ownership. Any unauthorized use, reproduction or dissemination is proh=
ibited unless formaly agreed beforehand by the sender. If you are not the i=
ntended addressee of this message, please immediately delete it and all its=
 attachments from your computer system and notify the sender. SoftAtHome re=
serves the right to monitor all email communications through its networks. =
Any views or opinions presented are solely those of its author and do not n=
ecessarily represent those of SoftAtHome. The internet cannot guarantee the=
 integrity of this message. SoftAtHome not shall be liable for the message =
if altered, changed or falsified. While we take all reasonable precautions =
to ensure that viruses are not transmitted via emails, we recommend that yo=
u take your own measures to prevent viruses from entering your computer sys=
tem. SoftAtHome is a French Soci=C3=A9t=C3=A9 Anonyme with a Board of Direc=
tors, having a capital of 6 450 699 Euros having its registered office loca=
ted at 9-11 rue du d=C3=A9barcad=C3=A8re =E2=80=93 92700 =E2=80=93 Colombes=
 =E2=80=93 France =E2=80=93 Tel + 33 (0)1 57 66 88 88 =E2=80=93 Fax + 33 (0=
)1 57 66 88 89 - RCS Nanterre B 500 440 813 =E2=80=93 Intra-Community VAT: =
FR 04500440813 -- Ce message et toutes les pi=C3=A8ces jointes qui y sont i=
ncluses sont, sauf indication contraire, confidentiels, destin=C3=A9s uniqu=
ement aux destinataires et sont la propri=C3=A9t=C3=A9 de SoftAtHome. Toute=
 utilisation non autoris=C3=A9e, reproduction ou diffusion est interdite, s=
auf accord formel pr=C3=A9alable de l'exp=C3=A9diteur. Si vous n'=C3=AAtes =
pas le destinataire pr=C3=A9vu de ce message, veuillez le supprimer imm=C3=
=A9diatement ainsi que toutes ses pi=C3=A8ces jointes de votre syst=C3=A8me=
 informatique et en informer l'exp=C3=A9diteur. SoftAtHome se r=C3=A9serve =
le droit de surveiller toutes les communications par e-mail via ses r=C3=A9=
seaux. Les opinions exprim=C3=A9es dans ce message sont celles de leur aute=
ur et ne repr=C3=A9sentent pas n=C3=A9cessairement celles de SoftAtHome. L=
=E2=80=99Internet ne permettant pas d=E2=80=99assurer l=E2=80=99int=C3=A9gr=
it=C3=A9 de ce message, SoftAtHome d=C3=A9cline toute responsabilit=C3=A9 =
=C3=A0 ce titre, dans l=E2=80=99hypoth=C3=A8se o=C3=B9 il aurait =C3=A9t=C3=
=A9 alt=C3=A9r=C3=A9, d=C3=A9form=C3=A9 ou falsifi=C3=A9. Par ailleurs et m=
algr=C3=A9 toutes les pr=C3=A9cautions prises pour =C3=A9viter la pr=C3=A9s=
ence de virus dans nos envois, nous vous recommandons de prendre, de votre =
c=C3=B4t=C3=A9, les mesures permettant d'assurer la non-introduction de vir=
us dans votre syst=C3=A8me informatique. SoftAtHome est une Soci=C3=A9t=C3=
=A9 Anonyme fran=C3=A7aise =C3=A0 Conseil d=E2=80=99Administration ayant un=
 capital de 6 450 699 euros, dont le si=C3=A8ge social est situ=C3=A9 au 9-=
11 rue du d=C3=A9barcad=C3=A8re - 92700 - Colombes - France - Tel + 33 (0)1=
 57 66 88 88 - Fax + 33 (0)1 57 66 88 89 RCS Nanterre B 500 440 813 - TVA i=
ntracommunautaire : FR 04500440813

Can you please drop this when using the mailing list?

Regards,
Simon
