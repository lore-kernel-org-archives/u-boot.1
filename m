Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37E606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YYP4qsRD;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=LuhvLoaG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46BE281116;
	Fri, 30 Oct 2026 09:47:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mOeHjhDnln34; Fri, 30 Oct 2026 09:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4F68F81112
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793353664;
	b=af0Y+7lTnojUEoXg0hVOq9pdBBwEJGbhKW+hn7FXKlaAi2oZL8TCWFKWxoimEMu4bg6W
	 tQmQTpCU7+pZDG0ucSILt+IstKO4Ncs76JIMfvbPpn3yZ8CbiPXvgOqKSLPGWIUWHy3UZ
	 1HpL7OS3xRZOsbbDOQRmjJ8+9SSqZTI8VTmX5jWcxtiyIITWLZk5B+PU5NsvCq93CDsah
	 AlDWYpUa1rwCs2M3XbQuMlbepMaGIRxz/hsGkxQ03XFVwPABVYHnfQRCxIzgqHae9Re/h
	 pqixQboK15a01cjXrIVtR/AbXqwGpLDH2etuKacyE3JpX/knQUsDMogGZALACZG5+oA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793353664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=RVQ7ohCRWXAUa3mAxqqqSb7Yn9DE9sybLrtYur6hPRg=;
	b=kHsCIc3pNmXGKnrBctvSAVdfaPj6yxNdaevbt0ckizyrVj/9RpBHmpis0lu8+oOnb6b7
	 uMH5mcmSDFx4XKkOCfYpK97ML8HTkl+bdf/t7G2CZYOJZqvmkRZ2LMI0yc+q95tbsC4t+
	 d9Yl7xjX1e86jYZvBX7Ck+XzizmPZFX3SU0HAeco8XEz1Yhj7inAXLNRb2E3qcT34gaMl
	 MX+VyJVQHLLacYEIbm1AMO+TiqjkvUlvccT6xUoL1f68Ml+RDKrAvR7iuuvh05hcv4CcL
	 3Vf2VYDivDjeFqov6L+dXbDgsgUHZyNEayfwyKUDIH3HoUGFAOZVvzYcC22VLCr8N2g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793353664;
	bh=RVQ7ohCRWXAUa3mAxqqqSb7Yn9DE9sybLrtYur6hPRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYP4qsRDFNnOCM7dYI0zAb7UyipcUpRjRaIQdbP+bVt7zn4yXeAPX2U4+aT6k41vN
	 Iuc2mmpodZ0t7xv/6TlzuFVx03sAWTIbtpWsium+yvQ/CHvTmKv/J9LcEKF/UY7PYi
	 V8wb7XpfogQS/931JOfTHvu5y4ZwlTbv5JqYtsBLHRurm8UiwzhrvohhLcANwjAgBY
	 eYrvsArM4SBB8buq7yaSMy+aDtvlz88V9QtKA9JJ7LpijEBMrSQMcyIlWvVFMcsszF
	 92XDBRppu3vb26YmBv35MOGxsfZaMMLbhLJdpWoQ99e5WlSWp3m+svC12pixqFo9I9
	 oohxmsT2LOxGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F68F81112;
	Fri, 30 Oct 2026 09:47:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C5129235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAD3B40AC7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UZdthXlreBkc for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5DCBD40AC8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793353661;
 b=czq8RcLWJBBO3nZOmd1rLQUw/VTOSfEezI2p0cSlibDu1BjFzWw9nsASDNlK2qVdhWxN
 e1+wo6YmGauzlxl5eGXmicf56pfhHbtMB+u82n7qEI7evYCcIm95fU5yM4RA6bN3WUHwy
 wbHyJ7insDT/GionRzeWfEDtg/vQE5xWJ97VRoz6vIdCAkYPZC4bdZoX3hY2Kr1Gt43yn
 FsfX8vk6CFiiFRIbkqFa9ZyiffriJXrQ8DG+/VWaw8U3A3k39LA+wHTI/NDQGZ8KzRk9Q
 TBuQYTMfoY4PDqiU/e1wXJaX4MdQXZAftXG1E5Mw/+5Kmx2tyXJFt9YNr2NDaRUOTMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793353661;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=RVQ7ohCRWXAUa3mAxqqqSb7Yn9DE9sybLrtYur6hPRg=;
 b=IUWdPfgFFl4Ql5e+lJxOYKyXsOEhlAHzJkTJk4+h93q1VMQcbih+fbjawmuTJwJzu8RO
 NC1PmIBcAxX+lnaWBI+eGh+riQ7rINv0kZQlEI/PvvzZFYyweceBYax5Y3eAbrv0P0RO4
 GdLk2gtXIzQ7ah0xJy/SJbidRUokksEn/LB62rwD8dDTfqFCZpmwdgXoEwlsR2b4/uiRx
 llJVccdUGu7PYO4fBUNXfK2ocPdjHngVlezpa6j3TBK6Z+qjEZhquwsqTd0OlD4jSmm7K
 nV30ZEIMk+sXzee54eooGNKXFRZWw86fjIYXaGE1/mhqx8nzpOtMsqNnhfJNSc/2Kqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=LuhvLoaG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=LuhvLoaG
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DCBD40AC8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C42HlsPfWjxlTIj1PQjhs9awrZ6IjwVYUzrTh8RnwPZ5eVTfaXp1D88G8fdIOGwCAGvI5MIPFvJVQIkIfiPXaneRaikZ8ygtEvwiPMEBa400se2rOQ4hILw/FwJ6YbB1+nIFh7M2uRjD1Se6d+xO6+lGga+DlDoG63WD+xMDIlUd8zaLWpFFbvc968R5v3HnaZQtl2a/VzgCEhfR4+AkNn25Mi8GJ20YbASPDiWFnASAaGvwG3QTw9b2QcSFtKqBjib6EpAXHTtNy9J6K3ShbX7lnkrApqCweKl9t9lIIPLb0KEQaW5mL3r784dx6IUaJIzd6FHBFxUn4hAyieEa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVQ7ohCRWXAUa3mAxqqqSb7Yn9DE9sybLrtYur6hPRg=;
 b=drsxIpGI3MaXsq+4Lk5U1eEXCNoEKdaGs4+VrlSjyo0tSYU6NwdLfKrlNsWvurf5vdcK3Umy5D+TNsL9q//Jrw+0M6MMVBjd0F/F8DrqKIn1jdcAcCSZV30qZd/XDaue3raPtXrwvjWFesmG1MdJPSrR/jLUBX2c2aMFtQQqvDGHvTiq5XTThJrWmNOXlIggy3/1/BuU0w5MAJ4R94mjuK5nJtDnf4UVkwm2UovTPd2kp0lE+WvlOI9d20zw94wv9d1Bmz1QTOv+RcEKBExq1O0FOPhPSNsqIwDKx5rPkLlNbhya6sJJrcSvlEBce1VCZV2/BPQjDLfJ5BDg+Xp8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVQ7ohCRWXAUa3mAxqqqSb7Yn9DE9sybLrtYur6hPRg=;
 b=LuhvLoaGHDoCg5vAynFMndCDvLcX3T7Se8zYdTaQhaJVYjISc7BL77fpb6pZHFZYtV7KwMD3Og5jHn7rLEVBs6bod6+bqBFrvtxkRt/O9f+69X7AQTbNGKwwZv31ckIBTi/fYdw3nHx+0233orIBlIGC9M9CfEI/u333gpGs0jMRy04t5V9zB41QN3yx554XdxMbDYRMBRlBz5dO/MXEROlQR43jNqQCvkEV4efwqxzMtYAew6fsIrafebA0vL8Ez2PNuvx1IBke+CIGjuRao4zj0V5xdIkao7gSVeC0lhbDRV1cTkixnZmiLqj6SZtcMRs8P4wBtnBi6kveeO2S9Q==
