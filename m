Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029E2D13592
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286098901F;
	Mon, 28 Oct 2024 03:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7714788FA8; Mon, 28 Oct 2024 02:59:16 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B8788FD9
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBvChK/67LbECDZgJ1m42H1cv/bOwpoyQZQzAN9yDeTn/IK8mRkfPwgAiKNP05xhVZGMtgArTEEE4K0T6z8JqXG3FkM6A7iA4N4cxUChmPKDSBgtxZ8xNG15BGiElEN0HdU8/4xbEOVWdbZnyT5yPPk2QkCJLd4CAg7VZCC7AbXpbTFKmGHU0nlq/5CBTSItEPtw1fPks223pNfog7YvS5orRW0M61rTWDUcU3/IffuNIAlVvc37S7DZNA1qz9+gl3majOssxRFfYM1CjEK4TWbck0Qz7LrH9W0Hlxh9DrK2HBigiXGQXo3t1ESGjBpP+faLrCzOHvQ5+S3B4M0G0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwucyFCkBqqzZy8GJXGtUFhfNfmRKEZXoijktu3Dqmg=;
 b=KIG9rXiLuOaWEQhYOf+qYquSsoeCltsWqoV0ezBytHBvj926/Jx61js3cilNzGBNPiEgZTHTYWpD20BFALAz0/V5J82NJPUPzGj0eq+aU0UxQprbanK5xojkf5C86xlm+X8chzWnBmJpW+Edw4SIjGhiLBEMIe076Gr9TT2eDoJEgSR+TfOrQpPs6VDTUZUMX2K/7xEStgbsIH9U+e2f0dUlCXTVe+DMkl99IyJTZlnSA+fEM6J1ZOK62tKKE/QugsJcN9V0FoaeCYa7bVYHiWk043kkwFxLZbq94S2DwCXt1yfddWLLBt0KJ3p7NNneZfUo/58LsmPiHKGGk7SpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:07 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:07 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 02/14] dts: starfive: Switch to using upstream DT
