Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFE2D637DC
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051D5895D6;
	Thu, 14 Nov 2024 04:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VbVR/+05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D52895C0; Thu, 14 Nov 2024 04:37:05 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9393389583
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIl+o8K6/SvKgSgv+5SWqku85rohrd4MERDJVOu4zaJT6/HZ6e6JHD9rpMH31b1PK9NxpxDhykiE4OGMd4Qy8+0Rqs6PK075lgPWdCeMzg9KmEETJ0Y107pgzm2XyXL9+z++7JiN3S9wxRFPmI6E0GnM2hckhj/Cw5xPeWjDu1ZWYQTrpOMProramKlwV/pdDug3UMsAbR/5GubLlwb02EKM8haF9JU9AC8vIgmaiSQy41X1FdFkeGwhmyN3MEySdkOv8bV6JEMtS4YxjXgFDlqvcV1FcBrAqsmdSf2ge7uBo363qgexQ+/qjlkDJiEBV90I1+VSzsVcFJPSr2VC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0QxNhYk007BUN0+KDemFnhIlSOWA/3ecO7E0C8dIFA=;
 b=f0aTMkupbH0NvlQzfUyKd4rh8nZNBVpjMQHOKlzL3nzU1+ZE1uhf2+z9PgeATxa80lDqA9dbGTi6eYobnG4CoUl5i5tz0+LOwZv+a5jcvK0+xbaNLpgbwocNwVmhA6kW+a1caVylg2E0Gptm5kq9O2nPu9wRB7cMjisSdLzqIh9Z0CIE26GLPh6iKQkEmHogghSjrrG15iw+gLDRZAWA4oexiXuPvKHkEM+zvarNXkit1MoJ+mtK5DmzvxsS7nc323ZE7EVa7Fd3xZQAzkXZslt5sqyCA9+9eHuRyF9fL8bxuQjwMA54f4rZmtDANf+AFZSqCEjTWSn4R5lc5wa32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0QxNhYk007BUN0+KDemFnhIlSOWA/3ecO7E0C8dIFA=;
 b=VbVR/+05aI8Uum1Ghhjb/KU4dt5Vm8ubMiGyXGLAnImE3JwuJkQwyG9Cqrn3y2tamXXtbPVVQYooG+i+muEe8a92zeKCJDFddKZ0q1qeqnbWfC7OFJyCpO51GMO4ZzXOM2E+In4IN2OD/EBetehL1EYXXIlUEA7i6wPpz1meSp1ktG8QwsfXT4VM+QyB2bgVsvDeZJ5EDKMQFU9na6eEkQ2HNzEhMIm2pt7vCSeZXjQ8hfjs+q9UycCknSDJxVjcQSrHuQVS/7GKu80YyrqncV/OQGpmq6+ZdFs9YgQ4ccYOqxkqVdrnxwokI3Kk/pc3Wjn1YKBVaM3kSPpTrmYTDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 03:37:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:37:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v13 09/10] net/tcp: define a fallback value for rcv_wnd size
