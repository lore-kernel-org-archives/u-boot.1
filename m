Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3774CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF6D84944;
	Mon,  1 Jun 2026 21:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aE0nTOKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A23984928; Mon,  1 Jun 2026 21:53:42 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4E5848E3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Brdo/PnbpyPlG/lCKYRRjKYL3Le3y1eDLyQ9vPY9zQf+47WMs1ElqxUlLJyOIoOG+DGPzrWYlt2mnSXSqYzMT7Og1pyGUcPMSU1WN+M6Tevg2RQ2gN4+aLum2YddUwH4z02sJYgbk9Fg1ZmwpUl1YlgrdsYaWnYROw5+kLlyzhCWKFcc0IcZOPRAqJB9iDoNpS4vU/A1L70J1MYoBhObp9gkxpJasSKro6+h+JfEFc6aKKhVQ6w0Wx//5zjdSEjX5gAhaIL1CfDqAWaqjA+wz8oux57UHcl9w8MFLJy4qjotu9uiYDTVBBkkp+yUB/Wn6c0cmjjtA1PTzQxVIqDAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=vUUh8wq/0E8YSVJfOFQplrxoIu8Bm7FVUbizKkM+CPRJn+E4DwM5o5iE3v4RdrOdMSJ4UyHJUbcUmbtQN3WL0kWiRx1qGozodsIs2zI4j/6zXQwAVxRBimXCJ+goHpad9lKRGahYhHVsVw+nznvofD3xn/cPAI1tb4MNJ36CXnCOrbJtmmmzQkE+ZwtZXl7tVv1zEFwuAwDdwSeiPmWMn+E01V9CjKHDwx2I9mXOaW9SpRJy39VJ9L43CRMUq4YKWlbc5H1QpmzYoR2KvXMZ3Omx+Y3MG3o7eadu9x4UW920wtLP4UhuGvARAzqtTyjrfct6ULd9EvEGyaRQtsPv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=aE0nTOKWtSO+8vXll8dG0nlZxI+Z+QgJbSpH1i70XMz+4rFgoj6GtnGQf/leY8nPUfZc5Q0LKhz8WOyuL9MNwiNvq1OTydg7xCCERQX5igCEV3DbLV2oi/BPS1OENlaO3AGfM6/MbvFMuhkNc5fDKzOWQLgl2ULsH1RltobR0zjgdSW5n8+oCTHZHYNf78E1O64aDjX0IOR6YHrhXPJIYwemMmYu7/BjR1PSgZGIU7oS526uEL8fCcnMjuqcsllNnIYddAy3qTH1TEuyh6v9jlvKqGnpBNuZ2PmOM+vDt8taAeNnG9uZ18zkKfYxDuoyQWooTVxeDNn1lHp6g/hjmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:39 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 10/12] configs: airoha: an7581: enable pinctrl/gpio support