Received: from PAZP264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::20)
 by PA0P264MB7510.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:57f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 09:47:34 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9:cafe::40) by PAZP264CA0161.outlook.office365.com
 (2603:10a6:102:1f9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Fri, 30
 Oct 2026 09:47:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 09:47:34 +0000
Received: from localhost.localdomain (unknown [192.168.72.182])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1C15B1FD7E;
 Fri, 30 Oct 2026 10:47:34 +0100 (CET)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 0/4] binman: Add HSM signing support to pre-load entry type
Date: Fri, 30 Oct 2026 10:47:26 +0100
Message-ID: <20261030094726.82062-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023090611.778581-1-yan.wang@softathome.com>
References: <20261023090611.778581-1-yan.wang@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PA0P264MB7510:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d51c646-daad-427b-c84d-08df366ad2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261022113327099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: lmQVS7iYk6pIMpmv5z8tWDM0SuWjIx+dOLwfwLIfdhs4H5UrhmS6x2iZolnvk/df0MXAxOlG7UYm7wC/c8cYa4jzttfzPHLasHdE2q6WopQUUsWIxPLzW7azXntifW023vGpdtP7DB3//cFFdCWwU7/5pTslB3N5MVbs3ukL60Jo2OLMv4gWf2faMOLNXvedvaz4yJERjlxv0P41YApn1Vtb8DtK67Q97M6xJb1VY4NM3c1y7maCJRxxotM7C47nlV2GbQwe7JYI8O3yJg6czmyVP/Z3fbtoVFI/46rxKDJJIb+m6w5k1bZyAPP3CMzaV9r021112Ol+gfHjzR2emEwlsHzxG9udEsqh0+VSp8HJ3Lsgo5mptMpfgiXOn/fvpbUUxxdvHSgklFBUb+6ijqEl0UJjn7mEnCrCxcyenLS0G/hTm8sNnTDEMFfKUmkK+5u84biWsDv2Uc5e9CbpmzJotVI93qApHu7O4LQMPSMruljj+AOnJuqb0Tp0K0uA64c0aE7EakBrGx/9uJI/yuNYuwJdIKAa2YO1UXPYSo3BT/L/g+s5ZE2Gl9VuHkiMECMVLur9aa1pNIF/s1eaVTbI8qXi5hH6JlcKA+lWl+SVdtU4g9KZ0oddJMcd5TmjMonSjSyS+KzQPmsHOoiHWml6/gEAjtA822GLeFtFTvHvlp5QoC2Mqw/AxVQyg/WT5RelZcdW10KJD0SWQ+fGKQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261022113327099003)(261021121427099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: syLXYqoXhF7I3d3J/v7RPyCqUSogHge84utypP2Z9Hq8nNfTLcSqxe5c36Wf+2VAZmB+BnUq1BOZeD8mJCIHU9leWgo8LgWL/D1+YoNPh4uEY+mlmODeCWWoXm5SKyTf/8hG+/GpiNWRHV9LEOYhNXrdCbFh6Vq4OHd5SB9ctUHnEyT3MitHY8QD+a13kToD+lTlMEZgFc+8hT4xAgctBo9vJ+BW+nvaqJsPBCPW0wmv5fyQufJWt/ICb4K83QcN19QRm8S2SGoq03+cnDSG9+lWu7SPUlAzL1FiP9bORKwhTqa2okiBqvFM7gXmeCp1WO3GbxDCgug8UlEB3IX5LRPaClf2uAkY7asbC9FId3fYQ0RTHl1X1keHudtyFHX7IiVM+Y6b2vvm3Dz8GaSBwSeO6ZlJuaA4wv3ptUWAW+qrSK6zjREyl/fxx9+HAOQn
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:47:34.3670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d51c646-daad-427b-c84d-08df366ad2fd
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7510
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pre-load entry type currently only supports signing with a key
file on disk. This series lets it sign through a Hardware Security
Module (HSM) using PKCS#11, so that the private key never has to
leave the token.

