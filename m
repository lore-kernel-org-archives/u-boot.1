Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3904C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22AB282B7C;
	Tue, 20 May 2025 14:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=draeger.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=draeger.com header.i=@draeger.com header.b="ry5AkTYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CB482AB9; Tue, 20 May 2025 10:41:51 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B43E829F5
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 10:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=draeger.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Olaf.Baehring@draeger.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaWzsdAboSgGgj/fDXRbBw7C6l0upw3kTLLA6P+D83j9CCJhgH4Gf0juxZ19iEVjUqMDOh3qJ5ASIF8Bm1/xDwRAId1WmDzIbZWwiAwIzboBvOc+CpXRVxmaO2Ymi1k7BWAV/51Qw2b9hPxiYsXSQ7W2+mMKZOTweihydWF4xruYTsE79dT92IAxC5gtPDbbs1c7zN9C1zkvDblS+tWqalxH5RptFfpMnaOlopbI+1gk1pnx4t7J2GiVZFKA6za06Sou8BngZ7z4qu/+yxQInj1zoSqmyLUhPLys5kFLuZkbKQ1SBcrRq4HaJqBNzYUV/4NvN3tINQv7smWgLh1RKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pZ2djM1/7T5yZdEiz7b6P4lDWezp5owCQUDsQ52Wt8=;
 b=dbJqhzFnVEjeHHRUljYY6g5ojskOerjv7bUPCKXHkYakIQmo6ky4OgjeYPrPXAUKNrTvIrt3hdGi5OLUyG1fe07dHYLcpJs8DXiAPBBZnT2ZhwlnNmFQk+APWB/3wF34c+05Oetce0gSj06oD0We7fpeXZnghAjiuX8UKeYFgQGkk3NKLELqmwVQacFOhCmsUKOEpS2WK8oMwQeeiQE1ury1YkYPfgLMq+G5/+3Th45OdkdeaQuhf5wpLe/+wLB1adyqg25cDO5f97mTo3ORlUV6oosch4GF5kzCuRQ1d4u0awcJY3so3LeQFfkdaJZ0whXG80ZrKlnpOCKZ4fqhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 46.254.126.174) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=draeger.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=draeger.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=draeger.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pZ2djM1/7T5yZdEiz7b6P4lDWezp5owCQUDsQ52Wt8=;
 b=ry5AkTYkNdDHGbKqX5mX1op0msuVjVWAL+NWg8j08Xb8TAzFiPE0MDT0GD5NJbIXjc6YYx11O7NtIpsi+sLCxjwPtifHnfQ1PlcWVRMv070lIRhcxxnf08vjmXSfnR5xjmHHeunjzJ5DNq7a20tX75oGHdQpn10JnuMTOYT+AO1n0tuqkqSXtzt7LdNcZyC4kIeDrwVDk6J6DVtYQxJPsb3g+ZpTRPtnnu6xNq/xvdL4K20qWRL4XLT2G6s+Lc7KaF0r0uxEdQSju2SYfmT7D0j+nWrjKRWkXAJpb5pvwSUi2/Hc+PEcO0elL/HcO4hHEhdhj3WDYAIoh3hCoQROrw==
Received: from PR3P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::13)
 by PAXPR03MB7562.eurprd03.prod.outlook.com (2603:10a6:102:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 20 May
 2025 08:41:42 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:b6:cafe::13) by PR3P195CA0008.outlook.office365.com
 (2603:10a6:102:b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Tue,
 20 May 2025 08:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 46.254.126.174)
 smtp.mailfrom=draeger.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=draeger.com;
Received-SPF: Pass (protection.outlook.com: domain of draeger.com designates
 46.254.126.174 as permitted sender) receiver=protection.outlook.com;
 client-ip=46.254.126.174; helo=oa.draeger.com; pr=C
