Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210CB606A882
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xGueFhb8;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Z3mq2zTe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA2AF406F9;
	Mon, 16 Nov 2026 14:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBREgMabYzHl; Mon, 16 Nov 2026 14:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1D43D406E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794840347;
	b=P9ZTz5PhwPUcVQxcXcGzL0jLezRkTTMbE3ndIfS5efUQ9beXsGpm77mzN8+GV3YzS0Bu
	 RS8hm6n8+HggTjQzJSdQsvTbhuC3EYc1VEHIE9V/XXjWkb4WVfivDauO4HjzzFJYCLerP
	 IX56SZen6ytmvLV7xpAwEh0s/qBOLk5Phz5BsAOGeiR+StQTlFiBcL5p+h5ayU61NTJlw
	 tdeZN1jqjysQeA2Fm605OjjoWqQZovvsC4uL+y6J8zSowb+LnN57Y17DAKF/aP4seOYaI
	 zeLr4njbhR3pnysNUyVpJg+tzIpkTOjVyBVwC6b0CKoYlk72DvcKpNHXnhTAjvF35Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794840347;
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
	bh=PtYveSHypJV3zJxkzDV3oFBpsw8ZKKmFudHVtJT8JZM=;
	b=dL2j1kniMSDWOk6elec5D0yBd02Hk3WEFVsaxmnVasKHh3pb/tQyMT+sgGPlEdZg4nNO
	 qjsYsftk4uiHbIi3k3QGlK8OxclUM26leyZVvKWNBDxBPrcFAStoAaa2Gobb8ri5XTNBa
	 KIlv+tt3XJ4+67XcpywEMQH9A8rypYw0FdK/Q5+/Hnw2SdluFO+h2Maim5qu6+bEF27Hn
	 FJgDKBZ4qbEbVHGSh0M3JIHA7jE1HBZ13cQuq1+R5td0avcuxS19LoInB4YpjZ5rtXfv/
	 DkPbSNOpXv1YKOEmXfGq1R96kprYKzRTfUolpnhr+KXYyZoEjsfTKCxkjRn7mnpuTTg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794840347;
	bh=PtYveSHypJV3zJxkzDV3oFBpsw8ZKKmFudHVtJT8JZM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xGueFhb8mQdF2Yl7F7MQCYLToSOBFwKTYgsDM4yytkH/XzeyI94YS9j683iV0WsGG
	 5dI9xg7hhhh1M3VfaCCpX1pM7y1RyrNJjFnmcrX/NZnt57dtnfPcd4JoO5RfEc6jvy
	 mMAJM1XkPm9yi4xfxNXyFwtLRAzDcu8+pF1cx0OydREIJuUm20JsAX3TxSpN0U+uXJ
	 wIPnwhzMbnQ5A7yIWdar74fQUOpzlg2mbXW9LzQgXbyuYfDvvzlyv/MErwQkIbHj9E
	 w1cbJtf613XCpGRUwEzo8FTnHtyzyH64OP0gB2rWEFTMAsHyF6NjKiSjVrIcbxa3BX
	 /GZN0nJ8IpZ/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D43D406E8;
	Mon, 16 Nov 2026 14:45:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 552B628C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34E8380F34
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:45:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37kWftlqV7OQ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:45:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E1DB80A8C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Z3mq2zTe
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E1DB80A8C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtYveSHypJV3zJxkzDV3oFBpsw8ZKKmFudHVtJT8JZM=;
 b=Z3mq2zTe2ssD9fU3W3Zq5MYPC7FB/qD7TQ2MGGDvFOvfC6yum4+t3t/5AGtR+T6kDv6sFVUV0blmsKuc9LBEBt/kFJPmQmry6XbQHlDUnYixnS5cA51W5y9jruvqrYumFtvuVyUcF7Wu4q88S/fjszmJzUkySExEI7R0rhbfD5MEW0pzkQ13vIfVFjpr7KiodceH4QThpEBTu/GNTItprZroMY8690kh9HhHfHZVA3YkEGB8upXqMQZDzvw07c9RfYgM9UCTaRIN8pPH85UOie/bM07olCDecU+ImXqaMwOtOXeTnF2tOCIRbUGfRzjbtVDBhpMh5Lci/hrJQqPKNg==
Received: from PR3P191CA0060.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::35)
 by AS4PR10MB5176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Mon, 16 Nov
 2026 14:45:36 +0000
