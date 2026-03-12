Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3399105A58D
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43031841C2;
	Thu, 12 Mar 2026 13:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VsxnSg6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88450841C8; Thu, 12 Mar 2026 13:08:42 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A910A84121
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-662abedbeb7so1402121a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 05:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773317320; cv=none;
 d=google.com; s=arc-20240605;
 b=ldXa/rQn5Ue3aRxvi/zlbsKPcV/L16W7xeLU9HFN5TYoGh9IpRDwHnJ1l0R0/JuyPQ
 FzSIr1Rg8VXBOPC5YSrYboSLHEZIcd/OkKx23QI1VKN1u1+uHhsY/qHzcNICAsRHiP5f
 JInO2rijhLW0NCVDTn1YOm6U5UF5PDEWY+0vvUnEzMkbNO/GmPmSBO9tUzmQnlHCFCW1
 ZTMor6umkMGhw7dHBmGsHh23Z9+jDg79qCM80xxHQtAEBnrmTE9TeHkgmKk5zfxs8rFT
 /gAfBlbS+QkzyCp8RnIrVcLQF/VNfyt1YFMbSxqtgqWdP91N93pAWylyKpBtPoyW7UaJ
 nYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WBHFtypCZ7rtDKqSwijE+5qMmkgsdId8N+fuKAWekEA=;
 fh=lEnt6i2qrjwBbaSCkrdTcOSYGh/b1tw639piUMO096Y=;
 b=WWYnzguHfimW85BfD/64D7On8ReVCGxnayTuw6Kc3RoZETZwlA93eiWsTK0jDW2Gl3
 puy7XIq9rvyQGhGxWjmmhJWOGj2Q1UNhDGywc/iw9vXz6eWogAyE36uCsAm71vl3CBD+
 RtzTMoUvcOcpZ7SHb81dSV8FFVbfwSCyQ9mcQZ6tMZBZFkL3ZPpi/XiWhlJ2UuY1k1R8
 /hyDM/lxOf2gGETKIN/XYMKLzk6BI+t+ZNlGPuTwmSyx5pvakSgjiAYxZTHFIrkhb1tx
 0ih5OkO9sVctpC3zKFNUiJ/ZAmmufq1t0j9FYDo+0cxHGU1sxoqimRcVR6rwq4xtLekJ
 +zOg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773317320; x=1773922120; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBHFtypCZ7rtDKqSwijE+5qMmkgsdId8N+fuKAWekEA=;
 b=VsxnSg6vmeojAD0048rijtpkwMzJ/FuD07owaJJ74XRObhn3i5uw/nYWgk2jfa67Ij
 lzGN++RexQF07LFRo/Edt7w5hH0/R/2NKgQjgTYHXZ9oAZHB58W5Dt/ZMcjYUCl5Wcsi
 APkUGFPXU0yNfKXC84xY+74NXBNQYCBumqOIKHIxNbPx2D88MWlBtZP62pr287UEHCUq
 RHrIMpldQs34W3Og4wfa2kQopKCKGmvDJyYduAXxmiZLWAt4n5fEZnIWXcSjCGoidW89
 sYHMrIGe34Qgi9bhdxsXux4gr9Aq4XWewW6tj4dzeEdlTad/0wgYsB4sCKJMI8mOq2yq
 qbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773317320; x=1773922120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WBHFtypCZ7rtDKqSwijE+5qMmkgsdId8N+fuKAWekEA=;
 b=OZaABYEgn0x3a3fO4Vxwax7d43eD9zW0VSE/ImHFeU1K/KMLVMF40t9xFnnMOgkjuP
 QT3G7czn1vfn/KVwO1e5/LMDU7sufiH4ROMKGcaMD0KvpQB0LuoYAMbP5/Ut+8bPb8s6
 gkYFWuLPY0DQyw6UE1RHyWoqIwurN6xmzgsknK+SSImSB19TRue1It0V6Mp6JXahc5Hh
 bDOd4bb5MkMKgdrHEf4TAmsNiJlnOVcv2KYMSq7Kq5mZct08BF3CMc9TqxHWuvVju5rC
 mSvw5mHBoGu8onOtelaqT2Jigo9CB7Wj4a76QqFPnEDBrkkw2C7EFE2pZfOC3JQL383A
 DKgA==
