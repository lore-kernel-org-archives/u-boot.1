Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95534606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wBF/EbqK;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Y4eGMTRK;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=TWhuUISU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 745CE606B0;
	Mon, 16 Nov 2026 05:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tD2pE1qK3uDW; Mon, 16 Nov 2026 05:52:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B876860709
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794808338;
	b=GgHU1UVnX9zPEdxkAfC+ASIeUQtm7bLhjZiIXMY7aoHheli1x9b1+wmWVffECwK+9qNz
	 26XRwz+s024YabHyetDkPgTBQ2fxv8Nh17uTwFqlbVd4j+hO8ChtSyJdJToOnUBhlA2LR
	 6es0rmAIa3bbj3Yb35ma2rq9AQ9gih0Qx0SNG/QQ+Ywngpe14gR3/x+hLwRMzTt+iAIs8
	 W9mnVc6QrLH7aMxF+JRUKWBOhQhJN9OEldZGv07z1m4a6oZC5UDkK+Q56ylB9L4rYhqJ6
	 JsxK3V1n20+ERPNfNKYPRVNAas4AIBJgrg9A9HsFcdAgDw3mExEG6q1XmyipRaOSeuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808338;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7IyR7yogzZQwhKrIiHSi7E0kwOAWkJVxS1KUpyueWns=;
	b=I2XHwBqnZ9RuNDQtRmHN+zpCJIVD9JY00f9a/kWrOlkqqN20+2I5YEON1LB0ITDeNQN3
	 1SgTcVFF75bBqzjDlxL/A/GSnItCwSAGsBEEHJx1JI7CqUdABYmmqaTesOy3GRny1RHS3
	 oHDyLTxP98bzOuF2dP9bORG0gwy4tsKvl5atbFIxmEDMMlGNF9PQW1mb01vz/EVP8vhwB
	 +kEG0Bn2ZUVTsTNfDfFPUM8YVm291dSd3IF/d/qibkrLDYwOGloIjjU7MW61RfgXpMtED
	 HGmQP1Zwnk3kHQt8WDpFmOVI4UZ3Fv+yCfYJ+i3UeA4Pgi21S7gpJoP93FsdTwfS8EA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794808338;
	bh=7IyR7yogzZQwhKrIiHSi7E0kwOAWkJVxS1KUpyueWns=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wBF/EbqKsVdhYZ973m3OFqtttpHA7KVWFYbzX1QDcRNMtdA0B/NhVa859++Tb8rHm
	 tQZr3oBQ/UXY8WmW2XujgwzN38X41wARu5HBdtIj8OYWFZBueFfut9HeAtK2N0BOoj
	 Ro1z+y2GozDd89Pmf7cf8+Xzgzx59dmUEA5pWQCZ3oRuLRbVWU8BSjGz/Ff3R23g4/
	 MHHMZvxlnUPHu1bBUvXkN8tmRS9OvbSxE9VgdNIsPIGzaGufOGVrPLPdyVeaXxasTI
	 D9dKYmfwisOQrK1dvZvx6ypuckLbvf9VQ+7JJEmhIuup4rGARFlAG9/OOHy9XVYg8b
	 mSbib1ZuvZ2ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B876860709;
	Mon, 16 Nov 2026 05:52:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01AC328C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E728940621
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AEcCCw_Fyadp for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5923C4062F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Y4eGMTRK; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=TWhuUISU
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5923C4062F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:14 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AG4QoNE318890;
 Sun, 15 Nov 2026 23:52:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=7IyR7yogzZQwhKrIiHSi7E0kwOAWkJVxS1KUpyueW
 ns=; b=Y4eGMTRKD8DWqWWOd5Sp5bkbIzUaDYv/7/7GAyelT0+IBqd+RkoiyTmcC
 46kFYIJ0fAClt74o8XFlk8r37CxI6Utdmuhr2t/j9tN1T8AgXtdIfoRFvgBOKY8V
 nvmwqH0r1q878xM2CAUfPJQBDII2wuwEQpviv2Cqp9476UW0cdiuzGdf97qIuRMs
 FQUkM6G9UFs+QQ3KjNvzXSBiA/6PxMO7oLRlMtxoqOy6tMPe9hwvuIdMmyf10yeS
 a0NxPNSEo5f7bh0SjtYlExEPeHGdMStd3jhEusTA01eT0ZIqiinrBPCteeHAPlEw
 VsMAUwbaeHMihf69IoqZwVh4Ubi4A==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hy9j5kpfd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 15 Nov 2026 23:52:12 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IyR7yogzZQwhKrIiHSi7E0kwOAWkJVxS1KUpyueWns=;
 b=TWhuUISUeixIGG2fiZLEzMlCi5pplFqpS5Tjq52fOAWCxYrKhYhZRR96MDmYqfakIV1ECIa0mYoTT+eZ+oO/Vjcb66TiFTW7G0KymRqr5jcLhK1RvVqwgTcNEpyPMZQTBG+8zoLmdH782H54pry4ZPeAzkRaUQ2wvrnRGt7mo6M=
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 05:51:09 +0000
Received: from MW1PEPF00018893.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::68) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Mon, 16
 Nov 2026 05:51:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF00018893.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 05:51:08 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:49 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:48 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 15 Nov 2026 23:50:48 -0600
