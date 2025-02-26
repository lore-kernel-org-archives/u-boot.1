Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFF3C18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D95D80805;
	Wed, 26 Feb 2025 15:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nQFTykQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 440A280F92; Wed, 26 Feb 2025 15:21:42 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18EAD807EE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6e41e17645dso70137886d6.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740579699; x=1741184499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=618COR7qOgUOOwr0BZ4CIonDLIWQtq1oxJubyf6M5ho=;
 b=nQFTykQ4N8JGylgQbpx5w2szJxJQrS6paijpd90qbYcvofP9W14wN1SPN14SfR6Mi7
 zz/Z+0gVsv5zbwHWL36v7wt4uYXnZS1/ilRMuwTB/nfM5938vBYzenqcRwv8WTYUfxsq
 00lW551uvD//LuS44VUX+LIRiNLvv75q+Cxyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579699; x=1741184499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=618COR7qOgUOOwr0BZ4CIonDLIWQtq1oxJubyf6M5ho=;
 b=c6z0s4d1nS2oYRuMYoea2PYRRVfWZ+0qzbgz/SQkYUEV04Bfixg8sZdXgejbinW4kC
 SW1uCBDijerkVOJ/3B3MheWkh+GG9GmCbwDun9uiFIIlrI5H2J6QfZ/B7lxPLcOBATJf
 9U7strQhOkN8jxrDRrOw1rthIRmlHeLDWxDKXxmfvlTeOrYNQwyO2igBNF+n1aRImmw4
 XJJXyq0/9XzIGvh9jSmUVdgwFPhjXpHhu/C63Kr0DsKIhRNK3kP7vd4bNJXlSmJb3Ipg
 cYccaG/T0uP+DZkYzfm7ATRnvxpwjiYhb3fzUB/WYYVMrmzHOFoxD56HulYPt4Z6plc1
 xPcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+lFmz3ah9C90+VdbveEBOFwhY327VCxCx18Fo9gNSnuCJfO0d2dfhqHgO3VZRPVZYNtu0yyQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzmuB+53rkLdRu86N+07rNC81hNuNe6yvGW7C5gFWUiLOKk1a9Y
 mGS5OYcHuoMfULQSlDl3jhBvGEMyMCvXLitlligeNs7SPL+gsP0WdBf5jp9L8z0=
X-Gm-Gg: ASbGnct324jKyYNTi8Nw4zF0xmgqKaqGdWXCTMVbolsCxzhZf2tyRTWWQLS38jgGL+a
 nHrRKzaylYG1XWkdqWpowiwmaOB7sngtZwudUW+TlHWF518G32zjelkVY18tw9pPf/1gJ3zW8vH
 IqDHrz8xSyn+269dGSIhqKafkv3vlahBQKcHEbYCEJrgSycUe4xS8PREKgpOxbFSHOHTdSy1hjL
 5AW73YRu77WrAcWrfjIi0NRFz1tX+sE0efedWDkGeUEldfHPCuTNanMgzgM9LjFcqhDo27BWJJh
 RO7QdosqOTzJtXZNzbnivp1T
X-Google-Smtp-Source: AGHT+IHCBRv0EvZr5re2Q5kvOGRqHm6Gvo0MKWdQe2SXrseDA/Nsx72CdTnbIG7sZ0tZbZqaadptbw==
X-Received: by 2002:ad4:5ce8:0:b0:6d8:9bbe:392d with SMTP id
 6a1803df08f44-6e88687977amr41714826d6.6.1740579698844; 
 Wed, 26 Feb 2025 06:21:38 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e87af7a83asm22633396d6.0.2025.02.26.06.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:21:38 -0800 (PST)
Date: Wed, 26 Feb 2025 08:21:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 0/2] rng: msm: support newer SoCs
Message-ID: <20250226142134.GG2640854@bill-the-cat>
References: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
 <9094cfe6-34ae-42cb-84c1-6965121d1a19@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8uQVksg3YqfD44G+"
Content-Disposition: inline
In-Reply-To: <9094cfe6-34ae-42cb-84c1-6965121d1a19@linaro.org>
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


--8uQVksg3YqfD44G+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 02:07:28PM +0100, Neil Armstrong wrote:
> Hi,
>=20
> On 25/11/2024 18:12, Neil Armstrong wrote:
> > Add support for RNG on newer SoCs which shares the
> > RNG hardware between different Execution Environments (EE).
> >=20
> > Also enable it by default to fill KASL seed when running Linux.
> >=20
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> > Neil Armstrong (2):
> >        rng: msm: add support for newer Qualcomm hwrandom IPs
> >        configs: qcom_defconfig: enable RNG driver and command
> >=20
> >   configs/qcom_defconfig |  3 +++
> >   drivers/rng/msm_rng.c  | 13 ++++++++++++-
> >   2 files changed, 15 insertions(+), 1 deletion(-)
> > ---
> > base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
> > change-id: 20241125-topic-sm8x50-rng-714cd0012391
> >=20
> > Best regards,
>=20
> Gentle ping, who's supposed to take this ?

It's amlogic, you can pick it up.

--=20
Tom

--8uQVksg3YqfD44G+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/I2sACgkQFHw5/5Y0
tyxd0QwAue9CRDMCBRWGreItgNNJ3KvooFKNdKXfuIv6eRL+T8W6m0oHZywp/l1G
nk5EnbxABl5bRzws3yojD33V/Sgww/DJhwMHrLunat+CYjehPdKI9TYFfXxx25qL
Uf6FhI4bmgjxqJObmckAt48v1hEGtiTw0J8q9nNLXquzEqDqQMKVIQwkz+Nm/cQK
qoiOewXzjrCtb5LplQJlw8sLs0TIcGojz3SXA109Cla2WTBTNaeRooNc4znQPDbq
Yl4de2SshyFlt1Dqdj+H+ljW2KcGDxOZQdJB6ZPqsjODiiOKUp/uFPxA9BEOGBtS
E73gpp3U6Bf5oUMxt+yNxV6PztH3YQJTI+xgcZm6b1zAwH2Zr0jv0gCSO3OkHHDv
na9qSki3g37pH9w02oAhbOBxNIPsXVkHaSSn5Td3Xfq40OXs6sWPCEfaDmOagJsv
SqVBRdNI45NiEI0FaAyH1v78wedfMThSkuejiLJzCmEK6u/ELUJ4NUmrz6mD2lCE
6Xz4x2Rf
=U+pp
-----END PGP SIGNATURE-----

--8uQVksg3YqfD44G+--
