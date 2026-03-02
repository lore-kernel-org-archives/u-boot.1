Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD65FEA4E2F
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 16:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D4283F2A;
	Mon,  2 Mar 2026 17:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IDFUe4eY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1AB583F61; Mon,  2 Mar 2026 17:04:02 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A6483F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 17:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d596a5be31so3777353a34.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772467439; x=1773072239; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0UlM+fcijIQzEdlMcgUZSe+0gg9bX40aEn1fWDtJM3g=;
 b=IDFUe4eYGGxg6ddGfN8jFIsan8PFFuD7ioK4fyhuy528SkeVzzKcfoGvnn0n/fzzfT
 Wm+7zcdipLbfBhayCqFJBwfzaCmnyjDdMKrmj1KDuV9Bk5eJshmjWlI5HUrHT8NQTyyc
 mV6n0JKjCiBvnSv8hQkIKdW8U8NjtTld4/Mh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772467439; x=1773072239;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UlM+fcijIQzEdlMcgUZSe+0gg9bX40aEn1fWDtJM3g=;
 b=Qw2Qo/f8dl3ZFV3tcHp9iTihK7YXQhdYLq010IQYsJehRfDMFqzTJefdfhPz5rB9ia
 6LiXmoYdwLGCc4suVTc4IlcXTKKyBXZoG4AcrP7W4yrm6qwpAp1s6XlAbbQOqNfzGg2J
 Cf8DJ7n0jkof9yI2FryiTx2ijY2ikz30JugJxaHNqT8fRYxx+hWfctqJuxMpGxRaY2et
 31R0jZll0SuoZ9yOxrQJFFEP8ijZeJIw73C5/0YVZNNugPU4pkSoxYvm/5PNLoQw7pmV
 NrIQNKnLROabnH9IaEuOCtcdko6McRbcZzpwtEpvR+hmAeMWX+9XTBzjvqflUgMcybPp
 PTpw==
X-Gm-Message-State: AOJu0YyHhJ8g7G3PeHsdp5OOsNvJyDG7cuv1d5DTBGKDE4Ofk2SPmgtP
 RC3/TdMXUm5INnHe4uK+8OrsGIwACwV2sJnNLeUQwpNx5ikmM57COCYHh1bj0vZHibU=
X-Gm-Gg: ATEYQzy92R1a/5DZ2PCg9uemLWt0ecSgdAosFudNMvRC6UQCyGjAaMZHD1ej3MK3UTN
 0H10RXheVA/nPX54Mx3VbmSS6dFYMDYOzMuPlZ9vrw1xRO7FI2bHXnPoU5qtug/sIilKQ61+BEp
 mjkJ8FmxGU3O+rmJseoZ7jCY4ImQtCa4BDhPEXrwHsRcT/CkuVHtS1z6OPeMaHIsSgScym7zP7o
 +VIh2zSdsmbCnRGJZgN6YmbWqRnXH6UwGapVZzFDoWEJqrIPpeo1Z4kfJ+9KQ+BADBZoULgB+Vc
 vCpkKcCSsr2bAeku0NuDo2gzUWS2C9E2Fy8DvM0y0xQJhyiXto17eaqUsu+2JZcA16LHHALZHAs
 AqMErlJYzh24PI5z+AIxQ9fHEBVuZvbJY/lp4TBIHhNf5H43jBgSZZNSdMotp8FCcDbOwrhwdZQ
 Qf7rch7fDElWOmXWmuM4n+QHoEpKeCYC7hgOaFBltkCkVRPBuXMfdJga1cfUTHU+JxPJqMlNtSL
 StD7U4RDdXRStsqd6Poi7Uamn8wpauTdTkA7HvHofGDm80ON+A=
X-Received: by 2002:a05:6808:191b:b0:45e:b647:ef5a with SMTP id
 5614622812f47-464be9489famr6390846b6e.3.1772467438643; 
 Mon, 02 Mar 2026 08:03:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb59b656sm7462508b6e.12.2026.03.02.08.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 08:03:58 -0800 (PST)
Date: Mon, 2 Mar 2026 10:03:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 5/7] test: Convert fs_helper to use a class
Message-ID: <20260302160356.GF1388590@bill-the-cat>
References: <20260228182304.3728735-1-sjg@chromium.org>
 <20260228182304.3728735-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BSIAYhQhMFr4hJaW"
Content-Disposition: inline
In-Reply-To: <20260228182304.3728735-6-sjg@chromium.org>
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


--BSIAYhQhMFr4hJaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 11:22:45AM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> It is somewhat inconvenient that callers to mk_fs() must create their
> own temporary directory. Convert it to a class so this can be handled
> automatically, using a context manager.

Instead how about:
Create a class around mk_fs (and later setup_image) to handle the common
tasks of image creation.  Many callers of fs_helper.mk_fs create their
own scratch directories while users of fs_helper.setup_image rely on one
being returned. Unify this by adding 'srcdir' as a field while converting
to a class.

And I didn't try out a 'git show -w' to see if that makes it clear the
underlying logic wasn't changed in mk_fs.

--=20
Tom

--BSIAYhQhMFr4hJaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaW06wAKCRAr4qD1Cr/k
CsnyAQDCU3f8g1HvYmAIU5gmd1iVlIvE8N1jmja6d88NoHTrGgEAv7qJiukXGDdG
Bf4K37fCRNB/qPZ+OgMFNE46KWKQvAg=
=VnLa
-----END PGP SIGNATURE-----

--BSIAYhQhMFr4hJaW--
