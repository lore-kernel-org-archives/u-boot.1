Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B27E7071C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636B986B35;
	Thu, 21 Sep 2023 13:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ksTHA9nY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C5286B40; Thu, 21 Sep 2023 13:09:53 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C3E86AFB
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUDbpal/HMFZ3YuEFDBFXRxxK57vetgWknMlju2VADkGdbLnzWFpjCWLx6Ddb52a9qS8V0gF1sHdRzqN74LfUbDd7E6YV6ZkjMSkl22bfHVOiU1hEA7Bym61sNGGkB18VGjVW3r/MUtogroG9LuMREaUg3RQVsR7tmpb2gJ4XCx+hG0EcY8IrHayTTM0fb/vGu2ANsWqt4zhzrEWn3kyeqLO3Dv237DnPTuaxcoBl+j+mWNC69u6FoYWjFlJxRTawnRK1nnuMJ2imOIC8uFc/BVWSGZfv7ka6saA1vBjt4JAv6gtjwpaUzCHWL0YRpPUbod1jvu5tDDIVmwpG8jllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn0m3LqnOZDi0CNURnkwr0oMHC1SJlxAavn9jeBJAEA=;
 b=V4WxlTy0SpoSJflgxeRzttV7fX3iUJ7GcfoT8cGaQhq27MMlwwglpq0JGyJdifp1dSf8f5O6WLPnHl6ihNBZ3u85RtjjG4F/iuUIWJV2I1E0ouRNSXS4sQLcYMiDL4u3bhFqkRiGza6sLnwzm7n0J0QhdEMjEAoeQlwyHOprzdlc1vmwmYbw1YfzDA2oR2ZPkMTOINh5F0TKkfBeDkpcBbHMaZMRU1Mlc1iStdSopu3QXoXBhLywXMsivoyIfUAcQdSq4mRvDd9hthsRQqWgzPD/bolttPkTeR4uzkTunXR0G7QGkDLMoIPZ1v/5JKRUtpUXxBobl2T0/skD1i1y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn0m3LqnOZDi0CNURnkwr0oMHC1SJlxAavn9jeBJAEA=;
 b=ksTHA9nYTPAZi1w24wk10AYtzDT9IAsNmUmTcgjuS7sZMeqCIH9uKAV9wrF3gAR4+HvCpnTgzA/FiK43gR1PlN1Y+gcdQZdMlWJeCH1D2fv6KgqCNr2SICbLbR/rNy6Pugq6n7Y36k0w7nf9V4cSBzESGVun/YfodJIfNhtK8N8=
Received: from DM6PR07CA0087.namprd07.prod.outlook.com (2603:10b6:5:337::20)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 11:09:45 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::62) by DM6PR07CA0087.outlook.office365.com
 (2603:10b6:5:337::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 11:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 11:09:44 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 06:09:42 -0500
Message-ID: <9315e3f8-a708-40d5-b739-c99760a6f2bc@amd.com>
Date: Thu, 21 Sep 2023 13:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix issues for small sized data reads
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <git@xilinx.com>
References: <20230915031759.28889-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230915031759.28889-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db268d8-bf7d-4a55-9307-08dbba9342e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFsewcwlNKAM0Bt7xEMrBCWj12Rbs18wtY6mTWXv5rGaXzCeOksaUy85DqUUhouVqr2IYtF05B62bbpQs1tk5gG4Bk5xgR98/SngbK7+gyiX7F6kVB1ANVh4B7TOFzYf8MZEeXO83gSXATswUKtS81A9+y48kdBvABYQgl7xRJY5TWqn+ywxFr9vcDLOAWpsqA8PXV/LYf+Yk1XMnIkXrPUZXq/HAbR2z1jhgE77jeoEZ8KmkaogNMogdVLyCLZCi2vy7dBc+iS15xQAl8ceEGR3y+6KG38kRXskAR9qL/eIw0/k94qNNua1rzwF5pXxilSFYWQYbKK9or5lF4TTl9Vn372apL5a8HgBFpRhs6gmXpLBRUcHoOghlqH8/VXpmNXMLbIqMh6MG0U1gsErcZCEv0O3XMwKApmG1sbtlFj3qcJIH7XA8Fgk9ajFEFvwujYDoUv514EU6x/ElICkr6kB1J0zqC4Fl0v65nYGuRHOF15JO7d7x2RnnBp0mSot+fAvPT4kVtEapsNY+gUOs5gQnu5tRJWhq7mQc80HNJo3kUSAWgDSFM76LKas90TnYHqorwjNW1KOLQ32Qx/V0Jg5VFYyAU37At2354XoiQwXQQXB604sANuV28eZC6Tf2GJL0ap5mxUbRezX7SzBx+tii8srnb8io9v0tjcKQnzIev0Ad9PuEuR4EkUKAoYNt+zykh1aOx4tqIRJyeUc6NbrDpLa+B6oyBzCx0gKiDubb7pWDwVZ365eAqjguRNs2dazjlOjYlZgJeGGb1+Mtl47jpg3dw7+H+I/jDEo2BppLIx3GFyEzVOqqPeI1m2F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(31686004)(426003)(53546011)(31696002)(40480700001)(356005)(40460700003)(36756003)(82740400003)(26005)(36860700001)(86362001)(107886003)(2906002)(4744005)(478600001)(83380400001)(47076005)(70586007)(70206006)(8936002)(44832011)(2616005)(41300700001)(5660300002)(16526019)(4326008)(8676002)(316002)(336012)(16576012)(81166007)(110136005)(54906003)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 11:09:44.7772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db268d8-bf7d-4a55-9307-08dbba9342e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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



On 9/15/23 05:17, Venkatesh Yadav Abbarapu wrote:
> Change flush cache to invalidate cache and also fix
> cache related issues are seen with small sized data reads.
> Due to this, proper data is not read. Also some times
> sf probe fails randomly.
> 
> Ashok Reddy Soma (1):
>    spi: zynqmp_qspi: Change flush cache to invalidate cache
> 
> Venkatesh Yadav Abbarapu (1):
>    spi: zynqmp_qspi: Workaround for small data cache issue
> 
>   drivers/spi/zynqmp_gqspi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Applied.
M
