Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379ADCD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 10:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47CD847B0;
	Mon, 11 May 2026 12:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dPEodNMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9EF28486D; Mon, 11 May 2026 12:52:32 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D647A846AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJZcuEGOueyG+v/XR6ShVAy2s5Br676y3GpgOwIr80V6TSREPPxcdtrpGIgjUEfJy/l73QPq+2iCke5sdyDOeF+OmWrhdTaKSilBFKjZ8PRcmUAGPs2ctv7tC6Oz7XgYtL+kXJKlhvf29sKcR9ckT84tOhFIFidROkblADjNM2OOgBQuteoPSC0knLr2LGTocD+nrwo+pj3pH28hphPHmkRoESdwPv/GtG19jEnRlT4R5P8kMpii/qP/CxAb/HbdRXS7hPWRYDMB0E9BvfT4V363a7MjgzUjJxgSBw8PJU6eNOuysPaZPRCteA4febMEjLj0KaVJ+k0dH/cpskpo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5RDgjFoN/WQ3OQlm5cupJe5uWG8doa4XC4SbKfoBTg=;
 b=QFxRPdhAafIXnDjFs7z5BIs19AtFEYAK0Ss6Ec+O9SGEuktbrpYV718IWHhyFEd9rWm5dZWtyot4iT68+uEGNYTQEhnnHs+GYEFxYCrafnY6yF+Qgevf2/XfuXw4nUcQjBNS3DTja8ddY6nx32HJpgO1GsEuzNE0Ks+g+mF0a39jVzUywPiUpkpu0hM6FmnPcipeu07Xu3JLBYIgjBznlKW1QTWhs/LbB/7tIQFelYF6Bkdqlkj8gZg496nidoM8aSSKn9GjcXAw7BYJh5MQpG6EkSwtbT1CncdvMbElM3JynDuenkctoY2jLRk8rFGH/UfF1yt6lP2jxfROFtWBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5RDgjFoN/WQ3OQlm5cupJe5uWG8doa4XC4SbKfoBTg=;
 b=dPEodNMUeMteKuUnWr7nFo7Wuh53mCmy2YcYOm8SNbyE7gjkUxnQSpr2QLQ/WW+O+tusqZHyonDqprhZs8srfw5+37WbDyhVzwoR0tRfi65VzUXrBgLxHn6h2Q5Wl91YxjpdHn8e6HRym47X1G4tcOoAvR2cGTn+NM0k6ci2ERc=
Received: from BN9PR03CA0329.namprd03.prod.outlook.com (2603:10b6:408:112::34)
 by BLAPR10MB4995.namprd10.prod.outlook.com (2603:10b6:208:333::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:52:27 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::27) by BN9PR03CA0329.outlook.office365.com
 (2603:10b6:408:112::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:52:25 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:52:24 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:52:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 05:52:21 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BAqGLO3213008;
 Mon, 11 May 2026 05:52:17 -0500
Message-ID: <7d8e528e-0b17-4e30-987f-059476da263d@ti.com>
Date: Mon, 11 May 2026 16:22:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] mach-k3: r5: common: add helper functions needed in
 LPM resume sequence
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Abhash Kumar
 <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-12-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260430084414.1354490-12-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|BLAPR10MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: bfefcf88-ee03-4733-befd-08deaf4b634a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Q15C7wUN+Dw0KZ0FE9Ck/XjVsteabhPeq7Xt9vn4o6X47T9AaO3O0eG0S399c4exB/vcZ8Ob1QK7+A+6+EW13CiInHSCzUoOaO4MHtPFZZdDNP1nBbdgwGxFyGGsqPqG43jD+tN74fA2jLXQDBXuW72903KQ8070hZ8cltYVxvyVpIuyMKOTwr9jIO2sxnjAtKBkGJMKkURxsdoxYqZOkHRxyrzDePFWxFur8FvyjvT74mtyXTlB5Z0K27RDCLFoirQar9jC7ezN+eQ6LwIwtoyTonoGzUux+f9Bux6LiECh2J2WNac2TsReNOjq1Y6Yc8dbuhF74A8rqr4eyZNuKjAeBUpEVgjV5nTohUuoxFEiCwOl1kqT8efNO++jMO1gVId0oyksVze3HEXtNek8w5iKnqqeMGMDjBFFFeJK3HKxYHffPzqAHXp2EMU0y0lHuD2jLQjkQ74tR/YVG8iO11ndarSCfUgrIrR7FtbwoFtZh2S0WcYjPw9jAOfysPNqsUPZ69jN00cjEe+ZM8+l/wmhxScAR/kB4ayiouOqY5rl0NwrQPAGdcxDtfISqMtkvJMbVEWjlTe64ABbMS1a156T6HCe/zsQgsuO0fYcTr5w8ObUDoChjEpkU6fK0Z8Cy5WUNabrZnjwjbv6DC+KQj46e4iNo3jsWDqE4IEtviIl8RVGp4i5t7a5WCLtseN2X4vEB+NsDCJ6dZifEBaAmz0RCYjS8k27L56Rn9h5/Ur6dNXSAhejvY+rCWMxZlck/vgbKmo+4OonGfkJqu+dFA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 44ngRPCtKOM3jm8zY5Lb+MnozlCrNS2F+GBqFHOdsh59Wl0ms5aLPEbwjzw9O8e02K+r4+iFOGUm8twic9jIO4Kfz+GSwLBLO2MaU/KRKlpvwFd9f3jAWu8IRWtU8oNrpesgnv8RJIJaxFGgq3hSKe5UpPMeq6Vzni9tR1PO6ivlTcRGf0Yo6mhSWirW1bEHSSV1PQcKwecWWrdPgjOrQRHRu+4X5YaXozsYrLlc5iFiIJRyQw62HOY2VFeY5DIDB+gvNBQn/K4T0i6ewl8a42Kp3yUjx0RH1pQbfDqZt7KPDLBigYuEe1dNtcRK5U1qCrcsBym+F3SNUVan4xBsETOktueNfmyMGZpRx6fe/OUbhBtpXJhdfZWccmId881/pKhEyY9OeK36HCAZvPXX2UlMgS3nfAlQo1OtCmWwa3nxlgZVD7g5koNNvrEJksmK
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:52:25.5314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfefcf88-ee03-4733-befd-08deaf4b634a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4995
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



On 4/30/2026 2:14 PM, Richard Genoud (TI) wrote:
> +	
[..]if (ret)
> +		return;
> +	save_addr = (unsigned long)mem_addr_lpm.context_save_addr;
> +	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci, save_addr,
> +						mem_addr_lpm.size);
> +	if (ret)
> +		pr_err("TIFS lpm save addr fail\n");

please check firmware capability instead of sending it w/o any check

[..]
