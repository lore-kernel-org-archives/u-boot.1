Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C72C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 00:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E60881EA;
	Fri, 12 Apr 2024 02:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EntEGRv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B858C87F77; Fri, 12 Apr 2024 02:05:46 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B617881FA
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5aa1e9527d1so248011eaf.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712880343; x=1713485143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kHMoKWFCGLBSmTNh+zTjRPAKQ3KPNEjrgegFKLwW5sI=;
 b=EntEGRv6P6hXrBEEqkmNIYFfYn2qjG/zyE7gGbAZYjiJ4QBJPf400PtsXHDWC+0Zm9
 a2obCSacYvG5p1NZs5cK/h2F06PqfUE/qu8WND3yrmMQa+4vguXlnGQLRrFaAXNMgu55
 W/GXYxevb41eP2IDWcizuHm5MxZCy086itmFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712880343; x=1713485143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHMoKWFCGLBSmTNh+zTjRPAKQ3KPNEjrgegFKLwW5sI=;
 b=LCN0/5+MHxp6C/cRVJNeqo+BXXcOyKt4EkyvuRqwAo6bW5ostJ7ks6LoMqsSd9CNoO
 1IXvTcj9/XWh7Oe+9t/b7E91BPkv5oj/hLjE+eT/+m/dgBf8Q4jatuvsilHyPRByYSeB
 LdHeczYHhmWDGZ7iJaV5YezpQwcz7c5NmVYb9xYVSBAyFfoLHKBelFWjLlla5SOvD0A3
 42hwnUOQq/4Nnxr/tHtG6Lt4nivhK2My1iQ+I6Fy3qq767w6qMWZtc7hiwLqrtrKldgl
 qTu5P1cviCG1crIpO9tFdq5efOOjp1ynp+YgFchWIn3agvQyLgorTzeApSyTZrybUtvx
 QJGg==
X-Gm-Message-State: AOJu0YwEh4aHYPt+Ie+bMgi5Q03S5j82s0F/M+Pu08Ex6n05/Lo4h0l0
 Y82q4qUo2u71Cr/YiL/a8FAPGHhOPcVr8WjfXrkO2JboI7OuMqsJq3pxf4nrGlg=
X-Google-Smtp-Source: AGHT+IH2AbDvkPdNsqbuzda1OX+rCeuySicTVTMenbZm1JQTCi+6Y2BhPOYWT7zZrt+Qnvl3cwmJEA==
X-Received: by 2002:a05:6870:1584:b0:220:a138:f59f with SMTP id
 j4-20020a056870158400b00220a138f59fmr1201313oab.31.1712880343348; 
 Thu, 11 Apr 2024 17:05:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 l20-20020ae9f014000000b0078ec5e88805sm1062731qkg.54.2024.04.11.17.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 17:05:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:05:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH 1/4] arm: davinci: Migrate da850-evm to OF_UPSTREAM
Message-ID: <20240412000539.GM2493117@bill-the-cat>
References: <20240404030031.4726-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7vCDhfUjB/zviJOR"
Content-Disposition: inline
In-Reply-To: <20240404030031.4726-1-aford173@gmail.com>
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


--7vCDhfUjB/zviJOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 10:00:09PM -0500, Adam Ford wrote:

> The da850-evm can remove the U-Boot device trees if migrated
> to OF_UPSTREAM.  This means pointing the device trees to the
> ti/davinci directory.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>

This series leads to failure to build for omapl138_lcdk and lego_ev3 or
was I supposed to bring in something else first? Thanks.

--=20
Tom

--7vCDhfUjB/zviJOR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYYetMACgkQFHw5/5Y0
tywHpwv/aAvqhExG5BukbcK91fiBFjF2nMzT+qB0Uu5SJJYkMTdiFYn4qE7hpWqK
/PAhTUFiAilwjg6eEoiTCWi6SUS0KgjgJ6MeGrm4+k754a1oLCA4DgtbE1pS9lGM
HT8jt5TyMGcANfLLmCvFOuELHb0D4Cnasj3rdVkKlCi1JXeRyWkhuliRAxNWH2Z1
6Bj+7dlWJu5N6leQirMVFQzuZzeDe4JxIc/IYg7bflnvMMURtTIHNZrDeM0T90at
XfTfFy+m3LJiX9E5k+pwkXrlcCZ/MBe30IuW2AIUW/90vWX6jbTEVlLo1P4dpmtO
P27CSsicDHk8Neym+fj3ynMoTFNqLV2HWyJyOJnWBAW/lssQtCfL1xQkfkc8WGy2
UESL3vFhjKkEhujZL1U9Y/HJBBztVIHsTLVMf0rLrAKSxvoXZrGOaFMcPXfVCIdA
mVlrqKN3P6MXGfTapSplvV2y0XGSWaESagJ8QplEu2v5Bs6TwBCGWJs/jZtVd159
f7SLWy+L
=87Lw
-----END PGP SIGNATURE-----

--7vCDhfUjB/zviJOR--
