Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7841DC46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493E1877F8;
	Tue, 19 Dec 2023 18:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TOJYf4pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C50AC8709C; Tue, 19 Dec 2023 18:46:47 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DCA8781A
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5e840338607so1788227b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703008004; x=1703612804; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4A7t4qtEOVftjsqtmXMuYZ91yMkaoLmzRC17Ijcqd/c=;
 b=TOJYf4pjX2odnvNh3J0omhkzMOXKbYXOX3+gC+Lr5z/LIdETkthgQgeh/GSfy/vxWS
 yIYYkarJlylSmVGnuoW4TuYRg7Rzy4D1DuhryoNILZeT2Qn8Cr04SAU4xn81FPSGL/qh
 SjhSA5+n0eV88cDS//QKJkGhzsXEhcPm6RW9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703008004; x=1703612804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4A7t4qtEOVftjsqtmXMuYZ91yMkaoLmzRC17Ijcqd/c=;
 b=XmURqcup59kOa93auf8yXQdpdPdudikg9j9LeGil5fjbsN/Mr/GKZdJ+AakF5NPCEQ
 gUSodEtDWBFqh+toXhgfif0oGaaOlD4nB3T+yJLOwd7rQLBgwBS/reo40UaA1g12vA6j
 j9Zq4IgtivLEa02pwW9QZ1m9rutpV22HyGRBDd90PenA11iO4Oys1Gf1wrx3NnrR6yAk
 nulQuuoEYkozV38fSUmmYoCI8SknQuDmACkxwcHeGX377J1+6ojxYXh2lpEtvb+sy/EL
 LTb4djFCjVuviMYVwmCbA59NDmQ5Vcrrv+kxZrcdvkZBsNQyjHRahxt65I0ua0AA38o0
 hang==
X-Gm-Message-State: AOJu0Yx3SZ30He6SwmVzCmPMznaab2FQ93A9Z8y1GeKNIc1EOeD6dVGT
 XcJfzIATMDVvXr7zHoS4qP8rJ3t3otRA2T4lD/Q=
X-Google-Smtp-Source: AGHT+IHU4aC1UQNO+QL8NguELOYt/Sou0w1BMboqjGnSdtrKRUVGJsOa9LyBxk0lopbs2LOzCjPJMQ==
X-Received: by 2002:a0d:dac4:0:b0:5d9:ace2:e496 with SMTP id
 c187-20020a0ddac4000000b005d9ace2e496mr8695749ywe.90.1703008004230; 
 Tue, 19 Dec 2023 09:46:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a81d509000000b005d774946228sm9629602ywj.68.2023.12.19.09.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:43 -0800 (PST)
Date: Tue, 19 Dec 2023 12:46:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] gpio: dw: Drop unused headers
Message-ID: <20231219174641.GF2513409@bill-the-cat>
References: <20231129214731.756321-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0Fs0NM+RGAfrqrEN"
Content-Disposition: inline
In-Reply-To: <20231129214731.756321-1-bigunclemax@gmail.com>
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


--0Fs0NM+RGAfrqrEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 12:47:31AM +0300, Maksim Kiselev wrote:

> Drop headers which are not used or needed in this file.
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--0Fs0NM+RGAfrqrEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1wEACgkQFHw5/5Y0
tyytIgwAlREKw54+WakTNJA/bASQWwDyNlrmVVBWJpFWCvnnnmIkyd4NtVnObxuU
mnigVUA2xEGQ1Us3c3uqV7yyUpL4NQasoez/pum9hIcXfbzG8HFCskuJDLN95arB
wJwipDDkwpfSTZqW4Ix8BFbF1yOz1dhUCnr0mBERgzFdhgDU3TfderVqHF6mpJCr
dq45Zv3V6auIMVhZA/nROZ2nmZAnW040T9g2b7wFr6HJsb4/qQskvU24lsRUtibj
PA2KtANwjGBmaj2mlWmHLp8FRn8o7PXLl17reVp9x7icckd0g7NQUFVjehL6zFbX
HIHSYc37Z892oYxxBo9Yj7u3nTnU2DthygrZfvkja9AR2BiJEqHBuwx464wC/V76
uYGt3YQp4moLN6dpCscDCIj84IZwujnpjs7HZcit4JetT1/dVd9hwV9GSf5UAOId
sPf5ugPy63tMQcnSjVGi8ZVVohwIIG35xlH66hUD5MSl9+L675qspgg+S9n1zyE2
Kv6gvWp2
=fkg9
-----END PGP SIGNATURE-----

--0Fs0NM+RGAfrqrEN--