Received: from oa.draeger.com (46.254.126.174) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 08:41:41 +0000
Received: from shamak6001.corp.draeger.global (10.246.85.80) by oa.draeger.com
 (10.246.85.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 May
 2025 10:41:41 +0200
Received: from WDED5532.corp.draeger.global (10.52.142.37) by
 shamak6001.corp.draeger.global (10.246.85.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 May 2025 10:41:40 +0200
From: Olaf Baehring <olaf.baehring@draeger.com>
To: <u-boot@lists.denx.de>
CC: Olaf Baehring <olaf.baehring@draeger.com>, Gaurav Jain
 <gaurav.jain@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2] caam: bugfix CAAM error on startup
Date: Tue, 20 May 2025 10:41:20 +0200
Message-ID: <20250520084120.4175862-1-olaf.baehring@draeger.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.52.142.37]
X-ClientProxiedBy: shamak6002.corp.draeger.global (10.246.85.81) To
 shamak6001.corp.draeger.global (10.246.85.80)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|PAXPR03MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d470991-7aae-4230-2cdd-08dd977a24c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OG1EMlZqSU5BMlpXM2pYSTZTYm94QTFoQ29QTGVMU2dXcWxFakVSSnBVZFZF?=
 =?utf-8?B?K0c0MDd1aXhsbkFYaVliU1NuQWtHSi9wTU1DNVJiSGNWRzVKUVg5NGlrT25m?=
 =?utf-8?B?MVZSL0hScWtQYStiRUtZTmw0R1FWZGJkMnJCeGZuZ3dUTXVhY0QxSVE0bjhl?=
 =?utf-8?B?MCtGUFFhelZrTklzdzZSRjlLQTFjM2h1ZUdOTVZqcjBrRFJMaEkrRFIyUkxa?=
 =?utf-8?B?eG5wMjRwQldLL2pSKzRtbjVxRVdKVTZrTjNoSXZ2Tm9mbkpneWNMU3JsUllr?=
 =?utf-8?B?d0d2eVJCT3FLS1VScWFUYjBaek9QL3A2elVodjlEcDUxbDFZMWkzVHBmMVFu?=
 =?utf-8?B?S2ZtekMzbEFXM3FUUHF3WnVnK2lOcHFjT2cxN3pVT2RuWWdvellmMnNySU5n?=
 =?utf-8?B?bUgwb2Z5ek9OZU1aSXF3OTJTYnRrWlB2L2dMT29obThBMGdKUnFRWkd0Q200?=
 =?utf-8?B?UUprTFc2emVYTFEwdlNYeFJzTDBhUndjc2J0enI0MEtaZTBreURldm1LM3Jp?=
 =?utf-8?B?MmxCUHFMMHE5UElVTThqS1NzU1Jha2N6aEduWnVYaGVYZzZkblhaVHpGaXEz?=
 =?utf-8?B?Y2o0LzNGNWhMTWVIKzEvVGJyZ2xZU1owek1CMVFsY2dsa1hTUVJQd1hNV1M3?=
 =?utf-8?B?VTZrd01iTVBaTlhrV21tTG5PYW5OTlR2Y0lVT3BBQnJJN0xabWJUTlZnZllC?=
 =?utf-8?B?TzhCQW8wTU1IZHFmM0VNN3hLWHgvR1dBaUNoTGF2OXBzZk9HYnpKL09WVUJO?=
 =?utf-8?B?eTNSRG5qbzNOVWxpaDNFU3dOTzZOczN3VVpyZ3RncFJzYlVhelRtZjd2aFJ3?=
 =?utf-8?B?V0pwalc2NnI1dHJqK0Q5cHdCSzNUM3JGNDU2WllUMk82S3F6MS9HWFQ1NTAy?=
 =?utf-8?B?M1dqWThzUDZKY0JteDBCdS91THhGVlJqbDRPUUpEQWJkRjh1dG9LYU8rb3NV?=
 =?utf-8?B?WVlPSDRQQ1lGbzZUbkZNcDdTWGdYc05PZDNiSDVwUHdBMGR1cHZqbWVFWDgx?=
 =?utf-8?B?RStwa05MWVJOUkRMdjU0RDREMk1zOWF5OTdOUXFIdmhsRTVodEtBc3ZQazZh?=
 =?utf-8?B?RkxkQTFsM2N5cDRTcW0rL3lIQVF0N091TmZZZmdpRkJLU1F5eDA2SjVmZ1Q3?=
 =?utf-8?B?SkF1T1hTQ0Qrb0N3MS9lT3VIdGVDVUNuQTVpNVBzTGFVUXlwVzEzMjl2a0FL?=
 =?utf-8?B?aVc2YlJLU0R4ZWt1Q1E1OGRqUnVHNmRwK1RKbklIM3Z2cXRSMVBVRGNOK000?=
 =?utf-8?B?WUZhcWZGTS9XNXMrWFlQcU15UDNxR3VsUzJoSU84WW9YbUFaWldFaENaNUt6?=
 =?utf-8?B?NVVxOExhTlFNSitKRTdNbHkzQXdET2VlZmJhQXhjZFhaa2d1bDlvTWJ6Q0hn?=
 =?utf-8?B?WkNLUGZGSzg3eW9hVHpGQ05LckU2TVNETUUrS1o1dFN2TmFqSHJnTkk0ZmZV?=
 =?utf-8?B?RGd2eUh1N0wrQlZTR3JUbzJRZHJlZ3d0VXhWUCtQbGpiUUY5QXRwQXJLS25H?=
 =?utf-8?B?MDI1L3NjT0ZobTcwNUxjemFPVkFIQTAzemdHVTExZzFLNitndVJvL2hGNVJP?=
 =?utf-8?B?Umo1WVZSdHFqS3R0aXR2N3NOMkJKT2JaY1ZVTjd4dGt4VWRZSy9SNmVyTzF1?=
 =?utf-8?B?SE10NWY1OEpnQWVGRU9yMlUvc0N0SjNGaE11akduZmNRWFZCb1BVQnpzQWRv?=
 =?utf-8?B?c2t4eHNML1dXczFFZlUvaTNBYWxXTUZWMGVaUW5zRW14ZHhYVW1qWFZqYVkx?=
 =?utf-8?B?Wmt0SGRzMk5IZXJCYUY2aHMzTCtGT3lycmM1WDA3S255L3R0cXJDSXdFSDZP?=
 =?utf-8?B?dGlBODE1L2FZbEdXcUEvYTRLZGNOcEZzZi9GUVVzcVAySzJQRlZtWTBXemlB?=
 =?utf-8?B?SW93S0NCcDB3aWZ5UnczZFZjVGw4VUwvT2JXRDIyaTNONzE5RFZ5dTJ4eEJO?=
 =?utf-8?B?dlhHV1dKRVVzblA5amNERHN5bHVhaUNZTG10eXNxRUhKajF4ZS9oTU1OKzB4?=
 =?utf-8?B?bnRFMFd2MlFjMWR0aThCdHBVS1o5L2k5Z2NZR3JOQXZRV2pTMTh6S0EwdS85?=
 =?utf-8?Q?lnvrTb?=
