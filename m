Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2918CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E8583835;
	Thu, 14 Aug 2025 01:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jrrhUSId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FFE837E2; Thu, 14 Aug 2025 01:43:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498118380F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC3J5YkyA+vJs/uI7hC7itJN3dBBQBwHChtAFO6+gdbNG6TW5Sdu5vTg8B2SwfpLjsyxYjTAOC1Ubf/r6/BxCSY3fBm/xzgn2tDk72maBArD8v6jjsN7z7ZBc8ICJ5CnUucHzKfP59/6cN5XMU51dZfwvnBTR9F8Ojn/ChWJxVD4h5XgVKE1StXDSQCIm9/Ey4vWeuY8GsQDLHg3s/Wi8s6QVQsDq9LIgMb9yrz4xihr5FTlNGFVh+uSd/SzrqQRhQ1VJFbe+pXXIRDGTNd6DbQFV5oclJLjT6bJtbzqP9nCINikm8GbYk1GSqgN+5ZJl2eugngeiTyyZ6NrvEybQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsyrMPGpe3uB4RVllS6FZKU1MhKScjRgFamqq3HR/6Y=;
 b=MscfY4syhS1r/12lZjlfOu2qjh4MO40PWlNasD+b5VQEu8Z+cAXjeJERvmah20qtTspc5Cszd8ziZCx2pFG0tJr/1gVeaFo5D4nYFd/t0A0pZvlfZFUXJ9mUGYAw65JGiZ29UBHB5FDBJzZtFiYYfWcnXPyQg/gRb5Nqiv2HG4T1RPT7DvXmIT3Aq8/n/HqNXlKGVzvTVSIDQZfdQCReM5tE/waboeY5/7T2dC3n1yg61C3feBRD3yxcCBpAR4q8AYcXVVaprySW5kt3pGHd9lVhNQk2NLbCK76EnPt+tZ080HUvpg+oa2DVOyW58u7GqR9fLH5u+Ozdii+t6I/cTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsyrMPGpe3uB4RVllS6FZKU1MhKScjRgFamqq3HR/6Y=;
 b=jrrhUSIdp91AGz1uKAtGpaNiwkcbeRf4CEIY0d5wkXJG7Z4xOyjK/e7T5mQSVPkkgLbaGXbEIqWXPNo7Utl4GGQODQ5hLQtI5zX8bBKcjETLekbo8VATCLqdN/zRPK7xcpPCUCiSI5IhqaYKEtXIu3MpTY70tEKzzadujteTBB9WUXa7YyLhcyYBttHG4ITBzPxiE53z7ZbdSeW3QJYEk/n3P4YNsKaEMfEzmYLiJSvStyZMnoKVz5iTOevnNSpG2655J6djuewXvInUuXlNkPTT+tTRajiiUpmAED6PWEeQddmiVueqfFcDnrMeEMCFh7U5VI0mWmeF/fmcEy4ZVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 01/21] spi: spi-mem: Extend SPI MEM ops to match Linux 6.16
