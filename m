Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F44EC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF4184C67;
	Thu,  2 Jul 2026 07:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MQPB+KeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802E184C78; Thu,  2 Jul 2026 07:58:02 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192CB84C6D
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1DB2bohSi2knslMrKxxE9kTLDyRfpYIkJN5gilKUou9gEFJqoFN7e4tt2vnLLdbhBOD0thNITxcuh/YApB12738IQvbDnR4wQ+IMzzlc2IR3OB+WlPe6oti7IB+vfjMrM7+RJf3HifFosS7ROx9KApK7QD6NU3mqs/1dP3NXr31nwtQ5GVw9EvJwzycOIC4UhgTS8a/tb6lCpWOyx8FvRyqXTJV0VghHQmNSme8EIk+V8g8USyy5nL8MVjzxgrDlzu6bSvPZL1Hdb8PeMlmoITtdkK5rLu5BofHKyQk/BbZXf/U/uDFrj9crDwzmmGv7m6ptrpuj/UfUfDN5AP96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=tE/yWx0JrGos/BNeZpkrBc/hNeLXxouyfigfOtjWNCquGwF27wBg0BPVHxw3Ea3K8i0LwLP7kOAR6W90CD1skh60G2QSGTzWjwyj8U4f/MmdscFSeDIU1uXS5KuRN7BxPZNv2CxPDVCudihSZP5vrabmqLEUtUi6nIkjpuMh1TPT+C//oN9CXE6tcSQrP7Hy0AUFAIxISitCGpaa6+O7ptpGBzydO5DjTULSo54nGb28MAVvCpSreq9BauE5A/86myLmhLl4WjeIR+6Di5aCz6mK3q1F5ypzbs2np3cwNeoGUeHKAQOlzmwq64Cu4CiDka5M/yssm32Xl7BgkKvE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=MQPB+KeAG/2CeiV0VdfFvcatF8rEP+mxqWz0ysuTfgsKKuGTYHHAk3Z+AdruQ/k2sVWilxvAzUrwBBwZUTNJ83RSFYNtz9K2wqWN3hB7p+VNJ5qOi9Greznj2cJol5B2b9gzqZlu/9E5py9/ajjDhioYa6Uhc1e8zrpLIsZPdtZ9MWBKtAiEpJHLu/VyyhIrgdgOOFnWW7D9dkqrOFCLVjnaa+E1TPuQ8hd5ozT54oXbnFTUNMkuM9wbJ3syeRsiSdnvFWC2mNJ77LoEAPmo6TkDEvgCkPtHdtLTED2cNS9VL4nL6pJRM3S9kY34cgFt87oyNzPVkVL+K3ngYOBTjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10435.eurprd08.prod.outlook.com (2603:10a6:10:52a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 05:57:57 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:57:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 01/18] bitops: import BITS_PER_TYPE() macro from linux
Date: Thu,  2 Jul 2026 08:57:27 +0300
Message-ID: <20260702055744.2164975-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10435:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b37cf2-10e4-4dab-fc7f-08ded7fedd77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|23010399003|11063799006|56012099006|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: I8ire6ZY+caHr9roIaYsstRJRWyhOzg5T2gS2LFnOpC7Mr1ONyyW/m6iAJ7RDADDEyt4oDl/0Rck/tjnoLfaYwUniYP/s7xM0BdF0f6a6jBsP/BXrCPzpk0fLEk1eYTHPS+19UaOpANICrd+pImkMTUE0QfJB7v8ukWsVDQm2vEcbhySQl5pleOEXHeYIltGPLkI8zHtXOzaakQKWYLRPTzgoJ6xi/5n+Sx7NTNL0+1rV8eJjW50gYr0vVejxxmVNOwn483Z885ac0sBXqCQb8nNbQ6cP6euv5iI56RE/sU4t2HtVx/+xoh4PsZsnDoNq2RYl0srP2KiXE+ovZOFHmoGyQpDOIdz4aLvxxk7x7lVVO7OD2tItBX8PrkPvGh9rCkRFevwkENYkPMYTGz29Lumug2+rd0FiFmxIngX2fEHycJJuAl0LohKS8qMvSUXHpizANix0UIHHTffQII8g5xjSjJGepAW6AqN8XP2ssm8IXJLVEtdm7aDqwe4L0GLYlztdk4dXHj0HA4004gH8VpXYYOX+sPEBTiMBBUpCnGvpKcslNjKWgscCEwX3bGZl+xT8SU48A+1MMKTAHCHXuYJ5CUXGClDfc3QubysAOn/7kyrsNf6Y6QN4syMvV5r17II71PiiomxhjpEsUyyM4LiAw5i4uhii5gPuW6Ksc/5yKqS106rkWWffVv6cNTXPsxLR6WGn7/9WVRyOu6RalD5nfApKO2wqFiE6iSbblc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVkCsYssc5CyV41fP4hNzxTNZ/COlJZ5DWJdPZYxzNyRadlEtYtk23NtWL3m?=
 =?us-ascii?Q?qzyLA5j3M6H70v3Azd767v6twIUfQl4nZyQu7H2p+DTjtsSHdP2VLIRMImNe?=
 =?us-ascii?Q?1yUzm3gYDpllH2OTVd/71mhplk/wE2Mv3cOweOXgLOUtmRvrLyLhJPFJt4Pw?=
 =?us-ascii?Q?0D0aW+md/CSmIgTOwMrCwixNANij1WqHGi/CYyuFQKN4Oks8KEh1RZCdneGz?=
 =?us-ascii?Q?erjCAW9nKUnRIMUW1NnowtOyjG90KxlrW09a3Az8PMZ7/f4PGNXW6A1Plqs4?=
 =?us-ascii?Q?ab9Bxgef4A9BGFdRGLmIa667/+IUH4RtLtihPglsFnQskNloUeYjqFIrDd8d?=
 =?us-ascii?Q?lChKjaaJ84v4hH0+PDsBgrygzJuVNqTRxl2Gx42b4+4Wwidn9e/uFgkaceIr?=
 =?us-ascii?Q?NImyWxV7K1NS/NE5W9eMNE7759oBRytUN5af2BgyBFe7r3uXDdemrAvHFPfe?=
 =?us-ascii?Q?JKGtcvrleMosh/ikhSIqXvs2QvZMOLONFt30oufV1OuaPtCvurQY0TfcN0UE?=
 =?us-ascii?Q?780UUNLaurvlJrBVCjZJwJCYhStq546ab4aAS++qluRP/tUvkVia68Npl8/i?=
 =?us-ascii?Q?VLFPJWG/8z/lIVTfmf8ltKTcCMbVxv6UD7+1y5r2UWVgO2uiKjP7zrM+hA73?=
 =?us-ascii?Q?8azGyg6RiUCKGJSK8Nt+pvGc97w+3P0ftKLCUzaafD/rPbAtp3aSMJrSehJF?=
 =?us-ascii?Q?/nAs0JyovEg/cKMdOjXz9+xtfK7+kdiUpxFybU28L5seEt1suMCwVPPM1BS4?=
 =?us-ascii?Q?NPjVsBIt6hSF5E44lJ6rW4Hr/kXh0670s46uhjG3Rgww4F1epGZro8EZsGYg?=
 =?us-ascii?Q?KoceF47d+TJwvJyLlbSDv9rFsIRGDtbHwiX7qk1dLmCJRyFFK4FhohfgsvEV?=
 =?us-ascii?Q?PKhgP/yQyHExlCzvbJufnUMdhH67muvyeQ8QXW1/YDs5eI+iarIKJWUXNMF/?=
 =?us-ascii?Q?ncS+pVgRt9ASFTVGBXK4WoZGv0W1rZrZigQb76kWu2HreWHby7um9QCjJD2v?=
 =?us-ascii?Q?ENpxyMIlYQ/Jxbohq8pKQGJoJaupglfwZtRWuy9x4KGVlJmKOHya2qaLIWnD?=
 =?us-ascii?Q?+5Z/Ry0XVgLxpQ022NK7lqGyX/MPNIS9LYNj83KND2dydlQ3QoMoxM5dt1NB?=
 =?us-ascii?Q?uMht20vUTHiQLk3PV1O06YtFMRYh+eaLd1fd+E+zpxp0Y5JkjjHNciOEIwAZ?=
 =?us-ascii?Q?5W+6IfvKYZepw2OjhTdpDs3NbnM+U5mSzMCT4YElUSWHXjv3s9lI2lI6V8Em?=
 =?us-ascii?Q?y3pAMvQ6XaHKFuCNXKhXiPUvFNiL3mrHG6LwwTBAeqTq4+mANv1YOHZ9F/7C?=
 =?us-ascii?Q?PGRcLWdoe9zbTaUpdYZc9oSmAwH8OE3wvXZQ7EIvB4Vz+04XwJTAtJKUbXA1?=
 =?us-ascii?Q?d4Vj7nqspNTr+Xo3g29WnGMp2POv3+h1ONEWOu2/dkTuDGFD41fETZy+C2R1?=
 =?us-ascii?Q?R4nHkUOmua7kapp5S40+ityG9oo9RxRdDqy3oNbDz5P6pJxlCdz4P0RT8/pw?=
 =?us-ascii?Q?W/qsz/GVAVIjNO0jB8q00WfzSo2MYcObdxtuWZK4/T8YQFhsNW1CshjkKBAG?=
 =?us-ascii?Q?bBn0qqXzKZR1MXkwO27QLwB3kiYQfhug5FJTYQPbDOm9RrWSv7bK/NTM6PW4?=
 =?us-ascii?Q?tcMkljJ1z5va+nQmMMKeaRJb2VPUggspO0XSU5SE+4CUniwkJuu6mBJljfVk?=
 =?us-ascii?Q?VGgyaCM3tPcNwSE/F+qklEUUKifFwpvXHp8GUs4Pmd32Hk1ygBncBWcdAdyQ?=
 =?us-ascii?Q?AaOtkoF7vL50nmSzMMz3s4exmKSUUeE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b37cf2-10e4-4dab-fc7f-08ded7fedd77
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:57:57.2447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7AjlIfmRkuzU9GMkcV/wlSIowU0OCztr/f7zb2ZQPaFR4Tym/HRgdHBr7hXiNeUQcUdsdvf/1DqbL/m5mBy3/4VY9M+1dZD7NTyx1FrRMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10435
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

