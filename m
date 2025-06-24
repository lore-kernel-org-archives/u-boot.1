Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1665C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 21:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F1782B18;
	Tue, 24 Jun 2025 23:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uH28p9vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90FCF82C84; Tue, 24 Jun 2025 23:01:26 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA5F803CC
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 23:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6119cd1a154so132391eaf.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750798880; x=1751403680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CJ2QHKepsjStDlqf2GWzQ84CwEfFi94/Fx5ybmOfkWI=;
 b=uH28p9vq9hNrehIPdENYnolSmT5J3PuMK5mpWH3VeIGlgSvTmklHw1Q4Hax9PzvtLN
 AU2+t4VnRupze6qmIxBXiM7dJUH2Nygl+yEWlHndm4CP5r12LQkkL4F0wNPrlEola1na
 s/bXgVF5CKFeY0Bxdup/gZ+vsd13baUXIrn+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750798880; x=1751403680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJ2QHKepsjStDlqf2GWzQ84CwEfFi94/Fx5ybmOfkWI=;
 b=j3ODz1HwtbfeYuQFhAGOJXe26IbNJEDRTnbl5Yb4+8BMBVVk6vgyBkC5N3lI1Lajkx
 cy8XioQK9dlaPKZ4Wf/iyasndn/HOsmKcHTvKGohfWBAZhdYUNBIW1aeqEwva0brJ802
 13uf/pDWN6YAfiPMkLD+XbgPGgwyIamu0lObkQP6Jd4jeBNQzWmUNxY7qFqi7ad9Msgl
 0znsu0/JV8SH8D3XZS61zjkhI0jO9u+Ct0hSQClIwKx3j3T4ryx+kIhbumelibjJ6Ybf
 phqxnoqaxZufB3oTfC16rB0Jph3UYd/WULJUYZ6PuvTNbHAgqPBKjWkoJA7Bx4bUYN3S
 3i8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkD6sqkY/gKq9arL/RBolXHhVGJ77FRp8Ak+jIwb4epa2JP+0sTK6joeFOC2AYiuLiPASBg+M=@lists.denx.de
X-Gm-Message-State: AOJu0YxwEi+Afww9ndcg44894yhWM2RAdKd57Mhu0bRVSXzjVZm079hh
 ZuqU6/pUVeBvLslXNxFHiEMYOMSkD8YcNWQn67h8sHunB+hepg5p/Ak8sB/ijlLlWbM=
X-Gm-Gg: ASbGncu4gjJwtU/A9ILSdoB+Zq35p7D93cSHQW1VKKZwTymjJny/ouiJJThLosTUbTM
 YX6sMMO/ebJ7FSIM6yuoxtgbm98WkDwgFwazBhLhYS8sYE/XCri9CaLmrn3akiPewjX5s3YV4Bm
 HHYB7w8s6wOQj1ddKaQnTlKkA6Q8w/7KLtDzudAkMZ/lP9wRdGbcoet4Sezi+0hdvWVJolovaGi
 s2AtaT/AZSneQxWArq/AuYa9cVa9kuFkkfXM8+tmcVC6YtwFztjp+xWdG/w4iB8u/26JbpfI7be
 fvO5XMrczr7XNOSfh1gf1FGdILz6GbJgaJqfPjN4gYMfAyENm96JIynRXoEo+7s6N79Dg58gF9M
 A1fXM5CYIurSDgpnga+zf99o=
X-Google-Smtp-Source: AGHT+IGi7ITqpc9FGVrAFz5ES0Yg8Z2PwBLqkOfn8rPQQXC+lwU3ZRuaB+wfR72vfONi/NqpMYvDUA==
X-Received: by 2002:a05:6870:ae8d:b0:296:bbc8:4a82 with SMTP id
 586e51a60fabf-2efb23d997fmr649799fac.27.1750798879451; 
 Tue, 24 Jun 2025 14:01:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee8a8e1e0dsm2270411fac.30.2025.06.24.14.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 14:01:18 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:01:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 uboot-imx@nxp.com, albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
Message-ID: <20250624210116.GL4003484@bill-the-cat>
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tf8KT9JEYit9Vkue"
Content-Disposition: inline
In-Reply-To: <20250624204700.972663-2-lukma@denx.de>
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


--tf8KT9JEYit9Vkue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:47:00PM +0200, Lukasz Majewski wrote:

> The commit e8a9521e649f
> ("vf500/vf610: synchronise device trees with linux")
> has synchronized U-Boot's DTS with v5.19 Linux kernel.
> It turned out that in Linux's upstream iomuxc node description the
> fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP's Vybrid
> SoC was not working properly.
>=20
> As by default the mux mask was set to 0, the vf610 based boards (like
> BK4) were bricked, due to misconfiguration of gpio at early boot stage.
>=20
> The fix for all vf610 based boards is to introduce vfxxx-u-boot.dtsi file
> with 'fsl,mux_mask' property provided and include it in boards' specific
> U-Boot adjustment files (like vf610-bk4r1-u-boot.dtsi).
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
>  arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi

It looks like this is still missing upstream, so what's the status on
that? Thanks.

--=20
Tom

--tf8KT9JEYit9Vkue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhbEhgACgkQFHw5/5Y0
tyy04gv/Rt4y4cJzHbdumXDv5yeY2twOY3QbodI3tGXVbRNHeY45F4Fi2ju7crR4
0MJK2INdF8CPD8kud8GAuoCcSDtY5SfQpkViPWsgDF6/sVvnXyW8nmDSX+Fjvdr/
0QcJL+BO0Qrm7BJmZm4tIknntSxa9uc1gt30rQjadfxMDeK6q2pCgUFHjwstMWIw
TfmoXZ6kbtzeo6JKqMnEhotebZNvimI5JTaD3t5ddFElduWQt4kNEpGAWR4i5ibB
WOy+32RsbFG4c43mzI53iTe/Y8vvGXeeuuClpwzYUuTQyb0FaW1+VV4gPjIfZa33
deUdEYShmgmA1gEz8Sb1CTnvfOF3qX6JWYED8a77bIcBpACmISYBNiYxQjjouqYM
NfcMJE4dQ01/myd5mUQVFiou6X5D2B2Lu1LDGRl7ZufLSAEx8/dWScbtXm+Nkkw1
4hj0Cl9+DNiDjBHjSrweXehmFGC1ofo/IiOzaqIGYkQCzvEUHcThROgp3EY8jGRw
CW9namDx
=Tv2U
-----END PGP SIGNATURE-----

--tf8KT9JEYit9Vkue--
