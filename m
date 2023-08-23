Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE02CEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 03:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702B58643C;
	Wed, 23 Aug 2023 05:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="jlUbC6yH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573318643C; Wed, 23 Aug 2023 05:23:20 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01olkn2048.outbound.protection.outlook.com [40.92.99.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C6B9833DB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 05:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L615fuNwUOng26aauc7slDxuL3GtIYdaA3i7PK9dqcIK9lGTs4J5/BoRsxRUDAzSRHgJtBVTy+20CkeaSfAP4AOLM+bTgdpm58XTvVcQPHklW35swlIjk99amrLwPLVRc5DAPysnQ7qXcyR6lARzNWEcXfmIn4Dcgjolfw7tBFVCgqWn9KtcmndYjlhmNs8g6yEM3LKXjNCZAuZFQUUV+iD/45dIRdQkKofnef62VsrktK2WKm9qc8Al4OR9coKhMPbqEC2q7bnTV1UPWHWJyDDtPnO+ff4WuWXe7vSEb8T3jdE75bLc91qZUkFgAeLlSV0exrU+Zliaqez877ASqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcPDc3pc6x7hfFpuZbwHw34Diwtu1BjfQW0GwguWo7A=;
 b=bcLyX1r/WblI1VUbFIuOY/PovjsBVuq2nrxRV/rI8ySJat3kj6ZPEtX2dsFTpZr01VBlZx2XUIrTL0bnaogJR5c+adOjLA0rDT7ywBcbfN7lc6mqVPfjGZk0MzT6PeVt6OJSHA/GbPkJfkzv2uIYJ+UffPF94LqXS1YLfxCRNsQKcBAWdbMOvnCMpZD8UlhqYgQcCvJNX8ToWvjzrPSOt4/cioBtPdJM/wXydYrzvYtiJgvVKY946dJjPq70h7Ar31JWLx7fm2PMna469Qq46K3xCUzBLhDzlXogEYO2EhaVIkae6J/qL6r5cNEzAJrqJay8jZfoEZTKVbp+4z338w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcPDc3pc6x7hfFpuZbwHw34Diwtu1BjfQW0GwguWo7A=;
 b=jlUbC6yH/lwx7Kgf2Wo3tQrNFWH8ryI8wwSBYqE4cJgaB+MHwptpAGP2I+QrWYQruw51hOkmNcRMIdN+LmaJugtLdRgxI+vm6aBZp221bgrncti/I7VOoieOyc658VKRfYX+3cgwHhjAfVF/d5J1mLgFxsd/wDWOze5FYo+RrtFS2zNr4VW17yfyKOYbWYT5KkIVKqp2gy0QBX4OZLYwgyZkYurAx/LZX16kLPNP42WbGrokRTDDU6z6eKhfGNOGfYOmUpanVo+h2icBAK5MxC366scC1X7lgnLaJOOtmgKp9AS8HO7OeKHvcqrjhrKNvp9nUazXgYF7hnVT3FA8Gg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3125.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Wed, 23 Aug
 2023 03:23:08 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.015; Wed, 23 Aug 2023
 03:23:08 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, sjg@chromium.org,
 andre.przywara@arm.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, xypron.glpk@gmx.de, jbx6244@gmail.com,
 hai.pham.ud@renesas.com, ganboing@gmail.com, bmeng@tinylab.org,
 yanhong.wang@starfivetech.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v5 2/3] dlmalloc: Add support for SPL_SYS_MALLOC_CLEAR_ON_INIT
