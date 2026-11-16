Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD181606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mdYcQjsI;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=lmBi+84a;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=O8v0SnUi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B71E240638;
	Mon, 16 Nov 2026 05:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSOBOSOimfDS; Mon, 16 Nov 2026 05:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C17934062E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794808273;
	b=bnansBqDVydhlDR3N6qka2TYsei65mn24PewYEuzAyYq8Tzy9BegKPPAxKOEK2+M0i2Q
	 rX18HZXkh92HpasqcxrQ/bcYeS/D9bIXcy5fqxzi//GpKuGlLoQYCbcZidmMLihY8FiZ0
	 QohJpw1YVeBK2aPoePfyDTE//9DZxoVc0+UI4aLT4WWckCFEq+IUH+9G4sHJVKmoEjw0/
	 C4f2VwsGEMlE8Ziw2R7+F7HDcofP8rwYST16uu0uR8JzlRkqhHSbsDFaLWOTJB1ER1m6E
	 feg6EqASOD1zoI4I55DqlXGUsO4X62Ct9SEmOBSf9E8yvwzwAgIJC7Nymvr1nPMv5cA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808273;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aAJDpp8I5TIteFyPtfPXDzINryZ/wvy7pQPjQAmRlts=;
	b=eM1HMI1t4ri6AjMBar5qK1hRhGOaPGzxSQ5ugunxj6wsSEumlpoa67an2nI5b3byCtg5
	 afYIRS9CmniH8CKa+KTGHCgrh/kPhwm+bU0mPvZd/vlK28lSeXcxbwCsswLizoxaX9xYN
	 DLf8YQrtP4Zh6lrWpC4/d1JK4Eehy8vpfSSQVrHS2Jk3+ujQMaHuUbc2iOog5MocZNFSO
	 FOZS/2h5orTTI6CUyuIswqTb7xFg5vTMm394I6UtHjwUo7/nmA7zonZo3rSx+bEJvoR3v
	 gOkPpYWcr3VMaEsUY/atoSPuDKiEobrK8Y17J92PpgLvuWB71g/OLIMidtuAiRLtP6w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794808272;
	bh=aAJDpp8I5TIteFyPtfPXDzINryZ/wvy7pQPjQAmRlts=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mdYcQjsIn5Z7BHPasBw5j4BCQ6Pu4Z9ULkJ2CrSeUgtCnKuoY6gXdkMzGdJWpDKXI
	 Cn7xWAvuuBi9Nww4yO5nAJeXrjFv+ycjO88PBIJLu/5R/R7JbC0LV696bLO9RUizf1
	 fgzbmc5Ag81gQT4GmFZ7RJHLDhfjPDP0UojPqS6dcJGmiy2diwCTB9rVIv1HuDpmNS
	 NXfMMC2uU6SBYveJhKwVb8z1n+8IU3bNWGAPR+YIjSTKDxS+qTe3jSgvc+nDtE/Oii
	 vfciDnoPKN9Wn+iRyh/Vq7eqPBNIELAa1j51hrwiTvB1FunbAlB1DX+1X+Znu9g0ir
	 xQfHodOQd2PiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C17934062E;
	Mon, 16 Nov 2026 05:51:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B4E22FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10D4F6068D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhiL8aOKNIkg for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C30AA60709
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lmBi+84a; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=O8v0SnUi
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C30AA60709
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:51:10 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG4QrBg711870; Sun, 15 Nov 2026 23:51:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=aAJDpp8I5TIteFyPtfPXDzINryZ/wvy7pQPjQAmRl
 ts=; b=lmBi+84aSDP6gEHL7O4+K7B+RKVMS0KU77hqCgH4CdRFyIRSmePYPIYiP
 erlVylB/YPKBf99i3VevIP6jWFfF4W6F/0LvfeP4FAnMX+YCSf4erJUMvKBO6Oe1
 +EeFWtaaDzeLH1pVdcWUMBpNSntAcczC7CgJEkUK8+5zriPQzyOsYchlTE4/EwzA
 mnvwuE8K0A93y60DDjweELM7gmVCQantaWj4vR53lXVOU/tts57aebL11uT5uq4Q
 rsDV/E/fJUG2Jxjs5AG4RtlWdcl3hzlQ9vAhtvzBiqLtBX6ocBw0550giRKguvyF
 K4KA6EQXdQ2uoFs5ghZTCa+2RUouQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hys3u8t7n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 15 Nov 2026 23:51:08 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAJDpp8I5TIteFyPtfPXDzINryZ/wvy7pQPjQAmRlts=;
 b=O8v0SnUiFuKq+v1/1beR7oLKA7o4krEyM0Hry1Pgg5J6Tl+kDhgmtkQ3PtyoRWuETRRkFU7SnRztGCQl3WriAY3ZDRmbrkJWlH1jwgZKs1xM6mnidWEHestLBr2A+tOoPn04+SrtOpe3bgrKZu/ZYP2L6EK4B1y0Aqn0p3Dw/3o=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by SA3PR10MB7093.namprd10.prod.outlook.com (2603:10b6:806:304::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 05:51:06 +0000
Received: from MW1PEPF0001888F.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::31) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 05:51:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF0001888F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 05:51:05 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:43 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:43 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 15 Nov 2026 23:50:43 -0600
Received: from toolbx.dhcp.ti.com (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG5oTbp091724;
 Sun, 15 Nov 2026 23:50:40 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 4/7] board: ti: am65x: evm: add support for SPL to update
 U-Boot device-tree
