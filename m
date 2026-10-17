Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33E0CCA490
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 02:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DD518165D;
	Sat, 17 Oct 2026 02:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nS9WNrAxRQ3h; Sat, 17 Oct 2026 02:45:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA9BB81666
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792205108;
	b=j8AeWJAbdM32qEr8x9P3qbwjoNXNbDU2jeE3tc2JrSXNZgBd6kAQmfsHx20NYNg3iWu6
	 2MUlt/2bIPzsxANqfezreypRdB7AuNdCoMHQ9XRCpQlE4s/SZtERV9zJ89uFnZe45NFss
	 aK2sT7Qz8cKMn0yy4Js3G0NSY4SziRAit4cSE3wsxyvBpii/hPLmvI79vFlj7eHVWWRe8
	 bHDin9S1Qts8yQ9Tm3fdRsSO6/BwhqD6bjj+5aGljLqc5zrCCUEXxEn9dGX5YXk4PipQL
	 LZuxjN4LAA/xeve1MqfZNCz3xO/asJnVKFG0W2OlPy3sFCdJTzAASOsDC2WaEJZ9t/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792205108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vaS303WyE5vNvYmJcrVUWUe3GQ1r8QIFT9KTLrf2ws0=;
	b=EFrby/fTTB+VxLNwquJJGPaDHkgnqYNgXt6QlRfUInJfRbySfA42wiHfKAtZtGOcvHfZ
	 bYOPfqt3I4i4cgAKFSDII/gIqXjfZvBLRocLhUg7/EX9hvP/QYC6rPYkBRFPTZQo7W6c+
	 47+SsFkp89dKq1UZ6KXzoXbFLOiW5fIutaDmGLZN2GO7w5HUrgb5Ipn4XUH2Xk5bgpde3
	 WKW9BJUJrKh4mU7XmSd9YoBobMkMXMx+0aVLKtWntdlXQda5bLO2AMbw0R0z5/xLHH4wD
	 7c9mPept1F6m1o9GySxjewtFPzKj2PcXEJrw0sZkk2Tx3xelyPFkx6iq3Kgfkzk3qkg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792205108;
	bh=vaS303WyE5vNvYmJcrVUWUe3GQ1r8QIFT9KTLrf2ws0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PUxOuqGNxPCW4O16eetdc4bbmR0rqoDKkzQ0eexvXQYHofPxzFN9ahP0DqxgrFWln
	 qbPiKJBaI4jb0wuI2/r3+83NDy1J+2DtcTd55v5OGT0qEYtb0QhuNlSqPvA5wo5hj7
	 Udymi2PauUEjd/6fn5aBHxDXWEUhBG177r3XeeB4CPGCwS5nhIsznZVJaXo5bqc6Za
	 5kP1TFUJ2zVUKTDgY4ww8Dsj7OP5A0I2Y9tGQvyH3B3srOmupjxqTmx90j/LbdIlqa
	 1okpZ8Pz4xWTUBflJfDlzlfs+Oq6rVHopqyxwLeswTIUs8Q60WBwjq0DeoNyYQ4aA+
	 iX5OXfZ91DYPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA9BB81666;
	Sat, 17 Oct 2026 02:45:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CCCD7AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F136140100
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InLXjnlA343x for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 02:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C240E40061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792205106;
 b=pAq63MjfLXcil7DAP7xBbcOAkC8jDbF67jGhIjph5djVdTKW5kzCsMK+0tY5HFdELBoJ
 lqyGp5hD0oZCqgzcxx5xHAKqeWCdw5kHMcyzvVMowuHk//YEDFsEhuAvTfbgm0/pdihZW
 /gOzs2XprcL4jfmLid8hMxnJRafPsQGlL3NtfxPiOaAq12lElnI58zectzOifJCcwjLA+
 u59Of6Dz2+DgWpTg8fUuss9T3TyAximV7lA8K4ECE1IdwMAX9j1Qu4AtXhFCmaEIqNDKl
 vp8g9x/eNP1IAFhcJACe9kN9mwMOQM0p0otmkWOrj5fnl++sC+Z3kqbiAZK3J6Pq5xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792205106;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
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
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=vaS303WyE5vNvYmJcrVUWUe3GQ1r8QIFT9KTLrf2ws0=;
 b=PawSAw/lPhqkGtXTjjJ/iHcYjKg4fPT16Ny0PHJQXkfhZ2gOaEvGmGwR2lNX8s+kHxJS
 oFmyWqnOc4wr18KmfcTZORfOYeyfT1TcRYANd8MgzoyUyCYDnlrq3UEGEIaOWtDphWEKA
 ku4mPAlK7RJOu9zXX/T/Dckd05oeZQSzkiINpSexUnwzwYiDHnJWQmWLduAusySMAvgl2
 nFF1udC/sjfTwuOOfDk08ED9BTTXT7HRbzKWOAgd6paC/jeFpDokJXIAeRpeWJjXvXbVG
 ulTHKvwDBtIv8qAqUpuTPUcDvncuCsMjALmMnjWgQvu+B2xL9dLWfmFvxyEc+UVgGIA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=AnFOJHAA; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=C03sHStk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AnFOJHAA; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=C03sHStk
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C240E40061
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:45:05 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69GNErBW933978;
 Fri, 16 Oct 2026 21:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=vaS303WyE5vNvYmJcrVUWUe3GQ1r8QIFT9KTLrf2w
 s0=; b=AnFOJHAAyaYD5kq+o82Tn/dFHfAmFgM1kyqOV5h5XE2P8RPUKyQx9EUU6
 tF4CHWFxLUa9AZ06MCvtEIfkFXTLWM9k5x5p/oyYdnZasiFXy+I3Zya+Oq8plLTh
 3H+yJ7AV95gU8gXX816QO5k7HbXEcijjneMHgFr7aqyzV9xB5ERDBkQrJ/3cY9Ao
 HmEhL3+6Em9Qeu07Vn3ufK3orwDS/dBNPiIIQXKA7RlY4eBGlda/o5vIAOf89hmi
 ra467eCz4eV+73/orR6oweSNc28YNAUZZPp7y6LiPOcHCpPOvDIpKu3z8VQVYcLH
 hw5IjA32vqRpA/AzRa8Pm5gU0XEWw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hbn5037er-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 21:44:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0GP/eM3jOAKx4jPi6blU4mkjV+gGDJOJqKtYrC6PClwGdKs9vDzGtQK8A+/kJKXR0/RwdJXOXm4mZ2VRFV8xY824aSFNsKXVoxKx3ry7/ckW0eWjAADHKTpboXUqwacvHSzLG65Bpwf5iG0tjSoTFpHu4RHDqDUbIXA8skgbfuotVgnTYtvETN8y8ArZ/0PIJ7d4323RI+3Kp3H/0XE8MfeTAB4aVd2Y6qa/VsX/9bQvC9UU4I8ao4cV5R6e5z1gKhmz1dLpoCf7gwcjOEMyYRM/PsGRDUrrXD5Hw8M2X6nnEQSa6Kc7oYGbV3WloYLjK4EHyTVRlFs+p4BZuCE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaS303WyE5vNvYmJcrVUWUe3GQ1r8QIFT9KTLrf2ws0=;
 b=hTwaVVpso8k6OPx5Vr0BEcCZVhUDTT47ZuKRNu946rn/lj5RWyCdE4+SqeysjfoM8dVtLLy3yb1xVQ6QvIv2Viu1bHr72g6kxU3WDvN3qlKoVTZhxTqMnh3gbu/zGfeiiWZxnzbIq8I4cxkBqg3re79RF1JerRk3A8ZSB/E+1oHHRDDyKWjEpMkiZMTK4EwRhYEidqoYpK2Up9s6iRKx8ZfK73a0zpxf6Pa9c190E9FCKTHGv+LuzBaHxitlLlVAEDHqxxj8Q13ss8fWhdy4WNvd8EbNZQDDBzooSEB8hf0q/XVYL4Let6A+HOlMf3qcvVjWG9BKDQRUxuZXxSYljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=canonical.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaS303WyE5vNvYmJcrVUWUe3GQ1r8QIFT9KTLrf2ws0=;
 b=C03sHStkmoDAU8OHnY6T6RpcWKZIgC5Qs4LmH5yvZaqKALvhh8NiTX/80lM5fHB/7yyGcTbf8p7gSy+aYZK5wQycwiTnGvrEIItgx5JNxue0iXAzKo6IblHSUjxKYwkR/9sfZrzdEzpJWe7N1nk4aUbmfPuzfcu/q5bug/SS97A=
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by SN7PR10MB6956.namprd10.prod.outlook.com (2603:10b6:806:34a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Sat, 17 Oct
 2026 02:44:49 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::22) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Sat,
 17 Oct 2026 02:44:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 17 Oct 2026 02:44:48 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 21:44:22 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 21:44:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 16 Oct 2026 21:44:22 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69H2iIxD2694474;
 Fri, 16 Oct 2026 21:44:19 -0500
