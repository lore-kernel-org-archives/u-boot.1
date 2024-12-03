Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438B7E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985C08964A;
	Wed,  4 Dec 2024 00:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Sf2tSNIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB82D89534; Wed,  4 Dec 2024 00:27:46 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CC738966C
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpWSsSY247fXEUIjnWh6B4rt16Cs1k2ppguCXnQQYmUtoQ7KAMjuqT8ZcdKkzn5QRPx44d7J8swNc3b53RvVymozXPgKe9G1HmxX97bnQxYKHitZbEDhfrnVQWcQ/NMWHQDYM+djXc6BEtJ1QAIfxAxk1/ESvrSJlCHzhKY46vXeDRJXJXiB97tzqQqM7dd1EKOIxnB/0/02K4r2aFoBwUvERxsZKk58W26pmX/2QcJ6y2IVO8hYmlBT1xy7BDMXjDUlH5C8iOk9xy8LANcHzufoGtlRO2Jk2Xip0CLEtLIR8TMCEhHZrYCu/yNYRa3E6feyTeitXSF9CNtB2XJTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IivdjE1LWmFrSOs3pxgNVBmWaFNudXcNpZdnE9bVfeg=;
 b=ZKepamnsoSfCMKU3K4QJzJtvYoljBE/vhaWTgFsKp4YXY6pBrAMkUDaIIk9CuFzxh/o5j7CGG1Ma2AWdQ18LI+ludfqKDntv9HMJ1FdBzak4Qmb6Dn3iTiG4Vew0XPiCBoiNgRGVRjr2gJJsAATbX1dNN7EonJhS3GsqNv+gMnMGX+bnAD/IArcLvQL4OQ+R99sFWtexxpGkXkw6IE3QvkPjEpVc7/tg7a27cG35j9yjyPvJBV1r3sjPCL5QdDEhimS/nXdBz2DK+6KxwsU3tNl9GBK7tzyWmf8YTMu6Qq3p+mnGinyWQgwGHhH5Mt5VeKO1ELib/buVErQ1cyv7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IivdjE1LWmFrSOs3pxgNVBmWaFNudXcNpZdnE9bVfeg=;
 b=Sf2tSNIxq/H5d/G5htRd/7maDr5UFXvzbk//NQ2lfz8T8gvfnr4aI/I8W/1IJFOq5RqUDPL1xQRdQjc9O6kpcrpDzXdobItz56HU1mw5Q4jhENy6tcuhgWW8UXWoW5A7tgUBXeWV8RJMca9nGhulc+2sISy7xDrOsGS8TTOwFhDenHNwOBNHe3Hwk9dU0v+IaRut9Dax0ceLuKTAPTM89O+hyb1O/wktMFPiY8qylYurdV0p/7mW4gSnf9MWVfDnungG3eYaNF8uUxOIeftjky4Wb6xd6MASEWEjArsBLt1vzpOMiOODVhvpFUc9DaRcXds1dXKYsKtlspVEXH2KUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8955.eurprd08.prod.outlook.com (2603:10a6:10:466::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Tue, 3 Dec
 2024 23:27:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:27:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] net: tftpboot: clear timeout_count on every successful block
