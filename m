Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0F0CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2EE83448;
	Mon, 29 Sep 2025 22:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p5GWcqvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2F68344E; Mon, 29 Sep 2025 22:00:12 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81A948341C
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7b97ce4fc60so476865a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759176009; x=1759780809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S5FRL2omAgi4pyQMAbuL+1CZP4kDKMQw7UHIemSQEdE=;
 b=p5GWcqvcVBgl9vQVoBxGwNdP4ugO985oHUYAeuGOr7TR36r4gECZGy7Mk1+5J9C1Rm
 zIuuwo0YHPrgyfJj4o2c47mHhQxFZVinDQYMKBlS4+vm34805D0Dh9+a6htCzngBgU1u
 HLj8qMuu7wGjpzldMOGJmGb9Im4C0WhlCvy90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759176009; x=1759780809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5FRL2omAgi4pyQMAbuL+1CZP4kDKMQw7UHIemSQEdE=;
 b=pLHyPY4OX7wIpMM6VuDgYH9AtlKaomxQgK3gq3xtsvoJh4oq6IXDRGuYS7L4Si6AUe
 64mWoPG3ouTjoYwUu9Q33rlE0bAIEgNbLIpgsB79Vw7ZL6NHLkpW1GOx/VFy1r7424KG
 bEXlO3HJb0wl7LIFL+SYFs7Jk1oMlLr1zWBmDXbwsRcCYhflxf1AyAVxTF0xb2emUICr
 QW72HENcURjNbm63ih+5/EcZEgpZ5UENCyIgRxA6G2MgiVpDdHuN+ayz4KE980/fynoy
 Fwy5mYf0A/wWPjttgVdWqSnpCHUV8N/KwL2j4zIbvikhwymNlM3cFcSxCOEhLLfXJxes
 Mf6Q==
X-Gm-Message-State: AOJu0YwGgu98biWDuKNpTG2IG/ll2a4Cvzh/evF4fEnMLheI+sCYvb71
 kYol5J5Hx4CFj4lyP6Q496BYIvOWuiuYNp0vicKA2Tucm4rJYWKxvs1NFvV/cj/vH3U=
X-Gm-Gg: ASbGncstAUmNepg0V1YjyBB3Rpp4mRIJZ8AxCzw/kVneTZkEwbWzW332XjRlT4rAF4X
 ypzaOrzQ23zdTeYJQ+lO8arUBfvLSYY7q5nDKZH0bS6s5tyjF1ruRi3Xpta0/aIPf69+9TaiTgM
 4PtExEOoQgmOS0hvyREMfquoSBvZSOTkcDi1PQcygLULJtEYWSThSni4xssCh1Ckxc4UWp8FkON
 OCOgDBotpVyt8/Im7mfHNsNVBHwBOft87XiOXyOubD1GQUa+ocLpqz4pmsaASvVPG8IAVSULeVl
 8dQcdOqGzz/jyqA90MBG0m8f4NZYdsqvftrLgRwrf04T4wFX3LsM4zW7PfT6V3Q8Z+93cCLwEx4
 +G2zS26NWOee364JvMkbJVURkZmlimMnO7LsTGOWzyhUYdmM5r3Zv00nEu/zPM0DpJkY=
X-Google-Smtp-Source: AGHT+IGak9sv6HOOlfzOZAsR0L/58stQ1GfDj5hNgCx+mXKvQZj9DqGletpcUO83E1H1r9I71ACa/w==
X-Received: by 2002:a05:6830:6d17:b0:7a0:239:80ab with SMTP id
 46e09a7af769-7a03e2583f3mr11173377a34.16.1759176008573; 
 Mon, 29 Sep 2025 13:00:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7b4c0e92da9sm1297629a34.26.2025.09.29.13.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 13:00:07 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:00:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, marex@denx.de
Subject: Re: [PATCH v2 2/3] iopoll: Add readb_poll_sleep_timeout
Message-ID: <20250929200006.GO6093@bill-the-cat>
References: <20250929195241.70351-1-kettenis@openbsd.org>
 <20250929195241.70351-3-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tEHmcnsUYVDdYU9V"
Content-Disposition: inline
In-Reply-To: <20250929195241.70351-3-kettenis@openbsd.org>
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


--tEHmcnsUYVDdYU9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 09:52:40PM +0200, Mark Kettenis wrote:

> Add a variant of readl_poll_sleep_timeout that reads a single
> byte to match the readb_poll_timeout API that Linux has.
>=20
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--tEHmcnsUYVDdYU9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNrlRQAKCRAr4qD1Cr/k
Cr8BAQCAzpx0GAyWinw8rTdNawvHxinlx4nBl4NhrG/UVeUBkAEAldQsbVdMB3Jq
K2CbvbZ6s/I93VFSHRckPlWgcij1hQg=
=DAkC
-----END PGP SIGNATURE-----

--tEHmcnsUYVDdYU9V--
