Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A166C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B834882A46;
	Tue,  3 Jun 2025 13:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DX3cJGt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4089982A46; Tue,  3 Jun 2025 13:55:04 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F1CE8212B
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYoIOoARQ8mbUmQ8mWlP7rXsOAsaZxkYew7o8cbfR4Tap3QQ/1R0vavXpRrjsuGwidDvERKCKxkGQRsAkW0D1l/jiQ0rqFiYpJFyYW907CoSYoX30UtYohVcfbd1aMC+hUPU0njG0p3T4plj2AjFxJvQeYXO4FhBLFdwbmYRh3LHsyE8b6yrf/sEb23Ww9OpoHWVqnclp4j3FD7xGxkIdfhnPYwafEXzGdbtqp0flpFu3vAEqyQwx+LkN7YgEkw2sKQ9cPYRnK73qoWQHqQJSOMjv0i5BxcJZlzqo5lZYpuUOqszx3/msAkLpmBsy3adoULLRW+LaH9QhIFdwvwGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2b5QCIgD+rDcA+8TkLdDdr3N9sNfnDC7z8bimZevpc=;
 b=jSOXDMPjcJrEgQ71qTyQparSaZVzLJkB/eM7gPCiBNJiA1obNHJrUlX3zjLT/eedhEMEdAjXHbZKCvkR+i6Bs/BORAo5qhC2m1ONSpAEheQ0sbLFGFtT7dhkJcEGfDHcYH72sM6fKj8TUHFMBNgy7nuTHNptLqdERhM4xLPSxyCsou47GPzkWeyribadEPtSsYz8S606yGQAcYnUEqDVS66KnGbnmgb92P2YLvVKpzHwo+Am3g8e/UkIhG5KDTgzi0oM0TWkujSvbmaKofm7FBRJSv+MU3ZH1fg12OtBdfGCnnzl+mF2LDk9op7lQ5njKmvOuIUXugUa4l5v/TG70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2b5QCIgD+rDcA+8TkLdDdr3N9sNfnDC7z8bimZevpc=;
 b=DX3cJGt2UzkG20LdNVUKzglyq32b0UkicE/lKklRMoLG2ssscqd3bpt4pAKW+fQTIYXL3DCrRxCJ5h96vpI0T2eA2SHkuVA1Ds2FMKBK1MkMk6IV3CUl52XdzTKizHsP66VuVOoQgjwz0svKhdja1zQ4sxucMt9FAJ1p1MKJi7H1oGwFBlcZBQny0WhPii5MIkYIFthjl9Et4zYKZEA13ukElf7UotWaw58u+Hnel7FLT/8XLu1bwgoB0NWpdZ5Kc/qj4ZhwhYhJVbEipvFBQ/L7gtyOPQY5zHWdrPrJXQ61HOrQQzzKXSQbfhVe6auGSdtSZ5+2+PzVB6lpamYWCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by BY5PR03MB5000.namprd03.prod.outlook.com (2603:10b6:a03:1ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 11:54:56 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:54:56 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 1/7] drivers: ddr: altera: Add DRAM size checking for
 arria10
