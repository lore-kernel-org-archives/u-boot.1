Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1465EE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6DC8060C;
	Fri,  3 Jan 2025 07:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mM76ALYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8664B800D7; Fri,  3 Jan 2025 07:47:08 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720A480601
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1RmIW8Tv9A7iG9CAHQ/pPvlad6HEW0v3EjZ2E51hoEJSlLCaKP1tyC8j4r6JJwKh2Q2N+vZ6chvewX/uB3ily3JyZxNaIygpFwmDhWoK1kRRC38yS8svDfUGsy7HE0BDj7iPDZuI+onAPo0tPKnVfCD4kuz24pmEQydmEtefO0kpNZHrxlS/rFILnXVoXtpTh6uzjccq7E9itVRbEGNP2JAuRe5Sgr06+deFUKc1KsjEgnJZbTD04KIwo80zN6udigPz/pJB4iZRRjuIz0GMoC6ryzC6MblDKi7x0eRN1q85GQ+QGwKHhSF20YEPrrJjf0vfninh6T2Y5vHVkXTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoBLlI6YVO3ooADgmy66hcgQ51cgJebEeBgA8BhwAQ0=;
 b=teOaciWVeaqsVc3opiKGvHnV/vx9tZMKz99kDyz/HAK40kFT+n0B5XuBI7tt1FqYtw2aDG/8dTbYvNJFscywRt2kflvcoD93pEDB369tZIleacbhegCYTyjHYOd3lHCkA1Z6MfLIk9l7R7jxqSFRdSzzFmbfqJFSy0vLowrbzI452hZKMIMZrDB/CFYOVJ1WryB84v+QfCf1QJo3EIsHw38QV/OjvKVI5/FPVzWOwwH1xNiGCyYCbbn9eMs73uVB9RAX4ccO+MzQ8xKW9ckturwXdFHXVlmpJEciOAhc0znsC4wR04clw0T6lfZ2Iqq9XD1TokpfB1AIj/5mhM2kTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoBLlI6YVO3ooADgmy66hcgQ51cgJebEeBgA8BhwAQ0=;
 b=mM76ALYaVzskrU6LG5DgOX53na+kdhi0D7zZsgEWqBpMQ3gJqFvXMkzHnQ3kPvYyw5upMDTt4iRq3zugNMhBATJFtTxGp6Dv7GKOXkBgWyG+CpOya53kcob4Ao9HCv1y1fo8SGL9+6tNKJJchkrLk12ntjFLqUjZgsZ1ACqeKGhyoJ0CwBfK0jGngH8EFjr1ncRKZ41m8+Qy86Chv+itUHj2kZ26+HBTYASyEUI2yXjBl2oc3NSUmiEjilbO/x2fvyOcEoVE0tuxNfyReT1P9pXuciA0oMDp9X3ZBrxE0wu1Nv9XhMOrUgDi6vF9aMp/X//+/hte2CejKZZRTtCgUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:58 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:52 +0800
