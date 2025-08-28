Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9DCCA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 14:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19368833C6;
	Thu, 28 Aug 2025 16:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ich3KcAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B008323A; Thu, 28 Aug 2025 11:46:16 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B062A831BB
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 11:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3EFD04E40BA0;
 Thu, 28 Aug 2025 09:46:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F1B2860303;
 Thu, 28 Aug 2025 09:46:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 55DF21C22CAE7; 
 Thu, 28 Aug 2025 11:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1756374372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GRwjejIiy9hGJQdGVyxSe2beYU6d3mghbp4mzk9n1B0=;
 b=Ich3KcAb3m8P670P9oWAfyxhFE2Z0SsSVdNEbN9Zu44+df/hUhknZ81Lgm6e9ubfJ8pLyl
 VusAY4Dx4ADn+qcji2Wmmr1/gKJ6VcO5P1TFEREU1fogyeJJW2DdObRRk/kKJx0MopvD7s
 UkIIZqapCLlrtebubsJbv6+MaiH0egHmwqQ0lbUXVF0jE6EzZNdITO/SIXo946ckGk3dVV
 lkY9wNCk1ovuV1sorw6BjY10VP4T5mg6/R4DCtS+WLuA/PrUadfUGvPZRZN+uUgtOSN8iy
 NgDz7qD7n0d8BgGSjph7qMN/ip/fTLmQeyutbT7xmGijoDkZy7P71mQtHfp1Lg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,  Christian Marangi
 <ansuelsmth@gmail.com>,  u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: mtd: fix speed measurement in the speed benchmark
In-Reply-To: <20250826192131.340354-1-mikhail.kshevetskiy@iopsys.eu> (Mikhail
 Kshevetskiy's message of "Tue, 26 Aug 2025 22:21:31 +0300")
References: <87bjo22knk.fsf@bootlin.com>
 <20250826192131.340354-1-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 28 Aug 2025 11:45:45 +0200
Message-ID: <87tt1r6api.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 28 Aug 2025 16:03:14 +0200
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

Hello,

On 26/08/2025 at 22:21:31 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> The shown speed inversely proportional to the data size.

                 ^ is

> See the output:
>
>   spi-nand: spi_nand nand@0: Micron SPI NAND was found.
>   spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page size: 204=
8, OOB size: 128
>   ...
>   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
>   Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
>   Read speed: 63kiB/s
>   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
>   Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
>   Read speed: 127kiB/s
>   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
>   Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
>   Read speed: 254kiB/s
>
> In the spi-nand case 'io_op.len' is not always the same as 'len', thus
> we are using the wrong amount of data to derive the speed.
>
> The patch also updates the help for 'mtd read' command to show the presen=
ce
> of the benchmark option. The help for the 'mtd write' command help has not
> been changed to fit 80 character width restriction.

I would put this into a second commit, and anyway adapt the write
command as well. I do not think the 80 chars rule is so important here.

> Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/mtd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Changes v2:
>  * update commit message
>  * 'Fixes:' tag was added
>  * calculate speed a bit more precisely using a 64-bit math

This should have been done in a separate patch. In general we prefer
atomic changes. It's okay as the diff is small, but as an example I'd
have instead done that with 3 patches:
- Fix the calculation (sf/io_op.len/len)
- Change the size because you fear 1h is not enough
- Document the commands

Anyway,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
