Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80A6CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C67831D5;
	Tue,  9 Sep 2025 16:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XIbXChdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F78831D5; Tue,  9 Sep 2025 16:06:25 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BE38313F
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JX+ERORSVuGNIxVIB7pdZqxsFgxMd1vS5cKfPMVe+T6t9d3Sco4ALSFAP7iMLW7SrC21D8GCRZG/m4r7QN4nfsFMLOUYmL5FUsO2HvU79Txz6NGgoukITtjn68FGGoGPYzze0/wMKGQluBaRqVFupdk4/2eg38N50uCsjX7ewy/3uND9QbpPMMetJsw7OMc+rSIY0Hlq9dqE1U9f4C2I7yZqA0oAwv3ZjnTULVY1eRCBcJve++cZ1n9HFqWG1Y1iuMi+gHCYFezFbP9k0BtFqgJz7qINHrKJBVmVz7ZyruOOF5qJi5Z3Dpgitk1EEDEoAPYHlB9BP/dQYkJteFw+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILxfgm5yKCc6XyF4eWnKAh1GCF8JUD4xr8o0ZfqfGto=;
 b=TTWE0DnnhbTf1hYD2Q8M4L0zwmuL/vz9uwStb/751MKRPYvx5gk1wywLm+UI0kwkmAKUGZ4ZCU6n+dSd+w/RqKzDHLz6jUQhuxuIMRqGPr+dEkPxZhtuB+p+TCKd0an5eXuqXgMqxaFpTJhPpOpru+u+SO1lBNZgKSu47Z0bpxdr38J5KU56/DjDnH3Xl0YwrshIyMHNHSEXYjFyrjTsllYNPEeZXVdW6U3avZDFrVydxBCf+BrPUnJaFW4HSwlEthgepS06U8DoJLzVFqR2cdfxsgR81sYQCaYy+GEIdE67fT8g5mgiih8vmsv67wz+aN2ebEe32PzXJIPT/b5VxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILxfgm5yKCc6XyF4eWnKAh1GCF8JUD4xr8o0ZfqfGto=;
 b=XIbXChdv4e2kT7AgzAyByGwv5O8upoT5MKMhp6tDx6KR5PoJncHqKj/Of6ri6eiUGlx0a0FSfzdBUCpWZWjZj+J3lAmMmpl5ZzE3LLskbMri9BzSu7bn8s2IynnuCsG6MZWwxpAGaIiFirIkJzqTRCk3vltwhdKHtNIlTG7ujWdC+MvjphUg0bdUjAG3BdazvYfsyhW3d3Zl4E3C6Q406IfP4BxXtI+YUdtSIP4Tkkx9VF3yGBOjq4eIDYeAqIGWlpw+adDw2Agxan2becHzx78YDyNmGLoQ/WR3N/eU7BimAvpqreYqP/eJEcTiRSzCccOaW/lkWijwubqqyw0Uog==
