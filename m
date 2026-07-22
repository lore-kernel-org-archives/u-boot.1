Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5211EC4453E
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D3BD40849;
	Wed, 22 Jul 2026 12:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CwuT0QFG-yOz; Wed, 22 Jul 2026 12:34:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E40F5407DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784723643;
	bh=eaGAsB3xhILbizgzHGJq/yzWCdZfolUK5iaMDzAbZ40=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ik6Vtd2xsxLFRPg2c++K6TB0U61QTxhvdBQXdNsbIavKPq81V8j6mACz3ee7vr0LA
	 yz6MQ8mIjs8wFo25+bVttgWggJ1WfmClbQV1fNe5oqqCX8srkSss9g5ILHVFdsPI52
	 41a6HWer355XC9pG4rkDVwWzj+Qpml1crpyVOJ+5O7eozF7+gikoBmgPX907cGvSqO
	 wAT4BKaeMhY5/NFd4dCsNbm8VR6sLra+5Ziapl94cyCMdmM7rvIIdXlFtbgiChoj/5
	 WvqMLWu8JxBnMIw8laP5seI4NUXoOriu5nKGTUHnvSpuX5HTudoABDiyWg25BuV3RS
	 Fhhv6R5pTDodg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E40F5407DE;
	Wed, 22 Jul 2026 12:34:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DC43224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F87580F30
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kokvMTQbB2To for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:34:00 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 141BE80F24
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 141BE80F24
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 141BE80F24
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:33:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2DF848BA; Wed, 22 Jul 2026 14:33:58 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF5E803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:33:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9Q/oGoc6CevgVDu4jPzUhf3PwVENgFBgYvOSThNqJSxHfwjLK+19DzNkOSK3FvOfM8KDcuX8ZhJjTJGw6/AOXyToexrQcM9FSz55215I6UikClMDdVPZe4kPYo9JYOMMc4LlKI4WQ9mFkWQAgceMRujc5njzINIqFCms22LwSi8pbrMrLZaSESWsmkNFQdSvRTtrldR//fhwQhXX4nCrTk0UWf5omry6qgVhOcAUoYqOqAfhnWr+H0Vkd17qpLrY1R9Ti1zOdqY6QjuVpFlHshAf3mjjlZ8pHh5h9nWeZB75tnnBPiwRyEPe0NAAxCp9M/n8pc6KdZnRxv87gAViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaGAsB3xhILbizgzHGJq/yzWCdZfolUK5iaMDzAbZ40=;
 b=rVs7GvdBDGnrcm9v0wP9HtB+uh0Z3Euz14HjfGdcuTej/CYzkZrnVUhCHfwsZZ63v12VJOSCOzodowcLJ+0+k+VEJ7jMp4n/PGJWu7eGwDFmXk3qGLdc+Kg5rScWtRStb+isFtEUFpz4FsAGRxclQT7bfZ1HutQhMlDPWa1c62jxt4oafxAtqPx6hVfdOZKyr93TjthTNbMtCJQE80BQ5RcyWIE5EZDfXlJF09CIeWOB5MOH1gbYI1JmB9ACfceaqIXK+Ot9asvmJOhCXoD9RwjL16JRxctP2rcefx9pJuUMQ2tvjNZlmdMTBG5IqkD5YOdm9PNe4jas+bAkM+HXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU4PR04MB11753.eurprd04.prod.outlook.com (2603:10a6:10:615::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:33:51 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 12:33:51 +0000
Message-ID: <41632720-1916-436f-b171-bc739b86f162@cherry.de>
Date: Wed, 22 Jul 2026 14:33:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: Boogie <boogiepop@gmx.com>, u-boot@lists.denx.de,
 Johan Jonker <jbx6244@gmail.com>
References: <e108fe69-533a-4734-8728-b17b172c4be9 () cherry ! de>
 <68f9f2bc-485e-4cbe-9ed7-8f34efdd8440@gmx.com>
 <e9100f97-91a0-4166-b62e-d639d41f6ac2@cherry.de>
 <48672330-0a41-46a9-83f3-031d5eea8e06@gmx.com>
Content-Language: en-US
In-Reply-To: <48672330-0a41-46a9-83f3-031d5eea8e06@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0186.eurprd09.prod.outlook.com
 (2603:10a6:800:120::40) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU4PR04MB11753:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c18ad08-e7e0-4638-4331-08dee7ed7c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ze2Sxhp5+1Y6uXni/aEF8sXa8dqaB57kRXdVrLMrKKqAMmzayJjqE20X+KMUqJTjT09AzqfhkKw1aubF4Wq27iZbaiNZmEmAcbM8aPuaSIAls6Srma+owwo4+uYjCLHCPVqJWH6jQTCnaosVgE38jSUFtPPmhU6nmMVH+WNLlVu0vaGRE0l/vPkPIV3xjQIGFbGHj/mcy+rIYrv3XEgRm3h8hxanc6aYFDXr3Ulm0T7pdi+4LcojxMu8pfmE/pMgAJCfLnjTQm+tZ9Yey53M8+F2i3MLwZKKiVMYsr2CoZ5s3/8bnhaZBnTg/IfxTOxiHoL87nnN3DnlRX4Ggd+3bb1Ut6eU/H1aOPB7BvEGIlf2NVNcoxXSdt/b/fyuiKmHkjOfyH8ydhrFAdAb40jC+BspafS0Zvwky1cgreNO14tPA2ksIrEPbofwgiMQ5uuHJmooz7Z6kQXPuQN3gRLpAmYKoLuAielqD/I2SAw94ekVcRvH13/3j2dN2Oj05pT+VRW7SqGZ5TdXN4jZeHUOyYNOMnFWbo3OaTZn2w3EcoY9WYOKavG4yctrcpF/gB4qbNTOPflBHi0Zs9xCE46nEQXmPEkLKRb1DGKQ143enxt4SJdNByHYpyATCEeYgWio4pCu5xcNZJcYhIQmkxiW9fn42FmvC99HZ8PRLUTzCAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dNN0x3a21uL2o5blpPSWVoenJpN01qSjlyMk8wcUdrakdpY1hhU3VMdzhu?=
 =?utf-8?B?Q1o0WjkybENZT2pZSW12Ym5CTHdOMVowTU5DUExlS052OEltQVN5QnoyaUdN?=
 =?utf-8?B?dUxtYTJmN1NYaFY4aDdiTENKUFhRN1prMFBwejdwbUhKaGlvSU5vcFNzK051?=
 =?utf-8?B?bWtNM3JmQkhva1B1M09ONi8rQWZFN041VklReHJvaVg0OHo5bE53WWZ6RUhu?=
 =?utf-8?B?MDBEdkVHbUt3SFgyV2hCVldlNVIyN0NLTWRSK2Iwc2Nkc2lCOTRlQks1UFIv?=
 =?utf-8?B?T3ZyYU5DekxxbnRMMlh1WnI3b3BiZmZQazlvYkg2bERDNTlyeFJCUHZvWlQ3?=
 =?utf-8?B?ekFwbno3cTArVzl4WE1wS29zZkt0b21QZ09ONGdxdmVXVXQ0NnJ6dG5sMWNI?=
 =?utf-8?B?VHNLMnZrWStjU0ZIV1I3dkF3UVhqczFWNzlVYy9aczVvdmpoNllJa3ZRVHMz?=
 =?utf-8?B?RzN0Vm9TdW9aRWxUTW1wU0FiVzB4ZXJuakhkT2d0OFIrdmpGSHNCM1B1ZTNR?=
 =?utf-8?B?SUdUT3d3TlZVL1p2bmhuVXpkNnpkbmlkekFWUjFMTTd1M09ROXFQWGN3SFB1?=
 =?utf-8?B?V0hJdytRL3hzd2VCNW44ZHk0WUlXbFA0akR3MVpPc0REcmZtZS9PbVpnaDFv?=
 =?utf-8?B?eXh5U28xSVhYanRFZHovUldNVjdjQ3E3Q2NveHBMSHM2SWxpbkdHU3h0bnZP?=
 =?utf-8?B?THZ4UHovclFHMlRycTZPdk5Yb3cwaXo5dnRIM21oOGU5NGV4eUlBNnBHczBl?=
 =?utf-8?B?WEwrNGpVdmg4aDhBREExS2lNZkVzVUFSWmlKM2VSSzd6TkFzaUtKL1BRMDVn?=
 =?utf-8?B?VTNSajdZczJ0U2FSU1VFRkNCbmFRcU5qSkJCYU9GYlJsb3J5TUgyMlFmZUZY?=
 =?utf-8?B?R0drR1pKU2xRVmd3NUw0WHdkVHhYbUlmRGZvLzdoNnYwSE1HUGJjNERGcVRx?=
 =?utf-8?B?bzdHR1ROZ2trREwybVVVbkIwZTFkdHVSZ1AvdDhVRU9rUjdkUmtyM1R1SjZK?=
 =?utf-8?B?ZysvcXRjUTlhcm10UFN6QnRQczErMDJZeS9YekJqckc0VThyTlJ5SnJ1bmY5?=
 =?utf-8?B?dmpnbUJNVUdvVEI1MDVmMTFxMmp1ZEhjQm9ZWDFTcUN5UVV4ZHRRMjZhSDcv?=
 =?utf-8?B?K0sxdVhxMzVXVzhuOExLcUVEOGhtR2l4T2lHRit6dUo5VDBlV3ViTXlwMFlF?=
 =?utf-8?B?MGxrYTIvVnIwbmZORk1SN0N1QWNISkdQQ05IczNHTW93Umc4VkJTQnNwdU1Z?=
 =?utf-8?B?VWJJWWMwNXdKdml5S3lSaXZINnFRSEp1cnZJbG8rZE5nTkN5SE9rbkV3eU9z?=
 =?utf-8?B?STR1Um45STdlM0t5eUhGck5KNitDK1BmbHRkYkxvYW1qME05VXlUV2ZyZVRY?=
 =?utf-8?B?aUtCR1lTODhFWVNvSUV0d0JwbVdNa0RJaWg5NTFOTUZwaDNEUjdNcmVXZm83?=
 =?utf-8?B?Y2tEUXp6aEFteWlCWWtIamx4YXU3QkhJbmkwdWcwVGt1VFpqSmdTcGpHMy9Q?=
 =?utf-8?B?RHJMMFBYYklpeE1UR1prd1ZKbUJsbzNwZWU3bmwvTE9ieHpUTlZQclNiUVMw?=
 =?utf-8?B?NDVFQjRIeUdQbnM5WjhwMHdrSnFhSzRKdHoxdExIZCtoRWVJL0EzVjgxdnVK?=
 =?utf-8?B?TzJRcVZUYXpxVVpTUGNReTJQOS8wRjFTY1hMNlhHZFEvOGVUTXBGREoreEhk?=
 =?utf-8?B?b3p0a2VJaVdDbk1XMnRQVG5KL1FuK050ZTN5bUdKVE9CZVRaYUZnWkJnWWpK?=
 =?utf-8?B?bWZoWnZvdEkySi9scjdFVlFoMWdQcGFjM3c3SjhRUUJKME1IR056ekJzNzBx?=
 =?utf-8?B?MFVHRzkxZDYvZjBRR2kyMUF0VHgvTWozUzhWc05vQzd6M295ckZFNWlyYzlB?=
 =?utf-8?B?ZW5QZnVQbTF5SUEzSzRvdWx1c0h1VFVSQzhrWjFpRU5mbUsrQTdhVFR5QUFv?=
 =?utf-8?B?TEU3RFlIbDE3a0JxcUlwREZneFFWNnUwWFNaRlgybW9rU3hNdnlMMTF2ajYr?=
 =?utf-8?B?Y2lVNWxFam1nYWRYZHdvSGo0WG9yL3pSWGVZZXQwSFcvMDVSbFlOQ2lUTlBj?=
 =?utf-8?B?Zjd4OElyeDhQSFA5RXJqQ0ZmU24wcStDWUgrUmdCS1BhOWJwQTYxZTVqRkxh?=
 =?utf-8?B?SHk4QlA5YUhrOFIzU0JZQ0pLbUl3cVlKTFpWNnNwSGdxVVhaNUNFK1c2VzQv?=
 =?utf-8?B?cWt0dWJoTGFLZVNybGVqbjZhWVVNZ3UwR1ZOZ250Q2l5QXpxZWdhVmV0aTJp?=
 =?utf-8?B?OGpqVXZCaVJxNlZZSW54VHFuVFJJMDlGK3JhbjJIU0JBb1A0ME84aURrVXFL?=
 =?utf-8?B?ZUtmMUc1ZUxySzRxbERsZW9jYVI2MFE5ZFZoc1ZncURHM3ZtVlRGUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c18ad08-e7e0-4638-4331-08dee7ed7c65
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:33:51.5012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74sHYknicF6Agn1JrDsA2QUwScDDrtheROkkYNAIb9wmcK8vgIw3iuNEj1hqIELykm7/yf7wW9MO9koC1IGgmpG08AI+3bk2+Y9uI4Pybfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11753
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaGAsB3xhILbizgzHGJq/yzWCdZfolUK5iaMDzAbZ40=;
 b=LkuvdGbeJZ1vhmCX7PaK31IprcT9ic+E0oiFQmp86R99fgkneseprZXpN1D9lhF18mAZIpqOt9MRyg5m8ZywdrgslqbnKYY6gjqXpCSRbpownGTxqQ/jg3zdkiBUfIctcg1Wv1xmOmVey3t7L1NS6CHZGMMjuWYJACUoskhZPVs=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=LkuvdGbe
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="LkuvdGbe"; 
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/22/26 1:39 PM, Boogie wrote:
> [You don't often get email from boogiepop@gmx.com. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Quentin
> 
> On 7/22/26 11:28, Quentin Schulz wrote:
>> Hi Hüseyin, Johan,
>>
>> On 7/22/26 12:56 AM, Boogie wrote:
[...]
>>> Rockchip NFC technically as minimum needs to know rockchip,boot-blks, &
>>> rockchip,boot-ecc-strength props only. Currently the checking condition
>>> is rockchip,boot-blks & applied affect is rockchip,boot-ecc-strength.
>>>
>>> The bug is this is only applicable to first chip not all chips.
>>>
>>
>> "is only applied" I think you meant here instead? Or are you implying
>> that you want chip 0 to have rockchip,boot-blks and rockchip,boot-ecc-
>> strength applied to it, but NOT chip 2 even though they are listed in
>> the same node?
>>
> 
> Yes boot-blks and rockchip,boot-ecc-strength must be applied to only to
> the chip CS=0. This is how the bootrom works, bootrom does not look for
> an idb image [tpl/spl] in a chip which is not CS == 0.
> 

The BootROM can only read from chip 0, and with a specific (lower I 
guess) ECC strength. That I understood and is a limitation we cannot 
work-around.

I was trying to figure out if you wanted to have chip 2 have a different 
ECC strength than chip 0 while being in the same node (and thus, 
necessarily with the same properties). Considering the properties are in 
a node with multiple chips (via the reg property), I would think the 
properties should apply to *all* chips in that node. Considering the 
kernel doesn't support this (from a cursory glance, maybe I misread the 
code), if you want something different, you need to discuss this with 
the Linux kernel MTD and Device Tree maintainers to have this validated 
first. I think they won't agree simply because we cannot know for sure 
that all (past and future) SoCs will forever only read from chip 0 and 
would result in different behaviors with the exact same node for 
different SoCs, but maybe I'm wrong :)

[...]

>>> Additional note: Linux mainline also is lacking the "nfc->selected_bank
>>> == 0" check, so i think similar patch should got to linux as well.
>>>
>>
>> Not sure what you mean here as Johan removed both checks in the patch.
> 
> You are right, sorry for misleading, we had discussed to put a lock to
> with "&& nfc->selected_bank == 0" for both read and write to uniform.
> But now i noticed that this patch only syncs with mainline and
> downgrades the ECC to bootrom strength for all chips first boot blocks.
> This also works, but of course the side affect is reduced ecc strength
> (if your current one is higher, and most likely is).
> 

Indeed. Thanks for the confirmation!

Cheers,
Quentin
