Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC347EB8FB0
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 11:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D32A868BC;
	Thu,  7 Sep 2023 13:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CiDLIv/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A6618692F; Thu,  7 Sep 2023 13:25:32 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF08586410
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 13:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB94MaypNoUlRBLTTxlGMcYBOesKdq8fRBezbBlj4w+hRmSJwUgEVFecCVh12N5ODu3WVWOfu7h83k6yzkNojLXbHza+Xl48DGPKKfnlfzAb0SsVP1SbRZaJl5lXz+FiQ3HzjsuzJHWFnQqserDxuS+VDBd2xG1I+marsv0TE0xVo8yRS7nJyx4U6euhEVH2k1sbQsu1Kmhpd2xbzqXqRH8j42E0Jx9TTS2sLQia3+s9MTMwQBGonjHtDSSsDWLfFc8ITfVxnbbX+wCT7U2pNNFPNer/2TKzxiNSxlQ/pamYlyKBIycJnS3dqNt568J9EqWmW+ObNAcmvIjKeN8b/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7VoZ4FZHbNbDb6s25mdpxnkhjxraLGjDIxi3F/94eI=;
 b=edpiC0HcQf75GLyzWiSr2dFVnodUClhrAgxM5i+TwfJRV5p6OF/YZkfu3hgccRg6ECNxVIzr+KP4pfhqj9XHoSxI9/UUptio2wCthE6zWmKmtQ6g68uHgLTOp15e1OhPlyCWiyCw9TrahpJLf89TJBhjg1SA60m9lWghWHtExEMrelSnCZp8gF8W/ia4xOTi5PV+pQKN7YyDArB+k3+jRIgJY1KHOkMTq6s63JE/N+2cS/7zd2UCe5ITOGBPSbSHydYysxI3GnZVCOgHaAiGR1fVT8eF0LjJ/d1SDOQw4Mm+0MZGEpUqeGXTfnQzjA+myhC6HuAFxGtGGsCmfRkPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7VoZ4FZHbNbDb6s25mdpxnkhjxraLGjDIxi3F/94eI=;
 b=CiDLIv/3hJNAZS+0ID9iE94UikVo3IFrl4HZnVO4Yf1ktOL2XWnSwuvHjYVzQ3ffyMUMmdNuGCEkxjaccPF5hMJnXwGF1fEvrU3sPPxeVmOaYSCQnq/9FXR2VHR2/E81v7pB+5+hnBYDUagDT9VXZ7K4X9mvdeLKMqPv+BZQn4Q=
Received: from SA9PR13CA0095.namprd13.prod.outlook.com (2603:10b6:806:24::10)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 11:25:25 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::be) by SA9PR13CA0095.outlook.office365.com
 (2603:10b6:806:24::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 11:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 11:25:25 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 06:25:22 -0500
Message-ID: <9f36935d-ba51-72b5-04e0-b91a88f7805d@amd.com>
Date: Thu, 7 Sep 2023 13:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/3] Do not setup boot_targets if driver is not enabled
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <git@xilinx.com>
References: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cea7e4-16a4-4c02-e7b3-08dbaf9521de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKOZTCTtPvule6E/FBcR9BB6fo/0DR4k6ayN5de4x+dBNqE/yDcHcmfeJNXX7CONa860nSHQ7/7lDhGNjHNzsNgen+RiFcYr4kxP1+WIikxcPRsTWLrxOCniOwKdB2NJsZ33uLDffVVoVRDoZ5pvJwpYnwfN2a/vBtp0cd0rL/OHDTRIBJx2D0bnfIpoNCSAbGynEEWtoAKJqj0FwLasBqOSNrzS5qxkX34RQ/8fK25v8VjvOoSrsWkWHRLWhoWBBofP/gCFd+kKdKnNs13yLrCgzjAnQzoB7yQcoMv7KzHrKS/nSXB0VobK1V/bVJy3TIGBO/VfHYw6ldHgXoY24/uCo9iiAe6SWEGJJFgb1M09jYEeRwmkwIrG0OuYlkH0eCD72hwly8aucF1eLT8qHp4GAS6FvGnP2jgn41sxt4i+QXPwNC/8bq1rhe4JG6/uqxkwEerZDT2tc/oadZQbgcTZE24uszXndAyYoEHIGeBQHzg9AbN/zn8a2HJab9s5dQNelvs+21zgucLGVicYEzhaE+0L5LXefL89a++NUHHZwi/LCf4F9l0RDdOaV2lUSuDFbUt3xwaBL0a8IAp4atBnauhef67ZyvWIW2Rotj4g/MiPkSccDNFGNX51qFytzfBn8suLxDLYEo4XZfAa83RPZEdHI/WlTSwXCpIZLOfLU4jiiO/oOpZjHLAkRe6QqH3pDUi1+te4ucTWjRC2lrQeO+NBaWOU5RAHs1h6grQWzJ2fz53Gugp3533Fzzjqsun+XLOWDBfIZCM7dD/v1+9oUby1kYX4i/tsksQYfERX607ucVIVbOi2MI+AeQfs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(81166007)(31686004)(53546011)(6666004)(356005)(40460700003)(82740400003)(31696002)(36756003)(47076005)(36860700001)(86362001)(40480700001)(107886003)(2616005)(4744005)(2906002)(336012)(426003)(16526019)(26005)(478600001)(16576012)(83380400001)(70206006)(8936002)(41300700001)(8676002)(4326008)(5660300002)(70586007)(316002)(44832011)(110136005)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 11:25:25.5676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cea7e4-16a4-4c02-e7b3-08dbaf9521de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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



On 9/4/23 05:20, Venkatesh Yadav Abbarapu wrote:
> Fixing the boot_targets for versal-net, versal and zynqmp platforms.
> 
> Venkatesh Yadav Abbarapu (3):
>    xilinx: versal-net: Do not setup boot_targets if driver is not enabled
>    xilinx: versal: Do not setup boot_targets if driver is not enabled
>    xilinx: zynqmp: Do not setup boot_targets if driver is not enabled
> 
>   board/xilinx/versal-net/board.c | 76 ++++++++++++++++-----------------
>   board/xilinx/versal/board.c     | 67 +++++++++++++++--------------
>   board/xilinx/zynqmp/zynqmp.c    | 71 +++++++++++++++---------------
>   3 files changed, 108 insertions(+), 106 deletions(-)
> 

Applied.
M
