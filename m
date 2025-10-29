Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DC7CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 19:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07AC8004F;
	Wed, 29 Oct 2025 20:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mSu0HBMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C6681E13; Wed, 29 Oct 2025 20:12:36 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC87B8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 20:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c53215c3c8so134269a34.3
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761765153; x=1762369953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B63110PYLf9TqKjzymGLZy0+h7qGxsaGsefgXj5qDh4=;
 b=mSu0HBMSjBH2RBT8DV5semr6Meoy9DyS1OjLjLWmdzH0+mDpbYHoO1Y9usahW3GCNb
 CQTFfn14GKRhvrWsiqg2yYHXt6TYuq+nYULx7qVoQArPhoxD4EMlG099PA/UMi1eXxne
 LN6OiuzjgmKbIsCrzqcRg1XyU+2SUG0jZq6t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761765153; x=1762369953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B63110PYLf9TqKjzymGLZy0+h7qGxsaGsefgXj5qDh4=;
 b=Ho3cs04DiWdneevZwG0p1merfib0G0K9WCMQPC8i7kZU7uqFD44qTOu6iIVGma13o1
 OIck/oCnI2YjL74bwGjlMIu6rmreAebcwJL07D14SKp/tgj6ylNUbzyNXhuNFmh/zIr3
 5hp7ROd4GfeY8pbvM+ZDZhxrtyU7ZX99Iv1VXMNXkaYbcFT48IJWCuyVBgKkwWHT4x/8
 hR6YovkFL6LWBdNo5Q0Yd92isZropbbB0qnM0TTJFLrgD201byhLw1RIbLQJ7OwlBCjj
 aehpd/x+BvQhYu6NoPdKlAleVOY8KNXbJ8X4XOzSgorLes3QyJHkzXmPFskM8T6uW7bl
 42Fw==
X-Gm-Message-State: AOJu0YxIOX6GyKjTyNQaZ8zse4KFep4Sd8mfWvsYAgTmTk5RQi5VZv2+
 6JikwlM9wTjjVhPjqSLTp2Twcu++4bJ3syxAZrg8jAN14ixcTF51Cdu2hBnlPqHFFL8=
X-Gm-Gg: ASbGnculeIapDQIvfgCIY9kUio7vkz5aOnwz8L6wLDe0JuzDZMvZ12NyliaMgMDz941
 tXGYlbJdG6GR9Eo1tdTqsE5Md3STlPCcvsFOsmGx2x3Sky+GH1CTL52yLifxKyJtZyCUp4+13Uh
 s+MxV8CkK5z3ydRhEjzbGJ6u57oe+p3q19iytxVpZU9JzrGrPXmUGJjkPkg2ZDelVdOyOIWnRE5
 Y1k6ItrlK2wakHwpO+cLnE6b7+g8ptpBngk0+rZUhpYG+BxPbl85Bd8HLf7OKjPAmedaQGydeeN
 0NByoitXwpRvl2m8R1rBJDmCtRNWVhuC/d/YL1ePN6IBFYCMT6ZTda2nTAQpf4jN0/eAWFK3W0W
 QCNB8Gud75kq6XDzqRDU4I5/NZNvpEQ5ahrjM12HQYdjcK/wsv/TuRaLaJx3k9UOokmUsUNwlWQ
 1QugZE66u0UIhAJ872dX9GnHSohehTdB/HWWz3E7c=
X-Google-Smtp-Source: AGHT+IHq4+tBKnN1KRNJwmFNqs/FEQEB1ZxepPlH5Dc/z6HXkkH6jOITXtXOds0IK03xwfWfIwz7Yw==
X-Received: by 2002:a05:6830:6d2c:b0:758:6251:2e5c with SMTP id
 46e09a7af769-7c68cfdfbd7mr375852a34.31.1761765153331; 
 Wed, 29 Oct 2025 12:12:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c530005afasm4418913a34.0.2025.10.29.12.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 12:12:31 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:12:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Sukrut Bellary <sbellary@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/3] pwm: move all PWM related topics inside a Kconfig menu
Message-ID: <20251029191229.GL6688@bill-the-cat>
References: <20251029-pwm-kconfig-v1-0-80186567f2e8@cherry.de>
 <20251029-pwm-kconfig-v1-1-80186567f2e8@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hN+h/R2OoaQWUmeU"
Content-Disposition: inline
In-Reply-To: <20251029-pwm-kconfig-v1-1-80186567f2e8@cherry.de>
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


--hN+h/R2OoaQWUmeU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:16:08PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> So it's visually better split from the other subsystems when using
> menuconfig.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hN+h/R2OoaQWUmeU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQJnHQAKCRAr4qD1Cr/k
CnHuAQCKdm9R6y5lZRvtfejjIcVG/gWl3HnH9FliIdtgp8kJOAEA1bBa6YDeKDSs
r//5JRa2giZRZADzvBn6VyRfLlh6vgk=
=3le9
-----END PGP SIGNATURE-----

--hN+h/R2OoaQWUmeU--
