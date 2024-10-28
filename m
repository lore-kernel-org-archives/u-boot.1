Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236DDD33990
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A06B8913A;
	Mon, 28 Oct 2024 15:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="IB79LoEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18FF98914D; Mon, 28 Oct 2024 15:32:23 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA13089112
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whTKYuMYX/FWPxSaClc53zPWjRFCW1zlGeCOCNUvKJLgMQN1bnvtEjkpzx8UIxCjV3K47FWQN/1wCI70/WsLCOcx9tgJDiVDvuHUpvd1gCilo+6TMHsPFinuQ51Y1/i2BCEomjy4huU/4aM24tkZaTpfuQ6vcmw/lqL2lC3yTAV1TdL7RueIIAgZaFbkJ8nQPOdjkVOll5hCRWXlmfuRXg3TSjRqSWmGMsyutJ906B5NCb0Ti9oaN1aUVsu7Duif0oBs/0wWnxr1PdjLo/fO+qCyVatOJzUAFQ2CreJAj6phWtb97ccPifMZ/W4HMOpTVp50BKAhKtn/EF0NGO2JXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdyTG3e+MaNyY6+1bbysakXJUm8KySA1K4eN1JvenYA=;
 b=QlXooQeYQPQ1HaNry+9imBqWtwpGo8G6WviecRfjKJKndmeLanqw76RD7oR0KRTD+ZE+1xcGrCmon8WBay0N1qT5Xq2V+lkuh8IL6tgLq05i9Czb98g/W/xO9TnGYLw1/Pm555QzGcbmpDHGUZrVzEx0ZtS7tpUjz2Cmq/MLLEO8kX0TKH+Y9Xqk2ACYFZODskITACuBcvFotuR0NwAuKPRnHb83ddyMhZguNZM9qv9UvuG/PRO1fK/3LGBp7Pvl/R061jx5EpQakQfDUfayOK0SutSq8YBWLmWDEdJpBHVYAGXDjTC3VV/DZTTj4i0M4/ZhzFMDRPtVZzzA1vOxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdyTG3e+MaNyY6+1bbysakXJUm8KySA1K4eN1JvenYA=;
 b=IB79LoEdg0g41ndMZ95nczuTRXgNyiXMnCkMVbHRP4l6CaQLc9jitlH6vfkxyBcZWbJYEeoSKDy25VRlC0j8/S9MA0PDsSlGuKGpFsCPcXhE4SCneEY+mVzl1tMl17JVxCjehlNMbijgDfFYgThyqaR3yelc6MdsD38B7S9E0zpL6ePd6CL2nHzLoe3k6XyOuy9f5x05037zmopz1feZcvKjlQW5MR6iBIWtnOgVJvRsJuI9NWgabDOllq9U9KfeE3GQe08rWyCwahyUqP8+8komVy6UkSpevflo3wi6qUBwuAhe4GkTvoWIdwBSh8KgMuei7F/6AHkw9Jl1gxDM1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB8059.eurprd08.prod.outlook.com (2603:10a6:150:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:32:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:32:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 13/13] net/httpd-upload: an example web-server
 implementation for file uploading
