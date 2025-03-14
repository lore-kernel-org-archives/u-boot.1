Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E90C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 11:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBC08197F;
	Fri, 14 Mar 2025 12:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tIkBzNy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9B78198F; Fri, 14 Mar 2025 12:59:15 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3D481760
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL0bNdbTsqoPAVsPgru93XdOph7P9MlLNDF7eF2SLLHUdmARPfwXeMErQB8KdQJ1/hA4chmkemgUYp8Rr9/CAPVNneMDD1cVW2/lv3ONBcKtrJNoyDbc8ARPyvlu27fEVrAnz1WrST7nLjpB7zyMUXQcONqAXHCRe5QiY9DNCXpQyr6z0o1n+OnTXalja0KDy8s4OX5eaakgRU6CeJ56a+pRUOzPgO4EwNpg7QlSaVE43CdzTmN7H4wSQwxZ+1gXZwMZm9whSVwwuGToxDPmUiVsrzAEU3Tw9SDHBSGvQjUIJlojU78n7q1fDV0E3mF1o+AWDP1LLPKcfheE9seVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrlbMcIXeyfP4Rb6EBOiXU6V+2mxg9MIpRVK9Ud13CQ=;
 b=CM9PLo5xncjKu9O1KoJsKF7eLjxb+VPWmieYRzZbe7NjLPIK3llhA0+dnaug45X3CNo2lr/fYMVQ443PTg51u6c8lzOhzfNYv/NM4DEZTM8nSevHg1UK4Nw+Y3QwuCy8COfByRAIlHuJX+Cgg8li9io2vshNl9EqXK/YGMc73D3n/PmckL7Rq9dvtLTRqYV0ulzSmqAGVG1p/3Wck3nFykWC0QZ+oobtZkSiUby4Lx/RK46qqLRVZ2GXqRKr9DmG/eeIJiMf+jBojvMzDRc+TcmTphyILf6iw6fLEm7QTA/D3mgyurrlroClzZQKonasttpfjYfXbVly/4qefRNYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrlbMcIXeyfP4Rb6EBOiXU6V+2mxg9MIpRVK9Ud13CQ=;
 b=tIkBzNy0YQeBw9K/q84gutDLM1NA4y0X68fystodormg/X3Ujbf232Kl6ZCsdlwHrRz9SJfwbtvMTmKaR+/PTxXfjFjCwRVYefXE7cLVqfhIJGlm2esozxOiy2UrsGwvlyRbDbMK/Nftr3mLTTWHtfBNyFrrObWkdsqk9RfNVnttyiukOlLAs/eHC5Ypz7Bg7O00FOsF3iqyw/381ITzySVvXm/A1v6VbS55VFmp54p1uOu9QN7jLO+NT+7izIhVfpgtAL4ChkvFKGuo8MwePDEp+6QXRGPuB4zdGpQZMMJQUJhcjgxJRkfYMjpYYTajYt/X3qt4YCcLQLy9SM98tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6921.namprd03.prod.outlook.com (2603:10b6:303:1b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 11:59:06 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 11:59:06 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] configs: Enable partial reconfiguration support for Stratix10
