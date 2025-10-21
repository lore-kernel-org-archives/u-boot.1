Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23418CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 10:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D75F807C0;
	Tue, 21 Oct 2025 12:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pVAf+rek";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pVAf+rek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10335829E7; Tue, 21 Oct 2025 12:40:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DBE802C1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 12:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TUTf3dKq0bcble0FB4b8V1vVnnkZVT+rNEC53YTDEFOXPlohteqrIcFTq2iLqPO3kjWTpLlIDBLntozeegfrG/BT0hGuZKPUE1R+/TtSMm/70ZbzefL0CRJ9fXocitF7TxpB1NRnBtL5Fdxd8K7OB9FP+97LGydssmZpI2ewrvGjTrwKNcB4fWvssvHXJ7S+kw/Hf4XmTYAC7z45sB4yIT387SnK0T89yRjBdStXScr/oo2Hy5DZ6Ai/5XFhpi9GtiGiV/gQeT2Qe4+nKbfomxDeA6vCPAFNN9SPvDF1WLl5T/8pg1l+bea6iGRFrCP+8jg0XwNJpu0V39XKoaZbFw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7cjCIT+0hJdLpCdMGeuKUVITN9A8wFeLopWx45tVms=;
 b=Sopb93YuS3vocboZDF2DDdiAVdV5zQxCOGA3eyevdxxEpFm1Ga3wJolnhG3i2FCWoWvE7YmkJoAMi52Ek4tMjN1d5t7emV3SxFZ3WcW9NI8ZxiNVX4xTn8+Xw7ZAc3zka5Le1HtrpEB2lLf2EA8flbqXBgDCbZsuJyxS0Td1H0eB8X8EEs3f9YZYxfcos31eMDKI3tx2Rb0r/RZQMa20PuPQIUmdmtj0I042GTnzOZsdeUr3PVGqeTEtZNhPWALQKRfAEPItktdZ5oHIqKdEaerKji0hTcFH5pRKnXB34fdkB5dsO2QgAYYn8YcWnzO/m2+pHHFoPUu3KRbdkX62mw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7cjCIT+0hJdLpCdMGeuKUVITN9A8wFeLopWx45tVms=;
 b=pVAf+reksOJuRgER/r0ue3y1ds6Mimj0aGzujDSqLTCFkt5bFC7L/DfYK9S+WurP1iFk0L1NZQ8hDmbNf2hXRVYQEihyyy8NixtDis3aB23aFRzz3wRtUhqm9nS3zWUOf160bX6RYsStrWd2DQQR7t1x4F2x+skYeWzTVjGkNNI=
