Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18D8C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2811A88A05;
	Wed, 31 Jul 2024 15:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qfokwqFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5530B88A25; Wed, 31 Jul 2024 15:22:49 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E87889C8
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKAd1RNW3x0hKqgUzXIiMsI0zhL4F/FBZMgIYqQDKnDgsS/iSMD2wDg4DKoizOZY7cIlsyxvXm8HxYThHGphZhpS2CtGgA17W36BAzZ7FI6Ho5tn/SUnjFWzUR69Av0UmD6es24K57mU0GktdivlNtDIasRDwR/QO9dJZXtXc0NNz/vJCm1r9QuOwyo7b/pe9exzmoCiW67LiOzQfNRNHYgvNlDMJ6JBp2ceg6gfncegXIRF/F1Q2XbOxmKYVX2yC0w/n81DXs0TahQX1msoQj7pm3AZgV4y3LETxPy+5EzsALk3dKT1tefLRAg5Re1bXKF1dxeGCUApWmlju6akLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8EWoBuaXsCXCx2dPN3hPpI74M/UF0eH31d4bQDWaN8=;
 b=IjVHhRMXtE2KGjMabbmGdZPtu9pXAOlOx32/1qE+inifpi390JIgmfybPivHmFh7+H2A+yOyllg4wMWWi7PcJhTOLvEkf+pU+XPHqRF4WLoYP3DxAGoFqopzUF04EjBr0Uxx54xrPOTEuTFifS2tbjtXA0lUD++n42WluvJ40TCB8V9ZVj9nGGW+Zd5oQDucFzBfGFI2UWMb3hh7obyB6H9+8rEihKfiiYysLYXjo7WfF6wBTbQ0GnmvdY9opmo4z5tM7tMj4REpqSVGeTczPZcamdgXGzfBix0LtwHlBig7bwc3xMyZmATV3QZxrHS6HiiMM3DlTQo0/Z4rosFIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8EWoBuaXsCXCx2dPN3hPpI74M/UF0eH31d4bQDWaN8=;
 b=qfokwqFb8fiTrBXW0/1WuTrwCvVZ8ulTVRfBxM4E18jyRQfb/kJaZ1JH1KFzeazzskVILBpfKUxPTOEwH7oZeePF1PQff9EZEZ3FDwJ0MjktGTfioSMJR6OuxMZjmz+zwKgCnD3IQ8IC5IfWe1Sq4ShLtTV8/oh/yik0uv+wcwmFrLhg2G+Ac70DYwTCGFfk1NjlQcuzEjdNtpJn+50aiH85HKadXbXPTLAbWvooeGwslhL4JbAHm2O6ZWNLBXZ+OsSrvQmGkwphhw7jDgRBPLjyVRRy8dH2LNVS2G+9TvsVUco3xbvEdqAY8T+x0QQ0DPpi5PIYkZmelYuUOXlEvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10941.eurprd08.prod.outlook.com (2603:10a6:800:250::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 13:22:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 13:22:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] cmd: led: fix led command usage for the LED_SW_BLINK enabled
 case
