Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7F9C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 11:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D378863B;
	Tue, 11 Jun 2024 13:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KWkDhEtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB12688652; Tue, 11 Jun 2024 13:02:49 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E7D88623
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vqnjcxg1phKcgmFgxG06/xyl5aoK6lJ4RiDgtogq4tPQJk6bK3sTObpIGyOdvCjO+pQniZg5LLQoVvYjKrXhdgy8yLtQWjGJK6NjevkZM+jlNJ3vNHXSum0ND1Vo5zrA2RyNCWDMW+8JdQqlMq3v6o7Q1Y5vxu3ee35VZuT8urPsWGpuEhERHMLpj7pnSEuUcsbPbORGmu2LmYrd/1vwLKxKOwKcnbAUf3IjasC7wnpYEUanoQV1QtrgICGdAfSbAZ2gqVtUkTi+5k52yQci6T05i499savqbnyj6YPRxyb9uj4zhwLCPDHvdagIwcT4BqnSWrn5oUATwI6S6QMwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwAuISxqGlXMHjskQkRHkCMhjK3kDWy1LFimJnOg3W8=;
 b=Bud6LaqTp4DI+bHO6B23iJnYWM2fPc/lnPaOzv5d0eVnUolSffBBBX7Jtm77u4rOyzJbtuBXHqydJuMAnSmw9PrjMY3KnVofnrfIDeZq1NBMiiU6Cpl1Fj0xiyQwkbJ2LZbaqq2yjuPlawakyqSafzqwcfd52MzA19TJhS9KBUvXBcPKzqtaGNxmoeu92RxSdkJSZY1meMeXqHx+2ZI074kysGa4Fud1Cp+PEz53OhVAHg1hGAsFTcX2LBRgBh2tIuJBE8NoWwq2i+haOBK1WdaHg+FpGHTd9WjAG4pa/SAnZK9VMMPdumpaMzlcSwYbvvyAWUsSjIMnZspGXEXndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwAuISxqGlXMHjskQkRHkCMhjK3kDWy1LFimJnOg3W8=;
 b=KWkDhEtn9QWkAykE244rUY10XJ7yl1M5dpKSvLFGsc8UkwnqDtlZGbeJPHEKtx07MmWBVKpU6C7RUqmgDrj3rGhtS0PJVtuGsSr/rVxY13QApNRzersKMJhxko1UG5HUNjJDdU2+uI5SfBxYMSt4zstp/QrAyEqEIspnXxKZYEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 11:02:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 11:02:44 +0000
