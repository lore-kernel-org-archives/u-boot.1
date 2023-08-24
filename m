Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B907C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E2D867E2;
	Thu, 24 Aug 2023 18:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="UMGf5UMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731A386903; Thu, 24 Aug 2023 18:25:57 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01olkn20822.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::822])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EA18675B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uef0H58ps20LchPIGjZJF5NPBUxoujKcBl2gh9sTiS0iXpr76D4o8tJN+Y3wP2xaPQjyqdV7FxV3eWHta2Tb+dzj/NyGnOx7pfBzP06GENfvpBKrpeEcnsRBef2F4GedvlQaBP1b+E4bEX4WQCejVjMSV7fhnBhK3GGjLkbvxhCbYThwx/AJlWI0XETqMr6ItUDRHZx2daFInWC74VHMRkSGamS89NBlgigPv6TOWMsxE4x8HyorZ/wHSIoZnAVAYjx0TFnbZIYZKAGX31RcuvdWpcIlbhioSHPcP3/EgKT8QvoKvUsf5mKxiObB+JVgwiNqcoaGf8RQT0xZen+zQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O836mX/MdUwThP2mf6Vt/9O044/xNPexzKTExl89HY=;
 b=gaET2pdZEBi3VB7wy4Ua3V3IWkO3FTlRYsHqkEXu7rWGwx07m7OF9JNNjZ9rwGzNC7iVISw6xiEWAR80Sp84uFJMNg2dEj17iYBheoMT9SEcVy6i1v8iMr09zC6Rc3UOaCP4FyaeHA8+v0MiLZS/by2FRDs4exAo+fm/Kw2Jjh1XpxjOL/GR0zVovoeSTIHD3MAno5FEj9UFcReupkjCjvVAyTQAyLwC/7bZowsNPlSHSxMsLjjM6wQcTtGxou7clXmjOqDu0zNxHHZWfJqPhv2OvMI8zWqvWvLcZtoj3nw/cBCZrQs5W0tu5et4vyaYHZ4+w+MQcrVsRwjRdRDAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O836mX/MdUwThP2mf6Vt/9O044/xNPexzKTExl89HY=;
 b=UMGf5UMcO5Zffk4/zm8kQiTrxlAmKPTdG8D/mCQWMODYeJ7CLXQ9EHmswPbfW0Jknl30/EIOCDvVhXbNRsdy1BYKn0EUe8taHdG7VAARE34DGfD0MuBB/e+XaBV/N6J8TEPXEdXmdcLLuASBZqW/TiVbQAepIwz2UxSMloLlBaQuo1ikZ4D3oh17Lj+VkCP9YK5fmMGI7TFIHaNWZwaJUHkiCCz51juLDJc3ODsMx5MxIf4kfK6YLF1tgM69rcuhMmw3o4VuS/2oqf8lPueioUuPqynkEZtjhYmAQ33FBW2CtB5EGU51zePVCWUpNiENVChzqxcJn76sI7RFiPXCbw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3381.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.19; Thu, 24 Aug
 2023 16:25:48 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.018; Thu, 24 Aug 2023
 16:25:48 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, yanhong.wang@starfivetech.com,
 sjg@chromium.org, andre.przywara@arm.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, jbx6244@gmail.com,
 bmeng@tinylab.org, ganboing@gmail.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v6 3/4] riscv: cpu: jh7110: Imply SPL_SYS_MALLOC_CLEAR_ON_INIT
