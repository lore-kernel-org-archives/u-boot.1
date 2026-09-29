Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDE9CA5FB1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 13:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 926AD80EE2;
	Tue, 29 Sep 2026 13:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApRx1pZUExPg; Tue, 29 Sep 2026 13:06:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B6C3B80EDE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790687206;
	b=mAEy/kEUh3fxq87zof/N6hbmRaYsNW/MVFk01nhepCwupkWOFwLFkhBsEEZCQmaeybHY
	 YIPrTn8JWFXhHOJMV/6ttlV60JxKeUA1/5XadmpleUF+HQZwhHQFtdYdEtXlniF4nKox+
	 itLCT8axraTa+RWj/VzJ144C1h6icbtIOwW++Vhro1Lb17Gb1v8Wd5z6WKbGuB8w0Obx3
	 BvuDtC7C6gROPqk1uwFt2ZFDItoKrjXGI6i82sx/3kGu114ooLoNHlIS98nwoTBtMa6IR
	 e/yQdO5cm1gze4j1t4//6uHkznu7iaaBZRE81zzdQWtXjGR7b7ra3/ILByWSyoyMPlw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790687206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:CC:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2qSYsnp+94JydtDitAV9crTHFDP7PVH2VX2yQJGPj1Q=;
	b=ETulieK70TQQRsEZiGzqRK3he6btDD+Wd/DeVU+NHGekJbdZrS6xu9ckldxvBUps+l9t
	 yzNfxSH4/dfKSUJw0gsQyop6CHDBEWC5e0YaDJydwKamRpDCs4DE+LH58ScRN7hMs7nnw
	 YbqHQ+CTwG89mggtxZ+Ok2Oe5aJ4Sisil8N5dp638gOXWqSPkOG5/8nWg94Ni5vQEJzaz
	 kQ/7r1aGrPKWt26AJH4HReCGo6B8k7mBhMVECKdePs9H01Q6+4WFFXDwEz6q5idbY6oJM
	 vD4/oQEL4Q648GmtBadVawSrwFTCRSE1BZJ0DMMbCwPqK7w3j72t1oX5rMWHohvTnoQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790687206;
	bh=2qSYsnp+94JydtDitAV9crTHFDP7PVH2VX2yQJGPj1Q=;
	h=Date:CC:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+qfer4xpRXUQjnFd20cKphRTfctYf4X5AY6FkHh75RA0AD4odqOB61GFLAVR+bOY
	 2d/7O6AGfpK6V8dx4ROeLxZHaxRopJY89xveBmoaVqtPO/ge1olUSz6pUhNPqI4k0Z
	 iRzWUBJCh2eGP9HvWFW4bP5vqBbvvVgF8SXOzh7zOc62umzfH8AgGCHsuddo4WxquX
	 6ZOXSdQ+A9L6qPUX3DpY9Kv+cnMBfWvGmABvpJPKh2gmOMUGU7k7sZRfEdpkSJPH3b
	 OnPp5loj4iHeTF9eL9lZum2k1Kzm72ahQ7hn9uRH9iRgn2GPpzOB1l4tY0TfPdGtyg
	 5GJIbXTrO+CfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6C3B80EDE;
	Tue, 29 Sep 2026 13:06:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 62D58335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54256607B5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YdhQZiHMwSN3 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 13:06:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C9F54607B4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790687204;
 b=hkq+CaGoGEhgfNopGBf6O6TFLydWllGFaW34kCYp5UtXksdWQJVmT3o2k6d87Ymr2dNf
 WClFLkBEmAYnNkm68d3BQw+hGWkhvfoZ1r/44ys2QSM5HvuBTAAMngTsGWhAF+4PGXhIn
 IIn60o7fJl5tOflS2apRvmJXi0kyRhAW1kVDDIz7jNkwd8GB2wUi0bPLsMwtExmjvI3Gj
 nHl4xQDP5EUDeBiCdf4lGi9orQ+Vd3xUzJFjn5pUFWy7yVdnTNvIdkdSGAosXl55HZlrc
 uDqtzygIjeMv2850mCRylcZMy9nHF2aC+Lu/3ZtuZ6TIoTHFvhVd9tMbLC/W4KRGA1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790687204;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:CC:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=2qSYsnp+94JydtDitAV9crTHFDP7PVH2VX2yQJGPj1Q=;
 b=bm6/JW+aq3tV2CV4khF5/uQKo7w2Z63B6l1s11qwnEWYGrQ5DIszDOgoQr4PjoeFKj34
 2ncOi3IOr+WUZu3sCEm4bInwv7u0OG5SqQr2qjanVwcjxEhaKmSecpa4jug2gofg0iS8G
 4U6GHT7uK3RJFnwrMv47si0YY8X4/jM3Usz4lBjfQ5mDnw2Fq3OSb4BNz6RzozW2dkv+Y
 WqCQSGDsJR31s5b1igrGLLhdIAQssyjjz75+l3haOALvkDzIXesAg7xHaYhqkMm03dTM3
 3o+p4ejz1QNEitukGrwD1w86LO0Z3II069rrt8N2xMiO83qcpMR2Qw44CX0F2M88n2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=RPfffIWS; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=Ogo4b+0o; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RPfffIWS; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=Ogo4b+0o
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9F54607B4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:06:42 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68TAjdAq807512;
 Tue, 29 Sep 2026 08:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=2qSYsnp+94JydtDitAV9crTHFDP7PVH2VX2yQJGPj
 1Q=; b=RPfffIWSAW3fyOPKWS58J8IoUzjhHO6iNq78AMSw6uxT5MVvq9jmrWuld
 jzIJPNRYr4frca1QRmZ8i3Uj6bm2SPhmrVZpw8fzgjGFF4hVgc3ZaFdt4XRYD/dD
 KdqIUldoZb1ii+E260wCML6JvjYweiSeyfeDlm30zIMfksU1TZYs7AEjfwrxaiwE
 BSscoBKIOA4AyQ+QZTxtpStWLxWoSb9VCsw9IVWG9UvdXgVkDPfB3yXURwJWJByH
 gWPgNlTVIP2qDDauvGfk49UxK8f8b3wlG0G8Lm/0y/wHTCf4TlTNqSK/Xnxvip9P
 K1H9tX9XsvrZhWHFT1+TZcY8VN6uQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by m0384305.ppops.net (PPS) with ESMTPS id 4h02j6bwnv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 08:06:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5GWJk7g0orVSawXRvZlTvD6iNXD4UVobHBlK5RBlVQckJ/2RC4vS/sZ2ZZrU9yoyjbTaFUf+W4oea7i4iLGJZxoI8V8e+9bWPQghz0xF7Tc2IJqCFMX5xGYTpbLobWu7to1B0vl39CJcq4591fw0OofG1jEicFM05HtOTJtc03kD3r88r/BH3zwZuMlf6wyXFDzMcjC3lvUYxQukVznzjlQAA8AHuy4xlr09neq1fnaLGTzCEvk1c35XFLPZHA6gh5PFMu+meG0M3bbmJ8LY9YtPfs+ADKG/Q/1rbaQPqwAqgyh1GaHRVYYgRdd6QejDGuptG+e7v7i8OR/n5InqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qSYsnp+94JydtDitAV9crTHFDP7PVH2VX2yQJGPj1Q=;
 b=duHY5T0nllXiw0munmgA29Ta2/vs9ODlRXXXqhbDbmuLJRcnlc/7JMzz3x2S/Njw4gxQZl88B0RPpoK6sgcai/S6ZnS8V9rRxYp2F0BJxt4fHIQKhwo1AM24UVRqmp52HhO+rjSKdpH4Om+AIOJv8Mo4F+k0daee7OyykqjMXsCT0PPEfw7FpAtVaRE/noPgf2R9Wui54jF+b1s1MxvMfVj0wa6XOSxcXuwoQtoQCM/hF9li2efR65gcuvIFTa4x51HYFnP86S2XP1cVzoLpOCFL5yLmrDa8ZR+N2I3ly2TJV7Ua8Qhp+aMX9RC16UblgaUBzgDw2DmvK0uQg16v/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qSYsnp+94JydtDitAV9crTHFDP7PVH2VX2yQJGPj1Q=;
 b=Ogo4b+0ol4c1WaBIwtIPIfoNv1v+q2UmO0uI1s4SywKL3XdMRXOf3KrCB9+eB32FLXc8GDE6dNMYHvl8x/EkY9FoaOT/s8c6t5gA4PaisKXnNpHsqG0BBo2KQWw+0tLrEqbiFan7MVgyP6AUcJsgdpoav1t3K/Bgrnsa8Cbh5WE=
