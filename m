Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC3606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z9jl+B45;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ItQTBEcs;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=bMpWWLqF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 615CF4077F;
	Wed,  4 Nov 2026 12:57:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TdL4JehEPZeo; Wed,  4 Nov 2026 12:57:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A10CC40732
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793797032;
	b=p+m6Bjqt3uw2wAu47B/pddCiT68ZAbW8Be6mOc+g+4kJwTtm48nE2WxHER6lj51x82KR
	 3j0PYJVE6u5195y2ZjSn/Ogi+s6N05n+2kf+YXVIj2d5RLtaBSMCtho422R7e51V4fT0w
	 YaSi43B6cFKfXanVTomiPYB/GxhBmqxz8+3Z7GfQYMUdFSWK4r5PwW4/ddARZsM3Bmmve
	 9j7kTSFh0QL/IeUmiz3N5Ylr/xfoPU2vQzXkSgessmN+480gelPxZLwSir/d1W6okZExr
	 YpB4+j6QmfbiNDx7pJ2xwIC2jSt7T7YK7b1WbRja4Iek7J4Y7NCf7lMO3N2FWKsEsog==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793797032;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KFHmxFDszgbBq0EBWC70oGgZFovdOooEOL4f8S9DlcY=;
	b=h+xQ6ws8ER75Ow9RLC7O9CRRO1MJBGeGFQ41IPOItYXEImc4550EzewHpYveXK9cTMLy
	 BC7S/2mW2NepTfE0X7tl1AMC4xz1Ftmb7Eka/gD2egjjmFgPd4aCspN9q3hQdHSPdm5PQ
	 34cESgUV3UlQWHiAPkKle5AjoLj3+DkXAHmssnSgRT/FZCSVpciqmHXQ/Ebs3iRPgAf/e
	 iyHwOsLqRTtwFo1LiQve3s4E5MHtlKou/xpRKyOuEvuzIIgTm0lLh3ga4zzcw2LJvMeyC
	 YByYDKg7GND/uOcQ/uO3LNH7wlCfm/BdUmw1cHPkoZMczt4S/4IwEYj+HHEXJaVUP2w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793797032;
	bh=KFHmxFDszgbBq0EBWC70oGgZFovdOooEOL4f8S9DlcY=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9jl+B45GDJcLAc22rz2tcuAX7xivVMQ1Sqvv/xx1Tn8bRq8F1TZUmvx2KBqq8r3u
	 7jXbinTpM9laGCcIpvdM5d41J0Ggm/AGqiUXqqGZR7sPOnLu6XJSppy1vnMSOI7IKZ
	 e8DRhx5kqS7YKKmlWZxd3NLYsrnka+x3LyB9dcQkdHTeVSAgvhtQFkPacDmqQt2CiO
	 JjmfqKo09YIvGW1DFXS3wio6VzNkn5zb0DGfViM+WjhWmEJQkIYCf7jI+dF505iNGb
	 JQDu5uJwqI5C841EIDBMYNrEH1GQrWpVyik/xtr0d5moQQ+ByIOUOIo293sjy2XyaT
	 XxUz03wIAYe5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A10CC40732;
	Wed,  4 Nov 2026 12:57:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CCDC435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E4D840068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ID4oN9BqmJKB for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 128C840063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793797030;
 b=V0GZQINwVZ2C9t4qood82SudmO0RUDKXupGvfiufWUD6Z/ANNxzVo/iYQybIEJnZw/gC
 sWf6gJxOKcSc2fc+33RNIDt49hmseC6vGdKxV/NzdRFgoswmhu3lmwAuKx7dk1TGoA6HG
 MIu5jvwyHKmHk15xhdUE0/DH+lmZM/tW+eOOBqKIodCKfD7H5MKjXhzjOfa60W1FmuVd1
 vaG6jirRqZdpkSftQm5BVAxuakaMOUZWeKk7tZ2f0AHlGoQy3CcvkpHxlSn5crZImNN8l
 LNi0bkyY4qI3fdAp0kNtdDdn+55V1oxTESR7AzWQIXBBdQHHSqb6QSojcmF6RAhdmlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793797030;
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=KFHmxFDszgbBq0EBWC70oGgZFovdOooEOL4f8S9DlcY=;
 b=BXq4L4f0eoxyMDcfUZ3iZjvb+upIbn9D+8vTsvcIA6/PRROLCKO4a9BR1UhAeF1Sw0vq
 d5SXIkO6k5F+DBmn60Lh52TYk4JaQQGRfe6Rs0435hUPtWJYFBlZU8sopG08eMQjNEp4a
 h414JcngDEl/jBnVFWhQb11tZc5t9Tmb95aqxzbv/Kc8cOwxc9Ej84KtiDpnNQzg9iJwq
 buzugtOgjfVVf2lqOvDVV7PSqiFuIjKUuEJ4k+ti8nBJEpAVrqhzhGKVwa0ViDIV4w4HJ
 GD4MXGpAiBvwiOnwqFO+MlfoDLAomoT2H2kX1tgHV9j3ueSauX/OYXk/ewaT7nf/5Vg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ItQTBEcs; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=bMpWWLqF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=n-francis@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ItQTBEcs; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=bMpWWLqF
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 128C840063
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:57:09 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Bc4PW1677562; Wed, 4 Nov 2026 06:57:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=KFHmxFDszgbBq0EBWC70oGgZFovdOooEOL4f8S9Dl
 cY=; b=ItQTBEcsn26OybUW5Cj1qSlmbDkDd/1HZ9Dp+Ht8y2JiowPFA/SwP5ACM
 SR6NlB1XT1IVkmvfQgQoHZXFNu/JzEDiMzF6+N2z2JnPllzX44r0dcxDLAQGgLoI
 XRxrKnCuY5llhTeyofd4rXhJ68Gqm6bqFQpUy7PAmTzCfI1ezsSzmtsaTzDIe/vs
 /EyJ3yT52rsfCcEA+jZZRnOgbb6CcekCDgx1LSMOXFwlj5g/oQhw6F81766Z9eDa
 yOVFS11Z1nzhkZ4zf6KKWtcX72WjAv6xAopLHqxIJDhbDW+z1tt9mMAnrsgLj3kt
 j5kKqVawdo84bQlAbd+FZ8+laghPQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hquyf2yt8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 06:57:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq3PkU+01+h/O/6o8gg+noMTatSycabXP0tCsAeGHpPI03Vrw0BvA2Us2mlKjRLy385QX5oRkg53puJ+g4rXMItW+PNt6H6pQ5HQzCL/fDyIfJ4klITshMxtXQbZmzC/O/f1ZuQqhlH71bUnJjJfEq8yCR98+dockmuG1f+tLv0SdPXHIKr70EVA0nD9sDn0pJJwFR+QozEXvgaqGt6xLNRDrZ0i4WrlkJ5pZCP+4hIolM7Fgjh3NvQkS756rWi3da9j0kJfv7gDSUAm1CRSC3LgWkZKp9TgN1M8ydpLeJHkFFbbQ+IL29sEjo7emhFtOpq/Ijf1w7sdNg3HJzrsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFHmxFDszgbBq0EBWC70oGgZFovdOooEOL4f8S9DlcY=;
 b=TFG/o8j7gMQYP3uEi24lkRFwJWszW1WCP3ryqked/7mQxt++pLG/eFs/7cks2qF/f/+eoWvWwF1z4WqjpWKsJt1YJ17neK7fz3WXaTXLmbxTxhz6ytDsVJsepmrsgDdu8Mut1X/U/a5jE2XLM8gNrNT5J+bJzW4wMNUdES7oQtRSEzR3JCcjgKY8vN9J0eWCHoYw4Uknph5BsHYtlWRY9li8NgFAIRsoq6aiZ5A3GiE5V1SLodA13G/i8T4vL3aZrl/7tNczEEJIa1u+YWkphJ3zR3y5NwHUO793z2R0IuoT4JhDsc7mO4kVzbhZB3+Mu4ZDVTEbyT9kI7pwKiCngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=basepowercompany.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFHmxFDszgbBq0EBWC70oGgZFovdOooEOL4f8S9DlcY=;
 b=bMpWWLqFbK1XxH+Uo4BVSbn6DmsDKreep7w1LT76HXATGu7FUAXhEXYP5hi+rXdAlWV9mo/9k9S4ZuZgmMFE0xbcfk/a4ZU2LZG1LQz+03m736rgcTeIn28QsuOwYjTSD6wtJ00MoYhjOttwr0j63U7wBFCX/8MmkqPcrPGfGRI=
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by PH0PR10MB5705.namprd10.prod.outlook.com (2603:10b6:510:12b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 12:56:57 +0000
Received: from CO1PEPF00018863.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::58) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 12:56:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF00018863.mail.protection.outlook.com (10.167.249.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 12:56:55 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 06:56:26 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 06:56:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 4 Nov 2026 06:56:26 -0600
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A4CuCdq2180519;
 Wed, 4 Nov 2026 06:56:22 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/7] dm: core: Add SPL_DM_EVENT
