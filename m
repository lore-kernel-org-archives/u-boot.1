Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58A4D5AE71
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 08:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93DC8920A;
	Thu,  7 Nov 2024 09:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="riRlHY7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404EB8904D; Thu,  7 Nov 2024 09:24:07 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F3988C4D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 09:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+QMv9R7MqZteLYb3In6IVd7PzIHdH+YD9/ggcywl5nIbjyz/LJpszB1j/GlDGDXpTgcP4HtBRpUyxyg7/kNAkXCmPl54RUuWecWF4vsz+nDAMwXFatGQcAJFVIoJMgXS28gq9rSeDHB4SKJB4Q1OVOZpQ1UfXrKGUkrWOR4IlO/gxjvhpgb3BnOz+X9FnivwvQT9VW7rMy0fc58gEVGIY+uoNb1sdwDKHNe/ixMLDSlKR3K0hbXamiGmtepSX3Qu2Lri9Vj0oriHJfem/Mwm9qP/mZ5HpC2zE2jhmeI23Gx83x4FXge09qfi5isPupczF47cAqW7WfKyu1SkjdMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/a1p4Vxh5A/kYLejQxqs2fGL/JFUPYLhh8QDp54Jas=;
 b=aCBh3J0plAFvNAlNS+pFrfaZgurX/Nukonq773Pvm34+l4zdgXmtQJWamIiJAQ+C338C4sXOvXCSE9IlC1gJC6ke5H6fvlwsWUacNzYjiNn6LtUt1V5WIdMQTbsnA5ambAFqoRI8+xvj2u3J3017y2HvZXFjNN4Qfgr9jKsNVro3EJzuaCV+imk6MNC2keWVgSUUInKqk3M1jScSf0KO7r52RxVLgQntNB70i6JlyoTfONC2SBskUCuttzQMZdm0XzZJspOmjgBdvlqbZgvSkGbeYkR4eBDZdz0Hg3Q0ri2JlSI8sX6j8g7+rb7cAAbETloEohvhd4heb4lZ3IKgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/a1p4Vxh5A/kYLejQxqs2fGL/JFUPYLhh8QDp54Jas=;
 b=riRlHY7Nwde/EzrBJk05a6D1R0ZyS8cs8YrXfDax64knJ5ZK57gBkYSd1H9+raF7dfz9bAoPJQCzF0b9QvrEABHPzCqHLkRvPphcVs7EMOzYruHYZ3XKch2XN/qpMFP9rVOs+e3eg351IfMrnEzxtu/nqTK5/IWtEveftiKTTug=
