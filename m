Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F70E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B7B805E2;
	Thu,  9 Jan 2025 03:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ze684GxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F40368006D; Thu,  9 Jan 2025 03:23:16 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173428001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPl+uZzVMilXc6NcsSLGr3g3Sf6zfGteXfUPSR6PND+nE93+LWqv4HoXucYzaoNJ3a6fc3ISdxIs0Y3vPwdS+NzZYWPy7xj/eRf7uaMshVMcRcPaM4yuQr5OtFGv8M9aWei5jArPebyg42/6AYQApZnr//NLn7hAt3QRF9LntL2dY/sonjRm4ufStsb4Gga+FQhGZFnuAKqTI4T2xH9ljj07D1XUpso4DB6K2Q6lUyFC7/ONvkDSpStyfuVNHDHZb5VOxI2Jym4WN4KQGhaXYDvpiasJ95m2IPvMzFSui+k9wiw4CTqH4a4/VmSVghXKOFx/v8hLYgRaxulsPP9LOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mizIgukHJKztM9qPU/PIFUbwKtCu5BQ8Iu2o+fIJd2Y=;
 b=ABCDogktKvwbQ3aTAVg1HreKYftRJJOa4S5HHU7iBG0eSuVQ7u6RmT6vEHyCCsJ/gqetrBffbxy5TfXDoIXKkhIfq0nw4F/WNK007OGSQQwAO3jyUAZqvYxm/dP6ZXVbuj9ofiv3WqtRkkh1vqnLaPXJzzNutRnZlbzlFznju113nearRIDv8710sLZ9coS+TAsJncZaWlk6TGQj77oGGrG0wU95zUIfrw6h/omUyd1LEd0TtNFx/Sb+iIYDOH5Xc8oiISC4dlf9Y0rUZHb3tSUp+k2tOqzS8Ug1WGl5ja9CM5Agr6HS5KhPwtVv2IHu+R2YEHDjN8vKXj+vgTXNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mizIgukHJKztM9qPU/PIFUbwKtCu5BQ8Iu2o+fIJd2Y=;
 b=Ze684GxRF/de0zqqT7VQM8L3JwHKlmCAZe5Agh31kMdIqqtrvxTRNvOxajyWyWpFnbHH28doOC7mzwI33hA3gWi6C+FgL80bFBOSFoTz1HHoxVig0HemGV0Z5S3Eo+k3LcjzbqwyfsvympPWVOMUQu9jELYURwVGMQYif6r3/Hk96Dz4H0wmAdiYz4vCk4Z9Z8fiSGVXMjai+w0rvKgVWk1bqXmZQ90uJV+LfMRQE5upn58Cu5mK2YjG1DfiVqMHj6iC7BpJrRbe2wmI3Bj4wustT1T2TMMEooLri0PlwFioWMlUeZhh8FOCYULRkA+VBEqv9FHbXIvZ5Ux4Ln5H2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:10 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 00/17] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
Date: Thu, 09 Jan 2025 11:29:01 +0800
Message-Id: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1Cf2cC/1XMsQ6DIBSF4VcxzKXhokLp1PdoOghcK4NigBAb4
 7sXXVrHc5L/W0nE4DCSe7WSgNlF56cy6ktFzNBNb6TOlk044w3wGqgbF6q9TzFZ2mndc1TIrGx
 JKeaAvVsO7fkqe3Ax+fA58Az7uzstA9acnAyUUWRKwM0YsKJ9TMt8NX4ku5L5fynPJS+lkkKCB
 qEaY3/ltm1f7KFdtt4AAAA=
