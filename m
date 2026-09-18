Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E73C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 19:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4FED60E83;
	Fri, 18 Sep 2026 19:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1P0rOGMQQ6NB; Fri, 18 Sep 2026 19:42:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0000760D86
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789760548;
	b=e3u12qVzOVqvlt6Zz6atM2SWOx7WzyO/RgZsR0T/+TXmxqHqnn5KtyKXPJaH5R/tQUxX
	 P9OaYzi2VT8CHNGpfZlzZUuMD2Y7BZxfNKLfmvS3Uq/wMj4ezDyIQSMs/W7w3gbycXh3+
	 GyN6HTbOfAblVftCSBX75U4MV2dddOgV8ayzT2eEfqxDX6Zemkk8AxSmWJ/3+9/zyXvBT
	 t08OV8yFIGC91SkYAI0nbGn+AMaiyXju9f6PYgtjwcwRzyF8RGLTfx7ynQ1DT2HTXXJuR
	 Fd72VSOsT7hNGFrXuAGu+KJQUZTRnLReBuGsEnPnuheTQhCyyMOcM4WFKG5Sgo9CeyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789760548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mV7cTrmLlasmsDbvmMGQ7eysJWaZCIw96LDfciBvS+M=;
	b=A9alfd5bgXJKOd8qdkQ++lte9DXYYNPRlFwbNJ0F9PDKg65qn5L5sjZ852lhZTZSZTPj
	 tZS6QLKh2RXqQ4i4M4gfKF/k209CBqO0MwXqAxbPJkLKMNifNBiamnVuvQnZRFigPb6yJ
	 5IopbRqfA/icwXCG86aesw/DQImbn3owj5ffg2advfK02LW4zKyhOBZ/hQowU9Mkd54eq
	 lo/3BfyHGowfa9OguSMhUjVedspU7Vih1rbrnRCIqA2W6QjUNrDiWGsGw6k0BUxh+C4J3
	 /qboqzddEZwnfpXecH9C+wIJ5lloZVele8GUDYIAVPJGGw+odxUQDp8FFLeZ7oTMy6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789760548;
	bh=mV7cTrmLlasmsDbvmMGQ7eysJWaZCIw96LDfciBvS+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KIAFzuWyK6F5nXexrrwHIf1L39lh2jd+w7ALxlBO1mYwP1tKwqGyah8Z7YZy6Ch5a
	 F5gBVYD8BjJ762i/vMzzR231sNWe8hRsQnVxpDBx0U6DiYqdhg7Swn3csEoOM2JL1l
	 oNYuI17ErTMLgk0QEKu7HkHCo4cncI8xdBjkIEEQ+XTkNcLsr0u5u/YjQOqXnu9u37
	 JH/vh3WjHzowVKznkpLf7UiONjGeWhIRwiRRMP2qx4fGJDEdJ5HuCJuLNtEC7BEYYC
	 l1oqYDwc+HMSbZNKAmb/GOmB778L3M0baSHIHmmdD4389Xei4IGBWhFad9102ZHyOe
	 XzyugQ2S25JSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0000760D86;
	Fri, 18 Sep 2026 19:42:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E2ED25B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 19:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 000E280E28
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 19:42:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i_5JLLpLZc87 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 19:42:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1F7CF80D98
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789760546;
 b=f+3XwaYtSZnIZwU8DGWfF+MWNi73Hw68rov/cms5UGE3/48oD7cZnuUeWlyPglhT3FD4
 Hos4iK5pY4z/sUc9xYLSHWaziaIPlaF3IeecImXFpEGP+8B1JupqhBdIvoHeOFhkmlQzU
 HWca9Y1kgkv4RvHtlOiK8epI+ss6LPq2rHBCT399Zeobzcmevf0fckcD5pV1476SUhygw
 iLMAByfVtUBGqBbyLzfoQI0jwQw5hKymu+lVRbAlq/BRLpWGfKo/0XzPL9y6HlFwmZ+U/
 VeShkTv7e94UZ1YJloMDcEk0Ozn9TRkBQvA7+ty4OcPZPrjng610M3pQKnh/qyI3ZkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789760546;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=mV7cTrmLlasmsDbvmMGQ7eysJWaZCIw96LDfciBvS+M=;
 b=EJ2lAjbMJ9RgV12O4Elj10VSuTDKNb30h4RuJW67ig4aN47M6TW9f1uVJkzPKXRTIEvr
 kYhEOuTs46Y8296EsSSRnInpHjOJa1zoFKrXJKrsf8bY4KMdrezAm+b8jAOBmFIzaUQim
 odYnxo8FMyvzaoM+SX3fvrTR03PzPs0SvDHKII55MEVwK3k/IMGeBKYDk7YqUXW5BJyEX
 sc4ihpejjjqOBUWbdLJlaOJv8k5Jd2OL2c5ui7CUtKxHt3UafRV9u7LHykvcWMDUn7EK/
 PXAfBSjEG4xu438772sQVpkznpQlnXD+e1cGt9Nn7gN9mfyZEiT6Yk1ueJYc5PUQGWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=o+Wv3rkZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::f;
 helo=mail-oi2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=o+Wv3rkZ
