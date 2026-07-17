Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91B9C44516
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 10:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F6F84DBA;
	Fri, 17 Jul 2026 12:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bfr996G/";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jnd20CZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7578B84DBB; Fri, 17 Jul 2026 12:10:32 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08D9884DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 12:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66H8JbtD363971;
 Fri, 17 Jul 2026 05:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=HpT6Xaz5aV4iL35aJ3mHH6t6L2YDby2V5qkXwngG2
 GY=; b=bfr996G/NoSWQ7fqZK1KdaJ7lumUhKEhqLODR2QzP8ERgPp8lNqZqfSED
 DX1/RaYvafV7/91syEAbOWVHrgwlMQOKvlNgiaNO3qW2gx4R+4ENhChdv19uztNz
 yy9vsWgl1MfbjBhE9Izam3I39qM4ccLoJGh+11/9V/lfVUK2XBygoEtsu2YZzeVx
 4BPB41oWK0yHcdwSrq8FOTpF3XD5nFpVmXBe40IWY4Ykv9M7BTFDL5g238rI+TxF
 BOYLySePChNfzKWOHADIdz+XInxymHR9G1ZPwa2NpBfqd8l3luqoZrXLC11FVxi+
 rxFsMmljYLbEbgsOuV5P6OZV5YOSg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsm8g68-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 05:10:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZdF5x/MZRc3KfBD0EeCfDKDoZbaR5Wyd/W6LJIDKRv+ec80rLYxXskchbaU11Ru2wAD24Wgh1tIrrZbbCPgs29Wu973NM19PS4boC6WiOCKi/Uk49IF2+gFNJ7nNCCA+OPImALJ4LZyf3fAwnDHphzMHbGe07O6K0kk+1tGN85ync2RpA1/wVc54FeYcG6JGBPKUDwj4DunTPrVRs882haqfhZlo9PcBg04pcbJTMfHUY1whxeTYkNSQbhdjkBgzRFpA/RNpAgEInhAIujE1eqeQ9bcFYI8xB0dRLR5Zgn5nYUX1nFCHN+McMcG0fy+EKm0DIjWVX5a/ylHiMfPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpT6Xaz5aV4iL35aJ3mHH6t6L2YDby2V5qkXwngG2GY=;
 b=bqsf3Kc+THqEHZFqmKmDoGPegiCwGvYF8d3sbhucPglf4ykRYawdOLKc5XorrUI+0ADZW4RpqHPnXdKElWioC5VRYJz9c9XH/9zf8ZHWJBI4cfaHH0R0nHlhNHjfKNg3HYC58WYy6RDhhdGLHShF77WoUWYKeGBCPTJuwDnVW+FD4XF8ATO2LaawI6f4q7B+LuqntncdDtDAXjit4v1zpkMt5RXyMsqQq4LWqBJOjb1PH6atmPjaBQdB29GqccWR9gfJkMIynHLDA+zxumgLl8C/CIGnSettEzfaE5l3ADM1C4gZzZK8dz3RsW3E6td9TxgjqSX/JzCaNfbMSaJBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpT6Xaz5aV4iL35aJ3mHH6t6L2YDby2V5qkXwngG2GY=;
 b=jnd20CZJSR8Gh7EUrcnfY4pTF/afLU6Y3c63/eL467Fu+HppBRVMijemw9opBwjEXYZnfnfNKVW6mOU0s8Yj0KEiQaOUrif8w9NmZUdv+VlU2Mq9+QjdQpyFEuKwjF5/tO2yyeYoiMTFsuRNeUw901Do/SLNwecqsZmQRuvCa6o=
Received: from BY3PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:39a::9)
 by SN7PR10MB6570.namprd10.prod.outlook.com (2603:10b6:806:2a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:10:04 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8e) by BY3PR03CA0004.outlook.office365.com
 (2603:10b6:a03:39a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 10:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:10:03 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:10:03 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:10:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 05:10:02 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HA9ves2956554;
 Fri, 17 Jul 2026 05:09:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] misc: qcom_geni: Add minicore support
From: Neha Malcom Francis <n-francis@ti.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
CC: Sumit Garg <sumit.garg@kernel.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>, Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, Jamie Gibbons
 <jamie.gibbons@microchip.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>
