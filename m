Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0367DE9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 08:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2902183AC5;
	Wed, 18 Feb 2026 09:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TC8sDzEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86FA183CB9; Wed, 18 Feb 2026 09:35:07 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C5C83AC5
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 09:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsaAWI81vKQF1SGKozpQHKWvd2h2bZ7RO4qYs4Z5QxU1Mh4jcAcXiGV9XR21YPHfYoraKXUtrpLjdVUWqnmJxhP8FEguZWN9qOcZWpceTk3vy/bZ+0d6LCvkGESrpemDj0qi2Nn5JRQdu1aXNtmtOCikGJ8HCXlaIAFK6j47sxzLmRIhXPfQUSO2/gNrIWTuCj+0MlJQG2ArG8jOVmiRVgVbEkO9kni6HA7vUlaF9MUUE5yYjg2qoZPaSpgAstdQ7iUb/ksHfmqNn2/0ZQSvTDyW6bMP8eS31Cl7+d3d6m3QM3iraKfu4TIsxM68K5RKjt10IFIG9XSDeLJVlf2cxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB5Amtp5smS5udd09IHoSBWKH9rL/trF+T/6fKWbV1M=;
 b=L0tqcb/KkZHq9KPQv0TNMlbK2DauRLOShrNB8auRzdILTO+/3v3cvzO3oFS8c9gu86T6mWts7Makaz+Ae3SycDL8sbZc059+BXqDUQLFG+++QTJycFmuKDXpbkGEMa2Uvd4Wwq05E/4u7XdRvUP+pjNRM1YtI+fFtb1q3I/fhKEFew0rkKIkDihoRawRSMUc+6zeSkgcqLcGHcVnBh3Nyl1ixWJ6Sc638Tlz7OwSMs7/SBOxnMcXkDxuyiAVFoqXZ4Tf5f97FdnGuyTzpfmdldUJdxyq7XVjHKiRftq8ploCpKi8Eqsw8yTx1vhhm/cPxYURrHTkVxeMoJmxBWYM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB5Amtp5smS5udd09IHoSBWKH9rL/trF+T/6fKWbV1M=;
 b=TC8sDzEvyu7nW2ZqSRyxrr2XM5fcjNEiAzjlvulRESW6NQrEMKrqa94xyJt2Wy0lTNUVucbPsSh1J4llVJNWOjprMH5vwmSm7NoUsyzWfVttu5v9tLdRY01yOXvNAFqGljgcp3NAgzHtqPG2j3QjDcHcIYwCVwt+Wc4R/l4gFas=
Received: from BYAPR07CA0061.namprd07.prod.outlook.com (2603:10b6:a03:60::38)
 by SJ0PR10MB6303.namprd10.prod.outlook.com (2603:10b6:a03:477::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Wed, 18 Feb
 2026 08:35:02 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::87) by BYAPR07CA0061.outlook.office365.com
 (2603:10b6:a03:60::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 08:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 08:35:01 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 02:34:43 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 02:34:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 02:34:42 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I8YfQM565327;
 Wed, 18 Feb 2026 02:34:42 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Feb 2026 14:04:41 +0530
Message-ID: <DGHY74TH5SX5.2YM5HTPH5MR6M@ti.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <s-k6@ti.com>, <gehariprasath@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 6/7] arm: spl: Enumerate SPINAND as a boot device
From: Anshul Dalal <anshuld@ti.com>
To: Anurag Dutta <a-dutta@ti.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260217112156.272154-1-a-dutta@ti.com>
 <20260217112156.272154-7-a-dutta@ti.com>
