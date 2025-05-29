Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2581C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 12:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05E48301F;
	Thu, 29 May 2025 14:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="hk3t/2gH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B728301F; Thu, 29 May 2025 11:34:05 +0200 (CEST)
Received: from SY5PR01CU010.outbound.protection.outlook.com
 (mail-australiaeastazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40d::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091DD83013
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 11:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zone.Niuzh@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNCamNixTrIi5+TXN3wrMBDm9L/2gFF37nibHIjRu8kuiCl5GqMHaXadYL/50ogLyJPY1raWoyOUUrGLjs/ZN+FncO59+uZxlldgdwEs+fu2OW1L6MazVVeXhAfSxCruq0W5hooEvQPW4iUa7BatwXiGHSBpwFiC0Ks8bYLJmKDtbJUiLTTtXaDsGOayur0qfOwJgsDAtTmJ+QcCwopFPo27nxLFtB4i197N8aa5voLj+SUKNXczZeSVQhJ1dwVo/PfzNVrWt1YfGa7wdf8QE7Fzztr+zp6Lt98SFxYbfnBAac0uCBpMLj6AZKK7gEJU3okUHStUrTW8uCOjBCxEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/IUH+4bBHkrj/bKo6m2TCMp83friiJa7VajcxnIypY=;
 b=L7VS6xo1Fb+z7F1nFQiy8DyKSBiCsJooUBPpjELjf7DYhXftJrQJXR4kehRn93Hi3cxSj1g5MUTC5ZICAzoRuUV8HMoP8hOd7DCoGev8+6J2ikORljoUgFh1hgQV1QrmY6e3x456Mpg5sLdDWPcJ4MnoYBbzJ54QhYHf5gywCSWUohWWouQL3SOCBln2stE5G3Zm4YoVV1FTA4KkkhGQcKbS25tLKC/xJ6wSqbSkhCmgugAX3lwrw+9rUSDdAm1B+bNIg7fPvMhWx91Sn33QnROHtFI5n1LkmOpHPaUoTVL3z+0kRdasaVKelnscEYvcJSgdEmeMn3gY0iFmdKE9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/IUH+4bBHkrj/bKo6m2TCMp83friiJa7VajcxnIypY=;
 b=hk3t/2gH81BMcTgJeZkfKiAab05R2k+Juu4aA0T8YwDkQuKowGfjl3fa6UU/smXA1kX/AXpVZYLqnR0EAtg6OogdrxuwGNKci6WHPGs2xUMdm5Zm6fHa3/kGeN8d/v2eCcDNgpuv3Q4xZSfiFpfQHclK9CC4AvO+wYPZoCbTr2KO3u8Rpe3hGln/p82LPjA09tTMqEoMhA70sbObeyr7aiK4kuEcl5M/7yJgCYXtqMyepyMgR6iIKpAgg9lPujvxbr2q057SZD8BogkWZOYCA7KqHm8b5jclFTjSaBXm2W5YsyxdVvwAElAddwj6F0S46jUnJXWcx0Xm9D36RqE2CQ==
Received: from SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::497) by
 SY0P300MB0278.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:250::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.30; Thu, 29 May 2025 09:33:56 +0000
Received: from SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1c4b:667e:6132:7b8d]) by SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1c4b:667e:6132:7b8d%2]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 09:33:56 +0000
From: =?gb2312?B?xaMg1r666g==?= <Zone.Niuzh@hotmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen
 <rick@andestech.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBib290bTogUGFzcyBTTVAgY29yZSBJRCBhbmQgRFRC?=
 =?gb2312?Q?_address_for_ELF-formatted_kernels?=
Thread-Topic: [PATCH] bootm: Pass SMP core ID and DTB address for
 ELF-formatted kernels
Thread-Index: AQHbzAGd/xtnyo2lokKyMH2GmzAex7PgcY4AgABatgCAAGR3gIAIIxk6
Date: Thu, 29 May 2025 09:33:56 +0000
Message-ID: <SY3PPF5E5ED63A94E67F10470722CA5B3529F66A@SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM>
References: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
 <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
 <28BD711D-9449-46DA-AD38-8142B0CAF7AB@gmx.de>
 <20250523222926.GZ100073@bill-the-cat>
 <fbe649de-dc78-4ef3-8204-95020ff2cf45@gmx.de>
