Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897C7D3B7F2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 14:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67DA83AB8;
	Mon,  8 Dec 2025 15:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uK9U4W1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341B983AC5; Mon,  8 Dec 2025 15:24:51 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F03E83990
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 15:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so3720813a34.1
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 06:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765203887; x=1765808687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OM8ofd/q+h9pqs8bQhE5v4gCcqSgWJ0yJQDve9gRH/c=;
 b=uK9U4W1hvQJrphTnJclzF81onf+QwyMe3DwPA0bqoNfheNNtEm4PJs1hzZCK0O1Om5
 KEkBw7z+AVHof6cda1oHm8zmGe98CTHpYY0c9jwpYcVicOkk2kg8kpvnq+KHGwDSgU9w
 BgftZMFbi2kcfc1DPCeQN3QXnL/q1GCdZ3Ymg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765203887; x=1765808687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OM8ofd/q+h9pqs8bQhE5v4gCcqSgWJ0yJQDve9gRH/c=;
 b=ZLmMlOpDGCUzvqxkyr5D6v8a/C3JX96cYcva2faZ/FFEaj6V2OH2Jr/aEp1gPOhzlx
 HrT4Zd7f8wZyBADCEgNrm5aytrU1MIWeRzPd9i4x5ke7OwH7F1unUVDKUb8+0nQIt+IB
 FkrdtSpSe6OG7ntxot2qXR3ClQEi3q/ynG2XUcLwAi9c3j8z6Drjg9mhIhDn/gpxiRLn
 pN4kUKgqY4vQYxoE+VtKRX7QJhg//XJvTjbRd5GW+/qymdLFiwIaYH86827yb+4fS70D
 ETS89z/WGHygrqQoIda4k7LYmQ1QSmBgxHhueyPc+JZXdelHt8EZsUzU2OPBL/osu4G4
 YIIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1m9hC8nyWqWwAwWBU7a7jzXLJ8pU5el8wAhQ+ZhKflBj4lkPGGp2qA+kTByiKEtWbaDaGXis=@lists.denx.de
X-Gm-Message-State: AOJu0Yy77Yfsro+Qzq7d44dfrmAkklAb8IDOB65XQqft4KaWralF+zHT
 CgTl4v6BIit6WYaBFcx7faCmiFtwOmmAKMS9BSNf20+9XSdRAw8WotqBWjYRMWQwf/g=
X-Gm-Gg: ASbGncvOsZpzNwUDILU3ALf+gP8qIofri3ZZLKZu7re5QtczX6Qq8tU4n6gBX3P1hXd
 V7Wj5rCLzb08ljl0Y9phra4QkcFbeGgM3JrN8i7UicuJ+CRyJ6Z+jmkNs1JxZaRZ3KkAGbU0x2F
 vV95m7NkdJlYwMYjwIp2HqpnKYaBD689kHT1Pvzpo+FeissRaKd+I5HDxgaRStNeDw4WzYPna0u
 RnMfY9F2lgQtecEyJS8GadoE51UDaanLzHk484n83FeWoPLscJ+/BLdYdQ3ZxKxGNa1CCuQYRFV
 1ojcOggKXE+AHQnC4xX6Rl1nhVY3XQIXRj04u/k5gF9HhPoxV4EWSM3BR4auQuPog/65I0tRCvi
 FDXYLQPexWknA+39CMcxBKmgZdxSq5EFATUk5T15T0vmZNosqHVohFPEAActIvqBK8+7gp7ZHU4
 I4pwd0qZu2RwemHqTToOCaVERpydfsdlZsGPJ2H4FhS5jbefbkWCz1Yux0DfbX
X-Google-Smtp-Source: AGHT+IFwWdeM1YPISLhvfnudreyziz8PGDROVZulS7cQDsKtiuylkvKbeOl/N8TUJvabRJ5Hp2f3eQ==
X-Received: by 2002:a05:6830:2115:b0:7b2:aba7:f4e with SMTP id
 46e09a7af769-7c970752562mr4182938a34.10.1765203887151; 
 Mon, 08 Dec 2025 06:24:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95ac84d2bsm9835653a34.18.2025.12.08.06.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 06:24:46 -0800 (PST)
