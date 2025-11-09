Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20469CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C12D83EF2;
	Sun,  9 Nov 2025 08:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="HXZcbUSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2074983EF2; Sun,  9 Nov 2025 08:07:16 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3226C83EC0
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/0gOuuFXjqpr4YPoncDty0JuegQxrgShPTxK3w2w/SwqndTqjUnkcVaPGqXugtTFQ7V/rMVBu1ZTbrb5LqeqV6ppPBnlholpvZzYOZfm8EDjMcSCeHsmHPLDdCxscCiefKE1pZE+0sBiCOhjDkTM+wLpceVesFOmBtMxm7EVqBCYUg4VrrJpXlAehgy+/3XVTvQUiG9R4hmkB19F3siwn2RNkGqKwYDyqxxG4NScbaYAi5HhgceVmZELN8e+Hvrx607PrHkt8mvJre2r9OXQ6BOsuHI0EXvO/SwsKWA0P/ytZXHzLn4Z50GIingDay81mMn97dTT3WqbcmbXgJhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orOzZolwsPSdyAAamqgjtv7CXxnCf0n3eCAcQ1KmiEE=;
 b=v93EPINM+gLa2Go8+dScaV4ptvTLi/+vOr7OamjXgGdQg54a+gtSGDaqLZapRKeF7cBpUm+NUKAXkPBIL5LeNSrahBZKX8uElVFPY/xdpFX15wucrBYogDF8/AA9jC83zCuM0FQ8hXmoDG9po+yHbjsCQrOiatrzwoGGvEDrIxWKAsCF4MzpKJpd10MIwF9GzpVmsejjSibHpB+Q8D6AwVVLuivQJQCXwipVODNc3oAKSqp92GIIN+6F7pD3D381pF4lQy/jQ6wDsQnOdbHRmkACNPozx+OCdlbibpLfXxgOX9ra1wb9JXgfb7+IZcTea73Tt6/Q7HkJMIUEH1DkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orOzZolwsPSdyAAamqgjtv7CXxnCf0n3eCAcQ1KmiEE=;
 b=HXZcbUSnQNHfzPGsLf8ZzQliacV23sHCRH++EDM0uG3QRVa57Xy4XkacmR4ABXd21448oPdvdhhuQqK8SB7pRS7OvvOu0x53oX/zHFGbrKeq7G/AXR6bsGt4KWgPqI4ticnGXzS1q5VM1eaGRuKq5fzhRNelaMuFEBMp8zbhn6POrBiFzRDDV9xkJeymy3dmP6juoUxpterPbeDOFDU07Yb9c3421BwHFPnBGp92Fy/ixdFjyQMq71A+GsmrSAxPufyNoZog/bMsiLNohzY6+bt4/uXHM9yujr1GBKh61VuiYchMYPj/cKqERKia3ula9iX3E8T4UHLwpVmnpBkUwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 01/12] spi: airoha: remove unnecessary operation
 adjust_op_size
