Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD5ACA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA20832AD;
	Wed, 10 Sep 2025 20:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L6yB/kAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9627183390; Wed, 10 Sep 2025 20:14:08 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1FA831D5
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-62192ee029dso937886eaf.0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757528044; x=1758132844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BVKcYGvX7TTI4RnHlhaAsBYjKBH4YLwBorX8o3dXrkc=;
 b=L6yB/kAlTDBSBss2IrvjULwaLsyqZNIuPlHRjrrwbi96dpc1WNHa4xcXtOFn8UxfuQ
 mGBpdToVjpdYNqtGWPN33wTBlNHFhDwS3rXr16yG+70Io5CdeR5pkFrmG6D5qczyCuWc
 s2fdYZ47J0b9ARnKoucesDSgKhNy/awwsO3uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528044; x=1758132844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVKcYGvX7TTI4RnHlhaAsBYjKBH4YLwBorX8o3dXrkc=;
 b=xTjmDRVSAxaJJY+mUifJ9XPi5xsiz1/fUbuLjeEDymv3Au7oSMwdh6IKelznEnC7VD
 NG60pGZqXuslLMT6bQLl4Mxeayap352P/UjWgxsIKoUDwrMf/IlbA99jHviiubNyJhBl
 THXXSuJGrhX2KZU4se0aP1WsUpqHn3LIpk2yvOk62+On5l+u2EQ1NbDn4HCX5H951fIT
 Xcmo9vTbvY1EajZWcs99R1GMBGAPRDi6VjNpfsscBVsWdVCew8U8qhZw3wI/F/d7hfu5
 iZ2fhiprSmlR/wzmv5UvkDz4idjaJGj+bXLuNJMwClv2bPBqd5u2FIltegkFqRfkX/th
 N6ow==
X-Gm-Message-State: AOJu0YzB8NUHXLS6RbriEU6diW6s3CGuQ2swffdDIWeG/xfepCDR+8G2
 RpJEYTJU0DDqaZ9wCV8eihT3NIFMB8OUZ9dRaIlZvnjCMz+PDlmwmVVmQUvjklso/qI=
X-Gm-Gg: ASbGncsHfKCLad9FyezvvNh1GaYEsO8MU3j1DP63I1HsAGqobfL8cUc6oEFWslnZObB
 w9pHA2+8D45hskR+CLw3JmuCxJjprzFb1vwpK5g81WajOzJZipFCV+pP1EjSVdMfkrbuAb0Ggfe
 tZ/SrPEgnyWkpGz5ZkAnugf1mTSxGPXVHw10tMvuP2NpA6UDeQMgVUBVrMdHO4/cGujh1WHDTrb
 JrTd4B3RLq3Puo7cYQ0sgCXeRcl04DuZuYi9v58uD8/W1CPxY7t8fh8L3CvyeAbRoP1ApXDAg/y
 h7PpHxB3zKeYL+YELbgObucz0NwErZqo4ZD1SJaf6Nfv95h5DcHIcmqtEM4joFuNzVgq8moga28
 NYrOTzcZ7fWbxL4KiE2yXoV3SlAUrUQsmU8YKseFRjAzHl6bFP0/0YyMo
X-Google-Smtp-Source: AGHT+IFXebtSqYxSVLnDDYn05aAJdONcPgnv/7UzoCk+RwRddpGrSkfjUoRdBEYrHOV4EZSygyEvDw==
X-Received: by 2002:a05:6870:1d11:b0:2ff:89c8:44f4 with SMTP id
 586e51a60fabf-32262a73cd9mr6204695fac.11.1757528044030; 
 Wed, 10 Sep 2025 11:14:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32ce868ab46sm20742fac.13.2025.09.10.11.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:14:03 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:14:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Sidharth Seela <sidharthseela@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] doc: board: ti: am335x_evm: Add documentation
Message-ID: <20250910181400.GH124814@bill-the-cat>
References: <20250903202043.285746-1-sidharthseela@gmail.com>
 <20250908055429.598536-1-sidharthseela@gmail.com>
 <20250908215825.GT124814@bill-the-cat>
 <CAJE-K+C0FHwxi4DneqqasD0D7H73BNk-ZO4GE+ZWSN=a0fdtqQ@mail.gmail.com>
 <CAJE-K+Bhk+jqYpdqLxtTYQA7bCM9i_MNrAnSM+9Pcfu838gb3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TUccDR/94uxsZVlm"
Content-Disposition: inline
In-Reply-To: <CAJE-K+Bhk+jqYpdqLxtTYQA7bCM9i_MNrAnSM+9Pcfu838gb3w@mail.gmail.com>
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


--TUccDR/94uxsZVlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:24:47PM +0530, Sidharth Seela wrote:

> Hey Tom, could I get some feedback on how I can get my patch accepted?
> I am a bit new to this, sorry.

I've assigned it to Heinrich in patchwork and he'll review it soon.

--=20
Tom

--TUccDR/94uxsZVlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMG/5QAKCRAr4qD1Cr/k
CnQ+AQCNPy9OP5CbvrUUgvc9OP6igU9m3L641RI09GzwV7/+6QD/X+XmxO+ySwUF
cKe4LSnQqK+b5iUIS2Y/N9hS261E9QI=
=8J2K
-----END PGP SIGNATURE-----

--TUccDR/94uxsZVlm--
