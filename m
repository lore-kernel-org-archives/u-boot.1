Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DCBFF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 07:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B73846CE;
	Wed, 29 Apr 2026 09:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="VDa/EhSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5792846D1; Wed, 29 Apr 2026 09:07:10 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419A3846C3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp3EZUjXj21kjs+OZu0OcUbhF/MQnXCEGa10YEWbx0Q4ZxuOhXPnK5+sHJmaTIHAc9B9cbioM0n3yE+wEj9v8j4uLSLE4ffVdtuOxjJlymrA6TPDzU/kwBl8AI/jm8HRg4I2drj2Y8UcCAOBC+TNPbO8HQ0+OFY5OoMQ98r6GDQGqZTzLpbTuqjFQWkkS2P1J3y/5+tW9Y0DM3FIVrbKkh4ikmGZiEB1rXQNXsVOU5C/X1+BtnaSEzjWqV5dqim/F71VwwFfPQ5wIQjzWOAsDqp79v8PyVPa7Y0DDVE3n2y14ERrvbouODF1fZHBYtVbHuChBjlNaFZuzweg9RhGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAxaLwSexzQ1LdHqVVoOspcoU+P4I7sDvWsTPcU1qwM=;
 b=MSZhvIytKLPBh3/x2xa+v8T1MeT7qlKau64ahpAooPFzHlNqTYOI7/utp4Ng/RcUxE2Hosa67slVSF4/7FGjCK43wWYw2FjFXuKE9NUidmQwGNa3eKCQvXF7lZ7/cMUF3XVKFSrPQ0Og0Bt0z9994DKRItIiCuBxD7kiPhOmAuqkNyPf9LaX7uRwACZ6oIb0E4iZFvnkYnBAxj1EkGAsrGfcQieDjXCIG+oeSDXrV7fWO3GryBlAk9zq8F8D5r7NS6i4O6yYDVIezqdwN63lRSDozKiIF6o7yqd8IxNZJoxmWk0eyz0C19zTT6HFrxBBsSO1vNOuyCap+hUF+/f7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAxaLwSexzQ1LdHqVVoOspcoU+P4I7sDvWsTPcU1qwM=;
 b=VDa/EhSgt8sDBRxPQSiX2XP6h5qg11Eu6gUu44HdEX5VgjWzPUS7fywFZZ747t6mzwb88e3KhiFggnUgGkqC7V1ftmQrqWDUHzNax+56R6hKgOl5HZb7NgQlxmQ+yx9FFHD9fRY3GP0pbp7seobZK80/w5CleJRAYzUEMkOisl42UxLeKYeS9varGCV8jabpltfC2tGy5mcgwhc8vwiLjns9DhDQ9V8TGNn8op1Uwlj0+c5zMpQO39XHxcySXZn8kS/xfFBncHGb4fMc841uJODqta4ToV7T4aZuCCf+9A0fyR/7ULa/hs5SX9/uRPHWH+OD8nM4EwwAalIf84XnQw==
