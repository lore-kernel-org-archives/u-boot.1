Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF60CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 06:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819868329B;
	Thu, 18 Sep 2025 08:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="bSHIx9kh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2813C83236; Thu, 18 Sep 2025 08:14:08 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0666A82F14
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 08:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QopUPHqRF1VJZLWr96YuLdMf9Z9pEAGAudPc2YyPnFcuXGKqOYBUnwRIFx6p8+NT9tt+xctF6fqe1n4cdfqmytzvUqB7mS4y2xgwSoqEvgwz43ygh718xHppIT91jC+1sfPvmA1CB3OsqeNE/kvMRrcCa5w7OeGBEIFok4ixhlJv+kfK+BwDv69FpSiQnW34dEC2l8GYKHl1PfCDFt2v/ta9Z1R0/MwblxSk2GfttLyij2BqOEUqc1p4tCktI0DBKxiMOlJLij5L0B5RWPMLpCNtJccX5vqyZcpJduFaNYL+9en83c7tU31Azx9eYJJHb7Cp6XE73li2qww4Wq8i2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO7qynMSzcbrx0rLiXfQNcstZbc7/0GGvstRZu1mkxY=;
 b=OdVCy0lbHRHLwoew/ZwQnelPH/hmnL4MRj7CJgGVnaFZxVEnNJlPYRT1japWq81e+zX3yGbvB7r8Zn7XXWrltGbpF0KIvGfmb4VKnATYjO6VtknebfzCJhm/YdfcQihDgybHzuSHUwlVAwHspu2FbzRwn0xLtgkGdvD5szMYlh8QydP0nF3or58D3iqSAcmsqq6R1oHM0Oc5gvJZAJomZigsuxpI4gWdysJgzeGQH0LajdUmjsvwIgnEh/K81h+l2X92bCVH0ajAyfc8mzzOJnRb48jG7gu1EQ4a+uXLrbEuIZvv7l97jBQeUZSxSvNxIaC8c3UkYt6/+5pIQzF1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO7qynMSzcbrx0rLiXfQNcstZbc7/0GGvstRZu1mkxY=;
 b=bSHIx9khwh8r1OPj+M5vkTmihLJsuyyYooi4aAzapXZ0mXmB8bHp/5NWeu1X1kjTIT0jq0/J71JYdFEeCeo6pmhJiyLy1EvYAhEpRRTc+veFEZjJE7vI8tRlnyNWLy6PBGx+wRyRLI4l3nOlxvI4wcrwgmTKyUuUUR6IeZ+88eU7k1abPhK0WkD4bKWsFminDJCBleNoIsnL2ijVcdy8n0wFeHzRv5d9wsxy6rJtJdx8KVOcRGPPH2dGSIA2BkomR6mKCfhdkkvR2FxfNh1YI4nkbATegEHNpAf85EHJIT0ajFrIeNThAgoLaNp2c8FoL/K6BcTyGPEYze/pCZxF0g==
