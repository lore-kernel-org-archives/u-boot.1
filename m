Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029C3CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F61D83E81;
	Sat, 23 May 2026 14:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fNeqNUnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE58D83E81; Sat, 23 May 2026 14:23:10 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E99D84825
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5fyyT0OL6q2GrCqC78+J0pLa6Teh7q3+O1PsqDY23HH9tqejXjtrtyVz3IyEPU2ZdC54K6vFPFvBjm97tFx/x5ZNcaFmXzHcuzHwP+6mONJfPBP4f96hXrH/+/x1rzP6oudUN20gXLRaiLr5EOP2KLRsK8rYBR5ttoBwU6j1jokjJ/iWEPDUmn5UrHim+PBlKTAr6Tx+xYL/NPa4Khfq93M/JKfvwGupJG2NPB/kA7xlOThrhFgPSPa6Am7RvoHFf45pkoVTbtoKeQ7Qn0KoCe6Qae6XTPYJPeQXnITOjQAhf4XWAUvZZd+hH39WODLD4mVFvNvTHPX86bBqfm+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8tInIzbM5ETyn+PwCLdb0gOyeaKhDRNUL7bkuFLAnA=;
 b=jifEpkNH/L52pICfduDQFzf5XV++s73r+5cTDxBS7mm+MWLrUoUrF1ZvY7b0+P0qH2ErDSiTJQ/adETU5OE65Pg/ez4ouE9oHENvODyhin15OiBsn25mrRuxCf6uInkMf3B9MNk88mPz8hD35LYIk/jtAp7VGN4TFx/ECQuvlkX74k73ZWfRTZW4LB08a3tMnGXuYqvppfnaBIoQzqVBsr3TvG3CvD/9JKcQ48LrM0WsaOeP/wuqXEPA0RQNLsLoXDwlFcyvL3tPaGp+8WHvL3nFH/bzeXxjMKAudnL4/wEIcY5yu7iPo2o6OQ9XTqin1N1S+xlFZqTwIo1N4wQ39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8tInIzbM5ETyn+PwCLdb0gOyeaKhDRNUL7bkuFLAnA=;
 b=fNeqNUnCWpuEPOLVUsXxXXD81GngQmbdHbLM3XGJjtX4S1T4xGbruS/j5U+n1n6IVgR0rRsbFJnCzLjg3Jqxw47GnGa60mWFHLLUBoFXBG19HtZX9RLJnBigt/quUMZrVaSO+a4uRnFZxYKc5RHaYh0+7I67y1nkgU8J4N6vfxRO+7dx6ymB3HwynFf4Wcp/dIzbFHoo4WENJhWqzIbH71xjcNNli0gM9vt1Ojsxa5NnFiFRkJDVJqqsj9qUP5soG18fcuZ0l/LAu2bYViV2AP4EcPq6LTPuWskdMitCPYRw8ysHCiORRUxut50Q2aOJDiMuUth33H+Pp3BUBK6ISA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:05 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:44 +0800