Received: from DUZP191CA0036.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::28)
 by GV1PR08MB8009.eurprd08.prod.outlook.com (2603:10a6:150:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:40:04 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::3a) by DUZP191CA0036.outlook.office365.com
 (2603:10a6:10:4f8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 10:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7 via
 Frontend Transport; Tue, 21 Oct 2025 10:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbB6NNtSSgkHEYw9GV+geK/kskG1pSeEF1/tRG94sR9xFVlu+BO+ev4spLYc7AMElKGI4OLv+/O7ee40/tY1reDRzlnfuaoOsYWvb3HAsrl5UQhuep5rXOHdKHHtrMbNRsEx4i2Us0o8oxqru/b8AYRhr/Mvl7OiuLDukJeWK7K5a0Y4XIhKPN/VKfC6HteYmU/2QLOR9DcK1mRH4fxlgPXcG3iKvCbJcL8mnzXRhwDTALkvkMxfc+112FnPtcXQrVOqQkQCuUDK1UhXrT6/da/iCi4nKI0621Gr7iD6GShim+E9evUNv+9SPoyvFxCTAXbApdv0cqoB5thqpf/UAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7cjCIT+0hJdLpCdMGeuKUVITN9A8wFeLopWx45tVms=;
 b=qANexdafR08/GDdaLUjqzUoR1iZLF5osTDWUwOzU0u2tRcty58LfCho+JWemVV23KTktuE39MapPkvCVyhUuRqz9U34+f7oqUNhFcHf6K1kNFR09qhQnspkXEOIL16t/ni7n7rw9nNskNchGRMWOfS95EOr3QovuJib0a3U/DFv+usR+q4dpJN9YXpA/y7Aokck9Mctq4Cy6yUQbqrBTjTLcKoh7kXDm/f8u514iQjRv6NzvT40Lw1BCh+eU9ra6XqbhG/1fz9BSPN4xPZPZDM/wRTs8/2wW/6grxv9GuzKPmjdNYufwNeeSDMutMN8+gbrw8oe0ZwRa0HUMFIgBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7cjCIT+0hJdLpCdMGeuKUVITN9A8wFeLopWx45tVms=;
 b=pVAf+reksOJuRgER/r0ue3y1ds6Mimj0aGzujDSqLTCFkt5bFC7L/DfYK9S+WurP1iFk0L1NZQ8hDmbNf2hXRVYQEihyyy8NixtDis3aB23aFRzz3wRtUhqm9nS3zWUOf160bX6RYsStrWd2DQQR7t1x4F2x+skYeWzTVjGkNNI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by AS4PR08MB8118.eurprd08.prod.outlook.com (2603:10a6:20b:58a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:39:30 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 10:39:30 +0000
Message-ID: <2a1cd973-99d7-4faf-9478-75f028916a2f@arm.com>
Date: Tue, 21 Oct 2025 11:39:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Transfer List Checksum Correction and Impact on Bloblist
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, nd <nd@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
 <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
 <20250929181133.GM6093@bill-the-cat>
 <cbedfd39-85c7-415c-a401-91795408ebc8@arm.com>
 <20250930144820.GY6093@bill-the-cat>
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20250930144820.GY6093@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::20) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|AS4PR08MB8118:EE_|DU6PEPF0000A7E0:EE_|GV1PR08MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8665a1-460a-4611-5ec0-08de108e3169
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?M3c1b1lKYmwyTUVPNVRRWlEwRDZ5eis1ZEpRaU1jcUJhaTNtTlo1SmxXd3FZ?=
 =?utf-8?B?WmJnOHBVNEIzRm52NXFKRVFSWVpXQ2k3Ump1NlRMcHBvMWpwM1RWK0RYUytr?=
 =?utf-8?B?Y294WWFmWmdzS3JXRVIvSURlbnVMeGROZVo1ODJHd1N0YzNwT1VOYjhNZ3ZO?=
 =?utf-8?B?S2R2V2pGTFdqbER2dldWOXF4cC9XSjZ3ODVOblpPSjZJZlF0aEFMeG1nOWhN?=
 =?utf-8?B?TksyNG5taEFaOE1ESXdRSG1xeDRXVmR1OW4rTVhLTVBlRnNRQmxMMTJBbGlZ?=
 =?utf-8?B?S0g1ZWQvcWpjTGV0ZWhuMEhGRndXVEVpMnVNb3dvQk1Ed0pZUHJ1c00xZklO?=
 =?utf-8?B?UGYvNC82eWxpQnRlRmFtM3JoOFNjK0ZkV0FYRS9odkVKcjgrK3BtSUs4b1Bm?=
 =?utf-8?B?cU1VaG1NWnhiTFEvMG9iSVhISU1oUTkwZ0RZa29veHJFaGU4TGVnVTFwU2JH?=
 =?utf-8?B?YXdqbWJlY2orVFl5c0xQY3lFY2J4WmpCUi9ndU9zVUtCaGcrNWN3WmVDUUhs?=
 =?utf-8?B?QXNyWkVUUWRrc0hKc296dFlmK2Uwdk5HbEJ1bHdUQU5mbHB2QW94L3J6Qko1?=
 =?utf-8?B?WmF1alNrMGZLVDVXcU1za2pxNjJNUTA3MFpSaEd4d2s2TUpmOWVoMmxHYlc2?=
 =?utf-8?B?RndiQy9wZzVST2lmSG5vKysyTHNRUkZHRmhXWjgzTTdOeUpHdm9uODVHQytr?=
 =?utf-8?B?ZTRvVUdKeHozYjRpYVBHUXRUMDM4djN3cThUdVBVazhKWnM1VXhTZURhdCtE?=
 =?utf-8?B?TUVBaTQ2dHhYQnFDeWdyMG1CZTZxeWZVc09UQk9HWHk0bjFTV0Y3R3hPVUk4?=
 =?utf-8?B?MXg3K0YrUWxNdy8xTHJqVTc0UVo2Q1F2b1EwUFVIakRoU2paNDMvUStzSlVH?=
 =?utf-8?B?TmdpZTY1TVJteFpkUnpFL1NZVzRwSVQzUU1tRktpdXpnZ3dhV0pZUEt0M0JB?=
 =?utf-8?B?SWUraGlnQ3NvcFk2UlNNOFdQWXgzcGNleVJmOTlyZ24vOGxnbzBZc0QvQzRu?=
 =?utf-8?B?UmRxcjRsby9talRTMWZHc1ppSFdDRStLWGwrekhjNCtxSXZwWXJFTXZZSmZQ?=
 =?utf-8?B?MUlIdzRIOW12ZWZEOXZkT3ZZSnBuUW4rTlhNYnI5ZkNXeFZIK2dDQ0FFcHBx?=
 =?utf-8?B?NmszYjJxV2tpZk1GOVNCT2J6b0grNGE2NVUxbkFDV1pRdXNBbldsYjhFR2U5?=
 =?utf-8?B?aXBhZXJicWdCdXJFbWRIeDNDRzZabStGbkpURnBLRVhMdGljb0g4WG82SGp1?=
 =?utf-8?B?eFlkM2taRFA2c3h0RytLWmp5ci9UcHlOaWNoNU9Jem1UWVJ2VFV6L0xOOE1O?=
 =?utf-8?B?NVJDT1NUWEk5ekh2K2RQYmZlK3JIN1dRbWdtRDdiMmVrTXA1a1dXbmR3YVdM?=
 =?utf-8?B?T0xPUmN3elRDSXlNTFVqK2VURDlQTmxvRGQrSzFIaC9VcVJQRmZ0cmtlbWxR?=
 =?utf-8?B?aGhFVFRtcis5WWwweEN2azVRalRBK25qc3c2VFR6cC9RU3Bnb256SE55TEE5?=
 =?utf-8?B?QWFwS2doRm9LZWw0ekJ5NkczTS9FKzJCWEVaY1pHalBITCtrYStjaFRyY090?=
 =?utf-8?B?N1hVMTIwVmZENDdjaW1ISGR6am41RzFsRUpSRFkxWXY2eHovRUlJV0FxdUNt?=
 =?utf-8?B?ZEVRMnZFT09sd0VMUUdHN0JQQkduMlBWN1p4VUY0c0RiRGo0TEYvVG8rY09r?=
 =?utf-8?B?MVRiZGVpa2JYOFdCM2JGUTZrQmJBdWRnbjQwaTNxVmNNTjhkTHV4ZnJGcEhE?=
 =?utf-8?B?U0pvelNYdEUxRTByUFRQNnh0TlRCd051T2tnS2VqNG44RGFhMWNuYktOb2pa?=
 =?utf-8?B?c3dRUnNvYk9kTEhGbmNDbjBiZFplVDV3SnA0UWRmNi9mSkJXNkdyV3EramZP?=
 =?utf-8?B?MjhpWFlFUjJyU2tGRXZkWVI1b1dNZGRyWDd6TmNQaG5iYVE9PQ==?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8118
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: db2174cf-4d60-482a-b6e5-08de108e1ddd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|376014|14060799003|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlhWZVROdWc3Rmp3YVRpbnplTGpkQ2ppOHlUTjcxdlNyQzVFZkdXUlFJRTAz?=
 =?utf-8?B?Z1dFYUdaN25VRVVGdXRnbHh6eDAyc1dEWHIvS2hSV3FqV0RkZ2RLVWZpSzIx?=
 =?utf-8?B?ZFREUFBFUXpRRk1GNnpZK09nSmNFdEg4dnpIQlVBd0pOM1JET0VzeTdoU0xU?=
 =?utf-8?B?b0tZUHR3ODF0aG5pcW1YVUl5UU8ybjgxUXFVMHZxNEp1YkhMRi9NVUdueC9m?=
 =?utf-8?B?czk1NGdneFdlMmQ5RkU0M2ZSSi93bzNZdlVVU09uek50ZHFSbzlrcUw4WjVj?=
 =?utf-8?B?bHoxei94WUg3aFdHdUxaMEQzdTFWTEhFTFZNVDF0eWRkNFlHVTg1bG1FS3FC?=
 =?utf-8?B?RDJ0empDNlVVclUrU0YzT1J6SUdJdlJuTkJiUnoyWjUwZm5OQTNpclhIaUxY?=
 =?utf-8?B?N29oUzVqUDhTQnBDcjVHMm9qL0dqV0Q4WXE2bjNuOXBIU3dJM0ZwUlFobEsr?=
 =?utf-8?B?MXkxSWdPYWIrWm9WTG1Ic0xIdFVYTHFSeHVXd00wVkpyNjNkN3h1ZHN5SkJs?=
 =?utf-8?B?R05IU0gvenpNVWR2OHMrTzhqekRIc2tPQUw2dG82SnA3Z3NqYjdITkpGVHFo?=
 =?utf-8?B?RVNNU3lGR2VCYlRWSDVNTkU0QzRMTVRXMFFzVGVPVjY3VmlYQnA2MHZXK3Va?=
 =?utf-8?B?bkxkRW11SW82cHFrMHYrMDg5VmYydGJXenNzRm5MM01JaUMxdS9McmVZTnZo?=
 =?utf-8?B?UlNCZmcwNm9MQ29aM3IxVFRPdzZ6dGhlUnl5eEt2MGtjZnhpc2VBMlBQY1p1?=
 =?utf-8?B?bkd2Nks4ZWQ4UHQwckxqckVrYTdkeUtXMUYzYnVBVmFPZ01EVEQ1eWJUOUFy?=
 =?utf-8?B?bU5JRW0ycGF3bW4wNDZzVWJ0L0hPQlRaZGZrK0ZrME5ia04yUXd4ODlCTng4?=
 =?utf-8?B?ZXNpdTRuaEwyRGcxWkVwVmYrOE40bEk1aThEK2lRU1ExTmNnRlhVclFvQ2s0?=
 =?utf-8?B?VlJGUFpOblJvN2Y2ancxTm90ZzZYMFJld3lvZ3FzbnZ4d3VMOWliUjVLU3Ns?=
 =?utf-8?B?TE10UVJvUzF3b2huZzk0YVg1cXVFSDg4ajJ6aWd0NkQxRUgzR3FXc2tMUk53?=
 =?utf-8?B?M3JYSStQcHhibEZjM0dBaGVCYmtwUDUvNDBIOXRzbm1kVTVHYXZDZXB5TXNN?=
 =?utf-8?B?NXRkWEk0bk5mKzdmd2dtczQ3b0JlRWdTbGdLRVJEL3E4NHpMeldXZXVSU20r?=
 =?utf-8?B?ZVVnVnA4Y3hTUkdhNW15SGZ0NzI2ZzZFU3h3OFFiQ0ZpUkppMjAyTUY5MFFm?=
 =?utf-8?B?dEd4a2hwS055VE8rOW9YTTRXeW5RRzFOYWd4WVYzNDhpS1ZqZSt6RVZndlcz?=
 =?utf-8?B?Ymk1ZS9QNisrZWc3N3p3UEd0SHFFcGhjckExcDFjUkJyQUdydngwNVVZcXRY?=
 =?utf-8?B?U1UxNENmNkRweDRIc29HV3NJNVo2SXVHeTJSTEgxL012OUNHTThoN3FwVkJw?=
 =?utf-8?B?cHZ2Z3dRMTFySU8ySmpQWXI1VE9HWVV2Tlg5eDcyN011OWcveTAzYkk5SWFk?=
 =?utf-8?B?ZnlNdU9mUFlPWVBOVmlkTWhNRHBvbTU2UkVlRHlZVTY3MDcwV2dnVzNRT0R3?=
 =?utf-8?B?SnpjM1Fad25TZU9MeXNLTFF5ektDOUVDUWFoalErKzNiM2FOaXdGZXVQakEv?=
 =?utf-8?B?aXczQkJtdDU2ZGhaMzJCZnkwMHo3K2tnYVVvRzdEejRKU3djaHlQUkZ6QmVZ?=
 =?utf-8?B?OFN3NXR4SVluVnpPWjE2QTU4WlM1MHJpbi9ueDRnSk9XVkM5WHZqSXZEckJQ?=
 =?utf-8?B?NWhrK24wUDdISFVZS25MVWNsbW96RmtGZ2E3WnhMTUJpK3R6VjRLVmhaTDd4?=
 =?utf-8?B?SkpPem5EY0xlRUtvZDg4RE5WQlQyVzh5enpSVGxrWk8wSjgzbkVSZlB0UmJq?=
 =?utf-8?B?SjUvM2lZelhzS3Z3S1NYVWVqY3ZKbHZxNTY1V0Jwam5HTjRTNTJyVThZa3J0?=
 =?utf-8?B?QVdVblRJVGN1NDNNTUllTitsY0x4L0RObnA5enpsa0RFL2FNdWVWV1lDdzJC?=
 =?utf-8?B?NmJuUWVyenloNWE0b3RwamtlT2crYXZZM0UvN1BpRGNNL1lySFMzRklzb2pG?=
 =?utf-8?Q?A12wlQ?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(376014)(14060799003)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:40:03.2585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8665a1-460a-4611-5ec0-08de108e3169
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8009
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

+Ilias to the thread

On 30/09/2025 15:48, Tom Rini wrote:
> On Tue, Sep 30, 2025 at 11:53:22AM +0100, Harrison Mutai wrote:
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
>> Raymond; Thanks for setting up the handoff tests. The next release for TF-A
>> is planned for mid-November [1].
>>
>> We’ve run into an issue where TF-A requires specific tags from the transfer
>> list library, but we can’t consume them due to the recent checksum changes.
>>
>> Tom; As it stands, ours is the only implementation currently using the
>> updated checksum algorithm. There are two other consumers - OP-TEE and EDK2.
>> OP-TEE already has a patch in upstream review to move to the new algorithm
>> [2].
>>
>> I’ve also reached out to the author of the EDK2 implementation to make them
>> aware of the change.
>>
>> [1] https://trustedfirmware-a.readthedocs.io/en/latest/about/release-information.html
>> [2] https://github.com/OP-TEE/optee_os/pull/7531
> 
> OK, but since this could also be deployed, I'm again asking, can we make
> a breaking change like this without having to check some cardinal /
> version field / something? A mismatch in expected algorithms will break,
> and so updating deployed devices and getting a mismatch is possibly
> bricking the device?
> 
Agreed, I raised your concerns in the specification forum [1], and 
similar concerns were raised by Ilias. It seems that the key question is 
whether any existing deployments rely on bloblist.

[1] https://github.com/FirmwareHandoff/firmware_handoff/issues/78
