Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F84CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6432383EF9;
	Wed, 13 May 2026 10:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xDVFyucI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A65283FB0; Wed, 13 May 2026 10:08:54 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5858E83EEF
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgKkEPHy26TzvbygrT9y+jBCvqKDU5E9sHeK7ypHN5k3gZ90oE+bqNhkecrq7dJvWnIDwUYBrvkbMx3jDWDwTxxVvZZThQ+5f7jRufx+WrHzcnqH6eIiwZeQ2AUVOnHEEFTMPjUZDkQ42dPhwjBYsr+YWe6VxZ6IlYrVTNZ8l8ed7ULFGTyLtm0P709EDwxm3radRjXiObLwVBzVNAX5/ovX3ev37BcPlVosTbXf3GK0WwET+bjkwn5JGH905Nx6J3CUG8QnIb8wY/BaYx3LbONtDi9bhER7bEF+NZw2ZIN818hdQ39aOtx3oZ7oFecPwbJVx43bSyoNtsuqgPbxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHfgsHNv9iNsNmmRfZoCU8tga84By4x+nU3fcYtGIyM=;
 b=abY0quz7onO4TGIUbVKNgT+QdpdwsUebV7OgxN2AhoodHt62j0EygXF/YPJDG3Is1woFeXxsDoQ9lIUPdvY3bovYa1Dxf0tSTcBUqOQjD/LKafWHn6T5h2duGa1zWztDS8qtQwpfUQrIxGZIxjcIg3Xbquz2alu1mxqIEW2EKwO1PHQV9jBduI6LaGY0ZRz4BbbCC51OXB7EvqEGJqc/haFn80b6XwJjJvZ4ZMxVLWi6kXVH+dMP7wFToazzVuGgP+/iZ9hRHwBDxDf3NA1BnArQsr+nvIYrYXaiVM6nhtvwxyWQhOOtRARHPCKN8HZDjGY5aRjrUWP1h7eSQMOcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHfgsHNv9iNsNmmRfZoCU8tga84By4x+nU3fcYtGIyM=;
 b=xDVFyucIWrhspm++QvslHlzGm+rGpDaHkrkSLp2RTMkVE4IpyO4CZ3Fty2WKtURGu7PPuo43kYKLFUULgoBgfVWX6l/eDdumbjG/vFbCbAlkWFoCm9M3goZDWp2+4sm1hMVBN2JDoAKgB+P3mYQmbjusPDsrf3Ek44wQ568eCs6+CSFooVBWUvkPj6sb/mowFiQoOY3hNn4e6wd1h08IpA01kISgM8d7YIiK0tr0yc6BzxoWHIJnKTxxidug0andbtD3N8V3sf9e8xQR1rDBXxuerdzL3tU7UWAFQIQysHx1wVjB1v2jqs4/ek7Rn6DkWP/ugwM6lkSxnVn3MuVnDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10208.eurprd04.prod.outlook.com (2603:10a6:102:454::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:08:49 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:08:49 +0000
Date: Wed, 13 May 2026 16:11:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: Re: [PATCH v5 06/11] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
Message-ID: <agQyMsKJ1gmW2vMW@shlinux89>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
 <20260509111157.4039434-7-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509111157.4039434-7-mikhail.kshevetskiy@iopsys.eu>
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10208:EE_
X-MS-Office365-Filtering-Correlation-Id: db632296-ccf1-43e0-ff20-08deb0c6dd0e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|7416014|38350700014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: c325CQQn5fW4K4Ujo3SgHj89t8mya3usBRmsEBO9D3bkFG2lR9NXloNH/ED9oIa+ho5YJXxZM7RgdcSSZpS8zpFTnmPkjT7bAr1Bd7srhFXJXta1i8K1pSCZdoAz3qFF3xhclDy12Qsk75yKdABMyq7+TXEgzl+iHug7HrD4vkctyf6GXKxGNug1Ye5sgTgSZQyffgZ3b0LB0IKt3jwhsUgWPIE1th233WnJkQ46q4ErI1q2Tr6+cMvbRuwdnxIPeplm4dIK2jG8qDr8fj6N0ehZwYAcnhQ5jqzuF/VYpos3h0SRXPeZQ2EMw/GE5r2tRTulHeNHexdBjDtE2YPNGqrgXFOOaEAvEwyXojvk2Kxh5yt06zPbUEWgW3JgDi6nfLNQmqb9Ar6UgQSRlXmzWVojgLJ8aJ6W8j2rsGETwjQpvVHUIP4ZgAU5j3lkRBF5fiIR5i7HpmQU9xmVVTRSGZZ66YoLZ7tGH9hAiONSWgh3BQVGjvNv9CcKrxveF2UnMUwxstbwhalOnPD7jHNCylQPmtcp0UFCkW3ARy7Vij9ZrX3783nTGPUb/Cb5OEtZc6K2Sbvh16PSmVeLxnYq1k3xWXbAfJLv+2ZkQLnuORf08jP5MFgHV2W41ergU2oO1dcL1nLu+nhoQSEGwcquHJD+4eHe2MIVulWMjuYO7ZbaU4fsX/xzfEOQLINXce2WdIFQKimQr+4QEOPuVmfquolHCB66r6ZFyRy2uGMy7mj7Kba2IOjy5gaihmBP32xg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(7416014)(38350700014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plTuhiV2sl+4KqkGggEGTCNl76aJl+MMoUzJzZ8m3GDCV1vfW6NLpFX8CT45?=
 =?us-ascii?Q?q9eV9I4AnEakub4ivBW+Jyd23gsaHI0uqM+6WCQkB2rdaUjClmuBrEHpn9hX?=
 =?us-ascii?Q?sDUVOQtc8T8KFcGFYOYxKerRfl3xG7GaR8DqPiPemHH+yH0L2tuRVtx+fLXf?=
 =?us-ascii?Q?JCZ5Z8qwxPky9XTC6ZIG/Vui9zcKfqL/ok4WoQppWzKo8TO5sjRnotqTT/vh?=
 =?us-ascii?Q?oFB6Ows1jbQz9Wczryku/q6PoMnKJTBj9aLW+n2ZdVYWJgMmCH6AU0RyMJ/g?=
 =?us-ascii?Q?vjfR6oTv5c2fXyWV6y9ODpXieJ2D5cwpXfOcC3oq+GLyL5nEAvFYYn9KvEXl?=
 =?us-ascii?Q?Fjhd6Hgs9hCtdnI/2CeEGJrnjubybA9Tq+6E42oK5M9sm2svForGL2ceczF1?=
 =?us-ascii?Q?pIAPqBscj/uMHbZOLpg70DGtu00b0UGkmHILBJrnlmk1+LdNeGOvm+Gz9000?=
 =?us-ascii?Q?giUa5kQfOpDqS5IJpEXW4FcLm9ABFu6hKXjJ94bM3OmmZEKiYb4ozxT0kf2c?=
 =?us-ascii?Q?WgjaDGP8ji9+B6Ni1vb9a750L/LkK+YcvnEZubXuo+/snbubiWDH2EywqkHd?=
 =?us-ascii?Q?UCqI1BAzvMwiUR538W3w9GDidCe4unYdgTpFgSIqWrfA4gm8JZaHEkYEWEtf?=
 =?us-ascii?Q?3I68QhODIITIbTZriKtDlF+HMcQkUJhgfHDP1ZQRYuaIwZSkHnxoEBWo4jTm?=
 =?us-ascii?Q?DTYlDu2yIOrrYNOd4pJMODTvjXxYpXQsWVmArXZzqQZpIw4ZXsVp3fySLlq5?=
 =?us-ascii?Q?ulSLP2pZowoMEWJWtcxaY4R/MS/UDjZScoCcCGxiYnOS3cFP3aCDjVw/Oq5W?=
 =?us-ascii?Q?0pjA+RAp0mQGEvvZuisslx3B4qRND/8xgryd3Lkkvo2wG5Olor5SIcAeOgfi?=
 =?us-ascii?Q?AKmisF+dmH/kXJCbbdzlp0e07kOiokqQPBEmlUqBvL20J4HgIzfpRkMlE8oO?=
 =?us-ascii?Q?S7c8eDKrqNUMA/RQ/bgZpllOMqBVF6V74reB2imgPjcQqmp4oCo37fQ9dZ2J?=
 =?us-ascii?Q?rtiDd5yMmV8Ylu3C3/Hlb7SiJ0jG9rdbzKPJudxlCCxgrHgpWv/xh8Vd2Y59?=
 =?us-ascii?Q?nUHZWvqRVJkf0IImHDtD3ZZrRnBF2V5u2XicW2MKXDmWMqdQKqz3KSgaWBGr?=
 =?us-ascii?Q?u2IT7L60g+CK3c+bYFkm2rrdsiwrvqibYNSp79Ik5GIUKXl75Ku07QdzeOt4?=
 =?us-ascii?Q?rEBPnMxKpd3F6ccPblDY4TW1DMtTRi8II4j4F34bL+46kZ4+nhSql25lQTSv?=
 =?us-ascii?Q?te/jenCDcafhjIGqhzLVkOB7FmZzwZ1XYoxk1CQRf56dECG1+Qcycm+t51AQ?=
 =?us-ascii?Q?RFgatKcxLdhuWzE2GEwqs1qMF6LTE3n/HsX0B7f9xT+aLIIcU4nxImWZM1YD?=
 =?us-ascii?Q?v83ULvDl46oYVWmOINuDUfucCy9Gj5q4UWyTPN4XyuKukVxJVbqItaGe/J2p?=
 =?us-ascii?Q?GQfqabGg8iA2BYHbyRLjIqXpmhi+r68Fnsz3Q6NrxqlNe9eQ3AdJQ5PWNCaz?=
 =?us-ascii?Q?jpB0X9Czpfu8NJ2b3aEfdZ9idPWEchMNrLBCofq9Dytju582JwU8wF2DSefD?=
 =?us-ascii?Q?Bl4b9MkfZU5Q8E15hS4BsTPRKjjtcv7JhiCfTdxIpyjUlgCF+QPDnZi4VSfv?=
 =?us-ascii?Q?6ZiNwa8th2Ug+ksz/66gLv+cGuFYrL3766m2F18E7qAxL/3Aj/QnGkOrjsYt?=
 =?us-ascii?Q?U7xn3PUVUf/kTK1dbvsdLjxCqXB6NpgP6wBoT9wcRV4oJth7dejVmPAnhXB3?=
 =?us-ascii?Q?ZEMJCcNP/Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db632296-ccf1-43e0-ff20-08deb0c6dd0e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:08:49.3263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lY6XC43vdlop3Iw7OJ1yGt96I9NHDmxwypYx3/2MHivvwwQPkf6/8QD8tlXowz2jWMdBHsEKCYDjrADhYsyLKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10208
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

On Sat, May 09, 2026 at 02:11:52PM +0300, Mikhail Kshevetskiy wrote:
>This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
>
>Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>---
> drivers/pinctrl/airoha/Kconfig          |    5 +
> drivers/pinctrl/airoha/Makefile         |    2 +
> drivers/pinctrl/airoha/pinctrl-an7581.c | 1076 +++++++++++++++++++++++
> 3 files changed, 1083 insertions(+)
> create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
>
>diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
>index eb87afbb374..986d23c2e3d 100644
>--- a/drivers/pinctrl/airoha/Kconfig
>+++ b/drivers/pinctrl/airoha/Kconfig
>@@ -9,3 +9,8 @@ config PINCTRL_AIROHA
> 	select REGMAP
> 	select SYSCON
> 	bool
>+
>+config PINCTRL_AIROHA_AN7581
>+	tristate "AN7581 pin controller and gpio driver"

Nit:
Use bool. No need module build for U-Boot.

Regards
Peng
