Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C8FC3DA6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 00:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143BB876FF;
	Thu,  4 Jan 2024 01:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aDFo2wP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6B987729; Thu,  4 Jan 2024 01:11:35 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A048767C
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 01:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 22B5561254;
 Thu,  4 Jan 2024 00:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF11C433C7;
 Thu,  4 Jan 2024 00:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704327091;
 bh=FVnLkp+lC5YchY+7IQkFupGJ+/28QBnreRLrXMvUCGk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aDFo2wP2hEspYa03CA3X/8uOdaAOdrf3YXkarUJI5EkAbli/jbYewN9g7mYV5HmmH
 agPuqbvxyGaRACwz3PAJyb8HhPJPWithaBwOkXWBRG/AJjRemEpOILM4g1Agcl+HKm
 j9EpEndi8OQdzYBCvN1ABsPjPCv7NQpn6mG3FFrSChRWeIZD4YXyhWl7ilgzHBcn2g
 qxq2t6g8DzWr4Jri4i2MitG5Tt0UTasXzBxJJNmSC4G5Ei1a+iy/dxy4LP0JpULg3B
 UVooQDIAs0fo5ME9VELYQhXZXeaNF0MtvXU4ZC1Xi9pcRIIJKgUlKvois9PN/sTsjN
 LO391lTDWryYw==
Received: (nullmailer pid 2095445 invoked by uid 1000);
 Thu, 04 Jan 2024 00:11:29 -0000
Date: Wed, 3 Jan 2024 17:11:29 -0700
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/6] dt-bindings: nvmem: layouts: add U-Boot
 environment variables layout
Message-ID: <20240104001129.GA2045237-robh@kernel.org>
References: <20231221173421.13737-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221173421.13737-1-zajec5@gmail.com>
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

On Thu, Dec 21, 2023 at 06:34:16PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot env data is a way of storing firmware variables. It's a format
> that can be used of top of various storage devices. Its binding should
> be an NVMEM layout instead of a standalone device.
> 
> This patch adds layout binding which allows using it on top of MTD NVMEM
> device as well as any other. At the same time it deprecates the old
> combined binding.

I don't understand the issue. From a DT perspective, there isn't. A 
partition is not a device, but is describing the layout of storage 
already.

Rob
