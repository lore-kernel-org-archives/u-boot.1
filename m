Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71721C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 09:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DA680F53;
	Tue, 25 Feb 2025 10:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ImO3U4uQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968DA80F56; Tue, 25 Feb 2025 10:58:10 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C1C805C3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 10:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpfUYa+Mg+2+l1SRySYBib8nMBC3he2wKrNw4tO9DDoMYf/MOKRFDVMwnOATXb77pJFqkoNvB/UFoP3C32kEAqhVR6jS9WrXH/3If3hsxA7NvkL+lkVEmV1b2M0lGCI/yE1etqaqkRHECqx5TjFmkvyrhUJtDeO9Fwc+NGviXOQ+gKqlEDT31fKfP6c5acdA0RdJ/1Gg0gjxqt6CAe6AfyWoi43l4oYhcSjLAXgvIpPzRcTwoJcJT1oOcf6AU/MRmiTrXSXG7rj9Lr5joDSTXxM08vJWptfvgwwGKzJBS1pX1lPwkRvPCV7zWlcDoVlXzdnqgH6P/tPi0BPYNePNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qt6ho2XFhuDBy2E052H8DpxpZQpBwUJUEton/Z405U=;
 b=uGl0Np/O47PFqFViG9KAF7NuJjTu3pC5dBGBxv0TpE+hUztgYtVUptHHitg1CrPJjMG0q0sCt+zSAxxPz8ZVpf1gZ4PrLiqTszLQxCBfY2FIcuJDrHjcwp3o80c0xWyZG34Nfpi4g6rLa6t/z2HknOoaRgbQdg7BKwyDIPzM0Gu+akrR2R6ukU0fKF9zzsq6IfIGLcNiarT8zxBW+rBD2I2U5PGyRu557/2v3XgbQ2aOF8CgYGOZzSZCbP+M2qhE9fFwLdlUQX68bDvXA85/xVx3ZzpkA/sP2/Ot+b2txEzC2AFgtclybvOM9zllOFjBK+rqDtkeCC5wmHrYkbX3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Qt6ho2XFhuDBy2E052H8DpxpZQpBwUJUEton/Z405U=;
 b=ImO3U4uQqFxnB5stF9GuCiZR6/oaRtsy79IjqudtIgoMYaiOIeDSBoFVdsDTsUr2VNRAnxD0gQyCe7ypXOnfPRpixqgHGbTcejq+bhNlwTKRcW2d3oCkHqlcgQWG7e1pqS2wtWt1W7Nh8FLxtPFTGSofCUISMk6CYBsb50u1tyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7562.eurprd04.prod.outlook.com (2603:10a6:10:1f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:58:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 09:58:06 +0000
Message-ID: <ed721621-1ea0-477b-acdb-623711157f97@cherry.de>
Date: Tue, 25 Feb 2025 10:58:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250221184732.202336-1-marex@denx.de>
 <94cf226a-c217-4e5d-bc63-60f5b7c4cb3b@cherry.de>
 <06a60d0e-bf29-4acd-8728-4abf40248347@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <06a60d0e-bf29-4acd-8728-4abf40248347@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ce5532-604a-40c9-243a-08dd5582e685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTFIa1hPdmR6Rmd0Zk1yUWV6bS9CQy94b1p2dzBwUElXdkxDYkxlU1QwZ2Zv?=
 =?utf-8?B?alI3bDRnVVpJRFk4WmFtTWh2YVczOENwaXNXUFJROEF2ODJKRkdZQldiM2hC?=
 =?utf-8?B?c2dXT2tzN3d1ZVFMMS8yUzlRalBhOFJWb1B6L0k1bGN1MDFaRnhOR283d2hk?=
 =?utf-8?B?aWVCSEdNa05KVUU0eGJ1VzdrY1lremhhTUZvSTFQOUI5RFRCYzNHYys5YXox?=
 =?utf-8?B?dGNGU2g1a3Y2REY3SkR0dkFMc2ZSQmEybml6Wng1SjZNQW1Pay9wVHI0OVdy?=
 =?utf-8?B?ZDZKVGxoSFFPREpUTUJaSlhnWjZYeDh1N1JTaEQrOVdaUVArSkRHa21KSktF?=
 =?utf-8?B?anRvTkVWSzB2V2dJczM4YUlJVXZUSzJVb0pwblUydFBtclYxeTIvVkJhN2pr?=
 =?utf-8?B?cGM5cmtxQjBtZzQ2S3pqbnZST3NNNEsrTFM5Ulc0RXZEN2ZFVXBrN2dBWE80?=
 =?utf-8?B?R1JYOWpadU1XaU5hanZWK3pSWHBRRmh3dGZxWnRTeUZyQ29QZzd0dG9qTjdt?=
 =?utf-8?B?aU83SG5kQlFVelczMTN1ekxEb1VTdndVY0N3MnlTL0twb1ZpT3JRc3UybEsv?=
 =?utf-8?B?cHJrUXFoTUhEUWlIeWROZUc2MVBEd2puaGdlUG41Q2NWS0UxY1lvNzkyRDYx?=
 =?utf-8?B?WDVORStzUTRDWDFtQkM3c3djWUlTNlRnQmNlaTJ2MGhPa1RRajNZcmRVNE1I?=
 =?utf-8?B?Y3E0VWNwd0N5d1haRkVma0ZQWnlzU2hxSi9tWmh0Vnp2NDhuRHhHQlVRaG9r?=
 =?utf-8?B?bUpBb3RHN1VoNUVGdGhjd2NPa0Nvb3pCQTN0ckUrSjQyTVNoU29DRDNoSmcw?=
 =?utf-8?B?czE4RVFpMzlnTTFGQk40NDR6TEIyQUNhbzJ0U3V6WDhNajZ0b01KTG9BV3gv?=
 =?utf-8?B?NjdGSVUyY3FFMnFrditGdUhIemZ3V3BERnNrZzdiZEoyYzlIMkZTdXJXdmRW?=
 =?utf-8?B?cklDQlVCeDVndWQ4eWZINnRkVmJMdkpEeU51T1dmamk5NUNKWHVjYk9rK3h1?=
 =?utf-8?B?d3hlbE9YWXBXdzlWekhoblNWWlNPRDNCYWRlZVppb0xPaEtzVDFlVVJ2TVRw?=
 =?utf-8?B?MHhVZ3YvQmtibVFiYk5zek1IYU5oSjFxV0JobW9ITVpaaVIwaFR4RUpKem56?=
 =?utf-8?B?OHQyYjVoRjdvRXE5VjVLV29oQXNqMWt2NWRXRGdhMjJxK21xRGpJR29lWmRi?=
 =?utf-8?B?TllwdHZZL1ZzV2g1WDFVSmJQS1EybWI4YXJHUmdoRU1FZmxjT3hIb3NOZ3hz?=
 =?utf-8?B?SWpxR0ExMlN5c3RzaHRDM0JrVWd2dU5Zanl6TTNjdnc2UGpkdEpOOTR0ZVdx?=
 =?utf-8?B?cjRjbXNDWmxuZ1FXQkZHSXJDeGF6QVYwSWkxVFJDU2tQblU4QlJzVVFPRXkz?=
 =?utf-8?B?YUZCaEtqdXBwb2poOWFMeENldXBVWUNwalF4OTNqRUtxMHhCMmQ5M3FldHVG?=
 =?utf-8?B?V2xhNG81U2pSUVlWNHJIczk3a3lMcVZoS2IvK3dGaDR3SlQrZEFmWWhpdHNz?=
 =?utf-8?B?RDI3ZWs2RjhWdTU1dTlFeGZ2cGsyK0dlSFR3OHI0ak9xRXVodkxqNnh4NzNz?=
 =?utf-8?B?VGRxaEpnbjNPRmdQd04xcXA0dHBmNTNUWG15eUU0TzA1K0xBa1pCcWgxM2FD?=
 =?utf-8?B?bDYxcTUrRWJNTVIrWEZROExCTTlJSmcxcnNHV1V4TzYzWjZNNndDS2x4MUhH?=
 =?utf-8?B?UXBHTXFhM3RIaHM0YzEvVDNsb0FuVVVvUFJUYzNyUnQxZE9qcU80dlQ5dHhX?=
 =?utf-8?B?OHBZQTN5SHVEY1JJSVV3Q2RJQzlCelJUdHQ2Tjg4RjI1Y0dHcFlaQ2tCRnVJ?=
 =?utf-8?B?NEFVNk4rN2c4Y3A3S05OUEdYaEpwL0dUQ2NTWDRCNmRJUFMwUm9Xb3pNUXRk?=
 =?utf-8?Q?s4hr34BUQzHYg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZIMWRodG5mMkJ5alRBT0tnQWhzY09tMGtISUUyTFdxbitKZ3pwcjA0SU91?=
 =?utf-8?B?eW5wNlpBdzdIT0U0M1JqZUdjamdVK1B0LzhzODBvekxXbG5IYmcvTjRxRUhH?=
 =?utf-8?B?S1pBeFRJRXIyZmQ3RHRZREMrMGdvRWdsTUJxWXAzaEkwUmdHblJQcnlITXR2?=
 =?utf-8?B?Q2lkZ0t0SUl0eEdNUFdnaHNWem9lc2t5VjRvQ01SVEVXRzA5SnoxU2ZvMFNW?=
 =?utf-8?B?Q2JqZVRBNFdxZGN2L3VBbldFVGh2em4vWmszZjU4YnhFOHZkbWNjZXdrR0RD?=
 =?utf-8?B?WUJtQTBWRThINzR4b2d6SG1WeW0xamg3Rnk0YkxKVjFGN290Z1A2R0U1Ymk5?=
 =?utf-8?B?bnZwaXgwc1V1WTIyUXNjNmdHYTc2TU9Gd2ZUbUJVSkExTGp3ZGFOeTVVWHZ0?=
 =?utf-8?B?QklrRkNxTVlScGtMT1dHa2RZUlRNUjRrK2VlUWR0bXVTaGtvY05RNGtLVmRm?=
 =?utf-8?B?WS8rL2szRUFKRFcrVUpSenZTUGswOG4yNGJqYk5sT0JZVUpFK0w2c1ZwcWRE?=
 =?utf-8?B?aUx3ZmdqRDdRZWVyeCtEcy9TS3lOMWM4VmJFaXo3aUVGdGdMYnF0YlBQOHEv?=
 =?utf-8?B?UUMwMi80M2s3WEcyeGlLWEtiZWJPczVERFhLRE5rcjQxUm9ZN1VaK21wSm5s?=
 =?utf-8?B?K1BqWWFwQ3pCaUJ0TG5SaHc0ZVAyVGZRMFhwWXZ5bFBSYjFya3pZS0VNNEhw?=
 =?utf-8?B?TzducVQyMFlTQjU1NXU5YmFhZ296S29JTCtzVEpLRkF0bjBaRkkrY0JXWVND?=
 =?utf-8?B?YXU3Uk5yUjRYVC8xeElGVmRaVnc0Z29ZRXNuYnR2am9zbHByVTQ2NFRxWVJa?=
 =?utf-8?B?SlhvWTBjdEdoRk1NWHVkSDV6UzcvOTZIQXBJUFY1N21LTkIwL0gwNS8wRzdW?=
 =?utf-8?B?TWhGWmN4cFBlazdCcjZ2TXA3NVNmQS9XYzFRUXgyVndlTzZucE9pOVdxZEh4?=
 =?utf-8?B?a2pqMlh0LzFnL0gzZEt2ZEJHdk1pVWgyZ0s3ZVZwZDVaMEV3SGdTZWJqdFNH?=
 =?utf-8?B?cjY2WU1sYTRuN3JxdnowcytTVHRFNlZqcEVVdnd6T1VqY1JxT2hOUUFrRThy?=
 =?utf-8?B?Wkkyb2RaLzZDZG1jbkVhQm5vTHVhMjk1aHp6T2hUcEJ1clh4VlpkZWlxa3VU?=
 =?utf-8?B?bmJ0dGZrTlhYTi83YWJPQ0xMdFpEbUY4K3BFRXF5OTFSVVQxNnVSenJtUnp3?=
 =?utf-8?B?Zm42cmRsQldWb1pVbS9EcTFCZ29nSHovd0VmNldEMlB0UFdGemxFcHJOSzg3?=
 =?utf-8?B?MklVaTVpY2svUE9TY3dhamcxTWkwRUdNYTBhSi9qakVNUW5IcnZvR1NLeS9o?=
 =?utf-8?B?akF5RjZSM1MzenovcTk3Uk9IUGFxM3FxOVZPTWN0Z3dxNmcxS1k1R3d1b0p2?=
 =?utf-8?B?SXRSdm9qR3EwZU9iZ3p6dE5yakZDQnFhTEErQzFXUjBzdmZlTjVOMXMraElj?=
 =?utf-8?B?QkRMM21zYWpDYkU5RVk5eXRHcUdWTEJVR1YyVUZ2a1oyT1hBU3lCYzVlWFRv?=
 =?utf-8?B?bkV2ZEczdEhiVWx5N2wxZ2d4ZUt2VEdSUHNBZ1NTV1pEaGZlNyt2V2RIbHlv?=
 =?utf-8?B?ZlBYd3hCU3JHOGFGU3BMZUhJdmpwV1JMTXA3RDhqa3JnUnpuN0xxQUxFWXpP?=
 =?utf-8?B?SlppQ0VoQlBoOEtieHNneW9SME9EaTFFUkdjcFdxSUhvaUdqWC9GcVhIeDZE?=
 =?utf-8?B?UnBQbFJNN1FqMDd1NUZrMDNici9CdEU4TUZDVEMxcmZxcTQzeDFtZkxHd2tH?=
 =?utf-8?B?ZzhpMWdGVHJJSEl2WG1vUG9iMkJIbTZPaEZDc1ZjRjVuNVBaT0lsVVhhak5J?=
 =?utf-8?B?NnNRS0JGcHhUaU1NdDNNTG9uaFVybDE4VmRoOWJON21OQ1NiN1JEZUcvTUZO?=
 =?utf-8?B?alFmUm9nemFoWEtpWmpTSGRCSWNmbWJRZU1RWTFWdFNiaWxQM0grbHZ6Y0Y1?=
 =?utf-8?B?QXUxTXFjTTkxOXlHRzc3RGhZMTBmTmhaYnl0bmJHekFPQTFjY3RsKzMwZ0xj?=
 =?utf-8?B?U1ZRZEpmdVduSUJWZXFuS0lvRWRXUzl6aUd5N2JVWHlaWE9sVVFTbGR6Nnox?=
 =?utf-8?B?STV3UzlYbHk2bmI2SWlCOGhkdjZsc3hpS1BLVkJhZjZlWDNmSTZuUjVPN0t5?=
 =?utf-8?B?YTFScW5TNjhqZ2hBeGdTZHc3NjRWWi9wNG9UaWxKWjBDclBYOTVFMldLd1VF?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ce5532-604a-40c9-243a-08dd5582e685
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:58:05.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYDhBz8eGq2IWUhZUETNrQIzv01DqQ9x44/DuIlILrtckRL7+5Q9M/+qy+msixP2Y+64nS4rgoZq7AG9AQBIoIowuKDADS6pYpiAM/MXSik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7562
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

Hi Marek,

On 2/24/25 6:49 PM, Marek Vasut wrote:
> On 2/24/25 11:01 AM, Quentin Schulz wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On 2/21/25 7:47 PM, Marek Vasut wrote:
>>> Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
>>> which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
>>> almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
>>> did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
>>>
>>> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
>>> in the last conditional, which does not do plain macro compare
>>> (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND), but instead does
>>> mmc_offset(mmc, 0) == mmc_offset(mmc, 1). If OF_CONTROL is not
>>> in use, this gets optimized back to original macro compare, but
>>> if OF_CONTROL is in use, this also takes into account the DT
>>> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Dragan Simic <dsimic@manjaro.org>
>>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@lists.denx.de
>>> ---
>>> V2: - Rename mmc_env_hwpart_redund() to 
>>> mmc_env_is_redundant_in_both_boot_hwparts()
>>>      - Return bool
>>> V3: - Hide the mmc_env_is_redundant_in_both_boot_hwparts symbol 
>>> behind __maybe_unused
>>>        as this symbol is called from code gated behind ifdef 
>>> CONFIG_SYS_REDUNDAND_ENVIRONMENT
>>>        in env_mmc_load()
>>> ---
>>>   env/mmc.c | 37 +++++++++++++++++++++----------------
>>>   1 file changed, 21 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/env/mmc.c b/env/mmc.c
>>> index 379f5ec9be7..353a7ce72fb 100644
>>> --- a/env/mmc.c
>>> +++ b/env/mmc.c
>>> @@ -40,18 +40,6 @@
>>>   DECLARE_GLOBAL_DATA_PTR;
>>> -/*
>>> - * In case the environment is redundant, stored in eMMC hardware boot
>>> - * partition and the environment and redundant environment offsets are
>>> - * identical, store the environment and redundant environment in both
>>> - * eMMC boot partitions, one copy in each.
>>> - * */
>>> -#if (defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && \
>>> -     (CONFIG_SYS_MMC_ENV_PART == 1) && \
>>> -     (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND))
>>> -#define ENV_MMC_HWPART_REDUND    1
>>> -#endif
>>> -
>>>   #if CONFIG_IS_ENABLED(OF_CONTROL)
>>>   static int mmc_env_partition_by_name(struct blk_desc *desc, const 
>>> char *str,
>>> @@ -217,6 +205,23 @@ static inline s64 mmc_offset(struct mmc *mmc, 
>>> int copy)
>>>   }
>>>   #endif
>>> +static bool __maybe_unused 
>>> mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
>>> +{
>>> +    /*
>>> +     * In case the environment is redundant, stored in eMMC hardware 
>>> boot
>>> +     * partition and the environment and redundant environment 
>>> offsets are
>>> +     * identical, store the environment and redundant environment in 
>>> both
>>> +     * eMMC boot partitions, one copy in each.
>>> +     */
>>> +    if (!IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
>>> +        return false;
>>> +
>>> +    if (CONFIG_SYS_MMC_ENV_PART != 1)
>>> +        return false;
>>> +
>>> +    return mmc_offset(mmc, 0) == mmc_offset(mmc, 1);
>>
>> This is not always equivalent to the current test of
>>
>> CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND
>>
>> Indeed, it only is for when OF_CONTROL isn't set.
> 
> This is what the patch fixes and this is what the commit message states.
> 

Sigh... Should have been as careful as I was reviewing the code and read 
the commit log once again. Sorry for the noise.

>> I would recommend to keep this check in patch 1, then add another 
>> patch that swaps CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND for 
>> mmc_offset(mmc, 0) == mmc_offset(mmc, 1)
> 
> What benefit would that bring ?
> 

1) rework to not use ifdefery,
2) add support for OF properties,

If 2) becomes an issue, easy to revert and keep the move out of ifdefery in.

Considering the change is documented in the commit log,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
