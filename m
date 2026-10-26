Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A462606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wb9dQ0eq;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=oEEnvPtV;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=j8p6fr8t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 558F260648;
	Mon, 26 Oct 2026 07:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGLITXCKECWM; Mon, 26 Oct 2026 07:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 42A9D6063A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792999025;
	b=L3j8Nkgy2FgxV2t+WZSfqPzKdZOt2/zLuncS6u3dLy3g5OEfboCYA/If+qKkY9WulYug
	 qgKoMirK7J9tyrnRDwLInUknYXRqi8l1po/dKa06q8a9HeQYsGPXf27O/xiqqIYJ1AR+9
	 xHtCJzrrgJT7LGZ8k+OSdK2lM7PxF/++UCcHizbuiozqlcRfbzH3XNzzbHPoe720u1jHK
	 AEQFNJnDV4+gHnfSY4BAMQjoK4OCJJE/VEGKZBCwY1fxEKar4R4/9/EeujQGv11YFe+W3
	 aNu6NoCB8CMywv4Epu11fW6KeN5t51yiQJxajqSnHkkTiGpHtePpCFmywOObc7WU68Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792999025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=65Zn0LeusDr8GybPlDv4tNVIakNVYB8JR+SUMmO34e4=;
	b=ooHAXUY2TwgSakkvaYTn7HFI/rU9hdBNpckShhR4t4u3Z1JE6nDeFktVIRa9/cn0WoZN
	 hb8kUlYHWv+SytN/dqyV1HZ+jD1tYId9H+YtjQmqhGJgjmBZ2DLPCov+Eyw/WcUL+F+qw
	 ZVRBhtR05WA+FwX73Uu45MxyEIkOKFcFe0hdsNqHSRUuoUU0KTNtiVy30d1b/I4RaswYn
	 K+v+/nEeVSkwIYhos62+YsnfXXqWqIIvWSRzuPwjZb341UYs1b6yfXmjcjpfYuRuPhxup
	 qLRwhND2LLkn0CU2lz8A6Q5A14vMZGXS1g2jt7wii1/McMw2a7Dw19frIxejNTanvWw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=oEEnvPtV;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=j8p6fr8t;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792999025;
	bh=65Zn0LeusDr8GybPlDv4tNVIakNVYB8JR+SUMmO34e4=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wb9dQ0eqObctQyztFi0vCiKpDtNAwugEq6QPM6+bmhMkyBASBZZzCD+YkR97l0In9
	 Grs3kR1Fgw9fl6yjHGx9nRIXtwTpOdsZ/KFdIM3dpHcpCNNxWsJP7yb4hvwYskJGGE
	 nWaEIC7q8KbkyzFwz2MBV8HpqHz0RvWQH11DBeYk5UdpcFi3iNQST60GwizsBDM3dd
	 HKyhgzvQiNJ+zY08UprARWxpMjRLABnhs03P5U/i69rEy5EnDkLqM0tlHOis23rEH8
	 yjOtehnWyJ0lVHqtZH5SiYp1nqZBRYn+RCCGL8EhyP8eNYteKSh52dmj59h7tkz4jx
	 Be2WWg6Nn2YMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42A9D6063A;
	Mon, 26 Oct 2026 07:17:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 89F5E380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FBDE6063A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsWz1YwWJ590 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F361960623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792999022;
 b=p/kVVNyYcpLT+XgVY/W14llv8e/LbuRoBOAaVUW5z+vV6vU4r5prv1m+Fm//50Y70Myg
 I5PlVO2NwjSp4tWeOwPjv6b+I2oO4ELeCrG5TFoF6VowEN+SdCnau+gAEh1kl8Kuh4ou8
 HRUXO/9XGT6ufSIgYrjY9+PZt0UcQeHfku2blOe1PVOFIw69evCk4MfP+bTQEVy40EQDX
 iOkp9QMwkgylm9qIaskmdKZ8y3/cCKQLt59MV4dWB6wTIf72kYeU2637tY1lt80BIr3h/
 RIdAz0yiYQhXn7wEd78c47slXFR+jWIpGtcYU06veK0yvVG/imKFWuU0knfnyNOg1mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792999022;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:Subject:Date:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=65Zn0LeusDr8GybPlDv4tNVIakNVYB8JR+SUMmO34e4=;
 b=nayyURD7YkfVwmyhOO4zizZko6oaxliD0nioj9ZpfAXjtzPkof7AaUPtdYUbqnrv5ghf
 S2FSyia4tgemEbAl480EQ+r5pOJ55OCw6m4SYyNBD8hpUIvRKDOwtqK9Jxp7Y9UPSWHHI
 WOz9OPUbBsYmmjZY/ZPhwGSb5O/+qjrEqkbgs7mSp8Tyf1cR7Bk4YlWJ9jbafsu350IFM
 cOkpSajvODq7Ua0QSieruwx4lOQF9rp19aVQAl3DvYUVLM7Gqr71mTtJO7FkDs8hwOzpu
 jtHJoQVkVYun4pf+rQClVPoPskMOnohKhGjz0FXVjb7x0T8BvH3vPcEPmcQ2YOcV0ng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=oEEnvPtV; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=j8p6fr8t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-jain1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=oEEnvPtV; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=j8p6fr8t
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F361960623
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:01 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q2N4rn1490490; Mon, 26 Oct 2026 02:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=65Zn0LeusDr8G
 ybPlDv4tNVIakNVYB8JR+SUMmO34e4=; b=oEEnvPtVqDoVnPnN4UIEgJFcipoC1
 wJlQUEaIGIIW7GBZDDIIu4H51wRt+GJHwusKRZMNHq2QDOohQ0s+5ewSYV0duSwc
 WvGvbn9KhLGvwApH7JHNXncldJr3YMn1q0AI/D2pECrS1pfcFQ8Jr1QulYzjfUt+
 i2IM8B/ukOTf+eoq5wOnhh0VljU9o9GKaYoiv5iefAu7CqPxhrBsvGDb8ShdFk6A
 YkMN3LO211buNKQ5EkBYhQSwfng8N1MVbIZKAm//y2zzntuBRD1VTITHW+/h55V4
 leWa/T8vH/NokHzsUcnDkiWGgJTL/ybEJ02vkSeiSoAgqCd14vyyAN/Bg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hhc25mby1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 02:16:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuaBIXVYp6eCuuFq/4Imw6glX2f8YeUseZsxJp7lsQRr5bhQga6Rmy4q6MkbeS7HBKXqF15jh90uNSK8Qkly2nY+GEkpXeHzj40vJQxN1RxOU60wpZAVvEPYhFSFSBr+Dg4hd/twkf85Yae1NnLTJy7ECDIyM7Cz7plC6aGAAYXceCbx2SMWLvq73eTiHvZ95uzHTesb7kXhI1d8lr7hWq//UbedBkB869elVjxTl/x8gtK/sdrh6iUS+0mrzOS3g5m7m3wBxfieDTHwMhdxjxlIMspka6dLOW+hO2ffTyjsdtFEGisVe0P+VAMMuXRgYrFmHkm0icDyJmSgDIpQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65Zn0LeusDr8GybPlDv4tNVIakNVYB8JR+SUMmO34e4=;
 b=Hp/lwUMZHsBm7leqFGIcb+fJryZi9lMvyJJ22moaDpz1MtYEMkznA5hpzAJ0u1YmPgsIeIFvd9yIWV/WGjEZHZt4E7bOKGQcinIeBQW0peH+LvEuctFPaOLNvOItn8xuv5MxZMno5PAgdciq0bBaCEPhOmqfK2n+oML5ABTqMt6tciWcAenYcu8mpNTOGQZCMOgw+dBsX9P/ATNu5Y5ZxIACWQ3couqAJW0CS4geSK7b5j2Uk5tmkGfOlXxIrg32JLvybyjl4C9JS21HhpeDcm8Vj3UEQfcsA/MHgc175BBOj6VbY2g8GUCGRyGhA17/uQt487B/cNmvRNLrAEHPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=nabladev.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65Zn0LeusDr8GybPlDv4tNVIakNVYB8JR+SUMmO34e4=;
 b=j8p6fr8tp+6bosHDX5XEOp8Hx7C1oiYVB0PAdxJP7NIAp+L03h9dCajLWX8Sdsbegk4E094lXcy1nW1OFEcihcWP4DbZQjyexxzHkIMDrXurK/ILpetwm4RO42rT2hxrsX1asM4K1SMA/cq1SLu1/cBTZrAjltfiXSEpkm7CSvc=
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by PH3PPF1D715CB68.namprd10.prod.outlook.com (2603:10b6:518:1::78d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 07:16:56 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::6e) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 26
 Oct 2026 07:16:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 07:16:56 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 02:16:44 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 02:16:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 26 Oct 2026 02:16:44 -0500
