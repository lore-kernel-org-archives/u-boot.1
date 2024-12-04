Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8A7E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 22:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7D189482;
	Wed,  4 Dec 2024 23:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Op3XFdvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D860A8947F; Wed,  4 Dec 2024 23:25:32 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8EB89482
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 23:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1C6095C70EF;
 Wed,  4 Dec 2024 22:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C07C4CECD;
 Wed,  4 Dec 2024 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733351128;
 bh=KkYPFC1mpw6Fozh4zA579wnyeO2CbgAmruP5bk/rSGI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Op3XFdvlL1ioC70eHFrqOkdH6v3YH8owbf0cARlVcjaubrurO6L0dM7BM3uGJ7XYh
 XhGj847+a7YWRu6N+xyGcQxET4PN6BNq0iN9QwNK/TDdP0KwDQ+nHhOuFiNucOCOHc
 hKx6y5aKCdhCScoqYGDSwRwKD65laqbLeUfQVD+yYWRidmNAFAXuPnkmqTu6lijIGV
 /fZL9cuHwmSzeTD2hCfnTamdES4R/CcbP4gZomAJwebHHOPndQ6yhNYf60ZCeiCGLa
 V/a3HEjml1rmOkUXPamS2SeIY45BcemkGvSSAjKuAfK+Fvu15ui8Zz9dYi7T48syrS
 JAQJtxpy0EyaA==
Message-ID: <61e1a5f9-0c9a-429c-944d-e1bbe808f60b@kernel.org>
Date: Thu, 5 Dec 2024 00:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: ti: am62ax: env: include environment for DFU
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, marex@denx.de, hnagalla@ti.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, jonas@kwiboo.se,
 j-humphreys@ti.com, nm@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <20241126120322.1760862-3-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241126120322.1760862-3-s-vadapalli@ti.com>
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



On 26/11/2024 14:03, Siddharth Vadapalli wrote:
> Include the TI K3 DFU environment to support DFU Boot and DFU Flash.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

