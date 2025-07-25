Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06167C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 10:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33598391B;
	Fri, 25 Jul 2025 12:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="C/bBxc9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D47483935; Fri, 25 Jul 2025 12:36:18 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326898391A
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWJ/4F8DazJpajw8MvrcUNp7X6tBznFmbsMWebQzB5B27tpA2F3MN6N0WzO8+UUxUxleOWYMqHpwYP7UOsCOpyPKC7sgns2H8TknBYMOE7yXxXA9IUyqw7yKtUqBO6gwBX9Up3AEWE7QmZBz9Czsk6slRdEwT5072eviBniUSUKctbpMUV+7v+ZaSEZbwljKGysN4Q4XTcGKBU2VP+yymgDEN3X/BnE50+l43QBACiEco0upEsB5A3XuOYEIZmXIzMOQbX8Efqf6O4nwcduxaG9EAwDeZx3yoiNTlt8kZDU3C/S4za//6ZMOOlsWoaeNMwPBbl55gNW9eqA1QvWNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1Nv7FmnDkeh/AUN3F7cAf8sn4ybHBuAcqjXDPRbJxw=;
 b=YYj+YDe/HMyzbopiVyLgsumfkiwR8Ymx7J2okIQWSYcd0/J93USToKxt9EWIJviaZ1wyHhGsqdLh+SLnN30kAg3Iu8tW4iHVo4O9JMvjPEylOrUJIOBHCzQGybtYge4mrLE2LAxkUoGU360Vj+ci6QgaKxRoawtsCqmkQQuw4QL8Hu7qblJYix48bXqgiJS12AxbonyK9ap+1ml2K8aiL0sn9wuY/mrH99cjemVwfOaNwMTZkP1/0Y7LMZ3mWv/iD65loK3Uool03ywVZtkCRIUwLgjLTAmEBOY6gc3Yp0fvJwUX7P76fO6ea+6rsDluDa5ogu1tgx0ZCqMWJj1Mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1Nv7FmnDkeh/AUN3F7cAf8sn4ybHBuAcqjXDPRbJxw=;
 b=C/bBxc9MuE97iQsGNAWMVcyRXKjlAds+rMW5nrnLgBnacuwdCzAKX+/Wb9RilccxoEsWq5R+jIrduhEt8WV3MniShRjIs87K8PFyQInzZ+R8RgzqunTQd//72B3Cneu9aZSCtmdvSO0BuIIxvcvr3Gpat+du61RyxMMjRmBPxETBsHb2asR7AYNxNf2joaCzRNQ0JLWOAbELK9q6IyEjFwh8LawhgQ7mfTTGpIJn+guOgN3Z5ELZi9WGVdMJS0hCqTUCFbUtAr1fJ2Yzqxq4tO0RdP+ZQiPcHSU3ndhUyhtXBZAyyqpOK1h6bxMbeGH+33m1TyLMlELhycn7SZI1Ew==
