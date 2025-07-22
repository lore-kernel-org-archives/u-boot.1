Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FDFC83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21AB38338D;
	Tue, 22 Jul 2025 10:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cTTf0Yba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18113833C6; Tue, 22 Jul 2025 10:55:10 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7476D83346
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56M8t5dZ1004448;
 Tue, 22 Jul 2025 03:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753174505;
 bh=HX9wyZFyWDpnGvDYM2ovz1UaW0Nph9irLr/feRXBBfs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cTTf0Yba82fc+miCFX118NZ6PD8pM/jH/vYTgL1+bAE1XqV0XoA4AC7n8zVrFkoFP
 piwxdDZ0wjCs4JPkYAxBSg5vjmDgMyR/dM65182U4MXNU31plNuQSJ1W3MQ7niImhw
 G4dOngLCPh4ui8VHfcdDeZMi/3it3BThfu9Q0104=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56M8t5rK3975637
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 22 Jul 2025 03:55:05 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 03:55:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 03:55:04 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56M8t2am1073874;
 Tue, 22 Jul 2025 03:55:02 -0500
Message-ID: <96ed68d2-95b6-43e8-8d23-bee2e35a0003@ti.com>
Date: Tue, 22 Jul 2025 14:25:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: k3: use SPL_TEXT_BASE for R5 SPL load address
To: Bryan Brattlof <bb@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Tom Rini
 <trini@konsulko.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
References: <20250717-dt-cleanup-v2-1-bbbd41cb0d81@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
Content-Language: en-US
In-Reply-To: <20250717-dt-cleanup-v2-1-bbbd41cb0d81@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Bryan

On 18/07/25 00:18, Bryan Brattlof wrote:
> The load address for the R5's SPL is defined in Kconfig by
> SPL_TEXT_BASE. Rather than hard coding the load address which could
> lead to hard to debug issues if this value is changed, just use the
> SPL_TEXT_BASE value.
> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
> Changes in v2:
> - Included j7200, j721s2 and j7842s to cleanup
> - Link to v1: https://lore.kernel.org/r/20250717-dt-cleanup-v1-1-a911b0bb832b@ti.com
> ---
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi      |  6 +++---
>  arch/arm/dts/k3-am625-sk-binman.dtsi               |  6 +++---
>  arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi  |  6 +++---
>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi      |  6 +++---
>  arch/arm/dts/k3-am62a-sk-binman.dtsi               |  6 +++---
>  arch/arm/dts/k3-am62p-sk-binman.dtsi               |  4 ++--
>  arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi |  4 ++--
>  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi       |  4 ++--
>  arch/arm/dts/k3-j7200-binman.dtsi                  | 10 +++++-----
>  arch/arm/dts/k3-j721s2-binman.dtsi                 |  6 +++---
>  arch/arm/dts/k3-j722s-binman.dtsi                  |  4 ++--
>  arch/arm/dts/k3-j784s4-binman.dtsi                 |  6 +++---
>  12 files changed, 34 insertions(+), 34 deletions(-)
> 

[...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
