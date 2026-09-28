Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE0EC9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21F4D40674;
	Mon, 28 Sep 2026 10:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gd-0jpTu4Jde; Mon, 28 Sep 2026 10:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D8F3840587
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790592228;
	b=pj2OpAG9EPpXShVQl5p11GZCzxEnxKy57rZXFmuaRt1J+Scc9+dgLI3O+SrwFTqhWT1T
	 GYW08zUewGRh1xSGWHdTt5EalNwIurVwG6Z3ra7n0bwbqBeEYeNaF3dCRMjefYmzBt4PW
	 gysCd3zJCk4b5B22yPKwsbdmZSYjBOD6o/wzaR2JwYwyjYiMrMMkywxnd04pTl5W1CGfS
	 ia7G7zqPdeZfRGKSLUpN+P37Cipl1MGFHOjr+h8uApAHfc3IWCwOMCdbojWnb863bs3vZ
	 kz8HqF7G8wQJtx3XWPo0adR+6PGfMQmXDQp/PIsQlm/0IwkrKOlxlLFn2Wf/RlOMa3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790592228;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cuUK7iPgimB6yxT+qoq6nB6sNk8mETU1/gjc8lku1AY=;
	b=JaGsk9GOU25ZVfYIfNFR0WqO3zKbP8u76GVpanMdEocwo2auwQs7aPpiEIBcx3PjEsLl
	 pkVSLfUS2c43XqZO1VUQUVZAYC5v/x1B1/9VKRK7S5OLsH6QnAO5Jn0ZMd8AQ1yeQZM3S
	 45PW3ZYtIEZnpVMA2es48WfdKVNl5H36J8krvFj6OdBxCZSePAe4tb0bxpFlxfcLga7Ie
	 imW+d561FPPzr3kyQ+54vaikIw58yq5DvzRbpkC28qZU8jqTqYrsN6/WIqt/+4oV74Khe
	 bfI6mL/BCWPJKgEdOL+TJjt2Gmn51W84QH7nWNs4lh0f7rsCpl5js8KV+7K7foG0jcA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790592228;
	bh=cuUK7iPgimB6yxT+qoq6nB6sNk8mETU1/gjc8lku1AY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMzeulEspNJx2+AwQBHpXEn4z9a+nBcxdUugz/gF8E5zOqiUd+eyeinJFfZXTuEZ5
	 nuzRCOyRTMOOayOO2leqfSsINm5WImRC0+4r1/2BOcvtT8NRqU1HzP+cavt6mokkNQ
	 tEp9Tmkdh1nFIsmwaCSVdT5l7Rkdo6uTKzjzhZbQsnPYZWjZ+HvjGHi/9Nu5CApKgz
	 CUSfYpZcna24A74VdX9n6QYG9KbilOR8k7ICUGTDbVlfDp85aOSXRT3CxcoxUaJ8C7
	 1H9HBFnw1QIQCiqefrs0YUtUrlCEZPyszRbFfTFo6PONuZtF+Xuc43XmlOAp5JLTaD
	 scRtfhdObUAlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8F3840587;
	Mon, 28 Sep 2026 10:43:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9782D2B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88DA680CEB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:43:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BvWtKp6Jrc4 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2FE3180CDA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790592225;
 b=FKB5c15eQ4YtGyvDJjuiUHykspG+gZFoEfOimjvl9YH1D7rvHqTZzbnpyanW/fZphoJ0
 O/wGakAJliwACJlUWRM+SosnwgMqjAVCAVmhv5plgii9cWtKBxzivtrV5RBYmb1VIcat0
 LYj291laH+MJPghR3McIxGnqEwGFzosvEfW8joaLryF7R2KNrIWaJy41rvzb071oT9aqE
 BbgjIbN9/foa8D50ziU3fwo1R6hGfTouoBbhEi71uMY5JZE7m2/uH7UiWVVlvVP3S02cS
 DQyb4QFwiyfSfc3ARnvmYdpMX2zxm+uASz/cQ28E3ZBPIoAasS02+MqQOQQi7UmDcPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790592225;
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
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=cuUK7iPgimB6yxT+qoq6nB6sNk8mETU1/gjc8lku1AY=;
 b=a+0McUjL8QqAIPtMdJzKtBxOMZHmPQS9NDDqO/zNKGo/qtPXuIMbe3PuSRn8m4MKOIDs
 bovfWBeYO+sQyMga1H6ELJtt/ryQU1CxOkcLsqtVgL5p8YYDbMxFdRH3rcL12BTSGujIq
 9LCX1EJOoCMPf8HljoWcLCXfImB6DUPGeWxhQriseB5tx9/djwJLYKnYHmc8st+lciC/b
 FfScaqQNDhwMxu4TvEX6ddoOrAcwLpcMTb9WCl8z8NFp0YZRPHdYTZSAXuFpps3bQDa00
 0PLWr1E98uqwGqutFErovEJV2GFZytqU4qQtNtQ/zJLdfhR/tIhukq9lzwnT0qe/ksw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=O7QE1DF1; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=twFta1va; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=c-vankar@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=O7QE1DF1; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=twFta1va
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FE3180CDA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:43:44 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68S9KV4u1395713;
 Mon, 28 Sep 2026 05:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=cuUK7iPgimB6yxT+qoq6nB6sNk8mETU1/gjc8lku1
 AY=; b=O7QE1DF1SoxxAK3IC4AUH5FWyTenU8cCnuCT2cObDoDPydmG8tDQY9n86
 9cOqKX6gVRnT3Hyg9LAoXN6CDwjDVqA4PaipVynYEx8Qm8hi18GISS8m5vOxkeCs
 fXDklllWk7DTQMs/JHJxxW8QRrjF4T87xmQ454L5Zvob0IK1DOiVMbKaAWxMZkC6
 TGJnxBsEfiGJJe79GbAhaJCee5KRzMZ6MmNUSfSvcx0gj9oDhiB/vcikCLqzJ21t
 weKhzZY36ZkRPwXetXZzm3oitE7Ct9bgxElE+NbyJ1r/Hv21hsBs9a10YwoEbbzY
 oHZh7jr/80uBiF0jjc5oc2l6QSYBg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gxy2nn7yd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 05:43:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXFlpw6pMdalX7I4LrhS6yzNfC0AbgPSSDWGQWe3UwRjdW5KjQz0Yt+KpPuJ1tNH2RDRpWch+ldnG/YKqd5u17/cIEzBg6H5lm48c+h6fdM5j9ne8aND26o3CZhOwH0lYnkYpl9C93oSVXADxI9lLR/KzC6kE0epYIyM4nty17GvCJ5etQZkjCJyYSnFaX89SsAjwXDX0baMbEHllTlHa6/B364JGd1ehpdGU+RbHlzirkZ9vej00KYiTX7kMRra1oUOtIj56ZIMztT9hMxxg4eGlorq1C3DgWno+I3RgJxQju6vv5h1traUvOLzuZgH7Um5L9Dm2ToM7Q1kQPD7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuUK7iPgimB6yxT+qoq6nB6sNk8mETU1/gjc8lku1AY=;
 b=ddLBSdXFh2lj2jFLcZSP6KWcZOQHZzBkY8WTSy5VHRFsE6HH0BeP9eTVsMgUny9yDHkNQNdr3EKpcThvXIZBJ9qdHcn77exlRV8GkrHJvz3sPTeiwsXxnDUX0IRqkoa8TXsYNsiVJgtnoRcx7TQJmi3rutNUQPg6Ite3qwKWVBX43j2uy8+fZ2zfpbJSo+6XUNUUr2lXIsBxa4X1lnby9s0WryqX2TMIrF4n9sIBECWc4W4WyB+laAXeIqtkNknNrQ5jOcLqj0aaBql2OVcICV373bFxrXAsCoWBjvnJNjRrEMNyk8jsshvZ+bR6kKMfBg49qr4u2amf2oFIzytGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuUK7iPgimB6yxT+qoq6nB6sNk8mETU1/gjc8lku1AY=;
 b=twFta1va+KgKyqsA0b6eUuHiGA65QKARC/cu/mqhxyySs4Z5eRPHXftwVZjDJG9+ta9R3B2jr/P848cjN4Bmz2AEN54xYDtih2Ouz3Zkb99oQAm/ePJB9dL/MKIB/uUJRrNQG+qY0LUaLwUkB27id/Ot+727KfJYqAutPiamZ48=
