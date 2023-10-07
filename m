Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1950AE95A66
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 828F986898;
	Sun,  8 Oct 2023 01:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kzRK+bJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F355B86940; Sun,  8 Oct 2023 01:32:25 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BAC186477
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d81adf0d57fso3525381276.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696721542; x=1697326342; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1phfem8pWGPUucSEHMqqDr8hBAa9gRF87uc4S3sVcXE=;
 b=kzRK+bJ2qOLy406m2/dBknbEPJlvUbbU6P7zFVbahnizvbzlDQHX4tyLfkDl6b/6YS
 7llZFPvqCZL7yaT6oGcV/ZjvFHQ3nZfUdhHYEVSPq0Nz61REc7k42DOq1orPHmxsP75g
 SWdLKY7tRA17WDQlbXTKgihtWf/7URnYIh9Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696721542; x=1697326342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1phfem8pWGPUucSEHMqqDr8hBAa9gRF87uc4S3sVcXE=;
 b=dIjYIxjM+gJXZ+X/iqbJSRl5tjJvYB3ZMX4YbI7Ig29aCuhl+xyG0H/J7o1HU2vtNN
 HcSdUA9uDmFm45kiJmoPsLw3u7/nIuB38GaNXKM7t8AaPkv/3fDiVbMnNgLEMEL8YW+g
 C/lprY/zrStLym2gJMoq0bXPWd48UKNKe5y0Nqa/mGXb+Hi2cCRZI4mLfHLv4d8e/GXL
 OzLKE15MLyneQnttsEphV64BGgCgRk/8+I99oIC5+NoFj2NGzTu4AFpMap+ioFz3tOOF
 0Rqq5hYebnoRBvul4X5dnAo7OrJQGzA6FmecQO6eaFf0KR+9zcVIAWznY8LY8ViXHwSl
 +jlg==
X-Gm-Message-State: AOJu0Yw55b7I+ZJ5yOkCjWFQ+JPz0UnVmQamwKhzTY8HjTyRjUW02zEB
 rCA0b0rgQ6l+cyFxbxwzdkimRQ==
X-Google-Smtp-Source: AGHT+IFGEGPqKwmbTx2Pt+mE5urv6tUn87yDE3P2ajkJC5g5SYoaI8+kiZacrJB+3+jWevG/anZX0A==
X-Received: by 2002:a0d:eb0b:0:b0:59f:4ef0:b4b6 with SMTP id
 u11-20020a0deb0b000000b0059f4ef0b4b6mr12451129ywe.26.1696721542342; 
 Sat, 07 Oct 2023 16:32:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3c47-81c9-6281-4dc8.res6.spectrum.com.
 [2603:6081:7b00:6400:3c47:81c9:6281:4dc8])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a81ab52000000b005a4da74b869sm2410343ywk.139.2023.10.07.16.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:32:21 -0700 (PDT)
Date: Sat, 7 Oct 2023 19:32:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 04/27] bootstd: Correct dependencies on CMDLINE
Message-ID: <20231007233219.GI2227687@bill-the-cat>
References: <20231007231255.277623-1-sjg@chromium.org>
 <20231007231255.277623-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GuxYRGAHINwBvlCQ"
Content-Disposition: inline
In-Reply-To: <20231007231255.277623-5-sjg@chromium.org>
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


--GuxYRGAHINwBvlCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 05:12:23PM -0600, Simon Glass wrote:

> With recent changes in boot/Kconfig it is no-longer possible to disable
> CMDLINE. It results in various link errors because some options which
> require CMDLINE are enabled regardless of whether it is available.

How "recent" is this problem?

--=20
Tom

--GuxYRGAHINwBvlCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUh6oAACgkQFHw5/5Y0
tyyW5Av+JZ1YlxaYftgad+sPm2U4kF0kHYPGJMDSoJOCmVX5bMTpUuB9aMiIPW3V
8dV9AqHMOIcc99JXym2TDYy9VewMu2s6EnA+CCB796dY/v+wdvdonjftghtKktIl
iYx2UkXb1vX8eCGA1Exrdi/KVQgOmjUND+iqwQUirw3AE1gTNon6ACzdtMT7bcU3
k62MXD75194voXAk//EmHBt0Z1JEp1hOro7dhZ4nsg+S9rsvUlIT2X+jVS7Symir
taj5ErhXXzmk4rX6qacIhw3UY8uqJ8HbjlJl6iZ17mH1rJpbACcDtwFR+X0LGWWK
RngGzBgHAfWg7F+Xvw9TokTRzrFcVvSsA1KqOl1aJQGOGOKpmlh4dbmSMbDhcHx+
uheB5MABtGf47q/p2dsWoAhSaXEBct8Uk+rROw4Vr57StRXQ1g4RpoF2oGsMLBkB
URDd/Z83P4k20AC8Gcy+CmoX9Up+ZGTD+aVC3fUhnrPoE+VnvpGJxnjEdtfyXcc/
fNeBDLQk
=PRrZ
-----END PGP SIGNATURE-----

--GuxYRGAHINwBvlCQ--
