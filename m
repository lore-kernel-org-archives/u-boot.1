Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23E1C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 10:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F03E786420;
	Mon, 28 Aug 2023 12:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1+v1OWcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E4B686421; Mon, 28 Aug 2023 12:53:26 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B7C805C8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG0fDGeTpLp5g7UwbkvxTUeaIWWH8hyE7hqO240PXz7VfxOam0GLgi1laEK43omVIgaSqslYejnlKbPkFlqCe+nz8n/2CWcHBRxmtjWpnMMIzx4cGo6cldU9KzfsuscENq3DBG0alr6dTaoArSRl/1fftMq7CNpspWHauGVoxZv3/1s5DB9SDvOj7PO225y8K5TQ+WpGWiC5i3763RS0bem8Il1MgXcc6afO+Xri/+8KKs6eMkFmNGM6PwwS7kCjads80/sfecAXfOy488bvTSWSAGzSFfgQr1DR5LofVywT06+h5v3a0Hgnn3/nTdr45+TtTqMnxLAIsNFhpar6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaRgF9RPwU+Y94NVRfs8OJ2CmAN0hZsfoZ4YE9Ben4s=;
 b=RyimicYpGfMYtuaFFupMWVztaWHEOhFxZrJbW+3gW4b1LJQfYu6VIjd0tqG4YF+i746maxMNIpaDIF8palWwwJC8MZbxizWiIL60+rq16J0ExfxTxCAUstCN8r1s4mdjhtAD5MoHJql2mGka4oUxhuresXZ/+qIwksRn1heXRCFNYGTYKDfKVzcv24/OXh9SHwBMFXQAPkwDkHYGH9xVi8cky5VlDGv/ZIUdonOhhTS12CzCYfQthjNWGGC8JEm267IByXRYcTeCi4BYLD1dqMtW8k8EKH1/iDgxhtI4ocdHfT36V+pr49np6/GvMFRcb6c2WqoiZLRPoD6AE8nfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaRgF9RPwU+Y94NVRfs8OJ2CmAN0hZsfoZ4YE9Ben4s=;
 b=1+v1OWcBorStAqWBu4s2GlxmMFUSYBaQG5Z9+PF5z369nU0RLhR1CJIbSYgNpJSfEf+yq07xp5AQyl4mp0yD4CmIvNI26IumSb+CuvOTQJ+HwgMqjiOygkZjU1mEBOY1T4wnYQvSf0Poz8OrlFMV7u2nSvQSHiOWjkEOtkvL2NQ=
Received: from SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::14)
 by BY5PR12MB4854.namprd12.prod.outlook.com (2603:10b6:a03:1d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 10:53:19 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::10) by SA1P222CA0046.outlook.office365.com
 (2603:10b6:806:2d0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 10:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 10:53:18 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 05:53:16 -0500
Message-ID: <f7c04c73-c2f9-5ce4-5953-270e907d89f8@amd.com>
Date: Mon, 28 Aug 2023 12:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>
References: <20230808102227.34233-1-eugen.hristev@collabora.com>
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v3] fpga: add inline stub for fpga_load
In-Reply-To: <20230808102227.34233-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|BY5PR12MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a8a460-ab7d-4a89-f87c-08dba7b4fcff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSxHPJStyOKz+GJtjxXA5OQr501hottHcElAS23JlXN3OCHRvu7z4/jwxkPbp2894+751vn89ikzP+gF4WmAFVhvQJ/KOs4aKesU7jkNSmzdbP40hp3YouFkXXmx+Bf4WsSXoBa+TuhQnMhopHAryUnrbVgDgxD91wgB/OT2jKiIz/5u852v+MnxqWOzzYYIFlOruPNtEPbWH1Y2dtsoWGrZtz+tEjsId4mFDTX+xdascdlB1J3O00FY+iMnlnURPsnU35B+nbhLSeXk6TGILHVF4AsSHfcOUlnLcRx2/sgi7sJ6j4zARGopIBlz6x+tPihD/t/lBHLw2IYi1JBdZNVFc5OTw/mLP2u9C9zK+556o4nOASJJAUDj7HhB5m8rkDRZNSDDuiP9DSqnA7hkhDpZAtKvBHi5pT0krOeXaJL18ZgDUeYMrTe6L4OUQ/TLhcGp1z0SNlmWHc/E7y1pAhH7RJ7MbswGRg+tPAylk3led1WMmWsxnmXXS96yAz5xbxwPB1rFwDsr5GcvkcW4nYOMpAdhRr815Xqn1H+P5j3gFYU2N2jjj3zEjOSiHEjPxhR1tjB70944cSZcqr+VCew9y5+6dR5B7vXjlyJXTiGyNhQ7au8uzKV0C0o3aoCR0Ra+SJywFJrGDb9aMUVA2Q1AzqX2m3aKGY3Fc/B36+ax2Tav5ODqXTHysx/9EquKkMLIFTPiDhVwl80bz8l2kQNsVm5ZjYJkQex05RK5vjXUGZ8DKbU+BiMDChEABbJI5e88uWPUu5/80SYCvw39OZeYkGCUhO1+bX5Lj1lr86E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(41300700001)(356005)(82740400003)(81166007)(86362001)(31696002)(83380400001)(478600001)(966005)(47076005)(2616005)(16526019)(426003)(26005)(336012)(53546011)(40480700001)(70206006)(70586007)(36756003)(110136005)(16576012)(2906002)(316002)(5660300002)(8676002)(8936002)(31686004)(44832011)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 10:53:18.3017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a8a460-ab7d-4a89-f87c-08dba7b4fcff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4854
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

