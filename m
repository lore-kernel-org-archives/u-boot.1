Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD18FE7718F
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C8280562;
	Sat, 28 Dec 2024 11:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="V+aCH5Jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA86804BA; Sat, 28 Dec 2024 11:46:58 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::719])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B5A80362
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWUqetMaK4iLHpQs4ZUYYi+NhqTlL+lrrKXOJS0YRMsLMgJRrf2O0X0yAwmwo50qZBaICQr6NzVvew8P3alu1iQEPTI6Wi5ztHO29IfvhQJsZUhVcF1qBkOelLBPNjdmky0dsAaG15ymOD/1A/OQQg05jk+O/f74zRg6VLw8t75qgw7+WnS77mBjnjCzQ4WKTegyTaVd+vF6xsH6F76FvJvGKYT+LH/06rY6LJ1b8L+8Rm7McaEYwPOWrXbHg3ySynYz24cYTaKOIsCEFLGw3/9kAXFiZk3Y6l7cX7BczQpnqI6JHhMCh6pbnvsRhzgLv08A+qWeXeh/waZJKXxbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwsq9rpbF+lfr8OhPI9DWPJdZWbwsGm1cVNOURt/368=;
 b=XdibPDWfrDbx4ccc+8hya4mzL3o4s9lo+5zq6yiQ239xxX7hjmZPhofZ+kn4S1fVAXqRqiap9WdyGZ01dIT4ARMnJEQ0yC+2z5Zb2J39gwWwwaerKTVXIWJivqKladOP90VDWPhQ/KJmRKtODjWD1VsgXB/iNOSBFMf2fPyphhEC1IfvJI8ldlTWaVOIUXnezqlKQ56iu9G5OgZKknN2Qk6EoRfy4BMQ59B76wmapthrvJO5R0YJUX6DCqAmdH6NN+zLG9ULwb0kE5aT85HToJfAxxBzA+mPAZEntiMlnnA8LfARD3294mSPNsWYlzGxzJtzIx/VokmVBwUfz+YqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwsq9rpbF+lfr8OhPI9DWPJdZWbwsGm1cVNOURt/368=;
 b=V+aCH5JfLB89XKR8cPS5Lu9LUtc0Y1GdNzfVnH7RYiXb2juVS7aQmWKIbGEOrZQth3DXiPoblS3hpGNU5kNQH5kMpKz1gf3D+/3CmEVA+yLSjSru7hZTglTfHvMOZtSkvTUOhyQtAHbrqAeqMtyLLHP/iI3DVeK+M1X30DDBiC2MrAMW7O7WjXWblMCkullqXScyb+UDy9mAfNc89jqO+Lhv24h1i7/RLZ0brUctQMextkGGlQmO7NBJ+cPjYt40C+onFxRvVOLUy6lAYSGEpjUZuUgKYDrSC5wdeNcq+4jZ1ImDmmup2FpxePWSetOwsAdJydpvT7TmX9lUJbl6kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 04/11] net/tcp: add connection info to tcp_stream structure
