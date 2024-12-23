Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80B7E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 10:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 619CA806FB;
	Mon, 23 Dec 2024 11:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="e+A5vwr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2B2806E8; Mon, 23 Dec 2024 11:59:10 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB116806DB
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/sSyz6SX6Ob4/gKSsueLqnkHQySyVKxAhdEh1hTEDW22AfE3y7RFy26mRX32QRUC27hVjjz1aQ0GgFHxQExsl6lcXATPMIldYPkZ+obNGaC+yTGjHzUWR7COyoXaD3Kx7TJuFmI8mCjeVl38VK2SsQ9nuC+/ikajK1hL+2tHhNPTKk6k6vmhFvF41yCMgqfgh6+qWun2La2gbziMNeZ9ht6NaYtP4OTesPRUHHSYI2DbqMrdVtokVnoDNfg3vJTUz7YGezj2XIq/jJjrFJmzThm2ovRwqhXPejJSP1ANkCPsh1YPH7k0p5PNeqY5D3CVdSG7COWgJTETBdo8lQgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=EXEugZPZ99b7Ejv8R8Ls1V7ov7VvlVlPDOsMwy/+s3tJH1HMEtacenTmZH8GRFYBI2jc2XlLnyHAkxTId5P4iUxIaGx+TRVWNBAOCEc/espGzfnWceYbblPEaOisgUt1qY4OyAzbSNyPzitzFYG1lRZ0aN56CdyDmHFl6e9RnzE//PvA8YIx4GeMsZmjpvInwoEIBbcH7yTTIdPVoEbVMs/cE/B4MfTDruYu31bdAz0leVB60JJauqVC6LOFdmcXwW3JLOsmmm92xHDUoGKYDud43+80cJBBiNfv9eIuWLJwMFo+6Jwa3Q4rvsDG7pKdJxet0P/JJhCJp3wkNwsqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=e+A5vwr+ZO5N8251Ih/Q1S2R93ih5yPbxIyT/d7c73Dwm1z9zZRSJzDqzV4nmTlN5EtJNXwNmebyKZqQNVG3nooUc3Yd5VvQfiyKSkcXAHyVYITcP2hUsi5DR8RRdcUXbbuZB9esBL8PNNbhDqkIgDlgiMxMnc8v/x9KjOpMsuTXl61Wm5ByyWR/Frt2DcYsupKx/3HywTwOPxjInwQG003qAq0os1OVadhf+yyrcPOD8hR/q2jqfIsulBbIq0neGNydTlCzFQAL1CEchSdk/b/tQVDpV525WZTeCsV3yr205OpXvfxwvWiP9j5ePk/UPZjK0xPMQvyX/NqMIJyWHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:02 +0000
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
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 01/11] net/tcp: fix TCP options processing
Date: Mon, 23 Dec 2024 13:58:42 +0300
Message-ID: <20241223105852.1074404-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee62748-cfa7-4e3c-9e5d-08dd2340cf66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iUMKjJ78APs1to94t8WLYiLKmAXiUhOa0NWnlHhXOneilyMq7X1LdtciTweD?=
 =?us-ascii?Q?gOravasZFF4DGZyp/Uizy1abDXuE3E32pPbV3YKDs0yv9FE95jWu6G9XNQNp?=
 =?us-ascii?Q?td6NAgJjp2A3U1bU6DKQq8cwDUr/Jpgc9ONA0qzaJf6S22Bwkexm8uOtZ1lD?=
 =?us-ascii?Q?M1MN7Wh4/rjBneaMhJPW99H+9gr4slv7nauMhRJyXNfK/Zy697M0xJHKNlwm?=
 =?us-ascii?Q?MnbQWxLsw8KkksMfooEkRs/7qMlykCdniQ6RE1rmxDOt1A4duCHX87dlxDOU?=
 =?us-ascii?Q?VIjktJDM7G+z8PDsL2hUHMY08LNaokQpLgDHB1ALZkTejOqZ04udaEID3Qme?=
 =?us-ascii?Q?iCDfkIl5ZqfNm4owefA4zsKlWcugtNBm41+oUl9fO/GZg+xzS75vZUDhNQjY?=
 =?us-ascii?Q?LGAJP8c7KCMFrJIbbhq+CB4eMxIRYa9Q/A7BjL4Zy6f1DUjkp9oJhxoipCVR?=
 =?us-ascii?Q?OuyvpmSqP7bXS8acuT1BAdTfcJNJwOcgosMnQ0yA1MOqxM96gbScg7OgCJGV?=
 =?us-ascii?Q?U7OXIfAy3oiytAbv31dB2SCZEfYHeo3NRLfYBPOmdG4TB8td0nMs3CvVm7tM?=
 =?us-ascii?Q?a3vlxDnweKmcNuc//Uk6CDJ96cU4jc2gQHbMtxPSP44tx3BGEe/Vj/9L8+/4?=
 =?us-ascii?Q?6zDxFRbV4FiOSX2Jyp1+S0yyKhsBUb+4oWCK8aZqlbbW+cxto2J5p6UcYBd0?=
 =?us-ascii?Q?sBXm5sIRdnAgxEVZKnmuB++EqXQxfpuCN4Z1JFjAAh5aOnw2lC58pCtXwiUO?=
 =?us-ascii?Q?uIFFJltZiR0E6BBdhgEqBKh6wJdfMdUp+80zEH03LmW/Hir0NLWKr0fd24+j?=
 =?us-ascii?Q?Kuy0CKyET1IKK4Mp634rX/e+abHV1O/kkL+QOW/VrAlbC7x/Sun67agU7bum?=
 =?us-ascii?Q?23ANanlasXg98YmOLmccIE/E+pFxn57++ZQFYjPXEPU8VQGpurPS2/guuT38?=
 =?us-ascii?Q?NIp2ALk+BbEhr2jBmBRwR4vt9OnM38UyokT6rMPr3+CmrtvlBXGMSDcRCtZT?=
 =?us-ascii?Q?qXy/QhMsYincbh+garNinTRuuvRjWwre24VcXWQI+RJAxW/jK0Tiv2t913HM?=
 =?us-ascii?Q?dXC9X+XRA85fMwWrlDXhJwjJBkHTo/7m/Sw/+7Jenx/T14tzZa0wYswCyhtQ?=
 =?us-ascii?Q?SEKH08ifZLaj1+DfHbBnYIsB28Wz/yLGt3WfcvCDJOTv5rqYUL+mAlKaktRF?=
 =?us-ascii?Q?v7IKJC0civxsiJYqK1CrZZqnmtZG7QGNSwk+lSoOZHnDbF16jgSfCnj+KSkx?=
 =?us-ascii?Q?KXQzcuUaU53r8scg483iCNbfdVQyukSThq3aT8JH87eqHKZhUnbo65tp7A4v?=
 =?us-ascii?Q?W/D/oh93FS7hZiXWLEcXXCDk5pgGDSHA7IS8QTFzyxtVF/5tgPw5EE3gDKSJ?=
 =?us-ascii?Q?zydHFpJ4VXl8RTrUXpABcBEDhDgQb1TrI0SNtVKVxHzRaTi+cIebE6Cf+QTB?=
 =?us-ascii?Q?Ngoyrzi7UyKkC5VE9dGPlBkVjN1nsfzbOD7obbN1eWouc51Pu5PNKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ixr9sEXrJlBWNGrpX3wdmwp03WK67KuVWwn/WtqCvXAm1vo9h3pcAEBa/pLY?=
 =?us-ascii?Q?TLghpaQAc7Vp72li230G20FEpGCZEhC2wpcprDD6FW3VDAHgSIa0ivDbMYPk?=
 =?us-ascii?Q?kePNuWALqZ5D8jIXOfSx2j4PaxHlqZkBuqXy+y4hSm935LfmdB7dH6iaZdFS?=
 =?us-ascii?Q?f3OVGiNw6aGWWOU5paQuHiDxhHMN5682dqLzgfce/NfaEleIAyXmTF3VBeli?=
 =?us-ascii?Q?s+65vWVq3ahvNTii635N1s8bnVrH/mYKCF0pueD54CM57gjomDd3MejVUt4+?=
 =?us-ascii?Q?q/oxbs6KZGetjfcwJ/aPOTWuJag/o7xVxg0y86t5j2PXXBN1lmabgS5TI+vV?=
 =?us-ascii?Q?2Nev1hBtoZD/p1KXPzjE5inIrhF59P8Mq0+iZFSyZCsbzOw5NBmwLbHkxgOs?=
 =?us-ascii?Q?yaT6dGmxhqABynN+DpiEiE0ZpUupuZN9cMT5ZnkP7j+FU1ydtxgZAks/bpsw?=
 =?us-ascii?Q?W5Y1UlnwRk2YAyJ1s9pSGjQb4MN3ujETrwVRYG3n3um99lezk2qODrZP03Fa?=
 =?us-ascii?Q?dB0HAGyTUOTxP2luaiwS3PrhJYakUGMZeMsWTHx/8iYIUjmdXrU9BXxco+Jt?=
 =?us-ascii?Q?92NKvhdFyv5x9QOuaf9VBM3RFXzDL8tP+aC4BGEZRXzNiG8zsoeJ0ArilZaG?=
 =?us-ascii?Q?6+S57ywAhFHrEVXrKBsbKm6oKHaYO2aPc8nDdAGi0BTJCvtCSLthlUSI9hg7?=
 =?us-ascii?Q?TSMRmzW1dnqIgctSnUqHWLGgrh7ukdZCf/rqEozp7l82AycEVcMJUknodCiK?=
 =?us-ascii?Q?MU50EUupM4v2Lz80RAip6eXTb1rmzT8042417f9gMgBb9BCJqHCMgaitmtY6?=
 =?us-ascii?Q?8IgHiJyEcPWvJeQq6R5LurgFYtRMxYlMOvkiuIpBZeUzr5ReEr4JUKRXiP0+?=
 =?us-ascii?Q?wB/O6yvFmW673afODvDo7pTKQ+iPXHlDrgy2yex+C6ifMfqwceI6Bi2w26w5?=
 =?us-ascii?Q?SQYIjnIErxNnO4D2ImwCizck5ca+kuIPkzBzCGniVANhAh/Et+yi95U4MbHL?=
 =?us-ascii?Q?iE868cSOoQ9eIBKYso8RmxQfhZ0T+6CPrzvDCS1GFiLyzinfoxqyKPSqW7Zh?=
 =?us-ascii?Q?mFBUYvpbenWP7j6W1j1UlEQWMnZ75ASnioHQBmggudhyxn06bCatbQQP/1Oz?=
 =?us-ascii?Q?ht3VFMXOHbfijQ9MJjMrkxq0yEPOlZlnXvKE04F7Zt/J/Q9WiA1yZVFJEd6Y?=
 =?us-ascii?Q?TTqgH0grbww/zgJGpO7GKK3C7XriSuW0f7HkA07mv39GJyWpIcxB7b9T8uH7?=
 =?us-ascii?Q?2JTSyS62soeHmyGv7C/6LBw820couhtQoBGwJnnV/ojkQt+A9SCuTtFmaQi/?=
 =?us-ascii?Q?yDQXaCe57P82721y5XI4/qoFFdAzkkwdSK3i76PLDLKMZH0+A1Cy56vPva5I?=
 =?us-ascii?Q?3JGHohgmJ9hXKeWEFfTMM4HVxGuLX7+QLL4zmbA11Peol7FYLGZZ/Y+V96r/?=
 =?us-ascii?Q?44AIMXNd95tlPXaXKwzCdumH/ZQUQl08LBq30jD69z0puKfTH+rvEckMFIFu?=
 =?us-ascii?Q?knX7PRXqjJgjtca1ut1EwveWavVMy9KlQSyJUkSwhDQY5/g0bkGOqgWnI8hJ?=
 =?us-ascii?Q?I0cw/xUyTH7zBn8ix+ffZh7exnYi88MoYVIKa31S0lNFHTVHcvd+0tQ/XuD5?=
 =?us-ascii?Q?fNqcakISkkeq5EXmGxAHC3E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee62748-cfa7-4e3c-9e5d-08dd2340cf66
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:02.2861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVur7RWmrYFOpEeQhPChuCYRaNpL91xOtdZW+JZh+E7RTFmaapwFo0nzZh6jNWm8zguMk7fe/BQbXSxhUi9W5hJIJZMbQ0NDrz1GvGhUvAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6676
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.45.2

