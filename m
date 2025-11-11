Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10CFCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 05:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5F283AB4;
	Tue, 11 Nov 2025 06:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qca96exX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA1A83AC7; Tue, 11 Nov 2025 06:07:24 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3267F83A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1/pue33QQLI0qd+tF7D6I2hkemGFg59qu4Fnx5YEN/gZCG6+HA3P1qYcjtKyhqZ7CHu5QtW/8XMWnN5BjPiOXBsXwGSjFoD7/o3U4rSTHTDAqU54QFhI3zKCShGyKtUNL3DjOKSKcXgVnUIJ9zALVSRIuJqqOY2xlHbnYvLCw11qTLE/YPFENw1lDU7idmEA9jFkT7Riw0RLPhhT+tM8Qe6f2uzeR/jZYLZk80c1y3kScGI2V5Ic4USSeR6kgrf/Nzdrp7MtSY5LFqQQSlJPhpdwtaN7b3u7YalceneHKBIkA5pzFMiMU5k9Sp4ACjP4u8kcKWtmXt3NUmCuiHXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=betar8nqGq0CcJAmMPyo/lFzRcRgDClUleLusYQOYbo=;
 b=rbdr8tVolkaasX8ncBDqWI+bxX1MEMawfgVt9yquuOJhCuSnjIc+YJV3Lc/l7C5AXlKHpBZ2qJFVlqt3tSzwEMEhErCuWNaNhfI0JAZwpgol+3gzhnvypDUrv7PK2oj8s3wy3sTbpuNqMD04GnaRGLDoEEXHm7UN8s/0dG8pwgaaqvn9xVJqbacGaRp29pQY7AcGDKOX4gF0Kavws5NZ5i9xHvvHPpGxIWCw8Kp/hZ4uGz3ZQLEy6+ZqhMFrTCkhIq1+DPN5a/2KRcwET8BLrhceUBSTjt3zfrl4YAoaNNe/DX0jDqtAkjJycfPXp7QsNuzdTDxew+NPDFgDIXZLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=betar8nqGq0CcJAmMPyo/lFzRcRgDClUleLusYQOYbo=;
 b=Qca96exX/y9dTtSAjLS8ZwxwMOfq/bBc2Qyo8kvJe4d4CaMu/WHcjLPWtC0DXre4uLeR3LsTgCi5KU8R7aH/ea+Lls/KMfw4ksWzKef4pS0IEWk5nJ5kRO/Gv7ytha+2hOSeVXxccEsUtsQYK+RX5UfqkuSZHgnfrfaoDQZb6y4=
