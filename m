Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C756C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 16:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9201682CBB;
	Thu, 19 Jun 2025 18:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="ghvXBR/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139F582D4E; Thu, 19 Jun 2025 18:39:23 +0200 (CEST)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC8C82D06
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIL5cue53YqVfmShCFDkgYbwGB5giu14tMpChaBuJ5LZE2/oDbFcg4K3OfD31trw4IeE75FfId9ct4BfpvMpW5nOYJlrXgvXwdtW/f9J2W+TY0xXBG8FEVB3PT0OkK5UWqfl4QFgOEhVLeOkNsDsoO0FCBOEqy7T8vtn28JobrgtwzmuTAUfAEd/GHLsV5K1b2eJrUv12b12p/Ipw82HA9m5vcyYh0+cPdf9xGE7HFvKFp73xhgubrGpZC2FU+oKUHeSCWjRJIGSWH0dcAbUIajZNx7KjCrRxtxESFsbYoDfzq281Mv53D3yoyXk++ukm4XBoJaLYN1HczVC6+pocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1ZiQDzRhdNcL9n9QnwC22svm7uMNvM00fu6twXTH1M=;
 b=Cmst06nqYtZZMmnmUC6l+X1zVkYeivBbTbEaTZjDhVDI+f2hs2FPIRbIoEqwsLvFdUw8fhPufRWhCS5/IlZ6nleCNGFaFRLRu7ZYoNTdh5NKBPBr3i8OE2p0nD6VDY2ChBJgVI8ZsnlgKg3UbWNXy1JAIswVniNKZvveX1KnkbvjfTKuN2h3q7K0jKixhBROtdxsZBRhJXIyvKSuCTNNGtASrq/VRuyjA0Rn2cExXtnIWbOyJLZA+IndU3e+kYuVn7EBCs1qtoDi6iFeZCjT0hJKEHXVZbDPVujnqrYB7jYI3/JA1n97+PP7Sy0boVeqx0YlmuZm+jceBU+xQvtfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1ZiQDzRhdNcL9n9QnwC22svm7uMNvM00fu6twXTH1M=;
 b=ghvXBR/pqXbIc4ehDgbgwZXHBdShg7pofRNEuIBPyZEz9E2fy/nns9SuuTb6ZuVtvkAXOTNfKZPe2sUuGIfVIS3XoQQCJHuWZUNJ0lTmLAGwS3sCIo1qxwruMjjLoCJfuuLuyKpJni4sCiLVHKqJ5M7Tz8lP6Zk1UX5I+/5ftGNfiOcjknK3D9/ldHs3NQhOEz3bRV0B65eWWpDvYQXsH+GNkofYjALyZwIeixO2szeTnGZsuczWInlBUFwAyckrHPKSzt2v0zDIlVq0f315att6yDDn6VxM/bbvQZyVanu/bIGxEo2jeUrTgmOHXZ3KNjKmdi22TiDCwC/aFtXxrQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TY4PR01MB14499.jpnprd01.prod.outlook.com (2603:1096:405:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 16:39:17 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 16:39:17 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 1/2] lib: rsa: fix compilation error without openssl
