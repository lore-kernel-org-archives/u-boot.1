Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A229C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB52287933;
	Thu,  4 Jan 2024 16:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IveUNarC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26D787976; Thu,  4 Jan 2024 16:46:20 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D7287805
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregkh@linuxfoundation.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id C51F6B81A4A;
 Thu,  4 Jan 2024 15:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F095C433C9;
 Thu,  4 Jan 2024 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1704383177;
 bh=SfZbR38GEcgJBvCINBMSek/E8wPgRnRG8ktuyVrX3zQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IveUNarCqW/WK/8Gk5NEKAQVJAt7LI3pmLVBOPmtCgUAUkU72rXXr29d8Yqn28wQ1
 vA16eeqmAhjiBrrO4iFDP0X/daoMm8Qttz4qBoqex04PAfTjpwLL0Aq/gPcV9LNetX
 IIDC7o4DtIGWqenWBYGChQgZSp+95PDVJQKSK00k=
Date: Thu, 4 Jan 2024 16:46:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 6/6] nvmem: layouts: add U-Boot env layout
Message-ID: <2024010446-willfully-swoop-8510@gregkh>
References: <20231221173421.13737-1-zajec5@gmail.com>
 <20231221173421.13737-6-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221173421.13737-6-zajec5@gmail.com>
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

On Thu, Dec 21, 2023 at 06:34:21PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Move all generic (NVMEM devices independent) code from NVMEM device
> driver to NVMEM layout driver. Then add a simple NVMEM layout code on
> top of it.
> 
> Thanks to proper layout it's possible to support U-Boot env data stored
> on any kind of NVMEM device.
> 
> For backward compatibility with old DT bindings we need to keep old
> NVMEM device driver functional. To avoid code duplication export and
> reuse a parsing function.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> V2: Support new compatibles & use device_get_match_data() helper
> V3: Use imperative in commit body
> 
> IMPORTANT:
> This is based on top of the:
> [PATCH v6.8 1/2] nvmem: layouts: refactor .add_cells() callback arguments

I applied patches 2-5 in this series, I'll let you rebase the remaining
two after addressing the issues discussed in patch 1.

thanks,

gre gk-h
