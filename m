Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80A4E9B37C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF3083F75;
	Mon,  2 Mar 2026 14:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eqmtnGcc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F4E83F14; Mon,  2 Mar 2026 07:41:13 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C191283D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAe84ID75FgFfFad5yzEZFfNkfA1rSxXelsljjfO07gFYHmc1qtPzNDeDslrMKoK0iJHSbZ2x6pZ9XyeUVnFKYGjPbaksJnBM9nXkrTQaVonrRC7th8zyymRidxFszFOg72F0h1h44NFr/6NFC40trjt1r3LtvOM/h0rJxOWEusmRcyDaGBjDChDLSHXeOz0BQUCRQgxb0N8ixJJyxDJZzoPXMThfqMrXiPrcL9NDU++i6GU84W2u0cH/PPtXMw9rElO9Ws8EmyHW4se2VESnjS11RTFZgSEJHejdxY5zq6+plDIqj5dJw2uInE4Uv6fQRqp/zRf4LFDrGQ07M888A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3UsWtWrOHe/l1u6MtbjAdeUmVbJMHhz2M4nhJYmG2g=;
 b=zQZF0PE4Wh9/JSzHE0U9ZGTQMoNRIdVRtV6F2OwFmfbLb+iMHTZijFEPaqVX+r4c5/I4So1DHBby4RJXELEg79dST7uv7dw05yXARQ2BCwKPcMOpAiUlrCfTvTZApfH1CQ8BE3OLDyyq2sngQtHSrQYJdy7ylrXbCrMLFqyei3GtKXExfUm3tw8qDRFuI/b9hGw4EiCFSoaAK5QeuKsIiA4n49+XjKP7yE9HMBheo7zQsg4XAlGXVEvJ6rkwmyC2VdIUxfs/4wgf0EE7ZWtMJkNslrr5RDgLUG9QIa05qlYczqmJU+p16yLLuC2sZwQFvUtUgXIj8xz49OooHgeB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3UsWtWrOHe/l1u6MtbjAdeUmVbJMHhz2M4nhJYmG2g=;
 b=eqmtnGccAb2Sdw+7vRJeut9Cf/NiJPH8HCF/gRM/h0aOtqgABtdbXv3R6JGqSqQU1diWUqj4GyDsiiaRAx6c4XhWUaMR6h3zDDZkmtpN2huSaR5Z3HGO7vQ+b46fbbrbeTdrODcIzWHWxgalwKDkdU5By+v85XmCO32I6kf1LUweNhg848d4bsFmTfpFfZqG+ps+SIasSlOQV0QbseGPhdwj/MUd7DWxYqe4iuboHN9poZS2Dqyk0Lt7bvPnNHS36SWjf93Dg7D2LGNd21r8gMJKV5qSvgxVDAG0TptPSnyzAqJY53R6FOeZPhLQZW8BZFj1hSOV3giDez73VdyDCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:41:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:41:08 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:07 +0800
