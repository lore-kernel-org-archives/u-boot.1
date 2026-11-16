Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEA606A32C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DbkBBged;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=gxDt821m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E47FE80EAD;
	Mon, 16 Nov 2026 16:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPeOAFLUib7u; Mon, 16 Nov 2026 16:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2495680FB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794847069;
	b=CpGp/c95UJ6Jj7PR3SeMEV4WiWoLbPWQfLTxpgv8rKxXaHEUownpnF4Z8c6HrTMEAccp
	 QMjPgm7DHHAgSksRgr/CHuhC99HMM/hD0Mj6vyUtglJjEhS48wOfJhk70NZc54X8BVWCm
	 lds8FBUIKyqN6bOteVE+d2lCSOnhCYBYz4ChoScexYipT/U2WOWpu7tmATurhUj5IcgKd
	 JYs31upSXdUoL6l5DNGWEXCcv+yJCgjTkjAEBhl2s6oQ+M0NusaL2IyCpMvU8+7Mm/Cfv
	 3nmiVKZRucEFlKWJg+9IKM5vdCBWM5Ta/+Y7qHjVw3jNNZY7x81kfQgjQZA03NdoSsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847069;
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
	bh=2RTJ4kq0CC/NmzfShAvewKfZgoHK/TBqBAcNXTa+81M=;
	b=DfCdpL7x5Pv27N1HDehBAtGmKpTeXYHj50Jr/hikvCjPib91bRR8nIpNmCEcBXFV7chM
	 ym91QyFExRKtwmG17/1ogmu1VChzvWZqInkPbYsDsHQYS2DEPQJC3Dd7m5ERccbKSOIjp
	 2ovisFn1PYCtQFOlT4rWawOH6b4WIoXMtgqVlA5UZZJ6ixp4lvmFHi00Ag2YkVUkQQof1
	 yYMmMYaKMXDkVofNul5hq/Z/yXjKYWoPG6XLeS+UXz5ShqcUkra+5BcBfmRRXWfAMLCMn
	 9MeQJ6MpCi3uCPIgI8OzuEENj9wZfCL1RSu38BZ+kbkfoLwL9OO/Qlxw7kwAXKrqnyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794847069;
	bh=2RTJ4kq0CC/NmzfShAvewKfZgoHK/TBqBAcNXTa+81M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DbkBBgedCCGwhzmKy1DKA4ZoLvuRqkW0nSXHNIqP4Fz3NuTbMYmUgMEFHcUT6h5TH
	 RDpiggsDDhhS/lqeJVGnC6KtDmxe9/eEqHQ/GKrXPxZCDtJm7NwFcBs7E7iPG0ai8W
	 uaLHQr0uUKVDYo7kQehX1kM5q02+g/OnY2N63QxYGlm4HWmOmhEX4+6b07tPISx6Ve
	 4LP8ZuPatb7CDjdvq0+epGRPBLm2W6KqdsQThNUklMqhlQoBJvgJ8bPSvRHlREtJS4
	 t+chVcI7RzhhG2Mnnhm+x1FGiFVIkGcYtbPhya47HqMZQHhkWlEXimGWgVKS0WCOiR
	 FsE2vpLc8DkJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2495680FB9;
	Mon, 16 Nov 2026 16:37:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3640B169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27FD5405AB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWVHOL55e6ur for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C7E640597
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=gxDt821m
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C7E640597
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RTJ4kq0CC/NmzfShAvewKfZgoHK/TBqBAcNXTa+81M=;
 b=gxDt821m8maC1Wbcx4WRFUKO2ZrWBZN95VoSYY4InVe5E9efzlM/hf7cYEijQJ1aAeUWjxjj5SaXkBZzgjIGj8f5Ezfed/U4EmYm364uUOC1G4r7ib6Kk5PpGlu4Rtd6r2IQ71Al0oApSYofIetPATjQpez1bvAcQ20jYZMR6KmSXwyG+7ETbuPPJdYHF4mbQTZjssnca80GXoxtHh+YJGsLFpBboC7Q6zLiRi/hUSX3WOBfclpRT79Zr3cfQfKyrgR4W1ue59RhDju3K5Di7QVFi/RvyE/UfgzsU6juWrgNzjG6hdrQUALRlqazCW8wj16/FemU5fuMl3rhxi9RAg==
