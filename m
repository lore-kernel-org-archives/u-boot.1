Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0733DC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 22:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CC3841BC;
	Wed, 17 Jul 2024 00:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=johnthomson.fastmail.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fastmail.com.au header.i=@fastmail.com.au header.b="RksCo7Cl";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDOwELi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2512788739; Tue, 16 Jul 2024 22:32:22 +0200 (CEST)
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com
 [103.168.172.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662E088126
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=johnthomson.fastmail.com.au
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=lists@johnthomson.fastmail.com.au
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id 4490013811CE;
 Tue, 16 Jul 2024 16:32:17 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
 by compute2.internal (MEProxy); Tue, 16 Jul 2024 16:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1721161937; x=1721248337; bh=anvRylOc9xXD1gDfRBOCQ5p/bFINRvdN
 QZCQBs8lZ2w=; b=RksCo7ClkbIUcrxmnVkptLjJNr07jzkgZtsZnIAvWVj6CA54
 Fl921aI+NuQvzDRsSC/7t0yAH4o36fUD4OjzNAanNGoPTXshHxSaqXHTOqr7MLXp
 cRtqMG0nqO6H9BrpRrEUJ2B1G3aWIRWYxxZ7rm/AiKBa9+HYSs7NmVwtjEfOCWWt
 w+bjEMFBnZVUSehfUBtI2Hw7FtSX8awV4M0Q59SvIlhsAp58HylnkXLM6kd1VIre
 jiGFK83RJNQzpAsN6pRo12eICBrNB94HtBs/Npnb9ofwIxF4B1i/+xMWNyIeGXNC
 9pRzKChDjwSKXCtz2h5fFVL5oNxiV0sODCecpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721161937; x=
 1721248337; bh=anvRylOc9xXD1gDfRBOCQ5p/bFINRvdNQZCQBs8lZ2w=; b=V
 DOwELi5tUIzED6NWnzwwU7rPqg38opcICmb+Y/znTkZ7z22ExF9zivWmsupap+LT
 xD/vxf7RqJAFgcbwUNShR+eRF24xjMCjhwh3yqouxrkXM/h60OjLdYaq+8CIg5n2
 Br+Duhz7OtshlufQwa3jmnSUfEorILjEw8mPouZjhLCYeyjYg2Yhm4XkdoSldc/c
 qEvxOlvcMUeQzMeBANGA+69mpLSmNihrbYGXfKDtvMDRYg+YED5y5/4sLYorzpfS
 Pc9+Qpypxd4QXKvsKfLYGtgc4NrZ8A3/HvY0z5XXtzu9je/Ovgjo9V6gROY+R5Df
 OrlHNrDWVa59hAIV3hmLw==
X-ME-Sender: <xms:z9iWZolz84gy7kbaNKZAMv3vbdG-B0TaKe7YMDwQONQbAWUjrNjSzQ>
 <xme:z9iWZn1jt6E8UgGOApcFZR6-hChpbD4KC9Zx6nhJN5CtrFZ4nZt3ddl7XFnJ36YCx
 T7MiN88WKo1JU2OKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggddugeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ohhhnhcuvfhhohhmshhonhdfuceolhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrsh
 htmhgrihhlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepheffvdeufeegkefgtedu
 ieejgedtudefueeugfdtvdeuheefkeegteejvefgteefnecuffhomhgrihhnpehkvghrnh
 gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrg
 hu
X-ME-Proxy: <xmx:z9iWZmoCFLN_4FZ3dcv--ijGLTUDQaZLMTwZWLkZu0WFapS1k-_y4Q>
 <xmx:z9iWZkmvS6TXdyeVP8UzPdnjBEd6Mv17QfR2ifXBJTLXsMAqpAMmQA>
 <xmx:z9iWZm38RBV7epcYQz22lM8ix5P_c6RebNqd-NUP7-QTOr4XQF86Tg>
 <xmx:z9iWZrsEjMTYEHq4YLqGlCLyxXERuWLnanbWdSLPogbvw5Himnk_XQ>
 <xmx:0diWZp1iAOnepBA37gGgbCvJ2Jcognf_Fso9x8LYv5WCp0XQcFSdPzAy>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9E5C32A20077; Tue, 16 Jul 2024 16:32:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <c8135f59-0138-48a7-baf8-c910a458f5b1@app.fastmail.com>
In-Reply-To: <20240715135434.24992-2-zajec5@gmail.com>
References: <20240715135434.24992-1-zajec5@gmail.com>
 <20240715135434.24992-2-zajec5@gmail.com>
Date: Tue, 16 Jul 2024 20:31:55 +0000
From: "John Thomson" <lists@johnthomson.fastmail.com.au>
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
 "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Michael Walle" <michael@walle.cc>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: layouts: add U-Boot env layout
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 17 Jul 2024 00:04:11 +0200
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

On Mon, 15 Jul 2024, at 13:54, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> diff --git a/drivers/nvmem/layouts/u-boot-env.c=20
> b/drivers/nvmem/layouts/u-boot-env.c
> new file mode 100644
> index 000000000000..5217dc4a52f8
> --- /dev/null
> +++ b/drivers/nvmem/layouts/u-boot-env.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 - 2023 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.p=
l>
> + */
> +
> +#include <linux/crc32.h>
> +#include <linux/etherdevice.h>
> +#include <linux/export.h>
> +#include <linux/if_ether.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include "u-boot-env.h"
> +
> +struct u_boot_env_image_single {
> +	__le32 crc32;
> +	uint8_t data[];
> +} __packed;
> +
> +struct u_boot_env_image_redundant {
> +	__le32 crc32;
> +	u8 mark;
> +	uint8_t data[];
> +} __packed;
> +
> +struct u_boot_env_image_broadcom {
> +	__le32 magic;
> +	__le32 len;
> +	__le32 crc32;
> +	DECLARE_FLEX_ARRAY(uint8_t, data);
> +} __packed;
> +
> +static int u_boot_env_read_post_process_ethaddr(void *context, const=20
> char *id, int index,
> +						unsigned int offset, void *buf, size_t bytes)
> +{
> +	u8 mac[ETH_ALEN];
> +
> +	if (bytes !=3D 3 * ETH_ALEN - 1)
> +		return -EINVAL;
> +
> +	if (!mac_pton(buf, mac))
> +		return -EINVAL;
> +
> +	if (index)
> +		eth_addr_add(mac, index);
> +
> +	ether_addr_copy(buf, mac);
> +
> +	return 0;
> +}
> +
> +static int u_boot_env_parse_cells(struct device *dev, struct=20
> nvmem_device *nvmem, uint8_t *buf,
> +				  size_t data_offset, size_t data_len)
> +{
> +	char *data =3D buf + data_offset;
> +	char *var, *value, *eq;
> +
> +	for (var =3D data;
> +	     var < data + data_len && *var;
> +	     var =3D value + strlen(value) + 1) {
> +		struct nvmem_cell_info info =3D {};
> +
> +		eq =3D strchr(var, '=3D');
> +		if (!eq)
> +			break;
> +		*eq =3D '\0';
> +		value =3D eq + 1;
> +
> +		info.name =3D devm_kstrdup(dev, var, GFP_KERNEL);
> +		if (!info.name)
> +			return -ENOMEM;
> +		info.offset =3D data_offset + value - data;
> +		info.bytes =3D strlen(value);
> +		info.np =3D of_get_child_by_name(dev->of_node, info.name);
> +		if (!strcmp(var, "ethaddr")) {
> +			info.raw_len =3D strlen(value);
> +			info.bytes =3D ETH_ALEN;
> +			info.read_post_process =3D u_boot_env_read_post_process_ethaddr;
> +		}
> +
> +		nvmem_add_one_cell(nvmem, &info);
> +	}
> +
> +	return 0;
> +}
> +
> +int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
> +		     enum u_boot_env_format format)
> +{
> +	size_t crc32_data_offset;
> +	size_t crc32_data_len;
> +	size_t crc32_offset;
> +	__le32 *crc32_addr;
> +	size_t data_offset;
> +	size_t data_len;
> +	size_t dev_size;
> +	uint32_t crc32;
> +	uint32_t calc;
> +	uint8_t *buf;
> +	int bytes;
> +	int err;
> +
> +	dev_size =3D nvmem_dev_size(nvmem);
> +
> +	buf =3D kzalloc(dev_size, GFP_KERNEL);
> +	if (!buf) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	bytes =3D nvmem_device_read(nvmem, 0, dev_size, buf);
> +	if (bytes < 0) {
> +		err =3D bytes;
> +		goto err_kfree;
> +	} else if (bytes !=3D dev_size) {
> +		err =3D -EIO;
> +		goto err_kfree;
> +	}
> +
> +	switch (format) {
> +	case U_BOOT_FORMAT_SINGLE:
> +		crc32_offset =3D offsetof(struct u_boot_env_image_single, crc32);
> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_single, data=
);
> +		data_offset =3D offsetof(struct u_boot_env_image_single, data);
> +		break;
> +	case U_BOOT_FORMAT_REDUNDANT:
> +		crc32_offset =3D offsetof(struct u_boot_env_image_redundant, crc32);
> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_redundant,=20
> data);
> +		data_offset =3D offsetof(struct u_boot_env_image_redundant, data);
> +		break;
> +	case U_BOOT_FORMAT_BROADCOM:
> +		crc32_offset =3D offsetof(struct u_boot_env_image_broadcom, crc32);
> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_broadcom, da=
ta);
> +		data_offset =3D offsetof(struct u_boot_env_image_broadcom, data);
> +		break;
> +	}

