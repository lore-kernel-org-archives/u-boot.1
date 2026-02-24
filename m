Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D01E9B246
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 09:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F5FE83642;
	Tue, 24 Feb 2026 10:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z7Pk+V1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2311E83D8A; Tue, 24 Feb 2026 10:46:34 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11EB82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 10:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0mnYqwAMVCKMwAsEjNOOjzBjDIXsjrVnHwWTbX6CKgbN4e7lciZJF61LUEpa0P7oiG8AG+cJk2UVAqWj80HA+RzE0pw0rv0ZxFWDsDF+YjTo0fdMZ7f89VELSf9hUPPE+2iQfCyObIgby/fCqS9OHFeOcu/hT2GJifjZY0ywhEtPbw97kpVmiim+m5bQfCz/HLThBjtXPIwd7wdIYzZTpJPb37Qk08vK1SIOF+Og4H9Hmm0dIUM5QaQAsXl7YJnDfCe5SE/M8gcZotasbAyVuStYXJ+Ux01lctYG2hn1otRMHk4Dsv8Rlz2dDaqvtwsvs1JiWtwjZIKx60sMo1mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXxgvbDlmlDzyjFGzZf97D26f1dx4snORFzWLQEqwII=;
 b=ymf4d46ZCn/Y8Q4T+dqBrDADIhBTGbbDVpXSCS7mY24F537Fe92maB7m3wNJgbczaKOfep2g22twWTGbL0CgiyxjW7KdZlIuLi09UfTB20DXUyrUweiSCUB5oOuoZi1lqL688xCVC+E9Df8Ae79kIuuuUwIaqUDv614ShQpHSfDf8wfxoYysXh+UMvGxkD0wZo5u27Cz/p04dDSol7UPBymWUAZ1auOfTHbSp6vIbT4qyHViHQIUo9Do9my7bXl+bUaiOjfv8Bj8176/KQU3QUZnZ04dqhWSFM5Y8sqQjQ5nraLKLRbuw5cRoft0in3XZ8HnJcYyX1iu8fWS2kDktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXxgvbDlmlDzyjFGzZf97D26f1dx4snORFzWLQEqwII=;
 b=Z7Pk+V1SvgrvaeizweBjrPrh1h8alD/sgvNnkNlPVzTJqTM5wXkaiwlkUyxWA1vRSrl3dxn9iJWjDlOtFEmImJGQkWQS/FHqLXbeZ59D4Y2pU0IpHICb2Pb9Z13afgvuN3i7aAt3gAtMWqNLjII0xNOl+jrl9NUbhzjhb9Vb9Y4=
