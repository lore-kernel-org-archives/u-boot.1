Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D355BCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 06:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60DAB84715;
	Mon, 11 May 2026 08:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Q1j75RrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604AE84717; Mon, 11 May 2026 08:02:51 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F98684671
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaOhx7Y2puIYoFJh8pwceE3hT+Aj+RAymCRpnP56BCG992TSMpqMxv239Qm1kjy+GdFtFeLLNqT+LUjXfjiaZOrMcrTaQzrq1u4D+YL/IlMU/+T2IDbUXvR9OmDKiz22SZ6JuJ1YSUn5ViF4dYd04gPLwWyeWsFhtZFm6a19loIvbQxDfxOG/BCz58WzT4bqgzYbZK0vGVuCIPws3MSwjuyO6WKO8UgfInU2eRpDnUmt3RtfuY0sn7nJ4u6sPpKEkoqDQkDQSUXvj0J69cGIgctQfFl6o3+JQiw9wPox3VXdCUwARjQjzMKZMBoS4vRv29wrHXhKSZ9fkHa5stHbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4yQlLdWAPL7D/PUAC6qqJTIXKIp4fuLS8YZAULtTeU=;
 b=ofsZFjclPxR2EXMGvCCanWdbWRtm5u1QrDKcyvTVAj842lpb3YkC5k6dm029HFJVEIHp/OJBo1u8d76n1RE7AtG0or9KpO3ef8Hcs/fZj1MP3p7nF7wfcTntzspIVWYzbJ5o8GbBDUcK+tkbs2Ts6vBblTItprrtb1/N7Pwt/PAkGWcY/OabKMJkneulUt3V95W+qn3A1L/UiQIFj+uDO7JYod20VHu+2xWsoxjGzOfbr41nOWHNDUHHWyfKNFUNX1QCvGuMKggzCrpahtyUPUlLDkQc8XDuee2IJ0MQ4Z1QHg2UTw5G/UcqE1T7TEB29uq1z7tPVo4fxxhW/qTIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4yQlLdWAPL7D/PUAC6qqJTIXKIp4fuLS8YZAULtTeU=;
 b=Q1j75RrJwl4j1pVDc/TgPB2rh+kAB2xkuOuaRmd7v6rSPpbi9kfN/7/GWoL9Xv9GhjQJEMfnRKIXEmUZwx6tmhtvQZcTVfscqIkUxeLhEr14OsaCg5jmtOWsCdTz6ObmOQ8Pq6JZbEWbbYJv4KhFxiNZP1EU96fHSP4lhLDxs9Iarfka2eIZRxEy34B3y2dpovvHpYdhkzZssg1sSRjD6rhgsenmx1+6h/oma1KhEWLzKf8g1uvKzKjWtdjYLzmxL1jAGMZfHl7954/9KTS5vpeHlKszG7vsomtZ/SdRHnDYy31hDJehcH3426VjWRbwTvYENZsasUuU+yxa9FaV/g==
Received: from DUZPR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::19) by AM7PR10MB3921.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 06:02:47 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::bb) by DUZPR01CA0011.outlook.office365.com
 (2603:10a6:10:3c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 06:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Mon, 11 May 2026 06:02:47 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 08:06:12 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 08:02:46 +0200
Message-ID: <2afe2bd8-f963-44b8-8dae-107b4cb34b8a@foss.st.com>
Date: Mon, 11 May 2026 08:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] video: stm32: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Tom Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-9-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260510171723.56866-9-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|AM7PR10MB3921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab72b77-04c7-40d1-1ce9-08deaf22ed1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZhdQ7wpk20hLcnYni/fAJ0KTKsLiAJFy11652DLWkXxl3I1k76O8Us0Na3y/OSeN8ZhQJCnAdwfIpdeS8PRtff52aEHLqzg68U0TjnAa9yy66OFJ71DtnFhfbHt/OdWcbLoe7D+eICqh/G6AiOZNIYJBRNG3t5qaY/ElyVk1RkPmqkEScm/0YzzfCXxBrf7Etan56UZuP+vngygNFyHpBjTL4bZpfdWIj7eXNjtM+earSEVu2wcIYvpqPHHIzF4o5hZeW3bD1hxWgHSnMOYqsI93uWr5+ECg6aTqg3P7iNvYgXbQ7HftmiuUJBt6HNhkEnyfX0QUnLNb9ir8YzqGGrlboccZfoit6UQAhiDrL1jAyFT0RiAG6bMk5RICwShddPZ6MCPP0V66uwrZGxenXt8poFo9hIPcgycWNVf2punXFNe//H2htdXXcJrWebdVgSVE91P+re1VYV9uQ33BFUjLHyDChygKhyu450V4Onq690+5v9vhuiIWN9tJZkvJS8iG+ZsnXaiDG/dGUOLqo0l9CL3n8uilRERvFQmSvNIxPI4U/EEIabChxpeIQQKGEfH8NGWL+YBwHXIoe20TZFGm25wwNI6eIbD0Jy2cZOAgZZ2SGVJhfUGDH5JNai2Ov52uxZOK7VykzEhExtKW6ud6BFDhilwkbszK3yoZMyakiXydUnRPFB9gyDGcuD0sPDSJv7aI5eo06+yPXag1VQuhN2D8HjRdFrR9fSXW7+g=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nJ3Sf044/y8JHCmFgchuVRhVwCbJzBJzbPScjXINZl5Wtzod7BPYRL9ZXBmqNK0qr5K883HifcFJtCCJYgFYMHUXo6w1EKGr3qgwP+9xEwBxw3+dzwsgkRhwNsabqTWUlss11o6PyCAH97Oqcjn6tEloeC7wi+0wfJAh4Tg5387UHSbE7IVjwfT8n+3vZK+FwasmUNBrbvJ1ZA9+bjln/2hG5qeXYMvzX5+fnKRL38O+TxwmnjO97DQgyojiiU+s6awpWkh9TH7soc71S5UXKI4Un/JAPrPNYJa7vAINxYHsSlygwbgVrv5PYC5w5QpcBpY+UawCbyiTXyYBSEl1tBePXyDU+ssEZUIIWQS11ZObx7BGK+2QIi5O1GobDuMZjtpLcGw03mT+0w5FqahjzShzDJZVZ0XZqxY8vUQ38nSKqLBo4m/2AA2ng9A0sv+X
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 06:02:47.3978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab72b77-04c7-40d1-1ce9-08deaf22ed1d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3921
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



On 5/10/26 19:17, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/video/stm32/stm32_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/stm32/stm32_dsi.c b/drivers/video/stm32/stm32_dsi.c
> index 5c4d8d2aab5..29c57a4ff89 100644
> --- a/drivers/video/stm32/stm32_dsi.c
> +++ b/drivers/video/stm32/stm32_dsi.c
> @@ -511,7 +511,7 @@ err_reg:
>  	return ret;
>  }
>  
> -struct video_bridge_ops stm32_dsi_ops = {
> +static const struct video_bridge_ops stm32_dsi_ops = {
>  	.attach = stm32_dsi_attach,
>  	.set_backlight = stm32_dsi_set_backlight,
>  };

Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