Date: Sat, 28 Dec 2024 13:46:30 +0300
Message-ID: <20241228104637.4173913-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f04702-caa8-4138-accc-08dd272cef6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kHVALxHEpi0tk4uyNQ5xgerSZI6TgNgSNu8Lixzszy88sMELY6gRZZAkSIFA?=
 =?us-ascii?Q?0EU8/VLOTzelyw8pQWhBrIISZsXqtdq7FX9/Aqhsuptphp0ayGvLXoEkw1xq?=
 =?us-ascii?Q?X4ZbWhQG5qYJ9P1kfPW6SJutOt0prqK446k+AkJH1RHGMi+Rn8VLVYMos2Mj?=
 =?us-ascii?Q?2v6x5E5T0QXK4AleAgLOqWccMXxNoko+IiBzg3bWgE70v4FPnRpeLTjljNk5?=
 =?us-ascii?Q?/jKpsXaf2H0CmIOpLpnZthCuIqzb/l6towCH30Hy9aSoSwrg4BtQh3gS6aQQ?=
 =?us-ascii?Q?SG6hztkIKQ1CqJLaSoMh1NQmyd6XsUXUVLzJrr20JGoiBCUNZFsiboT5HdPg?=
 =?us-ascii?Q?2S4rCo3a++MD9/061TdCFKL3SfwRdkay1Xhk01AjDco4tgl47z6hIJ6nmDsK?=
 =?us-ascii?Q?pQt191BaVQwBc39AQ1tu/14FF5T2TJgKtlwUNvBZRAa25C4sjfRJFnjkTRtE?=
 =?us-ascii?Q?8Nl7IWqFGik6Nojt2HVnUwXRpR902dxDl3/6Q5P9HcD9EALWeTKSKhJgwelI?=
 =?us-ascii?Q?bsp8yugFnW3caurP946c0Wn1fjLeL2McfRiwXKj6xcyIFG6nnXpFiIXWtVxv?=
 =?us-ascii?Q?vaIuT5NY/U90VC6KVVS0Z77/Y1UMyLgJZA8q5kvSrCslY1a1GY7vl/tWW9+g?=
 =?us-ascii?Q?kebzL93c6rLz0yfwC3/s0AWMIGe3opAqSz3zZnfOnGMmyQhGDc2NtBDMDhWt?=
 =?us-ascii?Q?DatOaQ6cmRL0UbpVgKONczjrNzgfdECkVAHRkCCTA1qr3llxahqbdUBj73ZQ?=
 =?us-ascii?Q?NbCo026/zThPAsv1uKN1DDQioTRvT4JZlxhENlDUnHe3O1RB+I1wVYm6kLM4?=
 =?us-ascii?Q?f1/ptyVDMMFoUs8n4TiK2O50d6+GQUuwMfG+rWzoOPeDhUE4poAlf/2nbQku?=
 =?us-ascii?Q?zcHEWbQG8Frv8JVYI3Ic/AwenlFyaYw3uBsagH/HtQM2F9pF8Z2x9seaTHgo?=
 =?us-ascii?Q?sDW1aeu/VBHjkq+ex1zL8irSTcUUJMu6G9TiYHlHWeX6Ey5L3p7HUNAeq56R?=
 =?us-ascii?Q?+p8NBmKScXN3aybaxtAogu4F+lvRzj+FEkLfORMVmQTrGaDAMg4kcZrLvqv+?=
 =?us-ascii?Q?gfCFW4XafOHbkkLmSgBcv0SglqY5oIkCFE5WLSA2PvbtD0/49TQXXBx0BfqK?=
 =?us-ascii?Q?251gKphORLxeOSTbf7lHyjUg/lWPsAvT9cWrD0nlBWc/ayyVAOv0VeRiXTqE?=
 =?us-ascii?Q?ILYawVcaSr+oIYtIq112IlGalBdkR8rLvdwBXGZC+W0TpylusjM9evxaQ0GJ?=
 =?us-ascii?Q?yO0nAHkmL16EOucYsx8+6PulVxlUF0jnhCcL35XXbIv2YN7Ljra29N0Mskha?=
 =?us-ascii?Q?SJD3ncChhm+ieUmvueMeTZUSZ0cy9V5arDrHBeFPBOzN1YOUpuVE5HHf4xdh?=
 =?us-ascii?Q?R1e0A788S6nR6IhERgFEWBcmV/ju1KwxXsjkXZ50agA0Eyfx5PXfe0R3vtg8?=
 =?us-ascii?Q?nbMVZAQTKxZK7Z0Od7pE5XADgJTQqCk2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JROwoPwmmZQY6vJW32nAWrqrcojba5LhdtSjpLsj65jG5s2Wu4Y4LI6rNDN?=
 =?us-ascii?Q?l2uDGMCMotljOO5n8shVen8axWl2ttK1YkhCneImNi5YrRSmh38WpdrAoMmR?=
 =?us-ascii?Q?rMBuhiOdzFjHvbCXIH/+Je7ByZ1acc5zJdH+qah9sfQNGztSTq6GKTpDHkc0?=
 =?us-ascii?Q?Lkuk2y3GQqFCYmdDbmsp3PpksqmuzjU7ZJAW+ZdMGSb3Xlu0mC7PDpPB8Cut?=
 =?us-ascii?Q?vnl+4fid+Qb226Di2mDa2PEFgv7CXiV8yQvHf34ItcD+4wCKlCy6HaDQG4ck?=
 =?us-ascii?Q?M1Y/R/nviTVZI0UME6ucWsfehdF2bUWarWrsR19udOv+fzH5vITI/FQg/MGP?=
 =?us-ascii?Q?CcA7xTliu/HNg9/4bLdTU51M/UFUzFgMQr5C0BOaMo1uD58pq9QrjHGKapSe?=
 =?us-ascii?Q?bC3xFtDVNFgaH9W42EtzSazdpNqtUrwU26Re6kaMkrtgEQBwP2QUmeAGlxv/?=
 =?us-ascii?Q?r6vRniVJ8rhuzSeytrTU1/GTWLAqV0pxiZxlwE8kWL32TLwOdwjNQjqu+x7r?=
 =?us-ascii?Q?oqCjbWHFp2/GApZNZIIraeujwNvYJhsJpBNGoCJScPoAVUISNaHYSVLtMXdx?=
 =?us-ascii?Q?BOPHsI3bwFvsXhFxr8jcai4kklWgHbd0F/QWkWLIIYHUqVlNwGPgDjt+tu1c?=
 =?us-ascii?Q?tk+G94zLUIFSfZBIbYt169q72L8YwtB9LNNVNgbhZs+G9D7jg1HxcAMi57Up?=
 =?us-ascii?Q?auBMoVagaH/dGDe0nSdlACb03LDwSWS+PiyqI9Lukts5jZL7h3pQGmVoBZyy?=
 =?us-ascii?Q?Q8IHvu75NB5hQLHDHsGaB3lF0vqaCzHCaa687/o9NNnk+8RgKF0g6hG2ndDY?=
 =?us-ascii?Q?pJosyM0oVfjnPKNSkqQdnL+Xpp2giVGdbpkHoss4tps3hwxOEaZioUoUkDkl?=
 =?us-ascii?Q?2yWZq1+/vdVUFMr8xGpS1V+TR00SwpX6S27OThRYrx2s9/NAkI2LSCnKovBw?=
 =?us-ascii?Q?a5KQ+CmXKgKcOkVQCk2ZPyvJAROIYWciIUkv0mhEpARD4GKJmh06zjrp4nSd?=
 =?us-ascii?Q?84cIbuSINF+apZqYIKoZqUupSavHFoejvy3jKCBcS7dqO5iwyBfi47m4mPO5?=
 =?us-ascii?Q?87t04RCdizTKfMyHJMXRHoPFMW9Czhv9VvhLLL7zlJFyHPh4DipSH35ClJ/K?=
 =?us-ascii?Q?M9+1VfHqM4olVC6iTtWJhRsAYbZKy9OwOfUUTOX6UXC5wBi1M1zZcLhKRbnf?=
 =?us-ascii?Q?3iAb8talfjxIZCTtTPMlQykxlyptH7RfXihbzgo1c9JXPLd7C7xwfib4aP/7?=
 =?us-ascii?Q?+d4EwYhxoOTbWo7z+ZitfTLdRWifMvr6WAhVI3vDzD4Ke38U2Z05zW2OfRTA?=
 =?us-ascii?Q?8nqQnVgYhde25fu36VWjVvGQrmd4SZsPtmvoT78hwy9e/VbLjnRTHTAAZHwK?=
 =?us-ascii?Q?uGkkYVjwhgGqlq53GvYXLFlhzGV5P35O2+9HewY4fRfy3zgKZqEg7vHZ2GUX?=
 =?us-ascii?Q?Vf7by0OeTT/evOXYNNJkWqiOa5UE2AHw4ykqZwc8WE1qMCOUWzq/KnXG+10Y?=
 =?us-ascii?Q?BA5Ii5xT1TS8Nn0UHtZB9G0v3fR8oRRd/Dpa7DHNShL61MDy4xRr0mIBujaN?=
 =?us-ascii?Q?NRNMueeu7foHJJZDB4E6iXglx74EBB/G1cEV89xuACY3MRsyRNdlV0RPJhKw?=
 =?us-ascii?Q?5YjQ2Uvx5XWR5K05hrJtkZg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f04702-caa8-4138-accc-08dd272cef6d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:50.7125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9h7binLbce3S2LQcBP+A5BdKUoZ55JQF5f2Gap+CsVFGmHksFwd4AQtRziRCDbFiZP6WMinKOuSEUxlaqVgwIX9SzVL2nhHFPzSZ/m/NyNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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
 * Avoid use net_server_ip in tcp code, use tcp_stream data instead
 * Ignore packets from other connections if connection already created.
   This prevents us from connection break caused by other tcp stream.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net-legacy.h |   5 +-
 include/net/tcp.h    |  57 ++++++++++++++++---
 net/fastboot_tcp.c   |  50 +++++++++--------
 net/net.c            |  12 ++--
 net/tcp.c            | 129 +++++++++++++++++++++++++++++++++----------
 net/wget.c           |  52 ++++++-----------
 6 files changed, 203 insertions(+), 102 deletions(-)