Received: from AM0PR07CA0010.eurprd07.prod.outlook.com (2603:10a6:208:ac::23)
 by PR3P195MB1007.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:06:13 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:208:ac:cafe::f6) by AM0PR07CA0010.outlook.office365.com
 (2603:10a6:208:ac::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 14:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 14:06:12 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 16:06:11 +0200
Received: from [192.168.2.142] (172.25.39.168) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 16:06:11 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 9 Sep 2025 16:05:41 +0200
Subject: [PATCH v4 3/3] doc: phytec: imx8m: Style and firmware update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-imx8m-optee-enable-v4-3-6dfe494cc939@phytec.de>
References: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
In-Reply-To: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757426770; l=7473;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=t2PZcZdU3XDJU540GJirJ0kcPntAD/Jj78yyel8CrIQ=;
 b=yp79sXhwERw2x5bGY0CfHoFBfG/1McpRZUMxrR9Lvt++tLUvmXAyGbCrEAmGNd1htTz5nqjJo
 Jh5rjgp3H6TCo0aY5lMGPocOkf8bi9qzQCTXM+MP3Z+hjJKj0YsBJFL
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.39.168]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|PR3P195MB1007:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cf5937-cebb-40ac-cb9f-08ddefaa08ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFl3ZE9UZFpKUVZ5SDJQNE1oeURtaURpV28zY0dDSzF1Tk40SHVINFY1ejJJ?=
 =?utf-8?B?VGNtNTAvejNkdGNtL2daQndUZUhiOWp0WnVkcC9rMUNMejZ6QzFjdnZlSTI5?=
 =?utf-8?B?UDF4S0s1a1FxbG5VbDcycWZtdTRZMnlXbzhFWUZDb2c1bE5oejBHSXcxSWl5?=
 =?utf-8?B?Q3BIMmdTckdkQ1NhUGFIclAzWEJyUkdxNmo3c0hGNVJVWHowNWMwRGpQRjVW?=
 =?utf-8?B?WGxkL2VlRTF1eGRFNW5Ha3VZTmRGWEVBMW54OXI1U2ZlRVBTVW1kSVl3STlo?=
 =?utf-8?B?bWZHbXhjWVdhVDZzcXIrT09GcS9uQVkreHQ2ZFNNQnVGSlo3N1JRMFFSb3VW?=
 =?utf-8?B?djJvNmZBYzFjQzhGNGhzekdDWnZVQ28rUmp0S3pQTHlvWlVhZVNxa3dFY0sy?=
 =?utf-8?B?U1FPWFk2SEtPUmNKUnZTeVljdVRTZmYzaEV0Zmw2eWdvSndVaDlyVnJzNExS?=
 =?utf-8?B?S1VFYUNGNWc1TlpRQi8rVU12di9hWWdDOXZ2K21VbUNqcFVkb1U3Y09yUUUw?=
 =?utf-8?B?eUNOQnJQb1QwRnAxWmQrVUZKYkQwWXJ5c0pUbmczeDhVZVl4UUY0a3k2QXR5?=
 =?utf-8?B?UWxiN3ZCTDdiNm9FRnJSVTltcjFjNGhmZGRzSk9rWEZsZUp5UnJ0eElDVjZY?=
 =?utf-8?B?OE9IczN5QmxUMnd0a0NOZktDbnJCekZZVHdyMHc4UTFTTUp3R3hMazhYRjdo?=
 =?utf-8?B?QjNJQ25uQWE1NXV4YjNpSUo0R0xKQ3hVS05ocmtsanRJVWhuZVEvOTNIYk9I?=
 =?utf-8?B?Wlo5MlpFS21vOG5MU3VnOE8vb0hUS3Zqb0VFV05GVkovZjJybEExRjBEU2xa?=
 =?utf-8?B?cnhFSE1CZDNyMitxQktXUVZWOEhIV2kwWUhSQ1l2b3J1ODEwK2Zqanh6b09p?=
 =?utf-8?B?RlhNZjJieFBFZ1BmMFRNU0s5U2hMVE1zckdneURNaGlEVTM0eDRZSGNRUVZ5?=
 =?utf-8?B?SjNvd1kzWFhMOVVJSlBPSDk2YU11dFdEU2prdUVwNGcvallZL3dwS1B2THpv?=
 =?utf-8?B?TDg0MXpQV3YwNlU1c0wyZThrYWhlWWhaVlk5aE1EL3lLS2JtUG5Wa0YxcWgz?=
 =?utf-8?B?NVVkTWJvWjRPSUN1ZDZ6MGlxQ1pDaHQxbC9OK0VVa3o4SnlYdjJ6Ri9BeU9i?=
 =?utf-8?B?ZFR4eVo4YlQxSGN0NWRDRXBPU0pMQnJDdmtyL2FiQXZHVVZSRDZsU3YyaFZp?=
 =?utf-8?B?SzFkcUtFZHYvclIrMXBScEVTL09rSDNzTzJKMXVKMXBJSENMNXphOCswNkJR?=
 =?utf-8?B?NUxtUEtXY2QyNUFzdUp4VUhrekxuSFBaczU2dnYzN0k5eUVLS2Jpc0lQQUdY?=
 =?utf-8?B?ZXU4cHNWZjZBM1B4LzNGU0xoaVQwYkZGdzJUOEprWlVDenZ0VnR3eFYwWWE5?=
 =?utf-8?B?RHhwa1NMcXB0QmhSUVdhYTVDSWlIU1dtaVBYY2M0OFI5M3ZxM0hSYkx4RkxY?=
 =?utf-8?B?aUV5dktsNjlPT2dEQ1VZQ1pMbGhQVmNvN2VtblBXT1lBcFpjazZuc2VWOXdN?=
 =?utf-8?B?RG00bm10N2JQZnJPcXBscGFPNmVxTkRNSEMrdUxUY1NKN2g4eGJObjhOQXNn?=
 =?utf-8?B?eFhtSFlGMStVNUp5d2daWmZmN0ZpVVRncWJxWDhUQ0llR3V4cXRtTE5tK3ox?=
 =?utf-8?B?bjBaVnlab1BCSVQwQyt4Q1dpeDdnVlc5NGRZcFNiOW8xb0pjajhUVjhXakVD?=
 =?utf-8?B?K0RrdU1pcFhrdmk3U0JyR2I1bW5TcHRxSXBsVGIrR3B4TW9Fd3lCb09LQmxn?=
 =?utf-8?B?ZGhsNlYxOWlac0xqWmJzT2dLdEh6ZXdDNFhSaXBwUmxTZ3RTN3ZxcUl1R1RJ?=
 =?utf-8?B?dnFvUTNDWXNzOURyOFhYWjVpUzM5RUgrQTg5YVFPaENiOGc5Y1NtVW5kV04v?=
 =?utf-8?B?VU5sbzdZc2kzbmRUaFhNU1FCc0l0SHRINGJpTHdrMGFZa2FOQ3gwU1FYTEhB?=
 =?utf-8?B?T0xlcXpLTmdnTUxLaE5iTEhVZDFDSExGcWlCUll5OTNBUmd1Zzh0VXBQT09C?=
 =?utf-8?B?VFJ5eThPdW5RPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:06:12.9119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cf5937-cebb-40ac-cb9f-08ddefaa08ea
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1007
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
index 7efc9392361b4a867ce2bc18db11aacf31208800..4dd82cd9785fa585ed216664a25f593d4e723dbb 100644
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
@@ -32,8 +36,9 @@ Build the OP-TEE binary
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
+   $ make -j $(nproc) \
           CROSS_COMPILE=aarch64-linux-gnu- \
+          CFG_TEE_BENCHMARK=n \
           O=out/arm \
           PLATFORM=imx-mx8mm_phygate_tauri_l
 
@@ -42,9 +47,9 @@ Get the ddr firmware
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.23.bin
-   $ chmod +x firmware-imx-8.23.bin
-   $ ./firmware-imx-8.23.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -56,15 +61,17 @@ Copy binaries
 
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
index ba6299a968ae9980d583b87b46dcccba5aa4a186..d5edbc91474e95f677dd12e5fcc6c16092dea1cd 100644
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
@@ -32,8 +36,9 @@ Build the OP-TEE binary
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
+   $ make -j $(nproc) \
           CROSS_COMPILE=aarch64-linux-gnu- \
+          CFG_TEE_BENCHMARK=n \
           O=out/arm \
           PLATFORM=imx-mx8mm_phyboard_polis
 
@@ -42,9 +47,9 @@ Get the ddr firmware
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -55,15 +60,18 @@ Copy binaries
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

