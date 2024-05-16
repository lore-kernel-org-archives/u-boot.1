Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD56C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 13:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3E08824A;
	Thu, 16 May 2024 15:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QL1/uczt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670298826E; Thu, 16 May 2024 15:39:37 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E554B87FF2
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 15:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB6fwzEL4ajkHEWybI23ddMeYvkFqnOLfg2NxcdWd7AIvIj7r0pEJpNi20+U588jXAzu2V8hDVKuptlpiOuLWVodLHHWxV3beMbL2sVcLjs+OuEthcvIE0Z/kLx0M3L9ETNM+LExBXvrXD0totbAoBhtUEqwve5QcdV8hrF+pRWm34+eahxheHB3Bi16g38PUIEX890TrknPU9r7mQScpfqRHe1ET6DEJo7P5ckynuSkRQEqvOxYoHGhOlEJs8px2CawPa0SSR/r0UipSgjESg6kkov/Yrbk9C6/5SSksCu2gSPaFX8z5Sur3xGkn4VgEbZmUyXnSszI4fnifyDByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAq6Ud6B1FBpCyElz9lCAksW2QZ9rwIztUYqOKui6k8=;
 b=cv4EIKsFWf+3OCBAyGaVvRPdLUKlxZ8zhacwz3gAgvefxDENbSf2JGH05uAWmHIWTydo7+tIKBQ2sUZ7ipEf7fKz308a1j3ycTo5Vgdr3CvLRTmhAFeZLsVeX0A+InIexF9y9/xebIw2jqt6L7XTm7C5AOxGaDK8v7Vx1BOsVcIOVIiUle/5jlPZQD10ubnyI2Q9JesJoBIYi17s3wVgpT0wC2Q49r7iKJYIg8bLxbyOfagVw0rnuroCIATeifY/o+4N+MjETo19WuPiSp7FOK2Pq6N6mVhJ+5/37C3BIFA3fsPqKGCDIF7VFHhV70V/Zjzk2RyeIleV5mo/tbnh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAq6Ud6B1FBpCyElz9lCAksW2QZ9rwIztUYqOKui6k8=;
 b=QL1/ucztf8tNuDxuDsXWuEhB8Tn/7bSMbE3MWZlKjDOXRIJLbIa1d+uUoBUBsESLVDO3kNHG9HJukJOXs/LW7Ys8pHVuFNTBfgsFhwkVhvWz7TmY2ssrVXwR+9WBULefermiFdvWg11em0UVzzdZ/GcCeHQGKNSTszYHHT5CKdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by AM9PR04MB8471.eurprd04.prod.outlook.com (2603:10a6:20b:416::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 13:39:33 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 13:39:33 +0000
Message-ID: <0929d137-54d7-45cc-b58f-6549510e95c3@cherry.de>
Date: Thu, 16 May 2024 15:39:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] rockchip: RK3328: Read the reset cause from clock
 reset unit for RK3328 SoC
