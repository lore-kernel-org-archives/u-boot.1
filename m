Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C85C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89FDE80EFD;
	Fri, 28 Aug 2026 10:50:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ofr7VqLaOD1; Fri, 28 Aug 2026 10:50:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914229;
	bh=/HFmQHB1mpvqROUWNt4sNzcNHv/2feutczm0y4IPD7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GdVE2nmSuNA/44ZZpczcvA9KraaYA6RS73a9ZjnmHXf+eCrpHzgB15sZwwIwCly51
	 PsTlz/Xk/ObjF9pXBCBdTFMDnPFnNqY2quv9sMk14YO6Wf/WLe66mGC+GFf29sSFop
	 UHjIygjW3psedEg+rGjzISBcA9KUjQkQ7CB/mUvxgzw8nOjwZk3RIpJgzMI57ilIuS
	 e99wQ4y6W7BEGSbbcgb6tt6/VHUoATFiyfDCowj535Re2oUy5EIUAQAFEfTdSt9zNV
	 e72bipUu/LJXwthMF9Xs3Gc0GpzZ+barHOULH9BQEIAs+ek6ol+aRi50p5MUhsLoL7
	 7IeIpd+92JvxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A1DB80EE5;
	Fri, 28 Aug 2026 10:50:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0291C105
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8F804082B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aov62hz1-t_c for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:50:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=ABxayU2a
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEAD940830
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1h4GghT0+6Jx8l5hc1oCPDdxV4xvdqReYDOF8KoH9WrVuaOtUjIesxhmDMyRNatxeUX3Eww1buu7H+MQ1Nq7jx3AUadgzx+6gw66T0NX+ihCtYvsyMReTFs7uiWJ/5DZshEv9RabAtPV1NBd0UxYocHa7LR62DCH/nAHdb7xK46MuLqAANyPAEUEARMXelNaZzeT0mfU83QJruKKCC8/GPrlYWxaDQo3sQKeXOUBYfPZiEWkmZYiFOO751JxR/T+SQC2dC8Ti+1OgnFaoAyk02Upgc0AV4oB3kl6tCtTBYKC9cxu4Owj1UHfQdB2c4ZOqMSbWezVM0jkKZVl4fKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HFmQHB1mpvqROUWNt4sNzcNHv/2feutczm0y4IPD7k=;
 b=OhUo1RaQu+0PIghJ4M30S5DjlMNkcUnYJ3jIL784h+oo+OgBmdo1nGcEl9LkIHtYV3FqP0Y7YIvCKs+H9cKlwWbC+qScBvjfcQ2za4s0Xhju3TKnmnMAeaKlNfH7LBTUnvpO9J5b+Q9COKrEvIJoK1i80+phnE/XMyiE90WxLgJLT1NDCPmr/posyeqhHqrgJHaMFJ4heCuFYSkRN6UMbwuhM869JHctz3aK/GQRlDWc6oDXadd7nJu/MrJzmrk5segPJgI+m7lxm0Z7zt4YXTip6bkmdLmNrmBArdzInbYgq0hg8sk/F+h/wlya/+3nfg5FYedoBXYdd3t2DMd6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HFmQHB1mpvqROUWNt4sNzcNHv/2feutczm0y4IPD7k=;
 b=ABxayU2agQ+Gq93Z1xAgEAVJItkgQY/sTjK4v2Aa1l+WPBIqRy4VgYKJMdsXO8z9R/9RlHKcPrqaiVLaJYGpdYXvIc/KCpkpwvtonkhwq+neruWy5ggXHMCVvsByLghlnp3Cbvsu1WzT3pQMfgPTGtkCUtkx7oNVrVct5LVWZn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 10:50:13 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 10:50:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/3] avb_verify: read_persistent_value: honour contract
 regarding too small buffer
