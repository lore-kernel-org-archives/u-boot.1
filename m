Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE6AE9B24E
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 10:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4966883D8A;
	Tue, 24 Feb 2026 11:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZtsOamN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED9883E36; Tue, 24 Feb 2026 11:26:41 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8BB083D8A
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNLPYttpPxgFwJ1hDtm6aGXgpR/GVr9H1g7Oue53i0kjUNR8/P3GKxNRDH3nF0UliMRKQ/19MN/2mATtHGDF/ykJ83k4PeuUJuDvJ5Y1UW9/0Z+wU+p9QqhN64A5DLg+S4O/WJZvvOAetXq3uxAjezn/mDqHvk10OIEnI47AdjqxYXOB+W3UP15kG/3BLnVeoNjMNnP5IeRBvuxMFUa9ZRiFQ/s6b+xwnFARSkwQzrGXWiQ+qWdzfhQqYnZeSAW76dX1aXdolWm6VoJ6erpNUpi9OTGjtRL3eQ+ZoLsFP8UeE9ncVBqpPmgAsXCK88AOCB3Em67pfXDPjVzWHBsIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cabgCWsVovq9hfXU3MAXoWbJRf+YomCy8y3VsjKn32E=;
 b=RJXcIhbx9/Oq9vFIXuGHMeR5uBHSjn8CeCt4pjct0/uGT08Q1B2xbUr9SvTBVfXawS0XOiMwhkBFs3iVGrUJYks5nxV7Cc0iYxE/FCKYhcF4JVJBEYnfhnnns1lQT8EpNFwKNI2mhVFE2zf6D82ikfwUDUG86UaCeNTkDTEFA4hp7I3dxdH2kT+72PkE9Ii866PeqaL1YtBQAYjkRCN4YyTnc+wxznio5f48Xr9SmKAVXCd0vhcK7JoX+EWoEYt7cwS7GJf2mIbCnoOa4nhUZ/Kj1YzQMZmX8phMsMIAt6TnFkt+hbXF1dwRLDyp/nHHp8Sa5vzz5pVK9kReG9NEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cabgCWsVovq9hfXU3MAXoWbJRf+YomCy8y3VsjKn32E=;
 b=ZtsOamN9nKVYQ0cH5UF9gD98fskUeNy5ZNdhD9/bsbW5TJLIRHYEapMOz+isfSG/B6MIUHb8xg68nhkiq4MEuMYauxUXfCISFlf2AeT0dHYwoK82l8Gvc5/h9zq9+G6tWQ/XYYV5/7kwZfQHYL5oFU8h6JA3M89GL28zjDwfUErrdjNDoTFnH4Lrsw0NeylI75/MrTQWGz72CQnWV3o/pN2zuir8yWUmYRboEV5WlB0Av8HnT4R9IFPTfdGMNwPDWXvxe3brN6doUvFkFXU9N+dZSQvibw7lNMUnxHqpN7udO1quWT60K9lJb1fEgGhUHQ2+Td7mwXNrROGbOkq9BQ==
