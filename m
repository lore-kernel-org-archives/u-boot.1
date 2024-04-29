Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710C7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 20:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3286888EA;
	Mon, 29 Apr 2024 22:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Uz2tHpm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85AC188606; Mon, 29 Apr 2024 22:40:05 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2E088912
 for <U-Boot@lists.denx.de>; Mon, 29 Apr 2024 22:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TKdsap057146;
 Mon, 29 Apr 2024 15:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714423194;
 bh=KZwOg6fgfb+FJmht8niUU0D+fZZNcWtb34LL8p33byM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Uz2tHpm1agAt3cRYfYv/Q+Sm8xv1b3kRf0qZEX5KTtQYw26Bay8WKJ2f8IMVbcb5Y
 1l5auSvL0v599Ubcw3Wo7iE8/7c9nZN6uae50pqi5oxa1HGmudg8WBpuDwu8DlMJ88
 AcJwEyEIAIqyWbTPscbI5LVFzeyPDz4tbDCWeHxo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TKds3b115924
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Apr 2024 15:39:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 15:39:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 15:39:53 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TKdrdM119263;
 Mon, 29 Apr 2024 15:39:53 -0500
Message-ID: <33db14f4-f3f0-4e5f-a256-2ce9b5c505fd@ti.com>
Date: Mon, 29 Apr 2024 15:39:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: U-Boot Mailing List <U-Boot@lists.denx.de>,
 <maximilian.brune@9elements.com>, <curtis.machida@intel.com>, Jonas Karlman
 <jonas@kwiboo.se>, <greg.malysa@timesys.com>,
 <ian.roberts@timesys.com>, Jae hoon Chung <jh80.chung@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, <sheng.tan@9elements.com>
References: <CGME20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b@epcas1p3.samsung.com>
 <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
 <20240426155154.GK1054907@bill-the-cat>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240426155154.GK1054907@bill-the-cat>
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

Hi all,

On 4/26/24 10:51 AM, Tom Rini wrote:
> On Fri, Apr 26, 2024 at 07:38:30PM +0900, Jaehoon Chung wrote:
> 
>> Dear Tom,
>>
>> Please pull u-boot-mmc master into u-boot master branch.
>> If there is any problem, let me know, plz
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/20547
>>
>> The following changes since commit d097f9e1299a3bdb7de468f0d9bbc63932f461cd:
>>
>>    Merge tag 'fsl-qoriq-2024-4-24' of https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq (2024-04-23 17:53:06 -0600)
>>
>> are available in the Git repository at:
>>
>>    git@source.denx.de:u-boot/custodians/u-boot-mmc.git master
>>
>> for you to fetch changes up to 1776213dadef4b578f98bcf18beb152f8975a8bf:
>>
>>    mmc: arm_pl180: Limit data transfer to U16_MAX (2024-04-26 15:32:06 +0900)
>>
> 
> Applied to u-boot/master, thanks!
> 


A patch in this series caused a regression for AM62x SK with the
following error:

Error reading cluster
spl_load_image_fat: error reading image u-boot.img, err - -22
SPL: failed to boot from all boot devices (err=-6)
### ERROR ### Please RESET the board ###

Git bisect showed "mmc: sdhci: introduce adma_write_desc() hook to
struct sdhci_ops" to be the offending commit.

Could someone point me to the next steps to fix this issue?

regards,
Judith
