Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880A1D5AE72
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 08:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E06E58921E;
	Thu,  7 Nov 2024 09:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="zO54e0yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2EAE89229; Thu,  7 Nov 2024 09:24:10 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6AB891FE
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 09:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDvD3/sKFqhYHnH6B9DjXT9uVtO7BvIxnN9ZRH5/GaTeyNYNqDH/8xgJjYADBEp/ulvRbS8BRE8agZCWDMI7XxlHMPccDk2z1/HpVRwNUWGJonzdhjkjKGDoWXOfmIrR9FqJoh+ZFP2nYqpuQOVnZNU9Wj4hta2rJBluc/Mec0bl3SWOeZsQ9XIb7VL3lVBGRXGJ8uAMw8dA+vgHhRYxQ0HN4C+nmBs97wQwKPKk8HdORexRNC406DsPlmZh+z+kKIQzpy5BYo07k5U+acR9c2sXOSKRQp65Ix2YpqFxYCxyak6AbJ34bE5ugKCIpwkz8lBvsHStKazVY0xcDIqLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+3sngteZwThmBw6kKiyqCc/Q0nuiTpyRKZH5bOuoxE=;
 b=E+bIRNzA2bJ2vtAHjUhQ503nn5Ev38cbt793+gzyVvEDLKuCFCPwsot7x0o6D2WCK1tc2iIJYzeIBk3FREIlmFFChDXKSA34i0GxjfoXUdAMTTugKnP51z5RB0W12VjClWwJbaT+O+b4yb2oyX1PofNRcl0vkCPtLFeAhtaCa2oN0HV9hi8X3iaFkGvkxaIAvV/3ZxOjEl68PaJu070AcdhY1uIKC3iUxO3/1lB08c5IUFq53UDknQxpP8bqw/8HkBXEnA6a+1QJV0R7tOuWT+JWlghUujNmS2O0hKqlEtzTV7NW3DRSNRZsA64yweavNfTzxbGadmq87HfVUAe4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+3sngteZwThmBw6kKiyqCc/Q0nuiTpyRKZH5bOuoxE=;
 b=zO54e0ybhIay9d4Gq1DLxEVJY7qKag4mxECAs5J3PqkfnEI/xqVVjppuHYH/I5D3bO4JjbIjBxaW0wxq3zNdleydMPCEkUbbhkuvy7WzlPG2O5mWg8Js+Hm0lzJGzfaAy14iubUixhSKcaiZ4i8AwN1UGMXx64y8IX04FfcJvgI=
