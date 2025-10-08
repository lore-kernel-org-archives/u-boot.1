Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83017CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48EC2839B5;
	Wed,  8 Oct 2025 09:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sgraZOn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E701583981; Wed,  8 Oct 2025 09:09:17 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB4E83942
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQtoK9JqO/aAsbXiZBm6iB8d3ZnCRLja2gRusdrDKcrXboHDvtk0gfTlQ96sWc1F+o/q09tMAn/LqOeUzVW6gqp5RJY9S3Oban6AE6iHAZDYkfpGirL6zWpVu5p/pY9JMWNBUSbF6lHbqZtBTMK3EXq7s6FWyeD6sED8MMnNDeB8bDz8dsmeK4wxJiOOyVYaDQIGCFqEDfpO52+CVLqLY9+UpU2qMqCWCWYF2nrJGS8QPgnvbt8vAecakl9qnjZC1XJTrVIfAZbeciLRsqyQD2Zl532EzR6t1+rKEj39XVABlfA7jXLlRP+euW15B8JgY7S6VwP7m2FPNA7qvUNxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU7qhg+vo/w0sWxBxLhE4SjpAHBw4zYXo17XFZlZWFo=;
 b=nT8QrQFs06rfS+xPq76JAq1r3ry34dQ4boshPh6CivBFwoXn/ZwbD1U9DiKbl7pFW/OJPcNcQOypPY80iAvTfE92A18EGJyAYuBpvCz8FSBSNFgNyfPJfbUYs2Kim8X3jCeCX67ZiUgNl307bQyTB1cL4IktnEZTiIjAYRMfC9Y5QM0dmYiNO8xYvCbffq7FdgmKII64h+UJDcG2nZhz+tqVAeCzkqNfkcd5+h9/GO8LxhZYP2JciONnflfNPYdBpEwnVo3iGhtZbtl+1a44cSdmrZqIOqEjNqG6JqFazRcXor4LIGp5u2RteO741McRlvCF8H+zcLdFoRwICrtiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU7qhg+vo/w0sWxBxLhE4SjpAHBw4zYXo17XFZlZWFo=;
 b=sgraZOn5CzCO8/yfdbW+pPMwHOH/qJelcXCC4NYKCAuHBPha7BaVSLDVELsnHFmDn7PwojWbZyR+uSJ0vfSnw0/7KHhq6MDG/XUuVX3o5iH6j8Rtmdc1n+bAL7GgxG5yLVSFNlr7kcR+7DkmnCqDvksdmL/nvz8+/Zuu8tfiREaRwSWXMRPSR7h/KQH4XQGhENEHUeXS4G3UzmzxH+NRmTLYa1biLEpSwKb3KMP7maCZz7QojTuwIowjxIwCvvQs1hwH4i085ydIJeI6zmJqMF1WbDN3wfCvzQDIsdZpGlt5P63j9zkiEMUjdUraumJr82ZOAGcaelYHCs1OFw9/yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7638.eurprd08.prod.outlook.com (2603:10a6:10:31f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:09:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:09:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 0/2] fix an7581 panic caused by attempt to support multiple
 RAM size
