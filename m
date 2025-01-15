Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CC1C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7705880040;
	Wed, 15 Jan 2025 11:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Hh48V+W1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A537800C2; Wed, 15 Jan 2025 11:34:50 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4CF80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG26TqMp1CiyuSL/ql3PxyMUy325kuOHN5W1qjNgMJgIvX4R++2rx3dPrEgaoQmJd34ZIBBYNgYJMnnJGaEXz6kmvcOrq5mXTQ0hdEZhXS8Svt1NalC04KcH5HjXAvn5vE6XaEkxPP0lLVGCYIXL1ogF+n23K58loJc8fM/azVOHmLFOpWRvb+LJ+kP9fjWfZ5CcdPE/0nS4DEAdCmjKinJL56xFTuU5pPgucn6o4obJGygwvMJK2y+PvhQ88MlYAzoES+EFdanzMmjJTKa37EYcQuK5TtmwjvnWe2hO4sL3BiV6bTlJitoSghvTjK9Ui9bAe4YY7FkiMqJjtNJurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm2EWbVbQnpikms+tEpwyoqRRSeP+VWqbbp1xC82dnY=;
 b=W+ainHMHx3a7tViHwJa+cQPGXc1/5/S0KQ+USUGvdSXcMyTBsUTYwLegOIXYzwzZzCxuQoHE/YUfrMa8zl+luPQkR6uEA8Q1ozxmQF8RMXYoVlNtTainF9Ws0fhV4Zi818QxdHU1QUrDYxOci6eHL4uTs6LQaOMHExv4rYZ8jEIN6QV7eymbfSBVdCdX02qawCr6VPFWcc+ImxZb65wCS8lELUVbZD2jEWgiggOHBQPlQ6yAKwVDM81Smu4khCV1a6AwGBZUDew93Jih7Ja+DcpyYQYLRoe3lDU8O5YKYxMmdrBtJNfqpaXXrR0uZiysUMrfPcObc7heESy3L6l4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm2EWbVbQnpikms+tEpwyoqRRSeP+VWqbbp1xC82dnY=;
 b=Hh48V+W1D5zIIO6cNutUOaLtUPoUmE3rzHsF6LpYsoOKMiDZV+Ezqrkncga/nLoNEjflWm21UhzOUYqt2NjXdtvTSGHwJ68xV5TgDa+/boa6ebH6HaSwgoADppd/AteXS49GF9ka4eWSt6vevYiv38zrU8OwZDaoGbAQ7RQDcUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 10:34:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 10:34:46 +0000
