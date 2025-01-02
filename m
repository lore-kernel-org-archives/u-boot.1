Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259D7E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851D08007D;
	Thu,  2 Jan 2025 17:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cU5a5G4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB0480196; Thu,  2 Jan 2025 17:59:36 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64758001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 17:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d89a727a19so110043366d6.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735837173; x=1736441973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WHdG3aVCNCbYNygT5g8buw3iJMCM5ODBUJAqHbKYvmQ=;
 b=cU5a5G4vIPSmn38YEu0y4RcW0y5w5QdTqRlzAgG/mf5tPwDGrAo7Fy+5vWbnV9WfuF
 yQAEQ9aGixnlvMnCJYylbHwM+yF304ejr62a/E5gaSXFoxMbVOQP8WS0rh0x6KNk7EYY
 MnKqnxqX8nZh2tIH8Mw8bSUshLI0pXxagu6jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735837173; x=1736441973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHdG3aVCNCbYNygT5g8buw3iJMCM5ODBUJAqHbKYvmQ=;
 b=cAxshG9sHpnNFjg2MA4pgeJT9KxYTf0atE7nrJa/aTIqTu6lDtaaSn6A9+X+VLOLU5
 pSt+PpcW1RlSgpnFkN5otxuN1igc4mNJKnfoyHfq7drPnuB2sjyHv1aTyTGLmlgQgg9R
 gMATVgXcW/OoQe1/is+ua5Hr3wReWsNGBXxmME9A0HV0mHTenbs4OKHONUwZD7ZMuPIS
 pKF7pEsq0Tx8QXxTHx9nE2+5iEMdJWO5Rmps1Kqi98yB/1lFkONFg0lwBG2dOT/ARYdx
 6J5l66OZF9ruI6cRAEkB/wQkUp/TNvqSaK/mMKU3u45PBsAH/XTa8f6DTFaK1p9uVVUL
 vO/A==
X-Gm-Message-State: AOJu0YyLagdHmPyOIOpl/ZMhw/Xe86gKAJxU2BNOom1nHtZhaLDCTN2U
 e7cwUQIITjCdZTqxgrjmxMzdKAvioG9svh9IU91ufMZMr+8iIyCN8NffiKoJ/kyHepNyvSydhrF
 h2hc=
X-Gm-Gg: ASbGncue8beFOlzssdnhChgTu8CI4XTH0eOGc2/EltPPNgPpK8YoO4rTQhxtwI0vukC
 c2WOPoQVGCDr3ABeTB27uLLVPVkbUKmOeiYe3JOWOSV7kKyrx3oPWeIFfa3j0CXIVoPOk5ATpjE
 jkLP1LnYcRf5Nh30aUUsKhbXGfw5Rz1WVXDQuM8Exst80loN6aLOJ5Ki//vTwYDYruwGjjsX762
 G0CTgOAumXuxSQnxidOSgbawaB7BxYhxNZjP/N0zXUMW1phjBNTXK70QQ==
X-Google-Smtp-Source: AGHT+IGRrNuDxxhfoHob/9iNmNKzvpo/yFcJhtg0Xq3DvqK4b2dRO5cV2Et0ciaoi7alkkHE0RuWZw==
X-Received: by 2002:a05:6214:300c:b0:6d9:162a:27a2 with SMTP id
 6a1803df08f44-6dd155edeb6mr714021516d6.21.1735837173532; 
 Thu, 02 Jan 2025 08:59:33 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181c05f7sm133121756d6.90.2025.01.02.08.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 08:59:32 -0800 (PST)
Date: Thu, 2 Jan 2025 10:59:30 -0600
From: Tom Rini <trini@konsulko.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250102165930.GR3476@bill-the-cat>
References: <20241231135509.GI3476@bill-the-cat>
 <SA1PR12MB8697ABC7BD292E5C69D0491E980B2@SA1PR12MB8697.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e2OM2fpgyvkkOHcX"
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8697ABC7BD292E5C69D0491E980B2@SA1PR12MB8697.namprd12.prod.outlook.com>
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


--e2OM2fpgyvkkOHcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 01, 2025 at 10:50:02AM +0000, Abbarapu, Venkatesh wrote:

> Hi Tom,
> These defects won't appear when SPI_STACKED_PARALLEL config is enabled. W=
e can mark these as false positives.

OK, thanks.

--=20
Tom

--e2OM2fpgyvkkOHcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd2xfIACgkQFHw5/5Y0
tyx0ZQv+KVnWFqybLlapAs0uqJFLRl3famu66DMtnEOzgyw0aaty4pUMQPm6BYyt
dMINTAAp0Ro4PiSigwKCODGXOXNct/BamdkHpmZNmbIGPzBUA7pphGPrUAHLb/+i
sD4dd2Z37t3+qUlrPxFTbxwRbgEruj/+x/clm9C0EhH2nTwid4QMSXY/7rAnZhGj
DsJxPiIS0REGOj0cQcLawtTaPb/NGVC3qEUeNuc2RFo1c8HAIWDkfe0Fi4ShN1rq
pHO/peh0ant9W+e4zrdAaotNQl8PK2dMVnL5jNfyS40glpgM2i/xGv10Du5zgay3
LXGQGD3mkDO6QG8ubxUzo+Eyu2klK/InSnpEn7O2f3RZOzC/cf8ALxtNMrQuBdV/
X7y/7wCuAlP7AYKRcOJDIyPKaLZBlVlIGQ/GBub7UHBPE31Sw8XndtFiyfgSXmIt
MZD1rMd4bdIdC61mFOk6hwCUnGmOn7AZ83UgE+yk2SuSTSe4HmUTgWK8CBlaP7Ir
BhKeFBzd
=s8Gx
-----END PGP SIGNATURE-----

--e2OM2fpgyvkkOHcX--
