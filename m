Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E01BE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C088189686;
	Wed,  4 Dec 2024 00:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="neEOeWAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519B989681; Wed,  4 Dec 2024 00:01:11 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9696289689
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjC9qlRkgbe/VlDeHgVuwC7hvc5iRrCxv8CWvJr7BreFFmWnhA/VL4JakAnG9Kj1FZJTCtfjk8Ea9R8Skf7ZHTkqZSP4+UIGq37d93AOvAGQOtOlq7wzUlW7MHM1SK9TRl261xu/lQhKjCjlxSvbnWcP7M8LgDy+3NxNBAy3zRHqRZ8R2pY4Me3c5wFIpFXFgWqhFTSPqk7OT98rW1eqHqXsn0yA7OTkjsBpnxzpmhd2R4aMBZg8hruk08p3LucwcHDzV/JfRhfCb3EQTc7Np8wBYOdkYD8Wq2wOHDoZ75TcnMj4cNJY818POyvEAKlNxMg1OkdRw4xNdK2x/csdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W98tXxggjpoGAE6Uaf1xpd0CCLuZDvLvnDRdusQNjkk=;
 b=fB2bnHV5EQYqYsxAkZfCDx0QZ+0D95nGIX6islSZyuiGX7TvDo9p8wbHUhCP6SKs8PWnHGqoOH3CphmgDqF1073HXW0FOGac6ik1QvT+7+YmIdrHqzRGLuWlHZ4Nxr3qJM/cFM4I9DCMpFC3HuOuuSykBW2lPx2b85edZgeeS5WNyn/qu5txCCvVe85CT3AeHGEEHh260K0qi+qnnHv7hi97aOJJcV1pCoYYalQPP+u9RmU7PWLKiyLr5SEp+M+2ileofLDzEto0k8MWOayF0kBBFVVbeVMxQ9y3WoZ4q9WQXxyst/7MYXknFwAU2TRRMUMp02j7MNpa6QFXwzmriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W98tXxggjpoGAE6Uaf1xpd0CCLuZDvLvnDRdusQNjkk=;
 b=neEOeWAd9qlbUiVScyGa4Q1orBSNa6tATklayqkCmvtpyAhyGHErFxzBp6WGA2BBSNm6GWRs9QwJtMfAObhrsA5AG80CzyrPrSHKddPkISDE9zP4NnQs6ZPVHQPnTWJpLjrRiat+RpasXzNHXzU3tGw/EeMmL8OANen/8hd/s5FU56sbN3pFgLsSjDNvQwQdTvGyo4oBMlrTX/viJU6Zo5A3Fem2lf1yf1AFNbFq0CDPXHPNKnYnijKeMAb0HLRNmAULYelAxwjixxNWqPzQ86LjENflddwndyQZvYS5Duz1Y7N0XoQbXFln9qJ8ZEvuY+QYQ1rkEro2oFQ0Bid1xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:01:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:01:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 06/10] net/tcp: improve tcp framework,
 use better state machine
Date: Wed,  4 Dec 2024 02:00:45 +0300
Message-ID: <20241203230049.2677155-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 543905fc-7656-4770-1973-08dd13ee5d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RiOJ9D3noAPB+kTdtwkqew7ZQ3AUhSz6+66wWsVwA/x/OM3HYBKSpiEL24TA?=
 =?us-ascii?Q?FFRSz72KGEcddjcbbdu61NDKiL14W84/sPrPlctQLRRT3zkco263Ag54fpp4?=
 =?us-ascii?Q?kem9NF9K+bjL6naprJC87XiwtiRbvbq+zp6r8I62vWJW7Yg3rSXz0s2TiLhw?=
 =?us-ascii?Q?aS+bfjumT6PUN+cnpZpebn8RhR7r1oGNkchfXiADHDfGocd//AA8n5+3ikFL?=
 =?us-ascii?Q?3rZpq4Pn9WLdRgyYa75xF3RlzUrk90Spo53+VQGZU2wcLZvhNLaR39k+MmVl?=
 =?us-ascii?Q?M0FLgraKq7sESxFDTdJAJOhWbTNoqnIE74h1M0q4wk2NhmM4jqS91Da5NjvE?=
 =?us-ascii?Q?3Izqw07/9RHHWttqyxYfYN7WOKlMn3wnWpMRH/qkDYXHBM2rQBsCa1fL2h6C?=
 =?us-ascii?Q?1pCggfF64G4WzrSoiH5vWOC7H7I4MDzUEi30eg54KIU3ye/3GDGNP+ZbBMUz?=
 =?us-ascii?Q?6y7fw+MbEk5DM6Z0OWzsXgO4vx8/L9AJXqcAHHhYBQu2h5tG+9B0oED+w9lw?=
 =?us-ascii?Q?DwTSnrQPdeHr6tTevnzw1YkHrrQLP5a3llVQEQTZip/pmwCS44xtkf/C8p+k?=
 =?us-ascii?Q?8E09M3gn6PCyJhGDl8kl911oe6xToCj0MF5yMm7nKKAzy6DdISlSz1jh13KA?=
 =?us-ascii?Q?kkwSj8UFdy4IGZflk12uXMdFpZfphKtq6DTrK05cTwXE/VFg0Up4OdJO36pg?=
 =?us-ascii?Q?TfKIARcXMczVgDqpeeF1mf5qHuAvGmCy4YwKnF+b0GiZxSqntuAM48UISafe?=
 =?us-ascii?Q?pxOfnAlflRf2lw34n+aSsHzmwxv94qOgNiv0iWKDGTy1y3SSScWaHpj7tym1?=
 =?us-ascii?Q?qID6/R6J/08ufPx6ChBYwDDTkWvY/JCuCAFyEV1V5ol7KG6jABzSMNeudG2Z?=
 =?us-ascii?Q?cxB4oil5jvzCI+FMdnHgF6lo7UhN00x7l6R6iitNDjHzqfJO1fuaGOcmZWNd?=
 =?us-ascii?Q?TGf2Do27IX6VJ5jrUickLIauP55Tr9ZyybPIJvycMZNEB3fiEoTgQ35AmJQK?=
 =?us-ascii?Q?J6PV/aFxOne2FnbDzx/jOi8L1y/1kfOKqYdwFnAlDJnVjk1osGIV2VAsGhQs?=
 =?us-ascii?Q?6jGw/7MLpeN8+e3b5T7tvb9HnhRIQzXZ21mU7RjCeNcn75hyORXX62auZG7H?=
 =?us-ascii?Q?AiD8qmXcDUpkHLT294JbW5/dd9oREfEe0+SCMMKM9z4UzpuVVjZikRBAahBk?=
 =?us-ascii?Q?iL1r67TCSvr3/zCmju1XjcoRsdeIgNFGf+66Nnteg/lzJFYVUgLXMFAEakUC?=
 =?us-ascii?Q?mmMw15qaiKtpz2ZCC89A7yg7OV/5QU6hPL902EG58n51IsMmjSqC+bxYnNgu?=
 =?us-ascii?Q?n1oFx4gJEf69XuOF4ppb8abLyNKv4h5FMV6UjKowQzM/AxwqtCY+13TC5plh?=
 =?us-ascii?Q?AM0Zp4WLBW4fUgPZT02lLSzFuL0NHOHwSB3oNw9ejs5jEPxF4AymbIBrgUBJ?=
 =?us-ascii?Q?zQ2jsIALLcU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TaZ4LSfB5AI8G451weFBajVDd+3snoLOugx0rmFHQav4PtRCZOeMEnhrGHRa?=
 =?us-ascii?Q?miQKN1ubx8XXFCd6K0xx4zts+k5ayuqFILE4DelMqtKbFlXqtt/9EI7Xr4nA?=
 =?us-ascii?Q?LSUyjcxMe3gI3blouYLPV3WdKnbtlu+JxAnkGuLOmvIRPPKE4ENJBMWkxiXy?=
 =?us-ascii?Q?x3zEzJuJVBJCNh6NXGCssJfSDYedTVq0SD6JxwpEyqDbCt7JB47rjUMprM3Q?=
 =?us-ascii?Q?Fn4x+7v23fyqU5Ol7V52HeT8dhTp71FRXnSShMUkZ8OpVQSV5ZMGOtWsGgFA?=
 =?us-ascii?Q?1IzpTuT+lbRAiqjaobaF6o6C8NmAi6vpRKQmcWgKaCfCgTFWgMHePKFaoMVB?=
 =?us-ascii?Q?KpataaJ4lTCVCR253EwDAh/Xrv5MUMFlx4guMdw/K/yvkxgpEz0qSw0GjCgL?=
 =?us-ascii?Q?pZmVf/oMFrNt2qdDxgvX8dM8GFq2Lr/vhGZHIPf0KDDX/r9SmqknO1GOyn6y?=
 =?us-ascii?Q?w/I8IciZq/OUCMj7e9MGA4+2krg6dP85y32YR8iDmNjEVcPeUaT7dd2MbgTV?=
 =?us-ascii?Q?zgQ/gbOzSzdD/OOV0nvMjqNoLuvx7BooUgIs9RKERM5sVPvt+Y2iaI5+Fkpg?=
 =?us-ascii?Q?uOZhYDrY1NAuX7Qe/NPAQJ9z8RWeK5XKOaLBxsYXT1zJD/UdjrzvPW/a6irm?=
 =?us-ascii?Q?Ck7PWf3juVtrpfaKIhukuXadaGG8KrBz97cO7HdWo1G4l3A9Cf76VYbl+w68?=
 =?us-ascii?Q?aLunXfvpAGal9ohYgDjicbaQnPCSLqthUHLomBhITL7uI/mN0Lt3JtP4nHX3?=
 =?us-ascii?Q?MxG0sfwMJ53ZD/o9SUDMHzsXfgSH1hgABN/PZf81Ui4MVd5Vl7P/OT6looTG?=
 =?us-ascii?Q?LGXtFzbII7sTiyuZFcVjn9Y62y4su5i7PlKE1Ew7ncjkeGHbl5nUFm2yT6+w?=
 =?us-ascii?Q?UDNOKMyA/kiZ6EHZQSKVn/0r6jtjIEMXhjeqa0Vf/z0oN6Bl1d/mh2sxju48?=
 =?us-ascii?Q?4z7g674GFKUmcet7N/ttfLEsxqV13IHakiNhM1f65BHlpGomGHarUvjs9naI?=
 =?us-ascii?Q?1bevU3qRTmuxSqHEdEbC3kGHjeMLpUeNDC29s/KV4gYVmjZP2Pk4xZgZD0LV?=
 =?us-ascii?Q?ZNf4K9xFfktXMi0I8XRqzf9r+mn0j/N/2kCmagkXkuJ8tuGzbJE+RweXls/4?=
 =?us-ascii?Q?dggXpUeKiZTYUkvOH9x4PVuULZt9f86TycuvXyDFZDXm1uKsasM1SjT6wcMq?=
 =?us-ascii?Q?a5LimV71FkodJeYYDHM9/q1s/sKesysZtq0o7OeBK4O+mo4f2BBpngaIgURh?=
 =?us-ascii?Q?jGD8edhdG7XZWux7nx4z9F1XXYj5PAGYxXq5MIsNX71yiIuCecBGnaNRUF3L?=
 =?us-ascii?Q?sgIGUJDvc1Yg1bsDL4rvBkaMiTTQBBSLnB6+uyYAOeHm4svGKjM5bVTRPRIG?=
 =?us-ascii?Q?q90c2hey+ZMf7tseN9+JgCmQLBlrrU6Ao3cWcl0sK5IaUCTVhwOicRnEsFxF?=
 =?us-ascii?Q?T7w1AWoA/y5z/jUnYjBJxuTL4wEqS3iEN7tyJ0l5D5D7SDa4M0VbVHq4gNea?=
 =?us-ascii?Q?DhJ80Tp/omnTy93Y6ooOiwUmiIy7nS6BHL2cmNo07vxgfcZcML60IYemfytj?=
 =?us-ascii?Q?Yv9fQ6BMRweMN+XV5ECwgbFP/5KdlFjgPvRNLXfmTgNt3PeVFZ795czIZo5x?=
 =?us-ascii?Q?8I8Q0X8a1RBpMMxsfijAOzc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 543905fc-7656-4770-1973-08dd13ee5d9a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:01:05.2596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCJQY8ekFmBkaf8v3AC2zlP3INs38+mO+Hswb0fly22uPkhlMuu0TBwM2MubKzNiJdqSJO84YWjGMZmV9MICfS5Fg8R1ibygEGzpp15hid8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7611
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