Date: Fri, 14 Mar 2025 04:59:02 -0700
Message-Id: <20250314115902.5702-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|MW4PR03MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: c78a74b1-bc02-42cb-2230-08dd62ef9f34
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C0vkEonMox4yq1v/BfWxZOuGi/CUcaZSbhzdJ94DXkNxHROgcUg8zN9Fy5YV?=
 =?us-ascii?Q?WV32HjUFNJG5bgkmlUs/uFauomEELucAznQxnYyc5LtJ8Qcd8pcD8HJGcoB9?=
 =?us-ascii?Q?nxTC/HmQOFT5DhMqjaswLE1cHr6wQqKDcKGxxKyWHeMCKE5cZpDJo7jzRsyK?=
 =?us-ascii?Q?e1ZdnvC1OSg1ZwdjpjXUE5FcUtLcWurESMpBfXqFFGStg+fWpxfgZEtw6b7P?=
 =?us-ascii?Q?qUjIJ8HNGO5YWeghmwIoHMMYQ3oJ0Ruxqv7HYKMrXCYH4vrePDSVl0aTcpjr?=
 =?us-ascii?Q?OmaNiGy//VcmTpA0o6cSH3dTaWB0+1XZ2JXNeerxTTLgFjCfiAkqTcwg8wTf?=
 =?us-ascii?Q?JxDFuPRgb2gvVVAfNSIA1h2kl6VNy9gdh5G55eIDRGetR2fLrmROGesOkqMx?=
 =?us-ascii?Q?QGpeBZk0zCVy1zijsZaUvjNPE3m1av7uL9zls2H9mSTkkO3w4cj4rjGHi4cz?=
 =?us-ascii?Q?e3Qrdn+vKLXCl4ASWAYB4SQTPELcsF/Pbni8Uf+xOJXtT9VNTXTVZs/C+ltS?=
 =?us-ascii?Q?G5yuReTPX5P1+Tvf1G4Zwsn+bRt4g5NdOA1qEBSvT7hmPQ1ejjElmkSxW5fa?=
 =?us-ascii?Q?Vp0I2u4OXH3fRakOHZ4LaT+krajiZMsM3UtF9W4jA444Pyysxdle2xumMUGm?=
 =?us-ascii?Q?D2rCmMegsA7SAAT+6eTHvwD0uzB7PXsFYqpZNT/Cvg1mJBgIEMCjocKUhne/?=
 =?us-ascii?Q?WkRPyGFnaQ0eE1tpocY3dqnOxOc6VvDtm5zmp/K3REiw42PxV/gW0whPFYRx?=
 =?us-ascii?Q?NSfPRI9UGqchK7jZnrltlAIjlA+3lsVTclr5qvscph0Gva1fHd1coAdYmoSM?=
 =?us-ascii?Q?0XFkB2UN9mfiKbefsodIOz/c1Khb6ipEbPMi8HjKBSksztQzXDWPy4UXfQ69?=
 =?us-ascii?Q?0FNvOnVLSBpD9VKFZg1X5WC+Ao65y2mFc3r7c9fdtjLAQ+Ng1giiN86FEoj1?=
 =?us-ascii?Q?yf9jIOVfs0+ozdxgkJPdF3qAz/dgyfIUgkkTmpuG1T19RGFyOXuqCKu6XKJw?=
 =?us-ascii?Q?8gNCgwizca9jmTkXnjsgkCYees1eLla6rzmdJwUopZo/+vspTZeKzYjXp544?=
 =?us-ascii?Q?0SigMmgfgAIj8BHIXcWKFMOhPM+fN7JA4ExLrpp3yRlUH0F1oUdwhAfa3FrX?=
 =?us-ascii?Q?wz8nTwr48/xVTpC+tdp5eTEqsSBZRg6/x/NFIssmx8GfRnwWY2YHnwWfsRm2?=
 =?us-ascii?Q?6cGm9or+W+/donW4gFkM+0ozNlZlQgSykOmMSHL5wkW7hOoVFpomex+1BvMH?=
 =?us-ascii?Q?ITLWxFeDo4R09XcnAbQ/hwj4RDP6ffzexRQ1YET7jOfOhmuGNhrOuuaNdqLy?=
 =?us-ascii?Q?CEZHyH72x3cKdEZv3jetpCXd1iq38y4tyaAx03Re4fU4B9Vu5GPzN109fFQf?=
 =?us-ascii?Q?ijQCUow2fT2WAxDpGv8jlXyFSEFF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mJeqOqv8wbiHxueDjPzGH2AU+ry1FHcO1X2GObSWOypqQqbLeZ8pNJISwhJY?=
 =?us-ascii?Q?R+weQkShWrH5St82GcF0aHthfvSkn+VAX9NWuU9bFyOmS5P6f8VOYb1QUOeH?=
 =?us-ascii?Q?M4G7zrHTpLwSr3Fle/TIQkyRoBNCiigDdpGsY0cBTDLTYcsY4Jppb0p3CCnv?=
 =?us-ascii?Q?jemMoFc5Q7qKTN7H6suK0cz0ypHvp8jFCECKWYGQz7e+Am17nNCrjEhfKMYO?=
 =?us-ascii?Q?uQCsYlXkE1xLfr8GDAr8VaS2jh4UfT1yJj8aO4wv7tika+46cUBuFlkESzvi?=
 =?us-ascii?Q?Rvw4d2t/3KHtzDBmb1O8awbnDrVZ/MkNmgxEw3p9BP6a87i53KGDqD7hjK//?=
 =?us-ascii?Q?r9jIGa0JtGmFJcD9GJ4rjuAoKoeZVhg1ajTMSC9pSouavwW52YqWxZyF5qxI?=
 =?us-ascii?Q?8qediVb5dFE3q++XsUnw/b3BiXwisqPJc96yXOBTv3gjg3P9zcyf9Pzd2Yfj?=
 =?us-ascii?Q?X64C/ZmevOV48UGmCEY375+WJhQ2GZdQ2DEwisnjqX3FVxjz8cYxcu/24qXj?=
 =?us-ascii?Q?SUWV1hEDljniQIQkqb51eXioFAoDW26Xk/po6TB9sZbghsR/1I++luaOPzJu?=
 =?us-ascii?Q?p2yprgVm7Mq31tZaNZRD0Qk1clbzrPJRMUBf6KdO86E+i3YjOabnuVTbFi1w?=
 =?us-ascii?Q?hQsabSkCVZA7sH+mQDwKnZbyiM2TJ9V6h/hKWwj79hELIq+sbYQtWHuelSix?=
 =?us-ascii?Q?m56pkCwpzQTy5SWdgtjH9LC1NqSCCw3mc5ucqoxA/Twr5lsYoAFWlYos0RwV?=
 =?us-ascii?Q?9yixHkFym5HrpT2r5CIvmMKAHYQAXJkX1oJj5UDf7iJTeU9gs7ul4kMZTRGm?=
 =?us-ascii?Q?lxuNBQTMO5BJ6RT7cpaxAieDr+gCHWfjJLhveVDwiotbk+qKwS9VkvGivwKO?=
 =?us-ascii?Q?0KPgKi426M6XXrAeG+8eTsI8rKEifXUQuMU3EpepRSKYl1Z2mwhiAlgFHui7?=
 =?us-ascii?Q?wUTPIjfFxaCXbjqqImkqiqodMHfR4r1Klw+kY9fTwZPF+SEZMde5MAtxLH5w?=
 =?us-ascii?Q?a1s2MpLRkMDZtuBnrLvAKthylwc35P44HYTvsSymNjjnksDP06G5kdiuTdVQ?=
 =?us-ascii?Q?vt8L3kxLJNQQAqbc2QN4/YKePMdLKRuLbJGo37DenTLNlyWyhTCQnIdc7REm?=
 =?us-ascii?Q?YP0tPobmgdORcWBNkiByzpVx0KFDRQKgTVxy+BXdr+kSYCjtfAVwgeylH0OC?=
 =?us-ascii?Q?08eK/kenoKMurg3liYuby+u2KNjy1fJVwt0cfiG/atZ4l80S4lHrADMUoST0?=
 =?us-ascii?Q?8KmJ8P8IMjjrJCDMff5hzMUh78RslwQVj6vGajYFVERpCtT2Y8dBgpxbQilI?=
 =?us-ascii?Q?0lkWJMg8W19Kj8MydzL0MICaL8BimXIe5yUs/Vp8B4GYQMpO2CmYSbJeKfa6?=
 =?us-ascii?Q?QRlj8ZC8eUpj+JjDL9o50oCJ2POOtMkIjQIBK2UZuWyJCawCKgp5HsxbcTmg?=
 =?us-ascii?Q?t/L68StXqv4agnRu0ayXKblYomED5R1sxIF0oA+RHaGvGbjFqQSIh1nuTIk1?=
 =?us-ascii?Q?03MgrmKAAf2iaCk+aWfHR7GmxTXphl8Xf4I9ksbQ0eaRahPdWYJfkU5y/wEf?=
 =?us-ascii?Q?hBHZuhGwy15k7oycgUj7Amt7UQyJnbtXXmQAJUS3Hvzlc+Pe6s8gF1esDHas?=
 =?us-ascii?Q?WIaPWYA8dgm7m1meeIxg5+U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78a74b1-bc02-42cb-2230-08dd62ef9f34
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:59:06.5588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVGD9j5nRxnX635OCRZERpY6to75X9P1LpdB6jqU4zkphW86J+jVC72BwzkR9Tk5DtBoe2u8gSmkgN5iZG3JMKnamGOvzHeAfFdbfpTbuOJ9ssNhii3fVKIP9jdkOQfw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6921
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

Intel partial reconfiguration driver is enabled by default for
Stratix10 SocFPGA boards.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_stratix10_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 3ea8259847..ff8a74be48 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -66,6 +66,7 @@ CONFIG_BOOTFILE="Image"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_ALTERA_SDRAM=y
+CONFIG_FPGA_INTEL_PR=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-- 
2.35.3

