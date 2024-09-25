Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC64ECF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729A288C4D;
	Wed, 25 Sep 2024 03:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="HiTM6h1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC3188CE1; Wed, 25 Sep 2024 03:41:33 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9900488C1C
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWg+NUEU9zwlLI6bqyuhXE2TKflg+4/whrivtKLXj1tKzSp6gsLFEZwUlDufC89EKeH/xCZBvPkZpbnVf8kjaEW7+WVh0hP67Jmzgvz8jC3/nBJl6cpetYpSO/677T09agh6+PV8qJxkINIihSzQEOaE9k8ngB2XmQVW5T82SgDAE0/efsS4JTAcldMGSH78Mmj1Ne7q6odULUEg+qqe+vWx/PnxDapdJGnf7PvqmO5dPReEbqevFevKvuXrDqoDQaBQEX10GiS4rtEk5EcbAd+WHM4t+jeB1Yu/rF/QPCS+/sbMtwQqhaQVpT5z8Q/nJ9o1Z7U+iOh0ARh4bdvdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk55j8b92Uo07snY7RW+GMWRLNNInYXkcXcTsUwL72E=;
 b=SHIeW4hFaKrMLuwxUXpYPQ6wNWZ7eJvREp+ivL5M8vyGn/vGxLjd7izEtftXFNGOBT74W0fNrW0e6oe5c84MdCjAijZnmlfVkh9lnh5H1Nwei+h4JuKBOBOyns2u4zOmXi2Ih+NYqgxTd2PmS4kPZAm6CVuD5lnfs6+rJ/vAuVEKDPJpZXsi9FxiVId1VIbw/OA6P4PR+A2uRB2ToX5WYUNG4wi/Pfenu3K2H4IdruQY2Q8fE0PhnA7hDf47c4aPEWRe0jUF9rcI76AWhnSG/ts5EYuqux7G8l/JP7rDtK4EIWlLWPknBK41bTNSyz73UEUAqf1CZKdkT0ygIbuGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk55j8b92Uo07snY7RW+GMWRLNNInYXkcXcTsUwL72E=;
 b=HiTM6h1svrM3brMLEOqjs3YPEDlqBkRQEbtuQL75A+nQ6hDqWpRKNxoc5OeW2Iz9lq3LFLc8uRQ1qMaqLJU1FwU5tdDmtaj/IfAktyC5pNkxbZVTi8sOtKRyon3NDwXD7oSJsENHxngEoL7e8hUItXSDAVP26LnYZkaao2IkoQsezBENeogy0OhBSWqMk54/HzvbgoJSbE1h6DznHhiHTy85Ik6inGAOnFVFgOuj69cDFJAkwTBR0hNW/eMrw+/7D21HYgfreyVRnxHA8216l2tDBmNeHCwDd4NWzzshitf4hJraTke5LE1WKqPk9FcwMJQ435DTpJQlmo8jLrxH9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v8 09/13] net/tcp: define a fallback value for rcv_wnd size
