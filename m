Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D17C4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 16:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F6848797A;
	Sat, 13 Jan 2024 17:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nGxEG8aO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E8887946; Sat, 13 Jan 2024 17:37:20 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 607CD87954
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 17:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Waqj+981pMvVG8mESG9BrtjD36DXB2OmTHFD0KMJTcT0PKPTw9jhbilFfbnBxex2aRFuxWSKeIuotM0QKGzdA3wjSnZ5K++WTsS3mPh6lFu9qBy4KBFo7a60Hw7ioU8vBMAq/1V74ukj8ufgB4z/m4Vr523PPHDbo2SBlnwIUbytGqresbZ1uPhkVeZ8UJB6SfTkaDnoXxFsTcrSuz0M3ACuJmMDDD7RPHbyA+RwczsmCQdkoa4DbhooNb2KZJV+1qxEFOl7xuIr5k7rrVuBy4KoH2UeLHM7T820Izj7sm+htLTWTl8x1N7IsTJ0k9hnkVbiQiPbX2Jggsp27BND8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ic0AIVWRlwBs6VrWKgggi04k5rKtPLx1x/zEH2DCto=;
 b=SBipLeibO3E1ZIymJ/7RWQ81Fsix1+JezFJqgSbuJAGVx6yMR2pVQJ9NBY/V6qZ10Y8QBCEL7XNBvD5Vg7cYDuPBPGA0LJUSQ3X3LHinprn4MqSOsKUMBXj/YK4Y3W6uV7is2aKAdvvkvN7Isz0cVq0kgeF+P7u8EHzSkPVrIjUEkQ8EO389LRaRxq/XtwJa8LCYINAZOHuH4v+Y0+FKpF9ISkMVT6qXJRUnZO3k63L4BrzljAxWtMkBrDvskc2rG7LPXE3/xKW1jAXQUy2hqkIbWz8HGS05FY4hqJNQMXodq0I5cHYGStte60SzSxBJ/ORUQ8Crpel39m5rrifEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ic0AIVWRlwBs6VrWKgggi04k5rKtPLx1x/zEH2DCto=;
 b=nGxEG8aOtGenhLw27Y1C827Ag5CkehB86NbCEZMbapz9a5NElzXltpVOAi9cbK73KxlQQvrES2qyDOXhdLVcw//0Xw5E23j5GGh/SAk+/OdgxBNtk1JpeL0ssQ6+d5waJI36gOqkjdGQdMyoCWFxRwRDplfOYD6c4pvcXpCekwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7567.eurprd04.prod.outlook.com (2603:10a6:102:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Sat, 13 Jan
 2024 16:37:14 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 16:37:14 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 13 Jan 2024 17:36:57 +0100
