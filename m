Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25770E70719
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8659786AF7;
	Thu, 21 Sep 2023 13:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HP4kmmVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D9286AFB; Thu, 21 Sep 2023 13:07:51 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAE4867C7
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO+QtH0jQnPuo6CBHnsQLrUJ1YUqw1OuNz6tMCrRZmR0Dwx68QgbRtGJ3QR9PrY9zS5C5idL4QjLZeSBtcy4dGz7AcBpaOS0POyoj3YgwbNos6jbxw1suQn8kDv8t/Rct8g37ERYvM3hgwelS+2G+AaDts+lOhGlY1Z23xEK/t1LDUNymFWQH3BZiSPqzrZYw7ZA4c4zhUiEc65h107ABHeoe2p1h+R8dS8N0QIfa2MXMH/gHj4y0VRFTb8wIz/Eda2AUmVyawVYpBrU2kDXeUbkBbLBSOa6UPAJeS3ecdOk9xGHwbVC0JDHE9vUFR5ni3SN9k8KUI2cfPOEd8Rcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNSuBtc/lqOPR1sfhMTcJgFsumf9+3VRBk0tOxaHZyI=;
 b=e5rnhKCw2W8FfexesGlFj6qoWCR7mRWfMo1XzTZPeBFEToyyhBJOqUlMlBRECD2lViTe6D/ho1JqA6cJ+cAymaoW/VrwiQRduYo8u6DHeOSmS/lf63ES8szktSPehQmCDxJN0YGzOkO9gKhZGCHJnmc8i+fZsCvPom0CkHMeQWcpTQd7F2hrKrzqcH/GNfsQSWWpa67zdShoPn8z31pOr62b+S9HQ9ihlfbiakHOGwDFOnzNTqQyt4Mmemr8RbYhahamm5fnR8RXGtUkvLNbOW97DXFfNCU+C/VCDQ3LayFeE8yBOEqYG4Ol4nWZcMVmAUpMf8H/Lg6Ipr1/coLO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNSuBtc/lqOPR1sfhMTcJgFsumf9+3VRBk0tOxaHZyI=;
 b=HP4kmmVadB3K0g9dICvGav/EspOpd0m8fTfpJqPL1G1tMU/ImFIfLDKfbyB/mJ0IRFG4nu9Fr9nEMEqnpoAzjw6LIOH+ymbXHrzkmnzyiO8H2cv5A6i3PVMyLwHVyBDFEkToDWXU8YeE5AbiuHId3EfoNeCciJtizMtb/naOD6I=
Received: from SA1P222CA0040.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::8)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 21 Sep
 2023 11:07:46 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::ec) by SA1P222CA0040.outlook.office365.com
 (2603:10b6:806:2d0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 11:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 11:07:45 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 06:07:43 -0500
Message-ID: <ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd.com>
Date: Thu, 21 Sep 2023 13:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] trace: Fix flyrecord alignment issue
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
References: <cover.1694779918.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1694779918.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 851dc118-73cd-4d82-ac3a-08dbba92fbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+F5AQq9JUF5olb+2CjRAv8qc9bKEuX8xPh7p3ojdFkfXy/SRRf706rtHGjDztfEE//k1SZUW0IJNqTTB6ov08eRDU4RTIzYorKy55qhSVFdQsp/ehC1m97b+FExpimMC6y/FgB08HDo9lOtvj7XToGCHl7Y7Sh0/Ow6Iw9y93P4nlKeYE9R6XPiig2tf9biuwhQfPmvPlDVfE3gnckNDnKjM0wDFbbk+RfbCGorcvoUZo6YjF5MLAcl0RYiov6UypwKhGpy94tTG6pT+RUyKpLakIfmSP9YK7Zc/MbTFrjIUIS9I1RzYLPg1xn0o0ePAP/+LCgrQYEfDZkjJ3mK+eD4GQr/kVkAQ6Nlp9iQTOA8hZQjgXrZSjhJWohZFRaDnepaCQ22O3WjGElJvhxjgviX6QnHVVfSTvq1Co3imfb3jjPEPqXY7CIXZEN7n0ORFpfVwVDC3TDQlQRRTAoQRU7FqvcUWMNsP9V/DZ8kNWCkSq7eNCMEg62v824wA0e8L8qmk0KA8v2WBn2jH8KqEjdaBNpQffnsBu57+MuFbr3g336qnOTONv4olLYaS7Z7jKNkM6w0mROwNOBANjrlEmQlV4k12/7tJwAGe3a6oa4CONcEUyHzH5NqZL28erFTYwQuhDWIq731v1i+8pap6pHYWAbj1PwMk0eKOkfkVsniviI34LXhsFco6lPkKfLDETY724fCHwUGFXoL6SYHExEnNo+unwpw6JOql9uBjYyHH+GcESJI6tchrsN5EZEYEzimoW37ybfOc7d0nhJsaLdc9M72OV/F+UZ6lWnYahOx5f/6pKLJE2H6mBqUEoaD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(426003)(16526019)(336012)(81166007)(356005)(478600001)(82740400003)(53546011)(316002)(2616005)(26005)(110136005)(70206006)(16576012)(83380400001)(36756003)(31686004)(47076005)(36860700001)(4744005)(8676002)(44832011)(5660300002)(8936002)(2906002)(40460700003)(40480700001)(31696002)(41300700001)(70586007)(86362001)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 11:07:45.5180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851dc118-73cd-4d82-ac3a-08dbba92fbd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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



On 9/15/23 14:12, Michal Simek wrote:
> Hi,
> 
> sandbox is getting bigger and bigger and I have reached the case that
> adding some more functions ends up in CI loop failure. After some
> investigation I found that flyrecord header have incorrect information
> about data offset which is caused by incorrect alignment calculation.
> That's why this series is fixing alignment calculation.
> I have done it via 3 patches where the first two are just preparing code
> for actual fixup.
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - s/start_addr/start_ofs/g'
> 
> Michal Simek (3):
>    trace: Use 64bit variable for start and len
>    trace: Move trace_clocks description above record offset calculation
>    trace: Fix alignment logic in flyrecord header
> 
>   tools/proftool.c | 39 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 34 insertions(+), 5 deletions(-)
> 

Applied.
M
