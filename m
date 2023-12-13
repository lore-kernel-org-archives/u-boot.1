Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B29CC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E756F8782C;
	Thu, 14 Dec 2023 00:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="edyy9GHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B9D878F6; Thu, 14 Dec 2023 00:08:02 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4281887824
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5e2e873ed29so10959217b3.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508879; x=1703113679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qmldZgHp0pYsa1O1kCwpjTzIR3QCkXTcXhIFHpdT674=;
 b=edyy9GHs0FQUIZFjEAaxAzVMY+PdyNxpjomPsL2KyI68MM2QUHQCSWerYJvezay/f/
 2rN00gpyYTEhvQgJ4tcHco58Fq2uXY6+XhzYE+eeocpx8WiaIUENHywlM5+2GjMEAfP0
 a+7MPKR4WYFX9Od68N8Jg2joKrtNbmXo0h3CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508879; x=1703113679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmldZgHp0pYsa1O1kCwpjTzIR3QCkXTcXhIFHpdT674=;
 b=kB8T9aSu+132xMIhWXr9qxWUGeaZfg1xEBxkmhbDZGI7GlH3Ggyjt0th3G6qXeQFsl
 1i6XPeeN2Fk+quoe5xAH4x4puJ1k8njxia1Di8svF78oCcpcN36jF/xRYiHh/wUPk2yZ
 5GZg8Q4k6oL0J7gjA0h+x4DWdQkcWAdsV3dF7Gy+uUXhKNuw9QdyTbcqX9f+aHMGTi17
 8MzCEvb/jj8NyvPa5NKTMbNg1Rvol08jRrKN0LZoHHfz/6DHvkfFguqjXyU6Rgwnmt8+
 G9kJPgvFOTQa2FxXKS27TOHf/RogL6CwFyz6ynctI2mX3+i4QT1b/Pmm3vE3OJWvfutW
 Jdkw==
X-Gm-Message-State: AOJu0Yydgt5M8YGdma6t5tMu8O+zPlfinNZvKlNdStwvQb2zmKAoozdw
 7n4qWe8+7JNNuK0fgBYqh1M2pg==
X-Google-Smtp-Source: AGHT+IFv0R78vSJlxDlK4FhmGKx2zUnoR6A8yIaBKUoloNE1x5rr1ijCRIgMcmK2u4PokPRAmCuttA==
X-Received: by 2002:a0d:dd4c:0:b0:5e2:e154:8635 with SMTP id
 g73-20020a0ddd4c000000b005e2e1548635mr1278680ywe.71.1702508878862; 
 Wed, 13 Dec 2023 15:07:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 a200-20020a0dd8d1000000b005d70c0a85casm1476257ywe.53.2023.12.13.15.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:07:58 -0800 (PST)
Date: Wed, 13 Dec 2023 18:07:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Apurva Nandan <a-nandan@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 08/17] board: ti: j784s4: Add board support for J784S4
 EVM
Message-ID: <20231213230756.GU2513409@bill-the-cat>
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <20231206123753.1486031-9-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jIh4wbvvjS4dXVXu"
Content-Disposition: inline
In-Reply-To: <20231206123753.1486031-9-a-nandan@ti.com>
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


--jIh4wbvvjS4dXVXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 06:07:44PM +0530, Apurva Nandan wrote:

> Add board files for J784S4 EVM.
>=20
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [ add env and board specific yaml files for binman ]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> [ cleaned up the env files ]
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--jIh4wbvvjS4dXVXu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6OUsACgkQFHw5/5Y0
tyzayQwAqpPWGWXQJW92imsj4lQxK/LEH7KYXmSb5zvKplphbyAShT+7DTO4NyZl
Qy9zENEcSGhr1NSqpGtse7ee5HUs4VbK8vLY5JTjGKSZqGZGr9vLgSBzQkqVbFtN
5g4jE1KppNm+qAfhFdyQxiwityF/tGjahdmo/nvBLcQfAo4ufDNZnawRU7qD9GMw
bZRQx7WcMCPTe7j27B55zzQS61ZEPdV9LswbpyVqoIWsEK3mRMg+RxrOy7ihyNZY
ZkMvkFyDa2bgnXBGu5IDmME/q3GoKNZxGpoR5bZ4rwfyeyp1i+i46jAtlgdeXelx
Bw/1dzF48ywd3mUw6Q+qlo9dYGn2H7NZJi0U4S2T2C6mCllOLwwryGBT6f3iJQmE
JS81D3Aq16Vt3rOkejnhM46ssU5KeoMDbt77qJwdIMnm9iuInJtpzyUkKjXQza+2
zo4ZDJnRDjYV75M7lDzo1xE28/HTYLen8Y8VjFyhnfjrA8o9D8Tzx9mgibGPhdfn
JIMN71Hq
=vUfk
-----END PGP SIGNATURE-----

--jIh4wbvvjS4dXVXu--
