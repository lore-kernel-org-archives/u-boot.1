Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC1ACD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB28C846FA;
	Thu, 14 May 2026 04:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DgQy330L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AFEE846FA; Thu, 14 May 2026 04:56:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15FD846D3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFignCq6F+9F8ZWQs0mpyytSCKPiO3r4U3qJ5kOW0TwTq+pDwXVpEPeWIH72cQnnz0SSiRWdyf5M8vy7rO481I/TyA7yGCWA4xiEIEBzmjj486F6A0iVF2g7bRQpp0Pw+7m9GYDh4KtO16nIcPJBbxDMKWUCP5bJNvMuuinQelSn2w2ynFs67gfQAYL/40GukSTBq7CGeVuQPcZ4MtOOQHz2kE3XNlIvWYojkNmA+RBFjguNuDfmBVappHILI16tWrY+Mrdi3wQMkN8Da3Hd+XrDmaD6owU1JyOqENnbEYF02HlPkutMNUZD0t2Nl3IG6lLN/h1vxPupH3BLQJWFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=slF2g7GvgWMb7xVp9uGyZ9X7SDYr603puCgI+jA5OYPhohrJLABfw69vc8Xy37EAOKKfmCx6rWL9ZtRjJE67jXQTvBeli0SNggNGMmMnvb4cbSv1VRi9nBhtsB/6Q9JeK2IL1OkZYtfNds6nPfAxQIyf7mLnDfDQALTdf38agRh3GV+4j3vgJr9k3KY5UUoEarqwdJvesx0pXyji8OR9ZnpP5Tdx5djBFsIxze5BdZIONaxUPuY2Rxy9I+R2n6q9r3Bx+ixcRdHXYcVYUQfzUGiiAMzIG85o0VW2+bAQFC/eMIl4O3znuC7EY+CCKWzN2Ub+0Ga8y7yB7Ufx4XvwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=DgQy330LTQ9/Br2e/UjR3ROgF4qLjGGITWqHHWHUade70ERgBjpN2F+A7biQheVLO22ZmVE12b+UKoLVmIzPO2btnQcud3jX/lLJ1iuXpjkNLg2Zxf3BsokOkgc01RvPUaKF0fhmWSRm3DSS8GIeZCywUJ1uwsWIkRIfz71kUbSxvg9Af/vU/ijn6PkkSe+T8TPxQcQzOMRpdaKeGuBhej6Jg0ITJNsGpa96fUbBhdHEF+9IPay4CPcm6qASu01yY+dmhgUNKVJyfMf9VZY4jxENhnTXMD3APn9pU60abtC6lEs+nvge6i8NFSnliQ7oim9Qrr6CY8TQLAdFxpXLqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:56:18 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:56:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 11/12] configs: airoha: en7523: enable pinctrl/gpio support
