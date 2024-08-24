Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9560C5472C
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0A0888D5;
	Sat, 24 Aug 2024 11:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uOwipLEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A3CB888C1; Sat, 24 Aug 2024 11:27:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B1D688C97
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh7+MYLBX+PfV1dNwt2O4aAiuSOUjvI6LrmQXDObZiYlJdB18JngcfTtwvcs7YEAixdNE4DrC/DQcXeV17/bsW+hNwo9Xjjhqc8kF4bYfBv6BRL+CPmvzvxbFMJ8QYZPvmzxuVjAzKdGxMLUOeyo47hu6WvAGM44VfJ7xGuxZiV2Em2ABQoO0F1m0T3K0/8IAEw8ujYImp9cNyTxy1+ihwcJzKDzQcD5UeHx+FnoKDzkCdMcDoBkfVzox4JGddV+oJbq1uw6TRDWsx5zFnfWHLeIr9wBAo53cTvHYN/OpjKu5GGszbBM6qdlX+Sc/QRe577jcjlcLVxImnE2FeeKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoFt4UFdyzHMIDNWxqwgCs1uTETlcZJ+xknUX5ebXiA=;
 b=LiZLb+KfwoHULspEczm1Qjmxikce/rwNTrdJEF+RS+VSriYfgYW8I6hRvf+acw/7rawApxRLBEKA2lTTjxyoI1wIBGhOnjNObfLcT08h0OT3/SHEYDj1+r1sXIxE0VmMoeTAzaxdaDpJ86QGsYQklloaFnRPI1FJitrRcxu3vzuOhvng0jIxZZyG2qWOG7ooGk4bgJdOZAPJ4/trk0Jnps78jAr6Rj6ukCMikc9IV6szMoVvhzg2SMZcA5DKgpGrTNq/8r1nR9xH2yiEsiokbOSn7824kW1pG00jS4NCGsBep+d9q10xs7q6+72slqW1ANn37XtxsDn92BAhQB0s1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoFt4UFdyzHMIDNWxqwgCs1uTETlcZJ+xknUX5ebXiA=;
 b=uOwipLEjSS7p4PLXfQA55vQOW1zR5ooWCPP7mRUhjyHPppssIRYLbYsOL5DOaGs7leTJoyyXH5wyiQ2WuLhPV69wRBGvg/Tspn8SXijQK7yd1m4OHJzrVEzCj0eb8T+VSfDVPoQ12HXLPy9WkhICB/+U7HD5vvWzssNtkk+3sDDriLQMjAykgM2aZD283nSeuNb9XwHD3mpLnlmBlMaDkkw5Ew3lRZx+/wVJF0J+2AjWO/QQhhsXDJUqbHIGVHlMZML0A4DEET19oMjR3mqKJBxjf0GwYH/JY8oy/e0pTBt3bpnDFIVNpWbV6MXEISQb4rEeppyKC5sDS5qu72LQhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7445.eurprd08.prod.outlook.com (2603:10a6:10:36f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Sat, 24 Aug
 2024 09:27:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 11/11] net/httpd-upload: an example web-server
 implementation for file uploading
