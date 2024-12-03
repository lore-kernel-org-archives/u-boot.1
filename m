Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E86E6C5EE
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F1B8966B;
	Tue,  3 Dec 2024 04:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD81A88E32; Tue,  3 Dec 2024 04:06:08 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3C2895F0
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TavKc4dmY26AZi4RLmXw6/dUSwY5GDnLbzDnnO/bgvqx9LuTLiJKLaJrUYNx0TOxjx7IUzp+Oh+ChfQc0I2iT/+Rad3bb6QNg2UQCbupufvtAcBnqD1iP31kjYeH7kcwj2GwYMS5h5+YX+PzdtjN9D7guMEBkd67f/i63UMMClskIffSy3ChWZwZWyXYtVeeZ9K8qFINdHrKQNFoioRfm/S8AnTUj9x2DC1D6Ky9moGlpPTejwYgeSFg01t8R2dx9YR92NN7B9R9jG4UXGKMKDrVj8Vo2apmWWsoIO8D62Z1YEiKf0BlM0oTXjB4CghNu/skwp3ElSBu1jmhBf9TzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1cxM2UKLtAU8lbAWkChSJjw/JyGpRvuwVT4mQuAAyQ=;
 b=gB2la7vwOQUA6jSVk5sP2oVpUzJBGVsdSf/wMjQk5OUO4hfkTWf3lGBrUJ4VBdZWZzraeAUMSBhpQTrPRWIjZKuFEjSO0JW2CdbgzyCj9U2SeMDaMhFL8DDhusk1EAJ9FjeFx38FBoJaa8vuM0/DDtXKGf1SNsx+qKrTZ+e8MVtC9/trRlPHbz09M1yq7JSPmb0gof3whBC+orEonfpAuKVS3N9LhpzwKxziINH2Ibvcj3/UivU1yvVswIEnF7tbXoROsGIfL6GpSDs3wpAndHMTolbgRUDgwPNgwkRTtqCgYOrywzyekDicR4GDd4PGlsluj1Ojfe8v7xioDIYnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 03:06:29 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:29 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 10/12] board: starfive: spl: Fix the wrong use of
 CONFIG_IS_ENABLED()
