Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C51CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7748382E;
	Tue, 28 Oct 2025 17:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="KPUQK4tJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF80F83700; Tue, 28 Oct 2025 17:28:42 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F80683700
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrPxYR3D/xCU93cu/r+uip0ywBsYWdWOjUnBvz9V+zEDTG/ZvFgnvaOUdlfrliQJIefPMRa5UBMdLgZqFhtJS1eb6YJAaTfF82xVdGP0z9m2HB1xkFF/SsFuGo9UgbTI4diqCOE6Ramf+zGIOUahiM/TPNEM5UNDrMZsKg+czz+zPvOKXTRcKRSOAsvf92AjmqRJ9XPj+O71v9et7SwOwi+RmXyrk6mu99UzML6sL4kbyzYdO70GATL0an6LA1MQ42aali/a0sjDxr/URT/RyBIPvVo/xrSv+3PXPp0+2G0TCpq+sJQb4pWAIuTu+IglgGjdivvYu718Q33iGqELkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4oiK82w7A4Bgvz10VWunzINQUGG3JMwg/sEwkeocYA=;
 b=oJHy5wIVmTDBBz9f7yFzjg/F+pTppo/cj5xPBjqWZmerwmjsXsoUUHSmNcD3ZaYCPjW8ly3bHbcmWx8CcFbMnnONPsopX82i1y9CDnz28+jKLi28chn5a7t+Qr04UZLySXtNhn2IEhnQaIZ/fHrR8+rjgYnfMBTNTWyMrNCVn2k49MP+lDPSuAs3cEvoPoiUtpSf/CrefCjXgTbXLUtDbs8znWkL03HkZt4sK4RORtaeSbt2suXrxusEvSmzOEYO9pBMNlJRif7xQHao66UL4klnNCHrcrokg/NYqz50VylGeKJnazLOM/56q5yRvCEreLaVva0cU4yhYMdOBknDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4oiK82w7A4Bgvz10VWunzINQUGG3JMwg/sEwkeocYA=;
 b=KPUQK4tJLbonADc7yAzSsvVxqn8SSJheyW7yLLALF2a79uFW1txwukjynRy2YPqu5DfieEo2XckJV90rA/sxHu4IT/6dWmDahkjeRNfVufiYBMr4XS8SVzn6+Tm82DQrIynegnTjVGlYqq9ybN2ZoGYYheMx3GvUQIpAwr9SOOHn47TPjTpE9DlSc/9XNesGchzqrMV4yVt2RU6iWqRuEFItKAM3o+OgjXWUqO5RxOKZmjmdP/haD7MhJSg++dZypp2/IKGNGfVR08m04GEFSjwCSwONXp/5fTCIiQxFreTKUMUg8WmAdPiRStMtFcbf2ym1TQb2HmLox/bNJUO2Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 02/11] spi: airoha: add support of dual/quad wires spi
 modes to exec_op() handler
