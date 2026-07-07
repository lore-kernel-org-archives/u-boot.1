Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A190CC43602
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA107846B4;
	Tue,  7 Jul 2026 10:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BLTk/1cL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A8384844; Tue,  7 Jul 2026 10:36:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D321801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 10:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raphael.gallais-pou@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR+G6Dfz/48fEaWOiMDfW0H9j2xqskRW1mYcmgdC2IM2rpG4uZUV361P2P+A64DTYxRJ6htKc9J/pxCxQNTvSc3u8JIpqp/LgRorilpCdH5SrcIrvZ4Y9NEo1oFqQWe67BxPExNjsJiEht61h4l5sYI2aPJHUwYUJUdKPA9iJH1PXah6DAmtHdaZlSkW1Np//JgkOOAPdogK1moCHB6T5C+i0F48tFVQhFC5468/zgMC32TGUVc5Y8kk7qN9a+QoB7K6uKR0VOD9BM8cHcMB0sgFTVyptaDOS9MH2TbSmIFbn9+PIPMg/08HKSEUe9dGqOqH9gG3OixT0p7ZE5ZedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR78Icpbml3KvgyjKGI5eIaDijmbUBZGbIL2wKVx6mk=;
 b=uucg9yn7Syzmsf/9p5qMcdfKMNwvARlRWnQap0pC1Ax9ujFGPWRhMm3Ch3Z3MkbLBVJsXhfd9F4NhdEeU6ZaPPWlJVOXPY28sdOHrhdzqYjXGidIDcL6pMtZ76ljm+KSfzPTiVXVjRUqTwEj0pgZP983nBBWqfttY19VoTN8zi8SxSLjiPxIPb3xABmT7hMfKji14jDM+oMiJl7FxbLmIVaYEz78prLxMVJVwB8pr9Ta2Hrphhv3lJsftoqiQjnMXyCj3cjvJa6aCjt1b9qvotpHt5yo1PqkJQV0uRKscKMJqG0oXg05ZusD7ViLqqFiePLc3VPkyxhV1RYbp5FXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR78Icpbml3KvgyjKGI5eIaDijmbUBZGbIL2wKVx6mk=;
 b=BLTk/1cLvdhsK2lqbf3ICQIfY2BexomMsSFK8T2cMlTkTP00+Ov/AkUVBqnSb+pKedwUIaKyWps7NSFOsfY8jVyyNm7kOSLtPaQpFbpzz9v+OEtap+H+uqvWHRBU/sCB0DOZG1zPtoEv42rPKiTXUlwDFHdpnkkHcnAFZHVGY8Z1lMwH7DjYvbJkhGGZMBOUvpE3RuZJN1C17+pbNH0NukVTWzEWqRDoWUL/3RHrALZV0Nvk4/FW1pTY/mI2q7Rd0zw9Kvb1jH5cpvo8zv+ZJ7+7h3Yd6dJXNp/AVc60hD6alrKhGB0UONRJyjXpC/diTY3piYU9sxgC2Wnpr8dEgQ==
Received: from DU7P250CA0028.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::33)
 by PA1PR10MB9051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 08:36:11 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::94) by DU7P250CA0028.outlook.office365.com
 (2603:10a6:10:54f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 08:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 08:36:11 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 10:40:30 +0200
Received: from [10.130.76.182] (10.130.76.182) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 10:36:09 +0200
Message-ID: <b7670b75-105a-4d03-8dd1-e7bcf7e31a00@foss.st.com>
Date: Tue, 7 Jul 2026 10:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dm: core: free fdt when fdt_create_empty_tree failure
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, <u-boot@lists.denx.de>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Rasmus Villemoes <ravi@prevas.dk>, Casey Connolly
 <casey.connolly@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
 <20260703-dm-core-v1-1-076d395bded4@nxp.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20260703-dm-core-v1-1-076d395bded4@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.130.76.182]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|PA1PR10MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 173f8eba-59ab-4fa9-9ff7-08dedc02cc8f
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vrv6WnJXsgfCpmixNrHZNXQb3i316frRwzW7G/yOSSIEXVlwG/k7V6XYzoxBKM5UBWwa5F3lSBQGAI619kTetewuDtB/6/f/bOTPDzXBA32PKtiJrLyY8A0sfqFomrgT0eDSlYkn0cBgXwdaN1HaaPg8PXIg/WdeTA3S/jtKUfYcqF9PARCvtNGBxYFZdL2AyL3rA1ezo9BnWG/ibFRMpAgE5IfqXkrCJbRrdP5IVT/hB6cYJ8gdUw56abJjO+m0Cno6KwVUNu9fs1FUmgtHXKu0s8IK8znqS06x8CzRmYrtSVKgyd+4SpjcaVcYOi0QG4ag0CdLKRx2JaBbd2lhiSlNImkDFPNK7Um57Kf4kNGZbEurl70yxOYUsHQw9vJ7X1HTecJCu3i7zlOPoqc1zW2V78btjTpgL2yPda0nTwCbNXMfzR0NDoD9S8kzZogQKTqJBmDH+EgPiHmL1LLUns4PhP0rrxwqk2fb9Pkio9glDY+DncezJpR6Io5IPIGygQAXlCKQVzyKMDCfVEUPWT3D0PloNsiOy5mDNgAFec+2/GpaF7ffsf7qxJnqzsfmRUQHpEkrbCieYPpP+7A8p+MXsiXLHxbLwFZk9lvjWffBaonGlpAOI/DAsHpCndF5tIMQC/9RltNszdLgkKwnD1u/By1W6ErqNwTWypw8eODB+g+Aak7uj+wznIquHqaWgifEdMuQthZDBoaoPUzpWQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 26V7FcRcJOLV7Wmk/E4sMEuOnGWop1x2GPALLI1oTuwrUmezgaDRC0tiE+kOjo6iRLB0I1Yf6A6I+b3qTkHC1cDIq9SdKl6F2xV481QAtCo4g0K64j/WlnrKfaD2oNE5LCViqmkwSbu+QZyHRA4k9iAuPkqwpXMacefmgRaEtPzhNR97upyo68CH7vZoIXSBYECWLEV0zq9I20mFw6TpSgLmVqxTJos0KX5wox7709QR3sF3zUhiq9T433x7M3OG5zyTjbP3C4uXQfPgs3VJMt+sS0mesWsjyjxaA1KrT3gLeN2pfKznEhUqxbWWX61s9bGOTtFJKLKW1kk2oS8ajTsp4MQWC7kgZmBzYzdTFW1+qGAk9GVdY8mbbmifP6OLAV6DGmBYYddtxH62hLJSTff//beYR2W75xoDFhhvohDAlvxHGHJYK4VgiKvSSkVR
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:36:11.1981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173f8eba-59ab-4fa9-9ff7-08dedc02cc8f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9051
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



On 7/3/26 11:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> If fdt_create_empty_tree fails, the malloc-ed fdt buffer is never freed.
> Add free before the error return.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Hi, 

Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Best regards,
Raphaël
