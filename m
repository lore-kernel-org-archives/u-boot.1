Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A51CF9C4B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3709188CC3;
	Fri, 20 Sep 2024 17:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CqagXy7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D515388CC3; Fri, 20 Sep 2024 17:12:58 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A3988CC2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoU8A99y1scGv5PFIDr0RjwG84JnozbVPIosCitN6keLRKn07DHLBaQc1Y5O5lMlK2V+BBXVxf0S+eBzc5ly5GubrhYhZ+Wbg8jxcusCMHfIeLDf86k5gJSohBOl596laMChBAoZBYXQlU1D1GUGAx+JXSWEj3Ogrkv6/N7Bh2jhAp+oqguNCjszjDlDfPi7tuUivCb8AsddeZbkLB4sIH3/sQKJvU/7Fg8X74tvXCy5zY9W0TgP94odxXYoYd5/b69O/UTdc7PYDAI/1xfHk1Bf3tAH99fwhypvvrB0hEo6i+sGR7zkyfKRFwOGTpbaiJ9Bi/SX/Tg1P6jjrwdB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6UeHvFl0uY25GUe62gZ3AdHbITochpaa/Ezx+dUW9g=;
 b=kdLh09t427k/Z0kueX2882JaAWoe9S414UduZCeulk4M2orzHRF1EzQ3remvDmYnAjN96QIKhnoWo/SO36HKmbl1Hl4xRFH9KU4RoRO1mgof+XfkkG4112qmE5UwgIrYPeSOCh4MNmilxHbe8/6D/F/MCOZnxavhphpd/0aw6GjsBzw1hriytGJbuSBT1HDGB/xaCOg1v1FQSyDA8R25jpCvB8n+iiogyXxTksmV5nTx7OK2nokiiuIH/ZncNiIKs6lcN8JbWPmFpfwy1gdoOTen+hH2G9HW2S2wDM+l+HHp9eyi2B+hAXmW8eM34Lo0xKQeujCDMTp+L2FEERVzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6UeHvFl0uY25GUe62gZ3AdHbITochpaa/Ezx+dUW9g=;
 b=CqagXy7f7vnVhP1qtnKSSSI6FLSNv8ysRugXUNXEmQ5witxgVH9+62jGLulYJzlnbT4MxARQIqPhr6Ui2GaBoOYl2WJUCkKaj212iQyS0Y/iQT5BRMM8Cj5ryc+BoE8LKhfubqaareV/xzBY2OuPR6Kis3STRJpOqZSj4DHVvAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 15:12:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Fri, 20 Sep 2024
 15:12:53 +0000
