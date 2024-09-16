Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40074C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 16:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589A288EBA;
	Mon, 16 Sep 2024 18:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aea1DvNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79AC488EC6; Mon, 16 Sep 2024 18:29:19 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686AC88A9D
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 18:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4581ee65b46so31253981cf.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726504156; x=1727108956; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PXRuulX/PkQjPAYIohyUG6dUamOp+riFdkv4e58t9lY=;
 b=aea1DvNep8j5H504h56kxQsn9VW2XcoraqRgtt/nGgDVo7LxeKn5SQR32HXDJy/q1C
 R7RVAEhKul/eRkNjeeSA0Uz4iuUwnJQP/wR3l/SC3HWtW6Vb2yE3+hjmuNR3ViOgn9nw
 efp20w0v534bTGjXOY3VP5qAhuo/BvV3VwXb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726504156; x=1727108956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXRuulX/PkQjPAYIohyUG6dUamOp+riFdkv4e58t9lY=;
 b=Qcv3L/8JlROgQ3HhGrGIH7qn5MFZMkcSv+WktyVsivYTLl8km+ET4chYh2UfjwRMrJ
 yfu+3U3j2hq11inxaGqM9uFLLhHrmMPk3IaQxI2RGzKiNuC6qaF+FmAb61vR1c6k07Cs
 ZcddARBkan3Y/YmfvK8TAxtcZyYd/w6FLv1l3CRQAyCdEgZa9/aP2w/ewoZ6KCb+1sF8
 DSgct87kL2mkrTJPePHN0VUKMnW88qHO3hEnwMosJiXyyLROG6XgSvjOgy+RutfJviWA
 d0jyiZLZ+gLEtlVqM4J1cWCRt5jpexzmSflM6kgwtwtqJBQKEIM7NeEjvpRFkwTcW3Gg
 dIWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAKHn9WO45es+Pk2KWM+7AsCB4d0jiJIS3hYAJF4bQzEeH/xtQLtTwOmpVdn3Ot2D2qeykkXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxVww7SMBiqibHgHWGQE6C78PVkjqCZmAkkArHa8qsqDpRVLAVl
 grvDblypNWeLouILIhpBgXiYLOXVT0vmMyF0tD6d/WifkghVST1SaUlUHZJkJBxRZZWjMRbA9X6
 DlR8=
X-Google-Smtp-Source: AGHT+IEwxqNMoHq1VnOJl65OZaV8b+cBPzaaL7bVSQeU3vBxX5kuGRb700CzesXB79lB2ksSAUQzwQ==
X-Received: by 2002:a05:622a:1ba3:b0:458:2f3d:dd78 with SMTP id
 d75a77b69052e-4599d235b4cmr191035491cf.15.1726504155907; 
 Mon, 16 Sep 2024 09:29:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aac611c9sm28814291cf.17.2024.09.16.09.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 09:29:15 -0700 (PDT)
Date: Mon, 16 Sep 2024 10:29:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>
Subject: Re: [PATCH 0/2] ARM: meson: libretech-ac: add suppor for EFI
 Capsules Update
Message-ID: <20240916162912.GF4252@bill-the-cat>
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MJLTFXrZpdZlI8eg"
Content-Disposition: inline
In-Reply-To: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
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


--MJLTFXrZpdZlI8eg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 11:41:47AM +0200, Neil Armstrong wrote:

> The necessary changes were made in U-Boot to easily support
> EFI Capsules Update and be compliant with Arm SystemReady SR.

To be clear, "SR" or "IR" ? I assume you meant IR here.

--=20
Tom

--MJLTFXrZpdZlI8eg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmboXNgACgkQFHw5/5Y0
tyxweAwAg2r/BhkOFrvohD+JIKVVkO8F7ovMuCHA3/rYB31Nar6nUHvbk8nHqsjZ
OiDiSpg7EVdZela4h6dtok86gFcTEo3aQ2KyAZdc4hl3jiE4iH2KrJ18fPpyrOWh
crA6FYlBfoFHwM2K4aDtMvDSWJmonW440H65W67EbnBCGbHL9X3Igt5n0uQdJFIo
Ow1weEirrhEXpgusLN3aBN9tgnPEzSnYMKRVugxJZ4MKQlG0R6bmu03AKSJ5WVS5
gjIJduBbjlVr5pcvI5Nc3HC7ZjR2uFcHR2zltFqGDx9gWcEcuZhNJGjhnGx9GPn0
Q5YS/7JOMrnWk7XxA0Jvmhj5RF9XUVxKukDPL/PVmDJwjk+8tvWWTU9t9gwFYtfz
qlOoVD5c1iBPDGn60DbylWMcYlD503t3TpH0WpalNkerDHp3k2a59H2/PXPF8mSD
R6kSeFKiVdHJdSllG1g+O/vxPE/DbY53gNrDodXK3v4NVz2/f5ZfZCjjfljVjqW4
hyCRS1jU
=PHwe
-----END PGP SIGNATURE-----

--MJLTFXrZpdZlI8eg--
