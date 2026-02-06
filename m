Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B135EE20A8
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F9583BD2;
	Fri,  6 Feb 2026 15:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PYhH0ZYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9102483BD2; Fri,  6 Feb 2026 15:14:14 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A163883B5E
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5UnjqUMKDDhq81IrFDrug9l8HbvEJyeVQb5a91+a1DrKslOOsdVz+ftgWLmy6ym5a/C0SulWhIY0H9IS+4ZiFeZ6u30AZzm3mbALFNzGRaRLz3NLK2JJlMLBnKlHMN/2tqb26Us6+NjXAJumbdjaUFqXmNPG0w5PrMg2fsOpSJr0w2XwipwUjSyeekv762jjbqIFQSL83HmzbUFyDExZVji4APs+UmE/Uu+zNoIhcIEeUhVwSjHVuOtdQ8oE+az0EhZnIfdLRRKJbqJC6gtoZg4sp+JMmpFWXYgqwgsom7WqrNAARBEsSI8jDMEIQsjcPXsINn8QAD1KViT6daveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpCJ6yvt/8FlPi/gjBAT/5u99o76NXI+GeiENkaFtFw=;
 b=ffX5rPrlzQRfzb+SYO2ZTKMWOT0Lg1SED2+T3gpI5iEqsu2CaFXaL9lVztgSEUJPcbfH7HAfFSL29JAVmLkbQh5XlThNlCVpNQRz+9VErc6gBfkiIxgoBfUJITXalnuvb0voU7ewK8kA7LnSrT6VO10OdlJuBRnkav5csqQ7Re6ndalrS238yt93hywxwm6glfauNU5uC3+fNKdD7TW1J3sgI3E+U+vFXX0PSExZMFOCSMu1tW6Q/9F7UQvoMglICOvYWboTuKxVRY6873D0rju1/x9hzk6q5IEmR6biPC7KyUlCipsUNDRESJR2cBJ7vanvkGh25Y/LQz2fEyVLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpCJ6yvt/8FlPi/gjBAT/5u99o76NXI+GeiENkaFtFw=;
 b=PYhH0ZYbCdewnks1fk7SLC/X4cLLbaxYE7rh6rkWGh3hWk6jcmJdghrIGdp8ZWR2YRUs1H8GNUs2vMmOIeA12oRCPOdrN7haJOfeVqKzMfJ6dcpl8FtNYzjzPDL/d0ssihWzLglcnRbjQRhbW/mmYm/gbtbY7l/Mwm/virErKvJ05zo0/NfJ+IqpXHXGEWgafq0FSn8IsjIUS4pYefawwQDMGLfL9ucitqp0CSVyRzLLFkLFf5mubk7D2KcdOg2MjwOauoUf0LFmHkjzGqbpiFg339oyGguKzo+pzn1GmwE70j6nI2p4GBllvc1TBUoCXxFTgNZ0qRA2tDcqUFJB3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 14:14:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:14:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Feb 2026 23:28:44 +0800