Received: from CH2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:610:4d::36)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 10:43:36 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4d:cafe::79) by CH2PR19CA0026.outlook.office365.com
 (2603:10b6:610:4d::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 10:43:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Mon, 28 Sep 2026 10:43:34 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 05:43:08 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 05:43:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 28 Sep 2026 05:43:08 -0500
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68SAh6BU2971230;
 Mon, 28 Sep 2026 05:43:07 -0500
Message-ID: <8a2e1e6e-28af-420a-8bf0-954d9bb6f9e8@ti.com>
Date: Mon, 28 Sep 2026 16:13:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Enable NET_RANDOM_ETHADDR config options for
To: Vignesh Raghanvendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <danishanwar@ti.com>, <u-boot@lists.u-boot-project.org>
References: <20260925110758.843871-1-c-vankar@ti.com>
 <27a0c3d5-0537-45fe-856a-5f685c2f68d3@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <27a0c3d5-0537-45fe-856a-5f685c2f68d3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: a29553ed-0a57-45e0-8348-08df1d4d5883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|4143699003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: lPMP9pgsWq2rhv/oCKY8albIOH3w0hp53kZbdI75KpgjsogNt32OR5kZOIAoQT0MyC62SQcpFGFwnl+DzqvzQd9C1B9wsyvQSE2HBPf2OTfy7hk2KuqI5H8iCbGnoPC0s81tUOxYlHJW8CBkVoMxMGtPPKapiWA/rBMNlR2RSYwoaAUooyG0aAMxjYZ08P66RRPPaXuGQ2FF7YeY5cHE0XbWamUP5QTtkfZSvbkSy82CDO24v4EZcxOTrqqvGVpNabjDuvFrf0xnyvmvhHm1HG/Y2+MfZZUqvw2UfWXIK+VambFizbk9ilo6QCRFaXTplOjwTZlKDpQH7RWGTovFgtC3ARCgn5fWVWttWF1A8SKc4GHMZsA0JY4YwOmSM19iLmC4yGUysIElONNIagVF6QBSSOkWNgxSVojYkpwGo3OFlcegPwoOyEOBAh+jBPAdy/TzuYsI5VUuar/6ULL70CCaYGvl2da+T5tsOFG36a1VG3U9bbs6XJ7sw4OTeT/KLt8GltZa+ZAivqbwM5sjAXEadqf4IvCeJjT/8vHojn9t9p7+Gm3nRFEppOcpvadcjDXV3ALiSg2ODSQZzo/ouR47cDIxMn64oJGE6QKxP/VpHnSQzlkLRFPUs+YqlLIejCJc+F709GRF82MBuift4wr2Phyj0UhR5r/DpS5/u1B14MaJMH0i0V/4M+dTxNYpH/82+/kDTiLj6M8qEjvyXA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(4143699003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: diMc9E4BzdBTRi7HXP4emAE3Nw+kWo39tZvGDnURDKlvZn5Jn8dS8n9Ro6iybq5BSMdANmk6DkB9bcNOwo9QV+kbEYKrCtm9TH+ZbnwQCYehO4hc0nt2VoN19Fv4QMTeJsu0D4PKW4gPFg6nL9riCn1WxBA4TFX8BMB3ck4a5xIIyX0t0uu9Ead3dQTXOm5W8JUO/h620vzjWrHnIvETKd/1CyDXZYIeu/e/dvsaUlf3RdmJyVEpfqGGapK1iAyts55yTf4Tc5ALs5QrQ5kZ+WFR82y3ztKZF61pCIjXkUgIheY1a+dgFPOGOd3x2BrYQECdJfxsmpiMsPYwaaPr+vwM+wo2c80psgTW5tvbjUHWn23X3C/4MNyX4jGkpydpIbs+DuC99F9lZ0ByTypDSEyrYk/oLc96fC87mrWZLgBKcae1MH0h0HAuUTs9oI+M
X-Exchange-RoutingPolicyChecked: njCbeAXhijvqDU8VhRjjKvhLNVWPj0nVq44P53rV5dl20RmL4EAXn2O+nWpKBtZ+buABmldO3Clu/dBcp0CE5EyEKAyy6U6Th+MAl3TUE6bPc7VtaI1jM9hBYC66uh38SOcS4l1wdyF+Cdp2TZGMv+i4uaTGMS/rwKqdXLmPabsMROrNIt7deE3Rojo1J76kP9s6bHFNX/qT2ZFBVrF6UiJjHrknB859g4G1Z5mMaxlP3u8zTxDYsMJla+ODn0oVn2srXOax4MrgaBZf/MOceLwof/AbEh7iF7iS6bhyB9b/KeaKTqv/m1Xw7r4bx88ggj1PKsCaXakdcZxV4ZIptg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:43:34.3609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29553ed-0a57-45e0-8348-08df1d4d5883
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX/c3BjRfRbhFy
 inrgs/pvnK6bFwniYDahdCnA2j01xkqQqJYMIEPjonAnQuRQvPnDbpy5OV+iVFGEvf2TN6pIThx
 6OcMk5PSUoF14YdfojMf+1SKlRTpw3s=
X-Proofpoint-ORIG-GUID: agES_3zmCy08a8Dou1azbM0kk5wEKEic
X-Authority-Analysis: v=2.4 cv=RLgmjIi+ c=1 sm=1 tr=0 ts=6aba44df cx=c_pps
 a=5NePcLBJi4TpPzNSyn8y/w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=a2VNwKn4IExAyy3i6HMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: agES_3zmCy08a8Dou1azbM0kk5wEKEic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX+xEq6oVzxDoj
 LPrJJ8mUBYD6SJVdN7EH9Ydl0Y4kBZv0xOU8XPavYriY24ivG65u+HWX/lCW2oe8JneiQjGesWt
 PIbAQMGHU6v7oNu1R1Xk4hsn6xpT2ySCucnEML7/bSxG21pAN8dhlDIv+rp804pJ4id66d6SzZT
 +4uSZComfX4xHjQyJEslfaojzihCbigy3ZsK71GfK9rRSJii+Y5/KDnlq8T0qNMpQe4wl0QPKrm
 Q9av0xjfM0USRxFm/+gSL7z1uufFGhTYvG3xFr2ERq0gZyFymbvAzNxwR0cD5BgEbLcLpDz/MV+
 yeu8DMP9RxCNGIW0VwE6BFlmQIdPIvLLmu+cq0+n2bAYbaorDA8Fx6wh0M4Ytmr/+KpLDetmLRL
 Blydb3pYUbKWzfbY3oqJ/Mh5OsBSM7pWjC99J7VVYz8UmTy7heqpiMu14fx0VNe6eLOk3NnliJO
 bauAlHwXJ9Q1/mhyAuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280042
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

Hello Vignesh,

On 25/09/26 21:19, Vignesh Raghanvendra wrote:
> 
> 
> On 25/09/26 4:37 pm, Chintan Vankar wrote:
>> SK-AM64 supports Ethernet boot, to get the MAC address during R5 and A53
>> stage enable NET_RANDOM_ETHADDR config options.
>>
>> This series is based on commit '9e002445cd0d' of origin/next branch of
>> u-boot.
>>
> 
> Why not use the actual address allocated for the device via
> CTRLMMR_MAC_IDx registers? I guess thats what ROM uses for downloading
> the initial bootloader?
> 

The way to configure CTRLMMR MAC in AM64 for later stages is by 
configuring "ti,syscon-efuse" property in CPSW port. We are using CPSW
port 2 for Ethernet boot, and "ti,syscon-efuse" is configured for cpsw
port 1. I believe we can't configure it for two ports simultaneously.

Regards,
Chintan.

>> Chintan Vankar (2):
>>    configs: am64x_evm_r5_defconfig: Enable NET_RANDOM_ETHADDR config
>>      option
>>    configs: am64x_evm_a53_defconfig: Enable NET_RANDOM_ETHADDR config
>>      option
>>
>>   configs/am64x_evm_a53_defconfig | 1 +
>>   configs/am64x_evm_r5_defconfig  | 1 +
>>   2 files changed, 2 insertions(+)
>>
> 

