Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C065BD1A427
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F36D88A4C;
	Sat, 12 Oct 2024 05:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D1288B55; Sat, 12 Oct 2024 05:14:03 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE03F88C9C
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTAc+jA/ZtX4r54HwVZfgz7QkSb0wFS5buJkE5kdQCTRVotU/yEpvnEz3alCQ36kpHMh4yBL7zN3n8juCcmff8Mk6UPDcsqetWWpoYCNI4G0ERP6gyjN7UxlI6DAZ4uND/zwQ8LlLDDyRQG13Xae71acrzjSvfErJyN4tEGKXLryo7ZK9b3a+0WOO57zzYlcunx7qfjShy4hGO4pQRDR0xv9JL4MoE+FAUJNKX85Gfko6wxgeVSbwxgsyHdpohiGgjtesmX2leyUbdoUkGZ2J5JcYKtU9ePsyivfWCjj6oeFfljHcXKBiCy56zinThxzjgckLYINmOnMV3FFP/A2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBbY04AM2fpxDBKDKIk+bYB3siZwaaUSrfxXQT7cJyQ=;
 b=ng3c8cPxi4vAexu3Gksl2wjuUFEW24tWGMI5D7NVBnXKIKzwwT7462YoBYyz1vJF3GPJp6SI2I8DRs6dWaqWEoHgv/HYzKVR1lfCgClNkWYJaFYmXerYzYBRA7G5YnZNBS0ZxQTUWsoRIcYMSf8gb4t/PD+9K4t+LhamDXrYptGUzXNZony8zUcaewMEnwtUP18ol1+MtmmvaWNXvtZXyCBbc4hlYH2/1kp809/PuauHLq+7HFUITU/IpfUVtFkZXkPodJ/WndYBxoDV1itNtpw6r0TxzR1ezwjsTvW1sRySf7Kv19DnBmHDLwsSG0IDSNP6Sk37kJucQrTTG2Mffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:51 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:51 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v5 8/8] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Date: Sat, 12 Oct 2024 11:13:28 +0800
