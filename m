Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D4CD4F2F
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 13:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C8483E43;
	Thu, 13 Nov 2025 14:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A+Bfrc/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37F183E52; Thu, 13 Nov 2025 14:59:52 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B4E83956
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 14:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-65704dae718so380583eaf.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763042389; x=1763647189; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PJ90nmwxteME2xN3kV0KKXpt8IGVpAjinSypplxjBs4=;
 b=A+Bfrc/pLwMJdwEW+TX9sERl5fgt8kHJ8vU7saUCf6DPKvL+BKp/kCSBmp4b+ES+I9
 S16w9VW6hnN+157T/12ILtR9AUQA7KhnQar12y+mIXTNLHoGzLZTI0AkmBwV+/on8xxZ
 EyutB4vCelGEDBK2Fy1paK1MWizI+LHPP4rPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763042389; x=1763647189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJ90nmwxteME2xN3kV0KKXpt8IGVpAjinSypplxjBs4=;
 b=CbLRCNY2Th5S98Irb7sqoEFpRB6bRxIy1BMTg+pVJ5sfDoSItCEYf/3lB8zp5RyJgF
 yfN1hdAbv3MI4maptGNmmebztQWiXnFGy/P9dcLJ/7xhzpTm7iLBCsc3REL8rB/aBAtN
 mZnhroZf05+gMBDqZuP7THsSm5EhWOyAXt8uwF2w6JbWpJnyrOLLvT8xn6NVdht2FYGM
 EfBJy7yxAJ3PA3xOR7g0MtHffQXAdVoqGpWVUVaOM9lsI/5TFGAb9iy64oYBjHE8zUe7
 cHz18vWxCAIFnbHtc56P/FnStTWnW8NkX374Ho2kIDwtE9okRGVFlaHe3cPtG1nvluQe
 yWnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUottbPUgs9fFUtBfHF0tN6xeGjniZ/Q2x3gImDt2ZWEaq9vseac6kLAnJQiV/H1/PIR71VOxw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2SHHRgDw7yAPQet9Gikn80G3xlqQ6j+dTTI6DY45knEvvBFtc
 Ny7tDtHXEmdW1z/0FYmkz9K8cW41t84tumraRcHaDfm/cdgKCp6YeINHh+4XdLbTlhE=
X-Gm-Gg: ASbGnctkc5pdFLSVIypIWHT0K9n02gkv/YSSRHdtUR6RwqXXsb6n/8TrEHr8SNzMjYq
 7Fpo+tYjI0lMa+yeFUXmSpnKv9CQOt+9ShXe/w/I9utSszOXHR26n4qct2Exe+FDy31Bh5fQGnV
 ga9tv+85eHbhrb2gXjEsrNl46DHQoq88zDKb/DPvibaF7Yj7Q0HKBLQ1keaShrNDcI51f9WZuQC
 mWKPVszzzxwjAA8dhquL9G17dkf4FfH18ZuDBHCmz6PYWqZISFhX9miM+fl93f45g8XioUGrwZF
 r3WciLAwmK9gUEbhA1iGNjtWewFlTvVkc1cckp2eiVgtsuKF1WlZJX0Mw9EEAVuRfF37C5zc+kW
 CihcKnLMB2ako/ck7MZRe6RXakIPu/wfcTa0d2swDKL20wqqp1aOLcSW++jt/jTCFYv6RRJGr1y
 FryDLD8WOdPRrNaztaDKgSGqWGjuXhoiBs/vBebLo=
X-Google-Smtp-Source: AGHT+IFeW1+3xYjAyOj+SY8bgyM7PwWPk7BJTpkYmJbh+EMZ7RrXZ80UgstIKg6KmDNHj90FzwndTw==
X-Received: by 2002:a05:6808:80b2:b0:450:3b8b:b472 with SMTP id
 5614622812f47-450745ca240mr3549221b6e.63.1763042388949; 
 Thu, 13 Nov 2025 05:59:48 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a553decsm991363b6e.6.2025.11.13.05.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 05:59:48 -0800 (PST)
Date: Thu, 13 Nov 2025 07:59:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/6] fat: Some code improvements
Message-ID: <20251113135946.GG6688@bill-the-cat>
References: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
 <20251113133038.GF6688@bill-the-cat>
 <deef0753-517e-4dc4-b2c0-9d25b1e56e5f@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FIaNrIRWXej7c+N+"
Content-Disposition: inline
In-Reply-To: <deef0753-517e-4dc4-b2c0-9d25b1e56e5f@canonical.com>
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


--FIaNrIRWXej7c+N+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 02:45:37PM +0100, Heinrich Schuchardt wrote:
> On 11/13/25 14:30, Tom Rini wrote:
> > On Thu, Nov 13, 2025 at 07:46:50AM +0100, Heinrich Schuchardt wrote:
> >=20
> > > From: Simon Glass <simon.glass@canonical.com>
> > >=20
> > > This is an attempt to improve the structure of the FAT code, since it
> > > doesn't fully follow the U-Boot conventions:
> > >=20
> > > - fat_write.c includes fat.c which is odd
> > > - use of __u32 and its ilk
> > > - use of typedef
> > > - old-style struct comments
> > >=20
> > > This series resolves these problems, making it easier to take on other
> > > improvements in future.
> >=20
> > We don't have an AI policy for the project at this time. My current
> > inclination is we should follow:
> > https://docs.postmarketos.org/policies-and-processes/development/contri=
buting-and-ai.html
>=20
> I cannot see that Simon's work would violate a policy like the one above.

The "please, don't" part. There's no reason to have Claude or any other
LLM do basic clean up and refactor work that a human could easily do.

> > So I'm inclined to defer this until there's some "other improvements in
> > the future", that are both useful
>=20
> Could you, please, describe what you dislike about the content of the
> changes.

Sure. I've seen first hand how hard it is to get current Claude to
really actually do what you tell it, and not make subtle changes on its
own, even when you tell it to not do that, really. I have no time to
review patches that should be simple and if were done by a human would
be simple to see what subtle bugs may have been introduced in code that
can suffer from both subtle functional bugs and subtle security bugs.

> > and hopefully only human developed.
>=20
> With your reaction you will probably push contributors to simply not ment=
ion
> which tools they have used.

https://blog.xkeeper.net/thoughts/rants/arguing-against-inevitability/

And if we can't trust contributors to follow the rules, they shouldn't
be in the project.

--=20
Tom

--FIaNrIRWXej7c+N+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRXkTgAKCRAr4qD1Cr/k
Cs3qAQDsgxXid4RpZeZxud17LQk9nyfHF5+x3CrwvgIDc8LqaQD/byRFHQqJjZRe
G64b96McIT41uCSo4tSbkUWxDQEbrQI=
=KiIU
-----END PGP SIGNATURE-----

--FIaNrIRWXej7c+N+--
