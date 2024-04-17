Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C86C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76758842A;
	Wed, 17 Apr 2024 14:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ZvgquBoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B518845E; Wed, 17 Apr 2024 14:54:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B4887E75
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 14:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEmUvml2Sk9OTv6ICjiSeX7hDTbfBYYqEQ2jq7G8QtUVKyuTdvpjpFKsQbuEVeJKz0yjwdx8T8/Sk9sfZsjX3R08zO/YKAahuxbJc4d+3rpgYPNmYUBAf1Q6pg11/F+XRoYpg1nUigIGAkEvNrzRcw4FeGdKbo3Y2JQW4/0b0T+v3jR7ytEETLFaeSaEd7UZkccF0N9kxLqI2Zu4t09lEp8BddbcrrO08n7qpqK5cPoo38WJDOI53o1ZKL2sU0WyiU3sd4xpC4HjlCevnku+0ACfgKajVR/xxD66dydqUGfSLRSoIbeDNJ2z2x9NDAHVmoKQ0dwF6sLBuMMPObC+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP5RHPc41rrYpFPvaS/qlU/844khSNKApM/FJbYRg9k=;
 b=HUuz/yzGDtX4G1FcFa9SOfc4djps6arrXyANEqbxVs4Ll04mSQ6PelMjEkDdmTBcBDnaCalYJSQ7fDswv3sZA6sfwx5PryfZB12o0RYERW9hRwjJeaP93jVeRHasAcq+0HcsTR+a+77dTQKjd3icRdoMPrif4uCy+RNZyosMUiPsyCHPyzfWN6FukAFE93F7/Av7ZlzjeKgg/17/rYbgk13/AxfdgjdyuFq8NrJ4ov/Sa/w7HoGtGvZwqr5J6G75fsRhNa1fv8a/N5KM1paHOIA/TkXTsoKN6QgUOI5aqiqRK/GBmccz5he00RKelHCa7YZ80hjIYTjoDtiRodOCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP5RHPc41rrYpFPvaS/qlU/844khSNKApM/FJbYRg9k=;
 b=ZvgquBoEUxYYWXqxaweK/C9f661/8Wap8r353U2bSKURVLSEsGAcFtY5oG5iCsHST5u5fLRg+M9V6rWk1G41d+7dH0r5PGmWba+EH7IGmSnApCZ/sBaMRGq3mAhyvYgCll5sEwRt51RcXIxc1O3BEjQtEbfADjUskl1vhAI33aWcaCC0THC4Gxy9Y6Tlvd0spuB9Zae/DyR+2tCertLQsEu17qVDgiMbatdBEs/7a0TIeqGl79/u3Fn+30eeuOVQAWgP7m2UlyPcm5izOq9YjJclowmouNrc+CYzlc4H+GRoKzcTBPuuFS7ByAocI67Xgm7g/XppzLtVWGPIicPlww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AS8PR04MB7751.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 12:54:17 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 12:54:17 +0000
Message-ID: <25989cba-846f-464b-b752-908b8e16c4eb@theobroma-systems.com>
Date: Wed, 17 Apr 2024 14:54:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30-board-tpl: Sync ifdef guards with full
 TPL
