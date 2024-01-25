Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD78BC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC79B87BE4;
	Thu, 25 Jan 2024 17:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="heBq5pr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75B58785A; Thu, 25 Jan 2024 17:15:00 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918BA87BCB
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dc221f01302so5634052276.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199295; x=1706804095; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DV+gwHI/t+2Wh/GIHYq/lMndXK0O0WILdGrxq+6BswM=;
 b=heBq5pr2ch340J9xJtxbCYVk/y3MbZYAjNdUIYSpvZHkKmecP5hkH62PN4iiXbJ72r
 z5yhu0glA0JsAcUpa3fjE8sAy57emcyNd+lPm7Ul53pQi7u/MQSoZ/Z48hUczkqazV/J
 3VudTjFU1MZv2L8NlTqZXpNOn2OmCO9a4JE98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199295; x=1706804095;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DV+gwHI/t+2Wh/GIHYq/lMndXK0O0WILdGrxq+6BswM=;
 b=ngUXmluEa7saVXR6LmYmdxsuQUJq+K6L3m9ZmMb2RDcZ2oAvSoyQ+eeBe3QDfKR96Y
 lDQtrLA5APW/QkJIIrlIseN9G5kSwjHOMDsLhp9vhvyHmR87f85O7IbSxnDjEZjV028q
 nlILZwW6G/m+tfTIDQpUJmhp6a05Xlc60HGEQx+CgFDUUZGAsxDy11sR77i48BXUjIdL
 nOw6GRvuKVcKwmuZZ4cBiEW1WRADtFw4U4flzwxzql8VIzCwuZMOJrJpbRQXhYyaSH8H
 VVSjaslnznjFMGj4PyWF8xmVQPz0NvhAvd3Saeht26/SdII4P1+XWbV54n9uIPzzy+cI
 SfNw==
X-Gm-Message-State: AOJu0YywNJUHA9XHyQzd5kl1P8tx7xiuijFYny+QQkdnvmCQr+azyoot
 52+Va3FxH/ELE+4sjXXSMOQZnpMSzBEQ9ECu0y9LGR04xWtlJK4Zv2Cw9OIty5bjkaRfq3MLm3d
 y
X-Google-Smtp-Source: AGHT+IEemMLI7zR4lRV7pNtwn5xpsFJXq/6HRlnZUl9RFV5mJteEejn6FkhX87QlC+9kGkrWgbaSKw==
X-Received: by 2002:a5b:28b:0:b0:dc2:2d0d:128f with SMTP id
 x11-20020a5b028b000000b00dc22d0d128fmr41256ybl.82.1706199295176; 
 Thu, 25 Jan 2024 08:14:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 g9-20020a5b0709000000b00dc23af43ff3sm3480599ybq.14.2024.01.25.08.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:54 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 1/1] lib: add comment in utf8_to_utf32_stream()
Message-ID: <20240125161452.GV3652023@bill-the-cat>
References: <20240118175450.49556-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c52ZJSyeyceIN05L"
Content-Disposition: inline
In-Reply-To: <20240118175450.49556-1-heinrich.schuchardt@canonical.com>
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


--c52ZJSyeyceIN05L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 06:54:50PM +0100, Heinrich Schuchardt wrote:

> The logic of utf8_to_utf32_stream() is not easy to understand.
> Add a comment.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--c52ZJSyeyceIN05L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiPwACgkQFHw5/5Y0
tyzpqAv9HHT7Tm3W6GQKkLuqrIMP6/AMjWj55C7JMskOdQ9VX4MOJzCJPQxS8x3A
8EeOkgoHJ++efeypF9TUFwyjwU8WJvlyU3SHzaUYgM8Mp9HLh93uzdiwLz97syKd
9CuVgn6QUQivjn2yHbYh3garIqDr+8YSO1/3t7WB/s1BupUJcAAoKddRwNWnX6L5
c5wDLKeJGWtXM1FhYm2sWz121CW/nNr/rYWzttnGN4pRHU24QHmD2b7MidCVq+ZP
I1XYg4upc7FDaLZ2xsZNVgnvhbS+EJCx7Wrjw2m9zR56aNrNJspAsBFB054AaAbn
PVPrqCM6HEdpD/5155W9s1lTP0gAQcX05f6RLoSwqRIynrAn/uJSrydrgk76pehQ
7lkgVL7XOrZyWeChoUrkqe4KXpNXtkaXVKBAJ4ELcvuIRWfvVrnpRn43xR6Dc5PS
qGkn0r7qDuma7nDW2zqczLERgXnLyu82wFpefQayMG7s+KZzBvzjOg5nuuqAH4wE
6jFcad+U
=Pk9l
-----END PGP SIGNATURE-----

--c52ZJSyeyceIN05L--
