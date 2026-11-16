Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A004606A33E
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uDvCt5yA;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TqCOF4so
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 988A5406D8;
	Mon, 16 Nov 2026 14:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ur8YQZYWxtdC; Mon, 16 Nov 2026 14:43:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ACF3C406A3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794840184;
	b=mftt+VwmuVPzfME+7Ml/eySvD5eGmAIZRr7ifxQl1+mYM4BPAsC7vXUajgkqan6xTG8h
	 pMA2Kl5cQpuGHV/Czej0CwAwIp/Dmr1aYrfcc5y/kK9DtIfXCBqBe2NRlij6YHHJkn/dq
	 F9fk7a/NqxFrHYhj3hQL1Ez8hu5f0JmCQP+7cwWsnL/i3oX/We5JWQRNUcDZvrt69Fgpq
	 rO7Q7vwHd/bRs8Cco1UbykKUVT3OHvaDBdQE/cyKQWvbQBNVuaArpuLYLGsOfCQe3jpB3
	 6q0uhAV692oMMRGn9Xa5KaIhjXsL4E+JmltzOrh9PJ4cRnxXL5mCkzbmugfmDn+g5zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794840184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VKWdcTIF3QyQriT+Cf9hOJtUNxmB6FB6pZDrBCCR/CU=;
	b=GmLZh/qq4nYKU5GRDnGDPNMPa/EMHWOuVZ7UVgYeDA+cZYfmjkRe3QA+db9g7VsKuxsB
	 aOGlMG5NSTInP9WctV9Y3QeFdb1s12WGoJpmp3YMqpxi9enU7eVkM/suhsoYMVDvO6P/D
	 MfFUQZgq3Rj9ab7L4k+kQuoLYKl7OkUrGnfJmKZUIg18OU/Sl6nmxjY7IjuUe2nkD6A4o
	 zWE2zOE7MwfGLTVFegDTxzS+KWj69YFqPjB3u8FV0zmvxWuretKYDoaHNbLnTY4MPI2Pf
	 ewwoSMrIPC8682GG3XUzF5Da9Ao4dS6DBfKDnXZ0kGFEYZ0yQdppGb8z57F0hAy55zQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794840184;
	bh=VKWdcTIF3QyQriT+Cf9hOJtUNxmB6FB6pZDrBCCR/CU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDvCt5yAs7YOkpvsihCaEJg3tZUlBZP0QEn1rSXXPPGwnxdaV6VQV0bUx4h7ujRqX
	 Y3W5eWF2EUxzGe/Hiap+wiBPlND0CGFft/whscVQABtOVOK1mY5nw3qETLVWwVOfz2
	 1KGbNl1il1q9W/vw/j2cuCq2CjGKZJj6971/KoEQqdKT5uow+XGEmoI5pFrngiEbCh
	 zuyWj99Gq3r2aqbrVk4JwfbTy+vBjNs1fqBWs1vpEhwp8Dn5imSliihZjXEO45aMV6
	 oQO/q8Z0raBBYFULChIlGOB9GkttGx8gqBn7kckXKe4qQ82WtidLXWR4jkjOmYwGL4
	 nw/dyfhnFNXmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACF3C406A3;
	Mon, 16 Nov 2026 14:43:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60EBC4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4116860796
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M_JSJLZsGhaE for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4952F6075D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=TqCOF4so
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4952F6075D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKWdcTIF3QyQriT+Cf9hOJtUNxmB6FB6pZDrBCCR/CU=;
 b=TqCOF4soDJoHk/MWv0xaWeebyBqFpckScuaZpQguF7lNHkSs6GVt1SkVw2pzfCZYJ3JncI1ngydHgnLlOP4WjcKWMaEq3HG1H36YU1zZuo+wpMsmFJsH7TuFxJjte+CM9lh1hsMZP7k1jZgkVKk59eJVcl5cM+KWtTMOv+024mHj70XeLMgSv1rwmDWX3rbzsrPGNrCt56qV7mRr/byjcVaT8tGIzM+6xwfezoPvjynvr7v97j+RG4j2tr0VMu0CUidX1/0Rrh9GHPGzaMspS9Ff+3fOaMSCcziweo9NcHHS0W1x6J1Qp0e02UaK4zE6Wbel1br0V6rVX5xyQeeaUg==
Received: from FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18) by
 AS1PR10MB5190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 14:42:49 +0000