From: Neha Malcom Francis <n-francis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Daniel Schultz
 <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, Aristo Chen
 <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, Julien Panis
 <jpanis@baylibre.com>, Jacob Parker <jparker@basepowercompany.com>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-3-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
 <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-3-e211cba9f3ea@baylibre.com>
Date: Wed, 4 Nov 2026 18:26:02 +0530
Message-ID: <179379696263.3643704.8108034708731769719.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793796972; l=611;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=taXM372+akBRiL/HmDlra+Doxhq3CEWP41bzI29gILQ=;
 b=hoF5iiOQmA1PUzB5rsAUeTWwV/RprGAJch0kR2U0WaiyvaQAXFDHcQeiezS1FrZHuVapkFwjd
 dOZW4UdXaHDD8k8bMy01RUmPojG+SA+klsE8O0Vr/DJB/GGHyqJhYUe
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018863:EE_|PH0PR10MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec62567-33e8-49fe-3d95-08df3a731aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|23010399003|6133799003|10067099003|22082099003|18002099003|261102123227099003|261026140227099003|56012099006|4143699003|261021121427099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: DNiMN4IrSDta9gtp/kZib8Bd1Px63H6MA//RxbAW6vu8igiOYieQRJTBPZEN9wBLZe7ZHE95p2LvbHZNlKBTYU5ORDAZOPXtAEhVOmdNmNJ70bjUeC4RRTiwbCjkO9hfaYLxd+31+bPJd/Z9+LyJZ7gXcpFmFhw5bjayUZZKWkcqaSRxvfc7qzg2cD+lVONoqPouAoGfYcbKdl45KbQrmBn+REZrm129P74c+nNmYn7ogFYCAIPRp4m/oUk04gPzvzl6VtFB2ZneCTmT4iVejEuqupVdJHW1J7Xw6ceQS740Fd9Xyikux2U9w9fMeuR7Fg8DtP0Fvd885svICbvEcOn/e1Y07zXPwiNN0RgpS3Maxer3ifle+KgRpaCdOJyEJ6vcDg02Qts1Nr5rB5W/TpfUa/26/WJkMC3LoWQ4cOkn0XYtDVoVU9nyLL4mOP0PrmQQsMIrPIz2DneRuYTfZPVwD5J31/mzX7oyCWFVBIiba/AELeOjT+MpWIwZfeYOGiwfQtKBO8DkOAi1evouvoKo2Jy3r/aXq+jKv+oYnS9R01Wtb4TVtZ4lQhyV7vaoYZMN3BrwGS0j3K9IA84MrLJrIp8dIU524e3C0iRvT5ifo8VAtcdRarzYS1xq0u3LLSziYUeU+A+qXwzPmSjYslQtqBmaXPAxjwwEGRXfJZa3TxtTnByEhGbVuEgC9JK9kBtUE2wVTQKbaO2hDXjymg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(261102123227099003)(261026140227099003)(56012099006)(4143699003)(261021121427099003)(261022105027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2TR2bZKlkcZ2w87CJl0uD1uhYt7JewZXUkq0cU0jdrEoiz1MReqmB7O83QB8TtlawWqTAFkWaw6M9T1nA5YBF3CtgAcv2pwbcZp4azqVaeROAJH8UPBijsxYdd1LqEtSQ8rmxRBAXbbVqTABxKIKCmj/wJzq4dqGmCo8v7uGpdrceD2iSnPdiQ+sUETJTZLaEk/gx+a4dD241gXCt7+hRlV8GnOO4PNEYEEd5oIqrtLwr81JCF4UHTO8FkdcZ0UwN14nqH3camhMiHmEK2VxMhs9Wo9ppqvovzuQxpQ8DSHDBRyXFcLkXufIHlUPNia55Tsvi8AW/+POrVeHx8HyzCwG1VhPTypXfj7DGX6fGJvKjx4mNXXm7k3D/bOt9QXVLdDq23kY6yT94fneUuuIPE01eLJNUSSZJ3NlHtGAs/0GB3MXwsa7IP9MQlhe2E+7
X-Exchange-RoutingPolicyChecked: pUYpomLgMeouee+aCMIlheF986HLi9LtM3arsbaGtug41PhxjY+87zfQzAq7pXo0VOW1HJfZ2nRBTmiirNejc+D7rCvttwFg2MDswY2G4Jk5iie+h/tAHmzqqrnGq1vMpx8TOqvmCowe5tLOGINco2PYSEO4oJkh/SXWo+unEAutXM359oCfPYzuvJiWQgYcPAy9Bjezq8B1Rkw5iMqLtCJbyrGVdCND4JrRFhOifeQ5pmTVfzZK0Z1bGaXLFGrNVA804sJUa8i0K0uTxDfhrw72rwTadArerBwq5k08eEUAenHuDfJ3WQGpa2BFMmHzv1gPZpTZKnK4Ur8Nx0EmTA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:56:55.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec62567-33e8-49fe-3d95-08df3a731aad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018863.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5705
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfX5pdM2VdRtO3E
 4RNTlehIHFy6umytfJethovOUJqa60bZa3KjPNAbXh46SN3pJ1Vqm8sJ650yj+BvEdhNcopzPWS
 kSklh+VkaBxBXrZNXkxG6/7MlQh0IVrvvoXjPbnBUe2CP9xcamLohFzUNPhlQhFpV8waPlyB7Fc
 +9DBFFGz3TyXE90NvJRkpRtwFN+RMv5DD0GXh+KH8qVfANmOe4WsjvxrmnTK36Jwtkr8VAnkXvA
 wQKbvgfmLRHjhPPg2wQE6BtGwptNi0oIJVMoaU3iBMLoELB0Ha9zgGZze7ZkAPLOMGmFIg05jKL
 6MTItZjys8OTTtZrscgCBV3paN9rXhwSSTkT8TLHGuWsojETcAjrdXectPa49X205wZVcQYm/Zr
 YPjgiQwE0n6CtgrQf8iVP+m2g6NPfvNs8Fkd6cenOdRKZ8bdiFNhk0gVNGda4Abh0nbuRiXCEac
 eN28ZFGihtoY+6p1iug==
