Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396B3D1BDF3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6BF88E50;
	Mon,  4 Nov 2024 22:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pUm60yib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE29288EC4; Mon,  4 Nov 2024 22:05:40 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEEAB884DB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b14554468fso356944785a.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 13:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730754337; x=1731359137; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lCFHz45xToQDjebiGnTOw4lZthMFVgVyYrzW7Vu+f4w=;
 b=pUm60yib97Jpi9L/Y61j4wZj9OA8l3l++bNtYaNv5+aSCFCpeZzeQnRkpEU4V9kL+y
 cv8tesMqV0If85G6nNWgIr1JUawZSlwPO8o5AAyqrcjMSoGiAFPNNdSkIMzRatNS5Wj/
 oWPdQU+AHyHhFSrydEwWPfEtLzvqRFy03kBck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754337; x=1731359137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCFHz45xToQDjebiGnTOw4lZthMFVgVyYrzW7Vu+f4w=;
 b=vytBG0LVGY91xtg7U17oaxzVNDWumlq19KWCnboEzITkoI0/x0Ut6MQbF1ep6Y8loG
 5eSL/iVb6FPTd18aHXBB7CzxrkgBQzcLldVrHcZU8NKW+FSb7SIxkb0TydAtQ+LbIOAK
 oTKnUkLVCLKVlhXjqx9vyNMVCDBRf70MPqXsfmHeQGY9yQ73z1AntCkxEWT/yCruckXN
 d+7ACEYKLj1IKkkUyzZ30bJWFCXw4ZXCiJTSiEFKfHWDcmBSidczxEnTBBSgucwzeS7y
 eScXM2I6OYoIkzDplGT5HL8Dn6lf6w5hj5eAF1JidKkqAPlZdv+SOp+oBUgsp6sq6n2i
 QpGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXJtsU2/vIbGULw0gahzMDah/FYHgNa9b2pNckONHEoweR8lSJIoKxe+gv2Zam1Q8YkXk5Pno=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7MEwS20qIGbFBq9xrmJcz0bxypZHvMHzGi589JUlawFs71ZAD
 s3/qJAwpjD2v+UFQ2hAKmneWMRkZ0LHAFyTQTZwOUkrI0b1+nK58mq/s/zGCSxdugHUV0fWnCGE
 aSSw=
X-Google-Smtp-Source: AGHT+IHhB6WpXA9g82Kc9F5tPyc7ZsTfU/LVEynNlHUm3UpobjQwdtv+HqAvwdT/2WFqIuk2RjdUhw==
X-Received: by 2002:a05:6214:5404:b0:6d3:66fb:ea7c with SMTP id
 6a1803df08f44-6d366fbeaaamr166458846d6.2.1730754337474; 
 Mon, 04 Nov 2024 13:05:37 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9e7e1sm52342026d6.5.2024.11.04.13.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:36 -0800 (PST)
Date: Mon, 4 Nov 2024 15:05:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] lmb: Do not use global LMB variable in _lmb_free()
Message-ID: <20241104210533.GT3600562@bill-the-cat>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <20241101-io_lmb_apple_dart_iommu-v1-1-fe4b9a74d47c@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1O/aykb23V5/ONAB"
Content-Disposition: inline
In-Reply-To: <20241101-io_lmb_apple_dart_iommu-v1-1-fe4b9a74d47c@jannau.net>
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


--1O/aykb23V5/ONAB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 11:15:51AM +0100, Janne Grunau wrote:

> It will be re-used with a lmb list pointer as argument for IOVA
> allocations in the apple_dart iommu driver.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1O/aykb23V5/ONAB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpNxYACgkQFHw5/5Y0
tyxqIQv/VJsLYGyaPDGljhr+/qbWkDehO3ZrTPtaMSWfHkp+CU/Pw+4zHcGzjCHa
du45I8CFqtk0rJIxgGx4m5AqcKPgXpGT9Gl3SiLNTi3H+1RZv20oRj/yjSNYK1Vv
/SmO1hFNf3a1t6UCRHBoUEb9SOSG3LK6lZth/WZ0ggLhllC3W2uBW4M7mDChPfhY
a7W0oFUsjT1WEtEKiriODz/OCMly/h4ikVu9j4yuBNbHAs/eNzyZyEgKNznPnLO9
M8bcreEw+0gqwbdGaWt6RVe0K0nE4pBk9JlShbV+595lAH86H6Q0XBhhkcJ4uKtF
A4SNDa+Y/d8BU5VOGTRyUhXv0ki/7F1Usf2HaqzzdC0fUwcyFookF6OPOQvIJegp
4RQBDyzuoj1CMCjJsNRcakYVRpsQRvBtbwfq8rICpZlCq+SbAaAzvXng4bI46kI6
4etbngVK6wZh8nWLywIr5ZenNf3wbv3q3rH2EfEBl84IaZYbRfkMYGSfs8sgIe/Z
Lu8Elzmu
=zvlB
-----END PGP SIGNATURE-----

--1O/aykb23V5/ONAB--
