Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CA1CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D51F848A9;
	Tue,  2 Jun 2026 12:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bpiik64q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7216A84932; Tue,  2 Jun 2026 12:05:16 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EE6848A9
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNoFJ+VsZSw0xG3SjcehuwY3qQeO7uBlejeK8Ne2PgJ/Yjv6h566nN4/shU5DAopcNWsYUxdAGyA3YJ24ILh+w2YmGOg/6cNa6BvX6vr+pdpDEbFv4K7iiRac2H+tzqpIRJeOQUcR37yqm0APr1RKAuMeCWQdBuw5zUEBZ4s9fO4nB4qpg+1ORLmpTVT3D6CkGft0fkzu364CYvx0c2cgpmJTUebmtsWnSiN9KxQR7QB/uZuCMHoCnpJJ+PI9ndmestH78WGDrdHHz4ea2WW72ArFlqLLbsAsvJSpz6ZHa8K8hZaZjCPZPU+E/zfa3sBKcvoWNkSfNoSR1esuQepBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEamUxJvSX80aF4Yt7D0FSI+VVk5yEMsmL3AN8GOb4k=;
 b=RtyRTGe81WMcTYdoYolicJ1Yg8sD1Dn11K4yNXcAydS4/SVsVI4qBsqgG6lqYN00SiftVr6fvw4EzvwUfwURjkLm0ZApNBZoBuaZmty+vQgdiMDGWFQMQLu10EjLDAd3LIFwOVvjXNERQoOccD/JPZpVqNK7g2Z+xMIbJv5bK4ISjDnlWjjBEAAVGDspiNG8MvXcRnJ8ByW4nSAwcJzssuPChbOT/FYQIJmV/3NTGARssVpki5CsPw9+PVczh80GonSOkJICwX0n43yEc04O0HmxUsCiZ9wtqBvLL5Xd8KVDBA3adSOHr99SEPZh3XsgaQq0tJ8Kvd+POA8DKYzQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEamUxJvSX80aF4Yt7D0FSI+VVk5yEMsmL3AN8GOb4k=;
 b=bpiik64qDA5fKyp/34aFTGYz7S9AgU56XY/QlKCPhc3QSCSEFbME3h3Zu4n5i9fQ0s1uOlRpodhtmuhSwkopS09UgaJ3NqIIP3v+ga7BpWDUFz3IrjdXZvr26UTeEUQrDH8JsTYF4OQq5cU6Lx8e1qjl1TzSGosLyw3FsX6FWpYZzf/lBI8EmOuvbga36jtHjzSm9qu60JxV6C+DOGyv8Z31RiVNl3C+xJBAe0iYk+MVTcbd22uUYVnZskwUJLprPygfcP9F46LnOodVR28jU/V9vmHsduQdFrbUZZlXknxvmVzL0WBfe0bkwqLB/rm4YEsiGAnalpTQtPlZWDgcWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7372.eurprd04.prod.outlook.com (2603:10a6:102:80::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Tue, 2 Jun 2026
 10:05:12 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:05:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:21:44 +0800
Subject: [PATCH v2 5/6] usb: mtu3: Use dev_remap_addr_name()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-usb-v2-5-a587ab36b906@nxp.com>
References: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
In-Reply-To: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PR3PR04MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 437913b1-e922-43aa-222d-08dec08e6f4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|52116014|376014|7416014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qA6/Enzn8gWn5i1sm20LawPbKycbgy5yMeeIqsB3URCZk5Vh76ustlFbs7YzbyscPzLlOfaZJPNhRU5HBQ8ehsDD03zMbpzb14Nhu0L8m49dh+qlsPSidD6TP4ve//40nsN6/1FVIMdk6e983bbezYntdADYz0trkrfWKpurhl2QgZqn0MoXdH3zmv7c9IhQdoWNwdmnxukkypTCV9vpcuiexw7GD49kkgQAJjnxbRrrjdSSA08X4RTl7AWlvcGQ31fchx3xlPfRw2qkz9ZV6LSnvPOBdZJZ2c6AiSZaOU0pcsjyf/7DCuBDpE3erzWnsh4Qu/LDM5IfJsk6mFr7pTr/zChXK80i0cqjeITjRKOPfeszyFuoP+euzzgtwuxGieWGi2B9ZDdigpTgE002c9+vOKLJKgTvJHjirheTedrcwg9rEOQo9lw8dhfmgl5hoOUnGBtpiZAQvFPE78bOa81NP8UFB3AYvxnxFCf7D7+GKO496/jSTg8PBDs0JKRweSPRe8xGfj4zlF8/kuofX3HaQz+gmX76uJBqpT1R8StvYhnbHg3E9TPDQLBg0RDE9yYaJClt5x5KpX82D7ofWHS+AqU8G4bV3MEb43ABbIjH9o7e2cYllarSkyUVZRtwToZaR4OnTbjuEPP3I4JscD53odt2a8c9xtp0fFkgxrzJmHtBVZOsI+c90N+GOourv+9Tajqnb7kS/hB0cNZCEKBhaZ0zDXioAahlBtaJZ+YcMcwmFB/yag2fInEJ2z2c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7416014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0ZaR1R5cWpWakJUSXlmcDZORk1XeHFuZjAzSmM2bkNzSTlXazZObTJCTDFo?=
 =?utf-8?B?VCtQRVZ4QlFEcmZTdFJXbllYY1ZHNUN4RFFvYSs4amhKNjZzNnh6YjdxekFX?=
 =?utf-8?B?QktaOEIvSEVVSG4waFdOK2Z6NVFMZjF6Q1NIYXhiVGJDVnNlNDEwMndGcjlF?=
 =?utf-8?B?bDhYbnhrRUR0WmxqdUtYWUVtTmNFa2F3bWI4cFUrTzJHc3R1ZmlES2JUKzJU?=
 =?utf-8?B?Mitjd1V1L1J2TW1YZWZtbVlrcEFwcjF3c3BWSlZTQjcvYWR3cG1ZZFE5L3RI?=
 =?utf-8?B?T3pYUk9oaXBqN2RTY1JHSktEYkFPZGdRQkF1UnhORVlxemUyaThjVDBtUnpu?=
 =?utf-8?B?ZVVOSWdqSlA3TVg4QXQ2MDRzMjFNUFNZSm9RdXo4d3NpT3FHVkl3RHNscXl2?=
 =?utf-8?B?UVFvdnRML1JMMHkwNXRpMDlTSlZzNkN6TEk5Y2V4ZVdrMkt1UUZJS1pucTRm?=
 =?utf-8?B?UHlVdnJ0a0pEUEdMZ1BIVGhwWGl3OHpBcS9NOHdPL3lRUVIxNUZZT0Z4MU1n?=
 =?utf-8?B?b3pTcERGRm52dDNBNGE2YnhXSkk5M09zL0JFZnVZYm5rcmtOL3lub3Yrdnpl?=
 =?utf-8?B?ejB6V01oMGVpTmVaK3p6MU1KdEJiWHU0NGM5ejhyWTNKalhoZlE2dzRhK0tz?=
 =?utf-8?B?c1VjQnRsTWt6N3g2NGllZC85VXRYbnZvVkF4TXkvZjZZeTVYNUlvMCtCUWNM?=
 =?utf-8?B?NnRGd29OZ3dOYVJ2d2luQmU1ZlFYSEdBUUJMeFU0WXBRWDFvbDZqUTc2eFpG?=
 =?utf-8?B?YTJqeXFRaXBpRVJ6M01Wb3pBc1NWcE5YRjB6ZnlESnNLdWFaR1lqenNFeDVp?=
 =?utf-8?B?Ync2ZFZmcEFoZGdmZ2thdW8wL3BmNmdxYVJCWnZSYmpFVHFDVnkwVFFlKzVF?=
 =?utf-8?B?SXFSR0dXR3p2eDNQc0lnOS9tcjZGY3U1Z1crMG80UlpOMFdaOExodE9lZFp6?=
 =?utf-8?B?ZExRaTlRbC92VU85R1VNT0pCNENSMGdJWnJDdkRpV3c1SGJCM3o4WExscGk4?=
 =?utf-8?B?RXpBUUtDeXBoWmt4U0pYK0NteFN0NCt5UW9RR1lOaEMzOVdxd3RkeVhCN05R?=
 =?utf-8?B?b3k3eVpRQ2RuQUZiaXk3eS9GR1VraXI0djNtV1VTdmhUQk4xM3NNK1h6SHM4?=
 =?utf-8?B?MlJLVnhER09MRTlobUIvTGZqSENHdlJHaTQ1TkNjVktqVE5xWHFieEtjN0x6?=
 =?utf-8?B?b0hZWHV1aU9pWjV5N0d5MVllSzZGbEp0dDVDTGJqT25XOGFFTEFtNDM2RWpv?=
 =?utf-8?B?Z1QyWjdmSmFxMjZmOVBnTDd4OFNRc1dOZjJkSHZCbUkreXJ0RTZTYm4xQ0FC?=
 =?utf-8?B?djlNVi82aDkvN1V5TVM2a2FiWWtHa29lMk9FU3lhZXNRMlJ4N1FPN3QzMEJM?=
 =?utf-8?B?SFM4SXpDaUlobzkrR0x5bWRwOXgxUGwxaXRiR01FY3dkamlUMGtybUZBeUor?=
 =?utf-8?B?RmJVN3N3Mkt0N2RtR3gxQzFrUVZtTDJtU01EK2thTzhIVTZzUHlXK0xmSlNn?=
 =?utf-8?B?QlZyblJ0VGw0NzlqRVRYNm42NXptVDZVSEVqem0zWDFwd2ZTY2ovV3I1dXhD?=
 =?utf-8?B?azNML1l3VFdxU2Z3NDNVbktmNUpiTXQ3S2x3Skk1WGV1YVBybjhtZXpQa1R4?=
 =?utf-8?B?SjhxWjd5YVpTOXE2VXNINjZTSUhhVTY5N1IxU0tYSERGWmNVbC9vSHlYa2tR?=
 =?utf-8?B?cEQzKzRCa0h6UXh2enUxc3RBZXhBdnVhVm0ycFhMNTRGRHRwVEFhUWl3eU12?=
 =?utf-8?B?K2M0dVloNTc2UHNpZFlBcFlLN3V4YUFiaHRBRmZTelRYVml6VGRCUlNpQkZW?=
 =?utf-8?B?WDM3a1p5QVRFRGhDQmJ5cE9wZ285clVGajRnanRrY3U4NlFhdFVrR3R1SzZq?=
 =?utf-8?B?SVhNZDRyTGpSNnVKM1BrUjJqWEt6bEtkQXU5SDdMRFNBVFZuS1ZKWjJVcnJ2?=
 =?utf-8?B?bGRma3p4ZktuVmcvcmVVTHAxV1U4SlFCS0JqckZ5SkFORUdZbUNRbzlodndV?=
 =?utf-8?B?c2poTkN6S2prN3o2ZmFtSk1JdTBKNTJybXZhQklqOTQ3YldlbXdIUEdRdHVt?=
 =?utf-8?B?RmtvNGxJYUFHNTNzWFJhamErb2E4TDRTOXhxNGJ0Njc4eHBDdStSRVF3VlNx?=
 =?utf-8?B?MmxNWlNLajlZVjBlTGNFa3dkc3lLdWE4eEI1YnR1SnNic0haMzNjd1dHZmdr?=
 =?utf-8?B?ZmdHRmRDNXh4TFpzUjgzYzdmVVNPeHZqeUZxMjJGNkxOQ21vdjhnU0l6am5V?=
 =?utf-8?B?RlVXZzBVQW5XYVJiNDRRS1RHNG1teW96ZitIVmIvN0c2Rm5JSWJDMGpFTkEr?=
 =?utf-8?B?QjB1YlhsMmFoS1RXb0EyakEwMWhMQ3F4N2dMTFY5eEFDVjZ0ZFdvdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437913b1-e922-43aa-222d-08dec08e6f4b
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:05:11.9888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DT12oCysDPjG4/3wk2d+tEaGpprcvFc48OIv8YcP/eTAc7gppcig+9XlKyU0EEG10SNF4SvPHooLAK9Kr08lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7372
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

Use dev_remap_addr_name() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 26fee141f6e..a35ec47f85f 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -154,7 +154,7 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return ret;
 	}
 
-	ssusb->ippc_base = devfdt_remap_addr_name(dev, "ippc");
+	ssusb->ippc_base = dev_remap_addr_name(dev, "ippc");
 	if (!ssusb->ippc_base) {
 		dev_err(dev, "error mapping memory for ippc\n");
 		return -ENODEV;
@@ -166,7 +166,7 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return ret;
 	}
 
-	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
+	ssusb->mac_base = dev_remap_addr_name(child, "mac");
 	if (!ssusb->mac_base) {
 		dev_err(dev, "error mapping memory for mac\n");
 		return -ENODEV;

-- 
2.51.0

