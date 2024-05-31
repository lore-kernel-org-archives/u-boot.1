Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68985C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6AE881BC;
	Fri, 31 May 2024 16:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4557C8816D; Fri, 31 May 2024 16:44:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BDA13881BC
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5802A1424;
 Fri, 31 May 2024 07:44:46 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D89A53F641;
 Fri, 31 May 2024 07:44:20 -0700 (PDT)
Date: Fri, 31 May 2024 15:44:18 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Tobias Schramm <t.schramm@manjaro.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH 0/2] sunxi: add support for Ethernet on V3s-based SoCs
Message-ID: <20240531154418.437fef06@donnerap.manchester.arm.com>
In-Reply-To: <20240531143350.14855-1-t.schramm@manjaro.org>
References: <20240531143350.14855-1-t.schramm@manjaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 31 May 2024 16:33:48 +0200
Tobias Schramm <t.schramm@manjaro.org> wrote:

Hi Tobias,

> This patchset adds support for Ethernet on V3s-based SoCs, adding in
> required clock gates, resets to the CCU driver and finally a matching
> configuration for the sun8i_emac driver.

Michael already sent identical patches two weeks ago. I reviewed them
already, and they are just waiting for the merge window to open.

https://lore.kernel.org/u-boot/20240513205609.1872861-1-mwalle@kernel.org/

Cheers,
Andre

> 
> Tobias Schramm (2):
>   clk: sunxi: support Ethernet clock gates and resets on V3s-based SoCs
>   net: sun8i_emac: add support for EMAC on V3s-based SoCs
> 
>  drivers/clk/sunxi/clk_v3s.c | 6 ++++++
>  drivers/net/sun8i_emac.c    | 7 +++++++
>  2 files changed, 13 insertions(+)
> 

