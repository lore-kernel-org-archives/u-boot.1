Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951F9C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7982871FC;
	Tue, 21 Nov 2023 20:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gS57azk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C88987250; Tue, 21 Nov 2023 20:06:21 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B965871CD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cd4446cf5so36029861cf.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700593577; x=1701198377; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4C9rAVM4DIvb2rsjBxJhmj7Bx6z+Log8fFMY6QiBJJo=;
 b=gS57azk3jpVjJ8Cnn7MHhoQYunraQa0GYRMR++tG3aF4xHVxaFVKzzKE0bagGZnAiF
 pFALR0oiIRKyroqeIRmiCym/EbmusIS/TrZI7D0+BjtCsp2eHGFFIpzZzTfOLTUHE6kA
 Ih97agLiOWGUEcRCNMmX0gk8G1G+WYlCvbPXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700593577; x=1701198377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4C9rAVM4DIvb2rsjBxJhmj7Bx6z+Log8fFMY6QiBJJo=;
 b=pHwZv932WkZCdmHzQGNXWROs65Se0gWlVzzxdixNGpcV+Gz60oUpNSV80k7maDEsVX
 JL/b4RF0YkzpQDHakjNe4+aqowF2BP1bya7PW5wfaFpdHXST5SmUfvEBKZQB3X2pG+ow
 gBgcCy7HY7n5CvX/BJvRgTg6VsazyBqOjKqnt86g4qk81xwAP6lXaKGRXuf4C8HJUodQ
 ZmMbQdCXP1i7mJF2EKAKu0E+UpZyVvQ+LB3rBasl8OXn9zmlIsZu2pOw/A2k1v0/YQ4d
 /gqLazqSTHTmKmsgCyOnkPzRcDgL9sAYHkYviIFl4Zs8ssfShEZOV5zJP5CRKP2bQPN2
 oQTQ==
X-Gm-Message-State: AOJu0YxenrwzTw3HX3/zWng7uA3GNqnW5COh87wN2BO5kOZxL25rIVh/
 cLXlaFEvOyBs4oBSeOTlmUnwWA==
X-Google-Smtp-Source: AGHT+IFT1DdL0Rxp23hBUvS6L0XJSwTs63P4z5o1jOQYT7CnR6uLzrWZKbQvH9p3V1WQuGLpeZXgeQ==
X-Received: by 2002:a05:622a:11c9:b0:418:f70:df1 with SMTP id
 n9-20020a05622a11c900b004180f700df1mr59236qtk.42.1700593577209; 
 Tue, 21 Nov 2023 11:06:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 n5-20020ac86745000000b0041e9f3c3be8sm3806331qtp.23.2023.11.21.11.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:06:16 -0800 (PST)
Date: Tue, 21 Nov 2023 14:06:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 01/21] arm: init: export prev_bl_fdt_addr
Message-ID: <20231121190614.GC2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-1-9492198e0c15@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d5DISj/wIZSt5c6x"
Content-Disposition: inline
In-Reply-To: <20231121-b4-qcom-common-target-v1-1-9492198e0c15@linaro.org>
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


--d5DISj/wIZSt5c6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 05:09:24PM +0000, Caleb Connolly wrote:

> When booting U-Boot on board with a locked down first-stage bootloader,
> we emulate the Linux boot header. By passing the U-Boot FDT through this
> first-stage bootloader and retrieving it afterwards we can pre-populate
> the memory nodes and other info like the KASLR address.
>=20
> Add a function to export the FDT addr so that boards can use it over the
> built-in FDT.
>=20
> Don't check is_addr_accessible() here because we might not yet have a
> valid mem_map if it's going to be populated from the FDT, let the board
> do their own validation instead.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--d5DISj/wIZSt5c6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVc/6YACgkQFHw5/5Y0
tyy06Av9GqUfDF5fOhSEfEQDzuR3u8LZ8YJKL18J5Pm3lmKttgce6MySBj2VwXSm
eDOOetEjvV/iaXuKEQWLJpQgytFEmIlOrtfJO94kgmVWHYm0eVlYax1owODXcUlq
nV43g5qhEOFGjZJdGRHylhLPnorQucOqw6Gg9uqAqQ1/zsRe8vM7ENY//OyzdwAE
fwqtm/4eEpQqASeiTYFMSAKaARRcXoRvQWx7I+fHnAzJZgrn19b8bwv9TWa8h5VK
Q8CmM6RxQu3rcDQBQfMV1Uf8njYkKzUD5xUtcCu29LCQqO2IMj3p4rkJ/qIavwgm
Q1fiLGZcm4NgxFsQtmh550igkuEFGXgKYxS61zylj7Pc5OkSnq+VWBoYOCAdDoUk
jb2ma0aJnhEuAe9RzheCepFqd654zS2hCFyWYfn6zzR5vG5ARLQ2ryZD8Lke13v7
CaBo1Dpl+6duuIIgLZg0nXAabUgNIX9CVBROhXo6o4C4cjP30AUlEAeyv6MX7Wdh
T+qQVqyX
=1y/d
-----END PGP SIGNATURE-----

--d5DISj/wIZSt5c6x--
