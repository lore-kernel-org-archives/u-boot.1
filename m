Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270E0C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ADE583DB8;
	Mon,  4 Aug 2025 03:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Frnu2R3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58CB83B5A; Mon,  4 Aug 2025 03:25:18 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7811A83D5D
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZVbnDpkrsKSbpAmKezlIiIgxGmhFA9Eni4YOHsmfTPl8LMbtmiMv9bhggOltxR35fsoy6dHqXtsWQUw99bDxAj7AB6PXUaErPFy0h2OUvDbeYJ5teGFmafTffLPqEdwvpMgvFrhILlm5rYKRUjuxQ14TUzfW/Sgn/4w8KAxTlnY52EVUHDA+UWPLU/CmiyU9PrJwI6QwBxDPxn0N6wNEt8A+wNnQz0q3f9wYw6VCIlDjRtyWmgFUlO0yoXik8NoIeeSEbxMs+H0m6RtVbGw9KCBa90tIzHF7ZlDEUft66id3TqdUSILJbijUYwoQw0XTpl81u3iW1Jxyl2HKuzwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvE4sp/RDYwsthA4NRWeEQI/tety6LG2HyzeO+KogwY=;
 b=q3PjGTm8/EYcHHlDQETXDvIrPeF/26nflxKRNP6cONinyjD1uuRZrfwHeyqilP9AjidgfkRS0xBXHAKSyUdu1OhI4/vpTd9bByJ4ZWWLvdPCOXQTmzmUYVqI2ijkIw4f9u6si/xjIldZSSytN8v6ovxcPKU1gJGZ7Yf3Bg4XvqtCCjYgcqZkS9iYWi2Obvpfv2CN3Y1Xyz0NB4tp2fijN1ttNAjAKECM37sw0ghvnj7DOxXn6SmPYxQpu0VYYJeN00XhWD48gY1ypM46HlumBGcWNasBBsqqGX3PcClTaYi+aNw2MNijc3jpT/drY2nXHmL3uT6jT43FtuOqSeKaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvE4sp/RDYwsthA4NRWeEQI/tety6LG2HyzeO+KogwY=;
 b=Frnu2R3Dkkhff9QxLiFJ8P0g9fpOF+X7xFVL6qZQU1VMbNKqN76UXPE0svMM83sOCnRDET7+RnPiDT+F0mERQGgamBwLL/uG1Sli2+iDX0N76Uxom8NaA4yUhej8iRa3HApD6j1cSe/iQNXjJ495zhXmrt39rZ0jfBB8JP9bGs8TDThAufS0hRtxyv1NGrNqTg49p/DH7zmXE5+utEf0Sfvrguc+7ym/hIABObP/jZHBCgZnczL0jwqhAdLwFPniKxfFnT5eXg68c8wHFVRQ48nkDv8HKXTXcdRguGp0muMmzr81Q7tVVM99ViUJX73qa7j2d88lOPRzjDRHhUddfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:12 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:12 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 01/34] drivers: clk: agilex: Use real clock source frequency
