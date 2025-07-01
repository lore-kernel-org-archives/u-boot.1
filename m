Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A679C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 04:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4589881FEE;
	Tue,  1 Jul 2025 06:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WJ22akya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AC0F82B18; Tue,  1 Jul 2025 06:52:30 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EAF8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 06:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymiT6xXfoXIeJiZLbUlYXWOuIWjXUENDreDBhNEg5AsQ3p7I8aOlE+954I1L1yU++ivigIblElbtITVoA3UmV7FHETCPNBPCVP87os4eb0LhScM6TUzaaeifpXBfTJZlOYD0ahT9v3Qa3NWVURFz//1sIrmyU5uMXMJGsqfrb9VPhqgdxTAZrRQ7OkcTzlbWJfOBzZSE3HDIwp+OBZOV4kW1CFluwzhgbkppz8hHoH+HMMI9SlSU+DiIQ7jYoZ8o8XS8bTbrdekHpBYQffr2TMZuCUkVZu7gSM4WASbZdnWZPaqh2BHfS/NcEJdPLic2i+62WN97zuel/kBF4J0jeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXxR7FTmeizzKnsjyd84xni91mLE3h4SKVWp06p2Xgw=;
 b=E1SZVxOX6laJianvQAuX0PmmQp5icgvcqoS6OwLyRGUvhSpEfWnxIVpTdQmtkGveikTCgnF8ttpOi3t1LO8zc9O1lc+qa5CW68tfsdRiV8OZQGuQ0qE9JKs4a0edSPDS+CRvSDfJv9IjpcrHierknZRQEa67jWJRyoueGui5kA7C3Dkq8KbeFRjov/CwTf3RtEQmiB+4wlBTZD90oU4zhJ2uoO8fuExbLphkZ012NGGbym4+lCrcolud8ukQBN4MqlFsyhO+uD/mqb5iadTmoSbeKll62FETuIVAcK8YQrzeuQeFNb2vwOUhoffUSGQHkovnDDyFgnTWcr4jcS1mfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXxR7FTmeizzKnsjyd84xni91mLE3h4SKVWp06p2Xgw=;
 b=WJ22akyaDSffinxN8h7Ct2I0r2s9346J/M0uJZtPll/PSMEPuTmryIohoNjshXl/GnEipjZ9+S68gwrMKpO8KlaGBxlul4deaqrs2B715Wg+vJjKJq15qkoJrhc13/7nC+NRRbTwwYf9bgYE2joBfP9hJVSxXiuQ8IO35401fbiP2khwTuo7R2M263zx5WKjgyeg+2dhoZYO+2lEsoamcaemEDwesRKkkE5qmRq9TeSVDg+Vrz+aU17sK/B6jvrdC9OZZBrutUTowRAWDEfe/8agukaaxEgt4FUxaAJodfy6BJzkB9E4iyP/cT5qwJH+tY+ZCBw6JtrSX0b4NSz7hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by SA2PR03MB5850.namprd03.prod.outlook.com (2603:10b6:806:118::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.33; Tue, 1 Jul
 2025 04:52:23 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8880.024; Tue, 1 Jul 2025
 04:52:23 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Heiko Schocher <hs@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: i2c: designware_i2c: Remove clock disabling code
Date: Mon, 30 Jun 2025 21:52:17 -0700
Message-Id: <20250701045218.8403-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::15) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|SA2PR03MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e7e331-47cd-4bf8-bcd8-08ddb85b119e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L28vU2LNoJ3EIImqrcEhlnFcxovcQi2cL1GFk+gEGPucoVL+1mX3gN9iRZpa?=
 =?us-ascii?Q?Cfc/WtlT56w4bOWrwQHVV8DKPJobhokEJ5PSE/29Bh4QhPQO5pTNykm2H3Gf?=
 =?us-ascii?Q?EE01pvpv5MOqi83GAte7G6ILPYcxcTzLeHeXDJBytiteEMCTrQxT7te2HSTm?=
 =?us-ascii?Q?TwVLeFzw+E1OwRIfYycRAnLl7N+sEj9UxVJK71HnvRHIV6fWbFvlCyVsMyvK?=
 =?us-ascii?Q?LVUsj/x4wb9J4rouB61/UuAKIF9FDlPNtzf/lyIgT/zFNC8K7b9IvMSWuhZk?=
 =?us-ascii?Q?bfbv7VPGMMUbV2wenE79DYLhectQzfFx0uaCUvt8EdhQjDkEv7RjAVBIGA2p?=
 =?us-ascii?Q?xf6rKJU6Z/mpWzSZAs+LtebauOM4x04vs34yMi8qB+Vn8Yxig6iAnPKoOUcq?=
 =?us-ascii?Q?FNX7B7tm0hrl5PbZg38pUUTcWwG6Qnr/nQueC3UCeH7omDCDWigQK69C5aeu?=
 =?us-ascii?Q?oNztidpszETK9PUCEtL4bwtpb/2h5i71Y+hpSw/48QwDswfv79BMj1Vgh1QX?=
 =?us-ascii?Q?Q7HEfn/Q0BT+4xObgXH8JN0kymt5NwWkvJQl2YKaULVMRDL2cmgu85nWs22j?=
 =?us-ascii?Q?HbcX+ZyVReHQigeo6vm8a6nZloHM9mHQ4JEt3D6AZSwQuNiucbr1XR22jjRH?=
 =?us-ascii?Q?3A+PXu92quOZ0YXLojOdqb6KXrbkGsCVPhvfBSP3P/DQsfrIkBgenmwufVwa?=
 =?us-ascii?Q?Da2+LUF4IoTi2ggVHO8t5ovPCyzXitb5b7FlYBOQ6Zc9VQds83N+hjlLOS/7?=
 =?us-ascii?Q?LhSZyDwDBzdCZhbt1a+T90OxL8IAS410faclxH6hGUFgQdeX9qjo/ELL6U90?=
 =?us-ascii?Q?hJUGERWI+fkhInfo7kviOgsuMO7cVIpllh3fOOFNcB9CUQ4Q0QPPS8dDcNGJ?=
 =?us-ascii?Q?cIRowEUGqicNscvzWAvVO7X+t7497JnjXQn2LJRUHJkXlXaP1BPqWV0a77ru?=
 =?us-ascii?Q?sJdfnI9PRY3EDymnd5eJBtEuDKMpXwqUBRhpcuCzfoXPk1EIlEaSnhxW5kOP?=
 =?us-ascii?Q?F3bbYy7bH61/RAtyQRZtSAref7P4Fe+/ETjB9CR2EiAvFAKn51i0FpdVWWwX?=
 =?us-ascii?Q?TuJTCS/GUg/O+5aadqFX8aN1J1c+t1f/Hdf0YdOPfG8ML3ImOXMwnVjW1fJk?=
 =?us-ascii?Q?OBluIYJuiV3m7RnEtJC/1KoMEp1CRlU8tHJsj9UK0hI3tl1oceZBdrGqks7u?=
 =?us-ascii?Q?zhoqV7y9hffMVA59rb+2b5ai0Qai7zJnp6EtaY8J627GuQ6IqUdpxDT04biB?=
 =?us-ascii?Q?dWFcznWSXHNBEurkOEOwUQvdW/SwWlU+bUuxaxpiM+ROM/PRuju9+RyccSUR?=
 =?us-ascii?Q?CnNND7M+8l3j26PYeYp89UywDWL1Z9bPGQetYW7NKXpODh5Qs2mQALcaFoYf?=
 =?us-ascii?Q?A3LN/YfdSeDkcSt1yRJEoc7KB5gfzlkpta5wMtrxmVIchga3P8sKibea5fRO?=
 =?us-ascii?Q?6CN0EwCeI7c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+WyjT4Tm9yOrYks38zRoSe9xuMlfiJBGNbx5i9PHu+hKxRyqFeEcORiU6gKS?=
 =?us-ascii?Q?ti882wnQt+uAwl31MSeF/+7Mk0e7xwaDHBPG9Cgf2vEoN3oJev4k0AibeeeT?=
 =?us-ascii?Q?/aI1879TCkquEDZ6o6IRewZZO8zELFe8bAagYIAl5IhEZzAZg70UHh95Jlsw?=
 =?us-ascii?Q?KD2r7PVGiKYcNb+l9Civzwxbl2Q2s2M86XAwbbwKEFAUWD7xn05GhrwGmLWJ?=
 =?us-ascii?Q?3hWoIzakgaZnKuKZ7IS9LBKhkcMklxq/1cesDCOHzr+x+bingFpwjzeJpm6m?=
 =?us-ascii?Q?+qvrn2Bw+0XG3sbudcUTFa9eMvdw922+jJmPh9/AEpmjtylV6opy2CLREAOQ?=
 =?us-ascii?Q?v4Nz9TAUAYYpuw8UV8cjr1ETILW+9u/r6CRuQOUUP4+RDCnh7OBr2lsPKXlI?=
 =?us-ascii?Q?MNhHLBnH5K0QbMH15IWyHmLYDU1XcqShV/R/tm/I1He544fs30HbeAk6YTmv?=
 =?us-ascii?Q?fU+gneB/Yw1PC95KtNlQhtIVrkIhl2JEA/SOKtJxMzhcj1HdcmviTlYlqvaO?=
 =?us-ascii?Q?tSAFuKM7ZeR4L0j1oZj6su8FopVois3jHXpiiaDxxn7uNSZ1sBsK0nZfFijW?=
 =?us-ascii?Q?NJWc1Rl8Fa2Eb+lHwR6R9/fo2GKFzV/uTgaMhSn5/S7hn/5wi6SEFU8/VyZP?=
 =?us-ascii?Q?EU7mAfy2wwSzsJev1SU7BgH37LTjzM1QCV7RfzxbBEeR4LtQsKtQFyJhBcsW?=
 =?us-ascii?Q?BPMdq4upCjBToUmlw5DOwuYBlDKX/JF798jW63Vxh+1ADW0i+9vcuKuBzfF5?=
 =?us-ascii?Q?XXxVWdWfnktFEaQGGEf3U9iF+Ak7N7PL/B8bOZwdOu/ioql405RD6sb2k2X5?=
 =?us-ascii?Q?9DNWwnTOS484scz1J29kM2Ch9iCHXJnys+UUpsBaPWuTnHGQceFgkqUQdLvE?=
 =?us-ascii?Q?5HlI5T4qJIozRED2YwvoMsomeMDeEHW2bnv3xN31Ow6LANteiieQcHAqX4dG?=
 =?us-ascii?Q?NhePkCV3m8DfaORMtUss5IDToAQIAY+Rz6Wgs8MUBh50eAwx9FySzwj9Ntte?=
 =?us-ascii?Q?l5ntELVFCaO/atTlwUGqWq2YYNWnEUqINCyt5ekTrp/10s66gyAdp+9C7GP2?=
 =?us-ascii?Q?NSmgxApf0MGdMAihW7FQUVc0Fji7i7zIwyuZ0e8VmgbJykpX4d13klvx0QdN?=
 =?us-ascii?Q?tXf+j4oeqtQwkkCOiSt73OKaepsFkaowDVz1fC5zzJTs/gLv+DAB30fz7kpR?=
 =?us-ascii?Q?oYNRA+uPuoPWGm41VFXsvA2YpPLlFTYpCl/azU8WPSpuNY4kuX8M0V/h4RCo?=
 =?us-ascii?Q?0DhWBLvrsHvcARosiRwpIJ9af6d0dAM6w0GNgR9ckS3vfBvQUACAb3cKEu0o?=
 =?us-ascii?Q?hbCQjTGJs8etZqzobhFyyFkyAWv+XTFgStO9VkHYPndjJTKpVDm54MrX3OR4?=
 =?us-ascii?Q?aZ4846EJd5CncZpq/AIUS1AWLnQjGYMoe5CXnhEZoXxUpySc4F8J/ozerBiO?=
 =?us-ascii?Q?IUtP/OyoDs5FtwllyYHI6rMVv+AYSZBNxRyYyKZvRXjW4rw+uKlpOEnHH8Ay?=
 =?us-ascii?Q?gcsl9FnIrK2DZuR/0YixREQc1qhrNvQP8kr07VbdKC38bmnZjIb8dB94uMgd?=
 =?us-ascii?Q?KyLJbDZQfYDsaie/APNTiI8y1r+yjQeF5Yw1Sdkx83YE6mxWCnT/3Xiuo1NI?=
 =?us-ascii?Q?OtG1Icva77gey3minyd+V4s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e7e331-47cd-4bf8-bcd8-08ddb85b119e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:52:23.7108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5VPglOayPSSYlpAkZuUriItwANY5jyA2QbPMm11umR4yQp5Kw7eyekaaViIIs+Rf3hvz4zXurRaIiXC2uVE/335H3g5zRWjYRgizbjs07pv7xt8XMpQUcqc5IJNp18i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5850
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

When i2c device is removed, l4_sp_clk is disabled; this would cause
unexpected behaviour for peripherals still running with l4_sp_clk.
This patch resolves the clock issue.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/i2c/designware_i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index a54976e7889..ee3e027d694 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -807,10 +807,6 @@ int designware_i2c_remove(struct udevice *dev)
 {
 	struct dw_i2c *priv = dev_get_priv(dev);
 
-#if CONFIG_IS_ENABLED(CLK)
-	clk_disable(&priv->clk);
-#endif
-
 	return reset_release_bulk(&priv->resets);
 }
 
-- 
2.35.3

