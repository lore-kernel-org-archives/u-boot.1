Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A630C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 05:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C024E40557;
	Tue, 15 Sep 2026 05:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bT9FQ7uc8Buw; Tue, 15 Sep 2026 05:42:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B80B40523
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789450922;
	b=Ohcf0H863YUdIS20AdTiPT9kTUG5d/oLxCUHwtkJ4qkTohnct5qD0xzqqqMbfTNRkqce
	 MttGkhXirXpJ0wIhiRyDeydJ4v4nrpHtpsAELaB6QtbBRnkOIH8radBP56IK8glHvER0L
	 dsRSAe0dw42W2Stc1+1wbnezT70X5dkuHmCKIVjRiZ8KA17ZdJxt6UM4iBqX2lV3Xa+TU
	 VXZSuzUnhnjj53F3hqvFu7pwcjc1OSplmEa1JGRBQCLX8eZbZHojPsI7MKQAQiIlDmyYY
	 26WOykspNazLilAWDxRKVYvE/ll6LbWNtX/P8t9uAwZFLCY61uLQJbkycQO2pzvDPkg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789450922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y/9Q9XE7gxtlgQJUSCLgb8iSVbr8NJzOPUEVAqfS/to=;
	b=Uy/wnfekXETkFQU9Q5GAoXGcQPvCBuryseKbYEsEASbM6EZwKYI97OeYXeyANe4MGwpz
	 FCv+i4VJCCHGYv6IrZ0gfjH7Wle9rdwi4M+E5QboJO/yDlL6fPXebxYnGmQCyR3Xk020/
	 YC0LFnGCQZACdoyxJOu3padHucXmUjO7a+8PGuhD0QEF91XzpSkATTV7iFyH16q524EY9
	 FSFb9WbaPxIE+QY76X8prsEWigNo8iggwQqUdgwUrc26ErMOdvUEuZw5tNcxW0ELrExd2
	 fgSokB+3zmNU/HPexYTAg2B9qG3U8nFvHsvpxLZo36rLc4YRThvCJrL9zFeWDtEYcwQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789450922;
	bh=y/9Q9XE7gxtlgQJUSCLgb8iSVbr8NJzOPUEVAqfS/to=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kjdtR6oq0qVNT2s7FLG/bfkhQSCDZSb5v9dQ6nVV6bU7xZbXJzOqnbt3RHDjH20lp
	 M4FP9U224dLoqTuELGUteHemNHPHdZxRhabFK/kWFlbGPl5Cfp1TFoex/geK5JSsaA
	 r3NPli88zZr/aZm+viSM+4xQHpnHvg8rGZWJPWgdFWKToVxZPxQsFYUrg93x8ZilhH
	 iggNUcVWAQ5wbRsuJyzZepArNCMODtMPYC+TSPpNn+Ip6CkFxzxnSqd0IBIc7uqdtY
	 2vX52EGlFzlaZoAvn7AucVCCWdXKMeP35D82FHTnStip1y9hf617p/BSL0PS3kVt3/
	 +IVmgh8wgY3dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B80B40523;
	Tue, 15 Sep 2026 05:42:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13335259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECD9680C46
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JzKs4h3dWGQd for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 05:42:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3095880C3F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789450920;
 b=FtioQyeUE1OlxS8P2JlBJU9Jjr6/Vy7DnzrAu3UfoN3DkYeaxfzoTTR8q9sdujxi9AsK
 zFkQKdmt9a2hwfWQz64ii3XYJhYeuxmwYVnw0WDReU1iCf8vvIJ5VYcBXNZiWuz23SHn+
 HE2I1/CQm+uFbldQ56RkfsJ9nxe8H2D0EQFUNgMOWARMJkX1AsQNOhDMg/uxfVlmA0Txx
 SmLFkrkc6HMyvV28SYcJx6ApyXzHgclDrQ5slvpZ+9tQHmaLKS3VwhwaX23JSCMSvpCU2
 V/rsgp62sZhohAzK/5elzsAHNWAEdPdsM8ETE2Y8uIaP63V8YdIhA9Bmv2FJpXI29Ow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789450920;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=y/9Q9XE7gxtlgQJUSCLgb8iSVbr8NJzOPUEVAqfS/to=;
 b=jkTJfT7G51p1De8RLmxKp9hLKvbYQCPsxiM6bduT76w/dnEfcnfA5ben5Y8dsVpWxTTM
 A8Ai9Nn+MUh37zh4LePu+M4qsRQWcc7WAxJWbZOKgT66nvrcTncwHGDQb65coCizJ4+6J
 Y2PNm+ep+OIdRawXkEqEH/qEl9Z6K6TQb9zrcMY7IImkmF4ebEM53ic5kNaa86EyB0XCP
 WQ6Uk61qB0nlA2aqK3V0V6HbA6LQV8uMW+skQTKHpo3EZLokxjg+jfDKh3Iy/iIkGjwgn
 OVnpR3f+CZ0cHU0tAKMoQQ9eHISPlx2BNe5VzoW48C4vm3A8yYFU5vF6xGm+QXa+c+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=hGMlFIJJ; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=U2rfFbJJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hGMlFIJJ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=U2rfFbJJ
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3095880C3F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:41:58 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F2m4vH3281220; Tue, 15 Sep 2026 00:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=y/9Q9XE7gxtlgQJUSCLgb8iSVbr8NJzOPUEVAqfS/
 to=; b=hGMlFIJJbHKZ7K9dL0ZG6PaIK1/X7XYfy44VFRN5AoyZSKpMVMnbiQ+jc
 DbCK58OPmiCtvsGt2noIcHCFUe6oa99L0YlNVohvj2biMmNO81wAC5bo+9XWsY1U
 fButafbX7kEer+MVDRPhegcsYj83rckSWD1BCzQWE2wopJwBz288hqCuA6o8cHhT
 GT4DD31r+A37ZjcOf13w9WHUhe7yeM9ctw4L6dZkdALJqy2WugSscMOQwTXt+CYr
 T1DPqVmpAvbjASakYX89gtdRE80l8FdKszEDEoQcipdeeSu/sJib7IYcTgj5HLV4
 VOI7C7TcL9NJawupYQDINfxfS2kWg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gpvpj97h7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 00:41:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COlHq/Zu1CCmZcm9etaBjXYUzHSmTsrAdM+uee2zYg5xnib2bFL9Xai38tiYFmNTr5pqrwlpxTEDyR1Xrm/BuVoiYJY7hqZd6XPOc8/v7ezoTbNjJzn+K2jJovl8A725eJ8sFw1qWBGIIWEVOKfS4bnZO6N3rrhFcZ8U0jImLBbNRWXKJ6U/95Jj0s+XwaQUcbnJH4YCIXibz3+cmEzmfZbdNhGq4rO+uj/C/ZfwYI3sWL+QTNvqvnPxgP3TJgCI8Y4kPQLFNO+7XfwX0i0SEnSkozQyXNCFCb2LpqogSwWj44Dev1zGpdEr7jU4QcF4wjutGhd6jFLy0jSw6RYSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/9Q9XE7gxtlgQJUSCLgb8iSVbr8NJzOPUEVAqfS/to=;
 b=nrDY6C+fk6D4n1dAGY8WvX/CXOBh7l83qAzjyCKvpgmNU7L4Gm/mAa4wsDr0SJiCuKEDQe9jjbXqNhmDNIywe1eg7pfHbR5R4fpcTcicyLHawRKne4mhx1GADCaLaIOXzg1NacvDfOW4guMKU1/i2OfaxMI87UYjhM53DlS50KcJ8He49fWdnq8DwKgXDYmH4t5liTndDSTomAmUshbowT06u1V9ru4O6NeUaaHLBLXJ229LKUQhYGH/sa/Zee1XWuFFLq0tkReAlI21cdJQl0vPqZzyZjHroeqEKcJ5VFKleiq7o/wuvrO6BpEybwx00k4Z+G5lQz+6WjaIs6DjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/9Q9XE7gxtlgQJUSCLgb8iSVbr8NJzOPUEVAqfS/to=;
 b=U2rfFbJJy/jFYqZwHv2wtf9/GWZ6woIxAl5nrLxEU9T2ud6ZJwzxvQTUJ7yNyD2AhVPeD3NaM4grai+f8c3pHDRkZv6jB0/YA1okx5liQ1OAPh2zSduV00HuamauSJ1YP7nmXhY/9of5+CB/YSe3ZhFtwGL7GKaOt92Bu2eFRt4=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by DS0PR10MB7049.namprd10.prod.outlook.com (2603:10b6:8:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 05:41:52 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::29) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 15
 Sep 2026 05:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 05:41:49 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 00:41:12 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 00:41:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 00:41:12 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F5fAXL2621147;
 Tue, 15 Sep 2026 00:41:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] doc: board: ti: correct path to tcl scripts
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, "Apurva
 Nandan" <a-nandan@ti.com>, Anshul Dalal <anshuld@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>
