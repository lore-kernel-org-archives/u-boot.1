Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71730C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 20:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 312B760720;
	Mon, 20 Jul 2026 20:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9pWxWRjW5wT; Mon, 20 Jul 2026 20:25:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B5166070C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784579152;
	bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
	h=To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dQizRC6CfhWZn2y5tl5QCugj5Tk9EALt6jN8xGwkMZ1h9Aza1SCVsjnCS09bKURaa
	 d8or9DivzkwJNe3jeFQAyiNr+D8WMESmNoRsG51NmZojOUCNRyMgv4Ho1jcHUqDggl
	 eFYao9vYcNx0Q/d1fVDTRAELyw5YOgS9j9ayNiY0TzjE6LO77+TXBqvbo3RGULEruP
	 eHXcEkvtfdY6IBwY0OXZeLnfJv8iT+SE1bq9pxsKj/LBz2ls5Z8R3Wd1u7L2NYgJhD
	 uVyuZ/SszhC9PNa2JBTCARA0+SNQlnYDTCFi51Bn7llWSw8qoZxzKURJOLr8b2woW5
	 MthwdkuJBJUOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B5166070C;
	Mon, 20 Jul 2026 20:25:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A24D41142
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93C19406CF
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cLScWtRRPb9D for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 20:25:50 +0000 (UTC)
X-Greylist: delayed 503 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 20:25:49 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1B061406CD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B061406CD
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B061406CD
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:25:49 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJQa9H2988947; Mon, 20 Jul 2026 15:17:20 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fhk19b6pj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 15:17:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AopGdg3TT5Ue97nKataikuQe66QXvcGK4rhhyzKkKtsI+vGiq9XOm1JwAGlMi2iXBZOytvxLW2n1SuJwjrZXKT7j3yCxv//Eq/6NCtbp7a1yRG46uiD3lDAT3IWG62V+sDSaTP6bDq73F6JfL+6N4qlKHnxC7MAA6tPAhPuk3xW9tPvwOG+hfPtCPo8eVimfLNRmR4Yurkw3mmXSij4GudoXwimDho0MXkW1GM2t24zvVF++dMQzYcT1fP1TNKm7BHt6iUG77PuKyzOIrhzDN7bg/yOoSjFo04EewEKhSdWFiikafUcdx2p3lWnNj8iaXOXEJXTHpAHbooEvPIeD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
 b=a5qnzgt0Rw7v9GSiw6yPbytQcsfoom3qve9gDNTNDdA2oxa7b4yKi5kEhjpxBlNWE86GDQFY/3AKGZTXEoEAT/ExqHI5DgwBDK4EjryZkESbtc1BCJn2O+4OKCLZRyFzj3twGKqJZ1fRbatOrb/ZNnSmnJ9V6Z5zQWA1XWqjKkUeiIUp903aPQuVKjaNkaoc1ZHCQHn/1S9GaWieHZSzkgMo5EZ5bg4ymLrO/X24plZhwkKGrj0ZZlEWLLb4Fvxym3Zj3Nk1LLyiJvx1LCIDCBu0dU4i7+czWMcQnm32nxgBvSfuY9AINkmHeWOIjsJ8brwjurumup8kwFi3OLDGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from BN0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:408:141::10)
 by IA3PR10MB8441.namprd10.prod.outlook.com (2603:10b6:208:581::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:17:10 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::4a) by BN0PR07CA0010.outlook.office365.com
 (2603:10b6:408:141::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Mon,
 20 Jul 2026 20:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 20:17:10 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 15:17:09 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 15:17:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 15:17:09 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66KKH96H3202983;
 Mon, 20 Jul 2026 15:17:09 -0500
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv4 1/3] arm: mach-k3: am62: add &main_uart6 to clock and pwr
 tree
