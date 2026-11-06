Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62347606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NeFSvYXC;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kKzLV9Fi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C86E409A3;
	Fri,  6 Nov 2026 18:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ClWlHpoHQTvZ; Fri,  6 Nov 2026 18:32:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8003D4099A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989933;
	b=QoXlYUAwehw3nlcIT8oXecMnGqZo68RcOypSZOwtA6znyu2fLqfLfCfwOkQJFahZ896z
	 qX9pNBHfxto2DyOa+pIC4vZEmjsOZoFDHgoIRg00wDWPIib+8VDrPhDRTyAHrChNzhpLT
	 LaSGBq4oDmbkww8LORYBKrnewcDVBW9zc97QlV8EHtqltzs9c7gtnGisqm/jb5GbHUf7l
	 YA2wi4qmLjvlIaMv9YINmMIATSV5erzmn00r4IMzG3XWUQ2CGR+AjQtnFQzu2o7AuPkQX
	 wTZVuOHn8rUzB02z0tpM6Io6MvfjDcochcBNkTmulRSepFIta972sG/yug2ZSGc4a7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989933;
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
	bh=b2knQ8+bejNVYbUzZm3tP9017nbKBjkfGwgWutBzNSU=;
	b=szToDZ6iM/lChRIZE/cGFTgeeThxxsJOuX3+OXxCX9pl2Inh96UrXHpOi496UMVmNXym
	 7/yuawCwDOh8s1WpZhYwWnKMxp63ORtbJ/Byy+KhUussbS4qm3OadEZiQdTd8MdJPktqf
	 f9g6eJRmJFfHRu2BItOD5cvYzXdt5nv5ue7KlyK3dLKl43a2adaYEgKujEOYwKoiY5KAj
	 3jqossC8gl7SbyjR2stKVMFfulc5O9i5vGt1Eaw/G8UriZbaL6jI2y/quSfk2GTFFMWos
	 YRHATIW3HZmSDWneS8J2SA6yniql6lncBRH73ga+qnhIbk0nZJq9Jamr4xKH54uO5Cg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kKzLV9Fi;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989933;
	bh=b2knQ8+bejNVYbUzZm3tP9017nbKBjkfGwgWutBzNSU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NeFSvYXCpnmiR4gie6WGaDoGbiceDD7hZboZZM1/s+AweYTgin772Aa163sQOsCB3
	 5r9nkVVnVd0YWJQs3PMw/YOLKdQ/RejUNYfjtaIOUq1zTd+KchNdp1Rtlec0znidjG
	 pOIF4O0UTD1KPIXsJcixdJMOULsx1enq2+tFvqpkIuLK4doWNenI3O+AahhL2U73G4
	 c2xRs0eLt8ERC+iRPtAPSSrWUiojPM7/RcHzL1Gu9HwYywk9kxpET6sc+IrGnHvAME
	 nHynP670zNBr2YFskuWPT8mp6Uy8tc0s1ym3u4X2hhbfuf/6pb2TtcL0s9qfzpzZC6
	 Ll5Vme2TyEc/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8003D4099A;
	Fri,  6 Nov 2026 18:32:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD0BB2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE2554099A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDGVCq7Sa37m for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:32:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9BC240996
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=kKzLV9Fi
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9BC240996
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2knQ8+bejNVYbUzZm3tP9017nbKBjkfGwgWutBzNSU=;
 b=kKzLV9FiAWtHT52IQn0aK0YrRvDcWTn66N+sM4kVA21n0XtP0ScWUZP7iggbWvfV5H0RE2gyV/Ke0qE26G7G8NUB1KrRvn7+NBvdPylWegB2DUdVmmOIluRY0lQ70TNyFGohqwtC87uqtolABLgJdZjU21fRQ0aacdpyOztgdcWYM5vfs+0lbHnde2yMC8jUend7GsbKvg0KTMA2X4HiN56hf5E03vBebq8JdDN3Xc7TnO7dZ65XdRXBZ5+wcZZWyq3F84G9+3gr66E6y12kFmr6NtbNG1IqN5NmEqu4oE7CNbipaFS6kgaTWPVRC/JNJLeQnZuloac5FMeSss4caA==
Received: from PAZP264CA0089.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::12)
 by PAXPR10MB5518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 18:32:00 +0000
