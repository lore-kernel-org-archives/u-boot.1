Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78367C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519808684C;
	Thu, 24 Aug 2023 18:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="PGh0B82C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0859A8684C; Thu, 24 Aug 2023 18:25:54 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01olkn20830.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::830])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 936F88675B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPYuFtnoVLsRD1W8jvkk9H+YdaK4XbHFSL2uaiB/D1ziKxfoz4hFufxs9fOh4bJmKaX3VhW2kyS9UXFTwH4Fuw+2DFeb5N/FkJfg7SklJsbkCoo1VcViMaknPmOGWaQ3nsYIHbUQlNKGFaBJhjeI8A6ZX3e7ukrzL/OHiiyBZTuvAiV6OrWZJ8pPvjYtb9Vq3R8NuJvagLq7ZOunJrKVPOFGWoAIJu4S3zKs332pVBgwq3o07sBWhC20oRF06ut0m5f4k3egrh1GsBa5SwLv3H8jhdLmPhduzMNI0LFvGVciKkOpJkHB7TDNZSHRpceP6gyvf1gTEiSXN0t9m6BJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8LPkq6591f5luJ5xr9ac/ZPaZsuzuZMMsN/l1rO7eE=;
 b=JNAD3cTNIw3ILYBr+9EWBYHFgWj8ipIlFtqh0BYHEsj2YFl6KnIsPzvyTLEflt6uZFarj+LlB5gsog57/utnlXM7Un/34ABZxmK8dxDKJzoE8mQcX8uottaAUeXEilRD2quFDjch10km1ScGzv6UJjn5+q2o/oM4odJ9feSgNEHDEoBNMS7W8WsAlxn/6xKbF4Rk441zwsyLE+5As0TIXYaauO4mICA/tBj0mty2jDGygepWV1qIxjxrNVni+1/xCih2NAqUq1KL6M/a7jEKTEr1a5IVIKP/k6LGf3h8WHblq9NE3vkw2pZs9t3ko7pVifUAiAxTm2mu4/KQadtIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8LPkq6591f5luJ5xr9ac/ZPaZsuzuZMMsN/l1rO7eE=;
 b=PGh0B82C8vTQ4E9U4q2smuofbpYIw1sTqEyPZLCRJtkHktsm77KiLxY7L4lmT5L2FXubKOlFxrlgqw/mbzRixV3xrM3lDZg6JupTBd7f4pG5Tgx2ecEMtbETZCovCddZBnvjzebbn2Hb5MVHKwyVv72tYrc+ewcoeblWkKUbDyn+t1YZJHlTVs1ZHwmfilmu5VF4c2REErn4VRVkO0jjCVIVZZQBsUhXORciP3s8heSMKWM7ntOEl6cv/dVohmNxcMjGmC5qUUB2I9RvyHwd8+PcH+P7wjQaX57Y1k1sp89KCpWTNJkxxy5wM2FCE+squKE2Ponl+roUN4D+ieEDLQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3381.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.19; Thu, 24 Aug
 2023 16:25:44 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.018; Thu, 24 Aug 2023
 16:25:44 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, yanhong.wang@starfivetech.com,
 sjg@chromium.org, andre.przywara@arm.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, jbx6244@gmail.com,
 bmeng@tinylab.org, ganboing@gmail.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v6 1/4] Kconfig: Add SPL_SYS_MALLOC_CLEAR_ON_INIT
