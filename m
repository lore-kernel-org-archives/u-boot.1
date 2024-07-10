Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F2BC3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 21:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6508862D;
	Wed, 10 Jul 2024 23:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pPZwmdAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B2D88717; Wed, 10 Jul 2024 23:27:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC34788126
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 23:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 194FB61B27;
 Wed, 10 Jul 2024 21:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EDCC32781;
 Wed, 10 Jul 2024 21:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720646818;
 bh=UyV9QbskN7z87S59wOHZ2z6ufUHkf36Y+JyJjuFAzSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pPZwmdACIM5CFKtV379ANRxnTOElJ/KOZO8aepw99FFFLmxpWtFWz1WrZ9AT64Oja
 07Wtlhw27CDzKBZMWvsaZNko9mwmH4NrjAdwxhc4OpAxPh5eMdr9Z4mrc5OgcMjhbP
 9fu/M+OZVbJ4x8b3bu2kbvmf/oqbJR4Tj9gxFDPomiN8EYJ2N4B9METkFfbbvcIWDe
 N9xoZRYzOxv1OHS7Xeb2kyo6x3OClcnBl+z2Wn37ZNKWk1PjpRgqGR9lMpArrcW2CD
 zeWKZPv+0ILdSC98Vpz7cNE0OEGJqDz+0/cbSuYKzKilHHT1gCt1pcBXwUDB1/f9ZG
 z8clcEP33kTyw==
Date: Wed, 10 Jul 2024 15:26:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Michael Walle <michael@walle.cc>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>, u-boot@lists.denx.de,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: convert U-Boot env to a layout
Message-ID: <172064681629.3804403.16986704276630415661.robh@kernel.org>
References: <20240705225821.13196-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705225821.13196-1-zajec5@gmail.com>
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


On Sat, 06 Jul 2024 00:58:21 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot environment variables can be stored in various data sources. MTD
> is just one of available options. Refactor DT binding into a layout so
> it can be used with UBI volumes and other NVMEM devices.
> 
> Link: https://lore.kernel.org/all/20231221173421.13737-1-zajec5@gmail.com/
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> I'm sending this PATCH without Linux changes to see if this is the
> right approach - for developers and (DT) maintainers to review it first.
> 
> My previous attempt (see above Link) turned out in refusal so I'm just
> trying to save some time in case this one goes wrong as well.
> 
> Hopefully the included example (which I really think we should add)
> explains well how I think this binding should be used with layouts.
> 
> If I get some positive feedback I'll work on V2 with actual Linux
> changes.
> 
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
>  .../nvmem/{ => layouts}/u-boot,env.yaml       | 39 ++++++++++++++++---
>  2 files changed, 35 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (75%)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

