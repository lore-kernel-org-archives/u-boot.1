Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BABCC369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 12:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB46A8210A;
	Sat, 19 Apr 2025 14:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jq+BlCsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71967828BC; Sat, 19 Apr 2025 14:59:22 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A63C82105
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 14:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so2085693a91.1
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745067558; x=1745672358; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJOeOP9Gn7ggjULlUoWNZDoRsCpkN4RGKdjoiOEq918=;
 b=Jq+BlCsNvXa3DDSwjJFu+0Vrm5cbKIowat5dQb3ZMv6m1W4SpfUDARhYqRf3Yf5/LZ
 L4rHpHJUlSUp9kKceiPo+Dzg6yJj1OgOSwSVTSWEt7izOyGRne/70xUCVFNhXmspzutp
 jkRVyl0HhZVcZKzKxok8Hcd+rXP1cDqGC0lliWhP5pr6g3vwSwIix8SeWX1yRSpjwcl7
 igs47pqZp0a+LTnQ15RZDK7JnollOORjxMkgeje9E+TJ8wZ4yLq6OA1E0luXnmvTUuvO
 +PvepgIR3DzAzGrtDPtic6jEqdVu1IIoMMjYfs/e2/F04DZ3qyzFIWKfl0Nmbd2NJNRZ
 QMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745067558; x=1745672358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJOeOP9Gn7ggjULlUoWNZDoRsCpkN4RGKdjoiOEq918=;
 b=WUDawqGRxzp1iGYi3yCfi8eSrch6+WNOuxwUP4RFIHqQN57ucarT+7AvgC54OgOSIn
 5x6HI6I128DphgDlvxpzkfAfrKZmYfcakdS92P7b9+DPsmyeo6X9E2syHnPQw926ppxz
 yhTAi6yLjGmQNyLV6vqrdmHYbcSiT65RDJXJYkrtrWrMHCRHlNbWvvioA9CKKPRcS+jm
 wtzSPe8pjSMlwEnNLhdZsANIqi0VoTXI2LAdiWwsQekjnIKdduGTy7cps/hgrTBkwwh8
 MiUtDuG6Bt8ZFoVZt+17hqaK+B1efKOMHq5z3WaLTigCOs1lwuldte2XeJxuyW14vhtA
 pg1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhBo2VsxDa1GES/Uavbk+IHgc3oj4oAPztpP6paCiD0g9oHxCG4TwwrXB8m1FzMNi8qc2DSzI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyo8g8Wop7QEkwMFdj/4zBr7tLX9hKT5lR3kjmeFc/zW7fYQVAi
 cgbCq2REaQBim7F+4kH1HbphskaUDxTifH/OgjBIwBNyZ2yyTan/RMecTERu61S7Dc6Uu1jxkkr
 ppOWtHPZFF2HljsGuBSyp70xHBpI=
X-Gm-Gg: ASbGncsrGuOUMoZqyO9iSKBWLZBsQeOg6FDSyG0ZKm6/LvMJP6tznxn7vOxnY7M7OoR
 hX6ieFMT6caPLqz9QLTi4i4ZJbaZPJb0x5dC/+XVPp19rLtisIT5/EzIr4+679OVr48ypL66snW
 SIFWIEIFlQRp4ISNwzruCN4g==
X-Google-Smtp-Source: AGHT+IEcjNynJ1zjvt8yuNYk3NAJqILes3v1AhlugSkTSxP3SzBipKAw35tjHtFIVknCu90A3RndXt9H7/u8dkmxjAY=
X-Received: by 2002:a17:90b:2588:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-3087c2a5c11mr7727722a91.2.1745067558296; Sat, 19 Apr 2025
 05:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
