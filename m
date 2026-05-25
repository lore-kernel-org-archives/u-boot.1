Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5334CD5BD0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 12:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06117846AA;
	Mon, 25 May 2026 14:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AUk7Bm6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C711846B4; Mon, 25 May 2026 14:13:10 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480CE846A5
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 14:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZDAWhz/Zf1e3ObJxiCf3CHWpoI6daAaAGW8eQKpKg8aLj8g8HxVZbv0o6iByebMDS3AUi/pp5Ma2lNmCTOZJUTfKjRIyFmXFvIMsfUsiFFg2MjKMVomFZij2SAwRJxXoYwlKM+0Xvxxj3U8CwLlaO64a6XQYOjpnmIkE2Tvnwy63jqoUKBMarxEH3xShoKZZv8W95VigW7PIuE+/EVWSkyNzQcblYceYjusvpc2O9UcM5+dmVw85MWEZAe9QVM31dhJ9G2pQhdGeSTAWnL8U8ku80hPxQS0a86zKgtTSDcPN5wR6e93BzG+pig85D+OhAI+EpfQQcuuasW7T8SkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVHSdiymuZ8JESd7Dx8EMJPCkgvBebnMqAJp4SS92FM=;
 b=Ib7iWq4SF4qsF8FINJGfI30j3yZnxpMzn9qi3TysI+9A0Y6JgIH6xYUGpiPd38gvbQUdudbY0LPVUobAIibBpTJ4NptqCwoXlhZ04tTb7ApYl6fOKcLc5zn5P34TLTXnGu8y7g/BBzP8CHtrVUiaPI+AQTEBFHWCnpzNnjs4Z/jV0H2oJZyeye+7aQpJyf55nenfH+752FYncJ9ENg9GCh+dZCG5dr78a9eVEtI7ycq7bCbwFWTu95uJJHCQhjATFR2X/IPIRarM1PZPqFYqL/BmpJQukb5MnRWQLZov4Dh0LVXMPkMd57uqiABaegNsbbvrvLogDcEFq4GB24Rb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVHSdiymuZ8JESd7Dx8EMJPCkgvBebnMqAJp4SS92FM=;
 b=AUk7Bm6eX/mXlZVHnOs59HSznhtJwtUv5liuG2kp6uH7OCQNxlAPjberNi6U0kanUfmNrmzGPB7LB2uFjgcsjYp8ap3SFR4+CCVXNHx/GoqPWV5bsAF+KMPQCeNd8by+JnVDBAfu6PReVwwmYOPtKdzolN7UdmTDjk6FAC9WzcI=
Received: from SN6PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:805:106::26) by LV3PR10MB7817.namprd10.prod.outlook.com
 (2603:10b6:408:1b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 12:13:03 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::1b) by SN6PR2101CA0016.outlook.office365.com
 (2603:10b6:805:106::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.2 via Frontend Transport; Mon, 25
 May 2026 12:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 12:13:02 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 25 May
 2026 07:13:02 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 25 May
 2026 07:13:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 25 May 2026 07:13:02 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64PCCv0r2997767;
 Mon, 25 May 2026 07:12:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/2] ufs: qcom: add ufs host regulator support
From: Neha Malcom Francis <n-francis@ti.com>
To: Federico Amedeo Izzo <federico@izzo.pro>
CC: Sumit Garg <sumit.garg@kernel.org>, <u-boot-qcom@groups.io>,
 <u-boot@lists.denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, "Bhupesh
 Sharma" <bhupesh.linux@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Julien Stephan
 <jstephan@baylibre.com>, Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan
 <peng.fan@nxp.com>, Luca Weiss <luca.weiss@fairphone.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260523-qcom-ufs-regulator-support-v4-2-45639533b06d@izzo.pro>
References: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
 <20260523-qcom-ufs-regulator-support-v4-2-45639533b06d@izzo.pro>
