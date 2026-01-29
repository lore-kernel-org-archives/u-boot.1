Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75DDD6B072
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E729583FDE;
	Thu, 29 Jan 2026 16:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YqWFYZ9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B5583FC6; Thu, 29 Jan 2026 16:15:39 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D96D83D9C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFPAiPJwZdOpeLs7Dzoj2hCWcq1GwEdQZU5QC63PCehZuvQNeLdtDbYOyhwYTXBbEQlk2jpg+J3d2roT2PPD7l1NADUlTJZUoOv46zg3mHHTNh7YsQh12ollGePJoOxTQUvRHtOEEioo2FbgYXHHWPzqcqVEeYDtvUYtFLwAtTM4eBLi7hDkxRffBpO40zr22yXmHuhFb+AvlR1NO6d1+umSLk1F1Rs+QojuvU/raDo0P4n7etxrHpGbYHuurCWZZn+fPztMM0q46l30FOO3LeZxwBtXKXlD7S9v8uz9MhSEarbg3tvjXt5RzSpvXvDm9PGqOKQHKu5hlSQZVouWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+THExh3aDW/Dww7MKeno65Hz9TYuYPOsbt4lHCRS6o=;
 b=CVY//lxCTC1oDKXgh8TZQoEWdYDCmS7TyEl3uBRumFQCyedSjSIfHN7tBbu4N106t0fXOxbDgl1EiZjG+mwL4JW/H+z17G/YHz6v1rcIeECcryffHsc1v3rjb8JtbHAHeQUObgLZIFq5CCKc4f9geaQxnFXr91sJl4HcesMf9HaR1CzILRRlIuAp/yJRCO1Nli4KAT3MQ0YQbKmbNhLIbqz7LVrbT6Vp3QQC1rXTxVyI84va1Va5IRSdpvKexR+HpU8MRjOj2+DpvLzIebqgtb2q0gGSrdmRiToHDVEDcX3ql+6b5tcxRHnBcKZeshJIv8Ll1+SI920gIEKAYX+8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+THExh3aDW/Dww7MKeno65Hz9TYuYPOsbt4lHCRS6o=;
 b=YqWFYZ9KAPFu2g2r+F/ijEP02jTP3cWwG5BlTGHNGdD6Xpq7rPE3gXhs4SDpAS0IbbSECl8MUL/QXuIJ5+bLYRjHdo9rWWeDS7wGbGJ2rzdAS2FNyGO+8lAB16e0BxVknG+oq+tntleS8P3dUAaFG5/dAWkEWRuuC60Qu9Om3lY=
