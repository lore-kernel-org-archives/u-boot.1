Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1E7105A591
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C528421D;
	Thu, 12 Mar 2026 13:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="g9wjh9xv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35DBD8418C; Thu, 12 Mar 2026 12:44:39 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151DA83BC8
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 12:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPg2UyyE7g5V8J4ke3gFIAarlZ9wtdTeZGTGKr2uRkjr+nKsH09Y56sVnXGR/uAOTotDR9qm4wDYZCK8B12xdSFgvpUf/BUiF+LjALOV+sogo+g0+rAOn8zi+LNsgMXwsCnzjUi7yIEz+yJFCzCaOV032KMRXu5WCQTeSyJp9LYoyCr6j5qlwC0aScJ5xAyxdl4QCJM3QKMp+93JxWuCpHuc2odBGlziFOFBBMA8VGY0YIwGa2LwVurdE5jazk5F7FjVWpi7Fh6v22q2RK/LP56vk/n19mtyRqrP0BkC+aGLlwzurIAdBvY/thR9cCOwsN6CZWj36WetGZ2z4P5aBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVwDiZPQCCIVqc6DdznvNd2ySpS/XwTOqRkLkllhpso=;
 b=Uv5MDPxnPXdduRg//StlYE+zQ8VhqjIxjNqd9fBsRXHnV5Od1gvLGSwqqmsSpew7kLxifQUHbh9d2cSWA4BOorALT+Yns98L7Ql8pB5/It1OwNke1kv97gIyzzJr6A+/6HwdmxB5npPRE/GCMrqrjmq/aZMcOv6X7O3SDscTzOOcUTGFNDPTmJtAIW37/+/h5mVOTlKAgztMHDbqVoqkw1lbW2WRO9lXxEbQsHm0BV+KtQ6heEc3RpAyDwWGDw100EDBAvvUyNBAH3mycxf8+PWbFNy1qe4ILMUcmTGCxtjdgEcEwmiKwJ/FSwmDC8RAzIVXIXdHqtf5i1Gz/U/qVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVwDiZPQCCIVqc6DdznvNd2ySpS/XwTOqRkLkllhpso=;
 b=g9wjh9xvkkzycmny7/JUBxu+8sl/io48Wt9gDQlSaA9fkvErwvvh4RdbXm+SBVG3KJP34WsBLefRYzVMU0LR8aoJoJHh6hZzxkn7vJ3eshYOVWRk375ytIx2BSAhM0nt8iQOO4OEGjuuIJssEjXZf535R9LRPRwINn7HzsxNpjb5ZSLj/wlnM/aF0AKGUKvRtVP4p8yUwSIfjydtisrfPguXBvLDS4n7Ef5hU86H0BKb/E28KioSHp3l4jAN4k5EJM5KdUAy0dygL+Z8KGfF3t3+5VlKjcmbLQIJnIk6eGaENWQgBYBxW0+UdJJ9OKu3VC30VBX3QkPceJ5f6NLfCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Thu, 12 Mar
 2026 11:44:26 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9678.023; Thu, 12 Mar 2026
 11:44:32 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Michal Simek <michal.simek@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] drivers: cadence_qspi_apb: Add 1us delays in polling loops
