Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AACCA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA15C608BA;
	Fri,  9 Oct 2026 17:05:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAcAPWCf4Zeo; Fri,  9 Oct 2026 17:05:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18CF360680
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565551;
	b=Tk+SX873fElTxLLhhjd7jSfNJZ6ZVkXMeCpLbVVHYwgLC9eav6bLLBnO1bS09LSc51Vu
	 yEE+8yRvLwKZfrVsa1pQnVZEM6JsTswSvwF9l06u1cQ4aSqX9c2o5MLeuDvW97PWlgyRd
	 PeC3XlzhU0ZETGXVudsRwkMWOPsxQ5+t1+vx1BBI5MzZ4/kJSwcs/+o0twbAnv9TnNUUO
	 ClEqs5LKHxCa6qluDsrLme7WavZraSUZWbGPcJnYTuS33gXcn2TDp+Ijzg8BBoYYD74ro
	 w0Yc6fEmb9MZ5tCvqublxJsgvgvX6vbATAgzz+SN7p2XZ5dUa8Hb5/wxYPYYrpXhzVA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565551;
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
	bh=YktZpM6z+Ut2b5CKD7cVH3NR1U6ycJdON82abCLaVUc=;
	b=LJWmpTjMMFTo5WgclSbkt1kHBjcu24uufItTOrjRVM8DfEx5DiQN7eq6/Z7zPxuUKln1
	 kARroc4Uyf+1Us4krpsurb8oIYp7RxaQ+vEAy1mnjCfCSho8VqwaSlA6epgvSFqonai+C
	 Yt6v9Aw8NuT2E/tiuxhQeLB/KTuKS2uNlDAcxkqxNbeRkkDHQM4jKYcOPTl3ku+B9fJB5
	 0M7PRgxEn25+G1ICm5k6mBUFF1GMfPaeUAhYMUHC5DtW5YZWfzZdfhUVEmK7GqPefIlV4
	 pV46RG7Kj+hwnYS7odNEF0Ihbh6ftoz2Mwec8OeORiuJuQERG6FGy3JM4wGU8xvBm8g==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=clDdT9Bm;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=clDdT9Bm;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565551;
	bh=YktZpM6z+Ut2b5CKD7cVH3NR1U6ycJdON82abCLaVUc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P9kIlRddkda4+j12zWus02OiHNLwmL5SCMYA3Aw1Ghk3tWpCNeswdUhKuctarBeyl
	 XGobx/EUm+2AKpi0pTVf+L3YoyHFP/bX3V7q88cCtCIDOdcmEVdSqfkx/3yFP1ipcu
	 8w0wSbx8q9RSdF6T2kYFIqkgFIAUYYNIdgWrUxKgShHyKoYiypmxKn2TK5nGxvbt0Q
	 8gTMyav3bvf7/HZ4z0X0OZ/vW0NuE6a36YHRO/bZa2fZugBBQPZMbQ1r54/Hlnmnvs
	 9dvDb6RQHzBDewtI8oyrQI9LuWHQf4H7D52InBsztw4NrbDJrJ+cXs8sb3EvGpUmjf
	 AfASloM4xJWCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18CF360680;
	Fri,  9 Oct 2026 17:05:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC7794E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4801860680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fv1p8rkDwLVd for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DBBC60663
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565548;
 b=sy34ojfzMLXaFGSU50US82FPQ36RdD6ZOAsdteZ4O9FJ5rA6Vdp00uMcp8Mhr51s/92L
 FOBEuEaW5o0yt7sAUotmKP6EfyW8D4YE03DpMey3MlQPaKGICglmzBJXtZkHKmFjd/JJy
 b+mYffmuQNp0AhrE2Xz1ndns+yJAGSuuMl36D6UH8hbXSpX5+I2FHQsHpMNnsvXmpJQ8b
 k5xkE2Hm7QzDnKB0XHrmYNUDRpLn9DScVrmMvgCzZP7sQd0Lk/A90RuSJnm2HMsPPloOC
 2cRTQSFLhrPSWODKXHis6Lw1FSzBpKvO7yNlLlDJ9L0cJxahIalmkVjjIL4WiwMM82g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565548;
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
 bh=YktZpM6z+Ut2b5CKD7cVH3NR1U6ycJdON82abCLaVUc=;
 b=AuSiAZ0VuWmwpVED+YybNjtScmKQCmo1PxvJ3b7kmRgJCwwL6kz+edatTm7NYtOuXK0X
 HC5UV5XoNtD/+NPnYd/PCnJdKAFz61a7MyG796wsOmwvzzYw4Raa4jRhvvt8qmpAMQHIc
 Q3GpKnaPOWy3eOUa4fU8SchjIy+5Fv6fdmjv9NX1L4HRfDCYiq8v35zQ1qLlBSZwP5AzJ
 m9roiQMVNus88SnYRkFHzAnk9MQfHyahZ/PLD2GCaV5CNzZ3jiY7W7E9hbjXXjZD7gtgU
 rtz8ObpQIFDCE6lj7ZcdyIjf2Pn3neTfN0S1S/p0uCR0S4OhIx561NKi945lRVfM9ww==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=clDdT9Bm; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=clDdT9Bm; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=clDdT9Bm; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=clDdT9Bm
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DBBC60663
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:48 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lHX193u/ZvTCORpsLGJ/RrcaFbxPdELOh7tlBUaL/mwjvhlIaunG0klsbeK1zB1jR58qHPt8JgesM/zE8LjxZV33Fh1gRpjBwzVx275Tt7XK++vy6B2K9cvIzwI0Uwkhz3ZqKI/9BTmFFpDgJsluapCJzbNmw0hUCGVK4+udmXK+IDQeB+XBTgxboo8bhJhkqW1ndUC4GMIh3i2NwlSHI5yS6lJ5e97L+EUtUt6oQr/iafKaXSKJdUHVqVUGWifTIKQTwXeAqofobVT6B257Z4m2UdgkhstwucH4iXFFqc/Z5ogj1Lpe0NBmJbnRi46212QvLRhgHAjoeOGvoeJjfw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YktZpM6z+Ut2b5CKD7cVH3NR1U6ycJdON82abCLaVUc=;
 b=xgzvN6nz0RG+91P2hQtB1Vn08QoExyKloKJvqBU6OUtsL7idNnfeUPRRiB1r0w929CmCLIpr5Ilw0BpSVYb9yYS5HCXZEiryhCOowGfFcnSTSyYz6PJbOG/4qXUQ6/TJAro7xQeifStdHE0G6sK37Wzhkz3AnfJXd1yRmH4NVMN3V9PNL0TZyArqLT6G9J/gUcikRXKza5Bd0mvHbrLEJkKjMSql89HfBb9GsBSlHlx4D0GLhoMiTJNdV1PavPm9ByA29ZKaUUb0ZPg8FSzfUbtsPC3nbeARt2LwJGzoWVbdp/ux1znMNf1VdoCpkch0dhSbT9E0C3kDY0g7oz7s8g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YktZpM6z+Ut2b5CKD7cVH3NR1U6ycJdON82abCLaVUc=;
 b=clDdT9BmQB+C/Mcue9CzP3E3JjMHXpot9KM+Ri/RFYNwRwGVHjeiW8epPzPxaZb7qYZODJembwhFOUz6zsH51SBXgr8KG1FAI6enGJyHAGtuArBPTz6STXgEj1HQ6u7byF/GlaGTVXwsorghqgl4nyzllBaZdSzomJ1DVqEHfp4=
