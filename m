Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EAEC79F9A
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 14:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FE98399B;
	Mon,  5 Jan 2026 15:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iYZUpDk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A158399B; Mon,  5 Jan 2026 15:11:13 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46763839AC
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 15:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRKckE7asGg0NH3B3i2ZdlKvoLl4nysHyDPIjJY7Z3Dtt9/fQxADCOPMik8vDOt7IjI/LBQIpFPQnZQj6UAiJV3PiEXQb+1ScW3GR7LBpaMvucbpK6xEGLVNbxkXOMqwO8HsYRT5ne8nHvBE4j2FjEttkl3CbZNN0eKrl5JnOH8/R6PNIdPFMzXEaJscX+R1aeKPCgzycct/Rlwy/W0S9NY/osYDP1PSKgy5ZESugFSL5qJvdRE56Ov3B3VUyBZryBxCsgbGHZRc0b9iAMBUTuv0Y5y2k7i9KxH6U0487qUXTspIifU2FymCEl/3ZhmeJ5JraVRye7VsIgpH0TW8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5ZyzQOS6eIyKd+JJEst5y7PHYYRWKs5X5cG7VKyth4=;
 b=Hqt1vsmWA+YSJ7E2PNuccNu+JOe8Y3y7hU1Z74r2NWfK5BFJHRyZcZXx+wujzLZHxjrVhmrOi/f1I1+iJGwckahE3AaidcSbswjgfajjC6V9DVFWJk37tU3pbMdRhGALbTEWgz25WsEGjesZ7PaXkGgnaSQ2KVDtSy4eJoa6dTTMtLp5SBEDQ1PZExGn6APeuKhpaP9tGjCJJ6VC3rDzb3RpD77L3ElskZUJBmC9RAspfogqG2uwk+J7SagBQdrrBpjHpZtV4syRicvCP4O7jrB7vjfd8Z+2E43etI+hKAnBeStBpPvlAJ0wOWoJRN5Lyrvz4U/dJIPaD3CPWy91TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5ZyzQOS6eIyKd+JJEst5y7PHYYRWKs5X5cG7VKyth4=;
 b=iYZUpDk0+ECbB0aGQFFc8oWqRq0WdJy1PInCbWTus25Xl/GOoA06S5ruQP2AEAwTFak0opC18amr19IFDnw/AAou2/1EAcW4tFNyIgNCkteCYb+h3j78B8MWcwR6ma12I+l51NsJSPb6yv8V1FWjX/0bF97BoeNwJ1MkLsfu76w=
Received: from BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11)
 by DM6PR10MB4250.namprd10.prod.outlook.com (2603:10b6:5:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:11:07 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::b4) by BL1P223CA0006.outlook.office365.com
 (2603:10b6:208:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 14:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 14:11:07 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 08:11:05 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 08:11:05 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 5 Jan 2026 08:11:05 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 605EB5aH1382549;
 Mon, 5 Jan 2026 08:11:05 -0600
Date: Mon, 5 Jan 2026 08:11:05 -0600
From: Bryan Brattlof <bb@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <trini@konsulko.com>, <afd@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 11/11] configs: j722s_evm_r5_hsmboot: Add new
 defconfig to show HSM boot