Date: Thu, 12 Mar 2026 19:44:19 +0800
Message-ID: <20260312114419.21163-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|CH4PR03MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 24aaef2a-a39e-4702-13d9-08de802cba19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: smm+xJ9t3RryDyY3wYLX1rmSmYcCn9CZGx1ME0JDsehqn/9ljrKFWBmxddKWW15Byv5RsFH0UsMPwF/imm27RiiqH3PU6apHtTWWm5YcxA2G1S8D6fvStkW3Cm9Ir4ZWhSE2oJiekMchzg49+uoc64e2NJp0/I0STMvt0kW5qU34BQQ+6KjdQf5WMoNZieVsdT53UY4NCG499Q42EkTv6cLBxP18mlGm+Bt8Uys4GI+PZFBim6KzJni9dIFIHZFEK+yBIfchgKL/VASp75RiVu8VCzuyNAM9ZLgzGG7F4gwFSrnILBm6+0miPl1KFTQHVsOqZTArGJEYHgCmc+4cdtnBoXVk9Fh4OW/uQT1ZG5+29wImuOAIu9kmH9qlmbW7+9hRYk4goPR/1/iR5RK789z+RihCTCC93Vtu7gZJm6rqFVAQTM6nNkSRQJTuUfIuPR0rktC6E5dPwkBVUlJjZnRszJW9NFbRmedHgJLf4zQXgT7HdFb8rnjPts/bb2brFTrVgfFNiu2Ef9zjxKts0TY1gPP+LhEqyfQrKwXqmgTDXHp7mukTSL/0oCrCL+a4B/jUNeYsCsdHS/WHkBWph/+bWKza31bMSNbctNnSLvwtnmiJ/cxfwGzXzyC9djzVH6+f4txOKznmdcqd3cIUOjPJCwg/vYtVLwY67ziS3Z16G8KKu8e34rHME9CVnsU7gLbBz4gMiaZ9hqG5KfpQ0aStSZ0xSUX14lrU6pwHTeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p46yOrsVUvIcs7mLCczLiRppM/XEUMV6yGdGneiaEgWsLgyu3umubCUumNY1?=
 =?us-ascii?Q?4oUe4AdgR+Q/hLu80TpPh27cCl6Ph0wB2FKdN+1Am5F1+aMo7dW7lIzS0NEV?=
 =?us-ascii?Q?nGKSQcSF6wo7QZuylytaSqSic8LJYVRaFqfDYobvb2gByU0ll4drP12IeUlN?=
 =?us-ascii?Q?4/kUfb8vxbXPaJkeX9QG9Z1vs8dHBGHcAbqX22M8WkIorQwINZCVZCKFCDyM?=
 =?us-ascii?Q?JNp8VWv0+bT+EUZ/ta9wVvs5qPmn8boGsJpEjl3eZWTIc9Yyy8GBNDQqhiAL?=
 =?us-ascii?Q?hDBbcRrn9bDEERF/50t7NIByJpJK5j/4KJnNAGnXdWFioWAmeKTmnPdF6TOf?=
 =?us-ascii?Q?82C8CHYIK8CtlE7uogWgKYOusj5SadW+XOhcIzhYxwx0RjA03PATEKTwUGKt?=
 =?us-ascii?Q?tcIMDdxT+4so2h8/cOizIy82zJNZ1JTQpHVqecWOJEXm56s+rZAzrS+cUTxk?=
 =?us-ascii?Q?5lvDh86T/occUvzR1zoUrQwaPOIwm2h7kaBRU2MMZd3C3xP3YNVx3EBWTPie?=
 =?us-ascii?Q?2PWJIeGGYYhHgOGW+TsYTs/UcAa9tAl3chk4lVjFAffphzwhuKWJQJESV7y9?=
 =?us-ascii?Q?pfnVrpvnEW4kNsBdeZSv5pP7GxvfvVIFGCwP8n3mSxDzyMHOCqMBldeUJchT?=
 =?us-ascii?Q?bTWJAaurCGjU2XtIrBxD3Jn0oRF4RTnQodQYRVBVwsubXsf/0I9ES4kDhq9X?=
 =?us-ascii?Q?HhHI7OqabpKluH0NsriyaPVpbaBK6+RMZcbabjTqvm97frUpV9lavm9oDIt9?=
 =?us-ascii?Q?wWCgDFNIYO5dRWgcy2NQd6STirHdaXKdV8FSx5ea0/XcFitj5l+e8HudH88F?=
 =?us-ascii?Q?lvQb8fr6z2y5QTGCpvIrP5UtQubh8t4eJVY+Zu2DqOppKEbrhmELZiThZl1+?=
 =?us-ascii?Q?/xOb1iaUXhkyO4NlcbHmv+fU+Ve6beX5mj7J1/4mjUkNa9aVy3XUgQd3/0Dy?=
 =?us-ascii?Q?degNQRsjKLiJNlbwITkg/lEpG0DOZm8S1MJehHCet1pJQfl6jDguWFNyM9L7?=
 =?us-ascii?Q?SlnDLEVDPsrYpEEXxIiV6GlC/Q6ctqo+I2R/jKSC7h5ZDuV++eRqZiRNMfp4?=
 =?us-ascii?Q?3VG9w4IIVdkuEoHp/qZt4bXtq88QT76IgYoZuXbTBVWXAgU/4IhJY4WIgrs9?=
 =?us-ascii?Q?6BDzfa2ZAC5gWbLBcD/YqcyGw905rmYf4rA+/nLlnBboCf6uFQYEcXLiNriz?=
 =?us-ascii?Q?69zbuflY9ZYRjt/lL2NzwgceZPLMGug2eNuAmM0GRWcDJPEcZcSmjcZL9STS?=
 =?us-ascii?Q?lGDfD6cIfIybRD4yZHWDhXQ1szzDKDIds/9HRGwiReFlpGWNqqOeO4dkQaGa?=
 =?us-ascii?Q?4vt+e4AbqlAZDb1GEhbgdjZUTOhvyy7YoEqXIo4xUNbhO8qtELtSLk0poYga?=
 =?us-ascii?Q?LYjQUhBOrHnuCofC491j3BVS8jTAmQoY81i1l8OQsf10d7f4oiIJBLT1U45x?=
 =?us-ascii?Q?Dhl2Jbeu2pRsdMS4YOAtp1OwC/Axccea/WeyCnKggnvcKYIhwy1/YtK11fmS?=
 =?us-ascii?Q?EkYBL6iO7zVbEXU/pvORaSFKGlG7Hn9soXH6X0CV1hBQW8wMMbIdfeHtEzoe?=
 =?us-ascii?Q?Rqu5b8w0Qsdp7478ibpB/4FMx1pUrp4St99d5GhFd8kJc8pthUVuXt5vRIDk?=
 =?us-ascii?Q?y5fcgjgEkiUq/oViPyZstHDmuF1TEXX3nn+QoFgLVh6JakHMMQCX/2Vdo/Mo?=
 =?us-ascii?Q?qH/mplnFZnfFMkX8TSvZttEGzBF8WGJdDnoRUWqas2wB0yFdSg/BGnBU5LYs?=
 =?us-ascii?Q?8FkdYof3VQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24aaef2a-a39e-4702-13d9-08de802cba19
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:44:32.6124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoGjSr7G1Np/RzmChUyb8TPPqySWRP3lSQOUAY/jzYBF+rI6DxD2UXVMokFAL/9dydud+Ycfw0132zEVSRwMnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:21 +0100
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