Date: Mon, 28 Oct 2024 17:31:43 +0300
Message-ID: <20241028143143.1807305-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: fb05656d-37e8-4490-6669-08dcf75d5307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pmV8psZKokZYWz5Qdrtjc0n0MWUpX4Aq4tlC/ett4JJSvqd4R535TgIOnR3u?=
 =?us-ascii?Q?i/wzyPPh4mpZwmbGnrFjQNk2aDkBUmVlg75KpdlunyL53+3InnKzVuQGlPvD?=
 =?us-ascii?Q?85JTO9qGoJpaGq3LC3O+IDWQEogqI8lHM7B5uY6nnXRSM8OUAffeFturg6FU?=
 =?us-ascii?Q?4hIhu/bf/GbV4eY+WE0JwTGPN3bYJXEa8YqoD3b5RZ9sIt3uNgo17QZF5Q1/?=
 =?us-ascii?Q?gXVViHnW/If/BjDKKXs4K6Tzph9DDbYpnnCJDHEKpZFIZgFA/ARTjkyKeXmY?=
 =?us-ascii?Q?mOTvdCo3mOOG+yKmTbR6hylQTIZC/pz+2XUlwfS0t+OToKC9lHgYpOWOHAXR?=
 =?us-ascii?Q?X/3YSBXdLipLL95kM41rgR8flrtYqyMU+mZcnbhO4EsfMCjSjdnc0wcb/zgh?=
 =?us-ascii?Q?yW7JQ9LDZGUDRT2SGgB/ickXsoB9q9z3tt48ZOQPWN/k6oDjGIScunxahZ1w?=
 =?us-ascii?Q?3G4pbJ2uzH2/gaUKFzhXDNlBuuVhgikfW/PS0/QF2XZLzkkbOqayG3EHaLxl?=
 =?us-ascii?Q?JinjbdvEeQjjqD267sgxuB/CvMtHXO42vKRguZvit+sVEoYjwDk8f2HJTNVt?=
 =?us-ascii?Q?H/W5YH3TI+gqtzrZ/kwhP8e1bqU/HtZROHlRYdP09SWUBWYqwbJWTpLvyzQu?=
 =?us-ascii?Q?UIXIgGftueT1OEboQbIYpnBOp1wMuToMm6uyXAdYw52xZDpbfFwwzalnmUdu?=
 =?us-ascii?Q?madsW0AHtj6N4M0sh8IqPCOQ3zLqjLGT5F2VPOzIp8LB+3BJN3FQH8l0uOT8?=
 =?us-ascii?Q?YzFXAyjmmhilOjyMaBThRz+aKgqfB+Zyt6vfTfz2tBskxmdHZW3Fx+Tjv7V0?=
 =?us-ascii?Q?Fy4TLPyn7Uw1WsafLEmCZ5ymKSzocPYAfm68CYLkTIGKmYGoipJNToGeL3Rq?=
 =?us-ascii?Q?1pH+mIEcB3blC+dGTFTKqFBHf8bnVNdXgDtn531L3tbzFAX8MHjfJfcPcsxR?=
 =?us-ascii?Q?RvCJPZ78/Q6ls4G46Dkkj9kjKyc3RuBD7zaGTg5yshh8+jbLgmpee0SgMx3G?=
 =?us-ascii?Q?oNMLpz1a/z/PwwLXdYEm2Wssd9HZLLp5LMYsFxRPVd6GX3AQHfGVYAy20qWY?=
 =?us-ascii?Q?HnhQ+yNkHk2IyeE74WW7YMT6faS9Ta4oS+o9BhJbhBbV5IlT18OBJ//oE5HV?=
 =?us-ascii?Q?jykto2ebAUeiGC3Iv2HYd5pGHY0mZMPO5k8kyLsf7NtAEEsWx130yR/5oSDx?=
 =?us-ascii?Q?pwcSqjJFUAI1ANiWXwfVCkn2oQY5dOkdXN7AVCsRiULv3iY58wj1O1K8nWAw?=
 =?us-ascii?Q?htBxPWOF6RvHUD5/sLXOwaP/WMYfIHIoGPjqgk8kMp9V+i7ju3pyU20YE4OD?=
 =?us-ascii?Q?Yh/BOZDHMK+ejWCeb3hG1uNTmsaHYhTsAerd3vO+pmuOdVRy34QE76nv/irV?=
 =?us-ascii?Q?yMLErxVOV9UVSpNGMy4eHcgjKE1K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2BZd93gaAi+gHR3L9vDRnoQS5tTK/E0I57Ku7uCDouik+nVBvZiGc3vJGw+?=
 =?us-ascii?Q?xH1fkoG2yHSFxojB7g9roLzkJeZ4NAf4klK2oWL6PvTTLb5Tt7NszDHGceCu?=
 =?us-ascii?Q?EmE0GW23jFLbvvV9Ct8uy+E3fD41b/ey07TXoIGg7YO75r4xxU/p8eXRRo37?=
 =?us-ascii?Q?vCXASbPgJKkX7UJQ5fXnSBMH8yqiPLZo52g7DyvnjnUTmFOw6oijjZRPUUB9?=
 =?us-ascii?Q?GW7i0UlNsyh3FYBqM+UD32cl/B/v0N2o0JXoKAo6lJ3Um3eJ/wOXzLLFgRtS?=
 =?us-ascii?Q?Xq4MH5KKXWkrjn2fmmKOXw9pXBXQe6hu8cQl0SzgioYhqzmya3FbxQsAnUU2?=
 =?us-ascii?Q?rrCmT8hZeF2rRbJTHzua2387GiqHzJAfGeuF2tzoB3rMQRRb3LU4g4T1c6/q?=
 =?us-ascii?Q?yHrT44HSrb2KlMAK/aasSEqM0r+ZZxeB1UcBXu0kUlAXlwphh8FkloF04j9f?=
 =?us-ascii?Q?3fQ3uMsVWc4YgK3lYZ1RbI812pbwS3wUCvqo9m5LNIrsPcnWDjuqCpVJf4Ht?=
 =?us-ascii?Q?MBC6nqAAAJwHIrVGqZXR6wyNZYQeGz3Jols7HftPssPBY5+1zTHEyXMKzXbX?=
 =?us-ascii?Q?VyxWqNOBzbycWYaKTAUqj5BVCVpfjmsxvBjdPfcDYHyVLhwIPMrazv2mI8Q/?=
 =?us-ascii?Q?mGXjLHyP4ZYfs2LRDcXRPcN5Fm8adX5XZPfeitbDFPNdpmleesvLONDknumS?=
 =?us-ascii?Q?5IG+iytccmScDaWBWT6q6YlH4PSreeLIUGaFWlzjzwpN6aPfWo9f3gUGpql6?=
 =?us-ascii?Q?FpN7nV9BG/I0qGe3LBrUWZZum18+PiFhWhqkUFkLrhGX7RAFn95NfFTrCdT8?=
 =?us-ascii?Q?jtKsUVki5ew7VTzrsGuGd0spk+ZWfWmC8mYwklwzZ+EiFERT5I4t64JFO+bg?=
 =?us-ascii?Q?HTe+0/X3JrZ5mesjVSEbby3cjqi6rkT3RXwpol03j0xFfArk6aDhdJIxwDVD?=
 =?us-ascii?Q?Bkemir/Oy/6QBaVnmwEOi2bzdvZhGotS6nvUkBB+Dv4Gqvzw956OUJCJkoAo?=
 =?us-ascii?Q?g2bkWhr9B2y7LN6g7hgb+ltgv/LhaEklLJN/r+0+BvoEP8bRSnCtd1hqBN4G?=
 =?us-ascii?Q?H7KyB/RfqzYT4OVadgRwMFJmzRHuEZg/klc9jOkGXqhn2zk3pJB6e02ykUMP?=
 =?us-ascii?Q?Hxxfqx/BaPxVsqZqqIy53K9lnIrTdiQPI5bufT+N7Wp7OFuHZAQAW9dffGBC?=
 =?us-ascii?Q?Vro5SQ+0rIpTikV04aic+fQWEJ/1c3/lvqm9zjf8Ghn7nVzUpiaR1Bb/f3E+?=
 =?us-ascii?Q?6EoQX6QxfKFJ9ZUutYJoKDOKTz3uH0QYU+nq/thJgiKYXhounFZEKe2Pa5S3?=
 =?us-ascii?Q?/zs4LcKSZAk4OHUSaYY9SW8QRRVBZPWENk43PPtLBM97dPEIEABZuM2hK4VZ?=
 =?us-ascii?Q?sPe4PuWYFc82L3nkiEHQ32QroApM9lcfhoYCnscDlJ4V16q1RLk2D2oEbslH?=
 =?us-ascii?Q?tDFhISqJS5A02pHYoDSTAtDEffH38cPkPu6iQwwynK8Cu+nZb0MBO+afl0gM?=
 =?us-ascii?Q?4FTip1fMbDMe6FD4RrgiFrpFjlA6qn5s69aOyAKu/LVUNoLSbjwBTa8OB0zr?=
 =?us-ascii?Q?8h/kuTfv38RD8ilzVpRt077u6CfUZjhuIYaZoG9iMwQWAuBv6CIM0GR0dohw?=
 =?us-ascii?Q?O2i/VG5itQlYfAtH+gRaz/0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05656d-37e8-4490-6669-08dcf75d5307
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:32:17.8329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAigZtNEnhQpdrFMk1C3lNfhPKyDVsy6i8E02cH060Wc4iMQFHElQkgseOyIm5AUi9DDP90LtIYYhfwG2w5XPwfCkpERlI2ybTC+IRsi6Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8059
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig                |  25 ++++++
 cmd/net.c                  |  20 +++++
 include/net/httpd-upload.h |  12 +++
 net/Makefile               |   1 +
 net/httpd-upload.c         | 173 +++++++++++++++++++++++++++++++++++++
 5 files changed, 231 insertions(+)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 net/httpd-upload.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f1d85c1fc7b..d7848f52453 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2087,6 +2087,31 @@ config CMD_NETCAT
 	  will be lost or reordered. Any netcat implementation should work,
 	  but openbsd one was tested only.
 