Date: Mon, 8 Dec 2025 08:24:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Beleswar Prasad Padhi <b-padhi@ti.com>, nm@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
Message-ID: <20251208142444.GO303283@bill-the-cat>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
 <52e73f71-6c4d-4630-88f4-81de3fedaf83@ti.com>
 <1e980f3c-5955-47c1-81d4-f758dfa2d09c@ti.com>
 <0a4d1065-24ce-4806-9696-b300717a672f@ti.com>
 <ba834c1f-2e64-4e60-8ce7-d249cfbd11fb@ti.com>
 <8934e095-d694-4d47-b8e2-6fca9e164646@ti.com>
 <5e90cda7-a867-417b-a898-0ff10f2b2e1a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lisjg5ngJ2vBeDC5"
Content-Disposition: inline
In-Reply-To: <5e90cda7-a867-417b-a898-0ff10f2b2e1a@ti.com>
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


--lisjg5ngJ2vBeDC5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 08:21:06AM -0600, Andrew Davis wrote:
> On 12/8/25 3:25 AM, Beleswar Prasad Padhi wrote:
> >=20
> > On 05/12/25 20:12, Andrew Davis wrote:
> > >=20
> > >=20
> > > On 12/5/25 1:32 AM, Beleswar Prasad Padhi wrote:
> > > >=20
> > > > On 02/12/25 18:47, Andrew Davis wrote:
> > > > > On 12/1/25 11:56 PM, Beleswar Prasad Padhi wrote:
> > > > > >=20
> > > > > > On 02/12/25 00:58, Andrew Davis wrote:
> > > > > > > On 11/28/25 9:04 AM, Beleswar Padhi wrote:
> > > > > > > > The AM571x SoC has 1 GB DDR space. As part of normal re-loc=
ation process
> > > > > > > > U-Boot copies itself to the top of DDR bank. However, on HS=
 devices, the
> > > > > > > > top 37 MB is used by PPA and is firewalled. This results in=
 an exception
> > > > > > > > and the boot fails.
> > > > > > > >=20
> > > > > > > > Introduce a new defconfig for AM571x HS platforms and set
> > > > > > > > CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (al=
igned to 2MB
> > > > > > > > as per page size for ARM32) for the same.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS de=
vices we
> > > > > > > use "CFG_PRAM"[0], seems these two configs do the same thing,=
 could probably
> > > > > > > combine them in some way..
> > > > > > >=20
> > > > > > > As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE =
which is 32MB
> > > > > >=20
> > > > > >=20
> > > > > > CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set,=
 but we
> > > > > > have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.
> > > > > >=20
> > > > > > https://github.com/u-boot/u-boot/blob/master/include/configs/ti=
_omap5_common.h#L75-L81
> > > > > >=20
> > > > > > > for all other AM57x, why is this needed only for AM571?
> > > > > >=20
> > > > > >=20
> > > > > > Other AM57x boards have >1 GiB DDR. So, the top of DDR space do=
es not
> > > > > > intersect with the firewalled EMIF region (0xbdb00000). Only in=
 case of
> > > > > > AM571x, the top of DDR collides with firewalled region, so boot=
 fails while
> > > > > > doing reloc.
> > > > > >=20
> > > > >=20
> > > > > Is there some way to detect this at runtime? Nothing prevents any=
 of the
> > > > > AM57x SoCs being used on boards with 1GB DDR (although they also =
might use
> > > > > a different defconfig). How do we deal with this for K3 devices? =
Some use
> > > > > an OP-TEE address aligned at 512MB and I'm sure one of them have =
that amount
> > > > > of DDR.
> > > >=20
> > > >=20
> > > > Well, actually not...
> > > > It's the AM62 SIP platform. From DT, it would look like OPTEE is at=
 the top of the