Date: Wed,  4 Dec 2024 02:27:32 +0300
Message-ID: <20241203232732.2680178-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1641c66e-bfcc-4eac-6dea-08dd13f21410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oflia195yOOuGoiuPHCdsVYhb83enAvNo7xRQ/OJNEH0+So8Qk/EgHsDErXX?=
 =?us-ascii?Q?s2Nxpkj78Rr92MsNOm2XNCsdXPM5ZY6n/zqp621aNJC4ozWa7Itjre2ujhA+?=
 =?us-ascii?Q?idhyTBL7WUesf3pL5Y1S6+ssvKMAvb2P6ObyjsbxnxgGX+jwIl4PL7duJbaq?=
 =?us-ascii?Q?lvB9GYZPvNXpS6fXvoUgcrxBcXSvPeIPfggmITPzpMtINAYW06NqZjP+mtPc?=
 =?us-ascii?Q?8kcMfGH8+7rpYwgO6fMuD+5LCiN8Hiij2lGtE8AZLbH9O/5C3L62cBaj0+Ag?=
 =?us-ascii?Q?8N4OapfdIQUhrjwmlE+hXrJKcVgNBM+F4OTOe2a3a4iaCbDbVWh3Oen0FlF1?=
 =?us-ascii?Q?9jZqPx++Zz/RmG+baUAncvS0jxihnmGsXWMXZHcQVTIhh3UCXGpDaBXYfi41?=
 =?us-ascii?Q?lEVja7S66A4cuDS5SPNveb0L4JC0zU0O+cCOLYZsxQBfoeAlGpzD+wTYqdGa?=
 =?us-ascii?Q?yxeqrUuJy6/dnO9TnngxPUd5GWmOAu+AOIW2FJm8cnl/4qjYIzwBeyH5Ek+l?=
 =?us-ascii?Q?hP7TrTauQlkPaoQjtlkuAFvNzHjDA35VdrHgOHmteUbvBjEV/EhF9DAN6qhQ?=
 =?us-ascii?Q?dG4hTyLUEsw4GuVoApoog3KKZSMc5eUEANBTNAlWYfhkbXr9/+qZa3p4uB9f?=
 =?us-ascii?Q?iyX1awqlidrdNoW8bHdxrrjK1ngCYk0sYi6muFziH7DyK8aN46BRlo7BFjoK?=
 =?us-ascii?Q?9QmkFf6WzLPpJuIyl/KTHsbJazPjrRfucnEVz4qdJj1THiqQGuKVcNLVBftm?=
 =?us-ascii?Q?KETuTydVSEfqJmqwTnRKIbKEW1E+zWF/0hVZnijESRoIjngRaDKxg/ppb/Cm?=
 =?us-ascii?Q?tBmn+LO7YTX4A/B6wSy9E38j3uOZLLNF6ZbT6Ymac+Yk6Lais7s8oUdn7Vnw?=
 =?us-ascii?Q?805CNS+b+3xIINQtXU3mRDJzrYQ4l0BYe/J/CNkmQQP1wIkNeq6qGjMshy74?=
 =?us-ascii?Q?LydXt02AApAJ1T+7QF7phtgir8X5eQEG14JlpgU301PDfEVmOP65AMpxQ48h?=
 =?us-ascii?Q?5Tl0LTts0Bs4gtSJhlpK1sZDAN8bRlCQiRIlhAqc75vz0zKnYTftTwu+jMmP?=
 =?us-ascii?Q?XdHiYmtBwRtiNQwlkCetU0nJtfP+I8DoBbTfSbPLUPHbnZr8t0s5Ir2GQhsf?=
 =?us-ascii?Q?KUpMAN/fy8BkkIvaiGPJRUTdoKqQPIrGnac90eXguyU8bDbCJMyPBw1stl85?=
 =?us-ascii?Q?rIW35sEF4TX7FR9ZzqiEfMBO8U9tD1noJGYQrPNmpiDDubt9sBsIiJO2jeZC?=
 =?us-ascii?Q?P532fL7bnT5v2iPAkhhpWcPbKHrpgPtsjm5pR5ATeKmgupmTg3naeiQSpuDQ?=
 =?us-ascii?Q?L1Qgykg8eIL0JsiCna5P8TA7YxOP4z7q/F7RKLZ6hHW4ntLGBmldDeWo1Hm2?=
 =?us-ascii?Q?GVLNi0XWDM/3fzOU83TU8FsjKb42OXuUrbjwRHsNz59qftZZyDvM9xlNzKar?=
 =?us-ascii?Q?7qMDspQ17Go=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1uArl/wJg1J4+5Wn2iDGsSCWePBVN3jGgsSej2ydyqHFR7pl2ftrv6jmlfj?=
 =?us-ascii?Q?ZB1p/sqLX/tLbKmWlzCL4o9f8E7ZyNkefj0SOGk5MZT3iHqQDaoz3KBcbxg4?=
 =?us-ascii?Q?AuEfxLx+CRfKevuxTvUQquAkuhhisSEKYDMiUtD92sF8QlD47dnmCUHqds4V?=
 =?us-ascii?Q?3xMdb2+iZ/tQyot66pIr5gyKoND/5zKcornoTQdiUgKO9qTlRQ+Fw0zWJ57D?=
 =?us-ascii?Q?sQ7fwwjlp176XGQ2VOqrVA2iFryffw53K+EOXc8T/ZIBIl/z18/ScXwgGerv?=
 =?us-ascii?Q?pKtYfmLsxzmiBc3rCoZPySUvncGbWxZ6fMgO3qyEFFwtg5D9/H3acP8uKrG2?=
 =?us-ascii?Q?NRk3/LsCM4NpT8glQFIFMPKhCUAs5mDE73R8XO8COLItnvY80n4jEE5gdRXM?=
 =?us-ascii?Q?JMaGb6pErXuJQFgqDrulq4eq4otwdBe3ugbw7GLpkzmrlEnewu7hE5JvjOYj?=
 =?us-ascii?Q?WhEjsVOWW3CVSVAxwzr1KaxRazt8JkmP0hgXTJIeN0ZOhZCyF6Dag+jQg1ys?=
 =?us-ascii?Q?Qjbcnkfa6L/rL38RTHiLhFFIFp8oQnE2AKwrOv2ZbOP1VsHhy58DxQFqWOJ8?=
 =?us-ascii?Q?5s/AzZm8Gy43ij/zgWN+YI04jwdp28AgxNLGrh+WV1xq2/sZVDAPnUHyoftM?=
 =?us-ascii?Q?4bGOX3ZJ265+MfvafpG2V1/7B5moj4ei8fCuMbasT/6Xc+dctRomfF0Y80QY?=
 =?us-ascii?Q?JKIpwiCw3UDuUNtMjkzQQ0mDT3RVTR7znm/alODlaZ2tcE0nisRrwBsvibDQ?=
 =?us-ascii?Q?VE0ds7Uk450mhK5afC5g1pL8mKdrwOKp4+9yvQuA6vjxBJncDpqJaCZjG0vl?=
 =?us-ascii?Q?jF7SktQD9edbeZ4++rIKVgZAWUF3zdpvW51bNDUBzpqMsQQcmMvJXxi+sYAx?=
 =?us-ascii?Q?XGTDT8oqrxjGOE9rmxhn2GnnuUDUDBuS0Bo2sOovZQiJHLGCerGK3L8HpIUw?=
 =?us-ascii?Q?mX6Ac4Z6yiaC0KsYqkEbS5Wm1+O5L0bGFn0JZA6hiiuFnkptMzCLCFEaMGxd?=
 =?us-ascii?Q?RVrDezXIsiUnLLvgdGjoMnqYtT4Qcyk2aeXZ1ZVf43v0HEhAckyZkVG1bIuU?=
 =?us-ascii?Q?pN+4W0jY49wfN7YesaQZKOhlvA8/YOlj+uwVOoBZ5J2OWyBjP4vsaG7Mn2Pc?=
 =?us-ascii?Q?LrHZfwfNUsPVwflBv7xoRXcbJDfiKwe+xB/XDcwDf1r9ED3uUm+sgDvmLxXD?=
 =?us-ascii?Q?PTjdnqzQRlZreUN4u71Koj9klfGgXcZoQShiBnPqL1zDracFIf3mquqKCXG5?=
 =?us-ascii?Q?2HtuzUhcc7JI9JQxf3HTA1k0/VUM6P26gjeVAc/ot3iCrcJktsD07OMCK30t?=
 =?us-ascii?Q?+z3xd4SSKQeN+PENtsCImnOKM4YRlkV49Dt+RBotEzgXyXL8OQKDGY4nZ5wT?=
 =?us-ascii?Q?uwTbLAz+5y1H8M/Vjc+uvq+USZPm331ImJgooZFQOFnN1hUAbMLj14eJ2b/g?=
 =?us-ascii?Q?7qp46NYO16Qew0+lcrtIe2ast7lVQYEBJXSGfX65PvtccWxb+LjBM9exKRNm?=
 =?us-ascii?Q?cRRUwz7f02ypYf/FCGfeM9ImYJZEi+OUIKil/YZANtMkiWHc+ZGKQ/gXRq9q?=
 =?us-ascii?Q?KBSKFlCp/2R+hsG62Sxs6ZVpYWZCPvrqVng3C6Eo1AHY6VqiEItythctOQqx?=
 =?us-ascii?Q?eL9Gs8s7qt9PvJ3981Q9Rss=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1641c66e-bfcc-4eac-6dea-08dd13f21410
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:27:39.7967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geQxzqppfDoaZNOx3TndlpNxvrl+I823TEv92wwxPIFm1hHrq9K9KOON1uRy2924YnaPY9a41CQUMJ/JcTOPy2InfVj66VGzhqZ+JN7cx8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8955
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

timeout_count is never reset once a tftpboot transfer has started. If for
whatever reason timeouts occur frequently, but the server keeps replying
nonetheless, the transfer may be needlessly aborted.

Reset timer_count on every successful block to avoid this situation.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tftp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tftp.c b/net/tftp.c
index 704b20b4ff8..8f948204a6f 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -498,6 +498,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 						tftp_state = STATE_DATA;
 						tftp_remote_port = src;
 					}
+					timeout_count = 0;
 					tftp_send(); /* Send next data block */
 				}
 			}
@@ -657,6 +658,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 			net_set_state(NETLOOP_FAIL);
 			break;
 		}
+		timeout_count = 0;
 
 		if (len < tftp_block_size) {
 			tftp_send();
-- 
2.45.2

