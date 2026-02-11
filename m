Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C52FEB5954
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 09:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10CDD83A47;
	Wed, 11 Feb 2026 10:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="JDIp64mU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1067183A5A; Wed, 11 Feb 2026 10:36:15 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988D982BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raphael.gallais-pou@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZWd0X2+iG4Nt6/GA7T4f04mganNEajunEVVXnFlj+c0T3s0tZA+MFLypImgdBUazA9dRlOhX1YuoeUQ6IswRu7fyF4SsHhBn57B+iXJhUuRXqBIJS/16o3H9CNiQVnwWwQz/qMEy+TrNMOcwOlE0foHMihgu7vHQoUrfVndMgvrZ0k5wU0goQ71YomnUep1IwwOJ0kLRNEHenyPv/U605WjrA0YaI8yIqCFAaJtOTD6z9SjapfVHzp+DQ9MvkDc0HL73zeAKEz0M/nmt/3vqKnFga9sRAbpBvivKqz8yU6QoD8/ILPkNCtTk25lwfJzVarIig3xycW6L3mdUGPxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLUzZBrI5RrU5qXk55pJ5VvAXcAWpQeRLQMTA84C5mk=;
 b=I2Is6vMfHGNIAjB953OyZ/mYMVlX0/9doIY0l0k/Qxde7DdzcDXSd5rQGpbmVQtvaLRf1aTmJvtdq1KqiEbvPwZ5+t1ombM4v0TwBvlx2nG1DbSXPtNnJ6ysBtH2RmIejMeLrQCFuUbjgBmibDwtB1hUWSQoz8fSPvo99/SZbbLbL1NTYeDjVNhr6pLitBJbEhncjEiWt5zg8AoOruaSfmOjvAnRXQGxVMOtEBq3ScfltXAhUL/5Ym5BImfcYphm5/lCrPPD2nMMCd66DoDz+wCmbhmmyamO9HO4KwwYMI6Fx6anteCHVyfWp8O2tKriWW30Q4MAujI6L0FJkIeGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLUzZBrI5RrU5qXk55pJ5VvAXcAWpQeRLQMTA84C5mk=;
 b=JDIp64mUbI/Mz9QDIAzr987ickIH8ipVcPHPJU19h9HOpMGqljhle93quJNyTkfVu5LnpHi4qaq0MxEURXhEYXjC8Y69+WIPE7lnjzH8N5B8fB702f5EhM2zw+QGdtCZP4sm7n2XzR9AOWp8rGWc+vF/MGxcLUZNML72N4Bj6/Iq2ryI16hyc+1tFpDZDCncz1IZjl/N4O9lk0WQA5pKFpkFU7yqWfCW3jxt48DmtbheHv2SJm1+zHNAwcVrrYqNrcgUlS8e0X9t4ypf0N0hbW9mxkpVOzvYPvwmQOo6pMHhXHPJsiUCw5QlJVLSsdO8fl/49HMatFmi9Yo+uoXavA==