To: Anand Moon <anand@edgeble.ai>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Jagan Teki <jagan@edgeble.ai>, u-boot@lists.denx.de
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-2-anand@edgeble.ai>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240516090031.2373-2-anand@edgeble.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|AM9PR04MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6e0549-1d1d-41f0-aa85-08dc75ad9e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzVYaHpRM1RLQlUvTURiRzd4UU02WHNXaFJxZlYwaHg5eHNub0ttZFJ1Skw0?=
 =?utf-8?B?WXRzZ0NiYnp2WDZVcCt6WTY0UGlxY3FzT2ZFK1hzRndkSFNHWEdzYTR4U0hT?=
 =?utf-8?B?V1JwazRIcnhobnM3UUFQN2p6U2ZvU0ZyZEpWSSs2RHR2UklYUmUyQXM3Rk5I?=
 =?utf-8?B?YTMvNUI0V2lNMXFRVkVFc3dybEFqZXRNSFdtMW5UdVg5Tlc5K0c4aGpaTkZV?=
 =?utf-8?B?dXkyYUJES0VZTTRmcXVVeUM1SjhsNGtEWUdPZXFrWXl2M2hSamZhbVhuclJK?=
 =?utf-8?B?ejg5NVNKRDdiclVoaFQ5RU1tVzlJVFFjVHhWSkxrcFNqN0thbDFxc3l5VnFN?=
 =?utf-8?B?UzFVSkgvOVpOb04yd29Wakl5bW1JT1RIcEFSOFZ3bm9nZTU5aGV5d3haUmNi?=
 =?utf-8?B?S2FpWWorbTV2cTR0WlU3NVFQRWgrbnV4emJldTVaT1RzM3krK0tvc3d1cmI5?=
 =?utf-8?B?K1Vxa0ExNHZ2dW9LaXJxVGFFejNHN2lXSmZFQWJSOURxSnRLYnVwYlRHRlFP?=
 =?utf-8?B?NFpRMm9vcDkraG9acTYreVhKOVc4aVkvbHdjUEd5RGxIazR4WTlSRHpFRjFF?=
 =?utf-8?B?SjNmbmhWNElJLzdFSXVsbkRQNUtjNkdKVkJyNCtoU2daaGRTMElXeTJLRVVu?=
 =?utf-8?B?OUd2MVFxUDFtVGZVWlI1WWxObGlCenA0S0lKSExBTHVMc09uSjYxRHBydGpL?=
 =?utf-8?B?QkRyRGpINVM4UDYzdWZhZUpZcDE0SWZoblY0M1NHS0RBN0xpSEorL21mZml4?=
 =?utf-8?B?dEF4NWdLVUtWdEtVM1JNbDBCN1A0QzRYSnVEc21BTVFxQWRBMUJvSnlyc2JE?=
 =?utf-8?B?Y3BtcCtmcGR4RnBtRm5JMndtZDJnNzBSOHpBb2NzT0o1K003UVlXVno0WXRk?=
 =?utf-8?B?ZWovNmo4S3FwRGw4L1doSExFSVF5bTZhRU0ySm4vamtXOVdvaUV0NDAzNkll?=
 =?utf-8?B?STBoYzUzWGJZeTlPK3pCZTF2amlIemtQTGNSZU16amwrUTExVm5mMzJsajZL?=
 =?utf-8?B?dDVmdithYWg3UGlnSENRWEluemJJSVBPTVl1dUxOTW5Wa3RpK2M1VHpnZ1VY?=
 =?utf-8?B?SktvYnVaOVBnUnFvWnpGZ3F6Q25rVTBwRXdSUEp2RlFMTjRncFo1MlJqNVl1?=
 =?utf-8?B?ZEY3MTYwdzl0dkw4ZFBOcDFXRENNMlFDRXpyVER2aDk2RHJteER6b0Q2ZVVp?=
 =?utf-8?B?Szk5a2RZeC9CTzdIWEdBZ1dxZlNxNitHRGlDa212alloN1lxS1RNL2xtM1Vo?=
 =?utf-8?B?ZjdVTXE3Q1ByTWt4bmNFVTBjMXdZSEE4QmxuR2poblhLNGoxd05kUkFkNmRZ?=
 =?utf-8?B?VUhoRzVWOXppaVdZd3ErTkJnUkMrMjlrMFkwdDg2eFBNTktmR01QZ3BGaWNT?=
 =?utf-8?B?dTlHUDA4UmhTcmsrMkVkTWhKQkZLMUR5UEg0U3hpNHZmNG5RMnhYNjJuYTZq?=
 =?utf-8?B?dDdmMW04em1YZEVGanFLSk5hbUQ1NVVsbkhld20xQ2xoeVU4R2VpR2J5Qkc3?=
 =?utf-8?B?Uk1tRUVsVWY2RHJhNmdOb0o4WlFidzJpZFhJWVpYR216emJuTTUrM2hrV2dS?=
 =?utf-8?B?dVNtWEdSTXFYak9UYWd2c1l6SGVtSlc1VEw5dC9OWElTaDVhUFArbVR4R0FB?=
 =?utf-8?Q?EkmghbhDy8Lvc2rm2ToNwsc/CLaNFkAzPiGFMqKEwBBg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZ3TmFyQkp0VVJ1cEcyTS9ycXJZUDg1amNNWkt0eWNJLzA2UDZmWisxYlh6?=
 =?utf-8?B?Z3NtT1pSZjVaSUNIS2JPUjc1NGlXMzBtQjJVTGh3cG95MUZFN1ZITUJyc0M3?=
 =?utf-8?B?cGtkaXBjQnZLRkhFTzFVT1k1K3lxUlRQVE5wTWhweEYzWTZvWk1PaUVFenc0?=
 =?utf-8?B?U1RoUlVxRXBEVHB4bE1KUXNRTWU5V3lnN0k1Y0E0K0tKVHJQajBvWGJtWU02?=
 =?utf-8?B?eEViT1NDL2xoY1lpSzI5ejlnaXZUdDN1N0RMWDl3c0pqZXM0aE03UThQSWp0?=
 =?utf-8?B?dmlvWHV4dFUrbENGWWowdVc4anZ3N2JyU1d4YVpzY2haZ0JoRlN4VFhkUnds?=
 =?utf-8?B?ckNIWnFrNW1aZ21pd3BPUE9Dc0ZvMFpjZWhIZzdHVU1CK1E5RVNGVG1TbDJU?=
 =?utf-8?B?UkR0WTBwajRabGNhemk0dXVYVUJqL0xDRFM3cG5ORXdUVG56ZUxFTmtaVndY?=
 =?utf-8?B?YXBZTVJ3MnhrZTVXaVFrWTh3bGIyQ0Z0bURSYUVIdCt6d1hTa29oZllpVk8v?=
 =?utf-8?B?eVMxeG5CQjd5UWR2TEloRUlrTUluUUZWcXhKaGcxNzQyZ1puSy93YVo2d3pR?=
 =?utf-8?B?WlNYc0JidXZWcHFQYk9aMmRPT2lzb3VNVzlXemZmSldXM2FRdVhqTFBJMnBi?=
 =?utf-8?B?SzZZR1Jxbm84ZGEyb3VvL2F2T05YdEJsckJaQ0Mzd05kVW41QW1keEc3ckFR?=
 =?utf-8?B?VEx5NnZnZkVNVHJlRGNrVUlpQUYvNmdoSklZNmxrL2tnK1ZCWjV1YkQ5bExp?=
 =?utf-8?B?Yk9MMXJGUnhtZnJtTkFRRjVHRFR0OHV0NEx5dHVOeUlCR2x0U3dJT1AzZS9Y?=
 =?utf-8?B?VmFubzhSMXhXektxSHpxRzdKNlRSMFZMY0E0d080c1Y5ZVQ3SDU5bUtDdmRV?=
 =?utf-8?B?RnRyM3lRSkNNQkhJYnA4cGlnUU5sMi9hbFdYMkZza2N6MEt4MEFUWjFCanRJ?=
 =?utf-8?B?dnJLNXByTGMxQ0hqUnRJNnVNZ1o2UHZIMXhVeUdLcjRsN0s0dFJWRlB2SEQ2?=
 =?utf-8?B?amtQTmY5cUZKSUIyK2xFSCtwQm9XYVZ2Y3J6SXp6TkcrQ0ZJTU5laGFnblVo?=
 =?utf-8?B?cUZ3SHN5NklHZ1VsSWNwdzk5NS92dGlxRzN5WWhmOG1WV1NJR2lpRnliV3N1?=
 =?utf-8?B?NHhEZVF4aGZCVmo1b2U2cVA3bzZOWW0yb1dVMlBKQk9EaDl1UWFZcUs2TEx2?=
 =?utf-8?B?Qm9uV24xdnVOSTQycTJGNnZYOVovaUlabEFQeDRpOVNGV1dsWTRsaFN1RVU5?=
 =?utf-8?B?U1Q4Zm0yZ21iRHVlNXN5YWVTZkx1VklMUTNacDQxWUF4NHd4SlJQUDRDQ0ZE?=
 =?utf-8?B?VVdNQUIveWd6a21SNFI5U1VLRWFyWlR1T0VKRzR3L3NyY1BqMmR6R1lTSjlq?=
 =?utf-8?B?K0xpMnJWRUt0TFpOa0JaSHhWdE92MmpKYXQzZUxoUVZWVi84UlprZWVaS1Ew?=
 =?utf-8?B?dElHMUE0cWpyeGQrU21INGhhNUwzKzZMVDY4clNGVFFsVFExcXV6SlpYdmlG?=
 =?utf-8?B?VG1lUzR2dVFQZXpxYUtQMU5SZENiRlpieXFLK0s4Rm1VU2RiclVITnF5OEdl?=
 =?utf-8?B?VHFVeE1IMm9mYk4rclVocVJwN2FkbW5KNW1zOFB6dU8zdTNMUVBneHZQNGZx?=
 =?utf-8?B?bXZSa3gvelI2VllsNEZSOHp1KzYrUmVyMGhvMWRXeDBwWWl1ZVFBRy9Gcms1?=
 =?utf-8?B?Snk1am13OUowcDZscXhOMTI5YmdFemhEeWZ5ZFcxdERCdHRsaVRJTXhMU0R6?=
 =?utf-8?B?Qk5zVllUTjlZZXRXUEhqSkFLSndOK2lFODdCdnZJZUpPTnhzUnpVUjgxa21P?=
 =?utf-8?B?U3NYbGNMOUdqNWhSK3JwRFVxa2kvdG9GdmFuVXljYXcyYnUxNWRsY0pybjFP?=
 =?utf-8?B?WXJ2WFZCZlNoNTFjcWF5UCtIMm1ORlRzN3J3V1MvZ05QVnBIRVdTNDk4UDVI?=
 =?utf-8?B?UUZMcEF2VEJubkc1V2RLNWVGSytJcllxOFVDUzVweEFCRFk3MVVEaUNBUzls?=
 =?utf-8?B?WW9rcGU4Q21kb2hEY2MrRE9IQmEzNDZoTlBob3FiSENwSWRsMkUzY3R3M3hQ?=
 =?utf-8?B?S0ppUE1aSE9tUjVNZ2Z4aXM2ZGh4Vld0NTRYaW5TNGw3WmdHYnM5RGhIR09H?=
 =?utf-8?B?YTZBWmNuOHRteGRQMVF0TEplNUVNZnZqMm92SVdCWnZUWU9WWlBOYkgrZXdS?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6e0549-1d1d-41f0-aa85-08dc75ad9e3c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:39:32.9600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkXVAzL7u0KoaloQjbbMaHdiRdr2r8k8duzHr5kpbSCetuPwegHRqqKDaqGZmVaRf7tYzVpyIHwJRgj6VwyQeDaoNUuBaLPdO7WLtu2XMYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8471
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

