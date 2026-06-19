Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7371BCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7768849D8;
	Fri, 19 Jun 2026 16:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cNlYpUDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ADA384A35; Fri, 19 Jun 2026 16:49:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222B1849F0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3RcRIOI2I9ZQuyorb7Hb7rwm51dC/Q1ZT/+zCohdcP85MlZBzKRISE4U+H1afXLvQH98FNVQm3ki8T8p8s3nZKoYVUR6wpT5X7C+XygVeI3diS/Z6+tUo3qnMyj39GbZ2D/LxAfqL5Gs5OxhlO4yG3Db9JTOm4NEprALx2v8EnlPzxTK745rVW6MeGhu6RbS+yGKpST9c6MeTea3+wfHwfXrZMWLAJRKFwKQ2O0lwKj3eNW8O52bcKArzvHwFgWs1yJcSrswt1bam7F9cIAqblgkm+/MyuMI5qsJGm414e4L3eZXC3LsMpy/8fTvSiv8+Q2g+odgA9coGSWlwKUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jjHL8A6a9zx3WTufoD9DC47yqcnwrFucs71RLSzwt4=;
 b=SLZEEyz5Y5vlTZw8/e2yl4pXr9HGwfsr4epvKPQGzXfyyhzJeAA48xBAmHrncR7n4wGGuqze07Ng17ho7Dsq7KYtJ0xKnQHKpXGZVc9e5XGIV6i98nz5L6qpo+PKbJYpRVBQKxWWzIY7QLX2nhbnSPIy5REBlzYKhdpCqVdPxPm3BASe/i6TvImibKkvLMcn4guPzBWeIFFjIUhaQ4woXs9hd7+leyRgB4Q0nYrUJlZidiDEv7qlhilNXdhaTsXBzn6MJALrRY2NICTTLB70mMAKLLYj1xigfq+Y3GXQr6n/jt7fJoli/l0cCmBpJYQKDKum6hMrqa8SiwvoPHEDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jjHL8A6a9zx3WTufoD9DC47yqcnwrFucs71RLSzwt4=;
 b=cNlYpUDDVGLy+2wvvRpqZJQ9f0XWLkmPXldN/lT+gPSZnOXv+gz/jAV6PzXcjHBNoTxZFxsLTjSz77axO2cpB+UcXQczO/2n6y6NX+QTD88pzCn3tvsTXM1cWovUWpQRzdsaB8/6RwSLkuXSsHtqum3rdXjqmt5K/x/EnqHjYapsYaXHI1UepYSFGBjkdGe4S5Gvaov6FwHRJbxVTeMV09GVcCrkLaeWbDV0zYCCgRg5a/JskuPiDJz3yDPs77Bzwf0xR3CcjtOl55goMnmR6DQuMDoxrolV8HH8L/Z1QvsCAIZAViqd6Q5FAMSasuh9Sse/sfVSyp8MmMDZt6Eshw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11827.eurprd04.prod.outlook.com (2603:10a6:150:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 14:49:28 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 14:49:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 20 Jun 2026 00:06:06 +0800
Subject: [PATCH 4/6] imx93_evk/qsb/frdm: enable booting Image.gz and avoid
 extra memcpy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-imx-gz-boot-v1-4-143c60a572b7@nxp.com>
References: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
In-Reply-To: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11827:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc5705d-8f7f-444c-7fef-08dece11f6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: daRjPxydGJ2mgB5oE5jfgmX9AF0in2yxrEsAjHZPHZzNy9Ul7pVGPnm3/E0/qcbROox+SS1PRbso6lG3mtIJsrWAkpQhEThaTObzUF2F5RT5L2YbA8uvBCySGSgY/CparjNozh63bQbGc02kiBa4QvyJIYI5JRQQ0Jby9abdbf5xfKRf0YGxUV5KwrjYBBhCItc/8o68BuxMh5PHZKKXrv0zAPtzoG3Q1dfR764HkAcByUThhfuyv65SE5S6Ai8b4ngxANrMn+Vma9JeCCFp6dgTw1281dnKz3inF3LYYRVHdfn2clh6xGKBHo1CRqfsAiHdLisKcPDKW16xliOx8K11/l4odHctKb8tXt9BTZhPgCKvCgexkOYulw/f9/oWaNpzuS9fdwml2iB8rFyPe+tmef2h709f2I/XczgkrjqwIe4nU1loU4xiCGfdw3O4iLL0u+WmItFG6jSgqK1wtB0P71+f7aFfdvQHt4g2xBlgFQprIfvP+pEIdaUVr0MDpsJGpSG/CxOx+X6PAEMy+Tfcrc/D3mE/jAtA1P9ODHoPX41WI/0ttraveo1Wrzo77Dsn4dO6uKSFOdSvoqOgkfuFzvQYbim7y9D+7Y5HFEbVRyL/hS8EVqt5LEsarjraQ2QkhXbhubmQlc6w6rrmxpwf4bWAuBxIsDdWqwhGBzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29jZDFxQ3AwZDZJOC9wc1ozZXhrT2pwd1d6VFRSZThQclZwVHMrS1M1bFd5?=
 =?utf-8?B?TmxieUk0SERHdlROVXBrZHQ2eFNteGNnb29GeWFQeVpwNlRKM2YydWtHTWJH?=
 =?utf-8?B?YVI0c2ErZ0g5QzVPUHA0M0Y3b2V2K3pLMTJaL2cyaEZIK3RiSXFRWDJmaHhP?=
 =?utf-8?B?RGU0UWlrMjgwNUd5cWNpam1lN2hUL1BTdHliOUdlUmRGeDhYcS91dWRuVnVo?=
 =?utf-8?B?MkU5a0p5SW1CNnFLUmxiL2JhVU5wbkcvdmdLcXkwTm1VdnBNVmdWUUxRZ05t?=
 =?utf-8?B?ZFh2aGg5RVVzN1M0UnZVaUd3ZTF3UkJDUWx5M09XVm9SK0NpNFBvbHUxY0tl?=
 =?utf-8?B?blp0c2FnalEzT2czWnFuT0tYMVRwWVpvTTBwRXlkY0dtci9MSk9Eb2liZjFK?=
 =?utf-8?B?WFQ1Sjl3K2Z1ZHB5eDJjOFByZlpJbUxIeDBJVUZ0ODZaOXJsMkRybDlmMG9P?=
 =?utf-8?B?RXYvNm5nM0lOWjN3QkcxYUU4ZHFCZmdFd0hmUXBGREN6Y2tsRGw0WHhXcjRo?=
 =?utf-8?B?VG1OWVAwS0lYUFh6MXIxZVNZL0NQZGpRODc1aUo2QXNZZThCb2J0eUw3VVZO?=
 =?utf-8?B?NWM4dG5sMEhXV0pJMkZqYjE1cGJwSGkvZ3dKaThPRjdEQkdnY2xId3NZMkc3?=
 =?utf-8?B?NGExZG5iczc1bkM1SGx3OUJpKzVDUnBvRklHditpb2lZUlNSZWYyMk9Qa3RH?=
 =?utf-8?B?N28vdkpBb010TWRLSndxQ3R1cGVBSHRFd2d4VVFhWXNzM3Yya2dIM3JpTnFE?=
 =?utf-8?B?NkdRdkIzSWxGeFJ2TFJTenBta2xEQnJSUndJMFEzTFVsOEtVaEtFWG5rUUl5?=
 =?utf-8?B?bC92dkNyRGY3Q2FWQmRYVlMwMW91MXg4V1VDd1lwY0NSdW9pNFd3U3FrTDNm?=
 =?utf-8?B?dTdnalhZQzJwekRSVHpwSU5aNEJ3am1LMkxtdWVZQ1FwNlZ0U3MwTS9LVzN0?=
 =?utf-8?B?TGI1dy9mSy9kb285b3NuYko0TnYzNWkxT1dabFE0NFNDbkVrS3JkVkQwNkd6?=
 =?utf-8?B?WVJJbE1jZE1FRkhGK0VEYW84TUtMRUkwQmMrd3lTckU5Q2FmZDRXbnhYK2Qr?=
 =?utf-8?B?L0FSN0E2cUhqc1FScFJxbVBEWmVBbEQwc1ZKbm5MUi9yNDE1TUgycEJSY1pP?=
 =?utf-8?B?WG5PbkZtYjNUSDdkdFBySzlTMGVTR1loK0YxeDZ1eUh4WXVMejZZb2lXY0lP?=
 =?utf-8?B?cFFzdTRYZFozNFkxbWp3cklmT1pJTkcyZ1RhV210dy9CNU41bGY2MTZPdHN3?=
 =?utf-8?B?Z3FFSGlWWEtITmo4QkFiMjhjUlJTT3YrUmVpaTNyUnBReTN6cTNySHMzVXg1?=
 =?utf-8?B?SDJhS3p4anRKSytrZ0ZxUGptM3dTRzhuQTFpTEZrUjJ5VzZQaFUwU1V6Y3Vw?=
 =?utf-8?B?Vk9WczF2bmVrTzdna1VaeVdkUzlGcVpSNUNYZkJaR2RrOEdjcWgzOG44V1Vn?=
 =?utf-8?B?NUNUcGxpdzNWMVQ2MDNEQzhEVXRIRDZoYmdxaTdsS1doakNHY3NLMFFZRVlC?=
 =?utf-8?B?Vm5mVmZoN2NMMDVlQS9IekExUGlJRld3dnMwQnJ1ZDVNbHQ3M1hvQkhaZ3pn?=
 =?utf-8?B?TStRTmthUkpJMXJEWmdaLzhkUmxqUXFzbzlmWXdFR1NLcjVQay83NHFqT0lD?=
 =?utf-8?B?V0hzOTVhcCt1YyswNk1jOFlEVkNsK1Q1eEhDTG5RS0FoWTRGSlNrdTR5MGk4?=
 =?utf-8?B?TUd3cUFudFN4aHJXa1J3OWZQY1BHa0RrOU1CK2M3cWl1NUdpRUJRdzNTUFZk?=
 =?utf-8?B?RjQ1R2E2TGVRbGNVUVBrY0ZBS0ZTQjdUTnVGM0FzQjJaTnNjcU1YWXJaNnBm?=
 =?utf-8?B?dWFtcFkzdXdjL0I4NjZsVXc5UnNmNDVKTmR2eS9wVTFkWXNZTkt5bENwcytJ?=
 =?utf-8?B?QUd2QzI3dE5BeWFLczJwbXJxNklYeGJXYnczQ0xoQWRNTUtyL2JXR2FuNDJH?=
 =?utf-8?B?V0lWZVQ3YXN5SGJMbHFWdWJIa0tUMWhnYmNveHFNaFg5ai83aG5NTGtZZ3lK?=
 =?utf-8?B?dlNIOUd3dmVZVVlJZTA4NERldEFDcnJoTkdwYWZLc01IWkZSMVplZ3RIV29r?=
 =?utf-8?B?WjFETnhPcHpRUEs5U2lmWUJhY2h1T3JlTEVyaVZlODUwbDBtTHdpdHJ3anl3?=
 =?utf-8?B?a2VvNUNyTU9mRDlWei9iMGM2cFQrVGJYRXhCUkI4MXFlN1ErbkV4eUpWZkVU?=
 =?utf-8?B?NVFQRVlwM1ZEbjJvWWNxQnhsNnNxTENHNktVVVloaVFjTE01ckZYOGlRZXZR?=
 =?utf-8?B?eUlYdUR6WjhDbXU4eHdOYmdtMDdGaVl3aG9BVDN1bWJpdzA3dGhlUUVpeUFJ?=
 =?utf-8?B?MXdJYUVmNEZUcGhtWTZidHRFUlRmcXNIbzV6Wm1DaWJSR0ZlRTQrY1E0eW1N?=
 =?utf-8?Q?UkKyWGgsJ+5VYftVttWZDhJpBEyP7hTu+i3+u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc5705d-8f7f-444c-7fef-08dece11f6d9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:49:28.5740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgK8qCUwPatgf8v4Kh7i7ARM+AX5VzBUWZEGHcManMyECv/9ilzf9VokxXJnSON69U5qbYl3k9v7ihC+k3t0/PIBu9Hbj4mLGbHb0l1xh4re+5y76HiLG5SZW2DJNoks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11827
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

From: Peng Fan <peng.fan@nxp.com>

Add support for booting compressed kernel Image.gz by defining
kernel_comp_addr_r and kernel_comp_size in the default environment.

While at here, set ip_dyn to yes to allow dhcp work properly.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx93_evk/imx93_evk.env   | 5 ++++-
 board/nxp/imx93_frdm/imx93_frdm.env | 5 ++++-
 board/nxp/imx93_qsb/imx93_qsb.env   | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/board/nxp/imx93_evk/imx93_evk.env b/board/nxp/imx93_evk/imx93_evk.env
index b2ed1901a2b..76fadc00eeb 100644
--- a/board/nxp/imx93_evk/imx93_evk.env
+++ b/board/nxp/imx93_evk/imx93_evk.env
@@ -10,13 +10,16 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=DEFAULT_FDT_FILE
 image=Image
+ip_dyn=yes
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0xC0000000
+kernel_comp_size=0x2000000
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
 mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
 prepare_mcore=setenv mcore_clk clk-imx93.mcore_booted
-kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
diff --git a/board/nxp/imx93_frdm/imx93_frdm.env b/board/nxp/imx93_frdm/imx93_frdm.env
index 9af3bdfd714..96096bc51a0 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.env
+++ b/board/nxp/imx93_frdm/imx93_frdm.env
@@ -10,12 +10,15 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=DEFAULT_FDT_FILE
 image=Image
+ip_dyn=yes
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0xC0000000
+kernel_comp_size=0x2000000
 mmcdev=1
 mmcpart=1
 mmcroot=/dev/mmcblk${mmcdev}p2 rootwait rw
 mmcautodetect=yes
 mmcargs=setenv bootargs console=${console} root=${mmcroot}
-kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
diff --git a/board/nxp/imx93_qsb/imx93_qsb.env b/board/nxp/imx93_qsb/imx93_qsb.env
index d669c6e3133..d14a1b6c9bd 100644
--- a/board/nxp/imx93_qsb/imx93_qsb.env
+++ b/board/nxp/imx93_qsb/imx93_qsb.env
@@ -10,6 +10,10 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=DEFAULT_FDT_FILE
 image=Image
+ip_dyn=yes
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0xC0000000
+kernel_comp_size=0x2000000
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw

-- 
2.51.0

