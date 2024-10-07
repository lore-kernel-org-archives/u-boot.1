Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7E0CF887C
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62DFF88D54;
	Mon,  7 Oct 2024 22:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Bkd7m+rX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340EE88D54; Mon,  7 Oct 2024 22:56:13 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0FEF88DD0
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuV2Tv71GRwL3aUpmh4t67niwJDQt2Y0g4lcel78qqiyKDhK3NNuJJCBkE/0xjZG6rqxyKGUlgMJd6PDA4J+rjSzfVlcb4BtpqkD+gOZjGa/v7BXOQUsVuqzwy6Sp2KTq2/3at6MFwLphjJHo3rbTPLEEc8gRBW/7E4BugyWyLh/qY3M2Q1ByXfCUvpjteLeg/pdY0AEhJzgjhkPXLQMMhK2MSxvl1asQvku+PgWH2x7E/bonol5vXQ4mo6A1MDUIi2f+7+Ewp6dnSMSqOIPGKvN1jRm1dNRdH4BaNJMD8TjzTJ2nxZSM4MKkuc3xyvIsdw2lgX9ocjex0xEZjTpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUbsugg/wp6TNPRhq9DAJ9Wh9YVAw7P6tiwZVShWQpE=;
 b=atlBLkV679H1x8rYK8kfDa5zn7yXE0KePj7fdBJ0TXvxWKuJtZvJ6J2nCo9FjGDTkSGzfLtFIn0StjSjgn/iB4v7EjSDlLysgjCOUK/Ai7vYGyFMW5qeOP7Y+nZAkRykSp+eUmzbQW72HJ8w5O8BzFMC6RHivm5hg+G/Vhm4nRxD4ofBhzV+Cc7cXYOc05lhlpoa6QBROuNZaDNLvg/9VTmqLEnB3ug3xqs2cAE5Nbu7Z5Ji5Z58PaO8dv8D8snc3Lh/sVC9RoDs9+Eh/pA1ifVMsCjKK2swl6DkGq7vPZlG7AUlYUiVu41clblZjjK0SP4XcGnAVlmigNTPGGsGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUbsugg/wp6TNPRhq9DAJ9Wh9YVAw7P6tiwZVShWQpE=;
 b=Bkd7m+rX6eHEEYsy+Ej7RO9hHn1LIZM4N3T9gKdI/6WfEcX0Xcw2pmn5tO3DVedUo4fxp61Y34HqwEh4Pg3SXbvGmrIyXNuyQ8qPL1Cutudl5ZDhm1vjfXzcgOP++ks0WY+UhRME2HBgvZtc3e28azdaFP7IJmERB3Dy+qyDAQnCvo4Ce+tVH2CLR1KiCfT9qmmz/DvEwFd1rXTKMST/MILReS1D/hgHQ7byAyj+eha2q8MXVCX/w+riTv5g1tRwsV7+0Thy2WPCqnFXfp3rrxCJ4/jukEHGzMiapDmuNSPj7RGbV9JIZrQBLc+ue/PiBDNlTPAsIaZvF2469sZ0jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:56:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:56:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v10 09/13] net/tcp: define a fallback value for rcv_wnd size
