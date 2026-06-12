Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2567BCD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 09:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649E18056B;
	Fri, 12 Jun 2026 11:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="morn1rp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1540983FEC; Fri, 12 Jun 2026 11:58:50 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 334B88056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EE5fH05K7uJVkKm3oWvqbxgyJonwMWkszI3qL+wQT+a7UVPtnsi7qbjxKVFw4HnGq1gzGPdB5ZTgKs6DwlvJWj9x2ODorzfbt95iXVfDsHuu4/3VyniQiagmDIGVufN15M/YpQjs5lR/5ahHrP7sN7F2RXqgnAuEo+7Y0L9wjzkNuk2mf94uY2L8WF8/dDDPYarMxVYjJrnUpFf28kwhJxmqk34zyFsKnQfL7Fij3rcB9Xf/cz0LhOgEhq4lqhCBfw7dkczH0ixjRRnZYCiyFRM0mAx7u/vPhcH9rPlS/dF/zGHqFFrIcnpB0VtSKk6Mgu9rXRlDxBFUB+Hma75qKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FdimrnCa4gGL1QudJcyVXI8WG35xnn+GsrWlW7YH2g=;
 b=fEkLfwmZliAzM6pooBq3mmpWTxbuNA9/ISQGvdM2QHXhUwLQEIusRz699yh0vp/2mhSNgLZ+VBLeQ7KkXQVWghGnnQ5dd0v2Sq1vXr3Fj0JlbCXUk15dgB9GNtT1yhdIcsHLjolDFscYfnnk+4jhoYRB9du+J+4BCpCwD/rwNXSySZ0kj+ETX/un/0T0bufa14G6lQvacpRAgdOeEsJ6+BF44HbtqDix26BqlvgONUrfT8JZLzj7O2yguCmCyJXKKb4GzsKcqB2o/1/OZt6yuyj/vEiT5bim1HDyIdM4igVk2NNxDBzLqE5AajNVN199rjMOOGkNNoejJm9xhGCHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FdimrnCa4gGL1QudJcyVXI8WG35xnn+GsrWlW7YH2g=;
 b=morn1rp1ZkOWwA8tzGrsf80FmWKjnrOgj8nhmOrfhcuO3O8quPRLbKJHWrgL5IK4rZ9CxRNkSTaeyTxg7g6luNKNwMUxIg7xoC6pqig3wgP1MMlWT77YKpeURC4WoXCa+E5f5gQD90evv8ylUN+x/1ZZx6TI7P+TmoU3ohJ1mkRyDBakGuObLJfgpbvDR0Gx3ZTZsVyoToHy1bwMnStO16x8EwNeloKUus2TjmkJf6yvAYQllQ+uCvZt8rtAGKLRDkrz5ut0vDlSRpsneoiG9AlHeIsPjeswo7Sz+C1D2S1bg0AXF55Gl/rOv4FlKE9/0nIg0IWYFV9alyWjet4SpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by AM9PR04MB7699.eurprd04.prod.outlook.com (2603:10a6:20b:284::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:58:45 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:58:44 +0000
Message-ID: <7b4ffed3-3321-43ba-932b-e59a8793e95f@oss.nxp.com>
Date: Fri, 12 Jun 2026 17:59:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: TZASC misconfiguration on i.mx8m
To: Fabio Estevam <festevam@gmail.com>
Cc: Richard Weinberger <richard@sigma-star.at>, u-boot@lists.denx.de,
 alice.guo@nxp.com, peng.fan@nxp.com, upstream+uboot@sigma-star.at,
 ye.li@nxp.com
References: <3208216.Ym5mLc6kNg@nailgun> <5857153.7ts2hSHzFV@nailgun>
 <a22e9862-8718-48eb-9eb2-ecb51209f672@oss.nxp.com>
 <CAOMZO5AOMGgf-iHL-504ZTLjG4-_LhrPAMQbG48tuqfrEVamwQ@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAOMZO5AOMGgf-iHL-504ZTLjG4-_LhrPAMQbG48tuqfrEVamwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|AM9PR04MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: c99f1e79-2ff3-4c9b-ba85-08dec8693044
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|19092799006|376014|23010399003|366016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 0fsr1HnSiAGN6VksCu3Qh2oaGej/1/sJsBuV5cheVm2HA2Yg13va0nBfZYg0+1urE2UH8ByflwsV1qQQFbNK7QC3kgXiSadbU+JKb80vmo8DZ2ujTdW6Plb2EVcmXXLW0jKeA61c/qKag9+BdEcyoTO82uL1cCSpIc/2Y72ne4zQSqjdGzUFFKZZCifPKwhD0QDPWxLwTMZQBa1Gwe4myogm4JjqUIcrv4X9v+BBsAsa/NqxmMKIL5R6Zw5BAeiZFgNZX201w96hhYOeKdFAH1L7bfgjMnYIO/rREWVDlVaSSKQ4ZCPglpUE4TIbVPwqkjiqbpue/RJW7LNuLcQtoP/OEGSUNlPazwRcDZ+UmwpccZIQHRiQMGvlZjfcczt0LLX6RdMrZmQoqQmrM9Y7KAsnWxjL/q7/lWuvAjy8u34yF6jGSW20+sz3VreHn6GUGygiMGieSOdeTMu5/QG7SCD+j4Lkuvq+DE5cSOp4aVUu3xCv99dV/YTrkODhg2L+2Ov0gDcSK8P/+okXDUbn94SMA4+gGTvHFR7WwfNoyvuEmrNyz2dQVEw/9WO4M8OWfxR61ktktgp5VZGGw5/ThApdBMRKE/qAMqzAZgmFkRx19RPgh4YRVupiTr+cZ8ZSosGTC59A6zAyBdr/xWY4yEOvd6dDSCAi65k/5sHwyvPwJ6GdY2i3MDsRMx6ypxkr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(19092799006)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWJtQVB3dkQrNWZCWGZKT1g0VnBoVzlabTJlWWh0M2tXa2FqWENTSDE1Ui9n?=
 =?utf-8?B?TFdudE1aaVc0UjFqVWE5T1pPZ2FpOXRnRklPUjJxb1NrL1dIK2ZiNXFTeWU0?=
 =?utf-8?B?bUpYdGppekJDVW1ZclRLNEJVS0NyVEN1MkdMSmZGcUp2YVgyTTQvMHlnZTRS?=
 =?utf-8?B?RkUxSXBKZFliVG41U1RXbFZ5OXVDKzd6ZmIzSURySVVUTnFLWTd4OFlLSFRu?=
 =?utf-8?B?R2p2ZjI5QmRRTjZiOGluMCtTK21wT2liMXRVRUk5cEVCSEQvMzF3S2lZR0kr?=
 =?utf-8?B?TVBFS2psWVRkblVoQk53akpRNW1PaXlrNitYTWJwZ0ZCU2RjNkROZDBtYVRx?=
 =?utf-8?B?UFp4THlrNjBNMlQveFp5QmhoNmUzdmVlb2hDSUVMM21yRE9XaG5wNjE3NlJh?=
 =?utf-8?B?WnZTUUhIV2trQnNtL2hSSE9BdTdQajE4RkZDV29vNVQ1UkF5SzN2SldoQXYr?=
 =?utf-8?B?U2RiT3ozZzFEa2drV1hPYldqd2t6eXgzeFM4SU5ndnBVcDFtcWd5ODNvQjM5?=
 =?utf-8?B?bStRbHhLZklGc0Z2ZUp6VkhaMG1IWVdrL29pTW1nbUpvVDhMeGlSTW9mZjEz?=
 =?utf-8?B?bXFKMS85amN1WEtFTFFmd2h5VlNvMTVieUR3bFdpZFR1VkdwK0phaVM5YzRI?=
 =?utf-8?B?dUJtUEhpclpndzhLQjZhaytRUU1Jc21wRmJ5Z2JGWW9WMWZ6RzJkQnY3TWMw?=
 =?utf-8?B?MFEzTnNRRVAvdnNETHo1QW14K0VZU0Z5N2hzZkFlL2NpL3RhL2N1U1d3Nll3?=
 =?utf-8?B?RnluZGtkVHRXc1FhOU0xRzlBV2hsT0VseGNnQ1JlZnFvTTNkdFdONHF6cExD?=
 =?utf-8?B?S0VFSnhLaHJ4K3BxWUpzWWc0ZTlvUjZxQzJqVWpqc21kR0hoUHl2VnRNenlm?=
 =?utf-8?B?MXNUYW9kWTdmNmxRRHc2ViszVUF1eXk2K2hFMkJIWmFnWUJtZHFXUUhTY1Nq?=
 =?utf-8?B?d2NqTWp3L0VHdHVrb2I4VWI3bWI2b2NMMmUxNWhBcGhjSHhkUDY1akZqdVNO?=
 =?utf-8?B?REdmdDBxMEE3WERpOXc3NisvMW5FYzJPSmRhTE5ETnJZeDVnVDcrN3FnSlEv?=
 =?utf-8?B?enUwV0lsUGFqMDJ5RmV2OXZtV1BsczBzdEg1MThQODZtVHF5WVRNbVZvWXNI?=
 =?utf-8?B?NklqcThMUUhORWdpcUhEaHp5L1BBUDBKajNoZTF4cU1RSmxjR3JHVFB2N1lX?=
 =?utf-8?B?OTJ1M1l0bXIyWjJuWXZ3bCtDcUxuVUhrcjNPZ0M4dnFRN3h0WkdSQk5neG42?=
 =?utf-8?B?VXA3ZFNBUzBBaTg5U3ZMNDdzVTlIMEk4Wk5pTC92SjVERXU5bkZtaGhkZ01C?=
 =?utf-8?B?OFRwU0E2RThDL29ERGZ6K3ZBRkdyMWlLOVRqdy9FZTVZYnFNVzZEMmhHeHY4?=
 =?utf-8?B?emd3RExVTkM1NkRvWWZVR0plUm1ncEhKTkVRVUF0MGg3bGlrNjNMMmNBbmZF?=
 =?utf-8?B?UUgzNVY4MmZhYktPMmZnMWJEcU5JQUVXYlFOaFJlalpXV3dGNGE3Sm1DYVJi?=
 =?utf-8?B?L0tDMm1STEtNNUV1V05CTXdVQWMvSWxiNHJPM2hrdm9Rdk90UkJ4S1ZYeTFQ?=
 =?utf-8?B?VWlWQTROcEtxU3BwbnpzTEltbVVPQmQ2dU14cnEvekdDcDVqQ0FmN0RYRzc0?=
 =?utf-8?B?Wk1rUmN4eGJIYnpBV3BMWm1JQ2lSUjRua0pIVzFuTk8zUmlDTmFpcWpHMmtY?=
 =?utf-8?B?NG44a1BGYnF6UG91WTBud1BVamVJWWRMWFpiVzcrTllFZnB3MG52NlNVQS9R?=
 =?utf-8?B?d3VjZG1vSExlS3U4RUU4dG5MNTIzUkR1alJDQmcwUUJIek1wanNEM2Z0RE9r?=
 =?utf-8?B?TTU5ZmwwS2xZa2ViWmxMNzN5cHdjSDNxRUM1UEZKaVk2amd4UGE3R1JEcStV?=
 =?utf-8?B?TU1YSWxIR3o2TGg1dk9vVWp3NGZSTUJkUXM2SFYwV1Nybnoxa2NKK1NDUWU3?=
 =?utf-8?B?VVNVTHhnT1MyNDNMWjdyYjJyQ1RXb0VWTU15S1NjM09CN1RzeGVpY0YrRzRZ?=
 =?utf-8?B?QS9VaGlnbklvNmJ5SVJneWRUUFlDWldxT3RxNW4wcUcxbk9PSTVNSlQyWS9T?=
 =?utf-8?B?QTBEZ0dOZEhJbW4wL1lwUVU4Vm84U1UzNVpYMnorOHRaWUJkMWpvWE94bFpo?=
 =?utf-8?B?VUVzeVp3SVNOajVRVTlMZkNBNTRtamZJLzVXbXRwVG1kV3NMUVYrQUhCWHVC?=
 =?utf-8?B?bDNvL3VSU0JoRWVML2FOSWZ4NXd2RGRhdlZXaFZRUDY5aHJKOTRLYXhXOHEy?=
 =?utf-8?B?L3RVNHJVdWJKYjQvYkpUMlBGNjIrZHlaTnRseDZLYndoRjViL3RlZENOa05Q?=
 =?utf-8?B?ZWYyamhYVnZYMERpZnFQSXdYYWc1eGJwcHhrbG5iYTd5bUtqaWltQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f1e79-2ff3-4c9b-ba85-08dec8693044
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:58:44.8522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2ZSY+XEjkAqrEgpX4Vnt/A0qOp6PvQN89PJDAKZTxwu64l2VLjFzl8eWyX1uT9y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7699
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

Hi Fabio,

On 6/11/2026 10:53 PM, Fabio Estevam wrote:
> Hi Ye Li,
> 
> On Sun, Jun 7, 2026 at 10:53 PM Ye Li <ye.li@oss.nxp.com> wrote:
> 
>> We have discussed this with iMX optee owner. The fix should be done in
>> OPTEE not u-boot.
>> 1. OPTEE uses secure memory, so it needs to re-confiure trustzone to
>> meet secure requirement not depending on SPL setting.
>> 2. SPL also supports Non-optee case.
> 
> Does NXP plan to fix this?
> 
> Thanks

Sahil has sent patch to optee community. We are still discussing it. In 
any case, this SPL patch can't be simply reverted, it will cause 
regression to SW running in normal world.

Best regards,
Ye Li

