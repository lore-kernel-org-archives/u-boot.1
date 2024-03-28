Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7412FC47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9B58808D;
	Thu, 28 Mar 2024 02:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TvFAXvLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0DCA880AC; Thu, 28 Mar 2024 02:46:44 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0F88808D
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYgfDmbYCaAVaK1EMrkbquvjfUGWcPDRLeIX82QAWsgRH4rMAepK3Wd3moDQPhjekqD5VjnYfa1e/avHxQkZpptxuj2OJKpjIAwytGEjCPg9mQHuN0GkwEv59B8sf7FGt0ISf23JEOV0w46RPrhv5BzYY+YXZOr9nxqby+z0EFh2Z/cyTDups6KRe4WXbf+XC06HImnif1MiOmidWuexeM5paNrl2oMzyf9RkO3eBPYsdXpqVN1uP55yi7A3DhcBcNvBq29C5r0aZEH/3AxmZKyQEQYoTOzgReNOuCA2JB7HisjTtA3XFxmQ9rqx7HJve1kYFL5zZVoIg9NmmCx4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euz1kp5ykqxGcOPiFvZWGujzLIYuNAQem6UbIzC5LGY=;
 b=cXUg9hHD64jzX9aNq9+VO7KiVFSKgYsQy++VCVjZz7BjzWVOdRZnQJ63Jxng7rKhmpOziI+5X9e3T1fQe+7vUsZBuUVZiX/171ZXcYZzx/KV9ZAw9/c8FkDuMp26sCGPH7urV6pTOT5ubRHiZObfOh3zhl3/nC1anyGGzb0WgiVpN2GLkqliWINUQXS3NhFCXEeht8zYDqKgNuKlxnVCy4GEKQwm8SEYkjwucvoIfIDPfXYryI3km8sP2amJAYWVJYDQfxUP/0KDaDwECXLHz+0puMN+cuJ1d1LKRxfiN+nOBJ6LW3OxX+pckN6nhKcX4JHwpPpcYrlfJkuqpZGL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euz1kp5ykqxGcOPiFvZWGujzLIYuNAQem6UbIzC5LGY=;
 b=TvFAXvLzLV8qmsUK6D33G17OB8SXcL0esNRD1DdBU7wG3qxGuB7808qZ9Y3y5S9F6/q03ztb+lY8wiSZNFcbErissZIFdeXPbRlo5aCZ35h92GfIOy90hHmVklcPitzcjCwrES1o1w4WYjOozlJXuMHrjdCA1q0MhXeAKX7utNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:46:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:46:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/4] imx8m: convert i.MX8MM/Q/N/P-EVK to OF_UPSTREAM
