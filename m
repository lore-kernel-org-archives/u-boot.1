Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ED6C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 05:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EEF83321;
	Thu, 31 Jul 2025 07:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IsfGVLsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E316D83322; Thu, 31 Jul 2025 07:59:51 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D608318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 07:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V5xlJg3373278;
 Thu, 31 Jul 2025 00:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753941587;
 bh=daEljzpwmkJ0vjcLdMlfj6ymC2JfXRHpu4kvjkoqoVQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IsfGVLsSDGUwC2L1Qf2l5B7Ahs0admvoQwOiZfYltd1cx0lSoC+GBM/r9D8LC5Oze
 OpXP2tDWGBry2ArHpxug72TpdFiJU2CHzZzaYz1rk8bS7T607F4i+RtnlfIKuNeKVM
 qJcTOTNx87scqNcn1PAvLKbQCVPKFW8Xdek6BKR0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V5xlFu3096199
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 00:59:47 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 00:59:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 00:59:47 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V5xiuB2119196;
 Thu, 31 Jul 2025 00:59:45 -0500
Message-ID: <cf2b5da3-ede1-407b-86d0-6b03126648d2@ti.com>
Date: Thu, 31 Jul 2025 11:29:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] ddr: imx9: Implement Synopsys LPDDR PHY QuickBoot flow
To: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Viorel Suman
 <viorel.suman@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-8-73da75bb33d3@nxp.com>
 <CAOMZO5D=p-BHD6KTLVWo_A-Gp+rn0k19Z-WFmtbS9o-x6stxzg@mail.gmail.com>
 <PAXPR04MB84595C1559CF7B32D6631B7E8824A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <PAXPR04MB84595C1559CF7B32D6631B7E8824A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
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