X-Gm-Message-State: AOJu0YydeIla/cDDDUoB/+wzxA/PBU/jQzsOTRofId/kln7inxPfoScs
 AoCl9bXflkocB2joQXzT7v8wWNbp16sDpt7ONZ+v6/kT6fWlyZiOXaF/aZbP3d2TUU9532mOXmg
 tLzUy/0Zvx3S1i0cs1/0jfC0TwwmWby5xO/tK
X-Gm-Gg: ATEYQzzd227v7yjmhBBhyrYvqble18gmx14NLQSAldCxLdTEuM4jhpu3tio5illev5R
 G8MtZLzPrNaRdF0STKzSeS84m9cAB1Cg3Bv13QIY4AvkiXttPiMr4nKWQb8EeWZwGaeGW1j17lv
 fgr2NueZvpo7pbYqtXPwkoVnYtoD4zHY83PYrI+40vXXxQVtVA0eof9QnJsIYZqIN8ktXEsc5KM
 FVGEgSWDgF9r6aKgP9RIT5HTJUy8qF6vGPm9om0h4geHXVv41FLTlu4BniOCXOBHE9TESO9eGAy
 vsd9KlcoANga1y4w3dVqP9Re0KMISLbEwi4u1cVx8UQYj7sRvWRs1w510mKs6Hm0UbxtSmOJOMu
 9PGzqzCptQ2YrOab/mO0Q0NO4Igt7/Q3xlbYruSQvVWB5HGwPUoDmVBhjU1NHutNGfBjRSQTL0Y
 Z78hPcN/I4YTw=
X-Received: by 2002:a05:6402:1468:b0:660:af39:2ced with SMTP id
 4fb4d7f45d1cf-663189c4f40mr3664359a12.0.1773317319787; Thu, 12 Mar 2026
 05:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260216184452.18732-1-filip.kokosinski@gmail.com>
 <20260216184452.18732-3-filip.kokosinski@gmail.com>
In-Reply-To: <20260216184452.18732-3-filip.kokosinski@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 12 Mar 2026 12:08:28 +0000
X-Gm-Features: AaiRm53fFgWaWGUdI6OPgdNV_xm7noYavvjuqs9AzAS8bqi2aJ0bpS4Bh85eqvU
Message-ID: <CALeDE9NqefkSCyHs6XNmc=voFUOOR8Vs+9=tCzUPL+bL3uSQzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] board/raspberrypi: add bcm2712d0-rpi-5-b for
 Raspberry Pi 5
To: =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com
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

On Mon, 16 Feb 2026 at 18:45, Filip Kokosi=C5=84ski
<filip.kokosinski@gmail.com> wrote:
>
> This commit adds an FDT entry for the d0 stepping of the BCM2712 SoC.
> This entry is used by the v1.1 revision of the board
> (revision & 0x0f =3D=3D 1).
>
> Signed-off-by: Filip Kokosi=C5=84ski <filip.kokosinski@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>  board/raspberrypi/rpi/rpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 1b404b448f3..3d61d08f3a4 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -197,7 +197,10 @@ static const struct rpi_model rpi_models_new_scheme[=
] =3D {
>         },
>         [0x17] =3D {
>                 "5 Model B",
> -               FDTFILES(DTB_DIR "bcm2712-rpi-5-b.dtb"),
> +               FDTFILES(
> +                       [0] =3D DTB_DIR "bcm2712-rpi-5-b.dtb",
> +                       [1] =3D DTB_DIR "bcm2712d0-rpi-5-b.dtb"
> +               ),
>                 true,
>         },
>         [0x18] =3D {
> --
> 2.51.2
>
