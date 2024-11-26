Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DA9D65527
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E50589C8F;
	Tue, 26 Nov 2024 17:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ftb664By";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D1589C81; Tue, 26 Nov 2024 17:49:35 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3864B89C9C
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-466966d8dbaso14530911cf.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732639770; x=1733244570; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hxe4ZZABLzjjgklWcU0ZxOUMT6pwKp+EhXfouGRfSdM=;
 b=ftb664ByBhtQpBE+o78vE1EcpwXYsg6c9bFZNgpBFtu1BC8gdzsrGT8Parofvvkat7
 4Z3AXB4WVidtqmJS2m8Pb8AByIITcIsHVypaG4MDxisMw536c3TiFlcsAr0Rmf4TcPyD
 PCS0jmu3qAE8UgMCA/hiQzgLA9AWh1NLbHoeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732639770; x=1733244570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxe4ZZABLzjjgklWcU0ZxOUMT6pwKp+EhXfouGRfSdM=;
 b=ltIEt/XPEhJi+zY39P2tdxOPIv+ANWI1sRGDqAztEDLpl3jgq3U/FFjEvQra64c1Nk
 36mB9+EMeEwTfbQTGu+qEXUwdm0voPqD7EQ9ncPfotefKbhjSjrHaLk08VADujhWj7S6
 3z8aB/d9knZ/WWprqBMWTVUuK+ghCA9xumKqVSUdTRBHhY3gyA+lX58ifJVCQ3LcQdrs
 VhrTh+0HDyGAAU7VNEAZo7Pc/P9fENBi1k5sALvjk7CYVUnbJkjBjWOODt0WyFHmz8Yh
 dFvGSlsSRm3u+pS2nKfXWQfYVBZBsE8l9Z9hY4g7L/dFf62GhOs/rTUvUJUddvy/rseA
 EBNA==
X-Gm-Message-State: AOJu0YymtDMwXiRL/vdYHEjNU49MT6y1XplH6IG0xS/eD4HWBv3yU1Zp
 aKpnJVeCT7C+dS80wPlT/fSyRxo4QnQ8+FHR7sH+Esm44KEAIKHo6EZr9jCNo4o=
X-Gm-Gg: ASbGncv+85XwDZ++pUtqxL0OOdkED6R3E620kngON73LAQo1isH6svvQVTWbECnVwAZ
 TovfI3CVAYzz2od5LtKPAblp9BF3kb52Pg6CI9GMF9HxPt51Npw2a2FxIZw4UEVNhaIgLjzOkv5
 UnjuECA3GKBvC0PFTnQ2sxZZtuBlpVzkTYkrhc6B9EViMBvZwj4fPAPSHb5UW1Lnoi3e8Qq/tub
 dD3Y7V/hVxl4gx3dkODiA912IQRlq+yzdt1VI8wDxLjKhvBNQ==
X-Google-Smtp-Source: AGHT+IFSckzu9ecGL91VqS7A4DS1scceNiTiodgW6VJiO+96FIwusPVNsa2ysvWVX4xjRbjWhtIsdw==
X-Received: by 2002:a05:622a:2c1:b0:460:bb95:5937 with SMTP id
 d75a77b69052e-4653d5e3b16mr219818571cf.32.1732639770013; 
 Tue, 26 Nov 2024 08:49:30 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46690590a12sm29161491cf.42.2024.11.26.08.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 08:49:29 -0800 (PST)
Date: Tue, 26 Nov 2024 10:49:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20241126
Message-ID: <20241126164926.GU3600562@bill-the-cat>
References: <87serep1ry.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ad0Pv8f4lUVMLPQj"
Content-Disposition: inline
In-Reply-To: <87serep1ry.fsf@baylibre.com>
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


--Ad0Pv8f4lUVMLPQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 02:23:13PM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some fixes for master:
>=20
> Fastboot:
> - handle unknown partition type as "raw"
>=20
> Usb gadget:
> - Fix ci_udc gadget driver for Tegra 2 devices by not using USBADRA
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23572
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 0e6432e19f9c812b4986ca7fd8e6db9fd2c199=
d3:
>=20
>   Merge patch series "Fix boot failure due to misaligned DMA buffer" (202=
4-11-18 08:24:06 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20241126
>=20
> for you to fetch changes up to 35d967f5a8219adc47628247a98c302b1870313e:
>=20
>   usb: ci_udc: don't use "advance" feature when setting address (2024-11-=
26 09:56:03 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Ad0Pv8f4lUVMLPQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdF/BYACgkQFHw5/5Y0
tyy7lgv/S5YEa8Nf3nssKNaEKM2PRuLw66JGYzR8ABkQbwmv1uNJ1Atjk5Wk17EQ
ek/R2J/00a9i0E4lbIyrZ2DSmp1ciEQVc1+ZPagU7k+1BkkrPD0sYO8kfsyugeb8
KD4itxqbol3r7zPFowXxSouUbZMgePu0XIrW/bMoFigUgKMFoAAyY0SptFCIIJlW
I1O2e+DQ28DBDdcb2B3Ct36r56Qcm+A1+7c7AH1d+lDTiNswHMi0sTw+40FMYfe2
3/wsPnNLaUcYxOnArqjzjBD77WpkQSyV4K9m/r6Y3Nb1S8mywnOCGc2Tfa9/860Z
z7qNfSZ+IoxTQzGLk97xuAQB9O6aSIwZIZ79VKzMTxLkc3y2MMzClMY35o6mtiE4
BZqqawgy/A2x1xTHiJX/7ZElV9Zz9ckoqKMHTRGJt2ieWEkmDzPkaKa0c6bINf2w
EEGZy9okBCa1vuVwewzqvtGLTP5oL9GqFDdgk4sUtbQBgQhXaXLkNDP05J4v1CPP
rqUzlDVv
=B3B5
-----END PGP SIGNATURE-----

--Ad0Pv8f4lUVMLPQj--