Date: Wed, 31 Jul 2024 17:22:33 +0400
Message-Id: <20240731132233.45744-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10941:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe15b7f-eef5-4d83-d442-08dcb163dbee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pxGELnj/aFSy5omkrLwswBBCNAZa6kgKadjuuCvA7dRA1VVAVYQkFRW93sqi?=
 =?us-ascii?Q?Yjwi6dac5RQ6fyjuZ27Y3AO1Gbm3yVQWvC8m389PcQwKH0iS+GYQmojMI/TY?=
 =?us-ascii?Q?qPjJI61U3uCDTBuVA1XHTUv3NBC2fDuxceIdxXqHEmpgLcNMy/xtYhnSCNrq?=
 =?us-ascii?Q?XmZJMK1Gnr7N+tkfu/9ANzhFWuxAnBjgjJBM2e9dwsUejj0mnhBmtTduCuww?=
 =?us-ascii?Q?d+yJZlp9pfWYqkTIIgllaHpOcALeFfVmZlt24/86hYNoyjo0ibP/0w7jJQdx?=
 =?us-ascii?Q?4OpvOg1LbKPaUhlreYijxHO7+KNi7oQfeapiPU2p7Jo2qMoBHAKd6JFFQ04M?=
 =?us-ascii?Q?o7uTDiLl+pdC23NjMf0Ryeiqybq0XBDJxsTj8UByDvFE/TqENOSj2lepFqGA?=
 =?us-ascii?Q?hUS6RzIXXCd8Xw/Y+JGqJFcCIcBV9Lf9nJIkNIpVUyNqSQUvGBabvYMG3+bY?=
 =?us-ascii?Q?zOOc64GBc9A72DS/NB/o/KXMDvTfVFule9BLKcBoLvClCjDdA6DlaLAsalPL?=
 =?us-ascii?Q?UmiyIiZhzCsFaYTBZNB/69MDenqM/MG5UqPGbSgQoCsVxGvwz8hHujnoD3Zz?=
 =?us-ascii?Q?XAyXlCbPh4Z2yKVIZ5qTzCe8+f/m/Y4/nsgQLu4iqaUPE1llrdEnv947d/cv?=
 =?us-ascii?Q?3BTSZcTunlDmWzJtrd890P4FHl3MJpiILm/oQxtzpDOWZL5TyjWTIfEggmST?=
 =?us-ascii?Q?SZDzZtv2pql6lzNQ23yj6p9flhKddmosvgzYg+dRTxIZaAx0KCy9wVvzfe1X?=
 =?us-ascii?Q?k7wZ4QCbLt4qd7M7B1P4Du3pdDv21frZFY9t5VwUo7wwk6wviwQio3j6/eZF?=
 =?us-ascii?Q?oTMLK0wrqqORy98yLdSF7pUuRhbGobW6QKgs3vUgx5CpX2DOro7mN/S+qcmq?=
 =?us-ascii?Q?oycxE77c6691186WBQ3uIVw5kZ9bViQ28DKMid2NccEksSeV9btiikW47y+9?=
 =?us-ascii?Q?lAZNtJS83YZsMMtYG77gACEcU0I4Hu/iTkSm9fuDV4cKYaiYq+J19Ug8jdHo?=
 =?us-ascii?Q?ICgnM9SFQct1xI3aTdO+AMlLfLKCHhHrDtmFY4gxltMstD7T6ppvE0sP1teX?=
 =?us-ascii?Q?geTMA8lNOu+BPld17e7EKgvwUQ+xiyaPDmx3KBPTPqvFz0KTYLxSiyupEmPL?=
 =?us-ascii?Q?xqxHJ+8EQA/vTA0fyE3vifjQOZTuO5JwC7pel/yXzfYmxzuRfBWEUdIAidWf?=
 =?us-ascii?Q?3C5k5MVI+8JMSXBR0dtzHWmx/P6GE4tKnk1Xf+wnjwEP+w4rNROqoW/uekib?=
 =?us-ascii?Q?rHEX8QY8XpFZQPPxRGqWe8vpibkEOL35qTRGudA+VCliSJbH2BdQuApO9a8S?=
 =?us-ascii?Q?+QJw0Fsa9jU/LxI6VxE5226HOEh4ytDLqfI8ihV3f/dzoQQqroHZsJyugs+o?=
 =?us-ascii?Q?4RhhyykNNFrMqNbZe/Rm/Xb1PJSrq/nOUChJvrWcAtpniN72kA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qPyhLSEE4DVmHHbupTDIUCqyhSHNQNhWrkZhoI/QuPoreL/BIGXDxwZ/gWqz?=
 =?us-ascii?Q?AqSk/H+xGTqoYfhQMm858gVVsHwnwVccxfZSseNehpT12sKnIw8TOy3/a1xV?=
 =?us-ascii?Q?y7doDmKC08UOZ1tm572UXkafL/tJgAxlUhi5dQ7Krt+Zt5cFTZnBgYYLTIm/?=
 =?us-ascii?Q?Ea0A0VWaRNjIO8i54CHtN3v14AlqbNdDXGQsHhw9wMm5vXVEFojbOqsmpaZa?=
 =?us-ascii?Q?HcAvHTZTbNSE/U6/5lpI+/WvyQ7b9OGlerdLIADe8uMKSeytPtdtpkvg/1RQ?=
 =?us-ascii?Q?WQTDMlPedaMAYMqT0lM8FdCQCEkbwltkM8raRvoTUF7zTArDhWb/IvxL0rAa?=
 =?us-ascii?Q?K00+dJLXG2kgiNphbqAOEuDstjUKIZlaUG+6omrwmnrm2y3Tzcp73Gdm/RLP?=
 =?us-ascii?Q?nIx5BfYhbknWGEEl5ZdtTRDBS0ZSwQZdwsuo2/pBIa55NH7Z7aN5CQd0F93S?=
 =?us-ascii?Q?SoZLcgMzVYgM093aqmF9YasySUUoYhKjnarJoIWlCcZrur2QFNPC1ByhGYWQ?=
 =?us-ascii?Q?hVaR/6xIT/NqBTJOROKtuXCJBFIYDP7lbf3y0CIT1Aj7grQb7ymjkt27nPyi?=
 =?us-ascii?Q?L0+wewMmy56mKocW6cJe8ipP/kAEiQrkPyOVvWJG2zjnNi6hB1XqqI2lWDkx?=
 =?us-ascii?Q?CBFD/kGEEuGzvCHv9gBhag5ZXowJL6N+5tYqUm94pnnHA2E2i0awY6sPg7GS?=
 =?us-ascii?Q?Ec/X99MxGfP4bZ2HENt0WYQ6lMaMUyM55v3T/YcXuyhwePXAJyjxoIaZJa1Y?=
 =?us-ascii?Q?mmy1ahkaHn2L68et29SM8QhIAUDkISWlyOJytK9fz83uzYS/7HClNHa0WSRb?=
 =?us-ascii?Q?9aed2VsMJfGojvuMpacsbdR1AKbqgDOaqer9Nd2fjmmcr6WvavYcnNepEzI4?=
 =?us-ascii?Q?ibahbA8CCMUJNPcX9p/NdsPCOxA0zVNUFbmVsbSDiU/O2UdoJxgUy3lI/q9A?=
 =?us-ascii?Q?DpkaXkN9HJT1Opgwtfn8Dec82jAW+U68o694GaVjYXp1nQ/IHCbsdWSgRFxW?=
 =?us-ascii?Q?0Qfrlh68fwqQaEauTIwBJ53QZGkXNEYVCBMClzHBXk/A1Ss6s21pbB2Z7BZ7?=
 =?us-ascii?Q?jWm5Svv7RAUsurVPP0NQddbPNLF+1nGHkvWJhDg0uTUS3CmjqINug4CrfTzk?=
 =?us-ascii?Q?Eja+pRxrUyXhA/WyOvrEI5tvMYNv2ksbB2qcFu/+NgsB8v5bgoHTawa6IMD9?=
 =?us-ascii?Q?xF2/aNpScdIsLKu7ViRijnTDlzvoG5b56LnxvW5Li+bLwJipMpVC7XEReV1x?=
 =?us-ascii?Q?0GptZH4ZnBF4Uj0A8N9uRRSZHg/KNYx5t7HACyit+MMmWK5/W+qCOd20t0Vn?=
 =?us-ascii?Q?WMQKQKder1cGxIF18bXshWe/2vHlugvDRatMCtNrIEIX3HRv41Wkj0cHWGri?=
 =?us-ascii?Q?wZ8qs163oDL6RGIYmOPhynwjOuQojFX74CGemRBEElKIjLWXk6xh+msFi/Lr?=
 =?us-ascii?Q?kRi0l/Tj+H8R8lBhFraGERWHVqNLnpscnO8At+/BRQPdE7lTM4GyiSCA3tVG?=
 =?us-ascii?Q?gTE0dpqP//WJ06vK9hJ+QNA7oBjRMZ+y2e3ykOvSUnh8EE68UlBUqenVPlEM?=
 =?us-ascii?Q?jtLL4v5oKImoCefDILhwkJYn8zRIhGh46RK04rciYQGKd6T8Xb9+xk5uN19m?=
 =?us-ascii?Q?aqhabzgZ4J6VVVZBNFXV1YY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe15b7f-eef5-4d83-d442-08dcb163dbee
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:22:43.2704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STOeHygS+bo3q9KWq5LCIitGyPQG/HpY641rE+ORk0JQdnaNfKPlZ/33bYKhmy4pGqPB7MhoD76YQ3vnHvPqhLK7B1E+60v650uKP32nHZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10941
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/led.c b/cmd/led.c
index 2f786f34c67..91fb856ee59 100644
--- a/cmd/led.c
+++ b/cmd/led.c
@@ -118,7 +118,7 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return 0;
 }
 
-#ifdef CONFIG_LED_BLINK
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
 #define BLINK "|blink [blink-freq in ms]"
 #else
 #define BLINK ""
-- 
2.39.2

