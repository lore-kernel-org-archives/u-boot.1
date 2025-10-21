Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA562CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 10:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DFB807C0;
	Tue, 21 Oct 2025 12:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="YKa6FDJW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YKa6FDJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E1F82B20; Tue, 21 Oct 2025 12:35:27 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7AB8003E
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 12:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qW1fOsQEXyq8lTQIPOcX2OG8CA0UlRk0UfsuuKTZrgxryQyu2fzvtWO754WTtPNP/TNh5ypeHHXAVNqb8sT621e0+v07a4SnSKbmiLQMUKyPKz4v4xJYLuJldtek2ek75q2pwapXeVsbAfTaU2/fW684MctYhfc2ascT6o+KLCtNwp9MFSH8jGAOY8IfC4ArUolhEz4ADvb5ISt/68Cjho6RpIyG6jMJ2LLfT6lGzJVAB4aPPJjtLsj4eUMAh4gELjuRjlCHouDQYLf3mBgQ+Fgf54mVvfORdPajL1VF9rigMyRFMFZjD0GJUKKvsPipIl4xgr8yne/Q86jQm5nGYA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ENi+sSXTXkP3s4MoSw6yamm2GSPSrrHsgIJ4ZFvlRI=;
 b=ghYtEP5KicIHhMbPOYrdHtlTkbkNOeOcEU01RmsvUkklfHU881AoQszy9fm4SREaIInuQwLW605AMdAWFlgG4UJMTsTE37O+iW3beKWNtzpmUThLc+bZx6jCzVz6aJqI6pkW5N5Nmu7gwA3Hv/6yzgsq+nasd53ZCiy9WxBFhxlj86pam3eQMXYBEikUSsiFSvvxMuob/TvtBlvRIFEM46uP6a2qcpTZn87bAPWsh2pf2YvNWSBhMBLn3Nuw3xtiuXT69fMUzGsn67pd4TY2ZOvrs6u5u1hqqGhi6b/Bn7sVnY97q3FmhIyplYmwY/Ahdzorf19EMuHqEGkev+5T+w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ENi+sSXTXkP3s4MoSw6yamm2GSPSrrHsgIJ4ZFvlRI=;
 b=YKa6FDJWtZLSSsK9ZkIn97IvdLnSQHhzyy7Htb5ANnmMR17GL9gQ8b8cLDW7BelG+j1fqNu9LXG1mNYkvXiNqkjs4pVh5Kq6PCXgjt1qbycfMId3kVfReNKePyl5PenYrJqdwiUBkpbDIBCTMgv/Zoqo21FW/cFPLD5dT5QHWCw=
