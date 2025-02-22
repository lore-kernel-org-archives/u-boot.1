Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E146BC021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 11:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D0B80540;
	Sat, 22 Feb 2025 12:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fjrtT2UY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5745A806FE; Sat, 22 Feb 2025 12:10:16 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C24801B0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 12:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgIp2ea85bk9oFdM4Iav8V1UHJZjlMnsVtbc/WO0vTWyg/11ojXS61YQLeOjpboNfI9xMQpYYHgy/ENSzTEHVTATHIuGjNFAV26R2uXCVKRExYHmpMgovaaM8P4fpPt20yo/ESoWhO43NT9mlZbeFUPCMxAy+twT6I50DAAv4NxD9Oy3NUcDeaT+xmtpUi+XEGZO3ExQKGNQ2qn4p0O1Jism8nNweZSuH11qozxNY/8EsHRGQ+vsqUQUui34/iNdGZ/v1sQ7QTXOfQ5a5PxwisPsY34Hrn/jWIRsPOBQN2KrucB3hOJXo5vjSiA443DkZxzRAgefVTtt7J82zFj1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvVgRwFXB5agrW5uCLgG7pLeW+tYpk2y6XZhgGnNvjw=;
 b=K2638qlEUbLTqbI7WhB8SGiWw85Q7KTARR0yvLCgf+09ls/qt1qzg3qWmM5sSFmVu5N/T6+QSL18PBHAc9zPoPxpr+VGJ1HDJg1dhQaE2xQZw6frwaZ1BSal+Dsj6tgftELcTOup0hxkCQC2i0U0l5ot/L2lgT+yvN4sZ/QtvbhFB2UlEtEj2vL0Wa2I769iXsHZy3PK2/7rCdyv3/t98cVHjrNejTk2kI9vgO6SQXY4KlINTzCGyY8b1e8WnyGO7oavkqjd8YoYAs11vv4P3ZvXP9BviviO0aSJ86503pjnPbunHQdWLQW/87dpFalrUqIoHQNU/PVRgcAqD530Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvVgRwFXB5agrW5uCLgG7pLeW+tYpk2y6XZhgGnNvjw=;
 b=fjrtT2UYScTBdcEjfJRhA9I+ZLfcInDNTdXm2NnnHvCotPhkKEGLfL6hI9MUn6Mg2X17BLThj97Rp4NckqzrGkidub2K3bx0HLPbM6TuhTsVMUfwCkVsD+lAcqSJqUqCAxwEVRlI9NcY5qi4I85xGjgg5xI/ypS9Y/BE1b+h3y20NZRfosH2yBsVSnuQks3G4OTSapLymmXNuY/8KtsuAdUyNqxnWthPGU2nR464rr7BViOQC+OSVtat7b11tSSQveJqZP4pxLji22PhCHo4E9BJFaO8466PjRep7Cpy8N6aXS9H1vzqgkKAgKP43DJJaqCB29zPjbWaeI4jbW9tMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10906.eurprd04.prod.outlook.com (2603:10a6:800:277::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 11:10:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Sat, 22 Feb 2025
 11:10:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH 1/2] imx8mq: imx8mq_evk: fix DEFAULT_FDT_FILE