Subject: [PATCH v2 2/3] nxp: imx94_evk: Drop init_uart_clk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-imx9-board-clean-uart-v2-2-ebee8158586c@nxp.com>
References: <20260206-imx9-board-clean-uart-v2-0-ebee8158586c@nxp.com>
In-Reply-To: <20260206-imx9-board-clean-uart-v2-0-ebee8158586c@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 016544b1-4f6d-4185-c97b-08de6589ff21
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGhPeTB3VlFpSlhId01kbjFRU2V6VHZOWGIya08xWmdNTU45Wm0zM1hFZVpV?=
 =?utf-8?B?QjBGT3Y3TlcyN3MrQjNYK3lSRFdVNWlJK3M5ZEdGKzBodTlrOURyZGdkWGJ6?=
 =?utf-8?B?STVvU0ZLS2xjVmJBNGg1N3hteHp0MHFBbmNlVDVodkE2UVg5VXN0d2x0d2VW?=
 =?utf-8?B?dktVYjViQjlZajhrY0hCQlpXZVBnNWVJSkVUKzhpSWs2NnZtc3NIYitvTFNR?=
 =?utf-8?B?TmZ0d3NiV3NKeWVjSm1qNGVjazQ3SEdSSmluOVRKS0ZJQ2o4emNTVFNxRHBK?=
 =?utf-8?B?MTQ2ajRpbi9zNC9aK2N2QWNQenJWSkV1amZMZTZsWnRqZ0tkcE0vNGhRSy9C?=
 =?utf-8?B?L1NlQmEyV3ZqTjcxdE1melZtWUF6a1pVck4zbUowWjZKc2I3Q1I1NXdCRDRV?=
 =?utf-8?B?c3kzQUZHanRRdy9ScWs3ZnZRZjJINmcxMTZXa1dPb0Y4STEyQXlMblY4ZXJX?=
 =?utf-8?B?WWVmLzVVK09qVmxzNkUzYTdrdW91Ukt5Zm81eWR3VExZbkVhN0xwaEdmTTN4?=
 =?utf-8?B?RkRRWW1NWTFHVmkwSVVPMzhwYlU5K1pGMlVMK3FENW9NdWVQRzNkWjFPQlBJ?=
 =?utf-8?B?S3BEM3lKSmIrajltQ0hibzJGVWx3TDVCTkwyNUFNZVVieGVDSWxLUEE3UEQ5?=
 =?utf-8?B?T2oyZFp3SGViMHJLQThDV1lEajJOdExhbFdRM1ZaWHU5Z0FESTYyZi9mZ0lp?=
 =?utf-8?B?YzJ3WmhpQVYrRjlQS2xYeFQ0RzNvOW9UcHg4Y0s3OS9ibzF6d055a0RWV2Ey?=
 =?utf-8?B?eVY0dVdWWm5mVldRcXVpTnlqcUFUMUZZa2dwVUF5VEZWdW0yQ0JQRjVkZHZw?=
 =?utf-8?B?V1BiMlBPc2lHKzVtN2doSlA4Sk52ZWp2R2N1ZVJjZzNnT0lXbllmYlBKYnA5?=
 =?utf-8?B?dS9hVGk4ZUllSVE2dFc1NDRaNGtUVG9ndVZzR1l5bmk0QmdZREFwazk1VDlv?=
 =?utf-8?B?dW12ci9mYkVRWUpFbGdVUEFUN3pqQlg5V3UxZGVMQmRsTGhiZkRYMVp3OFBh?=
 =?utf-8?B?M0liNnJ5enE4TEFkWFBiNlBHRThTbmVYM3FpbUh4TXdvOWp5U1RYODJvSm9y?=
 =?utf-8?B?S0F4OEx1U01mTlhyNmhEYTFZSW01N20vRWpUU0hGOTRHSWI1YUNFc29TNFVS?=
 =?utf-8?B?NFJuYkJXbWdLUWdyVnJKKzQvNmxab3BwM2FDUkRWM2wyRmxCS3NBVUQ1cnQ1?=
 =?utf-8?B?RHk3QllEVm1KZUdvM1ZURmhoODhnVFZ0YkhlMi9WVFNjR1RZYVBNKzJGQ01R?=
 =?utf-8?B?bDB1Tk9hWFJuM3NzMW1Id1dHVkNuY2tYQ29vUkQrV282N0cvTkRPMW9OK1FW?=
 =?utf-8?B?cXV4Q2JsNklieW5FWkQxL0ZUNitWQldORTlTL1FKUkFTSzloL29TZ05BVXc0?=
 =?utf-8?B?Uy9FcmdXNmh6TWl5em5aY0N0dGZ2WTRqbEM0bjFBbUxhNVk1dXBvYVVvN2RH?=
 =?utf-8?B?TDIwOVowd2ZvcGFaS2NYeEk1TzVkM1lwMHNXbXAxWldqWGJmRnZoZ2w5MkRV?=
 =?utf-8?B?dWdTeGExUGhzQUdIR2VWblE3Mys1RVNWRzY4SG9aVzZTL05sZDIxV3J1SGFq?=
 =?utf-8?B?VzU3cmxFU0lwNktIUSsvZlk3azROelpoVXQzTWNXTHFrWWNUL294dVdqZFVP?=
 =?utf-8?B?S0Z3RGh1anVHZXJ2NWY4WDI3SnZpa0dxRkZXeDZZUHJxeVhXLzQ1Z21DeVFj?=
 =?utf-8?B?MDd4Mkxab0huZEcreW5lYVRuaGJaTnkxM3U3K1UveXBjU3NoK1pOSUlFbmlP?=
 =?utf-8?B?VXFHY3pLamdCOTQvb1M5U095T1JueVJlWFBzOTV5UjdXZWF3a1c4VTNxdUZu?=
 =?utf-8?B?VTRHZXdOdWhSNURUb1dkL2IrYXNnZlVMdHA1SHNnRjJFeS9QdG9OenJ3K2dY?=
 =?utf-8?B?WFcrOXdZRVAwM2g1QzV6UWsrSUZLV2JORXYrWjBhd01YenNPVTFKMVdkRVFG?=
 =?utf-8?B?TWl6T3J4SVZjTnp0d2JYZVo2c2xqQ2ZqeTJZZWNRaHJYSHd4ZU1GZDBMcllP?=
 =?utf-8?B?b3Nkb2ZmN1VlWlRTaHV4aFhybGpuNFFIL3NPYWhWL3NZV3pDK1VwQ3N1NUgy?=
 =?utf-8?B?YXBuckJMM2EzUGt5dC9jWmxFcUZvZHBBRUR5SnhJa1JQZG93eGRHRXN3SURR?=
 =?utf-8?B?YXR2elZBZHBiZGZmRnFvYlU4Sno2R1dlUlZkRnFMVXcwMmlydUNXV1p6YjF4?=
 =?utf-8?Q?ZQbruoVkrvFe+CBeie//jVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFYaDByMnNWUDgrSzBxUFZDZTZVUzNPQ0J2YTBxRHhlZ1o4SXNQc3VKQUVh?=
 =?utf-8?B?NlJ4cWd4QVNaQ24rTFhhd0hsdWtOQUhyVlZVNWNmSE01RHRQRHVJMGNhZDVN?=
 =?utf-8?B?a2tHK1hlRUszbkpQZHBCVXNtQVlKUUlvR1psdk5iNXhYd2MxcGRjRmFwTmhp?=
 =?utf-8?B?NHROblZpSmpQN3FzYi9tbVd0MlRnZVpFTEJwbkNZdGNQOGd5b2JWZG14c2Zp?=
 =?utf-8?B?QWVsNFhKYkdKUjNodS9ZeWZ1QkI1L0NtVDNqSzI2R2JnRWNLYklOMng1Qmh6?=
 =?utf-8?B?ZmI1OW5icG5NOGxHRmNKZWl1aDBSQU8wK1JpTisyUlpnRFErNHR6SDd2MGkz?=
 =?utf-8?B?bHJMY2pGcnVFVlMrQWZyckJGcy9QRWxSamdOdE4zZDFzSHFWY2xhN3BLc3Rr?=
 =?utf-8?B?b1RqdkNCd1loWTBUUTFLNlQ0ekVieVppdlJrY0J4c3pjZGk2TmxYa2xJVlEv?=
 =?utf-8?B?WmI4bUdwbFJ0R2gxdHZoc2lTTlZUTkpxUlRkeXlNem4yekJneXQrYThCUWU3?=
 =?utf-8?B?dVNCVzJkdVBjdmw3eFBXdTJyQjU5eEkrM0dyU0JsRzhqV01ZMnlHTTN1ZE44?=
 =?utf-8?B?a3VucWJoQngwM1BkRHAyc1ZPeDE0WE9RZldCMmcrUFBmMUliTmp0UGt1ZDlO?=
 =?utf-8?B?eUIraUhweXM0aitwbExRMXVPVmZ3bzZ4d2RMejZrQXo2TS9yNUc5NVlpNDFB?=
 =?utf-8?B?ZS9mMEI1bjRJblVwcFIwRG84MXB6WGFDWFFYN0RWSElTd3dDOXpFbXpwQlBw?=
 =?utf-8?B?c2tRazFTWTdCdDJBWlRCckZVdTkxWUc0eVdOZmpvdS8yc1hyY0c3YU0wMm4y?=
 =?utf-8?B?N2srVkl3a2I2b1hNb2FLVVJlNDR1YmhxN1NON3hISDhuQjVHMjkrWWN4eGZV?=
 =?utf-8?B?MDJBRHJpbnlQWU9BT3RyNnNLYVowVTM2dzZ5OEkrV0pRTWhneEtIcmZSU0w1?=
 =?utf-8?B?c05kWHZ5azdWY0FTSEtuYjRBL0x0MEd0a3JhczhJcUthVDBuZnJTT2JLZnY4?=
 =?utf-8?B?dFU3a1h4OFpPbU9uMC8vTzFmeng1RWNmWWYrR0tudzJ4TXZtSWNvZEZjVGhZ?=
 =?utf-8?B?KzZFMlZacXZ6US9QakFIMlVGNnAyUTFQeDJ3Qnk4cGdOdGFDVU05ZWdNemZT?=
 =?utf-8?B?ckZqT244eEMzWURKMExEMGhWZ0RXWjd1VVlRRGIxcE1RTmpqb1FFZjFoV2w0?=
 =?utf-8?B?Q0YxbktNTzRNb1R4WE0xRlBZMVpSMDU1NGl0ZjJOOWNSZ1o3dE1wanJBUUc5?=
 =?utf-8?B?WXBnL1kzc1JTbjBPVWpzYzdDays1YnVvdXJGWVV5bkR1ZnRZZWRNaUtLcnU1?=
 =?utf-8?B?dzBNT2JydFVaajIrZXhNRDdnYXA4ZXpmU3RHUDFpREhPUFk2em9zdGVxdWN5?=
 =?utf-8?B?RjNEWjZhTDZGeFl4VVhqK0g2dFB5dm5RZGFJL3hVU2Job1YwQ3VhZkFIWGpW?=
 =?utf-8?B?RE5aV2lpUVBkWUc0R2RlQUllWHBlWmNmRDJoeHIrRFI1TE4wc3EzeTl3UWNw?=
 =?utf-8?B?WkdmOWR0QldiL2I3bnZINE5LQUlSZG5KQngrd0pmUXUrKzZJUzNsODJxN1ZL?=
 =?utf-8?B?WkhpbUxYTFhOcEhMaGFmRVlJcUhjTlpYc3h5UFp2NGtwVGkvWkJzS0FHMk9E?=
 =?utf-8?B?K0RYVkI0Y0wzZlBPUkFrUEp0bHVDTytSTmNUVzhNS21UK1RQbkdLQWQxZGkv?=
 =?utf-8?B?VXFqeFJ4Q3ZRWUhEcmt0T3FYWUFJYjJ5TWtnbzFobjJkSDVOeEtxdkJibEhq?=
 =?utf-8?B?WWsyWlZBM2lRVFdrSDhHbjVwVGpZaHBJL2o3Um5ibTB0UFZGb1RZY29jNk9Z?=
 =?utf-8?B?VW1BK2hBMXRFMmNzbWk4dVFnbXA4Uk5NN0cwaFl5L0VBV2Z5N25PeEdXSEM2?=
 =?utf-8?B?bHVxVWJTdDB6WG5jWTFZUlduWGNzMFJpaTJSZmtGSWFyVzVLVVpHU2ZBTU1v?=
 =?utf-8?B?MHhWVmJKRTJnbWdtSkVvQkZ6dytSTXVnMU8yekZFTGlEQ0ZzbkMxUHgya0tP?=
 =?utf-8?B?TlpYZ2gyNVg2N2h5WGZsMjd1S2dva1pZTWQra1NJdXNjbGZhbnU5MjZ4YU1n?=
 =?utf-8?B?UlVBczJLNDZjdHh4NCtXdEJvVmdSa1pOalV0ekFWdlFVTmErQzAzMXgvU0hP?=
 =?utf-8?B?Qk5MYmliUEtTNDlwSW14cG5xZnZjRkhvVUtwNUNZL1AzZ0VNWFdPNERIb1dL?=
 =?utf-8?B?NElJa0svOWd1QW1YWGtoaWR2RmtkK0dXVUpGMjlqRDRXcnMzM0xsYWV3dmZE?=
 =?utf-8?B?b1RRb2Q1eXNqWjJDb25INzF0MFZObHF6YTRKVDhlNnNCNEtPL1R2ZjVWRFhK?=
 =?utf-8?B?OVg0K2RXK1JXVU5mV3VqUkZxT2lBc1RDZGpmVzBkckFqU1FpbTdkQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016544b1-4f6d-4185-c97b-08de6589ff21
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:14:09.9843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjaVmXOjmK63b+qUPlCqxfjsMxjhxEfSoV7NG0jc4fJpxZMGXj/r8qua2k2PuvEqL3OMCI4BstGp2z7Ul9V/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506
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

