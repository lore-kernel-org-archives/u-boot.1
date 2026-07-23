Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0025C531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C9C060A5E;
	Thu, 23 Jul 2026 15:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNAPkTkOXWXI; Thu, 23 Jul 2026 15:26:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2045B60A41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784820374;
	bh=3my+RwA7CDb63PijTcAzrcMi2qvZXIf9Pdmc0q7HhFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zWokld+rc8ifkIOwS9E68yLXKm/UbfdyE0+Cl6M8wY7IuGP64TJ4cJBKhAOhsK9R0
	 3qPsIvNQyyDGIp3xWjkAYXCK7cLxw7Ivgi+MIPDp2xssrbvGF61sRFGZq78VqoDeDr
	 OGAibus4EBEsSq/HrTIrNLiLaJR1Q3YxwjzG/p1oGaYhqABY49s4rESQAGQd4aLrKH
	 Dzf2WozE72V9wmGH/rUN2pAu9qZSZczKIpy+vWvuP/D6IGak8MVJN7STHZ2QdMXlvo
	 XKb0Z3tj6gdeTNJluUcAoME4ImUCn4y84S1ATdfH1jOP1aWojCQiZISAKhZeDJ9nlE
	 j8DkMOeyTo29A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2045B60A41;
	Thu, 23 Jul 2026 15:26:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29BD41B8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B56A403F4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DPxdqWSR4Dnv for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:26:11 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 87B04403F2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87B04403F2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87B04403F2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:26:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF80803F6; Thu, 23 Jul 2026 17:26:08 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716A9800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:26:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SowJ0Wf9z1fPJ7m4fTmEcPECsh7tML3p+5etg3PpbxyWjVtiPe2MlwCgJTJRPC9w8oM3As+6MVAUaRgcIwm1bHFDLMP1JOOtpgS+wzONLuegzzx4w47TUz5dRcueOyogCeyRWxwTqmAl/gmFUGzJ6uFnIniQjRnZlQ4RquhgqAYUFLQgHqAwjo1jzLNLUk/nvpZULj2PwRio2SZMDSeWUSvykOtckA7ql3drsUoTSI3K5PE1MYusv0gGMF0TJ89DeRt6CGP3NvPltdDp1SkV5TWolgWRcktB1d/cJAfLMl96XayX2GsRPyDNBAz7rz0oW/QlVxR51YBoNpZjRig0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3my+RwA7CDb63PijTcAzrcMi2qvZXIf9Pdmc0q7HhFQ=;
 b=zAR/qgPaJ6GRse3K6TN0lLTR3qxG/+J+x2mrNMfRR/pUuIQqxpGAfW+CqfA7SnsITIR1rQjcrnj0TtMPadpSNeBBSaXLSbWnXLFnv09Vz09t9g6AC3fb8iqZS3CG2rch33n2zKVrPxDsXNSne0ams7gRmdZ6pcwTsLOJWJf839WOAtWf5hcoBs/wz1ETRcqSj0a9XeQJmpYqEjB5S8yBP2BNVv7FRexE+pCNRXOu8XrYngXGmCffBn4a/1f+ybW0wLmQgIYxnQXtcbbc+xLMYBQTtNDjeFZMkABmFNhOPIlWLrTHe8dkufisSxnDIB8lP7wVCPnHyeTjCKuBB6Q95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBAPR04MB7462.eurprd04.prod.outlook.com (2603:10a6:10:1a0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:26:04 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 15:26:04 +0000
Message-ID: <ab5807ab-a139-4f92-b274-318cf73f1b47@cherry.de>
Date: Thu, 23 Jul 2026 17:26:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: a37xx: pinctrl: fix info->dev used but never set
To: Stefan Roese <stefan.roese@mailbox.org>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ben Schneider <ben@bens.haus>
References: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
 <a0fc7450-cb3c-4a32-b3cc-cc2feec78f8a@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <a0fc7450-cb3c-4a32-b3cc-cc2feec78f8a@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0063.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBAPR04MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 88487135-88ec-49cc-f327-08dee8ceb58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9B96jGNkscqVxbcH9ezzaIUorMYOgTrbllWcwfBRJ1qAebw6GDiCbDRD945rvXi0dc2vSz2gnEZXrLZ0MH/DMQAraVfXZNOeewt8VB3hfN9JWURroXA8weU0gW3jKkSqYq2LD98ITzE5OBlQHkRo8awHcKDbpKGAwj161dlNpxTxHUAP5rxVLtmb9g65RC4tXowtnQO1taRfbBLaAOHTqFj0JWAhsbCJpOYVRgF+UH8cET0JO/ld1e5cZ5fP6Mdcm00FhsiM8HhfdlSKe35gsG+8GICgRhXarASm+1BOye+e7hsb9PK3K5wngLhrh7tAAORf7Ia+quM3BvJkpxMUTf/WRGfElyBAYA4kqMyP6UHZZ7Op4K3p/C08uFeOrmDJ7xh/MhoHIJpXZ98bA4i0zl/LQvaR7axObcsxq8DhSqrTSm757Tzcl7pdBHxNnINWrGkj2zMTX8IOaxPSxiSP7PeV30NJw5jremHTpQjsH86oWoicMVaQAhD1N6vGu7qdhMXuHUOA73NApoXJOiTUFSbl+NVLbq+S+1Zt6iiBg1LuuSZmcduAotpODHGamheIY9qBLZFP5iRo3oiJlo3OWLG3bOsEcoXuorTzr81AZjIOkdBS0r6y4YXurs101a9M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlRpeXc0NTdNb3J1SWJmK21TdHkxVzJ0ci84TE8wL1RFVWtZT3NGdU5SVFM0?=
 =?utf-8?B?VGR3YUlONWZrYnVjMmhENitKV3FzNkNFTVp2dDVod1BxS1pZNnlyRVUvVXBW?=
 =?utf-8?B?ejhad2FwaHZtcmtVN1NmMDd2dmZwTkkzbkFqSXlGakltK3RzZjAwczVuNVFu?=
 =?utf-8?B?WURSYTZsSTJqd1Z4QTh1UXRLVTV1UVFjWWt2WkpMei8vZmZCOU5ab21KVStk?=
 =?utf-8?B?VWN1KzdPdE1PMlo1SlY3Q0dIMy9OcEtFaDI5Ri9tRU5MVjlsTUVISVdQeUJC?=
 =?utf-8?B?VkI0clV2MHRTQ0pZY1lpekxtV3ZiLzNiMlk1VzhVT1dBdWNxTU1PSmt1UE5m?=
 =?utf-8?B?aktHMDZuOTZ4Zm5TbmZDN2ZpOUo0d251aEdPMlRDbTdmeXoxUmdSL2g0ZVZr?=
 =?utf-8?B?Zld2WU5hRlBBT2l0aEFhdDNQVnZ6ejJOcGQ3MHZLaDludDFtM3preWsyRXBO?=
 =?utf-8?B?S2ZtanFHSUlENUNBK0l5TXJ3WWhwTDdJclR6ejJSbnM5S29IbXIzN2ZZM05J?=
 =?utf-8?B?MHljR3VCcG41eHU0UWE3ZXZCN055dHJHQU5xZ1QxTEhZTzdKQUkwcUZIUlAv?=
 =?utf-8?B?a0d1dXNOYVVCVE1zaUdlRHBna3hoUHEwNHJ6bzNsTzV4eWpYNVdZbHVHaGh6?=
 =?utf-8?B?OC9OZ1hwTDhlWW5EUDc2WW9jVEw1a3ZXR1hMUzFsaUR0Y1ZONWRNQ1l2dGdj?=
 =?utf-8?B?Ym5tWk5XUWY0UGJCRTJJSGRjWlBJZTlUSUZpL2ZkSEVVbjIxZ28yOFV5NXdB?=
 =?utf-8?B?SVNGbG9WYVcrV09qSW1udGV2bWNZeTlSTjZxbWpjRXpOcGJSWDVmeUU0Ynhm?=
 =?utf-8?B?UStVdEJJWUxkWnVJTUNRSnl4UGZKZkFuSTM2TUcya2RQN2xQVkR4QU5MOXFa?=
 =?utf-8?B?YTk1VFpvRkVOQ0gxdkhNTlJPVENneSsvY3haVFFWVlpFKzFZMms5K21sS1NY?=
 =?utf-8?B?YkRyVXBVZWhsSFlxSGxJUWRKQ1NacEdQa2RhYWs4d29LMUR0R3Z4V0h0a0Nt?=
 =?utf-8?B?aGJXeW5xWkdhSFBwenh5c0F6MGV1d2N0ekRGd01wMnNWM0FMdTYwVERyUldq?=
 =?utf-8?B?QUl6YmtYaFFPM2F3T3ltS1l1R1plOUlnOXhKYnJPbUdUMmpPUXN1R3E5Zkkv?=
 =?utf-8?B?UkJvbU1TTWdOcFBWWlF0R1Avckx1VFZhK2ZYQ1RXcjVzUVNJdndZcWgzM1BJ?=
 =?utf-8?B?eVRxY2JTclJkR29lMlhuKzltVjdCMU5sSXFlZ3RkU2hHc05uR1RhY0pocXpa?=
 =?utf-8?B?UEZGS2VtYXdRU1hrQW56cXlweFU3a1kvVFNlVzBtT2gralBWbEcvSDRJWVhH?=
 =?utf-8?B?bEZIaU9YNXNQdmtUb3pJNExEdzZNR1lieEhTVHBkeW11R1NWcVhuSU1yc1lr?=
 =?utf-8?B?aHNIdCtmcnFMaVAwdXEyZE9oWER1WlFXQWorVS9sM1p2Qi8wK0ZqdGtudkh4?=
 =?utf-8?B?dzNXakVYMytwbUdwNVk3Wk1Sd2poeDVuZWhrSW1hbVdkYm14SXJva3NBWjdQ?=
 =?utf-8?B?Rm5mNHlHOHhVYXo3Y2R0b21OZHFHMGF2K2g5TlptaXNWd2I3c1JVKzRMUEtP?=
 =?utf-8?B?NWNXbUh5c29VYW1YR1ZycWJMZkRjOFZEeS9lZ0FubTlVK2kva2dpeEE5Qi91?=
 =?utf-8?B?SkI2YXZpaVFmdENPWmJKSjVkSjRlVHNyN090NDNQMW9wZVNCekNHeGYwaFBL?=
 =?utf-8?B?VTFMcFF1OUR5Qk4vdFdzRzFSam9ZRjliNlZ3clFBU1hsUkU4d3lzcGsxamx1?=
 =?utf-8?B?bW00a01jMitITkJsRXZxdXJlcWZWV0JLV0NHTit0ZXVaVzY5VzA0NHMxYmdC?=
 =?utf-8?B?Vmp0b0txREk0VWRYMjF2ZHFudWZ4c0tuZlZaelVJOWdpVU1TdG1SVkFDYVNp?=
 =?utf-8?B?N1RBc0FOTDZHNk0yUndkU2FGdzF5cHVRQVJCeDNUS2RQUUFEMzV1R2JPdmhy?=
 =?utf-8?B?YU55VENzQjZ5bkFDaVVNbTdHcmlLcFR2YUliQWJTdis2RFJBK1hxMEVHWXUy?=
 =?utf-8?B?MEg4Z0lYczlyZ2tZQTY5RFlnZnBuZlBKdHQrbVFHbFdZelZaQmNRU1dIVlVH?=
 =?utf-8?B?ZUJZU1VJVGtuc2R3QmUvTzFHK2l5ZGkyRklmWFFLL1l1L2FabWpXclp3OGhv?=
 =?utf-8?B?Y1JHSVZZR1FLUnpRRjNEeWxiSHNHb1pRUzZRS2JTY2w4R0FxV2JOQ21OL3F1?=
 =?utf-8?B?cTRlZ1NjRHZvbkR6TXBzRnJjeEQ3SEdWekxRVVU5TDRXSkMwK2IvY3k3bmk0?=
 =?utf-8?B?cGo0VXhtdXlaK3UrR1RrRWMzcEl2REd4aytWdkdHdW16eFNyeXNkeGZKcGhv?=
 =?utf-8?B?bEt0dS9FcGNLUEhnNVNzT2pIWnlaU2VQSHRaYUpYQitENW91SkE2dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 88487135-88ec-49cc-f327-08dee8ceb58f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:26:04.1550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCo7n9CgT81hxeVCqlq7qbmCTq5TZhTPef35nMnDdxNS/z/YziCdjShNDoO0Il5Exx/D51ZCY9/0eL9TmBh8kEsA4qoPHtEyF5t4IF5vwcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7462
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3my+RwA7CDb63PijTcAzrcMi2qvZXIf9Pdmc0q7HhFQ=;
 b=hjtIp6YhRDmH5aPiFgoenVr5aEBGln65seT7UQSE7YVmxLeDZ5+eCLdHYEcj61DhyEXRNlk2doa9oQ1XDU0rKJyDvqWzqb/uZpTrEtbR/bJGSosvB0JOJsD570qAB8IZn4LX2QDAc2MVkig5ZqhYjp2ovK80KT+Y35jT5pMv3nY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hjtIp6Yh
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="hjtIp6Yh"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Stefan, Tom,

On 6/26/26 10:29 AM, Stefan Roese wrote:
> On 6/25/26 11:45, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> A bunch of code calls info->dev, mostly dev_* messages and devm_kzalloc.
>>
>> The former can be passed a NULL device and _dev_printk handles this just
>> fine.
>> The latter ignores the dev argument whenever !CONFIG_IS_ENABLED(DEVRES)
>> which was true in most cases until we made CONFIG_DEVRES mandatory for
>> U-Boot proper in commit 217cf656e249 ("dm: core: Default to using DEVRES
>> outside of xPL"). Failing to set info->dev before it's used by
>> devm_kzalloc results in crashes, therefore let's set info->dev before it
>> can be used.
>>
>> Reported-by: Ben Schneider <ben@bens.haus>
>> Closes: https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2FIRefanijM8fTzOXeGe- 
>> H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz- 
>> IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo%3D%40bens.haus%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdee6169699cf4dbea63208ded35d01ca%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639180593585608379%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=miOSlgPfYtM%2BMUpk3G1eT1ZcJyVWDGuzeob2y3sI4mg%3D&reserved=0
>> Fixes: 0871806629b5 ("pinctrl: armada-37xx: Add pin controller support 
>> for Armada 37xx")
>> Fixes: 217cf656e249 ("dm: core: Default to using DEVRES outside of xPL")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
> 

Going through my inbox... Just making sure this doesn't get forgotten.

I see MAINTAINERS has been updated to point at 
https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git but 
there's no such custodian tree (yet?). I don't see this patch in a 
branch or tag in 
https://source.denx.de/u-boot/custodians/u-boot-marvell/ either.

Cheers,
Quentin