diff --git a/include/net-legacy.h b/include/net-legacy.h
index 1f62ebff51d..bc0f0cde9fe 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -416,6 +416,7 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 /**
  * net_send_tcp_packet() - Transmit TCP packet.
  * @payload_len: length of payload
+ * @dhost: Destination host
  * @dport: Destination TCP port
  * @sport: Source TCP port
  * @action: TCP action to be performed
@@ -424,8 +425,8 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
  *
  * Return: 0 on success, other value on failure
  */
-int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
-			u32 tcp_seq_num, u32 tcp_ack_num);
+int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
+			int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport,
 			int sport, int payload_len);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 14aee64cb1c..f224d0cae2f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -279,6 +279,9 @@ enum tcp_state {
 
 /**
  * struct tcp_stream - TCP data stream structure
+ * @rhost:		Remote host, network byte order
+ * @rport:		Remote port, host byte order
+ * @lport:		Local port, host byte order
  *
  * @state:		TCP connection state
  *
@@ -291,6 +294,10 @@ enum tcp_state {
  * @lost:		Used for SACK
  */
 struct tcp_stream {
+	struct in_addr	rhost;
+	u16		rport;
+	u16		lport;
+
 	/* TCP connection state */
 	enum tcp_state	state;
 
@@ -305,16 +312,53 @@ struct tcp_stream {
 	struct tcp_sack_v lost;
 };
 
-struct tcp_stream *tcp_stream_get(void);
+void tcp_init(void);
+
+typedef int tcp_incoming_filter(struct in_addr rhost,
+				u16 rport, u16 sport);
+
+/*
+ * This function sets user callback used to accept/drop incoming
+ * connections. Callback should:
+ *  + Check TCP stream endpoint and make connection verdict
+ *    - return non-zero value to accept connection
+ *    - return zero to drop connection
+ *
+ * WARNING: If callback is NOT defined, all incoming connections
+ *          will be dropped.
+ */
+void tcp_set_incoming_filter(tcp_incoming_filter *filter);
+
+/*
+ * tcp_stream_get -- Get or create TCP stream
+ * @is_new:	if non-zero and no stream found, then create a new one
+ * @rhost:	Remote host, network byte order
+ * @rport:	Remote port, host byte order
+ * @lport:	Local port, host byte order
+ *
+ * Returns: TCP stream structure or NULL (if not found/created)
+ */
+struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
+				  u16 rport, u16 lport);
+
+/*
+ * tcp_stream_connect -- Create new TCP stream for remote connection.
+ * @rhost:	Remote host, network byte order
+ * @rport:	Remote port, host byte order
+ *
+ * Returns: TCP new stream structure or NULL (if not created).
+ *          Random local port will be used.
+ */
+struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport);
+
+enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp);
 
-enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp);
-void tcp_set_tcp_state(struct tcp_stream *tcp, enum tcp_state new_state);
-int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
-		       int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
 
 /**
  * rxhand_tcp() - An incoming packet handler.
+ * @tcp: TCP stream
  * @pkt: pointer to the application packet
  * @dport: destination TCP port
  * @sip: source IP address
@@ -324,8 +368,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
  * @action: TCP action (SYN, ACK, FIN, etc)
  * @len: packet length
  */
-typedef void rxhand_tcp(uchar *pkt, u16 dport,
-			struct in_addr sip, u16 sport,
+typedef void rxhand_tcp(struct tcp_stream *tcp, uchar *pkt,
 			u32 tcp_seq_num, u32 tcp_ack_num,
 			u8 action, unsigned int len);
 void tcp_set_tcp_handler(rxhand_tcp *f);
diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index d1fccbc7238..4d34fdc5a45 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -8,14 +8,14 @@
 #include <net/fastboot_tcp.h>
 #include <net/tcp.h>
 
-static char command[FASTBOOT_COMMAND_LEN] = {0};
-static char response[FASTBOOT_RESPONSE_LEN] = {0};
+#define FASTBOOT_TCP_PORT	5554
+
+static char command[FASTBOOT_COMMAND_LEN];
+static char response[FASTBOOT_RESPONSE_LEN];
 
 static const unsigned short handshake_length = 4;
 static const uchar *handshake = "FB01";
 
-static u16 curr_sport;
-static u16 curr_dport;
 static u32 curr_tcp_seq_num;
 static u32 curr_tcp_ack_num;
 static unsigned int curr_request_len;
@@ -25,34 +25,37 @@ static enum fastboot_tcp_state {
 	FASTBOOT_DISCONNECTING
 } state = FASTBOOT_CLOSED;
 
-static void fastboot_tcp_answer(u8 action, unsigned int len)
+static void fastboot_tcp_answer(struct tcp_stream *tcp, u8 action,
+				unsigned int len)
 {
 	const u32 response_seq_num = curr_tcp_ack_num;
 	const u32 response_ack_num = curr_tcp_seq_num +
 		  (curr_request_len > 0 ? curr_request_len : 1);
 
-	net_send_tcp_packet(len, htons(curr_sport), htons(curr_dport),
+	net_send_tcp_packet(len, tcp->rhost, tcp->rport, tcp->lport,
 			    action, response_seq_num, response_ack_num);
 }
 
-static void fastboot_tcp_reset(void)
+static void fastboot_tcp_reset(struct tcp_stream *tcp)
 {
-	fastboot_tcp_answer(TCP_RST, 0);
+	fastboot_tcp_answer(tcp, TCP_RST, 0);
 	state = FASTBOOT_CLOSED;
 }
 
-static void fastboot_tcp_send_packet(u8 action, const uchar *data, unsigned int len)
+static void fastboot_tcp_send_packet(struct tcp_stream *tcp, u8 action,
+				     const uchar *data, unsigned int len)
 {
 	uchar *pkt = net_get_async_tx_pkt_buf();
 
 	memset(pkt, '\0', PKTSIZE);
 	pkt += net_eth_hdr_size() + IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
 	memcpy(pkt, data, len);
-	fastboot_tcp_answer(action, len);
+	fastboot_tcp_answer(tcp, action, len);
 	memset(pkt, '\0', PKTSIZE);
 }
 
-static void fastboot_tcp_send_message(const char *message, unsigned int len)
+static void fastboot_tcp_send_message(struct tcp_stream *tcp,
+				      const char *message, unsigned int len)
 {
 	__be64 len_be = __cpu_to_be64(len);
 	uchar *pkt = net_get_async_tx_pkt_buf();
@@ -63,12 +66,11 @@ static void fastboot_tcp_send_message(const char *message, unsigned int len)
 	memcpy(pkt, &len_be, 8);
 	pkt += 8;
 	memcpy(pkt, message, len);
-	fastboot_tcp_answer(TCP_ACK | TCP_PUSH, len + 8);
+	fastboot_tcp_answer(tcp, TCP_ACK | TCP_PUSH, len + 8);
 	memset(pkt, '\0', PKTSIZE);
 }
 
-static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
-				      struct in_addr sip, u16 sport,
+static void fastboot_tcp_handler_ipv4(struct tcp_stream *tcp, uchar *pkt,
 				      u32 tcp_seq_num, u32 tcp_ack_num,
 				      u8 action, unsigned int len)
 {
@@ -77,8 +79,6 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 	u8 tcp_fin = action & TCP_FIN;
 	u8 tcp_push = action & TCP_PUSH;
 
-	curr_sport = sport;
-	curr_dport = dport;
 	curr_tcp_seq_num = tcp_seq_num;
 	curr_tcp_ack_num = tcp_ack_num;
 	curr_request_len = len;
@@ -89,17 +89,17 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 			if (len != handshake_length ||
 			    strlen(pkt) != handshake_length ||
 			    memcmp(pkt, handshake, handshake_length) != 0) {
-				fastboot_tcp_reset();
+				fastboot_tcp_reset(tcp);
 				break;
 			}
-			fastboot_tcp_send_packet(TCP_ACK | TCP_PUSH,
+			fastboot_tcp_send_packet(tcp, TCP_ACK | TCP_PUSH,
 						 handshake, handshake_length);
 			state = FASTBOOT_CONNECTED;
 		}
 		break;
 	case FASTBOOT_CONNECTED:
 		if (tcp_fin) {
-			fastboot_tcp_answer(TCP_FIN | TCP_ACK, 0);
+			fastboot_tcp_answer(tcp, TCP_FIN | TCP_ACK, 0);
 			state = FASTBOOT_DISCONNECTING;
 			break;
 		}
@@ -111,12 +111,12 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 
 			// Only single packet messages are supported ATM
 			if (strlen(pkt) != command_size) {
-				fastboot_tcp_reset();
+				fastboot_tcp_reset(tcp);
 				break;
 			}
 			strlcpy(command, pkt, len + 1);
 			fastboot_command_id = fastboot_handle_command(command, response);
-			fastboot_tcp_send_message(response, strlen(response));
+			fastboot_tcp_send_message(tcp, response, strlen(response));
 			fastboot_handle_boot(fastboot_command_id,
 					     strncmp("OKAY", response, 4) == 0);
 		}
@@ -129,17 +129,21 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
 
 	memset(command, 0, FASTBOOT_COMMAND_LEN);
 	memset(response, 0, FASTBOOT_RESPONSE_LEN);
-	curr_sport = 0;
-	curr_dport = 0;
 	curr_tcp_seq_num = 0;
 	curr_tcp_ack_num = 0;
 	curr_request_len = 0;
 }
 
+static int incoming_filter(struct in_addr rhost, u16 rport, u16 lport)
+{
+	return (lport == FASTBOOT_TCP_PORT);
+}
+
 void fastboot_tcp_start_server(void)
 {
 	printf("Using %s device\n", eth_get_name());
 	printf("Listening for fastboot command on tcp %pI4\n", &net_ip);
 
+	tcp_set_incoming_filter(incoming_filter);
 	tcp_set_tcp_handler(fastboot_tcp_handler_ipv4);
 }
diff --git a/net/net.c b/net/net.c
index e12ac55c401..62d1c5b1e82 100644
--- a/net/net.c
+++ b/net/net.c
@@ -420,7 +420,7 @@ int net_init(void)
 		/* Only need to setup buffer pointers once. */
 		first_call = 0;
 		if (IS_ENABLED(CONFIG_PROT_TCP))
-			tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
+			tcp_init();
 	}
 
 	return net_init_loop();
