Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF78CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D28846EB;
	Fri, 15 May 2026 20:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="q75JT8wo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E96A84099; Fri, 15 May 2026 14:40:18 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC578407D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so46454565e9.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778848815; x=1779453615;
 darn=lists.denx.de; 
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QhddF92xmBvFZUtQ8Lq8eCt5NOmfHhH2iReD/cKKkRI=;
 b=q75JT8woCcNLwJEXp3ZN9pewbaWccHzZS3350vtrLZf8RD/DMbgk4ibQanOaJiLHjS
 /MKmB/91odzej9FUy+RwIxp45vddMfGzIwC3A4ck4sVdThfXmsm1NCJ0eXUZQAf0G2Xe
 BxNp8sUwCbq5OrqSRSqdfqXclSOgHDj+CpQYEAYFTUfLLeinhqhmqVCeXK73cjFzQy4D
 Zas0rGuJtquK+bDs8L64npmruf2Bi+hJ9V1S6LYDf9jlC6m7jaBqyD/DRnHcwbYVg1sW
 aalwA6BOItEFVbVZctx0ND0Zxj6yJi9HwHH19E0P8Eefv44yLO+sdUrHG6G7mcEWHCTf
 txYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848815; x=1779453615;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhddF92xmBvFZUtQ8Lq8eCt5NOmfHhH2iReD/cKKkRI=;
 b=f48hR/Ak3HNLf+vpydZ4kaDXQNBt4AJzDrNURjvKyC2buKMDHjLKVAEJ9JGM2V3FfQ
 p7OvVOdZSHPGuPxzop8G/kGTlH6PaIljS7KZF9CtLlWqicKxc+9DQK6kfaT8up0uUA/K
 Pxpfu9bOHFbuqhPpiddYZ3FG6f/CKVaj5tMR8Z5/LrCygse67vZODLBXFbeXOetPATkM
 WDlYJdlZePp0BLK6zl7APSFS9b46TDww/RaJrv+z7yzZ0u/HItlSA1siAX7gcdfCkGyV
 fv2PZp0+SAoL++YaqWROVHXQa7oz//4Vrwm52oTCfaHbiFsqGhY7nQm5tUfvHR9EFkDE
 mC/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ocaLN5PiY/ddoxx4BBlDzXi6lhkWQQCtGIWHoC+ArFF+FjwgISYVQjZjg43TnNwE8CZkA+j8=@lists.denx.de
X-Gm-Message-State: AOJu0YwTKSo3LA5EKmnndz7k3Fx+uqfT4+w4TL2IJkdfi1OXmQHoK5cR
 2c5qlhJz3oEi/1HDCmwOhAJoZYbfChWgNCW0YcfAbEh9wNgtPcFmMwQbwFNv0fQ5Fng=
X-Gm-Gg: Acq92OFrKru2FoCSx2qnhh3lgRw4l9xeMneusfFYscXgD5ekflGAXNpfK+G6NCYs+17
 EVL4aFaSuz4Hq4wk4mwdJ3ASxMzIHsADT+BeKZPyZO24hxvUoAngAhwBZ5NJJAvO/c49QXALGWw
 rqu0a3Y+Hk6b0au+b+uyqbNdC+paKKR/hc7ZAgN8UaTFZp+YwaUjNUkmy7NmXny5xI8G/HR7j+4
 oYqHSLlJsxMpH4EgGf2KoYW+VxuHPSXoOg3AqKheAEfYTyublFA6tnkWfHqqjDpHWWg8lQZWFtY
 bjzoOeZyDDjIgSg20W8tOgCkKuX9gMl4ENvwdf/m2h+jC+NVytHybchoeI96KzoHoOWqNucIUaG
 xMp1JFN8RbbspbuWBb51FdiBYBlWcgrpsJfw2D5WMOrF7VjNE6nRpRn6oDMVwG9w/qFlfabnnlp
 NV25HszMIMbQxQdXG4
X-Received: by 2002:a05:600c:34d4:b0:48f:e230:c3fa with SMTP id
 5b1f17b1804b1-48fe6626a58mr51816765e9.32.1778848814578; 
 Fri, 15 May 2026 05:40:14 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:298c:ceb1:1a:f428])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm56584905e9.2.2026.05.15.05.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:40:13 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a683b65d35d71b1cbbde9fe2e0594c45f561c8fa4e850bd1e7c7e5146f91;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 15 May 2026 14:40:05 +0200
