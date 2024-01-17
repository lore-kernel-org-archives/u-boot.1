Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500A0C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08D287B84;
	Wed, 17 Jan 2024 15:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K4QqKOH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC0987B7D; Wed, 17 Jan 2024 15:26:31 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 043F687B66
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5eefd0da5c0so114467637b3.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501587; x=1706106387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uwCAhwUCZ3Iultxi8gUgzXatG56myp2WCoGDe8phr9I=;
 b=K4QqKOH84lqw3pJWAGU27RLQjBtCDSPb1bNPgDn29icf8Yj52y12tUtgTTwH+6oiWg
 p7uZ3zvEwwC+iMjS7wVvYi0zMvpRtkfJ8xZK//JCIJH7KTsKcqsjg5+N5wFkwo4sxt9n
 aSoqD+riDYcsWQ43WbOa8WAW7cypgYlXKjEyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501588; x=1706106388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwCAhwUCZ3Iultxi8gUgzXatG56myp2WCoGDe8phr9I=;
 b=FEqsMTik3HW3TaQNtAC4i7cRQuFEf6s/GpbjkcIL9IXO3N4JnDERF8WLsj+Vqy5h0W
 olUrO24ozn1bq6+w2iDeh1cXOV76t244jWGBMBhH4xWQdoW7mEJI5I7tMZ8ZP+83bvsq
 DrF38W8ZGt+rCeBPdrFxiZ9PiYUJqoNjfUM82dQ00XZgtLD7IXnz8Z8Zuh1bqx3q2lLs
 cvS2LhIAXKXX6c/h0KgPI8KhM5JwDLCtiHPTDPFMyKUWl8tgVVv+xLC6S5f2EuPynHVv
 p+HX/xmJiEeXaE3bGlrYZ/bNwS12oJfDK+4cx14bC0nDLWbP5201IeGjwKhDo4gQuUvl
 0/jQ==
X-Gm-Message-State: AOJu0YwUaqc/XBH0KADf6GLuQmZ6FUtMlw6fYmp4g69R2+XOdAjDMZtX
 8oYCTb5ZE4EFycsGgN8VduA0AoBWKY51N0o7Zn225liYGNw=
X-Google-Smtp-Source: AGHT+IFNupvCd0gtcHk3JF+tGWpD35kEPUQYBGmYZyuHWqleLpA2oRSS7VEmVTdzlKOa+q5W87C6LA==
X-Received: by 2002:a05:690c:110:b0:5f9:81f3:85e8 with SMTP id
 bd16-20020a05690c011000b005f981f385e8mr7423935ywb.31.1705501587788; 
 Wed, 17 Jan 2024 06:26:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 w203-20020a8162d4000000b005e1a5593c0csm1785149ywb.60.2024.01.17.06.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:27 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: memtest: Add tests for mtest command
Message-ID: <20240117142625.GL12635@bill-the-cat>
References: <7912602add5224c40b81a823d803bdf1e3aa0b62.1704277765.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="voqLzSBxe99FSuTZ"
Content-Disposition: inline
In-Reply-To: <7912602add5224c40b81a823d803bdf1e3aa0b62.1704277765.git.love.kumar@amd.com>
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


--voqLzSBxe99FSuTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 03:59:42PM +0530, Love Kumar wrote:

> Add the following memory tests:
> memtest_negative - To test mtest command by providing incorrect inputs
> memtest_ddr - To test memory write-read-comparision for DDR memory
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--voqLzSBxe99FSuTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn45EACgkQFHw5/5Y0
tyzvmwv/ZDEGxtiUq7dWOqzxrQ/gzse3NAMIEBYAEN5AgtGdP7TGzJUpjJNC7JrI
j+b3bcWJihDXpmh0oAbKd0gOyIR6dlrXYxc3YYJUsEnjjuHqKKKFYOz4MzeSBRBF
4NxLGFFkB+vKHMzUhpq+0gB6qfWVYq3aD3VxrzsMAOQ/M1Z6eQR4bjZPf5PbLs7F
wcCDF1SCPlVFtQESMcUK9rO5BgPH2Xmpp/tY7JENBgKUGqrOHLzGrcwztqU8cv7j
tSg27lJkQg4QmrocClq+sQRTZKx70GTJnL/JhbTD1Lg6uxksH7dFVmPopxXNlqNi
/vOZYhXIBy5WJQhuXrDPmKT2xQXwLV89puIDfWPz5CzpkK/E6t4im04Y4VMsfEk7
9CcX3X8xagdq74eT/a/6i2GyQQgIHMtqQV+nSiQz8K3qWM6zgivuOxjUXTlQ530A
CZ4+bQNE8AQKQRVpi0c+9nUnyPOvD5TUquIj4ENBj21YtYrjtRY+xPyE9SLBQM2P
mJGKeNYd
=ENEm
-----END PGP SIGNATURE-----

--voqLzSBxe99FSuTZ--
