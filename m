Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2C6D132B5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA96188001;
	Mon,  4 Nov 2024 13:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EpExGKxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9514188360; Mon,  4 Nov 2024 13:23:11 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EFCE80245
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXg6+cgJ+XQYFO373yhoyVJLCnXMdqNbkhvVOmsQM9ZDGs3hNC8U0NdPl1tBPiUZakR/JQpdS5qah4KLk9/Mj8FK3nW7OZNGEvumHOikb6QJvN473UVMmcvqLtcKi+GaZsUKm55/anzML6PlLDI+o5o4Y2/qh9sJ1SIbs9Okg8vvkunDgEwr5SG5jzg0ZXg5sucyYRzuIq8fd6EJQxFBS8St4ji9UcgCP3/qUqR+HQBubWgtXX5ADeJC0PId9NRJHjiqVO30pS8Qug4SYon7g4oPw57RkA3aghz0jTjIwrxh32q2gpPHA0IsJPR4JtW0TAEYX3w+SocV7dVMT/FM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I1djrmd1fpnMVJDdIw2VIwJLCH8glMLDf4DTSuxiKE=;
 b=Os3mTcED8zKAVSNrS8+e3kQH8jlizUTSSkSDwQr7RKNqltR2oCO+kwoWS+1yloxLnWMG7WFJBeTpX9FxJYusxyBM0vIEJhuYazlHOH4Yb3DLbTEBH4BKs/YfOumCsAeaxusS9Y6xW0gJIKRMJybS4OEhnMXURbxlo/78QIQd6MehOOXEcIdXNA0vvFKGpkw+3vInqGvUxx+5/o6DUGom5ocP2zpn8iqaLBVgAOu73e+qUNOPA0AXxo0/ueSYTP+LHeRyH+QGC2Thwm9XwL7jQQh/70MtiPdZgE2pRP+NgYwTkehFYhWvYhQhYSqmNdKD0cvOqadSejhncHRRasBj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I1djrmd1fpnMVJDdIw2VIwJLCH8glMLDf4DTSuxiKE=;
 b=EpExGKxKyRqjeL7Fr4akxg+ZGbnBSU35yn1hcmrJbJ4FvKnUF8mBKvKfyO9yEVRcdg/WAo9jB71+ELgtQdn1leqkdHSZZ17CMCzTRcaegq57+djRDyMjgcC/G1GUpUJfMASrqVXJldN2WpnqGyhwwYm+OP6eDNeX7nA5EadRYO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 12:23:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 12:23:07 +0000
Message-ID: <ae544735-dd2f-41eb-9518-936d56bca104@cherry.de>
Date: Mon, 4 Nov 2024 13:23:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Fedora 41 drops OpenSSL ENGINE support, u-boot can't compile
 anymore.