Message-ID: <e5a7f1fc-8ae0-40e8-980e-87d23863d192@ti.com>
Date: Sat, 17 Oct 2026 08:14:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arm: mach-k3: common: add helper to wait for TIFS
 initialization
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Daniel Schultz <d.schultz@phytec.de>,
 "Richard Genoud" <richard.genoud@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, "Aristo
 Chen" <aristo.chen@canonical.com>, <u-kumar1@ti.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
 <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-1-c7ab53f79b34@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-1-c7ab53f79b34@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|SN7PR10MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 558ae780-694d-41d0-c74c-08df2bf89c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: xQoweZFw4bwTGCRN68ZgtcUiqRgT1IyBiXjvVZ+SKHumb7OkHz+TqRaSWr485x7RdcrGx+bqdLSebS9XeQAIy/JNNOGNxvKj2m+tZjKj0SLQ7W4Bsh085kC0KOYzS1yEmBoQdD/1B2i+Iz1RjCw/tV71EYMFJ5xLaiihL578pymxeI8ThtwBeD6Zk8wqgqPX16J/BuA6I1DD1XHQo2VUq0oTLsC0cDmhSAJWLpVFBlS05ANoIRdYV29M/l09lGdgG9x5CGb137mriJug6SDWrEmYrghF9NNy7Uwv493Dt2Z9SH1Rf2awxmS0Jv0Laog3E6Nuwai/bCzHulpjWxNld6tUa6zky1rac55F+i+W/r2aFj0qJYqldvu4llhRxSX00g3bBgV9xnRpcCVy8e3GZ3+shMxWjoZKsLNlRFxH2KarkSQJdwd8mS3z6FgAYr6Sl5hr1fmO/Ls83Zs9wuiZ7m1g4LsH8xqEoIHB1SK5mJ93e+/FwFVYeVcjbqE2pqGANjPiBGgqqz4nJ4to/U/yfwXdlJReaiWEXzRlRe35kbtIrEbasVBtYLfvvtat0w6KORQCCnnoaiefnECNCuCCwYzLBeF2M2pKImcYrQniVyP1eZ5el0s2UdEbAHTsiTMVLGok4V8dFy5wa4DfabQL5RUTjZ6np+zIFBKCgy3uShFqnSHJLsmwaxVDDEwkIB5cFv0AR4A6pnvyX1q2bIt9IQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m1r/QsuUlm4B2yZhjRx11zOF04Wz5rXDD5wEtEKGoF88j8jwKA0BezaSOL+iGHZWFd3kX8K3Dusm0tV05Jzeavh9+FbXtHRG03oCClTujIjq8tB/t9KYd4XQBcfu8nNYXiJjbSzr8QKqpLYmubRrBkGP4AM6fIfB1hbREMTHf1uCH1chKp6U1N6YvYDq85Aki1356bS0zEyjJEJeTCCM/mbmpvl/MQ6ZINZruu2U2MLjIzK89Ib0dAvj9DOtYUtTxsswXh0bHUCtt3xRgKnIBT6MiLB3MQ/KKNV2p/WAiOG+GPIhVNR7roNs4QLkzteiOAECePYDpyelxwTWtYEyoVMp+6Mj9lP8q44dlTq59F7s4RX5A9Gr4N0Jljl1Cb2msi8e3/tw94Wdv2DMk2ckqqMVNivUHl92lY6Dy49Pzb/jT67WZkwP1lXX7O2tkdZF
