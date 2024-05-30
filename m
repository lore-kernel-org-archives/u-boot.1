Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024BFC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 12:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFF6886F1;
	Thu, 30 May 2024 14:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mYpaYAI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4B7886F5; Thu, 30 May 2024 14:59:47 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909BD886F0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 14:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-24c9f73ccaaso459482fac.1
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717073984; x=1717678784; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1hkEFG3ZzV6eVxWQRSkRzKI/3LJi+aTpsLc6MkKARvk=;
 b=mYpaYAI0xd7C3gA3rMpLmaQ54Zca4u+B+1fSjfYW4PTbS7EDgMy2gYuvGfcSvOFzas
 CW3+kLk3fFLODHtJTRccxF5uBJqIEeQUEbTMDxY2gQZ4081XQy/OPvR0qGF8RmXkXH1c
 0blM/M7EBpQEbJs57HHBqckzWUdPcwJ4kAZi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717073984; x=1717678784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hkEFG3ZzV6eVxWQRSkRzKI/3LJi+aTpsLc6MkKARvk=;
 b=gPuevmeQCtvHvcTs1ZLmFlXGBP3hBtJJyt250+3yU0fGkex02Cfn0z++f+QNPvU3Zb
 DcFmE4PYp4cFuSKXofAxEET0IMh6yR0A/t191nulD1LCBaTe7eWJ1e60IJN4hsdoSof6
 E0yYuIn310TlyUI2nu99+rNlkDWbZ3D9gXL5tR8U5EoSe2E59PQKP9C7ZKSW51d7XocV
 yjsAgzm8o19RwB4DGoq1AuVfb7j0a03pSJIBehGUAmxk9EqiIxbkBkTSm886NR49Sbu1
 rY+2O++REkopoPqH5trEDpTRughTLk29JlrjRHgP+s2+XV5i/AuA9kQ0lsKp4AYQgyvp
 AWwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUjVpG9iWLF8MLk1VY4Vb4QChM9PtV7vZYZ6foyqP/gf8dEhbYlNHRnj6AvhB/H90f6uaqAZNy4B+v5sZh5hm5P4Xs4A==
X-Gm-Message-State: AOJu0YyfHIr5O1krPhEpRQakbd2v/b/ABUTd8W8arYApno4Mv+Xlo6Cw
 AF8vW2iBOZuzE3fmxRGu9zpkalCSnpE/wv6PKTbePF8bWbDBVs4sa0N0dbkiqnM=
X-Google-Smtp-Source: AGHT+IHQq15FYwZeZI28onLeCkEdEBiPubJgVV5ECuqjZ5/pOOEpp89kXnxVnVP/hyQ6cFcfXOshsg==
X-Received: by 2002:a05:6870:b01a:b0:24f:e832:de19 with SMTP id
 586e51a60fabf-25060d7ec72mr2450035fac.47.1717073983813; 
 Thu, 30 May 2024 05:59:43 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18af446sm65202981cf.75.2024.05.30.05.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 05:59:43 -0700 (PDT)
Date: Thu, 30 May 2024 06:59:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [PATCH] board: toradex: change maintainer to Francesco
Message-ID: <20240530125940.GG3714513@bill-the-cat>
References: <20240522082848.21536-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T2RQcuDHOlWsXHQO"
Content-Disposition: inline
In-Reply-To: <20240522082848.21536-1-francesco@dolcini.it>
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


--T2RQcuDHOlWsXHQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:28:48AM +0200, Francesco Dolcini wrote:

> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Marcel is leaving Toradex and the email will start bouncing in a few
> weeks, move maintainership to myself.
>=20
> Cc: Marcel Ziswiler <marcel@ziswiler.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied to u-boot/master, thanks!

--=20
Tom

--T2RQcuDHOlWsXHQO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZYeDkACgkQFHw5/5Y0
tyzrlgv/fakMrO8C4i4M7wGMt0I4fhwx5dE6RKjNHhh4EDJWu5YzpDqLr2t4ofgV
CQd4YJrF7UHK4qT+x2ElgYdYQGGx3V47llhzt6QTbJDzdpj41KMppTCRVvPii1uC
EIrrc2/ltmPNOe7GFshNHISjUoSRp+ZzYJbixrtx/LszxHAkZRrB8AnwSZjrSWWM
b1U2ryWON27OrRXSAFgtm1alMNm+O96C51vlGnlzBGyau+TKabvrNOmypagbSE1a
PbZJ3MjgngxxWdESGdY/xy3ydKFgDLeKV/+1dByi/ynWx9G+x9MtqmW1V6iL0ZRK
rH3ByVx/0H1VRkhs4vEWpCf2c15TdFfuMs8vms4fficP7noWBfNxZMt2W62s8UEW
tiMFgDr7wYpmYEUE5/65iUrSDyjC2IMqTo8fdbIWMjLiGA4Q1GFYfUEPY2e0HcnR
Dp8Ci+7WFi3go+2PiR1/UaXmWQZBe2JJmXGm0sONDqZoDAYCbrmeM+ZomD9l83Nz
XoUHu0iN
=dvyf
-----END PGP SIGNATURE-----

--T2RQcuDHOlWsXHQO--