@@ -908,10 +908,10 @@ int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 }
 
 #if defined(CONFIG_PROT_TCP)
-int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
-			u32 tcp_seq_num, u32 tcp_ack_num)
+int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
+			int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
-	return net_send_ip_packet(net_server_ethaddr, net_server_ip, dport,
+	return net_send_ip_packet(net_server_ethaddr, dhost, dport,
 				  sport, payload_len, IPPROTO_TCP, action,
 				  tcp_seq_num, tcp_ack_num);
 }
@@ -953,12 +953,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
 		break;
 #if defined(CONFIG_PROT_TCP)
 	case IPPROTO_TCP:
-		tcp = tcp_stream_get();
+		tcp = tcp_stream_get(0, dest, dport, sport);
 		if (!tcp)
 			return -EINVAL;
 
 		pkt_hdr_size = eth_hdr_size
-			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size, dport, sport,
+			+ tcp_set_tcp_header(tcp, pkt + eth_hdr_size,
 					     payload_len, action, tcp_seq_num,
 					     tcp_ack_num);
 		break;
diff --git a/net/tcp.c b/net/tcp.c
index 8eeb43b8796..db708f0a2a5 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -26,6 +26,7 @@
 
 static int tcp_activity_count;
 static struct tcp_stream tcp_stream;
