Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0ABE9B265
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CB783D8A;
	Tue, 24 Feb 2026 14:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="liIkBula";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102A683BC9; Tue, 24 Feb 2026 10:11:28 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0073582BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 10:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf801797i/IliVuxIWIq2unIOI1zhWX072dshb4qchJLfle4iUFqJxHrMYWk5jH0hfAcL6XaBiATr9x8UIKV0i2VnUX8m53/kZmKpc+N8304G4PEd7gzQoiu4QpqevIdCjNE/qOakkwzZVUqLTqnJRWECPBmKp5OX1VbagvqO36TPjR168D5itgDj6kW2tlr7ihSwJFTOxOIAfClvR8/Ixjq1b+iJTBpq5P1hWNjY6cZnVHMMwFhbWs+vhtin/52yFk/+/fLi7n70gy2DveKR855RQkPAtuXCkvDKIeupntRiYx4EcfF6h7s/0ZsS0pQ2rOvk84rxhrELaNRKcbzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWIfRrpo6ow7mVRzstfSYbF2D7Eyliaa6OZXBe4luho=;
 b=lj3pTEYR75QORDA13m+qP6PWnzCrmxBMIAHYm9v42BnM28CtTWOffr+I5kZTrsQc0RbtEQIyKYDthvCqxVfmskI0zp0Mr89LHlQ5cfqB3Hg6UNOACDPyX3PsyqOtdApOhGYgMAM2rpL15MklNmxLYJgraayrAO6qVaE6L7Ek6lBc8J1GDNrT+MTaHK3lKiyx3symHi0mCQle3+OKbo2PBLVS8ohhUXXjsCiuxySHYnWcOjiVML2wVj6sfQYfBSr9/KghDxBAHLUiyjeXaLQYxrC8t8LBsp2Pnd3/OxFf82OsTBhgiqEUoRnoQk+g0zzXoUIKu0KkyXOcdy+y4irhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWIfRrpo6ow7mVRzstfSYbF2D7Eyliaa6OZXBe4luho=;
 b=liIkBula8E5oWUsToXzkJ9RGC28i38YPJYe7JiWBM3v2bbWyhirdP1GFJjCGHQPNJ6nLZDEcEG/fdEuBFiso2rGY8UrzDDckNMQW6ND+E3RBjHnRGEcBl7SMKWgU58foAgONODjGxvUsuSEWTN6Vd0fCG7evxHpC5plUfXtZ2DUPek31N/RoqDVidEHgPyqdeP4Va9cY9Rq5LcCsvhTHSgzgrcPFZy/iPF6UduGq1TIUB4adFLr9hZeUS7yQflsITXCr9xh+mS977HYvFQRzGswF5tu24r0N98nqjNgMDZ2UCKp0k8+Gp+w3IkR30eX5lyIeV1nsbAPKd5jjR5yEHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MW4PR03MB6666.namprd03.prod.outlook.com (2603:10b6:303:121::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 09:11:22 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 09:11:21 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alice Guo <alice.guo@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v1] drivers: clk: agilex5: Setting correct counter frequency
 in boot mode
