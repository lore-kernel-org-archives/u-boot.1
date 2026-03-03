Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F71EB3655
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 02:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD24883F6D;
	Tue,  3 Mar 2026 03:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yFImo0FP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8C483F2D; Tue,  3 Mar 2026 03:30:52 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439E383F6D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 03:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8bWmUvoWD5u+0InZkx32TVXtwmkGDHO+0GSrhgwvgFq/CdRymqFS2FGUskHgaT6VuPuvtce86ixt/FrwB6taeoNoB9gYA1GsWKs4ZhUq+BpDQWzCZJMlFJ2Ypa/tEnvcA7uUfhz5xy0sulq+sS/MrfwglT6Q2JxksB2Iiwwu8yXhJpb2/aUBtQ5hPieghncpS1t8oAJP57ooBlUvWJcitoMGkBRCU/a8DO94rGQG4OKfajSwAFtzt37T4yR5NEcZCOaSccagYPDcV2vPIre3I7CNkdeXsNeDmUzXltX1b2v4U3ffm0npvUs2r3p/XMWIW6wuzrZffXePl6IeEYeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd9uzUcU+4pVnEZl9Poac5zQ3rtQFTvctlUWmMkMP0Q=;
 b=RjfD6abCSC//Plf7fCyCd7P0XDQT3VLDYLp6abEAvOkIcsXhFnRkqP9VSHuTWfIgOaXpqDnDwM3SvZywwe1NN65R3AFJsmn+k3elaFFsUISP9tE28I5WLB30enfUPm+NM06edY6d0eHOeZ2NzK1yPjiuQoOtWIHpwYEWRrUdsT5HmgA/fIbADJtEaOZurVX6uUHA62P7LxivjfBDzNnwU8mHFXoW8+wNutsVcQGJzBkCb3PK2BsnoYprneC4X18EzoZXocJhrfowRgfwX3CZblCwPQnDvl6LkvAVO+pKLCkpti93lrQ9f8EKltT9mBTy9maDknfkCS4X6RMrISk02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd9uzUcU+4pVnEZl9Poac5zQ3rtQFTvctlUWmMkMP0Q=;
 b=yFImo0FPHeul5QSHZd0ifyF6jGvampxc+OmlrtPHly8qhbJ+tCWPv3On2vwN2sNqgi1fWAnQ2Oak9QL1b0a9JrN7KMrr8KRk1mBOWYwjLGG2HfmWE7dMJ/PxebQ81nyACenZduEBJ9mB/VTSgtnpDvKilkeTN5pM00Ajxbxbj/uZ69mSoXAcq9Z7M8ar0p9HwmH6OzRYf5NYfbP7P1lksCDQRtjQZZXv608zflOlS+lR/0FwZOKNQui+N4nvasOA6o0MB11hz6uGsk8S/z8u0KhILvR4gY9l5yUNeZ1+XuQsScJ54Ku2ABFuZl9wjQW9VDwH30V600XeAEjkG8IZNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 02:30:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 02:30:47 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 03 Mar 2026 09:10:27 +0800
Subject: [PATCH v3 2/4] misc: ele_api: Add support for XSPI SET GMID
 command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-xspi-v1-2-8383ba6fdda8@nxp.com>
