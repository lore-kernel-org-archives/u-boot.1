Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B594C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 02:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E00686406;
	Mon, 28 Aug 2023 04:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DLo0juUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EAD786409; Mon, 28 Aug 2023 04:20:44 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76002863FF
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 04:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37S2KdCM104067;
 Sun, 27 Aug 2023 21:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693189239;
 bh=o3I0XCaQZOgvyBf2DxhJf8topUtt1JXZ+Dej8W5LE8k=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DLo0juUJOcJmfIFDdmRK7Xlspsfg9vSIyl7n/5qi09yWpeN0wGqtyyTw17ts163Eu
 0pavcljPbnpprCE8bmfowp57fMY6acqOJOAalxQTAPNWjvKXFHXzq/karpvIT0+C6D
 0y00qZGBRnzks4Myv9RI/ZQGLifOf3LrRofjqXSk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37S2KdHC027484
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Aug 2023 21:20:39 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Aug 2023 21:20:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Aug 2023 21:20:39 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37S2KZPp126204;
 Sun, 27 Aug 2023 21:20:36 -0500
Message-ID: <11ae1284-18ac-3f31-a026-6aed564b6209@ti.com>
Date: Mon, 28 Aug 2023 07:50:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/6] k3-am68: Sync from Linux tag v6.5-rc1
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Reid Tonking <reidt@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-4-a5f141be40bc@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-4-a5f141be40bc@ti.com>
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
> - Include k3-am68-sk-base-board.dts file
> 
>      Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
>      include k3-am68-sk-base-board.dts for Linux fixes to propagate
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
>   arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  69 ++---
>   arch/arm/dts/k3-am68-sk-base-board.dts         | 389 +++++++++++++++----------
>   arch/arm/dts/k3-am68-sk-r5-base-board.dts      | 143 ++-------
>   arch/arm/dts/k3-am68-sk-som.dtsi               | 112 ++-----
>   4 files changed, 300 insertions(+), 413 deletions(-)
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
