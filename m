Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E743BC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E481884D2;
	Tue,  4 Jun 2024 16:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="mqOxTySy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7339188400; Tue,  4 Jun 2024 16:27:54 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 317DE884BF
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 16:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQDNpCA4tmHJ8sT4AOVlW8YwpQC/qTJH0cPATOvdmdn34KXloaTVjD+h3iqAU6Vv5M8Ls9xVkN5sTi0vrL0oS2frnvrlR91MErcK+nYF14iJwAUo5aH9WK+B0Y/L7CDzKuv7PpIi6e+YyUClPg+BFNOW+HfEIxjOpuR4686qxGk4JR4vGxrCLuss1ViJY8VwgMm0MqfuLBsVC5QRsu9go3L5iXPcF05N0jf5RLjP5KFaP0XdBJnin4mlko1TtXASnIWIU+2kKYYQd0gnMjvfTKceLFWvJh+Bqqk0AT/x6pSfipBEJHT8EIRu0yY1FqF14aK4dNvAUiunKqqfjVgkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr8gZa1T72dC3sOmnVR9Zxf+Y5I+Sdou7gnhdgIh7Dk=;
 b=J5SJTReNLInS57AkB1vlkojMVE/7CMCb4X3wGiu7TKKQ43aGA9ZguKMucTPDiXk340BxhRmvzmbF4cvFKlHtbq6uPT/9qJloDqKhLtGr8jiqXD8lmzC0eeSk/tpHi59zJTKOftBMy0aaUXdHlK9wNALnGuBv4pmBqOmmQ7FTOx7o5QWKn5+vr8cXoWkxkhiIpotM5vhNPkl/9LhVxrvbwg0I+ef4vUJGjLELQsKANFxhJ4NkyJH72R6gC6RgUwOFvIs4m0SF2l3UNu48EzWFSh2XJR4QC25MHSVsHMaZSwG7sZsALF+vfWI+blZFW9wh5XE9p0c9fZW72pEJ2Cb4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr8gZa1T72dC3sOmnVR9Zxf+Y5I+Sdou7gnhdgIh7Dk=;
 b=mqOxTySyKi0RolPYKcH672fbLQu1gunVc/UH66eo6lHnCaJePqYxoZNzy1ZZb6mioClgBvojXYoIJcT5U++vU8wTPc3iJfzVJN6XtBKhNWcSECJNcCj1aKtMyFeg1lSC9JOp8WRwPgLQczEw7qZbMZIhJ2QpWtKEMOfgPk6gfYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5827.eurprd08.prod.outlook.com (2603:10a6:20b:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:27:50 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:27:50 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 2/7] configs: zynqmp_virt: Enable CMD_FUSE and ZYNQMP_EFUSE
