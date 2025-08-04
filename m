Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F517C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291E6840E4;
	Tue,  5 Aug 2025 00:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="IH/MbgQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8C084105; Tue,  5 Aug 2025 00:12:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF84840D7
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULC4cc3juNoiXITQU5LRlsFX7QpqAAYR6lr8LVrAJxkLb5QeT7xNgCEWmwN7I2yKd+SOArSKe/dlQsf83ieXCyP5siGbyK1K35sLmePfg6hegJq1ItxRFB4qKdLAIViiw9UF881rjgf1nILA9bQnaM19i+jx195beOnd87IvQrKeo8ALqdJENRRUJa9w0aa+XEL6U+kpApjxfm3lh3MYQfcKQ2pRn45YE8gpqm5AKm11JQeVl995gWxZop9GiFUxmPbgeTV5DIPy4kRHVJFJaBpy7/j/4iV6YPXOA+DkJopEFyC05uGBJ1+1GKomiGsU0BUomBx2VAtq2TeVvvk1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=solRFXJvvULD9GInm/+mGfuBiyDFqRlNlxdNpbmB01Y=;
 b=NNqdZAIILa5QVyop/xN+H5OEy1DYjdOcySQ1lsZzpFFRPar/h7O3fiirKXQZ97Kd84vDQ+Q0PAPfrRBoDmsmift1SAOw2WuTwIo/Fg4Pk8adVU2W0p4YJo+BxKJPzUE0OFEkZePduTs3eK+t6qOY5hf8dGDq5NEhy0qyEmnL5T6aLeR1HCg8bMFRjQvytLI72se7JmP+bkNDfjXB92aHiWgHh6SfCtM0A8lWJ3W3PEVH1uEd8I+uDy/lTrWhckScuG0heyhQs0FnyFmsca6SMo1p6c7O1dC7J+g5Kd4z5eHQyAEyzEbjYcx8Bmt5NoCD5JDqnaVKhgopeqh9l/qGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=solRFXJvvULD9GInm/+mGfuBiyDFqRlNlxdNpbmB01Y=;
 b=IH/MbgQ5kgKbaXXltTJ4ehpT9spPlIDs4cmr+OuJmvYlQ1+1ahnN0+URUQC4bnzviv36GXOmp/CykvaovJ7UzgfyXWLiX8N2zBz2jBFp9u08LVU+hFpObIcO327g93HNePkSXosepc4n2/XGoGXWgF8R5VW5WjA+QLowg3YpXZBGnIEEfvkOwh23QS0YpoHKNn+PWMe3sEIXVuAI8uOSms7099BKKtlrvqwxkOnb+0YtwH9WNSS7eWvjtsrnkFlIoQ1Kei6YRp+sGQfGFPSgjq/bt4LOmvrq8nWfy2JiPNKQZnzFjv8IZ4vB44GrNco9fU0wNbZjHqyabecXlK/Nsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:49 +0000
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
Subject: [PATCH v2 15/22] drivers: mtd: spi-nand: add support of continuous
 reading mode
