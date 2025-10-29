Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E7CCF9E9
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 07:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1AA8004F;
	Wed, 29 Oct 2025 08:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TvVu/BZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC90800B6; Wed, 29 Oct 2025 08:31:03 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9E58003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 08:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTaCm+W279EShOpE+YleHI3WWnBenZFeDwWF926g+jP+GABTOHMmYU/33vRjpr20dMa5fwxINFXK646R9PmGll5t7YE7o1u+zkQp0s4AzyCVNuMz5FBbzEUnoTvTp3lhIPHWGLGhsVP5rlYmnU9TCca27FeNlt9VMSppYNCxnbXD57+sryU+5tkQIelNZtkBZ+/aywL8yB5QtYKYIPGkJoo72ZRp8V6kzVm0He8H3tMRLYVjOopefUgznN+zks6vVQMR/szlA/pJEt1hHBljb7+8+1DkOUhOQ0UBH0EYkZyBTvbYf4LZaacLUi8N5XSYAjCWkCc8oqjx4EyH2EgxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QH/8Ke/l++Lule7GzJtYfteTDQndkSbTkGoAR+Kz5w=;
 b=kyPtMLGNOxt8rJPq1lPCGx4TYs7TM81ed68baCOWMP9zU+nEuSft5NxBdin6GoJbLdANr0mmLRg6CAknHRdG5T54Z/RPU5xjLHyIPGoiJ/MdHdGMuLwA4tNUijXzpY6/jz6dzXxWukcl5j5hZr1nNtwi6Gv6au4GLwvCUiKIgKMWQpmZxq5uEMyk1dRFJsrn5x8hO1Qm2XzyyjojuH2JJTq+bboExeZt6/l1VBHiBOfDL0DJok3g8dLpvs85PQwatl9HRnj4LG5D0sWrDjBS7xfuamiFYwOcluq8fiLqnFqR1/LBzGkTu6KSZ5nzZNLngoUzz/SAPGlFdDYshP+DPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QH/8Ke/l++Lule7GzJtYfteTDQndkSbTkGoAR+Kz5w=;
 b=TvVu/BZ4DOfsZXQk/U6G2McbPzmzae7xHQK8fIMFTAJoCI2nIVAetBd5RgQn/9VhnndW/VuqSSK2vJvHF4V/bRkSSVZ47ddR/JJRsopnJ6s+AoG1clFI837cWKJ2TmBJS3JjQ65B14IfWwVHFqL/EAfcQrkGTv85Li4pRDRCbmo=
Received: from CH2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:610:4f::21)
 by DM4PR10MB7402.namprd10.prod.outlook.com (2603:10b6:8:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 07:30:55 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::ae) by CH2PR18CA0011.outlook.office365.com
 (2603:10b6:610:4f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Wed,
 29 Oct 2025 07:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 07:30:53 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 02:30:44 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 02:30:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 02:30:44 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T7UhJC3636634;
 Wed, 29 Oct 2025 02:30:43 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Maxim Kochetkov <fido_max@inbox.ru>, Dhruva Gole <d-gole@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 2/2] clk: scmi: add compatibility for clock version
 3.0 and onwards
In-Reply-To: <87sef3p3c2.fsf@kamlesh.mail-host-address-is-not-set>
References: <20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com>
 <20250819-b4-scmi-v1-v3-2-360145076b3b@ti.com>
 <ccf326ff-b4d3-43f0-92df-07a22bd5c60e@inbox.ru>
 <20250909101806.bymqunywxu6pe33o@lcpd911>
 <dd60557d-e8ee-4ea1-8045-e442db38a5c8@inbox.ru>
 <874is9h937.fsf@kamlesh.mail-host-address-is-not-set>
 <7e1881e5-3feb-4b26-b9ea-e6e56a090873@inbox.ru>
 <87sef3p3c2.fsf@kamlesh.mail-host-address-is-not-set>
