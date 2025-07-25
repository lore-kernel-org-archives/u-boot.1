Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4480CC83F26
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 10:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9428392C;
	Fri, 25 Jul 2025 12:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="llIAan7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105C58391C; Fri, 25 Jul 2025 12:36:15 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5958391A
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygZZEv7hp8a7RnrUW315qjTwzBwuO6dW8d33eBw5kJJiuzYN+eoii6jmwakTeBRcMKZ6M9tOSbsowHMwIlINt9EmxFBSwjI8dK48k1BB8RgzVkAAgiR+dmR6AG+MzNeyPzJMciZlNYZ03W3p6ibOFySgjvUH239AkjA174mmeNYqGzXXZV8opRHJ7gkC3WWZu+sWHvEBNTnSEY+lr1EwVF8c+CXCJ+JsyDT4RmQxq968wWwaLgtR9wY694gdatODx/FzyZZt/20A2GlIhT/Dv+o76Acy7JZ8zjbnjJdJAMqFdQK85S3+JiR2KlcLSDgwX6L5URGFrkdk2UREXLT3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk8kaqtWIWVHNaymXr7FWXA5HRQ8I02fBacNbw+wyQI=;
 b=gR8tTEhlUif4K8UqbItjlDEI2yYy42i+NqBnkqgFR6CxfpCiR1SMDdfdMD3Km+ewkCm1OQ15x1l7rlQuRdLAK9nIRtc8kTbXMdISRW65IvT7XIkyQXeDdYeOmYLZ4WiFC+cfoa+jQwQQxPc9K7iFV+IrsqalaD97tTJXhivn/dTj7gG5yXvScnZOnzWFeMPXlgF/ai9VA8mi9O437orHV6XfUTbL0s84RGUvpoEqVDasbz4WV0os9VkLxOzAHTwN7PsktEby8j6X7jMcKdr/GKbkBT4MZpRmYktqls1/9PqEXv88hl1lNsasG/Ily3SBnoLr1URboQCTDxpI2PI2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk8kaqtWIWVHNaymXr7FWXA5HRQ8I02fBacNbw+wyQI=;
 b=llIAan7yjjGJw8+gvxVwJYzv/4808N0Mb+9P5vMWW/JVt63NZ+Qy/9oDmXpUxVRRYdwrp3QRNoyeUXStFW2u6u+xIuxrrlfl7uSpJXHD/0Yu3FYnIZVPUl9Mdvqc6YfOw37mzJ4noG9LKm8sE/6bJBRI/l2tELU5whRpuD9ncx+A/LlbqI1JJOzoG4XaYeYYsGSR8J3+ftgYklVXXNitEWoy/PrRuZF1Vf1H4vNTnikS6Q9RIH6DfGPfoSfDqHCiTJ4QNGqSV8yJPbbOzMVK9/zTm8DqP3E6cEbwGulJytaW1dsk2eae4h4RA86c2OcqCQmWFSdREEcXv0P87LZ4wQ==
Received: from DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) by DU7PPFCFFABFA07.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:18:3::be7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 25 Jul
 2025 10:36:09 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::e2) by DUZPR01CA0098.outlook.office365.com
 (2603:10a6:10:4bb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 10:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 10:36:09 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 25 Jul
 2025 12:36:09 +0200
Received: from [192.168.2.141] (172.25.39.126) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 25 Jul
 2025 12:36:08 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH 0/3] Add initial support for imx8mp-libra-fpsc board
Date: Fri, 25 Jul 2025 12:35:37 +0200
Message-ID: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPldg2gC/x3MQQ6CMBAF0KuQWTsJjoDVqxAXRab6EyjNFA0J4
 e42Lt/m7ZTVoJnu1U6mX2QsseB8quj59vGljLGYpJa2vkrLmDc3J54wmGdErPAT509Ki6083hp
 xcnFdCB2VIpkGbP++fxzHDxsRqppuAAAA