Changes:
 * Fix initial send sequence always zero issue
 * Use state machine close to RFC 9293. This should make TCP
   transfers more reliable (now we can upload a huge array
   of data from the board to external server)
 * Improve TCP framework a lot. This should make tcp client
   code much more simple.
 * rewrite wget with new tcp stack
 * rewrite fastboot_tcp with new tcp stack

It's quite hard to fix the initial send sequence (ISS) issue
with the separate patch. A naive attempt to fix an issue
inside the tcp_set_tcp_header() function will break tcp packet
retransmit logic in wget and other clients.

Example:
  Wget stores tcp_seq_num value before tcp_set_tcp_header() will
  be called and (on failure) retransmit the packet with the stored
  tcp_seq_num value. Thus:
    * the same ISS must allways be used (current case)
    * or tcp clients needs to generate a proper ISS when
      required.

A proper ISS fix will require a big redesing comparable with
a this one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net/tcp.h  | 202 ++++++++--
 include/net/wget.h |   8 -
 net/fastboot_tcp.c | 193 +++++-----
 net/net.c          |   4 +
 net/tcp.c          | 891 +++++++++++++++++++++++++++++++++++----------
 net/wget.c         | 450 +++++++----------------
 6 files changed, 1088 insertions(+), 660 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0694af9d5b1..55541e1b90e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -265,6 +265,7 @@ union tcp_build_pkt {
  * @TCP_CLOSING: Rec FIN, sent FIN, ACK waiting for ACK
  * @TCP_FIN_WAIT_1: Sent FIN waiting for response
  * @TCP_FIN_WAIT_2: Rec ACK from FIN sent, waiting for FIN
+ * @TCP_LAST_ACK: Waiting for ACK of the connection termination
  */
 enum tcp_state {
 	TCP_CLOSED,
@@ -274,7 +275,22 @@ enum tcp_state {
 	TCP_CLOSE_WAIT,
 	TCP_CLOSING,
 	TCP_FIN_WAIT_1,
-	TCP_FIN_WAIT_2
+	TCP_FIN_WAIT_2,
+	TCP_LAST_ACK,
+};
+
+/**
+ * enum tcp_status - TCP stream status for connection
+ * @TCP_ERR_OK: no rx/tx errors
+ * @TCP_ERR_TOUT: rx/tx timeout happened
+ * @TCP_ERR_RST: connection was reset
+ * @TCP_ERR_IO: input/output error
+ */
+enum tcp_status {
+	TCP_ERR_OK = 0,
+	TCP_ERR_TOUT,
+	TCP_ERR_RST,
+	TCP_ERR_IO
 };
 
 /**
@@ -283,51 +299,156 @@ enum tcp_state {
  * @rport:		Remote port, host byte order
  * @lport:		Local port, host byte order
  *
+ * @priv:		User private data (not used by tcp module)
+ *
+ * @max_retry_count:	Maximum retransmit attempts (default 3)
+ * @initial_timeout:	Timeout from initial TX to reTX (default 2 sec)
+ * @rx_inactiv_timeout:	Maximum time from last rx till connection drop
+ *			  (default 30 sec)
+ *
+ * @on_closed:		User callback, called just before destroying TCP stream
+ * @on_established:	User callback, called when TCP stream enters
+ *			  TCP_ESTABLISHED state
+ * @on_rcv_nxt_update:	User callback, called when all data in the segment
+ *			  [0..rx_bytes - 1] was received
+ * @on_snd_una_update:	User callback, called when all data in the segment
+ *			  [0..tx_bytes - 1] were transferred and acknowledged
+ * @rx:			User callback, called on receive of segment
+ *			  [rx_offs..rx_offs+len-1]. If NULL -- all incoming data
+ *			  will be ignored. User SHOULD store the segment and
+ *			  return the number of accepted bytes or negative value
+ *			  on error.
+ *			  WARNING: Previous segmengs may not be received yet
+ * @tx:			User callback, called on transmit/retransmit of segment
+ *			  [tx_offs..tx_offs+maxlen-1]. If NULL -- no data will
+ *			  be transmitted. User SHOULD fill provided buffer and
+ *			  return the number of bytes in the buffer or negative
+ *			  value on error.
+ *			  WARNING: do not use tcp_stream_close() from this
+ *			    callback (it will break stream). Better use
+ *			    on_snd_una_update() callback for such purposes.
+ *
+ * @time_last_rx:	Arrival time of last valid incoming package (ticks)
+ * @time_start:		Timeout start time (ticks)
+ * @time_delta:		Timeout duration (ticks)
+ * @time_handler	Timeout handler for a stream
+ *
  * @state:		TCP connection state
+ * @status:		TCP stream status (OK or ERR)
+ * @rx_packets:		total number of received packets
+ * @tx_packets:		total number of transmitted packets
+ *
+ * @fin_rx:		Non-zero if TCP_FIN was received
+ * @fin_rx_seq:		TCP sequence of rx FIN bit
+ * @fin_tx:		Non-zero if TCP_FIN was sent (or planned to send)
+ * @fin_tx_seq:		TCP sequence of tx FIN bit
+ *
+ * @iss:		Initial send sequence number
+ * @snd_una:		Send unacknowledged
+ * @snd_nxt:		Send next
+ * @snd_wnd:		Send window (in bytes)
+ * @snd_wl1:		Segment sequence number used for last window update
+ * @snd_wl2:		Segment acknowledgment number used for last window update
  *
  * @irs:		Initial receive sequence number
  * @rcv_nxt:		Receive next
+ * @rcv_wnd:		Receive window (in bytes)
  *
  * @loc_timestamp:	Local timestamp
  * @rmt_timestamp:	Remote timestamp
  *
+ * @rmt_win_scale:	Remote window scale factor
+ *
  * @lost:		Used for SACK
+ *
+ * @retry_cnt:		Number of retry attempts remaining. Only SYN, FIN
+ *			  or DATA segments are tried to retransmit.
+ * @retry_timeout:	Current retry timeout (ms)
+ * @retry_action:	TCP flags used for sending
+ * @retry_seq_num:	TCP sequence for retransmit
+ * retry_tx_len:	Number of data to transmit
+ * @retry_tx_offs:	Position in the TX stream
  */
 struct tcp_stream {
 	struct in_addr	rhost;
 	u16		rport;
 	u16		lport;
 
-	/* TCP connection state */
+	void		*priv;
+
+	int		max_retry_count;
+	int		initial_timeout;
+	int		rx_inactiv_timeout;
+
+	void		(*on_closed)(struct tcp_stream *tcp);
+	void		(*on_established)(struct tcp_stream *tcp);
+	void		(*on_rcv_nxt_update)(struct tcp_stream *tcp, u32 rx_bytes);
+	void		(*on_snd_una_update)(struct tcp_stream *tcp, u32 tx_bytes);
+	int		(*rx)(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len);
+	int		(*tx)(struct tcp_stream *tcp, u32 tx_offs, void *buf, int maxlen);
+
+	ulong		time_last_rx;
+	ulong		time_start;
+	ulong		time_delta;
+	void		(*time_handler)(struct tcp_stream *tcp);
+
 	enum tcp_state	state;
+	enum tcp_status	status;
+	u32		rx_packets;
+	u32		tx_packets;
+
+	int		fin_rx;
+	u32		fin_rx_seq;
+
+	int		fin_tx;
+	u32		fin_tx_seq;
+
+	u32		iss;
+	u32		snd_una;
+	u32		snd_nxt;
+	u32		snd_wnd;
+	u32		snd_wl1;
+	u32		snd_wl2;
 
 	u32		irs;
 	u32		rcv_nxt;
+	u32		rcv_wnd;
 
 	/* TCP option timestamp */
 	u32		loc_timestamp;
 	u32		rmt_timestamp;
 
+	/* TCP window scale */
+	u8		rmt_win_scale;
+
 	/* TCP sliding window control used to request re-TX */
 	struct tcp_sack_v lost;
+
+	/* used for data retransmission */
+	int		retry_cnt;
+	int		retry_timeout;
+	u8		retry_action;
+	u32		retry_seq_num;
+	u32		retry_tx_len;
+	u32		retry_tx_offs;
 };
 
 void tcp_init(void);
 
-typedef int tcp_incoming_filter(struct in_addr rhost,
-				u16 rport, u16 sport);
-
 /*
- * This function sets user callback used to accept/drop incoming
- * connections. Callback should:
+ * This function sets user callback called on TCP stream creation.
+ * Callback should:
  *  + Check TCP stream endpoint and make connection verdict
  *    - return non-zero value to accept connection
  *    - return zero to drop connection
+ *  + Setup TCP stream callbacks like: on_closed(), on_established(),
+ *    n_rcv_nxt_update(), on_snd_una_update(), rx() and tx().
+ *  + Setup other stream related data
  *
- * WARNING: If callback is NOT defined, all incoming connections
- *          will be dropped.
+ * WARNING: User MUST setup TCP stream on_create handler. Without it
+ *          no connection (including outgoung) will be created.
  */
-void tcp_set_incoming_filter(tcp_incoming_filter *filter);
+void tcp_stream_set_on_create_handler(int (*on_create)(struct tcp_stream *));
 
 /*
  * tcp_stream_get -- Get or create TCP stream
@@ -351,27 +472,52 @@ struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
  */
 struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport);
 
-enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp);
+/*
+ * tcp_stream_put -- Return stream to a TCP subsystem. Subsystem will
+ *                   check stream and destroy it (if stream was already
+ *                   closed). Otherwize no stream change will happen.
+ * @tcp:	TCP stream to put
+ */
+void tcp_stream_put(struct tcp_stream *tcp);
 
-int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
-		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
+/*
+ * tcp_stream_restart_rx_timer -- Restart RX inactivity timer. Usually there
+ *                                is no needs to call this function. Timer
+ *                                will be restarted on receiving of any valid
+ *                                tcp packet belonging to a stream.
+ *
+ *                                This function may be used to prevent connection
+ *                                break in the following case:
+ *                                  - u-boot is busy with very long data processing
+ *                                  - remote side waits for u-boot reply
+ *
+ * @tcp:	TCP stream to put
+ */
+void tcp_stream_restart_rx_timer(struct tcp_stream *tcp);
 
-/**
- * rxhand_tcp() - An incoming packet handler.
- * @tcp: TCP stream
- * @pkt: pointer to the application packet
- * @dport: destination TCP port
- * @sip: source IP address
- * @sport: source TCP port
- * @tcp_seq_num: TCP sequential number
- * @tcp_ack_num: TCP acknowledgment number
- * @action: TCP action (SYN, ACK, FIN, etc)
- * @len: packet length
+enum tcp_state  tcp_stream_get_state(struct tcp_stream *tcp);
+enum tcp_status tcp_stream_get_status(struct tcp_stream *tcp);
+
+
+/*
+ * tcp_stream_rx_offs(),
+ * tcp_stream_tx_offs()  -- Returns offset of first unacknowledged byte
+ *                          in receive/transmit stream correspondingly.
+ *                          The result is NOT affected by sin/fin flags.
+ * @tcp:	TCP stream
  */
