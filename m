Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036FBCAC58E
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 01:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45578340A;
	Fri, 12 Sep 2025 03:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qTsIxllY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0851D83322; Fri, 12 Sep 2025 03:37:04 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1981F833F5
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 03:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqWI5QofzXLBXNL4/hekILjnhMlG6fH3qdqNNxRTPbbw35q1Nh1LBdTtDtuF42mpP3XtYYf1TTbluZeX0NJ5G3fnDVstCtn7T8ReqpOLhoUgheLPNA320/25PpIVfmndebqH6r5G7bLJWwgGOZgkaqh1IzHyPhfQqT8jPgrMyn7b7jfgWzqa6XBOfA+1tTItb1xylYMGf+I0Lzf70dB7SVDprHx0K9GKR8ECvxDCNo+6vxWo/xxgr2uvt7cYTj6B5vGeCZZGXckidu40XdAHHevPFgZHLbRHULrGTjda2jYOQjF8b3p3Da1b2/5sTeARVe56UrBrIAErhi67eTfoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drrSf4GG1G9/0lqfFC75sgWurUt43oAuwu+WPVeAhRA=;
 b=j4SUevE95xqYx9pvAiYKbSVDYEijMU3r0Mu+M3FhB5BmHKYbELOz3gZ1gQw9baXtX/OQsxwWSeYGjEfWzdVhsbRNwPTJFKnm76q7ENpCKBR24mRwczH0khSfHlGjA226T7/WZsan0Xc/jyvAVvqrOeKkEsXQtJTAQ9NsF/hIhSFTAfDpwVAKDXG5+4t6pEY85k9Q4OlllKv2zLe9fwMSdxxLKjWtHZNjQRPH97CSK5vEvJ4Gi/yZPzPrxVT6fWB7VlU4OEOl+SQ+DWfa6xx4GMNz87T9eCNDuI4g1dF1tRm7jK/Ni1DcFWIJnJGmPRE2aFT3rexZzL3d1vt2ZxQngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drrSf4GG1G9/0lqfFC75sgWurUt43oAuwu+WPVeAhRA=;
 b=qTsIxllYcad3SHfvfLueIufcTwYURPJlnA/QRA/4tbvekuptyRjXxhveWfYJYnE3ugxp3/HV2W8zUVNgn8GSInT2kYWESiOG4mykND1nV/HYnmJkugsek+u/oT1vSVpWSFLMxe4a7Uz0x2z7+OW3+9kw1IcywI75Yt1nvvmSjKUtRLJ+Bhs+VB1dBLQDErYDlR0b9NZn+lwizTwMx6i+5koyDvNcPFVXU7jLu7Gg4Om6QD2X7P0IxtYBQCsk0guvS0sHhZgh83kogcIKTaW/COchVxJ0aUSYUEWTIMf7NpVPMxpAlv4K4sDUhvLv9Yqh6O8nqRUVfhiCtELgVoEb7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11627.eurprd08.prod.outlook.com (2603:10a6:800:30c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 01:37:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 01:36:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 3/3] cmd: mtd: add nand_read_test command support
