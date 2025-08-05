Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C770C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63D3830B4;
	Tue,  5 Aug 2025 10:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qmEKuFVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C51833D0; Tue,  5 Aug 2025 10:15:27 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F7882D32
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Izb2+B+F8q1+LHpHRucd/8GgRrxNBA1Ox2m4BjdMNq4PXalznRfPgofm+h2VT5kMp+wx5/DYS6V7bHMf1ZQKPA8Uz2aHK1Ko48ho3Flyfntb7kYQQrvhyWY6tsJ26K89LB5VlNw6eXglnIcKwKuwwG7eoNwAzvnYxrVa09oJB/z7gpbHhbk+6DiCFZGGTcYonPpdR+8zd9Pw8k18WYVYOG0fX6ruvT74NjTRNg6J9KellMhcQZRkIzH00riKrguqwfROygT47mPG4WROmUyQillOkJWvOntMIQXYfOuUrFW6wZ/uGj2yD4SQSBM5j1wlfMD/LHxqIQV4nxk6CajLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWnXAaCc7oNAOdo4769RwHIZe2CwSbQ15+t4pVu2xQM=;
 b=NBk0AaoWSY2hWyH+sTqAfSGpcJOk+bpDC04P/TAtnCG6BALiXVNFoqwOdaVysQBYr6Hlf5KbKtoWWrYf4pF8DLOIJct5Fad6aVkojL+Q+3b1B/6zk8J3GVsx+/bm3KDhGsK7CXiwMDCA1eufMyEiU7zRQvUZtPkakVva3Z6PHvRuqTsgvUh33zxhOAnG0Ns2fj40X4DyPwQduUuIybcfLorIj+9wDNt5YhzuuIGj3IQVfn83QjzQj3tAmTtntIrYXLwLUtqxKJ2IqTF7YLLZq0bcq65pnegnU0GpGHYyTtSe3gGdBnkwLVFXNsSD4cyW8X18GZjjyp1QANZjajiE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWnXAaCc7oNAOdo4769RwHIZe2CwSbQ15+t4pVu2xQM=;
 b=qmEKuFVDa8Dr9wkU7iis/BfgbjVVMFIUZ1J10fsZNbly0J3EK0o6Emb50FIpI36XN24WV+rQaGHSrs0r/VL2I5xHrrPzQiZuKEIIh2nOzBTzeHP7OqFI3oSg6I7eyIkqK7iNS8DROZjCGdeW4DS6Afc9MQqxLfH69DqXXGBABzzYeAxE7buX1UJmoRUm+S7g9kxvxjybOULQ6eTlIfvnigoC+e68zy+eLky7O6VfcNZ1nvXgM0Ipn1g+msjH1ZWu/AO85xxuD9YzguD8eIyO8AG3japdABYwx6+z5HmuX0lsDRVNVObc6OtMVodfU3lKQ5EJcipVJDWnPEmtHMFSQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB11074.eurprd08.prod.outlook.com (2603:10a6:150:1ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 08:15:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:19 +0000
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
Subject: [PATCH v3 00/22] mtd: spi-nand: driver improvements
Date: Tue,  5 Aug 2025 11:14:49 +0300
Message-ID: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB11074:EE_
X-MS-Office365-Filtering-Correlation-Id: 7313742c-c5fd-4206-7ecf-08ddd3f83766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yvqcMQYHvhK6zJBHHwLwCNcxcwtQmE3bbsbxpcHk0AbdUQusaVfXI3CClKTy?=
 =?us-ascii?Q?GNAz5FOfrX98um80P3LfgD7d+BOIZYSAzD9D2qiAAfiP8jFqJg667uufe5Jx?=
 =?us-ascii?Q?WSMBeyKrxBm0OwW31kLy7uPXvIYb8qDbnTP28deu43ayYr1cbmMuOjPsloFC?=
 =?us-ascii?Q?wCElE/lXn8MMpOdQoM55Fpec+Vc8/BNT9WewJzMrlXY4NgMIogNFZodj9Rxq?=
 =?us-ascii?Q?fLMzfwdd6yPZ9oY1MQapr50bDE0Yx/09Iih8YhXDwVUKijBKVEg9U0oE/8lF?=
 =?us-ascii?Q?4khTCPASDrXzi0xWFuggh21PBpty5cLywfpCsC4G9cUyxva8r7Zq5MZ12jL4?=
 =?us-ascii?Q?XPZu8NVoCIKHFOmRo1Lcw9Y7YzKbKr8fHUcO86cpPN55hd+Jpu/IUGG8Hnai?=
 =?us-ascii?Q?AJJ+5iNGKUITA9Bu4SZkiedm+sBBOn71GId/uBRXdzdfnCnaR1+wnQEoHvkr?=
 =?us-ascii?Q?YZb2I0jclTyyx9VrzeVBdPTsIy69jnA69xEElxB8sqVvkdQg1Zo+z97yKIDA?=
 =?us-ascii?Q?94RjiIpI7H5J1v1qc7jUn+RqFCpao3TAAxXHwC2ZTglNNCE5lvWYLBXNMkJE?=
 =?us-ascii?Q?COEb89IacosC0+rJNsUljEZNArLh5MeypnO5j7o02mzn0YBVVt70RYQ47FR5?=
 =?us-ascii?Q?BF6Y3RSVcLFn+3f2bbaYYI6EkG2GcSLcSr2MiXpfJKqGjnRbtuG1QuY5gSYi?=
 =?us-ascii?Q?TLtAaocax3olM7/tKgcl3n9/OyGLjhsaWoW+VUmynGDP/RN5ajp4F86IIKKU?=
 =?us-ascii?Q?ZrJzGTgQh/0EBoDu7Ja2hx+m2wP0SJ4TAblbEp9BL6bf2idU7K+c9Iu/p/HZ?=
 =?us-ascii?Q?GpnVLl9gD8XwZxr99bul6fVfB/OBvB0r+YNJ5BejbHwbaOv4b9egeSCMaTjC?=
 =?us-ascii?Q?t8+jhHSATJhyNsNIZEjDqShELRSrZLgOzGc9zdettXHdTl1N+HVGLTHGdvk+?=
 =?us-ascii?Q?xZ7JZ2LgpFbi/ZV7uYwzVi5rmLvbEGHmeLOvP0y/v/9tedKzSCy55qXC5Ksi?=
 =?us-ascii?Q?WJrBg/rUqgx0zGMdKCvgGUav1X5p15W/RRxVDV40+YmuMvIbYF8nGNQkbEbE?=
 =?us-ascii?Q?EfWg1Ia0IjB6kDBuD2e3hcnyU68mb5cbF+mhmb/jfTIvQhN0HXroKwZ22iGG?=
 =?us-ascii?Q?3qtkAKyUukrfnj27HrUBSYPQgoSQJK23rGpc/TvLoDZSqMTlu+aW0zL0yRRS?=
 =?us-ascii?Q?0KRR4T/b0XQO59NxqvVtDhoimHmHbOS6f3N4tB2oZ+zrp4+uPWWbfHxpf3PD?=
 =?us-ascii?Q?EDQ/cYWRzkl5gOGfACAriT5+eB8qDOpPYNiV5zlGb8z22omwgZm/6elGCrJo?=
 =?us-ascii?Q?+w1KaNBgNRqLxwqIT2u+YRU+FmzFEKn0OLPNmUsA1tCeldT8bizv1YrnK4r9?=
 =?us-ascii?Q?SYDnIAjtJPdeuHTtlG/taU/FcFo0cgeRH1YNq3UtXXn+MwCEbnwqjV8YBywp?=
 =?us-ascii?Q?Lnr9obSZs4W6Sbi487t3vpjdwV6h+nl3i6X08/cTdWXcmlKyWr/0BJvZlZNh?=
 =?us-ascii?Q?Eov59ZBl5sRzUug=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LgyJmqyMse9Et0QPH6QDEfnb8tnv7k0yGvshjQVXupPAgDIdkFCFYMMuRNYy?=
 =?us-ascii?Q?GbW8evQm9q2yPJPl7gZx7GXXnncBO79Jv9br5WOmUWHGt1MWyoakuw1KwTrl?=
 =?us-ascii?Q?dEVc1bQtxSyTk7YARc56j8P9s3w45KB4F4XaQeoGXi7BvX96BLxyi7lR2vjc?=
 =?us-ascii?Q?nBvGtAqfQsjNTYoRH5dtgPT+1lrFl8MHV/oTvFV8c66+soQTK1PjXODaKaNM?=
 =?us-ascii?Q?CesiOJBclES4zATTGaFBQe2rqVvTx3bWc5fm3T/YU4wTZKYtC0xfWbRwVlC4?=
 =?us-ascii?Q?zctHeYkRniRWm3sm8lB9tQYpryvidti0WPFa9S1bnF1MRHO6nU4DHkEaFjM2?=
 =?us-ascii?Q?oZpLUVm5Zeq8ccIxZJGhdq0rergqtpBKeq3FP2n1QILSSRb2txQwRxOFW7dP?=
 =?us-ascii?Q?/TstLIcy9wi02XRe3WyRZGDvZPrZcOeRWhD5m5MuYnzrAVrxY4lbegqwnwo+?=
 =?us-ascii?Q?yylxx5yKhp4m1CjMibIZ/QZ3XFuZy0KY2ASPYYDPH11uPL4ZZ03Zcq3cnbTL?=
 =?us-ascii?Q?P+1q4Adz+WNvKqUNzjq0JjsT5cjW6UUxCx+Yd2LTweGiR8ir2jqfUcMW2CHP?=
 =?us-ascii?Q?/eYdjZOT3jKWquNJP1uIoHnPAuID5oFfu3gg5LnU01nWkTxPThWai1Lv5jFC?=
 =?us-ascii?Q?RFvC277FAgqTBQg8s12cR7BXzdrVUK9uDnk3vBv52tLe960l7DTAz114c8XX?=
 =?us-ascii?Q?8WvXKCyN9DtnZowlXlDuzvczKNliZndTckWe3MEoTRS47t+DtUuBL3aE5aUX?=
 =?us-ascii?Q?v5A/VhHArGBrm6uUx2SZ6MG4D+ftMTnSSfv11H7+okS//OxkBKOFQyOUcfca?=
 =?us-ascii?Q?cg7alqsB/WYPEDYUQwrNavbiYOnH1FpgAsrTtVQtuCPAgv8JqNa7IHETIO5T?=
 =?us-ascii?Q?aMEhUz7oopdYHo9/Of2vsytR6htmS19nWmS3j0LwpSIVQuhaH4MkEk6BvdLz?=
 =?us-ascii?Q?uh9sh6WppNqU/iK4xglitrOrch3WFeSPUaeg81WEM9gazzQPVzTFOscHRbqM?=
 =?us-ascii?Q?T1oD4n16ChAOTBRSSAGyyQ0sOJ7P9y+o4kUfg3ucqWROKHDla8SI+vNe5Rpr?=
 =?us-ascii?Q?xxUj4ZGvRAoUr/nYiOA29fqsEuPnpbXt3654QdOdPNflZiY+QT6/eBA3foHb?=
 =?us-ascii?Q?AtKXjkvkwFQfdKeAXYyi193dEoOxYNYFOT7/lwPJfB53lqFL+WGiSMkgXgmJ?=
 =?us-ascii?Q?w0vQrMvc+49t2ZE84seH51CuTEu+CME/gGol59e3d0cGnRug5nO5sZBj50cL?=
 =?us-ascii?Q?GrNjviImOW95bjAOC47dVYTBR3iCh5veY+DIO+/FFrost2CN+ODvjRI3RJax?=
 =?us-ascii?Q?LIvhXHG6ylbAjb+cbcA1IeDEzkSCmwg+bKi+DIEyAfE2Cp0rgGG97dag+I1C?=
 =?us-ascii?Q?IJkn/+/cxWRHBexp3UmBajksgU3JaSXMzI5d3WPilf548qUoHOpbFN7JaU6W?=
 =?us-ascii?Q?+iiGfK3pYGKiH+YqFvWKMvCWoeJiFhcI0MR6ovtB5mehGvLBD2ozoaJgrV/p?=
 =?us-ascii?Q?rRQ/STNIMJl/Vj/VqjDFLPCk13Y3yh/RBHdjsD5K0l/EaJqv8/4RaWm6N0tI?=
 =?us-ascii?Q?Cck8ktXlew6u6t/ePPsyUkBvtBZEOV9eTji5TZlmKV5vGmgmgHGFYTTde2RE?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7313742c-c5fd-4206-7ecf-08ddd3f83766
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:19.5038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOjAD3JW433gzjrDh6VqcdsHjtKVKYgO4TlGVloEY8hBjPbGhviG+L7xKSnVewGEMKtjUyCH1Cg6fWT/KZ3lbEToJOuqpBQiiRt1LZWFjfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11074
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

This patch series makes u-boot spinand driver almost the same as spinand
driver from linux-6.16-rc6. This provides the following improvements:

* it becomes easy to port changes from linux kernel
* more flash is supported
* spi drivers can accelerate flash reading/writing using spi-mem dirmap API
* continuous reading mode was supported
* OTP support was added
* add support of special data recovery reading (for some flashes)
* bugfixes
* other minor improvements

The following linux kernel driver features was not implemented

* support of different ECC engines
* per operation spi bus frequency

The patchset also includes fixes for continuous reading mode.
The similar patches were sent to upstream linux kernel.

Changes v2:
 * update patch description
 * add fixes for continuous reading mode

Changes v3:
 * fix duplication in patch description
 * add more information about commits ported from linux kernel

Mikhail Kshevetskiy (22):
  spi-mem: sync a bit with linux-6.16-rc6
  mtd: spinand: Use the spi-mem dirmap API
  mtd: spinand: Add a NAND page I/O request type
  mtd: spinand: add missing MODULE_DEVICE_TABLE()
  mtd: spinand: simulate behavior of linux's function spinand_wait()
  mtd: spinand: more use of spinand_to_{something} helpers
  mtd: spinand: replace enable_ecc variable with disable_ecc and update
    corresponding logic
  mtd: spinand: minor refactoring
  mtd: spinand: more refactoring
  mtd: spinand: sync code with linux-6.10
  mtd: spinand: set bitflip_threshold to 75% of ECC strength
  mtd: spinand: Add support for setting plane select bits
  mtd: spinand: Remove write_enable_op() in markbad()
  mtd: spinand: Introduce a way to avoid raw access
  mtd: spinand: add support of continuous reading mode
  mtd: spinand: Add read retry support
  mtd: spinand: add OTP support
  mtd: spinand: Enhance the logic when picking a variant
  mtd: spinand: sync with linux-6.16-rc6
  mtd: spinand: fix direct mapping creation sizes.
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails

 drivers/mtd/nand/spi/Makefile         |   5 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 +++++
 drivers/mtd/nand/spi/ato.c            |  84 +++
 drivers/mtd/nand/spi/core.c           | 937 +++++++++++++++++++-------
 drivers/mtd/nand/spi/esmt.c           | 123 +++-
 drivers/mtd/nand/spi/foresee.c        | 107 +++
 drivers/mtd/nand/spi/gigadevice.c     |  66 +-
 drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
 drivers/mtd/nand/spi/micron.c         | 180 ++++-
 drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
 drivers/mtd/nand/spi/paragon.c        |  20 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 ++++
 drivers/mtd/nand/spi/toshiba.c        |  63 +-
 drivers/mtd/nand/spi/winbond.c        | 228 ++++++-
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 drivers/spi/spi-mem.c                 |  45 +-
 include/linux/mtd/nand.h              | 157 ++++-
 include/linux/mtd/spinand.h           | 342 +++++++++-
 include/spi-mem.h                     |  93 ++-
 19 files changed, 2936 insertions(+), 496 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 create mode 100644 drivers/mtd/nand/spi/otp.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

-- 
2.47.2

