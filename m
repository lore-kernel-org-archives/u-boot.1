Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09E9F33806
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 07:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F7A84067;
	Tue, 17 Mar 2026 08:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u9LdG84W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417068407D; Tue, 17 Mar 2026 08:03:02 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C877A84056
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oa6tLJuvlksH6+e1fr9W5hGNx2UmsYTdjStykPfPLA7zqYISbBtrLJHmD7oQJtc5T102rbLU8YBUOehMINo1YhhBNGINc0Yjwcr+1lPtuyN9QsdSN62aKyrNFcaCejLg5FMuEY28AU2rzfZsIbdjGkHlf8Wsj0+iTDGMskgWdiUlz9NcJCyF2TbpV2LfjfHUpfhvblUhbTrHZphEi1bnmBZYQHDi1rh49qrG9p2tebO/RIvc+rjHEat0kphiOwqDc8rmU3tnYtBKNfcGSMfXkc58FgzV1V0Brl/i0Y1g3r4uLl5QkBl9Z9Jq/W2diOZEwMErqULSNBJKlXg0XzWxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj2DqJYZDZlw6+kCRkXOdRH78bixbFGR1DbKse5yCKs=;
 b=EGExbYKhCaGsyL+V0ubavCCzdO6CBNk+GbD9wsr3r/glS7/wC2tMqfTnzZK+oux0bmiQXMxfnp8VyP0IjjW6Kq0TbB1v5erE9b7Xs05ns/ZuEyz+HBuWl/hEhe/Ny14uL2d+kCJYoQj+2TVF2MKXvq25y0BcQzF/OkFYh4KgtoaII3R6KKOixQg/tBbPfG7sBAh7yCyDE67qkXxTAOmslZhuTXAw3B2wXcafnBSxc5Xqc7Ki+ksMnt6GH7iaIIEsxjwB1hkxs1JSM1bt71HUucSXo5qNI+RVWwRRKDmYQOXwE+tK0qLbg4wSjCxmygOELDN++vJVRas6FXvDQdpYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj2DqJYZDZlw6+kCRkXOdRH78bixbFGR1DbKse5yCKs=;
 b=u9LdG84WuQBBy6Cl0RrjMLrQnnNghbLrkc1o7tSgCamKbyhMrgAQ/FXgzLpJ2pKAs+iMqbG9ks5S0fQ53SMb7OuSY4cOYq0TRTm/FACMCj4d0vpy4wRqVESBpuZ4STMsr4KXvlQKW6OT6cuxz1FrkFEWX01K6lLdzqWdDT5vgEI=
