Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2CCEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 11:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E6F867DE;
	Mon, 21 Aug 2023 13:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nigPxDxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BFB986802; Mon, 21 Aug 2023 13:59:16 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBD4867D0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 13:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ9V/+5vD55XU5UbmL56SxEUBkKF0NZTY0KxAzs+lDL9+/RyGSwdnL8cJSeBUC/FuaApyx6FR4NM35VcMkVGPo5sX72XoYNfjI+Lr1p/af/1qkUtUsVAKnIxvHTmEZWTkEWGrus0XMIu5+Rx20tLxlYRuv4y0kCJckuZ4AJ1rNHQKdueEgeIRijf2pYxr9rAiEulhxgFiet7ftSCSqdK/WmX/qD9d59GTgjrc1orYeqa4H3ZQphLQSJDU4I1Hxr1z4uZkje+nvWtYsWDohnQnDUpXN7aTWDm2fFpHr2/20CcP6kryW5cIOoFW90LnqHJVjajWtyg0/2/LE0/n7mWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFnEvT3b0NlnaGr0mUeWIqnBERstvdMFvtL9E7Y3LHs=;
 b=PW6mvCfbEe/fDXdBGLfaf/8PBf5XNHmOcyl1rqAawTNSx+9iZ7cF1U3ruuhDlXONG8CRSPG6t91ftPluIeXePimApaWWjrmCpkthUyIZ9vfUNoNIY54v2R018uG9Lkw1pHEUVNr4Ss63trd6qAeOXWjNYrN6AL2pLQPJHuZvxYFEbAo3GiXV5koG0ZbwOK/fQMRugCrKZFjJtH0LBXmwf5B/f/nB/P0wNZrTp5XSbdGEDxF3ySrJEp9IC+nAJE/34rkObVl/oNs5T52cdPO2L+Q2c8A2EU1OeDHoMLacZ1uBAmP3fdrbMZKLb4N1vX7qPRSxD0/lFEHr1cp2AlhC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFnEvT3b0NlnaGr0mUeWIqnBERstvdMFvtL9E7Y3LHs=;
 b=nigPxDxCdJMs7AxtqjiNaOSjHzwJSLe40AQd8V6XZUil5KW1k/whMx//Stlgb0ph5BJ/qtR6Hj18hGkoYaArQLp6d6UuATwDQ2j4gDaUH/8uuDjZLoIOkqMbZMTVqT5Ue5NUejZKN8WlJWXrdtRBxmMDL78YWhymArYbYTwIlFY=
Received: from CY5PR15CA0014.namprd15.prod.outlook.com (2603:10b6:930:14::35)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:59:08 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::d1) by CY5PR15CA0014.outlook.office365.com
 (2603:10b6:930:14::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 11:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 11:59:07 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 06:59:04 -0500
Message-ID: <18ca2d33-f887-e778-db1a-88c6f1f4d818@amd.com>
Date: Mon, 21 Aug 2023 13:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/4] xilinx: zynqmp: Move dfu.h include to be with the code
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20230817174125.369849-1-trini@konsulko.com>
 <20230817174125.369849-3-trini@konsulko.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230817174125.369849-3-trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0db44d-bc9d-47b0-5fa8-08dba23e0629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuRvet6NgjYSTU2rgjpaxG9IBUlCHCf6BRUEdqVAety4P4OKDxnCRHB8NtldWlq2Y9uCK0DauwavLWQ15JVFpsb4/ibhaKjKt3vRAeJIbqe3psUDfZjJ5n87953FYGPJ+Y18eufXtTfBh3dAB+9RJozc2v5wqUlRY6AAG1ZlaUkOv+oLInL4RvCkJWbao/QbPbRIK4qFG7AwiuC8l3neHfDWXVfz2E/ocUeNXFnZg7sdepmk1fXZtH2HY/EJ1HuKKM9d0+QJz3eKdS9oafRluMePDDN3nfdv2kziKr9YVOsE63io/XNPlGImsQgUjlLze2B3U9BXVhYdqypFDUFQ3YX72fXVXX124143Dm/9bzZrlpFf6lYdgYZApTsMxz+haSr0a+9wzYBjEJskvgMsjUNLAvL39iHk4Dl3SEescU+88ak8th+hiTayGJGjrMapxewQ4GAelY01FBk99p/Ti56FAHGNG+XByCdkmPNq7XdwkK6Ev4MkA6qUO74a+963TeTizFg8vF7UGESU8Zw/PeOm84jfQeqX+EEg1B8gzEU1KnLu64DwL9Mzal9HVexYVB0YvvRDMMQxAm7f4D98Nzcx0GE7DXXEdTphJ9jzn4ajfN6KorlIcBfY1bqP4BoNZlhe2OKrOplVoS2jFH2e4pjNZCXpNvsW37ureCruzedvU3jXS/G3Esr+7JrAUVJlZlOiYJojTz1fvWG+yRn28lsJVscqO7HopXn8a8lWFq6xDrHIrP85w6GU6dVOBzHaBQpz5WwJ+UqyFZsW8F5jingfIs2ExmsRPOqZq4U1Tbg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(16576012)(70586007)(70206006)(316002)(110136005)(8676002)(8936002)(2616005)(41300700001)(40460700003)(36756003)(82740400003)(356005)(81166007)(478600001)(966005)(53546011)(40480700001)(2906002)(83380400001)(86362001)(31696002)(36860700001)(47076005)(31686004)(336012)(44832011)(426003)(5660300002)(26005)(16526019)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:59:07.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0db44d-bc9d-47b0-5fa8-08dba23e0629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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



On 8/17/23 19:41, Tom Rini wrote:
> Move where we include <dfu.h> to be guarded by a DFU-related Kconfig
> option.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This becomes an issue with
> https://patchwork.ozlabs.org/project/uboot/patch/20220620111354.448512-1-jh80.chung@samsung.com/
> applied as now we can't include <dfu.h> without CONFIG_DFU_NAME_MAX_SIZE
> set (or we have a dummy value for ifndef).  Another option would be to
> restructure the code to move the dfu code to another file, but I don't
> know if that will make the rest of the real use cases here easier or
> harder.
> 
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   board/xilinx/zynqmp/zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 309f24a5f43d..367c3c65a9dc 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -8,7 +8,6 @@
>   #include <command.h>
>   #include <cpu_func.h>
>   #include <debug_uart.h>
> -#include <dfu.h>
>   #include <env.h>
>   #include <env_internal.h>
>   #include <init.h>
> @@ -606,6 +605,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   }
>   
>   #if defined(CONFIG_SET_DFU_ALT_INFO)
> +#include <dfu.h>
>   
>   #define DFU_ALT_BUF_LEN		SZ_1K
>   

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
