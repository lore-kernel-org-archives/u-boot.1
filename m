Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518C1F506CF
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 05:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F13684109;
	Tue, 17 Mar 2026 06:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jToNzg2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234FD840CF; Tue, 17 Mar 2026 06:40:15 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F9CA840CF
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvtge8u4CTySAy0cquyjm3ehscTSL7sbMa8ZBhFhppAeXYRyOiMY+3NxxDmG8UlLQs269PL/6i5FHnJM8SjFJIbzGNGVyg94nWw7cPkeN2Jpw9MJ4rFAi6RsJDQlB5YxGnaPpEittrJ1zoUETTYZPc03FAeT3FXNngYrUB1ey952oMYp7N4Ljl8HzOi+liGrX6YIoiM9OP26APN+k7WR8j83yKZ6JajAxrXyyOLk1oBA/IjGe9yJeUibLDuqWwOOKatOZHfcTSsEENElX5mDgu6RIHwjUxw26xciuJYNy4R9iZMNCo2ym6XVpCoYIhd7GxROcbHVhqjzp9QMx9Q2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inWM3ZyMDclzZxA2jxzsWwtGajw8whzXwxnkGSAeE94=;
 b=Md9DP1ZnivdzLT6Oofz1FZ5ObjC0OaGzHmB0lC/53tE08RiBaiiAOa+1llISc05hq6RLtBNiEqdsRsztu8BBMn8+7l0IMPkmx+ganIFpuTRaYFNQXxbiqG4huRp3VaGB0Vh32p8kWz4Zqnh9os/6Z/hu7u+hXyvtyZt8/uav2/AxzWU/8JOYXTxHMdfUcWn6lAGZ0YLRFzMJfxSx+/qXP0m/qbGv7Uw8eD03bzKg3XJEeKPz1fLKNKJn9LLZsdDuK2Iqg6JKe0oBiJUFx0Pfmsz28UrEHj4F1N2ShhBz7in9cw4/IxKifcSQ56tc3DTSjttlKrQl5acGJF66rx7Oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inWM3ZyMDclzZxA2jxzsWwtGajw8whzXwxnkGSAeE94=;
 b=jToNzg2RaGAo9Fj3qOQPjEzhhJf9BnBX2MQHQAvLDdOz4ZCJDU67MMKku0UHL9YQHb6O0WqexeN4ps4MIxOyylBQXXKTGshjkFT+1BPQNmhL5HkIeiIJo9WjzvLn6SKpA/9g8NWAyh1FNSjj4Euc7gUp7E5yt0binPKDj2VWrd4=
Received: from CH2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:610:51::33)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 05:40:09 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::1e) by CH2PR15CA0023.outlook.office365.com
 (2603:10b6:610:51::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 05:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 05:40:09 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:40:08 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:40:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 00:40:08 -0500
Received: from [172.24.25.125] (ltpw0g6znt.dhcp.ti.com [172.24.25.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62H5e31S2114689;
 Tue, 17 Mar 2026 00:40:04 -0500
Message-ID: <92bce3f5-9d24-45c0-82b0-4e15ed52fbda@ti.com>
Date: Tue, 17 Mar 2026 11:10:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
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
 <20260306190542.22920-2-ansuelsmth@gmail.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260306190542.22920-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: b533f7ee-a753-44c8-135f-08de83e7a6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 1f3HV2jr6S3C8iyWMV5Bxp4u3B8ikVp6Z834yg/FDKwU0ENU+k7GiOE8HYE3iTokPpISJxqI45C3Tf3MCXTVC8vVPDciiXLOHlMGuS20XdadjCyrnmdsgwzgm6Bw04XiGSNpymVCj8Ev09Q6QJht4Deg//D9gU0qkPPaRUYwdFn0NdxELOI14hSQGG93lzJzVKtyCU/nH6wkHFsIajFD+cuuCm5IJ9WXW16JKSq9FhPbETgRlJOCysIBxlS2qngLSAy+zM2utLHXeTrhMxPFwZhJrvJqDZy1aXkXAyStB/CwBWRjBYoChPW2TFp5XgppsH6Op8Y0hJiFoUhwa8mABfsjpMdXYFnyW/N7JrsmvXLYKuOnmbpLMDC/xJlKRHF5/qy0uLM/KKxpSk/W/MrRYgRW7kQvI1kEIaaIoOqyzQyHAtksfn08xjz53oPdIpy8YEJ3yRfdBA6vDtHyHw0m2Qv7j3gK0HsN/dC42LZEd/r4xxjTgiGV4rOwZ8pgn8ZE25zMHS5zd19pKqkX+zcCVAG4TMr6SojKqQKuDc6IX7AAE1KFWVAlSIfEXVl80hHfOiJaHt+GoEQBO5CRcasLzqbdpmRYv4CQ2ugNoW8DJSdBPdX6QInan/r2lH6FqHZmbrIFUhPWG25umUguj89ltc+3uyoHnwGvoRfP71ybAKL5c/4I3DGThSWdYHj4oUaEwEpXkbBWrLa4cXcHX+XEk7MW4hzpjo1v7+f8PR8Qz14qf9wHS0ewZDGr6wC+PJ+5rWmR8SAbuT8hpdbseZW/q+ei6e6xOdlq2JwNi0au5p5ShLAn67kE3Q3mlnmG4Um/
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H3t6FK0tTSfwA05K56TW17PLOXba6AYDAfadwet/R3s4bjmHZFU5u4pbso4U23c1veUIY5o+xwP1MG2Q2FCnYx4V/+ewiIgZybhjE8yJtQseH0etzp+6eQQzwuELbBcRSr9i0Osrtun2LCA87RpiWlc3xMVT8n0K0u4ZGPCDOjF9VX/WD5ETze1uUmlZIxCp67hHWpc/KrheDdOH+mrkzHX+8MVcAnoP6V7PSpzOeExYd7LbkFuVsTZqHGNKllrddduDM+QX+ZT+3JYF9Wz1bcGVufmyIGVT3Q4NpGVwF/6Lno9rXo3zcLgCDTKusZ295wX87FTgX1F06hQwuIT4U1mTGeUWcaUNK6I54joeFvXmrPTBWeeCOkdefZysMHs85YDsyoMAJINlnj+HJWWklbDKwi33jC/gXC3Vv9IOdjEjYJ3TbcdCOCuUwXMi1t12
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:40:09.3238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b533f7ee-a753-44c8-135f-08de83e7a6ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
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

Hi Christian

On 3/7/2026 12:35 AM, Christian Marangi wrote:
> When dev_get_priv errors out, the ubifs is not umounted (if used).
> 
> Correctly handle this handle condition and while at it also return -EINVAL
> instead of -ENOMEM as a better error since no memory is allocated but is
> actually an invalid scenario for fw_get_filesystem_firmware().
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/misc/fs_loader.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index 2928cf75f89e..7e432a7ebd62 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -178,8 +178,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
>  
>  	struct firmware *firmwarep = dev_get_priv(dev);
>  
> -	if (!firmwarep)
> -		return -ENOMEM;
> +	if (!firmwarep) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
>  			firmwarep->offset, firmwarep->size, &actread);

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