Subject: [PATCH v3 17/17] imx95_evk: add i.MX95 19x19 EVK board basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-17-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=26381;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=ItXkA7YWh7FWFpcBn55v5cch842FeS41bHc/dmuR8io=;
 b=qZsSDbPDsI+sbq8jBIbYwqLiSLYLDUAjaPMj1Nizatxmv3rwqg/1pOm7dJ9WGqpJawd5kMMGJ
 yXRRi13V02RCahRXnD59797v/mj8e8nvfmXlbeMH6qigKcmusOAOyS/
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba13edf-953b-4017-274a-08dd2bc26b80
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0FYbktlMWdUM0Fldk9SZUlDMjZJeEtGSDEvZU1rb3ZiVkNkaVBYTFpEWWdT?=
 =?utf-8?B?c2txM2hyVjNhWGVCbWd6YUhRYTRBNUROc3gwYkFVWWloTVNUVU5iZTBhbWVY?=
 =?utf-8?B?VTRQcUlENkFxY1Fwd0o2cS9HWTZlRENyejhDcllIYU02MXJGdnpUT1dUclFS?=
 =?utf-8?B?Q0JYRXFXelFjZmR0bEJzSWxwTlUrMFMrR0lySUdjM2RZNTQ5R2JXN0x2Vmcr?=
 =?utf-8?B?bGl1blR5YnNLdjJncHFKUGx4dWpNOUdSME1hdk9RZUpOd3hibnlSYTVGM05v?=
 =?utf-8?B?cytPaDczNldqTDJrc1ZiNTR6c0lxODcyTk1SZkRhNVllVDNKMkUxT1FvelVE?=
 =?utf-8?B?cy9mRG5PUmx6TTZXczV1cG8wMU5jMTcrY0diTmVZN3J6azgzbkdNTDZ2NHc3?=
 =?utf-8?B?SjRXV1hwUXNIc3ZXUzZpdTZzL2pDT3RDcmZZRFpOVEowUGFyT3c5elN3Zits?=
 =?utf-8?B?Qy9STWZaRFVwTTRKWDdhRkxQdCtBYjk5QjZ3VnBRaHZnWjJicHRjdGZHM3J3?=
 =?utf-8?B?cUJWZ3dpdk5nWWgxVFRIVFd1SlBoMFVuRUYxbkNXaEVmc0Fab08vRThINmhq?=
 =?utf-8?B?SVFUUjZ0UWgvb3B0a1JNcmF5S09LOUNPODAyc2NRODBqVk9PMkVrcTJxOTQz?=
 =?utf-8?B?QU9Bdk9TdnRRR2R3ZnZIRmd0VHpKS2N1eVVrOG9ERC9aTGxBQVJqZGZDTVRK?=
 =?utf-8?B?SlUvbTVtbi9aMTJXRVpwRWNiSlo3TWNST1NXMVdRZm4rVTA3a01DczVqVDJy?=
 =?utf-8?B?bjB2Qnk4MWFxUXRkU2t5eVF0UThGUmJlV254WjZ0c2RBWFN6L1MwNGVySzZy?=
 =?utf-8?B?WUpkYWVHNEI4MVlnbUlIa3g2ZFJwcjl0b042c3ZWOThSZTAyeE54U3NOcTMw?=
 =?utf-8?B?d2hHYkxubVdwY2h5S25QcFZDTnF1NjlBTjBFL1NmNkdkTVVYTFBrT3BXa0ZD?=
 =?utf-8?B?MkZzSmFsMXl1N3paZU5qSWJDcUVJUXpsMkd1M1RwQnJ6K0pmcGRQWEx1VGVC?=
 =?utf-8?B?c0EzeHZ5a2JtMDVOUnNlcVYyRDhoU0R0TkJtR2ZmUUU5Mzh0RWV3NmtXaG5D?=
 =?utf-8?B?NjhWdnRzTnV0cCtKaHBwOG9ONW9lVnRCY05OK3BJb0t5Q2lHNWxrbk1wSExw?=
 =?utf-8?B?andWN1BhSFA0azV6N1d6Q2d0QmlJb1A3M2lXWUMzU1NvQ3dkVXUwSkVJRkhp?=
 =?utf-8?B?QVdxZVNWeDAxTmRKTC9qM1hvdW5uQXdCMkZxWVR2K3B2eGNjMzFXV05yenNV?=
 =?utf-8?B?SncvRmRzZFZxN2pVRnhRMTNPbENnaUlNSlVxNE91UnRTdlQ1UzR5Tm91MHZ4?=
 =?utf-8?B?am5KU2h4clJ1eWlDRHNaSDAyYlMrTlFrQjRrcDdWTmNVVldacmczdWYwZ09r?=
 =?utf-8?B?eTljTnZSbTFkSFQyWG8xQk42TVMxUDFidnUzUFFwUDZTQk9QcEwyVnAzQXNk?=
 =?utf-8?B?VkRhNy9wY1UvNWhVdUd1Yy9zS1dVdityM05tNy8wb3ZERXo2T0Q1aE5MT0dO?=
 =?utf-8?B?bEtNTkJmNGdwRlNCQ1pOR0Q1VEdlT2l6UnJNdmtHT0FYOWVLRHY1RExUM050?=
 =?utf-8?B?MStHL3lmMGc5R0xrWnB5eUZzcVhyYUNsUFdFQUNFQjlNa2xUSUhQcDdIMVg3?=
 =?utf-8?B?SFdUbVkyZkl0NEloQnliakpiQjV2ZjFPVjdRMmpwRlJkR2s1VGlUY2dqd0RU?=
 =?utf-8?B?aWxIWnEwMFJOaTR0Y2RPV0dDbWJCZWpVUjEreHd4TUNsRHluYUJMemJpbEVt?=
 =?utf-8?B?dHNjYkx5MXUwWWVSRnc1QUR0ZDJLeUlISE1lZTJza2cvcHJ1YXRoUTgwZ1ZY?=
 =?utf-8?B?VVdwMUcvbXRPQU9zYlJqUEROcHgvUmRmcnZWVHVoZkJtMHNZK0RjUENmNnlP?=
 =?utf-8?B?ck1aVkpjeDBxTDhGaWpzYWsrM1pYOW11YndNMWc4Y04xSmRtcHZVcXZaZEt2?=
 =?utf-8?B?ZnR3bVphQjRSRE5POGxHckc4RTNQNGxaS0xvTlFZbFJMQUExYTJOQTFCQm41?=
 =?utf-8?B?c014SEt0cWx3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkY3RWlBY1B5WlFpdWljS25Yejl3OWorVTNFNkZsb0xwUUh1UjgzdzRBVGpz?=
 =?utf-8?B?SkplOFpqakk2eUNpQVUrT2RuM3RiWWhSY20rVFR6MUpIUGtkUmpKTkM0OGdL?=
 =?utf-8?B?UldCZzdpWHhHZkZTMWt6WTMvd2tmcnZLN08xMVZmTTNTYUFicWRSemdGTlpW?=
 =?utf-8?B?VkthSG82MzVnZDRubEhuRlZQc2syNnN6S3liVzRxVmJCbW9hY2NNZU9sekZm?=
 =?utf-8?B?R29TQWl1bis0RUZxZjlwNW5PRVN5ak4vUC93bGpwaFVvTHRicUNueDYzT05N?=
 =?utf-8?B?SEh3Yk0remo1RXNLbDRDUUNSaUt6UEdTa2FOaDk5VTlzOGtVMEdmRm40dUhO?=
 =?utf-8?B?ZTFLVzk4SlRuZUdXSlZaYlZxU3Fnd2VkdTBkeGVGdjhTSWNkbG9CTHRWZGRQ?=
 =?utf-8?B?a05DRVpuREVBMDlBUWxXZEU2VklmaUJKbURPRnhWdnlGL1NuRDg3akJLaUpa?=
 =?utf-8?B?eTdrc2FXdVc3eG83c0hldnhXcGIvK05XZUJmQUZwMEFLUGRoYnVZQkJUbHFQ?=
 =?utf-8?B?YUlQSS9HcDN4MkRiUk94bWVNUVFpRGpNdGl0dUVPUUE1VklmZXp1cUpTTXlL?=
 =?utf-8?B?QzNmODZ5bDhrTE9uOGNpMm1URHZPUlRaZzJBZ0hzU3VIb081UXRCVFh5R2lx?=
 =?utf-8?B?QnUzTnNvbTlQUUY5eWN6aDhBMVYzMDRTNnYzclhFamlURWI4REhxNkxYZWVh?=
 =?utf-8?B?VXFSS2ZMdUtkSHNuYmx5K09tcGR4V3RvaVdLNzlWeU9aYXNkb05sOXJXSjFr?=
 =?utf-8?B?L01Sdk9jYWlaWHlCa1BrSzNYZjJhekZadXd6NDZhN3M1QitUd29OZDVxL3Bo?=
 =?utf-8?B?NDEwUTAxdjBHYnpYWXZEejB0dUU0enEraXZEejlwTXhCVTNpdW5wNGlMdUlL?=
 =?utf-8?B?Q3dpTTZRMFlEYkd3Y3ZvY2t0VmgxaFpMS3krL0VMbzRBMGNUWmtyS2d0OHhi?=
 =?utf-8?B?eW5zaDNrTjFITnQ3T2xxTHhNWnRuZmkydDY5a2tjSXFYdnlxaFBTckFpaGZk?=
 =?utf-8?B?R1pkWjdmcnRPZC9yaFJvbjEvYTJRNTlUT0tHdjV5Rkx3cDZsWmcyKy9hRjFM?=
 =?utf-8?B?VjlxZEtnbFY5WWdRb3RibnNmU2dNaFJiRmRhQmx4VlhjVHplaW5HUDJyWXQ4?=
 =?utf-8?B?Wlh3bUs1OGx0ZDNCbDkrcCtZSllEck5CdjNKT3JLdW8zakxtUUN2b3Y3MnRE?=
 =?utf-8?B?TXhHSjc0Q3VEY0trSG5qZ3JHb1RzZW9NSWNnWk5SN0huZTVrWUhFalNYRWR0?=
 =?utf-8?B?SGh3YTNnK09IZjdQejEzNWRPWjBNNVh6Vi9kZFRzc2Zta1JUMDg5c1dsV1VJ?=
 =?utf-8?B?Tzd1dGxGcWpaQ29EbnM3d2JETG4zL0VkRUxPdVBtU0laR0NDd3BpYXRxZFo2?=
 =?utf-8?B?bHlhamhpTWdsVGVyemdFTmduZWloR2JkaGdMK2RaVFF5OWJvbVVoWk8ydlFi?=
 =?utf-8?B?UlU1MEgxU2N1a1VBVE8vT2pCWDQyYWhNR3ZpSk9hbHBXU3hKOVF1cUI3NVJj?=
 =?utf-8?B?ZlRFYytyYS8ydEw3M2NMQUROQkVNRWM2RjhxL2FrbHpua2ZjbklaTStDVlUw?=
 =?utf-8?B?WVBaclh2R21FK3J3b3g2a21ZdWJUNFlXc1BPTWZHSXhSMFBjQXZkNWttQ0R0?=
 =?utf-8?B?Witrb3B5RmdSNnR5Zk9MbGZ1VC85N002cFRGR0pJVGpqcGVScWtweGJaUmZr?=
 =?utf-8?B?RlBHVUNRYmx0Qjh1QXNQbXhRcndxOXF4YTZIQ3VoR0xXNG5MTVQ2dmRyR0F2?=
 =?utf-8?B?bUJ4c0xralNTSC8yRUtVVDc5WGRxbkJXNHV4UEVkdDk3K2VkN1V3QnhNTEZM?=
 =?utf-8?B?dUVJQnVoTjVpdGtWRURIbEREOFNGUW1aQldESjA4TDhXWHdkbjhhdHlISndF?=
 =?utf-8?B?OVFRcEJZTngvNlJtZ2U1Q21hVUExSlpoTmdlSktYemxBUnVFdCtLbmQwSTc2?=
 =?utf-8?B?ZkptQ2FrUFJTSStZdklBbjRHRTgvQWZibmtCblFkcjE3MTVlR1NQSyt6Uy85?=
 =?utf-8?B?U3JKS3dTVkNPQW82Sk95KzRYOHhlOHZFa0ttM0tZbGQ0V0xuVmdGV3ZXYXVZ?=
 =?utf-8?B?NVJITWFLWXNJSWx6MUZyUExxLzZUUkE5QkRrb3A1N2dGZ1lOb2FJSVFERVpT?=
 =?utf-8?Q?Q/7AXwawATd2aBfVSYnP53+zw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba13edf-953b-4017-274a-08dd2bc26b80
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:58.4886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D4aJ9SNOy1XFExpYlP6Qdk/cxMbYqpzSp7jSqZc2kVkGgVq7384iAU4fNZpnmsx1gt7gQRpux9IcgCzACgC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
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

