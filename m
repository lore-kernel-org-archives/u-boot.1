Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840E6CCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AC483B63;
	Sat,  1 Nov 2025 01:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nzWdw2R2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2212883B4E; Sat,  1 Nov 2025 01:45:19 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1265F83B56
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hH+f9bp7KBKIt2CieK4903x0vKTT1N5u9+SzxmtfdASAkUIY+qOLD0UIHmhXs2A39A4ohg+NN0xxbJ1+QaIvgaVvekN8XAbAzVjuQCTbrSJCfvpP0FbMyeuJ7SiC76AJ5k6NpXpx7exa2zwf+zquQrJ4hRh51V1VFkMDf+CyYEdIDfJ9QvaFL024xvmJ+IaYIAV5ZnVfZTHXrlmCgksp/2aMfmYumHT/2QCkEvLJF7nNiFva1e37m5etvxQ6bfMVMmyo7rJKfQpwk1EXpIOn0nZk11SeDPlT8NQ4rt5sIDgJA/7bErVBgcNMLqZs1RoZK1M7DO+MKUGI2MhxR0pzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oswVNEdt+PnaaCOqV6MPlfmP6AUlS1l+oi2aBeUm+jk=;
 b=b0gCYTfyhQFJNn2zOu5lE5eEktUrYkEhlJJ9UwsM6VGQ9SqXPW4TCTIavFJ3nHAK2FhUD3JT4WoHu5h5nme+kcK4f8gTL6iDgdVqAhydZDraZiNzSUIFoQvBxQZl9uAjkBKBlR9xgDerEivQ6iPQCW2rr2Ln50pdTWUXAmAcqVLOCFuQRBrv781ugEO8I/+CU1w9Enh3PLsdxGnmaV4/CNsbaBUxJU3spZqXCVwYDaDo0DChhuEVCsusfPBeaRN9eI5Tisdwto7k5zDxsC06NKU/KrY3e/zf5tmPdcVnVo9TMG3+U1dk7R7/rKaT6MGsFp+6QNavDZloi/HiRBkeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oswVNEdt+PnaaCOqV6MPlfmP6AUlS1l+oi2aBeUm+jk=;
 b=nzWdw2R2JfFfDR75pU2/YKDaLjNBeEEmM8MyzeUpPA61D1cWdpC+2EZxBh2qgDlvZVRRDu6MEcSDLCMzwBETp0r33yvjz1NkLnrvs+CtO5525HIn95UCjK9quFrREpu7QoaVbtQe4/BTNCmqSMDs6Z3hxg31OLm83tN5fYZls20deWOCcWq3fnMbii9bonZl9NuANzv1h02sHYZgwoGCUjXxkj0GzZ1Ks5j7aRMUmkxVPacoiI1WdP1rG6elFNTPbu5cvLFMV2DyzMbctCLu2p0ipCbpAXxWpSfgEWXRhnAMZwrhTp4gHY/wZMP8i+XTxnmJ9jSguVJGfIPRErM1Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 00/19] arm: airoha: add support for en7523 based boards
