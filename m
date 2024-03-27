Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB01EC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 10:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D355C8803A;
	Wed, 27 Mar 2024 11:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="SggOvfdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738F08803F; Wed, 27 Mar 2024 11:46:52 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D986E8803F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOJiZIonb2A4nf2FhzIscSnH6YDLTkML0o0L6tghkzrdAhtxR6xfZN1rl7JUBG6oBjgKxSNCT0jAlG/d0Uy9aGKWdEMUNg5ar+eEBhRtFyOLWH1kNZonMivFcBVjtly++M+C4uoduv792m/XXo3MaaEvvBFls7THpIF2nKAWDkFUJcpTi7ceD/efythlaqOx55ug1m4OgHz39aSVkVm/phOTAybJsB/vUt24iauh0xLNpKlptQhEhPnGAnUoopttR4EuhDTKcaReOt/ssYvHE1gXCQaA5/yqbqGL6FZmomxHumsnI/8BWObFVnirEbS4V2ISFMeqZBRHaBHE0B2Xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGxJwRUJSFWYMk42Y5tpfOY2RyqOcp7an9tT4eBzdTc=;
 b=X9pt4YX4LHCSCpDBcRsUL16vlPMmfUdUb/xpspwRbCGAjwxhD5B7+eFqr+RUE42q/BHQvL2K8cZSQmceWoTaW5XX8GcDs9sxtCIWgFew/0te7eFd10ZvO/Z3GaB1KhPoBeL4xtWIDV2Vvc9a0qD3/ERTu+dvVs7ZH8heEi6wGqRck+l+Yor9B4ZhCGUaACSjPRCuzNEYSZdBDGs6u6YCj5Sk9P382nP1ntoqNgyDqbrHSXem+Wg9xR00fdVj+6Ph9h+fb9OAN3+NlgMJYTQ0eG2Ljvtm3lGyV63dW9Ug/MWDd2zZyiGN8DcjUYEm83eTijitEz8GKDXXNdBPkvbHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGxJwRUJSFWYMk42Y5tpfOY2RyqOcp7an9tT4eBzdTc=;
 b=SggOvfdRdDDX05Q/jyKXck3i6xcsXiHO/SqS7WxWOvoaKRY/yIeEl2kLlEvXbsPVWOzLli6ERT9QsfvI8D2h/CeloskBIuQZf5OkmQlFApxjdMLIfeEr9vPeQQP2NRltpDekCqA6Ktk//Oe7GYnuJwYV5DB7YJDxXsx4Gz5QGZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB8064.eurprd08.prod.outlook.com (2603:10a6:20b:54d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 10:46:46 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:46:46 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Chanho Park <chanho61.park@samsung.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Devarsh Thakkar <devarsht@ti.com>, Fabio Estevam <festevam@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v2 0/2] Introduce spl_soc_init() for SoC specific
 initialization
