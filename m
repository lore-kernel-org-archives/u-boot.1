Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0875CC6B20
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 04:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55BFD80D74;
	Wed, 14 Oct 2026 04:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TE7tIVTSfCx9; Wed, 14 Oct 2026 04:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3419D80BD6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791951192;
	b=PDvY9KnecDHHdGVt9g3Nh4iGNBUATUiaTSG3uCXDocNU09NUqONSAR1QaJC1+7xnJHSC
	 HUZou+keO9Kl3Hnjb4UBpBiNu6zYc0p5t4l0enKDG4JAnBDa6mSBQ2YVF59iAMpq35cFy
	 DG7LsZ17R2Vz0S1pHvXkcx+q2AN5NiPBP7PjWdqLD1cjtLhX1v0Ud9Lerj1TPF8OZNjzF
	 Bcr/Ptm9Ze85OB57HszE5TMZa4vC35D6DfLrTq41C7dW7CkKY7DJNVkDGz33GdubZJySy
	 JLDuuTvcFZlrfXxLop+i/Bbnh8RT4zbZAwQFalA91SwXqFFoLT2mcYbsNbvrbRYTw4A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791951192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received:Received:DKIM-Signature:
	 Received:DKIM-Signature:Received:Received:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FJgKMNuGh8d3eh7ExWLuqQbRKRYzbxoi+cwfFZCnPIk=;
	b=p2+RNS3U5eyCMtEbJb2/jAve5t2UHgCfRdotRf/9CMkHTXj4D5U9RKnIeEyhpVseDPtY
	 lNu1QK4476e4IikONathBk199TDRIrUa9WF0s2Yz2fhJKU6y5wz4pWLdotpy5qElVKQVy
	 0e9z2HIxzNEXo9yvEln7osTzF5FiZVWhgbmtbP72ASpMMtiCRvuaSjiyy6gxSKl6cVLD0
	 Xn0ilCiVkWqS+412U2aqusD1SHIM5bFd3Zi/UjTuVhE12jNyQ1UidlLEY3KiBsIMiYTWT
	 +x4kxAT7UX3ss+klsMYGH7aTUQtNnexFxfAKrePget1LhMhToiPokHgejFW8YMpHfzg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791951192;
	bh=FJgKMNuGh8d3eh7ExWLuqQbRKRYzbxoi+cwfFZCnPIk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o40BI+w+iEZ4DivueFfW/z2TK1ieWDUdbTFIH2+qf193gKe/VpwW5GVYS6gOqKK1h
	 4N9HFSA0C9i6zjhPRK3Eb8v8owwGgTcAVx034rprno5IsosqKDsSWan7zZ5rk6F68J
	 H2C6wvDY8ph0QwSiDaDGt/wf6O/PLvFbOGkPvf6ul9uSjFKQugIqGpdkte4NuWf7ve
	 arep/Bj6ERndW1Guy7FdTzPpVJBv0BkPWCMC02RSC/eBR/lu875G2czMlLkx1sY8W3
	 /UAFhao2LrbySMUoVmb4+8SsYlyInub5xPQC/eju6CBpfUZm9AO0I2E83ZZZ5vHBzz
	 VLh+NUHzs4YOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3419D80BD6;
	Wed, 14 Oct 2026 04:13:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0821235
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A58F560894
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3v4e4eesBNmH for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 04:13:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 144756072E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791951179;
 b=G8t0dfqQ+Ox3FA+aakgZAVre7hQAjHCX7TMnGGk7SDE4vudvSXoYsUDq5cabPHo1O5R3
 OznF5syvI3da1mPhACpqfBMhIWq0WYl0JKR3chN7CBJXQAEsvFa9yeXup5G/NaZQNKKIG
 J650U6T5p7fUN//jNmsz6KAuA1+njp6UQKyl4/Ka46ClvCoqzucpFO7LF/MRbc7pY/XlB
 6trpg0sT2k7vxG6p6Gm0MazW61kLjq5bWyWE7il7zvTQtYArX3MMgmzqtXFzpx/O9fM1N
 SsxpjopkOvUkE8GFpjZhSZcaqTpxkovsK6K29i8MHp9Gf95lev2xGF5QaCqe1hGnsTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791951179;
 h=Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FJgKMNuGh8d3eh7ExWLuqQbRKRYzbxoi+cwfFZCnPIk=;
 b=mcD19qGOtplf9OsexPiZS7mZtR48b86NFLwhtD2FbMIYcOANXVeVXtoDUY/yzotHU09Y
 CYfpQ7DbAKJz271MGFA8UsqkW1R9N5fnie6BV0tcBtqJ4EwDaz0QPrMEPOS6DIbpgiG4P
 fm0oaAk8QNl8T8lNV4/Qx/rrCDYFdV1x2s4/Am2fE7zf7jMRK7gInWqxvmSeFquv04Z9D
 wQMKED56GtoSUAyZitQ8rpkSU9scPrvwWyBdahBvXJHAFeDYZMopG/QVcJZVsTQTUNkTk
 5+OQWyqUSM22QGbuJg4PEzyH6mL7Sxt+I7yAKo9olEAoJnaQkXrYZzGtTQFJ5OzOxSg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=dWq1xueg; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=dVBsyGIR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 144756072E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:07:49 +0000 (UTC)
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dWq1xueg; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=dVBsyGIR
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69E1Q1lE2155410;
 Tue, 13 Oct 2026 23:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=FJgKMNuGh8d3eh7ExWLuqQbRKRYzbxoi+cwfFZCnP
 Ik=; b=dWq1xuegHvaiulNLUfWcomFrjjJiAGnwAwvbF+oCxJ/i8QadSyLADlkAe
 UBaWoKnADfMVnx5WVrceZPoucyjJpuXnjUFn7ECtgvIdlO8wjq8wrc74yAFyyWeC
 Qubhkg4yyDQoC6SX25Qo1NARNOAWJNByCz31lxL/qnd5tBpxbcrA9U8ZmX5jzu2K
 bq+foE6Ywe6JQko6DWaqCIlyW+TE17KtLnSCUFnQcsCC0c7leF82ECO3nuI0RSRm
 C/fH2IzqAySK/yWdb4beszRz/qu+A/Q0HRW9JR1QeEw9MgXf1Wxk48+6kFzLbipo
 +KrJTH4IJSz5mBmLlj7N1LwVBW7Xg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ha02r8s1f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 23:07:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OV7bhUKZxp086FkhS+tArKydcfd1LmJI2kBs/6WGcod2cMKkKrcuTAmndVRu/l+1tFq8y//HdEGQL4KwTARTtO8rSD1jUVkhUZgLR1RN8Pfi7KCCGvCEJCYkl29298xZoMk485/rG6kjtbf22qaP2DfsXXBp26MOZP32Um7aUBCaRg8iqO0JqWYIfDTCDKGApC00jT2KoAs26ocVundLfDAJs1C6vZzWWDbhWEnMz4gxTQky7eL3fM2U/p17SbmlupLetyK7Ygk9iVtyc6Mg5jEjkX4U623xspyqIYcTHmqbzti8W7FB44QR/7nFZcRol5io/DF9AKx/RVQL1fXjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJgKMNuGh8d3eh7ExWLuqQbRKRYzbxoi+cwfFZCnPIk=;
 b=LLX+G4o1OnTW1Sr2Q7jSowCs8GcCeu4z3Y0wzJihyhWHUarntyWvrIpBWEuM01LDkXzylCwThyKsNhkt5BiOn/T9HI2Y25RfpGFUo3VYYlEEIwV3ZOAWdxd1+yWV9mJrkk3Lti5fE3AG5xTI1BkmggzVn+aTeA47UCEcjipn8pwlkHk2z8V7HGiSxVkPjpsu0tjq0kG2++sY/qmk7rnZrGvhpOOeUsInO/xw+G6KH+k4rOGlYfw88CCXJVlRk7lzA95X1g//Krm+41dAs6F8gmn5gsMCKA0ge9HlSFJ7v0sOusC37QGh/ubmiYaz/4FqoV8+KtGhG8IQOEEA3nMrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJgKMNuGh8d3eh7ExWLuqQbRKRYzbxoi+cwfFZCnPIk=;
 b=dVBsyGIRHeir5w0PNRNTT7oWE49E2aFNG/I4VGGmW3J/nt0qYajVkv2wgP66R4ONTCb60U+3EJA4gntpXEcwSMztiESq+3fpSHDPtq+QPrCthjbIRQOxeVnfKpBPUegmC14s/lkVX5f0+bRihizLs0LuKyqJZeqiysY1V2UttR4=
