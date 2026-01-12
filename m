Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E398CF45B2
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 17:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C467483759;
	Mon, 12 Jan 2026 18:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mEfi5lVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489EB8382A; Mon, 12 Jan 2026 18:26:14 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazhn150120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 214E383700
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 18:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hc8dCdjW5U4JK431uXbPL9hUz7Kv4JDAGtgStpVbJaZ/Of/i5Ul5PNKV4VDZs2uOmPPCM/WW5AczvwgNdQhrAKaBV8dTKsljO5UjvKV0+pG3EeYioYbWjWqISCMKcp1ttSrvS4MhWMpkEum9DbzOFILC2ETuCCBrqBOwXAG6tgrKyedR3uCn4P125ZvhCZMuvCgiEbgVNZow8PC6eceMWQaoUBXyPU4exUeN8Jg8FSd7wYhvWYLOfMCi6HgC7OSlMYM3czlVr9yBZ0QPGpBEvWv/3n7rbwQhhfuS8iCPvc4EpQ6nip7kIJL1px063B7j7b0BF54GE4KHTubVEaefgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taskZnzwx0bE7SOSJ23sDm1MNdjenrvDLaZSsac5zVg=;
 b=r3GytpUYl/eRjaxMm9Fs8AAWOrCx7ALOwv2tX/fFaXD4yQLwJ+NWMNqp4YUgXjrR+vqhMRZcw9g8zgYjTAYYrGDAE5xrrinJb8eXeopf4BSXd3Tq0hRBQG8mMKSHQvGX9C16X0VtXJt7CDpQNHcT/dzKJ4lHoLApy/laTNroHZgRumPTTnwPQLN8nH3xaB7tC9ACfA2iijvr2SBoVzvPhD8eU3J5JgJiluftbuIlLmJOep0vxaGBaXRIoU1hFbTA76IVAxf2u6FDXCV4U0BTU3kJm5eWXa+94JSC7TverFLxyUSoP4fnq0osQ/JJ8Osu3pIQOoWF94F+bjEbejXnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taskZnzwx0bE7SOSJ23sDm1MNdjenrvDLaZSsac5zVg=;
 b=mEfi5lVUoXzKnL1nmE0SkYHU5WmLZVP169O2ZQfSTdN+ZXviapPkV2E6KBmg1xD+XYQbTSadTuLkLMlYl7UX1na8to2LLxgQNvS8/mfrKrWZ1Q76qqyGTjHHNk1edAWtCZOxEl0q39yEC8yAsBZw5WMnwByCt/Unl4l+7dXeQWo=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by MW4PR10MB6606.namprd10.prod.outlook.com (2603:10b6:303:228::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:26:05 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::41) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.3 via Frontend Transport; Mon,
 12 Jan 2026 17:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 17:26:05 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 11:26:04 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 11:26:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 11:26:04 -0600