In-Reply-To: <20260716-minicore-v2-1-160af559b273@oss.qualcomm.com>
References: <20260716-minicore-v2-1-160af559b273@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 15:39:55 +0530
Message-ID: <178428299564.1171703.15456210253429165016.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784282998; l=1570;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=+S3u+75a6cgyrCT9vvSYcHnxA8smjTkIS5WTc+z2RqQ=;
 b=KADqaUy+eoxTXGnp09DJDNN+XXRFq7PSKMsreTmeXU+6tC9klI1qvTnR7xJ6Kf/7hxpen7/CN
 4jK37coJ74iA3Onoci3qcr/FoZsdcSZbj60jtuxolMPGu9owBqeB0y2
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SN7PR10MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6c2d0b-df51-4bd7-349c-08dee3eb91ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WcyvDwd8gTJwueEAHXZ1TkGS6r20KcXaR9lDX5GRkEskxt80epFS0nkwifi9QkjkHQ7XGQ3VcXcNr/HwtVj8yd73Kgp9IphVZ/5mwL/ymfhcw2FHcULGfR6aQo7zbvJeVOal+xI93STHcJtm0vfSuvOW9obRvCY/Rjdn3tgsXSxQ4STZbk7WAA6Cyt61KS78y2d0zxazaWJT2WqCHNxY/EJDBrZHdOGHXZ5VQxljU96+NJOsVHy+8ucmTibiQXRrSVjJwbJIoOZrsvzZh/Jn6v3D+qQ9w0lYqgfzOtfKjp12YPR2IQLZrESxTXtbgxIooCyJDeBt6IMNTmtOiYLqGlkbMfUnbScH8/liYww/v8tRA/E9L/2xO8l3JkAUBVCTLfbEm7e2Gcxk2jUNrFBVNt8UHgOH0p8aP3ylqPXCv9bOKkSID/J3EEVxQztJ1bwp+g0MPVu9hADWP41kpdH26RCVAnkVS9FmoA4/YL7xTTYoXKHFTS3sdg8vK6Pl0potzRnbZ+Gjba9QcIceiJFIHOD4J76tnic9UMQY3Rsc8UnayUGw6khv/BuRrPq9IXpXUUN2n6fm0bw76cAxBgpQMp5dFpsxwQPTDDCfPlwnqDwd5uqo4lujgi+JXjfpqTr9CxW1XbdQ/rZOoCB7BMIwQ7bSaJ/578yS4Y0oUd3KnRtq2LK51rx8Vkp29gF8+EDy+4R1ySlIRs0+KVWPjPmY9g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MzmJ4vduIyUxQeyor3yydZmoCAMhkrBYMc0WZwC/21cksqOqj/E8Yb3AdOJKDBVPqZsRNDxhavBtqTOSv8ed18QH8+Rqk7bzNLCURi91TKVjnE4USidFHIsZll6o/Kq/3d1VriOG8yWEPhnQeWuTWyXTnoewVyTnZ15izHvtxdJjH1JfZDc+EROJ37OmD4vwyXx9C8S53VPtSRHMY/xJ6WpXtqiloGwNeoAdvxISEZl6am7LUBQWiHGDr2Lvt80GnqxeTMM2qzjtkIDMyvcnbp7rCI+qOQLtbRxEU8gygyZgTjpDULjlgG5xHh1SfdGeUkJXKcNz2SijDHV0h4+zObFcXpP+HatBAMRCDtcCnL+ibVcTkmQ4/fx6jO6X/EOtAuRDwD+lbwDJ9GmdOA5UP+KuGl19Ofgc4zYzVqLNQHGf7jp61jU+s4Zlg2k3TAeW
X-Exchange-RoutingPolicyChecked: EM4c2pd+Zn43Dffazzv4jtkaYRX02ukhsddkIU8HZ1lU86edgjlRQuAZ7iuV0CjpYgNLQfV6w0MLdkBBjY2/NiEMW5lbWAW+4uTXkRqmnScmBroaGmNxvcfLBx2hfRoIIVImL2OkIdVPaA3xqTQiudLSDcvROxbYLxbPV2CmuUX15Mh2s4yozy1wiUsj0j35iQIgAtMlMc7HedrjTHwpPn2a3UTRfyznoxVcyD9+uaS+qZiHAMh1ZzHcsykPMTQACy4y+ZZg1fAWrM+D4f9+rtM5nozAaamc33znr+X4z1d2wdodgGnpyP/yzKvuKKyu21+JzRZbybevHHNWyuVogw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:10:03.5233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6c2d0b-df51-4bd7-349c-08dee3eb91ca
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6570
X-Proofpoint-GUID: O6IgxK4PbWHnx4-ZJpi76Egf9yeVH4aE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMSBTYWx0ZWRfXy36hwqUdGyAN
 r5PjblvfP6MtAEJW0ys6k4m68ILHjigprtsDu5wfRyZ+GaGDEUtlQ1zJqmBW72j/KBCu05tcO2b
 I+N02bBfTNHFFIHBC9+D6VxOcZtkAXncDFpm0YQPyPFHNxOJ91YOSg3q4+bRkAY/Tlzk36JewIY
 E7AvYpY9qV18vaAvryBeSdXcuIH+bDrRY+6PE1W/Wp41LZEEo98Ytd1iC0FDXbdzce38zM0D53p
 e/PJZD4sN0ZTgjhcpzc04G5t/EvcAbbFui+4ba1xzVcuQy9W7CWqqS2Tg1gO6kgRkqKhLTZX6hf
 NxE1T51UoFk1QKVk/a8VIVOUh1HrsPRvOQyv/1ZXYLQhJjCicKUztU7NofRELahMOtzB9PG5sGQ
 1UHi6VghE+apsz3sUdnTtye7WZEbG+h41FK42shxMMuO0TT1lv8pfvEs5VGMYy0K60VioD5ahM3
 PXKohhOYspPqqFRANbw==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a59ff7f cx=c_pps
 a=8jXpZF9zWVkTg+MA9bOgkg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=FlqkdxVrVKvbY2IN6-kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: O6IgxK4PbWHnx4-ZJpi76Egf9yeVH4aE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMSBTYWx0ZWRfX809mQT3B1NHV
 6xDSyOJUmauqjlLKWD294Tv+r4tfIUVHO0urqJ0tgLqMiDhGZ1p8Q1tpmbEzMYDeMCwnFoDqlU8
 dW4BmDAGi9CY5g4Ur6aBVXMjK3UFh2k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170101
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 16 Jul 2026 14:15:51 +0530, Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com> wrote:
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index a62ae6a2478..f3133f85885 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -414,6 +468,9 @@ static int geni_se_of_to_plat(struct udevice *dev)
>  
>  		if (proto == GENI_SE_INVALID_PROTO)
>  			plat->need_firmware_load = true;
> +
> +		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
> +			plat->is_mini_core = true;

Add IS_ENABLED(CONFIG_QCOM_GENI_MINICORE) to prevent accidental NULL
dereferencing in case CONFIG not set.

>
> diff --git a/include/soc/qcom/minicore.h b/include/soc/qcom/minicore.h
> new file mode 100644
> index 00000000000..9f2071ed86b
> --- /dev/null
> +++ b/include/soc/qcom/minicore.h
> @@ -0,0 +1,25 @@
> [ ... skip 16 lines ... ]
> +};
> +
> +#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
> +extern struct qup_mini_core_info qup_mini_cores[];
> +#else
> +struct qup_mini_core_info *qup_mini_cores;

else #define qup_mini_cores NULL

>
> diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
> index a67a93c72a4..df8a615b46b 100644
> --- a/include/soc/qcom/qup-fw-load.h
> +++ b/include/soc/qcom/qup-fw-load.h
> @@ -14,6 +14,7 @@
>  #define GENI_INIT_CFG_REVISION		0x0
>  #define GENI_S_INIT_CFG_REVISION	0x4
>  #define GENI_FORCE_DEFAULT_REG		0x20
> +#define GENI_OUTPUT_CTRL		0x24

Redefinition from geni-se.h ?

-- 
Neha Malcom Francis <n-francis@ti.com>