Subject: [PATCH 01/13] imx8m: Imply DM_THERMAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-1-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV4PR04MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: 271103cd-eb36-40ff-116d-08deb8c60a68
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: OQTbcag/UQqW+dUE/sKV9MgmAzdaH7eEeq6CgphXu3oA2Ed2n/QZkGBdHRS2zwQYOV6h4m/L+kDGwc3nDdZc9NzCVkTDUKZ7uls9uMvBojQAguukUIxi+YE+8kWX5PG+h8e6T8ZWhCuNkrOsCn1HHbK35AwGB6oogmYj1AMQF01UdLSEl49gQZ60Kf7Avaxrdyvb7AzGOJ2uEm+cLXRY3TI69rjuv03G+sq2/l5aJ3L4xy9bY5laoQtO83Ekj/HWa+PRBhgyQIgb36a+i0lY21QCXVlT14/ot71/kQpbxUzBv7trTu/uEHtccfjl/7+dBOQCsWfctOE/N0Bt/oEDr2DtcaiTs3c/4nR17kpZYnjtiMA+OBS6OETBuXvDjvJukPlONPZEhKsTOWiPw5LL4RTxD2z/8evkU0THq15QyLA7WsEkeZWO17Yu8ABu4a6ZcP4LP475cASvmMtx2nnxpY60pqhwQFzX/WVWZKBU6FX8IZpmgtXjtK0p+NvOqYAKcS0KXMD8bixvkm8DPL50rYE8A8BqnvHWJqIl6FQZOmm/H2rY2p0WYNLTDHcBrIEP5a8EKzp3t17E+3JHs7cu+I2UiuavJZlsObIug5eD2wziYyDVMKn60UYNZV53gqdZGjGRPQZMF2Jx+PBAv2tLN5fjRBA0kKhycTo9e1GXTLcwVtFm1eJXAbfTB+80issLaPkdfHTy5O4Zmj5ktfu56tRZaWFcn1N5NOhlI7637ovJVEHFrxc/JX/BUC4fQIJl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJoMXBNRnA1WDhHTmJXVUwyUFFLSldmRjdCdkJ5eXNRNVQ2emlqZHdWcUov?=
 =?utf-8?B?cVd3K2ZIb0dzNHJvYnZWZDdIYU05Sy9EblMyakRONnNqTG5NdURlanREYk1M?=
 =?utf-8?B?Q3pXVGZWUXJWYkdQWGtiWXFtT2FlSERRY3FJalpvKzI0R2l1Y1pkMHcyOFlN?=
 =?utf-8?B?WDNXY3NKMWpJUDRuOGI1WExGd0JHa3BodG5IUWIvVzRpQS96VzJCcHptVGZC?=
 =?utf-8?B?bTJuM1hTeWJGWlp5QnpjWGJsMU5pMGRsVE5wNGRCWS91d2Vhdkg5bTkyZzNw?=
 =?utf-8?B?bjhYRFRETCtwTEtSK2wyVlhLZDJzbmhFTzZOYjR6M0tsMnpBenhZdVBUWm43?=
 =?utf-8?B?azQ0eGFEenVxVTNnY2dQUXcwbFRqdFF4cXNrYVpVRnlUVTBKNXd1a3dBL01n?=
 =?utf-8?B?TklZYURwbEhBRmVuYnZEZkZPNHBDLzJxWjFHL1JFeURxZWJvbzUvYXh3UFB6?=
 =?utf-8?B?Z0NsWU4yYnd5bTcvd01zWlF5VUpoMGNQdnR3aERra2xMSnRCVFB4RkdzVnJm?=
 =?utf-8?B?RGRBN1FHZ0VSTWR6c0pUVmdCamRoSytXOWxjejVFdkkzNXFRa1VnRVhKb2tv?=
 =?utf-8?B?YVRoMk5kUG1YTVNYb1pvd1RDZ0lFL0wyemNaekVoeTlNWXV4UUxiNkxiWXlE?=
 =?utf-8?B?bnd2UHNMLysxM3MyZlpNc1BUQU1vOFd4KzFhV1gySlJJZ0c3M0wyMHFuRU4z?=
 =?utf-8?B?TC9iaHhwSTNNckdRdFl4L3MvSGFIangrUGV0b0g3UjUwKzlNWW0wRVNrQklS?=
 =?utf-8?B?RjRLNnRyRitEV0czZjNHTTFXTy9zeHpxZHJ4WVMwZHp4RVdFL1F1cDBzSmhB?=
 =?utf-8?B?WEJyaWRDaVZaL1hMbGxhRzYxdFo5clE3Y2F2dUpmc3ZRZjMrRFF0cmx3b0di?=
 =?utf-8?B?NjJ6ZVNCbEVOdGU5Mjlzb2NpZmcxU0YyYmJleVlhNkFML3EwN2psWGY5QmE0?=
 =?utf-8?B?elFsLy81bG5rSHRFdkNtdHF0cTBtQU9xRjNTekpJbmZTRnhLalFpVDJMaDZv?=
 =?utf-8?B?STVzNUpRTFVKZnJsWXR1NmhzSzJrNHJpbmVuWU1NUTdWUm0vZURqV1hTcEdC?=
 =?utf-8?B?N3p1UnpmYzNUb0ZKUHJRV1RIS3pTNk9tdkNPa1VhL1FhMFFDN2FyT1lXMHIr?=
 =?utf-8?B?dGFFWDBVQVQvYlEybnlsSnN6SCtFZjBnOTQ2Y3Fuc3ZCYS9pdXc3TWM4MmVs?=
 =?utf-8?B?WTUzdlN4K3FFMjRyWnZQbTgzNUJBQWQ5ZzZNVVJReHEyNXhmVjdXelBVS21s?=
 =?utf-8?B?ZnQvUC8wdUh3WkZkN1k0VlUxNzhDM04zVGtON2o3NlNkbFMvSWVlOXNuZm8y?=
 =?utf-8?B?bFFEUEZPRmNyeVNZdnRBQ2VPNUNnVUpvK0p2ZTVPdmVUUllSWm56TDllMW4v?=
 =?utf-8?B?L2NCWndBd3ZOZmNJUmRCaEFkRk5vR3Yyc3NxcGNzb2pEZStobnRPMUY0OWpi?=
 =?utf-8?B?enR1NmZVN1hGS1RXWnpZb1cvb0FrWGt0RDRsZ2xuRENqVS9GVkNjNEI2d28x?=
 =?utf-8?B?U2JzRG1YaFpKbUhoMEE0eTVOK0lES3JyY3BSV3JkbXg4OVFXUzhSQlNXQ0x3?=
 =?utf-8?B?NnlQQVlVdFZqQktXUXczc05XZFdTbElUT2JlcERMTVM1bzF3VitlYy9ickxH?=
 =?utf-8?B?cE5ORmZYRy9Mcm83ZjB1Z0ZKejlXYXhkSG5rOU9jdDVjbzBFWGFjMEdzd1dG?=
 =?utf-8?B?MXl4RzJVaENIVTQ4akpVSVo5aTRhRnRaSW5oTHgwU0sxSnYzanpxb2lWRVBo?=
 =?utf-8?B?YzlPdzJKRncrNERVOFJkSEpENWFwNk5nUGd6cjBNUHI5VWFsL3Q1dC9GeFlY?=
 =?utf-8?B?Y1UwZVl2cXJIK0ZQY3JsZ0pnKzdidGluN200SmZWdG9lS1J2M2hNOFgzNFBr?=
 =?utf-8?B?U0hnRVlDM2NRdTUxME5LQ2ZtbFBTcEUrVFJaTmdkRWZaeEJVWVdNcCtZOWJZ?=
 =?utf-8?B?a0lKODgyVm1XbXRjVDA4c2xtQk9ScXhOQjQ4dmUyZVo5bGtuRXljVHdFQ1Fp?=
 =?utf-8?B?RW9UOHg0b0VLTzZpNUpHK2poOU5FTzZYK2UzV0UzUER2SlFIWE5aRi9tZldm?=
 =?utf-8?B?UkVEVTFtS0tSaWFRZW94dVc0MU5DM2JoQVdlM1llZzN2bW4xKythNWJrbzVF?=
 =?utf-8?B?eWFYRE9YcDREQkJ1bWtCQ3piM2dTQjFGRzlRNHRtZGRTb1pySTA4WTFidWdS?=
 =?utf-8?B?a1JEaXo0T1REZEw1Y1ZiWlBwQnV2bTJLSVFjekdPWDVpaFU0dDU0emZTTVBs?=
 =?utf-8?B?TmZ4RkdOelp3eHZvUzhkMWhVeWY2eDJ4ME9uVDFKZjZ1VVRQL1QxMTZUL0hF?=
 =?utf-8?B?bEo3Vzh0UkRZWTIrdEpBN0YyalFubTdYaWNQbDJnbU1DZG1ManMxdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271103cd-eb36-40ff-116d-08deb8c60a68
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:05.2774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uU2pNsHnc4Z3BjQFalNM6YFTK/sf4pxgURDEJUyTJ0DRltDcvIt16LfiX121P4Sn5f+gbBkKAu9IN/fRGgTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11976
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

