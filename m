Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F31FCD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 01:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA8F84A92;
	Sun, 10 May 2026 03:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="jyahH3TG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE708466E; Sat,  9 May 2026 22:01:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20a::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB2A84666
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 22:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChCVjFKjijdeEfuE961cCvkHU0PZwdB0pGcEQzBMUTF42nX0BuGL5Jvbgr+HgjH4sgDbdYEB9kKMckXw48k6/Gg6G9QFQF++0m7rq7JTqRDOMOyf0tCPIZYit4SSxdTLHJVJx/qEV5HbdFikov7EIl0FzgWZxJ3aR5suPGAYLWcf6Jv/O8CQl25/xMMzg4XXouON6hyab9iZoh5nXavr+p7MYh2e0j39j2E8vbVdNv0Q3MSYlEWTfGIIC5WeDk6QHDXcB1kfhTvOtVeo0AUW/2uVJMjmfo5CjY1UM4GVOoBpW+rMY9L4kUFCFf4COLzeXyoNHnRP76u43xGA4lKcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHiovTZexoG8MZYh2vmJDXyYEvrnMdloLwKtTGmSDFo=;
 b=Ok+t6DvAQ9QcNpjI6KDC5ndsMhaxDNwuMW34GWfNX925ZLPzYxTyXcFX58b0msSS0BN9GXG+g+k9l/q2isQ9wjXjj089mh7SL0yGkrFd9hur4e+6GDeV3QS0Vh/DL2VEneF8UplLQU45X1RCgsv/RAh2jhGmUPQ/3oI+qeRxS9KMBltSu/VJgBWuP66CpauJX0+aDCwjhJvcYqZtBiE9LAD4iWZaBNHiwKnyWeAfQ0xuDiRmvoK+a3tyaZquYJ3PRgkuCqerIZPHUb5448cHFGY3Q3InsjP3Mq2iJVqjTmI7EN90jw3bXS7uYiMluuIYxEy/2oCBysq8GmNm5tDg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHiovTZexoG8MZYh2vmJDXyYEvrnMdloLwKtTGmSDFo=;
 b=jyahH3TGgDP8lCrGvBYl1WnCbDTCfmny9qMO5iIYk8Dc4roOpTIeJDpEI3FZgvzAHxLn3KYcPB0h9Y7xsi4ASfaDV4zVpYj7uMyE9fLtxaH2Vxk+toHiNFeGyCPJ2Fdf3Ov9kuWDntiJBDR9SVdYVGaGT+VT5HsRAzXpv5RPqz12IbrQYYxbcSOWGm6jXwOiKSfdvpBCj5+1+foAV6zuX4qJUGA1sk+nwZD9FVPBmtDLC/HMXY9p9UOoehlmc2gVPhamP2mgYsTG0bsH4KNgqw2erXNHdmPuYhaRNQXohjE0pLP0ETG8gWJQ+gUWtAXGINoljrD8KICMI6E5T5CsKg==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DBBP194MB1161.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:1e9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sat, 9 May 2026 20:01:45 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 20:01:45 +0000
