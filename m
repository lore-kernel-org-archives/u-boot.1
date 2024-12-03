Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E85E6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3B5895FA;
	Tue,  3 Dec 2024 04:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EDF789610; Tue,  3 Dec 2024 04:06:05 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20707.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEBD895E9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcwEuxgF+0slTlkN8ohV3IScUVnmDFh8T4fnP4ueCA2UfNaGd+xEfKfHYJqTy13RiZ2h2h8x8O7TaFB/sKiGsujhYVgX1fhyEbxsPpdxcNPrtUBA/6kPhp95tohDow+pMzYyvgnuUQbcL/I7GYZUse7bfAAo5NfjXPI/hnG516dqxV7uTBhOMpooG0hauknlUJZG6lXDLCvVqAJMJ4Q+vYB7P5XRlAi4lYJ6NpDMp5G9927RCHvim1nXN5UnvfKVWh3JWav8j5byP/6VaPwf/gP9wDQnup2b2Js/HiAm3Fd0lsKRKLJ5Q6f+dnHw3V6mNkdsN3KnAaFuD+4jVrA0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx2ZaJUYST2jP+DGGgmWCJpnPI07SbCs/En3qViRKSA=;
 b=Ye5179TRKhDm4uXkBgY4CT0Qr6ejHL5W9oVrslUwsLuojxCfxog7gSr4IB1eg8KmvC3bjvh1xlInoOCsR+sqvZXBRB7FK4T4KI/DQYfdtC/EfICTKHtEpWEVX+Em980B98YpwLotMKw7WiwLW8OB26JJ5ODFtF5MqYhg4WZVKOsnXUAYTZi7BXO/fu6o8+D9CLbO7KR64eMJsUaz+2j5CkVN6tPYuIsDDxPgjnmyFFXkk3XcefgL+lUAqUWSJrghpztD+yKPS/3nuBUMWZfQ/sUShKrkCS16/wvFgUYO+Ljmm4ySUy58QhuKa0QAuuKX9lR7MIbaG2fYzobwM3jCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1259.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Tue, 3 Dec
 2024 03:06:22 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:22 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 03/12] mmc: dw_mmc: Add "starfive,
 jh7110-mmc" compatible to match upstream DT
