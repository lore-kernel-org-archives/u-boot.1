Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894AACD5BC9
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F09D84972;
	Tue, 26 May 2026 02:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zNDIv3q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE6F84988; Tue, 26 May 2026 02:26:25 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3686784970
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2oQQfenHpaNgPO/J8O8ivapR4kU4cVLT9B2RlkTRYRvBoJl4T6vSbRqNaPm6+1VD23mau7Qqp6wyAzardlypekCAr2sDjUaoUCHd2/fXxb/eyWDy6+xrHvwaSW+WcZavrtdcPa9wAeW4Dh8W3FKqrKMDrtZbveSIQSbx+siVOfqCTCVoMIbfBfxZIFXgb2tVvZFTy9Cea4bb7URYk7Wxg0O0tl3az2O/iIt4+27X/ie7TGfBGBcPdQh3PSrKy8eyJ7bN6CZbFhlIRbHaxfpzy6QjS6v07V+8iE2FQ0g/MSK6jFQrwvWofF65l2W46rWnfe5YweEwWWU43q5pMsLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=CryUupKaQ4YmQagxJgdykhZrqS/fW/rV365rQ1UPWFp9jlY3EDiu4CsRNOQK4Hl71nkSqpof/IDiLc9h2ED2ca/8upViFaa382+l0MYQ5aGiLvrSOq9StoPdrxPPHTyj6oH8DKI8MPswaLiSPerLIoVszChtDhhAJ7gt7lI14NyRAU7JBnpzjcT9f7XEklfN6qQbj5oE9nIUrY1fuM1S54NDva0McXnbGbO8mAdUE9k4Krg2cjZWoF4OG5y2SHbbgmWWn5VGHLgDMT6VjqDOlheOhUaK82KvwHqPaYCOhgZFTE5ucXZLuyXfsyRUBLniH9Y+1RWl5Qcpy6HTgCTa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=zNDIv3q6wpy325B2Cn9kH6XHDB62mkolR2y1MI5AdQnDkN2H6gf/JHJA655tykWTiK6Fd0etvGso3/ou4ZYqXFE6Z3m62zFduZsDWBAG0si0Mkpzb/rdkpjQjwDuqtg/CmRCfIpA9sYWrYC7tEo+AcBo/y0hS5TPL5yTVllCVV15ihnXDTi/CmFo9cFHps/DuGvvJ+qm+1eMBjWhiGRlcEbjaArN4vhhI/l2FkaxjHZ2g1vfyLxCwTLJE7HOFDTfUzzGSSs8cWCseEMuGDWa+YvUGDuTTH5I0eAb4tAvbEiQrJ30J6QFMnUuPiHKT9YunPMyhO2zG6fGH3UJZhPatw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:26:19 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:26:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v10 10/12] configs: airoha: an7581: enable pinctrl/gpio support
Date: Tue, 26 May 2026 03:25:32 +0300
Message-ID: <20260526002534.898340-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: a1aad85e-c7af-47c5-e28d-08debabd6853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: V9Fc4QEea369v5dG4pstBUSU/BK6p24WN6S8gF3DZf5gpWY08Hzkqai03IULnxxNgJ3KDrx8qapvu98gQ45a6+M7LpmfU9ljGOj1Ue9w1FV3NvsntuLlxDUIoS5l0aPXpoZbcDsWHqYa7VzYnEvyebyTXVvofT1/OGQATERu19C2+ka86JKWHW/nLTqH9zIaRtyBzaDQE/WIvvWdHJcg9v8Olr0BybzjL79TCodZWsFQnl0u0ImobqO0+/fSRbOJvLLwRLrs3uxeic92lh/j9o+KtYBx3U1y4XRnTpDJcA4Vq1RjoYQ/8UPmCFPmcDnGUZVTXEkQ6yMBSaDpjsWWWgBLKZmVzCnnE1740EecnYxLW3HXVdX5KkoovgLn0kwk6iERSvsWoE3HsvBLMHv5fQo9Joz3sFcrNJuiAcOHOXs1N+dRfV3kSWg2iMyuCYgw9Ue0J5Tfv2UtQukk/BYkrVC2gwQ6FGu/IEnhEzeJ70oOBj2iZV+XQb15jSFbqGHI5TGI0ileBCZ8Ct1sXKR3KXm806CG69hR8di4KY7by5tUbqzg5XBVE1wcIui25eIvZVtrMWsYBhDXYnwepIe2aL3xjDttXXs1jT0RCSfmK1sVxpckmKIjJkTpwqn33/DYGDTF39+6Vf5G/nD3IAZuyYlmeZEQVmOP9THvyL8OmpsPcGKQ7vnOlnMnkB+EVEnkSNOtVgMuJS0z336EUAbQV3K5uy50KRi/js2UsbxxF1kO86eiu6/tdcAliO209AxH3kmVKxOJSONHpY9uC4aYxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tc/y6++qHVp+z18hOPgVX4YuXN+sg5ZHxhIsf3GyhAazzT9Rgx4kZHMnH6vA?=
 =?us-ascii?Q?HW7zRabyz1kFgmOX5l7btShEsrMAWFscdLAo/IdxcccY5MqQbx7EeVu/Yhpm?=
 =?us-ascii?Q?0my5bPaTh8PZUkuV6ryDD75TBrEJZrNGwkIZ2xjBlxpvBrV820EsbV6kNEwC?=
 =?us-ascii?Q?pc3l3ldKLLNGL0mrI52fgcAcguNPrCs43wOjBooudY5DT5re6kXfz1wnCio2?=
 =?us-ascii?Q?TgKbdicn1osHMTEGoJICtehlorNzISpx/6h4JfQCpSNYztrRkBjPh+RDNe5k?=
 =?us-ascii?Q?f/hH7e/RxylztWeQbuBWuXMNHumbvnpNsStd6Nxk/Az59839xL59TLQvPDpK?=
 =?us-ascii?Q?4RxPeYy2deBu2hdsymJv1Zvz+TqichGINWa49k5smPGnLCbSogrSHHi6kISF?=
 =?us-ascii?Q?pkvuOjZeFIA8pMR+a+4Tgr3eU5KcMhriYrlKCQEFHJcq3HAJnx+T4jtuReut?=
 =?us-ascii?Q?r6p/0CP12pvk0n4QGoIFipaIBGIRL0By/ABnkXalApxnBZW9RuBX/MSAJglj?=
 =?us-ascii?Q?aqewfiAA6/LuczCYW9cDlShawLQuwfmxF2c93qcQ0Fjn1ieXr3Rhr0AUYQMu?=
 =?us-ascii?Q?GpM/zOc3HXotREi4sD9da7/Jh892yy0GOIBzohw4hGOOgakc2VaRcMq3abAR?=
 =?us-ascii?Q?ymc2Q6uZ5qGORIRlqu7nQgkQiaw6Qz4U0iGHmVJaV2yD+hkbTNhJemKZqNtl?=
 =?us-ascii?Q?1XCRolcfk+NvUL1KeNYbOI6AoxaH+mqe6xBSRnMse4lonkEii84Y39dSb8WK?=
 =?us-ascii?Q?+1W3kecPigBVLToAHXJ0wMbUCx3ZwNJ+6XZTD/sbgg5Wkwva/J1l/3yc90rM?=
 =?us-ascii?Q?ARqz4c9sp3/X/UENX1W6zuhKuiDxyOU2GjTgDt8Yn5MkJNbmpc6Aht5sa/z8?=
 =?us-ascii?Q?mAE80PAxevAlHTFvvGGkEfrdvqmY/D3bctXS9meJjd40ETjmoCHmO6BLstI8?=
 =?us-ascii?Q?slHx1/QUgSjeu4ySNNv3dPK86iMxven5xeWY8ELpFXf2DVTuE5MORrUIDRXq?=
 =?us-ascii?Q?4Iu/CcU+tixMACLkA/CPhVLKzwesn3TcEP4guicb0YwBeMCVcxbHBLPmd/Ym?=
 =?us-ascii?Q?Thbk9OutyC4/cGRYjv86tr4BoqyvZcHpX3hPlQrmQs2ABEUqtieUX6D07kDs?=
 =?us-ascii?Q?O5c0ex4U4QRchy0W3dm9lDrHjY5uc8kNqikwSNEO3WgnHOFkUJ9g4o+FHD3o?=
 =?us-ascii?Q?L7BMgfYRoeOt8/u4U56n42MVU6qgKnZe4dab3agIXXvJwmEHB/ad1xk1eGvY?=
 =?us-ascii?Q?RXmgWz+h32WbW6C5PYc7iFrJTgiq2EefYqqhvNu8lH+dzPoOE1wcenCnr9JK?=
 =?us-ascii?Q?GNO4latqks16H2nyacyzYQeBBxUzvROaHftw1N73JpZ8hWU7C4aLULbSX/hS?=
 =?us-ascii?Q?hoY545dEfn2Tbm1hM4GrIRnerkWJZg+myv7wAFb4iyqAHXIsfdznuJVIoZrW?=
 =?us-ascii?Q?b7h3EuRoEcA2uT+lnjwXsM1ZQ0PRug8NKcJ8BU5Kz1GqU+IPXxKXbeAmexvZ?=
 =?us-ascii?Q?Gb6wbmXzXfLHalVseS+i1Pj7VIm6vmsNWrDMpYHaZceHAoh9OfXYw6raX8Fu?=
 =?us-ascii?Q?wOnUM/Zuwp1U7kWuxTf3pZLmjEbsch7ZU4lW8D0Q3y9nVwVGtM+yUWHbPyfQ?=
 =?us-ascii?Q?8bOFYhMybAOwZAbtTBWmuRpouyMZ954wb31p4TtJajtip9BPH3hSv1L794Up?=
 =?us-ascii?Q?KdQmudExN4BLUEx7w+jo8zQ6FDoW85KFraklGInGuM3KkMQPLn1/3DmA3PjX?=
 =?us-ascii?Q?8g/Vd5PC5BtzsfLfUSvY4QChjdrrVvQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aad85e-c7af-47c5-e28d-08debabd6853
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:26:19.6771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /R4GBgMrEuHFqExwUuaiDoN72GowAeiZwFFW0gzwbZZBkDO1k0aYA7DGFDfIxJE3dptJutrgscvsJzDPDOYezKhWRCJCcxQeC4dcDlcD0Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7682
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

