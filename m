Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961DF606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0BBnN1We;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=U+AAk04G
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 661C9606EE;
	Fri, 23 Oct 2026 09:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dmlC0DZKTKkV; Fri, 23 Oct 2026 09:06:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BFF626068D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792746403;
	b=ITBFPDJnviBRjW74UevIwPQTqC49l4cYFPN7OygdzQTDPkmvOu5Q59nx9hTgKPTAoZHB
	 XH8F6Psxl3VZGrLNsJNkqipOIqQ80lgdyA9zOvBrNTAhYgUJ0HJjPSB/tDUGojlO2t5hu
	 8gcJ1dymLLUZYVDrpNT6Lh0qPSXag99PPJASLy4D356rpR4O8IBT/ivzlr9b0CrXSxSyK
	 uGGYMtLObIFbCOPKY0O34sDHRLXvR2eCy/zYb5g30Dk15Ny/vtkk+j0H8C1l47Q3e6WYL
	 wepOVk6dUjo8jUMVYx/EafbK/c7ujKdiUUlvsud04Q2poEf/R8vVo9444ly89YdHcrg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792746403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=EjVsEvdaMPI+eNiirqyUE8IKdkD6+tnRr+ZKzyo+JT0=;
	b=R/TLIvVWP7nBAz3LGuzZH30JH38mz6Qs7pVy9jTT55WguiaGbTxM7cirAMnu94bcDnBr
	 nwTlwqBpiEq97RfoEpYWxq5X2yMy+w8Y2N883PlSZ4Tjn2LPJ+BUBbi9ltinZqqxNw/R/
	 65FiYKhrcd6JS4Csf+X3R3I895MWJk10R3BODxV6mMstMV2U/a7XP/r69mJV8FZn4wEPz
	 9PjoXTEEvt/2yWeHb5NEIh7ekDk2HJle3fGjc1eA9rZfj2hvep/2JDmGHKAI7DGEQyBOq
	 q1cVpnGgJMOGDtVJFxX5f7REfaPPK6jc3bZr2PhKzCn7Ysndq6qN3SA9cN/ALYoSb0g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792746403;
	bh=EjVsEvdaMPI+eNiirqyUE8IKdkD6+tnRr+ZKzyo+JT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0BBnN1WeNxaTBBwe8z5HyCF9CEHm3ZNKyFABwigwZUnnpBNhPTfW2ph9LolKBoNBq
	 /3enEpJ82wGRKAssLETTYDL3u1hM9JMb39aQ75ftTMtGsSdFC+pv5qHQ3dgn0Gm0f0
	 6iA6/QsrixiCik+CjdKG39I4kwm7IBGQ53HWiuRhlFD8VS8uwlN/GOeVvavdBb7+Nf
	 GiVbo6h9nsOwfUeCMof7NbkTO4qZNvEsQUgsjg/ie+rBuKj47qymYQ/aMCagkSS+OB
	 nelzkHH+gided9pgJ4h5Ht+3uv0taQr1Op/GENd3Bra/O2soHoBQIjUM1EYWnV/h/b
	 hauo9Hj4uT9cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFF626068D;
	Fri, 23 Oct 2026 09:06:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C474371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A3AC40845
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNNmQNgBXxrj for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:06:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E620C406CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792746395;
 b=doM4lMA1acUgMo0E3oaSxVhi0pvu8A44ys6t44kjNz5+VwoTo9Qqn/DujFYFc5W0fOXj
 4y7iDpUSmwGMTdTT0eWrGo30hiy1MM1xRT0YU4tXI8u52ri3cqhKtO/Jdc+4fbPsa+qNK
 VFBBVv2JEL1qDn9ReL0kcOusgrTNh9mI8FA+dC25/Akxi9jwBiXKSVMZlmCGrdiaKdSaQ
 3sfLeERNP65FCgMTlkavCx1dibB4Ol6FfGSnZkVl73/OwzLKNcgOhBY3KxXrVBphJ29VL
 JFQYtQvVSNUZfIMQlQLATvXzeqYGtw7kG+uA7XCc3qAVFb9+r39F2umobT7fIlY4QRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792746395;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=EjVsEvdaMPI+eNiirqyUE8IKdkD6+tnRr+ZKzyo+JT0=;
 b=pA2pzfp7Ctsg/v+iWPTdUVOaUXCAMfyOzbE5bQQWJCzqpF0P6wISB8pEf0Ik0R56G6GY
 cK1rRq/U6zdFgPLlpneTR757G6d3nc0voUAadGPpi9BnFjg7Q4SW1Rl6O1J1TKzDXFSlY
 634k3dzoZLCQCUyMzUApyX48b8phSFopDtfamxr0ow8SkkB7YqlSkP+i6BYDLJBScl3Xo
 DDA0h4pntPVNgzMVu/KjJF1vnRVkfrX4i7eGk2vamBxh68ZJNdH4aJhk2bnPWmJNRGOgk
 xgN2gVLWunfNK0xas0xcd1U5maZQP71feQwW612P/kJQi3ygDcdbCO0Yp8ZeXuSQzLg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=U+AAk04G; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::1;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=U+AAk04G
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E620C406CF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3PcahwecRiD1Qq1TF83lrKu5Gd0BXaHhkVARUou4ozDm33BOXISbnxXj/Gg5+CVw3Bxs3l2CYJgsVhmSG1VPuH6fmznqt8LwS4K4tbLZovGGbjO4NDY+9F+zuvHx2eoHn/Kdp0FIsmTi9ZKHoAiIrN9l9C4KZGQnoYejHpAzlBu66tdSrN3nuWScSro26S+8EsKGYdW2HgH2u+9+MxS7/YvtGMQ9X8bSdzyG0+nYCZ18p1c67I2uX+KywNt4D7fJaME30RRrxTZtZtTR8W2PRyKld10X6tyawq8eyUH0+c4WjIeKBg4HxGV5+Cf69ETrpuIdEF+kTozMI1LPIZqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjVsEvdaMPI+eNiirqyUE8IKdkD6+tnRr+ZKzyo+JT0=;
 b=Plkpeeqf/Bfle8VnhtfpV08YdR4yQnTF/N8UwYVET2kNZpAe0ByT/55n2v3cRuIpZ+kvW+Zt5B/yrpQ52xkD8Rj9Qdl38siCUqr/aiWSOxK1+epSEllIz2a1Sk9XB0/S4eXcihZDY9wnWt9MTJ4WZbUngZjNxUuws261+cdZrU0EIcyP4aYZqF61S5V/HZunLtGhzFh+5N6dkwYLAv4jsbjtm5ewMplVw0vSc7je0tsr6PjwFRfN+vJ4hr89/e/z1D9G1li6pN64TNdvaVCPTgBHm0hV/bOpWF8h0q/F6h7OmWNNfLeRvwqxwPsZpjiZaIqRXnvirzr+OyrOqgZhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjVsEvdaMPI+eNiirqyUE8IKdkD6+tnRr+ZKzyo+JT0=;
 b=U+AAk04GIGeRc87yUSWpI4h6buZwbrFTfjn97Ry/lZgrdIqnyvvrOO+Bei3k1A74UFbB8H3CYyDkgJUo/sOugH+u20JwaL0Ufw1ry83Y0SHmHQiUqojXK2ZNo3GK1SH7e8/QTNTarxnnDigkzz/1VD68nKO0RNid2UIPMT/eF8AXP7fYM/Mdl1+1MPlk3VCuf3avjbKo3B5WKz6Mfn+lpWPnTtg9J34IrYjMywIig1NGXmDsapXxAM40LZBWLSx/m3HhvAMAmgRGTJlP4d5XWORhmnhlTlEBzttYBwGogvZKVovmC33liMER/HmO6MbqIJX1I8kLJ11l0Sr6wQDMDQ==
