Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2016AC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 11:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA4D88651;
	Tue, 11 Jun 2024 13:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ANTQKG18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5592388652; Tue, 11 Jun 2024 13:27:19 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F02AA88650
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iewpFvVZZLwu9hy8h7Cun/KrRePgpXZwIPE48X9ikCcJWJnX0yk4Lz1c+fb0GGMFFAHyJ3p6BRj0FRKckRW6TKpPw+ukVcb3HpNIKfq/Z86i9/1ADw3KrFvICa9DOncjfOHZZlWfrV9WAI1a7cGwXa3XrjF98MKdppWqciZRMHDS1UGaDpS+QHwYWcJhFmaLezQT6SHqjxwscwnOBaYLClB7Y5Nopy1/mIu89WOvOfSvPyGCzbhplOI2GKakLxU0i1M7l2cl0lfCVJS4BqUhYyEa99W2MBGafbf7Slgz8/SmhWoXB6BsGg5Wg2WLfJwG8AlWo+hW7KkPRQJMMIcS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FynTFNrtUMjncUPQVw5mokggyk4vp5YruJIEeoFrxt8=;
 b=l1npD7FlGTa7x60UzRFACbU3YsS4e9mCjecX6xrdbuMVS3RwK/6pAcPqOs5oPMGrBAny/ZPF9ywZDaigNCZ1aGx8vW4MlzSn+Tij2iJZI9n+mr2fRcD9J+Kn5R6ICyc5hnZrKQdWN7pw1PHGGUMLHmAdXXl3yFNoQ7ku+2d2vkwUGAyFUNkIoBdXPugZhvENYVE1W8gAeHSxQ+czZzLGLq8Uw2p37TQwCV8A8G1g2+U6enSK4SzBa2y/oEn1bYriBRKtQQr1CxINDmauGy9P41wV/skJK5l4VUCk1yX7R6yqDJNsClWDAf7iY7PGzxa6YqzfafMAL9crp495KsumxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FynTFNrtUMjncUPQVw5mokggyk4vp5YruJIEeoFrxt8=;
 b=ANTQKG18033OxtThD8/bKO/yZIVqnrjn9AWXzt3Oeeb/H0mMDHgSNJXNzPk6UsTw3TJLl0tBwftrdifezmjDMqVXHTn7DSebygrXZmTfyCwbMyDF/fmkFQJ67zb8R2zqVXdMhMJ+HGEjavZntIhU73U0XCMir+vy/V0GhAorp94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA1PR04MB10579.eurprd04.prod.outlook.com (2603:10a6:102:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 11:27:09 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 11:27:13 +0000
Message-ID: <282d4379-2094-42ff-8ac1-6327655ca2d5@cherry.de>
Date: Tue, 11 Jun 2024 13:27:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] rockchip: Ensure memory size is available in
 RK3399 SPL
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, huang lin <hl@rock-chips.com>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-8-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240610145920.3302001-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::14) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA1PR04MB10579:EE_
X-MS-Office365-Filtering-Correlation-Id: b00ad2dc-94ec-4084-7e6c-08dc8a0970fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akhxY0lYeVBtY3FFU3RmQnRPQ3ZqbEtQODlIM3lZQjdycEV3WmhkZDAvaUpa?=
 =?utf-8?B?emROODE0SWRmWHBqQnVxNG4rT2N3ZVRSRTRIZnNuQ2d3NStjVHhVcGFlRHJp?=
 =?utf-8?B?aGhMU0h1ejVVUTlTQ05FWXNDVG10T2lrdkM0RXdieVd5VGdIQVBqVXU4L0J5?=
 =?utf-8?B?VzFVVnlRZWExNTBVOUYzWFlwZ1JWOHFWR2pBR1gySW9YY3RNVWV6cFA4YXBN?=
 =?utf-8?B?amV3aERZcWFYYUQ1Nk1LbWRBKzhobGNTcERLSkpIUFFMdVNXYUVrL1ZNUHBT?=
 =?utf-8?B?WVRuZkd3UmtHKzRGMmFQeldUZ3lwd29hMHM1a0RSNmY1U1FqQmlEdytRMHhz?=
 =?utf-8?B?SVlpYjBOVko2eHA1WldlNVFMQTdyL29vR1lhV1lSRUsrQTVhaVhkbjBuVVl4?=
 =?utf-8?B?WnVTbXZwalhMVVNYa1Q5bjdENUczL2piRzBZTldhWE5SOVBybGZjVGhYdTd1?=
 =?utf-8?B?NkhCblB1RDdsY0R2NlJtamNvZU83enVMSGhuZ28vaExxVUppdXRidGV2dFZF?=
 =?utf-8?B?aHMwbkpHY3ZtRWtNSGEwSGRiQ2FLbzcrMHNCWjlCckZodmVONzVNbEdUVldo?=
 =?utf-8?B?WDJpcWNralFHT3hTbVhTc0RHalFVcWd0MVlJczJmVzAwbVp4UWdPb3FHRkYx?=
 =?utf-8?B?cU05MG1LZ1BRSmtHeVBVcXkvR1JZalEza2l4RlAwY0dVTVk3KzNUNmNKczU2?=
 =?utf-8?B?b0FyUXl2QmFiOVUzNUVHQWJUREJXUVpLNFg2OWwwVUZQRGVkOW41K1N6Q2NY?=
 =?utf-8?B?UjdKUnQ2eUNRMEZUQ3JnMitTbkptUVRpN1Y1S1dWSTBKaHVrbEhsUHhZK3Fl?=
 =?utf-8?B?b1kxZnJKODBzdTluSHlGSHdQSE1UazUzSENNOE1hUFJNYUtGMWJ6ajhSL01q?=
 =?utf-8?B?OEI1TGdlcStyRVZGYTJqc2ZyTjVKVERVbFBjMlRVOWdLZSt1MWRHQ2NlVkZi?=
 =?utf-8?B?OVVkamU2MFFRNUVqZ1pOM0dSQTc1TEtSQmx4YUJ3MC9RNTlPQVlPU1hwbGxq?=
 =?utf-8?B?Y1ZFeVRwc2VicFU0TzJGOENSUk5Lc2xGZVJlOUZRck9Bcm52Y3A2WCtPMGhv?=
 =?utf-8?B?UXdubm1PTzJMRnk1UkJhSzRnRDBJdmlmYW9aVlVBWFlkK0VNbWtCeXRYMGdK?=
 =?utf-8?B?eGtoVUFUcXFJMXp0cTNBQlNDcURqWHhmVDVqT1N2RWU3NjFkeUYzckFocnAr?=
 =?utf-8?B?Y0xQUWk3Vk1sQnAxTGEyTStnSmJCd1p0TitUSzlBTTdrY3JlUDl6c1p4QVpB?=
 =?utf-8?B?ckFFbmFndlJqeXVNa2xtZFluUkFKVmowd0JEdk9CN043cGYwR25UQ3RJRENH?=
 =?utf-8?B?UkVDZ0N3UUFpUVNQMFllRFMyTUJvSmJjL0NBaVZQenkva0NNQUlHWUJzSkRN?=
 =?utf-8?B?SmJJQzM5d2FBM2pGUjIzL2J1RWtzUGZTNXdKM3cwRmNyalA5SldhNG1EWDdN?=
 =?utf-8?B?anFRVmxQY1RNa01wTU11ZEF4OURWdUhwSmg4ZGF3UHBVcHQ3L3l4SjhZU1kr?=
 =?utf-8?B?d2xsOGN6T3gzVkVrT256V1dhSWFqYk5xWVIwbFFneng3MUNDVEhUQUUrcCtH?=
 =?utf-8?B?cDJWcHdvdjhucG1EMTJsNExJNW51eVFmZXNpSFRVK2tNVmNZM2ZrM0o3VGNO?=
 =?utf-8?B?U2V6N09GTFdocTNaZU10c2tyODhOYno1aHEvcTBpVllUenJwN0MrdHA3WUJn?=
 =?utf-8?B?dUhvbFZUSWVuaHhEemNHbGY4NFNydTE5Q0ZXc2pNcC9aS3JuazFNQWNFd0tO?=
 =?utf-8?Q?1tyV4tvGuJBhw/d5glZL/YxUEt4q1HYiQl7LuG4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pYbE5FbE9BbWw1Q0IrcjM4TkcxZ1gwRnpBd3ZhZFdaSzFFdjlHdmNVdmk1?=
 =?utf-8?B?MlZTL1FjbmVWZnZlZkE0ME9DZ0h4NXNnZWQ4NTczZ29TQUMyWGhhZk9EY1lK?=
 =?utf-8?B?a2huSElKc1FHaVJ1WG9GN2Z3YXFVSWRvVGphY3lyUzN3UXdoNkNWZ0tuc1JF?=
 =?utf-8?B?L0lEQ1ZxSm9LVXByNXlKdDIwVVp0bUovbEV3QWFic2swTDVKcFJCbTYrNnhL?=
 =?utf-8?B?ODBoSVJieW51VCttZE5VWTlTc2RPYkszd09uVWRLdmYrQzZKVTFLSTYxbUpB?=
 =?utf-8?B?VlV5TTQ1aXpObFBlQ3U4UXduUGRsemtINTZsV0dKcGRydUUzUnhMT200L1Nw?=
 =?utf-8?B?dFl6S3dhdDFDU3RwcndlL0p4Wkk3a3ZkNlZKKy9iSFZPT0FFNDdpSWhMNEFs?=
 =?utf-8?B?WVpxS3hsVGk1dGFkVXgvekVVRlk4cy9SMEFaQng2OXM4TVRhdHErdTlWTUNR?=
 =?utf-8?B?NmZrT2JEQVVvWVVlWFlaRytUVnhoV2JFbnhWYXRnUjRBOWxyZGprblpUdldN?=
 =?utf-8?B?bFkxaDdtTk5WT2NIRkZQbnJ3VGNmR2lGQkRENWlGSElxeG5KbW9PUG8xNlBX?=
 =?utf-8?B?SjhvTWYvTVhhNzcvS2JJU0trNWdWenFtZDJ0YW1XK3NJRHBhaTNmYkxXaTFF?=
 =?utf-8?B?ODBCVTFjYlhEN0tEWjZFQm1nY2dFd2x5blliZDRVb2pENXAyZlRoc2sxTTFw?=
 =?utf-8?B?NWVPcmdoaCtKU2ppU0s3NmhEYjZNb3lpWG1MbFpaUmZrZEhkL2thQ2J5L3dz?=
 =?utf-8?B?ajY5NnByWlEvaDRWWDhNbjFZdEdyNTUxcjI5elZlamlZK0N6UDV3SnMwZjlV?=
 =?utf-8?B?cUdhQXhVVzAzWVhDbXNMMUZQZjJRMnlRVzRzMnN1NEFsTFZJcDdYV1dyNW95?=
 =?utf-8?B?N1dNY3R2VGl2d0Z1eGFKVDd2dmJEcmRsQ1d4RTkwaGlrclhuNHROTmxLR0xS?=
 =?utf-8?B?cVhzWWhhTzNRSWtLSDZmWnZWVXI5TS9WRHNZN255N1p2Rmp4ZVo5emMxeG9i?=
 =?utf-8?B?VC8rS1hvQ2IxaUFDVng2bDNFaTIzYlM1MlNzZGZnQ1psais3ZkFvcEtTdnN4?=
 =?utf-8?B?cnVqTVorV0JNelBQdDhaQnJacVRCb2xaWlhlTEVrWnpkQnJrU2dEbFpDZjVL?=
 =?utf-8?B?aS94NmMrd2o0N0tOVmxqbFRvNU5CM0lMeDdVQnc4MUdlTjFzY2dGdjdJRVpR?=
 =?utf-8?B?Nlg4aVhzRlFtZElIZk5seHlpZ2VMWGpSOHJmVytYYm8wT2VraEZCTU1pTTRZ?=
 =?utf-8?B?YXJWMkVIR05WMVZ6dGxzT0lPVEFiMzJ1UkVDUkdnenJnd0tIV0sxZ1VHZ2l2?=
 =?utf-8?B?cnN6bTdKWExCWEFMT0JURDZvazJORlloMk5LRTk5S3FWeDd6V0wvdVdUYWxq?=
 =?utf-8?B?UTVXQ1p6eTlHNlRzWFZURHRMYm0yWWZsRWlRTDJGd3kzVHNVTWdQaEVTU1hE?=
 =?utf-8?B?YkJIQVMxdExIbnJlVXVsU1h1V3NtK1NFZUNOTlB6OU1ncko3SVhJWVFjamVQ?=
 =?utf-8?B?Yzd4RHVFRXBJSCtoYjJVNGJFNE5ObnZQT3RjNmZYYXBYbnh1NmdWQ1EraVI5?=
 =?utf-8?B?T0ZIdUJoLzZUV04yUUt3MUFreWxaQ2hXWE1jM0J1N0pXQkdmcWRIVk1ZWXU1?=
 =?utf-8?B?QWVDMWgvY1RPWnJ5c0lpQUYybFp1WEUvOW12SFBNZm41OU9wS2ViUG5VeVNn?=
 =?utf-8?B?eFVXQUViSG9KcDhMN0NSd3pZSkZCbUo3OGhTN0NyTitQUnBEYXFDeHRKWnp3?=
 =?utf-8?B?RHBYRGd4UmdHNk1lelR3Q3l6Wkh3RVZBSFhPSWJsanlBTENDZDhSdHdwRXI4?=
 =?utf-8?B?UXBHS09VaTRiTVpGL2l4WkRtOGRWZU9QZWRqQXE5clJjV2kwUnhwY1VTdGQ5?=
 =?utf-8?B?QTdBT0lCWmtvZmlkNG5KWFEwRzVZQVU5M3VNQ2NTTXRGa1RkSk10TTcrQk9i?=
 =?utf-8?B?MjR6Tm45ZFdTYm9sRHhBYmNEbEhMVlUvdFJaVndsNW1GVmlBdnFHYWI0RHMy?=
 =?utf-8?B?ZXFPdVBHc0pDNEQyNVZpOWtWOXVYYUlWdks5MzEvTWtRWW5XcHVTU0FXQlYy?=
 =?utf-8?B?TWFJQ2JybVhPS2hnT2daSGZVWG1YWU1tcjQzVlVyckYvbWJsYTdGWjRMYnJ0?=
 =?utf-8?B?QmNWK290VmJ6YUJkNUo1VURzVlFUNmV0KytvUHBud3ZhWVRJN2gybFk2SUlJ?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b00ad2dc-94ec-4084-7e6c-08dc8a0970fa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:27:13.6730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiLbYd7yKL+Xg0EZsgVY0BK9/TzIk54ryaHDVnE/s4c+zi/LAFqTJOLaqtnomywEy9RYh48wT/Y8Z/6Tr59bSJnrNdsQmcUBo41ndWbNp/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10579
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

