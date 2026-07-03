Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBF0C43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3DC84B30;
	Fri,  3 Jul 2026 13:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mi8rijyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26D084B1A; Fri,  3 Jul 2026 13:58:14 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C89284ACE
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLQma7JsDgVrvMe3yOjf3iD2oTlCYhX1WDWtHZHO3kq4F5gaGtWUaAVVqs1aMHM5BJ2iWCbcOeDiaLCghWxbul/ECc7xQhmmBOp104d6tUNagEWlNDtNqg25s3wKdW0jixqCri9RqYP1n5NaPmFLD+h1M3XOwTrIHJJRiHI7PFiQ/TPoYIhrqI3YffZzrjhw9dTnnguHxYFvw5FmIq756Atk9UIabNTS3UKLCeBR4tKzR+ZQqici1Nh80suwRvnaePVdpARPP9K599HJeZR0EI1pkxDpqiXMhwwP4C5aAhR42cNwkMcT4cBg/5VYrkG8ZkyLAH0i6NIMsgHvnCQC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=w7k9V+pLnGa1yD8IgalyggCSmehFlcFtoWLJeEmb1EwjecCWouUQ/+hWXqUNwF2UR+mNityYbrVL6YpnwvsRDqGiWMSxb9eG+eMkF+V6gUC5708kKmJ8+49xA/LAzcCw1CXGSFNa78YiWf9It/aNnGLn5R+Nsq6NSSO/1DFyT8CdKRiCkFd4mr/BpI1bg0O0+OxuvT0FDMJS9vA3N+RtHOtTFPwGsTcEN9AVddk7iiocF+KM7d98NasDJxy99P94WQiapR7mOmBtlftWX6W0T+3NjtV8iskeJMOwaVPzKQ0v6k9YfyuC/g2vA0oE5fTZ65iI9+aKk9FkR+64RS2N6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=mi8rijyiI9MI0oy6r/ngS+1NURT3mQb958FXRwWEpcK+rkd3xpM6P1GTHpb+odOKoL2l6TGgDAu6eUqlAtIqLSoAfUVjNkfc7cVHFqOYw58q4qsWeWCxscgKybvuRY1/2nTxd13zj+nuQTs3bH+LB6YaEw2QTeRbO6WAWE9NFh/Tll8r1Sy8Wh7R+H4JZrbjXvyDcbKQ0oEZEqunK0t2bDmYWBza9BR0tWlemMuvU55JfEmJzj5dAY/weHV+wXTvZsF1VKK8wMQe34FRtEvKYvM9niC6R+xKV6QIMw+i0v+q46P6ZU3HfIFEUVioy9S4gumCV4iti49aVFw1UGXA7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:44 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:44 +0000
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
Subject: [PATCH v15 22/24] configs: airoha: an7581: enable pinctrl/gpio support
Date: Fri,  3 Jul 2026 14:56:25 +0300
Message-ID: <20260703115627.2317120-23-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 03eef135-5ed8-4b92-15b7-08ded8fa4a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 6lY9OCwAKarjqcboLNvmyuuRr5N+Od2bOP1LlCoKQjr2nfYHD0pz2Sos0uziEgoyezpLNl+dtP/dD+pNLnnMy6g/whYczr6f4unjZDJQl7B9pkfF9eRq5J3cvBPKK1v+bNJGC6ySOPq2kZprFN6wFg0UWyID7VcawQ9u0riAIRVdI9uev8rCFBcX+TkP2l100UXsPMagXXtp9pjlsnGZU3PFoN3G7hm35S+/Gvd54//l93/Qy8nmaYqGJ2Z2F+4hHAR4iVTmFS0/0j/r4Eyqo1mPDmLiFrs99jK6ovwkfrdotsBKm51ZYsNqPgt4e6nyJukAVBzgKUcdKXzUPRvNzk+JvfskVB1lObOUxd9A9+/mneLhKit4YYJNKMHM23z8Z4tTVgoOwutT/pbpIgUUqMyxnNiJoN9SmsKVkPiFSQZsQt4RpvyJk55nr3yv7DzHIYiQAa1GaviPqsQCc5SYlM5S0/m76wkhXe3d1rRs4EM67yzW9fGOwhjJ2p7wwVLN0YqHuDIY4Zqk/fElx+bKOgOo6PhTTtoT6vagkOJQXSCuNpQssI1iiPPOg0iVLSs7jcQ4K1mLhDJOotBjbTCXGbqJdkSobaPWX54Jo0YEuUl1PmTas7hkXqGRKZ/Ia5324n8vm6BJk2egnqBejIeEEv3e95P9yg+gpWecilOcTXhMDnSwthxZnbDA66llvWfaC0u3KspIUPlIkU/LcHrujbaWEUfysjP4S2h65OMeIvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCdgvZELB2anM2uBfeNX89g/Y/N5+brfJ7oqssSasG46SIc4w+xb1vhrkz9i?=
 =?us-ascii?Q?ZxLgShrJsgPX2oydhzusrkxEObI88DD/oTMgbA7QaaMRkDiRLAlX2UQQyttz?=
 =?us-ascii?Q?t8JRcjKN9e7TV8K3czTQesVbnLP4bpJdFshsri0K6tywlLbZ/S6cDhYSmbL5?=
 =?us-ascii?Q?I8bgh3IlpqODsV9YT2Wh9rG4xwJ/FGQaceJLzzk0rsz2Qd14TYoNaelTdVAO?=
 =?us-ascii?Q?gJUcNRXq7Q7U2m2Hf3E2jKoWKuUlDsQe/yoaT0LEw7A9/+sBUorLrD3NcWtY?=
 =?us-ascii?Q?utpbYQyn+8PzjxLF1uTzh0ruxwqyxKfto7p02wZu2LFXNROFZFhF6z662AG0?=
 =?us-ascii?Q?6nWXbqw1+Wu7pCBsX/F/7P71t9taYI1JTfwLcuM062Erob6PSVKj7x1FHco9?=
 =?us-ascii?Q?voGQiDMMLAM9is6oVYR6jAROn/ShP6wcD6/CTlfPKDMWuLft1GZz2AnkETEv?=
 =?us-ascii?Q?vvui8VxKMXmTaTrNlcFO2gxZvS3MGf+OeT5gbsN8r/roa6K2YcjOJhvFkRl5?=
 =?us-ascii?Q?7HaXNsW3wgMyvFiIPIhwhZWhIAT15Ks2PJarOSnIFKPy5mPQ/yquTFtVGQ3W?=
 =?us-ascii?Q?G/6y5BdUYPm42D5Pgwc/dWJq3wI/glQ0mULhrz73z3SSbe5c383pSoigpmTX?=
 =?us-ascii?Q?GqJpJiJbkM3fVss+5IUgcxu8A9wyROgJChe7CNJQfmBPBpYwpTUtKkxfe9mR?=
 =?us-ascii?Q?cuY69sqJcYCAyrML4s1/GufQ2sHF7osoDyx1ahYagf4tyEmsVaQZgSa/9DwO?=
 =?us-ascii?Q?bLoocgsNykL6eiAwo6ai+24haUcbA3F3xe/zz+abGhXINdVuKDUuUlZbnIi5?=
 =?us-ascii?Q?l/H60PHWObN7GxcLXdOxWvP5b5puKBfZ4SLfpH9S8YSNfJ0jcX4ZVFaqBZ5+?=
 =?us-ascii?Q?7CqILd0vFTSLJkyS4wrw6yQeexDntvI0C6B1hWwHA2W/A4oJSpEBgOHZnyRR?=
 =?us-ascii?Q?guP2hwEYu80a4GMm0NjmmdQV8MaYv4T3BOVvKM3ZnApMQIbhjnQYYQGTi0uM?=
 =?us-ascii?Q?sgV/FktTAlBvdBllfVpyHPkicXabENbfj45uxhhLZml5slsr52EiL67QjgTW?=
 =?us-ascii?Q?wVLLrVu+/QJn4DEUKwnFPD3afCbc2XpTXwa2uujKQlY0TVwmdnrxdXlJT5pc?=
 =?us-ascii?Q?8uL/q7Il0UbXuKOEl4q9QIvjXew0+rJ1/NWCA+3xiywGQNFB6P0J93lagOpz?=
 =?us-ascii?Q?DpscUBhszTC4CVzYczRkIqHFOVsEzOjVvElCSNzPZ89mxxFqDE2sVTfnmxow?=
 =?us-ascii?Q?M48W5vAicHvjpi4YdycbNV7oi8zi3nYLPJIVHJ6LObWBLkEU6uf4L4OsYFFw?=
 =?us-ascii?Q?YQyDeOp1P7e6d+uYDV3Lfy/6s7K7f81cMDU6XE4P4W2Vl5GIkBpfVnM+lPXZ?=
 =?us-ascii?Q?fCxXB6gjHOe1rmVqdUVv0m1J+FSBSyi+9e+54I9g+/X5nlMFWds3N4R5Uxzo?=
 =?us-ascii?Q?SnmjyMie3IU5xmNm9mT8SLYzVmIOPJNdYth4r3uA3yW7YydkQIR2hBY/of/f?=
 =?us-ascii?Q?biQo0Y8nOZ0dZ6DkMwzsilcXk9+OsqKm21CVfaAOVxKIvmS1DwMgTJSYOvSO?=
 =?us-ascii?Q?Ov0s/x1t4NHIGcT2+5ea3u6q5Wgcf2/2CU7MZEecoloNo40hEyjqy56VDmV7?=
 =?us-ascii?Q?wFqiSgneIUSPIP2QBCDgPnRPNUfNm/vDQaJRhof+GBm4Sk9TR+yKtZ36BlH5?=
 =?us-ascii?Q?FM0bGOK2RHgHCDeGZyLm0OAJfD0tp8TTZxrmUC6SKX2DxkpzxFHEO9entVyq?=
 =?us-ascii?Q?W7JnLNOJJ5Mv+XgBSu7SKSw+wtlFMfE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 03eef135-5ed8-4b92-15b7-08ded8fa4a9c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:44.0227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnHPgPtx74o6YGQ5SmC6lfoV6Xods7qsBB2l9tFSuO5WXJ3WDRBpYXgdNaViATH3dv4US6RsUGC7ujTzHhvJfLKNEh7bn7M8+vwy5J2+tp4=
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