+config CMD_HTTPD_UPLOAD
+	bool "an example HTTP server for file uploading"
+	depends on HTTPD_COMMON
+	help
+	  An example HTTP/1.1 compatible web-server implementation for file
+	  uploading. It acts much like tftpboot command: put user data to a
+	  specified memory location, but no special tools needs to be installed
+	  on the user side. The only required tool is browser.
+
+	  Start 'httpd_upload' command, open a browser, connect to the board IP,
+	  select file to upload and press 'Upload' button. This is enougth.
+
+	  There is no big profit from this code, but it can be used as a
+	  reference for other web-server implementations (ex: web-based
+	  firmware upgrade/recovery used by some router vendors)
+
+config CMD_HTTPD_UPLOAD_MAX_SIZE
+	int "Maximum uploading size"
+	depends on CMD_HTTPD_UPLOAD
+	default 209715200
+	help
+	  This option sets the resriction on the size of any uploaded file.
+	  Please reserve 2--4 Kb more space due to additional space required
+	  for storing of multipart/form-data header and footer. 
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 3dc9918207e..915a29630f5 100644
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
 
@@ -229,6 +232,23 @@ U_BOOT_CMD_WITH_SUBCMDS(netcat,
 	U_BOOT_SUBCMD_MKENT(save, 4, 0, do_netcat_save));
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
index e9e91dc8cce..c1be57eee0b 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
 obj-$(CONFIG_HTTPD_COMMON) += httpd.o
