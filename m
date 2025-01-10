Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ADEE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 12:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2508036B;
	Fri, 10 Jan 2025 13:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PllmsDH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DCC800D0; Fri, 10 Jan 2025 13:36:08 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7DC806E8
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmCmE414Oyje4evnVa4XjHJ+s10u79gqpj1j/Ho1jDwtY7Zh5rZuu2cvVtJTMCnONKfnoBlbUDN7siGT6x4fy3EAQLb4UiJZ9g0CmhqGuJpJ/fMR6brxs+7VJZWE6+/9OKgP/sOmRm8pp/2+jubmaVUOOBR0jJjQq4cUoAGaLYoTwBHCNYtqNGZIZ/Zt8jOhCXNC3GzbzGxg+VOGUOM85I1w/F4amrX19Gtl2IR5i4IX45TjHvIOQvAbSWaYFfAXjveCVvltwLB/YmjZwD7TXt67ODObH88MBFhi5kdByJDCO6QRXNaVwAKYO1g5Y8lfHtDSqjrAbLy7v31oLy1pGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTPCwmTn83EjYgV1F+7lYvZOSpbwjFj018ZZbmaYmLg=;
 b=vTXR5olE5tiK8Uoyhu7wZFVxBQgiv5/H9KarXgnAbHMZcDCZVQoKAitc/i02Pp3YlKgoAs2Xa1IPPOvf7NWXA9I2JzYbA/QFEXLiKKFBwkBib5W0Kh0kOYANuUXovb36mJHSeokhkEr/Yt7BiqpLvUouKcJm3nWdui9CXm6CjiZBPlSb/Rsv6CnPV4jZHN7dBOZt7mq8P7nfFoJrv+DilBscRGNKO+oGQ1xkOOlo+LKZHoelPYsziI726pTKXPZyl9RIZShUY4aPh1BVPbL3cBhv5eyQ9ZLCZW8Qg0s7r16T22bob4iaAl44blNi2sFnNgcDb8pa7GjTaeNZYJxjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gateworks.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTPCwmTn83EjYgV1F+7lYvZOSpbwjFj018ZZbmaYmLg=;
 b=PllmsDH1WQSjb74rWi500d8WOwGK/emAOqPneemcM/XH7DuxbHnrT4povOhtYgH1hNID2XGLteWH5RDUxKPlMJDvn02fQSHYyW/dBVHKcouHTIpJdHhhH1Jk4aP/uMon2oBQKk6IA5tuZJ35Sl3arF//uyW+I3Ldsex7sCjkuGyp2/xo/AZOPnWfd9093NxUt73wl7Ww5raWnXcAM7K09pehtnjON0Yr/3LtXgrz3YLpoVIn52DG43+3wZv7QgoMouEDpf+ZozT3wPF9TfkF8gf39Fo5zYxl6+F4sFN/9g5HpP5OfhG8ULwRAMBQbRaNsF0GJW65fjckshMmXeXGvw==
