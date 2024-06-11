Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D083EC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5125E886D9;
	Tue, 11 Jun 2024 15:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GxdRH1Su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F2888685; Tue, 11 Jun 2024 15:50:48 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CEC8886BA
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjZNHFjw9t3BsD3TeAe7rFbNwaWg2qL/Aq0/ABuw46oinEqSYrKks3kG5gqWgui4xvtq2LL0h/EXbSqX0S/XqTNoTUO9KR5uWJbJPS6q5AY1yumnNTwIRWZmE51ktfc0N5GRjRFg+dKrwPIU3GKHNcCzY91DbCoApZgT7AFjqVjoEs+Gp0XinH4krn253zvNFEYl6X6d90gq0aTbZAcecPMwkO6jBWIswkKOsSgeO/R0ZQxLMAs86NXU99eWknFBFNtpJ6qgMHXyU2A9+zeiJq9b0kWVdrkSV/Rl+/6eMOAG43oYUPN/5SGqqpfsJcKdrscqsGTpKy3zG6tcfR48Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfXPSC6W1gkk0LsAD7U0Pl3fiBib2v2/wozuvvQJhZ0=;
 b=CfUuKpBiRSsDVmw1zOEoKDxQdQXd3nwN90Ew1cV38tYxb67sTECDHChUhrRGHLO6T1bz5TFFIbtbyIfAxMvuV+Ppwe1pCEQmCFoAlJ2sbewwfABF80T0Da/LIIlTQkdGqGcvBEhmgAMy7tBbArBtj05iCdA5y5+EUUqmfx8hkkdMulIzhwY8sfMBHC0fsNuLupCt0Hd+fQ/nJYmdag6F2G4zmaQcp9kl77gMk2vYbElIL6XRyyAvPoFKo7dyXgipZweG6bIEc+dzI1sbpHEnoDYLlJovfLa/sM8VEhv1yWksZU3FTvIqKDQLI8ImRaMmX87ft2gJkFDji5ECbKPi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfXPSC6W1gkk0LsAD7U0Pl3fiBib2v2/wozuvvQJhZ0=;
 b=GxdRH1SutgWuC6a+LmcsZn8/784AK5EXIBEWeIIuxLibdWIxdA+o0QL1DgsR54ylpecVvV7g++4nWUzYX5Zc6kxfeDvXfBQ3V254NmFwe8vHu4HscA0CWy74dq7ehg1MfoY8ls7wESB63UkItNJXTcaWfVXMjHKrCDdYy5q81hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA4PR04MB9294.eurprd04.prod.outlook.com (2603:10a6:102:2a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 13:50:39 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:50:43 +0000
Message-ID: <d2341be4-3b34-40a7-b65d-fa880fd96769@cherry.de>
Date: Tue, 11 Jun 2024 15:50:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] rockchip: Ensure memory size is available in
 RK3399 SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, huang lin <hl@rock-chips.com>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-8-sjg@chromium.org>
 <282d4379-2094-42ff-8ac1-6327655ca2d5@cherry.de>
 <844b0a8a-471c-4c6b-83f5-3884c8bcb77c@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <844b0a8a-471c-4c6b-83f5-3884c8bcb77c@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA4PR04MB9294:EE_