Received: from DM6PR02CA0050.namprd02.prod.outlook.com (2603:10b6:5:177::27)
 by LV0PR10MB997686.namprd10.prod.outlook.com (2603:10b6:408:340::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:07:19 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::b3) by DM6PR02CA0050.outlook.office365.com
 (2603:10b6:5:177::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 05:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 05:07:18 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 23:07:18 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 23:07:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 23:07:18 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB57Hwq355631;
 Mon, 10 Nov 2025 23:07:17 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Nov 2025 10:37:16 +0530
Message-ID: <DE5LSEDXZJVV.HJ2G7BOFCC8@ti.com>
CC: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 0/2] 'part name' subcommand and some robustification
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251110205411.4075351-1-ravi@prevas.dk>
In-Reply-To: <20251110205411.4075351-1-ravi@prevas.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|LV0PR10MB997686:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c22b0ff-050a-40ab-87f7-08de20e0305d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzgxRmR4ajZBbERxYnBxUThlNW81NGRsZUhzVFpWM0EwZkpxd3hBbk5lcnVY?=
 =?utf-8?B?YkpzYjNna1oxLzNncnl4Tkk1bDJrbVFodnNXeTcwa21RV1FhamthZStvOUFS?=
 =?utf-8?B?NktuMXVacWJPeXdUL1pJT2dTdW01Q1dkd3JaS3ZNbEtuVk9GTUJ1S2hNRmdk?=
 =?utf-8?B?Wi9TWHBRU1FZZXFSMUVXcTZtcnJpWTlhSVFwdTNPTHRNWnN6Z2FLUVNuZUx0?=
 =?utf-8?B?dVRWTzhORjhCYmN1K01XSVN2SzFHTGJhakZ2Y1VIcUNQVWlvamFueThTRFMy?=
 =?utf-8?B?NTFRVStuN3JKWVcyY1lJRXRZUytoMW8xR3FkbHVSeFMvQVFvSURZZHc0SEVj?=
 =?utf-8?B?S1J2Wi9ZK0p1SWFwSVFPQ2VOWnpsaFlBbWU3TXZzdmZvNnBuZWNYYnQ1aTZx?=
 =?utf-8?B?MjltTE5XNUFHT1hzaW9lYjVWT05XQzM3NFc4K2RZclEreGVkWkpjR3BRdndW?=
 =?utf-8?B?Vm9tT0hWSW14OVIwMVVqZXRvbFpPcElGdTk0RWdBc3ZDaFJwMkJMMCtZbElv?=
 =?utf-8?B?TWg1Z2k0SnNMSVNIYXdHWFZ1eVNlUk8xMVlsVENKOGZoZXNUT3c1L2lsVHFk?=
 =?utf-8?B?bEs3a1lOTHZENHNLOWxNTmJuQUtsSDlsZUY2aFFQYTlQZnNROCt6OENSZFEz?=
 =?utf-8?B?d2JoVWRFM1BLSlpzUGwzem42dWk1NnBSMktOZ0xCaVpKd2hvRXM1U25zTXpR?=
 =?utf-8?B?aDZ2bXp1WTRqWURudHFUREV4SXhpZW9mZitoZlN5UW5IcFRpVFpKdkh3T0ho?=
 =?utf-8?B?RnpkMHcxWk1hd2JRQVFpdHVqRGlYRzd6azhJZW56THZFVDdLb29KTHJOWi9t?=
 =?utf-8?B?a0lwQ2FIeTBtK1VRRjEzbGZxRm5YeklmSjBJQkIyQ1NWaCtZWnRGUWhnM1ZN?=
 =?utf-8?B?a1AwUkNYcjJlMm5zckhRblROUWoraDgxbncxam1hZVp1SDVwbDBDT0hMN3hP?=
 =?utf-8?B?RkJ4NHRmbVZlK0MveVJkckJxVkpyejJoSnk5U2kwV05NUXFmY2I4Z2N0U21K?=
 =?utf-8?B?TWtycHo2cXpqYkFTWlNBSURJVGZMZHFYRGlsQmpSWHJmOTZQVnB3SjQ0azh1?=
 =?utf-8?B?VWtGdmYwbWpjckdDOTJkejNiMHdMZ2VNN1Q3TFE3Nk5objdJOWdJY2h2bHBT?=
 =?utf-8?B?bUdHbWY4NThBcGgrRmR3RGMrVW1GeVZRQ3R2OWpEK1I3OGphczJFQlZSWVJk?=
 =?utf-8?B?Q1FJS3BoZHRzVEp0TGZadFo0QTFtZFhTdDUvcXFZU0wyRWRDaSs4NHpzOS9U?=
 =?utf-8?B?NmwyNnRqa3pwUm5zUTZrMnFvTUJOYlJvQzNTRUhELzhBcFBaclM1YnZyQ2lL?=
 =?utf-8?B?bjVlVElJWHpha3NpaUkyc2JMZVRHU1ZJNTUvZHlocDZRbXN3UGhQb2RGTHgx?=
 =?utf-8?B?M0hyODR6UDE4NytuZlBxNkx0dkJIZE4wSWYwdGZNa2ZBb3NFU1VHWXBCdVZq?=
 =?utf-8?B?N1Q3RjdoR1lIaUVDTmlaOC9UY2VSYWNxRHlkU2lPaWN2YWZjbkw5cTRmdTlz?=
 =?utf-8?B?K1FvRksybHU0ZnVndGRVd282Z0JiTXNpRUFOeVV0M2lwWXNRSit1WTNMUzRI?=
 =?utf-8?B?Y0pRL3VKSFFKcDBoZjMydm93aGw3bHgxcjE0dmxQWjBCTzBxZTd0cjRtcGI1?=
 =?utf-8?B?WjZPU2lqQWVWa2E1VkkzS2QxTEE2STF1blVET1d1NGYxWVpvTWVMOWcxWUxk?=
 =?utf-8?B?VXRkcTBNOGExMEZ6enBXSHB2NW95RFA0RVhhWXZOT3VTdWdoT1pPdlFkY3hH?=
 =?utf-8?B?VG5IYldDK1ltSFlCQ3haUG5uRE01VVRHWTYxT1ZKUnZKRWRVWEFpSFhma1NR?=
 =?utf-8?B?QjdSUnN6Q241V3RURVl6T2c1ZFJDcEw2aUExNUNNdHd1Z0gyUmZUbWVZQXVC?=
 =?utf-8?B?Y2cxUHpaaFBReDVuUmRKenNlMG5Uck5Oc3BmWStTN0NmckRFRmpmZklDUVdz?=
 =?utf-8?B?OCs1TzRBRC95aDNGSVlua0lTQ2hwSXF3ZWFKVHN3Wk9MMWdoc3NpQ3ZmWFdy?=
 =?utf-8?B?bzJWdjlKY1N6RFhHajExeS95MGV3WVQ0TjkxSGZSNjR5dzBneDNuUE1XYyt3?=
 =?utf-8?B?Zkh1a1hHeWxrVjNTZGJaWHdFWGNrSmlKaUxYOUJRQ20rVnBvTEhuZkJvb29F?=
 =?utf-8?Q?2zmA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:07:18.8352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c22b0ff-050a-40ab-87f7-08de20e0305d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997686
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

