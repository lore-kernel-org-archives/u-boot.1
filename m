Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10936D0BB66
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2706089333;
	Thu, 24 Oct 2024 09:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="dBNOAacD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A43D989349; Thu, 24 Oct 2024 09:04:27 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::712])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698078932F
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8hqPjov0YmeHtjkkiY+wIHzVk7tuR4DR4vzG5VGwK6/eh2nYLiDb5QE3n1+y+5xWj4s1yyyfW7HZAtb9QuMfOlKA1RISwyN4GDf2rX9NiMisYhWcaqvUEaHm3PQ0v04CDFYgxycSI3LFNKqgG2cycj3WuPkw1ttogtcRUuDCzP1oDKlyhSAitcxEWM70nMh19KJIdF+BY5mFU4LwQoycQXsmz/NqEoEelhalYVpNaBbED3Bdudw26N+FTkd73qsVZsJqCjd5pxVPwTKvLNjhoMTh0/3M6/KLVWV4dz9VWZGfSUnk2IG9YVg1cLnULgvEUKtrN6bfYnWOUyqSLHKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ0aBXsv/GB4nromjqbeMvRAHbJbsV8rMBvnhzvCOEo=;
 b=oAl9HmeBg2RmSZMPuuSOPKgu1kJldC07M9PYgGSQKLbV92UfwAXPcCrkhvEpAsZ7xzt3So5Eo4xMa4NFfP/7NtJ7PWpvvlgGt0fuZ9Ce70QcYVv3F9GEiUWeNcAV2i/n/8QvNsqBUWLGJI+fwBdfi9oBF8S/GNw5FBc8jCnw3oGMdCJqGWl4ciux993bovSgdSlExZypOoVYTy+QkiHjfVa7zX6uCJsoE1L8m8JA+Y74oKGxWbcfuBPoVNoIy0+6NS4hX8jV09Fp+5wBWeYmg+JR/WquCyn1D1+g2ELzxZcFpqdvbmImbtwjexxwJumwShXT+7A5gAY7/xgER4k1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ0aBXsv/GB4nromjqbeMvRAHbJbsV8rMBvnhzvCOEo=;
 b=dBNOAacDB3kIc7maJfEYXeW31oiGszhOdvcIral3WTnLsSxWcgRoQA6cW4nZjfp3bhZkszfFuPVPaU/4ZlfdPWLaFekDeEWgpV4XbUT3hlDEVfQfgLubwM1AUUbbPYlkDUxiJmoV3Rr3Z05QhAWfPEcbnF95T785ewhvGhkByyA=