X-MS-Office365-Filtering-Correlation-Id: 4659c1bf-de20-41c6-093a-08dc8a1d7cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXRLR3lxTTZ2LzhVVzdrazdRZzZvVkRzYmN6OUZhWGRESVo5SkhVeElTUUVy?=
 =?utf-8?B?VTZJb3N5b3NlMnlFU256VjZKdzExSGFNWEtadGJZLzRuaFBodmRRa1dhVVZD?=
 =?utf-8?B?SmNCdzBhLytmZ0VXUHFFeHZha1FMMkUzM3FFUmJ4QWZhd0pCMi9rTldtc1k3?=
 =?utf-8?B?UUtlNVhZRHo5ZjkrWm41VkhqbFlWRis0OU5aNndNdWtyMHhXNFVRWXg4OER4?=
 =?utf-8?B?ZXZPdFN3WU5lV2FWckloRzFJUUlLYVl3d1R4WjF5eGZaallrNjEyR3k3SkJr?=
 =?utf-8?B?OEV5WHBVbCs2SHNHMktWMm5jMy9rTklPVlhZS2hROFJFdWpZMlVuUVNKRTZ2?=
 =?utf-8?B?TFhMRFZWZDFyVDErL0MwTGNyL3QyRW5vM2RqWkh1N0QvQlhyQmJYVjBEQ2xn?=
 =?utf-8?B?cjBUL3Nwa3MxalFaTlQ2c01YQnNOYlFIMHNiYlNqTUxGdlRzWkJYVFVDbkYz?=
 =?utf-8?B?d0lTTDcvL1B0dSsrN1d4YVN6U2NJVzV0U3JFb0NYUFViL1FvQmltWEpSd0ZS?=
 =?utf-8?B?NDloSUxGdE5iQkgzWGlQNXF2MXlkUDk4WFAwWUpXSnRLaFNkTDU3RXBpS0RD?=
 =?utf-8?B?a2dNSVUvT095ZEYrbHVoZnljZWd6YUhjQ2lGUVR0bytxRWlHTllGVXpmNW9F?=
 =?utf-8?B?VkJzZFNGZUhvaThqOGdOSDBTRTQ0WXUxODdWemFVejBVY05odzB5SDgyK29i?=
 =?utf-8?B?ODd2WWNtNkw2OUgxMnJ5Zzh6b1p6VjNhWTNUUC9mS3FtUGxCSjh5dXBld0ZR?=
 =?utf-8?B?SUx4bVZUMUdkQWIwdkN6YU5XWUxIZXIvNXdrSk9ENWJmNnI4TDVodmowbE5z?=
 =?utf-8?B?UTkwNG9Vak9ZcTBhbXZaZ1crZXJCRDFjVGJJcE43RVNRS2VGVU5FTVg3UkxV?=
 =?utf-8?B?TFJxVnBEbncrdHR0emdZWVpIK3JqdXlkNnlKdzIrbHRpM0gyUFFEeGZpYlFh?=
 =?utf-8?B?TFVLN2drNm92YlY3cHVEVll0NHFkazc5UXhYUExaVzdIVWlpNStWSS8rT2Rx?=
 =?utf-8?B?WFUwRXdraEE4Z21sazF6Wjkvck1EQmpaZE1tL2VUU1pRQStkUkZFL2IyRXVM?=
 =?utf-8?B?NWEwQnhjRWpiMjlBSmoweW1zTDNFcCtTeEw3YjEra29EdmFPNkN2aTNEQTRK?=
 =?utf-8?B?dWdoUGV3QmdpeHRSc3NvM0syakJmSmFxY0xOVVVZeTFWMFNFQlhvdE5sSEdY?=
 =?utf-8?B?cTkyTXl5RUF5U3owcVFBQmFacjlKNG14MzIzOHQ1RXEzRmd2UldZSCswMUg4?=
 =?utf-8?B?VDFoOGdhYkhqK0ZFc0FUeG1zL2ZMTFRpVnBYcmJRUEdFNExSYVJRTmdxTUtI?=
 =?utf-8?B?TWJaZzNFTUQ3WCtpQXJycW05RHNPbFNHTjV2aitIM3pxb25UZ2ZpeDRycnlP?=
 =?utf-8?B?bTNvYlRaTHhnV0Qrdk9lOUNZME5LTmpiSGlqcUh4Z1cxZnVYbDlwNFZMdHNZ?=
 =?utf-8?B?NlczVERJYXcveXZoZ0tJL3FpcmJFay96eDZHU3EvRnVqQUdZbGd3aXVkeU0r?=
 =?utf-8?B?SzhheklNZXk0ak9DRVR4cDdENkplUEsrQkxuWnNrUjE5WFRoQXF6UlkwQjlD?=
 =?utf-8?B?M1U2UnlHTzd6ZERLWDZ2SUF4U3VNVUhBYkdkVjFDOEVtREVGQUcrc1NpRzFQ?=
 =?utf-8?B?cHJIRkFpZDM0V1pjancrRnFLeTZkZEM2bXVxVU9rTkZmS0RHMG5IVjlHZkU4?=
 =?utf-8?B?bDg0M01LUE1aVTBvTmVDMEVCdjFnWXRVTzkrMW1kTFIvMkNJSG9RUjVtZFN0?=
 =?utf-8?Q?BGDs48cySxSQCB7oN2rtKA1IQIgNGKTtG9mwYz2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckN3ODRZT0RqLzlLR2FRZUJhWkwvQU10SkRYUEIzaTdadFBZSnBuMThWcVdi?=
 =?utf-8?B?TWpvSC9JZDQ5RmZlNy9lTGVtUnVKRklQT045TURxdTNabHJGRUdkNkh3anFz?=
 =?utf-8?B?UElJZXVtdzlFSDYyZ3haVHZPbitVT2pXbUVLV2xkSTBSV2xIM1ZMRGg2ODN0?=
 =?utf-8?B?N0Ywb1lHSDJzbjhFWStWazFiRWQ5ME0xNXBTL1I4bTA2Wk5RVUZycm5UZ0xj?=
 =?utf-8?B?MmdLOE1BTVJaeXlzOHpYdmcxZkFZaWs4MGxOUm1PYkgrZ05GT2lWdzhHdUZi?=
 =?utf-8?B?akhtQ1I1Qmk4VkxwWHR2WjllamFybXV0L3pkanptOVo5b242L1VWMmEza3ZZ?=
 =?utf-8?B?dGVVUG0veWFtRWphSG04RndOMmVjaGtkZmcxVm9nTVFyQXI0OXQ0YjFTS1BG?=
 =?utf-8?B?dmlJVWtJZkQ1c3VpMjZhYjhxUDBsa1h0WHV2Vnhrd0xTZVJScW01bVpmeWxC?=
 =?utf-8?B?blVKZ2JJOUpjeTZLM2lucFo1UXUva3A0WFQrUjN2d051RHpXU0M4ZWdKYVpG?=
 =?utf-8?B?M1VmTm1iaHI1Q0ZCWWN4ejNEaVFQb1ZmZnljWlFjVXdSZzlqcFBzQ09uMENp?=
 =?utf-8?B?ZmRNYjVYdktHTzVRSC9RdDBEeFhwL2R6bk5MZ3p5U3Y5M2FLVThWeHpwS2t2?=
 =?utf-8?B?aTFOYmEvN1k3bnNSbnl4dDBnVVQzTGdnNmlqaXRIN0NUMVNNMitIcWxLMmR6?=
 =?utf-8?B?cllQblptaEdvZXZtWlg2dkJ0SWNRdTdGeW5Sd29tRTdtdXIxWmJMTXJDc0Jk?=
 =?utf-8?B?dWdwS1YvSllvTkdldElsSFN6cHVJalg4bXRKb0JUNXh4bHZiZ0RMKzRBL2Zn?=
 =?utf-8?B?QUlZRDB3U1QzT1ZyU0pCVmx1UFZVbmJUUWxaYmZtY1BOZUtxb3pPNENCWDgz?=
 =?utf-8?B?OE9kWGpNcjF3alBraTMvNy9PWVhRajNkNXVSMTFYSVJXamtORjBwbnhaR05P?=
 =?utf-8?B?QkJnRm9PdCtnYWI5ZkpKNVF0R2dCbkU1MnVxL2J6Rlo2K1hBODdRbVBIdEJN?=
 =?utf-8?B?eTA3S25JT2V5R2U2Nnd4ZkJYbHpiazhPbkxhd2VucDJmZ3pUYkVQL2YzTjYz?=
 =?utf-8?B?My9MaTRvOTMybzVNd0d4Y3U0UzhzcUx2TGFEZ3A0QyswS0FzeXpIbzZjczVV?=
 =?utf-8?B?SVRTUEJ1dHRkL0doenVQcWJIZnlPTnl4M0VNdWkvNlZxTHZWTjJaSm9DU3pw?=
 =?utf-8?B?bWMwV1NQeWJLdTVaZTY5SUJFcmswaGN6STg0WTJBY3dac3pVbWJLdU01NWFY?=
 =?utf-8?B?VERwTnowVTIyVTQxa2RPV3R2a0NjbU9zcm1PTTlUYUxSc2ExalBZS2xvM2RM?=
 =?utf-8?B?cjVtdzMrZE1XM0NpYytKeHBLVStxeHJYZkdBUkhiNW95dGszbjZjV2V5WUlQ?=
 =?utf-8?B?ZmNTTlV4YjVPN0F4TlRyYzFDTHZzVHVLcVA1RTdqUTRsRWd6K1pMb0o2Tzc2?=
 =?utf-8?B?TWxFZDdxNWlEdDhEVFM2cFRIM2gvM0hzQldPNEhIazRpc0dTSk1mNlVpdEN5?=
 =?utf-8?B?dXVDUkRyK0VDTFVTVXo2RlBqV3JEdUl3aW1zZExwOUxXSEdKc0ZZQndOL0d2?=
 =?utf-8?B?STZkbmhXNC9SL2tpSjM2VGgxYXBKTDV4aGFKVnpUeWxOVEd6TzhJcXdYT29w?=
 =?utf-8?B?OERoS0MvM3BQSlJhUGgxNit5bTFIc0l3WXl3QUpqaGxuTW0zS3c2WkNkRXhm?=
 =?utf-8?B?QlhpakZuYlVMM2NYYTIzdUo0NGJEV0Fqalpwd3kybmErdGExNHBsZGJkQnQz?=
 =?utf-8?B?NHdIK1p4eGcrTE9XM2hndXd2ZmtEaDYzYTdod05QOHBDSlZDeThWWjN1cUlF?=
 =?utf-8?B?dy9OekxLb3RBWGRMSjE1OHl6dkNSb3pwTFFQWU12OFQrTEtDZGNTUGNaeG1t?=
 =?utf-8?B?eEpVcE00TTJmQUN2WjFGakJzbTk5TUZCdGJBQ3E3dWx5bTBWdjR6cG44dFAv?=
 =?utf-8?B?VVQzTGFKQm5pNFZ6aWthOUZkUnZxeVFwdmJ5TGM1clI1T0V5RkpCZW53ME5r?=
 =?utf-8?B?SmVXS2NhR2tNcmJ6SkNWbDFtbWhvU0VRdjVNZ3VYTzhzQUhlaDZscjh6Y1dO?=
 =?utf-8?B?enRaanZSd1U4U25FSWh4R0tsb2x1eTAxOTJ0aWdadC9vaE1RNUQrcFBlV2dR?=
 =?utf-8?B?TUVyLzJwMDAwZVU1YzNNN3cyeS9FbFdnbFRNb1l4NXhacUdFdWV6L2pqMVV6?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4659c1bf-de20-41c6-093a-08dc8a1d7cbd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 13:50:43.2167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzOPAxSKD4o5Cgcph56SjqP6wnwqxjBIe8MzGrUwZGiJhL4rr1yrW3dKkxXlDKLLs65Cs2yGNyILG4GuY/P0xXg/mCDA9MJuO89crQCmAjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9294
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

