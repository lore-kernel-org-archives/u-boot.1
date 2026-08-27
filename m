Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E85DC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 20:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E97440755;
	Thu, 27 Aug 2026 20:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9sIJl5sgj3T; Thu, 27 Aug 2026 20:58:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787864303;
	bh=TyGxO9QcW4L+jyiKXoxV7hcEv/q3jn6sq1E6zAnoH2w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vQMfYZsk5YJB+HaWkDSvaesv+M4Vmt5TzlYC/ZCWbvjoFPfIXeFQEWtXzVgLN4cCW
	 PjugkBB+Nezm/tBbBnHTfAXj3G+mHnIrm/GRqP8SfVRQnhlLspGZp3Q9J189sR3tYK
	 E89512wRhxV2wbP/xcttrOxiAXJ76pMH/aEaCPQIuPJnjWTbKnlVCbR6AZPfsp6+x4
	 k1lu3s5C9BtsnVQB7i76WPLT8r3Ep9OTLNu2VfvjIXQi8O9s7HxyR93HqEBNBlEdqm
	 RyqX3k4dZmpekNv9An8teWNmEfpq8xtqfU7ZEeHpXEEjx4oXQ94baobUDnY6n6h1k0
	 Nc1T2E4iZJc0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7922A40764;
	Thu, 27 Aug 2026 20:58:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60B5F466
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52A984076B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p0tA5FoMqbA6 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 20:45:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=eHeQy/JL
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5163840641
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avueX//3JV2T4sZHS7NSryndZpIPbiaOREA9meUaYMXtj9oKNbocwNJ03W665b1QViHsvKmRkpsyIs/3OgsPk+QW3PnmrR19TKshjI+l/pM6QD8iQh3JWE+wraHTxsJhdjmyYxLri5wYD3zq3fbuAl0Vtq9zO2j4g40imoVeqn/LsJMTR66bBAQoxeIM9xsy39+FRygXL73QWzk0kKJ3rY2AjQwyyHzVzELMEOkZC6bx3am3A0LjT8FI39H67G6N3cBpwKeu2mPGRNRd3EzjwRY3K756ZugGQEG4woECrUJx+EihS90omdIFw2Kv8Nb/gO7L/0hhsTemv0Gsp3jM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyGxO9QcW4L+jyiKXoxV7hcEv/q3jn6sq1E6zAnoH2w=;
 b=DrQfrPFWKL6i11guWD18ZnEyoBs2MR/ocgF+TRvheqX2CAr9JP7kUIVsjn0IYEWakfV1w51XEupO0AqfurZR5QJPFE5M21LaueDCwJ80/yqJZ9ZHExBCkV/mAhRuO7+9ccl4cxIOwVUGigS/no6Kad0lVwoWnse+XTrOYcN0Wkk1jrH4/xZGTKmCdkSrm3TXPYgEXse11wE0MuiWLSn8eIC0oxcYM+Gx9Z9V/uZUeBBqQVjhKFYj5T00Nu506qeT8zy84QlGL1Nmq/sCDLLNxyFaBooQFluOJanP6JybgkBmfrSMw3KDr3DLb3yHTjbSrDj3MzQZbTSjSqirNX2dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyGxO9QcW4L+jyiKXoxV7hcEv/q3jn6sq1E6zAnoH2w=;
 b=eHeQy/JLHVwap66RPvGfrSGjf+vltKZVWHIUD/nyRq+6YJnt7QDCLywlOAO6Oq1k/hWjFliPAi0JFpZjumAjGke9yuhPwqETaVFzpGoOm6Xqhh9oe3zDQCbhTlY9Pq0vPnANeYSE9EUL/SJt5S6vftAtN655bg5JEhc6RqD/SZoc8KhfYarlk7SRl1ZA3+45uZvlTeh77PbIX2zRI0XsXbrf46RG35MlrJUNGAvjYCgU0tNHWUs/h6uZkNZWqcLnsNJjiLBmH5W4G8snqID+ddqToSZlWYdpKeHgiWjqKg11KIvtFlk9Xxx4fp7kVdSeVubQA00rPkrYnkvBSoa4ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:45:53 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 20:45:53 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: u-boot@lists.u-boot-project.org
Cc: tim609@andestech.com, Jamie.Gibbons@microchip.com,
 Conor.Dooley@microchip.com, Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH v3] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