Message-ID: <bf433506-e17d-4e3e-8391-37a23d4d64aa@cherry.de>
Date: Fri, 20 Sep 2024 17:12:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399: Weaken dependency on SPL serial
To: Daniel Semkowicz <dse@thaumatec.com>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240920090613.76154-1-dse@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240920090613.76154-1-dse@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: f51ba4d7-06a4-4633-da7a-08dcd986b327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGN5dHp2QXc5eG1KTEsrZFdOUnl4TWFlMURCTCtEMEpKb2xNeVI3K1d6citZ?=
 =?utf-8?B?Tm1kRlBKTytNSjREKy9oNG9EVWpObS82WDBFY0M5SytyeG5tSGdGdUxiWkdF?=
 =?utf-8?B?UFFrQ0t4QnVkcDNTYndScjNrWm9TWWdLVkN6TjhNN3lRM01EVGZzSVl5NG9q?=
 =?utf-8?B?MWlBelBVaU54MVMwekQ0bCtRWjFoNWYwVkxGaGNkUE9UQWNMb3ViUDhsZVN6?=
 =?utf-8?B?MnhkeEdWeG1pYmxDNEhXdW1QZUJjM3A0TUxlNFArclBmdjY3NjV6c2xIbTVG?=
 =?utf-8?B?bWNJWVBFSjVqMXIxYmNmMi9oYUNBVncxVmd0d05IVHhybTJrSEVsYVVGeUg4?=
 =?utf-8?B?Rkw0c3pCL0c3UW1ZcXcxOEhEcER4NG1VSXFIOVJuQnlyL0NRSzhTYk9tODZB?=
 =?utf-8?B?SFYzTkZ0bDFmVEhwV1V1ZGw4TThVU3VSN2pYQkxtQ3hKdnlGOVZtb0xlTzF0?=
 =?utf-8?B?T2V4V2R1NWV4MmI0dHlVekE4Ums4eEVyODYvTDFHQ2c5emg2RllGZTZ4MGJp?=
 =?utf-8?B?ZEo1TVRCTytZTlB1VEl1bmN5UWNhVURNcWZhWURFZTVyczhvRnBRdXhpU29F?=
 =?utf-8?B?a3NyblVuc2dCUlYvbzFrb0FOSysyMDFWd01QSC9yWDhoMTZ6UTk0Q09XbHBT?=
 =?utf-8?B?OVlJVTZlME1mWm1Od1djbTkyQzVNNUhYZGJIOExoUHlQMjZzUURNR2lydU5p?=
 =?utf-8?B?QXU0SCtGbmxyZzBEYk56aGhGN0hLQXdRS1cyaVM0eWVYc2FRS3EyRU1KV2ds?=
 =?utf-8?B?MGQvWThUd0lRK3BuNGJqeTZ3cGFPRUxaRmlUdXNSMXB3U3pQYWw0Sm5aTWk2?=
 =?utf-8?B?dWw4NDFFQjdCcUxIMGgrdzBybzVzT2RxU2VYRHB0Wi9lMVkyMjVtNUJDSVFD?=
 =?utf-8?B?TGlOa2l6WjdDM29RQzZ2eEV4dkl5MkIyMm93VU8yVm9oQURxNG9JZHY1Ry9Q?=
 =?utf-8?B?RFhHaW1PZVFaL1JmZkFaMWxWRGJpQ08vZ3BaT1FkcmQ2N3FrbGdFaFZwZnJU?=
 =?utf-8?B?amozTTgvM2UvUFZWSG1Cc3BLY0lwY3l0T3RhVEc0c1BFdHlPcGMwaTZaMGp1?=
 =?utf-8?B?ZXdjN2I1OHdaSmZka0YxOFp5YmdtNzMrNjhDcTFFRSt4Z0JMeklpb1EvMFVx?=
 =?utf-8?B?bWNuUU9mMDBmUGxhY05CdG0yWCtEd3NBRjc4M1orUHExVDI5VTI0dFpUckRO?=
 =?utf-8?B?UVd0UlN3ekZlWlExcWNjRnpuUW04cVBOcE9hY2ptREZFT1ZqYzhwWWQyVzht?=
 =?utf-8?B?anBmUzlRRC9GcDZOZ25jc3kzeDBERnZnWEJlWWVVSlBOWVVpSm1yNzRCTEU0?=
 =?utf-8?B?TlhaNmJISVFMUjhHV1NLMllqRVQydklEVGtoOWJ2WWpPTFpHQm1xMGRFUFVN?=
 =?utf-8?B?bkY2OWkxMHR1Wmo5cURWK0RnWkVBY1QzbFRhTSsyQlVHendQQ2RwRjhpY1Bi?=
 =?utf-8?B?U2RqRk10V0Q0dE53bFNiQ280OGlESlVhNTUwV0JrRE53blYvM3F3Q25JQnRY?=
 =?utf-8?B?NFRpVERYZzdodkk0NHBWSU01aW93UWxDdjN4VkdVRWp4MHcrWW9UVERNcUxs?=
 =?utf-8?B?eFpGalBiS3ZzN0VCV2lTQ0hEemdXRkZvK0VrZmNwMFh4R2hzL1FzZncvcWJZ?=
 =?utf-8?B?UHRKOWhlZ1dPSkhvTE1SdGJySDEzSHZCK0ozK2hiQU5IUWo3WFZKZTB1cjVX?=
 =?utf-8?B?S095VFpoZllLODQxU1BOczh6cS9tNVk2eHBrVEIvS3FrbFdNcEw5UFJzUHR4?=
 =?utf-8?B?RkI2SFo1RlRxYkQwOVBJc1Vwa2R5ZEp0cXRzZzZCc2kvaGlrVTl0UGVINHZh?=
 =?utf-8?B?MVRISHNhVDFzNXY5aVZ3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aExjdWNWMnZUVHBmdE5nMnJDOER6eGNPUG9UdHoxblRyeDNWZGYyZFVnYVg2?=
 =?utf-8?B?L3dYd2t6eE81VHlTK2JFVkoxYWhhRnpTY0Z6dGh1VXRWTTh6SmNQcHBCNm0v?=
 =?utf-8?B?a1FkWmt1cWJlVlI4QkhYYmw1ZUd0Sm5yd0NEWFlVb3k2SGVYL00zbGlzOWxm?=
 =?utf-8?B?YmtQTDN4M282N2EvU0NWVktPMkF4RTI5enNMcjliUXNvb1d1c3N1NUtSMWxW?=
 =?utf-8?B?RUEvTHUvaGNJbHdlQjdRMThDN0x4MkVGUE0vNnVlNTI3b0lDUVBtZGFIcWlQ?=
 =?utf-8?B?SzI4ZVAvcHI5WlpwbTA5WWxFR21SbGM3c0dkZlFDVW9Gdm0zODNEOU45OURP?=
 =?utf-8?B?V0hNcUg5SThlN0luWUIwMHp6NllPa21ESUo2R0pheFJMcG9UVisrNk9Kei9B?=
 =?utf-8?B?SkdRZGxZaWk1ZHRBbmxIakoydFpnMEhMRGhjUzhPMlE0STROWkJ0SkZ3VUg3?=
 =?utf-8?B?TDRWMlg1djEzL1l0Q2RzdmVjWUE3SWJ6T1I4eVE2VjczcWJzM1FDT2Yyaitw?=
 =?utf-8?B?V0RQeU1DdzQ3dCs0OHpQekk1Wk1qSXdOZElxSHdML2JzNGxCN0VGRkw2ekVj?=
 =?utf-8?B?d2Q1UFkwdVcxL0x1NW1Oc0NqUTFkZzZySGJNTndhMmtUYTRNU3pKTVljNGU5?=
 =?utf-8?B?RndpNkh5SHRBYjFoejVzMFZOblFEemxMTnNEWDJVK0N6WXJ3UXZuMjVQczVT?=
 =?utf-8?B?YlVPTGZXZWFMVS9ybGU4OWtkd0NiZXFCZVVFRmI1MFRaYSs3SXZSOEJVcTll?=
 =?utf-8?B?dFhlZUhDc0d6cmFwTGZPclliai9Gc1hvU2QzQ0ZVTXd3eENKWGJhOTBuVStu?=
 =?utf-8?B?c1JkWUZpSnFVVVhUbTFaTmMxc1pMelMramtRSmdKU2t3MXNUWU9KRUd5UEZH?=
 =?utf-8?B?R2hvY2tDZWd1U3EvaEFQbitOTTBQVWhsRWd3MzZQUXl2MUpBdC9CTStpYkcr?=
 =?utf-8?B?eTZUWGpYTi9lT2hicjJkYU9rR01oNFR6bGJqa0dsYUpqWWR6T0FybVMwRk8w?=
 =?utf-8?B?T1hUU1JKT29MaHNXMXpsNFNCaEkwNnlPQnhKd1dlZFdKMGxuWktVYWEycGwy?=
 =?utf-8?B?RkQ0Rm1uR1JTc0kxVC81cDgweHN2YTRjYlRTQUdscUVJN1ZiVmNFYXJQSEtU?=
 =?utf-8?B?dmhSd3NFZ2Z4ZmlWVlU5VCtHbjZnNDlDMTZZc3ppVkVXMWxheGlGRkhBUjM4?=
 =?utf-8?B?Q0tkUERrNDMrTFNjKzFPcEZRUW1sVXhrcG1BVFlUWnhKeGJsV2lSUzZpYU5a?=
 =?utf-8?B?Q0hodFl4cW1FTWtrMStVVFNvdjg0dm04NkJrQXpDcGNoOTUvM2NRR0wyZjZp?=
 =?utf-8?B?THRrNTcwa3o0SGhBK1NlUnprUEVVNSt1YU5DbkhlVlZMZkpISW4zNDFDS243?=
 =?utf-8?B?NFVPRWNVK1BaNWhNWGVjY3NUa3Z4azErWmVlTEovdnJ2ZU10WGlBWE44L0lx?=
 =?utf-8?B?Vm1GVUlyQ2Q0cEhOOWdqOGMvZktDQlpGbWlVamlRNmlTSUZlbHZoSVRqVWRh?=
 =?utf-8?B?bGg0ekxYaGRjbisxcXF2eGYzMGFrQVNMYzlIcnVUbWNwTTNtUmJkWUlaNkhi?=
 =?utf-8?B?NTBWdmhVdzZ5MW44ZW56bWdPRjR2SE1kVi9pTWVwV0pWZWNqd0xMM0NwZFZV?=
 =?utf-8?B?Nmp1Y0dhL0s4RmdFczJ3Q2s1YlgrUkFxS3VwekN0bmpSalZDSzVhTnlVMkhH?=
 =?utf-8?B?SjZqMVFZYXorem5kN3FiTVpLRmtLRzdPZXJseWc5YmJ5V2VBY0VmR3NxZkZE?=
 =?utf-8?B?c01XSEZvdW5HRktEckovUHIvWHZyOVN4bjNDUDBlOFE1Y040Q3RRUTIzZTVC?=
 =?utf-8?B?VkNuWGludlNKZ0o3WElaeFlNckdoQjJsYXhjZmZoNnBVaVBDc05WSTVuQ2JT?=
 =?utf-8?B?cXdPL1VHMm14cE1ITENKQUJCajMxTGVVeG1QNHdqRElEYTlpMGJnSVpzVnF6?=
 =?utf-8?B?RkdEWm4xemgxZFVpYlVZM0tSdVVCR2ozdlN3NnpnaEcxMVhvVzVvMHpqaE9n?=
 =?utf-8?B?dEIrZW5oUnlDYjNNYll5Ris0OWVsbDdkT093dFovQ3FzMEV0dEw1ODhHV25G?=
 =?utf-8?B?OHlsR2twMlphcDRJN0VkSGtYcHNONHd5YjZnb0E1S2lnTnhYRWlEc0dxSVgz?=
 =?utf-8?Q?LhnYnuh53dnJ4fG/o6RIeywK+?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f51ba4d7-06a4-4633-da7a-08dcd986b327
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 15:12:53.6410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cBVGwZqMQ56Jw6nEyuUZtJ8wgyMCGDVelwiYUeRo3qadzNIo88GprPaQbMXHcQd/ikjW8pPtueDZL/5PTxMLiAxbm8sINTtW2veEFxVJ0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6839
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

Hi Daniel,

On 9/20/24 11:06 AM, Daniel Semkowicz wrote:
> Allow to disable serial console in SPL. Weak dependency is already used
> with TPL serial.
> 
> Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
