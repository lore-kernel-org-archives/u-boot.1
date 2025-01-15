Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0CDC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 17:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A62D88033D;
	Wed, 15 Jan 2025 18:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ct/fahJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC50C80657; Wed, 15 Jan 2025 18:49:50 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A857380214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 18:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hioxNX5Bh2SGBI863zrJSlSMG4rpQ0I9XfW0lWvPHWOrXKHPbSjYaHQKGZjhM8glC7yF/9ey41MS0clfU6LbR9wu02Tpjw6rnP9ubUZDUZQSrM+CLlQuyPzFkgKE45Sro5up1Aje5kQeHvCD66caofaGtY2aViyzlW5dB93+1z0CepGGdqwi4CHuw4oOc/uJUX4XGKGTCEfkDjjLKjyFqbQOcVJ40wQtbiLLF/xsZtyiF1fzIDUzVz68N93DbuPyGacWrnkhzGlgUa+12Cr7N7YfBNjDnYgo6XGIQbZKc/guSAWkz6iMNmpwADoo/6+5kRSgWrmXRiTYIrhMG83d3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWOugP4KBA9odji4WlC/oPnTWL+46s+6tMEfxY5lIKE=;
 b=Ex4mtbr13+SiWtfeHdLC3NSrYXAdpXcGfRjd3zTV5zZKNHvUF0b60BIz1HvRh5pQlF0ptW9LX+n0ap9KGid+mTbqJb4uAHbJY8lBYQOuZFZeX0rbPuFlJnD5wrXFX/72et9OmxCMBzE3ZCIB8uxw5fE2S7oEyVtzZ4YGsDIaS+PjdF7xOaLNdsUq9iffLcwB7G6jiWoplzczybrygFQ22D+0Kqy1vcdsHM2MPrY7xlSQYL0yLpamh2NsoooSBqX5kaZKPmEvTdk/XfsWiuQqiij6xIRpUcAKqcW2VvFyQvewqrVIsH6HyGbLTIkpcIwQHp5+CLuTo/NOeq2f9efggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWOugP4KBA9odji4WlC/oPnTWL+46s+6tMEfxY5lIKE=;
 b=ct/fahJllcwWDgS3E/E7YYHvRpSph28AUhvCahmr/cXb94PympCPzniEt5Xtsgm/VV9LeoymXZy91ftCNhyY9k9rvdzkCtP4Q2cYgKiiPY8XC/k/yED6qRJ/Omi6eIFuiyQlKb1WS0QaAGfRpEMtR3PX5akNZVsc1wVgkfBZ5HI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU7PR04MB11187.eurprd04.prod.outlook.com (2603:10a6:10:5b4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 17:49:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 17:49:46 +0000
Message-ID: <4cb564bb-8c0d-43bf-bd91-04668a1deab2@cherry.de>
Date: Wed, 15 Jan 2025 18:49:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] block: Remove "select BLK" from non-block drivers
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-7-trini@konsulko.com>
 <2b3e1050-7cbe-4dde-a298-5efb63cb4ebd@cherry.de>
 <20250114165914.GN3476@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250114165914.GN3476@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0148.eurprd07.prod.outlook.com
 (2603:10a6:802:16::35) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU7PR04MB11187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab83fb8-df52-4920-e77c-08dd358d002b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjJZbXZJS2wreVZBbng4a2d4OHVMUkdnN0Y5K0pBaHNNZGY4djNaT0RpQ1N6?=
 =?utf-8?B?eEhraSttbE9LSTJNMUZzaGJpZ1VBcDBLM00rSjgwT3phckNUZFgrSFZsMGhS?=
 =?utf-8?B?NkFEeWNMb0swTjRHaTFxTER4MlVVSFhZeWRvS2dnY1VueVV4cjVlREFScDBw?=
 =?utf-8?B?bnBRZ2cyanpvbVhyZkRPY2w4WlRha2pWWWVsaEg1Nm1YaTlwNDUrNk5VakU4?=
 =?utf-8?B?R3N2Rk9CNG1ZZFlrRHpxKytDQ3lZcmF1WGlqYVZxYmlrMnFXdFRzRGNJVVpK?=
 =?utf-8?B?S2xqZWsxRUxJVllkT01aL2svVDZmb3haTHIzemRQamhwdURldlFvZ2p4NExE?=
 =?utf-8?B?TFhUS2lPN2pyNXNVQ0N6ZGkxakVCWjdWKzlXQjZmQnFiQmRmMlNUUkExYzZV?=
 =?utf-8?B?Z3QrZDh2ODYyZWVLVDZwbS9WY3MyNjRTZjBBbWdYSHFqb3RRRzF4UndJNWZK?=
 =?utf-8?B?UUJORU4rcG1aaGxSNWtTT29jTXlBellxTWNWWm1jRHJ3emVJODBIZGxUODI0?=
 =?utf-8?B?WmVxUHVHV1JCRmF3UERncE9naHdMVGw1aEpqaXpsaWpHZWh6NjI4NzZEbFA1?=
 =?utf-8?B?dk1wYzFFYVJTcExZYkJiOVlHamFjZE1iMTJJdXN6eTIvTTZkcDRodER6bEhJ?=
 =?utf-8?B?UXFTR29WcjhoR2doL0FESjIzd0lPY05vcmRZcGZiTVJiaDdaTjJVOXM5K1Z1?=
 =?utf-8?B?cFNpYm5wSGoxS2VCZXhaRm95ZUZoMDFDL2kxangrTHA3MnczZ3hhbitHWHdM?=
 =?utf-8?B?ODR6N2NZOXNkWTMxd0UvZlArcDVIRjVicm5pd1cwOEZIOGFYbUVpWjlwVXlK?=
 =?utf-8?B?V01nZnl1OUtQYkZyazhzNTFZVERIVkFSWkdaM0k3amdMYXlWaXMzUVErdWJX?=
 =?utf-8?B?NzVsV2NVSjUrOG5hOUp1dmMrOFM2SkZPUGd3czhybkQyTGY1dy9UcERLN29r?=
 =?utf-8?B?dW9ZQ2ROUktXQVlHbXo2K1R5RHl6SXhFa1NodWhLYjQ4N0FTZ3lMVlIyMzhT?=
 =?utf-8?B?OXZPeGQvaEVxMVZDZUhPbS9mdDdqcG5wd3k0b0RIeWhGNlJWdzYrSzRIY0Rq?=
 =?utf-8?B?RmdhM3dUOFBIbE5qM3lEY2FqSnpVejBzS0c5MG9qT2ZodUlVTmVEOXFBejBI?=
 =?utf-8?B?S0RyMGVZbWNMb1BYTDNCeUV3d3lNbktZc2ZWMUVIQ1pINkI4NzN6Uk0xMXox?=
 =?utf-8?B?OFVSNEoxVXU0M083Sjc2SFgyajRLVnRyUHVhQmR0WHk1REkvNXBkaHlzSEtO?=
 =?utf-8?B?Q2dqNHpCaTZadDUwSkcwM2ppZTZ6Z3QxTXM3MHdoa3lnQTZRd1VQS01OMFBr?=
 =?utf-8?B?enN5VnJCREdpZ2lwcHh3N1o4anhRK0VPV0dRNjVoWHJMcXFRVEZUMDB6VE56?=
 =?utf-8?B?NUQyUWp1V3E2d3RHR1hISmxpcUczTWx4eWVQVDdBQ3k0Y1ZHbUVJOTZQTkd5?=
 =?utf-8?B?RmtWYjlTRlM3ZS9tSjEwT0FwUTk2TUR4MmxPL01oUzczZklOZ2hjeUliRzJn?=
 =?utf-8?B?aFVxMjd1N3NCektzMlMyVzA2a2ZIb3R2NUp4Mzdmc2pvSjZXUmpGeUdhV1hP?=
 =?utf-8?B?Y05LMnRIOXBRRHFOK2J5M1hZT2p4Zmp1Y05wMnJ1TXFtY0JNSUJJTVBtZ1pG?=
 =?utf-8?B?S1BoclJwU1NMODhFR0hMQ1Z6K1duVElVTkZLUnpwL0hmNnNXMGpZTlJCOU1P?=
 =?utf-8?B?ZHpkMFB0NEkzQUxRMjRKL3JyUWpzeVBBcnRoQldmTy9mR0N2SWJDYVZDSzh4?=
 =?utf-8?B?dDk0d1FQaU41bUQ2cTB2YkxjTmFkb3REbit0RHQ4ZklUa0hnQXY0MitCb2Z1?=
 =?utf-8?B?WTlFYXlNbGxFQ1RCLy9McmhuaGRZZzVyaXBRNlBFaG9TNEJxbS9xUTlYbjVy?=
 =?utf-8?Q?UKPH7uk/nJoPw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZnRDRXaXZZT0dwUm5NYW9iODkyRlg2Syt6cWJCTHhEa2ZmRDRaMGpiQWF3?=
 =?utf-8?B?cnVLV3JuM0tab0h1bGFOS2FZTzVtd0hJM28xS3IzN0hOWEVxOWFvZFFtamVh?=
 =?utf-8?B?bkdKN3hCTUErcDloajY2dmhnZ0tVRHJNb2FkWHF1eVlMU0MrVlRXazQ4S3pS?=
 =?utf-8?B?UUpQTXNoMVRTZmpNVmRFUStXaVN6ZUlBRnFwTWFWZWxnbHh5RldNTitlekN6?=
 =?utf-8?B?VmljUW96aDZEckNOeXJTdWlaRTZELzZxZm94dDByQmk4OU54WDRjSlpjL0VS?=
 =?utf-8?B?SE53YS91bXB6MnMrT2dyS0x2WUdZME0vYk9IbDNsZkczeEpTbEZlWm9ONURB?=
 =?utf-8?B?bEV2NTRnUVdOcUw1Mk9nVHFmbGFBRzhzdE5DYXBDQ3JSRDJTVnZ3SWxsMUZL?=
 =?utf-8?B?RVBCNGZZRzQrNStwbm5Lb2srbzRDZ1ZaZGFmb3RPUmIyME9BUkhBdktkdk8w?=
 =?utf-8?B?ZXRhTlZvVTF2TWtoekh5RnJvK2VWQWFmUlQzQ1oyM0h6ZnZKVGNwRjZUaGRm?=
 =?utf-8?B?clJkTGloSVZvYmRBYWZtL3EwMnliUVNHZW16dGRUcmh1OGg4OXJBeU81aGpv?=
 =?utf-8?B?SVhLOE8zaDJVTlc4dFRNREtGblpnOW83OWJHbzlHUFVuQW5YdFBORXBwRExZ?=
 =?utf-8?B?T2FqNVlmMzh0MGhqK2lmY25GejVBbHpXN0xkQ1c2VXZWTllGaFhKbGtIeWRQ?=
 =?utf-8?B?ZDVMNStvZndPNUVkbFhUZE5Zd1hXczRBMTY0b1dvMEtBS2dkVk12YzRQRm9F?=
 =?utf-8?B?SUlrOEp1NXlCc21DSXB2b1kzRisyUitqUHJRMlM3NE5qUlpPVEFSWU5vczZs?=
 =?utf-8?B?cmMzdCt2alUvcWk1K2FUdzVWa1c3RUxhdjJMU2NBSHVjU2dRbHV5S1F6MitD?=
 =?utf-8?B?R0dYYWx5SGFzb2Y1N1krV1F3ZjdFSjI5am1mVFY2MlRESG94cE1BODB0eTJs?=
 =?utf-8?B?OXBWNnoyWTZGUkpQS1ArdTVtUHN2SVRrcllvZzhRbmR4NUhRNzMvWDdScWx3?=
 =?utf-8?B?Y0pjTm1LZWl0bldMbjVpSHdSUWtDNllwWWZqM0RucWp4MWpBS2hGNkNmb3lV?=
 =?utf-8?B?b0MrMnVmUzBCZmFMRU9pREwyZHFWaC9YcFFSTGNYRDBRRnVOcFZGbjROQ2xH?=
 =?utf-8?B?SUxvR3VyV3RzOFdqRHBaWkMxQW1iTzVXRW1wMWFYR1o0WEk4aEg2VkUveUpi?=
 =?utf-8?B?Q3crNnhvSFJZeXNvSlB3NE02Z0dZMjhjYzh1MHpMYThmeWhQS2w5MDA1TFQ1?=
 =?utf-8?B?b0oveVYyQlJoZnNKTzIwVmk4UWF0em4xWFR3eWw1dFl6YkdHZm5xUnZQT1lK?=
 =?utf-8?B?UzlBVWZIQUszMjF6VldFbzZ3M1JWdURsUktLMktVcGhZZnFxSyt0S2dqOHpU?=
 =?utf-8?B?UmsxUnhaQXpTcElBUk1lSStDT3hXamM1TTNiNUpFTTJNdHBoY0o4bk0vbEhi?=
 =?utf-8?B?OFg4aU9Da29oYjMxVUk4SlQwQU1vemdxYjAxRkFGUGRLNUN6WGttcU42RDI1?=
 =?utf-8?B?QldOQTRPT3Q0dEJ5S1ZpMlZ4OFg4cDVINjFwK1cyZGpGRkxlV0JhVDU2MTZE?=
 =?utf-8?B?SnIxYXNYdk91TmpDbzB3c3JORENOUHF4ejRIU2p3elZUNXRQS1VnN3BxL1Jv?=
 =?utf-8?B?MEVMRndqVjBndnhTMXhYM2ExK2ZZSEx0QklidmVMTGJ2WXo0RXJCSnRGSWo1?=
 =?utf-8?B?b05xZmhLY2NuSDZ3dE13bWZkZGVoUzlMWlNtT2R4VWE0YlFrbVNuWTJNb0N5?=
 =?utf-8?B?OERBRGh4VnBtYzNmcmt1M1NJeC9IZndscW5zS09NZTR4WDZGdVN6ZlZHUFUv?=
 =?utf-8?B?WVBJRktwc2dwSklQSTdjTGVRc2hRaXF0dUl4TWVRRDlRbWxKNEVaNS9FQ3Qx?=
 =?utf-8?B?TGlNckpQNC9EczBWaHIzS2xRc1VlVlZhbzFxTytheFlTb2lFdHBhVjZKK0ZB?=
 =?utf-8?B?YXF0WVExNzhwTnVNLzZOZTBncFFMQVhMREtBdXViOVlsekJUb1RuUWxBRjVm?=
 =?utf-8?B?V1g5Z2E4K1k4SmRocER2YTBoU2V5V1FpcER3NHJkNDBld2hoQWx0d3BzV0RI?=
 =?utf-8?B?MTM1YkhYMVFsRVNkdzdkL2pEZHVPanFkaFVmMzl0QndPUnVteWk0RiszdUFj?=
 =?utf-8?B?QzE1aGdFVnByZ05ZS3NUeFZ1U0dEU3lOSFBZcHBCNDJYR2pySTYzTWtaaUJF?=
 =?utf-8?Q?m7ffjqVmDgWiozaGP3lD8us=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab83fb8-df52-4920-e77c-08dd358d002b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 17:49:46.6994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsq9pxlcKbrREXbn/6xhMep53lVIARIDbz/LgVRg95xRnJQURW5aGjssLH1RQFkROtRVzNpkh/4UxSGjbaF1FRKGsf9C6Zz78LW3g3S/7JM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11187
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

