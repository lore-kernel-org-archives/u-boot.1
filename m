Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C18CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C4983B21;
	Sat, 11 Oct 2025 20:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BtJSbchy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D5783E11; Sat, 11 Oct 2025 11:14:42 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3896A83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKwwucxOQ/Rovu2F3i+G1HVmsC4BSwVmhyqnNlgq+d8c6wl7DLKmPyiH4EeZsgUz/EhKLxKWtHTK1WMMFVilUPBTLiFTy1RvOsHRleVscUD68Tim0hc4emNRjRKwpgs0BSfE59oegE/D2JQm/WTH2rFP4BsLXdAdr9Gn5vbwHhY86KSXRUSrbDUxZFb/IW6sY7uOtZpaK50FZTawiFE2nghgSPOkfsxmB8corIw/HNsIF5lpR9P+WLTy3B/4PLp9+/8+BnrGId3QoLkR3qphAW0/gP+1M8yYihUiVVXAz6G4y6vBnoZWRvIzLA/Wh9iiLZBlN/Qq36cDvaLY2bFE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkcjCaAp/o/vhYose6vXIzYZm/p4ufGMXdCRP1XI1xw=;
 b=loWlAqw9BsKzJI3EruQ1rGdedjfW2EHK+09wTp63lLJdxe8blbua/WpPmB2XXJhYDA6KLuXvQB/7Ya82U6P8XKXaiZesC4vkl4qWWkx3+vPyMcI8hQF1Dn7ZS6LVZi6uT2gaojNv/J7xqmEI1AAKdnCp40nx4pFO648fxSzOV8SHiR3d79aQHUsOVfP2JoFLdaZ3eWCIHBVhS7R9uZfOFjDhZtC3WcIezs6IdHyAWS01pTHk12jwtEHEJZeZvbFsRJIj9H1Jv199cMfN2FPWU3MYKuCsg/OlmZA69DRMIuuCug0Up3bUduSx89nbLxBeXeE9nfbz66p+F329O/a2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkcjCaAp/o/vhYose6vXIzYZm/p4ufGMXdCRP1XI1xw=;
 b=BtJSbchyobPQxqF/xFMRbhwul6Pdjt9ixNTrPGNw2BS/lsyt/THwU/fivoiM1YRDpSSR9ylpXFFTjp3yQWJCi28toOa+tVsycM2kbQTu0iyNDSBNdApX/Lr7diHWZUimzDbScDSuoRYfuYaS4HO3QhjyOJ5TI1/nnxwn5VRppt3NHYdiOatadAeEzZY1Dy4UvmolIuicqAwSYYGiBAINKVmclc2s1r+R/F6DZXP5O8CdUMjFoit1rnpUCcEyb2gBJYYNR2EAGt92H1EUOE04HH69cqQ9FuCpDL9q9oB1yTN/wPVYbuE9i0FlLkrLu7skvt7CAl1a5rcbdgEXsbApKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:14:38 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:14:37 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:56 +0800