-typedef void rxhand_tcp(struct tcp_stream *tcp, uchar *pkt,
-			u32 tcp_seq_num, u32 tcp_ack_num,
-			u8 action, unsigned int len);
-void tcp_set_tcp_handler(rxhand_tcp *f);
+u32 tcp_stream_rx_offs(struct tcp_stream *tcp);
+u32 tcp_stream_tx_offs(struct tcp_stream *tcp);
+
+/* reset tcp stream */
+void tcp_stream_reset(struct tcp_stream *tcp);
+/* force TCP stream closing, do NOT use from tcp->tx callback */
+void tcp_stream_close(struct tcp_stream *tcp);
+
+void tcp_streams_poll(void);
+
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
+		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 
 void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int len);
 
diff --git a/include/net/wget.h b/include/net/wget.h
index 6714f7ea573..9a423b30414 100644
--- a/include/net/wget.h
+++ b/include/net/wget.h
@@ -8,14 +8,6 @@
  */
 void wget_start(void);
 
-enum wget_state {
-	WGET_CLOSED,
-	WGET_CONNECTING,
-	WGET_CONNECTED,
-	WGET_TRANSFERRING,
-	WGET_TRANSFERRED
-};
-
 #define DEBUG_WGET		0	/* Set to 1 for debug messages */
 #define WGET_RETRY_COUNT	30
 #define WGET_TIMEOUT		2000UL
diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index 4d34fdc5a45..3ea25c997fc 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -10,140 +10,109 @@
 
 #define FASTBOOT_TCP_PORT	5554
 
-static char command[FASTBOOT_COMMAND_LEN];
-static char response[FASTBOOT_RESPONSE_LEN];
-
 static const unsigned short handshake_length = 4;
 static const uchar *handshake = "FB01";
 
-static u32 curr_tcp_seq_num;
-static u32 curr_tcp_ack_num;
-static unsigned int curr_request_len;
-static enum fastboot_tcp_state {
-	FASTBOOT_CLOSED,
-	FASTBOOT_CONNECTED,
-	FASTBOOT_DISCONNECTING
-} state = FASTBOOT_CLOSED;
-
-static void fastboot_tcp_answer(struct tcp_stream *tcp, u8 action,
-				unsigned int len)
-{
-	const u32 response_seq_num = curr_tcp_ack_num;
-	const u32 response_ack_num = curr_tcp_seq_num +
-		  (curr_request_len > 0 ? curr_request_len : 1);
+static char rxbuf[sizeof(u64) + FASTBOOT_COMMAND_LEN + 1];
+static char txbuf[sizeof(u64) + FASTBOOT_RESPONSE_LEN + 1];
 
-	net_send_tcp_packet(len, tcp->rhost, tcp->rport, tcp->lport,
-			    action, response_seq_num, response_ack_num);
-}
+static u32 data_read;
+static u32 tx_last_offs, tx_last_len;
 
-static void fastboot_tcp_reset(struct tcp_stream *tcp)
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 {
-	fastboot_tcp_answer(tcp, TCP_RST, 0);
-	state = FASTBOOT_CLOSED;
-}
+	u64	cmd_size;
+	__be64	len_be;
+	char	saved;
+	int	fastboot_command_id, len;
+
+	if (!data_read && rx_bytes >= handshake_length) {
+		if (memcmp(rxbuf, handshake, handshake_length)) {
+			printf("fastboot: bad handshake\n");
+			tcp_stream_close(tcp);
+			return;
+		}
 
-static void fastboot_tcp_send_packet(struct tcp_stream *tcp, u8 action,
-				     const uchar *data, unsigned int len)
-{
-	uchar *pkt = net_get_async_tx_pkt_buf();
+		tx_last_offs = 0;
+		tx_last_len = handshake_length;
+		memcpy(txbuf, handshake, handshake_length);
+
+		data_read += handshake_length;
+		rx_bytes -= handshake_length;
+		if (rx_bytes > 0)
+			memmove(rxbuf, rxbuf + handshake_length, rx_bytes);
+		return;
+	}
 
-	memset(pkt, '\0', PKTSIZE);
-	pkt += net_eth_hdr_size() + IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
-	memcpy(pkt, data, len);
-	fastboot_tcp_answer(tcp, action, len);
-	memset(pkt, '\0', PKTSIZE);
+	if (rx_bytes < sizeof(u64))
+		return;
+
+	memcpy(&cmd_size, rxbuf, sizeof(u64));
+	cmd_size = __be64_to_cpu(cmd_size);
+	if (rx_bytes < sizeof(u64) + cmd_size)
+		return;
+
+	saved = rxbuf[sizeof(u64) + cmd_size];
+	rxbuf[sizeof(u64) + cmd_size] = '\0';
+	fastboot_command_id = fastboot_handle_command(rxbuf + sizeof(u64),
+						      txbuf + sizeof(u64));
+	fastboot_handle_boot(fastboot_command_id,
+			     strncmp("OKAY", txbuf + sizeof(u64), 4) != 0);
+	rxbuf[sizeof(u64) + cmd_size] = saved;
+
+	len = strlen(txbuf + sizeof(u64));
+	len_be = __cpu_to_be64(len);
+	memcpy(txbuf, &len_be, sizeof(u64));
+
+	tx_last_offs += tx_last_len;
+	tx_last_len = len + sizeof(u64);
+
+	data_read += sizeof(u64) + cmd_size;
+	rx_bytes -= sizeof(u64) + cmd_size;
+	if (rx_bytes > 0)
+		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, rx_bytes);
 }
 
-static void fastboot_tcp_send_message(struct tcp_stream *tcp,
-				      const char *message, unsigned int len)
+static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len)
 {
-	__be64 len_be = __cpu_to_be64(len);
-	uchar *pkt = net_get_async_tx_pkt_buf();
-
-	memset(pkt, '\0', PKTSIZE);
-	pkt += net_eth_hdr_size() + IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
-	// Put first 8 bytes as a big endian message length
-	memcpy(pkt, &len_be, 8);
-	pkt += 8;
-	memcpy(pkt, message, len);
-	fastboot_tcp_answer(tcp, TCP_ACK | TCP_PUSH, len + 8);
-	memset(pkt, '\0', PKTSIZE);
+	memcpy(rxbuf + rx_offs - data_read, buf, len);
+
+	return len;
 }
 
-static void fastboot_tcp_handler_ipv4(struct tcp_stream *tcp, uchar *pkt,
-				      u32 tcp_seq_num, u32 tcp_ack_num,
-				      u8 action, unsigned int len)
+static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, int maxlen)
 {
-	int fastboot_command_id;
-	u64 command_size;
-	u8 tcp_fin = action & TCP_FIN;
-	u8 tcp_push = action & TCP_PUSH;
-
-	curr_tcp_seq_num = tcp_seq_num;
-	curr_tcp_ack_num = tcp_ack_num;
-	curr_request_len = len;
-
-	switch (state) {
-	case FASTBOOT_CLOSED:
-		if (tcp_push) {
-			if (len != handshake_length ||
-			    strlen(pkt) != handshake_length ||
-			    memcmp(pkt, handshake, handshake_length) != 0) {
-				fastboot_tcp_reset(tcp);
-				break;
-			}
-			fastboot_tcp_send_packet(tcp, TCP_ACK | TCP_PUSH,
-						 handshake, handshake_length);
-			state = FASTBOOT_CONNECTED;
-		}
-		break;
-	case FASTBOOT_CONNECTED:
-		if (tcp_fin) {
-			fastboot_tcp_answer(tcp, TCP_FIN | TCP_ACK, 0);
-			state = FASTBOOT_DISCONNECTING;
-			break;
-		}
-		if (tcp_push) {
-			// First 8 bytes is big endian message length
-			command_size = __be64_to_cpu(*(u64 *)pkt);
-			len -= 8;
-			pkt += 8;
-
-			// Only single packet messages are supported ATM
-			if (strlen(pkt) != command_size) {
-				fastboot_tcp_reset(tcp);
-				break;
-			}
-			strlcpy(command, pkt, len + 1);
-			fastboot_command_id = fastboot_handle_command(command, response);
-			fastboot_tcp_send_message(tcp, response, strlen(response));
-			fastboot_handle_boot(fastboot_command_id,
-					     strncmp("OKAY", response, 4) == 0);
-		}
-		break;
-	case FASTBOOT_DISCONNECTING:
-		if (tcp_push)
-			state = FASTBOOT_CLOSED;
-		break;
-	}
+	/* by design: tx_offs >= tx_last_offs */
+	if (tx_offs >= tx_last_offs + tx_last_len)
+		return 0;
 
-	memset(command, 0, FASTBOOT_COMMAND_LEN);
-	memset(response, 0, FASTBOOT_RESPONSE_LEN);
-	curr_tcp_seq_num = 0;
-	curr_tcp_ack_num = 0;
-	curr_request_len = 0;
+	maxlen = tx_last_offs + tx_last_len - tx_offs;
+	memcpy(buf, txbuf + (tx_offs - tx_last_offs), maxlen);
+
+	return maxlen;
 }
 
-static int incoming_filter(struct in_addr rhost, u16 rport, u16 lport)
+static int tcp_stream_on_create(struct tcp_stream *tcp)
 {
-	return (lport == FASTBOOT_TCP_PORT);
+	if (tcp->lport != FASTBOOT_TCP_PORT)
+		return 0;
+
+	data_read = 0;
+	tx_last_offs = 0;
+	tx_last_len = 0;
+
+	tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+	tcp->rx = tcp_stream_rx;
+	tcp->tx = tcp_stream_tx;
+
+	return 1;
 }
 
 void fastboot_tcp_start_server(void)
 {
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
 	printf("Using %s device\n", eth_get_name());
 	printf("Listening for fastboot command on tcp %pI4\n", &net_ip);
-
-	tcp_set_incoming_filter(incoming_filter);
-	tcp_set_tcp_handler(fastboot_tcp_handler_ipv4);
 }
diff --git a/net/net.c b/net/net.c
index e5caf1d9334..aa1cb0b51cb 100644
--- a/net/net.c
+++ b/net/net.c
@@ -652,6 +652,9 @@ restart:
 		 *	errors that may have happened.
 		 */
 		eth_rx();
+#if defined(CONFIG_PROT_TCP)
+		tcp_streams_poll();
+#endif
 
 		/*
 		 *	Abort if ctrl-c was pressed.
@@ -961,6 +964,7 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size,
 					     payload_len, action, tcp_seq_num,
 					     tcp_ack_num);
+		tcp_stream_put(tcp);
 		break;
 #endif
 	default:
diff --git a/net/tcp.c b/net/tcp.c
index 7e445eaffd6..3268989b3f9 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -24,9 +24,26 @@
 #include <net.h>
 #include <net/tcp.h>
 
-static int tcp_activity_count;
+/*
+ * The start sequence number increment for the two sequently created
+ * connections within the same timer tick. This number must be:
+ *  - prime (to increase the time before the same number will be generated)
+ *  - larger than typical MTU (to avoid similar numbers for two sequently
+ *    created connections)
+ */
+#define TCP_START_SEQ_INC	2153	/* just large prime number */
+
+#define TCP_SEND_RETRY		3
+#define TCP_SEND_TIMEOUT	2000UL
+#define TCP_RX_INACTIVE_TIMEOUT	30000UL
+#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+
+#define TCP_PACKET_OK		0
+#define TCP_PACKET_DROP		1
+
 static struct tcp_stream tcp_stream;
-static tcp_incoming_filter *incoming_filter;
+
+static int (*tcp_stream_on_create)(struct tcp_stream *tcp);
 
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
@@ -35,12 +52,10 @@ static tcp_incoming_filter *incoming_filter;
  */
 #define LEN_B_TO_DW(x) ((x) >> 2)
 #define ROUND_TCPHDR_LEN(x) (LEN_B_TO_DW((x) + 3))
+#define ROUND_TCPHDR_BYTES(x) (((x) + 3) & ~3)
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
 
-/* Current TCP RX packet handler */
-static rxhand_tcp *tcp_packet_handler;
-
 #define RANDOM_PORT_START 1024
 #define RANDOM_PORT_RANGE 0x4000
 
@@ -62,6 +77,22 @@ static inline s32 tcp_seq_cmp(u32 a, u32 b)
 	return (s32)(a - b);
 }
 
