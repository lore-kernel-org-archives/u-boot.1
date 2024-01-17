Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D402FC47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D19787B78;
	Wed, 17 Jan 2024 15:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B0Xpb1nd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678C787B79; Wed, 17 Jan 2024 15:26:27 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D61987B66
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5ebca94cf74so106821037b3.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501584; x=1706106384; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jJmowFZOwajacfRllumo4dC+1HLT5kp41Ia3gVJBjK4=;
 b=B0Xpb1nd9TCWpaBhB33Tm8RrStwhoA9WDwP0OFpknIIq1Qhxsfb6yFWfDo96gSsh9b
 mrA+Nl1r0z83028OqO75z/rvIsUw8mcwZY1qyrnHrigdfE4PSMxYTCmSqDp6v55SfUmm
 2rHc8CEH0wmdI24HxKCyVSlPqoJdKkjeu0pmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501584; x=1706106384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJmowFZOwajacfRllumo4dC+1HLT5kp41Ia3gVJBjK4=;
 b=hJ5PCxM+tn8MZk2YcnvrwmCSmB/98kDUFDY/PD0KxscxCnTQGaTzcqUYWvD1C/HJhI
 2yzPO7HRVkQnQ40JfbpZJFnBI+mdjH9toeeolHUDUT5mOFV9K9Y5tbvsMUiNrVj5xvEC
 WefQ8sDA1c+pMJ9MNyw8H+/5DTd0oHxGIH/A4z6AHxjNo/LvQC0Q4VgankXIo+Ka5/EB
 l+MoqPqo0j2z4ihMFvtEQWjnhbDx4TMk3rHAkFR4dTURdh5IO7lUkjUpWg4G6QDAMkfB
 ydC2EmzcuTDzc6vnr5g0ypj1iflcMY1UeJPep9IemWJORvLG1vQFTvtGWkpx9vj97emw
 4Rtw==
X-Gm-Message-State: AOJu0Yz72Gtyh5Z6azcZu63bNu/eA/YCXOnmTDaFgjOX/GjiUpTCpYKX
 zmsZEFwJyC5S9E2ZJ0CWdnjH05brPqzHsw==
X-Google-Smtp-Source: AGHT+IFRPJJ6oeBNJu/5VoRQeXnmTKqIhil2YDYqIID10uM7AlxKFBvGdTgzr8T2+/q9fqbKyFLMTA==
X-Received: by 2002:a81:4cd6:0:b0:5f4:4014:dddf with SMTP id
 z205-20020a814cd6000000b005f44014dddfmr5462065ywa.91.1705501583984; 
 Wed, 17 Jan 2024 06:26:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 i17-20020a819111000000b005ff55dc76e9sm1440328ywg.14.2024.01.17.06.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:23 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v3] test/py: i2c: Add tests for i2c command
Message-ID: <20240117142621.GK12635@bill-the-cat>
References: <f7ff13475bbd3f0471bee709dc6a805d3da5915d.1704176360.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r9owuBDGES3GI7Dh"
Content-Disposition: inline
In-Reply-To: <f7ff13475bbd3f0471bee709dc6a805d3da5915d.1704176360.git.love.kumar@amd.com>
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


--r9owuBDGES3GI7Dh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 12:17:07PM +0530, Love Kumar wrote:

> Add below test cases for i2c commands:
> i2c_bus - To show i2c bus info,
> i2c_dev - To set or show the current bus,
> i2c_probe - To probe the i2c device,
> i2c_eeprom - To test i2c eeprom device,
> i2c_probe_all_buses - To list down all the buses and probes it
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--r9owuBDGES3GI7Dh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn440ACgkQFHw5/5Y0
tyw8gQv/ZBW+fnVHMduEDxBAh9dcNE4pfru2Ms1dgI69bInco1qIA+JuNqTFE+Dz
4ok7DtANw/7xohGB971Us200/oTVVwwZ+MuKfmmbQ6KGR6qf9f5JMWBjkScsBuSJ
1EXwL2akvr2o2VxlS7tidXyS6KknvzkbWSEr/50IujffIDyKQxNW7c/LP2rKEKTJ
8gLaPJoxIIPiRpBlrmQKcjqdaTtbUhPHWIeMmDIAvgsiXF6sYxfPFqNheN3w6tyF
onRp3VkAKbPes+1MWzO0GbMLggFuln6dIlVVkxEVRXaNXpjDn5Ow6+qJKzD281Bj
ce96MdyarimgW/yESeW4TJ7giBzUvyIuzoK+W6PcvUECOGMGDRKjwZKQp5MwufOb
iLXaIXEd7Ym4PzeokmXO4YChXuF20Q8OWT8MPQGoXZqsAfzfq3bfMv91WJE1i444
PZj5svC9cNADfbmX0RosJb1Su86/zUHmc866QRDNDNpRSBNQvrFwMdSg4wQGvNnO
sXTbfDeI
=yYsV
-----END PGP SIGNATURE-----

--r9owuBDGES3GI7Dh--