Received: from [127.0.1.1] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69Q7GgTQ3511942;
 Mon, 26 Oct 2026 02:16:42 -0500
From: Swamil Jain <s-jain1@ti.com>
Subject: [PATCH RFC 0/2] Add i2c ignore NAK support
Date: Mon, 26 Oct 2026 12:46:33 +0530
Message-ID: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFH+3moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINYtSkuOzzRKjs9LzI4vLi0oKEotLtZNsbRMTjZOTjROTTZWAmoFiqZ
 lVoCNjVYKcnNWioUIFpcmZaUml4AMVKqtBQAuNq2OfQAAAA==
X-Change-ID: 20261026-rfc_i2c_nak_suppress-d99cc3ca3ec3
To: <u-boot@lists.u-boot-project.org>
CC: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, "Swamil
 Jain" <s-jain1@ti.com>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=s-jain1@ti.com;
 h=from:subject:message-id; bh=LNERVm7B0YO8Hw92ol2lgb9tgEa4gZtIAVR8K+I3n8E=;
 b=owEB7QES/pANAwAKAXQhhQx4u/uZAcsmYgBq3v5YzSyyhVFhEKKP0XbLIbSy7q2vKUUN+jc7j
 nCt/iMO6TOJAbMEAAEKAB0WIQSX3grxmEgbaU60Blx0IYUMeLv7mQUCat7+WAAKCRB0IYUMeLv7
 me+OC/476Jub6LiSCJwZr2yBrvUGG9lx19o/UPYI9rszEtSyZQSqBpHOKPnr1rhGnoO3AzbI65j
 X+RsH2MDjA0L7fzelyBgIhfReBvV3R41RwxoNVHnbhzQ6/8wi1SBWoAMr7T520nThD+KMxEiD6a
 4eKYfc7KXQ6XqjtTc80gNytO6GcC0r17CVsyaa4Ub3Jr7TLQWilT06VfGVD5DvGmkkYPKtfEOgX
 qcOxVbcICpxSbLzNNUNm8lSXTxg8q5w+K/AyKX3hNyGRG/md3NKvEN8ro2/7miMm5SZTwX56ctT
 7vg3+R7PPfkD5VrHPc1QpcySzDx4gxMJvyS096+GvagN69I5Em0Vi2QGtWRmHVYFiIUKa1Mj46f
 dCO+G9GIxAun7jcU958sC/RJQo/ejJvNshSDjy0IEA+nJigLyEUsqQX8kucCE4aJOZOq42QMZBl
 xcwPCQ0K+8qbMuij6aeLE4kp0G5q+Q/j7UAJsF8tYYuoOkwPpQUJYXi6VuEihyPAZyO6U=
