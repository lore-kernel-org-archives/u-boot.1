Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C53FE784AF
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 10:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F34087156;
	Mon,  2 Oct 2023 12:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NqwvFMv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172498716E; Mon,  2 Oct 2023 12:05:14 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F4587147
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 12:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMsMQPoy85Vlidqi8BB56vdDsW6d4wwPOV7yjUBwYJyr8Xu3aFyuQuPUKltgcS8UD7sdqIxceirwns+44Y+/vy6GkTltnTVDcj5Zj1wzzCbn2Snuxx4zfUfnATjq+lANv95GfNmYhibklZDO4zP7BZ2yPogEHFj8D0ZJ7187WM51JZcJmKLmXkGdNTVdfUrsdIqgOWbiYh5RF/neYFbz8Os8zCD3tV4uzcKQrjj7FdNa+1wdu7jqiMNgjgJKDnVZlcxFwuASZfdvmDDMsm9J3KF4WMtqXW3sbWqpKUDSNjVL+ds8oAg7gMylrqfOYhor9qfmj2Xs1R1tJp5W6GHQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn12itznsH5XeaGToWrGMu7RlIdI1gwL1fVBGSQ/nDY=;
 b=E+jMkanNd2zUMRCTyrBg+lqa8cZX5aBs7JTeobYcFe/G7bjKXPsrnUiR8q5j6GOiE1uQ1GbJ8f4AYT971q05dYomayzm8up8eOHrdx9TnxLRFNoQHP+WEfgxZGzO4hBnaaEMmiCxdewB3y0QhF0MsXNY5CewAYLOf7i5O3zQfolB+KtdfghCri8pBIoe9e4bhHgYk2Qz98Dc/fbhk7f3UOz4YXQkSdjdplPo7174BgHx4lcwJ3J9+1+PtUfOz3QB+xiw4qC2EQckRlpXhk+y3gp/ku998IUEpkFC4zOtHXYxJtUB/yBijRRPcFCaero/7UFRbNICvjdVYsBgB0ojig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn12itznsH5XeaGToWrGMu7RlIdI1gwL1fVBGSQ/nDY=;
 b=NqwvFMv95souNnAEcfs91n+MvD1FVI87lEmNXM+R/bH8x9wTxtgk5CV45vVNpJi6OaQFQJzoJl7RrYRBFHsYoL0v0d0FXrxQd1ILrJLcgelvn2udzdgm3f3buRrIPHvFnX/QPr0xeh2+J1MNHncoU4OWiA7HAdsWwLy98EYziqo=
Received: from SA9PR13CA0162.namprd13.prod.outlook.com (2603:10b6:806:28::17)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 10:05:07 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::c2) by SA9PR13CA0162.outlook.office365.com
 (2603:10b6:806:28::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.21 via Frontend
 Transport; Mon, 2 Oct 2023 10:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 10:05:06 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 05:05:04 -0500
Message-ID: <94d69335-3acf-40b8-83d4-db5cc53684f9@amd.com>
Date: Mon, 2 Oct 2023 12:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Rename dt overlay file names from dts to
 dtso
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
References: <1dce37e72428c14a3ccbb5dc674b90dfe56b75ac.1695046155.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1dce37e72428c14a3ccbb5dc674b90dfe56b75ac.1695046155.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5396e2-101f-42af-a5bd-08dbc32f0e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VRpvWwoCl3vCWNBSbCxQBZXwO9NWnL6cmAYlZvGxeKze8D+wKP/xel/HfumaiYC9dQa5ur1wUFKPCVyyKSCkMSCEA53B8qH852lJgk3bTX4sMXWaRYOMvZxAXdHV9gnErek9oRDvI0RIYEVH1jyLxPGiVyWbz/CZds8RzzeHbdfMyrH3+o4p4ITy5JnV8Ll7uG5TK6w8hul704sW501cibdcETUUn1KDoHh5pH6VGCiZSYSNkKdIf5WUyLaRBeQW/ILnCrBcbOglKuy9KoywQ64wrGf4rrzUxRnDW4pq7Vb5viGf6pIQmEela0CaLqYakQ+KdPn7e+Tld0eAzlpBdRt8DPH3qWn1JcgjToVPCMsnuac8drQ2GnrsFD5rmugvRtEd1C0C8gmGAq59K5tb1S/7G3LJ2ROT7Ca8g7to/2Llc6aXaeQB6JRWT89GFovSEWotgazncrkYJUro3xDge0D+WNfF97T4WrsviQvS0iypoCvkAlmYWVGj5YtU+ENOtQlSD+Mc9aQ2tsZithfj9RRtWdjzTq/GdyS50KQXkfWsl6wmdVI472pmfhX17657BxGCAL8kwEdmaFuflHyIz2ITOn5IYXdY/HCafmN80kxcfUkGRUdFM7vM1Oj7zZo/vPUh/GYjtoxjYX0WvaQe1EnI+4AeRptwm1z9SssHjdMKKp+eLVGq2//K++8cYo6OjQKAAEzloWskxpuP3PNl6ZtJCJz/5DIBgL4uurc69Imj56XDGXUrx98ZspZh1FnSuEkCan2JQh/lw78LzX1IVTQ4qCusCBOtf4WViP3r40E7xR3Ye17aUYIOFQnMQJa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(53546011)(2906002)(356005)(83380400001)(82740400003)(81166007)(31696002)(86362001)(36756003)(36860700001)(40480700001)(26005)(336012)(47076005)(16526019)(426003)(8676002)(8936002)(44832011)(40460700003)(478600001)(5660300002)(31686004)(16576012)(316002)(41300700001)(70586007)(70206006)(110136005)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 10:05:06.8144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5396e2-101f-42af-a5bd-08dbc32f0e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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



On 9/18/23 16:09, Michal Simek wrote:
> Use dtso suffix instead of dts. Build option was introduced by
> commit a0f9a77912b2 ("kbuild: Allow DTB overlays to built from .dtso named
> source files").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   .../dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso}   | 0
>   .../dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso}   | 0
>   .../dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso}   | 0
>   .../dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso}   | 0
>   4 files changed, 0 insertions(+), 0 deletions(-)
>   rename arch/arm/dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso} (100%)
>   rename arch/arm/dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso} (100%)
>   rename arch/arm/dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
>   rename arch/arm/dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dts b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> similarity index 100%
> rename from arch/arm/dts/zynqmp-sck-kr-g-revA.dts
> rename to arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> similarity index 100%
> rename from arch/arm/dts/zynqmp-sck-kr-g-revB.dts
> rename to arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dts b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> similarity index 100%
> rename from arch/arm/dts/zynqmp-sck-kv-g-revA.dts
> rename to arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> similarity index 100%
> rename from arch/arm/dts/zynqmp-sck-kv-g-revB.dts
> rename to arch/arm/dts/zynqmp-sck-kv-g-revB.dtso

Applied.
M