Date: Mon, 25 May 2026 17:42:55 +0530
Message-ID: <177971117506.986002.14811075924990554544.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779711177; l=1090;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=v3flvRy4j72S3S7aJSbssrxhbJouOFAhPQEXg8ZlFy0=;
 b=AZqFTYx0mQAHq5QlsAUCz+woYkcNZyVnOeI2QgK9U22QWp21gxbTBlciHXxKNcNLH7GpSdiov
 b3j4bdThVaEBjTWhxW7pK/tZhq401q+sDBHmS6wahoQ5/WXnW7mFJ6j
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 46187574-7ea4-4267-3199-08deba56f820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kb6I2pLgIkJopRZQWtrw/jzyA83Ju0C4Zl5mlk00YKl/heKh9739MzHasGjbguS0non9QcQQ7XOD0/rXSwXugBbsl6aV8euiZhJRZlrbqCrhlpT+s6RCFx4otf/HRf8mvx2ZZCCSoFBQEwn4M670S4cd1numGb3dMAwnJyqO9R9GWEY8Vi0oJCfL69MqvZQusCYooSztr8QgdToDureMJcBnAcKX855RhkVTQFktYTzcMfKb+oFXiuFrNV2dBsVpAHRN+8nKH4S4c3yBXZAZVdmRANh9gqhulqdv/YTPVFcjJ3+UNjUmRTZ6jBdl6XsAtFcUa3NbqP/QrCF69yCO2/VZ9L+Gha/kPh17agRtq0hxSOlsQaXvk2eeO/lwJv6pshE68LocgiH6jTOGUjbt15DTQJ7p6SUVIsyQlVkcX0W5xgFasdQ6Op1IFY2SC1V72zLPU3jWwIAMGP6it5qK2/hx1alIGM37EyAhHUf/NxKslH029RJHMJ0y80qlvnOL27JLhJSxnBfiDIGLRo0G0Zwl8TCV6TBdH7SpWDr0jON6ax3Fo9jTZqrSdBigfRT8Bhn1lE93F1hcfeUGcLFOqgvXZMUn5Jpo1qyg68CvYV6/PvIUvJTLjEU+xcCdCRL3UXB2PYK1AbRa85SzRn/cLw09Vln3R8ej0T7AW9jIdgAESkgvhPpXuwUKOTYfPIR9Hu8iia89GXHfZmkMS88WOpgu3ivzvBQtKsjbm3o5yZ0=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(4143699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9R2RKGJW2ZlDyzIFr1zBT2UuqJpvf43a0TCrQ7zctmdsUlLRJnidNap8uYqkicWLcj7/BHywZ633Wu3dAEcT4y1DsohMEXfJPMKTdxDJTe8BePJp+jOEoh3Kq1ej3EiykTIFdD+14V+KpEaOF9u+kZl60I0vnN5HH1LXb7KL0vZZGZDZG+1gYRECuu0ylf6hkWe3Jv4DYVWZ2wFhfYbf0OT9VevYRDE6RZEH7WDn1ZM2tXtuEZZ0b4k+gB8234figrIRBpl19YHTO6e8Dh8hthKhRLsBXnLroQboxPrfSlrmCkssaxHv2LRM7ZJKaOENZ6yAEW1sBXGFXy09wHO1sLSrx5KZHc1BxM1XM9S9OwoYRiP2nYGd/qhZPY8sE/0zJl+XlAvLeiEd9q51QGGQZjjIruYD8Hd/nOZ210var7hgx3dygOXSVbzk3i4uISoX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 12:13:02.5489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46187574-7ea4-4267-3199-08deba56f820
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
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

On Sat, 23 May 2026 15:04:25 +0200, Federico Amedeo Izzo <federico@izzo.pro> wrote:
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index dc40ee62daf..0e2e45f1075 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -561,6 +562,19 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  
>  	priv->hba = hba;
>  
> +	/* enable regulators */
> +	err = regulator_set_enable(priv->vcc, true);
> +	if (err && err != -ENOSYS)
> +		dev_warn(hba->dev, "failed to enable regulator vcc-supply:%d\n", err);
> +
> +	err = regulator_set_enable(priv->vccq, true);
> +	if (err && err != -ENOSYS)
> +		dev_warn(hba->dev, "failed to enable regulator vccq-supply:%d\n", err);
> +
> +	err = regulator_set_enable(priv->vccq2, true);
> +	if (err && err != -ENOSYS)
> +		dev_warn(hba->dev, "failed to enable regulator vccq2-supply:%d\n", err);

vccq2 is optional right? Is it verified that the optional code route will never
return ENOSYS and there is handling in regulator_set_enable for NULL regulators?

-- 
Neha Malcom Francis <n-francis@ti.com>
