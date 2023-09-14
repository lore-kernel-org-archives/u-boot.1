Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD722EEAA56
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1372686A9E;
	Thu, 14 Sep 2023 18:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="unjwQP/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007C386BFF; Thu, 14 Sep 2023 18:53:54 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECAC2869F1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5922380064bso13619827b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694710430; x=1695315230; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kxCsLQkIJ69NoCsU0NXDvHVlUYMBrbYL7zehlt4vDXI=;
 b=unjwQP/Lo3ERh9gcQREIOEtpflFq4G3chikQessjPCZHT5J5AE707p6845QYDbjyNI
 YHOLfctb0ChD8dDqV2DeOwmrORScpHDk1m+8WmvuWMaOr8tx0ZDqa9YpUkOQiExuZhIN
 LG62NMItg6mmGmaR1QVYRtwB3u2YHE0D5JBaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710430; x=1695315230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxCsLQkIJ69NoCsU0NXDvHVlUYMBrbYL7zehlt4vDXI=;
 b=EKurqazmPNgUO7OOmQh4SbdUUW2ZQz790tdJm0nWLVNEZPXZFi5an8sWlNotpiLYRR
 aHqDfbU4q6AiJlFDdACmSTn7LXJsTGyuRNjh7eb/MlLtaIG9LgPOB6MNNffWOLy/k9IS
 zbv9HC80rDBgcjga0rE8osiyRGN3OEvt8eN4sZDuiWhb4+XjiLTrsi+yIyc9117ZHMaU
 IZtgr76H1S1PlsJMj8BcqViGgVsK/SyenPq+Q206biKBT5ArQz/EKiNojJhhd9EnGxbH
 t6drodcEYl8nE6uinB1mbhLfQYCs556PLzJuTj1YOz04PmAaNPcSHAYmjvpXTyJKcwnu
 yuUA==
X-Gm-Message-State: AOJu0YyL/tZwV+GGypiAR2uGnxE6mC2Foj+zEw/SW+NFAWke+Ybwe5yR
 5afvPp/GE4DvulMqHblIra523g==
X-Google-Smtp-Source: AGHT+IFa0yaRALUkx8z65GBQLbVhY4GwhQyw4Qbng87u0WSSt+EhWlw5ApiPdt8HnC53o3p6e6LSRA==
X-Received: by 2002:a0d:e9c3:0:b0:583:d1fa:1fc4 with SMTP id
 s186-20020a0de9c3000000b00583d1fa1fc4mr6300065ywe.26.1694710430705; 
 Thu, 14 Sep 2023 09:53:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 q65-20020a0de744000000b005869e1d8c41sm407385ywe.29.2023.09.14.09.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:53:50 -0700 (PDT)
Date: Thu, 14 Sep 2023 12:53:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Randolph <randolph@andestech.com>
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com,
 tim609@andestech.com
Subject: Re: [PATCH] andes: rearrange defconfig and dts and memory layout for
 SPL.
Message-ID: <20230914165348.GD305624@bill-the-cat>
References: <20230914114549.1934199-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d2dzEl9zEX4SF13Q"
Content-Disposition: inline
In-Reply-To: <20230914114549.1934199-1-randolph@andestech.com>
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


--d2dzEl9zEX4SF13Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 07:45:49PM +0800, Randolph wrote:

> Modify "CONFIG_AE350" to "CONFIG_ANDES_AE350"
> Unify the memory layout for u-boot SPL.
>=20
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/Kconfig                   |  4 +-
>  arch/riscv/dts/Makefile              |  2 +-
>  arch/riscv/dts/ae350-u-boot.dtsi     |  1 +
>  arch/riscv/dts/ae350_32.dts          | 61 ++++++++++++++--------------
>  arch/riscv/dts/ae350_64.dts          |  1 -
>  board/AndesTech/ae350/Kconfig        | 28 ++++++++++++-
>  configs/ae350_rv32_defconfig         |  3 +-
>  configs/ae350_rv32_spl_defconfig     | 21 ++++------
>  configs/ae350_rv32_spl_xip_defconfig | 18 ++++----
>  configs/ae350_rv32_xip_defconfig     |  3 +-
>  configs/ae350_rv64_defconfig         |  3 +-
>  configs/ae350_rv64_spl_defconfig     | 19 ++++-----
>  configs/ae350_rv64_spl_xip_defconfig | 16 ++++----
>  configs/ae350_rv64_xip_defconfig     |  3 +-
>  14 files changed, 101 insertions(+), 82 deletions(-)

This does 3 things and needs to be 3 patches.  First, is renaming
TARGET_AE350 to TARGET_ANDES_AE350 which is fine.  The second is the
memory map changes which also seem fine but are harder to review.  The
third is introducing what to me seems like a different way to implement
SPL_OS_BOOT.  But there's also not a full example of what that part
looks like in this patch.

--=20
Tom

--d2dzEl9zEX4SF13Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUDOpkACgkQFHw5/5Y0
tyyNOQv/XRfrzqVbXWhp6Os+KHXPvmi+taDMBOGaX/bdTnf0WODlBLCtmBx7bXWU
e+OEv8wFlCn8Z+yZ0G/ONOn6UfK/tCnMxqCfNSHilDdZpFk1lvz5nySTd2MnCZHl
EaI4tdnzb1RyO4ytNNMZMsJ3Le/dsj/QHGj+wYA5HopvbiYv4lKyFQkRsglQubh6
4B7w7yrA/2B/U1ZSOkd+Ia2iADBhPt+GvY/WaEp6Dz3apxNfkKneX9rr2qFn7Ae0
BD1QHJ6vXhLgiMwj1x0qda1dA/7OiOIc2/yX3uecUIuu4tmIwzJt2nCHvm4Ullzo
B5mtjIWZ9vDLCUJ72fWcrWML916OZOl/V6TbSwtkYPWS/lhb2oa5SHGgWXoR2pJG
zkJvPTsHgr6fivtWLQaqHtf8wl67utA/fhvkvE1KqcgRAhM4fNk843QQYE/ruwCr
3OsVUma+o9Y8AiXFa/sa2u168ARRRNlRJH8rAyeYSRacLyvAW5VZ5LaElhdw6wtC
xTq/vYEo
=Fjhj
-----END PGP SIGNATURE-----

--d2dzEl9zEX4SF13Q--