Received: from SJ0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:33b::34)
 by CH4PR10MB8193.namprd10.prod.outlook.com (2603:10b6:610:23c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 15:15:29 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a) by SJ0PR05CA0029.outlook.office365.com
 (2603:10b6:a03:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Thu,
 29 Jan 2026 15:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 15:15:26 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 09:15:09 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 09:15:08 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 09:15:08 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60TFF4V83925381;
 Thu, 29 Jan 2026 09:15:05 -0600
Message-ID: <a5661115-be8e-4e29-8c5f-923845f90ff9@ti.com>
Date: Thu, 29 Jan 2026 20:45:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: tps65941: Enable FPWM bits
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <peng.fan@nxp.com>
CC: <j-keerthy@ti.com>, <t-fujiwara1@ti.com>, <u-boot@lists.denx.de>,
 <gehariprasath@ti.com>, <u-kumar1@ti.com>
References: <20260129072857.1437272-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260129072857.1437272-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|CH4PR10MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 39504eb5-2c06-40b4-f7dd-08de5f493ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STZKdzdic1dmWFJjRGdpN0V3UG5MUXVaN0Z1Y24zZzhmTkwxSkZYNXl5UU5o?=
 =?utf-8?B?b3ZJbk1nSjgyUWRlUlZqUVhTV0pXNzFoSVZyL0lRejJ1QnlncHJjKzM0Zmoy?=
 =?utf-8?B?UnhJSkZIOUIxbTRiMEhiZWtIWDhXQnhNQUtxRlFCVTltMXhxYWRnaGlKTmRC?=
 =?utf-8?B?TmM1VjFrUnJOZ3dUVm1LNnVaUnRxTkZZT2hPODlJQndPbUhPVy9rV1ljMFlR?=
 =?utf-8?B?VTdBdFpyUkl6S2RpUS9zZnNRaWY4K2hESjZJRndSdEJlQWRBRE1pQTJ1TEpk?=
 =?utf-8?B?bHo3dG9JVGxJV2JncUU0MlhaMTFNTXp6SjZNcVB1cFZlT1dVZmwybHVUR1lv?=
 =?utf-8?B?SWxoRTdOcGtaQ1hzc0F2QjZNTXREY2xKYjJmcHQvQ0tGWnFYOW1SRTFxQUFk?=
 =?utf-8?B?b21FdnJ1TXZ5bEk2aG1Qd1hFbjNHaUZLbG54aUZzWmR0RVAwV2FMTVRvYkpW?=
 =?utf-8?B?cmlLSFU2cGM5Q01JaVduNTlTZGdFajRRdDAxR0FnWmZzY1RMb2V5V0s3Q1Qv?=
 =?utf-8?B?N3NSbHh3Z1dJUDdVZlYzbDI0cWNabVRDZGErRmdWZmtBak1JY3lCVkJEcTk3?=
 =?utf-8?B?RGVXdlRyenpEeXhLRWtNVmtkNGtlU3liR1NZcGp3NEdpaHdtRmJrRHFLRGZQ?=
 =?utf-8?B?UU4vaTJDcTJuNnhIbFk1RUFXVXcyTVQ1WktLcEhCdzBwZlZaaGM3eWNocGF1?=
 =?utf-8?B?a2preUV2Z3Rqa043YnVvOTJ5dGtGV0RLOHdNdmpIcTlaSDlsZmxRaTZCTG5r?=
 =?utf-8?B?NWZuVFR5TXRMN2x4VlYyeTNPRWhoMWRwUmE1UCtvMkVSV2dkcFY1TktSeC90?=
 =?utf-8?B?M3ErOGhLNnkwd2hvRzJ2dG4weWc3QXlnaXhVSzhiaytMK3BRZ3N2SU04RVln?=
 =?utf-8?B?OURXMTRER25ZQTRTUmNFVUNMWUN3endQUFZUOVNKTzIwbEVrOVVNQmFLR0NP?=
 =?utf-8?B?aEd6TTc2d0dqNURnZWV0cnJmMGxNSmRSamgwcnpCZk51dDBic1JDSm14am9i?=
 =?utf-8?B?dVM1N1VoTE5PanlNU1N3ZFE3a3crVkpyWDYyWlV1RFBrTFRsb0ZrVnQva1hv?=
 =?utf-8?B?YzFqZ0FEVmZaeWxibE81bzZhOVhsUVlKcXFST2dmZmg5VXhWYkJnUDkrRXYr?=
 =?utf-8?B?WE9MdVlTaFRFclAvOTNSK2VxM3IrYXVWUldocHpIRk1hVjIxRGFIN2pQZ2pp?=
 =?utf-8?B?NmUwWHdOaTc2eEcwMC85NXk4NjduOUV5YjZZellFTXFiWS9EM0lrNXhGRnI0?=
 =?utf-8?B?ajdVWTdRSThDZkg1ZVRFTGl3SlNYbXcxY1A5OENCQVZNSzhkcjFhS1FnUnor?=
 =?utf-8?B?aG82eThJL2xKeFhrNDFZbGtBNVlGNzB1TVZFZGo4SG5JaGZaZkRoazJJZGZZ?=
 =?utf-8?B?Qm04amRmVzVidVdEd0dCdjk2Ymd5czNkcG5GVVdDYnBocGo1ZzVUYnJ2a1ZY?=
 =?utf-8?B?bElTTDFXUEJyYXFtTzBVUUpkazdabExrOThraEdKMnpsYk9Ib2RGMjJDck82?=
 =?utf-8?B?Y3JKTGwySHZpQmdGczhlTWU5MzZRL1pkcFgzWHVFSGVjelJ2cWhMdDlyQlVW?=
 =?utf-8?B?U1lVQ3d1T3NxN3VqcmRnWFN5bldYejlHbVdqRHRjeWZvUDhJNGFWZkNUaTBX?=
 =?utf-8?B?SWdQOVBqbFpCWEI1UXRxVGJXdmdtbkJlMGZMQW1YUEcvbkM5aTVISStMYlJx?=
 =?utf-8?B?V2tkRUt1cHM3SFowM3VGemFVbVJUUDF5SlVuNXI0NHJ1bTEzbGxlZEt6clp4?=
 =?utf-8?B?eGM1b3ZWMzZ1cGV6UFN5S01wVFQyQkpEckVtY0ZwNTQvbTk5VDBacTlidm1r?=
 =?utf-8?B?bWJxZGUwejdBemlPdFo1RzJHTElud3o5L3c3SElxWXBlSXprbW9wZklWcWs0?=
 =?utf-8?B?bVpydWZkWG1ydzQ4NGw0MkFTaWtFVVNUK1Y1OXpFYXBWT3ppYlBwYnZWdnh1?=
 =?utf-8?B?L2xyN25NVXI4RzJGNUtMSWRLWDl5UkNCTDdINjNSb3FDci9ZcmoxdXZxMDdq?=
 =?utf-8?B?dXo4VGt2RG1OcjJ5cmdVYmJCcFVtdkFOMk01QVQ5dEFYRGcvRlFKRko5Ryt4?=
 =?utf-8?B?MnFndkpvNWNQbW1oa1VOTklubVFsZzhaUVBzbzZLYTFIQy9qK2lwSC9VaVhL?=
 =?utf-8?B?bVEvT0p3NlFsOHpaOVNMRDNqMkFacW9zQTl0OEpQT1dzSG1EYk5TNE44UHp4?=
 =?utf-8?Q?4OE8oSdm7vtEamew4ilhok8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 15:15:26.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39504eb5-2c06-40b4-f7dd-08de5f493ba3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8193
X-Mailman-Approved-At: Thu, 29 Jan 2026 16:26:51 +0100
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


On 1/29/2026 12:58 PM, Neha Malcom Francis wrote:
> Depending on the phase selection (single or multi), the FPWM bits
> configured forces the regulator to operate in PWM mode. In case of
> multi-phase selection, the FPWM_MP bits enforce the regulator to also
> operate in multi-phase. This fixes correct multi-phase operation.
>
> Fixes: 065a452ae6a1 ("power: regulator: tps65941: add regulator support")
> Link: https://www.ti.com/lit/ds/symlink/tps6594-q1.pdf
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Tested on J721S2-EVM
>
> https://gist.github.com/nehamalcom/a74fb2a3b59421d0e04693c7d244fdb4
>
> Before the patch, the kernel TPS6594 regulator driver would warn about
> overcurrent on a buck, this was due to incorrect multi-phase configuration.
> This patch resolves it.
>
>   drivers/power/regulator/tps65941_regulator.c | 13 ++++++++++---
>   include/power/tps65941.h                     |  2 ++
>   2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> index 2561d6f4c6c..e0297302914 100644
> --- a/drivers/power/regulator/tps65941_regulator.c
> +++ b/drivers/power/regulator/tps65941_regulator.c
> @@ -63,13 +63,14 @@ static inline int tps65941_get_chip_id(struct udevice *dev)
>   
>   static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
>   {
> -	int ret;
> +	int ret, idx;
>   	unsigned int adr;
>   	struct dm_regulator_uclass_plat *uc_pdata;
>   
>   	uc_pdata = dev_get_uclass_plat(dev);
>   	adr = uc_pdata->ctrl_reg;
>   
> +	idx = dev->driver_data;
>   	ret = pmic_reg_read(dev->parent, adr);
>   	if (ret < 0)
>   		return ret;
> @@ -84,10 +85,16 @@ static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
>   
>   		return 0;
>   	} else if (op == PMIC_OP_SET) {
> -		if (*enable)
> +		if (*enable) {
>   			ret |= TPS65941_BUCK_MODE_MASK;
> -		else
> +			/* Enable FPWM */
> +			ret |= TPS65941_BUCK_FPWM_MASK;


I am wondering, why you need to set this bit , I see default/reset value 
is 1.


> +			/* If Multiphase enable FPWM_MP */
> +			if (idx == 12 || idx == 123 || idx == 1234)
> +				ret |= TPS65941_BUCK_FPWM_MP_MASK;

you can use TPS65941_BUCK_ID_12, TPS65941_BUCK_ID_123 and and 
TPS65941_BUCK_ID_1234

instead of 12, 123 and 1234


> +		} else {
>   			ret &= ~TPS65941_BUCK_MODE_MASK;
> +		}
>   		ret = pmic_reg_write(dev->parent, adr, ret);
>   		if (ret)
>   			return ret;
> diff --git a/include/power/tps65941.h b/include/power/tps65941.h
> index a026ec56958..a8b1044b2f9 100644
> --- a/include/power/tps65941.h
> +++ b/include/power/tps65941.h
> @@ -20,6 +20,8 @@
>   #define TPS65941_BUCK_VOLT_MAX_HEX	0xFF
>   #define TPS65941_BUCK_VOLT_MAX		3340000
>   #define TPS65941_BUCK_MODE_MASK		0x1
> +#define TPS65941_BUCK_FPWM_MASK		0x2
> +#define TPS65941_BUCK_FPWM_MP_MASK	0x4


Check for alignment please


>   
>   #define TPS65941_LDO_VOLT_MASK		0x7E
>   #define TPS65941_LDO_VOLT_MAX_HEX	0x3A