Date: Fri, 28 Aug 2026 12:50:05 +0200
Message-ID: <20260828105005.200338-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828105005.200338-1-ravi@prevas.dk>
References: <20260828105005.200338-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0052.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAXPR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: e5958a81-1325-4201-b0f7-08df04f222f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 08vFN3stITchNr3Gf+wInevCko4hTBwwu+MC/RD8XX8v9OG9Pf50QwHYyJz1UlAh9n2CPrAK3EKXzsGpQWmB2LUfdDTES8a7ray/OC0e5QRkqorW+SKXjNl8yHB3smtP6xhgOfCQ2ECNMzaB2Y/vEfZg9X5j0ypjfYWG/6PHiYIF+fVwQh87YFqUbqMmi050CjEGf7vBD2ZAGVZkoWtNFwDEN8ozVv9sOTqix5301X8xi6+sNRIXmflxZZGzBvzMck/JWKfGpq2NPstYNmAUbWNNxnTZ05PQoAQ9HZ6PIKJNSlc00DokpAIzelnwmyDQwigLry/WtnkXTe1ShxsdeuY53pMlYIlDNiV50M2P9XsweVLkpPpwHJyfvgMzY3UdGNStbS/pozssAMlk7ihPf5hAyTq/PHsf40jOSlgc9JADcrtQztgzoGkTUKlUEtdks0hCvj71JlMyCHFR4jWqRfuNCnkDOxvSU8zWqa92qe1y6tsoCdfzec8zL1fuYn+FME3YoGVni2j1Ctjdd9/RK7snOrUe5Td4Mp4X9WyrLZqSkcdNKRifankOHreRsuHH27kPKiAuSGFQcGJKCetjxOda2HCdviaHR3+DEvimEs27x/rJyZLSEEJToKsOnpEIUEgZnamnMNrSy2wqfXTp4WviK6ikJydNpfWrbkSGDnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0m1AJE2o0emsiyQhemykKaYrnRiTa6IhsbAatLzonSBBgU4d1ctKVo3+ATU?=
 =?us-ascii?Q?MB9gESOEMUzOq1a+umMAP6Bhq8+IJtm1shAQRf/UJky1NgeYIB/6ozkfMge6?=
 =?us-ascii?Q?Duez693+3d0MZnLN/jH4TNQXfCNnUAjAIbEC8p0ZCcXS4MmPvxzah0uOiMe/?=
 =?us-ascii?Q?5K5aXlwVgV6UoQiDYAdIbwyXmtKMtV6qD5E4jTenyk14Y+1UAXWWEV3OicxP?=
 =?us-ascii?Q?84Cml2KsluMuypr7/uKqcdlbBie+XLaD8zy8I7RxDVrRxpSOh+oKiVtZrC5i?=
 =?us-ascii?Q?PE8/G2zezAIFd0xkuJuXP5XU+qLt6mdF2uM/FOYAiyej7bGWEdkMrMBmEIa1?=
 =?us-ascii?Q?ZyAMzymqSIVN5UXQt472bYmtJHkoI6+iDnN6hYrtx/Q00KYEFPvwLGQxMX1l?=
 =?us-ascii?Q?DdIgM7bHY4203Hh9Hg5zlrL4Aq/miAhDnJ7HUJnA2ixVrABJ2OfwHauxEIoz?=
 =?us-ascii?Q?9RMiO5mtXd8vdzBQNme1lhwaDXA178srRqiDDeCimDUiNogDq2q+l0f+WZwf?=
 =?us-ascii?Q?gWyylAS3UpBBL1YHXcqn8M2gvgbGL0+mw/xyb4s4yyolc527/DjJZjxyhQVc?=
 =?us-ascii?Q?mdNpcR82+a6kP9H0XXfPhDtYGHrmrpXdCaHuNs9lsycHgDwmbd8f+ZX2BCgY?=
 =?us-ascii?Q?oxRvneQhuczoAZO3/nyYMSt623MRM5qgaDuzGonVccy3z+SyXKUBmX97jX6J?=
 =?us-ascii?Q?MUWjbwFu9+AzEiHZFHFYWX2re4Y4/3p3FSePQDOC9Ph+11qcy/+IUdpahE8f?=
 =?us-ascii?Q?9Wf8TUABxz9ASkijOroTxkNhXwSD/FqmeZ2KEYcSxZzyl2JrolUs+X0piocH?=
 =?us-ascii?Q?9mO+AtfgKbnBFEzfPmL7oygbw4YREtkTq3TG9NF0TUDr7qPno0pDROf4Hrw/?=
 =?us-ascii?Q?U63HGhnMwIDeKOYnRZftMmARtQJLD/QCrDDaoFCJWCjv5ArkGgta29woQjZr?=
 =?us-ascii?Q?+bcH1+RMFHbVBlMxOvzt9AlvzrNuUpYx+CU69LVU5Hyh6eSfPYb5eY2QvvGV?=
 =?us-ascii?Q?XnBn3OI/4VgQIIVkYaEMK8y4ofGheuWKQaExIF/BvuZSum8ZRluggR+JyA7e?=
 =?us-ascii?Q?Uw94XiUzpFP9R89fg2lyhUJPcLBiekKEUOKMkfo3UONwJEznYO0SH4wvzbM2?=
 =?us-ascii?Q?hTiLwgr6tQxZsvjwgDze+KANfZRx582aUn1u1CMXe5Ouq2ZMe9p16Br87X+W?=
 =?us-ascii?Q?G6VcDDJZGUCFEAe4VTIRsZiL9tTlv/XkoacWehd+os/21IZzPRWVGFXTLNNx?=
 =?us-ascii?Q?ug1A5yKKDT9KGWwNG783qynyf5obIB4A9LKOPjCcvWAHRC1Gy7TjevKXLQjj?=
 =?us-ascii?Q?d+PB+w1LUJkOnNGpU+cCZ4oy85/OFCyVL+VU6ZiN17/9lbc8vxTjYsEBZUQq?=
 =?us-ascii?Q?AD0i135G4nDM1oNY4XNyYk+0SNFI1FCibl1TcMtG8/VwWDFPKjrgWaHE0dxI?=
 =?us-ascii?Q?mYrwBOVrJJmqHq7eIkWjnm6BsUg3gfKGoAhsz0WIr7gy2GG9lJs/l3R++vUh?=
 =?us-ascii?Q?S/hjlNvnqygI+NDZub6UGo0spLEL0yuBx7Ad0/HcdbZap1Yn2b70LpMXz4qr?=
 =?us-ascii?Q?s2xm0Y404tt5tnYTXkRkkWfb9m+4bfaN6EeGDBEOXqf62Te3KiH1wiA6WV2I?=
 =?us-ascii?Q?+samUjG/kp0Lwr5g9+c1BjHICThuVIZyBpQ73btyKgINVHtfcgzm3p5cBD/R?=
 =?us-ascii?Q?C0DYZq/X3A33PQdDwGa9CNakYyIfCZbgsg1bgn+kItzqd1iBsxW/2DDabL7K?=
 =?us-ascii?Q?5bkl/qrso76Ef61s0tqBcEDhkU9L7fA=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e5958a81-1325-4201-b0f7-08df04f222f3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:50:12.6313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlD4egVg3U4SDbP32FvBNMCzUeAv/LKs7gyK/be8Wq5FdSN2pPkTw5DUC7YfnTG4QFAZYn5TBeQvHTFPeawzPshHzaDwSvL/2+O4VBrXTS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The avb_ops.h header file, which has been imported from the upstream
