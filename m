Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C880CC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 07:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 110F587B1A;
	Fri, 19 Jul 2024 09:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F/KDOeBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736D2885F5; Fri, 19 Jul 2024 09:41:48 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C3E987B1A
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 09:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5tHQ37nNSNdYgqE0i3S39MISim8fyzEZHnJ73whOG8Ek9j3lrRuZNqujogsZMjTAFp7rHrpaiGlYK1gQzP4w8gyMs/fQAG5me0w4uaGHV/V3wgBBfpLQgyiO+vhua3qgnexj4m2EL0INWSvbtHqS7vuDoZGqjTk4BcU08seHDnTiCa0gLuLFCa4DX+qKYxZkWLNYKVDfIaYho7ZYrvS8byOFcVOzx7B+DpR6/KNmTvyLTh31MtQzPflI5UbPa7sV5ErLK+Orcs6upjJe2oeUrJLrgxeU3W1dFTi4n20HCEK61OAUndEM8YZ20fu8IHk4y0tEJk+dLwdocut+RwaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbxaPAjrJOEJiRwgvVfamCY7y4dfhZPapdNv10YAMLs=;
 b=Rvzkj40r9xGRMwJfkDmuQHz8uZK9AI0vAlWGenqXv0nxsvXWFx28k0+g8UdxcFp96GR1xPOyf3jFRWOFLAJBnmVlFvjq3xQuYcscoqqQUksyScCjYop3wcGSKGot+ptXNy+BeOqXFtEobjvFdSFrDut/KhiKIB/Hhrc9umXEEGAqeVqD+eagtRGwm0WdPbWO1VGs97h1v8PeiZqDEwi57m7GQ+0NAf+h0+o+SsQ1Fb1QVU85QkZUrJXeFfVE0XOZQ1RHMfloVngZzPZrEABiidvf+r8CFQydAWlYtvRxHagfVjxc87UrJjBRDO5efghV409YMRigZ3gVMQfIfPJpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbxaPAjrJOEJiRwgvVfamCY7y4dfhZPapdNv10YAMLs=;
 b=F/KDOeBY4sQNR4uJ42ES6Zz3nN5QIZTHTLJZ+T00e9nIOzYaEc6UXrtSr7rTyq5aSrrsk+tBrGP5LYLj5b5aSAb/TGgLeT/N4WYNy3+PsilA9TD62M4ZYnKKcmYxyWZ0vn+d4u6iAqZRb4u1gaWdlL4+QD+jQCeSJImyzS2Ejq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6779.eurprd04.prod.outlook.com (2603:10a6:10:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 07:41:43 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 07:41:43 +0000
Message-ID: <b4ae2ec8-0c81-4178-8e77-432ff82fb178@cherry.de>
Date: Fri, 19 Jul 2024 09:41:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: bring-up to Radxa Rock 3C board
To: Maxim Moskalets <maximmosk4@gmail.com>, trini@konsulko.com,
 u-boot@lists.denx.de, sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
References: <20240719073551.8070-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240719073551.8070-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 02246bb1-9ee2-4680-10c1-08dca7c63c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0hPTktzRW1mRmVEalo0aWViQ0x6OTZtSDVLZDNSdFNUY0h4cWNtVjFJcnhx?=
 =?utf-8?B?TVVGbDlOZUhHRmVFbXBBczZBYzVlcHk0VU5WS3JEdHJsTnJ2VklMYStoWTcy?=
 =?utf-8?B?U2FWMGNpa0Zqdy94dFdSaEJUZ0lGWlNCd2I3OGloc2NHbU05TmVlQWcydUhP?=
 =?utf-8?B?bmV3bDZqNHdJZ2lnR3FXNjhkcVJSbnZuWThOMjljdXY4NUd3c1FoeDZCZ09l?=
 =?utf-8?B?cTlJVVdLSVVON3puYnVyamhIWGpHelkxZTV6dk13RnNHQ2Q5Smd0aFFneG5n?=
 =?utf-8?B?b0JrWTRvdi9HRzhDOGtOYmN1eHJlbzkwQ3BHc3FBV1l4Y2x5NXByYmZheElz?=
 =?utf-8?B?dXQ0QmpMVUZHV3o2U29kYUhuU01oZHNYM3V5SDJ1MjNYWnVQRnFlenVibjNz?=
 =?utf-8?B?RjlSSDFkNWcxVUg1Sm9mc0tRdlhta2t2Y29DZGR5dU9WRkxLcUFSMHo5MXhC?=
 =?utf-8?B?U1Z6WUw1TmRMVG00emhEd3h1QVpIblMxRGpCTUQyajUwSzlhakQyRXN6TC9o?=
 =?utf-8?B?cDVxR21sQ2ZTQTJQUGQrbE9hK0U3MUxjRFJQRVRVU1phbzZnL2dZZ2JtNzV6?=
 =?utf-8?B?b1lCUDdNOHN3clhpdXRVYXFlNlJlclVNcHJEYjBtKyswUlppc3hjbGdsK2xa?=
 =?utf-8?B?S3IvbmRkK3JaVFh2cXNhRHAyRE1MNDk3TWlvaU9XQ2d4R0xuUWgzR3cxRklJ?=
 =?utf-8?B?TnBWNFNJU1JvRlRIV01mbVFEcWVpT1Y3RFBoTjhYVE5MZ2pic2EwVkExV3dU?=
 =?utf-8?B?STl0enpYZmZMVnBxZ0JSQVFER3dHTTE5TDFld0hvcUJPdmorNTc4Si9IbWYy?=
 =?utf-8?B?RmVOZTN1NSt3ZE5NRzF2NWZWYmp0NGN6SmhIMXJBdTZPMVRLdWVKNS9aK0lZ?=
 =?utf-8?B?bG94UTZKTG1lWEUraWZQNk5NZENKL0lXekRWR0ZQdDJYRk92MXd2VXN2UldE?=
 =?utf-8?B?MlNqK1ZaSlJFS1BDMkJJYnFxSzBXU1JWUEpLTVJhWWN6cS9jbEFHWDEyQWs1?=
 =?utf-8?B?WTR0TDdkeElNbEl5Ly9iSk1nODFVQlh0MldoT3hCT1A2cExNSzlFTXQ5Tlhs?=
 =?utf-8?B?QkJSQittTXdaVHNYZWtrRE1BSSs1T08zUDR5WW10T3BleEc1WnhZOGNpOHFS?=
 =?utf-8?B?RzViUUFleDNPRGlXZllGRUsrVmltSyt5UmpURTZ6UXBWeEFRNEZid1ZGNXFC?=
 =?utf-8?B?L2d0ampzSFhOaTVDamN3cHpWTFpQMmhJbXRydTkrL3Z5WHB3eG5nUTduWHlE?=
 =?utf-8?B?SVFRU2RCOG9rN29pWFFQZDNjMWo4OFlQVExaVDVUMWZRN2FjV3orcVgvaThI?=
 =?utf-8?B?S2t2NEFkVEtnQjFDRjZudlA3U2JzVjRraEF3Tnh6UHdzVHZ3NDNqeTNBRGR3?=
 =?utf-8?B?U2RqNkliNWhOdjZCVGlEeVI0VjNNNmRXaWlLSWEwLzhyclltRDgrTDRYNEht?=
 =?utf-8?B?SUdiSEFGNU0ydjBBbnA1U21HTmQ0dS9aQ04yWUduZmNNZ0FXR21BMU96WmRZ?=
 =?utf-8?B?NWhqeXp5dUpOaGRoVTJuRWN3ZmhuVGw5MjJmTUwxZm5TUVhCeGM5amtjR3ZX?=
 =?utf-8?B?Uk5DeFRqd0NacUdtSEVPU0NYbGZhUitiRVQyaytmdEh2RUdHa3FkbGU4NGVw?=
 =?utf-8?B?eDcxbHRqcUVZeVBjWFAralZmMHVERXRwak9peEwvRzJYKzd5M2o1Snh4TEl3?=
 =?utf-8?B?b05yKzdDclE4Ynh3bWNMQmdiQ25rNzVGTEc0ZlpEcTIyUy9VdHJsOENuZjQ0?=
 =?utf-8?Q?dbDYUUECn9TQrQVIzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlVDUHdUNnhMdnduSUtJN1JxSFU0VE1zYlp4NmRFZzk2eXIyRVBiamkvWjRp?=
 =?utf-8?B?YWpzcnVNdHN2U1dRTU9ZNU9YQUJmQzBlYUhRSVdSeWQ0d2hpWml6dVRlSGpV?=
 =?utf-8?B?MnBVYjNaR1c2bEdQWFJCV1ZwR2c2b1IrR1JYd2JEbkxkRHNHa1NCWkdZSmtk?=
 =?utf-8?B?Rnp2SjF1S2tpU0hNakJzblB6VXpRMlFEWVVEeEIvaHFyRHlLYnR5N3VadkVw?=
 =?utf-8?B?dGNrN3lzN0lmQ1hST2szVGltcXNBTW8wM3daTFZQYWswWFhURk9telVLMjBj?=
 =?utf-8?B?ZjRLeGJLNFAwMi9RTHpIWW04a0wzZkhYcVJzc0orRHRDUGwycytMdHA4cTVk?=
 =?utf-8?B?UnJiS21jM25GbFFSVzRLdkVDSTM0RlYrTzIweE1Gc21SY3hxeHczNHhuUHdm?=
 =?utf-8?B?UXZDeEFNczZEb1RnOXNnY3cxUXdDUVlsZVd0dVNFNzdEeHFQa2VwSHlHOVpo?=
 =?utf-8?B?K3lFelJIMWpVN3hZdUdmems2aHBWRC83ZWdNTFZta3N1M2o1elVRSHVHNXJa?=
 =?utf-8?B?ZklteEpyYUpqM3Z4cHppU1VBekRldGU4d3ltVTZ4eHBJQ3l1WkNRRktROHNH?=
 =?utf-8?B?cEZYUmdtZXhyZkZ3ckdxRlRGYm9yclA1RHBCVUdUNUVWNnVLeTFKOWNYVFpv?=
 =?utf-8?B?TGFyOUlEakZwNXVBcEdYNW50UlRiMUVETG1aNmtVaXpsQ2ZOS09JWWJ1Mk9B?=
 =?utf-8?B?Wmt3MWR1VXhESlZ1WTJQRVEyTUJXUERqbWIrOUdLcHkwZ1JWclpkMlhmbHJi?=
 =?utf-8?B?WlNOaldvL0syb1FtYVczdUF6SkhMUWxqN2pld0pJa054MmtIMGVXMlNjVDlN?=
 =?utf-8?B?bERQS0pERnhyVHdNcTB4bmdwVDYwTGJCWENQTktTWlNDQ3Q3NHQwNHFBTHFL?=
 =?utf-8?B?MDZjVGxJNE5MUlhIRUErVElqcnBLSk5tL3FWWXUvKzMyWnZMdm1iREh4RmNx?=
 =?utf-8?B?bDFxdnp0TW11SU85SFlqSHNOVGN0dFBKSFBBY0t1K2hYSlhTeG1jRXBFQm54?=
 =?utf-8?B?NTh3WGpOQVVVU2hvWVAvQ1FIdTJORDZNQnRUbitzVVI2ZkxBUEdHbWQ5V0NJ?=
 =?utf-8?B?L0lrLzJyVVZHaGxWbXhMQ2VnQUlGbmd5SGtlbVpUT3VQNzdaQ3loblZ3NjFp?=
 =?utf-8?B?Uy8wR2ZSdjdjblhsRmJETkZmbVlkcS9SeVdMZ2E0YUFscHowR0V6c3NEY3hY?=
 =?utf-8?B?NmFNVHFpdGVZNW1WY2VEVmtpTFBEdVlTNEFvS05ST0ZHZ3JLdzN4dm5UblIz?=
 =?utf-8?B?ZFVNQlR4dE9pVFdYVWlDQ1ZjOHd4Skxub0FqTDArZml1UWM5YU5DZldrYnlK?=
 =?utf-8?B?U240ODRGajB0S1hkbHUrVnFUUGZ2d1N2YkJhdUlyQ3NhKzUwNm95aW1zaENE?=
 =?utf-8?B?cGZWNTE5Ry9jR0hnS1ZCM2wwL1pIVDl2M3hoV3cxdXExZXk5WXhiNTNJZFNL?=
 =?utf-8?B?UG16Qnk4S1Rqc1Uxdlh5dGZETmM2Y1lmYzBISXNkL3pneEl4QVEwQlVTWFZC?=
 =?utf-8?B?enN2alFGSTlCK013L0FsUmFnRkdiZGJZZFpKWlBNdDhuWG12TitKdWo4eitC?=
 =?utf-8?B?R0IzcjZNNW5UQy9wYVk1LzBzdEtGbEJNWHZ0Z2V3VUtZVkdSMm9jKzJtRElx?=
 =?utf-8?B?K1dHRmVnLy95SDEydzF4Y3ZKU1F0VHlQUHltdVZYdWRKLzA5Y0ltK1hwRDM3?=
 =?utf-8?B?QjdBa2pmMkZXNmc1Tk11ZEVkRjBKTWVBMVluV2NlS214V1JEV3FVelVDVlhW?=
 =?utf-8?B?aHNvTHVIdk5yVEZweVNaZFNQT0RMTXQ5WHEzNXpPNDl1eTlsZmNnOVBMOWRa?=
 =?utf-8?B?aTN2N2JvNFFTdFZwMERQMEFKcHcvUXMvcVNrVXJqa1dWdzRWTDZYSE1ZcDVx?=
 =?utf-8?B?SjlsRFh1emQwOEpxMGVUMW1wR2pQdDVPQmZDQmNEejJnTDRWdmFnMU1XZnN0?=
 =?utf-8?B?c0s5dkt3bWdSOExFYUI3UXRkSWlZTll1Vkdrdk1pWkY3NFk3T3BEUUlxN1N5?=
 =?utf-8?B?c3BDN0JBRjFJd1dsbTVWbi9xVTFTVU5HbTNOTkJIN2lnZC9sT2I4ODRCT3JL?=
 =?utf-8?B?NXlOQW53ZDhmNWN3QWZIaU9ITHpKNkdXU0RURURvVEZPSnZqZkJPdWt4R2hy?=
 =?utf-8?B?dDJLSzdNQUJDU1ZFUXJnWlNDOVNjVnJlTkx3ZDVTemVzNlBOT0VnL0pMeHhx?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 02246bb1-9ee2-4680-10c1-08dca7c63c0c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 07:41:43.3745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgrfA03wYGsR1sHvMB6iRe07093dU4o3QXZVqCHuwNb7YlZRJhxVf83a8u8C/Cd4SHvqk+DKVTefL1/A9x7idonyAU8Zoy9qlNpN8gA0840=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6779
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

Hi Maxim,

On 7/19/24 9:35 AM, Maxim Moskalets wrote:
> Just copy of rock-3a-rk3568_defconfig with dts for rock-3c-rk3566.
> Separated from the original due to the use of different DTS, than
> fixed primarily network support.
> 
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>   configs/rock-3c-rk3566_defconfig              |  93 +++
>   .../src/arm64/rockchip/rk3566-rock-3c.dts     | 726 ++++++++++++++++++

Contribution to dts/upstream is only allowed through the
dts/update-dts-subtree.sh script.

For this script to work, the commit you're interested in should exist in 
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/.

You're in luck though, Tom has sent a Subtree merge request to the 
mailing list yesterday evening, c.f. 
https://lore.kernel.org/u-boot/20240718184912.2759784-1-trini@konsulko.com/T/#u 
so barring any veto, this should hit the master branch of U-Boot in the 
next few days and you'd only have to add the defconfig to U-Boot.

I recommend to give it a few days and check if that commit is merged to 
rebase your work on top of it.

Cheers,
Quentin
