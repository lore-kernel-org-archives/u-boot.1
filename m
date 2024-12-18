Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21575E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791AB80269;
	Wed, 18 Dec 2024 14:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lLSkfEGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 824E280269; Wed, 18 Dec 2024 14:57:09 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6838022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D7150A42635;
 Wed, 18 Dec 2024 13:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650AFC4CECD;
 Wed, 18 Dec 2024 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734530226;
 bh=g47pGpzdqbwiJKxJHmFlGvcQGJeG8CMKJ8Uu7gERaTY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lLSkfEGI6SNDXxdG2qbxDmUfOeM7mn0KB+pEotawA3PQHZjLSL/JtsnujBDnhYEI5
 UgXg4DlGksRZkF+Z4rLCR6on+zQxIs5cZkByDmYAWLJqrRKsCCa+JtUfrBoPSZah/2
 vMI5J2r1HePmmELO29og7W0/Sune9deZWqGp56KwL+bVT8o+OdBOF/b4wl3dZN920m
 Y38EyU01XHtCozzWEGX5ZqsZJbDbPa6vH85+QAHe125wgqYMuu/l6uD11NVPhBOY03
 VD6hq5HTz2FV3UodrrJrVWiNnA7xDw7MaVjI/Uip+O7BQcJWBYstAQsjNk80ZdUCrJ
 XDPdPPPWjG1Xw==
Message-ID: <500abf30-5063-4f7e-9e6e-47c6d834ce75@kernel.org>
Date: Wed, 18 Dec 2024 15:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] configs: am62x_r5_usbdfu: extend for AM62Px
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com,
 mkorpershoek@baylibre.com, afd@ti.com, glaroque@baylibre.com,
 sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-3-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241218124542.3519447-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> Disable configs which are not required for USB DFU functionality, in
> order to allow reusing this fragment for AM62Px SoC.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

