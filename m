Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE735EEF30C
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 06:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246C283F75;
	Thu,  5 Mar 2026 07:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="V4ec8cPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9061683F8A; Thu,  5 Mar 2026 06:58:21 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ABDE83F2E
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 06:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eN9sr14WvHL+7+7r/T5gltuSLmLMNnzv3tQZIa5CySENjLnF/4iWda9Z6o4E6iGqlC9Bwlm/nRKkUr8N4bn3ZWeq3bjA+K7VS9QSux4XreevdgOeQDhyEvuV3SmHEU4m9n9Uw6hioguqoT85kfTsFf7kT6GcgBYHPc7dC9Am4h5bXhI6mq7XQSKUyoNee69+mszc3dtHTq8jm+1/NfSpcPpiX0FzpmZRIoipI6oduoFJzr8aOIZWJhFZHm89Ld6axepbEMf4C4Zkq6R6OcRefmHfhqrdxUGWeQ9eAq3fHeKnFtR9B1eiWRpmrzfg/iRNO+OT4zarzD/jQWp+clMPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlqf4U6ZKfvHbBjQ2lQ/itsb5jl2LrS95Y5NHslmYOc=;
 b=Tmfql/4/3Bxx5yWziAZVEI8gr07hWykl0cqZbwzs4ryv9eL8hd8wjnQS1EMAYskaj3KjgIkWRTa6Wa0o+kcTwW2Y4tGhWv0wYu42kImFpzk95sUNxfQdRkqYBkXnRfkvH2jiwoF66Lt2rfAcaBjTQmjo+RTsHleXS4iWqVxxFgz2ayj/AHKJdeXXkBbNXyEyIzQzgvBsOgjELhEMrOxrEMJZRAIBpZHr2cps3oiF4qgOMqf6Fek7p+1UYSgYw1MttvqzlUn0oKIfjU5oDvhdzKmIbUlq9CVVyBQ0t1o7uKPihrYSrFv5pmfYdg8zOnBK+DOvPru9FdWW96ENFgRMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlqf4U6ZKfvHbBjQ2lQ/itsb5jl2LrS95Y5NHslmYOc=;
 b=V4ec8cPl6k23SO36ACXS+ssKDQIXY3yqauU4s2t6c3jReVstJxsQQ2Bk96jcjpZGyI+XuDRxEbu7xKMyma1KJdOGFkDHnReisvXS7RChKYhp4LBamKbLOZ+rhQjXvoN6dDuW2wfGH/3Q8zL38+Q9l1W+9ly12mkuDW8JeS3OkGi4y62Lv3xEOXj2O6EdUjUMAIQYLvcFbao/VE+5AExpYzwQ5xBTidf8WW79626hkWE2sD7hLT+Yn03Xb62kDebeuW4LQKLpQ5RoiIhQKs6oJeP0cpHv/xdiDvYD2LEcvpS38iTdAhJpJaWxGqLAdvmz2AQv02yEgH5ot8QNfzpr+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB6514.namprd03.prod.outlook.com (2603:10b6:806:1c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 05:58:15 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 05:58:15 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] configs: socfpga: arria10: Disable
 CONFIG_SPL_USE_TINY_PRINTF
