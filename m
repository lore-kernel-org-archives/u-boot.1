Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E30EC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D941B87DC2;
	Mon, 29 Jan 2024 18:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R61HtsQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4113187BDF; Mon, 29 Jan 2024 18:55:53 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE12B87DC2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dc68150f46fso1101644276.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550949; x=1707155749; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RbNgooIDVua8rtysxwQclvj8DtNvqqlvvISW7liWHsE=;
 b=R61HtsQVRIrICblqxvJndzn9+RGi4ueT074KDNpPgv569aOUA/hrwj2TGlRh2GCymX
 VhEvOGPKLb9q+QWRKyw3ZltU5P2LyMN+3+1WHSkh0lFoOUNRmxWDuVNCTKTufSGgYC1F
 0wxFE3jEvTFVeASbWODI2RfOvttuFCPuqbw9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550949; x=1707155749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbNgooIDVua8rtysxwQclvj8DtNvqqlvvISW7liWHsE=;
 b=qgkaSdrJATxexeEI3Aa6WuuU+FGcDzV7ZeOciF9miN3RlVcySnZgC0RHRujWPIM4Th
 yawv2Pm/cTadDLPUN1rZC1+R6hH9AlGpqOY+9z2g3Cg4d+apuKL3+TCYAH2GM0Vv81NY
 fCWA/1bKfXotNfUJuzLJe/za1mrlJ2tAoKIxV5KdZ5ymJsm5d5PAS70eOo+6PM+XHvbH
 GsyEg5o7/eu0Q+joYsB8TJbC92hVSG7nThJGR5hCkkfbw12Rc1np1zEP2TtqbTaiAjp8
 /LMDRx+XExjFupSY2tjibnBz5a/39bnCec1nT8x21FvZwtK75n0tTVQ+boZ9KDPZsXFB
 AVAg==
X-Gm-Message-State: AOJu0YxmZn66NzlNGvXbES+4zxk5pr/+V6V3nrsT/6MHMTUrUolstjoN
 YbRAzH9zHACDRb3ok99iwJGuDlNdJkTMrVwD+KemEkii45Rphi6LOlDZb+lW5U0=
X-Google-Smtp-Source: AGHT+IEY9Plb5Jtnp904TLpuh86l/y0l3H145ZoKY/YGCVZE4Nx/WqSZ5t0NKZsEQBQ8sbwC9FgrMQ==
X-Received: by 2002:a05:6902:2742:b0:dbd:4dca:7082 with SMTP id
 ea2-20020a056902274200b00dbd4dca7082mr4278475ybb.34.1706550948951; 
 Mon, 29 Jan 2024 09:55:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 f128-20020a255186000000b00dc25528fe9fsm2405452ybb.9.2024.01.29.09.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:55:48 -0800 (PST)
Date: Mon, 29 Jan 2024 12:55:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: scsi: Add test for scsi commands
Message-ID: <20240129175546.GL1152441@bill-the-cat>
References: <3f58ca31c93ba7fa3e0981035b251a5ebcb150ec.1705663831.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pGSv0REJ66sGmV2k"
Content-Disposition: inline
In-Reply-To: <3f58ca31c93ba7fa3e0981035b251a5ebcb150ec.1705663831.git.love.kumar@amd.com>
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


--pGSv0REJ66sGmV2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 08:07:13PM +0530, Love Kumar wrote:

> Add a following test cases for scsi commands:
> scsi_reset - To reset SCSI controller
> scsi_info - To show available SCSI devices
> scsi_scan - To (re-)scan SCSI bus
> scsi_device - To show or set surrent device
> scsi_part - To print partition table of selected SCSI device
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--pGSv0REJ66sGmV2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35qIACgkQFHw5/5Y0
tyyAIgv/a3AZfnGikVzdsVxTHyZSLrXvVn2qEUxML+ZIpwI7dP5QoBsyYuBFI7kK
jMhuleROpdbG1tJgvohyj16cRqLMxz2m6E/gxUtnX5wzd04kW09A5hqQrD2BQ/mg
33Ax1Wbg+BbSBjb78MQhhLFp5/Z8NdLCdtJZ77bUYqHr7YE4ifdbgYVJIFaiu8kZ
kNshURIv2zkFw38/vobEywSFFw084PIWNIC1uvP7eznkfWu/g0JexWpzcgnNbIgK
Sz7ZwFgcXzh2ilGGBDJGiflMwnsxOKPAztHRvdRSOCJJaNvXeRSS4oAksmA1dPDZ
iigu7P/PPiUNJJDGnBM78+fK3KCBVmulIXr1reZpEu2ivi5Rjf6vFR/526/ZK9jo
4zwQF+Bgh7sHGzjL5T/OSidW1jBrS8P7pbIJcIPO9AxqmqmgonAGmCwS2hlu8CbE
3N+6sT2iMT+stuzCcSB8lMYy0mur0GmfeXyOzbMxA40m7incl9o1qLLzbf2rncfe
PV6+cQWN
=EFfO
-----END PGP SIGNATURE-----

--pGSv0REJ66sGmV2k--
