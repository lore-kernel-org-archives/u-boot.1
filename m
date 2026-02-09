Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97503E78D40
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 08:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0FE83BC9;
	Mon,  9 Feb 2026 09:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Hc1FVKFk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Hc1FVKFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76920839A5; Mon,  9 Feb 2026 09:39:48 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6746839A5
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 09:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xBEvykJTkHO6dowEb/fOxkpDJIc5GvNiox1IaYbE/CtDoIIOEMzkidbDjd1FjkMp9m/pwvlZlCDO/JyO/+L1mGZ1BvSPi+0HVtJtmiqU48RHNK2tPmPjBMAFnmVchAioeVfonWET7WT2DU8Twe5hZX2ilO2lUIK3NLIXhy8TKazgCZIQFCD/6H+6hugZqu3wP4auyMq8nSo2BtgZxGSMb3U7vANVAM8bAOTGkCK+QliGVaZFYBCmdJjDPC2CGA3MLxn3aQonqz2gYki0yHPBTvemoipbm4GFLIPTEesiC39c4QJwomPuwl6Tf0H+Nu9jiXsf1nApKlghvixRzmN3jA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usMSfYHOZpRp122O4EFhJn8rqbsE95lJwq1zXonJl1I=;
 b=B13JMpV6Yc02T/OOgXKHsMtJ5owCu6pqtvIUajJFLTxhGQa8hnTD63R+RYj0PcBo6//heocu8d3doPwESSF/HbeueZGuK2HM8SXU/3ik/yOS7uM5/QU6q3PjDIVo38GeXKD2M6WshjfVgBIokPpwC8kwbHHiUaNFvEbINgGADdF5CJfMV3YUN/dFnWLGsdEKoIvi4UGo8zku5MJpdsnauZrWSmYfJXSr8hiYdCy72FUMZJA/S5IhP2ymte+h76Y6xa3E67Wmq7HfAyoxTZvUn/4u9JzW7weE5EFLEyN1abUhxWXnSeAYN/UcVh30K+vJ6AtglPq1NzdCJlkQwNmJ5g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usMSfYHOZpRp122O4EFhJn8rqbsE95lJwq1zXonJl1I=;
 b=Hc1FVKFkSpkx0S/CL5sQKT80tiFXCys3qOo3TtdCnNl3HGyqjrykKVZYpB4hsKELN7Nwrx4H+JI2y/VTWhsjUxQwvOpGwosNrMv9k6KKkeO3Ux0a8MsqJEqKsS71PLzG26e8Ii5ufH3wO7KFQwNvFYqsj1+4yyxvZw2eQqpHggM=