Date: Fri, 20 Jun 2025 00:38:17 +0800
Message-ID: <OSBPR01MB16704758DA1E4F7E6607563EBC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID: <20250619163818.4021-2-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TY4PR01MB14499:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a77ffc-b34b-4667-634c-08ddaf4fd4a1
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrOwhXVdeGZL70p0mfNR3Yw2HElULeIJ/L2htpE9WgRxt3Wfo/+n3oMf3YK/5DQ6cUAyAvibIs2MCRPPziEk4RIXV9uYKObUsvfzkUwGuTgz6QukrZltzWDQLqMAf/nQAjizTg6Bed9h8nJoi8iF9lA729jHLLLluoJyIq5+V5bEBpjbb8tkUzZkBvT7bF2VrC1UfAo7NdHQtYlNPYHKmJAt9a//gboEHUrRYGjcapTggdfih93EI/nzBSja1XVksw5WnvlG06FIAxuhuJ8NTtXg+7ljPzxr4zEeSSvjzROkwuftUPrE/R1q8udJ2rkkdmcCXRRasHItlUJxuAxA35IUH8HjGisevHAd9VDCiCJS0NJ/G54U36kGZHhJxsMb20MryOuKf8PJnH2NR3lJBEfiYabBlIFO3kWWgt5mjZLpqCT60bw/jm1w8i11LPKVYvXSycyC1yMDr22DOPA2HOd2aIcAnqsSsGPjGu8rtFMn/zaXRO4CEqRyxUElazvhEA3x7wt+7R78LJlVSagYlzakU6cHrHxAU1FFwn6ajZ4KtmqT3vl2dKl8pkvb0eoqAJRWnk3BxKFy0ACJcQrQI+LhdS7HyCxHH0sZCYqzKRRKt4480Tm0LNHyD+gMnjXiyoytvV/fp08i7tA9kvyVBlErk+WR5sbYtfgo2WSicdx94ZjcSLWCAEazF0djFaZ1C2XnAX9r3faSpG61ZJo/GzZ/kJSU1OJnJ6HBPc9au0kROqfPJBNJr9vm21V6MGONpJ4=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799006|8060799009|461199028|41001999006|15080799009|7092599006|5072599009|440099028|3412199025|19111999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MEhMdOtUiS2dtuvC2PyVAou5kRox4H+ZqCQLCrf10kXTalV5Y1bT7tat3TyB?=
 =?us-ascii?Q?5PresPq9nQ7jvOOd36OZk8X3FyvZxh+Qi26xohqa6rXmVWVMCjIdD7RSdONn?=
 =?us-ascii?Q?NI/Y5AHVjflfsSielXxuouNbF1WChJ59QlqoEyT/PsCpx3yqTaP+JTjswXTY?=
 =?us-ascii?Q?wHEDEb1XAzlLh+ifNEBHVrz8J/y2LDwc0RU4bxW/+48q3MrCMCpi6ptdk5oB?=
 =?us-ascii?Q?ODPEFExU5BI6JOz3fpGh8woqzOxb7Ya2lPKVP1JFNwgSbHvKJQBP4a4KmDeI?=
 =?us-ascii?Q?JwrBjHGLiokQhLUqJoC5SOLcIQPTcD89ITR4V6ENmfNBFafKibG4Sk9OSR4O?=
 =?us-ascii?Q?XdRQYg0rIbXSwl7xAbj+LPM3ddEe/hEETkeqFuT/feddJlT1I1Ob24X/st7i?=
 =?us-ascii?Q?vXDwCuPu3CpQU8dw3tt2lft9uRTjKUacuSHCBIfVq3UeH/VoxKk7W2VLwBqZ?=
 =?us-ascii?Q?npAlE2cbHPn7NMeHowI5F22tjra/UhctZlvarpOx5mBh6NWfyFMlV+UuSOxK?=
 =?us-ascii?Q?kk5amdDN4pKSpo6cGNuumwPHQUjY1Fgad5vVGb8tiWfmgrulodUmMRLD8Ay2?=
 =?us-ascii?Q?AZ/I4Q6Cd0aLHuvuVGjFFYjx9WifgBefVfbUGzNml91ZscU7yCtMkeQ2YzOI?=
 =?us-ascii?Q?RlL3KlVkx70EJ8cl4d3yzdlFnj3Unv2c5SidEUydXAXX0xQuDjzkr2kwhNev?=
 =?us-ascii?Q?UE79Ejvt7Yedb06OuHj/J6VNNmhnyuwq4YcfVkX4G8jIRsLDcewtOm6isBhp?=
 =?us-ascii?Q?T55Vl+FTHQ/xwl6Kt/uAZ1+gfLuYV4SLtSo0shOdMVq+SIJIOm/2GjKX7d0g?=
 =?us-ascii?Q?SQcrdSYEP8n067n+o0ve5iQRy4e/u7EPV7MY96ajMwaQs8wUPyYvDpmwvqrE?=
 =?us-ascii?Q?2yAYzlPlsnn6G6sUmihZKeMyVzk54HWJcUyJsyz5w3EB1uwARMCfpi9apUHE?=
 =?us-ascii?Q?s8kmShnVk2ajEw797KjluIO59pp7y2gasmNrMUv2ccRNN7rYcPKmDVoquTAE?=
 =?us-ascii?Q?v0vzQsutt6a090BICEl1i3Fo3JTL9DjB7SbZeQlTgBoUVCh4rNVPjD4xGnIA?=
 =?us-ascii?Q?HuQaZUtMdd/oxyKfIRZLU4zQIG1MMp/mseSIAVzX5iM6SV5nyVFNVoNFa6GE?=
 =?us-ascii?Q?kdnLF0r0Ns8/XQBrMJv9vigenbG2+EpY0TlRB77KIZjFrdFpHhLkPdH5BZ7W?=
 =?us-ascii?Q?SgT12Z4O+rtqhyV1BULNmaarcBQtvc7EiCJS1gPulGN3+XqFqOaT2Ze/YNM?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGXRI2YqlioGdN2bMjA9e/8LoYWlnVR/0cGNuZJk33k7E5pY9IPqxwf3YZ7p?=
 =?us-ascii?Q?cFcLGERAAYgBY0h7t6UZqLeqmkNb3LpgdDozPiiqFqAK6L/95/FNAziRvg2N?=
 =?us-ascii?Q?Jub0EW5/OW3FqoGKfGubs5ckoW2RGHGBLk+M0FFUmB/yXAs2rI6l3LXuNd4F?=
 =?us-ascii?Q?Bt5BtcvLhYbuO8h7wFwq2a9KGMxMrbhGslpJcG/K+MnjcTeoScKT1WOb7ZPu?=
 =?us-ascii?Q?HItAJrUp59/JgzTEPqNZtosrMEHsx9NdMZRq/B7PWq6t2oIPL3Z7e3FhMC2q?=
 =?us-ascii?Q?r0v9VgbqWjYS5NfGuWzFVVGiv834s78ovS6XexdNivyKGWkAlgiNWOCFuBut?=
 =?us-ascii?Q?HyBQipK+L9pgl67EaF1iJ4qd7gpwrJCLzmSNYxiVmdeS+Iqv21M5exZo7Ya+?=
 =?us-ascii?Q?i4gidd2kjloW+FDNYcok/GcfheKrvQpnTf56+HtuYw3QX6tYnvuyJt9B2hdG?=
 =?us-ascii?Q?Vb1dH8SZw2a/2B0/ih/RsZlGAZT70TgNHdTCo7MuQPqqEW/WHm0KpXrgalIj?=
 =?us-ascii?Q?SNK5K1n1P0Q/LKT9A2gnq/Vd7JtG7rdmDHeE+yVY+j2aOwmpoV485atnZZp/?=
 =?us-ascii?Q?VYw4SN//B/SvSXBmxKg27wid2VjZ0TQpoS35IV9PiRU5Ks1Cgqt14+/2eLWo?=
 =?us-ascii?Q?VF+chrXVVmDV2EeLg2P8WqSFCgTsMAwX2LIDMyH2W53GqHigdL3brYSHIf5L?=
 =?us-ascii?Q?9R1XGydsC+6PGwC2CU9aagZGU/Iryy/Xk+zjF4di3cg+rKyENLzfKfZ7AzsI?=
 =?us-ascii?Q?SXAxvYaBDAkxSLisyD+OVZvXeRrpVmmNm10S4OdFth+J6ric3hgIlD6mITU3?=
 =?us-ascii?Q?t5xmgtYzt0+co+9twIvkoRRK/kNb3ryV1TKEPR16s2ghQ88Je5Fn7Phnt6fH?=
 =?us-ascii?Q?djjuZT6tj5jACCfjsMcMd4sh9JBZ53ePlG/4dqiFYthcVjowCIUQQbSUVM1E?=
 =?us-ascii?Q?R8GTGEO1IfQq78w/+bebs99ZJZe3U1SzKaTG/eIYA6fPKSpDMgG+dWXkmf9b?=
 =?us-ascii?Q?Y9JK6S9W8gljwX15W5gKqrsZou2tgGMM9qVznhdYeAD4wVOo7+y8m9gZZdyb?=
 =?us-ascii?Q?hnNPr/D1gdz64D+/IfpNpKIyXrPFv4xDUpz0/befyww7m5nYmJAq90ok9dmz?=
 =?us-ascii?Q?PYIMbkq9jlmsyEhEXVgaQEKNMuQgEbs95rNQ+zku3nvBZJU3CIsIprf3b1W0?=
 =?us-ascii?Q?qs1XixClnJk8autwIoP3hv6+dj2BYDzOhnKMsHA2KkuArCQ/EnlEJ6QNwSa0?=
 =?us-ascii?Q?STE+V4+t0j7XtV3g19sb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a77ffc-b34b-4667-634c-08ddaf4fd4a1
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:39:17.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14499
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

