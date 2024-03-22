Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57076C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5FE8816F;
	Fri, 22 Mar 2024 11:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="idOvmQ5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B92087F33; Fri, 22 Mar 2024 11:22:51 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5635488126
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-60a046c5262so18413977b3.2
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1711102966; x=1711707766;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=feOKAlwg4spEnPXx8DUiE66ftV3gIahI9bCdKaSf6S0=;
 b=idOvmQ5OqQooxl/wsOXFGGHw87zZTIoE2QcB0cmORP9yGcd66MMzdM8+ICP73EbUeP
 6lCI3EAh5zOLBLjnAgi0wpgAzQSG+n5DJAzu7ZEGEqN/ImAE90ZfoOt4wEqItzQaIRoZ
 w0+hcf/83KUq9XraLPQN0ckHmOMyPof/enW3KCQzkNFBJzyuBNGQ35rm0OLJq1ADbyW0
 rJugFWFfEkRcTuPjhV76AGusIRhk4ezMya7KSnv4sD0wNcJ6tYR3ErSl3hc3cSykvlOV
 gRszJLonPfwL6YobNClOtPBz1Lcrxqr1e0Ez2WLgvv4Gnv9twGrj7/x8Jj9GBIRWt7cB
 yLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711102966; x=1711707766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=feOKAlwg4spEnPXx8DUiE66ftV3gIahI9bCdKaSf6S0=;
 b=l21PAOrbmijcis6NTrZCsccvnT1fyXd+a227gHT/A8mkfr5n1KIGltQNm51Ue4cXEe
 y96lU9oOGdaPAgKrg/NsP1VKSr86Kx/9pJCD+5V2xEtpw99H/wyVJsqbCsOIahgI2LF8
 NQFg1M4pBiiPG1m6PcjVglis0ZHgyhQo+DKJhDYrR0kUUiyDa3lKYle/0iLzY8s9RZcK
 a8ThjsJ00x5iN4JLSKrVQ0KPxbF/vgLU4SHIxOPhgkJ8hGGOxtaI2Tn7vNoh4AjkZIq3
 Mbe87Wuix+6h1IK6cCatE8KoQn5hPdHvSw/p0ItM9n8zRG4XspnnUsxylowsTsu9lbFt
 jahg==
X-Gm-Message-State: AOJu0YybFq//TPSSfsui2st13Y/td1B5Xg0ospqmi6aIA+IEu5GjjmbV
 NyiQMm70Wa1kcDMeNNeT2swH/CiE8qwQDz1bffBCO674E0CTGI3Rx3MSsFphSblr7JuS3DLSCFV
 F3pXku/bu2Kguxd30ZzM9tbKqrHvv/xMQs9QB
X-Google-Smtp-Source: AGHT+IEHqKfuqEADcV490I9iUJXm1QzDMsd4jU34Sy2OZWZ/xRiOddy66GRx6p423o9wuco8L0xGfMJxKd6R79QsLP4=
X-Received: by 2002:a25:b82:0:b0:dd0:aa2c:4da5 with SMTP id
 124-20020a250b82000000b00dd0aa2c4da5mr1519407ybl.6.1711102966089; Fri, 22 Mar
 2024 03:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230822031705.1340941-1-sjg@chromium.org>
 <20230822031705.1340941-6-sjg@chromium.org>
In-Reply-To: <20230822031705.1340941-6-sjg@chromium.org>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 22 Mar 2024 11:22:34 +0100
Message-ID: <CAHTX3d+qAMKgL9T5Fo6y=rvXDiMS_mCiCEGazHt07eiVN32Fgw@mail.gmail.com>
Subject: Re: [PATCH 05/14] initcall: Adjust the failure message and return
 value
To: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>
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

Hi Simon,

=C3=BAt 22. 8. 2023 v 5:18 odes=C3=ADlatel Simon Glass <sjg@chromium.org> n=
apsal:

> Move the failure message outside the loop, so it is easier to follow the
> code. Avoid swallowing the error code - just pass it along.
>
> Drop the initcall-list address from the output. This is confusing since
> we show two addresses. Really it is only the function address which is
> useful, since it can be looked up in the map, e.g. with:
>
>    grep -A1 -B1 serial_init u-boot.map
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  lib/initcall.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/lib/initcall.c b/lib/initcall.c
> index 81c5d2450735..0f74cef32f85 100644
> --- a/lib/initcall.c
> +++ b/lib/initcall.c
> @@ -46,11 +46,13 @@ int initcall_run_list(const init_fnc_t init_sequence[=
])
>                 }
>
>                 ret =3D func();
> -               if (ret) {
> -                       printf("initcall sequence %p failed at call %p
> (err=3D%d)\n",
> -                              init_sequence, (char *)func - reloc_ofs,
> ret);
> -                       return -1;
> -               }
> +       }
> +
> +       if (ret) {
> +               printf("initcall failed at call %p (err=3D%dE)\n",
> +                      (char *)func - reloc_ofs, ret);
> +
> +               return ret;
>         }
>
>         return 0;
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
>
I am debugging one issue and I get output like this. And I dig into it and
find out that failures are not reported
on the function which is causing it but on the next one. It is because of
pointer is moved to next function;

This is what I see.
initcall: 0000000008072de8, 0
initcall failed at call 000000000802b14c (err=3D-19)

And this is the problematic part.
for (ptr =3D init_sequence; func =3D *ptr, !ret && func; ptr++) {

Fix should be of course to get that if(ret) code back but maybe you want to
see different solution.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