Message-ID: <b2ed3bad-9c9f-433e-979b-557d646978f3@cherry.de>
Date: Wed, 15 Jan 2025 11:34:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: renesas: Deduplicate R-Car Gen3 and Gen4 SPL
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
 <20250112223528.179828-8-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250112223528.179828-8-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0012.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e92d85-c864-4662-df9b-08dd35503b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkViTmtzNWh2NkRueHRadmJJQWNQUkNiRUp4WWkxNnBiZEpuQitPTXk0a2p5?=
 =?utf-8?B?RWEvdE5XVTJBUkkrM2w4ckwzM285NG8rQTd0Y0lxOUlnSUEvRksvcUtQcnFr?=
 =?utf-8?B?T0M0UWMyWW1aWGNGNVhtcVFXRHphVWNqbEFyejdiRTN5QmVqOGRibDFZejZE?=
 =?utf-8?B?OUM0aEZSUEJmb25GTjBWdDFNN3J4RkhHRkIzTmh6QkI2K04vbkw2Mlo2OVcz?=
 =?utf-8?B?QWhiRWFsUG5MZEtHTVNmZTNvNHN5Yk1rZyt4NEx1ZnpibFh5akxtalFIcUZx?=
 =?utf-8?B?MEVLcEFVMGYva0tOcnhzTFh0M1BhaFNLSEdIS1hqd1ZSNXlWbmROVHhaV2ZU?=
 =?utf-8?B?OVN2Ry9DR1JyRWQvTHVUOTc2UEdXck1zS1Z3YS8vUllYTGUrSGxpOFNkaWY5?=
 =?utf-8?B?SFVLdmZob21vV3BnNGJjS0dXMWliWWExdlVqK0pFcE9HNy94SGJ0WDZYMDZY?=
 =?utf-8?B?V2UzeG1vSmY1cFhVM01mTU5DTldBZW1UbE5EdUJhUjR5UnB5TmYxVjhGWTdj?=
 =?utf-8?B?dVczT3diYWpnbFVoUFRoODJmYjhCcDBKVWNHK0Q0MGV0MG9hYzlyOEQ1bWJk?=
 =?utf-8?B?ZGp5RXdKY3UyWkVYRXkvZGtIWmlPZXdnWkJXODhFZU9GcExvTnN5blpjVktY?=
 =?utf-8?B?bW9mby9saEFRYTVYaWtLdW43ZFk5cnRtbWM5N0g1blhIQXpseUxuZUhkU09K?=
 =?utf-8?B?VDg4RVJ6ci85bEcrNThpeElWN3pkd3kraDRVeko4d3k5ZVFMb1lFL3hKUUNW?=
 =?utf-8?B?QldMdnA3SzlsNFhwditOVGVianU0dExuQjF2bFRRbmo0cGQ1WmhaaTJ6VWV2?=
 =?utf-8?B?Si9TMGtJWkxJTlNtNkllMzFWbS8yUVcra0FBQUg4OWprVWdVUm9OeDU2cVRy?=
 =?utf-8?B?blkvK0I2alQ0SkFpWmFnNlAreTJya29PUkFpSWVBeWNpVFZweTN3emlmRVZw?=
 =?utf-8?B?N3lWZzN2MUFoNHAzTGFoZjdZWlB4YkVleWRFQjJKa1I0NnlZWWFvYzNySVZ0?=
 =?utf-8?B?S0FPNTlvRGhTY0ZIR1BIdUpydGgvM0JUU0lWdk5iV0J4VlVWT3Y0ZFhIUlVs?=
 =?utf-8?B?VkhoYUdMVjhpbGkraVhnb000Yk01bytIckFsUkk3OVFjdkg0S0kxaVRjU2NT?=
 =?utf-8?B?YWpZOEtaT09tNmRUZ3FJZmoyemF3eFRqSzc0Vmc5Z0hWVmVTV1lCMjN1ZktC?=
 =?utf-8?B?ZmczV08yUDZ4TjhIZ1FyMDc5WHZQT2RmMVRURVo3Qm5KWThiZ3E2TlZFV0Rp?=
 =?utf-8?B?VDlob2Vreko3ZUM3UkVWWkxBSThmdEErdU1LNm9aQXBwQVFnbjFMSUNsL0dC?=
 =?utf-8?B?UUFTcitWNmRrTjRPZmdyUlNMZHZYVVFMVUNBREhTR21WckV6MUZUUHQ4WjRt?=
 =?utf-8?B?dGRXUFVGSklXRXltdDBCSFBLdHFSSzQzOFNZalB0N2RVeGtZbzd1eERQaEU2?=
 =?utf-8?B?N01Od04wNS9XWFNDaXExbkVRL01xZzd0Z1gzNHFWM1hIckE2SDl4SzBpQlJj?=
 =?utf-8?B?dEhTbFY4Y2F2endxUS9qWmF3a0dlK0pYbzJJWk13b0M2VnpqQUUyUjE4UjEw?=
 =?utf-8?B?VlIwMVRkdTh1WXpjNHgzT2pXNWlSeHlBeUE2VkVGa3F3bUhxbVd4aGJmOXdj?=
 =?utf-8?B?V3R3d1J4SmpCbnBHMkR1Q1loc3puRUl0RjlRTjhFQmdxQ3ZwRnRnMjNvdE9Z?=
 =?utf-8?B?dm95T1hEc2s0cDVJSGpwQWI5NlNjTmNpOFFXTXcvMGxlRStoYVFNMXAxOEQ2?=
 =?utf-8?B?REVkU3ZXOFBScUlpSFA3Mjhpc1ZwNlk0RkpQZWVXdmpuWE45R3Nzcnd6THRL?=
 =?utf-8?B?bDdBTC92OUxKUk8vNmkra0U1cEhQN1AwdkRQSE1Gb2MxTlRCYzlDcS8wWE1X?=
 =?utf-8?Q?DGrZjVbcB3j7w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1hUUlErWktGSlNCYjRoTm1hYytZWjBOSXZSS1duclFSY2NIVnk2aUxvQ0lW?=
 =?utf-8?B?SVhKa1RSeU5IRjdCeHJ3d2NwMnRkRmZzbUNRUFU4UENOdFMxZTV3cU9pRXlh?=
 =?utf-8?B?OTMyOUgxcHp0c0U1eXVNYjh0VnhaeUY0M1QwMSthZGF4cU1mank3dEpWUFc4?=
 =?utf-8?B?T3dmTlBubjNuSE14Q001clhmcms1d20zU1pzTy96UFo5RDYyV05objkvSldJ?=
 =?utf-8?B?TXlnTkJpOXdqNjI3bGNEVXA4cGh2M1hPTVZwN0oxdjJUY1A4eTk1T1JiSWY2?=
 =?utf-8?B?VDhRL1FvUnpwVEhQNEpDbVNPNGVaZ1pFbFpia1Z0WFJqNFVkaVJ6MlBZbFdT?=
 =?utf-8?B?RnlHT25jdVpiV21aanRzT0xTRE1PdzFjb0dqSWF4NlU0Z3dpSFVLZFU3Mysx?=
 =?utf-8?B?bHBvYmRRa01iYzZpaWpOSDNnKzV2THF1L2ZqZmVuOEFxZFFlalNZL2FPcnFk?=
 =?utf-8?B?ZXI1RTh4Tk9wbWdXV1R4VDBOdWtMSHpqRXprMHpkWlk5SlhPVlByOWV2NXpz?=
 =?utf-8?B?ZFBSOEdsTmR1RVkvbTdmVHpDODV3VnZtRW0xMHNVRzBpeld2V1RLbFc0T054?=
 =?utf-8?B?b0pCVGVlK2JRVUErZDVmS1BtN1NrMTlVZ1NmbDVDUkV6dEdRaVF3VVdPTnVT?=
 =?utf-8?B?NCtoUnpDRDhJdWd4R0hTMmgxM05kU3dacm9DQlhkOVFwaXNPc0RHc2cxemRI?=
 =?utf-8?B?RlUySFZTME0vY0JGYU9iT3cxeHJiMXcwVG52MmFTSkNNNDZwUUljTXZRM2Ft?=
 =?utf-8?B?NUI5RFVVUXpyV3Nrc3YxWU5nZkNiOGNEYUthYmNDVy9OQ1Z2NUo4eHVDKzVK?=
 =?utf-8?B?RGVMamJlZEg1MlhGQW0yVWVESEZZRTNnZ2RNODE0ZXRFaE1Pcm1qQnpNcTQ0?=
 =?utf-8?B?WkhDMURYeXI2U0QrUmVKQ29zcTN1c3NtVzZ1MnVaRkNWQWlJaHlmeko4cFpQ?=
 =?utf-8?B?dS9hUUF3UzVKNURQRVNlNGhjR0VKSHhHTVNuSWxNS3lrYUV2d2ZhQlZrTEVX?=
 =?utf-8?B?R0ExcjRQTW5ZSDQwSE1ickQ1cUdjTlhRUTlWMWFKWFZJZUtLYmhXMloyRjFX?=
 =?utf-8?B?S2FnZE51Zjh1MGtjM1ZvSGJ0c3h6WTQyYjFmajkyNkQ5YzRMWC9TWURtUXNE?=
 =?utf-8?B?MkFlNnA0MXdPdEJXTjBPbTRhUUJFbHBEVDhJUTZOcTFWMGpkVnR1RnhIeGlR?=
 =?utf-8?B?QXVhUi82OUtuTWVFd1AyUlo3dU1XcmoyV2ZUUnNaSnBMcW9NSHh5N202T1N3?=
 =?utf-8?B?ZENKMWRORkdndXM3TGt5dnUySEwzdjJoSEtvcnRmT2N2bmtRNFUrVlc2QldG?=
 =?utf-8?B?eHhFdFVXNUdSV3g2bjFUQWR0TXJxcDgyS3pYd2hVb0lmOGJJaXNxeDhpRnVQ?=
 =?utf-8?B?Vmh4MHZHaERtVXNLdXR4ZUtYL2pMT0kzVVQ5NUk4OUFNT3g3N1MydGtoZTJy?=
 =?utf-8?B?WDhYRXdPZU1ZN2o1emJXdTlyb3dvS1lodStBZ0J4ZzNHZjBMNFc3c3dDNDNV?=
 =?utf-8?B?NGFRTzVSMW0vd3pDaTVjRmRXeDYvWmc5K09obFIzeTl5TEt3dSthTGRJQzVC?=
 =?utf-8?B?ejZBTXIrQVZqREE5dDBTTGxJWTJYTGVyYVBKU2J2VGc2b3dlMWpzV3YySHhQ?=
 =?utf-8?B?REt0UU15QTY1K0dUNGNjRFFoTU45dTlPa1ZvWWFuclQzdENKd0tTRmdFRDdT?=
 =?utf-8?B?MW5STUVMN3pZRkM3bjNwMVRobk5UK20xcWNKZFFjcjkwTENSaEkwOVBqK2FR?=
 =?utf-8?B?Q1pRc0RYdzROZmN1aUM4UVkwYWZBZGNUeHVVVDdLNEtkWmdWbktlRVFzTVRk?=
 =?utf-8?B?TTVlYmFYVWY2ampEeHhidDlQU0pGOUVqM2dTWmdSVWNXV2U0NUV5empIUDFR?=
 =?utf-8?B?WEk2L3JTYzhzdS8wZ2lBa3U2TnRuK1Y4ZzErUmxnSUdvaFN0Y1lhRTQxbVhM?=
 =?utf-8?B?TkdyaThwV0o1Q09sZXdoU3VmWGdod21HSlJrbk1tbHNETUhtRVRqVmR6QWY4?=
 =?utf-8?B?UjRkNkJ5YmllTi8wMTRIMzJtQ3k4U1U3K2FQUjQ4YWhWMTRXTWtDYW5QdU95?=
 =?utf-8?B?bk1QaytiY1U2RWxFcTYzL0hnNzRUS1pRVzBaNk1aUDZYMW5OY004MjdxaEZ0?=
 =?utf-8?B?ODk5cS9TK2hHT1FuemxENFcwSHkxOHIvZGpaUU9oV1RFOTR0RzRnYmF0NTQ4?=
 =?utf-8?Q?kQf5MiTKUL2YND5fwrsCRoQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e92d85-c864-4662-df9b-08dd35503b34
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:34:46.4799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWrQGAYRgqC1oreOe+zgp8IxOZmPJbrLa97TkhpRG5vusg/mHxvvvKjCYfypDySN7IwT5O5/no54WUu8aE98I01KQzA1vefDXeAqPc+Lo6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032
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