Rely on serial driver calling clk_enable to enable the lpuart clk, no
need to do init_uart_clk in board_early_init_f().

Also remove board_early_init_f(), because it is empty now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx94_evk/imx94_evk.c | 6 ------
 board/nxp/imx94_evk/spl.c       | 2 --
 configs/imx943_evk_defconfig    | 1 -
 3 files changed, 9 deletions(-)

diff --git a/board/nxp/imx94_evk/imx94_evk.c b/board/nxp/imx94_evk/imx94_evk.c
index 588aa7548d4..2aeb21c1de7 100644
--- a/board/nxp/imx94_evk/imx94_evk.c
+++ b/board/nxp/imx94_evk/imx94_evk.c
@@ -9,12 +9,6 @@
 #include <asm/arch/clock.h>
 #include <asm/mach-imx/sys_proto.h>
 
-int board_early_init_f(void)
-{
-	init_uart_clk(0);
-	return 0;
-}
-
 int board_init(void)
 {
 	return 0;
diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
index 797806a8d4d..cc5b7f9ef0f 100644
--- a/board/nxp/imx94_evk/spl.c
+++ b/board/nxp/imx94_evk/spl.c
@@ -69,8 +69,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	board_early_init_f();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 0371dbe28a9..ef4f9a8fcbc 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -37,7 +37,6 @@ CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx943-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x30000

-- 
2.51.0

