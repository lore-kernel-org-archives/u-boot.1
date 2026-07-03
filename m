Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CE2C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E5E84A92;
	Fri,  3 Jul 2026 13:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="F1sU48rC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32C284A72; Fri,  3 Jul 2026 13:56:59 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2C384A72
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKOqM7O7bfLANXmwPKOTuBKQRRg5RP3A0h+WL16fImQG9kAC0Z1dAPiCnt+c8fCLI/tVKY55FuvNrOqBUljl+1+tUqy4LPfttrc8nZFy/j0EhD9e8Kg2YDrtP24GtAtwP2P/8e8eDw0mDK5JWCYrp4tuLSYIPj2oQKdwvAhD1mqdNTYXCeL3t5YI6iCj7vpZljGLJALiKLFYp9EGCZDOiiQkzBeAteNQ1+RBO8tClntHtbfMBXEhUUZvY8nz8+9RxyL6Hcbp4git/h+cNHQgzFohJl5/LrgOOOYUW6QWOxi2vcEG1ij8ky+tHY+gjhtWBAQM6RYuOKaeguufEryfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62FKSLbSqt/P3PeEciBWQ7xXIUoCxAL7TX6E550xdts=;
 b=a78uG+qOow1DTIWTI0ApkWsgcRDg3DEfXfw2GFK+FS8XBw0FMgyGIMMhFadxV5Z3Je3MCU/aEznGitSMqIoJhvjWCiw0oHBqFPx9uRw+BhN2LngRHdqOqzdURKqt+e5VEQyB/9fVWr8y/ET7FvH35BOAbEXQNUHE8IK89VaErqliCOpA+KyGdyLLMsNbWf/sZilXS149Z0ZPBgXhVelPqER8rxCcI36AU3zArZuE2FjQcPcBe7+Hl7a2Qbt342RTjM6ltEsMmGyV2Cu7v4/fzT+noKDnywffsbf6f9BgFwWx5nqRXux83E3Ed/bARms9mOiIWWLmhHrsNy8NUTHf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62FKSLbSqt/P3PeEciBWQ7xXIUoCxAL7TX6E550xdts=;
 b=F1sU48rC/hVT7UhgCINoQnroiZWawAPUf7/xztFWLJqbfZQFMslSG6swLQ1OIHh2ucj/Ymc272gtdQ3GxN3vBTsBDoqDrhg0MlXBLphqkSSIdqDOU2Y+UxBDxsDSzB6meR/lTanmI/X6l9FqxDnwyDYQAvkrAR7octkbl2LU1QyMKXMVBs40BqOhUChSLBx62qPXiAYFXH2bGMajZTlIq4z1C0SNBzax74FVH60pfTh896DnUmEHm+24fuoKGMvvxytHqpKE7Bq8R88PjUK/wG4MFx/OLd0MDc3hriZOYxkmD5XJ68GdCwScm06oHwLuJTZLGxnoRLagrPb7u+gYrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:56:52 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:56:52 +0000
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
Subject: [PATCH v15 05/24] clk: renesas: #undef field_{get,
 prep}() before definition