Received: from DUZPR01CA0106.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::14) by VI1P195MB0735.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:151::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 10:36:11 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::c1) by DUZPR01CA0106.outlook.office365.com
 (2603:10a6:10:4bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 10:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 10:36:11 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 25 Jul
 2025 12:36:09 +0200
Received: from [192.168.2.141] (172.25.39.126) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 25 Jul
 2025 12:36:09 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 25 Jul 2025 12:35:39 +0200
Subject: [PATCH 2/3] dt-bindings: arm: add imx8mp-libra-rdk-fpsc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250725-imx8mp-libra-initial-support-v1-2-d9982df21a4b@phytec.de>
References: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
In-Reply-To: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, "Shawn
 Guo" <shawnguo@kernel.org>, Teresa Remmet <t.remmet@phytec.de>,
 Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, Benjamin Hahn <B.Hahn@phytec.de>, Yannic Moog
 <y.moog@phytec.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753439768; l=1739;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=w+kVhyWXiMC53KaQ7aPurjcW6KYB2FJqu8yABJC38cI=;
 b=vnYxlW47KafHwYmrFqFSfR0h8GlMQxceFkO8TI/maHfe5a7FEnEgOYjmT8fJQvnf7XKys8AC0
 LLwhy1bnOjPAkzd7atWGP6jYiIOUkwjNWhb9ZnXoFrH5UOt67DUK939
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|VI1P195MB0735:EE_
X-MS-Office365-Filtering-Correlation-Id: bd19fd70-0350-47db-7116-08ddcb6712d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0hSbmdHN3VPK3lRNkVmQldJZnNhMTB2c1hWNExOQzdrc0dRY2t1eGgreE1u?=
 =?utf-8?B?aEZwZmE1SE1CSFA2V3cvZCtmZGV4ZEgzL1R2SGdoTE1oelczNDhwRUk2WjM5?=
 =?utf-8?B?R3dKamtCL1hLT2ZkdnNBdmp3RmErSkdpR3B3Tm16cFB2MjZXWmhMa2trUWcv?=
 =?utf-8?B?ZDNTT3BvZ2thcnBaRjhOb1k0cnJVb2dMSU1sQ1lQUm9kWjJHUlhETSt1Qjky?=
 =?utf-8?B?bE44eG1MR210em5BN2drb05uOXpoWHJTb0Qyd0JhOEVWdjd3RUxUeWpRbHF1?=
 =?utf-8?B?OENNWWM1a2MzbHZRYTFaaXFMM1ZkOTBMeXVSeTNUUjRUZEtRdmFIQUdiSEtk?=
 =?utf-8?B?NkZBWXlHSldiVFFjVlorNVNjVzFlN01ndUYyVjQyTVptYnE2enJXSVp0S0RF?=
 =?utf-8?B?bWdIbkFWbUZPL3N4Z09kY0xkYWd0SUJFV3VUb1JMQXh5WGxobDJtNE5rc0hW?=
 =?utf-8?B?azRKdGwzb09uVWxSb0hHTDdWK3d0VXBkRjJKTE9IU2tSeTVwdHlnaFNkNjdF?=
 =?utf-8?B?c0h0bVlSelVLcXFyaU1vQWVMQjB2ZWlVdHQ4STZMMyt1UTJmZUtQVG8ya2Vz?=
 =?utf-8?B?UXgra3kraUhuVHlFRllzMUI2V2dwOFZwTTd1ZnI5aXd3djl6UE16SGxZcjVp?=
 =?utf-8?B?RVYxcFNUcXkzVnloTEY4eWF6eGVRQWlWZmhwaDNWMzRYSGtQZjhJRmVYamdy?=
 =?utf-8?B?QVdvRTBRdHd6bDhTWDhTWEVLeUxpSTRuZWpGbjVvR2tENS9ZZ3NIaWVRb2VS?=
 =?utf-8?B?RWMvaTF2TVFBV3M0amp0TkdFZ1ZKRXd4OUdWK1F1K3dQQkh2ZE1acE1LYktF?=
 =?utf-8?B?Z3lpelZnTGFPSTBsQUVhd1hoY1E0aDRqNFJUMTA5UVViczlXbjRuc1BIQ0l4?=
 =?utf-8?B?b0dLQXlkNitIeG5ORytramNWNzJWMTIyam84S1BKYzBwQ0laRDZmUlB6KzFR?=
 =?utf-8?B?K01xNUl5bS80bHBYdDQ3c3hRbmkzWXBJMDI1VnR6am1DREJmdzFDN1liWktx?=
 =?utf-8?B?QkZYOXk1UmZVdFJ5cytkWm0rNjg0RjdWSmhIK1dscXVNUklITEp1MXJuRkZs?=
 =?utf-8?B?WHF2QW84SklPZjVrTGJ2S052NTE1cVBxN0pOekE4dEFyN1JMeXplQTNrNU43?=
 =?utf-8?B?NzJkN3FISGNXbitmb25qMjVydzE0SWV2K2UwWEduSU00NDUrZ3hQVFl5NVI4?=
 =?utf-8?B?U2dDbkpoU2hRUyswNXZRdWlsdklGR0cxVWF0b04raDlJb29uZmdYMjg0UTA4?=
 =?utf-8?B?ZW5YbGd5N0lFT21FREtoVGphREZxUVljZVUrMWJxZFNrWkl5eVRBb0hwR1FR?=
 =?utf-8?B?R2N0WmFnMTJzYVdpRkxna1Z5citGNEdqbnhGZDczRDJkL0xQMjI1R1VnczBD?=
 =?utf-8?B?Z2tOV1ZJYnFSbXNXaTFISjVjdFZaUGZISkFqa2xDTGtxZFBlQXFYUHdjM0E0?=
 =?utf-8?B?MU1ha2MxNDFFU2dMN1pFenhnVmdqNXV3Tm9DajVDUk0rTmRnTHZNSDlIRWov?=
 =?utf-8?B?TUlpaW9uWkJwZkVXT055NmRrWTZTRVlndDVnOHlhNWZQclJsa3V6bGN4c3V0?=
 =?utf-8?B?ajBNekg1QlAyU1JlWVZ4aFR3Qnk1Zk11QjBrN01iYXRUOXVaVE5uUnVGR1lL?=
 =?utf-8?B?Ykg0YmZWRWJjT0ptYVE2MHJrdjc2WTV4S1RMVlcwVUNCR1ZzS3BGclVKR1gy?=
 =?utf-8?B?dFJQYXNtbll3RTY2V2pMWFhpZXprVDY2QndjNXJXa01KZ2MveVpqUmJHOEYz?=
 =?utf-8?B?eWg3YWQvYXdYanBjT1dqZ29NTUFINEtOTDNvMXNpOXVrc05Sc2JzMFAzVnY5?=
 =?utf-8?B?L2ozUmRSOFA4SVFVQkNyNzJXZG5LZHBBNVRnWHUweUNGTjVtandLTytRSG5a?=
 =?utf-8?B?MFo3am9sUjcrbWY0aWxYTitjMU9OVmtQTWpGVUdmQW8vWjlETzhIMlNOUy9U?=
 =?utf-8?B?WW5jWXMwWEZkbVl4aWZpQXd0b0s0UHhSUWxFKzdKQ1BES0xaZEhGUGRZL0dh?=
 =?utf-8?B?c2Nxa1B6dURxTGtSZkVxQld0UzhwemNjckhuSlQvMmV0S1Z6Z3lOckI3dS9I?=
 =?utf-8?Q?sZFuaX?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 10:36:11.3503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd19fd70-0350-47db-7116-08ddcb6712d0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0735
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

From: Yannic Moog <y.moog@phytec.de>

imx8mp-libra-rdk-fpsc is a development board based on the phyCORE-i.MX
8M Plus FPSC SoM. Add its description and binding. The
imx8mp-phycore-fpsc som differs from the existing phyCORE-i.MX 8M Plus
(dts: imx8mp-phycore-som.dtsi) in its physical form regarding the ball
grid array. Other differences between the SoMs are missing SPI-NOR on
this SoM and 1.8V IO voltage instead of 3.3V as found on the existing
imx8mp-phycore-som. As a result the imx8mp-phycore-som is not compatible
with this new libra development board.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

[ upstream commit: d34db26e9ea504a758841afcd04c73928cd238de ]

(cherry picked from commit 6d47c5101c87b75e08dd2b9233491624306c2d92)
---
 dts/upstream/Bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/dts/upstream/Bindings/arm/fsl.yaml b/dts/upstream/Bindings/arm/fsl.yaml
index 1b90870958a2..22f05e6709fd 100644
--- a/dts/upstream/Bindings/arm/fsl.yaml
+++ b/dts/upstream/Bindings/arm/fsl.yaml
@@ -1156,6 +1156,13 @@ properties:
           - const: kontron,imx8mp-osm-s               # Kontron i.MX8MP OSM-S SoM
           - const: fsl,imx8mp
 
+      - description: PHYTEC phyCORE-i.MX8MP FPSC based boards
+        items:
+          - enum:
+              - phytec,imx8mp-libra-rdk-fpsc  # i.MX 8M Plus Libra RDK
+          - const: phytec,imx8mp-phycore-fpsc # phyCORE-i.MX 8M Plus FPSC
+          - const: fsl,imx8mp
+
       - description: PHYTEC phyCORE-i.MX8MP SoM based boards
         items:
           - const: phytec,imx8mp-phyboard-pollux-rdk # phyBOARD-Pollux RDK

-- 
2.43.0