Date: Thu, 28 Mar 2024 10:45:07 +0800
Message-Id: <20240328-imx8m-v2-0-7656998cc8b0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPZBGYC/13MQQ7CIBCF4as0sxYDKBS78h6mi5aOdhZAA4ZgG
 u4udunyf3n5dkgYCRMM3Q4RMyUKvoU8dWDXyb+Q0dIaJJdXfpGGkSvGsVmjufVCWbVYaN8t4pP
 K4TzG1iuld4ifg83it/4LWTDO5IwKtVb9ZMzdl+1sg4Ox1voF0VSPXpgAAAA=
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: b209d817-3b6b-49c9-227e-08dc4ec8ea6a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6IrJCmDLUojGrWg6a9SluwqqIBLY6seDKAtmhy4qUZPVXEq+nvv/4XNWkQSedg0fRgPzefkVYpiTU6QH5jPQNBSkK8anpIR2pzqyHcHAcPVYJQ1ab4mvLXVMnisrcNdn3PWrQKJH+8ZCpOgVmx7trZiukaz+SGAWw7q82TRVWHhbbxfgwvjp14k9oIjU1rZ7SopT/AWDzmG7Y5NyNAzUdOFfUwA+b29bbIwgTef8hr/wTBFFfIKd60R76ySwM3IEHWxJUY1w2VzC7UfIVW/z3fcE9yXSnHIm/GpuFLEUEJXzmO7QS2mCl30pfthTvyg1LcheMoYYGHvDs0HzPVBiFEYTvpl0Dqjf5mBuNPzLAjfc7hmSbm+S0hP9aNVB1kl6CCvDEA0ODhIsZMHsgNLfMBjo6nJx/xakbMnTah2vNoQLhsk4I5YB2bdDdRHHrL4nTmMfiFu5pnTXkBL6/SHwfRsN1JdLLsassY0otyLPoURjkbGiMyTl/JYt0d7sXNjqfw2XFixiYuZvu9AIj4CGBym50dEQU6kR4Wd/mKiCLefNLSvtFeS1sVpJB7aBnxmeJ9Oquwh6aHzPekOJ/yxiDJCYJUiOpiOyn+intxFsAuP1OUjTno+Ev/5xnsa18Vk33v5vBWeEs9fp7lomGDZjLADoPC9U7BiJubmqS+BgO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBCNG9pUGI2czVXNGxpQkRjdU91ZzUzQ1FBMzkzS3p6b3RlN3JkZitwbnNv?=
 =?utf-8?B?aVhLV2M5cm1DMmhaUFdJNGFlK2lta21BdFNxeHYyRkhwM3dXUVRtTGNwOHpK?=
 =?utf-8?B?bEozNGNLT1FGWnVCRU1KZFJWbTRodDArV2JRRzJVaUJ0UFR2allxNDBVMFF3?=
 =?utf-8?B?UVRNb1hSWkkxTkh2MDRIMVNsMVY0UWJtNkg3dnIyVXMvSXJ3QktoY2tMcHR2?=
 =?utf-8?B?ZUI3cW9nSEZxb1lXcnMvWm9CS29iVHBIbkNkRll3WC9EN0wxaUpTMCtFTU1B?=
 =?utf-8?B?dFJNNXFwUjNNQnAvRThBVkhrMHhpRkVsQ3VzQzQyQWRRK1YyamU0S2lLeVZw?=
 =?utf-8?B?cFk2TzNoblN4YWQ4a2dtNVY0b0ZCWElLdzcwd2V5MU1nT0FBdUVtT2tHMStT?=
 =?utf-8?B?Y05ublZSUFhIY1BkTUJxWk1lakRndWdxb0RKUnN0OTdOZGhYdCs5WEtQbHVJ?=
 =?utf-8?B?d3lYSzFudEl3V3NEOW5EaDg1V0xCbGY2MzltRDZidmgxaUJUblpLcnJOajlh?=
 =?utf-8?B?eThUWTNvL0NWaEFkZG9Pckg3ZEoxODhpdk9EaStjeXJ3b21ZNE51NkIyUWVz?=
 =?utf-8?B?UE9IUElvcmlUY1d5Vkh1b2hwLzhIMVFOOEt0N3R4UVRRM3VwVXAreTVrV053?=
 =?utf-8?B?WDBLOGszajFpWHBmWkd2SzFOK0tEOTEyM0tLSnVNcWVXVlN5dXhiNG8wR2ox?=
 =?utf-8?B?MnUxRHBFbFI0bExjK1VBWlkycXFKSmZXRTFhTGlLYk9ZMXhaWkN6SzY4SkJT?=
 =?utf-8?B?SmJQUGNTcVUydmFRRmpEdXBvQ1Z4RlB2bDVpMDNHeTM2ZWxHSENJcU1KRXN3?=
 =?utf-8?B?NVErcXhvbWorUHJ4REpDSXV1bUI0ZHJKQmgxVlZhSlVkNk85RGoyNE5HMTU2?=
 =?utf-8?B?WWZrSXN2bld5N3cwYldkUERIc2k2KzMyaGxFc1ZZZWd1M2p3M0Y4a1AzeXd5?=
 =?utf-8?B?SExZeER0T05SaDVWZmFiVS9CZDF4cTR2eVc5d3FWdUQwaTkzNkg1dzQ2SXhn?=
 =?utf-8?B?dmVaR3hrWVIzYzF2dHlGYVI3QXJHRytReFQ2K0RZWEo1cVlKUU4xaFVwS3dv?=
 =?utf-8?B?dXJLQnAvRWpJNlNGKzNVTUpuSkR2ZUdhbDAwNm95Vks0N2dnU0d1Sk5tS1hZ?=
 =?utf-8?B?VG8vYmREdlZpOUU0KzF6YzliOGh6Wk41ZytIZzZCQXRUMnBmb2RISWF6UW5V?=
 =?utf-8?B?ZHE5WW8rSjMwU1V0WGxKckIxRHY4ZkJvd0dNUSsvM21qY216NW9TcFFUOFlp?=
 =?utf-8?B?ckE4U04rdWd6dVBlYTBnWUJFYVZienV0NlNqcSszU3JkVVIvYWxzQmk0Uk5l?=
 =?utf-8?B?MS9hY2JST1NQczZ2R3ZvRk5Zb2Y4bWxxZ2NmU00xRnNWNlpYZ2huZ3lFc2Vp?=
 =?utf-8?B?dGNDTFlVVzVkRFJBaml6eUJmL1dxTlVOVVFGbXpSZXJvWFFVVmdkTEVPWTk0?=
 =?utf-8?B?QVlhZmVOenpGS0I2RnB6a1ZURFlmaFdsRGZNY3ZjejdJQXFxRFd2UEh6a1Z3?=
 =?utf-8?B?Z3BSTjh5U0Fmd3lTV0QrMkZNbmJXVzIzVW9NM1Zad2FxS0RCKzBraWJ6VjhC?=
 =?utf-8?B?Z2hOSlRHWWczMG96R0xrZVdiMTlXZ0dCVkRScXJPekdkNThPcVNUeldtcEpR?=
 =?utf-8?B?MThlZFJwS1I4Y3Z2cFpMR3lLaEJNZTA5ZEpaUzN5ZDBraDg0RW0rdlRNZ0g2?=
 =?utf-8?B?OUlsUDFXRVkwYW5EZUg1eXpUZ2N6VGloZFNQQ0QyUDM3ZVhRVzEzTTcyby93?=
 =?utf-8?B?YlFwdnh4UmR2eXg0UUFZTU1UQ0tmMk5mRjlQTWVRWDdoYi9MdnRSYzJqWTJu?=
 =?utf-8?B?ckVBMGpSTm9YeFJTbjdnVU15VkhxRlU3eThXVFRRRHNma3QwQ29GMjdwZVJv?=
 =?utf-8?B?MlhzMFN2OFhWWkVTdW1Lc1ZaNTJ4SFN3VkdES0drZWdRVnJZYlhiMzMyM3Yr?=
 =?utf-8?B?Um9pemowSm1SVTNhWUN1Q0ZMa0hZaWJmY3g4VDRrUG14Y3ZiUW51WFg4dzhH?=
 =?utf-8?B?Q2p2LzV5Z1FHa204U2NTNkVjNlBiQjg5ZzlzTFBONThoWUZFTEU1S0syYVdL?=
 =?utf-8?B?K1ZMVnJqMG83VG03OUp3TzV3Zy84NXNJdDV4OFRlSmoyVy85aUJUQmU4aGVN?=
 =?utf-8?Q?t08LdZFdDLf5SN6HRLhhmwnhO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b209d817-3b6b-49c9-227e-08dc4ec8ea6a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:46:41.4394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RLTw0GlqK0ux2CCw+RMX5MFcWcPdC0eGkviVJZnqwgaCiTYNwYRiRAZh7QxJONmZQQLcInpegRNRB5ZlYPH/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
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

