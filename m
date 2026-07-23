Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0951C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 10:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D669608CC;
	Thu, 23 Jul 2026 10:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WeEY7nwsD1Tu; Thu, 23 Jul 2026 10:33:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 614F5608AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784802815;
	bh=7oZyb7Lp9+WL7psZApNJ0ipAZGK5Ext0IcbKhM2Ftys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lprrdP44LQirLrePPMJl01XD5ZKDKkJt1Jy8/0kBqIdW9C2ZI0GcDguJBK1BlbSAW
	 6t+MjsyAFLYqt+nlu7dlq42qBue9VSioojn/o06WRA+y8mSEnj0u5xvjFTg5p6GWNj
	 D3zpBihWDSgqSgBcC6zC0dqsanE7VY41/xvTvAlwd6HzRV20BBM3YgS29q6h9jXIb4
	 /ndO+is0LPhm0BNAMhuhqFWscI1sEV789eTw54WGwGI55zElBT0U0SSQ/pFz4xD8Xw
	 nF+ssbCHq3LaXErZHQw8Wu7F/c5oRQ5AdelTca+dAZ5KjySAkk64WizYd1h8ZLWaT2
	 JCiTEwdHN3UuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 614F5608AE;
	Thu, 23 Jul 2026 10:33:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2E5436E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98981608AE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJICYaUzPpSC for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:33:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 57FF560816
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57FF560816
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57FF560816
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQmZ5JjJjSnXSo4SLfqmRLDFk7Mg1/5hF2ucVRflfcGkM+7LKP3p4QVxPgGnGsIVdALPhuXaBHRzOyHczl1A7EPGq2/cF8QwC/sMfRNNT7k65b+jRrnpLCTUipxR59whpg9iYAZAumbSlqqrIt3x6WxkOa29CDwT9JV9ksFvMDQQXhMv0SO1fU8BguBUDgPNeyaNUK6DbhLmoGSpm4TuJHWQhTAy9IahciPfxz7xSGOA9mv3a3cKXD2dd7KwLCAGeuNzSnbHu6acDaPaws1EdcqsTbrskwV77o0LL95FDBPHHceRTX17xGYMKunnLTpd/Arw99Ij69Msht+kc5oh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oZyb7Lp9+WL7psZApNJ0ipAZGK5Ext0IcbKhM2Ftys=;
 b=o+pZuvHo95AQ0p/FjjbVD7WY7JOD874yB5/S+chvB7jII5SsnUKcKVvgilMTZppjrqtbAenaTTfgyVilnFOwpEfDpZYPTn+ao3XyVt5xbFAB+YukJrcTiXgckNb5n42Ses1GdzFiIRZnhzPTMsPdkkK91+ZjhnGlSFTYN7WOPaHCGNgDVC0g2pndd6Mm2rezjUhWO8yhIIW7UQzNS76BjsrXR4OhHOwjTK+mApSqsdsYRlKDOxxnDPVCd9QHu8w0rnJBhKTEOScHtMVkxBQxXcEEsI8DCTO/0UBpzmCWEsXOPoMlGPYe8kN54SEMJD2iw0gAmGCRxUTpRt5awzUurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB11814.eurprd04.prod.outlook.com (2603:10a6:10:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 10:33:26 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 10:33:26 +0000
Message-ID: <6dffbfe3-a2e6-4f27-883e-d162113db17a@cherry.de>
Date: Thu, 23 Jul 2026 12:33:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.u-boot-project.org
References: <d6ffb432-5c91-4995-b5ba-d74102869280@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d6ffb432-5c91-4995-b5ba-d74102869280@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::9) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB11814:EE_
X-MS-Office365-Filtering-Correlation-Id: e0496e2d-9be9-4691-a30f-08dee8a5d405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 3EOmO4QB3BYml0TgBxmjubULMnA5cK8R3adB4QEuoEiLUn67mU0IgjFLNlZVt01M3MpWpv0v8YHOccVVgZH1CzWE6TW6tVV9N0BUS0CBk/tExercMJsvR7K9PuGgV5zxnYgT1yQTYiIPGA0HgprSlTwiTwBOmMKDWNZF4td0ZwROs9rs2Ht2vqtRuoSCab0SjcJtSWRo0VBoBirWcVAHd/zP5Q9K1wjfee0qBz3EqJOUqCcWIbXVRa/a04A5IYsZ/KYNWWwuqLpX6rwWQ8n0MMBmfrSPNVANnu27cMWPOWL56wbAwr9HuLu3BRAMKHcUOpLjutSagKu9NwR5QUuBKQTsAevUzStAVp7/QGrrbEvzBvVSsU+go7EdxpGdn7QI0zbbNJQWQVHmTeKOy3V56yIba4s+kKaUL0E0kjoxhz1iAagoJ8NK9mf8Rv8glR8KFcrpR7EeOaomLAHOgq0JYiafl5cjFWFF1SbbrX1f7QV6asE6g98Z9ikT0U6FDbOOW8TxC1NuLvcUGuHKcm8y95w+KhXUiiJ4L82YVHqBqVjpgPULgoJyo3TTAjqnCAYshXvHdV48iRAjRZzC4KLgKNSjuC0ewFi9NBv99keHdXvG/b+HLs/DdZQgU+v1cvmR0Ws6BxDz2++wX5g0nwsEZN1oGIY7/d70HmHu/n0j5jk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2hmd3pheWlhcjd4TGZSVi9yK3NtTzlvWWRhaC9nbUdINThJZTRlSWx6TVBh?=
 =?utf-8?B?eCtQS0padTc4U044YnNsSFNNVWFKSDVXVElSZUt0NXFrZC9RdkNTaVBDNTlE?=
 =?utf-8?B?dHltemorTzFpUmo3cVRsSzFKZmNFNjZHZDlpMkJFNFB1djMrWG9HNmZoNjJ3?=
 =?utf-8?B?WVhoWTFIM2NrTW1RZnAxZWhScmxmcTJZdyt1NmVVeXRKU1lETVRRME1tT2Rh?=
 =?utf-8?B?QmlESTcwQ09JdVo3cC9oSGc5MG10TXBub3FxdU16QjlmRDMyN1dFVktTcmRo?=
 =?utf-8?B?b1c4Q0p6dDh5MnRYdndwQ3ZnUlZub01KT1V4RmhMQTRpTlBnRkFicnRjdGZx?=
 =?utf-8?B?KzhETDR6SGtZVEVBV1liRkFzcjFoM3dmYXRMMUUwWGp6NUZqdUpabnAwYXBh?=
 =?utf-8?B?cFovb0xZS3l0M2hhTEpxNlZmTUFNTXhQZTczMm1yb0liZENMYURLRnNWOFBE?=
 =?utf-8?B?MTZveHgvUG1hV2x0K09paWQxOTZsQXhQdmZCN09zUFMrSVB3elNiT0gwQjBi?=
 =?utf-8?B?TlF6YXlrQndVVCtKc0ZzanEzRFFZOXRMc0NjNDREa1lVeDdWbHErVzZHZVhI?=
 =?utf-8?B?VWpsVVBwTE50bVZwSkI0QVFCSlJUWjFjVUhiRGZZY09TenhJZFA2L0kyc2RR?=
 =?utf-8?B?dmJEV0U0Q1FnNnQzcjhUd2RtcEdCU3U4SFdxL0V5TDN1K3ZRZnFYRVlmRWUv?=
 =?utf-8?B?VTAyVjNQbEZDc3V4akRZUm1QRE1rTk1QaGx6TnlkQjNJMHh6VElBQVN0dDlp?=
 =?utf-8?B?b1ZKTWxGeE1yNWRFQ1RScDhhWC94UCtSaWlIVnI1b3BZQ2NvRmg0Rkd3VldR?=
 =?utf-8?B?WitqZU9uWkdtRlEzelFmbkFXOGZ6MHpjUThLcmtUZjF5RXc5SlhuaEI2cVhZ?=
 =?utf-8?B?QWhmblR4dFBSd1pqSUVIM3BDSUhDS2VzbDBwd3RwaEF3RW9CcHJEMjJrTGVQ?=
 =?utf-8?B?YmhKQy8wVGpLaE5pOXBFZlRaeXZvSklpM3BuT3IzeFE4ZWEzVGFOeFMrLzAy?=
 =?utf-8?B?WGttZy9RMmUrTUEvalg4cjN5M1NUUG1QRCtBRjZTVUNuN2VWRHFBcmFKVnNH?=
 =?utf-8?B?cXE0a0FqVzNPUkNzNjhXVjhFeGc4aG1RbWJQenlOY1hCRGNGU0tsak5UcytJ?=
 =?utf-8?B?c1NDcVRtd2oxT1BTbG1CVWh1cXo0dnp1L3Bvc0tUdWFKMVZubmlTQ01PaE4r?=
 =?utf-8?B?TWlzYW9qOVF4TmQ3TXF6RHlncEVpdDlLMXZBQmdkNmNyK1VucldjUGtsRFl3?=
 =?utf-8?B?T21tL3cybitsMW9oMDJ2R0UyRUFGdngvSWNLQ1dFRHhUVDRuRk5LMkJxUUVw?=
 =?utf-8?B?UEhKVUhDa05LKzlqeFFycUVMcnZvcy85bXRjeUd6cklaNFNpRFdUQTQwVFdi?=
 =?utf-8?B?TVNpSkNlQTZuZmg1a2h3cm01anJQeFhHdkVndnU2c2lXTmdoQXhqZ1FGSUJj?=
 =?utf-8?B?NWVDOUdkTFhzaFErL1dXUWx5WmU5OVdwTmJtdWozeHlkeWMwR2dTUnpQNWJG?=
 =?utf-8?B?bUFSaDIrRk9QTGZuLzhsMzhkY2YyVXBPRnZoS0s4dXEwY3ltWFdKRDNPYXN4?=
 =?utf-8?B?NVhrZitaYW9SQkdyL0tFK0Z6cXArRDFtQlVJckYwdmllT1NtNEJUWTRINWpG?=
 =?utf-8?B?UDQ4VUs2WTRzdjBWa2JWWEd1WkhHMGRtTCt0OE83VjI0MFdFOHd6bUNTNVRu?=
 =?utf-8?B?NkFDM0hOZW5IVWdHT2tNMFk2REtEcm5sN3g2Q2RBY2dXUnVrb2NsN29PcWda?=
 =?utf-8?B?akNQV0o1dHpJTm1naUlRd3QrWHllZ3ZNSXJ4REtYL0hYcFY5TTBJMzJVc045?=
 =?utf-8?B?N1hGbE1sWUpJV2Z0aml3L3djT3hWSUdKd0M5dG1lTXZucWh0UXZ1RXFWalVo?=
 =?utf-8?B?c1UvbWpRMnNGWkx4b28zcnppYmMwTDZJRGhtdG0rYVQrbWdyV3h1OEc0UE43?=
 =?utf-8?B?VFNyL25paFk0SThCZjN4U0ZHZTRhZ1RKRThzU1lYZUd6TlU5RlhFbDF0d0cw?=
 =?utf-8?B?ZENkZmJDdy85VlZSTkNSV0hFM0I5SFdTbXJVUVJnTHFIUFVGZk9yMXFvOVVr?=
 =?utf-8?B?VFpYOElFQTdnY0hCWFJ4TmhaNWRWUWFlTnA1QnljUzhPUGpiVGZ4VHNPMW12?=
 =?utf-8?B?aDRQeU9TSG5WN083TEtqRCtRbzFoSm94cEsyVDVrRjkyU3ExQVYyb21FcjNJ?=
 =?utf-8?B?aGswK2hsWVBRaHEwM0dwaEs2T0sraWdWeStaZjFPNDFNTFpHbVVKVllSNXhO?=
 =?utf-8?B?TC9OV21hSDNSM2lOeTBzUE5hQ1lIanIvOFlScjF2WnQwVjJtNU5weXR6bmxP?=
 =?utf-8?B?WDA4NzFiSjUvQjZ1QTZBNFNyNGw5K3E0bjNuS1FIRnZ0Nnp5K0prZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e0496e2d-9be9-4691-a30f-08dee8a5d405
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:33:25.9609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9Y8A0LrWWRI9I6PVMRmLeUKGgBP8HmgGy0iwTa4PXA+EdUGdHV2I6QhG5pPaL8sI07+QZsPWVjn2XCoc3WXjC2Mhp/5hiu1wfhPEBjPldc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11814
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oZyb7Lp9+WL7psZApNJ0ipAZGK5Ext0IcbKhM2Ftys=;
 b=LkJTR3ZF6amTpMiV1wFSZpCPYGvvPBb0JPi/+vmbzMJfPYuYm6OHjd0XNDMOJP0rO4yTVrpbRbz6kPqN6JTgH9mhrPpTFMAETNdu3Q5KuwRgNOAnGtvM5cPv5ZokSNvnZ0FCp1xxAE/36AUlEUDIImH0mSx0500AydgnbjYhQZM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=LkJTR3ZF
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

