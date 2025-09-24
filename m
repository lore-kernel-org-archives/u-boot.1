Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E332BCAC5A7
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 07:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D7C83447;
	Wed, 24 Sep 2025 09:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cjf8Bulr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2781E83526; Wed, 24 Sep 2025 09:50:21 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223DC833ED
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzermIGLxvYjowhbM/CvUnOz/SwXeU8Qwic7RgvY8i4/JXdvhy5cxmnRmRQZPQYOmzsj8q3E+RO6LlmpWGwwCBhsRGdpi+Wet7xuFc9OV1smG5VkGjdJCC4YN8j/dW3ezkEweCLFJrpW73R0MA/47e9QpHAvNqhCU6fL/rJ3Pm4pjmukJWs657MJIWKRj1oEkNJ00rgnGLRRGRAHjqeHDagJuLgqLZx7SaJv7XcX/7BJF5mRFLOAwRc62wyMRDIHOBQt/1n0QTno4eGfDXCvFY8lencuKFWnTFh0BDdafX2pQwjyB4RPn703Tz1GELBpWUuq8N+XlW8nfqOFD5qXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlIQl+07N2IbwQTFrIUU+0Bi9dwA/mj6wNLze7f8Ub4=;
 b=dWqGhk9YTfdbcuIXeNurtwIM5H6ZxtJh4bQCjw4G8/uuqFNjNe31YuZJU0SDP2Ip6JGVh0gU7QanH+bWFBCK5MiDOJjbtO7Hw8S1nxqv9/Qv3zR4brSpy1GSFfHy2PWtOXdLiGgSNqk5WPjMfbUH1nVSAFyFKRD71oL/2t/aSBYe3StdM442vvAeBwaI16+7Dg01x+YVgTH/buGZLl79845H8zx2FXJgUM+afqJSbsTSto6n0uOqry3LmL5GKee5F2Srxnfa2fBYHNF7/Ocu1IGiwiT+8aU81E0InTmOPq6RM09cVwkmUND+gr/Gq3fC8UeVLzQ3i5tV7eST4jNNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlIQl+07N2IbwQTFrIUU+0Bi9dwA/mj6wNLze7f8Ub4=;
 b=cjf8Bulr2WdIW07uhC30siyQbsAUyMA99l0WTax2AqcfcqbcV9vSCw7HrUQz6Oi/uHnE7+4lhK0S5Uf67GWrZXF9H2YrRrdsp44TkveHOjh03XI0wa2x5W6Mpamw3QvKuM3NfVjU+HBYvAmjCYUxFeLU9gaMg0QcOg4oG0BPwl6H14O+yfCtYvW9nSMM4xMI3Cla4lYifI1JMGLN/yPvreXYvqhAdky295sNkP2syg7ObSllskRIKk3m+O1QSaKHa0HeRT+CUJFMgop1WWlaInSNmnx4QIEJE4VvTaEbprVDOWZ1qwMh0MPYSjrCHU/5AigdBiQcFdywD1G+qAhRXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 07:50:09 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:50:08 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v4 3/4] configs: Increase USB Hub debounce timeout in Agilex5
