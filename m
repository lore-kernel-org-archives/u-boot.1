Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA472C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 15:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42FE78277D;
	Fri,  4 Jul 2025 17:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dKqMmC7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8E082CFA; Fri,  4 Jul 2025 17:56:18 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BC9803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 17:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2eff5d1c7efso869316fac.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751644575; x=1752249375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FQlNfVFJqj7Adaco4+GK4doHQNyFD7Co2rf2Lm0Ry6w=;
 b=dKqMmC7pOE9DGwBBw7cPOkisr8nk7NvJvLmnfZ75DaO9IytJY+Luofgx19JKCT4LU6
 i9iJvwRizfDGMWPJwYEJ8RytS+/7+DaO87TaHDyUClYQ/MFQzOX4XhIpggD6jMQLjpZo
 VzvcMHQMQ2H+31rCj1DXbxSol//En/P1DKHqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751644575; x=1752249375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQlNfVFJqj7Adaco4+GK4doHQNyFD7Co2rf2Lm0Ry6w=;
 b=KaiX/QixEeeZ3k2JI3M6X07GpuIsxPUg6CxVos4YbQ9nRlpAOBLhNJyZUiUGTFyvEY
 iOMf/RWQQd7r/UE3BlqlR6kgOE/OEx7dpgWmuVhVsgQwR4zlSie05XGHZpxM4p12JTKm
 ry9TXRLHlkC2dfaWEGJS14sjdSND8ZF8QKT3MQiviNQazTQ1skacf0MT4X9WnDosb9Qy
 jReG/9KpBOly5+OA+ODRgAkklyWfzXZH+EDzXoRG5fIEX9EuI/9HXWNc+U4uTDO4p3ps
 pMyKssKpIabzqeslbH1eGLHJOjduuGYM9fAC0WO/5PC15wh15SVWpt43KgwWZb9fUwnQ
 qzQA==
X-Gm-Message-State: AOJu0Yw1BrTxPW+moFI4BEChqFzIqS04R7ip/VqCcRwueMxdR0yrotpu
 1OxAOleDs7xoBl0YxNIRw3r+wYUzZC6iqnAnY1lER5hrOekFLKv45hvTkhCOkMG7ZH+e6HWIgTb
 mhLykzPM=
X-Gm-Gg: ASbGnctw+EewQN5CdYoBUh47/FfJRiwlV4I2wI01/i+t22bQiaEOOgbWOJ72SXNhoOe
 PI+i2GGGPhfd35YyAgNWRcu3R0m5Kses2Gbte0TpHXmn2pnpoYW9B7Z2f30HdZchXVo2e2AoPnH
 OsGlI5KgcbT6QKzBlaDnGw7iitPPH2rO/JGck2XQvUr8m7uEnDhaSue+qmF3M3wmF2hMkP8zcMA
 CQzYJV4KZ5Sgw9dkeeuvf0XaHo6++z1Xd3R8lqf09SA+o+/WBzWWbCkYESoPKI0tVwsfXGdcA+g
 ozfeDOuwxkIndJST63Gtf4IKWBn+Gu3L/I0UYBaBETdxQFuAeERnDSlNdAarVimGU+oKhhyiaNo
 PFGCjn6oWvyVaZh4GrxrH
X-Google-Smtp-Source: AGHT+IEN9+zl1Du+YVBGdO0fIM3EUMQ4SGV5CKAVzVkxwFrpwGpGK/r/67bnefNEIfIpNoBxNFJvzA==
X-Received: by 2002:a05:6870:a413:b0:2f7:64ff:aae2 with SMTP id
 586e51a60fabf-2f796d61630mr2021081fac.36.1751644574742; 
 Fri, 04 Jul 2025 08:56:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff03f88sm568369fac.2.2025.07.04.08.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:56:13 -0700 (PDT)
Date: Fri, 4 Jul 2025 09:56:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org,
 otavio@ossystems.com.br, michael@amarulasolutions.com, uboot-imx@nxp.com
Subject: Re: [PATCH v2] mx6sabresd: Reduce U-Boot proper size to fix boot
 regression
Message-ID: <20250704155611.GH6424@bill-the-cat>
References: <20250704144022.3946416-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U4OTyF4flGH4jJYa"
Content-Disposition: inline
In-Reply-To: <20250704144022.3946416-1-festevam@gmail.com>
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


--U4OTyF4flGH4jJYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 11:40:22AM -0300, Fabio Estevam wrote:

> The mx6sabresd U-Boot proper binary size has grown beyond the=20
> CONFIG_BOARD_SIZE_LIMIT.

So, is CONFIG_BOARD_SIZE_LIMIT set incorrectly then and needs to be
lowered?

--=20
Tom

--U4OTyF4flGH4jJYa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhn+ZcACgkQFHw5/5Y0
tywYhgwAtpZulo5OVcKlnD2FJxe+8SgaO9ggjljXdfdXrGohRZ8pE7K7EF0unV7i
uMiez0HV1iJp5ZD0d/2yrFs3dizIaW6SoH8EyUE0cD0W4pQbzoldDL+HwO5e8evQ
8Y1AjApvA5uJtfOG94KwKPxyUVlRB0e7n9KVU8G+t8qaVmP9jTd3AbGaGaUfWbkb
NTqr8I+Q1Fbnkb1V5/Y3yj0rlADLjrd+DpOkkWVkw9j0kuL8puQfWz/6bbKd/Lts
uMFPTkdytRTK8L6ZS5OqZKqOSB9ze3Iq4HUc2c4oeRByLheqWsPopUxBZP/HnAPL
LAuZzfhp3cHLvudTdvy4U5z0bldKy9s8l+s5w6/DYTpj2U4VTcDpFWv7prf8w1/7
7zJgIjavsMjA5Q2w9ghQFknL5Nhzx0ELfJTUHUQuHhHx4MHDiZAyVuC7ecx3Cq4O
ojnGCYPCe9fCXR4UJd3Wmh2hOVb5DFDSIWXBRSlPkXt8Qegxgo0rNFRRy8XwkXi5
mSrQFk8d
=GGAi
-----END PGP SIGNATURE-----

--U4OTyF4flGH4jJYa--