Hi Johan,

On 7/22/26 11:45 PM, Johan Jonker via U-Boot wrote:
> A Rockchip NAND Flash Controller (NFC) supports multiple
> flash devices. The SoC boot ROM only checks for NAND chip 0
> and with reduced ECC strength. Currently only the read page
> functions have this condition check added in the U-Boot
> driver.
> 
> The rk_nfc_write_page_hwecc function together with a wrongly
> placed rockchip,boot-blks property writes these blocks at
> any NAND with reduced strength. The rk_nfc_read_page_hwecc
> function however does this only for chip 0. Resulting in a
> a ECC strength mismatch between what's written and read for
> U-Boot applications.
> 
> rockchip,boot-blks and rockchip,boot-ecc-strength properties
> require the nand-is-boot-medium property to be set in the Linux
> driver. When the nand-is-boot-medium property is omitted or accidently
> placed in an other NAND node with the required properties than for
> chip 0 there is a ECC strength mismatch between what's written
> and read between Linux and U-Boot.
> 

Yeah, we don't care, this is simply an invalid device tree. We could 
however implement the same logic in U-Boot by simply adding an

if (chip->options & NAND_IS_BOOT_MEDIUM)

around the two ofnode_read_u32 in U-Boot. A follow-up patch would be 
nice but not required.