Date: Wed, 25 Sep 2024 04:40:54 +0300
Message-ID: <20240925014058.1679074-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 953832d6-f7be-48b5-b4fd-08dcdd032780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bcf7Q5S4b2oWiZBr7DPcwmavzBms5wWge9wRuVZ0z3LSWcZv72tRAsn5J56D?=
 =?us-ascii?Q?J9LuH0vnIJKp/wEdzxvmjfrqYuFO74C4uCck7NhnRRAVkWObEhhxQLf45pbU?=
 =?us-ascii?Q?3cYyR2KcNNk1tvrmSZwCqTIkUaF86FC4u7b2QSI7UOYRGj06fCpaW0Zcpo5i?=
 =?us-ascii?Q?29LV8fNEfLANLFnMF7sVnwlgFUOms49J4rjixHkL7f81Zc643GuEvDR6ZQLS?=
 =?us-ascii?Q?CgHBcwIBPKoX3mqZxp2/LnPAKKKf02TYaSxEAdpNIv7+CWJNrpj0V9mK6HZk?=
 =?us-ascii?Q?gClya8M0MOdooN/f80ivzKDrq+SSTcwm7+319wLNctAML/Z6MU/Opdh9AzV+?=
 =?us-ascii?Q?gKBge4UeeZhBPvDVQR+4PmCNcexy+DC2VYJN3D57j0HiOG1g2SzXL/ZHRRlo?=
 =?us-ascii?Q?kDPMoQ4VjPDh063qztxgU6rdqpusPK7RXg61BADuO9hPf6M6GEDf9XBPxA9L?=
 =?us-ascii?Q?lVTVmtaLIHlnwop517nxVUpcG7vkeSWj4LFfuyT+MGmSEDunZnUxoSj1WSaC?=
 =?us-ascii?Q?tsMgo6E6b6bn/lqV6SaotXxKths+jfO0JXYLbwqHPd1dm7Btnsr0C21MHTCZ?=
 =?us-ascii?Q?4cy+5F7LXkX4KQAFJC9UrftMkcclJazBc6YS9qaxsMgw4dpSi1k97tSbei3X?=
 =?us-ascii?Q?0L5LFAXyzLCZJTZCj11Iq14oBK+clZyFIYmjQo2j++l7iOSJ3fyslhbofJ9i?=
 =?us-ascii?Q?wSTjn7hJInrKBwf/bMrDjDBxDQKYJ8UcX8oSS5lTiaqKgLGunG9wFunPndOB?=
 =?us-ascii?Q?qR26AdQ8S5raYOY1ANSc6spqfnOkQGOUNyHHgZl3nxtqnD0XSmBV3pZFjtCv?=
 =?us-ascii?Q?MOjsQXkEPczC2akQrAx+w0HFHAcBCSIPcZljz1mJbkpdfd6DVIYQV6F33h8H?=
 =?us-ascii?Q?SEs4NzKFRJ+LLzfe4V0a4M2U1E7dGwDtTGWHOK0ydGqHL3ywGIe+pG9kpkLs?=
 =?us-ascii?Q?zX5xh3rFlX10f7yutF79SuUXLeRMZkp1JfFNUJXszauYPGKNzU+q9kTt0zZ0?=
 =?us-ascii?Q?Hh+r2IoHc22a0TIxNhAo3fI4+RldAZ/YhrORG7zcBVOmEBpTHLnrsPGBIMY1?=
 =?us-ascii?Q?fjPuRh39UuRXp6OPMNFPNLgLyaLyzbPn5jZNrfuLcWG/z9RkjWizddSkIBYr?=
 =?us-ascii?Q?BmHoAYvQVzbKKvRXflV1Kpu35Mdmx/E+cEH3pJ6WxSk7XYRH6BeTBg7hPs8x?=
 =?us-ascii?Q?A2LHzUltor4C0JGFjA82hpEOUT2GcKtvPYdE/PqBFKfOrgCSFrUBgozRFevC?=
 =?us-ascii?Q?TCc3480Zykp+tZLRpQZajOrAN+COnre2+Zz6ez8FW02lkJgNcVvH0dozm+mL?=
 =?us-ascii?Q?GgfIU1tkg/t7zYBSAQCp1m6cSEORermBWF+HU8dz5m/nH74+65Qc89GW3c+g?=
 =?us-ascii?Q?ssgh1LR//zk7M+wou7CnJay4ACzngHsY+8tCv1WfD53B1mrHxPU5Z1ho/8MD?=
 =?us-ascii?Q?cs9ARynph0c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRHG41bvQIid5YxxpdNQ+317oCE+zsSAc+U/LhEMDDLXQVkXkhQpKhEa3BeZ?=
 =?us-ascii?Q?/h5xZHgFy7hh6XOGIgjsMSqCyhL2SrXLpNVLFD76NaZ6mqA8TXYyunKyDqJ/?=
 =?us-ascii?Q?KRr4BckYBuA6+2+DSsA0JFvDvS+3thO5HsID1tykPvaxw2yQY6fxhB0u2UeP?=
 =?us-ascii?Q?HB1Vnj/Ki3UMgGxIHl1G6j8yBB8lfX5mr647GpwuqGmHLM9yJlUTb6vVjOLm?=
 =?us-ascii?Q?VJ7meEkU95UkiVLUhwc6mrVzN3dO/sOFtOYg7QQpde2W5YG+flu830OHQSc7?=
 =?us-ascii?Q?40eOq2bMvqGvgKJRd145eaF3zT6HrA3zmrfidnMALkgx7KhDfBYGta/JdMdq?=
 =?us-ascii?Q?r0sqfzw7P2zb4/hcgj986nZafYoacNAVBtlZNPG/u7qPv2DjQ+omFqm60AIe?=
 =?us-ascii?Q?AfTF/qQfq8LzNdWbWUz291696uSRq2naizi88rDCO6uTadRfG45cGPE/oi7p?=
 =?us-ascii?Q?sXHBOQ6kTxmgXgpMmgNN5+Bf02ngDQGREEiAecdto3vthb9E/0wa7Ud9+Q0J?=
 =?us-ascii?Q?d6MgSZlRIzzCyHqlh8SH0pl4YGRjq8wS/BJZW6nlKJ4+0VOryRjvt6T79klC?=
 =?us-ascii?Q?orxOcwmvWYB/0NHBUzf/hyBsrSs02Cn+T/swIH0G9azpPqKbpr7pUAF5ACJi?=
 =?us-ascii?Q?25y+uEPM8ENzHYquCsAxNo9aXZ471whHwTpCSdq6xUKpybH4wFzGiNORFwQY?=
 =?us-ascii?Q?/E1oprGfU+bPUq4/Jt6TGZlwUhpaWCv9nkded+Ay9oyiKgsbPRH6N59u+P4H?=
 =?us-ascii?Q?x+eyvfEwCkNq9I3hboaQKrTFDvtd3JtPm7x3yUlRCeykwrNznXjwr7O9nF2U?=
 =?us-ascii?Q?YjbImAIo6ZZkJKZlCGkiu0A6h5C04qO74fL3kYDLyYSghQXlhitS99uT8Bd5?=
 =?us-ascii?Q?hhVPoXtahUq6W2lSqsoKONT+1LtdKxTegR7ZyV9Ef3F3K5ofdw4RyCptboAi?=
 =?us-ascii?Q?rctEhTqt/2OFNKtXWx92Bg4OhN97HjZ0N44OjyPdC6QUgTrGL91l9r8cc6Yw?=
 =?us-ascii?Q?hBmBzbY6OJES0oT0e398IC3hd2bI1LGZ/OpZ1pNz8kvcp9jZkA0kjTUTq7Vr?=
 =?us-ascii?Q?oj91XQWV3zc3APVHJmW1mZ/Gf2JNnxVhd5RjQCZz+cmtoKMK1tmRbUvE9085?=
 =?us-ascii?Q?tGkg6IHG+U0wyjZjdBmGgTJ3rbacKJMbDDpvqYPVVTswGPF83d8lWLUnXB4q?=
 =?us-ascii?Q?qONuXnQ1KB2aU6mA2SYn+HhLyh8LtedUJIFHTrEha4Rcg49y4lOwagSUau19?=
 =?us-ascii?Q?HFuAfuq45NNfrYXuJJQS03s+D76iz1jfsSnUZR6icbMA12zqI5vmOLGw5jxp?=
 =?us-ascii?Q?JGjh9VeMKDg6atcCOVZYQPc+hsdTYYPvk0v+lC5AB8WKC2S8QqMuW6bJrn43?=
 =?us-ascii?Q?v0zb1O9NGJrSRGvHxhwAs6ouHZMHth0ZYv3rN6/9r0OczmkMChjPGETl0348?=
 =?us-ascii?Q?qbHz1CTrkZGkjsMtp0xitFg69x+Jq4TVD/VSOhdLusueb423/HuEhran5qrv?=
 =?us-ascii?Q?hIVCKPbW94cOjNt92FRu2TjucD+r278NKwMUCotdZPGcCYDgY4W+WV14GUzx?=
 =?us-ascii?Q?1uSZ7JhcA7DD+KSJaWOsX8nw4lZ3MEls2ygZknbLkmZdce2RodGPRnr9X0Jw?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 953832d6-f7be-48b5-b4fd-08dcdd032780
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:19.8727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNLNK4GB5oaCS1R8I+UL9H/qAz4e2kC7sca7WrAVJBD3NqNi9ez8lN7POSiXyeKiCwQurXIxQCh9HlLFfEJ6/mSvIvQMn5ACqLq72o4mbSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5645
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
index 149670e77f9..ec41aa92a68 100644
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

