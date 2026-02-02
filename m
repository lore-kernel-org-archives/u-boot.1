Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA56E7DEEF
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 14:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDCC983B85;
	Mon,  2 Feb 2026 15:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TJy5Vpib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8843683C02; Mon,  2 Feb 2026 15:19:43 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C18F83B5E
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 15:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7cfca52ac2dso2801095a34.0
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 06:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770041980; x=1770646780; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=831PGCWihTxN8icrzF8DpsFlgobKtQug3fv1+cpbyaY=;
 b=TJy5VpibSVwJOUjRS9WoMCmBhn+nhBciTzdta+t7TXy3RkYRUFgS3mETow0RLmjOXG
 s1SgRwuuZPQxm4HdzNcGk707YAy9jiqZg5o3yVefzMIneo0U/Rc3NfFfbQOnltzooNSu
 jd3SFrGwj5MKQuV2O21GtFxuSc/QNiLMAUkbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770041980; x=1770646780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=831PGCWihTxN8icrzF8DpsFlgobKtQug3fv1+cpbyaY=;
 b=tlq0cK5GWE7rgQeCycRfptRc83MXWFi4hL3T0CcQsJXIFLDXFhXcJF88FzgDqouYYu
 GnGd1lIbxwR5KHPIvxlNzT7bfAF0+2HHc5UaLUEF69mdFGpIDKR+UT9Qq7K+OBZwuxd9
 Flxjm9UXDZr33088LI0ORXwzgymYFL8NqweoHJAXQp9JvoRoeUCmZ3Yegidp9UNZQUeq
 KQBgW2eJqdcvaIRvY9bp/kL591UED9vHE5Dsvsacz9w0SuVMOEAMwT3x2cgSBR+dMTjM
 BZNOVItTKRjVBQi6iuIiS1PUz+rftb2STgohG2Jyl5uvfjPeyM0FVACbc3B6LGI2sakE
 4FZw==
X-Gm-Message-State: AOJu0Ywe9M2p9bf+4ExF3SiEc64SA7gViC8LgyUtoyOcTIkQTVTmd7Hx
 Mzk8IdgS+dYkQP/sGTxvGwzbzLwRkveSihJM64un7EEKp5HJ/HzqeM2EHRcS022R+Zuu1gzjMmf
 yCZjHXbU=
X-Gm-Gg: AZuq6aLxYownfVaJ/HLzhY2gIDdvFvQHAcXYi08JP8F3tCUd0RxQB/cIv3o4GCPaQuC
 SOb/OWLwORXz5ABPKw+VZSa8PTNxMP1mhhx7rdOfS44eG/9DmBhJPpbYVnGrSKY3xY73QWIfDQT
 G44uw2sWuTS1THqOZIM/djpGVIDA2VmvHA/yKT7Ja6vQEanSaVZrsVZEASDe1yfzDqhpoSzF9p8
 nolaicGdTgSDgpYavfmLPadCqNagceG+R3YcJGgKDhoz065Hwe1UWpvwLljxM0bAVN5vPmEIKiQ
 8wCHowwCGZBOqPM5YYPbuCZtioFfbx+AMEzm2IVmCbGIS5NvaSqTvvZl5CBeaZXWPd91RhDIcCP
 xRldGR9qUqp0PzJN7v/HJ+UWsvska4JllxMyDDf0chN5tNL7BjiCY6GtHjv9xZMtEUwyjQ1/5fO
 oTbZYKkIXy47dRXN6uSVIU0QGtfxwqwZyLr9cP1LfM10zmwA3NsCd2dPkcUsgkRiYJT/m3XCscr
 WHfGDKgS6h4+KUtSMfSZjvU6Iu66rycK0Denbg=
X-Received: by 2002:a05:6830:3591:b0:7cf:d295:c345 with SMTP id
 46e09a7af769-7d1a531c976mr5971868a34.25.1770041979646; 
 Mon, 02 Feb 2026 06:19:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c7cf4f0sm10434179a34.15.2026.02.02.06.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 06:19:39 -0800 (PST)
Date: Mon, 2 Feb 2026 08:19:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: U-Boot website?
Message-ID: <20260202141937.GB2603314@bill-the-cat>
References: <6782bbaa-bce2-405d-a5b5-84ff3e399259@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yuzzw3TBjFEplcgG"
Content-Disposition: inline
In-Reply-To: <6782bbaa-bce2-405d-a5b5-84ff3e399259@phytec.de>
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


--yuzzw3TBjFEplcgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2026 at 10:31:49AM +0700, Wadim Egorov wrote:

> Hi,
>=20
> is https://u-boot.org an official u-boot website?

It is not. Only https://docs.u-boot.org/en/latest/ is official on that
domain.

--=20
Tom

--yuzzw3TBjFEplcgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYCycQAKCRAr4qD1Cr/k
Ci/bAQCjzhPijuuHV18c8Bh00bC22LnL9whJTrMMaTDVVq5juwEA5XkuAfVZskFG
RJyeJlzVll9204j4szUobDcOgW3ZCQY=
=NZK3
-----END PGP SIGNATURE-----

--yuzzw3TBjFEplcgG--
