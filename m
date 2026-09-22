Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE04CC982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CF2680DF6;
	Tue, 22 Sep 2026 08:46:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bOEP88WiRtCW; Tue, 22 Sep 2026 08:46:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 34D2E80DEE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790066782;
	b=kRnPqEjs1gsS8I3962P1zE4Fb7E1/PYpR6Qrc7txTKLMV1+/ifnsK+IhgfDCjqY0ru6Y
	 8OOEJh/ytGYpvmcO0md81Fy7vh0xmiQ8ty3Rz6D7NO0wQ0zs1Iu9yeB5qBPjAhFwGEA3v
	 C+99iW5at01t2TQV/HYx+xHYAz2GSJgU1hcqzf7g2EfjgkZskXtKPAZv4xTKtL3yDqMRC
	 9d2ExyscDqC0lj2C1e0BZNPA7y6X3FZPtmyRFUD2S1oxf3To/r7lS/tHBcrKAfRkTBs6P
	 ZuWtsG6CceOm2hfAMSqm+uMI1osgoLJBjYKBeWQsaMsg8pUu/efPD/Cl6ZBv6bXsH+Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790066782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u/GtJkT9wx9n4WamyiMSash1gmizcps3zbednATGc5c=;
	b=WaIKkpV/Fqk7XhWn325jaiFiPWKzp5reDVLQXkYEWmmZYkvwaPWWuLSP/NpGriOpQFYw
	 Srt3QczwAFNABjJgqD5jjaSOzi0Jp2jz6It/QPAV9hY8G/4AB6/5IBDe93nucjLHcckv9
	 WheZfimf720kARBd5bo8FCxo7GDNv8vEw+ltv5xfszhUMowWTQhV+Zb9AOVhr5bgw724i
	 i74TmptDxdiNn6beo86ct9uaghEgWqIDySobVwGzDYDKqL0Tg3QqvCoxVNfYvYnQM4Qah
	 LAbre/GGnVE9stv/xNS512MSpfX5uF1AGyL+GBAUZXNHZOegtWXxoEzPzclFfGhaJTw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790066782;
	bh=u/GtJkT9wx9n4WamyiMSash1gmizcps3zbednATGc5c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=06r0hRnOfkBiNL2AJAhLd1M9LKTiugmyYEsM5ZvkWdTy1Un4uJ72T0/1iKXkBM2nF
	 7f0xOFzqNoovJ3Int2P2hMFMZSUii87gkjs0aGWHH1nPOWselzJF/8HdbqXXmCRKo+
	 +vdT4Wp9aSq0Y02rkQGMGE6X6wVRqwkqyCbPnANzqr8iuQrVY2c/c+x3u7jMGfkQSq
	 OMHNvqdW4N27Kp8EcpbGTLNhDCch5wsmJejWVcCjJSSH8avrlIa81lg7b4M2wrGkyT
	 FLAO77pFZkCqOvB3vw1+ie/9vCXz52Hc1yj3Wa/2J4UUvVJSHZErdTYAXPit7Hu1Iv
	 h8Ctt3lXV8xaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34D2E80DEE;
	Tue, 22 Sep 2026 08:46:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A329194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FE1340766
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUNNP4kBWDmP for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:46:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0112E40750
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790066780;
 b=kGvGFeADDsi8Y9vZzopvQUYZvqw5DElwhMFdwlVjpoazPVi2Ll68MDMIOBNadZiFjrzJ
 Cp2weFETsqAbaczEsAgDJHTGadhtrHCzIv3Ol1GMcmv/KrcoRjgX0eW84Q1+pJ8tWArxv
 6kpiYK4PlOPzsK6nICL//V2TPnajghHUDlGjDi3jByMeuB3Y4IIqNEBtjsYZm+EZl3mEk
 srzMaSqz1WiZKDiffjve3hwPZr9heS4e8Pk6j1JKK6JtItdMQDsxla7H8UJoK5FqOpDHY
 aGmMKngjyf0GfzFmAGfyOXqYbylI+0z3UXZrPpNHP01vBXLaaXNP7/j2UCrF79aLUQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790066780;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=u/GtJkT9wx9n4WamyiMSash1gmizcps3zbednATGc5c=;
 b=gCKisKOF1LkvJwGtqLt+ybeqASr/6MOrqh5Mm+DkeLW09I0VAD9E4rJJoDTvJYbHHHDq
 8maKqtwzSU/+fQ+pNuW9eAfT42rqzwwv2dPGd0FJbSYoCATYfdpVAV0hTGgTuvO1goou9
 7kHRSLYAvGOZwlUULVXH5I4Khcg1TQbjUs+OkSZXoDcxmOIEZbuhYoI0dwL2IFNie7ZG/
 9jF0WIVa+9haqkPE4YVaAEZmC+XZwQRQzr7Z5rsU8PnFTORyrXFvMyb8KmEJjKxrQIt12
 su/J8cgkrUYut+LA7lmANovVBaFIwf2CvWFA/ucexyIUB8WjN1vIMwXR1vCg11TQNCw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=j5Fv696H; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="HX1/yrK8"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=j5Fv696H; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=HX1/yrK8
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0112E40750
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:19 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M7htFQ1034837; Tue, 22 Sep 2026 03:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=u/GtJkT9wx9n4WamyiMSash1gmizcps3zbednATGc
 5c=; b=j5Fv696HzozScotAQqTOkHeqMRPYFu8fuMlvMM5rpUoAgRWXp4Z/3RkXM
 779BWbnjU1OFg7mqc4kB11x6bN2VKQ7HH7hUKgQ1BaPKdp5ZLmyOwIy+ULPFwS5x
 +JbEy9m67DFkZ9OvVD+IZNFPZKXiwBfBxTjn5tjcrHTzQpelIw/vI7ZYjvYJAYPB
 /da+vA+I/IbGMbGe6r2APfNINdrABAY+NGfJQcj3uZW3yHZQa7c4nI9t6hTxit3h
 XWNXJAu0fhWEPE61WAmWcHJMxmDuGyjoFt1ukSaQC8ODEyIcw18fBXN6LNmlfyW2
 gVMEXO92iNhiJ27XWuNlph7c1EA9g==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gugxm1rjf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 03:46:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcE3TMyO+0CO5uoto1cZTnqsngDAPu6/V9H/kCl4jc3RTBxI8tSaAw3udtfN1OnCoSuoJYPr1/3EECotznN+kaTI7d0BENYIS0ZVgJTm+Eo8mwiieLACsNGQcQ69ADnldzI1aD6crgUySUk5sbwLQSzBGLkh9DWQUjQmkpVCf2n9H7rxUvW4jvS02mmlLKbwPLtr7J4Y+G6MytuCcf6/iSTfRV7fJPTJn3IAtJyN+WA42oLkb9g7xWK/083tkb4YBHBvFvDi0shJKp1U8cDihyFoLsm7ZX4Qm9Ps6mBrzY6GGDIKWdEd8MLff5oJ9rYt9ZpQQZcgMlFSK+6/muQPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/GtJkT9wx9n4WamyiMSash1gmizcps3zbednATGc5c=;
 b=qKb2X/kfFuVU30sp/fSA2/DoUNSJ8rr+czJF375PCVjVhlHJmJ05SXWQV6hGxhLhE0EXu4UjxQnB/zZQBSWhyzfm1qiWAPjdsuHujI966mwOsrRdglKO4Onuu4X9m9hrcOEPZvxQ8atw3CAyL8C8k5UIGhEY3Z7lbfdie+NbugrqHsg8kyiFjxoSHl6VIkTQt7F6OzcUoAXDtBd+E0G39EP/whw9MP/xLaPXMX2RJoHBLYky8mMty4AGuLEkOHRUVzSytlVv+xtzvEp1jPjuXeqUhw+ybWQmp5eGVJpykYw4x1z47VypDvVeW5DLwxwT3KNytjPXtDwhzfVEX+FxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/GtJkT9wx9n4WamyiMSash1gmizcps3zbednATGc5c=;
 b=HX1/yrK8CBVVzABwfcJ2zN52GQ9PayQPJCIzezsOm+5y2Z6I7UgO3YZ0tuOU0V411ChUkc2sUudS9hSCTrSZJVCjyw9KsQI0ss8YuYK9qP09SIv05sDuw53scUyKc8RJILIl39N02ehH6j1FhFQvanDpPVoIoo7rdYlvDf9zabs=
