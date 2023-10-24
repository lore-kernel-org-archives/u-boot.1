Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90479C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99ED8879F3;
	Wed, 25 Oct 2023 01:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cH181w9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FFC87100; Wed, 25 Oct 2023 01:16:18 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9814F8748C
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7d9d357faso50766897b3.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189363; x=1698794163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IzXH77pQEHCR5Y+dTrrW7jUaaUan45Oqu3CZgMe8FV0=;
 b=cH181w9IFIBemVxu6+B+uMCX+kZCqVRGXxaw810E8HdynFPwu+A6dZAdH9vMTtnuTP
 LDxZ9Km5TdPhJZGVTAQsA3I9g/B8e0FL5zXdTlZ/JEGeyGJ+lfHTSah+KddUX8PWtnBy
 Mg5tpDJ/tOsDRrYwlrm76efMGWfrnDUYraWbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189363; x=1698794163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzXH77pQEHCR5Y+dTrrW7jUaaUan45Oqu3CZgMe8FV0=;
 b=uUuBRsIWXOP8j/JN4ZmhNCmXnTmgX+cyUHt4w2N4PgttRm7RaJaW2GLdQkPhU/EVUR
 t70amTdBwu3y7KrT4ESrCjZ5vuTx0ojd45qnbRcWdD5E5FlAjJHvoVedoIGf7oAphauo
 rvNyFLdVwnt7XV0B5KeM70a7WD1qWUsNsWaXyfL5aNuAkjtFD6mfsWY2e8sL+sdr5JX5
 69raPtWpAVgHPpY4s9TNeLujici69Ylu9QCroE6lGsz3f08jsSO7yZE/mvdCjCgbJbW7
 Eq7FqVGE8lgwNzbPfZJ/QPRkge2AVDW8rOAuj3I77fTz2+dh77AHgwa4kKo30T+EdtPh
 XcDQ==
X-Gm-Message-State: AOJu0YzdibGcSODljcjCFUL/WCxxPOurOtCn/VWK+yqpdGxCCsJX/PDO
 HxfF5XRcLc/r0iOFEesQotjZtmwpc5Ya6wwJRhjzRA==
X-Google-Smtp-Source: AGHT+IFitDPvDeSFy10FFq1fIAHnN4ubuVvc/jMBAIwQh66Wr6ncvUyTLQ1oRlfK1DkChWOQyT8Z5A==
X-Received: by 2002:a81:bb53:0:b0:5ad:47ba:fa3a with SMTP id
 a19-20020a81bb53000000b005ad47bafa3amr3396799ywl.43.1698189363194; 
 Tue, 24 Oct 2023 16:16:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 x126-20020a818784000000b005707fb5110bsm4532901ywf.58.2023.10.24.16.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:02 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:00 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH 4/7] m68k: Remove common.h usage
Message-ID: <20231024231600.GR496310@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-4-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GIH/lxIkkiwnVhCX"
Content-Disposition: inline
In-Reply-To: <20231012230359.2005249-4-trini@konsulko.com>
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


--GIH/lxIkkiwnVhCX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 07:03:56PM -0400, Tom Rini wrote:

> We can remove common.h from most cases of the code here, and only a few
> places need an additional header instead.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Acked-by: Angelo Dureghello <angelo@kernel-space.org>

Applied to u-boot/master, thanks!

--=20
Tom

--GIH/lxIkkiwnVhCX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UDAACgkQFHw5/5Y0
tyxd0wv/fPo0QaKrK6Wg7+pEXJEo7wn+GsAbF1XP+3KmXUeXK7cMytxGpHU1H+hu
b3nHiewqoxaOvX7PZU3Hq2eMDwamXpktE64AxuqimBXF7vojnFtcTPzUH5gY74u9
OZa2C/BrbkXoi+J9XrUYn08GzSk98A0mUcq4ULePA4p1e1r9zp9/uJGARS4Sk+xc
EEoMO8+naknzyVU4lfw1ZZOwmyK0z56wZ3nPRTmwoWlk/E073vDHgDaOZ4Wa2cb+
BJD9cRC6qTXYEqyGXJa/YtX6THQeWIxZq4tzddHExD8UAzzhhgjjqVm0xDAJ6/JY
aYAf9Xtv9ve6cpXf5oGPBlzmZW69cDhR7OpNUGCnRDkOUD46q/Qdt66YMHuM4qZe
96Ns5VsHbiDj6aAXQW0aCh5dJxyz5ffHKnmElBK8sYDttcPdiqo5dw6DtoGoJ1zR
umHR6Gbrz5EfI4qL70xpcV9mDLPnXdp6KwhDe7vrriT9Oe+QN0/KSNlsij6qpmTd
R9XKQMfi
=EtH/
-----END PGP SIGNATURE-----

--GIH/lxIkkiwnVhCX--
