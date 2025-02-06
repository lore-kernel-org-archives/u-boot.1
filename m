Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2925DC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBC88083C;
	Fri,  7 Feb 2025 00:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VDAzEJhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D8A80EF6; Fri,  7 Feb 2025 00:16:49 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27C3801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f11b0e580so29660345ad.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738883805; x=1739488605; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KcUKYenFS2zcVpzUtgjgygHNbaNjuOlZFTmy5tyJfnA=;
 b=VDAzEJhFVVQFzJ25X9qmEK9emR6nWiN5GyXUkJg9FbSnBkWWjZ/jvgH60Qs5PpQ0Dl
 HtvHZnwNqpV7CImuqU0yYaIfuudsCRaPYqvTZn1h5G4TWFm1fx1CxfU4FM7eiuESuTxu
 jne0EkhaUgGUL29AhvagYsl1aBn0zV6NRCbqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738883805; x=1739488605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcUKYenFS2zcVpzUtgjgygHNbaNjuOlZFTmy5tyJfnA=;
 b=eRVLKzhAehilJjdt1LG0N9S+QgdqNwulA6hp0XuQYhV93Z0cmvm620OPmCcMEu5dMw
 uI29wvAdlgw2qy0QAua8mBNLvMpgI2qko3JuqViCLqUbFUK5rQmIpNFOamoq/B/ivmye
 AXF4JIfbkxC17VA8EIO/rqqWjDRdC+ohDaN7yCu1QQkuUpVYMAmRDJ1yqoTBa4U851nz
 oUBk6ejDddO7CBGSE7GJj4hbbskQDeVD7ctiaNgyCk/+flcQvtBMbiN9yBmZHSRGlQyx
 FlgS7bHn0370X5N7H8dFSA1xub7KmkGF1SDOLwYk08mGjw0paCiQVPfCEJ7BZYzA/BvO
 yDFQ==
X-Gm-Message-State: AOJu0YwaJYkqn2N7ASlHXBTGXfcGeU0M4jgrq1hJRxgCpUxKg6gMKG9x
 KPx/ngsw7zKdz5JtIFJtirGPe872LlCn4yaLr+e6bEi+M/mh4egYirsy5LlJpbAD0mQlHwf9Jr2
 ohlo=
X-Gm-Gg: ASbGncstRELOFzRDOGPqKNnqXMebqQH6AibdOKfLawlr4QrBhLmyFZmYyHhJrSDmh4+
 jxJmCNj8BLM6G0R8K6DWpOTa6dgb/B49m1DZq6lPtlpbKL+BNBolBRhfY1jF4aWJ+DphRYKTOJn
 /MHkSiI07Im6uT/t8yWNlGDiINpdoXaWHuNI/aHROzTeTjbcdhRSEc1Eix2/JdBe+e5irRzrYUy
 CBG8JTr+nwoMARAhgVXXptlpjVVf6cXDRF29NelnTifSupudsgbZMoV1bILfe6yWQ/MUNlOqT0o
 uA8ze/sxQWsJBnU=
X-Google-Smtp-Source: AGHT+IHY4/8nrpJgqGnyG3o43qOQElTF8R0f8mhtK90kgo7aMzMS5Ir/lz6OQLteoRPJ058IJ2acnQ==
X-Received: by 2002:a05:6a21:501:b0:1e1:9bc1:6d6d with SMTP id
 adf61e73a8af0-1ee03bb7e0cmr2466811637.31.1738883805248; 
 Thu, 06 Feb 2025 15:16:45 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048e1f16esm1807491b3a.166.2025.02.06.15.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:16:44 -0800 (PST)
Date: Thu, 6 Feb 2025 17:16:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250206231642.GN1233568@bill-the-cat>
References: <20250206223858.64672-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0M2NXwllpmoEc4yf"
Content-Disposition: inline
In-Reply-To: <20250206223858.64672-1-sjg@chromium.org>
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


--0M2NXwllpmoEc4yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:

> This is a global default, so put it under 'default' like the tags.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0M2NXwllpmoEc4yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelQtoACgkQFHw5/5Y0
tyyfVAwAswUwbgrHYIqxs7EBENESiSxVWVOuop/mNAThh2SLyZhg7gQ1oMZe/m1K
DJBm9lMdM/Ib3auVC9EKzcECQmnORvfnfmyy00bjBBMvz5ef3hBqxAry1nDVXIOi
OFhmW3NTp+UNINxmsVoS9e5f2G3jmTDHAoP2/tsDWUINzbrIwCfnjiaIUNyOyx4v
RPBfVdleWwHfmy9m7gdOV+IfI1aTebO6t0qp1sMbbM1nTpPqZvvtWjD1kxpTxdyn
0CL4DEKnyzXuLu/Ghlan83aiwY7upNBo7qVqd2449Y756jF63riIeVEZg7UOdald
0lJHfkiXogr774S2r4SN5CZCLJY/JQf8ZBW2OFxwB+dSoVPqDovZ2RdKsYzEkq5E
JXVSNzx7xC9HgX8sOcYuGvDJTKWvF9sOMqLApa9kCssofQsstp/lSDdMRV18xPHh
/nwHXqmjmnEKELGi2Ew3eLnt2fD71HTJOvFZeZTSLaPWE/jJT8CWRpTOnBRsBBre
h4bbUNX4
=1zJu
-----END PGP SIGNATURE-----

--0M2NXwllpmoEc4yf--
