Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10E0CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 10:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D32488225;
	Wed,  3 Apr 2024 12:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kgEhY6gE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDF188238; Wed,  3 Apr 2024 12:42:33 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE87878A1
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 12:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433AgHm0029962;
 Wed, 3 Apr 2024 05:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712140937;
 bh=U2K7PeIYsAMOMfUSjPvEFJqdUVUhbitLy4cs6JslT0I=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kgEhY6gE9tqKsig2aqNwT6tLZBuIoKrBicN5q15V9faLEqa5eBDxQn0cwSwaHIpyn
 OC66p4ApfPKCOkzzDK0kvcb5AV2nfXMoqpdbUJ9y3f7yvHShhYx5FkvogPsCmCXQ6A
 jU1YIKAd9OLlo85TI1vrWToh/BU/mKWVR/96pvbE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433AgHnU061750
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 05:42:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 05:42:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 05:42:17 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433AgAP4033606;
 Wed, 3 Apr 2024 05:42:10 -0500
Message-ID: <0db955bf-8668-484a-8429-7223f574d927@ti.com>
Date: Wed, 3 Apr 2024 16:12:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] verdin-am62: move verdin am62 to OF_UPSTREAM
To: Marcel Ziswiler <marcel@ziswiler.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>, Dhruva Gole
 <d-gole@ti.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Marek Vasut <marex@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey
 <tharvey@gateworks.com>, Wadim Egorov <w.egorov@phytec.de>
References: <20240403071518.400771-1-marcel@ziswiler.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240403071518.400771-1-marcel@ziswiler.com>
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

Hi Marcel,

On 03/04/24 12:45, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Move verdin-am62 to OF_UPSTREAM:
> - handle the fact that dtbs now have a 'ti/' prefix
> - imply OF_UPSTREAM
> - remove redundant files from arch/arm/dts leaving only the
>    *-u-boot.dtsi files
> - update MAINTAINERS file
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>   arch/arm/dts/Makefile                         |    1 -
>   arch/arm/dts/k3-am62-verdin-dev.dtsi          |  240 ---
>   arch/arm/dts/k3-am62-verdin-wifi.dtsi         |   45 -
>   arch/arm/dts/k3-am62-verdin.dtsi              | 1443 -----------------
>   .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  |    2 +-
>   arch/arm/dts/k3-am625-verdin-wifi-dev.dts     |   22 -
>   arch/arm/mach-k3/am62x/Kconfig                |    1 +
>   board/toradex/verdin-am62/MAINTAINERS         |    4 -
>   configs/verdin-am62_a53_defconfig             |    2 +-
>   9 files changed, 3 insertions(+), 1757 deletions(-)
>   delete mode 100644 arch/arm/dts/k3-am62-verdin-dev.dtsi
>   delete mode 100644 arch/arm/dts/k3-am62-verdin-wifi.dtsi
>   delete mode 100644 arch/arm/dts/k3-am62-verdin.dtsi
>   delete mode 100644 arch/arm/dts/k3-am625-verdin-wifi-dev.dts
> 

[...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