Date: Tue,  5 Aug 2025 01:11:15 +0300
Message-ID: <20250804221122.1420516-16-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: b917f74a-39be-4182-5456-08ddd3a3e8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3qQNnujL9OYcR/tbqLhDsmAzu30P0HDgH/NMKr/Dmhcim39NhaLp+U68qDKy?=
 =?us-ascii?Q?9ei+JiJx9dyEd/Ik6QiXUg82QrTeViwNW2kMQY+DeeJ02EecR/atGyXCYpax?=
 =?us-ascii?Q?GAcFFztmiZTi8jqPhDYtFST85nOQDggIph8LFk/W2q96lal73GlxixmeSZ4w?=
 =?us-ascii?Q?fBr3DObkdPWTWIMrRKK0GOWvrc9ogv7NpJcDgaHSBQe9Gb6za7w7kCCsyqsZ?=
 =?us-ascii?Q?CjLF+cC3aLT+hHwrWQ1CHAZ9H/er5IH6DkXKe6ZZmi/f9hTKV03zkwtyIazF?=
 =?us-ascii?Q?hAIvwL1ZZFLUWQSZjmLWCmfyEVsXj/lpnmL3szcXBQQUdAnSFHfJjrqy7XZp?=
 =?us-ascii?Q?IUpQ7s83O4O6TuS88Z36ukiN/ahych+l6yGw4cHkP0U8wgIVHBBS2zwk+dr0?=
 =?us-ascii?Q?ASxOQwco9mKHYaBuN4yfHO69BMvxRPoPSpEp40XGUzwImfiYTBIeZFsqdB7N?=
 =?us-ascii?Q?N8zlKa5FzuTb2FT7QbbmpKECjAH3X4pEDBVEz9XUbD3Pi3JDZ/Mtv7UjVnZv?=
 =?us-ascii?Q?eM6HFXiZlbOGbKIHFIjBvaMnu7LxnEFs5K7yE/UueA4l6wwKI+itnV2/zQdy?=
 =?us-ascii?Q?7c891uaW4aq5ZMjKb+36qmB9b5RU6x6VH/IIYRgE7gprNyW1AoQeiE3jIAO3?=
 =?us-ascii?Q?jx/IrBfpySZp1a6h2TlZY2YrYXcmm2eAUNX2TGaT8vKKVcJCbofVvHUs4ful?=
 =?us-ascii?Q?WkiRxlBoWo+68KNx6UtgpznXgp6u93eHzXBXU9Vst1jk7moEiPEearsf9tNz?=
 =?us-ascii?Q?OB1YxeyXJiCSTex+fzjSzTH/ktcDlGNxHKoFhxYU1I3+3HixSWZAhz+1R9K+?=
 =?us-ascii?Q?q2vRjcsRUZ+b8ptrD6JmR5yA4sfoo0UUMsiLFHR/9CUyv4hoe3en2KMo+1cC?=
 =?us-ascii?Q?VotKihZLDIgVQ4ozrYG6apVBMqtmGBo/wV2KY7/woOZRKSVAi4CSZ+FI/Hf4?=
 =?us-ascii?Q?9sqLI7lHT53HocxHJRSuYJ65bSkjVVcFux1SrMelKMqjg3emkNHWvI9t0s4j?=
 =?us-ascii?Q?auyVVLLWFN/zWaVGGutY9EOSwY3d9dtKzy8+spjujauoGECguGkIWwfV94H2?=
 =?us-ascii?Q?phY9hmc3HZl8VAo3DeT3HibGHrZ1fVaBsPRqcWALMrb8gP3omeo/d3h7UJKA?=
 =?us-ascii?Q?zjudN0V+AGnrXxScSPd2CSnIhZ2ennyoGIhqgk7e0gOPsJ8+r/A52AWxCpYz?=
 =?us-ascii?Q?9Q+EuQjWlv48ynHd+LTL4D/1199aVFhWxMyXY7siFVU6QhyThUg6MTf4Fyob?=
 =?us-ascii?Q?te6W6J1BmXeoMn56qJjF5ZVI0b/qKEPAJlJnUOxCQj9UaC0r1JDKIK0b/NIu?=
 =?us-ascii?Q?o6jjgFORkG/cn6uOEGh84fNbTLWByKOi2fBuJzJBp00XMv6QE4IT2D4fe5zn?=
 =?us-ascii?Q?ItWt3684Qj5M/Lz9iJ4MXKHzizsAzcKNI6ewAew9tGcXqkxoQ5Lu9NHyC94e?=
 =?us-ascii?Q?A0mJ7qX9KYuT7A7vbJhq0Pbl2PMjzhEV+0w5h3M62Md23LFzgxmAvg5XT1x+?=
 =?us-ascii?Q?atz1aZfyyXw7mv0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4yPxnzPA66Iu0x6Ytwd8PxXx8tk47H1hm68UIRYcs7V76QxJm4G97LgxG9X?=
 =?us-ascii?Q?fdCEysfWLSpdK1WikJtMRfpgmPBZ/Q+YV7AvMOsV4v931NcxwK8ykEifI3Kn?=
 =?us-ascii?Q?b9WI1djXYSgdy8XawctcOvkX06tZEGsal1X7FXjG8ecbBQx8O3AW9RCnh8eu?=
 =?us-ascii?Q?3WmQ74/ogH/qzBFwWnmb3oFgS3Xe5P4Vom2UcDVWw/cjOLbP2bBU3aAF0o0M?=
 =?us-ascii?Q?FV3Ve5WbqrhiYG5CpgZ+aECXZr+W+hUcEmmgniItmK9fRo3PvbtWkhSb/3rA?=
 =?us-ascii?Q?iVHdb484If3LkO9YJJGKNj32margJ+ldHSrIbqMDz91ga0Xnw7ZDrHV5iafD?=
 =?us-ascii?Q?PVBwD2ZC2fkqmIqQdZxor15cyU8y5Fb8TuYBJMv6CIesz/JUNylCojJGLF79?=
 =?us-ascii?Q?rp6PHV0p0WmVHEONhgYeeYU/G/l0t4pFOcaOnPZIlDixR+TcG46p5KnENAjZ?=
 =?us-ascii?Q?YVO1B+A4AhgFKOmQqGY3Yp4d2xWLJZnz04vY+IDrWg6IC8+wJZipfnR60pI1?=
 =?us-ascii?Q?+U0JuQtDVG3Ok1GJmSIVqdlACv/jNq+LOrz2b87nPgXRXX3X/MoV6lq6t+d8?=
 =?us-ascii?Q?Y4yY5TtVjbOVFaU0zZitcbxDvuXyQ+Qzktni3wRi3M9Zdh/OXajxqZSI/kJ/?=
 =?us-ascii?Q?/XMRGpYxCnrqnF0KL6VgnNY18K4jFRKvi2oBKXSPYMxckRI2AUcONS1qDuc2?=
 =?us-ascii?Q?vez73ogh9pWYAfqaBlv+rBGVa+r12auZXEbL4SeFgevw9jtldSsC6Ad08hWD?=
 =?us-ascii?Q?RUMiLuguj3FCuLINDREb+BGyT4hHVlKtPTxIamAzRAhMtP+eMoO7iuWlmi87?=
 =?us-ascii?Q?v5F12h9eXaNjbq4IG+fRFQRvv6hm1JpBBJ1v5l9VumGlzRF0MIbc/kJIZ9M2?=
 =?us-ascii?Q?h2CMnGFqqe8XEUkberFPV6EopRWpG+2hiC7fJRA+z47ROoHiL2CnqiZA3/XL?=
 =?us-ascii?Q?5IlxtwijFT3nZ3HTjRzEAANQ5Eufw8s88t49zkkCkoWIOjsO+l7jIV6pPbFD?=
 =?us-ascii?Q?2z/d6ly1fnzM+NUw98Pn6k4Sx+FHuGf9gBevPgUV5r1U8w2cYLB+rWX4UPvh?=
 =?us-ascii?Q?NiBDwVvKQijRrenecJfh8UutIrWYlHBvtWYRXtaZh7nGBKajfbsLysF+Pt45?=
 =?us-ascii?Q?3qfC0FCLbWXryVvodPRXUwEdLKS17N8LyWtxW+WHZnHMnxSMFdDLUVwdD4cW?=
 =?us-ascii?Q?JdrzG6dvVyaDLJImKqz3tgtj1/Ijrqboj90i0m0IIzSaNXngbgu8bn2GcMdT?=
 =?us-ascii?Q?K5+Fp/rBypY5cS52zN45uOrLsiwIBhBJ59bexceOhadH8v2FU6M1DCs/H0IU?=
 =?us-ascii?Q?9xXQM+kCacwAzJ/nwUR++uq95kq9wBLvdcfOC0FcxOIWH1frKR9fCyJMWM5T?=
 =?us-ascii?Q?6jeCRRT7MhgSTVtTJCwUcQ4IFcCmqbyr2uhNNUhoGOXLj9SS7FxBnSv0cOq2?=
 =?us-ascii?Q?3qx0fi4ZfpeR//zP6Ut8CS8RP85EqMdJTySPj50YGONoN1NGLgq8i0jc8kuZ?=
 =?us-ascii?Q?r3JWRCVKmklG7N4USeYl84j0M1S7A6/rhGbqodS5Duc4q4UNj3HQjkWvWpCr?=
 =?us-ascii?Q?JSjPZwVCHK/HR0FmBI7A0SPdOSaFZiIqkSZNYx0R5OmfnfoGUAuzcMhmjL9s?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b917f74a-39be-4182-5456-08ddd3a3e8e1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:49.8654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cMXlifILsTk/V4368726NWH+PWM9jAWmS/+sxpiaw47dzTjHnqYNMjV7hPciR8//m46k+cr6h3dPioIUbk6ynCKpaTXjX97HaXeqwWjfdw=
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