Received: from ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::25)
 by PR0P264MB3401.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 09:06:28 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:910:16:cafe::b) by ZR0P278CA0015.outlook.office365.com
 (2603:10a6:910:16::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 09:06:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Fri, 23 Oct 2026 09:06:28 +0000
Received: from localhost.localdomain (unknown [192.168.72.34])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0E41120078;
 Fri, 23 Oct 2026 11:06:28 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v2 4/4] binman: Add functional test for pre-load HSM signing
Date: Fri, 23 Oct 2026 11:06:10 +0200
Message-ID: <20261023090611.778581-5-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023090611.778581-1-yan.wang@softathome.com>
References: <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
 <20261023090611.778581-1-yan.wang@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PR0P264MB3401:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12624677-6552-4e09-8d56-08df30e4ec42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261022105027099003|261022113327099003|3023799007|261021123027099003|261022075727099003|261022115727099003|10067099003|261021121427099003|261021135927099003|261021133027099003|261021130227099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|56012099006|4143699003|17002099007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: MLR2ufb/JXqtSGSlpiyy04xjFj3vQ/KJg7JzrVmcy2tnxVloiRG7dOViS4r310C/Rh3xNkQU54URzyZudFURH2EYdsKve9HNQMZM7w5uyZie5jJnFikaWLiEDPDfGoUH8HqyA+51YrBHytbWcfRaXdeQ0mmU/VV+dWibakXbmME9dA7XU5VfOOOIEsDjuPiT26uJgRGF/wQ1WA6PeIPI5pFDwN6ZmltA7kQGpvOS1z8/nvjQ6/Bj/5TRuwnGdte3HN3Fw5ONPW8yVwJ23Q6n4r1wkSmcMAogM2JRCQ1uweusqvSkDcWkrY27xGUQlSpounU+xa1xPFS+rGco1tqY2o9kITc/NbqKLrhKGiT7yPqdFC737GiR/h2K3Wmbei+V+xmBLAv0CSRKTELPPwNSsfyGh4Xoid2R7cvhzFbUg7PywHd5IxhH+c0tRZ2aNcxae5Ey+iotZ6dJLkFUgYXrFfLPpornTzoiFK3o8ZxVChbMaTuU78Q5br6dTEiqnTYIiU7QVrKjZFRCagsuQFZCsrr1vJj//AcUu41qf3wQvyVS26yKDGmmnL8J6suSWyTUXM6GyiRRByv/6VjogCedG1D2FggKqRYbOHqlzFIEu4IH8sF813/D5QS1Tfm8bGHz/b3yuXDpO0dBmJgzvG83ueHW4b5MXVbu9jJUQRnDMJtEPhOfp9Jf90b5EzsRRmqLCi3x0cEN5IaYiLh6gg+5Tg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261022105027099003)(261022113327099003)(3023799007)(261021123027099003)(261022075727099003)(261022115727099003)(10067099003)(261021121427099003)(261021135927099003)(261021133027099003)(261021130227099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(56012099006)(4143699003)(17002099007)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U3iIWs22r1JeexhaM8gYp0b1RFLl08fNpNJx+06gkBiDEEcrJYpojcoA6SF+bxniRk80UjP5uM5rfFmBT6xqQ4w9RejGsiZalP84AyTwSX4r5Yxk4WxI1s+38CcO8utKP6Hq8rWx5JlqXslKczDpM5oPrSAkMte82GKx880hC8HdHZvH8wLNENPeWHpUv6AIgB9C10+Fg9sXrktLcStGklkDFnwOkishiZN6IowcHfpytInjTskxI1FKAa8NPkf7k73QmKvp1mXAuQD+QMcQ551ig/dQKIO1LgV/WeA1TP+sb9iePXj8izLtP7oRGwu1owBT2sYeHXYAO9k28YrtIdKNgerT0xKCuTVLtTz+obiBtgw/GyGNH3M/dyoBgDulhu/rQ32TtOTuuvnKw/cACAk/ch6Ft4rZrRv81Np8+xa+CeFqZ+2IsRFL1sMgpnFL
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:06:28.3556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12624677-6552-4e09-8d56-08df30e4ec42
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3401
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add end-to-end functional test for HSM-based signing of pre-load
headers. The test verifies that binman can use PKCS#11 libraries
to sign data via hardware security modules and can generate pre-load
headers with HSM signatures.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v2:
- Merge v1 patches 4 and 5
- Extend testPreLoadHsmSign (SoftHSM) to cover both pkcs-1.5 and PSS
- Add testPreLoadHsmEcdsaSign (SoftHSM) which verifies the signatures with
  the public key read from the token
