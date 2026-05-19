Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABCFCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49F5847D9;
	Tue, 19 May 2026 15:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SJEJOKNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDE9847EF; Tue, 19 May 2026 15:51:03 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E40E2847C5
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOZ0LJuqrRjaWSsOwuTfp81LTt2ausJIV2KHAIigrVl35QVbkP6mBIDJCC8UKkxE3qSkI1Avd4OcLx3PPCMNpLaubvh8Lsq5D3op9+jmP4nKCnepFnbFApVcyE2XFSDIm+yGTanKFdWdfk+jw4ZK27Bz7ecrdtCplF7Yd0jzKeJRW2WwSzvDILK7z/RGN8L+n91RNNGAd4DUHRsb5Gme0ZTaDdCSLuFL1EdCadfHxKEjlFhc6p6CQt5IOJVn5TN97ZXckgGhrLlNdKtL1lqNpvngWFLoBWKEchTwIJYyqArg0WxkKZXaEf4DbihWtTRZHtFJWZSd8YL1tDoopkFzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwXojLMnU9JGckwermgHxeAnQwVARqBqfGJhgsdFOE8=;
 b=T1ApoI/T4YU7VhYHS+ci+OM0YakFCBHdoW28uYZ0H1eS6LZyIGCZXL+NwOx6Ssyk9tb6CfvrCEAjHROsFYeIFhzVVoqdPvJ7KI8jnDKLsLyHxPVryzUcujXzSTCMCf+PnE/Z4E+05/jluApyEZs6IBxrKsb2O2tAs5I+ifO40SXeXWGuWfA5az4cd8p5kEbqsXz2a+PX7vfqE/83x1EAH/Ym3F0At4O9qKM+Hzxn9obEz5AOmSpbTdvEj1sO0+AC65YfOMhJVPahGNsNBszAWZWPO20VuES+vkN/NUDx1b90JCghPIsGVsphpfrQn69k7TOqS6BdPsco77PtV15niw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwXojLMnU9JGckwermgHxeAnQwVARqBqfGJhgsdFOE8=;
 b=SJEJOKNi8s5LgzpsCtZ2EeXcqp/IDZZvCVe56z9sSiMaw5hK1jvIt61/oPsunwY1Z10aEvSbIck82FLBFd4n8VtJNpe2e9BOdTFoCjZ7NQrBCq6Pxh0CQuXG1bmUYERVUpvDBdmoW3u4Abv4RPP+UvhbsTY+GYw7p4gdUwru+/BKQVYJVzXiJdys4ZCYWMYi3RoKuZmJ05IfysD9BEky28dyKcWELCmB467bmv4eJ0EKQ+xkx42W5A1svUYnlABBBJWPkqu5UmTQeneUN3289Ny7bqGQ1HNSxJ70KeM4MCvey+dn2e3fjjOjya9tV/K6jcgpweZJItWsXcT9AzC/0A==
Received: from CWLP123CA0205.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19d::7)
 by PA1PR10MB8670.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 19 May
 2026 13:50:58 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:400:19d:cafe::5c) by CWLP123CA0205.outlook.office365.com
 (2603:10a6:400:19d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 13:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 13:50:58 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 15:54:51 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 15:50:57 +0200
Message-ID: <67735aa2-d7aa-4455-a998-ec2efb009716@foss.st.com>
Date: Tue, 19 May 2026 15:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: stm32mp13: activate watchdog
To: Yann Gautier <yann.gautier@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>
References: <20260519080737.47928-1-yann.gautier@foss.st.com>
 <20260519080737.47928-3-yann.gautier@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260519080737.47928-3-yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|PA1PR10MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 363bf547-669a-47f8-65a8-08deb5ada815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ee2ypRcXK9sSLRf2943voPkYI2mR1Ea7qC5dQfSQju+yKT40KatUtdbSOHAqznt1fxoOWKxo56uzStMxBvcLMo3NOXA1iwyJJZvglv+FktHPmESkAeZuGDaCBa2ku2x7y0nvg28c/t1bwQgSmwPeuH4spgDc1owL0X8M2oI9ddDO0ztvuKewxrvuAEUAmOUHRY4C1MjLAR2OA604fRO15YmFGyYLG4Bah/1bnVAf7YBnUeHPV3syhMDj3ZHmolESgGnNLyKGE9+XGyrVD4ZKTE8HQb4VZFe7yR4PFusRHv7fcmdufrZZTo8J3hZ+1SwL90xvQd4/VwJDkGZ2ws9qDXb8XLn00T4s3YWR4dz+KpeQNa777hvrmDGv+l33qfyZFl4AQR/6LFzO60NgL93vYgV2FPD96OQEFJCWdFPsgAcBmHDQW8xpdl4BliZCI0hNi76mHqzp5u9WEfFnq801QsZZcDWRSwZxiOfa6oYzQv8S4nomNl2gKtJTXjjpKXwGdB8dp2iP4WOV2KEMfqOu9Pj8+EG688zgFf09G/gKub0E8LL4okegN1AHGa6PdiJxMlEsqujHesylIgU0GazfjQFPDoMQH73RgMgVzjacNw122MZChjHA1wP/vrgZgE4BWbacqMXQblSmC6gPVo6iCaH55pQoSFzOrKuGdF7hRZBFBTrWuALLCpwiIQuLb2JgDAekC1Aqdp3iABaNAUXOzZdb2lhOqCRTCYkiJSe7jGM=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sU5XMLQM/9ySINRr6FneynYsWqPqTpGa0VVGaFc4nPe0FFp0+xIA+ri07Q4IYYNFKcXAiMPBJczUL1dB2pDT2zAvMcKXZFE7AaX5SDsxKwdodzvmwlRE0xqQwFoyhHmTJANopfnz7vBnNfcx46syoa8lbcZboafK7Hmhmig6RXHQEzslyWRUnwr0MnozLvjdwUf0Q0K2zDWqt2UQFJu9MRrW9aiINwQ3LM6rJSmp/ItE9dnXvqIUFJIPisUQrwJQAF286QlQfgYzOVx8FLk56c3xL+KFjzMwiiLQGskjlPKrT9mjeSIHhDKurz1Xbng1oYzo758ZVTKVgP8o9IGX1ihuxys7bdB6T+MGkQfUkIVkYYGMg5NtAHEkDBi/AIGfkOYJQeLhemxNcGVvASlg62M77N9PXZeuifWbjhFl/2QA5g0wCNerOT6zCghwPiQB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:50:58.6253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 363bf547-669a-47f8-65a8-08deb5ada815
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8670
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



On 5/19/26 10:07, Yann Gautier wrote:
> Activate the watchdog for STM32MP13x.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
> 
>  configs/stm32mp13_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index 620a6da2efe3..cc41585097c7 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -113,4 +113,7 @@ CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
>  CONFIG_USB_GADGET_VENDOR_NUM=0x0483
>  CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
>  CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_WDT=y
> +CONFIG_WDT_STM32MP=y
> +CONFIG_WDT_ARM_SMC=y
>  CONFIG_ERRNO_STR=y


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