The code was ported from linux-6.12

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 210 ++++++++++++++++++++++++++++++++----
 include/linux/mtd/nand.h    |  90 ++++++++++++++--
 include/linux/mtd/spinand.h |  19 +++-
 3 files changed, 291 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a8fb3177f8a..a52cc91dd3c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,13 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+
+static int spinand_cont_read_enable(struct spinand_device *spinand,
+				    bool enable)
+{
+	return spinand->set_cont_read(spinand, enable);
+}
+
 static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -323,10 +330,22 @@ static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
 
 	/* Finish a page read: check the status, report errors/bitflips */
 	ret = spinand_check_ecc_status(spinand, spinand->last_wait_status);
-	if (ret == -EBADMSG)
+	if (ret == -EBADMSG) {
 		mtd->ecc_stats.failed++;
-	else if (ret > 0)
-		mtd->ecc_stats.corrected += ret;
+	} else if (ret > 0) {
+		unsigned int pages;
+
+		/*
+		 * Continuous reads don't allow us to get the detail,
+		 * so we may exagerate the actual number of corrected bitflips.
+		 */
+		if (!req->continuous)
+			pages = 1;
+		else
+			pages = req->datalen / nanddev_page_size(nand);
+
+		mtd->ecc_stats.corrected += ret * pages;
+	}
 
 	return ret;
 }