Date: Wed, 24 Sep 2025 00:49:10 -0700
Message-Id: <20250924074911.15538-4-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
References: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d2fac4-d459-4ac6-9756-08ddfb3efbc2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OKghZn76JLLOWooMvmcQQzF1OxX6EfS7VyB1NZNCHU1hFDwo4gCyqqO6QepW?=
 =?us-ascii?Q?yiCf89jN7/wFwn6at9AX1bDUxX5T/46LAHkPri6i1BYfVUxnFwJdYq71brZO?=
 =?us-ascii?Q?2VeHZhx3V4jSAw+5oeeX1tjwyxZQpwX3/dXZwPA8D1x7tmjrjLkibi5VXfTe?=
 =?us-ascii?Q?QZvSeAybUOQpu3LfoxtZJt37CPmSZQE8Bo5Bpd7jWSDDbX2VytCZhBnH5Z0m?=
 =?us-ascii?Q?Mw7j7XUhWjXNgAuKWBfnS2AlMMZZmkadTOabMhzG2hN2jPa/cNaLPwbOITQ6?=
 =?us-ascii?Q?DqQkRf8a78ubhzi3yJDJ4U18r8MScgr9SA/GQSAXcTy5pbp/IyGwAOnVTDX4?=
 =?us-ascii?Q?/6oGACDcEUesvKCCwrgWR76VMwZKp/OuQy8H6IGt1UfqDvn2isksWDABWnrW?=
 =?us-ascii?Q?P0m/e1hBMAty26IshZlP33PZz7rs04GiDlMC6P6MwfxqmODZDb21UgKWzmX9?=
 =?us-ascii?Q?ZAVTJISHe8bVa68uCaqNf2GxuFuS3oDPBVtDaTuF4FVo3ZKI+/33kLCyr4uP?=
 =?us-ascii?Q?OVKhtPSrHbKxQ0l+TdU722akUVoZVInnzGeWXaQ8HKITZ+CTsli1yVv3xSCH?=
 =?us-ascii?Q?EYUd8iyqNqILcRX86+Fz8VIpg+C98m09rFtTkiyv8zIhmfZ7mwV77uA6z3/i?=
 =?us-ascii?Q?emwyE7F//+Z4p6x1b2ESqpQeyVVIDJQ+Fc9Zf+UnAN3QmdqAiy8MH57S56Bo?=
 =?us-ascii?Q?gJXItcw2ZkgJK9FgGnIpHRMZScGeS7FFmnLqUrL5r07XnyIr0OwMYi7/8icn?=
 =?us-ascii?Q?bACcrciVfCcDwcUP4FkQbj+Nw6BQ+dmB/w5upWpfR+ezIm6klZOsgbEoatcV?=
 =?us-ascii?Q?ubyrIpc0+0f24pj86fddulywQEfiRh4Us1Ha5WJGpl00ucutRnliotLWvPym?=
 =?us-ascii?Q?f4Z5B7qCjsrU5CSBOO2+Keyg/5usxVcMs9BBl6H8S+Pt3EIZv/jnx0boPqNB?=
 =?us-ascii?Q?xJ64SKAew0riRJyb5apucdX9CvwDBqzvmbk8nqqsKiCCal0+zIw4L6tVWDSp?=
 =?us-ascii?Q?3DVAp+CHZv/YsEdXx+QfQ8bNzkkSMelZ4tnwzmWZoCVOyANoBM9CVDSE18/b?=
 =?us-ascii?Q?RuWdFCil5I2z6OgtKRghmN8QffAhk+XPJH9uFQfAHgGDz5y6V+d73DXaclmc?=
 =?us-ascii?Q?55bQt8VfyxIyzwF2fEsrSnFqgMUrxag6PVhjJtdHc57hWMhj/DLCewetUPj1?=
 =?us-ascii?Q?6dilMsrWP7EchL+l3O5s4SWE6rq7QyJWWA4vNLPpUdPF2DQGLJx5SIu9jAze?=
 =?us-ascii?Q?fqftiAYt0sdN89aRGaOYLoRiz0lmPg2xRyUapvpQphf9QSzKObwK8+tlJgeg?=
 =?us-ascii?Q?vO/t8jWgaWwyjZ6/+AWH0vF0jEKOavNYTnL8BgJL+jVnuwmogwNLiwfjMhyP?=
 =?us-ascii?Q?AgazMl2CCxuYUj+HRjIK0I8GWXqnZh5LzgYnFLPi2mC0ieqLhDFtbd1ZW/a6?=
 =?us-ascii?Q?I4vIKUGqAjI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mEIancJ0sQqeKIoR85AyB7w51KFe7Ejas5iUvYfIiZv4I+T14tDl2Ny1DJG2?=
 =?us-ascii?Q?xsIPVnXIaCkKX2Be8A8HQaURUN3Vd/kpFcrAm36eJdYjecsCi7s/TLv6OsI4?=
 =?us-ascii?Q?5VllDikTRF5RgZufSdqOnfY+zS2USf4GViRtNOXIwVeyFVHC64rH6iWpVByd?=
 =?us-ascii?Q?kJoNXZLjFEUvOQqxElfJQMkVP0Eyfs+wXiuOLbXnXEVzM86w4ChnOuJn+ABb?=
 =?us-ascii?Q?CFMAEG9Gna7O+wwIYODrSnb2Ie6L+dWPn3HaYopJEwoZNt5f92rbUo7ErHpX?=
 =?us-ascii?Q?wBGu86sgxk7JBjrDA4jjVxWVmVZFSHpFJOuqVfS5nf73dZ8nZXx6zzgBX4oe?=
 =?us-ascii?Q?QBsqVodWtINuZwtFzJExgzkw9FkVJJxHjTsT1LwNdYwbxYk2yRe6vpxMQn6h?=
 =?us-ascii?Q?/6/lu3mzCVgUSj8ao5qCaGxMWiLTX1OrgBI/yS6UMrB7j2NzWu4FRYqbS2i6?=
 =?us-ascii?Q?k4OEr5c4v1HXL8Ix86e/mdRdyZG1BqWLmQSrsK2iVe304Wj9yqnl6Vt9m6Dk?=
 =?us-ascii?Q?URiacSW1bfZ1PENezAKvE1Wbc8s7zw9SnGsmjohgYz9rbv3xjzEkMUn5ajU5?=
 =?us-ascii?Q?z0o39yBR4A0JXofqQqD0ToZgjJbtrJ2snEHbDVd9DXNQgABcz1junOQ/PRxv?=
 =?us-ascii?Q?8O9JgC1NqQ2Mno9afboZQweGA/I2e3J1pu1d88pniV3jF3Fna9Ll5MttgqrA?=
 =?us-ascii?Q?GsEdYZ1lNZK3YEb+7CsljzrGfG2ZB4nTgvni5Oe7NqnOmXrMwXXJczwSLAuv?=
 =?us-ascii?Q?tmknRexU1TMOnLWlY01140UHGFctKfO/Vgm/GlZ+0Nk0oTynbD+x8RjWs3J/?=
 =?us-ascii?Q?EcD0/345i8EVSeofZ07soaiulnEB4ELyv9GTuSvk5vHmoQUVFUTUOyo9cquR?=
 =?us-ascii?Q?d+pMEv1awiBM6WhGyDrF5dIibG2CLf8gQxzhYK0mLMc047UhzhG1rAxmy7R6?=
 =?us-ascii?Q?I8Qy/BSuAL14Ap3sWoNp5vTpIaLeHHHdb6MBG09At0eZRng3vrJI4W9yBm6q?=
 =?us-ascii?Q?sXhxXqRhyhLqabH23nVzazF0kccDZWuOEr/dGq3d+yJDFjnsxWgPZKqki/Hz?=
 =?us-ascii?Q?JCgcQFy9rZAD1uMaGm9X2cXPcKubIKKijNt6sES+mCQI63RSo4U7bTH0FZrR?=
 =?us-ascii?Q?TCiJjXJi/AgZhIwnajyYdzNwRyRBNBHB4mGodWCqCP8g/ThyJWy9MUWqgWVy?=
 =?us-ascii?Q?ApUhSAe1MRXKZsF0ImNlUGlsQZahp1Ooj64g1/a17nm2DErVNuxQWkMJ1P4u?=
 =?us-ascii?Q?Gz+NC71c1M87L9GD4NnOzK+d5KK8hnEpO4xPwA7weKsCfyOblICMmjUo0GOf?=
 =?us-ascii?Q?t99A6iylbbaX+2UecfYJo1Pjdx4P+hp9X1xrqAtm3rKwAGF7YtRYPRII+g7l?=
 =?us-ascii?Q?RzFrfYsuh3vS5lCTqWrsfSNTw7cxETJwvlK2GVKKndqUFi9c9LUtBLex3yjn?=
 =?us-ascii?Q?/VHAhu9yiGqf+bKxxc7xuEktslEij3DZzIPtaook1koDgsuUYRsrtqt30FFw?=
 =?us-ascii?Q?8IWb/uuHLQf8HvxztlSCL20+kc0NB9l/iG/GbT6CTPVrdZBuyQcp5KiCUhoR?=
 =?us-ascii?Q?t8VNoyilf6jjxeFkgIc3/uDvF4+47H1CrNmzQuDUnWMdLdj4SD54pbFX155N?=
 =?us-ascii?Q?d3syGc62ToXUSt6cpMhBS8c=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d2fac4-d459-4ac6-9756-08ddfb3efbc2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:50:08.9294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhKYD3JZq2v8WPEOm0K3TOSdB20rCwwN0yntrFzS9x+2Au+6qgiioxHnl5E5RZTLPrD6bOzzeZxcxM4Lh82J565ssOwEUToCGWWOXTCjtL4ifPFyKd1C0jNtO64+6AO/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
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

Some legacy USB mass storage devices during connection were
observed to have debounce issues. Hence, increasing the default
USB Hub debounce timeout value to handle this issue for devices
connected to Agilex5 boards.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 7cd2fcbf4ac..69be3bf79d0 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -104,6 +104,7 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=3000
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.35.3

