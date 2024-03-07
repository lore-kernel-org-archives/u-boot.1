Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0F2C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 08:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3FE87DB9;
	Thu,  7 Mar 2024 09:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="mZ1xAiaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B2D87DB9; Thu,  7 Mar 2024 09:40:45 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8592487B89
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 09:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1709800842; x=1741336842;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UQoWcPcSwm4klZVo1A/0S639pvQb8xeWe5OivG/Exgs=;
 b=mZ1xAiaVtRvA5O2bJUrN8rq1Q5YDaCwckWbYocReB0vodGUxvgUjoShd
 6lTAGWcpPH0bLt/G3GY/Vj5mcNc26mRO9ECG5rP66dpV2lIFly51gBRWz
 QN8RE5AP5D6RN3esLZXC+iPo+tYsbqAbvu/RcadZcfY+X3cUW1HO4kTUy
 wPBUAjzfFQxxyne440a/f5WbVIYCs1jLAvnphu0unrnMf3zhbkropuWcM
 y6jIUfIFudlJSOuzFjfDFhqp4KDBD/NoopEyE81jgD/WW3G5rbd+bw02q
 jAbWfSle63jp+J3CB/LLBMOWBABCmzdepICXpCBhbY0MxvpYzsbud7zdK Q==;
X-CSE-ConnectionGUID: BpxqfRJXTgODJnAdB7tOvg==
X-CSE-MsgGUID: 5loahiuoSQyMyYxKnMM8Zw==
X-IronPort-AV: E=Sophos;i="6.06,211,1705388400"; 
 d="asc'?scan'208";a="17871878"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Mar 2024 01:40:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 01:40:19 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Mar 2024 01:40:18 -0700
Date: Thu, 7 Mar 2024 08:39:34 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Leo Yu-Chi
 Liang <ycliang@andestech.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] serial: move sbi_dbcn_available to .data section
Message-ID: <20240307-strangle-magenta-a6bdc79cb6a7@wendy>
References: <20240226163226.126288-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GU+QBTmGDYeI3F/J"
Content-Disposition: inline
In-Reply-To: <20240226163226.126288-1-heinrich.schuchardt@canonical.com>
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

--GU+QBTmGDYeI3F/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 05:32:26PM +0100, Heinrich Schuchardt wrote:
> U-Boot SPL loads the device-tree directly behind main U-Boot overlapping
> the .bss section. reserve_fdt() is called in board_init_f() to relocate t=
he
> device-tree to a safe location.
>=20
> Debug UARTs are enabled before board_init_f(). With sbi_dbcn_available in
> the .bss section the device-tree is corrupted when _debug_uart_init() is
> called in the SBI serial driver. Move the variable to the .data section.
>=20
> Link: https://bugs.launchpad.net/ubuntu/+source/u-boot/+bug/2054091
> Fixes: dfe08374943c ("risc-v: implement DBCN based debug console")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

This also appears to fix the inconsistent boot issues that I've been
seeing since I reported:
https://lore.kernel.org/u-boot/20240122-finicky-ancient-797ba048f927@spud/

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--GU+QBTmGDYeI3F/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZel9RgAKCRB4tDGHoIJi
0h9CAP9xufWglpaKoIlfAJgu9OPrrGaMC7nK5hGA06VDxhKn0QEA5/2yICcD73my
g9u4YHWHsL95aPBaoqMbKoiNkfCUCgo=
=Qpde
-----END PGP SIGNATURE-----

--GU+QBTmGDYeI3F/J--
