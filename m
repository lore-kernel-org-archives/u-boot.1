Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A7FCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 741F060680;
	Fri,  9 Oct 2026 17:06:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jwoOYMqg4-Wc; Fri,  9 Oct 2026 17:06:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE04F608B4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565562;
	b=eLppU9EIehK4Sl49h6d2Ok11LES46DGm10Etzmkj3fqqZ88QDUfo91Jsj0LmcHNcbe4+
	 7QJA4r+D0JK2h1ZmQuWqlzex58+CmTKzOJo9PDi8yMR+hQoWNpBApPm437+3hnDg7sqij
	 kFxh+5bV1sI+eP6+6+Q6Zofz3MZmZALhA4oBU+pfdj/QxhuB+L5nwHAq5GcFJNbxMI+82
	 oBMsJtEHZTpM7vN5gv6Zn53PXf/BQDydyBKF7GRVJzOVcxg2vlZfqgLHuHOPAp82wyfRh
	 1cQi8BPNs/xIMTHJSNKBPg0pfxg3u8QXCq2z6CIwCx2lvQvOjmgRgvbCXkH2LXKN7KA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565562;
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
	bh=yMUgbe2G2z2H7EK1vZNPo63yDhPoxMHhN2HHV3+MG5I=;
	b=fFejePe69mIVrjtZ97DuD0tXQdfsn7iS5SZ31K/QqccNQkewiAE8teLoymBSz/D3e18A
	 RhtxV5XFFdrcNEPA5bDDlSUKr29EVSwKFqagZNUZ3ay9pH50Zr6QqS1T1H9HjVcT0LuwS
	 bePAs2l39idaqstWyTkPMPdR6sk8JLLVTYDRqT9a6RpEiegt33n9n4Xitzbaup6X0WBpi
	 5PD3soVutvBEpFL1qmy+w3gNclev3tmvP7Jxnmxpgvbd2MCeE4qbT50O/cwfOUGzfxO8Z
	 KHijBOzUXgMkcA3Vie66/fcUeo3GZnPBc9/8DhmffbkZyuiousO4rbWxvb2UP5e8X1A==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=S1O4u99c;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=S1O4u99c;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565562;
	bh=yMUgbe2G2z2H7EK1vZNPo63yDhPoxMHhN2HHV3+MG5I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQDISoHLds7aZDEaWkHZgkdiPiTvhmfaFloUjbtY7/8IHk1LsctJjg3o9uDQ3wmPo
	 8U/hOfLF6RZuFF3WsI/pakurQ1cAPAb5cj+jh4rJBJuBFUpKylMLMbNE0Ly2CnAvfU
	 u305vsaOTnz6nkH17ep3+s9SBj1Gq+/A7VCaiKcxnM1pfScQUeIIZkC2Dp1m6QL6+D
	 uhEwRrjI+0hyGnV0gUZCHLk+22XK1MafFCLgjOSJACQdBMhtFmSMnYpWeEO/qT0jPX
	 3hJvQUkgKeExniUB2OfMcJy+R6wQpcyIM3UdyN5TMCXA4GbUYzi7WYGh4JBAihNJCL
	 r6fGuE1N0T9Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE04F608B4;
	Fri,  9 Oct 2026 17:06:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A99DB94E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F8CB608B4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXkTZW6MjFvJ for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:06:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC54760680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565561;
 b=ba9h7OMANOykFg21QRGOaHLoo02FsM4/bQ8UUpmv6A49rx/EJntnqGqR9D9ArYx4tmmx
 FHCJxUJtxO9WcVCNDvUPDxdjyXDPYmKVBxjEpk/J7oD6TKa35+fLQo+IE8n5lVc4QWJ3w
 MjPYOfPGqoeYPFkUfk/Kyb+QU8Ib177COfq7ugyLApGHlB0SWa69SzzSsm8KfTgGKnUak
 gLLXpn7SHB6GxObp0N383ulAQJie0vOHF6ExI6Tuyt34L503h6+BQYQ3BpxnZhSUTi/Mr
 kXG7Un5Z8SFaBWEZfamZxexeQ93IemCYEdrNSu35kdLkNJOaUFx86cqSvKXDeoTwQoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565561;
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
 bh=yMUgbe2G2z2H7EK1vZNPo63yDhPoxMHhN2HHV3+MG5I=;
 b=GyWFBXzexOpbu5pd3prQET1y3B7RE2PuHBwqDd72Kh2zhBP34Uevis6+rLK+SE4MN+bK
 LklcFf9zDAMkFjif+S/es/jTycp4yr+hWlh482f2vo6jSHvoGqlsjhwOtPu2H+XjbzR+B
 LQ8Y14D2poeK5vdpEb36Cd8hcdnxj/gBuXK6fnlWRcil6eu7K4HjF53nmMbhJeyEJ/s8d
 DwPRuRdbj2x8a68mgIg7nmxcRbmVuVraxGyhF/5IU/7+9YrVYdn7CJDcX2IOQmyXfPAWE
 wmGI+XVk5ZUtz9od0mIEVPU/PfiBXgtcbpxqw7j0pG8vyP5rhq1K8NhKZdcQbpT6W/w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=S1O4u99c; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=S1O4u99c; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=S1O4u99c; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=S1O4u99c
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC54760680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eGcIdR/xrkwKCsGAQQhA9lqR8EsuOoZ9lbLBn5CedNaGctwZx6+K5BafK9HacP3bxwxgV8jd2NV/kqj9SRpEiDdjTLg3w1s1zeFOAFQf6wXuXQw7IgVdE2cFJ8IqK9VX4Yse39v2lZI5HuR1+quM2RScOXU3Vh8bRe64vt+a0oHmuzRj0yBfID1QsN8FU1y40PFLQwrjHHK/mV4MSgnL8mYEpdo9R+0wbnZXsRIs7wy9/AZ8sYgKTDuefQnKhHkogXgKjqgaQIq4PjSNKZeghzRSjzvopWX8DLsogGici2xGQhbxk+2XTb42quBdnar5ATJydiJRg2ybYw/vWfZrzg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMUgbe2G2z2H7EK1vZNPo63yDhPoxMHhN2HHV3+MG5I=;
 b=r5FrcnrWaLg6rDNMYDdAdSmkFUWuOH1ZLxpPxfZAV+UETwfsPwIlBlW1RuY2mnLqH3V6xtNcHB7yS7IrG66uTM/mNvZy166kJL+b5Grn0HM0sFJ3tkEv8qOX01P2L+GBYGVH5efVaFDi01UiUxi1v8Obb0zxpjDa2yE32Dc2mdjk2KXaYHzrxQ4hw63Tf7EJNf/1fKnx8IrTMr0mqgodGYjn7NDat+DzHNZAHEGwDAhnV6lNcVC/dKrztkVw3fv+eL+oP28Qx7px9HO6sarYnvz7ZgLDuPg1EWeaEGrloTNaFVYYB5svEumifaYr3URE4kWlBDc67ndt67RnrBpXPA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMUgbe2G2z2H7EK1vZNPo63yDhPoxMHhN2HHV3+MG5I=;
 b=S1O4u99cPJ7oPqDAgnOp6H88Bp2LkiA17pTrWqLgzwaXRpAVOYGC2XyVpVTnIkKwORpp2KulKzTpp5TdQ9jUP/vLUu0ZgOj19vOncY8x3JxconLkVqdiy8XUv9MILEic8nG6JqigtP6nbiFcxaNm7Nghgln1WRUjkSxG773RSdM=
