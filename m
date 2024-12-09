Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDCEE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F228977F;
	Mon,  9 Dec 2024 20:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dF4RtwRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D93D58975E; Mon,  9 Dec 2024 20:01:49 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF2E189723
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6c8a0951eso178115385a.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733770906; x=1734375706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WKWUvPxt7dVkQ24ZRajkH2s/qlN5rvLGdWeDMzoyNxA=;
 b=dF4RtwRX++226uHfqT/s7B5p3MjK+aUpqB8vRSH2CgihBKb3gyPBLwrDOoTIN2s698
 oJZXTGky193ItvNzWM2Gq49061zuOnrZDjeSHz5J3Whqf8yCRLUWtgnfg5Cd0EPq/taD
 r/6+iwAYcS845Ce1uJJoAIkl76EJ9cQp4UNDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770906; x=1734375706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKWUvPxt7dVkQ24ZRajkH2s/qlN5rvLGdWeDMzoyNxA=;
 b=Wq1BWfULlrOu57nEC4TiSuxTuret4bWp5kf1qVzR02iCrb+2waNBZ+xUJhakYRRi5f
 Bc4VxZcYRMDMwZ2agV/W5NA6WHBMmsKRaFFH7Z9lk1QMw8F20lURuaGy/CmxAVSLKBHd
 877bzER94CEQNSeQSl4mvYbVK6aaNF9UstjuHzHcUpNzOOYiAPxCwvaR++HiAPLAA9tV
 dbOQwA5EMCbYu1m/kh02kffhZpJpcPh5+UqT2JjewATBsZ9kVgFz5rJCyUkPCr4NR2A8
 xjR3V1IsNxCMTmVujFqCwNELmukfGyO7bci7g59dfzsqUZNbS9ig8mi5Z60K3DhU8WNd
 7Qgg==
X-Gm-Message-State: AOJu0YwXrpVrXHwKf6EkrKTU6yHzHdm2sVb0VnY+JhroPnkxhkrX91/p
 W9YAODgEKISU6fqJcED5fAZsBVy08ysQjwgvXFYNNEzNfmHDP6LtUGIZA09F/bs=
X-Gm-Gg: ASbGncuLXtfek736093Db4Y9WWnGhtwwYtLkNDSQJ4QQCzhdusEOzzcXpdcCifKwQhU
 jy7gwQwbhgTwFAqFSDVANnrUNoFzrXTV6t34EdZyRH3zPwsojfVFcBHLEM83O4AWeSwBmlaeAc2
 Jpz9Su/krqTb1D61BH87zDH0dnss3I48C9dl9pxyiSDVevLk4lnlwu8VM3Ek3E4EulVOoLwXZuN
 Gsi9oVa06LQwiA+fveHxtvAfR8AOHptcy5nMtPKfUfEp94hvUA=
X-Google-Smtp-Source: AGHT+IHkHEMeTnSEgwSLlk0FO6+xD+I3aiQIfq0NyLxCEHm7HWz1pNGoDXnEiOc9DRloyvVlFBO6XA==
X-Received: by 2002:a05:620a:248a:b0:7b1:7f5b:72c7 with SMTP id
 af79cd13be357-7b6bcac1c2dmr2267973285a.1.1733770906341; 
 Mon, 09 Dec 2024 11:01:46 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6d7086eedsm112561585a.1.2024.12.09.11.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:01:45 -0800 (PST)
Date: Mon, 9 Dec 2024 13:01:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 2/5] rpi: Set bootm_size to 512MB
Message-ID: <20241209190143.GR2457179@bill-the-cat>
References: <20241209182002.671953-1-sjg@chromium.org>
 <20241209182002.671953-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1NkeYINt/NRzXf2O"
Content-Disposition: inline
In-Reply-To: <20241209182002.671953-3-sjg@chromium.org>
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


--1NkeYINt/NRzXf2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 11:19:58AM -0700, Simon Glass wrote:

> Set this option so that all boot images stay within the bottom 512MB of
> memory. This should allow us to drop the fdt_high and initrd_high
> options.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1NkeYINt/NRzXf2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXPpcACgkQFHw5/5Y0
tyxCXgv/Sw7iIxHCresogj5U1Y21GbS1v24XNllqR6GMGiFOhJaFPM0k9m6b840L
ACBbH/NPBUr+NtxVlZ4A3Y/9LWTjCdYano5I+lFtiBnzg2z/9KDh0bGbPUcAUsQn
hlno1vC7jiEAYPZ5mxxWnVAPTi3lMVvi51FNLH3LKqm3HAfoOFjGS576N9uDnqw6
MHrukvvE0420cUMRS9W6tK21uZrPU6ooYLPDfRQYg12OLc7yDFdZVjc+EvVQofTB
G6smjoajIxbgfa6RcRlagbldOVNw6taRx2xT3wYJfarhyvC5CPS9v5u0mEruY91O
2OCCoRFNc+Od5slh2Zy57Rvnm5ew8h0U+aHDUBGYojSpwSQiADd2k9CN1V/SmJeZ
4YZ57oIpb4883+Z4/ad4Gb82K5/3NCpYhZm+7JVFZQsHk4MoI09c6dSK4t9bMs6W
MeU3v/oH3EhFJYZJIf9uquHHrdnyXWggI3oZD8ovH/bafXYzO7TWcw0T3F7LUbsp
fwhhzdbx
=2vjv
-----END PGP SIGNATURE-----

--1NkeYINt/NRzXf2O--