+static tcp_incoming_filter *incoming_filter;
 
 /*
  * TCP lengths are stored as a rounded up number of 32 bit words.
@@ -40,40 +41,95 @@ static struct tcp_stream tcp_stream;
 /* Current TCP RX packet handler */
 static rxhand_tcp *tcp_packet_handler;
 
+#define RANDOM_PORT_START 1024
+#define RANDOM_PORT_RANGE 0x4000
+
+/**
+ * random_port() - make port a little random (1024-17407)
+ *
+ * Return: random port number from 1024 to 17407
+ *
+ * This keeps the math somewhat trivial to compute, and seems to work with
+ * all supported protocols/clients/servers
+ */
+static uint random_port(void)
+{
+	return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
+}
+
 static inline s32 tcp_seq_cmp(u32 a, u32 b)
 {
 	return (s32)(a - b);
 }
 
 /**
- * tcp_get_tcp_state() - get TCP stream state
+ * tcp_stream_get_state() - get TCP stream state
  * @tcp: tcp stream
  *
  * Return: TCP stream state
  */
-enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp)
+enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp)
 {
 	return tcp->state;
 }
 
 /**
- * tcp_set_tcp_state() - set TCP stream state
+ * tcp_stream_set_state() - set TCP stream state
  * @tcp: tcp stream
  * @new_state: new TCP state
  */
-void tcp_set_tcp_state(struct tcp_stream *tcp,
-		       enum tcp_state new_state)
+static void tcp_stream_set_state(struct tcp_stream *tcp,
+				 enum tcp_state new_state)
 {
 	tcp->state = new_state;
 }
 
-struct tcp_stream *tcp_stream_get(void)
+void tcp_init(void)
+{
+	incoming_filter = NULL;
+	tcp_stream.state = TCP_CLOSED;
+}
+
+void tcp_set_incoming_filter(tcp_incoming_filter *filter)
+{
+	incoming_filter = filter;
+}
+
+static struct tcp_stream *tcp_stream_add(struct in_addr rhost,
+					 u16 rport, u16 lport)
+{
+	struct tcp_stream *tcp = &tcp_stream;
+
+	if (tcp->state != TCP_CLOSED)
+		return NULL;
+
+	memset(tcp, 0, sizeof(struct tcp_stream));
+	tcp->rhost.s_addr = rhost.s_addr;
+	tcp->rport = rport;
+	tcp->lport = lport;
+	tcp->state = TCP_CLOSED;
+	tcp->lost.len = TCP_OPT_LEN_2;
+	return tcp;
+}
+
+struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
+				  u16 rport, u16 lport)
 {
-	return &tcp_stream;
+	struct tcp_stream *tcp = &tcp_stream;
+
+	if (tcp->rhost.s_addr == rhost.s_addr &&
+	    tcp->rport == rport &&
+	    tcp->lport == lport)
+		return tcp;
+
+	if (!is_new || !incoming_filter ||
+	    !incoming_filter(rhost, rport, lport))
+		return NULL;
+
+	return tcp_stream_add(rhost, rport, lport);
 }
 
-static void dummy_handler(uchar *pkt, u16 dport,
-			  struct in_addr sip, u16 sport,
+static void dummy_handler(struct tcp_stream *tcp, uchar *pkt,
 			  u32 tcp_seq_num, u32 tcp_ack_num,
 			  u8 action, unsigned int len)
 {
@@ -222,8 +278,7 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
 	b->ip.end = TCP_O_END;
 }
 
-int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
-		       int sport, int payload_len,
+int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
 		       u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
 {
 	union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
@@ -243,7 +298,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	case TCP_SYN:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num);
 		tcp_activity_count = 0;
 		net_set_syn_options(tcp, b);
@@ -264,13 +319,13 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 		b->ip.hdr.tcp_flags = action;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num,
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
 			   action);
 		break;
 	case TCP_FIN:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		payload_len = 0;
 		pkt_hdr_len = IP_TCP_HDR_SIZE;
 		tcp->state = TCP_FIN_WAIT_1;
