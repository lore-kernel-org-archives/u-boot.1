Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB36FF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1B283BC4;
	Tue, 28 Apr 2026 05:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Exj3Bn+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B96283693; Tue, 28 Apr 2026 05:17:04 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAB8D83BC4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APqJwC0D1jrOzrWcpQ/lFSaNluktoA94ezKIACWO7kJ36oG9J00p4gmaN7ZgKzpWJQ1Pj7fydeRpXgVPVb5jQaVny/N9OVj5uVx0wJbHMudQvzAdFceWWaUucyGUwymZOa3HqNBSh6vpXPvj9WmtWJnvp98YQVZJQqzJD2H4OPqzqFmpSXgzhm2a8og2FF8Asp+yy33M0Pag4L7HsC+qvHLP0Umwrq2G4IRvGpqj45Sqv1ozJ6l1o1/xQh0MzAKWLu89IR7NoOiqD379WUjwUwKsnJKbmFUL6sb8bbgeMq5DI0yndwekk0nN5jqar5g9K57rXGzle4RGyz25VywMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZbVS94VvI2ndqe9g6+WTvxRHumwFEH3LiVJI/uqDSM=;
 b=WZtYtsBZxnnHckUcJ0tU/cs9YHWM0bJjQyMUTb5ba3AbYAY7INFrhRdeQ0zLWE/WDGGCf4jU9Yb3TmF4qmF0fNcMJ/+QqGPZwpBhERJxTe30qFPDImw7jZWT7Xd6DA3ll2x/RfFtL289IWQU+IAO3hznO4QoWVGKl2BYCxfXD97VKgOSfHlJ17ZHvrnD35qc5RAY4rJHYibrG82NYyuGY1yneo/Ya9hRCwSglxxleHNcvKcdJAcYlers7+40F6V5BhyODhumZnLjQz3vWMpUTfsop4NiLEozk9A5OS1BCWisUF1gmLfg8Ne3bkb6IebxAODp+9wXkIvXAwhQPDu4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZbVS94VvI2ndqe9g6+WTvxRHumwFEH3LiVJI/uqDSM=;
 b=Exj3Bn+JFQA4IaOYdqDR62PW+zgXW0dxj0bccMWHrIUphG6G8FIBTdYAvbO8BgHeQ49hBYWgjh2+nrBHdPZmNxKcrBto73f5lgVEE58mXhZYYjQ0LUes1sH0AHF9PqS/LDXTcXmVOoeNfYMCOTEienl+wUiTDdkgJMcW016AHm9Z4SLkUzsTj9d0pMwBvLz3fZnOYnNF5+YPFX31x2qZwVcAmM4LdmqPbzONVALE3m545MO5AgTrXWhTUHDraRkgEjDNCVIGkMJ3Q32+Kl4xOvZ0mLWeTRjljeE8jd0mD5xSVZ3WZ0DtTdTYx644p3zdld7drToeR+GXCX1Uq6dn1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by VI0PR04MB12006.eurprd04.prod.outlook.com
 (2603:10a6:800:312::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 02:05:20 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 02:05:20 +0000
Message-ID: <d3205a5d-e34d-4140-bc63-27245111c213@oss.nxp.com>
Date: Tue, 28 Apr 2026 10:05:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx: Add SPI NOR A/B switching support
To: u-boot@lists.denx.de
References: <20260423-b4-imx95_img_set_sel-v1-0-1681ea8b1507@ifm.com>
 <20260423-b4-imx95_img_set_sel-v1-1-1681ea8b1507@ifm.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20260423-b4-imx95_img_set_sel-v1-1-1681ea8b1507@ifm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::17) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|VI0PR04MB12006:EE_