Received: from DU7P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::16)
 by AS4P195MB1407.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 08:24:05 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::92) by DU7P250CA0008.outlook.office365.com
 (2603:10a6:10:54f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 08:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:24:05 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:01 +0100
Received: from lws-moog.phytec.de (172.25.32.77) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:01 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 7 Nov 2024 09:23:30 +0100
Subject: [PATCH v2 3/6] imx8mm-phygate-tauri-l_defconfig: add optee load
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-phytec_imx8m_optee-v2-3-bbc3747a60e8@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.77]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|AS4P195MB1407:EE_
X-MS-Office365-Filtering-Correlation-Id: 0260d6cd-371b-4833-be2f-08dcff058af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWN0V3ZLQ0tXSUVpSVRLaFlIYVIxT1AzRXdlcitFVWlDRkNoTFpsdUpqN0Rq?=
 =?utf-8?B?Nno0Y0lKTEFSSjFRY2ZtcmNjaVFUOWdSTjJuNG9hZ0ZpVlkrQnE0UXV1Ulpi?=
 =?utf-8?B?N251VC8vWS95YUpHRDczKzlSTHhpSUJjVlVUdlRacmVVWHRvQklhem9pbk5H?=
 =?utf-8?B?UlNZaDFlSGU1Si9FSUo5WlQyS2xrOWJmN0tvSkJiSHpLUzBza2p3dDVNbHdD?=
 =?utf-8?B?d3VaUEVnUmcvbENiNHVxb0RieVh2YzJ4c21tdzJ5NXd6ZytnTnNqV2JIckxH?=
 =?utf-8?B?WXU0dTZJNVVzQkNhRFp2WERsa3RMaGJzNVVMMWwxT001UXZKRXJpekNwR3Ri?=
 =?utf-8?B?aVRzTVVLTTZBQlR3OWNWM1dpTDJJTkwwS3Q2bEpuck9SeVZ5Q09BdXFreWYr?=
 =?utf-8?B?RVlqYWVSaWswY0g0QURXOXAxbm1acG1pb0NWaU9yZEdrdUc0TDNFa1VBTk1q?=
 =?utf-8?B?QlNTYWtvYi9MbHh1Nmw4OTNDOC9yUEdkUGNYUy9yRHp4NnJEWkNJa1hwbndT?=
 =?utf-8?B?L1NQbnlkVmdvRmR6QTJGYnJwNVp3Z0hOYmt4bDJZYnVoTXNyNUlRWnZUZ2Rj?=
 =?utf-8?B?K1J5c21FU3BHU3Z3L3hKTkFPbjM2cGNsWE5EZnljd2xVbjFpQ1A2V1BWbndH?=
 =?utf-8?B?OEhUYUk1VUh5U2N1UzV2ZlQ4dW1CaTZMSUw1Z1lkRlQ3UXZPSXFud3lxOU04?=
 =?utf-8?B?aThISkxwVWhzOXZLMzN5KzNJc1d6MmhzY0lBWWRGVWdWT09USHpWWXMrMzdS?=
 =?utf-8?B?MjF5TmF6MVEvc3hLK3g0US9kbW5IQU5memt2RFJJN2Y0NXRNZVlJWlo4Vnhz?=
 =?utf-8?B?QmhXZ2VCa0hDaGh1N2tQQjFIcURFQlQ4WngvOEdySnA3QjY3bm90RlNDaEdl?=
 =?utf-8?B?bEVpeHlpcEdid0toUEhWSWlhYXFGZytrampwTjBEdGtVckRYcmVoKzhvZ0E4?=
 =?utf-8?B?NnMyWVRwZVIxMC83elNFOWZRRG95L2xwT1ZFSTB5TEhXWkxkMmZtQUNoOG8y?=
 =?utf-8?B?eTlUSGcwQnByTVQzNUtEZFdxVG5ZZjlBTE01VXhZbXByeUJFVFZESzJGKzBi?=
 =?utf-8?B?bWxNb2RhNlFoUGlxaHgzMlhzWEZjYmorUkU0Qnl2ZnlrcTVsZlRhSnVzbjh0?=
 =?utf-8?B?SE9vcWl6RUxsQUt6UjRsQis4TTRVYUlySWkvKytadXVlY3JwTU51d21mZlBP?=
 =?utf-8?B?NWREK21XUkxEZUR1d2hLQTNxOW9wRTBuOWlGMDBLVldVZmozU2hHL1I5azFu?=
 =?utf-8?B?MWlSaHBxUE5wZXZiSEptQXB3Qnc4bVd4VkFKVDV2Y1NrMlhmWm9jSnNkZTRW?=
 =?utf-8?B?Q0JuT3NtRDIvNGFlZXRXcmRrNnRoU1hjNHZRbkdwWnl4M1RXMjZ3bGQ0VlV2?=
 =?utf-8?B?eW8vaVo1QTBTMGpQeU8xUEN2YXNoVkM0d21xb21PY3ZLZEFUNHBKemhKUW43?=
 =?utf-8?B?MFREM0FMOEdEcWNEQjhVM0RBQnIxR1dMZytKYWF0OVhZdWoyY2U0TXJHY2hH?=
 =?utf-8?B?QmlNdlk2b1c1ZzdVeXpjMTdFdXoxbkl1U2UxUTZIdDVmT1cxVGc4K1lGUEJm?=
 =?utf-8?B?Ti92ZzhLWERMQml1all5aSt3bzJaMmtRN3hLWURKV1R0WG1tckYya1kxMGVj?=
 =?utf-8?B?a0gwUjBUM1dKYTlKeTcvU1k4Tk5QejBtM3lxVE4rTzM0UElIdldyeTN1b1pl?=
 =?utf-8?B?czdJQ1BwSTZ6bXd5M256ejI2aVpCcTlsSTRYckJSeW1uaUVGd2U0YmpsREdV?=
 =?utf-8?B?NldNaW9Md3F0dU5rQml5aEJPWEpVZ2xwZmJlcnN3R2RZaHoxcUFDcGdLRVhi?=
 =?utf-8?B?WmxhMjRHb2JJcHA3Y1p4M2NQdE8zOXdSb3hud3ZrSEh0d1FlRktveGF2S2tE?=
 =?utf-8?B?U21QWks3K1ZPdjMxanl5Z1o4dkVnMnI3clVyb1ptd0FITHc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:24:05.0266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0260d6cd-371b-4833-be2f-08dcff058af5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1407
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

The phyGATE-Tauri-L expects 0x56000000 address to load optee.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index c69fe50ec81..2e1071b4058 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y

-- 
2.43.0

