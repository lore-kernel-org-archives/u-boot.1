Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1214AFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE66584150;
	Tue, 28 Apr 2026 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6I7d6YL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 342758426E; Tue, 28 Apr 2026 17:35:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809308426E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPG8h+LxiVOqpDuTn1W8K5OZlWkfD/D3f8161+CSkmasxBBVn3y2SroepY3uEPjuccpgZ2SfIcaBE+5XS/0PF2Zv3QCdpjg+eA4ai1rSUbEVrdy7GEqRQcsC+4dr1J7VtTaMjR27umH3gA6nCi8YXPxZQjH8UIUQbh0SlitNzzFyaQxeNG11nmE3lC1rGanP77Z/X0saZheL3F9e24/fXfLDNfHUNEbUoOmKeFxUpiWAfySCRlqQ9wa+u+VKzwDmC5WTt19lazBSqdujZfWwINk2y6rUCCgdmBYl4/VLGRzOxAqZnDKWuc1c1r9ErMotfyiQQqIpAo2nvfAy181q5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PlJfiA/Ji2ishvK9EtTgy+Y1nBgWMj7pkNHXzaOmVw=;
 b=osag/oHb4rtevLrDmkq7TBu9wlUYP3W5hHJzRvO3LJH8ZQVGZrHjP2zzDPLZjYBivbqifBtVM2f9rdtD2MQeAPD9Do3HSAb3BBWtos/Ac+tC1QysLoXAGS0oIFCz9aLQF4rmQ2rAEt2hwn2LWcSPl/Iq3OhEP3myXg+y439uvFJto3rQlpA7xIK/OkmZP1MHdtddmrVEX76yRFbQgquBwBC1KGTvCiyu3itagbLPlmTQEeQmVbjjzLq7CP71gX8kFCgFxqnjN43SDgb17TYN5R3dahueDcEqag8QKZCZwtk5fAn2wLEIUHEDJyDVwPs1US/lTXZToic3Wza/UkjbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PlJfiA/Ji2ishvK9EtTgy+Y1nBgWMj7pkNHXzaOmVw=;
 b=6I7d6YL58fe1O3moyWcn2nFsAbpQwk1RGImBlgdgWF+1l18xCIGzwcWCl9D5T+BHUlJJPKXz5DBFZ1+yd2pXOf7LuTut/ttwXsCuJYhg01Kfephc7m4Ps/BRelQP/QhgyK0pLVuIxVn0mLwHyqK/MUVHAvSmdQjwdSeKrf+Z0fakzdKN1kU1CXe6+T7KGWT8Pprhm9P1J59kLWKnnvceIjvp85bKlYt1LdIq7hPafVn0P55iAQgEzpa5QjvksLdLS4JZjGcZuzhZld47NUyFZRuw//+lV9Ex6IyZwtK/3gaLTrLFIoxcGR8BPgNJiqGImt32peraJUX5EcsA3CQeSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAXPR08MB6720.eurprd08.prod.outlook.com (2603:10a6:102:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 15:35:03 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 15:35:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 David Lechner <dlechner@baylibre.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 5/6] configs: airoha: an7581: enable pinctrl/gpio support
