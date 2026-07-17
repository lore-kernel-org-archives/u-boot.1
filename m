Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3587C44515
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 20:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0895807C4;
	Fri, 17 Jul 2026 22:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kKJKzmzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E4883314; Fri, 17 Jul 2026 22:39:26 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3707E80517
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 22:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a377223171so3674189eaf.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784320762; x=1784925562; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YG3tibqiQy+ZfyjfTvO2pUVj4Dzzn9emq2B3MJU1aag=;
 b=kKJKzmzRK7UZVDNTs2sFaF0N6SD/1WREzYHH8lq1ZWTpMSY0RzJXUVb/Rii9TWwaAD
 YuljAg7+EuTT1WMEFxD9eu9NWHJI7cfmuSaqoY50qWHLmO42M1sM1DbRq3+TW/7/pygu
 EoNindPO/eK7U3SXEApG+96qqP7j1QkPhibIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320762; x=1784925562;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YG3tibqiQy+ZfyjfTvO2pUVj4Dzzn9emq2B3MJU1aag=;
 b=fOL+Ua+uuBLcsgjomh42GkOkDEF7X9PYwsIPwZclSKcKO5V52/AznsP6niQ6tm+rsZ
 7oJY40ShmwJByMFKCOeHDMU/TOF6nOXMAK85RxwyxapisjT+e1v0Vy9YNB++gmGkANV2
 iueZCPHk27AeJitgJ6fB0UChWCmU8VPzFBGPsLJuKt0LGw3FcsMmZinQF8VGsg82j8iu
 UNFtCMnZWyocTWlhTp/9LSdan2c8PLIvdLBmnTXMGktAKby/AlGNL2S1pLgOQbFwFLKR
 C+Zy8dyzDeGSZtpiPwcUETpZBhmY5elNBzrOUhP7YOeID1IrQp5joEPCjyszEEKHazY0
 Ibhw==
X-Gm-Message-State: AOJu0Yy+qd4e9UHZX/1+v/tMZoo2tLqTOdOOADjoQa+qceQnvBTdSqJW
 08Boy55wUc7tGlRS63EIe1nm4iW7zU3F1rDnw2YPL9boxAMYgs73UMvJuNKOcuwJREY=
X-Gm-Gg: AfdE7cmslVGne+RrFQQeRi+S8CPnPHUNy4n1B2vBs9EKTSHw0vGgOfTTFERA74GA63b
 AAJyw/EQFM6D2xNvtWBohYzRujTTxYIho0sEIsevuRhOfrU/Mq1jb/OWHYYxyN1SupwOUKucrgq
 zfhAWygf760jPNTkVo4D5N8FpwWjezWRwA1eRDU926RKMlehv2hBnVbzRzT84ZWz56b5Vr3268H
 f33Oeg7jie2MA2tAe2G1BA74QRo9KvJa+8vv5VeiIK+8oj7KRPrPz1NbLIFiz8SjSJYfmOmUvZ9
 gzF7+XVG4UZYC/O3f9cm3EFe+Z4b/LSmnd68IX/f49RjeOfKpBrNhKJ0fStqCF5/n479Iq/4C0F
 ez/9nrK+S9KainucUs6hSv4QHuWJgRbLzbpwANXNDdiYdtueavFAbkUKxFTy4RVaKpeClra3rZ2
 dFGrOSZdgJpMUsPaPgi/fBiOmlekK/JJ9AvAQoSinQrwqgoChenB8q4YWc0PFg152Gpm4z+lgTy
 xijykKR4Zn+rQtpqz2sbtEYOYQ=
X-Received: by 2002:a4a:ee0f:0:b0:6a3:1dc5:356c with SMTP id
 006d021491bc7-6a536869169mr1812452eaf.53.1784320761778; 
 Fri, 17 Jul 2026 13:39:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-93-175.totalplay.net.
 [187.190.93.175]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a516c048f5sm2128773eaf.8.2026.07.17.13.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:39:20 -0700 (PDT)
Date: Fri, 17 Jul 2026 14:39:18 -0600
From: Tom Rini <trini@konsulko.com>
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v1] x86: add support for CONFIG_REMAKE_ELF
Message-ID: <20260717203918.GU749385@bill-the-cat>
References: <20260716205213.340109-2-dmukhin@ford.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OYbKICnknePckTf8"
Content-Disposition: inline
In-Reply-To: <20260716205213.340109-2-dmukhin@ford.com>
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


--OYbKICnknePckTf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 01:52:14PM -0700, dmukhin@ford.com wrote:

> From: Denis Mukhin <dmukhin@ford.com>=20
>=20
> Fix objcopy/ld parameters for x86 to enable CONFIG_REMAKE_ELF
> configurations.
>=20
> That adds new 'PLATFORM_ELF_ELFLDFLAGS' make variable for injecting
> proper linker arguments when u-boot.elf is requested.
>=20
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--OYbKICnknePckTf8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalqS8gAKCRAr4qD1Cr/k
CkUBAP41OAj1kv8GX20892fIrhjInbULPsekLyHjJ2WjAT3quAD/R+AG6m7oYSuY
TYMnQubitp1zHTMLAmIFulVfGxFD4Q4=
=1tC/
-----END PGP SIGNATURE-----

--OYbKICnknePckTf8--