Date: Mon, 16 Nov 2026 11:20:04 +0530
Message-ID: <20261116055029.3493551-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116055029.3493551-1-s-vadapalli@ti.com>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888F:EE_|SA3PR10MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eef349f-f379-4d1c-3154-08df43a59afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261022115727099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KmdkOm6sjRa7RGPQyq0EQL7XJu1CzInHNyA7z3PkyqhgtzI6peKhk+ufZ4Z2D0WXPPqNuHegvcG7fxQY1V85fqP/MIj1AmnIwHeT0D0aPNRyGODwCHaVznLbG5WmH+ZOZCvGJy7PYgkeRa3A92oQLMGRzbjjHKHpljcia9cb2mwPa9BLg0Z3ZsXVbcc8Q8FOnYVezupZTNkoWwLQvBDxK5c1wDrbRWJsAOPyg06HB61KYr2qCDu69vW0m+LxW01A17YQjBYzhOdxFRT2lTx5nuj9LF8nTqsfoTLiiFZ8du0P3vlxypKH9/vJB9yQUIKXWmE61VqkHg9rdh41plSFUdQjswLFYghzUdnrCUpTkZtLu6n/hPB35kirIw0IEK+pUDfD6BxQ+DcP+b8AkJI1GlHZNiAbuK/mvyl1U3OCC+MUwva3ZOJRNkMEhUHsrNBW9llszt+4SLg+zQPeHHlVhlkJNoVhZcTb+UJcsuuAEhwxGU4X6ljqBG9adEG8Ac4ernoWnSmwN0kk8w6UnLja9FQCG0bZcA28R0rEykbFHwIEoCCDal9Oi9AzpGS5ikM7i3IWqbqTh+QIc0F0F9btHpmfReGJz+J/sViq5cDJtBczRTvCajHN0AZgSXUNr+5vA6Fqaw6QZm9L/KE4uY/a8oQoxrP2/A7VgcFNzQUcKbXsDqrHX5Uk00oUoZNxhG/LUUFeFIRJ2pQTClFl+OuLJw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261022115727099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JGVpD0BK7S96E5ApTwRYPxL1/6eA9ngqgLw3XGeg02gJDDb2rCFRsucVqfCx0qJbwACJbJ3sMilDPsvNFokWskOBwNNp3zR2+vkdtE7UOubftSuWrEyIlUoa0mcG2aDaV75VOkWY4adV4Hq0g1CUPDYLjbsWJq4A4mBy6FxMk519GLw1pk9EOneW3aTqa9rKMbRTAgGQukMd97C9UQKmW66ItpF2fx+yTMpvckL35OS1045Sw+P2wWTiBRzrs+j2CEah6fpL3Mg03d4QyqOWFdulTNNoSrX/iGA6u2AagEk1U2EyKCnD5v0KlX+KhWIB46SOauTcFBJswtN9du2Ri1u7y6hCfObBg09hYXgOTASfmmsAqHLy7DCXuGasO847wrocUQ7sB5Z19BhZcIK5spkF7aFd4JuIB5WvRXa0ULD6Zbs9bFGLICQ0OK0dcFd7
X-Exchange-RoutingPolicyChecked: 1zKxFCnwXxgFe6yCG9nEeSuCoq6X63q1chxMzzFjIEXeyZDS3kYZeaTYCwTpEkh5HucPVhMqtp04xE85kKKL+OGixzhXRxT0xniZZbx074eMFSih0i/GfgBn8ZfOXD64n8xubLgSz/mbtXpLpKMTIDAvFEXQhWNXTNxOmi/5BIf6mfPHMH9RlGh5AY7DmrNt23SBOskmL6/yOwuMggI4ZWA3G0ZZPtHzNoIvbwm8ghSHy5TbtdzL72ch2+TZ3LM/WQ8uhGh0/pAeJnLCWhZDqpEyQ0+yUhdwPYT5E+n2OTS8Vwyg7czQkxRTF4TP6s7c6S9SByFRIRxDVeoIFbCToQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:51:05.7416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef349f-f379-4d1c-3154-08df43a59afb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001888F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7093
X-Authority-Analysis: v=2.4 cv=etZKXYpX c=1 sm=1 tr=0 ts=6afa99cc cx=c_pps
 a=UNZgSj2+zgRPHH//f1mBVA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=CJpyKn4wwkOrDLVWNK8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX6/AAST2H+iUa
 RVDjVjcW4dixIVo58qLKmrR3VL0POuFHb+HEeJzIZVfBqeurSBnKsh86Mz8hF6Ie6HV+8sYZxsC
 6HwHJ9ZNTV4uZVGd6cNyYRlCFYpfPQfuM9ZlzmNWTxRQps57dIjvoIoriqmB9IwYHhPWDUdZ9Y8
 ekvonpGfK20QxbK7YVoiWePKCGXmQg11oACZlZqjRAi7SO6xvBs0kDH6r4sAbv7osY8ZkqJZNpH
 RJ7yWPm9p7FNIHfXMwjvlaLWKZPNErPoZwXalYlPAm5AlV9qoQScbMVKoU6dO0AGJzJtO+rclSt
 AQcNdj5jfB2Va157FDeDIJtA0QKWBK+DJWJmb7b6vgJzVDWJsEYR+PYnFOIYQvOs5Lk61yR5rkI
 y+qG6Tatnh/3OyoptwD6unCSMpqRusIcd14PyLtw8/5sazHMFU1zX1Naxy0aPSbkQ6bb3E2xIS+
 dnc1KmluyGDTVt5wZmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX6fTVT1zCXxtp
 JzYPjom7WzGmHvke5jRHRU1rS/Ru0XUKQBe8dTpygFjkQhkhtpxVG0rF8yeHUmG92HSYM3IHhqZ
 TZxTEm0RJU6jaSSc8ukGaHn8Vk5mC3g=
