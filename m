Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7397CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 04:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 308148367A;
	Thu, 10 Jul 2025 06:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qB75xm/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2BC83653; Thu, 10 Jul 2025 06:39:46 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01FAC8360D
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 06:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mydnLZSlld5XHitmqJV5INbG7DjsxKhrjYbfc9Mqlj5deLpLOV4h3dbvnuaSz3GhUF6RK4++UwPUFAPZddU7cK1qKKsx179ZX1o9PrjFYDmCl06IJ7R3BBHda22QIZZz3QYMaO5cSo77Do5BBhBs0ApIDAokhmc/x6/R/2EwtnJHQLssT9oLKGhsXZWSVJ9c4yUKViRImPT8mBAwxUGbwd50cVdhoo/CBrQSN/A27FIB3lrcvQ/87AvCTlg6xaWcJQux/0fHApIJYvL6P7ppU+Ok2fApIsuQ/C41w+e5SOCofX2/9Oq3yut9oeW+xIS263VEOc+P7D3L2JJ+aXSjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrkoPNwlH5S+lwkLZzr7cmNlbdGeiYBDHgpJse3kEKA=;
 b=JIkmF5yJWMVBGCWzFKWH24AVQvJBtSy4BZI8FgpqZiLenOHpkbMT7siTiRdJgOc3RaLtFC3LepPu8GQSMb89bClh+r08uYpAZt5zGtnxyhKPgeTJSIBLS18+thqxh1i0Tl8Zcft+q8Z2QvQDYpnYPfUnECF0qUn7T/15sh79HJRR1TnD9MGMaYOv6cBMQS7MxKtQJ1TmAunRwNfQtnRI7gLC2v3hceyZbGJ67XX2RBEmcCUKP9MKXVY1YGpL2phOfUa2oH2cF60MJP5W+beZ0fa6HC3qC5EZhH2/IARbck/h0Bn3y+3Tne6wuJ7/Pvy3A2iwyqA/ei36BuxBApUUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrkoPNwlH5S+lwkLZzr7cmNlbdGeiYBDHgpJse3kEKA=;
 b=qB75xm/PGUUOG4X81fQzGAzcDERG6l3Cjc/TvSzSJYrJuKgJyNY6aVD9V9bnvdDQJ9cnCA7LEXcpKUbgw7FixG7uLRBz/0tZIB1Snh2UmVXK5WXEuOPTEqG6su3loF3OS0w+4c9B3xpnBAha3tuN4VNZgmv82tMbk5xhFQ3HKrm5T+MZGc2lhHz+hXI/7Rivc/y3eF9xkGVpiaHCozwiFRjTLpCbUO6gFtVmw7al5HME7YbrKXKxy+KYkhXqXfP1AO5nLtb8C5/c2vCHBJEjIUtn9BoCt4FOULnh3cGvvjIduQKuvzRzmfKbyp7aBVicLRYC1ZXDnbiGHQKOvqUsVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB7124.namprd03.prod.outlook.com (2603:10b6:806:33a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 04:39:39 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%4]) with mapi id 15.20.8857.036; Thu, 10 Jul 2025
 04:39:39 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: [PATCH] arch: arm: dts: agilex5: Set spi-max-freq to 50Mhz