Received: from AM9P193CA0021.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::26)
 by VE1PR10MB3902.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 09:36:06 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:21e:cafe::9b) by AM9P193CA0021.outlook.office365.com
 (2603:10a6:20b:21e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 09:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 09:36:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 11 Feb
 2026 10:37:56 +0100
Received: from [10.130.75.212] (10.130.75.212) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 11 Feb
 2026 10:36:04 +0100
Message-ID: <2a664e58-82ef-4b27-971e-02d84bf7f398@foss.st.com>
Date: Wed, 11 Feb 2026 10:35:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: core: Don't allow ofnode_to_fdt() to return NULL
To: Romain Gantois <romain.gantois@bootlin.com>, <u-boot@lists.denx.de>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.130.75.212]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|VE1PR10MB3902:EE_
X-MS-Office365-Filtering-Correlation-Id: ef56dfe1-cd1e-4939-9260-08de6950fa80
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXBtempBOTBPbEpWQkx1N01mS0FJZFRUL1FIMmlYeE9heEpya3NNMlp6enJH?=
 =?utf-8?B?NlpyeHhuejNGTDduYXpiai9NbVhRZEZGZDY3RUhLeGpOSFUyVTU1ZFRrY3Rm?=
 =?utf-8?B?RGR5dXBoUFRvQWpKNE9xU1FpcEdhZllkL0Nad3Z4TVRSMVJpQlh6eVlaRSta?=
 =?utf-8?B?amw4Tit4UUlnMG1IZ2lMSi9nWE1wU01QU3QwYmYza0VNM0tybFhTNnlXODBh?=
 =?utf-8?B?amV2ZWVwZUw5blJEdjVvVlZteDVBQ0F6N2xwN1VrSzdlc0k2MUVKU2VRb3JY?=
 =?utf-8?B?d2w0Q1RIVGJEN25IWVZvdHlSaytSVFVSR1UwOXh0a3lQUlUwbXJkREZVRjI2?=
 =?utf-8?B?dGgwY1RmVGJIZlM2OTBqSlZEYW1WSWxLUzZLYzMyNHAwckl1bVZRdVBPeDlh?=
 =?utf-8?B?RVd5L083OHlsTnJpUzJCZVhkZmZzb1RsaUJkTGVFK2RKRTYwY2ttbFpaWHdQ?=
 =?utf-8?B?WmhYTVhTclFmVWRVa1lUVlFXRGF3TEl3bHpzZnhvVGt4MVJtakhabGN6ZWhW?=
 =?utf-8?B?VmFGUENRb3Y1R3RkcHJsVlRKM1NRQnFXb2h0ZW0rVmI1TER1MzF4VG1MNUxt?=
 =?utf-8?B?dTJtOFRlbFNySW83cDhENjMzZ2h0TGRRT3ZrNmF6QkpFc2FPc3VOdkUvWVlW?=
 =?utf-8?B?ait1WDA3a21zaTVkTTJkeXhqMk00c1JzSGd2UU1BeHNUcGhaMVhBWTZYQ0dZ?=
 =?utf-8?B?bW81VllCdUgxWkN5Nm1KV3I0SjUyY2NaRWszRnJEMWpzOERPL3B2cDRmbmc1?=
 =?utf-8?B?cDFDN09nQzBwZysxZzZQdENkYm1Ua1JQOGdiczc2YmdSdXB1OVZtVDBOM1VN?=
 =?utf-8?B?eWw2VWZNOFJha3RsU1ZOOXU3eVE0aXZVQlVoWFdOVFZGak9KWGM4R0dSM0o2?=
 =?utf-8?B?MWZ4ZlZvOEpMSkREKzRIZ1JwaS9waWRNay8vOVkxL3ZpMzRPMEJTZGdQRTVY?=
 =?utf-8?B?Ym5DaWxrTjdxMkhnSWtEaXBFRmdvUVF0MElBMXR4Sitzd2kwSE92cnhBSjFy?=
 =?utf-8?B?MExwdmtUTUttK1c1NDdIMFp6b0VzWHExZW5iZXFGa05xVWVOOXJnSWhBOG0z?=
 =?utf-8?B?OUVuN1diYU9kSE04SDlnQmxEdElXZlBsTjkrM1I3emsrZkUxbFJjQzhucmFJ?=
 =?utf-8?B?QU85eEZReW5EbHVDVUgvWHNFVmZoclF3K0tyd29uYzh2K0o5T00wSDNKRER2?=
 =?utf-8?B?c1FrWmF3NWVpaCtnVVdpbE5kTCs3OW9QZldNL3duYlNMU1lLTGd3NEovUTJt?=
 =?utf-8?B?SG9oWXFjcTdsamZFZkVya0J0VVRGWVlnTUM1Wit1Mm9VYlBQMGdnVEFKdDQz?=
 =?utf-8?B?Y0VyRnpUNTJEZzFMcFZhdTV1ZnRGTVZvNDE2NENQaXlvQUtLVVdsK1RPQ0RI?=
 =?utf-8?B?dW1FaUR0aHp1dnpraHNsZ3BIdWxGcDJ6RERxSXhIV09mR1h3SmZQYURybGhV?=
 =?utf-8?B?cGIwYnl2WWNab1R4d0U1QkN0cEM5SExBZnBndnU1MlcxbnlIT0dCeDhEd0pO?=
 =?utf-8?B?OXo5VlJIKzZteWhYT2RDZUZ3YnRIN0hlZk5pWldnVGhudlVzLy9BRDY0SEpr?=
 =?utf-8?B?eFFhMnEyYjUvMzJMTzh3WDhaREVIRXZndk55bGEzMmZpUmM2L3J2ZlBiK1NP?=
 =?utf-8?B?VzJGbEZaL0RiazJUUEpIRkxYb0JBbHkrR1dBdm43djB6WFpadXZhV3V5T3ln?=
 =?utf-8?B?RERjYkRMM25sMnFsV1dwU1ZOSkdCdEpSSk5laG1JNkxzVklXUXl4UFMvdkI0?=
 =?utf-8?B?Y052Vkc5L3EyNWM4Ty9YYmw4LzVCQWxSVWdGcnpRS0hmbnllRktoM3JwMXE3?=
 =?utf-8?B?eDhlTFBEc3dUODdnd1pvbmhhZmVXdkZPYU1CSGc1MlZ1NHBYQlNZK29qaXFL?=
 =?utf-8?B?aWV0UTBIZkEwaTJnR2lXV2Vmb2NmekhBczdybjJYbDJ1dlZGTVg4N2UydDJt?=
 =?utf-8?B?Vmp3NzRoOXBiblFtZmtrcmtUSHEzbkRiaDR6U08vYkdTYW5WUWh4RytSVFpG?=
 =?utf-8?B?NGYrSnp6K3ZRdzhmMVlLaDZ2VFNNSFBVQkkwcHVweHVydFVabkRqZklOM2VU?=
 =?utf-8?B?K012UHp3Mml3ZG1WK1g2TmtmS3FSR3JoOUo2aTdBSEFiOGcvZENxdW5PY2NR?=
 =?utf-8?B?ZFdBUlZHZ0FTM0ZadTlNeWZGU1N5RnRKYVhUTzlDRm5FOUgydFUvZXVqRERC?=
 =?utf-8?B?bnNKd2x6SGphbHFJVGdZMTJkNE9sdHhTZ09scDN2clRRYkFIQnFsakNNT0Zp?=
 =?utf-8?B?TkpzRU1jL3YrdVVVaTJRSWFtL0RBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2IWqWbQrV95nYE/rE/LU50193W0fnaXjjgslFzfCSXeBaQQTIbReZsyUG3M4hjATKS74YFrMb1YYMydKRmv/FH3DW4zi3qPNJA5B6+wF3S3m0lME+N1zpfvt4XqRSKwN/30Qok2iLefQScMSef90SWcEF+0As3C8kHETfUUc7SHDlVRu9HWyF6t7g55bxKZuHiRgJCYN5rVKIG5xNvsL2vwXUvxHok5EitAYwjmYhe479zZFLuiXcPi2M0xayQ22SNfwnVFuHWeiSyfPXHGZUk40Rbidop65BYClsnwgRShbdE58LZECwaNe0C10S+ZecqpRzW1DYb/hwvHTjSKFJ1iUQeb9pkLxyet6pdrKHRtG/Lvr9e5go8lNLAHlqgxe/ETfUbCiFmr4IeJvjwBLEdqyrWz81HI4CjHTeZs4iBeQrDAyhnrFoWH6gJgK5vRR
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:36:05.3330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef56dfe1-cd1e-4939-9260-08de6950fa80
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3902
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



