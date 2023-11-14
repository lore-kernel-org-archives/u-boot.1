Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6048EC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 03:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37383870DE;
	Tue, 14 Nov 2023 04:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i9V9Qv59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D4B8709A; Tue, 14 Nov 2023 04:25:43 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218C9870DE
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AE3PVCU090141;
 Mon, 13 Nov 2023 21:25:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699932331;
 bh=LK5sSzyn7Q0ualk7/4LywSQ510xAJw2IBDUBxiVMVP8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=i9V9Qv59WOMsPaHXMEUZ4YMsPd2b86Pk72LoI4z/7ESQH8UbPjCh9WRhVJGYAsd1v
 LYQxGmC1YLG6O9KfJ11KTtFfQwC32g0TSB5HBzsa0AGUYububOTwlLmyAnrqbUIrBe
 OUPSxVRaA1ENGDSUruYTBCAv6Ja32GmlULnRfea8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AE3PVGw023144
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 21:25:31 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 21:25:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 21:25:30 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AE3PUET010031;
 Mon, 13 Nov 2023 21:25:30 -0600
Date: Tue, 14 Nov 2023 08:55:29 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Tom Rini
 <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>, <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Sjoerd Simons
 <sjoerd@collabora.com>, Robert Nelson <robertcnelson@gmail.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 0/4] arm: dts: k3-am625*: Upgrade kernel dts to v6.7-rc1
Message-ID: <20231114032529.7n46psjgopm44u5b@dhruva>
References: <20231113145919.1928812-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231113145919.1928812-1-nm@ti.com>
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

Hi,

On Nov 13, 2023 at 08:59:15 -0600, Nishanth Menon wrote:
> Hi,
> 
> Sync Device tree to kernel v6.7-rc1 - we are getting closer to
> clean u-boot integration now.
> 
> Boot logs:
> https://gist.github.com/nmenon/d62c4795c6d3d40c83ba36d1cd047c42
> 
> WARNING: This will have  a minor conflict (binman) with:
> https://lore.kernel.org/u-boot/20231104080137.9628-1-nm@ti.com/
> 
> I haven't had a chance to test this out on verdin (only build tested)
> - so will be nice to verify.
> 
> Nishanth Menon (4):
>   arm: dts: k3-am625*: Sync with kernel v6.7-rc1
>   arm: dts: k3-am625: Drop SoC provided bootph params from board
>     u-boot/r5 dtsi
>   arm: dts: k3-am625-beagleplay-u-boot: drop duplicate bootph-nodes
>   arm: dts: k3-am625-sk-r5/u-boot: Drop duplicate bootph-nodes

boot tested these patches on SK-AM62x:

...
U-Boot SPL 2024.01-rc2-00087-g38667965389d (Nov 14 2023 - 08:38:39
+0530)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.1--v09.01.01 (Kool Koala)')
SPL initial stack usage: 13368 bytes

Trying to boot from UART
CLoaded 777811 bytes
Starting ATF on ARM64 core...

NOTICE:  BL31: v2.9(release):v2.9.0-792-g2899ad392225-dirty
NOTICE:  BL31: Built : 17:56:37, Oct 26 2023

U-Boot SPL 2024.01-rc2-00087-g38667965389d (Nov 14 2023 - 08:38:54
+0530)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.1--v09.01.01 (Kool Koala)')
SPL initial stack usage: 1872 bytes
Trying to boot from UART
CLoaded 727547 bytes


U-Boot 2024.01-rc2-00087-g38667965389d (Nov 14 2023 - 08:38:54 +0530)

SoC:   AM62X SR1.0 HS-FS
Model: Texas Instruments AM625 SK
DRAM:  2 GiB
Core:  57 devices, 23 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1
Loading Environment from nowhere... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Net:   eth0: ethernet@8000000port@1
Hit any key to stop autoboot:  2  0 
=> 
=>  
=>  
=>  
=> version
U-Boot 2024.01-rc2-00087-g38667965389d (Nov 14 2023 - 08:38:54 +0530)

aarch64-none-linux-gnu-gcc (Arm GNU Toolchain 12.3.Rel1 (Build
arm-12.35)) 12.3.1 20230626
GNU ld (Arm GNU Toolchain 12.3.Rel1 (Build arm-12.35)) 2.40.0.20230627
=> 
...

Tested-by: Dhruva Gole <d-gole@ti.com>

> 
>  arch/arm/dts/k3-am62-main.dtsi                |  12 +-
>  arch/arm/dts/k3-am62-mcu.dtsi                 |   2 +
>  arch/arm/dts/k3-am62-verdin-wifi.dtsi         |   6 +
>  arch/arm/dts/k3-am62-verdin.dtsi              |   1 +
>  arch/arm/dts/k3-am62-wakeup.dtsi              |   2 +
>  arch/arm/dts/k3-am62.dtsi                     |   3 +
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 110 -------------
>  arch/arm/dts/k3-am625-beagleplay.dts          |  34 +++-
>  arch/arm/dts/k3-am625-r5-beagleplay.dts       |   9 --
>  arch/arm/dts/k3-am625-r5-sk.dts               |  21 +--
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi          | 145 ------------------
>  arch/arm/dts/k3-am625-sk.dts                  |  27 ++++
>  arch/arm/dts/k3-am625-verdin-r5.dts           |   9 --
>  .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  55 +------
>  arch/arm/dts/k3-am62x-sk-common.dtsi          | 109 ++++++++++++-
>  15 files changed, 197 insertions(+), 348 deletions(-)
> 
> -- 
> 2.40.0
> 
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
