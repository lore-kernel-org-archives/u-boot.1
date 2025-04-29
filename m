Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1928C369CB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 05:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F303680BAD;
	Tue, 29 Apr 2025 07:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EuN8WqXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB7280EFB; Tue, 29 Apr 2025 07:00:22 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7459480AE1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 07:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53T50HiX3590015
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 00:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745902817;
 bh=NlybL0apSZrfnvgEY/evPR3IQgujYAEzvNenqMz3WFY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=EuN8WqXYFXQLNhooo37A4sFwvbDWAyCT0Pp0FH6elk20ZsGq2xcBrmClOLHoVa65L
 KCpmkFgGjYjvTrUEjGjnuuh0OMu3AeOfHZCZE1Qxdd3rgbpPGoXLIzgw2S7RNPLL57
 Yh/qJCVHK8KZlMa5bIgajf4dDTin3gznoNyJl4BU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53T50HNS043813
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Apr 2025 00:00:17 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Apr 2025 00:00:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Apr 2025 00:00:17 -0500
Received: from [10.249.136.157] ([10.249.136.157])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53T50E5r061163;
 Tue, 29 Apr 2025 00:00:14 -0500
Message-ID: <1f8fea08-fb5f-4953-8dad-ce0e65ccb4f1@ti.com>
Date: Tue, 29 Apr 2025 10:30:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3: binman: Fix DM firmware selection
To: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20250425225403.861034-1-afd@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250425225403.861034-1-afd@ti.com>
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

Hi Andrew

On 4/26/2025 4:24 AM, Andrew Davis wrote:
> Just like TF-A and OP-TEE, the documentation states a custom path for DM
> can be provided at build time by setting TI_DM. This should then set
> ti-dm-path which updates ti-dm node filenames in binman.
> 
> Two issues prevent this from functioning for most K3 boards. One is when
> then DM firmware name is inside a blob-ext node instead of a ti-dm node.
> 
> The second is when the filename in the ti-dm node is a pointer to a
> blob-ext node. In this case even though the filename is updated, the
> filename in the blob-ext is not, so build can fail if the default
> file in the blob-ext cannot be found, even if the updated ti-dm file
> does exist.
> 
> Fix both of these for all K3 by removing any indirect ti-dm nodes and
> making sure all DM nodes are labeled with "ti-dm".
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 11 ++-----
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 15 +++-------
>  arch/arm/dts/k3-am625-sk-binman.dtsi          | 14 +++------
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 11 ++-----
>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 14 +++------
>  arch/arm/dts/k3-am62a-sk-binman.dtsi          | 14 +++------
>  arch/arm/dts/k3-am62p-sk-binman.dtsi          | 11 ++-----
>  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi  | 12 ++------
>  arch/arm/dts/k3-am69-sk-u-boot.dtsi           | 29 +++++++++++++------
>  arch/arm/dts/k3-j7200-binman.dtsi             | 13 +++------
>  .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 11 ++-----
>  arch/arm/dts/k3-j721e-binman.dtsi             | 13 +++------
>  arch/arm/dts/k3-j721s2-binman.dtsi            | 13 +++------
>  arch/arm/dts/k3-j722s-binman.dtsi             | 12 ++------
>  arch/arm/dts/k3-j742s2-evm-u-boot.dtsi        | 29 +++++++++++++------
>  arch/arm/dts/k3-j784s4-binman.dtsi            |  8 ++---
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        | 29 +++++++++++++------
>  17 files changed, 104 insertions(+), 155 deletions(-)
> 

Tested on few J7 boards.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

