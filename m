Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57D2D65C7D
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B8583B55;
	Wed, 17 Dec 2025 17:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="aisHy7Ab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0BD83B99; Wed, 17 Dec 2025 17:47:44 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDDA83B49
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aj86TZ+gL74yJis++k1GC6oCD4o1noFOs0e7lTEc5DDewZXTqa/kMTBaeYaDVWpoOJGBhHUUvffo/C/dOkzdPRtIKrOM45uYPQSaQr8YUaXt+HWi8+OWFeOPRJaAuFIquQ8+Jhc17YbweMPx5uHm9d//DKrBeNEpQecLF70UnPXpWRi9CpJYDLbJAyd241I4BmTBaZCdJ+UHNALRr8BTru8x5M8VYh2t8CbZLmH6DmYV4nKfXGamz7bH2uSmfgnDYh2auXdlMiEDO8COi1QAI977jGOVyF2MLEWtQCTYzd/DfZ+OlLZoskbPiuQ8vfV8JYG5SusGQxB39dykOAra0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KztuilgG+xuy/HLtSRfl2BgCZ8sbxZpltySUmfCrNKU=;
 b=vcn9gw7+RT3vM86kNvbPJ3Mq5E7vz8rIZr/z1tvJT9AgasxPW22FnJ7+jnhDrKmiL3VFaSyt7Xw+VyDSdMOhINuKjOTW9hsZAQ8PXIsm43mZ4FC91JhqrwwCsrCLdm1c4O6mjk8hBv83i6PYChi0JYfXPqK7fQODi6NP/OOXe2Ut+lIRmQEDUMqZd+RR2BMWiNKhY6eAN8g4ycr0ZTH/kNx1Qs5B4AkdB8D7d7B62VY7PFl330AozBpCNmwf/A53nvVDGXnf8EV19iRrKJs9U94pL0oi2ko5xJjIJLZpop+xg0sxFtT9byjrQUsGiXgrPj4z4mlc3NnRvn+EUSDIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KztuilgG+xuy/HLtSRfl2BgCZ8sbxZpltySUmfCrNKU=;
 b=aisHy7Abgj1bgReKdsCR6AAOgFuA0XI7LhKzJMc5F1SSUk7IRFwZQdYkhcs0WFgW9uKObMLA3tjMu8om5z5u7gpvn/NwJCvdVnrecBdQsBcW1nYac7ERzmlPlRnH1iu+5t+4rtUIWS/uxajjaFUloH9oH+CRafGa3ccWBOf0GrOmFc7+SGcrAc3h4V3tPOmc1WYaouLgV1Mt2MSEbed9VYm7zh8531LLbiUBhmPy3y43gwvkrPC0kbAXzC0yKw7fAdMVqmeTeEwKV0chJHVtr4SpVnjA06P6YvLAQ6ZAegL5dHzYzpZKaA3+YLV7DAe0EWxL5MLqKayn24dkMPNJgw==
