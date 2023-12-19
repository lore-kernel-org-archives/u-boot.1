Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B828AC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF33B877D8;
	Tue, 19 Dec 2023 18:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U0a2M9um";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CE38709C; Tue, 19 Dec 2023 18:46:29 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B25877D4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e75005bd0cso15858957b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007986; x=1703612786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s+FxJvBZSQ4wNVxSklC3Wos5Hx9maYusUSnhYevgFpA=;
 b=U0a2M9um7AD4flo57NXrO/7/rKjDsRnHw+Hi2DNIb7M7qgSWI8Uv1dL26k53xOjSHP
 MFJndpS79fudaYvzbfkz/u6dX2c7vPq/CUjYeI0xDxsmICjwnvbuIG1rrzqxlewB4j40
 NS0gm/lfeNkfGIMGfitU/zFMAMGf7YVtpfQQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007986; x=1703612786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+FxJvBZSQ4wNVxSklC3Wos5Hx9maYusUSnhYevgFpA=;
 b=b6/3ucsQGxCMsj1vWr5hU5wLbmu5EL+Tya6j70Wi273lwTMWoweJJFbMB/0jRdMEMS
 4R/3jLrnJiTlvmquFGauz7yXr9aTQ1VR1umKMbnheh8s2AjAiBoZGp5arlgzB6fN1m/y
 n0M3Fs8ehjNb2qmEZDN3uuVhFydxQAkvkHg24GGMX8t+JE0HpIOnVj835jS+NEnd736I
 8K9ajmUleiXiBOYoaGDbr1PylNX2vNUKwJ27nn89s8j/LA9LeNTStNhmSyNwFCGjE6j8
 YGVm3SIGUVCAsbcweZmQs0UScwQPQP5uJzRHfhzYJKH1dTSOjcezo76vzxJLimXfRi2T
 ZqvA==
X-Gm-Message-State: AOJu0YyVEyVHmBvZIDBDxE7wLjexKcaeWidy+fCRORMtsvUBpvDxfBLs
 fO8Ts/32aKOd9U/degxAWuLbKA==
X-Google-Smtp-Source: AGHT+IHcbAGxDhPTRsS6A8SCGTgLC3yreADPmVmLAlTX3sTG5ve5RIMFVltc+zat6VJFioiirlXMpw==
X-Received: by 2002:a0d:e60d:0:b0:5e7:9010:e05f with SMTP id
 p13-20020a0de60d000000b005e79010e05fmr1447043ywe.1.1703007986257; 
 Tue, 19 Dec 2023 09:46:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 em13-20020a05690c2b0d00b005e3f63083a1sm3572416ywb.97.2023.12.19.09.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:25 -0800 (PST)
Date: Tue, 19 Dec 2023 12:46:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, hnagalla@ti.com, a-nandan@ti.com,
 vigneshr@ti.com
Subject: Re: [PATCH v2] remoteproc: k3-dsp: Avoid reloading of firmware
Message-ID: <20231219174623.GC2513409@bill-the-cat>
References: <20231125182939.1796956-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="05T3vQKeG0tpjdbM"
Content-Disposition: inline
In-Reply-To: <20231125182939.1796956-1-u-kumar1@ti.com>
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


--05T3vQKeG0tpjdbM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 11:59:39PM +0530, Udit Kumar wrote:

> DSP core is going into abnormal state when load callback is called
> after starting of DSP core.
> Reload of firmware needs core to be stopped first, followed by
> load.
> So avoid loading of firmware, when core is started.
>=20
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--05T3vQKeG0tpjdbM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1u8ACgkQFHw5/5Y0
tyzJIwwAt5ohDXfbY6HVABbdwuXpMXm8Y5pnGXJ4BPxbTZBcDVEaholdhUWXoPyq
0NsLO7QKrrao7q5W8Uro+vRCu7C4KMORqxvOSfxUN0ERUn0C1QgZn+mcl4k+5RIN
ot84n15tYAqT2PgrR7drrZy9cIRg1WFKziVvRAPK6QGFLYw8t44bi19leiM+G8u7
6EYOdJU/Ffu0IymlnIJv0+M4t896mHjfm1hd+lRlvQ++coy8aGEJZCngpXAjV5lt
ZWSs6hrwH54PwEPNAcRjrnreuLFpfAs+nJbOToGsWAZehgpFSegEUIYhMXO89nhc
ZRS7OFgM8UR/GKk2MGq//zv6HXYch1C/zdr3tr0nkHHZo7IRkn9CQ5kge/ov/D74
DVAJbjb4vpBW2dyYe9cFVk4HPPRAI3oPwaPOE8ZIBJO7oVl1oRqAzBAM3r3L++Ct
rVke1A2ZwrApsxjo2nrl559rgZJh12P8qHZP1nTx2AXeCcpT3/yNbqHrIG0tugfw
m4fSGVc+
=EFYK
-----END PGP SIGNATURE-----

--05T3vQKeG0tpjdbM--
