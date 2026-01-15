Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66860D4117A
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 12:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB08D83015;
	Thu, 15 Jan 2026 13:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HWj/mWEM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HWj/mWEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBFD283623; Thu, 15 Jan 2026 13:10:00 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD37082BF2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 13:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xZhujzGRvoPIomxfVrYOr7sYn65qA4C3SL500ue1IJeKAqONEInLx/5V4+GFLWERLM3fq/UnqKEvN7umR9IQxEfT9bE+6VHStnvusiFI3Ft6g7ogB4ss1WaKxT/+yrRHtyEDex9TSocvCvxFlTgB0oxqKSWxUuzQsiJBvNuftTDlqXa9jfzc+ksD0+Op4UJAWkJb9PPBFve7cE9V5e5crmgVSMQsbTLk1AMFP7IGx0nPY7Pa08WCeI8CuB4VJa7DsHQEtHjGulrF3fLHIKrnMSp9UkOEdycdxqOscBvE8kEN6Jv6wHaSXpcEv00LpqeB0YpWQIWS92KdDrgPkMb/jQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RbDGSqbF0DFfsm23Gu3e3PjIZHXn4qE9PtWoa8gnfs=;
 b=pyGK45W+3mRwc3cPMF/3cL8tiSzcVeke/5/PlF5pxuNClyNE+4swOxuhQMGim4Hj6KelpHaPzMEm83maPxsQyCwvoEGyHREpXLueB428sXG0Osn7x7yJOku1e5NPX7Uw5AFWp1A8lEMqF7xG9tOiDgt2bsh6HiXXCKgLaZG/hBZdsrg49FW/8N7o8CW9cLyweesYCq8VaGdhrYsLEUlcd+yeInQweDh7PYBnKBcebAXM5L//ImL1XuiFN1lk/f4vgI1NNoLNDibng0pg8OjYSFib82n/qfrR8WOfIEMc/KvytoKwIB+dqD2RhjBzBWYVNCd0FoxyLbAcRitupFKK5g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RbDGSqbF0DFfsm23Gu3e3PjIZHXn4qE9PtWoa8gnfs=;
 b=HWj/mWEMtCC8JjKa5XGHwAOjF+y7EjVh6y0QP8ef6MeI6kwBE5Jjm6GvmT4rs9UwDTlPEggqbBuqEftY1KIu6P2cexOflgoX4sKJi1KlkehzqCGqV1xUiTjqROxrHTtlarINkGv5KkvMGvIGBZG0X1CFBkMmsdV/msk38TnuX4E=
