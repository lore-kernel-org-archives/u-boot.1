Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBFCD65C7B
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96BE683B55;
	Wed, 17 Dec 2025 17:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Ci9lRg96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C4883B99; Wed, 17 Dec 2025 17:35:07 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A4683B55
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYqmETXYsF8LwMv9WpGSieTJIfPRfsJk6tcAe6TWeQqFZ/3tSUD1UK+Vm32cl0K7ZUj/tSzInHZZSf9h6BdYoAjORXzcVIJ+m7qnVCR5ziZ1SuvS08LCe10ahNGZ6n2RuHEnay+hu5uxMAis5gwJcLKvcC91Tj00z5iTiqyV/KwtQpusAdWZdH7LYl+1RfcoP1BWmC+7TTz1QFLzyuk14yb3zpu6qtkXp9yRgWUsGYq4py3O1jPIzhLhvHBCZlLwhbuUUe+ZvrJyNTLeJSqLVyslIc/JUldRMz2VJvAxQYSOBTsVw0zW/g5z8E3zywMhzA2kaM/MbetODnZBuumlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRC9D0no6pnk/Qox8A08yQ6TAUTzfvmRiuZCfcpMc7Y=;
 b=ikrc+NoGih12UzyTLsNuJcxzxjbKRWYK7KWPErTryxNkBw/BB6sKbgRA1GDDpvo6qvPyVZoyG+1aRNj+ZzEPBQg0NAgk+KeaqAy9AxYzMHE4u6ocX/AO+2RuNe/LoNrzro6zbrwRue3wyf3nGXF7sJ6ttB02gL8UZM0BmYjInhv20aauUrJmEY3hYZVb3/p6vtKzswEgBPYIeB4FA9Bx8L4Ou20yrZ8LLU4IXKWXTmZgsJt7rBhkGBNGZBDqe+l8Yt5qmpvxgsAoTV3PYNs51oyeuwOAA7udIIvtLdxZQkN1CelpegjWkgHNZ2Udd8JAgyxy2bL+Xvvx5Qqg85uLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRC9D0no6pnk/Qox8A08yQ6TAUTzfvmRiuZCfcpMc7Y=;
 b=Ci9lRg96DyyOo2+8xRVnvYHziZTOMglR+a7ral4bf544fqyF+fSgMYGHCov5pNZfQ2wMY8SrNmR7bkTT82uN4X34/9JMAiXrQRXkCaShKwLkUmRzu67EN3q/K8ubNYBU6LOMusYDpRyyc8aOCYlo0wiGkS/SSPLl0CNeyESlj3kVDOxLX6ZVxZHOlZc1JG+GC+VZYERl82NjpL8taxX35Ckr+CW804g0zseNApvVw3jXQHoUGsWn7LGP69KZM1+mdYWLAhaQwmyQcAppAdS8ohG+d+hw6Ox6j9j/NH4WDAVJqUOUF2rIS5X+XONBJJ9tOrdbAwghdnv/eoVcYA70Pg==
Received: from AM9P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::15)
 by VI1PR10MB7634.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:34:56 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:21c:cafe::90) by AM9P250CA0010.outlook.office365.com
 (2603:10a6:20b:21c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.11 via Frontend Transport; Wed,
 17 Dec 2025 16:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 16:34:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:35:43 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:34:54 +0100
Message-ID: <a67bb8ef-00c4-473c-9761-506a577c013c@foss.st.com>
Date: Wed, 17 Dec 2025 17:34:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] clk: scmi: Fix priv initialization in
 scmi_clk_gate()