Message-Id: <DIJ99VT9BM31.1Z4PKVT91JLZP@baylibre.com>
Subject: Re: [PATCH v7 13/14] arm: dts: am335x: Remove unused uboot devicetrees
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Kory Maincent"
 <kory.maincent@bootlin.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>, "Rasmus
 Villemoes" <ravi@prevas.dk>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, "Simon Glass"
 <sjg@chromium.org>, "Anshul Dalal" <anshuld@ti.com>, "Michael Trimarchi"
 <michael@amarulasolutions.com>, "Patrick Delaunay"
 <patrick.delaunay@foss.st.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Tien Fong Chee" <tien.fong.chee@altera.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Johan Jonker" <jbx6244@gmail.com>, "Brian
 Sune" <briansune@gmail.com>, "Hai Pham" <hai.pham.ud@renesas.com>,
 "Bernhard Messerklinger" <bernhard.messerklinger@at.abb.com>, "Emanuele
 Ghidoli" <emanuele.ghidoli@toradex.com>, "Parth Pancholi"
 <parth.pancholi@toradex.com>, =?utf-8?q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>, "Paul Kocialkowski" <contact@paulk.fr>, "Andre
 Przywara" <andre.przywara@arm.com>, "Paresh Bhagat" <p-bhagat@ti.com>, "Ion
 Agorria" <ion@agorria.com>, "Peng Fan" <peng.fan@nxp.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
 <20260427-topic-am33-evm-oftree-v2026-01-v7-13-7e6cd1a805a1@baylibre.com>
 <20260428104133.5b437e99@kmaincent-XPS-13-7390>
 <20260505163941.GA2508910@bill-the-cat>
In-Reply-To: <20260505163941.GA2508910@bill-the-cat>
X-Mailman-Approved-At: Fri, 15 May 2026 20:12:56 +0200
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

--a683b65d35d71b1cbbde9fe2e0594c45f561c8fa4e850bd1e7c7e5146f91
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue May 5, 2026 at 6:39 PM CEST, Tom Rini wrote:
> On Tue, Apr 28, 2026 at 10:41:33AM +0200, Kory Maincent wrote:
>> On Mon, 27 Apr 2026 11:01:29 +0200
>> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>>=20
>> > These devicetrees are not used anymore because the boards are using
>> > upstream devicetrees now.
>> >=20
>> > Acked-by: Andrew Davis <afd@ti.com>
>> > Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>> > ---
>> >  arch/arm/dts/Makefile                              |  11 -
>> >  arch/arm/dts/am335x-bone.dts                       |  23 -
>> >  arch/arm/dts/am335x-boneblack.dts                  | 174 -----
>> >  arch/arm/dts/am335x-bonegreen-eco.dts              |  53 --
>> >  arch/arm/dts/am335x-bonegreen.dts                  |  14 -
>> >  arch/arm/dts/am335x-evm.dts                        | 767
>> > --------------------- arch/arm/dts/am335x-evmsk.dts                   =
   |
>> > 730 -------------------- arch/arm/dts/am335x-icev2.dts                =
      |
>> > 486 ------------- arch/arm/dts/am335x-pocketbeagle.dts               |=
 237
>> > ------- arch/arm/dts/am335x-sancloud-bbe-common.dtsi       |  67 --
>> >  arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts | 113 ---
>> >  arch/arm/dts/am335x-sancloud-bbe-lite.dts          |  50 --
>> >  arch/arm/dts/am335x-sancloud-bbe.dts               |  53 --
>> >  13 files changed, 2778 deletions(-)
>> >=20
>> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> > index
>> > d90e02ca4e5c73534ce4c5f41173c897780bc6fe..35145d7e01176e320ebbf5e4004a=
46540f8933f1
>> > 100644 --- a/arch/arm/dts/Makefile +++ b/arch/arm/dts/Makefile
>> > @@ -403,26 +403,15 @@ dtb-$(CONFIG_ARCH_ZYNQMP_R5) +=3D \
>> >  	zynqmp-r5.dtb
>> >  dtb-$(CONFIG_AM33XX) +=3D \
>> >  	am335x-baltos.dtb \
>> > -	am335x-bone.dtb \
>> > -	am335x-boneblack.dtb \
>> >  	am335x-boneblack-wireless.dtb \
>> >  	am335x-boneblue.dtb \
>>=20
>> I think you can also remove these ones.
>> IMHO all of the devicetree described here
>> https://elixir.bootlin.com/u-boot/v2026.04/source/include/configs/am335x=
_evm.h#L117
>> could be removed. Even if they are missing from CONFIG_OF_LIST, which co=
uld also
>> be corrected.
>
> I'm OK with that being a follow-up since there's been no other changes
> requested / problems reported at this point.

Thanks, I will create a follow-up for these boards.

Best
Markus

--a683b65d35d71b1cbbde9fe2e0594c45f561c8fa4e850bd1e7c7e5146f91
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCagcUJRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMC
jAD+MMCfiQyPDzBNk1CyEY0Z35afjerSS+lpmdRRP4x2lQ0A+gNG0sdPFaRoCIPy
VVbSelY8OqOnZbZwexrQ4uGXPNQI
=AknH
-----END PGP SIGNATURE-----

--a683b65d35d71b1cbbde9fe2e0594c45f561c8fa4e850bd1e7c7e5146f91--
