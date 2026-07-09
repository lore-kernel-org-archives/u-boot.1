Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5404EC44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 10:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9621184AE9;
	Thu,  9 Jul 2026 12:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YmOMz2c/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C4584B20; Thu,  9 Jul 2026 12:57:31 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1380C84AB8
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 12:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrPQUZ5whPenZEX0g8VM/7Qupjf6izhIdcn34C7AcNULjoZEqoaZY2M9RolxFBebu0QWHFbSBpdpRurvWmIrOTZQBTbekmjwGzOUjRkV42qrDtUxADPpPsZ/TPACWp62D0l6spipxEA+Txmozcv2tmO+VnDMwOzm65w81zCUFRK3vGMx0yloI/fafY4pZaL9NB2CiqcSOAH3rddUHgbMtynoPW3vGId1cMBPv9ZexV4X8uBFhqKc8748lsKIgvJCUv8Q1QWUK51IWGOPIwrsN/h56VleByfMpm7Y7TK5R/4H3YT4otuwRfyHSKti3TlsG/sTPjivsxpG3JZdVFCT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F93ouSUnqYW+IRmA1RdJSLnjmwnIKiIQLOOkt/VCAmk=;
 b=Q0dBGXfTTuytd+X8AkzYYB1aPtf01dtThkWPaAUKm/9r0Y51us8EbqDx0va0dEmjPlXrIXVPy7X/tT0aAGgWlLlnup5XpL8fh8WFD1W7EdhB4caEpVUweciOS8RcPVe1z30lgQoxH/XMUxElJCRaM9mSCg0ACV4VvAzMlNYbrytAIypijLPB34EsL/D+Hdg9hw/jlGUXGMcoy5pWm4xSszhnr+hHuanZxKDw5LQlwBEtLG+tdpR02c812WMhf3KqtWx+gON7xl6ZnToOGAOUB/ErgMZ8Wnij1fyYO1+hBY/0nONDVg/rdNC+NfOeMd+9Zis2ovX+mgUU1ATeAN1RDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F93ouSUnqYW+IRmA1RdJSLnjmwnIKiIQLOOkt/VCAmk=;
 b=YmOMz2c/XIabUsyUlOjLg23oH/wegWZ7xpK9izpM+i6pmiqZsqu+yR8j3XIS9swNnnWeAzhBdl09V8OxfMXFhu3o5LvYyqIh1DJMy2xA7Zf86rme7xXWMrx1crlHw349I3lqp/AIH68YajD2i9Gik65e1OtxKUW+4RiPeJSwP4Ua2TBWPeZ2+8JgwqBQaYawmqFjYHA09SNByhuzLMWBgGeeIA0Xuz7BuW4q+mSPy1vxThm8MmrMpeFPkt5JuUBswHzlmeTrYF09kZ1IKWN7ypT4cbsfOf31IzhjviBV3FRDAeXDJv0IhfD4LkFK+gj5/IYH2ePurN7xnUvQmhbnXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BL1PR03MB6166.namprd03.prod.outlook.com (2603:10b6:208:31e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Thu, 9 Jul
 2026 10:57:26 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 10:57:26 +0000
Message-ID: <754b4e4b-ddfa-460f-9a89-b7875a2e1e23@altera.com>
Date: Thu, 9 Jul 2026 18:57:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] arch: arm: dts: socfpga: Update L4_SYS Security
 Control Register size
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lok Chen Huei <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260225032149.1342-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260225032149.1342-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BL1PR03MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 1371c06b-95c5-46dc-88b5-08dedda8dc89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info: 0X8L4WWYgz/vWxMxA3UgCQB4GUgi1oZ6bH4c3EYYjVLBnmZMuncGGAJgpzEyjDHMI6KDpzAo2HDinkvKH8ksTkwM1YGjxK9RAu/TM3PlNMayDpU5xb6xrYBfONBuTV3/4GCUn3BmBRyYqy/FjX2RKsuH0lHzV1+sGVhn9r6k+vSEnmQFTaH2dhE81PvCmfWSjk6aEhnfKmrEejjQrs6JoTP5VX58HBrOekcYAekxir7DaQuH57gwz5Y4uX9yEIpiuH0TZ9H4XgIy/EZVcYZczUhSjLTVw06CVg0JQjSgvLB+twlsaIv9FeAqdejEgZhmF6z2ULlyNuN+nlP88mXho3UXhsrDnNqhPtk+rpabuD7gX33z7E6M3kQKMY38t2ziBIEECy6hnbGAc/8S0Vul1gkiwPvxDKCvUFtrcFBJjXbvb2N4zknZ79Nh71VPkfyA238Bqk9K8ATEuqz3I6TkuDdI55rVZT2Apme7VjDLrmfQzkTJLzgb7P5g74oi2s/7dOpGtrRw+/agPL18b2PP1z1ID2kJkAmFj/F2tBMK1YtJYBnl4QLeM969gIPOjrMUMpV2m5X5yNylHfCa7rSWozNQ+oF0am2CsQgE99mTD61VINCBKz6aE2C9VkLeg8HEodWDeuhav6fkxm206/8zpM/u4qxdeps3fpWA/MXRdtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9kcXRPSzRlUFlhR2dUMEg0aVdoQWFTa3ZXTVNEZURJZnVuaTMwSHFubW9O?=
 =?utf-8?B?ZGRveElDUXNacW5uYkVNZFo1QlpaZ2RwM0NybDRSWXllVlUyNDBVc3pmdy9H?=
 =?utf-8?B?c2tBcHRqZ1lLekltdkkzY1VLOTNkczB0dEwzcDNUQTlrMTRwQnFnWUVJOGVO?=
 =?utf-8?B?N2VtSUhwdm0yUjlNbVNuMktQVUF0MkhKUHZGYU4zMUdSVXJBazlBK0poN2pO?=
 =?utf-8?B?WmFqcUV4b1JGdDlNaVJvaDloK1VwR3I4SGRPdjZsdUJEdUJtZjA0dlFNeFJv?=
 =?utf-8?B?ZDZURHBSdXUwVm5JYlpVNDUzdFpjRC9WR3VuTHYzQnlYT3ZKUGhCOHhwL2px?=
 =?utf-8?B?eVJPcHN4UGtQY0hrWXQ5NVNLTWxYaGordDhFK0g1cWFucnZJcGdHOVArOTho?=
 =?utf-8?B?VVhQV2JneEg2Zld1QlFmaWZ1MXNUZi9NNERyeTRJVmlPTlRBQVN2T0tVd2xK?=
 =?utf-8?B?YVpiNURIWWppQ25kRSt0RmNOV0VPMDBrMG5yUTB6eFJkU3p0WkZ2cVNkR2w0?=
 =?utf-8?B?NFBkb0hOUVluOEw5ZW5iNlJtMHpGdnhJYWtSQk94b1VWUE9odkVld3UzQVpS?=
 =?utf-8?B?SWZVWTBlbmh6ZTdsSFl2ZEkvbXEwWkpGY3RJSkJ0VjRlN04vUnVFNDg0SEVV?=
 =?utf-8?B?RGFoM1NBQlg3NXV1RXJ5NEJ5WFFybnh1bzV1WEFORzZ1ZEpMNEErSXpCQXo2?=
 =?utf-8?B?UHBGK1VDM2lnYkRJNncrcnNHN2NvSWNZTW85ZTl1aUZ3ZzBlU0RpWWgwaVh1?=
 =?utf-8?B?by9lcWRra0l2V0ppQmkzcGFBdVI0aGdKMEhpR2k1cTNNVlNJeER3OXU2VFdl?=
 =?utf-8?B?TU05cHhhMS8yNEcvK1o0c2o5NFpnSGdtVEViZ2NDK3VkaTJUS3NXZkJLamQ3?=
 =?utf-8?B?MzlISVF1MFQ5SC9mdEp4cmVKZlVFeHlVUDZTVW0wV1h2bFc0MUhuOHFRSW1C?=
 =?utf-8?B?MDdCem5TbHhscTFUUVZhRXh2Y05jdGtsbTFpRFgyS1QxR09uREhCQWFCMlBH?=
 =?utf-8?B?ZVc4RnFJTE1yV01XcVVtYi9ySzZCM1d0ZHVhL3ZZT2tTaStGNW42Y0tzWFM4?=
 =?utf-8?B?QWU4UVl0d25rc2UwRzFRTlZ6L1EzaVlTaUpVZDR6LzZ5ODRGVk9mbUdvS2FN?=
 =?utf-8?B?cmxIVnBHNEg5NDhoc1R2T0QweXRza0dSYWpwbUViVUMxdm5LS2l4UU1sckxa?=
 =?utf-8?B?cWdJOW5mNmtYRnhBdERSeThVQmdERWZ3dGFzcmFjTXM4QWExK3pBTXZNRWkw?=
 =?utf-8?B?cnhLSmQzWitJLy8yV0VkL2JkWG1QSHVaNUNnNWFFMkovbVJLZFhTMHBYekg1?=
 =?utf-8?B?cXIvL3hvcmZjdVhmei96eENPQldJMjJNcE5jWkJ4NUwyR1RHa1pFZW02K0NJ?=
 =?utf-8?B?dU5oSjhMY09PbGpPdEh0OHQwVlA1V3R4bHBtdkNDdVNKOWU5bGdvTkZDZWcv?=
 =?utf-8?B?SHI1QkszWDM1ZzZMbFYwcHdydldGdWZMbzZMenhCeWpvTjZBcm95TmNsanZT?=
 =?utf-8?B?YzFaUVRYcjdQM2pZanhqeENjSUszWTJxZlVzVmQ0TjRsbjVtUTJ1ZjRjM1lk?=
 =?utf-8?B?ejE3azFYTllZQlNSUWhHQ2tLUDhYQmxvUXFuUU01MUpoS1M4a0ZBVFlqRTNm?=
 =?utf-8?B?a1A1bVBuN25UVUNRUzhkdG42a2FobDRSM3E2NWFvR0tqV1NlTkY5R0dPSUxj?=
 =?utf-8?B?d2ZSWkdOT1FUelJ5S3RCY05pbmRxNDlVMVFnbURCM3NONFRxZEg2YU5odi9L?=
 =?utf-8?B?THdveXowUVVOdWNkZXIrOTlpN01sb1hnS1pjcmd1bWpxaUpENGVtM1VGdHRn?=
 =?utf-8?B?UVNlU3RackNaSHljM1QrdUVTdytYSnZzVEdQWVp4cG81eTV5SE5sdUtzbW1T?=
 =?utf-8?B?UmhiNVg1aVlyeGlNZTc0eEF6V0dybzBrVlZoaElMV21yS1BXbXM4Tjc0Slpm?=
 =?utf-8?B?akFNeE1FaWlHNjl4Nmlja0JlV3o4TjMvMjNYZWlZK3Z2czRvc203NG11dWRl?=
 =?utf-8?B?RGRKY1BlMldoYmJ4N0hNMk9KSGNjL01DSE5DRk1PR3IwQjRmcXZSUzRPbnRC?=
 =?utf-8?B?ZngxNmxLRldBdHlSWThKRnd3NEg3QS9CdmpVWTZxZ1NNSlhJZDYzM0VUQU90?=
 =?utf-8?B?ckpyTU5FdVZianZ2R1Q1azVMbW5EYlB6cVJUMitDYnJ1dS8zNzYydkFqWkkw?=
 =?utf-8?B?cVdwek5mSmhMb0hGZnZOU1dValdhTmJPN2RDRTNlWWkyWndaeUcwR0FBblVJ?=
 =?utf-8?B?SEQvRjJiNm9Bbi94bUpHM3pxL3FoS25xQk9acmFoNko0dXpKdU8yNkxwZWlV?=
 =?utf-8?B?WDdPWnBKZmJ2VkFLWlRlZEh3MDRFUGZuZWpKTlJQU0w5Q3ROTXBaZUlHbFVh?=
 =?utf-8?Q?x9FeeBQmwfAVPnD0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1371c06b-95c5-46dc-88b5-08dedda8dc89
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:57:26.1424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO4/IeqOpt7Qv5oa6LbTK5CRP180xcD0WNChn359+5nfRZHQ5GBtepGyaPkPmN54ZtfnMuajUkJRgv4NB5nQg1jQHhx7zlSoTOgOofOkGuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6166
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

