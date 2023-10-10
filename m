Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4022DCD80D1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D47C86B54;
	Tue, 10 Oct 2023 15:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/Xqij9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB4886B05; Tue, 10 Oct 2023 15:27:42 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74604868C1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 15:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYjQ282OrBs99Dmlg6HWbc/QJssvspLn2i4kYQzhiHZYhJakbtKoZm+zr48UELxn63L+gglH3AOT5XBVamqusZo+u51JCd26QFHaUuqycLcqeTgFx6iDfnGF/HrNq+Mm207e8tgADGfe1uPY6c+OLMFTV9Q894TceTGx4Dvak/L8ZvMrDJHaLD4DmfTPf+cPKEU2JERxsGFVw8ZQTp2DUH+S41zQRlLUi03d8RvDj7NC8ZT+qkNatwQvfmKGv+JDXYDzdfCJyE6/tk6PWu/Fg0gYO0VISSkJoqjztTVjklBAWKqoRWyIAk2hXTPK9wRk6oXf95YD28I9/S2gZQddMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO+4jPmuUiAwBOF4cDQwlShFA+G8UEwktmt8xQJKeOc=;
 b=KrH3qyrSCVcYtl76w4cBmeC8w9Ygrq1xSqMbptCePJwdRvVQA9IkXIy7azdNf98e5tV8KwORYI3ncEIWkjRg6kuaGbgojyjR+fuQ3Gwyqjvc2QNmsiDYDxiwNZ2xuRj90lxs1awI+k5Hq+7h1P1RIouxDWOTpQ/CuLCjRgMkKGCQXS9krpmAghe2q6ZLPPDBYYWuTSAhRoQgKNjG/Nq8mW6AgbFk5Zgihm3IBTluS6SUQzgZUYoiI2L2KsjRiknJ0dOMsS51p49ytCg/Bdav756QbV2Tvvl/lTo3oGCFrjua7Q7ngjXy9VTiZG8lbq+DY/WTQlliqZU2Peb0Xr3U5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO+4jPmuUiAwBOF4cDQwlShFA+G8UEwktmt8xQJKeOc=;
 b=n/Xqij9kaaqqxewIHOGsbz7bVf0Ivp0Yhgy3iwaTJmaMKAl7m/1J3uimf+qNQgf1wRMXfEPiuHULF6WjEedkIcMCqc2HkLJ/tT1O0A3j5PvkgytjXs34U8KWMGfINXb4446SS57VyitPDEExhvgNHKIKMsrEJIwQmx/112YHLlw=
Received: from BL0PR02CA0134.namprd02.prod.outlook.com (2603:10b6:208:35::39)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 13:27:32 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::62) by BL0PR02CA0134.outlook.office365.com
 (2603:10b6:208:35::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 13:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 13:27:32 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 08:27:30 -0500
Message-ID: <cdb54dfb-a83d-4800-a036-4e139faf9f0b@amd.com>
Date: Tue, 10 Oct 2023 15:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: xilinx_phy: Get rid of using property
 xlnx,phy-type
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <git@xilinx.com>
References: <20231010030436.11854-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231010030436.11854-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 7976cc83-08dd-444b-93ff-08dbc994a868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGzxUcgyZveuYf+TnzfzpTuvb0OHgFTL09SRmGOBTDBYdGAS+zCinQBL4n1oQae1FFJ+AeDNgqFSoxVPMYc39IKekAC8PwOcYOfi158q/syIz+4hBYD/HSPM+8rg8vn4SLgwSg0JPjPOwVb1RylnkAQSNzw7kw7BR6T9uem8NngX0HEPp1KKrVG1oWKb8kEr528bGDT6AaQHadtgOV/1jwLSVxLKU2fkHvhEBKcDO6KPR/kYxcQa9Fp6FM0fSntxPgrxHLoV83sd2Z+z2LSfPt454woH9iQe88DJkvXERgAmNqyn84/fpUn9E89k+3VVifpOwOHKOSgCHXrz3pmvsoUYzIvWeYXwtqUvWMUQh9JL8y91glK4hmhn4yi/WnAQbD1xcnJNdmLBNPN04e3ZZTU6nBcU5rgknTMsu/9Yd2O3nFq/qgMuaXzQNtAcmjMP3cKXESIcvPA6C0u2YXX/yMuits38f6QIOP5UZYW/nbjiPQCjH0MfaQo8ScNZO39jXKOWLMmJP8iZgjX4JinNUoI02flMR0+EDvnWB6DDbKZMDRKZZzwIPXwhlSoauPpq5EmnF4VqlnmqI2cmoV1wms6k+lhRWpxxwxM5tUxj8SUCHeqJ9Q9GMs/w4L5rcMTYgk0CHYVdhuKzk0sG/yCvIrI1WAtW8XNd8UbjcbnWYM6h9PUawAhNO7mKbUDySwTQWS9sndhbXAgP5wCY1X2nnBTjwPaJe5b6NEdjdHoiqQmWePPnEArO8jDoxqVEw3htFq89P9GBui/4EtNPyF78QmT3OapOd2/docSpQJFDapD65sXOYVrnGuSjuOZB1l+jfWLltrA2k1cJX3fnObMgJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(31686004)(2616005)(426003)(336012)(26005)(16526019)(53546011)(5660300002)(81166007)(40480700001)(40460700003)(356005)(86362001)(36756003)(31696002)(82740400003)(8676002)(83380400001)(107886003)(4326008)(2906002)(8936002)(36860700001)(47076005)(478600001)(54906003)(41300700001)(44832011)(316002)(16576012)(70206006)(70586007)(110136005)(26583001)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:27:32.0357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7976cc83-08dd-444b-93ff-08dbc994a868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
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



On 10/10/23 05:04, Venkatesh Yadav Abbarapu wrote:
> As the xlnx,phy-type device tree property is deprecated and phy-mode
> is being used, so removing the code references of xlnx,phy-type.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Removed phytype variable.
> ---
>   drivers/net/phy/xilinx_phy.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/phy/xilinx_phy.c b/drivers/net/phy/xilinx_phy.c
> index 1df639d6f4..c07c780193 100644
> --- a/drivers/net/phy/xilinx_phy.c
> +++ b/drivers/net/phy/xilinx_phy.c
> @@ -99,7 +99,6 @@ static int xilinxphy_startup(struct phy_device *phydev)
>   
>   static int xilinxphy_of_init(struct phy_device *phydev)
>   {
> -	u32 phytype;
>   	ofnode node;
>   
>   	debug("%s\n", __func__);
> @@ -107,10 +106,6 @@ static int xilinxphy_of_init(struct phy_device *phydev)
>   	if (!ofnode_valid(node))
>   		return -EINVAL;
>   
> -	phytype = ofnode_read_u32_default(node, "xlnx,phy-type", -1);
> -	if (phytype == XAE_PHY_TYPE_1000BASE_X)
> -		phydev->flags |= XAE_PHY_TYPE_1000BASE_X;
> -
>   	return 0;
>   }
>   

Applied.
M
