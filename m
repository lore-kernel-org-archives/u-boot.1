Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32434C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4631587BF1;
	Fri, 15 Dec 2023 23:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mkwyChmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7354987BEA; Fri, 15 Dec 2023 23:48:02 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B7CE87BE1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77f37d19b6fso70184985a.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680479; x=1703285279; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GdxkuSNIG0zuOmUHgw6bm700Y0Hdwgj9naUjMkWzTB4=;
 b=mkwyChmY88j9QMjymeDi2V0mJzghquoQfzpxtVDe2PPgkxAKdgpDafz7yLOWexz3l6
 PaYQIaT3MeShMB0sOVNd53V6ETWfoSI/c1wrLLC5RW+rfAHi7hdRAbbJrKIZTEJo+kdK
 oTiEuNp1k4eLuO4fhSKtIRyEOkIhH3Xcv2fc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680479; x=1703285279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdxkuSNIG0zuOmUHgw6bm700Y0Hdwgj9naUjMkWzTB4=;
 b=nEey0DvIo8GkOtLV1Ce70aDxWu+ZCk6nDK56FE8+/14ZN2+pmaLuSz/jPoNVnRKD22
 DJBL1SJ7pP8S8Y8K+lzHNflGaVRQwwEVmNi14o5PA87WwgatLqGQSBqdslXioq6+iYJt
 UUbzDHUodAsrAEoTt/r8M0ZkDTqBs5V0FRKCDrnjLwwcj9Amil7gYQkBgEkUX/8Sg86v
 ouaeV4TMYTwdT8iQ9QeMDi6pyYRyMOy0XjZiK2V/9Ad5ayKa2hYkHjSBs+9u/9yvKDKY
 aJ0Yxb6fPIyDaZocWc/flIjpPMlrxxB4IdZgWSZD5RmNlh0KcyceoOlDHPhRxUFEHIqk
 a77g==
X-Gm-Message-State: AOJu0Yyncd8rgxtYg3DHwnWw6+HfTRmSEujLSHmW/Op2l/J2AGK/Euyi
 6F/qsRb5EffIZuHBZHyyMv3R1g==
X-Google-Smtp-Source: AGHT+IFm8jh/DLwDLsVrjVNo4YZv/wn7MTG73BUz7+oeYIMfzRfnXyD6ouCK4HNuGl16WqYj35/T6g==
X-Received: by 2002:a05:620a:258e:b0:77f:8e5d:871c with SMTP id
 x14-20020a05620a258e00b0077f8e5d871cmr7656682qko.51.1702680479166; 
 Fri, 15 Dec 2023 14:47:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 dw28-20020a05620a601c00b0077f0dcac136sm6449564qkb.11.2023.12.15.14.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:47:58 -0800 (PST)
Date: Fri, 15 Dec 2023 17:47:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Apurva Nandan <a-nandan@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] arm: mach-k3: Let the compiler size the mem_map
 lists
Message-ID: <20231215224756.GD2513409@bill-the-cat>
References: <20231128170528.407707-1-afd@ti.com>
 <20231128170528.407707-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jKIOYj/gpWAKvQOP"
Content-Disposition: inline
In-Reply-To: <20231128170528.407707-2-afd@ti.com>
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


--jKIOYj/gpWAKvQOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:05:25AM -0600, Andrew Davis wrote:

> NR_MMU_REGIONS is a copy/paste from another platform that extends
> this list later. We do not do that, so let the list be the size
> of the initializer list.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--jKIOYj/gpWAKvQOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV815wACgkQFHw5/5Y0
tywsEQv/ZmNUFgFt4jv2rza4eB9ObewnoUQF4wW4CdWhJdmSpKDzs6hE553l24Fc
POij1509b/z1KLSSnzpOJt3X7d+/tIA6UEMyG/KVE7l1r4v8Rc4aCMGF3TH6eusR
GEGl8gNY+Uv/LqHeyP5lHobs9/gir2L4M169pwjCRXKakdKqu6gBa12txMiXYcf4
rrJi1veWlTN6UCeSvclEgPSbnhGHR3Py+gHROe7ep+B95zjO7QoUlnjno97icsMv
0UMcvo9Ym9NVso93mLTde2KxqX8iD+f9NBV8x238VCpnuv5gYLVnNyxtEepXb6Km
+CbrhnqLrCo3DPgm4XdeOt9shgSkHQJY+a0XKNLb07p8PqeyrY8a5eZyL9kK7vqT
NJ6rzh3PuxLaManUr2jdW7WjvJS4wYuPaF+QC1Ua7Z5hnvTi8wo1m/hbPWo8tp9W
XfXlwIifI8I+4xuBO0sC7YKymGw+HueyIhJsiIxXWKjUdGyyDFQGxgjbV6dPOmt4
IkreFFle
=rtrQ
-----END PGP SIGNATURE-----

--jKIOYj/gpWAKvQOP--