In-Reply-To: <20260217112156.272154-7-a-dutta@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|SJ0PR10MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 388c6b1d-4ff9-4912-f412-08de6ec89bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHR1YmdVdDY1Y0pkcTNRM1RzcUx2anZQYzZRbktMWm14M0ZGVTJRVk1uMWZs?=
 =?utf-8?B?b0MrUk1rRWhaM1JWN2YvTnFVS0wxYmZ2dkR4VyswRy9GclQrdTIrZE8rekJi?=
 =?utf-8?B?eVJXbVYzQ3ptc0I3d1JUdzllazhOVFlyYUJRL2J5Wms5MHdFNndYK2NFd1BJ?=
 =?utf-8?B?OFNZMFoycHdrdHVrK1ZDNythTXRmUTR3STIyUEFnK1VSOFpzRnlqWmVBUnVV?=
 =?utf-8?B?dUdBZEhMYUlEYi90ZEJVNEczRlg3NHVGL3B2RDNLNFJxMktjaEcrT2UrS0NE?=
 =?utf-8?B?SHdxc3oxNndKT0kybjJmdU10QUQxRDlIS3VuU1NVY3NScHFna0pRR0o0dmZE?=
 =?utf-8?B?MFhQZEtTR3VGaXliSEVLanhpOWk1eW1TNWtsd0cyTzZBQlZjdjhuOWhHVXhI?=
 =?utf-8?B?WE84WDBrVW1aalpzUDhqcFJLT3JXamxxUzY0ZDhhWmxMMUg5SnQ1WnJTTnVm?=
 =?utf-8?B?ZTdHRWk4MDhPKzM5NzE1WVREOEFoRWt5d0dMazFJamtwdjBQMHVOZDhRU3p1?=
 =?utf-8?B?T05PNVMyWDd0RCtVWmNMcXNWMmIxZHAyaGczejdZdzFmWm5uQ0xURzNzbklv?=
 =?utf-8?B?aHArT3AwMDRFT3MyYktxN044aWxLcGdQOTRGWDVRWXpkT2t4eFRocGNzM2xV?=
 =?utf-8?B?VzZsbGwwR3dnVHlpTWRoMWtpSUk2eGVQZlJqbzFOTFJHN2ZlMkRHZUhxek1J?=
 =?utf-8?B?L1NQR0QwelVPRkxkNkFIdGhJbzJibHBkUlgzdHpkdEx0alJsSDZlRkR2alhN?=
 =?utf-8?B?emdyZTYrWUhjSWh5MmxzcndqNy92b2RzVWkrRWQxZ0xqR2J4WXFScFM0Tldx?=
 =?utf-8?B?Ni91N3VrNnNhZ3lYbjk4cHBsc0V6dEM0Nm82aGtHNjJlRXVSamZYRFdKSk9X?=
 =?utf-8?B?SFIwY3hNTDVUN3hSWGg1a1BLcXdkUHdQZXpsaVVvSTdWcllvejJjNk9KaEd4?=
 =?utf-8?B?cE8wUHAzYkl0SngvNUdmUFBFd1RwV1pxQUN2UEU5VFBMV1BuMWN1bEhTZHlD?=
 =?utf-8?B?c0UzcWQ2ZnhwYWhTUmNrRG5zQlZzSDBkR1pEeGdwemo2dUFuWExPTkhpdkxF?=
 =?utf-8?B?YnNWUEdaaUlsQnpybmNXeFFtWndaT2JBY1kwLzVKcDBOUTEwdVVRL0FhQUlD?=
 =?utf-8?B?YXFOeHFoaFovbGdheEJzaEhPaTdmenUxdEtneHJnMFcvUUVKcjZUYUdyWG00?=
 =?utf-8?B?aDhwTm9UVEsxS3VDdmdHQXR2MHFWR25ISCs3a2srZ00rM051dUZWZkVRQWFF?=
 =?utf-8?B?RnBVVnhEMGdEYmJENy9QN0RiMzFPY2l0bVhhMnZLTWt3TFpWa2ptVTI1cDRM?=
 =?utf-8?B?VFJ4YmdVdUsrcktlZDN1Y2UxSUhPMURPV2hFM0Q1aFB4SjJyYUNRczZMVWEy?=
 =?utf-8?B?V1c5dERTQTFMNHVyekNIMFVDdnIvaWh5TmhPUHNjZWtWVHJtM25VanVUYUJ6?=
 =?utf-8?B?eUdqRnJIZkZRb3daTlowYitSd21Lck9IbFpRWTJRY25JZXRwRllBQy9SbTUw?=
 =?utf-8?B?M3NvZ0R1NGpIbldTcU5STGFyaGdIWTFxUUhvOThMQisxajBQRy9MUUN0Wjcz?=
 =?utf-8?B?R2h3RlAyRTZvZ0JQVVNzMllJR2crVUhUTXhYU0J3eDd6cG9RNXpBdmhLeXJC?=
 =?utf-8?B?OTF6aUtleW1EcU9JUzgyRWF6Mnd1eExENTZDU3l0d3ZncnpIUmVPWDUzODJs?=
 =?utf-8?B?dmErc2t6a2NjUkZOcjQrQ054NW1pK1BIVEtKZFFoME1TL1ViSzJpWTFlUU83?=
 =?utf-8?B?NTUySklQbm1MSlVYNWIvalJtMkFyYjd0VGFQTlZ6SGx5YlBEdlNJL2t3cVRX?=
 =?utf-8?B?Vlc5M1RKU0RVNUZ5cVNtMUEzMEJldGpqYngzeGgzZHFUbEZ2NEJxaExXVlIr?=
 =?utf-8?B?TFcxZGdDVFFFM0ZycGJZZHdldXc1cGcxVzBVZFVPNmJMN01veXZEUWtOK0lZ?=
 =?utf-8?B?WHVTaDh1K2xLcUc4dm83eVZQYkZZWit0b3RmWXZQYjM1RStJOVNxN293Mm9j?=
 =?utf-8?B?Z3JEQy92emVXV1djS0FwSUE5Wk00Ym9JSTBpZGRmWCt3T21Eb1JRNUNsbUIz?=
 =?utf-8?B?SXMxSTU4a2NuZzkwT2VNTkhyWVE5M05XdGVyQ1lvUkRaeXRQMVdReGZHdS9J?=
 =?utf-8?B?V29XYmttUElRQ2dJTVdVUUZadGprWVBobnYvVUozSElKbWhzRHFUWlZ1YUwy?=
 =?utf-8?B?Y1o5WGtRVEVmQllyTzlDd015U0JZZjduRldjc2d0SHBLcWNwQXNBZ0lxdlBh?=
 =?utf-8?B?Z2ZTOEtWY1ZCUXp3dDZSOWQyTE1RPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mRBPBM1y42DFYzIPXRttg5+Zi7qCmQ9orqVMkbnDOpEltrMFUXKO/7E/bgZkyOnxSZL4Xoks+OEJ/O1RWbwrwEWAuIrHEEdtEVHLcmX21EqjQ8Ypa8qxFZUfDNGxsyACopDfhbayfZv9zA/Ps+EGvCazLoK3R55MfefndYeLTRvysZoP61ZcHIuKZcAyOIZBeD5Obk35uLhwnTk3I+Dd7tenyynZlFmz3dn/pB1Ys9RgbeeYF2xIXMN5/CmwHo5o/FfgfDniFDNxw1Dp3mkD5U9sIp/ua82QB4ezwQnCvCSjIioVcanqr3aevCKe/AcHPfSrc4b25DU0743aByh0xQk/CZdLpxSZ2orcVgIjQDe0lkBEbIOHZuO/OSqJuVy1Ejoc95iBeHgjFUyr0qX9EU/O6bw8eV+dDGMYpdfj5cj1Th7vnzLYzUfjL1MVV8YC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:35:01.7798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388c6b1d-4ff9-4912-f412-08de6ec89bc5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6303
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

On Tue Feb 17, 2026 at 4:51 PM IST, Anurag Dutta wrote:
> From: Apurva Nandan <a-nandan@ti.com>
>
> Add enum BOOT_DEVICE_SPINAND in spl.h
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>  arch/arm/include/asm/spl.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
> index ee79a19c05c..cd9b7942fca 100644
> --- a/arch/arm/include/asm/spl.h
> +++ b/arch/arm/include/asm/spl.h
> @@ -20,6 +20,7 @@ enum {
>  	BOOT_DEVICE_NAND,
>  	BOOT_DEVICE_ONENAND,
>  	BOOT_DEVICE_NOR,
> +	BOOT_DEVICE_SPINAND,
>  	BOOT_DEVICE_UART,
>  	BOOT_DEVICE_SPI,
>  	BOOT_DEVICE_USB,

NIT: Shouldn't this come before 1/7 of the series since we are making
use of the symbol there?