Add 1us delays in busy-wait polling loops to reduce CPU usage, minimize
bus traffic, and prevent watchdog timeout during QSPI operations.

Three tight polling loops continuously check hardware status without
any delay, consuming excessive CPU cycles and potentially triggering
watchdog timeout on long operations. Adding small delays allows the
hardware time to respond and reduces unnecessary register reads.

The udelay() function includes WATCHDOG_RESET()/schedule() calls that
service the watchdog, preventing system reset during extended QSPI
transfers.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/spi/cadence_qspi_apb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 0d4bc685f5d..ef03b263e14 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -157,6 +157,7 @@ static unsigned int cadence_qspi_wait_idle(void *reg_base)
 
 	start = get_timer(0);
 	for ( ; get_timer(start) < timeout ; ) {
+		udelay(1);
 		if (CQSPI_REG_IS_IDLE(reg_base))
 			count++;
 		else
@@ -728,6 +729,7 @@ cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
 			rxbuf += bytes_to_read;
 			remaining -= bytes_to_read;
 			bytes_to_read = cadence_qspi_get_rd_sram_level(priv);
+			udelay(1);
 		}
 	}
 
@@ -898,6 +900,7 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 
 		bb_txbuf += write_bytes;
 		remaining -= write_bytes;
+		udelay(1);
 	}
 
 	/* Check indirect done status */
-- 
2.43.7

