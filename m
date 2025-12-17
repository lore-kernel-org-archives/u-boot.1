Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F75D65C69
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 15:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC74D83B91;
	Wed, 17 Dec 2025 16:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e+DibD+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A57983B95; Wed, 17 Dec 2025 16:46:54 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130E283B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 16:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-455749af2e1so388630b6e.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 07:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765986411; x=1766591211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xImPengLnUBGFmjLODZmPSAoCsJtYOXEyUcf3z+/yEs=;
 b=e+DibD+DSZHLd0DVn3HKv7rJh7b9PYnQWSTeOcHSbShVvikIQUgILtHkiKM4hGkqRO
 p4GVVeaxXNf3rFJ1wikaBV63YSFOan4jJ8Vw+r/chS0/PJOj/kSBJY8yPRMqcfxy0e0q
 EIuspB2gUOE9evtB5Y3tM7tTm8rS9ybgJ16To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765986411; x=1766591211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xImPengLnUBGFmjLODZmPSAoCsJtYOXEyUcf3z+/yEs=;
 b=ELv6KpYJuq1LkDDAKjQ5EXo7mLUcidxavR1FtiTIBjK/ntSnBHMNuTU/iEWQBbIIbN
 GfPrFXFefhxyoik/17gRyZ57o7+n8s9N2naD+f7ekHGgbRONTPe0oomSVEiZijd5BjDM
 vTv+jWnf92A/N15/vlaL9Ap8S3T39UbS0OOSRMQWZeRqC9BEAFVdWpWRjigP4E8sGh1y
 tH7p3X7/++katg1pHcFqrcAaYOFi7SvTOsXvPBQPmE+S1TGRGBrsdH/j+B/m/8+M19do
 WY28HYDTJxhCIMYvqPnHPYWytNq86Pb/xL0+8bCoMPmeLXY7697ntfMxcJCIHOYOjc1h
 4cZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7enib8LtZhFHrNIATywm0MGOYXMBwR9EN2kjrNrK7+Gd9cmUviS7KVKHm/pGDeVxFJsJjHpI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3Xp3op4M17TZ+TwBXnPJeQs7ccyn3VV7I70JZ4GKNVlq7N6Oy
 IQ5X+QKtENwGrIsJ5VpHe0Kk6DA/vAxFY9WRXvCB9wF2XXo9QcpQmLa9+TDPNSx1k0g=
X-Gm-Gg: AY/fxX6ksVUsrNaOJ/KtZv7VyYQm+Uv5ELRSwmI/o9sbEMG15XAGmet9R5M4zQJ87gm
 C4wDIvQ0LF6Cd17LSYBtuaTq8QKs03cDZWzS/zhZoOsubYZ6k6EvNHqNIJ0fcZdNmW0d27cI2fg
 VY6eCCAkW/Azo7JZEltBpPu86OHN1Vekx27QYvtPqhtL5R62V9WwHlsqHt0H6P4UYFygb31eapQ
 Fnya9cPlxOJdEb7b+WUqC0fN+hE79Ql22M3pSaEmrE2kgJ/SVXjp59YNUzsdV7pNnJQ0nGZSqP5
 bdnLvY9VHaBD/cutd6Luyb0hMLK9qNM/sgjnF7yEZxvSeYK63EH0/fWdblY2cpgDcOE8CDv7XRp
 e9/Hjnc28FJOkHkh83fsAj435XnJHF+P3Mnz+X/Ej/nlxcPXkHcBtoECjc13nBltMGZ4kKo6wP0
 bsic+6uSEnLTQ/tQ3VlOHbbnWfXk8/wVIV792dHY5ck+tITIwGsQ==
X-Google-Smtp-Source: AGHT+IEVeMWZWE80vCXPbNOi8/y/QQf8LZKtSwHjvqOms7MdMRtamVqxjaPLgOzsCU64cS9ZrEDoNg==
X-Received: by 2002:a05:6808:2443:b0:44f:6df8:6a2f with SMTP id
 5614622812f47-455ab785796mr7105621b6e.23.1765986410703; 
 Wed, 17 Dec 2025 07:46:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b46c12sm9559469b6e.3.2025.12.17.07.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 07:46:50 -0800 (PST)
Date: Wed, 17 Dec 2025 09:46:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
Message-ID: <20251217154648.GD303283@bill-the-cat>
References: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
 <20251217141727.GB303283@bill-the-cat>
 <11ade490-ba73-4553-812b-27e85b4d29d9@cherry.de>
 <20251217150415.GC303283@bill-the-cat>
 <845dd05e-df50-45e4-9194-e2d519ab56ee@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KelZbvHPZaYmFNCG"
Content-Disposition: inline
In-Reply-To: <845dd05e-df50-45e4-9194-e2d519ab56ee@cherry.de>
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


--KelZbvHPZaYmFNCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 04:35:47PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/17/25 4:04 PM, Tom Rini wrote:
> > On Wed, Dec 17, 2025 at 03:51:03PM +0100, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 12/17/25 3:17 PM, Tom Rini wrote:
> > > > On Wed, Dec 17, 2025 at 03:01:10PM +0100, Quentin Schulz wrote:
> > > >=20
> > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > >=20
> > > > > CMD_NET_LWIP has never existed so it cannot be right. I'm guessin=
g the
> > > > > intent was to allow print_eth() to be called when NET_LWIP is def=
ined
> > > > > (NET means "legacy networking stack" as opposed to NET_LWIP which=
 is the
> > > > >    newest (and incompatible) stack). There probably was some mix-=
up
> > > > > between CMD_NET and NET options.
> > > > >=20
> > > > > The dependency on CMD_NET seems unnecessary as it seems perfectly=
 fine
> > > > > to run bdinfo without CMD_NET (build and run tested). So let's in=
stead
> > > > > make the dependency on NET || NET_LWIP.
> > > > >=20
> > > > > Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_=
LWIP=3Dy")
> > > > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > ---
> > > > >    cmd/bdinfo.c | 6 +++---
> > > > >    1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> > > > > index 20c8c97f0cd..09fe8067642 100644
> > > > > --- a/cmd/bdinfo.c
> > > > > +++ b/cmd/bdinfo.c
> > > > > @@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *b=
d)
> > > > >    	bdinfo_print_num_l("relocaddr", gd->relocaddr);
> > > > >    	bdinfo_print_num_l("reloc off", gd->reloc_off);
> > > > >    	printf("%-12s=3D %u-bit\n", "Build", (uint)sizeof(void *) * 8=
);
> > > > > -	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWI=
P))
> > > > > +	if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP))
> > > > >    		print_eth();
> > > > >    	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_b=
lob));
> > > > >    	if (IS_ENABLED(CONFIG_VIDEO))
> > > > > @@ -193,8 +193,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag=
, int argc, char *const argv[])
> > > > >    		case 'a':
> > > > >    			return bdinfo_print_all(bd);
> > > > >    		case 'e':
> > > > > -			if (!IS_ENABLED(CONFIG_CMD_NET) &&
> > > > > -			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
> > > > > +			if (!IS_ENABLED(CONFIG_NET) &&
> > > > > +			    !IS_ENABLED(CONFIG_NET_LWIP))
> > > > >    				return CMD_RET_USAGE;
> > > > >    			print_eth();
> > > > >    			return CMD_RET_SUCCESS;
> > > >=20
> > > > It must also be the case that we never both build cmd/bdinfo.c and =
also
> > > > have no network stack, otherwise we'd get a warning around print_eth
> > > > being defined but unused. Can you guard that function too? It needs
> > >=20
> > > This doesn't happen though for some reason.
> > >=20
> > > make ringneck-px30_defconfig
> > > make menuconfig # CMD_NET=3Dn, NO_NET=3Dy
> > > make
> > >=20
> > > No warning or error (CMD_BDI=3Dy and I've checked by adding #error wh=
atever in
> > > the file). eth-uclass.c which defines eth_get_dev_index() is not comp=
iled in
> > > (no eth-uclass.o in build/drivers/).
> >=20
> > Hunh, ok...
> >=20
>=20
> Compiler magic? /me shrugs
>=20
> > > > eth_get_dev_index to exist which does require a network stack. Also,
> > > > maybe we should be checking on the "no networking enabled" symbol? =
Or
> > >=20
> > > Yes we probably should but we do NET || NET_LWIP everywhere, so I bel=
ieve
> > > it's better to stay consistent for now.
> >=20
> > Makes sense.
> >=20
>=20
>=20
> Mmmmm... So CMD_NET is only selectable when NET || NET_LWIP today[1], so
> keeping only CMD_NET check is enough (removing CMD_NET_LWIP which anyway
> doesn't exist). But at the same time, there's nothing CMD_NET does that is
> required for this part of bdinfo to work, so I think going for NET ||
> NET_LWIP still is better? What do you think?

I think it's a good candidate for making clearer, as part of how you're
reworking the symbols. There's lots of ways to configure U-Boot today so
that it doesn't build, so one more small spot here for a bit longer
isn't terrible.

--=20
Tom

--KelZbvHPZaYmFNCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaULQZAAKCRAr4qD1Cr/k
CpCeAQDgED6IaUMnDbDHvvHxO8FJGYwpQlcjJ8dLi9BTT9GJTAEA9vvp/WzqsRcT
urqb/JoSNqQckuiB1YX5CGAGRQ3wHAM=
=0pTO
-----END PGP SIGNATURE-----

--KelZbvHPZaYmFNCG--
