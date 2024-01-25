Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14771C46CD2
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 00:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642FC879B5;
	Thu, 25 Jan 2024 01:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="csjBw+ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E1D87B81; Thu, 25 Jan 2024 01:18:01 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EFF0869F7
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 01:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6e0f993265cso1201287a34.3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 16:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706141877; x=1706746677; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PexytEwvql90G9PtvhwvKol01yXnmeLRWNHQtNWi2Eg=;
 b=csjBw+rugBA1Iybic5dJV8auN9EwBofFzb2nbgjikgAeRm0+BMfTF0YtGVqRTfQscZ
 fUqh5hp//ipFR3FQ/SDH3uvPrMNDQlZ1e3T1jQyxYYDNCXW0HMz2TqK8agmyEUPAIu3R
 QzcHNP/BVFJZPsX1NGIrjukMZkFTtgt157AA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706141877; x=1706746677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PexytEwvql90G9PtvhwvKol01yXnmeLRWNHQtNWi2Eg=;
 b=o5p7obQRhH8hbGWkzdHSOaFk7zIUE3EfVo8aBpEdvY/7EaiBvhYJjEHSOY+iAzGG9Q
 dL6gF5Wdlax3lKbN3hGnKDD5XVv7H/l04jXtqDbk11HUBpsQjZFcbobU+Fq/aroDZN8s
 3ukYhv/zCsNVxvZfe4ZtKZXvWfppGAlCzOITzp3f9T6GD9fizXrft76P3Xd95fhx3as5
 wFqe8R/FfibmDgTR8PBWq7C4VktHPCvq9O6INExF46gDi/agIBTthh73ZHfNd2q+iZH5
 UINQo4CtrRVxO96LCUVEed3nI0UYikRAkV3cPXC3HE058C7s5W28EdU2wUWUpTi7W1AU
 GCIg==
X-Gm-Message-State: AOJu0YzlCqsFZ2qlTgMVwgzlGSADfzF/I8yw9Ncf18i1v4wWFwDz4HSI
 Ay2nVu21ZU5eWwRT+LrPrDwza4w8ByFuKJZEU8890rghgyBOAq7g391MUOQ0soQ=
X-Google-Smtp-Source: AGHT+IF3+8D7k2b7aL2shI2EA2wNXtHCM4FQOGd0GUFfz+5QqH2nv7YrICZID+19dUv1UT/CJIIf9g==
X-Received: by 2002:a05:6358:70c4:b0:174:e3e2:4147 with SMTP id
 h4-20020a05635870c400b00174e3e24147mr178917rwh.55.1706141877548; 
 Wed, 24 Jan 2024 16:17:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 a2-20020a818a02000000b005ff7f3a9c0dsm287403ywg.119.2024.01.24.16.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 16:17:57 -0800 (PST)
Date: Wed, 24 Jan 2024 19:17:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/4] cmd: provide command to display SMBIOS information
Message-ID: <20240125001755.GH3652023@bill-the-cat>
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
 <20240124211658.GA493567@bill-the-cat>
 <496ce6bb-8437-4ce5-9935-808b0e833ae4@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bIulEX4CbcNjtVwV"
Content-Disposition: inline
In-Reply-To: <496ce6bb-8437-4ce5-9935-808b0e833ae4@canonical.com>
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


--bIulEX4CbcNjtVwV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:24:33AM +0100, Heinrich Schuchardt wrote:
> On 1/24/24 22:16, Tom Rini wrote:
> > On Wed, Jan 17, 2024 at 04:33:45PM +0100, Heinrich Schuchardt wrote:
> >=20
> > > U-Boot can either generated an SMBIOS table or copy it from a prior b=
oot
> > > stage, e.g. QEMU.
> > >=20
> > > Provide a command to display the SMBIOS information.
> > >=20
> > > Currently only type 1 and 2 are translated to human readable text.
> > > Other types may be added later. Currently only a hexdump and the list=
 of
> > > strings is provided for these.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > [snip]
> > > @@ -227,6 +227,13 @@ config CMD_SBI
> > >   	help
> > >   	  Display information about the SBI implementation.
> > > +config CMD_SMBIOS
> > > +	bool "smbios"
> > > +	depends on SMBIOS
> > > +	default y
> > > +	help
> > > +	  Display the SMBIOS information.
> > > +
> >=20
> > So this would be enabled (today) on 888 boards and is a bit more than a
> > kilobyte. I think we can just let this be enabled as needed in
> > defconfigs?
> >=20
>=20
> As needed would be the boards where we want to run the related Python tes=
t.
> Sandbox and QEMU should be good enough?

And the test needs the pytest mark for cmd_smbios, yes.

--=20
Tom

--bIulEX4CbcNjtVwV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWxqK8ACgkQFHw5/5Y0
tyzRAwv7B2aLIQwyhPmjY38t9bQlxwIr5iJi+jHsHdtlfs3qyqT9D9gLnCyU/ZTO
jzE1/EQk9cl1GK0ohJO6a5p9RNDxnc/R2mrbtNi0lnfB8w5Y3Q1XEFzWcCN2bO42
tGFCsbVklTBr/tPvvdGcKqfTV2YJ9F+hroWXvD+dZmxFzOfQwzrKsBI3HFJUo+SB
EYNbObpxEv9FuIUjN53LCm1hre48RjVzpW+M3gwLHnb3L3UpPkEGp3EngGh6U9g7
50In6iSQGjAbqInXsNT0Jme2gTo/cmG4jNRzB5zUvwo31J+kPnMawNc+2vdCanaz
ayVz3IRXD3iviXkRNyeySyrWY30Z0JzeuVM/OPMeHjq++yJDB0DfHefNHdakApgK
g9o85wl+Mvh8p7B+OOiDE8wgY1Tj0gJOYEWBaKQ1/+KS/XPkLkMIE33xBgHT/gsm
bNk8BQbXRPMjAz4PioEW7oAXP0XauEoOyNPBmD5igVPmrm7wUkFnkXxMFr9Rros3
MmT12euf
=WjPW
-----END PGP SIGNATURE-----

--bIulEX4CbcNjtVwV--