Date: Fri, 12 Sep 2025 04:36:46 +0300
Message-ID: <20250912013646.11522-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912013646.11522-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250912013646.11522-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004525.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::346) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a21ae5-070c-4641-b44c-08ddf19cdde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7kv2OYynrPUJKTwDtTnvKrEaH+sBFAHwZGLq2mhQNqWQULDsyWKRDqYbtTTi?=
 =?us-ascii?Q?GBclXOX1pnWzjEVu7sf3FYFLbdog2P6Y217GEXNXJVqR8NV5gJE0xurJdikz?=
 =?us-ascii?Q?8XticVOicyNxQYvxnOuAct88wvKNPY5E/Yrrpfvsa7gsL2tUcDWAKO0YfUbK?=
 =?us-ascii?Q?cWDi2HWsWBSKA0rZtni7CXevnRvOHZnAKjzBijjgbCAKAb/WQt28Mu3aPEma?=
 =?us-ascii?Q?iyuV64s75Wcj9Ek42qDYuV52+2P540VuG9AR5amibBU1mWzejqnyO/KktbBt?=
 =?us-ascii?Q?wrYeRIQta0WP3mLqs/rraNCXUSZvF6UO4pgckpDf3eb3NvwlYejwfHWAGHH1?=
 =?us-ascii?Q?n03W0vrnCtTA/l7sDy7Cbyw8BajLVCpMTXdN/qMLRv5xAui7e8wP6k6Gqrnn?=
 =?us-ascii?Q?oObrajQrgDjWzeWIbFq9MNQscKZzWAeesYUDJ4GjlOctcw3MBACmhn83P17j?=
 =?us-ascii?Q?PGXbbtN1Aj6d0wZMG4CjV4qtt6hl56POHn3uhLhwP2ihBNJeJPd/Zoy0Aun0?=
 =?us-ascii?Q?O3z9FYvFiiNZlLzOBgj/xGaPJy1RTIk2Y9g9MNeVxT8nV2aPSGDFJb4pQ0ff?=
 =?us-ascii?Q?U4EU+AkbOHmAQRvIIkXvonJ8fhK7VlJPxCEvAbOOmnfkn4bH5HR0sTovlJGx?=
 =?us-ascii?Q?/Cg0RrpkFZDdTPZjX1F5TkoQEBAJcWwOc5LyU/yMxFLhf09jA2Es2iYNazuY?=
 =?us-ascii?Q?rOLZ3deHzDRh8XUHclfQRNLMp9BAksCzF/L96a1w8Lcj56GisXZJvKagsYte?=
 =?us-ascii?Q?aMR5y32N0AcqEzOpNRE4x+G+YkQxn7KJFEScbJ55Ot0+xDx5Fu0NA4T+mSED?=
 =?us-ascii?Q?F5dLskRO6CdsLz6hkrUVndtI/CcdFFYwrMoS5Lh14F8UWo/NR2Np8bAezDLf?=
 =?us-ascii?Q?hLG1mPR7wh/b9Gi5YbUpCXoLkTBBpG33xgMy5uEKviSvKVwDouCjLyFZw55o?=
 =?us-ascii?Q?y6w2KEl7STt0BMcDPh4/OQJHLbrsQJdRw4lxWVJmSVb25KOzaEk1Ob91Wrxv?=
 =?us-ascii?Q?M2Q31pX/kX5dYkS7kREBcP+HouNf1s92mltd5H+Zj//e0ugwLB/nd60ufGj5?=
 =?us-ascii?Q?fiRMW6cjLCVJIvk4nGBzSnDkl/zqGJr/Yj+O/JmHjM2jJqhqzU0fv1+kZwT5?=
 =?us-ascii?Q?CWtCX+5yEQn3OPuhEvGinn0K9JjkOw7S1WjF/nQegqsVJUf9UlLnxRkq23X+?=
 =?us-ascii?Q?p5xNeteyKaCdDjbA1B2kbeWp2SswWrHsnFov+K/vcXnhvWMdOs2nPHvA6QFP?=
 =?us-ascii?Q?1tWQZUjH2dhbo4seq4ILkV/j0KnKryuBHATCNWVqsY8mblj9TUNsdaAK/xKS?=
 =?us-ascii?Q?7QGOXlPMdGZj0nFYl36qOtshvw5IhTOl1Eu2BPV7fVk9jkd5go8TIuaDL5+X?=
 =?us-ascii?Q?tli4OqHvb1a7uZ7ibDha1upKO8Bo3vrk5tnHHT35kc7aNuiubLBAcbdmjzDB?=
 =?us-ascii?Q?V1AMwvhVU7/Jhe0R7Jhu8ffAnFT2GftZdX6+OUhpSMAH6bCSAHPQFLLgGrdT?=
 =?us-ascii?Q?Musvgp5dfh/eYqk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8GXxRKnnK9nWnIiFnEZ/yB67/7bousGg/YboHDmjRgLoXzKjtSpD9UZkWLbd?=
 =?us-ascii?Q?/70ZcfMTiOgsJy2nrI3JYqJ7W7lPhST5AW7U5zMk7uYa3BT4cgLADBIMPvMh?=
 =?us-ascii?Q?ZwlZ+ss5gfUmRi3ttxg48Nw7EAtVI/T23fZYq+vEq0qDwcLY1MPam9Q2zIms?=
 =?us-ascii?Q?RVdaJ9PfKbuht+eQA3l3+SWfGRURleQR21Ty1XyOZPnyqbiX7QTZujUfUfPn?=
 =?us-ascii?Q?8liYeGTX/S2Xacs1LycLVu9HDrG3LpDHIrAGUxkSTWL9Bf8mzLpKnfEsP+VQ?=
 =?us-ascii?Q?Ud+YEwxm5pPjdshWiqqoZHqB5kn5xvZn9FJXtnn9T6DkpscGiOxtySlbZS8U?=
 =?us-ascii?Q?yBoMw/IAr58uMGfR2rTO0S6ZOAFR7KjKPXrEFXr12Nw59MkvATq+tW8dnD/m?=
 =?us-ascii?Q?X2Bd3qTVVMaa87w+q8rOQHaWedttq2f5uX5jtcnSAG+kWmXvg+1n/1HioC/0?=
 =?us-ascii?Q?2m1zC7+guMH6AGBC/6xVQNFdk7x6lGadFrG/bV1yAZIsoYpNrp8Nn2QCFSbR?=
 =?us-ascii?Q?71o6eDGxfEGH0dK11IyyliXO02m6aq4hEfo2ZouEwoFUTlC90Cu9Qgb9FcoJ?=
 =?us-ascii?Q?Y0NlOevS7+5bi33GQh/H6vOeesYV96d1dSSpZcnSafFgRcvBKZt9vZ1khQE7?=
 =?us-ascii?Q?OT9C4KQAjuqGiko3M9os6pTKi4iHogo8wne5OeGvv8dddTsPfHes9I1bSHSO?=
 =?us-ascii?Q?8oxdWaZQQ0FJAyDWkOmPsU3lOFReu/4oatCnyasMVXgsrt4ziv7t6NHokPQR?=
 =?us-ascii?Q?C/cp99hGD+98NQuGGMCZ4v8cipAWknRpyBbAM3GedDxvERQ5tY55deVu+qd/?=
 =?us-ascii?Q?Ptgn9TPuTkR6AYgve3Sk0QQLaZ3eIRWd0O+nImUg22B905oJna9B78AQEb7H?=
 =?us-ascii?Q?nkEqwMjyBQ0h8TC0RbvWC/W7kmPGKMThKkY4EV+89pbRqrNsm/YXYppMRpu4?=
 =?us-ascii?Q?7PLyPdIAvp3V8+rzVh4Hmr3o6E3fucCwOfWWZRSMn8o1WKNTWQbLvmGw7NbE?=
 =?us-ascii?Q?3tohiOmWIYl4xdThz1oCywT2cQVtPoafaciY6ayxSrZ/hFhmKx7bqsKtA2ZV?=
 =?us-ascii?Q?rYKHrRHYO+LY4ZZhbukNCw5rrkskrXgUFl9+GeEGcMwZYZvGrBcx2I46X3vf?=
 =?us-ascii?Q?Ilmy7Hmi8p6SX/G8p6lls5q1R406SakVpp1ev2ryrQ5WkRVq+8kI9EZLmIEc?=
 =?us-ascii?Q?kI4x6ouzovfGfLFbx5lyjDlVPNtX8GKkxeDIO3vKh1qZT+GUr9zNEYGfihrj?=
 =?us-ascii?Q?fm7qK8Ax14iF+SaFXvXsOG4KSdK7KA00bTUAAQqipQ7+uz6Icx2qBQFadggc?=
 =?us-ascii?Q?nfbe8DcM+iMJKPQY9R4CYCrIzOHj0YPXI9lHgz6er5VIW3mKuLXa7gvAVZDi?=
 =?us-ascii?Q?nGNlft6SrNRlRQW/MFuJFxxw6nP7Ptwpcc134WhxEH2PzXSXL+jXJI5f5RpF?=
 =?us-ascii?Q?xKaB28mdNS/6Nt6BRQGPkJNjVnH/RLRM10wE8Dr7RJdehf0hGfT2ACZXZnUs?=
 =?us-ascii?Q?6NvvArwGvzbbp2GanwSgkYi+Onv19H+EHvR1ulS12eVrLpxLOEA6yTkR+yOf?=
 =?us-ascii?Q?ehrM9j061MkOeC76RKC9H7bwmcFnXqtDnag4jWgmxTHoNid6y0+hc/XmdDqQ?=
 =?us-ascii?Q?muPqEgbuh6LTERddUUhz+GA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a21ae5-070c-4641-b44c-08ddf19cdde7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:36:59.8591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTFhN8WxCi9UaF/FNIp9Ncb1pW++GzMBPbC6WnUb6cwT8w/Z96pkkh0GmEbcXuS6EkkHiBiX2xTWgMwJZaD1ZO4u003Bs5N3Z/K/ZwW7OTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11627
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