Date: Mon, 28 Oct 2024 09:58:35 +0800
Message-ID: <20241028015847.42344-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2a2185-361a-441e-123c-08dcf6f41b91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: 7LlS4qq+F3Z8CcCNyMXZrjo72E9llElFu8PUJoA/e19Cxgze+PHE+V1M4oKFFUHBytNsupZXYsG5LNwmLAVwTmLZsWD+aZ3+X9KOZKzK4ad9l/NQFmkOcjFgq+GA0KZwFJCr4+bgWfRm4QeY47mRbziCh3Gl98Tg3AlS2Po4KAhsh15QgcV8UV57Bb14xiJxgqcm5HLDaK9WzImrSEPgVXQMzO1eclb0w3G3dJ8qFw4vwVY0lobzIQhX6hGKi8n/NcL4Z6+2bE3yq895aLUEXjQ/ldLSHvq0B/bJ50WaVG2o22Jh2x8nTP3I5cQGYg3yisyHvjqj3ohywaEP0Mrkn3be3wHltL7H17nhBJDpJZvu2c+IUqYqjJcp6iyB4BhB4M60aOhgNtZt/8gciZLxaRfiHTNBSucRq7yiThefHEzMyY999+hdZ1YuZsYNZu392pRKWXAhAuqsbbj1cGzzeS0qI7XGLKimkfRiaxp1wqA46fzDlehA82OJjQO3N0jkVftjHNGuI+yRHf0/9TWvk6vCv6TnVWF2OP+JIQZcuKe0uw7nqGEtvkuhsaKCxXD8FXutrKmi6F2pCv83FQLnTyE2Ym+AEi8VVkEsnC8l5WcPVtb07R3gYne7riED2fw4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GK8lFZNAyd4/wYCiTmKbtlWWlWJrE+0gpIAfSMv/7uWUteuoHWVq4bT39twI?=
 =?us-ascii?Q?PJfdrDNYWgf1KwaXjIhWH+cuyTjynVgvcTIC7DvXzktGM06dDrVxEGw7hzWS?=
 =?us-ascii?Q?bp7408CW0HtQKXWF+zzXzszoxKgJ+dAoF6yAtARaZ0yzqn9+IpY2H5ssUqFj?=
 =?us-ascii?Q?gDhIsKxN+vS9p2Y+ysS+immLErCNPKsEWx0f3GIqGL5ihb+mDAps74ACk8A6?=
 =?us-ascii?Q?nOvRfgPdxXuX3b+ZejmKzrPK41/qk1dZKfQFCxwVT/BK2VjLKvr+fERcbcdG?=
 =?us-ascii?Q?ntOhCxYkSdKtw+v3hk4C42MiqDduGNgluA9DnnN3+ct7DH+a6Cvzjzbo/SqZ?=
 =?us-ascii?Q?UTjozNJO81MVK5L/lei4TwZRZB7aUOyVrSjG/B91F+FXnDnpGKp668kZ2gLQ?=
 =?us-ascii?Q?QfCburq6HVxjeeCe1t902t5lQb3z8ioWUjrG/JrRWv0fUegHS0DY9JxUhUYp?=
 =?us-ascii?Q?4L3tOJ3jcm0i+EWvsgax+Qqa9HSkFYqv++p1eaKt8m+YuIjhV87YBo5SqAdN?=
 =?us-ascii?Q?uV3JpwLi+qbDYamOawHYtBo/nr9z58xBYBtKJJZ6TZIuXYTHA47IL2q9zs0d?=
 =?us-ascii?Q?JFoCY+42kk90rwLGQRmL9wtr7XGdIJNXtUncoBJa6nBkojZ8W40Z99/i9WUQ?=
 =?us-ascii?Q?XagT5tu9x2M2x5WCtF1JKgpWydi5ffqRl6gsrEiox0QQv47fry2Y0Z5pHyhs?=
 =?us-ascii?Q?XHZDFYbVGLND9USmOPXbgdkFn7fok99cKyO3RCj+6ZdtDpfjIlcCDV5C4mDu?=
 =?us-ascii?Q?6N05uobNMqboH8s0twCMaWPQwk/YVFPTbk4iphR6yuIxLDy4WZpZ8FU5JqtY?=
 =?us-ascii?Q?y9krGnow/Be/h05tTQquGZwK2rX85zld3FGh5sq/zUN6WlRqVboo/mpLk9nf?=
 =?us-ascii?Q?GbgzYQAnmxCtNbigb6Wz2YDfMaxhNLz77zfZKWMT3fe5yIhx0HGGIdDLCHHf?=
 =?us-ascii?Q?DYMwIbT/YeyQ+jSuTtoSIKQ0uHffpZSbrQH9TcCQMK0fIcBNI27sqTIZEmZu?=
 =?us-ascii?Q?+Ic2Gk7dM+J8ythihK/ukTLTpcWbgJGXFXJGciS3W71SrgpYpsA1BteNQE5C?=
 =?us-ascii?Q?iuJaU1ZnRBSndpA/iNB8xFl7DzYFmofMEtBrY96vHkY059uIy1xADS/ym3Cm?=
 =?us-ascii?Q?qtxHUI6/z4bNTN1rKX43M+xeYz8ZDvsp3H8Lj8d3hdMi8VO84Ku6KdDSenvK?=
 =?us-ascii?Q?kRDD1mvMywWBD6nBTjqwDHbfRmK1n+wZKP0CB1S4FWX5cx2Pv88ept14FWOF?=
 =?us-ascii?Q?HnrOtMQNHKWRcNGyYpL0sw+yGR42rGwsj1pK4FrgQ8HJWd4NBmp9t28DUyOp?=
 =?us-ascii?Q?VxOTCsZZm+cZRXhlI9n6D49oXv/BPVa1lEtQiD2fLfpCL+C0eFubX1eKDXlW?=
 =?us-ascii?Q?Y2KVO6Kkeh1cM3hAnxOmU0BChlm24HxTd1NtnxkVWizkjoUqYj9d97qYxRc2?=
 =?us-ascii?Q?GBzRdvsv4PjPxXj/gbT7Yq4eUs6AJ8wzz7l8ZulBkqSmESeFFHRtuuYo6xZX?=
 =?us-ascii?Q?DYHO3vvjhZzShUjuPx0Z8ZAiSNgCcztydEA45iEfDVkGg4bsfzbvJaxsrahu?=
 =?us-ascii?Q?8f0Tvx0tF/n3f4Mcura82LWiK5J94c+3lDmz27/Z0jTrIyk78C0XBO3OzkkR?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2a2185-361a-441e-123c-08dcf6f41b91
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:07.6004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDl8uzOhnnYbHwhST8NfxyR9QqtkCL8pR85PxJwAJHGqIrUFE879uUe60d8VnrUStALq1M3qAnvJGEFPsf0MjmHvuI4h3mYORvq+N3vOcl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

Enable OF_UPSTREAM to use upstream DT and add starfive/ prefix to
the DEFAULT_DEVICE_TREE. Rename jh7110-starfive-visionfive-2-u-boot.dtsi
to jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi and set
the v1.3b device tree as the default device tree.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig                                   | 1 +
 ...boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} | 0
 configs/starfive_visionfive2_defconfig                          | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} (100%)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index e5549a01b8..9904a60ddd 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -19,6 +19,7 @@ config STARFIVE_JH7110
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
+	imply OF_UPSTREAM
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply SIFIVE_CACHE
 	imply SIFIVE_CCACHE
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
similarity index 100%
rename from arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
rename to arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 511645cebe..e4ecf205e7 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=100000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xf0000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="jh7110-starfive-visionfive-2"
+CONFIG_DEFAULT_DEVICE_TREE="starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
-- 
2.43.2

