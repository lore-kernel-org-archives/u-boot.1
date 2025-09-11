Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08BACAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 14:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4167C833AD;
	Thu, 11 Sep 2025 16:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wwyjanjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9EC833BF; Thu, 11 Sep 2025 16:45:42 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73EB18334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 16:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BEjaj1313633;
 Thu, 11 Sep 2025 09:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757601936;
 bh=bJj4ZlXxO+fDBCkeNHPJxORlWhlyVbq74/RxEmqjHdo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wwyjanjwmcVeCLO6woj1UWa1AOpVhPQIerG+tFa/ELfEOqV3+LSBT7jAxy011FBBw
 vW3M+ABu/TioJ4kYOXk5pBcMqXT+wK2IRtS6gzlM02SENihHytV88+F8SL6DSIIIVa
 XnEQw0QQlleNWLiYbg0DsVm+pWloe/f+aea6Gw1A=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BEja6k2012616
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 09:45:36 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 09:45:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 09:45:35 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BEjWX22279585;
 Thu, 11 Sep 2025 09:45:33 -0500
Message-ID: <158f9ac7-cd66-4f05-9458-8f321bb0ed1b@ti.com>
Date: Thu, 11 Sep 2025 20:15:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: j722s_evm_a53_defconfig: Disable eMMC HS400
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Moteen Shah <m-shah@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-5-jm@ti.com>
 <69f903e4-b36c-4572-b05d-d6f6b0a982c7@ti.com>
 <197c6cb3-454d-4c2d-beab-bf4dbfdc4f8f@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <197c6cb3-454d-4c2d-beab-bf4dbfdc4f8f@ti.com>
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

Hi Judith

On 9/11/2025 8:00 PM, Judith Mendez wrote:
> Hi Udit,
>
> On 9/10/25 11:15 PM, Kumar, Udit wrote:
>>
>> On 9/11/2025 3:15 AM, Judith Mendez wrote:
>>> This patch addresses silicon errata i2478 [0] "MMCSD0: HS400 Mode not
>>> supported". Where, eMMC HS400 mode is not supported due to bus timing
>>> limitations. As per workaround, use HS200 mode instead.
>>>
>>> [0] https://www.ti.com/lit/pdf/sprz575
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>>   configs/j722s_evm_a53_defconfig | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> I think you should disable HS400 for am62px_evm_a53_defconfig as well
>
> Hs400 has not been descoped on AM62Px device. So we should not
> remove for AM62Px.


then please check, why this is getting removed only from r5/spl in patch 
3/4

configs/am62px_evm_r5_defconfig

--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -88,7 +88,6 @@ CONFIG_DM_MAILBOX=y
  CONFIG_K3_SEC_PROXY=y
  CONFIG_ESM_K3=y
  CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_HS400_SUPPORT=y
  CONFIG_MMC_SDHCI=y
  CONFIG_MMC_SDHCI_ADMA=y
  CONFIG_SPL_MMC_SDHCI_ADMA=y



>
> ~ Judith