Date: Wed, 29 Oct 2025 13:00:42 +0530
Message-ID: <87pla6p3kt.fsf@kamlesh.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|DM4PR10MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec1fbc5-9d35-4da5-1ed0-08de16bd17e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|36860700013|1800799024|376014|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8zsmle/E23t2vlJT58p0C19+Mwl3NSWLmdPjipMcjEjJWTCo5PZfoCAJegSX?=
 =?us-ascii?Q?dOdvcttAGOXX1+in80EgymDPGZHShyYLPulbQ2J/1YCon9wH803D9vadUlr3?=
 =?us-ascii?Q?WhmzxpHkg7yReawiFPv4nNFH0oetKYan81LUi7Jtcu4Q7opDPO2nAze1wJZr?=
 =?us-ascii?Q?MBtUpURT3H8Pg8soaIEnrvxsClfrIBw36Qqc6TVALYjNNLdJtc//tE8r/k2F?=
 =?us-ascii?Q?0IT01NCX7a9vJj5jLvakTJaCEzGEyyXpZSq2f1F3cBi8k0f/lBtFklrSF9LM?=
 =?us-ascii?Q?SYQxWfmgZ2EuR9aoMJwSKvkZ4ujPytUwXXgdN6bcQoXqKK82LvfNv7mN2irO?=
 =?us-ascii?Q?hXQ5YEcNC2fsqqonGFj0cSKdq7UcpLyjxIwjfKJ9gRWZQP3oOgGe25zrx4Un?=
 =?us-ascii?Q?9cCQU1AAiWsz4EvZLYBeBP36+hU4u38s0ha811H8fMlGSXXmyOeVR97CpS/t?=
 =?us-ascii?Q?8uIPy4jKrPNLPOe3w/uCTCNljpDA3s+bt/O7iv2UZPMl3D3Z9y/lbf7kzF2E?=
 =?us-ascii?Q?VL9nmxPIe1I4yQnOlf0+44a+BgJwT6kl5KrHG/oHUajO4OqrohNjcRHiIJ0Z?=
 =?us-ascii?Q?hHVVLf/7JcDjfMNLsfSob5ni9u8g4MbyiTrtciIqFGVis/jYUic+9rwWV60p?=
 =?us-ascii?Q?Wbc+y0YFc1T2Q8sJCEzLqSMflVOPRJnv5N26QWccHCJ3UrdHvWNoyCrxJLZT?=
 =?us-ascii?Q?7dJAf4mbVnD7vLnDJ/Ep+eQDvMvA6mKcFS0x7Bl8dIW8ZiP9eQXRIU5M01g3?=
 =?us-ascii?Q?1d6d1E9LRNgaWjl8O0fk7xtBp6PRBZWidxZ7SVy1Dbmyqak1PXGkIVbjTvN8?=
 =?us-ascii?Q?d2zJAOtG1dYVp8tRSUfN2cCFc6kCnszeyJKvPi4WUQDUlv8YZzaa2ofnVcKn?=
 =?us-ascii?Q?sKWBr9U976Jn5/i0ZSn77f05BFv+7H63c2RPBbJ10jEJPWac6ihpHrR7rsnB?=
 =?us-ascii?Q?q9c+MUWdMiFAhH8jvEfu0VY5qaLfktQj+L/IRDLTyc4B8C0BMN8zzr4aPLHW?=
 =?us-ascii?Q?VEin04GDpoRvLmYgppiPM206xPLSlJJMt67qc6iG/kG0BCjCctTo6UILPE6Z?=
 =?us-ascii?Q?1MpA/HUdsceM0AdV5UT1PBYS5U/RCW8ezjrDh+h++xAaIao0e5Yn64vdt9+D?=
 =?us-ascii?Q?Cxy53SWfJOcONXcGJp5LaisqnKPCkZe3Yuo50G7+XnkTreDrMPJRhHAJePrI?=
 =?us-ascii?Q?YVZEGZiCZpMRXpCEGv6JGcU/cK23kOSFcX7hv8kdBFv4VJPZScEKQe5fLTEC?=
 =?us-ascii?Q?M56TDGk4riNQ6gfM0ZnkTTF4SV72nNgqH/HKW8TME21sWLWVCsGWnOQKUJdf?=
 =?us-ascii?Q?F72hxDQhBTJxRzQMrCvThHwPwSlbuvBjTr8i81ohQVCqLu0Ry1ZN6XGkKfVT?=
 =?us-ascii?Q?mPExWNjQS6QMQpWmZT8G9t5DRPjCMIn0FAPEj/nsOSvwi/AzVlHPVt5mxHif?=
 =?us-ascii?Q?aFekx/IKEd2Lwnzzr0Ec8s1R7SOHIWItfUi3hwuw/LsRA920Pl1YLSnAFR9n?=
 =?us-ascii?Q?5pKSuJtrhUmoXNbsi0Ghv6GdPvDNZuxMilh/aUCGx2xvqYXXWKuiPjpteFDg?=
 =?us-ascii?Q?cFsiUAdZuA7QokcBzHU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(36860700013)(1800799024)(376014)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:30:53.8086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec1fbc5-9d35-4da5-1ed0-08de16bd17e4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7402
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