X-Developer-Key: i=s-jain1@ti.com; a=openpgp;
 fpr=97DE0AF198481B694EB4065C7421850C78BBFB99
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|PH3PPF1D715CB68:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f2a42b-8cd2-4b63-5eff-08df33311e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|18002099003|13003099007|56012099006|261021123027099003|261009223027099003|261022105027099003|261022113327099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: q50unzzhZLcZBzKZPtFzGZDL/P9d2lPva23HlUSfK9cM41/qUyO0tCkyt34Ok4IB+my0oln+PBBViQnW1Jrle4B3Fh3yZLjaUrAiSwN6p1Po75bYrQgsN7HNUTb8chax8MEvNg0V0KgdrzEJyJadhXn58NAZR+iQyOHxsYCQAiq8hpLzA7rl3Sgne5VSwfpdSxl7mci01qbXvsD4ls986lirKD2wVDlHg83coMbolI+tsZbWQ/CFiND3BACwfHO0JuowAeXGecbTycRdpqG+g1QzmtBZy+HOEMA1dAIpGVcL2/zhs3igqikxwZAZ4QCG09nk1yLYyk265xmtST8BsadmfdrbTXOIxbp+wHjGzUnK1kCjNyw/g4qRD0xDQwev42Z5pWO8xjo5f/QgNWlyckLZ2LcmyUrLBitAneEn4RrP8jyHjkq6kF0IOnnAMyT0Sq1DSNtpLQBH+kNHnqmfQ+bIw6epuJhQlvJMG9AXZl1db/mIpUpGCdJsjmyhJUxo9fIjAVeue0efmtnZ25bwpCzajDikEOFFiH9wCyNWxFFHIsylXa2yMszZogUkxQKn+gZjjEaNoiO0+oTsjQtGG1vLMHhbIa4r2vKFCHTIiZSPR4sjG1gxxEC4d9WVKvyytKAUaffudnjG8N2SKn4ucLzOeYiPmBXchJ45espYC6o=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(18002099003)(13003099007)(56012099006)(261021123027099003)(261009223027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ApJ1q+YrxSgKw10zusqI80brG/RkXhV/xwg4cNK+4Nw2DmAkUJ2H+U2SxufrUfjjzt5rQz4dpjcVmSA5ZHlUGWnamVoTpvpfbLgcTSZigiXb9Ed72osSaVvVhuAXxSAvBSPoeqNeL9NCG/Tz9tBE6GCSmCe0sSukP1HI2dO0zTkdmkIGl4G8Kv9zG41XwZtRIcH5dPdyLCEyVw3Fumr0qW/E9gw0i+nI2joKN26el/POpsdr/U4u+YMzZHOwGQDEHJbBguqdD+JUYiR0fO3JqgndNbGoNWvKx+ieMRN8bKKUsg6Q2VgW6x25hNfFRfgqeY/yuU0gIEmFOONMEhBJFDLlsoCfLkeM+NjhByr+n6jLlUs2DohQlO8IEzLlROemjAcfHCl1M3o1qXTFN9OEWuaNG3XHMZQaVJULMJwtILHKWB6IR8rQMAR+pZuqauRQ
X-Exchange-RoutingPolicyChecked: EuiLoVCcqgKUdbxX898RUxRXPcN166cbljQcAJBu7a7pAa7glVSOFWfFiK95R726vSKGuFZIwm+7qVcsZCQmgHKvpcQkV0mvUxS2+O54eeskb29kWkwolTCo8JepghH/TvIjwU0guyFmVGaC9xWsyQHc4Gn/NHjOrRefsWxz5Sf/AIgbgtpVibi4zeU7SPkHGtdU/+m6sDZ1EidxjxrTkMPIx94nXkkoapPKEAaLoNlDeQE3UzntJVdOcr99Ckmu8gXtW0aw9rQzFit2BywmBZQVRUOnUHR3fndWEjJGKoHipUxilm9ZHcn2YL0SU8cLLnU9QmsVlgjCRec3f566+Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 07:16:56.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f2a42b-8cd2-4b63-5eff-08df33311e32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1D715CB68
X-Proofpoint-ORIG-GUID: iMIZXyETIijhyRrFbDju-FXFOYLPta27
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX4cEqAdb/wKzr
 4/83wZEoFUUpb0jGkI405K5CLiGtyJJIrsT+IHNSOqknzxmgAVE/Yin4EfEi2YlUtg7iLZHVmIP
 kCP4KBblPsONXRORmH4CiWNPkiIUUAoRkZ2OyMIyzl0bFJBvl5aDO3cFG4MtX3WuIalhinZAQyz
 9YUeBXFkNgEGQ1B8w9/txUlz0SWsW1iuFCxJFtnqzxH6PUcYNSz1uGkFhbeL1ge6n2sLw8H9aNG
 Edt1jZsuhmaxtyk/bXTagM9dY0z01+X63Sq0T0Iog9QcFtwGeymbl/q9rliZQ0x2HSjL2oBZ4n/
 5l1LH0PynYzWJiG0gp0K8xqH4QWp/07JDk1fLWplDxYsi54h/7HheUbCO1SBip3b48rJF/JRZvY
 0Ez2CwuTHRcNZkcWiWL0NO1wgq8ECq34nwWP4LaXekU5GcpIRhA8yELasAjP1c57TvgSq6uj5T/
 o8zM64NCGBgwBC8pETA==
X-Proofpoint-GUID: iMIZXyETIijhyRrFbDju-FXFOYLPta27
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6adefe6b cx=c_pps
 a=uej8S9duoQdrJ4czObxKNw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=9a_GLtOMAAAA:8
 a=Lal0q3wtAAAA:8 a=sozttTNsAAAA:8 a=QDfc8BIJfxCpjh7KhdIA:9 a=QEXdDO2ut3YA:10
 a=VhXMHrVyyi-XtLzYJJ7L:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfXwHiYZ40cnmML
 VyMRsFY1JGnJNqvHfbfwaQtklqbl5xlAlV0ffIe4hO78f4GhXyHcyhbQ3mxxdaxvu1aGQWLLDaz
 uFufE2VIpcMLRFUCD1HO74VUTpPIWlI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1011 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260028
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some i2c peripherals do not require or wait for i2c ACK, so the series
adds a flag(DM_I2C_CHIP_IGNORE_NAK) to ignore negative acknowledgment
(NAK).

Our usecase is SII9022A[1] hdmi-bridge, while reading the EDID block
the bridge doesn't send ACK (mentioned in programmer's guide[2], pg 22).

[1]: https://www.digikey.in/en/products/detail/lattice-semiconductor-corporation/SII9022ACNU/6596625
[2]: https://www.scribd.com/document/808632235/SiI9022A-SiI9024A%E7%BC%96%E7%A8%8B%E6%8E%A5%E5%8F%A3

PATCH 01/02: Add flag to support ignoring NAK
PATCH 02/02: suppress warnings if i2c chip does not require ACK

Need feedback for the series. Please suggest if we can have a better
approach.

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
Swamil Jain (2):
      i2c: add flag to support ignoring NAK responses
      i2c: omap24xx: suppress NACK error log when I2C_M_IGNORE_NAK is set

 drivers/i2c/i2c-uclass.c   |  3 +++
 drivers/i2c/omap24xx_i2c.c | 16 ++++++++++------
 include/i2c.h              |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261026-rfc_i2c_nak_suppress-d99cc3ca3ec3

Best regards,
--  
Swamil Jain <s-jain1@ti.com>

