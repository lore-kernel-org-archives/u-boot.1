Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E7AC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74AD54046D;
	Mon,  7 Sep 2026 08:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcbnbZT1VoyO; Mon,  7 Sep 2026 08:50:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 89CDA40483
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788771021;
	b=GwHo3kDKbHZetu7wzc5CXbsJFgOPj4AZY0XtYaz3RoQ7ASK+ig84MbC7gakncg2lz7Yb
	 hiTTjpcM5Q1bD238Bb3Pbs1Xbh3/lyCghLRwipfvhBrhN8nQdpNvkIasB27EHqUl4HA1H
	 8vshWHMZ6nAp9jKiZEmvtlvCld1b8TogOrAzZny+PP5m67KJ/GlymHA5katah+6cpAyE2
	 htEoxaUt8h5nXGRcZ9YxzDel76oypfwgdW0ZPvmT13F6DSeVHxn+pOHIc/M5D2H96cW2U
	 QaRz5pvo0M+kracKSfTP9O/jq7IFKRVDFQhSc8X8s914KlMCwjhmVxSNxo33o7rwDXw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788771021;
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
	bh=3+tCFYEwdwOCLfM1/pz7hdDQsPzauaG8gLdBkDSHfZ4=;
	b=azPmmyXswgb9lY0TxYdjzRyPtC8ctlenAXuLxNI8wN/zKQHRfBRlE1Vx+jIQivDSu3uY
	 /TJPMiCfaCQQ/4giHjtOcjVoQJjHkZFmPrCVGh/bbWw66YYyz12EOpIscZIPTUbo9UDPR
	 cnzUaG0p1Juq/N+f/Q+f0hafOyO6IrGI09Kko3GyAkxLuVg1mt+TVUUAOdNq8zUyE+uD1
	 E19hknxUo18cn2L3tJb7lcM9akeAWRAad1/6FPSdoQOGKGwMSrvDgNtQl9eeMZGWaBc8i
	 hSIPGU7QnIcRoETsIYUqRHD4owSXSq9XhclHQcIdxVOMO/T0yu2Y1BJon3XvDZTJB1g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ReulHY7U;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=RlDhdzjV;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788771021;
	bh=3+tCFYEwdwOCLfM1/pz7hdDQsPzauaG8gLdBkDSHfZ4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKAAe0rF1TjciX3AyQvGvQtCb3cT5pAcgFCNg42CZg4n0IGrtkk3sKWehfOn7ciLp
	 FXnwpXiJpvNKlzsO8/Az2MZOxpRLUrMaiEE4K/O/mBN+uhhfQcYjH2W2L9JuXIDwxf
	 otkBCD4AcZje3Us3Mdhw/0R4DMEofxiTPu2pbFvrKwgZOjOmQmCyowja8UHmXpzzpi
	 Yh77XYClhtpwUb7ObWNvv7qUrgQOF6itkSCrYHw25HuZ+sUue9RbgqjUYFcD08AHrw
	 xtwwnzIodOoHtyN2LxFhMZ/kMzvyks0RDKSN8mVC1/PvzAdBS/bwSadKrgbrI1SBRK
	 iY7Y06QwJxH0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89CDA40483;
	Mon,  7 Sep 2026 08:50:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBFAB118
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1B7C40483
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:50:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yPKl5GtrfDQx for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:50:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B24124046D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788771019;
 b=Eebe0whSz35qH/3TAJA+xXIR23t1Kn+jqii+6ay3Wjbul8bpqBlkZB47Qej0sZTq9fuv
 0Nhn0UvBPe8/iGYSV6STG7ksO3lxZ60wa4yL9lpoITd3cr7zIum/Bh1qck9RvfpbC5XJB
 pvZ9WW+8H3BWEZQBfjuIQ9hLvXieDwUCZzf0hmVLYtdjw9cilJs9wKIYkVfOFkohOMrb4
 vko7sjzVhJ1GG9S5KV0iutMLnkBWj0S785I5QX0XcYjIU8ZMaKGOOYlDM5JlXTt30krFL
 pOpAl3plJgW+e7aZAyhS9RbtnUdvUJKq9u6wDkeh0sJp/vEI3JrAtABQhiekdVIBA0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788771019;
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
 bh=3+tCFYEwdwOCLfM1/pz7hdDQsPzauaG8gLdBkDSHfZ4=;
 b=M/RK55QQc3ymLmb9HiiaWlrM9aCI6gcAh+5LWCh5KJ+IbohDJtyRtJy9eDk70BD9hO40
 lwJYz7PV1fKGDdnDl/gZx0CQzrNxfq6IMsHq8EvF2ciuDX5VdMsTbyFInJ4o1E8Zo92fz
 V5Jkfih3AGtO/TJbO2d7VFTbgW/w5P4Yse6qp8/sd3a/fAQ1krY04NbyMUgg4pI4Brkgo
 714yzd2HoFtKl5ceKl47OckEwcELMYf+G+5MZNFsyAOAiYZAaRBX3qj6ip1AcgyigIPUi
 6so/MMVYXVZkJxDSU9bz74j28P5MIrB/xkAHaaKYaQ957SL62nMGXkC9/Q95YvM1Wuw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ReulHY7U; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=RlDhdzjV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ReulHY7U; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=RlDhdzjV
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B24124046D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:50:18 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68776MA82796284; Mon, 7 Sep 2026 03:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=3+tCFYEwdwOCLfM1/pz7hdDQsPzauaG8gLdBkDSHf
 Z4=; b=ReulHY7UogTbw9Htj65I6TH2XtUV5L7UY3jZQ8BlzBnmm5BmsrBkxhRN5
 0bkNQXmBuQZhHH7QKRRfDLGps7CiwQAhqDZ4GloQW/3o3ugABPFPO8Y8exAIjPiK
 S3uGKWFen2u5MgOlIGtX4SHty3bKirR0C7oU5GstSLQkicLEcxy+jnvZHtmjrvdx
 NQjlJY5+LL4l3gfLT44MBh9i4We7WsxuOvU7xjGribzCjx0Y3ZT8mabYlKyjIfHd
 VJY+An8R0HVZUgBW+LlAIXkp2hOhlmhQbzosGfaCc6kZOgPkELiRdx0X048p1PNF
 Z3ibBnBJ93NYTFYEYLgAkBQMWFGvQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh2f6cyj8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:50:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMeEz5TMIozPvKU+JBAqkqNFI/l9wNSZrGbtE/Y7mEm85R71jnpEcnnqIaPoBb23Ou+ypRQDVZG+qp6Sl+7tQhqM+U66HXKxUoXQx/rUEFSN9KtgJD2pJnMGJVwgNZlutSuuWdc3Ggb9VqaIWAF3vBGz2jlj7z/OgNLpAhU44pS+WDisk0SQjXKHsWgo+tahxEOBf7Wnm7+8YPL8D030UsKVrq44jbIxIeBjroZ4gox392MgN111ZjM0ISPXcf2UKLdK2KGfGIZmkjG0ksDCqvZd/ey8nI/XDYDOr6qSzbk3K3trfZaNaDiQrEe89V+rhvrz79+uYxJcMxP1jDJisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+tCFYEwdwOCLfM1/pz7hdDQsPzauaG8gLdBkDSHfZ4=;
 b=PxE5VMT/DF0kEUAhyxJULVHC8xyyuBLDIIET8H1MjnQ9N2KtXLmlVRIlhY62Ap/7qWMvydNiMcwQ+V5nfEgGmvw5qMTIwSRqinQ9A3CcXjzrmu2DzmVEGIHPy/89dBAX06bfz3pA63ZOiUCa93foBUvfgiGLdycg8/7wjYi4SRuYsZPlNrFSP5ro7grjCA4G2f+b3AkMCzDtDFsPK/oAK5GIv0IGerbh6kc8G67MT+WHdUTOrn+dKUyZYsW0jjeE6l/1aY9tJtPVUhk/fP7BaAkIFUqyk5RdkypuknCNFW0MDNJ+p8ay7KSYBy0scnJmFcGK6nB6LzilF/TS0y4Z8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+tCFYEwdwOCLfM1/pz7hdDQsPzauaG8gLdBkDSHfZ4=;
 b=RlDhdzjV+V5B+5NdZsnly3f1PHefZxOXeRqoPkxgf+fCUMBHgQi99eEpmh2a0JslS9uvrqq9tCx/Ootv/vsR/5maiLSfoB5LSAZ4IhOYis84+ykSN2c3F1aq20VDPAE4tNpN6p8RdtWWwpFErSYp41Ktlt0h8+AVaO0Gmqb8oOE=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by SA1PR10MB7739.namprd10.prod.outlook.com (2603:10b6:806:3a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Mon, 7 Sep 2026
 08:50:12 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::28) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:50:10 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:49:21 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:49:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:49:21 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878nGLC193901;
 Mon, 7 Sep 2026 03:49:17 -0500
