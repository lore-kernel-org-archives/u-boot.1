Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EC5D66BA6
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDCE583B49;
	Wed, 17 Dec 2025 21:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hICVZTSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73CA983B55; Wed, 17 Dec 2025 21:56:17 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B744283B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 21:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so4979542a34.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 12:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766004973; x=1766609773; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EKmrZtkVX1ZDieT/L/81V6o9WKewQ61PkWjnwL1l/h0=;
 b=hICVZTSdVGWbANXPp+NSH2PJt91m6+E+cE4m0+VfDMwVUlYYj51QbA6tr63ji6I/OX
 0Hr7z/M2/6rwuk/05DbhY8vHHOioQI20oHQkBmJTYm6A+KpKh6o0lWAD/8WCknmcpy+H
 x1tSjoPQFcd8HazN+bjSVtPCwipHqFg/CiqQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766004973; x=1766609773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKmrZtkVX1ZDieT/L/81V6o9WKewQ61PkWjnwL1l/h0=;
 b=qfjO1CGFyWDXb9Wi+7ryXRTAISBtWvQPcIN4jVsmqQ0oxfYu5w4wykay5XiyhDAHDa
 Jtgi7WUsSSaqbmWy/PWEV80+aCGJ/IWLdY+O/B0JMMt5Oo90jE9BnIUmAWOlXvVWzeFB
 Tm5yPpMg3LUQU4AEoGZQ/InMXr9eoBjLAe2uDqRLxXWQbv/eRI59cObymTCeDGaEyUMQ
 HIGqTAclX5ELuvvyxO+42UPBhB1gVoaHGjQtQqw9sv+WByTvET4rYwJPggYsSK7pKa8Y
 ES7uMntS6v2H7b8WeAkX0YNKBhEzPk/6MOlCA0mi2OTW4ZGBh0PL9Su0cI+51xnzd5M2
 aHmw==
X-Gm-Message-State: AOJu0Yz7Uup32yul5XPQ9gOnuP86COWqt9nZhQE4d6gTxc0aEK1Clb4s
 yhoQcRToNZU7/UdQ4UdVJGoJ/8g3X0bak7cMq/aB5I0/tUzu0KHVEK6qiSoWmzAq3YI=
X-Gm-Gg: AY/fxX7pT/4v1KFsGBbZLA2AABx+IB+i7fgEDaUV8o0TtsThetS6fUL9Na4EIk5O3ZL
 trewo46U33LWw8/+9L2ojWhJ3bXoEek7xjxc8vfGlGr5jOnel7hsL3MWyLkZKo9hGNXd+IgMVIL
 fyWPIEV4+vp272oN4lpSd5a/putwSo/5V3ounUc2aKylX1neCfWTcL8dgecfCk2Hok9cA21qFAO
 r8ymuQaZC1q9LS7YlTzTV84SBt8mz5j/V44LHixrD7nhNcCpkBnKX/FC6+nLvWvdkjHlMzQfOLq
 x+orpZNu1e47n4sB9N4q99k8kFsbHFK1S0zYrj6TDMUsm/lmEV5e5EptqmlNnriLZlkAxNIY8ii
 brxPCb1XeG3vbIh8dMq00nXdi/TNxC+pxN7IZKCDO4bZsrXwpiaFL8BAnXEd/kTDCi/42kajhny
 Z5tLlHJdbMOICTdmSje7NBkR1z97QFG8yOafxTSSRQon2dHjQwJA==
X-Google-Smtp-Source: AGHT+IG02tC0WoKZTXg4BmysWgqyGJ4x4YoLzq3CDyZkc3thvVqlWWLDNugfi9dTvFU0JGrrr5wSQQ==
X-Received: by 2002:a05:6830:438f:b0:7c6:b6da:e2ad with SMTP id
 46e09a7af769-7cae838fa6dmr10455202a34.33.1766004973196; 
 Wed, 17 Dec 2025 12:56:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc59b791b2sm293256a34.14.2025.12.17.12.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 12:56:12 -0800 (PST)
Date: Wed, 17 Dec 2025 14:56:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] env: Add single to redundant environment upgrade path
Message-ID: <20251217205610.GF303283@bill-the-cat>
References: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
 <20251217201323.756419-3-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h5zI1yVhWTkwalFb"
Content-Disposition: inline
In-Reply-To: <20251217201323.756419-3-marek.vasut+renesas@mailbox.org>
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


--h5zI1yVhWTkwalFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 09:12:33PM +0100, Marek Vasut wrote:

> Add support for converting single-copy environment to redundant environme=
nt.
> In case CRC checks on both redundant environment copies fail, try one more
> CRC check on the primary environment copy and treat it as single environm=
ent.
> If that check does pass, rewrite the single-copy environment into redunda=
nt
> environment format, indicate the environment is valid, and import that as
> usual primary copy of redundant environment. Follow up 'env save' will th=
en
> store two environment copies and the system will continue to operate as
> regular redundant environment system.
>=20
> Add test which validates this upgrade path. The test starts with spi.bin
> which is pre-populated as single-copy environment and then upgrades that
> environment to dual-copy environment.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de

For merging, a cover letter makes things so much easier, please add one
for v2. And, I think this needs a Kconfig option. I'm sure you added
this because someone has a valid use case but it's going to grow too
many platforms where that feature isn't likely desired. Thanks.

--=20
Tom

--h5zI1yVhWTkwalFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUMY5AAKCRAr4qD1Cr/k
CuBKAP0Yz2ipPAdYndu/E9l1gM5p7W7NwiAxOuIYkVWnOEhC6QEA0wdwOmQH3yst
Ti5P5nYJdWbUKJ+Q5lIQeKFaClZh6Qo=
=hyzO
-----END PGP SIGNATURE-----

--h5zI1yVhWTkwalFb--