Subject: [PATCH v2 08/10] net: fsl_enetc: Add i.MX94 support to NETC block
 control driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-8-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 113090da-95dd-4ebd-c111-08de08a699fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnpQUjF0M21KNE96VzhPeWhkS05MTEFkcVZ0MDNYaGxsVDRmOTFhQ2t5L2pN?=
 =?utf-8?B?SURCUTdtb0tNc3V4N3NIZW1VdWVhd2Jsdzh4RFBHSjNRb2RQcWFvVStybFp3?=
 =?utf-8?B?SlJ1MmtwWFFXMlZMSElRa3QrNFZiNmplZW1uYkgwd2dNV0J4UGcxY2gxZHk5?=
 =?utf-8?B?TldLWjIzSmpGUHlMamJITXBvMms2TDR5c0JXVG41Z3k0Z2xsQVpOamNtaGs0?=
 =?utf-8?B?NUpsZktMejVLbXBYNDVLa3ZHQnFDMzhLSzJjbnVnRlcycWx2c29DdUdaRHVV?=
 =?utf-8?B?L1puN1U2ZmYwVDJ5L3J5ODR3UmJkanI0RUhQSDdCMHczWjRNdmVpNnlCWmhi?=
 =?utf-8?B?MGdKWTdrVE40amlyalk3UzlBeWZlWmVpVElQNmpNZExFc1ZMM3BZVGw1YlY5?=
 =?utf-8?B?WlBuQ3l5MWlyWlBYTjg4L1hwZHRhMTBkQnM4MVAvUzI3QXZWYXpubTRmQlN4?=
 =?utf-8?B?VitGd05CR1IxRS9ISHAzQjdUTGJEYTMxeTVrelpSZysyaGY5MDVpSzhWZ2dF?=
 =?utf-8?B?SHNyVnFzdUN3aXljQktyZ1BVbkhpdGdpTkgzRFNKSjg0cnlTSVBpZU55RWxz?=
 =?utf-8?B?aGlSaGJEbVRReDBNa2NqcDBZM21FMGJLejFPL08rV3AvbngrQ1pMRndXTGJM?=
 =?utf-8?B?WC84RWpTbnBCK3FnZU1OU3RTQmRWaXVWTHNla3hIMHMya0lJVGlTNVFDVWRi?=
 =?utf-8?B?OTVjMGVnZ1JRbWZiRWEydXhLU2t6bFRvU1FEQm80ZmFOcEUwUnVHWVBRU3pj?=
 =?utf-8?B?cjNONjhidzM2UEt2OFppNDk0OXBVaGdQejBiNFFFNWJlRU93a21wcUNVZ3Mv?=
 =?utf-8?B?QytTcVNlaHozV0g5Mzkxd3hmT3BLNUhjUHBYV20wYzNCYTBZZC9TeW5xR1dw?=
 =?utf-8?B?dDZCR0pselQvcnh3ZlR6VERxNTNvTGNZaVZHZDA2dktBVTdBYTM1YXRKYk15?=
 =?utf-8?B?ME8rV2hFWVkvY0E2dEs3OThiSmNwMGZkRFlXaXJ5Z0gvR1lmVWRQTTh1MWNM?=
 =?utf-8?B?SyszbDRLa2d1OG9TMnBQQUNZWlo4SnI0NmNDRGJkcERzNGNvOFZoSlM5ZGl0?=
 =?utf-8?B?Y0dUdDQ0Z254M1V3VmF5U0Y1QjlvTVpGOGpJOTU5bmVid3FJM3ZuM0lPV0Zq?=
 =?utf-8?B?VllvNzB5VnUzclRvc2dxU0NUakdHU3JYYXA2MTlreWhTV1VJWGw3bTllT09R?=
 =?utf-8?B?dG9NQ2tNaytaNXN1SHlyTlJoaXRkcFRaRUNjTTNaNmZ4UnNsdmVDMkdvbm5p?=
 =?utf-8?B?ZEVHZkUwQ05RcGp5aHFldXpKZ0h4SjRrUHJ2aVFlQ3U5N3lwRVZZZmNCVyt5?=
 =?utf-8?B?Q3lrbjF3bkN4UmpHZ2Nsa0RLNkRVWmdCOG4xYWtlM000MG50dWczZmFyZ0Z0?=
 =?utf-8?B?Qnh2UGhPWlB5aW50UE9lbG9rbFZ4MmhoYXg3VlN2K0d6ZGZ5VkJkTkhOdGdv?=
 =?utf-8?B?T3ZISG5DT3U1YnJoZjJDc3N4RTZPenl1UC9ZNURkblNCdXh4NFc1TUV0K2h4?=
 =?utf-8?B?OFVrSityeVJPQUluRGNhRW8rcmUrYUZFSVpsRzdRU0VhT0lSbkVhQjQ3a0dF?=
 =?utf-8?B?ek5CZm1CYnhwRFQ3Mi9xRUY5ZnREb21udGhtNmE0K282eW9nWmdTMUd1aURz?=
 =?utf-8?B?cDRySmZvNFJIeG5XUy9OSlR4Wm1GdGlibTJhU2RqSTByRU9FcWt3c1ROaFFr?=
 =?utf-8?B?Z3gvN09mRjJjcUh5NFNUcVJZdm9pUW9wblJBbms5SDZkSXNFc29weDZoTHRh?=
 =?utf-8?B?aWYySGpTS0JOc2NKbi9pQVF3UXdkZStMQ1lrUkhTSUxXQWV1bnpNL0ZOY3VY?=
 =?utf-8?B?Z0dpYllJN2lhQzRLbXBGVElaRm9XQ2JhZkpTd2hEMlZibFJCa2szL1llbHFw?=
 =?utf-8?B?VGdPM3J6dVgrMkFoRGJZTEozdzU1bGMwNThMb0dtSkdjNEV5WXMydVFMT2RX?=
 =?utf-8?B?UWZQNzJkYlNjbHJnUFNvOFYxZnMzcm9LejR3QmhJTEdOSnZvL2pqbkI2WXU3?=
 =?utf-8?B?R3h3UENyTmV3dmMvaGx4TXdsYVVWdVovUWZFRWh0UWNjNms4bFBrY1NrUEpk?=
 =?utf-8?Q?0wUEWh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFN2YVpCcmdSaWdPVzlkWDJTMHRibi9HZTNGdzRIcWRhdEpZL0R4K01CejJk?=
 =?utf-8?B?ektvOUFmWEkvM2RGK202N1BpdGpYZ25NS3FLM2lYMEQ5RnZvT3B2Y0VKMERa?=
 =?utf-8?B?MjNCclhnWUFLcnhEeldHNGRMczM5bDFDb1ZvK2dVSkdET0wwR1JGSytFT3gw?=
 =?utf-8?B?V1QyQmFlWUFPUXcxWitEUWlMd1YxeWdKeVl5L0I5S3IyenNHZTBJai92OHpr?=
 =?utf-8?B?ZlJRcGlBejVTdkgwa2FZZ2ZoZ1NtdkZIWU9DaEt1SmFlY0M5ZGNqajNZR1Bi?=
 =?utf-8?B?UzZVZHFpZTZaS08weUkxRk5ZdU9lNjZsRG01VFhaWVBVSVRJSlFJL0pHV3Zi?=
 =?utf-8?B?eXExZkxoSVhXTEtodGRwNFhmTHQ0UE04VXIvak5laXdJL1VCWG5iMk1HVFl6?=
 =?utf-8?B?a3huanUxc0o3aHBpT3FXUTY5eWlKUSsrTWV4Zkd6VHU4TWZaejBuUnJXQ1g1?=
 =?utf-8?B?TGJtZEV5R3VnQndOSHNndVZ1MGMvSkpYK3UyQVJUb0l1VkNNa2FneTVHUVZI?=
 =?utf-8?B?LzN2ZWRTTXBaSFlxWTMvQVRmVVBISm9ZdkxWSTllVkx4c1ozQVFTR1Q3aGYy?=
 =?utf-8?B?WEc2bVFzREhoTjVqaURNaFo4eXJNYkRzZXRlM29XQWZHSG5MYWdoQktzM2cv?=
 =?utf-8?B?Smk4cHBZM1NOVkI1WDB5VkN5UEpXN2k5VytaSDZGeW5vMnpTaUpReTJPS05p?=
 =?utf-8?B?djRzdjQzSVE1bE9FSHFBVi8wL2xIZUcrM0NsOUJYMFFYWUlUNk0rNXluWXhJ?=
 =?utf-8?B?RTNpaWNaSGtnNmYxRndNeFdXZHg1eFdvOWFQVHJtSjQwVzkxUUxmcHZHbkIw?=
 =?utf-8?B?eE5ndmxMU2poR1ZVUi8vbjROeEM4RnlGb2pzVHZacnZWSkdMUDgzaUxqLzBt?=
 =?utf-8?B?aWtVRXNNTmlOMUp6MFNYR3g2MkRtWkptTERGaVF4dzlQZExkTGhBTGFJemdo?=
 =?utf-8?B?bDJpRmc4bFl0QXcxcmlUQ29paFYwM1B2VGg2QTFSY1BvV0phR2haMHlhNncv?=
 =?utf-8?B?cnloN2lPWWJ1cXF1T2J6S1dSRGJJRmpKamcxTDdMd0pHUS9QS28xbXI5TUNh?=
 =?utf-8?B?SXVYN2R0bGVVUE1tbHU5NzI4Tkh3N0N6R3NvM0ZtZWE4ZlZRNWd0Zmc4clVy?=
 =?utf-8?B?a1p2dm9rWSt4ZXBjb2lGQkRyS1BZQVhYenpEc3V3T2hYOU9kN1lRSXVaaXNt?=
 =?utf-8?B?dEE4bk9JeE1QeXJZTExrSmw5cmR5dUhoR1RNYmFyVExic0R3RFFsQ1VTcXFz?=
 =?utf-8?B?VWRVVjYzN1J2K25WRkZGVVZmbE41WDY4TlpCUXppY2JRNUs2WWRJN1Q3UFoy?=
 =?utf-8?B?ckVBUEwydzk1ejcvRFRWZ3VIZmtHSWJCdDIrTWVpSUhMZHBQa1FaY3dUN2lV?=
 =?utf-8?B?SWZUdk1lOEJIOERlcklta3JxYjBubXo3akpyTWVtUXd1Qko3cTVoTlJkUkVK?=
 =?utf-8?B?d1dkcGVabE94Zk9XbTRrc2tnNi80K1VLSlJyb1FDVS83V1p5T1YwTGdrTHBy?=
 =?utf-8?B?bnZza2ZHZk0wbFFBbUJiSFNmUE5PZWhxTm52YjRCcjR1MzcyUFdueEpFQS8y?=
 =?utf-8?B?VTI5R3FtbFhMaEZrYnZ1WUthOHd4R3lhU3Rhd01JSEdOdys3dDRsUHF2cnJ2?=
 =?utf-8?B?V29IcFZWWlBSMHVER0kyaTJKMGN2TVlvb1ZJOW9oQnhXR0VqUjVUcmlWT2Ry?=
 =?utf-8?B?Y0xDVUVqRXI3c3pVaXVWdDRRWERFQ3VLbUdsaDA1MERoUFRmMU81VVlsd0pK?=
 =?utf-8?B?TXExQzZpSHdWd1Q4MGR3TFJBNWUrb1FGU0x1aW5rY3hrQnRic01PUERiUHF6?=
 =?utf-8?B?d1pQQkxUUlFUZGcvNmNKS3NZcnhoc1hFU2FDbTNMNkwyZWJOa0xxeGRDTWF1?=
 =?utf-8?B?bWF6NVJmc2RmRUp0L3h2c1RQbm9hZVl2Tm5NSFl6ZUZZTC9NSExPQ0YwOGNC?=
 =?utf-8?B?QnRxY05JOStDYXc1SXBxZGZJYzhMaGVsQ09QVCtuaUNZeXBnSkZrSXFUOFBD?=
 =?utf-8?B?Z3lmQU5MYVlPOGgvZUtpTDZPakQrNzA0cTMvQmcyanA2dTlnejdvQ0RITFQy?=
 =?utf-8?B?azdZUzQ2UU1razZWdDB6ZUVLWVIwY3BETkdRQmx0dmJjcVFkUzhZOUJBYUJw?=
 =?utf-8?Q?z/P67uWhnpGBUKGIXrJV2auHX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113090da-95dd-4ebd-c111-08de08a699fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:14:37.5797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRbACC54tJjG1Xs4sXVilSaVjqQkdJGfqX7s00C0A7o57+SqVLAQ3yF2kNKKqdWQX7fPmOvya5++y5L48s/XSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

