Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329B8C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 16:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705BC86E47;
	Fri, 17 Nov 2023 17:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CtHw/FSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252B384003; Fri, 17 Nov 2023 17:46:24 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E47886E47
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 17:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66fa16092c0so11705276d6.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700239580; x=1700844380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ck3p8obm0vHWGh7RiPgTbKodBqfuWUi4uXO7LjQAEQ=;
 b=CtHw/FSo+t+6ab+new/lKRLVHzEHrsa8qFk6KiQ9y8dQav7fKuLlGBIb9cN/Pkw7lN
 f/JgEvBgYB9w8zGxeR9/dYgZL77HJpyzbBl4La89e7919aZhqUqG7TkW/CTg+WnpiNoz
 GYkG3D15te7id1UWfgBxjwLQKWyqsXzo04Yyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700239580; x=1700844380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ck3p8obm0vHWGh7RiPgTbKodBqfuWUi4uXO7LjQAEQ=;
 b=NW2/gi4o7VcnmY38kV9vVneoBUFnIWuYn02BMK1GqHXTUeeJz1wdEa/eyZeUihkiS9
 Edqwh4FwYHw+htJQESHP9ThQPH3YK6CT4l3GMlwQYJyLLWWBhiNQBBJNRmE2h9lUR3cR
 LwTUSGg3KeOquUR6wQ0kM2LMIEQD4FJtKU4lbtiYdNlWxsWzX3VfFesMuG5Ygq62cjQl
 4H/VQ8jjjuPuHn4ErmtIjwOatBsqQh+9OUpuDQto1AVGtkQhp9ZQcVEqn9YssBdikCZk
 DQ2cZdGokZ0b8Ama+cAh7m3oy4RAN+ip46ceQjixhmIpS+LAOU04vv5p9bYgulhbyd1+
 2m7Q==
X-Gm-Message-State: AOJu0YwhSCGfcteEUy51kNC4n1w2RaAwO5YKmhIl8uumh/T8AB9jFwvx
 npF8TJftDUdY3bU6yshs3hDZXQ==
X-Google-Smtp-Source: AGHT+IF2+gVJDUfaeQ+SPe5sBejZkWM+RPvmokzt1zPcfy228OhcS4XhD7N+R4l2q/xkgTzpGX3uCQ==
X-Received: by 2002:a05:6214:1247:b0:671:3f49:c8b4 with SMTP id
 r7-20020a056214124700b006713f49c8b4mr16632904qvv.3.1700239580464; 
 Fri, 17 Nov 2023 08:46:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 kg4-20020a05622a760400b0040331a24f16sm697891qtb.3.2023.11.17.08.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 08:46:19 -0800 (PST)
Date: Fri, 17 Nov 2023 11:46:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Message-ID: <20231117164618.GN170968@bill-the-cat>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
 <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
 <899b50aa96b802275035f9ee40f46b461f8bfb46.camel@toradex.com>
 <86ddb623945da5a507fb4632375f7cb70361ac58.camel@toradex.com>
 <20231116184226.GF170968@bill-the-cat>
 <91c3d742-a87a-458a-ab6f-6a56706bb78c@denx.de>
 <20231117142540.GE170968@bill-the-cat>
 <CAOMZO5Dtc1wdmEpsqZ2Zo=YHQwyYb+oRdYZmhz1r3YQyXRx4sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6kr4ZIATQdPxRR0A"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dtc1wdmEpsqZ2Zo=YHQwyYb+oRdYZmhz1r3YQyXRx4sA@mail.gmail.com>
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


--6kr4ZIATQdPxRR0A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 01:13:07PM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Fri, Nov 17, 2023 at 11:25=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > OK. Fabio, please send me your patchwork username off-list and I'll get
> > you added and you can start managing patches there. I've started using
> > some of the b4 + patchwork integration just recently and it's very nice.
>=20
> In the meantime, could you pleas directly apply this series from Marcel?

I've put it in my list for before the next -rc.

--=20
Tom

--6kr4ZIATQdPxRR0A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXmNcACgkQFHw5/5Y0
tyxwsQv+Owo5gZTLfUHUirCHqjPp+LbN9LsPlkl88eXzrKZf5Y5oAIRTs6m8HaVm
aaFHyeYN0HvbaVmK8USK58Vt9TutoGvjVdR48Zzo1M6iK3gvAceNPAjCRM95pIGB
ylYHwJgoFbBYqZcuG2XYv6SvAOrVW5dj43vWXuax1lFdoxW/Tv0rdYxFQbdUL7mx
A1ioBb1F1ToGCUsa3dYQoD+7F9VZYcMrhxDgBWYcLFPlgS1wByRIgyZNJRZX105r
BtyMlSaJ2vZFElLdt0IRYaTf+GcYWB+4IB9T9eJoJEdyRPcpNtYQJIlBex2/nhbW
8eNc4PfpYGBrh1JbJBOCz8BsFES3oi2cqRcFweqlnZVjttKy1WLERPtD27XpMUhc
5uOo5jwV80cLREVe8m6hDOA++P7Auvl42otVf1a+dRwVq5/e28yi9aCQuBrggq9i
hZx0Yg+JkusU3mp1FYCcWf2oDmYSidZdUgAqItfOFdZAzoiNrFhl8SXFH3em1kiz
Tt+Zue6z
=GvS/
-----END PGP SIGNATURE-----

--6kr4ZIATQdPxRR0A--