libavb, says:

   /* Reads a persistent value corresponding to the given |name|. The value is
    * returned in |out_buffer| which must point to |buffer_size| bytes. On
    * success |out_num_bytes_read| contains the number of bytes read into
    * |out_buffer|. If AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE is returned,
    * |out_num_bytes_read| contains the number of bytes that would have been read
    * which can be used to allocate a buffer.

The invoke_func() wrapper does translate a TEE_ERROR_STORAGE_NO_SPACE
return to AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE. However, this
implementation of the read_persistent_value method currently never
updates *out_num_bytes_read in case of an error.

Also note that currently, at least the upstream optee-os
implementation of TA_AVB_CMD_READ_PERSIST_VALUE never returns
TEE_ERROR_STORAGE_NO_SPACE, but instead silently returns a truncated
value, with no way for the caller to know that happened. A fix has
been proposed (https://github.com/OP-TEE/optee_os/pull/7959).

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/avb_verify.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 76c523fd0ba..af166e7dfba 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -963,8 +963,11 @@ static AvbIOResult read_persistent_value(AvbOps *ops,
 
 	rc = invoke_func(ops->user_data, TA_AVB_CMD_READ_PERSIST_VALUE,
 			 2, param);
-	if (rc)
+	if (rc) {
+		if (rc == AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE)
+			*out_num_bytes_read = param[1].u.memref.size;
 		goto out;
+	}
 
 	if (param[1].u.memref.size > buffer_size) {
 		rc = AVB_IO_RESULT_ERROR_NO_SUCH_VALUE;
-- 
2.55.0