Date: Fri, 25 Aug 2023 00:25:18 +0800
Message-ID: <TY3P286MB26116769A6FC3BB12FB91A77981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824162521.22240-1-wiagn233@outlook.com>
References: <20230824162521.22240-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [acwOX9mFIOs6Pb8gZdypWR8ZDludcnLx]
X-ClientProxiedBy: TYAPR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::21) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230824162521.22240-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3381:EE_
X-MS-Office365-Filtering-Correlation-Id: 93999384-4891-4b51-70a8-08dba4bec3c9
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWwwxxe0VdV+IxBz80lnVIzbv44VohPuyYEgA2/LJaoSiKFBMbaFx8kkI+V6FqDWYOCc998A389tSifl565BKOC8RJtRMxqlk54G/hNM6kyABTK4wpUYHdoUfduuhY0xzIGQE/sKgjQVOazAzp2EvSxUXkZFrI4u3e0KNjlN2KNalbpzLsL3yanZWxv6BYJ9DGxTNJRFz9o7dxnb8FjBHIAMkzCes+xR+VcrcamJDaBuZVKL/iBYmIQhP8D5+xgLfXcJnaG4sbUU4gMEFnLRcHMbB3zqQapNTAkLcoAZOlM2Ii6DI9q//QUO4bPa8Nvq4Ow714Eup/ZD1HGQrb2NehPvqzLsaDaSYro1w86KAxc6On7HCd++9J5+KwqoBRqWtPkWupbHhoFka9jCLGpydKhBrHa2VcMuLiBcPIsQ+0yxxBl5BQyL5wi78WgW1D/Hg7GP/OUxxlK3g5VM11Dqqc1aDsHbfdnYzIaDa1/A1FDAiiW0ty+CfvJRH7HQosxXo4HxkVAzelZM5gKo5daGOwuNuWUQGpjHzoKAvcO9a4FiGm20E43+R8cXiVUu2eGB2v6BG3MWA9qNZW0Lj6kqlvhvpS0Vo7ek8Ck2IdCnbXi4m6yLOlgKh9xfIzBtFUTF2ugHTbuGPVrPQQKXBq+qkpe8EJ6zRJQkc9p8k5Gr+S7y5WpGGUGQnXrOfyHlLxt2yvnPaRmN4hmXZ1xHb8HEtpRWdfFHFsdvbPfZpf7mB//Li8+zYTOKvghHPg4oszLM2Appn5joHUGnGUAFDE+kI5E93nB6cgI3fI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FByzqajT+QUsrtUUOAYmfBMBOtS03aahbEE6izT+L7Jtt359M9euQqS5OQvCmzbwLoseeVP8WNAQambVr6mJIwQjWneiYfv/ctDxdvimeddhUkCnELHfZvCzqdJCOdGU+Y+auM1NYz0qHIDCvVlNpPohHVM0rs5SuZLZVyzLJpb8zmbf8SIsI793H7BMj126ZVJJQUGHSNxzTCulGrNwsGn3ymbihXhfPvkhhFu9N6/IAbCtyML/B1+lf0cuLlnpT8y66daGTlXAkHZ5v+Y5RugCSHXcCks0eBQRBdAsZM9CZP3Ox48fqmi5Lj2IxL55NwK5luF3mp8zQUJTLrgh4juy1fPpvhlAmnSiLfHTfrAezWkOdg3UL+G4GKI6nLGSAhmEIQF/3AylzaA9kTwQTBscIJVT6UcOvq7SPE6r7KHbP7yGthxxLZtRqiZNNA0mUJ3n/WOnOZrlizcJ29anjwLcg49MUodz22d6wFZk/qgpYkJH25OH6Xbx04PHpMpzBpbprmDW51Cq2C4YQusQpB7kSLtsY82DbbCl+0Bn8/x/7pYT/Ds95P71LR/GXq7McixONWax5DkxubimEofUqR1RvoCDIjgkt+8AsKfsVCUen+h40Qr3avSmBVeM4Bhr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+dUTToLSqgFX9o8pZZ6F/YwHKoaatjlhYeF2rSiZrBoltkiuorV2KaLR0qkC?=
 =?us-ascii?Q?7qYXJ2JSSHPVle6KxlAD0JQxo1DyvR2AU84XSs7zuVLIoDI1S1MzvWIjJQ5K?=
 =?us-ascii?Q?vV1dpKpzajglSQfpP2GhzTFOBtQNa5q04w8/Ezr/yMBG/qFUXMxkaSzwbZ6q?=
 =?us-ascii?Q?nB5EV5fK3jsJ9eF/9MaordEcIqucux4tqAA8CtvZuihLVmfJRU65g2rRz4dv?=
 =?us-ascii?Q?8wrC/WFEpQJZkgiwcR4stiNx8gcOt+NA7rghcsDr24Eq4dTQXwwbFxNt7nCx?=
 =?us-ascii?Q?c/+Rhrk3bMd0Xi393o2KkOzKZV/lOS+rw4pTQHrBQ6J6Y8dP13vZHO5s2BRO?=
 =?us-ascii?Q?px8+GnHR47ECVlfNL+8aPYHJy4ZXUqcbcFSHbh+GxqMzg87eFtupt/dkboc0?=
 =?us-ascii?Q?u3iA6W/kjter2tWKFodUTlOCfRxH3VB6bivSAXfwL2ZUN3S5faZQhFhlF5EQ?=
 =?us-ascii?Q?xMrCplCGLan0gfFuSLGu3HoBv/AKdvUQbtfwiDpKvhgRn1/yFq3EpAGsnTvb?=
 =?us-ascii?Q?zkdhESYNwBUrZIdjMoG+65UZteqvTDDyeBOVdUJjPiylD53QFQudopV73rIl?=
 =?us-ascii?Q?3kDLPV0fX//bWI0S0H5P9wb9AFkb00TWuuAYZLwF7Iqq8OP4vsqm9hDuDOT2?=
 =?us-ascii?Q?i7BSj6LoQRSltAcAd0CkDmoXNHB+VaNvtXQ5cNNJsgd7quJjnz6VNEUHePi1?=
 =?us-ascii?Q?SrAkcLpjHYFq5cLd5i/2+Q05iV57+u5KqKFRWFS8qeu6LpbjM8lAIM5U3jmW?=
 =?us-ascii?Q?GgOMUSKDM6b8UYsqSrTuiDdXhIxEM8Q2Ru4qaU1U2zL3P3IngXqgJ41g34FU?=
 =?us-ascii?Q?/E+8YlAs6hKodcEZfjQ+I6t9K/FdBrC6USLIVPs72dOH0wH9vgNyDYj2cR27?=
 =?us-ascii?Q?YyuyXdwHBXh4TV+EuHNthL1fM3YqLmSCs650ileS04B334U8EF3lk+yF/gVX?=
 =?us-ascii?Q?WN+D07dPv+EhtDKYd7/v3zx4xe6pS6PyukemH4tnpwha3OrmNFM4l/Ps3O/J?=
 =?us-ascii?Q?jaXzkjJEc7RWCBPr+exL5w/xxWvJW8wXM7HjCT9rPGaMhDVtEvzwWmUjRIpb?=
 =?us-ascii?Q?79mINpgywJMr/EtnPlNW2fYYyoKIMAWrGzJzyqJEfOSUR+cI+4scbfSbSE6Z?=
 =?us-ascii?Q?AbV7tstsJD2reOKhAQ2DND1ePdG+95hJmDJPmDM26Ohf+mcWh9lappQyyULC?=
 =?us-ascii?Q?govJ2gXnU0pLhvorXnueikZtiiMQf3Ik0YCT6g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93999384-4891-4b51-70a8-08dba4bec3c9
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:25:44.1766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3381
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