On 1/12/25 11:34 PM, Marek Vasut wrote:
> Move R-Car Gen3 and Gen4 jump_to_image_no_args() into dedicated
> rcar64-spl.c file. The implementation of jump_to_image_no_args()
> is identical. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

This is just factoring code and looks fine to me,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   board/renesas/common/Makefile     |  4 +++-
>   board/renesas/common/gen3-spl.c   | 21 ---------------------
>   board/renesas/common/gen4-spl.c   | 17 -----------------
>   board/renesas/common/rcar64-spl.c | 24 ++++++++++++++++++++++++
>   4 files changed, 27 insertions(+), 39 deletions(-)
>   create mode 100644 board/renesas/common/rcar64-spl.c
> 
> diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
> index e6dde3c2597..7a9f3a25440 100644
> --- a/board/renesas/common/Makefile
> +++ b/board/renesas/common/Makefile
> @@ -15,7 +15,9 @@ endif
>   
>   # 64 bit SoCs
>   ifdef CONFIG_RCAR_64
> -ifndef CONFIG_XPL_BUILD
> +ifdef CONFIG_XPL_BUILD
> +obj-y	+= rcar64-spl.o
> +else
>   obj-y	+= rcar64-common.o
>   endif
>   

Wondering if we couldn't use variables to make the Makefile a bit easier 
on the eye (though not necessarily more readable)?

Something like

ifdef CONFIG_XPL_BUILD
SPL_COMMON := spl
else
SPL_COMMON := common
endif

obj-y += rcar64-$(SPL_COMMON).o

Then we could use it for gen3 and gen4 object files as well for example.

I really struggle to parse Makefile/C code when there are a lot of 
ifdefs especially once they get nested, but maybe that's just me :)

Thanks!
Quentin