This patch adds i.MX95 19x19 EVK board basic support.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  68 ++++++++++
 arch/arm/dts/imx95-u-boot.dtsi                | 173 +++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |   6 +
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +++
 arch/arm/mach-imx/imx9/scmi/soc.c             |   1 +
 board/freescale/imx95_evk/Kconfig             |  12 ++
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 ++
 board/freescale/imx95_evk/imx95_19x19_evk.env |  90 +++++++++++++
 board/freescale/imx95_evk/imx95_evk.c         |  54 ++++++++
 board/freescale/imx95_evk/spl.c               |  96 ++++++++++++++
 configs/imx95_19x19_evk_defconfig             | 177 ++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst                   | 116 +++++++++++++++++
 doc/board/nxp/index.rst                       |   1 +
 include/configs/imx95_evk.h                   |  30 +++++
 16 files changed, 866 insertions(+)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..36169b56ef3075a5c243f7fb1afd6399b0df77ad
--- /dev/null
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
+};
+
+&lpuart1 {
+	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
+	clock-names = "ipg", "per";
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..bf6b31210e0d70674d6ce7c787ff7157a1cf65ed
--- /dev/null
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+/ {
+    binman {
+        multiple-images;
+
+        m33-oei-ddrfw {
+            pad-byte = <0x00>;
+            align-size = <0x8>;
+            filename = "m33-oei-ddrfw.bin";
+
+            oei-m33-ddr {
+                align-size = <0x4>;
+                filename = "oei-m33-ddr.bin";
+                type = "blob-ext";
+            };
+
+            imx-lpddr {
+                type = "nxp-header-ddrfw";
+
+                imx-lpddr-imem {
+                    filename = "lpddr5_imem_v202311.bin";
+                    type = "blob-ext";
+                };
+
+                imx-lpddr-dmem {
+                    filename = "lpddr5_dmem_v202311.bin";
+                    type = "blob-ext";
+                };
+            };
+
+            imx-lpddr-qb {
+                type = "nxp-header-ddrfw";
+
+                imx-lpddr-imem-qb {
+                    filename = "lpddr5_imem_qb_v202311.bin";
+                    type = "blob-ext";
+                };
+
+                imx-lpddr-dmem-qb {
+                    filename = "lpddr5_dmem_qb_v202311.bin";
+                    type = "blob-ext";
+                };
+            };
+        };
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+            spl {
+                align = <0x400>;
+                align-size = <0x400>;
+                type = "mkimage";
+                args = "-n spl/u-boot-spl.cfgout -T imx8image";
+            };
+
+            u-boot {
+                type = "mkimage";
+                args = "-n u-boot-container.cfgout -T imx8image";
+            };
+		};
+	};
+};
+
+&{/soc} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips2 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+};
+
+&gpio2 {
+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&osc_24m {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&clk_ext1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&sram0 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&scmi_buf0 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&scmi_buf1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&elemu3 {
+	compatible = "fsl,imx93-mu-s4";
+	status = "okay";
+	bootph-all;
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 596e753f2897c11d7ca3bcc9211af786d005bfd9..1ba277baeb353de301a1e67a7adf70f281752ded 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -66,6 +66,11 @@ config TARGET_PHYCORE_IMX93
 	select OF_BOARD_FIXUP
 	select OF_BOARD_SETUP
 
+config TARGET_IMX95_19X19_EVK
+	bool "imx95_19x19_evk"
+	select IMX95
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/freescale/imx91_evk/Kconfig"
@@ -73,6 +78,7 @@ source "board/freescale/imx93_evk/Kconfig"
 source "board/freescale/imx93_qsb/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
+source "board/freescale/imx95_evk/Kconfig"
 
 endif
 
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
new file mode 100644
index 0000000000000000000000000000000000000000..29f346e59c4afd0c2689667abe36f4b776b29ba8
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+CONTAINER
+IMAGE A55 bl31.bin 0x8a200000
+IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
\ No newline at end of file
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
new file mode 100644
index 0000000000000000000000000000000000000000..c90432f5efa78dccb2c67e237b88a96174446b96
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+APPEND mx95a0-ahab-container.img
+CONTAINER
+IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
+HOLD 0x10000
+IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
+IMAGE M33 m33_image.bin 0x1ffc0000
+IMAGE A55 spl/u-boot-spl.bin 0x20480000
+DUMMY_V2X 0x8b000000
\ No newline at end of file
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 8a7df24afecc1d6d77b7162be639b56af95fd975..38ade99964b64512ba93423efcaa0cfb58094b00 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -43,6 +43,7 @@
 #endif
 #include <spl.h>
 #include <mmc.h>
+#include <asm/arch/mu.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_evk/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..f9a67353e5db6d3ec94784cf091e45d8817d541c
--- /dev/null
+++ b/board/freescale/imx95_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX95_19X19_EVK
+
+config SYS_BOARD
+	default "imx95_evk"
+
+config SYS_VENDOR
+	default "freescale"
+
+config SYS_CONFIG_NAME
+	default "imx95_evk"
+
+endif
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..5caf763e0cc390c46fc54ee627bc966b2b110958
--- /dev/null
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX95 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/freescale/imx95_evk/
+F:	include/configs/imx95_evk.h
+F:	configs/imx95_19x19_evk_defconfig
diff --git a/board/freescale/imx95_evk/Makefile b/board/freescale/imx95_evk/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..a278d58ee0085176948b812703d120aaad3a3116
--- /dev/null
+++ b/board/freescale/imx95_evk/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2024 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx95_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_19x19_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..8d2b5dfcf07d251c77440bae44d62bff6253dfc7
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
@@ -0,0 +1,90 @@
+sec_boot=no
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcautodetect=yes
+mmcargs=setenv bootargs console=${console} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
\ No newline at end of file
diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
new file mode 100644
index 0000000000000000000000000000000000000000..c75a8f2450288a34cfc01150d3c42b07f2215491
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_evk.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <env.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/arch-imx9/ccm_regs.h>
+#include <asm/arch/clock.h>
+#include <fdt_support.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <miiphy.h>
+#include <netdev.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_early_init_f(void)
+{
+	/* UART1: A55, UART2: M33, UART3: M7 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+#ifdef CONFIG_ENV_IS_IN_MMC
+	board_late_mmc_env_init();
+#endif
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
new file mode 100644
index 0000000000000000000000000000000000000000..54f56c8049876fde335485a5c3bd54dff6e4f730
--- /dev/null
+++ b/board/freescale/imx95_evk/spl.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <command.h>
+#include <cpu_func.h>
+#include <clk.h>
+#include <hang.h>
+#include <image.h>
+#include <init.h>
+#include <log.h>
+#include <spl.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/syscounter.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/ccm_regs.h>
+#ifdef CONFIG_SCMI_FIRMWARE
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
+#endif
+#include <asm/arch/mu.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	puts("Normal Boot\n");
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	/* Will set ARM freq to max rate */
+	clock_init_late();
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..4d6b194528e7f3124e6626b28be0d6344758f6e5
--- /dev/null
+++ b/configs/imx95_19x19_evk_defconfig
@@ -0,0 +1,177 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
+CONFIG_SPL=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_ARCH_MISC_INIT=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_GPIO=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_POWER=y
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_CRC32=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SPI=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SF_DEFAULT_BUS=0
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHY=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
+CONFIG_HUSH_PARSER=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_SPL_I2C=y
+CONFIG_POWER_DOMAIN=y
+# SCMI options
+CONFIG_DM_MAILBOX=y
+CONFIG_SCMI_FIRMWARE=y
+CONFIG_SCMI_AGENT_SMCCC=n
+CONFIG_CLK_SCMI=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_SPL_CLK=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_FIRMWARE=y
+#CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_IMX_MU_MBOX=y
+CONFIG_IMX_MU_MBOX=y
+#CONFIG_REMOTEPROC_SCMI_LMM=y
+#CONFIG_CMD_REMOTEPROC=y
+# CONFIG_RESET_SCMI=y
+# CONFIG_DM_REGULATOR_SCMI=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCI_SCAN_SHOW=y
+CONFIG_CMD_PCI=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_PHYLIB=y
+CONFIG_PHYLIB_10G=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_FSL_ENETC=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_IMX8_ROMAPI=n
+CONFIG_CLK_CCF=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
new file mode 100644
index 0000000000000000000000000000000000000000..132c45ed485148366533ee31485a4d5a41556eb0
--- /dev/null
+++ b/doc/board/nxp/imx95_evk.rst
@@ -0,0 +1,116 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx95_evk
+=======================
+
+U-Boot for the NXP i.MX95 19x19 EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
+   $ chmod +x firmware-ele-imx-1.3.0-17945fc.bin
+   $ ./firmware-ele-imx-1.3.0-17945fc.bin
+   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4c33ab.bin
+   $ chmod +x firmware-imx-8.26-d4c33ab.bin
+   $ ./firmware-imx-8.26-d4c33ab.bin
+   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
+   $ cd imx-oei
+   $ make board=mx95lp5 oei=ddr DEBUG=1
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
+   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-sm.git
+   $ cd imx-sm
+   $ make config=mx95evk all
+   $ cp build/mx95evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.10
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ make PLAT=imx95 bl31
+   $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_19x19_evk_defconfig
+   $ make
+
+Copy imx-boot-imx95.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX95 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 8ca4b5619863f616dbedc7eb0ff8a286a3fbbf48..e7ec725cc04e9755ba3dac37561c26ebc3f1c716 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -15,6 +15,7 @@ NXP Semiconductors
    imx91_11x11_evk
    imx93_9x9_qsb
    imx93_11x11_evk
+   imx95_evk
    imxrt1020-evk
    imxrt1050-evk
    imxrt1170-evk
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
new file mode 100644
index 0000000000000000000000000000000000000000..00909a043a71751684ebd8dc413b05d5aee8dd69
--- /dev/null
+++ b/include/configs/imx95_evk.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __IMX95_EVK_H
+#define __IMX95_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_UBOOT_BASE	\
+	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+
+#define CFG_SYS_INIT_RAM_ADDR        0x90000000
+#define CFG_SYS_INIT_RAM_SIZE        0x200000
+
+#define CFG_SYS_SDRAM_BASE           0x90000000
+#define PHYS_SDRAM                      0x90000000
+/* Totally 16GB */
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB  - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+
+#define CFG_SYS_FSL_USDHC_NUM	2
+
+/* Using ULP WDOG for reset */
+#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
+
+#endif

-- 
2.34.1