Date: Thu, 14 May 2026 05:55:41 +0300
Message-ID: <20260514025542.398469-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: be57cff6-0b5c-487e-8da1-08deb1645ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: CwVugVInRdrURE3+ETlnjoWbEk+diOb9TH8py8pjCFIljInXYeVGVKbNRfB+TajYkgftPTGp+bj71tbcE7uLqif8zkRc4O9b8yZ7J8JgSb4ethrsxJsHmWjaeP4FOoH40ofDqUoY0vBR9q4NgOxFKWwCs/ZGvmPOIDoWnsGmqz5kUDti6zDe0SqKaa4S3dhQeXHYCSER/LDxHA75jBxUIZ94tRU1mMbTXk0Y6TDfsc4I9VHUE5YR9xsB2JoLym2cVNz5PRdQX5uw8fLcxG9zgPaeCNnBFXbAOl35kFupnvlFywCjYwPgLRYX4X3p7Spd7aeIxvhiFrArVvCehHk2T9fTuADa5k2ipi8jueFBraHyqgSmasafObLx3f4VOfISdgCwnbsgJ+0QXtuq+cBJtrP6Lzw3d+U7VTnWHo9ULiel5lFCuiJO5wLr0Eknq4dq5ID2ZlnCnE7RY4D9NzpVLvuROXviDe5Lbi9FiSlMPr4bNHs5DCOyrvfrWXJoGKb0i0VmRChF4nZcZQ+21ZTPB3SJqQT741fgSNklWAlPYpej44knn9ys8VBxPM56Ig1m+EcOL6oeeMsr4o/IbnsWON0sav3FkFDnnaI3l923Vs+3Y4D+s4Y24jgFtjlDNyB3YTd2rqf0f72qAy5f4J5CIfo5S7w9rKSqqec2Bf2w+FSepNedBzb2jEsu3f7+lg8QYgE6SaLJ1LsrIdyW04MXhPSa+GM7PpOYzx13JUzj0pZojpEK2Dgjl+PKy7u3TuGav/EQLicIwNXs11ZjUiph9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xkvETr0+SbmqoeYT6Solqc8vEoStOek+YGL3isyPltDI89F8BoP3R/X52Knl?=
 =?us-ascii?Q?+RrxsNH8ZCv9kYC16IeLakJyPCffkxN+DVaSDuBMyg950v83QCPauofDNLzH?=
 =?us-ascii?Q?tgrdEtXhgxvyPoRV3xQOKAUhglVgFwqMshzxhoiVCycQZhSz0c5P7vI13XgN?=
 =?us-ascii?Q?33r0Fz2+TGmmmjubty1pveclGY9sC5SCV7j6LnfW4XN4ripqI7tCj4JUxPfi?=
 =?us-ascii?Q?aul22SF9MpPIg+wY0+nx0ROlOgY1SdTqjtDZKNwSLaiGnrJvjWGnT93Lf8gc?=
 =?us-ascii?Q?HMGPYxRhskXvuaKwMi3f56ehAUiP7V15fgf7aXo/tYlsibIBeThSD7exPMHC?=
 =?us-ascii?Q?KT/oA9eoS4t9geKhfjVenDrzcUV7WDSlv0IpgHz59YYSQozkeZn3o8mhkERM?=
 =?us-ascii?Q?oZcaXz39kFaUXEDjzJ0WHDNqTEsOTlwjJVwm1ATUAUjl6A47/fAb1+zEYt3F?=
 =?us-ascii?Q?t84DXz3wOE6SyBfDAzm1g9jMwjKqsf5hOKKYrlX4Lk71OSZA7PKUQXMq0qhl?=
 =?us-ascii?Q?YiL7ImTNZsZFwZOhaAJdl/SnNd9n18U0ER4jKKAi5G8Agez3Rs+EKQOZzyZy?=
 =?us-ascii?Q?VhkPwBbVOgzCQiX5ej0TCePZZDGA/U5VHxpl1PSJheDCuBpNIhn+ICVIkANH?=
 =?us-ascii?Q?MXwuxufj0KRSIfQ+74gD6i+Y5JKCN/QV+iMf9pq0tNnBJarwxA1YzwWtws70?=
 =?us-ascii?Q?fyW08ox0RU0hRo3AOp6hShRzT6IqyUXSfRolVS7y9do044p8xAzN1niThXnc?=
 =?us-ascii?Q?ehTYjodejefRN0dDLCTL/1ayPVtF3HKlGoh7w+GvCoXmnfr5WJfa+X1JN/Oi?=
 =?us-ascii?Q?sN5ERu8OYdUR/MrVr05QOIGfvnoTowczNlbEPownpjjSDtlo4tDcW40eaGOU?=
 =?us-ascii?Q?W91ULXU31/mD/AFwqYNYzemWjoD0RmsuJWlIgZtY12nOM7lbJJcJ/c20gqUI?=
 =?us-ascii?Q?M/lBor58xb6h0LF4ISu/eAL0ngJgoXe5j2UYvR8T3Dz3Zc97uUlE5BomPoYy?=
 =?us-ascii?Q?zLCOBgYssC1VMxZnHDI4KPZfxp+RPD1ezafpJbs5EZVckmm0R5Uek+aad6gj?=
 =?us-ascii?Q?zyyzWjN/nXHfiezeti7BjeLKQkS3Fe1/UgHFZ2i7UBe+y18DgccS+byX4gv0?=
 =?us-ascii?Q?OJ//UfgiV9HU87/nZhHk6ZZGvECtCBl+uIsWhWc2su9ZsbbFKLci0hkbFRfH?=
 =?us-ascii?Q?MsPgM2F1nLZG1F6QWkNnn9tgXG0k4mN3khC8Nhvvr9iKH+SmSBMSLyzmP/gm?=
 =?us-ascii?Q?X8HT1DUaOc/2jj2Hs6pCZeVAHScGwJezRkVtT3QZK7mEZy+AiFGSLw0S4ano?=
 =?us-ascii?Q?mCumEWiY7/fSNNQf6QEMdyGoO0JTKwS+dJEnUTBjg1TdgFWK1CkiXxBLTas7?=
 =?us-ascii?Q?HW3MO7GlbGsDhmce+AuadZQN87hYLSnKeuPdGt5wJiiXCTveXX0nqtWAIph5?=
 =?us-ascii?Q?9CqCzzUJbivy+DxI0z0z9+c1CbdIqshY9V9wkoL9YrGRWifSmjWeG3GOBcjF?=
 =?us-ascii?Q?6bFvD4APmn1GGY8LhtQs2rsXfOL4DXbNeXeUgTKsLSEv6df7cq4fNFTowUF/?=
 =?us-ascii?Q?gf+sMQljy03GmyWEqa/uncbbYZ2Qn5VaHWd3SXG5GZ4xHGT2dajicbC0yVxV?=
 =?us-ascii?Q?wjXYpaz90BmzDie+5J1RchjXS1g2M8kbWOB4l9S7YPKE/y74GU3ExN2vQUbm?=
 =?us-ascii?Q?84xYs+B1/Aw5HaDgTsdTkOY7X1zxoPnaFCfbY2YQIqlzurSTD6zi674gvgwP?=
 =?us-ascii?Q?3nuFnRdInzsywMxije8KmD2pGiEk3hU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: be57cff6-0b5c-487e-8da1-08deb1645ed7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:56:18.0613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pby0XDerxizTJiNtMhljt9G2YFAgxz67d46Ra6TeKhG4Y4GiHsKdUxk8QN9W7n3aEMhXsxBThAhvglRcl82B2OTndLlHuldJ6jNjZU/V9dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786
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

