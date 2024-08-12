Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFB7C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 09:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E87886A0;
	Mon, 12 Aug 2024 11:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WiBKON9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D8B886BB; Mon, 12 Aug 2024 11:42:17 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632598867B
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN1hgO9i9rzrFBahZZyIY93i5Sx+NDqOZ0esoYwowngabYi9GXMC+2mif+TCjarIEmMrx4DmtS45ZPMnmLEIeYS2YVytsAlW4vJ04s3kFJLdxivqHu/GnZZ7FvcxbIS7xaoP+1KXpuR11DBt42qU/crfIRkuITzQuvz6hzluoRg0aLDG/gSHid0FWDvl3S8Qjby2WlIgZ2qLJ/bcN1XSIu6i/ySq4Oq8QM/Cw4OOyd38yHJ8e2kORiQfxIISnYBYSBXMnWM8X9vQZsmiFvRGDOMnt4SNXEnkF0SSPRodGNJ2gLFuAx7A1abk2goXYv+OwCNnSM7Ji//xD/Z/QZ7hNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdwev+pXHTRh+UcivGhx9sFaSALNurWlFruaHmJIlJk=;
 b=LcWLXv0wvjatAGhr+RQEGA97sojmmRBZ7rhhDZqPlQ25OUehmHJWrWfErpeQMhIzwEXfUvoPvVmU/JwLu+o3CEw+Du65vdTMdZfoNkPqYipK78D5/lTw1DJDallhFRLQEzy6iHa2H7rkHFJcpba8RJQ1c7f9f0vvb2Xg681H9HcrcrD+jsP7is36QHJC8obbM4ZT5qxOM7tu4+GFnOi50z2F7ocEVtCTN4kbljk3UCXs1xyvqXwU6q4G01NlZoEyfAhuGyy457hLgwr4M9wjApUDv9bzT++hj0eqBDl/u8xEnpudH6F8HWYkemB2caxewP7NsLLemmbZrBl6BaiUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdwev+pXHTRh+UcivGhx9sFaSALNurWlFruaHmJIlJk=;
 b=WiBKON9h2F2UPsRCkMTnUxUqWJ5+P8HyBSnIaPlh8EAJgqjoGZSud6dlGAoCyGDq493ZPHDQiOPUE/Bnyut+Wto2dFDi9Tq0xc6GVXGlUMrNE/9IPkczLU3ldzpP0szIsBNShgSA8kbmi9BTO5eHWlQiFony2gobh7+B8fdHwQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:42:12 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:42:12 +0000