+static inline u32 tcp_get_start_seq(void)
+{
+	static u32	tcp_seq_inc;
+	u32		tcp_seq;
+
+	tcp_seq = (get_timer(0) & 0xffffffff) + tcp_seq_inc;
+	tcp_seq_inc += TCP_START_SEQ_INC;
+
+	return tcp_seq;
+}
+
+static inline ulong msec_to_ticks(ulong msec)
+{
+	return msec * CONFIG_SYS_HZ / 1000;
+}
+
 /**
  * tcp_stream_get_state() - get TCP stream state
  * @tcp: tcp stream
@@ -84,31 +115,90 @@ static void tcp_stream_set_state(struct tcp_stream *tcp,
 	tcp->state = new_state;
 }
 
-void tcp_init(void)
+/**
+ * tcp_stream_get_status() - get TCP stream status
+ * @tcp: tcp stream
+ *
+ * Return: TCP stream status
+ */
+enum tcp_status tcp_stream_get_status(struct tcp_stream *tcp)
 {
-	incoming_filter = NULL;
-	tcp_stream.state = TCP_CLOSED;
+	return tcp->status;
 }
 
-void tcp_set_incoming_filter(tcp_incoming_filter *filter)
+/**
+ * tcp_stream_set_status() - set TCP stream state
+ * @tcp: tcp stream
+ * @new_satus: new TCP stream status
+ */
+static void tcp_stream_set_status(struct tcp_stream *tcp,
+				  enum tcp_status new_status)
 {
-	incoming_filter = filter;
+	tcp->status = new_status;
 }
 
-static struct tcp_stream *tcp_stream_add(struct in_addr rhost,
-					 u16 rport, u16 lport)
+void tcp_stream_restart_rx_timer(struct tcp_stream *tcp)
 {
-	struct tcp_stream *tcp = &tcp_stream;
-
-	if (tcp->state != TCP_CLOSED)
-		return NULL;
+	tcp->time_last_rx = get_timer(0);
+}
 
+static void tcp_stream_init(struct tcp_stream *tcp,
+			    struct in_addr rhost, u16 rport, u16 lport)
+{
 	memset(tcp, 0, sizeof(struct tcp_stream));
 	tcp->rhost.s_addr = rhost.s_addr;
 	tcp->rport = rport;
 	tcp->lport = lport;
 	tcp->state = TCP_CLOSED;
 	tcp->lost.len = TCP_OPT_LEN_2;
+	tcp->rcv_wnd = TCP_RCV_WND_SIZE;
+	tcp->max_retry_count = TCP_SEND_RETRY;
+	tcp->initial_timeout = TCP_SEND_TIMEOUT;
+	tcp->rx_inactiv_timeout = TCP_RX_INACTIVE_TIMEOUT;
+	tcp_stream_restart_rx_timer(tcp);
+}
+
+static void tcp_stream_destroy(struct tcp_stream *tcp)
+{
+	if (tcp->on_closed)
+		tcp->on_closed(tcp);
+	memset(tcp, 0, sizeof(struct tcp_stream));
+}
+
+void tcp_init(void)
+{
+	static int initialized;
+	struct tcp_stream *tcp = &tcp_stream;
+
+	tcp_stream_on_create = NULL;
+	if (!initialized) {
+		initialized = 1;
+		memset(tcp, 0, sizeof(struct tcp_stream));
+	}
+
+	tcp_stream_set_state(tcp, TCP_CLOSED);
+	tcp_stream_set_status(tcp, TCP_ERR_RST);
+	tcp_stream_destroy(tcp);
+}
+
+void tcp_stream_set_on_create_handler(int (*on_create)(struct tcp_stream *))
+{
+	tcp_stream_on_create = on_create;
+}
+
+static struct tcp_stream *tcp_stream_add(struct in_addr rhost,
+					 u16 rport, u16 lport)
+{
+	struct tcp_stream *tcp = &tcp_stream;
+
+	if (!tcp_stream_on_create ||
+	    tcp->state != TCP_CLOSED)
+		return NULL;
+
+	tcp_stream_init(tcp, rhost, rport, lport);
+	if (!tcp_stream_on_create(tcp))
+		return NULL;
+
 	return tcp;
 }
 
@@ -122,30 +212,226 @@ struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
 	    tcp->lport == lport)
 		return tcp;
 
-	if (!is_new || !incoming_filter) ||
-	    !incoming_filter(rhost, rport, lport))
-		return NULL;
+	return is_new ? tcp_stream_add(rhost, rport, lport) : NULL;
+}
 
-	return tcp_stream_add(rhost, rport, lport);
+void tcp_stream_put(struct tcp_stream *tcp)
+{
+	if (tcp->state == TCP_CLOSED)
+		tcp_stream_destroy(tcp);
 }
 
-static void dummy_handler(struct tcp_stream *tcp, uchar *pkt,
-			  u32 tcp_seq_num, u32 tcp_ack_num,
-			  u8 action, unsigned int len)
+u32 tcp_stream_rx_offs(struct tcp_stream *tcp)
 {
+	u32 ret;
+
+	switch (tcp->state) {
+	case TCP_CLOSED:
+	case TCP_SYN_SENT:
+	case TCP_SYN_RECEIVED:
+		return 0;
+	default:
+		break;
+	}
+
+	ret = tcp->rcv_nxt - tcp->irs - 1;
+	if (tcp->fin_rx && (tcp->rcv_nxt == tcp->fin_rx_seq))
+		ret--;
+
+	return ret;
 }
 
-/**
- * tcp_set_tcp_handler() - set a handler to receive data
- * @f: handler
- */
-void tcp_set_tcp_handler(rxhand_tcp *f)
+u32 tcp_stream_tx_offs(struct tcp_stream *tcp)
+{
+	u32 ret;
+
+	switch (tcp->state) {
+	case TCP_CLOSED:
+	case TCP_SYN_SENT:
+	case TCP_SYN_RECEIVED:
+		return 0;
+	default:
+		break;
+	}
+
+	ret = tcp->snd_una - tcp->iss - 1;
+	if (tcp->fin_tx && (tcp->snd_una == tcp->fin_tx_seq + 1))
+		ret--;
+
+	return ret;
+}
+
+static void tcp_stream_set_time_handler(struct tcp_stream *tcp, ulong msec,
+					void (*handler)(struct tcp_stream *))
+{
+	if (!msec) {
+		tcp->time_handler = NULL;
+		return;
+	}
+
+	tcp->time_handler = handler;
+	tcp->time_start = get_timer(0);
+	tcp->time_delta = msec_to_ticks(msec);
+}
+
+static void tcp_send_packet(struct tcp_stream *tcp, u8 action,
+			    u32 tcp_seq_num, u32 tcp_ack_num, u32 tx_len)
+{
+	tcp->tx_packets++;
+	net_send_tcp_packet(tx_len, tcp->rhost, tcp->rport,
+			    tcp->lport, action, tcp_seq_num,
+			    tcp_ack_num);
+}
+
+static void tcp_send_repeat(struct tcp_stream *tcp)
+{
+	uchar *ptr;
+	u32 tcp_opts_size;
+	int ret;
+
+	if (!tcp->retry_cnt) {
+		puts("\nTCP: send retry counter exceeded\n");
+		tcp_send_packet(tcp, TCP_RST, tcp->retry_seq_num,
+				tcp->rcv_nxt, 0);
+		tcp_stream_set_status(tcp, TCP_ERR_TOUT);
+		tcp_stream_set_state(tcp, TCP_CLOSED);
+		tcp_stream_destroy(tcp);
+		return;
+	}
+	tcp->retry_cnt--;
+	tcp->retry_timeout += tcp->initial_timeout;
+
+	if (tcp->retry_tx_len > 0) {
+		tcp_opts_size = ROUND_TCPHDR_BYTES(TCP_TSOPT_SIZE +
+						   tcp->lost.len);
+		ptr = net_tx_packet + net_eth_hdr_size() +
+			IP_TCP_HDR_SIZE + tcp_opts_size;
+
+		if (tcp->retry_tx_len > TCP_MSS - tcp_opts_size)
+			tcp->retry_tx_len = TCP_MSS - tcp_opts_size;
+
+		/* refill packet data */
+		ret = tcp->tx(tcp, tcp->retry_tx_offs, ptr, tcp->retry_tx_len);
+		if (ret < 0) {
+			puts("\nTCP: send failure\n");
+			tcp_send_packet(tcp, TCP_RST, tcp->retry_seq_num,
+					tcp->rcv_nxt, 0);
+			tcp_stream_set_status(tcp, TCP_ERR_IO);
+			tcp_stream_set_state(tcp, TCP_CLOSED);
+			tcp_stream_destroy(tcp);
+			return;
+		}
+	}
+	tcp_send_packet(tcp, tcp->retry_action, tcp->retry_seq_num,
+			tcp->rcv_nxt, tcp->retry_tx_len);
+
+	tcp_stream_set_time_handler(tcp, tcp->retry_timeout, tcp_send_repeat);
+}
+
+static void tcp_send_packet_with_retry(struct tcp_stream *tcp, u8 action,
+				       u32 tcp_seq_num, u32 tx_len, u32 tx_offs)
+{
+	tcp->retry_cnt = tcp->max_retry_count;
+	tcp->retry_timeout = tcp->initial_timeout;
+	tcp->retry_action = action;
+	tcp->retry_seq_num = tcp_seq_num;
+	tcp->retry_tx_len = tx_len;
+	tcp->retry_tx_offs = tx_offs;
+
+	tcp_send_packet(tcp, action, tcp_seq_num, tcp->rcv_nxt, tx_len);
+	tcp_stream_set_time_handler(tcp, tcp->retry_timeout, tcp_send_repeat);
+}
+
+static inline u8 tcp_stream_fin_needed(struct tcp_stream *tcp, u32 tcp_seq_num)
+{
+	return (tcp->fin_tx && (tcp_seq_num == tcp->fin_tx_seq)) ? TCP_FIN : 0;
+}
+
+static void tcp_steam_tx_try(struct tcp_stream *tcp)
 {
-	debug_cond(DEBUG_INT_STATE, "--- net_loop TCP handler set (%p)\n", f);
-	if (!f)
-		tcp_packet_handler = dummy_handler;
-	else
-		tcp_packet_handler = f;
+	uchar *ptr;
+	int tx_len;
+	u32 tx_offs, tcp_opts_size;
+
+	if (tcp->state != TCP_ESTABLISHED ||
+	    tcp->time_handler ||
+	    !tcp->tx)
+		return;
+
+	tcp_opts_size = ROUND_TCPHDR_BYTES(TCP_TSOPT_SIZE + tcp->lost.len);
+	tx_len = TCP_MSS - tcp_opts_size;
+	if (tcp->fin_tx) {
+		/* do not try to send beyonds FIN packet limits */
+		if (tcp_seq_cmp(tcp->snd_una, tcp->fin_tx_seq) >= 0)
+			return;
+
+		tx_len = tcp->fin_tx_seq - tcp->snd_una;
+		if (tx_len > TCP_MSS - tcp_opts_size)
+			tx_len = TCP_MSS - tcp_opts_size;
+	}
+
+	tx_offs = tcp_stream_tx_offs(tcp);
+	ptr = net_tx_packet + net_eth_hdr_size() +
+		IP_TCP_HDR_SIZE + tcp_opts_size;
+
+	/* fill packet data and adjust size */
+	tx_len = tcp->tx(tcp, tx_offs, ptr, tx_len);
+	if (tx_len < 0) {
+		puts("\nTCP: send failure\n");
+		tcp_send_packet(tcp, TCP_RST, tcp->retry_seq_num,
+				tcp->rcv_nxt, 0);
+		tcp_stream_set_status(tcp, TCP_ERR_IO);
+		tcp_stream_set_state(tcp, TCP_CLOSED);
+		tcp_stream_destroy(tcp);
+		return;
+	}
+	if (!tx_len)
+		return;
+
+	if (tcp_seq_cmp(tcp->snd_una + tx_len, tcp->snd_nxt) > 0)
+		tcp->snd_nxt = tcp->snd_una + tx_len;
+
+	tcp_send_packet_with_retry(tcp, TCP_ACK | TCP_PUSH,
+				   tcp->snd_una, tx_len, tx_offs);
+}
+
+static void tcp_stream_poll(struct tcp_stream *tcp, ulong time)
+{
+	ulong	delta;
+	void	(*handler)(struct tcp_stream *tcp);
+
+	if (tcp->state == TCP_CLOSED)
+		return;
+
+	/* handle rx inactivity timeout */
+	delta = msec_to_ticks(tcp->rx_inactiv_timeout);
+	if (time - tcp->time_last_rx >= delta) {
+		puts("\nTCP: rx inactivity timeout exceeded\n");
+		tcp_stream_reset(tcp);
+		tcp_stream_set_status(tcp, TCP_ERR_TOUT);
+		tcp_stream_destroy(tcp);
+		return;
+	}
+
+	/* handle retransmit timeout */
+	if (tcp->time_handler &&
+	    time - tcp->time_start >= tcp->time_delta) {
+		handler = tcp->time_handler;
+		tcp->time_handler = NULL;
+		handler(tcp);
+	}
+
+	tcp_steam_tx_try(tcp);
+}
+
+void tcp_streams_poll(void)
+{
+	ulong			time;
+	struct tcp_stream	*tcp;
+
+	time = get_timer(0);
+	tcp = &tcp_stream;
+	tcp_stream_poll(tcp, time);
 }
 
 /**
@@ -240,7 +526,6 @@ int net_set_ack_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	 * This returns the actual rounded up length of the
 	 * TCP header to add to the total packet length
 	 */
