Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FD6CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4492686564;
	Fri,  1 Sep 2023 09:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nCQlQpbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F6C866AA; Fri,  1 Sep 2023 09:05:13 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCA881970
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIU9bTJb9HRiUCR74er1fqm/shszqNMfdiHkpAkVG97agfjYzVkm0lHTiHHkPSEp4F+VrZGshwOcQKBtUBLGyCq9yBIczJXAFWO51D93coqjXjkvaGNDMZL6bzMjrmaPgEOxSPqgpdTMcyt00lJ0VwhRiniILZFWpl9gj5Zn1XeX2Tl/wWdmpfpeMy7OJvbaCDyVxEMlpFa7xEk6yddeN7u872yrLtYQG8YNy7Kk+JpybwbT2h2MuuVfym16C97vshAgO8RCGh3VvIdZTGQsf9INtQ6a5t5Durptg9edW6fQ9VUqzbMCDQvUjeQV/TaYX8CeSZXDL70QaamI9DUk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht8zMvHMtNU2cOGUIyEtp+DkqQn3nGAEc0xNubKQ9+E=;
 b=Ilvu/q8AI7Vv56L7Fz40jiYVb0/pd8GPGd0Bj8yGkFRhPIQcs6wimp8mxSGkc0ySuX40eWNNGTXMyGMKdw0QmTxa5RkJvySshKcy4xlZIFEX8PUy5ceGGJ59XNKUomfRi2FpM0s8aEGTEF1Q2uCm+l8hdsQC1DeKluPrsVNAD0m58kN0ODUP7ko2CR+LuEXJBSThjzetl0pUeFvlg5d/W8rmVOBEVvhQJHorqYZtgPD/tzRjrP1UKdKTIXSlffscj6+tFrrgNdApZ155bTsip07ySoGBH9OWToAoc6vMIYItzvy3yBBJpTdPRy0UxtTXK8L14PQD0Ci3cUWa6CSCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=inbox.ru smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht8zMvHMtNU2cOGUIyEtp+DkqQn3nGAEc0xNubKQ9+E=;
 b=nCQlQpbGPXS0UiIAdOF+RT/6mY0Dl2a7sOC5bsjIDGrcRzP55xK93+OpUaROSkU5p/MOmA7Sjh7U09UOz8OWwinxOwMKs07g/P/RuyZ7ED61WRI2KTn1DAVW0xf79M8h0tVjcYBtPJe2BLjOs0c3IadYqbsNZLwX67le+ufZduk=
Received: from MN2PR12CA0026.namprd12.prod.outlook.com (2603:10b6:208:a8::39)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 07:05:07 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:a8:cafe::e2) by MN2PR12CA0026.outlook.office365.com
 (2603:10b6:208:a8::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Fri, 1 Sep 2023 07:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 07:05:07 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 02:04:46 -0500
Message-ID: <0b3ef1c8-b49e-bf63-4f2b-bffb530a92e0@amd.com>
Date: Fri, 1 Sep 2023 09:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] net: axi_emac: Convert to ofnode functions
Content-Language: en-US
To: Maxim Kochetkov <fido_max@inbox.ru>, <u-boot@lists.denx.de>
CC: <rfried.dev@gmail.com>, <joe.hershberger@ni.com>, <bigunclemax@gmail.com>
References: <20230811074351.26916-1-fido_max@inbox.ru>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230811074351.26916-1-fido_max@inbox.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb74a50-1a1f-4509-3868-08dbaab9c617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYQLhPxi69j61QcO7U3XvRl63LNU4ev3j1+F8mj6Ee0AqTPC20L2qes08CCfAYDhA/yHVfAwmqtPlwRTelxOTK6ySBpM/scMjh+samJ09R5tRapn775vjioTOZZkWhzh5zH0U6tcNEoYIx3X81n39P+gXjY/wcWhr2q/2jS57E+2fqehBp9+dcToJfchSeuzTXqM0RdBwK1wm6Q8raHTC6kseTDdJygJZyW7Fir3Yc0gZRtl6p3JMIYz4KzJ33jv6hhm9+95itVdhAQOzWHSGeEaEYcDxYnDj/3zbo8SpzIyHGGEfuhpx0ODt6z2cISkObBLcCqrlJysW3Kl3G+dTBZLFkn0H3CggTcnOtItjFKaxAbxZZiqrsBL166+03EE5zilfEHXzDrgXt5AmJRVJOhw0D0VR0+8/wAO5uMLt8Cguehnogqrbn2f/Z+J3IOfky7Km0b0DBRAkaewTxhXEuRCI7tr3THtX7vy3g5CNNWfZDxjFc3li+fH6DHD331v5zqaqdjGwK5R/H3tjsc45uBMeOhWh2/8AXBU9RJE8rQptYGhOe6IAkZXyBLqLqn56XthCu/rbYstbx7BvX6iV43lGAQS1DG3F9AdbSLuWLI8RqJXcaAFeVIlaUnoJWk0IC3HOK9HIacW8OtnoVNc9PvJHB6s2gT400q4vmCRjnfSiSCKb1MO7Fm9pAHhEgHlGYa85HUE1hXeRfb7YoqI1+V9wZ6JrgIOyr1olvJ4XqELwg03T58lqCT5c+zwv4RV8a/D/L6ZWymwVrCD7WDqBJjpKSa+z84jtgwb9LqLG9JGTEW8nMdcJDCLC09fLOkM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(2906002)(16576012)(316002)(41300700001)(5660300002)(44832011)(40460700003)(8676002)(4326008)(8936002)(36756003)(31696002)(86362001)(356005)(31686004)(81166007)(478600001)(82740400003)(2616005)(426003)(336012)(83380400001)(26005)(16526019)(53546011)(70586007)(70206006)(36860700001)(110136005)(47076005)(54906003)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 07:05:07.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb74a50-1a1f-4509-3868-08dbaab9c617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
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



