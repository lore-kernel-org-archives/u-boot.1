Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0D2C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EF884658;
	Thu,  7 Aug 2025 17:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nTbyEHkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D0284658; Thu,  7 Aug 2025 17:54:24 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA75845F6
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c47631b4cso858928a34.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754582060; x=1755186860; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JIOLt4h21Tj8EermekSFoQa6Vv8lRmPByBSAvOl4UGI=;
 b=nTbyEHkN4KIED8KpHbk74miSt97M/J74dagxoUEPNEho5VuFyusQFzFbid59wxt9IR
 JtnfSzKU9S7Mk9H05e+XdvvgFF8FAnRO2dsPZyHehdCWytMjXuzFpPcycsf7k+FV4CUI
 gZIbfTdZ4kK42GAs4kbqN36tbkHY7wJGUizrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754582060; x=1755186860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIOLt4h21Tj8EermekSFoQa6Vv8lRmPByBSAvOl4UGI=;
 b=S5K4/2QUf0Vlkj6ZehN7J2vSV5CBPE/RxO/PaZmdurf1NmNT+vSA5DBwUtnm36IP49
 t2fUvwXDS8Qw1eXckkc5cm68NZgdPbU6LngosjULV8mEvXF+g8r64X+oXZrEPSPbzKiG
 vxCPYUuTCKi0dPVHJuRshTNa8qBQLqNwrdb20vh5bZpi36ihBVnlviqEy+unqbT7EpS4
 mrMGKyXygNf2FWvWuRg68PxYkK7gNDYVK6RBO+H13RReL7dswwruPohsmJTSnMbSzsHA
 vsrE040URg9hZvshl45b9Mau9/lIvYik55s5cZA207i2YtR/2fQuFsvEIj/YOxUAhddR
 kaAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0xKeflzM7R5y+Lgty8sPNI+OYC0FMHRb7jXHZmVRq/3nepuMWo9FiQ48B7QezSizL3Fn+zz8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2rdki8wL4XkhNMTPwTv6gGCRWmRVn6CR/7Ov7s3qlw12u+q9W
 LneC11ZV3ce+MJ+d3P0Kn4mr8xBzd8l0gnRo/5L1grlJvMTGsIdl3TuaCzbnX1jPIfc=
X-Gm-Gg: ASbGncuicOe3vibomP3zyIRU/94OConlneHuvG3bWr1MNxE1jxtZN1QuPclZkjAYFCb
 /FhMwVQlmH4F0lWt9cqgFwoj9FmAsI7kOlM1FxWItDNwu6hnHETlGzALjxILDzYI4UJqVFt41wp
 2R5lkMYM57/wZoHoJidskan08O7HLpQON4GgttngTxJfsrGWhNt/bSsAUFnH7cM9ShFBHcSPBPq
 hE8CZFvGQniooEUqM/nvWV1OEvYLPKkzurnYZnUi3Y+dNsty8dYJhDcmIth0h36kbinZw6T38R/
 G1jJtDC6TKL+QYwsmj+S4pGegKchMOllEoz3t9Mk4BfZwGEYpuaMYTqU+g73P8HnhRIiKKRvd7r
 Ol+zyhsEvdNVZi+2gua0XNITLX6FWKRDVoMUXAkP/tTMKxGPLaTUjjqLH
X-Google-Smtp-Source: AGHT+IFMklJh/kVL98kot1aIJH77XfaJ8CzOiHRVuG9FHsphAnXAms0LvL5ubEdaDrrZ2/CijEiZrw==
X-Received: by 2002:a05:6830:915:b0:73a:6904:1b45 with SMTP id
 46e09a7af769-7430b28cd53mr4724515a34.8.1754582060562; 
 Thu, 07 Aug 2025 08:54:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186cc4e0csm4044804a34.20.2025.08.07.08.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 08:54:20 -0700 (PDT)
Date: Thu, 7 Aug 2025 09:54:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] test/py: Read from the correct offset when
 initializing capsules
Message-ID: <20250807155418.GY124814@bill-the-cat>
References: <20250807080819.1058411-1-ilias.apalodimas@linaro.org>
 <20250807080819.1058411-2-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ics7oVkc5NhFaw2/"
Content-Disposition: inline
In-Reply-To: <20250807080819.1058411-2-ilias.apalodimas@linaro.org>
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


--Ics7oVkc5NhFaw2/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 11:08:15AM +0300, Ilias Apalodimas wrote:

> The current code writes values to a flash offset defined by a function
> argument. However, when reading it back we always read from a static
> offset. Adjust the reads to use the correct offset.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Ics7oVkc5NhFaw2/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJTMKQAKCRAr4qD1Cr/k
CiJ4AP9ZthOsUOYUMSQrv8Q5ohBwzX4Jcb/gQoOqT24VR9P7xAEAgd+uHBPyRQ1A
CAgdeZUBipLEkmKpDlE5L27NYRbw1g8=
=0Wo/
-----END PGP SIGNATURE-----

--Ics7oVkc5NhFaw2/--