Date: Mon, 20 Jul 2026 15:16:17 -0500
Message-ID: <20260720201618.3863938-3-rs@ti.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720201618.3863938-2-rs@ti.com>
References: <20260720201618.3863938-2-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|IA3PR10MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d741012-c0d7-4b34-2947-08dee69be116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|3023799007|56012099006|10067099003|13003099007|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gdi39iU81rGb1WxLfvov1dzP0mry1kPUb7eaCQc3coDkv8OVOqEsJ9Ibn9TTSxo8QGRQVhJd2eel/yF9jeSpAjtZge/ZYgmURbaASrCAUsWCW55K1NJa6uHs5PNFEz1g7xruHTKLWttHodq0F1RnyzqZjUM1kQB79zHw4wEaZt/nZ85xcFMSInxUuTPHkQSNuy5ee+V2237S9TvSNgX0VbCLf6mu/bKChy/N+hd2HTfvDrseB+mZ8gBS68fKGpnk23d+RuKYM7kuKosDqb7tvcw+XN4xpffkyTBxuI+EeBapEKnFUAhoPvadg0b0qmuS9pBeDFzbabLiwUgWxa1bZJDVUVlLsLF24bSH7S8rHOoHYu4GISsTUvgDzfivX8xvvlNHBRwCUznSVsgJkLoijVd/zIhau92LSkXNFI5Rqjq1Q5ArNTfZhn+LWqIkQfs1A1AiW2AVNII3XbDBbhNIkjwsSwyAKnslQyTAw/NaGyUBGxUMkedrwUElxzxSLEOsmZYe6w5x29Mi3uojTyrrPQF8NgW1PNwtB7TLREphHGHquuyCSV0GiCiuP9b1PKYKbwwUqhrEeYKI6D/GZIBUG+akEgDPZRoEhjO8cbJ/1XBeN5hGzthzs5dhIGyn3Uuli9+AzKMtI6oxJJkse0uTYdxWPrRRqFCfT8wlCl6PASDIVx4I9Bl8Wi9Cv66Cv242
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(3023799007)(56012099006)(10067099003)(13003099007)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BHq4D+u+2SJEzfZKqfhkIZ5hWPLEptKCbvv2TXJWULGn2IoufkGClfV/A/agJjzhCI6UR9zHHGN/Q1GmZ5ESjbDvCOeebxiWfRbnZqIEZEMRK1fsvY5TnDcNfaxaH1NHQXgV6tZDjsHJtY9ZR2JdLqhjZ5+BChJyYfKvuMDuicV3Ck6NYyyCCvfSj2677kc8gQ23khNUnJ6Py4YgBNvq2LuYEOOO2p5viy64U778zxZt95PMxNtnMooGn74ECETdgdPvcj9qGSqIx7DFmlJ/bWLB58humlFFXFwx04MSY9UrnPJ7YJCaqb3+AOpMwcaOxSVzQomK5HOgKwwS9h1v1IMgSmvY+7KUpfJtVU7IxZKhQ8SCl5Xx03Rp4fga3rv/9B8f5p/iFXjTUQFTbScqaZ5L1X5KZn22Devd7B1HchXFMkxzyVg3+HB25tBe2nqI
X-Exchange-RoutingPolicyChecked: kcfVLWItnOs9Tu9kZiikkEF/+LOvweEbG3QpZnoG++iFtkBS1ll60HQW5J/QOqmfz+mt+CYdjs1PNRCqFtcSKRsOiFxw/f0GPGGdBNT2KUsDYaeltZANF7sW9/Sr9bOFu/Ci970IA8qzXpRkC4D8WmxvLGcE0x35E+8MrmyY852/Sof29haRhMcAmpudDqsLtPpU5rN+DJR2wMDYmQ/08AM1Li/uorFVNJVJ0jv/NCYc29DUKsCryYj7Xg0sIIjGHzzoAEQalL9b9TqI0e1ZdpTW8DxFfxECG8mJcsRPG6hodNZsT6elR1+W3BTgUTM0Z6zoYCtTTizlbrN2apnxeg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:17:10.2644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d741012-c0d7-4b34-2947-08dee69be116
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8441
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMSBTYWx0ZWRfXwKg7VH8xxXf1
 C0ui1fWUcIMrp0/wudroQMnFQ5NZgOe9gHeALexf+DSmfp9u+ajv/7WAh+Vd3jseCN9NOlp6pVs
 ssnZJBGuthvxefSKOkE+ztar30wY9vfwFBOguas68hyK08z7o3azr6r8af5D5L+z6vZGQvgbNf7
 trGL/qApl1QZkDpjoS/SXJBUUy3+ygq7gemn1aiXbu2yThqlHh0eUMyXW1H7Hez78lephz8qask
 1FH7UNV0WryL3PMSHGc6qulmun4u6L/dpjRkkGP0ng1W+ovcB8nQ/TKR6Efj2mAgdLzCKBimcdN
 +BkhzVtory/oDjYmTk4b6bLBQLvu+gePkRe40z8ppJCPNeZpJHPPSvn63P0AMSMgCcU5EO9Q3x5
 mc9Fc6eFrhRt8gs3Z/UGrxFMAmF9VGslkzb1XVq/Geo+qiOSV0rMcg1JCxHEDKriYeq1I538CHr
 vT4cIKJKWe3wFt2Njwg==
