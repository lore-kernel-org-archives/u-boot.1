Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B2EEE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E849864FF;
	Wed, 23 Aug 2023 16:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WdqQsbte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C25864FF; Wed, 23 Aug 2023 16:42:51 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FBB3864FA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d77c5414433so694905276.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801768; x=1693406568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+3SrR3sj6t0eipYgR0LX5gekyqYsgzF0ws00ZDA3Eus=;
 b=WdqQsbte5XEwCH6c3lnHS7dngPoc8UWBi2yD/JXDPYAzRN0tkOA6HJ+RMjgrveKbE7
 KVSBoBX1Y2LccTxdsGw5Xd6QRGXG6phi+EzOh4kNvuvo6PDBEEs70IS0tT/LaQ3B7uIU
 9jMAD0m21QDjC7c+hEoCCDd+VHzdNQztMiPpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801768; x=1693406568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3SrR3sj6t0eipYgR0LX5gekyqYsgzF0ws00ZDA3Eus=;
 b=PHGDpiubiYd1f5admGeSBuq0HGpIxktxjKJjq8sm3EJv+BIoHUQHLamitbtDkSl9dx
 LNTt4sevMJoVjkGvsfdcy5VEM7FYTahIuBvUCJ7NNYvyQ2lcCUy5aycsg48FJzhGRQYQ
 r5D7DUJyJ1iKIbNJqgG4wlUzjazZ6kfovqSxM+Pmz/bEhM1DxR7PC1ki/mwO+RhAXA0t
 826kqFdO11uKmS8Cm+BWXRKn8xEoDmjB+a9AtRtGLH2oT3ViVZcFtn+eGJevaBWVdZ8B
 mGTH9+FVrTUONDq8VZMmNahfRSaUWG+gS4bRoHAcsz8dXF0GQCWttJZNDD5197xB0ELJ
 mHyQ==
X-Gm-Message-State: AOJu0YyqpQcc5rHOlvpQ+5KkHfl/BjM9GPBuWYL8qmGl8rZu4dImALDc
 M+sub6MuZW3OUZiGH37hMG+lnA==
X-Google-Smtp-Source: AGHT+IGTc/cCGMFFU+4Q1c/fKti/BHbAVu4zicbD4Da52ClBKKn0i4mb6zix5GKhqZ8li1giMPujjQ==
X-Received: by 2002:a25:3d3:0:b0:d0a:a66b:cfbb with SMTP id
 202-20020a2503d3000000b00d0aa66bcfbbmr13232446ybd.15.1692801768025; 
 Wed, 23 Aug 2023 07:42:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 y127-20020a253285000000b00d74c43dad49sm1499300yby.48.2023.08.23.07.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:47 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 2/2] scsi: Add buffer_aligned check pass-through
Message-ID: <20230823144245.GD3953269@bill-the-cat>
References: <20230813235000.591239-1-marek.vasut+renesas@mailbox.org>
 <20230813235000.591239-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cebG3S6r3xzfCmWM"
Content-Disposition: inline
In-Reply-To: <20230813235000.591239-2-marek.vasut+renesas@mailbox.org>
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


--cebG3S6r3xzfCmWM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:50:00AM +0200, Marek Vasut wrote:

> Some devices have limited DMA capabilities and require that the
> buffers passed to them fit specific properties. Add new optional
> callback which can be used at driver level to indicate whether a
> buffer alignment is suitable for the device DMA or not. This is
> a pass-through callback from block uclass to drivers.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--cebG3S6r3xzfCmWM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGuUACgkQFHw5/5Y0
tyzs/QwAqSrCO3k7qOTcuGxE9Ic+LPzfs0iPrrYDbqf1P9xzvMiJ0SZR86LNrAHl
Wbw5lZelMBn97XYN9lrzHarR8WS+m/zDcVpWQAZXxeRz4cPpUxLWBq9dYL0obY7n
xtGNzADb2un9CVAKMF6ghqAO18Y0uFKLp4c6n9fXq+m7qD8wgLBcnkx20SxzjMGb
oL3Dd+EDZVOImyxZZ2/gQOHbTHbfzP0NiZpdfWonqwFcFXfRHKDFX4NvHi0vs7o2
BUESNmCLQziX0Inn0piAbt3D/Yy5swsRY/zWgn2Xpw7H2FwpeEenHbfc6inV/UKR
b7TmUqoqyq66QruiaIqAYCjKTS7ZTArYGDtycNXD5rY5dVhXTj6QxIw6cZj2RuLa
zCmEpCGhwVVH/+xfmBsz21r4vaWleoq3j2U/fHcu4gVI8kXwOzt5QEnhEh3qTOf5
N+PBDIYit3a9aXl2zmyoqnuK3e8Qjis0P2M6er+Q3ODj2iFlPIHkc2k/EVfWEk0K
Kxt22sHc
=d3XQ
-----END PGP SIGNATURE-----

--cebG3S6r3xzfCmWM--
