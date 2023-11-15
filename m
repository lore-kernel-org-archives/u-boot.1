Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ED1C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A42D87206;
	Wed, 15 Nov 2023 16:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZuxHnV2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5929871FC; Wed, 15 Nov 2023 16:52:31 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B828744F
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AFFqNTw066625;
 Wed, 15 Nov 2023 09:52:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700063543;
 bh=Fgg201fccNi5wL2RPEg+uiOQG6a4zc5YHCYvmg/3hD4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZuxHnV2DXyFiVOLiSak8OqFQ6k/Z0cU6Pzg5Br95Ey+gsBFG7EeCUnMHEL60ONOmo
 ImpCX/7XIdgp735KEH7H8xFlL6dBStAOZ1sBJypC1hJo7OOmH10lKQOsK4Y/hkgx2Z
 f2jdcnka7bgSX/gqx15qut1yEctjlXZbWk+PHgBM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AFFqNo1009619
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Nov 2023 09:52:23 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 09:52:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 09:52:22 -0600
Received: from [10.250.33.185] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AFFqMg0059289;
 Wed, 15 Nov 2023 09:52:22 -0600
Message-ID: <1beed541-c7bd-4ed0-943f-c3695ee1db93@ti.com>
Date: Wed, 15 Nov 2023 09:52:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-*-binman: Move to using templated FITs
Content-Language: en-US
To: Neha Malcom Francis <n-francis@ti.com>, <sjg@chromium.org>,
 <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <kamlesh@ti.com>, <m-chawdhry@ti.com>, <mkorpershoek@baylibre.com>
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-3-n-francis@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231115101024.3441093-3-n-francis@ti.com>
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

On 11/15/23 4:10 AM, Neha Malcom Francis wrote:
> Reduce redundancy in code by using templates to generate the A72 boot
> binaries (tispl.bin and u-boot.img) as well as R5 boot binary sysfw.itb
> (for legacy boot following devices J721E and AM65x).
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/dts/k3-am625-sk-binman.dtsi          | 157 +--------
>   .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 155 +-------
>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 158 +--------
>   arch/arm/dts/k3-am64x-binman.dtsi             | 151 +-------
>   arch/arm/dts/k3-am65x-binman.dtsi             | 273 +-------------
>   arch/arm/dts/k3-j7200-binman.dtsi             | 159 +--------
>   arch/arm/dts/k3-j721e-binman.dtsi             | 332 +-----------------
>   arch/arm/dts/k3-j721s2-binman.dtsi            | 157 +--------
>   8 files changed, 54 insertions(+), 1488 deletions(-)

1488 deletions, nice!

Minor question, why was `ti-secure` not factored out of `dm` nodes like
it was for `atf`/`tee` nodes? Guessing it has to do with not all SoCs
needing this blob and signing nothing results in something, which
messes up the 0 size check when loading it, but it wasn't clear to me.

Anyway,

Acked-by: Andrew Davis <afd@ti.com>
