Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA28EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73159864AD;
	Wed, 23 Aug 2023 16:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cYN/EEYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE4686403; Wed, 23 Aug 2023 16:42:36 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D612864EA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d45caf42d73so5455177276.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801752; x=1693406552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jma3L3WXYjAiVsuI+2SEglZdfDO1KNISmZAhxshb/qk=;
 b=cYN/EEYuB6rrvk2kqGYDvVozH1PPlo54X50OBWAhvDgYSJpxsNmThGYsPrKF1NOWFR
 p2OBk9DPGq7XRdjMOlR/H54VTWJKRrqz6koVPNhPfzQwo0byxVawivvbXo7so9oc2VES
 2JYhf/9Argt/g2VE42wXcbdC/i9nfWPzm/kRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801752; x=1693406552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jma3L3WXYjAiVsuI+2SEglZdfDO1KNISmZAhxshb/qk=;
 b=ZclYcsK20rFm514i14fL8YqygvTbIKYVQ19rkMj0GUVAd48LTFFqlH95aWqoNcNmx0
 sYHd2+hgU+T4BcI7SpgDfySsMpj1oVly0BVr/7b2wnkKWDCcnZmE5w70mGNH1Zu68P1+
 oTUmUt4nTuvXoS1WgB/hB43bzsqP6YodY7tsmisMJ6E1NCQmELBn4WAb98lq/NYaRl3t
 3SXp17J8qBv9dFLb29VAyOncpmsQHZAjkwMuhf6EXPSPyg2H/5N+4jvR1wfZniTL62Tm
 aax8sVYj66e95IGBlyXXcF0KrEtSE0bR2dvZC+T31HERN2LuXiBN70fx2s2hD8wcwJ/G
 8h+Q==
X-Gm-Message-State: AOJu0YxVxJlGG/zALoddCi5uSVwO0EumaufuYzs3KCkcztThP9ovri46
 Ah7n+XdAf2SO9iu50F0nOBwyNg==
X-Google-Smtp-Source: AGHT+IHljWNeHFBuYMeo5YBKpn/xSJs1T3ADoYPXvjDiFuLWvjbZKZ0GgeZzgrnHYx6PJtFLfgDoMQ==
X-Received: by 2002:a25:cbc5:0:b0:d16:7ccc:b407 with SMTP id
 b188-20020a25cbc5000000b00d167cccb407mr13216093ybg.39.1692801752757; 
 Wed, 23 Aug 2023 07:42:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a25f503000000b00d77bd2fe760sm394927ybe.27.2023.08.23.07.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:32 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 8/8] disk: Make blk_get_ops() internal to blk uclass
Message-ID: <20230823144230.GZ3953269@bill-the-cat>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-8-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NzlsYNh65HDe1y3M"
Content-Disposition: inline
In-Reply-To: <20230813234648.591083-8-marek.vasut+renesas@mailbox.org>
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


--NzlsYNh65HDe1y3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:46:48AM +0200, Marek Vasut wrote:

> Move the macro into blk-uclass.c , since it is only used there.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--NzlsYNh65HDe1y3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGtYACgkQFHw5/5Y0
tywa/gv/fJbPTX/JAbIrL8FTq0M805PUF2K6r+6mBj8JZ+6kKEHi0iK0ZIy6Klaz
vFW/9vQiCORF8mX4MbrrArzGi6zCbRlTyzohTs7B9d7EDQhGZ977z3XDa6XkPMeM
r0Wi8SzFA7F4npm7MA631t0+kzFZTlidJlNaO86gVadX4VTHkAxX6ro3mFcvgK/2
adrmVU4O+diojYoowXFmWctkHIvO8L1MaIKwhtlG1pQPkH6Aj/BkJuOLMqG50261
pY2NNytwsiQCcjGcQ7NU5Ug9lfj8i+e3nFn9Kw77gW4+b4928tcr70lCTLwBp4ns
+nymcTub/XZMTbfk0LaioUcCkhbgMMQP+sEjnG9Erb1n2efcWQEYbjxOiMpo8uOY
DpC1OrbQuMI2kU/2mlF4zv7jQlKxANDudfKJN7W7sNGh1dslbyWJGumRX/uzJWbL
Ulx18vMTZ47cozYtHsGuciJkq1FwmkLOEEEMzqP+4i9ctKfjT1ECh0bacBXAKvjY
ShIAAMIU
=6Z4Z
-----END PGP SIGNATURE-----

--NzlsYNh65HDe1y3M--
