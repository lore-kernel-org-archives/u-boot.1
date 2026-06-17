Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7CECD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 15:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63AE484833;
	Wed, 17 Jun 2026 17:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QGccekJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D02846B0; Wed, 17 Jun 2026 17:05:33 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C93846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 17:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ4syI4ctnIsYeiCKAjDVmpYC5PFMI+14nuDM36GkoEOuLV8UEtzapEtHbXxwo8q2NVse5mCpmeB/aB3ol7t+yQTo6nJZYsqpR0BrCyTeTASx3lKcJBQqp7e5EgWdQlTyH2VRBozFrnoqC3a6kPWw+mnBUSHsCamXvmMzAFXHeJRT/i+Y+RbtqZOX8nSxNHonVPykYzP+OmRQ56tLL1eLMtxiB0Ht4LXQb8Iw26iTCENexKvz1VTmXBezw+BOfrfx22Rb/V+D3L7nJQrqqJx9wnHqKNAhzYO3bawAxa8minr6eCd8S00L6ohsqefYenN4iK9eyTUg7iSZvKJo+TTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE3VxHTwO0FqzzBhI8Jd3xIPdhJWtTbCm0SGc+P2qP0=;
 b=AKvz4iVLSA7dDWiVrHbSegYQMJ7zMNapS/+l1+w3cxbrVsU908HCkOoVjl0C/vFXSXUm7xU/nXNU+Qdh8oYK7JlsM8lqlu9pfEqUy9wfy36di4KWfy/ppFpSsY6/4BO5ERhQd+ayf8mlfJOxec+OaJ6tHb802WgxmbbciILqZHo65X4znJEsI+rxZg0GR9tIRyHMVW9mc68TUv8oFtc/Qx0VY7T29rpJt8TYlcYXvlM7UXq7dLXs9+5vErGIDF2IQlAXEGmblKZoNWcvtLfSHFzgLYFoBmOIBfIFEOC7lwTGKZ4f+RBuNM/aMICWVex3aT9xE+aIZ3P2kFDLVZDnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE3VxHTwO0FqzzBhI8Jd3xIPdhJWtTbCm0SGc+P2qP0=;
 b=QGccekJsFF11n9xvvD63HBMCB9O4f+PepPuQnGE0o8l+Lw2OFtOQugNLGslqFwSjnOAffvU0qOFPkARhZHirwirWJ2uxccMjc4iELruoeSl+Ny8eHskVxfYww0SUaPMNysj1thk5ydzMJdfcTagHBEIfOz9uLPFCU8Kgpj8HkzMhFA3Z+8e6p75Xwli2RNq/KyRV7M+U48AHrIErygGqIWKuG4AOI2CRZLVstrr2ANI7jFGTv+yNoJlNcEr260vPVzKcWEDRLwRK1v9Uh3o8DVOqy6ivgBriCzl/6Jho08e61c2KJ7ufRJDpa/fmyg4g+Hz3J6GgCLhhkG8pnznf1w==
