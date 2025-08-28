Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8583CCA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 06:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7425B83214;
	Thu, 28 Aug 2025 08:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QsCYbc7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5BC83106; Thu, 28 Aug 2025 08:24:30 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B576831BB
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 08:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1XEBAeSroCWesx0TMW5QvFFJBn/ID/rA3AKrhj/5p4aS6mzCQHk/EjU0y8RxZ4dHMnwM7sjdTRIw3CSfJTd7Hq08X6Ib8mWnBwQ3xT6z9dTO/r6UN6YeGTxnexatMh/E7h7uw9m8ybeIKGxxhML2WxuHoWX0j8D4cRlN85Hdvt69Zk03ghmlTQPYunUnJ4J+hoOHBk4tDGZT/cXrVJXa/rlC2D+cAhBYyr8Lk5cbbkvnTJV1aaz3UEFMhal2fqP/QQzCHiXtvepNY4djNu4uM2M6h3GMDoSpQmfZEQHFxRgyB8dS1hiPOPq2PopZoCq8YEZEpjakPR0xw6wY8g7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMykyzucuqU7bDZc2/kHwttJRYF1ilOn7yMafmQcStQ=;
 b=QMOXOPeMLHiQAQMieMemPouWs+++y5cB7Dl71dzR5HHEPE57XJUDq1+Eomm2UUaNlGbTyNufR4Fi0oMLmNfIZQrgYePmZjnQWARgOGGhNrgFL33TcBP2fay2Y0dM8CkSH6/97oSCpxna36Qb8joxYFR8WYJUAVxKjjFTO6bnq5uycZd5uSMxOfeLSsGKtOhboaOpkv4c7U+2RBEpY7JVsVvLR5r8SCY57/lIQ+KW2uOYOin09KTjulinzgwa0vHyDGtivoWhePId3lTKPwF48nuYqdA2oAR7Sy3uaZ9ax1aoNG7BwdHFKZgSnR+OXFbylqwU46zP8JcJ8QEB8N8whA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMykyzucuqU7bDZc2/kHwttJRYF1ilOn7yMafmQcStQ=;
 b=QsCYbc7ZefkFJkVpw039sfxKAfU/L7vMepuYQsUDTkc3mxfMBbcak/R26BjyHvdKQOqpavYOc9cDM+93hGTJb+OCl/LFFNB9mhqFXFNb/bt1iU099pGdY/UNvrrgiaECgWKZi7CJSdsZhc8eTrEKRRcMVRhiQz3syOUu5SPGI7X1UlJZUJXuKSNff/6fSEj+l7w01AgUIUqCCmZxMxuTXBVqQdgiHrOqgq9g8eBa4BzoATbZAIM2eezYBajocxjF9REz1L9g9WZa/4AMMnZu7p9ThFSFXmiPSPkF1p8zVaY/VX79d0PHSh9Uks7Q2O7CrYFvaBb5+OAJzNDkyh3zZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA2PR03MB5676.namprd03.prod.outlook.com (2603:10b6:806:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Thu, 28 Aug
 2025 06:24:26 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 06:24:26 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Date: Wed, 27 Aug 2025 23:24:15 -0700
Message-Id: <20250828062418.17945-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
References: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA2PR03MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: bfeb9145-5ffb-4a8a-01e0-08dde5fb8929
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?csIT5IJwP5xH/Ik+HXUH59qAKpfB6rxvGkMLLlhLTtRKxru7NZsGXDo0ywNR?=
 =?us-ascii?Q?ud/uuSG0UPR1mRPynPwMbnv6ttCmdl4UtX3z3chU9eGihfw54uh4reLFYFrz?=
 =?us-ascii?Q?Jl13AgTJEnTwY3/NfNT673aqMAWMor/6hQKLMx7rtFuFbF2kIzWO+XOLRVXg?=
 =?us-ascii?Q?9T8OxBwyTz5ON42Hl0LhE/GQmjSr7gmD5dq6WK+CKZMndGGgs0GgAsvPFDE+?=
 =?us-ascii?Q?dtK9Myilr6qhNn7HH+VYbD/NMDFFsc/FWx9zEGbggzm+EJNWJzvf/mfAo0uP?=
 =?us-ascii?Q?2dGN9es6dVQhSnuF9rzCfzdiWIZRbY2qSfqIrG4yuX5RvupDt/8bWBbpGtcl?=
 =?us-ascii?Q?KyzFZM1F+Z5VpYcGDrahDiGzGkeRliEKM0rGzLN4O/zlkahUNEzeS9jkFaBO?=
 =?us-ascii?Q?JviBSbYzJ6Esm++dqHY3d8V//o9OImCsHXZLhoLc5wQDgkdTnXt9YESwAbA5?=
 =?us-ascii?Q?S/tCPBpJN4P9qCtILFJhM6+Kzhtop5gVR7GlpK5SK5j+g1oCAxFRoZUVoD0+?=
 =?us-ascii?Q?Lyo0IO1wMTF+LhxQskKx3XDfgtsaEMCoQGgjTEnfyJzYLkcs5m8plL3D34CQ?=
 =?us-ascii?Q?CoytlENKmaLqJjAL51unxjSUYmZ7d8J/iqWG5g/y1pFhhZjxHl9EtyADh2zf?=
 =?us-ascii?Q?LCGZzTy+v2y9SpuxK5xRvdfeHUZiM2wai0H6nOyZqu43hClvootu3GMBoeZg?=
 =?us-ascii?Q?j2UypI+mFlZJA40blemp+koYfjmUm9qIQHBpWCRteCTCefKy3GLTbvTOz0Gw?=
 =?us-ascii?Q?N2R6KnYaj6sdvsPJln9maRayPgE6iqlO++PDZ2GZDDD1Ya8t7dkjxs9zLNJX?=
 =?us-ascii?Q?uM9mkd6grBReG6hFHrNOGPx5vUyQuO/6gcwaFe6RnFc5SY3pi600NtTLBIex?=
 =?us-ascii?Q?e9UMrFbJIH6hK0gTlPTUSZuUrgryCLmOMWzAde+GDamnsr9Q+CCqWgGzrsgA?=
 =?us-ascii?Q?LL+KB0yCqPYPx+t08nWwgz3EJlrXSm3lU3Xez/rec9ZgzJ3q77bqpF+M2Top?=
 =?us-ascii?Q?8kETG0mG8kqaseEaNvNUNif9CfYgpN7115pWuRvws+JAlidFsW7zZcVJRfcX?=
 =?us-ascii?Q?48fQh01yJ97wHcpLB3zpIhgIMtsV5IcYKfUjM8axqg4IAwQjt2vk1V9ZoogK?=
 =?us-ascii?Q?OasnC93j9OaHPIDgV+0nP/zVA2oysgR789oeB6jtrCVujrwpjghP+VjlQJxx?=
 =?us-ascii?Q?PSb7d4+SKF2sL2k87vZDIkkJzaKMcd5WPlUfdUX5YE8vtTcI0ByVI34IT0yI?=
 =?us-ascii?Q?DYeqyPKrJp2pncoFOePj5pcvpfuLPFKG9Vhu+juQz93pyNqh4Fu8rzXmkYLi?=
 =?us-ascii?Q?O4ZFlnrz8thOIVXApT9w68eJJDDyvsKx9jIy5Du5VOvDybAKx9dfslSCpicV?=
 =?us-ascii?Q?5DJZB0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFUSZNw9fbMU3XIoTUK+Rcy2IYAu62eXmLdnf60hweJjRji4m86Ffot0StBw?=
 =?us-ascii?Q?Ngyn4a/yz7oD+W23kzuyFnPXNneoiPCYRCe8U4TgkUaZAuzRViWZ2fUp+Vo3?=
 =?us-ascii?Q?MQrmxkr12I/cgH6YrgGWuxulOLUMHLZWXQSFUHQ7JFGK+UodDmYTz9QG9N+I?=
 =?us-ascii?Q?dmckjjXfwjbCCaL1h/G8pbqErxei4qnHyTKdVh/yxIwl31QxqYKmqFbwSIgl?=
 =?us-ascii?Q?rO7KvW+FDXY5w8vQnYY2NHkWY3HqkXE+ql7GtjuUQ1cehnUinz3HioJUqvob?=
 =?us-ascii?Q?ZADSF9LfdQ504GAx4eHWDm/5I+IqOW7dIBtvTanCfYbySmW8c9SfXpG9hj8K?=
 =?us-ascii?Q?tEfvBoMJAF9nTs5a6eUVUNaIe90IhUg6yUWsaHVO7togMUqR+I4ApmRGR6Ix?=
 =?us-ascii?Q?uRkn035gSsQ2vHlTYq2habGmUSUaOjPB2iagJWdSpM+znbINIQi8jMhD8vC6?=
 =?us-ascii?Q?yHSHPIeYslXQWQ7YxIhOKti6jijLDw1PvUlROaJRdZerDoRU0unvWSzTaJbd?=
 =?us-ascii?Q?nRodHN1yYYT0FwiWSO73p2Y10E3+u9cOlJkduytDR+5L2bgZc0XeIW7ausgr?=
 =?us-ascii?Q?fCf+xu6Gs2E/LOH6BfQmXPdc6PG/lUfAciw3wRDywjIuOe6xGMCDy0V69mg0?=
 =?us-ascii?Q?ryknG3O32C8y8RdKEjv9uxYULDdET3iwRx/C3es4rETMJN/ZhNRj4kH8t1bG?=
 =?us-ascii?Q?Kb43sgjQcS2a9XuMhKcb7BidWG1dx7FKRk7X4Pdm3g1GylrKON9yVqH96pF4?=
 =?us-ascii?Q?6osnyvi09TnFZDuWU772JlJ9p0VXTyYjYQUnRxRR22U7LmTyHuoiqw+LvvJp?=
 =?us-ascii?Q?yzvfc3YAClKJkMiPA2dLVC0hCfrZduZ7uvGlYsiLv8+dN6sjzZKe0Jy/SMdG?=
 =?us-ascii?Q?jOa0ehzBpy6rMgF2S2meuFiu6XDlYGNSWjFepL0EjYlRimToykMkRNBi9R6J?=
 =?us-ascii?Q?/er8Jr/98lOuNGZPmm2TmJ6QO2SzACwVUGOO8MGuvn1wrZYH9hr0XFrZeD//?=
 =?us-ascii?Q?ZRDJRLro0XYFQCtchFORThT3t6hS5JuvSESRpkNNUh/6ilYeAqaXKpqKPYYw?=
 =?us-ascii?Q?G/HuD0cBv9oFTp2hAHb653nWE1nWktvod3pSkbhb4+TR8eHye1KojkeSs2P9?=
 =?us-ascii?Q?pk1WL/tPQ58d4pP0i4psK25FFkN1RdMx7AvXkwZb3r8DpiT9ZdzjKKFAeNQ+?=
 =?us-ascii?Q?EImT44a7MG/OyH8aSFAufbLJvP4FnNZdCDWZRsDDDqIZeV8vyguughpTfeWA?=
 =?us-ascii?Q?feL9Iv3nCDuLTpxvdiUdcZ7TegJd5kjja0cdrfj6VJIokIsWWbDMfzMkaHNB?=
 =?us-ascii?Q?mHJiWa42QPS7GkjZ9OkeOAZOBjidESfRnF8jHirUnZQsssLgDHe7i7O68177?=
 =?us-ascii?Q?gRg5ldh7nnC9wVhKgBAr/7LXMvmR1dvkafXZg7P6DIYDhOmcMrHUYMSUtA4D?=
 =?us-ascii?Q?+CGlxRMsmP8KsNJjnTF6vdrkw0dI+vUl4rDPZlq/8ZZ+hro87VC7ZqfJ07oh?=
 =?us-ascii?Q?7y51BNpdjk41pS8vZALfzUj7/1tS3AOpcvUO5Smwqu6sMwY0zmWOmj4SqeWl?=
 =?us-ascii?Q?AbkEltQtzjQDEPVmgdXKciYx5G6nBmHAWny0w0N2F9jkxgMcfri7qPQ3BOm0?=
 =?us-ascii?Q?zEjluzNXs7LSmcmgvuerpK8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeb9145-5ffb-4a8a-01e0-08dde5fb8929
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:24:25.9747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eg9YFf/HddhQ/QRoaB466DIpgPerzQPRbKSqI/h6oK2qzF4/BMduLgyVHqgcPOC1SoMKwTaWbmnNLqME9/Gp10pZsuj/LLBrE+NCgHET4k/pUBI4VSyPtzLJyDnFvM8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5676
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

USB 3.1 node is enabled for Agilex5.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 2ab143e38f8..86e6d374948 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 #include "socfpga_agilex5.dtsi"
 
@@ -87,6 +88,10 @@
 	disable-over-current;
 };
 
+&usb31 {
+	status = "okay";
+};
+
 &watchdog0 {
 	status = "okay";
 };
-- 
2.35.3

