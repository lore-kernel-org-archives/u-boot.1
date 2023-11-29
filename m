Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBD6C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09A8C8761F;
	Wed, 29 Nov 2023 17:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rsNt6j8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA0D87629; Wed, 29 Nov 2023 17:57:41 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007068761F
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5cfa65de9ecso43506717b3.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701277057; x=1701881857; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=305BAMxWQ0Cl2hA4zacYa6KsZ9EUoMWwR2qKc0oQHFw=;
 b=rsNt6j8ZjPhZBLY9w5O5QtWqlzgfX5bwAfDAIRBhqPRqR91l5wFRrSfMkUTNR6Whra
 FflUoaYBJSKc+eiz1XXx+zKIUmSXIMfArdydct6c4XoK80euVMRuP2ARXZCLJDLYAVj9
 X/CAtjsXysX8ldEfTGTaIMZAqzbsVZqLDhrK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277057; x=1701881857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=305BAMxWQ0Cl2hA4zacYa6KsZ9EUoMWwR2qKc0oQHFw=;
 b=QrwWBruzj5MQfJj6Bza9Ct1N5P7ncCykOEzoun2mw4ykAQZBcMUPK9SkcAi7/FZz8f
 6tv7k8anCAHOdFwMtVWPzG6F/t0DZ73hexicR1S1+X99aq9nMAt46rFvUaXH8TsuOyOg
 K3Q1NIc5LGsUrz4Hacu9NutgF+enrlxLxOQnV/+QS71soDkTPJ6cXwZugYPj0MHlMz2R
 SKjYzwQdi7FXH/OocYiMq8rsgqVrt2WiqE3vIC4+gDcJg5NgdkFIy3tAfJ0R1Fg7wZ3d
 CIClUexlw0XaUY8Ua+llXw2S5DIdsRVZw35QBlFOVhftAXEpMJ29QVLlz+hrH28jhZLE
 H9Dg==
X-Gm-Message-State: AOJu0YwbE+i/N7xDLm0eg0vQzaRZ5QQjblBO1bT6hRjCMgld8f8oe0Uz
 9S2REUyK6C6uJkfaIyoTqfiHbo8K6A1dGjmFhgUmxg==
X-Google-Smtp-Source: AGHT+IG9V77pqdY2AKh/4ilr9BQbAoJAsFx5+eEG04jcUoUZ6YFGGn0vKpjpCoH18JMspNa2BeZeng==
X-Received: by 2002:a0d:d5d7:0:b0:5ca:4a9:adc0 with SMTP id
 x206-20020a0dd5d7000000b005ca04a9adc0mr17866658ywd.37.1701277057683; 
 Wed, 29 Nov 2023 08:57:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a818306000000b005c9cbfc868bsm4643725ywf.33.2023.11.29.08.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:57:37 -0800 (PST)
Date: Wed, 29 Nov 2023 11:57:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] configs: keystone2: Remove unused SPL_MALLOC_F_SIZE
 and KEYSTONE_SPL_STACK_SIZE
Message-ID: <20231129165735.GG2513409@bill-the-cat>
References: <20231117223829.346652-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tP7P46lhgRU+ZiBD"
Content-Disposition: inline
In-Reply-To: <20231117223829.346652-1-afd@ti.com>
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


--tP7P46lhgRU+ZiBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:38:27PM -0600, Andrew Davis wrote:

> These are leftover definitions. While here cleanup some leftover comments.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--tP7P46lhgRU+ZiBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnbX8ACgkQFHw5/5Y0
tyzkMAv+O5nuh3DuAPUJCUpA+6XsFm9Jl6SahAsV5W8dHbJuAwamaeZ1Yq9Zvhz9
Ioj/YsO33iaVwPbfgLYye9RYuI4+fEzljr2BWN4jUI6bcL7bLc/h5h8I+D0Muldf
U2t5XKVKOIm9KTjmLRqWEf6rEf9z+Lv8m+JoeMkqNfRrJPSQgb7GgdYQN/kLpT6H
Dm7nmHButmlJE5/geBR/dUgzbKxfqHZvGihY2Wljovdgmnu0NaRUN5M9uuL8M3ZY
l2k+sVnMu2rP4VbKtNMFKcs/TjVnwyU0biYB8SwNa1hV3WQm76RrFDQyMC9llnd2
4pJXrU6SNKl83WgyRLA+ddg0jrA8gzL6q0MwdEH5sv827QX5dGoXS4vhWvZ/Gyej
1jFXFHe8ba9nq37tKqJkgvmmaUuxdQTkKJMSVzumKFaigdng6TFaoroKqC/f7CYJ
CgrbfQ7XxQ0sZg+9rLfVO2fn4gOmy9Oe6v1ELgFjHslX3T558mMoaWb7eAXZZsEu
lIo58KH3
=TmeM
-----END PGP SIGNATURE-----

--tP7P46lhgRU+ZiBD--
