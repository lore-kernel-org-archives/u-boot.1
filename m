Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32F8E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 03:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C4C80602;
	Tue,  7 Jan 2025 04:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QQeI5MEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F9B80602; Mon,  6 Jan 2025 22:42:42 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 077F5801DB
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 22:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6dd43b08674so105964536d6.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 13:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736199759; x=1736804559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zAMwUJa4u/wwWkYBPVUIkgZghL9vDab5d4ilupSJlDg=;
 b=QQeI5MEvmYU0HOauoGJExXjdbf7xG20S2c07o6C6wQQAaMJDnnZULgU4oG1h8GZBTN
 xAsvS1Qt14WDQlQJRtNt3Tu/tCCpCbd9uoKrJ0p02+WTIJ11gjzTSIgxkF05fVHseEnq
 fZSpwDqzlV17wRr9Qo4CJfvoZEtrTy2sjXPBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199759; x=1736804559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAMwUJa4u/wwWkYBPVUIkgZghL9vDab5d4ilupSJlDg=;
 b=UGgCmcGJzoaPLAdShF/VfajORyqTVCM+KtidlyLBwZtGqD5u4h2Zgh7fYU7gifsp9f
 KLHZ3FDOte6QVPk9/eVFNnpvPlbHLi98WyF+5uTc27Tvd3/uewESUNUd5SVcQ8Rr+e6K
 OcVKzrAf/SYv/hfOkk7MceohZCKx48KIJwx/KUVhDCtYw0zCPoxVjXBAePh6PIe6FlNi
 MjQEm0rrsK9pHOUsdByg0v2MaOjGzr5jE6V5uhzjAHUy6uow8WIrIeX8fBLjpO7qlp8Y
 OBDbVqWIqXQD933A0z9UBOt53leWY9HyQyPs7JRIr6F5/bRK8IkOPhqiApR5nkC+F0wQ
 WJQA==
X-Gm-Message-State: AOJu0YxpwfA1O+/emISiit7pQpejgS5RHBP5hnzjAdOh+7CULOJPg07g
 RECYOiCj81vZIyj5L/Onotj57g4NvWbg5YUz4p4wvQr5tAxsdjfyzD5ZIAusKPI=
X-Gm-Gg: ASbGncudsmYS5iidhuucWGkEsRNnw56Y5fYBdArOiU8NUZ/NRxoTYilloxTyFHKhCSA
 ZHe2kYubhoZ41gj06hAQR6IlEqSEIOl8chbuROOnAgOj0b/QJfnm7So8m3OI45url6EXwipRedw
 EZ3JEyCoLJPFPLi8SjeSlffTb99N8zyXDAPYh+xRgdZx8jw+WRIfd0pZOrO3s8v5aVZhoqGH7pd
 RAv44OWglV55JILSCaqfOHoTWRM58IbuTbBH8uLHEJLXHZygZRME2Y=
X-Google-Smtp-Source: AGHT+IEF6QvQJ2P6u3KWWUAicPBcjoW4ac+Z/kMerMgeGu54bBuRNOhaAX2cDHCHiLc6BjoJVfuH1w==
X-Received: by 2002:a05:6214:21ea:b0:6d4:287d:b8d6 with SMTP id
 6a1803df08f44-6dd2332d05cmr885537936d6.18.1736199757339; 
 Mon, 06 Jan 2025 13:42:37 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea9d0sm174507926d6.7.2025.01.06.13.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 13:42:36 -0800 (PST)
Date: Mon, 6 Jan 2025 15:42:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Alex Shumsky <alexthreed@gmail.com>,
 Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Dragan Simic <dsimic@manjaro.org>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Watt <jpewhacker@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Levi Yun <yeoreum.yun@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v2 00/33] upl: Prerequite patches for updated spec
Message-ID: <20250106214227.GD3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L1J7Dyha+KCng+zX"
Content-Disposition: inline
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 07 Jan 2025 04:15:55 +0100
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


--L1J7Dyha+KCng+zX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 07:31:56AM -0700, Simon Glass wrote:

> The current UPL spec[1] has been tidied up and improved over the last
> year, since U-Boot's original UPL support was written.
>=20
> This series includes some prerequisite patches needed for the real UPL
> patches. It is split from [2]
>=20
> [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D438574&stat=
e=3D*
>=20
> Changes in v2:
> - Fix 'Emable' typo
> - Enable the command in cmd/Kconfig instead
> - Fix unbalanced {}
> - Add new patch to move x86 tables to use SZ macros
> - Use 4K instead of 4KB
> - Add new patch to enable bloblist on x86
> - Split this into its own function
> - Split prerequisite patches into their own series

One thing I don't see in here is how to pass a BLOBLIST_ALLOC from one
stage of U-Boot to another. Or did I overlook something?

--=20
Tom

--L1J7Dyha+KCng+zX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd8TkMACgkQFHw5/5Y0
tywxNgwAqKU6gdqlt5hsZLImoUko0eiUrd5qfSi9h3FlXq8XizDE/LMVzq/bl8ya
IsoxD8afbk6pA3h7l54cszGM/W2ipte0k/xBt6mHBERkaA4XSqPNdq0fCRoc+mCz
+EaY/WQaP5DV8/YU4tXrQHwfWd+rVtk2mm+auJDfAWEaQ2aEl4ArHFFo/DJY1VkK
hUXRYzQVo1zDBBNbUD51PsVGXtBtJtoN1MqLhoV3F4ZK/ay5COvfRVCfX1gDIw7x
a42SxRcv7EYZpCFpehUdWib7J1MZKiDzMXDIBTsLcmlzQKmv1GI+67yjrxr2K0iW
Aa/Ec6ORxPAk1RZg+T3NoHn3LukBeCw4D9kNrZMNadDoi6oks2PyNmD9j5msBL8J
4Pz3aPEGDmR9j9J3sDqF+xAlYGvRE0/SNqhteJlVC0qeMsZSXJy2/flb3Nf2RIBp
0pqRSWRq+YcPa7STmFSZZ9RkVA71vdViPATBii5vYhb+3FV3GB7LmY/xhddrP6Ee
3RLXNajr
=VTsT
-----END PGP SIGNATURE-----

--L1J7Dyha+KCng+zX--
