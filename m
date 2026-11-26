Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9EB606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nuQmZ5O1;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=keaHk9xI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94E8C409F3;
	Thu, 26 Nov 2026 18:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIh_40ynX9mP; Thu, 26 Nov 2026 18:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9F37409F7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795718480;
	b=s0veX6hmAb0BYiBzgc3zVoPIcM+SMWFIdrHX+HC7rh2HshuBVnzVZynRxHAXpenk0kYe
	 vKFwtoEYBpVFVaOkY3v4Lr1NdWFiDgsQPsqa+AK9o5sLnbyHVNRUlt/RGDh0vN7bQT21v
	 R/4N/sBAT/tYa4wP2n3FIqDlMVUEnzhkSCfJoSSPYzkMcyA3jjsB8UcvAmITCqsJMSrMj
	 OP8L+xc+mi05G+tx7AL51KTvhGQXR+nf4B3OQf2pacVEmUZGONtWwlYkaatDrKTQMkVxg
	 fk6Agw4WMa90Jnay+lNPZtZ+FhIJf979VOFbd9ZVse+JRegXlGycm39H7awzG+lmucg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795718480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fl9kO77SWzydQgMQfUAcRUa4kdTjlkfayIuEkqLoKow=;
	b=cCtXWjBXwNllmHhXoXvBRAJ4tQDGCYldye/rP85DuCv1Y5Fm4LSJH/oUfUMw/SZLGWiB
	 qoZ5AEwaERQeNq1ycZ6XNIB8mct8AoTWTEhlXcO9YO4nms4R6GoYvqiA4Hlruk41eotNf
	 id56/Y7rbbDcJkzcuZr+j04vL4ywdszfpYeAiZqZDeQCtyPu2KZStIUe+42QJ0FwjOJkE
	 9q99YL7OTAZipY9JwLwHmbPRVyfHamxtaNkfDe+AWy35NpWXKIiZUv4LbV4vT/hI5LHZs
	 x0COByqTrXIwUKRFBqM2Mavq7Pl3tZ00k5xmsXP96u3Ltg1d+CLpAZ4B4vuW3hvZohQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795718480;
	bh=fl9kO77SWzydQgMQfUAcRUa4kdTjlkfayIuEkqLoKow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nuQmZ5O1MmUgz4ogDucsLn6Jpf1AnkgK0LRasO8batjbPWNTL+Fe2f/3HpDQddgJA
	 JXo9RpRuz18jhtdwMa5x6qftEYYZdImZs/dJB9PBqLll/CkiKwjXA3MuZv5Vcmjn83
	 zISywn94xWkfjsNHzjolww/C14Wv57reNdLp34se3W8ryUlrEekeqd0dKN/IkYCwaq
	 O3eDi54HLkH45iT35AFK+PDZpRrtigGIx/u4xAYO7HVjsRhuFDPZBLn8lM+S9fzvP3
	 HargyRpO2lZnu9A++4YrQH/szyQ7DTO6ZhqBFRLsC4rfq81Fzd2OYcLuqpqTBynSt2
	 mjmT16v0qZVYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9F37409F7;
	Thu, 26 Nov 2026 18:41:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9845E266
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 858D260AA8
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ut2nXQxxjAuU for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 18:41:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A795460A8F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=keaHk9xI
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A795460A8F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl9kO77SWzydQgMQfUAcRUa4kdTjlkfayIuEkqLoKow=;
 b=keaHk9xI9TdhQhFd6Xc/I3Yu9cB7vqQFeJYdTfT6y5RZntU6tUSOA4pcTCkud7GokugbAz4Vi4Q9DT/FjKHSJ8mQWjgqQFZMiwYaVBHxX9ALncXQpI6OiiyJeN6SPezRDFJFZaXPKImolI31XvTShbT8gnHTSzHVFkyH//mr7TE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9022.eurprd04.prod.outlook.com (2603:10a6:102:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 18:41:08 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 18:41:08 +0000
Message-ID: <35a02134-e9ae-483e-894c-c2ddeb9f20d5@cherry.de>
Date: Thu, 26 Nov 2026 19:41:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fdt_support: Add /chosen/bootsource fixup
To: Wadim Egorov <w.egorov@phytec.de>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de
Cc: kever.yang@rock-chips.com, anshuld@ti.com, aristo.chen@canonical.com,
 alchark@flipper.net, u-boot@lists.u-boot-project.org,
 upstream@lists.phytec.de
