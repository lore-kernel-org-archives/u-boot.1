Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882CBCD5BD1
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA894846A5;
	Fri, 29 May 2026 05:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2DE4846D1; Fri, 29 May 2026 05:26:42 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2071d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BED8469D
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9/ZaKekftrisQo3giJOKHGrWakNAFX6nCROhXEV7y9PyZdDRT9hEBMgl1XTYBTF3tbC1A98S9nf5vakbnS92h9F9qNg1IQPqQn8mJpU66M7YfUFsJke0tURR8yXW07oPv8EQx9JKsyFcMC5BhmdjScuTe/WwaykW7GKIzZzzk4w7KFv29FRdcz/83KCXcVXauCQJ2iTj1ZCzsgyMdQlcbWrdk9/TvwRH90q4j2j/pSuQdP0UIWPy7BCA6uc7UiIO8XjeIH3gdJVtnX6FAULqfPB1Y/uhiyacPr81beoCVGnnLANcQrAGXnxAvMngVQbAhDS5FAHC11qfiylC3TZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCHtupcEfbAAWcfL9VMJ4bkvxk4msEhsIDWQQm1gCxQ=;
 b=cp072gz+RrwsQiCeWHi+bwTs+Xn2ZwS/Z+GiDbj9bbEP+Z6i9DwAHDkUQhrm/1CPwLx0rriAwhcC8yVPQZmzgLSe4yEVUVXyYZb14G0Vnh9LQVgU/MgA+CLF5LIzjwIe5UUSNh91QSGsSVqXmdhiqtDsXAdWYQpLf3c+OahscTm2MwYZB6r/cqp0UwmGxA88Y52aNX7K8p7U9WMbZ2sqnNFq260Dx0SwB7kq/uaWC1iCq9WQWbxsOeSftQzxBmjvBF41fhVezey+ohbpeg/Qmn5n6aX81sIcdODpbLQEUc9PQgpl5ZhGZigTXrxxu4Aa9ED3tROmRO/qzTeTuGYSqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1210.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:26:33 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0071.014; Fri, 29 May 2026 03:26:33 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RESEND v2 1/2] configs: visionfive2: Add VisionFive 2 Lite eMMC DT
 to OF_LIST
