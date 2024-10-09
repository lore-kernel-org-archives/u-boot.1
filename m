Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE5ACEDD9E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3177988216;
	Wed,  9 Oct 2024 16:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pIuh1cEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8813E80245; Wed,  9 Oct 2024 16:22:25 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8094C8811C
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b10f298052so32969885a.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728483742; x=1729088542; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xu3oE/JnEBONJv4AuZryIAb+mfAq3L4h5xFUOeSBu38=;
 b=pIuh1cEavXESENG7xKCfRnn8vI6MzGGNTAr3Rb4ydZsI4QW0f01m26pIGdVRYtqm0Y
 fm/5YlLoET4yJCmOZoz2C9+eRZsVM9Oh38eL0C3UZuno5IFPx9SMCCnHRwQ67vcS0QTC
 +ZCzRsdmOe9mJKPcTxWPgVXIZFdWXOz9s1RMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728483742; x=1729088542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xu3oE/JnEBONJv4AuZryIAb+mfAq3L4h5xFUOeSBu38=;
 b=drEAYjwhaEdrJSMCakfWdT+lk6touRIzbavj/Nl/XBw9w7ysKGgI3q+6vzQsCESkSP
 4s3A/sn+DI2A+1xjIXq/K4RFFYfun5Ec8oR6yU0RgcgHL6hvKfjr3felJtxFmeY0Kxy3
 I+p0qyW532F3I51oJSzjZYPGsRfXIYaoCOcSo6layLDpWq3wX+Cc577sVZK9mWDg+XyW
 c83UJo2Nrs7evmETJwH9bPVAZ5Za3kpki2XtXBbPClsyB9KmdeM9fa7OZOY6a8Ao60OQ
 Y9lCAQznJvqmp0DU/PvOaVnpLqHihHT7GokXH3tW/CeHXP8Wk8mm8W6N/7ud+xCEn1ri
 IUXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgfCDN1eX3idRZInJLIneVWi2VMXlgP6CveYjtGmGYwd9Jh0VDIdxKsRpsSAaICjZs5zlRSUM=@lists.denx.de
X-Gm-Message-State: AOJu0YxjTzXBmWj/d0h/2XJCvSJkhjsOrPklTVynU0sXOclew3mFqv1a
 l0li462s5Bw0LkLb989p+HroGTVrhSDXyamNzN0oRChVURuHWOJohfeJjygTaY4=
X-Google-Smtp-Source: AGHT+IHx+gikdYjmZLPjM4+M3mhS9bpgkCjmLfBZi4d4CbWfowOi3T5WsO2cwnLntn3TEy3WpAV6Xw==
X-Received: by 2002:a05:6214:469c:b0:6cb:3644:7ee1 with SMTP id
 6a1803df08f44-6cbc95571a8mr47921876d6.28.1728483742029; 
 Wed, 09 Oct 2024 07:22:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbc9616b8dsm8199306d6.10.2024.10.09.07.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:22:21 -0700 (PDT)
Date: Wed, 9 Oct 2024 08:22:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "sbabic@denx.de" <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Joy Zou <joy.zou@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH 1/2] power: pmic: Support pmic pf0900
Message-ID: <20241009142217.GI14210@bill-the-cat>
References: <20240930032244.20286-1-peng.fan@oss.nxp.com>
 <PAXPR04MB84597FAE909539FAA580A19E887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AbLtLtK9vZ7SmZOG"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84597FAE909539FAA580A19E887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--AbLtLtK9vZ7SmZOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 03:42:52PM +0000, Peng Fan wrote:

> Hi Fabio, Tom
>=20
> Seems Jaehoon is inactive. Will you help manage the
> the power related patchset or I could use fsl-qoirq tree
> to manage these drivers for i.MX?

I'll take a look through things and pick them up soon, thanks.

--=20
Tom

--AbLtLtK9vZ7SmZOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcGkZYACgkQFHw5/5Y0
tyyLNQwApT/H3YOpyH1N31kgO1nz3w/8+JydoQeQLdbPvmv9+YKT1EpDce46+3vj
pANyb4mHkDqpHM3epdxzRyBRHQiD2y3aVm39Y3UUsdZySGWGu3oNRxOEivOKPOYh
koewM2xbkQnzj4tjO1RgiMUFVV1li5msFqIoKL//2M/eJlUY0NiDnd8QZRaY2++K
4VWCn2w17gh1AYZcVq/4YEKbPDUerQoUAwRVOTPefh0UvPK36uW8a8KMGQo40FBh
khuzQ2G61BQEysXW78MtjfhopEU/lM2UH0pekegzP5QDtp7TO4ItZuHZhZ5I6guy
2d1O0CXV8VluFXWjXQ0qrNNw5cBudYRC7zNSCWiKnsIeW7PfYIwXTDlcZRbnN/Tc
ch0vIzmpE3aV+53yEqkzplL+o7NXz3YcOkLaxStmlX5RCHq4iKUhuLgxyxq3ssdw
dwUl50x1LS2UBkLHqSIdgV+CQIrKC613hlTAlNJ0TSXK0pFEd1/0dTj/djJUUdP+
RBWxajEH
=29OK
-----END PGP SIGNATURE-----

--AbLtLtK9vZ7SmZOG--