Received: from PA7P264CA0142.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::10)
 by DB9P195MB1778.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Fri, 10 Jan
 2025 12:35:55 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:102:377:cafe::af) by PA7P264CA0142.outlook.office365.com
 (2603:10a6:102:377::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 12:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 12:35:54 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:51 +0100
Received: from lws-moog.phytec.de (172.25.32.31) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 10 Jan 2025 13:35:37 +0100
Subject: [PATCH v3 5/6] doc: phytec: imx8mp: add OP-TEE documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250110-phytec_imx8m_optee-v3-5-6c39dab15592@phytec.de>
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
In-Reply-To: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.31]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|DB9P195MB1778:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e3b104-b3b0-488f-a084-08dd3173537a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vi9FRWRzSkp1TzA1N3F3b2tRNW13VWx2UlZDc3ZVTE9ta254MDJJaW1pbXB2?=
 =?utf-8?B?cm9EYmgweFViNC9OYkpjRll4K0NBTVVNUEQ0WnlyTEVyU1VhbVUzSG9mL3dv?=
 =?utf-8?B?bWZ3bmxxUFliMEozYXB4MldTWEFhUjJsWUUzNmRUWExrRXExcHg1Uk9Pcnox?=
 =?utf-8?B?WXRmK2l5ckxpRWhTSkMxdmVLOEs1Y2pGOERJTEhTai9ZSHVJM2Rkem9pUWZI?=
 =?utf-8?B?RTk5M3hZZ1ZHcVNqTUFsUDFQWGhDdUFCL3o5RTZRbGpCdnpEQXRuVWpoZnBB?=
 =?utf-8?B?OFRGdXhuUzRaa3gwS1RnNHp4ZG84a3Mxck5UWGE5cnFQSmsvSm5ZbjZ2dVZD?=
 =?utf-8?B?eXNNL21OY29UWDVoQXpKYlJ3UVRYdDYycnppQURCK2huZ0xPUjUvYXlySktS?=
 =?utf-8?B?NjNyblV6aWV4bDRyUWUyaDJqL041UWlucTZyeFBFNWJHWWRWbDVqc1FWL2Mx?=
 =?utf-8?B?T0dxMVdHRi9vcmVPNmJyczRpanA4YUM3emZIbFp2VXdqYk9sdXM5WW9LYytU?=
 =?utf-8?B?TjB0aHJzdVF1NHJEQVBKcjZzNlhnTDJ6WlB4a0FrVjd4Z0NkQnBGVVZ0OU5D?=
 =?utf-8?B?TmdwOFB1L2hFak0yMjhpYVo2NUZFd0U3OHdVREhmSUx3MitkRjVaVE5WTm96?=
 =?utf-8?B?TzcyOEZxNFdIZDFuQ2ppaUxtT21VNjRhRkxjVzN2ZnBhcFlnakNWdDF5K1dT?=
 =?utf-8?B?d0l1YUhrNExtbDN4MFdtY1VSd2VoRmRwcUNlb09GZnkyUklYV295Q0ZZcTJP?=
 =?utf-8?B?YjlBUHExSDExTWlGQ2pHb3A2RmMvNEVPOUxxNDgvdndqV2ZSV1kwOEF1eE0z?=
 =?utf-8?B?M20wSDhFWGJZT1JwMTdRZ3RJVDJBSzlKRWVubFZDODVpZjd6aFBGUXhkNjJi?=
 =?utf-8?B?QXZ3TTdDRHR5ZlhGb2FNMnhsdmI5ZkJaK1N0eHpXamZCelQrNnd5eEJISWZM?=
 =?utf-8?B?ODNLc3c4akxSVGtUVmhlanVPUUxjR0k3QWUwemtyVkUzVzhGRG80eEJpM1lF?=
 =?utf-8?B?aG96WEtjMjZ5VVE5ckdjYld4ZXE3Q2M1OHJpNE0xSnd3K2o5TlRKT0xJSXpX?=
 =?utf-8?B?MC9qcE1qcnNpakNiV1Q5aWRYSENNLy9tN0cwbExzeXlDM3YwYUFsWkpZTmFk?=
 =?utf-8?B?b1d6Q3JMSFZyMis3VE9Kb290L3pydFR3Yk9rQTJwY3pxMHNJS1Z6Qmlxd2JS?=
 =?utf-8?B?NytSQ1ZsQ0h1VFJLaTFOeW1kbnB6N3R4WitoSy94NTBOVnhCUFZPWlJnWDlZ?=
 =?utf-8?B?OE5IUGRQOFgrTGdLa09NUWlHUjZKSVUzd1JMdmh2L2dqSEdUalRKTFZLVS9G?=
 =?utf-8?B?dGtkbGFTUk9NaHhHUmxTL1JpbFNSclM0MGpSdExRSmx0NTMzUjNlVlUrdm0x?=
 =?utf-8?B?YUROaXVSWHUwK0VCRGtqQVBBMjhVNmIxaTdyQXBVdDgrdDhhWkpLR2ZJYnZP?=
 =?utf-8?B?cDMzSk1DSHJ0dFdHa2cyWTd4SFAwOEp0bklPTWVxUW9MMkllRW1iK2FuNmIy?=
 =?utf-8?B?b2JYZjBzTEhwV3RmVHBPSE9zVjhURDdVWjFkWFE5U1RnNHVFZGRQQWZTVUpw?=
 =?utf-8?B?ajdEWG5ORk9OWVdjTnNKd05rWlNEZGhWakN2MVJYNW9ob2NhSzZiY2tpYmdk?=
 =?utf-8?B?R21JVnNIOEtOclArM2xodGVTSUFxTld6YktzY09PYWFlTDBvQm43TEp5UFZk?=
 =?utf-8?B?V3pRRS9POHMrek5UYUhuWnF2bUlHMGZJOWhlREc0TFZqQ0NqQVYrNmtlY3pH?=
 =?utf-8?B?LzRrYm1yV3BLMDQ0MW1pQWNUWmJ6U2c2UUY2RkRJeStHRUgwODV6WUNaS1ll?=
 =?utf-8?B?eEloTExKdTJSYms3ZVFJZU95b2Jjc01XSjFOTS9idndsY1RQNlpXdUpEcDN4?=
 =?utf-8?B?c0QzVlV5MGxNTzlmRlZTeXY1VlVWOTlQNUx1RUhDcTJUVXp5YmdaRjZkNC9q?=
 =?utf-8?Q?miE/UehH37E=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 12:35:54.7711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e3b104-b3b0-488f-a084-08dd3173537a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1778
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

Add documentation for the phyBOARD-Pollux i.MX 8M Plus on OP-TEE
integration.
Also add missing '-' to TF-A build instruction while at it.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 doc/board/phytec/phycore-imx8mp.rst | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index fda751aeffb..50be9912653 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -9,6 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
+- Build the OP-TEE binary (optional)
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -20,10 +21,26 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30860000
+   $ # with optee
+   $ make PLAT=imx8mp SPD=opteed bl31
+   $ # without optee
    $ make PLAT=imx8mp bl31
 
+Build the OP-TEE binary (optional)
+----------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CFG_TEE_BENCHMARK=n \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     O=out/arm \
+     PLATFORM=imx-mx8mp_phyboard_pollux \
+     CFG_TZDRAM_START=0x56000000
+
 Get the ddr firmware
 --------------------
 
@@ -42,6 +59,7 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
    $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot

-- 
2.43.0

