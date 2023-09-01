Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF7FCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB851865A2;
	Fri,  1 Sep 2023 08:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RFCDDNcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F098619A; Fri,  1 Sep 2023 08:12:01 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765098675B
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp59eI9a2EndKi/Qgg6cCKMEfk8IytVG+1dtPot/NG+b05q56XfLL2Kj45X4s+au1BGwtvbe+utt7ovpHo5JMeNSOGRY55/PPYn0bTx6TMMrwS5tnvBUfEokQ8LbbGQKnlT2YYDchcb74Kbitsu+WdPtynDr33VKnurcdhEiavDy20S3yOGQzoi2oSiM1o122xSIL4BEuC5IYXYadcICh2WBl7kp2Ft6bA/meT/PMBl7fHMhQ5eIln1ok8a9i6SMAqzix9zZ3dwcBn0rdH/EFawQQCqskheIBH0tSt9QMAPihrAKz3XB9ixLkpFqzEwD6uw2VFqPvV1TXMZDxJBmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2wTftWZGMJxzQlaifYWlJ207GXFNwt/yhAZXoNWydk=;
 b=Vmj+HyZqePMF7Qql+k3dhiw6ETUTRCDugXtVHiI6iieHntaQ/MgxgWljrK0MMI2yqRZMxMFx0yIwhLTMQC8ah0loEYxB5zMXjUIwViDQdrrvNq6hQQBFip69c3A3OCHPjkjpWN7MCF7krjd6GYhPJOLSb4txoEsXt1P0BDy+n0ois6wlTyhEL7O+ECy2PNCw6h4eJb+xUg2VUuiBkS1ZRzBCf7Has27uuhTf9x+JIFSUD0re+zm3mwPogbrpfzz3jtXX8d49YXeO5tJJBKoGS3BtIfht9XcPiOkI+vkuy6T8kjZQqnK6yTj0wO0yfWQKSzcJspBItimOUaA7qlqZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kwiboo.se smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2wTftWZGMJxzQlaifYWlJ207GXFNwt/yhAZXoNWydk=;
 b=RFCDDNcZqW34tSyDwLVmEoJjNHMdZpIrOb71Jmk3FZVkPooL3djSNsfx1E/6l2BIwkC0lscHpk6RjWukYgVBukbe0wUoJkRV3Sm0MOza/lYzTVLkiVs5KB2+ogTadPyMwUSn4Q9bZSCI9W89+oYal007hbFppjmChwr7RFugNXk=
Received: from CY5PR19CA0034.namprd19.prod.outlook.com (2603:10b6:930:1a::13)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 1 Sep
 2023 06:11:54 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::86) by CY5PR19CA0034.outlook.office365.com
 (2603:10b6:930:1a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26 via Frontend
 Transport; Fri, 1 Sep 2023 06:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 06:11:53 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:11:51 -0500
Message-ID: <3e04a33d-8c19-2a9a-0524-91522691cd95@amd.com>
Date: Fri, 1 Sep 2023 08:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 5/6] net: zynq: Use generic_phy_valid() helper
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, Marek
 Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
 <20230831221629.1027552-6-jonas@kwiboo.se>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230831221629.1027552-6-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: ed145f51-d81c-464b-0a23-08dbaab2567c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ha9PM6M1G0nAswOQUExAF9QSBtyhFKosw2CLzrMwgQzA1354OjjTVVw2fada8Kk0LFn9D7/1+Bi84UqTd75jFC9G6HY8w3f9qhT1PI9iJD2hU42vljk0F925eAQ9M4s675nZCPwXTIacniFNaGPPK2mY4G4y52y/ArfaoRRbDL0pzp7FC7cTH67EodRJ8iajj+RK1ADnPHSqMb0PPPHf6OcK/z6XFezbNaYgDdGCB/1lk9NnWHfBz4lcZJK1lVAAmTQ54ahwfgZN6t+1/3LTDa+8QNZJYWIZDd5701wOd9tm81gZv+dD8jRZzZfjVaQYMxVGzDaRT4W/7BTr3yKuokfod8SiMU2uSwCZzrixc7cd/dc9GHCMNPtmeCejzaWra/CQeqqsfFcVWKO9SFuCHOjGNza4sLjsO4mHsoWMDrQB+6sErNkS8HlCgx1BT9RmPotbdDuZjO1NcEixO2WH1ncA7BPKP4ftR3HMqVXiDabyOyhhIkyciKr2s//Y9oye/ZyDr9QzIsO3WYEquSfqhXq9EzlfkHRTx3qqxMvRR3yNXWz72MCrlavfG1HMUHxMQ/yg7uo3rlzYcwvrdVBwNIOBZf05jbNGFRqZm7YDa19iGKsvGh/gFim2vIEI+aKTaiNg+k/WvDaPsf7dBM1UgSK2X5SAAgGV3dDveZhJSL3aYiG/UoPS7ytztxFmZAHYjBKRwvXOU2waU4XjsXWgYhSA6Y0x85VThbMkIImiAhfpEuEA/fL4Lnk7vLuXNiy1Os4pAVg8WGtMJQBeuqMB2afrrOkWSoNXi3awDz4YmP9AbaUW7ugWLwNuZwLwRO1cuiczbe/vCobzlTLn/A8UnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(31686004)(82740400003)(356005)(40460700003)(36756003)(81166007)(86362001)(31696002)(40480700001)(47076005)(36860700001)(2616005)(2906002)(336012)(426003)(26005)(16526019)(53546011)(83380400001)(478600001)(110136005)(4326008)(70206006)(8676002)(70586007)(5660300002)(41300700001)(16576012)(44832011)(316002)(8936002)(41533002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 06:11:53.3989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed145f51-d81c-464b-0a23-08dbaab2567c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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



On 9/1/23 00:16, Jonas Karlman wrote:
> The documentation for struct phy state that "The content of the
> structure is managed solely by the PHY API and PHY drivers".
> 
> Change to use the generic_phy_valid() helper to check if phy is valid.
> 
> Fixes: 10c50b1facbf ("net: zynq: Add support for PHY configuration in SGMII mode")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/net/zynq_gem.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
> index f3cdfb0275d0..3377e669f2f6 100644
> --- a/drivers/net/zynq_gem.c
> +++ b/drivers/net/zynq_gem.c
> @@ -890,7 +890,8 @@ static int zynq_gem_probe(struct udevice *dev)
>   	if (ret)
>   		goto err3;
>   
> -	if (priv->interface == PHY_INTERFACE_MODE_SGMII && phy.dev) {
> +	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
> +	    generic_phy_valid(&phy)) {
>   		if (IS_ENABLED(CONFIG_DM_ETH_PHY)) {
>   			if (device_is_compatible(dev, "cdns,zynqmp-gem") ||
>   			    device_is_compatible(dev, "xlnx,zynqmp-gem")) {

Applied.
M