X-Exchange-RoutingPolicyChecked: zOkQhNgX8Afb7TGIEDPD5749vqh0lFgCpreQ3NkrD04FJ86Y+i3KxTsp6Xz7ynOfVnxLUbXwrXaNO0j46vtChWI7jECzFJIcqWTi/NlpiQsqdeiPRDDgfB1ClM0xMeds50iagDbGM2AH3nGcDDY2yrAmi4RoijOYHe2OiBvYyBSjpYm3BJvReMhtTYzimOjoxr0Ac2G8DC1JWlLwGFOsYDEtVHXjMMDlFndyxQunYVHJZDrXKWbUKun1GtphZhXzhw1OKyE04EqilCGMd/oj4XzgwqfWhwKRD1AKSah2uZ0UqA7I+E3zw+FaMNUE3jbmu/OLDoxoLsF2VoB2/LuaIA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 02:44:48.0493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 558ae780-694d-41d0-c74c-08df2bf89c29
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6956
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAxMCBTYWx0ZWRfXzwAt7xrNiBaW
 vVh+0VLE7TgFsVe1Odn/VBzcHjKq4svvho7jvpKAvh4Z3w7cPTiFP7sHbNcGkb1gmPz5mxdDVXS
 QcHtIZ6g/EXZgDOBXXyaymiMLlLwCLM=
