Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69612F8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B072784312;
	Tue, 21 Apr 2026 14:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B/YIv688";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B58E83BC4; Tue, 21 Apr 2026 14:26:15 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7596C842FC
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc2Uo2d9NNRPXCzVp6Buz/g6o1m4IODXtN7J+gInpCRvjzlCElceKYZp5eRfFls1WI+BWpQwr4uW8Ak6CgClYYxvf5gVNO5GCcyoklsFoZmXiSEEXIUbC5VHAYfg9xx234OJRyq8UnNgbfbBSziSd1DgYCMdqMFEaDqkpovDkBYMYcvzowk8F1JtoUbxacsX9TDmS1GtDIhGdNmwOZDNvwk8e7DNy/K09MwzDgBa9bUrxIVW/WREWrUQl0GK2Y8GNlpDPDbDWBbzE22fYW2kfbkMBOQFjY3+So6+B393qLE5SL2gDJEybv3Oe/UTxXso9g8yHlVaAgo+gRkOQFF4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxJi/tGkqN3co7Sm42xFF8RUH4gpAr2GkBQnk1p3ggc=;
 b=vW+z919rkczAYARHTHT5hIDU/ig2V627l2y/EBpBwjaZXGi9rbTuM99vpguNXtXg10URmqXPm5vwArIh9HhNel3XXmP6qDbfIOfhCmi2JMWteby1S7X8B4swIRMPLlVUk04zxfWKIDsD7VdSS6SRZE8d76CFWkZLTr7Xpaas836HI29lK4s31ByTZEEEADZhJhofUun30ia2ktm/uMWrwgB+YgJMfTMNNCuQoqYXJEAWA/CxWr6WA1O6bHOa2ZCriCdXoIVGMqwOa3s5q0Qt1kgERQ/Z0b4CfjKNjmS3Sd4GCW5JAspzOKoeS9W3ZaccMIIg64rlRkqKi6FnFwKM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxJi/tGkqN3co7Sm42xFF8RUH4gpAr2GkBQnk1p3ggc=;
 b=B/YIv688RlJ0LKsmujW0yZk7UrJRz0lEbuiNcAu4DBLVTw1I1fl210Tj/3qu1EGcCXYVikcGc202iVXd5qHIgELyQl280Egp0Jp6TJMsx96nfsji4A21r0pbiCCnmJherPDLYq/B3lA/5+plfOJDQnlxPRQCZc3dGHes+QWnQU3a+yxDFjKPlDpEER6TJrR+tR8C6WrWogkv0fGclgKlPWRoWzANJhl18a2GMG3TXTUGwLR5KPGZk6muFmyGZADdAJdz4LQk1cVRiT2/9Go9xVCQBPDuJ/szGv5yRXcPFfoxHmqNNqmAhVxbWpTj74rsEuznco7SkZSg2XllIve4ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:26:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:26:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:24 +0800