Date: Thu, 27 Aug 2026 16:45:38 -0400
Message-ID: <20260827204538.16222-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::8) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e24f07-f5f3-434c-8b84-08df047c2f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|366016|786006|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: zZK6koC57bFNHQgA7VcZzihlXs3K3Lbrc2LRqsZo14WaIjFsHwgrGNqhaU5Y38/leiERCybGv/OS/4sk2J93uUBJbCzF12wF0T4oJprptr3P9LJMwZ7zSN01sdp3thrqEMsybRgJWRuA6xDTc1ErZWf7l66It3JhtoCAoJg+/Lk9tDkz4fsFYeVvMU0XSQL6LEJ7RQHGFYMSvCRScoofhpAWQr0QEPr529A695fRYno/lXQzM6bL8eIYG2jL0yZOtgsO59OmY6aktceA7WGGYTJ+B35piY9DJV9ff5G/FdGZ/xmOJfUDcP1uouabd3xUCOvvZ6Bu8veu8le/Yxp3YGHB8imIda/H4JmFqqEdwZld6GAreGzG6j6fc9SojQ85nFLLzQ1GBU7qFIDKUcqzkQJ+AKw49PQtp4NBcHypRUY3aWdIOkgiSLKjfJctwRUqnLGqiN82XSXeBv3t6WvRDGAifa8raly0rAPz6czl47tbFmbc5lALMGB+IqvkmciMY4m5w6fYBixpa3qOP5STfbQFwYgPm5OTzPaQeqpa35+yUnRKbXjBMIeap89oiCDqXftAOo0d2Kn7knmRq/AheGQ87P4aU1VAZwjnKbkY3QEVx/nUxZd2C1QvaWQBzQpUz0ki/MsWK0dgQ5RyI9dRMXkZtqUNoKvuRdMF4FQI6Bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(786006)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qPH7VtGVu5M5LWMkCYQzlt00KL8BFs/eGPho15KuMFqE9wja87Mvz+h+66Wk?=
 =?us-ascii?Q?4iGDOXgSFwVx5vxytPsaDymbwh1cX9KaKqz5FtWo+QTUlUXXT4Yjgt/CeChq?=
 =?us-ascii?Q?ESm9Xh5aqyuh0wEQC8sSP7sEO8h26onL+7RGbN4rFPxkXX5Kw49BdJJz7wl5?=
 =?us-ascii?Q?gomAi+8yXvE/S4secWdr+Yue36X0+xYYety03YVunLRb8oludjhxnBmNqcFG?=
 =?us-ascii?Q?fcZpAmiTmlnoJiPyHaH1w62msA0HxRqoOO4aFycGmkGg/jWFo+bbWlWMUw2/?=
 =?us-ascii?Q?xx1lScwWvxAGePFc4vuvjQUl1ZZSZQNc2bYLGgHBdVfjj7zukGVVg/tIwcDZ?=
 =?us-ascii?Q?+elTgfugfwuzsLcbd0iVR0r4boec2c5b9CU9IOi7Ajo+luSPn2mXYRxcQ6Ma?=
 =?us-ascii?Q?99Jffp331+zFjmgq73amkDMhDJcDJ8b/dFAo0CF9duB1sZJMIpanFHGAk+WG?=
 =?us-ascii?Q?rxI/6tv2C5tFhQLw7vQ/V7+TISfRRiIe8AmEnCiJe68XnH5FIt7Va/1CuCrb?=
 =?us-ascii?Q?vEAgiYkj9KMxU96X9gk1oZmznRywSrVEVDe56naflW9+caNwoOzyCCAMhOgw?=
 =?us-ascii?Q?uYEcBooXk1colMgKXoNli2/OT4O+6U/oppMNRR3VpgyuYIYmnKeoNXYaCzPn?=
 =?us-ascii?Q?tdBZw9GnwiDW2jgl4ISH3zb6G5xisR9yW8wyz4doJIgfxf9vx/AUb6cyBqTj?=
 =?us-ascii?Q?wyA1gwtY0gEZzfnYHhdJ5YVjfgwZZBB4xsdX6wRHMhEFu/uQo9ypZZm9fNO7?=
 =?us-ascii?Q?DtWViZueoaD/7mWUicBXCvgiIPAzo53O06Lgshnzl7Z9bfH/wh4xZc1Nly/x?=
 =?us-ascii?Q?8Dodzr4dASymn3LVJcJLJEl4yx73ITPcAg6sO8Pun+oYZoD82l8r4h6lj64+?=
 =?us-ascii?Q?HjZ3Uwzaf3iQ2AbaUwjkOesKfGSiF/GiLuXkjnLbRaD3Ny7H3MgisWt08IeP?=
 =?us-ascii?Q?N8UTBAJ5zeczvOtHk2EZfcpxQQ1fcYcNihcsaV0gc+0KrXL8liMeW7x92vKF?=
 =?us-ascii?Q?JuGEBvao9N925ewOik/IhLhT73aGjHt6+JhpQPXh0vFd2M0nRRhXLW/JJnpB?=
 =?us-ascii?Q?PjZe7x4f7yHIypW1bdxblDCREsh2BjVtFt5Rmo73Bf+lhgFe8WaBSwjh+DJy?=
 =?us-ascii?Q?0pdkshSU4WscQUiat4JW/aHU7o8pnUi6QGlIXZkT3bZul8XH1LMxm90e69a7?=
 =?us-ascii?Q?radV7iDWkBl2rxTHsPcN3qqu5AW1TG7iF8o2wWtlyGiEd8o/0mN44H4gDTf+?=
 =?us-ascii?Q?lXus37D8lCJ+nQpHGHyd693mdhO3MgAfJ2IFsjRNmZCXc8GAbbR75eZpJD1N?=
 =?us-ascii?Q?BTc0MkArQHJuua46z3/QnqctiKQaOTCKkDg3T59JZohLfkst1DoT8+GFme63?=
 =?us-ascii?Q?tE4WyQCCIsjmFkCDDc6Jx4LZJitipJ3MBTQsf0y+VAVR4QCRqc/Qu94877NM?=
 =?us-ascii?Q?M/UR4WBMMyVq1Rm0GCZT3hF0GW5jRV9tDU9jP2exbx/x73njl5dWNvqsn7WA?=
 =?us-ascii?Q?jDee05HZqcdHewiJ13kS+B8+FvnA/bBUTEHsE1vN7kK5edOLLZ4BOiwU2GqZ?=
 =?us-ascii?Q?TqQ48q1ERAnz1RoTeufrQG02eWac64gyzNuPYLdu73jDhp7au7/cFK8CvDcq?=
 =?us-ascii?Q?+jPOU68nnaP1riz41wov5N0knvlag+VbK90en6YRV9Y+yEKfGEDgafmWtbdv?=
 =?us-ascii?Q?LRBzcjnMUXukqAgiVsfRokGFzoOjn3iVOTK6poNUL6TbeinIiXvPFIbOmGx9?=
 =?us-ascii?Q?v7uqZl/pNg=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e24f07-f5f3-434c-8b84-08df047c2f7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:45:53.0256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X4/MaKKKw/LfELkpBtKTURc8I8SMzpQalrX+iACc0PX7L9DidZMDGPT6fNfUjSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