Received: from SJ0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:a03:331::11)
 by IA0PR10MB7302.namprd10.prod.outlook.com (2603:10b6:208:407::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 08:46:09 +0000
Received: from BY1PEPF0002695B.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::2d) by SJ0PR03CA0066.outlook.office365.com
 (2603:10b6:a03:331::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 08:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0002695B.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 08:46:07 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:56 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 03:45:55 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 68M8jaFN3813357; Tue, 22 Sep 2026 03:45:52 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v7 4/7] arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM
 core
Date: Tue, 22 Sep 2026 14:15:33 +0530
Message-ID: <20260922084536.2477291-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922084536.2477291-1-b-padhi@ti.com>
References: <20260922084536.2477291-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695B:EE_|IA0PR10MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 9395990d-b90e-4f22-e13f-08df1885f1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|13003099007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ypjLV1kNYYQcmlUhW0RglH6t66Cz5e+DluJfutXFZB/aUCUKAROARBOTHIb1oFKxCCzVVqnbcd8IMsJvdIFh9FGDxLVMRXJDp1kSZv8KsWaJ+4YdwSW1JX+YSMu+rQ0EHrUubSSbD72gmv6mXfyeJur4U1eLhsU3Xs4q/4owtp1Vm/OMrF+G+2EM4k5vg7b3NmjSPmgteLjtXJ/VdOLF8B5yWMIhzlqRMMpFG+Nh72Ukya5rOEodpOjRS5rgh1KrWqaFevEjyopNtULyGhsKbFwoSAU/Dc55+7pqInbeneHZ9G+tIyD6ywrmDzSF1myehrASC8Qi//rRUHQCas0ZYPzlmFl3zA7ZeCS2o96H/wSK2bhNb7B+WS4wb9xgutvWB58kZxRqVOC/yfW7KTITRi8Vbv3Aq/rnAvYBvrZbWqlpGzaSXyNyHSDl5ZzETSWfr2YcR0qAO00/LvsF23WfW0cP44aYINetwNy5JA/XD587f8tzwt74+IDYD1dk1Rjtwf7tMQjL0HsYt/PkvPevgrO0pFLoIRmzxzk1GE/4vbQvIJbG7oX4d5X0INPLWRDnJCmxKHfY9HtsUFoBUKDSjtlv2MyZsO66OO5kgBNxea9lENPpbKgHh+XzD82aJ3H638O3a0V7OCWnp0izCzHvwQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yGZGpGDCkVASW/xb826iLCgEYUfrFLkoCwexOqDwmHyBDnspjwRqcPtKkLw8S+ZEHjpL7M6MHx/bopSq12JV4oWPCJDgxOGjjfFNjcas/p/dR8eCmz8MwTMx9Ky1Q9lYAh/L3qPcRJlUMoHlHVkyYTVv1Ed5rEkQfn9xMaNjcsWG2TIwhHW/eCrw+K7K0j0DJAopf0/fDA8L3CSb9rxI1Vkrc+ApA0PByZedkOmuImngkabgP0NZR/MjxxgnV8XKsQTg0K6tb87IdD4bKDKPGTLUZQOeDFt9biHoUqdXfn/hy0h5xmaf+CsgN8ibKRSL8hDSa1oCKWNv1fTElHf7zZHXQXejZq1mmcVrKexHNXk/Ze9XPWlYvSZciE4x2sNv44w/t22hR4nxccZWeMVFY7yV66WqNwk6Zrvs9Bu7kGbzO6Pvl5ULqVQNTtUnHSD6
X-Exchange-RoutingPolicyChecked: T87RhhxzzvFGIKkmFHQZrPvAiCzh+rnSmEHMBNev5BwzLut67Wy9+cqbzITx0R0gWoMIjWZmkWxdIGUkJbx0TKRycdsgSTwVowcnlGIFKEg5wvI0SgWulB1/3p+Ka/58XQQgkHaWx74g3hFA2PZ0/CHFWRw9LK0E7nwEXRx/3C05jqKW1rLTEIigRJy60X6OVC7y+H+GjtNqWxQ/Lv/pULX6d7+JuqSsyETfAtMoUur7HMaD9Vo2PA08SAAe8QCl/zbeMLG+g2y1Y2aPTNxamQo50nvikfaY1Y8TqIgjWa6eWkkhNTLp5p/yVjq8VDOaPsi/Gc60CLJzzy2zsYhfnw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:46:07.6400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9395990d-b90e-4f22-e13f-08df1885f1e1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7302
X-Proofpoint-ORIG-GUID: kcsX1ti5l5dxcvvX6YvfhnPZZbDcVLFH
X-Proofpoint-GUID: kcsX1ti5l5dxcvvX6YvfhnPZZbDcVLFH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNSBTYWx0ZWRfX7TRMZoi6wmNr
 JgJdGIciDZ9UydNTukbCcJTKObWQbkPQduOymK07izSaR8/WcmmoswrcebtDu0I//z+CY/A+As3
 odB77zPnwo4NYAO7Osooai9itNIpx6zeNhtupcF6M809pyESlrtlMC19vMAmJq3KqHTfH+Z3E8Q
 oPzSBm3qocunmpTNSs9ro+8H9Y+Fep3CPj4dW1ph5ulhZ0qryxlWFef1TNg0/xCI1vslahsI69P
 Z6M6yxAWlrPdMC2pGWnMWIPFjwroSWWjL0p2z4BboAphmOOh6H05RubznJamUqJsLFRcSUHJzEI
 5kAyoUIt1ayZb8zbxBd0Rd5HHZcEdFgGSUkUF6SMR+WOWWMp8IK/WdzMYGKTHUkB3D7w2ySkBDe
 eUiubFXxpam3UplT1U9kFL5BoGp98QTv0cPLJxL9I4TuDo6Mt31qS7x/2YYhfktRS+1GOIHpgUN
 k7rq3jrRazAUQi62i3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNSBTYWx0ZWRfX/cRWo2eI1OyQ
 PYBkDqJgsxQiGHWc0njhYs4PYQuJ71ZE3Vsu/G1O4BaAZmBS1QpDPjX8HIq+6saF9TEW8zU9ND/
 tYkW2s5oTf1dBW8JyNcQHoDl1h45ohc=
