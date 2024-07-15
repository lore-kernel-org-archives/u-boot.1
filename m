Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59DAC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 08:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2650984374;
	Mon, 15 Jul 2024 10:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AIwC4RvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E429831A1; Mon, 15 Jul 2024 10:56:44 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA068780A
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 10:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuB/z20yW2wFK8/V9M/fseH9uJVAmd3faMvPvkaGTNO9wUzgsuPsO8ND51OF6p9SrJCbvp61cCCnhy2KwxgIVVkNbF264kaTHLk41MSeQQrEAGwygxlW2HUnV6+/BJ+fcwpxo8JFH920mwA8zNZrfWO3XhQ6k/b2/iJYer0yDmGVaINBsd3OkJ/j3y90o2KJIetmauyE6NSeKXibbgKQyvJ35T4uUl+ZiSh0tEHDvDfZZqciZ/pz14H2o1jlwQrEnJfFq+9BmWaonLn90DSWC9E4lFv4P9mrFuX4KGskxRcrH5TYdZUGtsWKz7lG1Af2UldfcAWt4h/FdCsBO+cpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/cUcyWR0jjWkOIFFQwmLO2oKTbg5vTiA7+8hlWbAfQ=;
 b=Oay3aDx8+RJyf4KSNxizmD7PXwoLq6k6yLVq10hBy8Hi6tcN+06r5XY45+1amxWZv0PoAEp4wT3b+DiT6LIflhhZ2fhHgRyZYCmwtzJeylgDcDq7YhaborMSAYrmzj51e1IzMyLBLLze9YeTnyFzyW0fRloMaMF6iThe/o7xMcD8SuKY+ANZyhwLP7WQ+0mAsMrAC+aOG2rcl0DQ+Vad2s8gw00ie0HU8dNBnOXG2rK8FdNl9QnORTPJCDwQFl89af2SysNm41WYC/v/ta1YhJyt15ei4DEpNe/Vlq1Rd0vnBhp8+3kPlxcN/i9WoCCW9wa4c/PnBawbNhF2gnRcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/cUcyWR0jjWkOIFFQwmLO2oKTbg5vTiA7+8hlWbAfQ=;
 b=AIwC4RvKZoJwblMX1JVAuNUO32pFCHVb+E4SSPp1DelQdYN/s0jGhNfkKDADS4HEZ+mu6m2HKFDFevdpS1CJWG++9URm8mdffFXHWBFqwSqHZNlOhG603wSYr+ZGglerCPFctt4DGAdjn9Ar8FDSfrlLBhaxqiwnfUsI/aqO/UQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Mon, 15 Jul
 2024 08:56:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 08:56:38 +0000