Received: from CYZPR17CA0024.namprd17.prod.outlook.com (2603:10b6:930:8c::8)
 by PH7PR10MB6201.namprd10.prod.outlook.com (2603:10b6:510:1f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:07:38 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::3) by CYZPR17CA0024.outlook.office365.com
 (2603:10b6:930:8c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 04:07:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 04:07:36 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 23:07:07 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 23:07:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 13 Oct 2026 23:07:07 -0500
Received: from [172.24.22.240] (lt5cg60819vj.dhcp.ti.com [172.24.22.240])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69E474FC609216;
 Tue, 13 Oct 2026 23:07:05 -0500
Message-ID: <83313243-51cc-44a8-ad13-8c53d4343350@ti.com>
Date: Wed, 14 Oct 2026 09:37:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: am625: Wait for TIFS initialization
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Daniel Schultz <d.schultz@phytec.de>,
 "Richard Genoud" <richard.genoud@bootlin.com>, <u-kumar1@ti.com>
References: <20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com>
 <82208a4f-b91b-4415-8173-1272189e372d@ti.com>
 <DLO86T747FHQ.2NF28TVL3CFX2@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <DLO86T747FHQ.2NF28TVL3CFX2@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR10MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 98461e9c-79e5-4531-f6b6-08df29a8ae70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|6133799003|18002099003|10067099003|22082099003|13003099007|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1z7+aEwCkNQ6klZK6cU+Y33LzQfPD4PEm5IOYHF7B66f22B5n5NPDKve9DFXfIs6cNxWUAobv5FzHRIwGR87FKsZHN5amgBqjF9Z962waOy12h6uNsvQ55wZS00g8BRyYf2vwLipZ9sewRU3PZjsjRgHA0H8FB3WhqqiDR6ZHTRxh+b8mWxbMkcaz3FmxUw43G6AxHoLKoUXo+puPwInAYaPA/o/6D19PG2+xwX+ZK918etir7PiYnWw0BmluWoJfVtAiyyh5iBheTZgxCHXgpEejGIrbklO4r051SgjVKP7B88I4N5bOVHjnkLgNIE5fVlV9URvcqKXxZCUIEHLPmR/VhvvfdiNwRV9V9k5MRiJ/nI3w/c8ZJeTEGLy9vwMRQE5eaf9seE0EZ/ygQt1HIrg0iiViYe2feHLGO8QFIRm2S8rfOA7lo95dcs0YgrfM1VDcHtYWwZYy7dvEid6FOUolHFT+1Eq3cmzersHoMVaItdg2X5PCk+XeGE8aS6SaeW30fzHBH/j4G1UxVCu18VJPwkCt7m3GgEYUU6ZgAbvDi4KNzLQcbk0cvQ0DKII22Qcr+qI+HvCOnBP30TlrNVEeLYvpthSYs5PFjLBu6L1n1T270B09bVASdEVUXqTd5S2qA3jVuPbBcB8irNh8+2rh95WIKyn7JFvQM4qf5k=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(18002099003)(10067099003)(22082099003)(13003099007)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jafa4xo4OwRXxjleqEEIzhrMsv5HNmA/v5tHqcClgZ5V1NS1TNiw7pcGDHC1cUXvejYuZG4WPTqyj5kDZugz/Y3EG8Ukk5OXxOa6tE3iNG3pPnWYnDowN3nzwoGOqsxO1/tlk44cU0oWsBpUeFRRZ79QTr3Q8YJax9KDSACVTWwjMqavFg+hPuwT+Ybq2jq5V7qLU6UvhR/6F/I6nnDDbwIzQjOYTYQ1YqlGzONpv/BJuMwdaE6/VbyDQ1cQ4nCBaJGm02W+fvSYR4sjGcPJjkei31yONaFk+v9m7JGhSl5xA9k4UvWjSEeUl2CQmPyxLQ2MowRY8LVshWKLi95h+ICYSZhnQQNd5516mLJsozcJ/4H5WGq33OMDUjvV1DqkJy/8vMrHp/g3SMgSiatF1oSDoR29VBzSmBgqsxX0qyngxw6QoOTy7aIRRZjGykBI
X-Exchange-RoutingPolicyChecked: t3MU/YngocBd5yEv5SlAl9T4Xr3mDzItMLVWovf5xQE2i7F0Z9fuIG8sXPNe+45HeHu7a5hmt5Lm1fENnXaoG9GH+dtTXI58NUx+gdmMLdXD5gFM0QsNNLFhFWpka3Hkfi+76kyzCJWA9Br/snnebK3tXr+WP5jQURATEMBQ1oTk8Hr3NrguTtm4fdxU8ML7IXM+2mMGyEhJqmkttdtcZ6UDFkRlgzDaQkcNQhqZGSBPDnOHZmlzm+ZAmAIiyI+xBbgYfv9tcY+peNNxQFxVOBwhbzCmAlOzJAvGTKgaVc88myIRe8TqtTNbzezNekxI9rMrWYjhuYYOUdv43MGx9w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:07:36.6965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98461e9c-79e5-4531-f6b6-08df29a8ae70
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6201
X-Proofpoint-GUID: VIWqNo4R7LtVLn_8L9VOfm_KJ359AKGx
X-Proofpoint-ORIG-GUID: VIWqNo4R7LtVLn_8L9VOfm_KJ359AKGx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX2VKiJ70kTh6v
 n/4mVccQvIYE4rO6U3kr+sO8jhhIQWk0seIdFj2mYkZyLR1rbsJhSn1cqcEqaCPmXqt3Z91DKeB
 4WYBaMJK+diIM/vxXy99QH0cZTDEdUNM5+AbHJWFP/mPfr+I4PIFhX4KNfsxe4EBzBad0tLT+sD
 10wdFdlVnokYXV6AbBol1XhAGBDy468Qs6b3hT6BVAzibyambdwEMCcgWgTNqNPK2ZhlMYpkX7g
 XGtQRQNDnntClfS3I/CiaMCWZflnG9SM4O38cJ7UrBbZmo2u1lnSLX+0T7ZrIqbuz/Amghlp3mE
 EqaoaWrrWuouS5jdiGfGNpmRMhurO4doWo9FcVJ9kLkyyua48PKJptOLQ8F64hfm4xgInnHwEai
 1LpoWUHFNrJj0C8ThN4CL8Y3/d42oKevi8n3uCr/3lbZMag8YaRU4PWsKnqyJWq0GXjA3tFi1ks
 ITikJA0ovceM+TIMSrA==
X-Authority-Analysis: v=2.4 cv=Vcxir1p9 c=1 sm=1 tr=0 ts=6acf000e cx=c_pps
 a=x0D8RYL8GqfJKF6oaN0fjw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=Gfcx16FAE3elvPEKfJoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX2SUL9QChA5ON
 iBy4Ag63xzLv5CWIDG9DXvTxXaIybWVow1fwKPllRcAa6Dl7oUeCwwVLiLoOoSXwqultGs1OD+T
 1UX7CGRyxzmqeQ9BD//AAnqUnfZ9Wec=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140016
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

Hi Markus

On 9/25/2026 1:10 PM, Markus Schneider-Pargmann wrote:
> Hi Udit,
> 
> On Thu Sep 24, 2026 at 3:00 AM CEST, Udit Kumar wrote:
>> Thanks Markus,
>>
>> On 9/24/2026 12:40 AM, Markus Schneider-Pargmann wrote:
>>> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
>>> the firewall on the registers at the end of initialization. On HS-SE the
>>> u-boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
>>> leading to a race condition. This leads to a broken watchdog since the
>>> signal configuration doesn't succeed because the write doesn't take
>>> effect.
>>>
>>> Add a get_ti_sci_handle() call before ctrl_mmr_unlock().
>>> get_ti_sci_handle() leads to fetching the TIFS version which only comes
>>> back after TIFS initialization is done. If a response is not received
>>> get_ti_sci_handle() returns after a timeout and continues as it would
>>> have done without this patch. get_ti_sci_handle() has to happen after
>>> spl_early_init() as it requires DM to be setup.
>>>
>>> Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
>>> Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
>>
>> Here tom advice to include all platforms
>>
>> https://lore.kernel.org/u-boot/20260226143756.GC1593142@bill-the-cat/
> 
> Thank you. I am aware of that request. I can extend the series to cover
> all, but I don't have any other HS-SE boards for testing. Also I changed
> how the implementation works and wanted to gather some feedback on if
> this looks good to you.
> 

Sorry for delay, I am happy to test on HS-SE devices,
same time I am thinking in below way [0]

[0] https://gist.github.com/uditkumarti/3472e4f3975d1a404adb57635ddd04c2
> Best
> Markus