@@ -279,7 +334,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	case TCP_RST:
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
-			   &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
+			   &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
 		tcp->state = TCP_CLOSED;
 		break;
 	/* Notify connection closing */
@@ -290,7 +345,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num, action);
 		fallthrough;
 	default:
@@ -298,7 +353,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 		b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
-			   &net_server_ip, &net_ip,
+			   &tcp->rhost, &net_ip,
 			   tcp_seq_num, tcp_ack_num, action);
 	}
 
@@ -308,8 +363,8 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	tcp->ack_edge = tcp_ack_num;
 	/* TCP Header */
 	b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
-	b->ip.hdr.tcp_src = htons(sport);
-	b->ip.hdr.tcp_dst = htons(dport);
+	b->ip.hdr.tcp_src = htons(tcp->lport);
+	b->ip.hdr.tcp_dst = htons(tcp->rport);
 	b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
 
 	/*
@@ -332,10 +387,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
 	b->ip.hdr.tcp_xsum = 0;
 	b->ip.hdr.tcp_ugr = 0;
 
-	b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, net_server_ip,
+	b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, tcp->rhost,
 						   tcp_len, pkt_len);
 
-	net_set_ip_header((uchar *)&b->ip, net_server_ip, net_ip,
+	net_set_ip_header((uchar *)&b->ip, tcp->rhost, net_ip,
 			  pkt_len, IPPROTO_TCP);
 
 	return pkt_hdr_len;
@@ -616,19 +671,26 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	u32 tcp_seq_num, tcp_ack_num;
 	int tcp_hdr_len, payload_len;
 	struct tcp_stream *tcp;
+	struct in_addr src;
 
 	/* Verify IP header */
 	debug_cond(DEBUG_DEV_PKT,
 		   "TCP RX in RX Sum (to=%pI4, from=%pI4, len=%d)\n",
 		   &b->ip.hdr.ip_src, &b->ip.hdr.ip_dst, pkt_len);
 
-	b->ip.hdr.ip_src = net_server_ip;
+	/*
+	 * src IP address will be destroyed by TCP checksum verification
+	 * algorithm (see tcp_set_pseudo_header()), so remember it before
+	 * it was garbaged.
+	 */
+	src.s_addr = b->ip.hdr.ip_src.s_addr;
+
 	b->ip.hdr.ip_dst = net_ip;
 	b->ip.hdr.ip_sum = 0;
 	if (tcp_rx_xsum != compute_ip_checksum(b, IP_HDR_SIZE)) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP RX IP xSum Error (%pI4, =%pI4, len=%d)\n",
-			   &net_ip, &net_server_ip, pkt_len);
+			   &net_ip, &src, pkt_len);
 		return;
 	}
 
@@ -640,11 +702,14 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 						 pkt_len)) {
 		debug_cond(DEBUG_DEV_PKT,
 			   "TCP RX TCP xSum Error (%pI4, %pI4, len=%d)\n",
-			   &net_ip, &net_server_ip, tcp_len);
+			   &net_ip, &src, tcp_len);
 		return;
 	}
 
-	tcp = tcp_stream_get();
+	tcp = tcp_stream_get(b->ip.hdr.tcp_flags & TCP_SYN,
+			     src,
+			     ntohs(b->ip.hdr.tcp_src),
+			     ntohs(b->ip.hdr.tcp_dst));
 	if (!tcp)
 		return;
 
@@ -676,9 +741,9 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 			   "TCP Notify (action=%x, Seq=%u,Ack=%u,Pay%d)\n",
 			   tcp_action, tcp_seq_num, tcp_ack_num, payload_len);
 
-		(*tcp_packet_handler) ((uchar *)b + pkt_len - payload_len, b->ip.hdr.tcp_dst,
-				       b->ip.hdr.ip_src, b->ip.hdr.tcp_src, tcp_seq_num,
-				       tcp_ack_num, tcp_action, payload_len);
+		(*tcp_packet_handler) (tcp, (uchar *)b + pkt_len - payload_len,
+				       tcp_seq_num, tcp_ack_num, tcp_action,
+				       payload_len);
 
 	} else if (tcp_action != TCP_DATA) {
 		debug_cond(DEBUG_DEV_PKT,
@@ -689,9 +754,13 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 		 * Warning: Incoming Ack & Seq sequence numbers are transposed
 		 * here to outgoing Seq & Ack sequence numbers
 		 */
-		net_send_tcp_packet(0, ntohs(b->ip.hdr.tcp_src),
-				    ntohs(b->ip.hdr.tcp_dst),
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
 				    (tcp_action & (~TCP_PUSH)),
 				    tcp_ack_num, tcp->ack_edge);
 	}
 }
