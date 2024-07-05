Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DA4C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C3688607;
	Fri,  5 Jul 2024 14:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hvjLSkPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5022C88938; Fri,  5 Jul 2024 14:50:35 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625E58851B
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 14:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cplu9DrqegcryO1jbDDW6bYab2xotlglc5V4DkZpLO5TkS+dsoGb/9pGlpNAZu1GgVvCSRyfhWk3Iizlo1h3K0YF9vKsBXk8Mn1+bvcHgBCQmlesIiwYY0gTAMxYFzfco77fSUWGpbpx2i7Lj3tUzr7HPNVKIonHJi3SC2d0XNyjcO8SSPtEKXu6HHjt27rAY3pIoCd+5k89X5aV1hMEW6SkS20OGy2GExX22mu/oDiPxRxZeOlqyOpboJuJcd7Nd6Hdq3fG8BpPE1MBQ3gbS+PNfVxHr6kwIWSrvKvTg9/vjORjtVUWSbqWJhIvFPp/QQ0xqhpOy7RynafpJG7ZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c2wU6Lwu+Sokml1y2PWB47MLi4Dsw92x5IlK+t2DLo=;
 b=kuWltcnY4kXbRoWSf/benfCyAcWNlKZ3tnQ6VOrtd+V9drKDdDEWEFlGzfJqTLE4n25+nC+sGCsZjiX1TZwMTl6XniyZNYQL1SCi6Mr8fhommYA5GtojiZ6yqPL+4SIXZEFZt4yGWicH6zWxMWRSxlNeREGbEjFRjzovThYoXWVnblQEPO7dEYbBk+pa3qEip+AaHWn3WqOQSUKO2/fCQUf1nWBULuhYwFmVgcqp7Q26KjvKe2z5i6cIMycmobCfVX8f6x6D8FlI/Ss7F+zrx1p4Jm4lq6KC4/MoPxgPAsrJPwdI56xJPtoi2pSdXzRSvdU8fQW4L0d+AOTV6pjKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c2wU6Lwu+Sokml1y2PWB47MLi4Dsw92x5IlK+t2DLo=;
 b=hvjLSkPRwUYU6RtseIKVhq6gFhYzdyhuVQ/jWy/nvKkj1w+KroEdxQ9Z5GkmYnzUdE6qvow+mmaBlvFQfCZz77sxp0dYsrUAiF17aHToXPx93mKJmLuacayg+fAN5CZwJkEL0x6sBCjCyv3T0czz+THf72L7TGwORYDkSZhhA2hQBgM42IdDNj21aY54mzvE/vInUT6eyq5bCdCw8OHEax/L6XNVlwTREjd9g6dAixN1nqnHk2sHgG6egjYacWRQkxwWAYkT+WddXf4/0SbOj64oe1YnM0b3U8kMicLZ3edo6o+VfukKZEhQUjO7oRCJHj0sB/gKDnYOywCpXBj8dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 12:50:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 12:50:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2] net/tftp: make tftpput working with servers that do not
 use OACK