Received: from MI3PEPF00008552.eurprd05.prod.outlook.com
 (2603:10a6:d10:0:cafe::38) by FRYP281CA0008.outlook.office365.com
 (2603:10a6:d10::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.6 via Frontend Transport; Mon, 16
 Nov 2026 14:42:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008552.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 14:42:49 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:43:49 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:42:47 +0100
Message-ID: <95fd8601-c035-47f6-9c3f-f15c0aab16d3@foss.st.com>
Date: Mon, 16 Nov 2026 15:42:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/35] configs: stm32mp25: move FWU A/B boot
 environment to common settings
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-28-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-28-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008552:EE_|AS1PR10MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 195c46ee-4716-4eca-55b9-08df43efe2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261021135927099003|261009223027099003|261102123227099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SgVigleHraXihNaasI2/CD85U/jDUacMpOrzaWwJkFcLaL41BoZspcOIi2K6SL4bYU+ZAEDCf5dXbnzMyUm888ANyXkWc2kqSqyBtsO3Le4KJ1Om2OsAPt3gxfQMqNqG7nmKIeXMJRrk1595AjIwIZwgntc0FmSAdtiRXAfmZ7muKBhGdob7ZJLODiuyWfsOx+3qa6bq1qCqAcYLUAICkCLaHW4nzEUQxIQWgCSGxnfyhAPnjlYnSe+nswAPJWLXIOyTPR/gDl1tquA2zXRY7zjYOoWuowGT/Kdaf2GzxrWw5XfUx04kXwuoqvNUau59z9li1nXCGFGkbktbMbZ0+hU5tZzye9tcwZgeck1DmUhmz/4z/WUDlkSTmJX4OhmsuZHxsrdTVSb0q9vBitJUf1p5zQRx/v/UTEPy5snNFglSEx8YtEa+PNX0b2Gfvm54IRuyw3e6fSb5QooFkpaQ9lNubqtjzzvUcjRhyL/aFdXO3rY51ZYVaBjSHR6Eoutf5pEeMf4Tmy/RAcDBq3yxn4XLC3PLlNPHvfOEE5OWPEpmgY9dKJAzg/TimWPqYwEaMuTRrOhNkda35/WUprx7kjNFxvO/5Y1LJCGFnSWntGhJrJnGxSU3RFBCm0phPy/DVJSrQJEldEJSLBcNBq1eDTHgMLtnDUyvAnOoxtsLV53taIDPi3vO2AOBry8hKMB2dfiVKDgZf0i8sL4uR65qTA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261021135927099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 41L5T1TJFYpjKHYgumY6Noyc3QQPsLm893d+ucmV5rpnP5EnQGthwnUt/0LSjHiHHIcPN3uOaVutxoexUtS2dgZnbTnWKzNh85NEAjC2pTWpOXxT46Bu+5QleEHc0mIl86peMegSTPMFj7QDesVOr9LtBsuo2ZFQTOSbhf4laui6+OR8rIsEALf0iJSUIg/c/wQYs0IF71n38icC2P8bFS1LgmlIDG8tsPIByX2cN2CAEUTIQWB7GCOetqA67u/X0HSX5+uJEFXReksJjvMgEbj2w7ZKv7G+cWRHmLkXD+E3tHPnLnJ7oiMSrgFaM/uxToS6eQfoPk5uoPn0gWfpli92Yt3siqfj/GT+RFmhyknqrh7RC4vMZgwXtGpIApmzDa+u/yWNCdv5DDihE9FJLjawLi1rggDnXb68XMR+9QG8dSm/OIEcR6V7Z72leKUk
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:42:49.0399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195c46ee-4716-4eca-55b9-08df43efe2cb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008552.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5190
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/7/26 15:32, Dario Binacchi wrote:
> The distro boot environment booting from the bootfs partition of the
> bank selected by the TF-A only depends on the FWU multi-bank support, so
> it is not specific to the STMicroelectronics boards.
> 
> Move it to the STM32MP25 common settings, so that other vendor boards
> can use it too.
> 
> No functional change intended.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  include/configs/stm32mp25_common.h    | 20 ++++++++++++++++++++
>  include/configs/stm32mp25_st_common.h | 15 ---------------
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/include/configs/stm32mp25_common.h b/include/configs/stm32mp25_common.h
> index a334b47b555b..7eb5c4ffc00f 100644
> --- a/include/configs/stm32mp25_common.h
> +++ b/include/configs/stm32mp25_common.h
> @@ -86,6 +86,25 @@
>  #define STM32MP_BOARD_EXTRA_ENV
>  #endif
>  
> +/*
> + * With FWU multi-bank update, boot from the bootfs partition of the bank
> + * selected by the TF-A ("boot_partuuid" set from the FWU metadata),
> + * falling back to the bootable partitions if it is not available.
> + */
> +#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
> +#define SCAN_DEV_FOR_BOOT_PARTS \
> +	"setenv devplist; " \
> +	"env exists boot_partuuid && " \
> +		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
> +	"env exists devplist || " \
> +		"part list ${devtype} ${devnum} -bootable devplist; "
> +
> +#define STM32MP_FWU_ENV \
> +	"altbootcmd=${bootcmd}\0"
> +#else
> +#define STM32MP_FWU_ENV
> +#endif
> +
>  #define STM32MP_EXTRA \
>  	"env_check=if env info -p -d -q; then env save; fi\0" \
>  	"boot_net_usb_start=true\0"
> @@ -119,6 +138,7 @@
>  	STM32MP_BOOTCMD \
>  	BOOTENV \
>  	STM32MP_EXTRA \
> +	STM32MP_FWU_ENV \
>  	STM32MP_BOARD_EXTRA_ENV
>  
>  #endif
> diff --git a/include/configs/stm32mp25_st_common.h b/include/configs/stm32mp25_st_common.h
> index 0b0267ae99b0..cb679eb1be22 100644
> --- a/include/configs/stm32mp25_st_common.h
> +++ b/include/configs/stm32mp25_st_common.h
> @@ -8,22 +8,7 @@
>  #ifndef __CONFIG_STM32MP25_ST_COMMON_H__
>  #define __CONFIG_STM32MP25_ST_COMMON_H__
>  
> -#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
> -#define SCAN_DEV_FOR_BOOT_PARTS \
> -	"setenv devplist; " \
> -	"env exists boot_partuuid && " \
> -		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
> -	"env exists devplist || " \
> -		"part list ${devtype} ${devnum} -bootable devplist; "
> -
> -#define ST_STM32MP25_FWU_ENV \
> -	"altbootcmd=${bootcmd}\0"
> -#else
> -#define ST_STM32MP25_FWU_ENV
> -#endif
> -
>  #define STM32MP_BOARD_EXTRA_ENV \
> -	ST_STM32MP25_FWU_ENV \
>  	"usb_pgood_delay=2000\0" \
>  	"console=ttySTM0\0"
>  

Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