X-Change-ID: 20250725-imx8mp-libra-initial-support-d94282386ff6
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, "Shawn
 Guo" <shawnguo@kernel.org>, Teresa Remmet <t.remmet@phytec.de>,
 Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, Benjamin Hahn <B.Hahn@phytec.de>, Yannic Moog
 <y.moog@phytec.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753439768; l=1450;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=BQnUKdKc2n6e0/RIZxVWKu0+npa8e1PcIxrB62PVYf4=;
 b=5lJ0eZqVDLlpxFB3L37cJEN3PnebpdsXw1BO/NSgR3OJ5I0FRAymN3odY71THMryjlJz1L3IU
 A+UD3kgB83RA/sNZhuPp60BpRjzmMqK+0mxi0krHpxwi4EnQ1U/FvZI
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|DU7PPFCFFABFA07:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abe2216-f544-41dd-a097-08ddcb6711d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmlpMW1hWCtJcG1GUStaSTdqK28wTk5aRTB4WlgwQzAySUt5UVdKZmx0RmJC?=
 =?utf-8?B?UTJPR0ZQSjg5Nmg2RHJkTDMvQlZTYXRkYzNib0NEbGE0MWJnTHFLOEpHUWhq?=
 =?utf-8?B?T3BteU5iN0xUS3prK2JEV2lHZDcwUXc2RFpQQ0hCbmlwejFFQ2hMRnBXNE9r?=
 =?utf-8?B?QktxRVNRN3lrMDA5cFQza2dPM0RrdmpwNjBDK2RWekh0RzFWSkJFYmVySnJx?=
 =?utf-8?B?VUJzc1VQeUx2Y3dJUjVYZU5TdGlSRGlJMGtxVjFjSGorMDUrUk1jbVE3NmYz?=
 =?utf-8?B?aXAwcHg2NkYxRU03VFNoV3lzYVpOZjZCUEdPT3p0UEV1YmNlYitlakU5bE5D?=
 =?utf-8?B?NEt4d0cxTnllUEpTL3NEc3RPUldLNzB2OWtuUjByUU1Bd1VCTk5YaHVUZXJr?=
 =?utf-8?B?S0lleExwZ2N6aW5Lcm9OdmxRd3drQWNSUWNMY0dXUlNMSmNzREdrVWtmTWQw?=
 =?utf-8?B?VDJiTHVyUGk4L2cvZE5ycVZkS2puMlJPaER5VDEvQUh3VEI1SEdrSnlzeStU?=
 =?utf-8?B?QXJlaEwyTHZOTlRxVndsZkZLMFFFemd1cHcySU4vNldydkNPVXdZNzlMSXkz?=
 =?utf-8?B?TTdKMHBUbCs5Ly9JT2lIVHpZUGpDOHFpU0ovTXZoSEQxWEdWU0dIYTRsOEx5?=
 =?utf-8?B?bUt6MXpRVVI2T0ZQYU5Kc25YWGY3YS9TRUpVMysrcml2NHhOLzFWNDJsKzhp?=
 =?utf-8?B?VGRrZ2VHdHAzQ3FoMDRtVEFRVVlOeVZpTXRLRzVXQXZFTW0rWlFpck5HRGJh?=
 =?utf-8?B?Wmd4QXlJQzhDRzVqUE5Bcm9yYk43QVJWZVNieitXYWV0d3RZSjVreWxXVlZ0?=
 =?utf-8?B?WEpNTVVieVRtczF0eStQOXAwSERCUEFkU3BHQnIwRUNjMDNIY2VMdDJLL2pU?=
 =?utf-8?B?NUtKN0Y1TWdxS1EzclUxbnFMSmYyYlVZaTNhd0xDa3V0VjYxUDV0UmpISG5x?=
 =?utf-8?B?ZURCN2lFcUo5anRzMnJvM3BkenlaaFAwZ0xJanFKMmZYMjA2N0ZMUm5iTlVh?=
 =?utf-8?B?N1BrR0Mra0RKSFpWQVloZ013WVJqSTlZemJZWTRxR25BV2ZjRUgzODhhNEFo?=
 =?utf-8?B?amtheldVeVZweUhIbEhSUXdUMi9jMThBckp0d3J1dmRIeGZjVmNpdndKWGp1?=
 =?utf-8?B?QVRuMWlXeEIydG5ZdGlqcm13dlQwa3VyWTUxalM4TkF5R251cW54amQxamY0?=
 =?utf-8?B?VWNJTi9JVXNnaFNVNVNjZ2pLK3lOK0VpdHZmTHZsalJ6bUJxRVVHOXZpcXFp?=
 =?utf-8?B?OGFMMThUWmROK1FaZ1JkaCthVUlzVm1qaWJLcCtKbElHUU1DdXNQMHRSSlFJ?=
 =?utf-8?B?YzVmMG1uMEwrRG91RW1JN2w2NDVhdGttRXloY2gydlFKVFpxR255eXVtK2k0?=
 =?utf-8?B?TUlDellvSlFuM1czU21pQ0lDM3NVTTB2b2p1d1ZiZXpUdGV2c2hreHJ2MDNC?=
 =?utf-8?B?RnVhTEsvLzV6VXNvc09TSEZnaHVNdlVSdDJFTllUOWRjZ3l4eCtXTk45SStK?=
 =?utf-8?B?U0M1UGJmQUxuUExoeUxadEJpbndZNWd0NXp6WlFKWGNIdnd6RzVGbmdNSE5w?=
 =?utf-8?B?a0FkOWt5Qno2RW9OT3VJZndMQ1hQY24zZ3FwT05NY2xENjFFb3E5SG1Tc0cx?=
 =?utf-8?B?UlNra282RlgyWnRrcU1yTEwrMElraDg0aEFxa0pEOHlYNzNiM09FNHc1MlJE?=
 =?utf-8?B?emdKdHVqeTRQRTdITWFteWFFbmtlWmkzZXZBSFBFZmlLRHd5MVhFZExIbFds?=
 =?utf-8?B?MHY2a2hKT0Z1aThLWnBHTE1EU1Z1TFNwZTZWdWZSYk50SG45cE12MUd6MUpp?=
 =?utf-8?B?R1lEK0VtRE1lQ2dVZ1VBN2ExWWIrazhnY25MRGV0WFRyYTJJbExlbDBma0xL?=
 =?utf-8?B?WndDSEJnN2pVRHJoNVdmUmFtd1orR09DOWZpaDR2Q1U3elNYZVFKbEh2cUJD?=
 =?utf-8?B?QkVia01nbGZCTVFkMUxVeFhMT0xzK0NPd2o0bm1KU1FKRWlDblBFeURSbG9w?=
 =?utf-8?B?UmYveStVRWZiSWppdkZLeFQwZ2lwd1RMa2VHNEZ3MFp3WjJZWHJDOC9sWU9T?=
 =?utf-8?Q?pl0eya?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 10:36:09.6878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abe2216-f544-41dd-a097-08ddcb6711d2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPFCFFABFA07
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