- Add tests for an invalid URI, hash and algorithm, module-path in the URI,
  the data checks in _SignHsmData(), a bad signature length and a missing
  tool before the header signature
- Merge testPreLoadHsmSignRuntimeError into testPreLoadHsmSignError
- Drop testPreLoadDefaultPadding and testPreLoadHsmMissingLibrary; move
  testPreLoadMissingKeyName to patch 2
- Rework the devicetrees for the hsm-key URI and make them smaller

 tools/binman/ftest.py                         | 230 ++++++++++++++++++
 tools/binman/test/security/pre_load_hsm.dts   |  21 ++
 .../test/security/pre_load_hsm_ecdsa.dts      |  21 ++
 .../security/pre_load_hsm_invalid_algo.dts    |  21 ++
 .../security/pre_load_hsm_invalid_padding.dts |  22 ++
 .../security/pre_load_hsm_invalid_sha.dts     |  21 ++
 .../security/pre_load_hsm_invalid_uri.dts     |  21 ++
 .../security/pre_load_hsm_module_path.dts     |  21 ++
 .../test/security/pre_load_hsm_sign.dts       |  21 ++
 .../test/security/pre_load_hsm_sign_pss.dts   |  22 ++
 10 files changed, 421 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_hsm.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_sha.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_uri.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_module_path.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign_pss.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d4522e905e0..08523141b48 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -22,10 +22,15 @@ import unittest
 import unittest.mock
 import urllib.error
 