In-Reply-To: <fbe649de-dc78-4ef3-8204-95020ff2cf45@gmx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY3PPF5E5ED63A9:EE_|SY0P300MB0278:EE_
x-ms-office365-filtering-correlation-id: c0461955-40de-45f3-82db-08dd9e93ef13
x-ms-exchange-slblob-mailprops: obhAqMD0nT+76ZruCrigLPUIQMEMZUn+3lirkaISN5UfNTt9hZA7b9tjMKkgnvtvp2OK2KrqkfB8WiYN25LOhs5Ppb/F1QmkzIM72moKYQI2PC/Nx4o7ZlJ571oyd8NjNk38RWNytlnjG31ITKGzicYaSx4BGgyL7Rt0J9hvyljTYx7ibls3s8dZYWrXSygMe7jOQJpPXplUFCHyNyS/F2cLFYJ3ZqTGZM8EeNQqFLMJ8+VIhjQfdrRyB2eP7VbNleJDnUafMKx3bmcidtaBzrF+pQB2gTOMXwp+VWMjwQSUuSMAEWdMxOFh5r1SXqKe3ZmgVBot5tq9DyM7oUnufU5A/MoMPR8Q8syIsg4qvjaI/hheagj4j0mkld1Q/d2VaHnrRPmZq0eYpYfQnHiC7wIthY3GtvBX05q2vktl4Z1WyMfv/dUQaYvJWQ+1fsErGnEORf39Oy/namnCpK0DqsRmVlHTP09A75N1shY8YK5ztzuN0t74wgt9VvsJTboXK+zR5Ak4iKcq0VI6Bb6761RP9B8pYTbk6GbVTPSbmuosxfHfE0GmuUvmSAmdWY08LcfmEnOouRnuDLMzQmdEXcxgfDzm5ELooTypn8GnswG2oh0W4W8gLOftvZdtsCi5TDzw67K7aEQIIsUCteNX0XPZ8mekGF3S59k5fSjt+E6koyeC4jAZ/nUB//GToZluHvtQNSDkm+qY/8KhiDejY2GU1iZqtzsjc65OE7RcfTKt0HKkvaQUq2220S3YXsNbJixXMHiF2QRltsiknijl9fVZatCHtOAyPoQzxH6aRWzmohlZxQcZEo/LXYxmVp6K
x-microsoft-antispam: BCL:0;
 ARA:14566002|41001999006|15080799009|15030799003|12050799012|461199028|8062599006|7092599006|19110799006|8060799009|9400799033|19061999003|13041999003|3412199025|440099028|4302099013|102099032|10035399007|1602099012;
