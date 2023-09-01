Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BE5CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F079C86703;
	Fri,  1 Sep 2023 08:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="poN6C+Sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888E88679F; Fri,  1 Sep 2023 08:31:55 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6AD08678A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=himV4MbLif+tV6a5ehVbktk5k8gawM81RyyEo5QF87MMjvY7g+Ey4/VJSTliyJn/wiPtmTVVxb0Tii/ywlLOK6sv+r3qDJuDQdKLoFBztZXqJ/bSrFm+iegnkA1Vd58EmN4hyzitRY7iS/oLFjdt0oFeaQGB7BGfpJdHbLj0RtGVdbSbP/t6UirRoDOvY8Tv2vvU7Yp3TVYOx1El/DunHHOZ1Zea8qZAJIGOD260mdmARS9l1p5n9RZauy/t9dH0QdVrsZXsu4bqw79U4YBXjlG9Bu8Ug3hghLycx22awWtBM/8Xtdfe06FO5sFP94Apq/c3PpesSn1lh0qcOibbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJD0stvb4Wro2Z20ynMS2x3irJeXw+px2R7BXTb1GHE=;
 b=EqbgOrFzlxWWPNkWyNDsmq+J2qVxpzxXxhQMtUij30VYTSEfw+jHTsJnn3zvPZdBrwOE9PXu+VOTiVN43+k1qK1w6SKlidpkzAqAJOHpcLj1MhvbDP77mIbQTtDd8lYhs7NWdgmIapaxliRr5kXUKoouL0CDdM23wSkToLCX2u9T60gqJ2qLjStvaT66DKNGmrRqxWx9qwMh5KU3zPS/G4DWDRIdJp3JPOhBcvWV2M1irFYPilwrmdZYuVllJpEGXXrmY/3a6dsrvHgFK0HufodZvB91GGVavVasymD09QgItoSO9OLwKW36psKGxI4etbMqZHWOuEIZIy7Bl1NJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJD0stvb4Wro2Z20ynMS2x3irJeXw+px2R7BXTb1GHE=;
 b=poN6C+SxmhpmDApPLrcZvvf2fPG4YRZQcesAsgxEw5qoMrZcEtekzJJ1sCeGY95ZHWMLB5vigcNRU8kUmWjiUkN2glFdHhAq1/WsQGwNtHNUqFBaVBOuQt7VHhhHjfLx/HvLhKR8dyGJ259FcQEM7RrTifPp7+KOzttS4eXU49w=