Date: Tue, 24 Feb 2026 17:11:09 +0800
Message-ID: <20260224091109.8181-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0095.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::36) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MW4PR03MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: d2916d57-804f-4a53-f8e4-08de7384ad74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18082099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?grDJXVNDaApZxAs1DrzR9p+QU4k/fMoGRkm9VGXpFVJLJ/ynbWpPjKqX+ZYs?=
 =?us-ascii?Q?fy3nI2XA85FEQF5aPqKuCDDq+uS5afFxNba9Hg3/CXejD5Y7YLZ2f/JWdv15?=
 =?us-ascii?Q?MXbdICf8WBb4vM4QRNoHeDO5/SJj8v4e0jwY0ZVr0fqcUUMrAs8TBcPj3Qmq?=
 =?us-ascii?Q?pQzKxLeE7c6uV7fY1YDfhVDDV1pe9GzYQsWsnyQKm37dMZSSk5r1+p4wAAWI?=
 =?us-ascii?Q?+Gzj+MACQveuR9LyVZrJ9gPUqbuHjM2oqNWeEbLHAfwAKg5myv4M8700Vlb8?=
 =?us-ascii?Q?qAPc9Jwpl2Sd5f+yijEBTQ+J0V0QKFdI4D9pUKQacAFU+W03cJkTW1gmvkUt?=
 =?us-ascii?Q?YB2+sOjYx5E2kdF4iWxYyMfiIs3LQ9faYrYesqeiU4eYWjubtBcoJxDLvnPW?=
 =?us-ascii?Q?HOxqC/asC7FRSpZXOTqA+h9h31xSrRCU3PAYfT8PzrKNkpidRgTVD7Yp1m3Q?=
 =?us-ascii?Q?5O5/jTaMO7XthpY+mzrlU2UniQO609HDPwaXhNuEppjwx8AqVcruInvWbAcp?=
 =?us-ascii?Q?8VMtMWmn/SLocNH9lMswiHuRkKYtGD7hWeAxW6bz2wzvQKSIV0ZpatUb9rhG?=
 =?us-ascii?Q?8Fnf2Ccy2J5GnB4AGMR5cKHZSSKXSVlKzp5vjUscbGU+Yrc9QG+P/cWiN6zI?=
 =?us-ascii?Q?qyPLyRygWp2E/VIJfZLb76RYio1qc/5cfmPwQ0QeHMC0z6D3IV3FAUHMzZ21?=
 =?us-ascii?Q?WZ9bGNj1oSdjJNE18Elu5bAS0NYjR3lPbVVuEzFKxbiMKxq1XyiVnoJhNSgZ?=
 =?us-ascii?Q?0K+Vh5pUQCnJ0RevWtEMf7UiFmCttlCguQgiHFecs3ZegvgD/EOAAY2pPSCv?=
 =?us-ascii?Q?j0klFrs748dw+X//Qcq5+e9gd1jBUKKFdPgShcvmpCRfUfL88B+vdVH9Y2Li?=
 =?us-ascii?Q?bP+9I8tMTjCeJiZxDumMsyScVlZ2CpUxUfSVNkGcfPioc/do64/WN7W9N2+T?=
 =?us-ascii?Q?iRRLzv8jppNjT4qYSwPm1c21yMrlZvpINXOO00cn0nfofIedaF6pkIu8+HoS?=
 =?us-ascii?Q?v8liGvyb+rv7+PcGfNWMepUOszdeIUYGgL58gOtzytCUx7twtvOGpl6VhUeU?=
 =?us-ascii?Q?R2pfGT0Mj0bAUUFwvry+RUxl8yOHbgZ4B1hIvkOvtNdXk4X8roifXkooWfLX?=
 =?us-ascii?Q?Rxo3PwK1QREnIJmk+xUcHeHjskB040w1nquIVaNOZtF5yVAi/vW8FovUTP3T?=
 =?us-ascii?Q?HTwr2iNPxHmHw3dvsKTgiImSBFOlU60da6prYUYHz4Wo2xbhZ8ndfWAIMlfv?=
 =?us-ascii?Q?eVyiLEG4DLb39/p7yYYSR9fEK5hzWRDPkATAlfkWVcCdLBd42zroQdNkah65?=
 =?us-ascii?Q?8ylcx1dBN11dYUeJ/OXRcWIfP9/weFsspTZseC4X3oNnge4CUZPotQ6G993C?=
 =?us-ascii?Q?AE7TtSUdm55blQq8MRCyh7ZuB/nAlskTM0xsQAbrlR/0giLToQ1buNRUws/O?=
 =?us-ascii?Q?PVIDMkjrEHyq1Ei8Uz1okNO2mnUDpiXZwDwTKGoFQqRM6D1Ro8Qm/3phFKVg?=
 =?us-ascii?Q?S1cBi8Zet1KK4la6Q7E+uE8uNSYDbDIEKMUbGGuUq8dVRhgSYK66EmsEaA+C?=
 =?us-ascii?Q?Vko85OtZgB6GcTEqvEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18082099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?meYhXvvRKTPDWwH8Q8NpNllR3zkj5wClxGJ4N5HfAXRaWMEedZuEAE5lGYaL?=
 =?us-ascii?Q?4dLg3j2Dbiw4kp7WSiBN/MlO96fNklTaGX/Xd+DimoKOeaX/VeuAHlnuGfYM?=
 =?us-ascii?Q?Fcrt9sONutJnU8+0wXwvOTuHRIlJJ22HiGQd1QXK73TRJqJDExSt28X+7gC/?=
 =?us-ascii?Q?1b5MJDVun6VXYcPPFUJp5GrbH7/QDbF/kNcz0qiwMrRsaqij3bFdTITlrYJI?=
 =?us-ascii?Q?A7oWR2ADix8pZdojQOPqrfT7/z4nfB2gWb/zkyVU+eGoAX8YmQokHgDmm+zD?=
 =?us-ascii?Q?hNHZJCrq/pxH7Jbpmodbaz6mDtE0Mfj6SnQvgMmVA5m4JccBW91cSCdPxWbE?=
 =?us-ascii?Q?ZtUhfTzKl4iFnbHYhzUPRuLzKUqrTdyJ3eUXuyMY2XTUFtvVd0TpbyVbbYhd?=
 =?us-ascii?Q?3AQ/7yVIUy2YsdEWx72UsOcd8iOS26lsMeDTHvmh0irx6mkrVqPryL9hlyx/?=
 =?us-ascii?Q?qC1JDOJD+bVaIFNWozfg/G9OtBflYXqd/HBaK38mL31bgdhfVblzEksNAFsx?=
 =?us-ascii?Q?ia8cccM+GOH0mCVTtfAjeuUbPM/sYInxpcwdJotyDyplAg1thbzEoOukYv+8?=
 =?us-ascii?Q?WQrpJ96ebn6iG6MGmhTL4mZ3z7y6RnKG885ZRADLGoXsOkx8z/53jrNFJH+t?=
 =?us-ascii?Q?VfbdL6nBJVkUUv1S32DJE7VVODB2IQTiAa4EvN4DTOS6YqpO9S7SJLMjrfHt?=
 =?us-ascii?Q?HLMi5pWD7svpYgFAkCFQWXtYEUV6R2sopMu/MLiF4XPD/vYVCHeE9Xw0PTxv?=
 =?us-ascii?Q?cYmtAhoaUyZ2/sE5TPM6y9gvuwk2rHFbbaIKPgKwsdHKNbSm0EQut5PdDwI3?=
 =?us-ascii?Q?qjOrI5XPNO5BqMQqpGfxjvoYHSv9GK00GWtVNRyOdYf+5/L7Hj0Y4C+BVPw4?=
 =?us-ascii?Q?wFNfcq3bSDLje8R9/R/GoAuNKoHSoTk+lylJAogeuNWtL6nrVuCP0BCpGpAd?=
 =?us-ascii?Q?H6Z4LgPuWm/nbKIeOiDZ6sWorC3tLTApq65zqw9tDcv/KvIseoKOV5/o3Pw8?=
 =?us-ascii?Q?v9sCyn87+hZWcuEsSKYVLeHx6D5h0YkY9HfsmV+Zlj8bE7IX25k68b6C7GmW?=
 =?us-ascii?Q?z6qC76GwxOH4cTfKVteHe+ywRhrF6vLjLRzVH+/EMAy4UnfwtN7miWqz7Udq?=
 =?us-ascii?Q?xonq/E+uVuWmLcraVndVqq6FDCZkYu2OQQUEAd5Y2CTq0MV9h2pO00jA5GW2?=
 =?us-ascii?Q?7aPEu502+wusUy/Kzc+mtWIE2gLquwA9ZyLQoYtJXS1p51KyY3TkfsMEjlfY?=
 =?us-ascii?Q?9JXiVXJcNg0yqkUtVGDzXc8gMiDsqT2ihxpro8L+X7QUzDOQ4D3+1l8uXAXG?=
 =?us-ascii?Q?QjWAMoFh7/OtLqMfQmhWFRqZ6SlyOmNVYVhXJ7z09UzSz+sp3hPo3vzWR4Qy?=
 =?us-ascii?Q?cmxr1aVNU9wa4H5bHOlCf2OQH6zRAUA16Xf9GAGXST1AIZf1fmWjAFkXhzWb?=
 =?us-ascii?Q?PJPL63OAy7OJnbAugnKbcMbYe3LSiYagDEK7vfeohnEbBqSj8baIiYNsYfr/?=
 =?us-ascii?Q?kAJKOrObQWp2v4Ase5vjhd0PRQq57dR3PcbEaaIs04drIn8D8sGjof4WxbaO?=
 =?us-ascii?Q?XO1Kjni55DFWvwGTnhrybkMcpfKywtdbK1yog00KbfM2c6Lc2vQivZjkN8Yv?=
 =?us-ascii?Q?fyyDwXkARbptO2OzupDHzeU0oIrocnHdmNKd+q4F5AcaCilQXzVCM9wNjweB?=
 =?us-ascii?Q?hBI7uR2Q+lM6BVBm4JAX1zrQe9fnA3uJexoO+s4OhR+o1ujOYYF9pFLDvXGF?=
 =?us-ascii?Q?SIubRzOivA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2916d57-804f-4a53-f8e4-08de7384ad74
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 09:11:21.9340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGexdPFFF7J4sL6HzZiCzLHAiqh+rZ9ewVOdWm02Rly5azo125Oyyc7mihIlMKpg1eHkzJeZgMjBSGZ+WPTajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6666
X-Mailman-Approved-At: Tue, 24 Feb 2026 14:56:26 +0100
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Counter frequency need to be set in 200Mhz when system in boot mode.
400Mhz need to be set when system exit the boot mode with the PLL
generating the high frequency clock set by user.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5508fce796a..4cc42ca393b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,6 +30,7 @@ config COUNTER_FREQUENCY
 			ROCKCHIP_RK3288 || ROCKCHIP_RK322X || ROCKCHIP_RK3036
 	default 25000000 if ARCH_LX2160A || ARCH_LX2162A || ARCH_LS1088A
 	default 100000000 if ARCH_ZYNQMP
+	default 400000000 if ARCH_SOCFPGA && ARM64 && !TARGET_SOCFPGA_AGILEX5
 	default 200000000 if ARCH_SOCFPGA_AGILEX5 || ARCH_SOCFPGA_AGILEX7M
 	default 0
 	help
-- 
2.43.7

