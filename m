Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4D0CF3972
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1557C84033;
	Wed, 19 Nov 2025 18:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZAB69AIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B8DD83F42; Wed, 19 Nov 2025 18:05:42 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E508403D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-657523b5db0so639236eaf.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763571938; x=1764176738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rmw5iDmlSEdLZlDrEpqd6T2iOQwba9JuN4b4gSocVLc=;
 b=ZAB69AIqZyNvSLHOKa8TUHJ1p61OOxpeEUPVa1Sq2PJ1azMGyXJ7Wlj0/SHQGzrFHL
 r4fB8Lt2WiQU1XhqvkmLjzKzY2bgawK8LiECgU6RDOnhaGFjP9SqX+mb9jxEl/2jNAOY
 MW1G7GLX9Zg6f5lreaM0Mhpa+rWFLeTB6D2Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763571938; x=1764176738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmw5iDmlSEdLZlDrEpqd6T2iOQwba9JuN4b4gSocVLc=;
 b=RDHv8OEtm/2ql0xCTtg9ssDwlR7/AkQ5PEgW6GqgWM8I5UqPg6QmaPQ60PHSUwYvy9
 m4AEjMbo0u9FR+eqsi8Km2SfUanWRYrWX0fJWugsT0/LHHermr1ndC0A7OGmEFmmq3xf
 xLm/UVoC0EJUbFXbLxBditpWDOpE9NhMFkdqn/hFDgH5XgLQfS1LsSznQM6cneZlN1RL
 oirn7moW7kvqdrV4yu+UqhJooUfriQXQtwiNIUqGknTeOyt0Hb1XkaTJGWjLsxv85S/q
 JUjvoJsR8tyqxjErELbKh26gIKWiALpHwZdZqQNiQdFAS+ZMLXH3Hr8c+7r8+Ltj0gz1
 9WRw==
X-Gm-Message-State: AOJu0YyG83mQwsCukNbZNIF7zIHAhL83eEYgYStF4jK19R79HlUa0FgR
 J2dM+x83KDQQFrrtREd7Am6yR5v2IOrPU13Pvf57ecNdJe8m3Fg1Iz43ARixauw3reQ=
X-Gm-Gg: ASbGnctyeiMbXhh2pxRFSpZEGsb/0zDOVAc7UFfLeUN/2zDMmSSo6Qev0crqWEq3gnx
 PRJMdAXcUiDM6Q3Qxc0utuXDBvYchjI0zHaFHP22+Eh4FkTv9FVk1nokwHfLAAtNza3TSUpHQJ/
 MlginqeZjJkA1T0/RkTqt4Sno/v0CCZpmwBIpBK7KvFpqZAfrgfzavpz8DT3eynLezx8YaZhOa6
 /E2QYJAcMk3sTzlMf/HeyW/1wke/3n5VBFdQsPxJRaoXfuiFZ/k+q9kFKxZC0gZZRsP6AtsO3xf
 zr1SOB6FADOqtaCCOpm7PJKx5JfT4marpmUif1kH6HltIhD06o7V6rBYJXB8a+qBZjCYijCM0wA
 5/RFPcLgYlYDtAFK45alHoqyU3nBAvnUhWhqfPyoaj+Ubft6uDS6NWqebDygUx5AhRUgj8AsaRZ
 Np9pdNL4Jm9RCVQXizeLyltQum20lGlbGpxKVsBdAkanHZAsT8HQ==
X-Google-Smtp-Source: AGHT+IH9NN02mZdhNv5Ildo2j0xgbT51w70vf020ItXwpt+Cx3VCL3gtXWPBbL0Up9oLBFZpZZEd1A==
X-Received: by 2002:a05:6871:288f:b0:2ff:a27f:9c67 with SMTP id
 586e51a60fabf-3ec9a4a6c42mr32417fac.30.1763571938019; 
 Wed, 19 Nov 2025 09:05:38 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e89865b118sm4680117fac.9.2025.11.19.09.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:05:37 -0800 (PST)
Date: Wed, 19 Nov 2025 11:05:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <hackpascal@gmail.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>,
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 4/5] net: remove unreachable legacy LED code
Message-ID: <20251119170534.GD2125796@bill-the-cat>
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
 <20251119-legacy-led-unused-code-v1-4-bc0ae1235baa@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dU3MRUUgsx6SIzuY"
Content-Disposition: inline
In-Reply-To: <20251119-legacy-led-unused-code-v1-4-bc0ae1235baa@cherry.de>
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


--dU3MRUUgsx6SIzuY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 05:43:48PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The code is guarded by a condition none of the defconfigs meet (that is
> CONFIG_SYS_FAULT_ECHO_LINK_DOWN and CONFIG_LED_STATUS_RED both enabled),
> so we can remove the unreachable code sections.
>=20
> When doing that, there's no caller for miiphy_link anymore, so it can be
> removed.
>=20
> This in turns makes CONFIG_SYS_FAULT_ECHO_LINK_DOWN and
> CONFIG_SYS_FAULT_MII_ADDR unused so they are removed as well.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--dU3MRUUgsx6SIzuY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR343gAKCRAr4qD1Cr/k
CurpAQDmpA6kBDb6pYFXrcxRVyh4OZJfp8UtskBvXd+XamNlvwEAp69YjApw05b8
xD6u4tBtBUuQloAJAjBhecl0/NkMHQo=
=QNzr
-----END PGP SIGNATURE-----

--dU3MRUUgsx6SIzuY--
