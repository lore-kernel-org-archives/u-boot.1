Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18715EA7963
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 04:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E90D8341A;
	Thu,  5 Feb 2026 05:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UKnXqyYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30DDE838FA; Thu,  5 Feb 2026 02:59:20 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C4683015
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 02:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN0kzmTrit88XLyjyd8gpgZavcMAMkiXyLc/B07SMYlMJ3RoYe9iCgKzoSW0R6vZ+wW81LZeAFrp1tDyK2kdpsh4Des0zHEz8Xj/DcQzu9c6tbNkBlkTCaWeW/ofTutX3NFkXPu/V14/SzyWkHHN2YdLjKgIFkyiEW6jmXERQ1qOc0LKygXItJdNb/DkWyEPA1FCBOKbG/CfYU0DLrlqA3bB4v5lboaLmedJCQOD0zFKA8JHIYJmHHvCYozUDTR6T555N5FXH+ljc/qazxLrYPUQIrb/72H/e+54S70hIEBR6kvxI7/19xQCsud9C8J1jvzwrjGyrB7iDThxoE8T4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0GaICE7TiQl41iADQPn6jLI35zUuaH1ij801cZNheQ=;
 b=h8418yIE+Y6PxdNeNSlAIjqH1N7LXoM6XEhImDxQd1HD8zM6F89zoWIQfzS0bzu9RpU5LyNaGXVxVozcCr1GtKUYc8q1gqPH9HjD6MK12cQBHb+juMo2J86Y4QIJPzemkbD8sZ7VLyklEeLLtIc8mfbHEmIUHTM08uZjrHaZhWvi4XFlUfIqWeZ3F5RieHPHGnZaObZhpZC/CLlBDElYgAjxFZesrZ86w4OvGGvD7Mv69MEPo+Qj9c3+JDMcJGir6aedv1vdrj4wcdtOB/rKYI0S24hnsCVHMdQqCMXcLGeDoSO6J/d8D1QPT1jwHmdapLn96+hjrTI8BHislmjFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0GaICE7TiQl41iADQPn6jLI35zUuaH1ij801cZNheQ=;
 b=UKnXqyYLbyRycoqTls/DEIMWdotuoPDB/Ri+XOfGiwAVc2wkMiECjj3OzNdjwqNMNQR9qPAkEEpoIAAhtqRX5hI6XqC5iK5G9iS4NIP/4iKe8+OLkkXM6+f8ykj1zGInRyuJIgzOnYGEQTF1AHcaUMjIyeobJF7fe3dhrXFLGc5z9+fns50zvy621VvDOXr03lmF4KGLJLqmw6C+vqN/82Hbjix+YKP2kwHVR9RGQZxhVhkLveqscOQhRHI4RzjI6LGDenywMcBgWRNgiASKtj0XkWkU6M0Ke2c+90uR/u/C+yKMZDn4oxtWKqyWP3+pKgYB3MbcTv7DiRAP9qx/6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BN9PR03MB6137.namprd03.prod.outlook.com (2603:10b6:408:11a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 01:59:14 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 01:59:14 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>, drosdi <danish.ahmad.rosdi@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH v1] drivers: fpga: Enable SOC64 support,
 remove Agilex/Stratix10 checks for FPGA bridge