@@ -368,7 +387,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 
 	if (req->datalen) {
 		buf = spinand->databuf;
-		nbytes = nanddev_page_size(nand);
+		if (!req->continuous)
+			nbytes = nanddev_page_size(nand);
+		else
+			nbytes = round_up(req->dataoffs + req->datalen,
+					  nanddev_page_size(nand));
 		column = 0;
 	}
 
@@ -399,6 +422,13 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		nbytes -= ret;
 		column += ret;
 		buf += ret;
+
+		/*
+		 * Dirmap accesses are allowed to toggle the CS.
+		 * Toggling the CS during a continuous read is forbidden.
+		 */
+		if (nbytes && req->continuous)
+			return -EIO;
 	}
 
 	if (req->datalen)
@@ -639,24 +669,20 @@ static int spinand_write_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
-			    struct mtd_oob_ops *ops)
+static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
+					 struct mtd_oob_ops *ops,
+					 unsigned int *max_bitflips)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
-	int ret = 0;
+	int ret;
 
-	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
-#ifndef __UBOOT__
-	mutex_lock(&spinand->lock);
-#endif
-
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		if (disable_ecc)
@@ -673,18 +699,152 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret == -EBADMSG)
 			ecc_failed = true;
 		else
-			max_bitflips = max_t(unsigned int, max_bitflips, ret);
+			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
 	}
 