Date: Tue, 28 Oct 2025 19:28:16 +0300
Message-ID: <20251028162825.3353166-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|MRWPR08MB11233:EE_
X-MS-Office365-Filtering-Correlation-Id: f65516ec-f16d-4644-af57-08de163f0bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5UqCZo2KjaruXgU5+Jje6iiXtNIA6Bic8uMN0VcwW4SdzYW61IRIXbI1RgFN?=
 =?us-ascii?Q?i6PLNFIsXLXc3pVWsM2fJvldnvAfbM7I0QET+QUrjvflev8gRqq5oEZ9RaBI?=
 =?us-ascii?Q?nMrPSp0C3We15vZq3/i9yqbkOHY3CJaz8Ye8qolmEAXWaUcVm6qYeQ8HWgme?=
 =?us-ascii?Q?zGkgvwO11QO1HSJlB3YANPOt2Yz1ZKJHSmJPHN7/Bcn+dLH8uDLABXIg18w8?=
 =?us-ascii?Q?UHH1/F8tivCQBwsaMhH8cuJQ5L8mW1Y29dJbbSyAknpkcEEAwQKR++bdpqyT?=
 =?us-ascii?Q?PUqmzdMmZVCoa4goC5dqO8rF0t019zl6RO5VS1HTPFcuz5lGJxMxGWwFe5BT?=
 =?us-ascii?Q?nxCDz0aNAfRVB5XmYReqyLHls86IS9U9CpJSN681e+8YpXouBd474D1a0zGx?=
 =?us-ascii?Q?TjUIdtR0/ydq7gpPdyDFZdY828ayLGeSml+3PqjxIkGQxFYWUGyCCUUwoJ6E?=
 =?us-ascii?Q?BMxpGr8tUA3GL32nbXMHJQFkMI0a/aZjx40eS1i66NJEc8pnRCs0p5JaVwaO?=
 =?us-ascii?Q?VWoVjIGujPmrnaE5J31r/KO5M8pB8zrwJbaLmAO+2jdG75OF+kqaSSQcA+5O?=
 =?us-ascii?Q?ZazRAReFyxpBnksYC294p+uH9Mvf4qqde+Yb+1zm7c+lW1I/Hy2ODsIwUUgn?=
 =?us-ascii?Q?OpSuvK0TdfmL8x7VdQtfaF66P3k4EebdkPiJX+phzGDSTZFQWn3OC0dDRsGI?=
 =?us-ascii?Q?MMgAlCVPrgbEsXObv7nsgNMXskTN//5NlFkotDndoCzEL9mMKWpZNflZiCr3?=
 =?us-ascii?Q?rKvar6Z6gPOjGenEQexHu1N6PMY/eQVPIpWjapi19QFOowf60kDvla4ntJTU?=
 =?us-ascii?Q?VN/TbT+TbhhgDIXqUGxj7ZKRsVc4bqUjksKoxACMd3QA0FgLJpz3dGcxX2wn?=
 =?us-ascii?Q?a7MqUZi8/OADFnCzzA5MHwSQxWstBfQsMdr7eak2A9t1lCyCGawd8w1gOgYf?=
 =?us-ascii?Q?ltsLIwWJgnbv9gJpQIPbYwJfa4/dSv1ozYvAKOSR4ePqlEotJQWu7TVeEjSD?=
 =?us-ascii?Q?m5I4BQ2koFRiBXgza5fi/lzCmybpEluxHgBRs+iDQsqX+1JyDCJXeeXIt0Gx?=
 =?us-ascii?Q?DXIE2RoOY7XZpsStK8/u96WYYJAHsTGavhef4SRd3NAC9MM5ZD/4BJQ8ifYY?=
 =?us-ascii?Q?AIkWbDv2sQ6259LqYacgGM3Yw9x09k4vHlNexOJK3H19qZmcTUd8eTQjP50i?=
 =?us-ascii?Q?tJBnH96M/6nW06kVxzn67EOt35OcWwmoYd/m+k9WhbUmzjxv56SFrV8SWAKS?=
 =?us-ascii?Q?MHV7o46rY4lLl7+duWArOYGgwJ+D0tGLfsCkbMhrz/8oKevrLzSF92lXgBCx?=
 =?us-ascii?Q?zMfUOqNv6IjmJH+Qo1EOnffAWnSHz4JK6HpwRlIHJeCdmkEyFMI8snyGcLlw?=
 =?us-ascii?Q?Ybmk5yL5P/UwY46pBrBa+y8I/oYk9Bd5zOk2gUgu/DyvVVKgHUt0IIFT0xv4?=
 =?us-ascii?Q?xYnWjpc0FjZ9g/RN7TEqez88ieLKR8/+YmUQPx+nhHDel5jiZXZxReY63W5r?=
 =?us-ascii?Q?2S+zoa39OaT1pIq9bhckmfGHeuT8DTa2Nm9E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AI+y+EA/tCzLbjuadrXYSPTZzAlJiQ/LabqpEIE9rpPkOo9BfLzpvgkiQste?=
 =?us-ascii?Q?BbuhgTEYf5b8TFjHt9vL2u+2ZUYblT7hMzwZBWGdtAT9jeerIlDLsy7bPY6X?=
 =?us-ascii?Q?W06gwVG5VxpH89prFiqE1+UilL2j2QbrEPb1VO+sC5yXlCFS4mKmpsfF7kFz?=
 =?us-ascii?Q?Hjj7E4HMF7bvV9Hzsdg/oK5vp14vSoKfMqvjrKBUVvy2/5x0/NpLmeiyaQoo?=
 =?us-ascii?Q?W027F+k4Vxrq2dowLx2n0nQJ397y+fe8nEcIRQIxoI/e/Bt0ma2cOQAW+Tep?=
 =?us-ascii?Q?55QwUqrDZ39qqTT4bW9z0lfJZWppL40OeW0/yhurMt0gnNwDe+NH/PVk7gY0?=
 =?us-ascii?Q?f7MWg+GfheOXQUSH4r2/+PZkueAj/MmaxBczH5KLy0Ofjwz/9DHl9JdzUCUJ?=
 =?us-ascii?Q?Owi0f3ob8t+aEa4Li92rAH1AYJCc4Pvu6oRvHy4zMmyk/GoZh28iVf6wduU8?=
 =?us-ascii?Q?SbbdGFAA/Ic4B+85Z4aNxdULzFYU25+inBFYprf0X8slpdhrbtxoL5MtD1Lz?=
 =?us-ascii?Q?3WK46wzhq8kXqyy8bVC/UutirnmgE4doN1Vw+TZe1Jidnx7nbZ/g0Mz8qMSo?=
 =?us-ascii?Q?gEOqCoDWyinVJrIh5deCabYibjvHy7v97itUCfjsrVetx5yvjeZRSTJMNf8s?=
 =?us-ascii?Q?5WtPiYrEIqfqeFfBezQeMxMs5JKiZ7mV68aHgwKSOx7O/7GUPFE0vcmGkTBp?=
 =?us-ascii?Q?1e3RuKHi3WBFg+JAWQaY8Xsig9+HgWxUkNkJzHYOhH2SZBsS/CioQBF4LMOs?=
 =?us-ascii?Q?qgQVPs7PiYJgs5Q60qnEWpc2dVDQlta5yfI8Sj46A4VZ3M8+OnAKCHCm50i9?=
 =?us-ascii?Q?yOMDUA6eCsGAGQtDa9j+PvZnsP2g1eUCR/zLoWzqu2XtNUwLEQp9dt6WywyM?=
 =?us-ascii?Q?1+b1EMvSnlz82tL12+oHBzt6xanoPXdXuVf8m7LI3nPdxgps3kfDa9BPJCXd?=
 =?us-ascii?Q?bVRMNTRE1OavIlhvx8VD/69XvsmHBN2ExdQnRE5cjUE/++2/gDmwe58KTz7P?=
 =?us-ascii?Q?0P1f7Gxd2bCC/iBDKnjzaP3j1L9UcMzWC8jw2l3Vf9gqOVtjAJfZ6uaoOhqq?=
 =?us-ascii?Q?xDz9otu/2PfKNj0Jt9vnfAd3fMwa5w15fRfm6GA1uKPKepS3icQCpmav8zzo?=
 =?us-ascii?Q?IP06qt1lfkoo4WmjyfmFKGTO899IBXk7CSnzHqkSyMijtMGu/qMZXOkBGfTR?=
 =?us-ascii?Q?JpL7DGjd3pis9WQSeXkQ3guwQpc9iZvREHcD54NJA1ivXZouYGxP6QvdMPFc?=
 =?us-ascii?Q?xmnLMh3J4N1PSTo77YAjNMpbg38QADsUm7nhyFBXyyBYuiOokStdI+aMjt48?=
 =?us-ascii?Q?um/EKocF876eHVt0Ltdchsu+Jl6UWDJ1X6PSLfi5Au/FrcX4f86kaPOWoGg3?=
 =?us-ascii?Q?qx++QteaIwHzTWwj44cvBijPSnW9U4i5HmK0BzgYG4OXCYmrAHXjUsWu237f?=
 =?us-ascii?Q?RTnIAw1EFuSxqr/aQMZ+C7p1R+tNFuChQ1Y4NZeYBn7550Pq8avBmT1s0S5G?=
 =?us-ascii?Q?cMEvTpbrBpjMhLl5lS/W1nAzTUyHc7LeuHd5aQ4LhsmpvNtn4iL6Rcrl8Oyo?=
 =?us-ascii?Q?yqD3bq/mnqjL8BPgRCKu7VeHByDm3bM2MZLx/pq5jtZmHym+kJNrk/u03FB7?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f65516ec-f16d-4644-af57-08de163f0bb1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:37.0424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8UiG2XSGUW0d+NraAO59JQxV8trgFNAF5acxN9h86j4AVxQAFgfyXK3UyEeUoWMRQtf4DmKd5fB6IuTcjD7byS8/nFNdzWIZMnhHtJStYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11233
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