Received: from [10.249.130.12] ([10.249.130.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60CHPxAi865871;
 Mon, 12 Jan 2026 11:25:59 -0600
Message-ID: <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
Date: Mon, 12 Jan 2026 22:55:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: Marek Vasut <marek.vasut@mailbox.org>, <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <james.hilliard1@gmail.com>, <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
 <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
Content-Language: en-US
From: "Padhi, Beleswar" <b-padhi@ti.com>
In-Reply-To: <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MW4PR10MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e29d9f-203f-4ead-98c1-08de51ffaaa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTRKVnFpbjFnc0FnV3pkNHBHYXlCUUNKZW5tRzlRbGhvNjk2QjBUMnczdEg3?=
 =?utf-8?B?b0tDcDh1QjFaSFppWGFnWWsycjV1RUV5Z2MzSkNFS0RoSTVqbElpUnBoMUVW?=
 =?utf-8?B?ZmZFSDRnODg3T2U4TmUvQ2VyZmFLdkxrY0JrKzFQNWwrR09UTnhSMFlBRGUy?=
 =?utf-8?B?bWlONTM5cDdTbEN2Um54VDNSRTFHcFVSVUIxV3F1cW9jVGlrOGNjWDlDM3BT?=
 =?utf-8?B?eEZ0b0UrSnpaVUNxdExCbEFyeHFHa3l6dTB1WDNnbmszZUVzZ1ptZ1BZVmNU?=
 =?utf-8?B?eDh1RWd5NVNqSHhLZS83Ym9BSTk3bGVEMXNpWkppVWJYZ1JKWXdSK0JkRXZ6?=
 =?utf-8?B?TGRRc1E0YVIrbThDZzg3NlBtRVIrUTIvOGxwZnU3VzYyeEtrTExLMlNlaEJH?=
 =?utf-8?B?emk0enk2UlFmQ3ZNK0owek5JWmd0VVFEZWlROVRWTHMrRXZBR1dpejZXWERB?=
 =?utf-8?B?UHhBanBXdUpMSk41dnI2R1c4Tzd5WjB4Vjl6aWlpdmJjVnc2TTA2WmQyRzQ5?=
 =?utf-8?B?OWF5MDhQSHZmdy9MaFVWWFA3MjBtZERlaDlFSGloZmM3cENWTUpLd2Y3Q215?=
 =?utf-8?B?ZTBydGxkeURib1FnbDk5cHFkbWhubGpQYU00QUZnd005U0VxTDdGUlhpTUdG?=
 =?utf-8?B?dHdvUlJwSHhNQ3kxeU9HUHJhK2swMG1rb2ZRQmE1M2NLa1YrOVR0UUEzQXYv?=
 =?utf-8?B?NmNWbkVXU2x0NEc0VTQzREthenVPa0FqSWsxcDdRUkN2NDN1WjB2UlZXVFVE?=
 =?utf-8?B?VlQ5SGNxbDQwdU5QZDBELzYvTTJkK1dhWVB0T1ovbXFxY093Z2dNM1NINHBr?=
 =?utf-8?B?RXQvOWdIRURoNjdiK2hwMU83eGt3Z3M0WHVDYmM2RXo2ZDMwc1QyRWNMMGo4?=
 =?utf-8?B?aitPZEdRSHhNdTdNVUxoZ295bzdxcDJjODlaS1ZEcXEwNkxIVVh0MXoyYitE?=
 =?utf-8?B?UVVzR2dpcDdBUDdFZUZROHJrZG1lOTByZUw5c2pKaGtTeHdCSEt3cys2WVVM?=
 =?utf-8?B?dkx2MVpWWWd5RUtnSW4vYlBFbVhmVWg2R3pWVTNHUlQ5NExCaDJvUzBOOHE0?=
 =?utf-8?B?aVpPcDZnb2NhVFlXUWtUeTY5ZlM1MUVka3dMTUN6NlltWFBubHJ2T1ZqUmZC?=
 =?utf-8?B?OTZrUEI2blZJS0JEWjF4ZDgzRUU2ZXoyQm9oZzJibmVRbk96U1ptTld4anB1?=
 =?utf-8?B?VEtaMXpDbEVxYW9OTXg2cmRlamJrZWdDNm1pQmtHbmY0NTR0OG1HTEU1YTB2?=
 =?utf-8?B?TnlsQVA5clEyZ1hUMUFLeHVoVCs2ZHU3OS9mSHRIT0o4clFBSVdYMGRBVXR3?=
 =?utf-8?B?WFNTZ2Y3dWRqYlU3NWNaWVFIOXRBeVZZaDlrTmtlQWQ4V21pdHVaTzMwU1dm?=
 =?utf-8?B?ekFTNmhJUzdidk5STzE5U01SOG9BODFJOHk4MWZzTzlpMGtNa0ZjUjNDd0RX?=
 =?utf-8?B?cEFVWlRlbDdjdUYxNDV2YmZsRm0rdlBEOU12Zm5YZE9kdlRHVyswM3ZPNVhu?=
 =?utf-8?B?RkxZSlloVTZ4MHdLOHpPZnE5OWtEeHRMbm1tdXpqNGFOaHA4RDRpSTZQQWJQ?=
 =?utf-8?B?NXg5WG5IVnVuTzlmQzUra3Z2cUJYTTgvMGI5TlU5V3llRFJWQUZML3FtWGc3?=
 =?utf-8?B?bGU4WTMwVDM2MTM1bDRqYUhEdkxaSjZhRCt6ZGczUTQ4cjBoNkdKS1ZKeHRz?=
 =?utf-8?B?QzhvMEluQ0JuaGkvQU12Vm1vL1V3d0RBMEhSK3VLR20xQjYzMXYrS1g3Z3Rj?=
 =?utf-8?B?aTFLaXNyeitLZm1yYTJhTVNRd2RuclVMWExvSEoxYkNodys5VEdGMFRSUUcx?=
 =?utf-8?B?QkNhTCtKbnk3ZjlEeVBYTzJaVklldmo1M2x0cWpuQkN1V2V4ZmtqTS9kQnJC?=
 =?utf-8?B?WU5SYU9NSWZsRXBpMDBmNlNUcXd2WVBOUHJRRlpGdkdLamRnKzR3Ty9qbksw?=
 =?utf-8?B?K0hqZlNVTXgzSjJUdGxPMlFDamdNR085Ymw3SjBodmpkN2Q2TXFjQXlMNTRO?=
 =?utf-8?B?VnVLSnZvb0dLdnBENmE1MllUdmYwekRsZnJrSzhjSTZGcVRsSXVobS84MGk3?=
 =?utf-8?B?L0ZZRHFWMWZmeDRRNUNVYkNtb1IrTzNaUFYyUUVjamQ4QThKaGtkKzBiM3Zx?=
 =?utf-8?Q?6LEs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(34020700016)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:26:05.3368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e29d9f-203f-4ead-98c1-08de51ffaaa5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6606
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


On 1/12/2026 8:09 PM, Marek Vasut wrote:
> On 1/12/26 11:11 AM, Beleswar Padhi wrote:
>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>> packed inside the multidtb.fit FIT image. While the individual DTBs
>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>
> Because DT properties are 4-byte aligned, and fitImage is a DT with 
> long binary strings encoded in them. But that is not the case here, 
> because the invocation does use mkimage -E .
>
> Therefore I see two issues:
> - Should the code which handles LEGACY fitImages with 4-byte alignment 
> be fixed to relocate the blobs ? I think yes.


This we can fix in the Makefile via the dd command as suggested by Tom.

> - Should mkimage -E align blobs to 8 bytes by default ? I think yes, 
> and frankly, I thought it does so already, but apparently not.


This can be done, but should it be? Not all FITs demand an 8-byte
alignment right? It is only the FDT which requires this.