Message-ID: <20260105141105.ykq2uaelapfqb2m2@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-12-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251231173621.1069988-12-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM6PR10MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 305d587b-32ce-468c-f971-08de4c64452a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REYzcGJlZEh1TUcxTDUveVhNaEVZKzRhVklTazZkekZ1b3V0RU5uaEJaQ1BS?=
 =?utf-8?B?bitTTS85TmxkdDd2bXRVOFc4RWdwWlA0cmZUYkI3Y0h2OUJGbk8yWEtQMHU1?=
 =?utf-8?B?R0tiVS81d091Sk81Y293V1k4RGhGaWZnWmcrd3VHTm80Znc5NXo0ajlzNmg4?=
 =?utf-8?B?NENNQWIvK2ZEMGlUaFJxVnlpZ1BQUndkSld3ZUxiSitrMmlkSjgvbGozdjMz?=
 =?utf-8?B?Q3Bia3RmeDc3SGdGcjBMWXQ5TDV0alhpd3lhZDJLa29vMnN2VjlYQmlqeStn?=
 =?utf-8?B?SGREUXJhWFpDekV1aDJRWnhBYUYvVHI5QktyeDFEMy8wYi94aFBqVjd2ZXND?=
 =?utf-8?B?bWxFeFcrc0tTWXlZSmdocUlMaUNTeGtDczlia3RqdmdCTkZpVjZmOXlxRFUz?=
 =?utf-8?B?Z3BmZFYyclJxeUljVUJXRVg3djNjZ0VlSGk5dGc3bkVRdGxjK1NycE9aSVBV?=
 =?utf-8?B?bGlpeGdZb3p4TFFkUm1NdEZRMUsrSVZqVlQrMGM4bmZFbk1Wa2Rxb0VzQ2tr?=
 =?utf-8?B?NUNFUGVuNXo5VlJiV1NLRHVaWTRuNnVtRHFoWVBDVFJwRXZ2S2dvcTJhNGp1?=
 =?utf-8?B?WVVJUm1rbVYzazk3bFdYU1RZN0E4V09VQ2t3QWJNYnpLK1diNk9SU2xzLy9J?=
 =?utf-8?B?bmhYRE92TkRMUExabjFpMUVScDY0MUpKRGJZd2FiblMzNmFqYkk0Mkx1d2x2?=
 =?utf-8?B?VWJSeXJkY3JHQnpLZHZEaXJXbjhaVW9IVWlFdG0wMCtnYXF1S3RqTWE1SWlU?=
 =?utf-8?B?N0ZoZnVYNlNoUUxXUnVVNGkwd2pDaHNkbDUxeVU0WEtzY2g0YkRCS3Q1aGFZ?=
 =?utf-8?B?SXc1WUZ6YThuZjJ6c1p5YmpHY085VWh0bStvcFlHZWt1Z0ZXalRMYWtqeWEz?=
 =?utf-8?B?OWg1YlY0QVBjeGhzU29SdzRCdFo5WS84MkREcXZpd1pHUHBLV1V0cW1nZXVR?=
 =?utf-8?B?YjYxaFl5YVhGREswSlJoYTQ5b25tdVp3ZS8rT0dybzEzZEtFMjRHRTVxVmpH?=
 =?utf-8?B?clJUZVhpQUJJbDBzMmMxUTR6T25GTWg2ZWhGYktPaHF4UGV4MUgvRGJ3SGtR?=
 =?utf-8?B?VU5COHFkLzMyNE5BeGd3SzBHUGlxTldvdG80cFlreDd4NCtwZmhwaDB3cklm?=
 =?utf-8?B?bWNNdGFockFESll6RzdFd2NpVzF2UEsrVUF0a1NtSVc1blJJVFpyZUVwWUtS?=
 =?utf-8?B?VzlyR2hWVytpSG9XZzdlMnhHem5qRUZCb3B2dVY1WHdwSVJvY01SUkxaTGE2?=
 =?utf-8?B?R1FXUjh5ZXh6TnVFaDd0SUVhYllZVnlaUVU1TEVtSU1UNWhUZlZHUzMvNy8w?=
 =?utf-8?B?cHl2djRvMmxsQjBaMytmbWFjQm9NYzloMjZLbEd5U1lnNEVYdXFqNVFpL2xo?=
 =?utf-8?B?QXE0aTd2QW43Q0trQWw4ZUducWI5YlRxZjRzc0FlWE4xckVNaW1BL1BnOWx4?=
 =?utf-8?B?WlU1WUkvS0FQVXhvZFNMdUVEUXlzZjIxb2E3STUwbEptMzVGV25pK2ZWMkdJ?=
 =?utf-8?B?UDFQTVRJa3VndzM0T0FxRlA3TVB4cTAybldncUJkN3JCQnE4a0l2N0paeVhC?=
 =?utf-8?B?dURxSWd6TXBHWmhWNEJISHlWdU9aR0h6cG9CeXE1akc5amdvcmdMbzB0Z1R0?=
 =?utf-8?B?a3A5TjRET0NON2JkMjJCNWcrSDJpVjVhcVJmWkpOc0xXbWtKYXJXYW0rL1pS?=
 =?utf-8?B?VzNkTHo3VXZVOEtlWUZyTTJaejR0SVFrZ1BxNjZPSFR6bnl5WlNON3NSNUNv?=
 =?utf-8?B?aCtWeVl3dGxiRE1COW1BTkNiR0FCYmhBZmN0OWZ4Vjg3Rjd4WGxTdWJEbFVn?=
 =?utf-8?B?bkQ2bFBuT2FENTkzUmlhVzJ5eURST3dLM3hvc1JlUm43WHFCV1kydWNFelVP?=
 =?utf-8?B?VzNBNHo4ZGs5a1ZhM0h1OWdkVnJQRnZ4L0Z3Ymh1WUNKZ0RkV2VVQ1QrTW9s?=
 =?utf-8?B?c3V1ZzdnSDk0ZE9TcE9LOW5sZUVWMHN5MkdVUjEwSDVnV2lySkhhUlBqT3Bk?=
 =?utf-8?B?blpRRXFRRlZIdE1rNkdZM3pjeDVmNjhKNHVEVzFqRk9zYzZ3OUpOTk5EUVAz?=
 =?utf-8?B?WkRvOThLNTRuTzNtdkJYcHJXWDZJU2t2aWJKYWxFdWg4RmY5Y2VFa2wwdllx?=
 =?utf-8?Q?yDlU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 14:11:07.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305d587b-32ce-468c-f971-08de4c64452a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4250
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

On December 31, 2025 thus sayeth Beleswar Padhi:
> Up until now, the R5 SPL in J722S platform was configured to start out
> of the SMS0_HSM_SRAM0_0 (0x0043C00000, 512KB) memory region. However,
> with the requirement of loading HSM M4F core with its own secure
> firmware, R5 SPL can no longer utilize that memory to execute itself.
> 
> Therefore, utilize the MSRAM8KX256E0_RAM (0x0043C40000, 256KB) memory
> region for loading and executing R5 SPL. Naturally, the SPL size has now
> to be trimmed to be fit inside the smaller 256KB region.
> 
> As an example, create a new defconfig (j722s_evm_r5_hsmboot_defconfig)
> which removes the SPI related configs to trim down the SPL size to
> ~175KB. The above defconfig demonstrates loading HSM core with SD, eMMC
> and UART bootmodes.

I am worried we will need to find a better way to handle the defconfigs 
which are mainly here for testing things. I agree we should have a way 
to test this driver but if we go this route we will have too many 
defconfigs and build instructions for each evaluation board to get our 
code coverage to the levels we want.

And it really only confuses people who are getting started.

~Bryan

