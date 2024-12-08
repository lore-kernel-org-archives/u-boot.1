Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257E2E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B970F8974A;
	Sun,  8 Dec 2024 14:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D23A89525; Sun,  8 Dec 2024 10:21:24 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A052289555
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlrokTFWl6F17hD1mpFTNzKVQJ4BTZfNxQScTivehDbSzOHavYMVFFvWyg/F4g4Fgs81ODNO6jKE8I+7kII0veRwl4JxoIGvD4VRmbonKKBYsnTbEexd74/prrUJpuAXjkiZlsvk52KSt0EkF465WZtPK7CAo639IhDpyfK55XWClgBpOtTOzK0Hrvs4xxYVP1KoczjmnjD8xp+r0aC2X5sxayhA+y/nL5NI+34UMHX/UDPx+dbd6veL5CWgyDYudA8o3kIUd4T/o0fs8pxf7Iv31ohBUuI5eW4u/vvX9wDFJwGkNUV7lGiRtDnRsG8qFen0VAkp3CKUmrChMfk14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1cxM2UKLtAU8lbAWkChSJjw/JyGpRvuwVT4mQuAAyQ=;
 b=BEYR4LGbgsmWQLmK3FEi0Oy/sOpA+hqHp7DQ4oXonhpUM76q9YrGybuvzrROP+z95krB5F0qyKTAgwOJHLJl+VMMO8vxQPtKv09WZ19pbBPwliHvYX8VM0eqdYX3Us7PD03uluL4vIrZWvsqSvvQ2b3DokEpvtDy7i+gMA3dunkSPhqUS9/Yz39YxS9d+LC+MieGFB4Z+tIjAGuu6tf+49dYn9tB5xXVjQMa3D7zlUsYkMOH1XhueVMFi7V5R5DmNfXe8kPT22hSHEvAwKHJunKkYg8/EdBbmkm08Jh0Uoc7lF+bxhH57lQVRGG5XtohR8zjBqYx1lF9k3pD3t0sCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:45 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 10/12] board: starfive: spl: Fix the wrong use of
 CONFIG_IS_ENABLED()