X-Proofpoint-ORIG-GUID: r00ZN19qdVLeSxCTRpSDYwc-bTv2SiFg
X-Proofpoint-GUID: r00ZN19qdVLeSxCTRpSDYwc-bTv2SiFg
X-Authority-Analysis: v=2.4 cv=IuOL47/g c=1 sm=1 tr=0 ts=6ad2e123 cx=c_pps
 a=ChtxJ3izA4DGUCEzIvXZbg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8
 a=CClic77Brg5jECpCl-AA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAxMCBTYWx0ZWRfX0NKS4GAhqE3R
 tMwoK7sc4NP1CtIi1hdNJQMEnSUY/M23V5vju70okNPPNdIBi02edk6dSgHkoWK/RGsv+NEWY0z
 vvFyqJSQpJGEBx73juJoUxRtTs9x73J0O4cs6MAy6d5igz/fVt4+tXqmfzl+OZkkGmnQgW849FC
 EyXvihGaZEOb2svVtB+vL77qyyZGOHrNOLQehgNbYpLwc6UR3I7viQoHZTyi/O+4oCzRybYBa6P
 eZBfwxq7yN5ag8VolZou/0nj/NXRbmSLTJMm5kLQemja+LS2HnlilS1uEltF8fjVapoKbY2yZY1
 PwjflQ+71DDj+ZshdUzKvcc+HJUx17EN4CayP0aWEQYDvN7bZYpld1vQkBLfxKK1FfRewVFME0a
 65woTRglxcoH764M11tM8Cdzruvn82uTOez9UIR4rUG+wrlMiBocyWyikcXQdb5wjhYmaBBUkIb
 OltHipE6X6gvexxE5Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170010
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



On 10/16/2026 2:35 PM, Markus Schneider-Pargmann wrote:
> Add a helper to wait for TIFS initialization to be finished. Effectively
> this is just a call to get_ti_sci_handle() but I think a separate
> function makes the purpose of this call better visible.
> 
> get_ti_sci_handle() internally leads to fetching the TIFS version with a
> message and response. TIFS only responds once initialization finished.
> If a response is not received get_ti_sci_handle() returns after a
> timeout.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm/mach-k3/common.c | 10 ++++++++++
>  arch/arm/mach-k3/common.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 6e382efdb3be..480c90cfa65f 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -54,6 +54,16 @@ struct ti_sci_handle *get_ti_sci_handle(void)
>  	return (struct ti_sci_handle *)ti_sci_get_handle_from_sysfw(dev);
>  }
>  
> +void k3_sysfw_wait_ready(void)

Please put some warning on use of this function.
On few SOCs like J721E, u-boot loads the TIFS firmware.
In such case, no point of calling this function.

With added comments, please use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> +{
> +	/*
> +	 * Wait for TIFS initialization to finish. This helper is used to make
> +	 * sure TIFS removed the firewall before U-Boot tries to unlock CTRL_MMR
> +	 * registers and continues the boot.
> +	 */
> +	get_ti_sci_handle();
> +}
> +
>  void k3_sysfw_print_ver(void)
>  {
>  	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 37ff98d89924..146b986febc6 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -38,6 +38,7 @@ void disable_linefill_optimization(void);
>  int remove_fwl_region(struct fwl_data *fwl);
>  void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
>  int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
> +void k3_sysfw_wait_ready(void);
>  void k3_sysfw_print_ver(void);
>  void k3_dm_print_ver(void);
>  void spl_enable_cache(void);
> 

