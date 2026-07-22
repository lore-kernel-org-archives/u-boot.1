Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E0DC4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 17:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EB6680F33;
	Wed, 22 Jul 2026 17:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BcJeu8_EVQQD; Wed, 22 Jul 2026 17:54:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB8ED80EC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784742842;
	bh=mX6MydHGdY7tPmTc8E/P0jE4dJ2XcP42emv+9rPQ6kQ=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KZg1+hDCnMEfabMAkJKXg9CxOa/2YfOcXAXf1rNtaT2hbb82bDT+t27FnKb+vPSkU
	 K5g+MH5QwUhiRiunvhEgg/9bBIrTjZBEel747d2XSHqBJ6HU6MYpNo3IbpcCBUXDqw
	 y0Y8kIrq6KjCMF1YkBor4wjDk59SuJjutzyBPPNj69FJeMyEGUk4TAG1Xst1IA7+zI
	 OdPduRJ519kVlwjJsW+JLyU91nOCqqV3A1erALstVhMMP5iuLMkrPU7PNUUBrKvyjF
	 DwCd5cWOmzZdH9BVBiB6ScgNpHmCLfTnu9vOmVsh2d0V2kZhV7zr8CLa8f5TkvySAU
	 0HxkW4+uceq3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB8ED80EC2;
	Wed, 22 Jul 2026 17:54:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE1001B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94013605E0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cdOHVK4UCjVW for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 17:54:00 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3D5F7605D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D5F7605D1
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D5F7605D1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:54:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE249846A4; Wed, 22 Jul 2026 19:53:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1538C83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 19:53:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji+WUN5E25ZdB3oJur41Efk0EZGE7SsmILxpY5fp8UbNxbCOlQ9cdR+DJHzCmZ/7mz4FsirlpMfVjj6/xq3HB1hpuGDxzEykj9sUCMwBbH6Iezn6hYVuH8nWkpOhY5SD3rwyBkbbqLMhoevc155zvBmwSHKtird2lHF4RC/q8bKxR9pNTX2K4yNvcKpLQg7Ts8So67vIzG3OvLBa9wGI9vuH3UuZTZRCGfaP24H0cRqJ4mZt2n5tzcdUkDGxUqXN5CePqiXrbif26z6k4SpE0y2FvHRrWdD/7SdFiJyEg7ISsg1Kz486tq6063lPfhepXJJ++IY3kQdLx13351FQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX6MydHGdY7tPmTc8E/P0jE4dJ2XcP42emv+9rPQ6kQ=;
 b=JnmMphvleNO02IW/o0dVFBOBg5oVV7HboTMH6YVeaf9qciXqGFCoh497MCBA+t7vfhsV3IGPfVRZddTMBwfHprzSJP0XFniB57w2Y5gr8uux4P4h9UDuPLzlUESIok7N9VRr/N3z3EXXgNuMp5nWvyQ3iMgVtZYjfNOp/gw8SPuq4x4FOqKjnRKACuHvUVk6TH7cZxJuO+PpaXSuNMnvGbMC+AIdh08NZ51UMJ80gFq161HBvkJ//l7UhLRYk/va4DKU+A4uAq1FesIbUsCUr1qqvOlULN/Nvf90JmuS47UzKlPgkTosNOxhKz2tSBNhBXHuBhv7LYlQK+16EvmjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:53:54 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 17:53:54 +0000
Message-ID: <7f3408bd-ec91-4819-8053-650c253de133@cherry.de>
Date: Wed, 22 Jul 2026 19:53:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] rockchip: pinctrl: replace RK_FUNC_n defines
To: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 u-boot@lists.denx.de
References: <d5752c9d-eca6-4ee4-a0bd-52ffc8103976@gmail.com>
 <51cb65e5-1702-467f-b961-c9cdd029056f@gmail.com>
