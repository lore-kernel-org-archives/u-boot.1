Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0F606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z16h1sKP;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fcfs/BhT;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=cd9kdYtn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54B70405C8;
	Tue, 24 Nov 2026 08:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-vfv6PvNN47; Tue, 24 Nov 2026 08:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 799D640729
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795508177;
	b=ZtWHo/lAdYau5PmDQInr5ljagG3NWYjPNGRmtEit73GPFc5+2X+2s6ZQPBV5BC4hifpq
	 sUfIfT3E7hO3COxu/yFJnRCVvDQD6qF7Si/JZWRjOHTZ8OxPfHNYiHgDVPCHi5DnwGOAQ
	 K+OwRRyDcHU7BWHoTWIAQskL/9D7bcanOJdviIXWqTyXuLCLGRgyYVLaKR050Mt7gGEEj
	 dVSjUHaY4HM6PChyfL/s3YsEnjFc4862tWt798O1xZN35m80ff4f/s/LADOY443ma2oDC
	 NbipKfw7NkRjCgKREsvvkC3SQQqmp5konjWw4fUDszjWjnycVuI4mZmZRlt7TVVMFzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795508177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F/ayNjEVcm+LrfypXfA/A5V1TMKEHZhOzLKdPOe8qEA=;
	b=LwePDoDNElsIvK/kZGTGcLRT+KJ944Cn/st0f2X3P6JSkCWyStUYfek8YGwgPFhpyIKI
	 FTYGT+f3a8PO51Dw5cW4jkUl7naCuN9dxhtBMrATNDn9bl3Q2GgC2IEzPBvWGYLR++RBz
	 2mt714NN4zxbKGk+vRcIA72D8IJkQjNsIhetLYZZbZ1rHZiMoekVXFhSaV5EtOH6VIuQs
	 9OVff4gOGWyBCdZyCpDBTfIPGiqTiF99A2D8H9KgDsixoVcrA8T7TdrovO21SwFUFJ3s5
	 pUNAiZbojTpMlTlf6w7PDOF4HkiTjDz8+z5HXVgKp/lLl+RRnl56XhjaqxV+pLtg0wA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795508177;
	bh=F/ayNjEVcm+LrfypXfA/A5V1TMKEHZhOzLKdPOe8qEA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z16h1sKPap2ko0RM118ynl+CqPye1ZGGkPeMTQJc82nyo6DOVY2liynEagovtf20I
	 /o5NWGz8XWd5dLXlvuqoXs+q89zQX3iuishXcg3LekYs2KmFE7m5tGYvnCUJ6fMEkK
	 Jd9WLuSFvi2+wSupb+nb8VzlRKmCspD/lykB2QOCMZHaO2bB66djfW9rMmdO/yk7xP
	 jpQJ6rQtEJ2nJQIhOqHS3OqlF5fu5py9CmzXFPb7yBEVrQyxRFAl9vLW4Q6n2PUAeW
	 Xl8kwjdmeSDdgLWUn7wOIldwWhSMyOGkbvyvCn8ve2Zh/gSnUVbjxNi6olQXGDbnVb
	 ep9pyl7pq68SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 799D640729;
	Tue, 24 Nov 2026 08:16:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 95B4D22B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92513402E5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2yqNWPBVvAAd for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B764C400AE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=m-shah@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fcfs/BhT; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=cd9kdYtn
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B764C400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:16:12 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO85dPZ1488093; Tue, 24 Nov 2026 02:16:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=F/ayNjEVcm+Lr
 fypXfA/A5V1TMKEHZhOzLKdPOe8qEA=; b=fcfs/BhTGb4dvkd/d86+N2FHOB+0H
 Xy4OfDgTW6oPmBENx+ePQiabSaudNZNR6s8x1n2BTdh1NL4e9aBvuFmeX83l2UbA
 PNbjAP0N2cmePEBvF8wBX9CeoEsWZduhwcT8LXRt7MusQyweDvad20NlYbzTlLYT
 O9g6xDANEByLZ7TENIwdhEHJ10irWhKLXOhHxdUAMG4pkuFreOxmbG0MwR+GrQXP
 nc05QYEg8XaxBt4+7irf0r7DWG01MiPZF++9WaHJXts7Z4sVs/8/2N9dYJs40/Gq
 Zj3aOQlzmM5DecIXF1SE0SgW2/v45AkT+m5RfF3TXY9xiQe4xx/ONQvHg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j4v9239xf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 02:16:11 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/ayNjEVcm+LrfypXfA/A5V1TMKEHZhOzLKdPOe8qEA=;
 b=cd9kdYtnXOwMtQPqURgLSwNOqJUeUF5O5oXV5YnVMdbgWJWn6Xw2FH1M7/KfHvGbTGtOT+DGm3yNXHRxq4Sv4Eq7D6kGnnNqHJuML9q9q+QPwQYi+GKFPfTKM6jzkCTV/Zc55J0HA+rOxEkXBjm5r39Vjip5T9xhl1998cKNHmQ=