Received: from CH2PR08CA0014.namprd08.prod.outlook.com (2603:10b6:610:5a::24)
 by PH7PR10MB7718.namprd10.prod.outlook.com (2603:10b6:510:30d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 13:05:37 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::7f) by CH2PR08CA0014.outlook.office365.com
 (2603:10b6:610:5a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 13:05:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 13:05:36 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 08:05:12 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 08:05:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 08:05:11 -0500
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68TD565Q1035781;
 Tue, 29 Sep 2026 08:05:07 -0500
Message-ID: <184e99fc-4c03-49e9-a1b7-7d701dc99142@ti.com>
Date: Tue, 29 Sep 2026 18:35:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.u-boot-project.org>,
 <marek.vasut@mailbox.org>, <trini@konsulko.com>,
 <ilias.apalodimas@linaro.org>, <michal.simek@amd.com>, <lukma@denx.de>,
 <alchark@flipper.net>, <jerome.forissier@arm.com>,
 <dlechner@baylibre.com>, <sjg@chromium.org>,
 <Thinh.Nguyen@synopsys.com>, <mkorpershoek@kernel.org>,
 <love.kumar@amd.com>, <c-vankar@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <178964898806.1279633.17593305863869822172.b4-review@b4>
 <arZF61eAp54rQyrT@monster> <4ca2f00c-9083-4d0e-be76-1465042849ae@ti.com>
 <aruN2OLSSnntkyrn@monster>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <aruN2OLSSnntkyrn@monster>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH7PR10MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ae110a-4675-476a-03cc-08df1e2a5a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|56012099006|10067099003|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SpxNTUu81fjCp7pqWPp7YC8cx3vLsJVXnp6eMeqqQlymnORKcNVB6kiDQU5Zql4qlw8qprOsaEJfQbtdtsBsRozMAWwdyMMJdT98hfv3/9AQwmOsjpBTLDz/nEhE1bz2YOWOieglEnKrexnBgvWfHkEGQbD8FwN1G09U9kO8i6PPj5TgEtSOJB9mNYVXCD2elWx71ezG12G24s5mUa6ZKLDryR+R/mTpJug7ZHSbzWGrbyomSf8GsuBsG2L99qnahhOi2G36ulouqkbxHtK4l1eVwN9S0nF8aXNkJXQpJ59coUmApiJoXkCSiHFAs4Dqzdo6AWGZ5V2Bcw4STOSWBg52dNphgNMJPQKroyH+17IEv1RDuIekBoXmE8+Gh29Ei1JgMmsN+gOm/x7znw/7/FDk7Z5HLV8iMtFaFVZUZvhEhXNNn+LyNw/5LblVXhAsvrCzncdZKueUQksN9hsWiOEimJ9xY788t44DNbmXs0Szx8YZLqcx5sgizL2HxYkAMJ9IlAJ7jd+poaWI/nAmkTMQ0eONE8+eugcjq2qGdXZ7hzQVaAt2zZcKs9QaVm1FUiRD3Ak6Yo57ROeAMxUtcxptSgllmIkhZNpoG6LRbSlMMHMZMIrvL8TT58/aqGjbeg6eypbLWigHWl+5T/7MdTw447y5xwVZit07HPXW1/au51HqUc01RdpI9ahEgUVrK5ahryCoOlpitLmvAnMWpQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(10067099003)(4143699003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: npgxrtH1drqp1Z4+wJRqd8y/mcNgvcptL0GQUc5SLBylh4LuFbeqbhVB2D2fzDpmReOF5BBj14vYwKjZcSpIpwf80MjeoGNshT77dLgLj92xIAQTmv8AEIbrMznP5praBJrF7wWmupU/zge3PVUGxPYuzRfCjF2eSEwUxdlnPG3OHcsgqQICTWuaMvkVGC6FfX+GO9iXyAAYieEF7C1lSlEULDr5pDRRF7kCaginGNHwkfuziY+3nMW+LyJfa8IL+RN8cIIZV0TXGxnlxxTobjFX5HvNyDjxgXMWF8qdcctpEYBHTnnsDchaNFi7X9HeJkmiaaMe+h3zO4nDAXepLCyBIhdinmpDStBHjd8CxEdKLyv3mwPtbc56M6sYqPGTQ60iVo2FrJqszY2pHQGtl1OgbwrGD2rfHoLUQPBds/QwXgRo/ZM+cDHwO+iC+PCq
X-Exchange-RoutingPolicyChecked: TGj51Q0S1fQep7w7gkEJ5BkX0nOghsuLt4dLPSky2qMXItQ/OB759BqsEqv2D+ES9tQMbAZY7ugdz+tm8kJGv2wFhy5nrPgfly5u+Lsx3Ng80wGV/ghBZNtzY8uDO5oFh+gG0h8ctPYsR3FgWDgXc//Nsbxue6qRY2UPiCeUPJ65i+2WUA7Z48aU+c5MBXl/hkM76DI0JPRV4JM+Q7C1bWJe7J7NLRSdPP1C+NwAlyQxxSAx9wVwuCQOMkxzwbViTf0Btl6Mfvm2EjIsMa88d5tUG8ye36QmB8yi7koOCCXjU0RjhSmkkNaeVSr+pWSzrJf0Oe5cUHQhsUI+m8qo2Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:05:36.3757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ae110a-4675-476a-03cc-08df1e2a5a74
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7718
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfX9GLCXywzvN4E
 NSfrJg5NicMuLI7JMgs4TgTPHpCdYoZTxx3BvX9I63mg8/ipOzNXN7+Xu+UCNJA1+Hc7aGIckfV
 OjOJTUZW9b9Dh0QhZQuD9UuEmwgBye0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfXzAIEt7FLEG4P
 HemrT2jDtMg8X/M/C3BA3397YdgfNoIHK2luFtsEH4upcY0I3pBXY0xToS9g+20Q8E4HIGhAMxV
 /LmX/WRrMAtF/gtAmZtAzI90Tw97Z0xUGPMx8dXev0Vw5TvmK5RNHyW6QZ2vjc08ut/s3nDM88r
 UT/U6owvzUI1cc9u46BWziF83SesLxzKiVfoEe5F5tUHcIYeLqx85AM/17Tl7ikvQswf2upZkGN
 Vqc3H75TLZKLIyFA9nG/EwpEh96dKNdqBIfxFx15GrYW2BJRm+JlyM09SzbiITf2Jik7nnnGl0v
 pvnmPs0lVDg0FK7bQswQz5ZIAFRoAJRqo7Jx2CNwbyr0PHYF2FBfERazNPe0vEZ7YcfpOsFTZjD
 ytWaEdI01xr4q+o1tszaXORGlgtGQjR6xIGni7pSV75a4S8iW67Z3l/KfLpWINT/6C6rEYOf8Gf
 +UVcLIUsCr90zmzvFMQ==
X-Authority-Analysis: v=2.4 cv=Z4p5j3RA c=1 sm=1 tr=0 ts=6abbb7c6 cx=c_pps
 a=jRvQvoFr2LhS1HEjeZSEyQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=mBlWcExsa15PIYP-mzsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FGwSq-vkVbyBdAfxC4bM0gwUtjFsSWoM
X-Proofpoint-ORIG-GUID: FGwSq-vkVbyBdAfxC4bM0gwUtjFsSWoM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290052
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/29/26 3:37 PM, Anders Roxell wrote:
> On 2026-09-25 16:09, Siddharth Vadapalli wrote:
> 
> [...]
> 
>> I didn't see "unknown endpoint event 0" at that point, so this series seems
>> to introduce a regression.
> 
> Hi Siddharth,
> 
> Thanks for looking. But that line can not show up on mainline.
> dwc3_ep0_interrupt() has no default case there, so an event 0 on ep0
> is dropped and nothing is printed. The dev_err() came with the resync
> from Linux. So your logs do not tell us if the event is new.
> 
> To know if it is a regression we need the same print on both. Can you
> run ums on AM62p twice, once on plain master and once with my series,
> and send me what it prints?
> 
> On plain master:
> 
>    --- a/drivers/usb/dwc3/ep0.c
>    +++ b/drivers/usb/dwc3/ep0.c
>    @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
>     	case DWC3_DEPEVT_EPCMDCMPLT:
>     		break;
>    +	default:
>    +		printf("unknown ep0 event %d raw %08x\n",
>    +		       event->endpoint_event, *(const u32 *)event);
>    +		break;
>     	}
>     }

Based on commit
369d71b895b usb: dwc3-generic: Fix ref clock enable error check
of the main branch and with the above diff applied, I see the following on 
AM62P:
=> ums 0 mmc 1
UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1dacc00
CTRL+C - Operation aborted
=>

So the 'unknown ep0 event' print doesn't appear on mainline.

> 
> With my series:
> 
>    --- a/drivers/usb/dwc3/ep0.c
>    +++ b/drivers/usb/dwc3/ep0.c
>    @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
>     	default:
>     		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
>    +		printf("unknown ep0 event %d raw %08x\n",
>    +		       event->endpoint_event, *(const u32 *)event);
>     		break;
>     	}

I couldn't apply the part1 / part2 series cleanly, so I wasn't able to test 
this on AM62P.

Regards,
Siddharth.