Date: Thu, 10 Jul 2025 12:39:24 +0800
Message-Id: <20250710043924.90780-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA1PR03MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 37639dac-9f10-4d36-21f8-08ddbf6bc7ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xopi2EtRXFJFumrZkwSve6rKAwDETKw2BILlUgoD6wXWUwJe5hvFMWUXSdJt?=
 =?us-ascii?Q?EwNyuRh1PATW/lbsnXCIEbJI2noVtUF/AZUNboikM/Ztm93xc0Oa7aZmKBtX?=
 =?us-ascii?Q?W31jx19U4G6o4kHrGUonfBdpOm7bGGyygW98p7TGXAEDQxHYaWDvK9urSJnx?=
 =?us-ascii?Q?1tJkcdyyaaneJjAq+ugDKG1GtSKbl0KO5XlViANzHGFcJp/NIgxWpr4TX550?=
 =?us-ascii?Q?kes6MNvAc6pQ/zWXi5s4B6M5TfJYb/jQZ6m9AyZvQegrpK9bampMItOEmIFz?=
 =?us-ascii?Q?ckRuTk0doOqoLXdRGbaR5BxW+0famqT7nGspULiBmV/V4/lT5tNwCvCUz1SD?=
 =?us-ascii?Q?M6TpEyx1hVN75nUJvyPcsmrx04CrnB7npi46A+T9b/l0/B3XB5PH+EIfpvga?=
 =?us-ascii?Q?u3je4o+K1ns32FrQsQI2Lu1wox+idV35qVYXzbNUaTXYn8bFEcRxCUR1XwZr?=
 =?us-ascii?Q?ZGck3OKByxPPiygFgQsKKbWTPCSCZmveNrPwmoLaHHhCsSYlRZ9cN8hEAG6J?=
 =?us-ascii?Q?3XY0edy7vPoB4d+UKn0XknMnVJoKf4BLeWftljZSefjeU46/XnKqK6NokH0S?=
 =?us-ascii?Q?YZMDdoLWuCFE9dh9Wo/0ZGXrEQOojivIfaNlVTP95L3T0DpFQ0t911KcTOFq?=
 =?us-ascii?Q?KwoM2hPOHNZx9gArM0k4mzbwN7P2ugtxtQNqljpxZ1yYNZPXh37di9SjPYs9?=
 =?us-ascii?Q?2haBCEA4hCAWyz2kQlIbvNcOL5xu6RYts+N6sM5NtYkxSUFS8VEm9/9qzqV4?=
 =?us-ascii?Q?i6fg5Hrvco9lY68Mf8AYf617GpDaBQLQ3TVZ6y5WOthpJw7soxZxPY8rUsWw?=
 =?us-ascii?Q?ZomeTVCxhIluX4RYQhwGl6PquyspE00oUW67ItdmMV++7oP2BIvdrqi2N0ti?=
 =?us-ascii?Q?JAyaYL9lyJ0LvpxzDSNrEv57OuvnMP/ZFu0n1XhhoPaOMeQCsR9m/4mP8m3A?=
 =?us-ascii?Q?Z5BCIunHjKUe+p7WUkEMC7PGAk+jP1LCX5QkFPniL6VoDJpUxuVRClJ2KcQt?=
 =?us-ascii?Q?IZajxvc3OqqWAUGx+TW0ET5s3FmRVXy0h2XU6hh1djyTvn5YKsC4KQGFoKGe?=
 =?us-ascii?Q?XKCW0ApT0z/52g735pdwmESAH2GvT+XevIxNXQ3GOSHS16hc+Pg03v4Ns+ii?=
 =?us-ascii?Q?qicQBwTbXqHpcJ9hJkGvzzGonsz0mkiXs5bj6Wp4nlK0bQV3PjfWQhiaHf2Z?=
 =?us-ascii?Q?ds7ELiLzBeW5g4x74Me6DlQ4be7EO84xdD8z19Th73NgwZWXqMIF8fwt/w7u?=
 =?us-ascii?Q?mTD53S4aSnQgkqZ9Lc43lDGsvY4KCpY2EbKB3xz9U94G2uhptJeNS0GIrOD1?=
 =?us-ascii?Q?uLr+5ermCQKMOcWb7jSo1+f/cpzmS1+ue7Da1lZi9yUIm/LLg/SzZavlcL/P?=
 =?us-ascii?Q?tBg0WPQ/2X2yhgEoboLf/lE9aU060BJe176yPom7p/sS+AFUVKW4DoEwFzOq?=
 =?us-ascii?Q?Kkg5kPLvNiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZFcoc+9iu1nIZ/UL2wM4jXroR3Dgj/Y/qYqF6GcXKYCeQzfblJyiaCjwggp?=
 =?us-ascii?Q?eXYfkUleaXSgsPAWTEZeUeOuaONVUtMleDEj7SRxiOjW6yT+z4BLWHlly5qd?=
 =?us-ascii?Q?QYEqAljxrPOl7I/5RZkijhJyVvsOp9CEgYjqpQpQCg5FoGz6O7fnoohpptCo?=
 =?us-ascii?Q?bnxxdbYjqAoNjL6VSaU78v6JRbwJfjAiXx9ilAdmxtJ5cFixnhV8A63gJ5lZ?=
 =?us-ascii?Q?LdhxexX7MjDR9DiPwVdsYEOvtA+1932IZXBuso0gYsNBD17WvEnkXwwdpcEO?=
 =?us-ascii?Q?NKD6nBb7IXVyUR7ZlIx1XA/Tvf3gpa+ydrwtxMo17x5T9YDmqwKw1WIaP/i1?=
 =?us-ascii?Q?4UY25NOJMmRSSMnOhlNoKV2YSNbxT6grCoENBxAzJmaywBmP/eDJzsb200GB?=
 =?us-ascii?Q?8GTTw4xciB1XL1JRt9g9GzW1ij10SVRWAdF0dA+J6ddJgD6sWmdMhCjPrnyf?=
 =?us-ascii?Q?Usb0aXgABe3lygw4adUHyKyYdobSDisdMs3A+OuIvlg7mWrFX+H2lQSvPpon?=
 =?us-ascii?Q?e7q9p4bXrG/Ksw+csBKGMS+nmJVcrEJsCfGG7hztpfYXbL8LdBANkp+tRC/F?=
 =?us-ascii?Q?1OZ+nLdFAD3JgChH8r/HrEqLx8ffDQMGghqsLHpYkPrt3ZEP4j/1Gbf72VLn?=
 =?us-ascii?Q?Jhg4+RsZHAKQi9JC9dI59mgopdMGAc82T6Dvue09p6QAs92G/MrgCa5cJkWa?=
 =?us-ascii?Q?FxY9cAmcifuOs71gDuMi9t1mOcvO0zRR5m6JhjoOiJ8bw03Klz2TJMcU07kL?=
 =?us-ascii?Q?fr0BsTVEw7CM1r/5QuNs3k5tY52fc2iSFAUCPOVYBWSsbwR3Dzjng6C2V5Nx?=
 =?us-ascii?Q?YBSiBS6kuXhhjoUMR80m0y2mTzGD00yCgGu3Mp6e2YTeLoUo4b7Rh+vcvRS0?=
 =?us-ascii?Q?qfNwIFtDkuYnE+RPnhEb2lkWGye9dqP9dKWPBWIAe/PvItKb7plb0g7gu6YC?=
 =?us-ascii?Q?qQE4arCwXbYWjsYj3YXhPJZ/fDH60od+r7QuUEyuLnKsZjyEa62VKQsoEqIa?=
 =?us-ascii?Q?tVwYl8rigqi40nXKPUNXnCdcZVkvX+Ux5Fes/0+fZuAU+tfK0kGqGlcwurYq?=
 =?us-ascii?Q?cHug7zui49XQMLEraHgkjSZFmXS8zwKc1lNEiSelczgdWyHau7Nh1b2Tt1RX?=
 =?us-ascii?Q?7/SdIC9kFjVKHF29fqdSr+rmY3fUYlH543CpMD16aDW4ChLQ94qzjmvBR+8J?=
 =?us-ascii?Q?IM3tEaTJ1+jde6l4+DxAU1orI5FXAEHlnwDiliR6rRNxv7g+c/+hc2AvF5j0?=
 =?us-ascii?Q?IIfQ0SX/gmVR7t+JgSlbNG8cSv2zUzKk/qvxuWpHkdTqrbOMGwrvsLc4BRPg?=
 =?us-ascii?Q?Ts0CPLwSaDqH4n+bIznKTEhKU4D681PQVQbZ4/vfVrC6VMPjpaWSK/qbfohe?=
 =?us-ascii?Q?wF/nSlKUMsCSCX+YeAiQiMlkumyb5iIXFN7MSg+4DidEuY1Hrzk7gNnAxxj2?=
 =?us-ascii?Q?sESAgr5fSsK51TVjwOM1HyqgjCUG7ZA6ZjRa2VyxZhn0y7jlIYiJazv9L+PT?=
 =?us-ascii?Q?KVx73aNEEXADzyBHIy0ljChpYgOmWy4ZpZ/wz3F5XKJ6s1L3fREQAgcoXQsV?=
 =?us-ascii?Q?wCs7tlIGdjBodDLLK1tD1+a6oZbunZMBbrj50ybnxuRBp0m4Dz9Go2jBfdq9?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37639dac-9f10-4d36-21f8-08ddbf6bc7ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 04:39:39.5027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LLOXJBsQ+u8YzEsKPaCGieLmaQOMvxwXL9br73I6CVylAuGYAuRJKFil++rcj0ObPYj/YyEtjCOxeUB0Bl/ncOZvd438VN3QzG2SDCm5OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7124
X-Mailman-Approved-At: Thu, 10 Jul 2025 06:59:20 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

This patch is to set spi-max-freq to 50Mhz. This will add support to the
driver to set the operation speed according to the slave device up to
50Mhz. Without this node, the driver just can adjust the operation speed
to the default speed which is far below the best
operation speed of the SPI slave device.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 arch/arm/dts/socfpga_agilex5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agilex5.dtsi
index 86322d7b0ce..9bc3864022b 100644
--- a/arch/arm/dts/socfpga_agilex5.dtsi
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -388,6 +388,7 @@
 			reg-io-width = <4>;
 			num-cs = <4>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>;
+			spi-max-frequency = <50000000>;
 			status = "disabled";
 		};
 
@@ -402,6 +403,7 @@
 			reg-io-width = <4>;
 			num-cs = <4>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>;
+			spi-max-frequency = <50000000>;
 			status = "disabled";
 		};
 
-- 
2.35.3