Received: from DU2PR04CA0310.eurprd04.prod.outlook.com (2603:10a6:10:2b5::15)
 by GV1PR08MB10751.eurprd08.prod.outlook.com (2603:10a6:150:166::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 10:33:39 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::31) by DU2PR04CA0310.outlook.office365.com
 (2603:10a6:10:2b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 10:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7 via
 Frontend Transport; Tue, 21 Oct 2025 10:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLt7Z+jbTUD3ZOE7M3gBCNxXHwbKLdbkIEGr2F/8s48ArH4GTRrqzWMqymXeHBMF6hARcWMzO+PhiiQ1zDM28F0wKyq4GX6feb9xeS1dMEec0+lF9XQKc7hBfs8K1Ak+FSu9HyHt0/46d+es+aT4YlTMJQ3jbGNLLDp+CGWYI8Z9+lc9bXWS73533lySUsmp6o6baD8E/a/i9DZA4QpHYJtavdT3cTchKPVhhd9xsT1PvOf1buEd2auk1/6MVENp//ANMNXPQvcET3BPiO3UmaRk5BUOf+7ezoSr88IOlXDdnVANRUQNAx7v/asvQ5aR+QpstdE60r+niJaOK6rfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ENi+sSXTXkP3s4MoSw6yamm2GSPSrrHsgIJ4ZFvlRI=;
 b=hQKkBoueFqEqdYt5KeLRIp8xFS3DVGKSakQ0z0gdyA2OuC7Sm4cL2msQTm9KhSCWI6wk88K890uiInGNl45bO7ROTX6fza/8rwtsglhsPnUG6/5rJy98b82axVIy9Uhr4BekMK9oh6KVbFtDQ2pT35D7G0nOF66YaYGWkV+YecbQqJCXac9u9Lc+7WrTbF8Q0NAyI7sjDrCzKO44Qru1cLUTG8YeEgPeCs3jX63QX6UsNlkTOOYEApBmWY+pKyIaeOWqJzOJqLMaCbTpU7qnWnDaP3MHaiZfuBnwh2Pz/e4Qltaf4h2g2/ZMj+1PW6BjnqrphSTByCZu27+67nLYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ENi+sSXTXkP3s4MoSw6yamm2GSPSrrHsgIJ4ZFvlRI=;
 b=YKa6FDJWtZLSSsK9ZkIn97IvdLnSQHhzyy7Htb5ANnmMR17GL9gQ8b8cLDW7BelG+j1fqNu9LXG1mNYkvXiNqkjs4pVh5Kq6PCXgjt1qbycfMId3kVfReNKePyl5PenYrJqdwiUBkpbDIBCTMgv/Zoqo21FW/cFPLD5dT5QHWCw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by AS8PR08MB5912.eurprd08.prod.outlook.com (2603:10a6:20b:29f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:33:07 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 10:33:06 +0000
Message-ID: <b7da1140-9221-4d3f-8255-006d80be6a8c@arm.com>
Date: Tue, 21 Oct 2025 11:33:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Transfer List Checksum Correction and Impact on Bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, nd <nd@arm.com>,
 apalos@gmail.com
References: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
 <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
 <20250929181133.GM6093@bill-the-cat>
 <cbedfd39-85c7-415c-a401-91795408ebc8@arm.com>
 <CAEfUkU+jQDQmeLm6Qw4dKGgN99eprzn-CEaRdHdAzBOmn3UT8Q@mail.gmail.com>
Content-Language: en-GB
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <CAEfUkU+jQDQmeLm6Qw4dKGgN99eprzn-CEaRdHdAzBOmn3UT8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::6) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|AS8PR08MB5912:EE_|DU2PEPF0001E9C2:EE_|GV1PR08MB10751:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa82f8e-f19b-4e2f-9227-08de108d4cb8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Q2xKVDFEZW5UUmVUUHo2NXlkZ0ZkZEc2UlR6T2o3NWxRbG1sZ2hvRnBsMURn?=
 =?utf-8?B?bmpUa1p6NVpRVjlIOEROUGFNVStZMk1JdnFzOFBvbTZPUkFxQ0UzREp5TjFC?=
 =?utf-8?B?WWlDSjVQWHdTUHczTFBvZlZFQVJ2akJtYjExVjZTTTBrSDFRdmxkdmo0K1RF?=
 =?utf-8?B?ZUVpa3NTNVNGRnNKenV4UHI2NkUvRnZ4a0lRYjBBVDArR1YxNjVsekdYZ2Uv?=
 =?utf-8?B?cXk5Wk96SVlWRUlwMHpSZFByVTNtbHl2d1ZqYUpUQWZaVHFjanprTkpUUWFR?=
 =?utf-8?B?cU5Nc3JVWmhySXBnQzE2ajJKdkVwU3hTdmYrK0ZEZXlGUStmRnA5dXVoVTNN?=
 =?utf-8?B?b3FTTEN0WWo4Qk0zcE01YlVMQjJkcmJ4bzUydU5UQy8zM0g0amMrbkM2Y3ZH?=
 =?utf-8?B?UDNGa09SNm12R1ZHZlJ2VXZzc29HaXAzVG9TQWg0UWsvREZoaERqWGMvbjVS?=
 =?utf-8?B?WlZqZitUaGZLWGtnclQzNEU0SUQ1UDBTNnJwRjZzK0xpeHVMZ3FmWDloYjNa?=
 =?utf-8?B?RHowMFB3d3FQcEt3eFdOeEhNQ3R2alFUUnM2ZVoyRlVabkVkL0g5QXpqYVpn?=
 =?utf-8?B?TENRV0N1ZDRMV1IwditycHNUMFV5VWFhV3RzSkFHNVp4RzFjS01nUzNtU0o5?=
 =?utf-8?B?ZElkSlI3ZE51emR2VlNvQy95VEYzNXFoeWdqWDNOMnRvdjFJdUhMUEgzOGhN?=
 =?utf-8?B?emxCbTJEY1hrQ3huUnlvWXlJR21tOFZZbVBPeU4vL05ZZGs3UTFTSEIwMVlo?=
 =?utf-8?B?TXNnNGlzRmZKQ2l0UnU1c3J4b0JLRjFnVVpRK0hXWFVrUkhMTVdBaVhSSHY2?=
 =?utf-8?B?aEpIVE9TcFNDazdYcnpTWUx6WWVtTExBSTYvRUVTRk9NNlA2VDlOekluR1V5?=
 =?utf-8?B?YzQ2UzBVMkFyRWtaSFl4R1JUZTBZMCtGU2hmc0l6Rlc3akp5SVVTL0lwZXl4?=
 =?utf-8?B?NGNDT05pRkZvSlBzNExoakJSNSt4MUh0NjNVYTdsUHNodmlnTWF2K05FTVM3?=
 =?utf-8?B?Z0NLOGJ3VlVuK05BL3R2VXpVZnNjQ2lodFk2UlhPYkRzYU9Rb3ZlcVZWcTZ6?=
 =?utf-8?B?cCtyTlVLcFovZlV2czdUSmRsS05LU1I2S3hNUzI1Zk04YUowQ1VwRXozRXU2?=
 =?utf-8?B?NGw2NExSUG95dmhGbDBWYi9WaFg0WkFzcVFvVm5VYmNkNzRqSnpWaG1PNTU1?=
 =?utf-8?B?clhKbjIyR2RUaXdyQUI3NUtxMG5jQitqd0lMVkl6cUFIWGxRRWtxaUdERHhl?=
 =?utf-8?B?Q2FGbGkxSHhTZlRXWVRVMGpBMEZOR0ZFOGE1L2RLWFI3QkI5UFd4UldLWmVk?=
 =?utf-8?B?MzcxQ1Y3ZG9hNWx6czBYd08yUTdXSGpHWDlQVnMxN2hCK1l5QzRKM2loUlBT?=
 =?utf-8?B?TXdwSnN1V2pzZUo5TkRTblBwNXZyZTZsaDFnbC9LYmg0NnFKQWcwN1FuK1hk?=
 =?utf-8?B?NVZWWGNBT1loZzZhcnJYSkV6Y3BiQ2FXRlhaZFBFc2d5cWVHVXVXbmE0dEdH?=
 =?utf-8?B?UHlkcWpRRUJJS2xFUHBjdXliMktmTDF0VkUxSDVBU1gyV3dwWmVmVWRudTQx?=
 =?utf-8?B?NmFRdDJmSmtOSHQwRVdpVVI4UG4vOUthNnUxeHNmN25QeEl2bVViZWVtSm9P?=
 =?utf-8?B?UXdkVTRHazJ0cW1ibzFMc1lNOFZXcm8wNk5TaWtUVVdkRnFONWE5blgyVEJK?=
 =?utf-8?B?NXZlZFV3NVVuS01LY3ZhbWJxTmZqOXFoL0U1dzFFS04wY0haY2FtQ25Cd2JV?=
 =?utf-8?B?dU5XOFdmQ0hwcklENitaU3diQkRDakpiTUIvdTVkOW1HVkhVdVpIVHN0ekJ0?=
 =?utf-8?B?QVFZaEt6K2s4RzFORWRYOEpBd2w3b1p2RkdnV2srbzhlTTRFZXZMSUswSlYw?=
 =?utf-8?B?OVFNWHptK3Y0a2htY3JJWFNjSjdSQkl4NDdKdElGMXNqREE9PQ==?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5912
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: dbd91eae-a1cd-4a3e-6d54-08de108d3903
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|35042699022|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXNtSjN4b3pkZmR3WU9tWnAzSmU2UWg1ck91aDU5QU5icWJ2QWpta0xLNkJF?=
 =?utf-8?B?RWhOSlZlV2UzUzZEZVpDNXhTTFFINzlUUW9rVFJxWi9sVnFpZGlKaDdFcGpi?=
 =?utf-8?B?ckhOamdWdE0wRzZDcTZGSFB6WlZyeEFZV3hoUmhGSE9yUGo3ZXYxbWs5b1lR?=
 =?utf-8?B?Z0RtRVhJZjcxNDJ0UFN5MVVaQ1VrY2VYU2F0S2NMUU9mb1NPOTV6ZWtmcEZ4?=
 =?utf-8?B?bWpHc2FiNG9uSlBzSkx3T0NZdnRFWWtUUnVoeHMwVkhnSzdhMWNUb0wwY1FZ?=
 =?utf-8?B?OUFmaTUzSXZrTVRRVWRTdHNxN1cwZUYzdDJCc2RueG9PSTlzMWhQN0Rxcjc3?=
 =?utf-8?B?djVSZ0haRTMrRFJOWjNWaUtLckhncUszTktKQ1grbXlCcVZsMmRkdWg5WmRy?=
 =?utf-8?B?Ni9pNFNVam1lbnhSSkhZT2FhSEVONS91WVkxSlJVKzhOQWRQK3hJTUZkd21S?=
 =?utf-8?B?c25JSWFiNjh2aEdDN1VxQTdmYVUvcDE3UUZjNkpXV2R4KzdtQ2psWWsvZm1I?=
 =?utf-8?B?bG02VzB5b3NXVHF6NTF2SGR4RHdJS2tkNG9vVDN4WmI0aTFUdllySUIvMm1z?=
 =?utf-8?B?WExwcmk4ZlFYdGhuS0JGdzh6QThDYVlSQno1MDN2MmMvNmJWQkU5aHFQdGNr?=
 =?utf-8?B?NnlTZnllM0RrbFdXNC9YNTFrQVNLdVVFWENtVkh2SW84WWd3REt5THBobmla?=
 =?utf-8?B?K04xQVY5WFRJRC83bEUzbXY0U3pPdTB1akUzSVU2a0xFYTh2YnNYSEtNYSto?=
 =?utf-8?B?VkFzN20zQURpalJXUmR4bGo2TXRBbXlCMFpOZHhPVUJwbnovUXV1MjcwdGN5?=
 =?utf-8?B?K25LNXJEOVZGUy9pYm4rNmpMOGRLK2prcnRMK2ZJdWhaUVMwdEw3Q1A1SUdJ?=
 =?utf-8?B?Sm9JMlgxZW1pL2gwTE8zOVJBNzVBVWlmdmlieTdJZnRQSXNSUWFHUFlQNlVS?=
 =?utf-8?B?TDB2b2hiWGNJakthTE93Tk52eHRPVlVSVWlqTHZ2M3l6Y1NkSHBFUHdid3dO?=
 =?utf-8?B?NlAwMmpUZktOUUo4OGYwdkdwSStUWEdyN2hOT2c2U2Q4YUJHSitjUnhVUFBK?=
 =?utf-8?B?aFZ5bVhscmE0cHBnUzhlckdrZHRJVE1VN3lHR09XU0FuRmM2SkIrUVRTN0JT?=
 =?utf-8?B?RUdwUHVVeHZvcHdTYzNCWVRuYkgrNEpmMG1LcmNJTFFTQVpsV1h4bXpyYVYr?=
 =?utf-8?B?Tm9TYnFRVWRZUXd2WHBkUmxpSGErZkdhQVZvYTQza3FpMmdqdysvYjV1Z1Rl?=
 =?utf-8?B?KzJxMXc1VHI2SkhoeXUybFhGMi8vaW0vWFFVbmU2WUcxZ2pnbzZLM0p4emZr?=
 =?utf-8?B?bmhKYTNpaTR6d2hGdW1HQnNXT3Z4WnpUQjlDMVFObU85NTQ2WEdhZkY0V0JB?=
 =?utf-8?B?NXgrbjFmaFdSditNb2tCVjBSQVhHcDVCaEQwWmV3VDZIQlZHZmNTczFOV05F?=
 =?utf-8?B?SW4vZ2JMdGpjcHZsUWVFWmhBbXU3RjYvYlJqTWZ5VjY2SlorcEZaeXkweGEx?=
 =?utf-8?B?VVR1M1Jua0NtZ09rdUk5STJJSW9xZHQ2eFpGRWQzcVp0SDVHRXkyUmw0Q016?=
 =?utf-8?B?KzZOaUl0MFd4RnBKU0NNakdidzljUkZ5VkhwZWhqQ2luNytVQVNTU1RKNUJG?=
 =?utf-8?B?YnBmb0I5OXZpbkdQdTRTRE5Wc051SnRtVXpuc3JrdmIvTHpuWVg2R2dyTU8z?=
 =?utf-8?B?R0tOdFBiSmpmSFR1SHIvWTlBY1NqQkFzUFVNdHhUaWZidWM5UWo4WTYzZWo1?=
 =?utf-8?B?cWFZWjI2em9WOTljbitFS3pXZEZwL1ZXeHduWm04MlZmYWVJeTJpTmUzcHRT?=
 =?utf-8?B?TWsrMkh4YjE2MmQ3RUxnSjZxZ2kySWdZb1AvSUVjUGxsNXJFTFJuNkpNWXNw?=
 =?utf-8?B?ZnNPWGM4V0RnWDcrVG5LNVJjeWppL0tveU5GaVc5UEtCWnNSbnBKTXg2clZH?=
 =?utf-8?B?QTBTZ1Zwck9vR2J2Z1F2Y2ZoTjlVb0UvMXJNYzM5OUo0RVJXYlhjWmlWZjkw?=
 =?utf-8?B?TWQwSFR0RHdnc1huWGo3dWJLSWNiamNPdHR1NXBxWEtUZi9laFplS3FweTJy?=
 =?utf-8?Q?KmWo5b?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(35042699022)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:33:39.5802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa82f8e-f19b-4e2f-9227-08de108d4cb8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10751
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

+Illias to the thread

On 01/10/2025 16:54, Raymond Mao wrote:
> Hi Harrison,
> 
> On Tue, 30 Sept 2025 at 06:54, Harrison Mutai <harrison.mutai@arm.com> wrote:
>>
>> On 29/09/2025 19:11, Tom Rini wrote:
>>> On Fri, Sep 26, 2025 at 05:09:53PM +0100, Harrison Mutai wrote:
>>>> Hi all,
>>>>
>>>> We recently applied changes to the transfer list library [1] to correct the
>>>> checksum calculation. Previously, we used a simple byte-sum approach.
>>>> However, we later realized this contradicts the Firmware Handoff
>>>> specification, which states:
>>>>
>>>>> The checksum is set to a value such that the XOR over every byte in the
>>>>> {tl_base_pa, …, tl_base_pa + used_size - 1} address range is equal to 0.
>>>>
>>>> This discrepancy creates problems when interoperating with Bloblist.
>>>> Should Bloblist’s checksum calculation be updated to follow the same
>>>> XOR-based method?
>>>>
>>>> [1]
>>>> https://review.trustedfirmware.org/c/shared/transfer-list-library/+/42548
>>>
>>> Erm, since this has been out in the wild so to speak, we can't just
>>> change the algorithm without bumping some cardinal. Or are there yet
>>> other implementations that were doing what the spec said?
>>>
>>
>> Raymond; Thanks for setting up the handoff tests. The next release for
>> TF-A is planned for mid-November [1].
>>
>> We’ve run into an issue where TF-A requires specific tags from the
>> transfer list library, but we can’t consume them due to the recent
>> checksum changes.
>>
>> Tom; As it stands, ours is the only implementation currently using the
>> updated checksum algorithm. There are two other consumers - OP-TEE and
>> EDK2. OP-TEE already has a patch in upstream review to move to the new
>> algorithm [2].
>>
> 
> There is a question: How did you pass the OP-TEE CI test without U-Boot changes?
> There is a CI check QEMUv8_check2 in OP-TEE that builds with Firmware
> Handoff enabled, but the manifest is pointing to U-Boot v2025.07-rc1.
> So I think unless you have merged the updated checksum to U-Boot and
> updated the OP-TEE manifest with that commit-id, otherwise
> QEMUv8_check2 will still fail due to the mismatching checksum
> algorithm.
> 
Ah yes that's a good catch. I've held that patch while we discuss things 
here and in the handoff spec forum.
> Regards,
> Raymond
> 
>> I’ve also reached out to the author of the EDK2 implementation to make
>> them aware of the change.
>>
>> [1]
>> https://trustedfirmware-a.readthedocs.io/en/latest/about/release-information.html
>> [2] https://github.com/OP-TEE/optee_os/pull/7531
>>

