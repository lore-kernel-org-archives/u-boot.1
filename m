Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB480D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065208393F;
	Wed, 26 Nov 2025 15:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DDJbwwk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF4D83942; Wed, 26 Nov 2025 15:56:29 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08390809A5
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-450c576a335so223867b6e.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764168985; x=1764773785; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bgkqU3Q+pfbpHN2Q3/wjJCWv6e+DutUd53ejSdGc/II=;
 b=DDJbwwk3hXZ073hwzcW0EpwS6utFRKeq6aDlXOYLiZQorn8+AkjnbM3KVGDVuI3oCS
 UiObxGBRDFKDVIENGdgIh48OXI2ehz9cBzW4Pq+0ejRdPEDdD6Xg1Fh0ML80f1uQeDxe
 8g5AcGoITdPvL8HIbpyu0JWlAfU5y4eoOBw8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764168985; x=1764773785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgkqU3Q+pfbpHN2Q3/wjJCWv6e+DutUd53ejSdGc/II=;
 b=SfYMSEF4hhqNGsEdOC1DnQ4gMv41jVbzklOUhQpPzBij1aYwZ1cYOHefHoE36uePSK
 GuGQnOQXbnQTvpb+5k9tDLskUmcUY2gPfNhuWnTHzRzY+trrs0QhW2l4CCI5DXoKhq9O
 cFxDNGKZcNy7odp8EvZTCFL+kHYJU4ic/3KqAwWCN4o/b33NXiAIanCnbOPsUL4bmv/U
 WGfTllqEcxvNfAkWTBsYrQ//mM5pS4dN2cwqOQhU5/kbh3iq+9ORIkb54fYRIJtaz5mq
 6pFXouS6IAHYnVqlrYiT+F/RUr+k5zs2F4+BKU2EcEoq9CzV1hGdGbDRz2NojLiZHn0q
 x31A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGf3OVwlts3zWjWraq8MRraXKLfTSfisLvLgFn2apardUc7vsOcOyxLG5/FexxaLLXmGqxtL4=@lists.denx.de
X-Gm-Message-State: AOJu0YwiGMuoxA8U34lO6wr/ygY109u9x50mpivFGy8BpabKSbimd6Gm
 Ffu8tNj7gMRasL6VEMLpwztbVMzc2AaYyfjHtz4HULlshc/2GP7vEe8IbfQoAtgzeVg=
X-Gm-Gg: ASbGncuIe/Cv7XnzKxIihYMYg3Cg8DYguyvhvnc35atYvlvTT/FojQzjcRoBHVv0GNQ
 X8Pndo59O1g+3swM24/nUYea+zbmMTFI4jrPcUaLpq+ctM+fqZeZs0wBMjoNohHgg/QVJy/obbB
 ZGx9o4UFOFz1WyzqVc5NIKaA9Ic0pYpcuEUl4bPoDF7/MyJplX/sHF6vOxZESQRF7rcdTJ9Rp90
 6v7diO9TK0HY9nArXLj3I1EMeXDOhGcI8of/HDph/YC/RXz/+YIm5ZGErOwZwpJWBSMaCHSCF2y
 NSuCE++OcP0Zf0Q0BdiJ3MFp9MwYLBZ8nLwVYDOyysRM46mlPqo9hPTbD312g+wOjsM0fsCYqTm
 KwupmeoB4+rs+kZlGbnaCgd+Ma5zQKEINQDUpjzpBJuKbefGdNOCXcYFBQic6WlWU2A+MwjKUum
 W457c28cy0pztQWuuLw6LtQkVOGJ5riUKsyUdAFaPs3s8/C3iFkA==
X-Google-Smtp-Source: AGHT+IH/lOc0UK7SUA+Q5DUTHRAyabVV1lRD01lgbvMbCCIiNpdfvmnfIcfIUbEXhDoYKQo5WxUtKQ==
X-Received: by 2002:a05:6808:6781:b0:450:befe:b79c with SMTP id
 5614622812f47-45115b215camr7299672b6e.37.1764168984628; 
 Wed, 26 Nov 2025 06:56:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782831ed6sm5108293eaf.0.2025.11.26.06.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 06:56:23 -0800 (PST)
