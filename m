Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B7C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 13:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5892807D4;
	Sat, 26 Aug 2023 15:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="O5H+hHWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7241580812; Sat, 26 Aug 2023 15:09:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCEE6803AC
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 15:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693055363; x=1693660163; i=xypron.glpk@gmx.de;
 bh=rwCNXgqEEs8jMpfxvgz+kT4StGdhMKaGwaP8fitR+X8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=O5H+hHWtU50PbZ5DgWvY7gKhW9aPlxliWTBrpi0aPGFmI1DJYGKMC6OSTwQliV2h38/cqUC
 IoZ01wtjJiYNOyVLvnnutewt4Xj7rqliX+KcNhT4vd2GcPSxb/aJ6btBqJFVtCFqu9Q6z3cTe
 vMWdMNqfkmg+//mheJzjBRZeyBjn0iQse7NbUsWdkVM33Pv0E8PgdNy7z9tjV7keERUS5OOy2
 rIZoObibxtwOOEeWBDVhO2Ux0jin32RzsYsb56s9sFKNvmW3Eze80xgcgI9OyA8S6xY5N72iJ
 hkeB9Ye4WYFHSmMTFVqQ54Eb+JvU6sW6umC5uk2XnGyijJ6dwaHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1pcmBl1x4U-016xNH; Sat, 26
 Aug 2023 15:09:23 +0200
Message-ID: <f9fc81a5-1505-4cb3-8b65-798ddf16e1aa@gmx.de>
Date: Sat, 26 Aug 2023 15:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pstore: Use root address-cells/size-cells as defaults for
 reserved-memory
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
References: <20230826121652.2487643-1-andrej.skvortzov@gmail.com>
Content-Language: en-US
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, Pavel Machek
 <pavel@ucw.cz>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Detlev Casanova <detlev.casanova@collabora.com>,
 =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230826121652.2487643-1-andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uIsjo9Bszdvv+9nNsylWURKstvGOXhnk221liZtBfZCsaD3RMRz
 3GtVjWk0OQmDvLPpK5LObGNRNjRKTA5XQI/fTW2czDshNeemHoGzf5ycRxr4PpjVPUtY96n
 iUvmYpkFmkYl/8lRJadaAmvZyZlCow84lgPI42V3X2qRXq4Df9i6/YoLu7zv4W/d6J7sfK/
 6tlPOtvYGLo/vYKTGFBFA==
UI-OutboundReport: notjunk:1;M01:P0:SzFa4WdLpTA=;uGCa95Cl90ClK2Z852XSelLmTPN
 hr9LSfa8+Fo3VXDtbnsQT7W41Cp9B89Fp9/AGDmYpZOheGMsGKihw4NAgeA8e9NvW9BSjs+HK
 zyJXl1lwlpmwyatJnLsazZCDbOZ2i2FD45D4GIS8XZqjBJ+MTln1B+qky729XCux8OXoeFB/Q
 Lj74Gt+rOl+HYYVBx8oMHBJfwY9nK59l+xVnzZHZ2SDi4JlWcB8YzwKqv7klysyixw0E0EA88
 S8bUhg6+oe+yqf5V2Y+oe2PDLqfFXcC1H/Ux2EZvvE5OGft7SyswCoG4K4ZatZIhkd6681HmZ
 v1dSU9JrX/IwajlbeytDihd5ZgbS3qu7xKdYBU7aOB33F/PCYxYQEhLL9zKBkp2i5HlgSzuvo
 gCvShYU4Ag5e56SLhLsnQGI5M4nt9kytDhsOtdEsHHMGton4PoncCiNiVWqfdjuwPtOs7gKJ+
 88CL0wHXFsMVWkv9nLEfhzw6DyNRu4PyeqFHW2Uvj+ZuzDuISWyQ97T3Q1JCjS30HAdtPRBsz
 1BRKiPV+qV2NEULk2a8dugym2MRVDgnAarqv+7tVqh0S3xjhPM82VtVfGn1cJ2Lq48+AJaZ6W
 +1xtbMBMkhoBoYUCt336kC1dxBn6oTr3bQMbnMxhc4PvLnY0yA0LUaH+lO+mUmJgScrnYNJxN
 FJZn6YiLf6XsNMmN4ocxBZM0MgjYXxcciLTuh2PYp5GTpDAak+IGdQQlpeHQVYZvKiPcFr6dw
 603UbTeRDfxr8WVgNfQVAR2K7Rhq+pr+UKwyyiwUN2syQQgU2mcIt9Wm0OkfdaY/uVf7KXT7r
 MqWvLlvQrfS6Enod7B20A8+fkFXJIl2SNnH3pLYZmEeVWm1CMCAag40X4Y/CEDz6u6aAG8jRa
 GNA3bim2k73JBLAXu/3q7dFlKS7mOmEwLf18oKaoFyfIMZ66Q+2ydyhWp5DyiqKSY2PqKLeVU
 sEdRgZ/UCfPRYuXZohjw5uEM/JE=
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

