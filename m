Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF72C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 16:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 367566072C;
	Mon, 27 Jul 2026 16:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WxxAQd39vAyM; Mon, 27 Jul 2026 16:51:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81E7F6069B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785171099;
	bh=h3e6VjdutsbqID2cpOcfBjOx6pxhE2V77KD00Qpr9AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EWTKSvbx4QybOsAOU9T7fQX8ydq6omFLw4hcjvXkHbtRIEW+l2N2Ef1ZnHwAfRhh2
	 Yjsboz3iF31O4GpAWXxsRNBxgJBsCJtkvTKHfCDGTF652ZUQC09+JLkK6z0o9Km61c
	 +PwEl9+cOxA2hRGYES67l9ZDOv1rfB/ObBeNJte3i76jIw0EH5+2syNsupoHvee2Xn
	 jDDzWlGq4RF35ygJ9hioGD12cozD8oDcaWvHHnTN+55+0U2SKCbNxVuN+PW1af6Us3
	 72ztOJuH7cvVu5jVafDH2HLf/q7mZ+pXLw0/pQrOEq7erynUrnihVbskG8g+IT5qDI
	 AFD9BajU9upvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81E7F6069B;
	Mon, 27 Jul 2026 16:51:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 505BF350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35CF140744
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:51:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlMjsDYH2E9n for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 16:51:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3448E406D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3448E406D2
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3448E406D2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:51:36 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso1551173a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785171096; x=1785775896;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h3e6VjdutsbqID2cpOcfBjOx6pxhE2V77KD00Qpr9AA=;
 b=mKD7npXIORg0c9BrUjMEc08icjlrHOvyi2y5+nEAL1hoVinYgeofSTnFb39B2xMr4Q
 DjdmwDsW1SHPu0sHVJDVRiI05EfXqQAllCUJiHDm1SO6pKEhZEg5MjP2Y2ri5OxI4nAD
 fTF/hyCvIi/qj4mqqkD629g1FYJHmUZwRu2Lm63T8mXG4RTrCbQGjC9fCNZBPSNcC/MZ
 NSqzuECHD4Gqa3EnmmgDhJO9w3rj8qwnQLkvnHhyzhZFKqSWE21/m1YVNrgO2oRpck6o
 82xTlk39NZj2NJig6zxu5SAT/2kPiGGltmAHIhwvmMKt6PepllWIg5C8oHz20C8V0r/G
 eclQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKCx94Va+e8ZJP7d7kDe15dCfWvEev0hTQ6/WpX09c9z6dj22Rvz1BD0QVkMHMtCW3rR+tmIU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywmg6OOowTeKq77mRLcQEaDOzw/oqJc9sqvQ4G5Ii3Ua6R2cRqa
 AIbmd8hUET2sUbdWxLekrTNahTrm4GLoaTHjpULKDYGKm52NtTg5xGYgvapOs8DdIdE=
X-Gm-Gg: AR+sD11kVOSHVgQocniUmzI3tj1OfO28ADBc2JFhSIE670hl9i6ZZrUR07uBuDeAHRk
 fVD1+NgV81uFu6+XI/gi8HUX9ASbvt9JuMPAWO5IsaFM1clcSGnJXEoclA3L5DbPhfaDPqAeKEp
 AzK3V1zJkm5+aAQqlVTJ/Lqtp1g7lslOLYRtW4HuXRem+DYG+zqKL/B+8ih3PTheVLKgyXE4S7z
 H2DnuFksEw+dvyU1vxUINgqcU0qptVd5hy/5Du3XzDN04mFvL//b1Ct00I06Fl6F/5fHu6dWswT
 VIv+meZR//bTPrpWN3n7r8uoijZLKCCxU+Di00qyHoUe4eUxYo09C9sKwh3Z2/tq7+TrZRWRTOT
 7zMIs7fSCqGXcWYBNPd+P2UeZJB7VAU5Qetx7Kshicg5MB7g4Zqo4FUIaIOHYz0EDyPRO7+Oy+N
 TwBho87I4YB2KpMendE24HXpt9eowl9U36AY0J7h9TU2ivz0wdDMU85DNntXJIHCBGAgd7G3ZKq
 ZynYT2QNsIIh0fQAVxrPVyvop7mbOn75I/gYg==
X-Received: by 2002:a05:6830:2a0e:b0:7e3:d199:3164 with SMTP id
 46e09a7af769-7ee78c565a8mr8237319a34.11.1785171095983; 
 Mon, 27 Jul 2026 09:51:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee29e0ec50sm13205743a34.8.2026.07.27.09.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:51:34 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:51:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Ludwig Nussel <ludwig.nussel@siemens.com>,
 Anton Ivanov <anton@binarly.io>, Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/3] boot: fit: authenticate the dm-verity roothash
Message-ID: <20260727165132.GA4154891@bill-the-cat>
References: <cover.1783995924.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p5SmXpCcJEG9VGeg"
Content-Disposition: inline
In-Reply-To: <cover.1783995924.git.daniel@makrotopia.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785171096; x=1785775896;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h3e6VjdutsbqID2cpOcfBjOx6pxhE2V77KD00Qpr9AA=;
 b=Kbp1PyUYLdEKN2WirD/gJZBqWqGh0ITTaA+89sZXzIYWMIu76nXwRZ+DomrklyeIqf
 u5GY9JEIpNVL5ELL3Sj1pXfh1O+xMkKgUW0ZXgfrAZp3dvcbDToda3/VKZ+7hrgUo0xc
 3mIFaKDA0uXtHI4GzM0Bz8jACwFkvDTTWsKOw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Kbp1PyUY
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--p5SmXpCcJEG9VGeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 03:33:23AM +0100, Daniel Golle wrote:

> A signed FIT configuration can delegate the integrity of a (potentially
> large) root filesystem image to the kernel's dm-verity instead of having
> U-Boot hash the whole payload at boot: the FIT carries a "dm-verity"
> subnode with the roothash, salt and block parameters, U-Boot passes the
> roothash to Linux through the dm-mod.create bootargs, and dm-verity then
> validates the filesystem block by block against it.
>=20
> For that to be safe the roothash has to be trusted, and in a signed
> configuration the only thing that establishes trust is the configuration
> signature. The roothash was not covered by it. fit_config_add_hash()
> collected the image node, its hash subnodes and its cipher subnode into
> the signed region, but not the dm-verity subnode, so the roothash, the
> sole integrity anchor for the filesystem, was left unsigned.
>=20
> The result is a verified-boot bypass for the root filesystem: an
> attacker who can rewrite the boot medium can replace the filesystem,
> recompute a matching dm-verity tree, write the new roothash into the
> unsigned dm-verity subnode, and the configuration signature still
> verifies. dm-verity then faithfully validates the malicious filesystem
> against the attacker's roothash.

This fails in CI:
https://git.u-boot-project.org/u-boot/u-boot/-/jobs/50414

I've just made you a contributor area, so at least pushing this through
CI until it works will be easier now.

--=20
Tom

--p5SmXpCcJEG9VGeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCameMkwAKCRAr4qD1Cr/k
ClgeAQDP/084Kc4c1izrn7bEGMtSWaI9rULfTgrAA0my3g4LCQD+O9zmaoa0ixF5
e/tn9fNoAnuteB1kL1euAbiLs9/6+AM=
=6Vr1
-----END PGP SIGNATURE-----

--p5SmXpCcJEG9VGeg--
