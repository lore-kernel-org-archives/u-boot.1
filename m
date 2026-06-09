Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5923ECD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64878488A;
	Tue,  9 Jun 2026 09:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ee5q0KUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524E5848B0; Tue,  9 Jun 2026 09:19:35 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 268F08484F
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH+4iFzk3B0t+AOkEQ1COoQS9AcrO5lrLpMVzEkTTA9BJcUJTe6aIZthvTCAEfDwnjxH1pKRUoyeHQaK0eITYEjIAjCkuBFhrVDLropQnUUgwGF33BxVwgoNhhDCl4tlsJswLff7Ld6IZRJKMaS8ndnRDjAfboH4Xgc0vFSuIGw5Gi2DkB1pH33iffYgrbIGeAU+prm2xT0QUS/pt5hsMmLzjrq1vGCIVEJ0klDiD3WJpTOhma7bZmVe+PCfnmm0mlscWomMNiS89TZnYwwOgI2BYpzjDxAv+1YW18wskn7NOHRf9JXHT3auIVnGkWbHLdWbxfMpgz/S/hY12kvUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u4S677UmCTaSvEEUQ0+KhOwxrfvD62BpCJQp550lV4=;
 b=RTGXomaRXhxZM38MEcmphjaqmifHKwuQ1mDchfUbsj8UuT4pQ2dKxwhfKj/UfG5cObg8B40nvN0T94jSTRqQupM6u+gfzT3SpQyisv0vjmQzZg7XN5M8wjr9Ri0Wd1D+Dw33kW/+re5r8/SQyBfFfRSxsOCBx7Kuc6TTjZxd0XNL5SqpNM9zt+pyD3H1Ge0cMUpMWy/2kwC9t/XVYNp5ZhYfkOfFIXo/lZTzQXZJOjLJFapdK2UPqubFcBoATWjocezPG9T+tfHQQKad/dX1SaBSbxuiQD2flrShJpvJMa+p4LkwMDXxalKQ5sow6dIMpGJyg6PYi1HB0JhK1zDcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u4S677UmCTaSvEEUQ0+KhOwxrfvD62BpCJQp550lV4=;
 b=Ee5q0KUB8MPVjKvGwK42VTOu5cAYDvvHk64DriI323dfUlwZRzfOZPpa7B0o0TiwWwZRQ5H7lMo0C9HBHKw1fKHmBl+GL1kjcDNnUqu3YX02tzelVH0HlYOdArP/LFDN3xxpjMH7mnLcUKE3RW46Gmmwk/xFdarm5kW2dKB/0aXyI269OzunHsYA5t5sQKcWciTXdpxywV/Xi5O12CxoP0P/GhmhBNo8JrdaSMizw9twcc/+hYAvxzk0oVvfHWUnEF5mya1GOy8EImB6DErQcBsXWPLdO68IEgjWXSeIkB1UWgXVQn/J0d5RBeKTcRarzjEY0w9+xZF7uIQ6TtUe7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB11546.eurprd04.prod.outlook.com (2603:10a6:800:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:31 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:26 +0800
Subject: [PATCH v2 09/13] gpio: imx_rgpio2p: Use dev_read_addr_index
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-9-58e1665d55ae@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4e2f86ed-ede5-47f5-48e1-08dec5f77344
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cVDyo1FJ+vNaC2Iv4+Svareqy9GQGxmTteIKnkShSxrBeTwYLhcgn5vDVtJo/fOJ5sUwf17b82qNLzKVKzI0SS9n0cYq8eGJTkrTEY9rwbYrLts/mfw+34eU2lLCOTTY8DJFBDzK1MPLDpJwAt/ZgWqtaL6efs78K/HFZz8p6MtOQE/KfbpNJnbqXp7GV/X77X0Ug34zektsejCQ2HeURobzMFPJ5kzYgVGs1L98eM3Z27LyTzFFbSyuipQ4GWDy/E65LaEZD+asTXnExxtQ99+8cwv3Z0jxxJyvbzA7Yz1WkkoFktpikg6zJxJfi0CEVtL9gLdaF3t7wc5tQkOcvxFkdHr7Hmj2/7b8Tih4JPAtt4JI2VK/Xyo9a6EQQgRlVCjEWtFIfjRmEdpQl62R0sqtTzO9fEEMyZiz5oJFRN/K0FQk4usTnBbPtLlV4C4EQA4obhyWgYPivCqlukpFe6XbR825Vmx8pQcJjHxp4DXHaJz8hgh6rjuf7JrIzzFrjNOZeUbudQ3hNbJlcynS6DuK6j55w2zeabisZw9mBtS4R0CtsvBtBulpJyKwQXgDf4rZowPwIkG7vEMWct+wuM1Vxu3+GTWygQc2NbI81dhyFSC3CU29FwugaAp2jk/vXncSMAvPXAcIhBfjkm/1zxjVAOielZb+VoW3iV7rx97XoehSrBifmSoBtfm3IT6ik/w2RCRdSSqyIYePiwbF0F7x9IKoZDrpv1D0Fl3r+Sgj7lyqRw3oUujOAjF8HRv+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFY5SWpQdUNtVEZCTkg0RkZqMHNscmllNUU1c2RITFNQWkJocUZob0hsVjcv?=
 =?utf-8?B?bHJrdStKc1pQSW1VT1RjV1RsU0xZYmR5NGl0RUhmWEVSeUs1eU1aSjlSTStt?=
 =?utf-8?B?dUQ0THlJSUJRdkhraTFDak0yak9XTlJoa3FVTTdobEJOdE1obTVkZVdsU2lR?=
 =?utf-8?B?WUM0U0JzZkVVMnBBekFIWGhrYlNjUTJYaWhocXJ3TVdpUml5RTV4ZXViVmk3?=
 =?utf-8?B?ajhjOXF5dWVsSTFnYWk4VlJxcExBc0xvY3VsYmN1Y3JIc3NmSVhwNE9ydWlo?=
 =?utf-8?B?OWlVdElRMEZySjNUQkMrZERMcjFHeFFxMEdMdXFFYUdkVWk3NkxOVEhZamxD?=
 =?utf-8?B?QktodEVFZTEySUhlc1NibVpEdWo3dGs0KzlhcHRMWURSeW9adzJ5UTNGczNS?=
 =?utf-8?B?OThSU0lpdVFQRnF0MVhZcUJDN3JjakovNlMwbVNwV2RoelYwZDhSQVlpYUZa?=
 =?utf-8?B?SkY3V2dhQUxBcm53cVNQOXZVdlUzUmE5RE9zYjBsOHN6MnN5dHg4RUhYUVFK?=
 =?utf-8?B?TTFkZXd4ZzdnbXhDcWNSa25wWC84dTltSUlCUTY3MmtQUnlXVXBTSGN3SU1H?=
 =?utf-8?B?SlNOeXh0Y3B5YzBkU3N5ckVFNHRkWS9VdmUxVGZNVGNiRWNja3p5ZGowYS91?=
 =?utf-8?B?Mzg2eVR0bUZDYWkyWEh0T3pUY0ZPclZnU01TOWs1NElkc0lzL2MrYzdsWlZi?=
 =?utf-8?B?T2RkYUVIRkNoRUtRdEFCMk5NbXN0b1N0OTNZV2dhRTE0b0cvNlNwOTMyc1pB?=
 =?utf-8?B?ZHFmSnhJSFFPRElpSXFyNVJJazNkL1hQVHZFMjdpWVBhaFV3eXcxOWNmWkdZ?=
 =?utf-8?B?S04wV0xzc2c2OW90YldQOWNubzh4OGdMbUFsTTJnNTdaRFEwbVlTWkE2alZL?=
 =?utf-8?B?a1VvVHZIeDFnWXZ2bE1EWk0zV1FxejRUNFBMWVh5OU5iWTlBU0hxUFcrdWJt?=
 =?utf-8?B?Q3htblBXLytuWmxSOS9nL29CZjBQdzFmNVBCTjNkVlhtSlg5dUppbFkwTm1Y?=
 =?utf-8?B?NXdxcU5TczQ4SzZCWWRaTHVkRzRGRDhnbHVnelNpTWpMRGFFQnB0UGV6a2xt?=
 =?utf-8?B?T1RYd2RmOTJmTnZLdlVtYjZJMEMySEtoa2dBYXlEc0MyV0RkU1hlei9xdHZl?=
 =?utf-8?B?REJocUpSdDV2TW1KSFdmOGJmaDFRSXNsS3ZlbHN3UUtHSDVmaE9HM3J2ZFlX?=
 =?utf-8?B?QmlFdzJhL2svM3EvMjdZM1g0RFBKU0VwQjJ4NHhCaDFoak1xQnp0a1JkSWRF?=
 =?utf-8?B?YVBOMDNlNlhlYTVUc0NxTzVNbjVHK1M5dHJNRHJzT3haVkJGZE1KMHZSc1J3?=
 =?utf-8?B?VzBZMDB0VWE0M0w1MU1pd0pwLzRFcjF5WFdSY2ljWk1hTXNkLzMxR2l6ajJm?=
 =?utf-8?B?RTBPYW5DRnp4YzFIV3lNVGNaOTE5T0FHQ2llU2JvN1hzejlSTk9ra1BlZEVv?=
 =?utf-8?B?QjkrKzROR3ByTmhFMUxXUEJpcWYrdU5RV0ZtV1ZSdTFPWWZrK2pMdnIyS2pi?=
 =?utf-8?B?MEZyc1V6S1l0OWQ4Y3lsc3RlOFNDb3hGTXV5YkhWUnZvOEpDMlVZYThIcTlo?=
 =?utf-8?B?bGk5clg1YjNNVlVxSWp5RlM1WkxLT2lmOFZ1dGlxZzZPbFVhNU1NT0h6TDRU?=
 =?utf-8?B?SmhiZWl0UjNPdTJmc0N0WjRsNU1IcGo0a2VmRXRZVkJmWlozeUd1aks1SzBC?=
 =?utf-8?B?MmVUdTNTZTFmZFFTaUloeUhmaGJJOVhZaFpEeGwvc2tNMUl6VzVyNjI5d0RW?=
 =?utf-8?B?NG4yMFFzQWZ4VHV4T1dOOFh2SkNJdFUrVTVSYzZRdnR4djNiY3o2anBtWkZq?=
 =?utf-8?B?VFhYaG16R3psQklxMlk0RDNQbU1DL0s1emRXRFFOS0RVZ2tlbEsrdzB4Zmwx?=
 =?utf-8?B?L3VJejN4TnNycFRFN1NrTEhnREtUdjFqVlZxUE9VM0E4RlRFUFJaYTRkVEhr?=
 =?utf-8?B?dUpEMGxFTnB3ZitjNnlvMWFPTWFSNmxoVjgzVEZSNmtvOHVHYmE5bS9HQVg0?=
 =?utf-8?B?NGhaOEw2YUpFMzlYMTdLdFBLQzNteFh0UGZ3ZmJJRzcxd283RlNjcjFwNHYw?=
 =?utf-8?B?NW9yRjR6T001eHlBWU5DbW5xTUNwWjFybnFXNFJNclR5MEJtdW1ZS09DMkdW?=
 =?utf-8?B?d1RKSmk5RHU3Q2xEU3FLRUQvTnYyQTRSQjVrbzhYWS9TeWxvcmFkaGhOWVkx?=
 =?utf-8?B?c3NSN2ZHZzFPVWt0c09kank5MGpEd1Q5VW9qVUw3YU40alM3TVMwZkQ4VnNO?=
 =?utf-8?B?WlVGc2dpSUxFcHFGSjJJcFluN3Jtd3N4QmpOSWVZVHljZnVBZUJneDFxcVZG?=
 =?utf-8?B?bDBUdDRTU2VDbjkwcUhGbE1yNGNZd3drbmpDeG00WldkQ1B4U2dDdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2f86ed-ede5-47f5-48e1-08dec5f77344
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:31.5363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJ9/j8JdbzMntPeR+pYmM+J4hzYID0DLx84WVChiETlvu4is5rve/LP2KpIKw8ioJRixUgO/w5KGpVCcP8NyjQ==
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

Use dev_read_addr_index which supports livetree API, otherwise driver
will fail to get addr when OF_LIVE is enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/imx_rgpio2p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/imx_rgpio2p.c b/drivers/gpio/imx_rgpio2p.c
index 7cf178f8a48..ba3c5fcf25b 100644
--- a/drivers/gpio/imx_rgpio2p.c
+++ b/drivers/gpio/imx_rgpio2p.c
@@ -194,11 +194,11 @@ static int imx_rgpio2p_bind(struct udevice *dev)
 		dual_base = true;
 
 	if (dual_base) {
-		addr = devfdt_get_addr_index(dev, 1);
+		addr = dev_read_addr_index(dev, 1);
 		if (addr == FDT_ADDR_T_NONE)
 			return -EINVAL;
 	} else {
-		addr = devfdt_get_addr_index(dev, 0);
+		addr = dev_read_addr_index(dev, 0);
 		if (addr == FDT_ADDR_T_NONE)
 			return -EINVAL;
 

-- 
2.51.0

