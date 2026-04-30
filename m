Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DA8CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 07:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897F2845CE;
	Thu, 30 Apr 2026 09:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Y6H0g/4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7C780433; Thu, 30 Apr 2026 09:00:09 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32EE28460D
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX6nJ5+NjECNhjTEKkSuI8le5QZx7Rbsw6Xat+GvUp5nXZNKV0eTed8/eAlzZeVeiJd8qfJ49VNa5L0H8eV5WoKhCC6nSxOQP0SZ228kV5uMbmLXRwtPd2oyVvViAfT9vCbBM/cDYPWruYB6SYrmdNc5N2avNpjpk8C0hjac1+eGMrh76TpgYGPDX/y5q953yB2BQ6mBnsFyyS/WNV3a1xhLGC6Kg0k9dYg9fCXq0CpM/rxz7tqPLLcrAQV7d8GZSrBCWNBLcTpQoVR0vEiRkMPUE+Iw9p+GpPPCsukMNbTU6d595lvbgRHCwfOPvmN2bF2dyb6X1lQ0i4cv2/636g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVkAA7lM+o8HefohnJya+uoCy8dtjJbppIphLIkJQO0=;
 b=u1gw8Cj4AzhRysqH+RLxaC3Vme1UGCS/1SpOC9xr83AzejIeipC7ojeQKaq0rPHnvoVJx/ImyuireqRb2d9IYDBMj8q9U1Y9ZlQTMCMHIMEOTLVlW0xsZu1iwUoqJ3EvQRrrzv+Vd+rtsHJdKHLQ2GdGfPz5JSzqeE9bmCIGLMBCZXQ4OPKDP7KNDal3pR6ou5mZ58zeg1YnWAABxDMN73GPzVN64jezz2/UaVWfCm8mmK/PFdFBEqi7MlxsiN9JXF2IDHPUVlS5WCVOTT/5ztxcdU//SXrzxPj/Cf1TzucQw/Y7DAjDHrG+3s/F8NKlGGLjRXW0/i3o1I/RSyHPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVkAA7lM+o8HefohnJya+uoCy8dtjJbppIphLIkJQO0=;
 b=Y6H0g/4B+LQFGf+2sYDqQtzqWmcqM0YgtBXBpmIueAzOjsAi1gXxQDcQN0A643b0y7pBRfM36evS7xoZFJBScpFnSUsCvio/jBJfn1f3qriP09zhwyV4JdWRXUju/IFxwxzQH9BhmG3ViNmDC9Z6ZaQrFbR95Ic2x1k+43TZ8upxvAmuv0rOAGelgimdDlq4FhPYW7QjTHwJYSr7yZXetggfF/AO5SsaQlfjFwc1CAUu2U92sHmsE/FsJAq2sADVfZrI97J2iviANpgh+2eVOSQetJW6UMVVv4GZdvcHr6A2GLqjTQmzQ2J8ScnyuRGRmBJYGCsxFseR914WutiffA==
Received: from DU6P191CA0070.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::18)
 by GV2PR10MB6211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:00:01 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::ca) by DU6P191CA0070.outlook.office365.com
 (2603:10a6:10:53e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 07:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 07:00:01 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:03:13 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 08:59:59 +0200
Message-ID: <ac874a36-8798-47da-8f5b-912b49089e0e@foss.st.com>
Date: Thu, 30 Apr 2026 08:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: add STM32MP23 OSPI support
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Stefan Roese <sr@denx.de>, Christian Marangi <ansuelsmth@gmail.com>, "Ralph
 Siemsen" <ralph.siemsen@linaro.org>
References: <20260401-add_stm32mp23_ospi_support-v1-1-4c73550eae3e@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260401-add_stm32mp23_ospi_support-v1-1-4c73550eae3e@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|GV2PR10MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: d01f726e-e6be-4881-f402-08dea686192d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S0s2eqvV+oxS68eij5NwRVNnegtvfjaMJH7iPTb8GpINk4a9oFClR2L0QCx4A8b+Goc3z/7VpvjUi+sAzr3DlyhTrcyayrBrQgzMLgbmOp7kSgIbJ4hvjuvQbBfq/I+bj+BrURqcswW+hc+3mcAOWCriQUvCwY4BFTtbTYdIcszcYzyDCYmtmrZj14yoewQQZKdGhnV1Zyte2E23RlwmkhES/1bZ1dzDp1DlFfk7eErpBaVaMCNKD2e+Tpb94D5b4DiXIPXYXLCuScFU0dL3+CasN4rTh/5vhNeq4QJgwfaSnQ84UqbFNoMmjIz+s8j/pLlVw9ECoB01VpPWSvp2cX1G1xBNIu9MZ87XjWjNFp7nAXIPzjV7tICveSc4f2zRHZWdgPnGsihBFV9kbr8oDRa3QHRHEFBXCcCraDBMHyXG/8U2xVXXLbaxCBfm2jhwLrglDgZLFrm8h1vSbi+aNDXTBi26djrDmeYmMyvl96MuqZ0FVg60dyQhEkruCtwFd23lW/fF4ldtVtPrzyIpLXpMAIC/gX7E3hGYZQIOetMxEjUXtZsRbAZVX0y52WjcbphBgzbx/pUhzeRDmaxKcyfYJo1xqLBZ78b62szdftAeIElykvbuh62ksvcLdyEMh7yDqqaNjozig/ftlI0LxqUmpRfH3om4zE3+ybIReu7m6WdCSxlJcZ31J7+SEfY0/iR6qOg/qtptg4oZnPki+j3OYNrIR2yzwUbWcQHnY8mUg9yq6YYvY2+tCrtOp/igvK2vQwE6db1Dxi5r4Fe8xA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XkkjXY46xcv6M8yohr5rZ5hJyymfsdUCHQiPp4OSgYlP8FP+KsVXhUC7EUzWsTantxLPNCnDjxFpC+88/wFLRcXcIlKSHapSQpxyABMaeCrJgvLTa2wkROLTPeNrHScphZ9F8VtPUTuSuZ4lk/DJtwHcdPpw3MXAc8OBt+/AMqSEAL9C0sMLlH4Fc5d+tI1A0dq0+j+ZI8xqMIe+1FOmKmHtcaKNMzTsF+VGQnWThuqB6umADBEewrJEhJHiwyuPb43ZSTCat5CXTe2nFOgaJ48/3zItozJfwi/aysZeyEi+WUJvyFJAznicTq/KcIvhBgX0J9T/trmDZY6qDVAte9TAsXa8dO7fFbIo0d/gQXind8cf6qWHjm25pvxKn1QyKsRdXgJaASb067BPMWswpo5u11Rcm/4xTBAC1MI5Ddo0iECvnLmT2UgvhvHAYq5r
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:00:01.0214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d01f726e-e6be-4881-f402-08dea686192d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6211
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



On 4/1/26 11:36, Patrice Chotard wrote:
> Add STM32MP23 OSPI support.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 8c6c095a8cf..51909e3a8ff 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -550,7 +550,7 @@ config SPI_SUNXI
>  
>  config STM32_OSPI
>  	bool "STM32MP2 OSPI driver"
> -	depends on STM32MP25X && STM32_OMM
> +	depends on (STM32MP23X || STM32MP25X) && STM32_OMM
>  	help
>  	  Enable the STM32MP2 Octo-SPI (OSPI) driver. This driver can be
>  	  used to access the SPI NOR flash chips on platforms embedding
> 
> ---
> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
> change-id: 20260401-add_stm32mp23_ospi_support-1cd96f39a5f0
> 
> Best regards,
Applied to u-boot-stm32/master

Thanks
Patrice