+
+struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport)
+{
+	return tcp_stream_add(rhost, rport, random_port());
+}
diff --git a/net/wget.c b/net/wget.c
index 0213e3ff51d..a175533ada9 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -28,9 +28,8 @@ static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
 static const char http_eom[] = "\r\n\r\n";
 static const char content_len[] = "Content-Length";
 static const char linefeed[] = "\r\n";
-static struct in_addr web_server_ip;
-static int our_port;
 static int wget_timeout_count;
+struct tcp_stream *tcp;
 
 struct pkt_qd {
 	uchar *pkt;
@@ -110,22 +109,19 @@ static void wget_send_stored(void)
 	int len = retry_len;
 	unsigned int tcp_ack_num = retry_tcp_seq_num + (len == 0 ? 1 : len);
 	unsigned int tcp_seq_num = retry_tcp_ack_num;
-	unsigned int server_port;
 	uchar *ptr, *offset;
 
-	server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
-
 	switch (current_wget_state) {
 	case WGET_CLOSED:
 		debug_cond(DEBUG_WGET, "wget: send SYN\n");
 		current_wget_state = WGET_CONNECTING;
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 		packets = 0;
 		break;
 	case WGET_CONNECTING:
 		pkt_q_idx = 0;
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 
 		ptr = net_tx_packet + net_eth_hdr_size() +
@@ -149,14 +145,14 @@ static void wget_send_stored(void)
 
 		memcpy(offset, &bootfile3, strlen(bootfile3));
 		offset += strlen(bootfile3);
-		net_send_tcp_packet((offset - ptr), server_port, our_port,
+		net_send_tcp_packet((offset - ptr), tcp->rhost, tcp->rport, tcp->lport,
 				    TCP_PUSH, tcp_seq_num, tcp_ack_num);
 		current_wget_state = WGET_CONNECTED;
 		break;
 	case WGET_CONNECTED:
 	case WGET_TRANSFERRING:
 	case WGET_TRANSFERRED:
-		net_send_tcp_packet(0, server_port, our_port, action,
+		net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
 				    tcp_seq_num, tcp_ack_num);
 		break;
 	}
@@ -348,10 +344,8 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 
 /**
  * wget_handler() - TCP handler of wget
+ * @tcp: TCP stream
  * @pkt: pointer to the application packet
- * @dport: destination TCP port
- * @sip: source IP address
- * @sport: source TCP port
  * @tcp_seq_num: TCP sequential number
  * @tcp_ack_num: TCP acknowledgment number
  * @action: TCP action (SYN, ACK, FIN, etc)
@@ -360,13 +354,11 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
  * In the "application push" invocation, the TCP header with all
  * its information is pointed to by the packet pointer.
  */
-static void wget_handler(uchar *pkt, u16 dport,
-			 struct in_addr sip, u16 sport,
+static void wget_handler(struct tcp_stream *tcp, uchar *pkt,
 			 u32 tcp_seq_num, u32 tcp_ack_num,
 			 u8 action, unsigned int len)
 {
-	struct tcp_stream *tcp = tcp_stream_get();
-	enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
+	enum tcp_state wget_tcp_state = tcp_stream_get_state(tcp);
 
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	packets++;
@@ -457,26 +449,13 @@ static void wget_handler(uchar *pkt, u16 dport,
 	}
 }
 
-#define RANDOM_PORT_START 1024
-#define RANDOM_PORT_RANGE 0x4000
-
-/**
- * random_port() - make port a little random (1024-17407)
- *
- * Return: random port number from 1024 to 17407
- *
- * This keeps the math somewhat trivial to compute, and seems to work with
- * all supported protocols/clients/servers
- */
-static unsigned int random_port(void)
-{
-	return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
-}
-
 #define BLOCKSIZE 512
 
 void wget_start(void)
 {
+	struct in_addr web_server_ip;
+	unsigned int server_port;
+
 	if (!wget_info)
 		wget_info = &default_wget_info;
 
@@ -523,8 +502,6 @@ void wget_start(void)
 	wget_timeout_count = 0;
 	current_wget_state = WGET_CLOSED;
 
-	our_port = random_port();
-
 	/*
 	 * Zero out server ether to force arp resolution in case
 	 * the server ip for the previous u-boot command, for example dns
@@ -533,6 +510,13 @@ void wget_start(void)
 
 	memset(net_server_ethaddr, 0, 6);
 
+	server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
+	tcp = tcp_stream_connect(web_server_ip, server_port);
+	if (!tcp) {
+		net_set_state(NETLOOP_FAIL);
+		return;
+	}
+
 	wget_send(TCP_SYN, 0, 0, 0);
 }
 
-- 
2.45.2

