Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D88C54E68
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 19:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8BB28804F;
	Tue, 19 Mar 2024 20:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ts3UL4RZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB6608804F; Tue, 19 Mar 2024 20:04:51 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C5F87572
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 20:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-60a068e26d8so67581467b3.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710875088; x=1711479888; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=THmlAagmxuKz0ObkN1kbYlDPXEdjAL/WtKF9qItv5/U=;
 b=Ts3UL4RZkv9fr3Bd6J6ugSQpLTv0bkodVwclM57o++21l0ukxvvM4o27Krbz0TCatM
 tJ7vgC6bdQrvTpL/lCsDuSA29U5dI93ZvOPqqDkHqxo2MupObxGj9UJWB4HSeQ69mSb3
 2gzZ3wf2iiSKgtasC7QMTbcpehmQmj0dxhAnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710875088; x=1711479888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THmlAagmxuKz0ObkN1kbYlDPXEdjAL/WtKF9qItv5/U=;
 b=h938nah1LHLFzQNcX60KBqSF+ijg0GA2Zt6f4mpqXqWhIkeGUSvLBC8kk5z1zgK6KO
 Q8iX29Yis/L3VXLeK/cEsUF/H59TaCO2KH1f1bJJ5WByVhHTQr/elD0eQ8jby0NqNlMX
 fClv52PLv6tEQyZK3mZ9JX7cftTK3bHZkM6PO19iFAZ5cmYO3rL1oBpNmbo6AtwRj2Jc
 efnEuvHoAfnDHTPDRMh6VX6TwG2rzmzUmRhIuV8rSshwvoGI6L6Rb23pcOIk4ZLpGhTA
 fC6dZno4K3CrXlFc3ZETg4uBmxzIlpjoJKKr8faxHNdcAOALK4G94znqgfVSmZV0k4ys
 OyUQ==
X-Gm-Message-State: AOJu0Yxidnl5Tm+nxTe7KAPwlhvvb4spaIIEup47jJCXwweEqIuYkDdn
 8f3bKsDJGvDkeTxaYoZleLei8gPMt5MX7ZjUfQRcqDS6/e2iIMFw/tCWl9lUplg=
X-Google-Smtp-Source: AGHT+IEB9r4avXxST3jWEKPuUAHOE8cM+YtnLKHn0aQ0qBIMw49pGpTB/fLrbkr3KwCqKpSw5SutYg==
X-Received: by 2002:a81:4849:0:b0:609:f87b:aad3 with SMTP id
 v70-20020a814849000000b00609f87baad3mr14716552ywa.31.1710875088035; 
 Tue, 19 Mar 2024 12:04:48 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 q189-20020a8199c6000000b0060e09612482sm2086392ywg.100.2024.03.19.12.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 12:04:47 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:04:44 -0400
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Vasut, Marek" <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Lau, Wan Yee" <wan.yee.lau@intel.com>,
 "Lim, Jit Loon" <jit.loon.lim@intel.com>
Subject: Re: Pull Request: Please pull u-boot-socfpga-next-20240319
Message-ID: <20240319190444.GH3442575@bill-the-cat>
References: <DM8PR11MB559268178EBED61730BC04A6D22C2@DM8PR11MB5592.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ujRc83ruUpj6ZHXj"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB559268178EBED61730BC04A6D22C2@DM8PR11MB5592.namprd11.prod.outlook.com>
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


--ujRc83ruUpj6ZHXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 06:14:54AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> Please pull the SoCFPGA changes for next from u-boot-socfpga, containing:
>=20
>   1.  A new driver in the misc to register setting from device tree. This=
 also provides user a clean interface and all register
>=20
> settings are centralized in one place, device tree.
>=20
>   1.  Enable Agilex5 platform for Intel product. Changes, modification an=
d new files are created for board, dts, configs and
>=20
> makefile to create the base for Agilex5.
>=20
>       Build-tested on SoC64 boards, boot tested on some of them.
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit 86fd291a7990af84e96808f48eff2219dd4ef4=
96:
>=20
>   Merge tag 'efi-2024-04-rc5' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-03-13 20:39:46 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot=
-socfpga-next-20240319
>=20
> for you to fetch changes up to 386fca68960994ece0d9da8a69a14495b5f1aedf:
>=20
>   arch: arm: Agilex5 enablement (2024-03-18 14:45:47 +0800)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--ujRc83ruUpj6ZHXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX54cUACgkQFHw5/5Y0
tywhiQv/b0H7mgSgSmQCuRkWG5j2/WLxcaJzcUta9sPtP6hrV6cMWC/stNDvSn8g
uDURKqMfjYXkABW1UAU37Bzi2CAS8NwxBVEotMKcnehxIBPRaNL+HPHrvxR9RsVB
HYGQ639lqFbn3RAQrCJrlLfcIg2FgsCx0fIbkudTgxb5cx6z+ek4nahtE69HZqO+
/KnB6r2LKc80JhbIPKGbu59YSg0c+kz0+yL6DESBgEQgM7aM0Alji5zj3CqtPDvt
kFgL9qQgM4jDF/dHS7JqDXI+ChT2ouJQ4XD0KPT4nFpWLzseqvhVm00jNynkggWE
d01idDfh3ghkPHekO1urrakGtCJOWd3pRsDZZHrr6T+ECiQBONIOVA1WmUgrAOT7
Tez9WHzKcqhq8k+FnJRPKnBT4/KNXlhYDgoCoiIBzIwsUiB920exY3EVb70ziSG0
qKS3GGkw+Y9gQbkSEgX+5ogbvg14PC5Yz1rdDxVCZAaxHLrZyn7mahBS5NjLP5M1
NjmdRFG+
=QlK5
-----END PGP SIGNATURE-----

--ujRc83ruUpj6ZHXj--
