Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4643D3EE84
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 16:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410198397D;
	Thu, 22 Jan 2026 17:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b1AaCN4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 141A9839DF; Thu, 22 Jan 2026 17:21:44 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF82080077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 17:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cfdf7e7d19so980061a34.2
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769098900; x=1769703700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BE4k8/w58jMo2z8cHWfWmYYUPziBgJEvDr3I8y7z0T8=;
 b=b1AaCN4P6b02glLiHBOEuSmAIZmLarlx9eV0KmGEorwhARuPVbUV5li0I0ZUdJhfag
 AZzpO1K9ti2KgvXth99n39SIXeYIxVDnLDF5F1rYiKHg1BSDmnvwO/d6hjfiVvmugrw2
 JcZ17pLTWbq7Z/xhwoUCKMJaI8EzOGx+GDCqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769098900; x=1769703700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BE4k8/w58jMo2z8cHWfWmYYUPziBgJEvDr3I8y7z0T8=;
 b=DDMQ/oMniTXl5MunoySTzwA9J1CUWZpEWQ/zH+JbGsDS/ZckfIUAw48223ApLGhhHj
 kHEY/6kYjJRwM1Y5XWxp0L8wi3d/XlwXbnpY36V+i1Tbeo9FkwLCCRCWZxezagGwWXT4
 1x9atAAJ3dYWJsd2zyxhrJTzXmdOBkDZjqCPuAnDT1vbVNUfVtrxU2I3i0mtZtYK66xx
 gq2kdPgQmez0nDqg4mkQ5whQT3uzujNjz8BRu2odE143USlg3a06IPbVI4d2638iy6ec
 sKUBA89Wnj/5srQA8Ez47DeBOWPo1F5BvPifj7y1Hk2YeLls2nCSeHBxP9Ut8iFOvR3U
 XBVQ==
X-Gm-Message-State: AOJu0YwxZN9Lw2V5uKwFzbKNgIX81AQGYiFwJQGFFzwtAOPtkpvdGTNV
 cHmpsVxKx7uyk5nF/tjnLasrP3PLrk0475EroxFHB7XkUm3iMXbEs8NMgwzxPpTnfOeJc/IigxD
 Y8HHaS+0=
X-Gm-Gg: AZuq6aLl7cW5Aph6IticANz6s9mfS2ms0hhGyYysCuxQP1sxhwDTY/dZ3lUzQdx28mf
 anCDLN6W3Dk5LsTlQi2MQvZyzyV/54GVuOXlHVDmL1QmjYUcrAUvSlJJx0ECuyiyhirJ4v0AQH2
 wWpYBx7UcIBfT92AWpv7VBHCbsqE5BPLSWFkUDwUUCapBjVtY3rni89ReOaaCWiKOHc/ADuHSAb
 5cM48AKJ6OyYNFYZx+NHfg5j3kst002kvlbu74qN8vLB6BDpDSQOm2XbNPSm5y4Kq0fGAAzH5wu
 eCobrfUoIrEgcL4AjgUmKozRvr9p9LHIyVSUyas9gBnjSZe6i/2t79wrBc4HtZ6ZgtUUc0nce77
 ovdbNHkJEJGvZi2DzDxDLeLSkcS/qp+fAZEuDit5R9OwOQ93BWyWeS5zYeqx1kFpjDOyiou8U7l
 2gxnptnVKXT9uj0pWBAC1i8X9fk18FJHjio/9bKztAS53BLk4brtixAxK1DE6xiEcXPpeCli3Qy
 wurhqvt9Wo1U2xFs5lI02XYx7SvuwxMg/PRM4A=
X-Received: by 2002:a05:6830:34a3:b0:7cf:dd63:3d37 with SMTP id
 46e09a7af769-7cfe017233amr9820251a34.25.1769098900301; 
 Thu, 22 Jan 2026 08:21:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28f223sm12717456a34.19.2026.01.22.08.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 08:21:39 -0800 (PST)
Date: Thu, 22 Jan 2026 10:21:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] am335x: add support for loading u-boot from multiple
 offsets
Message-ID: <20260122162137.GA3416603@bill-the-cat>
References: <20260122131728.1551365-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jj/PId5DS6jYJdgJ"
Content-Disposition: inline
In-Reply-To: <20260122131728.1551365-1-ravi@prevas.dk>
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


--Jj/PId5DS6jYJdgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 02:17:28PM +0100, Rasmus Villemoes wrote:

> The am335x knows nothing about eMMC boot partitions, so in order to
> implement an update procedure of the bootloader which is robust
> against power failure or other interruptions, one must make use of the
> fact that ROM code on the am335x looks for a valid first stage
> bootloader at several different offsets. Updating that can then be
> implemented by (assume we put MLO at offsets 128K and 256K):
>=20
> (1) At least one of the two slots must contain a valid header, since
> we successfully booted. Pick the other one.
>=20
> (2) Overwrite the first sector of the slot chosen in step (a) with all
> zeroes.
>=20
> (3) Write everything but the first sector to the chosen slot.
>=20
> (4) Write the first sector (containing the magic signature that the
> boot ROM uses to identify a valid image) to the chosen slot.
>=20
> (5) Repeat steps (2)-(4) for the other slot.
>=20
> It's not possible to simply write the whole MLO in one go, especially
> not when updating the 128K slot, because an interruption after the
> first sector is written would make the ROM code believe the image is
> valid.
>=20
> But this only caters for SPL itself; regardless of where SPL was
> loaded from, it would go on to load U-Boot proper from
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR. So in order to update the whole
> bootloader, we need to teach SPL to use a
> different offset for U-Boot proper depending on where SPL itself was
> loaded from (*). With that, the update procedure is just amended by a step
>=20
> (3a) Write U-Boot proper to the offset corresponding to the SPL slot
> being updated.
>=20
> We can know (*) because the ROM code sets a new bit in a certain
> "trace vector" before each successive attempt.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  arch/arm/mach-omap2/Kconfig       | 37 +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/boot-common.c | 31 ++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)

Very interesting. I think the only thing really missing is that this
needs to be covered under doc/ as well.

--=20
Tom

--Jj/PId5DS6jYJdgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXJOjgAKCRAr4qD1Cr/k
CuX1AP0V0WnirAPKoN2/+TbojTZPuDW4vNHJpZ9nzpykE9KsdgD/RwtlC+qokC/D
EddpZkTl58ua7TVS619oH0fKQ9aOYQ8=
=anng
-----END PGP SIGNATURE-----

--Jj/PId5DS6jYJdgJ--
