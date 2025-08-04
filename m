Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02648C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BA484015;
	Tue,  5 Aug 2025 00:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ivzNaeUU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA86C83FF8; Tue,  5 Aug 2025 00:11:46 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 129A08401A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+p4iIF5w9CoeWLfT4mpCX6pXEuPJBG5aVGdw5uPIhksMSfx5a09GAy7HiYGz781TfyEuE+ttEep1JaN9kIyXWx78e4/cMi6o2H2IoIR3YH3D2vAnFvJ67YkDeQrqcWtYi/Vvsm4VDcyQcASUCpfBoMW+XfY4IDw3say8t4vETGMvW79+SpT/D7oGMUhkOGxnm2qVwzqwHLrh+/RReTRjT3lqdOm928PKipLbHPLfox/H0oebJRnxz2sK3e3vf6/n9WfEhJLoytZw15fIoGbrXxCw5Ee27d3lzC3bbr+gIp/FW3s7qcx4uLIrwGHfDrL2NgI0Eg/STWhob8tRzt9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpbXnn6DY20jJOtBeiQ5nd2dW0hUh87EMimBLfaBjVk=;
 b=hHEED5EmAiTOb2lXMIcalBnmoyoDZvQkoWf6ckTo+U+55wMnU7Xy2n0+irkPun/Dc2GKCR8zIuCCdmtCvP8oJP7W8jgkGlBVvVDq8KamFMPWSoxzCRkbyzRs2PGrqJrncJ46oAHOpP2FZzIKGUPjxW0A3AyFY8VDEE22jQcrFKSExXAHudhnE8TCKueN7nd6nEl/LauO0nmK0vCH4blunj2TOxf8Si9A4pgyZeb08IPsMYVLZC8J0pdPTVeHljMQ+Vq1g4bgFdTglItr/N7mcwOvVuJoJuOZ5TdZizFiwzM2SUbOs29iWvButcEbE4xPkUthSCWx7gqmNlEZDO5s8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpbXnn6DY20jJOtBeiQ5nd2dW0hUh87EMimBLfaBjVk=;
 b=ivzNaeUUm0jwyyExfZpZrv4B8phKGvTGKCG/nPZEPJTl+2C0ziQkeE2uLs/DhmpaTc05BW55c/IUtFQbBQ12/zY2RDC+ZSh0edlkBmosf1HG92Oc0dysbZY7JvbsobyCaNTpoF65EoZejzlmo41hPK99J/FdY2rAJJrPoqCeSY2K+sRmqZEY8pHz8cDUgF6V4F3KYaYPlL0NDto8K+udiLRAJ0m+WYIijpWV6xBrsq8me0JY4dlJuebX6y/d9+1YXnk6yE7vbMFJ32TpM5ch2s+6gMp2s6+SdlMqf8blUv1FpLKRYe+wuT/A3hVAE2Wla9jQSu+MBRQ/mwtPSlXfMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:37 +0000
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
Subject: [PATCH v2 05/22] drivers: mtd: spi-nand: simulate behavior of linux's
 function spinand_wait()