Received: from AS9PR06CA0265.eurprd06.prod.outlook.com (2603:10a6:20b:45f::34)
 by PAWPR08MB11144.eurprd08.prod.outlook.com (2603:10a6:102:46a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 12:09:53 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:45f:cafe::b0) by AS9PR06CA0265.outlook.office365.com
 (2603:10a6:20b:45f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:09:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv1tVeg0VQbjbjaXZVZXPkedaUzHsEAb5B6i4yvjHAzvDC/YEpum2vSqO4mNURbRvp+tqG6H9It5jgBUgQ/ArIxf1wMrQBZBseYzX5N6zftKK/iZy9VEtuNrIwGoBKCVu8uAAl/9AICKdQovQIGGywJVTBUem3eTM5fQ+HUgO+UicfM0p7x74yZXjf3mk+pM9qc4Qx6OKUwikF3ZQ+wsUjn/avsXm1psw0oCNwEWdXpt1rVoScc5xMXSR5hOUmy2xrhjbsy4VCi2kiTMxyhtlxBmWJ2ESJ8sImLmMt/ghrydgkwP55cwkF3JrPFrYVIeWub/e14HKCNvgPa2R4IzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RbDGSqbF0DFfsm23Gu3e3PjIZHXn4qE9PtWoa8gnfs=;
 b=usBtN0flSJ4qWwLSv0XgcBqXwIYOuDb+LUyj0kqp2qnq45vAoRIEEUG/+CcX3sfjXTmCMZugE9vCeXbDy0orDLNUiW/fF3m6qEq48+4zAQketIjgfIqNDbTq7jDQ0ROcj3eJRJhhy4Sdcaf3dr6jqDfQREC1tu9Wmq3ddECQcNpx/cYqW6hy/oXqX6HPZGVSlgIGlMbc/P3PBPR0Ul2B0N/JpAq3wAjfgTCt776hHpjYT6y30OcV3XuTjxG6bYZXa3bHNh5gZ/NEk9MkLfr6xgB0gym9gyLLIi6Nwae5c5VFRS5UqhPsnYeMHY7/rjJjIrcSxQq/t/STZaoOx85pWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RbDGSqbF0DFfsm23Gu3e3PjIZHXn4qE9PtWoa8gnfs=;
 b=HWj/mWEMtCC8JjKa5XGHwAOjF+y7EjVh6y0QP8ef6MeI6kwBE5Jjm6GvmT4rs9UwDTlPEggqbBuqEftY1KIu6P2cexOflgoX4sKJi1KlkehzqCGqV1xUiTjqROxrHTtlarINkGv5KkvMGvIGBZG0X1CFBkMmsdV/msk38TnuX4E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU5PR08MB10561.eurprd08.prod.outlook.com
 (2603:10a6:10:51f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 15 Jan
 2026 12:08:46 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 12:08:46 +0000
Message-ID: <3e16301b-e9b8-4e61-85d6-8acbe7753226@arm.com>
Date: Thu, 15 Jan 2026 13:07:08 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260115
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU5PR08MB10561:EE_|AMS0EPF000001B3:EE_|PAWPR08MB11144:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b714f0-8864-43ef-3155-08de542efd7f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?UVRlWGRrbmtEOWZrcXJDQjFSUTd0Z20rU2xQNGpQUGlLQWNKa3dpZi81MVA2?=
 =?utf-8?B?dks1azZ3Vk5ZV2ZQL0NFbXZ0TDdxak5OODB4YXJZbWNyamF3ZlZXcy9CSHNI?=
 =?utf-8?B?L296eTBmTEZZTGo0L2dZYXdiWHBvWk5ISUdLZkFzTlBFTy9WOURoVlJhTWxB?=
 =?utf-8?B?Y0QwK09oSzhCOTQ4YUNaQTIrWVBHUFBaYmJ2WGt4NGMzN25LeUs0bmo3TXlJ?=
 =?utf-8?B?MFZFeHZhUVgyQWttOVNNVzJMU3YrZk1aVCtsOHI3d2RQRlN5S1U3ZjVRa05T?=
 =?utf-8?B?VW16V2tzWXV3ZGNNVVBSeUEwZ1phSkVHaUJ0TFZ1em9sR2VUNUMrblJDUmg4?=
 =?utf-8?B?WlFDeUUyQW9LOXBwTTg2U2o3WG9veEFzTCtUNTlkWlF4MEwvYVMwQkV3MmtT?=
 =?utf-8?B?YXVVOTFDTTFnMGNWUkp2TFgzZThrMm50bjRCODZuRFBFdHQ4WHk5SlRIKzFE?=
 =?utf-8?B?UTRLaU1JRFNCbUNXemhhZVZaUjdqL3BFVlppaEdlOHVkYnViU3h3WW1Ld3o4?=
 =?utf-8?B?NWlsU1lMQlA0aU44RkR2cGR0OS9EWFRmMjJNSHNmV3J6aXlJQjl4WEFoOU5m?=
 =?utf-8?B?ajdrN1JZVy9OS04xQ2xUcGxvQVNaYWF6a1ljUk9UZGQ4bkt3ekNrcjdlMkxW?=
 =?utf-8?B?MFJUQmR4b0Uza0tWWGw4cFFHbzIxQTg4RWYzNndNVStDWWpMaDYyVHlGc28z?=
 =?utf-8?B?d1IyeGs5TkhTVHF5Rk83MFZaMUxIYi9xTjhIVDRlemsrcDc5ZFpqOGRNWCsw?=
 =?utf-8?B?Q3NXb05KUk55M0NYV1BFUlM1ZnZQQjhETlREVHVSRk1YRDRZdWk2THExTTVa?=
 =?utf-8?B?TzVDQlhRNVhFcUxlMjZ5VDhuR2NxYmV4OEw0OGZrQ0RKWHlya1JRdW1lY1hv?=
 =?utf-8?B?Wkk2d0lKeFBmbGpDVTJCTDdMMmFWdkFIOU5Ob0FPQ3NUZjlBQjdzRjlhYVJJ?=
 =?utf-8?B?WHIyWWlmbnlTVUVDbHJEWXo1eE5hclhKWGhod3Bmb2VlaVhsRkx6eVFUYTRT?=
 =?utf-8?B?UVAvOEpXb055S21iZU5xSjBmVnRzVW5XbDQ3MWlFSWZBZHlpWTFXOVpReFpN?=
 =?utf-8?B?QUhRRGUwTUV4amxmU1VkZDNON1AwQ3Y2TjN2bEJnSXBkV29rR2NTQk03amgw?=
 =?utf-8?B?ZnExU2MxWTRDeHI3WnJxaEdIZHNyaVBYVkRVUDE3b1hHbGgxeHlIbDZMRnhm?=
 =?utf-8?B?c3NhSXU2ckxoU0lhZlhENkxpbzZpZ3QySm1jekdYaHVMaUl2RWI5NjBJV3Bz?=
 =?utf-8?B?YU0yRGR6b09OaVhJQk9vTVR1bWx4OVhKaXlFK0hranhSL0Q3YStvZU5WbDVa?=
 =?utf-8?B?MU1MR1BZSzlqVTRERnFDRDFpRGVaZTQwSjlPRWMyYnpIUHgrR1ZsR2NjWmdT?=
 =?utf-8?B?YmFQV2FDeHFYSGZ4U2FGZ2ZwdDE5Z1pvU3JhdE92YUs2a1VmZFFxZXFobDdC?=
 =?utf-8?B?SmJNK2E1Q05iT3RzQUFVSncrWE5GYWY1UEFwZWFLbUsrY0JDRm1XL29tZjMr?=
 =?utf-8?B?ZVJES05EeEJaRGFDQytoajZnUTZvT3RheDFKUjlyQjg2R25IRlpPM2FEZ0Y1?=
 =?utf-8?B?RHhQclNFbXQ3MlZMbVpqS0d0THl6ejR5VzVTUEoyMTZ1YWFCZHZKVS9qZG1n?=
 =?utf-8?B?MXJVVlBDVWpTY0lwUkdaZDZyTEdqTGhqY1hRakd0bThaTG10Y3dBTVMyNUsv?=
 =?utf-8?B?cjAxcTJmRUV6a2xQaFNMNUI0dVZOdm5RdlpHZ05HK3VVcWYrZURGTWNnekow?=
 =?utf-8?B?VVZIK2orbksrSjBYb0FZeWFLQnhwaG00UFFjem5XY0dCemxvelN4Zk5XbDF3?=
 =?utf-8?B?dWdnc0QyRnRaYU55V09HUXFNMVZYUytROElURUtzSzVYamQyRHYrM0NTWCtB?=
 =?utf-8?B?N1FhdmFpc1g1U0I3Mmw2SzdWbHNReXJJS2RORzkyNGx1Rk1aS0UvN3o5M0VC?=
 =?utf-8?B?Wm16NTlPeU1wdzdqaDZtRHBOUW9ZeVJwZ254OE1iR0RzSEQwdnNkTFVwR2Qx?=
 =?utf-8?Q?INhuC7xCRURs9uoeEfqPGQGt6UVYXs=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10561
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: db74cd7a-c00a-4653-d3d3-08de542ed588
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|35042699022|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDFpWUtsaFNwTE50czZ6NEQ4Ymp2YVJ3SmRnQ1lpalRJd0c2WVg5N0pMank1?=
 =?utf-8?B?VlpLdHBoekFzUkt3a3YrZHc4SGFsTU5CNHVlaHE5K1JYQytBbUxOcTRGdGxz?=
 =?utf-8?B?QWhRcnJTcndTUUlwMXhWMnBCNUJXUUs0cTJVYzdCeXRUZzVobHV0S2J5REpm?=
 =?utf-8?B?Uzh0elN4aGNYTFVxK1BwTTVtSnc1MnBHaUhNOS9BSHNqc1RsaEtBNTR5Nnhz?=
 =?utf-8?B?cEM4RWFhUXFBUTVHQ1prNU8ydVdhTFpYZXNRSXNSU0M3YlNudDA3ZytOcXBi?=
 =?utf-8?B?Rit5eDFFM1dieG9Cdm9UTGhZTFlicUgzR25LMm1lNFNaRzhYellhdGRZZXZO?=
 =?utf-8?B?VTlQMlkraUdCQ1RTNmk2eXJ3d2tVWm9udUQ2aEx4b3JIeVd4QndJVTZMaE5s?=
 =?utf-8?B?YlNkVGVCY1RjN0M2Tmt1TkRjQlVXb1RiV1puVjFpS1JXMEhGZWFENytCRmhL?=
 =?utf-8?B?Z0xFbUtwTDc5SWZobmZuWm9VN0JjMi91a0Qxb2hsNWF1TE9GWko1MXVJSnJk?=
 =?utf-8?B?Q1lxWUtEekxjL2ZnOWpHYjFzVmVLQ254NlJ0MFlxS2g0NGZ5cGFNT3VBT1o0?=
 =?utf-8?B?VUkyNXdhQnpxZFBlakFNc0ZSQzlzeFZRRlhnVkd2TWNKRS92bjJ1NXFMQ2Yy?=
 =?utf-8?B?bnpjdEF6QXlhS2E4ZGVxQVlJbDMxdTBRK1VZV0hVM2RUTGwzNmxnbGVxZndr?=
 =?utf-8?B?MTBQZVg0UGp3bnl4WWN2TkVzdmFWMnovRTFGTWtPOEdubkU4UFdyaDJ4bnpk?=
 =?utf-8?B?Q3hncFB0OTlQWVBDQ01LeWloNU55SjRISGtQMkg5ZXdyNy9PMFJaZEF3NkNH?=
 =?utf-8?B?K3M2T3I4T0lteUduTkNDdVBPUTZ0aXZ1SmFJTWxGelRZY1l4WjVBMGNRM1c3?=
 =?utf-8?B?SzRweW5OMXBBS2dDeG5CemxBaXQyb1ArV1Vpa0IxcE5tWnpMc3FPOWVvakhs?=
 =?utf-8?B?Y3JpRkY4OTRrQ05JUFc1d3dhSDd4WGdtbXFqT21rS3h0YlNpV3k1ZnUyMzRv?=
 =?utf-8?B?SFJHWnM2Um1SenRuVDY0ZExPN0s5aUp4N0hQU3RZS1FHR2J0U2xrdWtHMFRX?=
 =?utf-8?B?UDJ3MWVQU3ZlQmZTNjZleCtydHNlb01SRGgwNGNZTjlPbEZQMGlCU241UGVa?=
 =?utf-8?B?ZnVUdkk1S0tQbFRBK1NaOW0zZzBEOHRvbld2TytNNnJUMWgzbzlkeWR2MEI3?=
 =?utf-8?B?QmU4RkdjVWVDYUNRb0VIZEV3bzFhS2R4UmRpOXp6bzd6SFBQTEJYRzZTUWtQ?=
 =?utf-8?B?cXgvR05GOW10OGxCbkxaUTVzZnRlekRINHoyaS9mcERnN2k5ZXJIZ3h2OEpK?=
 =?utf-8?B?Q1N0U09OUjlkeHI3U0JvNmtBeTI4SjNiMTZGcThVaksyQjNpbHVXRzFxOWRy?=
 =?utf-8?B?S3pLdlRERlhCc0ZsQi9USTRvamlyQ1R4TXhQQmp5UDBBQnNKNTJzb01INDRl?=
 =?utf-8?B?VCtGVW90Y2RyZlhSb01XbFV2TjNqSjlDbStxWm5vMjBna3FYYnVHVHR1MTB4?=
 =?utf-8?B?TlJBOTZ3V1RiWUY2TzIyNXFOVytWVWlWZnU3Z1ZIbE16S1dKUzNIV0xta1dX?=
 =?utf-8?B?Y05mT3lFREx5OXRqcDdZUlZLZkRLa2QzU1JEY2k2Mko0Mk82TDgzQW5YWjBP?=
 =?utf-8?B?QWtoMTBsL0VpSDdtVU4xOUtIQnVYNlNlQWZFaTRTU3AycnJwNjdlZDYxa1ZM?=
 =?utf-8?B?bkZCcXZpMjNKZ2xqaVZRUlAxS0phOWJhMGtBakZ0UkZqNFA4aWtqcWJ0eHFX?=
 =?utf-8?B?dExlVDRTb0NyR2hxUHhCNEkxMHhZRGJYeW5mdHpidFVzS0FlRXFwTFF1S0Ez?=
 =?utf-8?B?QzFBVmY0SjZWTEh4VEpMY3ZudnMvbHhEd3FKSExJZXBpYnF3NWVZZWtaMlBL?=
 =?utf-8?B?Z3FQaTJvSnVqTzJqbXFUWloyZDRmYmtpNlBMc0VoMm5XUExDeGlUWkYyQU5D?=
 =?utf-8?B?ZnNJSSs1TzYyRDlJUytKZGR1eHFJRU9xWWxsb2IyN0pvOGxFUmhQWnVkUVBZ?=
 =?utf-8?B?cHF1QXg3dUhWeXViaWc2ZlZYUDlqa1RHS1hJQk90WFJVVGFBakdSWmxyeHE0?=
 =?utf-8?B?ZC8rZ24vdHBBN3EvdlMrYjJwNHo1WS9Wd1B3WitGSmNXV3NzbGlERlBaYzlC?=
 =?utf-8?B?Q0hteDdSaVlDaFpqZkxUT3RqaWVxdVBCVSs1N3orSnVsVFlPWnRVUWFRSWFX?=
 =?utf-8?B?Znc9PQ==?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(35042699022)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:09:53.1018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b714f0-8864-43ef-3155-08de542efd7f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11144
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

Hi Tom,

The following changes since commit d503633a36767d756c7de28305cf0de79440cbc0=
:

  Revert "doc: board: starfive: update jh7110 common description" (2026-01-=
13 14:18:05 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ net-20260115

for you to fetch changes up to b61d7d95cc62525060f0d05881bdaaf994a55b11:

  net: phy: micrel_ksz90x1: support forced GIGE master for KSZ9031 (2026-01=
-15 11:09:28 +0100)

----------------------------------------------------------------
Pull request net-20260115.

net:
- phy: micrel KSZ9031 and KSZ9021 fixes
- phy: marvell10g fix
- Fix "net stats" help
- Add Microsemi/Microchip MDIO driver
- tftpput: Rework to exclude code from xPL phases

net-legacy:
- Some refactoring to help with lwIP NF support

net-lwip:
- Add NFS support

----------------------------------------------------------------
Andrew Goodbody (7):
      net:lwip: Add debug line to net-lwip
      net: move net_state to net-common
      net: Move some variables to net-common files
      net: nfs: Add licence header
      net: nfs: Move most NFS code to common files
      net: lwip: nfs: Port the NFS code to work with lwIP
      configs: qemu_arm64_lwip_defconfig: enable CMD_NFS

Link Mauve (1):
      Add missing =E2=80=9Cnet=E2=80=9D prefix in help net

Marek Vasut (1):
      net: phy: marvell10g: Fix PHY mode bitmap handling

Markus Niebel (2):
      net: phy: micrel_ksz90x1: disable asymmetric pause for KSZ9031 and KS=
Z9021
      net: phy: micrel_ksz90x1: support forced GIGE master for KSZ9031

Robert Marko (1):
      net: add Microsemi/Microchip MDIO driver

Tom Rini (1):
      net: tftpput: Rework to exclude code from xPL phases

 cmd/Kconfig                       |  28 ++--
 cmd/lwip/Makefile                 |   1 +
 cmd/lwip/nfs.c                    |  11 ++
 cmd/net-common.c                  |   2 +-
 configs/qemu_arm64_lwip_defconfig |   1 +
 drivers/net/Kconfig               |   8 +
 drivers/net/Makefile              |   1 +
 drivers/net/mdio-mscc-miim.c      | 136 +++++++++++++++
 drivers/net/phy/marvell10g.c      |  14 +-
 drivers/net/phy/micrel_ksz90x1.c  |  66 +++++++-
 include/net-common.h              |  29 +++-
 include/net-legacy.h              |  22 ---
 include/net-lwip.h                |   1 +
 net/Makefile                      |   1 +
 net/lwip/Makefile                 |   1 +
 net/lwip/net-lwip.c               |   6 +-
 net/lwip/nfs.c                    | 286 ++++++++++++++++++++++++++++++++
 net/net-common.c                  |  12 ++
 net/net.c                         |  12 --
 net/nfs-common.c                  | 863 ++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/nfs-common.h                  | 123 ++++++++++++++
 net/nfs.c                         | 849 ++--------------------------------=
------------------------------------------------------------
 net/nfs.h                         |  59 -------
 net/tftp.c                        |  31 ++--
 24 files changed, 1589 insertions(+), 974 deletions(-)
 create mode 100644 cmd/lwip/nfs.c
 create mode 100644 drivers/net/mdio-mscc-miim.c
 create mode 100644 net/lwip/nfs.c
 create mode 100644 net/nfs-common.c
 create mode 100644 net/nfs-common.h

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/29=
008

Thanks,
--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