Date: Sat,  1 Nov 2025 03:44:44 +0300
Message-ID: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d70a5b-c822-4ab3-3253-08de18dfea11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KzVP9kO7QyarcrwICTZEA4Ld4zBZLWKGHfsKEHLvOKNzuDndpVCNh37Kwx1I?=
 =?us-ascii?Q?7lVli4C2dE+zxXKLK4m6gWVYW5xLvdIaIaVdflph4dXgNDIS+sm/0qXIrfEg?=
 =?us-ascii?Q?MzZwPfWGZ63nYJBhMznD0/5Xfzhr51Oerg2KoyWlISqilY2mdDv49XJHCL7n?=
 =?us-ascii?Q?4bFhAmAltoqYEYckzibmxM3bYqIvLzXRVLy3ewYDLgqrUuEb/kKoj2ptuUXJ?=
 =?us-ascii?Q?CeqoWHOHMDoQkSllcF28+2qgflEzbwO8DzGD3afsxv2k4tE+2vJCm9AldXhG?=
 =?us-ascii?Q?9BghzDlcKAsRDQWhpmbZXfg+xn3go4qDgEMuLWosERmpOkPGD8gMJ11+sdVz?=
 =?us-ascii?Q?m42jn/Q2qTAk6ixiDY/xvsDlKmlSknZAHfhyDJTmyPGY4CtCPFcdFSRib4S6?=
 =?us-ascii?Q?0npku9PILd6R+SLOBcoT8JqM+CysQOQuEBTJhm/bYZF71c7Nyt2spjHE09XB?=
 =?us-ascii?Q?fs0zSa5hjzc76Xm7L7iAmJxeEnbMlmaL5k3f4Fcx60j2V7yPnvGJn9fSiVhB?=
 =?us-ascii?Q?tqR+caLUwVtd/SwsrVW/HAKtr1FIYI6zYh8ED+cKVQmwhh3eFhuhE7tIeXOv?=
 =?us-ascii?Q?9gYb7cdVGBhe3mmJq5h9rYfTaCj4YfJ7BgcD8V3wqAbNHwPMHzYPNCE8N73J?=
 =?us-ascii?Q?QCYf3L+MrTKqUneUd2tiuWInpVqcVT7bw8R1moZI2Nb9qd84kZsr1gAwA6sU?=
 =?us-ascii?Q?Vnxshk5SD9acDwDerht+pQo5CypyMOfnQxX0i2kLNjuHyw1HY0xPtidOcZ0q?=
 =?us-ascii?Q?QI3Mm54+nWjfYQcb+UJpU7QC6YrXMGD0ph/RYCfXo6n6GV95nbShJmfbuQha?=
 =?us-ascii?Q?mY+IRGkwtX8Jh4SEv9C1VI/CeCsIbkxPJoCgSBX4vwfgsOwunEZAWaafWzAm?=
 =?us-ascii?Q?nViCS+cczyVLf2nZsgDGOTTKcKBp9LyYRhp03KR/rPPGKbMeQy/fpoMp/1eg?=
 =?us-ascii?Q?rry8xT2+SwxAFOcHwvpGGgCE0A4anWJlArAetnXhDghS1UtXhSWUG4jLgMOz?=
 =?us-ascii?Q?0ZNVkaNBJ6pxCbAAaFzg6eQS/ASx4hGVQ2SRkq86Fyn/BJaCimGjeuAuw505?=
 =?us-ascii?Q?CzlEl6pNIzLEeR41iO70qnVeb6vcfYr7t446A31ZpQb1/3JChG3s8WhklnOb?=
 =?us-ascii?Q?XnId23JNLZJESJb3jh02ZsJAWrr8mlDfN2HfnH1NVrOIK+iqMwE3F491n06i?=
 =?us-ascii?Q?HF4K0styyEaylxizL52KLNZf1rZ5DRVTabv8Z6TdHdqD6geZR02pUXGN+9sy?=
 =?us-ascii?Q?+e3sdL2udeV+icsgZ7YHFb6g8u8smJTKAsHdl/R54j6Y3jOzfxLUfVv/uvUR?=
 =?us-ascii?Q?ILcSb31vw8NLM9O5fenLLVk3Tfx8oHn6yp9I3pkWeJZ370pmBxhLiKa2irIG?=
 =?us-ascii?Q?RhDqm0DD1aSrkBV61cYFOguNVB2EDhXuOY8i9tB+tpPqjkGo2YPUtj7Lnl+N?=
 =?us-ascii?Q?HGsm/JqvqysQDQYHvWc8dQSy4wkqz72rMk5tdavDdiAY8DJodaJpfv04SB42?=
 =?us-ascii?Q?qqRIXgCGnXKHFkZLb062lOGBEonWqJsaAumM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oU1yXb+xCIF9Bmr2mC8WjH7uHH76+RSu0fZ/s7R5nOj5M+JaxV+mR03RCEm1?=
 =?us-ascii?Q?dAK0VqLELe6l+EKtcLs04nfFZqIKgAyrg1242Q5E//5UVsEAbsOB9bM+5bqg?=
 =?us-ascii?Q?EpUp1PZJ5A6h2CYiV/cbR/Gu14zBHP8id6pfsPsSg9LNFI15/dR5e3GaFbFv?=
 =?us-ascii?Q?pfYBo7BtQilb8WlzFBX/st85sTA9RRYeHAKf622xekjmaVNmA2NWdxiAD/10?=
 =?us-ascii?Q?HmTbPCtMbxad+v1R47sxWdELDE8HqGy3CSo0oktoUcaXoW8iZrU7wk8nMv5w?=
 =?us-ascii?Q?5AJORMuR39BKmCBTdVXs/ms/HU1RtXUWrcEjPQVSUc7jhZxX+lqzUehW9QyY?=
 =?us-ascii?Q?H/wK7mdWMBRnkPBv7uB1yQjQLywRgBdEXFR51bF3WvyUtT1gRUIGClejWEBT?=
 =?us-ascii?Q?Dl6wbaQMOdsn/U7L3R1TCjU3ERKK17hIYzMICfU98TIBrihOsoGO83EWspDd?=
 =?us-ascii?Q?Uz+qkDxXxP/DMRmy1CHOcZdn78/AASR+9if8q0mEw0jsBGmyKhVjOY7bKUTT?=
 =?us-ascii?Q?UY1/eKRR9rD8I0cphXq3UQNvIVnnPmDv9AHnG1joNTUbVBALxUO6uA81I5K3?=
 =?us-ascii?Q?jKD3VLVoj3XkoKXJVOmGwrrkmhS2ZKEECh4Ih5ETRXRdrjPFO9tv0/mg7ZNd?=
 =?us-ascii?Q?ToWlBEoyanidpjKD31VcxhZyUgADrY5k8jCC+teBcqtoxiGn+4HmP/98zuDf?=
 =?us-ascii?Q?cGBlY7bAZfXr96u9SYEC5dYi7yFSNqPwFjAiubZwMq0gD4BtsHpnsqoxFyKx?=
 =?us-ascii?Q?o0sNZY+Jb+SRkEBn6AgWfnBfTN4fZwnM/gh4ccZxGvx0VznehtcNJcoewUVZ?=
 =?us-ascii?Q?wG50JAbUsF93jY4oZmi6fQijfVU/De50FQ33dKEByPWgreJfL68xZhLPv+61?=
 =?us-ascii?Q?hhj5uDv5O/0qqPbdXMam/q09TLQDv1KuNKhw0MfYqVuJzTPbeNSsC4CsqgcA?=
 =?us-ascii?Q?jOHw1EtZOWCfK1FQD8MfnzbugnESi87TnzEToWGSseWhTAX4hXbSrE3w8XQs?=
 =?us-ascii?Q?apisLUsGiXmxJZcxvayQO5qnWbTSTZvEyUM8j4iJjrUDGs7nN+twRGrtx9vD?=
 =?us-ascii?Q?Elz2zG2B5XbTnjklXm2p+F0/b5ZM1nUuMeM5b/fsWst01AyvFigYQP1OHjO3?=
 =?us-ascii?Q?ZcZ5laa/LWuZYixWzR6RN5H/MIOicUzJUd0TL/ELyFTk3XArH3bnwY5dHXV5?=
 =?us-ascii?Q?2SeN7GSNM2zg9GmqRScliH3wtmuk0cKhmXyC2+HkhvNHpUX4hzAdvg+MoZTE?=
 =?us-ascii?Q?tl1QRbJGOFS9m4hb6IcOmGLRsZ1fKKF+01beLF6nx5sqTnUjJFsQVX1Ju7K0?=
 =?us-ascii?Q?dLTeBx2VX1x8Y8gkSTfR3ixvtRuTp+9xZl7B79fTZ8zWel062UfsAsZeFNt/?=
 =?us-ascii?Q?6d4Jm4EIeGTLuk3eO6wTTFJ4vf2MhXggm39PMKLpWevgu5ivtsflLmVud5xB?=
 =?us-ascii?Q?1M1hjXzqCUsZm9Xu/xnDl0h6uiCJ0LNf4PdJkecLZD5mLVvT6WuGfX+Iz1Ys?=
 =?us-ascii?Q?nlAOnEuPGF45+plBj3f86E/niTUG6hsuJvccD6mldriJOF6go/FrIMUQPx+s?=
 =?us-ascii?Q?UCMoYck/PdYVonQ4S71HpYiJvc1bLBrc4tFMXbAodkvwZbhY6Z3rDDMt5pFW?=
 =?us-ascii?Q?tU3j6iCARimer5LiK2k8wm4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d70a5b-c822-4ab3-3253-08de18dfea11
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:12.0003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0eGluYR2aCvukrdf9uIIEw2dFuIznXZZSSVz5Ng94u/4NDxiNKCbF2QBv33j7YuQvI3pJpaphhmGfmSicPheBE8qzGI7CVnHKfdlJmAqhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

