Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E901FC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 08:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF905807C4;
	Mon,  6 Jul 2026 10:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WtuyBIO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCC1B84105; Mon,  6 Jul 2026 10:20:02 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC6B80398
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 10:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1zlly6+wKiDyROOuRh8e9dDGQlvwvYFJq9woZBjFIz7D38W4725d1c1eq/6qvKaoJl/enEi/jXjCJH0oRzMkhRB22Z9tMelR+ThfBzoO624MzDFmTLX2Y6ywwOUHvGH725RxrQ26b2t3F6RlVkT1ckHRe74KP1Vs9h8jLGyRBXby1hNrX0Ye2vZEzCcJGAb59TnyOxwjj4AcEsWRjyxpxci+ZmYE7gP0VKpKLFDWN90gsGu/vDSLsziwICZMVmOxIUI2i7Ln2VMhLsFqwQdRwKaJ/4XW45FQg5z3tWp4QbAOcyktEiBu6HIYeHVrZFQc4lZp3hQkjKtNONSC/oSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjRHBmgd0WRNhNJ2sUFnTPSKe3om0m0Rv4h7a9wRFVU=;
 b=GpE6U6Zdu3i68Og0d7VKCuGJR9roGdvws4+5GNQWCM++5O2IyxOYKYl4M0pSQ3Ak0goYH/9j9lk2MYHYbq9TFYzgblZ05MrnBETGa7ngx2uCgiQ2Nm9f71PrRThWgEdH3R2GREOOorh02Wom8gU4/rBNVIno+w1nWjyuHNp/1nIwx3Ixy/D1NCApFd/299Yp6h7Reh7an6XLtiXWozFwDbpwJWTUfsL22XnE1iN0T0szF+x9u3Vl67N9HlAuPgJlJ/NJS9xCQC29zYj9wtquhLoWLjPux9oAOJkl+p+fXUkFp0LV8hyv7AsqFyasBapz+y6PyJfTdXz+u467Hr3itw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjRHBmgd0WRNhNJ2sUFnTPSKe3om0m0Rv4h7a9wRFVU=;
 b=WtuyBIO6JjDlaxIPYUlGyggakF0rb0FLSAIKuD2Hkahx/sfkRFkAkASPwQf0Kc86jKJ3tNIcsZis88I1jjFT9R4n/fPFIHO+s0TtdEtKQ9n+7c+SMYTDKGdph3ILzJwy/u+MGGLN7tPm2cMvwiW3+akXB0ONmqwYAIlxHQ3mFAL9efJAn1a0Zz8hMWi5/Qk/FKhg5emroCobyUbusFlQKrXw8EpNTKcj4wgxapLUvfiqUD7O1AwgG2kpPwEnlxlvF/1uTrsea6AZEIEGJ8bPVSZSis2nnkjlgqM/UOA0ZyZ1nrkQsktf7ysyWqd7HXYmyLSqgpvmsjh5/xn8sSx+AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA2PR04MB10333.eurprd04.prod.outlook.com (2603:10a6:102:41a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:19:57 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 08:19:55 +0000
Date: Mon, 6 Jul 2026 16:18:39 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ye.li@nxp.com, marek.vasut+renesas@mailbox.org,
 vjardin@free.fr, aristo.chen@canonical.com
Subject: [GIT PULL] please fsl-qoriq-next-2026-07-06 for next
Message-ID: <aktk340Ug5-TVQY-@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5P287CA0263.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA2PR04MB10333:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6c22bd-d8f4-4f38-59fc-08dedb375c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|56012099006|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info: +NHcg/J7x0NU8dv4YXeFvsouharXqtOl828sYi1E6OY5LXjOJDoTbPlmpJS+/2j5+CoNUpaBVOK5JGOgyxEgQ5IKONfhZeP0r4WsLEQu55Gr6ffSKKGXtiWziS2nvdrr1CoODn2dpptMVsxMjIUpq0LItcDxLjYM9s/Sqpo4O5I6+iRTAF5LWjxKyHLiMqdCLR56nVl58pTHFS02GYDphvauLSXzPUTFm1yypz43D47CU9x5l8hfXWe3Xa6QCwoKweTWAjxA/ap1IdrResZJjqGv/1KyZUCAxpyH9oxW6phxRA67CubZ+5SoK287VNWbjeY3NOf2JUB/e+RRzrJ9td4CBU4xLgpi9GDkHjPuTCl20Da6GGLh7PWFWc+WJYVLyRWqQtQXOrhfr2w/mVgrSrFMbKR5dlkkLQ+OZXF1uB7s+NFN8hJGGmgYOqvj+ZJnm+WMInlZCH/exIfYUygEJiGZnAqcaIPSs3YqQLCbwcq83Ab1nS3bvGXeEwlyN7jyx2anuaLPDnoroLBjNJS2Qarbx385Pd7WKpdAn8cNzwI02klMC9dcDOI7dDgpwCkMunc2/ToneylPrpFcuZOayJOgia94Il6jGPUrR17BOm6iIadJjmvtfv2zAeGWcib6H1qlxDZFNP+kXP8vz0TEC0C+2ALN20XuZECUDQ4TapQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(56012099006)(11063799006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ynUmP2LVpNqMLeixvLeelOyYEU+okvplkWwN4rC+Twq8ogDnA4ktyNpJRSF?=
 =?us-ascii?Q?6fX55BVyoJw9+ATi7Rf2Jm6S6EHydhcV02A223Vt8bd/Uz8OPRBjhMvKA2ri?=
 =?us-ascii?Q?zj2da0uBMy4tS3RDA9QESsk5Dgfnsr9PCD0fFaov8O/Vk/fINwNQJhY9eYVu?=
 =?us-ascii?Q?kjA0lgerrJ7BRrCB3RdCYUMLVm/GsoZqMCAn7MSCpMQmlx51l0naqBbxmiiA?=
 =?us-ascii?Q?MI5vquxZSTbsve9kLh8tfPP/OvE9FGBHkziIGpbLIL9CPgNnZMUudnVECQKE?=
 =?us-ascii?Q?Wxl7RMnzCpeV4HOsWhN0ID3WYccxUSORdWnw9AcDZ5sLwSKHIhksVLRfSyXg?=
 =?us-ascii?Q?8yjSeE63ONHH+dyYpPs7vpLvdLP/piNqxUPwrIVghfDAMeLF3/n5o+S7M1UD?=
 =?us-ascii?Q?dO/I8oMQWxf9VHbe1eawZTyWbl+yN6pp2AeR45OXCeUl0JOij5rTdElZOl6T?=
 =?us-ascii?Q?0gF/iQilZVYcS8CVfaYnrMyeSMyj9ksdCZ/TlmVUOMfRC1zGKuY1HsAh3jQW?=
 =?us-ascii?Q?e219fH9wwkS5SGAUvJ5YmQmah+gvdFcI5SP8+w/hk10ZyP2d5hRHBaLnhvsk?=
 =?us-ascii?Q?0QHvwrkeGC07Emmw66fU+uSjCwJmiug2NQeooxEHQz8APRf/LwCo01Guk/bB?=
 =?us-ascii?Q?ASN5WLyA9olKqFItK3+ccZ1uqe3PREIY+AW+KPE1NlXYLPfR1k8eACT/8E4d?=
 =?us-ascii?Q?wyCOmm1u1fLMKj6iS5fJ65V+wzdrWFpP4Xkl7GmFOfokaYKM7/2PD1lajaQo?=
 =?us-ascii?Q?Sc0bEv96XMCd0pbR+PqSG8+SIWxLunK+OtW0OxkmXyufUGKWZ45JtnewoR7/?=
 =?us-ascii?Q?0DMzz9GK5sKAcETtP6FTMO3rkONiXUnlEe7p5gYX3kC6VJdOIZVBMbykyyh7?=
 =?us-ascii?Q?tngRXBAcrTV/4Rn6mEjQ6UnuauGecT+cXjzwjTIZAsBEQN5uJmSUnrnmfvRa?=
 =?us-ascii?Q?ivhqm746MCYgPBnDLyxrj3rhwku4fzLJ4dCry0dh67rvsjugBf6bUGeuAdbT?=
 =?us-ascii?Q?+gllnwX4bT9vXRxyThhx3DEBFnRXscWGNaHPQJc4boQCYDaYVtrLBfZvI0c4?=
 =?us-ascii?Q?RklH3JB5ofETNfwnYVvTjllxn4X2FgXjR0B+19oiBgLbokAxOJltEJTfQ2Hb?=
 =?us-ascii?Q?OrNYlaB6Or/qDOXWY2eNVMNq/JsrMdL0ZSwfuLJFVRkPl+JcS9dEyhhk2AoB?=
 =?us-ascii?Q?uaiIqNTscUKnFWE3gs41R2WvEhGu88u0DyFjyUqpLxJpG4XJYeM6MozyTBj3?=
 =?us-ascii?Q?VWznfVdwfL0erD2t0U4bEWSUInpRT6vBoEMSj2FrGScciu/QEDycpM6oi8Vc?=
 =?us-ascii?Q?XPIqyluSKCYgCm1+53EOPLSQGT9sQLtyYhDlnVVfSZ8ESaOeKSnAEeu5B5mp?=
 =?us-ascii?Q?2ot8RnexYRD74bdgyogwgwQE43z4Xgmg+AFYSp/eAYCN0rlSH6Dy8ZnSowCV?=
 =?us-ascii?Q?TIneFf6fOJfZo9uIx6QTr5xat8CoVWPCXDebVfU9q0WUygowTXnHEA2cQycz?=
 =?us-ascii?Q?sQZLJI2Zj2/F+OAvN9wJKerJUQ/S0+P6oxD+7hiky7a+xLaugJcdkOEwrWJ6?=
 =?us-ascii?Q?zbwmTx7IEDCO9yaOLxHmkTNfkHBslkJZNQKso54ql/0qc/9yTowH5U8HhKjs?=
 =?us-ascii?Q?mfFezIvz3yjqGL4c4nfRe7KeTXWNy/QUyaAn7zKK4Oyv7m7YCWwnYaumzq+l?=
 =?us-ascii?Q?s83TsJTptN+Y9tsxYPVr8nvRZN3M8nWnu5HDseIGGmKNl5e8TWYUAkjVvBc+?=
 =?us-ascii?Q?2pAyD7DbEdHWAg8qXH5NM6COVADjoMFQeqypGFHNAZMbZmrAmmPn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6c22bd-d8f4-4f38-59fc-08dedb375c69
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:19:55.5759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3GiGLpJAfO9bBpv56RLGOovBWt6I9cKqaVsmKsIoNp9tJQ5oGL9kfeh9SGyIF5/6ED6EIYDKAyVm+lUeQPG6jKPjwu1tbKJ07bufjJLKIMB4L9rpSa1WOnUrswllooZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10333
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

Hi Tom,

Please pull fsl-qoriq-next-2026-07-06

--------------------------------------------------------------------
ls1028ardb: Move environment variables from header to .env file
crypto: fsl: Hide CAAM_64BIT symbol behind FSL_CAAM dependency
gpio: mpc8xxx: Add set_flags/get_flags ops
power: domain: scmi: Allow failure in getting power domain attribute
--------------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/30622

Thanks
Peng.

The following changes since commit 2569e25ddd5aa323cd87c7a3819c3a4f4b32302f:

  Merge patch series "bootdev: few fixes for automatic boot" (2026-07-03 10:14:32 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-next-2026-07-06

for you to fetch changes up to c9beb84a376853078e62f385447672fc7e8cd819:

  power: domain: scmi: Allow failure in getting power domain attribute (2026-07-06 10:24:46 +0800)

----------------------------------------------------------------
Aristo Chen (1):
      ls1028ardb: Move environment variables to .env file

Marek Vasut (1):
      crypto: fsl: Hide CAAM_64BIT symbol behind FSL_CAAM

Vincent Jardin (1):
      gpio: mpc8xxx: add set_flags/get_flags ops

Ye Li (1):
      power: domain: scmi: Allow failure in getting power domain attribute

 board/nxp/ls1028a/ls1028ardb.env             | 49 ++++++++++++++
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig |  1 +
 configs/ls1028ardb_tfa_defconfig             |  1 +
 drivers/crypto/fsl/Kconfig                   |  1 +
 drivers/gpio/mpc8xxx_gpio.c                  | 54 +++++++++++++++
 drivers/power/domain/scmi-power-domain.c     |  8 +--
 include/configs/ls1028ardb.h                 | 99 ++++++----------------------
 7 files changed, 127 insertions(+), 86 deletions(-)
 create mode 100644 board/nxp/ls1028a/ls1028ardb.env
