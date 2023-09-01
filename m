Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ABACA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D05B86564;
	Fri,  1 Sep 2023 09:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FbyQ9gEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94628669D; Fri,  1 Sep 2023 09:23:49 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785C5846C0
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEH6fN77P6OHh+07VSzkcTtSsshRw2YwjRvCe9yU2e+70wf9A9uhF0XOjf88mogBrNrIhIQCJbOxnlESJhWHz+a/b9Ky3LUYaHDPLkdaoEI5hnH226n9pwsGcJB9XaCaVFPj34n5FlxZi4WN1JFXcTTfmUYZ7VaMiWc/2vI2gr/XLDufbIqtnEv9qT1Z/kdyAFa7p1Xnbc9kzMTQSdSQvGohsX87Z34i3QrJ/7KfPC4GXXYoICAVIja2A3BtqhtSOIrHKmhZ3EaCBQ0EZf476A1Ci1BO3W4cyi5CPdKbt5X3usymnRUZ1xUPue9MiWqybTxumeDl7U9zzEzjla17EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgQU9ET7GkNd2dS5QI6RdTPtIxi49ooW6nxTkCa6rDI=;
 b=b7hfJlRH8OgM1j4feOMeIZ5e4+Qjk3YVHB5gIOv8SZgOlgD8nGOaz8klnjgI3BoYQTHPdxY4isuGaX9x5zu3wwIHRGiVPmXxdo6NBSY5w7iYVyQI+oFJAVVnDGi1Twl8Elslwd/AA6U6T5JZfpfdorFdeANdrzBPXZ+TbJItk77lcMmD6mE61zErZ9f9p/oUYLTJw7LkWOt5Pouh+Ku+bIfNabX1AEUk+9OlOMnioHL50j8ZcBiN9smzYUWeVp0e+dl58zyJugCwIefBCbgnDoR94CdVL01CUVJgZU6x8M1caath8vA8lFi6VsmtgR6Fk2YqQTmb6TU/PR8IK4PujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=steffen.cc smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgQU9ET7GkNd2dS5QI6RdTPtIxi49ooW6nxTkCa6rDI=;
 b=FbyQ9gELcrLU1g0BFeQqQfiJLgmQrMk4b2iVi5JX8SqyWRNseztE+pbCzvNk/QcYqNAU0gVko2TdjV1oV4YLhPnbZOefCPzpjsaOhQzdKOgdw5FyQjUCEcrAvHQE+eT6dlhLp959huocTtqJsv+BY8PW89PmLdIpaZFWq1lOrNg=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 07:23:41 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::fe) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.25 via Frontend
 Transport; Fri, 1 Sep 2023 07:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Fri, 1 Sep 2023 07:23:39 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 02:23:38 -0500
Message-ID: <5c110cdd-fca2-7c7d-0374-c26ce121b6ba@amd.com>
Date: Fri, 1 Sep 2023 09:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] xilinx: zynqmp: move fdt_addr so we can use devices
 with less memory
Content-Language: en-US
To: Steffen Dirkwinkel <lists@steffen.cc>, <u-boot@lists.denx.de>
CC: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
References: <20230830140349.10801-1-lists@steffen.cc>
 <20230830140349.10801-4-lists@steffen.cc>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230830140349.10801-4-lists@steffen.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: f87430a8-069f-48c3-5a2c-08dbaabc5d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zTtBbde1M/67eEuLidEglsaoBXcc0Pe7iBIVNtrl/GpNpVO+t8i+JoOdZbZyxTPKGt4bOR+EoeCCQrWI0iZ2Z0Te3BGl9x+/vSV6ObXuVphIlBdR589muj09QJJaVuS7xM/TAVsQAKmdD2ibpf1wXcmRl6NMZpLE8BYrkZFRYNvkbj62b/u5o+4qD8P/hiZnbd9RyNzY1D4J3/2vyDsu/tEMl9i7nwp9nmAnou+antb9hWzhcvd+yzyPpkHaaSk80pwLom8gMIHnEBRErmyOkI7JA+RZ1ZmB1d3eM6285ucDrA73CHjPk/VRCt6oPTG/VBZQhs5BUpa6l2m0dvsztvJ0qVHskBAU/0gsBfdIKWqgd14wXTMQTJXpUq31TfK79x/4qIgYPpLPqgIAHKMXlTLhyYmKKX97H0Ay+LHu9EZIX6w9K2Zb4jMtyNPLcLTk051lWdxiBsDCycABfg3IjwYzSjk7OuZpvTk5xswc81deuFryTEDSY9u+M56LnKo26Ol1NjfVHv1GkGrdBL377S9lixkOvTVUmhca4L7V+mASPaoGNkn8afYvy78PSvqNd7bOKe1pqe6LpUVU+rXL4Luzgm6Idqy4JIstsjI5FMeplBDHoX+vUzyEpRgiiJxJEBWnuQgOuZ69vybLbhqa6EskDwghAHhIKKUHIwuBm0qXCqxteMzJwtF+yQ7L0+dHz47SbGf6zPTf+okxi/927eQ3VyqNbwbhtgLnEzsgZXP70HbwqItLhkrRjQEzJzaiRN3OlrDHbb56Wf78NGl3Jj2+zKWh2pKjtFd/LqNiV0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(36840700001)(46966006)(26005)(40460700003)(16576012)(316002)(41300700001)(5660300002)(4326008)(336012)(426003)(47076005)(44832011)(2906002)(31696002)(86362001)(2616005)(16526019)(36756003)(8676002)(36860700001)(40480700001)(83380400001)(8936002)(81166007)(356005)(82740400003)(966005)(70586007)(110136005)(70206006)(478600001)(31686004)(53546011)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 07:23:39.5387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87430a8-069f-48c3-5a2c-08dbaabc5d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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



On 8/30/23 16:03, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> With the current config we'd put the fdt outside of memory.
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
> 
>   include/configs/xilinx_zynqmp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
> index 74264b7bee..334fe95d66 100644
> --- a/include/configs/xilinx_zynqmp.h
> +++ b/include/configs/xilinx_zynqmp.h
> @@ -50,7 +50,7 @@
>   #endif
>   
>   #define ENV_MEM_LAYOUT_SETTINGS \
> -	"fdt_addr_r=0x40000000\0" \
> +	"fdt_addr_r=0x28000000\0" \
>   	"fdt_size_r=0x400000\0" \
>   	"pxefile_addr_r=0x10000000\0" \
>   	"kernel_addr_r=0x18000000\0" \

This is not the right way to go.

I have started to move these variables setting to DT.
You can take a look at
https://github.com/devicetree-org/dt-schema/commit/3815da51a138619f443abcf2f821ca0a6fd57949

And fdt_addr_r is the same case. It should be moved to DT and remove it from here.

Thanks,
Michal