Date: Wed, 27 Mar 2024 11:46:36 +0100
Message-Id: <20240327104638.2432672-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: b6896120-ad8c-471b-6ec2-08dc4e4b32fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH6Hb6+bynikxUQCc7OFQxdoJU7O9uTste5QwfIaAaKSXRIfPkMCl9azhTGMvG5Vm025Bxe+fN8Gv944dW1HrcWv2hf+XrXqgudHxfls5VuqdYGwmZKnlYLuqxgSgQGM4dznckFkYlCNVDdAmwHokEv95no7LudMQqvAW9vG4EPtrdn0GnR279PkFRkqCdOLCQLjxkrKfhEbN4dV3d4FXdU8y/piljMWGU0BnpH0siukvoadsT4n5eQyfl7EN7d0F03uzZlIQCfK0b8Lx1fxEjh/1VD6jCSUfXAMvuMNyL+GykKvJ3ZVu3azgEvt4k+tlbwgPNAd/AuUhOrfqZgLEUnkIRJ55vAnHvSNeTPU1zujTOnlz3NhKWipvSrQF2XUgj8iqbneVjZe95bdrm6Yr4SHjAm/0w1UeAZR68uRKaE/aTtt0coUDc0IeKruPq2pelsjiS06ADHBDluTHpjHwSCWSEQZihrwVcdQB7v9NLKPKoDxyYdBtWcK2jXvDDVaNBeEZEmv59SL7oHkPjVODN691EZo8of6CWtfG+YkO7N899KeOYDExAE40/erBy3vD2Q1mkRs3Sjobh65KHMzbgav6/vZevRlqdnJyMDY057XEYFY/hkDIKIL/5G04JtgleBmRNdYkOxGOcLAYOZBQlKXMATArZwmXKQ3xFlJeTgvc3lwgfsH5v8Pos4sa8qz1y7me7MKpi26PNRVKWLGLm2uLwN2essDn+K8xrDpQuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JUOb1DWjhIPTFyv7RDPIAgr+aaYaQhsGtXsrDplUmfKc4HMBF4SR7HdcuIx?=
 =?us-ascii?Q?nzRlf9CASrKz9WfLd7/XMaiXbscpKMlUSDy11AFN12JfX4qAzPfGyVlPMFPw?=
 =?us-ascii?Q?Z+uwzWqkxMRsN1KO7bQw5/vRZyAoSxLwEnrTAytaM4fkPp/HbimdJYFFg7Dd?=
 =?us-ascii?Q?AjrtiwxT/Ycc9t9obYwi2aNNCuEM3aqUKtp+K8pu9nyyJ1sYjzLoy7xByjQw?=
 =?us-ascii?Q?k0QCdGgBqbdMYA/mDiyIghv4xCXdZklnWE0a06TKyY1+8GhZgSen68SoigUL?=
 =?us-ascii?Q?yQhEWIctjie+xlSpqrTkh7M6VzRpVLdr+ZaBEfW8XJHYSgzshzg7VtoRKO8L?=
 =?us-ascii?Q?ic94qB1EnxC6wMWeKjYSDwzLjBzSxLYgSnlGUPl0WEDKqNPTlqrda2Fxzmcc?=
 =?us-ascii?Q?IuqhpCI1xolHBrph8hPz4oKYq7AWDvhl/dOAUpccRkz2hn9ZjF1hO5jPuBhT?=
 =?us-ascii?Q?3zCBLuXw+B49UCWIBBiQE/hJKDeZJLJFFXwk5j1EKlUTLrI5u5E3v5Jvyv6a?=
 =?us-ascii?Q?DcDmGHDxYH8U0sqXTSrt4le25PcuC35HPGtrGNE4yMaVv5kdWu6EWHD1xVRb?=
 =?us-ascii?Q?Nycuk87s9qg066ZBSoSCIQo+E2lBrqWBSrFgTL2XJgdGlPNQcrso2kbpZetW?=
 =?us-ascii?Q?FdSlAN2WAwSBi1euWUiLaCB8KgpA2oyYJ7Z8McVUpCtaSz5nQ/cSRGuZKb8R?=
 =?us-ascii?Q?kGl7b/zYeoPK7+QLchesQHIKRWEW5Qaqgkl9MbaD9j7f0J+mIO2xpMqNO81N?=
 =?us-ascii?Q?fCJ2L2k5myabFKN4ZEK7cCUHlTwMMF8mHXUSybI/R/rTLmjB33w3PQ+hNHS/?=
 =?us-ascii?Q?OPHx8OzqJYeu7KMTQysQv0CKX+Yh6iBAb5d7hGB3cnbYFOhFZIo0YQuxHfs+?=
 =?us-ascii?Q?u+NaR1P2i/5IEHqBbxqyuRIZ+9Dd8i2ezR5NJ90YrzKGSX02c7QbqEUnlDuG?=
 =?us-ascii?Q?zCsh7QJE7dxFrHz90VmWLeknnAEbIA+ZV6puckxl8IAwOVt6XlwLQzieaCmU?=
 =?us-ascii?Q?1XtfIauhD4HXes9u9Z3ZqdZmrMfBlrTWgExejAogDUqAKItP67GeysuXnatQ?=
 =?us-ascii?Q?yX+pd2v2XSVYbZYCFZjuL93kGGqqkLMey5cQBL/XGtINUDkT5GUA4Raux0Qg?=
 =?us-ascii?Q?Sb6v7fl5NpsGug7DvS3o3bjBuySfyXRDV9K8QAvj70tPLb+bbxTGjgyChuy9?=
 =?us-ascii?Q?FUX2OqCmfFtCX0wDuHOaXvEi83Hvopo/4s0/w/B+hUZbDWqJaUDpU+tztXwn?=
 =?us-ascii?Q?I2UJgzpLxYy2qFwC8WtmrcPYT3NYc3r9sindTZAlRCT/AgIXAHQh6gmYdXs0?=
 =?us-ascii?Q?S2RGWjDQdBU0jo5YdXtU6Ee1HIRCr+0eMMqQf3hhIDuAB/ZTg6eTqQ5P9gwL?=
 =?us-ascii?Q?aBdirVXPJ8TrQkF7ToAlQJrB8UfLxFiE1jxiqPqIwzHe2WbuvRFOC7UlXlfI?=
 =?us-ascii?Q?EbdMbromPNTb654Lgtc7uP7sp5R0CAWln9QaRfLwQoPRBUNEevnZZ6vJxLON?=
 =?us-ascii?Q?AeMt//2J6fpxLNp068G1HWg02EnJKAmaOcTPfjKy4X2dSDPnzVTTHDiZYTdx?=
 =?us-ascii?Q?HpP46xpUW37J0RuTKV1eGecelpOXsKhbrYhmViWvK5AB9oL69b1ivA+qbuOJ?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6896120-ad8c-471b-6ec2-08dc4e4b32fe
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 10:46:46.6123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETqJflrmRy85HdZPXVM3h1wwJF0QdacRJ8EdS81z8kwn1vLAuQ75gT6yWFqwQVKVcIopfA1qtDByRfWMrewviw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8064
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

From: Lukas Funke <lukas.funke@weidmueller.com>


Currently some vendors use spl_board_init() for their SoC
specific initialization. This prohibits board developers from adding
board init code using said function. This series introduces a new
function in order to separate SoC init code from board init code.


Changes in v2:
 - Change spl_arch_init() to spl_soc_init()

Lukas Funke (2):
  spl: Introduce SoC specific init function
  arm64: zynq(mp): Rename spl_board_init() to spl_soc_init()

 arch/arm/Kconfig           | 4 ++--
 arch/arm/mach-zynq/spl.c   | 4 ++--
 arch/arm/mach-zynqmp/spl.c | 4 ++--
 common/spl/Kconfig         | 7 +++++++
 common/spl/spl.c           | 3 +++
 include/spl.h              | 8 ++++++++
 6 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.30.2

