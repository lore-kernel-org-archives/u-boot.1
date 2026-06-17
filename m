Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CB0CD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7065B84895;
	Wed, 17 Jun 2026 07:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wWoVfxhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8549984895; Wed, 17 Jun 2026 07:30:02 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9030584894
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfr6crthcs/U5JNxAQGlUsMbHZB7OEGU10wCFLb//F+FVygwranDykMFqLPuu7roYBwYMvjl3MAdr3Fik4yxa0j27Nr0qQrGE527qSozogam8E/8NVJKgmAUCCjCUKgtKXI+Yqqc6Q9OFXZCm1hC8JsX8uwkFtRrtMQy9yJ2T4uIACW20tqyXkKJM3lDKi9drfDKUiGI8A86J4QvkzS9yQscyM1EiEu7kX2pQHHIp4LcUWNaiUbjp4hh2YIyPh8++5gPFCNSHKCKmFdTrxDvV5Rbb3wTFabFWcKPmICzJ+JhmDozec98UBUbtMPDrIsfX9zWrn3Id01OYDYC5/jwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=cDdHCtrpYeFFFojRP5kqrq10gwDHl0neCyCI3FTNtsEclFB0wiS//GgDxH8xH8Vo9sqOCfi7bMTbRUuAVBA6xAKxr2Mcnq403kNQhHbHoJ+RJ1SmnaEMHye5bam3RAErNw6MKP+bcF48Hb1oYZX1naTA+VzArVgTPCXNcmfFA7/b0IQ0ZqX745L4732MB/YtLY3lJOQ8hkn0NQ6/IH74+IdN09Bnp0f3AIxujEQHD6XCuJhYVWUQwf1WRcl1M0jJPfjFHfulfXCjvin9aeg3nZE7DFR89/57uwqIyZinTdcn+ZUopLnROLzSgMfM9gFE5NLKYufdLOjc1HImB4nGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=wWoVfxhvSli0l6etsBBeHqavDhFJEkLtifQGvBSWRuEzpNLyzb2vYojh0HTNZYmFzJ1/d2y5Wjs5KLAPF2peu0aHSUR4eZvv7jyUFvztcmiu65aIhszauUfOPAyV1KchXPyKihg+RNQzY8x9mcbFNDyRUmWQcNHW53hauJjVVW/Te8DXnB+pd2MzEv+n2VBZsbrHlc/bSowzJrXqq1IuzBLhpekKjxvo01DDG1ak0ee/m79iicm9floliETV4nLwYMlJVzpht1lkM3sSUVtOLpXL8kCyebjhNoPK3Tbcr6hiKrCqAA5KSHP8W0LgxAeg452SJPImy4Ev8DEABbDNxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB9653.eurprd08.prod.outlook.com (2603:10a6:10:449::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 05:29:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:29:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v13 01/12] bitops: import BITS_PER_TYPE() macro from linux
Date: Wed, 17 Jun 2026 08:29:37 +0300
Message-ID: <20260617052948.2815870-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b6a0f5-d4ca-4e1b-f752-08decc3178bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7416014|23010399003|921020|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: WY5ugPDhGXrI9+aScMP935rzeA0oL8oaj8ffdQd+C75vyQlALvnJY4ZwpejABfjFHCtb06cQLbiRGXmeApg/MLm6WpADzBJxGlKcw62kjX9TrtZx25RiocjEyoiNTk8JNKjKHr4RyTsw/K1DnSFMh6rnp7Ydt7CDc8sS5F/0vU0K7Ia48boyyu3nCvXy/rdwRB0WO0ssVnamcMS0yPTFEXUMaZzGaGDJgG6KE0cTanm1TTT1a0p1qQJjnZWaRRFsaxMNmuVY+AFk0+wPRhwEbc8n8BuMTuHpTMWaZYGuDub5l+hNbYscuR07BEvD0HaFfhy0JHeutEqiAdOc1Ab6Ww8e7hL4S3b3iuehRuPQa0G23gfxwKvg1WPdg9ec37MVGfe2pOl9W35J+cxj4qG/aOt8IlSsIhKMTI8RzLXOjsf7kFdWn0ymitRUheluBuDDvOMM6acgXb+E6NPTEYPbwgUjYIemDTfMxv9PGWms0C1yeGNZwPxomqSvBb7Ghxd3nCZ2+bbtGz++WNYzwDtVsjLZBLXUItZsRiBxLjjBGJblLblFEVYQXYcwNxJ6quR+RpiTLKxVcEt3EoMy1zY/IdoVFdk2/LVU1jc3fBXd7KOOzpR+M7NUzImWIlUU0GXnJRIAZBHxa1czfZsf9ZdDMOhzoUGOL6wGA82o5VjgJt8qFGvhxxm5NtIZL/XyaDiXJ3K8f9n4LziOwNKycrF7xGHZjq8AI+tSHge3J+Iuq8UTldQc+l7UILKC3ErfVkn5EZ2SwEtFsw/Lgni3ESCIdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7416014)(23010399003)(921020)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jT+FRlZc7y60KeILw/IrYnhRfXQL2b/bXE9NEgkDk05yVqRR4axTacJZJJm?=
 =?us-ascii?Q?3GXBrnEi9RNNtNpq/myiL3xWQqk34NfHRZnpQVGTNWCUKwRWfwm/UeMxh8HG?=
 =?us-ascii?Q?l5W2HFO2gb7v/CPX8FXXbVjgaXLuRfui/qQVBmfvF+Mj15Y0I/LsMpFsAUoi?=
 =?us-ascii?Q?Gq4crgSS97VaRBRv29xDZJwrsHS8TW+HXXATJY+kuZB0xFK0ge1ukghaGps0?=
 =?us-ascii?Q?/Nj/7RAK/yuHkxiFQ9QLrDnFiMo/QOnULmKIjNbN9Sh8NXmwzQc/17j06nlX?=
 =?us-ascii?Q?YAvQ6DXlX4ROlzE262QWUuUFXTi592CsHLRqRbn43gfVNHWznDB/3s6HVo9e?=
 =?us-ascii?Q?9vtHPaxOjYCdqCJ4duYSOOZU2ZTfz9F4pJkuVj13didOL5hQp4OqfjOpR3fL?=
 =?us-ascii?Q?SXfhImn4xakgqLG2IFe3/1shCgJqmEVw+pkPT2gluU/zJEgc67tfHYVHuzkB?=
 =?us-ascii?Q?NhZx8h9ZXYGR/ih+yAMgwgSEh4Eg2v1Eabk+xLL9j3JpG+o935hkNMAzPWGQ?=
 =?us-ascii?Q?Lny7OYpse76ujAchzcmfMajCQFlubRddb+baUeAV9TAexTkignmw58eSSg/B?=
 =?us-ascii?Q?bLMu8v7twwMagG7zevS2deK6AFk5rJHxtxm9qenvMlaOqp4E0Gyw3YUaWTb9?=
 =?us-ascii?Q?g8jeRIMKLmyEvo3qeKn2LjGJtZF5nVBDZN/BVD8g2+aI4wIoZZInSEGF62tw?=
 =?us-ascii?Q?OpYeuBfmYN1Yu+UrLN814YyK7S1OIrVhk0CryAaC9XiuByZHMPa/tOZvVP6n?=
 =?us-ascii?Q?vB4mf5LS326AhYMVud1qBuGxJxQHt7RvUH7wrtOGM7hg87xYAcaTlHgAAqYB?=
 =?us-ascii?Q?z98RioPthbfQZfHT40CsnZUYUAkpJmGh0gdD4Zii9A3o16YuuSpB+M8Rm7Kb?=
 =?us-ascii?Q?x8fZhAwFny94fbn/o5cefXakR/rsNU2QNfHA4tlDUfP7XY1RmdG24qWRN57+?=
 =?us-ascii?Q?NHLxO+NjoDjUZp7NRTsSIShkp5RgEIdchN9Dpit7C5mNDzcmadm3S8LFa28M?=
 =?us-ascii?Q?6bSQJNNO51GrhO246WnmsOVO6vkg3qHe20KsgPsWOj1PSRK0sEdSGyoYfFGb?=
 =?us-ascii?Q?4FuQq6Uru50JHoIUh01pRDbQ+OjW42iCLrLVurl6i70MbLVkVx1fHnP/yn2E?=
 =?us-ascii?Q?vH6JEB+5OzUIZ8dl8GvnNAwnCy8xsVQtFlt6siMniK3JOqnugHHOsisQQJCn?=
 =?us-ascii?Q?exfBlDwtH0eXl+A7apRt0KJ8bXt02uSEYQMjXpcSOPxfc3df7UHGZVh0gmX9?=
 =?us-ascii?Q?MbBwkIxCgMYjp158xORoE+t2N7ya5uSEjSIxB6g85kpAlYhWBEPPWyzri7Oe?=
 =?us-ascii?Q?ZwlkZkL8pIFYBrmEf0Xu7Gu4eLY5q2Cgkfdz1oG1Dpy1qbimisP2+BSVxIOb?=
 =?us-ascii?Q?CjBOJ8YfCU/8k5XBZBOTCxe4n7jXYX56AqaQYQ8uV4gN6cOzoeM5+7cnoNcd?=
 =?us-ascii?Q?mIJvHnCzy6AvSeIKxDE9vXfsfMHMn7nuzn4o6uirsJ+AFjzKqhzU1aLV5fR8?=
 =?us-ascii?Q?HkROH5oxHXK67d8IZxGkEL0n7A7Mcxtc2U+EpJJakzplR7Y3/IE6otP1kN6c?=
 =?us-ascii?Q?+VWPuveIRz1bLScqXQOVOwzWNS6MF18s5KmQ30JaoNUouXy/HJJPS3kcEoQm?=
 =?us-ascii?Q?nsx15O9UKWVhswlro/Ib7kPExQgZ22IL822pumhl2ujqEFRBGb8xZNmnyXDH?=
 =?us-ascii?Q?nyMPudo2izAVmDrVvPEIaLqmd8joGvlI6f33Z4dFWhk+OSab6vbp79WayPWk?=
 =?us-ascii?Q?m0LPg9OVhM3v0ponF65u8Wst9E4tbhk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b6a0f5-d4ca-4e1b-f752-08decc3178bc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:29:58.7297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25UbBb+2YpXV0z7TrmPFG+00DTdUym3FAn0NU27tgz5YwieAJG8tfyFKVuPjuv0cq27ndVOCuzRvwu1+Yo2CQgAclryGt/CI6T0SmJUXYfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9653
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