References: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
In-Reply-To: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: ced34c75-dbbf-4ecf-abf2-08de78cce07e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: e39VDO8qFD58jSzIjxncCsmbYxhC8Ai/BB4BZTCP2IFW5Ta8BIDy/a1YcBSlb+aDP3b5nUKbvFnlrpnHFqSHn7KOSuzWw6+bOUkiSsCq+5/SK6VATVxBXwbDn/q6fwjtQiXpMY323wwlnM/exTz1H44wKD7U3yqSaqSX5xJJSIA14250wnALD2EdQMh+SFfOE88pJb1bdOO3uYH2AWtSw9vdQBM+LzJIComGrP4ohGGd1I58yZa2Cx3o65hG+D5Gk0kEtboZqwwH4vDLrqTGzxDkX+0bgL1JGFaQgCs/W5xlYyqrvLSbztT35vIBn/XXS/EWMQoL3eRn6KlUH3CMhuwLnzfU/hHG/Sy7gptb75F62yWCJZ4dvkRmX4jOXeY4z+OYhkMt86CvIIEIHrNIjHp/FHkIjPhdvspStm6tdk2jPVShuvA62qvUuueQAvtq2JK21F8j8rV3DJZT8tgGKPT47XJGxysr/TVsNbbok7X1AKHBkaRLokzRCOkWd0/oy57MFLniLaZiNYGUhRqThKNy2VEKR7YouuWVzXL5NEUgvheI56jAMvcfKQ5s4XuDnkpFOgcMCH3nJfO7ASKLhgC9Wou5sR11OuNO46WYxdnnQiLk2FgFNEmpLQpnz9ouCFTyiYmT45lFrSNfzq9nesk9djJxEMQD9VEGUst0dr9K2Q5O0tzhuREBW2YNGB9mq5H/kV2CdoUNKmXvvyZGNwHIvroEGTvhYbBKx03TBO7KOnFDDY+20v9Zpi+bZhZ0I6+jUgbZF3BogIPkZq6HxSOwoIFtcmNE0ycyFi5C480=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVYyRWZCVHhxR2FLMWg1VlNOaWdzRTc0UjZHb0JINUJ2ZlhrYWt4d24vR3RV?=
 =?utf-8?B?VE95aGRkU0xXWDRPUUhSSXhwbnBibEx0bnNWRGNpbDFUSUg0a1dmdGNMamdv?=
 =?utf-8?B?MkZCQmtNTHBxaHJ5ZlN0SjRWQjlLY1p1N0wyM1ordFVDNzJJS2ZOUjI4aHJO?=
 =?utf-8?B?RjlXS2tWZXFEaEFNUW1uWFBlSUdOYXVyajYxU3pVSEJBNCtpM3RGRTRjMlUz?=
 =?utf-8?B?ODhGSDhxUnVuU3E4d0IzTGxHNHJLZkhQV0h1OHNWSUowOE9RQTVlVkVRUXlK?=
 =?utf-8?B?dFBwcnY4eCt6TDVlSUE1WGx1c1BoekV1MU1lNmkxR3ZReFlqTjJrRVk0a3Ba?=
 =?utf-8?B?UGxSVkdmUDZZSjdxRFFRdkE4SzJhbFZld1F3aVZvSmM0Mkp2aC9pS25Qbi83?=
 =?utf-8?B?SXhhck5mcE9uR1ZYblBOUGxoZVk4bTBPOVE4NVd2cUx1SjArM0s1bU9aTUpQ?=
 =?utf-8?B?Z2hWdm0wT1BIWUFLOVBYZXNSZ0xLSEM4NzR0WWE4YjNvam1GQlo1OG5aNjRE?=
 =?utf-8?B?OFM5UENSYk1iTTlJUSt2QktmNEZGb1BCVzRxbndPdUROQmtZbWNXOXQ3SVps?=
 =?utf-8?B?L0hGZ0ZIZU5kdUdCaUUzc0VNT1RRT0UyTE9CWlhtOWlON0N5ZllPT3grekF1?=
 =?utf-8?B?N2JLS0p6d0x1cEZTaE0ydFdOQUxrNm5KQlBFM08xMThMWTh3VVB0VHVIRzUx?=
 =?utf-8?B?WDFEb0VHSVl5VThvOU1lZzlYdXRmcUgwSHF5L0IvOGgvMVJRV0EremdTazVR?=
 =?utf-8?B?bGpmNm53Q2VsVmdTd00rM01NcWdmekVaVDFMNXdLUytHQ2hUYldWU0ZldGpq?=
 =?utf-8?B?eFFITUx6TWtTZnpHSjdlV2NTTGtOUkVwQXlmdk1xV1U1YnYzNjRycXJrbEgv?=
 =?utf-8?B?bHZ0NVlsVWUyRUtBTE96Nmo1UVhhY01rbDRFZSt6LzMrWnljRlBETkJGYzM5?=
 =?utf-8?B?UXczQVVkS0lYazdwZStkUjhiYkkxY2ZWZHBaaHhtMkpEbTNiN2h0MzF4T2NG?=
 =?utf-8?B?UjU3dU91R0dvRUJ2b0t5VzFpSXZFc1pCcFBQMGVSTkxlLzVvVEFCaWtXR3c1?=
 =?utf-8?B?Um9UY0NBUEUwZHdPTU9Cb1VLNlRZVnR1ZmNnMjdhcWNhVmRCdG9tRnVLaXJl?=
 =?utf-8?B?c2hiaVdGWExFdmg3SEtXcjkyMFlMTThGQWJCVW5hMnBoaGczMnRNYTh6OEtN?=
 =?utf-8?B?U1FQOEpTYnhiZFYyYWV0cXBLN2hmZWFqaWcrS3lMUWhubXJJUk50cVo5Rjc3?=
 =?utf-8?B?dC94Mlc4QlhXWXVtVzM5cW52Z1lLc0Z6Wm5mQUJkekhJVUxBTHpQaTlZdnpL?=
 =?utf-8?B?S3MrbGFpZVFDUlk1MnczZG5lQUJEMTE2RFFhR21tWGRJTG9KYlY1a3RZaERy?=
 =?utf-8?B?VEJ2YzMzMUZFYlJiZ3didzlJeTVHbmJ4WSt4ZkZ5WDAwN1ZHc0dSeTZ6b0lx?=
 =?utf-8?B?RU1maWVVQk9VZ2kvei82NVMyOENDYzhKczVBalM5QnlwYlZpZ2t4MU0zS2g1?=
 =?utf-8?B?aTJFenFOSTVBVFZ2bmlQZEkwMmFyNE52RWhtZDFhSWFoVVBYOWxZemY0Zysy?=
 =?utf-8?B?d1BvbmpXcXBhaXBRbVl6NUVvaDNsbjluQnZoRU85SlozT2hxUmNVeEwxOVg1?=
 =?utf-8?B?U2hPbUx1cUcxWm04VnpOQkNVUkVBMTAwa1JMVDVwSmR6by94TXJWc3BucDY4?=
 =?utf-8?B?NVlNaWk1MFRLMUFEQ2kwTzFUY21ES0hMN0duaVhaUU9QemVCcENZQzhzMEhy?=
 =?utf-8?B?eEVZU3FuSldKZzNqd0JyK0wxVFE0UXhvcGlaUVFjT08xTitLR3VoUVhIR25t?=
 =?utf-8?B?dSs4Mng1Mkhldm9xemZPT3ZVZmlYbnBScTV4cjk5SkVlcVJXRGJ0K2R4NGZk?=
 =?utf-8?B?NCtqZDVoUDVxaVpKL1ZqUmNPKzZCVGp5RmFJWktNRUJETk5va2d6RzA5amNr?=
 =?utf-8?B?V0RmYUp1dVEySEZ6WTJqMCsyVU50TndjVnhObUwzQmxyMGcxdFJPNmdRcGhK?=
 =?utf-8?B?U1dJMC9jQWZQZjRETk0xVzh6UUlueEhNZjdieEVDNUhURFIxdTRyenRxa0tz?=
 =?utf-8?B?TjZXUmxNYXVybXVpam9RT1dTVXNuK2hUUE9YMUlVNWkvWFhGUVo5UEQvNFk0?=
 =?utf-8?B?Q2ZLQ0loRVQ5N3A2eEtmbTBuVGE4ZTRCVU5TYVBZWnZMaHVDMlpFOHVTYmlm?=
 =?utf-8?B?Q3ZPZ3JKT2UveGd4Y3d5aUhIT0F5c2RCQmkwd0daZWxta2hHRlhNWHhldGl6?=
 =?utf-8?B?cmFmd2RLbk92QUNLdHo2MllLVnM4OHRhdEhIL1E2a0JpdStTcTV5b2YyOHht?=
 =?utf-8?B?WmhaMk5GV0thR05VcWdsaDk0THA1cW9oVTl4MUh0MStlcTFLN0xrQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced34c75-dbbf-4ecf-abf2-08de78cce07e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 02:30:46.9305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYAw6f6zoDpm5zyB5U9JWcRb0IethAKA7/bitkfFnBPNRnUbFWO0obHr8zF0ulNBHC9ea7/wOdYvaKLM4XkSWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
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