Received: from BY3PR10CA0001.namprd10.prod.outlook.com (2603:10b6:a03:255::6)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 06:31:46 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::73) by BY3PR10CA0001.outlook.office365.com
 (2603:10b6:a03:255::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Fri, 1 Sep 2023 06:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 06:31:45 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:31:44 -0500
Message-ID: <a914530a-849d-0546-decf-322f74058d01@amd.com>
Date: Fri, 1 Sep 2023 08:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: zynqmp: Add support for K26 rev2 boards
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
References: <6b9e68ebfb436da391daeb147f2a9985ac984c0c.1692951005.git.michal.simek@amd.com>
In-Reply-To: <6b9e68ebfb436da391daeb147f2a9985ac984c0c.1692951005.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: aec058f5-2613-44f3-9ce1-08dbaab51d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJcez9YgW2UB/DhWqXMa3Z6iGxCrQQ8ywL+/fnii+auGp1ymZNUs0E+erzx/8YiS7TyEyB6ghN0U3pNtrnprsNy+tLqoDBXLbuYtdRU/Zr0OmlDL/O799dubTsrl9rtTMN68IMgqKSYH0PMm0E5Bwnt5JAx900pDSbLp3WO6Z5SwlXVPiq9Nf7ouo8lf/h53JUxaCX4dwumCYv0WE4qRFVvEHvOhv2ufJUXwUmFGNRsXwedK3g8pso2ayoaqKo/SVqBF3sC0WYffHtoVyjF6b09CU6/qG1ocV7pjYm2CStUDfgx+eOTF9WnXzV2ThIl4M8cXBWCyiA4FI9RCcdD9mtmVxab1Ckte9d3Z7JZ+nxC36pELZ4kuDLUe4WIroMWXiRMyE39P48098D4eVVG3NN/gcUL9DIeCKEJYalSMixujaKROmLM5Ts0U+1ddfnmK2BRia7OXQ6SKhvgXoIsbInKVvecnNsFdaUTxZCVWcFRqys0LlLBUiSV8Ia6jdJmGgexGNPppZ/mtz7nVysgFadfAoZuXKXLRBaTmErCfoObOFEknHfkYqp8h9doFtW7nOZEJWmgyRV8K7FuWc5/W6M3ILocbfYFChazgNbqYpYOvJDSSscCIdgwI+Wsq4p9KZJq8zAMMidTfARzL48WMIRYRNXBstooKlFAuREJAVHGTQ+LWmRoHyQYT4NzsxGQBAJiEBSDPYUS1hYsnPLmTw6SgZTwZysKumVW2bEAGfP8sa+X5231pcgBrNombDr+fQijPMExuCwPgQPoWqSJNhq9kRylzIniTPXOHYBXllKPPygKElYWKuoOhpS5Nq67Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(2906002)(16576012)(316002)(41300700001)(5660300002)(44832011)(40460700003)(8676002)(8936002)(36756003)(31696002)(86362001)(356005)(31686004)(81166007)(478600001)(82740400003)(2616005)(426003)(336012)(83380400001)(26005)(16526019)(53546011)(70586007)(70206006)(36860700001)(110136005)(47076005)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 06:31:45.8136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec058f5-2613-44f3-9ce1-08dbaab51d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
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



On 8/25/23 10:10, Michal Simek wrote:
> Revision 2 is SW compatible with revision 1 but it is necessary to reflect
> it in model and compatible properties which are parsed by user space.
> Rev 2 has improved a power on boot reset and MIO34 shutdown glich
> improvement done via an additional filter in the GreenPak chip.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sm-k26-revA.dts  | 8 +++++---
>   arch/arm/dts/zynqmp-smk-k26-revA.dts | 8 +++++---
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> index d718fec76065..80b9face7483 100644
> --- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> @@ -1,8 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * dts file for Xilinx ZynqMP SM-K26 rev1/B/A
> + * dts file for Xilinx ZynqMP SM-K26 rev2/1/B/A
>    *
>    * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + * (C) Copyright 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -17,8 +18,9 @@
>   #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
>   
>   / {
> -	model = "ZynqMP SM-K26 Rev1/B/A";
> -	compatible = "xlnx,zynqmp-sm-k26-rev1", "xlnx,zynqmp-sm-k26-revB",
> +	model = "ZynqMP SM-K26 Rev2/1/B/A";
> +	compatible = "xlnx,zynqmp-sm-k26-rev2",
> +		     "xlnx,zynqmp-sm-k26-rev1", "xlnx,zynqmp-sm-k26-revB",
>   		     "xlnx,zynqmp-sm-k26-revA", "xlnx,zynqmp-sm-k26",
>   		     "xlnx,zynqmp";
>   
> diff --git a/arch/arm/dts/zynqmp-smk-k26-revA.dts b/arch/arm/dts/zynqmp-smk-k26-revA.dts
> index 85b0d1677240..719a4e49b574 100644
> --- a/arch/arm/dts/zynqmp-smk-k26-revA.dts
> +++ b/arch/arm/dts/zynqmp-smk-k26-revA.dts
> @@ -1,8 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * dts file for Xilinx ZynqMP SMK-K26 rev1/B/A
> + * dts file for Xilinx ZynqMP SMK-K26 rev2/1/B/A
>    *
>    * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + * (C) Copyright 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -10,8 +11,9 @@
>   #include "zynqmp-sm-k26-revA.dts"
>   
>   / {
> -	model = "ZynqMP SMK-K26 Rev1/B/A";
> -	compatible = "xlnx,zynqmp-smk-k26-rev1", "xlnx,zynqmp-smk-k26-revB",
> +	model = "ZynqMP SMK-K26 Rev2/1/B/A";
> +	compatible = "xlnx,zynqmp-smk-k26-rev2",
> +		     "xlnx,zynqmp-smk-k26-rev1", "xlnx,zynqmp-smk-k26-revB",
>   		     "xlnx,zynqmp-smk-k26-revA", "xlnx,zynqmp-smk-k26",
>   		     "xlnx,zynqmp";
>   };

Applied.
M
