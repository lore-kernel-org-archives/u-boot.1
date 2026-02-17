Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D3FE68152
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 09:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F3083981;
	Tue, 17 Feb 2026 10:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hdXl7TNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BC383C32; Tue, 17 Feb 2026 10:16:44 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D9F8063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 10:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 28192C16A15
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 09:16:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A18D5606D1;
 Tue, 17 Feb 2026 09:16:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D964E1036885D; Tue, 17 Feb 2026 10:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771319801; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=3KxrBMN00Im+/T27YZUCwvK39pj1XvoQfHCu/F7ee6E=;
 b=hdXl7TNS7QeUgnw5NUUhbBXlBYPQUkTx00OY/UBfLeUSA/j34E3uB9M/I3UHTtQys0kJx5
 oR5gjHGKnB6uRaYHYvoJjj9iHHEtIwoCIXJ2migk9uiKcgFjntSwrk6ArcYTUl3n9DcZK2
 qci9Qm95SdfjYMo7fiCFuU7g2l4AVLtbZk1CC51ZdwmjyiaSHXh5MaAA9k63yiwfJWSzAB
 rINDtq38H2Eae1Mj+CSmOwLTgpVrYhKKyK38aE+o/asEIjrPQFvtQzm4sgAHN02bJv/1sL
 qo6fCsdP0waEeZizF2zUV6ZZ0PnfEBNxN1Qj9NZCBz32HETSwX4sN4GrFPZZ/g==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH] dm: core: Don't allow ofnode_to_fdt() to return NULL
Date: Tue, 17 Feb 2026 10:16:37 +0100
Message-ID: <6241294.lOV4Wx5bFT@fw-rgant>
In-Reply-To: <20260216175020.GX2747538@bill-the-cat>
References: <20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com>
 <20260216175020.GX2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5079667.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
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

--nextPart5079667.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Date: Tue, 17 Feb 2026 10:16:37 +0100
Message-ID: <6241294.lOV4Wx5bFT@fw-rgant>
In-Reply-To: <20260216175020.GX2747538@bill-the-cat>
MIME-Version: 1.0

Hi Tom,

On Monday, 16 February 2026 18:50:20 CET Tom Rini wrote:
> On Tue, Feb 10, 2026 at 05:29:01PM +0100, Romain Gantois wrote:
> > The ofnode_to_fdt() function may return a NULL pointer in multiple cases.
> > Or, this function's return value is often passed directly to functions
> > such
> > as fdt_getprop() which end up dereferencing it, thus causing a NULL
> > pointer
> > exception.
> > 
> > Don't allow ofnode_to_fdt() to return NULL, to avoid a NULL pointer
> > dereference.
> > 
> > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> 
> This leads to failures to build such as:
> +(neu6a-io-rk3588) drivers/core/ofnode.c: In function 'ofnode_to_fdt':
> +(neu6a-io-rk3588) drivers/core/ofnode.c:176:21: error: assignment discards
> 'const' qualifie  from pointer target type [-Werror=discarded-qualifiers]
> +(neu6a-io-rk3588)   176 |                 fdt = gd->fdt_blob;
> +(neu6a-io-rk3588)       |                     ^
> +(neu6a-io-rk3588) cc1: all warnings being treated as errors

Indeed, looks like the dropped (void *) cast is responsible for that.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart5079667.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmmUMfUACgkQKCYAIARz
eA7qVw//QsNfv0cXTW81YwV+S3UilMngHE1bg/qmzc6SUkVivY8CRsr6IWhkcwVG
gcL/A6nBU7hRX0hJDZyc3jgZ2WBsxsKJ2EdsotEpSS/evgRUY1kOwLjsF60Jn2Rp
xlMJIvsn8HHIHBfi1Ab/fg335eimxdwY6EU9odVRtQsJSmJUAj5y1UXWSKC+aoKD
NO704WJp49d7NVzaDCjV/CzRI9PH36eI0Dar34fo0YKPB0c8gHGxliqjpBVn8xrX
JgqTF4ZOOJ1yiGmV6WLHrY9fWruAT3T+og2uICkMrQEY2SCT1R6kML6YQSGbv+WI
1kR5NARPE2jbvw4RlGnaXwUgqKyPRVe4bNjKkGYtC/c9Ja2s77eAAxRaOljbnwta
1003vsOc88xSWwJWY80aV+tyPGoDNiTmLcFZ58kBhS+uiyk6vH6NGtFYV9nA4uAo
8nGWHDgXhocGlfSJK7Rsj4MU/kdEbqLLcuW5469Lr8Y3viMW1NGNlmReYj9Ws6Jr
RPjOUoRasLwiuZN4Z1vo0FvxWGARwWvSeZs+j+iGV7+5f/K8oGxg/cIrB3/vt9+d
eU0DrH59E9q/TR9tZ+cNXWDhV8hK5O0KdHyNP56hN9AMZ+ks+tnt+bk7MbA0zBEi
Mn9j/P8ny/CJOYT/wsEL4YjUO+Gp2mQD7r/QyjVmyd3T0ZgG+z4=
=yk75
-----END PGP SIGNATURE-----

--nextPart5079667.31r3eYUQgx--