X-MS-Office365-Filtering-Correlation-Id: a56be223-80eb-4785-a743-08dea4ca99b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TB6LqQNKCvOivbzkKtZ3RG8ULBSJ73pMUIz/V1LhcaeIUZleBImrTfEu7qTEEhmBH428a2FdTKFcMUx6AnA+Y+Y1GNPk08g3bZ8g6iF6BLWd9Zdzeaboby0Tq4A+JANRea7Y4PfhJ/ZkLwrXu9pHhZncqiPLpPHIADFGqbF85gOIxNlM6XrE5W0wTGs7e5j3XRJInwU02hNxyTkhWWoIH9scCOpqwwrumGLhg7XCkQHqZ303lvb9xkamjN+2SzKvEqgMgEGFWpb+6knR+9cdUXH68xKKM7gtZQXc42Tz9xKIqoVZooGl8NTTZXG28UttrnaoI1ZenpxO4X/w7zcM0pvqlVgVjRnyvDGEyYFHgOc6RTIOl5n1zafES8P7wAI+xFQMylYhztQbRjPl5Db3c2TAVzpZaE5U5VUXwb30fFZfwsOv8lW61v6h0XnXOsjd1yr40rIcqhVL+1GpCVsqZE4RBGcPhJVMw/J6i3Ap8Iwzq/8NtCAaKL7mCdWkUMN9pNoSISg7Dph5xeoYFPVGo4naRAtfuUmnssmAvPlwIneTZXPGrxGZMoxosdiMsZzcw0BAqvwBnqCnjzfdr6PHUyEVH0KiX8VSByQgD5mZSDSYw8CqrsgrJrBRbblC/+f5K86PgnpktGAPl4JPtphuc5/cxKA5QFC0nYrHzaFwAd5AUz2aRBS9HWNWFqKwNhERET/rVwquNRoHqFI7+N4OmLECiCp3+LbfM8rC+zV+R0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG0zek5TNEp1SEQyVUNBNStZbEprQnI3QWVVTXVXeGNCUmVyVlAvVkFOTStY?=
 =?utf-8?B?WE4vSFo3MWRkL2pjQjU3RzE3RFZTckZIWjV1UnJKcU1rend0aWxVZHVJNFcz?=
 =?utf-8?B?NU0rWE9aVTlkNVgyRW95SitKa0ZFMXF6QUlyMVIxNmZIenIrRFRRb2hZNm1h?=
 =?utf-8?B?a0NJZS9kZEVqYy9seFJ0dXRXUUwwcVRtWnh0Z0wzT3VrbEtlOWpyWW1ZaG1U?=
 =?utf-8?B?TWNIR2FOV2cxb0VEa282UGlaNENES0V0QXZKVW9zSHA4ZUFTeGhJL2MxaWpo?=
 =?utf-8?B?WWxYd09xVkxtNGlCOFRicy8vQkp0WWgwajI5eThMWlVseXhaaW1saDdSU0dv?=
 =?utf-8?B?bGZDWTg4ZnhFemhDYTdZTmxDVUdBN2J0WWZmUEh6MUFZR2pUQTJHMlZ0WitO?=
 =?utf-8?B?VW45OFozNHg2VUJ1b0JadW5OUUprcmlkaUZIMUJzaDcvVFpPaDVnZ212Y1ZG?=
 =?utf-8?B?NTc2UFlELzZXditaeUhYdW90amZKRWJzOGVrcUNiMElFbEIvSWZuWE9CMGJJ?=
 =?utf-8?B?bVRsWXQ0K1dWZDdpVDlianhjaVNKQk1tR3ZFTUgxT0tzcjU3S2w1V0JiakpN?=
 =?utf-8?B?UkY2SlFpMDRiV3ZPQjYxTWJWcnNWdms0eUJlL2VjQXFwOGVJK3ZUd1lRZWlE?=
 =?utf-8?B?cEEwTExqQk5zYnp3V0pta2ZmaGpEYTByN1ZJZlZ2b0h3RTRlRWhncmMzSndO?=
 =?utf-8?B?enpkSlJLSVZHTDAvUlZTYktEZzZUdnVpd3greDMxaHZ3LzVEM1BYc3hOUDJN?=
 =?utf-8?B?YXVZREdraGFlNW9TcGRaWUIyQVk2YWh6SHM1aTZlQzJ0VUcvNzUwekwxMjha?=
 =?utf-8?B?dlRtQTk0T0RTU1Nyb2ZkWmt4ODRKTDBGcW9OOFNOek1HdmFyZEhpeFlqalpR?=
 =?utf-8?B?WHEzV2oxRjdsWnVVYnFjZXVkdlFHWUE0bG16OXM0dFFLTWt5ZFlsaFRtOXBW?=
 =?utf-8?B?bVd1dlBVVjAxRTlTR3F3UXk2SjlPTW1qUXJ3dzRHSHZhNU9NK2xmWll1dW1I?=
 =?utf-8?B?eUdTOE9QMm11UEVJNFNnUmZNS2h5aUEzclFaMm5HTXdXeGhUV3Rlckl4cjRU?=
 =?utf-8?B?WDJsSXFQeDhoQzcwaVFnTGVGNjJNVmF1bnd0R1JBUTkyVEtDMW9FcVZoNHFY?=
 =?utf-8?B?T0VhNDVWQmpqOVB5aVgvajlxakpSd014TWFPeWNMTVB2VnFpeUR6SjNDcERP?=
 =?utf-8?B?YzlPNEJRMlpUd2ZzRk1Qb2JWeGVTVm5OcDZpYnhwYnQ0L1BGZVhSQktuUmdL?=
 =?utf-8?B?ME9ZNWZhZlZyWHF4NjYvQmMzN0RuVnRmL3dtYXBNSVdUQWJkVVZkR2g2dTQv?=
 =?utf-8?B?N2xTYkFhSHRGbDg0NFdMenRRL0RXWkcvT3NGTmI4VjYwVHZaM2hUVFRmejFx?=
 =?utf-8?B?M1BpYXltOTRKZGpic3ExcTJqcnVxN3dvc1VySkdQV2tWQlZXTUFvMDAwYTlv?=
 =?utf-8?B?MllKU1oxR29ZbTFjb2ZqYlZ0dU5MeGtFcjVoSG9RbllRN01CK2hsMDgxMCtm?=
 =?utf-8?B?MHRnMkNZWWE0QVg5TlZOSG1iQ0xYbC9ta0wyWjhkS0ZqOHhuVEExb1FkVk1p?=
 =?utf-8?B?SVRHU2xkbGhxWmMyWXpmUmJSWkJzOGlDQkNJUDBGbXVabXJCT213V3BYVjNF?=
 =?utf-8?B?M09mbTh1VG1SL0VTRTkyR2JwQ1VmL2hveW9NZ0J4NTduaSs2eTYyTGJUSm1o?=
 =?utf-8?B?OU54ZDdWSW5yZGp4YjVmaTkyZXZLckdhbk05UzB5dVBwcGZGUktVMzZhaW9F?=
 =?utf-8?B?RkZhdTRnbjg1dTlETnZORm1ZZjFNR3RuZkxMVXJLZ2FFZUd0czVGWHV3NXRu?=
 =?utf-8?B?Z0IyTTlGT29QUEFBVkloSFZhdlg4cUNGYk1jc2lSVk94YlBXeVRoS2t4NUI5?=
 =?utf-8?B?enB3dWNSNkl6UC9HQStQMzVTOGxDNzVGS3V2M3JIOG1hKzlmV1pEL09ubWsz?=
 =?utf-8?B?azd4dlhYaUtNOEFJR1J5L3hKWjV3cmpQWFNFTFB1d2tvbCtNK2V2VHl0Wk00?=
 =?utf-8?B?OHlJZzIyOXB4cmE2NEVMd1lqL0VmOHFOOWxwWkFhaGVKRTFUMDJwYVBCYVBv?=
 =?utf-8?B?b0VkaTNsRzBldEVCUnlkaloxcHVNaHhETk5VOFNRZ0JVcmxVUGdBbEpXWmhr?=
 =?utf-8?B?aVRIR3pIeUYreDBSVHRRdHpwRkJvb3JkbEFiWTZaVXpXblRudExpdm0yR0lY?=
 =?utf-8?B?Z0xEcWxwM282b21IWEJwTzdvaW1qOHJJc0c1ZHJGY3A1YVlBS1QyQlJobzJk?=
 =?utf-8?B?UGZUdG9aOVU1OXZxVFI5UUMwMU1Nb3ZtVDMxSk1iV3p3RjM4MDM3SjBlSHFj?=
 =?utf-8?B?QTRRWWtqemVyM3dkOG90OGRJa2lDZjdaS2VjSThlVlBaRnRwS0ZCdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56be223-80eb-4785-a743-08dea4ca99b8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:05:20.5703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBRz1V3FzAe8hv9greJSazabJOXHHsZbsePhGn8Lun6v17PhCCv7yEC9me4Vvf82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12006
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



