Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87D8C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2724881E25;
	Wed,  4 Jun 2025 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="cExiBNbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 077A881FEE; Wed,  4 Jun 2025 21:56:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0374803DF
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7lWwB5FPzH9xSPbGcTU28lW84WyXQGnqfTC+LzsHpr6Mc2+6scejAs1RMpdoK86ifRnq0hyocNb2imehcS/NGd6lX+b839KsSkYP658DNQ7nPqqYdNxv8TdWdLDvP9rN22IBZ2r49Vv4RFm5idxySpwEG1O+QGfy3n+9rAMocRYNzCvszI+DsvzxnZlnIB0BrNLsPuAaW7t5C3ym/SclKrlCGWMz1j2JTZDrxVhwefPWfg8CG1TqZ3H8CNi5Tb3ac+1WBwxsWYoAgU7MBhY3qhIpwc2bHMlBrx6zP9d04F9yFyJ7VvKEOr1IZyxKodTItNcNgVuO+/j1KsvyhV5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2cjm2pXhdN4R8YakIWGM3NbLwFvCxkuF7rlNVa+S8M=;
 b=Di7v7dwl55dpiE1uoVnE6Vn8yO3ShmkCCFvnAkQNWkc6F3RcLXlwMoCJN3P6EQBQlfYKAQL9G3wfDMIMTafAa+SYOl5E3m9KXUFWkOgMa5l79Ug99BsoqJubyIKX8cL+ChNvearibM8p920khpcxpqsF6up/DXQTSadDCuGgEdOqlk2nUDEGgWZVXn7RqXNCWSV9MRRYZRiJU5rUDxmI/xkiOJZixsK9mPKhBbgntPxs2gIwnma3yOvfpUkRTYER58sySJ8JsDu26g9gKg1v3cbTPHnOTgsJsmSH/fVr8jfMAIHTWLE0iwlDxFGnKuW2ahIb/fOHxGoeK/fxc2nQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2cjm2pXhdN4R8YakIWGM3NbLwFvCxkuF7rlNVa+S8M=;
 b=cExiBNbKwq90eF9vD4GuI0jVScyiyeBw6uo2YJUvM6FMMr1eLdOCxLwqVLpHko0CE5qtFL3vWpjmHzBsdciQjeh3Jla/bq1BthAuk1K4TESqbH24h2FT0ferDLVtBJAGBl5PjO15V0mE28DceYIygLwf8+NZwwfVyMdnDW/PAD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:17 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 02/12] powerpc: drop volatile qualifier from gd pointer