On 6/10/24 4:59 PM, Simon Glass wrote:
> At present gd->ram_size is 0 in SPL, meaning that it is not possible to
> enable the cache. Correct this by always populating the RAM size
> correctly.
> 
> Part of the confusion here comes from the large blocks of code which
> are #ifdefed out. Add a function phase_sdram_init() which returns
> whether SDRAM init should happen in the current phase, using that as
> needed to control the code flow.
> 
> This increases code size by about 500 bytes in SPL when the cache is on,
> since it must call the rather large rockchip_sdram_size() function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Add new patch to correct memory size in SPL
> 
>   drivers/ram/rockchip/sdram_rk3399.c | 49 ++++++++++++++++-------------
>   1 file changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index 02cc4a38cf0..2f37dd712e7 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -13,6 +13,7 @@
>   #include <log.h>
>   #include <ram.h>
>   #include <regmap.h>
> +#include <spl.h>
>   #include <syscon.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/cru.h>
> @@ -63,8 +64,6 @@ struct chan_info {
>   };
>   
>   struct dram_info {
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>   	u32 pwrup_srefresh_exit[2];
>   	struct chan_info chan[2];
>   	struct clk ddr_clk;
> @@ -75,7 +74,6 @@ struct dram_info {
>   	struct rk3399_pmusgrf_regs *pmusgrf;
>   	struct rk3399_ddr_cic_regs *cic;
>   	const struct sdram_rk3399_ops *ops;
> -#endif
>   	struct ram_info info;
>   	struct rk3399_pmugrf_regs *pmugrf;
>   };
> @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
>   					struct rk3399_sdram_params *params);
>   };
>   
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> -
>   struct rockchip_dmc_plat {
>   #if CONFIG_IS_ENABLED(OF_PLATDATA)
>   	struct dtd_rockchip_rk3399_dmc dtplat;
> @@ -191,6 +186,17 @@ struct io_setting {
>   	},
>   };
>   
> +/**
> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> + *
> + * Returns: true to do SDRAM init in this phase, false to not
> + */
> +static bool phase_sdram_init(void)
> +{
> +	return spl_phase() == PHASE_TPL ||
> +	    (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
> +}
> +
>   static struct io_setting *
>   lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
>   {
> @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
>   	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
>   	int ret;
>   
> -	if (!CONFIG_IS_ENABLED(OF_REAL))
> +	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
>   		return 0;
>   
>   	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
> @@ -3138,23 +3144,25 @@ static int rk3399_dmc_init(struct udevice *dev)
>   
>   	return 0;
>   }
> -#endif
>   
>   static int rk3399_dmc_probe(struct udevice *dev)
>   {
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> -	if (rk3399_dmc_init(dev))
> -		return 0;
> -#else
>   	struct dram_info *priv = dev_get_priv(dev);
>   
> -	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> -	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> -	priv->info.base = CFG_SYS_SDRAM_BASE;
> -	priv->info.size =
> -		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> -#endif
> +	if (phase_sdram_init()) {
> +		if (rk3399_dmc_init(dev))
> +			return 0;
> +	} else {
> +		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> +		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> +	}
> +
> +	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
> +		priv->info.base = CFG_SYS_SDRAM_BASE;
> +		priv->info.size =
> +			rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
> +	}
> +

Isn't the whole change summarized to making sure that priv->info.base 
and priv->info.size are set when DCACHE is enabled AND we're in the 
first stage BL (TPL or SPL if no TPL)?

i.e., shouldn't the following code be enough:

"""
static int rk3399_dmc_probe(struct udevice *dev)
{
#if defined(CONFIG_TPL_BUILD) || \
	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
	if (rk3399_dmc_init(dev))
		return 0;
#else
	struct dram_info *priv = dev_get_priv(dev);

	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
#endif
	priv->info.base = CFG_SYS_SDRAM_BASE;
	priv->info.size =
		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);

	return 0;
}
"""
?

Then what's after the endif could be guarded by if 
(!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) { if we need to but it's not clear 
to me why that is needed?

Basically, I'm not sure the migration from ifdefs to the 
phase_sdram_init() function is necessary. I'm not against it, but it 
makes the whole thing much harder to read and hides the actual changes.

Additionally, why was the cast to phys_addr_t changed to a ulong? The 
function actually expects a phys_addr_t.

Finally, can you please explain why gd->ram_size being 0 is an issue for 
the caches, where is this checked? I'm not too familiar with the caches 
in general :)

Cheers,
Quentin