This patch series adds basic support for the boards based on Airoha
EN7523/EN7529/EN7562 SoCs. Due to ATF restrictions these boards are
able to run 32-bit OS only.

This patch series adds support for the following hardware:
 * console UART
 * ethernet controller/switch
 * spinand flash (in non-dma mode)

The following issues may be expected:
 * Extra slow UBI attaching in U-Boot (up to 20 sec with fastmap enabled).
   This is caused by the lack of DMA support in the U-Boot airoha-snfi driver.
 * Linux airoha-snfi driver in some cases might damage you flash data
   (see: https://lore.kernel.org/lkml/20251012121707.2296160-15-mikhail.kshevetskiy@iopsys.eu/)
 * Latest linux kernel is recommended to properly support flashes
   with more than one plane per lun
   (see: https://lore.kernel.org/lkml/20251012121707.2296160-7-mikhail.kshevetskiy@iopsys.eu/)
 * It's NOT recommended to use flashes working in continuous mode because
   U-Boot airoha-snfi driver does not support such flashes properly.

The patches was tested on the board:
 - SoC: Airoha EN7562
 - RAM: 512 MB
 - SPI NAND: 4 Gbit, made by Toshiba
 - Linux boot: was NOT tested

The U-Boot was chain-loaded from the running U-Boot. Airoha ATF-2.3 does
not allow easily chain-loading of U-Boot from U-Boot, so a special FIT
image (mimic linux kernel) was created

1) Create u-boot.its file with the following contents:

=== cut here ===
/dts-v1/;

/ {
	description = "ARM OpenWrt FIT (Flattened Image Tree)";
	#address-cells = <1>;

	images {
		u-boot-ram {
			description = "OpenWrt U-Boot RAM image";
			data = /incbin/("u-boot.bin.lzma");
			type = "kernel";
			arch = "arm";
			os = "linux";
			compression = "lzma";
			load = <0x81e00000>;
			entry = <0x81e00000>;
			hash@1 {
				algo = "crc32";
			};
			hash@2 {
				algo = "sha1";
			};
		};

		fdt-1 {
			description = "OpenWrt device tree blob";
			
			data = /incbin/("dts/upstream/src/arm/airoha/en7523-evb.dtb");
			type = "flat_dt";

			arch = "arm";
			compression = "none";
			hash@1 {
				algo = "crc32";
			};
			hash@2 {
				algo = "sha1";
			};
		};
	};

	configurations {
		default = "config-ram-uboot";
		config-ram-uboot {
			description = "OpenWrt RAM U-Boot";
			kernel = "u-boot-ram";
			fdt = "fdt-1";
		};
	};
};
==================

2) Create u-boot.itb image to chain-load new u-boot from the old one

  lzma_alone e u-boot.bin u-boot.bin.lzma
  mkimage -f u-boot.its u-boot.itb