Received: from DU6P191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::6) by
 AMBPR10MB9683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:763::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 10:26:37 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::88) by DU6P191CA0066.outlook.office365.com
 (2603:10a6:10:53e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 10:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 10:26:36 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 11:28:43 +0100
Received: from [10.48.87.244] (10.48.87.244) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 11:26:35 +0100
Message-ID: <8122b9fc-6aaf-45d2-9682-d62197074572@foss.st.com>
Date: Tue, 24 Feb 2026 11:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: stm32mp: Add STM32MP21 support for RIFSC bus
 driver
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>
References: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
 <20260210-upstream_rifsc_update-v1-1-74c813fa4862@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260210-upstream_rifsc_update-v1-1-74c813fa4862@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.244]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|AMBPR10MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d777f7a-1d89-484a-d570-08de738f30ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zit2K1NCbUM0TzlkUHAwWnJDNTJQQ01nOU04cld5eDF4bTBMUmhqczNXVW0x?=
 =?utf-8?B?UTZRVlpNYTU5ZHJHY0gwZW50ZlYzaUdzZWE4Q2N2MDBLcXVTYW1GcWZrY0Fn?=
 =?utf-8?B?RjdyeEo1bFg2Z25ZZVJDeDk2ZEdLVk4xaXdURlRuTTNJa01YV25nZVhXYVJQ?=
 =?utf-8?B?RDVQTFdJSG45Y2RtVEZkWlVsMUkvWXZXOUxvSkRTL2NkRWtYUWp2ZFZ1THJY?=
 =?utf-8?B?YnBnclJmRVdud0R3UVVheEZVcFRra3dDNW45SDkzYjUrNGR3ZzEyRDVUcUho?=
 =?utf-8?B?dVB0Q0xtNWM5Z3hwR1NwSHd6cXVVMTIrbWIvTEhUaTJrNU13Y0tqRmNPa2xI?=
 =?utf-8?B?S3VGZ29YTUxTdW5yVjFiWk9PRWY0b1lwVXhIN2Z6RTlwQllRU2FWOEM4ejRO?=
 =?utf-8?B?c3liaitGb20zbE5SMTN0V29XQ2V1ZEE5OThtL29zRkdQUzF1UFJLamFrOHZS?=
 =?utf-8?B?L0E2VnlwQUErTjFIb0NrcmVrWU0yV3A1SHBvRi81dEdvcXdmWjFUSTNSRjkz?=
 =?utf-8?B?VUkrWWRjdWtCWW80MlIyNlpFb0c2R2JFZE9NaHplU2dNRnVyTkIvcWg3d0ZT?=
 =?utf-8?B?VnVxQ3ZtQ3RzRUdhZmVWMmJCaXUvL3lxaE9lVlJVSlFjQm1LZXdjQ2dtaTN5?=
 =?utf-8?B?MUFOOXZtLzg2ZVowWWwxRTNCbHo5cFZQNFdoSXJxcGxTbnJmY0xnaXdBeVJK?=
 =?utf-8?B?b25pZ1VzSER6R3hyVHlVcnY1S2hVTjl4eUVCOTIzenA1M3owZ2dGaHVlSnI1?=
 =?utf-8?B?NWdaNDNOKzFDdkhDdVB4VHpuaGNncWRnMG1Ocnp4aDROazlWeVlsdmFET0Iw?=
 =?utf-8?B?U2xWUGFMOUVEbmFDNmxVbE5QcXh1ZFJyN3RCMDk4dWYyN2twbitHQVA4aGdS?=
 =?utf-8?B?SllyVm9MWWE1dWRVVE4zZTczT1RRUXZ1L0o3ckpvWUFBSTV0d2JCSHhrWmdV?=
 =?utf-8?B?RUdqNklrWnJkY1doYXM5cUhtZUQxTXhyblFBNzJybzM0bFE3a2NWRlYxUmFo?=
 =?utf-8?B?TXljQ0dRalZha0R6MFhkb01nUFVESStuM1I4WndoNEpQa2k2Nk9RK1BsSEV6?=
 =?utf-8?B?TjYxTmhoTmQyeEFhcEk4QS8vNjE5OGloUUd6ZjdJTDhYaXpDMW8zbVgzcEpo?=
 =?utf-8?B?Qms2MGJtQkVJbkd2UG8zWHcrcHJVU1k0QjEyV0lSU3ZpSktRWnlnNzdOcWtZ?=
 =?utf-8?B?MVJTajJKUnI3aFYreUhKRmI1R0h3MXdhRDY3elJQaWxzSlBvM29mVDB2aW13?=
 =?utf-8?B?S1Axb24rZEZldUZxUGxVTGhBcUJ3Tk1iWFRZYkwzRGtldzhCL2V6R1JRZnBz?=
 =?utf-8?B?SWY2bi9hUXNoK3lDVFlqeFkwZjNYSDBMTHN3VmtlRE54dXo4Zmlqb1dDdFQx?=
 =?utf-8?B?aEcrSzJ5NWQxSzJlMnE1Z3lqRlNKQ3hrOWRpQmRFbXBnOWt0bWpZUVV1UXNj?=
 =?utf-8?B?TnpiR21lc2N3R3V3ZTlEZVZ1Y2pJODN2TnlPbllVMGRxN3daU3pEejB6OUw5?=
 =?utf-8?B?dTYrTGVJWXJrTm9RaVlYZktQd01CMUZ3KzFNcTFKSkxaSU82Skd3bjFvZWg4?=
 =?utf-8?B?Y05BZ2srZVJiWXZJME95M0lNanpTZUhLMlpXM01tNGNnVUxXU0UrcWRuZXR5?=
 =?utf-8?B?SSsydkVDZ1pROXgyVWpOejhrV1dxTHFudTJaNUdDR2lFRUF4bkpyTm9LdG1x?=
 =?utf-8?B?eGxRWkZlWXRuL2E4dnJ4UGhER1RjcnRIWnFLajRsSFVubUQ2Z0lGQ3VIV2wr?=
 =?utf-8?B?QUVMWmtjS1I1bHRjaGtpKzdYWUh2ZG5vVlNaaWo5WWI3Y1VpMDJqT2tTNXRE?=
 =?utf-8?B?eVc5bVdrYkk0clpLR2twSFp0cmZBRUt3Z1lid3FMaVNXSkRYNVhpV1BPRzdD?=
 =?utf-8?B?V2NKOWxYUlVSUGNJb0lWaHgwc3luQkxoYk4zckxtaEZYM2hnYUk3S1VPemxr?=
 =?utf-8?B?S2twQzBTbTNKMDE0WnVkcXZaOS9LSzU3Z0ZaamtQZ1kva0owaTNyMGhCV2JS?=
 =?utf-8?B?dUFhWUE0Rm5FeG1UQm1OMTBMQ2lnai96ZmZGY0VaWXFxOTdUOVNWd0FJeWMx?=
 =?utf-8?B?SnFjZTEzS3RpLzMxQ0Q0eVo5NEFIQXd2djY5WThmK3NGeDlHdHhNSGlDRXFM?=
 =?utf-8?B?NVcxQWtRSXpOc1hGODZxMUVhSFgwMXlGQ0VQMWwyQmNRc1h6dlFONFpIck8v?=
 =?utf-8?B?eW9rLysweU9Sb1ppL1R0YVp6L0dlRUNyVTR5clFlNVQzR0FGUk1Zakw2WUVr?=
 =?utf-8?B?L24yZ3FTNUZHYU9RWlVCQkJBVURBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: thbbxX+IVwlFX9GxcCYKD8VHBa0qHHjcQbKQnpeRIwuB2+DTQtfqESfmsjd7hmrDKzemqXqsjUUAnxw5C+eWdBJn5td2qvFq2Y3V833fRkVgPr3aEeCfrobdGtpbXZjXJWl+7AQPBv0B9VUs9CqholmefDsntZaUwIrqZQNNEypYdEPZnn9INjScz09fx1b+RSil4QNL/6vnAhqY1x5hr554+d89/IdOEoNJTXzXI3Qe4g/BoFwFu4xubS4KiM1AcSBM68JnloGL4noSuNytihJ88+V59gLJtV4Blo+1+ac155unjwm+ifSkP2CZGkE5UOw6wOAD2fgHn+x2KjNdHgNKVW4OhTmPg3W/sCXuQL2bJ5FddxNE0sqZTAxlbtEc6imSrqW9JL7HxHGaKQr+3ynpk0mzq/yLIY/MaLXxXxtAOpunPeu96sMnzVFbhHci
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 10:26:36.7077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d777f7a-1d89-484a-d570-08de738f30ba
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9683
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

Hi,

On 2/10/26 11:26, Patrice Chotard wrote:
> Add "st,stm32mp21-rifsc" compatible for STM32MP21 support.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
> index f8f67af4449..cf8026088f3 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
> @@ -367,6 +367,7 @@ static int stm32_rifsc_remove(struct udevice *bus)
>   }
>   
>   static const struct udevice_id stm32_rifsc_ids[] = {
> +	{ .compatible = "st,stm32mp21-rifsc" },
>   	{ .compatible = "st,stm32mp25-rifsc" },
>   	{},
>   };
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