X-Proofpoint-ORIG-GUID: ppkWIZs7liL3_iUyb5W6VVSxrhOhrBQy
X-Proofpoint-GUID: ppkWIZs7liL3_iUyb5W6VVSxrhOhrBQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160023
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

Since the device-tree description of the peripherals contained on
daughtercards that can be mounted on the base-board is present in the
device-tree overlays for the respective daughtercards, in order to utilize
the functionality offered by the daughtercards, it is necessary to have the
device-tree overlay applied for the current stage bootloader by the previous
stage bootloader.

Two such use-cases are that of the PCI x2 Lane + USB 2.0 daughtercard
and the PCI x1 Lane + USB 3.0 daughtercard which provide PCI and USB
functionality. For U-Boot proper to detect and use them, SPL has to update
U-Boot proper's device-tree by applying the corresponding device-tree
overlay at runtime.

Hence, add support for this.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 board/ti/am65x/evm.c | 76 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index b35a9229033..1ee7ce5e30f 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -126,6 +126,14 @@ static int init_daughtercard_det_gpio(char *gpio_name, struct gpio_desc *desc)
 	return dm_gpio_set_dir_flags(desc, GPIOD_IS_IN);
 }
 
+#ifdef CONFIG_XPL_BUILD
+/*
+ * Populated by probe_daughtercards() in SPL and used by
+ * board_spl_fit_append_fdt_skip().
+ */
+static char spl_detected_overlays[1024];
+#endif
+
 static int probe_daughtercards(void)
 {
 	struct ti_am6_eeprom ep;
@@ -133,8 +141,7 @@ static int probe_daughtercards(void)
 	char mac_addr[DAUGHTER_CARD_NO_OF_MAC_ADDR][TI_EEPROM_HDR_ETH_ALEN];
 	u8 mac_addr_cnt;
 	char name_overlays[1024] = { 0 };
-	int i, j;
-	int ret;
+	int ret, i;
 
 	/*
 	 * Daughter card presence detection signal name to GPIO (via I2C I/O
@@ -242,9 +249,10 @@ static int probe_daughtercards(void)
 		 * Populate any MAC addresses from daughtercard into the U-Boot
 		 * environment, starting with a card-specific offset so we can
 		 * have multiple cards contribute to the MAC pool in a well-
-		 * defined manner.
+		 * defined manner. Not applicable to SPL.
 		 */
-		for (j = 0; j < mac_addr_cnt; j++) {
+#ifndef CONFIG_XPL_BUILD
+		for (int j = 0; j < mac_addr_cnt; j++) {
 			if (!is_valid_ethaddr((u8 *)mac_addr[j]))
 				continue;
 
@@ -252,6 +260,7 @@ static int probe_daughtercards(void)
 						      cards[i].eth_offset + j,
 						      (uchar *)mac_addr[j]);
 		}
+#endif
 
 		/*
 		 * It has been observed that setting SERDES0 lane mux to USB prevents USB
@@ -283,13 +292,66 @@ static int probe_daughtercards(void)
 		strcat(name_overlays, " ");
 	}
 
+	if (!strlen(name_overlays))
+		return 0;
+
+#ifdef CONFIG_XPL_BUILD
+	/* Store for board_spl_fit_append_fdt_skip() */
+	strlcpy(spl_detected_overlays, name_overlays,
+		sizeof(spl_detected_overlays));
+	return 0;
+#else
 	/* Apply device tree overlay(s) to the U-Boot environment, if any */
-	if (strlen(name_overlays))
-		return env_set("name_overlays", name_overlays);
+	return env_set("name_overlays", name_overlays);
+#endif
+}
+
+#ifdef CONFIG_XPL_BUILD
+void spl_board_init(void)
+{
+	/*
+	 * Detect daughtercards to allow board_spl_fit_append_fdt_skip()
+	 * to apply the overlays to U-Boot FIT image itself, allowing
+	 * U-Boot proper to enable and use the peripherals on the
+	 * daughtercards.
+	 */
+	probe_daughtercards();
+}
+
+/*
+ * Mapping between FDTs in binman.dtsi and their corresponding Device-Tree
+ * overlays. Depending on the daughtercards detected, we conditionally
+ * apply the device-tree overlay's fdt if it is packaged.
+ */
+static const struct {
+	const char *fit_node;
+	const char *dtbo_name;
+} spl_fit_overlay_map[] = {
+	{ "fdt-am654-pcie-usb2", "k3-am654-pcie-usb2.dtbo" },
+	{ "fdt-am654-pcie-usb3", "k3-am654-pcie-usb3.dtbo" },
+};
+
+int board_spl_fit_append_fdt_skip(const char *name)
+{
+	int i;
 
+	/*
+	 * For the overlays to be 'conditionally' applied, return 0 to apply them
+	 * if the daughtercard corresponding to them was detected and return 1
+	 * otherwise to skip applying the overlay.
+	 */
+	for (i = 0; i < ARRAY_SIZE(spl_fit_overlay_map); i++) {
+		if (!strcmp(name, spl_fit_overlay_map[i].fit_node))
+			return strstr(spl_detected_overlays,
+				      spl_fit_overlay_map[i].dtbo_name) ? 0 : 1;
+	}
+
+	/* Any overlay not in the list of 'conditional' overlays is always applied */
 	return 0;
 }
-#endif
+#endif /* CONFIG_XPL_BUILD */
+
+#endif /* CONFIG_TI_I2C_BOARD_DETECT */
 
 int board_late_init(void)
 {
-- 
2.56.0