This patchset is to convert NXP i.MX8M[Q,M,N,P] EVK boards to
OF_UPSTREAM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Sorry for the quick respin.
- Drop the dtb build in arch/arm/dts/Makefile
- Link to v1: https://lore.kernel.org/r/20240328-imx8m-v1-0-2be5e6657a88@nxp.com

---
Peng Fan (4):
      imx: imx8mq_evk: convert to OF_UPSTREAM
      imx: imx8mm_evk: convert to OF_UPSTREAM
      imx: imx8mn-evk: convert to OF_UPSTREAM
      imx: imx8mp_evk: convert to OF_UPSTREAM

 arch/arm/dts/Makefile             |   5 -
 arch/arm/dts/imx8mm-evk.dts       | 128 -------
 arch/arm/dts/imx8mm-evk.dtsi      | 615 --------------------------------
 arch/arm/dts/imx8mn-ddr4-evk.dts  | 160 ---------
 arch/arm/dts/imx8mn-evk.dts       | 128 -------
 arch/arm/dts/imx8mp-evk.dts       | 684 ------------------------------------
 arch/arm/dts/imx8mq-evk.dts       | 712 --------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig   |   5 +
 configs/imx8mm_evk_defconfig      |   2 +-
 configs/imx8mm_evk_fspi_defconfig |   2 +-
 configs/imx8mn_ddr4_evk_defconfig |   2 +-
 configs/imx8mn_evk_defconfig      |   2 +-
 configs/imx8mp_evk_defconfig      |   2 +-
 configs/imx8mq_evk_defconfig      |   2 +-
 14 files changed, 11 insertions(+), 2438 deletions(-)
---
base-commit: ab8d9ca3044acf51d8ff3bf3c4718c48f30ad606
change-id: 20240328-imx8m-b6e89715c5dc

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