+	if (ecc_failed && !ret)
+		ret = -EBADMSG;
+
+	return ret;
+}
+
+static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
+					    struct mtd_oob_ops *ops,
+					    unsigned int *max_bitflips)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct nand_io_iter iter;
+	u8 status;
+	int ret;
+
+	ret = spinand_cont_read_enable(spinand, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * The cache is divided into two halves. While one half of the cache has
+	 * the requested data, the other half is loaded with the next chunk of data.
+	 * Therefore, the host can read out the data continuously from page to page.
+	 * Each data read must be a multiple of 4-bytes and full pages should be read;
+	 * otherwise, the data output might get out of sequence from one read command
+	 * to another.
+	 */
+	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
+		schedule();
+		ret = spinand_select_target(spinand, iter.req.pos.target);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_ondie_ecc_prepare_io_req(nand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_load_page_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_wait(spinand, SPINAND_READ_INITIAL_DELAY_US,
+				   SPINAND_READ_POLL_DELAY_US, NULL);
+		if (ret < 0)
+			goto end_cont_read;
+
+		ret = spinand_read_from_cache_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ops->retlen += iter.req.datalen;
+
+		ret = spinand_read_status(spinand, &status);
+		if (ret)
+			goto end_cont_read;
+
+		spinand_ondie_ecc_save_status(nand, status);
+
+		ret = spinand_ondie_ecc_finish_io_req(nand, &iter.req);
+		if (ret < 0)
+			goto end_cont_read;
+
+		*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		ret = 0;
+	}
+
+end_cont_read:
+	/*
+	 * Once all the data has been read out, the host can either pull CS#
+	 * high and wait for tRST or manually clear the bit in the configuration
+	 * register to terminate the continuous read operation. We have no
+	 * guarantee the SPI controller drivers will effectively deassert the CS
+	 * when we expect them to, so take the register based approach.
+	 */
+	spinand_cont_read_enable(spinand, false);
+
+	return ret;
+}
+
+static void spinand_cont_read_init(struct spinand_device *spinand)
+{
+	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
+	if (spinand->set_cont_read) {
+		spinand->cont_read_possible = true;
+	}
+}
+
+static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
+				  struct mtd_oob_ops *ops)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct nand_pos start_pos, end_pos;
+
+	if (!spinand->cont_read_possible)
+		return false;
+
+	/* OOBs won't be retrieved */
+	if (ops->ooblen || ops->oobbuf)
+		return false;
+
+	nanddev_offs_to_pos(nand, from, &start_pos);
+	nanddev_offs_to_pos(nand, from + ops->len - 1, &end_pos);
+
+	/*
+	 * Continuous reads never cross LUN boundaries. Some devices don't
+	 * support crossing planes boundaries. Some devices don't even support
+	 * crossing blocks boundaries. The common case being to read through UBI,
+	 * we will very rarely read two consequent blocks or more, so it is safer
+	 * and easier (can be improved) to only enable continuous reads when
+	 * reading within the same erase block.
+	 */
+	if (start_pos.target != end_pos.target ||
+	    start_pos.plane != end_pos.plane ||
+	    start_pos.eraseblock != end_pos.eraseblock)
+		return false;
+
+	return start_pos.page < end_pos.page;
+}
+
+static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
+			    struct mtd_oob_ops *ops)
+{
+	unsigned int max_bitflips = 0;
+	int ret;
+
+#ifndef __UBOOT__
+	mutex_lock(&spinand->lock);
+#endif
+
+	if (spinand_use_cont_read(mtd, from, ops))
+		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
+	else
+		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
-	if (ecc_failed && !ret)
-		ret = -EBADMSG;
 
 	return ret ? ret : max_bitflips;
 }