On 30/07/25 18:03, Peng Fan wrote:
>> Subject: Re: [PATCH 8/9] ddr: imx9: Implement Synopsys LPDDR PHY
>> QuickBoot flow
>>
>> On Sun, Jul 27, 2025 at 11:14 PM Peng Fan (OSS)
>> <peng.fan@oss.nxp.com> wrote:
>>>
>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>
>>> Implement Synopsys LPDDR PHY QuickBoot flow.
>>
>> What does "QuickBoot flow" mean? What are the
>> motivations/advantages of adding support for it?
> 
> Save the training data, then next time, the boot
> will be quick and no need ddr phy training step
> which would consume 4~5 seconds.
> 
>>
>> Please expand the commit message to explain why you are doing this.
>>
>>> +config IMX_SNPS_DDR_PHY_QB
>>> +       bool "i.MX Synopsys DDR PHY QuickBoot mode"
>>> +       depends on IMX_SNPS_DDR_PHY
>> && !IMX_SNPS_DDR_PHY_QB_GEN
>>> +       help
>>> +         Select the DDR PHY QuickBoot mode on i.MX9 SOC.
>>
>> Nothing selects IMX_SNPS_DDR_PHY_QB in this series, so this patch is
>> only adding dead code.
> 
> I could add user in V2.
> 
>>
>>> +static int ddrphy_qb_restore(struct dram_timing_info *info, int
>>> +fsp_id) {
>>> +       int i;
>>> +       u32 to_addr;
>>> +       struct dram_fsp_msg *fsp_msg;
>>> +       struct dram_cfg_param *dram_cfg;
>>> +
>>> +       fsp_msg = &info->fsp_msg[fsp_id];
>>> +       for (i = 0; i < fsp_msg->fsp_cfg_num; i++) {
>>> +               dram_cfg = &fsp_msg->fsp_cfg[i];
>>> +               dwc_ddrphy_apb_wr(dram_cfg->reg, dram_cfg->val);
>>> +       }
>>> +
>>> +       /* enable the ddrphy apb */
>>> +       dwc_ddrphy_apb_wr(0xd0000, 0x00);
>>> +       dwc_ddrphy_apb_wr(0x54008, 0x01); /* SequenceCtrl = 0x1
>> (DevInit Only)*/
>>> +       ddrphy_w(0x5400c, 0x19, 0x1);     /* Lp4Quickboot = 0x1 */
>>> +
>>> +       /* Adjust MR14_xy if pstate=0 and 2D training data collected
>> during training phase */
>>> +       if (fsp_id == 0 && (qb_state.flags & DDRPHY_QB_FLAG_2D)) {
>>> +               ddrphy_w(0x5401c, 0x39, qb_state.fsp[0] >> 8);   /*
>> TrainedVREFDQ_A0 -> MR14_A0 */
>>> +               ddrphy_w(0x54022, 0x45, qb_state.fsp[1] & 0xFF); /*
>> TrainedVREFDQ_A1 -> MR14_A1 */
>>> +               ddrphy_w(0x54036, 0x6c, qb_state.fsp[2] & 0xFF); /*
>> TrainedVREFDQ_B0 -> MR14_B0 */
>>> +               ddrphy_w(0x5403c, 0x78, qb_state.fsp[2] >> 8);   /*
>> TrainedVREFDQ_B1 -> MR14_B1 */
>>> +       }
>>> +
>>> +       /* save CSRs to address starting with 0x54800 */
>>> +       for (i = 0, to_addr = 0x54800; i < DDRPHY_QB_CSR_SIZE; i++,
>> to_addr++)
>>> +               dwc_ddrphy_apb_wr(to_addr, qb_state.csr[i]);
>>> +
>>> +       /* disable the ddrphy apb */
>>> +       dwc_ddrphy_apb_wr(0xd0000, 0x01);
>>
>> Lots of magic numbers in this function.
> 
> We could not do much on this. Synopsys release
> reference code to NXP. Using macros to replace
> the numbers will make upgrading much harder.
> 
>>
>>> +
>>> +       return 0;
>>
>> No need to return 0. Make the function 'void'.
> 
> ok.
> 
>>
>>> +int ddr_cfg_phy_qb(struct dram_timing_info *dram_timing, int
>> fsp_id)
>>> +{
>>> +       int ret;
>>> +
>>> +       /* MemReset Toggle */
>>> +       dwc_ddrphy_apb_wr(0xd0000, 0x0);
>>> +       dwc_ddrphy_apb_wr(0x20060, 0x3);
>>> +       dwc_ddrphy_apb_wr(0x2008F, 0x1);
>>> +
>>> +       /* load the dram quick boot firmware image */
>>> +       dwc_ddrphy_apb_wr(0xd0000, 0x0);
>>> +       ddr_load_train_firmware(FW_1D_IMAGE);
>>> +       ddrphy_qb_restore(dram_timing, fsp_id);
>>> +
>>> +       /* excute the firmware */
>>> +       dwc_ddrphy_apb_wr(0xd0000, 0x0);
>>> +       dwc_ddrphy_apb_wr(0xc0080, 0x3);
>>> +       dwc_ddrphy_apb_wr(0xd0031, 0x1);
>>> +       dwc_ddrphy_apb_wr(0xd0000, 0x1);
>>> +       dwc_ddrphy_apb_wr(0xd0099, 0x9);
>>> +       dwc_ddrphy_apb_wr(0xd0099, 0x1);
>>> +       dwc_ddrphy_apb_wr(0xd0099, 0x0);
>>> +
>>> +       /* Wait for the quick boot firmware to complete */
>>
>> Is there a special firmware for this quick boot firmware?
> 
> Yes.
> 
>>
>> Please explain the details. It is not clear why or how someone should
>> enable this QuickBoot feature.
> 
> I think needs to use B0 chip to use this feature. I could
> add more information in V2.

Also please add more information on the flow, I see you use the binman
symbol from the image to grab the offset of this Quick Boot f/w. Please
add the flow as to what is the expectation of your boot image as well.

> 
> Regards
> Peng. 

-- 
Thanking You
Neha Malcom Francis