On 8/11/23 09:43, Maxim Kochetkov wrote:
> FDT functions is not working when OF_LIVE is enabled.
> Convert fdt parsing functions to ofnode parsing functions.
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>   drivers/net/xilinx_axi_emac.c | 50 +++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index 39cb3cc260..54f2232768 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -112,7 +112,7 @@ struct axidma_plat {
>   	int pcsaddr;
>   	int phyaddr;
>   	u8 eth_hasnobuf;
> -	int phy_of_handle;
> +	ofnode phynode;
>   	enum emac_variant mactype;
>   };
>   
> @@ -127,7 +127,7 @@ struct axidma_priv {
>   	struct phy_device *phydev;
>   	struct mii_dev *bus;
>   	u8 eth_hasnobuf;
> -	int phy_of_handle;
> +	ofnode phynode;
>   	enum emac_variant mactype;
>   };
>   
> @@ -335,8 +335,8 @@ static int axiemac_phy_init(struct udevice *dev)
>   	phydev->supported &= supported;
>   	phydev->advertising = phydev->supported;
>   	priv->phydev = phydev;
> -	if (priv->phy_of_handle)
> -		priv->phydev->node = offset_to_ofnode(priv->phy_of_handle);
> +	if (ofnode_valid(priv->phynode))
> +		priv->phydev->node = priv->phynode;
>   	phy_config(phydev);
>   
>   	return 0;
> @@ -839,7 +839,7 @@ static int axi_emac_probe(struct udevice *dev)
>   		priv->eth_hasnobuf = plat->eth_hasnobuf;
>   		priv->pcsaddr = plat->pcsaddr;
>   		priv->phyaddr = plat->phyaddr;
> -		priv->phy_of_handle = plat->phy_of_handle;
> +		priv->phynode = plat->phynode;
>   		priv->interface = pdata->phy_interface;
>   
>   		if (IS_ENABLED(CONFIG_DM_ETH_PHY))
> @@ -894,20 +894,21 @@ static int axi_emac_of_to_plat(struct udevice *dev)
>   {
>   	struct axidma_plat *plat = dev_get_plat(dev);
>   	struct eth_pdata *pdata = &plat->eth_pdata;
> -	int node = dev_of_offset(dev);
> -	int offset = 0;
> +	struct ofnode_phandle_args pcs_node, axistream_node;
> +	ofnode phynode;
> +	int ret;
>   
>   	pdata->iobase = dev_read_addr(dev);
>   	plat->mactype = dev_get_driver_data(dev);
>   
> -	offset = fdtdec_lookup_phandle(gd->fdt_blob, node,
> -				       "axistream-connected");
> -	if (offset <= 0) {
> +	ret = dev_read_phandle_with_args(dev, "axistream-connected", NULL, 0, 0,
> +					 &axistream_node);
> +	if (ret) {
>   		printf("%s: axistream is not found\n", __func__);
>   		return -EINVAL;
>   	}
> -	plat->dmatx = (struct axidma_reg *)fdtdec_get_addr_size_auto_parent
> -		      (gd->fdt_blob, 0, offset, "reg", 0, NULL, false);
> +
> +	plat->dmatx = (struct axidma_reg *)ofnode_get_addr(axistream_node.node);
>   	if (!plat->dmatx) {
>   		printf("%s: axi_dma register space not found\n", __func__);
>   		return -EINVAL;
> @@ -918,30 +919,27 @@ static int axi_emac_of_to_plat(struct udevice *dev)
>   		/* PHYAD 0 always redirects to the PCS/PMA PHY */
>   		plat->pcsaddr = 0;
>   
> -		offset = fdtdec_lookup_phandle(gd->fdt_blob, node,
> -					       "phy-handle");
> -		if (offset > 0) {
> +		phynode = dev_get_phy_node(dev);
> +		if (ofnode_valid(phynode)) {
>   			if (!(IS_ENABLED(CONFIG_DM_ETH_PHY)))
> -				plat->phyaddr = fdtdec_get_int(gd->fdt_blob,
> -							       offset,
> -							       "reg", -1);
> -			plat->phy_of_handle = offset;
> +				plat->phyaddr = ofnode_read_u32_default(phynode,
> +									"reg", -1);
> +			plat->phynode = phynode;
>   		}
>   
>   		pdata->phy_interface = dev_read_phy_mode(dev);
>   		if (pdata->phy_interface == PHY_INTERFACE_MODE_NA)
>   			return -EINVAL;
>   
> -		plat->eth_hasnobuf = fdtdec_get_bool(gd->fdt_blob, node,
> -						     "xlnx,eth-hasnobuf");
> +		plat->eth_hasnobuf = dev_read_bool(dev, "xlnx,eth-hasnobuf");
>   
>   		if (pdata->phy_interface == PHY_INTERFACE_MODE_SGMII ||
>   		    pdata->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
> -			offset = fdtdec_lookup_phandle(gd->fdt_blob, node,
> -						       "pcs-handle");
> -			if (offset > 0) {
> -				plat->pcsaddr = fdtdec_get_int(gd->fdt_blob,
> -							       offset, "reg", -1);
> +			ret = dev_read_phandle_with_args(dev, "pcs-handle", NULL, 0, 0,
> +							 &pcs_node);
> +			if (!ret) {
> +				plat->pcsaddr = ofnode_read_u32_default(pcs_node.node,
> +									"reg", -1);
>   			}
>   		}
>   	}

Applied.
M
