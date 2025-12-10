Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7754D3E77D
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 21:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A8383642;
	Wed, 10 Dec 2025 22:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="disnEbM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A8D83A26; Wed, 10 Dec 2025 22:38:33 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599058042F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 22:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6d3676455so180561a34.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765402710; x=1766007510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7wyK5w9HpZFaY9r5RtpoH9JIOTaiOq6U5S6z946MsUc=;
 b=disnEbM1LtqtXkV4kvC0dJ7DvMbplWOsCHy3R+yGPGFYTL0z6H3/H3Xmm5e+7RKKJ3
 zCnI/W04JDDQah4+V0+YIJtvkOqO4XYsQF/mDr8vTDZa0skK0oR+HTLHYxHVeVKB+Y3a
 uU+cEzdyqiB3IbYSWaAS/ucGZBkyKpOLLPBQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765402710; x=1766007510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wyK5w9HpZFaY9r5RtpoH9JIOTaiOq6U5S6z946MsUc=;
 b=sD6Wx0mts3gMpzMhLPIeJW5CeBZmWmkAgtMKapcuym9d8GzavYjan2TAHsx6AJWtuk
 H+qgoPVtrOwXcm8k0eoOhxTINfU9w2LpXp9uuSWsG+dKPb7wlBlrOHIEwlhU0HkPoQAS
 xf04Oz5q/zB7CdZu170DbQdW43cFXXVlbbgz9YvQxppDZLdteDUsRkrcWacZ7BKVglPM
 oIFhV5rNIxKOzhRugyRNZGFWXw4gzfuGkFb29TsDLBf55umWSPUKbXZw9hFvmVGmg6wr
 Sk7UyatLnG83nQgA08iz+MTkCyyS13cIXigI8+hnqVZ8mbuv22XZb2gla74S6XEZehJX
 hEBg==
X-Gm-Message-State: AOJu0YyatkIrcs8CGSPzACxwN3QzBQgjKlFj4UtdMxEp8lkJH2JaUOaA
 aoSRyzsfrpl82MRsWGYnEXZLPW2h75cqGyeIuiQ0jB4LiT6kVKmGCpMLfS0azAOfRn0=
X-Gm-Gg: ASbGncvoZunCEHZSLJcQX8TO6yJgjPzRA6BTUtk9mlMtWB8GYeaDyRWSPdhMGbzsL5q
 smFA85TXzA7YaL1+0qw76YpzZnv31vMlCpTYCCxzSiqGpZRkGzaqFh14ehxLgpem3OjqVu375h1
 3WliEbhw2HwfTXgVE6iiTqg3K6reGv0Y8Y3PFQi2zTgyygU2u+bhc5/ieXg8hp/VdAGhJpAjltw
 RQ6pmTtg/VFcOKxrxBoSfip6VfWWvRxqj6LUW6Q3d0+8z/sCaJPx/iDwqJTBPDsmYKSYgfgv2p8
 ymTjYqFmR5mvhWJ2cMg3KMm18+e0GM2rm4EZPNotfENGTUtq1Hto7EmmeYZzRvmFZyuex9x/Vt4
 H6RHlTIRL2+cglBnfh/y2ZTxLG9TKsTBg89IcvYFy+sPCk+HikG2EN+ESDKft/PiEH3Jyyo7rQg
 Z6U0Y3wGJFa1lw8GW4qsaMQbJzNiyf1FfStUdFRyYxkCzH62gGsA==
X-Google-Smtp-Source: AGHT+IHqbN2yZg1dsntcoieqUReTsscQcNubxQFWMs6Xv10M4PDtSStoG/Ki6shVRVz5uNQlVYC2Mw==
X-Received: by 2002:a05:6830:4423:b0:7c7:68d8:f6f5 with SMTP id
 46e09a7af769-7caceb80f91mr2444843a34.3.1765402709986; 
 Wed, 10 Dec 2025 13:38:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb3261bfsm139479a34.25.2025.12.10.13.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 13:38:29 -0800 (PST)
Date: Wed, 10 Dec 2025 15:38:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ye Li <ye.li@nxp.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 0/3] Fix compilation issue on regulator_common file
Message-ID: <20251210213826.GK303283@bill-the-cat>
References: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T57rfCLYnXNjwl0t"
Content-Disposition: inline
In-Reply-To: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
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


--T57rfCLYnXNjwl0t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:24:21PM +0100, Julien Stephan wrote:

> Hello,
>=20
> If CONFIG_DM_GPIO is not enabled, compilation of
> drivers/power/regulator/regulator_common.c  fails with the following
> errors:

How did you get this condition exactly? I'm inclined to say DM_REGULATOR
&& !DM_GPIO shouldn't be allowed today, and I see what looks like a
Kconfig bug where SPL_DM_REGULATOR depends on SPL_GPIO and not
SPL_DM_GPIO.

--=20
Tom

--T57rfCLYnXNjwl0t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTnoTgAKCRAr4qD1Cr/k
CoMjAP414ozWrI7etKlHLmDa9JHr62+jj+Pb9CLKaJmiz9R6rgD+PtppDogPGVq2
gWTjkYwwAdzn77Py97ZMoi3NJg35Ewo=
=GO+r
-----END PGP SIGNATURE-----

--T57rfCLYnXNjwl0t--