Message-ID: <97d63ed0-e26c-40a1-9422-81453617d02a@cherry.de>
Date: Mon, 15 Jul 2024 10:56:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: button: support remapping phone keys
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
 <bea25c3e-3257-4316-b7c7-ec3fa8d5bfb0@cherry.de>
 <4d222507-3e68-411e-ad8a-c355ed1b8b9c@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <4d222507-3e68-411e-ad8a-c355ed1b8b9c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::26) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 79546ed8-2ebe-449d-d78a-08dca4ac099b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWkrNjRGakpsTG9RbHMvaVFnMEgyejN1L3hCVVZMNmVhM0dhRE13bUxFQmF3?=
 =?utf-8?B?V0tGbXRRUkRtVDhXVFZreVJzS01WcUdldG5Id3VJM0FSQkorc3ZjWHprbnRU?=
 =?utf-8?B?ZVpHaHN6ZHdiRDVTRG5Ka3U1dkU1b2tLdmt4QWpXME1xUjI0Z2ZEeEF2WlA4?=
 =?utf-8?B?Ui9neFViQWhjM3RiMXhla096YnN3amV1eWNxc1ZDQnhHUHJBWkpXR3Q3U1M2?=
 =?utf-8?B?djZ4Z2hoS0lJd29DRjdMNVNqUUdQdy9VK29zYXVMTjJtbVYzQkZwQ3dNaXlw?=
 =?utf-8?B?NjFJakVtM3RvT2VKNGlCT0QwbFA2a3B0Rmk0Y0ZoNzlvdkFoSHB1MFhMczBN?=
 =?utf-8?B?dlUvNG9GZ2tKOUk1SVJLZ000WDlCOTFpejlCa2NsRTVKdTF1bVo4eDlacGFE?=
 =?utf-8?B?MmI5ZjhwUlBja3dNd2syN01PM2RYSGFkOXJzYnlUcVdzd1lXckRCN1RJa2pB?=
 =?utf-8?B?cTV6bllRNnFFZ1dJa3gwV0luSGpJclV5OC82eU9jU0hCZHIrY2ZrOXVYU1hn?=
 =?utf-8?B?R2Z4eVZ2WlpTbnR3YUJPeTRCbFhZc1VkQ2dVU09lM1JmRDVpSDk1QTA1aHVl?=
 =?utf-8?B?cWdCMjBDeFpac2MwSzhYanVLQTJhRytReXpZa1Iva3ptTWFkOXh1THgvdm0r?=
 =?utf-8?B?MkJRd1h1ektYZ25xSWt3bk4rZXY2dk4yY0xRL3kvbG1NU3Fnd3Nua0ViVW9D?=
 =?utf-8?B?NG5hM21vUXNIU255SWxpTDd4Q2NCTzdQSHF2ZEt0WHRaaVFLR1pSek1aa1U0?=
 =?utf-8?B?RThIRWplaFRRc2ZhUTgxTWtRdDgvaW4xQWg0VGhPTGczK1VJOWZMb3g3ZXdO?=
 =?utf-8?B?bDRhTnVqWHdBeWpEdmFKVlIwaGN6eVcyMm03OTV3TmhPRGlURDUzSlpsSENV?=
 =?utf-8?B?L1NDYzUwc3dPUUIvODZ5anVySWRrVDNEUEZuMDROSXVCK0QwcUZNYmlvVEhS?=
 =?utf-8?B?T3BMRURUSkxDbG1adDRRUGZXb1grbEhQdmtoNnVrVTdZcXpKUU1rZDNZMkg4?=
 =?utf-8?B?WERjTWhxKzI0dnpqU0E4bWdEVFRkQk5CMjJHSHh6TUZvaDZ5S0ZBd0lyMVQz?=
 =?utf-8?B?UXZvcFJGOHB6RnJ6YnZ3S1RVN3hPUVZ3VzI3djhaNEkvR2kwdjhaVVRmQ2hM?=
 =?utf-8?B?eUFUczBadTJNTlBud05RaHNhenZXTERxaml2cjZUVlBjUmsybnpnZS9iVHNY?=
 =?utf-8?B?clRFQzUzR0twaFlsTWdyOG1YL0xoZHovMEh5UUR1MFJNMVZoWjZmaktjVkZt?=
 =?utf-8?B?dDgvWmZVNlplYk1FS3ltMjVzRlRodHZaemp4TCtkWmNkVGxLcGhsdytZcmdL?=
 =?utf-8?B?VkpQWnF6VXpYRkdUWFFYSjFHd09TeXJRdzA2NTJXSkpqa01tcDZCTjVFb3E1?=
 =?utf-8?B?ZHR1cVgxVFpSQWVXVWc2VVk1WmpJckxENGtHZHRSVThHOTZQVlgrcG5nc2lw?=
 =?utf-8?B?WkhBTW1HYXZnVzJuTWxrUm5TdlR0YyswS2k1RElMYkVrbm5lcUMyOW5QUVpr?=
 =?utf-8?B?SHFnTlFuemgrS0c0cWVoOHRjc2FLd1N2Y2xROVUrM3h0UE1YeklSYU1iQ1VD?=
 =?utf-8?B?aC9FUDZnblB0L08wQkUveHNkYjNTazdhNXB0eFo5MklYZmdhUWNRMXB1dVhY?=
 =?utf-8?B?U1ZLQWoveVlVK0s3dHdVZERUaHpMOVphdmxRclJqZjdQZHZicDdUSGxBR0tI?=
 =?utf-8?B?SzVpWUVheTBaa0ZGSHk3M2JjTS9ENWxxYWJmcStsU1RBTnhrblY1eWNHMTJB?=
 =?utf-8?Q?95fFUYKIVCj/MBFN2g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FCWlJTcjM4b1hGTjE4SU5OaElMaURqMHZVVXJrSHdVbjZ6SDAxZ0JHcDNk?=
 =?utf-8?B?UjRnTEp0eituVWhMMS9FTThRbmdQbFlPemNMeUNrZk54Z016RkNMcitNU1Zi?=
 =?utf-8?B?Tkxkbm1oWXlVQksrWG1jc1RuRmxQcWRGOG1ONU1tYTZIT3IwUExzckVjNDBk?=
 =?utf-8?B?Z0J5RVoyZXJkbmVva3pFUWpPTUdOelBPUVFXbzlWeFZLRFVTL3NjRkFXZGtD?=
 =?utf-8?B?eTVZRWc3NTdtK01MdjBsK3ZOdWM4S1ZXK3BMOEdBQVAzdXN4WWhPNHRUUnAz?=
 =?utf-8?B?bnFQc2wvWE5QYzN4QndrY2l2NlYzdTlseWlZTWhWSnIySXQ1WmJDOVl4UmpZ?=
 =?utf-8?B?Tjlhdm94YS9xRFdNNUZsNmg0OVNESWd2NjFIVGo4dWFlZnNHSEFwWjZKTWNy?=
 =?utf-8?B?cnhYSllFNlk4VlMzckZyYUwzZUlRUG1LdWNGaHRDNjJFNDIxZ1gydTdvSnpZ?=
 =?utf-8?B?YkhpTFFTSDMwWFhOZW5DeUZTSHppZitIVDJEaHpRaDhLOCtmQVlHRG5XNmc0?=
 =?utf-8?B?L1pNcmt3MVBnb2tqMzJ4QmY5bW12UVQ0VDNNam4rSkJVb2tjNC81SEJPSjh1?=
 =?utf-8?B?YTBGQTJLU3Fwc2lYRGpMeEV2d1Q0L3kzQjluUExUZWNDSkt6L0VuTTVsSXdJ?=
 =?utf-8?B?NEJza2tQYTJzWjJSUlVLQjQvM3VLeUV5T1MzaFIxMWhsYWpjZDJHTWxGaWIv?=
 =?utf-8?B?RkNJWDB5dENweFFZeGxaY2g0RWg4eWxKQjF3d3J4US8vNVZ0YW0yV0xvb0cx?=
 =?utf-8?B?L0tDbE5xV3FOaFV5SkZyRXlKNnJ6dGUzaWNVWnp0UUZYeE8xbXExN3pKVURz?=
 =?utf-8?B?R0lWOVZucWtxajBabDZxSXBJNXZUbmJyMnVQVjdmdDRWTUYzODdQdll2d2JG?=
 =?utf-8?B?R1FYSWV6ODdWSHNHTk83UHZsdVh3cE5hbklPZ2F6Z1E1MGx6bFB5MDBQVjdz?=
 =?utf-8?B?TmhuOXcxQmJ1am1IU1ErbkJ4ZU03amhGMm82bjdrMzVBK3AzZW1GN25lR0wr?=
 =?utf-8?B?ejBUMHdOV013L1pMd2dhNWF0azZNZ1dBZEZuOHFFVy9yMEZ0OHNBV2dGWXVC?=
 =?utf-8?B?TXBudk9vaXRMZ3FpbjgvSTA5bnNIL2x2K0szaGEwRGxzOWdtWTJ0V3R0WFY4?=
 =?utf-8?B?N3BYSUpJbk0yTmNMQTNOZlQreFNXMFM5bm9VVllCekNzeEQxUU0yMGJCdGd4?=
 =?utf-8?B?VjVIdjJhTm5lblFkT3hMUnBGbFkwYmVNSi9RYSttcUVhNVF1ZUYwU0liUGhn?=
 =?utf-8?B?alp0YjRKdmJtb0o1YXRGWFY2T3E1LzV4VUV0akU3Y3FzUEVYd1NKd0Z5ZkJI?=
 =?utf-8?B?RTZUUGx4RENxYVc0TVhjZ0h6dStFaW9YclRsTWg2VWtuZWNWdWFSalNjNWU4?=
 =?utf-8?B?bEE3Y1hncXdWWHZabmF5ekVVQjlrb0xrNXhqLzFhRmExZlJSaTNqbXhyNXkx?=
 =?utf-8?B?ZFpNSVhIV2cweEhIMXBZLzVySnMvTUtJU1NKYlFGYnAvYVpZdDlwWDVGYlY4?=
 =?utf-8?B?V1JjMGV0TXNRU0RFQXNTZFVyRys5NkNMK0RVdmlGSWt1SWpTdTFzZUJsNzg4?=
 =?utf-8?B?QkhSVEVtMDNSc3k2cHBlUWhMRlZzdTFlUDI2MVZVR0o0eGZQZTdPdUJSSWJh?=
 =?utf-8?B?ZjE4end0WmE0azlqQ0p3aWxMUEwwL2sra0txL3Y2OWZGTi9BR2FwYTdsZGw2?=
 =?utf-8?B?L0tVUTVkNTdMK3ZKb0tURGNZYlJNNWhwK0tMYTNadTdiVmUxRnpyaGU4dlNk?=
 =?utf-8?B?N1ZVVlZRaklWSWpFS0tMUExhQkFPOXYraVY2VzdWVGFaT2MwQVpDTTVmSDZx?=
 =?utf-8?B?dUJmQkg5dm9pZjFEWC91WHQxMEg0K0F5WlV5MjVob1l6eWpPTjZNVEJZWTNJ?=
 =?utf-8?B?akx5WWRhR0RVMjBsYWVIR0hOaTV1SmE4NlhUQmQ0amt3ZExmY29YcFZhcGFz?=
 =?utf-8?B?V2tvSmpaR1cwY2Y3dS9kM0M5aUk4UTVTbFlrdkxKcDFjQnVJaXd3aEcxZzE1?=
 =?utf-8?B?VzNnay9vZVJWL1ZHV2c3UlJySHV2dHl0bVE2Q0E4MW9iS2p6cVRBM2I4OG9M?=
 =?utf-8?B?QWtMUUI0SkF1WlRQamNXSmRtTG1XbzBrYVg2R2pkNyt0ZVRmUEdFbGVNU2xJ?=
 =?utf-8?B?VlM2SXNvWWdFd241TnBXQks2a2pBNWRJNlJzZXhBenhUQklZdXl0S1NQa0xz?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 79546ed8-2ebe-449d-d78a-08dca4ac099b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 08:56:38.3756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KehSIMn9F8+wROFqDhNoYj9aVsmj6NsFC3hia5uwDJ4bXaIwSm6Gjz3JWxKNdieIsiVkYpL+cc1w6USQQ8QBItyp8hy7cJPiAVBj7D3QIFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
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

