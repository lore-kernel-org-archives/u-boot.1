Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2174C83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 19:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2120B831A4;
	Mon,  7 Jul 2025 21:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nW9UFACn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CD0831C3; Mon,  7 Jul 2025 21:58:45 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0443D8318E
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 21:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73ac40e810eso800663a34.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751918321; x=1752523121; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R4l8PXzG0ON7+9WPuL1f010mie+HJFXfXqRZJhubhzc=;
 b=nW9UFACne/bhLSEU0RuvWklnC89j6SxoZjzpZK5yJxfXsKdlsYP36xEdj2HpHFMv8M
 RL9N1r+p8vt19FiW/8re+VVimc3GusYzmWbtqWBxDZjhSAd5IKHwsPhRmPkdAzg1bkIi
 tssCg9BFIyMhXf4ZrMWD7AUm88lkPNn4mGAw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918321; x=1752523121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4l8PXzG0ON7+9WPuL1f010mie+HJFXfXqRZJhubhzc=;
 b=syjYuC/0pS41RMc+XD5T+PD958qp78JNmsza3APcaYKOkBXxQpIOqtLdOCe2L8NpeO
 WHptRFmgmorh8oy+OjHqL5d1bYRkUR5sLsnXZfoVW4NZV68sZq7iaO3AGaDy9HBAhboL
 opHCY8MiRKBPrO8UrpSReTQLOz6HcoyUa6S6sEelht6+FNqKqHZZyyehoSt5YfDOJumK
 EpK4dcaotRNHAnmshge6pU15twuTHR/nf9j87go0H7LYZEjvOLNoJHAjFGdgZaMoXUlz
 N4lxHQ85u0TeOj8bwH9ywhMhG56js1tDkOtVOo4x165NmTTv8GyeHNhpajx6SMt1Ryz4
 tM+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0zL672WHxTys+qE24UqKCVZ+BeRfwFhK3i6TUtFcdMpQ+Rzi4A8Q80Bv5RgNlJE5k+L190Cs=@lists.denx.de
X-Gm-Message-State: AOJu0YzvkzBVHQLKXlmlf5qK2VzlpT7kUpGaluPgzBYsqyvLParvqlL8
 2Sr5FXrUR/UdWLK44WY97TM6wlZsidOhfe+XwI4wpfm71QZo9HqYTDEKOEeqJJ9aJBk=
X-Gm-Gg: ASbGncvhgIiJnhpWh5TegY544vlzPvyHHmUjfnbXev/aYFA2ENb3zac8QloFAYa/N5g
 FLeYdqaYg/zGflAufX1JI8JAgApSmdyiWas+gXr/uWraLI4gLt446KL6JgpS+sx9KajHTVLmt89
 JDPvGdPQgIN1xz3oDnyzq41ne11lRtOUDLGdGsang3BLKBWk+a6ZjEuv4Uy93+nKdJelA3rtOM+
 Z480TQy8xDwYCORX0UjPDObmn4yDrTcrV4+d0m3ZTWNoDBwoPSzenbyS1agL3JADlqWk4nhKmyn
 36cupkIsw1pjOHKa9AZ/VVt4NRg9DFoa3dKAlunAy1JQt6qnXjVqWn6uyjwyvKoPTTr5qQXhlfX
 ceHFnhgg2Knh1e/dU2Fmr
X-Google-Smtp-Source: AGHT+IFr1R5mt/jG4p/qfaxLyvdQPj5L0NAe1P0IcNtjx9STZ9wxrVIh68bVwoHsTtJAfmMdvt/gPg==
X-Received: by 2002:a05:6808:1a17:b0:401:918a:5b89 with SMTP id
 5614622812f47-41110337dbamr647719b6e.26.1751918321493; 
 Mon, 07 Jul 2025 12:58:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02ab103esm1394951b6e.29.2025.07.07.12.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 12:58:40 -0700 (PDT)
Date: Mon, 7 Jul 2025 13:58:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] ofnode: NULL check bootscr_flash_size before
 dereference
Message-ID: <20250707195838.GO6424@bill-the-cat>
References: <20250703-ofnode_fix-v2-1-2e529f21ba7a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i08WyWIvqKhFtisj"
Content-Disposition: inline
In-Reply-To: <20250703-ofnode_fix-v2-1-2e529f21ba7a@linaro.org>
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


--i08WyWIvqKhFtisj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 11:04:29AM +0100, Andrew Goodbody wrote:

> Move the NULL check of bootscr_flash_size to before the first time it is
> dereferenced to avoid any possible segment violations.
>=20
> This issue found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--i08WyWIvqKhFtisj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhsJu4ACgkQFHw5/5Y0
tyykpwwArNUz15FCR8mvu9zquvUOcHZTaWbTGztwdBffREAVPGDxnhM8HZo+s5Rq
N3avkt2SnLy8MIX1jq0xxHgcZegU6XqYKpcTvamCYEt1epZqz6NPLK44R+/+ytFd
+QX6ZBSbKXcQJGN6xUrjo6mXa1x06Qq/U8UAuAytLjvW7PxMc5TLeSe9fNJvdeU+
g/2jahaXX+0Ij8lVt3VXALC+iMLeQ1X66wE1ourngcs8bcl8T1+ns2+ojP6kMF7g
hc6YZR8NlmvecNUbcKqNTlElxEnisOk/FkmuNW2jVSVlcsX8vGxrrIflvbn/LnS9
bhoSWc6YtsChRZ5xF8Mn+N1VNTQPwvOjZ7WUUjqzwWcZGtC9QzKIhT144/8+GjZd
eituntDZD3nHnM/YuExqN1Jz6kUb64833TkgoAdr5Eepw9qNXgezaFfjWO8a9QMN
vX6/ueuOfZUmdntnp9xYtNbYs2aEVQPNlQ822k9kkllak+9OT8pWaHzR5eFGxH8R
TcS62AUT
=DFrT
-----END PGP SIGNATURE-----

--i08WyWIvqKhFtisj--