Date: Sat, 24 Aug 2024 12:27:16 +0300
Message-ID: <20240824092716.1042696-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e413c2-570f-47f3-f978-08dcc41eff9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ahw7kD18J8VB7HSZIzSw77EmLqMPzPkA/NTuHLz+2pTdEPSEOhSPSNEk04Ut?=
 =?us-ascii?Q?egV+lF+LCi12l3btO7bTW8lor5mNMgh8tQG4+4mDtIIaSRQdtbwyX8yjfSIn?=
 =?us-ascii?Q?HGRO+Ql82XrTuybSd7bsF09VZYlOQ13Vonrjy1WMVcsKnqTZJe0/YDoq18Or?=
 =?us-ascii?Q?Pq0yTOMuDaklRjxsAfP/qBkgUjvQugBXOFIPLbIOXlR1WVMprCK+Btfmc4Y/?=
 =?us-ascii?Q?gy/WGHFborjrQ1WwouWed7cEqUjZQEOlzJaPXGzrgFmOPthsEkwLWZVO9zJm?=
 =?us-ascii?Q?ppeAHzCO1BKlCcmT1ZmAZlK7AIuJ9pLGd5VK0S6hVXxBputKFePbMr6C9JuA?=
 =?us-ascii?Q?dDZvhXXV7jc/QiEqzT2OxfTChrXR4JlTDqy8NoKPgWsmwMKZqpmR3s9EBjNQ?=
 =?us-ascii?Q?2DtYYwY7/YV8Tza+gVOs8Q8GEfhARR/Slx9PBqzIA9y1WMeLzKstzbtI4DAq?=
 =?us-ascii?Q?3FiEj4mp8uN7pjVz9X/5gdfxl0ki4TG6nGhwVXBUawQxwxA6beqfVx7gNLKa?=
 =?us-ascii?Q?ATPCIE+9x5pc9pvrbmQIi2fsSKubU3/3Rt6Xqn+7op4PCHrlOWD1WDF768UH?=
 =?us-ascii?Q?y5GeNQNBz81LkjjdBuvs9x7aPswNT7VLhS65UuUl14SQH589kp/yagncdVM8?=
 =?us-ascii?Q?UQ+c4Enat3MqEoxc5iXFw9WES+3PnsJPcdge4POEaAJ51MbVEr1q9txwt+8t?=
 =?us-ascii?Q?Iq5ib9QxGxJjVdfR9U1ANh5mo+7F8JabRv+XRq0/D6vopQSWqQfstDEjDsAY?=
 =?us-ascii?Q?x2wxPDsHYJnvZdVN9fUN+l6+bxd854UTtvhojY6efWnpUcGkkljxmZyzFqmJ?=
 =?us-ascii?Q?+Z2aSa32YiH4Us1aAPEqPFXcDlQd1frZfOzqW63hTSrAdWNJr+VvKozeEUoF?=
 =?us-ascii?Q?hI5A35Wz8DA70qASDoMMo3d8vgudTbi9yi2sNCsFNgLvWgsTrYjIsk1aFvBq?=
 =?us-ascii?Q?U7e6VvPVtQcW97bN+Df9NA3FTLfsqo88XL0OylhkL/XikqEZzJAs3+ZQJT/+?=
 =?us-ascii?Q?BCazZwL1WQoC6hLR9Los70B+Wjjvil5InvTA6SKbZfigsdaQNc49NDxG3yk7?=
 =?us-ascii?Q?IBw+jum1yJ6qO/tJjuamu+cIRqN+84UmVMtGuQpU+FTVMpFL5ErUg3vSWfLV?=
 =?us-ascii?Q?Qu97+YEE5xwCVZH1H6dljk1l/NDO885fzw57uGlIgZZA+L/RjWaNppHyUTeV?=
 =?us-ascii?Q?7rQQvZKESRyAcnU0rJa61Q9SXGy3FCh4yo9bS+gpVe+WUgqbVRSdaCTkT1au?=
 =?us-ascii?Q?RuxDpbo2UcxJn0vcu+EHQH9dNneb7oDE9d/rU5+odiZ0rZgfmphivctwOIYi?=
 =?us-ascii?Q?LpIBD/PG2rLJqzY4a6vvYsqvLkOKc385NpZ6Ey80Bu4AoVnTHie32ulCY91O?=
 =?us-ascii?Q?uymIIhGbpLug5mVgR8yJcgLeny7q6a/5RcrWqld6JXJd6FrIP/l2U+yVxPPL?=
 =?us-ascii?Q?r7ADm4m9sRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LRetwjxj4A+vV57WhD7ph1TTlc+oeobl6hhOJYQoflxVqNmVZMoBoQsNVuUY?=
 =?us-ascii?Q?Jmmuru54zaFfHkiGstJwYLDT5V/BsW2D0lHacwnrBw6ghlsvLwFP6Jh7nSsE?=
 =?us-ascii?Q?IcqyQNkwdTtI8yPIEsPKM7Bw3RuXDP6gjk+QiEWKqF5oBBXfjZATD6rdiWb4?=
 =?us-ascii?Q?wMjsgmoRjFK2TDznm1RKH70cKWE8BoqqJGs+4l17/BFxUjos5htCrmm6Gk42?=
 =?us-ascii?Q?1whNbDQrDrwapUvdPkgvfmBpMK2XLCmjfIozG3A414d0w7iMWZmGeTiBqV+X?=
 =?us-ascii?Q?+xMi0GrWM48BmqYzFAKF+baxhFdatUBnsqtbYrAaN4CSb9PHpVy+5v/PaUOi?=
 =?us-ascii?Q?l/doQycqA+jw3F0eV65m7+oSB5OScN3qqHndfaN6C64Q9yJHWjXWLA8M6EdO?=
 =?us-ascii?Q?NO4Uph/5CXjJ4A4K2jqslBDfbqiSx3/5MxH2IvFMrK/RmKz7BoNKvFm+0Vju?=
 =?us-ascii?Q?e3UCTCPPHcG5C3PbLbzc01uBIgXMvwATGNPQJha3LblyyfIUigmj39V3nCY9?=
 =?us-ascii?Q?wJcUsOukNvvULdnEte3wQgA/jBvjfpkyqI2PDvFcEEF5h6cat/BgPD8vl+C2?=
 =?us-ascii?Q?lp8u9gP7QJDWXkJllpLs7dCpiiOlVWcyrJ5Q4PvCGHogGlwYpFUNW/YVdewY?=
 =?us-ascii?Q?S5Ugw2/KEsciYa8VfXrTVkZmYJGhUhCbNRnnnuW5inL0n4R2sKM7ipPXWbDZ?=
 =?us-ascii?Q?/59IcbT36JO0jChnCRz0NCWc9pHKtRUkv4+0GR8Vq+X11kZuY6SyBZ3pOn01?=
 =?us-ascii?Q?bQd/evbqcRKQYc7eQREwztPyoVmbc7rwkLyEnvERr9753PyRWfHCLa6gJz8M?=
 =?us-ascii?Q?Zklaj4JVwGERTXZlrVy6fbJRnNRQZLLdYAEuz9GDBEkiiLwp57/1FwNbmr8E?=
 =?us-ascii?Q?WctARzTadV58sySsiMhklIUzbe1RliMXfmJUJ37unfSqjkr2eLHsW+pxTNgY?=
 =?us-ascii?Q?yZkXfM0oU8Jly2agpDxe9j04u0J0e3pg5lqxHa6vc/dBf78/7q4hZi4mYsgX?=
 =?us-ascii?Q?Lp8Qi/jiQ2RHmQD/LhR6IT4yZA+eQZ6Iy6RncAJ24+Jg/yXwHLt4+bxVBSN2?=
 =?us-ascii?Q?YiDijydsDs6z/j6Q/bGifkAlI/cmureD9afFplfGnKiw5KlO6jF+yI3Gv5Ms?=
 =?us-ascii?Q?7CbWMiuci3Bl/HiQS52MJdX2H3H9efux0w8yEd/cWy/Q85qotW7oKRiJwKl4?=
 =?us-ascii?Q?5ASspnXBni+RiSwLlrgV16kA+Cf2F9fW3wpHYX0tX+PWg/TilVa9kkxHL5Yg?=
 =?us-ascii?Q?fcYT/2f4opTqX5Q9Wc2Jz8QNZfrinCXBsaQrljOYMNTMJHrXpHAgBdh+9aqv?=
 =?us-ascii?Q?Wad2pDp7wLerfsexLZHfGS1uZhQol796/3U8cA9TlSfUYQ/WaPSByWCnghdV?=
 =?us-ascii?Q?VlzjxEIPZWWa9lEAMxMxPEZZKRPYmkCqur1qX3m9mP8w86Ra9irDurMqH0lA?=
 =?us-ascii?Q?tYZcml8CuBdWn+v5U/sTSmPHcblZIeJi4jbyWJkECopeuLfVMayVfOfiTiMH?=
 =?us-ascii?Q?dx0eOyy3RHfcK0ZnAubGfB25wwJj/lGcu86qLdlKENbSgpAxGjXIYgCNnvoQ?=
 =?us-ascii?Q?R714OJws2VfowsgfGQEpjzq5YqJrJTdmF0C3aWryjlhkCq1ArBlqW/5EskaX?=
 =?us-ascii?Q?yVHyDEh25EN+lk3QKAJQftw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e413c2-570f-47f3-f978-08dcc41eff9d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:39.7670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWzXfVGSVRZbL4q3MgetRnIXG0gxjHv3n2X73nLuGXfg5+QFj66BjSNRrjGPPkfrBN8eNdQVk/ixiw+Pk71qiRAywFHbYGmZkwXawv7r41Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7445
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

