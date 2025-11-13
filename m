Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12A5CD8C8F
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 15:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C6083FA1;
	Thu, 13 Nov 2025 16:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D2KAMtvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5FF83FA1; Thu, 13 Nov 2025 16:49:15 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C516B83E76
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 16:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4500a6fb71aso389649b6e.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 07:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763048952; x=1763653752; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1cHqqbgab9XBIYtwc53NcOeyGCpagJ67r+R5dkKLoEk=;
 b=D2KAMtvcdhxhOaTYtd/4vsY18B3G4lJrXP6k5kR00CdjCBgjaDve7Xx20Grx5N54xB
 04S3lamyPW7IAUbW//vq+KrxlIxp6l3OdjZ1A3pdx16pDfjEkb8vix/Mbu/es2l4e/xP
 SnoVJlkDHL+4IStcO2aTxMbW0k5tVAR3L7Tg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763048952; x=1763653752;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cHqqbgab9XBIYtwc53NcOeyGCpagJ67r+R5dkKLoEk=;
 b=kOhBrZFv9t8EBKNhtfPtrtcbZZV33YOmLDE3xAhl1cw7mO2wsN1TheEXxtw/q9anIH
 sHTtGWFNlaoc/yHZvMllcRcsieH/y0uYOfv9/ZfQMHJr8q48jYjNmEsFHGGbtzU6TI96
 9XnZDLvZMIRdffQtk4AnV++6S8IQzGFdUF+NrMc8OWPiLnJ8z2JH4MOGI9Qetc+RSyZi
 KTYdklPCRfcTHCPjjhEsp6gKinrpAfpS1nZDeIjzhN9sj5/uVauFGk9RbdVEL1dFtAra
 mfIQG12RfezFdiCznua2t0SQheQH/7vwXIRRp4KNfK135U6FSj0lt1wAtoUN8VYpQFCQ
 Vfwg==
X-Gm-Message-State: AOJu0Yw1UI92TuSGB0FbCrogr/Atlr2dsNsCxP30YYl6S7t+EXg6/qkG
 cl54fmfZTys56ccQW10ay/kZEj0eYBwmCZMGqp/4GeM1aMYqbk/w0sV2WJAUNHTFXPE=
X-Gm-Gg: ASbGnctCHF8W8g7TqK0wQW0p9YGr1G54mL7fP5QFDZ7jm5nEA2iVmcPpO6j/NJt4san
 LE+YwP7EfuDt16Sr5FtDZylm4XNxnh7Zd13rNg0BZ3baq4sdJjS1Fzp/JuMnwNYTu7zSJ1tC5yy
 7yKz1K5MZIj1V+uNlGOQMJ4rydD72I9nwwD9uus5nM+GTeqxkwuPmHlVMrS/XHWDnOVyK3bKHzf
 zuLU5zeKm4+4BYlmXMn1kur2j+On2xrOY8psfaBPsHtwcpVesd6Erb3G3Glz/tWLusmXu25RjY1
 LMzSlOAkkakOs11nSvHt7Y8YBT6KnXq/Ao3Ee3k8aimZr7rEc+mGNt2wzus66IkmAxfbTAM7MiD
 fg8XjgqSAqk3vzemwofBXexL5d/TheCu5zqPCeGIKp2vRhwP5zZm8R8gBXeduHCH3IOsKBGZ7wN
 9Qn7eHZLZKnu4gFTxnb6nYIK7iLt7nWzpveN4Zg8g=
X-Google-Smtp-Source: AGHT+IFNhv3NCU04Qe7byO3A6zD51VHUtm1rlXWY4994c6AKdXp3vackk+IwQVczSwqqVx8TQWCjtA==
X-Received: by 2002:a05:6808:30a2:b0:450:1179:5f3a with SMTP id
 5614622812f47-45074582e0cmr3278229b6e.41.1763048952543; 
 Thu, 13 Nov 2025 07:49:12 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6d3218sm1133615b6e.20.2025.11.13.07.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 07:49:11 -0800 (PST)
Date: Thu, 13 Nov 2025 09:49:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] test/py: Use aligned address for overlays in
 'extension' test
Message-ID: <20251113154909.GK6688@bill-the-cat>
References: <20251113115811.947992-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j06jgpuI+I2u8amO"
Content-Disposition: inline
In-Reply-To: <20251113115811.947992-1-marek.vasut+renesas@mailbox.org>
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


--j06jgpuI+I2u8amO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:57:52PM +0100, Marek Vasut wrote:

> The 'extension' test would set 'extension_overlay_addr' variable to
> decimal 4096 due to conversion in python. The 'extension_overlay_addr'
> is however sampled using env_get_hex("extension_overlay_addr", 0);
> which converts the 4096 to 0x4096 and uses that as DT overlay address,
> which is unaligned. Fix this by setting extension_overlay_addr to 0x1000
> as intended, which is aligned.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--j06jgpuI+I2u8amO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRX99QAKCRAr4qD1Cr/k
CgILAQDsvrlSaYNPsKoqkhSy3Hha43hJH53UcnSFbCpF2W+wKQD+KM7xvazOBDAd
p3dmTieNaScosBLbONq0SKlbxAkieg4=
=xnEc
-----END PGP SIGNATURE-----

--j06jgpuI+I2u8amO--