Port upstream linux kernel devicetree to of_upstream.
Add support for imx8mp-libra-fpsc board.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Benjamin Hahn (1):
      Add imx8mp-libra-fpsc board

Yannic Moog (2):
      arm64: dts: add imx8mp-libra-rdk-fpsc board
      dt-bindings: arm: add imx8mp-libra-rdk-fpsc

 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     |   78 +
 arch/arm/mach-imx/imx8m/Kconfig                    |    9 +
 board/phytec/imx8mp-libra-fpsc/Kconfig             |   16 +
 board/phytec/imx8mp-libra-fpsc/MAINTAINERS         |    8 +
 board/phytec/imx8mp-libra-fpsc/Makefile            |   10 +
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c |  114 ++
 .../phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env |   30 +
 board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c     | 1846 ++++++++++++++++++++
 board/phytec/imx8mp-libra-fpsc/spl.c               |  131 ++
 configs/imx8mp-libra-fpsc_defconfig                |  170 ++
 dts/upstream/Bindings/arm/fsl.yaml                 |    7 +
 .../src/arm64/freescale/imx8mp-libra-rdk-fpsc.dts  |  290 +++
 .../src/arm64/freescale/imx8mp-phycore-fpsc.dtsi   |  796 +++++++++
 include/configs/imx8mp-libra-fpsc.h                |   27 +
 14 files changed, 3532 insertions(+)
---
base-commit: 021783860f7e628f7c4e0c101707cd4250e6d61f
change-id: 20250725-imx8mp-libra-initial-support-d94282386ff6

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