Date: Sat, 22 Feb 2025 20:17:10 +0800
Message-Id: <20250222121711.6697-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10906:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b0bce4-512c-42c2-3551-08dd533178e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2o1+roUbZ44toQ9waYU5lFwFKKqwPg9zF4vipIFOelA9osEGTy1kpoAUqKjR?=
 =?us-ascii?Q?rlR2YmkvDbRlWasJib9LpMP1gwUFs5SqdK6pPzfsOJ61gYzimiaKkcgQ/T6I?=
 =?us-ascii?Q?qFV9TUyHoXKInKkI+kJ8wnXKBnWgbrJscyxdg9X1QNlZqyFwiD2Exo1EO9tU?=
 =?us-ascii?Q?wsFTmWy3FQ+71DMlIt1/NUU+9ZAhzVZc/GibtMTwJBzhLC8JRyUL6LFAm/Cd?=
 =?us-ascii?Q?2sQNLWrwVAnUtqW+InJ5sna99uJVrwpEJE5BUF7DkxTsPKfjDfF9gqSSDEQY?=
 =?us-ascii?Q?pojMEoJuWpORjyHMjqTFo+vUwCsEvF04lh1D4uS5+Qrk27l5CXwLZve0uTPA?=
 =?us-ascii?Q?G1q8D34yC5UbWoxxinN9eJV+of7SOYT3mUOxgAMM79jQ/Iqbx0wksxUdVbur?=
 =?us-ascii?Q?3fLciy2qhYYbigqkVbpLjLZJAMjrtz8Xdh4bgjh0BlxmKWkp57GsyH+T7IuE?=
 =?us-ascii?Q?VKgrDbclBvtAclgG9zmMGEhh8qVh/mECHtU8L9diT+2hvVldSpxIUHfDuuhD?=
 =?us-ascii?Q?tkb7SO/tjFrhln3WwSZbFK6+5ytHjgcw2TL4tYynTvgL6Bd+eM6ZCb9eTV2v?=
 =?us-ascii?Q?DYPHPjyqWlTuJ6tLGd3faIDNDCIpfQ9dEAGG33I8ITZ2y0UB4ORDuyA2HbB3?=
 =?us-ascii?Q?c2+RV7VfPkUsQ6OMGopUBsinxSCmyajLlRWqsQTcJRfPs/wIPi72PWUODZFw?=
 =?us-ascii?Q?1tqy5PBaVdxYnh7bFYC8HV7rFl6sjwM4+7aL8ZuJOC5HFBB10HurkjWp3heQ?=
 =?us-ascii?Q?iJJMdrM/k60ckWiSkRKDGXipQdxfbepq3jytv3/vNn01d/pn/2EiryLqZfUt?=
 =?us-ascii?Q?q9wU4oeIk5/WoRhOLJjkrf9oVqUlMDslVfSHz3BI+oka1dbSXXx+43JPTm9v?=
 =?us-ascii?Q?OUDbO4wstsySx/pKQCAY77Sj8uTBRAQww5rzT5qxfaX1FatuBSkdoT6DeLGH?=
 =?us-ascii?Q?zZXZtg4IJgituXUnLNHAdT8Dw5us2evyF9O+lPVQk5QI1uUcTBijGgLP+xWe?=
 =?us-ascii?Q?Xbr6DoZ85MfjS4Z+BIXlsC+S97uVqU622sL6EFaQSiphaP3rkcB61GNto3gi?=
 =?us-ascii?Q?e4LllPlSGjqYSYy6XIpKX+rixB4+meEGtikloC+76zEKwGISFcfIQGXGkQt6?=
 =?us-ascii?Q?Gk/HxbQYNZtrb5Bw6TpVKECoLHNfm9rTdUU2vLFQ1K+eYJdvchYMBLApCHN3?=
 =?us-ascii?Q?Z+/UVIpsC9gZ/s3W6KWl4fSgA9akHaE0IHPyMNYQkGsHnRBoyWjc+I/H1xTg?=
 =?us-ascii?Q?SaepS7QiA8lx2VSjBbY6Mprj1MGQUqV0vvgIpAnLxp9qjLfqQFwIisqks1Lc?=
 =?us-ascii?Q?4l3Bug5dfPwC+E8oDcpc9LwovahL7S1Cm/PJ25L8sGDLh/BLQiU3Z1LSiORC?=
 =?us-ascii?Q?3BUcCOYizqn6R3PdsSFDTN1zjUSaiN3st79Ejihvvz4QDD4Eu7cKaY5T1SyA?=
 =?us-ascii?Q?TI2Nt8Y3YNiSDONzlmq8PJMWH25cdQp+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Ki4/nDTPLcsdjfCQhNhIQnOpnPmD+ZoIKd6gRda2K/8gpnBMDMyD+/LGlrE?=
 =?us-ascii?Q?qRsUp7rE8f+hMbUJTZ3SheS3sDFWV09jdwN7+eZalE+UUzlZXJBvz5t6A2G3?=
 =?us-ascii?Q?I6O4qxwaLbW7S1WsbMnpJ46186B7MEJLMbf322t7eG6YdWa5nNVU2arQ4Zxq?=
 =?us-ascii?Q?iLLy6cMNrWPgmnIpFAVMxG2p5hTcYLwKcly0rdsCtciGKre1OltHVqzZSaRH?=
 =?us-ascii?Q?PUXL9ZJuqFv3RDnu9Woa6d3UUGGG0Q+Wfnu2UM+/DUVY84LzjXONXarof/os?=
 =?us-ascii?Q?t39HIiXfzmsCM1drbh/6F+iMcjKEtHEjHxb8/L9CWGT2OtJrwXtv2TNUYGz/?=
 =?us-ascii?Q?JjTGL4ar+UlW1gVD2mlUpVrYgzchwh/xwovmMk7QphQEIeFxBpqwGXyx7c4r?=
 =?us-ascii?Q?eM0zrRJC/mGs5P8cc6BgNnnkhNmBDqHA+7RuPzefiahg9yRDB10AXu0eXWWJ?=
 =?us-ascii?Q?hI1XS2s3KSaJfz5QzHKGw/bwkXxlGal7hhhjrt47C9h+aAh8PL+/iIQKOnrw?=
 =?us-ascii?Q?HoL6MIgJJS74+/8kR2MLf15EEYhX85JU5Q0/bsdy0XLSkPxVPPofXQb/OgCO?=
 =?us-ascii?Q?XhzRUsxTJf0RguStPYL1mLgoSzUgezjE2yohTn2nmy2ktag0BSOmPaeJ/gRf?=
 =?us-ascii?Q?TZpLwrFqWFR71lkc8axYJ4W1UwG5/x0sy1Rw5PaIMMevS3+T7YVOefPZ+Fdg?=
 =?us-ascii?Q?gDssXAlHjB6ykw40NqD39402duiwf9a+kWufXljhrqDGS5kZTlTQMh9HCits?=
 =?us-ascii?Q?3M+07jiBiE0g4TJhBD7H0JCdyG9+LzYnGuvfw6zwEpRiMFprjZdWXtRRzEfs?=
 =?us-ascii?Q?eYXyL2Sb7ncyuCZSED/m/yQr5D6bWFxZDMGf/msgCdyswjXyDoIN844lMoGr?=
 =?us-ascii?Q?BGeroaZmoLFwqZ3lBGkKW0znfGtrHq0cJD21nTgA9neyLhvGHTtodDQaUisY?=
 =?us-ascii?Q?BmYp6ZkOhauWEZT42TS/XFgAC46ugc5TWNEO6R6UByZqXs2Bx8IHYRf7PyLO?=
 =?us-ascii?Q?Vq6vQUO96mbUppkW1BcVpFX5VDdIDXQDyC09lNJx2/YcZZoGk4EuLtfIfmPk?=
 =?us-ascii?Q?Ncvpnx+WmEpnASZH38m3z+QVU6NE2CLcRWnYNwjVkE6/5VevOfCdCol9q74V?=
 =?us-ascii?Q?9U5vlwpG+R1JO/ntZ6cc13iFosj1dKLXZXcfT/tUfWzIHlODOha/xGgSzzLH?=
 =?us-ascii?Q?L9Vt5HhdEq2ayjF6ZqZTC3ILlwh/oMADIfYsxLmv4G+cVKM78wRYvfPepIDh?=
 =?us-ascii?Q?818V9K9Svf6SsCDriXtZkT/SuPwbC2U2zAKTJEc+Mams8oUnXT8IZ3P22RV9?=
 =?us-ascii?Q?IrvKpvtZ7NkBdCCT6zBHRBa2hz6pNu+im67TbqA9Oaw+S1ivz/OHh1Tv+DsY?=
 =?us-ascii?Q?6vtiyLy5vwWntbxTV+9k+AxfKa54Lrd7YzL1w9h2gtLH4vdmh0lWX1ZE1jKE?=
 =?us-ascii?Q?4IK4OBXb/JII+1PhtCXZ8QV+eig0kHq19d29YNDpZMZHBwrkHR2jmbZH6eeG?=
 =?us-ascii?Q?6LURJLq0iUR/4rDXpOxs1TGUc/lOsWIUK+212hmUrgHGV18T7TQjmuvbBGcL?=
 =?us-ascii?Q?GsQa2/jANPmxnF9B9lPtZwJ8YHdH+nIR9jzqKvj8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b0bce4-512c-42c2-3551-08dd533178e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 11:10:10.7255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NmkI6sFw5boGNCX79+eL566YdQE3RT2zhBStjmBoih8DGOTSScFNaAFEk5jS+2GU6VIFF7QSdqXUGfP3GOH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10906
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

From: Peng Fan <peng.fan@nxp.com>

The CONFIG_DEFAULT_FDT_FILE should be imx8mq_evk.dtb for this board

Fixes: 7050bd925f7 ("imx: imx8mq_evk: Switch to BOOTSTD")
Reported-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx8mq_evk_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 97ef352dfb8..0de98152b2b 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -32,7 +32,7 @@ CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
+CONFIG_DEFAULT_FDT_FILE="imx8mq-evk.dtb"
 CONFIG_SYS_PBSIZE=1050
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
-- 
2.35.3