Date: Wed,  8 Oct 2025 10:09:01 +0300
Message-ID: <20251008070903.370974-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BC0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 500a4046-ffd9-493e-6cd7-08de0639950a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6fbmdLjRDhWG0ZXIqhPIuEO0Ts6YDFybQypg0OUWcLU5JZY58KdQsKq7k+1P?=
 =?us-ascii?Q?FkwkLzQCDH0dOnqEVCkZ/Cu1zXC9HL3BFaydNYnfRudFsAUcSFKOCcnbweUQ?=
 =?us-ascii?Q?Rgjp7fIywKHWwgsCTznc7t0u7wXy3Ztjkl7eECyrIeXHR2WQTk5TYL760Y55?=
 =?us-ascii?Q?5hFJpfGBrO7vwK4UBIfpPR0gcaj/ECrMsHRzQtrfV2dtdGrqltEJTK7Pq7bl?=
 =?us-ascii?Q?FfXVkU054XgwqxYHr6EeCeC66/NXduMhFnRkly2qhUN9hX1NSMB4fp89pHyD?=
 =?us-ascii?Q?tr/YBIuqCXW02mjJIC20zxHj7NAFXkX29gucT5zGsjAQ5DPEf+a9/Hcz2bKl?=
 =?us-ascii?Q?GSrsxNZMDAQRoNnKpJfPPRpOceouEt/ZN28A7geo6nwr9bgUe2c+JfGkIcm3?=
 =?us-ascii?Q?+S9J+AQ45vbj0XluEXw4QE/mzePXx2J63WIEHih+/IgUDLReYPLtZN4exToU?=
 =?us-ascii?Q?1sAW7nMe0unf5A7GRb5R+un9l+Wq1OR9SSgHXYYhepN0FQayybiRSgcMb58a?=
 =?us-ascii?Q?36VOlHRq6fI72waWvJm1SCgYc1JmOxQimRYjBMQPRENhwFPZWMKrfzc8OXwS?=
 =?us-ascii?Q?1EFry5TrK0WyXexgJqxwJZyqsvdZeCaaLbnyzQvDSzN7VczAQsgDpH2/biug?=
 =?us-ascii?Q?CAcRnC4iG32PR5c7+OarbOOb3BEA9Ep+NData/SX0wERkMLjcGWujAOjxrPb?=
 =?us-ascii?Q?qgSUQCSmwSSP93jvVMOIYkBdz1hCzVbIOHtTB5Yz/BBvxf7vZvqMC5MqZCuc?=
 =?us-ascii?Q?FJYjRI/gko3zsIaAdhzNM/7QSys2uwR8vKmM86Q5HEHwREObyyVnL6KV2QV1?=
 =?us-ascii?Q?BF4db+6wOBEaA6H8FfUCNyW4s6N9Gvpyb1dFFl66pEQWbvISdLUvfaOxk212?=
 =?us-ascii?Q?y/K5yYwdnZ5r52NcqfQyLNzoNh5OVD1XrR6fODUU7rXDdtV8AZ6NQUrVCBby?=
 =?us-ascii?Q?hDiUq2IIEsXxiy0BDCUEYIdSZlncVc8BKrGUg0KkrYP58kAARbLdemUUUFK0?=
 =?us-ascii?Q?R4Rwq9ce/n4UcyUo7bc+0kABLlU5icFFUrLpa8zWCmkDKCcOOiXVYy2XvKNO?=
 =?us-ascii?Q?CqjFAN+9SLA+tqNz/0GzpgJUIh2paq0s1V17JTk0USlka/O2Fh6Q5WRzqpGy?=
 =?us-ascii?Q?Gv7HZflBb84k5Va/H0U9WOK5VnMfjntmbQKEtaOU5jJlxiz5805QQQdaYh8t?=
 =?us-ascii?Q?z8OBo2oVZun8EUEh+84CpI2j4qXiBLgkNz2tSRxHYWZl1xeNTTq4Fg8LMDLA?=
 =?us-ascii?Q?DIATWBo4q4aPQYRnj71Ond2gdEPhmZ+BEalpPlyJxgc1dS3YvpWcjGzCIDr9?=
 =?us-ascii?Q?FPdcflIptJdFrZC5vPmepGpbi/14GF78LDk7stOVVSeg44Y+KRMvH7H0EVqe?=
 =?us-ascii?Q?LC6Lewybsy+/xy7GUuwGt0eCe4tHZUFoSmWKRzNDLdbDk0eu6OTJLzoH43XO?=
 =?us-ascii?Q?m/OjRotyCMd0n2hBvMOlEl6uXd+p0cMC+eSpcTUChP0XwKV007uhcj0AAKF4?=
 =?us-ascii?Q?bSmmp1Tn764g2oPihyXZX02npIVvb/P0k+OZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qL0eNeN4j5CWKg7aW5AdPbndf/zim0GZbk2KCXrBfU+Xiaffq5LxJEYATZ2r?=
 =?us-ascii?Q?oGPv950PY5fnOEBnWCW9tjYYMT7T9cgEBsL1A+nyTt5qFshI6a/hYvm95WiH?=
 =?us-ascii?Q?HlC+HmjTNzZQ9n2tw2q8TvHa2i2PO4VnUlrTUar5skwSCIiJVu3ueUc9Cyuf?=
 =?us-ascii?Q?ta4Gz7h5PpooUJ26xLYcCvnqBExdVbTaE4zrndpkIQ7J9XczPP3M+l1DGUvZ?=
 =?us-ascii?Q?tJC8kPD6NQMTRS2W79MedU5/Z6ryEGuV5sFrVnka/xMum4Rq2zJIwZ+01vZt?=
 =?us-ascii?Q?8RzSjZWSzqeBuuMGD+GqlXJvlS7QH7kerhp7ZPAgdROlgvFV+vZ8X+p3Mljq?=
 =?us-ascii?Q?E1OiS/hN9K09Sd18iweKtyb7zTtG2+RolyCnIrhtXQ8JIiAhAfqO34mcAo63?=
 =?us-ascii?Q?AUPms7OVBJUoDyoOCHuRV+D9g+kf6xM75+3BSqHtV13JcjTei+zmKBVX96Nj?=
 =?us-ascii?Q?BMRkKSzwrJ9sWcknICXdX8zWPC6bOeDvc6/1+WzfW0uQ2qr4r8PrE2CMOd+f?=
 =?us-ascii?Q?oKbt1Uvfxor6w540dQOrYEvdLmALuvjM3VLLofc+dxUXc+sz5GVGmQm7pfAR?=
 =?us-ascii?Q?EhoUBvzW7Q+1Jq9Z4i9HmxtPyCIElF0kF8YcuGxIrXuukE1L3UTtKJnc7m2X?=
 =?us-ascii?Q?Qkm+qDL1R5j1kCDap2M0PMxYIGUMy8v7yU/b8hYoeTqNfALFPeIHu0qqFT5f?=
 =?us-ascii?Q?YN0e5cnkhk9KY2Zv5Tg2+GDXScYA3TcEs9RxaqstBW9NlLG2IAtjXB9PFW+k?=
 =?us-ascii?Q?nMuu6HjzA5Io5eG2HjIKpv4K6HLPKJoK1DM49XJ1lmWds8N5ZaaW8KjOzJWs?=
 =?us-ascii?Q?s6kzmfztHQhwfKG7P4EWOe7f3q8laEwP9qr6xNUayIbdfHshf0WWKCeUwdp0?=
 =?us-ascii?Q?ymab38it9EUuL9Gq21d+E/OEm9HKgKS+L12OXjFq//H5uehEeDPRIMAnJCOH?=
 =?us-ascii?Q?2v0ZzzYbJ7zI42lyEBNt0gZq2FGzb+Yp6vPYzMMtC1d1+3WczwTpmYBnTgLk?=
 =?us-ascii?Q?rM6XxNfAtYNYZKAoDTOhEuTORlxUoTz/s8a5C0nOQpi0Ixh9ab0cB8UQU55M?=
 =?us-ascii?Q?zEzBuLCebFlDP6kLRZ77xn49zFkW05+nxGf81W5jSThR3UDxHDVhTJeogT2l?=
 =?us-ascii?Q?ayIwojH8tUcTy/Zd/Bra1Y5bDY6QYgICp6yF/Q9/9fmlqIduLcQov+h4mW28?=
 =?us-ascii?Q?1gGZSjkAadi+iLxhUxK93x6zSOGo4frjAC19CdSshXnKBWHUXxifHEzCJ+zR?=
 =?us-ascii?Q?Litf8a2V9Q3zL8dDrp69dH4FT+FIcpvz13YaVHNW53gOeuDOCaHRKI+FbtD/?=
 =?us-ascii?Q?iYuZZH+Cnn6dB0TvEFdfyOzCJE91oyU918Vv1FdE81RSXZqnrpwiuGJINyd1?=
 =?us-ascii?Q?iNp1Y7hIEhCRpq68994h1C0bACl5qbL1afIETTCtPW5JiMreJlTxZE2+6ObY?=
 =?us-ascii?Q?BLF2WdsX0/vjXdcZnqHehRO/nkhD9cd4HqpddCkwiBZN7U10at09AhxTtem3?=
 =?us-ascii?Q?0BwvpPJACGpTLtBovwzmmqYqDKEoARmFH6I6vPbPYCLKdmMEa02ykXFJu0G2?=
 =?us-ascii?Q?gLCZ9WaTmVF3Ndwg/631YlkURZyD0fc9RX9sHLyirPKu8agUtvytwT/NPvcG?=
 =?us-ascii?Q?IZHujX/HoGxrU2eq97nrrh0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 500a4046-ffd9-493e-6cd7-08de0639950a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:09:11.9851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vQmSmDjcr4SB+T7F9OKUn4SZAF4xBmR10FosI3ypMessfxnxq9Xe3a06gifPVBcCjbr5H80oZZ1N+XuDAuX3hfrJp94WfzXbpj6WefOCaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7638
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

The commit 726404a66c773 ("airoha: rework RAM size handling to support
multiple RAM size") is not good enougth. It results in pacnic during
determining of memory size amount.

This patch series partly fix and partly revert the above commit.
Unfortunately for now we have no a good way to determine the an7581
memory size.

Mikhail Kshevetskiy (2):
  arm/airoha: an7581 ignores CFG_MAX_MEM_MAPPED value
  arm/airoha: partly revert support of multiple RAM size for an7581

 arch/arm/mach-airoha/an7581/init.c | 12 +-----------
 include/configs/an7581.h           |  1 +
 2 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.51.0