Message-ID: <35024a1b-8c7e-4b62-9f33-4cbcca6f7b5d@amd.com>
Date: Tue, 11 Jun 2024 13:02:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: zynqmp: Enable usb3 for k24 som
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: luca.ceresoli@bootlin.com
References: <20240604083854.2033917-1-neal.frager@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604083854.2033917-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f777ca-5fc8-4c72-03bc-08dc8a060551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0tkVEo5RkZNN090bEM4dTBLM1FIdnpnaDVnNFYrZlF3VEtQV0NISmh5dnFC?=
 =?utf-8?B?emxodlRNL0xmQUoxZlBTWEp6RjNaV3ZsNkwrdjh6dGZReUxlUnJKcmh5MFRn?=
 =?utf-8?B?NEdnOXBlQm41UVBsVFJIdFMxTDJ2d20wK2doYU5CMFlCS0VtYzBWc3E2NCtF?=
 =?utf-8?B?MG5WYmNGNnVDaHc3K1IxVExUN1piMENGSDlKZEtaVkR5RHFPaVdlbEh5dTg1?=
 =?utf-8?B?ZjFGdTJWNHdtREFET1VmNVBhRlJXa21KZjBxTTgySkVjWjNLR3lDMmZqYkMy?=
 =?utf-8?B?MTMxbXk1bEk5a01SSVpEYXhxZWw2L2dVaDdFWTlqait5OHlFV1dTWnJCUUVI?=
 =?utf-8?B?YjVibWpjRTU2M0J0azNRNEZQV3ZuT0pHQXI3SzZMcFEzOHNjMGptbDBoVmk0?=
 =?utf-8?B?QmtGbVFzSHk4dzZaTGNBbXhCaHI0RlBKdUFWWkhTcHh2NzNxVG5tdmEzeXVB?=
 =?utf-8?B?Z2ZINmxuaE9Bb2ZuQTZaMGU4RnBKWGZIQUd3TVowZ0NoTUVuay93U1ZicmRN?=
 =?utf-8?B?Q2Z3Wk1QcDRWa3JMRUlSRzdyenE4ZzNLaXdTcnBxa2JVb0lEYzdVM1B6Y1pI?=
 =?utf-8?B?N2c0d1lnL2cwbzB2b1NLVURMZCtmK2lHVmpnS1FTeXE0OXU1dEhlTm5EODcy?=
 =?utf-8?B?ZUtKRTJEYVdBTFFVSVlydXBIUnRJc2xuT3JEaEIxdC9lT0VNWU1CMTFCRW5X?=
 =?utf-8?B?d3JPNWNjL3g1SDZzWFZGUElqTVAxUHU0ZVFHMHcyTzlDamZsblRSUTFRZE5U?=
 =?utf-8?B?OU9KYmFuYlkrVnR5NUFFOU56Vkd6azBJMFJZdHdtRTFzditKOExUWjhrTzlv?=
 =?utf-8?B?Z2l6SStnYUhWT2ozZU8yK1J5N2FhUUJWcFRWQlArSHdla3d2d1BmdDdYUmxa?=
 =?utf-8?B?SWFsVllkZGJQOWFOcHpnMWRxZGlKVWJpbTFSVFJBYnA4ZE1aaTJPNUxHUTFC?=
 =?utf-8?B?a0xxYWZkNjF5VXhQejFUTDdCMGEwQkI0dXNvb0ZITnU3dkt6RXhUSVg1VGNL?=
 =?utf-8?B?S05SVGxObkt4TVR3b1BEVC9wSDVod1c1S3pCd1pTcVBnMis0amh6REhHTmZl?=
 =?utf-8?B?UDNiUS9QYnB0Q0pBSWw4YktFNUpWUXI2QlcrdVl0WGIydnZRMHdQV0QvZFZN?=
 =?utf-8?B?MGRhUjQ5cEpiODFCeDkxcU51QjNNTVpIZjRMMFdHVTNmUkxGQW44TXJIT1I0?=
 =?utf-8?B?eWZPM1lLZ3NaeTNJMCtteUdqL1lsTTBmR09yclhnL1FaM1MxVFlRQVQ4VzB6?=
 =?utf-8?B?QWVIeVVBL0U0MEpYZDlySHBHQ2FtK2F0OWFMeGtwKzlFeUhUUzNabjVZUlBv?=
 =?utf-8?B?ZnNBYmlEcFpPTEdLUTJIK2g1NXZ3eWhBNU9VYWt0b1NoK0xRK1UvOXM1RTdI?=
 =?utf-8?B?UjhpU3NFZkdIMDdhOXhMWDFRZkZ1STduNTRVQ01lcnhSM0NtMFA1aG5abEFC?=
 =?utf-8?B?dllZd0pSbUs1K1dBV3JHY0xoUlVHMEt3c1d0Q0dHMGFJVFNFS0JqWWtqSGtj?=
 =?utf-8?B?dW1rRnFFRzhpMXhvQU55SDl6dCttSGFyUTV3N01TV1RCMGg2UERVbHRCK0Nq?=
 =?utf-8?B?SVRRWlgxRXBIRkVrUWVMcktJYm9XeHRLQUpqOURxdGNvNjRMLzhjZ1QwUStp?=
 =?utf-8?B?cHEyVTAyU0tBeWJYaW5xcFh1a2t5TngrSWYvbWxsVFNibTNVUm9hWWNkaHhC?=
 =?utf-8?B?aGN1ellPc3JYajdvVWdHZ2h5TFkvMjVFN3J3TnBsOUxmTHNvQmdvSHR2dlYz?=
 =?utf-8?Q?Qy3sJql4C5PxYHLLeygYrZUFslOJF861Fuox++Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFRb2ljWnBNb0s4TDYvajBZMUhIZml1S1dDcWp0YTVrNlZWS3Vmc2FPQTEv?=
 =?utf-8?B?a2w3ejA0K2NZOUVVL0graEVtbGJLREcrekUvNzFpVVhQUGhIa3d4aWpCMEMw?=
 =?utf-8?B?dHl2bS85aG9YbllkdURlTnQ2eEhZK3RsSTBMZkNmYU1iQjJpZFVybUJyTGxB?=
 =?utf-8?B?b2FkWXlGRm9IVWErbjNvUk5nbU16bHJzT2JiTGtCeHpibWJGYmlWTDlQWVhp?=
 =?utf-8?B?aW4rQjk3UU5zU2tXUUxxU3dTWXkzeHJpWk44RVdpWnRpN2g5d2xyc2UxL0Z2?=
 =?utf-8?B?TnBaVFM0RERYODR0SHVHSnFnZDdtTFBYbEgyQTlCSFpyVGp6bmRjV01TU3dK?=
 =?utf-8?B?Z2tqV0JvaFoxaVJRbHljVGgxRnNLU3dPTldrVjBNaWthcllldC9NcERaM0Rn?=
 =?utf-8?B?aXJWa1AzZmI3VzhpYm03ODZqYVZCd2t0OVVmbUhEWkZXYXlON0poNkZHaWsv?=
 =?utf-8?B?MTFEUzJ4d1JQUzQxVC9pVGMxejhUWW9Ody9mb1JJTGxTbW1MeDlyVEFCVmV1?=
 =?utf-8?B?aU1HUDU4VnhUK3ZNQnp3Qit1ZFdtbVgyN0RJYklxd3RFdFYwS3h1TFRBelFh?=
 =?utf-8?B?eno2aDNhSHdTbnpQS1RHa3k2VzBYb09EUFZzYlIvZnBmWWdobXM0UFJ1dDFn?=
 =?utf-8?B?dnM4NHNQU0IrclphcWFYZEhtNi9KZ01UYjVpWnpEYU5TcFA0WUQ5N012aXNY?=
 =?utf-8?B?ZHllWmEzTzdrcnRFNkdwM21hcnUyRWJ6b05YL1BaNlMzZzNjcGkzSWRQVXlx?=
 =?utf-8?B?T1hualNxL1BjYkZzZUdibWRVdkFEN0FsZUF5RUVQYkZ3Q3p3THJ0UmZhVGFP?=
 =?utf-8?B?TVJocXFnZU14bGxhZ0l0WWpDZTV6SkxQQ1F1QkNmaEY2ayt5OFJVNnVPV1J4?=
 =?utf-8?B?Sk04NUVSL0RqeGhzNDRYbElKRkZMaVVwR3R5QjBKcEd5R21ISVI5WEcweDhx?=
 =?utf-8?B?RlBiL2cyNmFFTS90WXZIZ3o2bklrMnVCenBNa3h3M3EvekhhWU5Ga0d2Tzc4?=
 =?utf-8?B?K3cydlRXVTAxMUk5YnhVeHFsT2JPdTBzN1dGR01EMkpsMFA3Q25TNXVkZ0M1?=
 =?utf-8?B?UzNubVZmbUNtcHR6cXVWR2JzY3dudDVvU1d1M0JkTjdoV1RXMDZGbWxRdHpa?=
 =?utf-8?B?R0tYZjM4WTc2ZmpYVnkvblZhckJLYW1QSmljQ3BlemxGUWR1bTRhb3QvR2I3?=
 =?utf-8?B?cHN6REdxZ1Zhd0Uza2tLMFRISXpVWnJKZm1GU05rTHE2ZnhpN3phUzRJc0FK?=
 =?utf-8?B?TUQ0VmZOQlRPcVhiZXBsNE5zSVRBVm1SU2JHRjFYL1Z6cWlhaGs1YVRualJI?=
 =?utf-8?B?R1YraUV2WGprajh4WHRBZlJxZ2lRazhtZkxjcTBkSGJ5NEtrbzVMNEdmZUtE?=
 =?utf-8?B?OWpBT09QOGZMdEpZUUU4L2RLbmVISjBZOEgxVTdYcUcwVFpzL21OaENCM1c4?=
 =?utf-8?B?MWY1clBERjdkZEIwNjdINEVvVDhTcHA0akdxd2FlU3ZTa0U5djk0U1J3Y1Vh?=
 =?utf-8?B?TVdkL3o2dmtDK1RiYk9aU3JRSjNmdVBFUFIyM3BvRVFUTWtENlhMY0tqSDUy?=
 =?utf-8?B?alB5YStXS0tGME9oQlhGZ1hCN21tWVZpZnNQRlRFM21VL0RIUGtnNUJXYitT?=
 =?utf-8?B?QTJuZVNsU0RBS0dXZ0U1em5iRWpkMHZHUkk5Um5hNHJ5MEhHUW9SNisyOEpj?=
 =?utf-8?B?c0lLTGRzUGhUZmUzRi9DYVdTZUt3dWZGUG90R0xPUWhPNVJ1VVUrL0NwZjZP?=
 =?utf-8?B?cTRSUVRSTFpyK2tFWGc4Q1Jpam1Ic3I5dXRmZTRYWFdoS29JQnFYd2lFRW5y?=
 =?utf-8?B?eitzaUlOSERuWDRVenJSc2hFSVEwK3dram9RVmlBMmVMMXlQRURpKzZEOVhi?=
 =?utf-8?B?K0xKaG5EMk9rckEwRHd0VFZPMXEzd3FzT2JLR2psdnBVczhVVCtlaHR2TlRW?=
 =?utf-8?B?OWVZWFdoNmhhYTZ5K2ZwNkFFY3I2SW01Y3lWNDRiSWo5Yko1OTJKS29uSWNO?=
 =?utf-8?B?TmJocDZsYyt4ZXU4bVZ4SEVzMTlORmczMVJ5dnRPNDc0Ukk0R1Z3SHpSU0lD?=
 =?utf-8?B?aHBydWp1U0FpUm5nNkxRRjJWdWxjRVZXNWtRRnBVdVVDMllBR1IxN1c1bjd5?=
 =?utf-8?Q?YyQcXZVk6XVrtAMEyLbUdmMB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f777ca-5fc8-4c72-03bc-08dc8a060551
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:02:44.6241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JXC3NzXhKL/4dz2BVGpHRpFWR0wlFoUrSb7zLdl8A7sywpJM+Y371Ncl2swSVol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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



