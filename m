Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED5AC87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 16:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E798383A;
	Thu, 31 Jul 2025 18:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IceH0ryC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE2908390B; Thu, 31 Jul 2025 18:05:30 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 446058309D
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 18:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-306db05b292so195727fac.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753977927; x=1754582727; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J1cXDO9SlgmUWVcbpKgD/iXZQMkORwKvTOZoSWi/Pnk=;
 b=IceH0ryCXgK/WrwxdkB+e4F3ik23LX37+vo134hmLoskYd8vfo1nixWDwTyLWIFiBX
 7O26XZsBsZem9DVdhIGacPhe6UBGp/NHa6PGBPWwE/WdIkKOBB5J5hbiWTTINyNRBlac
 wqAxMA9f2YSel1GrY3FjxHX/M/fGwTmmS916M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753977927; x=1754582727;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1cXDO9SlgmUWVcbpKgD/iXZQMkORwKvTOZoSWi/Pnk=;
 b=Encb/cxauwY1UeYc2AwHJZrk5GwpUJli4O+veZyqG3QiicYDuadWNwcvOoPodAptM7
 ehNCIggSU5x+dOx/YAMGFM1st+MsNJ44VIVuLo7xA22lSM5DWxUTKaTdN3RcsA2moXo7
 cu/RrDaa11RMFjehqReulhAz8ruNiSyvpNaSNRjbz/5o2LYkcadBm0LNljt5ro3w3SOo
 oyA/yo/FO6DCDMhJLmT6dOTeWjCQ9848ceLRU/Z7BhurPc6GRzFmc7zX+sifHqMEqE5w
 4MwOlcO5zR7bxhfgCKO98U4w6qbU0brm6vmU4Vwv1lNo66McZVeA/r4rsrptwmXaXM8L
 xfMQ==
X-Gm-Message-State: AOJu0YwnPGZCB0C3ePlx8DkYUQXyQWMWHg4imnX/2DSY9kKRLUaIKT7S
 2SSVWST4gK+GA4xDMArasuXPfwXwIHcPx2EM16F4DinbbeDMOpFChPdMTEfox6iZsSE=
X-Gm-Gg: ASbGnct31DQno4rW+XmrRKVazJ90eSYZzkFQWfoWXJuk14rLggI5mPkecHsizT7Ojcp
 mrf2OmqRw28pe4lSWhgCHazvn3E4l/2xCqkY9OC2l76jj0/HH3DcOMkJG/mwYy0Vkk566AH/eKH
 YIVN+dTcPBISA6fnD/Jx9kM03Hva/d1E6leptkUjjL+aR1GRqiWoJTZGoYirB85LznsedrhODBf
 wgLG8EFg1iV+qoDmkH9ox2iKFjAM9sXYknKunpy9gIf/eBDVRTpAp9ok1Y2cTJuPjjjcWrcsdz2
 xmd2np/ZYWZffx6S7jLVzxagm2j6n1U3zz3lcx+KHtKgyqyASK2nHms0n5MQrSUHs8ALfV+zgrS
 Q6d3TWU2dRwgYicXiZHj1bh7qwMAnfCzKjh8kBtkDL6pixKX9B6M/bYDw
X-Google-Smtp-Source: AGHT+IGUpbRe9qhc0jQBo1QdW1gsidgID5xaXmJb/k9CwM/niKaxqAwTHbaUDT5Y375izrnZGJ4b8g==
X-Received: by 2002:a05:6870:589:b0:307:5faf:4f72 with SMTP id
 586e51a60fabf-30785aec2e9mr5117011fac.14.1753977926579; 
 Thu, 31 Jul 2025 09:05:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a71200b4sm445860fac.7.2025.07.31.09.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 09:05:25 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:05:23 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "andrew.goodbody@linaro.org" <andrew.goodbody@linaro.org>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250731
Message-ID: <20250731160523.GZ1807455@bill-the-cat>
References: <LV8PR03MB813752D257E7C6949E76863DA727A@LV8PR03MB8137.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qWUWWewIcgmFLubF"
Content-Disposition: inline
In-Reply-To: <LV8PR03MB813752D257E7C6949E76863DA727A@LV8PR03MB8137.namprd03.prod.outlook.com>
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


--qWUWWewIcgmFLubF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 03:15:52AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> This pull request includes updates for the SoCFPGA platform intended for =
the 2025.10 release cycle. The highlights focus on enabling the Power Manag=
er for Agilex5, NAND boot support enhancements, and various bug fixes and c=
leanups across SoCFPGA components.
>=20
> Summary of changes:
>=20
> Agilex5 Power Manager:
>=20
>   *   Initial driver support and DT bindings are added for the Agilex5 Po=
wer Manager, enabling better power domain control.
>=20
> NAND Boot Support for Agilex5:
>=20
>   *   SPL support for NAND boot is enabled.
>   *   UBI/UBIFS support is configured in defconfigs.
>   *   Memory layout updates (malloc and BSS relocation) ensure proper boo=
t behavior.
>=20
> Code Quality Improvements:
>=20
>   *   Coverity and runtime bug fixes (e.g., jtag_usercode check, sub-devi=
ce conditionals).
>   *   Several cleanup patches addressing formatting, logic, and initializ=
ation issues.
>=20
> General Maintenance:
>=20
>   *   SPDX license tags and header include fixes.
>   *   Device tree updates to limit SPI clock frequency and other minor ad=
justments.
>=20
>=20
> These contributions come from Alif Zakuan Yuslaimi, Andrew Goodbody, Dine=
sh Maniyam, Naresh Kumar Ravulapalli, and Tingting Meng.
>=20
> This patch set has been tested on Agilex 5 devkit.
>=20
> Passing all pipeline tests at SoCFPGA U-boot custodian https://source.den=
x.de/u-boot/custodians/u-boot-socfpga/-/pipelines/27221
>=20
> Thanks.
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit a8f20bb6650df56d2600cda2c66f9349df9e49=
c8:
>=20
>   Merge patch series "bios_emulator: Fix two issues found by Smatch" (202=
5-07-29 13:14:52 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot=
-socfpga-next-20250731
>=20
> for you to fetch changes up to 4064e7c9fc42c1c376bd919a80b451273472f3df:
>=20
>   socfpga_agilex5: config: Relocate malloc and bss address (2025-07-30 17=
:45:31 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--qWUWWewIcgmFLubF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIuUQgAKCRAr4qD1Cr/k
CvB/AP40zi1DRuocBsPNDgqYgoTjRShjL/FA2NVVg8ksnw4CBAEA6+4a7brzrwxX
LnJSGm/4MWtm+vHk53lEih0cHQMgpgY=
=jx5F
-----END PGP SIGNATURE-----

--qWUWWewIcgmFLubF--
