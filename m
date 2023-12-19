Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44549C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 07:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 917338709C;
	Tue, 19 Dec 2023 08:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="A1zyJPqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B90870B7; Tue, 19 Dec 2023 08:55:24 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E58BC87053
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 238FDC000B;
 Tue, 19 Dec 2023 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1702972520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZXHfcE8iV40Vx6zOQ3A1z/zKCAFk19AQvCsz5cKV2k=;
 b=A1zyJPqeBC5Dif3oK8hakbVcuQQHQwi4BYa/8qZANOzdws66iSlDfaUPaaafuOpKMWy4SG
 wWAve1Gjpm1bvkK/QOcA9o6oOLuGbqJgls3NxwxHH9oc/1MCqORHre2eYxNZJQlO/ZzMsJ
 5AK9lnXgpjgNJhK7zfnrg4vKz5ciaiIijDNSkByHynUWpwDIoxD/S/RKT72TPy6wfrCb4C
 pburPoxHz4kVzOaDj0U0hRI3ftpc+6ARkMfb+//JIfPgZ9sn4kHuPZDF/cROuT8IIBfLBh
 z1TWk1BWyIp/706xhpccd+LpdbId0WNdYwxqvXv/QqHLOofdYVwwgROrW+s06A==
Date: Tue, 19 Dec 2023 08:55:17 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle
 <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 4/4] nvmem: layouts: add U-Boot env layout
Message-ID: <20231219085517.4b6ec4fc@xps-13>
In-Reply-To: <13bc621c-5fcb-4710-912c-06e3e80d7337@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
 <20231218133722.16150-4-zajec5@gmail.com>
 <20231218152116.59d59bad@xps-13>
 <13bc621c-5fcb-4710-912c-06e3e80d7337@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Mon, 18 Dec 2023 23:10:20 +0100:

