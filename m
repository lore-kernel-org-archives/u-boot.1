Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B65C83F09
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 04:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD578360D;
	Thu, 10 Jul 2025 06:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rPmMf5a3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E109383653; Thu, 10 Jul 2025 06:13:19 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21C28360D
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 06:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvRdVUFM/2T1FM/XVqB+s75gNZzyzJG+7pX1YzWgkx9puMjk7MwarvU3pFU0qUbxX6yVGPu5kS35+kEz3HbvvBLgDv45xi8q4n+ROHmjodX1jQXdqGTTd2QcoxQUVBS8svExIsTbnXuUmG+MpZxtAx0ytdfi1Er8Zm7yyICTLnH11VVh1ATwxyxe32vgrQbn5UezDee6jdDRqQrR4MvOyt9GksyF/VI9B+ksgXm3MxsS0CN3cnkwmkLuntilaZiKS/ulBculK7zNTKa8bPWgXLThOpuXKiosAHLowgSy+3rzS71V1yQCM2xWqJb7VXzp/W96udyCA44NnRNOs2UMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+HfSx42SrUf3d9a01IdJvdWnTaG5NMJSs7bJIcD/pc=;
 b=Z4hf5MnU39KCIAYw0v2vrDmPNnap0AIfdAUwDHawsIREi2Utn1LVleXt6Ufv+a98NU6Nvnmpi+g3DJAsR2gsjQ1I6q4Y67JvT11rKeVaQdUMetbivluCLp86kA1R0MHJp+R1XwnTAlCeo8GDrXk7nGvMkAd6JuUolTZ191oNXbG9fYZcx8Z+Qf8/WDj0v7ms2PHDcAhk1dd1BTiNctpixXYoATZxVajWJhoD54Iuddl8XWNB3h3A7L9Cynm90MwfAZnsQ0GLu7aMwoHXlaBp47154KUZaBpw4QiwRifoWF4/wo+DNpv9x2m0f19Xcoi1fPsveYCI63CBJ5kdnb7VTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+HfSx42SrUf3d9a01IdJvdWnTaG5NMJSs7bJIcD/pc=;
 b=rPmMf5a3vlNihaG7kAUXEamc1KpkEjYA8U73rsY57MPKM2Xpr7x/cQotKxeRxV4bLp8cMvj93szb7vEtIL6EumrniyTtwkrYUF5hNCQ8g2Gg26sM6r/SndQS5fjq1CtFqFX7QFLNnTsla82zAZUuwDJEjr8Xun0m99865GAO8HoRONNwQnOggqfo6N0a9q3lGXs5zIHvsJ8j9cluQLymbbTqxkuBl6kN++Ue2o6ikB1nJDjHXbql9Xn+n/5fwzEuBx/yf3YRer5smB/4nX1ZJJhQEhgkztL8w6cXZo8NCNIqbBc3jiD2FXBlLmRkDyw539gaQ9FpGArblcs61B3txg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB4973.namprd03.prod.outlook.com (2603:10b6:208:1b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 04:13:15 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%4]) with mapi id 15.20.8857.036; Thu, 10 Jul 2025
 04:13:14 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: [PATCH] configs: Relocate malloc and bss address