To: lukasz.czechowski@thaumatec.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com
References: <20240417112128.288531-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240417112128.288531-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AS8PR04MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b63529-e987-4c2d-9284-08dc5edd7dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIYXD2YjKs409Spd/YOFWy1UNBQ3YPfWc4QB7GXJPtz4yZa06GhdKuk8Rnyy10v+JsBeLM5WBzR5zwdOuxEcM4AH+JA9T/rK3xcFGPW1A7uYs+aV57i08WSNzKgwmVTHpkVDsd9ngwDDDHfZ6Sw1vP7qY/CeW77yTktRCg0tuJBnXU5l2qGzW20GnOc7oshYFUL1SMWa8bCEn7S4VP6papWkdd24VRzbpfQiI9/4du7ln64vi2+dlUpzOLhxk5+Cv5Pg/wWEs7/vexmYEapI8FIp4pJbbIpQSVmdZfPdxSXHOnDkyzZy60hWsHFn7VctzP3pne6wCKDWKZG2gmymE+0mQAz8ZRGBUyGOUqTaSSUlS557rzqFimRfWIlSTnYyEW0eUVq59NxqLhyPsc57hmr5nv2sVXpnnHS1HugOJvoqIKaP8p2wpY+kNo6XPqwuWFgIbM97Kw6+GrPA1p0SObw3uCbukN+dpnKootcQGB/2plm7d5+Nv52fJH6QiKk/DuvVSNUC4UUPY9mx2X47GJybbg0QTUU0iWe62DYAXjOor3fbLoO3Bhbk1VQ1KYurNGgN8rlEpOvzjqFoQjkkj7gf0vOs1qeVklYhtdkHJz2UeE/YHxKop9XZpFn0Bq8JI69Rp5coLuuq9OFXfZDQRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9jbWRSbHhNU3ZvZTdmOWJxeUExelVzN3VSTmFRSGdjQ1o4TnVnbDhDbmh6?=
 =?utf-8?B?Vks2OVY1dERQVFZMQ01yMnFDNnpKMlVzNVVCVEFqbGphVTF1NzFYSEsvd0xT?=
 =?utf-8?B?WTNtYmhkejlaUjNZclBYbm5salZPMXlRWlJieXlLVEI3Rm45TlZOb0EwN1dk?=
 =?utf-8?B?MVA1VzU0K1grSTBRTXllaUxJdlpZNzFIVm9JdldGM2s5MFU5Nmt1ajVTcXRs?=
 =?utf-8?B?TmRWaVpqWTJXR0VzUk4vTSt6dHJrUmkxYkx1N2MxYi8zcVJMOEZHTmZYOFRz?=
 =?utf-8?B?WFhlbmUxVm1aWXROV09FNmJOam5QSGZSNEEwWmZJNnNLbXVwNzNjN2hqQjhT?=
 =?utf-8?B?N3VXUFJTdlNwaVFlSTNvcWxRLzF3T3lxQmVJcEZYR1ZLZnIyNXMrZ21pVW0z?=
 =?utf-8?B?VXozd0d2K2dYSENpQnVzSnVjSHZhVFVSYWo1ZVliaThOd1haK3h5Y0l5aG40?=
 =?utf-8?B?UDBoTjRXUkZBc3VWN3hlTUpwcVQwWnl2cTY1dG5ocmhBajhVMTB4QVY5aGFr?=
 =?utf-8?B?eklGWVpQUExUWVEwUlRVUHNhbzNMa1FqVllpcEZ1RWJtOTNLLzg2NGNRT3U2?=
 =?utf-8?B?bmtBNEdueDJaTStSckx4cDdjaWdwOHZ2eDkzakdDMnNqbVpvZ0h6a0V2bERu?=
 =?utf-8?B?Ty9XTGNLN2w3T3BDeWlRaDlJbHpOZjg4bjJaNVBSR0lYblNXaFJWZ0U1bGpp?=
 =?utf-8?B?Y2NCb3c2MmhoUGdUL1hSeG9panFrTS9kbTZmdFkwdnQxZ1k3RE9vMGJTNWpP?=
 =?utf-8?B?clVSVVZLaE42NEZyWnRDL0ZqZVI5Z2ZCMjlTUXRuWTVmaG1vbFB0VEJGZUFX?=
 =?utf-8?B?YlJ3SXl3bDNROXlrMmVEaTZVdk5UL2E0aDcybGMwblNlMlBjQlN0Z3lWcmhH?=
 =?utf-8?B?ZTEwdjdjcFFaNDZ0Uk8rT0h3R09YTlJpL1pJY2RacXJKY0JIVWhtUGNqNHZa?=
 =?utf-8?B?aERkRVVlaWw1OFdVNDh2WXJrRjZyVEJmWmw0QWF6SFZSSUtTWktFc0p4WW51?=
 =?utf-8?B?cU4zU1RtRDJqTHJzVkNyay80c3BocytiY05zVjhhZDFIc2pMTlovaWJoVXNp?=
 =?utf-8?B?T2VrNEdaSjNpZjhlTzFKRFRSQ0Z6bXlLdEYwaU5lcWg5emY1OVhqWUhyUVVp?=
 =?utf-8?B?bUNLOVZiOC9ibkE2ekRNNGsrVHVyQUZ3RElDL3dVaEgrT2dvOEpUVXZLbzJL?=
 =?utf-8?B?TGJKWFZFYThFL3NON2laS1U2OGlnMjY0VGhIUnNWQjZ1SWdEOHRxekM0UDNi?=
 =?utf-8?B?M3JnM1g5ZmtmMC8vaTR5dlJPc0d2dVN3L05BZVZDZEtESGltWG56VE5nbWx6?=
 =?utf-8?B?MnZja2VGVDR5K3lIR3dmU1dVT2gxY0VnUXV0S1h6OFFJNlk0V2hHYVBQOEdq?=
 =?utf-8?B?ZFRoR08raFdPTHk3SmdPNWVzZmFEYzFQcFF2U3Z1UTQwQXp4c3BTV1BFZkJR?=
 =?utf-8?B?YTk3eE5EN1ZrYXFMQTZyajF2ZHFrenpwZ2o2dWJQbWxENllMNGZ4dDV5ajBK?=
 =?utf-8?B?eXoxRmVEWEx1Y0RoRTA5bkd3UmRWMlg2dkhHdTVrMExlYWdyRXFINlhJcThW?=
 =?utf-8?B?NmcvOUpaOUpQSWNmWjJrWktReVZjdlJHZWkvT2pMalRKSkUybmc5d2U4VHpV?=
 =?utf-8?B?dWgvZ21JeHNDbjEwdHJKbmJ4dFlaOVZ4N0p3YUZXdktCUXVQK28ySGxXS1hr?=
 =?utf-8?B?ZDAwR2NvUklPbHVhWW5pZ0hlclZDeGNHODdzWGpWMUw0TERMYnh2a1FTMnFh?=
 =?utf-8?B?ZnpmV0d3alJiNUtNQWFNSnBZRU9abkM4MWZtd0xxRkdFNEx1Nlp3aXNGc29N?=
 =?utf-8?B?aVpQM3gxM2MyQ0g4eUY5VGs5SmhMVTgyREdBMjNNaVlHK1IybFJsWnVlZ3dw?=
 =?utf-8?B?SmNRZHFtQ0NTMGZvTHJlMDBtbk9KNHlsMlpPcFBTS3EyR2NrRlozUjNGMlU1?=
 =?utf-8?B?aUN0M3V3MWF5U0JRWW9FcVg1SElPYU1UTFd3bXA1MUU3cUlxNmhxbCttY1NW?=
 =?utf-8?B?bVVvVWZ1Z0NkT0hDa1dWV2pWLytVOXZ4MExaaEZrNUU1NkNheEgzYlJxWEkr?=
 =?utf-8?B?eG1IRm5ZZ2p6QnBsVDJhVEtrYW9UcmhHeTBhN2g2ZW5ENkVSUzV5dHNKMVlR?=
 =?utf-8?B?RXlWRVFkVDZwSlpQa01RUnVVVlJvUDVFSmd4Vi9tRGJVb1g0ZTV2bnNFQVN4?=
 =?utf-8?B?dnZVRk9PTzZBSVdNUThqTjZSbHF2QUdoZzVnZjJSSDhGaDBGb2dpVGlCbGMy?=
 =?utf-8?B?QWFKb3VlaDhPeEZJZU1MNE9BcDZBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b63529-e987-4c2d-9284-08dc5edd7dda
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:54:17.5172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syV4svOnmTqyDpN3hPIjUMaOMRZaydBkg8+1nLh2PtzXKuEvXhJ6zkfClz6UEm9L7qgXzSMH7iizm/UEpiQdjCtzl1oaJrtWFbr7+dh5z9EH3Y8O3G572kcj7WQVLdOy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7751
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

Hi Lukasz,

On 4/17/24 13:21, lukasz.czechowski@thaumatec.com wrote:
> From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> 
> Display TPL init information message only when TPL_BANNER_PRINT
> configuration entry is set. This allows to disable information
> message in case logs on UART are unwanted.
> Update parent ifdef condition to check also CONFIG_TPL_SERIAL
> to match logic of the non-PX30 TPL implementation.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> 

When someone gives a tag (Acked-by, Reviewed-by, Tested-by, ...) on a 
version and you send a new one, it's best to include this in the commit 
log now (above your Signed-off-by if I remember correctly) if and only 
if the content only changed a bit (like no big logic change or rewrite). 
So here, my Reviewed-by would have been nice since I gave it in the v2 
:) (please do not send a v4 for this :) )

b4 does this with `b4 trailers -u` automatically by the way :)

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