The XSPI SET GMID command is used to assign GMID ownership to the
requester, allowing access to protected XSPI control registers. This API
must be called in SPL if XSPI GMID-protected settings need to be
modified. Otherwise, XSPI configuration depends on the previous GMID
owner to provide the correct settings.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  2 ++
 drivers/misc/imx_ele/ele_api.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index 4e1afc42bd8..04e7f20a2a6 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -49,6 +49,7 @@
 #define ELE_ATTEST_REQ (0xDB)
 #define ELE_RELEASE_PATCH_REQ (0xDC)
 #define ELE_OTP_SEQ_SWITH_REQ (0xDD)
+#define ELE_SET_GMID_REQ (0xE4)
 #define ELE_WRITE_SHADOW_REQ (0xF2)
 #define ELE_READ_SHADOW_REQ (0xF3)
 
@@ -162,6 +163,7 @@ int ele_return_lifecycle_update(ulong signed_msg_blk, u32 *response);
 int ele_start_rng(void);
 int ele_write_shadow_fuse(u32 fuse_id, u32 fuse_val, u32 *response);
 int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response);
+int ele_set_gmid(u32 *response);
 int ele_volt_change_start_req(void);
 int ele_volt_change_finish_req(void);
 #endif
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index e7aee0fcef1..8ee0a7733ca 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -844,3 +844,31 @@ int ele_volt_change_finish_req(void)
 
 	return ret;
 }
+
+int ele_set_gmid(u32 *response)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg = {};
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 1;
+	msg.command = ELE_SET_GMID_REQ;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+
+	if (response)
+		*response = msg.data[0];
+
+	return ret;
+}

-- 
2.43.0

