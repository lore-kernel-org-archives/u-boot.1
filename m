Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA7C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C276D871AB;
	Wed,  8 Nov 2023 17:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kkrZjp/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B266B871AD; Wed,  8 Nov 2023 17:44:34 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0090B871A2
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d84c24a810dso7367816276.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699461870; x=1700066670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oBrLhJJWr3LhhjPDVKuDBKdPr1068b9WibTf5SXkLZ0=;
 b=kkrZjp/eWfjHVrPnznloYiCqmZ3SfPEhNaluXOFuHXEHwlHpXBGJjTU77GJKu6Aj9Y
 80UfS//NY2VfPxGeLXgquDzBCxTsXXATL5GrHAv7I4XHDzeUTBBj3XkuGoOvqoSLjly/
 nsCcNlPnrBmmFrOsXXc+Vhy0KlTNIJ3ud6EIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699461870; x=1700066670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBrLhJJWr3LhhjPDVKuDBKdPr1068b9WibTf5SXkLZ0=;
 b=ucu3hfrX68zEK6wAHlX5H/TJtIbuSDP/ZaHpYVDmLFvbpG9t/lXAabglHUpWf2zWIZ
 IfS1JjAUYMxo6sUfCzg72aPnKaNM5FJ2+QwZHzyeV+LpTH/L/eD8RkpXV66u7BXs+GNi
 6FQDbsteNJ7lGDrOT2fg/G4jH0aOgv2UzNab4jshK/0AcO5dRLjNvxD4IbHoJQTT9ER0
 6SDqYjphVgbaXQ3oUlEv0J7uAhhiD3Pe012giXYXS3WnBrKQ2YhUmR8qSFtX/zvyLE39
 QCenUn6NvnJVWsJCFwNcqrh4gVZ4/sW0we/fsw8N7up6Z/eKGAQVyjC2EHgopXjZe51a
 9zOQ==
X-Gm-Message-State: AOJu0YwS/5/y1v272v87l9QbN8E9DWt1LzTeErXgtUB8eLtBLn9c+eXR
 Xhaokx7uo37pF5jjrpt7kSqwzA==
X-Google-Smtp-Source: AGHT+IF/Wi0G2WDYlgsCjHU1lhCVxCj10gAPvhFkEy2f4EYUVbRlfZ4MbcbEzbmbN4Ave1no4orFsw==
X-Received: by 2002:a25:b18e:0:b0:d9b:76c3:4143 with SMTP id
 h14-20020a25b18e000000b00d9b76c34143mr2111456ybj.6.1699461870557; 
 Wed, 08 Nov 2023 08:44:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a255f07000000b00d8679407796sm6350211ybb.48.2023.11.08.08.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:44:30 -0800 (PST)
Date: Wed, 8 Nov 2023 11:44:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, palmer@dabbelt.com
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231108164427.GQ6601@bill-the-cat>
References: <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <20231107-audible-undoing-293506af3890@spud>
 <20231107232305.GW6601@bill-the-cat>
 <20231107-sprinkled-sixtieth-6456baa2c7a3@spud>
 <20231108003449.GF6601@bill-the-cat>
 <91ae75c2-a0d7-4835-8306-777c4d9afdd9@canonical.com>
 <20231108143735.GO6601@bill-the-cat>
 <d39c3c18-99e7-460b-97b8-9f84f523cf11@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+MUsmQZVYUPe+gPg"
Content-Disposition: inline
In-Reply-To: <d39c3c18-99e7-460b-97b8-9f84f523cf11@canonical.com>
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


--+MUsmQZVYUPe+gPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 07:25:22AM -0800, Heinrich Schuchardt wrote:
> On 11/8/23 06:37, Tom Rini wrote:
> > On Wed, Nov 08, 2023 at 06:23:37AM -0800, Heinrich Schuchardt wrote:
> > > On 11/7/23 16:34, Tom Rini wrote:
> > > > On Wed, Nov 08, 2023 at 12:29:03AM +0000, Conor Dooley wrote:
> > > > > On Tue, Nov 07, 2023 at 06:23:05PM -0500, Tom Rini wrote:
> > > > [snip]
> > > > > > Thanks. Setting aside Simon's follow-up, this is what I was loo=
king for.
> > > > > > We might have to wait for Heinrich to return from the conferenc=
e to have
> > > > > > time to look at how to utilize the above and see what we can do=
 from