+from Cryptodome.Hash import SHA256
+from Cryptodome.PublicKey import ECC
+from Cryptodome.Signature import DSS
+
 from binman import bintool
 from binman import cbfs_util
 from binman import cmdline
 from binman import control
+from binman.btool import pkcs11_tool as pkcs11_tool_btool
 from binman import elf
 from binman import elf_test
 from binman import fip_util
@@ -5992,6 +5997,231 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn('key-name is required for file-based signing',
                       str(exc.exception))
 
+    def testPreLoadHsmSign(self):
+        """Test pre-load header signed by SoftHSM via PKCS#11 (pkcs-1.5 and PSS)
+
+        Sets up a SoftHSM v2 token, generates an RSA-2048 key pair on it, and
+        builds two pre-load images (one with pkcs-1.5, one with PSS). Both are
+        verified with preload_check_sign using the public key extracted from the
+        token.
+        """
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
+        self._CheckBintool(pkcs11_tool)
+
+        p11_kit = bintool.Bintool.create('p11-kit')
+        self._CheckBintool(p11_kit)
+
+        openssl = bintool.Bintool.create('openssl')
+        self._CheckBintool(openssl)
+
+        prefix = 'testPreLoadHsmSign.'
+
+        # Configure SoftHSMv2
+        softhsm2_data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf',
+                                            softhsm2_data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Locate the SoftHSM2 shared library via p11-kit
+        p11_kit_config = configparser.ConfigParser()
+        p11_kit_config.read_string(p11_kit.run_cmd('print-config'))
+        softhsm2_lib = p11_kit_config.get('softhsm2', 'module', fallback=None)
+        self.assertIsNotNone(softhsm2_lib,
+                             'softhsm2 module not found in p11-kit config')
+
+        pubkey_der = os.path.join(self._indir, 'pubkey.der')
+        pubkey_pem = os.path.join(self._indir, 'pubkey.pem')
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  'uboot-hsm', '--pin', '1234',
+                                  '--so-pin', '1234')
+            pkcs11_tool.run_cmd('--module', softhsm2_lib,
+                                '--keypairgen', '--key-type', 'rsa:2048',
+                                '--label', 'uboot-key', '--login',
+                                '--pin', '1234')
+            pkcs11_tool.run_cmd('--module', softhsm2_lib,
+                                '--read-object', '--type', 'pubkey',
+                                '--label', 'uboot-key', '--login',
+                                '--pin', '1234', '--output-file', pubkey_der)
+            openssl.run_cmd_result('rsa', '-pubin', '-inform', 'DER',
+                                   '-in', pubkey_der, '-out', pubkey_pem)
+
+            entry_args = {
+                'pre-load-hsm-library': softhsm2_lib,
+                'pre-load-hsm-pin': '1234',
+            }
+
+            # pkcs-1.5 (default padding)
+            data = self._DoReadFileDtb('security/pre_load_hsm_sign.dts',
+                                       entry_args=entry_args)[0]
+            image_fname = tools.get_output_filename('image.bin')
+            self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+            self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+            self.assertEqual(PRE_LOAD_HDR_SIZE,
+                             data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+            self.assertTrue(self._CheckPreload(image_fname, pubkey_pem))
+
+            # PSS padding
+            data = self._DoReadFileDtb('security/pre_load_hsm_sign_pss.dts',
+                                       entry_args=entry_args)[0]
+            image_fname = tools.get_output_filename('image.bin')
+            self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+            self.assertTrue(
+                self._CheckPreload(image_fname, pubkey_pem, padding='pss'))
+
+    def testPreLoadHsmEcdsaSign(self):
+        """Test pre-load header signed by SoftHSM with ECDSA."""
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+        pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
+        self._CheckBintool(pkcs11_tool)
+        p11_kit = bintool.Bintool.create('p11-kit')
+        self._CheckBintool(p11_kit)
+
+        prefix = 'testPreLoadHsmEcdsaSign.'
+        conf = self._MakeInputFile(
+            f'{prefix}softhsm2.conf',
+            tools.read_file(self.TestFile('fit/softhsm2.conf')))
+        token_dir = self._MakeInputDir(f'{prefix}tokens')
+        with open(conf, 'a') as fd:
+            fd.write(f'directories.tokendir = {token_dir}\n')
+
+        cfg = configparser.ConfigParser()
+        cfg.read_string(p11_kit.run_cmd('print-config'))
+        lib = cfg.get('softhsm2', 'module', fallback=None)
+        self.assertIsNotNone(lib)
+
+        with unittest.mock.patch.dict('os.environ', {'SOFTHSM2_CONF': conf}):
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  'uboot-hsm', '--pin', '1234',
+                                  '--so-pin', '1234')
+            pkcs11_tool.run_cmd('--module', lib, '--keypairgen',
+                                '--key-type', 'EC:prime256v1',
+                                '--label', 'uboot-ecdsa', '--login',
+                                '--pin', '1234')
+            pubkey_der = os.path.join(self._indir, 'ecpubkey.der')
+            pkcs11_tool.run_cmd('--module', lib, '--read-object',
+                                '--type', 'pubkey', '--label', 'uboot-ecdsa',
+                                '--login', '--pin', '1234',
+                                '--output-file', pubkey_der)
+            args = {'pre-load-hsm-library': lib, 'pre-load-hsm-pin': '1234'}
+            data = self._DoReadFileDtb('security/pre_load_hsm_ecdsa.dts',
+                                       entry_args=args)[0]
+            self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+
+            # preload_check_sign needs the private key for ECDSA, which an HSM
+            # never exports, so verify with the public key read from the token.
+            # Layout: header (64 bytes), header signature (64 bytes), image
+            # signature (64 bytes), then padding up to the 4096-byte header.
+            pub = ECC.import_key(tools.read_file(pubkey_der))
+            first_header = data[:64]
+            hdr_sig = data[64:128]
+            img_sig = data[128:192]
+            image = data[4096:]
+            self.assertEqual(SHA256.new(img_sig).digest(), first_header[32:64])
+            DSS.new(pub, 'fips-186-3').verify(SHA256.new(image), img_sig)
+            DSS.new(pub, 'fips-186-3').verify(SHA256.new(first_header),
+                                              hdr_sig)
+
+    def testPreLoadHsmInvalidPadding(self):
+        """Test HSM signing with invalid padding-name (validated before tool check)"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_padding.dts')
+        self.assertIn('Unsupported padding scheme', str(exc.exception))
+
+    def testPreLoadHsmMissingTool(self):
+        """Test that binman still produces an image if pkcs11-tool is missing"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('security/pre_load_hsm.dts',
+                             force_missing_bintools='pkcs11-tool')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: pkcs11-tool")
+
+    def testPreLoadHsmSignError(self):
+        """Test HSM signing when sign() raises ValueError or RuntimeError"""
+        Btool = pkcs11_tool_btool.Bintoolpkcs11_tool
+        for exc_type in (ValueError, RuntimeError):
+            with unittest.mock.patch.object(Btool, 'is_present',
+                                            return_value=True), \
+                 unittest.mock.patch.object(Btool, 'sign',
+                                            side_effect=exc_type('Mock HSM error')):
+                with self.assertRaises(ValueError) as exc:
+                    self._DoReadFile('security/pre_load_hsm.dts')
+                self.assertIn('HSM signing failed', str(exc.exception))
+
+    def testPreLoadHsmInvalidUri(self):
+        """Test HSM signing with a hsm-key that is not a PKCS#11 URI"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_uri.dts')
+        self.assertIn('Not a PKCS#11 URI', str(exc.exception))
+
+    def testPreLoadHsmInvalidSha(self):
+        """Test HSM signing with an unsupported hash algorithm"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_sha.dts')
+        self.assertIn('sha1 is not supported', str(exc.exception))
+
+    def testPreLoadHsmInvalidAlgo(self):
+        """Test HSM signing with an unsupported signing algorithm"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_algo.dts')
+        self.assertIn('rsa1234 is not supported', str(exc.exception))
+
+    def testPreLoadHsmModulePath(self):
+        """Test that module-path in the hsm-key URI sets the HSM library"""
+        self._DoTestFile('security/pre_load_hsm_module_path.dts',
+                         force_missing_bintools='pkcs11-tool')
+        entry = control.images['image'].GetEntries()['pre-load']
+        self.assertEqual('/no/lib.so', entry.hsm_library)
+
+    def testPreLoadHsmSignDataChecks(self):
+        """Test _SignHsmData() re-validates algorithm and padding"""
+        self._DoTestFile('security/pre_load_hsm.dts',
+                         force_missing_bintools='pkcs11-tool')
+        entry = control.images['image'].GetEntries()['pre-load']
+        for algo, padding, msg in (
+                ('sha1,rsa2048', None, 'sha1 is not supported'),
+                ('sha256,rsa1234', None, 'rsa1234 is not supported'),
+                ('sha256,rsa2048', 'bad', 'Unsupported padding scheme')):
+            entry.algo_name = algo
+            entry.padding_name = padding
+            with self.assertRaises(ValueError) as exc:
+                entry._SignHsmData(b'data')
+            self.assertIn(msg, str(exc.exception))
+
+    def testPreLoadHsmBadSignatureLength(self):
+        """Test HSM signing when the returned signature has the wrong size"""
+        Btool = pkcs11_tool_btool.Bintoolpkcs11_tool
+        with unittest.mock.patch.object(Btool, 'is_present',
+                                        return_value=True), \
+             unittest.mock.patch.object(Btool, 'sign',
+                                        return_value=b'short'):
+            with self.assertRaises(ValueError) as exc:
+                self._DoReadFile('security/pre_load_hsm.dts')
+        self.assertIn('HSM returned 5-byte signature', str(exc.exception))
+
+    def testPreLoadHsmHeaderSignMissing(self):
+        """Test dummy header when the tool vanishes before the header sign"""
+        from binman.etype import pre_load as pre_load_etype
+        calls = []
+
+        def fake_sign(data):
+            calls.append(1)
+            return bytes(256) if len(calls) % 2 else None
+
+        with unittest.mock.patch.object(pre_load_etype.Entry_pre_load,
+                                        '_SignHsmData',
+                                        side_effect=fake_sign):
+            data = self._DoReadFile('security/pre_load_hsm.dts')
+        self.assertEqual(tools.get_bytes(0, 4096), data[:4096])
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_hsm.dts b/tools/binman/test/security/pre_load_hsm.dts
new file mode 100644
index 00000000000..5671559c838
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_ecdsa.dts b/tools/binman/test/security/pre_load_hsm_ecdsa.dts
new file mode 100644
index 00000000000..5b00ed8d69d
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_ecdsa.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa256";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-ecdsa";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_algo.dts b/tools/binman/test/security/pre_load_hsm_invalid_algo.dts
new file mode 100644
index 00000000000..49d1c18f478
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_algo.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa1234";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_padding.dts b/tools/binman/test/security/pre_load_hsm_invalid_padding.dts
new file mode 100644
index 00000000000..6ef11a59bb1
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_padding.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			padding-name = "invalid";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_sha.dts b/tools/binman/test/security/pre_load_hsm_invalid_sha.dts
new file mode 100644
index 00000000000..e6c693e4954
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_sha.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha1,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_uri.dts b/tools/binman/test/security/pre_load_hsm_invalid_uri.dts
new file mode 100644
index 00000000000..17838935f61
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_uri.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "http://not-a-pkcs11-uri";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_module_path.dts b/tools/binman/test/security/pre_load_hsm_module_path.dts
new file mode 100644
index 00000000000..ae25d63b53d
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_module_path.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key?module-path=/no/lib.so";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_sign.dts b/tools/binman/test/security/pre_load_hsm_sign.dts
new file mode 100644
index 00000000000..5671559c838
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_sign.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_sign_pss.dts b/tools/binman/test/security/pre_load_hsm_sign_pss.dts
new file mode 100644
index 00000000000..452f9f6d8a6
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_sign_pss.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			padding-name = "pss";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

