Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72FED74EDE
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 15:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F0E983B0B;
	Fri, 23 Jan 2026 16:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LjtH1zpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26ED983B21; Fri, 23 Jan 2026 16:45:16 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D3383B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 16:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-382fd8aaa6eso19720391fa.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:45:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769183113; cv=none;
 d=google.com; s=arc-20240605;
 b=X0zKJJA3vKSK0+utp7tBf7YOWulfHZs1CaEKHPAMDzk03ldPRRy9BbsBA1D7xtTZw2
 nzTFq2SDayDBtbHjZVE6+n6jzNwJoK/IkP+LAhlhVlysUt6HyRqJUW8xeQDoB/6jk8pb
 eQJWIuxg5VemGWYVH9Y21OanLGZvm6s2/fa+mHf2ZhcmMCHXkw/6j/9KnKNpO1/JqQsw
 kJhVXdl4gD6ULQVOI3TGqLZynRMK5mgtGdVSLf9gZ2VrRDywgg0XxHZ6l6HxWIOWa6sb
 3umHmsu3bwaLte606WPa7qGEWmcB7M4pzz2uIT2dGqmccCLnZBr/xPJSFFC5+DfMz6CS
 mSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CzoAyz4tftc7Q04gsXKRTE5rBdV/7+yVBXN2i0XDE/0=;
 fh=HRwMAjXa605J2lgdya1MQw7whSqYwGHiQZV30T4AHSQ=;
 b=Nr/2GdWlXCI+ixFKFr/5Ew2FFhN1KJrjXtm3GIKzl65x4yO49V55+Bk4xFnZAAGW6Y
 xYpoEnpx9SPSefQr1bQt3the5jKk4jyRg2nIu1/MlWgNlR4dQLwOE/LQkuQlxDxaQGuG
 p3notyGvBuM2ldjzul+7oF3ryqZ1VETXKYd7DAN02wYks0MnVipKwJh9iOCSKti8tXvB
 dTTztSA96eKYAUpVjZBkF1SmX/zEepjzKrSYRIdTL5Oi4BvEI7HdrRDIR7fzOzGvHcW4
 a7rWFeKr0wBUHgkc41PtIeUJfEcZb7Mo7Yhpk4KOJ4s+RjRJnZNU1PqmTuCB9/cKbTJg
 Tqzg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769183113; x=1769787913; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzoAyz4tftc7Q04gsXKRTE5rBdV/7+yVBXN2i0XDE/0=;
 b=LjtH1zpSUE+pgecqkBEVaH3moVwMxNyvnE/9LhhqLqksltPuiLGefoSmQOMwV0cGFT
 9vf7I0lOt4PYXQ4bxly0+lgkVPzrd21vOXlK7FUGHdzvT6HcqgFnZxBmO7U+Sufoc8bg
 C+sAULatG3J0xQJxJf+1lBP4LoInsq5MODeWxk9qVyk5fCdiSUQQO9BLaHB+ZgWqTaO2
 vXe6lYWoY6YagAiPLNqSWR1YHpJUcfAKTYtyC8W5mIkZwyfahIBdTghb7Ns7w7vvAbFX
 LBtppeVrtEMVmwKtKzOeb3b+/mOzZOtepfW2wKbenFt/12q6zJDWtj8mop5Ir9M6FTBm
 LoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769183113; x=1769787913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CzoAyz4tftc7Q04gsXKRTE5rBdV/7+yVBXN2i0XDE/0=;
 b=dJGuAZpVnHedKYCk5BulVo6fLaeo2fT8NLH7mfB4T3A0wTBbkVBb0vSuQc9tntruSw
 iPIVWC0OfmARvKnbQf1g5BMmCaSUiwqTi6si3vz1ldGNbdZHO3+piuhS5Xaz/8DAfLl4
 Tzpgxo7ATfVQVDVCUZ7C0sHP/JufPu4kFbLQ3LKxcFdFNoFL2og0o3INrMnxdJ7o76QV
 ghvfiC3MECq5TT26S7ufXv2uPh3wzLbyrHqPo370GKC58dkbWZc5BiGIP1XDRYlME/oh
 FbeprCYkKN31v4jiAPgUrYQvJthxJkbMVUyrgSLGlWq49EwcReBKBvWwL0j62rUv56/j
 I3QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqkKaAAPj7bnhDXEkM3sgH+/QpzDdo7vBlJbLJpRVmtUOmCS70TihTiTzkfTgt97GQGC+0M7A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+nPRMEGE+0VXRGw1O57UFEyer6v9ynfKR1icEZswiI14f1Q9C
 GuL9GO7MawL/EcZSrmScecnLSOHmILc/Ih5I9c2PwQCN79jAkdOmbKUNcCZOPAj6VSxcrqs1unJ
 uZUOOTYUVcelCtSNsuwUfevDDeOwJXzg=
