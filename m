Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD2AC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 08:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A6687FFB;
	Mon, 27 May 2024 10:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fbVj0A93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B6888297; Mon, 27 May 2024 10:59:03 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F81C87D74
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 960381BF206;
 Mon, 27 May 2024 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1716800336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVL47r0ASUK00/+0bucx4caeKGq7mXBNjRcrmje2znA=;
 b=fbVj0A93hL2tY6QjWBIhXyBj6ebEx95L27zY7tDYmAikL6P3r4nxdnedR8I1vpVsst/uKt
 JI/kKPqy35NkrDZvC3WkJ+eF+TYaS/x0AC+ZvSkD8yJ7a2BVR43AszuSvodLdlIpsnNKys
 AJzFrpph5GgytXQwnQowNdKdAec5B221WOuQ2WY4FTXtkSDWQKDOPWf8dwc9mu+PKBYc4r
 SpMEtR3Z576hjRUfUYQOCmd9vAp+pwEdK2bAb9ZbXll+2wLpZ1mj4MgEfGowgKCrKB3gr0
 SxZGSNo5QHdvYM4n577zqKi4/F+X4vgfb0+tIsBlxLU0YucsVcTOOsqAyR7ATg==
Date: Mon, 27 May 2024 10:58:53 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Eddie James
 <eajames@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] tpm-v2: add support for mapping algorithm names
 to algos
Message-ID: <20240527105853.4769f2aa@xps-13>
In-Reply-To: <20240525200049.3904124-1-tharvey@gateworks.com>
References: <20240525200049.3904124-1-tharvey@gateworks.com>
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

tharvey@gateworks.com wrote on Sat, 25 May 2024 13:00:48 -0700:

> replace tpm2_supported_algorithms with an array of structures
> relating algorithm names, to TCG id's, digest length and mask values.
>=20
> While at it fix the tpm2_algorithm_to_mask to return the proper value.
>=20
> Fixes: 97707f12fdab ("tpm: Support boot measurements")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Eddie James <eajames@linux.ibm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
