Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77393ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D9E88EA8;
	Tue, 10 Sep 2024 00:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="C0ksSpck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14D688E56; Tue, 10 Sep 2024 00:27:49 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6D188E65
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5oADnLRajWCC5qXd7zEl9YVV07190vwX9pahGTLz9O/45ZCJs8zCVRzeiyC1fw+CXbcHOaHwaQhicaL+3Q3nC/Vr5afe+s2P7ZIH7BjOdA268KLGxB16/qXlFj2yyBa5YQWhVipGkD8fFHnzOqusb8bsDMbEthmwkaVaRzB32QTsCmjDngiJskznFLUq4xMErYJFlBZJQpxJIam6BOKps2wvb83eahpy+bV7mAA+WqB9a+1ShNL0oYROYGc8m4xSy8hMwSuSyxv/ZHWjRW1j/A2fkcb0LcjAMW2UyogNOdNrdx8eZh4TGedHecn0qL86P6IQYsLpm10+Cu0UTNLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tyz16sydUguFVlbMeIIs7ru3vxXPlzW+bD4+XKxcy8I=;
 b=KPZT6SXCyx9jg/mTovPzS7aLR3OS50ZxtdNN3cvsxzg1+QvIW30SaSBWIeV7uS4F1eqYCydxwCCASMHYUWKEE8iW30xvOW1IYwZTYQ5AhcMg97gCSMcBJV3mPyTlLsaobqpOYQir1C/W/pmsZ148DS3nXKi7nK61+hCES+ScYayswoAPT+s21rdI/pag3nGxz3NCFtUxuPhECjf8sSrIQa9Rlk2SZjh0lk/XPNaA7DgMeCrWllz2CEq5ITk6fU1hseVABa9x8GHu7nZ8nm/Ue+L2uuQVS4GXNuJkMzOOAT8S+nUg2ywZO1RdQcXCalkv1SDMvHJipGv2RY0zbd2sqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyz16sydUguFVlbMeIIs7ru3vxXPlzW+bD4+XKxcy8I=;
 b=C0ksSpckJyt2RqVSSoigDaKd3vN8guR9qRQ0ayyxxDokx1tbW28bKsmEV9yW61mEo7BmCUiX6RWaUj1hBo9Q2Tr1NZZYtuFVy2BEg8unggcPFHmLXR6J6SEQHt4W+GZMR1cqw5ycWpumBrGKc9bcMbSr/6zQQmhGrFSmcEy42hMN6hDU5ZC1VHIC+sZnbs7GbXHSa0rPbWgagufUgdupY68LpG8XnD1yQ4NyiU0UxYwq/YMpMv5AqDG9EQ1gpzia0+18gDbcCHJpFBJoTmQoZWKB2y5i648mxNrtcRKyg8fb5tR0sDfrvL7tEqBjTIYgB5PM0fuqFCQNr2K4E8NCtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v6 09/12] net/tcp: define a fallback value for rcv_wnd size