Could we error somewhere if bytes or dev_size is < crc32_data_offset
or alternatively if bytes is zero (above, beside bytes !=3D dev_size)?
Detailed here: https://lore.kernel.org/lkml/20240612031510.14414-1-git@j=
ohnthomson.fastmail.com.au/
mtd partitioning can deliver a zero length partition (if misconfigured: =
Example u-boot partition starts beyond hardware NOR length).

> +	crc32_addr =3D (__le32 *)(buf + crc32_offset);
> +	crc32 =3D le32_to_cpu(*crc32_addr);
> +	crc32_data_len =3D dev_size - crc32_data_offset;
> +	data_len =3D dev_size - data_offset;
> +
> +	calc =3D crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
> +	if (calc !=3D crc32) {
> +		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected:=20
> 0x%08x)\n", calc, crc32);
> +		err =3D -EINVAL;
> +		goto err_kfree;
> +	}
> +
> +	buf[dev_size - 1] =3D '\0';
> +	err =3D u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_le=
n);
> +
> +err_kfree:
> +	kfree(buf);
> +err_out:
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(u_boot_env_parse);
> +
> +static int u_boot_env_add_cells(struct nvmem_layout *layout)
> +{
> +	struct device *dev =3D &layout->dev;
> +	enum u_boot_env_format format;
> +
> +	format =3D (uintptr_t)device_get_match_data(dev);
> +
> +	return u_boot_env_parse(dev, layout->nvmem, format);
> +}
> +
> +static int u_boot_env_probe(struct nvmem_layout *layout)
> +{
> +	layout->add_cells =3D u_boot_env_add_cells;
> +
> +	return nvmem_layout_register(layout);
> +}
> +
> +static void u_boot_env_remove(struct nvmem_layout *layout)
> +{
> +	nvmem_layout_unregister(layout);
> +}
> +
> +static const struct of_device_id u_boot_env_of_match_table[] =3D {
> +	{ .compatible =3D "u-boot,env", .data =3D (void *)U_BOOT_FORMAT_SING=
LE, },
> +	{ .compatible =3D "u-boot,env-redundant-bool", .data =3D (void=20
> *)U_BOOT_FORMAT_REDUNDANT, },
> +	{ .compatible =3D "u-boot,env-redundant-count", .data =3D (void=20
> *)U_BOOT_FORMAT_REDUNDANT, },
> +	{ .compatible =3D "brcm,env", .data =3D (void *)U_BOOT_FORMAT_BROADC=
OM, },
> +	{},
> +};
> +
> +static struct nvmem_layout_driver u_boot_env_layout =3D {
> +	.driver =3D {
> +		.name =3D "u-boot-env-layout",
> +		.of_match_table =3D u_boot_env_of_match_table,
> +	},
> +	.probe =3D u_boot_env_probe,
> +	.remove =3D u_boot_env_remove,
> +};
> +module_nvmem_layout_driver(u_boot_env_layout);
> +
> +MODULE_AUTHOR("Rafa=C5=82 Mi=C5=82ecki");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);


--=20
  John Thomson
