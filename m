Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524FEC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A475E875B6;
	Tue, 19 Dec 2023 18:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XJNSaAp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E86A8752B; Tue, 19 Dec 2023 18:45:36 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD0E86D33
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-da077db5145so3002026276.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007932; x=1703612732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kds5KFIeZFi99rWCgv3Q+qsvJcrYA/fDiOuyeSJfBek=;
 b=XJNSaAp4x++Nxvnt7QZkHPrU2eUlk7/2M3RskLJbAdzCpWF0wfQIcatqgLyNe9kRXv
 uaEHpc5nUWsrhuqQxOX+pwgQtmSWrmUJVG7N6cVRk1fQxYaXo+veyMPHAS/KfMqcqDue
 vVfQxQym/oJv3b8L+eKiajJPldkbWBawrLRXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007932; x=1703612732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kds5KFIeZFi99rWCgv3Q+qsvJcrYA/fDiOuyeSJfBek=;
 b=u/H80JjzRHtnSiy6HRY9sscdj5ZGCR6fxIOfhsWhNYO+JOnV+KEemNDMolZcyMtD3P
 8+QFN5MkJK63N8eG0xu9VZXym55jBKs4k7fyj+2vhbtyXHApAQGbilOZPuvgSLNdWubF
 vqU28JJMeG7wI6hG5DouutD1AMvTqCZ6TAkQ1t3pEiVxArYD+CSit88p7osTDomKY84D
 DYmW52PMrKFEHY14lXsX8l3tObzIF9JMSF0CT8ZdZnhh86Oxb9x3jitHLK6/cXiQatLX
 1X6WZMw+Cj506IpJDonts78rA39rsY1ZDKByxxrNXlM84McZTel/RNOhKwRxT9ImRTAP
 5mBQ==
X-Gm-Message-State: AOJu0YzWQWUVoqpQ7rZQXVMa2lTv8CIw9pJ+yvEhFG09+bxGye48GkEG
 YkNK27zmMrYqT/Pvnkmz0S2m+A==
X-Google-Smtp-Source: AGHT+IEezlTjlEcXW1ZhbMEA8ZgvCC0Rl9w8+MMYSgfii/NL+D/ZhwCkGT9+vCvYQHTyDPMYa+iJCw==
X-Received: by 2002:a25:2e4b:0:b0:dbd:38c:e612 with SMTP id
 b11-20020a252e4b000000b00dbd038ce612mr3604501ybn.84.1703007931970; 
 Tue, 19 Dec 2023 09:45:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a25ac93000000b00dbcdf062499sm4711464ybi.54.2023.12.19.09.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:45:30 -0800 (PST)
Date: Tue, 19 Dec 2023 12:45:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 10/10] Makefile: Use the fdtgrep -u flag
Message-ID: <20231219174528.GW2513409@bill-the-cat>
References: <20231219142128.2388562-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1OddsU6uhhR/WfLW"
Content-Disposition: inline
In-Reply-To: <20231219142128.2388562-11-sjg@chromium.org>
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


--1OddsU6uhhR/WfLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 07:21:25AM -0700, Simon Glass wrote:

> Use this flag so that the bootph binding is obeyed correctly.
>=20
> Add a comment about what is going on.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/12

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1OddsU6uhhR/WfLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1rQACgkQFHw5/5Y0
tyxrGQv/ckPJs6OgUA8MR2iiO60MBmuxBOy4B9ClGTjP1FS5375KP4LSkBwBzFhV
67M3WBqL441WhFXxxn/8FC4WsM2sFTgscNI/MoicjJxZBrGUef1TpmdXDgCGjMZQ
/O1YL698ggTOBjWkV0+Wp/qjAI7vN6IDt4b0ang8SvmU+0MjE8llU+memG0LptFU
xUcL5eojOeGOwq/0dPF4Ll89/jWbSKuGoRMVlPYELe9FMCFoNJIxAbpxufM4SlWt
fYmDRC2EOku1Erbge+WIHcboTHm704xfCZtv2cyV73L7frox+VqrJeYm7acJx4dB
zXvhMIsQKdFXRTrKR6VjrSMqkmzyjisDrB6j35Zzjx2wcvw2Axq/zM9LZEIWXFiT
JdmHpBU7/yYmYN1ldVW3RmWc+RmRsxIjH/7YX9dyGPgkVGTlrIn8ymxcozwhYuik
KOzh0kQfA7m7v83nM/M2225hauw9z7MJ/YarrEohvQEcsEkKRM/byAVz25VQ3ZwC
gEJMROwj
=liup
-----END PGP SIGNATURE-----

--1OddsU6uhhR/WfLW--
