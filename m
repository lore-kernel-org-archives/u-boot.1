Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75B6E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B221E84209;
	Wed, 24 Dec 2025 09:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="a1yWeLJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B140E841D2; Wed, 24 Dec 2025 09:24:40 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B598B84207
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+oLiakHIkA0Oy6POnWnbvJ3nnSDMP5pEav1BbGbYq6DFsZJW60TR4jJ7ptC9kh4zBv6FnedZjXMJAFX13aOG5Ro61k9wBnFJ7pcFO0HMOG98dodVBf9tSEBbDS4hlNqQzNfUb3xTClv4CKRzc5xIBS8J0XntzY4b6rZtlgFNRLaBisKVn1edPZ7YN1gT255/Z0MqZUYqa4ohrfNiaSpo/eaM8A9EAUpVAxD9p0M22hnZtL5ry6VLItgsKOoPC3lDa2MYEeCYmWipucDeZ2Ga007i4Xf3nvEt/ktbMzWSJerGbrwbU3quqP7nXzF9gw+gT3TBwd68qdtyMNsfwYt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02y2+JJvi5drU0RwKWTr4pHDwHEX6kIA3GUOIFc4OCk=;
 b=uFvqJumQIsb4wDlHfoRqmLgHBLj3bFnszVJXdwNWOcyudryDMKofraSgfh6IxvrYPxEO2TFK41SHCjkyZT2iLbOAjMjdIF1rSFKkujDJelRLxwcWc4HV1JuD/9Wz5Y8vkJ1Cgnk7z2j4vyMzeuzuitCXZfKuLEkSXxA1qGOG1i/h16Uc3mYqzf+9drRbEaxTkx9nZVRwKHyQ4bXtXdS8QpnBjjLB+7CIIEgjgVhLgp1LGtadiyhRJzLaUG70eG/uifMrxojSgZFvl0pyFiZWNMT6cLUk3dksm+OnQmdyLBaawybaI0egsFmwRZ/ydOvojtPSFteBqslKzgC6PRc+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02y2+JJvi5drU0RwKWTr4pHDwHEX6kIA3GUOIFc4OCk=;
 b=a1yWeLJ6QYtUoGsj9TcHvQpP8Fu/i1tsn/0bNID8MugX8VnfEZ7P/eXrpeb73vFAAPPBJQVEBFsL566gEW4ALMlRa7be822CiRil00KSAvqvxkmlSYF/GZZ5XGVPKGFZPwCbyaKh5TGlsByCacRRQT09QnVSTL9gXmJnCfzzHIz+t13D2m5I3Ew51Fx9BsklOKEX17yLvF2BrAFbrO+q3J3w0aDdDcZrYsiIx127rI7XUFvr7tkvp4/t+QdCL3fA1MirH/WCvEowU5/qRg43Xmh+j18mibKq+vzy5lxFbjtHmBftgSCD97kSjCJrgg49oFFhL4cmHBGbpdgPxnZ4nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 05/19] net: airoha: do not call airoha_fe_init() from
 GDM port independent code