Subject: [PATCH 12/15] imx8mq: reform2: Drop SPL_POWER_LEGACY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-12-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c5d1ad-4fa6-4ae7-7a99-08de9fa12b88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +FT7/r7PHeBCYyKd9/Oa3ekSU5ajH6lJKwnwDhfZHW1DUtJxEitqyctFHVuM4yQf55uLvtSEHzAioVrBuXKYtANaRzdfpEOUKzkbEJ1C/iOpFSzUjllB8Ua/rRUG/JG3f0C7+m+iKAQnnmFTYx5WrlN9j7d2dfv8+GRYW+QUSULir6+DcCgbIAq2vkhm97HXksYZ0SxgZ7eTb/s+lzU6QzlJWQ9f0cgTZvMwAaO4u4aE5UcVwUmEu9kCiq9K8J1BkUgmA1rhdkWqohbFN1x9n3BdopuO2XPI9IlV6HwAlltQVD+aYDMJoa+o+XdpiCqytEsQCTlmhfSw9bXhzqXxCoPtttxhRFOZFfAmlARX2hKM8PacvMeUF5U5JURE90OUfo8vmxiDGyXxMjhlNWbKn0sPi6wmumGftyxbEaJgUGD3g2rmKoyuIJvzz3U3mOoJ1+SRN8TUWVByOQnmSuOKi0XJcp01LXOXp+b7k6gpu68gUdKionOxKxCZT56CQXGga7ODZYTTB5L1cwVBKPOtfTDPYiBpFd7ytLfPuzA2vLbMxoNz8VMOQGAdSoglBBHDWlUlhDPHpAPWLNDZt9Dyy3mnd9t7saqTFtqM9lZdh7bgIAiEYnwh17bwrIWSaDx1zu8KuXlUS59g9peA4Xnj5mXvKKDAbPmQ5PwjfW9jAdEDFQqK7kIYOQi+8hxliVmLoaI9OFQc5viYfcyOXwLzjQ7+LaDKCdIWqxpRa9X6/MQNmh8sXYZry5J9lomGQXE+v5vIo9uxVkr9P2/fTo9DjB22OFyqs4TFERZqX3sUVSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0QyZkZtaEpYRHpSVkNIQVNqN0FtdnNWZDd0ZmV4N0NiM1NjRnN4c0gzeG9t?=
 =?utf-8?B?V3B1bE03MjdrZ0k3b2RMbW84aTZZeUdRQlJPR05BSHJ5dERkVzc5WUthak04?=
 =?utf-8?B?WWE5UGZ4N01wMERHZmYxdUZKMFhQN3IrNEt6UWd4czRYdXFBdklnWkpDK1hB?=
 =?utf-8?B?b3IxSnVsWWZNWWVZNjNVRUVLbmlMS0tNMVZJZ1NLT3krUG5ybTVaOXNvRDdt?=
 =?utf-8?B?WlB0UDUyS1VlU1M4MzRBNG0zOTIrUExkQ3pmMEdvckRrbjFtSWJaMzBONi9x?=
 =?utf-8?B?NUcvdlVGaGFaRnU0eTRHc0QycHNmRkFEU0VTRWpkTVFkbHRwcDBkYzFxelNE?=
 =?utf-8?B?SHJrOGtVWEo1S1Q1eDZlRHhHTVE1akVmcUxLK2dDRGZkMjFxR21kdVVzbENj?=
 =?utf-8?B?OFVoc1NCVENPYlBtYzY4SUFtNFNzd2d1WjdzMURjditscHE4VzlVRngxcHBP?=
 =?utf-8?B?d2IzV2s4dUVVa1dSeTB1Z3BxT05nMkpqSVJleWhIOWhscU5EaDNCbGxDcmdj?=
 =?utf-8?B?YlBJRUYzQXNLVGZBQVRRZzY5clM0dVpDaGk1ai9BT01Ec0Rqb3dpYzVGQUFM?=
 =?utf-8?B?VlMrMkdDMFBiVTlXVlJCajZmemxSaTZNZzV5NzlhNE1jcFc5NllreEtteXF5?=
 =?utf-8?B?cjVLVk1ZYnAvOHJ3TXVSanRwZldKZEtJai9GOFI5R21LSFRMcjhQemdPOUFm?=
 =?utf-8?B?ZHpkUk5nTWxJMXRjNFQzYUMrb0dOdnUxUVNRRUI5MnRsckNqRDdZV1M0Rmwy?=
 =?utf-8?B?Ly9EOWFkTmR0WjBOck5ncWcvNzNicVJSZFphdzVEdlhMeVJjNmVsWjFseE45?=
 =?utf-8?B?Zzl5OWNUcnVYMTdBbE9UYmlPWnBRcjBIMkYyQzloVC8wTEEzRWV3L3hBWEYr?=
 =?utf-8?B?bjMwcDh5aE1KM3p2Nks1c0pGbUZzNjM2aTVHbVpET3JkZnBOMDNFZjUyUStF?=
 =?utf-8?B?OGx2RSsxelk5M1pncEtncHhVeGZ5Z1RoOWJFRXNMUTFXYlpTK0JkbnVQNEFk?=
 =?utf-8?B?SVExUmN0K05rRDVFTnhoRWZjb3EwNE14OTVHV1Z3RSsrODk3aTNlRWhRSXpl?=
 =?utf-8?B?cUM1VUUzcEJTaDZlVUdQN0V1N2dDc3JOcFlFL25kYWtFQW9MWERSTjJNQlBM?=
 =?utf-8?B?WDNYN0tnaDJiaVdkWk9maGJDQ1FVQkFSOFZYaDdUQU8wUi9Yc2hVZC9rMlNp?=
 =?utf-8?B?ODdJQUtEK3dWdExSYzN4SnY4bGN1UjVFcVg4MW51cTNwZWgyNXNleDZpUXl6?=
 =?utf-8?B?QXk5S3F1VWEzcHZSOE5YeC9wdlN5OVBuUU9ZUUVJVXdzSzk2RTFPQ3d4cmFD?=
 =?utf-8?B?MlJ2WVgvdGxNOVV1WWoxblU3NzdxS2YrK0N6aFVyVUx6QVdOby94MFFVa0hz?=
 =?utf-8?B?ZmZHcy9Wdmcrcy9OK3FxR2Q3T05SaE95MTdIdUtWVFgyRnJzeFJjY1E0Uk91?=
 =?utf-8?B?bzNnTHZiUkRaVWU4bzhZZWxaUU5ueWFmNUd6ME0xYURrSFZmV1NUekZlWWlS?=
 =?utf-8?B?SjlxWTJ5UGZjSmIrd3lIV2xSaUlibEwrdEl5Y24yTmI5MmJ3Q3FSVmpFN2d3?=
 =?utf-8?B?QU5oYkw2MnIvYjBGY3lvdHoyZkwrck4wV3VaQWkzQWdVOVNZclh4Q2hkSGVk?=
 =?utf-8?B?MVRYTFZ3VndxVnFiUS9iZkZFaGwySzBQNGRVTVZzRUxPZUc1TXN2bDJuYy85?=
 =?utf-8?B?VkZyWEltcE5sUkFQaEJIUVFGY2NpY01SUEg4K3JvK0liK3FjUkNGRmVRdktj?=
 =?utf-8?B?UGlMWllhLzZvZ0RyN1dsZUtvUG9MY0lTV2owTGxCN2dWaktTbE9yZDZJZEFv?=
 =?utf-8?B?RGR0c055UEQ4YzNJOGFNS3hOUllYcndGUFQxZ3NkTVhHSm9kZERPb3RhdnJn?=
 =?utf-8?B?Z2ZncEJaZktsNVUvOWM3em1tM1NIYlFuTFMxTFdNSFFxdWJYWk9LaU5JcHV6?=
 =?utf-8?B?bnlPSEs3NEo5SHh0WXB6eS83bktGUytWUHhWZ09YQ0RsQ0RwbEFqOU16NVVK?=
 =?utf-8?B?d3pqZXN0Vmg2QVBRcHdpbElRZThVdUdpelNsUktmaXRLU0haY1I1SFdtNHJE?=
 =?utf-8?B?SkR3c3ZubVh3dmMxUGxJVDhjV1pZMThOZTh4RHo1SmVTRmpCQUZRbG42bmZP?=
 =?utf-8?B?SWRXWWp6Wk8wbXJ2WnlsWmZ0UjJzMFdOZi9TWTFyalczQWtaaHY2cktOZVFH?=
 =?utf-8?B?YjFoN1dQeWgrakJUZ3crMFZYZytMS2Z6dmVIU1diZE9QUjVDRmcwVVJKNUpp?=
 =?utf-8?B?d3FCditYakswTWR5UlRDSGJ4SFhndWxPNlBodWxWQnUzdm56b1pXVFFiVXZV?=
 =?utf-8?B?Zmk2NmpqY3ptdlUxcDUwVDNyTGtiQmsyYk10cEN3OWwrSHNqQ1B5Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c5d1ad-4fa6-4ae7-7a99-08de9fa12b88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:26:10.6249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7P++wzC02DxRq79LBl5R17Zj5DeqZaD1IGXxAC4cCmiNvh9pAlz06TZpr7xRQ8oZUzUAO8dqKaTj7U4hzMneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9349
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

This board does not have any code to call legacy power API, so drop the
selection of CONFIG_SPL_POWER_LEGACY.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx8mq_reform2_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index 572fb84b292..efa1b1ac1d5 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -87,7 +87,6 @@ CONFIG_PHY=y
 CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y

-- 
2.51.0

