Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6A5C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44EBB84AE8;
	Fri,  3 Jul 2026 13:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3LVO1gk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E3384AE2; Fri,  3 Jul 2026 13:57:39 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57ED84AAF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndBdBuFrRDZ7Hl/syE6vbCWuDVBwhm67QFpkKrWBBsO6sIf8cTk5/jvBfMPIkxLV3+KPopGgva9b05fpocKhq3Ny8cqB3aOY/zjSBjWKzTX/norfYJyZWYa7jz0sPS9UtkkXHtHXVmee7IE/JnhEro8M4W9r5C/+m9WLEYI4680Cs+9jAaxnS5A89IL24vRWfFNuelCOBdd/wT9mtsYAHw8FgYMc7UFxuJMMmJLFskXVuEs6Rk/I/3+dERuAWLY0+onX7EE/FDAr7G24cQWmX9fp1ynPmOxKcahgaXrAngRcarbyUhbKAvuDy1sRdZnRiMhqOof1E+VFZ44ZfWloNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/PNWOSpDDq/dsQo3yyu1loR+SLNz81UQkCqKtm2QWc=;
 b=MbDzG7jWANLpRD/HfzmOm9JfRu3seoyB9v2s9VgYeS3BwrqioN58v5bK78T/GDfmWJ7CdcjM+afs+AqF0u6dEWsJY532N71w1AqCF/PuDdkN/tYJlRWxLVAc366Ul239ia8cv5krUWTopwl+3b4voKr9vPcexxeNIgpiI/ihTchHKX24vy6Vq6TP+XJO3FHBqSxd638h9klOyyDLeAEpvx4dVpJbdRb1mW9TmsOpiv35gr53sMJzjHX/4dOd7bFYM8MFvZLgNDcBxqcRZEz3+/GypJI4nv06q4joe4LOjgvJZgR9mKNQhG6K8i/0wjWdGlW4fmVN5kB3W/wBFv3pCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/PNWOSpDDq/dsQo3yyu1loR+SLNz81UQkCqKtm2QWc=;
 b=3LVO1gk+8NwaGW6jFxpoMUfFtLP3nCCfzCFLfh8YU3wQkwzWxXrx0EHYaYbXpND0jYW+ExXVBBrT7Hendv5loS/UxmyfvgMZcs2ESxYnAYKKLf+kQgjTXeXco+Ahu5uiijmL3fml7bgIiAy1aJAVDg62sbC7QdnjBt/OeU6CMqQpSCB5IE3opQPwQ+VC8Uo9nBPtLXYd6NlYsjdK0616DiUcNF8wIjLOCsM5JB0UeMZyzKR7RMu/jL0m+Pq1KJpF6qZ3I9H9KpQhb3uCgDoX/PFLjHrlsIThGIjqhlvGkzffZyGK5s/LtYO7/sjHdBcpDMv6nuHk4qbuydndD+amBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:22 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:22 +0000
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
Subject: [PATCH v15 15/24] board: renesas: gen5-cm33: Convert to common
 field_{get, prep}() helpers