Subject: [PATCH 3/3] arm: mvebu: helios-4: add defconfig for spi booting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240113-helios4-spi-v1-3-2a5663a10e6a@solid-run.com>
References: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
In-Reply-To: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
To: Dennis Gilmore <dgilmore@redhat.com>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c5a96b-5e7a-4c21-b806-08dc1455e5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECULT/hrie3Spzk7aNyk1XHc5hWPVSgXDdfHNjYeEFLTsvtFn5azSkIgh8yI2CP2/AuzG4eyS8e9Aa06T9paAgn0t2B2HHX28xExDUmdYLHoC4g6YYDegamAk5RAb+IHyeM94SjuJERpeCq+6GQTwjou+Kscn7i+qf1N4k+qCsLlQSe75OFe/2ynmz+g7WlVIAmcp9Ef80cu/NFWADtQzWcwgh5Nqh69MUOrX+D23FFO6GVn3YACmd+oWWYjUq/s6qkRzFuvih3QzTwr8X2jCjdkddZ9ICqfEEKdbPhfyJkDQSdHtGmyE2rLsM6GwdWq0n3QlOkphrae2g2SB5qfViIV3Tspg3LZsyL/aS18qudBiX/c1UVZG/d31MA6KHMKPxrRjAkPfy+hQiFt71ezJMi+MnjiMkHLWq8kr+jfJzWGFolW1C7wWAUY6nC3rvdZygnnw/AyYRHhVgbjl565U1oaZnwnStUtCt22oEY7KyT1vz7JI/VWnLtGJkmPFdUN+LjmZZSGreycD+3WdqMl/GtyfNiEp52YwhlbD5Yery92tuWAejJGBo2BcaPzP6VXk41FFF7EA1SrLFElHDvjGWhByIKTv+aBhCzLbwnbmkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(366004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2906002)(5660300002)(52116002)(4326008)(8676002)(8936002)(66476007)(6916009)(316002)(6512007)(41300700001)(38100700002)(6506007)(966005)(6486002)(66556008)(66946007)(6666004)(2616005)(36756003)(86362001)(83380400001)(107886003)(26005)(478600001)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1MyNXVBM21iR2UyWTJTSHRIUHM5b250elQrUFZkY3BYbTV4Sno4Q3RERzJO?=
 =?utf-8?B?ekJYc3E2R0FwZTdoSnVxV0ExVjEyUENGMVVrSHFIak5DSSttdDUvVGE4REJ1?=
 =?utf-8?B?OHorSUIvdTlCUm5Ndkxob09wb0ttNDltcElkR0MzMHpZcEYxRVdCN2VjeXJM?=
 =?utf-8?B?K3IydVkvbFBkUG9GaHRzYld5N3hJTThoRUsxZzFJd0ZvTytwVlFrL01QTC9l?=
 =?utf-8?B?RU9RelZ5SHp6Z3Rtd0dOQXdTRG1uUXFvb0dCKzg0anR6K0V1VGtYa0srU0Jv?=
 =?utf-8?B?a2VQYWE5OXR1OHNPa1FSUzJlMHZLczBYVWVydkxsNmZLOEpaNFViNlFERzN6?=
 =?utf-8?B?eC9LQ2xobnpmdmhoc29aZWZvOUhiNTduQk5ZUDM2UlQ3cGFCZ2cyejRvdk9n?=
 =?utf-8?B?UjdHdkx0UGQwSXlsampxSER0cFdyUmxFU3N5a0FOTTl5OHpCTDllb1RPaS9z?=
 =?utf-8?B?NGhaYjJsb1dWZWh6ZlNPSERkNlJkN0h5Z0k2ZGlVb0JqQ3NXd1BnMzFLWnM1?=
 =?utf-8?B?Y1FIeVpGMEVUVTNVUXRPUWtmaVpBU0paakFHVExxTjBLTiswdHhpdThZYzY0?=
 =?utf-8?B?bDYvYko3dG4yWm5tbmdnQXJocHdPUTlOUVhCYnNMS3JVdzB2SzJkUHludkZ5?=
 =?utf-8?B?KzFvd3J6dDhlbStjcVRuK3BoaXJJa1NzQS80Q3plT1RHMTF2aTZLWnlNMTZC?=
 =?utf-8?B?Z0puV2c0YW5IUnNBanRhc09KZGNXR2d3YWJlZkpYSDNoUXVFaE1aK0JvdUR2?=
 =?utf-8?B?OHFEQ0U5RTJHOFV3WVJhamdES0dxTU5nNDRtckdxUU1wL3drTmVMUmlPRWM4?=
 =?utf-8?B?azJaRlFzU0oyOW1lWGtWR3JQVmkwMXg2d3pBV0hSUi9QM2ExNWg1U0VOei9p?=
 =?utf-8?B?QU5oSjNVNjBINGxXcXkyV1IyTDN2WTZGVk11dGFWamcxMjIxQ251dUJlUE1V?=
 =?utf-8?B?L1ZCWmliQ1pldndsMjZjbzZmaG1jeEVZTU95OVBIQzNMNGNKampjUFdXMUx2?=
 =?utf-8?B?U3RuWTVveTVDQ1k5OTg4RnJvR2k0VUVNanpjUDUrUUpIbEEvaGl6MERvTnQw?=
 =?utf-8?B?L0N5UkwvZnYxa2JyZE1Oa3pjeTNvMnVhWEVkeGovanZSbGZ5NTc1bGJTZllx?=
 =?utf-8?B?SjAvOFdPNHlQRXNtVHBlUVo0TkE2TzZiNnIwSFhSOVZsbFNXbzBhQjZJVTh1?=
 =?utf-8?B?WFhyTStSOTBTQzJoOWs1NzRlQ1dUcWxVWHg1dDFUWGtQcHlaWnJrc2JxVGNS?=
 =?utf-8?B?Rjg4VzdCTGI5eldnWFZMdzY3dlZqcXFkVzlwNVppdEk5T29WN3U0cHZCTlYw?=
 =?utf-8?B?VUNVUS9XaUpXclk4Qm5ZNTkycE52RHBLRHNEeFIvQUsrNld0UTh3TTdLOXlZ?=
 =?utf-8?B?NFdSMS83YWxYNHZkeUJpV1I1M1R2RjdSVXBNa1FtSEp6ck1HbHlyd1RUWFls?=
 =?utf-8?B?MW85YnN4L0l4RDIzMkN6T09yRmhhekZSTGE5L2VSWStXSi93ejBUdkR3NFBF?=
 =?utf-8?B?WmpYVkxWVHowbmtNelVsalEvRlB6QmdFVHVXVmxlU3E5cGJVeS9sTEVncTJP?=
 =?utf-8?B?Q1gvZmdUcE9mSTBMZG9IaGlmWEdhSzlJT0pQRkNaS3hRR2JiVGpOcU40M3By?=
 =?utf-8?B?OUk0T2NBZ1kvbXo1VVhKTFV6SVBIMVRTbUlOdDZzLzIxNFU5UGRLeVZkd3A0?=
 =?utf-8?B?KzFyOUtrSTlCVzRUK1ZXMEdyYXpaQ01rN3FQL0YrUExXbWp6ZUkyNi82ckRi?=
 =?utf-8?B?ZnlLSWRsZGtGMGNDcEJpbXNpY0J2VVRub0U4RkpuVkdCT09mblFDcGF1dUVn?=
 =?utf-8?B?Z0F3dThwb2RvRlNZYk1HcDYvU0N5M2tJakxCUnRuN3FST2gwSDYrajdMbysz?=
 =?utf-8?B?VmFvQTM4anM0bFlrc0RtcGwrR3Q4dzU2eUt4UEtreEJBTWZhbzUzb2xteFg2?=
 =?utf-8?B?RE16VlZtMWRVZmhXWnd5WVlFakxDQW92QlFUb2t5REtMKy94eTlKeWVWZ2h2?=
 =?utf-8?B?UmZaVGVoejMxRElWVS9SK2lzMU5NcmlMdmh1dHBET2lNQWxTUkd0ZGV1NVpR?=
 =?utf-8?B?NFNUbkZKbzhjMzd5cGpwck81SkxpczdKYS9ReFFiVkU5OVB1Z3BYeEh5U1Rk?=
 =?utf-8?Q?ZGLp+Ooj6I0SBM6VC0WC2llgi?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c5a96b-5e7a-4c21-b806-08dc1455e5b8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 16:37:13.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WxNdrPPBu79s3F0IlX3WLHOEb1NeaHSUFy2xKx6OCw0dFpC8/ErjRVeESOcdGmAd9zF4bUMa/jllXbEWs2aRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7567
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

