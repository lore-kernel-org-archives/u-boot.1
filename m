Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE36CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D76849F6;
	Fri, 19 Jun 2026 16:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="utcsk9JH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB97A849F0; Fri, 19 Jun 2026 16:49:24 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5E39849CA
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgoN4/U9CEbUCnhhr5BiUzRzLfZqMYXAYVvJVeHYNUydKayCGPa76BecQoIJnuUIorCLYpyqLzaUjU6zo+B0XKBegvzBX+f3Vt79Jy+RlyTwCfTZZMMrD2jxajvdXvDVltk+GhGm0FqkIAPSgXRRwe5Sj2OvLzMrXu91gzmzVbBxo08WqGC9T9GTqGnnGF5fwfQztQHLTqgatv/pZhWhtXaiDx4HDMGpptqPhemAyBx1C1SSEoSzkY6hhx05ZVb2ZD/IiYgsRVJ562Lb8zNFu+VCdu/9nqkoZqLDV1VQpkwTQ+Vl0iF4hyVIvarWEpq6NgZpXXVZYq3z6IR1EWAZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp2ICsXnge17s82J9WA2gQWd7UrhkkYpnkdJaU4oDCc=;
 b=R1NoXrn57jsyMMX8zjHujvISM5DDJSjJ1pJxBk2BKCnWJMaimi5fRjYwF1psfPiFxb/TjC5tfAR9gzafXMWEwFqt+E7bXsnLlvKDOPstDAEtgG8S2jkePWJonA8CcQXP6GwlRFVTP8J0jkgx1fRsQvxgzlaL1IV2c6ucLuDbDz2j5kEUOIDTKUkOoPGi8ugI0Uhmx/BHg1E+K9I4RAh1wLB8d7qnTD9BczQu6tcRPHyfjjkGpm5JguOz/VBPW7ol4HJvf/AqScsjwasibNo0ykwv0xGt9t6Ol7+2pg4QkyiEgC9isj7tHndqRN63qnPZlHXD9ARoBO4gsZM3E5RD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp2ICsXnge17s82J9WA2gQWd7UrhkkYpnkdJaU4oDCc=;
 b=utcsk9JHetxj03+yF3R1QQFeZElWfAKTZ1eZnYo3eKXr3MEtqsZqAoZ238D0bYf1q5UXefUE1x1MJXQMOoVgstTbxhjLiLfWyRdF1OOeiUwi+b80R3SlcDSnFSvPmbuJHH9aVERVvA6bwbTxI3ovqc3UkIjxPnOpeZXJOzO5k2XsKtmRxypFMrYHFVTMmGC/jo92HELf2UtGm3Fpib1GF0J1wwTsuMfC0Rxu9IbjlDWwNnevzZNxEGl/WGDgx1Xz0x8r3EtF3HbW0Db2RyRLrMR8hOazNTBPb/VB+MQV13buOkTVDl1guZ/k+fJ6Mshd1lbOLdqlgeiyCzfnmLkjsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11827.eurprd04.prod.outlook.com (2603:10a6:150:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 14:49:21 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 14:49:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 20 Jun 2026 00:06:05 +0800
Subject: [PATCH 3/6] imx8mm/n_evk: enable booting Image.gz and avoid extra
 memcpy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-imx-gz-boot-v1-3-143c60a572b7@nxp.com>
References: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
In-Reply-To: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11827:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e399f5-301a-4108-64dc-08dece11f22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7V6GrlLwEQ8T2OxpcilROYi8ezRPahO92epqyyTVThhGGja6zKH56bGaW+T8jX6wPo2QC9Qa1gk0Ey2y02tbDcaEgvBK96IjxEGpzHY/VKcIDrRY5SQTEa5cve0R/cQEWB2q7IvrCTSyiNYbSLGZoEkV9AYQ2T6kO6n3bzxKDveQMaxxihpNn8VYiJD5HjrGjYl3bgKhRc0aAfWpKaOho/g+RauOH21NQ+Cplt8eswn4+S4Snr91fBmcZ0iKmwcStMZ20jFZsbhKyCd/G7Vpo731q/EU4XmIHSXfv7qAIGLJ/AsHS/UwfGyQh2+gOgYhv4Hklp1Owrsg7IN7sragMXKQhfQcX98pUVx8iAnaSy3FW61mYXe7QNDbPslrG1tMsa/IhchQAd+X57LNM2dJXgu4RTTNVsybV8mHu9+uYZmwntAZG6bhrYGM/hiZcGZolBLEGWHa8/NSkJ7u0uFrXlgYd5xBKIPZOP8Hs2A1lbF2AqOnPXrxOyLqors0m/pkLLswCmIskoJbJhMWjL1E24T69g2aUdU50HTk3SLQxekHkZnncFLPO8cV+Aw8eE4YR6w30xu8o00Ul1GqpkbkVdrLrMdG7HFobXbQpmwg629VtS0E7q4I+1YsdIFrjaqD8gs50+Ph7x5YDCU2fOEygfoGXvwfooYv26qB4JgCcvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1pnRk0wZWRFYTdESTk0YjlJNk1TTDE3b2VhUVJWc1Q3REhJZUF0ODRYSnVw?=
 =?utf-8?B?OWNQcCtyV1VBWE1kVWlXYTVhSVU4ckdpRnE2cGVMYlF3NWphSWZTQTQxSXBH?=
 =?utf-8?B?VVU5S2Zsc3MveW5wVnoyM2IzMHFXQVB5cHk0K1BiclBid1NxODR6TmRYTDQz?=
 =?utf-8?B?amE0bmd4UHBLTmJKYUVvQlpVcEhpQ0p4UXJsZ2F4ZktvNnpQWXBmQlRLZFRw?=
 =?utf-8?B?NGRyck9YaWIxNU92cjJucUJ1QlpDa3BZeDhOUWVKWnpmWm9rMGhYdktOZFhv?=
 =?utf-8?B?TkVkYUlIcHpHTEliOThJb1FkdndVei8zaUlVd0k5S1VFRlJoemRwZ2FxM1VC?=
 =?utf-8?B?a3BjcUxsbDNqVU1LQklNME9IT2g3ZG04RmpFaTQrczNYazc2TmNBTkhIRXY0?=
 =?utf-8?B?MnpabHJWenUxT2l5TldFVy90bm9lR1YxcStXdEVQbTNHSnIxMjdoWENVMjE1?=
 =?utf-8?B?d01iYkI4MGpzYVB3YWVJOHE2YitsZG8rUE1IY0Q5T3FKaW4ycjBKWjRsaW84?=
 =?utf-8?B?TXo3MGUweHZCZTR4WUwzbWFiMS9OYS9RM3Q2V0IrbEtwWnJ2ZWxjR3UvZHE4?=
 =?utf-8?B?ZjExcjFJTCtrUGh2QjNCamcwY0w0ZzZ5T2lsRkpiZkk0YkF5OUtYVTVqamhK?=
 =?utf-8?B?SEhVaTA0cEdBM3NQN0YvR3JXdHcyL0dNa0FtSFptRmJsUUNnSCtzSTdBWHVQ?=
 =?utf-8?B?UW1CVG9jdDZydDNZQzViRnJMSGt0QmJQWmI4YjR1T29vQVdhU2xYYlZ4aEZP?=
 =?utf-8?B?M08xWDRsajNwY3pjWmI3VVFudm96ZWcybVowdEp0RmZIdExjbmRZd3ptSzkw?=
 =?utf-8?B?NnV6RG9aMHI2cmpBSVFZcERBZ0ZnVWMwSk93c2hEOVJ6ckRiRGtSbTlUTmg3?=
 =?utf-8?B?Wk5IdFJvSTZ6eUMrSkVBSHNOT3pFRDhheklwMnY2dmZ0Z0gwYyt4eXRFVkVB?=
 =?utf-8?B?N1dScFg4YkoxdFNRVmpmaFh5YVVjUjlCYkJTanlDS0hVU1hUa1VHUndKR1ll?=
 =?utf-8?B?cE9zMWlRYWp5Q3hkWVZjYlhTZy9mbnUrQjJqVEY1dmZYYmtjZlFSdm0vOUJ2?=
 =?utf-8?B?eVE3SGhGUXVmUWtNU3I2NGt6emw3L3Z4Uzh5T00veGZETzZha1dDcTRJT3Ns?=
 =?utf-8?B?WUllTDA4aDZWanpOQjJCOWlVZmJnU2NXaGU5U2VOZGlrM3FuRmhJcklBM2lN?=
 =?utf-8?B?bEh2NkNGWGhpRWxBWVRFdzhDM0w4STZBTVhlcWRyMjVnNkZZRHhocTJTOFFn?=
 =?utf-8?B?YmdxNmY1OHBGTXFOcWx5RXVaNnhXWWY0ZE5maUdhV3ZoVUJQOVVEZDhWeGZF?=
 =?utf-8?B?VjhielRuVXU5STVwL0dwcmNmZ2Y0V09IcGtNS0d2bG4vNGNXcWhMV29VTGcv?=
 =?utf-8?B?cDVjcXducm0xY1BTcGVHcGVMNzJIZHpkeXE2YzBuL2Y5MUY0b0dGaTM3aXBu?=
 =?utf-8?B?TkJwUGJEellsWDluU2s2SmMrVUtQaVNDSDJsNGptcEc1bDRBT0JwU0FHUTQ2?=
 =?utf-8?B?OTAxVHFEcGd2SElROW9GN3lzOXk3VExBYjByLzd4clNOeTl5MXgxbk5aTmp3?=
 =?utf-8?B?OTFTeGJ2ZnhPM3N5eTBzNEFCOTdRdXV0a0UwNFJPa2tJc0VvMzRna2dWbWVK?=
 =?utf-8?B?Rk4vRXBEOHpLQzZIMjh2YlcwTjllYXJCVUsrL2xiRER4eEhsUlpsTkwrRkhU?=
 =?utf-8?B?dUVZQTY5dHJTVCt1YitDa2Q0YmlDQ0VxZ1grSDR4emQzU3Q5Z2R4ZHQ4elk1?=
 =?utf-8?B?a1lVMmo3VTZTWUc2VTBidENzck8zV0I2RFFvTVl2RXM0Zmx2Ulprd0NQQ3g3?=
 =?utf-8?B?TDQrNU02MG02b1QyNXdOQ0liOEQxN0E4WHNQaU5hb1dobTR3R3I0dVp6Nmo1?=
 =?utf-8?B?UmxXSTFWeXR2aGRndzdMQzJmQXNwblRUc0hNaXNpenRpR1E1U2V1QllwUjJl?=
 =?utf-8?B?M3BLc3NwZ3BXQjN0Uk5WQUpnY2llcFpUZTdVOHZKUVBBQjFna3lhQ1p6TXdn?=
 =?utf-8?B?OVdCcTB0Q0FXZDBuVFdHOXEwUzdFNnF4ZVcyTmpNcUpvUXN1cXBQdzI1ZTAv?=
 =?utf-8?B?ZXJ2MWxodzdYanRHQ0lKMG5TdFRHcW8wV01pTjkzVDAzbk9DanU0T0lnc2dO?=
 =?utf-8?B?NGZWUzcxMFRLdVJod2NtZW1pbmxpVWt6dmJMWUI4T3FSS3NhR2U2aXZPTHdJ?=
 =?utf-8?B?QThXNEpwUTVrOE1WT0VSTWtaVnZyTFViMGxJL1NmbVpSV1orR0JzYkk3NndW?=
 =?utf-8?B?TTVHUlNxUGdQQ0V0eDJ3YVBhQVpORTBBaHFHSmFBazVvUDJRc2FOQ0RmdVpB?=
 =?utf-8?B?UXVGRWJxVXY0UDJmWks5YWZvZFhBeGdFVmFtOEJaS3VaUi9xUThNN0w4aDVv?=
 =?utf-8?Q?VuSJA4wXcB/8yJifgxfeyUrFxtY7FIT8r6EJp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e399f5-301a-4108-64dc-08dece11f22c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:49:21.1418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09pGftyS/43k8I40hwylKEnU371rp1twos9dZx4vIFZUk1rNp1UoCx+00+OWQLQ5k+CuH2fstJ4Bbk5PK6LQrawCQZ3hYHe6nf8RFaErJuFlcrrYbttaCtUAliWz7Ex4
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

Set kernel_comp_addr_r to a high memory region to provide a dedicated
decompression buffer, avoiding overlap between compressed
input and decompressed output.

Also adjust CONFIG_SYS_LOAD_ADDR from 0x40480000 to 0x40400000.

With TEXT_OFFSET=0, the kernel is relocated directly to loadaddr, so
separating decompression and execution regions is required to guarantee
safe decompression without additional copying.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mm_evk/imx8mm_evk.env | 2 ++
 board/nxp/imx8mn_evk/imx8mn_evk.env | 2 ++
 configs/imx8mm_evk_defconfig        | 2 +-
 configs/imx8mm_evk_fspi_defconfig   | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/board/nxp/imx8mm_evk/imx8mm_evk.env b/board/nxp/imx8mm_evk/imx8mm_evk.env
index d59bd6fd5ed..88eefaa35e5 100644
--- a/board/nxp/imx8mm_evk/imx8mm_evk.env
+++ b/board/nxp/imx8mm_evk/imx8mm_evk.env
@@ -12,6 +12,8 @@ initrd_addr=0x48080000
 image=Image
 ip_dyn=yes
 kernel_addr_r=0x42000000
+kernel_comp_addr_r=0x60000000
+kernel_comp_size=0x2000000
 loadaddr=CONFIG_SYS_LOAD_ADDR
 mmcautodetect=yes
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
diff --git a/board/nxp/imx8mn_evk/imx8mn_evk.env b/board/nxp/imx8mn_evk/imx8mn_evk.env
index cffa83bf792..fbdf202c573 100644
--- a/board/nxp/imx8mn_evk/imx8mn_evk.env
+++ b/board/nxp/imx8mn_evk/imx8mn_evk.env
@@ -12,6 +12,8 @@ initrd_addr=0x48080000
 image=Image
 ip_dyn=yes
 kernel_addr_r=0x42000000
+kernel_comp_addr_r=0x60000000
+kernel_comp_size=0x2000000
 loadaddr=CONFIG_SYS_LOAD_ADDR
 mmcautodetect=yes
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 7521df31f2f..390b3bbf2a1 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -18,7 +18,7 @@ CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_SYS_LOAD_ADDR=0x40400000
 CONFIG_SPL=y
 CONFIG_EFI_MM_COMM_TEE=y
 CONFIG_EFI_VAR_BUF_SIZE=139264
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 8ab6ee24b23..9a1cc8f251e 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -21,7 +21,7 @@ CONFIG_SPL_TEXT_BASE=0x7E2000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_SYS_LOAD_ADDR=0x40400000
 CONFIG_SPL=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000

-- 
2.51.0