Date: Thu, 14 Aug 2025 02:42:54 +0300
Message-ID: <20250813234314.3945708-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: be63cef9-b8ee-448d-dbdf-08dddac331bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+yixfjv/fdRLuw1t4hW8k4dUP5V1VQqogxgi6FhgXYqzfTNDgZEwlxYPiJFC?=
 =?us-ascii?Q?mnQeruh44KqrjJ/ndOSu2AAkGN1FPev61ptPElFP6xcFLu1Pgw5eNoLQdr6E?=
 =?us-ascii?Q?91A54FLvXqKMgEzczPabBXz0svPgILLPX7Myop3C1ipI2LS/GspH3tZk3wyX?=
 =?us-ascii?Q?w+vlSDI3mUAaeS7KlZV1L7YJoL/hQsLNkEkyXWt/FHzKm22sAI/e5mkneA4B?=
 =?us-ascii?Q?yiGGjpvO5/7nRY80oBdehtPnw2PbQJerYVI0F2rjECizFAUwRS+fA440O9KR?=
 =?us-ascii?Q?nqXP4o/kdVoMswh/6a3lrBOkvpl6LumrnwMfs5hvkJ5TNRmxGkvq02tC6XeH?=
 =?us-ascii?Q?sBtcjQak9esz9SMbrLJpAGe42c5YJvSwjoocN54AQomRTKoLCoDU6ykSBded?=
 =?us-ascii?Q?dsnVdBiK7rhUKWhd2vEQe++xWWja1Ae3cp1kYRSUrsmbloCEw3SFpGCjtNzk?=
 =?us-ascii?Q?F8iIZ+hnxMorD5szJMNWdErYsinq6REuieKRrS0ejVDToy9FgPmexlvd8apo?=
 =?us-ascii?Q?6mSxV4W0zvM7QNVLgY531nx0TEwOdu0HJ0DPVGyPf0KxnUkocBtSKzEvam/n?=
 =?us-ascii?Q?RhCDW1JGONxsM6oWePPxbQ5mCtEUtZpIGOQCI3TgfHni/WFCquSLqNV3BJ44?=
 =?us-ascii?Q?eWt9y456+CK+EBA5TXXfIJixcnMpmJ+EGpjzIKHABZUUUh4pQV8TcznQ062x?=
 =?us-ascii?Q?9k8PKdFaddcBYsCqTTPRT92zBEVk00Ei6bCpXSw4Qx2nwAv+obJm1d71VbWq?=
 =?us-ascii?Q?OrEDVONiYW9ouQi6dLf9ZkLFRI9EYlQNEe51dMIL5RnRhM4OXiv5HE5ed03H?=
 =?us-ascii?Q?69lWesfv5sWrXXpxr8RNXdv1LHWj6kOzZ+LLjPxI0lbhq6o1tffBLyHGSJXQ?=
 =?us-ascii?Q?PC+JCxM4j0yIgIv7Fds4++vkOkIVrwyCdtLTYoFM2VtrceOX3wg/H+aQIBUv?=
 =?us-ascii?Q?DVTcq47Vull+KxMRXz0IH3K/8TNzapoe7Bo67AcccUhHp4puPUBaWA/v3MSk?=
 =?us-ascii?Q?vonRZAVeGtH2mc4eryqiMWaqf919ZSJDwNqKwtJgJ7TxUujNMN3L1f+e32sG?=
 =?us-ascii?Q?6K+rdBWEp0f9652M9UuMgsK+zFeJzJjv5pamq2G6AWyXaQnVqIsCl8PawmVl?=
 =?us-ascii?Q?NNxM45DgbcKAgJK2xk3Fjnj0jcbXCrZI+hV4wrb+IcqFUQ4kycMQurHyXCAf?=
 =?us-ascii?Q?1faMnCNRLqL1LjC4cC7TwK8TvtiTRWHDlV71vZZZ0bBaA8lblq0Y7EZFK4K3?=
 =?us-ascii?Q?Y/UdGMw09DfpZ12MvfLMLEszwNEyHkZysUQLCHgFYWNtdFINuj138ft3O1Y+?=
 =?us-ascii?Q?L5LCJc4HvyhMdR0+o00ZsCG+bjtWpZwMaFkDmMDY9oFb/vsZ7Iamqd4AhE0/?=
 =?us-ascii?Q?c2MpI0K1Jw92wcAB9ElkvswQfhvGhZE4dmZ1ThEdEFX+xVniknq9YmDoXTbJ?=
 =?us-ascii?Q?Sxd2bb+d/dytSfURiCdZL3DU3riNVoRRpstBK84MK6TuDzWzJ/MQu7y7x0Ip?=
 =?us-ascii?Q?siXm1XmCnHuQFCw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?snbu6rk0QHpN11Uf3IjH6RtVcUp6zv36lQHh06EKkS0W7PJCI4YI8B3pJfkd?=
 =?us-ascii?Q?Y5EYYDZnjrJ97qot44KANSl++O09NNZkxTCzPZbH288GGCIGCZuikMxPQRaH?=
 =?us-ascii?Q?65AKcLJHGrrwsyNNHBPKt9xAxq9OzCNuFD/fQRT8pXa/KBQrgTFCYLqdzDy+?=
 =?us-ascii?Q?1Sdwypt47JcmmS+M2lrr/bsDVtS6IcIbB0xXJpB7VszMBc3rDexGcNPDqcMl?=
 =?us-ascii?Q?LU7Ah+AMZBMfUCMcQTLqUpEBByxtNFeYZu9d4llx30RMnbNsvjhjGlqtrwLg?=
 =?us-ascii?Q?+8CfFp+PW//6JAcTu4uxtitceaQWmhulGzegBWzru4fIPRxyD+rcZ5TfLJNo?=
 =?us-ascii?Q?GOUzsw9MdWOVwGHQbwXj7p8/zhD/ztAXC5qCaQGutXTAzF5mhiltZmCb4vQo?=
 =?us-ascii?Q?UU1b8EdQ+WdbSAiyfHZW2WIG0eV9hloedRkLllTqHa0W2uZQrHfYGj4lTPIv?=
 =?us-ascii?Q?sbiIVAMptFrS169iPk6177vZNKm+ccndUqdTUJLNxiph3t2OduWL9+cD5yij?=
 =?us-ascii?Q?g9NqsPK/A3rBaY3CenZiwbsTE99YQSoaR16QuH49MtNv+BVsBpKugiL5DR1s?=
 =?us-ascii?Q?f/mUZvlXUtCrq01uRBrQGVI4/l4MgOvOghUx/KGxCgewkqEyVeNQu1wzST+F?=
 =?us-ascii?Q?y2q0LBT92l+l27LmrOCyteOC1lech+zPiwR2TkmK/3xSr5t0FTLBCQCu7Wqd?=
 =?us-ascii?Q?YsXCSJ8SBzJavNDYFxtPjeE72qIwX65gDHsiezbAvceBzR46jFzWAOMtW8RZ?=
 =?us-ascii?Q?6nx7dVLPLks639rtKalxem0pdbyEyvpYq4Emp0SZ9Xns/hgO+CRgSs2yd7W8?=
 =?us-ascii?Q?ANS68fkZvPj0TBAmJNaoq6ZN3cIuXHMArIKJe8L73QDvyQqoLwANc7A2kkkL?=
 =?us-ascii?Q?K7fWh/d/RV1LnjK8ijY107PlhK8Pm2K/3Vi1fh1OFC1BqEnpY3b32/gHqa1e?=
 =?us-ascii?Q?58xAYaEy+pTBG0UN2sR4iug5nhEsLx3wROccRIu0M9zbnR7Ua1tOQVxQMmzD?=
 =?us-ascii?Q?Sqz/OhYuojNilUjJDNGrFG9QJnD+zVdyuPvOAWpcm5ULlghyR6r7W+v9nksn?=
 =?us-ascii?Q?AcAv55X5QxUTyTKpuiZyiWwcZ0tZi73ZV6ZLVE+NSFBXtkonEKdRgFlHzwO+?=
 =?us-ascii?Q?lGkGaFdKlvd4LZc5ELu+QQM8TurLbg4CCBfDLoiesb7secR1QMzthiwOE3gN?=
 =?us-ascii?Q?wBxr3UzufgL7rtt7SGUi5JlHFRlIeQx5w8jVyzenEnPi0lRivtX8ElAx80Yo?=
 =?us-ascii?Q?yHueDrJkxSEJzYQnGHO7ZAJ2BSd3ulQOEJT9lJZtpJNzGKcEBW1Bnd2a6b4S?=
 =?us-ascii?Q?Z0bH1YKmE4RNTnJ5ECBtU9ibVSVOfaZVIunXSiV5pLkq92whjVDUGvMaSpNA?=
 =?us-ascii?Q?70yW1hBzZ8mKfUFj2zkhfvBFUzLCdiyigBeYwG5tH6SWkQis9Lv0GG4GspeD?=
 =?us-ascii?Q?Yb+WyDnCVjymtFKw5RngREtZiW//kPSpWIDwJ6QhdPuiHVDQUMUgW5YzECNu?=
 =?us-ascii?Q?aYTlLD4HRszGaYH/13gerLelRw0olcuIy0bVg9AY9xOX4b+ITMtCqr7vmbNs?=
 =?us-ascii?Q?FkWkluZXSOKVbaS9V1wP0rSla9QVBwf8r556CYmyKKHoZRQwbhmgQia/3yqF?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: be63cef9-b8ee-448d-dbdf-08dddac331bc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:24.6722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1RVuwg9Me3lcrZc/++9Ycd+rqHmTNCICdw7JjAkhDCP4seatspX0vpQaymy9fomH0cP3QyObtC0cFcJbqz9nowQwhvVFKnfXmi6I/WZjBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

