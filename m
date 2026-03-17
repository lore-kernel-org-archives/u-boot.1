Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF372FF6E87
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 22:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5AB8410C;
	Tue, 17 Mar 2026 23:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="F+cHJFe0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DC6842DF; Tue, 17 Mar 2026 18:25:23 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4DE84201
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6843110DC12; Tue, 17 Mar 2026 18:25:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773768319;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sv7gvjC0FfwwFlHaMmJ7lv0lFHl3S9kMxptilBXrMzY=;
 b=F+cHJFe0/HGfMXBWR9pCODrtx5hVcdA5rzsKuZ073r77aplTPTK6ZY/4EPHi8BD0r9jpfr
 RqPo2eoZxUbjkUcdMd3lVp6BuOhydI9hFzHKZJraPAILwbzstck4UUk/5AAlUGPu9geVvM
 PgrnJeVpxRbKtz+dyyPsN+9kk+fCT/q3a+0DpwRlmxmSam/CMWRHDvKtxtnwjMKYEcPlh4
 rwUUbz7US6DggNngVP6FaAhpyUxut+xFM5/ziFvhWigVBbFNXlZXuOEdGosXZjF1RhXmLY
 AJkiMgLPQym6P3SrPMNchETs80/RA1MSYsjiO7TgEtXqGz3Vwsb+07urPO9fkg==
Message-ID: <e1f9f624-4a08-4e23-9ed0-0a180b812a9c@nabladev.com>
Date: Tue, 17 Mar 2026 13:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] imx9: Add support for saving DDR training data to
 NVM
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <5a7a3063ce3a429c67396c1d0bae95444ac3f996.1773648510.git.simona.toaca@nxp.com>
 <04ea62f9-f82a-4c10-9866-0ce78ea90b05@nabladev.com>
 <zlimv4bpiwiz45sbjesa6d7k76rpaeubqx3dtcbfdvjs5uqzbl@chaau67obpch>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <zlimv4bpiwiz45sbjesa6d7k76rpaeubqx3dtcbfdvjs5uqzbl@chaau67obpch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 17 Mar 2026 23:04:49 +0100
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

On 3/17/26 1:36 PM, Simona Toaca wrote:

Hi,

>>> @@ -100,6 +100,56 @@ struct dram_timing_info {
>>>    extern struct dram_timing_info dram_timing;
>>> +#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) /* CONFIG_IMX95 || CONFIG_IMX94 */
>>> +#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
>>
>> These are only macros and structure definitions, do they need to be
>> conditionally compiled ?
>>
> 
> I agree that this might be redundant, especially since IMX_SNPS_DDR_PHY_QB_GEN
> depends on IMX94 || IMX95. I would leave the IMX_SNPS_DDR_PHY_QB_GEN
> ifdef so that it is clear in which context this structure is used,
> if it is also ok with you. If not, I will remove it.

Remove it, it is superfluous. If you need to denote context, add code 
comment.

>>> +/* Quick Boot related */
>>> +#define DDRPHY_QB_CSR_SIZE	5168
>>> +#define DDRPHY_QB_ACSM_SIZE	4 * 1024
>>
>> (4 * 1024) to avoid side effects
>>
>>> +#define DDRPHY_QB_MSB_SIZE	0x200
>>> +#define DDRPHY_QB_PSTATES	0
>>> +#define DDRPHY_QB_PST_SIZE	DDRPHY_QB_PSTATES * 4 * 1024
>>
>> Add ( )
> 
> Should I add () to all the numbers so it is consistent, or
> just to the macros that contain computations?

The ones which contain more than plain integer and can have side effect 
if used in the wrong place.

> [ ... ]
> 
>>> +static int do_qb_mmc(int dev, bool save, bool is_bootdev)
>>> +{
>>> +	struct mmc *mmc;
>>> +	int ret = 0, mmc_dev;
>>> +	bool has_hw_part;
>>> +	u8 orig_part, part;
>>> +	u32 offset;
>>> +	void *buf;
>>> +
>>> +	mmc_dev = mmc_get_device_index(dev);
>>> +	if (mmc_dev < 0)
>>> +		return mmc_dev;
>>> +
>>> +	ret = mmc_find_device(&mmc, mmc_dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (!mmc->has_init)
>>> +		ret = mmc_init(mmc);
>>
>> mmc_init() already handles the mmc->has_init conditional, drop it.
>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	has_hw_part = !IS_SD(mmc) && mmc->part_config != MMCPART_NOAVAILABLE;
>>> +
>>> +	if (has_hw_part) {
>>> +		orig_part = mmc_get_blk_desc(mmc)->hwpart;
>>> +		part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
>>> +
>>> +		/* Select the partition */
>>> +		ret = mmc_switch_part(mmc, part);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	ret = get_qbdata_offset(mmc, MMC_DEV, &offset, is_bootdev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (save) {
>>> +		/* QB data is stored in DDR -> can use it as buf */
>>> +		buf = (void *)CONFIG_SAVED_QB_STATE_BASE;
>>> +		ret = blk_dwrite(mmc_get_blk_desc(mmc),
>>> +				 offset / mmc->write_bl_len,
>>> +				 QB_STATE_LOAD_SIZE / mmc->write_bl_len,
>>> +				 (const void *)buf);
>>> +	} else {
>>> +		/* erase */
>>> +		ret = blk_derase(mmc_get_blk_desc(mmc),
>>> +				 offset / mmc->write_bl_len,
>>> +				 QB_STATE_LOAD_SIZE / mmc->write_bl_len);
>>> +	}
>>> +
>>> +	ret = (ret > 0) ? 0 : -1;
>>
>> Use CMD_RET_SUCCESS and co.
>>
> 
> I am using these enum values in cmd_qb. However, here I would have
> do this 'if' at every return statement, since the other methods
> return 0 or an errno code. Should I still change this?

If this function does not implement a command, then it should be renamed 
to something less confusing.

>>> +	/* Return to original partition */
>>> +	if (has_hw_part)
>>> +		ret |= mmc_switch_part(mmc, orig_part);
> 
> [ ... ]
> 
>>> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>>> index 17269ddd2fc..eb9bfe19a69 100644
>>> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
>>> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>>> @@ -281,6 +281,15 @@ static struct mm_region imx9_mem_map[] = {
>>>    			 PTE_BLOCK_NON_SHARE |
>>>    			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>    	}, {
>>> +#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
>>> +		/* QB data */
>>
>> Is the ifdeffery necessary ?
>>
>> Where are the QB data located in this case, DRAM or SRAM ?
>>
> 
> It is necessary because CONFIG_SAVED_QB_STATE_BASE is only
> defined when CONFIG_IMX_SNPS_DDR_PHY_QB_GEN is enabled. So it
> throws a compilation error without this. And this is DRAM.

Are there going to be any users that will actually want ot disable this 
functionality ? Why would they do that ?

>>> +		.virt = CONFIG_SAVED_QB_STATE_BASE,
>>> +		.phys = CONFIG_SAVED_QB_STATE_BASE,
>>> +		.size = 0x200000UL,	/* 2M */
>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>> +			 PTE_BLOCK_OUTER_SHARE
>>> +	}, {

[...]
