Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A601C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 16:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2619040764;
	Mon, 27 Jul 2026 16:45:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IchdGHBLPJ9u; Mon, 27 Jul 2026 16:45:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CDF540755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785170702;
	bh=4BgNw4vTt76xol4XnjBTxSHotN7/GCYdxI2JBXh74RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VMYz8MWOqi3AjsIXD+JUyzYEfcHSJ65pAzG8j4fwg5JLna7QxwHSzsT//rijBZurE
	 QqiKQRBB9WeeZAsqUqB0gnJDpCvP/KGrZFTHG1iz3OxlGUEb7DPaw5HfWXulvB/Sze
	 Ny/IdpibOvNw6dt4RFUzhAqDGUMg5izvDZR0G2PLlk6TcxtymNg86SB82iWEE7zeXT
	 0hNg3He9oQBemWud9vBZbN6y0KlKhKV6pOM9fULV9AQ/ATF0po/phx047fK9W/pSm1
	 t310ES8xx+TEmXq87VGxt3YZa6DnnE0UFzo25NqTyTlfjfa08V9Tn/uG49JkpIyS6b
	 YN4TVTsLjHtrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CDF540755;
	Mon, 27 Jul 2026 16:45:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D53823B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2C4B40063
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqOpoUxB9WPU for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 16:45:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E371040055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E371040055
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E371040055
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:44:59 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66893db7bccso3776428d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785170698; x=1785775498;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4BgNw4vTt76xol4XnjBTxSHotN7/GCYdxI2JBXh74RA=;
 b=RLIJDYsZFvA/+kqHiVSiBUiLvSSoOgph727jPI61nYVqtIE/O4DZGrKNY+2y9z/e1Y
 t1n2VirL5Cm78BAVD6y2FlzsbSNupi5jOCcNATiWNEqZgC7PIJHZfZ922S4Igerj/GCD
 VBmmXyGhKz5EitBqdhrAayLzRiGMvvSfP0W/cK8WbhfnqIMypiFGqmwQ0VLlneQZTkB9
 WtQOpa2UvMldiQnN9aQI0Ho1PQyPtBF3aYp/1RRMs//4btSMcIm4NJz0A21Rc5nHFlKX
 BJvHgmLXp5mTs2MEmgnvdqiPviXPLDUrBnIXRDgGgE+xhSbPZoGJBtDpejTwXydzkVbM
 C6pw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSJae/WY8gr/vtX16UTRNaTdUdsVZAkRUhhilo6bbJmGA6Mlx+HQaCQHtB1uEnkZot+tcfq78=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwfJXhfsQChZ+QflkLvCepkiaUn72+bV4d1LifzX9eu7BC/aqyM
 eM1eyEgphrz+HQoGll9lDtzTN0j29poMyzcioFqxKqc92qRXAmePsA0/4cEReceYPAkpT6UopOO
 mWYshXG8=
X-Gm-Gg: AR+sD10hGlepWkk7JdFvWmV/b8wMU5Q4QFSwvEIti56920gRYtIstATRL+Smio/QNdH
 aLYbUnTwrzY/STeHbPs/nrtpeNdPAAmyv03KVdlDPzbqozaNvyEtCZ63XRCzp8jVmu2+jQz2zAp
 rBclc1SvbJIu392tPJ8WAxX5KPTHFudh0CpBdIBsPkUwtnR+Vpu4NRyQMa09z8U0fNPIDtMPSJ8
 hjb+Ag67MQ8nwTeopTyWXTiROzsSCsAId5jI+3TS7qiiUo777dTghYu9/yh08J7OxfdFwt+d2cz
 tZT+x8IRU3lT9XmoVqZka4DmZ2CItRNo/kBZqCwEieTfg72JNGiyRZTuTFrpdCl+6kqk86G/Oxv
 c1026Z6Kh1X9I4lkAXEzB1iIhLrn+vmwDMgYGsSzUIKpTh0UH9WViLCCjVIwPi5I1EGgANOhPxg
 zww9pXAu5BFjR7p56JdaD0t44KfWtICYs/Qfhgym+W14SwCm8K+8KOs2fpt6GuM64+8T1RquodU
 Zm+hgdKxfbgTc56ueacVed04l4=
X-Received: by 2002:a53:df49:0:b0:667:8b90:2ee5 with SMTP id
 956f58d0204a3-668ffeb5903mr11943d50.96.1785170698466; 
 Mon, 27 Jul 2026 09:44:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-668c6d30e62sm3657224d50.3.2026.07.27.09.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:44:57 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:44:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