Received: from DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) by DB9P195MB1244.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:29a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 06:14:00 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::72) by DUZPR01CA0058.outlook.office365.com
 (2603:10a6:10:469::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 06:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 06:14:00 +0000
Received: from Postix.phytec.de (172.25.0.11) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 18 Sep
 2025 08:13:58 +0200
Received: from llp-moog.phytec.de (172.25.32.54) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 08:13:58 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 18 Sep 2025 08:13:57 +0200
Subject: [PATCH v5 3/3] doc: phytec: imx8m: Style and firmware update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250918-imx8m-optee-enable-v5-3-ecbe0b583b94@phytec.de>
References: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
In-Reply-To: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758176038; l=7431;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=8k2UQmnTvV+uQk1OFTXNkG69hgQgtaw5BIY33biOpWo=;
 b=3HMTEqzJhShzJzOrGCd8Ahf1yxNPfifnBOYWCb4JEm2nc/PHLo2AJUGeSLhR6HjguG9u78M8J
 bvPDLYdozXxBs+z5+CXR1EAOCUueGoxWV/WwetTr6ghGR/XqSkhVdjq
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.54]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|DB9P195MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c91d2a-e8b1-4540-3e94-08ddf67a8f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWlrdG52bGx2NFJTZ0NmU3hZcVNhdFl2Rlk0bVdoc09RRmNLS2I5WWI1LzNi?=
 =?utf-8?B?cTE2UGFsVUEra0NYVU5TWWlyVGhhbHk0ZHJsM09hdDd5cDlxTkVFT0xNUXFz?=
 =?utf-8?B?RG9rSEhKQnFqZ1RsSE14V0tOaUdVNnN3U0VBV0pQM3BxOXMzbTV1Tk0yanUy?=
 =?utf-8?B?UHdTSGVLL2hldGNHMDhIc3ROdkp3ZG9BM0d5bUJKMXhtRUwzLzc2TEd3U0Q5?=
 =?utf-8?B?MnEwQmZOdWxCNUtzcFZQNFpDQkV4NjUraUhTOGQ3akhBeDArSFNqR0xueDc2?=
 =?utf-8?B?dTAzNE9JUU0zdHBETmVTYjNJS1JYa2w2SVY1Z3o5TFhvY3NPWmU3NEFOT3dN?=
 =?utf-8?B?VEM1bnVXM0cxaCtwOHdIaWRkT1Iyb0picDNscldqU2c2RXFVejJveXp1bnc0?=
 =?utf-8?B?eWM5c1luVkR1NXNQa2NxRVhLWXZzR3F3cjh1L29ZU0Nkb25YenllaFFVY2pM?=
 =?utf-8?B?KzlLZ0U0UzMyOGJoLzI2M0U2ZmlyMFpvNWtHMU5oUHZVZlFKRlAxOS94ejRF?=
 =?utf-8?B?aHB1S3hXWHE5MXo3MnFNSER5ZmUwZ2I1NWdYanNlaHExK1hkYlNhNFl6Ukpv?=
 =?utf-8?B?Q0Ywb0IvNDZnVnhaUDFuR2lkQks4N01SV0ZSTEREVkcvaDZJVCs2YyszenRH?=
 =?utf-8?B?OUgvM2JWS2cvY0dUQlN6VnVmVFo1MDJGWXFkTGliZ1Bvb1oxcDVsZHJrSGN5?=
 =?utf-8?B?N0tIeEJRa09Wcm9waW5ZTGZyWnc1M3ByNVkzZm5ydy9hMVVUQ2ppalFUai9T?=
 =?utf-8?B?L1pKNkJrWWdTWDFmZHNmbXcyYW1wV1lnK3pnL1ExT3UybXhBRUZVakdyZUlV?=
 =?utf-8?B?VFNFU01iZGsvMkQ0aFZ0SEhrTlozL3NGVjFScDE2eTFWVVQ3OHBtMmg3UjNF?=
 =?utf-8?B?b2tmaERpbnBqam1uRnBWY2lKSnNNL3NSZ1IzZXYwUTdJM0hSQ0xXYU5rS0Iy?=
 =?utf-8?B?WmIyaVdueGJQeDRVWDUyMkJVM0pJcFZxOEpWR1AvYzkrbVFJYzg3cldibG5n?=
 =?utf-8?B?bTNDNTFEWDdOOGdTQWUxTVpWNTEwZG5TOUdjWGF3c2syZndzWi85cWFYM3B6?=
 =?utf-8?B?QmpmeTFXSWd0cWJ5ZzVJWVB2MWdvQnVjVGo2VWY5VzdFMXBFUXV4L0pSSHhX?=
 =?utf-8?B?Q0J5SHNmZFdES0FoTWFzUEg2cHplb1lMR1Z5RGFZWjU5cmRRdE1zMXQybGpE?=
 =?utf-8?B?VTdUd1liZ2hzYWlsZVdNdEc0eTlHVVAwbVVrOU5HZmR6UFFqZjRSUDM5M1Zh?=
 =?utf-8?B?SEJXc1k4QThKeVZjOEpnc095c0RrNFk5UmR5MWV0WTZKT1I2ZlhMT21uRWFV?=
 =?utf-8?B?Qk5Iamc5MXFPcEJvMjB4Y1RFK3lINU00aXlYQS85MU9sa0IxMDJNdStaZVBn?=
 =?utf-8?B?bnh1NlRSTFZDSDIyYWV3QjY4d3VFMDRJUjNBT2Q5VnM1MlFzUzFLZWVFblZO?=
 =?utf-8?B?VzlLT1ZwQm1lZmVxMVAwV2dqdnVkSmlOWlNObFppMnk4RGRFT0V2K0dlWUpu?=
 =?utf-8?B?RUZLMm1wWnhOT0JEM2hvNHlUVHJtc1pFWms4SUM0d1FLOTNSVkZMQVVXcFNK?=
 =?utf-8?B?WU9ETjBHblJwTmZUWmJJcjBGZlZUREZGbkZtTEd0MU1veUlQSVB5RVF0MHBo?=
 =?utf-8?B?Yll1ejlwUUFJWCs5Tnc2ejVqa0IvajVhM2gwdFl4cm9aQ2tBTHFsMlIvcG9y?=
 =?utf-8?B?cTlKOHZFVVhIcEFrVExRNVNHUzFCUDAzcDBrMTdvY05mbzZmRG1sdDljRVdV?=
 =?utf-8?B?TkJ6WDN3MnJDaUgxOVdxaHU2S09yOHVuSGhtazgrZEVwRVFrQVFaRHA5Mjg1?=
 =?utf-8?B?WTBsc0l1bWRvSVh1UlV5SzRjdStqL3NoVEJHc1d0QU5TVy8zN0FNMFNEQ3dP?=
 =?utf-8?B?aTNCd1FNK3R5Q3VEdnE2SXhYcmpISDZoM1pENVYrZCtFTVI4NzRRZ2lndCtQ?=
 =?utf-8?B?bE9DSjdRTGVDQlVZNGd2N0kvVEVvcTJDNk9RV3NDR3N0TldvWGRFMU1NUEZF?=
 =?utf-8?B?YWN6Vk8vdThBPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:14:00.7655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c91d2a-e8b1-4540-3e94-08ddf67a8f60
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1244
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

