Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55739CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 03:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E5B8469A;
	Tue,  5 May 2026 05:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="q2nZMjrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C55846B4; Tue,  5 May 2026 05:51:57 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5450A84661
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 05:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpJ+uVLKV2M7ZGQsdZtPpBSdAybFprBijvbgOYJFXpMs7APJrnv+Z74mcEaYC8Qzo6N6PxpYpofgeqplI2Psq9jGI+BIT7B02ZiFy/UdL1xbdFoB1lgo9Z4QrZWVaWXhP6Q6a1M94Pz1QmnUgrf/0OVP4BtpwEiY4mB+lMAmNd3uTEFZvaKDF9cyIWtOlz6Hyj0p37Y8ErYyRAwmyT7Si6VOOYJqX45kWCDrhdJMFiaoXjyw0flyel5UXpdwsjDzWRSAA/XONPWa07xbFAQwxHyrLx/nikiGdcq+4Abj3pAQT5cqNEYAhnYef2viBhpiziSVd49EG9LDbgeU/RDN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b6+9vWAf0wsi/e1opIUr/e7i8y/g7AyY0UaT00VHoQ=;
 b=rX6olnqO1V4DWnOL0+WVGS+Xi+geTrPcb21KaKlLlFA7aaozx1PO8zeM9TulO/nozOZKv3P/mCCEE2EWqaqgGqTH2mF6Sk3HpP4xW6r/4+teyZbxFvSsqnj8Rfsd0uVmRTDi6FuBRSxL1atgdrcNq1IMq6q4/TPefvvFusq0rdUkhc3K53BEnSX2opdH+UeAfFsMz6I2sDlb4gUKvRr4qGG76lbggKby+mGSt5fRqmV8EkIjTQvHoIWNDs53WE6tfnaVgcaL7IRAuMnUxt//gRhG2MqZS8z93/fA1I4qs5OsJLTsfOtniw9aipfCDy/hmDRK24wQDZsUS1fLb5hMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b6+9vWAf0wsi/e1opIUr/e7i8y/g7AyY0UaT00VHoQ=;
 b=q2nZMjrOzhh2dYd13Pk/HZqtvQjl/D0gUkdtkFPPMTtHzFLY1FdycYoiVcemP4mn+g/7FymmggAwY07GMfxRcVQPYGIxQ1eq1jWNYPWVHdBuneSlkFFTPW9ryCP+GZfFA0JSPuRhMLQf7EBwIVdy/IgbD8CFsbtnZz+NV0/0msc9cfjd/CIk5nUPVu3o8b2iujuG4SZN+yaibiUC/g7e5ZE7b5iV+mw7j1XOUuKo4AozfieRYKEXLTh7Us5ctat4zZTbQNea+GSV74ryoj5v0YhX/28gWRPoryiPgucnHNT1ACm/htFH6mJmwVktvcOGSDe0DHaskyVEiT6h96zS3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB6971.namprd03.prod.outlook.com (2603:10b6:510:12e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 03:51:50 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 03:51:50 +0000
Message-ID: <cf24618c-2913-4bbe-868f-ea543077fe78@altera.com>
Date: Tue, 5 May 2026 11:51:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm: dts: socfpga: Enable 8-bit embedded device
 support in Agilex5 eMMC device tree
To: tze.yee.ng@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <cover.1777344421.git.tze.yee.ng@altera.com>
 <aa3bb421d60965e147f201d1739830b42ccd7124.1777344421.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <aa3bb421d60965e147f201d1739830b42ccd7124.1777344421.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH7PR03MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 5510c26b-83cc-48b1-a50c-08deaa59a13b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: gF5MAiFk8joocmvVtbdCG1gePxPsOQM2RsVwv9IJ7DvLJp0rTy8R1J6yawxn/zaXltRUFco6Kp1TxjvOAfCFlfm42m9EfldhLzclV+VGUQFQm7SvbJY6QTq6on7HS2HEjLRTtIzYtRvVkl0v49Igz5mlwefJHZ1My6eG7Y6pU7KYSXNDGejda/cY8vdktAbFFwPcS/Z5CM/4LjRPuZrjKJeufZ9vXI4Lysc0yOc+m+k+T4JXVc7j98168WggPp4NUvi5ayZHRYodS/1VW4voKPs2D/z5lycgk2oHpDcH6cQsRyjGnyxdCrm1Rn7/URuJ2kLFE4Su7UcZAiKcBhZjxm9g4fjX8j1OQksvA+QwPw8X820f+WrO+r4Vo8DnjZ6V0szqVvNxJjWSECk0NMGxHF8zdCKsqXBkS0CQHbp50mYTz4ucTSXv+0Cxas9z8LlClvVBIUSNKkuwnEUh4kRjMAXBl7r6kZ+cvhD7muiGgIsSZXWVJ8mguYC6qskS2oPdGX3L9Ed4xosshFJZR1JvV/fX1eH2iekoLmnBgPp0OgqV+EpJu8X8ts9s6iIONNttmkmWTX4NrywF4bLpn+vCp5OdsJW2AqZuvmnbmBuWuJfm1skuuxwsyBpXmk6Ho63INWQqg3igRR3F3Af/+SC8kXF4MEpBQuS+NJrDD9Vg8cQfKtNoUcPIPTPH+IIamJuM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE5mWEFpRWJKc2dLMy82bFNNdTFBV1k3YjRrbzRoMG4yUGFUcVB1M09NMWlG?=
 =?utf-8?B?NGlGd3VqZ3pkTjUvMXRsU0NsbGZtdEc0RWhCTHM0cnhhQ2VLaitjMi9CRW4v?=
 =?utf-8?B?TkRRQzBnZEFwMm9PNUkwQk42U0lzU2JxUWRZTVpJZXZCbXJhN1BqY3IzMjFS?=
 =?utf-8?B?b3RGT2Q5dG85SFpaQ0FrQVdydXU5N004WWdVUnJ0S0lPR2xJc1BEL1ZvVnVO?=
 =?utf-8?B?V2VSODkzWDNIdzZzalFPUFU0djNQUC9qTkh1R1UyajcwQ1Iya0RXZjdQcC80?=
 =?utf-8?B?Yll4ZmNEZzM3NFRXQStQaWNLeXk5K003ZkFWYjliS3V3YzZXNWFWd3pwUXNx?=
 =?utf-8?B?aGgyU09GMDJBL3ZkamhHL3A4b1BabUNSSm1xTVVBTzNDaGpVczZHWGI5OE5r?=
 =?utf-8?B?QnVVaElqS0sySnRHcHl0dy8wTW9ycmorUXZ0MjQ4UXU5MW1xSTVSZ1ZXa0xj?=
 =?utf-8?B?bWJIRjJpZkJ1L2I4cnJDOGN2Zlg2T3FsWlh0Q1VDMkE4bW81WkxyZUd4M3JQ?=
 =?utf-8?B?eDJXeVlJeFZNbEFkQSt0QW9SeWFwM08xQmpWN0syRkhEYytVUWNRKzJSdFZJ?=
 =?utf-8?B?MGNWdDV0Y3VqUUJmSHluNUtvU1QzSDIrKzkwVWJqTGV0VGtEMTBYWW9DRnJk?=
 =?utf-8?B?VDkzMlcrREY4ZDh1TkVGK2IyQWo4SUtpUkJrNU9OREVFd1hRcjlVQVlDWTEy?=
 =?utf-8?B?aXpRMFdreGtYTU93cmtiTi9YdGprT3ZMQ2ZrcVFEQVZYelRyWllEZHFPN002?=
 =?utf-8?B?a2Y0cnlqcWJjM2RnWkc5M2Z6QU1VUmR5Mk9BRWVFTHVjTklyS1dCQnhYTzNB?=
 =?utf-8?B?SG4wS3djbVAvTXpsRXVJSmJBRWI4Y1BORGpNVFVvYUdteE9MT2RncUlTK1Fk?=
 =?utf-8?B?NHRiNWwrL0tvQzJnYlZWeUtUbmdDeDJqL0FvdjJZL1BETlhtZzNZOC90TGEx?=
 =?utf-8?B?UlFReXNVYVVPdEVnUmNUNHNoYVFXY2ZDaVVYQkNNbENMQVhkbXBTZkxKTkNG?=
 =?utf-8?B?bWNSMmFLQ2p3bER4c1FlQ0poNWN6dGFPajFBQmdTUVVRaEExMCtQNUdla3hH?=
 =?utf-8?B?b1g1Yzc0TTZ6UjVQWmlKRUVVN1V5QUppcFMzWjE4OWpiOHB5QkFWUksxYWo4?=
 =?utf-8?B?Zm5zUG9naWh0QS9OaTdxaXQxRUVPYzBSZ1JrQU9ZL2dNdCtSRXVXNVo0YVpW?=
 =?utf-8?B?bDJoaGZJM0xnL29kSlRFTGpveFdGQlNSMktjQll2dy9YYVRWVWNYblhrSlVP?=
 =?utf-8?B?VHhZcTgwckZ5OTQ0UzNCY0FIRmd6OW1IT2dIVncvQ2dmVndYNlplZkdIbjJJ?=
 =?utf-8?B?TVdZd3hXdmM0eEVSNVJJYzJOQk1mVlI3cHNuMGFYYmpYcCtuSkpjVXZCQS9h?=
 =?utf-8?B?WDd3bldTNERHS1I0bWVzb1VTbEtqV0s5TDVTYUJYdHJkVWt0dlpja25CdTM3?=
 =?utf-8?B?eWY2UVVzTVpVRkloa2NvQzRWbzRxb05EQjE2UjFUT1RtZDJFZUFWUXdQeW1V?=
 =?utf-8?B?SzMzYkw4SEg1eTFmaFFUcU84ZnJYS1pRQTVYRk5CWERzUkJSSzh5MVAwVXVM?=
 =?utf-8?B?blZ4SE9iUHpSMUtWWGR2RTllVVRwWm40aWFqUjRtQ1RZSUIrTVlPRTlvS1M1?=
 =?utf-8?B?bXdwWTN2czRTRjhITmM0U3VQT3NjSTMrUmJ4YkN1ZjJQSkt3ek5kZEQ0c0xR?=
 =?utf-8?B?MzR4Sm1IL2hLZ2trcHF3cyswZWhWemEvTklFYVdaWFRLU1pUVnltYTZBMlBn?=
 =?utf-8?B?V0VMZUF4VEpCUHBTb2dBOU1LQ0lXUGxnOGRWTk9oa0xxRVNYZ0RldTJLTDB6?=
 =?utf-8?B?RXdEeUhVYi85R0I2VVZrRjFtQ1MwcDZ1bkdQS09WQ1J2SXVoMWFkbWw2MXlF?=
 =?utf-8?B?V3Y2elhoc2grc1JkcmdQVkkvUDJDL25Gc0RxTjFBeTlXczJta0lFaFl4TS8x?=
 =?utf-8?B?RlZtV05GRXM2ZEQ3NExMQzZqZ2VNOGRhSE9CUTBFYnU3NnV0a3g0ZDk4bEFx?=
 =?utf-8?B?NGFwMHdHbFhIL1UzdEtXNVpzQnphS01NdjR0b0Rmb3gvaXIvbm1kR01RT29J?=
 =?utf-8?B?YmVGNU5weXpDVFM3N2xpd2dWc0xiVzJielc2aHd2dDAyTTVJNkpsd3pZVmh6?=
 =?utf-8?B?ZzRjT0FVS1ZxNHB0TDdWK0hURmhJYmlDK3ZpdEtLaDBFUjRYUkVLY250MVNB?=
 =?utf-8?B?aDcrVng0bW9KS2NyZ29vNHcvWnl6bi85VGFQdWtLY0swaGhVTC9GdWIwdWhM?=
 =?utf-8?B?dFdtY3Bia2xSK2lYM1dZdjN1K1RJZlV5SDl0empLakQ3Q3BtS0ZuQ2doL0Nv?=
 =?utf-8?B?emZQaUZjZWwzS2FpbzNscTNPMUhsZU0xZmViNzVOMGM5a2VyVmlzblVNQkxy?=
 =?utf-8?Q?aYQLBbYaixCXBYkI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5510c26b-83cc-48b1-a50c-08deaa59a13b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 03:51:49.8213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjjfmYAEZ0YHwXJ5BdvuNNRiCMgqWQDEHjenwh39YWI+01qS6eMphF6I06QXDyLLDFRXXCuuG0eyZb8ReSdDHa50B9nkuHtUBWtR4k0Azco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6971
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

Hi Tze Yee,


On 28/4/2026 10:53 am, tze.yee.ng@altera.com wrote:
> From: tzeyeeng <tzeyee.ng@altera.com>
>
> The eMMC device tree inherits the configuration from
> socfpga_agilex5_socdk.dts.
>
> Changes:
> - Set SDHCI Capabilities bit18 to enable 8-bit embedded device support.
>
> Signed-off-by: tzeyeeng <tzeyee.ng@altera.com>
>
> ---
> Changes in v2:
> - Remove /delete-property/ sd-uhs-sdr50 and /delete-property/
>    sd-uhs-sdr104 from mmc node
> - Fix wording in commit message
> - Update commit title
> ---
>   arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> index 92ff8b4acf2..52aa92e4292 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> @@ -18,7 +18,6 @@
>   };
>   
>   &mmc {
> -	/delete-property/ sd-uhs-sdr104;


I have a concern regarding the v2 patch series that I would like you to 
verify.

In v2, patch 1/2 moves sd-uhs-sdr50 and sd-uhs-sdr104 from 
socfpga_agilex5_socdk-u-boot.dtsi into socfpga_agilex5_socdk.dts as a 
new &mmc node.

Since socfpga_agilex5_socdk_emmc.dts uses #include 
"socfpga_agilex5_socdk.dts" as a C preprocessor paste,

these SD UHS properties would be compiled into the eMMC DT, which is 
incorrect.

In v1, those properties lived only in the dtsi, which is not applied to 
the eMMC build since the eMMC build uses its own separate 
socfpga_agilex5_socdk_emmc-u-boot.dtsi.

This means the eMMC compiled DT was clean in v1.

To verify this, please perform the following test:

1. Revert socfpga_agilex5_socdk_emmc.dts back to its v1 state.

2. Remove the /delete-property/ lines for both sd-uhs-sdr50 and 
sd-uhs-sdr104 from socfpga_agilex5_socdk_emmc.dts.

3. Build the eMMC DT and inspect the compiled .dtb (e.g. via dtc -I dtb 
-O dts).

4. Confirm whether sd-uhs-sdr50 and sd-uhs-sdr104 are absent from the 
eMMC compiled DT.

If they are absent, it confirms that the /delete-property/ lines in the 
eMMC DTS were always no-ops.

In that case, the correct fix is simply to remove those no-op 
/delete-property/ lines that were introduced in v1 patch 2/2,

without moving any properties out of the dtsi into the base DTS.


Best regards,

Tien Fong

