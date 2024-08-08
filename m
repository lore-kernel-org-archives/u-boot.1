Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3636C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 05:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422AE880A5;
	Thu,  8 Aug 2024 07:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wlwk9XNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117EA8811A; Thu,  8 Aug 2024 07:54:04 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A1187D0A
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 07:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4785ruYJ095703;
 Thu, 8 Aug 2024 00:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723096436;
 bh=mCSI6mBgPhq58cwJa1ay72PdX/ngB2+NcAOSOum3d3s=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wlwk9XNjWwgrvaDsulOqGgmz7645RZU/Ti1yX/+pVHveL+LuYci4xxkMuRniiun65
 v4tn2BJbdTshJsfKu7yQb+fhGEyg4IEwtjW64qPZGBvn8nF6QP1QsKRs6z66TnFcGM
 gTnCsp1uqmngeCQQ2rjeU6hdmLMhog4bqiXFozxw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4785rure029047
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 8 Aug 2024 00:53:56 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 00:53:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 00:53:55 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4785rr20120814;
 Thu, 8 Aug 2024 00:53:54 -0500
Message-ID: <e0dc0dfe-9ac5-46db-ac9a-0af036a7e60a@ti.com>
Date: Thu, 8 Aug 2024 11:23:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: keystone: Move to OF_UPSTREAM
To: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240807145651.52700-1-afd@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
Content-Language: en-US
In-Reply-To: <20240807145651.52700-1-afd@ti.com>
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

Hi Andrew

On 07/08/24 20:26, Andrew Davis wrote:
> Enable OF_UPSTREAM for Keystone boards. Remove DT files that
> are now available in dts/upstream.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm/dts/Makefile                         |   7 -
>   arch/arm/dts/keystone-clocks.dtsi             | 411 -----------------
>   arch/arm/dts/keystone-k2e-clocks.dtsi         |  74 ---
>   arch/arm/dts/keystone-k2e-evm-u-boot.dtsi     |  14 +-
>   arch/arm/dts/keystone-k2e-evm.dts             | 152 -------
>   arch/arm/dts/keystone-k2e-netcp.dtsi          | 203 ---------
>   arch/arm/dts/keystone-k2e.dtsi                | 144 ------
>   arch/arm/dts/keystone-k2g-evm-u-boot.dtsi     |  20 +-
>   arch/arm/dts/keystone-k2g-evm.dts             | 148 ------
>   arch/arm/dts/keystone-k2g-generic-u-boot.dtsi |  18 -
>   arch/arm/dts/keystone-k2g-generic.dts         |  27 --
>   arch/arm/dts/keystone-k2g-ice-u-boot.dtsi     |  15 +-
>   arch/arm/dts/keystone-k2g-ice.dts             | 118 -----
>   arch/arm/dts/keystone-k2g-netcp.dtsi          | 149 -------
>   arch/arm/dts/keystone-k2g.dtsi                | 258 -----------
>   arch/arm/dts/keystone-k2hk-clocks.dtsi        | 422 ------------------
>   arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi    |  26 +-
>   arch/arm/dts/keystone-k2hk-evm.dts            | 180 --------
>   arch/arm/dts/keystone-k2hk-netcp.dtsi         | 207 ---------
>   arch/arm/dts/keystone-k2hk.dtsi               | 111 -----
>   arch/arm/dts/keystone-k2l-clocks.dtsi         | 263 -----------
>   arch/arm/dts/keystone-k2l-evm-u-boot.dtsi     |  28 +-
>   arch/arm/dts/keystone-k2l-evm.dts             | 129 ------
>   arch/arm/dts/keystone-k2l-netcp.dtsi          | 187 --------
>   arch/arm/dts/keystone-k2l.dtsi                | 105 -----
>   arch/arm/dts/keystone.dtsi                    | 330 --------------
>   configs/k2e_evm_defconfig                     |   3 +-
>   configs/k2e_hs_evm_defconfig                  |   3 +-
>   configs/k2g_evm_defconfig                     |   5 +-
>   configs/k2g_hs_evm_defconfig                  |   5 +-
>   configs/k2hk_evm_defconfig                    |   3 +-
>   configs/k2hk_hs_evm_defconfig                 |   3 +-
>   configs/k2l_evm_defconfig                     |   3 +-
>   configs/k2l_hs_evm_defconfig                  |   3 +-
>   34 files changed, 98 insertions(+), 3676 deletions(-)
>   delete mode 100644 arch/arm/dts/keystone-clocks.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2e-clocks.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2e-evm.dts
>   delete mode 100644 arch/arm/dts/keystone-k2e-netcp.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2e.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2g-evm.dts
>   delete mode 100644 arch/arm/dts/keystone-k2g-generic-u-boot.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2g-generic.dts
>   delete mode 100644 arch/arm/dts/keystone-k2g-ice.dts
>   delete mode 100644 arch/arm/dts/keystone-k2g-netcp.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2g.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2hk-clocks.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2hk-evm.dts
>   delete mode 100644 arch/arm/dts/keystone-k2hk-netcp.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2hk.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2l-clocks.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2l-evm.dts
>   delete mode 100644 arch/arm/dts/keystone-k2l-netcp.dtsi
>   delete mode 100644 arch/arm/dts/keystone-k2l.dtsi
>   delete mode 100644 arch/arm/dts/keystone.dtsi


Acked-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