Received: from CW1P302CA0025.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:297::6)
 by GVXPR10MB9474.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 07:07:02 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:400:297:cafe::c4) by CW1P302CA0025.outlook.office365.com
 (2603:10a6:400:297::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:07:02 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 29 Apr
 2026 09:10:14 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 29 Apr
 2026 09:07:01 +0200
Message-ID: <848b503c-a908-4ad2-8d4b-560f3e0ceeaf@foss.st.com>
Date: Wed, 29 Apr 2026 09:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: stm32: dsi: fix unchecked return values
To: Raphael Gallais-Pou <rgallaispou@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.denx.de>
CC: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260412-master-v1-1-d7a8e742233c@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260412-master-v1-1-d7a8e742233c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|GVXPR10MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: e95989b0-eb3c-4599-1eba-08dea5bde9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QFhX/+HAVqn+eLunloKMVvazXbFtdAzM2e/wn/xpMP3ePqMy8K9dygSHwPRnnyPorIi4ttCkLRG/9JFqUdwNCBriSReam/sj/dGy5ndGllEvFt4H7KRNwOiZUfr/0auGHYjWFDU21f7nUs3eTsM0pduI9peJx9aOLGzPOfAsac/t3xtuNPO7ZDrcjdopGypfGgCG5L32S3B5IFkjsPUmkGMROdojMpZaBlksQre21jjbBcM735KOIVsn753Qg9ylSPdOQ+CZbyAEYe+n9ZoI+XRB4tCOPRuQVlIS8TLQcJQBVCOWvrEoQAHrbMquVbQx+FZ7gfhUq+E/MR27PXjV8VW9SldZhpfKXuJB6jWsIODUpt6RrQjneAOc8ceTaAgdZnc1pwL6pb6dxYEC9Docpa2d5rBl4oRTytOXx7wMJb/4lo54E+yAvZ1d6vdT850+n7O6QjTt42xgWIr7NAgSAiA+BSqeZ+JWNetvezLfpnCP2S31rbCMvTJL47uKytBy1ONV1zGhKCqM8qod+yuwIoZDQoVG8paD2grrn8/vXXmkvPn8YFkX+Ckm4WG1Kx3YqGF5dMvVRzvfrI+EPhttJwmA7XZzzbArf2aUKCNdWx/uUMRtrX1jM/CgiJiWg6tZy65fLKmteRTvcMsm3HsiPyIONOgjvgmNvPraUrBPAYYLoq8kI8UFwq641rdyWssxfJPKP0otn8eTiOIFKtddXXfg4iFD+TzEeh5klbiDumxdKGMzXQ3fD4Od5WpUwOW3Bq3VdMhqDwS+QdrkRAXdHg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RxSrmX9alW5T+7qDL2Qwz98kqlfvglrZeRu1B3l8U8xMXGPsSzaCYDHjp9qT6i/ish72WPrbEne51Bdk+ZQFjBT+31wdGUq+HWUZ/zlJlBNpScV/lx/otH2FngkuXEO3ioyUcBX1nYgUlI9rDyCf2ykrOPKgMi4OGMSmI+oyLWI1qUi928SK834uSKYMEVKnn30LN3RtWzjvksOa0cORniesyvIXMTM1iQ5a4mEqZrmMxKuaUTnQlcmXWjAr6SuAfc3+J3pGh1gSvjTCTRYNDZxMdVPwWMgh25X9WwjRM6Qw8GceG7EYr+g7DQSNQHA7lzmLFtN0s+/BL6zRKlb2UDr2ZPgZK3QNdkdptpBES5hOlI+G7P+eGWXJnTSzAFI3cgqxxFaGLFX5HzbhqX83w27DPaZHsy+IRIBZgynSe7Iqa8G4JyM/9UvBqoGrw49t
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:07:02.3607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95989b0-eb3c-4599-1eba-08dea5bde9e6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9474
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



On 4/12/26 21:07, Raphael Gallais-Pou wrote:
> Fix the following errors yielded by Coverity Scan:
> 
> CID 644836:         Error handling issues  (CHECKED_RETURN)
> Calling device_chld_unbind without checking return value (as is done elsewhere 6 out of 7 times)
> CID 644834:         Error handling issues  (CHECKED_RETURN)
> Calling device_chld_remove without checking return value (as is done elsewhere 4 out of 5 times).
> 
> Link: https://lore.kernel.org/r/20260309212331.GF1388590@bill-the-cat/
> Fixes: a6d047c0a86b ("video: stm32: remove all child of DSI bridge when its probe failed")
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  drivers/video/stm32/stm32_dsi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/stm32/stm32_dsi.c b/drivers/video/stm32/stm32_dsi.c
> index 65a91f5cff7a..5c4d8d2aab51 100644
> --- a/drivers/video/stm32/stm32_dsi.c
> +++ b/drivers/video/stm32/stm32_dsi.c
> @@ -493,8 +493,11 @@ static int stm32_dsi_probe(struct udevice *dev)
>  	    priv->hw_version != HWVER_131) {
>  		dev_err(dev, "DSI version 0x%x not supported\n", priv->hw_version);
>  		dev_dbg(dev, "remove and unbind all DSI child\n");
> -		device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
> -		device_chld_unbind(dev, NULL);
> +		ret = device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
> +		if (!ret)
> +			ret = device_chld_unbind(dev, NULL);
> +		if (ret)
> +			dev_err(dev, "Unbinding from %s failed %d\n", dev->name, ret);
>  		ret = -ENODEV;
>  		goto err_clk;
>  	}
> 
> ---
> base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
> change-id: 20260412-master-8be67866e096
> 
> Best regards,
> --  
> Raphael Gallais-Pou <rgallaispou@gmail.com>
> 

Hi Raphael

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
