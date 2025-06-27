Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3633C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 15:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC32B80C83;
	Fri, 27 Jun 2025 17:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lh+66Pjc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68F981D5D; Fri, 27 Jun 2025 17:44:13 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F22800C1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 17:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yExUi3PHkqvp4/NAwdfDMhDaBPxtOLbuUjJs8S91+ACd8qERXJWL02IMOU2kA47zspziZn+oVWRZ7Q2rihv0ZCpYy1XTBj0vDPleI+AGqTDH2UCGrzkoqYOa4UFUlO4ep5HH2ouZbsBgoOyqMzB4XhH/XOTljcfLRFwnNuiyPu2K2xKd/tYvp8gvQj7kxcZ+emrcUao2hdEzuVPNscct9JWJRUIZ62hqIUBF790NJN6SWNGZRezowrmByuP2+8P2ihZNJemtGjRmPedYxbNmgUzId9Ep8OP63lmczV8yJpL4wolHV5sYXozOWgy9y0NkP2MDxFr2Dim5O9huLXGVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqhx5IPzovOnggAKzwBQM0tn8WsMkCB/i6eiBoSq0Lk=;
 b=xZKplbn1HTMdY4XP5PzwXut+J0Ip055M56LjwM+IHz25CusLsAeF6Z3vsnvTG2d14QfaLbkBXBMU4Wwy9A87ON4Fv4YolMewYlbUywpQre3E4UdLkqemVoAFyc+nS0TtHrq5IjpyqAH86NQVb3pgqJVDja7PAU7JMADQ1guk6dr6TTI4zVQidbmK7Cguzb9C8kpHsVacaLbQeJ0rMC4+CWpOA2Cn639zmFOQiV0gO5Wue8tk6YR2JvdSx7Jxhh3sVk8y9vdsK+9Pbvqid9c+ybgC8MQF90MrF9NWXoTFmg+AF635kCKqWhUaea2sfgIF2i/MQmtLQkx30xespcrXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqhx5IPzovOnggAKzwBQM0tn8WsMkCB/i6eiBoSq0Lk=;
 b=lh+66PjcrbSWILaxWyNmncehfxu9s/J2Cje4QblL/BDqCLw7XoUK/R4RDhevP3h6kYxq8Wlw7JzviOSJ6f0vHmq2lZiRnG6A3O/5BWQDIJQqcrSrqSRFYtX8h9LS9CaV+Q/azvnixxh0wNVQ7VAB+WpDYQTPD2xUkfT7gRMJv3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8594.eurprd04.prod.outlook.com (2603:10a6:20b:425::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 15:44:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 15:44:08 +0000
Message-ID: <6a2d9b3c-adfe-4912-8937-c3b72f28d612@cherry.de>
Date: Fri, 27 Jun 2025 17:44:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: MichaIng <micha@dietpi.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
 <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
 <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
 <7ab1deb6-5ab7-4544-805f-f2e1e139d045@cherry.de>
 <647c2f92-344f-4feb-8979-93b1d6574193@dietpi.com>
 <0c822158-11d7-4a1f-93f8-22043c807bd9@cherry.de>
 <3a38f9b3-e8a1-41dc-b770-0af80b8ebc09@dietpi.com>
 <ed094775-23e6-4fb1-9272-540256d46719@cherry.de>
 <e92a4e72-1f7f-4a38-80df-7df8447a7bef@dietpi.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <e92a4e72-1f7f-4a38-80df-7df8447a7bef@dietpi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9bf165-0020-4b3a-379b-08ddb59174a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b21aeVNlZVJHbS9VZGxjOS9SbWFOekY3Mzc5SXpXTFJuZ2s4cXNpUWtCUTZw?=
 =?utf-8?B?dlhwWlUyblBTODFGenhDckVudzNyZm14bFVHRCtyL1FxQ2UyS3JzMExQelRu?=
 =?utf-8?B?alNEWkhuMGZOUkVEWXZ0V3l3cnlqRENTcHQ1SlRSWW1kTHJMMGEySjNQR2oy?=
 =?utf-8?B?cjZ6bHZScTgvbHphTHlJNVZDSVB2TVByckVtK0NnSmV5Z3hzZUZoVlZkMGpH?=
 =?utf-8?B?WXIxRi8yQ2F6QlM4UjJacmwyYzEwSW5vWmhaMElBRm5JcWdxZzJDVlBYYkd3?=
 =?utf-8?B?RHVjSTU2Vkw0TjdRVkpzVFlNYytJM3RrTkFoc0RuTVlzbUpOektBSjhrU3V1?=
 =?utf-8?B?bDMrVDdGRUFDSFVlZkpxc0NRMWNId294d3BMaFdFeGNVL3UxaStDSFdPb2pk?=
 =?utf-8?B?bGt5MnRzQ290WEpGWTFnUlEva2pETTBlVkZDWjlWc2diZWFibU9IVTFlMWpt?=
 =?utf-8?B?S1gxNC9wV25tYm0zem9ybmVXQURCbGhuOTJab05rbnB6YkxjeWtCNnYySDlC?=
 =?utf-8?B?YVNxVFEyTTRXQlFzZFBuRFNBZTkrWG1JajBtdlBxNTNXeXRyaGJ2NWJpMUxi?=
 =?utf-8?B?eWpGVXZpc1dubkN1Rk5Wcm0yVW4vZVVRaVh5RXE1K0tScjFQUExaZm5Ga1c1?=
 =?utf-8?B?Q01zS2Jlb3NzOFpyWEhBVjVNRGxWYS9ZRXVMamlGQWhVWkpoZWVLZGc5SDNk?=
 =?utf-8?B?VnY5MThKZTZxTHI0cVJlOWJObmc0L3Q5WUlwcHZGZVZMU2d4ZXRCVm5IK1ow?=
 =?utf-8?B?U1pwaXkvTHB3RWtCS1NUSGZhcC9QK0gxWGswa2M4aC9vS3NzNVZrRWI4THk2?=
 =?utf-8?B?N3RMYmFvSzRmUHZRQm5iNWtyS3VyRE1yNWFKQm1jSmJlODd1V2xiSTZyaGtQ?=
 =?utf-8?B?QXRaeDIyY2dDb0haR293RnJBaHcrVm9ZTmRnK2U2R24zSDlMT0cwL3RaaHJS?=
 =?utf-8?B?UEwwOTFtdlcxVGdhNUtNVDNPWEFlNHA4cmQ3KzRLSnloKzlIMXhCMENONmJS?=
 =?utf-8?B?NytWYVllRWZLNE1KQUdEUHAyWGQ0eHFFd0NsQkVQNGpyU01tMSthZWg2MW1M?=
 =?utf-8?B?dlZ2eGExcHlueE92MCtNa09HTC9ySmd4clRlbnRuNEs5a1FaVUVDZ3hSTjdz?=
 =?utf-8?B?VSs5ZU1EVXpENEZ4VWFwS1pQMjRiQklmWlliY1JKTVArTC92bk05TkNFWDNh?=
 =?utf-8?B?RVJFaEJLUU1mY0pxY3ZzWGV2bE8zd3NWVnBGaEo1Q0hDRmR6UUIxdFJ5alNz?=
 =?utf-8?B?MjdwZjV3YXVpRlZVNnJyN3lDQ2JQTWxPS25XVWxJVEg1emplUE9QNXNTOHp0?=
 =?utf-8?B?UWtPYXNuVkhOT1d4ZWEwNTUwZVFqRXBmYVVnM1dJdDVodVYvRGI3cHl4dDdx?=
 =?utf-8?B?U3ltVWh2bXptVTduMTVCVDR1bDBjNEhVZzBUQmNDQUN5K1VjeWNIb28zNC9Z?=
 =?utf-8?B?cFYwRHJ5NUpkSFo0ZmRxOWZsQmNsVFJVR29Wc0ppTWxQOUZOc0RmTWVIeXp6?=
 =?utf-8?B?UGpoNTEwam5LU1FpdUZQckxhRld2aTByWmpQaEwrNnJLWlRkeUpHZ2tXb21j?=
 =?utf-8?B?VEp3b2RLN2l1SlhmVGZsVlY4dnIvMlA5dmNNdmI0cG1YQ0ZSKzIvMnRyYllN?=
 =?utf-8?B?NjhsWEhGQlZjbXpjN3czMUFZZHJYaDBJVlJkQUJnUEdqZHI4cFBNMWdYNEZP?=
 =?utf-8?B?NGJlQW9DZzlQT0RvVkQ5MmdJMmlLRE5MelIzYXMrcWlqNkRBa3NiMlNXbUpN?=
 =?utf-8?B?MENicEVJRmx1MXd5THRpTjRncUl6c1ZwMzU5eFdHbnRFTDMzKzZHT1Q4bVBq?=
 =?utf-8?Q?ARHJxg3trO5A+ABJt3oNQghXYCBDobsU3Lj+U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1F2WXZPdzhPclZHUTdCYnpHVWFXdEh5UHJsd2JTajhsRlBjSlFVbUZ3bW1Y?=
 =?utf-8?B?NDJCZVVJWXVMdTBZYWc5ZS8xSzQyREhWWEhXUWlPem1GeEREUXFDc0tFdUxF?=
 =?utf-8?B?RllBMHhKVUMxQmdoRjhVbTErb2ZZTHg4eXZjZzYrbytlN0Z2NmJFU0o0MG5X?=
 =?utf-8?B?SGV4TVkwSGY5Z0tNVUxYR2ZteGhYd1kwcFNsOTRPb253N2ZxYlpWdE1kbm5T?=
 =?utf-8?B?NEtGcFdUSUdrRllzb3FOL2FVRk9ORVZZeFJaRXYrTS9RMURzSG9FZUY0U3Qr?=
 =?utf-8?B?UW4yaGVIcHg0OW9takdySlpNd091OTMzSnpkRVBGK0JiWm1qUVhOY1d3ZUZY?=
 =?utf-8?B?WEhXM0RteXg1V0NRZFZZZ0tYb0ZTRE8vT296ZzQvZ1ZyMjZlUnpsb2prR0FI?=
 =?utf-8?B?RU1YU0J3RFhwWVYyWExmTTk3bUpETnNGMGJYK3d1dWxyMkpzV2d6MVZoOTl0?=
 =?utf-8?B?cERtaHA0bFFrV0I2cC83VzF0M2NQQjJabm9QYTBQY1p3U0h3eUN5UHZPalM3?=
 =?utf-8?B?eU1jQnJQbVh6Sm51UzNaWHZUNEJ4TmdHSVNQb2orMFlraGRnbEc3by9VUyt3?=
 =?utf-8?B?QWJremVNSFpoQUVoSFVhWFd5a1VzV1liVjdPdmNHenJ0UkRoUXk1a1Q2T0gy?=
 =?utf-8?B?RFdHYzhRekxjeDBnd1BKVWFOY2dPczVKaXJ0QUxMV2Nhd0dZVFI2WWh5cFJU?=
 =?utf-8?B?cm15ZjcvS2FPWEdEOEJrRFhLNTlCcHRvZGVkTUdCWFRVSzFTK1duZ3dHTURi?=
 =?utf-8?B?OW8zVmU0K21GRXh3NVducHBmN2piMWs0Q0JlME93MWVpZ1doeWIzbGVHREQ4?=
 =?utf-8?B?QUdaeEVld0YrcDhhT0NZTktEQ1pVT3EvaFVNL3JKWmJ2ZHRzZzlvTTVpSkFl?=
 =?utf-8?B?NTJaMk45bFJOU1U5NHRkM2tJVVR4WGpnU0xLL2JlVnN5RVEzelpBMk43NHdY?=
 =?utf-8?B?MEJkZ2xLUnFvYzIwVHA1TlJCRVV5ZEFFelZicnk2MkdubVExeVRaTFVoVStB?=
 =?utf-8?B?enUzcFh4MExaSjNrYzBCNW9PSVdEMThoWUxyUWdXNGlGMXMrNnZVZThQaGF5?=
 =?utf-8?B?Y1RJS0tiNjBSczUrOXJ5eUJGeS9Id0JFVlVkOVMzNmc5TU8zUFk2MVdCNFFY?=
 =?utf-8?B?NWc4d3c5SVh6dnlZek5vSFQrR0pUZFptTzM1djZJT2RzampBYnNHRVpSYmVz?=
 =?utf-8?B?a0RFOXMraktkVlhqWXpSZ0VPdWJ1T2wrTUZHK21zWW96TzBwRGw2SXkycjZ1?=
 =?utf-8?B?NjZBc1lTZjJlb2hJTmFaNGtpU1VrM2xkUVl1SG5sd2ZtZk13UVpvY2ZRalNK?=
 =?utf-8?B?UmJubWQwVjZlUGhTRzhOeHRLSTNTSEljUFRkaExwbmlKNUtFOC9PeUhkOENo?=
 =?utf-8?B?RnFCNVZEVXMvRlFKdUszVC9OWFhXNlRUSTRBc1VoUlZIZTJ5OWxKczNEQ1FB?=
 =?utf-8?B?N1V3MFJNWStjckhTL3R4U2tsRjhUdjBuMUM4TlBBM2FWMFNHQkg1NWtWYmU3?=
 =?utf-8?B?YXlQUjdKOTlJVWNrVTV3OW96TUk4UnJBWTBIdk1OMjdKK0hZUnM4VHVVbmM4?=
 =?utf-8?B?a3o4T0tCZWhDcXVSNG16dVFKTUU1YmxHZml6UGhJUkJJZHdEYlJob0hNOTBQ?=
 =?utf-8?B?NWNUckFaQ3BDZ3pONUp1OHB4TExLMExVeFU1bmNqNTFMSGpoNGhETVpvVzJj?=
 =?utf-8?B?NVBXL21TaE9USFdlVnpXOW80d2paTGZnNmh6OUdld21UMm9reFhPME5paEtk?=
 =?utf-8?B?KzlrV1ZLWUF4Z0EvQlVXVVdBWkJoQ2xKak9JZ2dEV25rWnkxUVdnaGVjcmYv?=
 =?utf-8?B?MzVraTkzWHc2YkxnNUpjRElzRkt4NDMwOWd2aEowdzlMNFhQakpGcUl1Yzlm?=
 =?utf-8?B?YUdlRWNpUGExbXlrRkFxdFF2TS92bklzYjRKTTBDbVJza0ZENk5VMjFMTXlr?=
 =?utf-8?B?cVE5VmxDVDVacHRMVDNQQU11clc1NW90bXlNVk5GZmFJOEdBaXJTTDZ6NGgv?=
 =?utf-8?B?L3Y1Z2tlYWFVQnRwS2FudHVHNkVBTWVMSkJqV1M4dFhrZFVKVlhxbC9sQjQ2?=
 =?utf-8?B?dE9obzJ0N0tRUDJHZ092N25xWHJpTkluU2pwTG9qZk9PaHNBVDNCVTJ6ZkYw?=
 =?utf-8?B?b0t1bjlUOUs5SWtFM2x6aHZCQ0grU2lXTUVuaTFWM0tMRFdqbytWK094OXlr?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9bf165-0020-4b3a-379b-08ddb59174a0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 15:44:08.9197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC/YgAfbYFdHN3IGCWxUnro+Ry34rK7FVQWWAEcAvzCKxkRcVITf/q1P02R7sBe6tbFwQOTRSlwKVSqnvl2hsLh3EZ0+RWiuK0o+pBYTv20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8594
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

Hi Micha,

On 6/27/25 5:23 PM, MichaIng wrote:
> Hi Quentin,
> 
> many thanks for all your feedback and input.
> 
>  > If DM_SEQ_ALIAS is enabled, I believe so.
>  > I would imagine people be surprised if the same device operates under 
> two different MAC addresses depending on which SW is running at the 
> moment (U-Boot or Linux for example).
> 
> So far I only found https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
> boot%2Fblob%2Fmaster%2Fboot%2Ffdt_support.c%23L645- 
> L664&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cce3f16cb7ffc4282428c08ddb58ea1dd%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638866346409088334%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=QoEVV9ymbETho9Zaz%2F%2BD7NDTv3al4GiweS4BdEM9v5w%3D&reserved=0, the fdt_fixup_ethernet() function, which, as far as I can see, is called after/with boot* commands. Ah, but if U-Boots device tree is used to boot, then of course it is applied there as well. What I meant is in bootloader stage before that, when it is about looping through boot media, and in case network boot options, searching for/executing boot.scr, in case U-Boot console.
> 

U-Boot code is sometimes much more convoluted than a quick grep :)

I don't remember the whole path I took but essentially it led me to look 
for enetaddr, net_enetaddr, eth_env_set_enetaddr, etc... which calls 
dev_seq() on the udevice, which returns dev->seq_, which is set (if 
DM_SEQ_ALIAS is enabled) by dev_read_alias_seq() when binding the driver.

Cheers,
Quentin
