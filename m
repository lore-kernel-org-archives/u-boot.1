Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1FAC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE028416C;
	Tue,  5 Aug 2025 10:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sA8j4o0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE13E8304F; Tue,  5 Aug 2025 10:15:39 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FCA8415B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8xCiL48jY4njEgmTCl1CYLoKBX6fnGpypt4bzvbiZEHxDxzW7voYOi6xZvEWFmL3lp9Zdc1kdld1e1566ud5eo1HiZ5L1JNjetFM/DNM6HuD++UyZT/Qi4vLScCqoSdCGWtAVuDKBCqn880aNrklD8AkPP3KsxrphmI5tFC5Cul+3jzl6fhjIKaG5NM25YA2XAJC1BosXTPoCddJ1GhIUF/BVnz1WCr2oex8js7ReWabeIkD5MQkc3Oj/1PQ19tsyT9MyP73aLdBz003pH6yxBvguNA7mBpczCNUpfmga9O4sIgxD+4yvThOeoyEMbHwH8C4+GYfg/sEoecbUcNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v/yRZS/aADAjS8OmojHzPrLMnm6VhT7XfyF/56YGWE=;
 b=OsYKi3YWSPgziQy5U650/7MBbavk3afcE7QNesqxwbJrjIA7PssH71PcbG8Y3TWkDVSodeRWQ+sgX4X13DmYLyUuqjuDkCDfgTuLDbCBv8nS8xzaPF2pE5+porxWCdNYmduw2th5i21eOs0xpdnLdvNGY48WW82QXzVKbWwP6nzueNhOCvg84q2jhLE+LIjnqrv4m+VKPJvpDCfBVeSUQrHea9Hsp9YqZbr1j3Kf8YLWLM04FaFIo/G/6izdl4Pit16/u2ciSPsip098ey1WcFPNQvbsAsiWWQGjOQ0Crm2CONxeFI6jwXHt1I7UFiv8kfYrSWDo5g0wJaODqwP/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v/yRZS/aADAjS8OmojHzPrLMnm6VhT7XfyF/56YGWE=;
 b=sA8j4o0AnZcxbT0Xv6YCJtGa60Z6ZA9PpTfchC5XiSDEDEKtFD/PDnvAc2fzbZE3+TDOH46laLQxNq9qjGKhpXCtatDta9OsIrhwv36K+6e6NM1LQYleHQJbZQoRx5BfcsXoi0HluQ8BFUpnEDEcWjazhxpnxLOGV5OKdBgvRa6hi9fcbUma5nh0hPFQDnhT5ROsjvE3wLuVgrVfv/M/dEZkgpzs8uwARo30aT0eonKOOSgb23VezsgvLlnmWv4hywVW9us1t8xMm9VO3hX6TWzzn0tFRgBJOcKiRZ3CMpngC/3x11ao83r70hPp82+SC1GQ9evNYyBy2iMMTrEv0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:31 +0000
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
Subject: [PATCH v3 09/22] mtd: spinand: more refactoring
Date: Tue,  5 Aug 2025 11:14:58 +0300
Message-ID: <20250805081511.1482964-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: fbad8682-17f4-42d8-070b-08ddd3f83e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nldbhwVTSO9fxvVgzcslzvYWdC9zGOZlNA+8HywuzQrk2ZE2AMPg/KNgpzRP?=
 =?us-ascii?Q?9OoOOl34DGvwFAl4E1n+cJ64aUdzQKs6BtIJH+sULGNzON4/uhln9RMHc6JJ?=
 =?us-ascii?Q?WUjBq8iUEMsMo/HI9tcD8GUhEqm97fUyeaQ9nEX0Bs9nC60zBeYCxKfrQDDm?=
 =?us-ascii?Q?zM0bIWguOVITLYc1s81b98a5Jn0Hja7JVtcgJNWAPjc4p9Sv5h8lx+SUIZRH?=
 =?us-ascii?Q?d8c/ZvibFCyQQk70sjbBYu0OzugoG7LKH8r+6QoWrNT65QGdK+62NLfswj71?=
 =?us-ascii?Q?2xqaRdcjSZQGxQcbw5NvncY5lL69Vot9asH8J0MjfwzxvEsgWXAEgj0ml2oQ?=
 =?us-ascii?Q?N44WPRBJYXeSaIGT9PsTgP49LQCcy62wRmFRcpkPWsbIyh3syx1mDy/g5oi5?=
 =?us-ascii?Q?b5MlVYebjjlcYjXq4Kv6iYCcsMymNE0maidRUL3b/ub0VZshMoOIOSZ/HvqK?=
 =?us-ascii?Q?Hqr/mphzaxYO0STEiFUT9SxZpzx9MPBfkoE4txhcrWlwBTnTNu15f8cV0BL4?=
 =?us-ascii?Q?kPo3jv6pvPAmLGb655eLAsaZ2Jh64jPHYzoSPdg8Zdti9M/wvWcC2yiKnmgQ?=
 =?us-ascii?Q?el8aGK/bfqkVzU8+FupXg/kzJPOvOYXUJh7ECwLHM2C3XVd1TVwzV/YPQLSu?=
 =?us-ascii?Q?/EZDfldNlEoBJT0JU9iUA1NLY42i+UuCtWsDOQq7LD1yjNYRYLhLotf6bEGU?=
 =?us-ascii?Q?FYZlj+gvlgq4HsgPsr1TP0vMXwEOKeQEhw6siCKhShq6z3y2rhmQ6f6K+Ueg?=
 =?us-ascii?Q?Q0uIyEZ7ci8ccJGmJ6szh7nXNPoUiNozrkGLD6roEYjQK/n9Jn3ajNFvuFTS?=
 =?us-ascii?Q?Qe0GJXQqh3oQrg0OeXbAuzEIq7WAX0GTtXTukQKVjG86Weor42w0ngDrn12K?=
 =?us-ascii?Q?EBvieIyBzvZO0sDj/rkvmQXMIzDSKpOJ/0pJ4VR9NFny9Jn5YuuxDd8Rwr+F?=
 =?us-ascii?Q?xLD7en9ShhXyOJMi+MCsVF9BV2Lpj0VkgKRFa+A8hDe67xGN++QadsQdJRws?=
 =?us-ascii?Q?YljtdBAX1+gQVei+5QkgbyMN5i/hUQTp0PPHMI9HFS0gxt/D7RWTSkNdzXyn?=
 =?us-ascii?Q?ZBVRzmHzvBSlNcMMjIK/7YWXOZ8zAWA6LyYsmwuXxnx0oxfckvIGUcoTpbL2?=
 =?us-ascii?Q?fhR1o1jpzDTZhHgwmvj5pVkbxZdCenK4RoS021SChIodix96SmXy0IuXzJz1?=
 =?us-ascii?Q?x12jaeQkQkOW/xT0dkSgxn3g1NEcvW5S7KAjOFJ+B1qXnLXjsitdLTOGRK+2?=
 =?us-ascii?Q?KoDcJPHAWPJeLlGs2V3W/8XUF/s4aWPRu/jEa98plWe6esxfCbNtcbZaSRvp?=
 =?us-ascii?Q?PwdTSTw2qQ+XN7xEjCYnr85J5qm11760rojgvr3DQhlXaoaK9xhBE/MIDUvR?=
 =?us-ascii?Q?kk+BYB0mBnKdD7yjdr8HDWVSU+347tjOuJQdus8xdHgGEFWZ3t1kAhXMG8aY?=
 =?us-ascii?Q?/B/oKlfo2Ee9pyMgIpypNzKkwakwOgGmx60/cI1nFp033EQ9Lm6dzd51K7bD?=
 =?us-ascii?Q?lnVM7vnr9xQGfNA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nF6lqduXDMifYxYjXT+IKQ7Sk1PuzGuMv1/QFsNJTWhJvm+8lItT7Nqtzdsg?=
 =?us-ascii?Q?JBEfZPERuz+UNdUT/W9AiUJEyr5v2+vTKHT9ikDb4YqSIYYJOXJJ8/GVOwZr?=
 =?us-ascii?Q?Pmxs6rD5zOsT3EFLdXfh+M3yDV8E7yEAUMhKiERqz82AaEoJYl0nELGfWY1E?=
 =?us-ascii?Q?lWIWCXMDSWwgkiRpjc58tLvqURAK3gqVP+QCawzfMrj6UsO3zKv+XuvAHO/Q?=
 =?us-ascii?Q?gPTilfPVfuCx3yDcPRTSkZExCnYUJKtaftjyaos8svX9Dqw+/NOvumQa6MBN?=
 =?us-ascii?Q?KUhdmnk5A0zZ24NkIMxI01Ro1bUFfG8LEZ6o+IOXYUf9pHDZeZ94yTwSRPX1?=
 =?us-ascii?Q?/bpX41RDOk+xHopfrhgGo40WKuKchpipmgbs9AYw6n4rMYBGVxTFuW0jOjag?=
 =?us-ascii?Q?++2pSET0+6TYvYL9oJTXdbbIAqscVkWSIxKHgJF7UNbJg4Aumt9ziKxjaDVD?=
 =?us-ascii?Q?vGGYmTYnXnTBWuOxH2VhTP0OlqrwCUkWXJl/m+xkUW6EPC0+Hv7JHtLgVBQq?=
 =?us-ascii?Q?PycWvYbAe8REwLyfewEtXT4/I4aXr8uc5u9Dz0FOATrBLfk4pb2O9yqAy61P?=
 =?us-ascii?Q?Cg7Eiw5Q5efj2v9UNsSOhNvSwgxXEhHQ81NhYUnhQgqFa7uv4L9Th9zmvYPL?=
 =?us-ascii?Q?ayKTGjFrf9dRcplRtXZi1chkZXYId9ycHbbfI9OcRGbkXpDgD4XR12bM1fJS?=
 =?us-ascii?Q?2Fz3w6CGbZmOIikw4LV0OZdyyoVRFrWP68dwuvVmLPy4RiHISPjVccOjydxc?=
 =?us-ascii?Q?JNKu+8JMbxsPuKHyF4QiJIRPhviT1StHJrzmPny4z8WnT1toSu4eEY3K00WY?=
 =?us-ascii?Q?MajOLVuwCY4cV641pZq+mFDFxqgu+LcLQ7/9Fn8B18G9LFOpZI9tT/CShVSL?=
 =?us-ascii?Q?KZ+At5dE3ZMyHXEE5nYzVMMGHkxEj4tnISLknz5uFhZ1RgRguP2tA311dR15?=
 =?us-ascii?Q?nBhdKjQzYKcT+bYEgt6ASvYj+k+2Gxj2AVGFrEhdAVQRJt//CZn1lxH4CT1Q?=
 =?us-ascii?Q?wz8bBZTWdP5pmmpw6bvDA27378CMpAUrroYDxwsXWCmkbz3wxQoj9lbf9rl8?=
 =?us-ascii?Q?NE0wi0S6vxtx0AFMbJYLQ1ceCJn6VqglBC+jL17T837VORL63gN2eNEJ6GBQ?=
 =?us-ascii?Q?DzTosWv14pQKAJAEXVVQ/7a4gdERQWJMkZaJ/TLzhwkLCATdj/F7Jx8DfgxR?=
 =?us-ascii?Q?v/gIZrmiG+RZGuKCiR9EG17o2efPdFpN/XJsrAZTSEz4uNybIdS+1yUoSI5W?=
 =?us-ascii?Q?ElM8RzBqGxYOJNcb8o++L74ucYolHFjbKT6iHcx1OJKw3sXeK5RPvaZD8x/H?=
 =?us-ascii?Q?+n6ckUa+392RzwBM0v6gxanIUaiXHZZIByIy2COOUwaBj9ScXxoqjMFn93DY?=
 =?us-ascii?Q?ZG4O/kqCiGj5YX5+rl1pen/9VGJjtjD5FDCdVsFASuw3/Kjf1qX0ph8pmd18?=
 =?us-ascii?Q?OWyiUmU/1Ce2KZeoe9dVBi9Ar91UgEi7excO//5LYuyzaoxpZFJjLyPdVOI5?=
 =?us-ascii?Q?g8jZdR7DoCHH3o/59fZ4OISW5IuOfE6fNOkL49VxDpoWw/8l+wVgQY8qz9ad?=
 =?us-ascii?Q?AMtIXeC/TF38C5AUrplc7wrPvy+ux/IHpaQiyk1xJyqaILWKoJ+usTQz0UgC?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fbad8682-17f4-42d8-070b-08ddd3f83e7f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:31.2607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nagJmtNxOUc1RF0HMc7C2X/cutYn7kOpWEkzghkp8lioR1umjBIJkU3y7KQi6VbA3Rlj+AUPjWHrtZWwfjhAT4csjpmfGbg4wgP+DqacFf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
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

changes:
 * Move spinand_check_ecc_status(), spinand_noecc_ooblayout_ecc(),
   spinand_noecc_ooblayout_free() and spinand_noecc_ooblayout close
   to each other.
 * some code formatting
 * remove comments not present in linux driver

This make code more close to linux-6.10 kernel driver

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index df59d3d23ce..a6353b37e7f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -413,9 +466,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -445,35 +497,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -1074,30 +1097,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
-{
-	return -ERANGE;
-}
-
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
-
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
-
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct udevice *dev = spinand->slave->dev;
@@ -1187,10 +1186,6 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
-- 
2.47.2