Received: from SN7PR04CA0182.namprd04.prod.outlook.com (2603:10b6:806:126::7)
 by LV3PR10MB8203.namprd10.prod.outlook.com (2603:10b6:408:284::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 09:46:24 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::a) by SN7PR04CA0182.outlook.office365.com
 (2603:10b6:806:126::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 09:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 09:46:23 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:46:21 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:46:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 03:46:20 -0600
Received: from [10.24.50.71]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61O9kHPO2512146;
 Tue, 24 Feb 2026 03:46:18 -0600
Message-ID: <c3ff3d97-18f5-4f32-b05a-3e2fb33ec786@ti.com>
Date: Tue, 24 Feb 2026 15:16:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: tps65941: Enable FPWM bits
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <peng.fan@nxp.com>
CC: <j-keerthy@ti.com>, <t-fujiwara1@ti.com>, <u-boot@lists.denx.de>,
 <gehariprasath@ti.com>
References: <20260129072857.1437272-1-n-francis@ti.com>
 <a5661115-be8e-4e29-8c5f-923845f90ff9@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <a5661115-be8e-4e29-8c5f-923845f90ff9@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|LV3PR10MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: eb936bd7-ce59-4677-c06f-08de73899251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlRLQ1JlQzA2RmhxZ0pOYTNYVlcrZ2FZNXh4T3lic3JRNkNpMDh4ZzBOUUE4?=
 =?utf-8?B?TjR3T2poZ1puRDFNa2RVMGNzRzN3cmNKU3BTU3BOczFGTEd0eWJuaVJkaFZW?=
 =?utf-8?B?YkRSaWNxbEgxYmNZbmxjQ2lqalRtbEF4UWhLR0tFanFXUlZMdlk2SHg2T3Bt?=
 =?utf-8?B?Q09kc21NRXUvSWlySjFTeElSQXl4WW4vVW5tdWdmRmFUK0kyMkZKNWFjbE1E?=
 =?utf-8?B?SnBuTENDRVg3ZEhQWHFWb2R0YVd0alM0VlJHeVprK21yTUp6N3c2emxyWWt3?=
 =?utf-8?B?cFNqUk1qaVg3MGwwb3k3V2VnRng4dURmeTBwcjVwdTRFK0RTbkJSMHVlay8w?=
 =?utf-8?B?c0NiT1JUQzc0YzJ4TFpaSW0yYUwyY3pZa3FJdnpab2RiYWo0ditWSkNxTUZq?=
 =?utf-8?B?RUlUTFFubnFGTXQxa2t2bFVQQU1ydVd5TFpHelREQ3p5azlOOWhpbnA2SlFQ?=
 =?utf-8?B?a1kreC9WaVpKbXAwNTlrYmZQQk9JQ0pXYjRSQS84RGZ5bFI3dyszRWdhdnFo?=
 =?utf-8?B?SmYzZHVQZHZPNWNrVkYwc1JwSVR1dXdtZHBaOUZFTmd6L2x0d3ZpZ0dYV2dN?=
 =?utf-8?B?Yy8vUGc4OEppUzRqWldsT2hqT0YxVjVrZTRoZitrSnhEQmxEWjJNRldSa2Zx?=
 =?utf-8?B?TFV2YVZpODczSWZCVzVFSjRNKzNFMlNsdUxlTUMzcGJua2c4SGNtaE9OYXoy?=
 =?utf-8?B?bmk1Z3BTZ3lXK2VQZyt0QlBVQldWUjFGQmNWUFppb2lEaVI4Q1dTQWl1VE14?=
 =?utf-8?B?M0FqcDh1dnRTMzMwR1pSSlNLbzlMam9DTXdwNm1wUTY5OC9rdVVuakR0TFZy?=
 =?utf-8?B?bmNZN29YZzRCWG1FOG5PMGlHdW9FeVg5MVEzNjA1cU44M1I0ZCtPb20rMW9E?=
 =?utf-8?B?RVp4ZDIvVjBVLzVrSUNOVXBlU2dUV1NzNTJPUDh3dmtSV09yRWx6TUcwamMx?=
 =?utf-8?B?aFh3aERDYk1wV2tkU0kwUExtTmYzUTdWbXdZYkFzTW9ydUlvVTNSRzZ1eUxy?=
 =?utf-8?B?QTVqQlJHdUxPVWE5RHZPaFZlRWsrYXc1NUk1NXVObXNScmlDS1ZKb2tON1RN?=
 =?utf-8?B?dU9YSTJBVUk2bElXeUVLelNJSGRpWStwQjQvRlZCa0pjTzdUMmdhRDJqYmVC?=
 =?utf-8?B?NFAxeU5zQUZBNXZYckRUejhUYVdPV2FhcFVhT2k0SjFxQnArVUs2N1RIRkh5?=
 =?utf-8?B?VmF1N09TS0pWRWRBaXl3WmlIZmtYRTNadldKZVUxU0txRmNHY1pTQWhCSHdV?=
 =?utf-8?B?bm5uMGNiekJ2VURpWmVmcTNOamdqU3c3czFhMU0wYlRFZlRjQ2ZPOStWZzRV?=
 =?utf-8?B?QXlQcStOMDBFK0xxaWxvSjBiUWNvNlh0MWxERWNsTldmbHduZnVvdkxCdzZN?=
 =?utf-8?B?bHBXMUw0VUsvcG1sK2tUTmlBWXp3UGtIaUp5U0RXQVdsdTVpL21LcE1jSk5P?=
 =?utf-8?B?cWsyWVBOcTgzZk1oQ2hXaDFYZmdNMks5YTBzR2UybjIzZjEzVTIvOEVrZk5Q?=
 =?utf-8?B?bDBFQWl5RFRkRm5TNkVNMDh3aDduZDdPNlJIV0ZzeHZIamhWNld5ZlYzSWZB?=
 =?utf-8?B?L3NCbGJDaVlSS1QvYmc3TmtlUlRmNmVkZmJWMmxiL1JZUjVtMFFQOVFQZlN4?=
 =?utf-8?B?c0pla1pUakFiL1QvU1VyZlJXSG5USzBOUWlJSklYS04rQmFUSkNnck15TVYr?=
 =?utf-8?B?a3dmMGxiN0ttQ1k2MEtQYTJzalRlUDdrdm0wL0c0WVdEOXZaSVNiUHlrQVdD?=
 =?utf-8?B?ZzZHMFNyL012WkxKcWN6R1Y5SXl5aU9nME12dDBkcHZCNXJrbWFmSWp0WldH?=
 =?utf-8?B?N1lxWlRoMnJkM2w1RG9ZbzFJQTRRTW05L0dOOVNaVExqWGlNeXJDYzNNTU1j?=
 =?utf-8?B?Rm9tYTUwaXJBZlZnYi9ZdHNBd3JwUnd3dkpPVmVQQjAyOEU1cCt2K01Gdmg1?=
 =?utf-8?B?RmpWVVNXUUMzcGwxaDdUcWxFajZ1TTdJbkVGMkRLMlhNTE5hS1BBMnp5Q0xQ?=
 =?utf-8?B?aUxWTzVQZGhlcXRqNXRnTkl5SFdLS083NFY3SDZCakNZWVVaQTM5bWxNOVNr?=
 =?utf-8?B?a3MwOG9IYVZka3RKUUlnNGcwRW5uQzhUemVPeFVYa0I1Sk5ML2RuVmZRTFYv?=
 =?utf-8?B?ckdDWU84dVhURmU3eFRjN2FSM1BEQWJUQjFKalFBeUVyVC9ZQUFHVzJQNzVJ?=
 =?utf-8?Q?DUVb7ZchaLfXg7iLPer+ZPE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /vR6KrTlnK17mW60FndJAESQZdWEGpqdcjRNHzCmfChPe9S43uBd+aplx3+0dd5jqY9QGdxRc1ABXDu12AuyLRfW/8LMO257l31JJq4FQH0W+yuPpuf+zHP04LLq/5uOaajkiKvtJyijbQ3x/AmDw46/iF3I/Pdf+FY+znCHSkdNhwC5bRrAqX3RcBvi8M8bPiJGvz8Xg4/TdRkV4TNNXAbCG43p4INttvVMe/NBZAiJtl+5DVfPjeLX8JYZP1W74nE3AXedRe2KD32/iaOckrUDqw/9zXzRqy6/LaPpFXHHpf+vpxb3SE8pN8gKT+937Dgaf+8PL13jCLNWhbwHzp2D79JFxiz1KK3rm7unPW41RD21i2lg1jLddAxmbUUVlenLO0Xu4EvQIRNcbFBCFoOTtSg7bKUAyDrW9Ellk4kreZ+5SvjP5YJ4tKpE0UN1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 09:46:23.5073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb936bd7-ce59-4677-c06f-08de73899251
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8203
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

Hi Udit,

On 29/01/26 20:45, Kumar, Udit wrote:
> 
> On 1/29/2026 12:58 PM, Neha Malcom Francis wrote:
>> Depending on the phase selection (single or multi), the FPWM bits
>> configured forces the regulator to operate in PWM mode. In case of
>> multi-phase selection, the FPWM_MP bits enforce the regulator to also
>> operate in multi-phase. This fixes correct multi-phase operation.
>>
>> Fixes: 065a452ae6a1 ("power: regulator: tps65941: add regulator support")
>> Link: https://www.ti.com/lit/ds/symlink/tps6594-q1.pdf
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Tested on J721S2-EVM
>>
>> https://gist.github.com/nehamalcom/a74fb2a3b59421d0e04693c7d244fdb4
>>
>> Before the patch, the kernel TPS6594 regulator driver would warn about
>> overcurrent on a buck, this was due to incorrect multi-phase
>> configuration.
>> This patch resolves it.
>>
>>   drivers/power/regulator/tps65941_regulator.c | 13 ++++++++++---
>>   include/power/tps65941.h                     |  2 ++
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/
>> power/regulator/tps65941_regulator.c
>> index 2561d6f4c6c..e0297302914 100644
>> --- a/drivers/power/regulator/tps65941_regulator.c
>> +++ b/drivers/power/regulator/tps65941_regulator.c
>> @@ -63,13 +63,14 @@ static inline int tps65941_get_chip_id(struct
>> udevice *dev)
>>     static int tps65941_buck_enable(struct udevice *dev, int op, bool
>> *enable)
>>   {
>> -    int ret;
>> +    int ret, idx;
>>       unsigned int adr;
>>       struct dm_regulator_uclass_plat *uc_pdata;
>>         uc_pdata = dev_get_uclass_plat(dev);
>>       adr = uc_pdata->ctrl_reg;
>>   +    idx = dev->driver_data;
>>       ret = pmic_reg_read(dev->parent, adr);
>>       if (ret < 0)
>>           return ret;
>> @@ -84,10 +85,16 @@ static int tps65941_buck_enable(struct udevice
>> *dev, int op, bool *enable)
>>             return 0;
>>       } else if (op == PMIC_OP_SET) {
>> -        if (*enable)
>> +        if (*enable) {
>>               ret |= TPS65941_BUCK_MODE_MASK;
>> -        else
>> +            /* Enable FPWM */
>> +            ret |= TPS65941_BUCK_FPWM_MASK;
> 
> 
> I am wondering, why you need to set this bit , I see default/reset value
> is 1.

Even though the reset value is 1, NVM configurations done by HW can
override this.

> 
> 
>> +            /* If Multiphase enable FPWM_MP */
>> +            if (idx == 12 || idx == 123 || idx == 1234)
>> +                ret |= TPS65941_BUCK_FPWM_MP_MASK;
> 
> you can use TPS65941_BUCK_ID_12, TPS65941_BUCK_ID_123 and and
> TPS65941_BUCK_ID_1234
> 
> instead of 12, 123 and 1234

Will make this change

> 
> 
>> +        } else {
>>               ret &= ~TPS65941_BUCK_MODE_MASK;
>> +        }
>>           ret = pmic_reg_write(dev->parent, adr, ret);
>>           if (ret)
>>               return ret;
>> diff --git a/include/power/tps65941.h b/include/power/tps65941.h
>> index a026ec56958..a8b1044b2f9 100644
>> --- a/include/power/tps65941.h
>> +++ b/include/power/tps65941.h
>> @@ -20,6 +20,8 @@
>>   #define TPS65941_BUCK_VOLT_MAX_HEX    0xFF
>>   #define TPS65941_BUCK_VOLT_MAX        3340000
>>   #define TPS65941_BUCK_MODE_MASK        0x1
>> +#define TPS65941_BUCK_FPWM_MASK        0x2
>> +#define TPS65941_BUCK_FPWM_MP_MASK    0x4
> 
> 
> Check for alignment please

Will rectify

> 
> 
>>     #define TPS65941_LDO_VOLT_MASK        0x7E
>>   #define TPS65941_LDO_VOLT_MAX_HEX    0x3A

Thanks for the review!

-- 
Thanking You
Neha Malcom Francis

