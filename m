Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB00C44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6662784B51;
	Fri,  3 Jul 2026 13:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PRY1ca5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF2684A4C; Fri,  3 Jul 2026 13:58:16 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90C484B48
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INVaqXvC3DIISgJ7uXxZrN1iWdVPI3wmHCCpdXASOw6G7MrDYK+GG+srEIBjJj3Y9vvyCahUyjJR3TGSi4Vh9lOuwhKMwMu5TZo22+68mXQXBUSanNLCqzS3+3uWc2ocBtrB3leOLdzlwR9qDdwz8ZQ4UymVn5Gll0fg1/ju9duIM/ZtI2Za959EGbUD6Mm+8mL2kYEfieHAR2lR3JLl2d+O3cpUsEvKVlSYjog1mesODD5UuRUyeWWa6yX63BHnbdGV04Az5aRy3KC1F4gjae8K1PBHkYm/G+XwGHuT4ZOmXbQturmmyuSTAgni3RpjnS6U6b41JIrxEwY0SIGzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=rLd0QJaV5zKoSILTQNzF8exZCNuO/TOV70a58YWVi3L8mHuXyfNT/l2BCXbogb/EKNEBl6EWrS9Go34Lh9ZUoSsrCpQNCQUO7g7rUIif6UuEtx2adKFFRRV9FvPjLoKrjpN7N6Hvz7w/iJqjJ7py8drak32W6S8yZF3H5qiZhUuTrJVa40r5eTgEnlrOWwQ25WZvZkJpsWTF+p77pnZJI8UbuXERyt65xYjwSF6OgpXsn+EWgPppInzfmmufdoW8qlaTEmru93W5lkubMu6qctDwf8bqMCzwglcF5djPA0iLhrGoZSttCD23PyPgYQlmZC8SwVNQDmXTfLxNPMMn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=PRY1ca5wm6DMKCgRxfE6IGro392u2KDd0nX+uYi5jOmsVa3o818hNtCk69jpYPz4gXhENvkcRcSJEC0wo9xBpCi/GIFPOE8UKA38iM1aYNcn8lusVszhAeojSoWCIPsXmNfFjUHJe2RoKEYExw4Hj1B/syc7C84Cips7BlBjMan743rTBOoybUKMPK0vtFZtuZcWaOaYQY8eCi3HIr0+aJ9xPkyThr6XiywoqubssL0ytEyUmVCvR17QqmA3A9WfpkXnRkko6eY8yQy5X5+dgs0aJ2KYx9mzq2EsvU1TXn75BuWOG+JSUEOc2+vTBiacaLzBdQcwjz36zsZDbkmwBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:46 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:46 +0000
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
Subject: [PATCH v15 23/24] configs: airoha: en7523: enable pinctrl/gpio support
Date: Fri,  3 Jul 2026 14:56:26 +0300
Message-ID: <20260703115627.2317120-24-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: f5dce0ac-a2ce-42ce-026c-08ded8fa4c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: s6X6v5uLl099nRsAs/royuKdynqqFrkaCuyPg7/4CgzH6F87QxfLhJ7CV/YZRA8Fp4WZsQnwLzypcWWbAzMaJSKtUIfsq+CzGhrFa5nb1px+ga7Qzbh/Fvi9rx2BDAVOfblV+rL+1AXXw1XhMMnJxx+mXMpoU/5hcDjcB5o4eYtnG0g/QYW4YWPvc8jHIfurHMQaulLOGrvxHig7p+ouk3aVXf+bpe6+bzmHC+DNG7/KdmImR5vJ+lSUOxBe+X9m3KelZkF/TE8fQYPXij7gcFNy89SJp2JNhcBLnbEM6Tlgw7sNf8duVX48hlOSxk7/7U/iUQfTZ+uXGlyT6WPz5GSHKi5dLZj7k4WfISJfy8xJUC9hfLs9WClkR712nx5fgLQ0bD7s32V3LFYxr0aTdEzmcZVbB97mtpjcTd8XSga4aS2lZ1wsgxTVcRcayXHP4HgrL0dAiDkmjx9opifjkAS/99sS7V2hvxdaQX0UX27Tar5VhgCDepl62mrt8NvZKcm/wbCn4S3UvbuOTyuq5+i97lsDZQsEP5+QksofdVjr8QWMdDJvBYSev3A2TRmBMfa1vMc1UqiFGQ1zy7q8EhPywdTuXItyj8Cjhyhcvu69OGcG85BUxSJBzu2D4kYkRRUL+2zW3kQASyxWNNrk+7L6mpBh1jOXeGgOG8qOY+gHam93dCf9RotKnleN0pKkXWPDByoEz/P/cl2AIHhqk7Khi+Uu/hpJIMV75tdWwnoXZv7wI98YR8F1SlZxwwkk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwmqVfsK6Os8chI2tKvWrpOMPOKK+vHcP489xFBjUBPlSH/pVDOJEzguc56/?=
 =?us-ascii?Q?d3VrYxJKb4MtFsVSDcfvOLNR1q3vAXKaVCVTqGELsARt14WdJvr1DW0zGl24?=
 =?us-ascii?Q?KRG53pnu+a7JhWq1RfXIUzc5XCbJGPYHYWPT71DRhbgYCwT/OiMHvA5XNjOt?=
 =?us-ascii?Q?7amS7fsAZk2QP1p+Zdk7F3wgTyNrONYnwqd0mgdsuH0mtBH3jOW2XEfOcVRk?=
 =?us-ascii?Q?NgN10lSxvDmiY69/2gszbEUF7DSsdNiySoQ3eHi+boBu/hoG/qPG5UF3pmOg?=
 =?us-ascii?Q?1YyF4U+6leFcS/65ESBsA/NtmPsRcvSAnwnNbzG2ZrKG9M6XJTtOWEVhXpuP?=
 =?us-ascii?Q?A5gWKEPa1iyRgcRiFDf2pw/cEgevfIwkNpPJnR489ZTcf9smptAOqyBON9F3?=
 =?us-ascii?Q?u/BftK+YJxZHTMWskmAYlg8hLN/n/Lu05rD5A6VIl0e3SN+nrtbPv/EJKsav?=
 =?us-ascii?Q?sIXAsC2Wd/u+xdJ2inuaAaPiafUmgW1n+aOybXMSs25wuk5E7OO5auqNDgFR?=
 =?us-ascii?Q?3GAgRJZNCWemYho8xIsKzHVCklxnsY9LsatNgz0LKQNtvTRvgdG6hIG7B7A3?=
 =?us-ascii?Q?pok3ZUGRCuRebMNu8622UxHUZq0PzmC9Xe71RUI7E5kd58FUD4PzxDkOpDRI?=
 =?us-ascii?Q?nSg5dQSU+lgJrMUQxE9mv4z5Lae6VB8srTkANjIO2+g+YOkBbckfKx4nDyQI?=
 =?us-ascii?Q?TkeA6RbbQMNDd3/+7+E9mmUEPziuKGFirPb58vmoDO0gfp2bt7WPxj+LoXh5?=
 =?us-ascii?Q?5giLkfHhXRqj+bqAQBh4gTG3/tjGlG98SAHwrtiBD+NNw70b6Z6STShWhYV2?=
 =?us-ascii?Q?9fVoOa4RGl4gVeStZItVZd19JREnEWd13thvse2LgFiK1c0/Wle5WuQf73ez?=
 =?us-ascii?Q?vnNFnruDrAZEBMV15jmu4FSac1+CXLi0Tdq/0cZGtLyayLTV4MoaLls5QA1W?=
 =?us-ascii?Q?oaeIl5UE8oaCItSsci55M7M9Y8bjqo9e8a/zlImBAoufFTpC5oa7xnKZVgFf?=
 =?us-ascii?Q?FTR0KUegWyKVH7Ka8wC0cmgmqIpax6w88Qql33d53J5G1sdJESu1ff57P73L?=
 =?us-ascii?Q?b1veomXcC2vOGyZzk8A4zDwQBvcwZzMki55yIytnLAAz93b7IaZOvEgTB9Ml?=
 =?us-ascii?Q?HlOSaJZoO9AwoJtxjq0tmAhWuTSgPP66QfCcXOE+6KBLlZa8YbchyWyDzR5Q?=
 =?us-ascii?Q?nBe1AXh/Q1WxBuOy7T9XqZ9KordXjk7DcqdkdANsPvJhFIHrR+pNeIaRf8WR?=
 =?us-ascii?Q?NlO6bmfRL95zLbPRpq8N3liqFujEBdgG6G8FlN3+/RT0cZb53yzbJ6Jl+aMK?=
 =?us-ascii?Q?QHSjThNFrSZiqcXxv1Qj8ifQYV3MAcbKSfoy8JCy+eiPOdQm4hT3F69smL3C?=
 =?us-ascii?Q?YffgVvVa0h4si7qpleWh/ka4GVmm5mCmb8hXxWDZ+GDbGJ27aXZnxl/m2MLb?=
 =?us-ascii?Q?lMFnvkIijKAOuLG7L9Ybq1jc1iu4NurHmflkJcpz54n3newEF/CSUwF/XXBT?=
 =?us-ascii?Q?1t8TySNDY8MPiVR85RLk2il9B1yl7emB3ALNxQGQPTnWsQCnULnXlZVm+Fhf?=
 =?us-ascii?Q?xmh3+d5asN+dqmCGTKeFiYi3ZN/838HIUTxE4SS/m53vBpcSxJUibgfDV5Ct?=
 =?us-ascii?Q?ybjmzPZr1dEc/oN3xue6SNIXUa5YIqnE+I5FKXX5uaep50StedRtfUE9WGf9?=
 =?us-ascii?Q?4j8VisdCk/n2nRyh5u9UPvIzkydIeCtI/Dje4jZtckRLV0dOy2Qw/ZPSdA5F?=
 =?us-ascii?Q?/VEBwOZS03NlqJ5mUmIELW/R9McI/Xc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dce0ac-a2ce-42ce-026c-08ded8fa4c44
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:46.7741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQGdW0IdMfHzFFvlH1cj4MbgwNXOe02R72LUZnQ+cEUDtWlVHjKmIImBocT2zyxc0eUk6BhXv+TYMPI0hKVtlZZL7HwzgwRDThDERUfTSXU=
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

This enables EN7523 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 configs/en7523_evb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index d3137a0ae44..8b1f3c71e9b 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -54,7 +54,7 @@ CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

