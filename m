Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8321AC624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B86AE60C11;
	Fri,  4 Sep 2026 12:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfxGoRe9WqJB; Fri,  4 Sep 2026 12:03:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BAE2B60BCE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788523421;
	b=BAdyCmFXuxhqJhaxF7rqfP6L/GiRgvx7sMUUnFaykOfywxReHvrFnTz6fUJN7N10TzhU
	 hbBX9NR+X6r2V1lQ5oSGwZzdPxS4jpPn+QPy9PXteQ+a5892oMtUIDRpa4Lnec9PFXPT7
	 5Zj7HwfmtVdM42Vg/to8qYZTCeRdiH3uxmV1CBq6eCYKhWb3i993mystu1XbFfGHhi19i
	 hkoiaouh+HrwnZFH1S3ApUyu+UlOqCRowqNJwpEscL07kJcG3D+GFsf8lnlu+UpSEnYyD
	 ZyZLj6t5pCcamsjAAT98NmE/WXwML2Bx9DUwU5bKgM+OdytLRwgMMNrpcdUz8A+2+PA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788523421;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xq9Eis5YvDiXnkQQie3U8FHVSI5+a9qu23o6p66j9HU=;
	b=aLEeSy1iRyhXEYszlsAmPKSYWWJ6g2jkkIX4XwaEZwHUpJcEQl+MGRFJb+wypEWyegOf
	 Mq30JO1zYOTrwBvvYhrVtbxiInbruTxZCWCem6pQeWM58ukkdF7utrBykgPZdOg0tFuyO
	 El23OfR9VwxpskhItlBT3HDrbnQBJzyemBU3pV9AB1re7kad+x2KRGI6KHZ+v34f9hiQf
	 wG1e3TStU30n370r7kTNlM9qkxJnqNUSpgT1nE2TM4OIztSrGsiFEPRvKx1fnyv/QaEIU
	 5izejTpsqgKv2OBkYa9MRNcJdDb3TgM0WMWApUFPQ+h9HCOHKwYMXxu96AlLXMPAFTQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788523421;
	bh=Xq9Eis5YvDiXnkQQie3U8FHVSI5+a9qu23o6p66j9HU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YgF87ZVSdk0bj+TurFghPpBIdg7xHSbxoHVH9naDvKHtSQQMIVYeIn2qD8DdgCdgA
	 Cqquh9n3vKEuNuXn6tBkOauskgGdULmp8Wjz1Zz6DBQ8nkZfKblj9XsM6m02uyaAaC
	 ar2+WlP9aNGbxzI2zScRXH/ibS/K8arow64pIbj2Vh6Aw73Ne6TIXUxyhqPdnU2cBW
	 6/TpxDUmhgw57THxYB7OV8XT163NR+k71g6B/EVFHn3/rQxzZeZYR7iIU0XmIBsK9W
	 LjtHwiEMlel1LmbpPWfGPFQydwYNyBYHJfL0NPtpzfMNsu7S7m8mX9rqfXHuvmKuH3
	 4gVM2ZQnZF+KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAE2B60BCE;
	Fri,  4 Sep 2026 12:03:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F0813DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44804810E9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8WWEu2UUdTQS for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 20364810E1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788523419;
 b=YSkE9b0UeBk8l1pB4QroXVJhk0UbYOZYyzEfRkOW5Zf11Jori/fpKq0DdAL4yFhpyLO8
 MZcCEAbIgOiydNW8d1T1k41+WHrpTLx8N4PnXZ7yauc1vENWsqMzyE8BB4b05OuhvEHiH
 FrZ0NpovReaqmCv0WX2FzeuWnwS6ml7dCY6zFq4psB92jSl+tJoJwFy8a56vvD5ug88zp
 XiTXl7usdklf3mncHJM3EhJ4YWKJrBRXP0FoXPujKIN1eWklUCBNAEM/iF/ORS6XnlW0/
 p8bOi4022YQHaTQNhXL/ZTIZ33FJxt+IraUaO8kBx+b+u6GHF481UpiRfc3lv3NYtOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788523419;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Xq9Eis5YvDiXnkQQie3U8FHVSI5+a9qu23o6p66j9HU=;
 b=Yvxgt1eZC+VpC9qbCcT/E8m68x0BLkJ8vg4rJX0aPP6pJ6RQ/3uBwbFhMcwAFg6ZtsXM
 GZVBYMxX5B5pHkAdLa9cYFxJEXsFsl3QLwWt8AhKKDHzIcfPjzyfhHDQXO3HBJnVBGtEO
 xpWOec3ZYERsbh4q9ChAFpnAbplfZvGqz0pUsPt2Y8IizwWjOzMduBRXAMFeAb68MBH3W
 2mEYCeU165E1v0T8j9iqTSVnEPPnGhaLmxyW9gi75KA7A/PTdF8n7hk7Po/6e4LS/xZwa
 m2FDqAkVOCSk/ETnRFFOL+s1JJU0isXZSqA9ST5d+L4kBAE8gU+4td2IUYveqLvjccA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=J7C2NB39; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=UaJzpd0m; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=J7C2NB39; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=UaJzpd0m
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20364810E1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:37 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AHcjk3603256; Fri, 4 Sep 2026 07:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Xq9Eis5YvDiXnkQQie3U8FHVSI5+a9qu23o6p66j9
 HU=; b=J7C2NB39AhL558YPizpIgVTx6RdY0BBK6QOoEOdPhJ3ENP5/GGtl8RqZN
 rKwovzhGKDlxXnY7qQGfYi3YwRCrIofHIrZz0DtE5+CmzdVs1EHAvOOOcyWfb8hO
 G4akzgdPXqdYzTPPehzBeaawwxBTy/Lj2cu6rhR1RCatvqDY4w+MdX1w5GiV7X8A
 KgLCoDTwgqGPLi491X41aXf6ZbsbE/NNddUOyitSdKXcSFCYJOi9PtjH1WOzT7bu
 wTaeNmZLDGTDICcigziMg0IZsULjVqr2NXY6Rrf3N+LPJTzB0LoE2Am1QpGAFPM4
 rySOnjRLblzUMvyrKJA/bzRpXCw9A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq5x1c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 04 Sep 2026 07:03:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6wUqLMTZnFxFIVecHUIGdgQ9XC///uyFuCofNddDzOLwDGzoJi4+kC6wBe/AwiF/mXeB0fk9HSKoiJp7sDXdkBN79ynU7sv4cqwVuh5ZZhUKskOTUcdGDeTpFkrZIctqiVIiSZVkROXcVkVp69cLJwPFWgou15eUDaryBumN8yetvWi7iKV6L4aqqvRVrZk9nOxcPm9KeDfqsrwD6PMKtNH6zG/sD0pDdOhrevj6kFK/QSeLC6kvD6rFEOZcW1SLhFjwqHcjRGoPrjVu8NgXqfjMjc/R2jV8rpTd65vEMVb3Rpbh5yYoR1CR0nVUSI4PusjPTSG9RoXMBgu4aBYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq9Eis5YvDiXnkQQie3U8FHVSI5+a9qu23o6p66j9HU=;
 b=qVXE1LYX7oZ6pRIBYxi0M4+9q5UZP9lpnAJyIbsvxx1FCpRQ1duCNkfwhIPNgDlPiYFHS9mU5HGAYdc155H8Xt8YURcjs4amfTy6u+mMGI270moeB7TH6/u0TKKkRoJYWNCAXVLyK28AwdKJHNWIvQGvlOly0rPuBDjcvRlVv1zfoZUhvnWUX0iwTDXhZ0h5b/XeunE3OxVlPVQY8YkBQw5983Eaio+IMb8mf9gbkqfaljRlwVEYg3VxOeOU9RV1YZOydEBz2kEngVH0TBOunrAX6jOI5WwteiROJVLTOTxAgZoAW+bqllDDn/XnBlHGFQrpMaguXUvdKCVmpsGU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq9Eis5YvDiXnkQQie3U8FHVSI5+a9qu23o6p66j9HU=;
 b=UaJzpd0mtnY/lGv/Cd3MYBnE3vFDXfvNFOOvdMAfN74pFdh4/01yuiUePCyQlgRvGfQefvCj98MgPi9N8G4ww+rOGdKQwPEAFQgA1DTQN6vgNELdpVotrtLVXmFYV/cX/XQWZuJrY8zZ/XQJd3EbSmWVjTeNBPX8FrNUSJzcwoM=
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by DS0PR10MB8055.namprd10.prod.outlook.com (2603:10b6:8:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 12:03:30 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::83) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Fri, 4
 Sep 2026 12:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 12:03:28 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:28 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 07:02:28 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684C2NcG3456269;
 Fri, 4 Sep 2026 07:02:26 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/7] phy: ti: phy-ti-am654: fix logic for programming clock
 parent