Subject: [PATCH v3 06/13] imx: container: Add i.MX952 support to
 get_imageset_end()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-6-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: 13089b65-fea4-436e-695b-08de7826afb4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: LgPJvpA/sG5iNZrdc6/zFobguY6xkVcv9W2Fw7Jxadb/RvjJcUxOKGan+FDACEFTWSMgOnrmdR4RmGYjnQJjjDAv24Uqzy0QTtBcJFVyWcxeVl1Rnsat3qw7Zwe8gpTkJVy4uZ/9UEUBmAlg4e8OJ/Z35zVVKJdkDtYO6IXDa3Nrorjm4lP8SqJfFOPDtdLd5QyY4MQjJuNBVtQh6vN6X8k1N5CxBzAFyCdlBUCMkHLGm2NeB+d7gOqS5/zyR+lkxIsOxU/gTJR3qcF2PtRI59IGOdl1+yjsUYU+WDrY7B+2tnqAw8tfk+sp5PWNlS3MYJkrQEbv29LK95jf55JXnb9ovEVqjma+mVocFpTbsW5txwaAYPAdhQFTnwLYWtjgPcwK4vTMJG90h+yYrHtis54+DCRwOL337PsiWIn4fQW1r8luw1gjX6Zk6iLQa6pgm+RI1aPt1/s2Kyxiz9NGOa30mZ23bZj98nHHETKNXsI7/5EbzGHbhhYT8eSaKOmTOL85Ntlwc2Z561+h763v0aiqNym4+iPcvRfPaHLLphYRVM1abwHdOm5/gRNiHMoEDChea+z6TPLEVccujz+sD0S4EWhI5byozEeVSxroe6vE2fNKio7uXphN2Q9+Iuy0sYTnyYT5BraXR/Ni4mUe3twzY7WhO0+HmOt1v1WrG8kBu8Ya6JA3x3BHfsZekk5HiovZDDeQ2cN9kqNQ0FbVkTpTW/gMW81tjoSDrxUSpkQqOsd7sEFuuCwwNsrGtCsMP1JDM7c6Y+/fxKUqo5ji0TOjfNxQsd5r6i0YrGjffVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJ5NVVpM3JhRkthVHBXeFhGMktxb2RNNWRWdzhseHhjWWgweDE3Y0szQzlI?=
 =?utf-8?B?NXlzRlY5QnBwVmI3YW94dmlBVEM0VGdPcWpUaEJKc2VYd2hyQmZ2bGNvQlpo?=
 =?utf-8?B?WEVqL3FoUFRrWmhQMTFscUg1YXM4dUtrOEc4c1hQdUFOV0VJR2o1b3RZMEQz?=
 =?utf-8?B?UzV3YVNwTmF4SEN4UXZSQUt1K2pxTDVUTTJwYThCTm1uU2N4a3llL1JKQXNY?=
 =?utf-8?B?RGgwcDN6UFRLT0pHekN6di9rUDE5REVoK1h0K3IwLzRsaE13MHJESzA4M0ll?=
 =?utf-8?B?TU5yaDM2K0RLc1FLVXdmT1BHcjkwTXRoc1Z2dFBkYm1Yc3cyRDJuN2JiRkRw?=
 =?utf-8?B?ZnVtZ2pZTGtReVdWRnpyVjI2dHJJdnFtZUh5T2ErRDRVNXdtZDdPYXAvSVBl?=
 =?utf-8?B?M0pBTDR6b0YvVlhhQzE1NEdTaUpqTURWTDg5RUFlckJteDc4eG5WNk9RT0Vo?=
 =?utf-8?B?Kzh6RkJ6VEpaTWdoS2FydTFoSDdkRCtmblFnZWRHODE4cXdRVzdNRjMwbGpk?=
 =?utf-8?B?Zi94aVFuRjEydTRpbzJoK1loRm5jb0FmTGRoeDFaVUJaRDc3QUJPRHpDK1kr?=
 =?utf-8?B?MHhCMTNNVGFDVTV2TWlpbmJnOGhHMlVVK1R1Znl0TjYrRDZxZ2pCbVZGL2lP?=
 =?utf-8?B?eUtkVXZjWHZjSWF2dXk2WURBT1VLS1I3N204REdaZzROYjUzYndSVXIyVmUy?=
 =?utf-8?B?M2FxTjZ1Q2dOMVhrbzF0WDBSNm5jYVkzYTNjQmxYVkcxSUJSS0pLZzNEWFhC?=
 =?utf-8?B?bTBrcEN2NXRRTS9tZEpvbllWeDdUaE1obnJ0NCt2dmNxZnlHMHRnOHJibUp4?=
 =?utf-8?B?VzltMXViY0t1WFpIS3p2MVFWMGR4SXQwcGFzZU5CcG5EL2ZjU3kvYlpOd0Zk?=
 =?utf-8?B?UXdkY3JpM3dnbTBIVGVPZG95V1YyRzRsamZQckhOeWtIdUpQOTZkTDZTUitq?=
 =?utf-8?B?R2FUVWRZR05qUVRYV0Zyb2VJbndkUVRBWWUydVNCOXdkaDIwQkZmK0tMWmtI?=
 =?utf-8?B?bUlXR3E3RkJ3OEJrdVdIeURiZ1lpMlZKSVQrY29UTUJaVW1ORjRpZUx3dWZj?=
 =?utf-8?B?WjAwbVFhSDlmcjlyNzBnTTB3QXczL1FwTjlXU3ZBaCtpZDJNRTVQNmY4SGlU?=
 =?utf-8?B?OFVBS0dVK01Fd09pSmFFM2RTTkc0eEdQMXVsUE8xVE1VWXhHemRVYy9ZL0Nj?=
 =?utf-8?B?MXhiTm1HbTFRbHNaM1dhSzQ0eHdUOHpaemZMWnI1MEhTL2I5RURuQXovemNE?=
 =?utf-8?B?bzZlQURoMXB1MDdBdTEzVmFqbEZxMXRUTURVSHdhdFBBaWZxREw0S3l4dkRF?=
 =?utf-8?B?RStPQU5nbzd3REpSVlZlcis2d2NVQnE5QlZvOWNmdmVrSzk4TGhJL2tSN2Vi?=
 =?utf-8?B?Q29TRldjUGttTVhiQ1UxNCtRUzM4eWd5a2dlUk5xV2lob0ZKLzlZd0swazdC?=
 =?utf-8?B?SmJKUXZxZC9QVFVyQzdjL3l1OG1sS0VkckRwY0RieitzMUZUTVZKWkpvQ3dV?=
 =?utf-8?B?RDhEMDRnVGdRUEtUNTU1Z3labktJL3ZPSWpBS2xBZm5EYXlBblErYllYczIr?=
 =?utf-8?B?anlFU3RqaGhuZ1VneHQwVE5TYUxIbjcrdldpV0lCcGFFTXlBMTdVUkpCSnZi?=
 =?utf-8?B?dVBtZHJLSG81SmNNT3FIa1VuUEx6RUhGRG95VlJwcHRrTmpBT1hVQTRpdjlq?=
 =?utf-8?B?Tkd4aVJ5SkFzYnRoNzlQVzJZRVlpQmdUdERkYXp4Unh0OGhJMm8vVysvT0RT?=
 =?utf-8?B?R3orWTM1TkJBOHY1eCt0ZHBOQ2xEYUxyNUpjQVd3ZUwvUE5LMnVzeHRlazNo?=
 =?utf-8?B?OXJPclREelNmbmM0dzl3dGtMcGhiNWpGeWxxZUFpUkZtMjJIMW1YYnRkOEFS?=
 =?utf-8?B?WXlJc1NibzVETkxwQ1pRcU5wRDVrdWdPeldGYktIeGRQa2RvZEdiYW9NSllD?=
 =?utf-8?B?dE1uSGI4WTlrNkVnOTkxeXZHbHJXaVBSczBVeUo1UDNIZDdYdC83d1ZFZXNw?=
 =?utf-8?B?QWJDUitaKzA3WUhnTktwb1JFUU1pTUJHTHcwdmM4TFZrdis2RDhoL1E5c043?=
 =?utf-8?B?N2s0M3c4UzF3NlFoMnI1MGNmWVNNZ3p2N1VRcHZ0WWFzdUYzUlNOYlFLaGFX?=
 =?utf-8?B?TVRRMk1RZ3JiUFdpbTY0K1Z0RFJQQkZ0dTRjT2RhcXE5eXE5Y1FwRnFXa1Uw?=
 =?utf-8?B?WHQ0SnowZG8vcXBkaXhkWnQvUzVoN0x2K3RxMERsa0x6b09yeFN5aDlUeUkr?=
 =?utf-8?B?SDM3MkFuczEzQU9ZQzlJOHN1RUR1VHFEQnRjd2FGbXpwaEl1UC9kYkIvNmJ4?=
 =?utf-8?B?cnBIMHZvK0cxNVJNaTM4UGl3K1RHc0lxajZNSXVrQURlTnovTmc2dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13089b65-fea4-436e-695b-08de7826afb4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:41:08.7618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJ283peb46XfMvxZSuur9VAm6rXCkbPyeQJigEbYbz/Z0GivIWlaHhxAF6BRfedFJxd1esd/MFFxeDyYt6e9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

Extend get_imageset_end() to handle i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 78f2488cf6d..7bfcc9d7e9d 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -297,7 +297,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	if (is_imx95() || is_imx94()) {
+	if (is_imx95() || is_imx94() || is_imx952()) {
 		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 
 		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
@@ -321,7 +321,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
 	if (value_container[2] < 0) {
 		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
-		if (is_imx95() || is_imx94())
+		if (is_imx95() || is_imx94() || is_imx952())
 			return value_container[1] + offset[1]; /* return seco + v2x container total size */
 		else
 			return value_container[0] + offset[0]; /* return seco container total size */

-- 
2.43.0