Date: Tue,  3 Jun 2025 04:54:36 -0700
Message-Id: <20250603115442.19971-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|BY5PR03MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fc1811-baf4-472e-8f29-08dda29575d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukJYxKXDv+y8ptpmXFv3uZP+kHp12IzkTp9TPJDBEmMISpnNhgN7TpWw/UzQ?=
 =?us-ascii?Q?ENtNF+v51l1FTXH4zvg68KwHlPafabGAfX2uIeibG8WrSYalRGRiy3TK+kiL?=
 =?us-ascii?Q?YTzdErEV+cPUfKCRsgZGJa+duErwNjGQUEnEtHI6idO14SSQYTSoePqFWxpB?=
 =?us-ascii?Q?Jy+2rykUXy+ebbh3v7R8vH/WAtPAlbwEfUYVUE7hW+yLRybnLeTAyjiywMgH?=
 =?us-ascii?Q?yEf5yVxJUHjLCDs3i/MhRmJ9hibmB69f7U4rhv+Qv3SQXrqnD25Fp63xORrB?=
 =?us-ascii?Q?5Ba+33QOfUiSbeJejTN48wQzd6TaEJUbqN5fVx1W8+fLEF2btYyH79zWiePt?=
 =?us-ascii?Q?FW61IPdyZ3XRZHxGRgbHOrfVPbjrr+aE5GcFZc4pLlo1GMc76RRQm61nfkiG?=
 =?us-ascii?Q?5U2cqKa0AkmHVkxAZ6Kcf9sKy4suOUeDqojpjdctr43V3eKJbL0VO8pyWkIY?=
 =?us-ascii?Q?pJOxW2HDSDF4PGT9Vr4aPdPTBAdWCq2R39/ZhTWFIZgJ8ueW+xG3QH0yJfxl?=
 =?us-ascii?Q?Byku5zpWXiCJousahVVI79nwWKPe3FHYoOm7fTOko5fRXjhdsuevxkRLQiBU?=
 =?us-ascii?Q?Zb7JCcShwnVj8IOQBzSwPrycqN8R0HXl9oOm5UNSqmfyRq9GE38bhP6mXvkB?=
 =?us-ascii?Q?Ar6fRIhAhX6Jn7RdjbyluMb6SjsmPPutUUzvzSSCVx/nxrNm+gETHK7kANzF?=
 =?us-ascii?Q?Mxc5jzwfWRZk9XsUJS4w+HeCt9ln4GOamcg2GM6y2IgNT9G5UOVKCVCt/1il?=
 =?us-ascii?Q?eInn3UZmru+lk/pO3cwnDgVQ44vgO3c1pq0JS4aRl8Uh515BNapm0xWUlQOB?=
 =?us-ascii?Q?lOEalsD3RSISlTUzARQTKlXRq3xGI7xg3KgAZFYUqMbQ54n77PfwgbE/DjtG?=
 =?us-ascii?Q?uT2g0HX25Zz33Ejljvsn0cnC2nthf4ruCKCJFuGJghliCcgLJUfHcZ8RwGTP?=
 =?us-ascii?Q?v8/ZTNowhWQUT0IWv9LXBpwWcQFt9fTJwqXZ2NtglhxrN8drIy8XocGsB3Lx?=
 =?us-ascii?Q?AmFA3vu90PxWtnsuRLrYC/mLJfYPI/yQ6pEPRFzSKB+eEw+KCxiFx8xQ4YtM?=
 =?us-ascii?Q?2ZEkSfrS6ScBgWRTYQEsDDj7ebInYEeo8zw/w2VUyVSjqPoKDQg5W/BpMlaV?=
 =?us-ascii?Q?SMmC8au4CGtAbph/mgmbzEW1FOZLY4wwJ167Hu7kjSkANrpmFaoiByYqfTBK?=
 =?us-ascii?Q?AKKzEnb368yqASV4fsqJ4Ejv7J1zSvHtoMAOWCJxGh5DiHZ9vGT3/6GsPhjo?=
 =?us-ascii?Q?dd1G6QWLfMyBwlC+LsuCiHtZSRFCkYuGXz6FmavotekjNlud6jx1n78qxk38?=
 =?us-ascii?Q?GyL2B8HVyFR4KwXrk/0gwiiVtUcOqHCEwARlKUSLtdu73flDhfvxUKPia+1w?=
 =?us-ascii?Q?KVvpv3w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ti7j1Uns3HJOyzsZT5OKaGGYZwt1HLYOb/cLLNPRFUpxKf4DmawH4DZnB+rv?=
 =?us-ascii?Q?/pb/zWr7isCoVMOvZrbJv/pRnQ3O+M285YP6T473ObjlvR1CdD8ZKuqi4VBq?=
 =?us-ascii?Q?IcMpDP/geWaLNvQRcT6z4PkmVfiwNZWtfhgq7NMyq0XuDOnUVbKrwNEfUuWq?=
 =?us-ascii?Q?l2eSBY4vS8ZXSGGPVzMMKhpnp6qDiuIJ5G3k75pS5jfu0i5UN9A4Z0mGE4Lr?=
 =?us-ascii?Q?ysuI14QoTq1fImOs5WhlPQw0sJldfrknuaUs/ZN7qpjmh52fvqZR6HnobQwQ?=
 =?us-ascii?Q?iFZUON7Q6Ara9MHoJ0MEQUkQ9t14AYHU+ks6eXYfj22EiwsAHhVR8xlE4SHf?=
 =?us-ascii?Q?7fy2EH1NkHywjJ8WKgk28mFOO6qjB/1KsrUzsmKtXpQ3a5k0ucrETWV4pJwz?=
 =?us-ascii?Q?b6OrXe6NFS5XXsxwxtX2NW1jtZgVPrh0zisLdHZkIF35PwCME95brGklg5xi?=
 =?us-ascii?Q?2rtEUkJ2zmuUFnZaV6/+oz6ZvCnJOKzEWcJBBVEVChJfyBchMNopWkFTy+3u?=
 =?us-ascii?Q?9e/gC97o21z+luhkwBl0VvQ2+eiR9LkdcaE1fxs7beeweMzEhBbdhq835CPm?=
 =?us-ascii?Q?Hf5Cb4IIXpWag2YNEI3ckThInWiharav+gHPLhTDfjJ6LECMBENDrqWZiQ8Y?=
 =?us-ascii?Q?38G96Hy+1pMJ8BZrAb2ON5bzGE+899mpewjXHeUF0uJTY4Sch4z5UQI/Tthb?=
 =?us-ascii?Q?N2vDsq5z6xd/N4zDmWjmoIokAcHU6AH2nBTk+S8G1qtJjOgjl78lHzSTkai7?=
 =?us-ascii?Q?klqMEAwG6sv4dHZxLrHDDi4r0I8GSkXpNL8KsuXs5jUphoZhJMEyBwJgXBim?=
 =?us-ascii?Q?xFYNClTpwyugJ/xDvU9oqzxcf+aaj8oIMHmwJnjkA4MNzLHvCRaMpo00FAI5?=
 =?us-ascii?Q?RD89WF7k1EuMpg23EEN9b47/+tvZlDUziZrfATeTYLU1V8nKEHmVeSbJtP4N?=
 =?us-ascii?Q?iS3juudTuHCnkZZH114XHGf4R/3PlzZpk8X1aCtm1hdE9guQM+Km50eWOyyE?=
 =?us-ascii?Q?eWWXpTRdHJPKPi/5R+ljSJq6rTPVOAIE8PS7KuTdXNc7t4K0gZaSYY7/nF9C?=
 =?us-ascii?Q?0CimC6TqeQpeekLdQKuzOCOVMlxEFMU/arN5pz3w2NqkMLV1WQ0IUXAxKlVO?=
 =?us-ascii?Q?3qUY1A8p4cbwm3vAkZeEkHZsHQ820OyG+AOF8nMLyXRFBHMKasRoVbYXlCIF?=
 =?us-ascii?Q?UKdckVkV7r9iQPdXm8fDfp0kPdRMLDqkPIN5FGkBb3Bq3KozVeHpN/JD5jbS?=
 =?us-ascii?Q?8V7f9kdGew3FZlNZUh88Cz5XCIpfsZxwCQOp+mqIIoF3acJ4cp+YeXZtLH7S?=
 =?us-ascii?Q?yyBOEnw4tqFE3G/xLy+iOa8C9ovZ6agGJcvDsi7RAN/vZonwmScI2y1XzgYe?=
 =?us-ascii?Q?2eRLtvYvQokBs9PJugyeyOphPkhaho11K6ZvXOK0rsU83I+yi68HpAbtUKBF?=
 =?us-ascii?Q?nAz6+ORH/p7mQTkLqPcCf2SU6QPn8WYBhiGnzQu2Lwe4g+Bndmsz61nRzUNF?=
 =?us-ascii?Q?XdIt0EKkrrsAr6/8QVmpdf304wl8K2hhNcBSKCHbA2j/f/QvouDyFH4Zlr6C?=
 =?us-ascii?Q?bjpPzEpRwFTDMNuk3ffhQ5jyJU1rf+UKbdJoQHctFQpuOMrRfDcFwhx7byVP?=
 =?us-ascii?Q?44o0xMTa/zveHu0BxP0zKok=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fc1811-baf4-472e-8f29-08dda29575d5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:54:56.8259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbyEpi9jFd4M3otfqccIF/TqFxtl3o/AHeh6CnRaTJGrzXO7U40p7NAOWrqik8xHQAIqCsxreoSbL49qkwdv7CPpeoHa/RCuJYzLQUDqQhFM3VCLqZIba/xHGXejrX6y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5000
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

Add DRAM size checking compare between size from device tree and actual
hardware.

Display warning message if DRAM size mismatch between device tree and
actual hardware. Use DRAM size from hardware if device tree value is
greater than actual hardware value.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index d3305a6c82d..088dc1cb33f 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <cpu_func.h>
@@ -702,6 +703,19 @@ int ddr_calibration_sequence(void)
 	/* setup the dram info within bd */
 	dram_init_banksize();
 
+	if (gd->ram_size != gd->bd->bi_dram[0].size) {
+		printf("DDR: Warning: DRAM size from device tree (%ld MiB)\n",
+		       gd->bd->bi_dram[0].size >> 20);
+		printf(" mismatch with hardware (%ld MiB).\n",
+		       gd->ram_size >> 20);
+	}
+
+	if (gd->bd->bi_dram[0].size > gd->ram_size) {
+		printf("DDR: Warning: DRAM size from device tree > hardware size.\n");
+		printf("Hence, initializing DRAM size to hardware DRAM size.\n");
+		gd->bd->bi_dram[0].size = gd->ram_size;
+	}
+
 	if (of_sdram_firewall_setup(gd->fdt_blob))
 		puts("FW: Error Configuring Firewall\n");
 
-- 
2.35.3