Date: Fri, 4 Sep 2026 17:35:50 +0530
Message-ID: <20260904120604.3612484-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904120604.3612484-1-s-vadapalli@ti.com>
References: <20260904120604.3612484-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DS0PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: e5240a53-316a-4638-834a-08df0a7c880d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: TN+uF+ycIuzi6Hxky1UZ1/lEeVowEpsPIqSua+Ma6aMUfsEsT4MVqRO/Pmr0gMwBkK3kUz+mMUr5lzdJvx0mHHvUQFOu1QrBJ5eOvmShEReDeRP/OB63sRr5RdozDr66fTs43B6WRJW+OfoO8rp2IVnWWsbPQvtTsK8hTvBS90ozNABRg9x9yrl1qG3O6DMOlEvBZCP1q5dO55HqinNwaYxFjZ14klGnOLgFhIRQaLVub/mKCkPfm8HF6hbbFxwNTaKXuCxqlYueOuQMryN9oMdJGY54ZFb0tqWNQxEzSWdbbTpH+4QBcQPmb8hnqRYPxnczvEOEjfbF6e6B7JYDkn1pFEbcbpUU1uKWzuIBkhPhHLEALzEFQ9+oiSV4oG6PHNRkSjS8iCgpnF939UwFtR6LTf//oIsKWpAbSvzZPn4Tt/AmBZe/h35XswYeTksMBrfq/X+JEmTxrgPazm9JJdn2JaGRv6Cf52d/rhhGuL9fUfZz5ib5M0ND/kGouPFw7NoJ4ktFRW4CZ6AKju0b8sSsTzme3mTMWbrOa+JAvb3Z8Nr1sg1bRfmMNEufwEN0wFm7qyRYuDLXwfv2QsXj5hSrg5p3Ndcjpih9uc7q1gFk6tCikO6iaAjoa4pgvX/vNW+AYCUlXPi8oRCE6hpros+igJy7Ei4p5Eu3Ezh0d22cyTwc/LLjPt9eTRZpSfwT7w7V/irhvSc9cOVQQHYWZw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hSHR7tlzD8GW/dU1m/L3OXoCP75DX35L0BJ8xL4FK64RfN1YuEvJuTsoHQhJSSPFKAda7YyEw5EPT0rmq2v9W5B2Y2n3tqAL9ww4Bc7scTmQSjWs/DBbh1wrf0pJdVXDThOuQiH6f/opX0GeZ29tkuawRUwLQq+Adde6htq+hiqLd0ARCJFjr5QMhoHrkp7qYoYWk4lXi7tC/DeuTTZfm23CY9akelKfopKx1rNCHiUacK9978rIug3Ggd8RFovlPS/loi5TOHb06mmlRPRPmfVtZyEkH+N4OTDOuMF/3VG0y2feFWaOONHlsr3vIL90Pg3SOdxzP/oKEHZDEn8ws7+gpJTwptTMd0LehYuvJobXevtVmbiBrKMfHw/99CqsPh6BWl2EfQ0KDsaiY5HsNlZPeNOTPZJmvg/DeYKURB0ksFpEtA/7NIi3ovJUUml+
X-Exchange-RoutingPolicyChecked: o9D3qPFS9wu0B2+y5xMKnhWNH3zG+bDMyK5T2QJQWSbyZL0rZvTggPVQuCFv/02kc5U3bDeAInf1ioJLPyhwxLoXbzrTFk5bHuIu5Uj3F4Tf2ht/+8CB+y8sj6ApkTdbVMaVtmhBjsa0nJcbBQTlZhvgGIrcrwWM1dLkv1I0StgsiCxQ//PzyD5jxTkMRg/iA0TnaNsjvKZfuOH1dY+GldtLRLFY6n3uH/ci6VzEGyIMkUq853va3WReIiC1sTTTl9J/U+pj5+yEIp4ucPRtpQEluf7JuZ5XV0TQlUBpCE58O3kyDlNM51BkHzsIsJXO4udIya7Fb69XmGwGHUgmVA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:03:28.3350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5240a53-316a-4638-834a-08df0a7c880d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8055
X-Proofpoint-GUID: dFlwTZU6FqInqHexPpaaRSsrtVwYHSGJ
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9ab397 cx=c_pps
 a=9jlK8eo7xmF8zH0m+f/LEA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=g8noQebMVTy4tJefGO0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfXx18qdQQo928C
 49eKw4kZOYMkE5Ed/s7MdDDfE4JHzp5pzqa+VoG82WoagDTvRPZ1AssFe+UcfeM0NP3jxXuR4wW
 XKKVgRAN7QiBcYR62wEIfzVp6aXtKKKpYn5N4J/Tz40tCZDN8SMhlWOdO3KWaRbE9473RkXv9q7
 O5gGOIyFzSL5tfPUfnh4rhRUZBcX/nIdqSu/RsvnOWkCxizsaJT+ZUeDrYHSK9/NI0YwCMQ9uz8
 tW/Dz/0CfEFo53m2gVAZ3ECSO5GLFnxH0TkD8yZEh8MPJASk5OgkT+a3tw4O0rkunCll5BwKU5N
 Gq2ZNx/cMTaN8fThqtRhcXGPSVegyjVEHG77SeRA8jLyE924KbWyy3Kdb7X+Gzv5bVHMrvisf2U
 KmeDcEvNO57mkbjZMUjUT1ps4dafSBBJtrJ4Oy7Cm/QrKAHNPfBBAMtEXBqot+EgCQ9i/qkM31g
 Fi9VRjxPoex7v8Z9Xzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX8AiaVgyPkysC
 lQPfafq38vYN4weT4T5NXUnp5hF7Z5Bws6mfqLzyUbJWP+YCSF3eiItx0RrKO5jHJ3pIa+gRfwV
 fzotjvnJveWuLy/+aYf2T2IRU8opzfk=