This patch implements read-only test of nand flash devices.

Test reads blocks of NAND flash in normal and raw modes and compares
results. The following statuses can be returned for a block:
 * non-ecc reading failed,
 * ecc reading failed,
 * block is bad,
 * bitflips is above maximum,
 * actual number of biflips above reported one,
 * bitflips reached it maximum value,
 * bitflips above threshold,
 * block is ok.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  16 +++++
 cmd/mtd.c   | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cd1a664f34f..21d6db57628 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1533,6 +1533,22 @@ config CMD_MTD_NAND_WRITE_TEST
 
 	  WARNING: This test will destroy any data on blocks being tested.
 
+config CMD_MTD_NAND_READ_TEST
+	bool "mtd nand_read_test"
+	depends on CMD_MTD
+	help
+	  MTD nand_read_test command support.
+
+	  Reads blocks of NAND flash in normal and raw modes and compares results.
+	  The following statuses can be returned for a block:
+	    * non-ecc reading failed,
+	    * ecc reading failed,
+	    * block is bad,
+	    * bitflips is above maximum,
+	    * actual number of biflips above reported one,
+	    * bitflips reached it maximum value,
+	    * block is ok.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 4d69c7b4915..689d8d11655 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -951,6 +951,200 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_READ_TEST
+enum nand_read_status {
+	NAND_READ_STATUS_UNKNOWN = 0,
+	NAND_READ_STATUS_NONECC_READ_FAIL,
+	NAND_READ_STATUS_ECC_READ_FAIL,
+	NAND_READ_STATUS_BAD_BLOCK,
+	NAND_READ_STATUS_BITFLIP_ABOVE_MAX,
+	NAND_READ_STATUS_BITFLIP_MISMATCH,
+	NAND_READ_STATUS_BITFLIP_MAX,
+	NAND_READ_STATUS_UNRELIABLE,
+	NAND_READ_STATUS_OK,
+};
+
+/* test_buf MUST be not smaller than 2 * blocksize bytes */
+static enum nand_read_status nand_read_block_check(struct mtd_info *mtd,
+						   loff_t off,
+						   size_t blocksize,
+						   u_char *test_buf)
+{
+	struct mtd_oob_ops ops = {
+		.mode   = MTD_OPS_RAW,
+		.len    = blocksize,
+		.datbuf = test_buf,
+	};
+	int i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at 0x%llx: bad block size\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	ret = mtd->_read_oob(mtd, off, &ops);
+	if (ret < 0) {
+		printf("\r  block at 0x%llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NAND_READ_STATUS_NONECC_READ_FAIL;
+	}
+
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ops.datbuf = test_buf + blocksize;
+
+	ret = mtd->_read_oob(mtd, off, &ops);
+	if (ret == -EBADMSG) {
+		printf("\r  block at 0x%llx: bad block\n", off);
+		return NAND_READ_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		printf("\r  block at 0x%llx: ecc reading error %d\n", off, ret);
+		return NAND_READ_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0)
+		return NAND_READ_STATUS_OK;
+
+	if (ret > mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: returned bit-flips value %d "
+		       "is above maximum value %d\n",
+		       off, ret, mtd->ecc_strength);
+		return NAND_READ_STATUS_BITFLIP_ABOVE_MAX;
+	}
+
+	max = 0;
+	pos = 0;
+	len = blocksize;
+	while (len > 0) {
+		cnt = 0;
+		for (i = 0; i < mtd->ecc_step_size; i++) {
+			d = test_buf[pos + i] ^ test_buf[blocksize + pos + i];
+			if (d == 0)
+				continue;
+
+			while (d > 0) {
+				d &= (d - 1);
+				cnt++;
+			}
+		}
+		if (cnt > max)
+			max = cnt;
+
+		len -= mtd->ecc_step_size;
+		pos += mtd->ecc_step_size;
+	}
+
+	if (max > ret) {
+		printf("\r  block at 0x%llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NAND_READ_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: max bitflip reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_BITFLIP_MAX;
+	}
+
+	if (ret >= mtd->bitflip_threshold) {
+		printf("\r  block at 0x%llx: bitflip threshold reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_UNRELIABLE;
+	}
+
+	return NAND_READ_STATUS_OK;
+}
+
+static int do_mtd_nand_read_test(struct cmd_tbl *cmdtp, int flag, int argc,
+				 char *const argv[])
+{
+	struct mtd_info		*mtd;
+	u64			off, blocks;
+	int			stat[NAND_READ_STATUS_OK + 1];
+	enum nand_read_status	ret;
+	u_char			*buf;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be checked\n");
+		goto test_error;
+	}
+
+	if (!mtd->_read_oob) {
+		printf("RAW reading is not supported\n");
+		goto test_error;
+	}
+
+	buf = malloc_cache_aligned(2 * mtd->erasesize);
+	if (!buf) {
+		printf("Can't allocate memory for the test\n");
+		goto test_error;
+	}
+
+	blocks = mtd->size;
+	do_div(blocks, mtd->erasesize);
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC theshold:     %d\n",   mtd->bitflip_threshold);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %lld\n", blocks);
+
+	printf("\nworking...\n");
+	memset(stat, 0, sizeof(stat));
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		ret = nand_read_block_check(mtd, off, mtd->erasesize, buf);
+		stat[ret]++;
+
+		switch (ret) {
+		case NAND_READ_STATUS_BAD_BLOCK:
+		case NAND_READ_STATUS_BITFLIP_MAX:
+		case NAND_READ_STATUS_UNRELIABLE:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NAND_READ_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: marked as BAD, but "
+				       "probably is GOOD\n", off);
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	free(buf);
+
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NAND_READ_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NAND_READ_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NAND_READ_STATUS_BITFLIP_MAX] +
+						 stat[NAND_READ_STATUS_UNRELIABLE]);
+	printf("  Non checked blocks:     %d\n", stat[NAND_READ_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NAND_READ_STATUS_NONECC_READ_FAIL] +
+						 stat[NAND_READ_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NAND_READ_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NAND_READ_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+
+test_error:
+	put_mtd_device(mtd);
+	return CMD_RET_FAILURE;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1039,6 +1233,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
 	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+	"mtd nand_read_test                    <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1081,6 +1278,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
 					     do_nand_write_test,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_read_test, 2, 0,
+					     do_mtd_nand_read_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.51.0