Date: Fri,  3 Jul 2026 14:56:08 +0300
Message-ID: <20260703115627.2317120-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: b31236b3-61ed-424a-e118-08ded8fa2bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nPZQzrF0RtFuSVjhUfneF3WoEXH+vrLcWTeAV/snkQ2PsV0fKZGvjP1WAGOkfEoOgNZHJiU6ccDTmKkttrz4KhYfErAbkAkrwPDCzG/h+OmqEpBnGanQ5aV5M2qFsgcR94GyDsch22hMCroCn70TgabLuzoeibsrJziulxc6R7O7YOnPdCi3D5gkLzl44iFE7MfC7KBbR7iNmxDxqNu1OOwSvCpFUvs/Lwv4sG06ExfbYc1MH2uX5vzGd0K4Oix/tGVk65txcl+TwvxXF+0/JmMReSosqGCiSsUY+839/9mbdzmDbSuewDdHuCCDNCk7nTc+k7jXSi9Kgw+WpuTTFvDpz63flhxjTE/0iC1CULIlmVKGV9v24Zor0WRwP+xyEDQ6PGPyhThM6hK5BglKEuweGi7IuhEx5upvvSCuRbVnY8Z/QBjpqGHG+eCCa4UFw6po56bJbKoD8v6WG1VtUfqimG77Ip7qxsDg52nSLIQCUOPBTjU6kU+3psrOVLc3ZTnaEEbfVucQieTeQegWjIpkjyQX9FqsxGagp/jszcgXae5FWG+NuaOuVAA6eu8a+my9zgSv/5MspcuI5odQrIwC+VW9KklibFFAr0UiEradh2hauVT8cMpnmv5CVxNDYOFMSXhWRquKGrgK0Rw3GoQ0/kMyWevgAPN2FRbBtxDiV+F4Xv4s8tc33DN/+1eSa7QMCbQKE9LvW7jS1H56pRO37Ys7n6uzlgDdqc3OjBcn0Ifw8Ei0A01CLTSLBs6P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tsfooo4yq3eE+ZsHUlWeXF+XvpgHqDOyc8BUzlDhxza6AWHrOjk8qR5iDOpv?=
 =?us-ascii?Q?ccYVCpX75ndffHSKGcarK3ZjEHNO2pCytFiBAXiXLzeLORxuu7sWn9KH8M5k?=
 =?us-ascii?Q?ljTX21ZJQ+W6dhRm+qKutVsxjEUTQoy2lzHThiHerR+tlhxmnbJegiS23YBf?=
 =?us-ascii?Q?T+Sqnws6Nokq1Wz3zQ5bAqMyKmjqiaj9pkACebp9F23p6rTd1JjZg4A176rF?=
 =?us-ascii?Q?owWVqCNg9weljCLFY2+huahn7WlR0e+cEhVTrY64HBRi/6cZzSqlpdavTxQH?=
 =?us-ascii?Q?8okVQQtrcbkDN+TFxFuYjdsISIKOyNq7eRPXe+FuRMCxkzVcjpaPDAFD2GiT?=
 =?us-ascii?Q?GxPs/53PAGSfld5oc5pFnV8mKOjK+GqYB2J9pgUEvkSgSrwiQIZ48Qo4sEXI?=
 =?us-ascii?Q?O3qWkxh9LqTRIMULdu9+rVaWEjBrCOMlr2NEeWpMthNp3mscLxhkdtne3ksy?=
 =?us-ascii?Q?sEZN4bLjlB54hdXtfhIVyFikaZRkc/7xOfJ0GlNZwxY8v9qtkXF3/FLZ8foD?=
 =?us-ascii?Q?k9i8GjrBqgskPA9e8qg1okg0UyA5KH4en+p6rGyXZLoCOva2AfGh/TTWD2Q2?=
 =?us-ascii?Q?qdSwSqHnIyNihCjHtU2TsWJIdGhWFxbotivtugZRxFG1RIVsaXKh4oOLrFR/?=
 =?us-ascii?Q?AWc+TGV2FQrG7KILvVwa/GdGSoi3Ddzll7XNVNfZkqgQJTgQagHusuQ5bNgW?=
 =?us-ascii?Q?Zh58BRYFXEbNfiHXW9lcUPA//WiBd3h52CsXTdozXDQZ+DjMb7UYl3FqBFnc?=
 =?us-ascii?Q?0oqEUIk7ACwm8DPVB0d3CH99SDBbuGdbKSx+nVB82oe4gdpeEqqqmMDRLQcw?=
 =?us-ascii?Q?eJfWNHlMB4FBDQMSFoB1zLi0WNXGld5cqaPX69wyLIA0k0u1GE1u6vumkPZl?=
 =?us-ascii?Q?PJHQhKKt6LqLEo97jtLCC5K+9XFIioERq+KsR0yM4vcra5qL8f2xOggrdwq+?=
 =?us-ascii?Q?uIQZHlPo7IIgB0bpb5Pi5QCApOuOCtgS3kh6V7F/HzgTDK1mPuEo3xMvIsFX?=
 =?us-ascii?Q?kWmMDmwbuxLEKOVHoBZnwJ+HOASJ8GyofVzgKc+eQUNTmyY3T3ByhbMMzK0K?=
 =?us-ascii?Q?wh9xUq+ZbETLdQ1CvdTTWp/zVAifuhvFluDzE8Oy+I319X6sQvI5omN+txlN?=
 =?us-ascii?Q?3ilGOJ+IHzgmCeEtyV/RNLAOq+sKyfrzg14qkIVjHZw2fkajFnDmYa5q0pgJ?=
 =?us-ascii?Q?E+4+EMnOgZfIGcL9xBFAwu0vzTByMoPRVi/buCriUjq/GnMi3/wYwfAijZRn?=
 =?us-ascii?Q?wSl4UAVjgp06QOzlQCpk4+Qu1GHI5HMJounmpzITJrhxXb6EO9NCyxQGiG0X?=
 =?us-ascii?Q?FaH2DtW7wLBXzPwHympBXzeuES+27H8X8CCvpUTPnjmpbiGRY2o75oz+i3mC?=
 =?us-ascii?Q?9XJANdkbPhY0ViP04n+Rb9QHM1bJpdQgM1l1ANrf8uJuxWQT0wuL4+hEoPMv?=
 =?us-ascii?Q?CLkG/SU1HykaCXvQ9R7mmB70WohRPrJRixv4etnUAtSIpqyXkvObz1wE+Oux?=
 =?us-ascii?Q?dZPcP2uc8NTWQSCD+Co3n5wgFYgzEL0SJRHh7xahjSmfMDRLAEsKX82f9owq?=
 =?us-ascii?Q?PwerjQhZzJjvtoxTRem0Ia7Bgpt4vkplz4lvOkkhw6OdWJxN7IwUmY4zDms6?=
 =?us-ascii?Q?4072IlTt3gUrEOMr2Q2AeKWoXVE2NssaqzkPOyS7qjJXUt9FIxjIqLI9IXWM?=
 =?us-ascii?Q?xqG/DM2lPo4UgEv/Oty0hF9gsu3P3ub6o4oeSCr+fr2SiXd8CKjwXglClYTb?=
 =?us-ascii?Q?G9zaFD95mpuDzUJwJBICcSULyMQYKQU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b31236b3-61ed-424a-e118-08ded8fa2bf2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:56:52.5143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhhhpFgP8fUB1gR0U6ll+JYk4s4Rsgo/SQu8KKLkDwNamoW+h8P0Zs3yluls313Bw0RB7kVQ4gxslV8hnZ71QgR7zSPKtkDnh74qBqfcQY0=
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

Prepare for the advent of globally available common field_get() and
field_prep() macros by undefining the symbols before defining local
variants.  This prevents redefinition warnings from the C preprocessor
when introducing the common macros later.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/clk/renesas/rcar-cpg-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/rcar-cpg-lib.c b/drivers/clk/renesas/rcar-cpg-lib.c
index 60ab2cb379e..5d1c8514adf 100644
--- a/drivers/clk/renesas/rcar-cpg-lib.c
+++ b/drivers/clk/renesas/rcar-cpg-lib.c
@@ -31,7 +31,9 @@
 #define STPnHCK_TABLE		(CPG_SDCKCR_STPnHCK >> SDnSRCFC_SHIFT)
 
 /* Non-constant mask variant of FIELD_GET/FIELD_PREP */
+#undef field_get
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#undef field_prep
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 static const struct clk_div_table cpg_sdh_div_table[] = {
-- 
2.53.0

