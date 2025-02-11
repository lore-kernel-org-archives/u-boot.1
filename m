Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209CBC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 19:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB91809D0;
	Tue, 11 Feb 2025 20:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OGURgQVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629E580A55; Tue, 11 Feb 2025 20:48:43 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DF380842
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 20:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21fa56e1583so39512815ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739303319; x=1739908119; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=De3P+IYhW/35eFlcxwx9oobJgvst/6aROwxVAWSxhxg=;
 b=OGURgQVG6/UFAfFw5x2MdRH4B7FAI3cqfeGRn32JcgIDEtqyaE/lfUDaWEWYmNuAu7
 l40N1ZUygkzdAxrIQwTbgd+rz8B49RI17arteKrVh9Ng+3QCJ+XDgPryECnpRY0dWPyt
 CPRSpo13JUAMoo3rVGrjQJjb8eSsesaYkTsfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739303319; x=1739908119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=De3P+IYhW/35eFlcxwx9oobJgvst/6aROwxVAWSxhxg=;
 b=xL7ZMNBw4jbTROkE6p9DUWd+WkRpjidBykvEHl8X0Nlxw69bpMgYtyNK6OLIZ6R9u4
 n4UNleXrBCDWqWAwOLwvjZ34mGSmsS6z8pt0tcpasCYGjFT9ZWLikuZnONrxcZE9l+Pi
 0+YBDAbiQLP1EBqmNBfFihzlboH8KBXfuWIkYvGYIp3jaQ3+c03fvYdccwhoFBmad+ww
 ErxCJhLiyrafvVxXIo48idvheItwQrwGp7wDc0vRIJEhLOKp6b1eTMJSibmn4U0NlGp9
 z+qogxduln6iORBFv59yYUkcXwxlLKLagdbCwMANki+lq9fhpUiiLLf8+6ZUYZhWP4sK
 S2Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYR/WPL8vgCSv0sRSyGQavUJow7QimHrPiFZ1NhKn6XqFR3+vR6N3Z9cjnTIv3Ymo3F3n4yck=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0L/sRBs6E4ndsR+jF5DotQzZhoTOhtBW97jWJuG+m31zsykAq
 Py4LsdeSri/kmyCQ8ffQxHN4rZqxZvSExf5OIbei9T+XhEOFYx2SqWt7enfJR78=
X-Gm-Gg: ASbGnctTGpLGvESh3krDwiK+J9DdnESQYE+aKnQGiPJPpLMW5N5tAw4qv2DrqLJ9L4q
 2PINWoLIJKlfJBw+eHf9HmzLS/uH2nGiq7ClJ4shvtR5dmoQ6J7GbHnW0iZ//MVauezUCr5el3l
 gDHrVHh6byAjYJifF5+x+QnInTJkEKkDzlDUM00KbXhLMdgRQ40iOAzWbrgIXP1OVZsPFyaHQtX
 eiKv/SiH9kX33LGTNTXhRkxQym5ZmQVf+hGZnX8ggrinLZC5N7d9Kmpwet5fcAjQJTXIb2uN7v+
 c61gHe8je4aTZZM=
X-Google-Smtp-Source: AGHT+IHXCTJ31q3GUEDFof7GVw7LzZlYkB54MO5Inz//p7bmOyn3xQO0UVEZlu8ut2Xv4viaBE6i/g==
X-Received: by 2002:a17:903:32cc:b0:215:854c:a71a with SMTP id
 d9443c01a7336-220bbc6844emr8418005ad.34.1739303319033; 
 Tue, 11 Feb 2025 11:48:39 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687edbesm100507145ad.177.2025.02.11.11.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 11:48:38 -0800 (PST)
Date: Tue, 11 Feb 2025 13:48:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: mkorpershoek@baylibre.com, ddrokosov@salutedevices.com,
 u-boot@lists.denx.de, u-kumar1@ti.com, a-chavda@ti.com
Subject: Re: [uU PATCH 0/3] FIT Image Boot Fixes for am57xx_hs_evm
Message-ID: <20250211194835.GD1233568@bill-the-cat>
References: <20250211082838.18766-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZzIokUJ2D0LFwqcg"
Content-Disposition: inline
In-Reply-To: <20250211082838.18766-1-a-dutta@ti.com>
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


--ZzIokUJ2D0LFwqcg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 01:58:35PM +0530, Anurag Dutta wrote:

> The u-boot is unable to load the FIT image due to incorrect
> boot arguments in case of am57_hs evm as can be seen in [1].
> This series introduces multiple changes pertaining to several
> environment variables and overlays that are responsible for
> successful [2] loading of kernel image.
>=20
> Test links:
> [1] https://gist.github.com/anuragdutta731/7bbf0df73dd1e3327765f1807d3374=
45
> [2] https://gist.github.com/anuragdutta731/5244174c9b9556fd89132c8d72ae2d=
8b
>=20
> Sinthu Raja (3):
>   include: configs: Override get_fit_config to get FIT config for AM57x
>   configs: omap5: Enable custom mmc boot to distroboot for AM57x
>   include: configs: omap5: Add support for FDT overlay
>=20
>  include/configs/ti_omap5_common.h | 27 +++++++++++++++++++++++++++
>  include/env/ti/mmc.h              |  1 +
>  2 files changed, 28 insertions(+)

I'm not sure this is taking things in the right direction. First, you
need to finish the plain text env conversions. The "get_fit_config"
function exists in both include/configs/ti_armv7_common.h and
include/env/ti/ti_common.env. But second, I don't see how this isn't
"FIT image was generated without expected naming logic, correct that
logic".

--=20
Tom

--ZzIokUJ2D0LFwqcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerqZAACgkQFHw5/5Y0
tyxvaQv9EBdLdiFiq8MLvL0gRv091x/ZdnBrMjwelF47JuKVTH6n1RYFRocOWhJI
U0oNbHQJHbiKNn6lPIYVLaQjwtbYlPeWK8ehJyqqmnL2dy7OtXwI38nbfASLckZV
6lTQ0WMQA7ZHwJL3MoSprQh11tiDnKBoQBe+7t9Cl0t1USmKrbwcGdYXlj5hFW/m
jM1ZQgNguJnT/UqF9nOUCPj3jdaXugHPTBpxZwQW+a0XAWsA0MXpp27ZXFYywQwv
RSctSJSOUXkFX3jed+z+Zv2W6i4qJZ/o8kFpBEn1h3kxyQoixKiap9+nR8V3l7WJ
bzwHwZMGZpfGG2gZI8aKjTynEKvV8V8/ZmPE3Zaq3KNxMZqg4byQbPt9QKssOguw
BcJ2oQT6/YFmxv2yb4kT7pMPQjAZ80nf8s015hdK5HoHcRBNWa9gD9bGZh8lZ6h+
lf7QAc5pHoy/y5JpevZAwpMti2Enb88uvYNbBh+GRbi7ld0vOAL3uo1xP2EiwFGz
cicx8gFr
=JyC9
-----END PGP SIGNATURE-----

--ZzIokUJ2D0LFwqcg--
