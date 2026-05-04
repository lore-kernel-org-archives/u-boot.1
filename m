Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E50CFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 22:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D031784836;
	Tue,  5 May 2026 00:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KnHjMJiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCA484837; Tue,  5 May 2026 00:10:06 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6550B84832
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 00:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso4313758a34.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777932600; x=1778537400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IWcebgyFZJhO56OqZIK/Nc2KTiOk0r5sXXiFL4NCXB4=;
 b=KnHjMJiGAJmkYleyfpVEUcGdeUhC5T0i5lnLE8eLtr+5nCMTwrJkk0/H6eCaEyrVxQ
 ZuL04yMgXKSze80f6SjauaG+8WPJqnC+KSgkYbY/Y9qHz8S3BKQgRcbAGZY6KMZNUUeJ
 GvDYq3Ik25HTU20hav3OdqsZcXn5e0ba0ZqtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777932600; x=1778537400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWcebgyFZJhO56OqZIK/Nc2KTiOk0r5sXXiFL4NCXB4=;
 b=gKpkJAAKo7v4GMKIyheQn5o8fKky7/7MlpF6ZhA8eDZA6fDvdNmXQWPG6erihF/4RY
 4brvT0zGIWcBbnT2Xk86VhQ7UOvk5zfjSjPaPRVvJDjAec3R2st3+TA0Xfz+N8WRHQsU
 wwCZlrBySjkyVyr+z4xQVy5NTHoHa6vNAdsIKP6Dsqlhz/oeD1HzvApNn/cNIe5rcQUc
 OFfiTVPcMBPwvBBDXMd7Wif6oCq7cHzVZQxpd1FpHaz/jWt/mOWx/2PKQnJS2h3DmUWd
 TWYVSd/QZZ2F6UlFlDefdq52rJ7Dl9wHG5QOz6DQ01Ket4H81VkUrvnMwJzJQYtgNFKs
 yBrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XXYDa++aGXE2VYCaoYWybIAUTaBwca6FujCK/XMXIBkIabauXJg/r5EakMnJ5YBpXoiFiAtw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywxq/Ip2nwY8FPeT3GQY6r7Sz+00qCr5BfrZ0tf0/N+BFLc4YF6
 3AEgITYqKG9lqoqtrmSgwv9VQJhg3TNtT1SK9WK7afyNZeI6e5kBsBA2ygXFZR6TDz0=
X-Gm-Gg: AeBDieu9D1Dn65qmMOD0uWg4VMkhZEsOd3SfFTIM2OehRhtqWYT9QUfLkvSbf/+RDk9
 PO9HWlmoBr9mupMhagm87gq6j/ARGHebAvVU/aXR/5srlKkpm8xTK8CBpQK0Dm5g59DMc5w2TW8
 X3HrFY8hCNJk63kb4wtG4aAi7TZyYFdISiAx5XMPgha1L3EqpTRMc6iz4yYydv37EYiFzr5zF0q
 UsvmEgdQjDhiL5VcwdzcfsU4bJ8vjnxrMcTt21vQUVcUzBWBZVO0SMuJyh8RuxWUXL0KEEf9STm
 sHxcY4aU347w6kFJ5ZGvvvbG7EfnJ3taigMcLqzsrxvIg/9Cf3WDGa1VpLijXARYbvNRX7ziIQW
 nzOZk+Ipa5f4xsItzgUNWFebEkXQS20YsWiHqXnW9pTgKOOyWDmwCERzI2HTZMe/xGM1gbMzXKA
 zFweoYXFPaiJvw4ZWQpYTEDEloX6tzVXMrwQFSFw5OEwAdopoXgv0l/iXNUJA8fhDFrKC/vtqr4
 5+vioHY34Qp4DqvYli77F7vWU64w/tVS7qDYu91SpWNS86lw6tmYxCvOjp5HA==
X-Received: by 2002:a4a:ee04:0:b0:687:60d8:776d with SMTP id
 006d021491bc7-69697dc8e7bmr5955154eaf.54.1777932599942; 
 Mon, 04 May 2026 15:09:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434548c1151sm11627781fac.2.2026.05.04.15.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 15:09:59 -0700 (PDT)
Date: Mon, 4 May 2026 16:09:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v5 0/8] Add virtio-mmio support to m68k virt machine
Message-ID: <20260504220957.GM1614990@bill-the-cat>
References: <20260416093927.602613-1-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mF8dvDO1CJgQYjyA"
Content-Disposition: inline
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
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


--mF8dvDO1CJgQYjyA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 06:39:19PM +0900, Daniel Palmer wrote:

> Lets start making the m68k virt machine support useful.
>=20
> First we need to fix some m68k endian issues.
>=20
> Then allow virtio mmio driver instances to be created with
> platform data and fix a minor endian issue.
>=20
> Finally, add the code for the board to create the instances.

We get this in CI:
drivers/virtio/virtio_mmio.c:359:15: warning: cast to 'void *' from
 smaller integer type 'phys_addr_t' (aka 'unsigned int') [-Wint-to-void-poi=
nter-cast]
  359 |         priv->base =3D (void __iomem *)plat->base;
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~                    =
                  1 warning generated.

With clang, please fix.

Also, it seems that "sysreset: qemu virt: Use __raw_writel()" has a
duplicate Signed-off-by from you, please fix that as well. Thanks!

--=20
Tom

--mF8dvDO1CJgQYjyA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafkZMQAKCRAr4qD1Cr/k
CidFAQCE9OJFJztTJnLiyUfMzxUe8gqC8NQk/iC8V6ptLb2oBAD+OL9XgF1dfsoc
RmVBE5ipYJ3pxq0fcogvH6ZprUQIVQg=
=zSJC
-----END PGP SIGNATURE-----

--mF8dvDO1CJgQYjyA--