Received: from toolbx.dhcp.ti.com (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG5oTbr091724;
 Sun, 15 Nov 2026 23:50:46 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 6/7] arm: dts: k3-am654: add bootph-all to gpio@38 for
 daughtercard detection
Date: Mon, 16 Nov 2026 11:20:06 +0530
Message-ID: <20261116055029.3493551-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116055029.3493551-1-s-vadapalli@ti.com>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018893:EE_|MW5PR10MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d46342d-18b7-4b27-d938-08df43a59cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|10063799003;
X-Microsoft-Antispam-Message-Info: 09q7cR5pvc9SdJg7IhxEJLzSJGlu4lRpxp+l27BFExqATyBQp8w1/4Zf8UJLjn+WdytteLb1VBzNO8Rko04IzRLQSgXgC+7LQe5fiPjLZxRtZHmvGZXEDq3zpznzfZvPu5pyYelWPtHtM67h0Q0ZI8ymnN9o3353cuPFV1Tg3ZCT+w41R2+h06WvqW9mG8ozsf75LMjyXpf7aXNH5bzAI/v0FzUlv6VRAFiKO0Mz3qY/KOMiN7omKgD0ZzYFKY14oHjHQwfAgJnJjXT+1CMD8S1tCuDI3CxlLbBl35d3FxRhdZNLb0V9zviVh1vY9ghkIc/rruErzqEP/zNc8otNgjCYKM7MRtarMSygITN7oZEG9QVtgivx7NHb6UDTOjiZVs3xCB+C3+qbG7zxhHjH94budb9TVpkKTsXUivWvCYSkALFjZXwjRuk9BXBKuJXLKKfMCGHMdWFLljWKJD6mhUhMW6vlxRgUylKpS7zTD7olQg93bwj61FF1QMC1GX1SdmMYaXASi/cPd86kspc8MKnb92ZL9+w7dOxu8BVz4j/I4gLTvEcN8CqlmtRF0fEXqz5Wri9n3z0rbeoTXzWJ4N49v+U0tEWzRQJTGfR0QMk6snCqLQ3GzbjdqlYjyrPuVtYtUR/uOUl2hQF0VOCfLlaN138EUfSR+TPaVKZMS+6yYlp4VDIxv5dWOUhL1jLEduv0Gcaf2bH1LSGWqViYsA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(10063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uUG5ekr6l9Dkl+a+oWj5RdCirD//cETaltpYZIxvYa0A24rdcLS0DZZSvcMWn8FJVqH9xR508M1AMWuQLg13fRRd7CG/uvT2PZ/3H1LyEvTv6lr9MNodSXojdNiAXcqqYUocqgttqAExRwUd1Ynmbj2pa2X0w2O0DcCUZpMhZB9N7dANEIZlg/izEm7EzZKyl80YZXhvQr5PtTW0E2L9g9iDpz+vdW598Xup0SxR3VsoQEaMY+uHPR3v/ZOxTqBLIs4piDxHgJ3V1C7t6NvcRzAtmOaFGhfk42UOt77H9KuAoyCjOfhqCHyciZlfUGGYWLfp0d8Ze9HhNIS/KjJ0XA9XfTaTS5jHefyijo+hiP4vGxzDEYPhtnGCbG1dsid38JQIjqun+BhpoIPs3V537loRGkrebOzmy6BE6boD3RxSNarHVpqFD+hnp3dyuaf4
X-Exchange-RoutingPolicyChecked: f0oAeDwd941tqUHrX5gIps6j/GYNT+UwKuL0UVIpdZyWh989GoJHZDYi5DnVF/qCduZ77eIIKZnkzHS+BUpoCIszp/U8Ire1FA45ds9K7TzgFamb+dmAyNDIIVNJLlZscExB2cptbeKjy8LmLKAx9BN/qDU7C0/GAb4FOqPyYvnKgZ9hB5Tn10SUI4ibBFMQ8RybNTZ72yoendOaod5t79yr1Vpipyo0Qe6Xv7UkZ/Lnf4PbWCF8jP9Zy6wZg9dKidkoa0ydM0L0vz9SdxTAtXJTt6F/1T/alw+Gma5RCppBkmruEdDCDDUdXydi5Ys/xCwJIZ+spc8cAaKmx1U1BA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:51:08.7656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d46342d-18b7-4b27-d938-08df43a59cc9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5738
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX0T7RQJVg9euq
 /Y2ne9Ggw81fgxI8wlrtCXlsZz/4r5EdFe1zbkSdhP1LecEHbq+1qpKDpSr38ExRqCibAXdJgFt
 hmFOX4hdeuDpQMlEmyhPYJMbN5kv0pA=
X-Proofpoint-ORIG-GUID: mnuKPDRtsUXaNThlHR8ymEAbgDAn9_FY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX5qHcm2lTUZZy
 iUprGlqrfWoJha1m9hAP64QIN+wIn21mgAy5hAmR7xsbpV7qwE86+Xnem1BWQauPArgQKbPUrCd
 8D2bv2Cb6s6iZ1OKHWRmfa3rHzKRNukxOaY7D9ETAwaLbq/rmlvqZpVgzG9T6aGeAPAaISBS1jl
 OqiCBdLblhBrc5dR+6cbgG3G7hG+F4SnkI5knur1QZrwoLUsSrv6XTOmKUIYpjuKqW+H368RUEw
 L9wDE68iK3/rVdvLITvNROFs/ro25wWmsgRn0aE2siJDS7Xn69jINMGL1VD6D9Ak3z7iE3bgQ1f
 NnYLMfyhfKQLnGP9OZPlIIhMbyeDhtsHsUaxHQ5Jgs/HYq5SHiDcbn1hRx3GLm2aOG+vKchkIqh
 +D2Q/b48zUmQOHvggL4/2Djp36Xp5YFpYw+wzZxvw0H6GGVI0kFVrl3SH2DOFa0cLIuNZhqt0kc
 yghK85g2v3e8r2s6peA==
X-Authority-Analysis: v=2.4 cv=TplzFzXh c=1 sm=1 tr=0 ts=6afa9a0c cx=c_pps
 a=QTU/OWcW2qKRxVucCLrmDQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=VsGSjbAOC_8i-f7ynrYA:9
X-Proofpoint-GUID: mnuKPDRtsUXaNThlHR8ymEAbgDAn9_FY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GPIO Pin 38 accessible via WKUP I2C0 is used to detect the
daughtercards mounted on the AM654 Base Board. For the daughtercards to be
detected at the SPL stage, add 'bootph-all' property to gpio@38. This is
required for the PCI-USB2 daughtercard to be detected at the A53 SPL
stage followed by A53 SPL updating A53 U-Boot's device-tree by applying the
device-tree overlay corresponding to the PCI-USB2 daughtercard.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index baf5dd562f9..9e5f4b6da10 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -146,7 +146,9 @@
 };
 
 &wkup_i2c0 {
-	bootph-all;
+	gpio@38 {
+		bootph-all;
+	};
 };
 
 &vdd_mpu {
-- 
2.56.0