X-Forefront-Antispam-Report: CIP:46.254.126.174; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.draeger.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: draeger.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:41:41.4484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d470991-7aae-4230-2cdd-08dd977a24c6
X-MS-Exchange-CrossTenant-Id: e8d897a8-f400-4625-858a-6f3ae627542b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e8d897a8-f400-4625-858a-6f3ae627542b; Ip=[46.254.126.174];
 Helo=[oa.draeger.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7562
X-Mailman-Approved-At: Tue, 20 May 2025 14:28:26 +0200
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

In rare cases U-Boot returns an error message when intantiating the RNG
of the CAAM device:
=E2=80=9CSEC0:  RNG4 SH0 instantiation failed with error 0xffffffff=E2=80=
=9D
This  means, that even when the CAAM device reports a finished
descriptor, none is found in the output ring.
This might be caused by a missing cache invalidation before
reading the memory of the output ring
This patch moves the cache invalidation of the output ring from start of
the job to immediately after the notification from hardware where the
output ring will be read.

Signed-off-by: Olaf Baehring <olaf.baehring@draeger.com>
---

(no changes since v1)

 drivers/crypto/fsl/jr.c | 30 +++++++++++++++++-------------
 drivers/crypto/fsl/jr.h |  4 ----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 8f7a821ebf3..edf678d363e 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -217,13 +217,6 @@ static int jr_enqueue(uint32_t *desc_addr,

        jr->head =3D (head + 1) & (jr->size - 1);

-       /* Invalidate output ring */
-       start =3D (unsigned long)jr->output_ring &
-                                       ~(ARCH_DMA_MINALIGN - 1);
-       end =3D ALIGN((unsigned long)jr->output_ring + jr->op_size,
-                   ARCH_DMA_MINALIGN);
-       invalidate_dcache_range(start, end);
-
        sec_out32(&regs->irja, 1);

        return 0;
@@ -243,6 +236,7 @@ static int jr_dequeue(int sec_idx, struct caam_regs *ca=
am)
 #else
        uint32_t *addr;
 #endif
+       unsigned long start, end;

        while (sec_in32(&regs->orsf) && CIRC_CNT(jr->head, jr->tail,
                                                 jr->size)) {
@@ -250,6 +244,14 @@ static int jr_dequeue(int sec_idx, struct caam_regs *c=
aam)
                found =3D 0;

                caam_dma_addr_t op_desc;
+
+               /* Invalidate output ring */
+               start =3D (unsigned long)jr->output_ring &
+                                               ~(ARCH_DMA_MINALIGN - 1);
+               end =3D ALIGN((unsigned long)jr->output_ring
+                                       + jr->op_size, ARCH_DMA_MINALIGN);
+               invalidate_dcache_range(start, end);
+
        #ifdef CONFIG_CAAM_64BIT
                /* Read the 64 bit Descriptor address from Output Ring.
                 * The 32 bit hign and low part of the address will
@@ -283,28 +285,31 @@ static int jr_dequeue(int sec_idx, struct caam_regs *=
caam)
                }

                /* Error condition if match not found */
-               if (!found)
+               if (!found) {
+                       int slots_full =3D sec_in32(&regs->orsf);
+
+                       jr->tail =3D (jr->tail + slots_full) & (jr->size - =
1);
+                       sec_out32(&regs->orjr, slots_full);
                        return -1;
+               }

                jr->info[idx].op_done =3D 1;
                callback =3D (void *)jr->info[idx].callback;
                arg =3D jr->info[idx].arg;

                /* When the job on tail idx gets done, increment
-                * tail till the point where job completed out of oredr has
+                * tail till the point where job completed out of order has
                 * been taken into account
                 */
                if (idx =3D=3D tail)
                        do {
+                               jr->info[tail].op_done =3D 0;
                                tail =3D (tail + 1) & (jr->size - 1);
                        } while (jr->info[tail].op_done);

                jr->tail =3D tail;
-               jr->read_idx =3D (jr->read_idx + 1) & (jr->size - 1);

                sec_out32(&regs->orjr, 1);
-               jr->info[idx].op_done =3D 0;
-
                callback(status, arg);
        }

@@ -378,7 +383,6 @@ static int jr_sw_cleanup(uint8_t sec_idx, struct caam_r=
egs *caam)

        jr->head =3D 0;
        jr->tail =3D 0;
-       jr->read_idx =3D 0;
        jr->write_idx =3D 0;
        memset(jr->info, 0, sizeof(jr->info));
        memset(jr->input_ring, 0, jr->size * sizeof(caam_dma_addr_t));
diff --git a/drivers/crypto/fsl/jr.h b/drivers/crypto/fsl/jr.h
index b136cd8d05a..8d5ca03e501 100644
--- a/drivers/crypto/fsl/jr.h
+++ b/drivers/crypto/fsl/jr.h
@@ -83,10 +83,6 @@ struct jobring {
         * in-order job completion
         */
        int tail;
-       /* Read index of the output ring. It may not match with tail in cas=
e
-        * of out of order completetion
-        */
-       int read_idx;
        /* Write index to input ring. Would be always equal to head */
        int write_idx;
        /* Size of the rings. */
--
2.34.1

---
This communication contains confidential information. If you are not the in=
tended recipient please return this email to the sender and delete it from =
your records.

Diese Nachricht enthaelt vertrauliche Informationen. Sollten Sie nicht der =
beabsichtigte Empfaenger dieser E-mail sein, senden Sie bitte diese an den =
Absender zurueck und loeschen Sie die E-mail aus Ihrem System.