From: Ye Li <ye.li@nxp.com>

Extend the NETC block control driver to support the i.MX94 SoC.

Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/Kconfig                   |   5 +-
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 338 +++++++++++++++++++++++++++++++++-
 2 files changed, 333 insertions(+), 10 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 7ae28c4e0d5..b292f7a6c42 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1002,8 +1002,9 @@ config FSL_ENETC
 
 config FSL_ENETC_NETC_BLK_CTRL
 	bool "NXP ENETC NETC blocks control driver"
-	depends on FSL_ENETC && IMX95
-	default y if IMX95
+	depends on FSL_ENETC
+	depends on IMX95 || IMX94
+	default y if IMX95 || IMX94
 	help
 	  This driver configures Integrated Endpoint Register Block (IERB) and
 	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
index fecd66eb15a..42e25ac8d5f 100644
--- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -43,6 +43,19 @@
 #define PCS_PROT_SFI			BIT(4)
 #define PCS_PROT_10G_SXGMII		BIT(6)
 
+#define IMX94_MISC_SOC_CONTROL		0x0
+#define SEL_XPCS_1			BIT(1)
+#define IMX94_XPCS_PORT_0		0x0
+#define IMX94_XPCS_PORT_1		0x1
+
+#define IMX94_EXT_PIN_CONTROL		0x10
+#define MAC2_MAC3_SEL			BIT(1)
+
+#define IMX94_CFG_LINK_PCS_PROT(a)	(0x14 + (a) * 4)
+#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
+#define NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
+#define NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
+
 /* NETC privileged register block register */
 #define PRB_NETCRR			0x100
 #define  NETCRR_SR			BIT(0)
