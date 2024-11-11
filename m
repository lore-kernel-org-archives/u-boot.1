Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272D9D3ABC9
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 16:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E7B88EC9;
	Mon, 11 Nov 2024 17:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SHqDRIzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10D18931C; Mon, 11 Nov 2024 17:12:30 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8722889100
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 17:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-288642376bcso2380050fac.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 08:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731341547; x=1731946347; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jEomiNRm8TYpOuJcYxH77kvfO7wH/iSGX30nq0it29w=;
 b=SHqDRIzKmOmHF0eJBKToKAnNDf0LQiLptxvk6vufhgGUaABIRQz/pYkdYte3zcuJHJ
 K4oSIv8LJd7kEp0ngpEEs+Qr2UovmjXrHBkpKqyxAMeESwJ0YKo8awlZg+KgPYWBu1Fk
 r2vCba/rmN76FBp1lJ8iHbPnDZGNhdlmv2Xjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731341547; x=1731946347;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jEomiNRm8TYpOuJcYxH77kvfO7wH/iSGX30nq0it29w=;
 b=ISflnc4/igxIlz8ooAF5dtvCOnsRM/zKDvQxkWpJ2Km7aQLLOabChqOOE2hsPaeqOw
 2RgVtLpvRcV1MN6AOPXfDS6uAqtD9BKNj52beh4p/I5izhT0Y1VuBfPJU7dIHwr7zRx7
 RWdDUMGVb6H7Zfb6UAzD7wccuLzbizug/lmbjfXxHHqeRQ1uaUcVI7GZyDNp+U59L+js
 or0hj33YBNRopzU4w789B2FXer8AqRLBT8vRfh8PruNhz4sL2CD08dXoSiZpVbDVw77z
 Aq6EepSofbkrrb+d8Mv6HsrDVlhtSyjJMour5xqH7+OlbczkdfTYoNPYpebdr6Mt5usc
 ogiQ==
X-Gm-Message-State: AOJu0Yxbm3nW9j81XKkn6Wa9yvoMchTUtEWDolB0Q+/50H24ryNZeuXr
 LWXk7CMgq8IMOTT+uKErvQr/Pz3z/93TTNyzyscw9HQIzvdZs4FDmXxai1k1oGBtrMVv3Dr3YzI
 dQXA=
X-Google-Smtp-Source: AGHT+IGPXUPStJJ6O/nNR3YOCJk3FQ95P2xt1cRxoJLDb4xg2dRJfMEesGFb915/Olsp0ayicBOg+g==
X-Received: by 2002:a05:6870:5e53:b0:260:e3fa:ab8d with SMTP id
 586e51a60fabf-29560309523mr11089788fac.37.1731341547259; 
 Mon, 11 Nov 2024 08:12:27 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff3df017sm64402941cf.17.2024.11.11.08.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 08:12:26 -0800 (PST)
Date: Mon, 11 Nov 2024 10:12:23 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.01-rc1 released
Message-ID: <20241111161223.GV3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qqtHVewO3Wa9PSp8"
Content-Disposition: inline
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


--qqtHVewO3Wa9PSp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and so here's v2025.01-rc2. It's got most of what I'd
like, but not everything I'd like, so a few things will sneak into -rc3
rather than going to the next branch. The next branch IS open now, keep
in mind, for bigger changes.

Looking at the -rc1 email, I've just now merged the series that
addresses the problems with the Apple IOMMU (which wasn't even using the
old LMB for images, but handling memory streams, if I follow the thread
correctly). The changes for lwIP using https are almost ready, and
there's a few lwIP releated things to fix as well so that we don't have
to worry about correcting behavior later on. We've made some progress
fixing up all of the SPI related issues but it's not done yet. I remain
hopeful we don't have to revert the whole thing, but am open to it if
we can't resolve everything.

In terms of a changelog,=20
git log --merges v2025.01-rc1..v2025.01-rc2
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

The next branch is now open and I will be pushing that out shortly. I
continue to plan to do an rc release every two weeks with the exception
of I'm also doing -rc6 on Monday, December 30th to have one more tag
over the end of year holidays, to see if that helps with people finding
time to test.  We'll how that went in January.

Thanks all!

--=20
Tom

--qqtHVewO3Wa9PSp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcyLOcACgkQFHw5/5Y0
tyx+qAv/VfjDpdoE+GMyfgNTkrao7Agy4gjVI43uS54UFASVOPymKXJIMGuIQpGX
TTi2LRttcmXoqCWQPytvSEt+iI1sc2RGNOOjbuohZxOfmGeF80Bn9ATkaDBRXcyH
EOJhyav3YLhcu88tPJkpsCVCm2w593cgmqdiUrpxVx6RCxMiLVhEUUCcP22AZgZg
II05NBAf08sYOXnoADV/ChKrTPbOOVl/5MoX7DAE76CtWPodCR4/l/VqgUuwN8Ar
qSrDKaMlAAYto9/AAYHDqTJxPDaND40tzZ+7kusD9btafKuje/zrTUlaJRFYRgrr
Ng6Z7CXY7HjwxpB9c6I0BRIKtB2MbRKK4PjOa0EbboOJoDq0URyHwKsJYMRGASsa
LLyDojx6RYpvji2cAKiY/YPtPi4ils0ijt7GUrSqOtHlNg925uBuaHWI2HP2GqEL
yXp5KnEL0Y6fBHRaRuTazkTS+cgmocdNpdZYxdV3F4h8367odibiWYx+qIkO9iTJ
AxwXJ4Zi
=E1It
-----END PGP SIGNATURE-----

--qqtHVewO3Wa9PSp8--
