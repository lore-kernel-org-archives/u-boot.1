Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C63CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B9B8680E;
	Fri,  1 Sep 2023 09:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bFWbh7U1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E45786813; Fri,  1 Sep 2023 09:05:34 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 753B781970
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlWtsEA91Hz+jjMKHJ3S0p1lDFjEVBa4YT0KTV2ZYRacMnKZjl0zgNttkMtyIC+zzsVky2AQ8BU6c/WVg3QQD2W4RCoJUluCHB5sOlUyq+muxIjtStjDPWxd86If3NFVZZbFYeSxA+TuFhqHthbz840dGq2OCJBSLPJxotQ4UNOuh+YJ/km302sw6TY11TdCpBlzYL2kdWlYkF+LtGUr2s3p2uB/ku83vsmaLrxMfIBfAZL70CRC1XDJg8J3VNzsknpgTw8ockBJFcb3A43gC8sUg1xOZpfakyOXfO6G93ZSUxwwbgqNxkfjrAw7WuNexfFZ1NCDZl7QSeyTw/tUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RKZyxkckIQ2QwDbe/z7xaGvuIn97koZE7DSzy9BDWE=;
 b=nJPn4lvvlbfEWsRlq8buumSQA8y8ghbYldM/YbykqWeP3qNUn+YRU092Xlz/alg+gMBHvpl/psdaR5h32aSeAdp4J7ikAfiYfguy5oLuBT0yYpEekZ7ckWavW2F7TiHo53FB1ggES4rUoHXL2vOUhFKJB51ZqkhXOJDA99nubK9RnM71PPt6hgoxIa7nzizzKbH813juCK6apfc5vaaV7yAbl0mz8leaj+jMzGQ3b03SkqJu+1MU0z2I+BiXnOiwiC4F7DG6nQFAy+vHYt+ktrUJhD7THKvlsy9P3UerZ0SvyoQG8OhXX6NVpa+Z2cBu67U60xuVV0NhaygrRBetwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RKZyxkckIQ2QwDbe/z7xaGvuIn97koZE7DSzy9BDWE=;
 b=bFWbh7U1wsd8nusZCCwNAQhA6tC68140tL3qbYDFLuPukZRTtwa+ec9A3kk83It8PQgVyOXRRVvVXI0tdGmMTex9eP6SQVmFpqRlZoqVZZUGUvFCXYQA+zbHoMsBbm7wQJWTxVHVPgyUFhj5KRaGg+DdtnEMy2RLHQh/F6rIxnQ=
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 07:05:27 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::4a) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.25 via Frontend
 Transport; Fri, 1 Sep 2023 07:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Fri, 1 Sep 2023 07:05:26 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 02:05:25 -0500
Message-ID: <8b1e30d6-b54b-7c18-f15c-630b41af71ac@amd.com>
Date: Fri, 1 Sep 2023 09:05:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 1/1] drivers/mtd/spi/spi-nor-ids.c: add mx25u25635f
 support
Content-Language: en-US
To: Neal Frager <neal.frager@amd.com>, <u-boot@lists.denx.de>
CC: <ashok.reddy.soma@amd.com>
References: <20230821124502.3308208-1-neal.frager@amd.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230821124502.3308208-1-neal.frager@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: b0364796-4f2e-494d-cbce-08dbaab9d19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/zVou/iOCy+f/o00gc+D/d6Gz+8CfjCISUqDgMKlGEC+3GbHM2c6vGhEqNYcyMYCXOgZv8bZdc9F2namEZIbLHDH8Pp0EB/jQz1DDAM4fTlJuL6tDXeLuVTIZTUJsEGJFGP6y5x0uNACXPYUvx6sVxBvQpPOkUqNf6UMBSzuSf92z9c36c2J1ivvhPaS6b27u5+dwrR2oc5xq8l0NnFjOKncVPlCGzXmtk/wTKd+6+uCvZlD7Sl1cy8VoIddYrxrDn6V1ONRtpZ3A5THsdsnz8SkZbEAGNVj4oBHot8v03FWZSqcPV0AzBbcu8koVIntZwDfGGOpEyWuz7c0+0OvJGkMXej9FluFkELU/iIYoPYPjAcdX3kTc7zBS3HcHyySjNSERovCsPpXxedqTv43tOLLkkoQwW++MIfIBc9sjEquvh4lxW+JKEWlVDDzFbaEQssmilaGsGjDUC5mYtb7/HaDv9s7e/EYdD3zA/u+PZD7afwAo9WBYvf4ABJQULBTKQICENgD1/ori1/MDfqBmg15kysAZ/TSc67EqhnIWRBIw326qGouKtGLAFbQRSMt+QwjKqnHt7MKv4FkTtVmtwukCSoOCAG7h1Ku+3tCaL9iD84dJQjGTwMhlznY6SScDa6JnHjsbNFymswBYMGckJQhS2OPJ/WsSM5mrCy1zPtMU2JjQJ6jIq34sjSHppj8EC9zqQ6vWZ2gcfdVbJu4qSr3LsEdLhJHgR5fo7fRlXF+JmzPxRaYCnaEza1lUK/89kFjnP5OhJ+1ylXvaYYMTbdWJ//tplI73MWRW7HNlO/I3wW6tSkQ8QPbXTIS1N/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(4744005)(2906002)(5660300002)(86362001)(53546011)(316002)(16576012)(478600001)(2616005)(4326008)(47076005)(36860700001)(8676002)(31686004)(31696002)(44832011)(8936002)(26005)(40460700003)(82740400003)(40480700001)(41300700001)(336012)(426003)(36756003)(356005)(81166007)(70206006)(70586007)(110136005)(16526019)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 07:05:26.4414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0364796-4f2e-494d-cbce-08dbaab9d19d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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



On 8/21/23 14:45, Neal Frager wrote:
> This patch adds support for the MX25U25635F QSPI Flash Memory.
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index d0b49c4cf6..7534af684e 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -249,6 +249,7 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("mx25u6435f",  0xc22537, 0, 64 * 1024, 128, SECT_4K) },
>   	{ INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, SECT_4K) },
>   	{ INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K) },
> +	{ INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K) },
>   	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
>   	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },

Applied.
M