Message-ID: <623a3f66-c45e-4c7e-a994-163ca8549bbd@ti.com>
Date: Mon, 7 Sep 2026 14:19:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/21] arm: dts: k3-j7200: Remove background firewall
 on DDR
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
 <20260828135730.1565643-21-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-21-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SA1PR10MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 810423ef-8d89-4c5b-7f25-08df0cbd0681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 5jS9zhrOV312d+icOJSZ81+VKc3ooqhJpPb7qI7f1BB/IznknaGemJSYBv+nu+fZJj0IDMqUgLCh8ayJYmZSRjerxKubnLI2tRc9lMi6jfmvMcbKHUbvWdL35o7GptBDLDy7KCIW9HMRGVrWig3hsBKcmeE0Q5g+EQLtwtg8ZJH4Ym5gFptB7gxsIndzGbCr4iQvF/vL8Ij2enhJoJt+gFd3BtWLjAM0TCEuYftMiCTaYIG2yNFH/dctpT5KbamTf7/0EQjnIaElusaVYlAmCY6VYto2uN7J1mB+3K72JQ2l3f8lRhrYHFu6ASsutLJXM7rH9ujPa6OUBO6Q80eOtn2OfR313oAp6h140hA+LpNv4eCLffcZjIp7IUpp/rwdMKycDCVOIjsfu4p1fPKHJv0sPECVi5l+KIuo5cfeK5MQN7oeSyu5Ce81BmJ9vKYEI5Agsrf3uVLhyfibPJOCpQCEqkU6/8HYddLGWGZkr07sbJlzQaLFZCVrPeDyr2IJsiozHiYfGKvOgf7ySFfzCTQU4qN/MukN2++CnZJDrnnbuX97NPb4CTWlUwcW1XjnK3WOdzZ5QQmlAzEAgIF4kjD3IBIjjzS8upaS5VTe8ylooSxB6hOFVmciDPGGUDxzAkoLNRD982zQST0yu3rt3genwfZOtGMTz4nKVrMLAVsySK4gHc2R8miDZ9RAETWHtsnOG4PNeF8nhOGJCXovig==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fft1VzoQNhabUuoqeHHkUX0qhMakDHFKwOdbNipEWqBWdtygViw18QcjvOrNhD0NIAmgEtvX/DyGc9j2/3JTfsUAUTYpTEzeMNGOtUwNNrEtqqiE5Ck6xooNQR/16qHaFj6XCzrdyy6fv/YbMkAvF4HQaVBTzzPx3LB+BDIJr+20pVEptLcb3VAXCBWQDCYp66Sl5Sxk3J4acjRpzU82Hm0Kpxz11KZ44rdf6YiOWxcn9RnGnC2YL55/nbZmmCuPKruUxrT610LdsLRP9KYFDwfHxZehdws0oVfDIrV3Ux6qPTpbWR4CyY8COlqDdN/UjnC3SH5RLjFtImC+GkjfV1in5IceuIAIljEcLLmlDcDGTVQjVuVrJKrcaic2apU6hs+SSWGdtT8oUxgsZ1W2aPahs7EX1YuC9Q3+LP6iuRM4YR2DP0NI9ZT9GIWV752a
