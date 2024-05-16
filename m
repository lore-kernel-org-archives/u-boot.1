Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F91EC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 07:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C8187FC7;
	Thu, 16 May 2024 09:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QiM3vqz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F7187FED; Thu, 16 May 2024 09:09:54 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160B487F4E
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 09:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 423A8E0007;
 Thu, 16 May 2024 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1715843391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZr4zRQ1VtfAgZmwOUEJaFufDWQI5tIEc19tWPK8EaU=;
 b=QiM3vqz/IniZMf9wB7vpQj3VNrhdPwTF2uwe3BY+nI+j55ipOASmTO46vhTQqSyJz7UAZk
 ynDIrKsXqEVEzC/TWVcuZs/ewGtFCO71MFn6bk8BOzStYLrDGCF/XznDwZ0tc45gCr6k2f
 qs9ku2LkHK6BpCz4fG8Fnr/jWEZ9UXX+cehHXalGXJ+NO0P/7cN7PGFXd6eFxRDB5iXVIJ
 wj7D7k7On1dHqQ3yoeqDf0JpIuSJHpcUYcPezsvtG3ea2xOZojlAQD3sw+IMp5XFOGokJA
 aDoeb+ir1O7jqyWhP97s5Ms32SZyiza7IDb2SG9LVyGhgyqIKdXSkWMm3jU7UA==
Date: Thu, 16 May 2024 09:09:50 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v3] tpm: display warning if using gpio reset with TPM
Message-ID: <20240516090950.373d304c@xps-13>
In-Reply-To: <20240515232138.3065987-1-tharvey@gateworks.com>
References: <20240515232138.3065987-1-tharvey@gateworks.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Tim,

tharvey@gateworks.com wrote on Wed, 15 May 2024 16:21:38 -0700:

> Instead of displaying what looks like an error message if a
> gpio-reset dt prop is missing for a TPM display a warning that
> having a gpio reset on a TPM should not be used for a secure production
> device.
>=20
> TCG TIS spec [1] says:
> "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the
> platform CPU Reset signal such that it complies with the requirements
> specified in section 1.2.7 HOST Platform Reset in the PC Client
> Implementation Specification for Conventional BIOS."
>=20
> The reasoning is that you should not be able to toggle a GPIO and reset
> the TPM without resetting the CPU as well because if an attacker can
> break into your OS via an OS level security flaw they can then reset the
> TPM via GPIO and replay the measurements required to unseal keys
> that you have otherwise protected.
>=20
> Additionally restructure the code for improved readability allowing for
> removal of the init label.
>=20
> Before:
>  - board with no reset gpio
> u-boot=3D> tpm init && tpm info
> tpm_tis_spi_probe: missing reset GPIO
> tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
>  - board with a reset gpio
> u-boot=3D> tpm init && tpm info
> tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
>=20
> After:
>  - board with no reset gpio
> u-boot=3D> tpm init && tpm info
> tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
>  - board with a reset gpio
> u-boot=3D> tpm init && tpm info
> tpm@1: TPM gpio reset should not be used on secure production devices
> tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
>=20
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMI=
nterfaceSpecification_TIS__1-3_27_03212013.pdf
>=20
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Looks way cleaner, thanks.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Miqu=C3=A8l