X-Proofpoint-GUID: qFSdHSGbGEaf1xAmhLx2l8HhBwqSZ9-k
X-Proofpoint-ORIG-GUID: qFSdHSGbGEaf1xAmhLx2l8HhBwqSZ9-k
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6aeb2b9c cx=c_pps
 a=wAiiizkMq93U2JYT/wsFEQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8
 a=cHywnxroYYbljiu4dygA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MSBTYWx0ZWRfXxNdUc1gbSNO9
 AAz1LmfRgD/scFAqqENDmmTXl10T/K8nNtUs/nq95H/8DriiDMi/D3XlhuGtNL3ikZyW3KQQFkZ
 eBdOiW5L9KDr0Ze9GEwqvccCNJa1pNc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 11:58:21 +0100, Markus Schneider-Pargmann <msp@baylibre.com> wrote:
> K3 SoCs like am625 need to execute a TIFS wait and register unlock
> before anything is probed and after the tisci messaging is bound. For
> this reason a spy on EVT_DM_POST_INIT_F is needed in SPL. Currently
> CONFIG_IS_ENABLED(DM_EVENT) in SPL always evaluates to false.
> 
> Add an option to allow DM_EVENT in SPL. Enabling this option leads to
> dm_init_and_scan() sending event notifications.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