Hi Caleb,

On 7/15/24 10:38 AM, Caleb Connolly wrote:
> Hi Quentin,
> 
> On 15/07/2024 10:16, Quentin Schulz wrote:
>> Hi Caleb,
>>
>> On 7/14/24 9:49 PM, Caleb Connolly wrote:
>>> We don't have audio support in U-Boot, but we do have boot menus. Add an
>>> option to re-map the volume and power buttons to up/down/enter so that
>>> in situations where these are the only available buttons (such as on
>>> mobile phones) it's still possible to navigate menus built in U-Boot or
>>> an external EFI app like GRUB or systemd-boot.
>>>
>>
>> Are those event codes properly defined in the DT already?
>>
>> e.g. 
>> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts#L31
>>
>> If so, what prevents us from simply patching the U-Boot DT to change 
>> that code? No additional code required anywhere, no need to maintain a 
>> list of mapping, etc...
> 
> Many platforms in U-Boot are now switching to upstream DT, and 
> SystemReady compliance requires that the bootloader provide a DT to the 
> kernel.
> 

I guess you meant to say "the same DT" to the kernel here?

But yeah, that's what I was afraid of.

> U-Boot doesn't really have a generic way to apply specific adjustments 
> to FDT for U-Boot without them being carried over to the kernel.
> 
> Patching FDT is in and of itself somewhat treacherous without using 
> OF_LIVE, which isn't set up until after bind(), making it unsuitable. 
> It's also vastly slower to patch FDT than to patch a livetree.
> 
> I couldn't conceive of a way to do via patching DT that wouldn't require 
> solving the above problems, I also couldn't think of another example 
> that would justify making this patch more generic or configurable.
> 
> Kind regards,
>>
>> If that isn't possible, .........
>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>> Cc: u-boot-qcom@groups.io
>>> ---
>>>   drivers/button/Kconfig         | 11 +++++++++++
>>>   drivers/button/button-uclass.c | 22 +++++++++++++++++++++-
>>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
>>> index 3918b05ae03e..6cae16fcc8bf 100644
>>> --- a/drivers/button/Kconfig
>>> +++ b/drivers/button/Kconfig
>>> @@ -8,8 +8,19 @@ config BUTTON
>>>         U-Boot provides a uclass API to implement this feature. 
>>> Button drivers
>>>         can provide access to board-specific buttons. Use of the 
>>> device tree
>>>         for configuration is encouraged.
>>> +config BUTTON_REMAP_PHONE_KEYS
>>> +    bool "Remap phone keys for navigation"
>>> +    depends on BUTTON
>>> +    help
>>> +      Enable remapping of phone keys to navigation keys. This is 
>>> useful for
>>> +      devices with phone keys that are not used in U-Boot. The phone 
>>> keys
>>> +      are remapped to the following navigation keys:
>>> +      - Volume up: Up
>>> +      - Volume down: Down
>>> +      - Power: Enter
>>> +

