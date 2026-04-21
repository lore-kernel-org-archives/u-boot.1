Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F274F8FA6D
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 479BE84326;
	Tue, 21 Apr 2026 14:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Phe76/1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A408431C; Tue, 21 Apr 2026 14:27:10 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACADC84326
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFUpg0bEL4sJvBEF3o7Vq7QooQaaCxS3RLGWN0/UyYm3tgARDlnR3dED7O+gXyAdJUleIa2byd48X0jRvpbbA7q7UkKf6JaQfHBJFmEdoRRqNPKKiHRwr2BaurWqoDzQ6xJJOJukX9EEQArr2P67920liN8SYpZ8qk+aGo3UYzsmvWGuC2/WJ/2vXQLHAnGDooaXnuB9BKmnjuwfUZfSPQ96Oc/at1cbnMoOCYGPR6cgtbH3UpmU4g5sFuRvy9Jlh7ZVeXArGF10+E+tjb2euVVqQ9YYVO1gbIg/IS6H9uDFAbv4GMAiIHPyF5iWygI4iyF4UPg7DcxG7jwmY+XXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7I01FNbzYvo5+uGpUXEn1Q3XGBpwMVPC7NWldChO/0=;
 b=WJkc5mgXMdtA6Dyc7yd6GOGefwQWsYqhPIzzW6PMDbcVvouRPqExB7At7GFZSQaGiRQdUEGd/DxzyO6ImQ5SeWGige9PEh7se1d8mleO6pw+ZOa771sZ26nyjUc41VQMr4BfefWZ6gjJXmIVOrh67OPIKuJL97E6Dyd7D7rWfCrtfSNj6IiiZ4wTnkVX6+YGA69ggPdAJBR9FYZWw09K3/D0Y7mICA4MjwsC8mQyzRVCWYoSaw3siRSoTUe8vV679uKACbmyB8Y1ii1oVgWWEH38fuhJLpkG26U21x+VabTVtjkfAhR3GRus9tmrLjia720rda8RpGJeSKIeHYU24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7I01FNbzYvo5+uGpUXEn1Q3XGBpwMVPC7NWldChO/0=;
 b=Phe76/1K6TMXXhYl7GY+07gVwWqZZLdjPjDLPxNIRAEbVXDECcZzXlTIU7SXizr3SqaN68WKoUKMKZeS+wCi6n0uXhJNeDp49FAL6AgHEkShHoR1I82hduUpGzx1llOZxYoY6Vfohj0GgZTzEs6hPqQzmb9COh/09ZYrJF+svhk=