To: Fabio Estevam <festevam@gmail.com>, =?UTF-8?Q?Bas_Magr=C3=A9?=
 <bas@opvolger.net>, george.mccollister@gmail.com,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <a0da63e8527876ed60cfce25700793600ea2304a.camel@opvolger.net>
 <CAOMZO5BFO_9xHiia-xYy+PU+FQdVnszSoBTXUscPUA+G4f=HpA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAOMZO5BFO_9xHiia-xYy+PU+FQdVnszSoBTXUscPUA+G4f=HpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 178c737e-dece-4a4b-32c1-08dcfccb703b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3V6U1BUa2QzYTk2N3UzT3lRcTdkYktiUm5rcThuMm83U1BwRmRUMENJblNG?=
 =?utf-8?B?eGt2eWdSbXBjbFpwS2F3VEU3ZDNDR3NPTnNJcFh4Ry9yanRTQjlEdHl1cFNR?=
 =?utf-8?B?UGo2VWlXcklYRzdIVlovdTd6WlNicGtwbXRFTnluOHlLK3JzMWNta3h0U20v?=
 =?utf-8?B?ZXJ3S0VIb0oyWi9ob2pkQU85UFQ3b0NhZlpnYUY3bWJWMC9lL1VWVEp1eDNw?=
 =?utf-8?B?djRYVjRqMjY2amV6cGxKT1pmZGxXM2FqQldCRWFJMGtvV2I1MGd5SEswK01p?=
 =?utf-8?B?M3ZPUWpQVXJML1RJQk9kaEZpSjVTaUNtdWM3c3AzQy96S3M2YnNqUHVvaHRL?=
 =?utf-8?B?K1RQR29Za3Vlc1U2M0hQTzhBT1ZCWHFtaC84cVByWkZoMG54WDZ4bjZHY0xu?=
 =?utf-8?B?Y3NBODFwaW0wa2loZkZxcXY4ckt5T0lmQWpGLzhUS1FiV2R5TzlzbU1hK250?=
 =?utf-8?B?aTYyVExGNnAvWjBwQnFkU3ZkQU01YTZoVWUyY1FmOUlrWjk0WE5ZdW9HRDk5?=
 =?utf-8?B?TS9iRERsVDdnYmwwVVJGbHVISHBadFd3ZzVaSXI1d1dDWW50K3ROSWY1MXZB?=
 =?utf-8?B?UmZ1MnNYM2EyUDRockhrNXBMVzBHV3lsNXVEc1JGL3BiRnAzS0Q5TCsyWFBp?=
 =?utf-8?B?VElVVXpzMFdTQ3IreE9xTnRHZ1UyLzI2SHZ1cW1IVmlSRWRybjhRbjlUVVJr?=
 =?utf-8?B?QnFIcEZzMDRUVXhUYUZWZWF6U0oxa1Vscytpa2hyZzBjM1JNbTMya09yWUI3?=
 =?utf-8?B?R3VvZlFUdTRUWnBZdWpiMmJ6RU92SkpOQ3djRmo4cTF1QmdpeFNIcmlsUzk0?=
 =?utf-8?B?c2FQMDR6bnJFdVBsazhxYThmdG02a2hpVW1ra1p6RXg3TitRelBXTEkwTWp3?=
 =?utf-8?B?eXNyMTZJc2lQc2J4OVlhK0tFN3Qwck1IMGlhcHhSSTFaZGNCWXZveGN6NXhC?=
 =?utf-8?B?OGw5dTkvVXpFM01RV3o0eDZzbGQ1R0NBcXNubWErWCtPSTBzVmlQSk9EWFRL?=
 =?utf-8?B?Zk81bzFmNUdSYVRhbzdoK1Y0ZTVCd045Y2xtdXJESGNnakhCWVVFT284VUdP?=
 =?utf-8?B?dUV6bEVFVHQ1UDJqKzZPdnhXVndoWlR1RlFOaWJWT2JORGJIdnJMR1U0blVn?=
 =?utf-8?B?YzBiMnlib2dhTWtlWXlYSWR5VnBRUWxVaTMwdW54SU04cUs2Zml2U0R2djNT?=
 =?utf-8?B?UmpxYXBJZHgwQTRkMGh4ZVo1bktyZkpobmhTOThYTUZROFlabnhjK1JOeEoy?=
 =?utf-8?B?YngwUitNZytXTzBYNWJ4R3FEeWxWWUlqMitlOTJsVVlvZm1SWGpnQ0NDME84?=
 =?utf-8?B?Y0kxZ0ZlV1RudG9ibkZ2MGRXOWZ3dkl2UXIzM1BOalJ3dXVldHJDWUZIVnhR?=
 =?utf-8?B?SW16NUJZajZLU09BQVJjcGJvUXNHMGZQODF6N3NBKzFjakthTlhicDFsYmlP?=
 =?utf-8?B?cmN2WlpxZjg4UUpLY1NxZlUveGNCTG1NRTUrQ21MM1llUFE5LzcybWpkUkIy?=
 =?utf-8?B?djBGc3hyLzVPenZzWFU1MWV4MkVjMi9SL1BLOEQ0ODVocXRRM010b1dPZVpv?=
 =?utf-8?B?dm11eGZKYVlBUzEyUmVNYXgzWHBKalZuK0JyQ3A4WVBlQ0J6bmY3UUVubThz?=
 =?utf-8?B?dHhFRHN3bXJUcW5nKzVVbnVUbVNHajhRaDR0OUlEOTIxRGlXcXllT2E4ankz?=
 =?utf-8?B?VDdVZVZnc1JOYmU2ZUl5NU9JWWRhUElYZXlkSlRKalZrbi9ndStieXFWY2l6?=
 =?utf-8?Q?jx9UmmGinFpFAr0/+g6xUtuAT9zfyRxjTRETzxm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzZlbXB1MUMrVFhBN0VoVjcxU0FXbWNjdDl3TEIvazhDb0UvUklUUkdxdUV4?=
 =?utf-8?B?cnJTTlVQRFZFajVEVHp3b1N6OHUyd291bjlEZjZXYU0vbVZ1ckJiWG5jcDZu?=
 =?utf-8?B?RHE2eE9tek9URi9CdTh2VXRvMEw2WkZnZ0I3VHZ4Tk43NlJnZ0RLSzBxblhH?=
 =?utf-8?B?a1J5ajlwQ3I5NWYrZFFjM3gwRnA0ODZXTDZLaC8rY3hyL2FoWndtWVEyUlYx?=
 =?utf-8?B?a0hOdDRReDFZN1NDM3FuMnVyZWNBSVdlY0ZSS1FMUVdMVGY5aFBCeFVlV2Vt?=
 =?utf-8?B?dEtjYVR6WFh3NkV5VVpZVUVpTXc1d1FxVTdWbERVWXV6OExMMER1TVlGV3JN?=
 =?utf-8?B?VDFMTmJMV0M4Q05NS3VzUEM2RnZPNDQyT21PZUl2S3p2V3VKS2srQkx4NWc4?=
 =?utf-8?B?eWpUYk9iZkNHdjVlbHNCRkQvYlRmZXdlQm4wUWZOd3kvc3JBRXFSVW5FUDhq?=
 =?utf-8?B?WHhvaTZRUDJzelhvcEtTOXNISll2ZEFkOUFEUm9NZk5hczl3dk9QNHIySmhT?=
 =?utf-8?B?TzVRYjVTcXVSNjhaQ0tJUVh5clJYODFtRzB4dTdNbnZYR3NpRjVZTUtFeTht?=
 =?utf-8?B?dEZQV0krbTU4T0VDOUdWV05MRWEvLzkwdno3MVpoUjhkRG9XSkphRE02LzFS?=
 =?utf-8?B?ZjB0aWxXdDFPUTVXNkNoc2pwTjBqOTg5b0dLeUpVcVpoSGdIVHpjL0dPNnZH?=
 =?utf-8?B?dGlxdHYzSVdGR3pFQXh3VmoxMkVJbm82cDJxTWJHSGlEeWFOcXk1YnR3UnJk?=
 =?utf-8?B?TkIrN3pCLzY2TURyWjB5YmhhS25CNk9wQTVqY1E3Q0dmaXV1UmJIcjZWOWl5?=
 =?utf-8?B?bWs1aVBRalIySHJad2Qzbi96YnFmRlF1d0pJQ29ybG9vakZodTdjb2lMNVgz?=
 =?utf-8?B?SUtrTGhRWHloSW1ZN0Y4SHN3Qys4QXZNSndEb1ExWi8vZUNYc3krbDZJb2lJ?=
 =?utf-8?B?Uk1yTHdEVEt1VU1zV1pSbUNSSDVuT0xIREVDRzlobGhWRTViajUyejVrSGJX?=
 =?utf-8?B?WXhCYnpZc1VZTGpncU80TlZYS2IwRzlSeWdQd0Z3c0sxaFpKQU1XcUFacVlY?=
 =?utf-8?B?aHVuKzlON2V1OWoxa2tIazJVU2ZFcTYxOFJibUs4Nk5DSzZQK1ZSWHZRV2hw?=
 =?utf-8?B?SGpBZ1Z5bitscXRyUlZNRnpFOHZOTXNrcWJXOGxlL2w5dlo3cDBsZU9renZZ?=
 =?utf-8?B?OHFxMHdCMVpMWHhEUHE3RmM0OVoyV1lBUHBIOEM1NWxpTENjQ2JxbHRNREtW?=
 =?utf-8?B?YTQ0bW0rWGJlRGhvc29xbzJpRVduWFU4NURQZ3JGK2RmdzNORExPUXVWZFY3?=
 =?utf-8?B?eUE3dUlCczk3NnRhN0hJMWJ1QTZya1dUaUdnY0hIVVI5L2V1UUI4dVVzL0VQ?=
 =?utf-8?B?UEpTWUc1MVB4TjlxVlJyb09aeUZKLzZRaHBwYUpGNmNtYXhQd0ppYStZTERh?=
 =?utf-8?B?SGpqRkd0MHlpRUUxSG9VakpqUzdMbzgrSTdDRFZRV0RRektKMHdLWGNPYkVB?=
 =?utf-8?B?RzZRV3FBOHZOcHdtUHZBb2lYMlRZeWQ2QWE0ZUhMNTE4M3RMM09vSE5iQ3dT?=
 =?utf-8?B?Q1l5MktIc0RYNzU5cytTU3VnbVgya3ZzS0doYVdxay9Kclh2MFhVVEUrNDVD?=
 =?utf-8?B?aTRKcFFvZENMYVltK2cwMlNLRjJwNEhiUDBENTZJYjd1L3NRU2k3UVpRellN?=
 =?utf-8?B?U2wxS2ZHODNCbWlGN3QvWENGY2ZhOTZHZmdJYVV5aXM0KzVZNUMyaGowVFhr?=
 =?utf-8?B?MXc4V0MyY0d0STgwS09TN2FsOFF5SVp1N1g5UEQyeGphNUpsMnl3cHlsTlJV?=
 =?utf-8?B?bm9vbExNajlTT2xHTlcrcFh6bm15Nmh5dlBTVUNyWncxQnFEUmFYeEZMdVo4?=
 =?utf-8?B?MFAwSWZBZU5FdlQ4bkJ4Q2N2cURERktOYkNmcW5vN1BkWmt3RUVXbUlqb1VL?=
 =?utf-8?B?cXdoT2MyTFdDdE9Scm1ENmNBRU9QU2drcjl3Zm5NYVNFODlXR0lEZ1BTdlVq?=
 =?utf-8?B?ZjV3eXZXMFlkbStISVc2UHgzY2lCNXlTY3g3dmRGaTVCNWIwa0xMUGFWaktJ?=
 =?utf-8?B?ZnlHbzVrQ2NhOHFhcmFuUkRFU0VhQUk5QTBJM3VTWEZROUpScWVHSEdKVFMw?=
 =?utf-8?B?OTV3eTNBenlpanNndnZYTHhXN2dyckJneDNwd25BblR3OEx4WmdUckl2dFJ3?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 178c737e-dece-4a4b-32c1-08dcfccb703b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 12:23:07.2576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVmOiPkeHLOiD8fidUhm6EO76RiuOU1KQdKIlIBMEl9pPexOs5dPneT2NI4SMUIU/k2Qi7mgW9LrgV7aicdHqgw2ss4ClO6qz8fmWWlErlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837
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

Hi all,

On 11/4/24 12:56 PM, Fabio Estevam wrote:
> Adding George and Tom.
> 
> On Mon, Nov 4, 2024 at 12:30 AM Bas Magré <bas@opvolger.net> wrote:
>>
>> On compiling on Fedora 41 you will get the error:
>>
>> fatal error: openssl/engine.h: No such file or directory
>>

dnf install openssl-devel-engine

Cheers,
Quentin
