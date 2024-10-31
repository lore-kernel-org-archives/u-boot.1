Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7C6D767E8
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 16:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D178929D;
	Thu, 31 Oct 2024 17:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n8YZLEUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BE088E5C; Thu, 31 Oct 2024 17:56:39 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D909588E6B
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 17:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6e5e5c43497so9555067b3.3
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730393796; x=1730998596; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dIFM+t9iC7/CgzS7x6Ugdq1rTyGVbYuWmeSD1KCJLDU=;
 b=n8YZLEUS9jX1H8LYfhkPpECTMDhNn6JCjj5K9cXAyLKVTl6if5jCJ3PhYxZNbGuW4m
 g9sYQ9pQriLax6oEbGlft0+7cBHSUJMe830PUiI8ejaNbIKHxVmzLwDkOqj1EOqPB3tp
 pP71aLM3cpB0hgl+Bu/bBbo9r8ETWEkgUHyio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730393796; x=1730998596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIFM+t9iC7/CgzS7x6Ugdq1rTyGVbYuWmeSD1KCJLDU=;
 b=GAX4UI0z4/5O4n0TwjugrEkPp+X4tCqZd4j8NFCfHMX2XazMRSAz8LSpNprwmWCqqs
 Hkes5AcQLXuqk8Hr6tv0Mz5JWfuBLO5r/v8onlukZqYLphg4RfVleyAaHYNnVn2m7mEm
 BYEmzITc5VHdAEVSq/RTYaDgyekRBnYTBs4jMyf/Hn0SHVs3t7DqGysVfX9D74kYW1ZX
 BYM6DJcZeiu5YgwUTBRMsYg9IN2ZvI40vcoXPYYaCtuGiObxOlk9cNSxQCAnQ/hCvHjT
 4UulwMsmKIc08o7jLQ135CszbdhW0+eabJHSAB3pMtd+0bIgaXo8v7afMBQuTZS9Ho8g
 2w2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2RXscehdE66X+raHnPmbo7KfPb5hjESY9JDi6W8f4y5JYiNlpTRNOSl06Ml1lxUkCc+ZL13Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyzkAjyx17eezqOUGdUTdzYGfWuoZwKZ3G+uDY+s/nJEK+QlqT3
 S4E8DnsFtFPsAc5b8FKJ8Ex54UmHNuYXmFRaoNygWw/WsQtSuyDQ2oo0I5B67Is=
X-Google-Smtp-Source: AGHT+IGgbuo/3KKwxsrJoQMnO6bw40ozwBzmNJ8f/QDwjwu0STJNzOBtfs3GB/Ixu6tMMIrs23TSTA==
X-Received: by 2002:a05:690c:4c01:b0:6e3:14b0:ff86 with SMTP id
 00721157ae682-6ea524e28c9mr42628217b3.27.1730393795581; 
 Thu, 31 Oct 2024 09:56:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad162557sm9231311cf.66.2024.10.31.09.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 09:56:34 -0700 (PDT)
Date: Thu, 31 Oct 2024 10:56:31 -0600
From: Tom Rini <trini@konsulko.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BB?=
 =?utf-8?Q?TCH_08=2F17=5D_scmi=5Fprotocols?= =?utf-8?Q?=3A?= update struct
 scmi_base_discover_list_protocols_out
Message-ID: <20241031165631.GT2558755@bill-the-cat>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-8-f640c8f3bc1b@oss.nxp.com>
 <20241016180716.GD4959@bill-the-cat>
 <PAXPR04MB9644CB49C0E764D7F4869C8CE2552@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ASsOesTox7szedEu"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9644CB49C0E764D7F4869C8CE2552@PAXPR04MB9644.eurprd04.prod.outlook.com>
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


--ASsOesTox7szedEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 09:57:27AM +0000, Alice Guo (OSS) wrote:
> Hi Tom,
>=20
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tom Rini <trini@konsulko.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B410=E6=9C=8817=E6=97=
=A5 2:07
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > =E6=8A=84=E9=80=81: Lukasz Majewski <lukma@denx.de>; Sean Anderson
> > <seanga2@gmail.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
> > <festevam@gmail.com>; Marek Vasut <marex@denx.de>; dl-uboot-imx
> > <uboot-imx@nxp.com>; u-boot@lists.denx.de; Ye Li <ye.li@nxp.com>; Alice
> > Guo <alice.guo@nxp.com>
> > =E4=B8=BB=E9=A2=98: [EXT] Re: [PATCH 08/17] scmi_protocols: update stru=
ct
> > scmi_base_discover_list_protocols_out
> >=20
> > On Wed, Oct 16, 2024 at 03:18:01PM +0800, Alice Guo wrote:
> > > From: Ye Li <ye.li@nxp.com>
> > >
> > > @protocols is an array of protocol identifiers that are implemented,
> > > excluding the Base protocol. The number of elements of @protocols is
> > > specified by callee-side. Currently, set it to 4 is enough for i.MX95.
> >=20
> > This needs to be in the file too for documentation generation to pick u=
p, thanks.
>=20
> May I ask which file you mention?

The file you were changing in this patch.

--=20
Tom

--ASsOesTox7szedEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjtr8ACgkQFHw5/5Y0
tyxWDgv/T8lo5V5b3LRLyLoXgKOo8ALRoUnKRq/Nd2Swq32/o+fzkBGB2r6eSHal
AZZPmRuMPcVJwvmaJkUdl+aZEFJhvda0iqCG5mGHVp/zFbMwpMW1aw8szllK/1bd
hBG5JqzAskB8s1t6L67JYJLETuMZlL94E5q9Hl3ZOav4YgGW/EOT6VxP6NobWWtc
KNKtoW4waVzOPXfY2D2d/oWTYjdQ6JC2NTOb7WnQYC7KqXzXtl735NFQH/uPgIds
qll+KOE9PncqMTmVKCy8RTvGHcDBxY3FpQqqZ9jAT6YSAR5jPYHlgSYH08Qnx75q
HgzkO7n9/aaE7Uzair9llMwEjEXMojzRO8hm0CXLyQ8wSXlIRCj8I6cYw8IE5Uve
RRCCtKI8m2BlAjfbys0uli0YVFBuVVwhbDts9vUJuR/VY3VrQ+ZyIfec2c934xT5
MNX5PkXh4nSRFyF7d/HW/uk1FIv+BoL7jEC7p5mcHvH2XDL4AAnlOlu+qMtLlsy5
zcO+Ozqd
=wXxL
-----END PGP SIGNATURE-----

--ASsOesTox7szedEu--