Hi Tom,

On 1/14/25 5:59 PM, Tom Rini wrote:
> On Tue, Jan 14, 2025 at 02:53:48PM +0100, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 12/20/24 11:22 PM, Tom Rini wrote:
>>> Now that block drivers are all selecting the BLK symbol, there's no need
>>> for other options to be select'ing BLK so that other required
>>> functionality can be enabled. Remove these places.
>>>
>>
>> We have multiple commands depending on the BLK symbol.
> 
> Yes.
> 
>> BOOTSTD also depends on it, but I assume we should be able to network boot
>> without HW block drivers?
> 
> Correct. That's part of the motivation for this series (which I wasn't
> clear enough about on its own). Without something like this series if we
> remove the BLK dependency from BOOTSTD then some other platforms fail to
> build or grow a bunch in size (as BOOTSTD is default y and now it's
> enabled on those platforms).
> 
>> CMD_UFETCH wouldn't be usable without those drivers as well.
>>
>> Should we do something about that by making them not depend on BLK e.g. use
>> CONFIG_IS_ENABLED in the right places? Not sure if all devicess based on
>> those archs have at least one HW block driver enabled. I guess checking if
>> all .config before and after that change are identical would help us figure
>> out if this could introduce a regression?
> 
> There's a few options, depending on what the command is. For CMD_UFETCH
> it's likely that a small restructure would be needed to not try and

My point is that I believe this patch is too hastily removing the select 
BLK because some symbols have "depends on BLK" and by removing the 
select, we make those symbols unselectable. This can cascade if other 
symbols depend on those now unselectable symbols.

Also, removing the select BLK from architecture/target symbols can 
introduce regressions if BLK really is required?

I think a reasonable (albeit cumbersome) solution is to migrate all 
those selects to the impacted defconfigs so that effectively no change 
is made for existing devices. If maintainers want to remove BLK, they 
could then do it later.

This also makes sure that BOOTSTD and CMD_UFETCH (and others) are still 
enabled, since BLK would still be enabled, just from a different 
location. Then another patch series could remove BOOTSTD dependency on 
BLK by adapting the code, same for CMD_UFETCH (and others).

Does this make sense? Am I missing something?

> print block devices while preserving the rest of the formatting. For
> CMD_LSBLK / CMD_CLONE it's an unfortunate short-hand for "some block
> device exists" which is functionally what those commands require.
> 

Yes, we need to keep the depends on BLK for those.

Cheers,
Quentin
