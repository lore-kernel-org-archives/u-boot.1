Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75F3CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 18:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62B0833C0;
	Thu, 11 Sep 2025 20:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G2vBl/IL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB43833C6; Thu, 11 Sep 2025 20:07:29 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A6D83327
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 20:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30cce50dfb4so778991fac.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757614046; x=1758218846; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1CQEGiQIk4uFmoLdWCZq7ozDA8jPl9CTjDJuHjhRT6Y=;
 b=G2vBl/ILLGQPRTRwjbFP+pNGB7TEqe9wlmGv7kcYk0F7HIqnEGh++5UgORbxOilt9m
 BF3zE/KBz0Y/5Mo7yj9n7F6gkMg/BwpaHihdSFteD3dP9ar12DpvocVXfhhZ+UNF44jG
 at/Gx+aFlGasdiJd+X3SRz8KVy+dKtvPHWNpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757614046; x=1758218846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CQEGiQIk4uFmoLdWCZq7ozDA8jPl9CTjDJuHjhRT6Y=;
 b=ZPB0/MSfW9ydtezpC8OrQAd0+UY3+41njmQxehSoh8kYJHxo5vKhPuUVjQy8TLUGZZ
 FVZxw5RJW/8r7veK1/ck1bfjlPibhzML9oD4PbM0b4RW8Qc/vRTHpXAUP4GNVmiohYX1
 IhN6orDKeo62dhUCCu/fBxlNE2RG45G4dXH4O1a+Z85wm0XdG3ZS9u0YJ6gPZBkwgOKE
 AB0OmGjqgqWhNV0SygQsvRJvZr3PPrKs8fgPKQiVpLzPgyxNnWUJTS/gTWdHQYF9xfzY
 AeLBiuFaIrmQLAMQiswZET7P/dyXdBBx1TFOwj/CeR5HbXVVTxMvGjOxoA0r8nj+zW5M
 gsBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA3VcZuJvPq9Pe2umRaKyFvF3dSItfdU08nx78a6djgUSG0rfCcMbxXOGWGZPRwdL88FQkH7Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxFuVmRmNld7nl8TWvw9orKKBSFLSqKbxocR8S/AbMsP6JqWnPD
 ZEXJ4aF7dRGAV8r4f8iHTmovn2l6XHNYyy1wx+/UAcxcMbdPixpyCjycNpq/Rh4jE9x9JSYlIqo
 53aoH2bc=
X-Gm-Gg: ASbGncuuEnDc+1DX3brRatsHKigyrqCJfMhZwvw4Y4fS0qd7+it0eflGUex4BdwGHod
 Ncegv+MCvl7k+wrZeOzvSN7OtDC5jfRaqDWqRY+agDX7U0tF70PkTyZ/QSrtYDRbqEy45gVU53q
 m1yA4tPBH9fxeYZQwi1g0dxWV9Qja+B46jbYUWuMY9oBFsS+TF7xUz2Jh5mdKNKW2cdFYtw9Kv4
 Xk7alIOuGCf+jHsTxaVaMTW8vMFzEhLEke4gGtR3Yn+fY9tT5N3uU425b000DGyMGeeKx+T281F
 xuTnxykzmz7KgN/11aEeSOBIgwc1lQrPyHCHjdWgAbgGYYWPv/Qpt7U18olPBisIwb+UnYMnCBJ
 mBP90u+7w6Mvcu/lnh5GFJtPl1cfsItSE/m/sxmxDtr6/2vXPGDPdmKw2g4OqUwma2cE=
X-Google-Smtp-Source: AGHT+IG1LZ3SsQ/pRkG54Q+/e0FBx0uwqJJaI3pgjVrZj6C//o1VJi3FhA7f1ug74hyEUGEw89JMVw==
X-Received: by 2002:a05:6870:bac6:b0:301:2bc7:61e7 with SMTP id
 586e51a60fabf-32e572ed9f9mr76099fac.26.1757614045792; 
 Thu, 11 Sep 2025 11:07:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d334449cesm580080fac.9.2025.09.11.11.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 11:07:24 -0700 (PDT)
Date: Thu, 11 Sep 2025 12:07:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: make it possible to use tftp for netboot with
 standardboot
Message-ID: <20250911180722.GB124814@bill-the-cat>
References: <20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fPw+K7m07gJfrb/0"
Content-Disposition: inline
In-Reply-To: <20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de>
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


--fPw+K7m07gJfrb/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:34:07PM +0200, Benjamin Hahn wrote:

> Add the option to load the bootscript with the tftp command (static IP)
> instead of the dhcp command (dynamic IP). For this a new function
> tftpb_run similar to dhcp_run, is needed. The selection of which command
> to use can be done with the ip_dyn environment variable, which can be
> set to yes or no. The ip_dyn variable was chosen as it is already in use
> on the imx platforms.
> Also edit the bootstd doc.
>=20
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--fPw+K7m07gJfrb/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMP1gAKCRAr4qD1Cr/k
CmMiAP9d2H9BUvWy7qIZAN8nu9IU8jk5e+2nv8CdEBud/0eYmwD/YeNl+sLj7R9R
RjUzWv55nP8MXovQ3/CkS43EMeZQvgA=
=YFfN
-----END PGP SIGNATURE-----

--fPw+K7m07gJfrb/0--
