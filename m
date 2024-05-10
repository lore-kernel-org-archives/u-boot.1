Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E01EC25B4F
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 09:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4390F88294;
	Fri, 10 May 2024 11:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aZ968wnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19D088361; Fri, 10 May 2024 11:55:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFED88287
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 11:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DE54761E89;
 Fri, 10 May 2024 09:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEC4C113CC;
 Fri, 10 May 2024 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715334921;
 bh=E4B1dMy+hklqx8U8zY1vOYqntigCnUUK0bDm7BWDqHU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aZ968wnB18rGET58wKKTBjc0rvSK04+gW5bHwQBa3TVfTwQM+LWW91DW9m+BXMdh8
 VVru8aK141pS7rx63W8+PYSkIIVbj28wXnaTN2JT9Xoij5UYtujdNhBQ01+5FO1uTw
 AI7JNirJiC3hOykq4joUco2EgbfMkwYfReRCLRssQSSvP8TGIkEO0oopzoq82DvJ5L
 k6dKZpnn2sMUUM2WDVlF1D8CYpSgerstc8kp46D10m4DSDg7wp3YwI1Ijs6Od96D+x
 3F2IXRgHaLDaaHNuuXJIXhanEPA0ka5ix4i4acqFsoOgI5z3WXDNrp7hUnjNZeUMSt
 WLEW93YAHXpIQ==
Message-ID: <9baa5ac5-8ce9-4aea-9a3d-ec1d68ea5505@kernel.org>
Date: Fri, 10 May 2024 12:55:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com,
 danishanwar@ti.com, u-boot@lists.denx.de
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
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

Tom,

On 25/04/2024 15:20, Roger Quadros wrote:
> Sync AM62 device tree files with Linux v6.9-rc5 and
> add in the missing bits in -u-boot.dtsi to get CPSW
> Ethernet working.
> 
> The last patch is marked [not-for-merge] as it is not yet
> applied to Linux device tree.
> 
> CI testing
> https://github.com/u-boot/u-boot/pull/527

While the checks have passed, there are some recent conflicts introduced

Conflicting files
arch/arm/dts/k3-am62-phycore-som.dtsi
arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts 

Those files have been removed.

Do you want me to rebase and resend this series?

> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> 
> ---
> Roger Quadros (3):
>       arm: dts: k3-am62*: sync with Linux v6.9-rc5
>       arm: dts: k3-am625-beagleplay: get CPSW Ethernet to work
>       [not-for-merge] arm: dts: k3-am625-beagleplay: Fix Ethernet PHY reset GPIO
> 
>  arch/arm/dts/k3-am62-main.dtsi               | 126 ++++++++++++++---
>  arch/arm/dts/k3-am62-mcu.dtsi                |   4 +-
>  arch/arm/dts/k3-am62-phycore-som.dtsi        |   5 +-
>  arch/arm/dts/k3-am62-thermal.dtsi            |   5 +-
>  arch/arm/dts/k3-am62-wakeup.dtsi             |  38 +++--
>  arch/arm/dts/k3-am62.dtsi                    |   4 +-
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  63 +++++++++
>  arch/arm/dts/k3-am625-beagleplay.dts         |  66 ++++-----
>  arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts  | 104 +++++++++++++-
>  arch/arm/dts/k3-am625-sk.dts                 |   4 +-
>  arch/arm/dts/k3-am625.dtsi                   |   4 +-
>  arch/arm/dts/k3-am62a-main.dtsi              | 201 +++++++++++++++++++++++++--
>  arch/arm/dts/k3-am62a-mcu.dtsi               |   4 +-
>  arch/arm/dts/k3-am62a-thermal.dtsi           |   5 +-
>  arch/arm/dts/k3-am62a-wakeup.dtsi            |   4 +-
>  arch/arm/dts/k3-am62a.dtsi                   |   4 +-
>  arch/arm/dts/k3-am62a7-sk.dts                | 162 ++++++++++++++++++++-
>  arch/arm/dts/k3-am62a7.dtsi                  |   4 +-
>  arch/arm/dts/k3-am62x-sk-common.dtsi         |  24 +++-
>  19 files changed, 722 insertions(+), 109 deletions(-)
> ---
> base-commit: 38ea74d6d5c05224acdb03f799897c1bdd56f8cc
> change-id: 20240305-for-2024-07-beagleplay-eth-f82a51197937
> 
> Best regards,

-- 
cheers,
-roger