Date: Sun,  3 Aug 2025 18:24:28 -0700
Message-Id: <20250804012501.21811-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a31515-f9f9-4a76-e86b-08ddd2f5c251
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wwo/Y8HV+ea3XLzqgjJrJdXpbfVoZYfTlvxoaTgYwzszTPgV+GKqGESFrCnR?=
 =?us-ascii?Q?C4HDsOIK76Hr5E8cML3Hhf/tUki7VFwZYVUepgsqXjarkEz1D+4R2ihQaPPb?=
 =?us-ascii?Q?h1IA2XDXY+7HBUjQI8dId8cXuhuEPwb0UNO49osxpdnRDFOYWxO35rIF/UF+?=
 =?us-ascii?Q?U3Ka8Yms5Is47URH1uIjn1T6mg+U9MMlv0egn9qwBkpK7hNc7RofyLbLvyhs?=
 =?us-ascii?Q?b4VKS8vsA+29Y/hlmz5ngIkZxxwHbWGpcRduuvxbtwMjTLF0DJISo4oC6yOl?=
 =?us-ascii?Q?6hgvxuL0jETDdXOdxLX+Wb88tXe4wrPlYyiWG71Bs08PALFa6QmUI2BGovRT?=
 =?us-ascii?Q?EK0F95DTDK11xqbtpJPul8RJs00RiUUSxNu16ogod/CsDqzzDBVIK/PQyFMF?=
 =?us-ascii?Q?x2ZKKB37p3bsSK3dgw848GM5FWBoYWhKlcBYKoeIRjQ9LFqa0VY1CLyhMxI9?=
 =?us-ascii?Q?4dyj0MHIuyiilV/9ce6B2CFi15aqXlGhSE31MeXUItw38iwwGroZOWpYvFMp?=
 =?us-ascii?Q?3vQO4nVHYDIgKi3X0msWw6nSTFUGpGs0YTl6jTKkcLyEljUW0ovolDXXWC7J?=
 =?us-ascii?Q?p5BIEEkVC+goqzPElufKVsIF0M6E46udPREZxysJokrTYQ6nMbqzEy5chOnw?=
 =?us-ascii?Q?Mp8XC8n91QW5027EulCWBT8x3xAOclbY+7LVFm/8mo3HcPULtbvFWTi1PniF?=
 =?us-ascii?Q?oRxqJEltI3nGGmV6igQlNOtsKbZJViIH6RbR/Ef8hjkOAJBzAhbrk49/ka+w?=
 =?us-ascii?Q?uVsznaL6EY7shU1sqW9bbFm6DdYG9/K2Zp4CYeG/o6M4c7livXKZb32/Kj0w?=
 =?us-ascii?Q?9uG44xrSCdpJ3gFrLEMfc3AO7Ucjj4OMG3sI5ezfEs8fb5pYno6w8TudzMRk?=
 =?us-ascii?Q?WJov0/NLLWzqBHx9m87E3pzUnSeWLwELvF9IJRJz0pdr6e8CpFp/xaV4ZZlD?=
 =?us-ascii?Q?46gndSh6/CaToa8xtmEXYFgqmWc0rKaiVnID+A0GAkxncOZu4SsunD6yG3M7?=
 =?us-ascii?Q?oiuhAx/EjJ+06da3xv0pwF11PVEmuOeXmoRD91hCeMTfwZE3jRp2GNeSoeNu?=
 =?us-ascii?Q?S6LaGrOX1qVj+i9GZE+u7aDgXBV6ryh1K23FcBRUH72RewmBDFNwKJ7L1URB?=
 =?us-ascii?Q?8wqzWzHWKI7J53qa0QRIrTEP55mgOBGnn/cT8/NN99dY8bepzkIFzaCTZbPj?=
 =?us-ascii?Q?FIea5hpc7c5wpifAyQWmUYeDlTWaRfVUta7bNV4RwUqNUXbA18/Z1lnKEK15?=
 =?us-ascii?Q?K9hOtIn4HLjPQSCLarbpm57XiH1cA/oV0XF/27zlzzWW3coD16nMhY0qrS1l?=
 =?us-ascii?Q?pRtJmqYY98Rmci8jiDXWvN3D4k5G71vRgH55xwJ9V4evygCt6T6LcTPOzzzr?=
 =?us-ascii?Q?JTzBDPMFi+6EZSy+LCsnAbUNu4tFyi4+xy9uh4yDIJ+5y3vOdLB3p+3MBqpP?=
 =?us-ascii?Q?Zm2SaF/ebPA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5zFqbild4FPrrUL44HGZGHKoHWfveugD3k342facaRsmDVNIWbjXtRiGlDpf?=
 =?us-ascii?Q?xu9gDL/fza898brYEkKZO3qsCct2hJUa5XNK8DacwvUuTQj+28PultXEaW+W?=
 =?us-ascii?Q?p6M9zLmMD1g3SUSqJRx+kjEIi42RhjQcML+nIszUrdM9PyJGt1UtehdeiyF3?=
 =?us-ascii?Q?WBFT6X0QG9JZUFJadFFPh/nIWKxmwZTH2WRn0UoZkGA9OWKgVLQYJARJwH17?=
 =?us-ascii?Q?uBIOq2FwRpnKHoGAOYbsxbxj+c2s515VQsMP/3WjNNdCNCUVRT17wdUVLWsK?=
 =?us-ascii?Q?zGw2D5IN+Wz+xAN6GGQOcLfZRsSrSs22DqenHdxqrtkjG/k/d5rCjlbM/mmd?=
 =?us-ascii?Q?czS2ngv5tZHIl+gwyAoUhl58TvowDUG6dA59aeyNCMyd7+p7HDrkH0C3oAJ2?=
 =?us-ascii?Q?HlIzsIam3t2YtrgUUSBat4SlkmNK3L6UcntuiBmE1NZLEEu/LTXrX76ed2FK?=
 =?us-ascii?Q?4qcmhGcRa8QZOPtD/LrgJiyBC3PmX+eVrQ8bNdRnjYndZygr1tz3tatacMd+?=
 =?us-ascii?Q?TYLsIE/CjH/7V7WpShBN2hJpJJUOEIT8SrGHNfYHVUolcha8rhH7dAFJCyYD?=
 =?us-ascii?Q?hThr+advDWiAVS+xaVoJT1HrvHcfDsbxyXPSs6BMIHpd5wHUyJrkIah/AnUz?=
 =?us-ascii?Q?Os4ypGZujTNVs9FqRSK05j3licZutVkfOMpkEqJVaDOTKKCBq7+Ij0nQq4on?=
 =?us-ascii?Q?EUtD8i2joHjGBRZdML7/xz7U9x9pjDKD8I2F2U8XG7f0EC6JgpxJqjGRv6QY?=
 =?us-ascii?Q?w+c8MCFg02mBCVDdzfC2xSNuA19uAAKO77aAtfXxxv+eLX2vq5IBaCfB0YkC?=
 =?us-ascii?Q?WjtsstuFW8I1hWA6bS9/a20jIqLCGFrzzmDrv+TM7X4+iC2MbB9Xc5qu5QES?=
 =?us-ascii?Q?Iu3OLMyj8FmSUyFQ1cyoYYm3iL/VeLeH54LISyhnmL4E9BUqv0x0FV/bxqO8?=
 =?us-ascii?Q?NpxbPrjekTTUk0BKnd8ou+QWB1ZrqNNzrPyciYoYd16PqBO6WmAvtIQoCaPr?=
 =?us-ascii?Q?DxzoaO5y3wbUDc37/SCS+AxXA6sVkXhFzI0wmIK4TMfV1qHfpRPLvcNISMsX?=
 =?us-ascii?Q?8F8NWJyeZ2i8GcMamVZTJPCadKJOZ7WMaRBDnvw4u8sFkace7ogCe0292RB6?=
 =?us-ascii?Q?hwU47cTqIQQkfQf1lxTtWgybiYKHibvUGw+wxWjsiyjOvsOPnuZq3h8eGkMu?=
 =?us-ascii?Q?WRkuf6cFLXM8uJC2CLBSXV4zVoKVhovGDYbaV41Xtd0jmkc8o05HlpW8n8gZ?=
 =?us-ascii?Q?C+pxtoBgT3a/8m9Y+51p1Wxe6xdveFXDj33MIX5arTiurdfK4/fzxVTAGQGZ?=
 =?us-ascii?Q?VziFyB79iGoJQWa7jo+K9RxtzKYLfL+RUW3L8gcIccprdwg61m9EiCh5IVpM?=
 =?us-ascii?Q?Z7qbjWOo5KgIFEN+OWZYXeq2WSXj0hTvYOiEqp2Ao7redKtFvwHeDcb2r/ya?=
 =?us-ascii?Q?HFvDF55EskInMPDpfyUs2IZtRK1hAxEn87TupwuZC8MV6udYpUCtt0cTMruj?=
 =?us-ascii?Q?w/fre0foKt+no/TpCoM/4fuRXsjS9CrNDpMBLLa4yqvQxzd3H+Hznm7ipo0c?=
 =?us-ascii?Q?QgoASrxO+i8obhhXAEKj1CK4dKZI7ZfwUQ47y4tILUzC1Uz3yCojBfBsNL4+?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a31515-f9f9-4a76-e86b-08ddd2f5c251
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:12.7193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpuegLHZX1TJb6OZIDjgwM5IzP8r94TpsiPb8Y1Z7BvbBeUZJyeZrENnx34UwRfFGwh31DAKNe3GINCuHXYIERQNXu+dvcqDuYsrYL4et3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Update the ARMv8 generic timer frequency register (cntfrq_el0)
with the actual hardware timer frequency (COUNTER_FREQUENCY_REAL).