Received: from AS9PR06CA0365.eurprd06.prod.outlook.com (2603:10a6:20b:460::17)
 by AS8PR08MB6615.eurprd08.prod.outlook.com (2603:10a6:20b:335::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:39:42 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:460:cafe::34) by AS9PR06CA0365.outlook.office365.com
 (2603:10a6:20b:460::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 08:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 9 Feb 2026 08:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jK2/phG8poXbPTwBD+NMIjJ/C3IBStVDsc2/8PIv6wIyDUdzxRXY/MkwSeupA0XtkRL9rjBKKRcDB6tsW/APUP/A4lgoGyMCNij9MC9XmvTqbDuWWQkIgJsBReQPt627bufLKhj6R7Lp2sldDVapRA0zlfQKhUyCXeGMjFO7rKTKXx8GzVkbSpZPgMwiPGlo+po2DwOzgoMKljQLwk8qyuXAh1ytwTgsa5JdMDD1aoaHS/5Dc1VRrdVRhNe5KRwKvQYds9CvBFWELH+B8pIyu0dvWIYMiUD4av2rP9Gox3M33puJX8vodjlTBKMwapdB7wH4PBPYnhuQWwS3n63njA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usMSfYHOZpRp122O4EFhJn8rqbsE95lJwq1zXonJl1I=;
 b=rkR80Zt85l+Nb0mNEOl+xSFOmJzjCQHDprrS4Xep255b07G4NNmaFf9/RL8bwuy51K4Ojc1PQTNb8ckECHu0TgqJ61mijsbCMSQ3Pa1hZ25TIvA1taKefmIU1rlv2A3q3AyBP+eaiLJ4u1VrqlAn8GenxzDhQzv69bJoKJV5QoymxUiz5oMnqJ5QoljRLKP8EpVQplMtMkM/UGtxak/yVhC2Z6lxZorwmGPJaxaDmqi/FCnBhFxFdZ4v/1wojZo7Rb9QeGXl2JUA974Zzk0rQnPL/35bCMtZlo5hXwkOhCtT+RpI55LpnIjhGq5Rt6HpOmIOidSalk8xYoo0V9ffCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usMSfYHOZpRp122O4EFhJn8rqbsE95lJwq1zXonJl1I=;
 b=Hc1FVKFkSpkx0S/CL5sQKT80tiFXCys3qOo3TtdCnNl3HGyqjrykKVZYpB4hsKELN7Nwrx4H+JI2y/VTWhsjUxQwvOpGwosNrMv9k6KKkeO3Ux0a8MsqJEqKsS71PLzG26e8Ii5ufH3wO7KFQwNvFYqsj1+4yyxvZw2eQqpHggM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DBAPR08MB5735.eurprd08.prod.outlook.com
 (2603:10a6:10:1a1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:38:38 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 08:38:38 +0000
Message-ID: <772a6779-699b-48ea-8eed-6ebc9c4eafbc@arm.com>
Date: Mon, 9 Feb 2026 09:37:43 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260209
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DBAPR08MB5735:EE_|AMS0EPF00000193:EE_|AS8PR08MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 81024c33-e567-464c-09a9-08de67b6c524
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?ZmZFYzRldUptclIxVllsaHBCdkhkWGY4cGtyd3Y0NFM1L0lDcXZ2UUxNTEYr?=
 =?utf-8?B?L3pOWURYVGc0c3M0YXJJbEt1M3RrWkphTmNLYjlCTjVaSGFSQXIrV2NvRmo0?=
 =?utf-8?B?Y3FTQ3pFNzJUZWIydm5mYnRUU3hIR2kzek9DTzBsVjlNSTRwUnAzMW9Pb05L?=
 =?utf-8?B?bldnU3BQdWV1SGxBTmowWDdhVnhodllOMHNDOWxxTTB4elNyRG93ZmlmbjRF?=
 =?utf-8?B?R1NMazlmQ2tMRjh5SEZWY2VBTytEZS8reFhMTTZkb2RJZzRYZjc1MmVoVmJC?=
 =?utf-8?B?K2JQdHB5a3lGNi81VFFMRDNFMVlGa01VRUJIN3c2WjRuWTY1MFFTV0swb2d6?=
 =?utf-8?B?MzI4VHpVeWl1bjN3ek52TTRRakRaUUtZQy9WNnk5dFVvc09ZZTVYOXFheXho?=
 =?utf-8?B?dVlmSmphRkZkQklyL0hiUVlaWi90YWhlZU8xY2xGY1ZMaENFZnNLMkdiV09Y?=
 =?utf-8?B?OU00aTc1bnp6dGNYdkhZNFdsQ1RnS09MbElkbHRNeitIQWE4aFdVZFpsNzNx?=
 =?utf-8?B?NENCUittN2pUZFRNeGx5UG56NXUwSWdva0xjTGtBcWxDOE5lL3A4b3R2Ykhu?=
 =?utf-8?B?NE5lY2h6dE95Uzk1RDdpTTVVMVhaYVV4VTlxUUpQeVpmVHB0SFFadE4vZm11?=
 =?utf-8?B?cFNVcklqaE5NaW1jSjRSU3BtZTgwcS9uMHVnblVNK1lORHBuMEo2WlE0MVpn?=
 =?utf-8?B?a25vUERRMkU0VlNhYjB3b2h4OFc5RC9rOC9YVzBQYk1kUXlVY1pzZFRpT2tt?=
 =?utf-8?B?Zzh4RmdSMUU2L2ljclM2V1lNK29yVVZWNXJZRHRBcDMzQlhPRUF1TXI5VDRp?=
 =?utf-8?B?VzE5em1NQjVRKzBWQlZOdERVekNpZjdFbGpnLzU5YjBrQVdpQWgzWXdZMU9J?=
 =?utf-8?B?UkZVYmxlZEs3VEx4RXJ2eHcyRVN3VGQxcG9SRUYxd2plMGpHYzU2bEhoZ0xq?=
 =?utf-8?B?RXpJZTAvNnZTSjZuZUt3R0FHbmNuVmRHUHJvdm9LOGZ6L1ZpbFRBQTBSamJM?=
 =?utf-8?B?b1dhMVkwbFBxc1o2S1VSQ2RaVERvaE0vQjRlWjg2bjMzYlc0R1JabnE5UVJ0?=
 =?utf-8?B?V1FGL2poeTM5YTU4MDVmWXppdTdiaTV6NmplbkhiWjkrWWEwcGdQQVhSNzRT?=
 =?utf-8?B?ZkErajY5UTJGZjJ5NjRBU21sQW5oWFVqOG1nWjRMU0RGVjZJSnZkSlNrdkpY?=
 =?utf-8?B?VTczWkUyZFNxQktKRkJjaHJOZkJFYzhQUEk5RzFoVUZMQlduanBqZ2w2STRB?=
 =?utf-8?B?TmZMMU9hT1V0Z1RGTTIvZnhYZVVTdXRWRmtuTHJsQVMraVNHUTJzMGk5bzlQ?=
 =?utf-8?B?dFZ0Q2grcjRIOWcwUFJnZEppVmRmaDlKcUhIMmNCYjJGNWNxeTg5MzZ5U2JD?=
 =?utf-8?B?VksvZEJlaGxWZnJzWWpTMU5QVnFZSm1xQlRjZFZMTmVlcnpueVFUaW81cElH?=
 =?utf-8?B?OFZSekkyanh2dDBvWVJpN3dpVXIzTEl6RUtjREgyajkwb1JiQzhJR1BMU3pl?=
 =?utf-8?B?ZURFRWVwb0lXSlVNN1hVRlVJdkFwQWd5VFh0Q3NWYXh5Q21QWUxXbE5qSzl3?=
 =?utf-8?B?VlpncDluNUNFZVJUL3d6R0dTTGczMXFqbWd5S0FISnhKT21hZEVxeXo3Z1VS?=
 =?utf-8?B?NXpvVWRVU052eEVWQ2RpbG0xYjd0Mkp6aTFwSHhKMzArWGYzTVkyeTI2NWpO?=
 =?utf-8?B?SW5iRjREd2oxU1NmWHdVVStBOE5GR3pMK3QwLytGeDdTRWZUd1BkWFpTZ25y?=
 =?utf-8?B?Ri9aL3BwVmxkRFRIbmpML05teWFKT1pYaStCcnN4VHZIdklGcHJlbUpZVWtt?=
 =?utf-8?B?aGY2Tk4xdTl2R3V3U1BiWGZxdS8vN0UxZGdtS3RWNTF3VEVBRG1PRG5EUndI?=
 =?utf-8?B?b3JnZ3lzWm1tbHJlaTVocklza3hvNTJKTG5RQ1FsTVZBcmRVVXBYVFo2TEhU?=
 =?utf-8?B?Sys1c01MRnVSTVZKWVkzTkVjYU5tZlBJVnFSMC9SQzkvQkRXRThCRDJBYTlD?=
 =?utf-8?B?RDdxV25hQm5hZW1HZHZhK0p0UXVyZjhCQ0xXQ2JsaUR0bTljeW5XRUJId01R?=
 =?utf-8?Q?5d8ip0?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5735
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa03a78f-8a2b-4e99-3e51-08de67b69f02
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700013|1800799024|376014|82310400026|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlN0eDNkTjA0NGUrdTd1RTR1RlAxUXFoUmdySlJMQTFBWEtWNWoyTWliZVVj?=
 =?utf-8?B?ZDZxOVBXeEtqckxoR0pOcHJTVWZpU2pEaHZIdStwL2xFQURBdnVocTJxMFNI?=
 =?utf-8?B?cUJ3eDZGOS9UdlU3REJYTW5JU3A5amQ1UEhYUlA2ak5ndWM2d3dpYks3a2p1?=
 =?utf-8?B?Q2xWaHdQN2NYSnl0Nk9UYmRRM2hVQ2lua1l5c3h3Nkw2T3R3cmVKZW8yT2Vj?=
 =?utf-8?B?RkRYN2UrS0pseGhlVnNHaFJVenZ1UW82S3M0Vmg0azFyMXIrWkhPZ2hTTE96?=
 =?utf-8?B?amh0cWZ6WU4yZ2NRL0hDS2cvZzlvRWtEQnl0b2dJTEZ6VGM2MlB0OWljOG5P?=
 =?utf-8?B?bVlQak14Wk80K0llSmlPUWdDbDJYY20rOTJXK3ZRK2F6L0U1OTUxSXVyT3dS?=
 =?utf-8?B?R3BEQWZlNmJGMWgwZDFsd0pCVTdJa3J0UjRSNUJLNjVoVTJBSjFYeFdmZGE3?=
 =?utf-8?B?dnB6N2FwYzJWZERXSHRZaVpaY2RVS2t6ZkpqUDh5bTBFK05PRDNFbzRnUFVw?=
 =?utf-8?B?bEdWRWJyTWVaUHFuQ3J5MFAyTXQ0UTJQcWJCSjEwenZKRDljOVRNaTIxWGRD?=
 =?utf-8?B?cXpYTkxGMlBmYVhIUTlsVi9XcUxVanR0SXRCdlhkVU1qaEJOVW83a1FwVmFD?=
 =?utf-8?B?RHRGL3FYelN1NENuUTJ4dEsvRVFiWUdkbVdWdHc5QitLQS8rMzl0THp3V1JL?=
 =?utf-8?B?bWJueUxSWHpmMld4VEplNm9IemRZZ3J5a2M2V3B5cUEvNndOWEFJTUU1K3FH?=
 =?utf-8?B?d202NWdscWJGNWF6Z3k5UlRHdVUvRkpPeDg0Y29qb3l2Vkhwck8zNlU0aDNz?=
 =?utf-8?B?NVNvbjdZaHl4U1N5Tm53Q3BWdTY1N2lmNDc4SVhhVmxPS1c4MFJtUUFoY0FM?=
 =?utf-8?B?OGs4ODRGSVUzR3VuVGxETEVSdWhPdG95QXo3UnYycko2U2ZGVzVCR2QxNjA0?=
 =?utf-8?B?eGJUdFIyL3JLZlJKS3kzV0FrRWZCbC9KQzF1OWpNWmg5eUVkaVNwbkhWNmZ6?=
 =?utf-8?B?SnBibVZ5Z3dKNXAyaUxvTDZsdC9UT1BWYUhIS3o3bnBGc2JLVDJkemhtaXVH?=
 =?utf-8?B?dmNaU2lwbkd2WEVnR3BLVnhMVVJjSFFET0syNkgwak9YWFFobEhnQnU2aU5O?=
 =?utf-8?B?R1ZiaHl3dFlVOVU3V0ZURmZRbENDbSsxcFRHWmFaNktRRFF2clpPMERnR2x5?=
 =?utf-8?B?alJTN1ZNakxQMkFKMmlzTnNpSytjenZwWTRvbWZZaGV0dTRDU3prNEZ0WUxB?=
 =?utf-8?B?eEZoZDNaNm1PeS92aHpsVGhwdnVaUE5ZbTMwZSt0TDNxVWNuWFhleWRZZnN6?=
 =?utf-8?B?RmtWNzhRSzNtUU93bXE1Z2t0d1E1VzRjbEF5ZUFLQUQvVUpMRDdHWThKZXo1?=
 =?utf-8?B?ZXh2S3U3OVVYbm9HdkZUSHRmaVJQbmk0Z1hQMTlVTEFqVUZuOHZldktkd2da?=
 =?utf-8?B?WERHdGhQcFBudDJOWGJDaGJUU1JEekRzc1pidDRiWFFGN0NLRkIxcDdVRGdX?=
 =?utf-8?B?UjBBWklJb1BnVWJnbHExL0Z1YTRvc083ZWJnZ2QyK0c5aVdTZjByWEs2MGdF?=
 =?utf-8?B?R0pZMnhldFpadmI0eWJkbGZIYXorSE8wQ2FOa1RMMXhzaEFRVlpvMFk0eUkw?=
 =?utf-8?B?S29FQjhtWnNCZG1xQ3FRb3ZYeWtBZkJSRTdHMFVqbFc2YSt5Z3hxNzl1YUIw?=
 =?utf-8?B?WG9sTGVyQTBGZUxvNHdoYmtFYmRtc2hLV0tQZWJSTGlOT21IRFIwclhUMmZw?=
 =?utf-8?B?NEpabGluTVJJQ0s3QmRCb1EyUDZQYjJlbERYZU1vVDhrWDNxRzRtekdGcE9q?=
 =?utf-8?B?MWQ0Qlh2NzByUjJhVkp4eFA2bnRabFE4b1BSMG5TM3o5TmhVdDRiUkNiM0dR?=
 =?utf-8?B?Q0tmS0xlSlNFVVBiVXVEbGFuLzliWGptdkJiS2NOVFNJVk9OSUZHL0IwUFVj?=
 =?utf-8?B?UXA4Sk01eHBmaURIUC9SdUR0cU9ZRk5Zem9kQ25iZmdndzRuS0s2VWw2Z0FS?=
 =?utf-8?B?d3NBemhOaDJCYzVZdzRGSXNuVnVzVDFpbEMvQjE4aEx1cGM4KzBzbVRMOHpt?=
 =?utf-8?B?bmF1bGNuUlVmV3VtT1ppVXZTc2JUTWNvQW12M3FGYnljUGdnbEQ3cjhQRk5X?=
 =?utf-8?B?RHBMaU0xU2IyaHhZWTY0TnZJVm1GMFZUbjViQWNwZ002Uk9VVE5aS3JiZU9H?=
 =?utf-8?Q?NGq9I6mD4b1gcxSmHPqlepE=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700013)(1800799024)(376014)(82310400026)(35042699022)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lGRAleOX5+SiMfdT6e/7VjaYiI2oBzx9kGIcVmIf1e4xUDTk2BFxEHEEnSNplWzfX5LcyOWtSH6X9S8CygteS8XqpJIC0Anl7OPrrknpR7yYYmXh/J3HnJRLztWZbkWVkFXPYxH7XUimqauDGStpfvmVZh1OI7WdgqF2R5LCBikKXmTLN3aJ7QtDSVh9y4kk4te9gPrlUdzYi6hfFJ6QwOpXWHOM7exuk4TM35iYB7gt/gZ23g0fte8GipjXN0B9JCdREjDk5PeA+utGgDJAuv8QRQ0IziodSotId6jdWklqIU0+wcLJmnipKyVlY37KUkakkaq5o1mitkHFWFNVXi2Izjcq5wquHy/T+kxI7f5XR5dOip1Wo3mZmZfn3aZUIfDyYsJJb0k0LDt3AtmJCPxTIeU+W+SqYTcOfDMI3e6NmMTgKL+yaE/hUbqwgMKF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:39:42.1960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81024c33-e567-464c-09a9-08de67b6c524
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6615
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

The following changes since commit b5213bbfdcb1812be510427857827ee8becb9f8f:

  video: menu "TrueType Fonts" depends on TrueType enabled (2026-02-04 10:41:48 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260209

for you to fetch changes up to e7b83e64d6bc9f2366669118cb596d75f811eb89:

  net: phy: mscc: allow RGMII with internal delay for the VSC8541 (2026-02-06 16:42:45 +0100)

----------------------------------------------------------------
Pull request net-20260209.

net:
- airoha: mdio support for the switch
- phy: mscc: allow RGMII with internal delay for the VSC8541
- dwc_eth_qos: Update tail pointer handling

net-legacy:
- Stop conflating return value with file size in net_loop()

net-lwip:
- wget: rework the '#' printing
- tftp: add support of tsize option to client

----------------------------------------------------------------
Charles Perry (1):
      net: phy: mscc: allow RGMII with internal delay for the VSC8541

Jonas Karlman (4):
      net: dwc_eth_qos: Use lower_32_bits() for tail pointers
      net: dwc_eth_qos: Initialize the transmit tail pointer in eqos_start()
      net: dwc_eth_qos: Start DMA and MAC after tail pointers are initialized
      net: dwc_eth_qos: Define more of the unused MAC regs

Marek Vasut (2):
      net: lwip: tftp: add support of tsize option to client
      net: lwip: wget: rework the '#' printing

Mikhail Kshevetskiy (7):
      net: airoha_eth: fix mdio binding to switch device
      net: airoha_eth: use proper switch node for en7523 case
      net: mdio-mt7531-mmio: fix switch regs initialization
      configs: an7581: add mii/mdio support
      arm: dts: an7581: add mdio child node to switch node
      configs: en7523: add mii/mdio support
      arm: dts: en7523: add mdio child node to switch node

Yuya Hamamachi (2):
      net: Stop conflating return value with file size in net_loop()
      net: tftp: Fix TFTP Transfer Size data type

 arch/arm/dts/an7581-u-boot.dtsi                   |  5 +++++
 arch/arm/dts/en7523-u-boot.dtsi                   |  5 +++++
 cmd/mvebu/bubt.c                                  |  2 +-
 cmd/net.c                                         |  9 +++++----
 common/update.c                                   | 10 +++++-----
 configs/an7581_evb_defconfig                      |  3 +++
 configs/en7523_evb_defconfig                      |  3 +++
 drivers/net/Kconfig                               |  2 +-
 drivers/net/airoha_eth.c                          |  7 ++++---
 drivers/net/dwc_eth_qos.c                         | 43 ++++++++++++++++++++++++-------------------
 drivers/net/dwc_eth_qos.h                         | 28 ++++++++++++++++++++--------
 drivers/net/mdio-mt7531-mmio.c                    |  7 ++++++-
 drivers/net/phy/mscc.c                            |  3 +++
 lib/lwip/lwip/src/apps/tftp/tftp.c                | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 lib/lwip/lwip/src/include/lwip/apps/tftp_client.h |  1 +
 net/lwip/tftp.c                                   | 35 +++++++++++++++++++++++++++++++----
 net/lwip/wget.c                                   | 27 +++++++++++++++++++++++----
 net/net.c                                         |  2 +-
 net/tftp.c                                        |  4 ++--
 19 files changed, 185 insertions(+), 62 deletions(-)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/29233

Thanks,
-- 
Jerome
