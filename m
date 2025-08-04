Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B684CC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DCC8404A;
	Tue,  5 Aug 2025 00:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hPCNMtyQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E388403E; Tue,  5 Aug 2025 00:11:42 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69A983FAD
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu2KvAN4h85mgs+HmsTsswiTC9ZgZyrE+5dB9XR9+0GMYd16KQSul27a+4d99apo0tA8dzTnntGm31KzLvmmPkvez9HsJ237rWdpLANY6dFyxzXys/sJOMIDCU9JzX10wVqYtuY2qiC6kuYzTWqsGROUhyGNeZA35uWCYeHzZJxhgRHW36bMf828fwhpWNEAcOgB6pqX58GTfU+cJYBcdjzcTnn4oeRYBXmdCQPwH16njp3QxM2/TpTGUpHY+TsM6JeJKzlKvpopAU7hheHmw1JyL9+AUbiMjh6gk3c8KTrW8RLxrSBswSQY8CtkPsOfH31UVCQxskmPU72+j3+45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCVnnqecEyf0tV+hyWHeobdIFe1VF1Wq/nrZLk23tgc=;
 b=UAs0pMUlCWi0WOjAU9Kx+rpbFvgyw4nrIVfBLNTHHQfguGZWBm9hiO2RevhQ8DPW8B8cATGN5mckByji1p60GG+cNF0YS70ENGhrl/QxR0M/nNQQFRI4wAlcwLlNyDeA2hiSxT8iiM76zFgW2eaQ20g/jADHq8p6lLCSXGVQKYf/YdpV3jnOERIyDLgKnt4HXIYD6kf8Qs6GVgs2Srb0ANKtJM5zkAsCWzcuRwn8JQ/H6uSGEvX1/VRMpHyLIg41vLlf1Zb2Ol5r9D4ECPoOxZCrWkNX5m/qAX4I8VYl9V4Q2X8pDzyvRzgJcJfav161VGfWZAezXDMRCI/pRKAYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCVnnqecEyf0tV+hyWHeobdIFe1VF1Wq/nrZLk23tgc=;
 b=hPCNMtyQWUWZLdsB+PZEtMminh/7gr+fTzCQCHcvhjal3RTaHZhhczo5d0h1yf3hA2M3B0MDyzbJEVpoobDy3DW34nEfUZCBitrqRVaPuuCxtc+vPBy2CmxLJyB3Tdjq/U7aQ7sBRX30ypCPbN4S5zWPC8WmCtPkdH7xtpCWady44ERKn8tIOcXbtuEBVUwI44f923/Bw8fdyYIiRKmVL32i6uuBqLT3OHLuXD99mifyevqGCan7/u6l+DxxNG/B7i4X07k3rOXlpoXqUgFasK4P5Jod1VLw3A8zSsuIofsbJT0MiBIVn1qFg4bKkbIAmSMI9LdG1nXCFejTyXTKkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 01/22] drivers: spi-mem: sync a bit with linux-6.16-rc6