The generic timer frequency was set to 0x200000000 during boot clk
which needs to be set to 0x400000000 when transition from boot clk
to PLL clk.

This will ensure that subsequent timer operations are based on the
correct frequency, ensuring accurate timekeeping.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 13 +++++++++++++
 drivers/clk/altera/clk-agilex.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index e1ddd02f356..b922723d8da 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -6,6 +6,7 @@
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/system.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <dm/lists.h>
@@ -337,6 +338,18 @@ static void clk_basic_init(struct udevice *dev,
 	CM_REG_CLRBITS(plat, CLKMGR_ALTR_EXTCNTRST,
 		       CLKMGR_ALT_EXTCNTRST_ALLCNTRST);
 
+#ifdef COUNTER_FREQUENCY_REAL
+	u32 cntfrq = COUNTER_FREQUENCY_REAL;
+	u32 counter_freq = 0;
+
+	/* Update with accurate clock frequency */
+	if (current_el() == 3) {
+		asm volatile("msr cntfrq_el0, %0" : : "r" (cntfrq) : "memory");
+		asm volatile("mrs %0, cntfrq_el0" : "=r" (counter_freq));
+		debug("Counter freq = 0x%x\n", counter_freq);
+	}
+#endif
+
 	/* Out of boot mode */
 	clk_write_ctrl(plat,
 		       CM_REG_READL(plat, CLKMGR_CTRL) & ~CLKMGR_CTRL_BOOTMODE);
diff --git a/drivers/clk/altera/clk-agilex.h b/drivers/clk/altera/clk-agilex.h
index cd68ebc4387..b3e8841a512 100644
--- a/drivers/clk/altera/clk-agilex.h
+++ b/drivers/clk/altera/clk-agilex.h
@@ -10,6 +10,8 @@
 #include <linux/bitops.h>
 #endif
 
+#define COUNTER_FREQUENCY_REAL	400000000
+
 #define CM_REG_READL(plat, reg)				\
 	readl((plat)->regs + (reg))
 
-- 
2.35.3