Received: from DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) by DU2PR10MB7694.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:493::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 15:05:26 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::18) by DUZPR01CA0023.outlook.office365.com
 (2603:10a6:10:46b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 15:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 15:05:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 17 Jun
 2026 17:09:25 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 17 Jun
 2026 17:05:19 +0200
Message-ID: <884e052a-cd12-4076-97e7-13b1e549324f@foss.st.com>
Date: Wed, 17 Jun 2026 17:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Disable eps during
 disconnect
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>
References: <20260617-ums-disconnect-v2-1-6e52d9de1d36@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260617-ums-disconnect-v2-1-6e52d9de1d36@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|DU2PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 2087b055-6509-4ac6-6298-08decc81dd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|11063799006|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K3Zu1dZeAAG+EwyVLDL3UzHD3ckeQ/hLLmnxQhsRC6LuDzPabbXo300g6aPQEOapTIBqpQX5m1R0KVAvxUSbZthk8mpBR/s0U1j+D4msiHnfviazgmJzDMRHZ3dhx+eSpiofPpJKBE576hCgtg4Q9J8hu5iE287PybpT6sY+K8Oz4IG2jLGGILOBt0Mxo2EPidsJT+3byrB0nYtOJYZb0frAvmxrINTLdYZ5Nm2YnTaGbSjbusAXzi60Y0+VpLF8M+Vx4iOthU6wcWpIkmAZjTYse4515Jvqxrqkr6G86HAsEdz6ttaJ8EWMU/o8BA10fukHpx9FFIJS/fFY3bXyddugur67UcpIjzXqK6RinVHeF1fVnrNsr4MNWV0ErcooVabJ4txeTmhzh7ZxaWP7p/k8nqA70gi2lbtBlDEhKeZKd0agzoDmRRQtnjPTjhp2C6TskL1FDsXCD67jiMwjEC3QUAbr0EwJPDQWn4xi93zZzUPTzHOUaBshgCEz53i58lKi1j0ZOXoSXJLJv9AkDhV1AyNFXlp/2aPi+bP55VHw0P8RRxazkPxNJ2E4oMmCrw8cu9IUAg4+ysbjaiPH+LMMUysOSt1r/A2zatXWVLnca2OEYh3h3XgqTLQwBFoNvG0O1Iqqzsz5tMheHxZSOr3goMZhN3OF54gJJ9CpWUmdvenL7+PoLbesXX/p0TDT
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(11063799006)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JhzMNI6TdBLyOm51CXcItUlOCGD9zMCaiKjLmWGwG132bD5sIcVtKvzjBPaBIqC34uMPm5Bv5YYntL5F27lL23rG1XWxADr5RJZbW0kYMcMq9mpQRx7q5oL4H2xa8eg58/BSDdRNhldOWxz/7F8CF3yBJNyvcpuGh3TsS+7WTIQmq5aG1gpytdojlu+VHgYZqr2u8Jv0ZZ8AwU5Zegp+v58wzatXPJbNZelJR47Yu9kwrZJifx34ayehqMuvovZKS5hruW/zPM9nOV6w+yyGuBzFpbEU0Cq3pDuubjIFAkpAsA5O9/K8FvBBetWmRWbY08mHZOE52h/ewPU0ZXZLdeNybL++QvIlbDNkrPTR+n006Lyb6JkE2XJuVjg/Ubibs9aoxPW0s2Nj8DDTBnAU4IYvridoIn6EuJMKXNyYzIZNht9P+NJDIb6t/wZ2ItZp
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 15:05:26.7611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2087b055-6509-4ac6-6298-08decc81dd4b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7694
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



On 6/17/26 13:14, Mattijs Korpershoek wrote:
> When trying two ums commands in a row, the second one no longer
> enumerates properly from the host.
> 
> This happens since commit
> 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
> causing usb_ep_enable() to return early when ep->enabled is already set.
> 
> Gadget function drivers (such as f_fastboot or f_mass_storage) implement
> a disable() function which is called whenever we are done using the
> gadget.
> 
> Because f_mass_storage driver does not disable the endpoints,
> ep->enabled will never be set to false again.
> 
> This can be reproduced on the STM32MP157C-DK2 or the Khadas VIM3 boards.
> 
> Add calls to usb_ep_disable() as done in linux [1] to fix this.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9fff139aeb11186fd8e75860c959c86cb43ab2f6
> 
> Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
> Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
> This was initially reported by Patrice Chotard at:
> https://lore.kernel.org/all/20260616-ums_fix-v1-1-f1f6c903b3fc@foss.st.com/
> 
> That thread contains reproduction steps.
> ---
> Changes in v2:
> - Add missing Reported-by to commit message
> - Link to v1: https://patch.msgid.link/20260617-ums-disconnect-v1-1-a5ff9011d49a@kernel.org
> ---
>  drivers/usb/gadget/f_mass_storage.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index 71dc58da3f03..87ed25e8bb3a 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -2275,6 +2275,17 @@ static int fsg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
>  static void fsg_disable(struct usb_function *f)
>  {
>  	struct fsg_dev *fsg = fsg_from_func(f);
> +
> +	/* Disable the endpoints */
> +	if (fsg->bulk_in_enabled) {
> +		usb_ep_disable(fsg->bulk_in);
> +		fsg->bulk_in_enabled = 0;
> +	}
> +	if (fsg->bulk_out_enabled) {
> +		usb_ep_disable(fsg->bulk_out);
> +		fsg->bulk_out_enabled = 0;
> +	}
> +
>  	fsg->common->new_fsg = NULL;
>  	raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE);
>  }
> 
> ---
> base-commit: a7830e87555abfb81cc69275cecb2bc0fbde5b28
> change-id: 20260617-ums-disconnect-d839bc17a47d
> 
> Best regards,
> --  
> Mattijs Korpershoek <mkorpershoek@kernel.org>
> 


Hi Mattijs

Tested on STM32MP157c-dk2 board.
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