Date: Thu,  5 Feb 2026 09:58:23 +0800
Message-ID: <20260205015823.11401-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:a03:60::31) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BN9PR03MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc89a8d-01f2-4687-2b24-08de645a297d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2sokh5XxpLJAdUClT7kL67RtAQ1UTkNm/N7tBN7Ty/gg0OiWNndIEu53SFip?=
 =?us-ascii?Q?OA2ZruSvFElShx/PuZ/Vget33Pg9GgB0YV99SJSOoO2EDbgGoqJi8jlPg5tx?=
 =?us-ascii?Q?zzMTzAIJV+LjUobUY8dufeNg4Hs3uwIrgCd8IhHWk5mL98ZvNDV+oYx5S6/u?=
 =?us-ascii?Q?nzlEKgsQnR9TPP4sg7f2W6GC8asB1RoO9O+6TtXLbrTnD29BhyUPdw03HJbN?=
 =?us-ascii?Q?lPppyxomUKESdgnUC7uQVBX12FQGl0JJSjoj0iAF4dLAnvxkg53g9gJqGmtu?=
 =?us-ascii?Q?5t8tMiy97ZI6S/8OUrpIBSj0q1SyJY7xkaYBBu94pu07BwAOGv39lbh6XpOV?=
 =?us-ascii?Q?CdhvWuOAhK7bE/3yVU//QGaGsLdD9Zrk0aG6n/mKGGYveuENbiKO9hCmAXhC?=
 =?us-ascii?Q?NgB7QcVBJo6KenkUNrTOYgK9+u+b5gcQ0UyTKa/Q8PA7n1YqQqHPJ8BNexIZ?=
 =?us-ascii?Q?V6VrJ0+X8qzINcze0D7Cvbp1LPZsJvO40+jxN1LfihbzcToORfaCHl7S8+4w?=
 =?us-ascii?Q?ce0JC6HuK0wkywfT6xyMq41Aqd6TxkJu/2KK7pkA3FKw3sloLuTWC15MpffE?=
 =?us-ascii?Q?sgXq/iuJHPhDHNWAZ+ILJFy+6ef1ekwis8zfd/yzcl52pCoYadft9moxRbd1?=
 =?us-ascii?Q?uCBNUbCTy5Ta9pxDmC3mGtT5XOCxOIBPRo2ZmBPyBA8XFT3eXsfZL28JQl4k?=
 =?us-ascii?Q?5jUNG9l/RQZ9HXQtiCkYc9agT+0t8+leC/ShWvc9T5yzlm4q/EYX3frrfJ/Q?=
 =?us-ascii?Q?iQdMqJDSIDrDEhsX7PwbZDfjvpKZnHHDmda7OBewxC+bZFerSXa8/17B/itP?=
 =?us-ascii?Q?fW8rzh5pKM1M+Xyc8CPebkl6yVpx1eKx1Q3EuF6wW94gC3W8KWURhOWGSMLN?=
 =?us-ascii?Q?lc/lyiIXvURksU5CjItSj1KKRrrHbF/iGQF8lCJM0uRB66f/p5PNvaZJQ7Ad?=
 =?us-ascii?Q?fDTRvJqu4M+Yq/+bbZW85+qv1DJIXRj3lBHy2dNX+PQL6yw+wV7sKn/98CiE?=
 =?us-ascii?Q?4zJlHMD9vjQ3eKSK0w/9XtJ0YARWWVBgxs3Iv79cRW3E67Og8N1obekBsGFQ?=
 =?us-ascii?Q?rO52kdOkVF8FfLmAQ4x1uvBwmvU4j+iuQqEyIdV5C35Ftk71nJ+58V1MpRTX?=
 =?us-ascii?Q?/eNZZfH5zUsgQObMQY+IDUzxwUv8BM4tQwQzsJ1gFJS1exfp1jMha9yxMKXh?=
 =?us-ascii?Q?uaFMWHbSEmr5fmR8J5wRul986KlC8QBq14du2bhILrrI+DZWFrL3nPf8X/WX?=
 =?us-ascii?Q?20mAsfdp9eiZSrIT5Mv9E7qUkKbcQ2pcYRisLcMMEfy3+Z8NuGZ4BZ62r8x/?=
 =?us-ascii?Q?2aDfk/B750XbE0nXLOCjj7G1cNzrruSrN7Tzkt3GRyc7jGTOrV/m9hzEvBzh?=
 =?us-ascii?Q?uheUeTlqtA/nycV6nr+kYC3mjiB7MrDqDZZcgQt6k+tnuf7VEY2lWBmZTO9y?=
 =?us-ascii?Q?BUIurHWXTyoTAPTVzxWthWAe8vmtsJ8rXmwdUyorg1nTBO9p4fdTru0rZ/Gk?=
 =?us-ascii?Q?4+xpUd9TMlKyaXI4VXHuIdeaeXPNWPeS2iFT9BoWgtP5m6jjBuUvBn/ECqRC?=
 =?us-ascii?Q?LgdfTcwI9cfdivFf2cs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?96NxP4G9kWxOj7+vOjS4URd5bU+xpjAD2pLXr/9khh6LOG9CdV3YzRaJvPNF?=
 =?us-ascii?Q?Cw22b9JmK8pHkdsEeSmbeDuDDess/m/ze0FvM46FupeObQrw5cx01MC/+ZO+?=
 =?us-ascii?Q?MKuIrsPSWT6xn4X2YV7qPdyXHUf5hlv2Jry/nk+JxgPFIRkCcEgpWOdA08fe?=
 =?us-ascii?Q?HBlaxy/Mqapx7YO89tLZvR9pHovclzX5Zy8BcqT9ZSRP0bpTIi4PxFPMCAij?=
 =?us-ascii?Q?elwOb2wm8GNoeTsh0Zzd+nGAXVMaGGoSSvoz/bl2d4c9KhX9QXL6LYTVgLk9?=
 =?us-ascii?Q?KKyOu+6RjkKCJjX2/1voJvDG3t0GJtC/wg5U0aR03VSaPE8UH4Fj4q9e66pF?=
 =?us-ascii?Q?t1by6VVQ18TOaoohVEt565NlOdDZYGhZPo6Q3wjpXF9pi2NvNKmiJfg0ksdZ?=
 =?us-ascii?Q?Hed7oQDJjQTyA2E2MtbhazwsN1AaXZZDypSOmbTjwAj/PsORzHzxPvV9uF/5?=
 =?us-ascii?Q?09bgPTxDIllaocKqHMNSReRLQtVD8A2Fd2V7+uzrceOcyt+723cGthsIGuG4?=
 =?us-ascii?Q?PyO8pYtiA8vOI5GoHTsgi93YQCsB4h4PKZoaDQrvTjEtme2YVUq7IzGtKwHP?=
 =?us-ascii?Q?vPHt5slMZcra9bcqxMRJp5kX/IuTNU0UuGNOLHdpCxa4yRgVp/SjIe8rMiDJ?=
 =?us-ascii?Q?LUjfrl9mWxzYIXM+ADMp0miwyrH5feiMxMfYqQHo5CKWVPRinAh484TrKF7B?=
 =?us-ascii?Q?FMDXBHqhtI1Q2spdJDJfgaU1RjzAnqEe/tM0N9wv83b9BK+2OG3duKXFp42n?=
 =?us-ascii?Q?8OG3qQ9Iqpmg1+zECIYz3xnNhHeI2uBcXYEJaP0TUTEbxKfmrIaEh9fo9eTc?=
 =?us-ascii?Q?7Tw6JiMOPmQCQFviQ7R9li2zG5twl/BJPrJJV1mZsekJT7YOwRJzZAWFoeQ9?=
 =?us-ascii?Q?PW8/DINKvERmoAWaMUBlY2lS5oXDXkNOmvzrCKyOdv9qEiNjtKXLDXLBOyyg?=
 =?us-ascii?Q?7iEK6jp7FSP9MgrN68hTp+MQfXIFiZbxWOn/JbNJUK8RDo2YRClq7lQQM+AT?=
 =?us-ascii?Q?36fiYP1htcMDpG8DGl6rEPI9SdNa+4EZtLhK8oUyLIluk9MQwMlcIuYjuQ5s?=
 =?us-ascii?Q?t6zR0pKWg2H4fqWq7eaMc2CrgeMymqmynnPkTZS+UD5ElpEQh7gWIb7yjhDK?=
 =?us-ascii?Q?SkHcTsKtUnP//X8Hx4lgPY145ZSUk9hzt52AyL3fgox0rfCU0zGFWKpoAxsX?=
 =?us-ascii?Q?6Ds+feswQuwkw4mMyfnSDDJ2fpnGJw8Eo8ip5JpPOax5MeCu+fql/B5XcGL+?=
 =?us-ascii?Q?M4U0idHGHqU7IYM49unFGyth52Csv2zPikurMgyh4Qs6EVvpJJmtxxa84siR?=
 =?us-ascii?Q?nue5e3g0fQWq09c5RCLBRnWP+TszJ7FvpQ+QR+YzJhazJhwfTAkJBLyX9jmy?=
 =?us-ascii?Q?Ydbust1tKwBb7e6QbgJ/1CgfKHSihyJsguf+NMt/Dt7Pay//49+oiqxVqZWs?=
 =?us-ascii?Q?G6cVAeyX9BqLt33n5mY0u0aTN5guHVwQrK9u+scWLIgPaLd+RebBlKF3lN3e?=
 =?us-ascii?Q?jhDXQYbuoEDVox9Glm0Wu4bHCSA/psghyW4HCZJJu7+3Y7kbYgKUt/9uXNo1?=
 =?us-ascii?Q?zPn3JE6byd/mj4ABvEl3bpbfH4KqGEzVnaS5TYBUSdWz1oCExy8wR+V/+5DH?=
 =?us-ascii?Q?foreX6w0pKO1On83n/qoWGWVKWFtwupx/jXFd49MQ91evoF3XqMcYWwA7FW/?=
 =?us-ascii?Q?JWlirl3AiJiKgNTH7eAyux1ubSusEDU5x6Dp1ky2KSeiI+YduFcGjNH25re2?=
 =?us-ascii?Q?8IX5qjjb5A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc89a8d-01f2-4687-2b24-08de645a297d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 01:59:14.3042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqIJR1a5TfaFOEJXgl0AaviR6j3SUbdOSlaqALWBkqO7YTv0zuQ8Bn/N+ZVKpIxbInp5iWnIfheJp51Fnnfctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6137
X-Mailman-Approved-At: Thu, 05 Feb 2026 05:47:43 +0100
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

From: drosdi <danish.ahmad.rosdi@altera.com>

Replace the conditional compilation checks for Agilex and Stratix10
with a check for SOC64 in `drivers/fpga/altera.c`.

Signed-off-by: drosdi <danish.ahmad.rosdi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/fpga/altera.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 4a9aa74357e..246df72cb89 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -12,8 +12,7 @@
 /*
  *  Altera FPGA support
  */
-#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
 #include <asm/arch/misc.h>
 #endif
 #include <errno.h>
@@ -48,8 +47,7 @@ static const struct altera_fpga {
 #endif
 };
 
-#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
 int fpga_is_partial_data(int devnum, size_t img_len)
 {
 	/*
-- 
2.43.7

