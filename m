Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A0CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D61846F4;
	Tue, 26 May 2026 08:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CLvKmJzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9E8846AA; Tue, 26 May 2026 08:08:52 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA8A846F1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRJlNTXhKRC6vyGmzJWzhVmDkgVMTHYFXms+77zlS//VkschdDUwaa3FPkDNZFeTwQNrFJ5ZnLr/kEv8IWqO7IUeFNPOvy01KtRao4+8qksM9PToLiNFhVanTTA4PoRvF/MiEIkPzzAWiNig9CZHXWJE5maDBrnw6YyHKFHPp9Z6hX31ah5EzmF2PuaH89ABAC0ZTFBLUjjfHxnjHVkE5UdMnZ6qGAdnG4rDujPeRv+EZ/4/1H+AtPV5cAZQigzG9Y85SHX15VT4u0fUGezjOaNzkIAKOjzhEZAEbDxCDyxze0WT8ZBiWrM22tdhfQAr3VrzSGXexde0dB/l4wvxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3oaLGZfHIWUGKS+LU8lUtvN9nzp58uILNFISsaNl7E=;
 b=VE03x6qdj8E28s9LJQWwFSc40xKihILEfvyRSeisSy23GEICGY2tgIkdcdnb5J5YkAvuE4SfG3eQVyVTkKbepc26arKoK8srY3VrtILkhVmo1Wsb9SDfi8VNK8wz2CkWBPDm1hFvPS98rhFnzVW2VV7oZ9QhweMcwe9/fc6FR+pl5oMPBKZ7r7ejbbHLrwWwrLPHO6ZudfxJVl7nacUIbphIdYLbpnrpm+KV7KK5m6HriT4uxa708FGcTzDLTBzMwPEgX+7rIxKn5bFycq1chnY6Z3HwXIAypq5mO/T9eiCaw5ag5JE8ozVtqKec7kURU+g9EJ5kInzDhJUOwD3H5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3oaLGZfHIWUGKS+LU8lUtvN9nzp58uILNFISsaNl7E=;
 b=CLvKmJzdkzfvLTm2WgzINH5OBRzXowKvKLrLrzjZ/bPwK7R9yZaTVvOEhNQlQbglumqDpVOW3wooEltepnqFKp1O06Dgza2UXuU/9v6NMk9lRZox56uYV17tTi751oMrc6qSbC314MXKA9YBnai5659qTbN5WENzSsJdnBCG+bKkuOa0WqP0gEiSg0nJukdJygISd3IXzU8hpLh8TBsO10kVaPO7gJI0PyNn4xRpWU7ykoZPK0EBIuQCfny76heBsBMACu66l/lqACYustLy6B3Kr5rmuEQfwBR6u/afjsWeqRLbur56wcEfrEf4q8Z44e8CJUi3F7FSWtekZS6KnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA2PR04MB10516.eurprd04.prod.outlook.com (2603:10a6:102:41b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:08:47 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:08:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 15:25:15 +0800
Subject: [PATCH 6/6] net: mvpp2: convert FDT access to ofnode API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-net-v1-6-be3597b85b5e@nxp.com>
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA2PR04MB10516:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5e4fe3-03ba-471b-c5d5-08debaed3fcb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|18002099003|56012099003|22082099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: bSZ7RJu1l+yyrkWeLUbvie1duotWQhyVuwXTRYjrCCmqftF365FpgQEoLfp/uf/pq1PoWxrNyl5zjfglIazt71N9kv0AZBu4UuN04s9yve0dj0JCuyq5piUE1pN2crxHQzmeADAA/JEh7fKsT4fh99MU+ib11zabpo1v39JHeBaL1HJXRKaWAV7rKELWOvxh0ybtNmb47eLdn+rRn3vGthoxPs2k0HY0u3afQSKc6jW4/EbpCuwAtD/agsJa2/hyJSOFZYEHjMHOz0BJWYuJ4YOC1EQUjN9m1QdlIulv/a2lJWEV05x2qUVDfQL7gn6PjLqRPm++JZNW6X1q6ZMuSv9I7xQQ31+idJBfxTCM8/JikOAv9MdMJNcHcUi7wRpC3ofBg2sI+MiPsdxFBfn8BANqlpqhQ5fqH5bdhH4Kp/pMshRyai/nThTnBZNAnuCi2D5lLV7cB6di25bU0UgJW3jOCoLcltgP6Dly1aHF5LIDuIk3k6/Duri096ahPrQJUGS/OolhMMgNiW1l404WtswYYsWVTlB+Z6vxj4M8kciyGCIXZsCvUzAJJwMTEW0ZYh8CZfZcXGlQGq4Iol8l5AYUKXX9SWD6XSYLjGvVO/5eP8ZCJDBR/5EXHEUVWyrqw8lE2GKB/t3FWGYoj2Bd1hFmRurGWg2CLjEj/NB9Vty9CRQg0Dh3T6CWvQevsyJxAmjAiHa0GcrplrnAr+dAvRdXG2UPrLSsNzwbCGQ94Piszk3KDnOmctgUU1MlcLhc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(18002099003)(56012099003)(22082099003)(38350700014)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVlPQVZGNjNJK1g0a3UvQXUzelBVNkErNjd6aklNYWN1WDlMSFlYSURwdkhV?=
 =?utf-8?B?Rlp0bHg5U3BSd0lJOENuaW1EQWRrVEZQd0IxUEZiVTRNNEltOUc4L0VGNUFz?=
 =?utf-8?B?b2dFL0liZi9MUWpZL216QW5tZUJwWGFwdjZyTWRFbEZBbFNrNWJEaTdZUHR0?=
 =?utf-8?B?ZGxJMFc5OU1QZjNxc2wyT0FrOTQzY3hmOGkzUkc2YTZBS1lpdVRtTDJaSVl2?=
 =?utf-8?B?b041UXBNb0I3alQydHB4d0RiOGVmN2dqbmdkSFZRS2xVb3pJWjAvRjBjNzBo?=
 =?utf-8?B?V3Z4TE5GUnFwbWJjOGgranBOK2FYaG43TFRLbVNVbFM5VmhhYjlBU2hITUZJ?=
 =?utf-8?B?dDgxT3F1VFJOeDB3N2tMWStnaXdla2wxbUVtOFVvWFFuNDd1aEIzOU12bSta?=
 =?utf-8?B?V3NIZ1BTbUI4NEJoMnV0ZFZEVldEbkV5enppTFZuYVB0SThBcDZJdG5XMkxv?=
 =?utf-8?B?dFc1dXFzTTE4SEgydkdYMXNnMm9LQUFUb0NQZ0JWR1RFRnIrNksxRk9TYXgy?=
 =?utf-8?B?WndITlFMT2pzSTBrMy82K0hxTEFQM0tob1dtN1ZtaUlocUlzY1Q2c0FzNXZx?=
 =?utf-8?B?cWNXRTZ1T21ubnN6b3hWYllJNXhFSG1QTS9xWnA0NTEwY1VLc0dsdEF2NUhN?=
 =?utf-8?B?dndNVkd1RWtOb01sYXdXeXVhOERPQmtiaHA5RjBVMjc0YW9iQUFmbVRnaW0z?=
 =?utf-8?B?aGlHK0hzVlpQY1RVU0FlZXJKdUx4UHZhZDJNM2lJZnBTZUhzZE9ZcXo1Zkkx?=
 =?utf-8?B?czNYRGU5dnBNM0xqY2pleVFhQmZhaXR6WFlIeCtJdVBSQmxxNEE4Lzlya2ll?=
 =?utf-8?B?enh6YTdRWC9mMzVGUCsyblZncmc4T1Q4b041azAvMW9OdUtyMjROdElrYVM2?=
 =?utf-8?B?V050Yy92cXZvaHREaVJWZ2dyeVVBeXQ2YnlVOGdZQmFqbVBzcDZyTkhHSjVY?=
 =?utf-8?B?NEE5dkt0MGFMLzRNZFkzZXVlMUxGYnlPUnNYc0RyM2FTRzNxS2VpNjh2R3BB?=
 =?utf-8?B?WWgrbnNMUmRPN1VVZmd3cW15enZ1MENXeHhia3pjYlJPeDZLUnhpbjFVN3k5?=
 =?utf-8?B?SFhrWENwZkxvanlvbTAyQW5zWXp3V05qejVpYktpSHAyTGI5blg5KzI0MTJT?=
 =?utf-8?B?Zk1sZzJXTWU0MWVvbnZVVTI1dlIyVEtOdjZDVWJXZEsrTkt3UWF2K0FyYUxM?=
 =?utf-8?B?dkhMeDFER0laM252cFE1a3lLZVUveC9kL2wvTFVWUFZUeWswRGJPVjlmK0xD?=
 =?utf-8?B?WDN0eXloNzJtYU42aXRZanBPRjBHT1dVbUQwUTdoc0JEZ01uUGYzakVwRWMr?=
 =?utf-8?B?U0FxVGgyWGdsNFJHUnBzU01tSXFJVWVsbDQxWkVLYVM4M0F3MG4wRU54Y2x1?=
 =?utf-8?B?VGhEekNBeFpwaWk3dXV4bzZScFIzS2dmR1dNUElQQkJ4WXAyUTdhNGw0MStY?=
 =?utf-8?B?b1J4L0FUMDR3UGM1VjJmbTRuSWV3MWlVckpEQ2N5NjZjYVJjamNMNGJWSm9R?=
 =?utf-8?B?T013V2l3czFFNGFIZkRqS3JjZTBQYS9DU0lFa0QyVjZEK1VUcDBRODRncWVU?=
 =?utf-8?B?OHIrdlNpUkJjNUJ0UW04blBKMUZ2Z3RjZWludFlzU2E3ek9VSm5CQXJWdnEz?=
 =?utf-8?B?MDBXazFZMzFKM2FjTXY3UHZzbjI3WFlEU0MrV2Vrc1V6QlA0bzdGendFUGNr?=
 =?utf-8?B?dlNTTjQrQlhkUVlVTWNuaElHSFZJRzNQREpGNFBiTkFUeFFMckJldGlKei91?=
 =?utf-8?B?R01OS3FWWlpaZWJwSjFvK3F1R3pQUXZkU1BlZUF1K3ZlNitURy80YmQvYmNL?=
 =?utf-8?B?dFY1eUR6TkZUS1R2eXpWSzhuc0tReUlQVUZrQzlEaG1Bc0loeHcrRjhMeU5K?=
 =?utf-8?B?VElMdlNlblNlWmxvcjExbTNhaVk1UERRMXdHaktGWXVzcWFuNU1sSWRBTm93?=
 =?utf-8?B?dTRwT1dKVnJpWXovRFdlZWJidUlyYy84bGVoTDVGeE4xTmtUekp1WGE2TUd6?=
 =?utf-8?B?YjN3Yk9CRkxiNElScVZ6cXVLOWpscFlkRWplaDdUZHNwb0taRnlEcHRZZzgw?=
 =?utf-8?B?K2FlSlJ6ZWUxZWEwaGFnbmJ3ZFBTOVZvbEJjdnViblp4citWS2NJL3NIREFK?=
 =?utf-8?B?Ymkxc0I0b3RTaFJkcjlUWmVGSkZaN2FVeXZZMmZXbEVRSmRuRWNXRmtKOXBt?=
 =?utf-8?B?eURyckg2VFo4S2wxUTNKZlRkWngvQXVmRlFDVDA4UlIzaTB4YjFTd1hhdC9D?=
 =?utf-8?B?UURuMUlERU9LNTA3QmRWVmk3RktuS0FoVHV4MHdjOXhzTWJOSFFrRW1zU3h4?=
 =?utf-8?B?b0pzay9vYy9kbnF4VGloZG83ODZBSW12THJ1NEZlSkJsTlRLVzVXdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5e4fe3-03ba-471b-c5d5-08debaed3fcb
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:08:47.4609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+q7kliLpGxgMrkZnVZ6CZBD/ZtfdUt2zSruAdb0GuViPnxFfzgRO/XBNHgWlz8lXRo/APJp67uLxRkXUFusWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10516
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

Convert mvpp2 driver from legacy fdtdec/fdt_* APIs to the ofnode-based
interfaces.

Replace usage of dev_of_offset(), fdtdec_lookup_phandle(),
fdtdec_get_int(), fdt_parent_offset(), and related helpers with their
ofnode equivalents, including dev_ofnode(), ofnode_parse_phandle(),
ofnode_read_s32_default(), ofnode_get_parent(), and
ofnode_for_each_subnode().

Remove direct dependencies on gd->fdt_blob.

Main changes:
- Use ofnode_valid() instead of integer checks for node presence
- Switch fixed-link detection to ofnode_find_subnode()
- Replace uclass_get_device_by_of_offset() with
  uclass_get_device_by_ofnode()
- Update subnode iteration and device binding to use ofnode

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/mvpp2.c | 54 ++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index 193f82ea07d..27f785163ba 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -4731,33 +4731,34 @@ static int mvpp2_port_init(struct udevice *dev, struct mvpp2_port *port)
 
 static int phy_info_parse(struct udevice *dev, struct mvpp2_port *port)
 {
-	int port_node = dev_of_offset(dev);
-	int phy_node;
+	ofnode port_node = dev_ofnode(dev);
+	ofnode phy_node;
 	u32 id;
 	int phyaddr = 0;
-	int fixed_link = 0;
+	ofnode fixed_link;
 	int ret;
 
-	phy_node = fdtdec_lookup_phandle(gd->fdt_blob, port_node, "phy");
-	fixed_link = fdt_subnode_offset(gd->fdt_blob, port_node, "fixed-link");
+	phy_node = ofnode_parse_phandle(port_node, "phy", 0);
+	fixed_link = ofnode_find_subnode(port_node, "fixed-link");
 
-	if (phy_node > 0) {
-		int parent;
+	if (ofnode_valid(phy_node)) {
+		ofnode parent;
 
-		if (fixed_link != -FDT_ERR_NOTFOUND) {
+		if (ofnode_valid(fixed_link)) {
 			/* phy_addr is set to invalid value for fixed links */
 			phyaddr = PHY_MAX_ADDR;
 		} else {
-			phyaddr = fdtdec_get_int(gd->fdt_blob, phy_node,
-						 "reg", 0);
+			phyaddr = ofnode_read_s32_default(phy_node, "reg", 0);
 			if (phyaddr < 0) {
 				dev_err(dev, "could not find phy address\n");
 				return -1;
 			}
 		}
-		parent = fdt_parent_offset(gd->fdt_blob, phy_node);
-		ret = uclass_get_device_by_of_offset(UCLASS_MDIO, parent,
-						     &port->mdio_dev);
+		parent = ofnode_get_parent(phy_node);
+		if (!ofnode_valid(parent))
+			return -ENODEV;
+		ret = uclass_get_device_by_ofnode(UCLASS_MDIO, parent,
+						  &port->mdio_dev);
 		if (ret)
 			return ret;
 	} else {
@@ -4771,7 +4772,7 @@ static int phy_info_parse(struct udevice *dev, struct mvpp2_port *port)
 		return -EINVAL;
 	}
 
-	id = fdtdec_get_int(gd->fdt_blob, port_node, "port-id", -1);
+	id = dev_read_s32_default(dev, "port-id", -1);
 	if (id == -1) {
 		dev_err(dev, "missing port-id value\n");
 		return -EINVAL;
@@ -4812,7 +4813,7 @@ static void mvpp2_gpio_init(struct mvpp2_port *port)
 /* Ports initialization */
 static int mvpp2_port_probe(struct udevice *dev,
 			    struct mvpp2_port *port,
-			    int port_node,
+			    ofnode port_node,
 			    struct mvpp2 *priv)
 {
 	int err;
@@ -5350,8 +5351,7 @@ static int mvpp2_probe(struct udevice *dev)
 		if (!port->base)
 			return -EINVAL;
 	} else {
-		port->gop_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					      "gop-port-id", -1);
+		port->gop_id = ofnode_read_s32_default(dev_ofnode(dev), "gop-port-id", -1);
 		if (port->gop_id == -1) {
 			dev_err(dev, "missing gop-port-id value\n");
 			return -EINVAL;
@@ -5375,7 +5375,7 @@ static int mvpp2_probe(struct udevice *dev)
 		priv->probe_done = 1;
 	}
 
-	err = mvpp2_port_probe(dev, port, dev_of_offset(dev), priv);
+	err = mvpp2_port_probe(dev, port, dev_ofnode(dev), priv);
 	if (err)
 		return err;
 
@@ -5436,15 +5436,14 @@ static struct driver mvpp2_driver = {
  */
 static int mvpp2_base_bind(struct udevice *parent)
 {
-	const void *blob = gd->fdt_blob;
-	int node = dev_of_offset(parent);
+	ofnode node = dev_ofnode(parent);
 	struct uclass_driver *drv;
 	struct udevice *dev;
 	struct eth_pdata *plat;
 	char *name;
-	int subnode;
+	ofnode subnode;
 	u32 id;
-	int base_id_add;
+	int base_id_add, ret;
 
 	/* Lookup eth driver */
 	drv = lists_uclass_lookup(UCLASS_ETH);
@@ -5455,19 +5454,19 @@ static int mvpp2_base_bind(struct udevice *parent)
 
 	base_id_add = base_id;
 
-	fdt_for_each_subnode(subnode, blob, node) {
+	dev_for_each_subnode(subnode, parent) {
 		/* Increment base_id for all subnodes, also the disabled ones */
 		base_id++;
 
 		/* Skip disabled ports */
-		if (!fdtdec_get_is_enabled(blob, subnode))
+		if (!ofnode_is_enabled(subnode))
 			continue;
 
 		plat = calloc(1, sizeof(*plat));
 		if (!plat)
 			return -ENOMEM;
 
-		id = fdtdec_get_int(blob, subnode, "port-id", -1);
+		id = ofnode_read_s32_default(subnode, "port-id", -1);
 		id += base_id_add;
 
 		name = calloc(1, 16);
@@ -5478,8 +5477,9 @@ static int mvpp2_base_bind(struct udevice *parent)
 		sprintf(name, "mvpp2-%d", id);
 
 		/* Create child device UCLASS_ETH and bind it */
-		device_bind(parent, &mvpp2_driver, name, plat,
-			    offset_to_ofnode(subnode), &dev);
+		ret = device_bind(parent, &mvpp2_driver, name, plat, subnode, &dev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;

-- 
2.51.0

