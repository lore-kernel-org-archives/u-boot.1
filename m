Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B2AC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE2C060658;
	Mon,  7 Sep 2026 08:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_h6wQXBmlBm; Mon,  7 Sep 2026 08:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D28236061C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788768630;
	b=Dv47d9xJCiIjohbOsBHH+0P0Ag0WYeQv3bYCIvmOuqcI74RxcBOvJJO2mbFYF31bVRoM
	 q2VZUizz1Rl771dw8DrXlz+uY7BTnWCOQtPBzdMbmsIKH5xxlLMp9/ktIeSN4BvDDzxjc
	 diIOSKQcThGkqlUsMNmLb7p5mszak09Iw8L+QGyDsfp2KqBDq193mIZcw5wXzzogtrc4K
	 wv09nc2mBT9+nBVVLS2m9BdyobUbGclKwS5Av2ix/O3ESaxggG2EoLZ14TDLf/bDXe3cf
	 8dfoRt5CIPlOaUVXhxh3CbMWSa3XM6l+lYRQmuclZKsJZkjt/kRtI583/6t/7agCYwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788768630;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VSKiRLHkDyVll2y2oQJO6PHg3W8MmeA7hP44PHey2n4=;
	b=dCOwwqFlf3m4lDEcRvMHJoBUD1w3+KLEmrcnMX6se2dpJ9VR+FI9JdRdgH16IqiTtaxI
	 wJRXCPIvEEikyBfdYDd9fCGtgNj4+MuXQXKjwHmna3d8fPANU3JjctDC0LAsh30jqX2mW
	 xA+bq+Oj9zi0fLl6Yseugg6b8M6zPd82n5rzHnTYklyho8CzQbw2tHaMaCABIwrAcILfZ
	 N3/AgNSzm13owFR6I4YyrP9mvruut4z5+H/UYKqnmK2lF4G2AvDDBssclJzwl0cHJJlq/
	 nCvzvNM7RMLZkgktTb/cHJ8GkEfMqcv/IpSg+/2LYLK6ZFI8WYdKBu51bqxxU9lcnvg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788768630;
	bh=VSKiRLHkDyVll2y2oQJO6PHg3W8MmeA7hP44PHey2n4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cGEdn82F9juBXKvi/drw7Vboookvqv7JLWtQOR8qOz/F2Mx8tiOpTW38fb/NwQgXz
	 3bafB/Td4YfZkGOvtAMc2t22f6EPUkxAhV9lU8bBt8apDijq//5EGZkVefhwAr+S44
	 hSbnGiGO8NdOXarcB1wYpNZFeEKvnXzcq9uqMbrdfPc28Wld5KVmMV8FSK3x54vdBy
	 HOBGhx2CGt4w6E3yrD9kUx4k/laR8obL57auSBSgPwy4oyvbrvP5cJ4CGfpQGDXhZX
	 PlXrchmxBPt335w1n20mrXR8NpmXyDxcfFK9dpnXsoDYFfIxYdZLQqtBXFkt6nm+t6
	 mYSh0DxUe4ryg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D28236061C;
	Mon,  7 Sep 2026 08:10:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CBBB4970
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDB98400F5
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dg3HLQXY2H_a for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:10:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BE49840068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788768628;
 b=XLVg8YkGq5ASi6O9MupqcuUXdd+J+rgACtf67yhxGhczJbk7mcAJgnInPun6bxfvwf9x
 K0K0BmSRrv1+rXkcXMFpmaNHr5qQgjGEPcLSuBMc8+SaGqD/bIGPeye4k1jfKezw1MwAA
 IkAfgpPq1hFYoK6n++yBQBj3YeTY05gGD9AQjXQPxipLN57BnzLJdeXmNZ0bMyJ90Pme2
 cFk9lQaM1AkxEb7XFCXbBX9IytE7EMngqh4H4Y271NqNGxpZPjNBtaxUxlvEgD6RAtFAq
 vXGNZJ2H9txcNnwhpwM5QagDxWXTmcvRZ00UP6sqPNPDlG2nah5+WEWLqK+2FKFwuEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788768628;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VSKiRLHkDyVll2y2oQJO6PHg3W8MmeA7hP44PHey2n4=;
 b=MZHYiNjgdckmD06IwgNtEyZZL69Kr2uNOL6iPeZX3ya4ra7ghfs0B6EV5hdhFcqhycqy
 ihtQRi1kVf298T4ZKy8t6L/HfNYzSr6Uome+ZNBBMaFTJ/f+Usw54yP+bFaWkSh4TxArF
 xTCVrYveSACiWBR1Z1NyfOHipCDRfkVtkfm7XcRYiB9+8qFc+EiDPiS37upkXlnp1UH7V
 zVshlJ1jEvc5apaZXuZYlxEiBNAzBqlXaoT3csXgiD+F0JP6FVR5fF08jtFv0lbv9lcy+
 bPkWvAGGclOZYP03TG3B7evFCNZx+9MHAMtkuZr+UwcpX3BACJW52zGOSao3Qsq1Z8Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=RaNIfmP5; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=gVaxAMEN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=RaNIfmP5; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=gVaxAMEN
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE49840068
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:10:26 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68776CEj2796084; Mon, 7 Sep 2026 03:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=VSKiRLHkDyVll2y2oQJO6PHg3W8MmeA7hP44PHey2
 n4=; b=RaNIfmP5I4gnI094VPpafO1tsJzu3k3cAFOJsQzHNIXCB4iXPnRaGGGe3
 0tFt0eSz/4pfHtJa5teryjcFW3omXhB4TVhgi5gru6eFZMYY2s1XT6y7gs1U6x2t
 bLhUr10wkcMxq4sABgbKcw3oK4o4izC8jNh4IsnHRies8xokL/TVRftOV7gmReqx
 lPZGl/LtA7zXxvHGHQlmy3t6rk9flsyXg5oxju6QqRc4qKqfrjHKJaLWrwsgQeu3
 YUWfj08r7FLzouNG5dOJ/fbDE2A6RMmzQmkuc1qz+1Lk2XuxDl/h/1AlByrVEd7u
 TuvKyUsiD+/VmvLKvOuYHIXiYtoGQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh2f6crgc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:10:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqdreF2vI9MzX3hijSDDyuQ0wJEedbFlyj5FObli2j03fMOE6LwN84VybtnZgJn3B3bY+g/1Ot8VcWX/fwCHcmREiOT9FDWb9q+MsUcK8c3AkgZrrZkiUUKFCQDBNmT/oXvyat7vkfSdnON0YNg+xt7lRwvS3ZRP1byvseCID4zgQHD4Mt36edUFenhsd/G8kFIEiyaYN8nctVHBIcR8e4vS3vPE7c9Ze3NpX1FpoENPKBEPt5bET0MLaQgBjJoyHZs48D1468FSfxp4ktmEWW3U9QAZ6lw1MmA0qIqfT7ZHZSf+LsFjHQVK+g/AnQgDxwxujWp1rILKRvnY6bUbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSKiRLHkDyVll2y2oQJO6PHg3W8MmeA7hP44PHey2n4=;
 b=SA0CFUxUa1QQRRGXgPe7FUxuXhVi8bdqMfXHTbiVheo6awh+UOg7QK3p/RJPcQlViy+gBuvWzDiBnKLiQniOYBKKKfVxEkvHhs8Ve/J++2HxFk+R9JRrRmSkU0v9u/HkMOCSopfME//Wyar3cojh1Of8W8WLrpsLHzgsDcbX3/8c+xe0C/qT6W5nX3e3JWfmtDas8OSZohcHjAKcHMWMiBHhY20j50I22paesk4Fic/B3Kz4vBGKVkLDsQF4EOKLCBEuxQ1h1XWC51thElxtRrY3MzkZY7S3crlUv1nv3J8WDVwfDOtMuGzbX9rXdWRfkpqmd4NnUij0cpb+SYFTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSKiRLHkDyVll2y2oQJO6PHg3W8MmeA7hP44PHey2n4=;
 b=gVaxAMENCG1yHFDR15b2R8/1o9NEn7Srm8UfyMGxwo1xc+0QlY1m7nj0BrqTRng4W4UawJuJBgPJGEXA94kYIpMnnz6VVyt2ZhBwqpJcs/Yv87qhqD0li8XzSQVg2tAc9Z/DllNoLoX0FZlRqPfaMwaCoisaYkAgFH8pgPxT+uo=