Message-Id: <20241012031328.4268-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241012031328.4268-1-minda.chen@starfivetech.com>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0850:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e464b48-b352-48bc-2ef0-08dcea6be580
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: arRj9tPqYgng0Fy/EmJPviloX08RQaoDjHDcyPfJOU17ihKmMcm8UuEM7Vsh2+KiFoly8/u2JS+3szeAHLfYPUyIyDj8Kz8eomgECftblULQnW3pGwz6BQ72HMoUS8B42TODNpNPKeTIbu5WVdwkCPfHrafO8le9zb4hMGZ5PUJ0tjPurWireF3CopUTiBm3N3W5iYbb+oRPoQRImVIeOmGvpCeqtfpZJBntEyX6F64QnYjhKHRiFh9chX72BjBPWg9yfi7QTfIIYI5gRW0d40VndOksI/ct45tfgkLTjSswTOopgoJW8E+4QabwyAGEZU//12c/2pYYSuKwIQyGw6CjMyfWvs3NKVoEBjeb83t4LKyXpRLUbtA5QHrjEGx8ijWVqJkv4Unw/PvEoL8HNMdfHpUpErYTULiPq7jfHOAlrdepAVWvncORkY3ecO9HeLtTurHOAwK0I/G7rigw4EiKvN9TOQ7WJBIoWTxMlYkO+vRkI/Gdati/X3yW+Y6fJBEV2UKKeY7Jb4bZxNRVfzIDDtWQryAeh58Z6D98+Hwqv1I6pJfTKITK9i0plar7Zk1iqYtP2+PShC0Ibwvqy39EKtdW3cg4ayHfhJeW5qNZF7KsJvTyxj2r2MmMmzFuTEECZhNQaWs4tfrHezntYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gK76IVveFk4cyoQeF6lbWMuIAyNep3BEYTeNBLT07cPPsdnzZ2w3l7WwLeLu?=
 =?us-ascii?Q?x1rmhU89Slf8u5REVO4HlrbwJMpm/401T1WoeHlfu80Hq6687PDFbmH0lnrR?=
 =?us-ascii?Q?5zED30oNkP9pPqAZErfnzs7Tw8ayCWMRhXbBqjDo7QFQ4ZZErses2nmOF7M2?=
 =?us-ascii?Q?S52K38ryBDmoAt41P9haIsg74Y2hsEbVDITocX+WgK9+kgoCd8ZGMmse28Gy?=
 =?us-ascii?Q?bPe60V/ToUD9GDyGXdapeRFxf69t8hYS3Lcc3cIRtp9t+9/gTgjQ0kpMP3bD?=
 =?us-ascii?Q?1tmWvcM2r2TNlBhcoKlH9Wl/E0pY/xtewz1ag/k0DR5AeDIVr0xCCUkQhhkO?=
 =?us-ascii?Q?orIFBUfAnkq9WpvqRxTGHL+rsdwJ8M+XWkvYvmwxN/nAy2vU3LIOUbWO5jtA?=
 =?us-ascii?Q?U/C3QuzbEszkp/7InKLH7hcTVmJ41w8hDqd83aCbw8TyE05QerCfKfhxKsTC?=
 =?us-ascii?Q?ydqj/yM0QhaRhbjTzCmLHC4zgl1f6SL6Czj+2RaKLIuUaGwotzPXJ02lpVEN?=
 =?us-ascii?Q?avlZ4NLSWjPXVieRdqgcyJEZEOAm6FjT7jQqN9lzc1IRsMjao5+wvW+4N+U2?=
 =?us-ascii?Q?fK+k8ZgB+2a76WFfmzG+D/c1WRT8/OB5qR+vzUurbqxOlXOnX2DY/mRxusf6?=
 =?us-ascii?Q?q+vDasV+6ngUW8WX8sK49UDHbNdoF5q26FH+OYr3Nc2dVdsNjO6WqQC3qJMW?=
 =?us-ascii?Q?Eb3LEKUk+8Cp6GE2pN+7v+nA7e88rgtcemTnYEXoMyxcc3cn0y5kETECUkMg?=
 =?us-ascii?Q?9k7WUKmJuUNGo8pJ7lRwomprAO/EQ06Z+Gxd5cQenLGbiqLIKvUA7q2Dz5gX?=
 =?us-ascii?Q?HrjjpohmG+B41Hoi7l8Vu1X1r1cRGL3U5zRRzkuQlG46WuyGmIzdxqcylLCJ?=
 =?us-ascii?Q?cBglGqCKzcQPIXBw5z1LI3DNXmp8BulrtVijAMdvgP2urbjmx/UKxk1gg6Xt?=
 =?us-ascii?Q?Bx7kaI4PiXIdXnjRDR3uAcL2iPwnDxrTACRsoOCYvtVeMCXtyiWnLLG/fqFN?=
 =?us-ascii?Q?DQ6WCeqaBDKtT7RIzXYsNzUbYPDCcMODUkUpG0aQOoKYZDvbhzZzmVZtNENy?=
 =?us-ascii?Q?1heyBs8vPCvlA7x2anHhivPrDwAvhWZcFBJd3VhA7WioBQv2ZRH8OyG4Z5Da?=
 =?us-ascii?Q?MBsEH26/cfIQekrAEQLnaVwJkqrBaC+FPFIP8RAL/PweXTtIUMZpNV5HvZry?=
 =?us-ascii?Q?eXf6H9FYYVpf3yyJDfhLwcmFYjKnfbwW1oyq7t0PXiud9Vb+dffRR5ttT9lP?=
 =?us-ascii?Q?IAPSp7RldLVSUo1raOmGZhdG5sQi0t/VeF1RGz/9NS8dd/0aShhwZ3iLqc6P?=
 =?us-ascii?Q?5ln5moMlO8/W6QQbzul4oES1buuVXFxR0s1jvbq8+hZcc6B49VC3qyUFb5eI?=
 =?us-ascii?Q?hplamVQ90aByX6bEyWUL/IWmoPqDYzG5HDa8EkD7i+ixbvk89XR2wtV59clb?=
 =?us-ascii?Q?1Wda0iUJbr2bCLpzTLzhxAoic6UofaodGPexRBEKrQpMzvAVPfzr8MZVhdku?=
 =?us-ascii?Q?aJEFeXODwRkRyDf2Or7hXY4p6KJpzG3E1Ql9+nT8ol9nS6nuhUIDhDCpahuq?=
 =?us-ascii?Q?QRB/CLh52ipIx65gXhvdBcz1rFJzT7OgBxqPQ1RrERQ/2T7gURfMOOmbfG+d?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e464b48-b352-48bc-2ef0-08dcea6be580
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:51.3944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueMKA8eVCqpZQUXt1RIMNn0jqNi+vL/OL2U8UJ2+g+Uz6m7asVMStohteURiR6iOXfV2tb7Ef1SvRy/sXk1f+XJSfP+aVjD3Y4h5T7h/5y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0850
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

Add USB related files to Starfive visionfive2 MAINTAINERS.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 board/starfive/visionfive2/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b41..1faf83f581c 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
 F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/phy/starfive/
+F:	drivers/usb/cdns3/cdns3-starfive.c
-- 
2.17.1

