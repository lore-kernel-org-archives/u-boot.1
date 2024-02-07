Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52539C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD0D87D03;
	Wed,  7 Feb 2024 16:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uqx3UwDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3185C87C8F; Wed,  7 Feb 2024 16:45:03 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F0CC87D05
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bff204fad4so11667b6e.2
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320700; x=1707925500; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=odCoBbJCfQWM5M2lOxLQoMp51XY5Jqeipe7Rv7mIQ2A=;
 b=uqx3UwDYMyRUVB3kdpjsG7reyykrdZ+LseTlLFyMPihb4DTb2v5tEZgBxlXf06JfQT
 1cjD4SB/XXsyuTlX3ShT2ZIWML4ZFZxPOs9z7kKx9EcJbtNLvtWoMCEDOBo9x+IdRCqo
 TdwJEA0s6VrhNv08gQWh7lrSFvCY8uM8Sa55s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320700; x=1707925500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odCoBbJCfQWM5M2lOxLQoMp51XY5Jqeipe7Rv7mIQ2A=;
 b=vxX/3hGZWHmtwMKkaIY/dhIPNfXi98HNZZLG4gnrZJAzXBPxp+wlLLDk6h9iogCUUq
 Xa+SmNxSOF7tixOuHxOssBWRP7EqEtEs2/OcmpNhm5jAiYvB55BULaHB1p3XPQhUXFTW
 dPm8Vo3b+Lh9byp9QLzHBrbzx+uIfteubVPCQIBA3Pive1slEVUnntJbnwp2kw1clQu5
 D6TLtsR2oxgUN54Rv5aep+8Td4p1LK4c+LkdnNWpuUW/I6RzejfhC9cMRsPGiQhJemm+
 P8ttUnMrgYrvLuKnNg6BS1LMIYXhV1b80PqanGNUwmpgcJem5eZRVd0aC3eU7x+b3DXR
 99VA==
X-Gm-Message-State: AOJu0YxWrExajj2hcZuSzLUMhCMHXhygWjXmOUEiV6nkdSpjncLBGGWZ
 XfCmQVvU3iAjWRY0wk4jHzS/zWeHLcfP29ZrUxfzkB3EZOMod5NgEV8fCp5Zm3E=
X-Google-Smtp-Source: AGHT+IG2vl82Hucds/W9WttkC9wTTWb8aaNqvab5pGvr0B50ymXIL3042aS21N3VpClb0E2iKnSNwQ==
X-Received: by 2002:a05:6808:159e:b0:3bf:e52c:7b07 with SMTP id
 t30-20020a056808159e00b003bfe52c7b07mr4879708oiw.0.1707320699740; 
 Wed, 07 Feb 2024 07:44:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWeEGdjjh+X8Yk0J03hiiMJ+MkspFAqzePUB6P8UnPeW0sHotnOrzNQaybe1V9pZ+RRUG0uhrIBui2Hkbn8iUwqO4IB5C470oktRQsFrXaZt4KQN/pP3Yl3TpHah/CCtBNKRno9cbGudZ2qcdtMecRT6cozYusPmzHl+ciONhVXtOfFd3SKImD5og4ksA1hmKu3axjC40FiLFboL7AaOEEuQ1bmaKtiIUfIb/TM5w3X8gWW5bMoK8HU1fRIL6Yxk9PGjr8/hNJl7iJgW6wYo6U0BZn9ObcwIlyoHfITIG/48h8UCLR8GyOMgmC6iMQjl3BDFC+bncYrwy6SuVdkuJ2i8XRpu6ZuXjFMaP+wLv/XFozpDqGHw8/o2jRH0aHTDuAfMcUvGTwtaNomR7xdGdEol6vx7lCl6h5+54fkU1095Eu5DOfLbichd6hvA2B22BA02piJFwNGLi6XNJHVTw/Jn45N5wqy7TTnpnlQBr/gPRRxCYQv8ZsO8apoGBuacVsTR4QaT2pr4PIDkzoVPRDpYEyQtTalIZlk3WQKvaXx3e79vibtTGo7XewwMtbJmdMq
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 he24-20020a05622a601800b0042c2382a53csm615853qtb.61.2024.02.07.07.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:44:59 -0800 (PST)
Date: Wed, 7 Feb 2024 10:44:57 -0500
From: Tom Rini <trini@konsulko.com>
To: "Ole P. Orhagen" <ole.orhagen@northern.tech>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Kristian Amlie <kristian.amlie@northern.tech>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patryk Biel <pbiel7@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
Message-ID: <20240207154457.GB1152441@bill-the-cat>
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hkETTDxwx9fTO/GA"
Content-Disposition: inline
In-Reply-To: <20240126124801.1164892-1-ole.orhagen@northern.tech>
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


--hkETTDxwx9fTO/GA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 01:47:50PM +0100, Ole P. Orhagen wrote:

> This commit enables support for DM_SERIAL in the vexpress_ca9x4 boards.
>=20
> When running the board with the DM_SERIAL driver, the board ran out of
> memory in SPL when initialising the DM serial driver.
>=20
> Thus this required an increase in the pre-allocated SRAM memory. I did
> increase it to 0x800, and it now works graciously.
>=20
> It could probably be set lower, but I do not see any reason not to use the
> available SRAM at this point.
>=20
> Also adds stdout-path to the 'chosen' node in the device tree.
>=20
> Signed-off-by: Ole P. Orhagen <ole.orhagen@northern.tech>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--hkETTDxwx9fTO/GA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpXkACgkQFHw5/5Y0
tyxtkgwAtmKGYLA5HENFhSZinFojvGKETOcAS4vKRWGK2HrbvLsBD5AI+XCu8o39
5/Byt7GKGPSJwq7HHodPXz3h4IGQxeA483ijvsBG7yJ8qKTVV4AuvkdMN/IpN+mt
yaMOYOsqrUVL4kgzFgyFnZHjnDx+MQB0kG8vfEKb3b2RZykajB71Jx84Jw08TJh7
LQJaLhG+u15FM/mfXH3W2MKRPHX7fHpB9mDqH0NpXU2e1qSkcCpAXaIjqpxGwP8A
HxTeeX46zjf9FuHxmRUqWkaZXISaCXJjJ3bjDE1bEuTb8glFtaRYE48woUbylFIx
Ss+LLhKmnH3OcfZkdUMjpLxGBo0F8PQSuMjPUIktUMIN4eQSvdGBBDU49P6dxcjX
P+zn9dOCUdGaKKoKiYXFM1EmW7Kt/8okSL7TTxCSVUCNJsEzlImT+WDYIovCreD2
9dSlGSy7QIANu2czqK+BH1g6M71Gr4Mh5UQ0FVJ2mbpaRwQecOSW4kcwO8c20NuW
5Z+q57IX
=jHXW
-----END PGP SIGNATURE-----

--hkETTDxwx9fTO/GA--
