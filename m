Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD18C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2176807B9;
	Thu, 23 Jan 2025 15:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JEuCRabn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4442E80243; Thu, 23 Jan 2025 15:33:04 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239D480137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6f7d7e128so204671585a.1
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737642781; x=1738247581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=toV9uguY02p81Z7l+zJgVrYMqDqkUy2Rnlv9D9pX6CU=;
 b=JEuCRabnxAGdgbQbTtCIBjykmaVvmXzlH78OMhGGj5oPtLRbzuJn7ogcHs0zgk6kRN
 ELkVhEhkY2Bcv7Rc6MqvGyzX4jCXLtZhfYZ10pM/5I/egWMghhjYd4GIgEWQ4voxGyHL
 +oZNk0zMNIoMzxZBecn0g8mmhH9+VLY2PxMwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737642781; x=1738247581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toV9uguY02p81Z7l+zJgVrYMqDqkUy2Rnlv9D9pX6CU=;
 b=Jz5PePifXnhI/lMVbl/1r7ejMqnJW6qk9UzXNKeaP47GCrz4wRxECzTYZVovIkTYJN
 XQCL+7YYal8kyyo7LOAbsW15F7+/YYxqUn6VLNkvh/+9DikUf1HrMs7R81JEPxKe+X+K
 L/qA+HNoJCfT3fhcXKxpF4he7ru9ZsPBeogt/locdhrUSlBL2F44lrcyVuKGHyAq8cDJ
 ct1zkuekAQbMBufZo4ziXbFzDIIJ3eDLLQFFHqPBghQP1UVD4Awt0J5qWhOmWjLgEmoX
 vL+Qy1FV3ZvdZ9d896v22Bwo7gA+wK9IkB0a0nNqN4u9w+T9NIIoqLO0mttltQRLYLlT
 Fnxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV3Wq8EfRSx/syQ8fuCkjp2tEBHY6qO79861GtLf6LrZmUL/Wu4RcQt4Puk0qjnF2fNjtsPn0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzuz/6T9sMjjMfSWO3X8FUcYcm/il3pCFpOa1p1gmOSkSdg8Q+5
 QGLR2OpNdFLVJCrv3RWJTOzBe6FbT3WzdV4n6idpHxXpKTTOXYac7MgQjyoZung=
X-Gm-Gg: ASbGncsotQP1h9H+Toywsic5TVIzgUfb5gDNmOJf/tbDOTCR63Ii9tURm2d1xM/6DeN
 xf8H1dsU6sczB14eBvrE61I66IV8sKAOZ4Fe9g3BQACjYJzJLcug3AaG25/Q3jb6CAED8kQcupD
 qI/tk+dVU9zm5gPqcViRAZ6QLfNNAwBAZ0yj2wb7vlLugtAmcVb00TzSbuNfOCwnix9OJR7SZkf
 lfpOoR0N6qcOC4IHviLmZ57u1XknY50d4eeb8q+9U4RvC/+YVVq4rlIteVt9zfZuqf0tqFAZVrb
 EpKq
X-Google-Smtp-Source: AGHT+IE2McYDGjU47qGRsvER4dAhcWXkvBjswrp9ubz6mTcdhmr+PKhl/bzFLzEUmPKUUbnuhMJXag==
X-Received: by 2002:a05:620a:4304:b0:7b6:eba3:2e08 with SMTP id
 af79cd13be357-7be931ac818mr493373785a.7.1737642779521; 
 Thu, 23 Jan 2025 06:32:59 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e102fb9adsm74974761cf.18.2025.01.23.06.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:32:59 -0800 (PST)
Date: Thu, 23 Jan 2025 08:32:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 John Watts <contact@jookia.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] spi: ca_sflash: Remove redundant dependency
Message-ID: <20250123143256.GH60249@bill-the-cat>
References: <20250123073713.2988293-1-ada@thorsis.com>
 <20250123073713.2988293-2-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uVTdeNqnLwwxrD42"
Content-Disposition: inline
In-Reply-To: <20250123073713.2988293-2-ada@thorsis.com>
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


--uVTdeNqnLwwxrD42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 08:37:12AM +0100, Alexander Dahl wrote:

> This is inside of an 'if DM_SPI' block, and thus always true.
>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uVTdeNqnLwwxrD42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSUxgACgkQFHw5/5Y0
tyy6IwwAq7Fa9CblwfW9qf7siYdZhAeA4QypTIUbr6JAOcLoFZkqpjvU3Ns4pvI0
G6oHDJFvntnvdbYHqbEqyZSWVY2DL06O1Pg20955xmmDkXGu1zSJ0TIjVudDHocS
yYAUTFoxdPsGnDqcgQduNULcxbR5L1ySITeGd8SocwTQqxADhxSexTpEsS609a5c
KiI2y+SNrknlUpi6bkklY3brDfJ4N4K+ZQ40eQufS/BXKMMwfvGk+dvFghqAQ5M3
nyI6opvMThdfkx02eS4WbrCH+S8qmBhdsevl77qV4VDh8LFrUO5xIOE9IlWwKVeN
mIOg6O5N91Gt/ZTHwX4mnHZwpPi60df91gyIStGInu8HQuukWRwzc5L3PPlGS13l
HwvoDl/NjaSyjo2wREYeH/ZyR9RJPOfXD6kZ1q9Z4GOHrSCunqk1m5jDGDHsTXjv
NdY4TdZRuGWtw/ZxTcBlttr0GLHTNja/aco3D79+UypiSOKyTqtg2cSkj9D4VHKT
yd0LSqcK
=CPyc
-----END PGP SIGNATURE-----

--uVTdeNqnLwwxrD42--