> Fix by adding the same condition to all read and write page
> functions by dropping the existing 'selected_bank == 0' check
> and use the NAND_IS_BOOT_MEDIUM option that was introduced to
> U-Boot more recently than this driver to behave
> identically to the Linux driver.
> 

I don't like the wording in the commit log, it still isn't clear to me 
what the issues are from reading it. My understanding is that there are 
two cases that aren't working in U-Boot currently:

1. multi-chip node with rockchip,boot-blks and 
rockchip,boot-ecc-strength. They will be applied correctly for chip 0, 
but for other chips in the node, the read will use a different ECC than 
the write.
2. single-chip node with rockchip,boot-blks and 
rockchip,boot-ecc-strength for a chip that is NOT 0 (not sure this case 
makes sense though as I'm not sure there's an SoC BootROM that can read 
from anything but chip 0). Then we'll respect the properties when 
writing but not when reading and thus have an ECC mismatch.

If you don't set the properties, then boot_blks will be 0 and page < 
pages_per_blk * 0) will always be false and the four conditions blocks 
changed in this patch will anyway not be entered regardless of the chip 
so there cannot be a mismatch.

Is the above correct? Are there more cases that this patch here fixes 
and that I missed?

I can suggest to reword the commit log to:

"""
A Rockchip NAND Flash Controller (NFC) supports multiple
flash devices. The SoC boot ROM only checks for NAND chip 0
and with reduced ECC strength. Currently only the read page
functions have this condition check added in the U-Boot
driver.

In single- and multi-chip nodes with rockchip,boot-blks and 
rockchip,boot-ecc-strength set, the chips that aren't chip 0 will thus 
have an ECC mismatch when writing and reading.

Fix by adding the same condition to all read and write page
functions by dropping the existing 'selected_bank == 0' check
and use the NAND_IS_BOOT_MEDIUM option that was introduced to
U-Boot more recently than this driver to behave
identically to the Linux driver.

NAND_IS_BOOT_MEDIUM is automatically set when nand-is-boot-medium 
property is set in the Device Tree, which is a requirement for 
rockchip,boot-blks and rockchip,boot-ecc-strength and will thus apply to 
all chips in single- and multi-chips nodes, regardless of the CS.
"""

What do you think? If you agree and this covers all possible issues 
fixed by this patch, can you send a v4 for this?

Giving my:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

as the diff is correct.

Thanks!
Quentin