Date: Wed, 24 Dec 2025 11:23:55 +0300
Message-ID: <20251224082409.1347373-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: e76b0c84-84c2-4dde-2768-08de42c5df1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uEi7dPHK/VOLy5NJ3EWCas/CVsHVxv9LyrnqtrI0bGjmSOG6CNy11lvsZ7/r?=
 =?us-ascii?Q?V3wohLoYug2A9nfRxmUi5U4WMmiIoqfSLJkrN21nllBHVhcI1fZS7WQ8PUrE?=
 =?us-ascii?Q?i3Vt2M5XaT7BBTLm2dPnGMx1wL/2rZZhXxdQt3VtTmKfciVPkiV0bBazCccF?=
 =?us-ascii?Q?xD5zrmO2dv1qCqoNE/a6OA7P5kRLIVhBZuXqjr7PdA8xLbcWO+RZnL5cujtv?=
 =?us-ascii?Q?SeDlQD56sG90np3M+BS3fjm5dfqwCKNGxt7nPFjjSq4yxQOPb15bVY1aw/lw?=
 =?us-ascii?Q?Z2LwxfQ+nF7Nxt/8KvpXcm5nFdGVRxxur4Xrs7qCmF9BhBaQL1Qq6mCNlnij?=
 =?us-ascii?Q?sxP5SBe1TapVP81KSxY5GXFs8jw82OoF/qyAgtnc82/gew80KLnpHfWI3ldD?=
 =?us-ascii?Q?/eB0xZ3UrZLKDke0U9/oDNO+7CJxkWw1+96XXGjTJuyAyuuhs5ZlJ1kkliN0?=
 =?us-ascii?Q?l88WIUCv4uba6J5pr0u/gtiXBOxRxi5RBp3Cziu501TarU3glBu1gyMgJctP?=
 =?us-ascii?Q?gFC1Rk2aVkWQzSz2tgZuG25BUwBJ6L5bWcnv77DBIR5gKLy675GZtJnFvKHt?=
 =?us-ascii?Q?XhHSh3ZIZzp5hCjykgpQR9aUyMEzR5tyAhqKjDqdFWIYGxDcpIMIpvHIRbsx?=
 =?us-ascii?Q?/eiBLz9XufDrOednvIKvj0FawtQHNejrwzsme3CLf4P9zJ/kv6C2wKb8U5w/?=
 =?us-ascii?Q?H2ZoarHhP0ibu6oDWvEZd92fK7AVZpvTGsJXD/j2Ic34l654dw4hx5KrkVJr?=
 =?us-ascii?Q?sd8RlpO4FNOtAFhEAgka6C09G9jDW0KHjktzezuXrFsdkUdxjhc34KoVhptR?=
 =?us-ascii?Q?Z4kibiSrTZzyBki7jBy8az9woL4tzskJtHkqABYZ9vzn2/YBHiyUwszrpvsF?=
 =?us-ascii?Q?UMzlCCXFeNubT7rrlIoBm2o0TOsmGZMxjGK0MxTJp4xM2mQ+Jf+GRHIun4eJ?=
 =?us-ascii?Q?r2yQCxx6kD1+GWWkjzbP8oPiXak3VcMiVhGns3klid1decFUiHVIuVfmiYJQ?=
 =?us-ascii?Q?VQfwDwFI1Igu8s3Jr/Ux13waLJjscxU7DrQNzf67IV0OcBtIyJZx6WqOLum9?=
 =?us-ascii?Q?JyhFQe0cjF1X2SLPM9dGcf7a6XjwZFFTYqi5vVx7oafxTV9xjdA46EIYrZP9?=
 =?us-ascii?Q?EzSWy7h0ez7/vOx6qzcDhy0vjhMyDoiU+w6wcaVlqaWLb82tDXsM+Cgz2GmM?=
 =?us-ascii?Q?wCmBR8Yizxq2GrSq1nZ9UJhcbxY8O1BbIVEFDA22t2wg843K8t0SfdbYNQ3u?=
 =?us-ascii?Q?su19a7dIGtkJ86jP00qFxTmzANFF4Hg/RAIrLsXQeiJDCgq7WONTheEQli10?=
 =?us-ascii?Q?+5BWqpV59OjgbVXaW33I37mDxpRJ6VO0lIdK5KeB9EW+aCxA0tLkOg6c7jhJ?=
 =?us-ascii?Q?Pe4vbPOD9j/Gc/1DG8C6UHEPhbTKfYfLBQp9xVKEplw+Q9MiEnpLMgQ/GgxT?=
 =?us-ascii?Q?QGyxnCTR8QgRQMpOeD76KRrkJrWO34cJgDCudRGVvLj0DcwkjiZ8MPAWwPCZ?=
 =?us-ascii?Q?PvGIF2bz31TXDRY3OJcXk23jl1NgTVC2zncgv6HWDCAPR0byGqTQX1Uybw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fad0WTR1GuAeC31AdfsYSaCVBlLlGHuT0t2wigvl0Ld01BMTWP14JkC5FxgZ?=
 =?us-ascii?Q?ER1BNbmRxVy482w2nuTI6PIVjllyPVPKOClCIosDSgH4k/F93jBoeq+AUqpa?=
 =?us-ascii?Q?NMIgOdhsGzx6jSSV5vUlRGiemtNozCGOT3yYihxO2Ko6if2SjQOlLUoxTqyC?=
 =?us-ascii?Q?faFTV7FyLxvXylumTxW4VGifvw7J9N94PKNiY7Ky5oB35hga+9W0Yy8G2+DU?=
 =?us-ascii?Q?U1vOiuKemtBIQd5tC3DJiDC9do4/WvBbLtjP+bDG4617lf/uIeJw3eDFEYZC?=
 =?us-ascii?Q?fZEaWYPPXIM/T4OuKEH6IzoALXYVLUCiF6pTF5F2MygC6p2gqGm1YPf+OecW?=
 =?us-ascii?Q?R2nFluWD7OEibjtopuFQ6d0rpwAKbznu4DRdqZYs4Eo5SY4NdT0arXuem3Gm?=
 =?us-ascii?Q?GYTpNp81iTOV/MSaKCM4M8wkwGwClmOjQOGh1gS2UfogHD3Ll7v056wWA1R8?=
 =?us-ascii?Q?C9E6Sv4Gswb8XYqPCMggvJGCIe4kjBfckQSVswT2t2J2Hvw9jNeSXPoXB2Ad?=
 =?us-ascii?Q?y5DL5kANKKaKIevNnCZGlMSlb0VgcOuq7J8rx/yBtI1/qEdxw9KdYAoEy+32?=
 =?us-ascii?Q?f5vCT3DtnxXVi8QjZr9xMgoo+g74/4R0rS4SUp+jWrgBfE1tPxuos3+L/KNw?=
 =?us-ascii?Q?I2NC369G73e/IJYvKHJSdPJh3uqRFkNk6RqoxEwiePKwA1hKJZFTmiLmeEU0?=
 =?us-ascii?Q?RhXVbLSQyDkhSv9KjxWqLRL1S8BvrMsFyJbh5g66N4oKqywTKTRmoQLtPAa7?=
 =?us-ascii?Q?de0Ps87kCyTDw1h8vipcpdvUt/3p/LAgyNt+ifG+AErZZBoDiQg7DGNSzz4e?=
 =?us-ascii?Q?jhTp399Sst8gGn13jYLs6LI2DB3owE7am0qS5xlrP7l6zybKQyeXRaBRynBM?=
 =?us-ascii?Q?LvWanjJ1caL01nqqrUj5PRiX0AG6vDwMy2b6E8OTUE7Se1HkGIqzAgmqVxqm?=
 =?us-ascii?Q?FtbtoV5vx1uV+HLMWoSkLlpY/BtEURzTm4XDbfdD/ruL+JJOMdu84/0cyy69?=
 =?us-ascii?Q?t4SO9wviitBsqkrjTpvFEgMmrq2AsMn/mwhZdRfwVnO+BQt9GhSZO7KPpwgD?=
 =?us-ascii?Q?Aj3opPOoirVswnkop9IerIcPP+Okp48Lmp4yups8LMnIyBMPfnAu2mnz0ex6?=
 =?us-ascii?Q?sxvCEJUF9Y2+bvSjD3qlvJwYqdvcXfa6pov3e6WflR5Dc3U1bFHSim8dAKRg?=
 =?us-ascii?Q?wUc6ePoXlSJU5vxI8VUVduF5OiaT9D7OnJmV2CGceEdZOsgzRIsXrj//wV+D?=
 =?us-ascii?Q?KnOLYnaFo3hc91sKCQZzsCMwsDiYety2nfJbE9rxLzrH/iLxhLx6gzXrom/f?=
 =?us-ascii?Q?LMN7REF3af2ZFiEdHrJ8eblAEoAJSO4PAvTbCD71pVOPvgYUQs9u9iTfAYgE?=
 =?us-ascii?Q?Bk6QEm8lXV675SnpA7k3/rp7hVAATEwB1kKu4q+62xRzS1Gi6qNtAd5CVCgS?=
 =?us-ascii?Q?N/EZTZe0Y2XtljF3TMQC8tUkDR7d55oSMKe3AkXXh1LBJUwAfr3/vTyb8K8L?=
 =?us-ascii?Q?ZDEIErW8+kyIv6SYG6r4nF6wCjaFA8e9OScuM2bHXXbi01Fg4yFbzDukYyhS?=
 =?us-ascii?Q?VFeXcJ+vH+gbAO3eobXR+3LnDtV0X5OH7eM5HtrWQtOiQeLQcgay+CXYDKWY?=
 =?us-ascii?Q?rQBbRagn2X9HT5wsHmtZuT1HJHroHCk7umxUYCNCO+d+PztkV981v2egmNaa?=
 =?us-ascii?Q?jbJtoBNzViQ4CffGXqVIOq4clH2EK+cWOr5x4GrEkIaTHIgefOJpk0TDv04b?=
 =?us-ascii?Q?2/EHx3zYz0MPdlX/uo0YstJ+ToYtf8o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e76b0c84-84c2-4dde-2768-08de42c5df1c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:35.4582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFxRA0HT0PwHhfO1stK7+WH0XsKZBm4KpAwXk/81sV6uYelosDayZjOjlDwpaHSghy+qoaqicsdqXQ6fRTrcpCwDAQ6oRfwG9mjeGx9RfJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6721
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