The symbol TOOLS_IMAGE_PRE_LOAD doesn't depend on TOOLS_LIBCRYPTO.
If we choose to build tools without openssl, rsa_verify_openssl()
will attempt to call the unavailable openssl library functions.

Fixes: 942c8c8e6697 ("rsa: Add rsa_verify_openssl() to use openssl for host builds")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 include/image.h      | 2 +-
 lib/rsa/rsa-verify.c | 2 +-
 tools/image-host.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/image.h b/include/image.h
index c1db8383459..5f4e23a0ae9 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1688,7 +1688,7 @@ struct sig_header_s {
  */
 int image_pre_load(ulong addr);
 
-#if defined(USE_HOSTCC)
+#if defined(USE_HOSTCC) && CONFIG_IS_ENABLED(LIBCRYPTO)
 /**
  * rsa_verify_openssl() - Verify a signature against some data with openssl API
  *
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 4a0418a75f1..b65fbe44007 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -570,7 +570,7 @@ int rsa_verify(struct image_sign_info *info,
 	uint8_t hash[info->crypto->key_len];
 	int ret;
 
-#ifdef USE_HOSTCC
+#if defined(USE_HOSTCC) && CONFIG_IS_ENABLED(LIBCRYPTO)
 	if (!info->fdt_blob)
 		return rsa_verify_openssl(info, region, region_count, sig, sig_len);
 #endif
diff --git a/tools/image-host.c b/tools/image-host.c
index a9b86902763..21dd7f2d922 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -19,7 +19,7 @@
 #include <openssl/evp.h>
 #endif
 
-#if CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)
+#if CONFIG_IS_ENABLED(IMAGE_PRE_LOAD) && CONFIG_IS_ENABLED(LIBCRYPTO)
 #include <openssl/rsa.h>
 #include <openssl/err.h>
 #endif
@@ -1416,7 +1416,7 @@ int fit_check_sign(const void *fit, const void *key,
 }
 #endif
 
-#if CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)
+#if CONFIG_IS_ENABLED(IMAGE_PRE_LOAD) && CONFIG_IS_ENABLED(LIBCRYPTO)
 /**
  * rsa_verify_openssl() - Verify a signature against some data with openssl API
  *
-- 
2.50.0