On Tue Nov 11, 2025 at 2:24 AM IST, Rasmus Villemoes wrote:
> Implement a "part name" subcommand, mirroring the existing "part
> number" subcommand.
>
> In the discussion for v1 of that, it came up that there's a bit of
> inconsistency in how much and what one can assume to be initialized in
> 'struct disk_partition' after a successful call of one of the
> get_info* family of functions. Patch 1/2 tries to consolidate
> that by making sure all ->get_info invocations go through a common
> helper that at least always initializes the string members.
>
> Quentin, I've taken the liberty of including your Acks, as the
> incremental diff in patch 1 is quite minor, but do speak up if I
> should not have done that.
>
> v3: Make sure part_get_type_by_name() can only ever return 0, -ENOSYS
> (in case ->get_info is not implemented) and -ENOENT, rather than
> anything that ->get_info might return.
>
> v2: https://lore.kernel.org/u-boot/20251020121100.1742812-1-ravi@prevas.d=
k/
>

For the entire series:

Tested-by: Anshul Dalal <anshuld@ti.com>

Logs (on TI AM62x):

	=3D> part
	part - disk partition related commands

	Usage:
	part uuid <interface> <dev>:<part>
	    - print partition UUID
	part uuid <interface> <dev>:<part> <varname>
	    - set environment variable to partition UUID
	part list <interface> <dev>
	    - print a device's partition table
	part list <interface> <dev> [flags] <varname>
	    - set environment variable to the list of partitions
	      flags can be -bootable (list only bootable partitions)
	part start <interface> <dev> <part> <varname>
	    - set environment variable to the start of the partition (in blocks)
	      part can be either partition number or partition name
	part size <interface> <dev> <part> <varname>
	    - set environment variable to the size of the partition (in blocks)
	      part can be either partition number or partition name
	part number <interface> <dev> <part> <varname>
	    - set environment variable to the partition number using the partition=
 name
	      part must be specified as partition name
	part name <interface> <dev> <part> <varname>
	    - set environment variable to the partition name using the partition n=
umber
	      part must be specified as partition number
	part set <interface> <dev> type
	    - set partition type for a device
	part types
	    - list supported partition table types
	=3D> part list mmc 1

	Partition Map for mmc device 1  --   Partition Type: DOS

	Part    Start Sector    Num Sectors     UUID            Type
	  1     2048            262144          076c4a2a-01     0c Boot
	  2     264192          417336          076c4a2a-02     83
	=3D> part name mmc 1 1
	mmcsdb1
	=3D> part name mmc 1 2
	mmcsdb2

Regards,
Anshul


> Rasmus Villemoes (2):
>   disk/part.c: ensure strings in struct disk_partition are valid after
>     successful get_info
>   cmd/part.c: implement "part name" subcommand
>
>  cmd/gpt.c              |  4 +--
>  cmd/part.c             | 16 ++++++++++-
>  disk/part.c            | 63 +++++++++++++++++++++++++-----------------
>  doc/usage/cmd/part.rst | 13 +++++++++
>  include/part.h         | 16 +++++++++++
>  5 files changed, 83 insertions(+), 29 deletions(-)

