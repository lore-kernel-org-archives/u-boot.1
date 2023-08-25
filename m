Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63759C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5EE86961;
	Fri, 25 Aug 2023 09:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZUmXgByO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7746F869DF; Fri, 25 Aug 2023 09:23:28 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6513C8655E
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyQ5oLF/pq3Q+y/ex4i0I3d2Z4bIpYITdCSBTpBzQNPBBT5ytWGeC9uYAeud32vtwNnDosp9wk0ZfYGLQPO7zfH0ABTcafRwhpYBVnvc5EGZQ2xNC9a2pohvCY6DJPN8NIqsAxmcb1IyKhdpXuIfemwkwNcLmYpq/ViNYp+Gf4UfHTGJSLDpQdOHqH8pV4gFon2uarbs06H3SqLUippxoO3vnzhqLd+mNYoIxAMgGK+IZ66n8Us7YEFBmmIt3YxPYPZZ2DuUT63wPaB5qjGPlgzO5dUILj0QFN9VLdIEN8sG3hKWdHjf9+Puvh73ME8tiaGr+sTuxNBylbWb6aLJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FWZ+Q9sDFDew3MLdStEYspaFpnljqG3WN55cpnqQls=;
 b=H4BAZ/KetmK1hfg38Qrr3w7jL8poXN00OSg52+121qyJGcJy0BvDgI3xMRA6pGjsoi8RgkQ09Nz6EnO13y85D345r5cZlMX4M6BkTGYa8ukTuFkzB/4yU68qIgi3AQHbRi2yEOd75mFgxi+DjL67en50Q6bpEShGxrKlKRawSlUL8a5uWjJg3IkIsgBboL5AcwdU8vh8UoHGPD1Wn/P7/N6j+Ct0kMzS6zi0/67Pb4DHXrQ/Ydp04v8ZjzABsTj+2AAk0470Zke8zCkjtPaYcRNi9cz6vDfDIsSWIUAWkqx7FAJ6I92wtbcIYdYqw8oJHPgWGG/t8JknxViEEFaNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=samsung.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FWZ+Q9sDFDew3MLdStEYspaFpnljqG3WN55cpnqQls=;
 b=ZUmXgByOk+CoD1+XAvzT3bO5wOuRAJkcFGxPkQe549T/ZNVAIe197SJsla9FPGuJy/z61JZkzIq2jflM9JomYxVssxro92HH5jZryPnhSFLfZ038HHWk5iQqvJ/PV0CcJre4dUsGCfxQiGzLzwNKx93wVPDRoFcuBND5ERu02+c=
Received: from MW2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:907:1::18)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:23:21 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::9e) by MW2PR16CA0041.outlook.office365.com
 (2603:10b6:907:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 07:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 07:23:21 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:23:17 -0500
Message-ID: <c0e49c05-a5f8-2759-33b5-946bf2283b34@amd.com>
Date: Fri, 25 Aug 2023 09:22:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug build
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>, <u-boot@lists.denx.de>
References: <CGME20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec@epcas2p3.samsung.com>
 <20230816065437.836392-1-chanho61.park@samsung.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230816065437.836392-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb1b60c-ba0e-47da-b0d5-08dba53c2968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j18Qf0p2/Nms6w8k5Qsv8pYw0nSxMgcqNYhWxRiUSoH+yQqfZOQ0scuBC5qFEcD5W2fajYxU+LhVQg7wpmVAwHcZwj3g2KTaRHkkGF3yAjFF3Ymxztqbz3hGaabQh/63xTNVOcYeuSLSaAsK+aRUNxjBOQNJICt7sFXOFpABy/jzU8Q0x3yoPEIOlKr5tq0W78AJIPXbq9cQXefx8cgTxjepQeh3rzCMkCpBfyeFNeCpey/bmTTr7M0hbarmnIC21xDI3dvBM1CY/5bY28bB2H0IEx8aEedOPvvGm9JSvkc8VMbdSs4A/Y69LScQfsrLiPjC3SP8CmeKErGZWSUHGIEYCR/FBcFmcxHvNyuiAuiQvTv3z4sCdE91jjSnp6brvLDozOaVWbfH288QEVqrI2kqmQsARUDYr/30rL5XlrqSmfqmzafUs9J7aFvSNhZaz/SR3ICL0xiG4QgB1V24NAU6jQtPtSI8tQ5TeFLhJseXkuqqD6Fh6iHdtnhNeGSzcYsajJjLDD2OVch3n+xoN/nU8W5h7FBSzoGXP9cLWSFoS98dgfjJ52CvDYlRgwchwjAq7v/GncSjj/200sCrV7GSJTjGIsCB/xu+XvApKhm4Y6fEguVMDwBFMqRmhkmfPaXI4nzSo0MuBSiUW2rsEcxZ0if3WMlQw2npk/NYfOFLL9gNyi4Ugq7/N0oOk9J7KIoDCoVnETAlClk0WCXv6DCw+e2cmyJohzBabtkp+GYyulXMVnT0etlBKTmhJTqsKng57W0D3CO/bP+3NA0FFdSBZwbPpRi8bp9DdSOyZCU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(2616005)(5660300002)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(44832011)(36860700001)(26005)(16526019)(82740400003)(40480700001)(356005)(6666004)(81166007)(16576012)(70586007)(70206006)(316002)(110136005)(478600001)(966005)(31686004)(53546011)(41300700001)(2906002)(86362001)(31696002)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:23:21.2998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb1b60c-ba0e-47da-b0d5-08dba53c2968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
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

Hi,

On 8/16/23 08:54, Chanho Park wrote:
> This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled and
> CONFIG_SPL_FPGA is not enabled.
> 
> ../common/spl/spl_fit.c:591: undefined reference to `fpga_load'
> collect2: error: ld returned 1 exit status
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>   include/fpga.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/fpga.h b/include/fpga.h
> index ed688cc0fa3b..44f2755a3f10 100644
> --- a/include/fpga.h
> +++ b/include/fpga.h
> @@ -60,8 +60,16 @@ int fpga_add(fpga_type devtype, void *desc);
>   int fpga_count(void);
>   const fpga_desc *const fpga_get_desc(int devnum);
>   int fpga_is_partial_data(int devnum, size_t img_len);
> +#if CONFIG_IS_ENABLED(FPGA)
>   int fpga_load(int devnum, const void *buf, size_t bsize,
>   	      bitstream_type bstype, int flags);
> +#else
> +static inline int fpga_load(int devnum, const void *buf, size_t bsize,
> +	      bitstream_type bstype, int flags)
> +{
> +	return FPGA_FAIL;
> +}
> +#endif
>   int fpga_fsload(int devnum, const void *buf, size_t size,
>   		fpga_fs_info *fpga_fsinfo);
>   int fpga_loads(int devnum, const void *buf, size_t size,

There is another patch targeting the same code.
Please take a look at
https://lore.kernel.org/r/20230808102227.34233-1-eugen.hristev@collabora.com

and work together to come up with the patch which covers both cases.

Thanks,
Michal
