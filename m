Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D82CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 398DC408C7;
	Fri,  9 Oct 2026 17:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GnqX53ra7skR; Fri,  9 Oct 2026 17:05:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 873DF408CA
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565542;
	b=LqnCc1iKdb5D7yzp6QiE+aQowlOW+FJ/TNrrxpkPMvYS08V70O4da/5uzg9Bg+s46mI1
	 u7ycqw7M6T4iElTUWegO2bp7oz6Pue5cbyoK0uBfIxsW2f8yaZp+uqhOabmLmskERmZ57
	 iYpcgHRQBh98l1ZcjEd0wMpj9Kydv3adYWHmFZ8PR8Wq0UCcyB60kdA7Kr/vxCCn1aMre
	 PjQYu0bJQ9IEAk1V9Z/8nHRoKHb+2Leve5pjRzLM8Bf6k/VwsDA8j9mThxElI86V9ldam
	 I6RhKBDOLPkDmbgDZbayfJB0VCUY0rPvAI3V3wG3OFvn9j2uDmneDh1eG7rNiC0iLxg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=fdAgqnI61H/CTdQwKCv0K3fki+Vfbg+CPW4OuVPbKNg=;
	b=oomqRTPcDwrwUe0NP4V6Mo1Vgs4qpzYyHvc7iJGzokrl/n9EAWixjf8i4hnhhjVfb8vr
	 HqDFZMTwCkqLv8nlP8fBGzniGkEq/6wtOZ8LitR7c9vc8QjXT4N97dKXJHyzu2/qxD187
	 jEUeYB22jeWIQZ4gGuqakUTGaO+xZ1i4bKAzmbqaR3yauacbX0UuQqry5O+kpKdOFw4/9
	 gWo66YNp4l5+TSlMZaXcs9eaKpHBiT/smH3nbKKhJHrHs4A5AlpTe/ZoBjnPVIU43C0mZ
	 zf7AUcATxt/XBOq6RR7BWMRFe1JFKPfhPYPgU9MV/8t3+SnLrbLyA3lbiqlXdpqwBBQ==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565542;
	bh=fdAgqnI61H/CTdQwKCv0K3fki+Vfbg+CPW4OuVPbKNg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S66fXEy50/W7p9pTnKIXkYBZLxa8byWfZJZFr5YDbB+qP6gnf495yy/kXSJkLIN6j
	 mqH5S2+BJzgkmCUpzr5Q5unVP9YumS6TVG73+3mjEUQWm44ui7hvinS3dsT4Au+U3o
	 5FLMEovJeK3BNMDyoKS381NEjiZu30vvcWdH98EaeeAUhfvOmkgpWSxNPI/qQB70Gn
	 PLkX1TcU6CASFzjgGiYE7lihKPsYesMj4vl4fYDbUZGEa1wAVow99lJOwMSs3WM8bK
	 L08CQZ+WoQipNkv9G40j3JD2OEoymkXUm3Wvlf1D9kM1OyMo3VP3LPhGQCXlmPEdCE
	 JDcylhhTVjvWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 873DF408CA;
	Fri,  9 Oct 2026 17:05:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D490D75
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA80981412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yPGkXNIVxCn6 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:05:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 607FA812EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565540;
 b=Hm2Pq4L4DR69/amBA4BRnmG0OebkreG1G+9qWfnOZNBslQZWWt0a1INz81cePXgvGrEo
 tjghSH+C/r5sZU7dNpWUz5P1HP2B3MIBvTIy39cLKx5xYtadBaT8SVaxwOk+zUUUlt1B2
 oWh+d4xs2gG4fGcyF7bSgIsugdkGXPAzmjHwIXQXDWequjHXEBvEMNDcu7LG5lspv28jy
 Yhd+tcUXyi7/68S7QILzpN+8LVFQ7ihHV23tggj+I3B+S8r7yQ5yt4IYeXoQUOl1dbT0W
 FrA8K8aQdO/WrX9cWM6di6EQIF74KYrrAPVRMMYGMza6iR4KMjVG8IA/lN2QKO6n2vg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565540;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=fdAgqnI61H/CTdQwKCv0K3fki+Vfbg+CPW4OuVPbKNg=;
 b=VMS8gHdvzlrlAyLK9HuvnXTiuQ2sJYGumTEs+SbdVI8QokJ+2KX1013UhZrw8edlqK9X
 r2+BQDC4cJ+SYZ7L5047snMdsf4UYe5aLn9kx/qGglaO5sbVjyFgUdd57CebWlPDvAhsA
 jAmevVWP63qVEUNuNjgc4E8PgXjH+ae+IStmC/ZN0OV6nf4ilKo9gWltjDb1l8d7LR0x1
 8tLQIVzV2X5mnmlkf3Zr6xMO9pHuuSdMfhabHMh6BuhUirJlm/S2vXW9/jT0WsypV27KY
 9FwPkcDH912MNmNhRTWx85LGJC9IJqrhio4gZQ/jbL36/ZLGQIRjIC48tVEg4q6hzwA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=pEmf92AC; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=pEmf92AC; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=pEmf92AC; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=pEmf92AC
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 607FA812EE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:39 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rv/yiy/gVabLo1e7RQmvT89bml/5eS8Iy1I5qQp6VUonpTy6V53thujAdAAC+XK/1kYLdwptTvpVCwQcSM+5rf0u9akNmp+V4gbnrG8tOwOUQ8MO5c3q4FkUgnOVtNY/DCXyEXGm/MxGBcp4qcpvn01rtxciqH6JvpD9qCkn0HG6kEK7Heqhnn3iQsj/We6Da8smdr3mcjjtOyfjJOPPrkhr+um/CoTOB5b/y3a7fvpkjRUOVBBK5LqYttwKkcQDnE31A2ZYiVYhNyg8Qjw9qJvcSDg1UsAALQP1LbP0bqIJXH1B13GPHTMX2tdNyRaP6r+jrsDEM7vbOc18yuDPNg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdAgqnI61H/CTdQwKCv0K3fki+Vfbg+CPW4OuVPbKNg=;
 b=RHTROyCPdOkcEqm6M5DYOyQAPb9dowxQgXxxNIvyyul5jFyTkF4p4lqB6yujl/j7G7SnjeGSq4CVze4oDt4P9b/kDwSFrwgOkYg7LJtD/elucAGe0p9X7qpVmILV/UZ5eQDjcxkdD+BHf9O8w2FbR1Y6P0x23nOH88LjspKnlLh3tfDUw8ID/orxU+033mXqi7jTJJeNAuMaX+MFBj1QOGdY0IWitzGmeQAROa3DbfzCv7mPQ+U3f5V7eSlGAjqRFXMlQFwGzUfY7YsPgVsIzStcTf6DIqOy0lSTy6PxLVtMyI167Hp4jBw6ETIFvc2jq8qWbR32L7lsIK7t/4LRjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdAgqnI61H/CTdQwKCv0K3fki+Vfbg+CPW4OuVPbKNg=;
 b=pEmf92ACu+TeGFrrREuXxhD7e39ulzjeoSmqxrQ8sFCh0HFonkF31f0pmTAFtno2aoVRouI/d3WmX1XCGL/UKtK/NMca6fXcsLTEtbDKFPtAfXefSYm+shttu87YykdRdCyW9/SjIJr4ZqQMH+vwTBohAuz7YycInUXIi1HCsWs=