To: Marek Vasut <marek.vasut@mailbox.org>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>
References: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
 <20251215-sqqs-v2-2-9a15a22072b7@foss.st.com>
 <c1b0ecd6-2697-4b81-9b63-1c5b3d243a86@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <c1b0ecd6-2697-4b81-9b63-1c5b3d243a86@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|VI1PR10MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 981be077-68de-4ddf-5250-08de3d8a3640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnhQdE9GUUlmRVhBV2QyNjAzaktNaUxxeTd1MXhPTkE5eEhTNXNqcjZPMW5U?=
 =?utf-8?B?M3FtM0R4OXpaeG1ZL21DZStnakZ6YWNuaE5ad1hvMHJvMXlyWUlRZEdMYTVB?=
 =?utf-8?B?aUE1UHV4NDVEbXU1VlJoUElLYVUwdlFHMnMxbElVa2Fmcm1vdDZ5V2N5bGt5?=
 =?utf-8?B?SFJldTdieU00aXhWSm5JK1krZSs5R0pOZ0lpQnhVWnNRZnFudUxPN2FtY1NT?=
 =?utf-8?B?RlV3UVR3M0tsMml2a1dPVTZNWnhCUTV2bE5IZjlLT2NnbHNmZ3BTYWRwYVJm?=
 =?utf-8?B?emo2ZzhJSVFMSW5udnduWDE1ZEVSRUdKSnVDQ1owVDF0aXVWSWxmK1E0OFRj?=
 =?utf-8?B?bTFndlU2bHRHUjJaTXhtcGRvWHVYT1RaYm9KQ2FKbUdJdk1YZFE0aFVhWVho?=
 =?utf-8?B?ZjlKQTBZeVIwcis5bVhwTUNON2pudWhtTmVhd2J1UmZvdjM3UjI5MVltMjJX?=
 =?utf-8?B?VGovSkE5Z1RsbWFGYmlVdHhtN3dvdjFTcWlwWkh3d093dDN2UTJLVXBvQk11?=
 =?utf-8?B?cFdDOHBleU9nL29ULzFSblM4YnBvTUwxTFRaVkNUejc2THJ1eW5PajlYNFky?=
 =?utf-8?B?cTVrM1BwLzJQdWYzT3VvRjBxRDY2L0J5Yjd0eEtpTUhyT3pEb1BMUHB4YVdW?=
 =?utf-8?B?TzVDdXpFYWpOU1BDOW5QT1hYNzZKUGI4UHFEclJ2L0E1K1JQU0ZLbGE0UXZl?=
 =?utf-8?B?YzVLdTdONElXYzFKbDU5Q1JUVFo3MlA4RCtvcmVYZXFQcUJ1SDdDUW1WdW5W?=
 =?utf-8?B?WGVCUnZhckdDUFNEeDVGdXUzZHBaaHJTSUJqbWRIWVUrTkVrelkxTEswOVJ4?=
 =?utf-8?B?OVI3SUdjSGdjSmhpRDJlVU9EMlcxUTVHeTJUNDdsMlFqNEVxVytTWkVRTWht?=
 =?utf-8?B?RlVzUEFKMTVyaG1PckdVZUpxWktrS1VNUVh0dERWSCtOZU85UG1ncHlVRDlD?=
 =?utf-8?B?b0FoVTYxZUpMUDFySXpkQkYxcjU2R2hUd1ZENWxrbDlkSXM0WFczSW13RVZw?=
 =?utf-8?B?Q1BCSzRYOVZ1bkNwN0dyTlZZZm9TYW1ITGF5cU9ZSHk3S0JySW1pTS8wL2tI?=
 =?utf-8?B?UWhZRFBTcmE2NkVwUWdRNld1OHoyZThSOTdQQVY0SjYrZ0orWlViWFQwb014?=
 =?utf-8?B?MGtyVjRnYTlDYVlGTkdrVEFmcnVLTk9yQ2FZUDlTb2cxU1RMeFk1c3c3MkVz?=
 =?utf-8?B?T0hrRzNOQkprUG1QSmg3WjQyeFhUa1U4aFlTUURCaFlzYUlHZnV1cFhhM0N3?=
 =?utf-8?B?RUJHRjJIbmVhcVJyY0xGR3RYMlNQVUtRZWM1MHlLZ21Yb3RjYXIyNUs4WkZi?=
 =?utf-8?B?dlR5V0tIckRzNVlLb1R6RHBnS21xaVdIaGpldlQ3SHo5aUNzZ2RsdkhYQkdM?=
 =?utf-8?B?cTV6Mi84R0kwYk11ckFzNVJzQ09neTZSOHpZN3h0azVmc2FKRlUyMTgzV2x6?=
 =?utf-8?B?NHRRdUxjMDhSZnF1VmFlL1VsU1cvZmNOV2g4T2k2S3pFb3BxRFltdXd3QnNG?=
 =?utf-8?B?alh0cUtBT0RwT0szOEU2RWtvaGg2dzRieUJMVGFyV1JmSkhjKzN5c3RGWkNN?=
 =?utf-8?B?S3IyV1RpQm5CY2xMY3JOS2Q1U1JzS1pURXB4SHYwYkFHTUtKYVVBV1loRjBi?=
 =?utf-8?B?QXVhVGYxdmp2bzFPR3FRUmN2aWpKbFVCaGVRbHk2b3BGQnlqcjdnZ3g4R3o5?=
 =?utf-8?B?NGliNFR2UjZaN3pMRlE2bWFCMkZtR3JxcHhjcFdOeUVjZEFxMTBrenZZNlVL?=
 =?utf-8?B?SW1IZlZPQ2lkNVRkVzF2Z05aNFhDTlJxNUszQm40RnFFcGltSUc4TGNiOTFP?=
 =?utf-8?B?L3AxSVRYN2NEWHlJcGUyUmdDZXRoU2tYZDFaekxsUnhUaXRpd2RtejJ2SFBZ?=
 =?utf-8?B?M2VYVnJKQk5jSXVpeVJuMGp1SitsandVL1A2VWw1c1JMV0FaOFNpdVFnQlhi?=
 =?utf-8?B?clJDbE9FNEVVTWdJSlJ2L29CV3IvUFk5N3dGRU0vb1dsZ3VZYTlYdTdhdEt0?=
 =?utf-8?B?R25qQmZhTU5tT0VVcnh5bDE5STRucmZCeDBoVldaRG9XQUphSlN2Vk1EcWhh?=
 =?utf-8?B?ZzNPUEZ0bVpNektxd29GbE81ZFM4bUxMTXRneU0yWDRldUU0NUZxZlZWNUxV?=
 =?utf-8?Q?PMAM=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AcaQVIXSuNJHGf8ZSJZRkSPSK2UXjC3kZyZQP8iE6Z2eZ0d+BWNxunSib7Wz0rXiSz9BjqTbfY+Zz110eCmL0Kl8NyS76TIdsX/LCBZbKdPIoGMNaWW1jJ1kDubgghUOm253N7TCwO04PUAeCidSWpfrs4dyARzVwsgq4Ygu2DCoGkI6Crvv0Wml+sl7ivTPuFjLy0MOYD3sW+OBA3mOBcyNMUOT/qCVtJVrwgmkmfaqEJWZzhFR+zWHJkJDtxTHIQpPSpogZf1hSPAJf1MxzRpRcnEPmmaQCzbCo7pEsTMW4O4g2kKT+GaDC3x7UzywKsmnJ0P1FEUMEIzzOB5psweGvFTjQjhob9NB3bSCSwHUAY52H31XtyigBQl+vkN94X7lNcY4DfOIug1kY2sNMCj3Y0FVimv3ty+hP5assFoQxpIuDqzL7UgA/IOJ+zpujhQgI9o//AXCI8QRQiIwNdeg6Y+hZJLCA2qwVbQBLnYcoqTm0NPjV00/TFp0Sbrs+uAyaef4aeq50l8MLCypCEsWJAVXqxWO54EJ79QbXE98pT8PbkIeLvSZeZWNeOMlcBwTjmZUuDaA8/04ETnbPgj1Yz/y2lEfjiXT3g4k45xKPCK50lECJgrUNMnWgUiJO+LuiFNFuhcOkamsr34mSFCFPgfU9ukSFvfhktyVYaWzndKg5v44vONOzotYaDZrjGefULcPhpf2A/tdb04kWA==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:34:55.7329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981be077-68de-4ddf-5250-08de3d8a3640
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7634
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