Received: from DS7PR06CA0008.namprd06.prod.outlook.com (2603:10b6:8:2a::15) by
 CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.6; Mon, 7 Sep 2026 08:10:17 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::8f) by DS7PR06CA0008.outlook.office365.com
 (2603:10b6:8:2a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:10:16 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:09:29 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:09:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:09:29 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68789OlX129924;
 Mon, 7 Sep 2026 03:09:25 -0500
Message-ID: <dfbd66d9-f645-41b1-a394-a1ca11839b0b@ti.com>
Date: Mon, 7 Sep 2026 13:39:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/21] board: evm: Enable de-isolation of IOs at resume
 for j7200 and j784s4
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-10-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-10-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 473d8b22-9c69-45b1-4d2e-08df0cb77334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: npsO4XLcRqrZU8VRbR3hGEY/JWI88YsQFxGxDfakLj27Gy/id96dy31dTPbaLUP//zWDLVn7EGQZhqf4YFr+Huw9uvmG3TlEceY1CEYBcWWPQqBhuePK7yeTUrnpMGYt8CJxB74p05lIuhb7LI9hW5jjDYczTYQKlPnRLVBl6NN/7etL5F13j2BaXczXBGHO0ozqA06rbeBAQUN+0lvwRKIj73h8X8eLKwieEkIg4ZGCM2f7hAxOxksEji9vw2jIRNamNRQpLT1b73sRGiYSgyTrYAqXigUS0DzX5ouOA4ycz8w1obClHuDS0Ij62k4tPwMPJNd25mrXfXFvCHfqxHn5mCmJRG9Zo646j6wdlRedyt/hb5mG3AXzRQkyvBM2xbEJ//t2aMbzEOJQrKvZCbT+1S2U3GED0fUR5W3cUqd6fY1aDTORw45ZAMuRU17QLkEqELyUPNKedp4FA+oPxdYl6lrW46HnaySAdBlaR8VJwQc1vgayHl51eTW468E9xHLWxIVWzyBDW3V2hsp6N2OhOlKh1yLARa2lA6MCdE6J71AYlXL5xpADRG/8h1msmaJ/SceyKfJ9IxVrcVcawPSA8bQFe/McYeXaLFutxXYzKG4+7tM0vv6SOOvn7wPl9iYVKEIpTZeo7AlqwxNy+87nC0r6m8nCnmz/VNYdOnhu8X7DL4L1ig/U1EjpJUuPJvXTve5lM/kjiEmFtSyJKg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WoRTfpKYporhzv+ilSbqfboXZlSdL0g3N5FDzMNiU3Tg+ltQrEjvFNJxR9IHicLOOBAA8H8mFrODwiRDXa2x6MJOryFW1EAtFawVgGXlo1fmhicTDHSa/mkCrRIR2sZhCf1OkgGELy7HMel0JVIaWRY37ckhsoUTsEWWKPnbkRtyI9dBjfUHJC4bmq3D4xYesDcQLc+UtPcSYxNcWAJj/6Y1WBv1w1n7lSYs4FwbIaq1jrrbPUpi/+/XLz18LHi9GV/tbwaJzgddzHZR8Q7nXb/IYTiwAbW9q4pqSqrbfjRnsWFNXpPggJKnSa1o+n9/NMZ75KQ+FFQcroEY7pRmB4Qo1SipMUGLQjSEBObTbzX1HnvFwY9VPZI8Cj6NVYCjmucdcoZFi0gIFuu4xMbjIPmD8bVKoE5zDVgU51ZY4RBgjb5713MPz7PgwOWHJWzm
X-Exchange-RoutingPolicyChecked: tn6TJfWFhOeHf9wm0GZjcIKIfb1FUXFibIzowCydHBH3lLk2kJ+GErVmqVTg+N2i6+F+edqjztCMlPXXxHXYjAO37x5GSj2sDAQPNNvR5VmkggblFUThuV7JB9DW3vJUgDVh9+cbaMF/kYXgzItEfJ1UdM9sQEmQKWzOe8MUq+rWgvGpsjJhCkrIZmJXHmeKyw6InfhH3kDgmJ8zFLOcRjgQEEfBGBOcLFlHsTvWrxMV44wmFP7RMmqY9hJUyA77VFeoaJmZfXnjTJvQtTOgsNQKb/5NRtux6XZxCLs0LIHra0AusTR+wDkkZfZsuDgtDowRtq9SNcH4W1EUVGKN+g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:10:16.0510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473d8b22-9c69-45b1-4d2e-08df0cb77334
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-GUID: KQkxWniZnGFXEZ6iGBZ25VlD2IY4_rIj
X-Authority-Analysis: v=2.4 cv=Wqkb99fv c=1 sm=1 tr=0 ts=6a9e716c cx=c_pps
 a=pAJzO7k5KbwWJfk/IQaIJw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8
 a=tJ7v478wPRtO4BRNew0A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: KQkxWniZnGFXEZ6iGBZ25VlD2IY4_rIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4OCBTYWx0ZWRfXx96andMHXs9K
 mfYStAekOd3lJMx8Jy818xfRwFI+hr4SZcXaqeXci1tRXbH9E3ZpTbTCRa7aNdjmbaN/XkH6guZ
 zB65rKBW5wjwmN2bAbnzMALiEk4y17KJ1Rf+OKxjvD8aWsFWmtPfSAbCa5MfNwNOmFZY7iuiN7W
 ksS2mhlKfqz1pQDcJX3gfuaRa5/FNIHO0d9HutBwpLC4xEp/bqaKIxusFXFZuUjQ02wB4DTvFbG
 IsFKghyICvX0PI730JovIE57WKegwyleOkW3bQjlbV4JxcDnRzfRPz4IoJTY+qoCf72hnHf3H2N
 lWza6EBDfkw4Ynu8BUlGq1t+sDm5qgUp3QMX1reSrhK+LVsEpLKtSI3VYctQY/IdqotBwRubQnw
 ksg0oUVqS9wJEVfIUKULJPGGzqxTlzHxME0aeBDFwRwXCVUdoSRTX0JyaFZElOHWvf047J7IooE
 VCP4scnPxkU/SzIWKVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4OCBTYWx0ZWRfXzdkzrhsh+/+E
 e+gRMPvygId9cotAY3U4MuC6NDkbCWHz6nRodUILefmHkmXmH0xCGvLR6t84XhqiVcAEV/mGKKP
 BwWt4xr5HrResXFWX3+o0xvd2kZ5kb0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070088
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> From: Abhash Kumar Jha <a-kumar2@ti.com>
> 
> When resuming from IO_ONLY_PLUS_DDR low power mode, the IOs are
> isolated. Remove that isolation in resume sequence.
> 

