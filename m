Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3298CCA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A57802C1;
	Tue, 19 Aug 2025 06:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="s19vWEZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A9280422; Tue, 19 Aug 2025 06:33:17 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1C08006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMIQEcQKjOl4fviocscoCafx5Waw+yrrjjPt6BBmABem19w5NBIjsvvxFlc9+nTTWwFrmQqBcnZ1PHAmVumkP4OmOqECdj9izx83t/Rc30+/6ynp1C017UhCJi9+YLKJstnhufR15RrciG7HaIGzYCY6RtwaXs0KJrGhrcl7utIz/+P6uJZwtrXmy87QOzIzZ5eS6AItLt+dIcz2PNoG3qXMT1pWFwn+EtymFMuQEFlOhlVuWoXyFzw1h62omw4+ft7jC/wxBoqiXnUXTpYTCg6BxR2kL0lOvfAYe8WwT/7K/93w+DKrgzeVtlxinxfUfmEVZIOsEd3qETLH5csNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjUHxayuWJVeIv00KB5AXFEtRaNQJWHzukUEHKmlVMg=;
 b=TJ/s3WF4DxkHY21nlZ9gh/N/xxTh2P/RYJWddq2iVaIQnHRgmNhwKGEvELp+0/yT1AFVC98p8JJpWi2lzPy06TfE8p0uA0I/9cuQfzzl2BLNZipbvc2cnjTdqAf+sDqfa+Ie1XaAGPnPfO9Dj4ld6S76v5K+V5PJNjP6Ec1RUbw6IvGaemu194gPmLQBrj9nrFskMPnSkDXaM/WvnMOZr35VyH4rXC8g/oextl0hb1m3RpP331aGjW3GcuQQfn+cAqs8yoHDm2+SRQNJ9R5kMP3mu7UM9O0kBMNU1FR9jCHrhmMkaJYvmcZGhD4rKFYql/fttEOxuyiU+aLEuEZnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjUHxayuWJVeIv00KB5AXFEtRaNQJWHzukUEHKmlVMg=;
 b=s19vWEZmmFq4DthuBU/7Ij8mMI4F1m2Xxp0V52z5yH4FuPqIm3Bl+z0wXXC4LEtQ0p70TH3gs0+NYg+ouVQCqxQo8zI0gg5CSrLecT+A7E4ADRLMP5prZSCX519nwb0nKsTRYELtbDcJjB8Lyh8a0+NZkg+ci3EnIv7RLnOthOilCXvrcv7vWrBIfH6xRkj8UjSWzqVFEEkXsnoMJvlUcvdruow/bD4uLRQEYsGZM5WHs9IswEuV0u3wlfF2fGHBrMwiZ7Qp5Xu6ri35qo5p1XaKIKNDJnnYpgFxXBsR1FFsZFRYxDqAHQjyYOruwSOljAJFG/0OWVq1w+lgpXpfvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5688.namprd03.prod.outlook.com (2603:10b6:510:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:33:12 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:33:11 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] doc: misc: fs_loader: Add example serial flash config
