Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17670C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 852D186961;
	Fri, 25 Aug 2023 09:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXd7MrF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3627869DF; Fri, 25 Aug 2023 09:22:15 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92FF58655E
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOqiPnuQITDCVlm79U3TVU3YQXSQcZE3omdzbjrKGxJgRniCGszt0+WEq+8A6HiZehRga06hjNiejNsA+MmJVHokosZSSagK0b8eLBTeQexgdsdt6mdg3JB0922LgwXLzcZzEDfqcapS5WKYYK9+skR4ZlKiuXQhL5IspZbl07lDoajGdoskALPgCG4DRua4tYPVcnwXhAn4SG0vCrTVa45IddX/3rlVRgKgZtF7FqiDBLao4UUaOz8Q/1Rd51C7H0KkgtWfY2zItqHvVj5fYLEmO9XXABppFmQbqDhsP7YCplImz4dyb6Jwpzh3T8pEdSaiSftLrOJBknrmEqucZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCYviDj6jjjOBfjPf7DHCmW5W2PxkP0Y1xHrwJcGD8U=;
 b=HXzsiN6QCPTRLGzvlbw6R9QC9I5UarFMGl7gabd13CYP005r26vRQGWg4qA1BLTdtIbvYq55IwaueT3PJUhen6v9Jw1y7qisTYPia2cGtSl0Tyo/83mtxyqlCQyC1bAlOJNwsM6sVaw4pRLTMz+dJwbUvMvSMMvOrMVf3oipwXOComYjiPQ6myPSwskbq2II8XrX1o7XWdRUbz8gJ1b2aRrfcZHIG9j99Pwnmpb2i/S4ERsCcs96noeWiZmFohWD9bCKBEBsFgLGXpqEBBryWutjcuWlE65AmWHPOjFmoI4B1veaZFTu3OOW3KUsZztsPQSdURtE6nRFjmJrVLwFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCYviDj6jjjOBfjPf7DHCmW5W2PxkP0Y1xHrwJcGD8U=;
 b=eXd7MrF3TvRTU9w9xrAy24F79pRX9IjXegDwEUrn/lE3PPK3v74dx12qQ0282Xk5TsPwhQS0i1Id10Iy7VlmyWIHl/mjw/pzX8Eo9MEB8q8+ec4e5TUW3VulcmqoK14VwEI2Aij2nrmRa+iofjrA+OqhDHaHjxqrcfQJbaKbeBQ=
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 07:22:07 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::94) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Fri, 25 Aug 2023 07:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 07:22:06 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:21:47 -0500
Message-ID: <027aa995-b8ed-225c-0fa2-7299574cdc33@amd.com>
Date: Fri, 25 Aug 2023 09:21:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND v3] fpga: add inline stub for fpga_load
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>
References: <20230808102227.34233-1-eugen.hristev@collabora.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230808102227.34233-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: eb40685d-8d95-4659-c164-08dba53bfcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4R3okEzyrH0HHqAjQdTI/yawhu8qvjq0aLOz9B7FtQXBAVLl0VM5uE0g73+dWpsxioXM6xQgrJnUVrn1gT3fXk0EYRENNEA6TvQbCClpF/OZ6ErLkqJyVYWNp/8o/7Z9jHLF0fTmnufv7hDnk649efKfZjROn5QaoAih3FclJZWvmHMyaLoNca5EJrIKyTacGl9O8by6BM8oA4cHtvnw5TBx7iDHyw5TfRNgdNpgKK5Yzz+P3CvKQ2EZEbIULtnabZr/OmFN8T2DlMaorQw/Uvu3KcidxccZ+pHj/ijw3qWLC7z6XGYJXUGU9Kf3m9764kPCy1ZoaZazY4nDcA0EF8g72yqxrtAyBnMKT0djv4XWfCxPyF4QiQbPC0c9BCRjps6mpKcQFxju0su5HGRKZzY695UKo/HAKdZga68fL3I6YudovwedRpyWu16F427OTRnzcet+60aTTNePMP0SB81iE7Hbx4uKxE42EajFDNPdd0UrAFWbYIHGPdsTx0sJKqGGozlcG4njkYuLKmoHKV6O1H3nf3aj5vgKkvwi8kDPYomCiwApE5jgBFvK2UaJ4vYFVL86e7HFcaJyqkOexh2cnamPxKq/JRocRjwWmKVJmAF4GZvr69G10GO8QNjI28UzBAcy+NVmjReUnv2clUa8nJOLfMyIb4v+FiOo/puTQo3ywczGARS7exSwoXf1VdTgDsSVokbup0kV4wySQRiImcRNWHEkIXXC1uuROao7NzNu8159F69tNCleLuvnv37A0R9V2hjnYX2A3UDflykFE+Kk/uW3nnjsrKjplg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(40460700003)(8676002)(8936002)(31696002)(41300700001)(53546011)(316002)(36756003)(110136005)(70586007)(70206006)(86362001)(16576012)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(36860700001)(44832011)(31686004)(966005)(2906002)(2616005)(426003)(5660300002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:22:06.4183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb40685d-8d95-4659-c164-08dba53bfcba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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

On 8/8/23 12:22, Eugen Hristev wrote:
> In case CC_OPTIMIZE_FOR_DEBUG is set, unused code will not be optimized out,
> hence the reference to fpga_load will be compiled.
> if DM_FPGA and SPL_FPGA are not set, the build will fail with :
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

Actually there is another patch targeting the same code.
Please take a look at
https://lore.kernel.org/r/20230816065437.836392-1-chanho61.park@samsung.com
and get Chanho on board and create a patch to cover both cases.

Thanks,
Michal