References: <20261117135124.207113-1-w.egorov@phytec.de>
 <20261117135124.207113-2-w.egorov@phytec.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261117135124.207113-2-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: af7adb7f-5c24-4b3f-de1d-08df4becd5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|4143699003|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: uAvGkhBQ4Kt5cbg0s02EWA13cW7Q3uMxDs1dXBQ0dvEcLYsyFNiqs80RA4h/dE0NteYHe1K5cq0VV6hQERkaPPQkCfA7eiOi+hLnw1nomNruRuAO0acpdAZmggm0GuXKG+bkplk6xMSjdm9ThG0IgjHy93mSQO2wBvReRXj+IfMgrVlFVpIp6gwLuETNkWiUdnw1jnKy2LfhQCic0JzfKDE5OR0AlJf3PGiuKT5qvuizDmBnsYTjkABwWQEVZBaCxzSRcJhE1HBiKJmacwUvaB/3aYwFOfloFEDH6q8TmkrMiGik43C4HzvFF7duZhPaQqB+2HYyQT60u2kuLI6ci5n7aQy+CyqR2sDEz5/z+Yc4XpKW7RamO/NCMTtct18gcOgIK8YI01+Y585PAIVHRGE7kVGwgU8S0jyYlj0g3HcVa4oEUes/C7xNRgIVwuqWxqq8yLs0Uh/7S5w6x+ih2YQHbzq/0rRP8u2bU0s0hxzkprWaW6CjwFF58zdineDBr7i53hKylLcFdb1i5nbRFhStJtF+3DE+5c/DFrAw7EF1ymimOGaOev9b0IeE7a2T28Y78tDLPxf+7gOjsIOQbZAY4mpYzQHlMspZbDuKvlAF2EgSm+JfasAXSjEmsjcoCSvglWpH4sQRXF5/4oORc8shRg3j+z9OhQ+1ahu+4Uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdMU1RpR3lKQ0dablJNMmN0SmQ5cElIdzFMSWRJNytMQitWenE2aUs0ZXh1?=
 =?utf-8?B?SkhSdlFlZjdZVHBiNUNQTEFjQXA4K0NGdmw1SnJFazJuQ0R1SzVCbTZjTy9N?=
 =?utf-8?B?blB1ekYrU2NkbGNEaytiNXFoaXVUOU9kU2ZaTVR0THFFa0kyWVNwSEdFUWR6?=
 =?utf-8?B?bHNvZFplUHVUKzNNVkJDTEF6NU53b202ZTlqeTFaNjc1ZEVkU2EweDYwYzJ0?=
 =?utf-8?B?NTNEbm11WW1LdGEvQ2swcVNabm9qL00rZmtjZStoTk9LWGFzQTB3UVRWZEk3?=
 =?utf-8?B?ejl1UnhpeStjT2kvQXYrQVR3MlI5ampFRWtNK0FZOFBMNnJZS2RBbExCM1k5?=
 =?utf-8?B?VW03a2NETmkyL0lSL05GQnh5MDJ0WmxqbkZMb0hWT053WjRmU0pFOFc5bVFt?=
 =?utf-8?B?bW03ek43bVhuaWM5VDN1VzR0S1BkN0d0WHNiL1loOEJoUjlMeXZMcnFlcHdI?=
 =?utf-8?B?SStLNVozSC9YcjU1RDZlK3FUOGkzaGRscEgzM1Y2ZkR4d2t5bjhOSmQ5a0x3?=
 =?utf-8?B?djdzL2ROUnN1ZEVuUFY2OVBhY3d3MFcrVUZCMGpPWmxuamVkczltNENTUlBL?=
 =?utf-8?B?cW9zWnFpZm00MWNLdGwvUHpnL0IrNFh0TmFIRnMwcEFnTkc0bnhhd1JIVzdZ?=
 =?utf-8?B?ZldFcUducldSd2NveDVMTFdXVlN5YjExMlBseUJZZWsvUk94RW1BUjV1S3VF?=
 =?utf-8?B?K2NpMjE0M3VEMDd5ZGVzSlZnUGZSZFJBL1lHK1pHdEltNmEwRHRpaDB0bHl1?=
 =?utf-8?B?TjhQdm1oczdSSFdKOForQXc0TmV4cEkwVkdiM1pnRmt6REFBYVNlZmppeGR2?=
 =?utf-8?B?djE5VzdLdHBTdG9hL2pLVjdMT1VkREU2SklUc3BhdGdleWxIVHhiUWtsYVB1?=
 =?utf-8?B?cXNoTkVEU2ZxbU5nRytGTDdpWkVYNmM1a2hHR3c4MW9IWVhlZ21sM0RKS1Mw?=
 =?utf-8?B?ZFN3Q212WnBzSHJEc09IRC8wY29ybWhpdW5va0pFSS8rc3dhQnVMYkhZZFE0?=
 =?utf-8?B?Q1ZrSUYwL0R2dkxvT1VUbS9JR05tYTVFK3hHbkVjM29ZZUdvZGQyWEJwK29m?=
 =?utf-8?B?YXFuKzlWd29kOCtMUnE2RmM1QWpJVnZoV2xTYWRqZXpuVnFUMk9wL2Fka2Zt?=
 =?utf-8?B?NlZaWm5xdXI3QkxFNDNkY2xmSXB6L1lCN3gvL2pmL1BlckczUDdKUjdVL2pp?=
 =?utf-8?B?YnhOT3hlMEVaRW1SKytZcnVhZ0I5L1FEQnhTbUF2LzdTeEY2eFU1dlFDVUxs?=
 =?utf-8?B?NEdDUmUyNks4V3ZSQW1jREFrZmduM0IvbUg3Tk5haGQ0RG9VdnNMcU1LR2RG?=
 =?utf-8?B?OVhaZFhCRjVVQXZXaWZWUWhOQmtJeXBXOFlScU5mekZoaTVIN2hTaUkyMjBq?=
 =?utf-8?B?ZFhPWFROVWl1MGV1RC9OSHg0R21SNHVBdG1XSER5SjZ0UmxEZno3bm1zNHhV?=
 =?utf-8?B?WnZ1V3lKQ0lLM2ZaZzQxQ2lSNS9MWld1ZENwZDRmQVluS0ZBazc2bmdVT2Ro?=
 =?utf-8?B?VjhDYUljdE5Ud3VLV01ERnNqWmdHeHNMREtzS0UzbVVERUF6OEs0Z1N0OW53?=
 =?utf-8?B?anFVLzc4djBaQzNvdTJJTTREQlZhMU40MnI5WDl4Z1oyMjJyM0VoTzFDM2Jn?=
 =?utf-8?B?UFNDRHJPM1BCSFpOKzBmYU5xTkZNY3JKdVpaZUcwemtDakZwYmpKcXVkaFdR?=
 =?utf-8?B?Y3JYazFEMExnaFRrVUQ2YlRyQ2ErZjMyMkljTVhFdk1TbHpmYnErdzFCRGs4?=
 =?utf-8?B?NkRWbFh2TTAzSlcwVTlVcXp2RFJ1RlJ1ME9XWkorSnpkZTkwRWpmZ1k2WW9G?=
 =?utf-8?B?Rm9LVFowWm9XdTJPOGx1ZlN4bjNjRXhSSHpNUld1T0lTUW5yN1poYVFZVXBQ?=
 =?utf-8?B?SHJCUVNUdnk0S25VTVNCMDhRdWF6ZEdabkJGQmc4RDlqOC9Ea1RBayswYUJD?=
 =?utf-8?B?TytmUGRxK3V2TUR3bVFzYTFtZUMzZGNjR3Z6MHVmd1lGUlg2TlcyZjJ1UExw?=
 =?utf-8?B?dUJOUmhCZVNYMU9FL3ZSMWZmVWt4VEw5OXBZL3BtNUZNWHZaeHZZUXpyakRs?=
 =?utf-8?B?RnowKzBkNXRSN2pveDZTaFYzMWRjK1lZcG5xd0RzT2UvSTgxRFExNW96RHhj?=
 =?utf-8?B?V1ZVeUtLQzBLTmIrS3BqempzSXdQZ0xnTW9Xd3BLalNhMlBKUDdnVU9vL3lr?=
 =?utf-8?B?UHhHajViTmU3VEJXaEZBeEVjbWVnYUN3QlZxZVJ5NExIbEpGRnBMZUx5R2FF?=
 =?utf-8?B?cWRXYXlDYzhaVXZhUDZORUJuWlZkRks2SVpGMktPL2Z0RTBlSDk4RXZjT2I2?=
 =?utf-8?B?SGhpYWtoek5LNSs3cDFyQUptTjJnSzF5N1g0V1NZNTVhQlpUZ2Nwdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: af7adb7f-5c24-4b3f-de1d-08df4becd5e1
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 18:41:08.5333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs476u+8PF0A6gxn7OdTBq9nTCPcJFq3CkekmTsE76Mv+WsHyvgU7ybQGFjDAcmDr0aaYw50Ex+mpBU4n4T46r9hoDoaxZ+CpqkHY98gRXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9022
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Wadim,

On 11/17/26 2:51 PM, Wadim Egorov wrote:
> Set /chosen/bootsource to the node of the device the BootROM booted
> from. Platforms provide the path via bootsource_get_ofpath(). By
> default we pass on what a previous boot stage has set in the control
> device tree.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