X-Mailman-Approved-At: Thu, 27 Aug 2026 20:58:20 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When working with systems with multiple FPGA firmwares, it is sometimes
useful to be able to use the same U-Boot and script conditional behavior
based on the FPGA firmware ID and version number. This, allows, for
example, flashing new FPGA images without flashing the bootloader and
letting U-Boot and the Linux kernel adapt appropriately.

This does two things with the information:
1. Prints the FPGA design ID and version to the console as part of U-Boot
   startup, which is helpful to a human working with the board.
2. Stores the same information, plus the already-acquired FPGA serial
   number, in a new set of environment variables (serial_number,
   design_id, design_ver [the version], and design_backlevel
   [minimum-version backlevel]). These can be used in a U-Boot script to
   load different kernels, device trees, etc. depending on the currently
   installed firmware, which allows U-Boot and the kernel to adapt
   cleanly to FPGA firmware updates that change accessible peripherals
   etc.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Acked-by: Jamie Gibbons <Jamie.Gibbons@microchip.com>
Reviewed-by: Conor Dooley <Conor.Dooley@microchip.com>
---
Changes for v2:
- Rename environment variables to remove the pf_ prefix
- Remove portions of the patch that added properties to the device tree
- Style changes
- Rebase after a5f93037f28624c612288e2d97604d73e03af5a3

Changes for v3:
- Formatting changes suggested by Conor Dooley
- Add #define for CMD_DESIGN_INFO instead of using a numerical opcode,
  as suggested by Jamie Gibbons
- Rebase after 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc

Thanks to Conor Dooley, Tim Ouyang, and Jamie Gibbons for helpful suggestions.

 board/microchip/mpfs_generic/mpfs_generic.c | 26 ++++++++++
 drivers/misc/mpfs_syscontroller.c           | 55 +++++++++++++++++++++
 include/mpfs-mailbox.h                      |  2 +
 3 files changed, 83 insertions(+)

diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchip/mpfs_generic/mpfs_generic.c
index f57f5f4046b..fe9ce249b36 100644
--- a/board/microchip/mpfs_generic/mpfs_generic.c
+++ b/board/microchip/mpfs_generic/mpfs_generic.c
@@ -114,7 +114,10 @@ int board_late_init(void)
 {
 	u32 ret;
 	int node;
+	int idx;
 	u8 device_serial_number[16] = {0};
+	char serialstring[33], designid[33];
+	u16 designver, designbacklevel;
 	void *blob = (void *)gd->fdt_blob;
 	struct udevice *dev;
 	struct mpfs_sys_serv *sys_serv_priv;
@@ -144,6 +147,29 @@ int board_late_init(void)
 		return -EINVAL;
 	}
 
+	/* Store design info and serial number in environment */
+	memset(designid, 0, sizeof(designid));
+	memset(serialstring, 0, sizeof(serialstring));
+
+	ret = mpfs_syscontroller_read_design_info(sys_serv_priv, designid,
+						  &designver, &designbacklevel);
+	if (ret) {
+		printf("Cannot read device design information\n");
+		return -EINVAL;
+	}
+
+	for (idx = 0; idx < 16; idx++)
+		sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);
+
+	env_set("serial_number", serialstring);
+	env_set("design_id", designid);
+	env_set_ulong("design_ver", designver);
+	env_set_ulong("design_backlevel", designbacklevel);
+
+	printf("FPGA Design name: %s\n", designid);
+	printf("FPGA Serial: %s\n", serialstring);
+	printf("Design version number %d (backlevel %d)\n", designver, designbacklevel);
+
 	/* Update MAC address with device serial number */
 	mac_addr[0] = 0x00;
 	mac_addr[1] = 0x04;
diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index b9aea7e1181..8c1980faeb5 100644
--- a/drivers/misc/mpfs_syscontroller.c
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -45,6 +45,7 @@
 #define DESIGN_MAGIC_3					0x50 /* 'P'*/
 
 #define CMD_OPCODE						0x0u
+#define CMD_DESIGN_INFO						0x2u
 #define CMD_DATA_SIZE					0U
 #define CMD_DATA						NULL
 #define MBOX_OFFSET						0x0
@@ -152,6 +153,60 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *devi
 }
 EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
 
+/**
+ * mpfs_syscontroller_read_design_info() - Use system service to read FPGA design info
+ * @sys_serv_priv:	system service private data
+ * @designid:		30-byte string name of top module in FPGA logic design
+ * 			NB: null termination is not guaranteed
+ * @designver:		version number of the FPGA design
+ * @backlevel:		programmed minimum allowed FPGA design version
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv,
+		u8 *designid, u16 *designver, u16 *backlevel)
+{
+	unsigned long timeoutsecs = 300;
+	u8 data[36];
+	int ret;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = (u32 *)data,
+		.resp_size = sizeof(data)};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = CMD_DESIGN_INFO,
+		.cmd_data_size = CMD_DATA_SIZE,
+		.response = &response,
+		.cmd_data = CMD_DATA,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET};
+
+	ret = mpfs_syscontroller_run_service(sys_serv_priv->sys_controller, &msg);
+	if (ret) {
+		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort\n", ret);
+		return ret;
+	}
+
+	/* Receive the response */
+	ret = mpfs_syscontroller_recv_response(sys_serv_priv->sys_controller, &msg, timeoutsecs);
+	if (ret)
+		return ret;
+
+	debug("%s: Read successful %s\n",
+	      __func__, sys_serv_priv->sys_controller->chan.dev->name);
+
+	if (designid != NULL)
+		memcpy(designid, &data[2], 30);
+	if (designver != NULL)
+		memcpy(designver, &data[32], 2);
+	if (backlevel != NULL)
+		memcpy(backlevel, &data[34], 2);
+
+	return 0;
+}
+EXPORT_SYMBOL(mpfs_syscontroller_read_design_info);
+
 static u16 mpfs_syscontroller_service_spi_copy(struct mpfs_sys_serv *sys_serv_priv, u64 dst_addr, u32 src_addr, u32 length)
 {
 	int ret;
diff --git a/include/mpfs-mailbox.h b/include/mpfs-mailbox.h
index 39c998e4c8d..bb9a162fb20 100644
--- a/include/mpfs-mailbox.h
+++ b/include/mpfs-mailbox.h
@@ -61,6 +61,8 @@ int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controlle
 int mpfs_syscontroller_recv_response(struct mpfs_syscontroller_priv
 	*sys_controller, struct mpfs_mss_msg *msg, unsigned long timeout_ms);
 int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number);
+int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv,
+		u8 *designid, u16 *designver, u16 *backlevel);
 void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv);
 struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev);
 
-- 
2.43.0

