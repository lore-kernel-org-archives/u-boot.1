Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712C2CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 06:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B17D846F4;
	Thu, 28 May 2026 08:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xz72Med6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D19E0846D1; Thu, 28 May 2026 08:43:54 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2797846DE
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkYq6uC+YHLzRMnwW6ItJSjTRYozzW0NTVGFFx4bLZGghDKy9dH2yeawpAtLcBdL7VT/eKxlhy/hZ5cAatQ9f4GY3X7fAHSak5cT4Ffr5x7DfnYyhJfsYT70y51oKyGHmIrZihJBn/LpoARUM3P7MaCg9lTUtQI0OuXH72s86EQdHSZBG3suV9nAZRg9QKz/EcMo5W1SOSn74FYLnEWq3P69Q3JVEJ74QdWvKiqmn0Zmh6kTk9B/1YAN/orouiz2tlrDDGBJCid2NylbAkxo1fE+C4vR4zocLOWt6eH4uBf0HsO6tYyHMdy3sYYIy+EufpfbpEvxVNpupWkaGbBySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDIDB5mmbAy7/5lHv137yQkacX46M/wVQSG2JPUa26g=;
 b=tR6m472XD/1xNm3n4/Z1qmQ1dp24rcU3Csj1w5zD4Esed0zj5VL3apz3Fquj/+fKq6mOHT1OPre0JQtVrU5ZGs4a2hARpW6AHg3ZswqJq3xjWUcppb8FEv4FoQHow1+2X8y+D4jY2fmInMLIjZ6iPP/zDLaii+qGLNegvvJj9fxYu61oRIDGYjHUunb0gqhbmfpEf51GjFhrYorKc0Z43dp8CtYo/Ly8JtrQhqPt6Fgf8FHpaM4vN+cpn3TIN+Y7ewgfUQ83RK2yejKCPqI7FCX7oDcsYLLbsH059GuUJxWhRD+I+tRMIvHBtwSQg7sONvNEn7moK/AVjFtC7c5WnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDIDB5mmbAy7/5lHv137yQkacX46M/wVQSG2JPUa26g=;
 b=Xz72Med6OMiqprXr2SckkaqgDq2pULyCStZyNh6jObam8JY6V5PvR2zfq3oNnpb2GKSyzOyMr3znc4SLDAnCPTj7Kq3N/neR3TZfnRd3qDgKAsCDOQZyvt0HAt0DREgTO74x4GdHc/fI8e998PBnW101CSgUHYC5wHiaUcHUhSzxZKhqHTL05jr75VnPGTbLZGh/PlFdRGz16XirWZ+dqtNxj/fqWHovqSgHH3Rmkp8QEFtA1fMETMANOUbVZzPRRx09RnTYskbekDfbTA+xjGombYen4jhb8TS1xnoMkxxWMEKHADwAbGNN9GpNSS8tGm+CzzUzp3qts3y0PucYyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8516.eurprd04.prod.outlook.com (2603:10a6:20b:343::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:43:50 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 06:43:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 May 2026 16:00:23 +0800
Subject: [PATCH v2 5/6] net: mvpp2: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-devfdt-net-v2-5-dc6f20b82611@nxp.com>
References: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
In-Reply-To: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0a6b64-98dd-433e-f7a6-08debc8479df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FwK6gAUhX2B6LCrJXM3kkrTraLmyln0xxX9V4eLuwUTpLE9qv85zGQBZ2+MuNcZshwTvCIhe9/795O5hCSnmpwoC699/BCXIqXYBYCOrO54Cod9mc3DhhoHt9N+UgHxwOfzEBWRp/Pw9mXUeoRDFRUzUjsOnhq+6QhNlWrOYX7UlcnawMYA7YXQKcrxAbA4Dfc/p9JTy64V4WKnav38nAdmKzAP7DeXdGNj620tGxNygoOG45bwlyfSfAenGGcT+VYLQcfNsxTklnZTOujT/cDQh8/+JvL2sk286mkXqMjM1xNPpDTzZpgHenPleask7dFOGDwD+QeR8bvMMPp2aAedflhq20u9qKg6i0BZExzAVNpQcPs4qtRanYf8DzKERQ438HvY/N+AmjNTiBU+3SAFSH3DryPhM1UO+cOWkXKVZsgVcvSdfu0C5aNhvPKvHAouYehhH0IxDS28TS0TWRZsjk9hBHXo+95tHa0vjyCWeD6EZ5Ve8H/bhA4zfqvt0TYoUU7qcfbumxU8yC5ZOzS8YBDH40m6LKOs5Gmx+DK2KLYvIXsaIWaSkhpbVfBPfDK3xirvlux02cRs8H8nvCnA9861XQd/2rdW5X374wyXo8oiHaJfIljJAZpNa4hRq4r4fsM0tn2N1q33idTCdoBkdp0mxpzS5+tRIoGKtcuKn2zgH7omjba/UYcLaxYBW+07GvO4cuJpmXjOV6tyx871bBFgzHNIhZbPzBUcxw6l7CI+2BzVRnRYAKCkNPsNi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXlaZXZkcHlwcWk5c0phMnJ3dkJxNG5EZ0RIS241a3l5NjlhakVqbG0xbFBp?=
 =?utf-8?B?S1lkYkVGRnN4T0dKZ3ZyVXFVNktzNXMvL1psYWwvVkxqbHRYZEVUN3V3MFhY?=
 =?utf-8?B?V1ltVTdjUXJkemQ0OW52bjFmaVd2bkovajhBK0Voc1FkbWEzQStjdlFjUG9C?=
 =?utf-8?B?UmphR3MxS2N3OGRXZ3ZhaWVweDhKRkJuYW5IdUNsditvNXhQS2lnMXRRUUVS?=
 =?utf-8?B?SmdOS29hMzdOT2ppdGloUDRvTXFnZUMvNjZ2NjEzOXZteHo4bWpNSHVyWXBC?=
 =?utf-8?B?L2lxbTR6NnpsVnZLOG53VlpLeldkcC9IQzNiRUU4MDUxdXRUUWhZY0p4Zm5Q?=
 =?utf-8?B?YkhTNnV1bExOQVpLaTJTSjVQUWsrdGpTTjRQbm1DVmdESVdsL01wbEk0Vksx?=
 =?utf-8?B?dklEMnBhYjE4cXBoR3F6N21Qc3lPNFcvZEFpQ21GeE9UZ212cU1WWnZleDZq?=
 =?utf-8?B?QnBzZHNEWnJQZWxuTHFIVGFzNzRhTm56WldaZnBZb3IzY2p3Z0cvZ3lTZ2Yz?=
 =?utf-8?B?dnBzck9Kc3VxUnNpSXh4a0tTUkhqQnJaN0hpZkF4NHNYSlJnK2V5bzVLTGUy?=
 =?utf-8?B?My9NVk8xZnNLQ0xFNlRWREdOcy9KR1FPdjBXU3V3czBqZCsza0ZmTmJaWjc3?=
 =?utf-8?B?dGdodkdIdVZiOERyNzdlOWduRDlER25UVlZxVUY2SjZxaEhxNnI1RXdjSkNm?=
 =?utf-8?B?VkhITmxEdG93K3hYSXZseU12YnR4cHJrTGRaRVZiOUpsZEhwSE90ZlN5RlZq?=
 =?utf-8?B?bDN4cEZEa0hMS21LT3pDS01QZXp3WU9CaTN6VkFWMEZ5d3d6R2lvZGUzVXg1?=
 =?utf-8?B?VHkzSS9sVnNST3oydU9WUE1hMDUzbG15UitQZVVCZi9hV3BtZFBINTNuUisv?=
 =?utf-8?B?MEdEQXVTTERRTW9PYjNvWGNWdkhQT2xrdWNZOWlFTWpWem5ySEsxT1dobEZL?=
 =?utf-8?B?OVFRN0YzM29vS3JVbXZ3Nk5HS2JmanAzV0pKK05EdUN4VnR6ZUZIc3hXV3ZU?=
 =?utf-8?B?NjB0MEhIOTdQRnBDbUFQMDNodHJmK0NFcllkbGg0LzFqa3c2OXlkaVBtZndO?=
 =?utf-8?B?cU1EL1N1NWR2UVEvSzlncUNjeHNXSWdCT3N3aWRBOUZia0lQcm9pS0V4Y3lT?=
 =?utf-8?B?c0F4VEJsUHRRejlsT1pTNVlGaXU0cVhIUVR6dDB3ZjhVc1hOSkhBbmova0Rm?=
 =?utf-8?B?alhRN2IrWGRGMUZWZmxyMWd2eDVEdHV6Qk5tZEFUeVRGanF2SHgwU1J5Q1NU?=
 =?utf-8?B?cDU4amsyaU9GZ2ZKOWRwaTdobVBBWVlubDU3RktQSGkyUXM0ZUx2bGpqY0or?=
 =?utf-8?B?emJzZmwwSWIxVnZGQzFvb2J5Vm5HNnBIeHF3Mm1BdE5zdVNEbkRYdDY1V3A3?=
 =?utf-8?B?bkdXSVJhV2srU1ZyL2JtZHlGZ0t1TlNZYmQvUHFmNzUvNmlEdzFFUTlKZnVU?=
 =?utf-8?B?MURIcm1UR1Z6MFk2NUdqalNuL2hhejdGVVBYMGhWeWZtZ2VwNUQ5ZnZMVjBa?=
 =?utf-8?B?UXRUaGU5Ynh5NTl0WkV3cFBJVG15MEY0VVQwaVdieUZ6Z2owRkpoUWlkb3F0?=
 =?utf-8?B?dWlDYVAyR2kzejV0ZFRHL1Q0UDk2YVRSK002b3RFV2U1Z1ROTklyWWFPaVJX?=
 =?utf-8?B?ajhvdDAwMEdVc09jbDBmRjRMTHFSWGUyL2ppaDRuUUJ5am4rMnZYMllhYU1t?=
 =?utf-8?B?WXE4UVlVZVJSRlJpTXY5TWNFaW42ZEZqa1RsWmlIYUpwT0s2NlZwN2VYZzk5?=
 =?utf-8?B?TmFZSER0ejVDRGU3MDJpd0JXM0VrdXdsQTljai9aSG00UERkeUhLaDNQUjZa?=
 =?utf-8?B?RE1PZ21GVW5lYVF4eElVRngvV3NQQ2RObkdXY3UyMlkwTk1UL04vRFl0S2Jz?=
 =?utf-8?B?LzZ1NVU1aVFadG53S0EzSU9NKzZUeE5UMld0RllIbHZSUHhIUFI0dzFVOHRC?=
 =?utf-8?B?VkJvRnU1L1NwdHBxWjdkZmswOWUvM1lhc3R0SGtZUXpvMlZkTXFyTmFwVEpQ?=
 =?utf-8?B?RFNzV3ZDZG9kVE1YeFZlYS92N1l3UXJCL2FiOEs1d2pGZWVsQjhOeSs0QS9N?=
 =?utf-8?B?VndFeUVIVEIwbmhnelV1UlpKMi8rc202bVhJVitoYUVVL3ZPVVREV1ZoWXli?=
 =?utf-8?B?bE95a3FGZGFNL0creW10c0RTblFjYVdueXRJYnVQQmFqRkFDRXF1WW5oMHBL?=
 =?utf-8?B?dEIrSjVEUnBFWWVZQi9IQVpBWVR2REFkS2xodkpGWjZJUTJGZnpqQzh2T09s?=
 =?utf-8?B?R21oRU1SVnIvS0c3YkNtZ2pyL2VsbGZhTzN4b2lkZ09ZcGVZZFVvWkJxQjYv?=
 =?utf-8?B?c0FVdFZZcE5sL3F1ekR5aGcrUHlxb204U3BpWEpodU1nZnBuZ1ViQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0a6b64-98dd-433e-f7a6-08debc8479df
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:43:50.0467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIv5myteqwa9+/maeQsdcluusVyVxnOQpq34Ho8r9er4ghk8Xza2v5XEojk95GqEGIXpfZebgW3w359Z58vB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8516
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

Use dev_read_addr_index_ptr() which supports both live device tree and
flat DT backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/mvpp2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index f9e979c4d58..193f82ea07d 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -5296,16 +5296,16 @@ static int mvpp2_base_probe(struct udevice *dev)
 	}
 
 	/* Save base addresses for later use */
-	priv->base = devfdt_get_addr_index_ptr(dev, 0);
+	priv->base = dev_read_addr_index_ptr(dev, 0);
 	if (!priv->base)
 		return -EINVAL;
 
 	if (priv->hw_version == MVPP21) {
-		priv->lms_base = devfdt_get_addr_index_ptr(dev, 1);
+		priv->lms_base = dev_read_addr_index_ptr(dev, 1);
 		if (!priv->lms_base)
 			return -EINVAL;
 	} else {
-		priv->iface_base = devfdt_get_addr_index_ptr(dev, 1);
+		priv->iface_base = dev_read_addr_index_ptr(dev, 1);
 		if (!priv->iface_base)
 			return -EINVAL;
 
@@ -5346,8 +5346,7 @@ static int mvpp2_probe(struct udevice *dev)
 	if (priv->hw_version == MVPP21) {
 		int priv_common_regs_num = 2;
 
-		port->base = devfdt_get_addr_index_ptr(
-			dev->parent, priv_common_regs_num + port->id);
+		port->base = dev_read_addr_index_ptr(dev->parent, priv_common_regs_num + port->id);
 		if (!port->base)
 			return -EINVAL;
 	} else {

-- 
2.51.0

