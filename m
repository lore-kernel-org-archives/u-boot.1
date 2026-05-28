Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4430ECD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 06:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B389884659;
	Thu, 28 May 2026 08:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RRa1ap32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30FC846D1; Thu, 28 May 2026 08:43:52 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD5784659
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORviubVy4nELWgyfH1NYl3J+TxcvLVfG7+unDg5c0gPsk5YqlRvUuB+AOk8Wf8xY/vT7/pzQGzW80534rcwrEiCm6ss/kcjDIMoOr8PKvKXmobjUfPHh0F5r30yJTggAoJhra5KfHMz8xMLuN5GvFoiaq4/mHE4kHdTwmje2hb0hj++k/qPoCRiNZv9llcPSkglncnPluOrUMBMa/UWwC9CeszfrGXuuLE6/B63ghVVwTww5Rp0PqUm8ziIDShSFOWmQ2kd7x+UzVZdpdCq37vlvhxfMmdVyVuTseUkvvadLfN8M3xv+ei3GvifB7xESX8fOrRxcBg+WHSuTDZzokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRu1MImRO7QVj5dFdEIiS9UhWyFb8B8YVWjSgxJvqfE=;
 b=JecT2V+VDGEDA15NAMMfeqeCJbMM7BECh88hyhulNqQ9plsF/ZJRiVuH1VFvsZV6JnCafk+SUljTeA5y/Imw3xdHdJe8N/vwsgwM7Npti29K1DmFQ+owHlSr06l2hxPBnDtXYHovltjqnWcb+1tQjXUTMHDG5qvsb6Baa5BWi8qqmA8oarUkgJypbLGUFrffAOAVgma05pyLKoE+mD80bCsa5JP38x9O5UeBvpk7V4kozlo5DLwHQI1vrVdvjg1n6xHlb3FbDetdOgA3X05SdsyyUoX4wdh6MUwxsmpsyO4kaV+6tXZ0xAvWC6J8XA6o7xQXanieqyQxunBL+aLCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRu1MImRO7QVj5dFdEIiS9UhWyFb8B8YVWjSgxJvqfE=;
 b=RRa1ap322Vn4mbH4SiFGMI3dAmBe4/pKnwia17BvYtANgTYAlycczfDOT37r7mIKisIxoUzWsUYWftMrb0c3iuqdspTqxhrk7CVVNzE6ZzLmHtQH9JC1PdxaFCQa7E5s9yhbHw2Ja6MvFr7nkIies9nweJWyqeLadFIjCe0Ktd9fPzkrIC+O2TplVUR52hY4xGaI738WnOSKJbTmULcUUoUNYFX07g7j4QUU1H/6+pKbTiY+b+s7tVO2puPge3y7HW0kyE4j8SLgS3TZ02U0i9xjW4bZvKe+Y9QyqfQzQcXcsbYhpbE9mihOT/8y3YplXR+fQ15HzycKmaN8ndIdmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8516.eurprd04.prod.outlook.com (2603:10a6:20b:343::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:43:47 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 06:43:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 May 2026 16:00:22 +0800
Subject: [PATCH v2 4/6] net: dc2114x: Use dev_remap_addr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-devfdt-net-v2-4-dc6f20b82611@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6fde1d33-190d-4d45-711b-08debc8477fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: D4JBA/zxAHUM5En5K16R8OKBHFXLsBfW/7/a++JWwKFMvJIEIFI3mxG+umnKT/Iom/Qq4XWNtrbjj7HIP2i41X9bvXmVohYsgaCKHKRq8VFPtFysB3iF3CKR8OLoZ+70FDr/X2vYd4J7iS3cs9/XmRfxtN3HNzfRdLr1zqvaeL8oNpeZ0QTXxGQcYGuF8ZhyB2uPwdcXM7XkEuZD3v7E+8TdIv7UHAmWHSLUoptqycN+UZ3vls3PabOclRYUTkMCvCmQ9ocnY5sz+GtDWzJPG0g/OcCcQYols0XeXormGnI0eVWyCCx7k51Fanl1WJSih4bdkQym0JCN8IDLp3s484Yqdp/xUbXkP2kVV1QhvmoGagq8bY9r/cv/A13PrHxJDjacELOlD4ZDBntAHwt2nxuH4bacjZvWzlIQX1p5iQWTzwOR53RodmxsgNquqIa26A9rXxGQCRP67+KcyReLJZFQJjrGXXYoBucG8KVLmJFXY2srwAfx3/EVfUjrKD0XG5rpFoR+zpMPq4iEjLH5KTRhgfV6jVBAd9AiItzNJpG7Z+PtdmEkgcw5hihSOOUpLqtlUI+Uv+kTRJqECYT3p9uApmZU05lU5uaHIMXmarS47j+2BpRH2p0pe+Py6uZ/nMu11nBrctUvcmzsyPvf1wmDpYNHQgOImXOlLgd9gOXn/C2LeTvy8OjJlPKTt3sLNtCNc7j9TyeTu16Bx/S7rPDQSmdhZv8TfPCoBeHqIoUJe1+xjYdRr/DK5ylCSAPW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGZQMVpyN2FIbjhFZVlrV1htNjV3QkNNQ2Z2OTJnVHA3VjRMQ2N6QWR5WGhy?=
 =?utf-8?B?OVFpQWE5NFZDWk1BeGIxTnRHd0oweWNUcldmOEVOTVg2YitFNmhrQlgvbHZh?=
 =?utf-8?B?dnlWOGNma0xmbzNPbUdQZ003K3hHaXU4MzF6dnFlRTFnM2dkNVVDdmhiVWl0?=
 =?utf-8?B?eGhxUUE2aDFLRkI1WGZxOXo1bG91VWFsemR6Y0xXN09Zc3hvVmlkMEJFTUVO?=
 =?utf-8?B?eXhnV3YvdFRkdGF2SmtMdEJ0dDZpdGNOSEo3RGlkcEtBRVlORmtNZlFXRVpQ?=
 =?utf-8?B?a1dKcjhmTVhQM3d0Q2p5YmxiMldLdERkUHNDc1hicXd0VGdqaU5DeGp2VjlZ?=
 =?utf-8?B?UkJYUDk4MWU5bHRVcm0raHNWNVY0YXFha2hpdWNvek9oUlZwR1ZNa2E1TXN2?=
 =?utf-8?B?Q2tUcER3RmQ5WGN4elE0NEhwQXNvZkNPd1VkQXhhaUtyTGtiVW1wMEQ2Nitu?=
 =?utf-8?B?cEt3eE16OGtKRGttZnNISjZQNFFjQ2NsRkNEOTVkdGcyS3huUGdVMmVNUjZl?=
 =?utf-8?B?UU9zeTZMZHhqTmRZWFpZQlR3Ni9Mc0liNjJ1N3M5cTRNRk1uMmY4elRwamZm?=
 =?utf-8?B?YWJvcXpsckZ5Q0V0UTZwN1dYWE4yalk2MkwxM1pUNFpBL2ljQXNKQVExbFhQ?=
 =?utf-8?B?MVpHN09hcENheXZFSGhnbHFPeXdkMGpBVk43NjZtNGZGVTJ2UFRaUnJ5ZENi?=
 =?utf-8?B?Zk9rMEFZME9qL0h0RW9pc25PQVkxcGtaV2Q2ZUJ0djNpMXlBb0hlOFFBZHZG?=
 =?utf-8?B?RzZLMndneTJyOUNpT1pqai83NkhpNkk3NlJmUGlXQ1RyWmpVV1VvL1ZWT29U?=
 =?utf-8?B?UWk5c3VXTjc3NXdQWlo4TUo2clNHSW9QZ3JzQ1NVU2J0U3dudndFbEZSazFB?=
 =?utf-8?B?NWZxMDF1Vk56WWI4b09rTkJ0R1lWeXUrNGVUWUo1MjFQVVhEclEzdXN6YVRF?=
 =?utf-8?B?U3oyME9qQnBiS2FnbjRNcXNSTFN0MWl4aTFHZFNlUnF2OThSeXJEbWFQVUhJ?=
 =?utf-8?B?cUwxd2VaS3hSQ3lBVzhCc3ZIRWdyV2psakNqd3U1aGZ3RVNnWDYzcU9pTWlo?=
 =?utf-8?B?aGtFWWtWaFhMOEpSQ0JuYTdpbUZYUlgzYVUwR0I3RVJ3UjFiVEdBR255QW1R?=
 =?utf-8?B?dDROeWNoR25UaTRCY3c5YVV1T1d6Um80WHR4dnB6U3VEWlhkNCtZQ29rRThp?=
 =?utf-8?B?c3NkWVl1THRCMTVURnphM2NncDRoU1dJMHpqdHlNZnpXb1podzU2T1FUT3hE?=
 =?utf-8?B?T2NGWE5MRUEwZ2YzV2JCUEVoYXl5QVc1c3dSYTkrUTd3eUdKbmVSMkUveE1R?=
 =?utf-8?B?cVg4YThzdVdWVHBKeTFacG9TbFBrb3JyYy90TVdVRXFCZG1yQks3UjRuZm56?=
 =?utf-8?B?U2dKSjgzR0d0TythNFFERlgvR3hHWUpsancyM0FiWXZtaTA3ajBnZEJCM21F?=
 =?utf-8?B?L3cxOFd5K0pQM1U5dyt0V1hnS05ZV3NZVDRIeVdJdXdINkIyVmVzRWxrSGxC?=
 =?utf-8?B?SUQ2Q2d0SGh2VVJpaElzbGRRV0ZQczV3TTllVXI3VG1hcG5xZFJKRWpIMTB3?=
 =?utf-8?B?NVRPNmpydXdtaEJYTTFtVndyVzlsei9DWnRxQVIxRUhKZjBFWHYwSUhxYUpI?=
 =?utf-8?B?TmxyMUEzQ2NQSFdGTE43YVZ2L1BWOFR5MDJXcHF2Yk5ULzAySzY4K0lQYmF3?=
 =?utf-8?B?Q0dRYUtHSDN3b2VaVVpzV1RtZ3p3RGdHWnY4Sjd4cTdobXpjYlhwanNXUkY5?=
 =?utf-8?B?OEZobGF5WkdxMHZnYTMzN1VPZ3pNMzZRQUtyUUdCT0R5U2hRaEhtdHM5c0p5?=
 =?utf-8?B?T2ZRMktZMURwQTdpR1k5cGpYVGJPTm1zYWZiaXdXa1poYmRSd3dwK1RTTFRB?=
 =?utf-8?B?SDFNVVJJMWh1eGtRbHJUWmd3QmIwS1RaeWRYK2hpeEVlT0lHYmpjUkp6Tkto?=
 =?utf-8?B?eXFxRUVacXNrT3M0dmF5WXZPN1VEcDNTdjkweWo0NHphd21RSzhwcjRVc1I1?=
 =?utf-8?B?VjhLOG1CVW5oaXRyZkRMM1pPY2N6QytKVmtXTWxCVm5IdVpxelZSUlpoWksz?=
 =?utf-8?B?WUw2di8vUUljM01hdmszRzBwd0g5MjcxTktuZlNVa2RuVXdJN0RMcWtRRTdP?=
 =?utf-8?B?Yk1Wa2E1eVZjeis5d1cyUk1KdXhJODdFOE8wdjBSQXZQVTg5bXlubmIzS01E?=
 =?utf-8?B?RjdHc3orKzdNb2hxY20ySG81M094TzZaaFFCZCt0WTU3VjZ2M2U5eUFsZlkz?=
 =?utf-8?B?bUdQVUlJOVpObTBZTHpETVd0aHl1LzN3R0JMRkhsVy9ibEtQR3pJb3BES0Rz?=
 =?utf-8?B?WGpVMnhvaG04ZzlYblpKNnd6MXVHbE5ZY0R3bzgxbmo4bDBGTk9VQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fde1d33-190d-4d45-711b-08debc8477fc
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:43:46.9559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6h4HXyLE5nd45tWQhRJ4l0QwOM4q2ubjdsvovDuAiw+JIzXkcFQrc/F50/TRq7kzd0diZ66RbFWFkemqMladcA==
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

Use dev_remap_addr() to simplify code.

dev_remap_addr() does same thing as dev_read_addr() + map_physmem(). And
it supports both live device tree and flat DT backends, avoiding direct
dependency on devfdt_* helpers.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/dc2114x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 8fa549280aa..2a21eceac57 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -653,7 +653,7 @@ static int dc2114x_of_to_plat(struct udevice *dev)
 	struct eth_pdata *plat = dev_get_plat(dev);
 	struct dc2114x_priv *priv = dev_get_priv(dev);
 
-	plat->iobase = (phys_addr_t)map_physmem((phys_addr_t)devfdt_get_addr(dev), 0, MAP_NOCACHE);
+	plat->iobase = (phys_addr_t)dev_remap_addr(dev);
 	priv->iobase = (void *)plat->iobase;
 
 	return 0;

-- 
2.51.0

