Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB79D1CDC8
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 09:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A3988D9C;
	Tue, 22 Oct 2024 11:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g8zO09It";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1663088F50; Tue, 22 Oct 2024 11:22:16 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223AC88969
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49M9MBxe119204;
 Tue, 22 Oct 2024 04:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729588931;
 bh=nykxh34mesOL0hf6R9WeTdM0zEFqPWfSMXnoTDksZFM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=g8zO09ItlQ+fqnATKRafaQwWyHKL62YbgF/sp9lB5uXrXToBYiSNKGX96cgSZUen4
 LiEsPQCCxz/VVkTelZ4/wdnxHVTZ5Po6WRwNHT3D/JM131VFgNo6GkRuwm+nphlGJU
 JFTba86GREudbEBhn9w49YE2ze4+SEc4UAc4NDSo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49M9MB5a083362
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Oct 2024 04:22:11 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Oct 2024 04:22:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Oct 2024 04:22:10 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49M9M7m4114434;
 Tue, 22 Oct 2024 04:22:08 -0500
Message-ID: <9353d62b-128b-4814-a113-52959ba3c2ca@ti.com>
Date: Tue, 22 Oct 2024 14:52:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] arm: dts: k3-*-ddr: Add ss_cfg reg entry
To: Santhosh Kumar K <s-k6@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>, 
 <nm@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-9-s-k6@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241021044024.835846-9-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Santhosh

On 21/10/24 10:10, Santhosh Kumar K wrote:
> Add ss_cfg memory region which maps the DDRSS configuration region
> for the memory controller node.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/dts/k3-am62a-ddr.dtsi  |  7 ++++---
>   arch/arm/dts/k3-j721s2-ddr.dtsi | 12 ++++++++----
>   arch/arm/dts/k3-j784s4-ddr.dtsi | 24 ++++++++++++++++--------
>   3 files changed, 28 insertions(+), 15 deletions(-)
> 

Thank you for this series. Maybe I missed something, but why is this DT patch at 
the very end of the series? Doesn't it make sense to include it before the 
patches triggering inline ECC i.e. patch 7/8?

Sanity tested inline ECC on j784s4 and j721s2 and all looks good [1].

Tested-by: Neha Malcom Francis <n-francis@ti.com>

[1] https://gist.github.com/nehamalcom/66f1a2ef5288a94eebabe97708b5a277

-- 
Thanking You
Neha Malcom Francis