CONFIG_IMX_TMU depends on CONFIG_DM_THERMAL, so when selecting IMX_TMU,
DM_THERMAL should also be selected.

Update i.MX8M based defconfigs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig               | 1 +
 configs/imx8mm-cl-iot-gate-optee_defconfig    | 1 -
 configs/imx8mm-cl-iot-gate_defconfig          | 1 -
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  | 1 -
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig | 1 -
 configs/imx8mm-mx8menlo_defconfig             | 1 -
 configs/imx8mm-phygate-tauri-l_defconfig      | 1 -
 configs/imx8mm_beacon_defconfig               | 1 -
 configs/imx8mm_beacon_fspi_defconfig          | 1 -
 configs/imx8mm_evk_defconfig                  | 1 -
 configs/imx8mm_evk_fspi_defconfig             | 1 -
 configs/imx8mm_phg_defconfig                  | 1 -
 configs/imx8mm_venice_defconfig               | 1 -
 configs/imx8mn_beacon_2g_defconfig            | 1 -
 configs/imx8mn_beacon_defconfig               | 1 -
 configs/imx8mn_beacon_fspi_defconfig          | 1 -
 configs/imx8mn_ddr4_evk_defconfig             | 1 -
 configs/imx8mn_evk_defconfig                  | 1 -
 configs/imx8mn_venice_defconfig               | 1 -
 configs/imx8mp-libra-fpsc_defconfig           | 1 -
 configs/imx8mp_beacon_defconfig               | 1 -
 configs/imx8mp_rsb3720a1_4G_defconfig         | 1 -
 configs/imx8mp_rsb3720a1_6G_defconfig         | 1 -
 configs/imx8mp_venice_defconfig               | 1 -
 configs/imx8mq_cm_defconfig                   | 1 -
 configs/imx8mq_evk_defconfig                  | 1 -
 configs/imx8mq_phanbell_defconfig             | 1 -
 configs/imx8mq_reform2_defconfig              | 1 -
 configs/kontron-sl-mx8mm_defconfig            | 1 -
 configs/kontron_pitx_imx8m_defconfig          | 1 -
 configs/librem5_defconfig                     | 1 -
 configs/phycore-imx8mm_defconfig              | 1 -
 configs/phycore-imx8mp_defconfig              | 1 -
 configs/pico-imx8mq_defconfig                 | 1 -
 configs/toradex-smarc-imx8mp_defconfig        | 1 -
 configs/verdin-imx8mm_defconfig               | 1 -
 configs/verdin-imx8mp_defconfig               | 1 -
 37 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 0e885f97e63..942198888c0 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -10,6 +10,7 @@ config IMX8M
 	select ARMV8_CRYPTO
 	imply CPU
 	imply CPU_IMX