X-Proofpoint-ORIG-GUID: dFlwTZU6FqInqHexPpaaRSsrtVwYHSGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040107
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

The current implementation of serdes_am654_mux_clk_set_parent() assumes
that the register for programming the clock parents is exclusive to the
SERDES instance. However, that isn't the case when both instances of the
SERDES on the AM654 SoC are used (for PCIe x2 Lane as an example), which
results in the second SERDES instance's clock parent programming
overwriting that of the first one.

Fix this by using a dynamic mask rather than the existing static mask
namely SERDES_CTL_CLK_SEL_MASK.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/phy-ti-am654.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-ti-am654.c b/drivers/phy/phy-ti-am654.c
index c3d9972397a..23a5d1483b2 100644
--- a/drivers/phy/phy-ti-am654.c
+++ b/drivers/phy/phy-ti-am654.c
@@ -142,8 +142,8 @@ static int mux_table[SERDES_NUM_CLOCKS][3] = {
 static int serdes_am654_mux_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct serdes_am654_mux_clk_data *data = dev_get_priv(clk->dev);
-	u32 val;
-	int i;
+	u32 val, mask = 0;
+	int i, j;
 
 	debug("%s(clk=%s, parent=%s)\n", __func__, clk->dev->name,
 	      parent->dev->name);
@@ -169,10 +169,16 @@ static int serdes_am654_mux_clk_set_parent(struct clk *clk, struct clk *parent)
 	if (i >= data->parents.count)
 		return -EINVAL;
 
+	for (j = 0; j < SERDES_NUM_CLOCKS; j++) {
+		if (mux_table[clk->id][j] != -1)
+			mask |= mux_table[clk->id][j];
+	}
+
+	mask <<= SERDES_CTL_CLK_SEL_SHIFT;
 	val = mux_table[clk->id][i];
 	val <<= SERDES_CTL_CLK_SEL_SHIFT;
 
-	regmap_update_bits(data->regmap, 0, SERDES_CTL_CLK_SEL_MASK, val);
+	regmap_update_bits(data->regmap, 0, mask, val);
 
 	return 0;
 }
-- 
2.51.1

