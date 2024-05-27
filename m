Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CD5C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 08:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C1E882AC;
	Mon, 27 May 2024 10:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KcQ9y/bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692FC882AC; Mon, 27 May 2024 10:59:14 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B39F87D74
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B767E20002;
 Mon, 27 May 2024 08:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1716800352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmXrZL7vxeXan5F91mhK7eB5xD970MSOlRhrB9rh6+U=;
 b=KcQ9y/bxQydcaex6gPPd/VCIYs328S9RVFzcJE0WqyOVFprIp/nchtKdyEOUfknkk2FOxK
 t7riFRd6TgPimIt2Q3i48897LciT3UXd0V9/xUyhqFFP3hsGH6ZcCezqnF8wN14S5/HjeR
 yj/YAyv8AIubl0sNTVuIfTVDOAx3vYlzeYz/GD/7bLQ2U2J02VQoIrIy9c0Am/Nz5v8iX7
 /vB3Vb0HzgC+MzWfsBUzmP/JyadrtXeBGWVyQ4oG21PUdUcRc/RUCeCZZs66MzVRS6+385
 PArtoUzPAlm+pfsrIIS7ZA3GmhrTHbiSRZTO8bxRAlLqn7+E384hX84RRBtRcg==
Date: Mon, 27 May 2024 10:59:10 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v5 2/2] tpm-v2: allow algorithm name to be configured
 for pcr_read and pcr_extend
Message-ID: <20240527105910.3bb425d1@xps-13>
In-Reply-To: <20240525200049.3904124-2-tharvey@gateworks.com>
References: <20240525200049.3904124-1-tharvey@gateworks.com>
 <20240525200049.3904124-2-tharvey@gateworks.com>
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

tharvey@gateworks.com wrote on Sat, 25 May 2024 13:00:49 -0700:

> For pcr_read and pcr_extend commands allow the digest algorithm to be
> specified by an additional argument. If not specified it will default to
> SHA256 for backwards compatibility.
>=20
> Additionally update test_tpm2.py for the changes in output in pcr_read
> which now shows the algo and algo length in the output.
>=20
> A follow-on to this could be to extend all PCR banks with the detected
> algo when the <digest_algo> argument is 'auto'.
>=20
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

LGTM,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