Received: from DU7P250CA0027.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::22)
 by DU4P195MB2666.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:571::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:24:01 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::f2) by DU7P250CA0027.outlook.office365.com
 (2603:10a6:10:54f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 08:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:24:01 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:00 +0100
Received: from lws-moog.phytec.de (172.25.32.77) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:00 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/6] imx8(m): add optee node to binman FIT image
Date: Thu, 7 Nov 2024 09:23:27 +0100
Message-ID: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP94LGcC/22Nyw6DIBBFf8XMujSARrGr/kdjDOhQZuEjYIjG+
 O+ldNvFLM7NvWdOCOgJAzyKEzxGCrTMCeStgMHp+Y2MxsQguax4y0u2umPDoadpV1O/rBsiU3V
 ToeVC6rKGNFw9Wtqz9NUldhS2xR/5RxTfNOtEun+6KBhndqhNo4xtdWuev9J9ROiu6/oAOfTvq
 LQAAAA=
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.77]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|DU4P195MB2666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf96131-b209-4b89-871b-08dcff0588b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFZCMzMzazRBZSs2aXRQck5UdTZMUExmY2FiUGVwQUFRK3hCNy9uOHM3WCtj?=
 =?utf-8?B?QmlNM2MrVUM4WkxXRkpmc21EeGloSUsvRHpoTk91TWtCL2sxOHV6S21YK2I4?=
 =?utf-8?B?RFR3V2tVMXZZYU9NRjJ0aUx6VjUrTlk0ZzYvNDRQSEFITzFmSkFrbnI4ZFNF?=
 =?utf-8?B?d3MxM3ZBRzRHbTc4SjJKR2FnN1dKZVZvMndLOVJNdy9yNXd5SzN3QTBISWpv?=
 =?utf-8?B?QWw1UnJTaDB4aXVGZjUwbVlIV0Q1Z2R1WnVZc1RjYVhtb3FCYmxnNDFaR3do?=
 =?utf-8?B?R0FwM2JTbS94VDBwcEpUQTBFRkJwa3VKQ0o3cHJJcUZtMmF3RTMvU0VLZ3Zo?=
 =?utf-8?B?VzUwa1kxb3E4VnA0L0c0K0xYRnAyZXRCbkRsRkY1eGlxMkE2RmErRC9ZWUhk?=
 =?utf-8?B?ZGZpdWNLMFZUdVJqdk53QTF0cWtaN2tzZGI3aXRTdktCQzFJM2VHZjNLOHlx?=
 =?utf-8?B?Sm5iUmFrbzJYcUcvYWs4VkdBajZWOGJxR0NsQmt6eHcwZ0NpRDZPUlh4ZzM5?=
 =?utf-8?B?cFlwQ0Q2Rk1oclU2dGNkRjViT2MySFhZSUtUb1FZZmJMcWliWXhFSERnTG9N?=
 =?utf-8?B?S25UZmNMb0hoQjhYY2d2Mk9qMDlnL2hEekR4eW41bHpiaWtIVXZrL0x5dHlw?=
 =?utf-8?B?T3FoclVsUUtqVnFMeGR4QzNBWTRQeFRWMkNPSGtjZUtuNUNYd3lkd1Q1SzFE?=
 =?utf-8?B?L0pUR3FlemZ6UDFURS9hcU1jKytXdUhVb3U2eGpxUmgrNG94N2t6aERGd1Ji?=
 =?utf-8?B?N2o0a3dyeDFwc01LWEppUzR2dkFMVzB5MS92RS9SWmh3ejVPWnBkNCtjZmx0?=
 =?utf-8?B?VUZSdXRZa21ubEk1UUZwN2VHLzlYSUR0ZzBCQ1h5MFhJZmI5VUlSVHI0Q3ZQ?=
 =?utf-8?B?L3hQdUV6RmdXWmJ2bmxMREpRN2p4dzh6emRSZmhyZ1AyZnQzWDhXTURjb0hY?=
 =?utf-8?B?amdLOVB6Mk05NHB4R0dFcUlIYXo4eG1OUmxMOU9LYjR1UUtkV3g5UzB6azRk?=
 =?utf-8?B?dXA1Ti92Mkczdmd0NFprblJoL2VWNnE2RzlydlVRUjhTRlVQb0xmVlpkdzVN?=
 =?utf-8?B?SDNpM1ZpanF6dlVieXNBaDhnOE5hUnArZXNzNGppWWptckxWMDVUWG5wOThq?=
 =?utf-8?B?MkF6ekI0ekRyamhhWjc0Ukd3WTBrZy9PVm5RdUFJOGRXTE5SRXd4NTRqTE9x?=
 =?utf-8?B?eExEVTVSc3JiN0hWMnVuV2ZTbUpCYzZCbW9QendQR0pOb1dqOXhJZEw1S2pQ?=
 =?utf-8?B?ejVXL2c3ZjU1YTNCemUvVE5aK0JKTFplNEFXOG5vMVhnL2hJWGhBZURJZUIz?=
 =?utf-8?B?Vi80SmdoT1NoYUZmbHJXZkJmZjBBcng3SEk3c0JybzFFbUcxZGJqeEhKMVBN?=
 =?utf-8?B?emVjcXlJdjI4dTMzc2FIMEwyVFFZOUtIM1hRSDBpMmQ1ZS9rQ2FuWGV2ZzRr?=
 =?utf-8?B?WVFOcUNVRzgxSkxjNHZVM1JRYVRKd1JXZExta3dnTnd2R0w3MThnZXlzQXpY?=
 =?utf-8?B?Uk4xMWlVMGtIZVpYWjMzMUlZMVdzSVZ3Z0RVWWhKRXcwSEw5cDhpVC9mcHly?=
 =?utf-8?B?THhQaG9SRDh0YmFSSGxsM2treURxZEtoUzVQZGc2VlhObThOa2lna2tYanR0?=
 =?utf-8?B?UkhkMWpnSHFVUlZaTnJpL0RlbU8xQ0pxUUZ3SHJNZHFrSUhOL1BPbHdYZ2dv?=
 =?utf-8?B?VVVUamI3NGRNV1BkZ2lwYWNmYVFUZVVDVldqeXVFb3RHSy9VM3lCekpleFpa?=
 =?utf-8?B?UVl3VXNYOEtTNmFKZkladG1CYkZmSHZvNVE3SUlCQnpwSkl2SGxCWktMK0ww?=
 =?utf-8?B?UDVRQ0xNQjFuMVRta1ZkYlYxYmtRS3A0K1NCbUY3K3ZQbGt3OVkyS0RlTXN6?=
 =?utf-8?B?aCtxWlEveVZlckM3cFd6MlE4bFkzRDdqSUlhb3Q1NXhmWmc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:24:01.2922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf96131-b209-4b89-871b-08dcff0588b9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB2666
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