Add SPL version of SYS_MALLOC_CLEAR_ON_INIT, this would help devices
that need to clear ram before use to work correctly.

Signed-off-by: Bo Gan <ganboing@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 Changes since v5:
 - Fix whitespace
---
 Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Kconfig b/Kconfig
index 91170bf8d2..6ba605a564 100644
--- a/Kconfig
+++ b/Kconfig
@@ -372,6 +372,17 @@ if EXPERT
 	  When disabling this, please check if malloc calls, maybe
 	  should be replaced by calloc - if one expects zeroed memory.
 
+config SPL_SYS_MALLOC_CLEAR_ON_INIT
+	bool "Init with zeros the memory reserved for malloc (slow) in SPL"
+	depends on SPL
+	default SYS_MALLOC_CLEAR_ON_INIT
+	help
+	  Same as SYS_MALLOC_CLEAR_ON_INIT, but for SPL. It's possible to
+	  Enable it without SYS_MALLOC_CLEAR_ON_INIT. It's useful for boards
+	  that must have particular memory regions zero'ed before first use.
+	  If SYS_SPL_MALLOC_START is configured to be in such region, this
+	  option should be enabled.
+
 config SYS_MALLOC_DEFAULT_TO_INIT
 	bool "Default malloc to init while reserving the memory for it"
 	help
-- 
2.42.0

