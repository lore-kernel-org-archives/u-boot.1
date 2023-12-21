Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89596C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 12:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D7187853;
	Thu, 21 Dec 2023 13:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UvFS4KAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E0C876F6; Thu, 21 Dec 2023 06:57:45 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2FC8763E
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BL5vVI2093361;
 Wed, 20 Dec 2023 23:57:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703138251;
 bh=rzF2ol9IUrshvc4L9U6kQcPUlPMsWNAx4Z71tlDmE10=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UvFS4KAIj1h+JS5AnBLuZxSwdkufC3B2Zm/AvywgV1Rts3khOBFefk5O8EswDZD9y
 D/6t+o20y4TSWnUhMJhE4uMSEOtxSN4DMhbf+1s7Ec3+PrDHgsRNg8mPJDZuV9W7zO
 COKAdupwdGBydLsnptoFnzEXw2vboUYcdOfgflaE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BL5vV3w109602
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Dec 2023 23:57:31 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Dec 2023 23:57:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Dec 2023 23:57:30 -0600
Received: from [10.24.69.31] (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BL5vNaG114779;
 Wed, 20 Dec 2023 23:57:25 -0600
Message-ID: <dec37f82-abf4-4300-88f0-511faf014564@ti.com>
Date: Thu, 21 Dec 2023 11:27:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/16] configs: am65x_evm_a53_defconfig: add
 SPL_LOAD_FIT_APPLY_OVERLAY
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-15-danishanwar@ti.com>
 <4a831eea-ce70-46b9-9e30-cc57a0182630@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <4a831eea-ce70-46b9-9e30-cc57a0182630@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 21 Dec 2023 13:26:33 +0100
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

Roger,

On 20/12/23 3:32 pm, Roger Quadros wrote:
> 
> 
> On 19/12/2023 12:34, MD Danish Anwar wrote:
>> We want SPL to apply DTB overlays (e.g. NAND card overlay) so
>> enable SPL_LOAD_FIT_APPLY_OVERLAY.
>> Increase SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ and
>> SPL_STACK_R_MALLOC_SIMPLE_LEN. Without this SPL hangs.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  configs/am65x_evm_a53_defconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
>> index e79a961317..2755d7082f 100644
>> --- a/configs/am65x_evm_a53_defconfig
>> +++ b/configs/am65x_evm_a53_defconfig
>> @@ -70,6 +70,9 @@ CONFIG_CMD_I2C=y
>>  CONFIG_CMD_MMC=y
>>  CONFIG_CMD_PCI=y
>>  CONFIG_CMD_REMOTEPROC=y
>> +CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
>> +CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ=0x100000
>> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x1000000
> 
> This change to 16MB is not required. I suppose default is 4MB.
> Did you face issues with it?
> 

Without these I see below error in uboot,

U-Boot SPL 2024.01-rc5-00539-gdc3afd4d5b (Dec 21 2023 - 11:23:56 +0530)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.6--v09.01.06 (Kool Koala)')
Trying to boot from MMC2
spl_register_fat_device: fat register err - -1
spl_load_image_fat: error reading image u-boot.img, err - -1
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

The only way to recover from here is to do a power cycle reset. But when
you boot again, the issue is seen again. So I think these changes are
also needed. Without this, SPL doesn't work properly.

>>  CONFIG_CMD_USB=y
>>  CONFIG_CMD_TIME=y
>>  CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0"
> 

-- 
Thanks and Regards,
Danish