In-Reply-To: <20260901-openocd-tcl-fixes-v1-2-bbde8ddfe425@ti.com>
References: <20260901-openocd-tcl-fixes-v1-0-bbde8ddfe425@ti.com>
 <20260901-openocd-tcl-fixes-v1-2-bbde8ddfe425@ti.com>
Date: Tue, 15 Sep 2026 11:11:06 +0530
Message-ID: <178945086697.1987229.4541787805541512042.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789450868; l=1294;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=UYm2hsoDJyjFcJyFtxx/njSSZXleRm4UrNkYJ+9TC9M=;
 b=yGW0MjfRqI4+vGUyqcDpaoYZNNRT1nFM2WND+v94pbg2g2IStXw0UZVgVY5lqbNyfcpXNQwxi
 XfSL320mrrUBAW9Y2OpdbHqlz9PUwK1gpWG9RdEdci18vZkbbqBbA/4
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|DS0PR10MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: c3544188-75cb-48aa-a033-08df12ec09c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: ocV2GO5qwDsrYt6WEvswSXTtoWgyyp/HlO3tlwaHkw3XTCz7HGjrQN64883P+Vhin6BpX1RW3QDwh9Hs08H3ts9XfLTsGQf38/J+eNyKj7/n51EpkqpJF3jU240qeN9454nH8vdtUF/Z5MZKxiPGjqjDx1eqpsEBI9sxJ8vnCmapNDr+WqSxg+5NNF90ojYApBD90f7cfK8enOnS+b2aNAcSaRmOP2osa7ndqI8eSbcK+MJK1flAz8AomgAfAokxYGfctImZ3G+y6Z4hDdybz7Qmf35F4WkVFHaLWbLp7XdV2HF2c1au4XnHxVBgLLI/bMRbxQeWGGH13+DeXAKphPCU5LeUyEP3vBB1hRTgkSYInGZ5s61wH0NzaAVGy7Zte1BOvOwiUC9fqjdLCP16zgVoPFb+oM1oHjMB9fWQ5oQ83kBzKx04dsAaU60QiTYqdcViLYyrPhtjsxR7lpyvmyopFZ/fj7WeOA4ny62XuIPc48SZ/ys3Eg0//l/wGCrn6OVoGhMnTmKbPLhQEjYfZmbWjUvDnKdfsCYobwz1kQZAMSvAs7mh7dRZymUFUXZAJFEhND4nG+MoilAy7Er+PPrPegkpkWhxndHcolREG21sDNMiai8sqodcmnXnQblmjcAkWP9rgyRYHRAdRcL5s3Vm6ETgPnrMWKbXTpfHXXI7kdchhJYrAkQRNfMW6Q5W227qeDVgEX/egPtlsHLang==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3BXieF/Y84GM8NMtRMeVt3g2cro8Bu5zcGj2me5rXIBUE+JVASsb02AdYo3Nh7cNtq81UT7BHI2L5LxtyyNBegvP6DrrMEtwBzMFiMC9mPqM6GgJY2M4ijqFQtgqV42kIirObyNF03SoU2c9sPz865TmK6GCbfn3IeLJk1clbxc3YAvTFkyCsaQl1fJ/Fgoa11oTZO2qUVORNDkZ0bZytJl/yRjP+nhQHhGoa0aa/20bf2oXETRJgcdViEjmbP26u5DU1Qg8qh9ayKBEQpMqhnpr0laAaLglqpT5A0u4bYCJt2IzUvdAfPU0ZL00tmmV2Va3IEo1+c4NVwWCPz8kzsZgeW0YZNxm1jhsorN1HGrDPxlmBkvtqeao9YHXUO6P7eyPFA0uNDl6MQ8BkU8lqFkjN2mOxaXsloUkYh5QNblFD3jBhHWx48Zi7om2r21A
X-Exchange-RoutingPolicyChecked: tKuWg3p5zs2ynGMSpLOxKp0oTf/DngUJHY062VSwt2lw7T0JmCkXZTwNbHN6c4hinSbfjpN+9qjIIJLG8RTwx6B7THRkDXhIJDCf8NHWeKOGH+HDAAMV9/eph45oojqa/aCpiWa5Xj7m3OMrNoQznY9AZmBaB7t8Jh2NbbunBUG7sSZ/99lyBQjj+AmmtRDRG6WEesqcArEHO5q6V3u53b2VgutaiK4FzzrAIsyh6boAXvsVIzxwZCHCMG+FpZuFzhgQPHIP51uVzyHSNcsV+bvzo+PkFagxaXlZOhmT54O7Zy3mckkJm3IVj9TlCdEIBI6XU8S8pauKvPl4/iMTug==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 05:41:49.3787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3544188-75cb-48aa-a033-08df12ec09c0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7049
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX2X1tpt28dgcG
 +j2/Cr4BULuwu50E9srd1IBMv/4O4YXiusps/SKCWODQFMdZqd/hJUVbZSl6mbxVJurB393cIk6
 PELqLufu7t+f+d7fKG0eCi3EoOwFKL4=
