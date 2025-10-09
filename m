Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB9ECCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 17:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0665184199;
	Thu,  9 Oct 2025 19:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HZfZ20b/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889BE841B1; Thu,  9 Oct 2025 19:35:28 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4EE83F0A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 19:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30cce50dfb4so839382fac.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760031325; x=1760636125; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9U4rjuMXl8JWeCknZ2/d/OTAcoCo+C724IT3AQ7ITk=;
 b=HZfZ20b/TYK3UeNxIVPnSvYWyLeOkl4Joif7HPgcAuWIEqNWMSPN4l28BB/CH9zmKi
 WAWirEtTYufIjUgtcnGsZ+yVzfn0o+fBnfYbB96i+7kkO03YJXalcGTgW7BX2YSriO3i
 82neCUP3eUaNBV9yq2jjr59BQHQrk+mVzkW4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031325; x=1760636125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9U4rjuMXl8JWeCknZ2/d/OTAcoCo+C724IT3AQ7ITk=;
 b=VxqNiRV4IXM1jh/xSJFzSFaDd8D4tJmHPqDxCSoXgX4LsExwEVzD1qFhe/8n3iGIlH
 EvVXxsilomHt0eLWhhoTdU3lsrqEDxfdHFpc77WEs0czx4Pw+sDmCEnwTr3tl7qIsqz/
 WO0Dt/73lmBgKRJFkV8jkqu5/xs3liU1gNcUuH00C7/7O2qANCy6SvbhvXBIvo2/VF+4
 2K1wfruUHowJgF75QuiZ4Namgj4J8wgkregeZrmbwnXs3B6nCXlI6I8RYO5dt9AM/VZ3
 Tsc1DgZiEAJVgWZsYun6QgY7fNFPnbiZ+i9XhL8XNnvxZxxVatd/F2BPCY9cXPlqdajY
 naBg==
X-Gm-Message-State: AOJu0YwaDWy32nlm0iT5f5x13BtHYpAXpdja0h8OySIcDcC9CnTfEgj6
 58BnOepX5uaavFmSYjYSuxI8sM6k6r58tDxrde9XBC1WyBKAmFyaEev0b385Zmv5ANU=
X-Gm-Gg: ASbGnctQOwmAI2d7HZ6oumfXzG3cw/fEBnBxhG1Fk/cBXCNH9y5RDq9UPvHNevoOWbU
 k8+KRYDjLegIrwwpnoWv5O9On8acK0I1jxofzHUOaabjRWgTMItFagiKjEp3QglGjgBKE/Riai0
 Gh7J/QAAOT1R7epCKqJEo+XyujR9d5mbXoF0rQ7RXLtc21j2pHttfPBzaD68TA0ryYwaMKBEsVd
 R8Mcj0vy2MVqqyKHvERFdnn6R8iuQFZGbNdY2ekaIyPw8s2OJU0DQGElTk5kx4q4cFpT50KNsFp
 VZwNgjdjFh/T7uLUyl0Lr3JP0tuUqBx+Dddo/PpI9YkT/l/RX+DDn+XNgojq2qaGVLDz1ybTnO8
 eFAwnIcUjGjN/XhWMBpdIj0khpdmvaEC4Fg1cxD+4HCbvgWv5wCbHb+x/p3MEGU2xkWEMRnYY4/
 Rzj3uZlRS0Ow==
X-Google-Smtp-Source: AGHT+IHWaCaBaJwo3zORnhbJvq6iJrrHrAwaFcGpIxh542wjW5uO99aJSvO6DGKdYNQEYtPgQU0gOg==
X-Received: by 2002:a05:6870:8106:b0:31d:8ceb:20f2 with SMTP id
 586e51a60fabf-3c0fa962d74mr4464571fac.41.1760031325146; 
 Thu, 09 Oct 2025 10:35:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8ef7401sm44437fac.23.2025.10.09.10.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:35:24 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:35:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 4/4] boot: Move preparing bootdev into a function
Message-ID: <20251009173522.GR298503@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ph/p/tqgW6tMNEuf"
Content-Disposition: inline
In-Reply-To: <20251009092959.260121-5-sjg@chromium.org>
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


--ph/p/tqgW6tMNEuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 03:29:55AM -0600, Simon Glass wrote:

> The code at the end of iter_inc() is already somewhat tortuous. Before
> making it worse, move it into a function.

This is not a great commit message. Taking a look at v2 as a whole, the
reason to extract this logic from the end of iter_inc is because you
will be checking it in multiple places. That is a good reason to move
the code. Adding another 5 lines of code (a single if test) alone would
not be.

--=20
Tom

--ph/p/tqgW6tMNEuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOfyWgAKCRAr4qD1Cr/k
CjixAP9J6a/gUFSIGEaScaA3n3GqTObMZ+GT/m9x2RhCma20zwEAmaJYeuZpoT9R
11Aq0tX1Xxp7wCu1cS/ytJLtqrMiMwE=
=E+q4
-----END PGP SIGNATURE-----

--ph/p/tqgW6tMNEuf--