Date: Sun,  9 Nov 2025 10:06:47 +0300
Message-ID: <20251109070659.801344-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f81ce2a-c9e6-409f-a12e-08de1f5e994e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3iKHU64XbiQ35keWORA+uikRRgSpEMHidd8d++kRowxXqggKihmVcf/bzszv?=
 =?us-ascii?Q?mfrVnpqzbY4SBvghprwCRG5dmjyt1MWUxRoRBxkGcmxqwmQf+cQXmkQPGmGD?=
 =?us-ascii?Q?3If4rJ3h6j7j5VXJa0aHIx0N9OqqupiE6ulrHbxDl0luh6RHfil3cWdh84G5?=
 =?us-ascii?Q?7Un7/pZ9jgCwlduqzsTqUkUnduV/lGiGZB0XXYbGPFkgEm6p1i03QwnUOH4Z?=
 =?us-ascii?Q?tVOKk3/9aZSnbpucKwjs13d2aFkGQ6FydTosIlXy5ylTDR6QUHG+aiYsItp+?=
 =?us-ascii?Q?NPLyWiXWAjJyh2AeFAYkkOzSiimiPMDYwVTVRBUf/v1OkDmG8c6Wot6LuPe3?=
 =?us-ascii?Q?4k56r4EKymSUzYYpIwxJp+Z9kOfTVmPDfNkHqYijkHCWwrFiSZYQzvyLsL0W?=
 =?us-ascii?Q?bS6feSeO05Kg5LDQblB5OqhocLQL+geeQ42Fzjkh3F4qvV3nNMAE4QtyCU28?=
 =?us-ascii?Q?O4Rs3LAG8Da+aGpDl0EElMegO9i2W7+tOEeAVlEK0caiPfu7vhpO3wysIYHk?=
 =?us-ascii?Q?IemwSJ8TQkCHSrHcGwvHZg7ga/d4laT49u9nKwynMGsXfKObUzRZjRbO3WCa?=
 =?us-ascii?Q?r2QPb6054jN2qpQA8YJ7Vl7BmpN3t1kMWfZH/yvAxMRmjtCYVG/b8EMzj/D3?=
 =?us-ascii?Q?1Rs597vwaaAoc2EmIYq6eRqLVadh27QhY7DIcPqn4Gk5jv5XNscs7ILpw0wN?=
 =?us-ascii?Q?MCq7eOK8PPkzFpjdCVpI0OPMn61h3sFLgn+xENj1pWHg9ObwN9dx7qKh14/5?=
 =?us-ascii?Q?92R7auxokIZvHgqWAZGcC0VwW8lvGWZTZRooAEtYo/qcXplipqE04dNXUwAt?=
 =?us-ascii?Q?raLK+s4Tp833C7q2aIStMYlBJvq9VwaQyHdScv2kNeuY5F8Y+7TD72OSxzmj?=
 =?us-ascii?Q?H/4KqF6Y+3Y1iS5JV2pWKBe7PcqMAC6zRsH0oYFzQiKQ20jy5oihtyHehSFX?=
 =?us-ascii?Q?YqaFnlaug7L+djzqYJmf9yxJRO2PjMZyrlDqgxHtQnRcpXj4Ho/lzr9Wp60Z?=
 =?us-ascii?Q?icAw2LA+vzuyYmh6LchDE7L9P7g8kzZ1Hk+e/Ob+YclJG227RIQWEB5PqRs8?=
 =?us-ascii?Q?ToKf1R5wtc654GSgEC33G4v6Olbs+mEit6a46Fv6EvB1XrU0e7iCRKgeC0wv?=
 =?us-ascii?Q?N61MAs2xFFYf6k9bgV3hJzYM3pxiqAjTCCzcZby1DonpEIx+6KTOqN2aJX70?=
 =?us-ascii?Q?5HNGbP/MiL3gWgy23IoJqmTGa95Xya5n5P+8DyCHeZdjWkP+vsdjKfrlSzFj?=
 =?us-ascii?Q?T9+Z4T6wgwN7VADjxqN3znbGnyOFig1vQ+aWw+6IurqUw/m/1u1Ash/hdSFd?=
 =?us-ascii?Q?dWvYvBIgeL9kvQtQ8nOsYrGMEMTNkT/bafrcbvlYgEw8fmDVPZ1RG4NbKWeH?=
 =?us-ascii?Q?biaWeRRTMU9SGrnRaAeT+AivJ8D/oleh+yTzUSYbNj8HgS8+ZESNxlk0nXjM?=
 =?us-ascii?Q?3Sj0kwM8NRJ0oHYXRfaba/bIO0WuRinbvlyeAtfJ6EUZ21NtmSIRbxymMhCL?=
 =?us-ascii?Q?n1fD+rcyMH6XSJuma2HUGh+MHxpZyOIXf8xS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9392zBl+fLbQKJQA82ScnFKhkmT7s/elEq94KCt008JGcoGYebgrPlPLLvw?=
 =?us-ascii?Q?MJxzVv9/MNITA5O+m1AYD2jlOpiHMfsta4qlcxhOyZ3Oa0RB8I/ppHBwfkiY?=
 =?us-ascii?Q?9pNBM8C9uO76dBTe0MDrPbNSRGM4Af99PNB1vwPeo4KxbqIR9lGNYOKbvQre?=
 =?us-ascii?Q?fmOL8Q3iZhMa4kZ/3sNcUq1WIbPP83F9qVG+6RfUcuCOFkzezS3tKoWjdMs6?=
 =?us-ascii?Q?X2RQ+VBnTD+zu58XcMgGcK8cJQp39wbLRX4USMZIbN/k3dflF/fq3ia1jMvQ?=
 =?us-ascii?Q?QM6jwrH8mitfUbt/qEt+OddO+Y3ri5cLs8IVDThOmBkZ9y8X9t5jUnN2ydxs?=
 =?us-ascii?Q?YfLZG8p283gjNQ+3GcirKc+O93gymqO68/+ZG9+aLd+wbYF2zLHbw2eh+G91?=
 =?us-ascii?Q?MwCc8QDgEWO2Aq0EtT/8qVG0yEqaQrBYqqkuAT31h9ffrce0Z0NhrCtZ2sLb?=
 =?us-ascii?Q?A81Rcx/Y+wYtu4dsYEATGU0V5HKiFrqu4O2Hubbb6xQk3goHlImU259zPuCX?=
 =?us-ascii?Q?qQ0ArKmVUPCpuEWawLazXx36BPWOnYKa+6jz1rS+l7Ludq98IvukSQd+6fR1?=
 =?us-ascii?Q?uMCBbN+AfaKeIVe2Oa89M6lOjDXvSRakUIbGDa6hOxFG6rMkKqi6G3i60R9S?=
 =?us-ascii?Q?8gplspcMZde+E9qC2EFQTceSWflmk+duiDQHj5eIj0JmaIcNwLE0b+t3ediD?=
 =?us-ascii?Q?swyUxJ/4Y+y4zTq1vt7dH/m1Om19E6GQjNnC02OzYG5/C9nW2E0CqYICG/bm?=
 =?us-ascii?Q?lDYqC0QLPnzt0dBbVz+dD3ZAT0yPz3AHZ7JJ93oIt5M+v7Fyr618dPCAjA3D?=
 =?us-ascii?Q?QmbbqF7fga54Ye30B90niJaDpI6DOvb9w9BsUJztk2AGwZnRAxl83YpYPWwS?=
 =?us-ascii?Q?bx6d2VZvGleao54XlIuwaujYsuBH+5puKv2X+btzZSEyocbH5QdVF+Z8q1RF?=
 =?us-ascii?Q?RsXSUBDpH8cnr9Kevy/+ev3WKFlySEnXKDrgJWQ5CtadOmvm/Q1qWT+wMP5e?=
 =?us-ascii?Q?pT7DlOCdVXnQEcWh00ujfsTU/uuBFn5GN57M2emCZnx+a06lLFA/mY6yHM/m?=
 =?us-ascii?Q?tSE3vNRVBqOUjb5Nw1iCtWABm2FgHRErRBbL8gpYpnJh8zC7g7dP9ChOb+ho?=
 =?us-ascii?Q?yYTstBu06xE5yUZ7mgofQVWbKHro8FcwwI9emg7Xny5+yRppeGkeYlQZPwSO?=
 =?us-ascii?Q?wN5x9+ECQ7hd0y2b9m8Uxv6F8cq9VGrOzvtWcZOymTSJv9Pzt8d3innvAwkD?=
 =?us-ascii?Q?DaAjJXjAw7h+kgAY2uMIEFUDIWGOPQMtNsv7L9lmtqUAqMF6edRXo2g/c72Q?=
 =?us-ascii?Q?yACXEqdL/5RdDjUfuSLnUlGtRA4ucvxFQLblpd5aRMZQdVCCIJhT3BKuC+Sn?=
 =?us-ascii?Q?mQgCbHbnmyGFBsu0XLvEYdAKI62IiUGaFXq2D+NKwEPE6PVZyeSMVScybRJr?=
 =?us-ascii?Q?D3Nn1/8chR5rNA8njL7L59ypZRce4yykkH3M4JFSCLgBZTw2xN3tx6SZaVfb?=
 =?us-ascii?Q?k2W1KaDxL3Dq8IWoMcv8B9nEPzzCrqKcvLLCL39q6O8fCwnWkk5untRE2znj?=
 =?us-ascii?Q?JH0HLIPtQR++h2NwA+B1jTMrLARmhtJPZqBZNriKypAE/lTzu2ipL6TN7ddl?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f81ce2a-c9e6-409f-a12e-08de1f5e994e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:09.4867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gw6Ta8Z3drDe8WYw6BFBAXlvgJOSekfdfJoqZUZVzZO2wxLgwdl/ZqZl85O5lWJTNZwH7mqnPbJfJFO4IYnlrisSrexyRpc1pVDptpZ7lao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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

This operation is not needed because airoha_snand_write_data() and
airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 3ea25b293d1..4eb01038404 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -525,21 +525,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
-static int airoha_snand_adjust_op_size(struct spi_slave *slave,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-	if (max_len >= 160)
-		return -EOPNOTSUPP;
-
-	if (op->data.nbytes > 160 - max_len)
-		op->data.nbytes = 160 - max_len;
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -691,7 +676,6 @@ static int airoha_snand_nfi_setup(struct spi_slave *slave,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 };
-- 
2.51.0