Date: Tue, 10 Sep 2024 01:27:17 +0300
Message-ID: <20240909222720.2563118-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b32b8d-5f5b-4ad5-4c4a-08dcd11e9eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kqQGj/eShQaDkvb27eP+MeHYXf4cTzFBv7eZClQyL/9bPXq9sVcBnE15Xyxs?=
 =?us-ascii?Q?BsbuzvQpchSpY8Zsq2awx5QC9AciGyegydK3RNZtM+WtwZtNfodgxFcrMJa3?=
 =?us-ascii?Q?14Mt2uk04wRbbBC9AcCO3zJAhCDgZbrk8dLCP1JrNWvNn5EWfSMhyQzrJr2c?=
 =?us-ascii?Q?pU/Cqyw3pDKcZGidSeOFwrsNCFTZMBYxSjjUdH8cWRPy7pKs/SuGAibMGADm?=
 =?us-ascii?Q?uLAusrhu04D5lj85TqguhN9pAmznfqB1r2NupO5/ExcKZ/gO5dYwip3mPOFM?=
 =?us-ascii?Q?DXoh1p3d/F2TEg5O2wpf2BB9cnjKilwf2LpQgeGVJ3UBdhCcdYLA9tNtvz/Y?=
 =?us-ascii?Q?cOo/c1LD1vo6KUmy/BOOd/D7shSj/jxEJzmgpEhbCtI332mIDIDWFmwjSTAw?=
 =?us-ascii?Q?abjD7EwiNQec8hqJvDhNvLGd/zccBi9hIgQM4hnHu8LCV4oI1e7paL84+led?=
 =?us-ascii?Q?az80IVBLGdRljuUKlJn6UiIGz43kGcXnYyqecxnkm95nc4D0PtEyCg0UVGBF?=
 =?us-ascii?Q?jPa+srhcbhUZiTeecDS/vRghYotWDa69qrkhTpNgEq7rOe/zgiUVwRWi8c77?=
 =?us-ascii?Q?6AuwC6b2+9dsnO4WFgnxcP0egaWmFX/GFVtsz3LwU3jae4rcXKog44TrZtp4?=
 =?us-ascii?Q?fck29W1kdB1orbsRsdU8MWgHixDN7y3rgya8cLjUbVJmrMseFpu2zYIEw3lG?=
 =?us-ascii?Q?gaU6ENq9N0jKvGyJEPBEqwXKzOC+8t2X1tyVhoSYQ+FcnhqVTeWjXzVs+BJX?=
 =?us-ascii?Q?130RdrdbZRqQ7s+GCKkskOO2zWgaXIX6Br4jvouA1Vr+bnJENePxeRLh/g87?=
 =?us-ascii?Q?bmFJEyL3Qm6WQ9DIxRulBobcSE6gx71N2DqYzUvSbyldMwb7WXxPLYz5xYnE?=
 =?us-ascii?Q?DH0AR0UmDxN2tGY5PZ5YDG1enOg/5yqpYja1lyxsf3qnzUbM+sjfIPXVIrhQ?=
 =?us-ascii?Q?hAZVeT9yJVuLLC1PD6lLNIBxdRHaB63iyRJefKjbJqf4BM/eT+l2RCpE7e9C?=
 =?us-ascii?Q?9TPXrjFpztwtqkRKponHJvlydcrxIKt41Y2Te3ULFnXiXvkdIAFt9cWNsJly?=
 =?us-ascii?Q?zbLG2U1hpxXIKeUgpEVcZeWJ0FzT8mUnVM4C3kw+HxRvlRmobEjoM21u/CIx?=
 =?us-ascii?Q?u0mf5ikc5F6Ves2NaNbUDPXjpfekaBBYKTvD6RX5LpSYVxk+ji2Hi7FKkzh6?=
 =?us-ascii?Q?2ycWqAiVyFStndddej3DCcSYE5YaYeNr9uAkbGdnIKUrfGaMG2BRKlX39OmT?=
 =?us-ascii?Q?1tZ+0+YOFMvHVEG3vOcG3f8DMh03q62Em9QKeqvNwJN8hKAc6UWwwKxL/h93?=
 =?us-ascii?Q?natfRu26n0Hh/VNoHkZKnfUhIe8RsQegVdmW0/LFQ0tmk500S+2Q69G7pjL9?=
 =?us-ascii?Q?hJgqQJ0z6cjuv+3r3ltwCeiWwT6LxajNzFXpAEmVvVp8v/L8pMh6+9miboAa?=
 =?us-ascii?Q?7yaqClzleTM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9fWgfzog8y+0lasTTVBs3RnVbLtnx3sio8odu8uaVqS7d7o1h2SvhXxfq3B?=
 =?us-ascii?Q?SD/iL4Od9nVaoKeS/yvJsF/ZZfWs8RLUSB8Dl/kAGULkA6EVsiKkOc+wAO0t?=
 =?us-ascii?Q?WQ2xUKS+gEAw/UQMboG+Tx+UzZn1VG9uvvHAq6FPAnp2GCSAi1tUZTIQ3F5Q?=
 =?us-ascii?Q?uX93M0IRxwcV9RAGt63swmhvuDP62DX6tVHiq0/czta5YtxstIUXv/VGKwzb?=
 =?us-ascii?Q?xcfUfXDaSa4e/5+I+/ReiY5iM3te329Clrk4IdODTv3Mk5arlAf46B+8y+IY?=
 =?us-ascii?Q?6WqCpKP361xiC/IN5QcqwmNpdwW0oNsutOguvdf9RaLYPmWjv+M5pp7rKGym?=
 =?us-ascii?Q?oF+4Uu5+A1acQyXsIad+oJ/XBkIDExDsxYgW2hrpQPuljEE68XTqBntpVTmU?=
 =?us-ascii?Q?eTCSWOorCMeZOAEoMoqpOKJOlK95jievxV7BlVANXpvwR3aLmWpw2l5C2euM?=
 =?us-ascii?Q?+HKTauHNPxUIYlHXqodw1yBbU8RxEjI0bhnDOtduzsnzmqyknl6itGj1d37n?=
 =?us-ascii?Q?AOxuzOf8ka5E0X0tvh/1K//ErSDjvGMbJQGcQqKgIAB7oMvIOwqNa+RALayA?=
 =?us-ascii?Q?AEsZpaIYevEa9YHj+2SLaR6TKl4e/jdKdCQp+hmF9kpYdOQq9/BwvsbQVkgx?=
 =?us-ascii?Q?bDog73zMvWazxqZy/a+ltoN7Ku2291CoJGamc0LY4AE9a+U6kyLx349yA0Y3?=
 =?us-ascii?Q?FkP36k0mCrrYEjcbzqWKiC8rdYvV7O4NmdqcZ3oAO777u6Q0FTlR/YRQNRfV?=
 =?us-ascii?Q?tZsOQFlwinv9k2DDvDyf//UtXEsmlDMcU6coQzGZn1x41rjWJUDDMNVgTlx7?=
 =?us-ascii?Q?2/RA7LUVB1g7KglL5Ioofbw3oMKOTB8F6w1ovsj1uXeg8Z0zmp9B+sLbduh+?=
 =?us-ascii?Q?RHuSfy+bBqlAqUDM1lAGVSLAF2wHv1TsFosiNLsUjGgHaWEIfxFDKgSJYz0a?=
 =?us-ascii?Q?gwHTl2qpYf4okfp115FShji8P2+UFHfFXwdG4my5mrE6kokkKUkMj1BTr2r2?=
 =?us-ascii?Q?wnVgN9NbyL9y3xUN+n7V0GYqxyjEB6iG5h5pnoKQ5Se3cTMBwGzL/UrKIzWW?=
 =?us-ascii?Q?6D6xDOHLlgxZdmZIaQEuCV0VPp4+aqooG1ltHMEWbEYle4FA6EU1n9yFrN+O?=
 =?us-ascii?Q?Ygjhfef8zOSDrB8/FxCou+0s3dFqkml6+uXydAk71dsJ0km4t4pDXLkOxH/y?=
 =?us-ascii?Q?yw+Ag8M/0weCwATLni4Jky53lNerkWvDYYLzUu+986eF6ShQP/J9EH8s4gBn?=
 =?us-ascii?Q?O1VyklnGbnTnlZYF1cDbEKZPwolkL9dbYBTv6/Q47zFHjOEFkLalOBBt5iVn?=
 =?us-ascii?Q?sIv0rYfxpVyz77T4RycQ7tDlqUHlsLcEyD24OeouDplG45gxoyBlEjWrJFue?=
 =?us-ascii?Q?QOaXsk+S8zApjW717GcNYeqVDmB7HCmFm/cM71rXVeH4TtKHneb+uOHBYjOH?=
 =?us-ascii?Q?NvocTaHkztOUL3DlcMupGFmONKqoa6J2cWHRX0XbDji2EFydtKJEBhjiFnOV?=
 =?us-ascii?Q?Q6QwXmlIkxE0B6uktQFPuQYliuaUmVJckEP/6Je5pJv7Cp2vH+eVkW0dmAnR?=
 =?us-ascii?Q?8+f1FFmDPxzOKdTehF9OOsQAboSmpCdhjSlZ6leq6w9XKLkYRTS6X9YMU0g0?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b32b8d-5f5b-4ad5-4c4a-08dcd11e9eae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:42.2864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RYTNY4cW3BjAu4d3LHHGvzjlV6ZldtAYvLVdlLgvAdA80Aip6klG3JUIeqjGSjtWYFguvp/e+kSbxdV5i+ziNbgqWXmTeANXZJuIngVssE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8722
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
index 0778c153aca..32ee1fe03ce 100644
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

