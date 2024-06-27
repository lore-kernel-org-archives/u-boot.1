Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D3BC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 14:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B211D8852A;
	Thu, 27 Jun 2024 16:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qcbKRJnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CC187AEC; Thu, 27 Jun 2024 16:42:04 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7A58852A
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 16:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-701f397e8ffso242988a34.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719499321; x=1720104121; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8VuU6QGPJcyFO5NJZXYFEqvXPhrCM94mUOVysHFai14=;
 b=qcbKRJnlV4i6rjzX45dE+CqRiS/YBonX3NpQq2jwF50yHgdQLXzuEs54+TxKNeLCjC
 174/4uOf4IGG739lvbAuoLKCEL8zugc/SYspiMY8o1Xk3c0KAnoaEj8236wu5ELVybP8
 Ug93T6OB/KGSyfUJcR7gBI3gOtrHKAVerScOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719499321; x=1720104121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VuU6QGPJcyFO5NJZXYFEqvXPhrCM94mUOVysHFai14=;
 b=sLqDMirFhGIZ6kzmWU4vyzqGbDCSFo6amPUdRHB7ipTvTlyi4huDf9lMYFWzRDt2nJ
 bGZt5FE3w2pqKm/vdd5R565u+49cr6M2dAXbajncpVjRiSP0vnW4eeeO5KbpekqQLoOX
 aztqcwFPTWuoJOfiLHJGwWgtf+p7uKEo7IIbfjJ8kqZrzgHYFJ1IkEmGGPC75WKtMIsc
 EpSdJ1bnsy4fiAIEVZvBEa9SLZ7jQWdgWON4/VuwxutuJR1yAP8F+UF1RcY02fLbOG1X
 Ffjehn+JZOlkDTUJKoELt7UubwaA+ZiC8zM1bc23O9DRp2AbqUymiOtx0civFHOf1NwZ
 n9eQ==
X-Gm-Message-State: AOJu0YzZ752q4uya//swiU76+XJDbeZegxwQU7LV6b+rrETGpIXMgWWI
 4mDZLQ30LUGIhYYOH4m2f67NW7uD0skVGpUmViFV7rLYiWBw/z0GYLlzEwjmvdg=
X-Google-Smtp-Source: AGHT+IFWbMRxzkVJkdFDPqdI6a7SqR1ntdQnJB85rzyJV4wJjDoMqhU7lXq7uv7LWES1/aH5/6V3kQ==
X-Received: by 2002:a05:6870:a98a:b0:250:7dba:9501 with SMTP id
 586e51a60fabf-25cfcf2f0c6mr15005109fac.41.1719499321005; 
 Thu, 27 Jun 2024 07:42:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d72d552c7sm372468fac.41.2024.06.27.07.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:42:00 -0700 (PDT)
Date: Thu, 27 Jun 2024 08:41:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: u-boot@lists.denx.de, sr@denx.de, rasmus.villemoes@prevas.dk
Subject: Re: [PATCH] arm: davinci: remove unused defines
Message-ID: <20240627144158.GA38804@bill-the-cat>
References: <20240619105958.43083-1-emil.kronborg@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w5HJtZS/ehpRWjil"
Content-Disposition: inline
In-Reply-To: <20240619105958.43083-1-emil.kronborg@protonmail.com>
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


--w5HJtZS/ehpRWjil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:00:01AM +0000, Emil Kronborg wrote:

> The last usage of the DV_TIMER_ and DV_WDT_ definitions were removed in
> commits 8d7757637138 ("ARM: davinci: remove support for cam_enc_4xx")
> and cef443c1666c ("arm: davinci: remove leftover code for dm* SoCs"),
> respectively.
>=20
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--w5HJtZS/ehpRWjil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ9ejMACgkQFHw5/5Y0
tyxDDQv/evxvwFRS9pna+hrUbbrgb2RNSHsK0OyT1Jetkwlobm7jEBltZKp7FHKV
8bWug8VTngHutUl/MNH1kE1LWLQLjCZkqHrpVxwRzbmGJExwP8PeAcB0kFiiPzjm
+hHkkLJLtjbNi5TgH/c27Dv20kzEdwfKxeIAEKF9HEhNBVXX9dLBaH5Ylc83v29+
CIciXxN84ihGB/LDnb0gHSB60oh2W+WBiu1zD423nT7tGYmUzmFRFnG8gR4RqjlC
boBFwCN+hZVBUyNl7i7CTRyK2DbwnxShiGknE4bQeK3a//IrEfTzM3jQc2meE1dg
qWphyUgVdpCsbNnTcqelZIu8d95M+QRYUswKtsZYxWa8AQPpnIhAKlDfy0gZb4j8
l1zF54Tax/G8aqVkwmX+r070D8YrjUx/vwoa+xqpDxE/vaTH00BQFd7AsXBRiMmd
70IxrNchLFT21U3KPmYynQE+J0MeEHbDDVYAgIl5bV/diASBg0VmarDyxMjHe5dl
K8uOKUlX
=ZAiK
-----END PGP SIGNATURE-----

--w5HJtZS/ehpRWjil--
