Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB39CD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E5B84975;
	Wed, 17 Jun 2026 07:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bF1XnpaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65EB8495E; Wed, 17 Jun 2026 07:30:24 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8796984987
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6aroq4ZAY14IqteEfcYLsS82tO9NOaHIPGV8e3A8Zx3EIMjdFDHTH+Ju4xS6yjl6GTi7B6kdrIuoGOz0FAZLiqebbaYvHIG+qdXsL8RpaiQBJEaWq1qNF11fal2Hc65TO6N6SbcGwDuP2DnyJDcXddbiZrfjPyf7oKggbX3KGmFj9FfCSQEXs7p2LLk3SJhu1QDAgj16+S5UM2+ymE5NAfsq/73zXetXW5HHsvbmWZIs9AwU8zSHdEIUwlRMxRRbC+xEJuCFSgHjmQ0vNVRjBnDsp3b6nfNUcdBvaMozP957IcILL1a1K3XdwzAy+rkk4N7LGN9kDfPuqOPZbextg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=kPYr4dqHQb/7azX7+wuZvQ2IBUtHrnIyYeKkaO+yrk23ovJksYYNE0Jj+Mk3rrk1avGTMpgQ9hGcJqzgIxscmLgRs+90ix6LnSpeP1TZ9tIeS6yghWhl6YMj6gJQBlxPeoMRet35fyLU3dYZ10PAk1KaaGxX8rR+vEcq0rYjFmhBOU92AV1eLMXLsRYAmB805755s+s1gVXxKVbVryeKz0sNryJvUc4itveokMoO1HdUPOGvb0/xtyIeJ0qPJt9FwGQPGWVf+ERAhKiSA07uRxuPFlNGBK4OjinmvtPTr+GxSJbim438cVyIo85Wg2juwoExUYVOOiK6B81/W0EEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=bF1XnpaJK5IFDWdii+Fl2ul9JBwv7nabVzts/4kThaGMp+FtqYKG2E+wR0yxSqr+9taeahrXF6EbENN+3jzi5dyXJzsXX3NixKT9r1mWNxBI90qFMhWNwPyySgikzB8l9Delq6my3mzBY4Co69uwig6w4dgvWK2JYBGyz3W1hhpwSbXOOmIwqsZUUkReE+w1sUKspDAQvttH1+61mF7NF/9bZIHY/1y72IPFJYV6Xo8BZ7bk4t0nSeNKcTRb7NQ7BcP/c4CaNQSqi7OYRl8gQa7wvUyj8NS6/Wv+pPo9JklRTVZ4GGiK8Zxnpj12vn/xkaoSc2opvKxtc6l3exV1UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB10692.eurprd08.prod.outlook.com (2603:10a6:150:160::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 05:30:19 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:30:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v13 10/12] configs: airoha: an7581: enable pinctrl/gpio support
Date: Wed, 17 Jun 2026 08:29:46 +0300
Message-ID: <20260617052948.2815870-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB10692:EE_
X-MS-Office365-Filtering-Correlation-Id: 426faf2c-bbad-4649-9a8c-08decc318508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|52116014|1800799024|11063799006|56012099006|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: L8vh5uuXYjdAYSKqf37iUHfoFHvAvUphYaxQvIcwckfA1ZNxOLiit0eZR27/tRkM53toA26REyITMOej9CWUxyEa+88Rafh/M9yaxfkVcvIHZS1mTpqnFmxSGtvGb3HpPMSc2pX3tinVHCol9oNVTT+L7FLHIlDi/wATvluhIKbq5AvwRuAL1HDt5Nm6I+0ErXi8UGKBtwlzjmwMbnyabROjYIhpeTRKpfxvzuInf6As2o7ydF8p6UkBDodRNOsFQsUfcyXYGbNWHHwB5jfOAOmZPkVwOcejGuphR8K6ECZOvtIBpKDDUfECO0KtHjbCXI2h/MM0lFYadc5dbtar3OjKknyz2Phzk8WjYI3uGx3qlwjkVnTvxQgRdaG7/WFMAwspaLYNmozULzFxDFdPjC8JsOmExc7HyiAsLXriClwy3V3lA4UeP/rE0esfTSCDmrwYS6PDlp8n5+x90gN3Fd/HEk3by11+3PPid0rYdrvZo8CpTAO+kuY4nV98FVVI6QhvfP8zT/suXaRLRFaRMaDrUldVbP+Wr6nvtTZHGp6ZlwtHCVPG8Pu9cxwIjVU/AcLxvBjhPv4iAUxNCBCN1g5rLmQXQ4aJ4do+HzAfwN3HjzBezq8rnenAuUqVeG8yOVk1Rb8gpL5iwAI9jjeRUlMcEKtr8cUFMvnGQtZvNcXtGQWSs1dOgBsz6WRwQy6uzrpwOlm26Gyv9lJyKgIH+8DcZMGfkEs0Kg9NkljV2CP1VOWS1daM/EJe5ch3uPEgg1yIMHnsLU/L00EMTiJSAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(52116014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9qMCqlq+ctJZ1MYgOq/3STnEMO+8k9KK0YFQ7Rxbb05MOXoCUnlLO2SJ/7N+?=
 =?us-ascii?Q?WWC64AHz162cgw/pC4llg5aXSdoSbzK5PE11oZ2GPFrN+tmMgrCUne75qGVF?=
 =?us-ascii?Q?TnqfXOz/6utLkwn6gewnto9CO2oIB9D2Dr4oJpfZxpUhkfpP50gODk7JQ+OL?=
 =?us-ascii?Q?J8316QEujqRx8AffedpUSqPM+B2rijdL+5z8tGLUsOL9AS3V4CRDj9+N8oSV?=
 =?us-ascii?Q?v2/plpzazotx8VPDPYy0cwZZxHY1ZZttXUlUj37xJUcUucG8Eugm591QIDcx?=
 =?us-ascii?Q?WUpgf7tP5KVq5h11YhmrPDsmKSFOkCBZMlqaF8gKF0MShAQ/qWYWZO7mFQE5?=
 =?us-ascii?Q?qdtXnLCfXoiXbLyrgg8NwV2MHaWnJdkl718ZhHCTHgNOtqh9fbHnSpL7gMrN?=
 =?us-ascii?Q?yeniGhP+STsibuxGmJr1LGIFHgcwj+UVMxRhSzvQh2oaAweBl/qbtXAFKpbP?=
 =?us-ascii?Q?nLLWxzMJfLQSUd3cWdK9G+Lv3mBfrzBt6CfrUMEhOZhXLOM9YKqfl2Mqi6ub?=
 =?us-ascii?Q?I1E5UK3+NSdgmN83PutLkJVApauNObAbfHmLrnKrXrtRimD1p952IZqZRbls?=
 =?us-ascii?Q?z6Iv6gcAbl+Ix5q36FjF+obiWA44V+KYcyRXl1JCVRRbPgBrtmdI37p1cnAT?=
 =?us-ascii?Q?NDGqWTYf7/0KaWVcbj7vBKiDKvRe9Q1REakqerfw0Z5wvKVr9Fe1wxZRusDT?=
 =?us-ascii?Q?58wJEmkS3ZbLWMg95owpqng6pOr2MO32icEoHARkRWs98nwbZcsyv1GDvfem?=
 =?us-ascii?Q?iN11SyTlVGMtV8VBsrPJqN/Aj4Ah0Rsyq37atk0T08BP83/YCbcfUGgyk6d0?=
 =?us-ascii?Q?adcmFtXFgjihLggzu3zbqp3c+xFHY3IJFsqFx3in06xAvcOEO31lJYagUY/f?=
 =?us-ascii?Q?bnK2v0DbZMg9kcctzAzQRjf0bAc4yvq+XQXjyJfXdimwWPTARYBNcrTOHfj/?=
 =?us-ascii?Q?73iAB9RcFDruMadkchekFpLkCO6fgZDjiDZjxQMOvbOR3k/X7lqXhz0AdEni?=
 =?us-ascii?Q?5DEbDW8yNPQMag7+43100oKkBZYG5GnBT2+ABU2Bs5VkkEr/CyIkrsV57jhM?=
 =?us-ascii?Q?hgn/TVf1Jzjcet6B5jFV4EET59qYJQbnTYTa3DuIHWTwY7rARhq/dZkKHcfi?=
 =?us-ascii?Q?y7tHKjitkqYYycF2bZW1PYEbYJ5gcElvtpX7cI2fJSneJfcWpIpl1uUUYZqj?=
 =?us-ascii?Q?6dV4G4paqUzWp1aeNtcxr9FUZSH0o1C7QVrl7alXtkNOzko68PQmi19t4/hp?=
 =?us-ascii?Q?vguYrDXa6Nn2r39BPbAPTtjVRcQ5/SpsB4Y+Wh7/6aObQ0GcS5Vuclymv6Le?=
 =?us-ascii?Q?i0sClbKpWqta+EMaOdTI7QP444MA0xiMwIDfp1fdKnYnBkphVvuNItZkGZLl?=
 =?us-ascii?Q?/nBV0SKlbvuOzaGO7dnqSvB6TJ1NIg8RS13t/oq/DqPSVulMg4IGxGgvVrjL?=
 =?us-ascii?Q?tUmN4MHsb0ZwoOO2/xytv9eghE4DSxrjb23wHaPREwW6QMiWersLEe2g3yGr?=
 =?us-ascii?Q?COTbal5jiRG9U/ktOtkfg8byDBj2o1Z5hQHrERhlA8ZM+s4Ve/AnBXOO24+B?=
 =?us-ascii?Q?WJ84Q1OYjdMUpGF65uGBGAcu5WIYGPT5IANv87Z23uR42JYexNHVy02mbNzm?=
 =?us-ascii?Q?aC0qicZNgsL28MLogoFI5RAdffoVtHYGh1Oakc2tdCLwtsSnYFU0lWHWc9uo?=
 =?us-ascii?Q?d+h/7CoFxNXBH1OEpZjXl/xnsFs7SEDq/CjtRm7hw73pCR6AQkQUptBDdJnj?=
 =?us-ascii?Q?nWqYimBXgLJjBtVIMeRlArk9Mk6g2Ek=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 426faf2c-bbad-4649-9a8c-08decc318508
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:30:19.3321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8QqWIVTQk29hsBPy1fh7/waW080+9EvWe41V70MGOoUtcwAKB2f2lHk+BdY3F2Tf3DqiKPhNMH/AOgwgSxuqlVGgmT/q+E5LvohGyX2UtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10692
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