Received: from MN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:52d::15)
 by IA0PR10MB7231.namprd10.prod.outlook.com (2603:10b6:208:409::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:16:08 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::5e) by MN0PR04CA0003.outlook.office365.com
 (2603:10b6:208:52d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 08:16:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Tue, 24 Nov 2026 08:16:07 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 02:15:28 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 02:15:28 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 24 Nov 2026 02:15:28 -0600
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [10.24.50.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AO8FPub1214892;
 Tue, 24 Nov 2026 02:15:26 -0600
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <u-kumar1@ti.com>, <m-shah@ti.com>,
 <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH] arm: dts: k3-j784s4-r5: Fix FSS range for OSPI1
Date: Tue, 24 Nov 2026 13:45:25 +0530
Message-ID: <20261124081525.1719157-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|IA0PR10MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2fe685-e2d3-44a5-f64b-08df4a033111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|3023799007|13003099007|260925021311599003|260925021911599003|56012099006|260925022911599003|261021121427099003|261026121527099003|261102123227099003|261026140227099003|261022105027099003|261021123027099003|261009223027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: nBwsZ9mtzIMPRujCInv5OAUNMAyl3j6aqpR1vPKZzU98dXlcQ7WKbZ15w8Re8pjbKWyWzVdE1DHhmXVpVYlJmRyZUv2iiVAZi6cZOxoV3/PSYktPKqi5OnReKmLp3JyDsyvhXXnF2hEmFIilbVXITE4DThD2gfqN1+JLtP9qW6ZUnME/s/0f70fc+IoA5R5Pya7WQZeQ96Pxs5bakLwZj6pj0b95XPzLlVKFEeqH5WhMnsBlzQdZOEl71vJKMosGqDVxlVhqOZnnmqwH01rBc4r8e7phuFsGtoichISnGSGGb5DdkfGc6G/S6aYjdA7Nc7Cpi2CTqTCo7FrdP4rnwuDKBqg0i8nElhuDrWy+PSpQGxnHU8I3IfjhbjhRDvExpbRc90cBdQZSGfkuFrBqSAxT3RPdV7diFqVl6uVd/h+mhMCHpBMo7E5LxLMD/dvzGERjCSqApWv+Hv3EXOtIFLXzwx3ENT3FM+xujKt/xvVMOU44ADsYmQHYA5+saJUlAkYhrzqqtIfAgQ5TnSQnSXMVhE+FxFl9kOo1aVfv271ooVVseTRNLWeCYhyq33J3Iwzs4NS2G/UBG4HshpNonvcUBv9hVnJVXLOwvfhRozhQpLX6sAd3Caft86b69eSN9itOtzR8GiyTmmkXx21pze5pzU5U1St+h1Wp0Mxf68M=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(3023799007)(13003099007)(260925021311599003)(260925021911599003)(56012099006)(260925022911599003)(261021121427099003)(261026121527099003)(261102123227099003)(261026140227099003)(261022105027099003)(261021123027099003)(261009223027099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cRQ2QG2dxdeRvZ2MjtbLb7dhZJIO+Rp9OvYItGNXXIzulNS3b/K1/6/H3zy3W64UEeZ4cNYyHPTkpXKtDsr+KXNdbJ2/FCDjBL+24vHYN+TjfMKaxZ8rlMI3iW/joveqYbrDq+o3Rceg8u3h2fqfAu+yzMci+NrhtTK/xXUqlYWBtAeXPmgtRU1gaAkQSCLjM8hrlDgd20LsFPaZwtRArJCMt8RN48yC6gmfhWVUrOC4z/QyzM6cWe+bUsEQpVwoK80PPug2KWtcEfuWaYDkWsWScZhfeDotOPbUVZfXEssAxMS6JtvYm8dVNljTZGS17OQmVSNY2YqzeAlt+j8ln+6J7O79Dj6LPDVyOQWSsKCe3/Hi3ovLAMhq2rOBHm7AO5GxrsFv0sW8v+XuOa3SGAD3KmjLtnY/fh3G2cQhCYxYII6gAMsOqcTUOTbw8LWD
X-Exchange-RoutingPolicyChecked: fgJKQlbvb7C/zUhNLB8xKCMWk352lFVf4dioOyErgcKxOLJGUSIY9eaNMvlTjW2R5q9ciXM0R/o3WZKW07URrf5a513TUk0dNIh/Uggd4yB5AIr/bxr1lhxoHsHlBMjPdiobTm/JnwDGQjIK1O/E3Pq//1BxqI29Fx6mfKZqo9oyZ9a3wI9+Ndypchx+egTyjysAv2hv8infF6MBWj9asid2VDAtLWn5nGkaziAE/dCMjPSJDP1guTtGRVDyYpehhM+uuCW95yGgO2tSupQ14bednTtP2v5UFGxbTuhuKdZ4HCLVMG8wAAdmlQbwBWE5Z6tG9evcb4abq+wDd4fZAQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:16:07.7392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2fe685-e2d3-44a5-f64b-08df4a033111
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7231
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX/W4N/8wmvKag
 ntHKp9cu+5AY6G1q6h29crRQgzI+e/LiMuHJDc9y2JOCvmM0kLerP+zJTvpVFobv2kwOIcuE4+N
 sBQTud4XjweAOM5iehUkGHDTPD4eDIMx0QC5e7OqBDmweFPF+jJ/B/SvHmUURJ0oLW7h6fIUEl1
 LekG9ZnWiGz9oQ9R3z/JmYmf13Pl0Qrr1YZ9mppzE+AvfOufl6XFxnPGH32E0BQzFIFddj30wtt
 hnMVfKui6j7WpDTXgy94GDo3zHDvHoFGCg0QvBmyT6vhSYIF8ZGFHto74MsoMNjmLMjSjzmNhBj
 SXRvxGMFbZLPHS979bQFl4TlrTvbMW6TKqDDlgtmCf6nF+emRDtXs1TutgxS7ZZvRHF5WMxSu0G
 da5Mtqak5janornxWMbeZNQ+DwU4lX2AF0IZdQmfR2gK29CDHNGk7+73c9iJ9bFQhWJY/iqKw+z
 2Zww6QuO8zoEmvs9ZyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX4KiqgceaG0P8
 UJiMZaVIDNUbwOo448w1oXyoTX7HWP4cSU33iHBXm2Ux8jH1RBpfziNcLsz/rr0POrmoxy44wIJ
 K+Nu3lTWUVsPWy/uzPOvr57CMtbvOuo=
X-Proofpoint-GUID: ZYuOIv4kyUzWVlmYJ3_b_5tEDKnDuCGt
X-Proofpoint-ORIG-GUID: ZYuOIv4kyUzWVlmYJ3_b_5tEDKnDuCGt
X-Authority-Analysis: v=2.4 cv=QND91QLL c=1 sm=1 tr=0 ts=6b0547cb cx=c_pps
 a=kBTuJkHEWKOaoYTOH1TR3A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8 a=kl3W6Ttyt_pvu537aSQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240032
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The R5 FSS ranges override covers only 128 MiB of the FSS data region,
ending at 0x57ffffff. The OSPI1 data window starts at 0x58000000, so
translating its address fails and the Cadence QSPI probe returns
-EINVAL. SPL then cannot boot from QSPI and reports "Invalid bus 1".

Widen the range to 256 MiB so that it covers both OSPI0 and OSPI1.

Fixes: 9151844547c8 ("arch: arm: dts: k3-j784s4-r5-evm: Add missing fss range")
Signed-off-by: Moteen Shah <m-shah@ti.com>
---
Bootlogs: https://gist.github.com/Jamm02/96d884c47b0a589d168aac8fa7b90a10

 arch/arm/dts/k3-j784s4-r5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index afbb8faca44..8bad08bd423 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -103,7 +103,7 @@
 &fss {
 	/* enable ranges missing from the FSS node */
 	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
-		 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
+		 <0x0 0x50000000 0x0 0x50000000 0x0 0x10000000>;
 };
 
 &mcu_ringacc {
-- 
2.34.1