@@ -55,6 +68,7 @@
 /* NETC integrated endpoint register block register */
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
+#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -64,6 +78,26 @@
 #define IMX95_ENETC1_BUS_DEVFN		0x40
 #define IMX95_ENETC2_BUS_DEVFN		0x80
 
+#define IMX94_ENETC3_BUS_DEVFN		0x0
+#define IMX94_TIMER0_BUS_DEVFN		0x1
+#define IMX94_SWITCH_BUS_DEVFN		0x2
+#define IMX94_ENETC0_BUS_DEVFN		0x100
+#define IMX94_TIMER1_BUS_DEVFN		0x101
+#define IMX94_ENETC1_BUS_DEVFN		0x140
+#define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_TIMER2_BUS_DEVFN		0x181
+#define IMX94_ENETC0_LINK		3
+#define IMX94_ENETC1_LINK		4
+#define IMX94_ENETC2_LINK		5
+#define IMX94_ENETC0_OFFSET		0
+#define IMX94_ENETC1_OFFSET		1
+#define IMX94_ENETC2_OFFSET		2
+#define IMX94_SWITCH_PORT2		2
+#define IMX94_SWITCH_CPU_PORT		3
+#define IMX94_TIMER0_ID			0
+#define IMX94_TIMER1_ID			1
+#define IMX94_TIMER2_ID			2
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -73,6 +107,15 @@ struct netc_blk_ctrl {
 	void __iomem *netcmix;
 };
 