Message-ID: <BESP194MB28053AA411008729F40FC707DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 9 May 2026 22:01:42 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] net: ti: icssg: Fix portname buffer overflow
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0058.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::15) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <bace8a14-515b-4293-b41f-6d34c6be670d@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DBBP194MB1161:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf234b8-0615-4d6e-21c8-08deae05cba0
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|37011999003|23021999003|8060799015|55001999006|24021099003|15080799012|5062599005|5072599009|6090799003|40105399003|52005399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmNvck9SRlRRWlhKcmw0b2VJQzVtTFJOeXQrZTU3cE9ncGhYZ09NbXhXYXVq?=
 =?utf-8?B?VmpuSG5uZ0htMG9HNkMvWkVzVndRb0VUNGFtWHdKbFN4Wjg5d2tKSTZvelpz?=
 =?utf-8?B?dUVJL2hac3VVVDIzcklDVjk5SXFIU2RPYVhsNFZ1YThQaFJmdWt4Y1VjNEEy?=
 =?utf-8?B?bDNoUFlzbFFxUUNxN0tJank4SkUxYi9xR0RsN2d6R2NHNi96dkJKYmlqdFVz?=
 =?utf-8?B?WDZlZ0dHdFc2a0M0RU1CMFpQSk83Z1lWV1VnZ1BOM251WWg4eEtMc25tbTQy?=
 =?utf-8?B?ZHJmSEhmb1h6czBpZnpOVkRMZlZVR3EvMm1CR0k0UUNSdzU0R3VnQk4vdnpy?=
 =?utf-8?B?Tjl4MVI0MittUy90YWllRTRpQUdtdEFhVWVNK3NOOXVmd2g1MDJocko2bXRO?=
 =?utf-8?B?NU1Ua05FRnNDK0psZlJVdE1INU8vNmdscVhTaWxCaXNYbU1UaHpJY1VBQ3ox?=
 =?utf-8?B?Y0d3bWYzK3NEZU5ISTdrUGN4S0Jrb0hWM1UxUkRROTRzZXlwbDFQQzZlWW1H?=
 =?utf-8?B?aktRb2F1MGpFN1VXVmlNSllwWXBMTUZPN05ZZk1QR1NJeFVvb1laMnFFRkZs?=
 =?utf-8?B?cmZhZ3JLRHBWS0RzNmw1QzRvaEtiQ1BDSFRxa0kxbU5nMS90c0Z3KzZhOFlJ?=
 =?utf-8?B?djZzRXpPSGN5TlVrMVNaMHg0eWZrM3dLUUR1dVBoNlpjN1Y2MnNYS1c1R00r?=
 =?utf-8?B?Z1h4VUVYRmJ0d3phNWg1dlByWnBhSGhLMmFaaHZBT1h2dzFuQ2ZZYjhtRlVn?=
 =?utf-8?B?NUxBZm1HWVVoVFArNTVkUlpueXp4RnhrVjlhdU11VmZpT3FENXA1bUVET2Fi?=
 =?utf-8?B?c0JBVUpWbEs0bDFtWkVlbndXd1piQW5VL1pjb3RmSzNjdzY4S1dUNWpob0hD?=
 =?utf-8?B?SmZUNmpUNTZET1JkRWp3MXdqZjgzUXlrQmpnNXVlSk13K1BDaHZiZTk3aCtI?=
 =?utf-8?B?b0NPL2RVdlQyU01HR3piUi8wN283V3hKdmtmUnhLUW5XS1IvTURGd0kwYXBq?=
 =?utf-8?B?TmtvWGJJekwwcjhPTU5CNzRaVk1ESmdxeHdGNHZSNDI4RGN4WS85SXlycXoy?=
 =?utf-8?B?bDZjUVlOeEpXZ0lodkwzY3hYSzFBellBdmt2TFJGWGMzU3UyM1lhUUdnSHhE?=
 =?utf-8?B?RlZRQlBndE5ySnlzUUVLMC9oamNDelk4ZDh5bVNIcU00NEtqckNPWDBabDBE?=
 =?utf-8?B?VFFGdDV5MFB3b2Q1dGRsVnp6aityRWRkbTJLVjZXd2hZVGJWSWlHb1ZYSk5n?=
 =?utf-8?B?UUh1WDlKQTNtaDdpUUZxYUJXdzFMZnJrakZEUlNLWTQwYzYyNDlncDhteXBN?=
 =?utf-8?B?OEQ3bHBsWHNJTXo2cXNpYTd1QWhSWjJvY3BzYmxFWmRhSmk1azRzMmlnOVVY?=
 =?utf-8?B?WmxtR2ZtdVM1SzFaTjBacHpBSUwvRnhycW1QTElxL2xVY1NPUHF2UjR5eTEx?=
 =?utf-8?Q?fbP/DNxm?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZnOGVqcVBHam9MQk5JSkl6SFloL01KQlh1MnFnd093cUZZbUNwekw1bVcy?=
 =?utf-8?B?WjhLVkMrdUxYRDR0K3pRQ1lHUTMvTjJPVDlMTC9TejVtVFJJT0ttN2V6NlNp?=
 =?utf-8?B?eGdXQ2wxV2Z0SnIzWnFVSUN6RFcwSGxkV0Rxelp2b09kR2VHNnp2QjV5bzVH?=
 =?utf-8?B?WmpoSmZpbkt0dXFYQ2doRWpZNGd1OFhjMEozWEh2OTdXYXJOVTNsdlBJT2Yx?=
 =?utf-8?B?YjNocEFWek1FZUg3ckpoNnl0NGtMSUJBOGlQdWMwVHZPODQ4SDUwKzYvUzZa?=
 =?utf-8?B?RGYwMmN6VEVSNTdkQ1UvNkZwRVFtam5NUktydUZTRC9xbmxTdDVmaFkvOG5C?=
 =?utf-8?B?eG1ud2tCVEMzNUZ3T2psKy9KWDNJN2dLVktPZnQvMWZhWmhDd243M20vVks1?=
 =?utf-8?B?a0dVYW45OTRQRXYrUUM5aEx5d0s1RUhreHlOTkYrUWgvU09HS0VydGRrRFhr?=
 =?utf-8?B?bWFQVm1PMkx4RGlDaWNpSXJXNGNadjE5V3BUZUhPdldMdWpCRFRpUENzazA0?=
 =?utf-8?B?M0RhRGlVZEM5M0UxWGpzL2xBOVdGMDZoNE1GRGpFYzFKcVhoQkxtZFRRaXRP?=
 =?utf-8?B?NERsNGJ1aS9GNXYya0pnZTkxYzFBdTg0Wi8xZjVIMnJka0tQSVNpS3ptVGtF?=
 =?utf-8?B?YlpRelNqU05ONDVHSGExT05nRE5mcUxYcEtZRlJKUFp3NU5LYWZDQm9sRVhj?=
 =?utf-8?B?V1B2K0IxMDNqdmhjVkVPYTVmOTd3cmQreUEvMDVwR1FRTWZGdFhSRW1NVjRF?=
 =?utf-8?B?VGluaCtuUFNsQU1tMVhRcWg2c2tBeHl0QUtyRjl6dmpydGU2dXh4S29sRWNn?=
 =?utf-8?B?SmtYcDh2R1Y5NGo1YnlRdmFyUndOelFTaDMzaGdza3hYM0U4S0dFcVoxY3dz?=
 =?utf-8?B?Q1ZKK095VitIYXpTc2Zad0pKcFM0S255ejdoRkxCbU51dENHYWdKK2pqNEt2?=
 =?utf-8?B?dG9WcHcwUXdvVUpjMmlBcHFSRkNwMkY0YzJ2R0F0aXh6WXd2bnRRUEhhdzJR?=
 =?utf-8?B?SWk3VWV4ZmYyS2ZMQW5yajlUaityQ2Q3VjRFMWtJR2RvVWdJbjROczNvTFZG?=
 =?utf-8?B?T1p0VWIrSVJybldJUnFMZDdNTjlqNnBPZi9OclJVR2UzVlBDUWNaeUVVdUxH?=
 =?utf-8?B?ZnhDT0FpMlBidDVkdWxGZnQ3R3JXK3JEanNPT1llT05LMmRNVUxpanJrTHFm?=
 =?utf-8?B?YnJyL1ZiNEVUelZPdVNLNVlPMFhMeEJqbGV4c0dyV3VseDBFbTFGSXhIKyto?=
 =?utf-8?B?aTVMVzc2MStHMVNhS0ptWnRudnRkR1h3LzN0dC9yZlVXRFdqZXJkVS9PYThR?=
 =?utf-8?B?Z3ZjZzZiNXdIM25BUXBkWHpSQXgwbU56eW9ydzl0VnBCOGlMUmE0bEZ5MnZQ?=
 =?utf-8?B?QW5mRUxDd2RQNkRTMW1URXdtbUFrb2U4b0xmcDExMEJLWkFJWXlyRm9teTJ4?=
 =?utf-8?B?OHVXNCsvUDAxN1VkUUZCaGZwNkRzR2hQRWZNcm5XZUhpTFNSMnZ3eXo3R2JL?=
 =?utf-8?B?NnNOc1l2YlYzdGExWFhnSU5sTHUrWm53QXpwV3NHYStETzJnMkk3RkZobGNL?=
 =?utf-8?B?Mk53Y3FYUzVPZFVhV0hZdkYvWjJLdFc2ZHZVNXBZdkFGZVZQOXZUN2JDdEw5?=
 =?utf-8?B?VzVoVTdyeXBLMEt1YkhmR3BFcTk0djdjZ2tiemR2bExxSlQyWkppQ0hGUEdT?=
 =?utf-8?B?cjF4cjVqTURNalJOc25mVnVFNExxZHFxNVNKaWwwVVRjcGFvWkIzeGpqZ3RF?=
 =?utf-8?B?eSs5S01MdmRDdjR1TlF0NHJ5bEs0RFM1T2ZEUlUxdWc0QWlNTlZJOVFQN1dw?=
 =?utf-8?B?RDZaeUVtTS84cWd2YkZoaHRFOW5BbDMwQmlRVEx5WGJkZHpNWXlrVGRqaHZC?=
 =?utf-8?Q?zmw1lWE6bFCSX?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf234b8-0615-4d6e-21c8-08deae05cba0
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 20:01:45.0517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP194MB1161
X-Mailman-Approved-At: Sun, 10 May 2026 03:41:44 +0200
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

