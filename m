Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14FED1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E25789161;
	Tue,  5 Nov 2024 04:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27F488F95; Tue,  5 Nov 2024 04:45:10 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B624888FCC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIYoXHMq+yPgoSlaabUYaynx3f4j9C7McfGrxiIg436OApIefUOOAtIpdvkNeW/uZKJEEmdkZPAVMQZ3sOAi9dwgBwENSfhxJf2SXWYVb6vRoHtDoKV1DVThewm/H7GHmXtkoXaCbnYQQGOfssy2APkKODsY4CapXu1zHeKp+IIG99kXq9ubXtKsOw+6EBnJtlM+wpLE/kA7qomRcvriJ1jWp/GJY+VBCxSS98rqng2TiHWGli+4hHy1nSdqgUxygglVc70x98E5CB8pEbtthGPTtOGsPymm9PN6L7ZPRv8BzMi8f6hffIySSBt8FcNOjRaLmVvYYr9ib0ISLBArXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBHJJp30lHUkjPj0ri4VWOhD+dIkoMv688WXiK0fbKw=;
 b=BlCbIbcRYpq1BJzp3STEVQ2lUZSfgMuxY4TdMBDUIWPSm5mLE25OJSngmIkStd7Hq14S+sKP67S27p1vvWddyqaSBJm+D2l4bEdKczTElWuND6Wiee2GIpcTG+12/M/FFKRdDm/SEPOKtTFBPjQAe9xifUJRHe9N4EnvyzifzujIdjyrFmqB7K1i24RX26QQHlDEOxw4p+phhXGPYA9EuaH1lM8Xk+1woNxtaZWLhTeMIdM6yfMADE0AaBcdJ8xvSHbyndjVU5z+571n1X8je88XJwOQFf/p82Ey4BUUMkU7sHqyoz9bVEoki8aTNjsVp1nvGg5y3ufKFf4hwY4d3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1242.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:16 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:16 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 12/13] board: starfive: spl: Fix the wrong use of
 CONFIG_IS_ENABLED()