-
 	return GET_TCP_HDR_LEN_IN_BYTES(b->sack.hdr.tcp_hlen);
 }
 
@@ -300,18 +585,8 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 			   "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
 			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num);
-		tcp_activity_count = 0;
 		net_set_syn_options(tcp, b);
-		tcp_seq_num = 0;
-		tcp_ack_num = 0;
 		pkt_hdr_len = IP_TCP_O_SIZE;
-		if (tcp->state == TCP_SYN_SENT) {  /* Too many SYNs */
-			action = TCP_FIN;
-			tcp->state = TCP_FIN_WAIT_1;
-		} else {
-			tcp->lost.len = TCP_OPT_LEN_2;
-			tcp->state = TCP_SYN_SENT;
-		}
 		break;
 	case TCP_SYN | TCP_ACK:
 	case TCP_ACK:
@@ -328,21 +603,16 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		payload_len = 0;
 		pkt_hdr_len = IP_TCP_HDR_SIZE;
-		tcp->state = TCP_FIN_WAIT_1;
 		break;
 	case TCP_RST | TCP_ACK:
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
 			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
-		tcp->state = TCP_CLOSED;
 		break;
 	/* Notify connection closing */
 	case (TCP_FIN | TCP_ACK):
 	case (TCP_FIN | TCP_ACK | TCP_PUSH):
-		if (tcp->state == TCP_CLOSE_WAIT)
-			tcp->state = TCP_CLOSING;
-
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
 			   &tcp->rhost, &net_ip,
@@ -382,7 +652,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 	 * it is, then the u-boot tftp or nfs kernel netboot should be
 	 * considered.
 	 */
-	b->ip.hdr.tcp_win = htons(PKTBUFSRX * TCP_MSS >> TCP_SCALE);
+	b->ip.hdr.tcp_win = htons(tcp->rcv_wnd >> TCP_SCALE);
 
 	b->ip.hdr.tcp_xsum = 0;
 	b->ip.hdr.tcp_ugr = 0;