There have been attempts to get op-tee node integrated upstream in the
past [1][2]. The challenge is on how to handle the load and entry
addresses where the op-tee image should be loaded to.
Different SoC families and architectures have different RAM base
addresses. Further the final addresses can vary from board to board
(e.g. depending on populated RAM size).
This approach follows the TI k3 kconfig solution.
To be able to define a sensible default for the new config option, put
it in the imx8m kconfig. For other imx families, the RAM start addresses
are different and thus finding a common sensible default is not
possible.
I do not have a working Nano board so I was not able to test imx8mn.

I included usage for PHYTEC boards for examples (with documentation).

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.3921891-1-tharvey@gateworks.com/
[2] https://patchwork.ozlabs.org/project/uboot/patch/ZeHDVr-Bzm935-5N@mecka.net/

---
Changes in v2 (from RFC):
- Use kconfig instead of trying pure dt approach.
- Add load addresses in defconfigs instead of <board>-u-boot dts.

---
Yannic Moog (6):
      arm: imx8m: add OP-TEE node
      phycore-imx8mp_defconfig: add optee load address
      imx8mm-phygate-tauri-l_defconfig: add optee load address
      phycore-imx8mm_defconfig: add optee load address
      doc: phytec: imx8mp: add OP-TEE documentation
      doc: phytec: imx8mm: add OP-TEE integration instructions

 arch/arm/dts/imx8mm-u-boot.dtsi             | 17 ++++++++++++++++-
 arch/arm/dts/imx8mn-u-boot.dtsi             | 17 ++++++++++++++++-
 arch/arm/dts/imx8mp-u-boot.dtsi             | 17 ++++++++++++++++-
 arch/arm/mach-imx/imx8m/Kconfig             |  8 ++++++++
 configs/imx8mm-phygate-tauri-l_defconfig    |  1 +
 configs/phycore-imx8mm_defconfig            |  1 +
 configs/phycore-imx8mp_defconfig            |  1 +
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 26 +++++++++++++++++++++++++-
 doc/board/phytec/phycore-imx8mm.rst         | 25 ++++++++++++++++++++++++-
 doc/board/phytec/phycore-imx8mp.rst         | 26 +++++++++++++++++++++++++-
 10 files changed, 133 insertions(+), 6 deletions(-)
---
base-commit: d88bcd6d247a2b5d1683e393d8c9dc0259cd29f0
change-id: 20240903-phytec_imx8m_optee-8674ef012a36

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