Date: Tue,  3 Dec 2024 11:04:28 +0800
Message-ID: <20241203030430.26089-11-hal.feng@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
X-MS-Office365-Filtering-Correlation-Id: b982fe79-b1df-4c75-6045-08dd13477b50
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: E8eSAWCLnbvcKvnM+EDLRK614Jrp76rj/uB0fJgfr+swDvifV3A5iZKqDQ9dqtvypFn6T8/eNgYKWBCmuRH/6HCoSojZ1F04QOP8jq+/on46OknPuERXT1JhXuOxal17Lo0AquFCNVBv/ynr1cOhZmBHt/oMe5Kp96n+dT7JNFHpGRaJsBoBx+FtXg5boy7z3LovpBSbp0r/dkMfj6c/RnPE4Xny9A4nHi1vMcrVIrdiFxL3+ksQdtK7UFFswKvLmEBdw1u1zx26qwlKKhzd7m53widil7+2wCWmngk9dmR+gH46C+XvF9Qdm7KwCTdVykIhMOPAzpRdArcPVntuhQIBqlDe9UljBOQ0jvbsPDCzkvR/bcRwi+ol1eBDM11dwbIAlpnAK4zYA8gC1SVSrlyEZbitWx1ArWAeC0j4kZP9M6GtyFMfaOsDNe5VzhW3NzSSB4B3rVa8yn2g/w0Ffv+SDqaHGUaDXuDSv5w28b20+Eitp5a7v3FB0ekT/idvEjW7yfyJtpH+tFaxFOcMR6sSPedTArV3js6ccfKdngDrO65dVvAgyWTCTKA9Lz81N/jfc021GSIt5ohXofLBfAavBbeWkJgyUM6pDemPrZkCGKAgT3RTTUa8QT/zvzSItCNPrCiKMgfEcBNEo1iOKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?En+q8fBDn6XCfWS0H2IEVASMKeNrnZRwz8e6lb2OiXGqhqOMO1lp79pBSGgP?=
 =?us-ascii?Q?eroq+jVYazgtKDry4Q1MpaqcjeqovLRiS/JpZcHX6ohANzRKqkAx/AblDtTs?=
 =?us-ascii?Q?M2JNvwy01YWHQaH5KqLIjUTlCEUh9oO74mRGs/Qzri0XxTdBgKK/4Vipm31i?=
 =?us-ascii?Q?LP23HOr3x5GFaXh2C3jRhi41NtI/sr7ykcEPzRJunriLPnlw/oNea79AoThB?=
 =?us-ascii?Q?Qr+Fj1FnixAb9nHuaUZTXUekiFwWnSusz4efoeXrvWLb4mbCgk+y34bY5OKx?=
 =?us-ascii?Q?Xrhl51/aEjbNu6TEypsycGn72k0kBb0FoSd6ggEgvJP/ZKVR06JFzshZBiPI?=
 =?us-ascii?Q?xQHDd1vFkBOYGTeBmBnBMwW+UsvFf16XAMZvLMeYlEc5bS5b2oxpR0pvtEaB?=
 =?us-ascii?Q?FoWuEoKHBcjut+gKMOaL+1D90dpT1Wb/7h+NzwrgjTy5gRDb0IbCtO3L9c8P?=
 =?us-ascii?Q?ao15z0i2ekevNRSC5WlSSX+/tOZdgTVjE9m5F5Uf2Nt6BQYCLDJn9+u81pLK?=
 =?us-ascii?Q?h8YJwXTeEODoeGJxDRJK3tMdFBbaXlfm/T6LpaxEIS5frIS0donssV0S1ysv?=
 =?us-ascii?Q?SJ+PSBSy2KuSqRN8q1fiG9TVJDppOLMeOg1wgmjRJLSXEd0AaJ2+THZQpU+M?=
 =?us-ascii?Q?I0sjoE6EuJ7Wz7UtiB0e2Y0ZYxxXZ2tKfb6ZjNzn1dQOFucQBRtALgpJ6Rwt?=
 =?us-ascii?Q?nfIn4oL5bOBISlhuVcJPVGgXkyZacvV6aR1UKyeE+Rbk0UROUWf1DfY3zK03?=
 =?us-ascii?Q?U//v4XFnN62uiCJopfpqwioROmODkqtpdegsaKfm6NoHumt28cW5zxsc4IRX?=
 =?us-ascii?Q?gAzBrXr5pEtK+Wx5g79lC4Fk7ywsF8yH7Nww+wqyhOkWIASCGkf9MAujLmUa?=
 =?us-ascii?Q?OcE1i0pXPOLu2BnucNrElhQD/iRoa7zY5n3WVzjZ1XFwQu91q5MkfADHx/Xu?=
 =?us-ascii?Q?js0UJ9ICj3efpop7aUfVKurCbZXSe0+QufN5yawOywKhH68He13nG38vkJ9/?=
 =?us-ascii?Q?QtvuKH72bOhxJ8Pd6ZEp8n17UVl70B7oW/ikuJZrxYg+jXG2KeOmnSS3tWEy?=
 =?us-ascii?Q?8srkQF5MVFrBOvBlEA12Kry/PokcdYb0zDwSkqlZtgi7UzSgHyjk1ePRlC1F?=
 =?us-ascii?Q?KCr1Ax2oBVWsX0TeKByXk0qPZMsKhsmCRaH8efKJLhBE3tLXmI3TqYcU28mE?=
 =?us-ascii?Q?6u9VyBVW/I6tzrLJ9LQ8N0yCLPwoElVXObBCZJoPR+WehpjD/7kw2/LDUR2e?=
 =?us-ascii?Q?/4NskOSFK841Y2z/8BNJQlP7nG4ep0EnRbggT/5dnQ4ZBCt/RG05HJQb/K/k?=
 =?us-ascii?Q?FRMMgGHzyfqWEIpOKEn34MO3Wh8lmlr8j9UZjpmm10WtRzHuJ7BbpEQ7YuUg?=
 =?us-ascii?Q?Fj4c3mA6DqoItfwSUMxbW0CTKRidJhWLW9DOz3sW9s7Ux/UR+lsNKMYD+jye?=
 =?us-ascii?Q?s6+0U1ZWVYLBUy4r5a9an2tj6BwZTj9SgeG3/Oo2X2NCCxgJAmo7A95mgZ4z?=
 =?us-ascii?Q?MtGxOkNblP+kfSCG6UZa/POZo5U8ocyZHbaHb/ONwzpaYNIycE0j9U1zknaS?=
 =?us-ascii?Q?dGhr2PR2g4UEnOdTXWpnJaPrHwnhBLEOAMTHoNu/lwotGc5zjs8rsytu0oFB?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b982fe79-b1df-4c75-6045-08dd13477b50
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:29.0051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzeQpwt7hnugi+8xXHy2mofPgeHm2w/eG/cecZqlsz57bqYmvzeMd2rCjxgVtBbRzB/7M6NPaSxKAKvH/Ta4m1ylLK80bzBxZkaCQhe+m54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180
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