Content-Language: en-US
In-Reply-To: <51cb65e5-1702-467f-b961-c9cdd029056f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0059.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 5720ad6e-ebb1-42c2-5d09-08dee81a323b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: seRhGf9Ko7bXGaztEBNW6BqkFlvNrAxKsi/anbYdn+6jeV4pc/R17OaiyLdEzw55y9Iq6on7b9+9/uB7M8hV+JadHLIR/jIVn2yWgn40c7EgwGQ2yKbpDChCa/2sFX5dZfDIRwARJHqczCacgAryeSkixDOvU7/T0+5+B1TZznQRZuMURAJID2JYkRLwQWFZthelFZQz9esYuCf5IAGrBFoPP9ilWZ51Atl4lbKSorMU/NRLAvkFm9ERmIbmuMh4GUOE8avkTOE6XgiE8GIidxhe76rH0d4toSuqQUJD7wS6F9nvPkWoY/tUlZ3v5oxFxTx9p1YVz7pe+WmvKNfnTvRVXhpr3N0veLmrx5P2aYbH1y5jbg7ucx3eAbdN1ucxJtiIiJXmRwNQV681/ZpS5LSxBO87tnaXuSK+dloG7jono+N84zOvdgUCi5w+8NrzoFSWGb01hBFOi2FJVVbGA1/AGRAgvFk6Hhm0MK2Lj7W/PBavW49Il1IrW86gb4VJh5O5jbv0lj/LOuPsbiBQrvEdHf3NPHXcaiw1CSzRRHJYKlvoA5X06JbGunpzhFxRes0Xkcn6aYhyXjdr4825av1iFNB3PDZ/t0ybdW/GYBlwoknsRjcbdw6eTqnVwJhCTFM/3Zs43joLl6rzBze+R1QuH2Y6scswYBX8lfeJgaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hWTExva0xnWFRYQlpQZFFiSHd6bVMvNmJEcHAxZXJsalVUNDZMSWpIbGpU?=
 =?utf-8?B?ODhNTlRhaithTndsN3NPM0huZU11b3FpWGlicTEvcnFXSmR1SWg5bWEzd1N4?=
 =?utf-8?B?TWVKSnRWTmVSazhwUW91TEsxdTlGaGpYZFE5NnpiUlVIRGJrVElLS3RaUHZ2?=
 =?utf-8?B?TFZ5UWZuRGN0clJ5L1lqbitpZWpNT2ZMTnB1dFczWHdIdW5ZU01pQ1pkZzZx?=
 =?utf-8?B?Qmt2K3lUTWlva3Rmd1Q5Z3dTYThvcXVmSitWcGE4Y2liQk9OcEhXY2RxMWNz?=
 =?utf-8?B?RTZWUW9BbDdZS2Q3dEJlWUNMYVo4Q0VZSjBSaXhXUENxN3grNTFGd25nUUJU?=
 =?utf-8?B?NGc2WWdnU0FOK3o3cGdHb0tWRG5Tc1A1c1RBeW1oQ0kxUTFTQk0vVlhXWDVV?=
 =?utf-8?B?SlJtSldMZG0vM0Qvc21vWWRhdzVCK0J4aS9HV0o5di8rem1NK1NFZzVoV0l3?=
 =?utf-8?B?ZFNHOGtscHpnNmZTbldYMmQ4TEErd0gvQWU3SjltVTJiQVBEK0ZrNjdud1Va?=
 =?utf-8?B?aXI4S0lSdk1sK0VRbUdvSWYwY2ZwWmx5bDdodW1BNjlmUHhnU25iby9ZNGw0?=
 =?utf-8?B?dWhHQ3RSS0hzR1RQd1VtaFhWMlhaWWFZaFVxWFNFTWkvbHl1MS9jblhRNVAz?=
 =?utf-8?B?bXpmMm9DKzMzTFpPckNHM0hzM3plMk1iT3FGdG5RejFrSS9IZDhhVFVwOU9W?=
 =?utf-8?B?eWFwNFZUV1ArdUd1bmFZSmJaQ0NZUFVLaGhQRS9EMk1PRnVtamNxVVZZL1g0?=
 =?utf-8?B?L3preGFJdVE4ZytBNlVObC9SMHhJWkZFT21ZWVAyd3hRd3dycjZibElyN2FD?=
 =?utf-8?B?STU5Vnd1bWJwK1hIMDA5eXloaEZjWTh0UmVaY0dsWmp6R0daQS9JK08rSDVp?=
 =?utf-8?B?VXlNYlNIVThVRWRqaFQzTE5sVlFkY3VpT3U2NERMekpyRDNGUktibVpaUmVD?=
 =?utf-8?B?R01jUGJnZ3UrdVBudWxsQTFybUIzZVdSNjJnUFdJT0JBbWhjeXIrcDJLS25l?=
 =?utf-8?B?MmI2OTVLbWUreXFQNDl4TktoRStSNnJ2V0pXZ1V0TklHVDl3bW1DcDFIUy9j?=
 =?utf-8?B?VVlqNDhmcjl3NXNSU0hGc3ZMekIxTkxweGNRQ3JhbXVOWTFlMk9DRk14OUlD?=
 =?utf-8?B?WjJKS3VneTBMR0kvczR4ZlI1VkM3Ly9Vc2lySTlSN3dBZUhPUWRKRXhrYzhK?=
 =?utf-8?B?ZXNiYkxoalJ1WThpTkpoSEdrRFZhUk5xOGtMR1RHekxEbGMyZUNWMEE5ZHRE?=
 =?utf-8?B?MGtBeXlSSlBzeTc5NEF1SzVKNDhnbXgzR0pta2xvQW52ODNYMU4rbjQzRTRr?=
 =?utf-8?B?MWEyZ2dKejlNSnFxemxQUEY5cU0rWmlZdVVNN1czbW9BK0hPUjNWTWQ0M0Zh?=
 =?utf-8?B?ZFVCemwvNTlHSDZaZE1SWk9kb3pRTXE1NFlnYlhRZHd1U2dETm04RXRoQkZh?=
 =?utf-8?B?OTRjQS9uV0ZvUlVJTmhEZXJiQU5LOUh3bmV1cGlhc2RPZHp4RGZ6T1Z5VkVM?=
 =?utf-8?B?T1F6dWY4K2FNS0h3cjJyVStXVVE2M3JMMFpFRXd1MDB1WGxmYWdQcWpqWXpz?=
 =?utf-8?B?STJCTWFrQkZWOVVIbTNHODN2V0dwZjAxME4rMzdKSE8zUHpWZmpubENwdHNQ?=
 =?utf-8?B?a1Fva2lQYW5XOGZ4Z3B2VzU3SFg3c2E2TjFOSGZBNm4rTENNaXpDdGtlR0Ry?=
 =?utf-8?B?cUFUTzhhZzNLdjF2SVNrWXZ5bGwzaW1XQnBiNk43b2tXZThpK1p1OWQ5N2Nv?=
 =?utf-8?B?ZFhqdUdUWXlxTTRPSGZ3dmUrRGpFaVdydFhJRFB3aEtWTmtFM08yaXAxZllB?=
 =?utf-8?B?MkNGdnlyTDFZajdGZERpY3NrSHBEbWpqSC8wZ1ZvVk5BODBkcGxuQmYvQlNB?=
 =?utf-8?B?c3hLNW10b0lPOEtNZGNMR2pvYXVWSFJtcytOcG1BVzhud2xWcFg5djB3MWVn?=
 =?utf-8?B?MkMwTU5yOTBkU2pTZjRVS29UQkVDeFFkYjAybnlneU9DbkROQUZzb3VUd0Uy?=
 =?utf-8?B?bkYvWStaSVBQZEhUazlMRWpZNXg0a1JRYkEvNVUzcDJmUGxWb0R5WnphNVlv?=
 =?utf-8?B?OXNTYncvNktMaDMyZ2xhRmIzblFsY3BNbDhEczdKblE4S1pkRlc0OWlVQ2J6?=
 =?utf-8?B?U1VuWmtIR3cxdkh6R0JGR2NwUmZkbnhGcFZhS0NqREVJbVh0QzI3cWY3dFNU?=
 =?utf-8?B?QlA2eWdnZ3Y3M2g0NnhMQXM1bitvbGdPUmkwOWdVWHh4M0tWMzMzL3gwU2dw?=
 =?utf-8?B?ditHRENIbVFPd1hDOWRQSzFPQ0txSE1IejdjYmYvOWk4b1JXQkh5bzBVMjNC?=
 =?utf-8?B?ZkFqL08waEgvaERLVmpUREpOYUJXblNyMDR2M0dhWmdOU3VJL3JEQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5720ad6e-ebb1-42c2-5d09-08dee81a323b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:53:54.5385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/tURhRHLC4W9jDZF2zLk0icXyfF67n7KNW72QTqxxs1qN/1pj1uc5hdX4SsxyrFmTtlIeVUm1b5V82jnekLr8U+D66Eexm8PAMMuOLCLSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX6MydHGdY7tPmTc8E/P0jE4dJ2XcP42emv+9rPQ6kQ=;
 b=OyGCjhb0UMTYKzMF+FXMdZvBYe+zGTkq42dWmfsrh9DIHqCk3j/JCZP/nAxVo0ZK/qY8GZ/tbpFJArqwKIuFczVkgajhlLNN09IpWfv0Ph16XUmxb4MkHZKHj5Ou7l9m1C9HrhQhNggxSYHup3nHMHevMMjwMwWvqNsFyVVLpl0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=OyGCjhb0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="OyGCjhb0"; 
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

Hi Johan,

On 6/9/26 10:22 PM, Johan Jonker wrote:
> The use of RK_FUNC_n defines is deprecated in the upstream
> rockchip.h file. Replace all them by the function number.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
