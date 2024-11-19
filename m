Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1243CD60D09
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0C6894E2;
	Tue, 19 Nov 2024 03:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0300C8924B; Tue, 19 Nov 2024 03:06:11 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20707.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C66894A8
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CweB1qj+LM5iSHgBEdvgbM6gt8Mtich8ZZmuD/3OEUIDSIZNTFeimkf4n/jpMWa3Qs/YqMr7GdcN51xGWG1vE5hroyfu9b/mHkWaTSE1JRAGcHx3Kdv6yJFJP9a224gJZ8sO3v5LplgGwazYVTg/t1A/lm/rvfbnPW5w7eermg1yOtNvJmnZ7KC22D78XhOqQJzx+P2gqWj9ItvwkB+PYP3lXTAWfM/HzegaZJ+xt+74e0EV0QBqtm5K5z/Vs2aYOvg24oBUFarRP9xHNDSsvZh9HDo0zAgfzZC+ZVGBwjdVBIPGjvuQnHTW4MP2NX/SbqoDQEW2BUhRS2IbGHaxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UYvy18KPXU4zQd2ylcP+nnTCd7nnCmXLXdqhl+tbVA=;
 b=eY1kFD9GKNF/NQaeJ7tooZVNki8hunZNIOX5/Mr6DkL6LUAd6/g6y1dyW/o9F/XkOCAh8rypbGJ/1MW1AnXMcrR/RxeqPGqPsMWXTxbdL+UslrlljCPsvpCawwtO6/DKX5+tXVujqREuvjKzzMQaoO288p/2wIhEAeGPsPcWo5fYX0TWOm10Mg0P3SsYccSI0mMXqpoGaheUcvG7tzJsN8fjYlkwyjegiLHLVaEPujtW21RmdbnFlDfC3v7qLHWgwIAsQQO8piEosh05ahBNh7kAb37ESLkIYLELWv8WUajlwEVQeOXBvtN+lqmOcT9Wg3gC/Qrr5g34fMaoVQD8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:11 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 07/11] configs: visionfive2: Enable MULTI_DTB_FIT for
 JH7110 based board DT
