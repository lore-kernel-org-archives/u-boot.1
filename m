Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0731C25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 20:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CE48793E;
	Mon, 23 Oct 2023 22:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GinAL6r0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF9E86FB8; Mon, 23 Oct 2023 22:30:29 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5107877D0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 22:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7b91faf40so37543627b3.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698093023; x=1698697823; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G3w0iQg1yXJZcgbzBbsyUazAoAp0UoCxQ0e/3KMyfDA=;
 b=GinAL6r0eE+G4n0BU6II6tciHH2F0WNfHyqdJH6Nmj8hg9of9Z0BneCXK45GIQO8s/
 X/zOH/HnBv7vQ33Das5XiI0cfF5GkNtmiZ/2WE5idItYhBNB/LRRd7vnST1Vc7FOVgHc
 icL2Noep2ZN6cla2TNfUKOnkwrPcA/tvg1hp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698093023; x=1698697823;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3w0iQg1yXJZcgbzBbsyUazAoAp0UoCxQ0e/3KMyfDA=;
 b=nb0Abtw72q2JvYf5Nlb6c+HdVtQRvdYw6IhW1yvqnx8EtQ1xG1AQw90YXNj84Ox+dK
 D1sIA9lG93yh9aWvsJw/URlgC14G3OAmvhtY0USAgn12AjtcnTemMOHLE+qSDnWNM4/y
 PE7kb/IlCYRNVk+wHLZPyR/KrYFn3weV32O1o61VR4DFoIcmvR7TIdewJHdEyRi6pb8B
 3qWDjCJdcKJcPDiOYKw1kE7gnNloYeN/rwSyi5OUT6HycB4y7txGdWAk6DXMw5cgFK6C
 jmdiO/jTgZcoQ3ro1+rOu8tgqiZquNkPNJaARe4nL7oYr8iZBHdi9cnAXqmzuVNxXH6o
 i4HQ==
X-Gm-Message-State: AOJu0Yyh630NodPr9MXdxj2Ve9CHGTy9lKXl52HUhcy0v5XmZN+5dH4D
 wkA4yIhmI6Z90lvzhA38ljw1EmamfHNikgzjL2TDeQ==
X-Google-Smtp-Source: AGHT+IHC4yY4ugrt+kehtNbuhfQD3i+KhxfBVwI/89Zo1jZufURf0g9T1pgjZGVYiMoanSwcCBYnlw==
X-Received: by 2002:a05:690c:72d:b0:5ac:552c:3462 with SMTP id
 bt13-20020a05690c072d00b005ac552c3462mr2554575ywb.41.1698093023481; 
 Mon, 23 Oct 2023 13:30:23 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c6de-498a-c903-1c13.res6.spectrum.com.
 [2603:6081:7b00:6400:c6de:498a:c903:1c13])
 by smtp.gmail.com with ESMTPSA id
 z63-20020a0dd742000000b0059be6a5fcffsm3469102ywd.44.2023.10.23.13.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 13:30:23 -0700 (PDT)
Date: Mon, 23 Oct 2023 16:30:21 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.01-rc1 released
Message-ID: <20231023203021.GX496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WtuLEdB5bFYycMDA"
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


--WtuLEdB5bFYycMDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc1. Looking at my own queue it feels
almost small right now, but I both have things to pull in still and I
hope for some pull requests from a few areas still as well.

In terms of a changelog,=20
git log --merges v2023.10..v2024.01-rc1
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on January 8th, 2024.  Thanks all!

--=20
Tom

--WtuLEdB5bFYycMDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2190ACgkQFHw5/5Y0
tyzGoQv7Bzm5heorolTMFnLUv1rXdmMYpfz/8hRpqliZWXXVPre+m8Prp9tUs/D5
bNkPIfxgRdPz8ECWenR19XzugIs6T6pMo5WiE8XTbRRl4mzGWOWdPawOeXroP3tr
1axvZNtF+xwhfQg6pfYlesQpsPoOGhBeXn8CEzM/YLnq/hWJOw/oDiNvIe+paUhp
6Os19tooWsfv/EScnujTMSdGzV/mmJ6p/BFBjpkDyLhooDKU9BP+j1fil7jNwhg/
MdZZC4oFkOY7kZhhRqY56QtyHjNKBYGFCEMJdkrB4rClmGwb8WsmMQw5Au22p9h4
njwNT9H33KZHmovCeJJdTXMoxUdpz3S04v4zgZdIAdsMMkST/kusOrMSbT4LpOSG
rPxkcg6NBltI6wOLEG5ilFodiMf5x7OG0G7X8l7l+UB++vc22hh/M8bBADMsyrk+
S8s2WSWUl4uzqE0SvOniyi/NwnrzBGwL+4nxn9t6TVioZ67xyCEK4m+Gx/wRRw+J
Ulryyjmu
=pZSs
-----END PGP SIGNATURE-----

--WtuLEdB5bFYycMDA--