Booting without this patch and disabled dirmap support results in

[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[   13.356897] UBI error: cannot attach mtd1

If dirmap is disabled or not supported in the spi driver, the dirmap requests
will be executed via exec_op() handler. Thus, if the hardware supports
dual/quad spi modes, then corresponding requests will be sent to exec_op()
handler. Current driver does not support such requests, so error is arrised.
As result the flash can't be read/write.

This patch adds support of dual and quad wires spi modes to exec_op() handler.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 143 +++++++++++++++++++++++++++-------
 1 file changed, 117 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 4eb01038404..7cd409ba44a 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -186,6 +186,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -380,10 +388,26 @@ static int airoha_snand_set_mode(struct airoha_snand_priv *priv,
 	return regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_priv *priv,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -402,16 +426,32 @@ static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_priv *priv, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_priv *priv,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(priv, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(priv, cmd, data_len);
 		if (err)
 			return err;
 
@@ -525,6 +565,38 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
+static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
+{
+	if (op->addr.nbytes != 2)
+		return false;
+
+	if (op->addr.buswidth != 1 && op->addr.buswidth != 2 &&
+	    op->addr.buswidth != 4)
+		return false;
+
+	switch (op->data.dir) {
+	case SPI_MEM_DATA_IN:
+		if (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth > 0xf)
+			return false;
+
+		/* quad in / quad out */
+		if (op->addr.buswidth == 4)
+			return op->data.buswidth == 4;
+
+		if (op->addr.buswidth == 2)
+			return op->data.buswidth == 2;
+
+		/* standard spi */
+		return op->data.buswidth == 4 || op->data.buswidth == 2 ||
+		       op->data.buswidth == 1;
+	case SPI_MEM_DATA_OUT:
+		return !op->dummy.nbytes && op->addr.buswidth == 1 &&
+		       (op->data.buswidth == 4 || op->data.buswidth == 1);
+	default:
+		return false;
+	}
+}
+
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -534,6 +606,9 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 	if (op->cmd.buswidth != 1)
 		return false;
 
+	if (airoha_snand_is_page_ops(op))
+		return true;
+
 	return (!op->addr.nbytes || op->addr.buswidth == 1) &&
 	       (!op->dummy.nbytes || op->dummy.buswidth == 1) &&
 	       (!op->data.nbytes || op->data.buswidth == 1);
@@ -542,13 +617,29 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 static int airoha_snand_exec_op(struct spi_slave *slave,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct udevice *bus = slave->dev->parent;
 	struct airoha_snand_priv *priv;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	priv = dev_get_priv(bus);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -559,40 +650,40 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(priv, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(priv, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(priv, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(priv, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(priv, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(priv, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(priv, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(priv, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(priv, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(priv, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.51.0