Should this be alphabetically sorted (I don't know if we have any rule 
for Kconfig options?) in the Kconfig file?

>>>   config BUTTON_ADC
>>>       bool "Button adc"
>>>       depends on BUTTON
>>>       depends on ADC
>>> diff --git a/drivers/button/button-uclass.c 
>>> b/drivers/button/button-uclass.c
>>> index cda243389df3..729983d58701 100644
>>> --- a/drivers/button/button-uclass.c
>>> +++ b/drivers/button/button-uclass.c
>>> @@ -9,8 +9,9 @@
>>>   #include <button.h>
>>>   #include <dm.h>
>>>   #include <dm/uclass-internal.h>
>>> +#include <dt-bindings/input/linux-event-codes.h>

Does this work for boards without OF_UPSTREAM? Otherwise I suggest to 
use <linux/input.h> instead.

Nit: Missing newline between headers and first function?

>>>   int button_get_by_label(const char *label, struct udevice **devp)
>>>   {
>>>       struct udevice *dev;
>>> @@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct 
>>> udevice *dev)
>>>       return ops->get_state(dev);
>>>   }
>>> +static int button_remap_phone_keys(int code)
>>> +{
>>> +    switch (code) {
>>> +    case KEY_VOLUMEUP:
>>> +        return KEY_UP;
>>> +    case KEY_VOLUMEDOWN:
>>> +        return KEY_DOWN;
>>> +    case KEY_POWER:
>>> +        return KEY_ENTER;
>>> +    default:
>>> +        return code;
>>> +    }
>>> +}
>>> +
>>
>> ....... I suggest to make this a weak function that can be overridden 
>> by boards (should it maybe be only defined in boards C file?) so that 
>> it's easy for people to come up with their own mapping without having 
>> to deal with two people/the maintainer disagreeing with what should be 
>> the one and true mapping for that key.
>>

I guess this could be done the day we need it to be more generic.

Thanks,
Quentin