3) Load new u-boot from the old one

  U-Boot> tftpboot u-boot.itb && bootm


Christian Marangi (1):
  reset: airoha: convert to regmap API

Mikhail Kshevetskiy (18):
  airoha/an7581: add CONFIG_TARGET_AN7581=y to the defconfig
  arm/airoha: add support for airoha en7523 SoC family
  arm: airoha: introduce AN7581 helpers to get SCU and CHIP_SCU regmaps
  arm: airoha: introduce EN7523 helpers to get SCU and CHIP_SCU regmaps
  clk: airoha: use CHIP_SCU regmap helper
  clk: airoha: add support for airoha en7523 SoC family
  configs: airoha: en7523: enable clk support
  reset: airoha: unify code using SCU regmap helper
  dt-bindings: reset: Add reset support for Airoha EN7523
  reset: airoha: add support for airoha en7523 SoC family
  dts: airoha: en7523: add reset controller support
  configs: airoha: en7523: enable reset controller support
  net: airoha: unify code using SCU regmap helper
  net: airoha: add support for airoha en7523 SoC family
  dts: airoha: en7523: add ethernet controller support
  configs: airoha: en7523: enable ethernet controller support
  dts: airoha: en7523: add spinand flash support
  configs: airoha: en7523: enable spinand flashes support

 arch/arm/dts/en7523-evb-u-boot.dtsi           |  11 ++
 arch/arm/dts/en7523-u-boot.dtsi               |  70 ++++++++++
 arch/arm/include/asm/arch-airoha/scu-regmap.h |  13 ++
 arch/arm/include/asm/arch-an7581              |   1 +
 arch/arm/include/asm/arch-en7523              |   1 +
 arch/arm/mach-airoha/Kconfig                  |  14 ++
 arch/arm/mach-airoha/Makefile                 |   1 +
 arch/arm/mach-airoha/an7581/Makefile          |   1 +
 arch/arm/mach-airoha/an7581/scu-regmap.c      |  30 +++++
 arch/arm/mach-airoha/en7523/Makefile          |   4 +
 arch/arm/mach-airoha/en7523/init.c            |  33 +++++
 arch/arm/mach-airoha/en7523/scu-regmap.c      |  38 ++++++
 board/airoha/en7523/Makefile                  |   3 +
 board/airoha/en7523/en7523_rfb.c              |  16 +++
 configs/an7581_evb_defconfig                  |   1 +
 configs/en7523_evb_defconfig                  |  67 +++++++++
 drivers/clk/airoha/clk-airoha.c               | 127 ++++++++++++++++--
 drivers/net/airoha_eth.c                      |  78 +++++++----
 drivers/reset/reset-airoha.c                  | 106 ++++++++++++---
 include/configs/en7523.h                      |  21 +++
 .../dt-bindings/reset/airoha,en7523-reset.h   |  61 +++++++++
 21 files changed, 642 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/dts/en7523-evb-u-boot.dtsi
 create mode 100644 arch/arm/dts/en7523-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-airoha/scu-regmap.h
 create mode 120000 arch/arm/include/asm/arch-an7581
 create mode 120000 arch/arm/include/asm/arch-en7523
 create mode 100644 arch/arm/mach-airoha/an7581/scu-regmap.c
 create mode 100644 arch/arm/mach-airoha/en7523/Makefile
 create mode 100644 arch/arm/mach-airoha/en7523/init.c
 create mode 100644 arch/arm/mach-airoha/en7523/scu-regmap.c
 create mode 100644 board/airoha/en7523/Makefile
 create mode 100644 board/airoha/en7523/en7523_rfb.c
 create mode 100644 configs/en7523_evb_defconfig
 create mode 100644 include/configs/en7523.h
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

-- 
2.51.0