Date: Mon,  1 Jun 2026 22:53:09 +0300
Message-ID: <20260601195311.2390473-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea19ba1-3d60-4304-3b7e-08dec01779a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jp6f2YiO2eej26gK3BH3l5hmA0E0mr4fwKln+fKv6G9jktP0cFBptX5kYhAA/WEkUQk7+9+usRiQwUaZFuQp2TaQKkWRLVU4iAGht4kfusmPiniLcAZp/FabXuOeMhMpcITMRglb8jw0a8rQxwkBekXaJrzw1IXdX3FD0oYowos1zOoGaeYRh/iXTN+UwhWbRVkMvuPYJxN9F3ype03misKT+MrrxS7gx5q+zvGTG5/ngda1msoaCJAfvd+q6W3YmwaS3AUYnCoYLWvGUa6GihMTVoXtS1jTTxTAqAO7y3ypPvEbCyPrPoDuoeNVTI2WsEnItlm2qu244/RLNrPZBOUg/vRA7V+L3iWcXehHnv716ZiXIMsfseO/MaHQPASmHVzDo7Oq5VOg1EqynBb1j0PEmpLv12nAigsetbA+E92if0mcNF/5kJiFCcK5vqg2O80liq+4lHCHL2F4VnFgRhAcog/TADFF2b5un3kGsTj/rielke2T44svzMJpIGPZvoiPNw1uM25F2G14lHCtcGcqYJy15lM3IPUS3pzmkpKjKj6S4hXEQy9FF3/u5SzCWKK8pjVaFoeFjeHRn2gecD9Kupf1AEzARxCKQ3GjsAD21BHlx8DXLLiqDCC9QZUlxkYQI1/ZpHZbqlxf9AFB/fv8S1M+K6sPRNof22tsyaFCWV5a8rucVxc6BJE8xjQ615TWmUWmTkg17fcS5T8eZZnvd8CAhMDe2c8srhU8JvLlfBDDAYrj93iFZ6dSh1ZgZM15YJpDHPXGUgcZajMiHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L8ySy3D3UhvH7RuN4eruKV0+p7ZTGgdZFAzAcIc1PFO17niSYSNTYrKu/7o5?=
 =?us-ascii?Q?opvqqIK81Pka0LPP93XESNrtM5jqDUqB7oZiavOV+/euh4/Qu4bjDSutd6LP?=
 =?us-ascii?Q?WgoTEa/L8Zb0aTUbv5NeXUJfb7BoMb5U70bCh6fSSa8l3tgEcRnPTW6kjVqR?=
 =?us-ascii?Q?1KTKhuoDLGJBFhmyCcoIZdRU57RNdVkt8P8siOmapxZZFHaMdBsfPSxSAJXf?=
 =?us-ascii?Q?jvNqSzaeBKMNRkLRw5lLM6wu2SNS1PFX9TO03vcTHoENee5yfCgSIeJTYK9v?=
 =?us-ascii?Q?LVqZCnh5v7O7eH9Zn/vzgnCqW8QwhVKnKBQmeNv1/HHegjTQATWTL53a8uqq?=
 =?us-ascii?Q?tKAh5+cuKwj8ER9pCCvoZWyJ/uzOaFzgrWgmtU5kgsKCom/qHuXML2+5u8eb?=
 =?us-ascii?Q?1rjN6AFYD7E7v6M7Ws17sJkNd21O9Jy0fn05cRxoRS0n5oEm6HroyyGn8zg4?=
 =?us-ascii?Q?BAsUeSPWPbjFY3xnWd9oPRntMh1LjSslSk00ZvygFWhVa3J/r8wSaP/ax93d?=
 =?us-ascii?Q?e5bCUCemdBc72+hyXA8ev/XYA8Q3L8DDN1IAvHIzsmpcdsiaZVtARr+Yzehq?=
 =?us-ascii?Q?gqQ6J9YdaQ/hn+q1G1BeVYGMlN0c89Mu8uXX+E20EP9il00sELwsDFhY2Tz1?=
 =?us-ascii?Q?c/N3JQlCvlBgs2vyAk4FJjxh2IuwbSSBzsPT2EJUkcOoV8iHRENBrkjpwvOD?=
 =?us-ascii?Q?7fZAJL9UsHMKPYJ13DUHGd+8PhqZazLm+Nld2T26fCCVdvt8aRQcyYjtOdHO?=
 =?us-ascii?Q?mseSggXqYbL5vcmZsNYYbEmCj2hIsPo5VFheuXegTggzTMYeMW5t/VFSLnZS?=
 =?us-ascii?Q?3wPwdWXvxYqu/k5hwOxkMwaINn0Idya2heE5Es8AQPNujPtpRUSsm/jivTAF?=
 =?us-ascii?Q?j8Pk3L61YmC5H4jwbss8sZ5cT1m3gvldnkhacG6Fl9hgN/M4N/l5XjmIkC2d?=
 =?us-ascii?Q?2vI++hTmTRHUOz+oqkzEOUBnn6ieNzfWAxjZJ6vq0cvObYtU7kVpv1tTmHbV?=
 =?us-ascii?Q?rSDAcOOCj38xykXqCuhPdT5cvu6MDaCByq2X+zvL5F2toefM3GOUgzA13wc0?=
 =?us-ascii?Q?SpDNLZ1c0J9Zr/tOXzfUMufArkRSMhvsce70cRXgFb7YIO0UEBerQ7FfakVE?=
 =?us-ascii?Q?yLokm2uXCysrByUYiEAwPVxnehZ5t/bJTgl9zwvdaJk1OAdgMRHHje7IIXeb?=
 =?us-ascii?Q?mg2PapwXaHsx0C9mmFtiTeeAPRxFYilvfgEq8DXeZZ10vhIn3bihwQeKa0ob?=
 =?us-ascii?Q?WZexSGNL8U5NHzSf6fmNiVsAsm35WTqihiJnp93wPRhxiPCLrmO79GN4oDNF?=
 =?us-ascii?Q?gZURhUjFlGZKvsLVnvvImEIj+mSqF53/eSr36ZFLpxv+GRnxwHmWrjz/tCNa?=
 =?us-ascii?Q?7BZC8lX6qWWcPbUtcsG3FIMcNM8y/M24nj8vNmCJhMNblavbIRJSEfkcxSIW?=
 =?us-ascii?Q?chepI2oBiOt4WcY3ZFcIhiRWbwGrwUKT4iMmef1C42AoiFHnYZxHAUW6X1eZ?=
 =?us-ascii?Q?drPTYagMrXcji6n5qbfxrvABKxxmViO/mooykKkLtS4HmOXzycg9zOevgPkj?=
 =?us-ascii?Q?YHpqc0U/i63M6IvHWN8zh3kOm3i0QgfkVi5PQXGt8xUbpZM9XlbW59XxPEua?=
 =?us-ascii?Q?2ZHGbM1nsx6jCoW69U1gVoEvF67aD3B9iv/79Xg/hHmMngdggcBqFIJ9jLoZ?=
 =?us-ascii?Q?TVH7HAnU4Aij049zN2AEtxiiOlo8dkO1ksJqhJNYOdqtxLumxIczve9sAFTS?=
 =?us-ascii?Q?Fm0iR2Llc7uPQKPwY+IdkAOiEkV9f58=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea19ba1-3d60-4304-3b7e-08dec01779a5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:39.2484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sK71r8wKZeyvof5ilzqif3wnHWYkSjGBmsEGKVOhyLTbbZyK8yBkFIwJVexYDathg4295ch6c74W0mPRJUmLEV7Uo1XfFyOOKUqw5o2fxy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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

This enables AN7581 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 configs/an7581_evb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 07569fa0a4e..a615994cc76 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -72,7 +72,7 @@ CONFIG_PCS_AIROHA_AN7581=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_AN7581=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.53.0

