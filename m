Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB26AC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 09:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3108288BCF;
	Wed, 21 Aug 2024 11:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="W9cgLYFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6414788BD8; Wed, 21 Aug 2024 11:58:41 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3AF88B3F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 11:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=95660357f=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1724234318; x=1755770318;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zRSnu5cz/Rr0QXAwdV3uTxVhBYRvRxv6UlZDP3GmuMA=;
 b=W9cgLYFyxMBO09EfzSmI8Jv7OSWEcDozWCKwDml/S9sAoNOlArT6sIEU
 zFHdapsAEwbtkL5Ot9rj6K6TN/4BapNSxOT1WoAppbfKc0BeDNS5RzHZc
 WuY4lVIjrGO3tz/M3LM8AmZvrgqrXrzwRI8GtVDd2KSdibqpTPDbVA7AF
 qW+xZIqCgbU7f0vszAAdi+wUFZEYEJG2Ic2xbzvX6CETH3xwUDD1Wwvfr
 UTELf+tTCR9OgOJUQTFdww5eOQ2yH33OXJDzNVcWIIKuGTfxBQXLJrzdS
 EPM+Yla7f4uQoz+JESPo8yK0dxEr0sun50P8Bszt1DLaXvXk/+/7QON4M w==;
X-CSE-ConnectionGUID: LCTqHnLhQC2nIM6cgEZO8Q==
X-CSE-MsgGUID: Z4Hygoj8Tg6hP9a/KFgrsA==
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
 d="asc'?scan'208";a="198161506"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Aug 2024 02:58:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Aug 2024 02:58:05 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 21 Aug 2024 02:58:03 -0700
Date: Wed, 21 Aug 2024 10:57:26 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Mayuresh Chitale <mchitale@ventanamicro.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>, Kongyang Liu <seashell11234455@gmail.com>, Randolph
 <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>, Yu Chien Peter
 Lin <peterlin@andestech.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Samuel
 Holland <samuel@sholland.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 2/3] riscv: cache: Add CBO instructions
Message-ID: <20240821-smilingly-lance-c051e89df945@wendy>
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-3-mchitale@ventanamicro.com>
 <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d5IrxbP/diCx/392"
Content-Disposition: inline
In-Reply-To: <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
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

--d5IrxbP/diCx/392
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 02:14:01PM +0200, Heinrich Schuchardt wrote:
> On 20.08.24 11:37, Mayuresh Chitale wrote:
> > +void riscv_zicbom_init(void)
> > +{
> > +	struct udevice *dev;
> > +
> > +	if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
> > +		return;
> > +
> > +	uclass_first_device(UCLASS_CPU, &dev);
> > +	if (!dev) {
> > +		log_err("Failed to get cpu device!\n");
> > +		return;
>=20
> Please, return an error code.
>=20
> > +	}
> > +
> > +	(void)dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_size);
>=20
> Please, do not ignore errors.

I'm curious what the policy of U-Boot is w.r.t. extension probing. Is it
okay to enable the option for Zicbom even if your hardware does not
support it, in which case riscv_zicbom_init() would be expected to fail
gracefully and no CMOs done?
Say, for example, you had two very similar chips, one with DMA non-coherent
peripherals and one that only differed by having DMA coherent ones, and you
wanted to run the same U-Boot binary on both devices using a devicetree
passed from firmware.

--d5IrxbP/diCx/392
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsW6BgAKCRB4tDGHoIJi
0vmsAQC09TC423NB0hsj9HI2PrKYeHZU+Eiu1H3ywgZWFFPrKwEA0Gi+gWvBwxrL
lO/SRoi0I0+q6Tf8k6ShEoKXoPQDqAY=
=6Foe
-----END PGP SIGNATURE-----

--d5IrxbP/diCx/392--