Received: from DB8PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:10:120::27)
 by VI0PR08MB10825.eurprd08.prod.outlook.com (2603:10a6:800:201::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 17:05:51 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::73) by DB8PR06CA0053.outlook.office365.com
 (2603:10a6:10:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:05:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cn+QEqNG7CnycfrZup15E6sRCs8z8fbFudzFMYhIKJC85aMDh6i2FLjNnD7HPh/MQMR7oMogG6bcv4QKKv57v34ob4Llz/CFLBRGLKmmev9zJI5l3mqTwk4aTF2umxafwDVZld6eDU7Lus7458Xa1YdGYwSkaLOWl5rdHJs26odE1k3aMAOamurCzW+Xg9eslbPsDGDCnvdJJL0tYrKegiJ/Q8+5fhVnolxnw4nb+JgpIXGZPKT5MoPDdd/VR9iIM5iEnY51qt3/SvhmEPG+XSivB/qGPYnMH06Qtixdtp5ayvPmVjeiGKE9Ml9aijkpzZ+ynuoiPnvuEa3MO9RJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMUgbe2G2z2H7EK1vZNPo63yDhPoxMHhN2HHV3+MG5I=;
 b=EIc0N+PTakcvpxPLbj9QB+bB/fZbg7JinWh04/B5UKNIR2iT1dTfMvpaXjl2UcB+Ao0JT+g+lsb2CAm79tjp/BZDTdnjN+6s2YIIRUTpQTgE1BNq0L/craff17daCFQ68pSVG0lhzqEsk/IpqFUuuJrSRxONJsSbatbqzvA2lMhYENHwbno8UPKxV+U4nt003QiwfwXJq1riy3/7Rw+bCQgxZlEwB03pwAaheyfJSVJG6F706ETgzFm1fNifeCTRScYcZdoPYfycq78qJeQiQ8Vdgd0NiSU3rmugBROUdArvsAB5sXbV23LJMoDZO+q57Pz8jtITkCVLkxE5y/gxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMUgbe2G2z2H7EK1vZNPo63yDhPoxMHhN2HHV3+MG5I=;
 b=S1O4u99cPJ7oPqDAgnOp6H88Bp2LkiA17pTrWqLgzwaXRpAVOYGC2XyVpVTnIkKwORpp2KulKzTpp5TdQ9jUP/vLUu0ZgOj19vOncY8x3JxconLkVqdiy8XUv9MILEic8nG6JqigtP6nbiFcxaNm7Nghgln1WRUjkSxG773RSdM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM5PR08MB813850.eurprd08.prod.outlook.com
 (2603:10a6:20b:7d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:05:18 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:05:18 +0000
Message-ID: <449e2f5c-534a-4247-b943-c08ca398fc90@arm.com>
Date: Fri, 9 Oct 2026 19:05:17 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v1] net: fsl_ls_mdio: add match fsl,fman-memac-mdio
To: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, nd <nd@arm.com>
References: <20260926112915.471021-1-vjardin@free.fr>
Content-Language: en-US
In-Reply-To: <20260926112915.471021-1-vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM5PR08MB813850:EE_|DU2PEPF00028D08:EE_|VI0PR08MB10825:EE_
X-MS-Office365-Filtering-Correlation-Id: 797bbaea-cb69-4a76-5d20-08df2627918a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|56012099006|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info-Original: rf/Dw4x0JRB3irR6kGx8kHAAgV7RlzdsHxU9aFDAILxJKlOHxT/D/NvbVy6CrRuvrYAh+Tgp2zYkSAE4xYwj9iPUh4sMutK+iUd6WARTjo48+p+VmkQ6I7rCDhFkJilBxEkL1ZonshHE09FSidkqs8uC/YCQCC/xhTnBjQr3cWhzNK+SKych/5PTzBL/ufokjD6A2RtbRNeGhk7ReAf4ilnuvkR6+cPzirUhaqIj42fQrq/NaqhqHB8J7RRve4Bc+2ydLYAsH07hj0wfC7xKAgMb4/NhKjkIg0ZAMD4lnwHaroN87ypqhNZnklOQsUIlZmkmm8fmXmwe4Q3T7RyP3Q5JPWqBhgvfrT4HGaE9nCvCsoLoJA/ZGH0OxZXxi8uXX4mK+gqt1ZH4PbutUHB7ngSbvYIZOKBBPsls1iUsse7GYjaS8FX3rKNFmbz/Yv7IzLyfOMXWI9WrRBboxzmh11bARts4EM6fep/HvqkdMGfPAeyG3w7Vc8lndKB7CoucF0pBdHgsufn186wPddYkfI2x0f6ZZIngRfsqqJUmCuU4NuILwwYYzxgT490lnEE8FPe0LBSoyXhVPy18yVw2AZskWbYuCnjOZLTvWcAAkmdXO/KwO4Tap4Wny57rC3QamMt29GYgWpzSbzdUJ+3j437/ryPu+xJl49EN+c96ATmX8Ph1ACS5fPRW4xOymMg3CxaWPboCWwA+lW+tFjvXqP/aA55OiC/8sMZc8FslxAE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006)(41080700001);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fZJ07/ai+aEMytZh+qUPKjEhmaoVe0rnnr1XrwZJuY1uiSv4ZQ3jW3Z0XtVCydEjUkRf+o0dlYJ8FsJxsKZJXnlXdKKHLkqi3I5dz0Vqtk4OeaJ1liGMGvZoJBRlhd4VKdcMyT4h2Mg44tcdtOuh3AodlllBkyyJpQLtxuuRaXOLBlG1p1Ghpf3PRqbQeXoq6RN8tZhGJ2JkP/P07t2T5hTi17IJF+yCv3v+az3534MCJMYn7nCCpGiOqlK6DIdqCu+j6DQu1DuCI7IX5sHQrxQ57K5ykFuD51DUMMFtY/+58ydTGyxZpO/0OHMVn11MsyM1V2FygELGh4ay0WehxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR08MB813850
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4a1d69ad-bf66-4a5b-08c4-08df26277ebd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|1800799024|82310400026|376014|36860700016|35042699022|22082099003|10067099003|18002099003|11063799006|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info: 92m39vGwswntT7VOx625znlYEX9pt1S60kT/egnYK91YlUwR+ysqmyjZ1szdzgxiGXMqscCD0WRQRnBDJbt1L+Q+QvDtvuselVLEbp6rHQv8HDWCLpHUEClzQEs+WDRelbMUdUwEG1aYzYLjqShCBjiU4MGdCG5GNudW2hxyQUkMinHgltCIXlAa7kIKD4Zfu+A6Zy2SycUYchWUA7I9lFNWYb3N3TvkhucfpIYk8mEQZIu6EVmiPGIh9CcKJdDj+4z1KQT4QuzM5Uapo+TXnnKkQPHnikUOhxBySkIJM9SIO1h8uIBgwnh3dY9X7yqw6ETzcpTOhsVej21ljfhFlehmCCEojo4PHHLmXhLFamumXzJKCLR7uloDL2PAnQQrh2behfPzp81SCs6N3z/52fm4k2pgVjUNbZCOFd0P6iygtq6E+CaFFhTvlWAbX/gTinqsUKwSvmxZIPKawD0Wkp3oK8yr+KNVgGrFGHYwn+VDUgbBlerbhbSz7s0tz1lT/SKP0ZtxLZ6hXzIfD8utod71i00yFJVL7+slpNnVJPd/lxZ7HxKAlfucigGcReUp0SKBxtEBkok7pMZ/XzOFcvt88kSHndjPRlEKS+8Z/87wsPhTSSNMT1fxXQ80WFNBXBDCxvmx1HzFmJtOdR5EwGrCOwu1MzqEbFMCyaRSw2Wqf5/pLWZZDHXH2PNy7D3Ww2EjwIZWSMYnacTI6cs+uQOBcC66ZjaCpVbn/vXq1MLiWv9k8Kg9Kg+q2Wz5+saFhilV190h51bxYMXwj0THnA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(1800799024)(82310400026)(376014)(36860700016)(35042699022)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WizKCIYPircHml3/Vz73xIUtiipzGkEfGnv9gLa/NOzL69B0anPLULHXed7D7YcVszznIfltDANlaSQ80wi3hJPYUtl9YF8f97a7itE/GBs+q+nJoRZu7w4sWaECOG35MOb9s2zW4oYgmBzl7t8fL6OMDVDFtHOd05G+6oWQH2WjnKmZhyql3C2zZ3jYvq0PjH/QoD7IgB956nQHlPQP1feGjmKlp3x2y6OlNJpw39iOnHM4rU7JmretaNKYwHbDGtkmmOkwAddwqniS+xthpLLI8E73M+O6FufybO8BoCvFHG5qG3+WiZV3XSnujL0BCQ7iXeJe+imORQVPeeNdMYHTeCkpjDcIgJwHGPMt/Z07sZvff8jc8YJx3EZmzTQKXXLIg/r0FxYsMib5DvNiHV0vH9SQKumKdvqRUkCMPSmWdDHNiy5Be7jaK34Yp9n8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:05:49.6280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797bbaea-cb69-4a76-5d20-08df2627918a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10825
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

On Sat, 26 Sep 2026 13:29:14 +0200, Vincent Jardin wrote:
> Align with Linux to avoid the case when a board is using an
> upstream DTS and then we end up with a "mdio list" that displays:
>   "No MDIO bus found".
> 
> Note: for DPAA1 CPUs, drivers/net/fm/memac_phy.c matches the same.
> 
> While here, terminate the match table: sentinel is missing.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/1] net: fsl_ls_mdio: add match fsl,fman-memac-mdio
      commit: a9defc63cb72cdada011bb7f72e1c0f82ebab6be

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