Cc: sjg@chromium.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3] serial: coreboot: Accept DBG2 subtype 0x12
Message-ID: <20260727164455.GA4154485@bill-the-cat>
References: <20260715134049.85424-1-jayaramudu.desapogu@amd.com>
 <20260720154826.42527-1-jayaramudu.desapogu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vj31cbyFFeaRKLMn"
Content-Disposition: inline
In-Reply-To: <20260720154826.42527-1-jayaramudu.desapogu@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785170698; x=1785775498;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4BgNw4vTt76xol4XnjBTxSHotN7/GCYdxI2JBXh74RA=;
 b=F/dX4TfTzxb23CzLb2Emvb7RUBQRQIdsjNZOzpyb1VICW9BMu6qXZ541hHbPUMCczN
 efuVyzDt5dluDkIp+kw5noFrN1PZnMD6Fpi+pKIMdhWgRlva9bmLgRp3bni3fCfqrW01
 3Zx7WIeHzJl4G2K9Bs1Fwm1yMNWR6jrU6/taA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=F/dX4TfT
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--vj31cbyFFeaRKLMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 09:18:26PM +0530, Desapogu Jayaramudu wrote:
> U-Boot running as a coreboot payload obtains serial console
> information either from the coreboot table or from the ACPI DBG2
> table.
>=20
> When serial console support is disabled in coreboot, the coreboot
> table does not contain serial information. In this case U-Boot falls
> back to parsing the DBG2 table.
>=20
> Some AMD platforms or any other platforms that uses memory-mapped I/O
> advertise the debug UART using DBG2 subtype 0x0012 ("16550-compatible
> with parameters defined in Generic Address Structure"). U-Boot
> currently accepts only subtype 0x0000, causing DBG2 UART detection to
> fail and leaving no console output.
>=20
> Accept subtype 0x0012 as well and keep the existing handling logic.
>=20
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
> ---
> v3:
> - Change subject prefix to "serial: coreboot:"
> - Shorten commit subject
> - Remove extra From: line by fixing git author identity
> - Rework commit message formatting and wrapping
> - Rename subtype constant to ACPI_DBG2_16550_WITH_GAS
> - Add comment describing DBG2 subtype 0x12
> - Keep subtype definitions sorted by value
> - Wrap long conditional to stay within 80 columns
>=20
>  drivers/serial/serial_coreboot.c | 3 ++-
>  include/acpi/acpi_table.h        | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_cor=
eboot.c
> index b1f69f6998cfa1..cb07173a80c0cc 100644
> --- a/drivers/serial/serial_coreboot.c
> +++ b/drivers/serial/serial_coreboot.c
> @@ -59,7 +59,8 @@ static int read_dbg2(struct ns16550_plat *plat)
>  		log_debug("Not a serial port\n");
>  		return -EPROTOTYPE;
>  	}
> -	if (dbg->port_subtype !=3D ACPI_DBG2_16550_COMPATIBLE) {
> +	if (dbg->port_subtype !=3D ACPI_DBG2_16550_COMPATIBLE &&
> +            dbg->port_subtype !=3D ACPI_DBG2_16550_WITH_GAS) {
>  		log_debug("Incompatible serial port\n");
>  		return -EPROTOTYPE;
>  	}
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> index 4895366a6188ec..825652798166a4 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -674,6 +674,7 @@ struct __packed acpi_dmar {
>  #define ACPI_DBG2_ARM_SBSA_GENERIC	0x000E
>  #define ACPI_DBG2_ARM_DCC		0x000F
>  #define ACPI_DBG2_BCM2835		0x0010
> +#define ACPI_DBG2_WITH_GAS		0x0012 /* 16550-compatible UART with GAS */
> =20
>  #define ACPI_DBG2_1394_STANDARD		0x0000

This doesn't compile now. You reference ACPI_DBG2_16550_WITH_GAS and add
ACPI_DBG2_WITH_GAS so can you please do a v4 which compiles and you've
tested still resolves the issue? Thanks.

--=20
Tom

--vj31cbyFFeaRKLMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCameLAwAKCRAr4qD1Cr/k
CidyAP9zXEczHLNg87svDlKhAv+pZefF1PiqsYchQ2JnkL99HwEAysq9W7J83qQI
/mi0x9zrEmo/y2r6VZHOh6wGZ4pH4A8=
=Ct+R
-----END PGP SIGNATURE-----

--vj31cbyFFeaRKLMn--