Received: from MI3PEPF00008553.eurprd05.prod.outlook.com
 (2603:10a6:102:1fa:cafe::76) by PAZP264CA0089.outlook.office365.com
 (2603:10a6:102:1fa::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:32:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008553.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 18:32:00 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:32:30 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:31:59 +0100
Message-ID: <1b66e0b1-4b08-452f-a775-633cfd8ca543@foss.st.com>
Date: Fri, 6 Nov 2026 19:31:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] gpio: stm32_gpio: release RIF semaphores before OS
 boot
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, Fabien Dessenne <fabien.dessenne@foss.st.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Vincent Jardin
 <vjardin@free.fr>, Pranav Sanwal <pranav.sanwal@amd.com>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20261106-upstream_pinctrl_update-v1-0-4f3d4f6e97fc@foss.st.com>
 <20261106-upstream_pinctrl_update-v1-5-4f3d4f6e97fc@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261106-upstream_pinctrl_update-v1-5-4f3d4f6e97fc@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008553:EE_|PAXPR10MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9934a4-47d2-4cda-c273-08df3c343f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261022075727099003|41080700001;
X-Microsoft-Antispam-Message-Info: RS6vFuTq9X8nzDAx+04b3JXrhxSGHlThfyicEXFF7vUlRpUPhVkMQs1lofD1fXFHDvm4GhgymobMccs8dQPQRdZ9hwbEHibDO3RMBy6q+IvRTmiSwymo91gmlVBUvkgUvRLBHVWmNeyAZSmE8XXR2ARZ3RrRyPH/KkxGUSzrJn1J3R3teoyGtg29g0GwgtY93Niq1qtpZdmrIJz48kpBZjcE8PONmEwbAym6GadTf7M4YJ++9Fm7Z9QuXfEv+7Tx5+2g/gZn8yrBdnSjwYPjh95WavIE3UJbvlySxkAcSI5DKjfBbhywaqY0X9503AMRm5bPAadE7CIKlvoh9GVOliszQ6rlJ3FgTws62T17N+TTjWUOZ2V1QxTzQcsZYhE6B5pJ0nMPy4HCKq2LAYamqL2ta1rZIoi4bK/ZbRcEfuezGT+ngNGnrImcOLc2ZTAxnEH/Dhl2UKMr4JLilGgJVVWClez1YPyXmUbsHuVCj7qLFZ2QBVBYXfJxCUmXhHbAA9iL+gCG82KFdURrRzGFLgOBIB7buHA7CTm4OQAsO2rAj26jT7GAQcttDTXyGiIontUKQ4aUP6Td+yn36y9ZFtAD8QE0Z7ikbuDXepmnlasdnTTspNMxeKwa031FPtVNhoc+9KXc8LNXTPp0tBUoFlUZ1S3y8gKUcLTlfr0O3GbqMejM62wJVQWbJA+cNk+xXvsZG+TJfChuHMumSNuEnaeGlwi0hMcz0emep0OFzZPvXT/R4U7pN0qcL8H4WDqLkfWnycpoyvvGX5okzB5vKw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261022075727099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vXHwZRsP73npBueiVpKkxiKMIGTBLskpG7yX+5LsOF0iqqOzAH+vJKSOnCVTxHAImNhH3KLjBM3nS0EkMJVkWA0do7qqrTLk7o41hnF1YQYEevLixsMGUz/mmkgVRvRUsbkurFQ+7+unpSQoQ7zKrgnJ0hfOlV7La7o6JQqPqi/jAiQ1XIi4kOhO276p+FORx2VqnSe2GkdnZcRPzK+8Lv2cllfywsg560e1HRK2ffk1P0aovxuZ4oekuhVsLh8fd2HiBApuQyVa60YCBHd9jfko0QkFa0Y0nw3UivSz6nu0ISqbM8PnY+nUFYljiqZ/BPiQHFk+/9xln3/1wgeMu3yhyfWXhDuMuFfFYynG/XtZuBrHpmDIafdSWfZjI4FXDb5D4zvSJvSQHav1ZIliqVxoOvIOrm2y5OY5/8fR1BHMo8PjcoKeIH4lz4V3oeV3
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:32:00.2918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9934a4-47d2-4cda-c273-08df3c343f06
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008553.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5518
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/6/26 12:18, Patrice Chotard wrote:
> From: Antonio Borneo <antonio.borneo@foss.st.com>
>
> GPIO is a RIF-aware IP, meaning it has to handle its RIF configuration
> by its own.
> The RIF semaphore can be acquired either with 'gpio' command or
> through the pinctrl's set-state.
>
> The OS in the following boot stage could require to allocate a shared
> GPIO to another CPU, thus the semaphores should be released before
> the OS boot.
>
> For the 'gpio' command, release the semaphore when the GPIO is
> released.
> For pinctrl, release all the acquired semaphores during OS prepare.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   drivers/gpio/stm32_gpio.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


