Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28972C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:03:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942D288333;
	Tue, 21 May 2024 18:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NIOzewYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D217882A7; Tue, 21 May 2024 18:03:18 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9600688333
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-43f84f53f66so1890211cf.3
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716307393; x=1716912193; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E15bcXJ6nejZLMBjQh/+8uMriVmV4txpDhTs9793RFE=;
 b=NIOzewYlSJujQicKG6z7zWaE2r+x0bfpjfyZLwP+iKeaHHEGSaZlO793Fuq5sEQ3w4
 gt6IoMLWjw5Gusp87pNPuqwMPiwTVwDAvEUR1EgGou+Ur1F5WF0oQ5rTP7ViigoTOWc3
 YVmGp817Sp7nN4hNpzMDuyYDf4/pKPEXpUe18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716307393; x=1716912193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E15bcXJ6nejZLMBjQh/+8uMriVmV4txpDhTs9793RFE=;
 b=YJV9YPK8bnoYGxnp/Z2x4/iIQ+nVzbWhSHNIPyD0F+rowII99rSXZj1F4KAjFeo88i
 NQO7KXbJctHQh6+1ZKZ9ZkTLSkHC3QGJMKE3iPoMOnUhhVm1CCYcIh9kWC2sewpTPrhH
 a0e9HdzunImuujsorfIR3mg4d3Ro5YJE5JWo7VqQ7uke4OhA7+yXUHSFAv1dXDHbcIWU
 q32+MXJsMHM+OZsSth4k/V7Ow6NSIogrZ37sCUM7pYvzSmaUWNlDwpVHG+6pQf+Svfyr
 CXr+GtaynsXVuEr4j6UEqIwIUiiNbdek+QQ1/I25NZuTJObIv1WYnE+AKJ9Jqq1JF2RH
 gpqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIW9FPFuuB4ZLBZ9B1hE+0zeDV8VKBEVSlDA09VvF241W9T3MRj6nw8P0xIgq0Pz42fGXiqEBxnrTd9qAyqOICtDpu4w==
X-Gm-Message-State: AOJu0Yz2A11ur+tnitMOGEVvxmDh+FzL1jja196ITGKem01oNbcIeJav
 ToNSHsdk5pYcF289ReXPgjecrsLZ9Ii5FfpToPNIummEdwzVWAMX5K+xiZIt9ro=
X-Google-Smtp-Source: AGHT+IESeeCg4OwJOq7w7MhtedAe4urz+Z5FC+cYokON1NIbxxjtGhl3qFCJR7tsfkgF5qkr1cViNA==
X-Received: by 2002:a05:622a:491:b0:43e:2574:ea9e with SMTP id
 d75a77b69052e-43e2574eb65mr273513511cf.50.1716307393073; 
 Tue, 21 May 2024 09:03:13 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a5724sm1295669885a.69.2024.05.21.09.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:03:12 -0700 (PDT)
Date: Tue, 21 May 2024 10:03:08 -0600
From: Tom Rini <trini@konsulko.com>
To: quentin.schulz@cherry.de
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de,
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2024.07-rc3 released
Message-ID: <20240521160308.GR2568172@bill-the-cat>
References: <20240520160635.GQ2568172@bill-the-cat>
 <7fc715fc-eb51-45a5-b7f2-71668bfd3eba@cherry.de>
 <6e7ab24f-1c01-426b-a57f-85f836a13171@kwiboo.se>
 <770c99e9-a5f0-42a9-9904-25978268bcc4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U1iEKy5eTMjypyto"
Content-Disposition: inline
In-Reply-To: <770c99e9-a5f0-42a9-9904-25978268bcc4@cherry.de>
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


--U1iEKy5eTMjypyto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 02:16:25PM +0200, quentin.schulz@cherry.de wrote:

[snip]
> I'm also a bit confused as to why we need to specify the size of the
> allocation pool pre-relocation? Why is this important?

To this point, there are platforms where at this point we don't have
DRAM available yet and so are very constrained.

--=20
Tom

--U1iEKy5eTMjypyto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZMxbkACgkQFHw5/5Y0
tyzDrwv7BAnSSzBYoVzjf+f3eqYrJ6ySEKoXR1HeVkCcvLUmUDZ2dxJ2oaJIdvCq
x1d4aK9kuxmN6VkSLE8P0rmtY4WkjdqjltnqbwxU/SUWhcyBgg8EtQCP8DdIort3
caoEOCbnSChxPWVqZN+XPhO16+P3oH4hDSzdM7871XQmQ8mH7COT76IB/MyIFaLK
HvPZnOtVc1pOjg0UIoTJhPagv4sVYu1Pq5LLtBeZen3eEz4eF8CU7nWkFJJrKgU6
XZDOP6QUSjv+d8MUdF1d3OJY00l8IiK8tZMSklQLXE3R3KRcMrsBr5vIt0aYkFek
EdMK6qDHun0z1HoHhifDU6aT0AFMMlX7i2QQurNF3qBIuEZuPKwPJZwolTUztUK+
4MoJHgl5ilbSXH4PyslHq442OzH/SzVjyC43L/81FpygF4NoFE9TqQ0y3zY+4DJv
R5kka4WK2GKE+fj++ImA086mYkEErF7eEga51Ava7pwi658B2qz9NK03uk7QQY2B
hSdP5FF/
=uUSO
-----END PGP SIGNATURE-----

--U1iEKy5eTMjypyto--
