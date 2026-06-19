Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B0ACD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53177849E0;
	Fri, 19 Jun 2026 16:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JAHsPxGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB14849CA; Fri, 19 Jun 2026 16:49:13 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D45849BF
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7/wNhC3d2uCltD4yjcocSBxE3gYOT+Ovv1g9ruiUtKMeYQvzBRY5kpDfgli+vg595UP4QCuRYWTL7kiCS+dGGx8YL+3DrVL5gYOXSb9TGfgtTfytPN/440v6GsnCKng8vD7TabTGNlbaxvGO/TPasDLjxJnSHBSu4OFICt/lurPDfKJveEU59qhyc1nqi7HeXTzhm937WCK10A0RmZzdYtWrw6T/m3+PdVKykGrrFtceoy3WDx4EK31IN6IsEM7QDMWfVnSQnbRbZKyqgjzWNcI1X7oTuw+LuPrVutkshYsRYojbLOiQht4fjxo4OUCu9MyviMcLBKJlGipwyf3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0RFggADA3/hdKggZU3/D5l9QvJ+lk+FMM1RwoGAbYM=;
 b=hY5TitKINmFytVJnJ0OnNIn7T2noaeVbZsR6GZiRonQU4TavYGPl7VstdPP0BPQ9Vl+yyqydfIJ07uCcjeOJkq/Dh8jhe5i+a0x8ceuuzAVBkt+W4Lr7HC5lAdTB1ho/F+b6t1ULvd9whXR33EJIAR2ByQvg55Z3J/iiFfvTUh3M5d3DcRiFqMcapXiPlGUfN8nSAjHgMjOmTkNgO/Ej1g3S7pt8YBWuNIHCL907/6KvIv6G3MO71Dg+o48hx4GzzRbrMENdo2jjhEvKV8FIvsyTbC2FevlrV5wVJ3PF7xCB68h47PUrU6q0mFgXi+tUqDDNTM8r412HrrlVL2u9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0RFggADA3/hdKggZU3/D5l9QvJ+lk+FMM1RwoGAbYM=;
 b=JAHsPxGrRyfKQ23nL9dGKWilsBsKeW+XhAGPiP09gPk0YWNgFwvVIBDNTs4k+6+IbRo1HwcQLTFG1h+ve0Ek7acnEqXdxz8ai2gMJc5UDQ+bYHsAKh89OQ+Gv4pT9iRCLxLuomGyhDPzK2vp0DJXypcnCZeupt1BIBvR5Cs/nZCmZKVepzqaoUrDDV2OL0rygs6doymhiv4iv1V7W2jK07aV7piZd2iMsmTimwu0eRAlVHHpXJ2RBqGcTbiEL3/JFjQSytW275AKqZcQvJysKyd5bxBwn2jgDjF70rOmhZi2m565Mbd/f4igKsgd55zq/iacI1taDl0OgKpDAv2y9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11827.eurprd04.prod.outlook.com (2603:10a6:150:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 14:49:10 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 14:49:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 20 Jun 2026 00:06:04 +0800
Subject: [PATCH 2/6] imx8mq_evk: enable booting Image.gz and avoid extra memcpy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-imx-gz-boot-v1-2-143c60a572b7@nxp.com>
References: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
In-Reply-To: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11827:EE_
X-MS-Office365-Filtering-Correlation-Id: a40e80de-fdbc-4769-6cea-08dece11ebab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ryBmTW6Fw9evRlw1YNeDThs4IdVeRqlXScaYIVh9+39+1lwCUCizU84VDgmqOnA5u1aEPxDSM/TqE6MvLoTdObiy5ONSoH/Jh56VloOcEwd2mxE/ooi9whz+6BRPleWAB9euO4kPeJlYg1OXIyGNXlsMpBLPl76uYBLAp1V+kwSoaq63dH5rje1nj+rR0HFzvAnCcSJ4uS1bQDm83IDR+v2pNcxKdNkKxvmMIDoF5kR+gfduyFybrBKsGaMJAlXxn5Fs8WLuhtegIY0y6GXvER9VKehTDjG98KtiaFE1dJwwhVYKPSeFn0zbcHCau4+XDDXxswrW6S2MxqY4myZ4jWm0Nj5KvKoeIBM00/I1nsDqWsd1WR+ex/OsIXXba9VWc3czr+9v6GCLWLNqIEwqiDclEpmBkOha4f4NaKUX7BNPP8UBM+MK/Fy20vsLBdBlilcJcF5VlpSIKMZtlQyngHj2Wy8ilCxw0bcsWy8bXNT6aenwqGj1gPMgNjQTQeSM780wPpJJ9iS2oJFj8AVnofs4xeMIdW4Lx2zdHlw1yma1wh77LCjRH9P7LaRFYBvvPq9xrojpkKVeS9yyVecba+COp3/7cs09JU8zt9dKbjbH5Aw+T8AZCtvl/VlmysRYlJvaWN7UFvV0SLZ1EeJm931E/imkftmBPJD2DoQBIZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVdlWGNBeG9Wb0w2dHNpNEMxS0tLMGZOeUZDT2hRL1ZwcVc3MWV1S0xsQ1RV?=
 =?utf-8?B?dkRIMWU3NkpTNVN1ZFpmUGRYa2lkQi9iS1h0cUwxaEMrQzZISk1yRnR6UXhi?=
 =?utf-8?B?NkRMLzJoUjZGZ29Rc25rVXAwa1NMWElXYU5rbVRKRHF5RWhRbkE1dzFadU5B?=
 =?utf-8?B?dWYzR0ZzbVd4THFTaENoR0pGclNOTXVnVVV0SDFOVFJVNnR4V2RFL1VJTVE4?=
 =?utf-8?B?OXAvL2RJNmhyQnB1QXAwTHc3UTcrOFk5NzZhVlRUcTBUY1RxQjVTVHZZeVVX?=
 =?utf-8?B?OWNHT1k4QTBiVWk5VUUzWmNLTFdYaHYzeUxxUm1INkpEUWRVYXRqRVlWVERF?=
 =?utf-8?B?VWxVamcrMzRKcElWMXVXM1NpZUpVeUc1ci9aL0E0RmZWajdFMjlVbmhvQkN1?=
 =?utf-8?B?cTN2aW93QnhMNUpFcko5d281SVdPS3dnNW5KTXNHbFk0YmJVS2pndHlWcy9F?=
 =?utf-8?B?VTBpaEk0NVVzdHNlYWI1dW9hejFHcE9nYTcyVEY1VkpXY3Rid1ZQWHNWWTVU?=
 =?utf-8?B?Z2NKK09LeDlCQ2J2ZkxhM3NVY0h6T1Q3czNCWlhTbTFic0hJMTI2aFUzZ3d3?=
 =?utf-8?B?R3VNSlZKeGVIYW1IWlVLTkc5LzRmcE5Ka2hMOXowMmRrMElXdkFxNzdteWlk?=
 =?utf-8?B?RzdhNUNRZ2o5QmZXNzA3eGVPTG9nN3VWcFhIK0NreGEydVNLTnp4Z0podmlm?=
 =?utf-8?B?djFrZUdPNnJuQXM5Z0ZjL2tDdmVyelo5bHBFd2FYRkFQSVZEeDlVWHV1aWpF?=
 =?utf-8?B?S2lnRkh2bXBDZVkyUDB4a0tGb1QzWHB5ZXF5VGJ0RVRMMU9IQ2g3MlNFZ0FP?=
 =?utf-8?B?cmRadmRsbExTdG1HMU5pZlVIVXZ2Z3NSSGwwSWhEZi9MVExkS0VJcm54WjFx?=
 =?utf-8?B?Tjh6WVdOcml3K0VYSCtmdzU2N1ZhRGppaFc2UWtEeVBUSGFQL1UreXdyR29i?=
 =?utf-8?B?dklrbDZCbzVxZE1xWEVseWdQY2NMT2ZGRDlWeXFUUU9uZHpYdXpuYWUvMXpX?=
 =?utf-8?B?aEV1NnlrWGZaSUt5MkkyY1I3anovd09aaVRLN0NiNUx1eGtEM2tuNWx1ODRi?=
 =?utf-8?B?QmF3Z2h5NnJmSGEzQm5PZnk1Z3pQbG9ZbkQwb1JlWk5xbUhXV0wwaC9lSFpQ?=
 =?utf-8?B?VjZzYzJYbkNsQkRmam1aTkRTZTV4U0QwVmw2NkNySlR1V2p3MWl0V2EvZ240?=
 =?utf-8?B?TDN4d0pQeUg0c09HZHNraGxIREZqWjZ1MW9HZ0cyM1V6VUFGckVQSXpTZXBH?=
 =?utf-8?B?aGFOaDFxMXJqTDNLT3JoM2hWeG12ME0yeHZPWnZtWGhBczlRVTFGbVZtN0VD?=
 =?utf-8?B?QlR3U3VJdURjRWlNMWRiNUsrRStYWjFCUldBK3hlZHkvRWtWbDI3Ly9USmYw?=
 =?utf-8?B?S3VqSmhrdnpOUnZESkJ5SkJCbFJjQ2VrZjVBM3VETzJzWURCdnhrUkwveVdK?=
 =?utf-8?B?VE5xZVNtaC84Z0htOXVLb3JUdWFubDhSeTFEUVJ2TkFlcGZDWURpdms3Y1RR?=
 =?utf-8?B?NHY0dlhQaDFyNlV1N0xQdkJKeldoenZpaUF3eUdITU5GcVMvRFdYUm9HRTFo?=
 =?utf-8?B?QmNicFZvbUlxQnNrU250YmlJQ1VKVnNxd3Biam5rQjEwSVRoZDcwWjhSUWsx?=
 =?utf-8?B?d0VrQ3U5SmZyWHR1OGREWUpXOE1YLzhsQXhNR2pRdmFJZXgwZEppZjZiZ0xt?=
 =?utf-8?B?azNGNTdjSFdxYVgvb2RCdXkvbGhuTUhuV0ZMK0VoK1VMOWZMVjdqOHNuVE1E?=
 =?utf-8?B?U3JFcnVFVDd4N29ieHZGSzBGWnNVeU1ET1RScEdxYlo2azRkQjFHKzJMN3lO?=
 =?utf-8?B?WDdnbUxZMWVsWGRFNUtCbHpQdnVaa21CWGUrbWF3N0xDZXhCUTArd000ZDRr?=
 =?utf-8?B?bHcxbEVyVFZrYzFSR1JQTHBLMjZRWjFVcjI5d2ZKczZRVENTYVRWbXJJVS8v?=
 =?utf-8?B?Q2JMWUZWYlozTHdadE9WeWhlVmJ6L0FEMlRjcTA2eEh0Qy9HWVIwcUNzcGN4?=
 =?utf-8?B?cjZrZWNPRHhuVmt0NVJUOU9KNjh5aU84VXBwd3lEeHlpRW9TRTcxYTYycUl4?=
 =?utf-8?B?Ri96YzV5UEVxd1JPTlpLUHh2WDNWZTR3VnhqWUpmYm9CVzkzT010ZEcwKzhH?=
 =?utf-8?B?dXFBK2Z1Rm1rd1NIRndVVVVaQ2xRQ0Zrc0xxVFhSMHhLcEZCUUpYNFpMWEIw?=
 =?utf-8?B?UERQOVc5Y3VRdldyMjdJQTF0RXdzYWZpbkw1TDR4enhjbzlaRzB4Ymk1YTV1?=
 =?utf-8?B?b3pVNnN5aXZZMUFRNmpDcHoxUkltdFdlUXhNbjRKR2lkeEVNcWlhYzBOSXVK?=
 =?utf-8?B?cUhQVHlwNmNSMVBiTnRZOUwrYjNYQnRLRHpET21sZjJQNXFWeU8vN1lnOFM5?=
 =?utf-8?Q?VuxqMWunkC5EnSm61cElW9TWns0j5qm3n98+n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40e80de-fdbc-4769-6cea-08dece11ebab
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:49:10.1927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4MztiqZGh09ohJX5fYEjmZ0S9Tj64NaCnrPRHfxRvnBmpGL9pMoIaDoLheUc6xLcY7haBGycAAzLLCdzCs/ennrmh2DnqlA9uG0z7pBIvkoKX4zEdFC9TtADkq02RQ1
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
 board/nxp/imx8mq_evk/imx8mq_evk.env | 2 ++
 configs/imx8mq_evk_defconfig        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/nxp/imx8mq_evk/imx8mq_evk.env b/board/nxp/imx8mq_evk/imx8mq_evk.env
index 6575dd7cb07..dd674afac91 100644
--- a/board/nxp/imx8mq_evk/imx8mq_evk.env
+++ b/board/nxp/imx8mq_evk/imx8mq_evk.env
@@ -10,6 +10,8 @@ initrd_addr=0x43800000
 image=Image
 ip_dyn=yes
 kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0x80000000
+kernel_comp_size=0x2000000
 loadaddr=CONFIG_SYS_LOAD_ADDR
 mmcautodetect=yes
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 67a7f339816..3a78eaf9467 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -19,7 +19,7 @@ CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_SYS_LOAD_ADDR=0x40400000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x204000
 CONFIG_IMX_BOOTAUX=y

-- 
2.51.0