This is an example web-server implementation. It can be used for files
uploading to u-boot using a web-browser. It acts much like tftpget, but no
special servers needs to be installed by the user.

This code can be used as a base for other implementations like firmware
upgrade web-server used by some vendors.

Usage:
  u-boot: start the we-server using the "httpd_upload" command
  PC:     open the "http://your_uboot_ip" link in the browser

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig                     |  14 ++++
 cmd/net.c                       |  20 ++++++
 include/net/httpd-upload.h      |  12 ++++
 net/Makefile                    |  19 +++++
 net/httpd-upload.c              | 123 ++++++++++++++++++++++++++++++++
 net/httpd_upload/error_400.html |   9 +++
 net/httpd_upload/error_404.html |  10 +++
 net/httpd_upload/index.html     |  14 ++++
 net/httpd_upload/upload_ok.html |   7 ++
 9 files changed, 228 insertions(+)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 net/httpd-upload.c
 create mode 100644 net/httpd_upload/error_400.html
 create mode 100644 net/httpd_upload/error_404.html
 create mode 100644 net/httpd_upload/index.html
 create mode 100644 net/httpd_upload/upload_ok.html

diff --git a/cmd/Kconfig b/cmd/Kconfig
index abcd003f7f1..55b9d04f2fa 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2014,6 +2014,20 @@ config CMD_NETCAT
 	  netcat is a simple command to load/store kernel, or other files,
 	  using netcat like manner over TCP.
 