portname consists of dev->parent->name ("icssg0-eth",
"icssg1-eth", or "ethernet") and dev->name is the port node
name ("port@0" or "port@1").  Every board DTS in the repository
produces a string that overflows the buffer:

"icssg1-eth-port@0"  17 chars + NUL = 18 bytes  (AM642 EVM, IoT2050)
"ethernet-port@0"    15 chars + NUL = 16 bytes  (SR-SOM, phyboard)

This commits increases portname to 64 bytes and replaces sprintf
by snprintf so that any future DT node name cannot overflow it
regardless of length.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/net/ti/icssg_prueth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
index 12a162b9d68..4796d0d67cd 100644
--- a/drivers/net/ti/icssg_prueth.c
+++ b/drivers/net/ti/icssg_prueth.c
@@ -496,14 +496,15 @@ static int prueth_port_probe(struct udevice *dev)
 {
 	struct prueth_priv *priv = dev_get_priv(dev);
 	struct prueth *prueth;
-	char portname[15];
+	char portname[64];
 	int ret;
 
 	priv->dev = dev;
 	prueth = dev_get_priv(dev->parent);
 	priv->prueth = prueth;
 
-	sprintf(portname, "%s-%s", dev->parent->name, dev->name);
+	snprintf(portname, sizeof(portname), "%s-%s", dev->parent->name, dev->name);
+	portname[sizeof(portname) - 1] = '\0';
 
 	device_set_name(dev, portname);
 
-- 
2.43.0