Date: Thu,  5 Mar 2026 13:58:04 +0800
Message-ID: <20260305055804.21580-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::25) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA1PR03MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b82369b-0efb-466b-0275-08de7a7c3123
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: DMzGd/ZwQ1c0T3Gk3NqYfjC3ISqXcrm019vqgkuaJR6pe811+hWA3+/z6oXn9N1KWAW6MZ9gIWyOExaJfP0JL4CKjuFsQygtQ4DTvz4QB67AjIkDr52GUc7GVeR50biFyAUttaVEfVCJXMVIh7wHhhg543+pZ77DglGgwNKR9PtyEmHLcl5t6JqYF0ZR4QfthXlWUHMQc483cBD2uCmo1FO6kO88rABWEk+RsxetBZLzjlztF4MjbfqiEfftBHqKybvZATBUFM6yBM9eMy3beoYdxtx+nM4cw+F8lx38g1D+qMCmAzarqkZ1HAFY5HpTFaEccCf/J3Fn9Zbv+4B5MKUz8wTm9HfNHM4rR+ohzjTRsezU7m0O+LZzvZTAfEoTsTCtl/OS8VoKUP7l8wBeAxxFcRRNwoIi7yjM+PCFsUocnJ08dSmr9+hqF9nBUk20kRlT+753tG872f2hkkBmTvuSYa+TXngqSha3JEl/iWKd4e33Il+qh1dlb/EEc9Wjk8SPXexrKocbYlqw52QMNs5hb6VTLgZHVw3NB4gUVA5P6Gd99W6EaweM3Oi/q+O6z9qohS9Lqz8Vnb3NGH5g8YfXBBVTqfTZXtxffssw2TaJ2RrNSdhj+cKB9D86gDOmFsdSfRrr5eUVduy//P33JiRMPkUkoWoPnZThdho2WZGKVoWNuaZky+bWQ9aGqNrFizF0E+RSqfcVC9ie3p/x+zSspOhnEQ/nMTL4pYFhKLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6sPdeESPXycL+ceoAjNLvTZKmBce7z5hZzRzbW2KlNeAsiDklEAuPXo5zBG?=
 =?us-ascii?Q?PCrpbMkkHzbxSX0cnonpq01jNPZC8MqncFlmP7Bm8y9lb4Dmxs77fl9ePWGO?=
 =?us-ascii?Q?cnP+X2k8wn8id7Hnfg+Ve8PTVzsSQzPTwj0x3bl2W7u4simGLZulNOdFpMcq?=
 =?us-ascii?Q?OI0tB9pqxNXL160ca56pIj5+9TpCLoniFzRYUbmZsrMFnsQXF2UwswnNf7bC?=
 =?us-ascii?Q?Zf0q756RWW3X0OttdDm3EzQs5VHeDPoy9aDTwSbqSfiIkm0Ki7sDUmevCWRD?=
 =?us-ascii?Q?pDl2Fiw8bSoq+14xTunXxw11VW/FpmJdBxPwWmGhRzxhttxVgZYDLwaoONsi?=
 =?us-ascii?Q?A4dDkwRzqGvg0e+IcpRTT8K/RyXXuCYx8uEFrPs6XdwGkV4gO68M1e2uNx0a?=
 =?us-ascii?Q?VCtHmd+BnFrrrXetLBj6NoNY+lffjZrfHDl1xm9UYGW2uoNmhG6vRBopV4IQ?=
 =?us-ascii?Q?Vn3MZlMlXQeyklHeK8uoGjXlG8IivF1duoF8/M4cSny2iaATJhplp05HTanV?=
 =?us-ascii?Q?9TWmUB+nyKn/UfcVydEnh5qLrtBlyM8yA66FJb45h4sfq4IuFBGUP7hosj8H?=
 =?us-ascii?Q?wZ7SZHATHInfGsvODQQ4BxZbFmebi4Gx5up1S116xHiZX9hhVSzPER6kZ/gX?=
 =?us-ascii?Q?5iqzh+Qzjw4CQ0wLTensjRdeoWnuw33WNYNI4JdHtyXRQSU4LGrd4NI2Ag4d?=
 =?us-ascii?Q?AZQ+jXX3tqOwyTxSYjAJR3wMQAzTwecmsac8QCAl5Qv6U2DhGaMyrtk/J9mF?=
 =?us-ascii?Q?rLC8FKrPEVINfFFm0d5RzcTU6gwcRi+KpHBOCr9BS/h0iU/++fpOIupYATI+?=
 =?us-ascii?Q?CKe+XNaWrHDTWmrs/xkyGRlcT5BSdyV5cEBY6fDyetn43KnoRJDkVkXKNkWX?=
 =?us-ascii?Q?PdcyaYo51wqbku3PBR2DpIoEXE2Q0LyzCh+oLQvs2EgaNDD+om+vgy7oCR7k?=
 =?us-ascii?Q?I3oFw+petU+mwgh0IJTbKcr0IVYXSqwOMZLISnyo/v2Vky1VH2H85dFBC84a?=
 =?us-ascii?Q?hQkFhnedunhiibpdOp3QNm6RrgnNxeOwXudK6rb2C52QsL5fXJIwDKKBlqZE?=
 =?us-ascii?Q?qf6DrRyzcE0OPaFwjn8pTVfqjpnqwUCBztb7IgHyIYlgsqqWZfAW2Ubi6FUq?=
 =?us-ascii?Q?qHSZl9qtRaS/XfoefzJCkSn7ZQs9TQrxLCZj8UYqSIqkGTr8XVRicgWhoJSM?=
 =?us-ascii?Q?lOTD28VC2FMwVsOlMOm/zihFk4Ru08LA9iDu+qb5mo8KGJVUFcX27lsl3iUl?=
 =?us-ascii?Q?EDIqyfRoZO1JYn4IvmtVyk1WgR1zIQ/8spSXKKgjjcrS6w+rcxYvkqvkdUi6?=
 =?us-ascii?Q?B4XZv0efkOyTA5hlinylT4sP8rgsyzPMftgcgLOCfRA0s2dxL+ypzUJcwQni?=
 =?us-ascii?Q?3Q+Q9NycJgp8wqSdcdbHfuK0ZtHCydLyaUGn7e4vYTRB24qo+5BZjYkIy+Hj?=
 =?us-ascii?Q?h91Kqf7MkJxI84Zyu7Ty10+b+cJNpY+zlu/0g1Try8uX4o4L/p6edVU1Brlh?=
 =?us-ascii?Q?+mwSwT73yDs+R2ZTYYF94130086Sp4hEnD4W5L9knXicp9YVWN3uO0FjSWBC?=
 =?us-ascii?Q?BLC2qej8MfRmBS6xlcI5rahfXE7ghD6+jQOdnV9ZidHaKKCd8MI4vW0m4C0V?=
 =?us-ascii?Q?zy3HF90I/593SagANoRhFhK3277PT3YD9Qsx9zGQfiMN7xpLDL6h9NmaxEdJ?=
 =?us-ascii?Q?adyt0H94XUYPZHuHCYe7HCtGU9Z7rvHVmpe9vGl91HPnDlKDFdKGBovGtQ40?=
 =?us-ascii?Q?r2hmJUUCnEZYwdW4+ShQ5C52NP05rxY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b82369b-0efb-466b-0275-08de7a7c3123
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:58:15.6390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLJRZI8XfQsFFuifvSPtUl2sWAHpIAZImdR2EHC8kAAsbDVCvaknOQV9Wgz3beQlFm9YmOEOkIN5s/kDOpmZpS2TIA06yw3vCdXl72LOBkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6514
X-Mailman-Approved-At: Thu, 05 Mar 2026 07:39:36 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

CONFIG_SPL_USE_TINY_PRINTF is enabled by default, disable it.
Arria 10 has 256KB of onchip ram and it is enough to support full printf.
Full printf allows us to have more complex format printing, example %ll.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/Kconfig     | 1 -
 configs/socfpga_arria10_defconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..ba01ec08be2 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -101,7 +101,6 @@ config TARGET_SOCFPGA_ARRIA10
 	select SPL_SYSCON if SPL
 	select ETH_DESIGNWARE_SOCFPGA
 	imply FPGA_SOCFPGA
-	imply SPL_USE_TINY_PRINTF
 
 config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 	bool "Always reprogram Arria 10 FPGA"
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index b32f40ae408..74ec07cf3e4 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -69,3 +69,4 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 # CONFIG_SPL_WDT is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.43.7