Received: from PA7P264CA0473.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3dc::6)
 by PAWPR08MB9832.eurprd08.prod.outlook.com (2603:10a6:102:2ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 17:05:42 +0000
Received: from MI3PEPF00008483.eurprd02.prod.outlook.com
 (2603:10a6:102:3dc:cafe::ab) by PA7P264CA0473.outlook.office365.com
 (2603:10a6:102:3dc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Fri, 9
 Oct 2026 17:05:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008483.mail.protection.outlook.com (10.167.240.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:05:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhgXLS8xW3fHiJz/PfU7md229XkjZLhm8VJuAOXSGs1JT0VCcOsufWP737nM/Go+4eIrMM6a7sZ9Skoh0jftF1AVBBpcmI641kzIlZjP46dtBsQ2E1itCwQAzFojPlbh6B8/3HpasvlNGtVpTK9nDwaKwhFgznmenlRftVRA+oa7j+fTX4kFCJ6tpLmewZnAZl7ZhA6+dPx6f/Pi2s4dwQ7rRA4S0YloFcamHEcP7gXNsaVX9KIdcryVixLFDMYOxJJn7c8scGizLMYHMHiSqHkWEi2Cjv3XoCr/zvWWNWnQr+gXVIWfTgbaL2x9TJNGUFhif1wrJNGvakn7SAaUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YktZpM6z+Ut2b5CKD7cVH3NR1U6ycJdON82abCLaVUc=;
 b=Z6k3ha8i12KDs3I/Z+8qXeiFN6hbVbOoGAmQD61tgKOUXKYmqDgipZuDWLArwyN3498s+UVQcMbqcgm8ndOeej1LiXbkFfiZycngivrB59tEI6U9vhu8AlrawujTUBOcKblTWutkaq1+l3ixmEqUVa6AN+2z0T6pM83ojKtfGEqdYFceGeqZrVv6Q3OBefNEKxilwk/s5V8gv4wGiGi27KSm50UAQLV6bG/RlTR16UF6xGn/iLrmVSLTm9vZP5MbRpiYzIWjyuOytutWyRSKhl+zzQTZQmXXDjcMlK8sITw9BmQVdNLdPTPDu3jJdcnNOiPsL07HiYRPPiywF1gr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YktZpM6z+Ut2b5CKD7cVH3NR1U6ycJdON82abCLaVUc=;
 b=clDdT9BmQB+C/Mcue9CzP3E3JjMHXpot9KM+Ri/RFYNwRwGVHjeiW8epPzPxaZb7qYZODJembwhFOUz6zsH51SBXgr8KG1FAI6enGJyHAGtuArBPTz6STXgEj1HQ6u7byF/GlaGTVXwsorghqgl4nyzllBaZdSzomJ1DVqEHfp4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM5PR08MB813850.eurprd08.prod.outlook.com
 (2603:10a6:20b:7d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:05:09 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:05:09 +0000
Message-ID: <803ecd32-06e8-40b1-b724-06f84c54790b@arm.com>
Date: Fri, 9 Oct 2026 19:05:08 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2] net: dhcp6 use link local address
To: u-boot@lists.u-boot-project.org, Yuxiao Zhang <yuxiaozhang@google.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
References: <"<CAOOoKeTiVDjEwx2T3w3ij74EOR_15LBNOuFB7ANV5vd2PdgEYg@mail.gmail.com>
 <20260925150928.v2.1.I1473cc3e9adc7793245927386e6fb0278d9ae4af@changeid>
Content-Language: en-US
In-Reply-To: <20260925150928.v2.1.I1473cc3e9adc7793245927386e6fb0278d9ae4af@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM5PR08MB813850:EE_|MI3PEPF00008483:EE_|PAWPR08MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e711a3-4dde-4133-d405-08df26278ca7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: 2bujc434t9+v7EuTTqnSYnH1JKc3WvB67PzK2hh+LDtfINKzFNSx6ol5/hLZ5SGzbU0aJ6LQYmh6dbVOwziVUk+g6RQF8LhLBuGVilWbJS0DE8UlX3D9PQnwCLdNpS4ZLN4k85AbH/eR8bVt57WVySwsRYuaipBffmwc+yM2BFuc4xp5ZoGG5a2i9FvVn0jvZuBFYVqW5PfvjLoPgU0YOvM0y8AakMAM8fmzNe/EeRP/jMvASAKL9x7x2zbPigD7R/nmtxOAMOQESxhd2pUxyAh36rbhnywBjxxnknKSiwCPmRVfUWlcNZdCwJR8uh+b4O/n5i4CAqJpRN2OalcntOm8r78hltwD4gwzQpl6kw+pnt+0XMzXvXWuDiCqecetqkOIhJy/AqGBHBkdj6e+Xd45dK20UL1RkD0z+4VvSDhE/VU7VGG8wuMii5d+yF+kUgU5AaLKKmw6JiRueZw7V6tMZhgDmmsAFDYeWUPD6nF3RSJKT9gK8ftsgxXsCVE92fwukgsY4UuRxA59m4MQtcxLZn/K4P3bJCIDWyFrmPzRhCrYU0DJ9YQXtNdDNnXxdNsWW8ftbYT0Z/wo700pRZIwXoVK86uvK11In8Snn3xeMuq+0YmgNHi3bVEyT/YIDbpBi5jxmMvIfp4V4oFK4eL/Ik44ROmXgB8K/H/SmRM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: RF1g6uWH9zukdijoB+j4fV9Q2u4QQabkwjY4ZmlOGiZIjoKJWJEFQ5ET3WUHPh638D6gDGVovDK1GA+q8QlZyBkgHaRRWmDV8lVIFz0cNdPa7OAyjrqHFu4n5BpBvIrLRBPcvp3XFA3KAQXdoQjZfBOHOucTAVFnBBe1eLGAyCSG9ZwL5bHsaSmasn6dBj1C8NmBDOqLlXdqva05/bmop3mIMz7Si+HB8lOjBQRBMHdO1XmpRiU+5DaY9r4ozh7Rs/VmN4kf7vhzIjFxvqwrg4epysVT5hQlonB9Nkp1oz7XMoYgzj25NHqr8P+eEj+yS6tBss+hbKkvqi7wxZEyWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR08MB813850
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008483.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6ffdd185-13fd-4de8-669c-08df26277974
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|35042699022|23010399003|376014|36860700016|14060799003|22082099003|10067099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: chXMsIdNHRJPMhq9KSP7vzIYLiy30YMlwUoM9HhCtD8tKYKZb+YiWQG2racOG/+0wAcCRBEKUUTSN+WgRwdKccCVHrQumUawBfv1JQj/g2574e1yPjvN9svTBp7GvnWHIGRyYg35Mg4RDuDI4ndEfqOmjrZt0MBAmEy4Wl/Qu/n9q38bHBedF8rapoXCKNQMVM2Sc3MTkIs9qNfsa+pVg8W/OHrFAnXfCbdu8DpavejlbU86zgjeAn5hb3nukV4/nrTdyouEnzQ7TPjF9rufOpOwtdBT1zmvCjpp2owGL6YF2Kg/28rXgQzLhxYR4ngYwG4NKwAT7K4sC64tdX9z4BnoArmF7qN2bjNcjCN+GnlDg5/y6FvzprL5a3ZvMiWuu/GzMdu98QXI/KAnnD9YOZrtbCmnLThWNA9HtoSOaAU+garBuXCnj1fU4icz07zZIezDUx/DkR6Q5P1pQhJgHoHeVwzxkq3BP1Q9cmD5qJ3SN092+/Q2Rt+S7u2BlOojrSYi5vMwhguQSMj74NHp7w+7WTHi+xJ7+dlItR/ve1ARnUExNcg3uD4seahJqjZKVSZa+nhlWPjKIaoH0D/5TVF3Edrvi75QoX8s4MD4m1mKCTh8ik892zqym8kOLSqzWHiefzaQPNfid/jrD9kjg4VkL0YwwQts0V2BPkNl8gwj0xSSaNZ8rle3KITaPnwZduCjTBIDh/TLY0uFHOa7HA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(35042699022)(23010399003)(376014)(36860700016)(14060799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hK2Y3gDZt/J9VLJdzIHdpkdqm9N5qx5NfPTffC0FIgumDDsMHHSRKBfi9oOCp33QySyptK8nwGAe+xI8ANTeuJ8q5aKJKs7ZqnxHN650JgC35AXpI1d2xBHLujS6PNDQzNXg8MgjyyAw+b79rX7I4o+I31RQebJFTFdix9j+0kZKoJy6YYbOAL7y/ktamzdrj8U8c5BAbcIEuFQMjSriMtPaZF1JXb31S3PhwYW9mPlOCcP7eaY+8J+V2kayv1GMq6RwnUwmTjsBT6nYT4Epg2TONF/ey3ZNs+jpp5Ok/A8UDbylkUUgnokD6C81+fEuCCh+Z404f0X3bqZzXNz4Kf4cPR0myCQZpphOKjaIqdrwbOicwe2VhWLNM4rPetp+ioBszUHFDObilzRku1LsTFtj7oA2nDNduGoVKOdlqG2l5S+QkPRfx/nc2sx7BfLn
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:05:41.3645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e711a3-4dde-4133-d405-08df26278ca7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008483.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9832
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

On Fri, 25 Sep 2026 15:09:29 -0700, Yuxiao Zhang wrote:
> DHCPv6 messages are sent to the link-local scope multicast address
> ff02::1:2, but net_send_udp_packet6() always uses net_ip6 as the
> source address. Once net_ip6 holds a global address (e.g. a static
> ip6addr or a previous DHCPv6 lease), DHCPv6 messages go out with a
> global source address.
> 
> Follow RFC 6724 source address selection and use the link-local
> address when the destination is a link-local scope multicast address,
> or when net_ip6 is not set.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/1] net: dhcp6 use link local address
      commit: 4702e50195bdf6b2a7c2ee5074ffa5bb372f7654

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

