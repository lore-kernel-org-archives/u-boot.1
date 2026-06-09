Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880DDCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCB98489E;
	Tue,  9 Jun 2026 09:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uoddUCPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 079E4848A2; Tue,  9 Jun 2026 09:19:33 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C788484C
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0xCBF/vCsz437G5B8aGlM2/ClNO8hk6nS+pOrAQLw/TcBFCvd8/4J5zYRpswX3I51kfwliwVfV6QIccsJrhTTyZ/6VdgMoEy825UrOysMgXIP08/3Z4jTs8MegBOiasUIf/K/QsFKhTfYGZih2ZP5gYuQ+dl7BAtijtfqbF5nOi/Z02Nfv5+RXZp2PK/OGT4//7tvDIcdnPrRx0+cUdVfYPszwtjFAgisB5KbjpmnRllJJBAb3ea60a3naMD980KuIeyReYIUfa1ggreKqxP43C0ueHy6H74VUuCE+3nc4AqjlORhd95fS4Er9TXpbzXJ2gleRyi/bPaxxV3XFRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGVlSv6QlyQkrdP4bFcTRama9WgjrhInOsBhZygcx5c=;
 b=boJmqa5a1Ghhog+EvpiTF6b0dxeHSwOjdTJgQ/cL2fYtwXqHshtB5mgSJ1xsXYb7jU1WTo3ssJDixjFFM7YzsxuKSv8uC1c/xC/q5mULDwlATpS7dnZ5+I0+2ayuNw0SG6XeZOg6ouNsvKPkx1g/eAccHS6FFZLrRoQCLkNGNE/Jdq1lTnNXs1hMM+nIkZ5pyT3gsCdC9Cacwm+tVsZQ+ji8t6oQ+pzlggGPfi4qyP+RLWbExiW/TnNo3PEiybmQtSKreEz/wTe4eJ4KyMQurBJ0Ipq213wNm2bOS16CojDKFvNh71J9ucjvAE8vd280KKGNlyroVg28bsq+6NNFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGVlSv6QlyQkrdP4bFcTRama9WgjrhInOsBhZygcx5c=;
 b=uoddUCPRNnQKyuQ9DNK6KjdytyoyHY1l3u7AB0m31XcZ9TDvdZFMc4SkNnHdj4r9H4p48DMKUUronknsuaIaLEP2D3dL332Rji+QGO6Pri0TAgFrOSZfCg8aYacgQc+TzLyoMB6NkBmJVeqbMjpIp3AyUDxva14S5f81tmHbZgVJ9JTBqmQjJB5aw9QVawM2qxjrLV7SKAzRzDruVNPKI3QWowVXtqtSEJViQSwtww3jijhQSqyyEjzAQ7qEf1gt7v182PXMvF3af6cgG1FXbdj1HY9UONAnwVqoupJTDs33Ethhztfuy0kj/GLDz9eZ+4odN3DlJdGyOsUH2DBHNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB11546.eurprd04.prod.outlook.com (2603:10a6:800:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:29 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:25 +0800
Subject: [PATCH v2 08/13] serial: lpuart: Use livetree API for fdt access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-8-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB11546:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b5d5b3-539f-477a-eb02-08dec5f7720b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sWnhCHN6h4ng73Qh9RINxkPBJLzjelqb6dcxbBsGL9+Qp/6pTK/gcW3ggxT5BU8MzjAiV2BKsm2seQExdLiwrIEO1IQIqjGzk1V2Bx/Hadfenp2Gx3CZ4jC0Ot84nkM8J29RoCcxu2NPYFKMh7N8nN1+e1q+VThfs8dvT8zBNSfRe0gIzepiitZYorCg6BIMpakK6xQyrNugIpp+FtWJiprdi8qV8uC/UyfMGlmOYFJ+9/i67bjMiyRL2xk3+/riaMr+UvL7E3b6Otz47lp2Ju6RHhcEmSZz1siO7IViml6TMchmerXhY4lVwQDgrD0hlcvm8Uhfvx4QlQeqw0LvZupzYE54tnmrM0EUQ+0DFdS+S+F3RnUmnleLqm4d+K0xexUGrWqJfQym7WCavN+G4vhjAtfXXsA4sO8k0NW0Wcrbt4yl1IzMsxEuNW98swBCPVOC1swqEJRVzM28o80azClDsvtwDuEhjKp3dFuY2j2nISCwSzedTrulYfSJu0DCfM89V6xEAQQ5XRshJXlrCn55dfOo4PIOHSIh8hrItNmjMHBfr7Tc1JLP7UE4P8yRLuirjkZ6GQHQhNBfRMgrg5Wf1ovdSTcUAu9s0ZaACeGdlQEs06LdDvVnt3qn33/6uXUCJ8R9ARn1kSp+8UZixw1fIweeKe1cMyHN8e2hQDDHGRiZzK8kToGT3rZ3TXx+M/n+xxlY1Wgd2uul47E2SgPoP2qMFr1zqdijppO3ZIB7R+k5DLNHkbtpeTL+kKyb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdzS2ljYXNHY1JoaDBhaHJMQXVwNmxJUkgwSHdBc3pvY05RZ254YldtSjRi?=
 =?utf-8?B?VkY3UUtVTEVza3lyb1IwNnJ1YXY4aVdWVFJIaURWUE4ydUJwa3kwcG5xVE5X?=
 =?utf-8?B?b2V5Wk5DRlpFdnM0Ry9kRmZhUnpQVlRzZjdFUkI2U0hMNEVtak5iSDZ4bThk?=
 =?utf-8?B?aEJ1aitmZEI3blNqR2dUT29zcVJkWkRUV25McmM3M1F6MTUyWU9zTnFEMmVN?=
 =?utf-8?B?UjRNZlkzbElyUElFYk01dTFCSWxyYWhzUTZUbVhhZ3F1N25QMnFQWFIrZ3F5?=
 =?utf-8?B?MXlNdzRlL0FWenUrQkdMa2dXWjE5Wlg0dk9Pcm8wVGRwM1c0RkdvREpmeUEw?=
 =?utf-8?B?MytyK2o5a09VcjJqWVd2SG0zaVdKdWZ6aUJmMHZCZ09keEtSWFZvTWNqQjFD?=
 =?utf-8?B?V25LUSs0UnBQWjEzL3NreUFJWjNQMUtQdWR2TlhrR0NJWDdNYnI5eVZ3U1pY?=
 =?utf-8?B?YmdRSlAvNC9qNEg0aWttVmY4VitaWVNKMTREZVJPd0RCN2w4VHllREw1QUN0?=
 =?utf-8?B?TVNPRGY5ZTZsdVZMTWRhUE1WTmg2L2JnNmwwN2E2Tko1Z2xQWVFlc2ZjUVZI?=
 =?utf-8?B?ck1OTmtCeDlSM0IrWG5QSVd0NU9MUlFXZ2pBci8vd05hWFFrWDNNbjkwWDRS?=
 =?utf-8?B?QTI5eXEwUmEvOTJFNVp1YU5EV2dKNnJibEloRnZVYytXdmpYOHk5dnZWRUhJ?=
 =?utf-8?B?MExsR2h5NXR0V3FrQVEyUElIalgrai9PVnNTQlM3a2pmSHE5cGJLRnIxYW9T?=
 =?utf-8?B?dzFaNS9lVUdoVWVQQVFTaXU0ZkxVaHkwb1pXNjhxZlVmSkhaaWJDbGZEOXRR?=
 =?utf-8?B?bkMrbWZxaDVIdTZkRU5PYmZ1MWFPMUc5QkNXanNuZ3hmR0wyTTVocjQ2ajdW?=
 =?utf-8?B?cVd1b2Vab1dBL2EvQnVhUEdqMkpWaW9GeWNPdzB4dk9LNUQ2SmQ4S1VZRzhJ?=
 =?utf-8?B?czVtY0JYdzhscHp4K1hCK3J1b1RZMTdZdUFFdHJQVFpWSFBrMDdTVW1rZjNn?=
 =?utf-8?B?dkVzeFgvem5mV3pMc0tvcUVUSHhwakVlWWtsODdnamVCb1Vacm9aNTlPcE95?=
 =?utf-8?B?T0NlNWNzTkpRdWlyRGFmSnRGdUxyamFoQnViamhEUUh6SkdLRkdiaUR1MStE?=
 =?utf-8?B?Wk1WcnRhYzA3bXBuRXk1YWFKNlVsQTNOSlFnNDQzVStISXhoWXFuSnRuWEpT?=
 =?utf-8?B?N25lUmlJMDhCVldHRU1oSlozMkMwaG13cyticFhZL21nMFlZMStwd1MrUGd3?=
 =?utf-8?B?VmpQTGxOSmtnNGZmdE9mNEMrSFhqVG9VMHVmakloT3pkaTkzUDk5clBBN1J3?=
 =?utf-8?B?eFRGQW10RWIvcU9yVmErZlF5V3lmVlRkLzVhcDAxWUZWNTdjUzllWC9BZzFU?=
 =?utf-8?B?RzNCUlpUTEdMMnJycXVYdTF0TWw0S0RSMnp6US9xdTZOZW5sR3ZwUVJNanJh?=
 =?utf-8?B?Rm1KbWljRDRsVVFnVGhnaXo5bFlJY0ZTdis1SUtDTmh5OXNMWEJUN2N1L0NG?=
 =?utf-8?B?NUtPNWsvYU1Ca3lxR2EzYWNyQmFXcU9mNVRDZkpqcHlsaGIvMEtMUkk5YVB5?=
 =?utf-8?B?dVlhUVZsQTdDbnJwMGZMenViM3JNRlVqK09JenRrZGo5TmFmbUl2THNiSmk0?=
 =?utf-8?B?U2dJOHRiMzE0eFBkaGRrVHNkbVIzekhpODFyUXV4SFlnbEI4NDRtSGYwaU9y?=
 =?utf-8?B?MU1iQzQ5bXR2eWliU2FZNlZ6aXg5VUQzV3V3YWt4Z3JQNFJBbzlwa0lNMUlS?=
 =?utf-8?B?aHE3L1VTN3JndG1xUkRyNVJYZkVHQ0xxdU5DVmJzMUNKUGtTc2RORmd5bGhq?=
 =?utf-8?B?cnoxcEVZczNWanBxcFMzVk92dDBkSXdDWUdzdnJzRjZDQXdvcTRld2ZCRkNX?=
 =?utf-8?B?SU96cjlPdENkRnFRMVpZejl6TDhlcWhkekRDNzNwU1dFSjFlUFBENlNOUXVW?=
 =?utf-8?B?emk5ZGhqQ0tQN3ZBWDdwSDYyaWNRT3JmcDFoVnFHV0hnK0RNaExPakU4WDlE?=
 =?utf-8?B?MUtoaFNEVWtXSFdISXdHTDZ5UDlVOS9uaEw0dVk0ZjJtOHBKN0tMRFkyNWMz?=
 =?utf-8?B?VFVzdGY3aXNhWHdpbmowVEh4Wm9NTWYyRE9nVW9oL0FJUEtVc04zR0hHTG9W?=
 =?utf-8?B?dGs0Y0xselB6ekszeWRGRXpGdWxiY2VXMnEzKytWSG13WVAxWk9NUmtyZnVy?=
 =?utf-8?B?WXBGTXpGcU5Ubkh0bmdWQS85U1pUMFBDZFVhVFJVRmRTc0ZJakx1N2pBYnk1?=
 =?utf-8?B?UFE5WnN3Wk5zZ0N3OE53WHJQeHBDUEt5WWdtb2tCa0dKTWVPMDF1S0xWcE5J?=
 =?utf-8?B?ZE9RK01vWXdicWYzQWpwR1d6ZXFoQjJXSUwvODk4QkFBcFYwU2VMQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b5d5b3-539f-477a-eb02-08dec5f7720b
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:29.5091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJAdXpmuckrLxR+uOiSmGwkNm/Hktf1LgdGdzB8Tgfxqt8YMCNXM8CRDrS5FJtRqZVEhPnVhH7/FCNKHcQjepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11546
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

Use livetree API, otherwise driver will fail to read properties
from the device tree when OF_LIVE is enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/serial/serial_lpuart.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 9fdb6503085..e96e344fe12 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -523,8 +523,7 @@ static int lpuart_serial_probe(struct udevice *dev)
 static int lpuart_serial_of_to_plat(struct udevice *dev)
 {
 	struct lpuart_serial_plat *plat = dev_get_plat(dev);
-	const void *blob = gd->fdt_blob;
-	int node = dev_of_offset(dev);
+	ofnode node = dev_ofnode(dev);
 	fdt_addr_t addr;
 
 	addr = dev_read_addr(dev);
@@ -534,18 +533,18 @@ static int lpuart_serial_of_to_plat(struct udevice *dev)
 	plat->reg = (void *)addr;
 	plat->flags = dev_get_driver_data(dev);
 
-	if (fdtdec_get_bool(blob, node, "little-endian"))
+	if (ofnode_read_bool(node, "little-endian"))
 		plat->flags &= ~LPUART_FLAG_REGMAP_ENDIAN_BIG;
 
-	if (!fdt_node_check_compatible(blob, node, "fsl,ls1021a-lpuart"))
+	if (ofnode_device_is_compatible(node, "fsl,ls1021a-lpuart"))
 		plat->devtype = DEV_LS1021A;
-	else if (!fdt_node_check_compatible(blob, node, "fsl,imx7ulp-lpuart"))
+	else if (ofnode_device_is_compatible(node, "fsl,imx7ulp-lpuart"))
 		plat->devtype = DEV_MX7ULP;
-	else if (!fdt_node_check_compatible(blob, node, "fsl,vf610-lpuart"))
+	else if (ofnode_device_is_compatible(node, "fsl,vf610-lpuart"))
 		plat->devtype = DEV_VF610;
-	else if (!fdt_node_check_compatible(blob, node, "fsl,imx8qm-lpuart"))
+	else if (ofnode_device_is_compatible(node, "fsl,imx8qm-lpuart"))
 		plat->devtype = DEV_IMX8;
-	else if (!fdt_node_check_compatible(blob, node, "fsl,imxrt-lpuart"))
+	else if (ofnode_device_is_compatible(node, "fsl,imxrt-lpuart"))
 		plat->devtype = DEV_IMXRT;
 
 	return 0;

-- 
2.51.0

