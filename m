Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757A6E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 22:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C652C8007D;
	Thu,  2 Jan 2025 23:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MWfvJWMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED6980196; Thu,  2 Jan 2025 23:47:31 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 889568001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 23:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6f75f61f9so1580950085a.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 14:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735858048; x=1736462848; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k/aE4HKCvJ5LvjpN8DnF7QSy9ToRIY+0kCUq70khUmM=;
 b=MWfvJWMyfkVpdlBLqdBZavCExeV2j+FPEayCSzMqD+SEWMOSKL8ig+Erh+aMA3F/SZ
 7YvqcIaswpI93QJfW0EFxoB9D9Rn4ylVC4Mmd2kNGshzD5Inir9L+fSL1JOkSbGAPPYm
 RAMWIRofH+GkIO9w7WcIJQbJy49N4AZQPmAdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735858048; x=1736462848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/aE4HKCvJ5LvjpN8DnF7QSy9ToRIY+0kCUq70khUmM=;
 b=Ai09wU+RHVcxySzzKxuPXgSJYQf98vXGdGmGvGm0OkgyU1TMJsuEJa8uFlXvocM6dZ
 ehkbiPEm3rcgARaJ5Qw4FEEOCfx+yMELowsKXt4XN/tdKPNTDtSUdT25YpxjIV1DNEfo
 Qr+AQG+wL83THc5hw+bo/BKApurifYRZYirwsWWhlCh0OWu+fM0KwDdVXZxMes247RUI
 GItapOq1mztmvxPr9xA+WIARvT4oyWFk0Y0ufzOYHaKLNdJBxRX4UX/3Y5Kj16j5wnUV
 dXvmR/3LfVNatV8xygM+nWNeGKKy97qxE86/AQqyx6k1G9tjMzLoXj+LTRHhYXrcwmW4
 Ud8g==
X-Gm-Message-State: AOJu0YzzPUJyHPO1qWoXlXjeHmC3ToW0K+7kV5NDAg8yqhAq7B9WfWaT
 O1oBHt/AVbeuqdZUwQ4Qb004nuN5SIszrEwYHP17a23bpEMigvGyCNyCUMsEFodaY7q9xMOUacL
 HWb0=
X-Gm-Gg: ASbGncv1umBxzS7j1vX5MwM/X1eFYjck/pTXBPA+L25y9Sgd3vfnnhpWycp9O72ziUH
 DUb07L0NzL7leh72OkREdl36JeRSV5WmQ5sV3eNtbkeF9pFJQL+fpuwr6R4ISJIPNbkYEd3YE5j
 Buhd4a7N8kMMY3MfYszOZyhQcoOFSYSQURciUeoTKiUmXV9fUNOxkWYKytM30rhVVmZOBdHiUF8
 1AgaR7zJB81wqSPqpCz2G2jtInkR+L7VMERmQLTkduckVF3Xi72kXHF4A==
X-Google-Smtp-Source: AGHT+IGgJWjUziaKR85y9Ypwqe2CC5FzTFx2+LPjZ1WpdUYsTtZJhbxNVWWbQ0mKPHncIIKj9Ybuxg==
X-Received: by 2002:a05:620a:6088:b0:7b6:d420:7883 with SMTP id
 af79cd13be357-7b9ba7ac16cmr7356873585a.33.1735858048349; 
 Thu, 02 Jan 2025 14:47:28 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478df8sm1222323485a.81.2025.01.02.14.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 14:47:27 -0800 (PST)
Date: Thu, 2 Jan 2025 16:47:24 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: LwIP and multiple network interfaces
Message-ID: <20250102224724.GS3476@bill-the-cat>
References: <de7bf6b3-fd45-4c8f-a492-bd41db2aa904@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fztljLJ6fnepVtZC"
Content-Disposition: inline
In-Reply-To: <de7bf6b3-fd45-4c8f-a492-bd41db2aa904@freeshell.de>
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


--fztljLJ6fnepVtZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 02:26:06PM -0800, E Shattow wrote:
> Problem: 'dhcp' must be ran twice when the network cable is plugged into a
> port other than the first network port.
>=20
> Network cable plugged into bottom (first) Ethernet port:
> 1. Power on
> 2. StarFive # dhcp
>=20
> ethernet@16030000 Waiting for PHY auto negotiation to complete....... done
> DHCP client bound to address 192.168.2.51 (3678 ms)
>=20
>=20
> Network cable plugged into top (second) Ethernet port:
> 1. Power on
> 2. StarFive # dhcp
> ethernet@16030000 Waiting for PHY auto negotiation to complete.........
> TIMEOUT !
> phy_startup() failed: -110
> FAILED: -110
> ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
> ethernet@16030000 Waiting for PHY auto negotiation to complete.........
> TIMEOUT !
> phy_startup() failed: -110
> FAILED: -110
> Could not start ethernet@16030000
> 3. StarFive # dhcp
> DHCP client bound to address 192.168.2.77 (31 ms)

What happens when you set ethact to 1 first?

--=20
Tom

--fztljLJ6fnepVtZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd3F3gACgkQFHw5/5Y0
tywKZwv/SMmCrUH0fa4YwYAzANkaxdbfp43sm7Uw6GN2sOas539yi0/+5sm97RfC
5kRInYHbyvLCU+AW2FUTh/V5a9VpK4IySKq2GsFLxr/m2tlbYJFlXRaOn9bf8sAi
L/2jOItKVCj+r9mnBt1Ei0js6RF3FczcNsPqE3MKXdtL6LLgU4ktwEwJafJ9cou7
hrOOJDJ9hwl2xhtZcgEQevWRdHDGiITFS/Y2DJalFahqemaG4odM9lZnOWTd34SY
vxebjjMhgCvp187+5S0hqMClcWifzkaU8vAETD9tJW65KZwPARwj3B33saMjHxpy
BYtutGNZRx43NADhGYNW5v+mehEFNb4kJwDzXFLMKk32ZlcBUBTcbtEmzeq8sh2K
BtlOXzROGojX5dxDldqzfohxSeTaWb2bYEnpQxgORxlZ+MqLHIsvUFwzOZhOnROW
9ndWYg5FTZPOKxhD23bfOz5xIOJpqKp4X+rs9NMY1cdxttbOxh0DkOkIycdMs66b
nbv/AlQR
=Z2Tb
-----END PGP SIGNATURE-----

--fztljLJ6fnepVtZC--