X-Change-ID: 20241231-imx-bootstd-abbf2e9e0d75
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f64eaf1-f801-4519-97cf-08dd30548fa5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N25ETmtKbmJGTUhIVnF6V0hBdGtBTHIrLzZnYTFaamd1VTlJS0dhQUVFYmFp?=
 =?utf-8?B?anMzOWhYNnc1K0s5Qno5aFl6ZGhrcjZxa3VmT0V5cFQ1UnBFUHRIL2RVVk1n?=
 =?utf-8?B?Q2xTbXh3ZE5qejB0WGFYbTByMEZoaWJSb012TkxXWDYrdzQwS3ZBMnBwRjQv?=
 =?utf-8?B?MUhvYjU5eXNQODhoSU1IL3NtMEtmUDlOc3laYVc2NmZhb3NJNDZmV2ZrWTA0?=
 =?utf-8?B?bVo1emRCcEs4V0JsMnFJUVh0Z0lsckJuYWd6SzZnM1VlcnRUcG9XTnYrM05Q?=
 =?utf-8?B?TDNRYllGc1JoYm9lRGV0bkFyOE9keTd4NjRVNS9lKzU4ZGpyNjJUaHJTbytJ?=
 =?utf-8?B?dTcva29lSnhyb3lwM1pTa2xuSENGRHcrb21wL2wrc09tMGNRTmROSFJIdVVZ?=
 =?utf-8?B?UEVjRG1kSGRxSlozeWp4UXhRdzdKcTVtV3lzSmcwT2pPT3Q1RXV5OWdqUEtn?=
 =?utf-8?B?elhobmh5ZTRFRGh4dGpza0xUSkRYSFNocHo4elFnUlFZSTRUYXVPWnd5VlMw?=
 =?utf-8?B?RzFWNVpBVGFHMkUzU3c3cWNmb04zaTdFeERZZVN5MytCOUc0RzVJK01mS1Jj?=
 =?utf-8?B?TUZtRnNTQm9jQSsxWTdQWnpIUFRRQW9GSkJaaGdoZFdyYzhXNFNScGtIU3lY?=
 =?utf-8?B?aER0MUNlWlkvL3lUOGQwbjNFVU9jc3dOL1FGMU5WcXpCNUtQQnFZZzBoQWlo?=
 =?utf-8?B?M2Q4YllqMWUyTXB6bnF1WkprVGY3cEllcE9KclBqRUZkQVMvM3c0WXBYVXRt?=
 =?utf-8?B?ZGxrRDZkek1NNktZTUpodXFHaGtVQjhZcGFHcUhBMzVIMWE3YkxnRi82S1pZ?=
 =?utf-8?B?QmJiRDNSZExPTHhqcjFIUlVkUWQrN0ZVNGlnYlhXRUE4MVEwU0l3THVkeEdq?=
 =?utf-8?B?dlVVWmx4UzF1U1pyRFNzSVVCclBxc0RHdlk5ZXBpcXBLajEwWjA0V3ZPV3Fr?=
 =?utf-8?B?Wm1WNFVURFI3dE14REZsY1hlcEJNclA2LzNsdDN5ZktJTW4rNWdBUmdEUzQ2?=
 =?utf-8?B?dEdPTHE3L0VHLzEwdmp3TW95UldZZUxDMXpINUd6WG9pdm9xaHVHN3RZdzE3?=
 =?utf-8?B?bzBiRVhXNHdpc0ZqNXpzVWN6eEJidVZ2QWoxTHZ1WmZqaytqcFRON2pJUkJV?=
 =?utf-8?B?Ym5PUVU3ODBLYStHYzRqMFVSRnl1S0s3TTROUTFmZi9QZTBEQTgyVVA4Z3B0?=
 =?utf-8?B?RlpZVFVIbGU4eFRZZU81UnlaRWpsWmNralh2V05tbXhKbjQ0OVVkREt3eGZW?=
 =?utf-8?B?OUI5QUJKK2ZHMjZadWhBbXlnNU1VMFpza1lOeEJ0YXZkUmN1dExScnRCT3JJ?=
 =?utf-8?B?SFQ5TlB2NkRWWlNFWUVlaWN2U1dyRVlOYks3L0kwRTBXZW1ZTzJKK1pnZmJL?=
 =?utf-8?B?UlN0RW1IL3ZlWHlLQ2tRd25FMnIraVJmMnFqOWtRcWM1NXhrQ2JtUG0xdkNR?=
 =?utf-8?B?SDBWTUk3akVoVVVuSDFnK29FdVZnZkRGY0dWL0wwWk85ZndUT0FISE9kcmN3?=
 =?utf-8?B?TWorMndNY29Fd3dsbGlTYXgvRTNQRHpLZEpsZ3BZRGFQNEwrMk1SSUJ2cHZQ?=
 =?utf-8?B?QnI0Tkxlem1kZjlrKzlSZERrV2NvbC9PakZhNitHdldGNXdORDlaZHlOQ1FW?=
 =?utf-8?B?TWgyRDkxSzBYVTJ3NUU5M1NDVm5WdlBLanRqRG91eWhWeitaUElKK3oxQmJC?=
 =?utf-8?B?aVFaaUFNQ1luR1p2eUJuUnhKakRXRkdWWmVEZTFxdER5MkNVTHZzd291UDJ0?=
 =?utf-8?B?ZmJNNm01R2tMNEhwMlB3M0lvT0llYzFGbjVnempsYURTelJ4RGVYZ1A3YmM1?=
 =?utf-8?B?WUV4a0NvSlhyL0Z0MW1xV05sWUx6VjZML0h3OG05MzUzUWFrSk5Wb0k1MmJE?=
 =?utf-8?B?VEhPM3QwQ3N4a2lZemQwOXpBK2RSVU5lZERHN1IyKzYvRUQ0Wit6bFZPVkFq?=
 =?utf-8?B?MmxiS3RqNzVJeEhDQXF4aTMrVUNDT0lCQmVCa1J2bzEya1pBT3YrNG9ZVjNm?=
 =?utf-8?B?SXphdTJYZGJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZuSUhHSm1qKy9kdThrcVI4VFd0ZUpmclVPVXlVbURaYTlaQnJ3TFN6ZGkr?=
 =?utf-8?B?bXZIUjJlNFVDRmo3LzdkSnQzMmVUaTNkRk1aQ3lkdjVlYnBZMGMyT1ppWlV4?=
 =?utf-8?B?RGYreC9ramF4eG9PMDhVVC96Q2I0MXpocXZpWEkzZ1FwOFVsR3ZyY2RLM2xh?=
 =?utf-8?B?bEwrdU4vOThsdWRBdXBibUlnNmpkcVBIbktBeklpQXg1M0xPZS9VVDNIajdq?=
 =?utf-8?B?czlWTTJrb3g5V0dYclhDUjduVXY1RHNkRGw3SzZuQnpHQ1JQM2Z4WjRkSGpl?=
 =?utf-8?B?a2Q5TUhKQXRzZ1hMaDZRYmRoT0RqZk1BRzRCMEhqS1dheFNmVDZOa2lsblNF?=
 =?utf-8?B?TUFET3JlVU9URERVcDYrUGdTTlFZV2xjb2U5R3VoZzNuNnRPWkRtZGc1V3px?=
 =?utf-8?B?YnIzeFBqUFFIa3NlWEcxdGJXcVRVVEN3aTAyTS9RbHZaRFhYREh4VVh6Vkhs?=
 =?utf-8?B?YmRoNFR4K01iMDFYZFBOZE1EOVB3RXJxUVZja29jTXZEaVlIMFVlZmRDS2xE?=
 =?utf-8?B?UW5jdzBTT2s5SXl6NHlSS2hLODFhL1lxdnMrOEYrd2JXVlhSU3ZYVnhBOHlG?=
 =?utf-8?B?RS9RUENkSTRick1LREcvQ1pmSXZUcUFtbmUyNmRCUE9Jb0N5dlh4dW8zb3I0?=
 =?utf-8?B?WVZHMElaRDVlaWRVOGFvV3FFZEs3OWxxaW1tN1UzK0N4TlNQUmN5M09BL1Ft?=
 =?utf-8?B?dmI2NnlGMlNPK2piQWhKdzh0RUhsOVBGdjRvVTdrRjNNUzBBbjd0MC9YVzZT?=
 =?utf-8?B?b0lyU0ExRHg4WjBOYWdMRWoveGFNdjR5UGdxdFVRYjlsZlJORVdBd1FVYlpN?=
 =?utf-8?B?Q2s0dkxZQWw4c1pxZmZMT00xZEsyc05hQ0g4aG1MajdjUitKN3UvOHRoTWds?=
 =?utf-8?B?VHpHczQ3TTFHMkVtWmFDSDRyeTI4bVJjcU9SY3pmWGZkaWY3UjVwa1QvUHpL?=
 =?utf-8?B?NkdWQTg4ZXcydndVZzNXcDYvZEhpcldwSW1IVVQ2SlZEUlFSa0xuQTBWRGhG?=
 =?utf-8?B?OGtVcEdQOGd1QmhoT0NqWGNnaUFkVzl2czY5R2ZyUnVWV2NaL0I0SHJDcUZW?=
 =?utf-8?B?U0h0N0FFL0hqTkF3WWRZbzQ0dHowbFZEeTBjSExQNXdpcmFrYjAzT213N1Nm?=
 =?utf-8?B?eHNSRDdJMCtuMkNrbDlkdEpVTGFSVks2bFZCY2ZqNnFFYWJFQzlHZS9tQjht?=
 =?utf-8?B?S1FIamR0KzVRdU5VakQrRzI1UUFjNGdObnhaQ0xPenJSU2p6bU5rdmZXaE03?=
 =?utf-8?B?MGFHK3JBODVKengzdkdBNTdudTNkb2R2RFBMR3FYTHlhV2pvQ2hjeDRLclYw?=
 =?utf-8?B?d3JLNThXWGZETC91U0hTTFVUQmJ4ZHV4VUZURXhkaGhLUlhNSFcxZEkxL2x6?=
 =?utf-8?B?TVhxZDB3MXp4a2FXV2NuV1BhcmdrcWZlelFnVktQZE1KSkswS2ZTTEVLWjVu?=
 =?utf-8?B?Ym9mNDJicC9COTJUdnFhOWxPSUZwaTI5QVQ3bGFJb01RZGttR3R6Mkt6aWpw?=
 =?utf-8?B?TnlqQmE0NzVoSlhXc2VKRGRLWUZEZlJlYkFWdWZJL0I5QVIxYmYrQ0dJZ0FC?=
 =?utf-8?B?dk5oZ0RxN1IrbllraW4wNWVaV3lTUWM5ODd1eEtXdjlhOHlBd0E1K3Rad054?=
 =?utf-8?B?amI0Zy9oU1doSDZzUHh6VFlLdmVWd2YxQ2t2KzZvQ3JPbGN0YW9ET0Y1U25L?=
 =?utf-8?B?TXZWMkhMUjRBQnB3cVZ1eGE0QW01bHpUbWdlSm1kT0pkK1NHUnpSTmYxRlI3?=
 =?utf-8?B?eVpFVzYxOUVOb2EyeUhHT2tiZ01aa29FVnNZREgvMXNPSzZPL01ZcG9BZUJQ?=
 =?utf-8?B?RHVPdTBrWmdXQlIvQUhMaEZsSE00anQzQjhzVVU1bkRoM0JsZDhOWnUzR0FQ?=
 =?utf-8?B?TWpZRWI3VGpGN2dlWlZOUmlMKzBaOXl2MFM2bWREVU1KeTFmeHY3Ukp5RlRn?=
 =?utf-8?B?RlF6UG9LVnNlRERJOW1HM1VEMXlKR3hRWmtPS01UN3M1YWxvaGl1ZlBBaHZQ?=
 =?utf-8?B?UnJFQ0MvbmNlWnZIVFNQNFpjMjJRa1hMQzc1aXdLSmx3RU1ETW1jUFVVZEUy?=
 =?utf-8?B?UGxSTjlydStENEYyL2tBZklzRW9XRHJtU1VsaGpkVmg0cmlkbGorZ2pZTEgy?=
 =?utf-8?Q?R1Ubxm5CkLh0xauFO58SRcEAS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f64eaf1-f801-4519-97cf-08dd30548fa5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:10.4627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPpjeUHm73YVMMWTnhBlENXZbkV5MumSCgqe+F3Jkcg9t6kQxzMFAKH0VyhqTjsMITmpshObl56Emj5n9NOa8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd as fallback.

