Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682D3C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 06:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE4881F66;
	Fri, 27 Jun 2025 08:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k0dbFhwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC7682B34; Fri, 27 Jun 2025 08:04:29 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4133280C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 08:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55R64Iah2645140;
 Fri, 27 Jun 2025 01:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751004259;
 bh=7VJEGIcUm8qxtadtXn8VqN5/EOyF/lZ/KLCQGRYax1c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=k0dbFhwqwAhdzbhI9gbbj2i7F2H4IclKF/jgD+ffUx8mcfxhjnHHmkjrvsFAg4qtk
 SJ2GtOi4rzux0DK8EkUiq9IVeql50Foe1tUs4/RcwfzNG1KyVJBSVL586vP/jKl/3u
 wDreVH0iSVXpfy09N65ffLWQhEbH4Av/3p1XG7y4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55R64IPi123614
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 27 Jun 2025 01:04:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 01:04:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 01:04:18 -0500
Received: from [172.24.227.4] (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55R64DaL2306277;
 Fri, 27 Jun 2025 01:04:14 -0500
Message-ID: <227f10db-c584-4ada-828f-f44f72560b8b@ti.com>
Date: Fri, 27 Jun 2025 11:34:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] Add TI K3 PCIe Endpoint Controller
 support for AM64X
To: Tom Rini <trini@konsulko.com>, <vigneshr@ti.com>, <rfried.dev@gmail.com>, 
 <jm@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>, <afd@ti.com>,
 <sjg@chromium.org>, <danishanwar@ti.com>, <anshuld@ti.com>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <s-vadapalli@ti.com>, "Govindarajan,
 Sriramakrishnan" <srk@ti.com>
References: <20250616164929.631791-1-h-salunke@ti.com>
 <175098661987.1928306.16153229800176946154.b4-ty@konsulko.com>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <175098661987.1928306.16153229800176946154.b4-ty@konsulko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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



On 27/06/25 06:40, Tom Rini wrote:
> On Mon, 16 Jun 2025 22: 19: 27 +0530, Hrushikesh Salunke wrote: > This 
> series adds support for the Endpoint mode on Cadence PCIe controller > 
> on TI's K3 family of SoCs. The driver is an adaptation of the Linux > 
> driver (drivers/pci/controller/cadence/pci-j721e. c)
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!u3dqPfcvd0wb6sZFHdNgHD_5IYxHC6X6-ZdM_RF6PaZkyeEkWwferth2j24zfrLAu8SOfQrJ0Qwh3AuoqVc-unAZfLSYds3hJogsvDXuFgzmH2lV$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Mon, 16 Jun 2025 22:19:27 +0530, Hrushikesh Salunke wrote:
> 
>> This series adds support for the Endpoint mode on Cadence PCIe controller
>> on TI's K3 family of SoCs. The driver is an adaptation of the Linux
>> driver (drivers/pci/controller/cadence/pci-j721e.c) and has been
>> implemented specifically for Endpoint mode of operation on AM64X. A minor
>> set of changes will be sufficient to support other K3 SoCs as well.
>> 
>> This patch is tested on AM64X EVM. Following are the log corresponding
>> to this feature.
>> 
>> [...]
> 
> Applied to u-boot/next, thanks!
> 

The driver includes header file "pcie-cadence.h" as
#include <pcie-cadence.h>

But this header file is not in standard inclusion path
so this needs to be changed to following to avoid build
issues especially on older compilers (GCC 11.x)

#include "pcie-cadence.h"

I have posted the patch for this fix.

https://patchwork.ozlabs.org/project/uboot/patch/20250627055546.3706770-1-h-salunke@ti.com/

> [1/2] pci_endpoint: Add TI K3 Cadence PCIe Endpoint Controller driver
>        commit: a4a0edc6046dd5b9ebe24ad72dfcdb43b36f0bd6
> [2/2] configs: am64x_evm_a53_defconfig: Enable configs for PCI Endpoint mode
>        commit: 7d70986071ea32b2d496ecfc4f9621e454dc1b75
> -- 
> Tom
> 
> 