+obj-$(CONFIG_CMD_HTTPD_UPLOAD) += httpd-upload.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/httpd-upload.c b/net/httpd-upload.c
new file mode 100644
index 00000000000..24f708fc9f5
--- /dev/null
+++ b/net/httpd-upload.c
@@ -0,0 +1,173 @@
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
+static unsigned char error_400_html[] =
+	"<html>\n"
+	"  <head><title>Bad request</title></head>\n"
+	"  <body>\n"
+	"    <h1>400 - Bad Request</h1>\n"
+	"    <p>The request you are trying to do is wrong!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char error_404_html[] =
+	"<html>\n"
+	"  <head><title>Page not found</title></head>\n"
+	"  <body>\n"
+	"    <h1>404 - Page not found</h1>\n"
+	"    <p>The page you were looking for doesn't exist!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char index_html[] =
+	"<html>\n"
+	"  <head><title>Upload File</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload File.</h1>\n"
+	"    <p>\n"
+	"      This will write the uploaded file to the memory area pointed\n"
+	"      by ${loadaddr}.\n"
+	"      <form method=\"post\"\n"
+	"            enctype=\"multipart/form-data\"\n"
+	"            action=\"file_upload\">\n"
+	"        File to upload:\n"
+	"        <input type=\"file\" name=\"fileID\" size=\"500\" />\n"
+	"        <p>\n"
+	"          &nbsp;&nbsp;<input type=\"submit\" value=\"upload\" />\n"
+	"        </p>\n"
+	"        <p>\n"
+	"          It takes no more than a second after the file has been\n"
+	"          uploaded until status OK is shown.\n"
+	"        </p>\n"
+	"      </form>\n"
+	"    </p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char upload_ok_html[] =
+	"<html>\n"
+	"  <head><title>OK</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload OK</h1>\n"
+	"    <p>The file was uploaded.</p>\n"
+	"  </body>\n"
+	"</html>\n";
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
+	net_boot_file_size = 0;
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
+	net_boot_file_size = post->size;
+	env_set_hex("filesize", net_boot_file_size);
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
-- 
2.45.2

