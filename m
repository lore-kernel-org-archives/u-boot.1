Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF29C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 00:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C6E87FDB;
	Tue, 16 Apr 2024 02:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FTMZRKUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E745287FA1; Tue, 16 Apr 2024 02:35:54 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68FCD88001
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78d57b9f3caso242151985a.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713227751; x=1713832551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X9lChb86ta86bmN0jEBJK6sZgvdAwWFxcY/pW60X9G4=;
 b=FTMZRKUa6jfbpUsgRVEKo0TnDcyrRZjqYMDKsU+zwPdpAQG3pBXgLGmGqCDGmXoRtW
 LckvYzIOoV04ccJjv/pBNgnc8XmGei+DAWMhUwQy+i3CXDBizRbV1KEKcqoR+r7F1eCB
 4zkRuPGDb/m36DkPkBv9ZDTst7q3cXtZF4ANk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713227751; x=1713832551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9lChb86ta86bmN0jEBJK6sZgvdAwWFxcY/pW60X9G4=;
 b=GbrYz/1FD6A9jbsnYS6t+TQyh0f4XXiEXjjkQM7iLEoHriIVZz33i6T2GvPFbf2D2/
 nHY8bF8ZSC1pm9Tm8ANY6ozrMINslzpuj0cpzFhzBMDwI7YjRM3EcHwlVTwLIe3qUAmJ
 a5O68wUwpje95k1/Dmw+5GU9KtA83G0Nj2Qjm1VTlPaOfdUoUn1u2nH/D2gKtm/hcJu/
 FDtzab9hDoMxaaAo95eGiQpekzjvZEl/m5MwCShUe2ynwad7s16Ww/f0GASstsRfJzRC
 oznWUHPeupzw3Rb1ZscMPae4QmbIikHuhze1fZ8ZmlsbOPPp9zTrk1Uycdf/QkywdCCU
 hS2A==
X-Gm-Message-State: AOJu0Yxu/DXg+4Xc6c5hKdw1YGTfXgei4kskhllzJKhW1DW/WUSCbGIN
 K9th04RBnj5PBYxUz4zqqb9Quy/UMqlhbztDe/qcYb+qbkZvog06yJvChGks15I=
X-Google-Smtp-Source: AGHT+IFl7p2LuR4e0oj7364zMjIpdURGDwfI6BI0jOp0Q+Wd/5SzjsEGktZQ7iamn7XQynlUidl8CA==
X-Received: by 2002:a0c:c606:0:b0:69b:6707:628a with SMTP id
 v6-20020a0cc606000000b0069b6707628amr6891179qvi.47.1713227751205; 
 Mon, 15 Apr 2024 17:35:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 u18-20020a0cea52000000b0069b192e63bfsm6858784qvp.91.2024.04.15.17.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 17:35:50 -0700 (PDT)
Date: Tue, 16 Apr 2024 02:35:46 +0200
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Vasut, Marek" <marex@denx.de>,
 =?utf-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>,
 "Lau, Wan Yee" <wan.yee.lau@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: Re: Pull Request: Please pull u-boot-socfpga-next-20240415
Message-ID: <20240416003546.GF1054907@bill-the-cat>
References: <DM8PR11MB5592D34AF6D95F4F105443B2D2092@DM8PR11MB5592.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V5flBhEO2nN7oJlJ"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5592D34AF6D95F4F105443B2D2092@DM8PR11MB5592.namprd11.prod.outlook.com>
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


--V5flBhEO2nN7oJlJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 07:34:20AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> Please pull the SoCFPGA changes for next from u-boot-socfpga, containing:
>=20
>   1.  Add option to reprogram FPGA every reboot, enable this as default i=
n chameleonv3 defconfig.
>   2.  Fixes: Rename CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_SOCFPGA_DT_R=
EG, so the driver can be built when CONFIG_SPL_SOCFPGA_DT_REG is set in def=
config.
>=20
>=20
>       Build-tested on SoC64 & SoC32 boards.
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit b03b49046af5dfca599d2ce8f0aafed89b97aa=
91:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2024-04-14 1=
5:58:31 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot=
-socfpga-next-20240415
>=20
> for you to fetch changes up to 27ed98d491521a637f2b4468ac021511294f897f:
>=20
>   drivers: misc: Fixes: Rename CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_S=
OCFPGA_DT_REG (2024-04-15 11:16:06 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--V5flBhEO2nN7oJlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYdx98ACgkQFHw5/5Y0
tyy+ogv+K5InH9RYwxvZER8brp/NA3VR2AvLN+hk6uh6r6FSU4d7mfBjqxG+aWe9
Ro+MUc/vIVwCGZf6fTbSXaevffDLpYpFn4OpiTkHl5JtrpG78Ff0Wvyp79k7Kia6
TMSiOCpa47fo7ZPX/g0GoKIvJekbWEbjy9+zC/AC09F/XAzNPTbEtPycjz3wG4hP
84xgAwm+JYdt8k3OxgFQ9s5nHhugItKqXORfe3rpoQL8pIzPckZYABwDRjk5r20t
vr1Ba5SQ8FOeRkZWc2gClRzjonh4e6Ogce5bMEHXef9+CI1+yNMqfWCdMDEPIc1L
qGOxXcYz3fEFrO30R+cFG9z5sKMXp1GW38q2GAc5YUczVIQTkmSjRKO/Xdg+MPwC
vmrKF9cvOA3yowI+i2veDUF6Ezgh9qk8ALYy9IsA89Q7IKYjjBs3uBdIWb+flJ3S
urHD28+rUUAt5JFPUgYlQmPuESjrrn2yDoccKGVBTo/NLVeuPIL2WwmH2SAs9+b3
MwFn+C5d
=uKpY
-----END PGP SIGNATURE-----

--V5flBhEO2nN7oJlJ--