Date: Tue, 28 Apr 2026 18:34:47 +0300
Message-ID: <20260428153448.980150-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAXPR08MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a165a8-26ff-4f3c-f83f-08dea53bb795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Af7BGn52oew3jJMlC67cPwJ128SK1MW3zHZfBh8tU0e95RuGwFPaJgW9Uhp1Mm3FtsTuydAyA4tun0qrgfYjtP5vHCZWaeuaPQr/k7qKo5yRwk2I2/M/1QdDV11omBr55q0zjbbn5+qgRR1qnQNdT+hvfugv/zY4ehn3w5tba4n2xLdsQ4zjXstr1fPDXAbD5yTR8jjTGWP1ciiof6IFrljeR4JBWtsWFLSmNnPhCZ2xMW5Ipp5d7ZsSZhAKc9nBq2LBsEpcdV/EqbXqS6W/1eaKWYlaNXqVQjb5r266jn61XcF3xZSZ6Dm5PlXLwf3bhk0HMV/5MFe8cIH2QEYmGXI1ixborUv4hWQh/nOR3AZ5MEXVGvy4j1KocOF327egx0WwfT29Peb+r23aQ7l75OwTiXhagkry63qNk97qm+EuyuxiWvE+CEpnhq+Z/uGe/wSgSbPwLxXcbWvtJj+Rn1TSDt1lUU36sB1UrA8ju5Efc7sn+yHpRN60xFhwPALpI1+A/K+MhempUlGu2In59Ge9Ht8zBGtWlkdGMsN2e8NnRyAly61sbelXzUz1ZcBaK0CKO4UVEQEGYSzXnDw0ngbj1625+P9N1vmK9eQ3TAXRZCimyS34HflzQG51HLzkueO2qVWqyA7yl6j4OMLeWGxJB6zBRXZgLy0cyv8amW6RdiDUj0pg5nxUfgKS+kpxh59F7OF1sfSoC45j8G5tug4eyUtlG1Fiv8gVHN1+GTXevX75McEESZ21+xcVMfkZ5PbYvSh/BGMw6EuTuTvMIgMFRT0n1a0XtqGe6oTbJo6fSzp3ynEuRKzo1KM35F0l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RLf3DcZ5NJBZyIA47o+ZDikpxH86BU3ME6ybg6snG+mxg7stmmPjmgxKahnm?=
 =?us-ascii?Q?gSnjnCQtndXby9cRB6HHfq27P7I0KGemMexybsgvvbj8pgaD1fjfdlnHtURi?=
 =?us-ascii?Q?LT0FDlO4++a80MQFaytAIki8E7IZhXpFL+lJk8hWpSBXkHhElZp9+4ct/8rL?=
 =?us-ascii?Q?SjC6HVsD+51zX9iTBFfL3l+aOX+N1YK8Cw5/bF5SsXw+RUvYIOgqINEIsx50?=
 =?us-ascii?Q?aWjU9ZyeJN30NYN+GSwkx8Hr1XFWGwH9F8fbmw0z9RJ96VFQ281Y0Wd6CfzN?=
 =?us-ascii?Q?lLgshlzfzCG9OPqP5CHmrKhpWrjgqNbxqJTOi7iLrztRAz2tYIJqQzxD9i5m?=
 =?us-ascii?Q?proWT3gXqLdLBrxDE1uDtHLRWpWBeuPgv0Ey1nnUqNMTwrT3pqxodmFzY7yI?=
 =?us-ascii?Q?rXPteHJtkzkYaoYYW1BdjXnGrq3PY8bosy/fXC89xXRYVoM/gfNr85Q+ueUQ?=
 =?us-ascii?Q?KIMudPjkeDBwLcBDFzxWL/bIak4XOuSY1FB8Ho8HznQiftWrv/RZ6q7mUwrV?=
 =?us-ascii?Q?oB8nVabdqEJ94caOflzppQAaXK3pBmT7u2wTZajv6+P5Pu0t2WYM9nc2QA1Z?=
 =?us-ascii?Q?WzfQzn+7X2L9lB7mYcHxvmx5X+hebFmqji7cETNaNuP+WgrCwgs62vSyQPY9?=
 =?us-ascii?Q?Teb5D3Q73h8WOmlerRnG06JHInzLUZh5um4yS/7RnG4Jks2ZejPkNGrWgT1Z?=
 =?us-ascii?Q?TN6pAFnjogzrhKH990DlzXEmS+kTcsJrkIP21iYlJRKu7xF1JMEiILaNRkug?=
 =?us-ascii?Q?cns4NmhoQiLPyQ7/y6jJiYwk45Yzz7zIS9U994dGIpdeHaau/PEEUgl3heBL?=
 =?us-ascii?Q?asYAcsgTbsHTSePZYQvU8dfj3uVw85mTOinAGSoObB4F5LWFakjWaH6v9/0F?=
 =?us-ascii?Q?DE9KluxGV6hXWJHTxzFVuKkc+zJuBZPhyr6A/GqYPd6MvJrES/DE0j6qxbHJ?=
 =?us-ascii?Q?0Q579kJYHNDTwTGY2ljd1bFn6XoKMiHYiR7JHLgIk5v+5G3Skv/MIRZZ59Nk?=
 =?us-ascii?Q?l5SqwH5qkVuBWJW7Y0oD9eA2TMxmokJeuucgGm9uXLnEgfPL2HLd3mBP/YGF?=
 =?us-ascii?Q?YZwVLeTlIDUeU6LJZwnhcm3L+QX0hPGzn6VAkIfAZfVBnorup3Hf+dzOeCz+?=
 =?us-ascii?Q?EjZZmt9K1ae0Q+FzFP5RuFl3Voh+QEgGYf4tY5I8T/4t4exkKE6C0WhoeekK?=
 =?us-ascii?Q?fXjRovKmhNv6zv65arjrQbiyrTrQDWhBk+K5EKB3JF+bTeL0z1HZzkIPocKS?=
 =?us-ascii?Q?3dyn+J1U6S8hs1A7VIIiO2B4a0XH4B7vAdS/Sbr4I5C82TtL9M5u03nEBP3v?=
 =?us-ascii?Q?0ssb2q7QJCsQkq6LG8xpt/8VyvqZturO2KqpUCYA2nuVPOzJdHoVHU9TYoQF?=
 =?us-ascii?Q?6On+EGcjTv4rdcrcsb5xfYRDKhxLGmRWJaiFem3Klqad51bCpZfbCZ+E2II/?=
 =?us-ascii?Q?oR5p6ZuAngefBouNgbGHKvOANx4PrmVbRY/kfrqIZHDpAjM8sFrE2xeI0Hjl?=
 =?us-ascii?Q?LnOwTPwn8uaTHfxG2rE1wQ31pkmz6otQ5DxJeoaIu53CAQhiXWVYEYa8MIY4?=
 =?us-ascii?Q?maHWZBulGONH/0R8QkhUeMYnCT0nBW67aZdaWBsQGja5N6QDPGIf7bPcIDMH?=
 =?us-ascii?Q?Z1jygQrWsTWa9qWJmI4I9gxgTER5/ksW68MAu1QT5r8MnbHdQ9SwE8DnSeiV?=
 =?us-ascii?Q?VW4ukhxX7cZzr/vrXlUqMBsYq1gBO3KFNlidlF5FEV0DHNVJ0xYq6P2IGSgr?=
 =?us-ascii?Q?Lgp1A8lodY2PD0H64yfRF0SPjfNnBvs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a165a8-26ff-4f3c-f83f-08dea53bb795
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:35:03.6754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27oBullef/VKM8rHGkgEwES8swqaFIv0hXjwO0MaXddD+OphqYZliCObzoKmTuSAoDjJMK8geQhSjS7fEM348GF3H1WIJ9FlMG5sFZdOZmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6720
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index a94730cf564..e50216babb5 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -73,6 +73,7 @@ CONFIG_PHYLIB=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_AN7581=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.53.0

