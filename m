Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891A5C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512BA879EC;
	Wed, 25 Oct 2023 01:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TuzZoWqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFF3879E1; Wed, 25 Oct 2023 01:16:06 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED2B879E9
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d9a4c0d89f7so4602054276.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189355; x=1698794155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pBzAMFC3bc4KqNZuTomyQtCW64iNNnzhUxzZpJNZYug=;
 b=TuzZoWqHz2paYExU2H7BGjLB9pGoEU+/eru9SOL/JNT10Sjh4Y5XkIDtP/Jj1zzT/4
 VTspiUgBhxKNA7eL2RUQzFQ0k6gu5s8wrb5ujcOSzCFnHnLDg8a8RO4ewxheGY6lhopF
 GA8rF/GRf7zAbP53MgZN8EucZbGVhNRtQaRXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189355; x=1698794155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBzAMFC3bc4KqNZuTomyQtCW64iNNnzhUxzZpJNZYug=;
 b=gRfZs/X8s3sC9FgSKaB1EUipmOzS9hqaOAufoB4V/3HWkhR4NnvqjiXYe0EWqp1fWr
 Mrh/To5p+dGDkGTuXFgJTTNPJ2hgMULPLGMDeSuJrqqMPl19zbWf9fMNBBDBh5nxqGeC
 /lJItZwJOrnpD3WCY0fn9IhkxhgqisTHPAl/tp6RL55CY7dP3zp1v3SqFdQbpT85toys
 gsp5piYVMxP/i98DGTpr9gpmPy+pJU86FzeSLMRytlLCv/n/MIVIQZVyOUky3r4MMf0N
 +H0ARwcK6dmi3Y6XuLFBPe7ZpfgDMmnHrx08fup9WsXOn2twSQfvIARfobvddwaxL+ZQ
 Dl9Q==
X-Gm-Message-State: AOJu0YxvIWw0CBnPJxX9YBhqhceTxzLQYklvnF38MXjq+PTsi4Zpk/FD
 jfObmojVozpyOJkThAEeOQF47Ch+N0YqQlWvEMvQoQ==
X-Google-Smtp-Source: AGHT+IGhphlQyS0Ydpe7xoteidlApnc9Lc+DXkD8fwnPuTVvquPuQnBncfRRgUjL1NxT724dpfDv9g==
X-Received: by 2002:a25:d051:0:b0:d81:97c:c016 with SMTP id
 h78-20020a25d051000000b00d81097cc016mr13824004ybg.15.1698189355264; 
 Tue, 24 Oct 2023 16:15:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a5b0b10000000b00d911680fd10sm3868300ybp.50.2023.10.24.16.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:15:54 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:15:53 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/7] include: Add <linux/types.h> in a few places
Message-ID: <20231024231553.GP496310@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dOT5QEUVYTrBW5TZ"
Content-Disposition: inline
In-Reply-To: <20231012230359.2005249-2-trini@konsulko.com>
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


--dOT5QEUVYTrBW5TZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 07:03:54PM -0400, Tom Rini wrote:

> These files references a number of types that are defined in
> <linux/types.h> (and so forth), so include it here rather than rely on
> indirect inclusion.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--dOT5QEUVYTrBW5TZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UCkACgkQFHw5/5Y0
tyzaGwv/aarlDpZvaP+JuSwRRBu+xilS+Fw6pTpbYgObL/o2dUC++RfluCedtNB1
klkGn3Dr6wlPPWCB1xAALbewpzfd+Sox1/nuRpRu9Z+X0SjMA8U23KtWRSKn6aKI
m2/R0FlnvDM9WpPinvDPquZkM0khifRqNC478t13eHGrLm+gT9DQ/hbZF9Px0A5j
yXs7gTx3F4+MEakq+7jzC+fP2bR3AelZT0v6Km9Vz6p4gfslEO7l+Nm3zd12NtXH
ZxJlBxvMK9NVZCL8K/hcNu0l2a+Bt1daOCCDl/d58S1yu+TL6KpJNW4ZPV4dVIpZ
nGT6F/hkEItxCBxzMtqku4ckI+kbGUDugybkJcbUihZBVpO0YpOy15vW/cv+FC2A
yKkjgGlTy3b2tyJBFDdlmrKh8BQffENwYrRa0bQaf4hkO90eqLX4xtn5FbO3K7Xm
X5NmE/lCKzgDEQYwsmVE8gzffuMgHRb6+qs1CWCZKE9HHpOiyNlpzsrVU7LElfwL
0JAUAteU
=U1yO
-----END PGP SIGNATURE-----

--dOT5QEUVYTrBW5TZ--