Date: Thu, 10 Jul 2025 12:12:53 +0800
Message-Id: <20250710041253.74712-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f9b8f8-3d3a-418b-8313-08ddbf681691
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zfm8j3rJYTugEXopGOdeQwRFcmCiMIbd171HntDvuIbxBXKV7Cq0/qU4/p3p?=
 =?us-ascii?Q?LDlNXJhLPl9QB8UjyXL9ingCWH+WC/ZRAUMn0SlnWO1pYfrJ81Yrc1yzJPnD?=
 =?us-ascii?Q?cyX4JCPYiAOHBHDqLMoRlR+OSmM4B9wtHw3AF8kFZU270d3208LRC+a0ZhS9?=
 =?us-ascii?Q?kDsK7rh6ZKd9IhmjcdXimph6bUHCpCZiZCAGawiPwEmxP6tba95jd/FAnL+m?=
 =?us-ascii?Q?WJcPgj+FVS1L6m8AoH0dsxs/yk5hX44y165IzpG5U7SleQCgZgiz0rSCDvUP?=
 =?us-ascii?Q?8/UfiKRUkZI62aBJ/V2/foAO1PbupyE4WharmmVGa/td6GPOVJztHX87pE+D?=
 =?us-ascii?Q?04A+v34mZEKvhCzrJGeMOeL/fHwrAxQ2rinvHQXRYoYHtmnlCJ52Z+IDr/u+?=
 =?us-ascii?Q?95Qze/Y7gPXCtjUYV7EB5ww00lcE4m9pb+A4DG14cSVaA/864XP92A/+HraP?=
 =?us-ascii?Q?WVs2kp3/Fd0iFyLPdHHrME+Cevuwaagp9rZqMfJej6p2Sp7JVua6FeJ4SstK?=
 =?us-ascii?Q?UCs++Eo3cdrNxNIIdaptFWWAMOdme6BIhNCYiq65/4SEhZkAeTiXOrBQJKmo?=
 =?us-ascii?Q?ZqqbMypWhU3YKg1ZuH+dIp3W/9+OJcMOHBgzfPBH2rWB6/+WQDBoK1hQCjyo?=
 =?us-ascii?Q?6pMnwSf8+0zPKtVHHTXEUxscH+AVt4XbPytUHyX9UwmCAzYI9bQaoCoOfW/o?=
 =?us-ascii?Q?4saGx+IC7bR/kY39D8g8EG3FdxgriFdq5gpP/Y/JqRTfNPB9m7RwM591REn2?=
 =?us-ascii?Q?zn5ElR4FNTm/2b0Q73tZY5AJuKskaSbLwjCXMemgjVMSy6UrC8hdSNrNV5fb?=
 =?us-ascii?Q?Mz+aRjlE/pR4Xs+dEEVs6lnOFTKMeBh+pl97RTrTZIPGMT1g3AVjNd+AMboD?=
 =?us-ascii?Q?/51r6IBJniRXtQAQddnT3U/WyKe3iiq7li2GSKEAiNZCn8vJHqgdReDyrrhs?=
 =?us-ascii?Q?IeT32fM8a84Wb5bBgYq9pDO20o8HZrdyZy8a6ZPJd02BIjCWLgQv2j+tWFEf?=
 =?us-ascii?Q?WOyHk6Hb60Bzl2HYuTnzzdyXzQGm2hYH00npSH06LX2XfDQx3EOvGw1Pi1mj?=
 =?us-ascii?Q?caZIIbFThwbV4PiNzbZw37fF38ZdUkJw4nrq9BaVJcIyQFkJp+OO4MVg0bL/?=
 =?us-ascii?Q?TVHwlNetFrVSxA86lrMILXrBJhKJSFVjO8o1hB12nl6jfcYpYXP+8LRQU0wF?=
 =?us-ascii?Q?9Ih0mdsjJVseUjwiwMUKKJHBAOnrUfyxHlpYtTBU4whv0vJ82bOB3FeoPxTV?=
 =?us-ascii?Q?TdiyiHBYkkiIxQTH3taEmNsxFRVCd7haVZBAGEQu0wtRXaKflg7W8md9y9Wg?=
 =?us-ascii?Q?76Uh++gpZkCRoavnUD13ZT4pNpxEewiGrhwjNgOmhkyDFqqa1MeNfBzyFmfa?=
 =?us-ascii?Q?tou9ReZ2WkkSZhvhKsjQ00YXF7PU/N5LjnXqgwjPpIDvxZZiiLjpm23jeWbo?=
 =?us-ascii?Q?YYAkUaNv2EI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFx6rxNQN4RT5MuqEvCunt6VETTXh35XFdrE9ywZM8GoFIReKYRjnU8Xur+M?=
 =?us-ascii?Q?Py7p9iCre5RLL/SrWz64TdWGuKrak4/TWM02hOAjnQSs7ozAohYc8Eq7XqK2?=
 =?us-ascii?Q?9bjXIQsFqwLm+S3POP/lqis4N7K41OfWKMQhJMDqQ/gYlqIOQuVXg2kSGcg6?=
 =?us-ascii?Q?0DnfUsJZXqroZEzDtwcKhBaZagJVouehjEiXuuH7SCdkwhzLt88staGs3ZI/?=
 =?us-ascii?Q?BbbdCFPW9R6hvy2LS2XMu427eaZ438UQ38L1JcHwEgZCmUCSP7oS79IdBCM8?=
 =?us-ascii?Q?otTsn7zDSgoy33WNfLrpT457trbkJsYfq9tzs1nAv949DencfusStr3WhbX9?=
 =?us-ascii?Q?NTCS972ddr/x93OEXaXE4E9Z6kWLwXIPaYmdeGb3blSwllOOKar7UKj4XPMo?=
 =?us-ascii?Q?OBfd3QaEqY0y8OG4epfL4LoZbxMCgQ69QGkReDd1IoC/OpIovwn0u6VVaP1g?=
 =?us-ascii?Q?yHGTSACqb9erToF+/dH2w1nSdu/NR+SCEaSosOw7k6OHMn+kQes6Sb6p5ihV?=
 =?us-ascii?Q?4yhKV3DOTPa7gTeqHYZk5oj/WPtPF9mF1ccu+zlRauQnZiWgQU9GCmS8ofjX?=
 =?us-ascii?Q?zjJ8qFVVKV9B7SUzDmuPAgvpHmpGreqNKhWFI6O8+SNrpLmTCIrv4DayMBMe?=
 =?us-ascii?Q?YQEXmIW0AX9Ppveg2l3PmnPkEXZAjinHCBFGKHvv/OmJY8a1KnpplGz0PqNL?=
 =?us-ascii?Q?97FvmsjXYOSoagTzMCQ3hbWTl/RG3KvCJfGEMeCSOOCtBrvtdqmIa+pw86Az?=
 =?us-ascii?Q?0hXyBqzBcyB2NgVXgc4fgRKd5rWc8n+ERQ+GLcbR+489qeLOu91E4vyarHaH?=
 =?us-ascii?Q?iYYaw7macV48mhczIC4CqPGxLJH8bqxO9NOvVFD0/2FgeNkawfPqJsvgSGpG?=
 =?us-ascii?Q?884T2si7FD314eZvA3jGYPre1j9NZXWopOxDsca9xuY+fMv7NJwKmsvTwobJ?=
 =?us-ascii?Q?2rME3uyQlFfT7+ZC8/9vCieNgQt3KfvsnJmXVLJX02J9BiAp/MtLGz0htTnX?=
 =?us-ascii?Q?ucJo0NAu1SuJoxClvfXbwNKnKGA/ixphvfIRTfpMHUXjfVlag5VBhSuYZvFy?=
 =?us-ascii?Q?lVvNHppYGX4RtbjC2Uj6YfnNXTM5VxdRLy1R8KtfOFxlJpT5UE4E4huFqXjS?=
 =?us-ascii?Q?GQwJ6y9/oWK6jVDlEsq//vYN4mU9exf3WcXXvn6wmCWxdUX29yFpW9ukHwqJ?=
 =?us-ascii?Q?z4Y2zHcWlF/yKTqTgvuC6TjhXV9jq/+4HAY6Ja5HaXU/ubUGU+AddcAp2BNT?=
 =?us-ascii?Q?4uEBtdzzRCVBRH/vh3gejO0iRosmVIlTwfkgRvMDm1guiCazmGBAQw0CWSYu?=
 =?us-ascii?Q?92LR0ecoGCTHO5zOCCgt2VAOQuMDtpV3+GtoNVZFX+3ghwkTvcGvgpHbh3Nq?=
 =?us-ascii?Q?KGjI1s/5L4czeuXvIJH5K3CJPAT1xvXP1+UiVPvSY1XQ7q4T0T7vraEZvS16?=
 =?us-ascii?Q?hEU2fusd7ZVEmpoceUhgJLcT6iKjWQNAn2KD77kNULChiIX7Y/KfNMGaQvVG?=
 =?us-ascii?Q?i0aYkkRgbpZMBdcBnTVQJbZQfUEZikRJ0CmgpNaat6kqoGcCDYWY9nGTU7f4?=
 =?us-ascii?Q?zQnBm2f1MaCeZ+GqL6XJDRDVlX45YQ+fxu5u5NgXb5pIXO+dKjD/QGOonfW2?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f9b8f8-3d3a-418b-8313-08ddbf681691
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 04:13:14.4466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjlURk6hXRff2R2gMxU2/QSvupa2Cx3r8AGE7IDHIBr7CfAbbaxmlf9PQNRrBuSV77r98q+o0vcPzh9GBBKJwhHlvWlwy1n86wveKuBubfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4973
X-Mailman-Approved-At: Thu, 10 Jul 2025 06:59:20 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

With Inline ECC enabled, the bottom 1/8 of DDR is reserved
for ECC parity bits and must not be used for general data address
allocation. Previously, the SPL bss and malloc addresses were allocated
inside this ECC parity region if the DDR size is 1GB.

This caused ECC hardware to detect stale or invalid parity bits,
leading to data correction attempts and DMA polling hangs or failures.

Fix this by relocating the malloc and bss to the usable 7/8 region of DDR
and is fully ECC-safe.

This change ensures reliable ddr address operation and
prevents unintended memory corruption.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 configs/socfpga_agilex5_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 4ac0a5d9b99..01c5ac88015 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -12,7 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x7d000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xbff00000
+CONFIG_SPL_BSS_START_ADDR=0x9ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=y
@@ -42,7 +42,7 @@ CONFIG_HANDOFF=y
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xbfa00000
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x9fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_MTD=y
-- 
2.35.3