On 8/26/23 14:16, Andrey Skvortsov wrote:
> u-boot adds reserve-memory node, if it's missing, with following
> properties:
>
> ```
>      reserved-memory {
>           #address-cells =3D <2>;
>           #size-cells =3D <2>;

This defines the size of cells for the children of reserved-memory and
and for the ranges property. If you set the cell sizes to 1 you can no
longer encode 64 bit addresses.

>           ranges;
>      }
> ```
>
> But with these default address-cells and size-cells values, pstore
> isn't working on A64. Root node for A64 defines 'address-cells' and
> 'size-cells' as 1.
>
> dtc complains if reserved-memory has different address-cells and
> size-cells.
>
> ```
>       Warning (ranges_format): /reserved-memory:ranges: empty "ranges"
>       property but its #address-cells (2) differs from / (1)

I cannot find any such requirement in the Devicetree Specification 1.4.
Is this a dtc bug?

> ```
>
> This patch takes into account address-cells and size-cells of the root
> node and uses them as values for new reserved-memory node.

Reservations may be above 4 GiB. How does your patch consider this?

Best regards

Heinrich

>
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>   cmd/pstore.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/pstore.c b/cmd/pstore.c
> index cd6f6feb2f..9795eea2db 100644
> --- a/cmd/pstore.c
> +++ b/cmd/pstore.c
> @@ -486,6 +486,8 @@ void fdt_fixup_pstore(void *blob)
>   {
>   	char node[32];
>   	int  nodeoffset;	/* node offset from libfdt */
> +	u32 addr_cells_root;
> +	u32 size_cells_root;
>   	u32 addr_cells;
>   	u32 size_cells;
>
> @@ -495,6 +497,8 @@ void fdt_fixup_pstore(void *blob)
>   		log_err("fdt_path_offset() returned %s\n", fdt_strerror(nodeoffset))=
;
>   		return;
>   	}
> +	addr_cells_root =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0, =
"#address-cells", 2);
> +	size_cells_root =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0, =
"#size-cells", 2);
>
>   	nodeoffset =3D fdt_find_or_add_subnode(blob, nodeoffset, "reserved-me=
mory");
>   	if (nodeoffset < 0) {
> @@ -503,8 +507,10 @@ void fdt_fixup_pstore(void *blob)
>   		return;
>   	}
>
> -	addr_cells =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#add=
ress-cells", 2);
> -	size_cells =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#siz=
e-cells", 2);
> +	addr_cells =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0,
> +						  "#address-cells", addr_cells_root);
> +	size_cells =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0,
> +						  "#size-cells", size_cells_root);
>   	fdt_setprop_u32(blob, nodeoffset, "#address-cells", addr_cells);
>   	fdt_setprop_u32(blob, nodeoffset, "#size-cells", size_cells);
>