> > > > DDR[1], but we do a FDT fixup here in u-boot to replace the OPTEE t=
o the start
> > > > of DDR[2]
> > > >=20
> > > > [1]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/=
dts/ti/k3-am62x-sk-common.dtsi#L71
> > > > [2]: https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/=
am62x/am625_fdt.c#L84
> > > >=20
> > > > I am not sure if we can do such a thing here for mem used by PPA/fi=
rmware
> > > > as it could assume it has that memory hardcoded.
> > > >=20
> > > > >=20
> > > > > > > We build for all
> > > > > > > the AM57x with one defconfig, so this new defconfig will go u=
nused. Just set
> > > > > > > the default CFG_PRAM size to 64MB (same as AM43x),
> > > > > >=20
> > > > > >=20
> > > > > > I am guessing all AM43x devices have the same amount of memory =
unlike
> > > > > > AM57x devices? If we set CFG_PRAM to 38MB by default, won't we =
lose out
> > > > > > that memory on other devices which do not face this limitation?
> > > > > >=20
> > > > >=20
> > > > > We only really supported "officially" the AM437x-EVM. But our ove=
r-focus
> > > > > on just our EVMs caused us to make assumptions that would later m=
ake
> > > > > it difficult to add support for customer boards. Assuming DDR siz=
e was
> > > > > one such assumption, and should a customer board have the "wrong"=
 DDR
> > > > > size things like this would break.
> > > > >=20
> > > > > So instead of making another one-off fix to get one of our EVMs w=
orking,
> > > > > I'm trying to think of a way we can make this work automatically =
for any
> > > > > combination of DDR size and firewalled region.
> > > >=20
> > > > TL;DR
> > > > I think adding that dynamic support would be tied up only for TI us=
ecase?
> > > >=20
> > > > Hmm yes, I get your point. But to be able to do this dynamically, we
> > > > would want to see if gd->relocaddr intersects with CFG_PRAM:
> > > >=20
> > > > Case 1:
> > > > gd->relocaddr > (SECURE_REGION_START + SECURE_REGION_SIZE)
> > > > =3D Best case. U-Boot relocates to an address higher than firewalle=
d addr
> > > >=20
> > > > Case 2:
> > > > gd->relocaddr <=3D (SECURE_REGION_START + SECURE_REGION_SIZE)
> > > > =3D Fixup needed. U-Boot relocates to an address which could overlap
> > > > with secure region. Update the gd->relocaddr to a lower address ran=
ge
> > > > which won't overlap with secure region:
> > > >=20
> > > >  =A0=A0=A0=A0 reloc_text_size =3D (RAM_TOP - gd->relocaddr);
> > > >  =A0=A0=A0=A0 gd->relocaddr =3D SECURE_REGION_START - reloc_text_si=
ze;
> > > >=20
> > > >=20
> > > > And ofcourse, we can't put this logic in the existing 'reserve_pram=
'[3]
> > > > INITCALL because gd->relocaddr gets modified in the subsequent
> > > > initcalls like 'reserve_trace'. We would want to introduce a new
> > > > INITCALL which would be invoked after all reserve_* initcalls and
> > > > before the reloc_* initcalls; where we can put this logic.
> > > >=20
> > > > Let me know if you think this is worth adding, or is an overkill and
> > > > we can live happily with CFG_PRAM =3D 38 MB for all AM57x devices :)
> > >=20
> > > Thanks for doing all this evaluation. I don't think this will be
> > > the last time we run into this issue, but for now let's just make
> > > CFG_PRAM =3D 64 MB for all AM57x devices and create the perfect solut=
ion
> > > later.
> >=20
> >=20
> > Thanks, I tried setting CFG_PRAM but it still ended up in a firewall
> > exception. I guess this is because CFG_PRAM only ensures U-Boot doesn't
> > relocate to that protected address[4], however that memory is still open
> > for access by anything else if needed. Whereas, SYS_MEM_TOP_HIDE reduces
> > the ram size itself[5], which ensures that memory is not visible to
> > U-Boot at all (either for reloc, or general usage).
>=20
> Seem PRAM ("Protected" RAM) isn't all it claims to be, better route then
> is to convert our existing uses of PRAM to SYS_MEM_TOP_HIDE, which seems
> more modern and uses KConfig.

I don't think it's any more or less modern, but to be clear, there's no
way (or no reason?) to describe these memory areas in DT? Or is it that
we also need to do some game to remove it from U-Boot's view early on
because how of little memory there is / where this area is? Thanks!

--=20
Tom

--lisjg5ngJ2vBeDC5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTbfqAAKCRAr4qD1Cr/k
CjBNAP4zpGbu4mwA/DBOaEqVKlvv2wKuK7nV/FdG4N7pWnXrRgEAnQSQH8Zw/eMy
XCG5mzgyo9cbhlirDj9S2wt7g0DU3gs=
=Smt0
-----END PGP SIGNATURE-----

--lisjg5ngJ2vBeDC5--
