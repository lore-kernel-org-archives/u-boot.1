Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705FFC6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 11:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4A286496;
	Tue, 29 Aug 2023 13:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qmws641o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E4E864D7; Tue, 29 Aug 2023 13:10:14 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E8684788
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 13:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncfKP02bQnYqhi3DYd/29RshIkhM1RY9+2cEDer0UsZ6MaH9kVDBcvzqMc7MBYapns256Ns3d9GJO9G3uU5kxnrhxUwQQ+odojiL2GDwVadwuwXAE7P0ZxeZdbVbsEMm85LWyjWr36ntrmjqlCG5yeWRjARt3c/Nk1W4E/+DXDr6qgUyVG7ASjzw7vAaWfa2qZ252CbWC5yZsY5M3EP+RTLXGezZA3jJLJnub4hA3Nkcyd7Ir+RXlXb865WbR9Sm5l7HThmRA4O2qFaMYKbSXI11RANJsP3Z/BpJMPRBatgNUQiFfig3AmCEiBUcMYC0j8orAhUtwSMB1TP6jEKp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHzqH381td4D4Jzm9mNPu4gOC0wTA58RKYJc1RGia3E=;
 b=nFMRa4qKjbtYd5Gu51Uw6g70+XISWfb+e+eBa1/fyvZ6Qy/v3kc8UFzenyfRR9peqC/7XYH876v3lgmozFWQ7876W93Pbqg3oLqqLARaDZp06D/2bC9hqc9L6iGmNzJ9K23+8G7yRA0GSJR5mIhluFjhnJ8kI5G5KK8gq8mk5hBWZRClBqeshhvhFadI1bE0dA3DCy5my9GAIG7o/TLV36mGTf9u4NH88JQugKXRwpXZv162yPcOVIPtw5H5bFxgS8L1vzSoJchRxl4DJnVHZfgBAzIWpysrJwADGYmFwbREVhIbvRkPIjAKvtis8nAHvti9SkrFsF/+QczPaG07Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=samsung.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHzqH381td4D4Jzm9mNPu4gOC0wTA58RKYJc1RGia3E=;
 b=qmws641oDZI0B5mv/wvkXSgSieyvPw1BzYuVfrUhjOoBtZZrnuWpYiG1ZwpiWKsJAXkCfwmEDwcrXJ+WsZJ1xE8tZLs4URiyKgTjrQnBPWHR+q7hIt5MGI03kuqaKxYNO/HvlJF3tMpL1oz88LbDctpNhQk9ZlSZNzFrtOpVG1c=
Received: from SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::27)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 11:10:08 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::de) by SA9P223CA0022.outlook.office365.com
 (2603:10b6:806:26::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 11:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 11:10:07 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 06:10:06 -0500
Message-ID: <84b747fb-f026-be06-aa0f-c3bab07c3ac4@amd.com>
Date: Tue, 29 Aug 2023 13:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>, <u-boot@lists.denx.de>
References: <CGME20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec@epcas2p3.samsung.com>
 <20230816065437.836392-1-chanho61.park@samsung.com>
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug build
In-Reply-To: <20230816065437.836392-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fb3b10-c632-48ec-0f86-08dba880810e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vo7uTj4Qabn3Tv2IG7HpC0A0wCNtU7CaQ5P1uC63HBwXrRyHVTqCDUZmfzWU3vVkxmBmHsfTxVEJ+0snZjWiI75CVe83dkR5rPD8k1gaUphC76nGedvv8DhUnUmZ4T6ZgHqJKw26W5ty7Oc9CRFESOasgYvo6ckVrHR3Bxo3QH4UbHMT4u4NrwYu4aYhJZTlruoeQKSC4up8V5Xe02dP05L5wxY+Y3eC2X3JZhw2gw7SeuYSVHPoQJuJkpR+PIcmSShVBkwVwo+SKz5FAoYht17sm3O1KSYKo0rERqDW0KrIP3DjZvIavMxeE+LBUOR/eu8PiOnpU9JiOuooCbvDyqDr/Rub2i0kfZ4I+0GCdzrAckLu95W3JT0BU6BgWRCyJr9qpI7y5yzLQrQTL37395E49JSX2yoWe7RegZBPf85qKLXip0e4g7sIBHsUhY0zpa6YLt6fRUHFTpAuIvw+tQdT48A15LVrruWzGr7EvnPIW3Sw6VLwJ0fGsoKsiTH2hkUZ8QSgPpUCuMICbO31IljfmMXR+6dqvQGtHnz0l5H127sXOlweJCtJ8SFjlGCEdV8QJVNJOP0rGn1UStXIGg8DVHZEiXUCT/UiClZE9zXxV3MiRHGXj91S21iSm3pSRrk13BIr3rc03TawwFuNa/unrmL9VH98Gn5bKvCf6UZ8lxXzfwTUpEsbvd/kfEDk54M9m2vfSsDYA1h3vc/KVGDCZnZyRI3YIY2zpCgilzTODynkXSZ9skwwDx7DAmPpisn9tBQoAkI03ERBGczR8ELXYz60jz+uEfRlDeqTEJ3sP04BHRWtbxTrCx3cPLA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(53546011)(478600001)(2906002)(336012)(426003)(26005)(16526019)(70586007)(2616005)(316002)(16576012)(41300700001)(70206006)(8676002)(5660300002)(44832011)(110136005)(8936002)(40480700001)(36756003)(86362001)(40460700003)(356005)(81166007)(36860700001)(47076005)(31696002)(31686004)(82740400003)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 11:10:07.6894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fb3b10-c632-48ec-0f86-08dba880810e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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



On 8/16/23 08:54, Chanho Park wrote:
> This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled and
> CONFIG_SPL_FPGA is not enabled.

I would rewrite this because the connection to SPL_FPGA is just one part of it.
It is also taken when CONFIG_FPGA is not enabled.


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

Thanks,
Michal
