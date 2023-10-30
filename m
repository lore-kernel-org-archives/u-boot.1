Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45084C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 21:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E4987A02;
	Mon, 30 Oct 2023 22:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D8VQFuck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674AF87A23; Mon, 30 Oct 2023 22:35:57 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DC0879FD
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66cfc96f475so32635126d6.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698701754; x=1699306554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GR2W24U61AXhWBZaUTfpB9xVNJI0Q9IW44d/9aYrBFc=;
 b=D8VQFuckjQ5AhkEkcFSTE2TdpHoRpoI+sKACl0mKYElTpCdDxPUuhWXOiQfnVBeRAm
 aUKRRCm6qiBNM6uGLZEv5xASln7LBs0ApC4E8zC2EXflHLPPEz6t6LvbkpbiN/tSCSNA
 vI1LKAuZjtjHDVStaE03PPafctHBgOdnnjVI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698701754; x=1699306554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GR2W24U61AXhWBZaUTfpB9xVNJI0Q9IW44d/9aYrBFc=;
 b=BuHbuGV09PVkrNdMbLYhevSMj6KNpmFdA4UXrMWy/RdibqIbuE/oWTiv36w0h8f1nh
 YtU5FKjCa4zsKj83Y9Zqv26lnnzU0OMXz8kCxCTxpTY+jQLToS3sj9p5WYbygbVshL0D
 MhNyQTJ3/2htMWvxvKPcG6OfFKs+ejuyb6+i8rayBMu7g24xEH6un4M2G7sIeho8QU/w
 SD6M2BtgUzm/SV1hiJ3UdX4zOEN5wv2kM8TnFvr0kDkGrzddIJkWrn0Dux/WbcyPYckz
 hoJOBvq1ob5pbWIeWJJPYlAyBYsaDxhKj9lSbvjZNiB4LgLLmPKwGFllUID0kZy5+AY6
 xMxA==
X-Gm-Message-State: AOJu0YwTnJpjO//te27DTuHQMtBehKWsbLLEvPv7EjTWTLfEvNkvEXv4
 v83wJWuJOq8Dl65/XGGkC9uJ9RxQreSCTyE8t2BkOw==
X-Google-Smtp-Source: AGHT+IHb2oHmNQoDtYTI/oBduRoOPJsYflF7qnkKxKqmy0SjSsHAcwqMdbG3rPEfpc6r5SLYNU6Usw==
X-Received: by 2002:a05:6214:3009:b0:66d:65ae:18f6 with SMTP id
 ke9-20020a056214300900b0066d65ae18f6mr12730561qvb.50.1698701754072; 
 Mon, 30 Oct 2023 14:35:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 p8-20020a0cf548000000b0063d5d173a51sm3856373qvm.50.2023.10.30.14.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:35:53 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:35:51 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: mkimage: fix sfspl_image_extract_subimage()
Message-ID: <20231030213551.GB496310@bill-the-cat>
References: <20231024072638.39798-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LSuAo+OqmLR/sTe+"
Content-Disposition: inline
In-Reply-To: <20231024072638.39798-1-heinrich.schuchardt@canonical.com>
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


--LSuAo+OqmLR/sTe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 09:26:38AM +0200, Heinrich Schuchardt wrote:

> Do not leak file descriptor if writing fails.
> Correct the error text if opening a file fails.
>=20
> Addresses-Coverity-ID: 467054 Resource leaks
> Fixes: 64fd30d367a1 ("tools: mkimage: Add StarFive SPL image support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--LSuAo+OqmLR/sTe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVAIbcACgkQFHw5/5Y0
tyzWWAv+Nh7jTZYcYo5/rkV5LCwgzi/2qS7DW7JDJrgeUlj6j903RHisbP9q8IWG
f1rpKAKui753lTYKpt3o//O5ptk87HnvB1ebN/UG4OytHMyePB7GAw60p4ARRlQ+
S7RQi6ZZlm08+yX5dx1ETScQDYcKeLW1nX/jSuFviI8ZqPTSW+1IxG82oDhNJwBP
KTFnRYmAO5psdq/BL/l8DHacXCGh3IJDZR/L0dpISSdZlu0lXkZNvgCoI1gsadLh
Wp+G8zmHholg+ecrNxHONcM0ka3YUattPJ44TqRmq9cSwC8sAYm5+bjpdC/35YCa
fr4rsjTJ/k3nqKcNH2MHc/V7JEH2FiGC5RX3PMIjtj8PM0YrRHjNPbjQIZy1fDdr
22nvvLxHHrPshH679cVLgzXQZJedTjXa1ciFoz1snz9a3VN6Pi5MrOlHyPJW7rwH
QFwz/erMqIgpJM74xdB9EdF7TFzRrKhhZ7prifRcxdtK0HcAu369CtdBRYgl0fHR
5jYuTpuf
=CK/3
-----END PGP SIGNATURE-----

--LSuAo+OqmLR/sTe+--