X-Authority-Analysis: v=2.4 cv=I4pVgtgg c=1 sm=1 tr=0 ts=6a5e824f cx=c_pps
 a=Getn/9gNXKMn2yU3BA3TiQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=WtDTEybOK8mIDu76bVQA:9
X-Proofpoint-ORIG-GUID: XJv9R-sqSM3AC-pCSoZRBCTS11J3hPfa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMSBTYWx0ZWRfX1qitz27hpI8z
 STA9dDBFApn7299X+boQIn9nSs5lhZJXsIZl6DOX1CFEflmPUWqi5VyJ/5zU4oTyV0aQ/0RHUz0
 6RZNnNa6gLXcGmQsR/9cSc3ZFKS3vXQ=
X-Proofpoint-GUID: XJv9R-sqSM3AC-pCSoZRBCTS11J3hPfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200221
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnL
 YI=; b=CYbrpgWVCN9XafGG2fgtviVlzzYJ10wHttMZMY7cFmQsjdhQsxGaV3T4F
 n66R+qD9rQbPvdhOUhu3hu12wtaMGKu1AXCPNyDTEjA8Rk8vWRT+fTYc82wwjlXn
 SahRYVXtml+2zPHSNl11F7kjJj5MOj1boS9nSLqWdGtNThvYZybgGBUsmvnJIET0
 MN3jlII7kuP0sUKgJwudbzaSTJe2UDPUezvVRQab9FC1Ajm1PKk7nQR6ELdsi9Cy
 ivMlT1O5k01dQdhWaTwQ6VJRLYV+uBBIZcplsU6LX3Z2xCZgCECP7uPziYkmrB0W
 /3qfGeruHx40oXeXl72Ynk0fYlNVg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
 b=sMBf9JSbQn2duGrE8fy3fbUUMlAiOIMb06h25PltGT67L8D7uhpUEjTcW0TowsKmOGUQ+FzyaAsPXUkIQv2c+fLD0Q/NvOKP7uy+j7APgHjO1WZjVY+HF+04NT87CRrI14DtcETsrBr2+NS703j++hb/JdM4ATPOZhqI5IpTtlM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=CYbrpgWV; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=sMBf9JSb
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
From: Randolph Sapp via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: rs@ti.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Bryan Brattlof <bb@ti.com>

The pocketbeagle2 uses the main_uart6 as the debug console. To get debug
console prints at the R5 SPL stage, add the &main_uart6 to the R5 clk
and dev data so we can configure the uart as early as possible during
the bootup of the pocketbeagle2

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/r5/am62x/clk-data.c | 19 +++++++++++++++----
 arch/arm/mach-k3/r5/am62x/dev-data.c |  5 +++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62x/clk-data.c b/arch/arm/mach-k3/r5/am62x/clk-data.c
