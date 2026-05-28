Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7063FCD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 06:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51908056B;
	Thu, 28 May 2026 08:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZeNftSqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ECEA844CF; Thu, 28 May 2026 08:43:41 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7098803C6
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FK3VY/MPW8pBHUSo8IRnFdT8saXXcPScZcQwBAiIRfAcLg5WlgsBaoawr2VAEzEERGpIimoi37SfZWtgI+PblzFItTjed4iyv5MIXczZ/eV1p6uRnnkdz0py4VoXP2jluQnyrqNSuhNKDMdCUMQHm7CfFZaOBVSuNSTzmhizzm6GFaAYEGScJBUDOzA4gpknIr/sK1JjJUkMepeRBFs8EQvIdEXweXTJvVOkCMCbowl9016JHLCefYn+qymhqNBo4X9XPVhS3tPF8gju6jtO+0TUSvcSf6tJ9S2sKMYdJP82tCnkWcXqjFhwzK2plkPwsBqxzjY0pCI0VILFDUAaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Goyi962GT+aKCeiDXMYzlMQ3cusehUxfLN9W6FGGYfc=;
 b=ngjDzbtLifB0JP4F7meYZxrSwVG1jvGpJNYtqhf+ztImQW/8U/GOKgmAd5D/qSahClPVMw496AdTeO+cKJ2kPiEm4tNXDZUTOMwIKYNXJQReddjORuZA7xMDYI/qneWs8TKwDN8vho4uZ75eG9LQaGkbwshUt+5t1hwtYh74YDRAJ7ulDHKprshwUXzqSP7LJWiC6PEOaaTQeUjH7GW66ERJ9C4D5pWR/8K5ZIWNqgoi4OKwmM/4wWzB0U1qrWjNdDGHYvg/EQsr7sVGSGGL57889yDTpWJjZewY87AWHja1EySZOpagOEdYi22jO20sOT1E6EHrsM6PNuK479uG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Goyi962GT+aKCeiDXMYzlMQ3cusehUxfLN9W6FGGYfc=;
 b=ZeNftSqx0WJmqAg+UYRgkiBtCrwqYvKIt9aZvua6qvo4eEbEIyOdeAvFvHtE4MF4PRYhkh3R0qWZx/y31L7Kzti4KtRH6FHiKmJe8JF0AFLOg+u7/jO81TFpigjoHVRb1Q4nT+suBBo+m7b6xR4SLa9mt0Fyg4oYJpxhunkg5I737I2jmNL64rE72/qAV7dklVFsVOvderHFB95VptIDNhDJetPTRtbfYPkzyxDRjmDdY247CtEjqQ4x4TbvdeDvf3yjUQsxP3OixU+Nbv46o2RIsNDvU/sEhcoGNv4MwQ9/jKH7JjXM29HNYQrNp0AK3ctSEATXsx+nbY1Qkv92vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI1PR04MB6880.eurprd04.prod.outlook.com (2603:10a6:803:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:43:37 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 06:43:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 May 2026 16:00:19 +0800
Subject: [PATCH v2 1/6] net: ethoc: Use dev_read_addr_index()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-devfdt-net-v2-1-dc6f20b82611@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI1PR04MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea1dbb2-4fb0-423e-30d0-08debc847257
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|22082099003|38350700014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: E6hNxWvNrV4BksahX6WYMHYZrQYrTrH2qJogA6y0RP7Hf7Rmv8Q1ChjV8qgq66lEqUYEImr4Ghxz0jrun3D3/NTbeNJ4Z1c2a2Cfevl5Ec1w6Nlr4wECv5bMxShQfl5hWhQ2iLby84claq8MYGF3VmyHvVSzu9gAKNJnmaLDrcdM2fD4Y2nFyUE+oERtP80dt3iNlSXWLyt7246Z5WwRRj7NjlmfirmJ/FRpFzVrfISZ1MC6vg90twgydDFqZR6kQ0Pwggup7ENuWqWcEUErtOnHv33eYW56iDSbVjH6MDPGZ3EUs8jE1gfloC+xBuggXONQvDyGqoTBKb97DZbvwz03lrxlNPfd02JxT2nC9YCE9Naump5wUJLO4oQksSQE8N57f8Dtwzaw9bhk0sKAWRuccmyFRtbBi5iOZu4AJtUQGqrq90277n7w7MOI4+EeV3OWxB9pTZqEt12dytrKZg/u1bD/uhEgeB0V9p2Ys9tlZqVxX7e+cksrUAWqqJ5maIIHRKpsLy3q1Mt8523CObrSxBmkDsnOMnJ1v3QAmQ8pbIepn/+c52Ot4H37bXMDMeOa8tt/zQ01m8zFkJVzjzRHkO74SpGDwvrYJYhW5D3dyZeUeJTd+XrH7dkJcQ/dfNoRiOReIwK7grzegkIURzn3ykx9yQ0HFdfkJnhOr/m6pxOrWfgYpGfjrZBfjKT/D6v96QMPa36QyVq9VkoWreQNzeIrU44YoNktiSKUEafDA9aJuaoemxP2yn/ChYRG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(22082099003)(38350700014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZGSHdHMHpOMFYvaU1zUk1yeGVDVFFLTVFjUDY5c2ZpZ2k5WTB5RFpkR3k4?=
 =?utf-8?B?Vng2aUNuUk80SXBIai9VMVFFMVpmRkptTmxZOEUybVpadk8yTkZHVlFOS0hP?=
 =?utf-8?B?ZVQ3M05COTRiMFlYZGlaS3h3QXI5RDV6OTdUWExkbitpMFE3WS9kdDAxZkZr?=
 =?utf-8?B?WHRtRDBQdlordXdYTUtBckk5REl2dUtMb1VvNHRqcW54bVlHcWN5QmYxdlpv?=
 =?utf-8?B?bkMzdGVxZmVET0tjL1NJemtKbnhyVWZNWUM0SG9KN1prYzFvdSsrRVZZcXFx?=
 =?utf-8?B?OVpnRFB0TG9mYWltTys3VGlLTGdaSGg5dXZGOFkzdllrQUZQOElnOXFmcm9u?=
 =?utf-8?B?RXVQVUxUUGJ2R0FNZ3FGR25EN1J6NXZuMGJpZCt0MWc2V2ZSeHV2TjYrenhL?=
 =?utf-8?B?anVZY0tJZ0J0c3RyVDQwWDVtTmM5d2VRdlJ0TktaUmFVU215a2psQTcrbzhm?=
 =?utf-8?B?Ly9RQlR2azZuT0t3eUYwaXVKNC9PbHJIR1RxZmJIR0sybi9uZzN6akd6NU9n?=
 =?utf-8?B?ekluOFl0S1RrYVZnUnJqZVk5KzhPVjA5ZFhmZUNQVlVEdmN4MHFBanMwNzJy?=
 =?utf-8?B?VFUydzFvbitvdGxXN0RERitTbFIvTTNpQW5WSDRzdXovYm1OSXhKYnlpSDA0?=
 =?utf-8?B?SHNmT3dxMFdWSkhRWnBYK3FSK0dzY0ZKY2dxMnhXWXA1c1JHZ2tySDVTTkR6?=
 =?utf-8?B?aVcycEdtamhXdUE5SzFTRytjd1BqZXIvR2ZhbmNQa3EvdTlyN2QrakswK0lW?=
 =?utf-8?B?WHNPdHlTRFVxcXdZRG92bXJlaWo4M3pqZE5aeHdkanhZRVM2ZzNnQ1hDQVdW?=
 =?utf-8?B?Y1BLdUMzcGF0N1NsMVNmUUx4NmozTElJYzNPbTY5RDhBYS9ZS1kvVTFUcVg1?=
 =?utf-8?B?SVRlUHJpa0NubDJUVCtlaFVqMDBEQm9wTjFlS0ZpWklhdklxQkh1M3pHVnZC?=
 =?utf-8?B?R0tUUDVCQldHRy9RUmZLTUtDSWZBVy9lczJpaEtFcHN4M1plSjN2YWNCSDFD?=
 =?utf-8?B?cXVWS0tFMFFjQmZwMllNZUU4QnBENEo0UHI1bmg5OE5JWmlKV1dmSWV2N2Jw?=
 =?utf-8?B?dUJ3K2RwL0cveUhROEZyTDU5blhNNEhqYnQ5VHIzQWQrdXBhandjM3FUbGNO?=
 =?utf-8?B?cmxzUFo3WngrR0J4UkdVVVdPYytRMllmYkRpZnk5dVl3WThIazh2Q0ZoWFhl?=
 =?utf-8?B?VTljYUZ2d0xlcFdIWkNsbXZHQ1B5NmxxMERVRzlKOFNNQUFlS1N4dFJMd1Fq?=
 =?utf-8?B?RkVJS0xoMU5EdGpaR3VGZ3BQN1NLdll2L2szNVNWNWZMLzJvTHZmbWkxN2tJ?=
 =?utf-8?B?djY2OWNoc0pGRjlpMDhHWWFkWmR2NW9VTlVuUkR2RXpNSDFZWTJCWVRsL3lG?=
 =?utf-8?B?a1lmN0pkemx1ZkJ0TTVOSC9jU0lETGU0QldmV01XSlZ1enNKVStEaVIrOWxZ?=
 =?utf-8?B?aWNTdHdPNW1ySUY4aFFjMDJuVTdJN2QyMTlIeXNWcXVIZEtXcXJrVk5NWE13?=
 =?utf-8?B?NG5QbXcvSHg3Ung4Q3g4Q3hzMTFQV0tMNi9DcWtXWXZoa3p1dnh5b24zTEIr?=
 =?utf-8?B?bC9PcHdFRGdYZVJXOFBmRzdsSmYrL0lULzlRQitjZ0FaZ3lmRDNuK0VDMG5p?=
 =?utf-8?B?S2wwelZTSlpFKzFsV25DUUZOcjdNenZrbXZoN0VxOHB2S2E5cmtpR3ZlV0lo?=
 =?utf-8?B?MzNVSzVLMFVVWW1rQmpMZVZrNVNkNUREb0ZlMWNtSk1VbHNWcERiZ3RyTUVR?=
 =?utf-8?B?cFlSaVhlNmNLd0FYRENGNlBmd1EzbXFGM3V2cTBoR0JaWGhTVXpLdEhacVpt?=
 =?utf-8?B?ZWpwdFJJSVlzQndlUEFTN2JxcmlUZ1kvVFl6Wkw1Q001VU43cVpMazVzcE9V?=
 =?utf-8?B?KzZBTzlRcXFVZWxOQVNqdEN0SUQwTW9xNW50UG5iamQ3dFY1VGdKNEp1elZG?=
 =?utf-8?B?MnlaSjB2OE9jK0JyVTV3Rm1pVXByT3ptY1ZsMXpYSTZpSEF4RnhzSS9MUmhx?=
 =?utf-8?B?K3RGOEZsWVBvS29rM3JFSXVleGpRNkxXanA4dERtZGtVN2hJalZ1SU9NWTBu?=
 =?utf-8?B?QjdYMUg5ZitIaXlsNy91SDh2TFNFb1hHK2RxYSs5NFRucnhRU3VCU3ZNdHJi?=
 =?utf-8?B?bTdVOEd1NFFpaTlvQWhxVHNtYTRKYUwxSFlvWThINUd4Sy9Mb2M5cDM0UU5h?=
 =?utf-8?B?enlsMW9MazBMOU8vem9oWHRwNnhiSW9JckVJT1lld1YvVUpCQjVPbWpyUExV?=
 =?utf-8?B?RDM5aXJlTXZNRjNHcXJzaHo1TUtjOEdPbDhiL09hUGtwTGxNKzdWWmgraGZ3?=
 =?utf-8?B?cStjMU9oODZkWHMwdlArK3dCSHlFMm0wb2JneFk4L0RacGRyU2ZGQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea1dbb2-4fb0-423e-30d0-08debc847257
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:43:37.4479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0GVvXAo9H5M75jH82P/faCoZnQ9u3x+SJGY4dJFmsq5NFtAuHin24lP7VKSwyhO2DWDA3Hsz53lbIc31En6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6880
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

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/ethoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethoc.c b/drivers/net/ethoc.c
index dc7e6f1929f..87b2b3426c8 100644
--- a/drivers/net/ethoc.c
+++ b/drivers/net/ethoc.c
@@ -686,7 +686,7 @@ static int ethoc_of_to_plat(struct udevice *dev)
 	fdt_addr_t addr;
 
 	pdata->eth_pdata.iobase = dev_read_addr(dev);
-	addr = devfdt_get_addr_index(dev, 1);
+	addr = dev_read_addr_index(dev, 1);
 	if (addr != FDT_ADDR_T_NONE)
 		pdata->packet_base = addr;
 	return 0;

-- 
2.51.0

