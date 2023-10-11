Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2267CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B2AE86E43;
	Wed, 11 Oct 2023 20:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sVMGh8iX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CF186E13; Wed, 11 Oct 2023 20:39:08 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8579C86D94
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7afd45199so2175257b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049458; x=1697654258; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aVoW3cxk+/ezCbNZv4OLbhoiLsnHrqmuVaP62OEBwcI=;
 b=sVMGh8iXezqNnV+R4f7fMAiMe0QbZocTxmaaQPdgSzMrrOapb+GA39YD0X6ph8kCrm
 6oYz/jNfOxueT1dAhcBIdpgd2WGrGEv89Cm4qzMc3ZdwB39cPEsFCB7HFZoBY4as96Og
 3bmfKQhJsW0ltMnUE9NfyKOwnzUwsUaeH3Azs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049458; x=1697654258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVoW3cxk+/ezCbNZv4OLbhoiLsnHrqmuVaP62OEBwcI=;
 b=dhIlnCGW39qaX74dB7d6TuBIiY/6c2XroaHrCJUtfd1EBybpWkVgIkRou3Dw9Lv9xQ
 1JmLdbhfyQn8WEaXjNvxze1n+xVVcHxYUkQiwIN2AqC2tKE4YkxZKkI98bPKpeH/BUUb
 PyCo+se7NckiB3zNLcCWzut7G52rJA9eSpgLlZ0GIRbVb+CKlQrSzb2logAboVMc+Lsd
 O/sCWsSBMkCJaf1EauGftRfahtQkSu8+oXHJ4Oo1txxFhb4LFkwv8yCTtAgNWcjYxDJv
 gDj14rp7fJXcPvNJlZPw51IEXU/Xxxxsomdwd6zi3wL8BxHq19vjjtOfo8jgJxTO9qRg
 17zw==
X-Gm-Message-State: AOJu0YyAPW4iKUsQ0R1qmbG4CwMRj+F52wR9B70zTodNz0jRjJTp9Ypt
 4DgzTJw6rnJcveVfEVWimSOJkQ==
X-Google-Smtp-Source: AGHT+IE8Krr2loxm7SHJt+pmEztyRsEQ8IjkVyPAw81P5jZddbmBn2UxnvGpUuB98Lc9hfJD101Sqw==
X-Received: by 2002:a81:7255:0:b0:59b:fc99:8e5 with SMTP id
 n82-20020a817255000000b0059bfc9908e5mr22042395ywc.29.1697049457765; 
 Wed, 11 Oct 2023 11:37:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 p65-20020a0dff44000000b005a2245c3506sm5345920ywf.42.2023.10.11.11.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:37 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:35 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrii Chepurnyi <Andrii_Chepurnyi@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "leo.yan@linaro.org" <leo.yan@linaro.org>,
 "vicooodin@gmail.com" <vicooodin@gmail.com>,
 "andrii.chepurnyi82@gmail.com" <andrii.chepurnyi82@gmail.com>
Subject: Re: [PATCH v1 1/1] board: xen: introduce virtio-blk support
Message-ID: <20231011183735.GW3119521@bill-the-cat>
References: <20231003085805.2214260-1-andrii_chepurnyi@epam.com>
 <20231003085805.2214260-2-andrii_chepurnyi@epam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wTYBZbwVELBySsed"
Content-Disposition: inline
In-Reply-To: <20231003085805.2214260-2-andrii_chepurnyi@epam.com>
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


--wTYBZbwVELBySsed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 08:58:28AM +0000, Andrii Chepurnyi wrote:

> Added new xenguest_arm64_virtio_defconfig which
> enables support for virtio-blk using various types
> of transport like virtio-pci, vrtio-mmio. Currently
> supported: up to 2 PCI host bridges and 10 MMIO devices.
> Note: DT parsing code was partly taken from pci-uclass.c
> Limitation: All memory regions should be
> below 4GB address space.
>=20
> Signed-off-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>

Applied to u-boot/master, thanks!

--=20
Tom

--wTYBZbwVELBySsed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm628ACgkQFHw5/5Y0
tyyqsQwAkRdnAEUS2LIynJy5zLlFxCHAgPVRLy0dAkFlSRrMPjlbbGbXbDDiScHy
Sb8+k98XnCGb9oks0xCcQaYsi7PivQhOwvdUzgMIJlnLGdsnargakc8Xsju/skrw
/W/B8jH/lURUx15Z5XDO0wqjvxxsWGYanVYjtVUsBXlMrvBvJ5c8QgPAUSyTLlwx
rSoxi/YfnxBLbtiNTAxPBaTwAOj53wZ/EPIQPIcSl6ytyVjaJHo67Z3bdC7Ckyq1
VDFy7cd54NRnKKmvHoFUDHH0e8jNgrwlD5hASdnwSCgU4t8+6omQCycmlmLkMV2D
+YwlvHLlYfHfEkXb0hAVhXEE3DqAZY2T6bEmm9RDo+8fzFH0QndNN6GFw7TFki9C
KxKxPxnE5kB+xSwCeEk8TGGcTly0KWlQqgF+uxRG9AnjpRpMgEXJhNo9MQl0NbQF
yI3JB8bgda7Hjwzef/83zPuXv5XyXUBcGV6ZPyBgueZUdYl4FKv0rBedsZHkyk4i
HcftMAqe
=fbFj
-----END PGP SIGNATURE-----

--wTYBZbwVELBySsed--