Date: Fri, 29 May 2026 11:26:23 +0800
Message-ID: <20260529032624.6868-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260529032624.6868-1-hal.feng@starfivetech.com>
References: <20260529032624.6868-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1210:EE_
X-MS-Office365-Filtering-Correlation-Id: 858fe204-dd95-4673-8baa-08debd3214f1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: /L8GHMz14ECbBmM6PBkUU/FTbi0woHNl9UA1/iYXrLGJkJaNB7mO7fma/oIrkwhAIpToIFtVP7Zz2sPCB4zUA3K4rq6ZBtqW54pG1ZDu6hXFHPfXS4p7GzKXNrsNs45E6Zk4MZpoheSsSs6kVbVisxUMW3wvm7Bm84mKfI+7SCAZN+bksqtf+NphZEqMoBa6PlUSeHl0TX7mvy02AfjuKUhbrfsPAPC4vdV2cBP2gkY0TLAG0h9exaSzzXwdo8pwOI1E+UbHISBzjU0aenly7F64aJJ54AgdLw2wKDZ6uBPI65hI4GxuxM2MjSWotqvo2lwFQcNft43S2uuG2QMDA6l6Lez4T2aslVS1nXZwQP9hNiFUXs4vpyaaxqaaXG3KRTOatZryEQqSNPjzqs6OR8FN3bwNEaoI/Y9NLsHabBLQJGG0EDYcZhh4Fe2jIzFEjcfD5fcNuO306kjDAkKYleX3r9UeCqXVCPd/r5f0mkf0ZAUMc4iFE+BQ0GsqPK8/nF1Uq9+neZrFLmhE7+21DqicYrS/iZHOyOWaQD9C8CtvtB8pYBNKWBljV4h/ZEEt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xn3haYqVbdmIhTCzM6sfj486fdef28Ad3ItYTobww78rVqz/i/UqRNSuoASP?=
 =?us-ascii?Q?eWJTOzd10Pzh4pSddUA/r/18jVJO7k6kz3NjEm8QhZ83SKzRRY8BpMr2wb6H?=
 =?us-ascii?Q?SfeWSc9bdVmmN643p/fchHRZDxZJg4/0ONN0UHXAHzHjq3523xqWaaYPLnza?=
 =?us-ascii?Q?72JNLPttPRpkDG1gxCEDosTX+ffT5i9YR4YaxFsqtBdoerSUsUjvwRbhWyUq?=
 =?us-ascii?Q?boEdzHSMUVoaSfTDyIcR5stp/x4xzN8+3BCa7M96/rAc3zc4yZo2s8/Tyuyp?=
 =?us-ascii?Q?6KkRTJbgIvhAHC5wXfqE/Z0rE1TmkE6WLQVynkBXM0dY8eud3n8hlTsIqB0v?=
 =?us-ascii?Q?miVjVDU1939a5Ix+omcHZi1VY44v2N3HuxrLYFF0o/dlFyijI3oDyhJFRq8m?=
 =?us-ascii?Q?XZMKn6VYy3hLi7ksOWQercuE8ruS0P6aoPOiFhTC+3Vw9y5gzVg7p3ejrlSO?=
 =?us-ascii?Q?5yRIbQZ62PJd6F60nFXckGTeIwcFTlVVjGG4mlPHMQRSveB9Vkj0XfWXCuB4?=
 =?us-ascii?Q?vhUw71gcDIRA1RzUhAY7dn66WvEJawliU4QqzVhdMNPN/FKXMBckKLwAKbd/?=
 =?us-ascii?Q?HM4yWQinyrOXa5M+h3koWdMB3uxPKkovdGTBQUq5xNc+31AnNRiurahKDGMi?=
 =?us-ascii?Q?Gb20cvTBNnTcdtiPsplkuCKyciice7ULSg7CVdJKjpQeD06oVqF8j7wZ6ihn?=
 =?us-ascii?Q?rafER9PZGMNqL2NbOSZnRT6e4CUqBZ40IvDpOw8yckc9+01GCC3MCiBhLigh?=
 =?us-ascii?Q?eryoHwXWz3SrpcwndHQoeusYmKYDfUx4eLbu53Bx1JyGdi1sad2AVSWBmQB8?=
 =?us-ascii?Q?c3NXxoVG8TYgVohXLLAlnNzC/RAo7UwSXG89HoShr1HlG4UO5d8vJofpj+i7?=
 =?us-ascii?Q?mEbb+/V0GsCchaB/b1/2sA5j5yjUespFPBx4awErUdxQXYep9QgeTcdgOVj4?=
 =?us-ascii?Q?Z2zAfiBXohSNsGVcFBNsvtJ1gy5s/99q7N9nvbmDpmZ1FwrJzsoT6U2JDO75?=
 =?us-ascii?Q?sCSZNz1ivc9TcF+t3UV2n1z/3jP0AoiP3gIEFZRGbgVeLYoakil3V206ow8c?=
 =?us-ascii?Q?dz2Y3C4S15LuIQh9DJu1km60g7LnHl+XgHWKjcOHDpvEFkjC09G4/EnNLRqI?=
 =?us-ascii?Q?ObkgmS2/KXVn03fIseExnAjj9XQVQh1KSdsBI4qrMFV9hC+fClJFpGGUQDMi?=
 =?us-ascii?Q?jQFt6Fm/Q6Gyu7aTqK8bUh60HIbPqqu8kXB9MkauLwZg4PAXjbLsX1BIkup7?=
 =?us-ascii?Q?Zckihb3nbrplhcroyfI2b4+SSMvhAxbUroJZ26a7m0OO8ewi3rq3icHZ++fM?=
 =?us-ascii?Q?Hm0fttS0hBAiMTmRyF3HJGvqCDpBuBUa1S6j9AnbJ1T594xt5gVj7ViTii9Z?=
 =?us-ascii?Q?CHunX+kpoad/zpHw9XLXzvknZJxMmSlNsS2jQEHVrwE2Fqu5t+d8AtGSR6Ur?=
 =?us-ascii?Q?9+pgZHGatMEFpYzV4cCb9lw+xtlXbszdzw0pu6uInJtBXmP3gptgwa0u3Cdg?=
 =?us-ascii?Q?D6kd7f/ZnjX4+aHcg9CL14QFgj4GiY64PFUleCwxiITpvdTKgP+KpV7fPYjX?=
 =?us-ascii?Q?tZzHd0DwAtB2Wv0hFwsaNztPyTfj7RDPERVidv+NZv2Lpx14dx2wzv1MwIKb?=
 =?us-ascii?Q?gI52wmh41wLqCw9INJqH4esL+MH7pjj1J7tFSWyGT+OqeFo9oSYDhb+L3BIx?=
 =?us-ascii?Q?vehUi2pTsMqQhZ9FIsleup63zFIMujNxjS0j2jVx9b7oJunNMrQFJp4/3Pz0?=
 =?us-ascii?Q?eVrsGgdZ7PElXGyM1ZAMWp47TZ5ncLQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858fe204-dd95-4673-8baa-08debd3214f1
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:26:33.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYVWY0KwjkcdDp+hmsB6yi+QTkpv9fCz/7GzZH67FN6P801SvV5VbY5ozRW82eRUV/jyTGYczekHV8gbC9RU4vO18SRsMu9KM04NYsEnMYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1210
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

So the VisionFive 2 Lite eMMC DT will be built and merged into FIT.

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 23f903a6df4..6fd43544a0c 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
-CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite starfive/jh7110-starfive-visionfive-2-lite-emmc"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.43.2