Received: from MI3PEPF00008556.eurprd05.prod.outlook.com
 (2603:10a6:102:55:cafe::8a) by PR3P191CA0060.outlook.office365.com
 (2603:10a6:102:55::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 14:45:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008556.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 14:45:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:46:35 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:45:34 +0100
Message-ID: <63973f08-733f-4f03-8db3-43ef99edba99@foss.st.com>
Date: Mon, 16 Nov 2026 15:45:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/35] video: simple_panel: add Ampire
 AM-1280800W8TZQW-T00H panel
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-29-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-29-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008556:EE_|AS4PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 09db317f-7eb3-4b71-b843-08df43f045ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|4143699003|56012099006|261021121427099003|261021135927099003|10067099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vn/DRTYKxPts4jkTlJZ3leHhKH6mz4ZGbMrvTiM62sRjuE+gpzBjv0opmEfCPSdyOHF7AvSxxSeDbmsWArsO4FPdB7qtilDow3sLQsz04qakGz2BoNAculuU/o0O9ww2IhH6CzpP/qCxEx7XMoVtbZkVR3uFIfzNI94y87PWpAC0egaK8F45l/CWnr23bST54fM6nQWlmL8EUV+3VxxVdegEu/BM9nOXRzwONEsjDz6IhQdBmf7QTIvdNfLPjlz8lQakS6mEuSxbZICmC+p6DJlKJcoqkQZhajgbl08XR/5a3tG7n0HlT/dagGPMSJGiNTxLYf4fXyWd5rCugyfaemsXlHLSX2gsCOmzZWEUQSYcZ/O9McxcsDBqAObHrUqE0UGkqBQccSW7iMJVT7iYHpqfE5MyP5bSiBfigk/lpy7DxCP6dol9RiuLkLTGk8Nemzhmbqikcs56VN8vFe/awmg8m/UeBiajAVJyHwY+2NB9dMz1AiOtMZk0PhcOTMR3TXiAD6xSdGCXZq32eDjRMzYZbUAGlPHvrtgEa0kQkBAMaCDC1buo5T/zYOkJwbylrA+0A4BLddU9aabMoem1/J4eAvSzKiaiUrnnKtgDRk2CyaKg5I35FHFGq51ZtT1ZzKEmPXhRp4uULquYJtVz0+tdCJnSFgdf3PvKBC4l0HycVpvEMCQbBKsdmgB7bdwzG+51qoPC95p84YUkDgdhQw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021135927099003)(10067099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4VR4zDk6ZLIC/pwAJVsPYP79E6cPLkuqg99kAVUUrVVHArTyTC9EYyi5H2zoiX6W+huGOgySKYYzLKQzV5sxddieQQSIYIT2d+kU0R+MlWciluWLdfBVDce0aPL2jKTV0TZ8DYStzNRqH3i6C8e3FgJikMO76D5JVpFOZSxnT6WbH1DIVjY6EAdhDWHF4/ot45eMoWTcGRlFwcf4pkppVn/oJ+cNWbAkiJygh9qo9NR+f+UlldH4Vz0zodqTUbufoW/3eywYTpm4f0BIAA5AnHhdBdTRz07HgxQ6qJjZYI+2YXMAxlJojjfyHj3p/WtGOnGiR9Wf556MlQW7mh47dljaV9QxdXVXEV2HwbR1X16EVqBt5Sey5xxe/Uqc3sRtv4d0jwd3d/H5E/6kz9H5Ql8ncncrNM+osLHqjUypN96zO7iL2at4Uol49qdwPakB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:45:35.3602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09db317f-7eb3-4b71-b843-08df43f045ed
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5176
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/7/26 15:32, Dario Binacchi wrote:
> Add timing data for the Ampire AM-1280800W8TZQW-T00H 10.1" LVDS panel
> from Linux to the simple-panel driver.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/video/simple_panel.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
> index 1cf587f973be..e674419fd912 100644
> --- a/drivers/video/simple_panel.c
> +++ b/drivers/video/simple_panel.c
> @@ -208,6 +208,23 @@ static const struct panel_ops simple_panel_ops = {
>  	.get_modes		= simple_panel_get_modes,
>  };
>  
> +static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
> +	.clock = 72400,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 40,
> +	.hsync_end = 1280 + 40 + 80,
> +	.htotal = 1280 + 40 + 80 + 40,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 10,
> +	.vsync_end = 800 + 10 + 18,
> +	.vtotal = 800 + 10 + 18 + 10,
> +};
> +
> +static const struct simple_panel_drv_data ampire_am_1280800w8tzqw_t00h_data = {
> +	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
> +	.num_modes = 1,
> +};
> +
>  static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
>  	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>  		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
> @@ -240,6 +257,8 @@ static const struct simple_panel_drv_data tfc_s9700rtwv43tr_01b_data = {
>  static const struct udevice_id simple_panel_ids[] = {
>  	{ .compatible = "simple-panel" },
>  	{ .compatible = "panel-lvds" },
> +	{ .compatible = "ampire,am-1280800w8tzqw-t00h",
> +	  .data = (ulong)&ampire_am_1280800w8tzqw_t00h_data },
>  	{ .compatible = "auo,b133xtn01" },
>  	{ .compatible = "auo,b116xw03" },
>  	{ .compatible = "auo,b133htn01" },


Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
