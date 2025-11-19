Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD11CF34AC
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 19:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E1A483F26;
	Wed, 19 Nov 2025 20:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UAyX/ZXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A62583F2D; Wed, 19 Nov 2025 20:39:28 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E39B83E0E
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 20:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-44fe903c1d6so18197b6e.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763581165; x=1764185965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5mV6vpq9fYx3q1cFVcbviPcKTIJs38bJF+irn4tthYc=;
 b=UAyX/ZXoly6vKkOl0aelpQ1dnxImHaxOGWnL53Lhto2Itzr4V4MhxRhOYMywFqy6ye
 RU9SfGupJuDzPUPElF0ozQ0p3af5slOjV/aLVbmW0LDWO5qfwu4exEUHFLYAhXOCYQzq
 2akWjmU6aH2+mpsnR3q+UPJ5RDTai1sWB/IiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763581165; x=1764185965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mV6vpq9fYx3q1cFVcbviPcKTIJs38bJF+irn4tthYc=;
 b=kZhg1RFGGiweSqzrabHdE3Yc/5Vt+Udiv646wATg5DnQJwbX6Q1GzMfV1903buMn67
 e0379cNaQScdDZU0hkGWeNXNKOfjkrjaqQ0xq2EKjGFujFC3UVVj+XcNRM3sMkRiaTuX
 ZhOs3rWIJjn8VXh5gdMWfLEKMklye8iNuEKIEUhJTuEixvEZ/doKQTH9QZJXUp5mOp+F
 kDyYWXNc7tMsbxhDzl2lHFasd39Ka1ymAsgV2R5lHxMYyAzDJuzZUAEz6sbJGAGcf5Rj
 w03DNQzlQYKYrRqYy8lniT0UqmShNWF84N8UO1exUIr+k3BY6X6zRElw/V5OhmLZwuQC
 fKVQ==
X-Gm-Message-State: AOJu0YwkM0exi5I1yA92JqBbsksAS3me7mT40977Cmek4roLR6F+Uer+
 hRb15GihUCMK3C1oKUEn6IcFAqLEPSm3kNgc6DlW/MUtC+zSHynSIijq0bb8YXRym9g=
X-Gm-Gg: ASbGncs+15+SMB8VuRlwbfRcF/W27DEKmvN+uOisCCN3o8FKeM9L77TNC+bH4tLwgCh
 jFtBSOblPL0EUsNYsRsndp/Lm5cihDv3hXmvW3Jqu5WPlox15rq9N01yXlILvoG2wHH1faqo6YZ
 KVYi5aLNd47joYS/bFqo8ziJstn6Id04qMpimAqtKCZO/l8NZadeQH00YgS2KKQFxQpNbU5tj8o
 OlGV6XImLm4TApDcPnoOhivaUj+vqLWoetNsxCa6WaFf6OYW8WEqfIL4K9vMtTZiI4sGL05NP57
 Db6NeDexIoC8v9A5BN0oQb+ICp+nJzciJHz0OHQGmaei+epUdDIDQeO7WH6yfIRT6WQjlNX94py
 Ie8heh0zQMMY3+MlMci4OPjubO7PyuHwBG1mymHq10duBh3KwqEblK/BuLASJuCR2zMhxQdU+6M
 ebh/I4lqalFj+pLC2JrI9meO8pXGYEKYfNWQihuggUImbJjahnlJ5l2EMD3UwR
X-Google-Smtp-Source: AGHT+IE0sDDzWfbFWRVPYRg9RrsKEw4zjQ7eoB8Vje2QoGUa1sBzngbho21NGezO4W86Xj6oCGaNnA==
X-Received: by 2002:a05:6808:c3e9:b0:450:ac94:5ef5 with SMTP id
 5614622812f47-450ff26175emr251733b6e.16.1763581165022; 
 Wed, 19 Nov 2025 11:39:25 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d32c580sm138344a34.8.2025.11.19.11.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 11:39:24 -0800 (PST)
Date: Wed, 19 Nov 2025 13:39:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Aaron Kling <webgeek1234@gmail.com>,
 Eddie Kovsky <ekovsky@redhat.com>, George Chan <gchan9527@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
Message-ID: <20251119193922.GE2125796@bill-the-cat>
References: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jbY06NdGl6PqLLcq"
Content-Disposition: inline
In-Reply-To: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
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


--jbY06NdGl6PqLLcq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 08:32:51PM +0100, Marek Vasut wrote:

> Newer versions of libfdt strictly check whether the FDT blob
> passed to them is at 8-byte aligned offset, if it is not, then
> the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> android_image_print_dtb_contents() passed FDT directly mapped
> from abootimg to libfdt, and this FDT is not always aligned to
> 8-byte offset. Specifically, the FDTs are somewhat packed in
> the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
> long, then the next FDT blob ends up at 0xfd offset, which is
> not 8-byte aligned.
>=20
> Fix this by first extracting the header into 8-byte aligned buffer,
> checking only the header for validity, and then by copying the
> entire FDT into newly allocated 8-byte aligned buffer. While this
> is not efficient, it is the correct way to handle DTs, which must
> be at 8-byte aligned offsets. Mitigate the inefficiency for the
> common case by checking whether the DT might be 8-byte aligned and
> if it is, map it directly.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for doing this. We had talked off-list and I looked at the code
in question more and while it would be nice to abstract those two
similar loops in those functions, they're ultimately both different
enough in usage and small enough that it wouldn't really be a win, to
pull that out to a function of its own.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--jbY06NdGl6PqLLcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR4c5gAKCRAr4qD1Cr/k
CkGzAPwNYZUcE3EaisS65wnUU9uDoTbns2vnRhLW95C088viZAEA/Q3oBjbb5Rea
ltzw7xUqlILTgTHZf4/9VFZKm5sQTAw=
=XiIU
-----END PGP SIGNATURE-----

--jbY06NdGl6PqLLcq--
