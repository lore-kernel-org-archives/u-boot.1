Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA33C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 15:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D566A838A2;
	Thu, 24 Jul 2025 17:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RsQg1OAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83BCF838C1; Thu, 24 Jul 2025 17:52:23 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681F383844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 17:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73ff32d8b87so704685a34.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753372340; x=1753977140; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JsX5u0/oZgS2nXEMxg/SMLRNGkk55Ru50vqY1UQJg5U=;
 b=RsQg1OAoOTSYajBVwRospIUetyqGiT9X+Z82mY4JaBjGvsUhCKClHbs90wpSED4JMk
 I2n4YdYhg7D/9nGvhjgLDhAXbJhiaHdmrgGN/AAbBrqvfJik1mMsZ/8k196EWqo7fwRu
 KJdfG+tcrs8wRYR8qOlYT/kNv0fdLsAbQ/Qu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753372340; x=1753977140;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JsX5u0/oZgS2nXEMxg/SMLRNGkk55Ru50vqY1UQJg5U=;
 b=qXz8fvlCROnhqG131ptzGVPZgx9H2Ctmiao1tj4h1ZtZAmy2K/PQhQ8rfCA5Les3tO
 2sGK9B8cPqagizHUnX+DUXqP+L+EypZx3v/Ytlob+AETr4FD8QRLlj4/VwAJ+vIfnx4O
 a/cyFsuafbp67c0eaLVIDGiPCjog6eRFPAtqoT0xaOnVUJ1yNp4ARtLbpV/Lh4bhvjNX
 Nt+nWK5L54E+VN7xWd3tT7rPRg4jdnX6UT2BM+9eDD/HR8RxXgSXSxdH5KaHOPohdgGM
 sZZjxEmqYWEgUVRQ7lho7cMjqxgjry5gFXOC0qxBniztasxfe0GsUEwc6o9x708cBaoI
 5XMQ==
X-Gm-Message-State: AOJu0YyIyZjTcf1Pyha/+YdJcNefTpjrcH21XeZwOWsPZJ7//ojaVEK4
 iL/iUJPxrhLUJgU80XDWXc3U61A5EwFdBKAJrqoEI0Erdjy0Gol/AvbUFWgR6VoPj+E=
X-Gm-Gg: ASbGncsVQFWnFYPep3XizdMaMlnYuRsJZzfgjpR0sCtN6Ts/lZHKAgnPADl9kfNqGgB
 sxp2zfVIIWk8j8Vui9NuV4mhQkUQkFkzw1313+BHtZHipshK5ixENFEyhImCjntnpwHXHSUdT2j
 J+4v/LW4KYSpnhs1tWBZL4IgL0ttLE5rWwS11DusgNKSQwy+NO6TWW16LWI4BDjaEVg0jLaxkuR
 jCTDOjYpi4RQPM6I8LqoQCsW4ZM+iBL4uD59c5Uu/2ZQet925fLWPC1KNELWVpu7goWeKmgF96j
 zppukr+brcd0f1cIkaESJFKVCiC57Ev91mEgE61DMtcC6rzNffmReEbve6j3kvw425evC9FQIx5
 Oq0KxeJQ2w1x87izTNtgO2AAIJb3nl5CKvqtOGVixrcVWyqflwE4YlSpY
X-Google-Smtp-Source: AGHT+IGdsoGsZfCBYNMW0qwFzp5aawJft0Lzvt5thJIyrVcI/3lDB1rPRz4dusFEJVwJCR3bbuhfiA==
X-Received: by 2002:a05:6830:8089:b0:735:a6df:babc with SMTP id
 46e09a7af769-7412fbc0b27mr1165635a34.3.1753372340056; 
 Thu, 24 Jul 2025 08:52:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7412d0fb94fsm309428a34.9.2025.07.24.08.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 08:52:19 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:52:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de
Subject: U-Boot test/optee/optee.c problems?
Message-ID: <20250724155217.GQ2847763@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TJAfS/qyR8K3vvpZ"
Content-Disposition: inline
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


--TJAfS/qyR8K3vvpZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

I only just now stumbled on this because of testing some other changes,
but it looks like with commit a2535243e011 ("lib: optee: migration
optee_copy_fdt_nodes for OF_LIVE support") the tests in now
test/optee/optee.c weren't updated and I'm not immediately sure how they
should be. Can someone please take a look at this? Thanks.

--=20
Tom

--TJAfS/qyR8K3vvpZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIJWrgAKCRAr4qD1Cr/k
ChquAQDCu++6tc2okVRB4v/yUJLOe27kpDUE9Jg6qLXlmhOLzgEAs8WsFRxhEaTc
IjCWeZSYj9ip5qiadVe2FUcCEsFzKAQ=
=h7RY
-----END PGP SIGNATURE-----

--TJAfS/qyR8K3vvpZ--