Kamlesh Gurudasani <kamlesh@ti.com> writes:

> Maxim Kochetkov <fido_max@inbox.ru> writes:
>
>> 08.10.2025 15:27, Kamlesh Gurudasani wrote:
>>
>>>>> Could you elaborate?
>>>>> I think clk->dev should be fine, similar to other instances in the same
>>>>> file. Maybe I am missing something?
>>>>>
>>>>
>>>> clk->dev points to hw clock device. It has no struct scmi_clock_priv
>>>> stored in priv data. So we have to step up to parent device to get SCMI
>>>> protocol device to get struct scmi_clock_priv to get protocol version
>>>> priv->version.
>>> Hi Maxim,
>>> 
>>> in probe function, we are making sure that priv data is available
>>> 	struct scmi_clock_priv *priv = dev_get_priv(dev);
>>> 	size_t num_clocks, i;
>>> 	int ret;
>>> 
>>> 	ret = devm_scmi_of_get_channel(dev);
>>> 	if (ret)
>>> 		return ret;
>>> 
>>> 	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
>>> 					    &priv->version);
>>> 
>>> 
>>> Also, the code is working just fine and returns correct version with
>>> clk->dev
>>> 
>>> Let me know if I missed something
>>
>> Here is my debug path:
>>
>> --- a/drivers/clk/clk_scmi.c
>> +++ b/drivers/clk/clk_scmi.c
>> @@ -135,6 +135,10 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>>          struct scmi_clk_state_out out;
>>          int ret;
>>
>> +       printf("%s name:%s dev:0x%px dev->priv:0x%px     parent->name:%s 
>> parent->dev:0x%px parent->dev->priv:0x%px\n", __FUNCTION__,
>> +               clk->dev->name, clk->dev, dev_get_priv(clk->dev),
>> +               clk->dev->parent->name, clk->dev->parent, 
>> dev_get_priv(clk->dev->parent));
>> +
>>          if (priv->version >= CLOCK_PROTOCOL_VERSION_3_0) {
>>                  struct scmi_clk_state_in_v2 in = {
>>                          .clock_id = clk_get_id(clk),
>> @@ -288,6 +292,8 @@ static int scmi_clk_probe(struct udevice *dev)
>>          size_t num_clocks, i;
>>          int ret;
>>
>> +       printf("%s name:%s dev:0x%px dev->priv:0x%px\n", __FUNCTION__, 
>> dev->name, dev, priv);
>> +
>>          ret = devm_scmi_of_get_channel(dev);
>>          if (ret)
>>                  return ret;
>>
>> And output:
>>
>> DRAM:  510 MiB
>> scmi_clk_probe name:protocol@14 dev:0x000000041f51fc50 
>> dev->priv:0x000000041f520ae0
>> scmi_clk_gate name:UART0 dev:0x000000041f522710 
>> dev->priv:0x0000000000000000     parent->name:protocol@14 
>> parent->dev:0x000000041f51fc50 parent->dev->priv:0x000000041f520ae0
>> Core:  132 devices, 22 uclasses, devicetree: board
>> MMC:   scmi_clk_gate name:EMMC_S dev:0x000000041f521950 
>> dev->priv:0x0000000000000000     parent->name:protocol@14 
>> parent->dev:0x000000041f51fc50 parent->dev->priv:0x000000041f520ae0
>> sdhci@0: 0
>> Loading Environment from nowhere... OK
>> In:    serial
>> Out:   serial
>> Err:   serial
>>
>> As we can see here, we have two different devs in scmi_clk_probe() and 
>> scmi_clk_gate(). dev from scmi_clk_gate() have NULL in dev->priv. So we 
>> can't get scmi version form clk->dev direcrly.
>>
>> P.S.: I have CONFIG_CLK_CCF=y
> Thanks for the logs Maxim.
>
> Looks like the behaviour is different for CCF and non CCF
>
> We have parent->dev->priv as NULL. (and no prints from probe func for r5)
>
> *r5 core logs*
> U-Boot SPL 2025.01-00667-g8d2958a533ce-dirty (Oct 28 2025 - 18:43:57 +0530)
> SPL initial stack usage: 1984 bytes
> Trying to boot from DFU
> scmi_clk_gate name:protocol@14 dev:0x82b7a400x dev->priv:0x82b7a588x parent->name:scmi parent->dev:0x82b7a1d0x parent->dev->pr\
> iv:0x0x
> #####DOWNLOAD ... OK
> Ctrl+C to exit ...
> ERROR:   Agent 0 Protocol 0x10 Message 0x7: not supported
My bad both are a53 logs, spl and uboot


>
> *A53 core logs*
> U-Boot 2025.01-00667-g8d2958a533ce-dirty (Oct 28 2025 - 18:43:57 +0530)
>
> SoC:   AM62LX SR1.0 HS-FS
> Model: Texas Instruments AM62L3 Evaluation Module
> DRAM:  2 GiB
> ERROR:   Agent 0 Protocol 0x10 Message 0x7: not supported
> scmi_clk_probe name:protocol@14 dev:0x00000000fdeb65a0 dev->priv:0x00000000fdeb6f30
> Core:  84 devices, 32 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> Loading Environment from nowhere... OK
>
>
> If you have suggestion for solutions please let me know.
I'm not able to test CCF enabled but I have following that might be a
potential solution

modified   drivers/clk/clk_scmi.c
@@ -130,10 +130,18 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
 
 static int scmi_clk_gate(struct clk *clk, int enable)
 {
-	struct scmi_clock_priv *priv = dev_get_priv(clk->dev);
+	struct scmi_clock_priv *priv;
         struct scmi_clk_state_out out;
         int ret;
 
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		/* CCF: version info is in parent device */
+		priv = dev_get_priv(clk->dev->parent);
+	} else {
+		/* Non-CCF: version info is in current device */
+		priv = dev_get_priv(clk->dev);
+	}
+
         printf("%s name:%s dev:0x%px dev->priv:0x%px parent->name:%s parent->dev:0x%px parent->dev->priv:0x%px\n", __FUNCTION__, clk->dev->name, clk->dev, dev_get_priv(clk->dev), clk->dev->parent->name, clk->dev->parent, dev_get_priv(clk->dev->parent));
 	if (priv->version >= CLOCK_PROTOCOL_VERSION_3_0) {
 		struct scmi_clk_state_in_v2 in = {


I have checked with CCF disabled.
Let me know if this works for you as well.

Regards,
Kamlesh