What is IO_ONLY_PLUS_DDR ? Please give bit more context about this mode

> On j7200, The canuart IOs are isolated whereas on j784s4, the
> mcu_general IOs are isolated.
> 
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  .../arm/mach-k3/include/mach/j721e_hardware.h | 11 ++++++++
>  .../mach-k3/include/mach/j784s4_hardware.h    | 10 ++++++++
>  arch/arm/mach-k3/r5/lpm-common.c              | 15 +++++++++++
>  board/ti/j721e/evm.c                          | 25 +++++++++++++++++++
>  board/ti/j784s4/evm.c                         | 24 ++++++++++++++++++
>  5 files changed, 85 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
> index 5bef309af0a4..e6e437af4ec0 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
> @@ -14,6 +14,17 @@
>  #define WKUP_CTRL_MMR0_BASE				0x43000000
>  #define MCU_CTRL_MMR0_BASE				0x40f00000
>  #define CTRL_MMR0_BASE					0x00100000
> +#define DMSC_PWRCTRL_BASE				0x44130000
> +
> +#define PMCTRL_IO_1					(DMSC_PWRCTRL_BASE + 0x88)
> +#define PMCTRL_IO_LPM					PMCTRL_IO_1

Alignment,look one extra tab
> +#define CANUART_WAKE_CTRL				0x18300
> +#define CANUART_WAKE_STAT0				0x18308
> +#define CANUART_WAKE_STAT1				0x1830C
> +
> +#define IO_ISO_MAGIC_VAL				0x55555554
> +#define CANUART_WAKE_STAT1_CANUART_IO_MODE		BIT(0)
> [..]
>  
> +__weak void clear_isolation(void) { }
> +
>  /* This is used by J722s */
>  __weak void ctrl_mmr_unlock(void) { }

ctrl_mmr_unlock() is available at all stage, why we need weak here

>  
> @@ -72,11 +76,22 @@ void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
>  bool j7xx_board_is_resuming(void)
>  {
>  	struct udevice *pmic, *i2c;
> [..]> +	if (ret < 0)
> +		pr_err("Deisolation timeout");

this is panic state, if de-isolation failed ?

> +}
> +
> +#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
> +
> [..]> +	if (ret < 0)
> +		pr_err("Deisolation timeout");

same here

> +}
> +#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J784s4_R5_EVM */
> +
>  void spl_board_init(void)
>  {
>  	struct udevice *dev;

