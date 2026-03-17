Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400E4F33800
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 06:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67AC83DB6;
	Tue, 17 Mar 2026 07:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tR+s7Gmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E5883F6D; Tue, 17 Mar 2026 07:18:51 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2BB839DF
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0Bxe2tFbmUJVa8ISapAoy6PFbHVCQd0G+afmUKRDAkl/mN2enc9Nt0jQCJ2hGsgAW0+LSNPJx9svOzHuOZDuRE4K/gT/+DUXHZvGapHD9i5Nu+SzLHqE0K5QnxJ2jbb4MHzVCdMnRV7GZqL8uRBdqVwVrO9ZCkrg5u5uRgbLCvEnY99kv2wuNcjw3yGazV2q039o73xT1vqlTaPx7CHQwoNNrQCaVlNhrIYcBwXe05KjzYecCaWQuOrBIcmVWzdZXTyN2UHNRlXlhQc9D37XQ5m1BLAmcl92FU717jm2FEAVsIPC3ZmQqeAWY2t6XKJbxjPQHYrJz8F9ufHAD3tSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2lzvqG5Yo0jLLr8sEwLwdaG7Tmeq2iYRgi5nlJ6E1g=;
 b=ycTyrU4igmKO2mNfskM++jVih6DLvrg3I3H66f4DCAso3bVTxdMjpQa3k6HxlT8eEBKmwSma54zxJZxNkSc4+TAX4SRpfmoeuyDSl2g63tXwXS1VD1lnh84YaLoMp6Yd+wjfdVl9Rqa4of4yoRHE1c4sNKVR20Gdi3K7UtOr5kLGFSenAsJOokkmc88SrVfdzH13vS6RUHKmceN3NjVey8P657SAx32UVW+vLz8wOkJCQk/1KzCZ/VLwMoQFlIaG1vCENqglDe060Ko6sLJshBGJ0RojyGDYK9OFCFXntmR3bwgmEsRlMluUHFrSZJBkeO2SxiFi4QDEV8h3Wvvc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2lzvqG5Yo0jLLr8sEwLwdaG7Tmeq2iYRgi5nlJ6E1g=;
 b=tR+s7GmwbIVkvsmEY8h1vcYIKhoNpgfPYKb6C2POC4Ag7gsFkOAEmUyc7ivDKUFDuOKr86IKoFcdU9cxxs8LlXcUXwA3uBWaFghwNePaO3aCQoOjfPfD4Unn1FaC0XZjayj3AgnvfDJCa4rwjfCh5tXLHfv7wB1jOL9mNd3Mlvk=