On 4/23/2026 7:54 PM, fedor.ross@ifm.com wrote:
> From: Marek Vasut <marex@nabladev.com>
> 
> Query the SM via SCMI, obtain rom_passover_t->img_set_sel and based on
> that, add 0 or 0x400000 offset (A or B copy offset) to boot container
> read address.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> ---
>   arch/arm/mach-imx/image-container.c | 10 ++++++++++
>   arch/arm/mach-imx/imx9/scmi/soc.c   | 13 +++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
> index 7bfcc9d7e9d..eeea0b80b39 100644
> --- a/arch/arm/mach-imx/image-container.c
> +++ b/arch/arm/mach-imx/image-container.c
> @@ -204,6 +204,8 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
>   	return ret;
>   }
>   
> +extern u8 imx95_detect_secondary_image_boot(void);
> +
>   static bool check_secondary_cnt_set(unsigned long *set_off)
>   {
>   #if IS_ENABLED(CONFIG_ARCH_IMX8)
> @@ -227,6 +229,14 @@ static bool check_secondary_cnt_set(unsigned long *set_off)
>   	}
>   #endif
>   
> +#if IS_ENABLED(CONFIG_IMX95)
> +	u8 img_set_sel = imx95_detect_secondary_image_boot();
> +
> +	*set_off = img_set_sel ? 0x400000 : 0;
> +
> +	return !!img_set_sel;
> +#endif

Using 4MB offset is not correct for secondary boot.
1. This offset is configurable by fuse
2. Different device may vary
So better method is using the img offset from rom passover data.

Also this change should not apply to IMX95 only, but include IMX9 
platforms like 943 and 952 which are enabling SCMI.

I plan to upstream the secondary boot support from NXP downstream. Do 
you mind wait my patches?

Best regards,
Ye Li

> +
>   	return false;
>   }
>   
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index fbee435786c..330b276b23a 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -745,6 +745,19 @@ void build_info(void)
>   	puts("\n");
>   }
>   
> +#if IS_ENABLED(CONFIG_IMX95)
> +u8 imx95_detect_secondary_image_boot(void)
> +{
> +	rom_passover_t rdata = { 0 };
> +	int ret = scmi_get_rom_data(&rdata);
> +
> +	if (!ret)
> +		return rdata.img_set_sel;
> +
> +	return 0;
> +}
> +#endif
> +
>   int arch_misc_init(void)
>   {
>   	build_info();
> 