Date: Mon, 18 Aug 2025 21:33:02 -0700
Message-Id: <20250819043302.3972-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa747b4-9966-4fc7-b712-08ddded98167
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zgc+zxu7S5yT9PN0+TvJFZWYacflciv2gmtvFRVPdB4M10dQuyKMWHt7USn1?=
 =?us-ascii?Q?fj78CO2PDzFGCuVZJneaCAkwHM1Ntasrp6egKy09FLob+7pP6P8kT4Gn5Gnz?=
 =?us-ascii?Q?Ty2g9lctxfXioOzTO4PQUb5n9sp8giDVMPNgWfRLjF98vyDWluStUvaGjBl4?=
 =?us-ascii?Q?fjh6Tio9Tjx1umD2lbIh4Woqsga3JvNMGthd5TF4RuIG4KIxWDzKkIX2izxq?=
 =?us-ascii?Q?TJT14edS4SomEnEtRCHbNZsTIadh6zp4m5YNE2y2dN/rXNJl6IfBJ0aVjjFW?=
 =?us-ascii?Q?X/s0Az0nphswhDE5/jaeWttbSH0O3nCaScEtSLHlM/FFHZMt/sKnguuhLEF2?=
 =?us-ascii?Q?CcnhMM4wAfxZ+3H/Ij+x3WMO6DXecBLRycQSXS6SEkIjiCrOFEQ0oaLCAvIB?=
 =?us-ascii?Q?xPJA+F9AQw2208WnZS2srDXmlgRvaaVft8+PxVDbPVA/l3UzhX2syM3a6V1b?=
 =?us-ascii?Q?el36fUunQ8h6wciJnX7+cVjJ1KKfUW6lafURbnk299mktVuMYhRFbxWwl0li?=
 =?us-ascii?Q?tJYMbvlJVg9x+fWHWD/Xtc3v2FwHii5TWiaSVVbCNq36niyxd4CJLRzII7/d?=
 =?us-ascii?Q?4bMUB286Clh82BB6g+JuiCs5RBb5h6D8A8gh4JE6mqOs+o4vlx8+Y1EQuNAY?=
 =?us-ascii?Q?5zqRwch5Trts4xbxsv1VGz7s59DLqI+rurDBz00GNnuI0hZO+fAR30xYrTaZ?=
 =?us-ascii?Q?KTcGl048VwdmO0xXjJQ5vA8Qa0Eh1ieLdr2HXN9HLz2zq5aZblUpl+RaLda5?=
 =?us-ascii?Q?yxYlvXSq/67vVjefw/y8zxPqGnS2rIHci98BKm48fqvp18BwJG69ZbgK6ZPL?=
 =?us-ascii?Q?RnsNaQZApNqGYhP6SCbRCYrB5DxTg2+5Q//is5rCmvImPyLhkBkkNrv3A0hb?=
 =?us-ascii?Q?GBhYf2DVFuiBXi2L1iz/cGsp+gjYseyYXdoccgQbls97W1pPVh6398t5BaFc?=
 =?us-ascii?Q?NwuDYTwT8RX7/wik/reYDAFUk2s6S7aEJo3CsAAYUbKNg/2IYC9/iWVreQpN?=
 =?us-ascii?Q?ECldEZnAvxljQuCtRHxlzc2bxq+5RRaoGDB4/Tb9VP+lRhd9DHeJwj9pophQ?=
 =?us-ascii?Q?3LQpkEGktHz+sJvr0p4VHgYyGrntmWEjRo3cV5aZpyfYbfdWpsqkJV90D94e?=
 =?us-ascii?Q?gOB1RGUQVbhSTp2tzLAjEjj4We2irYiEvJhLhrgOBjcdbQwqea92Q0WAHpEd?=
 =?us-ascii?Q?p3DoA14v7HRQout9sxPzO9TzCwmIBIesjQ6yhjcRb//fgsvQrw7Fn2389yW2?=
 =?us-ascii?Q?GZ+AbBmneJsKV5nRJmVa6p0nvQnnX0GZWU/BvDGaTO2KWOwd79tbzBtNS3Jp?=
 =?us-ascii?Q?7AhVwNkDT0rMkm5HbAWMKX1k+r+8nUBBBuK2ghT2pknBi/xbZLqOxTtjifnl?=
 =?us-ascii?Q?7COx5DvvyNO5cBKg8qsGgTBC4OQdC5P6l7lGzd1LOQISYN7pG39y5TjtQKKL?=
 =?us-ascii?Q?vB/QrnDqHgY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7r1Dj/sqLefpqAexYWBScuM04bSxgIWq324zVGhxioKvvsW57wWcioEoerGX?=
 =?us-ascii?Q?cxVJGvQ+NsAdEZQwGWW4BwgT87vp+OsJNQWm3Cy81G7U/CIu5qKdxFPnEWn2?=
 =?us-ascii?Q?UR7k5gPJ/yFVVCoykDeIzTTgmI8zTV1NvcwxT8Ke3ry97StOZaeJmnYe/POk?=
 =?us-ascii?Q?CP3DwIqCJA4Rdwk1y4+joQnYM3oXvwKAE3rgzxBCosbt9C1+Drijv8VV4wed?=
 =?us-ascii?Q?RQwseE7jdl1RBIgnbM3ckjlhR8ECbYCiqP3SVigxmUXRPrFGqwSKKQZt+yn1?=
 =?us-ascii?Q?bRU/MtyK/skNtrLrVi49B7/7+WHBY1mXV5SN7VRBY7VX5q2h1lTJjvyCf3iN?=
 =?us-ascii?Q?SJZhUGdFxbMDUOSeVaMtPOpjRjSb2ElqGC234O5Ic95F49ZpwFMF7SxcBpwI?=
 =?us-ascii?Q?WJRDwmIjeporPnNFISCUQQHldhLmDNrN+oLJv/OJpDjIaEMQQ3oHpbYllVOR?=
 =?us-ascii?Q?6n4bNJPqdsHciqlsANcJeoGSldeH04kPcbZKd8WxfpjRbjEHi4NsolnTNfiF?=
 =?us-ascii?Q?f/poQWrn5zzg7p7LK7C8L6+JNyfj1I0Ex5cTDgbOHoS4yUX6vkKvJTVsKYqt?=
 =?us-ascii?Q?KL6fvBbZ+iSU+3a2igfmjd9+g4HqRLx9meH25waCwtyLMhhnfuIGdY57+i2F?=
 =?us-ascii?Q?odn5/J43egd8qv6DxJQS/tVS32PINp5BR7AmoR4CLX/eu2C8Sxm65YnXGWAB?=
 =?us-ascii?Q?5u0GSiXNHjLc6QvNbOqFwh34o3oudOPSlpdDhG68GPQq3kEVDShxZnKRY1F1?=
 =?us-ascii?Q?XgYBEotkXouKZG80Ame797eC+vMQl12aA8tW8mhFAW9C/YSvGb1IyP47k0oQ?=
 =?us-ascii?Q?OYZdpl/LWN48Em+YC2ntZuwlDhFic8k1dgOr9hBFFHLk4tR3EhhvcAB/ZZVd?=
 =?us-ascii?Q?FC3er/3jumOChUWyElN6r+HOI9fgWZLLPQNwTC0tVq8jbTCKkPfFhDn+gI36?=
 =?us-ascii?Q?1Z/pkaQ2hT6a3rHlTiGk9AbXgc3ymjddX6rsR+MZ6G1jPWlWU8Grz4E157kd?=
 =?us-ascii?Q?6623IPD3PpPUb0wHVo6yKaBXKM4bixDnphuIls7RvxwZz5o/FevgAtn0UL6y?=
 =?us-ascii?Q?urcCcSWmSovpdf1NovxkxISNFwTBPMtXwOeYvYuzvDsxZIOy8rn7I6gzO9zK?=
 =?us-ascii?Q?5GPZ3F6Qx+v32yHl+tM7GLp4EFr8gFdeb202dfltg29YpCo22vp9cmywaXd4?=
 =?us-ascii?Q?y+dU5eBlOKrej0bbcp6yRPAaN+zkkW22T0XcbFh1xSZ+U+bLqJBL7LfKh63h?=
 =?us-ascii?Q?z/SJvP1i7i2pP49dwkqj7FSFX0bIsRGaKVXlmZyG2OOxc7jnmOd6VzSo4FFJ?=
 =?us-ascii?Q?4d0HUlzhbP1rDxFDIlIQ6uDV/DQFZ5vl28DSRtsTffUbthGrsLOjYgaNdWD+?=
 =?us-ascii?Q?n5yH/tP3dybQQSuwDyJUO5ShezfeSJAIBkO5VAa9WGkFI46j7w1hlPxECJOh?=
 =?us-ascii?Q?nhdSxo6bkuZNHEK4R88B0YvFEkc8yMWsh6jmN3yN7Q2woIOSiHEDV9XFlimY?=
 =?us-ascii?Q?Sfi/aMRNS8swJWjeUUP6EjEmHnDSv85Vr5RBg34JfhFczYQjoqskWI/mo2AN?=
 =?us-ascii?Q?uPx8XGqdnBPh7Wuhch5li3Qy8Ap9kL4pc4T6N6OiiUmJFcw5+chpO+L3WVvo?=
 =?us-ascii?Q?P+LR4MowWroQi/Xs9wm4UMI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa747b4-9966-4fc7-b712-08ddded98167
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:33:11.8662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rHVKs0P6JufnZjC1ZeuRNfQXnrdP8Uwmc0HYk/+Z2ELeda9puLaPGwXSr2dVy7gc5jHvb/ZVTEBy2l8x1BMPlhnPnoTqx2niLD5OsTSiCZahY1/7UQVv9bsc7zTEMsy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5688
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

Add additional example storage device and partition search
for qspi in device tree source.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 doc/device-tree-bindings/misc/fs_loader.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
index 542be4b25a0..621472e516a 100644
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ b/doc/device-tree-bindings/misc/fs_loader.txt
@@ -12,6 +12,8 @@ Required properties:
 	   required for ubi and mounting.
 - ubivol: which volume of ubi the image loading from, this property is required
 	  for ubi and mounting.
+- sfconfig: serial flash configuration which should only contain "bus number"
+	    and "chip selection".
 
 Example of storage device and partition search set for mmc, usb, sata and
 ubi in device tree source as shown in below:
@@ -46,3 +48,10 @@ ubi in device tree source as shown in below:
 		mtdpart = "UBI",
 		ubivol = "ubi0";
 	};
+
+	Example for qspi:
+	fs_loader4: fs-loader@4 {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		sfconfig = <0 0>;
+	};
-- 
2.35.3