X-Authority-Analysis: v=2.4 cv=KvnYSmWN c=1 sm=1 tr=0 ts=6aa8daa4 cx=c_pps
 a=28cfJ68vbCdGklxr1LbY0A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8
 a=NE0PsRYxIkXyhpSH0W0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1S0GHbfqTUxPBiirSPpcJkfPLpIT6DnP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX5iTGLpBKpF+8
 vx2+OrRUrvSOvhuSox2eaFOjblllBEKHgoV+D7SbmmlOY4WOUY/PZJ0ScG1auGwBK1rpQaZiC6V
 YlI58wVUxY4HwyqPubbOGUK5kPg5cDJG3dx8QzrYPbWbKvGRWumWbHJ1h/Typ2reV8JTQ+vsYK/
 mD04SNE6WJKpZBXeUMVGP5RCQxP1uFg8UfmkL5DMRrR71xNx2C9ud0/bUsC+B7zqbr/qcZVBKuP
 BQQclxh5NNDocIRYp0Hfzg8TKWaavHpcVYV1BgS8yviAtr1Ff/jcMEcxrdoquDoxsqg0+25Wllb
 iDX01Xszc7fnZxsWDxyELI1SPNkijJfIRMKMSYhyQyqw+2fwz98VSHVAB6RifWRy66a9rMdGeL7
 OclsRLTFoBp9oeFOnqb5jvURwUATs9N8Tx5u9Vp2kwAvKpuPNAU9L02rK2MUy5xFMmelgvemwKA
 WM1A2GPDbRM2YNZ3LZQ==