index d7bfed0e031c..05cced0b313b 100644
--- a/arch/arm/mach-k3/r5/am62x/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62x/clk-data.c
@@ -3,9 +3,9 @@
  * AM62X specific clock platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -125,6 +125,11 @@ static const char * const main_usart0_fclk_sel_out0_parents[] = {
 	"hsdiv4_16fft_main_1_hsdivout1_clk",
 };
 
+static const char * const main_usart6_fclk_sel_out0_parents[] = {
+	"usart_programmable_clock_divider_out6",
+	"hsdiv4_16fft_main_1_hsdivout1_clk",
+};
+
 static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
 	CLK_FIXED_RATE("osc_25_mhz", 25000000, 0),
@@ -210,9 +215,11 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
 	CLK_MUX("main_ospi_ref_clk_sel_out0", main_ospi_ref_clk_sel_out0_parents, 2, 0x108500, 0, 1, 0),
 	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108240, 0, 2, 0, 0, 48000000),
+	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out6", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108258, 0, 2, 0, 0, 48000000),
 	CLK_MUX("wkup_clkout_sel_out0", wkup_clkout_sel_out0_parents, 8, 0x43008020, 0, 3, 0),
 	CLK_MUX("wkup_clksel_out0", wkup_clksel_out0_parents, 2, 0x43008010, 0, 1, 0),
 	CLK_MUX("main_usart0_fclk_sel_out0", main_usart0_fclk_sel_out0_parents, 2, 0x108280, 0, 1, 0),
+	CLK_MUX("main_usart6_fclk_sel_out0", main_usart6_fclk_sel_out0_parents, 2, 0x108298, 0, 1, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout1_clk", "pllfracf_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040084, 0, 7, 0, 0),
 	CLK_FIXED_RATE("mshsi2c_wkup_0_porscl", 0, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
@@ -336,6 +343,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 164, "clk_32k_rc_sel_out0"),
 	DEV_CLK(157, 165, "gluelogic_rcosc_clkout"),
 	DEV_CLK(157, 166, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(158, 0, "main_usart6_fclk_sel_out0"),
+	DEV_CLK(158, 1, "usart_programmable_clock_divider_out6"),
+	DEV_CLK(158, 2, "hsdiv4_16fft_main_1_hsdivout1_clk"),
+	DEV_CLK(158, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 2, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
@@ -361,7 +372,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 
 const struct ti_k3_clk_platdata am62x_clk_platdata = {
 	.clk_list = clk_list,
-	.clk_list_cnt = 90,
+	.clk_list_cnt = 92,
 	.soc_dev_clk_data = soc_dev_clk_data,
-	.soc_dev_clk_data_cnt = 137,
+	.soc_dev_clk_data_cnt = 140,
 };
diff --git a/arch/arm/mach-k3/r5/am62x/dev-data.c b/arch/arm/mach-k3/r5/am62x/dev-data.c
index 59c95df2a887..ea1e76a8a758 100644
--- a/arch/arm/mach-k3/r5/am62x/dev-data.c
+++ b/arch/arm/mach-k3/r5/am62x/dev-data.c
@@ -3,9 +3,9 @@
  * AM62X specific device platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -61,6 +61,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(36, &soc_lpsc_list[11]),
 	PSC_DEV(102, &soc_lpsc_list[11]),
 	PSC_DEV(146, &soc_lpsc_list[11]),
+	PSC_DEV(158, &soc_lpsc_list[11]),
 	PSC_DEV(13, &soc_lpsc_list[12]),
 	PSC_DEV(166, &soc_lpsc_list[13]),
 	PSC_DEV(135, &soc_lpsc_list[14]),
-- 
2.55.0