Date: Tue,  4 Jun 2024 16:27:36 +0200
Message-Id: <20240604142741.425307-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: bea5c435-c71a-41c2-a2bd-08dc84a28347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0II0YuQd9vcnGDohes9e1muJdi+5R4M3/8DqPVlvyNv/YHisnF9FqJ5u96xb?=
 =?us-ascii?Q?2aCjd5d15oDR6ijOM7qcB4x3KxGYFpuexxMmf4WRAwBmrkirlRWS8Vdnflx4?=
 =?us-ascii?Q?eaCCAGW+vNJ5uTK9fQMAo2qnghtgmmvoeMWosK1IhUr8b7dNT0Do4F7tJIki?=
 =?us-ascii?Q?MZS5IHQcONrcyqFSvvTBKjC5sGyNAkTr2L3NEs1511AzbJWmzQEJHJBr5nGR?=
 =?us-ascii?Q?0rvhWKn/VbYIjvp229TPAMHm2M03WhHtRCT9PKFf0yCvIpXipj3jhxqnxBw7?=
 =?us-ascii?Q?RJWeQ3O8ngx1+qaKS+ngfxRHfFQ9zFjYpCykCv71MWhsKDRFNFLKBpODusGG?=
 =?us-ascii?Q?0Va6ei+wTIvJJ73Y/Zsf+WNmvHe1kF7OUZd1B3H8aPKMcSs3vl58CDTwBsLR?=
 =?us-ascii?Q?AULUXss9henkng1L6GnurLsKAkYUc6PQ6PveLvz67Ke+5iZs8AaCCBUb1kw8?=
 =?us-ascii?Q?CRaon3Ej3hb8yddUoSxiuurX/OdZoeLJrhZ9Xa+ybRNuYAZNosyR1RWTQYKw?=
 =?us-ascii?Q?s6tv+T3zoWWNy2DmTA1IHFUMbyCBRydl0fPkJtdh2hSlShT7TeoQdD8zzUOZ?=
 =?us-ascii?Q?MCtT8MM+akwhMGA3MiemAO2nDmSJaogk4ieZeJfeoH9dzqhHaq7bboZCMHOH?=
 =?us-ascii?Q?BFV+b0+GxnjKDf5gXbdhxLYA/NTgacQdeVpoRo25j5HBWIHkldx5mI8mEbXi?=
 =?us-ascii?Q?xadLB627Wk6nBkkV2YlV+L03YpcJThdT3GBm2n37zSIMZs3/zbGWB4otOG1Q?=
 =?us-ascii?Q?PwhK/QAViEKBmBPB522rUeuPIBM7VSfkz6xqdy09/KnBwJawuf15owUzRPTL?=
 =?us-ascii?Q?et8hT55hZ3z1fpclBx0m68zIEQufZjiVe3Y4AId2lXerFlG83ldn9Oqhp+1s?=
 =?us-ascii?Q?pidGkHbmAIZmMr10U0cNwwfgv2RYnbOuQ0D97qSffb3V8+upJ4guu0b2MlhS?=
 =?us-ascii?Q?eZtfuG12CJv2vnJPmxhXf2JveKJ80qsONI2TkrKmAtUTy3V9BccpVR5jiJyB?=
 =?us-ascii?Q?6HgqsJe6VV3ngfhwTXKHFI8D0UTwfXnPi5olsuXRJ3DjW+n8zqED/ffln/XT?=
 =?us-ascii?Q?K+BGhXHCVYag1F++A26zroKWN+rI7O/Y4L9egBD1IX7xdEZByr9bwDcNF4K5?=
 =?us-ascii?Q?a1RBvBKBG4ItiDYZsMLibnM1/ZAU//Nx7YCPUCisYzdNHrC2QgZys7xcrvYQ?=
 =?us-ascii?Q?68dcZP8rG/IU5aKD7f5ocxv2+aDtFHyRf67SRe2qia1cLQkzXEwh4Xi3uFVr?=
 =?us-ascii?Q?lYqy+4egxcaXMWVmMhmGpeOwA1mi9q2dCpWirUi4B3O/A27X0hA5i57NA4eZ?=
 =?us-ascii?Q?452PPQEL4cCufVUeiCsFKsebKWhpjRpsiaFJyghA1sd66tQQfvBNBEruiZWi?=
 =?us-ascii?Q?g8tIEbQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Vb4vW8Sv5EGTFe2k0Zu7erCSMRlNA5k9LEQni1bEcvpvoRWjGhWuLoWLsVi?=
 =?us-ascii?Q?Q0SToQmcqPOqDYSn5VdmYQW2G7uCLRywfgLczGcXX35nptyyGyRQ3qjDkDK4?=
 =?us-ascii?Q?gI1cAfKtMO6eaLqHmgK3CheqE4vqbG0nKvi51xgS+RwFLgGU1PUdXqlXJx+p?=
 =?us-ascii?Q?WskoopliOpgF9C1ypSBPLrO4p4jq3zFq+6B/XpnUV/LX1IaJIZ0nqYanBJk2?=
 =?us-ascii?Q?ZdNm2YYJV1LRzH6TBt3m05Kgodwk5cytTsrJ63wu1SzhEpzACJfuzLn6yfLi?=
 =?us-ascii?Q?goK66TyUIFTss/VIukpjH9Y44PdamAUtupf4UTB72P9BDhRy8pDAI0/wSjQd?=
 =?us-ascii?Q?uNmosw8x8qwS10oTRkhQMLq1kBEX8XDxaz/MeHaDtSNDhe/dMUKiU5W84NzQ?=
 =?us-ascii?Q?gxP75U8RDFFV69mqqbdfyelViunHWkmjemuVe3/Aq0J4pIC+h31FuIZWufQy?=
 =?us-ascii?Q?4D8KYcn9jbRKRl7YL9nYm8ib268lIrpAveOEZZh4+IRZjTXFJW5m/Q6LiVon?=
 =?us-ascii?Q?NAj8gW44b0BYNjxOt6SXEx3Bg+v4vXZ7DSY8US42wz1fA8/6Edkz93EO5Z+o?=
 =?us-ascii?Q?/saYZshwfGRt7RHjLFhaxzDs99eyZ32tnmk9E3Z9d3SDYvbDbd9JxjhIXecE?=
 =?us-ascii?Q?BK3KUjvoXkytGwlO7aRRPiP76skXcyctH7IE5oV0aW6N0kMBD4z1Z3JzFNuP?=
 =?us-ascii?Q?x38PhDGkYHqmflM4L3AGHkFRDEGIZS9NqJ15zteyZwmrXAZbtdxK4gEMebkd?=
 =?us-ascii?Q?cZOFjh5kBIkmtfN+jV3JDXiVMlAlk2oKzzGTjsENKUnrJLRwzs9MxhgyPyUC?=
 =?us-ascii?Q?Pyx/xZ/E9IiKMwMi1B9i+537lzm9hU9Nq9OAN9jDBKtCpQFC/YhZ3wYcmdHg?=
 =?us-ascii?Q?jhIiBX/087hufgo3Qpkv2qUEUWYuJqKGXliPHefhTQCgZxpSvAK6M8YiSCgA?=
 =?us-ascii?Q?1cfwgVZzsfSK1wO6DOzWPoWAyuNgNrjFua7ffqrkHbDUTEToXD0Toq3JOQzn?=
 =?us-ascii?Q?5y5NcGHqgxzXiSk8r8b7PvmS8aQw9KtJP3Pqyy7aLTCNhD7D+WfEMKwsxawB?=
 =?us-ascii?Q?Gma28y1DDBVyhXVfsxEK/5JmcLXfgKEtDQ56YTaBoFFu8+MJjnetUumzCy8D?=
 =?us-ascii?Q?gPF0bzke/uqMu9be77scakaxvoPTw2qwmH6AeElwQDp//P5nFhkjiKtCE6af?=
 =?us-ascii?Q?Ygsx/35UQSvvNHQRjgAj9bTalR7aPVR03x2E4E92qGeH8frMVyfj04nDd/3r?=
 =?us-ascii?Q?N3ZPkzluFcmtoQoFm1/T/9EL4HFOxgDUYpO+kk6kOXzQDqoZqU/O/SJ/1Png?=
 =?us-ascii?Q?CduOJ8jIoy81q8te4r+JXcFQup/hPmga+PSrd3B/dXHuZbiuKmcmqjbNISI+?=
 =?us-ascii?Q?JLDp5J80qb22Nu2GvKsULMtaVew0F0VayFcXocnqZCtjWOyiZThHLjwlN4/0?=
 =?us-ascii?Q?KYju8zLR8uIago9u0/RibYiUXWG8CVjj8PpP/sGNvvdzD2pUxde9eCXQE1fd?=
 =?us-ascii?Q?jDJWJR9U/CoB+qQ+tig3hYy834qqQle93ZLhzgEWZBjk9XMLhdKz3I2JG9oi?=
 =?us-ascii?Q?bpRtSFrw/CnLjE++cuMnVQmMseHlp/kRIXR3+W+LXx5dEoEaKecx/WD4qLNa?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea5c435-c71a-41c2-a2bd-08dc84a28347
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:27:50.2664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/Y8rgsLE720Pu0ZR1j7T3oW+LR35LfJKll4VNivas7wq9Lg9ildxEVVA7GgrNCpZYShrhXaSnEyJdgI+K9eeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5827
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

Enable CMD_FUSE and ZYNQMP_EFUSE in order to be able to write
ZyqnMP eFuses from within the bootloader.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 configs/xilinx_zynqmp_kria_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index ba42f0c7848..ac91dccbe64 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_FPGA_LOADBP=y
 CONFIG_CMD_FPGA_LOADP=y
 CONFIG_CMD_FPGA_LOAD_SECURE=y
+CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT=y
@@ -147,6 +148,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
+CONFIG_ZYNQMP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
-- 
2.30.2