Date: Tue,  5 Aug 2025 01:11:05 +0300
Message-ID: <20250804221122.1420516-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a163fe0d-5ca8-4fab-6ae5-08ddd3a3e1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?noL1VCuA4DlrBO9oRjoOfi4ZJEOHV7TwT8Tgj+kj4t6S67dXz90izPkh28m3?=
 =?us-ascii?Q?Zgw5xDAUcnWQV9SztHhiFTt3FDaA2spBPja0H7T3gEfFwcAKccphU0iLtA4o?=
 =?us-ascii?Q?dCrOlbNJm/ZJHXxct7rwA86RXXKeV+in9WKN3a7EtMON4ssTJ+PSWu744JIA?=
 =?us-ascii?Q?wtSzAqUK+f3U14J2ZFIqRFQDKXd+0I5M+ap5w4kELkSjNW8PE/HcI0+mz/V6?=
 =?us-ascii?Q?ZzGJbYI9K7M2Ag4WLpeuzzFnZWJhMPaAIdpleAeddQRjxXUoyWDRIOz/auQB?=
 =?us-ascii?Q?fFxaV/wVlv4WMbBq/kmo1jrxwrYoAHNSLsDd0QMcsKZ7DtRdbnobMIsVg4/o?=
 =?us-ascii?Q?KQ8W5ea02gACsiHXBmmjo7gYgM2dTW64RaMn1aMaV3dvAbaajICN5ZP+VRxR?=
 =?us-ascii?Q?lDgV+vvwCtLfr24bd9ufot/4FLxG14DT/yAVz5lhu5OXJASbQRJhExahTyU7?=
 =?us-ascii?Q?fCxtyr2n6t+HuuDwUJy7wJAzobMPW4TtxZAxxw8xlX0jTzS7sUx+igl95EDb?=
 =?us-ascii?Q?2J/I2U4cetiqHxIAUvz9k9rngs1fs5+brT2tYg5I3aj8VCEXX3pddJggxTsS?=
 =?us-ascii?Q?GdoUtVV5U26G5grNUyBnVRVvELU3kFTvC62xiajIAWVcMoMSlipm6h6vLGDf?=
 =?us-ascii?Q?qRygAc3lbuBDA3OKDZRIi4ylBVkXniNIhjttz5l7u9FFr3QQpdq8Jp4x69lk?=
 =?us-ascii?Q?3xnUvNz65IG9DzsVpddQ0K0zKfbJwXsIFDHcbFNSlBMxK2uiSkxJ6r2yozbr?=
 =?us-ascii?Q?l06xzkjzkxhFwMd7H79lbFgqb0Rw7MnOz9XOIBzgkJs/B6ZzMUyqT1OkYZ0d?=
 =?us-ascii?Q?hM+10xdD4Y1ViLhVBWB/b07aA2OX40V+dCF9YDbscPmCRhiXvLVY4/TC2RJX?=
 =?us-ascii?Q?m8TNPciKC5mjnI54dk3oUdei5ZIY//IyEsRqkbTsf2wah7CBOE7mmBo44aD+?=
 =?us-ascii?Q?U3g0C0WUIjkeDTGec89fVhcbEXRcB/Sm4ecafAOydhX9y3hVhMC0Bq4i5oQo?=
 =?us-ascii?Q?IInPKCo+isj3F0ixdh3OS5cgEyYvUQEJWFua6jLGwgBvLG4o42RVYAgPEMtN?=
 =?us-ascii?Q?G/6IPnB3Aor6YeXQk9e0eE8xjTtwdvyTpcU03eJTIjZzALyPGmI9SgPC8iV1?=
 =?us-ascii?Q?xCYinPAPMBDpO+cZJ0dflyNaXEGJZHbJSpgIsyZZy8IVKtd1B8OD4c2l9nil?=
 =?us-ascii?Q?qOlcZKIOCZWSmiQZksJZoBuMhlKuqwG9XDe9Z04x0KKH7wvWQxetDnsL9hI5?=
 =?us-ascii?Q?nj5CRCHcP8TkXT1LCgmRGvr9DB3sx5cnTP3tZIP2Q8vPQ9cLLopKR+bHUiAk?=
 =?us-ascii?Q?TuEN7LXlGZB634bFMilreN9C5TKqhqMoxOvdfHJXz13ReQBr1MqGH6Kx7l/D?=
 =?us-ascii?Q?lliYl/pmzF4mZzFb6H0JIAQH81DauW/zPT6UhHL93RpKu1Bn2EVwYPCmjTtU?=
 =?us-ascii?Q?qn7TGcqx8AM17QzNV3mAwGdDxOjiPBHPEtdH9EucWvvDU/M69yaabm5Tj2hO?=
 =?us-ascii?Q?tO1rfBnScIB3qUE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+D/9EfW1gkxUNiB2Bks1+fK+snWACP1vdeZQACLWr8MdPLek7BjPBZPR7JOB?=
 =?us-ascii?Q?2pcL8zg591662FOilNZ4pc+cAFx8IdbnH0Y3eKZiX4IVZD4s8OMgpDUWsQaG?=
 =?us-ascii?Q?nXoZ3d87D9ho5C+u0uLXn2ErsxUgllCZlLamhzWESWx1+wdmg4kvL7HR1JAc?=
 =?us-ascii?Q?PkuSvAAgZvjdzCia9wnkh/qBh4tuQxM+A0WO8cnLJEtvgUzHzGb6PAMhpGRd?=
 =?us-ascii?Q?Pe0094ceOAY0WBslOugjl+YjdzsKVFjD0ykkczdhcnSPg9/qpVTn7qeM8ZuZ?=
 =?us-ascii?Q?LpcK72UhlAbsme/t72N0CsOhajYWOzgx25/4CRrOEtY3ZdGARQlCDxpDUKiG?=
 =?us-ascii?Q?9/sqeVAWKPHL8gAhOIZRim8dR5aSe8A5uF8EFnSCINwOcJTS1pOrzgsRVk/5?=
 =?us-ascii?Q?tRLk8Rdlk6D4hFJrmabjKrbZ17VqEWA7h9B9Uag7nr5I5qrvHyVrHnhhCBdr?=
 =?us-ascii?Q?k0j3D7s6d6gbf0YIdEsLYEhVH0JMl4Gos4bQV/UCzV/LvhKh3GZGoxfuKTq7?=
 =?us-ascii?Q?gX0hmWhAcfmaInM0TADvwZslgKHUWf+HWrzqtCOU5XJ0Yg2rXNRv3FSsxpqd?=
 =?us-ascii?Q?bDNsuqWS7gzkhLv/FJRfhNPQJtfK0irXJKHQ2wb6fvwnoyry23Q9i1bS8YHZ?=
 =?us-ascii?Q?AeVNbllrAbi3dRJm9IUYBNYiCXsL7Ws0keGuKT1iPPvBml6OxBWexvgGqWB+?=
 =?us-ascii?Q?EY3BPuUoWnwK+dOaABbQpAkdRfa/30ZpwtPk2tWyPoleT6g5X189AfliYNYl?=
 =?us-ascii?Q?cWMdSD8v3wPkijD0DBR4SaGO9j/ThqxplcGF0HVZxDwtpHwTidZTWLXZV8ps?=
 =?us-ascii?Q?9ZN2qYPDDKb0H2rLrLOwsDUVMAqVCZNkJHu+dGDtjZD5jH4Xqi6rxwohQ9Ic?=
 =?us-ascii?Q?k4ivjMKrnt95X0Q3xdgRxnFBGC9vKJZ75K/2JeZEGp7Cc1+GEnuBwUHNyyts?=
 =?us-ascii?Q?LN5Zq7dGFs17VgeTq6ckqIeH8FshGvzA33s3njK2Vq6jxe6Sbxv9VL0ZexJW?=
 =?us-ascii?Q?6TMArOIk4GCzIUXvyOH0jWxrD4vnzQH9yCZm1jVC8fF5h/LUZiiRoLFRMa83?=
 =?us-ascii?Q?XSro/JDPUx6Mn5JmS769JMo+oiMlQNFI2kNvRbMOie7WEmTYTkaslGRmSMUS?=
 =?us-ascii?Q?/cqsMkyQjduJrfcoAp98NbfazryjOBiRkYtB4mfqTVD2KWY1SeCLzZSOfStE?=
 =?us-ascii?Q?bjXDZtSsSbf0DH0MuwtrRsxgD/tgIo+WpEfl/+OtCusYvRjViJPcAEq1xT1p?=
 =?us-ascii?Q?snP+zBnFBOMSuK4c0pVvwHS4VKDzBiIldyUxVI2zI13XgEa/M3fOdryKzWRg?=
 =?us-ascii?Q?RKiiqhc2AL89RHvXfJ0YSFz5gStuoE/emoNGHA8K24fNcamQhT6bsfE9Vevb?=
 =?us-ascii?Q?+hDIJnNMGf/zMwaRiIK92VUHaLSsvqesIZoySGON3i1T8973xV+2T9m0ncq9?=
 =?us-ascii?Q?5lDe0P7PffO1sx5eVGyB/XaahyhC0De7Jb1kPUo6/XlLfofIzyEXQpbHgFUl?=
 =?us-ascii?Q?xOZsMVK8hLte/kE4Dd5tjs1K+eMXB+HPW0XXIydEsXB/MsJHqDd2A/UUPObe?=
 =?us-ascii?Q?ShYlQFLaPQkqed2Ncimrl6VsG3214NS4awnKrdZ9EH33NBlyL6n8Fr3pdWoY?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a163fe0d-5ca8-4fab-6ae5-08ddd3a3e1a5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:37.7093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD5a2DZv0i2PtMXNu6wH29W6i14y1nmdNCMJvTdlidD3XVVtppSQVdyU6mjqAlLroao8s36Yl0Z6Ot75VCZc52M0aqUcVEP8zJvKkmWJmUU=
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 34e5ac33c63..f99568050fb 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 struct spinand_plat {
@@ -362,21 +363,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -418,7 +427,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -466,7 +478,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -498,9 +513,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -702,7 +720,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 163269313f6..ba6c2ba149d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.47.2