Date: Thu, 14 Nov 2024 06:36:42 +0300
Message-ID: <20241114033643.623355-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: a498b123-ec25-4ea3-9dde-08dd045d9a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bxCOvge+eS8kRyGoEB3NrKZwu0o39EWDdCNioBLg9nDVw+Fe+cmgLqiHXkZc?=
 =?us-ascii?Q?9AEDYY1LKXbgO/zk1YI1gyJ9g+I6l2zm5GICt2OjrQAHrgm7oe8ZbE/W0Z3D?=
 =?us-ascii?Q?INpqxAqgHC49k3NIXKiEL5I46ClHvLzvQ6qIp23Ec2znJLUNqo1KypdEJk38?=
 =?us-ascii?Q?GJIKGZLnmWcp//Id7zPBlQpBBeNEkPQ+nyfDDsEFuMnw61ELH4qKmubEJ9+k?=
 =?us-ascii?Q?jMizj41aq062hKBkHE7mB+FKLsxthMlx3cYIEJt3xG6eskSkgzwMbbK92Xox?=
 =?us-ascii?Q?Hqa5zBtd2UAt8cMhpSqrX9yI+fgXyfUUW8h/mH32cvbCRUQx0o/lSVtL4lE4?=
 =?us-ascii?Q?FwejD+NVBUG48c8PeA5ZUpEdA9JYE8FNkJUBt5kHvlJTtMgGUBW6OZ7E2Sww?=
 =?us-ascii?Q?9MZPsvjKlH0hscDVwDRPN+ZRB1hPrpvODBtQUGw+ByipUuwCztOQQwWGnuOK?=
 =?us-ascii?Q?TBOb1oL0Ih3ZLQZs8IWhd2JseoLNPEOd2W0NHqv5P/ZIomUuLUFOdy3Zn38B?=
 =?us-ascii?Q?8lq1fgHTR70aJr4vUJUyBEfJH4LsU+TVuyq0eEjVu52v+DrKN3Dt0ZS9bZ+Y?=
 =?us-ascii?Q?Gwsimx8PLzhGdR8+dLxTsiJnItVhhErTWOcT2ATqh8GowMXLImWS11DXH0iq?=
 =?us-ascii?Q?Odc4GSw6HsJY3SMpq/ZIofBHO+IRIutPgAsSMjAe6s38IdGprUPYpdoTnfhq?=
 =?us-ascii?Q?7b/Wrsc5W5xfCaTzZjcM/875/WK3MKzsDyVskcOxmtpD5EcclhN4+LuGLrYh?=
 =?us-ascii?Q?VPjTwzL9ax10LgaDwsoe0gTANwmaO3eNRFYyXdJYrgGvnPLYoT8CQP3263Qk?=
 =?us-ascii?Q?ko2ERaBFIiQPZ5m0/UQcfP6n682K164F4tHSAu1QbgeF7v0ATyGukW0E8ir8?=
 =?us-ascii?Q?M+ch0+Uj8uMZdiSNQg7N3ja2wU6ka7i/Gu023aEV3WwRIZDo+D6ayAvc1yRd?=
 =?us-ascii?Q?/+yCGT0CiR3Ppx2A1d/0jIIvL8JFmaSk0g2OnsaYJBrmygP857vJ0TMIIoiA?=
 =?us-ascii?Q?gFqbZt6ROnazhtuaHFk5zeKGP8D/NpCDeVnsLb2KE9Gn7vNWyoejD8m58NhV?=
 =?us-ascii?Q?TFxSUb3mKX1BvjaNXQzRD5NGhkVCxENTZ+EUrg/s8K0372bCb8HoEjZqW+TD?=
 =?us-ascii?Q?VVY9El5F2jBi2jihcBaZ9i6BiBsirWT79NOXwkEGF3C3TtlK4Oxg87l5dxu8?=
 =?us-ascii?Q?bs7t0/69JzxlZlZFxT/a2yM1dTVNNeKoQlZQ7Fz+eqe2oyTT9PrfuQC02W2z?=
 =?us-ascii?Q?3VcRFL8wz9WeJGhSXUHIsM0DnYxJAWEOClmwUDqrBC5AaXePEQ3vcEzxmpI7?=
 =?us-ascii?Q?pAh7qYEX6ZNL5b7zs/4y5rLNdGEpDXzbVfolu6g6ynDMd0h4PuJOY0a8e9mA?=
 =?us-ascii?Q?qXODFdkyHkelWyalW1vhWWWJUDRE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gduVbFf7y2+cpoEAszxgVmNf5tn7j1Rfjfqz2/ybQQ6GnZ5NWHE7T3qVS6Q6?=
 =?us-ascii?Q?IOLa/4VbtdYy9CnEVZq4f3pu89oFVJwpcz4EzFmmxz5hQUp73zSbInHkOD+n?=
 =?us-ascii?Q?5H5AoDDc+IlJyv+gIxNA+Bs0NsCloO4CzF3bqY97VMUs+TdbpBmniGBbBWjk?=
 =?us-ascii?Q?fNP8UfDhZFde+xJ0I+R+Ckcd+FpxNXV+qsCmI0zsD5iWlmk19anvB1+7o5wH?=
 =?us-ascii?Q?x4th9F3nBb4fr13JLDBbl8Zmmtb55S/Tc4dxHCQ/thvN9JbAT/DVwgGCFW19?=
 =?us-ascii?Q?UT7su3Bigh6NfjzOGV6bL0eEbDgQN+nof6m4ynn+VOd4wgE3s4U5+4rLFoe8?=
 =?us-ascii?Q?nzMdz+dxJ+IUmeo3CYF76Fy4e8/Yg+MIL1JRNZ/s2c71VbijtbvDD9QlOSyb?=
 =?us-ascii?Q?E61/1f9IyWTXlkaY5bB5KhdGtuSV6bZoEix0B1UBGHZMxm9UhrCQSLIjxFNT?=
 =?us-ascii?Q?kIsa3omVySeRpbsIxvPeBVwr1rdEOVCe1IkpbU8urkh81C41I9dCKEQj3v3X?=
 =?us-ascii?Q?P7bh1xaeuVr3bGKrpG8jtK12WRZnX78ixxou9wNDg5PeYfKgQNo7ZwDS2vx7?=
 =?us-ascii?Q?fjIhcpSfKJy7yAvAgcTVtLt7J1yZp7k0sLwWSVmcJQm6Lp990qZ4BCVL4819?=
 =?us-ascii?Q?gwBKCVvRLIUgHGuJQ/ncvhj1kXe7rpeogmoKU/AKrlHBafXpP0+01jPIkRa6?=
 =?us-ascii?Q?mxawk20oN90A5YUakxOKrH0xezSTv/f/SESjTzp1+kZqlNtZ5uZv/5HAtgrH?=
 =?us-ascii?Q?P7u2sikxcr6g8o+tGpKkMPFr4PPBgsCzK4Yczo5LQSrlSgTjQPlVs3p0KK5e?=
 =?us-ascii?Q?+7nJnzcobVxRn5dYDUKaibSMspeneha52mJsw4NEgkdeoN8gtDpCiW2ZiHlX?=
 =?us-ascii?Q?E0ltj27yGDlrDvBbTWN67bz2mbf771nGGpfUexYEApqW664WsooXC91/+Ptg?=
 =?us-ascii?Q?d0qHco6G8AYGnsizEXT0OOtUIGWlhL79N4XLIcasUtHVTj9iYEpyj9tQHXkE?=
 =?us-ascii?Q?bOdHh9BykF3hn95ewLZRZcVsGuFyzR2i/mTVekubqWolSc8EGUPD0dZvnZwt?=
 =?us-ascii?Q?7qtRaTJt1t3qMRd2wPXp0brnXbGKPGgRSKByLyyzHub9XSu5LLrNN1vtSWKf?=
 =?us-ascii?Q?vmrIjukAcpQm5f8Caf9OG7f4L9t9iDnJA+d3HtrHF4E4pRXgyn2hi+iN7Xbh?=
 =?us-ascii?Q?n+hELhVSfmlfXuxxif0PPAuS4RbWtBxl5StJxVmZNe5qtA4t3myXPNtYDB/U?=
 =?us-ascii?Q?1tY+jvD0TIiKUvdG9QjTGCgOpG8OW6XI32ep3N+oCKoWIf4j9rHILKqN02h7?=
 =?us-ascii?Q?js9lwRpwol6P7O8QYdE9IA5wfm1PzbYIAnM+1LVZ9oGAvfvadFqyPhuasloX?=
 =?us-ascii?Q?QnL77pRVP7TgvZQGikzZFcY0TKTZ1ToabcCht1zrllIesErz/HwAiSAtb4t1?=
 =?us-ascii?Q?phnRu6NZBhsGOccq5A3lEq7MKK/IirEvwXtqUWmgvO4qpOgSgtskGA/2VHfa?=
 =?us-ascii?Q?FwM7OqJTC/wFKm2/yE/BFeWp2X+SPtDlR8tr4fDSL0iMrFgIfNmxH6W+J9Ov?=
 =?us-ascii?Q?6mBJu8Zc1MGwsXQMV5R0PTDPIykPVNuCitynjG8s24PbeyDVbobv61qRLt1D?=
 =?us-ascii?Q?nV3L89UgYE7G4wnmYMR7FSc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a498b123-ec25-4ea3-9dde-08dd045d9a22
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:37:02.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr/XD4Ttbr89CgaP89v7hhxqI4IiTIgFNjKVDt0hRLAxQfUSyq/wE54a7zGQ9OW+tn5Ru6a3MsGhg1OPZqutXzlZdOC9CxlLDSb4Ya2N+z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10338
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avoid it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 153f5183b25..5e76b1a24bc 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -36,7 +36,11 @@
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.45.2

