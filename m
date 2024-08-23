Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8969AC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CEBD88210;
	Fri, 23 Aug 2024 23:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SFG7psYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFEC88549; Fri, 23 Aug 2024 23:57:29 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D11881A5
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-44fe11dedb3so13663851cf.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724450246; x=1725055046; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ipgfZT3H8axfvatePyqRHFYlMC+ddrhZqzhPbptYBXM=;
 b=SFG7psYCuXpOBVShtB/d+gvaOtVYS6GuH8wfJB6ZJw+0ku02Be266SnRCfjQf1p++v
 E6YFBSMaKzEeZfArq+WCPeV7HW20ew67xngHSE1h/lC9x1UgIyFfllh0QyS6haLNXWLH
 rceTSKK6UJ6Wa9aDlPHBisFv1IYaMgWyVMvfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724450246; x=1725055046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipgfZT3H8axfvatePyqRHFYlMC+ddrhZqzhPbptYBXM=;
 b=rg2h7bRt+Vc6mQUQI9WbtFp0a/Uokc8md00GzbmOr4QJ/S37CiJZKTHjLwFFIt+TVU
 5Szh5y8bnF1OGMohOB2dz4YkLhaSv4LGUG3YxvfxENet4s6FufKKfc2j5yep3+6+hLkf
 g4ppz9rJNe47/6w2sVjaFkY1lmg6N/Mnu4ZeC3iHT+ouVfsC7FSLts8MOZGhTYo4UYLX
 Csy+onldscc7I8EsL5gHUq5i3Ux/260qFehXE1dg43NEsbFqPsflDhhohrApWDHBE0mQ
 6xhSJv3RNN1IHxMeL1GIswAekVmTBP42voT8lYPT3LYQiiPiIE3RAaYxFaxNGgHFvTz2
 l5LQ==
X-Gm-Message-State: AOJu0YzTrWYtQWAdR8FFV8oEoXE2QTCQ+GsM/Dly2MkIY6ts+gWTSGDJ
 mChrqa2PGxO59L9ZAOAhvw1GSlg5JJHjSPcVi1SBAH0t2KwqoBmgT/5T7ZfQyLY=
X-Google-Smtp-Source: AGHT+IF5D8XcOsxwFSvo3GRNv9cg5YlKEzVKXFdF3+HbeCOajqqD1F8iYEN1bwtmIqElc6zglWzNdw==
X-Received: by 2002:a05:622a:488f:b0:44f:a251:2c05 with SMTP id
 d75a77b69052e-45509d59828mr48462831cf.59.1724450246011; 
 Fri, 23 Aug 2024 14:57:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1968a6sm21243651cf.61.2024.08.23.14.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:57:25 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:57:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL v2] Please pull u-boot-imx-next-20240823
Message-ID: <20240823215722.GD2479150@bill-the-cat>
References: <20240823194052.3978150-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VWLHAIS8APe/BQP7"
Content-Disposition: inline
In-Reply-To: <20240823194052.3978150-1-festevam@gmail.com>
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


--VWLHAIS8APe/BQP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 04:40:52PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit e93d343cc7d2886b1148d885aa137d46bbce05=
70:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-samsung into next (2024-08-22 08:15:04 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240823
>=20
> for you to fetch changes up to dda8444832ce32e0bdb9a05e2e90a7dc9f8663ca:
>=20
>   ARM: imx: Enable cat and xxd commands on Data Modul i.MX8M Mini/Plus eD=
M SBC (2024-08-23 14:53:53 -0300)
>=20
> u-boot-imx-next-20240823

Applied to u-boot/next, thanks!

--=20
Tom

--VWLHAIS8APe/BQP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbJBcIACgkQFHw5/5Y0
tyw8KQv6A45HW7f/dRPtrK9/S0M4ARIBEsDGe1na4cOIIQRpzD80XM+11kW9j46A
5XjtZjVnh3mG4//qwz1RTisB72DcqtqJ0oxy0Z+bDaLNsVpvb06fTnopuOgjo2ml
9sFLU9XjgANEzny/VnzQdHC6uo/k5HNDExaRze6jsJp+axFbC4rEMBz62OiukOCq
ultQQiH2mhMgJeyjdpLS+hn/OSoUrKHk+KOCi99rYJQa3e7ZuGhEFvmqSqFrsChi
I0vvIHAp0R0yScu7/vRVC+Q9MfO6wKtbnSFsb/aIFPcOE/UToLSIXz6S/oMq94dQ
3hDjn4np3YBFR5yV+IuLnX7zjrUw6kmreLqmFPQYW5k328jjweFXrc1FDGotayf6
QnNTDv6i5Pd81mPJMBfZw1GXSiUyLNNIhtAlaRc/hL5CFFkbyLwgrdt0IFZNlTBv
lpCNcTMFKHMdIqy11pBs+9ovNCjRnHymJo1vDuJN9B0GlhHhMZOxDO4lrqjWda37
MJdGNh/W
=DvgD
-----END PGP SIGNATURE-----

--VWLHAIS8APe/BQP7--