+config CMD_HTTPD_UPLOAD
+	bool "an example HTTP server for file uploading"
+	depends on HTTPD_COMMON
+	help
+	  HTTP/1.1 compatible server for file uploading.
+
+config CMD_HTTPD_UPLOAD_MAX_SIZE
+	int "Maximum uploading size"
+	depends on CMD_HTTPD_UPLOAD
+	default 209715200
+	help
+	  This sets maximum size of uploaded file. Real transfer will be
+	  slightly more than this limit.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 364139ec5b9..e5fddc8c7c5 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -21,6 +21,9 @@
 #include <net/udp.h>
 #include <net/sntp.h>
 #include <net/ncsi.h>
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+#include <net/httpd-upload.h>
+#endif
 
 static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
 
@@ -228,6 +231,23 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+static int do_httpd_upload(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	httpd_upload_prepare();
+	return netboot_common(HTTPD, cmdtp, argc, argv);
+}
+
+U_BOOT_CMD(
+	httpd_upload,   2,      1,      do_httpd_upload,
+	"starts httpd server for file uploading",
+	"[loadAddress]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
diff --git a/include/net/httpd-upload.h b/include/net/httpd-upload.h
new file mode 100644
index 00000000000..a80df214668
--- /dev/null
+++ b/include/net/httpd-upload.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * httpd-upload include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_HTTPD_UPLOAD_TCP_H__
+#define __NET_HTTPD_UPLOAD_TCP_H__
+
+void httpd_upload_prepare(void);
+
+#endif /* __NET_HTTPD_UPLOAD_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index c1f491fad02..e7cbbc2248e 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -35,8 +35,27 @@ obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
 obj-$(CONFIG_HTTPD_COMMON) += httpd.o
+obj-$(CONFIG_CMD_HTTPD_UPLOAD) += httpd-upload.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
 # and this is intentional usage.
 CFLAGS_eth_common.o += -Wno-format-extra-args
+
+STATIC_SUBST := 's/^\(unsigned char \)/static \1/'
+SIZE_REMOVE_SUBST := 's/^unsigned int .*//'
+
+httpd_upload_generated:
+	rm -rf $(src)/httpd_upload_generated
+	mkdir -p $(src)/httpd_upload_generated
+	cd $(src)/httpd_upload && find . -type f | while read fname; do \
+		name="$${fname##*/}" && \
+		name="$${name%%.*}"  && \
+		set -o pipefail && xxd -i "$${fname##./}" | \
+			sed $(STATIC_SUBST) | \
+			sed $(SIZE_REMOVE_SUBST) > ../httpd_upload_generated/$${name}.h; \
+	done
+
+.PHONY: httpd_upload_generated
+
+net/httpd-upload.o:	httpd_upload_generated
diff --git a/net/httpd-upload.c b/net/httpd-upload.c
new file mode 100644
index 00000000000..1e1e0b1cf75
--- /dev/null
+++ b/net/httpd-upload.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * httpd-upload support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <net.h>
+#include <net/httpd.h>
+#include <net/httpd-upload.h>
+
+#define MAX_FILE_SIZE	CONFIG_CMD_HTTPD_UPLOAD_MAX_SIZE
+
+static enum net_loop_state  httpd_on_stop(void);
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post);
+static struct http_reply    *httpd_get(void *req_id, const char *url);
+static struct http_reply    *httpd_post(void *req_id, const char *url,
+					struct httpd_post_data *post);
+static void		     httpd_on_req_end(void *req_id);
+
+#include "httpd_upload_generated/error_400.h"
+#include "httpd_upload_generated/error_404.h"
+#include "httpd_upload_generated/index.h"
+#include "httpd_upload_generated/upload_ok.h"
+
+static struct http_reply error_400 = {
+	.code      = 400,
+	.code_msg  = "Bad Request",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_400_html,
+	.len       = sizeof(error_400_html)
+};
+
+static struct http_reply error_404 = {
+	.code      = 404,
+	.code_msg  = "Not Found",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_404_html,
+	.len       = sizeof(error_404_html)
+};
+
+static struct http_reply index = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = index_html,
+	.len       = sizeof(index_html)
+};
+
+static struct http_reply upload_ok = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = upload_ok_html,
+	.len       = sizeof(upload_ok_html)
+};
+
+static struct httpd_config cfg = {
+	.on_stop    = httpd_on_stop,
+	.on_req_end = httpd_on_req_end,
+	.get        = httpd_get,
+	.post       = httpd_post,
+	.pre_post   = httpd_pre_post,
+	.error_400  = &error_400,
+	.error_404  = &error_404,
+};
+
+static enum net_loop_state	httpd_loop_state;
+static void			*post_req_id;
+
+void httpd_upload_prepare(void)
+{
+	httpd_setup(&cfg);
+	httpd_loop_state = NETLOOP_FAIL;
+}
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post)
+{
+	if (post->size > MAX_FILE_SIZE) {
+		printf("HTTPD: reset connection, upload file is too large\n");
+		return HTTPD_CLNT_RST;
+	}
+
+	post_req_id = req_id;
+	return HTTPD_REQ_OK;
+}
+
+static struct http_reply *httpd_post(void *req_id, const char *url,
+				     struct httpd_post_data *post)
+{
+	if (strcmp(url, "/file_upload"))
+		return &error_404;
+
+	httpd_loop_state = NETLOOP_SUCCESS;
+	printf("HTTPD: upload OK\n");
+	return &upload_ok;
+}
+
+static struct http_reply *httpd_get(void *req_id, const char *url)
+{
+	if (!strcmp(url, "/"))
+		return &index;
+	if (!strcmp(url, "/index.html"))
+		return &index;
+	return &error_404;
+}
+
+static void httpd_on_req_end(void *req_id)
+{
+	if (req_id == post_req_id) {
+		post_req_id = NULL;
+		httpd_stop();
+	}
+}
+
+static enum net_loop_state httpd_on_stop(void)
+{
+	return httpd_loop_state;
+}
diff --git a/net/httpd_upload/error_400.html b/net/httpd_upload/error_400.html
new file mode 100644
index 00000000000..de654364edf
--- /dev/null
+++ b/net/httpd_upload/error_400.html
@@ -0,0 +1,9 @@
+<html>
+  <head><title>400</title></head>
+  <body>
+    <h1>400 - Bad Request</h1>
+    <p>
+      Sorry, the request you are trying to do is wrong.
+    </p>
+  </body>
+</html>
diff --git a/net/httpd_upload/error_404.html b/net/httpd_upload/error_404.html
new file mode 100644
index 00000000000..9dac22d497d
--- /dev/null
+++ b/net/httpd_upload/error_404.html
@@ -0,0 +1,10 @@
+<html>
+  <head><title>404</title></head>
+  <body>
+    <h1>404 - Page not found</h1>
+    <p>
+      Sorry, the page you are requesting was not found on this
+      server.
+    </p>
+  </body>
+</html>
diff --git a/net/httpd_upload/index.html b/net/httpd_upload/index.html
new file mode 100644
index 00000000000..e7d5ac943b6
--- /dev/null
+++ b/net/httpd_upload/index.html
@@ -0,0 +1,14 @@
+<html>
+  <head><title>Upload File</title></head>
+  <body>
+    <h1>Upload File.</h1>
+    <p>This will write the uploaded file to the memory arear pointed by ${loadaddr}.
+      <form method="post" enctype="multipart/form-data" action="file_upload">
+        File to upload:
+        <input type="file" name="fileID" size="500" /><br />
+        <p>&nbsp;&nbsp;<input type="submit" value="upload" />
+        <p>It takes no more than a second after the file has been uploaded until status OK is shown.
+      </form>
+    </p>
+  </body>
+</html>
diff --git a/net/httpd_upload/upload_ok.html b/net/httpd_upload/upload_ok.html
new file mode 100644
index 00000000000..8d2e561982f
--- /dev/null
+++ b/net/httpd_upload/upload_ok.html
@@ -0,0 +1,7 @@
+<html>
+  <head><title>OK</title></head>
+  <body>
+    <h1>Upload OK</h1>
+    <p>The file was uploaded.</p>
+  </body>
+</html>
-- 
2.43.0

