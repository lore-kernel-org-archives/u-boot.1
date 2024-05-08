Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59923C19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 10:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8021886E9;
	Wed,  8 May 2024 12:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TxgtVzX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E84048843F; Wed,  8 May 2024 12:24:17 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50FE886E9
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 12:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 448AOC0D029050;
 Wed, 8 May 2024 05:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715163852;
 bh=FLfNyoa4+j/h5QY1W6QF5buWXHmBoOrgQv+7poHBs0A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TxgtVzX9Jv2LUiYyD2vkHWNIw5IhAycAj/bDY2VUkZS3r84X5IJdhsqnNtSMroyqf
 Ob2WR1+gjv0o8RGKfl1zdz6dM1+f5QUMI4UBBMuJtZimDO6r45BUslBI66M3gAGtQ4
 EHypxrmxpW9AZWHSfqW26sQ9O6hRkIgjop6VNXXA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 448AOCEC123842
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 May 2024 05:24:12 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 05:24:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 05:24:11 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 448AO8W2002624;
 Wed, 8 May 2024 05:24:09 -0500
Message-ID: <1fa4b6a2-edda-46f0-a10d-8a9cfd63cf94@ti.com>
Date: Wed, 8 May 2024 15:54:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] configs: am68_sk: Move to separate defconfig for AM68
 SK board
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>
References: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
 <20240508-b4-upstream-j721s2-of-upstream-v1-3-ed0933172410@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240508-b4-upstream-j721s2-of-upstream-v1-3-ed0933172410@ti.com>
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

On 08/05/24 12:56, Manorit Chawdhry wrote:
> Add defconfig for AM68 SK R5 and A72 configuration.
> 
> This includes and modifies the AM68 EVM defconfigs:
> j721s2_evm_r5_defconfig -> am68_sk_r5_defconfig
> j721s2_evm_a72_defconfig -> am68_sk_a72_defconfig
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi | 23 +++++++
>   arch/arm/dts/k3-j721s2-binman.dtsi             | 89 +-------------------------
>   board/ti/j721s2/MAINTAINERS                    |  2 +
>   configs/am68_sk_a72_defconfig                  | 10 +++
>   configs/am68_sk_r5_defconfig                   | 10 +++
>   configs/j721s2_evm_a72_defconfig               |  2 +-
>   configs/j721s2_evm_r5_defconfig                |  2 +-
>   7 files changed, 49 insertions(+), 89 deletions(-)
> 
> 

This looks good to me.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
