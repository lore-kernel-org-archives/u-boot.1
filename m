Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2FFE810D9
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1226C86BE2;
	Wed, 27 Sep 2023 14:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tAd4B72s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2566486C96; Wed, 27 Sep 2023 14:21:41 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB70E86A0A
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 14:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RCLXfw043902;
 Wed, 27 Sep 2023 07:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695817293;
 bh=YZ/9n7rYyp+IiXda6JdAjieaKTZ2+yrTSxn+R/TRrJs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tAd4B72sOZ8CRmUfwcZexUb1PCMOPagZtsXL7XOwv8fItI2bRL/yC4y8cuH9yoVTx
 xmamTznjSSTTES3e93Fp6El/QGIHR2S9yPyOgSfEvsOEv9TBPI8Ersoc/umO8PEash
 bYph+Ulu25C2Tg6qLj3hUj7+y3Q/ePUHeZY7WdQI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RCLXHD102743
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 07:21:33 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 07:21:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 07:21:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RCLWhc047344;
 Wed, 27 Sep 2023 07:21:32 -0500
Date: Wed, 27 Sep 2023 07:21:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <bb@ti.com>, <afd@ti.com>, <srk@ti.com>, <r-gunasekaran@ti.com>,
 <praneeth@ti.com>
Subject: Re: [PATCH 0/2] arm: dts: k3-am64: Sync dts from Linux v6.6-rc1
Message-ID: <20230927122132.ybtwmpqo3mch6ti3@fountain>
References: <20230927120148.75088-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230927120148.75088-1-rogerq@kernel.org>
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

On 15:01-20230927, Roger Quadros wrote:
> Hi,
> 
> This series aligns the dts files for AM64 platform from Linux v6.6-rc1.
> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>   Revert "ARM: dts: k3-am642-sk-u-boot: add PMIC node"
>   arm: dts: k3-am64: Bump dts from Linux v6.6-rc1
> 
>  arch/arm/dts/k3-am64-main.dtsi        | 209 ++++++++++++++++++++++----
>  arch/arm/dts/k3-am64-mcu.dtsi         |  53 ++++++-
>  arch/arm/dts/k3-am64-thermal.dtsi     |  33 ++++
>  arch/arm/dts/k3-am64.dtsi             |  22 +--
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi |  70 +++++----
>  arch/arm/dts/k3-am642-evm.dts         | 177 +++++++++++++++++-----
>  arch/arm/dts/k3-am642-r5-evm.dts      | 194 ++----------------------
>  arch/arm/dts/k3-am642-r5-sk.dts       | 194 +-----------------------
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 122 ++++-----------
>  arch/arm/dts/k3-am642-sk.dts          | 174 +++++++++++++++------
>  arch/arm/dts/k3-am642.dtsi            |   1 +
>  arch/arm/dts/k3-serdes.h              | 204 +++++++++++++++++++++++++
>  12 files changed, 815 insertions(+), 638 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am64-thermal.dtsi
>  create mode 100644 arch/arm/dts/k3-serdes.h
> 
> 
> base-commit: 4cb31a9f3560b293670de95e76c1f3cf2f9e1ca8
> -- 
> 2.34.1
> 

https://lore.kernel.org/u-boot/20230911144401.1011354-1-nm@ti.com/
https://github.com/u-boot/u-boot/commits/next?after=90c81f407dd4a7747385b10f9b8f732202c45cde+104&branch=next&qualified_name=refs%2Fheads%2Fnext

Can you send delta patches based off u-boot next?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
