Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3520606A322
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yg6gl2El;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=oyXn2q57
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1D59606DA;
	Mon,  9 Nov 2026 10:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id udrz2__UrCb7; Mon,  9 Nov 2026 10:45:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E154C60698
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794221118;
	b=oiRhGcQJg6wTXruMU9gKCalWZ3K19FD3xNq0lk8YcV742PxZjhbCDqKxbqWL0qHHba6l
	 kKGpF4FnClXOI0RFn7fXaOfEfr3AcIiL0FD+Pw6IR2ax/UDM9+f7nAnhPtrHR2RNTQzRq
	 QUK/0c0Ab/zqOo9yU1vK1c80qLPnLKXKhEjavPbzzlWDPy59I+w/dLheIu02zo2oC0+v2
	 EEsu97WwhTpsHpohy9mgY0NehqgE9Hn7nHBGVWSkjDr/tSzpXFXZCmBOxtTygLO/n96vG
	 xAW0d7+dSLdbuA25jaNQ5wxDsK/DTlTIri8bOMzUXsgrz6/ASDcqMa9ofAHI7wQMNYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794221118;
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
	bh=7lw5YPfnESU278foyzAPfoOZehloRAUukI45NwI8Ydc=;
	b=qh63gKTzTA2zTH+Uw2+QiXmXDZgPj9Z242npDmJ9/vjRbYR4pyOxcHoIEL5N1z3YDpzA
	 Q1pKA5YeR7aybtYK+NBG/N3fgISMT0JXiknmjl+WNPCwYFAvbjg3wxYuXarjpDbdCOwIQ
	 v3DsMnAjd72Et0yiT7LXHs0mYf7fnl16EsLDnGvVO1VkOdxTdWbXNpTnz7gjUDgCd4fcc
	 SwuK2gXbTS+zckrnly/MQcUuVQMwx1AAtiCzLYRQNtiK/atdTrNBB+YK5DFVI2kQj8gSb
	 rW2m7k+TiHDEFBS09nbXyxSmsutrHHop+LdskhQvUHkDq0gwNUJLD35jHUe/6vbNiXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=oyXn2q57;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794221118;
	bh=7lw5YPfnESU278foyzAPfoOZehloRAUukI45NwI8Ydc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yg6gl2Elyscy8ROiUqfUgtami4Y8BzlANzbwZ6LGJNb8anJd0Y3o8ERIUEBAfZ3H/
	 qQ1BMg2mHsL6vHUoXp7CVMt4fWakljfKEQeCYR+66AH1Xhp8XRdIR/AoP9+yfKpc0C
	 irbYmsYPqQDHtRpnD6mw/KicyJg8ToxQfuJ6q9Qd8uyQtqiyp8i5vOwxGsz99iqFV8
	 iikLLPQorHAcaSFv7QVx+VE6OBkod5ubaoHc32tE0/XEsrshbI0O3ltqO1rt1WWxPj
	 V1FMFoU9fdcgKkJgtTySOB4reUL0RsiRHm8DT7CGlqxOa8LUjPc8rciqIeoxRsjpQ0
	 WlSGnrfvpHYRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E154C60698;
	Mon,  9 Nov 2026 10:45:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DC68235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FA3A60621
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibLli5-YZ2Bz for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 10:45:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6ADF960698
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=oyXn2q57
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6ADF960698
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lw5YPfnESU278foyzAPfoOZehloRAUukI45NwI8Ydc=;
 b=oyXn2q57lLRRBJR7m2QQlOvl2ftWzVOu3SGg36H8bcBpnGt2lkzilqzrBSWXaTiIFHyKcAQ+oBCUf9WU/vMRewRHf8vgOtqmCTs7i2bA06sFvJvP96YfAJzMsU+iMyWIa+VTMbAWWk/DNpFYQIdOVOrmhgAxsyM6+qPu8p40wsIR0t0TifUV6DpQdsSJkjCsB/E1KL94rGlZ7TmAm6qy5N7lt0pxNjOlXu6qwO/9xUqbvwPToiRPmiWbvDf6oMhsRB1iBEqORepcSfNChRgPyr5MR52H4JnyxdVUaWAaT2ZWKDanOiuW3funmv390ImNQxxeZX5x7fWpbH83JhzevQ==
Received: from AS9PR06CA0224.eurprd06.prod.outlook.com (2603:10a6:20b:45e::21)
 by PAWPR10MB8044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:383::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 9 Nov 2026
 10:45:04 +0000
