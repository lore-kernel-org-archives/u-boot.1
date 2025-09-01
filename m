Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EA4CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 15:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E652B83990;
	Mon,  1 Sep 2025 17:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pdhMXP/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA60839F3; Mon,  1 Sep 2025 17:48:19 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343AE83965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 17:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-61e110cbcd0so838384eaf.3
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756741696; x=1757346496; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j7/Rs1KmeH+/Et+YMITHYJj5hbIJxj8+GS6V3iJAf9k=;
 b=pdhMXP/ftUnT5/MOUllWwcf68Vs0ehpAgSIRAFHNRPJjq6mEOa1kXbZvWEFuJLf7oK
 Cx/L3yX5q75LBMFTG42VjRjM4kmRXOBQNkEmhL0UMYP2gDnKdhNEs/EdM9feGJaUgYym
 j4Yve7vUjkiv8SGT5DClXkSKAtJI6CxeVxQ78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756741696; x=1757346496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7/Rs1KmeH+/Et+YMITHYJj5hbIJxj8+GS6V3iJAf9k=;
 b=AOjkaab8KxT+fPLgUzKJYDJUiL8JSkahk3khwzfdkj4WCXAEM02PsLx9NG0n+N7QnE
 7+Zljip9S4kYnXNi7EkSWmwJ9RugEp5hf3l+RS1qmn7dVgn6fMRcN+5G9cr1IWOpcgEn
 1XOEajH08685M86mxRjWjgG+xSg23krt/vyi2Wxu/dP6Ag5pdGmNnEZCMUUBTPDw/j4Q
 D8a8lKlCUKBMN9MUeSS1B61qzM5HsBvCrgKcnTuDcK2oG+PL1EjV2sXEuQ14MoYZFjkh
 ylvtZtnx1Kf586z7izd9BSKufeDH+bMSl112Idq+3/YQlaMdyROu5CoLn2/DNRzojmNS
 sPSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmhCIsZUPTAgiEXE0VYa7qCsSNqhcufFUz33TLcQk3kIVLBroO49H794o7ZisvflAsAGik4wY=@lists.denx.de
X-Gm-Message-State: AOJu0YzJjrusPyMWfI04K3uOYpkUMXBXJfmGK1TmyDluPClB6QbFqTq0
 Dy3Cw8afHfqIPMvxXUWLVbb/+33E4zOMT2YoE76ONXL/sDJOUoJH0g9myb9871ZP5ZM=
X-Gm-Gg: ASbGncupu0ufdO7KzOq+5om+i7VXtgP9wIapvWxLaaq/GD3+noZl74xMvgE9KiNmdVF
 Fu77oCFxSEa3r6sI9VkqjCPjI+sN5ZhcxzZm/pZJRvPojsfHZFcF08Hzf37k0X6f1OJ7MdrspMD
 9072W+EDfE7E8CglNPolisxTQM6Ou3KIAOiL528biy2bPgu0zZHGZ7FHaBbez/0GETu3nz0A2pg
 WhTVtMzYA3MMyblIuFtK0mdu3hsnlUH/ht0ZXzlcL3cc1GiQo+6bb8GfOMwBRAt8zGq/3aJ+/oS
 017mR2XwpKVgQAwHUYweEEi+MkiKwVgbs4AqmZVofcXzixz34wTbWowuXVUL+NNeXjgw5sFXGm2
 qXda9+x6v6xRXLqQ3TqL8enrUkXgA6qTSYAlV1Y5BlGSXX/TBRAND7objvzDa5yACYpA=
X-Google-Smtp-Source: AGHT+IGlLRBmvgv0OuZKBjikCNQIBdjhwzTiFHN0k8p/iU2p9e+P+ZaVBD5vkCdurDLoFkYay8shPw==
X-Received: by 2002:a05:6808:1923:b0:435:7863:9a85 with SMTP id
 5614622812f47-437f7d74d66mr4584041b6e.26.1756741695703; 
 Mon, 01 Sep 2025 08:48:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43800023229sm932116b6e.21.2025.09.01.08.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 08:48:14 -0700 (PDT)
Date: Mon, 1 Sep 2025 09:48:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/4] AM57 boot fixes
Message-ID: <20250901154812.GB124814@bill-the-cat>
References: <20250901061659.986164-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="20T64v2Qe014HPU/"
Content-Disposition: inline
In-Reply-To: <20250901061659.986164-1-a-dutta@ti.com>
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


--20T64v2Qe014HPU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 11:46:55AM +0530, Anurag Dutta wrote:

> Hi all
> This patch series migrates from .h to .env format for am57xx/dra7xx.
> Also, we do relevant changes so that the fdtfile can be set from C code.
>=20
> logs : https://gist.github.com/anuragdutta731/82560cc9bc958ca70a25a95a703=
1eeea
>=20
> Changelog: v1:
> 1. Converted to plain text environment for am57 and dra7
> 2. Added dra7 support as well
>=20
> Link to v1:
> https://lore.kernel.org/all/20250425053431.1622267-1-a-dutta@ti.com/

Is this a fixes that needs to come in for v2025.10 or a cleanup for
v2026.01? Thanks.

--=20
Tom

--20T64v2Qe014HPU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLXAOQAKCRAr4qD1Cr/k
CikyAP4jOarUFYLEDxk65H4aKH1HoQixLNk5GYwGfHlZDkuzDgD/WksXiRwQxRBW
yNrIAINu0Qo6/OCIi8aHUElRqeNBtAE=
=tOX1
-----END PGP SIGNATURE-----

--20T64v2Qe014HPU/--
