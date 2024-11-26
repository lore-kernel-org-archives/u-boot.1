Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588A1D3B98F
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 13:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF62F89748;
	Tue, 26 Nov 2024 14:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K0h/CRHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D377289A51; Tue, 26 Nov 2024 14:51:48 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3E8895F4
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 14:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQDph70118747;
 Tue, 26 Nov 2024 07:51:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732629103;
 bh=TJ6KFVfjtzNapNhsGc7Z3wGz5TDELvmomfn67C4aooU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=K0h/CRHtwbDr7JTaoxS2XV27rqmPzS/zUHXHO0guHQTJEldYFsMfjAwqXs34/XZLa
 iG8f8TKdHTmlnLtVqMM+slboOoY3EYqMSyTZdwoQfP11nD3eLiMu1YqmDbTUYHbfA4
 BDH9FIEy/RjqPKXYqVoyGE1A/dfqPzfBHLuXkA9Y=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQDpgBj007848
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Nov 2024 07:51:43 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 07:51:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 07:51:42 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQDpchZ037977;
 Tue, 26 Nov 2024 07:51:39 -0600
Message-ID: <b42b43b5-0728-8de2-a2d3-ea0e40b1baf3@ti.com>
Date: Tue, 26 Nov 2024 19:21:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] Add QOS support for J722S and AM62P
Content-Language: en-US
To: Jayesh Choudhary <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <vaishnav.a@ti.com>, <afd@ti.com>, <n-francis@ti.com>, <seanga2@gmail.com>,
 <francesco.dolcini@toradex.com>, <sjg@chromium.org>, <w.egorov@phytec.de>
References: <20241126070614.47136-1-j-choudhary@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20241126070614.47136-1-j-choudhary@ti.com>
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

On 26/11/24 12:36, Jayesh Choudhary wrote:
> Add QOS support for DSS in TI K3 SoC to route the DSS traffic through
> RT queue by setting orderID as 15:
> - J722S
> - AM62P
> 
> Changelog v1->v2:
> - Rebased on the tip of next branch
> - Corrected the commit message in patch 2/4
> 
> v1:
> <https://lore.kernel.org/all/20241106063930.59870-1-j-choudhary@ti.com/>
> 
> Jayesh Choudhary (4):
>   arm: mach-k3: j722s: Add QoS support for DSS
>   arm: mach-k3: am62p: Add QoS support for DSS
>   configs: j722s_evm_r5_defconfig: Enable CONFIG_K3_QOS
>   configs: am62p_evm_r5_defconfig: Enable CONFIG_K3_QOS
> 

For the series,
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