On 6/4/24 10:38, Neal Frager wrote:
> This patch corrects the mio and pll configuration registers for using usb3
> on the kd240 starter kit.  Without this patch, the usb3 to sd card bridge does
> not initialize correctly and u-boot is unable to find the OS located on the
> kd240 starter kit sd card.
> 
> In addition, this patch correctly configures mio76 and mio77 as gpio pins
> which are used as reset gpio pins on the kd240 starter kit.
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
> V1->V2:
>   - rebased patch to latest u-boot master branch
>   - improved git commit message
> V2->V3:
>   - removed unnecessary serdes initialization from patch
> ---
>   .../zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c  | 23 ++++++++-----------
>   1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
> index 166e61431b..274203ffaa 100644
> --- a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
> +++ b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
> @@ -528,8 +528,8 @@ static unsigned long psu_mio_init_data(void)
>   	psu_mask_write(0xFF180124, 0x000000FEU, 0x00000002U);
>   	psu_mask_write(0xFF180128, 0x000000FEU, 0x00000002U);
>   	psu_mask_write(0xFF18012C, 0x000000FEU, 0x00000002U);
> -	psu_mask_write(0xFF180130, 0x000000FEU, 0x000000C0U);
> -	psu_mask_write(0xFF180134, 0x000000FEU, 0x000000C0U);
> +	psu_mask_write(0xFF180130, 0x000000FEU, 0x00000000U);
> +	psu_mask_write(0xFF180134, 0x000000FEU, 0x00000000U);
>   	psu_mask_write(0xFF180204, 0xFFFFFFFFU, 0x50000000U);
>   	psu_mask_write(0xFF180208, 0xFFFFFFFFU, 0x00B02020U);
>   	psu_mask_write(0xFF18020C, 0x00003FFFU, 0x00000FC0U);
> @@ -569,21 +569,16 @@ static unsigned long psu_peripherals_init_data(void)
>   	psu_mask_write(0xFD1A0100, 0x0001807CU, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x001A0000U, 0x00000000U);
>   	psu_mask_write(0xFF5E023C, 0x0093C018U, 0x00000000U);
> -	psu_mask_write(0xFF5E0230, 0x00000008U, 0x00000000U);
> +	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00000001U, 0x00000000U);
>   	psu_mask_write(0xFF180390, 0x00000004U, 0x00000004U);
>   	psu_mask_write(0xFF5E023C, 0x00000400U, 0x00000000U);
> -	psu_mask_write(0xFF5E0238, 0x00000040U, 0x00000000U);
> -	psu_mask_write(0xFF180310, 0x00008000U, 0x00000000U);
> -	psu_mask_write(0xFF180320, 0x33840000U, 0x02840000U);
> -	psu_mask_write(0xFF18031C, 0x7FFE0000U, 0x64500000U);
> -	psu_mask_write(0xFF180358, 0x00000008U, 0x00000008U);
> -	psu_mask_write(0xFF180324, 0x03C00000U, 0x00000000U);
> +	psu_mask_write(0xFF5E0238, 0x00000080U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00000400U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00008000U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00000010U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00007800U, 0x00000000U);
> -	psu_mask_write(0xFF5E0238, 0x00000004U, 0x00000000U);
> +	psu_mask_write(0xFF5E0238, 0x00000006U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00040000U, 0x00000000U);
>   	psu_mask_write(0xFF4B0024, 0x000000FFU, 0x000000FFU);
>   	psu_mask_write(0xFFCA5000, 0x00001FFFU, 0x00000000U);
> @@ -591,13 +586,15 @@ static unsigned long psu_peripherals_init_data(void)
>   	psu_mask_write(0xFFA60040, 0x80000000U, 0x80000000U);
>   	psu_mask_write(0xFF260020, 0xFFFFFFFFU, 0x05F5DD18U);
>   	psu_mask_write(0xFF260000, 0x00000001U, 0x00000001U);
> -	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000202U);
> +	psu_mask_write(0xFF0A0284, 0x03FFFFFFU, 0x01000000U);
> +	psu_mask_write(0xFF0A0288, 0x03FFFFFFU, 0x01000000U);
> +	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0100U);
>   
>   	mask_delay(1);
> -	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000002U);
> +	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0000U);
>   
>   	mask_delay(5);
> -	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000202U);
> +	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0100U);
>   
>   	return 1;
>   }

Applied.
M
