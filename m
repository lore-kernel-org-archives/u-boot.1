Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2375CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 06:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590B1846D1;
	Thu, 28 May 2026 08:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B0AN9Uqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB0484702; Thu, 28 May 2026 08:43:56 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44DC846DE
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkFTtex8SPnPSJE5gPlcJcOf6fvLNSnr7998w/Xd4TcD0LEb2prG6DgVJ6248/RL1OfhujJz6ObE5UZ4U1FKdGgHsnE1yIdpQFJJ2rR806JIIt/ljbQtpR6i+RPWaxj9zTkQkGM+OJw/RZTiJXpQw8yFouxgr9vbpix+teAtlIqfahmuOt2HjDSkbNhV8HwrCiuCFi+IYaZGrBOlm6O3sdL8T/F/O4selQEMWp+IX65Swjm1wtiJdlKresa3IBlWzeaZIF9yhqJObfePDIb5Zlxlckh7VJ1TpQVZcl2l1QmC7K5tGwq3VFIG1nd8mxW6fDSNHa4rTBTrMvh+tBZ/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfZLjk9MuDtirSZxIwvpvs3j8gg9pYJVv8DRSGUWYRI=;
 b=uhql6uY+ytu0ewJEmaMCA3j8h4lMvsFbnTXojiybebqAOXUhPfl5Lofl+eFVbjY3IsJxNiyss+xl5xPfDeTFcNs3xofWQLy0VEWBFXjBgzLMEx75JpP+an6FGyaBFmmx8b7H8085Uc5Rsa82HlqYXAGWXQ48PxJ1nuP/PrT6f06qoiabKdedZU6nhTuRKTxHvW3OOskUUYtXWc9gjXrWgE9HtPiU4rgGi9XwzbgtP9A96J9PnU6F90Ov1XtnprcmCJL79B21HClOXythTl/GMOtVMFfBhfbfVAjLkw+yeVpP7mbbBSs9WInWirBKhIfUpFiXvHuqb2mpOgRGNzFT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfZLjk9MuDtirSZxIwvpvs3j8gg9pYJVv8DRSGUWYRI=;
 b=B0AN9UqhUlgJWVgCJWJkVMAXI7gaJrOBN1fHKRI1EXXIOBhLb7Jp/92jBXFz/IfER9EAuWqbXX0JeQaPnfZhBjv4jdlkyDn39xJafOvHIFPUXJ1yhHVOEWfTXOuz8bmSq4NeWknfRTP0bAI9NRPYOmuPFZ+5N+jDKa89DoJF22g3amwjm31bFCZ6tbaktStyim0Qh0Bo4EVsW6gLvq0ZU0ojhqcNBObcIh3YRi2/BLSD0fkzB9uPk0oXg65rGq6vm/YCZ8sr9XbE1ZyT3SZE25+nCO4TDS/Nkp4bQQF0nNnS5njqBgqggfeTpqVmWG2tU0q454E8qAPINbDTXESGUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8516.eurprd04.prod.outlook.com (2603:10a6:20b:343::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:43:53 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 06:43:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 May 2026 16:00:24 +0800
Subject: [PATCH v2 6/6] net: mvpp2: convert FDT access to ofnode API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-devfdt-net-v2-6-dc6f20b82611@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58df4852-0b50-4ce0-95ba-08debc847bc1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GISgy5oV5NS1/psTHK43xpmHsjsaPO5jBgFD00EoWCQUyfZW4XCy6Z6+oIeZ59w6P+6uGCo9TDsA1T7DAdxit22TkEPXcDAcvcyvAeR66x2/irrvUVtLWQJfT2dydzYlqBZCYH3MmGxQrrBsowKMqB/GjjGxE9dmhPqRv+DlgAzLXSNfy7PR5fFL2KOaKwknvWS4ZoRn0tS9voV8Oe8rV3NI65rwJ93ALkWr9Exxx76BTzfWgYRWIgEOzcspJwNdkvxr2J5DemIxAfX/jYSjXJR+tDTNt6hTcBy/i/VdDFvI15jAfCE2ULWqYEoWCHn2fsxYHF7FIBc6IqRsABZ6Fv0r59B0sIg0HbzetTv9dxAkGxq4nfvIlNYIxz6I6DkwC4JSBPE63d1WM4A83gEAbohDR9JZWivMp6ThTnsuxoJQTlp8VYpZSdyGAKt8xsQg3ozXD38eDgvb3QlJYyYLm+zd5RI5ePK4lx5Ocghef9bhbFGysg0Ub2+cYIocNKTSi1shjnVqm9wPgVo2D2fO8PEoU2o6/2f8vsaedfrDkjXPOTXx8pKAwvOhuvyI06bnKdqXW3E5qQ7i14M7u8i5Srkn3JwTPOPCH6DLSIkyfgKHwpxcQmy9xTGJJYHzPvAKbjn7agf14UkCmp+NtoWtUvyE4LhtoVKXsdGpOUcXpQYxWymkfClKj4dhv2yFun8EftPRcxqVq3q2KKyqYdVbsqQv4kHm4yAXiLBTGlhKiDUPyJLImPkQcHJAI8c9oiuU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmU1UVd5V2RvVk9WY01CSjBpOHQ1eVZOTkkwbVcwMzZ3RS9GT0g5K3ViQ3Zq?=
 =?utf-8?B?dGlCVDJwRnloSFRPWnVpVFVENmU1WTI3dGRCMGpzV2o3SkFIcVBzdjN2UG54?=
 =?utf-8?B?NUNzU2FaUzQrdFZkRXJvWWhHRVdlK2ZOUnZVL3A1Q28xQXdrdVUybWhUTnFl?=
 =?utf-8?B?UVFUTllIbXhOOXhscTRiYTh4SElXc3R4ZmFyL0RodldONEFQR2ZZOVIxM0hs?=
 =?utf-8?B?ZzJiZzlibGw2NnJ1ejdGMGpiMGZvdWNrQ3R6U2R1YjMzdGpuL1dYeUt6VXNB?=
 =?utf-8?B?eGVDT0Y5YTMwTVdSeWRnbjN3R3N4S2c1Z3hvV3BJbG5zcDFVNGNuYnVBODJD?=
 =?utf-8?B?L1pvc25CVWtFTVByMnRuWGdTQmtqTitxUUlsYzdLUWZ6YUxEcmdieDhmc0xP?=
 =?utf-8?B?dzlxcmI0a0ZUTGJ5d0JzOENka2dtT0NoK1pBMlpQM2k5VWo4RTBSTm9rTzZj?=
 =?utf-8?B?VmJ2bUcwcG1ucGkwYjE5a1VxSk1QKytIY0FjcytaYklySm5SN3hDY2ZiYXBw?=
 =?utf-8?B?elFnOXBwOHFxSk5NUTllTDhIcFA1b1pLNHJ1dWpUNHlXaEJZTk4rMkRrL2pu?=
 =?utf-8?B?TEVMTi8rbDl5andJUUY1SUs4ZXdSVnhheWZtRGFXZ3pEaWpKYy9HN3NzR0hM?=
 =?utf-8?B?cFp3ZTFmanpYN1J5RGVNczRJVXN2bngxQ1VpYzNPdXIyK3dla1licld1NFph?=
 =?utf-8?B?bUtxOUU0b3N1K1lhU3g1R2x1bW9oYzlBdWhqaER2Q2V2NnJiMStyZUVuREFD?=
 =?utf-8?B?QWhPWURkZHo0ZTU1MVpxK0ZLMGgzN3V0NmVVSktDZTFpVXUwVGloQ0Q0VlE3?=
 =?utf-8?B?SW11di9nVUlYTXpUMHl5ODRxWWkxaG9XTnJjNmRrSlJZUEU5dVlPT3dlWGxY?=
 =?utf-8?B?QXF6OUJ5YklEa1l3UUErZ0pDWENSVHRkcEJhL2phSkNxRmRIWnVMeHJHeDFK?=
 =?utf-8?B?aTY0ajFKV3A0K1I2djliV1hGU3VpUi9jL1pCYWUyMDJUbDBvU0w4WnhHWncz?=
 =?utf-8?B?djYrRVdTOStCSG9oV29zZndtQXVrUnFKNlVhV3JYKzBtR3ZJR0I4ZXhZUkZS?=
 =?utf-8?B?UThCN21zZ2h3R2wxT09IcDJxSXV0NHFXRml3d2hxRHlqN0dtZWJFaUNUL1c1?=
 =?utf-8?B?KzRoVlRPcjNRVUNMK1ZuZjFWM3RmeEMvR2J1MTJDVmo5YmlKbVZ6Tnh4clMr?=
 =?utf-8?B?dEE4aW5wYXJHeG1FMmRJcUwzQUhFUDgzcDh3SlhOcGs1aDdDR0ZZdklzbExy?=
 =?utf-8?B?RzhyVGZIbHlKdlE3a3hQMzJIRjBmajZjNFpOSVBOdW9sN25XTXRlQXFDcUxY?=
 =?utf-8?B?MmVpTFl1NHdOVnJSS3IrbkNRRk5HbnNxVGh2QURmN1dCNmg3K0J0aHA2YUEz?=
 =?utf-8?B?UGhtVk9oL3kzUlZLY2lSWjJnRWJRbE4wcVF0QjhVRG9GaTJkQ09Db2V5Q1NX?=
 =?utf-8?B?akY3UzFxaW9sYVVJQTBhb1BlK0R5bWNKcTlUODNVT0JDcHRQS25UcWFoUVdm?=
 =?utf-8?B?YVM4SkpIaWtZK0p6NTlXRXkwbk4zcVJIdTJKUFpxSDA4aVJHT2xPSlNTSmIr?=
 =?utf-8?B?NkFKMHlFRnBCaUlucTNEZlpNUWhubjk0TFRTQkNWT1M5RmVTa042a3NCamdz?=
 =?utf-8?B?RENpVTBxUEhqQkRtUS9heDhyTDFEUm42cStjSGU3aWpkUXd6SkpWZUZQclY1?=
 =?utf-8?B?dlpDSGs3TEY0WFVBODg4TGtPMHhJR0FFemc2UmxkV1g1Z3FRSlJBdlRlcWtT?=
 =?utf-8?B?c2RnVnJlcVN1OEJtTlVtSDZpMjhYdW1NRXgvTUVaMHYwdXRFelZKNjA1M0Fs?=
 =?utf-8?B?MERKOXE3aHpRWlJxTk9zTHpCcVZ3WlFaemlFV0RqZ05VSkxjN2FFN1dkc01p?=
 =?utf-8?B?WGh2aW5ZbHhZOUg3ak9qVk50S3NCS0VaMTY2N3RLN2lMdjZPaU1HdUx4ZXJX?=
 =?utf-8?B?UnNmTzZ2UUJNRWlKNzRYaFp3eDdGZmZsUzV4V0NtRnFrdHdCdTBPY1Y2cFNu?=
 =?utf-8?B?Q0hmMDRBdXoveXJwRkRGd2RLSzhyVkpSOXlWRjdwZVBheCtFVDdoblI2OWhR?=
 =?utf-8?B?MjVvRll4Tng4TVk0VTJ2dWFoWVpNLzRqNTRKR3dpSXRFU0tuS2lDWlhIcEUw?=
 =?utf-8?B?RTlZdnovd2JsYVZuRmxrVVFMYjZuWEk5MWxxNXFNdGp2QWdVMjhoa2hEYkFV?=
 =?utf-8?B?SFcvSWw5WWJSbFBsTWtKNy91cysyNEJRWWVoYWtMbEVtSC9yajFGYVk4bjEr?=
 =?utf-8?B?eGlUMXlRcUR0KzQ1ME5KOGRzZkdkZFl2TWpJUCs4TmNRV0FNM21aWm1KZktz?=
 =?utf-8?B?Yk5Bdm9jZzRzcjRGVjdBYUZEa1ZUZmxKeVBoZ0JIYU0wSjBwZjJpUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58df4852-0b50-4ce0-95ba-08debc847bc1
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:43:53.2000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfGcZd+Fl5EW+1NxO2LBdQmyRyt3JCQUWxD8n1fhIhRmPEv6AdvAPF43Dthuc1iyJ6OpKjrFYn+2rpG093kHWg==
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/mvpp2.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index 193f82ea07d..fc137df14c4 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -4731,33 +4731,32 @@ static int mvpp2_port_init(struct udevice *dev, struct mvpp2_port *port)
 
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
+		ret = uclass_get_device_by_ofnode(UCLASS_MDIO, parent,
+						  &port->mdio_dev);
 		if (ret)
 			return ret;
 	} else {
@@ -4771,7 +4770,7 @@ static int phy_info_parse(struct udevice *dev, struct mvpp2_port *port)
 		return -EINVAL;
 	}
 