Received: from ZR0P278CA0129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::8) by
 AMBPR08MB359547.eurprd08.prod.outlook.com (2603:10a6:20b:818::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 17:05:33 +0000
Received: from MI3PEPF00008553.eurprd05.prod.outlook.com
 (2603:10a6:910:40:cafe::a6) by ZR0P278CA0129.outlook.office365.com
 (2603:10a6:910:40::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:05:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008553.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEpLRfGCdGaI1iCChjg1uIZs57s+TGgDg3Wtr4GzlEjYVzRfCCvH3OhqiVS5a/yZPSuqD/d4aavbTzTy7dK/3tXjvRfyzg+G5GNIXUWAXu9/+tNdH7Kmq2WcYt+XfinOgoiUt/QqC9X96iyRxbIMDp9kau4/XxVLtY0TVj3RjIgW3VVXiwX7oOAvxzVvYLHcy4h85aQHwC3kVMC3bvszyyqI4rhWbt83bNStXE0b7ME/ZzTac0nQ/pQd/n6RETObODqmNAWeW5qE8gAKuAk7Mh4cnG50Tw66kaBfyp32db907ZWa82l+v5mQMULLmj6ytXfgcRWPbgaijMOQacsLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdAgqnI61H/CTdQwKCv0K3fki+Vfbg+CPW4OuVPbKNg=;
 b=WTUCxyt48P+VL1z0IjJcePLezJeS6gyfa/UW51xz12aAYuQ4CBzWOLGu+sZvVJoy4csenfrIh/wb5bIyETFI1yeS6bmMk/TWWi04pia+VMGTcSDH2/0oBj1F3mF9d99t3APS0KVr82yBeKeqJHwsJZForZkbFApHf+NJX9KuUo/6G5nBDWKb5/eIdg3Vitttd8chqD5IkR4fphlJ9sbRRrYz/G29OiicyR0vpOP+CFxWZH1SWnO2Y8JwuSSokjfbkcuxIQgHSa9y38NIhoAsGiUAqNC31fSbidebwkpA3bvMM/npz4eATjaRV53D5fz6jvwTSZXMyyV+DN31+GBbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdAgqnI61H/CTdQwKCv0K3fki+Vfbg+CPW4OuVPbKNg=;
 b=pEmf92ACu+TeGFrrREuXxhD7e39ulzjeoSmqxrQ8sFCh0HFonkF31f0pmTAFtno2aoVRouI/d3WmX1XCGL/UKtK/NMca6fXcsLTEtbDKFPtAfXefSYm+shttu87YykdRdCyW9/SjIJr4ZqQMH+vwTBohAuz7YycInUXIi1HCsWs=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM5PR08MB813850.eurprd08.prod.outlook.com
 (2603:10a6:20b:7d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:05:00 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:05:00 +0000
Message-ID: <4758f940-2f7f-447c-bd4d-fcd5197161ea@arm.com>
Date: Fri, 9 Oct 2026 19:04:59 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: phy: prioritize GMII2RGMII bridge over DM-bound PHY
 lookup
To: u-boot@lists.u-boot-project.org, michal.simek@amd.com,
 Pranav Tilak <pranav.vinaytilak@amd.com>
Cc: git@amd.com, akshay.belsare@amd.com, padmarao.begari@amd.com,
 Tom Rini <trini@konsulko.com>, nd <nd@arm.com>
References: <20261001095555.647330-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
In-Reply-To: <20261001095555.647330-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0499.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM5PR08MB813850:EE_|MI3PEPF00008553:EE_|AMBPR08MB359547:EE_
X-MS-Office365-Filtering-Correlation-Id: af47cabb-b380-4b46-44b5-08df26278745
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: zxSTZ79Xj/DxX9ipdXTPBjMPk1YdNOcW7ke2QPmUKUoV0qR6IK7VF20JM9i5akd8rO88WEN2Bt1pvOya14wcTftdWOJzGOTAEM0cCqdGCr/JSxZOFE9kvSqsNVe73+JU3XPjxW+UITzc0nkIJv0EKPTz0Y9+T8F8jpNSRucWsWaKgtUTyVqqNPQQzbYWY5b8Fyfw+mjMYbMSiQ69/0he+Puud2xpWmWGUfGfTF9lDn2l54ie0rjcbyAzqn15/2EC9aKPef7nw9fae2ZauAazlW0YUrFylubbR1tbcZVSmHfzqkLM5rJy6583zQKdM+vfAlClk1mCrEuUrGKWNjF8i/07YHCAKeIYd+ZKgL5oulSi2KeZLHLmaO7HjjcQx1PBmwU/YKWWNz1F1424R/cMnIbss1q+OW/NjwXjJtgzLJH0TES1sYIFf3Y64sxSE1kQwlaQCAef9AHaPGwfnBMUI8A0ZhMNy2h/hmVp1h2kL3Jk3T31Y5vEKYv1RT0lsaYuTmXg9mNYgXS0EJPvXtBCBxw2zo29xgvRAgRR9xcpr02GxT6TWGFQx594F7T9ECepg6hyAlvqveSiV6XNP9IlHtWAnyw0o5A8kek1Ge18e1YOT8XfAAdUvxKkCldK5apTmvGS0b8l6lxBciNraJGfphyNgX2VPJ57WIDN4MZ1Y70=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 44Blu8OeHHOfrZDDeC82uhWa4gEy5ocmJxP/WgcUm21H/mqrwbiL/c1rCxSzqBR/uX0d6BJU5hHixhK3D3AsvZGCh//3DZxSzD9e3wkTdIzHhADeJSIFpq6OzrLG94D5ixIoT1eAYvzkp2KiI3mCD6TMilAGASb45XPldWJbPcZLzIdf0hezQkXkG0Bn7SWxvoMQD9Uqtgl2Ro1gE5Ho0nVJptIsbTG4lCXhpumHhJX5mKX1W0eMTDyQIr8iKUbaBxlSjtF6SSYdFjhsopM97SEHTArAnnVwAOalx1u6rDQT9DSl/6qxd/omjYeTkkZE7M/lYqgqWfreCseiB1pHjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR08MB813850
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008553.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e5257b38-db35-41de-83df-08df26277447
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|36860700016|23010399003|14060799003|1800799024|376014|22082099003|18002099003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3plMTErLJWaUPw0bMQyQ5YtQj2I7ff9BwF6CmK2/YxrIuSKIyv8y4lRYUuHwBOWOCB1Aeq9j94Mem4zz8yaqg++xXBpyAT4g/mH4HvjaULG5MYJTGkmbtHIC8FxVuhS2A63i9Xhzxkmc7ZafmNEviCLBB8j/BrHaJPVCnHasQA9F3nh1PP6SZw9o1q3xUPk1wb31Yj1BPETN2yivbMWMELLNw9mqTMOAU0SN/c5ohk4W/gvNNt86QqForVQM1ci/uKNFlYKUJNIzo1LQCnmZvtg1VC11x4Mv/3zNPV8V5cVZgHRFyaA0VwIRpb0gkf8tx1nM+GNFzh+3ULzMqeEqliwIwUHs4HAQKVo/jhRGW7fRAQBLKWTAorbmWypahPZoqxfuf7w+VgCl5UEXAZsVJiCAC8D64sD0PJhlzW5BbQ5bryy9eCnuhBqLSvfuvhczcs9y6lyQOUpieB1Wot/9WoDHpMXyKDaVjhfBEsVfT3+wiHL8KRVDmOeaxHQSs9XHJVZ8+vy+j8csuBvuedUTB1Hpb8FDQxBtuackLAofU50KGLHa1b0Xc20m2S20xzQ2nBfhnkhZuZMPstTShzMhwvd3y/5xIhRbssrZ9s+flO2/6ssmUGLaRJysEFPfrvgXVOmIVje/97O0XJf3yIlJQv6gx5qyGl01TGb33CmG4ZhM36SWEgoGIZXB9cvbNjFhVY5yBWqsDwm7rSpZncFF+Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(36860700016)(23010399003)(14060799003)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4MepO0PLHlxQy2iFnVxBeaS2lOanV6M0lMGUxYfNzsKFxsR+OBiTjAfCZ8hVmCuE7lCfNoNZTpNVnGi1ZrHEctwPmfexqUSGl/INt4lOAYgy9ScxtTJ9xJDaj8JLJ0ZNeLkMRAO44hetgoRuqyQRPScPlLvm5YzRq3kuSA53nHpD+JMGSt+SM+p7kIXba32A39c3s3KIH33tA4MFmvRD6ILNY6/ruhJp9qtyR6/DwHBgKFZMgjs1qcB71X2BBEzaoctSNUFtZa9aLVwV+C3PmxQQ/Mk9/+dHMrLkPGiaOxcnz8Z6SMcYH+uPg5cxsmNC8sCGfjCrV/pe7evGJY7hmFV+WP9df6lkSqs4baFSwFcFA8l6WOcmayMJIPGXQGjNGn/Hi7VhZztZVn2iNyKt9MkxxpTguRvLTT9cAS/Sd4hpeUihWf2KI//FpJb59qPi
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:05:32.3207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af47cabb-b380-4b46-44b5-08df26278745
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008553.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB359547
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

On Thu, 01 Oct 2026 15:19:44 +0530, Pranav Tilak wrote:
> phy_connect() currently checks for a DM-bound PHY before attempting
> GMII-to-RGMII bridge discovery. On boards using a GMII-to-RGMII bridge,
> the external PHY node is already DM-bound, so phy_connect_dm_bound()
> returns it first and the bridge is never selected. This skips
> xilinxgmiitorgmii_startup(), preventing the GMII-to-RGMII converter
> from being configured for the negotiated link parameters and leaving
> the GEM's MAC-side phydev pointing at the external PHY instead of the
> bridge.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/1] net: phy: prioritize GMII2RGMII bridge over DM-bound PHY lookup
      commit: 3518647f4d4d30e40cc015d670734e61f98e9133

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