> On 18.12.2023 15:21, Miquel Raynal wrote:
> > Hi Rafa=C5=82,
> >=20
> > zajec5@gmail.com wrote on Mon, 18 Dec 2023 14:37:22 +0100:
> >  =20
> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >> This patch moves all generic (NVMEM devices independent) code from NVM=
EM
> >> device driver to NVMEM layout driver. Then it adds a simple NVMEM layo=
ut
> >> code on top of it.
> >>
> >> Thanks to proper layout it's possible to support U-Boot env data stored
> >> on any kind of NVMEM device.
> >>
> >> For backward compatibility with old DT bindings we need to keep old
> >> NVMEM device driver functional. To avoid code duplication a parsing
> >> function is exported and reused in it.
> >>
> >> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >> --- =20
> >=20
> > I have a couple of comments about the original driver which gets
> > copy-pasted in the new layout driver, maybe you could clean these
> > (the memory leak should be fixed before the migration so it can be
> > backported easily, the others are just style so it can be done after, I
> > don't mind).
> >=20
> > ...
> >  =20
> >> +int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
> >> +		     enum u_boot_env_format format)
> >> +{
> >> +	size_t crc32_data_offset;
> >> +	size_t crc32_data_len;
> >> +	size_t crc32_offset;
> >> +	size_t data_offset;
> >> +	size_t data_len;
> >> +	size_t dev_size;
> >> +	uint32_t crc32;
> >> +	uint32_t calc;
> >> +	uint8_t *buf;
> >> +	int bytes;
> >> +	int err;
> >> +
> >> +	dev_size =3D nvmem_dev_size(nvmem);
> >> +
> >> +	buf =3D kcalloc(1, dev_size, GFP_KERNEL); =20
> >=20
> > Out of curiosity, why kcalloc(1,...) rather than kzalloc() ? =20
>=20
> I used kcalloc() initially as I didn't need buffer to be zeroed.

I think kcalloc() initializes the memory to zero.
https://elixir.bootlin.com/linux/latest/source/include/linux/slab.h#L659

If you don't need it you can switch to kmalloc() instead, I don't mind,
but kcalloc() is meant to be used with arrays, I don't see the point of
using kcalloc() in this case.

>=20
> I see that memory-allocation.rst however says:
>  > And, to be on the safe side it's best to use routines that set memory =
to zero, like kzalloc(). =20
>=20
> It's probably close to zero cost to zero that buffer so it could be kzall=
oc().
>=20
>=20
> >> +	if (!buf) {
> >> +		err =3D -ENOMEM;
> >> +		goto err_out; =20
> >=20
> > We could directly return ENOMEM here I guess.
> >  =20
> >> +	}
> >> +
> >> +	bytes =3D nvmem_device_read(nvmem, 0, dev_size, buf);
> >> +	if (bytes < 0)
> >> +		return bytes;
> >> +	else if (bytes !=3D dev_size)
> >> +		return -EIO; =20
> >=20
> > Don't we need to free buf in the above cases?
> >  =20
> >> +	switch (format) {
> >> +	case U_BOOT_FORMAT_SINGLE:
> >> +		crc32_offset =3D offsetof(struct u_boot_env_image_single, crc32);
> >> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_single, data=
);
> >> +		data_offset =3D offsetof(struct u_boot_env_image_single, data);
> >> +		break;
> >> +	case U_BOOT_FORMAT_REDUNDANT:
> >> +		crc32_offset =3D offsetof(struct u_boot_env_image_redundant, crc32);
> >> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_redundant, d=
ata);
> >> +		data_offset =3D offsetof(struct u_boot_env_image_redundant, data);
> >> +		break;
> >> +	case U_BOOT_FORMAT_BROADCOM:
> >> +		crc32_offset =3D offsetof(struct u_boot_env_image_broadcom, crc32);
> >> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_broadcom, da=
ta);
> >> +		data_offset =3D offsetof(struct u_boot_env_image_broadcom, data);
> >> +		break;
> >> +	}
> >> +	crc32 =3D le32_to_cpu(*(__le32 *)(buf + crc32_offset)); =20
> >=20
> > Looks a bit convoluted, any chances we can use intermediate variables
> > to help decipher this?
> >  =20
> >> +	crc32_data_len =3D dev_size - crc32_data_offset;
> >> +	data_len =3D dev_size - data_offset;
> >> +
> >> +	calc =3D crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
> >> +	if (calc !=3D crc32) {
> >> +		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n=
", calc, crc32);
> >> +		err =3D -EINVAL;
> >> +		goto err_kfree;
> >> +	}
> >> +
> >> +	buf[dev_size - 1] =3D '\0';
> >> +	err =3D u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_le=
n);
> >> +	if (err)
> >> +		dev_err(dev, "Failed to add cells: %d\n", err); =20
> >=20
> > Please drop this error message, the only reason for which the function
> > call would fail is apparently an ENOMEM case.
> >  =20
> >> +
> >> +err_kfree:
> >> +	kfree(buf);
> >> +err_out:
> >> +	return err;
> >> +}
> >> +EXPORT_SYMBOL_GPL(u_boot_env_parse);
> >> +
> >> +static int u_boot_env_add_cells(struct device *dev, struct nvmem_devi=
ce *nvmem)
> >> +{
> >> +	const struct of_device_id *match;
> >> +	struct device_node *layout_np;
> >> +	enum u_boot_env_format format;
> >> +
> >> +	layout_np =3D of_nvmem_layout_get_container(nvmem);
> >> +	if (!layout_np)
> >> +		return -ENOENT;
> >> +
> >> +	match =3D of_match_node(u_boot_env_of_match_table, layout_np);
> >> +	if (!match)
> >> +		return -ENOENT;
> >> +
> >> +	format =3D (uintptr_t)match->data; =20
> >=20
> > In the core there is currently an unused helper called
> > nvmem_layout_get_match_data() which does that. I think the original
> > intent of this function was to be used in this driver, so depending on
> > your preference, can you please either use it or remove it? =20
>=20
> The problem is that nvmem_layout_get_match_data() uses:
> layout->dev.driver

I'm surprised .driver is unset. Well anyway, please either fix the core
helper and use it or drop the core helper, because we have no user for
it otherwise?

> It doesn't work with layouts driver (since refactoring?) as driver is
> NULL. That results in NULL pointer dereference when trying to reach
> of_match_table.
>=20
> That is why I used u_boot_env_of_match_table directly.
>=20
> If you know how to fix nvmem_layout_get_match_data() that would be
> great. Do we need driver_register() somewhere in NVMEM core?
>=20


Thanks,
Miqu=C3=A8l