This pulls in multiple changes from the Linux kernel in order to keep
the code in sync. This also fixes octal mode support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-mem.c | 13 +++---
 include/spi-mem.h     | 92 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3579b7d7db5..6f06650384c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -120,18 +120,21 @@ static int spi_check_buswidth_req(struct spi_slave *slave, u8 buswidth, bool tx)
 		return 0;
 
 	case 2:
-		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
-		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
+		if ((tx &&
+		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx &&
+		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
 
 	case 4:
-		if ((tx && (mode & SPI_TX_QUAD)) ||
-		    (!tx && (mode & SPI_RX_QUAD)))
+		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
+
 	case 8:
 		if ((tx && (mode & SPI_TX_OCTAL)) ||
 		    (!tx && (mode & SPI_RX_OCTAL)))
@@ -300,7 +303,7 @@ int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP) {
+		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP)) {
 			spi_release_bus(slave);
 			return ret;
 		}
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 2eb05a2e5bc..e68e2b50e85 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -17,16 +17,32 @@ struct udevice;
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
+		.nbytes = 1,					\
 		.buswidth = __buswidth,				\
 		.opcode = __opcode,				\
+	}
+
+#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+	{							\
 		.nbytes = 1,					\
+		.opcode = __opcode,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.val = __val,					\
+	}
+
+#define SPI_MEM_DTR_OP_ADDR(__nbytes, __val, __buswidth)	\
 	{							\
 		.nbytes = __nbytes,				\
 		.val = __val,					\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_ADDR	{ }
@@ -37,22 +53,47 @@ struct udevice;
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_IN,				\
+		.nbytes = __nbytes,				\
+		.buf.in = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_IN(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_IN,				\
 		.nbytes = __nbytes,				\
 		.buf.in = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_OUT,			\
+		.nbytes = __nbytes,				\
+		.buf.out = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_OUT,			\
 		.nbytes = __nbytes,				\
 		.buf.out = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_DATA	{ }
@@ -62,7 +103,7 @@ struct udevice;
  *			   transfer from the controller perspective
  * @SPI_MEM_NO_DATA: no data transferred
  * @SPI_MEM_DATA_IN: data coming from the SPI memory
- * @SPI_MEM_DATA_OUT: data sent the SPI memory
+ * @SPI_MEM_DATA_OUT: data sent to the SPI memory
  */
 enum spi_mem_data_dir {
 	SPI_MEM_NO_DATA,
@@ -70,6 +111,9 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+#define SPI_MEM_OP_MAX_FREQ(__freq)				\
+	.max_freq = __freq
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
@@ -80,26 +124,35 @@ enum spi_mem_data_dir {
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
+ * @addr.dtr: whether the address should be sent in DTR mode or not
  * @addr.val: address value. This value is always sent MSB first on the bus.
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
- * @addr.dtr: whether the address should be sent in DTR mode or not
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
+ * @data.swap16: whether the byte order of 16-bit words is swapped when read
+ *		 or written in Octal DTR mode compared to STR mode.
  * @data.dir: direction of the transfer
- * @data.buf.in: input buffer
- * @data.buf.out: output buffer
+ * @data.nbytes: number of data bytes to send/receive. Can be zero if the
+ *		 operation does not involve transferring data
+ * @data.buf.in: input buffer (must be DMA-able)
+ * @data.buf.out: output buffer (must be DMA-able)
+ * @max_freq: frequency limitation wrt this operation. 0 means there is no
+ *	      specific constraint and the highest achievable frequency can be
+ *	      attempted.
  */
 struct spi_mem_op {
 	struct {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u16 opcode;
 	} cmd;
 
@@ -107,6 +160,7 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u64 val;
 	} addr;
 
@@ -114,28 +168,35 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 	} dummy;
 
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
+		u8 swap16 : 1;
+		u8 __pad : 5;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
-		/* buf.{in,out} must be DMA-able. */
 		union {
 			void *in;
 			const void *out;
 		} buf;
 	} data;
+
+	unsigned int max_freq;
 };
 
-#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
+#define SPI_MEM_OP(__cmd, __addr, __dummy, __data, ...)		\
 	{							\
 		.cmd = __cmd,					\
 		.addr = __addr,					\
 		.dummy = __dummy,				\
 		.data = __data,					\
+		__VA_ARGS__					\
 	}
+
 /**
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
@@ -143,7 +204,7 @@ struct spi_mem_op {
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
- * This information is used by the controller specific implementation to know
+ * These information are used by the controller specific implementation to know
  * the portion of memory that is directly mapped and the spi_mem_op that should
  * be used to access the device.
  * A direct mapping is only valid for one direction (read or write) and this
@@ -223,10 +284,12 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match controller's
- *		    limitations (can be alignment of max RX/TX size
+ *		    limitations (can be alignment or max RX/TX size
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ *           not all driver provides supports_op(), so it can return -EOPNOTSUPP
+ *           if the op is not supported by the driver/controller
  * @dirmap_create: create a direct mapping descriptor that can later be used to
  *		   access the memory device. This method is optional
  * @dirmap_destroy: destroy a memory descriptor previous created by
@@ -300,13 +363,16 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 				   const struct spi_mem_op *op,
 				   struct sg_table *sg)
 {
-	return -ENOSYS;
+	return -ENOTSUPP;
 }
 
 static inline void
@@ -315,6 +381,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+static inline
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	return false;
+}
 #endif /* CONFIG_SPI_MEM */
 #endif /* __UBOOT__ */
 
@@ -337,7 +410,6 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 			    u64 offs, size_t len, void *buf);
 ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 			     u64 offs, size_t len, const void *buf);
-
 #ifndef __UBOOT__
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
-- 
2.50.1