x-microsoft-antispam-message-info: =?gb2312?B?RHZrcFFmZUN0NVJJbWhSY3FqcGhHelNEdEl1N2llYnU3SUFBZ1hhenpJYmpF?=
 =?gb2312?B?YXJ5WUtCRE5kZUFBUnh4bWtTcjNyKzFEcXZIREc3UEtHK2pyeCtJU09XZE9X?=
 =?gb2312?B?UERDVlZSbGpUa2YrcmdBTDhZbjlSRVROUS9SVUwyMCs3VkVhaEhrb2g3UEJQ?=
 =?gb2312?B?b1V2QjdoZkJ5K2FTM3gwaThCcnhrb3IzVGFQaTNSZWFXRHFQNUxYUERrRVVJ?=
 =?gb2312?B?cUV3MDhQN3RHL1cyUmFsQ1VrS3M3aDNoY3M4a05GcnQrckFwWWVIU2NaNlA3?=
 =?gb2312?B?dzlMRnVIL3JjUEVUclZTWCtsTUVjWCs5eExET1VMaXN6dE5acDZsMENEOVFh?=
 =?gb2312?B?eXdDKy9qZVFma2hWN0lGRVJFREMyeXUzK2w5aXJNY2pTK2NNSHVaNXcrTTZX?=
 =?gb2312?B?QzdpZXErbXdsVkxNYmNkQ3NqRFdneURaYmsvSEJDZncxOGRtODVNQjlvVjZW?=
 =?gb2312?B?TDRaU2RtM2c0TkxPMldhOEFmOWlDWmR5U2JCOUFWZk1QaXZ2ajhFK211K1Vl?=
 =?gb2312?B?S3NtZEcwa0hFZEc3YVJiR1JLSDlQUXRXclhFU3JNQTJvYnRUcnJpNGNnbUhi?=
 =?gb2312?B?MjlrZERNMnYrcEY5TE5HNE5nYmt5a01hL3YwcmtCSzhlamdFWmpkZkpXejJm?=
 =?gb2312?B?MGx6S2R6NFhncTRJcmN5U01hUHE3bExLUlJIRjh2dnBzSFhTYU92UVlnRy8x?=
 =?gb2312?B?SWFJMUhuZU5VMDdVcWFydTA3UVFxM2V1QVEwQ2Q2NGFJc1NLNEhaWTFCNXJE?=
 =?gb2312?B?TVdOVDJOcnZCRGJMaXpQYVNYL3VLU3g3SWpZbDIxMnZ1ZDFQK2xxS0JLMEpV?=
 =?gb2312?B?L1dMb29peW8wNjExNjRqTTBMYnFZMlJ4K2VIRDNxMGdLYU81aUZPamp1anR3?=
 =?gb2312?B?SXkvYktnWHhXejN1TlJJQ0tldFpVUW9CNWFPWm9pR1Z1bnMvaWl6Z0JsbFQy?=
 =?gb2312?B?SjdHMlJBM3k4bHJTTkV1RWNiMkxKSlNBQWlzNHdUM2crQUw0MXNaSXBWeXJJ?=
 =?gb2312?B?N1hVUHk5MkxxcVZ0aC9QcFM1TTdrMUVnS1ZTT1U5cDZ4YWlzTE5BMTF6TVhq?=
 =?gb2312?B?NWE0SGFwajFrZHRmdGhHdUlZY2h6RXkzQ0VWTkJOalJZZjQ0bUROZlNHNzMr?=
 =?gb2312?B?ZUVpZGdkV09mbmtjMGdQYmwxK1VTZ0F5aXhkb1Jya0hCWGU1bVJYZzNOUjFP?=
 =?gb2312?B?SmloaUthblp6S0NZS3pXTWsyWHJGZDdxT2pnSnNaQ2FYM1I0U3FBSWpPQlVK?=
 =?gb2312?B?aVo4QlZGbkFLMjQ1cS8yWVM4WGNBTFFKTXZ4Y3dMM1g2RTJNNExEOW5QQmNT?=
 =?gb2312?B?MjZBQmNOWWlvUlVHeENGdGh3YTh1S3AzaTJoek5pMDZxRmlRa0VzaW9GRlEw?=
 =?gb2312?B?aFR3M0FLZTlrQ2tZeXNrbVpWN3pSOGR0TGU0MmxsbHQwZHhML0RSdTBMdXF1?=
 =?gb2312?B?MGVFV1hVeVVMeVFPenBlL0x3SWxaMFp2TUo4eE1DSlE5YjVraFBXNE9weXFQ?=
 =?gb2312?B?TmRiTFVGWDRVS1ZYWWF6VXlHcU5jdEc0UzBlYTVEOVRLSXlnTVQ3L2RZSHpS?=
 =?gb2312?B?dGx4OWo0UE1FOFJ1aittRnZtZjR2WXlZRmRRcUQvdFo4d1BDQzF3WXd6K2Rl?=
 =?gb2312?B?ZXBUWEkvNFNMaUdwZnRKUExrcVI4Z2tveC9YVjlUY1hNZWRwWXdKZ3o3TEFJ?=
 =?gb2312?B?M1l6VXAxWkIxZU4zT1Eyb3duRTZMTGZPVWFOdFRvWEpHMTViR2lRa1RaMW0r?=
 =?gb2312?B?VWxtbVE4MnJ6MGI3aXVXelBIVEE0TEZONEw2U1BqTkJFTEtFeGxzUHAwVXQw?=
 =?gb2312?B?TXlieUV1T01YeDh4RWg5Uk5oSmd4VnF6RmdLZGtUVUdKZEdORFhxODJISk0y?=
 =?gb2312?B?MHhZOTJQR0F4UVVzcWk4bEhyS2xIeHBqNGhJY2hoeVloOXRiZVJFZUpGb2ZG?=
 =?gb2312?B?MGRPNTNGaVhISEZJTytPTitQSFhGRDNTK2ovbDhFMlpiOHdKUTNqVVpoMkRH?=
 =?gb2312?B?ZSsvL3RyMnBnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z3VNdDdqKzJDdnR6eHlCUWsxOEhZbEc4alo4dlo5WlJoRnR2ZU9QSVc0RXBF?=
 =?gb2312?B?ZndoRFNFaWJPNzBHQWZpK0x5Z1lJZ1puSjJuOHdPSDZtUUtXOWZ0Qzl6WXNn?=
 =?gb2312?B?bDlSMGxpTXQvSWRMOTg5WGZQZ1lwYVkzTG9XcTBsSk00Ylp6SkxtNnRsajVH?=
 =?gb2312?B?VzFvTnc0WkNveUpVL1dPV0hwV1ppdUR6YWlCTDVCUWNRYTBGSGFCZnl1VjE3?=
 =?gb2312?B?M0pJWmVSMnUweUNkTUdpUk8rWjBGVkNwMTU3a2lNYjJTRlhsMWlqd1cvc3R5?=
 =?gb2312?B?eDdMWVV5dGFhRnJHOXpFZmREZ0JuRExnaE85Q1doeXJMY1oydExVUnI2d1lR?=
 =?gb2312?B?YVdOVitxM3hyT2wrWGtITmVubG5hWG1kenJvcTYybUw5N3RMUHlGOVlxSThj?=
 =?gb2312?B?UHNucW12K0NlVytubEJJREpaK0wzQ0psYUR4R0d2ZVhNaGFOMzBYMGF1WUJF?=
 =?gb2312?B?L2cwWmE4YjRjZnpEaVpYaDRvZE91M1dzWDJZMC9QUnUvNHJYaHZzM2wxaVFV?=
 =?gb2312?B?ZVRGZUFDaGkxbXlzRk1Pa1R1VGR2K3Rpc0ltbk95bmJTaDBqSGg1VUY1U1Vj?=
 =?gb2312?B?d05aMFhBQlRZTDhIYkR6d2ppL3hOcnRkU2xKMUEyRGhROFYra3BSemRLRTgx?=
 =?gb2312?B?YmFaNC9MQUFsditNV042R3hxY2lwc3NLcGwxRG4yQ3pOQXBQOHloQU9sM2ZT?=
 =?gb2312?B?ZzRQN1NCTFBuQjZRYVFEMHRhK1EzRzVjZ0lnTEZzTVRLSUNOblBSUDlCbFpG?=
 =?gb2312?B?UldmRDM3MkY0dlU2ZnhDVGtNbkVGR2xoU0ZNRjM5bDJ4U0tTRHlORlFZam05?=
 =?gb2312?B?OGZWYWNIZXNhd2Jta1NOV1ZWM2dLNU1IOWdHbGJNM0UyV0pjbWJwTmoyclpS?=
 =?gb2312?B?SlJPR1lBa1NTYTdnL3V6UVRuaGFLYzdQMnFicVk2c0ZLNk96b2VvdUFTeXlp?=
 =?gb2312?B?THQwRWF3VnZwVSt6eHhBb3luK2hGamplVnpld3R2STV2MjdjTldBMmdKbXJl?=
 =?gb2312?B?eUxYWW5qRTdhSGI3Yk95QTVqVWw5dnhua1Yxdk5aNzM4ckl2LzBBNmw5eE9C?=
 =?gb2312?B?bldIZStkam8vN0lhaWZEYUVWSDY1STdrWVRvQmc3dGx3VCtuTDBLQzNrNWJP?=
 =?gb2312?B?OXF3UitZRUZ2V040Mm5iSy94ZVE0czJJblFsZEN4M2lJVVJyQUZrZHR6ZnEw?=
 =?gb2312?B?UVJSVEpLbUdrdjgxS2lpVmRDcDhRd2pONC9hR1lMQ29IRGw1TjJDL2c2NHhZ?=
 =?gb2312?B?NzhsaTdPVHRMc1FScGtrTlc3MnRPUmN4cjBubTJiTWI3RitidmlZTDcySzBp?=
 =?gb2312?B?QWZHUStMSmIvcmFlaEtCemxYNFN4K3BCUENsM2o0YVRjM2kwc21sQkxjRnUz?=
 =?gb2312?B?TW9rNnVtS3Z4QmhmOHJmMkVWdm56aEFTS3dNMXZzNi9aMCtyckNXdkV2UzAy?=
 =?gb2312?B?TVM2R0Y3K3QwRmpNODRCaURSRUVHN0JrU2RBcVF0OWdQaFZGZXoyTmVtY3JN?=
 =?gb2312?B?b3MvbStWdWtLSk80am9yZldMcVpGOHRtdi9uZzNwU2g3UmdPeWZ3bkVXeW0y?=
 =?gb2312?B?Y1FBM00vM29PMnduZklEZFBNVllzUi93akNFdkJ0aGNMdDBuVC81YjBLNFRq?=
 =?gb2312?Q?/eH2zMVfMCxwjOpjpbeLL9/7BGwnBfmY5npVc6VEphXg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-fb8bf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c0461955-40de-45f3-82db-08dd9e93ef13
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 09:33:56.4703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0278
X-Mailman-Approved-At: Thu, 29 May 2025 14:27:20 +0200
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