Date: Tue,  3 Dec 2024 11:04:21 +0800
Message-ID: <20241203030430.26089-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241203030430.26089-1-hal.feng@starfivetech.com>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1259:EE_
X-MS-Office365-Filtering-Correlation-Id: 29bed8ef-4aa0-4dc7-41f5-08dd13477726
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: XrfWO0pRBlkMlTUlXLHT5lSnyOlasPBX/h3Dh6DcZ1/lYQa2BzKNnh/2ZgqzdF/BFLnql7jdco+TKKIj1tjnR3KN2Cw71rZSAjJh0yZ9FqmQm8ab/ai2c8emH0sCFih7CEq7pFC5un8WNtMf/O9baYbUOFBGg9p1DXyCQ6AYKBo9w9jETCG7DJ+qZmVi25A62iIng8rFcG/mio6q/9syDsz4qK2vpBGSf0q9ZvPR1vq+565FcQZ64k3Wccg7PX3KqMhUh0FgLsvFOyzKLir3A2ldEifo1sKVDQ+0jncvvYPWsmqPx5+TS3z1wZEG84+kBEIUbWJ9/YxC56EyCU0F2iw/GVSSDmGrSy3MisDl7/FU+bWucwpRKMBfHOQIk4Z+m5NPubMNwOpC26wSDy8xjPX53cnqrWBqFNoYsv2TA28JLPpsjjMDdI+5ZYmQ4tCi5Xc9mpp2W6bi5Qd7hFQID5SN2WCIIOc0QYI8HQVAW21i7VvRah8RvU24wexxAfWsUlVSk0U3Cl58kKSJTnAxo52euC8EH1hYPWn4Sayy/stt9ryFsXxU2LS6+txxlsY2jeFssQAIKIPYlqf1DaePW4APoIfhFmIhil68B/Zl+Rrgoo9EytgFHdSUFOqKHI+QOoB5UGsyWiPvlybM1QgjfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bmKyTgAe8bs0aNzNn0VZFJhGQnOiUbeOjpCWmJzzbnptSj/V6lsjH+AY9Fsi?=
 =?us-ascii?Q?07DqMx8l67bvAE6l03Rn1iJ5UGW3aL4YTy0Uj+PVR9I757kjoQkaVKZmPrAs?=
 =?us-ascii?Q?ZfnBYTyNrrMgDJNSfTzpJ0BZLlSWq6yQ48s9gVbCHSLZC4eEEYuiHuJFGCfs?=
 =?us-ascii?Q?ISdCfpeqzwJc54I0FraLxriQnJfSeeJcXFNs/hfghape/P6SEJ6qgReyL0gj?=
 =?us-ascii?Q?DZau9/M3CQwPaYZya+hcSrWxXYJwlKHtKmRTwNr2RItu70Goeel2lfcqCou8?=
 =?us-ascii?Q?D09Cre9DZ7i+KzuH+yM0WhhNc7srdH8858fIgYc/uUm/jAsgWc6/nkSVA/mZ?=
 =?us-ascii?Q?7VpAFQdaODr9rfMUXNgsBjY/6kQhADDs//hkPqWkMF533vptplTTBjcbmVoz?=
 =?us-ascii?Q?XBM6AJ/JM1sjCwjA05GmDgk57MHt52f4SkZJRMGyWYX/kA71VlvuavaOapTy?=
 =?us-ascii?Q?NtUhHNHP5AtpjHShFo8yHSd4oNyDZ7XLkBpU0PSHzH6w6J3mWmWf6rJxYqLH?=
 =?us-ascii?Q?/ad0SBfKF5UotUQbzetAuaN0Mu08mwj9m8qlDPxfw753ULKw85DnwlcSdNT+?=
 =?us-ascii?Q?u7F6oKIH0T4o/1QVsDrsIk8Mf6jIWWnKFIF6y4EhQcTZg+coM7jsnGvXr4oh?=
 =?us-ascii?Q?Hqmu/CNGTJ4R67Mhy0CVqwFxikmzjPi96UE85SLxgn2qm1mSOzjvHG2ahggZ?=
 =?us-ascii?Q?Kub8zvziGCCM27PeOf4QfevM5SBDODTkuzXYf31B1Rr3uQuJWz4bKHzUKiRZ?=
 =?us-ascii?Q?iFDr2QM03G+4WI7VyvOSMulUw5GB5bvbclfOgxLO+58Ep4qmIV77FSf1KZmv?=
 =?us-ascii?Q?zAprwUCtFrm47UwT/5YQlO5ARujaf4d6EzrHuTXVQL58arcsyr5thWHSpNNb?=
 =?us-ascii?Q?hL5v52JZJb2BMjYuMCW/Jq8pgeEK/aLKiRoA8xvtwoCp/eSQYOV4rXsbNNoM?=
 =?us-ascii?Q?QTemiryZzgtHbFXYfNg7gp8FMRreaWFkOKYS9CQQBF4XOPpTiqZkCfk4Pwli?=
 =?us-ascii?Q?X8K4EsRL7EDIqFllNm/RU6cro47sT6uOqhmgqyH/Xjinrlbqt0WMMqFNuMHS?=
 =?us-ascii?Q?QJGgCByiEzlIEuiJdkyowcZguL1v9WJX1TnLsJaiq3GECj/YB0APgwnUqOlU?=
 =?us-ascii?Q?hKZpi/4CPgNtPjh8alzfmLMOSEJBLb+pcNc8ZNXsAnlGLsVYDOgtl83nLtp8?=
 =?us-ascii?Q?KgiAdGNYln2zjo7VyQXFL/DxFOWCxfKC/NUZaEyLjzbS7Ye3wvV76/jn4HmH?=
 =?us-ascii?Q?SXGqX6SCwj7f63p9q3ZXYnTGzOCLUeU1CcKMW+oyuvlLP1y1bdBksvGoRHiJ?=
 =?us-ascii?Q?DxKCORM3NWXU2sut68/a3a2xXMoVmCie94MdqZA/wGlna1ZTuWLYBVf7+nAI?=
 =?us-ascii?Q?Jbq5VhjTBYidUHBHr+4wbRw/XrbH9G5HGiAGmljsxpg1YATYgFmPA5D04Mmb?=
 =?us-ascii?Q?McVPVFWG8UK+0B5eOLpfHQ9u3JP0oajupZISm5TW2x3q15evamru2+AopVzp?=
 =?us-ascii?Q?0XjdRJr5kww99o48DQzix9NTFafItGnvohmhT+kQyKhb5ono6yehC5w2dvyi?=
 =?us-ascii?Q?/L6PjNNi5Gjz7tqEVRugXZ81krrpHO0NXKiYhdzfFQHysEG9PVwi1UXAblbl?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bed8ef-4aa0-4dc7-41f5-08dd13477726
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:22.0671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y948MZKuLt+xbnn7I+mZNLCAardK9/ATUz/OE85gDoNmJVSiS3jNlvHqGfRkCgNwtO0a1Z4HQYJdmb0QPmx/RzGfuV5n8jlyK/0FdVidBwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1259
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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

Make the U-Boot JH7110 MMC driver compatible with upstream DT.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/mmc/snps_dw_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
index 47ab5654bd..92880e0ed8 100644
--- a/drivers/mmc/snps_dw_mmc.c
+++ b/drivers/mmc/snps_dw_mmc.c
@@ -186,6 +186,7 @@ static int snps_dwmmc_bind(struct udevice *dev)
 
 static const struct udevice_id snps_dwmmc_ids[] = {
 	{ .compatible = "snps,dw-mshc" },
+	{ .compatible = "starfive,jh7110-mmc" },
 	{ }
 };
 
-- 
2.43.2

