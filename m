Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92340C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 07:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D2D87BA8;
	Tue,  5 Mar 2024 08:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="lECoUa7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F1287C4C; Tue,  5 Mar 2024 08:56:15 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CCB875FA
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 08:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1709625372; x=1741161372;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+3TFvIrni3CYBewTzOfmd5O+0R62bqLiygHIaKzgfKY=;
 b=lECoUa7xbnKYbvWi5x9ZHA1lcTQu/DKbcN4KLMBVVOkuN7a87hUsAwBP
 BI/1/isdvQ5LpNnKaX6XlINoQSN4Lt+5DFnkVrlBiAVW/tK62Pt+TLSy/
 LSdPGyoVrzSA2b4j7gZhpDAzmtCy3OovyiGbq/BZbkXa7pyAUy/EGUtqo
 EE7fgQiujIuzc3IGH803Psre0e4o4aFgyQJoXkUuWuOAxCakOU27Um86L
 PrtwDXc6+GlSOv8edErzoURsnBhabsmjlKWNAwQzA4e7KRCGTzNi9c/Lj
 qyoYsXvyw4u8b7q6jNCtCmk5JwK5zWDlJzJbnV7weE3PL1KG9meRMUqEp w==;
X-CSE-ConnectionGUID: XBiH5z6dTQS4bdjPYAZ5zg==
X-CSE-MsgGUID: BLxdbuaZSBO9IMQMudQxsg==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
 d="asc'?scan'208";a="247970086"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Mar 2024 00:56:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 00:55:36 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 00:55:34 -0700
Date: Tue, 5 Mar 2024 07:54:50 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Conor Dooley <conor@kernel.org>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>, Bin Meng
 <bmeng.cn@gmail.com>, <palmer@dabbelt.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] riscv: cpu: improve multi-letter extension detection
 in supports_extension()
Message-ID: <20240305-expulsion-pastrami-0a1ca34d96d7@wendy>
References: <20240304232835.3076533-2-conor@kernel.org>
 <da2c1e6b-95c6-4326-a353-3ed32c524b40@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fpB+RMTzhqard7rU"
Content-Disposition: inline
In-Reply-To: <da2c1e6b-95c6-4326-a353-3ed32c524b40@gmx.de>
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

--fpB+RMTzhqard7rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2024 at 08:34:20AM +0100, Heinrich Schuchardt wrote:
> On 3/5/24 00:28, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> According to
> https://github.com/riscv/riscv-isa-manual/blob/main/src/naming.adoc the
> ISA string is case insensitive. Why can we assume here that it is lower
> case?

The binding does not allow upper-case.

--fpB+RMTzhqard7rU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZebPygAKCRB4tDGHoIJi
0mi1AP9CT50cqpx8LEyVThskcSPsjrfXW+Lmm/2QuNrOXYVSyQEA2Nj6k03vf5KX
pYAu07oV37klxNedoI0xIMNEYiVqkQc=
=BrTt
-----END PGP SIGNATURE-----

--fpB+RMTzhqard7rU--