Date: Wed,  4 Jun 2025 21:56:02 +0200
Message-ID: <20250604195612.2312979-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0070.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::29) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ebb911-3a39-4e0d-a835-08dda3a1de68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hnkPPZri5S79ct7wUgBjfWIBrdcyntWnvHXt+na139o4wevYDkxiDdP1GucI?=
 =?us-ascii?Q?mxUicZiIb7coTJi+gF6ZGxb7Zq54ECNPxgdo2XmapfbGMK9B5T9rKICujtAJ?=
 =?us-ascii?Q?n4KyS3wlstK+emb0tBuaKK224hGoAqIo2RvX++kM5wWO9RCyKSd9V1e4ov2+?=
 =?us-ascii?Q?kK8CP5xT828pJ/Bl1IztPAheH3yuhg6TNyYYwN12o1+tnNg1XeaMZRpLAXvf?=
 =?us-ascii?Q?wfLJdbXc4anA/f9K7jR4Duhl92o9kLslDhoscsterQVIkaGZQ+nww6cKQLsm?=
 =?us-ascii?Q?ZNEQIecaPHgqPfeV9eiVQAc7Z3ct6fngKD94t7Xu2T98jzODJbwyotv0xbYI?=
 =?us-ascii?Q?TF6h50kPuv74tH0iAXrD5jecTVpDQ7T4GQihTdi1QHKpwDpd1P2f86wvrHHk?=
 =?us-ascii?Q?fwVlFR5yXG9ep3o5CTmyPjWqSt231C9SDtNzZOQejmP+Oy95pQaqEfMx4Eu0?=
 =?us-ascii?Q?/U80Ul0kldoIxDaKUhcS5H2fQATbk30yB93wWPxOnZjOsjDg0LGB2m8yi1mC?=
 =?us-ascii?Q?lS7NGDqkzG2xTntSGwhoJ/FWIkScQvl6TYjTHNls69qi0NEKvvTdBzO2ntQU?=
 =?us-ascii?Q?U1IZ66hBw9ex1zWZYjhM7VcxngN1fqVkzQAOH8NkTf+L9f8xhwM4heGg+mjg?=
 =?us-ascii?Q?fA+1CznbAVSATUBoReWQz9h2cJ9l+Yk41OR0nWBTo4Ozx8dPKdGAQ6q4wfje?=
 =?us-ascii?Q?mPZA5WKudAsuGbBGXy6moHQ+vWNd/gXZlT5Wyn7eMAFVWVKOAJUJXEmzE7xD?=
 =?us-ascii?Q?vRPBI8hSACSNz1dOYVX1toqSUVzm+MfSfAzTBGXP7bkpfyzCBZDi75iT/B1e?=
 =?us-ascii?Q?/IK4J5/IeMu9t04DSt7EkAvpdjrXZsWqjxIIQoKcrgKBKt5ZeJnuTXNM02uI?=
 =?us-ascii?Q?yqYGQdXBGjtZSbsrbrDGSzdJyBcoSZQ3a4DvMzxvLoKUYoWJHJwefn5RWPU7?=
 =?us-ascii?Q?5lyUTaO3ZVE3p5N0Vd0KomacI4JvZywcVVQ/BeXj9toGKVP4dIA64VSLsf7T?=
 =?us-ascii?Q?XqyEnWKaHep1VZwaxLkAum2nQph5Hn3KU36A0TPrTESFillOtlLWYBokGPHK?=
 =?us-ascii?Q?c+Jn6zmuBShqb5InIfyXyYOX0h7qhSJY3GAhfPlHPkUa5rOKMsJ0+53SWC1Q?=
 =?us-ascii?Q?ttysYT33R/lOFR8DT9YGzArkGpVsLd03Eqb0fNavNraYMVymhEAjE48I6Z60?=
 =?us-ascii?Q?PDJjJVae85ZGeezJIQAeyFeCNcT3ZoTkicLCrDoNz3HZHWvP/CKk8lstVfk2?=
 =?us-ascii?Q?5aM1BBHlaPTt3RbBhTyvKs9fm6n6VXQolXvrCbtLVCx7kCprps2Gqd7MP4n4?=
 =?us-ascii?Q?LlMKsOzMyqon2JPfZUAxfoVRLTUu5jXkEMhhINqYjo7ukxVRBAKAuvgeGGGj?=
 =?us-ascii?Q?DhR2D/m68sxBF12ibOVr0C+LQEBi2V8fGkZyQIUxzRQqR8YV6y8THrpYT5Bs?=
 =?us-ascii?Q?IAqedwPgfvJd+GPh+TEqOhUZDX5eZL54WJUWywNT5Zg336+MHxwIbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/omnKFpl3ZMeyz25aAuHXaqbAhPhAPDr9UBSAZA/v7FP4HhKeL9g6yvgPcI?=
 =?us-ascii?Q?p8xyPpp0PyWbHuGvQXTSGnKqAXroz/Cvr5EQ1nOSqJUqY2EAwUlVVMU9NSBx?=
 =?us-ascii?Q?Y2dVmCmgm+P9LqfIzZVAPiA2hBS/vEYppi6YuEnW/Q4e8HGtT55j6Yi92MR5?=
 =?us-ascii?Q?Oqo/kiBvpo1wV9R5bmVEoMDjvuvzyH93Z8Zn1kA8P0+eo2TQ2sIkZVLnfy8X?=
 =?us-ascii?Q?EVeIJcJW7OphCKaEYtLOJP6RC2vI2HkKAGXUo291Ns4Lx4d4ULdnDZ4wl3/4?=
 =?us-ascii?Q?2fPAcJA6XYG2LudK9grgKUdlYVrBredA8OsVabKe0T48Ac8dj/YD9ZuUlhMP?=
 =?us-ascii?Q?cOUmAIJlqAxV77NISs2/oMyLxrdhKSXuaQHUuA4wXc6kLBbYaw3KAyNr7AS9?=
 =?us-ascii?Q?GLKlnYWOTmQ3+WsgruLtRLCvUWRI7H+keU9PEYTe6oog80KaGQlk0QX1dAm3?=
 =?us-ascii?Q?mG+aDzY+m1nKA6uame0EWaDe+GJuPJOhO8s3Q5Lw4XjHC2PpyiFz/sz5XrpT?=
 =?us-ascii?Q?+1XdlUiPo0OEgBlyV0egEyeNKxR3ffuh4ujiCAbpawJf/9QZ+t1hZS6u4D2T?=
 =?us-ascii?Q?4b45Qmb4a5ttvleacYdqepjdIWGuLuJUOWgQfHsJAMQbK6wRYtUdIB2rH/ri?=
 =?us-ascii?Q?G/7l4Ne2uHg2rqFXl0seSdBlTV+Zlak0Lki1lmktMQtmpNzI5xjhptNC3noQ?=
 =?us-ascii?Q?VyUHxIxhqIK9oif7WoGqMbg+ih/TkSXpAaZQ6e+Xzz50KEhZ1FfauNry3DMj?=
 =?us-ascii?Q?JtcD1tgkhboMVNsubXlPi/+6IJxUXMGMceEnjwJVNV2OPJaESaPP5OJ/7BMG?=
 =?us-ascii?Q?HZE2nwyKh6yRo1wfhOj3cQTcuDfH1JX4QIohmrMTkzZCK1ovOFMObaU1nsUF?=
 =?us-ascii?Q?6rv7rXaFKHYtqeck50uAyrUyBOnGailXcd6qJPmYMjgDHkYTAR14wRTNgUmr?=
 =?us-ascii?Q?KBxuea2wdtwxtfb0xjEt4fI/bGAzop6rxdL4qg/vB5D2GYgfEH+fAm3quwoy?=
 =?us-ascii?Q?qjh69yqb0T27yxLhDsRJdE6o/ZMFNwS8KjwAmQh42plKV8VcuV+qEd1jiTfp?=
 =?us-ascii?Q?4i5VaMSFeDl4LXoKpjCaNGOsD/0yI9J6+IIEqpXccFEGk1B8UJfo5JedwR6C?=
 =?us-ascii?Q?We8W3qttk9u/aKZMhaYBcKVl7TQgldDdBLIonpdNYCxv9dJk85eVfxQA7aKT?=
 =?us-ascii?Q?6f92mqCmtx+WFTa+LqcF4/FQksIPQcy7hCqUV6rlgIVvqqBBuFPAq6ZMF5xZ?=
 =?us-ascii?Q?0NqIS3F0KRB/YI0JmPLGON4OL8VOdHaJCnIwZLEuxUrMMESBKZO+IlTfV6A2?=
 =?us-ascii?Q?43ejU+bmFCa0XnRy/vR91pCY26eBLBAQvPd0SkJWueJKLnLmyprdPOYyWYFD?=
 =?us-ascii?Q?+kQKDq/ruOcX5hOOhzRwgVp465LrVbUSsnbJ9WXU8VuOsp4WN2uNomSXaPkp?=
 =?us-ascii?Q?hAOCUxgtTPxCNtLpZrVy5A0bgs16hXXxeisFiillMD0z2pWdGvz7DROFun29?=
 =?us-ascii?Q?JCPMbo9VNFGTTXAk6LAOFXRGG3dGcYoXPpJDZHuwgPJHcPhaHuRVhutrC9xu?=
 =?us-ascii?Q?dhbJGeExvXUr/VxXBY9gIb4CrP5o65fehWeP3aXeGedE4cR6gYvPDk62nXqR?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ebb911-3a39-4e0d-a835-08dda3a1de68
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:17.3967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz2L46Etd/bDTaDFAHUoboO+8eIgS7IHMjQR20Wj1vqGU1el7p2p4Ca2HH6fhvIDIuTCELGuk3jENj7OcIebgD/imfMR5LW+GPpOxsV18Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/powerpc/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index cc2ce617350..26cbc7854d9 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -93,7 +93,7 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
-#define DECLARE_GLOBAL_DATA_PTR     register volatile gd_t *gd asm ("r2")
+#define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("r2")
 
 #include <asm/u-boot.h>
 
-- 
2.49.0