On 12/17/25 14:02, Marek Vasut wrote:
> On 12/15/25 8:38 AM, Patrice Chotard wrote:
>> In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
>> data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
>> retrieved.
>>
>> SCMI request is performed either using scmi_clk_state_in_v1 or
>> scmi_clk_state_in_v2 struct depending of the unpredictable value of
>> priv->version which leads to error during SCMI clock enable.
>>
>> Issue detected on STM32MP157C-DK2 board using the SCMI device tree
>> stm32mp157c-dk2-scmi.dts.
>>
>> Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Cc: Alice Guo <alice.guo@nxp.com>
>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Valentin Caron <valentin.caron@foss.st.com>
>> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>> Cc: u-boot@lists.denx.de
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/clk/clk_scmi.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>> index f6132178205..5c99f3708c3 100644
>> --- a/drivers/clk/clk_scmi.c
>> +++ b/drivers/clk/clk_scmi.c
>> @@ -137,7 +137,7 @@ static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
>>     static int scmi_clk_gate(struct clk *clk, int enable)
>>   {
>> -    struct scmi_clock_priv *priv = dev_get_parent_priv(clk->dev);
>> +    struct scmi_clock_priv *priv;
>>       struct scmi_clk_state_in_v1 in_v1 = {
>>           .clock_id = clk_get_id(clk),
>>           .attributes = enable,
>> @@ -156,6 +156,15 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>>                            in_v2, out);
>>       int ret;
>>   +    /*
>> +     * retrieve the correct priv which was set in scmi_clk_probe().
>> +     * in case CLK_CCF is set, priv was set in parent_priv
>> +     */
>> +    if (!CONFIG_IS_ENABLED(CLK_CCF))
> 
> Please invert the conditional here , no need for the if (!...) .

Ok

Thanks
Patrice

> 
>> +        priv = dev_get_priv(clk->dev);
>> +    else
>> +        priv = dev_get_parent_priv(clk->dev);
>> +
>>       ret = devm_scmi_process_msg(clk->dev,
>>                       (priv->version < CLOCK_PROTOCOL_VERSION_2_1) ?
>>                       &msg_v1 : &msg_v2);
>>