Received: from DU2PR04CA0268.eurprd04.prod.outlook.com (2603:10a6:10:28e::33)
 by VI0PR10MB8714.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:47:36 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::20) by DU2PR04CA0268.outlook.office365.com
 (2603:10a6:10:28e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 16:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 16:47:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:48:23 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:47:35 +0100
Message-ID: <ca64955b-f43f-4be8-b97c-b7df96778cb7@foss.st.com>
Date: Wed, 17 Dec 2025 17:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] please pull scmi-master-2025-12-17
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>
CC: <u-boot@lists.denx.de>
References: <aUK3gznUWeKoLi_j@nxa18884-linux.ap.freescale.net>
 <20251217160556.GE303283@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251217160556.GE303283@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|VI0PR10MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: b6319a06-143c-40e6-61ad-08de3d8bfb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWZYU04wMFpNb29ZK0I5TnRGeHRvdDU0dkhqWHZoY1hyNXJmMEZrejFxZytS?=
 =?utf-8?B?a0hDYXNMVHFtL3V0NTVWbzNxOTNRUTdsZkx1WTBCejhBNUViYzVCMTZhTzBM?=
 =?utf-8?B?TjNBRVN4dHRnQmc4MnUwamQ5OWRhbEluTS80Tk1HSEE0bW1MdUZMdENNYWZ2?=
 =?utf-8?B?djk1dlE1aHM3Vmg4N3ZLYjZUdVlvQTlsTTJqMnNQelZMSTBXL1NjTlJkNXJN?=
 =?utf-8?B?TVFrc2hQT3p1KzZwVC9YcXJiZXZjRjU5YUllR2JwODYxenMxS2pDYTJudmds?=
 =?utf-8?B?MjRsQlRXRjJMRnJMa29FcWpNTmVzZlNnb3puSFRHM0FDcVFURlJSSWtlcU1G?=
 =?utf-8?B?Y3hFQTJiS0pxdDFEWFd6VzJubmJwdHNGUlNLSzloZmlDNjNmU24wbEV2Z0E5?=
 =?utf-8?B?SHdDYjR0akZGc0Juc1JsTC9tWHZueUdjcGZrRDNvTDV1dzB3bFAwUll0aTVw?=
 =?utf-8?B?QmE1YysvaTcrOGViMjlvQ2htMUhpbDRmd2xIYTYxTVZmOEl4OXR6clMvVnlV?=
 =?utf-8?B?akpjY0RDMmZHcy9zN0pFWnBpYTRPSUVGMHpGWTN0WFFqa1czWCtYMUoyWDgx?=
 =?utf-8?B?VThHMWdMSGppOXpuM2J4NHM5N0lRbXpaaW1HUzM3cjRCUU4xVTdpTTRqaHAx?=
 =?utf-8?B?N0dDVVpiSS9jczlTS3JGZExJb0hQS3FIbWZ5YUhmUTdnV2RCZjEvQWVoTXVo?=
 =?utf-8?B?YktvYTdnZnhsNndvcFpsb0xJZWFnZk54Rlc4TE1ZUkdlaXgrRHdUSm1wdGNj?=
 =?utf-8?B?cDZOVCs3R1IxU3MwOXJuUUN3OGtMcUM4ZndmbG9seFR6NVNwcjZlZGhvVVRa?=
 =?utf-8?B?VkNJVXErUGJqZ05uL1F2Mk9uTFR3RGhNOVlNRjUvYS9ESEM0a3kyQXQzSHNM?=
 =?utf-8?B?ekZndWpWUUxZRC9sNDFKRndEVXkxVE9LeExsVGU4bStZRk52RE1vMVlvQXpM?=
 =?utf-8?B?Z2J1V096ZjhiZHI5K0VkZmlBbWpPY3hZME93RmJqYjlkQlhkRFZKVHNBajlD?=
 =?utf-8?B?Y1NNMFdtZ3dmdnZ0WnpKZ2dCeGxNN05GZXRvanNiQUk1aEJHbzNBKzR6Yyt5?=
 =?utf-8?B?cS9KbEdIT0hpS2k4Q2k3TVNtMHdscVphdmtyQ2hhOExxaENqa29FcEMxbDNh?=
 =?utf-8?B?ZHkzZVVKcU9rclo2OUJoT1ZIUE0wZDZjYlZ4ZG95cWU0ZGFod0I2M3EySm5G?=
 =?utf-8?B?VDRkWm9weE8wT2hVSzk0bmVvRjlGUU05Vmg5aFE2Y3ZTbERNQ1lFcDBvVkpT?=
 =?utf-8?B?bm45WmRIVlg5K0crN00xbGhHTjNUd3dkRDJKSWQ4b1Rja0tWSHRWYUs4VzI5?=
 =?utf-8?B?a09oU3IxaGFFaVVLRXViWThVTGpaRElOZmpxaEVhS1Y0K2hUM05LczFUTk82?=
 =?utf-8?B?dUp5Vm5HR05JVldLbHhpaWgwZ29PTy9UTVhvQzBjQ1hhaHhuenlpOEhkbmJN?=
 =?utf-8?B?a1I5VzhHZ3pvOHRmbFdGRVJuTVRGdXVBUVpNVFlDK21yc0xONFRuUHUrS21L?=
 =?utf-8?B?UzdSNHJYeTJhcFlIVjZkTnJwbEhpM0FiOUZXNTNYZnpRQUhBbFdaaUlobkEz?=
 =?utf-8?B?Tnp2ZlUwbWR2VDFxUVVRUC9Rb01wNmpLZ25MVXd4YVhVYmxqYjY1bEduRWg1?=
 =?utf-8?B?Y0RpbitHT2lpVTFLOCtZNS95MWhRUE81M0NCOEVMNHJpeWNUTWsyb0I5dDR4?=
 =?utf-8?B?MkRaNkpmS3oxSnVpU1RKeWRqSHg3VnJ4SXRZaEF4UUtUb3VVL040TFRMTVNZ?=
 =?utf-8?B?T2luU2tEUkdMdEZ5WUhTa0Q0WWFxR3VFQ3c3RTNmU1dUV1VBRittaEhPVXQ2?=
 =?utf-8?B?UEFDTWpqOFdvVlFJZCtrcEE3UU5LTTRLQVFqbHU4U0pCQWVRVU1JY1dxd3dY?=
 =?utf-8?B?OHlkQlFUZVRFeGFaS0pFa2d5ZVQ4alJaVGZhSi9hdkU0ZFAyU09qVmF3OVJF?=
 =?utf-8?B?b05CbjhSTEI1WTZscndoczN3ME15bXNtRDRhRkFwZjVnaXlOVTEyMXREOURX?=
 =?utf-8?B?bHBvT0tjcU8xN3VncjI2cEVrQnVkSEpXdFF0eXhEdXhSRzUzdVExdU00MEIy?=
 =?utf-8?Q?IwLMa9?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aj8GsPLc83fiYKt3FstYrFSBEdtWDS6KaQgbnn4/zjefkhTtjDKBShrKHG45cl/b346fDTDZhf1uSoBifWJyvQXq5pod6CVB82FDQ8b6VM+NRZJCYl6xUe5uHOg0wXMKLz1x8g0fXMuY9541ybIIvb+v5fNOZ3bCGV8Q5GLo8JE+VMhgx/i/YLvwQTABezpi9DvJhhg4Ze4auT9V3NCK0kt7jp5GQyxSII07H3v4qCu8h7G2I+PywCGKm2+LjnOajqfsRrc8lrRatUb/3/iyWSMD5P+UVzdRJllBP0ZA1DE4wwronKFqfgA6vhGnY07iQUVSGL4hiN+NwYwGh5uBULtSL8c5gaGFHL/BdAhHZgKED2lbbhwkkObWSGit7d5Ysc73x+H1OikWFBq1ip6lv3BGINt9FkjteQujZP0dFA5YPNUaIfJ+0yT+qLR+mTdauhSwXkIWu/iwnCui+5fTTMzzHV5237wWGJlAz8xcE1qxIGl4S+XiDF9PrH89zFJzWxAlA/2gifT4M0lNytYfkCrqvSFCgUxFmR827nGOss4rPAjrK6G6Fc+2QLZVgp6cugJgOgkKxunOhxTB9T3eorXwnt2EAsJZp7L8HR4PmQ2CuowdCz7TWh7PNZNuaQHRSIYz0TKz7U/0A9bNMFWF6naCvshyoCQf22HGB7E/aztGuEfTKmzGm6VQ5WHp6ehWSZ84xlqHSrsogddgKLPUvQ==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:47:35.9946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6319a06-143c-40e6-61ad-08de3d8bfb6c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8714
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



