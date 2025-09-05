Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F09CCA1010
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 15:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C95E9838F0;
	Fri,  5 Sep 2025 17:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="C4krAjj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE348385B; Fri,  5 Sep 2025 16:13:28 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E0A83826
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 16:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B9D944E40B8E;
 Fri,  5 Sep 2025 14:13:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7AABC6060B;
 Fri,  5 Sep 2025 14:13:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1EB69102F0780; 
 Fri,  5 Sep 2025 16:13:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757081604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ptPHmmnU1SVz32JHTM4B7OEGUSlniZz4CLj0IX/78bg=;
 b=C4krAjj4on7761QKOWia8cS7qwHAcn+quNr2Q0+fQceXIkcFFrQqpRjtfwSCvSX9ZJkrZh
 h4YZ5vQERQ8/6/DRK/fO/d8HRKHRQ32diYJwR0uFNUpz3v/OMimhBvYEhN6dZfJMPPaLVG
 jyKYKa/+CzKOl0nwqN4CloKaF5IMOCs7d4OntQbeAL5+o2Ti1lwMnrnlczCr168p1RvOOd
 cA8oKHkQK+IS/fFYznKOUlmocRyRVVZaECDauaNh+K/Yq7dlYMMWbYLKNuFwbzY9ab77zC
 nCIY6ioznYJF8V/G7S+UzV9UlSbLCP1cKt9v1MFMKNFLadWnrrFrxOnQmVC8Bw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Jerome Forissier
 <jerome.forissier@linaro.org>,  Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,  Mattijs Korpershoek
 <mkorpershoek@kernel.org>,  Michal Simek <michal.simek@amd.com>,  Ibai
 Erkiaga <ibai.erkiaga-elorza@amd.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de,  Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH 0/3] cmd: mtd: improvements
In-Reply-To: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu> (Mikhail
 Kshevetskiy's message of "Thu, 4 Sep 2025 17:50:20 +0300")
References: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 05 Sep 2025 16:13:11 +0200
Message-ID: <87y0qtkmx4.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 05 Sep 2025 17:52:17 +0200
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

On 04/09/2025 at 17:50:20 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> Some nand flashes (like spi-nand one) are registered with mtd
> subsystem only, thus nand command can't be used to work with
> such flashes. As result some functionality is missing.
>
> This patch series introduce following features:
>  * 'mtd markbad' command (clone of 'nand markbad')
>  * 'mtd nand_write_test' command (clone of 'nand torture')
>
> Also a new command 'mtd nand_read_test' introduced. It produce readonly
> test of flash. It's mostly usefull to:
>  * check general flash state,
>  * check the correctness of returned number of corrected bits.
>
> Mikhail Kshevetskiy (3):
>   cmd: mtd: add markbad command support
>   cmd: mtd: add nand_write_test command support
>   cmd: mtd: add nand_read_test command support

Nice!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l
