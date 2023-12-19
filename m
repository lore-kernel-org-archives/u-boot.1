Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD8FC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADCA68780E;
	Tue, 19 Dec 2023 18:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sGDM4RaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299B6876F6; Tue, 19 Dec 2023 18:46:37 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1DA877FE
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5e734d6cbe4so16992377b3.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007993; x=1703612793; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8pkZY5+WVrwe1sMwV7kJtztSZwWfmGGs+IMHSe3jz/w=;
 b=sGDM4RaBIFoKtZTu175lH8YL3u0fWUPA1RMmBBZ+tIXbt2oUGwaBP/3L7hdEqrvnbs
 yj9U6TJ6rl1rLJz2D2k+uE4EnOzkuiNT8O/2ZEnS0e2NyD2U+Wa7TEtBXLs7ZZiy2kpJ
 Y0dnT+iGXIVZtXoMhPLi/KKD8FfcZt3vGtjtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007993; x=1703612793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8pkZY5+WVrwe1sMwV7kJtztSZwWfmGGs+IMHSe3jz/w=;
 b=N3I2itq6JuZb8y8uMT2hfqLvwVUAeDN6LzPbQqorigmxxePWrKE/N+gMCsvz9NmJqd
 QJMApYuoTAN12Dm/ev+w0qtPs2O/i8/wKg4+sLI6Gt28tXVTklQyNHos4LCOsG9WELro
 PPPvjveXfAA8nVmc2Qnwr3PcyscnsmKYL5JsJMwbpM8hclvHknaSYBuR3EMh+7pHqBJY
 OuFOUET9wV7aw4Qn523IILpXuUGHxhydg1RKPNAuwCBndQZfa/qeyLpYs1V7ggCymHjF
 NQ3xFZo1VWm32BzB5PO/4obpBKxCPrjkFOGpT3Dl3ZIjFCvNX67J+lVGVhGIrI8jQ4z5
 9b3w==
X-Gm-Message-State: AOJu0YyUivFLqJSatgmCZcthBVG0gRh3s4A+zK3Jq24xW4nN2lo7yRRZ
 bOE4dg/Vt77gPUpgVv6VFf/VSivsY+6RRAwcKf0=
X-Google-Smtp-Source: AGHT+IHm5Otmlwn8c5InBdES9sXllVBBma1Y3NbFs+ku4A2M0lUY5zEHhBonn+hpoaBc0P9f9bdxjQ==
X-Received: by 2002:a81:a7c2:0:b0:5e0:765f:1e2b with SMTP id
 e185-20020a81a7c2000000b005e0765f1e2bmr14414816ywh.78.1703007992817; 
 Tue, 19 Dec 2023 09:46:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 p127-20020a819885000000b005e6ca69cb17sm1621269ywg.25.2023.12.19.09.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:32 -0800 (PST)
Date: Tue, 19 Dec 2023 12:46:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: u-boot@lists.denx.de, Jens Wiklander <jens.wiklander@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 1/2] tee: optee: don't fail on services enumeration failure
Message-ID: <20231219174630.GD2513409@bill-the-cat>
References: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m9SJ4z4N5sUyuzrx"
Content-Disposition: inline
In-Reply-To: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
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


--m9SJ4z4N5sUyuzrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 01:37:52PM +0100, Etienne Carriere wrote:

> Change optee probe function to only warn when service enumeration
> sequence fails instead of reporting an optee driver probe failure.
> Indeed U-Boot can still use OP-TEE even if some OP-TEE services are
> not discovered.
>=20
> Fixes: 94ccfb78a4d6 ("drivers: tee: optee: discover OP-TEE services")
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--m9SJ4z4N5sUyuzrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1vYACgkQFHw5/5Y0
tyzMrQv/UVBNQxDRiKNSR8qYfZECZJPScbMzUYrgckVRgg1lKqapSTa+Y/SBha0S
hVCNq0n7tsatxFuz1T7v0XIZfnQJI72BORDats1IzcvS5IoEyonnNEHChJ13uuQT
KV9dAY4xepRV4F7MPo0QWvr1ZNEFZuLEzEg6+S0WhdqOxNJWzo9dS0rAj9vyJoG1
dY+KCvOxLgJHXkORkR+M7DnKZzkG6CIAi7KP/iBTsVSYho8tyoi0BqkoWkbg76uT
4FPDL4Dlgr+CIv7W6aIuxtye0lmGA3CR4KR3n3EaNsIVCrcEhm1Ghn1jYynDEBKi
ZksuOV5jFkbWR9fNayqBDzl//WQAp7733PwuF/dKaoaCQK7oG6Xm/jOnsaScsDof
kZ+pm4jvC3mTN9GboaYxptNs++OH5REfEUMLauAFh5LdekW6r9V90chKEEr4581w
fVwaeTz93/xmc6xSu5ZbPTE0ySRcm/cVODT33seUwEnrRge2YZir20z0PmxYbQS9
HWwPuECk
=HV99
-----END PGP SIGNATURE-----

--m9SJ4z4N5sUyuzrx--