Received: from CPH1EPF0000051B.eurprd04.prod.outlook.com
 (2603:10a6:20b:45e:cafe::1d) by AS9PR06CA0224.outlook.office365.com
 (2603:10a6:20b:45e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 10:45:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000051B.mail.protection.outlook.com (10.167.241.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 10:45:04 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:45:43 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 9 Nov
 2026 11:45:03 +0100
Message-ID: <9e4b7c4a-380e-4e1f-a8dc-41f4d4daa4ab@foss.st.com>
Date: Mon, 9 Nov 2026 11:45:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dts: stm32: disable iwdg2 in
 stm32mp157a-dk1-u-boot
To: Antonio Borneo <antonio.borneo@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Lukasz Majewski
 <lukma@nabladev.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
References: <20261105165253.587809-1-antonio.borneo@foss.st.com>
 <20261105165253.587809-2-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261105165253.587809-2-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000051B:EE_|PAWPR10MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: ff75e44b-7493-4150-a835-08df3e4e835d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|4143699003|261026140227099003|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: THv64ffJ7ipGUMsNnD7tss5P7Ua8WnvPShVFieY1WfB6kvyzqxsqOJVsqDW+T9sC3DTmhV6hZC8cye6inaSLnKUVxiWR2Zg0VhnPclCi/fEENdk3gQTkSaEyWj5IWRJDdEn8M4nDBDicAKq0jnEUv7KLZOIrdJp7+dVhu/DkWFnXC4Y0SGCYwbcM4Z1OIMR8Cmd0WljAg/4IxvLmqTbS1dxfqyviNukhPq7IW1Jm7RFSpYEGgLHlD5p9vQOMS6TG8b93qm3GNawpthaFLWgOg/U31yQamCxLhWZgElNMvLMzzIDMglNRtrjtBwrTxpKO5S9JFvacpywVlhL2KWdD2kroAVw1ZNlrHBtOz0KK+2zFq2VHFA8c+xYxtxX0QQSv1HHwMGvHbd0tl8DW3F4smPW6Z1Ck5ZKO/c0fwjPc610iupWd1+3Ay0X4Eiy98Nn+LE6VQzf4KGA7sPoGV/wkd6EUyPAs3yDQ31I8CIJsFqtdfET0MrsTMGSfXtLv8RYy0eOFbP7H+4FT36PRuyv5fcRpuJLuVWxe/t1LSoQ4Txov2v4/61c8tFopXqDWJkoKDeEx5VNkQkcrBX92k+5ISDKNiNdSpGnFCs9Q1ANboQeXja73WZph2PrWzHybPz7iY06NbiNpzUfymHFAM4LZYUQ6YOVazaotr/FVXuu2TYKd7MJLFJJet32Wj5GiQF+gzRASfceapYA1hc14C442Ig==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(4143699003)(261026140227099003)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bExxzmQBqokZnmWL7Rv2EOID7PcY+uiP4mq4hNZhH1NT3OlpA46AcUAXPA+8p93uuJ3fvPCUJXniVAGOD++pHqmUZZ7zqZb3SKQh3+qsf6u48Bu5KwqrTk+uO2Uy74Kp6nKeHyw1JHI6u0O8hXCzT2GwvxHwbTn19wRtJq9uPZlNSG75Hy1mLiyEkuqNsE84WbKyPaZ1RxJRPAYoPtb+LZ0H75E6JvD2x8Xhap1/iKONzBbVn+ymhoz6PmO1imCnioURmYI5q7AQwG+f2BDnCP8EUFNWk9hBmiWqF5QEhrcMzgPUep+WuXInxlFS9PNGCltjDEU+NlsEcFcFaW/f22/I+ZpoGq4zgjc7yRs3FjTa8Iu59jx5tRwyog2RpCCLV7qspQ/GK7Q3LcsjCQdP7Ycmx7bAy0H7zJjHFwlvq9rsuxWIEQUPzVFX4dv7Q6t1
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:45:04.1263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff75e44b-7493-4150-a835-08df3e4e835d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8044
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

On 11/5/26 17:52, Antonio Borneo wrote:
> IWDG2 is not used by U-Boot, but its node is enabled in the device
> tree inherited from the upstream Linux kernel.
>
> Disable the node to prevent U-Boot from starting the watchdog when
> 	CONFIG_WATCHDOG_AUTOSTART=y
> as in stm32mp15_basic_defconfig.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>   arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
> index 78ebc3d3ea3..4ed747db6be 100644
> --- a/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
> @@ -88,6 +88,10 @@
>   	};
>   };
>   
> +&iwdg2 {
> +	status = "disabled";
> +};
> +
>   &pmic {
>   	bootph-all;
>   };


It is preferable to don't deactivated the nodes activated in Linux 
kernel device tree

in u-boot specific device tree (Add-on device tree = <board>-u-boot.dtsi)

because you change the expected behavior if Linux kernel is started with 
U-Boot device tree.


As you just wait avoid to automatic start IWDG2 in U-Boot, you can 
use  "u-boot,noautostart;"

and the expected behavior is handled in UCLASS function wdt_pre_probe():

- by default : autostart=IS_ENABLED(CONFIG_WATCHDOG_AUTOSTART);

- UCLASS override autostart=false if  property "u-boot,noautostart" is 
presen


So I propose to change:

+&iwdg2 {
+	u-boot,noautostart;
+};
+


regards

Patrick