On 12/17/25 17:05, Tom Rini wrote:
> On Wed, Dec 17, 2025 at 10:00:35PM +0800, Peng Fan wrote:
> 
>> Hi Tom,
>>
>> Please pull scmi-master-2025-12-17 scmi clk fixes for master.
>>
>> ---------------------------------------------------------
>> Fix non-CCF priv initialization in scmi_clk_gate()
>> Fix typo in scmi_clk_get_attibute()
>> Remove duplicated scmi_generic_protocol_version() request
>> ---------------------------------------------------------
>>
>> CI:
>> https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/28770
>>
>> Thanks,
>> Peng
>>
>> The following changes since commit 47b50fb1125c539d80ed3e7f739c02c6486e1b52:
>>
>>   cmd: part: Fix part argument description for `part number` (2025-12-16 11:14:53 -0600)
>>
>> are available in the Git repository at:
>>
>>   https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/scmi-master-2025-12-17
>>
>> for you to fetch changes up to c3c30da46fb7aa31de428bcbb96c973493d70695:
>>
>>   clk: scmi: Remove duplicated scmi_generic_protocol_version() request (2025-12-17 16:36:32 +0800)
>>
>> ----------------------------------------------------------------
>> Patrice Chotard (3):
>>       clk: scmi: Fix typo scmi_clk_get_attibute
>>       clk: scmi: Fix priv initialization in scmi_clk_gate()
>>       clk: scmi: Remove duplicated scmi_generic_protocol_version() request
>>
>>  drivers/clk/clk_scmi.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> I saw Marek had comments on at least one of these patches already, so
> lets get that addressed, thanks.
> 

I submitted a fix regarding Marek's remark:
https://lore.kernel.org/u-boot/20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com/T/#t

Thanks
Patrice