The pkcs11_tool bintool gains a sign() method which drives pkcs11-tool
(RSA with PKCS#1 v1.5 or PSS, and ECDSA). The pre-load entry selects
the HSM with a single hsm-key property holding a PKCS#11 URI (RFC 7512),
as is done for FIT signing, e.g.:

   hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";

The PKCS#11 library and the PIN are not stored in the devicetree. They
are passed with -a pre-load-hsm-library and -a pre-load-hsm-pin (the PIN
may also come from PKCS11_SIGN_PIN). The library can also be given by
the module-path attribute of the URI.

The PIN is forwarded to pkcs11-tool with '--pin env:BINMAN_PKCS11_PIN',
which requires OpenSC 0.15.0 or later. A version check is added to the
bintool and an informative error is raised if an older release is found.

The functional tests use SoftHSM.

Changes in v3:
- Swap the order of patches 2 and 3: HSM signing support (pre_load) now
  comes before the key-name/integer-size fix patch. The HSM patch already
  needs to touch ReadNode() for URI parsing, so grouping the key-name
  check there with the HSM validation (in the following patch) is cleaner
- Add opensc_version() and _check_opensc_version() to pkcs11_tool; refuse
  to sign with OpenSC older than 0.15.0 (the first release that accepts
  'env:' for --pin); older versions would take 'env:BINMAN_PKCS11_PIN'
  literally as the PIN and silently fail or lock the token
- Make output_file a required argument of sign() so the caller controls the
  path; removes the temp-file management from inside the bintool
- When tools.get_env_with_path() returns None, fall back to os.environ so
  PATH is always inherited by the tool subprocess
- Add _BuildHeader(sign) to pre_load.py, a shared helper that takes a sign()
  closure; refactor _CreateHeaderRsa() and _CreateHeaderEcdsa() to use it,
  removing the duplicated struct.pack() and padding logic
- Pre-compute hsm_hash_name, hsm_sign_name, hsm_padding and hsm_sig_size
  in ReadNode() so _SignHsmData() does not re-parse algo_name on every call
- Use state.GetEntryArg() directly for pre-load-hsm-pin to prevent the PIN
  from being silently read from a DT property
- Remove the hsm-library DT property from __init__(); the library path is
  only set by the entry arg or the URI module-path= attribute
- Move the key-name check into the else branch of 'if self.hsm_key_uri:'
  in ReadNode() so it is validated early, consistently with HSM validation
- Extend the bintool unit tests: OpenSC version parsing and refusal, env
  handling in run_cmd_result(), PIN passed only through the environment,
  token serial lookup and resolution

yan wang (4):
  binman: bintool: Add PKCS#11 HSM signing support
  binman: pre_load: Add HSM signing support
  binman: pre_load: Require key-name for file-based signing and fix integer division
  binman: Add functional test for pre-load HSM signing

 tools/binman/bintool.py                       |  10 +-
 tools/binman/bintool_test.py                  | 650 ++++++++++++++++++
 tools/binman/btool/pkcs11_tool.py             | 379 +++++++++-
 tools/binman/etype/pre_load.py                | 323 +++++++--
 tools/binman/ftest.py                         | 268 ++++++++
 tools/binman/test/security/pre_load_hsm.dts   |  21 +
 .../test/security/pre_load_hsm_dt_pin.dts     |  22 +
 .../test/security/pre_load_hsm_ecdsa.dts      |  21 +
 .../security/pre_load_hsm_invalid_algo.dts    |  21 +
 .../security/pre_load_hsm_invalid_padding.dts |  22 +
 .../security/pre_load_hsm_invalid_sha.dts     |  21 +
 .../security/pre_load_hsm_invalid_uri.dts     |  21 +
 .../security/pre_load_hsm_module_path.dts     |  21 +
 .../test/security/pre_load_hsm_sign_pss.dts   |  22 +
 .../security/pre_load_missing_key_name.dts    |  20 +
 15 files changed, 1761 insertions(+), 81 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_hsm.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_dt_pin.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_sha.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_uri.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_module_path.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign_pss.dts
 create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts

-- 
2.43.0