X-Authority-Analysis: v=2.4 cv=INeXmQvG c=1 sm=1 tr=0 ts=6ab24059 cx=c_pps
 a=+UayH2mdqs80qU9+PBkj6w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=rkogX2Xzrmj8k-iabVcA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220125
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

The HSM M4F node is disabled by default in the device tree. Enable the
node here as we have to load and boot the core in R5 SPL stage. Assign
the alias of 'remoteproc2' to the hsm node. This assigns the sequence
number '2' to HSM core which can be used during rproc_load() and
rproc_start() calls.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-5-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-6-b-padhi@ti.com/

v5: Changelog:
1. Add a comment calling out the usage of alias indexes in code.
2. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-10-b-padhi@ti.com/

v4: Changelog:
1. Changed node labels from 'hsm_m4fss' to 'hsm' to match with device
   tree definition.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-9-b-padhi@ti.com/

v3: Changelog:
1. New patch. Enable HSM nodes from DT.

 arch/arm/dts/k3-j721s2-r5.dtsi | 10 ++++++++++
 arch/arm/dts/k3-j722s-r5.dtsi  | 10 ++++++++++
 arch/arm/dts/k3-j784s4-r5.dtsi |  9 +++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index 7d4a6dc5301..abe64f2364e 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -8,9 +8,15 @@
 		tick-timer = &mcu_timer0;
 	};
 
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm;
 	};
 
 	a72_0: a72@0 {
@@ -102,3 +108,7 @@
 	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
 			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
 };
+
+&hsm {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
index 06a63fb83ba..9ddb951e078 100644
--- a/arch/arm/dts/k3-j722s-r5.dtsi
+++ b/arch/arm/dts/k3-j722s-r5.dtsi
@@ -4,9 +4,15 @@
  */
 
 / {
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
+		remoteproc2 = &hsm;
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 	};
@@ -82,3 +88,7 @@
 	reg = <0x00 0x0fc40000 0x00 0x100>,
 	      <0x00 0x60000000 0x00 0x08000000>;
 };
+
+&hsm {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index 78444dc4e14..afbb8faca44 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -8,9 +8,15 @@
 		tick-timer = &mcu_timer0;
 	};
 
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm;
 	};
 
 	a72_0: a72@0 {
@@ -113,3 +119,6 @@
 	vdd-supply-2 = <&tps62873a>;
 };
 
+&hsm {
+	status = "okay";
+};
-- 
2.34.1