@@ -501,6 +771,7 @@ void tcp_hole(struct tcp_stream *tcp, u32 tcp_seq_num, u32 len)
 void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
 {
 	struct tcp_t_opt  *tsopt;
+	struct tcp_scale  *wsopt;
 	uchar *p = o;
 
 	/*
@@ -515,10 +786,13 @@ void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
 		case TCP_O_END:
 			return;
 		case TCP_O_MSS:
-		case TCP_O_SCL:
 		case TCP_P_SACK:
 		case TCP_V_SACK:
 			break;
+		case TCP_O_SCL:
+			wsopt = (struct tcp_scale *)p;
+			tcp->rmt_win_scale = wsopt->scale;
+			break;
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			tcp->rmt_timestamp = tsopt->t_snd;
@@ -533,129 +807,344 @@ void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
 	}
 }
 
-static u8 tcp_state_machine(struct tcp_stream *tcp, u8 tcp_flags,
-			    u32 tcp_seq_num, int payload_len)
+static int tcp_seg_in_wnd(struct tcp_stream *tcp,
+			  u32 tcp_seq_num, int payload_len)
 {
-	u8 tcp_fin = tcp_flags & TCP_FIN;
-	u8 tcp_syn = tcp_flags & TCP_SYN;
-	u8 tcp_rst = tcp_flags & TCP_RST;
-	u8 tcp_push = tcp_flags & TCP_PUSH;
-	u8 tcp_ack = tcp_flags & TCP_ACK;
-	u8 action = TCP_DATA;
+	if (!payload_len && !tcp->rcv_wnd) {
+		if (tcp_seq_num == tcp->rcv_nxt)
+			return 1;
+	}
+	if (!payload_len && tcp->rcv_wnd > 0) {
+		if (tcp_seq_cmp(tcp->rcv_nxt, tcp_seq_num) <= 0 &&
+		    tcp_seq_cmp(tcp_seq_num, tcp->rcv_nxt + tcp->rcv_wnd) < 0)
+			return 1;
+	}
+	if (payload_len > 0 && tcp->rcv_wnd > 0) {
+		if (tcp_seq_cmp(tcp->rcv_nxt, tcp_seq_num) <= 0 &&
+		    tcp_seq_cmp(tcp_seq_num, tcp->rcv_nxt + tcp->rcv_wnd) < 0)
+			return 1;
+		tcp_seq_num += payload_len - 1;
+		if (tcp_seq_cmp(tcp->rcv_nxt, tcp_seq_num) <= 0 &&
+		    tcp_seq_cmp(tcp_seq_num, tcp->rcv_nxt + tcp->rcv_wnd) < 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int tcp_rx_check_ack_num(struct tcp_stream *tcp, u32 tcp_seq_num,
+				u32 tcp_ack_num, u32 tcp_win_size)
+{
+	u32 old_offs, new_offs;
+	u8 action;
+
+	switch (tcp->state) {
+	case TCP_SYN_RECEIVED:
+		if (tcp_seq_cmp(tcp->snd_una, tcp_ack_num) >= 0 ||
+		    tcp_seq_cmp(tcp_ack_num, tcp->snd_nxt) > 0) {
+			// segment acknowledgment is not acceptable
+			tcp_send_packet(tcp, TCP_RST, tcp_ack_num, 0, 0);
+			return TCP_PACKET_DROP;
+		}
 
+		tcp_stream_set_state(tcp, TCP_ESTABLISHED);
+		tcp->snd_wnd = tcp_win_size;
+		tcp->snd_wl1 = tcp_seq_num;
+		tcp->snd_wl2 = tcp_ack_num;
+
+		if (tcp->on_established)
+			tcp->on_established(tcp);
+
+		fallthrough;
+
+	case TCP_ESTABLISHED:
+	case TCP_FIN_WAIT_1:
+	case TCP_FIN_WAIT_2:
+	case TCP_CLOSE_WAIT:
+	case TCP_CLOSING:
+		if (tcp_seq_cmp(tcp_ack_num, tcp->snd_nxt) > 0) {
+			// ACK acks something not yet sent
+			action = tcp_stream_fin_needed(tcp, tcp->snd_una) | TCP_ACK;
+			tcp_send_packet(tcp, action, tcp->snd_una, tcp->rcv_nxt, 0);
+			return TCP_PACKET_DROP;
+		}
+
+		if (tcp_seq_cmp(tcp->snd_una, tcp_ack_num) < 0) {
+			old_offs = tcp_stream_tx_offs(tcp);
+			tcp->snd_una = tcp_ack_num;
+			new_offs = tcp_stream_tx_offs(tcp);
+			if (tcp->time_handler &&
+			    tcp_seq_cmp(tcp->snd_una, tcp->retry_seq_num) > 0) {
+				tcp_stream_set_time_handler(tcp, 0, NULL);
+			}
+			if (tcp->on_snd_una_update &&
+			    old_offs != new_offs)
+				tcp->on_snd_una_update(tcp, new_offs);
+		}
+
+		if (tcp_seq_cmp(tcp->snd_una, tcp_ack_num) <= 0) {
+			if (tcp_seq_cmp(tcp->snd_wl1, tcp_seq_num) < 0 ||
+			    (tcp->snd_wl1 == tcp_seq_num &&
+			     tcp_seq_cmp(tcp->snd_wl2, tcp_seq_num) <= 0)) {
+				tcp->snd_wnd = tcp_win_size;
+				tcp->snd_wl1 = tcp_seq_num;
+				tcp->snd_wl2 = tcp_ack_num;
+			}
+		}
+
+		if (tcp->state == TCP_FIN_WAIT_1) {
+			if (tcp->snd_una == tcp->snd_nxt)
+				tcp_stream_set_state(tcp, TCP_FIN_WAIT_2);
+		}
+
+		if (tcp->state == TCP_CLOSING) {
+			if (tcp->snd_una == tcp->snd_nxt)
+				tcp_stream_set_state(tcp, TCP_CLOSED);
+		}
+		return TCP_PACKET_OK;
+
+	case TCP_LAST_ACK:
+		if (tcp_ack_num == tcp->snd_nxt)
+			tcp_stream_set_state(tcp, TCP_CLOSED);
+		return TCP_PACKET_OK;
+
+	default:
+		return TCP_PACKET_DROP;
+	}
+}
+
+static int tcp_rx_user_data(struct tcp_stream *tcp, u32 tcp_seq_num,
+			    char *buf, int len)
+{
+	int tmp_len;
+	u32 buf_offs, old_offs, new_offs;
+	u8 action;
+
+	if (!len)
+		return TCP_PACKET_OK;
+
+	switch (tcp->state) {
+	case TCP_ESTABLISHED:
+	case TCP_FIN_WAIT_1:
+	case TCP_FIN_WAIT_2:
+		break;
+	default:
+		return TCP_PACKET_DROP;
+	}
+
+	tmp_len = len;
+	old_offs = tcp_stream_rx_offs(tcp);
+	buf_offs = tcp_seq_num - tcp->irs - 1;
+	if (tcp->rx) {
+		tmp_len = tcp->rx(tcp, buf_offs, buf, len);
+		if (tmp_len < 0) {
+			puts("\nTCP: receive failure\n");
+			tcp_send_packet(tcp, TCP_RST, tcp->snd_una,
+					tcp->rcv_nxt, 0);
+			tcp_stream_set_status(tcp, TCP_ERR_IO);
+			tcp_stream_set_state(tcp, TCP_CLOSED);
+			tcp_stream_destroy(tcp);
+			return TCP_PACKET_DROP;
+		}
+	}
+	if (tmp_len)
+		tcp_hole(tcp, tcp_seq_num, tmp_len);
+
+	new_offs = tcp_stream_rx_offs(tcp);
+	if (tcp->on_rcv_nxt_update && old_offs != new_offs)
+		tcp->on_rcv_nxt_update(tcp, new_offs);
+
+	action = tcp_stream_fin_needed(tcp, tcp->snd_una) | TCP_ACK;
+	tcp_send_packet(tcp, action, tcp->snd_una, tcp->rcv_nxt, 0);
+
+	return TCP_PACKET_OK;
+}
+
+void tcp_rx_state_machine(struct tcp_stream *tcp,
+			  union tcp_build_pkt *b, unsigned int pkt_len)
+{
+	int tcp_len = pkt_len - IP_HDR_SIZE;
+	u32 tcp_seq_num, tcp_ack_num, tcp_win_size;
+	int tcp_hdr_len, payload_len;
+	u8  tcp_flags, action;
+
+	tcp_hdr_len = GET_TCP_HDR_LEN_IN_BYTES(b->ip.hdr.tcp_hlen);
+	payload_len = tcp_len - tcp_hdr_len;
+
+	if (tcp_hdr_len > TCP_HDR_SIZE)
+		tcp_parse_options(tcp, (uchar *)b + IP_TCP_HDR_SIZE,
+				  tcp_hdr_len - TCP_HDR_SIZE);
 	/*
-	 * tcp_flags are examined to determine TX action in a given state
-	 * tcp_push is interpreted to mean "inform the app"
-	 * urg, ece, cer and nonce flags are not supported.
-	 *
-	 * exe and crw are use to signal and confirm knowledge of congestion.
-	 * This TCP only sends a file request and acks. If it generates
-	 * congestion, the network is broken.
+	 * Incoming sequence and ack numbers are server's view of the numbers.
+	 * The app must swap the numbers when responding.
 	 */
-	debug_cond(DEBUG_INT_STATE, "TCP STATE ENTRY %x\n", action);
-	if (tcp_rst) {
-		action = TCP_DATA;
-		tcp->state = TCP_CLOSED;
-		net_set_state(NETLOOP_FAIL);
-		debug_cond(DEBUG_INT_STATE, "TCP Reset %x\n", tcp_flags);
-		return TCP_RST;
-	}
+	tcp_seq_num = ntohl(b->ip.hdr.tcp_seq);
+	tcp_ack_num = ntohl(b->ip.hdr.tcp_ack);
+	tcp_win_size = ntohs(b->ip.hdr.tcp_win) << tcp->rmt_win_scale;
 
-	switch  (tcp->state) {
+	tcp_flags = b->ip.hdr.tcp_flags;
+
+//	printf("pkt: seq=%d, ack=%d, flags=%x, len=%d\n",
+//		tcp_seq_num - tcp->irs, tcp_ack_num - tcp->iss, tcp_flags, pkt_len);
+//	printf("tcp: rcv_nxt=%d, snd_una=%d, snd_nxt=%d\n\n",
+//		tcp->rcv_nxt - tcp->irs, tcp->snd_una - tcp->iss, tcp->snd_nxt - tcp->iss);
+
+	switch (tcp->state) {
 	case TCP_CLOSED:
-		debug_cond(DEBUG_INT_STATE, "TCP CLOSED %x\n", tcp_flags);
-		if (tcp_syn) {
-			action = TCP_SYN | TCP_ACK;
-			tcp->irs = tcp_seq_num;
-			tcp->rcv_nxt = tcp_seq_num + 1;
-			tcp->lost.len = TCP_OPT_LEN_2;
-			tcp->state = TCP_SYN_RECEIVED;
-		} else if (tcp_ack || tcp_fin) {
-			action = TCP_DATA;
+		if (tcp_flags & TCP_RST)
+			return;
+
+		if (tcp_flags & TCP_ACK) {
+			tcp_send_packet(tcp, TCP_RST, tcp_ack_num, 0, 0);
+			return;
 		}
-		break;
-	case TCP_SYN_RECEIVED:
+
+		if (!(tcp_flags & TCP_SYN))
+			return;
+
+		tcp->irs = tcp_seq_num;
+		tcp->rcv_nxt = tcp->irs + 1;
+
+		tcp->iss = tcp_get_start_seq();
+		tcp->snd_una = tcp->iss;
+		tcp->snd_nxt = tcp->iss + 1;
+		tcp->snd_wnd = tcp_win_size;
+
+		tcp_stream_restart_rx_timer(tcp);
+
+		tcp_stream_set_state(tcp, TCP_SYN_RECEIVED);
+		tcp_send_packet_with_retry(tcp, TCP_SYN | TCP_ACK,
+					   tcp->iss, 0, 0);
+		return;
+
 	case TCP_SYN_SENT:
-		debug_cond(DEBUG_INT_STATE, "TCP_SYN_SENT | TCP_SYN_RECEIVED %x, %u\n",
-			   tcp_flags, tcp_seq_num);
-		if (tcp_fin) {
-			action = action | TCP_PUSH;
-			tcp->state = TCP_CLOSE_WAIT;
-		} else if (tcp_ack || (tcp_syn && tcp_ack)) {
-			action |= TCP_ACK;
-			tcp->irs = tcp_seq_num;
-			tcp->rcv_nxt = tcp_seq_num + 1;
-			tcp->state = TCP_ESTABLISHED;
-
-			if (tcp_syn && tcp_ack)
-				action |= TCP_PUSH;
-		} else {
-			action = TCP_DATA;
+		if (!(tcp_flags & TCP_ACK))
+			return;
+
+		if (tcp_seq_cmp(tcp_ack_num, tcp->iss) <= 0 ||
+		    tcp_seq_cmp(tcp_ack_num, tcp->snd_nxt) > 0) {
+			if (!(tcp_flags & TCP_RST))
+				tcp_send_packet(tcp, TCP_RST, tcp_ack_num, 0, 0);
+			return;
 		}
-		break;
+
+		if (tcp_flags & TCP_RST) {
+			tcp_stream_set_status(tcp, TCP_ERR_RST);
+			tcp_stream_set_state(tcp, TCP_CLOSED);
+			return;
+		}
+
+		if (!(tcp_flags & TCP_SYN))
+			return;
+
+		/* stop retransmit of SYN */
+		tcp_stream_set_time_handler(tcp, 0, NULL);
+
+		tcp->irs = tcp_seq_num;
+		tcp->rcv_nxt = tcp->irs + 1;
+		tcp->snd_una = tcp_ack_num;
+
+		tcp_stream_restart_rx_timer(tcp);
+
+		/* our SYN has been ACKed */
+		tcp_stream_set_state(tcp, TCP_ESTABLISHED);
+
+		if (tcp->on_established)
+			tcp->on_established(tcp);
+
+		action = tcp_stream_fin_needed(tcp, tcp->snd_una) | TCP_ACK;
+		tcp_send_packet(tcp, action, tcp->snd_una, tcp->rcv_nxt, 0);
+		tcp_rx_user_data(tcp, tcp_seq_num,
+				 ((char *)b) + pkt_len - payload_len,
+				 payload_len);
+		return;
+
+	case TCP_SYN_RECEIVED:
 	case TCP_ESTABLISHED:
-		debug_cond(DEBUG_INT_STATE, "TCP_ESTABLISHED %x\n", tcp_flags);
-		if (payload_len > 0) {
-			tcp_hole(tcp, tcp_seq_num, payload_len);
-			tcp_fin = TCP_DATA;  /* cause standalone FIN */
+	case TCP_FIN_WAIT_1:
+	case TCP_FIN_WAIT_2:
+	case TCP_CLOSE_WAIT:
+	case TCP_CLOSING:
+	case TCP_LAST_ACK:
+		if (!tcp_seg_in_wnd(tcp, tcp_seq_num, payload_len)) {
+			if (tcp_flags & TCP_RST)
+				return;
+			action = tcp_stream_fin_needed(tcp, tcp->snd_una) | TCP_ACK;
+			tcp_send_packet(tcp, action, tcp->snd_una, tcp->rcv_nxt, 0);
+			return;
 		}
 
-		if ((tcp_fin) &&
-		    (!IS_ENABLED(CONFIG_PROT_TCP_SACK) ||
-		     tcp->lost.len <= TCP_OPT_LEN_2)) {
-			action = action | TCP_FIN | TCP_PUSH | TCP_ACK;
-			tcp->state = TCP_CLOSE_WAIT;
-		} else if (tcp_ack) {
-			action = TCP_DATA;
+		tcp_stream_restart_rx_timer(tcp);
+
+		if (tcp_flags & TCP_RST) {
+			tcp_stream_set_status(tcp, TCP_ERR_RST);
+			tcp_stream_set_state(tcp, TCP_CLOSED);
+			return;
 		}
 
-		if (tcp_syn)
-			action = TCP_ACK + TCP_RST;
-		else if (tcp_push)
-			action = action | TCP_PUSH;
-		break;
-	case TCP_CLOSE_WAIT:
-		debug_cond(DEBUG_INT_STATE, "TCP_CLOSE_WAIT (%x)\n", tcp_flags);
-		action = TCP_DATA;
-		break;
-	case TCP_FIN_WAIT_2:
-		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_2 (%x)\n", tcp_flags);
-		if (tcp_ack) {
-			action = TCP_PUSH | TCP_ACK;
-			tcp->state = TCP_CLOSED;
-			puts("\n");
-		} else if (tcp_syn) {
-			action = TCP_DATA;
-		} else if (tcp_fin) {
-			action = TCP_DATA;
+		if (tcp_flags & TCP_SYN) {
+			tcp_send_packet(tcp, TCP_RST, tcp_ack_num, 0, 0);
+			tcp_stream_set_status(tcp, TCP_ERR_RST);
+			tcp_stream_set_state(tcp, TCP_CLOSED);
+			return;
 		}
-		break;
-	case TCP_FIN_WAIT_1:
-		debug_cond(DEBUG_INT_STATE, "TCP_FIN_WAIT_1 (%x)\n", tcp_flags);
-		if (tcp_fin) {
-			tcp->rcv_nxt++;
-			action = TCP_ACK | TCP_FIN;
-			tcp->state = TCP_FIN_WAIT_2;
+
+		if (!(tcp_flags & TCP_ACK))
+			return;
+
+		if (tcp_rx_check_ack_num(tcp, tcp_seq_num, tcp_ack_num,
+					 tcp_win_size) == TCP_PACKET_DROP) {
+			return;
 		}
-		if (tcp_syn)
-			action = TCP_RST;
-		if (tcp_ack)
-			tcp->state = TCP_CLOSED;
-		break;
-	case TCP_CLOSING:
-		debug_cond(DEBUG_INT_STATE, "TCP_CLOSING (%x)\n", tcp_flags);
-		if (tcp_ack) {
-			action = TCP_PUSH;
-			tcp->state = TCP_CLOSED;
-			puts("\n");
-		} else if (tcp_syn) {
-			action = TCP_RST;
-		} else if (tcp_fin) {
-			action = TCP_DATA;
+
+		if (tcp_rx_user_data(tcp, tcp_seq_num,
+				     ((char *)b) + pkt_len - payload_len,
+				     payload_len) == TCP_PACKET_DROP) {
+			return;
+		}
+
+		if (tcp_flags & TCP_FIN) {
+			tcp->fin_rx = 1;
+			tcp->fin_rx_seq = tcp_seq_num + payload_len + 1;
+			tcp_hole(tcp, tcp_seq_num + payload_len, 1);
+			action = tcp_stream_fin_needed(tcp, tcp->snd_una) | TCP_ACK;
+			tcp_send_packet(tcp, action, tcp->snd_una, tcp->rcv_nxt, 0);
+		}
+
+		if (tcp->fin_rx &&
+		    tcp->fin_rx_seq == tcp->rcv_nxt) {
+			/* all rx data were processed */
+			switch (tcp->state) {
+			case TCP_ESTABLISHED:
+				tcp_stream_set_state(tcp, TCP_LAST_ACK);
+				tcp_send_packet_with_retry(tcp, TCP_ACK | TCP_FIN,
+							   tcp->snd_nxt, 0, 0);
+				tcp->snd_nxt++;
+				break;
+
+			case TCP_FIN_WAIT_1:
+				if (tcp_ack_num == tcp->snd_nxt)
+					tcp_stream_set_state(tcp, TCP_CLOSED);
+				else
+					tcp_stream_set_state(tcp, TCP_CLOSING);
+				break;
+
+			case TCP_FIN_WAIT_2:
+				tcp_stream_set_state(tcp, TCP_CLOSED);
+				break;
+
+			default:
+				break;
+			}
+		}
+
+		if (tcp->state == TCP_FIN_WAIT_1 &&
+		    tcp_stream_fin_needed(tcp, tcp->snd_una)) {
+			/* all tx data were acknowledged */
+			tcp_send_packet_with_retry(tcp, TCP_ACK | TCP_FIN,
+						   tcp->snd_una, 0, 0);
 		}
-		break;
 	}
-	return action;
 }
 
 /**
@@ -667,9 +1156,6 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 {
 	int tcp_len = pkt_len - IP_HDR_SIZE;
 	u16 tcp_rx_xsum = b->ip.hdr.ip_sum;
-	u8  tcp_action = TCP_DATA;
-	u32 tcp_seq_num, tcp_ack_num;
-	int tcp_hdr_len, payload_len;
 	struct tcp_stream *tcp;
 	struct in_addr src;
 
@@ -713,54 +1199,59 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	if (!tcp)
 		return;
 
-	tcp_hdr_len = GET_TCP_HDR_LEN_IN_BYTES(b->ip.hdr.tcp_hlen);
-	payload_len = tcp_len - tcp_hdr_len;
+	tcp->rx_packets++;
+	tcp_rx_state_machine(tcp, b, pkt_len);
+	tcp_stream_put(tcp);
+}
 
-	if (tcp_hdr_len > TCP_HDR_SIZE)
-		tcp_parse_options(tcp, (uchar *)b + IP_TCP_HDR_SIZE,
-				  tcp_hdr_len - TCP_HDR_SIZE);
-	/*
-	 * Incoming sequence and ack numbers are server's view of the numbers.
-	 * The app must swap the numbers when responding.
-	 */
-	tcp_seq_num = ntohl(b->ip.hdr.tcp_seq);
-	tcp_ack_num = ntohl(b->ip.hdr.tcp_ack);
+struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport)
+{
+	struct tcp_stream *tcp;
 
-	/* Packets are not ordered. Send to app as received. */
-	tcp_action = tcp_state_machine(tcp, b->ip.hdr.tcp_flags,
-				       tcp_seq_num, payload_len);
+	tcp = tcp_stream_add(rhost, rport, random_port());
+	if (!tcp)
+		return NULL;
 
-	tcp_activity_count++;
-	if (tcp_activity_count > TCP_ACTIVITY) {
-		puts("| ");
-		tcp_activity_count = 0;
-	}
+	tcp->iss = tcp_get_start_seq();
+	tcp->snd_una = tcp->iss;
+	tcp->snd_nxt = tcp->iss + 1;
 
-	if ((tcp_action & TCP_PUSH) || payload_len > 0) {
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Notify (action=%x, Seq=%u,Ack=%u,Pay%d)\n",
-			   tcp_action, tcp_seq_num, tcp_ack_num, payload_len);
+	tcp_stream_set_state(tcp, TCP_SYN_SENT);
+	tcp_send_packet_with_retry(tcp, TCP_SYN, tcp->snd_una, 0, 0);
 
-		(*tcp_packet_handler) (tcp, (uchar *)b + pkt_len - payload_len,
-				       tcp_seq_num, tcp_ack_num, tcp_action,
-				       payload_len);
+	return tcp;
+}
 
-	} else if (tcp_action != TCP_DATA) {
-		debug_cond(DEBUG_DEV_PKT,
-			   "TCP Action (action=%x,Seq=%u,Ack=%u,Pay=%d)\n",
-			   tcp_action, tcp_ack_num, tcp->rcv_nxt, payload_len);
-
-		/*
-		 * Warning: Incoming Ack & Seq sequence numbers are transposed
-		 * here to outgoing Seq & Ack sequence numbers
-		 */
-		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
-				    (tcp_action & (~TCP_PUSH)),
-				    tcp_ack_num, tcp->rcv_nxt);
-	}
+void tcp_stream_reset(struct tcp_stream *tcp)
+{
+	if (tcp->state == TCP_CLOSED)
+		return;
+
+	tcp_stream_set_time_handler(tcp, 0, NULL);
+	tcp_send_packet(tcp, TCP_RST, tcp->snd_una, 0, 0);
+	tcp_stream_set_status(tcp, TCP_ERR_RST);
+	tcp_stream_set_state(tcp, TCP_CLOSED);
 }
 
-struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport)
+void tcp_stream_close(struct tcp_stream *tcp)
 {
-	return tcp_stream_add(rhost, rport, random_port());
+	switch (tcp->state) {
+	case TCP_SYN_SENT:
+		tcp_stream_reset(tcp);
+		break;
+	case TCP_SYN_RECEIVED:
+	case TCP_ESTABLISHED:
+		tcp->fin_tx = 1;
+		tcp->fin_tx_seq = tcp->snd_nxt;
+		if (tcp_stream_fin_needed(tcp, tcp->snd_una)) {
+			/* all tx data were acknowledged */
+			tcp_send_packet_with_retry(tcp, TCP_ACK | TCP_FIN,
+						   tcp->snd_una, 0, 0);
+		}
+		tcp_stream_set_state(tcp, TCP_FIN_WAIT_1);
+		tcp->snd_nxt++;
+		break;
+	default:
+		break;
+	}
 }
diff --git a/net/wget.c b/net/wget.c
index 3638cbf9373..c114c4238c2 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -22,46 +22,25 @@ DECLARE_GLOBAL_DATA_PTR;
 /* The default, change with environment variable 'httpdstp' */
 #define SERVER_PORT		80
 
+#define HASHES_PER_LINE		65
+
+#define HTTP_MAX_HDR_LEN	2048
+
 static const char bootfile1[] = "GET ";
 static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
 static const char http_eom[] = "\r\n\r\n";
-static const char http_ok[] = "200";
+static const char http_ok[] = " 200 ";
+static const char content_len[] = "Content-Length:";
 static const char linefeed[] = "\r\n";
-static int wget_timeout_count;
-struct tcp_stream *tcp;
-
-struct pkt_qd {
-	uchar *pkt;
-	unsigned int tcp_seq_num;
-	unsigned int len;
-};
-
-/*
- * This is a control structure for out of order packets received.
- * The actual packet bufers are in the kernel space, and are
- * expected to be overwritten by the downloaded image.
- */
-#define PKTQ_SZ (PKTBUFSRX / 4)
-static struct pkt_qd pkt_q[PKTQ_SZ];
-static int pkt_q_idx;
-static unsigned int packets;
-
-static unsigned int initial_data_seq_num;
-static unsigned int next_data_seq_num;
-
-static enum  wget_state current_wget_state;
+static struct in_addr web_server_ip;
+static unsigned int server_port;
+static unsigned long content_length;
+static u32 http_hdr_size;
+static int wget_tsize_num_hash;
 
 static char *image_url;
-static unsigned int wget_timeout = WGET_TIMEOUT;
-
 static enum net_loop_state wget_loop_state;
 
-/* Timeout retry parameters */
-static u8 retry_action;			/* actions for TCP retry */
-static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
-static unsigned int retry_tcp_seq_num;	/* TCP retry sequence number */
-static int retry_len;			/* TCP retry length */
-
 /**
  * store_block() - store block in memory
  * @src: source of data
@@ -71,7 +50,6 @@ static int retry_len;			/* TCP retry length */
 static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 {
 	ulong store_addr = image_load_addr + offset;
-	ulong newsize = offset + len;
 	uchar *ptr;
 
 	if (CONFIG_IS_ENABLED(LMB)) {
@@ -87,310 +65,158 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 	memcpy(ptr, src, len);
 	unmap_sysmem(ptr);
 
-	if (net_boot_file_size < (offset + len))
-		net_boot_file_size = newsize;
-
 	return 0;
 }
 
-/**
- * wget_send_stored() - wget response dispatcher
- *
- * WARNING, This, and only this, is the place in wget.c where
- * SEQUENCE NUMBERS are swapped between incoming (RX)
- * and outgoing (TX).
- * Procedure wget_handler() is correct for RX traffic.
- */
-static void wget_send_stored(void)
+static void show_block_marker(u32 packets)
 {
-	u8 action = retry_action;
-	int len = retry_len;
-	unsigned int tcp_ack_num = retry_tcp_seq_num + (len == 0 ? 1 : len);
-	unsigned int tcp_seq_num = retry_tcp_ack_num;
-	uchar *ptr, *offset;
-
-	switch (current_wget_state) {
-	case WGET_CLOSED:
-		debug_cond(DEBUG_WGET, "wget: send SYN\n");
-		current_wget_state = WGET_CONNECTING;
-		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
-				    tcp_seq_num, tcp_ack_num);
-		packets = 0;
-		break;
-	case WGET_CONNECTING:
-		pkt_q_idx = 0;
-		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
-				    tcp_seq_num, tcp_ack_num);
-
-		ptr = net_tx_packet + net_eth_hdr_size() +
-			IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
-		offset = ptr;
-
-		memcpy(offset, &bootfile1, strlen(bootfile1));
-		offset += strlen(bootfile1);
-
-		memcpy(offset, image_url, strlen(image_url));
-		offset += strlen(image_url);
-
-		memcpy(offset, &bootfile3, strlen(bootfile3));
-		offset += strlen(bootfile3);
-		net_send_tcp_packet((offset - ptr), tcp->rhost, tcp->rport, tcp->lport,
-				    TCP_PUSH, tcp_seq_num, tcp_ack_num);
-		current_wget_state = WGET_CONNECTED;
-		break;
-	case WGET_CONNECTED:
-	case WGET_TRANSFERRING:
-	case WGET_TRANSFERRED:
-		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
-				    tcp_seq_num, tcp_ack_num);
-		break;
+	int cnt;
+
+	if (content_length != -1) {
+		if (net_boot_file_size > content_length)
+			content_length = net_boot_file_size;
+
+		cnt = net_boot_file_size * 50 / content_length;
+		while (wget_tsize_num_hash < cnt) {
+			putc('#');
+			wget_tsize_num_hash++;
+		}
+	} else {
+		if ((packets % 10) == 0)
+			putc('#');
+		else if (((packets + 1) % (10 * HASHES_PER_LINE)) == 0)
+			puts("\n");
 	}
 }
 
-static void wget_send(u8 action, unsigned int tcp_seq_num,
-		      unsigned int tcp_ack_num, int len)
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
 {
-	retry_action = action;
-	retry_tcp_ack_num = tcp_ack_num;
-	retry_tcp_seq_num = tcp_seq_num;
-	retry_len = len;
+	if (tcp->status != TCP_ERR_OK)
+		wget_loop_state = NETLOOP_FAIL;
 
-	wget_send_stored();
-}
+	net_set_state(wget_loop_state);
+	if (wget_loop_state != NETLOOP_SUCCESS) {
+		printf("\nwget: Transfer Fail, TCP status - %d\n", tcp->status);
+		return;
+	}
 
-void wget_fail(char *error_message, unsigned int tcp_seq_num,
-	       unsigned int tcp_ack_num, u8 action)
-{
-	printf("wget: Transfer Fail - %s\n", error_message);
-	net_set_timeout_handler(0, NULL);
-	wget_send(action, tcp_seq_num, tcp_ack_num, 0);
+	printf("\nPackets received %d, Transfer Successful\n", tcp->rx_packets);
+	efi_set_bootdev("Net", "", image_url,
+			map_sysmem(image_load_addr, 0),
+			net_boot_file_size);
+	env_set_hex("filesize", net_boot_file_size);
 }
 
-/*
- * Interfaces of U-BOOT
- */
-static void wget_timeout_handler(void)
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 {
-	if (++wget_timeout_count > WGET_RETRY_COUNT) {
-		puts("\nRetry count exceeded; starting again\n");
-		wget_send(TCP_RST, 0, 0, 0);
-		net_start_again();
-	} else {
-		puts("T ");
-		net_set_timeout_handler(wget_timeout +
-					WGET_TIMEOUT * wget_timeout_count,
-					wget_timeout_handler);
-		wget_send_stored();
-	}
-}
+	char	*pos, *tail;
+	uchar	saved, *ptr;
+	int i;
 
-#define PKT_QUEUE_OFFSET 0x20000
-#define PKT_QUEUE_PACKET_SIZE 0x800
+	if (http_hdr_size) {
+		net_boot_file_size = rx_bytes - http_hdr_size;
+		show_block_marker(tcp->rx_packets);
+		return;
+	}
 
-static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
-			   u8 action, unsigned int tcp_ack_num, unsigned int len)
-{
-	uchar *pkt_in_q;
-	char *pos;
-	int hlen, i;
-	uchar *ptr1;
+	ptr = map_sysmem(image_load_addr, rx_bytes + 1);
 
-	pkt[len] = '\0';
-	pos = strstr((char *)pkt, http_eom);
+	saved = ptr[rx_bytes];
+	ptr[rx_bytes] = '\0';
+	pos = strstr((char *)ptr, http_eom);
+	ptr[rx_bytes] = saved;
 
 	if (!pos) {
-		debug_cond(DEBUG_WGET,
-			   "wget: Connected, data before Header %p\n", pkt);
-		pkt_in_q = (void *)image_load_addr + PKT_QUEUE_OFFSET +
-			(pkt_q_idx * PKT_QUEUE_PACKET_SIZE);
-
-		ptr1 = map_sysmem((ulong)pkt_in_q, len);
-		memcpy(ptr1, pkt, len);
-		unmap_sysmem(ptr1);
+		if (rx_bytes < HTTP_MAX_HDR_LEN &&
+		    tcp->state == TCP_ESTABLISHED)
+			goto end;
+
+		printf("ERROR: misssed HTTP header\n");
+		tcp_stream_close(tcp);
+		wget_loop_state = NETLOOP_FAIL;
+		goto end;
+	}
 
-		pkt_q[pkt_q_idx].pkt = pkt_in_q;
-		pkt_q[pkt_q_idx].tcp_seq_num = tcp_seq_num;
-		pkt_q[pkt_q_idx].len = len;
-		pkt_q_idx++;
+	http_hdr_size = pos - (char *)ptr + strlen(http_eom);
+	*pos = '\0';
+
+	pos = strstr((char *)ptr, linefeed);
+	if (pos)
+		i = pos - (char *)ptr;
+	else
+		i = http_hdr_size - strlen(http_eom);
+	printf("%.*s\n", i,  ptr);
+
+	if (!strstr((char *)ptr, http_ok)) {
+		debug_cond(DEBUG_WGET, "wget: Connected Bad Xfer\n");
+		tcp_stream_close(tcp);
+		wget_loop_state = NETLOOP_FAIL;
+		goto end;
+	}
 
-		if (pkt_q_idx >= PKTQ_SZ) {
-			printf("wget: Fatal error, queue overrun!\n");
-			net_set_state(NETLOOP_FAIL);
+	debug_cond(DEBUG_WGET, "wget: Connctd pkt %p  hlen %x\n",
+		   ptr, http_hdr_size);
 
-			return;
-		}
+	pos = strstr((char *)ptr, content_len);
+	if (!pos) {
+		content_length = -1;
 	} else {
-		debug_cond(DEBUG_WGET, "wget: Connected HTTP Header %p\n", pkt);
-		/* sizeof(http_eom) - 1 is the string length of (http_eom) */
-		hlen = pos - (char *)pkt + sizeof(http_eom) - 1;
-		pos = strstr((char *)pkt, linefeed);
-		if (pos > 0)
-			i = pos - (char *)pkt;
-		else
-			i = hlen;
-		printf("%.*s", i,  pkt);
-
-		current_wget_state = WGET_TRANSFERRING;
-
-		initial_data_seq_num = tcp_seq_num + hlen;
-		next_data_seq_num    = tcp_seq_num + len;
-
-		if (strstr((char *)pkt, http_ok) == 0) {
-			debug_cond(DEBUG_WGET,
-				   "wget: Connected Bad Xfer\n");
-			wget_loop_state = NETLOOP_FAIL;
-			wget_send(action, tcp_seq_num, tcp_ack_num, len);
-		} else {
-			debug_cond(DEBUG_WGET,
-				   "wget: Connected Pkt %p hlen %x\n",
-				   pkt, hlen);
-
-			net_boot_file_size = 0;
-
-			if (len > hlen) {
-				if (store_block(pkt + hlen, 0, len - hlen) != 0) {
-					wget_loop_state = NETLOOP_FAIL;
-					wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
-					net_set_state(NETLOOP_FAIL);
-					return;
-				}
-			}
-
-			for (i = 0; i < pkt_q_idx; i++) {
-				int err;
-
-				ptr1 = map_sysmem((ulong)pkt_q[i].pkt,
-						  pkt_q[i].len);
-				err = store_block(ptr1,
-					  pkt_q[i].tcp_seq_num -
-					  initial_data_seq_num,
-					  pkt_q[i].len);
-				unmap_sysmem(ptr1);
-				debug_cond(DEBUG_WGET,
-					   "wget: Conncted pkt Q %p len %x\n",
-					   pkt_q[i].pkt, pkt_q[i].len);
-				if (err) {
-					wget_loop_state = NETLOOP_FAIL;
-					wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
-					net_set_state(NETLOOP_FAIL);
-					return;
-				}
-			}
-		}
+		pos += strlen(content_len) + 1;
+		content_length = simple_strtoul(pos, &tail, 10);
+		if (*tail != '\r' && *tail != '\n' && *tail != '\0')
+			content_length = -1;
+		printf("%s %d\n", content_len, (int)content_length);
 	}
-	wget_send(action, tcp_seq_num, tcp_ack_num, len);
+
+	net_boot_file_size = rx_bytes - http_hdr_size;
+	memmove(ptr, ptr + http_hdr_size, net_boot_file_size);
+
+end:
+	unmap_sysmem(ptr);
+
+	wget_loop_state = NETLOOP_SUCCESS;
 }
 
-/**
- * wget_handler() - TCP handler of wget
- * @tcp: TCP stream
- * @pkt: pointer to the application packet
- * @tcp_seq_num: TCP sequential number
- * @tcp_ack_num: TCP acknowledgment number
- * @action: TCP action (SYN, ACK, FIN, etc)
- * @len: packet length
- *
- * In the "application push" invocation, the TCP header with all
- * its information is pointed to by the packet pointer.
- */
-static void wget_handler(struct tcp_stream *tcp, uchar *pkt,
-			 u32 tcp_seq_num, u32 tcp_ack_num,
-			 u8 action, unsigned int len)
+static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len)
 {
-	enum tcp_state wget_tcp_state = tcp_stream_get_state(tcp);
-
-	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
-	packets++;
-
-	switch (current_wget_state) {
-	case WGET_CLOSED:
-		debug_cond(DEBUG_WGET, "wget: Handler: Error!, State wrong\n");
-		break;
-	case WGET_CONNECTING:
-		debug_cond(DEBUG_WGET,
-			   "wget: Connecting In len=%x, Seq=%u, Ack=%u\n",
-			   len, tcp_seq_num, tcp_ack_num);
-		if (!len) {
-			if (wget_tcp_state == TCP_ESTABLISHED) {
-				debug_cond(DEBUG_WGET,
-					   "wget: Cting, send, len=%x\n", len);
-				wget_send(action, tcp_seq_num, tcp_ack_num,
-					  len);
-			} else {
-				printf("%.*s", len,  pkt);
-				wget_fail("wget: Handler Connected Fail\n",
-					  tcp_seq_num, tcp_ack_num, action);
-			}
-		}
-		break;
-	case WGET_CONNECTED:
-		debug_cond(DEBUG_WGET, "wget: Connected seq=%u, len=%x\n",
-			   tcp_seq_num, len);
-		if (!len) {
-			wget_fail("Image not found, no data returned\n",
-				  tcp_seq_num, tcp_ack_num, action);
-		} else {
-			wget_connected(pkt, tcp_seq_num, action, tcp_ack_num, len);
-		}
-		break;
-	case WGET_TRANSFERRING:
-		debug_cond(DEBUG_WGET,
-			   "wget: Transferring, seq=%x, ack=%x,len=%x\n",
-			   tcp_seq_num, tcp_ack_num, len);
-
-		if (next_data_seq_num != tcp_seq_num) {
-			debug_cond(DEBUG_WGET, "wget: seq=%x packet was lost\n", next_data_seq_num);
-			return;
-		}
-		next_data_seq_num = tcp_seq_num + len;
+	store_block(buf, rx_offs - http_hdr_size, len);
 
-		if (store_block(pkt, tcp_seq_num - initial_data_seq_num, len) != 0) {
-			wget_fail("wget: store error\n",
-				  tcp_seq_num, tcp_ack_num, action);
-			net_set_state(NETLOOP_FAIL);
-			return;
-		}
+	return len;
+}
 
-		switch (wget_tcp_state) {
-		case TCP_FIN_WAIT_2:
-			wget_send(TCP_ACK, tcp_seq_num, tcp_ack_num, len);
-			fallthrough;
-		case TCP_SYN_SENT:
-		case TCP_SYN_RECEIVED:
-		case TCP_CLOSING:
-		case TCP_FIN_WAIT_1:
-		case TCP_CLOSED:
-			net_set_state(NETLOOP_FAIL);
-			break;
-		case TCP_ESTABLISHED:
-			wget_send(TCP_ACK, tcp_seq_num, tcp_ack_num,
-				  len);
-			wget_loop_state = NETLOOP_SUCCESS;
-			break;
-		case TCP_CLOSE_WAIT:     /* End of transfer */
-			current_wget_state = WGET_TRANSFERRED;
-			wget_send(action | TCP_ACK | TCP_FIN,
-				  tcp_seq_num, tcp_ack_num, len);
-			break;
-		}
-		break;
-	case WGET_TRANSFERRED:
-		printf("Packets received %d, Transfer Successful\n", packets);
-		net_set_state(wget_loop_state);
-		efi_set_bootdev("Net", "", image_url,
-				map_sysmem(image_load_addr, 0),
-				net_boot_file_size);
-		env_set_hex("filesize", net_boot_file_size);
-		break;
-	}
+static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, int maxlen)
+{
+	int ret;
+
+	if (tx_offs)
+		return 0;
+
+	ret = snprintf(buf, maxlen, "%s%s%s", bootfile1, image_url, bootfile3);
+
+	return ret;
+}
+
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (tcp->rhost.s_addr != web_server_ip.s_addr ||
+	    tcp->rport != server_port)
+		return 0;
+
+	tcp->max_retry_count = WGET_RETRY_COUNT;
+	tcp->initial_timeout = WGET_TIMEOUT;
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+	tcp->rx = tcp_stream_rx;
+	tcp->tx = tcp_stream_tx;
+
+	return 1;
 }
 
 #define BLOCKSIZE 512
 
 void wget_start(void)
 {
-	struct in_addr web_server_ip;
-	unsigned int server_port;
+	struct tcp_stream *tcp;
 
 	image_url = strchr(net_boot_file_name, ':');
 	if (image_url > 0) {
@@ -429,12 +255,6 @@ void wget_start(void)
 	debug_cond(DEBUG_WGET,
 		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
 
-	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
-	tcp_set_tcp_handler(wget_handler);
-
-	wget_timeout_count = 0;
-	current_wget_state = WGET_CLOSED;
-
 	/*
 	 * Zero out server ether to force arp resolution in case
 	 * the server ip for the previous u-boot command, for example dns
@@ -443,14 +263,20 @@ void wget_start(void)
 
 	memset(net_server_ethaddr, 0, 6);
 
+	net_boot_file_size = 0;
+	http_hdr_size = 0;
+	wget_tsize_num_hash = 0;
+	wget_loop_state = NETLOOP_FAIL;
+
 	server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
 	tcp = tcp_stream_connect(web_server_ip, server_port);
-	if (tcp == NULL) {
+	if (!tcp) {
+		printf("No free tcp streams\n");
 		net_set_state(NETLOOP_FAIL);
 		return;
 	}
-
-	wget_send(TCP_SYN, 0, 0, 0);
+	tcp_stream_put(tcp);
 }
 
 #if (IS_ENABLED(CONFIG_CMD_DNS))
-- 
2.45.2