Received: from CH0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:b0::6)
 by CO6PR10MB5553.namprd10.prod.outlook.com (2603:10b6:303:140::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 07:02:54 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::91) by CH0PR03CA0001.outlook.office365.com
 (2603:10b6:610:b0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 07:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:02:53 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 02:02:53 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 02:02:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 02:02:53 -0500
Received: from [172.24.25.125] (ltpw0g6znt.dhcp.ti.com [172.24.25.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62H72lJx2235873;
 Tue, 17 Mar 2026 02:02:48 -0500
Message-ID: <1a171586-0ced-471b-b26f-88486718a691@ti.com>
Date: Tue, 17 Mar 2026 12:32:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] misc: fw_loader: implement request_firmware_size()
 OP
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>,
 "Paul Kocialkowski" <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>,
 "Justin Klaassen" <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 "Jamie Gibbons" <jamie.gibbons@microchip.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Lucien.Jheng <lucienzx159@gmail.com>,
 "Alif Zakuan Yuslaimi" <alif.zakuan.yuslaimi@altera.com>, Sky Huang
 <SkyLake.Huang@mediatek.com>, <u-boot@lists.denx.de>
References: <20260306190542.22920-1-ansuelsmth@gmail.com>
 <20260306190542.22920-6-ansuelsmth@gmail.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260306190542.22920-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|CO6PR10MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7edde1-e9cc-4687-5036-08de83f33616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: H0D7nmwZOcp4vH4xgKokmArpOYKiD669piF3KaFiCJHLPzIshtqh2aXHxoLqrFa0MiddRTxYWPEDHK4PmlTG/NA5HUMBZX8+hUnSa/F68UP1La/Fpfo8qMdty/j/Jn6hG+tqXS6NHQrpZC6xa2GKkUzxkSv6WrB6Xxpx+pCvHxJZmnSxGIn+RaCxERqOg6sukCHNrAXgXET8Fym0g77I5RQWRelv6DJwPtPQEJGaOBt9WjopddEaYykDMbay0VQG4Ewn9oAwv7nyT5oWDjEs+3nqvjs/tA/lWDXtpHdc6u09M5oS64/wOqOdm0Ap8xFCU+1ES9nlCbamLiSnxNnXGWQBCQw/bCH64U5djv+HdLvC0JBek++a6mlQmBT45nCf7i2v1yoinKbS5VXZtR1T/KSq1UfKTGo9+s/7/Add/DcAXuHIl9LznlnfK72zubhIbPWNvwcm/qtkUVy/WF1X2Ft1+4BLkqThHDTqkzg4NCOboY6dyNrqZRV6IBaWtM5XAZB9YLGOOe0J4jjaeEP/Lh82HIrdUWTSL4cWj/JOYEXDyz/eMR03Ft+wezNTN8MStxw/e0Gr2AY0jmhyDTOfmgCQFxZQDYO0ATTKFw8+xgVr0RLP8IMsfdTsSs1cS8hEeo367OHCfTbISScaCKfGOYnY1n2OW/aKG/+IlPqu+Na0rr3BMGbWYMViHS+b8Loaqxkc2VaikWkomvzAl5CsvsTseMj8ZtwdBgu0sA+Oi/IjbXbzJu6O5z3QoqPJsHuJT9NRqanwkgi6FUojsGMxDAiuUDlpQw9Cr9rToIBptZE9OPntmxjd5Qcw3VJuadqE
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DVxEIyFxTMBnyiJAQ2Qmoaq03qMLrMmOH9lH4KpP2VhA83/+VQjsy1J1slu8ImWPaMpI6oxcn86eiELLDfW8+iBd6TgCACQynIqQwsoeA/fgTK80SsijYVET0SIOzjd0oOYwGgtdEfq56nsguInnGIbgP/YVqYKcuZcvAfWw6hjmrglAW2YXKZUje6f2kB+LdmJ177SiJZjMDMRSFLsEJDyaRzYboLfgR8FnU4aDCtu+J+hPVdlbBnboeHHntkZLMCuSSX78inNunvFgx5488gHHJifJaKggATsLEeA8vCNJpt6FdPc3C+nvUCjMeJZqh2osp60eub67VWSkqgYjwyBFMNJHAM5cCHwykQFWutnLLptFH7IoVCI63fV9jYZmujgqQatYvMJ0wGlwiwA3eYhEunSS11PlUJRmbWJuBLXUID9QBCsYXS0rw7KeuB2K
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:02:53.9995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7edde1-e9cc-4687-5036-08de83f33616
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
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

On 3/7/2026 12:35 AM, Christian Marangi wrote:
> It might be useful to get the firmware size before reading it to allocate the
> correct size. This is needed for case where the firmware size change across
> different firmware version and is not always the same. In such case the only way
> to handle this scenario is to allocate a big-enough buffer to read the firmware.
> 
> To better handle this, introduce the request_firmware_size() OP to get the
> firmware size before reading it. This way proper buffer can be allocated and
> dynamic firmware size can be better supported.
> 
> Both FS and FIP lodaer are updated to handle the new .get_size() handler.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/misc/fw_loader/fip_loader.c | 35 +++++++++++++++
>  drivers/misc/fw_loader/fs_loader.c  | 70 ++++++++++++++++++++++++-----
>  drivers/misc/fw_loader/fw_loader.c  | 20 +++++++++
>  drivers/misc/fw_loader/internal.h   |  1 +
>  include/fw_loader.h                 |  9 ++++
>  5 files changed, 124 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> index 376e1d2a59d8..a285f785db37 100644
> --- a/drivers/misc/fw_loader/fip_loader.c
> +++ b/drivers/misc/fw_loader/fip_loader.c
> @@ -523,6 +523,40 @@ out:
>  	return ret;
>  }
>  
> +/**
> + * fw_get_fip_firmware_size - get firmware size.
> + * @dev: An instance of a driver.
> + *
> + * Return: Size of firmware, negative value when error.
> + */
> +static int fw_get_fip_firmware_size(struct udevice *dev)
> +{
> +	struct fip_toc_entry ent;
> +	struct fip_storage_info info = { };
> +	int ret;
> +
> +	ret = fw_parse_storage_info(dev, &info);
> +	if (ret)
> +		goto out;
> +
> +	struct firmware *firmwarep = dev_get_priv(dev);
> +
> +	if (!firmwarep) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = parse_fip_firmware(firmwarep, &info, &ent);
> +	if (ret)
> +		goto out;
> +
> +	ret = ent.size;
> +
> +out:
> +	fw_storage_info_release(dev, &info);
> +	return ret;
> +}
> +
>  static int fip_loader_probe(struct udevice *dev)
>  {
>  	struct device_plat *plat = dev_get_plat(dev);
> @@ -533,6 +567,7 @@ static int fip_loader_probe(struct udevice *dev)
>  		return ret;
>  
>  	plat->get_firmware = fw_get_fip_firmware;
> +	plat->get_size = fw_get_fip_firmware_size;
>  
>  	return 0;
>  };
> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> index 4ae01b9c8f0d..d6b9f4998815 100644
> --- a/drivers/misc/fw_loader/fs_loader.c
> +++ b/drivers/misc/fw_loader/fs_loader.c
> @@ -93,15 +93,8 @@ static int select_fs_dev(struct device_plat *plat)
>  	return ret;
>  }
>  
> -/**
> - * fw_get_filesystem_firmware - load firmware into an allocated buffer.
> - * @dev: An instance of a driver.
> - *
> - * Return: Size of total read, negative value when error.
> - */
> -static int fw_get_filesystem_firmware(struct udevice *dev)
> +static int __fw_get_filesystem_firmware_prepare(struct udevice *dev)
>  {
> -	loff_t actread = 0;
>  	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
>  	int ret;
>  
> @@ -126,6 +119,28 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
>  		ret = select_fs_dev(dev_get_plat(dev));
>  	}
>  
> +	return ret;
> +}
> +
> +static void __fw_get_filesystem_firmware_release(struct udevice *dev)
> +{
> +#ifdef CONFIG_CMD_UBIFS
> +	umount_ubifs();
> +#endif
> +}
> +
> +/**
> + * fw_get_filesystem_firmware - load firmware into an allocated buffer.
> + * @dev: An instance of a driver.
> + *
> + * Return: Size of total read, negative value when error.
> + */
> +static int fw_get_filesystem_firmware(struct udevice *dev)
> +{
> +	loff_t actread = 0;
> +	int ret;
> +
> +	ret = __fw_get_filesystem_firmware_prepare(dev);
>  	if (ret)
>  		goto out;
>  
> @@ -147,9 +162,41 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
>  	}
>  
>  out:
> -#ifdef CONFIG_CMD_UBIFS
> -	umount_ubifs();
> -#endif
> +	__fw_get_filesystem_firmware_release(dev);
> +	return ret;
> +}
> +
> +/**
> + * fw_get_filesystem_firmware_size - get firmware size.
> + * @dev: An instance of a driver.
> + *
> + * Return: Size of firmware, negative value when error.
> + */
> +static int fw_get_filesystem_firmware_size(struct udevice *dev)
> +{
> +	loff_t size = 0;
> +	int ret;
> +
> +	ret = __fw_get_filesystem_firmware_prepare(dev);
> +	if (ret)
> +		goto out;
> +
> +	struct firmware *firmwarep = dev_get_priv(dev);
> +
> +	if (!firmwarep)
> +		return -ENOMEM;

goto out?

> +
> +	ret = fs_size(firmwarep->name, &size);
> +
> +	if (ret) {
> +		debug("Error: %d Failed to get size for %s.\n",
> +		      ret, firmwarep->name);
> +	} else {
> +		ret = size;
> +	}
> +
> +out:
> +	__fw_get_filesystem_firmware_release(dev);
>  	return ret;
>  }
>  
> @@ -163,6 +210,7 @@ static int fs_loader_probe(struct udevice *dev)
>  		return ret;
>  
>  	plat->get_firmware = fw_get_filesystem_firmware;
> +	plat->get_size = fw_get_filesystem_firmware_size;
>  
>  	return 0;
>  };
> diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
> index d2446fdc07da..d5973fce4b9c 100644
> --- a/drivers/misc/fw_loader/fw_loader.c
> +++ b/drivers/misc/fw_loader/fw_loader.c
> @@ -162,3 +162,23 @@ int request_firmware_into_buf(struct udevice *dev,
>  
>  	return plat->get_firmware(dev);
>  }
> +
> +int request_firmware_size(struct udevice *dev, const char *name)
> +{
> +	struct device_plat *plat;
> +	int ret;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	ret = _request_firmware_prepare(dev, name, NULL, 0, 0);
> +	if (ret < 0) /* error */
> +		return ret;
> +
> +	plat = dev_get_plat(dev);
> +
> +	if (!plat->get_size)
> +		return -EOPNOTSUPP;
> +
> +	return plat->get_size(dev);
> +}
> diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> index 5513e043925f..4701b494bf3f 100644
> --- a/drivers/misc/fw_loader/internal.h
> +++ b/drivers/misc/fw_loader/internal.h
> @@ -36,6 +36,7 @@ struct device_plat {
>  	char *ubivol;
>  
>  	int (*get_firmware)(struct udevice *dev);
> +	int (*get_size)(struct udevice *dev);
>  };
>  
>  /**
> diff --git a/include/fw_loader.h b/include/fw_loader.h
> index 7053c7bc6f05..1af3db385161 100644
> --- a/include/fw_loader.h
> +++ b/include/fw_loader.h
> @@ -39,6 +39,15 @@ int request_firmware_into_buf(struct udevice *dev,
>  			      const char *name,
>  			      void *buf, size_t size, u32 offset);
>  
> +/**
> + * request_firmware_size - Get firmware size.
> + * @dev: An instance of a driver.
> + * @name: Name of firmware file.
> + *
> + * Return: Size of firmware, negative value when error.
> + */
> +int request_firmware_size(struct udevice *dev, const char *name);
> +
>  /**
>   * request_firmware_into_buf_via_script() -
>   * Load firmware using a U-Boot script and copy to buffer

Thanks for this series. I think this starts to pave the way for us to move away
from using vendor specific drivers scattered around (like
arch/arm/mach-k3/r5/sysfw-loader.c) and eventually come into fw_loader.

-- 
Thanking You
Neha Malcom Francis

