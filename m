Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B33AC7EE33
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 11:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C523088B5F;
	Thu, 29 Aug 2024 13:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="bgW8iRJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E083E88B88; Thu, 29 Aug 2024 13:35:53 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB04988B23
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 13:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C66C61FD28;
 Thu, 29 Aug 2024 13:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1724931351;
 bh=ErwoFUiq2QOLb8RI2+sqvQ7iSDCk6SR0hbefu0Bd8EY=; h=From:To:Subject;
 b=bgW8iRJA5mtlhL4k/VNDyWmK2QHIxc3LD4M6bzGgcCVyI78L8NmCJUM84pX991KHm
 iCz4u5cea/DtQRmKvc7oLJX+OAFxl/o8h8jV3GudX04WhNq8Sc/rIJMh04sX+fJqG4
 er7XYDxmvPC4VS7OM2xUO2DkaGsPoQjhzUpYkfI0O8+7ArwgJe/6/SiwAz2/X4ebtT
 ZXnwMgHkypvi2AOm9k+49h+5G6BRolqaIjWH3zgXSx1IseROGg7x1I6xM0iDlEaDxp
 Rkmm5SWDp7flqZG3kk2Bhb1BaDTTlBnFFiOLp5Yk798uzy1jY7eFoI2YkVqJbJ1Uf8
 aU5sR48Nkhk0w==
Date: Thu, 29 Aug 2024 13:35:46 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Rogerio Guerra Borin <rogerio.borin@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] configs: verdin-imx8m[mp]: set CONFIG_SPL_LOAD_FIT_ADDRESS
Message-ID: <20240829113546.GA29092@francesco-nb>
References: <20240829112357.22292-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829112357.22292-1-hiagofranco@gmail.com>
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

On Thu, Aug 29, 2024 at 08:23:57AM -0300, Hiago De Franco wrote:
> From: Rogerio Guerra Borin <rogerio.borin@toradex.com>
> 
> Set the CONFIG_SPL_LOAD_FIT_ADDRESS for both verdin-imx8mm and
> verdin-imx8mp configurations to specify the load address for FIT images
> loaded by the SPL.
> 
> As per lastest instructions from NXP, the generation of a HABv4 CSF
> (Command Sequence File) requires the U-Boot FIT image (u-boot.itb) load
> address to be set to a fixed value when binman is used. The address is
> defined by CONFIG_SPL_LOAD_FIT_ADDRESS.
> 
> Here we set CONFIG_SPL_LOAD_FIT_ADDRESS to an address 64MB past the
> start of the DDR memory leaving plenty of room for the various DDR-
> residing artifacts to be moved to their usual load addresses which are
> close to the start of the DDR.
> 
> Signed-off-by: Rogerio Guerra Borin <rogerio.borin@toradex.com>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