@@ -821,6 +981,7 @@ static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
+
 	return ret;
 }
 
@@ -846,6 +1007,7 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 			   SPINAND_ERASE_INITIAL_DELAY_US,
 			   SPINAND_ERASE_POLL_DELAY_US,
 			   &status);
+
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
@@ -902,6 +1064,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	};
 	struct spi_mem_dirmap_desc *desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
+
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1131,6 +1296,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->set_cont_read = table[i].set_cont_read;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
@@ -1256,9 +1422,8 @@ static int spinand_init(struct spinand_device *spinand)
 	 * may use this buffer for DMA access.
 	 * Memory allocated by devm_ does not guarantee DMA-safe alignment.
 	 */
-	spinand->databuf = kzalloc(nanddev_page_size(nand) +
-			       nanddev_per_page_oobsize(nand),
-			       GFP_KERNEL);
+	spinand->databuf = kzalloc(nanddev_eraseblock_size(nand),
+				   GFP_KERNEL);
 	if (!spinand->databuf) {
 		ret = -ENOMEM;
 		goto err_free_bufs;
@@ -1283,6 +1448,12 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_cleanup_nanddev;
 
+	/*
+	 * Continuous read can only be enabled with an on-die ECC engine, so the
+	 * ECC initialization must have happened previously.
+	 */
+	spinand_cont_read_init(spinand);
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1330,6 +1501,7 @@ static void spinand_cleanup(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 
+	spinand_ondie_ecc_cleanup_ctx(nand);
 	nanddev_cleanup(nand);
 	spinand_manufacturer_cleanup(spinand);
 	kfree(spinand->databuf);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 910ef56ed0c..9285edd5c4b 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -101,6 +101,8 @@ enum nand_page_io_req_type {
  * @ooblen: the number of OOB bytes to read from/write to this page
  * @oobbuf: buffer to store OOB data in or get OOB data from
  * @mode: one of the %MTD_OPS_XXX mode
+ * @continuous: no need to start over the operation at the end of each page, the
+ * NAND device will automatically prepare the next one
  *
  * This object is used to pass per-page I/O requests to NAND sub-layers. This
  * way all useful information are already formatted in a useful way and
@@ -123,6 +125,7 @@ struct nand_page_io_req {
 		void *in;
 	} oobbuf;
 	int mode;
+	bool continuous;
 };
 
 /**
@@ -638,19 +641,19 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
 }
 
 /**
- * nand_io_iter_init - Initialize a NAND I/O iterator
+ * nand_io_page_iter_init - Initialize a NAND I/O iterator
  * @nand: NAND device
  * @offs: absolute offset
  * @req: MTD request
  * @iter: NAND I/O iterator
  *
  * Initializes a NAND iterator based on the information passed by the MTD
- * layer.
+ * layer for page jumps.
  */
-static inline void nanddev_io_iter_init(struct nand_device *nand,
-					enum nand_page_io_req_type reqtype,
-					loff_t offs, struct mtd_oob_ops *req,
-					struct nand_io_iter *iter)
+static inline void nanddev_io_page_iter_init(struct nand_device *nand,
+					     enum nand_page_io_req_type reqtype,
+					     loff_t offs, struct mtd_oob_ops *req,
+					     struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
@@ -669,6 +672,43 @@ static inline void nanddev_io_iter_init(struct nand_device *nand,
 	iter->req.ooblen = min_t(unsigned int,
 				 iter->oobbytes_per_page - iter->req.ooboffs,
 				 iter->oobleft);
+	iter->req.continuous = false;
+}
+
+/**
+ * nand_io_block_iter_init - Initialize a NAND I/O iterator
+ * @nand: NAND device
+ * @offs: absolute offset
+ * @req: MTD request
+ * @iter: NAND I/O iterator
+ *
+ * Initializes a NAND iterator based on the information passed by the MTD
+ * layer for block jumps (no OOB)
+ *
+ * In practice only reads may leverage this iterator.
+ */
+static inline void nanddev_io_block_iter_init(struct nand_device *nand,
+					      enum nand_page_io_req_type reqtype,
+					      loff_t offs, struct mtd_oob_ops *req,
+					      struct nand_io_iter *iter)
+{
+	unsigned int offs_in_eb;
+
+	iter->req.type = reqtype;
+	iter->req.mode = req->mode;
+	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
+	iter->req.ooboffs = 0;
+	iter->oobbytes_per_page = 0;
+	iter->dataleft = req->len;
+	iter->oobleft = 0;
+	iter->req.databuf.in = req->datbuf;
+	offs_in_eb = (nand->memorg.pagesize * iter->req.pos.page) + iter->req.dataoffs;
+	iter->req.datalen = min_t(unsigned int,
+				  nanddev_eraseblock_size(nand) - offs_in_eb,
+				  iter->dataleft);
+	iter->req.oobbuf.in = NULL;
+	iter->req.ooblen = 0;
+	iter->req.continuous = true;
 }
 
 /**
@@ -694,6 +734,25 @@ static inline void nanddev_io_iter_next_page(struct nand_device *nand,
 				 iter->oobleft);
 }
 
+/**
+ * nand_io_iter_next_block - Move to the next block
+ * @nand: NAND device
+ * @iter: NAND I/O iterator
+ *
+ * Updates the @iter to point to the next block.
+ * No OOB handling available.
+ */
+static inline void nanddev_io_iter_next_block(struct nand_device *nand,
+					      struct nand_io_iter *iter)
+{
+	nanddev_pos_next_eraseblock(nand, &iter->req.pos);
+	iter->dataleft -= iter->req.datalen;
+	iter->req.databuf.in += iter->req.datalen;
+	iter->req.dataoffs = 0;
+	iter->req.datalen = min_t(unsigned int, nanddev_eraseblock_size(nand),
+				  iter->dataleft);
+}
+
 /**
  * nand_io_iter_end - Should end iteration or not
  * @nand: NAND device
@@ -722,13 +781,28 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  * @req: MTD I/O request
  * @iter: NAND I/O iterator
  *
- * Should be used for iterate over pages that are contained in an MTD request.
+ * Should be used for iterating over pages that are contained in an MTD request.
  */
 #define nanddev_io_for_each_page(nand, type, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
+	for (nanddev_io_page_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
+/**
+ * nand_io_for_each_block - Iterate over all NAND pages contained in an MTD I/O
+ *			    request, one block at a time
+ * @nand: NAND device
+ * @start: start address to read/write from
+ * @req: MTD I/O request
+ * @iter: NAND I/O iterator
+ *
+ * Should be used for iterating over blocks that are contained in an MTD request.
+ */
+#define nanddev_io_for_each_block(nand, type, start, req, iter)		\
+	for (nanddev_io_block_iter_init(nand, type, start, req, iter);	\
+	     !nanddev_io_iter_end(nand, iter);				\
+	     nanddev_io_iter_next_block(nand, iter))
+
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 63626c9c27c..2f8212e4037 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -175,7 +175,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN	5
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
@@ -336,6 +336,7 @@ struct spinand_ecc_info {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @set_cont_read: enable/disable continuous cached reads
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -354,6 +355,8 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +382,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONT_READ(__set_cont_read)				\
+	.set_cont_read = __set_cont_read,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -422,6 +428,12 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @cont_read_possible: Field filled by the core once the whole system
+ *		configuration is known to tell whether continuous reads are
+ *		suitable to use or not in general with this chip/configuration.
+ *		A per-transfer check must of course be done to ensure it is
+ *		actually relevant to enable this feature.
+ * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
@@ -457,7 +469,12 @@ struct spinand_device {
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
+
 	u8 last_wait_status;
+
+	bool cont_read_possible;
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 /**
-- 
2.47.2