On 2/10/26 17:29, Romain Gantois wrote:
> The ofnode_to_fdt() function may return a NULL pointer in multiple cases.
> Or, this function's return value is often passed directly to functions such
> as fdt_getprop() which end up dereferencing it, thus causing a NULL pointer
> exception.
>
> Don't allow ofnode_to_fdt() to return NULL, to avoid a NULL pointer
> dereference.
>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---

Hi Romain, 

Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com> 

Best regards,
Raphaël
>  drivers/core/ofnode.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index cf1cf8abfbe..af24a2c533c 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -164,15 +164,20 @@ void *ofnode_lookup_fdt(ofnode node)
>  
>  void *ofnode_to_fdt(ofnode node)
>  {
> +	void *fdt;
> +
>  #ifdef OF_CHECKS
>  	if (of_live_active())
> -		return NULL;
> +		panic("%s called with live tree in use!\n", __func__);
>  #endif
>  	if (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) && ofnode_valid(node))
> -		return ofnode_lookup_fdt(node);
> +		fdt = ofnode_lookup_fdt(node);
> +	else
> +		fdt = gd->fdt_blob;
> +
> +	assert(fdt);
>  
> -	/* Use the control FDT by default */
> -	return (void *)gd->fdt_blob;
> +	return fdt;
>  }
>  
>  /**
>
> ---
> base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
> change-id: 20260210-ofnode-to-fdt-null-95a9f357819e
>
> Best regards,