Date: Wed, 26 Nov 2025 08:56:21 -0600
From: Tom Rini <trini@konsulko.com>
To: "alexander.feilke@ew.tq-group.com" <alexander.feilke@ew.tq-group.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Fabio Estevam <festevam@gmail.com>
Subject: Re: [BUG] silent hangup when debugging lib/fdtdec.c
Message-ID: <20251126145621.GS2125796@bill-the-cat>
References: <20251125161427.1155-1-Alexander.Feilke@ew.tq-group.com>
 <20251125163524.GQ2125796@bill-the-cat>
 <2db22e-6926d980-129-2e0bef80@48422766>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MMakRkhrNJhY4cf1"
Content-Disposition: inline
In-Reply-To: <2db22e-6926d980-129-2e0bef80@48422766>
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


--MMakRkhrNJhY4cf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:41:14AM +0100, alexander.feilke@ew.tq-group.com =
wrote:
> On Tuesday, November 25, 2025 17:35 CET, Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > On Tue, Nov 25, 2025 at 05:14:12PM +0100, Alexander Feilke wrote:
> >=20
> > > From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
> > >=20
> > > Description: U-Boot hangs silently during boot when enabling DEBUG in
> > > lib/fdtdec.c
> > >=20
> > > Not sure if its really a bug or rather a configuration issue on my si=
de.
> > >=20
> > > Minimal steps to reproduce: <see patch>
> > >=20
> > > The hang is caused by `panic("FDT overlap");` later inside the if blo=
ck.
> > > (see `lib/fdtdec.c:1279` in `fdt_find_separate(void)`)
> > >=20
> > > Additionally, no boot log can be seen because serial is initialized a=
fter
> > > loading the devicetree in this boot stage (see `common/board_r.c:665`=
 in
> > > `initcall_run_r(void)`)
> > >=20
> > > Tested on i.MX6 with configs for tqma6d_mba6 and other tq boards that=
 aren't,
> > > mainlined yet (tqma6ulx_mba6ul and tqma7d_mba7).
> > >=20
> > > Any idea what to look for to fix this on our side?
> > >=20
> > > Thanks in advance,
> > > Alexander
> >=20
> > For very early failures you might need to look at enabling DEBUG_UART
> > which wires in a more direct "just write this to serial port".
> >=20
> > --=20
> > Tom
>=20
> Thanks for pointing that out. The debug log shows that the global data is
> still located in the SRAM after relocation.
> Printing all variables involved in the panic condition shows, that the st=
ack
> pointer also overflowed, so there appear to be two separate issues.
>=20
> if (top > (void *)gd || top > (void *)&stack_ptr) {
>=20
> including top, sp and sys_init_sp_addr for completeness:
>=20
> <debug_uart>
> FDT 8789d3a0 gd 0091de40
> top 878a7aa8 sp 878543e7
> sys_init_sp_addr 0091ff20
> FDT overlap
> resetting ...
> System reset not supported on this platform
> ### ERROR ### Please RESET the board ###
>=20
>=20
> Note: I don't use CUSTOM_SYS_INIT_SP_ADDR so the default is used. GENERAT=
ED_GBL_DATA_SIZE is 0xe0
>=20
> #define SYS_INIT_SP_ADDR	(CFG_SYS_INIT_RAM_ADDR + CFG_SYS_INIT_RAM_SIZE
>  - GENERATED_GBL_DATA_SIZE)
> #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
> #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
>=20
> Do you have any idea how to address these two problems?

Are there similar configs upstream? I know that imx6 is not generally
broken, I boot my mx6cuboxi on current next (and master recently) and
it's not failing like that, for example. Also, adding in one of the imx
custodians..

--=20
Tom

--MMakRkhrNJhY4cf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaScVEQAKCRAr4qD1Cr/k
CgJaAP42cH7AbJQ9AMYKnZ6IkEaGDtOoAaRHffK73usKCR20NQD7BGwNzS2Sir7V
rsfK6njzwG3TIhowl5nhKseY4oh9IwQ=
=T6+v
-----END PGP SIGNATURE-----

--MMakRkhrNJhY4cf1--
