Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D413CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D41F8349B;
	Tue, 30 Sep 2025 11:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IaOuQOnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B341F83071; Tue, 30 Sep 2025 10:18:18 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E5A828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 10:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7AB3A4E40E53;
 Tue, 30 Sep 2025 08:18:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4F85C606E4;
 Tue, 30 Sep 2025 08:18:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6A25D102F17B1; 
 Tue, 30 Sep 2025 10:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759220294; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JQo4xWbtLITA+SMNj/VWjrQARin2q2KYPJaVi6pVGno=;
 b=IaOuQOnzKs9Q/LNwYtrAgLPr6ic8RAqOkG3prJYKddhkk+fS05sIRkyxGEzfmM51u5dpZ2
 bcLj51dRMyImzAyZvcZFqnf2OpJ1ebGBj4YJJbb8AAW99YbIDIqnSNMa5sCtNGSRaK85zo
 itT/joAoFFI/IfAhsUNRuY2/Aca9ny34NWPIqefM0n3V2tRKvUs3klkQaYTVlrKtQiVjY3
 obWuxb7y9w46puz9TCeq+61pE8Xhv7Mkb+qBBKqwohRB1scfdgRZux+Qpc8hWDkwAD7GAm
 1FxnGa4rN8BybBKtlqPrJ/Jn1qZhOAqsXo9PlptQvciTw+ffXW3FZ69FkCQ5AA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Frieder Schrempf
 <frieder.schrempf@kontron.de>,  Jagan Teki <jagan@amarulasolutions.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>,  Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de,  Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH v7 00/24]  mtd: spinand: driver improvements
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu> (Mikhail
 Kshevetskiy's message of "Tue, 30 Sep 2025 03:20:45 +0300")
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 30 Sep 2025 10:18:01 +0200
Message-ID: <87wm5ggxqe.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 30 Sep 2025 11:29:06 +0200
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

On 30/09/2025 at 03:20:45 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> This patch series makes u-boot SPI NAND driver almost the same as in
> linux-6.17. This provides the following improvements:
>  * it becomes easy to port changes from linux kernel
>  * more flash is supported
>  * spi drivers can accelerate flash reading/writing using spi-mem dirmap =
API
>  * continuous reading mode was supported (for some flashes)
>  * OTP support was added (for some flashes)
>  * add support of special data recovery reading (for some flashes)
>  * bug fixes
>  * other minor improvements
>
> The following linux kernel driver features was not implemented
>  * support of different ECC engines
>  * per operation maximum spi bus frequency
>
> The code has been tested on Airoha AN7581 (64-bit) based boards
> equipped with flash memory Micron MT29F2G01ABAGD
>
> Additionally the patch series includes continuous reading mode fixes.
> The corresponding linux patches were accepted to nand/next branch
> of mtd/linux.git repository.

I haven't formerly reviewed all the patches, but I am pleased to see
this work moving forward and would like it to be merged.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
