Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A01DC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4A887A39;
	Wed, 25 Oct 2023 01:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K3me3pLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D51B879F2; Wed, 25 Oct 2023 01:17:28 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B833387A12
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7eef0b931so52240647b3.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189424; x=1698794224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e5jp6gw0ZfOak2E3zTdP+urljVPdYMGUetVO6F2wE7k=;
 b=K3me3pLWwJJ4OGdL1OCzQCq4QRJetvwCRNamGDoW1TTZdH046rPiRNmBXyz+bwqvZQ
 Ij1yCpzuB5tI2BeMPoInGQ42ccq/ZcZxv2ZZhYMe1Mk2TpY1LnXKm6j5bxQHJ4Qfn+tC
 j77uF6I76/2HZZFxkY2jDKL2w5TIG/AK29aNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189424; x=1698794224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5jp6gw0ZfOak2E3zTdP+urljVPdYMGUetVO6F2wE7k=;
 b=gKfNG4rnc8UzJCXcA6Sf2BvssPnBByXj5cvSc1tI4tdvy8xBFVeXSZXdyKL5ZAFHIq
 kiI+xZQaAIltYTRZMy0oZxz6uOWUGnhUgaKaD9BvJv+p/CGyYseV19jOkJRJO5QsMwvY
 8VgNWaS8MNbBmK3fAPi4sp2J4mWBeAM1KpEVDWBDWJHSlO5d01v0UBqmZGkkWVMK6eZ8
 5AnZPcx1bEtelWqBeZTox8eHBKyqI7CEiehXZF73vN3nniicIEKH3P/fYTAZPBM85FNu
 EvvKhb5DqZUhrWtDK9kt6vfX4vqyw0WXX+tyleSc2gd8SAkfwIiiBVc3yfUo1XdTAY8V
 dk6Q==
X-Gm-Message-State: AOJu0YzGdU9w+Rr1Po58arevuSbe7J8EBFUQ2MQulQXV/HN6wc1k4exq
 Df5y9y3fdXlvUaFVmwl+lLCQNA==
X-Google-Smtp-Source: AGHT+IE1pS+qmAUMwisNl8ngildQWzr6tbv8RzE+eEJ3NHfMdBKHkF6QK1uOI7Z9q+xhkX3kLpYTTQ==
X-Received: by 2002:a25:50d:0:b0:d9c:aae9:10f4 with SMTP id
 13-20020a25050d000000b00d9caae910f4mr12797404ybf.4.1698189424649; 
 Tue, 24 Oct 2023 16:17:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a05690203c900b00d9ca9243ad5sm3871220ybs.38.2023.10.24.16.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:17:04 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:17:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Michal Suchanek <msuchanek@suse.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 2/2] serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE
Message-ID: <20231024231701.GE496310@bill-the-cat>
References: <20231016083522.945453-1-rasmus.villemoes@prevas.dk>
 <20231016083522.945453-3-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q+JvkpsTJ6jHe+nB"
Content-Disposition: inline
In-Reply-To: <20231016083522.945453-3-rasmus.villemoes@prevas.dk>
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


--Q+JvkpsTJ6jHe+nB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 10:35:22AM +0200, Rasmus Villemoes wrote:

> When debugging, one sometimes only gets partial output lines or
> nothing at all from the last printf, because the uart has a largish
> buffer, and the code after the printf() may cause the CPU to hang
> before the uart IP has time to actually emit all the characters. That
> can be very confusing, because one doesn't then know exactly where the
> hang happens.
>=20
> Introduce a config knob allowing one to wait for the uart fifo to
> drain whenever a newline character is printed, roughly corresponding
> to the effect of setvbuf(..., _IOLBF, ...) in ordinary C programs.
>=20
> Since this uses IS_ENABLED() instead of cpp ifdef, we can remove the
> ifdef around the _serial_flush() definition - if neither
> CONSOLE_FLUSH_SUPPORT or CONSOLE_FLUSH_ON_NEWLINE are enabled, the
> compiler elides _serial_flush(), but it won't warn about it being
> unused.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--Q+JvkpsTJ6jHe+nB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UG0ACgkQFHw5/5Y0
tyySSgv6AzddLELJTepMWQt1RtEmjKiUTZA1xtWknH5qFisLSXy0A91QSrYcRnob
ENHbrZyUPtWiQxAI92aqWqeQubj8htOkiJSVOxx9z3tmJtg3V4JGkjBl0rp+eBIT
haguMlMGCpY/VSIHLm3Xjbf6HRKF7f8awmNaErwQEof0cRZqyqwGjw/j3jF2jiOd
p627L81mhZev+Nny8/Ki17Ohk3OwS9/ktv+tW+26ovH1MjEDMnl2kcMpoGYIVtFq
cCOv3B62lvHdp1HpFh0SzhQSZuHRhedSylAN0TUEF63wcBp8zN2pH22EGhlB5CJb
CRO50IypgvR4EWsabdYtxJeePAv7+JgGt/HlkEjckWxPPvEYm8IK/01yZTf2nbhU
/xgaZWxD2GdviAFMI4+fBYAwQTmXH2agdjnLwls+M+hI/Ha6h9GH1qVsUFyt0E/U
DzjR+FZob7Pb8/maJXq8kVxTp6riecvOzSp+g/O+0l6w97gCjTmjIEBxpE6sxJiZ
72xhoELm
=CgVe
-----END PGP SIGNATURE-----

--Q+JvkpsTJ6jHe+nB--