Hi Anand,

On 5/16/24 10:59 AM, Anand Moon wrote:
> Read the reset cause from clock reset unit for RK3328 SoC.
> 
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> ---
>   arch/arm/mach-rockchip/cpu-info.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
> index 14c7331e1a..fce4bd7541 100644
> --- a/arch/arm/mach-rockchip/cpu-info.c
> +++ b/arch/arm/mach-rockchip/cpu-info.c
> @@ -8,12 +8,17 @@
>   #include <init.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/cru.h>
> +#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
> +#include <asm/arch-rockchip/cru_rk3328.h>
> +#endif
>   #include <asm/arch-rockchip/hardware.h>
>   #include <linux/err.h>
>   
>   char *get_reset_cause(void)
>   {
> -	struct rockchip_cru *cru = rockchip_get_cru();
> +#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
> +	struct rk3328_cru *cru = rockchip_get_cru();
> +#endif

NACK.

If I only apply this patch, it breaks support for rk3288 and rk3399 (the 
ones which have a rockchip_cru struct).

Do:

"""

#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
     struct rk3328_cru *cru = rockchip_get_cru();
#else
     struct rockchip_cru *cru = rockchip_get_cru();
#endif
"""

instead to keep the current support and add stuff.

However, I very much don't like this. There's no need for cpuinfo.c to 
become SoC-specific.

I would recommend to move get_reset_cause() in some file that is SoC 
specific, and out of the DISPLAY_CPUINFO ifdef since it may be useful 
outside of this very specific print_cpuinfo function (c.f. the rk3399 
firefly board).

Yes there's a bit of code duplication then, BUT, nothing guarantees us 
the reset reason will always be stored in that glb_rst_st register and 
moreover, RK3588 already has more reasons that currently supported, and 
this prevents us from expanding it.

You can have a

"""
__weak char *get_reset_cause(void)
{
     return "could not get reset cause";
}
"""
in replacement and let SoC-specific files expand it by overriding it.

And.... to think even further than that, maybe we should actually expand 
drivers/sysreset/sysreset_rockchip.c to support more SoCs.

Then we could get the status via get_status callback from sysreset_ops in

https://elixir.bootlin.com/u-boot/latest/source/common/board_f.c#L904

and remove this cpu-info.c file from the arch/arm/mach-rockchip.

Reporting the SoC could be done with a CPU UCLASS (c.f. what's done for 
IMX8 already), from 
https://elixir.bootlin.com/u-boot/latest/source/common/board_f.c#L176.

This honestly makes more sense to me.

Cheers,
Quentin