Date: Fri,  3 Jul 2026 14:56:18 +0300
Message-ID: <20260703115627.2317120-16-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeec792-57fd-4d8c-8646-08ded8fa3deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: kWpS/SZO56N8+iX/dvPc1+QF3CbODK44BrksJofY5SRIYy6kyq0OABT1TPF5TftcZ8nszLMP1HFdkJ38uh3WZpciy/TUQIXa401ZJAqlCzut94pQfMbC/nizXDgj0sPLec6x65skfybfgwZbHfqapma3BSGhCxFDgEGBbIQgX73lKF5IKppv7FMKy4slqRUehlGGxLu2/d5uKxjPaH4g5zSRGz7NKvMNb+6PYfbs+tL3QHhzMaMrZLViTg9Atu48lmUQqGmxasTnKIh9JK2j2iI74qqSuxbhqK1C5MYEAvuIyZ9Il1L1CZr1UGAcJBvM3K/vTy9ZAFa0pt2ohvF7gKxw7IoEdiA7i7hk0s8uZPs0AsCFMtN/VXu6LqtKCrQZtM/d92MkkcWZk5fYdYowRbI4Rh7chC5cdtQoY5jAgywoFGih85podPqBh2gH9TLZO1X8ScI8gdQ8/sBLAWTOyL4I62waCoAA9qvei2JhaRA+8LdkT+zLUejgqqXsfYjXnXsOE+yYX7pORI1vCieDQDoXQJs0cZQDsD3NMGKh9BV/QLWmzSgQGYvxisNXWVVqks42LGvrbn+GQskm33iSyEI1WXtrNPqbdrmqdn5YbJ0u0fBEseaSIb1I79eNtazI25s6wlFOiXNFqsecv7NUeHTWjyMwnoq3m8FZNFDtJWeQsmmBl9drICluOY7ZWhxGqWSq9hGGWodt3tPwejmx0XFxxhtWA4TblUsvRRqT45SLq7Gh31Wf//WAy92SF/E2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XNUV5c24Y8VpbVkIwp6a50xYGqmfko5sA1IV/jvdjNWk64bCU4CdFN2kgeZe?=
 =?us-ascii?Q?hywbHSraX/cG2Isx/gdZdqR6NGZ9um4O1lxMceKyzPBzZpDTa3oyujUBs/Pj?=
 =?us-ascii?Q?0kA7/vqmWJnzYoNGVgisAF5bfO9pB8utSCDX8I8WHt1tTpKGx/PF/KErZ3WN?=
 =?us-ascii?Q?1MNO8AiOSTFyc3SdIOxsMjHfFLzmbe1DlG1NtbUcK2K94pZwnVZie6xtX4za?=
 =?us-ascii?Q?GoixNzGAF4xl9XYMR6qF47ApvjjjSO+1fYyFs23hFi9NHL9Q9lQYe+YuoLMP?=
 =?us-ascii?Q?K8tSiknWNRgaTmfTJiNlaVkT2nEMiW7coR0zBcpL06rWmbCk0QJv0b1ABw2o?=
 =?us-ascii?Q?po2ASLW/+KVaHyhqj9HMKVSjRgUW2GDSwBPuDcAQcGF0r8skSJaL9J2fe+nh?=
 =?us-ascii?Q?+Ix6ZXYJFcIn44SNmFV5uTd18LdACy9n+x2KR0Y0sJP7XojhycZbZtzendCn?=
 =?us-ascii?Q?mJ7SahWXDJlaGIQZ3jSgPTXcaFnmdVR2bUY73LTWMVCIIwWYysnAfBa335np?=
 =?us-ascii?Q?0I16DvnAHTS0zQTLOfmkZg64Q76LNwTgXeJ52tsydI3NsB9zqbFcYrLkDdoU?=
 =?us-ascii?Q?No6sGkWR3qw5huBOuldhWXdM5hgnBVQ64QQuxQMDT1Lto+tNwmdVX5qSUC7/?=
 =?us-ascii?Q?Re56iNgh8lXIoKdI6r3pOYULXjA/XFJc3p0xuCTMGd23r0QXqgk4BwHowQrE?=
 =?us-ascii?Q?sgWW3eu/OUUJSVf0wmSo1LMzfJYWfCJcm5YH78G6FFifkyVKZtxMUeIGBJC6?=
 =?us-ascii?Q?lRle30ieI4YZiW27se8qECNGwYvHeCACsH//hy5txGr8NwhWROjy1VEdxEbD?=
 =?us-ascii?Q?Vsi4rz44GKhdqiqqFPOA7ISTXH7D6Hb7aacjYT1il44IT1xRZU0c0MjENhM0?=
 =?us-ascii?Q?UUln+lkB05lTGNoPccmI6v0DjuNH9sJmWlauH3faxbmOc7rSfUJVTx1vbasG?=
 =?us-ascii?Q?Fx257C+JGZwE6DGIeXCo/W4QUy2CfhRaooEjEiE2upM6dHayqL0cl4pGDEKj?=
 =?us-ascii?Q?sbGeaOzsTqnRjiN5hfKaSoOF2eqAONJ/5jws5eTZTlLgdMSvfDUUFoY2qPUk?=
 =?us-ascii?Q?sjTzLfTciI+AzuBxAP8wPrwtvt+a9DzICnyl8gnIy2JWgEoYTtPphAiBf1wh?=
 =?us-ascii?Q?dCEtNaMsU6Hmjn6JYSMQeQx2qE4N7IvbV41eN0niRaxa+g5ryGDQbt1QZ+VW?=
 =?us-ascii?Q?1nbuDMPKSyRZyInQZIwif7nw9H+rFygrHkKBnkp7yVBEvwQp3jBnnbWSXXGQ?=
 =?us-ascii?Q?nO2VSLB8iEJ7a6Q3O/5YEPMwjmxHPtOvehuQsd40HZUGbwrHAlbU+sOddyO8?=
 =?us-ascii?Q?ovUZjLE5FiRrNutqu9U6y0dyBS3TPCKZqjVIRAGqVOrqkn0TqqNz4aZ6cYnq?=
 =?us-ascii?Q?7PfKcWFBRW+Qld131hYWQFONcFmMM1fbv5qOpc7GRl2/IgIaJeOQUsVMfU6o?=
 =?us-ascii?Q?3PJZ05qNymfo6cZ8+UbbieIaJX1be8qlUxjyER6XmkQJO2GwGyjVzY2Qyksp?=
 =?us-ascii?Q?XOuJv011ZS9/vd42rrnPuAyMQFG3LZvI6gmuizbY6m/Ah52AHrgsNuCtKzDH?=
 =?us-ascii?Q?iJFogZRN8O/yFOKQSdC34BSZZRpeN0+CsAwDUBkzsY8EmFhHdmDOm+Q1LPgj?=
 =?us-ascii?Q?Eh+4jcl0ylHD1WrG50AJBcpHyuVikCwcHDQo+yE1Rpo1UbjZMZmoixfMGBwS?=
 =?us-ascii?Q?y6rKrbNFskZghmPHki6AaaoIIexnYqeyqsZbRHf2+PakLgJbUtdwbAVFAfKb?=
 =?us-ascii?Q?2gaIeM11D75Mpb3Vmb8uQm1HfvN8UVo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeec792-57fd-4d8c-8646-08ded8fa3deb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:22.7078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltVXkQgxkfV2bt+Eu9k95yBUXHspNiH3NfoTPNXAiWK409w2JHQOLhp7hIatYAgX1/MhZN00RTuOlq1Med+UzNaHXmX/KL00ENACwqnM8a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8172
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 board/renesas/common/gen5-cm33.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
index 00280c142d3..b2f6087a943 100644
--- a/board/renesas/common/gen5-cm33.c
+++ b/board/renesas/common/gen5-cm33.c
@@ -21,11 +21,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#undef field_get
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#undef field_prep
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define PKC_PROT_LOCK				0xa5a5a500
 #define PKC_PROT_UNLOCK				0xa5a5a501
 
-- 
2.53.0