Date: Fri,  5 Jul 2024 16:50:20 +0400
Message-Id: <20240705125020.2268788-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0124.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM7PR08MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 5444660b-a375-4451-2b40-08dc9cf10d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jHoLddVAQqy1Hd6I19LDBp/1Yxi39krPZLy8f86+gXQw7iURENFc+i0vX5DF?=
 =?us-ascii?Q?IIQnhRIDBTjGxYZJ5yicOpnaqGAyxXcFKKUU0tJ9Bql4R1T8jgxST4NhRyJ2?=
 =?us-ascii?Q?I/ocASH/hBHOpWT0Y7TnJ2QPpRvrHQLJhLgWW9uwDgO7GdUXJKeWl+Ay0yaT?=
 =?us-ascii?Q?f00v+Gi95g+n9WocdGHG2Lg3q+iq2CMfPFPbTOiYz52Q+83mtRmy1PgajwV9?=
 =?us-ascii?Q?6+T9NEmRqYbvn8mCXi/QGYNfRcuJNi/R0MO56yOCJR3hv36KKwB33erYOIud?=
 =?us-ascii?Q?aak2qX21kdvch5c4jN01a9t3TN+ly/QTPFpS8ALnxhpN3QAytJtwpDifnsYm?=
 =?us-ascii?Q?Ff8082yRBVrwcbeRsmxlW38W1bDfT6stXg+1MklRDEWU0+qj4KUJ4qQZwO2g?=
 =?us-ascii?Q?fQRc0t8HMsLjtSxjbLi1qlx7F+fcLOaKorwdfoQcb6VYe9hA3eHRHfhojvjH?=
 =?us-ascii?Q?LydWZUwidpNwLpgOTbCCn+Ue9JFs/ACN6S8anQihdpTCGpkuAMiAKUHgE+GZ?=
 =?us-ascii?Q?YqL2MF5mLAq+QfXhBUirXD7LlENgRhK8NmlH2ycET3L+4LKdf4EtfSZv0BFF?=
 =?us-ascii?Q?CputmTszXNMnkxnw/t2rel72BDVI083Cg/+D1UuQNtaXw9PbYMGlZ5dVD/NX?=
 =?us-ascii?Q?lZEcNiB3vU9WiZ0/t482vNFw1BZyOYjn/1SyZxlB9onEhMacVi/PUxMGUcI+?=
 =?us-ascii?Q?mEXVFucNImg2DjjaZF2a95kp3Rnhj6nP3TSDZhlG5iAi2vXoKRDuoMObJQON?=
 =?us-ascii?Q?sJJuCSkeBez3NIRoYAuJ893EW5L438L7sskdv0Q6GRXKJSKzsmfpN3blb6rR?=
 =?us-ascii?Q?FZCMbbL9t2zNHzuorfFJmZQCz0bK2Vr6JzfK8EzCw8qzQi13YRI0BDJk380q?=
 =?us-ascii?Q?BvAqZMQTLLzMBXg0HCdxJ2ja3Gmeqc5CTjqy/gqdVt47JbraL5tNjSYv0RYZ?=
 =?us-ascii?Q?YCECSkRwXJ973axaC0cW5To1bEAD4Wp7343us6TLSJ1pI21nUa/bj3JjDcZW?=
 =?us-ascii?Q?gDwxJlcWB2YCESjgE5CzkN3xk8OsPXxweIcMbluT0IjwsKjtALN/We3QKQmS?=
 =?us-ascii?Q?v9efYScJkH2iVsqxPpMSUBcynkbd8nm24+ivj1Yz/xaTp5y7rmCw/ZvXQhC8?=
 =?us-ascii?Q?bn153/st5J6Ypqb6AKaVvSbe5QWe3TzW6Od8G7t3oY4ss99gP82Fd13KIOOl?=
 =?us-ascii?Q?dDVg11Y2R9fBTh6d5xAXRNVNKWIZMcRh40gv++Wpk50f7H8c7fL58X8u/MDp?=
 =?us-ascii?Q?7RH/sr2cYKUjhWOA0qSdpdLHmFvYpUnSMKdAJTe6+DSOgjL+n0yQ/9yevwCp?=
 =?us-ascii?Q?lT0TWdP5OgYbbYj6Gl6Cy7avwBMjR2mye2Gt0G2/Ymbp8f2MEec/W9bWZIjB?=
 =?us-ascii?Q?dGvbRCrLrhBOhsLttbAROxGUyfwfGLZZs+KxiuwZo9bsXOGmkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTcbbdfzsCgNA+mqK4Pn831FWLt4p+HlD+dnecesFTE+Uq9XMf5SqSgAH/Hm?=
 =?us-ascii?Q?XG4Lx6a3Bchwn2EMtDrcrHO5IsA3I+a2KYgwOWiPiNG9SBHNRVXoQ8mUG/gr?=
 =?us-ascii?Q?dTYGop1hMMgVXhhppnKTO2w80YGvICgajCqe/K/0IKRZ4gH50oDPudgtuz9C?=
 =?us-ascii?Q?wM6C5lIyhKlHVfxohPFtdLOwnR0cChIKACP249lwHwV9QiKMHKkG7RiLMnIk?=
 =?us-ascii?Q?rXCzhLzLaLjVd17WPR8WMGgYGNkArIo0wbdnaK7LAqN6DgriqgM2zj1Bg9Nb?=
 =?us-ascii?Q?6A+g65QfQOMaCzVSg+fsfALnSBmdQ04tGLDPF/7no5BhVwq0rub72KTv1AQ8?=
 =?us-ascii?Q?Fp0BQs0SySTtmzDIKJafW5fK7S/GztqAycf9on7bbFEr0qiaZlYy2KAYfKKC?=
 =?us-ascii?Q?+opTGhRplKMDAvDK+d/suvUMqG12GUxDmAKfCmurC67MeDgZ8LJbsFDi2bHu?=
 =?us-ascii?Q?C/eXeSjHjRsXDTv/U+HU2Mt+RVrQJNkzahR/CnxCyiYkmVrFlB3Rmh0DytMe?=
 =?us-ascii?Q?pFM3HEbw37Ho6ZJOvTo2Uz7wmPTF0iJv+U28Sgrbq9fp+LEqeBUtYGtLWZx/?=
 =?us-ascii?Q?+otSRGG1jAfXfpgUPtjavCE7cy707pSAQPfmAxCW8o8PNRnVDWNTC/WlvDxW?=
 =?us-ascii?Q?HpkU1uBMQkaiMYjy04rWBYjOXK93mjrqMANt08dAlsm4x35NYIkVqrwyce67?=
 =?us-ascii?Q?E97Pi8WOlKowYa0lYdG9T9IqiXQ2sk4zB6bThbU/rLCkCwJA54Pl/5jahl27?=
 =?us-ascii?Q?uTCNfn3B/WsZdlO1fVymdStOL4W71OsHe3qZY4Je7ludtiA9X1rZNZu8ob4a?=
 =?us-ascii?Q?lMr9JtrFL4rhP/WctFBkmcRPNB2o7XcySyYo9n77+t2F+4zDQUvbvitsRwY9?=
 =?us-ascii?Q?PrWTWwqQxTPUDMXeCvWVlo1nLMlLnsq4O1vg4yWMjEFnWiPEFZ8gKuHSaa8V?=
 =?us-ascii?Q?whSjpQgrL1K3NzXPIXqAyQm0DxeaMgY979I86bFXrgJyDAxA3O3g+ftYttgC?=
 =?us-ascii?Q?9Mqp+4aJcc04I8If6lBzeVpFtfMYixelMmE0fPA9YRfScs/hSNN3O9MTFEJD?=
 =?us-ascii?Q?mOlDQQsassyREbUPxFGs2PUbIepZ4DyhYM8PspwNMvTcPFPpdpeDdDH/HQu2?=
 =?us-ascii?Q?yzdxXH17Li/OaPNoXuUjZWCjAIhA5CR6zoD/9bXapyWlyFrsp36mHimLqr+1?=
 =?us-ascii?Q?H46HVKoK7gX0oUmHysLn8wlnq222EQpNDu2fBtOzuiWjZ71XTPar/qOzJnZT?=
 =?us-ascii?Q?UsXAHam7Gt/Wh7bDlu3NDMJtw/7SkWB8JPIrXJei7J9zWE1Xesijp/ji5e/l?=
 =?us-ascii?Q?LE8a2w07H43iZieUdR0wGgt7O5xlgd5oNGxlNcaBdKys/Zpfa1STzAIXfN0G?=
 =?us-ascii?Q?b/GghvoGKfCls/4GE3S3iDcQWVFwTH5fOqaeIUqWhgt65N6rfXnOKSiYl9DF?=
 =?us-ascii?Q?CwDMJ8QMhbbnpoS/dwULpBF+I1r7Pm8FYPq6ry3SUQaOlSnXqwlS03F1dzE4?=
 =?us-ascii?Q?p211oijeSK8JRGPCCP0Imv0x0HILNIGT4mApe5DTh25bSnrwmj0eFFNZHeLW?=
 =?us-ascii?Q?dXYIf/dSvCXYeN7o37VFB6KkGmyRLC279lqw8r3KChXbGdDynIqL5NRwWpdv?=
 =?us-ascii?Q?jtBvXBD/p9+XNhvPB3Rm9hU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5444660b-a375-4451-2b40-08dc9cf10d61
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:50:30.8525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+6R67n0cNFgj39GJN3Ma8QERHS6PziTWveBpqQr/Vds6FfFm+YI9y8oqsdZTMx+MMW51E+N8sCBv1SmlDWDvWFUJlUTDs/2xAnF7Nihj5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
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

Option Acknowledgment (OACK) is an extension of TFTP protocol (see rfc2347).
Not all tftp servers implements it. U-Boot supports two tftp specific
commands:
 * tftpboot works with both types of servers,
 * tftpput waits for OACK from the server, so the data transfer does not
   start if the servers does not support OACK extension.

This patch fix an issue, so tftpput works fine with both types of servers.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
Changes v2:
 * update patch description
---
 net/tftp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/tftp.c b/net/tftp.c
index 2e335413492..2534dec1c9f 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -494,8 +494,15 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				tftp_prev_block = tftp_cur_block;
 				tftp_cur_block = (unsigned short)(block + 1);
 				update_block_number();
-				if (ack_ok)
+				if (ack_ok) {
+					if (block == 0 &&
+					    tftp_state == STATE_SEND_WRQ){
+						/* connection's first ACK */
+						tftp_state = STATE_DATA;
+						tftp_remote_port = src;
+					}
 					tftp_send(); /* Send next data block */
+				}
 			}
 		}
 #endif
-- 
2.39.2

