Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E94CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A6D846AA;
	Fri, 29 May 2026 05:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C148341A; Fri, 29 May 2026 05:26:44 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2071d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAAB1846AA
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REO574UhHXIctExtNIe5Ak+YIIpVAFHP+HBLq2ir2pTFviKxoSF2qFAA8pUJVn6rHUvpD8W4VkF4t9fiK7qUwqXKUpU/21c7MbQWIvU6w9pcPl3QSf6rV7Ugj2LQxPjTiHondHC9HZCB0c1S6EenltoLMPP2vJzyuth0nClIH4+/oGs5zqpf6RMkBtzHzo+5b1tXy9OfC90XT62KJjQQ9FO44fSCZ1gfK4QGvF9ez0kR2vOOP+WeALmUUlzD/qr9zwcGfXEo8eWSQydWTF4LUJs5URsMc9Ez8xZXJRMHDSsPvy/9jAS4YBQWW1E6gbHwYLTqvWTQzc3Y9nqS4W5Dug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDkiPPOUBpLAcBjMUVGcvRTOqwqfuXSe5wqBYWIxe0U=;
 b=J1toqxHw94qosEnwpaamenEmou/sQQ9p6e4NeGUVH9Aayt1Z03UVXToILFZKELY4102fzOTgaQMtEcTJuAGUiAG3phe8EwH5NqZJU8UR6V2mF5wdO0Svc2tZadbvFnBztDTABz+zK7I8XZW/0B9yXOu51dE2IiyGMXWz0SETIm0VwI3Y9JNfZ9Oxh6XjCkUanZEAOMIBksnFCMM/JBZbwiPRje/y6+RZfrYalr0x2ybB/upPwZ6y8QRZTGKOcRfHd6IWJJgPTCWMRS+zWrqjJ9VS9CRoB99uUEsK8XuM+28G4pHfXbruJw9eMFsXcZAvzHgZmLt08UDh3JGWmxIVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1210.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:26:33 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0071.014; Fri, 29 May 2026 03:26:33 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RESEND v2 2/2] board: starfive: visionfive2: Support VisionFive 2
 Lite eMMC