Date: Tue,  5 Aug 2025 01:11:01 +0300
Message-ID: <20250804221122.1420516-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: d4446189-dbd8-4043-19e9-08ddd3a3deab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uRChs9B82y13lAOuButqcc29Ku9YEx3u1pmsZayACJhZKjIwSamCkoAQGbvn?=
 =?us-ascii?Q?Kv2yuXCZ9OZV7LBxL4JRa1exHMmaQi7fOHe9oEiArJq/Hhn6Dnhk0kg6uLg9?=
 =?us-ascii?Q?K/kmdoI22LnyHI2qQCYDKwwBkjjSRJRhiLrRMo2MzhuK7PnfuJyhy24dHaxM?=
 =?us-ascii?Q?A5t/6jUYFmCWyo9ciXKhak2JPiBH1l/KrYxEIcTVwvSiW3fJsdiDJoI+1ZDU?=
 =?us-ascii?Q?alAFzR9Ssf9EccBr33rq3Gi04lYmaTxxQg30ZtV3RYOsGOun7I6rBXT/jKCm?=
 =?us-ascii?Q?bhknBpT7uczPEnK1DSrtK1qG146axEqphRaA/7NNpoGDIdjC7rDEMlRXLKZl?=
 =?us-ascii?Q?1yIGdaBE9x3LYi3XG6Lu3h/YBLVb97sBiLaVZqVLusCGfcITgHlPXUI9am6i?=
 =?us-ascii?Q?BZH5QyQV9sz2QAit4UOcaxHBuaebJ398pgwXV9JldNHvtxY2n4aT9FvbfZwR?=
 =?us-ascii?Q?GRfOUbx17jqaURKtZLxUngTq0PafGaJ7lu7FSOF5BrpcKo/GLFX28AVEaMNS?=
 =?us-ascii?Q?q4NErLxRqFhM/zG/lIHtQsJI5gMrMJT2u3zR4d7kCG8jdH4AQOKHFDW+/3xD?=
 =?us-ascii?Q?UtfHZerHQ3hLFCAdmnlbbafsaJ39SS46Uz8ySaCYb0fYxp8MkGm1YdevyEMX?=
 =?us-ascii?Q?BnAtY11BHmSv9w701SQx6fYcabe/xmZxUD79tmnW8r/I31RJxQ02XxMa73Xe?=
 =?us-ascii?Q?zAbSq0q9Sbl4w/879hQRvQzRyZCnc8EQEdM2R0/aUEE1JSqZXqljRUMEiknt?=
 =?us-ascii?Q?tHmN/ZpjTaMeKRAeXHhjJPlKz7bsNWX5iPifGerW+xoLmC/RKyE2iNIZFkJY?=
 =?us-ascii?Q?N+/oVDuzBXHCKbdny0rLzQzSwJ4vSc3DumBw6g/yhL3k/YYeE8CR7Ih3OIEk?=
 =?us-ascii?Q?0GY8GXSuHZehTdeqb56VDBbPVGAHYzzm+Z2BKsu4+nWlEKnnv8XzpaCjBRZX?=
 =?us-ascii?Q?+OroOS+8rfir9TjTi8AyY1TkuEJTnaDm8yaE60gu5Z5EJgcB0Jsn2Q7shb/u?=
 =?us-ascii?Q?EOs14q9Icxghbuwqos8vjx+rTrHAq+GwbXOJlJw1ovbVM64lpcO7ev37+HSA?=
 =?us-ascii?Q?T3nlm1mnFeLFBguORGD9k9MyAtNFsSMv11YAzb2rXwS4ZnAKKOGzN8CascuO?=
 =?us-ascii?Q?C8ukGknSbMFovbtpmbBHER0uFxHroIEfuwKVVSERvr44lyTeDy8F0qntiBm4?=
 =?us-ascii?Q?Z2zkgzIcTwDiI7KGk9JnvNfd5U+gipJpUVnnUBw+VTmkcqyMIqYacFgELljd?=
 =?us-ascii?Q?AniyQeuH/YgtpGr7YP4cxlez7pmE+K2QWEFnXYyxDuhEnUiC/SWtH8mFZom9?=
 =?us-ascii?Q?0JlwygDaqjRw8QnxRUUHmdq4+2OEBK5fDoiYb/Qvqq3GNkBFM3uRSYWOu+qP?=
 =?us-ascii?Q?1Ec+6JEhrVt0xPmvPwUZKdDucOf1xTRlBfa3vIVT2w4cv+we0YYfZeghU/ra?=
 =?us-ascii?Q?3m7MXu8I9EBcUGN9KpP/A2MfjyjZUIumiRYTmVoMpmlvpjdacDOrLjK2yppa?=
 =?us-ascii?Q?aRb5DItCI9wgUY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUGkbv0vp7P0OYUq8/njFpW2jT7AczTGAdm3sE+nC99e2jB/2vpdynVjP+ZG?=
 =?us-ascii?Q?GYe96zT1C90q7RZikzU6mdTiBSl7Hr1hiQOTmrSypCc7hihPQ3vyRWXhPTbZ?=
 =?us-ascii?Q?+Y6BWb4Ek6mUBwUehH6nhid12DfOEzarApp1vL4cItPwnGAYibxhy+K8l0zO?=
 =?us-ascii?Q?b5J0q0cIVwMmq1k/MfiQ9CmfRg3wpujBfn4VNhT/LPxbxOX1AM7DV7xkr3Sk?=
 =?us-ascii?Q?Cdjgz1okHgV9UvQf1+xJC1v9cRmYsFTTuagKtUJh8VlCYUPi4lCxBX52+0LJ?=
 =?us-ascii?Q?qspqmzwX9yTQVgvhyFefhAUBlYsfCu9Q6+iu0Tj6J3Iuxq59TVOjsghmE3xE?=
 =?us-ascii?Q?YC+rTXPTYw6Ke1wrgWuOQyIHBqh2vJpXF1da39weyeN3WyaXBzJAVNWa8Wnp?=
 =?us-ascii?Q?WdG5iWsDjehjDITTsyz3OU7xVgnnXICk3aUxcehkRHNzflXTAXvSn8dGwsTh?=
 =?us-ascii?Q?bvEM6wlsN4103y2igwIi2YgjQd11yrAeV/7HOWskfRTVQGmhqgC0HTYIiDSB?=
 =?us-ascii?Q?L+cVG1d2rChqie3548oBTvGIvj77shyVhZIDar+BulKTUi7eFPBHjcQiqx/N?=
 =?us-ascii?Q?8u4sIVNlq5JJvBy1r5NcshootxH8KxNS6F5qe+DxtOoSBYwEQ+YAWQWJXce2?=
 =?us-ascii?Q?gu3ejrFdPUm8Dsvo2INjLDTy2YRvrKLWMwu2uXPJlCHvJhYUZ0xBTDQnX9OQ?=
 =?us-ascii?Q?SKb1mUngjGJkxSryVapUYn7tcEy6qJuHyo2X6U5COASAwcfbGfjpxygtaAOw?=
 =?us-ascii?Q?vyHrGo2dKzLqj2Pbmp2gddr0zcmaF9QdB0kOGE6nzwVBX75DDeW3YRo00FQh?=
 =?us-ascii?Q?EmLGa92BiClUhEGiNBgQViRD2Q5nWWSsaJZBwWKri7VDdIeVtU8r6sAISRq8?=
 =?us-ascii?Q?ePI8cjmNY32Q8ck5diCT+Y1nbfK61RJV6MqZaTZNyK4MS+2cR7IobtijwpoR?=
 =?us-ascii?Q?pmPNHm9F6WGOlVina/TnENBiCl39zOBr5NAQ0tfxD8Xgl8PIy2F8S+wQav1p?=
 =?us-ascii?Q?Et4Ou7vRD40H7ir3Pk4LqNHOkayzKHdLJ4FDzD+v2DfK9acdO+A12mXMSjj6?=
 =?us-ascii?Q?CIcb0jn9zYLkknYRnb+BHFTJBHR5ur6+6yRH0Sw6p/T56L/YiqylV7bRFGN1?=
 =?us-ascii?Q?pO4kiq6i20EGtm57St+rgxtIm9yOzTb0xi5GO1/R77TURc6PErY5qF4phZeS?=
 =?us-ascii?Q?XgO5I43uVXsaAQ7lseK8YG39V06Lf1e4JrcqKeUxJB1cW4ZBq9XTg/d9u/2z?=
 =?us-ascii?Q?O5bVNpFjFoFMDM0/vB7l/9ULX9wCLC+0lQ6KDSPH0vLpJbNp2NzR4cS7NVAl?=
 =?us-ascii?Q?Y5BWIcuennCb7NBxUFMyYKTK5DUd+6P398WpFGP8fqIq4PBeDLJGGdq6OdQr?=
 =?us-ascii?Q?FlqizIr6gqrq4Xe/RiUt+zMx1pAjDGlZYfYzeIo0gnxDVpFIPlxtlv81vnKo?=
 =?us-ascii?Q?Ar2pZ0hOpmYYycTLt9ZIXDmKulAFJQmgOv+bj4WL0D8hx4lBBaWGHwYnZmyd?=
 =?us-ascii?Q?Qk72TDzs5aAV8qB2iCuUpHVhBVLXyZmb9IQuYHvFXbxqVrqrM65nGgP3rlCI?=
 =?us-ascii?Q?tL/q8UjFe5STZ7m7h3hw4VdwnTaiinSh7lpZGeefzONI/6vDazHC1ErojFXs?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d4446189-dbd8-4043-19e9-08ddd3a3deab
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:32.7278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvrQzemynalBM1mxet5Ew6b4BYjPzb+Klcc6aJ76CL8rJjGME0l/MRBU5olvqE8zxJMVziabsUfh+68MaM/N65dvcm7cJ7lLEoS7jRSX7K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

This also fix 8-wire support a bit.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
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
2.47.2