Hi Boon Khai,

On 25/2/2026 11:21 am, Boon Khai Ng wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> noc_fw_tcu_tcu_scr register has a base address of 0xFFD21400 and an end
> address of 0xFFD214FF for Agilex7/7M and Stratix10, which makes the size of
> the register a total of 256 bytes.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>   arch/arm/dts/socfpga_soc64_u-boot.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
> index ce5b37ef547..a6e0b615717 100644
> --- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
> @@ -132,7 +132,7 @@
>   
>   			/* TCU */
>   			noc_fw_tcu_tcu_scr@ffd21400 {
> -				reg = <0xffd21400 0x00000004>;
> +				reg = <0xffd21400 0x00000100>;
>   				intel,offset-settings =
>   					<0x00000000 0x01010001 0x01010001>;
>   				bootph-all;


The patch updates noc_fw_tcu_tcu_scr@ffd21400 under 
socfpga_smmu_secure_config (line 134) but leaves the duplicate under 
socfpga_l3interconnect_firewall (line 111) at reg = <0xffd21400 0x00000004>.

Both nodes program the same physical register at offset 0 today, so 
runtime is unchanged. DT is inconsistent; a future offset-settings entry 
in the l3 block would hit the driver's blk_sz overflow check.

Fix: In patch 1/2, also set line 112 to <0xffd21400 0x00000100>

Best regards,
Tien Fong

