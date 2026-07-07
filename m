Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDD2C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 03:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3647C849F3;
	Tue,  7 Jul 2026 05:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bk3KOfFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA728496E; Tue,  7 Jul 2026 05:57:24 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A6B801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 05:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUrOLqFnRsaSEp3FS13Oy+Aayq35FSlwcgbGS5bOgYRqRq54tAU/lNflvBXKKb+fUIldazPoxGqZSb7ehYl2/2pdvwvNTWX/4ds5rvqLPqwSl4UinoL0IBPQVsIfrn0QzazO8hX4bdw7pRj1LNPpsUTtbyserwxTxu9dwNaHnxPamr816gr/88sDLlWc5d1EUp2SRs1RUQh7ttDaKjp49b1nBTTifT5gjvXeFaE2mQzz6FI0aVKirKzJdvVvh4jvVWYBZlBx8UslzC9jGLrAVVhXcJMIMMLbkV4rqrxfe2ZWscb4Jz45PoVAGxDVVATBxaxdurwMRh/xqjIw53fDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUhsgaLF7gAV6aRkf1mM49abABs31VJKOGtkDmPzXAY=;
 b=o7OjsoPDrzlxHuETmWbpLld/wjNx12xj9nc47lQz65G3MTupHkyRIvDsX+Bto1ujANn9ESbKy1hp82nn8EvPFIfQcOPeyXZALmV/nUl4680ayxe8Q3RC5A1DhoeQk+fLvcPonMmcKWunYezwpHP127OBj8F57VyEZX9wvtCp55fKJmgvTZA5JcGksP6jQ/rA8vc1a1LRq7vy7x0orvSzNWABMobOJXBGnWE2i+IqoRzwVNDVGtu6kqxaPWDk0CWY8A8LEzUUacqdf/nbH7xR62pRD5C/FegLXSMtWyyNrCgrb+uYondTXm+/FRvqv/sx6TNZYB1A8dWGEoO1ZOK0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUhsgaLF7gAV6aRkf1mM49abABs31VJKOGtkDmPzXAY=;
 b=bk3KOfFQvC0hxEUowCNETbHoxMzj7v07z+nEfZC0LOPcqQFVGzDwFX9cqFTMotuW2efAcifJEPETjjouOPpJdZu6SDZryMPWKLjwoLWS9df5SH+J8yoIziWqPw0LMkW72FNenbSxy/HUF8KHUFKb1gFWrrv4X/dpcSadZz0+tA1z3DsTMqKI+a2nSJGXWLL0Dc1OxJEpCX6fDPNRnGVeaNTM6lPmYxXQwdCNLuFcSjsziFtG/7jAye+uqmmcQXFvvb/zr3UMSvXDSt1KijJrnq25HQERaMTXaRW3picVnLgjRyxOflMXdpHnb8ugAQ9ME+uEDgs4Ha3MNxBeCqn/Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by DU7PR04MB11235.eurprd04.prod.outlook.com (2603:10a6:10:5b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 03:57:21 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:57:20 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 07 Jul 2026 12:00:27 +0800
Subject: [PATCH v1 3/3] net: fsl_enetc: Add SGMII mode support for i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-imx952-v1-3-1262c7c6f7e9@nxp.com>
References: <20260707-imx952-v1-0-1262c7c6f7e9@nxp.com>
In-Reply-To: <20260707-imx952-v1-0-1262c7c6f7e9@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|DU7PR04MB11235:EE_
X-MS-Office365-Filtering-Correlation-Id: c5daff0f-b1d1-4b2e-79ed-08dedbdbd7cf
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|23010399003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YtStuI4HWvv5BlbibzKas3vjAJNXTWYrwrOz1yyuLqwA4HWNUz2A4IKNL7PXhLVJgbHaASnlXNuyckiufDcDYy2EdOt8VLgMPIETMMaIFgTArCg1Jug3x6xSxn3A5V+U8PqqGfqBX2Pcvx9LvAWBN9R158b7xBGN8V/E6xaX3h02LNzmhqvpk1cG4lD8jWdWMl6YequtDPCgeKBiIzGINvHXQb8K6fMXQ9bI9wKnJQwGYBSZFeMGaiNAluMMAdkO2TCyFswkQ+zqR3UbSyTDeNFQzaUo7lldKBYXtQRZTtetmy5z27rXLZkG4u9I37Wsysu6ye319ibAYLG8Ljd7m8wbrrPUWcCHi9IiOCgPJF+h9Qc1IbGcxZlCQxXNZnrMOTmk7Vg2xjClAwEJKUVEawMWpeOwRddzzjvGxmb2H7M9POqhjkfHzDSxTtDI2bAJWUUapZBRJyUZFECgbPdn6l1gleZLLZ6tBgKR1NPqILs364+uNyxyzS01RuGMN0hXYiQFa//kebZqFppGz5Cov6vZFEGMhLIrLIMpkVxQ1PucmOZx0fLywUaK6h8SxNBLzu8sLeact50vIpBCVGPZpiTOH1yRAPwHwCM7YPafYh/6l3XgMAzUi3XREFdPPeyyB7tUDMjKrsq18fysqFpKXnBBM/X7BXOVAiQUDYxp6Ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTk4UkxZckUycmFHOHpYTmhXMTMvT0FyMFZ1Nkt2RndBcFRlcThPWnExa3hx?=
 =?utf-8?B?N25ZSS9QaHB2eGxmZ2VRYklSVUdWbUtiQU9KVDN5eGlSaTl0RlFjWVlVZXdI?=
 =?utf-8?B?NVJUV1VFcndhN0o3RzJ5amsvSDc1NGlqbS9YZytwcm5sL20xZ3lBaFhJTWZh?=
 =?utf-8?B?TU5TRm51MHRsVjg0OHI5Q3lXYzJPTkZJRWVWNFRoTzZkY3dGWkZIcktXb2c5?=
 =?utf-8?B?bjhJWXhCL0FhNVI4Tk5jTWI1dHgyQ0szTyt3bGFzNjlwN09OaGo5Um43aDEv?=
 =?utf-8?B?d0oySDJQN0RHQllMT1phTHZGeFNGSG03RjQzRTg1emZTOG9URkNXU2ljRWUr?=
 =?utf-8?B?Nlo5OEs3eG5tSTYyMUlYcENpa1lQWit2U1JTNXA3L2RGQ3Y4TE5CdDJFQ3dX?=
 =?utf-8?B?eHVRTWFXYWZZL2tzK0VsODFiVmJ3anVwSkt2cXpvcWZIdERiNFFPVU84OEVC?=
 =?utf-8?B?MWs0ZnJqTkhGdXlPZFlCYjQ2QmUwKzNYQjI3eFJBWG9aODJ5bzFMN2thNDB6?=
 =?utf-8?B?WElGSnc4a2xmblFGNUY0NUFXdVMvZHRIT3MzUGxTVVJrQUR6d01XMCswazl0?=
 =?utf-8?B?MmFoaTVqUzd1Y0ZrN2MxSGdaTjgzTUdQdjZRcW4xMjZZd0U4bm9qSmltMzRK?=
 =?utf-8?B?Z1hDajFBanZNRjV2MmZMbG1ZdWx3aEZrL2EyQXRRbzVsY1orY2FKRENsenFz?=
 =?utf-8?B?Q29HbUowVlY2NmdnbXE0ZG9pK1ROM1IvcCsxdWdCY0wvYVk1RU8zZDZkRmYx?=
 =?utf-8?B?d1dnUWlqektVeWZZcUJJb1MzNXZIb1hSYmpSRFpaZ3Z1OENmVzBNTUU4azJm?=
 =?utf-8?B?Y0pxVVl0akJjUGFxVHBMaVdaLzdKamEyTnpDcmJJV0k1ZmVWd2xDM09LQ3Zw?=
 =?utf-8?B?Y013K1BTVmJwMWZVZ3JHYzkvZktiVkR0UCtnUmxPdG9uRm43VlVHWU12TTV3?=
 =?utf-8?B?dGdtVU9pVjRuKy9pNUZjakl4OTlSN00yRVBmbHRFUHJTMDlRRGdxOFYwWG5M?=
 =?utf-8?B?Z2FtbDhzWGkraTl2STRVRGxmUGxiWWkzVUtJNlE3YXN1YWdrQlZwS1BHQTVE?=
 =?utf-8?B?Z1dHdm9RRUFXcHk2eXhBUWdMdE9iclpmUkpqNWZIUE9YODlRR1NjWlgvdVBP?=
 =?utf-8?B?SEFHdU1sdmVsOXVrQjlVYWlVTEIzQlJoRlZTZE1YczRvUkYrK01xL1o4UWFX?=
 =?utf-8?B?elluOFZQM3V5em43NTVkZGEySlEwOTVjKzg1aFVpNWsxUVlQOW1rSzNhY3Qx?=
 =?utf-8?B?b20rYWF6WFdKN1draEh6aG1sMkZhczZPMnVxemVPcnAvbXdGNWg3c2JidkRC?=
 =?utf-8?B?WGJXdkhnRTRVOTJNNVRCeGV2UzdaZk0rMmEvZ2pCVEVVMllTaU1ETXl0dGw2?=
 =?utf-8?B?ekJmQ3VMcDI4bHdHQ1VuYVZqWkRscHVQdWxPM1BtRHNkN3RWVDVsMExMRUdB?=
 =?utf-8?B?Zkx2MzZ4YlVFYjMyUTltWDN0SUVMbDZCMktOYWhTNm1PRkE1eU5jN3pQbHRq?=
 =?utf-8?B?Zy9ZV0RCWWVUT05QRUdTemhXaE9waGltVFlITjZkOEpSUE9Vd0hkQ2E0RWFM?=
 =?utf-8?B?WHFvTkR2U3d6MER2amJLVjhaT00xUFNRL3UvOGlYckdieThTQW55NHBYSzZ2?=
 =?utf-8?B?TkRobnlma1k3VlcrSVRyeXFYY0xSQ1VXUGVkNERCWDhqSG4xUksxYnR4T3NE?=
 =?utf-8?B?SWRzcFZrdjZ2T05INzNqYTdCYytNeS9CTGF2djA3M2wxZm9SRk1DZEplUEtU?=
 =?utf-8?B?YkNJbGRXTmJtZkl0OGk2RjAyWVorZEFuekZJWXBpdWlZdnk3ZnJLblNMSkM0?=
 =?utf-8?B?MXhBYmt3bCtobEpoL3VSdlNMNkNiSksrZnlvcWxZTDVQeDJHM0ZNY2gzNHlz?=
 =?utf-8?B?UDlzNENpK3VzenBqMjgyQWRtNk9JK1pMcEhnaCs1Nml6Nmt4Ny92dGcxaGFR?=
 =?utf-8?B?ZlNRcFpBbEo5ZHFGM0lGMFdQUWlFS2xkaEpwa2EzTVRNSU1Yc2Q3Qm1pZUZC?=
 =?utf-8?B?OWhpbENPenhiYVY0OVZhR2s1UmR4ZDl2WnZ6NEJsR3JQR1hpUkNHSUpXcWdU?=
 =?utf-8?B?Vzd5N0pjV3pUMEpUS29wU1gvZTlSZFVrYzlZc3c4a1RLang0MTBIb0ZBUjhh?=
 =?utf-8?B?aTNYNi9MOCtnM010Q0Rab0RhY0dLb05CL0tYMHFGUnlSOGFjT3pCdE1NQTl2?=
 =?utf-8?B?dzRnaHA3VDg4TlNZcUEvUkMwcmJTeWlmRGpmZnlSenlBL1Q0NzYzVXVHTDFN?=
 =?utf-8?B?UHVmdVNLOHhCOXZjbkFaK0ZBZ2dTMGlucHFRWVZ4aDROQTA0U0wxcUg1NGNW?=
 =?utf-8?B?RHMzaE01U0pXTlE5elBIK3AxblF2dTJ1cXNvZTFxRnV1WThISkUvU29TREp4?=
 =?utf-8?Q?XVj+TEi2BHJrA5PyrEqzUUBnpYLSu1r8HSdvE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5daff0f-b1d1-4b2e-79ed-08dedbdbd7cf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:57:19.9610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YmkTkJMXq3PfYefZ2DH99HsqDhywIjbAWm368EFwUPNMjFeQQONlL+5I1YJPdRjILT48ELIrTcuzXavx590fiHHwloxG69qSN0NwREcsxBT+G1UBjQk+t0xrZgogaR4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11235
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

From: Alice Guo <alice.guo@nxp.com>

Add SGMII mode configuration for i.MX952 platform in ENETC driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index cce1c5ef2a7..98376bcd3cf 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -392,6 +392,10 @@ static int enetc_init_sgmii(struct udevice *dev)
 #if IS_ENABLED(CONFIG_ARCH_IMX9)
 	else if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && is_imx95())
 		return imx95_xpcs_phy_sgmii_1g_config(dev);
+	else if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && is_imx952()) {
+		priv->without_pcs_pma = true;
+		return imx952_xpcs_phy_sgmii_config(dev);
+	}
 #endif
 
 	/*

-- 
2.34.1

