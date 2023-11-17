Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B4AC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0773287508;
	Fri, 17 Nov 2023 14:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TyZWSdBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F111E8750C; Fri, 17 Nov 2023 14:42:31 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F08D587508
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-778999c5ecfso114058585a.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228547; x=1700833347; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=37Z69/mc3nTxGUqGWdjDDqjSU9x5K6FuwLTym+g4sPQ=;
 b=TyZWSdBYQCkucgR5yCf+YhkAL3qJcpllyCNmnaW1LJapm+BmqWSAYWaW1QaBhc/3ty
 aqPpTOEXA+l5TySMn2ecivcXNRgHPXoQRQVN1a793a4VyCGihx2fANPLDVQNM5K66MY8
 01QjAut/X7RlgUwhBlda6WkzKIbCWe22whcpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228547; x=1700833347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37Z69/mc3nTxGUqGWdjDDqjSU9x5K6FuwLTym+g4sPQ=;
 b=ZwiaoPMIwYs6Ns/JDCcIDcx0EHwXIL3kCznwO7tNOqHVu4TfwkY/QMUly6olZuF0tO
 FD5/6HWFtZ/8IRUYxltuYqPfg2E1Yt7piZv7/THtaWBUcOjJ+Odh35CZqRdZIQXoL8cO
 LGXWTkXidBUHca6Hn3YlPCFc4IScZE1aDnsH0BgsLPI+q8bk3vwkjilZqRrdqQ2mcYAb
 JtR0T1FBZ7KLI8KjbjHe8EAdxdk8tVKhfpBO3ONs/71IccZWMrG118pUTm+F8cEIyc1C
 bQrcL1cZKd3fzduBsDz6rBYT0lZ07Im48fOmpsFZPm79F5i5LNtXFysJz3wEtiY8k0jD
 vd2g==
X-Gm-Message-State: AOJu0YyaqDIzu5rdyrKje/n3GMzz4bSE/bq8jupyTCpyCm4stRJfGGF3
 k9BEFbYFeG1VLfX1PeMeJ3Jbqg==
X-Google-Smtp-Source: AGHT+IFnrjNAAbToMv3FYKqMnijXY3zx5Op0LDsj0aN2STNDPZhkQNEUuUU10GAVXUL8HAPD7JAksA==
X-Received: by 2002:a05:6214:4598:b0:66d:5d31:999e with SMTP id
 op24-20020a056214459800b0066d5d31999emr16374344qvb.43.1700228546864; 
 Fri, 17 Nov 2023 05:42:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 lg22-20020a056214549600b00671248b9cfcsm630598qvb.67.2023.11.17.05.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:42:26 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Peter Griffin <peter.griffin@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v1 1/2] poplar: use random mac address
Message-ID: <20231117134224.GX170968@bill-the-cat>
References: <20231109223435.706053-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eP0Xs01zZUiLEVbJ"
Content-Disposition: inline
In-Reply-To: <20231109223435.706053-1-igor.opaniuk@foundries.io>
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


--eP0Xs01zZUiLEVbJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 11:34:34PM +0100, Igor Opaniuk wrote:

> Set CONFIG_NET_RANDOM_ETHADDR=3Dy, which sets random eth address in
> case there is no configuration provided neither in CONFIG_ETHADDR
> nor in "ethaddr" env variable.
>=20
> This fixes the problem:
> poplar# dhcp
> Error: ethernet@9841000 address not set.
>=20
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--eP0Xs01zZUiLEVbJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbcAACgkQFHw5/5Y0
tyzWSAv8DRnTDZFjlYu9nvO33cEVk7BbyKDO7s6YC9Eqsk/9FmmDoLGnWKBEnDEz
sH/ltNjWHb4m7vQtcBHMsqn6bibyT0+J9FJOrN0YEcGUNnXJPbHjfRnMNejAlEgI
0/B5po2kesrEubhybRy3dHWY+zSxxIW2LfQkXsOBk8ExvHg5KK5Sio20EUJ37iim
CHNXwgD6BWZt5jnOxMFYvHYdcBynQyX8z0wLwMaIs1rfdM49ADkF/Tj10rqHmkti
rBex3KGzvZkvWjocBLZw2Z+fNx/6hAk0mMlBWvIp+WY84oxDClFWK4c78Tno4KZ3
smjo7UejfUjtGNCdmF/nzpoeXnj1SVb3e0WVqOLBF/oq1YwPye5mh3bznRmthsXX
9V/diF0MORYYcA7UeQ2xTAZuiSFlbR48+9Mrm50TP/cABRbJafGjtiILeeCpMcxC
ti2EaOXjRPBdOhY+vxc68bOEP+eYlm87AGKJVUn1A56ebksYiMKYHPfWljIMTK9V
2YT302ZB
=0cP8
-----END PGP SIGNATURE-----

--eP0Xs01zZUiLEVbJ--