+	imply DM_THERMAL
 	imply IMX_TMU
 
 config IMX8MQ
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index 4039ef298d3..20294756d90 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -136,7 +136,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_TPM2_FTPM_TEE=y
 CONFIG_USB=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index 489d1ff2d32..ccd7bf6ed8e 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -139,7 +139,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_TPM2_FTPM_TEE=y
 CONFIG_USB=y
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index eca9bf63376..85f8908e68f 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -88,4 +88,3 @@ CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
-CONFIG_DM_THERMAL=y
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index 29114486cba..7e7009299b6 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -88,4 +88,3 @@ CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
-CONFIG_DM_THERMAL=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index f8a7d6060ee..3f954976c0a 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -149,7 +149,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index e34f12cabf3..9dc7fe21820 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -105,5 +105,4 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 04daa0040c1..32339e7f6e2 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -135,7 +135,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index 6017f50e51e..8c66fad7390 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -133,7 +133,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 7521df31f2f..953968c9092 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -120,7 +120,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 8ab6ee24b23..79abe3bfeeb 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -107,7 +107,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_FSPI_CONF_HEADER=y
 CONFIG_FSPI_CONF_FILE="fspi_header.bin"
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index 8fbe0e049e6..e647e929054 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -100,7 +100,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 0cde12d9d78..d9d1b7c6e71 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -157,7 +157,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 # CONFIG_TPM_V1 is not set
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index fd80c3065ed..83db14dc5bc 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -131,7 +131,6 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index bc2d6014b21..6a1be97318a 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -138,7 +138,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index 800f851edbc..662f8f902d0 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -137,7 +137,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 18c44e801f4..63e75aaf7a6 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -97,7 +97,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 3233686034b..152f04953f8 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -126,6 +126,5 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_SHA384=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 54dce09bc9f..c5685c84d2a 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -152,7 +152,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 # CONFIG_TPM_V1 is not set
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
diff --git a/configs/imx8mp-libra-fpsc_defconfig b/configs/imx8mp-libra-fpsc_defconfig
index 44f3c9fd796..142cbcf9888 100644
--- a/configs/imx8mp-libra-fpsc_defconfig
+++ b/configs/imx8mp-libra-fpsc_defconfig
@@ -156,7 +156,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 1693264c9d6..8359f748244 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -152,7 +152,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index 401ad666011..eafaf4140be 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -159,7 +159,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index fdfd72fcd7b..6e8bb06d019 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -160,7 +160,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 49f0e0e829f..990d100f253 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -157,7 +157,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 # CONFIG_TPM_V1 is not set
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
diff --git a/configs/imx8mq_cm_defconfig b/configs/imx8mq_cm_defconfig
index 79c51191be0..9a8c16ccb19 100644
--- a/configs/imx8mq_cm_defconfig
+++ b/configs/imx8mq_cm_defconfig
@@ -94,6 +94,5 @@ CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_WDT=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 67a7f339816..dd0c615032a 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -107,7 +107,6 @@ CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 64e3ee04293..9138bca067d 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -93,4 +93,3 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
-CONFIG_DM_THERMAL=y
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index 23ee6278503..a63a01ba8d9 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -93,7 +93,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index f999ed073e8..c3a954dffd9 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -192,7 +192,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index b216a0bb270..1b175670ffd 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -106,7 +106,6 @@ CONFIG_DM_RTC=y
 CONFIG_RTC_RV8803=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index 7e450e2d356..72ffb72a137 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -130,7 +130,6 @@ CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MXC_SPI=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 3767fdfb23b..10061a1ba4c 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -131,5 +131,4 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 2b2aa899632..a116c65a99e 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -162,7 +162,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index 2d5bfffa093..dc2263368ab 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -91,4 +91,3 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
-CONFIG_DM_THERMAL=y
diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index c0185ed9ca5..7301d7a4ace 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -160,7 +160,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_DM_USB_GADGET=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index c8a2a057135..16e5ce7f406 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -145,7 +145,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 3c9dab36d90..778d56ad55d 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -162,7 +162,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_DM_USB_GADGET=y

-- 
2.51.0

