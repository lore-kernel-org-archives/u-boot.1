Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA519FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 11:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4A28394E;
	Mon,  4 May 2026 13:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vvXp+5ZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C083483EF9; Mon,  4 May 2026 13:07:55 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD42980F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 13:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0sCOCH91cBgFqDbwM6pCw5kmNe+vUjabNaspdWmCiFQX2/TbC9fIDN15AjXaKHxh3bk4jlQMd1u+SB2x+76fgovKee4cgytLS5yA0bS4kLfgw1KnFwfSDivC5h2ayoqCyFLAjeRXJD+PXiOKgGCFOvfYtdfjS4a2bJW2zCiSB2ElhXR0sn8fpL8dg32T+Zk3neuNVPf5/amRUW821aZzKQudiud4xp+JtdWqZLgrEX+lnkhJDTKso7dIMeOvVxSZZRcce2yBAcgxM6ba9m8Mp2mthyTIdAqHAsP+Inb+pNrhmPrccx8TfUY/OkDdinEbUB0dXVTGfcSdn6DPv8HaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0BthBybuUctg9j09AkSSScjUXU4ua9V9me7Kmvbsls=;
 b=RlUIqLyjwDYcxLYX78lNR9Zs4N2CRtomVm34QO3EcRfOne/+tj7DGhUw1r9HIm7fuwcksWW1w+BEaUwAKrs+dCtvKC9qS/d37rCTz51Ys7AgZLRgBsVpjRru43dEIy7KReCkDzcsPpWCffuS9n1d6MkQ40mJVfe75hqzHks9IUAha/A6MV0RELV/ogrxa95t4VJAaP8BaTdZH9cLgMrw9AbCqIqmSSc/wmw/hT6sTEZChAQ84SqG2qMN/Phz6Jt+D3KhkmyPRAEwRrBSm3+grgSFwXE8aVcsd9k5QCIYQ729qiCVtncCEE3enlRi3u2mFCb2oB33SWqLVfYB7HC7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0BthBybuUctg9j09AkSSScjUXU4ua9V9me7Kmvbsls=;
 b=vvXp+5ZGL+HutJWiqspMGLc7VBTI1mhpBwKfi+xgp6HYUvvLoRlvHxnddhgVPCBs0guQMLzPcq6gWWxQRrjwxy/T+VX84fzkjZLg00aPK3gRCxzRAkG5doDXU7WoyECeAS8Gr2hAk6x1niKKplIm0nVOmgsr7BK0Bjsvv6otuJA=
Received: from MN0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:208:530::30)
 by IA0PR10MB7134.namprd10.prod.outlook.com (2603:10b6:208:403::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 11:07:48 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:530:cafe::37) by MN0PR02CA0027.outlook.office365.com
 (2603:10b6:208:530::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 11:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 11:07:48 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 06:07:47 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 06:07:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 06:07:47 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 644B7gdO586965;
 Mon, 4 May 2026 06:07:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/7] drivers: ufs: qcom: Initialize and enable
 clocks before hardware access
From: Neha Malcom Francis <n-francis@ti.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
CC: <u-boot@lists.denx.de>, Sumit Garg <sumit.garg@kernel.org>,
 <u-boot-qcom@groups.io>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, David Wronek
 <david.wronek@mainlining.org>, Jens Reidel <adrian@mainlining.org>, "Luca
 Weiss" <luca.weiss@fairphone.com>, Swathi Tamilselvan
 <swathi.tamilselvan@oss.qualcomm.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260427-ufs_clk-v2-6-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
 <20260427-ufs_clk-v2-6-36e10a7c0ef6@oss.qualcomm.com>
Date: Mon, 4 May 2026 16:37:39 +0530
Message-ID: <177789285970.3146166.17231505865681142244.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777892862; l=695;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=c9yma7sSixc+Mf/OzgV7N+rekcAEDfL0+9L9CTC5FsE=;
 b=dcrzZ1HTuoqTxCXoooS36jEHfwLBB6R+MmDoDDm85Jetycm1+wUfXX5Vstp/fH0KVHJo5SCMJ
 0U2gvpXIo4/DO6rviKRCVFBdfYs/dJcCFnN2O2eFj4azczUKlDms5AT
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA0PR10MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fc411f-ed98-418a-09e9-08dea9cd6070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: W6DahK4rraAaW3xixzf/h9HbuzdR05AwA3rmRaXoTXGQiNtEUdlVqXtw4C2I6QkjEs5wA6ULJv+mX2W42cgIttc56VNb6qepwxpb60C3TS8t+r7KPHz506sV2iAEuBsFieFF6ISuWiMUVbpoTl1NjfDO8+C/craa5ItmMo9AMuk3+uytmJvLQkyeV5QQny4+7gsuQ/cDaC+Kg3A0SWIeHgFiS4WXyA0o/cSeFeR9kOQsPpvn442mS6rnvtDruIZl3AIvTj2qXXkLT16j0cs4697X0Yg7whkk5DfaB7/k1vuzQXjPKpmqcq12jYfFB3S1gy/xaydxh2bWn1OAgvzFJU0px5hrBGY5LnHSxVcM8lAWPbYFBemgMQJESAYnS8+joJn/cHIiqFOnuwvG4EsJSOK+C04zk//znuyDvDQ27EZOkrFskAtyELc+HuQzCyXq3FOTIumL7JJqHnJlKIjn8N/8iq6ebES/DzlyUFr0kTGflTsr6cNPKtZkMk9KWxOqvjUpQPA+OkLN+2vtaalK+H0t4zhpZIVmF/lavJkCbBNJxJh2kegXGL8zvvS5/cDpKhgN0DpTfyEoHGMZDl+F7yhayQX03pV32Cf7ba0ZGiJ+eNRm+lkYmHdZnb6ScIdAKbuW4NF2YV096XQIiOvj233oFjKvfIWlAGPBw7UZMNjaO1ALYdWaamUhrugBNPdo/itOuFGscYKO9u12HFut86q3DR5DkjWDJrcrLI4TlIU=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TUUt6cLIizKfQ1HC0WhMlpz8kznt4KRQJdWGoJmYVAK9oGd8AqR8qDETUMdb0HLG6bXlJf7kXTJ72jAqKpWhf0w51b/X+nGOAy72acF2h1PDeDJrMvFih+2wY0zU7HD7iHIYO+zW5CnwIybffwYKCoj5y3eK6m8r2b0Yb+JlRg/4acsrtiZhynArLt5ci9o+YASb8Faei+mQ/rI1w6PqyKv24H6Sfy+/FDH/2LXXMCqJ1YN5aVo1u3CvkIe+RlGvUfu1AgSXZAa7CrhZT9tmUZSukZvEpjH7RQ8hFMjX/G8RVQuALoxDi8hwF5fOKIKsI+XclFPDaDQtsAZ9LYEIupiINNe5o3J5Qa5ybtUkh5K6QmLMH7B7ho8d1SNk0wbXr3g67uBrcWi1EV6sq+Ipk2aANlxNKPYSLD83i4m7acQ42sMOiPa78OhHGu9ghoY5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 11:07:48.3293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fc411f-ed98-418a-09e9-08dea9cd6070
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7134
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

On Mon, 27 Apr 2026 14:56:10 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index dc40ee62daf..ae33f62fbee 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -557,10 +547,45 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
> [ ... skip 20 lines ... ]
> +
> +	rate = clk_set_rate(&clk, max_freq);
> +	if (rate < 0) {
> +		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
> +			max_freq, rate);
> +	}

Was it intentional to proceed with init despite core clock set_rate failure?

-- 
Neha Malcom Francis <n-francis@ti.com>