Received: from DS7P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::18) by
 IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 12:27:04 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::50) by DS7P220CA0026.outlook.office365.com
 (2603:10b6:8:223::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 12:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 12:27:03 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 07:27:02 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 07:27:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 07:27:01 -0500
Received: from [10.250.202.124] ([10.250.202.124])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63LCQuHR465474;
 Tue, 21 Apr 2026 07:26:57 -0500
Message-ID: <dc7a05dc-cb5f-4d06-9ec1-967f097984e4@ti.com>
Date: Tue, 21 Apr 2026 17:56:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: regulator: tps65941: Enable FPWM bits
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <peng.fan@nxp.com>
CC: <j-keerthy@ti.com>, <t-fujiwara1@ti.com>, <u-boot@lists.denx.de>,
 <gehariprasath@ti.com>
References: <20260421082145.824453-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260421082145.824453-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR10MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a46fef8-068c-4f64-590a-08de9fa14b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: LWgSdLoE31utMXtbgsZ94vOhA4t0zBA7Sw2eEOGLs7ZB3EDPvdyOV/OlYOBOjCWqiodSh9x0ZvzFVoIzhDbsS28Xsg7ygvkUYXVsRAfQp1Ei1K+2STnNO4mZo0f5IteTGF53ews7aqf4bQlrK8qcKwuRfBqSCkV1r1ra/po3bN6/gv7Fxj64stkHaC0WDMdHQVJbVBMzJIACPAZvrff/nAxF7e6H2ME1UDOYGc3TYahReBeA+YoapYvmOlbd5rDx87lQ5K3Psn3rjxGLNH0QHwGimb1j00R/XV708AbgGN/ld0L9j7eF6d6VFFd3EFcNp+SrJoMYVietBPkHVFrXjl5FisUHNAwYYk6EhbMsoIBv0mUAWj4++v02UIfbK0iyGk2+oEifwzBAi0j4mz1QJRa862afrmLBeVqs0R1wn0UdTwrA9JZ7dV2uGz8kWPEq2fZj30FDdXS4LJtd5SlqZQ9kXwxM85bHk75Kr4XnbZoDHz4CrCG87JUolAwphVwC7RJEJW5sPsgAtVRjaxVFSmT1BNGWktGwz48WSuhDN6g1E7/fBjeec54JD/FFutjxSQ2K58xfZtgwqps3b1m0Iw67fn0gKbEgZBF9jJHRyYbkIb4pYsTTbiQQd0mTeWEYF1DH/T5JfxPvA/9Eeg815cqkXmFwLIiak2hDSMdeXBaqYPJbQ93UXp5+Uyb2HjHyTFmLm0Z4AU0nVoNO9GFpuSI75ljFykFYHdV3Hg/NsVQq16/ZTlN4tOfmtYxmUqxiI1+/o+fUvr+pVySbSAOaFA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7V90vJoknx5nY9+RYg3rtE9yt5g76RdZBKgrTPsDmTC2+0YTWi8bcDiidX1ZX2AAFiCLp6PE5w2OAXWEQxo6IrP7haM3Lhvhd+yf/tK6+EFPhPwCvGd1pZIh7yxo8yj+vpmyPEAl0LDDyxX8xMgOtUBXKQcg7QOoQVHirhePL8SfDIThUcCqREwUF5iVn8XV0qGWLokq3RVFA5BnEBf2BjDznPmWaXydpTGutjFnL7lCFNq2fx0p17IrhKUZhxl08iyT3/g8a0RGPHVPemmcsO3IZwRMGPEpn14ZwDG9NarK9CsGySa/cuJGQTob+xapMZO2VET6ktcz7Kc+Wquc93Yu3uOLRN/FVTylJEeOshc2mJvf4b7MFkRfPsalp+GmtYzUdUi33KIgaVH6JdkZfpWFoLbq4tHIJ/JEZuUg8Gln5typKJVcxvm8rw0n/Z9E
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:27:03.2692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a46fef8-068c-4f64-590a-08de9fa14b36
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
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

Thanks for v2

On 4/21/2026 1:51 PM, Neha Malcom Francis wrote:
> Depending on the phase selection (single or multi), the FPWM bits
> configured forces the regulator to operate in PWM mode. In case of
> multi-phase selection, the FPWM_MP bits enforce the regulator to also
> operate in multi-phase. This fixes correct multi-phase operation.
> 
> While at this, correct incorrect macro alignment as well.
> 
> Fixes: 065a452ae6a1 ("power: regulator: tps65941: add regulator support")
> Link: https://www.ti.com/lit/ds/symlink/tps6594-q1.pdf
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> [..] 
> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> index 2561d6f4c6c..209968b5718 100644
> --- a/drivers/power/regulator/tps65941_regulator.c
> +++ b/drivers/power/regulator/tps65941_regulator.c
> @@ -63,13 +63,14 @@ static inline int tps65941_get_chip_id(struct udevice *dev)
>  
>  static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
>  {
> -	int ret;
> +	int ret, idx;
>  	unsigned int adr;
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  
>  	uc_pdata = dev_get_uclass_plat(dev);
>  	adr = uc_pdata->ctrl_reg;
>  
> +	idx = dev->driver_data;
>  	ret = pmic_reg_read(dev->parent, adr);

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>  	if (ret < 0)
>  		return ret;
> @@ -84,10 +85,18 @@ static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
>  
>  		return 0;
>  	} else if (op == PMIC_OP_SET) {
[..]