> > > > > > there.
> > > > >=20
> > > > > I did read that, but I don't think most of it is relevant to the =
binding
> > > > > itself. His five things were:
> > > > > | - U-Boot models hardware (and other things) as devices in drive=
r model [1]
> > > > >=20
> > > > > This I think should be satisfied. The Zkr CSR is a property of th=
e CPU,
> > > > > and shouldn't have its own DT node IMO. Is it problematic for U-B=
oot to
> > > > > populate multiple devices for its driver model based on one DT no=
de?
> > >=20
> > > Devices in U-Boot are bound on the basis of a compatible string. All =
RISC-V
> > > CPU nodes have a compatible string 'riscv' but that does not provide =
any
> > > information about the existence of the Zkr extension. That informatio=
n is in
> > > the 'riscv,isa-extensions' property of the cpu nodes (see
> > > Documentation/devicetree/bindings/riscv/cpus.yaml).
> > >=20
> > > > > I know in Linux that I can create devices using something like
> > > > > platform_device_register(), does U-Boot have a similar facility?
> > >=20
> > > This is what the U_BOOT_DRVINFO() macro in my driver does and which S=
imon
> > > discourages.
> >=20
> > My current thoughts are that in this case we could use U_BOOT_DRVINFO()
> > like today and then have riscv_zkr_probe() be what checks the
> > riscv,isa-extensions property for an appropriate match? This would mean
> > we don't need any new nodes/compatibles/etc, and possibly not need any
> > bootph- properties added either? I assume we don't need the RNG so early
> > as for that to be an issue.
> >=20
>=20
> The presence of the Zkr extension in the device-tree 'riscv,isa-extension=
s'
> property does not indicate if the machine mode firmware has enabled access
> in supervisor mode via the mseccfg.sseed flag. This is why my driver tries
> to read the seed register and checks if an exception occurs.

This I think is a question for Cody or someone else in the RISC-V
community? If just checking the property isn't sufficient, what is? Or,
what's the best / most reliable way? I don't know and I'll let the
RISC-V community sort that out instead of making incorrect assumptions
myself.

> Additionally checking the device-tree would increase code size. Is it rea=
lly
> needed?

I mean, it depends? My biggest issue right now is that in-tree I don't
see any RISC-V targets that select any of the RISCV_ISA options so I
can't evaluate what platforms grow by how much where. We shouldn't be
talking about kilobytes of change, so no, I don't think somehow checking
the device tree for this is out of bounds. But it comes back to what I
just asked above, first. We need the correct and expected way to check
for this feature to be known, then we decide how to handle that.

> We may have multiple RNG drivers enabled on the same device, e.g. TPM, Zk=
r,
> virtio-rng. In several code locations we try to use the first RNG device
> (not the first successfully probed RNG device). This is why
>=20
> [PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
> https://lore.kernel.org/u-boot/20231104065107.23623-1-heinrich.schuchardt=
@canonical.com/
>=20
> moves the detection from probe() to bind(). The patch further corrects the
> return code if the RNG device is not available.

Sounds like we have some other general issues to sort out too then.
Filing an issue on
https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/ would be
good so it doesn't get forgotten.

--=20
Tom

--+MUsmQZVYUPe+gPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLuugACgkQFHw5/5Y0
tyx6VQv/eAxr+fMXxi2xKJf4gcYMXXmbk/2TKTBrDAUBZFRspXNYZWaAwgE2Rx0W
tJ6KMMPiDMjMG3Zm/9zjcxmMy3xldt7ZFAi/ON1TchkHAh3CVA4Rhs8pc4uZ0y3D
f7oU2V+ZKpbRYoMxmdfhL9Sil1PEiiNnxf06cd93VEYJT1NLMPW0SqSq1GHVye+2
ch7sA1riQN84/C7hJcSQczSfqZNsYYhguDOUbyIF1S3TVDh0yGa2GmWF3nIzQzwx
1fE9y94XPhWnFK0R90u+rFM9f9PvFI1AcHnpulj3OK1wn5OQ8Z2W9KfjLPric/P9
p5hYxzHGXFuKe0PsKOzbqWJ1c0a0KW8spbA07Z12CsYE0aaWGv9pAgXjdsQxDRE0
RjkQcJNzohCOXVo2a/YEKSRPN+Mxe8T4uJG4/I83gNBt9NoM3G5iabGEoxmEVOoK
59XXpLr1cXrD682og+4xPxCUaUPzvDA8L6RV2strsdTvBnBDOP/NI7E9HHGIFo6d
XkA2Hm37
=zhn/
-----END PGP SIGNATURE-----

--+MUsmQZVYUPe+gPg--