Date: Sun,  8 Dec 2024 17:19:40 +0800
Message-ID: <20241208091942.47298-11-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c9203f-ee4a-40d6-a736-08dd1769bc20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Vb7VSBe+8DTzCD2aJRMT7SYv+vMXwfH9NLLCvlgJ1W6dGPfie37wm97Fn4ZbKfCAVog7S1Uh4gJHR1xD/fz/G1wTkBRJpKmgHboSeLblN0Ty3oP7hrVtjff6PZL9pW9tRbpOTLdRFBNJ50ZoDiyYZs9d8Np9C6azmkD4kIO2qB4rmcudiHTuRLiSbocC2mCm7eVYkoEFz4DBAJUO1/0ojT33gntK4f5tSLqoYqE2aivzqHz8gew0jDm2nmebFkUm5HlT038kC9EejVYmKYhVIUxbQDMrNPH5woFG41lDE0sY9mRz6skAA3KU3+AwEHVhdHYtueXIslqiGn36wH18ccRW88ArH9Fj6oRPvlXsDDwdWQFKbN2VaeSSanLjHPc5/XaQMAikHNN/PetlPc1l5H5aEeGLX1j8YdclnskWNEpWku1XsFeBXy9cp8eF5J/gOid0P8dJujy2mISpAboS/w456k8cj+//eNvp7Hg4FPEuIgNcIgTClg4SsaoQoLcfNMBfROG1V1nnVrNE9aVhoYPjV952XMFPcXXuJsmwgzsM2BKPBDKqReTxnMur0NqYZE2HIIIZxjq7YT/o3LpTtWxC6LPC3kX6f7O1MonT8eSvDWeh7Z4Dfvcvuk1XSNd6GTbxW2KO1h60eVNY7z3EUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H5Ex+P9qvH2hnPMTZZD3WLOxyTkF4nUeBGSnna4bviuhUqRt0nm6BWlcgCfP?=
 =?us-ascii?Q?iFUAVanzjRKXhaxojJ0St/ICmOeFurSLe/7PM2ebPPCAWJyPcZMOUw6LmVbO?=
 =?us-ascii?Q?buwayK3MJg9ZE0t9Vt3L3tg3/4oMSgrTMNyAeWbfy8vjOHOzN47daYPqWAr5?=
 =?us-ascii?Q?U6txGR53Hn95a58nkgd+LbzZVpag3A1XxzadBrlADNYDAWU9qWfCjcxqEnoP?=
 =?us-ascii?Q?yNOkjT5sToz49suBL5SDJ4bh0TJ14MKnUR+Aujm7zdev31riKOGQvkrDxsHY?=
 =?us-ascii?Q?M7P1nFr/ML3AzoM6SSORSFF0guu89MANiS4IX/TXckqWrV+mWRinXxz4rdme?=
 =?us-ascii?Q?5R623E7/8QHomgpgTiI4VbNnSoQ9vhVVcB+CirMOBFSugCFKMeNdMIUbygtD?=
 =?us-ascii?Q?Aj4i1eLaBbtD5os1s/K7YPF+3WpkHSGif4DL9L9Kaj/p8mpioYu5Ieac7GgX?=
 =?us-ascii?Q?0SdhfzqPNf7wVu/9r701faLWnuZYFrvpijs2SWDXBdSJkJJNjccFS4dIscvD?=
 =?us-ascii?Q?kgjdf3sOSxYIeeqnj1RM0EEj+zCHjOTlWK8YOTCRHw7K1kidi+dM/ml6zs7Q?=
 =?us-ascii?Q?QKy2CDuUQlJH0r/7bY4wuoTKqVq9r8Zuny9xZ5CtSM5b7l9AH71wd7JWNcI+?=
 =?us-ascii?Q?yCyCPH1H0IPAbCiTAuD/Bt0HlFGkOyLhkpF5Od9UmtMbjFOoT/26Z9BWKCPC?=
 =?us-ascii?Q?GSfK7Du77sYyq28OVzL3GvrSbux0XJpYz9QWUpZ93XBgHXU/pMqNnrmLljma?=
 =?us-ascii?Q?kFr1W45KcHYurRjTJ1UhDkQm++mUJ1t1W0LOL+qBgOjANARNBC5ZtSqItbup?=
 =?us-ascii?Q?jg8S8UWb2NKX/eDdfxiAnPkhKMVBtZAie/W+uKiSeE4Je4XpS6/Y5HcC0xSK?=
 =?us-ascii?Q?12f4/9VvbkwN7TODYBnj3kH+2SKOEyEjs3sT8k5ya+hld1TBeq4YmChx2AIr?=
 =?us-ascii?Q?haMqxMJ6/hziYT5x77Rf2HeJiyacAk+Y5x74u+zYbX9fInaB3byYEEPJlK60?=
 =?us-ascii?Q?07Krb6ptRylndXbV1IbNTBo7Tl38SWgkEhsHfHyWNf7xxeBB3kzZvDy4soiS?=
 =?us-ascii?Q?eYSjjCfngx+FCEsPZphU6HZhScOhf1GmWAVgY84q+bqBS7+7eRdTtLVKnQIJ?=
 =?us-ascii?Q?bimc+ixnCS2q99Wjg96FoHgEMDbk43U3fxo6DOD84bUo6QzEPoKguf0ttfuo?=
 =?us-ascii?Q?AZPJ/VvNZAk1JtILYq8LZJLtfIDVAELVvr1hGNrtyS3SJ/nPIW5DMbTMK82m?=
 =?us-ascii?Q?0RHBh8itbWna5O4WcOlLXxG9xRt2fUmxPb91GfvYMpBreTdP9vp/QhgSPsSV?=
 =?us-ascii?Q?gekwyjIcihYRxMFfi6bzQ7gZl9O243PKVxD7FlYBG2mN0B3mKj57s9YgRhm1?=
 =?us-ascii?Q?9ZE+jp55SXXNssTf5QXyjBQaHgdkg79hYEwtK8xRKbSHm+giu7KQj/dK9zE0?=
 =?us-ascii?Q?mWm0pMPhqUc5vI/i5ZCl720UOPjauMgGGntA6XVqdsq0AP0mEbyrIMNvt0JQ?=
 =?us-ascii?Q?GP44IAP66tRaMTm6JF+rbcX5q0jlMbtTPsl5WZ95q45n2T1X89U3ijsPyVs3?=
 =?us-ascii?Q?hKCiFkGcJEspobnqZvDtfHxoj176BEnhIcSwMnLfp1jT28Q3l/QFiult71Cb?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c9203f-ee4a-40d6-a736-08dd1769bc20
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:45.3100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EITP5Y35x6Jr0+UpxRogkthgCgATJRQvDrU7yZRflhClibL8/hYAL4ogjv051arhSWz6EclGzdDIH/B9gxcTm+DICGeERlly3TckZSb9/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

The prefix "SPL_" is not needed when using CONFIG_IS_ENABLED().

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Fixes: 5ecf9b0b8a75 ("board: starfive: add StarFive VisionFive v2 board support")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 38132ecccd..cf7f39d5c5 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -110,7 +110,7 @@ void board_init_f(ulong dummy)
 	}
 }
 
-#if CONFIG_IS_ENABLED(SPL_LOAD_FIT)
+#if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
 	/* boot using first FIT config */
-- 
2.43.2