Hi Jonas,

On 6/11/24 3:43 PM, Jonas Karlman wrote:
> Hi Simon and Quentin,
> 
> On 2024-06-11 13:27, Quentin Schulz wrote:
>> Hi Simon,
>>
>> On 6/10/24 4:59 PM, Simon Glass wrote:
>>> At present gd->ram_size is 0 in SPL, meaning that it is not possible to
>>> enable the cache. Correct this by always populating the RAM size
>>> correctly.
>>>
>>> Part of the confusion here comes from the large blocks of code which
>>> are #ifdefed out. Add a function phase_sdram_init() which returns
>>> whether SDRAM init should happen in the current phase, using that as
>>> needed to control the code flow.
>>>
>>> This increases code size by about 500 bytes in SPL when the cache is on,
>>> since it must call the rather large rockchip_sdram_size() function.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> - Add new patch to correct memory size in SPL
>>>
>>>    drivers/ram/rockchip/sdram_rk3399.c | 49 ++++++++++++++++-------------
>>>    1 file changed, 27 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
>>> index 02cc4a38cf0..2f37dd712e7 100644
>>> --- a/drivers/ram/rockchip/sdram_rk3399.c
>>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
>>> @@ -13,6 +13,7 @@
>>>    #include <log.h>
>>>    #include <ram.h>
>>>    #include <regmap.h>
>>> +#include <spl.h>
>>>    #include <syscon.h>
>>>    #include <asm/arch-rockchip/clock.h>
>>>    #include <asm/arch-rockchip/cru.h>
>>> @@ -63,8 +64,6 @@ struct chan_info {
>>>    };
>>>    
>>>    struct dram_info {
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>>    	u32 pwrup_srefresh_exit[2];
>>>    	struct chan_info chan[2];
>>>    	struct clk ddr_clk;
>>> @@ -75,7 +74,6 @@ struct dram_info {
>>>    	struct rk3399_pmusgrf_regs *pmusgrf;
>>>    	struct rk3399_ddr_cic_regs *cic;
>>>    	const struct sdram_rk3399_ops *ops;
>>> -#endif
>>>    	struct ram_info info;
>>>    	struct rk3399_pmugrf_regs *pmugrf;
>>>    };
>>> @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
>>>    					struct rk3399_sdram_params *params);
>>>    };
>>>    
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>> -
>>>    struct rockchip_dmc_plat {
>>>    #if CONFIG_IS_ENABLED(OF_PLATDATA)
>>>    	struct dtd_rockchip_rk3399_dmc dtplat;
>>> @@ -191,6 +186,17 @@ struct io_setting {
>>>    	},
>>>    };
>>>    
>>> +/**
>>> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
>>> + *
>>> + * Returns: true to do SDRAM init in this phase, false to not
>>> + */
>>> +static bool phase_sdram_init(void)
>>> +{
>>> +	return spl_phase() == PHASE_TPL ||
>>> +	    (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
>>> +}
>>> +
>>>    static struct io_setting *
>>>    lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
>>>    {
>>> @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
>>>    	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
>>>    	int ret;
>>>    
>>> -	if (!CONFIG_IS_ENABLED(OF_REAL))
>>> +	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
>>>    		return 0;
>>>    
>>>    	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
>>> @@ -3138,23 +3144,25 @@ static int rk3399_dmc_init(struct udevice *dev)
>>>    
>>>    	return 0;
>>>    }
>>> -#endif
>>>    
>>>    static int rk3399_dmc_probe(struct udevice *dev)
>>>    {
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>> -	if (rk3399_dmc_init(dev))
>>> -		return 0;
>>> -#else
>>>    	struct dram_info *priv = dev_get_priv(dev);
>>>    
>>> -	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>>> -	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
>>> -	priv->info.base = CFG_SYS_SDRAM_BASE;
>>> -	priv->info.size =
>>> -		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
>>> -#endif
>>> +	if (phase_sdram_init()) {
>>> +		if (rk3399_dmc_init(dev))
>>> +			return 0;
>>> +	} else {
>>> +		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>>> +		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
>>> +	}
>>> +
>>> +	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
>>> +		priv->info.base = CFG_SYS_SDRAM_BASE;
>>> +		priv->info.size =
>>> +			rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
>>> +	}
>>> +
>>
>> Isn't the whole change summarized to making sure that priv->info.base
>> and priv->info.size are set when DCACHE is enabled AND we're in the
>> first stage BL (TPL or SPL if no TPL)?
>>
>> i.e., shouldn't the following code be enough:
>>
>> """
>> static int rk3399_dmc_probe(struct udevice *dev)
>> {
>> #if defined(CONFIG_TPL_BUILD) || \
>> 	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>> 	if (rk3399_dmc_init(dev))
>> 		return 0;
>> #else
>> 	struct dram_info *priv = dev_get_priv(dev);
>>
>> 	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>> 	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
>> #endif
>> 	priv->info.base = CFG_SYS_SDRAM_BASE;
>> 	priv->info.size =
>> 		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
>>
>> 	return 0;
>> }
>> """
>> ?
>>
>> Then what's after the endif could be guarded by if
>> (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) { if we need to but it's not clear
>> to me why that is needed?
> 
> Agree, this look strange to me too and your diff much cleaner :-)
> 
>>
>> Basically, I'm not sure the migration from ifdefs to the
>> phase_sdram_init() function is necessary. I'm not against it, but it
>> makes the whole thing much harder to read and hides the actual changes.
>>
>> Additionally, why was the cast to phys_addr_t changed to a ulong? The
>> function actually expects a phys_addr_t.
>>
>> Finally, can you please explain why gd->ram_size being 0 is an issue for
>> the caches, where is this checked? I'm not too familiar with the caches
>> in general :)
> 
> My best guess is that enabling of caches in SPL cause issue for
> bob/kevin because they only use SPL not TPL+SPL like (if I am not
> mistaken) all other Rockchip arm64 targets.
> 
> Using SPL-only was not something I tested when caches was enabled in SPL.
> 
> Maybe bob/kevin can be changed to also use TPL+SPL similar to all other
> RK3399 boards?
> 
> How U-Boot works on these chromebooks is still a mystery to me. If I
> understand correctly SPL is only involved for bare metal boot, if this
> is the case then using TPL + back-to-brom to load SPL should probably
> work fine?, and would align all RK3399 boards to work in a similar way.
> 

Once I repair my Gru Bob, I'll be able to finally migrate it to Linux 
but broken power and volume rocker buttons make it impossible to disable 
some of the EC security stuff :)

Anyway, my understanding is that coreboot is started by the BootROM, 
then it loads U-Boot as its payload (I assume SPL???) which allows to 
boot UEFI systems (coreboot doesn't).

I assume no TPL because we don't want to back-to-brom as coreboot's 
payload wouldn't be loaded by the BootROM so it wouldn't know what to do 
with it.

I'll let Simon answer and will religiously listen :)

Cheers,
Quentin