Received: from AS9PR05CA0354.eurprd05.prod.outlook.com (2603:10a6:20b:490::30)
 by AM9P195MB1139.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 07:04:15 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::44) by AS9PR05CA0354.outlook.office365.com
 (2603:10a6:20b:490::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 07:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:04:15 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:11 +0200
Received: from lws-moog.phytec.de (172.25.32.62) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 24 Oct 2024 09:03:39 +0200
Subject: [PATCH RFC 5/6] doc: phytec: imx8mp: add OP-TEE documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-phytec_imx8m_optee-v1-5-fc6b78bf9a9b@phytec.de>
References: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
In-Reply-To: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "Simon
 Glass" <sjg@chromium.org>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.62]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|AM9P195MB1139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc72324-4a8a-48a3-c1ce-08dcf3fa1217
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFdsbUZ2Z1A1cFczM1RTMktNOXIxOGQ0UE90UExIUEdTdy8vSFB4Ty80Zm8z?=
 =?utf-8?B?SmRhQW8zMzkzOTgvLzYyd2VBRjlQbVBWOC9zQWpWY1lKdWtxUlg3Y2daNTJQ?=
 =?utf-8?B?Q1dtMk14aHhqNExURmhxTk5hMzNQL2F2V2M0OWRrbytHZUZnYS8zRWc2Z0Yy?=
 =?utf-8?B?UGFNK0syWS95b3hoeDVoUzdrdHNsMEQwV0lob0NFTVpscllnYTdXc3krUEN5?=
 =?utf-8?B?K2p5MklSbkJndU1IYXVBWEx2V3lUS0tBTFF6YXhqNWVzajJHWHZ4ZGsxOGNs?=
 =?utf-8?B?VjgwV0tiN04rd01Qd0pCQU95anV1ZXRDWEJGWitIbUNUOUZyaFQrWDRzZVg0?=
 =?utf-8?B?T04zWlJKejVRUzJ4Z255cGlDVVplYk5UdWhCU25SRTQxbHgvN3BTRnVhbnRN?=
 =?utf-8?B?MkdyWXNmd1E1dHd4VE9hUmwwcDJvbWorZkJlak9RbHVVaWVHODE0RE45R3Nw?=
 =?utf-8?B?c01BMURzRHNKOXNxSis2Q3VwTTBKOHlxQlh4Qnp1RDJtWEgxd3dQSDNnc1Rl?=
 =?utf-8?B?TEFjMVBpWS84emEyVUNSbGhIbVRMbTZGUjBoRGljOUVaWE9majJnQUFmSjAv?=
 =?utf-8?B?SEVFcUxIWmVjcUt6NXNZejU0NHZhVUNxdkRHU1ByRHlidTc0NlZjZW1DOGRM?=
 =?utf-8?B?ak8xZXE0eEl4U0kxdHBHVWlYaUJKU3kxMU9USUdXbEZHSFBkcDFSVE1zTUtl?=
 =?utf-8?B?eFE5L0UvS1lMS2RjSStZOVJMWFRZbHAyTk1hdXVoc00ySDNjNHhvbnNyV2Jr?=
 =?utf-8?B?MTg4bXJYOGRDRTJMeU42S3lHblNoTDNpTjZ0VTd3Vmd2aWErR0M5eUhkeC91?=
 =?utf-8?B?NFZpQnBQOUtDbzlOemNXL0xJeVh1TDdTZjZnK3dEWmpXZ1QydHJ3YkVnbzh0?=
 =?utf-8?B?Z2JqbXB4MkFMNHBpbnlicmxzUGM2NCtXS1g2YUk5cEdXWEljaVR3RjE1SlhS?=
 =?utf-8?B?cHlDWVRrdEpCUlIzYitLYVFWOUdOcEtTRkgybmdNdVY5KzlhTFZnQnBOWGRB?=
 =?utf-8?B?bFFmVFYyMXlsWHFWZmczaXVSOHA5US9ZVVlLSFZ3V3hkVVpwSTc3aWRUc1J4?=
 =?utf-8?B?UVltcVpsUmxtcjlsZnRLSlRkTkh2NTd2Z3p2aXJmdlNteDljaUR2b3BmWUlW?=
 =?utf-8?B?U25BQkJhbi9JQ2oydWVpcCtaYXJGTCtidkUvUHhEeG5xMUE2MmNrbHI0bXJH?=
 =?utf-8?B?alVxL3dkSDc3QUVuZ3gySUFQN1JjbE80bzQwT203MGp5TC8yZllWUmhEazh3?=
 =?utf-8?B?REFCQzN1cXNHcWE1dWxJMDJwZjRIcXluYk9xK1lLdFFRS2JJUy9Jb05pNFNU?=
 =?utf-8?B?aWxhMnVNZ1dNR1E1K245aTF1V2Jkc3VUQ1laajFLVHdYRU1sUkd3Z2doa3g2?=
 =?utf-8?B?Sk4vaWhVc0RFNHc0cTQwbTNpMXNoYUpPeW14cDAwM3RwNEsyQ3VDK1p5U0Fq?=
 =?utf-8?B?Wk9rcGFFYklRejVHY2hZd3pGYkpnSlR4QmYzOVA2aXF4RkQ1aHFWSittcU1U?=
 =?utf-8?B?T3ovYURQOVFhUklWVG9IRmNJanZoc2ZvWFdQZHhPYktMR3JVWnVjNzMyT3hu?=
 =?utf-8?B?M2JKbU04Q0F3Sjg3VWZ3dzlGczJINndJb21BU1h6TjNGT0VRU0xYMGNKcW42?=
 =?utf-8?B?SDVrYzc1V3pDQTRHUWl3dXpFZDZNS0V0ZjBTSnFYNytLY01VV0JncGRlUWhM?=
 =?utf-8?B?a3Vma1pjRG8xQUJVWktQZUtwRkNoNG1NNFhyUDd1RVpPNk0vT3lSeVR3ZE4x?=
 =?utf-8?B?eEoxN0dnNmM3bThvUmpIYUFMMVJXQ2UxdG81TldzUDhLMVlENWtDVVZnNEtI?=
 =?utf-8?Q?l1CrSFNNmbRMMed2ay5qHuOCmr9gOBIkYUk4k=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:04:15.0375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc72324-4a8a-48a3-c1ce-08dcf3fa1217
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1139
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
 doc/board/phytec/phycore-imx8mp.rst | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index fda751aeffb..4bcfa9f39ca 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -9,6 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
+- Build the OP-TEE binary (optional)
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -20,10 +21,32 @@ Build the ARM Trusted firmware binary
 
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
+   $ make CFG_ARM64_core=y \
+     CFG_TEE_BENCHMARK=n \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     CROSS_COMPILE_core=aarch64-linux-gnu- \
+     CROSS_COMPILE_ta_arm32=arm-linux-gnueabihf- \
+     CROSS_COMPILE_ta_arm64=aarch64-linux-gnu- \
+     O=out/arm \
+     PLATFORM=imx-mx8mpevk \
+     CFG_TZDRAM_START=0x56000000 \
+     CFG_DDR_SIZE=0x80000000 \
+     CFG_UART_BASE=UART1_BASE
+
 Get the ddr firmware
 --------------------
 
@@ -42,6 +65,7 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
    $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot

-- 
2.43.0