aGkgdGVhbSwNCg0KVGhlIElUUyBmaWxlIGxvb2tzIHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dp
bmcsIGFuZCB0aGUga2VybmVsIGlzIG5vdCBhIHN0YW5kYXJkIExpbnV4IGtlcm5lbDoNCmBgYA0K
L2R0cy12MS87DQoNCi8gew0KICAgIC4uLg0KICAgIGltYWdlcyB7DQogICAgICAgIGtlcm5lbCB7
DQogICAgICAgICAgICB0eXBlID0gImtlcm5lbCI7DQogICAgICAgICAgICBhcmNoID0gInJpc2N2
IjsNCiAgICAgICAgICAgIG9zID0gImVsZiI7DQogICAgICAgICAgICAuLi4NCiAgICAgICAgfTsN
Cg0KICAgICAgICBmZHQgew0KICAgICAgICAgICAgdHlwZSA9ICJmbGF0X2R0IjsNCiAgICAgICAg
ICAgIGFyY2ggPSAicmlzY3YiOw0KICAgICAgICAgICAgLi4uDQogICAgICAgIH07DQogICAgfTsN
CiAgICAuLi4NCn07DQpgYGANCg0KVG8gaGFuZGxlIHRoaXMgc2NlbmFyaW8sIHdlIG5lZWQgdG86
DQoNCiAgMS4NCkFjY2VzcyB0aGUgdmFsdWVzIG9mIHRoZSBgdHlwZWAsIG9zLCBhbmQgYXJjaCBm
aWVsZHMgc3RvcmVkIGluIGJvb3RtX2hlYWRlcnMtPmltYWdlX2luZm8gdG8gZGV0ZXJtaW5lIHRo
ZSBjdXJyZW50IGNvbnRleHQuDQogIDIuDQpBY2Nlc3MgdGhlIGJvb3RfaGFydCBhbmQgZnRfYWRk
ciBzdG9yZWQgaW4gdGhlIGdkIHZhcmlhYmxlIHRvIHVwZGF0ZSBhcmdjIGFuZCBhcmd2Lg0KDQpO
b3Qgc3VyZSB3aGV0aGVyIGFjY2Vzc2luZyB0aGUgYm9vdG1faGVhZGVycyBhbmQgZ2QgdmFyaWFi
bGVzIGluIGxpYi9lbGYuYyBpcyBhbGxvd2VkIG9yIHNhZmUuDQoNCkJSLA0KemhpaG9uZw0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogSGVpbnJpY2ggU2NodWNoYXJk
dCA8eHlwcm9uLmdscGtAZ214LmRlPg0Kt6LLzcqxvOQ6IDIwMjXE6jXUwjI0yNUgMTI6MjkNCsrV
vP7IyzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCrOty806IFNpbW9uIEdsYXNzIDxz
amdAY2hyb21pdW0ub3JnPjsgxaMg1r666iA8Wm9uZS5OaXV6aEBob3RtYWlsLmNvbT47IHUtYm9v
dEBsaXN0cy5kZW54LmRlIDx1LWJvb3RAbGlzdHMuZGVueC5kZT47IExlbyBZdS1DaGkgTGlhbmcg
PHljbGlhbmdAYW5kZXN0ZWNoLmNvbT47IFJpY2sgQ2hlbiA8cmlja0BhbmRlc3RlY2guY29tPg0K
1vfM4jogUmU6IFtQQVRDSF0gYm9vdG06IFBhc3MgU01QIGNvcmUgSUQgYW5kIERUQiBhZGRyZXNz
IGZvciBFTEYtZm9ybWF0dGVkIGtlcm5lbHMNCg0KT24gNS8yNC8yNSAwMDoyOSwgVG9tIFJpbmkg
d3JvdGU6DQo+IE9uIEZyaSwgTWF5IDIzLCAyMDI1IGF0IDA3OjA0OjQ2UE0gKzAyMDAsIEhlaW5y
aWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+PiBBbSAyMy4gTWFpIDIwMjUgMTg6NDE6NDUgTUVTWiBz
Y2hyaWViIFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjoNCj4+PiArSGVpbnJpY2ggU2No
dWNoYXJkdA0KPj4+DQo+Pj4gSGksDQo+Pj4NCj4+PiBPbiBUdWUsIDEzIE1heSAyMDI1IGF0IDEz
OjI4LCDFoyDWvrrqIDxab25lLk5pdXpoQGhvdG1haWwuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4g
V2hlbiBib290aW5nIFJJU0MtViBFTEYtZm9ybWF0dGVkIGtlcm5lbCBpbWFnZXMgKElIX1RZUEVf
S0VSTkVMICsgSUhfT1NfRUxGKSwNCj4+Pj4gZXhwbGljaXRseSBwYXNzIFNNUCBjb3JlL2hhcnQg
SUQgYW5kIERUQiBhZGRyZXNzIHRvIGNvbXBseSB3aXRoIG1vZGVybg0KPj4+PiBTTVAtZW5hYmxl
ZCBrZXJuZWxzJyBib290IHByb3RvY29sIHJlcXVpcmVtZW50cy4NCj4+Pj4NCj4+Pj4gU2lnbmVk
LW9mZi1ieTogWm9uZS5OIDx6b25lLm5pdXpoQGhvdG1haWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4g
ICBib290L2Jvb3RtX29zLmMgfCA1ICsrKysrDQo+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvYm9vdC9ib290bV9vcy5jIGIvYm9v
dC9ib290bV9vcy5jDQo+Pj4+IGluZGV4IGEzYzdjYjUzMzJlLi5hMGYzMTBiMTM1OSAxMDA2NDQN
Cj4+Pj4gLS0tIGEvYm9vdC9ib290bV9vcy5jDQo+Pj4+ICsrKyBiL2Jvb3QvYm9vdG1fb3MuYw0K
Pj4+PiBAQCAtNDAyLDYgKzQwMiwxMSBAQCBzdGF0aWMgaW50IGRvX2Jvb3RtX2VsZihpbnQgZmxh
Zywgc3RydWN0IGJvb3RtX2luZm8gKmJtaSkNCj4+Pj4gICAgICAgICAgaWYgKGZsYWcgIT0gQk9P
VE1fU1RBVEVfT1NfR08pDQo+Pj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+Pj4+DQo+
Pj4+ICsjaWYgZGVmaW5lZChDT05GSUdfUklTQ1YpDQo+Pj4+ICsgICAgICAgYm1pLT5hcmdjID0g
Z2QtPmFyY2guYm9vdF9oYXJ0Ow0KPj4+PiArICAgICAgIGJtaS0+YXJndiA9IChjaGFyICoqKWJt
aS0+aW1hZ2VzLT5mdF9hZGRyOw0KPj4+PiArI2VuZGlmDQo+Pj4NCj4+PiBJZiB0aGlzIGlzIGEg
a2VybmVsLCBpdCBzaG91bGQgcmVhbGx5IGJlIHVzaW5nIGEgRklULiAgVGhlIEVsZiBlbnRyeQ0K
Pj4+IGlzIGZvciBnZW5lcmFsIEVMRiBmaWxlcywgbm90IExpbnV4LiBQZXJoYXBzIFJJU0MtViBp
cyBzcGVjaWFsIGluIHNvbWUNCj4+PiB3YXk/DQo+Pg0KPj4gQSBkZWZjb25maWcga2VybmVsIGlz
IGJvb3RlZCB2aWEgdGhlIGJvb3RpIGNvbW1hbmQgb3IgdmlhIGl0cyBFRkkgc3R1Yi4NCj4+DQo+
PiBXaHkgd291bGQgeW91IHVzZSBhbiBFTEYgZm9ybWF0dGVkIGtlcm5lbD8gV2hhdCBrZXJuZWwg
Y29uZmlndXJhdGlvbiBhcmUgeW91IHVzaW5nIHRvIGdldCBzdWNoIGEga2VybmVsPw0KPg0KPiBU
aGlzIGlzIEkgYXNzdW1lIGEgbm9uLUxpbnV4IE9TIGtlcm5lbCBiZWluZyBib290ZWQuIFNvIHRo
ZSBxdWVzdGlvbiBpcywNCj4gZG9lcyBhbnlvbmUgZXh0ZXJuYWxseSBoYXZlIHNvbWUgc3RhbmRh
cmQgZGVmaW5lZCBoZXJlIHdoaWNoIHNob3VsZCBiZQ0KPiB1c2VkPw0KPg0KDQpodHRwczovL2Rv
Y3Mua2VybmVsLm9yZy9hcmNoL3Jpc2N2L2Jvb3QuaHRtbCBkZXNjcmliZXMgdGhlIHJlcXVpcmVt
ZW50czoNCg0KIlRoZSBSSVNDLVYga2VybmVsIGV4cGVjdHM6DQoNCiAgICAgICAgICRhMCB0byBj
b250YWluIHRoZSBoYXJ0aWQgb2YgdGhlIGN1cnJlbnQgY29yZS4NCg0KICAgICAgICAgJGExIHRv
IGNvbnRhaW4gdGhlIGFkZHJlc3Mgb2YgdGhlIGRldmljZXRyZWUgaW4gbWVtb3J5LiINCg0KQm90
aCB0aGUgYm9vdG0gY29tbWFuZCBhbmQgdGhlIGJvb3RlbGYgY29tbWFuZCBlbmQgdXAgY2FsbGlu
Zw0KYm9vdGVsZl9leGVjKCkuIFNvIHRoZSBjb3JyZWN0aW9uIHNob3VsZCBwcm9iYWJseSBiZSBt
YWRlIGluIGxpYi9lbGYuYw0KYW5kIG5vdCBpbiAvYm9vdC9ib290bV9vcy5jLg0KDQphMCBhbmQg
YTEgYXJlIHRoZSB0aGUgZmlyc3QgYW5kIHNlY29uZCBhcmd1bWVudHMgaW4gdGhlIFJJU0MtViBj
YWxsaW5nDQpjb252ZW50aW9uLg0KDQpVc2luZyBhMCBhbmQgYTEgYXMgcmVxdWlyZWQgYnkgdGhl
IGtlcm5lbCBpcyBjb21wbGV0ZWx5IGluY29tcGF0aWJsZQ0Kd2l0aCB0aGUgY3VycmVudCBkZXNp
Z24gb2YgdGhlIGJvb3RlbGYgY29tbWFuZCB3aGVyZSB5b3UgY2FuIHBhc3MNCmFyYml0cmFyeSBz
dHJpbmcgYXJndW1lbnRzIHRvIGFuIEVMRiBiaW5hcnkuDQoNCkNPTkZJR19DTURfRUxGX0ZEVF9T
RVRVUCBhbGxvd3MgdG8gcGFzcyBhIGRldmljZS10cmVlIGFkZHJlc3Mgc3RyaW5nIGFzDQphcmd2
WzBdLg0KDQpJdCBpcyB1bmNsZWFyIHRvIG1lIGlmIHRoZXJlIGFyZSB1c2UgY2FzZXMgd2hlcmUg
d2Ugd2FudCB0byBleGVjdXRlIEVMRg0KYmluYXJpZXMgdGhhdCBhcmUgbm90IE9TIGtlcm5lbHMg
dmlhIHRoZSBib290ZWxmIG9yIGJvb3RtIGNvbW1hbmQuDQoNClRoZSBSSVNDLVYgbWFpbnRhaW5l
cnMgc2hvdWxkIHJldmlldyBhbnkgY2hhbmdlIGZvciBSSVNDLVYgaW4gdGhlDQpoYW5kbGluZyBv
ZiBFTEYgYmluYXJpZXMuDQoNCkJlc3QgcmVnYXJkcw0KDQpIZWlucmljaA0K