We should not call airoha_fe_init() from GDM port independent code,
because it do a GDM specific things.

Makes airoha_fe_maccr_init() and airoha_fe_init() port dependent
and call them from airoha_eth_port_probe()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index ed8ee9da4c9..b1256866046 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -431,22 +431,18 @@ static int airoha_get_fe_port(struct airoha_gdm_port *port)
 	}
 }
 
-static void airoha_fe_maccr_init(struct airoha_eth *eth)
+static void airoha_fe_maccr_init(struct airoha_gdm_port *port)
 {
-	int p;
-
-	for (p = 1; p <= AIROHA_MAX_NUM_GDM_PORTS; p++) {
-		/*
-		 * Disable any kind of CRC drop or offload.
-		 * Enable padding of short TX packets to 60 bytes.
-		 */
-		airoha_fe_wr(eth, REG_GDM_FWD_CFG(p), GDM_PAD_EN);
-	}
+	/*
+	 * Disable any kind of CRC drop or offload.
+	 * Enable padding of short TX packets to 60 bytes.
+	 */
+	airoha_fe_wr(port->qdma->eth, REG_GDM_FWD_CFG(port->id), GDM_PAD_EN);
 }
 
-static int airoha_fe_init(struct airoha_eth *eth)
+static int airoha_fe_init(struct airoha_gdm_port *port)
 {
-	airoha_fe_maccr_init(eth);
+	airoha_fe_maccr_init(port);
 
 	return 0;
 }
@@ -718,10 +714,6 @@ static int airoha_hw_init(struct udevice *dev,
 
 	mdelay(20);
 
-	ret = airoha_fe_init(eth);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		ret = airoha_qdma_init(dev, eth, &eth->qdma[i]);
 		if (ret)
@@ -898,6 +890,10 @@ static int airoha_eth_port_probe(struct udevice *dev)
 
 	port->qdma = &eth->qdma[0];
 
+	ret = airoha_fe_init(port);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.51.0

