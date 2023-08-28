Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F47C83F10
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 02:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6F786406;
	Mon, 28 Aug 2023 04:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DBOxdCzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7774B86412; Mon, 28 Aug 2023 04:16:49 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A78F2863FF
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 04:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37S2GjJL102615;
 Sun, 27 Aug 2023 21:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693189005;
 bh=a3sRaZ7fv/7otcaL8dy6wbBReZEk3hv8tNPPuGIpK8I=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DBOxdCzBekSDkEDgNkrI2qzOJJ264IUvHmMtBDOFX2H3U3j4j/GcICWT3AvJu9FgI
 qrINdLaBK6DWpkLQWYwB9FgU9v7/MdmpDyXOWGv+5GRacNWq3L30v5KHGyhQvd5bag
 BjelUDiVAA5Z9e8EOR20XOhLHLMWqKUfuY4G4G9o=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37S2GiQJ018226
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Aug 2023 21:16:45 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Aug 2023 21:16:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Aug 2023 21:16:43 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37S2Ge8G123463;
 Sun, 27 Aug 2023 21:16:41 -0500
Message-ID: <fa7c853e-dbdd-a07f-f52f-014b40c986c7@ti.com>
Date: Mon, 28 Aug 2023 07:46:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/6] k3-j721s2: Sync from Linux tag v6.5-rc1
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Reid Tonking <reidt@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-3-a5f141be40bc@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-3-a5f141be40bc@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Manorit

On 25/08/23 16:47, Manorit Chawdhry wrote:
> The following commit syncs the device tree from Linux tag
> v6.5-rc1 to U-boot and fixes the following to be compatible with
> the future syncs -
> 
> - Include k3-j721s2-common-proc-board.dts file
> 
>      Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
>      include k3-j721s2-common-proc-board.dts for Linux fixes to propagate
>      to U-boot.
> 
> - Fixing the mcu_timer0
> 
>      Remove timer0 and use the mcu_timer0 defined in mcu-wakeup.dtsi
> 
>      The device manager is not functional at this point so we can't
>      configure the clocks for the mcu_timer0, delete the properties
>      that enable the clocks and power domains for it.
> 
> - Fixing secure proxy nodes
> 
>      Linux DT now have these nodes defined so remove them and rename to
>      use the Linux DT ones.
> 
> - Remove cpsw node
> 
>      The compatible is now fixed and the node is not required in
>      -u-boot specifically
> 
> - Remove aliases and chosen node
> 
>      Use these from Linux and don't override when not required.
> 
> - Remove /delete-property/ from sdhci nodes
> 
>      We have the necessary clock and dev data so remove these.
> 
> - Remove dummy_clocks and fs_loader0
> 
>      These weren't being used anywhere so remove it.
> 
> All these have been put in a single commit to not break the
> bisectability.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  60 +--
>   arch/arm/dts/k3-j721s2-common-proc-board.dts       | 330 ++++++------
>   arch/arm/dts/k3-j721s2-main.dtsi                   | 585 ++++++++++++++++++++-
>   arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             | 365 ++++++++++++-
>   arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    | 151 +-----
>   arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 165 +++---
>   arch/arm/dts/k3-j721s2-thermal.dtsi                | 101 ++++
>   arch/arm/dts/k3-j721s2.dtsi                        |  12 +-
>   8 files changed, 1339 insertions(+), 430 deletions(-)
> 

This LGTM,
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
