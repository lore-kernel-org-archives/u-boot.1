Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC8606A32D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AA7wC0S2;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=R3PAWGug
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71D6B81638;
	Thu, 12 Nov 2026 08:47:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bl_qietLqBDh; Thu, 12 Nov 2026 08:47:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C8D1815FD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794473221;
	b=ldunUWRreqjODcVm+ws5nECTaHcjPX46Ga4frnx7ss9+4RWd8GiQL0mhMbBawZtv9dda
	 q+s/dm34oi7vjNvoJUSXISUevrCPWtKihg5YSWu3m6eHVgmxzVjx8VE3H1VjIAg8eYNNX
	 tGxWuq0cRAuOFq2susQ8fo5QF6F22tYMrsEGsc6qXuacO+MpOb+42XvuIskGK9JpzQYyU
	 n9dpdfHcTu7gXiAPBNSqw7NAM42GgaqNsp6lk2l6ZHA9ptwcOz4ucivfKzcVWJrTdDz+1
	 aRMA158SO0b3JWG7XPxYKSlg0IQbVLeLQ3AWEmthtoJkHidpLFivhh22PawQSNyy+hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794473221;
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
	bh=SkDMVCp1Q4ugw+iejeV6uHdgLKdkScWC5p+cgO+tXyk=;
	b=Ig9M9uLK/Ab2/NI5BcsIOFbtvRwj+OePHbNim8GI0cvVkCcJijfkc+vnky2DifBZW2xS
	 G08jx7MFYSoCbwF8jgbCUSvCKzvTdYQ7q87Wq5RjaFP/5jtTFSofUkQgSEEIXURj7tfSA
	 lXvF1ifykyQAy5fYZ84b7J1m0ipbcVuA6SpiFXeFf147UcTWKsNV7Rn5V2FUsj+GE1Zcs
	 OOcx0gNVzUWsA6ftXdUUO+0ied4wywpsZxRa+fCuRx2O9sMbQm7yvPqk5Z2mz6l4fXzAS
	 FdWCjHomrt8CA0YKhUCdoRVqvwNpLTgbxghh8SPDsnFt27oE7RjjFJiBupVcDJMG4Ng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=R3PAWGug;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794473221;
	bh=SkDMVCp1Q4ugw+iejeV6uHdgLKdkScWC5p+cgO+tXyk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AA7wC0S2yMa7L3D85sWkPqKN2qJ90vaRzb7uNKSgVYHiuTcueULsyDLYf7g4dlxZY
	 XySE6hbgFwmH1rOVrK+JAAEmRXjDenSXkRpFP13Noqb8zM1oC6Cmyq4pKgogDpgRCW
	 T9IuWJQu3pIRVPpeay5lZJ0JZ55ALI4BP/8WU9WFrl/RSGIrmKfgT5YjR9Ssb5k2Pb
	 2l9hl4FA3KR8sBGp7bkpQa0Oiplo05UsS+stG404Bekb83eDaLTHfsUgKQHZjZMH2s
	 JSStp+yLK8tvvM8MtqIFe0jsKvDNiGddsa8l7zXFW72zvG3kPcr9H7u40hkJjzxNIA
	 gr05aIPVeb9tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C8D1815FD;
	Thu, 12 Nov 2026 08:47:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA882156
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBA10815D2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:47:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BI8jrsAyz9Ob for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:47:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A1101815D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=R3PAWGug
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1101815D1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkDMVCp1Q4ugw+iejeV6uHdgLKdkScWC5p+cgO+tXyk=;
 b=R3PAWGugXYpjEpY1fICOSgEmODnK7o61Iv+O78/fR4kZ55s1VAJYmHNmKM4SvOnLbZYBZTh1nA2CIPOr/y74BG3mpO2JTtveWIyRWasqI50WWeUI5hq2rL2zQEF3sEixeQm5bpDr0ZlXACv71UTQTyCvTc2+YHNKniVLmH+diVpG24l1tVVFx/XNYXNgKRmVBLuQ6Y3b+WL3n5iubMNxs6+dzl8jVP+hnjs3vB/CFNjm+YC8epFt3FaMBzlEdHSV81tGGBxo1LAzfZ7wtOu3IR1HX+3sf3PPbMj2sDSLVrAXGGpQDKP/t+HTCQ3JnT7wrHFkUYEVLL4GSEnL92N1lA==
Received: from AS9PR06CA0730.eurprd06.prod.outlook.com (2603:10a6:20b:487::14)
 by AM7PR10MB3317.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Thu, 12 Nov
 2026 08:46:53 +0000
Received: from AMS1EPF00000097.eurprd02.prod.outlook.com
 (2603:10a6:20b:487:cafe::27) by AS9PR06CA0730.outlook.office365.com
 (2603:10a6:20b:487::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 08:46:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000097.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:46:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:47:50 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:46:52 +0100
Message-ID: <62d74dbe-5a78-4eb1-a845-6f5c5ce55628@foss.st.com>
Date: Thu, 12 Nov 2026 09:46:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] configs: stm32mp23/stm32mp25: Size the frame buffer
 for the LVDS panel
To: Ana Bobillo <anabobillo3@gmail.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Kever Yang
 <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, "Andre
 Przywara" <andre.przywara@arm.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <d49cbe10-bb1b-422a-9bbd-f78970fa131e@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <d49cbe10-bb1b-422a-9bbd-f78970fa131e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000097:EE_|AM7PR10MB3317:EE_