X-Exchange-RoutingPolicyChecked: iNmXUO/Tm56Ty0tC0f3tBA5ZsYppSowneVHCiPON/TAsd+acWu2jZrtNuKl3f8d69XIcs3+/Ts7GrCe6yCJb2q2NA/kWXgf1cLaL3wn5NV4j0rLAjkClseaif/gVyc4t16RJQb0tABaoBL4WsEAuQ6D2WHkNVANkeqeEcsGIsBe33eQcZ6la9tEpgpDVb5aPWPZiV+rD0Ukc29fW9SSwK7TuegbbLGBJk9KpjKF2rX0THKfsU8frC3k8aM1AyE9eLJztz3iIpHNjo1SIVgQxeM7k9pQgh/W4OUJUrdsE08ZwaAUh0TmTBj/9WRU06b9VcbRITDCJl8f2Qap75ROJjw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:50:10.6163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810423ef-8d89-4c5b-7f25-08df0cbd0681
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7739
X-Proofpoint-GUID: MEvmeIyHT6-XBF-XWPZWHik2IU_X-0UD
X-Authority-Analysis: v=2.4 cv=Wqkb99fv c=1 sm=1 tr=0 ts=6a9e7ac6 cx=c_pps
 a=uEqrJT4jjddHaitOG1ym6g==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=duV5q9HLl3FjtXDZ2KcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MEvmeIyHT6-XBF-XWPZWHik2IU_X-0UD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NiBTYWx0ZWRfX5TWIkh1qr0Ur
 jhW7vxc7avx8t3ruA++lcVdlhrqNyJ+hfZav+sj2CUwS4JEnADaPCZONVE2XTWtY4xJW/jsWVl1
 V8kd8yJ+efMq/9w34bnVAcVPhgs9eme5zHqoLkipvPh/x7XX6p2Gvt410Lx+gOWJkthg4AwpOc/
 SlYlTb/iAMwf7vQYXWrJwbN61JbWWioSA1tKyRjtZYTeX4yjjNCJeU8Wc2almHhE2Xyv27RSnCl
 qCJstpF7juM5XcahUrptUnLHczLv0yLB2DPYgnvCpMWi7CuBInlteNGRO0ti/IdfgCvOm89/9oL
 u35s36DIWE512ZTGDks7qemph94++R+rO0354GGiRFKB+gHzI+c5XlIwNOEH0Ft4UCsudJgMBSa
 pj7ztUKBM+gHdbJFdpGUNfcpMAkt0NekeG3X9n+bthILocCnSuQsTmeNnNSZnCpOHePxcTPnOro
 r+S86ffWwaSspN2wLeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NiBTYWx0ZWRfX2mhFCiWgWNPc
 sy2UupBdvDiwj12/itESeq4Z6fwjOseGBknOR312e7Xzh7POLbeV5Csmz/FORby07s0RE0Q37Fv
 jUdu4AXi+BBgcqwVTfJorGRPjmE/lAM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070096
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
> From: Prasanth Babu Mantena <p-mantena@ti.com>
> 
> With updated TIFS version tag v11.02.06, the background firewall
> for DDR firewalls are applied by the TIFS. This removes the
> dependency of applying firewalls through binman.
> 
> Remove background firewall on the whole DDR, as this
> background firewall is applied by the TIFS init for j7200
> and j784s4. Modify for j7200 only, as there are no firewalls applied
> for j784s4 from SPL.
> 

Please check for backward compatibility.
If this breaks, then changes should be protected with K3_LPM config option
 > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>  arch/arm/dts/k3-j7200-binman.dtsi | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index b4e0ce8bfcf2..c2b86339d593 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -294,13 +294,6 @@
>  							region = <2>;
>  						};
>  
> -						firewall-4762-0 {
> -							/* nb_slv2__mem0 Background Firewall - 0 */
> -							insert-template = <&firewall_bg_3>;
> -							id = <4762>;
> -							region = <0>;
> -						};
> -
>  						firewall-4762-1 {
>  							/* nb_slv2__mem0 Foreground Firewall */
>  							insert-template = <&firewall_armv8_optee_fg>;
> @@ -308,13 +301,6 @@
>  							region = <1>;
>  						};
>  
> -						firewall-4763-0 {
> -							/* nb_slv3__mem0 Background Firewall - 0 */
> -							insert-template = <&firewall_bg_3>;
> -							id = <4763>;
> -							region = <0>;
> -						};
> -
>  						firewall-4763-1 {
>  							/* nb_slv3__mem0 Foreground Firewall */
>  							insert-template = <&firewall_armv8_optee_fg>;