Date: Fri, 25 Aug 2023 00:25:20 +0800
Message-ID: <TY3P286MB261133B2CDB503E8F45DD39F981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824162521.22240-1-wiagn233@outlook.com>
References: <20230824162521.22240-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [91K4MXX96Ilud4gfa3Gbx1DJqUWngPgw]
X-ClientProxiedBy: TYAPR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::21) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230824162521.22240-4-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3381:EE_
X-MS-Office365-Filtering-Correlation-Id: d02ef9cc-ded0-44c5-9481-08dba4bec675
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWwwxxe0VdV+IxBz80lnVIz1qy9hvzmdLA4ict5qMKXPsLl3vLvfrdZaLe7dgnUEzmJow3gxxLY7OrcwLC8gTkh0WsXQT7ik58gDkP+dfv1bKK9OqlsQuZE+Wv5FEh7779y1PlzRDODVMZw4b586+mAyCORVMIcaEIRFuny2AnR7+ZRq9L97JIlLCw1hW6MXGUlCxIWkEfI1tSPRRDSUA3cwQcJl6JoMVJmHpZ5JtFKUu6n/gFr59F8b9mfd/tOET2p62NpC+C9qBmR1EB/nIHB8foJAkCWs0TSsXNneTahvJnRHOrwgAqXCL1SdUO57dUXBCk958H2jU+yvHwScNxldJAMlL8A2Dg9l43GzcvuSsMH11P7lZm08u44srdKtVuMzPIA1n0zmHDYFlQZ2ps6x2WWOqFbbazTOdjl0diHuAuy+uE7twUB5u9pWcizPHU2CYMSW9E+ghCebMoYi590nh7PKcgPR4B4OXc6rFqPjTpTkcKlW74AT8FTAuLy8fINDsHuhKHpWVWIEGsB7bbVa0iSw9GqpnhU+wYwGCtk0eWcCQrbdIKy9R0X2+ZvhKM/WCFCU/l/a0+lVfgLka/boAd/z1P7qEZCLeJqwRRPopXHXD6O8OAeaXVPZOQJAQNPqR9ZNLU9OAVcsHquPDVYTsVO01NrDpg5nMNu1H18qesGqalzpOZK+evPsUTgIB3BSz7oPyfo5iq+Cd7YnFI7+SmMNQJpYUfNYvTCWrcHhhqQGPEeIcLXGroDJKf9QhbJflzGldVjM4HmCC3q4arKAffM7oagFEo=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAriMcVzB5oIWqJkCp129CewtCB44NM1oo73EuCHtFtAEU7ic6Nx7krxltIMqlMH2XrUVAE4yDLPf4DYmBhOr+gOtfNWFhXyvs6WwM6OqVqYisfMnpVGYdj4Nsase0HOI/ZS6tH4TphlcbvXv74HhH984lAxADT70ZuFqLdVQfjBmxAKVHEDGJW4wG2UXOulcmAy/lpJYi30pfGx7kx4uHavzWM6zU4jrZnsDgVzaOWAeeXfTE+fSiiHGj+fK9wNnxSRb3nBfloJnKt3luMlDnd6xSTRzrWjOPLeI8HYQaCh4InjMv9JnxpFauM/5gmiQ52X304ML5zXs13CvrwBQUzr8KuM/cKAApInTJTLU2sEH7AkGX4ZLiySR+0qnIKXQX7RJR0/iaB/FUGR/M/LFC1NEOaR4abW47cvPv9jByU6qWAnLqxtXfS7m67MnSf73oU3Ztg9dRX+Ta1+g7tAtEnbPP2EH+WR6GRSfwLP0BJgoCdYck8vTKOwVOZy8vDOfqmB6xgZR94ktoiQvk/48lLaKXpyrZZU1/F0GJ+ZdP2GPttSvlkycPx1eULwbGa8Q+0DlvMeAh/ZKEq52KHxQhS15Z9lja5cexC4nJ+NVrbYoGEjLOt/lsUaRhnNQWLC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MCRD594CbNETvj23RlXm0Ej5G2Yod+Iljm7j9fSPk1WoY51ophEKWoNDn/35?=
 =?us-ascii?Q?+Kvo7tLNMzvU9Hw1oyljEK6THs5uNs3BtpukSnmbBvujvYN2Et67EBxDo3Fg?=
 =?us-ascii?Q?wDSDY3GmVUrxzHpjOQAA0+CgMID6jaQ0Kn0oe+e7QhzpfUIdYHS04DRhoKHc?=
 =?us-ascii?Q?AL4eOXGJ31ofWz4O2PkUCx+8S7j+REWCJw54aFGidKNktJPs3uf8VFa/P3ng?=
 =?us-ascii?Q?GcSF2X1yeWFjMciKRCNwWZwHOCsFW3rR4hw0lMZKkd13uMmVoxNuCdYGGCwd?=
 =?us-ascii?Q?eycGDjvUoDYZQ/weURjxo9BhdNfDobPss7CN9MB50X7E5t+cbDTEcqLY2Y1E?=
 =?us-ascii?Q?sxus9lVxhh8qZdp+MJwQRPXh2eYrjV8svOV5wwDOwQzkBs8OiHyfjj/B2J0h?=
 =?us-ascii?Q?0IHT2d9oN59pxX44viQiqKhqOBXpKwLE6nqqOeu+GCbKgeS1DzgbcUACL/Pn?=
 =?us-ascii?Q?XWNZpT6g/HK9dYX//zZqq9+rVSbE0W9pVzSHi2hELPhWBbKA8Be1sS8I1D99?=
 =?us-ascii?Q?0SJFR/bO4dk7lqTf0xoZBHdvrwslthoIu6ZPu91maq6RRWxQHdtz6e7qlsMK?=
 =?us-ascii?Q?2KNwFI7YWdq1yhBJpHAkWbSw3mOgYojTRCdhrw1mWs1taG8t2kTYDvR3sfrw?=
 =?us-ascii?Q?Z0hk/QoZqjIDIlgMQ3eXDVk2skYowN4/5iPSGTfIwgOJNKmXtIeurJkwFxOm?=
 =?us-ascii?Q?3JU8DEluUlLVxgv9PD569NHeWJBEgdnxOZhVko07+tlePZ/Bi9dnNyXqE6Yf?=
 =?us-ascii?Q?6XZlwKgSwYEu54qsa19ds264xGOfjrg2OhY/TwbPwgWQywfPgp3mBqUP1YVm?=
 =?us-ascii?Q?BbIHRj3fdxO5GTcdsxy4IstGS9ghyTOpx8aajJET9ym8VfbbjNhHkLe4IRtl?=
 =?us-ascii?Q?1GkEThSV1E9Goc+VpmuCoJYLDk2XMzooV/8Gitvl/u1e/fO5l3r8CDmLAki8?=
 =?us-ascii?Q?ukhTYDF5ypXy4wQc7PlG71QKUWVO0P9vA5p25QZ+7209OsJmPwj5b4ApdNDs?=
 =?us-ascii?Q?vsl4cS0hVetlSim50v0O/2KpPgZrT/Wk/tQk/4tNjMbYT63zzDH5+Pz+lvwK?=
 =?us-ascii?Q?hWF5QzDIcxhtmMNLfz1G+Yb+3YoPVsJfFJ0OVgVyzrtvRzshQ+WGa+cwu2LX?=
 =?us-ascii?Q?zES801/QLOn+BEf40sqh0lg6qNvXVCuZvHu7zdioU/vG2L1IayMj01mBtKyA?=
 =?us-ascii?Q?8uWRgpAjqfnX9xcpWmgc1Ik/UT7lJuV64eV/fA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02ef9cc-ded0-44c5-9481-08dba4bec675
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:25:48.6499 (UTC)
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

Starfive JH7110 needs to clear L2 LIM to zero before use or ECC error
would be triggered. Currently, we use DDR ram for SPL malloc arena on
Visionfive 2 board in defconfig, but it's also possible to use L2 LIM as
SPL malloc arena. To avoid triggering ECC error in this scenario, we
imply SPL_SYS_MALLOC_CLEAR_ON_INIT as default.

Signed-off-by: Bo Gan <ganboing@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 arch/riscv/cpu/jh7110/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index 8469ee7de5..e5549a01b8 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -28,3 +28,4 @@ config STARFIVE_JH7110
 	imply SPL_LOAD_FIT
 	imply SPL_OPENSBI
 	imply SPL_RISCV_ACLINT
+	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
-- 
2.42.0