Hi Eugen, + Chanho,

On 8/8/23 12:22, Eugen Hristev wrote:
> In case CC_OPTIMIZE_FOR_DEBUG is set, unused code will not be optimized out,
> hence the reference to fpga_load will be compiled.
> if DM_FPGA and SPL_FPGA are not set, the build will fail with :

this is not correct. It is not DM_FPGA but only FPGA.


> 
> aarch64-none-linux-gnu-ld.bfd: common/spl/spl_fit.o: in function `spl_fit_upload_fpga':
> u-boot/common/spl/spl_fit.c:595: undefined reference to `fpga_load'
> 
> To solve this, added an inline empty stub in the header if
> CC_OPTIMIZE_FOR_DEBUG is set such that the build will succeed.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> Changes in v3:
> - return -ENOSYS
> Changes in v2:
> - this is a rework as suggested by Simon of this previous patch :
> https://patchwork.ozlabs.org/project/uboot/patch/20230619102839.277902-1-eugen.hristev@collabora.com/
> 
>   include/fpga.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/fpga.h b/include/fpga.h
> index ed688cc0fa3b..33d0dbbe2ba4 100644
> --- a/include/fpga.h
> +++ b/include/fpga.h
> @@ -60,8 +60,17 @@ int fpga_add(fpga_type devtype, void *desc);
>   int fpga_count(void);
>   const fpga_desc *const fpga_get_desc(int devnum);
>   int fpga_is_partial_data(int devnum, size_t img_len);
> +#if defined(CONFIG_CC_OPTIMIZE_FOR_DEBUG)

And when you enable CONFIG_CC_OPTIMIZE_FOR_DEBUG and FPGA you get compilation 
warnings.

drivers/fpga/fpga.c:265:5: error: redefinition of 'fpga_load'
   265 | int fpga_load(int devnum, const void *buf, size_t bsize, bitstream_type 
bstype,
       |     ^~~~~~~~~
In file included from include/xilinx.h:7,
                  from drivers/fpga/fpga.c:11:
include/fpga.h:64:19: note: previous definition of 'fpga_load' with type 
'int(int,  const void *, size_t,  bitstream_type,  int)' {aka 'int(int,  const 
void *, long unsigned int,  bitstream_type,  int)'}
    64 | static inline int fpga_load(int devnum, const void *buf, size_t bsize,
       |                   ^~~~~~~~~
make[2]: *** [scripts/Makefile.build:257: drivers/fpga/fpga.o] Error 1

I means please tune that condition properly not to create additional compilation 
warnings for other combinations.

Thanks,
Michal


> +static inline int fpga_load(int devnum, const void *buf, size_t bsize,
> +			    bitstream_type bstype, int flags)
> +{
> +	return -ENOSYS;
> +}
> +#else
>   int fpga_load(int devnum, const void *buf, size_t bsize,
>   	      bitstream_type bstype, int flags);
> +#endif
> +
>   int fpga_fsload(int devnum, const void *buf, size_t size,
>   		fpga_fs_info *fpga_fsinfo);
>   int fpga_loads(int devnum, const void *buf, size_t size,