Received: from BY3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:39a::8)
 by SJ5PPFE654FA166.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7da) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 06:18:47 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::33) by BY3PR03CA0003.outlook.office365.com
 (2603:10b6:a03:39a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 06:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 06:18:45 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 01:18:42 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 01:18:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 01:18:42 -0500
Received: from [172.24.25.125] (ltpw0g6znt.dhcp.ti.com [172.24.25.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62H6Ib5e2168508;
 Tue, 17 Mar 2026 01:18:37 -0500
Message-ID: <17bd4570-823f-43a5-b2c2-c566dc0260b9@ti.com>
Date: Tue, 17 Mar 2026 11:48:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] misc: fw_loader: implement generic
 get_fw_loader_from_node()
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
 <20260306190542.22920-4-ansuelsmth@gmail.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260306190542.22920-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SJ5PPFE654FA166:EE_
X-MS-Office365-Filtering-Correlation-Id: 5079f56c-559b-465c-e58a-08de83ed0bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qj97AwdpZQccTWd385LvSKk3E5ZSMl6u6hbzbt2K5hMHqeVTY+V6I9UaKkAWFLU1VdvR9nsSA8HRneZ0nju9zZb5kbQujv2I6WWQ+FAhUL7dNfT4YuXTb8h2MgPyk70SyN77WzJAKR4v+y920OCBKtmSdm3o1MHPqsq2IwBenw+IKeVpjTjTI0oEzmd2jeLpCY865fMExTeDAAx2HAt31IY1x1/mireGjZ9SgYnRXuMe27GpCiFdZI+6kk6O0wtenZdp6FkZGu/EshyCf5PxNjJKk0IdlVyy0iC0QVH3GzvTTxnX2IQZf6pX+3aD1wl8fIOWM4VyTlpw9OMfyyN0ONN3DoKeN7E9cd3ROOQqqTbCmfioUezCE2aFYJa8CKdbs1L7GMYz33Rwn9UM+Fia6plRxjzEuGjA1QeyoGyWGV9K0Mali+uZSTUjoG7Zutctbss/w1/e90e28fINyfxvaaRSuwMSUalspc1jmR1jXbvtigWlHA12BxZKzurPbatFMbySoIq9y5IUV0T4PWmjaKg7WoT00RuHYpdQitwC3n8jma2ErbYF2W0k1ppUKjWp9WEIzSpf87EXNGiUdmYbUvE3Xu3Sn9IUXAa2khgB5IKj1WuQ57+mrRg2f/cf90MRGAiEr+tGEaWGVvKTq1YWtymyxIlbTEPymMHWsVCLpGdpsecwrQbAS/72j7AEzxzSAGhES1m5PoDRfjpS+dC9bcdjZNV0HIpZ9EXCUIdD+Tsk/A5TqMWfobJTzPaYdTiPUA29EN0c1LJJW3+PP//bSBmgDWSMk9jQfbWGNcYJ3cUF1YBCFU4sJ85mvzZKSBW9
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0EmNrq+8bfpX6KTvX5MOc9jw9I9sfTV5uGHcjCt8Bo33LS6nwJ8HZIR9aBjwhysVMjPfXnj8wkhVJBslbGr3H1XCLoYHcUP2UJRMEf0ApyeysLfJsXLdRDsEzAyN3KLw/rtYa7z6oQVo+xHjDncvJDMg1tZSFygiAjQc9T0CV+QTTHpjKPP62JO3rUX3pCA4TPjfT/SFaFnBpeJ3QxlRW2U+GIgqpSi9Zg0AyFeSxIBnVn0btFi4k8wZvvs2q0vdfvv92x1XObKejgygdSR+iky7l2RZ1PJ8jrjBOWGpfpuEGJJaCi7sQcV/cCKrCqccmQnZAkxcV/DzRAbIDbkNGzBmIwHyYMjuIWffkqtOFA+OJ3D28S1DuSAa58/bo9G49SsmRLatncxw26W5ome1zyBIW88wHV5n9Yc5i1A2cHIMej7wBNVGoZ+e5WsGvrJD
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:18:45.9275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5079f56c-559b-465c-e58a-08de83ed0bbc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE654FA166
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
> Implement a generic function to get a FW loader dev from a node.
> 
> There is currently only get_fs_loader() but that is limited to chosen
> node and is limited only to FS loader.
> 
> Introduce get_fw_loader_from_node() that will parse the
> "firmware-loader" from a specified node and will loop over all the
> available FW loader until one is found (as it will be probed by the
> dedicated compatible)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/misc/fw_loader/fw_loader.c | 40 ++++++++++++++++++++++++++++++
>  include/fw_loader.h                | 15 +++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
> index 6459ba23a15b..e477a631fae3 100644
> --- a/drivers/misc/fw_loader/fw_loader.c
> +++ b/drivers/misc/fw_loader/fw_loader.c
> @@ -8,6 +8,7 @@
>  #include <blk.h>
>  #include <linux/types.h>
>  #include <dm/device.h>
> +#include <dm/uclass.h>
>  #include <fw_loader.h>
>  
>  #include "internal.h"
> @@ -67,6 +68,45 @@ int generic_fw_loader_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int fw_loaders[] = {
> +#if CONFIG_IS_ENABLED(FS_LOADER)
> +	UCLASS_FS_FIRMWARE_LOADER,
> +#endif
> +};
> +
> +/**
> + * get_fw_loader_from_node - Get FW loader dev from @node.
> + *
> + * @node: ofnode where "firmware-loader" phandle is stored.
> + * @dev: pointer where to store the FW loader dev.
> + *
> + * Loop over all the supported FW loader and find a matching
> + * one.
> + *
> + * Return: Negative value if fail, 0 for successful.
> + */
> +int get_fw_loader_from_node(ofnode node, struct udevice **dev)
> +{
> +	int i, ret;
> +
> +	node = ofnode_parse_phandle(node, "firmware-loader", 0);
> +	if (!ofnode_valid(node))
> +		return -ENODEV;
> +
> +	/*
> +	 * Loop over all the available FW loaders and stop when
> +	 * found one.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(fw_loaders); i++) {
> +		ret = uclass_get_device_by_ofnode(fw_loaders[i],
> +						  node, dev);
> +		if (!ret)
> +			return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  /**
>   * _request_firmware_prepare - Prepare firmware struct.
>   *
> diff --git a/include/fw_loader.h b/include/fw_loader.h
> index 56f5e3be6195..7053c7bc6f05 100644
> --- a/include/fw_loader.h
> +++ b/include/fw_loader.h
> @@ -6,8 +6,23 @@
>  #ifndef _FW_LOADER_H_
>  #define _FW_LOADER_H_
>  
> +#include <dm/ofnode_decl.h>
> +
>  struct udevice;
>  
> +/**
> + * get_fw_loader_from_node - Get FW loader dev from @node.
> + *
> + * @node: ofnode where "firmware-loader" phandle is stored.
> + * @dev: pointer where to store the FW loader dev.
> + *
> + * Loop over all the supported FW loader and find a matching
> + * one.
> + *
> + * Return: Negative value if fail, 0 for successful.
> + */
> +int get_fw_loader_from_node(ofnode node, struct udevice **dev);
> +
>  /**
>   * request_firmware_into_buf - Load firmware into a previously allocated buffer.
>   * @dev: An instance of a driver.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

