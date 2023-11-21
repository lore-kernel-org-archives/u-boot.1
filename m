Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9962C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2011F875E3;
	Tue, 21 Nov 2023 20:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DjURh6oG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F4B875F5; Tue, 21 Nov 2023 20:24:48 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A6D875C7
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-421ae930545so36486211cf.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700594685; x=1701199485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bz/z3dEPztbmk5ykxv9WifzKYVnk8hbg/dlSrMvMti4=;
 b=DjURh6oGqerVY83apb55XLzfqh4eH9i012yjucjc9Q3M7gOjjq+68pikWRGDi25eCK
 iL7YHEaEF+oxBGuRJyKmCykwaYuFCP6TSMrmOrPQ8DvO7jYuRCCDeiD5/1hR+0X0A7j1
 PRbUY8cZEhPnsO2gtIqZxxmxPQgCiWUf4esho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700594685; x=1701199485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bz/z3dEPztbmk5ykxv9WifzKYVnk8hbg/dlSrMvMti4=;
 b=kDYYTQC8Cyfceaxu5OpO8qiooxzdU1H00rcdL7DTT+wj9QC18PZ5oWzFykbWg5CrFr
 CR/SpaOV6w2fYOasbF+Ln6FWGNWwMylhr+2Ig3r9xAVBpQeWvPpgVo6+Qlkbk/xFElEm
 leLwjcLUqIlHKpQL8CDq5cDAJ/YhDv9YhvvqilWSlyp4OFvcyil9LK68MDWH8wwCnCJm
 FroXn+M0ozm4ShnHuZeTPz0eJoO+CTTCb+k7oc3mxjtKQCpzsxr9xZ2gDfBFw9VYL7DX
 Vk2gNcWIQ6mkIUzVvLiu0iC8J/+DKbboMDgKaIHgNG7Cjv8oL5zR34I67oKo+eg9e6fd
 QyrA==
X-Gm-Message-State: AOJu0YxGTaKJs9/pEzxBqnP0LZVaGgp2qupM0obLCeocuXEJ0lJZbpgx
 lhOzuW88jzkbO/C6RSHw0N1wPQ==
X-Google-Smtp-Source: AGHT+IEQ7oagtJVTF9jiBU/JLq+0AX41W/Fce39vNCjX7tjTBItZIoWNumubelylwVoA1XYpN9tqWw==
X-Received: by 2002:ac8:7f4b:0:b0:421:b48d:af02 with SMTP id
 g11-20020ac87f4b000000b00421b48daf02mr83970qtk.19.1700594685112; 
 Tue, 21 Nov 2023 11:24:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 x11-20020ac8538b000000b0041818df8a0dsm3833705qtp.36.2023.11.21.11.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:24:44 -0800 (PST)
Date: Tue, 21 Nov 2023 14:24:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 14/21] mach-snapdragon: dynamic load addresses
Message-ID: <20231121192442.GF2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-14-9492198e0c15@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F3sQu6WnMr3co5xA"
Content-Disposition: inline
In-Reply-To: <20231121-b4-qcom-common-target-v1-14-9492198e0c15@linaro.org>
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


--F3sQu6WnMr3co5xA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 05:09:37PM +0000, Caleb Connolly wrote:

> Heavily inspired by Apple board code. Use the LMB allocator to configure
> load addresses at runtime, and implement a lookup table for selecting a
> devicetree.
>=20
> As some Qualcomm RBx boards have different RAM capacities and base
> addresses, it isn't possible to hardcode these regions.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
[snip]
> +#define KERNEL_COMP_SIZE	SZ_32M
> +#define SZ_96M			(SZ_64M + SZ_32M)
> +
> +#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
> +
> +/* Stolen from arch/arm/mach-apple/board.c */
> +int board_late_init(void)
> +{
> +	struct lmb lmb;
> +	u32 status =3D 0;
> +
> +	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> +
> +	/* We need to be fairly conservative here as we support boards with jus=
t 1G of TOTAL RAM */
> +	status |=3D env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_96M));
> +	status |=3D env_set_hex("loadaddr", addr_alloc(&lmb, SZ_64M));
> +	status |=3D env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
> +	status |=3D env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_96M));
> +	status |=3D env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_C=
OMP_SIZE));
> +	status |=3D env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
> +	status |=3D env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
> +	status |=3D env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));

First, with 1G total, we should I think be fine using SZ_128M and not
needing to add SZ_96M. Second, having worked on
https://patchwork.ozlabs.org/project/uboot/patch/20231119144338.630138-2-sj=
g@chromium.org/
a bit I think your sizes are a bit funny. We're looking at where to
decompress the provided Image file to and so 32M is too small. My
generic v6.6 Image is 40MB. One of those "would be nice" things to see
now that I've kicked things around a little was if all of our boot$foo
decompression logic just asked the lmb to give us a new region of
max-feasible-size for a Linux kernel (or we make it a choice between 64
or 128MB max supported kernel image). And further looking at the code
and matching it up with the function docs, it's even funkier than I had
thought, sigh.

And to try and be clear, the second is an ask, but the first is a change
request, those sizes are too small and inconsistent with supporting a
large uncompressed kernel.

--=20
Tom

--F3sQu6WnMr3co5xA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdA/AACgkQFHw5/5Y0
tyzMGwwAqK35TRexMKwA4Hvk+5J/IwIkWXB2X0HrnPVd+Xcc4wqe/okMUnM1hRdC
Es898XOoF83OgWMFVzxcRHt4h9ew295Lc3oVrZiugF4gfG3PH3+siEzXytDZFidg
O6yYTQMvMgtTU1QP6XRkYzLnckxSmRPO9lVSJSE6s3xQqgm0dnD+m1s6wthxrGYC
1VBwUygTq9SNSRTsG20rK9CM+O6mjFau6a2S8fICElCmbGrg8tqjxbEEqnjIZOb0
UzJPw+x4B3zF/mM7KJ6IuZY4qrO7oAwL/vvgrdnqT4DZ/87pNciXrzIDcfMLZAxg
CW8YNrHSHGyQXToIwBNpEsanJmo3X9KmOUGLXwaR67OsoCV2xAoCGj7mdShyBK29
ryzGktWLk+yfdX4RQWtSX3KFt4CiBt6E8kzr1INqA7vrutEvUlLtZeoNC/uoi+k0
2bKi0YJ9F6jzCCSR+ZTCYjcJNjUvYa8TKGt8ieSOAk0uSEm2O4HuaptKn11tYbK3
0kp04grO
=bjmE
-----END PGP SIGNATURE-----

--F3sQu6WnMr3co5xA--