Date: Fri, 29 May 2026 11:26:24 +0800
Message-ID: <20260529032624.6868-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260529032624.6868-1-hal.feng@starfivetech.com>
References: <20260529032624.6868-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1210:EE_
X-MS-Office365-Filtering-Correlation-Id: 504ffc0f-cc82-4b9d-b65b-08debd321565
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3M3G9cNcZiYWacLBXOcVxpu8/6wq3BbXf2JUTvwdcJk0Gxo0dC5Zco3fVeYfEjNOnxwpslAAtRledPKEnW0Ms9UKd+lqTKTqcND0wpZ/EBorqB4L3OTAwomNUSuRAGUG1Atsl91A8AJwQ1Hp8S77aUrhUAq6C5ydchtm500wPfsbpntYlSNhiKhPk36+ExPaTPIZnZ/ih+n75lTait2HGlcUocDeOdwvAKfWHmWsacQpIa4RDDQYBE6L6AFPD2BTII/8MCDwzkpeH64W+BFKUtQYKqN0ieJ9BQByEkTFxhyxdpVfkzumkPh/xGP8VOJMLzmljLyndxU57H9t+bDnUQsmgKJAv0+ukixSjCm7T5uYsUBU9zpgebgjXsJLAG8r6WxPUH5Z7tRspJdcqeYj+VqaOyyjW6meZ25ERk4mY6lFHYo9LWaK5DRTQAT/mYhMRSMYrfsSA2NPbdI3ZNDHYG3GllLdDZt+ltgsMkVTUcvRVOXnwmVvimZPF5mNK8CuH8zHDG7A29IhGHEf9AMRAGQ48NeoLGgCc9ER1UMfE22/PGU0rwnPzXOopllwYO7/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NeeSwrSPJjbKAPrlCk0ZCE+tKsinXdXHqt3ovLUA5XX+bEIswco7ZQVQ7oJf?=
 =?us-ascii?Q?xK8d7iZjfboJvb8U3boxcCW3yOebryJD8NXzk0tONkdqIe9Ggze7x/HjL8XO?=
 =?us-ascii?Q?jBsKI/y6ZBexgk7VrY2Qc2NDT4J10lvy7NEO5FljTkEPhsWiP1wJeKHxMvMt?=
 =?us-ascii?Q?tJ1M4qT5etf2iCE6f4CnWEEysTl6BOkqqOlPqUCchrf9SKsCv9i5o4ZOZsnH?=
 =?us-ascii?Q?qvGYJvV4kPJL8A7mEY3tuczwXuYdES6PnWKneBwWGzEMMROG0vvMYlwrK2Oi?=
 =?us-ascii?Q?nkFs48z+sT6n5TGnbO7hehcdmBWiH8dcIi+tbJUb14rgo4XRYCorE5jelpEi?=
 =?us-ascii?Q?3qkKXBbzlkDxVjbZuVysepvuNZ8J8hEpK6HDLCSHZ0Z1lHZx5Bc8EC/lRA1W?=
 =?us-ascii?Q?iwyzZtWOyIa0e+ZnPkzhLotv71QMQLF1LgFWFul8X33zAyQ8XWtOL92wKoVr?=
 =?us-ascii?Q?Hd0Ep/t1WrvRidFi++NAGDFYgYYzIff7aTHJwqm9ujSsyMJG2T7SkMXfYMU3?=
 =?us-ascii?Q?FF02VYzSWLbt2qWB6SQi6D3Z57C02SRi6ZB8+Wo2Gxoctj8GyBOxvKTyGbt3?=
 =?us-ascii?Q?mMvLIofPNagFpHITCWPBMu3vR0ZnsCchRSyGKvLeudulUsNrzprkUVBQKvka?=
 =?us-ascii?Q?IWgzmuYt00gGzjv5fWlVJaLymkkrIfI+M//zaIG83rUocI+StScdRexSfbtA?=
 =?us-ascii?Q?UTZhdKf1qgszsYFKztyWHQLil0PFj8AWjdnGJsrBEJGE3FSaOaaz0+JFo4gs?=
 =?us-ascii?Q?xaA0M0d/OkR8Jni8KG1gaSBdo0oHZgq7M9MWPPUflTWt9m0xWv0OEKnCpiQk?=
 =?us-ascii?Q?7CR2vylYwzaUpJj8rlgy/jAoP41/2lPDenpd9SFIG3c1m/TB7dJVbvRPQ1ve?=
 =?us-ascii?Q?BnvMn1QqLHmlA0GMt3YEVa/X/vHbyaujuQmO/l7RqCVHsFq0iV264jeEoUJR?=
 =?us-ascii?Q?73VrLE4OKp1rzZYOIG+Ck14t9CBzOUtsr2WcnLH7FLGkeuAeVoPfbUEaiEKn?=
 =?us-ascii?Q?zAKWLjlCwhQhFM8kGo3q92g9JeguN5X8JBimNnJffD6W5x+Xp667YkMA0Y+4?=
 =?us-ascii?Q?cQbB3KH4isR/NOXc2IOsXJ+MfdNwABcUoRfpIX7q4FFsFJ6Obff/2MPMy/r1?=
 =?us-ascii?Q?yLf6KCqjYf2OLzIsNwaJ+52z0E+VbXZXEzzhIQXdzU0DU9Tpdj1y73uaUWBS?=
 =?us-ascii?Q?XAhRhrsO4Rk7FAswRgoJZaZqjvZkOGC6g1HBEue3zJqfCxkN7l8N1V4FV2lG?=
 =?us-ascii?Q?g7dAi4nlpmix/6BV1uE9UeElrQERAVHHOlvDcrWf8+VWRc4Kyo/vt68GyIi7?=
 =?us-ascii?Q?n3oE3NL318BjgVDWxSp/G6jyN6pj9vxPkwQ6pku6cfdL/2wBlW6eRW8e3QBP?=
 =?us-ascii?Q?b5hfsvNGpZYld3nswzBNjtmIoFZ2UTlqPwkBRHtVocpo5WGBIOcUWnYELV46?=
 =?us-ascii?Q?IdJ0ZVCf0BT2+AF1KDB+UEsxcvmX2vlfYjVzOy7s4NmfTykofoAOzzT8wKeC?=
 =?us-ascii?Q?6bEpW4yP0H7XiWdzdDjIpiGPlUYphB5unupU/SnPEaDMX4ruExbUzOiqnfkU?=
 =?us-ascii?Q?gWduIqkYTihUbO7o32i1+w8/5nKea4kZ7bNjHxV+J0D4x45ypVryjgsZhzzq?=
 =?us-ascii?Q?WxEdqWsY1FlEN5RUpLRklpJKwqKOTtBf9sb+CeaXJe3+mfzRPz1AIyCJW+3J?=
 =?us-ascii?Q?d8K73eHEZO19sbKFbdJzdQbrwOPSgcfBHWrm6Ff2TtX2wYJ43oIR2S6mgYu7?=
 =?us-ascii?Q?VIBxB5JhRQc3YvswB8qihtHC8z+frF0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504ffc0f-cc82-4b9d-b65b-08debd321565
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:26:33.9289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7ulXu1iouayDai/iQXNkPlWqNW09Hz8YHa2W4pV4I31oVylxdeahJKp32bIzbE+Pcdac+H4eb880WTXKD8DXRRGP3uVkbgC4wDVBsci31c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1210
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

Add emmc detection to VisionFive 2 Lite DT selection and
fdtfile environment variable setting.

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c                  | 7 ++++++-
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index e231467f2a1..1b4d623d002 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -144,7 +144,12 @@ int board_fit_config_name_match(const char *name)
 		    !strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
 		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-lite") &&
-		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
+		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8) &&
+		    !get_mmc_size_from_eeprom()) {
+		return 0;
+	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-lite-emmc") &&
+		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8) &&
+		    get_mmc_size_from_eeprom()) {
 		return 0;
 	}
 
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 1a76f745ec8..97f40715f8f 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -72,7 +72,11 @@ static void set_fdtfile(void)
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
 		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
-		fdtfile = "starfive/jh7110-starfive-visionfive-2-lite.dtb";
+		if (get_mmc_size_from_eeprom()) {
+			fdtfile = "starfive/jh7110-starfive-visionfive-2-lite-emmc.dtb";
+		} else {
+			fdtfile = "starfive/jh7110-starfive-visionfive-2-lite.dtb";
+		}
 	} else {
 		log_err("Unknown product\n");
 		return;
-- 
2.43.2