Date: Tue,  5 Nov 2024 11:43:27 +0800
Message-ID: <20241105034328.56439-13-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1242:EE_
X-MS-Office365-Filtering-Correlation-Id: 132866db-0bc0-416f-f5ea-08dcfd4c42b4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: MLobPDl25/3E2uz4dx7cPDSs0JBi7S3B/LWa0Z1cIDIYAwQR83WFitJSNROgUNfklY7iX9P/62YdyCPzm02e6CWhwb3aYtIaMUpDfEAIpHJW0yBm9yufB3GWGUAiYtxO/OM6dohhLqkYbbUd1RhPKIhIBO/QeLL0xK+LxOxnOBYboaYEBVvZuWgfX2nVwVJvlEGmJo6JBaTcO9DMiyqjtQTp9li47AmkO+dWxBxmp/QJCldd7FQN26IBqWXkUb8A8Q5XCGAeTXx0BLdmg0Fl+iykYfdvzl0f2RMox/9wiUzAyNj/D/u/E2svqnJkqJsgnqwAdZZendjhPxQbPrVApJmyxABg4dJRg63yaSskO1UOqsZSJYRJ5lCTC9WdXgdafFbaZzdoEBv+QVM5E1Yv24PWTfhAEMyX6AR3UoGAMSXBTsA/OfI2u9g0FdW18iv26Q0FJzt6OGpn4k2JpjOVC7MY7CJqWQzBj/F7qH15lFqEh2YJLNUrb80jt9MUzHHV58iPTrTgNq6S8mRbIMBu9Ms3l9S/m0Mdcn0VXnEJNHLOb+yA1Jdzow87gwW9zyDUGuQExu5l6HQaQxcoSzN7vF/GnWiLbbfp3iR5e9XmfFTK0oNrPpnrjqzBKC0xgUJGeWEBNLFtL6OXKOTRcVXFdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8FzX6nQnUpd1O1AokBwnsvEOMrYmX/i1maZrpCD9+HZBrsuUra66qYgA45o?=
 =?us-ascii?Q?VrBdUMo6heEm8mtJGP3MdR/E3Rbsl0ZnWps3OsHdk61GeptLe3pNy2xpXurB?=
 =?us-ascii?Q?cacDLAHnfPIfJzjGJv2fNw32hSBWQJCFoU0Kp0vQeReN8w6S8ENMiXS4FN61?=
 =?us-ascii?Q?0oGS7gK3gEYTgCwqhX1Q62b80qpviJv1t4b1Ljyo/152kbUw/zdP6Q7AsDxt?=
 =?us-ascii?Q?NHnaZOfOnbKl8+TDxSVTkbArstVLRLQ9EcFd73n82V7AHQEiAZswFNBvVQVb?=
 =?us-ascii?Q?Tw4zVxOQdnxROE0IKmCpEUTj2+ajk6ttzdhJM582ATbXdgx45p6m6cZ7J2B1?=
 =?us-ascii?Q?eLOEF98sbeEUwgRfnzOY1+2/cszeVYvzyrJ6qP3iVcNm6x4GhnSckCuCOnFY?=
 =?us-ascii?Q?3ZSBJ73RQmjaeWeObBFqP6YGePT8wHpJsZg9K4YvicuDvwKI1LL82mYTVu8T?=
 =?us-ascii?Q?vsTBqNtxLbEu1fP0DbzXFT6gsIHegHaLllzU86WMNVB4jLXNa1PCLAagn3TI?=
 =?us-ascii?Q?1d+61b1NYs91umoXMqKK/OW1q1nG6tIIUFqjojS7P48dbKJOX3qWThVxsY1Z?=
 =?us-ascii?Q?ZCFop/xn9IRcWJvXx2VpD8JEMzxRCIQC1UX1X6bNVGxrSm8ltfqCD9TQn6Na?=
 =?us-ascii?Q?COX9KokrkrmHMIRVxDu757ygQDgFBUq7ZRHPJYGpqJcffVUVan1NRWjLOCwV?=
 =?us-ascii?Q?h1tBqjG29JnYthDUZfeZGfB2FmAl2GeNOFcnHv1vitlYdUaFUR8Keqbs0maC?=
 =?us-ascii?Q?F/v8ZNRMImPkGSrS81hw8iviybaOJG1TYunAzkG9yKU16Rz3/xpkbktwFWiB?=
 =?us-ascii?Q?1wygPmPw6qsEer6KNANCLHV+WA+uBO8Kux0eP3o48RcDt+T3OU9Ss0MNlo40?=
 =?us-ascii?Q?tgx+nbeovNLnhc7RYYIIYXAilUBFQL7iKQdY64oIDhl2/5f6iCg3kFOvvXKt?=
 =?us-ascii?Q?VdrN31Z5qJrzaIw6q4u0qqKR8DR2FfaySqWy6D5llaUnt2QmQrPnlS5xXuyH?=
 =?us-ascii?Q?Q3EVQddBkjsRd0vFW2V+qpCBokjTKpjFTtZJIOvzATHvjrpURzfGH9jjW1la?=
 =?us-ascii?Q?o4QpkxglpEj1qz8GWOirrGcmUvQ2AcVT0ms2Vbr42M1Yu+3KyU2x12QW2kKM?=
 =?us-ascii?Q?jTk7C3r1syB18l09XcOR6jKTaKpcD/Os9PzCv3eya4h8uUnoluvleo3cSZKC?=
 =?us-ascii?Q?nim8PIG1X6krzQANuOusqcayM2+VojmhdcbxdFdilTZOOWjtNlOFNq8/f5JI?=
 =?us-ascii?Q?pb7bElKFBKep66ZgQw5hqh0vYCU8FjlN8rpUWFGhbktIqxFVk7pcDHsF64EY?=
 =?us-ascii?Q?PoCVKe66LoXLizYYv1rsISUSDtRBzaUfrtpFdF7kapi2drmu2jG1o9hciurh?=
 =?us-ascii?Q?oxXV89NRIv9zsfu2odIlBkI7b7+/jmAyTnh0gnRQipB0lJEMsJQX1tRwPvjQ?=
 =?us-ascii?Q?S/oghn8zFQtfbdkXCV0C31+bzE5FByTjbfN9WSD9BDyKX1LyqdFWQVYu1Q4a?=
 =?us-ascii?Q?s+EEtWX7ek9Dxuu1NAt1t6HVVRCFOnED/oClPFm9xWB0rxJl7QM9/1hhxVf4?=
 =?us-ascii?Q?3pntDwWVkOug+qBWsalyes+aSsTTtowzcmy5PzTWAI980ftg3lvx8nGHd5uL?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132866db-0bc0-416f-f5ea-08dcfd4c42b4
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:15.9540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyVS5CokLAQ9yz5ILO0SZcSqEEzZDoyOulr9w8cCgT+Gg8SWOkukaG1nKoJspY3GiUsc0xNX078d4K28KXi8r4Kx3m/sGeUA04tBWzVj/E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1242
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

The prefix "SPL_" is not needed when using CONFIG_IS_ENABLED().

Fixes: 5ecf9b0b8a75 ("board: starfive: add StarFive VisionFive v2 board support")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 38132ecccd..cf7f39d5c5 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -110,7 +110,7 @@ void board_init_f(ulong dummy)
 	}
 }
 
-#if CONFIG_IS_ENABLED(SPL_LOAD_FIT)
+#if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
 	/* boot using first FIT config */
-- 
2.43.2

