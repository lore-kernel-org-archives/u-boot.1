Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAC8CF9C71
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 19:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC8C8898B;
	Mon, 23 Sep 2024 21:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZAx6Nysh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECDBC8890D; Mon, 23 Sep 2024 21:51:21 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2E288B86
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 21:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-45821ebb4e6so37486401cf.2
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727121078; x=1727725878; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uB586FS2dgwVMjKErZbWOHqZ2N4WRNBIuR17EzIUT6g=;
 b=ZAx6Nyshf4sntKogwMfIBFCfPpJBPo2rtzSvAOdFnCbyLYlaUpJXpDxK4eX2jtRhCv
 7HvMghd5vmEy2wtBqdHScx7WmMn7WbcZ5VQA+UF8X0dFGmTXi8MmNFpUwYTB4GpxGvu2
 KGYVjkl8PZgbydFfJdPy9TzJcoJCCZybzpELc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727121078; x=1727725878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uB586FS2dgwVMjKErZbWOHqZ2N4WRNBIuR17EzIUT6g=;
 b=wDowgeyQXmcGkjmlt4oEcd+SJOdBEEuL+LbigUNAC/lDuweHzyDRdBld9M5I7MvyHd
 8Sy5guY3El3cFrcDmd/8q9+3E3fEBsBTgwmNulrqwCtC9X1Lj94TIa9Gxc0xV9+UdSJg
 t9t9RVwQgchGzye/PDY27+W4dHy0C3kM1pNE9avVy+SPswnufKCtgbQk34+S0wCYzMy/
 mufvWPFlPCmzcWPvQ5hnsamX+zBRzvE7HbT14Y2Brkdn4Jvx7MLjR/wTZgsrAdicwlae
 zjZpDK8UCRASiRKtxUqLYkXEX8gpC2YMP2e2ATjdFNFvyPlINqKHHMFY2IWdi+h9mmlI
 NhJQ==
X-Gm-Message-State: AOJu0YyJE+z/Di5anLUvNYFWxBn70NEs5C6NnfZcngiVRPI5A8Mpbmpn
 ej95eY3QMhMKxEZkDwgxCrkTZbxrImW3u6tjWs+TeUjjOhudu/d5JFctddJZi9VDoGvqREaxIhY
 mYdA=
X-Google-Smtp-Source: AGHT+IEV6oskACyPxgw+lRo+zmvcfZQRXA8r0uCSfwNbl1M+UNmC2zjVEDN2BktgYxGk7BvO3GndLw==
X-Received: by 2002:a05:622a:188a:b0:458:3fec:e741 with SMTP id
 d75a77b69052e-45b228cd3fcmr160746681cf.47.1727121078085; 
 Mon, 23 Sep 2024 12:51:18 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b17867ef7sm50208141cf.4.2024.09.23.12.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 12:51:17 -0700 (PDT)
Date: Mon, 23 Sep 2024 13:51:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2025.01-rc1
Message-ID: <20240923195114.GO4252@bill-the-cat>
References: <2a5d1c10-f5ed-4d13-aacb-280c7a3a6180@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+uOjga7O+Gw6Ie+d"
Content-Disposition: inline
In-Reply-To: <2a5d1c10-f5ed-4d13-aacb-280c7a3a6180@monstr.eu>
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


--+uOjga7O+Gw6Ie+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 01:54:30PM +0200, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your tree. Most of them are related to
> dt-schema and it's alignment.
> But the most useful one is work done Prasad for being able to apply DT
> overlays via Makefile rules. The rest are just small fixes.
>=20
> Thanks,
> Michal
>=20
> The following changes since commit 948616894c6d3316a5ac8f2a891783e3e7ff35=
16:
>=20
>   mtd: spi-nor: scale up timeout for full-chip erase (2024-09-19 16:42:31=
 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.01-rc1
>=20
> for you to fetch changes up to 61bf0fa8663d85c5d4088a9f82c9244181f3adce:
>=20
>   xilinx: zynqmp: Add bootmenu support (2024-09-20 15:33:01 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--+uOjga7O+Gw6Ie+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbxxq8ACgkQFHw5/5Y0
tyzB0gv+Jtb+z6+rXuuu4mPxHo5bH0HTjKoU2cgK3BEOXv/7yUI9d3kVs/soB7ur
dwRCs2aqb/b6Def/NhA5x1cmjN1n6hGMZM/XA15SpNmko8LAkmwgQ/U2wfK8c0gE
z51EZayDPDM4LW4BLObtYgzO9XcYUBrJ5ZZ0+QbFTpCSqlaYJUpbeMKgI+0hHJpU
C6oOydP+c6qmlhjWaQcQpAIGjG5Lpkw0gXVKqvFDKpT+JutxuFRS7kfK7gs5mrTK
7yGIRibRsLgEQS9KQrHhkZ0FdjB3OTiw00/gG67knsKUxgOF1uwoyT3/Ryo1nXOF
jyZDeACITvzQ5JrwO5DVu87jcS5ZuXWWverjHvV957l45PXNcyFdxHsUgpvFraYq
wEy8a6babOei8RQrJFl5qAQGGJBKX9nXqsnETlj9F8DOLCtnPt5Z499A7gkN9oGr
W9J9RPIs9dlqxsEXIjxzjSfbs6sb8cf3T+xKfJR5van8NIybKjjfxhf+L9tTt3ZK
ZvvdjfAW
=33UB
-----END PGP SIGNATURE-----

--+uOjga7O+Gw6Ie+d--