Date: Wed, 23 Aug 2023 11:21:05 +0800
Message-ID: <TY3P286MB26119C4B919D90BAF5082198981CA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0.windows.1
In-Reply-To: <20230823032107.1792-1-wiagn233@outlook.com>
References: <20230823032107.1792-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [iW8swSSZEpkb90JwONgOEzryUAR7ZYbr4nsP7xqhMaNgyelnJPX9ziKVxMy5pKUu]
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230823032107.1792-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b61716b-c02c-4a3d-325a-08dba3884572
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWiCif6GDuV3ScvVn8CDwm+wIH9G48GG1MHvjy1OutXJKkd9mx0eb9cMEZbLwncHT9nR/yd8AVVgMYkmxeZEt4aJ9eNNXyCWx4szp6rkvUUYWnBSx+Wuh41nd45l+kUjCxRIF+7oHhfVN0hLtapiQ0aAxS/Vu6qUhdoMUonOpeRoV4JHlAFqqWi2Ktz/VfAw9O1P7w6o5ACKMzzsntceAsSYUV19XJjDS09Ujr/xlqJ2laj9Vo6tqA9w62KvtbslPMcl/IMnlVhXvRF2Y7SK8tHnXKNlczsgO17TKDRM0JNvNe/cEIG93RzTXBzp//6diVmfmsL3/EAZP10BFqZRDQKFQBxowfORL8fHlTLI6s15zVyhdhjN+OTJ1wpFfX1axgHEaG3B1E3X/imeALQJ6zl2LH81Fc9grCcGS6aIEt7FYPGoUnOy3SzizgDnq/XAi7vRS3K/P7Vy3JV4rNz+0jEZZyeTsk6CBPRILmyl1vB1tr7d6lRDJghA3Ayle3KSvEPBtLUTh983DuC4gfRgJCsRsyGpEHrLqJShaRa8zjmcFbwJeuew/E+5R3745NVPoFM98UsyplD/OI2JIt3GzEVWxbIJbofm4qbR4rS9BZ5NFN39SXOvhwuDCUMZ0XsJxZcQU/ROGNWtSdg/L0T/mJ688Gmr7X9NQ+d6EU8AsHaOp4BC4Z3PfiB/1fKIWS1JchSaFJrKhgOGbZuGfJy7UIhy83RhbHyysok1t22cDueR4yyyqwxhT00VJvEnTY7Zs8STEFjJss2xZ4Bqlj7dgXTU40RFx5/fGU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJt16WZbgu/cZVWPxrNDnkI//aJTmhTQ+UV7+x5qa+xqCSrqD8QYVhiWQlaL8cEfzXT5HZlXRjvg5rleNQ8loleVCImaY7L9jXOc4+mkx98H2OYrJfDNYO7SS4i5SUKQ33k9s/IaXqyKOoEvAqEU8prZEBsEU5I4mcFxzRd2tcjQkc92ZaoHEjuLbWvCMU2rFlBQCECUSdpmmId/ohAQId8NVrB+E4CBOVgp948Khs9cjeyLiLqHu27TUoTeV8//r5LMve+h6XDqyCcQB96dMYlkh1vFQJp0Ww54jykTGWBIqbK2L3m86zMes3r7RFjI5mG3mD9BeVqu/WjtFC8BP8TFbXDJQ4FjfNsZL9+cJPNZxIo9a3wWyYdSpY55ODR9a6lUuJ5AhxpR+QBgq3P72iRgjkJJ3XpFquxV+0kHD2O23myFBKxG94U2LuGHML4lE4D81vP6QEppax/2FSbc6xQuN3tqCacdsayEDYo268tjxKGP2RWGHG7ChEvuFQvDu+XcRdOgGW49bbABbWGmETLfNZpsEX4PtdCUBEcaMytwaXkhTWbTZ7esWZaf1CZov5SZU48k3exHK39STls0kBrMKjlOtXi/VZZF/7/owWHAjXUiNKlZvu4R/M/HeP3l
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7eEmmpYq5qBigA1pc40T5F5Yo/UbC/FyFgE41cp2MRJeQHBTdLPwYKaJx+5?=
 =?us-ascii?Q?NAbv1AkdUz+/G96QQRoIJqVYJapBJCKmN/QLgmZYse9tIvWWq73iqjiCl18g?=
 =?us-ascii?Q?V9b1rfCJNq/mzeg/45PbNgTfgBEYttZnkK/+g7zQ2Y2rtiQ2lA90C+Y+n0uj?=
 =?us-ascii?Q?lfXNjMoP2L2wtj4rLTswyEzswFLRq2J9AIK1X7oZ+qzSYVxdlWXSNZ7PnpiQ?=
 =?us-ascii?Q?hELV0Cxlu0Brdv1Pa6m+UiLhLMu8XtAn9kTpaRPZbg4lWpxh+iqlWMjFFecd?=
 =?us-ascii?Q?JVoIH19T9wp+emGo1xjKXpWnEOZ8bsCovY9hWE032ISYSn1Usm3Rpdi+H0i7?=
 =?us-ascii?Q?cr1RgJ5432I1frCB3T5BeVFh9mVB3gsnC5b7s18C7yoY80SwcR7jYq5HgELo?=
 =?us-ascii?Q?5M0AYvZG83nNoBh9KoG4EDixAkqArJ0UwduGKquZ90b5jC6ttmdsz7r9O/iW?=
 =?us-ascii?Q?NNhk6PB1wP5Ew4EfhVBo7Tmnv0lEuC/+jI3ovtuN7YVn/SK0AxOsbxKhmJcW?=
 =?us-ascii?Q?qFs+dsceDSp2T9m1SZJ8rXMmsSe8DD2rD3ArS/L0wMAnRufowZqQjbGXItgz?=
 =?us-ascii?Q?KPdsUpi4twNEgf2+MTF5dklEJ0PyHgbdWolSRE3NV0W8gscpfoME2VmlO3mW?=
 =?us-ascii?Q?SzUr5FendMXF8iDcb8E2Qp8uaTF3TUQbotLE45xJRYdphSzubfazihMubHrn?=
 =?us-ascii?Q?62SGe1CQ9MgKrQET9RcSuWHSVeb+HU4DPh8ItVKSGbwJba4KLTCX8AO/eYF5?=
 =?us-ascii?Q?iJHSnls644mLSaLuCqDAOxzWFbmcJ2M6P6T8L30S4NGgbK6sncPvB5pRRG4Q?=
 =?us-ascii?Q?y5SxhJLwRjw6VH5BkT5kNVufLcOifzIi01M/DuMHbkTXpgpQ04JmOO7LOvKj?=
 =?us-ascii?Q?gT8ig8sDfJn5kEyLQU2ocNxX+FznKHhYNMZCaATqWitCs82MVGbXyNJyK0ko?=
 =?us-ascii?Q?oVVpqD6yf2VUgPsGFzkIyEgIxnGgQa3pE6xQDsRR1v4wdrjYMslMtUAwuaTe?=
 =?us-ascii?Q?G+Ws6IjjSPRWr6z5k4ZYlcXwZVK7BZ9knV/aZN1kkUYeLfCGNIejh5pjL9jF?=
 =?us-ascii?Q?GDbxzeyHYq5XdARaBR/JnN6g2YyNtfEvPOHMdi+4sp1jsRk4Tf8VPF4ylOKo?=
 =?us-ascii?Q?OvaiIhUeeW6TTZzo0sDsb6pT6A1dsJ7sbxMizO1H+z7qwcQudBwUoCsr9bjI?=
 =?us-ascii?Q?tF4SN8tKtLHLiRsFweVqVymIq/CA6Abb9Jq56cEKEf3EinC+qVgbbvploRfV?=
 =?us-ascii?Q?F2V/i79ZbWvET3tyKgdfblkEYxvjTI2bwGo9nJV9Rw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b61716b-c02c-4a3d-325a-08dba3884572
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 03:23:08.3619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3125
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

To support SPL_SYS_MALLOC_CLEAR_ON_INIT, we have to modify
#ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
to #if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)

Signed-off-by: Bo Gan <ganboing@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 common/dlmalloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 0f9b7262d5..dcecdb8623 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -631,7 +631,7 @@ void mem_malloc_init(ulong start, ulong size)
 
 	debug("using memory %#lx-%#lx for malloc()\n", mem_malloc_start,
 	      mem_malloc_end);
-#ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
+#if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)
 	memset((void *)mem_malloc_start, 0x0, size);
 #endif
 	malloc_bin_reloc();
@@ -2153,7 +2153,7 @@ Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
 
 
   /* check if expand_top called, in which case don't need to clear */
-#ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
+#if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)
 #if MORECORE_CLEARS
   mchunkptr oldtop = top;
   INTERNAL_SIZE_T oldtopsize = chunksize(top);
@@ -2184,7 +2184,7 @@ Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
 
     csz = chunksize(p);
 
-#ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
+#if CONFIG_IS_ENABLED(SYS_MALLOC_CLEAR_ON_INIT)
 #if MORECORE_CLEARS
     if (p == oldtop && csz > oldtopsize)
     {
-- 
2.38.1.windows.1