Add a new defconfig based on existing helios4_config file to support
booting from spi flash.

Settings for environment location are based on vendor u-boot:
https://github.com/kobol-io/u-boot/blob/helios4/include/configs/helios4.h#L59

A separate defconfig is required because the options are not
intuitive from menuconfig, numeric values in particular.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 configs/helios4_spi_defconfig | 81 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/configs/helios4_spi_defconfig b/configs/helios4_spi_defconfig
new file mode 100644
index 0000000000..6b8c6dfc56
--- /dev/null
+++ b/configs/helios4_spi_defconfig
@@ -0,0 +1,81 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_THUMB_BUILD=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00800000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_HELIOS4=y
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DEFAULT_DEVICE_TREE="armada-388-helios4"
+CONFIG_SPL_TEXT_BASE=0x40000030
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x4002c000
+CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0xf1012000
+CONFIG_DEBUG_UART_CLOCK=250000000
+CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x22fd0
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x40023000
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_I2C=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_SPL_CMD_TLV_EEPROM=y
+# CONFIG_CMD_FLASH is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_MIN_ENTRIES=128
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_AHCI_MVEBU=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_MV=y
+CONFIG_MTD=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_GIGE=y
+CONFIG_MVNETA=y
+CONFIG_MII=y
+CONFIG_MVMDIO=y
+CONFIG_PCI_MVEBU=y
+CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550=y
+CONFIG_KIRKWOOD_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y

-- 
2.35.3

