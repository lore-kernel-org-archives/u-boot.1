Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA29E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB7080241;
	Wed, 18 Dec 2024 14:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="is7Jv/vI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C84C80269; Wed, 18 Dec 2024 14:42:36 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32EC8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIDgUQT160876
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 18 Dec 2024 07:42:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734529350;
 bh=L7OdqGavzDU0sbFdVLikDVLhaZKleZl3iBt25ZFOm64=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=is7Jv/vII+s4otgABqTWn6GhQiMTQMBCAdnAkKiRww5gwdJNd4i+R8QGPI/rHIkuI
 /NYuN6fon5ZcTI0tBQY+IIvDvJf/+iK+afp1P6F8L+LVLtuoqk9UrxHP7w0cvYG0fC
 vKZqRU3nS0BchP9YDh65e2PgK7DTotp17qfukFUs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDgUcO076154;
 Wed, 18 Dec 2024 07:42:30 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 07:42:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 07:42:29 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDgQuY067147;
 Wed, 18 Dec 2024 07:42:26 -0600
Message-ID: <8870aa42-c83b-4805-8758-fcc68cfc9489@ti.com>
Date: Wed, 18 Dec 2024 19:12:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Fix OSPI boot for J722S
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>, <u-kumar1@ti.com>
References: <20241218131341.2073823-1-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241218131341.2073823-1-p-mantena@ti.com>
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


On 12/18/2024 6:43 PM, Prasanth Babu Mantena wrote:
> This series fixes OSPI boot for J722S. It contains fixes for DMSC
> communication, R5 regmap for ospi and dma specific overrides for ospi.
>
> Test log: https://gist.github.com/PrasanthBabuMantena/ad469dd09ab7263f85f87dadda46c86d
>
> v2 <==> v1
> * Add Fixes tag wherever required.
> * Improve commit message.


For series

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>
> Vaishnav Achath (4):
>    mailbox: k3-sec-proxy: Add DM to DMSC communication thread for J722S
>    arm: dts: k3-j722s-r5-evm: Fix DM2TIFS secproxy thread ID
>    arm: mach-k3: j722_spl: Add FAST XSPI boot mode
>    arm: dts: k3-j722s*: Add overrides specific to OSPI
>
>   arch/arm/dts/k3-j722s-evm-u-boot.dtsi     |  4 ++++
>   arch/arm/dts/k3-j722s-r5-evm.dts          | 17 +++++++++++++++--
>   arch/arm/mach-k3/include/mach/j722s_spl.h |  1 +
>   arch/arm/mach-k3/j722s/j722s_init.c       |  2 ++
>   drivers/mailbox/k3-sec-proxy.c            |  2 +-
>   5 files changed, 23 insertions(+), 3 deletions(-)
>