Use single make command for compiling blobs and U-Boot.
Update the imx firmware version.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 27 ++++++++++++++---------
 doc/board/phytec/phycore-imx8mm.rst         | 28 +++++++++++++++---------
 doc/board/phytec/phycore-imx8mp.rst         | 34 +++++++++++++++++------------
 3 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
index bc58a141e4f1aec894b70c1dea2f01c28b3cce3c..3a09be7075aee989f52bfef8bbfd09518469bf0e 100644
--- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30880000
-   $ make PLAT=imx8mm BL32_BASE=0xbe000000 SPD=opteed bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mm \
+          IMX_BOOT_UART_BASE=0x30880000 \
+          BL32_BASE=0xbe000000 \
+          SPD=opteed \
+          bl31
 
 Build the OP-TEE binary
 -----------------------
@@ -32,7 +36,8 @@ Build the OP-TEE binary
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CROSS_COMPILE=aarch64-linux-gnu- \
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
           O=out/arm \
           PLATFORM=imx-mx8mm_phygate_tauri_l
 
@@ -41,9 +46,9 @@ Get the ddr firmware
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.23.bin
-   $ chmod +x firmware-imx-8.23.bin
-   $ ./firmware-imx-8.23.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -55,15 +60,17 @@ Copy binaries
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
    $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
-   $ cp firmware-imx-8.23/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make imx8mm-phygate-tauri-l_defconfig
-   $ make flash.bin
+   $ make -j $(nproc)
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          imx8mm-phygate-tauri-l_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index f8fa420019cf994d602a30c61c62bdd16adb8929..0784154e710d99b6533835326431f76afda08e8d 100644
--- a/doc/board/phytec/phycore-imx8mm.rst
+++ b/doc/board/phytec/phycore-imx8mm.rst
@@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30880000
-   $ make PLAT=imx8mm BL32_BASE=0x7e000000 SPD=opteed bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mm \
+          IMX_BOOT_UART_BASE=0x30880000 \
+          BL32_BASE=0x7e000000 \
+          SPD=opteed \
+          bl31
 
 Build the OP-TEE binary
 -----------------------
@@ -32,7 +36,8 @@ Build the OP-TEE binary
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CROSS_COMPILE=aarch64-linux-gnu- \
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
           O=out/arm \
           PLATFORM=imx-mx8mm_phyboard_polis
 
@@ -41,9 +46,9 @@ Get the ddr firmware
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -54,15 +59,18 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
-   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make phycore-imx8mm_defconfig
-   $ make flash.bin
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          phycore-imx8mm_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^
diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index df087072062a0b8ca2179fecaead4fa3d0b9eff4..0252cbd08249fa37e979e13bb5ffac9c2b7bb723 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -3,7 +3,7 @@
 phyCORE-i.MX 8M Plus
 ====================
 
-The phyCORE-i.MX 8M Plus with 2GB of main memory is supported.
+The phyCORE-i.MX 8M Plus with 1,2,4GB of main memory is supported.
 
 Quick Start
 -----------
@@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30860000
-   $ make PLAT=imx8mp BL32_BASE=0x7e000000 SPD=opteed bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mp \
+          IMX_BOOT_UART_BASE=0x30860000 \
+          BL32_BASE=0x7e000000 \
+          SPD=opteed \
+          bl31
 
 Build the OP-TEE binary
 -----------------------
@@ -32,19 +36,19 @@ Build the OP-TEE binary
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CROSS_COMPILE=aarch64-linux-gnu- \
-     O=out/arm \
-     PLATFORM=imx-mx8mp_phyboard_pollux \
-     CFG_TZDRAM_START=0x7e000000
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          O=out/arm \
+          PLATFORM=imx-mx8mp_phyboard_pollux
 
 Get the ddr firmware
 --------------------
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -56,15 +60,17 @@ Copy binaries
 
    $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
    $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
-   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make phycore-imx8mp_defconfig
-   $ make flash.bin
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          phycore-imx8mp_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^

-- 
2.43.0