-	id = fdtdec_get_int(gd->fdt_blob, port_node, "port-id", -1);
+	id = dev_read_s32_default(dev, "port-id", -1);
 	if (id == -1) {
 		dev_err(dev, "missing port-id value\n");
 		return -EINVAL;
@@ -4812,7 +4811,7 @@ static void mvpp2_gpio_init(struct mvpp2_port *port)
 /* Ports initialization */
 static int mvpp2_port_probe(struct udevice *dev,
 			    struct mvpp2_port *port,
-			    int port_node,
+			    ofnode port_node,
 			    struct mvpp2 *priv)
 {
 	int err;
@@ -5350,8 +5349,7 @@ static int mvpp2_probe(struct udevice *dev)
 		if (!port->base)
 			return -EINVAL;
 	} else {
-		port->gop_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					      "gop-port-id", -1);
+		port->gop_id = ofnode_read_s32_default(dev_ofnode(dev), "gop-port-id", -1);
 		if (port->gop_id == -1) {
 			dev_err(dev, "missing gop-port-id value\n");
 			return -EINVAL;
@@ -5375,7 +5373,7 @@ static int mvpp2_probe(struct udevice *dev)
 		priv->probe_done = 1;
 	}
 
-	err = mvpp2_port_probe(dev, port, dev_of_offset(dev), priv);
+	err = mvpp2_port_probe(dev, port, dev_ofnode(dev), priv);
 	if (err)
 		return err;
 
@@ -5436,13 +5434,11 @@ static struct driver mvpp2_driver = {
  */
 static int mvpp2_base_bind(struct udevice *parent)
 {
-	const void *blob = gd->fdt_blob;
-	int node = dev_of_offset(parent);
 	struct uclass_driver *drv;
 	struct udevice *dev;
 	struct eth_pdata *plat;
 	char *name;
-	int subnode;
+	ofnode subnode;
 	u32 id;
 	int base_id_add;
 
@@ -5455,19 +5451,19 @@ static int mvpp2_base_bind(struct udevice *parent)
 
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
@@ -5478,8 +5474,7 @@ static int mvpp2_base_bind(struct udevice *parent)
 		sprintf(name, "mvpp2-%d", id);
 
 		/* Create child device UCLASS_ETH and bind it */
-		device_bind(parent, &mvpp2_driver, name, plat,
-			    offset_to_ofnode(subnode), &dev);
+		device_bind(parent, &mvpp2_driver, name, plat, subnode, &dev);
 	}
 
 	return 0;

-- 
2.51.0

