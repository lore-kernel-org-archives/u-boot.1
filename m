Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79683C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81F684AA4;
	Fri,  3 Jul 2026 13:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="IPLLuMb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2463F84A65; Fri,  3 Jul 2026 13:57:08 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E901A84A91
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OECq3fzIsXXk0GMkWRdOA4tGTatbKWPXKfxG/3pjD/oaCqJPpRJltWEt8mfIZyDGf6VHHteJXBn1OLQmnewCeC1gKGykElH8kly5CsWU0yPq98tdeLvIYaeHO1tR9d6u9vwT47EjQCQbBaUONbWHmnobFcu9fjr6MeZycthfy6tiP9q1FAypvZPpE7EhiBs5+31tEAm2mUWt+nGrpot/yBCzxzM5M8oXtXvG4esH8vnWgL2WpaqeTvJB9yOIFCnV41NuJ9wR6ir+HudVeUFI1wDq9T0JmpfncTYPU1Aki5NLtI04qrf6MfAgV7+OT/0FVlrcA+OWUENHuhQJdoJodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bthA1+7mrHzwfI8usOlWW60l/srMic6Rq1B71fI3Ujc=;
 b=DhOd0sDyyRLjCNs7p5fTKeGVAAQjbsVX0qnwuzIoT4kWChMhM/6EQIyI3fARbQl01zrisNUdtIOqxiuxs+PzRik4yZBuYDqPwzmOxLxTETOUaXWhA+RPAk2jpg7tnTaaW8RhOXDu3zgtIYPyXohLw2gTq2IuFukvaSKpC/j/TmyDvUP5p1CMiqUAacHkPzaFgBFOGCy3hql1Zhz90X3Pe7gNOTU/Qdf/5vlciudnTlmyB/fuzhkE4XfQPlR41YFmHaRVLCvLvR2tcdaHstZg+6SKGeRn/gm2DigMlPM7oLTGCc9uh+yT/DRk9miaf72QRoEFzBBRvS6DbdJFxnV0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bthA1+7mrHzwfI8usOlWW60l/srMic6Rq1B71fI3Ujc=;
 b=IPLLuMb5346GR4vLO9Rh1/DoOwgKK3QdbQOOfWgYQUiBEngXNVW6ie0QIt51j1Ylj4OxLLqUVSlp4wQHUui5nrpNSBU0uRCmTMpDXbW638QHPEf3PiloTIm631aVlW6ojpo7ScotCFvn0S8T4j0uqhZfb0W3Ow3cI8cZ0a18sHUAahTa2yp3olOqhmIxzLi46xgBva5Z8iGYQFh1KUaTJTg0hm1pQ74oWQgwDgFZ6ReE9x1mQt/Pd95NODFNvR5wCX0hNH18pmg4+nf73+dUNTnyASHr1UEpWdYpPBuXRnUj9jijupBBEHFuLe8SgxaueIYurELcOEfiQF+e1w2WIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:56:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:56:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 07/24] bitops: import BITS_PER_TYPE() macro from linux