Message-ID: <fb0358d9-9632-4222-b69c-763e7fa381b5@cherry.de>
Date: Mon, 12 Aug 2024 11:42:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] log: Avoid including function names by default
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-9-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240811122924.4035982-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: c260af75-e69b-47cc-73b9-08dcbab30ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFZ3YXJuK2hwV2h0NEFPcE1XL2greVVtT0ZIZ05Vc3Vtb29Gb0ZTVFdIdy9X?=
 =?utf-8?B?OWF2MDE5NUNncUIzNGNoM05VMlJVQUc2NmJTRG53aHlGVXJndExJR3lkSVRV?=
 =?utf-8?B?OUhEc0xCOUtGK2lBbEY3bGs5aldQTnZWMXRib3JobXJPS2MvMUZ1QW5wa1VZ?=
 =?utf-8?B?cFdBNU5PWk52TnpkVFBFZml4TjJhbDNYNTdvZEFJbHNFdHhEVnk5d2kreEpY?=
 =?utf-8?B?d205RU5YbUdTMGtuaTdsaXlTdk1kd1pVMGpUa1dOMjN5V2JBb24vUTNtN2Qy?=
 =?utf-8?B?ZzVEeHR0d3ZuZzVyQlpDWlplZHlXeXFzaGptNTJTNkRXMFVNRHd6NTF0ajFB?=
 =?utf-8?B?Rkc2MXpNN2lqZkpHVTljVjNSYm1Sb1BCcTk4NTVoQ2g0Qm9JZldFczVRY2ky?=
 =?utf-8?B?RGt4aGgxQ29JNjdWSWgveW5QT1VyeVdydjJCdGl0bGcxVllDQmVGa1plZ0Vv?=
 =?utf-8?B?ZXQxY2M0ZTNyZC9PSENGVjl5U2lrMG5HcE94SnVlRmVtV2pycTExeDNLTDA1?=
 =?utf-8?B?WmJUQ0VNSFhCWFRSUy9Hbnp1T2JLeDFoZ0FRRGFwdVM5STFvNHp4ZzJRYU93?=
 =?utf-8?B?U2FlK3RIdmx6ZVZJT21uN1hUQ0JXNWcyZFFrOGpsVHFWTmUzNXJhNm94di9a?=
 =?utf-8?B?R2QvTnRQNnp3V0kvRFR3K0xHR3pLQjJIWGVoT3pVcDRTQjQxN0VTN0RZcU9j?=
 =?utf-8?B?Y3d6aTI5UFFwZ1J6Uzdwbzd5M2xQZTcyejlzWGMvTThMRVdCNzJPSTQyNVBw?=
 =?utf-8?B?R1NEcEFnMHN2Q2ZDdCs0UWRlZWpoT2ZwOTN6TFZiK2VyK2xlYXN3Z0tXeFFC?=
 =?utf-8?B?NUJ4aUQ3SXRvMFFLNm9nMklSQU1ObUZKSTZNZEhUMDFXQyt3Tk0rSE9yc21Z?=
 =?utf-8?B?U3paR0JrR1NmSExBQTR6MER4c3lWclJsbURrVm53OU00TzFmYVhjRmZXT0Zs?=
 =?utf-8?B?QXJOVE5HRzNQOWhZN2J4L2ZKVWlkS0w4TEMrWGRXU2YzdW1GL1JvcFJlMWZ5?=
 =?utf-8?B?NHkyV0JrY1JscytDSnZOVDdpS2lHVXlnT1V0WnNkblNQdlpOU00zSHp6VnFK?=
 =?utf-8?B?dmpnMnBuSzRLOStnQWRReFExVlkzNktZUUpadHlXcnhnMlVCQUVGbnlpTEJo?=
 =?utf-8?B?RDc1cTdoQ0FUVnpFanpVRHpkbE1ibWUvZ3owY1hjbjA3cStaMHhhMW1Fbitr?=
 =?utf-8?B?VURxT0Q2SlBWQ21rRWNwakt0NmpMVUNYRGp6R0F6S1dESEZpVWREdVRzc1Rw?=
 =?utf-8?B?aGl6WGRMd2J5NTc4TUZhb0V0SzRYcmY3QWxkTFBLbnBxYzBkcm1MUk83cmpZ?=
 =?utf-8?B?NzZWT08wYURWYlFEVEtHVHVJOS9UOTY2aUFoVTNENW1vWWc2TVVUUTh5MmNF?=
 =?utf-8?B?U2VPR0J6K0UzME9Sd01nR3k0L1ovcmx5M2dUNVduY0s3aGhlUnlYdmMvOWNI?=
 =?utf-8?B?OTRSYWN3c0dUMHZHYUFNK3h2M1ZZbW90V0VzSi93Sk5vS1lMNWpMMDUvMkFM?=
 =?utf-8?B?cjVyNWNHaHdmRzhrTzlLL0h4NHhYak1MV3FodnJwbXlCQ3NuaVRoVWcyeWI2?=
 =?utf-8?B?ZW52WVV1czhiVWJmTVBuTFFla1E0TDlrb0p0clpyTFFGU0ljdjh2YmdyV3dE?=
 =?utf-8?B?VkVrWEVvL215Zm8rMkwrUUJ6Z3IrUFdxRjBmSllld3Z6WDRDYW5iTjZ5TXRz?=
 =?utf-8?B?YmVZZ0VSM2VQQ0kwM041OHY3SStHdUc3cDZWNjdDQytsOWY2djN4ZUM1a2c0?=
 =?utf-8?B?d2FCQXE1d0dWeTF1TEdRNlJ2cG9kQVdXR2JRRkFBT1RPSlRidy9jVmk3czVS?=
 =?utf-8?B?M1lZcGhTOTYva1NoUGtYQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEFjNkZzTlFZeUprRXhySlU2dzN0SlVRb3VmdmNLclljK2x0VUNmbzdYRWRQ?=
 =?utf-8?B?dlREYk0yZDQrRTQ0Mk9zaFNSY0RJaGNlbCtHeDVIbGY4dG9XVmZpRFBtdFhF?=
 =?utf-8?B?dHQrQ1pxWWs5RUdPMlhWZHYvRldsZHhBdnJYblRqZ2g2QjdoampwVkZzOTRE?=
 =?utf-8?B?OXU0Zytsc3VZNXZOcmNCL3Jna2ZCMHM3YkNub05ERWNyckF1RXVvazY1eHlQ?=
 =?utf-8?B?ZWpKM1ZoSWFnZ3lCMG5YclJpQlphTFIyV2U2QnE2MlpGZmpHOCtPaUE0d3Nt?=
 =?utf-8?B?ODZScURaVHlQZWJJeDNua1N5TUtjRVRzY3FLNWNkMTk2Y1AvMFIyZ2pKWnEy?=
 =?utf-8?B?WFpyWVhROVVlV1pQOXpEdElzMGEvZnkzOW9peWJmWjJVdmI0NmRxTjBNN2dj?=
 =?utf-8?B?djhWNjkrL1dtQlNhZ3lvbjBpaWdIazFPb1pZNUVzV2ZFYVFnY0o0bUwycUl6?=
 =?utf-8?B?bXdGMGJiVzYvUlZvS0VMS2tHT1RXQXNzd3Q2R3lDNWxDQ0pCVjdUcjVULzU5?=
 =?utf-8?B?MC9tMzBDWStkb0doNi9EMWZjcXRIbW03THA2bVluR1lLb1daMDJBVFpmWU41?=
 =?utf-8?B?WTVTTVFVVHpVa29SRDRFTTN1YU8wTjBucFZqS3ZJVGJTK21jekdsZDdkeHo0?=
 =?utf-8?B?eExPSDdVN3AxYVFGYmp5ejlJTDRlQXRKdlBXTk16QTA5U1lVZEZVMlJiT0d2?=
 =?utf-8?B?VzhvQWFzSmhoR0NuUEYvZDZxUkRLc2lzcnhZYnB2YWZOblJvdmZYMkJ4bmN1?=
 =?utf-8?B?dmxyVWRkTVdmTEs1R3hmY2dDTDdnZmxyNGZYaUtUdEVob0MxRHIyelhBcDVh?=
 =?utf-8?B?SUJLZUlXc09mVmR1KzNzSG8zenhqdU9FMTVLWjk0UHRSU3NGeHdzbXM5OGRT?=
 =?utf-8?B?eDNVcE5pb0IwTGFkZ2cya0RVUTFBVnF4Zi81UGtSWVF2UkZ4NVNPbHpNVVVm?=
 =?utf-8?B?cWhHSXVqZWQrYitvUHk2dXQ3NGhGbG55S2xCMmZlb0RURUhmVlFvUThwUTRB?=
 =?utf-8?B?Q01MWTJOdlJOMFlKOFBjOGkwSStyUlJjM3RVVkdmWWkvdEtwSlVyWWpLbFZv?=
 =?utf-8?B?WkVQUGp0eXlhMDZ0L2tUbGtRaUVrcXUrekFIMStuTU9NUVo1ZVlWcVpPRFo1?=
 =?utf-8?B?KzJIU3ZidEVDTGg0Nk43MFlua0pTaFM0YzZLRmJkeU1YUm1NMytBaTd1aTl3?=
 =?utf-8?B?TUlGcTEzODFsUHlXMUZma0dNVnZYaFpOcHN3NDhxT1lkdG91R0ZGRFMwWDBw?=
 =?utf-8?B?c3l4bjFTcDR2c3FwV3A2eW5sbmJ3VGJmaWlnNDducXJENHlTWVBrWWFEb0I5?=
 =?utf-8?B?eE9Fd2tCeG5tdG0wTzNTZk1Ra2kwckc2OU9EY2x2SzF0ZnJ5ckV5a2xZNExU?=
 =?utf-8?B?dlhycWtKRHZvNFd1TjFZSVJHOFE0TWkzdWthRmNuUDgxdkM1TCtmVWIwL0Js?=
 =?utf-8?B?UXd0dDhkNjBvQ2pCNTZsSUpRT2tsNGJHOVc1bUREQmhWekRwOWVoWVBhQm1B?=
 =?utf-8?B?UlYyYnZVWVNJOVFBaWdPd2piSURmbkE3Wm5YRXZaVVdkKzdsNFB2Q0RiNEEr?=
 =?utf-8?B?MEY4SVIvYW54UUs2TVlzdXBpTE00SlJlRFovRFZtMWs1TGorUjY3TkpyV2Fm?=
 =?utf-8?B?Q0hLWVdtVUZDb3YxNFZIYjBObjNyY2FCL1hxU0hOTU15L2NZY2xuR0pSZTVS?=
 =?utf-8?B?VDJ4SzBxYmtRWkZCZHBhbXF6RUhKSU9LcG0xRHJYWVpqOTQ0QUFZbTZjRndo?=
 =?utf-8?B?WFhVNzJLQ0hPV2lFRzB3QlpsMm5GOGlXaWdTTk9uRlBHUVhzMXRMTWVlQW84?=
 =?utf-8?B?YmJjZ0cvd3JmNmhvNkhMSGFGSVFFZlR4WXB4SjlQREc0eXhaaGllWk9VZzJr?=
 =?utf-8?B?QjgrckNNVHF1TnlNenBtRm5hbkkvcU1pQlo4QkVDa1p4R0QybnYxNm9SaURy?=
 =?utf-8?B?dGFDeThMTUY1UjRhUVRVTDAxS2x2SElQOWJ5d1pDU2EvK2dUSkVIcTNoNjIv?=
 =?utf-8?B?clVhbW9LT1BPMEtLV1ZwcjhMTTRId2xFT1Vqb1RqRzNYUEhySFFJQlh1aDhC?=
 =?utf-8?B?QllYSXZNYmxzdmNydmVPVndiM1RwM3VNY2l3Y1MzR01sYklranpXZ2tFZW80?=
 =?utf-8?B?TDgrUzNXSTk0ZXNwemVpZXNLL2tmN1g4YjBzMmw3L01KZHJrWHpOTFM5NEdL?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c260af75-e69b-47cc-73b9-08dcbab30ab9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:42:12.2453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIBL2rwPpGFjdPOsGBjw+PI4D2K0POOPC0dakxUSn/2H6XtMnC655tZxSb+Mdza5UW3Kn+v8rxJdAIcwHipLYTOdp9W8KUgA5VF9I016dD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044
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

Hi Simon,

On 8/11/24 2:29 PM, Simon Glass wrote:
> Unless function names are requested, the logging system should not
> compile these into the code. Adjust the macros to handle this.
> 
> This means that turning on function names at runtime won't work unless
> CONFIG_LOGF_FUNC is enabled. We could perhaps split this into a
> separate option if that is a problem.
> 
> Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
> function names to be included. Fix up the pinmux test which checks a
> logging statement.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v2)
> 

You did make some changes though:
common/log_syslog.c wasn't patched in v2.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