Some cleanups are also included together with this patchset

CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=17&view=results

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Separate driver and dts changes for patch16 in V2
- Link to v2: https://lore.kernel.org/r/20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com

Changes in v2:
- Separate cleanup headers to separate patch
- Separate drop global data to separate patch
- Drop CONFIG_ENV_SOURCE_FILE since same as default
- Link to v1: https://lore.kernel.org/r/20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com

---
Peng Fan (17):
      imx: imx93_evk: switch to BOOTSTD
      imx: imx93_qsb: switch to BOOTSTD
      imx: imx91_evk: switch to BOOTSTD
      imx: imx8mp_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mp_evk: Switch to BOOTSTD
      imx: imx8mn_evk: Cleanup headers
      imx: imx8mn_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx: imx8mn_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mn_evk: Switch to BOOTSTD
      imx: imx8mm_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mm_evk: Switch to BOOTSTD
      imx: imx8mq_evk: Cleanup headers
      imx: imx8mq_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx: imx8mq_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mq_evk: Switch to BOOTSTD
      imx: imx93-11x11-evk: drop duplicated nodes
      gpio: adp5585: Update compatible string

 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi     | 118 ---------------------------
 arch/arm/mach-imx/imx8m/Kconfig              |   8 ++
 arch/arm/mach-imx/imx9/Kconfig               |   6 ++
 board/freescale/common/Makefile              |   2 +-
 board/freescale/imx8mm_evk/imx8mm_evk.c      |   3 +
 board/freescale/imx8mm_evk/imx8mm_evk.env    |  67 +++++++++++++++
 board/freescale/imx8mn_evk/imx8mn_evk.c      |  12 +--
 board/freescale/imx8mn_evk/imx8mn_evk.env    |  67 +++++++++++++++
 board/freescale/imx8mp_evk/imx8mp_evk.c      |   5 ++
 board/freescale/imx8mp_evk/imx8mp_evk.env    |  57 +++++++++++++
 board/freescale/imx8mq_evk/imx8mq_evk.c      |  29 ++-----
 board/freescale/imx8mq_evk/imx8mq_evk.env    |  60 ++++++++++++++
 board/freescale/imx91_evk/imx91_evk.env      |  29 ++++++-
 board/freescale/imx93_evk/imx93_evk.env      |  88 ++++++++++++++++++++
 board/freescale/imx93_qsb/imx93_qsb.env      |  29 ++++++-
 configs/imx8mm_evk_defconfig                 |   3 +-
 configs/imx8mm_evk_fspi_defconfig            |   4 +-
 configs/imx8mn_evk_defconfig                 |   2 +-
 configs/imx8mp_evk_defconfig                 |   2 +-
 configs/imx8mq_evk_defconfig                 |   3 +-
 configs/imx91_11x11_evk_defconfig            |   3 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig |   3 +-
 configs/imx93_11x11_evk_defconfig            |   2 +-
 configs/imx93_9x9_qsb_defconfig              |   3 +-
 configs/imx93_9x9_qsb_inline_ecc_defconfig   |   3 +-
 drivers/gpio/adp5585_gpio.c                  |   2 +-
 include/configs/imx8mm_evk.h                 |  22 -----
 include/configs/imx8mn_evk.h                 |  30 -------
 include/configs/imx8mp_evk.h                 |  21 -----
 include/configs/imx8mq_evk.h                 |  22 -----
 include/configs/imx93_evk.h                  | 105 ------------------------
 31 files changed, 444 insertions(+), 366 deletions(-)
---
base-commit: ec9263b4f15c4cf82eb6a211c67baa6385065b8e
change-id: 20241231-imx-bootstd-abbf2e9e0d75

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