Date: Fri,  3 Jul 2026 14:56:10 +0300
Message-ID: <20260703115627.2317120-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0e2e63-0d86-474c-6de8-08ded8fa2f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: SdXavP3S8IJ9zB1R0mefn+9rRAdNbASqSxLsNhKENQt1GW35ITImymRnA4ciHiBTjs8nArBAX4CtW2vgH4OFxgk7PUz061NQIUf4CVboaeVid5qnt2QhnzfogZmvxlKDnqyess1BTqubLI7h3FdUpe7+simwSRQUPSWqS7EJmYkgc5dvpr5lczh/YJoT/FkxKMo4MMozn8wxOQGEswFqms5WbxKm98lCNRtOy0452RWBajlCy8ztQ2BvW1D0JGGv7gKpkmU8fxIK+yhhxX8NejykK5ZUtX27W5/Gw+XpKBosrq65GRbzZDKYrIsIj7tHlhbU4xJ1PLeaxttdLzx5CpnIGj2xr0iLin5xvAyUgKFfJojIuhqVXjD96FZ6pwIwWJlKx40vYvwxCMiE03s1U8G3WDQVt7vJ6zjlwxg0t4ZyFvs0YyUSN5ZY8w4mLbK6qTJKFevZu7rsAzuqUCdU10ap5t9Fthqo4ZEjDHh6TzFd12LhPd1Z2d3kVlhlizm2fWaJaIE8KoK2ktHOvKcLDicb/HzLXh0NwC3FI4NXG3knhr/pp2p25jXXAMpYhfdf0ikhK9CcTDjaNB+H3QzFCh7wEp2KQ3tU2UJ80vSMfCgMJ9299imHkWujMcjtF2TCPsicfKtk384F9EPfiBpWnXmz0ijJYBmPxWo4oz2MlwhDZAdyqRBGX/udugSTDVwNC0PK/0tFCthdyMpVhubOc0iOHUhtX/p6HbpBIyMVJCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jVCnIq9F7EpvuNG24ku6gF2p7oyXgBTXBHdU0kZyHLpEX71tZkS4Pw8jFnko?=
 =?us-ascii?Q?eBht8h75Z0aTXaruLU+8rgqWRQMJTPnI7nQhumQUZ35n3R+rQRu0+bkmUDmj?=
 =?us-ascii?Q?z1eARcWeTDr+VXdlxP96Z5c2BH0Ta5r+nxkHxDlHoEYgqr9PpDMaR7IbP0hx?=
 =?us-ascii?Q?nG501PVi7s+XY9zBeft3ErD1uwvJ4xc+yohmw7gvZ2Tv4CCdRZo2WsuP13Q6?=
 =?us-ascii?Q?AaVBwj4I6uoVIHZBD5KN6LHKAw6Z6jHOPMDxE7uVVW9GwG3Vj2V8J0U81U5k?=
 =?us-ascii?Q?nGFji+Gxyuh3RkchDC8Fv2Q0J2ywpuMC4Hj1WVzBgnJAAWOBZAI6Dd30D3rU?=
 =?us-ascii?Q?RsOc+uWYQ8uTHAdardrAIDLDRYZWNfhvsNJFHkwC55Ue1wIj1L0EWrxLQAa5?=
 =?us-ascii?Q?4LF33CAPzEonJ4t2VLODBWPrphVzinC9AaVA1N7IfzSbslxrDaCjaGiUAJnU?=
 =?us-ascii?Q?EQrluUaVrrddrAsDwQmv8OgNxesMOx6K9Sp/bjLYIekbXjNGrQpcfQxq5Igj?=
 =?us-ascii?Q?wlXkmVWzxDpNCxqBjSw4BdTOFwHiD4sItanXipaxl1D4SjFwipcgy2y7RTeT?=
 =?us-ascii?Q?UZ/kAb7pH19Zjd1KX9JXKQDTThqy+mGa3Gssx8epCvrZvGUSaQ56jsIRLdpg?=
 =?us-ascii?Q?VnVnK0qQTTVgYm2bEsS0ss9qLu7bDMTWpzwzxqY0G5RBby72qI2k60N2IXb5?=
 =?us-ascii?Q?gVDawbFdKdQBOYSzTV3RKc97eAFeMxV2uiO85mAhY/elcHwzqsbv8gZhX4Lf?=
 =?us-ascii?Q?DdYsp2IBn5ez11nqrWg+YhvjmUj2S2Jsq4BYQYy8EYTftuz5lFgdSNapLO5M?=
 =?us-ascii?Q?3Q7UKSrC5v8+yvg7fa75KSESSzuWBZsgTBRcxVvfgTThHLO8jZXBId9mb4W3?=
 =?us-ascii?Q?gdzJuAc/NmTqwnLzTyxI5AHRsyTP9SRoQwnuvT5YEg8OmB/CwPpRSvNXVzk1?=
 =?us-ascii?Q?4lMDoLbSv6HqyJHi0BCiEF660bMdZz7VjzZcwtbiwt5SG0WbF3L80wHyccKI?=
 =?us-ascii?Q?CID6EhXHB/GBcAwju+aQaCkMY/n5e51biHxpNvMoLX7D7QzdqEbERxb/rqHY?=
 =?us-ascii?Q?2jWADPLcReOcpK0zNxZFtUJxCCxNTxRICF8w/LgGyvP03JlrXNmZ+urIyqA6?=
 =?us-ascii?Q?qppPjMsBnW3zYsZJY485KpO94gLqx0R0vAMGq+EOD5ug/CPO/ymf8j8Am/Ut?=
 =?us-ascii?Q?Ut4GSH+pE6Cc1kImiRAvaouajuRmqM0GDfph9kRCcjvjfeaY/So636lh/+SM?=
 =?us-ascii?Q?hYxmWqdvtmiMnNn6FDTuTGymwNyFkYpZWl29Njniwge931ctHrs/3u8sazfD?=
 =?us-ascii?Q?zlnF8QgAUEOXOiUHupegO+eRjR2BdIycsGWYtHVvtJyhLzfGnFqcBhpCy4Mx?=
 =?us-ascii?Q?oeCwpLJpMDhuBJS41Xq94Kl/L2DUy33MDeFknM3uieiKeo8ohxXh1oZg/sBc?=
 =?us-ascii?Q?rTLhiEnlrBK7xWBq4FUDnDRwi8xws6QXT9gv5Id92SeOcGuCCfpL+B+DcoxL?=
 =?us-ascii?Q?puiFEXUM6RW/kCgKqxpo6R3XjhtRJGYb7ATeY7lN3oJdFt7TzlVnwttszS6h?=
 =?us-ascii?Q?qUPCs+lCpVWMOQucHespjdT1vlHhD3GPk4vOApqq29YPqMaWMYKnsQ8tTwZ8?=
 =?us-ascii?Q?oXMgOApQM+9f/Milg581Eq8RXiR5v1w69jXWWe1M56WzNYWoS8zZjqCpLBsx?=
 =?us-ascii?Q?7uoDK4jlmPyvZAymYIbS3HX9LjpBfIKlmGrqcV69n2PE9QHDXnlc3Vdw/KDT?=
 =?us-ascii?Q?FGTfWk2y4d2C3SX23o/8np1JWV1ZsJI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0e2e63-0d86-474c-6de8-08ded8fa2f42
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:56:58.0976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XlLzP+CPnQyG3zYzhG/U9Jto2AGxO5yi3MrQRherQ1EYEmzNVhLsoiVM4JZ+gpuJvPpo1o/94SrM8vuKT0mb8xsMsQRx7lBWPmHk1hyxgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9448
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

