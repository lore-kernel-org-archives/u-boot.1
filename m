Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BCACA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 19:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA7283211;
	Mon, 11 Aug 2025 21:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dt/WnEoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90ED6831BB; Mon, 11 Aug 2025 21:50:02 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D18EE831C5
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 21:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-883eb1ad790so26498239f.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754941796; x=1755546596; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMEeBYk0OKOzjgrxiUAcIpeCXIkICGOkWcvCpVoiSC0=;
 b=dt/WnEoH+vo6hKCZgvd9YpJjWcmxzVy9u0pgkAfXyEExgxnw2rTBfU6qqM6S07XIJA
 W7grc9cBt+QgLXmyK+BMrCKSypip8lLV3R0yPlj1twFDikDcCWRhCTA+BkXYfJc/Zn7+
 BJ9T6kp36T1qSfcrNR7KgayA60vPymP43Kz+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754941796; x=1755546596;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMEeBYk0OKOzjgrxiUAcIpeCXIkICGOkWcvCpVoiSC0=;
 b=miW2GbejE8b+8zHdZsITUQyP8sz10LHI5ThvXMZ7ZriLVHv0y0Pu3LZKiI7OlRdyj4
 W3CTymHQXHQrzlfXpwv/u5htAzmk5PPxmWrzsBzPpWk/iVwQnXKyJXKesA8/u3GdtmR1
 +11eGtJC+M8/bKvyI3UqwCtT5d05qaSdoEGmQAVXAiFTxCfwwsFUkHPNJn2jBQMUVC+I
 K2zQ59VRA3PxN282vguUKDhiTi8WRa2V+Vfi3NWGwV0pVEe9Mv4owNdk/i/RH5lnjcNS
 TYu5s9DmqaWnxWT7GXAySG4MmtuAybEVqxswqUt7Ytjntq1tX2XQFD/zOZ9LpNm5i7H6
 QaEg==
X-Gm-Message-State: AOJu0Yw/2y+rQRTFugCg/EK7L0r+yW1opZJ3PCfqZZz5/fybmI+vrTF7
 GCs6d9roPhKq662253Z2GImbJE17vY7R+4pXr2GThHHlG/OkVzhLeM9mXh9EN/+7ym61akB/l9M
 +91wLpWA=
X-Gm-Gg: ASbGncsiTYmFIbawHjNrnliaVFPDCmxrMM4MDRqJRbrASsRl+yCy5AtTS9+4U/1YLTP
 gNuKE6MymnM30PUEP4KjxmwzV/h1cZxWvsOGQ3WE2dQiexi+1ibTKbrnorghGOi06GCNeF+857T
 /+zGJA/UeDWLhlfk+WGQqH/+qhiFWzqsSB2lEm6m4C5z8OPOSDARrYhyFOhQvqkMJfeXG6DfFx1
 jobxMhFCK0surX2YdJGCb0xlCW+Z/iGUaFzyhHowMXHRkLskhJAzGPqjNbidch5OhxyWn8xVxVA
 AndzexwZXgodx+vcEiV/mlbQpYwc4U41YYeOqI2lMLfmsR8p6tVXnHVJ8YyNfalMe37RdehpRYk
 5XQP3kFYSEsfi5mgTX4dgPZM8bDmDvxihKJAJ4l9UoyslLP3j7DtLYgfz
X-Google-Smtp-Source: AGHT+IFA68ZxqqMy5PpvCMdUd3cccT/zC2KmknSTG7wKLsXuMurduJxcnfK9PEwR44uNXXv1tYXN/g==
X-Received: by 2002:a6b:d80c:0:b0:883:f01a:5d55 with SMTP id
 ca18e2360f4ac-883f11e7078mr1969255039f.5.1754941796388; 
 Mon, 11 Aug 2025 12:49:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-883f19d0640sm302546239f.32.2025.08.11.12.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:49:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:49:53 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.10-rc2 released
Message-ID: <20250811194953.GL124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1/SrowpjX2waDXy7"
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


--1/SrowpjX2waDXy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and I have tagged and pushed things out. As this is
rc2, the next branch is now open. Moving forward I'm asking that
custodians ask themselves if changes are best merged for the October
release, or for the January release. If there are regression fixes that
people know of or otherwise big changes that should have come in by now,
please speak up.

We're continuing with a community meeting following the release
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
August 12th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- The promised dts/upstream resync happened and we're on v6.16-dts.
- Enhancements, improvements and new platforms for Atmel, Marvell,
  Rockchip, STM32, SoCFPGA, Tegra, i.MX
- Networking (both legacy and lwIP) stack fixes.
- Addressing more issues found by smatch and removing unused code.

I continue to plan to do an rc release every two weeks and the final
release will be 06 October 2025.

Thanks all!

--=20
Tom

--1/SrowpjX2waDXy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJpJYQAKCRAr4qD1Cr/k
CiBoAQDyiuybgkuyKy2AWAOntT17NZFkq2Fg7d9p7OPcSXzd9QD9ESBMU7MLdRKL
3RnEX+p3PGjSLurBOXrhlONTyGcbXAI=
=aPyf
-----END PGP SIGNATURE-----

--1/SrowpjX2waDXy7--