Received: from mail-oi2-x0f.google.com (mail-oi2-x0f.google.com
 [IPv6:2607:f8b0:4864:32::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F7CF80D98
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 19:42:25 +0000 (UTC)
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-80032c08611so746665a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789760545; x=1790365345;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mV7cTrmLlasmsDbvmMGQ7eysJWaZCIw96LDfciBvS+M=;
 b=o+Wv3rkZW+YFxPSa02f7lb61xX6wYjUWykjMIYQrHXHTKnV6cumcFy7sWQWc/XyuYs
 jNifDjzcClUS3FUMnzRvgvnZ0k7ptqmm2ZDutGHnPTOifhys7pjZw1A8pnr6Mn8gogpg
 tCo07DqqO3WCWJRvs0ZrbI20TXeDrMfx5heMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789760545; x=1790365345;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mV7cTrmLlasmsDbvmMGQ7eysJWaZCIw96LDfciBvS+M=;
 b=wgbJyaNyAhpBO9fyPPmqntY3H+aH2EclDPzQGmwHHS8R1bX+o0t7n12YioRYunY7ZT
 0qEa6AXPAl0v0SqclFkn4ZoOmGE5IyWW88bUEKHVs7VzOkQrr0qv8aV/xTEmwZ2pwA8b
 JqL8ZzG5wC3cb1epYLtCp/Wch525fNu8OZ+Se9cmebXlXh03Fu/KK2s5DdOn2qAO7jvd
 yofnNA8Y3B1S3el+x3b9DWnD4Vqee3ytswtMIoAeGyky6cU8wNXkNjiWG7FoG7GrTLEU
 9b7gcK+NqSJuq7lkDi/xJPeZ7ej5rKV3uwULNCIlZa5iqyvuwV4OhLkZJh0TjNWfSSfR
 oDRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+V9kic8qK6fIq8iUV2WmQvCa3dZ3IzsT7OwjqAgkg720O2DhAuhkvDxRfi7I1YdbIYg3mfnk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k0XYwZcHImsaTkgJHJnxGB0jXIxTXrCxXMKLkGvo3b2ITYs9B7
 mZmc+lXVE8vhz7YWF1Z/si6Pz7zdd43OB96QdaPcTzbDQRjtI6pY8to6kv1VtDjjRqY=
X-Gm-Gg: AYBFou2wSk+w+jqY4582byjzNWQDFV5yZMwM0ju4FtwsG2f0+q5kb/6BYVZIz/gV5PN
 FO6tQ/06gH5vvmOV5D8AmF+5p3Imc5k0R2k3wpfyPLQ94i/qD8l22YoY2ubsFN1bKv3A64yz/h5
 c9cMcHgvAbLy+56uUErgcWPK8JFETaPG2Zrev1Tl1rTKYC4xF9YvwUippY4c+kJ0gIvKamBqAsX
 IFL3ooFQh+yJlgCcluUXVXYdm3W9VQUJlTTus3pDo3vDZTYCt1nL4e2mmp1rHDk4CrbpzcjSiQ6
 vANSaK24vWFk5PyX7OQ9tzW3Y4G6+nV2r/dRU+V0x3VtBBdHaS9resevc65GRsOcF+N7IV/tsrU
 uUPVjbQfg0bLCgOcpWnxA8Ayyb/grp3ywuEqynhqCUF4GqHBc21ZVY8lMlurqORYtZwJ9BMB8Jm
 MUon6fwG1aDy8A0HMmoeJn+w3PRvAG7+d+1ne8ditYXyMAcVZIIw/NuQtntV5e7Q9gHtAGpZN0c
 zp+Lyg6jFR38NWhem2P/66Tf2NiN4bYSno/dackbcg2wT4NI1/x/ST1OYu9XTpMp5k9AT1EUfE5
 4SakQnuStUap9VBIyD4=
X-Received: by 2002:a05:6830:3886:b0:80c:d30f:97d with SMTP id
 46e09a7af769-80de33eccf5mr4165932a34.30.1789760544860; 
 Fri, 18 Sep 2026 12:42:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107e38ec49sm380871a34.13.2026.09.18.12.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 12:42:24 -0700 (PDT)
Date: Fri, 18 Sep 2026 13:42:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 11/11] rockchip: Choose FIT payload compression via
 Kconfig
Message-ID: <20260918194221.GU858934@bill-the-cat>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-11-28e946f57357@flipper.net>
 <77f7c2c3-f038-4558-a1d9-8a69529c372e@cherry.de>
 <CAKTNdwGRuKgrt3pcYWcAuy-OB0GqOkqVFC1i0HF_+e5Zmi+Bhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mnX6jvi7d54RmC3T"
Content-Disposition: inline
In-Reply-To: <CAKTNdwGRuKgrt3pcYWcAuy-OB0GqOkqVFC1i0HF_+e5Zmi+Bhg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--mnX6jvi7d54RmC3T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 11:12:08PM +0400, Alexey Charkov wrote:
> Hi Quentin,
>=20
> On Fri, Sep 18, 2026 at 9:57=E2=80=AFPM Quentin Schulz <quentin.schulz@ch=
erry.de> wrote:
> >
> > Hi Alexey,
> >
> > On 9/18/26 12:52 PM, Alexey Charkov wrote:
> > > The dtsi infers how to compress from whichever SPL decompressor happe=
ns
> > > to be enabled, so there is no way to ask for one in particular, turni=
ng
> > > a decompressor on for something else silently changes the image, and =
the
> > > conditional has to be updated with every new algorithm.
> > >
> >
> > Thanks, this was something of an eye-sore to me for a while already :)
> >
> > > Move the selection to Kconfig instead, with proper help texts and sup=
port
> > > for all available compression algorithms. Each choice enables the
> > > decompressor that provides it, and carries the compression level.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > ---
> > >   arch/arm/dts/rockchip-u-boot.dtsi | 16 +++-----
> > >   arch/arm/mach-rockchip/Kconfig    | 78 ++++++++++++++++++++++++++++=
+++++++++++
> > >   2 files changed, 84 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchi=
p-u-boot.dtsi
> > > index 4ba6a87e78ab..a72b55cec05a 100644
> > > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > > @@ -11,14 +11,6 @@
> > >   #define FIT_ARCH            "arm"
> > >   #endif
> > >
> > > -#if defined(CONFIG_SPL_GZIP)
> > > -#define FIT_UBOOT_COMP               "gzip"
> > > -#elif defined(CONFIG_SPL_LZMA)
> > > -#define FIT_UBOOT_COMP               "lzma"
> > > -#else
> > > -#define FIT_UBOOT_COMP               "none"
> > > -#endif
> > > -
> > >   /*
> > >    * SHA256 should be enabled in SPL when signature validation is inv=
olved,
> > >    * CRC32 should only be used for basic checksum validation of FIT i=
mages.
> > > @@ -61,11 +53,15 @@
> > >                               type =3D "standalone";
> > >                               os =3D "u-boot";
> > >                               arch =3D FIT_ARCH;
> > > -                             compression =3D FIT_UBOOT_COMP;
> > > +                             compression =3D CONFIG_ROCKCHIP_UBOOT_C=
OMP;
> > >                               load =3D <CONFIG_TEXT_BASE>;
> > >                               entry =3D <CONFIG_TEXT_BASE>;
> > >                               u-boot-nodtb {
> > > -                                     compress =3D FIT_UBOOT_COMP;
> > > +                                     compress =3D CONFIG_ROCKCHIP_UB=
OOT_COMP;
> > > +#if CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL !=3D 0
> > > +                                     compress-level =3D
> > > +                                             <CONFIG_ROCKCHIP_UBOOT_=
COMP_LEVEL>;
> > > +#endif
> >
> > OK so the obvious question here is "why Rockchip-specific?". I
> > appreciate you're mostly working with the RK3576 but I don't see why
> > this (the kconfig symbol definition that happens later in this patch in
> > arch/arm/mach-rockchip/Kconfig) needs to be Rockchip-specific, we have
> > other architectures that are also building a FIT image with U-Boot
> > proper in it, so I think it'd be nice to have this setting apply to all
> > of them so that it's a more generic approach.
>=20
> The Kconfig selection itself is surely arch-agnostic, but I have no
> idea if the handling of the resulting images will work out fine on
> other architectures or what their constraints are, beyond what the
> build system can tell me. Rockchip is the only one I can test, so I'd
> rather start here :)

You don't need to implement it on other platforms, but yes, we should
start this out generic-facing. That'll encourage someone else to look at
what needs doing for another platform.

[snip]
> > > +       ratio on offer, and by far the slowest to unpack.
> > > +
> > > +config ROCKCHIP_UBOOT_COMP_LZO
> > > +     bool "lzo"
> > > +     select SPL_LZO
> > > +     help
> > > +       Compress with LZO, run from the host 'lzop' binary. A poor ra=
tio in
> > > +       exchange for fast decompression.
> > > +
> > > +config ROCKCHIP_UBOOT_COMP_LZ4
> > > +     bool "lz4"
> > > +     select SPL_LZ4
> > > +     help
> > > +       Compress with LZ4, run from the host 'lz4' binary. The fastes=
t to
> > > +       unpack and the worst ratio, so it suits a fast boot medium.
> > > +
> > > +config ROCKCHIP_UBOOT_COMP_ZSTD
> > > +     bool "zstd"
> > > +     select SPL_ZSTD
> > > +     help
> > > +       Compress with Zstandard, run from the host 'zstd' binary. Clo=
se to
> > > +       the LZMA ratio for a fraction of the time, but its decompress=
or
> > > +       wants around 94KB of SPL heap - see SPL_ZSTD.
> >
> > I don't like specifying numbers that aren't guaranteed to stay at that
> > value. I understand the appeal to provide some number to give a rough
> > idea of the size impact, so I don't think it needs to be a blocker,
> > maybe Tom would have some opinion there, otherwise ignore this :)
>=20
> Tom acked a similar help text on the SPL_ZSTD option itself, but maybe
> duplicating it all over the place is an overkill. Happy to distill it
> in the next version.

In this point, yes, perhaps the better answer is to not this stuff in
documentation somewhere, rather than help text.

--=20
Tom

--mnX6jvi7d54RmC3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq2UGQAKCRAr4qD1Cr/k
CoOFAQDK87wWbz28zT5XBLs9amPK6vVgZSDlsoaQRxaf5GEwNwEAhV7pIs4iyEQs
K+C0acIjWQXfaHNCi4sRRtMmHQHCnws=
=OZTM
-----END PGP SIGNATURE-----

--mnX6jvi7d54RmC3T--