Date: Mon,  7 Oct 2024 23:55:39 +0300
Message-ID: <20241007205543.1632499-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 6807b8ac-44bc-4921-3d15-08dce712784c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ssd3AwB0utnEZ24y7sbrnc8mMOjaZOtrANof2tXkPZ546m6MRbaKB8fJ9pon?=
 =?us-ascii?Q?x5VRzFlb5Y4f+W0u0gfKHbuou3vemB05x5jg6gWg4h4xPHtDeyQAlRK9IBIE?=
 =?us-ascii?Q?ZimGzcsfRXgeddemt7hbYRin0ONbN20WmPEm4N89XXiDOwXnr3jChFlNEIsF?=
 =?us-ascii?Q?I/c5/I504ugcOHBHtemWJeZAEeIcZybnCpbedE7VahjIdLEOQRsR5msjDRlA?=
 =?us-ascii?Q?DzadQvjCoXh9ggfqcE2yvf3T8eqAgIlqsJHhjZV0yopBbe2Cqss8fv+jTu33?=
 =?us-ascii?Q?RNrq/xGC7eMA2SiTJ0v0Y4Y09XoDuYv9Hu7iSqdSlCahBE36Yd4z8OojnKY8?=
 =?us-ascii?Q?YovuYkv2JuEJQR03IimYvcM79v0ytHJC2JCSIWMlhBE7Qc2gYWpUAwIgMNty?=
 =?us-ascii?Q?q48Y9YwemSYXzKFTIM8+oDrplXp0UU2Vmcbl5ZzNjjbcMHIPR9ezwUVlv8Mr?=
 =?us-ascii?Q?UIWRsGOSTH4BTYykCmzCWUyAsNkhO3ZbXfrzPZH32P9EHw5tuvvQ/YKXSA1T?=
 =?us-ascii?Q?vra5y/fBeLUk1sC6DGUiChiahtaxdsETS0vdY4k9ikUrU9nb7XU2Kp8gEhDT?=
 =?us-ascii?Q?7CBQOZ+U+Vfrl2YHOlMpChr3bZ6kS8gG82/VEY9hq0LYzawulYDfy3jdGfQ5?=
 =?us-ascii?Q?/d5XjbEe8IEwhfyZgpVqNQoZU2vksbjmrrkzMb1OF/NTAJQxDu4YKCHftFhk?=
 =?us-ascii?Q?r2g75WSj8w53fQUtpcCh4VKopT3FE2NVEJ3wiHEUrpZnTVXfN0HQrx1fzSWs?=
 =?us-ascii?Q?ewlIheX50KwsvpF7stMP0hUFtAky0Hgug3yV33WWyOT+y2BMLuvGffPV/nJe?=
 =?us-ascii?Q?T8KkQIheBJAbRYpwMi3I3CCt7kzGqA+nCQqT3bdbmNf2XcYenRldKMHUF2xz?=
 =?us-ascii?Q?7a6KOnix0Q4Wff5hmEnCMKcCgDpS55PPJq9RCI0Zd/2juKbrKkRMQMubKZZU?=
 =?us-ascii?Q?7dY+CNieG1u0t+tUJG+ENDntkQv1+QOm48PswahBJJgn9+lc6qCiMnGIeq2L?=
 =?us-ascii?Q?2UQBQO6i6ETpzgSdXvdsd/FV0KKTJcwawaNFEAQOyys29CfY1n4EEaY7bmsz?=
 =?us-ascii?Q?uw9jvP0pM3eFw09zTUOZLIrE9+cX7Q/+V7Bc+0XhwhUUKcPqOwEOLoZu/c+X?=
 =?us-ascii?Q?I/ZO9UI/AjZZxHFyzCqg5V/Lk9xHibvosSBEWBYzwB1JIGDGRCSfdIT45Z1d?=
 =?us-ascii?Q?eQ/ajUOy2M0vWKERRgFz1ptmLhnryeOyUE+aNaleXIzXcxmUSz7S04ZLGP3m?=
 =?us-ascii?Q?+YKlujOkvV6cGjWLdNFtWkuVslmTUXxls9mAh3tSGkHV360LTDP7avs9ntuN?=
 =?us-ascii?Q?NQLxVQjMfgdu31ircIDjUEsPBN/oOlE3Yh3NlxbVhjQXvAwZocj4aLCuxEvL?=
 =?us-ascii?Q?2Tm4tQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NSds0QsyGh/h69pF+R+jGkP7MU7LiNhxst46A65qSyHbPOXKDMgGPxltluGS?=
 =?us-ascii?Q?au6zxAvSk+u58U+Y9+1E3I5swthvfAQ+hOU22wcRXsOYbaqdQdVmwC/Mncwg?=
 =?us-ascii?Q?EM2yPrbtuHzMoRu+GavHwRwsK0FnKHezxD1pYM6AIj4dIAyGtHkCPFaZ+YRf?=
 =?us-ascii?Q?DP2zF1de/ckP5d0G2bRb/blRzC0vUO7QHftt1Ky1gMznAa+dFqaUuXW9PLGF?=
 =?us-ascii?Q?mMD36X9znMTjNz4HbNpCegS2vuPLK9uNCpe5ulbcA8d4UM0eI3uGfRyAiFD0?=
 =?us-ascii?Q?pu20CimAoBdNnZButrndP8HECN984T9acU5ly274Imh1/s3uCLVnAjUnIjUu?=
 =?us-ascii?Q?t3kJM/1L/lLjDTYKNvY1HPA79AUxrbUJfOEopcb5HAHsUOE7b7BQc8qfxqe5?=
 =?us-ascii?Q?uUPVvpFJG8Q8JgcrCq1sgrIsVTUcFV6M1kdBZ6L64vsgamqKq+pb4ZNku5w5?=
 =?us-ascii?Q?OvDZ+ZsiwtLz4qOKYXSKQfjn/pD92HN15YZiUJdEwOCeSt7nBa6CnPQB3Q3V?=
 =?us-ascii?Q?zDitXLHEtoj/Y2c8l5SUvBkkF3rjj79722R4xroEZOS2ULtJtbwEK7Z/pvHN?=
 =?us-ascii?Q?Psz8k7xdkcUVoEDldgJ98up2xhmnAjmMJFU20rGQbTHWnErOInjj5ql77g5Q?=
 =?us-ascii?Q?NgUSCBfsmHHTtqKtkn/R1/1IXHr4OEYapGmxrKFs+/Ux3FL/CBmwI+gz0PSq?=
 =?us-ascii?Q?LcSN+ieNSrRatHnworkGMX/m6jUOdDCHdXZC2BzGby4h+jVTGE045P5PJest?=
 =?us-ascii?Q?cJ60jmBJILjWilC45OYU7Y28P2hjT3CEOKVgV/lhQ2yYSzNviPARlr5Hv86V?=
 =?us-ascii?Q?R7TbclTZa/prJE6S3AOnDdQk7jDPMAaL8fcg+zkGLIEubDzx5/GQ4uVeBX88?=
 =?us-ascii?Q?72JpCvDssouVapFN5DBq1mgrxjQKb4ispWeRdLWYp9oQxaN2btr41wB2wX+i?=
 =?us-ascii?Q?yKq9QcX9ThHZCdTc20mtEdaIBr0UjDfKKb33KiNpp7pUA1G2ORi7aGBFWlMs?=
 =?us-ascii?Q?8k9Ig4z4xWBwb/jQLEjIA3CZLhuet6Dll7/LxKEaKUG6Swcp+kJItKOfqrhj?=
 =?us-ascii?Q?YMmPsOmH6T8B45zh1aTxCMOvxtiph+PbFT83Noy28WnjwLPQcqNilpz9m4+9?=
 =?us-ascii?Q?HBLoqQ0cJwjdplYSbuXhh1ZfWrDvDsUHLrsnJAG5gqWkV7GEBf1u8pzRHhCe?=
 =?us-ascii?Q?7XqsmLmxNGQUQkGB9hxaO6OxyoHQdNZuoSMXf9ygoAD7LVNkGlJA/DtqaHQB?=
 =?us-ascii?Q?uVajW9/Dp9GqfAQ+33yu5ihrKeLwcnpy5mkdIg5dwVHMgrAmmlc+n5BPn6WE?=
 =?us-ascii?Q?WhFt9PoiE+H55fBU/sPmk+ZsxGCryDHmncaMHxQRj1X1d2ewYlvCOQDXtuRj?=
 =?us-ascii?Q?oRSnBzzREcShKDaQRW9eDhEHv21O9+n/JMB522XxQ/JNDrUELXh2kEg/fbIL?=
 =?us-ascii?Q?FZXuqUCJIicZpzJWEE+CLx5eoGUALSBFtd7ZsMgiNSco/ZW9URPXBZR1QC54?=
 =?us-ascii?Q?HUDF7ZzEc3AKH8jleS4VOuiGtd5BzMVlV5c1ThHtl/pDACvyG+fSS+OVYLiJ?=
 =?us-ascii?Q?WXqzsVcDdozX+tGaB58ZaPQo6oSDUfi6pSjwEYM4YOaewb7tM4u+fr2s6maS?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6807b8ac-44bc-4921-3d15-08dce712784c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:56:09.5038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7KXLECTVSMWTgH5+ia1inf+E5Ht8Khu5EDROqUCaZqP692JH6YUInjwCaX6GaLghzGoxlPy5ILJ/2tEOfJ2ZVClN/DH5Ygp9nvfU2nicdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7644
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
index 2a95c44b141..b950d2b7727 100644
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