Date: Tue, 19 Nov 2024 10:04:21 +0800
Message-ID: <20241119020425.51989-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: ca654d41-19f7-4599-5956-08dd083ebb47
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: pyDKabNb2HDzkfwIVbQI1R5tE+V9xgJR1q3lWm+zEWIijx/0W5JexqIFDgKs5LoNfKsSCXHjDWrk+eGjq91hu8VT2dE6SGLWdQ4aRxEhKJXgrWzYyFlN8Hda1GoAIrmHLPX7hjvfCRY/iVEhPkVAwU7V2XrsM3xic9VGQHj5O0F6ZyOp4ThVAU+uchlzCcHpkJ9tVG74ZaijPr+kfsPZVXrcYifkSE5wxp4jrXKIZ0VQot8ioktZuRm9ooMM/wzYefHcczx4OSO9I5+c8oglL8nnmGQd9B7iITUya6ybUucSTAyW5EYoxyvb+ZRmeor62fSAcz7OiEVMzbuMYjltoapN9heJlxb48d7PFMspqEV/QMx/yXZ55QNAgQQr+l0R4G/jh/fRcRpLdZpdpSFYbqTvKC5JDx9ieHnaqXS5HCTQMipT4iHEOSGG7O45cM5dWPT0akDONrwSQ3IlRxTahXi4e8i9cxyXooGIqyxD2DcmaWSJpaRPjYN5mp5YcXI9a+MucN+we+H/zg3Q0iS/2J5IGA30akH03wb0eYGWMPdAwbpRcdBAWqhpoOobdaEMeflBkBJfKiQzLhAGYm710qmkCCM2QFFcZQxlmGYbN8tR+ggATG6ym66JLgZuv0M6Y6URxXIGW2yim6J0CgCbFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eM4SmdyBkQeDRQdEZOYv+Ye9Pvc7hYRoj8d5WP0GwUzjSbfAZlrZAnD/Z4fF?=
 =?us-ascii?Q?9Izuacw1zCN6Dkd2fFbpnGD/9RLmh2tddY6RG2/o8L/9UB22q2mmQPyCTFxD?=
 =?us-ascii?Q?q1/BxoDXPOFvaGiW2v2XeM7JP8zMS5GydBf+2YZCLt0zCwkpw4YahkqhHJsZ?=
 =?us-ascii?Q?NsHG5AkJv0DU8CSPyroU9qNR46vt0LqpLhJMw0gZLEstBtSAs+Eq+4+Bdsrc?=
 =?us-ascii?Q?wIKWkZRY2+yF+uILUfyikVrXNivGCVM10aDn0lXxUaFKxCYFE7FjSy4Hz8yg?=
 =?us-ascii?Q?TV2rAEBjBziixdwXUjh/2U6AEDMcPfF5aYtxLLUHTbrfEpMpn3kgDvuTPlbN?=
 =?us-ascii?Q?Rrunu+YRl+vrE/5CVZulZJ7WU1lihkbH7LVXkDGop51GOAlMuB8WIUICg/b5?=
 =?us-ascii?Q?xVGPxvQYkkHjs1vb4C+aOG4TcfStV/nVXBTROpHMzCIBmrdJrOVTTa0agw0F?=
 =?us-ascii?Q?2ixsqQU8CKd68o5cfmD4veM2iVCoT5IFjOg4r3BNPixSTFQd+Gt2yqlOzbMS?=
 =?us-ascii?Q?aDg/QTY0RNJoGCNa/c/9TEK1264py6zIno7FGuLVmV+ZrRVAG8UhuRSkJfT3?=
 =?us-ascii?Q?jjrPBAxhtMjHGofRlzE96bYpNkB95q1hISYbsQ4Ak3rN5TJuEshv1ByZsIYF?=
 =?us-ascii?Q?ktE6e2sAbES0C2G6tCLgTFzZi9UyCECy60sAYxHZsWvMqunWlgRmi5sK8EWV?=
 =?us-ascii?Q?BJ4oYJZ+/wVDxwR2xASeTBYOpmlDu985UjV7KtD0jhcoJWdS7NKyTYxgYRzb?=
 =?us-ascii?Q?SsRQZuR5f7mHM/Gvf5ivrWtjsl6m0d08tvkSDh8aI5tQPNpQ7MLk4scXAle9?=
 =?us-ascii?Q?FSv/oY2i4RY+VzbwexzBh8TYtGTE3PJh0txDD7hQ8fA0hCbKuGixYIKXfhAo?=
 =?us-ascii?Q?hkp7l2TU/D3NNOBrCZhh+i6hNMvURsI4mPIiFSIFS9hz6fDFqgfCo19absjX?=
 =?us-ascii?Q?fAhntKJL2MrUOalD8ylLju0VahZk9/Ldd+cH9HKcSLDgk3A46y4jm6wd9m4B?=
 =?us-ascii?Q?s/PUUgT1NdvMSJ9KDazwcaNb8BonMX/3Ae/bXCY6nNruKAALcgVkHMGEvCBA?=
 =?us-ascii?Q?hCMjBJrsqsYhcIMW0wOyCGbMePahC6WL1xowhAWqc/TK1bR0AfVl0lrxgHm7?=
 =?us-ascii?Q?6+ky3lE8l23XcqpkQq1OjZosCYWSqksuXEp7YOPPNTlK8Dk7tMggb6qElrbZ?=
 =?us-ascii?Q?0rPXe3GuAC02uojrOY4/gankflIh0sOY5BQBG2UIg2bDabyomHQpLyhhHRp2?=
 =?us-ascii?Q?BSjaJWCTKSeBhzoXCDUNmxcIfqtvB/AquuXCuCIL607rpmeZUvHddY/o0bqM?=
 =?us-ascii?Q?suFSCcLLQjteVGYakJ5ywz5r2P51VKwBbF09JQbuh03WECKOby8H+xTLjYPc?=
 =?us-ascii?Q?buRVLRvutvJdsrUpQs7ArrqMMI4JAFhKD64G5e6xDYMaS/q/1cWewagjN5wO?=
 =?us-ascii?Q?+5EOFJOtwdwvTQ9wSHv5XMvWo9WvH+fugg8Isd1R/LXnZN2p4d2EHi3bkc4s?=
 =?us-ascii?Q?85yx42CqJkFYBRn9kS7NE20WeLv7KOAOssQDG1d0oTHgVfP3dkaNO7L2PIt3?=
 =?us-ascii?Q?zPtM4xCd0fogAnaVZnLXxLH7/BhsFOxAuzVjWY0+U5qGsHAaPcuQ4RE5A/UJ?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca654d41-19f7-4599-5956-08dd083ebb47
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:08.1127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WeseRTEN3NlF9D40VE3PpYn9nV4OaFlgq5A4J+8n7Zfl/TnsGiSCT97HItJG7TqyunCGQglpgHTlrYmtMCZ3aqitESQUKQuouHpMKs9yY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

So JH7110 based boards can select their own DT at runtime.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 389adb5e55..18b3c00ca6 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -78,6 +78,8 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-- 
2.43.2