In-Reply-To: <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 19 Apr 2025 07:59:07 -0500
X-Gm-Features: ATxdqUGGTjllGHgdlqm42V0PACjJc4w1gEoWTWMTMqDCrf2qiL6Wo-EwZcgYg0o
Message-ID: <CAHCN7xKGOmbj_NAV_XLhdyFX09i7Z_WMgZ-YDhyG3z2N3yF3cA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com, lukma@denx.de, 
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Fri, Apr 18, 2025 at 9:53=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/17/25 7:11 PM, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@denx.de>
> >
> > Currently, fixed-rate clocks in U-Boot are named based on their devicet=
ree
> > node names. For example, given the following node:
> >
> > osc_24m: clock-osc-24m {
> >       compatible =3D "fixed-clock";
> >       #clock-cells =3D <0>;
> >       clock-frequency =3D <24000000>;
> >       clock-output-names =3D "osc_24m";
> > };
> >
> > U-Boot registers the clock as "clock-osc-24m", derived from the node na=
me,
> > ignoring the clock-output-names property.
> >
> > This differs from Linux, which uses the clock-output-names property whe=
n
> > assigning clock names. As a result, clock consumers expecting names
> > like "osc_24m" (as defined in the property) may fail to resolve clocks
> > correctly in U-Boot.
> >
> > Update the fixed-rate clock driver to check for the clock-output-names
> > property and use it as the clock name if present. If not, the fallback
> > remains the node name. This makes U-Boot behavior consistent with Linux=
.
>
> This part above ^ is fine.
>
> This part below v is wrong .
>
> > One concrete impact is on i.MX8MP, where USB clock lookup failed follow=
ing
> > commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*").
> >
> > With this change applied, fixed-clocks are correctly registered with th=
eir
> > expected names:
> >
> > u-boot=3D> clk dump
> >   Rate               Usecnt      Name
> > ------------------------------------------
> >   32768                0        |-- osc_32k
> >   24000000             5        |-- osc_24m
> >
> > This change restores i.MX8MP USB functionality by ensuring the proper c=
lock
> > names are used.
>
> This is wrong, because this is NOT how the clock look up works at all.
>
> The lookup works this way. Take for example:
>
> drivers/clk/imx/clk-imx8mp.c
>
> 240         clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux(dev,
> "arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels,
> ARRAY_SIZE(pll_ref_sels)));
>
> pll_ref_sels:
>
>   21 static const char * const pll_ref_sels[] =3D { "osc_24m", "dummy",
> "dummy", "dummy", };
>
> the "osc_24m" is looked up in the clock-controller@30380000 clock-names
> property:
>
> dts/upstream/src/arm64/freescale/imx8mp.dtsi
>
>   745 clk: clock-controller@30380000 {
> ...
>   751         clocks =3D <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>=
,
>   752                  <&clk_ext3>, <&clk_ext4>;
>   753         clock-names =3D "osc_32k", "osc_24m", ...
>                                         ^^^^^^^
>
> The offset of osc_24m in that clock-names property is 1 , so the phandle
> in clocks property array at offset 1 is used to look up those clock:
>
>   745 clk: clock-controller@30380000 {
> ...
>   751         clocks =3D <&osc_32k>, <&osc_24m>,
>                                     ^^^^^^^^
>
> Which leads to this clock node in DT:
>
>   188         osc_24m: clock-osc-24m {
>               ^^^^^^^^
>   189                 compatible =3D "fixed-clock";
>   190                 #clock-cells =3D <0>;
>
> The "clock-output-names" is NEVER used for any clock look up.

For what it's worth, I remove the "clock-out-names" from the device
tree in Linux, and the Linux driver properly coped with it, but I am
curious to know what the point of this entry is.
>
> ...
>
> I am fine with the first half of the description, but the second half is
> wrong and this actually does not fix anything. Simply remove
> clock-output-names from the osc_24m and the code will be broken again.
>
> The clk_resolve_parent_clk() is meant to perform the aforementioned
> resolution(), that is what "[PATCH v2 00/24] clk: Add
> clk_resolve_parent_clk() and fix up iMX clock drivers" actually fixed.
> It seems there is something still missing and clk_resolve_parent_clk()
> does not do the resolution properly for some clock, but that is what
> needs to be understood and fixed, not worked around this way.

I added some debug code to clk_resolve_parent_clk it does return
osc_24m as the name of the clock, but when searching for index, it
appears to fail. Do you have any suggestion on how searching for the
index can query up the chain to the parent CCM driver on how to return
the reference to proper clock?  The clock-names property is at the CCM
parent and not inside the children, and the number of levels vary
depending on the child clocks, you can't assume the parent's parent
has the 'clock-name's property.

adam