X-Gm-Gg: AZuq6aINlfJGAMRQrVmGHnLNsGLd/XWaiH4IXkVv8qDKtCwDp4DFNCA5Uy9cTmk3Xsi
 ioem/r6E83EVkiK68MDWpIyFN4691AnvXzSnKqLt625YU+xXeRFqOpYTF7uFbxjCK9/9zRbOQuO
 j+r9waPXfuKCn7KNthDJd9AOlXG2uorFYR782c76U00vsK/PrIQ3zywoW2IRFxilDij3xjHnaJK
 i4LDmiKdevUZ2lvAY8W+uAfXlBWXG6CAe/z5G7Sh/x3P0MSkswwxjCK7qS3uqtMNhyofgB/DG8X
 lrnp2ld8G/kKJstaficEPoYlig==
X-Received: by 2002:a2e:a4da:0:b0:385:b57a:53fc with SMTP id
 38308e7fff4ca-385d9f950f4mr8820021fa.22.1769183112898; Fri, 23 Jan 2026
 07:45:12 -0800 (PST)
MIME-Version: 1.0
References: <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
 <20260122194239.GF3416603@bill-the-cat>
 <CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com>
 <20260122232407.GG3416603@bill-the-cat>
 <CAOMZO5ADFCbzyv3whDo_w=hEwe9i1hhMZ-X+UEu8132pkFnqJg@mail.gmail.com>
 <CAOMZO5CLQZ3i+Eit5csv6E+az-_g2eOHfCr-whQTPeg06WtqEg@mail.gmail.com>
 <20260123142708.GH3416603@bill-the-cat>
In-Reply-To: <20260123142708.GH3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Jan 2026 12:45:01 -0300
X-Gm-Features: AZwV_QjxhQJt9J1dZDxJtgZmNpCXz6i2_365iFwPTNu9iFVGobG9cH4VGGbufms
Message-ID: <CAOMZO5CoN-6UVuX8GsmfQHHPs1N=29t4khWOEaeJCN-RjyQynw@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

On Fri, Jan 23, 2026 at 11:27=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:

> So this:
>
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index d780a5060774..dcc201c30482 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -50,8 +50,8 @@ SECTIONS
>         .rel.dyn : {
>                 __rel_dyn_start =3D .;
>                 *(.rel*)
> -               __rel_dyn_end =3D .;
>                 . =3D ALIGN(8);
> +               __rel_dyn_end =3D .;
>         }
>
>         _image_binary_end =3D .;
>
> Will shift the dtb location lower and __rel_dyn_end 4 bytes higher.
> Which is probably fine.

This change fixes rv1126, but still fails on rv1103:

sonoff-ihost-rv1126_defconfig:

$ cat spl/u-boot-spl.map | grep __bss_end
                0x000000000000b468                __bss_end =3D .
                0x0000000000000050                __bss_size =3D
(__bss_end - __bss_start)

$ hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
000016d0  af 98 00 00 15 15 00 00  d0 0d fe ed 4e 99 00 00  |............N.=
..|
00001d20  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG....=
..|
0000b460  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 0d 95  |..............=
..|

dtb is correctly found at 0xb468.

omega4-rv1103_defconfig:

$ cat spl/u-boot-spl.map | grep __bss_end
                0x0000000000015f18                __bss_end =3D .
                0x0000000000000264                __bss_size =3D
(__bss_end - __bss_start)

$ hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
000029f0  d0 0d fe ed 00 29 05 db  8a 18 03 d2 43 6a 1b ba  |.....)......Cj=
..|
00015f10  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |..............=
..|

dtb is not found at 0x15f18.