X-MS-Office365-Filtering-Correlation-Id: b706aac6-da0a-47cf-07ef-08df40998036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|7416014|36860700016|1800799024|18002099003|22082099003|4143699003|11063799006|261022105027099003|261026140227099003|261009223027099003|261028144727099003|56012099006|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9NnsGo50EWTz9ihcjPf42iKCzqXrT7ZviVSMSvkvy9QVL58kg4cNqETY9wjvHJam5EFfaNpqO5T3WSRzRlArEhtm2AqPYF8OHREtknmnmdteC2UOYnNykEVsdhmfsLS8QhYoyJOQ2V539rKnyJaSplpNpMOvCUFLRPM9wl5O5EY9hqMUitsjOb5WkgmVF8nWau06f0F6QvH+TorX/KjEZv+CaGN9io3O6h/1X9cZUJhr/oKG2NjIcvg0Xxi2EXRBvPf314ufnzQqAvGDqSVYdNs7cpkJ9K4rolOun1Uih6wpvB5U+qA3d1vUsjyyVyODU1plamLjFTOMbeQiWIBeMwtKOaLg6q9dlVTUZJWEeTgMsg9GGxJfECtV+ldeJLekK05yus3K52GzHFqPvnbOZ0sQax7CnqguRtG30IJAyesN3qL095Cj23WlZnJOlXSTl5hJx71yAi9VBpf4menCHaco1RlEKtFUmD+KwwAxu/ySVSxF9V7SZ7JPNkrwNXDdsK/Fd55t9XlOldwK2HR5K56JxRifsRkM8A/3oNqDkV7NyvZUV7c7X4+WlTAHEaDL7wN/k4TxHR0X5RA2W2VN+TXWevljDsFuOdAgXBCY+mErGdu4CQDTtsSpv60HTcDeU3hTmNOl7B70Eh5vIvze5RD7Wysr8UzdupVKFC3hriz2lGOhyusM5axNRmPccXwigffTNTF56oQ746rvifFVLQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(7416014)(36860700016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(56012099006)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dzxKiYQ6WhqfuTbIM1Skf+9j5z7ScwNGaALobUTR1kkVcEJc73CFhvYCCP7kpUircCbpRCUMVA6Uca4m+BSXWjYBAzkAXUODOFO40THaG0T0aujCW2KI1NopC368Qqj1z/Aj6463It8Fjf1ncp9RGSdaIgalhIjbRNCOvawisK5XmgF/eOc0EuAFDAweQteDbKOPindXUfoZxjCsDoU/DsSf3WCxxzf4Wz6IosepEA3vMw5sqi37OQQ/AOD6d8lMf9/kW+o1bf55EAsxbxnkgrIHHCzCLOYzSYkZ4FUZl+Pg1BYxSb4dJJL8BZGOOSihjVdMbSFWbtAMMMQyRgwg6CotKDTn8wQUvxFK4Y7fgotiLENwDu//gOk94UgXKfGYp/gv3v8xHbMKC4Gp9P6IJZd0qILG7uv4XCsWqagu+SWj2aX+GoZmxCb0DqnGQQRJ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:46:53.2393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b706aac6-da0a-47cf-07ef-08df40998036
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000097.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3317
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



On 11/9/26 18:28, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
> 
> The boards built from these defconfigs drive a 1024x600 LVDS panel at
> 16bpp, but CONFIG_VIDEO_STM32_MAX_XRES and CONFIG_VIDEO_STM32_MAX_YRES
> keep their 640x480 defaults, so stm32_ltdc_bind() asks for half of the
> 1228800 bytes the frame buffer needs. The display only works because
> the frame buffer is aligned to 2MB, which leaves room past the size
> asked for.
> 
> Set the maximum resolution to the panel's, so that the frame buffer
> fits in the size asked for. The video uclass is about to check that.
> 
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>  configs/stm32mp23_defconfig | 2 ++
>  configs/stm32mp25_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/configs/stm32mp23_defconfig b/configs/stm32mp23_defconfig
> index 04aaa0f6b26..8d960a51e02 100644
> --- a/configs/stm32mp23_defconfig
> +++ b/configs/stm32mp23_defconfig
> @@ -97,6 +97,8 @@ CONFIG_STM32_OSPI=y
>  CONFIG_VIDEO=y
>  CONFIG_VIDEO_STM32=y
>  CONFIG_VIDEO_STM32_LVDS=y
> +CONFIG_VIDEO_STM32_MAX_XRES=1024
> +CONFIG_VIDEO_STM32_MAX_YRES=600
>  CONFIG_WDT=y
>  CONFIG_WDT_STM32MP=y
>  CONFIG_WDT_ARM_SMC=y
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index e55ca2e3f0f..ac9f562c8ed 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -97,6 +97,8 @@ CONFIG_STM32_OSPI=y
>  CONFIG_VIDEO=y
>  CONFIG_VIDEO_STM32=y
>  CONFIG_VIDEO_STM32_LVDS=y
> +CONFIG_VIDEO_STM32_MAX_XRES=1024
> +CONFIG_VIDEO_STM32_MAX_YRES=600
>  CONFIG_WDT=y
>  CONFIG_WDT_STM32MP=y
>  CONFIG_WDT_ARM_SMC=y

Hi Ana

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