+struct netc_devinfo {
+	int (*netcmix_init)(struct udevice *dev);
+	int (*ierb_init)(struct udevice *dev);
+	void (*xpcs_port_init)(struct netc_blk_ctrl *priv, int port);
+};
+
+static struct netc_blk_ctrl *netc_bc;
+static struct netc_devinfo *netc_di;
+
 static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
 {
 	writel(val, base + offset);
@@ -183,6 +226,150 @@ static int imx95_netcmix_init(struct udevice *dev)
 	return 0;
 }
 
+static int imx94_enetc_get_link_num(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC link number */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_LINK;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_LINK;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_link_config(struct netc_blk_ctrl *priv,
+			     ofnode np, int link_id)
+{
+	phy_interface_t interface;
+	int mii_proto;
+	u32 val;
+
+	interface = ofnode_read_phy_mode(np);
+	if (interface == -1)
+		return -EINVAL;
+
+	mii_proto = netc_get_link_mii_protocol(interface);
+	if (mii_proto < 0)
+		return -EINVAL;
+
+	val = mii_proto & NETC_LINK_CFG_MII_PROT;
+	if (mii_proto == MII_PROT_SERIAL) {
+		int pcs_proto = PCS_PROT_1G_SGMII;
+
+		if (pcs_proto == PHY_INTERFACE_MODE_2500BASEX)
+			pcs_proto = PCS_PROT_2500M_SGMII;
+
+		netc_reg_write(priv->netcmix, IMX94_CFG_LINK_PCS_PROT(link_id),
+			       pcs_proto);
+		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
+				       NETC_LINK_CFG_IO_VAR);
+	}
+
+	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
+
+	if (link_id == IMX94_ENETC0_LINK) {
+		val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
+		val |= MAC2_MAC3_SEL;
+		netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
+	}
+
+	return 0;
+}
+
+static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
+				   ofnode np, bool *enetc0_en)
+{
+	int link_id;
+
+	link_id = imx94_enetc_get_link_num(np);
+	if (link_id < 0)
+		return -EINVAL;
+
+	if (link_id == IMX94_ENETC0_LINK)
+		*enetc0_en = true;
+
+	return imx94_link_config(priv, np, link_id);
+}
+
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    ofnode np, bool *swp2_en)
+{
+	ofnode ports, child;
+	int port_id, err = 0;
+
+	ports = ofnode_find_subnode(np, "ports");
+	if (!ofnode_valid(ports))
+		ports = ofnode_find_subnode(np, "ethernet-ports");
+	if (!ofnode_valid(ports))
+		return -ENODEV;
+
+	ofnode_for_each_subnode(child, ports) {
+		if (ofnode_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		if (port_id == IMX94_SWITCH_CPU_PORT)
+			continue;
+
+		if (port_id == IMX94_SWITCH_PORT2)
+			*swp2_en = true;
+
+		err = imx94_link_config(priv, child, port_id);
+		if (err)
+			goto end;
+	}
+
+end:
+	return err;
+}
+
+static int imx94_netcmix_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode child, gchild;
+	bool enetc0_en = false, swp2_en = false;
+	int err;
+
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		ofnode_for_each_subnode(gchild, child) {
+			if (!ofnode_is_enabled(gchild))
+				continue;
+
+			if (ofnode_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild, &enetc0_en);
+				if (err)
+					return err;
+			} else if (ofnode_device_is_compatible(gchild, "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild, &swp2_en);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	if (enetc0_en && swp2_en) {
+		dev_err(dev, "Cannot enable swp2 and enetc0 at the same time\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -238,9 +425,99 @@ static int imx95_ierb_init(struct udevice *dev)
 	return 0;
 }
 
+static int imx94_enetc_get_enetc_offset(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC offset */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_OFFSET;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_OFFSET;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_OFFSET;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_get_timer_id(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC PTP timer ID */
+	switch (bus_devfn) {
+	case IMX94_TIMER0_BUS_DEVFN:
+		return IMX94_TIMER0_ID;
+	case IMX94_TIMER1_BUS_DEVFN:
+		return IMX94_TIMER1_ID;
+	case IMX94_TIMER2_BUS_DEVFN:
+		return IMX94_TIMER2_ID;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv, ofnode pf_np)
+{
+	ofnode timer_np;
+	int offset, tid;
+
+	offset = imx94_enetc_get_enetc_offset(pf_np);
+	if (offset < 0) {
+		printf("Find unknown PF node.\n");
+		return offset;
+	}
+
+	timer_np = ofnode_parse_phandle(pf_np, "nxp,ptp-timer", 0);
+	if (!ofnode_valid(timer_np)) {
+		/*
+		 * If nxp,ptp-timer is not set, the first timer of the bus
+		 * where enetc is located will be used as the default timer.
+		 */
+		tid = IMX94_TIMER1_ID;
+		goto update_reg;
+	}
+
+	tid = imx94_enetc_get_timer_id(timer_np);
+	if (tid < 0) {
+		printf("Incorrect bus/devfn of ptp-timer.\n");
+		return tid;
+	}
+
+update_reg:
+	netc_reg_write(priv->ierb, IERB_ETBCR(offset), tid);
+
+	return 0;
+}
+
+static int imx94_ierb_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode bus_np, pf_np;
+	int ret = 0;
+
+	dev_for_each_subnode(bus_np, dev)
+		ofnode_for_each_subnode(pf_np, bus_np)
+			if (ofnode_device_is_compatible(pf_np, "pci1131,e101"))
+				ret = imx94_enetc_update_tid(priv, pf_np);
+
+	return ret;
+}
+
 static int netc_ierb_init(struct udevice *dev)
 {
 	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
 	int err;
 
 	if (netc_ierb_is_locked(priv)) {
@@ -251,9 +528,11 @@ static int netc_ierb_init(struct udevice *dev)
 		}
 	}
 
-	err = imx95_ierb_init(dev);
-	if (err)
-		return err;
+	if (devinfo->ierb_init) {
+		err = devinfo->ierb_init(dev);
+		if (err)
+			return err;
+	}
 
 	err = netc_lock_ierb(priv);
 	if (err) {
@@ -264,6 +543,31 @@ static int netc_ierb_init(struct udevice *dev)
 	return 0;
 }
 
+static void imx94_netc_xpcs_port_init(struct netc_blk_ctrl *priv, int port)
+{
+	u32 val;
+
+	val = netc_reg_read(priv->netcmix, IMX94_MISC_SOC_CONTROL);
+	if (port == IMX94_XPCS_PORT_1)
+		val |= SEL_XPCS_1;
+	else
+		val &= ~SEL_XPCS_1;
+	netc_reg_write(priv->netcmix, IMX94_MISC_SOC_CONTROL, val);
+}
+
+void netc_xpcs_port_init(int port)
+{
+	struct netc_blk_ctrl *priv = netc_bc;
+	struct netc_devinfo *devinfo;
+
+	if (!priv)
+		return;
+
+	devinfo = netc_di;
+	if (devinfo->xpcs_port_init)
+		devinfo->xpcs_port_init(priv, port);
+}
+
 static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 {
 	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
@@ -272,14 +576,27 @@ static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 	return 0;
 }
 
+static const struct netc_devinfo imx95_devinfo = {
+	.netcmix_init = imx95_netcmix_init,
+	.ierb_init = imx95_ierb_init,
+};
+
+static const struct netc_devinfo imx94_devinfo = {
+	.netcmix_init = imx94_netcmix_init,
+	.ierb_init = imx94_ierb_init,
+	.xpcs_port_init = imx94_netc_xpcs_port_init,
+};
+
 static const struct udevice_id netc_blk_ctrl_match[] = {
-	{ .compatible = "nxp,imx95-netc-blk-ctrl" },
+	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = (ulong)&imx95_devinfo },
+	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = (ulong)&imx94_devinfo },
 	{},
 };
 
 static int netc_blk_ctrl_probe(struct udevice *dev)
 {
 	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
 	struct clk *ipg_clk;
 	fdt_addr_t regs;
 	int err;
@@ -318,10 +635,12 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 
 	priv->netcmix = (void __iomem *)regs;
 
-	err = imx95_netcmix_init(dev);
-	if (err) {
-		dev_err(dev, "Initializing NETCMIX failed\n");
-		return err;
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(dev);
+		if (err) {
+			dev_err(dev, "Initializing NETCMIX failed\n");
+			return err;
+		}
 	}
 
 	err = netc_ierb_init(dev);
@@ -333,6 +652,9 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 	if (netc_prb_check_error(priv) < 0)
 		dev_warn(dev, "The current IERB configuration is invalid\n");
 
+	netc_bc = priv;
+	netc_di = devinfo;
+
 	return 0;
 }
 

-- 
2.43.0