Received: from DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) by AS8PR10MB7523.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5ae::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 16:37:37 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::ab) by DUZPR01CA0047.outlook.office365.com
 (2603:10a6:10:469::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 16:37:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:37:37 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:38:21 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:37:36 +0100
Message-ID: <42367b3e-aee5-4c94-a993-a0b39806c139@foss.st.com>
Date: Mon, 16 Nov 2026 17:37:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/35] board: engicam: stm32mp2: enable simple
 framebuffer for the splash screen
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>, "Tom
 Rini" <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-36-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-36-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|AS8PR10MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: b0adcd67-92d7-479b-f98d-08df43ffeccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|11063799006|4143699003|260925021311599003|260925022911599003|260925021911599003|56012099006|261102123227099003|261021121427099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: x3cVumaW6UsdH0cKWCEB+ag3lYuPXjnlRSyC3/ZFtMIeYTsrTglwyPCY0NnpVMYb6kJc/rMDvYYA5PN+owPNwLYLEpVF5iL4HAGQhrvOTwgRPKnZ8cstBABj/i5Ru9VmWjHA/k5aWWgsPYyWYvV0OUyMOlrKuEJ5GI0ebSug+klvxILZwF2nBYDs/RGuGWyOKGaSi2KbP8ADGTMMBUXYdMFP5CiYvLrsKroDYSLu52ksx+tlAN1OhMbbFpbH4c6iGySEEVIDEAttJpx9egdK218cZpGuXy+e8wJfDuDPjTHYVJKlQufXGzFSJmURruU8owRHn2+EOwWlKdQKTiJnvDGHiN4AMRerEo9eOLTNUsCs5OzmtdP8I7QsU1AbCCGnqk0YzyESh+ZJJBcM3Zu1UrMDRzb7wQz7KBg0Cv65VNUL5gLBX+q2oak829RGsJjhPXRVa5zSP+ZETw6/BGkpoYcL9MjvRtVc9Rq39yPqJ7U6GtBMOECpMdK23K2Q1e7xa/qj7LIOzk2lZ84pINDUhHBtMMecvHxu5OGdtlTcGZyk60opkNVErLIqaV7YOUH+QqXggv3eBGkaV7/cwKq9lA/5UMbPlITDr/AhFHhBUuFCK3+3XEP4bN/4rUoYcdivETjWnzQC+rV4qk2wmnD675cZ7q5l5e+taFDfWeeMIrxMjEWfw8Zk1Asi1cvrmUjNZu+NUFg8CXW+YThzkEwq+g==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(4143699003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(261102123227099003)(261021121427099003)(261022075727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e5vjdcLrwrrhw6+8678UERiFFgLmUrdDNm9CNJ4rjZXUiEOm/GqbQ8s+cHN2gtbyJ1bwiz/AoxcaJ6jZkqqAa9uQ8hNIgbH0mLmNxGxRC+kh0ABliEE4purxsnmIGc8kHZr/RBcEnqYmW+h5+lyvDT/yRwU8qckYs+65xJy+hmovF9unWAm5bI7s9ZpUlYJsc6iWcqclij0CgtDmvlMh9mZ/JmEGtt/umw7CtGZrrGSnZDOYbBd7qJKCkglMTkY6encp+aZilY7u0QgsTZuNbm+XRjdARSIuuZi/j6QjG8S3boAILWwDhu5bPEX7s+DLeAALF8tRp+2xDHi3/li7V01aMZyCbSTdNlFhWygozPuWUVE6/PdujbO3On/5N5r+bPNBubP0VAKur2TGRUgR6DaqKtau7YhMi/3e2i82m8n3e7Xb4gGavKrq5jMUEcma
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:37:37.7481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0adcd67-92d7-479b-f98d-08df43ffeccd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7523
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
> Enable the simple-framebuffer node of the Linux devicetree to preserve
> the splash screen until the Linux display driver takes over.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v2:
> - Drop a redundant comment
> 
>  board/engicam/stm32mp2/stm32mp2.c        | 17 +++++++++++++++++
>  configs/stm32mp25-microgea-rmm_defconfig |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
> index e15141677775..64fb44fd7f02 100644
> --- a/board/engicam/stm32mp2/stm32mp2.c
> +++ b/board/engicam/stm32mp2/stm32mp2.c
> @@ -12,6 +12,7 @@
>  #include <env.h>
>  #include <event.h>
>  #include <extension_board.h>
> +#include <fdt_simplefb.h>
>  #include <fdt_support.h>
>  #include <log.h>
>  #include <splash.h>
> @@ -218,6 +219,22 @@ int splash_screen_prepare(void)
>  }
>  #endif
>  
> +#if CONFIG_IS_ENABLED(OF_BOARD_SETUP)
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_FDT_SIMPLEFB)) {
> +		ret = fdt_simplefb_enable_and_mem_rsv(blob);
> +		if (ret)
> +			log_warning("cannot hand over the framebuffer (%d)\n",
> +				    ret);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP)
>  /*
>   * The FWU metadata are stored in the boot device, the SD card or the
> diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
> index 73f8f7cf96b6..d5ae71354736 100644
> --- a/configs/stm32mp25-microgea-rmm_defconfig
> +++ b/configs/stm32mp25-microgea-rmm_defconfig
> @@ -24,6 +24,8 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_FIT=y
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=1
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_FDT_SIMPLEFB=y
>  CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
>  # CONFIG_BOARD_INIT is not set
>  CONFIG_SYS_PROMPT="STM32MP> "


Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
