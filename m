Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D594CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0C38398C;
	Sun, 16 Nov 2025 15:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J+vLz71b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897198398C; Sun, 16 Nov 2025 15:13:28 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66A483979
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-656de56ce7aso699223eaf.3
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 06:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763302404; x=1763907204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eCkyCm/x1DrVJaiM6K3TRJjyGLS5mrbB1Xh/Rtjmpb4=;
 b=J+vLz71bRkTnTt8XVC2gnw7xyl4AdFkwuHSwRxNL0C0UEFOftA7rb3KR+F0kq/MsG9
 3uKzEhvhi8DW1psXm/XH52PxfgvgvEjiXAAxtJcJeF3dcIwi+0+heBfWdpB0pRUF4aLQ
 FC/OueUiUwtmwRUaBkHljv8bWUpc077iQEjag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763302404; x=1763907204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCkyCm/x1DrVJaiM6K3TRJjyGLS5mrbB1Xh/Rtjmpb4=;
 b=Rmq+2BiYfyug3mX0Trajd6Kc4dznb5GgT/1Tc/q/C4E5WkBsySS6ZIfWV3hYGm42R2
 5JjBtBjYdupCh/1kg8UNsBl+mnEiPD7BIi8VF/3Vqylr/JKPYJRH7uWxY1g5O5fu5MNc
 bnzvVrdx6y498Ougctq7vnLCCfnIx8DzGWPuxBM3QPQ0DBjvrStuzg0vuEvub2rlUiyS
 nYBUMQzezYFGTI4DC9R6hAUscnZW6KSybqjCnSvpZsEUWtcLHch//X+I5T0DQ7I2SCio
 SZWp783Xafjt+JoZo2mjJkNyyr+iM4y+Nz+de1LmRH0Qrk/nmDU5B7zCR9BFP1BJeXud
 HCjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMtTCvzsnVaGSamU/aMvDjJ4Wh1DOny/uHIh9GMSrKKi++J2WxsM2FAqiXP4mvzzrc4LzARl8=@lists.denx.de
X-Gm-Message-State: AOJu0YysFc/kGcIEmQ9R5FSYG3YLYoaUk/A2AGUaYZO10PH8lzDfWylv
 ZiryMscouoR2VIG6Sxe/MFZHB3mMHUfsJ/U5SpyCYAGu9MPEZvXM2m21ZI0xYkYjZ7k=
X-Gm-Gg: ASbGnctBG4DOw0x2mqLws2laqZDDhs0mafrT2yJA0brsZMjaTA+CEYJZ5GbPJiwi2MU
 6/JSwgdCz2p1j24spJnuuRjSfavv/qDuq+4C+SMMNvH9bHiaGg7UgQybjHo3TaB2+FG7/4UKDj5
 OaeaxB+RUMY4CfaeEJyPQby2kZ52IO4dC7V1bXbfps8ZmTo+B1YHexo6DQDlfzndIVDeByln8Pl
 8nAN457JI8hmJvdl9XGTNvLiTrE2VqQXCLSvfu1fajGq/X2bs5CBovwH0agAfQ3nn4uUoEF6YAU
 BRVvIxirXkJdtZOWXDM0KcOAx8BYlaXTLQz8bdVx2WWFtvArzwCzIj63jTVEHKtCiOKC4fRdkLa
 CQaOdb7Iqv7kQPSCGedFP2+kihZbN5MQmfr44EC7c2bJZKv3a7nMB/NiS13c4uB1PcklObwvDge
 Z/GLBWJ1bZB9caKh5hk43Ni/cHMAPfIEkToyOAIhYKGID+nTdoog==
X-Google-Smtp-Source: AGHT+IGA+sFNstlE+Zs3v4htBMKWnRX/MbDJJoR4OsZXGkGZngyAKfbUTRtyxcrxsiAOk3N1XrijxA==
X-Received: by 2002:a05:6808:4fe7:b0:450:4782:2b0e with SMTP id
 5614622812f47-45097455d7emr4597707b6e.15.1763302404651; 
 Sun, 16 Nov 2025 06:13:24 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450a5f5e1a9sm1513068b6e.12.2025.11.16.06.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 06:13:23 -0800 (PST)
Date: Sun, 16 Nov 2025 08:13:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
Message-ID: <20251116141321.GD2125796@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
 <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
 <7a083302-1096-47fa-90a9-aa350eea6884@mailbox.org>
 <CAFLszTjktw3yS9Dp9KGC=BAnpJAHg46f--NRRfnzXApQVOiuUQ@mail.gmail.com>
 <fd30d6ca-fdfe-4096-8057-a952a6a4bb7e@mailbox.org>
 <20251114143609.GZ6688@bill-the-cat>
 <4ccf5adb-6e66-4842-8e4b-1c6f37ec966d@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2+WS71kzCVbSbu6O"
Content-Disposition: inline
In-Reply-To: <4ccf5adb-6e66-4842-8e4b-1c6f37ec966d@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--2+WS71kzCVbSbu6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 01:16:53AM +0100, Marek Vasut wrote:
> On 11/14/25 3:36 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > We would need a wrapper for almost every libfdt call, which isn't rea=
lly
> > > better.
> > >=20
> > > > What does fdt_getprop() return when the offset is -1 ?
> > > If can_assume(VALID_DTB) , then crash on NULL pointer dereference .
> > > If not, I think FDT_END (premature end) or an error code.
> >=20
> > How are we now getting in this state is a question. Are we being passed
> > an unaligned DT and trying to work around/with it?
> This is superseded by:
>=20
> [PATCH] xtensa: Assure end of U-Boot is at 8-byte aligned offset
>=20
> It turns out the problem was yet another unaligned appended DT, on xtensa
> this time.

I wonder if we have still more places. I've seen patches in your series
for many but not all of
https://lore.kernel.org/all/20221215115825.827111-1-eugen.hristev@microchip=
=2Ecom/
and I don't recall how many of those were done individually instead
afterwards.

--=20
Tom

--2+WS71kzCVbSbu6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRncAQAKCRAr4qD1Cr/k
CpnnAQCPSp8emdP9mn9Avhqde9p7ssKuXRHTs7aNbe5ANKNxYAEA9nN3Kmu6AHhc
vR0Lp1BImB28wu1QY9jHc/gdaII/Egw=
=B1/V
-----END PGP SIGNATURE-----

--2+WS71kzCVbSbu6O--