X-Proofpoint-GUID: 1S0GHbfqTUxPBiirSPpcJkfPLpIT6DnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150079
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

On Tue, 01 Sep 2026 14:44:19 -0500, Bryan Brattlof <bb@ti.com> wrote:
> diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> index 44dae4afc870..72de78d5f869 100644
> --- a/doc/board/ti/am62px_sk.rst
> +++ b/doc/board/ti/am62px_sk.rst
> @@ -331,13 +331,11 @@ detailed setup information.
>  
>  .. warning::
>  
> -  **OpenOCD support after**: v0.12.0
> +   **OpenOCD support after**: v0.12.0
>  
> -  While support for the entire K3 generation including the am62xxx
> -  extended family was added before v0.12.0, the tcl scripts for the
> -  am62px have been accepted and will be available in the next release of
> -  OpenOCD. It may be necessary to build OpenOCD from source depending on
> -  the version your distribution has packaged.
> +   Until the next stable release of OpenOCD is available in your development
> +   environment's distribution, it might be necessary to build OpenOCD `from the
> +   source <https://github.com/openocd-org/openocd>`_.

I wonder if it might be useful to just refer users to building OpenOCD from
source as default since either we might have outdated paths for the TCL configs
or they might not exist altogether for newer platforms.

Acked-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
