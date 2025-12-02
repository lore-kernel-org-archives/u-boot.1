Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C31D116F1
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 02:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1D983DEB;
	Tue,  2 Dec 2025 03:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="mtA/pXRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8786683DEC; Tue,  2 Dec 2025 03:36:38 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8938883DB6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 03:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBO6RhzgL0av3Uyn4Ls+7TdkEUzfTN42qqD3zTs7lGv9aNGEAnprAShP1yv4BckaZiSb1LKncto45jfw34ddNAnFLlwa+IDFyk4CUCJOYi6tv4yiCd6duKnuupfTe/UryMLAKpokgD9gR3TocT17DOoIpBALCbF7U9KcSCEON9pBRsCw5gp1lUcsDDFXs7bEueknfrHzBkcDGyfOHfDiYCxasqLOj58/QkL6UbFsjQ06JaPBCWUyIwAqkUMej6eR+qs2rNIa4oP7BySbqSMYAGyhsuSkkAc7EQHigxXf4kTVjDX36WP5cp5yfivNqK6X6g4wESdqDfymkqvbpmxvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46K7fy+iNxScAxT/uuatgmUqchtQBgHsO/3JDRdtQA8=;
 b=NYNqknys3rvx19BgDE8N7rTO/e2PVAKYv3tTRwG3zOEUtVPK7l33ArGxYh8eKdxa+KB4LXTIAuhwcFN/dXIFrThAe/x4C8eqZm0rz78WN6yPp/wuaOM3hLbHOwjAAvTfoWuG4rO6T2UvKBfYpCgUoAm5z7BDmKNHfJWrc90nGxOPiFiahcOFICRgt0oUeXXmiPhgaf/SlA+VTGXNvO8oC+UahTy6kya2VYEgPu3TQVYyC8weiknAapgxby3MF5cC15ehuBGHarZ8T1G2KaeK5Zjb8y7mjhxnkdPkvlU8lbxW6RcEPtI5dpgw7LyQCo+xx+bhyFTBS4myC7KVVAODPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46K7fy+iNxScAxT/uuatgmUqchtQBgHsO/3JDRdtQA8=;
 b=mtA/pXRsP7HpG/gJOFi0ib2Gz49K5sHiCsi/zoD4zCnNZZvSW1D5km0kPxx+lRUmflhfiCpYkQYpfsSMUK9xVDplgrNvUJzT4y7iAskdijrbGAvvQtvjokkJjjzIOTiyvpuJpwYFzHHop8IbqXDljIos0eD/Mf5QC2PojLk+D5GsOi7jLwg3UipDQ2P/XN/CMK/YjqITQ/zkL0iVl/SvoJD+/v17J/eYVyvo3OoVdkn3LdkLadlZY0WK2pNKf8ASepL5EOo4/LSVpqsohIBl3dKlP9SmF3JfnAePhr44p+IYBoffGwba7/53TTI9menWiSDP8jZtMbKfgUz5iResFA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by MRWPR04MB11520.eurprd04.prod.outlook.com (2603:10a6:501:75::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 02:36:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 02:36:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Joseph Guo <qijian.guo@nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, Adam Ford
 <aford173@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Mathieu
 Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: RE: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Thread-Topic: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Thread-Index: AQHcX4PqFDJT+6oYvEeFUAwT4nevIrUNKvKAgAB9BgCAAAFHAIAAAFHw
Date: Tue, 2 Dec 2025 02:36:34 +0000
Message-ID: <PAXPR04MB8459355C0CE42DFCB11B17E588D8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <CAOMZO5Dxi52OzFEBWU1hnn2HfHc9EZcgmwW=p-N-+Oy+JHQBHg@mail.gmail.com>
 <aS5PECe5b8576MTk@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
 <CAOMZO5CbYn544xKUb6QApg0bzc_cQEqqTSSC1r9SUgyfpQGSEA@mail.gmail.com>
In-Reply-To: <CAOMZO5CbYn544xKUb6QApg0bzc_cQEqqTSSC1r9SUgyfpQGSEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|MRWPR04MB11520:EE_
x-ms-office365-filtering-correlation-id: e8efcd63-79c3-43db-adb2-08de314b9c2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZVJiZTJMSk5SYWV4cVJYWUl1aHNoNTY4NC9nRlFycGMwZmFZV3JCSTFFMThD?=
 =?utf-8?B?YVVWcHV4QnZIWlAzcHJTUU81YUN6RGx0emx0UlVIV2VZTG1Id0tWd1A0VTQ3?=
 =?utf-8?B?K1J5WGVXZVZ6K1dUVlRrU3Fmeml2YkVhc1lna3Q3cmN2bjZUYjhXcStQcjBU?=
 =?utf-8?B?N3Z2TUEzcHkzMWpONUVzWENPdndraWluZGxlL1E2bk1CNFB5UFlydmxicWQr?=
 =?utf-8?B?QVlEWi9XS1RXcjBmU2lmNVY2WExzdDk2bHRrSmZuazZMRmxnY2g4QXVSazFp?=
 =?utf-8?B?VksrRkwyV0hHcTFFQytNSHR4cVBoQXBCdHBaMlJEeUNkNnpYR0lvOHJ6Vmpn?=
 =?utf-8?B?MlFmM1hoaEdFRi9LdmlwdWhqL0psdXV4RXRQem1HY3Vvc2NtSzJOZVlyVW9F?=
 =?utf-8?B?cUs0eGxSeWJCbTdhWUs3aGsvWmIvU3lpTlV0WjlRdzk4NzZLTkFTM3hsYmhn?=
 =?utf-8?B?cnFZVDE5Y0ZUQjA2L2VieDRnWXRvbWlrMS9YUU9KK094VjRBeWt0QlV4NWpq?=
 =?utf-8?B?WTd1aXpiQ2x6eTRtQi9TYTNSVTdkalFGZ0tjVWora3FwM2RudWo4WldXRTNP?=
 =?utf-8?B?a21FN3NzaUtValZJWXRrQXEzaHVzVXFXaXVFbnEyOU1GZUVoWUZyNmxqRmRi?=
 =?utf-8?B?TzEzd1JITForSjRDSzJEbUZiRk96RnVHcGhkTWpVSisrVlhSOVF4d1d5VGlC?=
 =?utf-8?B?OUFxVzBKb3NwczN6cG9vRG1NZ3NwdGIwNGozTWt4V0JOU1NJZm5jbmRLaHhD?=
 =?utf-8?B?cW5XOEk1NFluclJFT1U2M0p6SGx2d0o1ZytuSXVaZysrUEJDdzRubVh6Rnph?=
 =?utf-8?B?MzdRMUV0bDhGMEs5V1ZUTXcyY2tCcGg3MTFaK1JDMXIxcjlTWUFGdUxvZExT?=
 =?utf-8?B?U2IrQStmaCtYMzB5Wlhsa043b1ZBeUN6d3k5RmhJVGxyaDl2ekdZcDBxSEZ2?=
 =?utf-8?B?YVNIaUYvK1NvOWMwY3FsZUNxZFJnZ05WVEpydE4rc29BTkRFeXpDRGt6UE1l?=
 =?utf-8?B?NnRaT3JiWUZyb1JUMEpIMytNTmIxV2FXd3RTd2c1MXk5MWNNWUlRUko5ZnFm?=
 =?utf-8?B?SVJBa3lrQVlvS1pNSFZyWnRKYUNHMFB3ZU0xYXQwb1NybDAvZUttaEVVZ3Va?=
 =?utf-8?B?NHJ6N2R2QUtDbnptVlExZDhRMmo5RGMzd3QrQjIxSEM0TE5MMUtaTnRoWWUv?=
 =?utf-8?B?WFlFVVVqVFRYN2Jra3NjSG5kSkpvWFJpdnRtL3hLME5yenlhNUpNRkRaRGwv?=
 =?utf-8?B?UFQxZW9FVGRwbFhGSHUwbzN1eWkyRitEcUpqZ3FWRW1MYUZnREh3WUJrYTZS?=
 =?utf-8?B?S25YMDlYQ2dyZVZlWkJiQmJlM1hWVnRlYWpJanJoMEtITjd6MVI5UGxySGJv?=
 =?utf-8?B?ZHo1bFJiM0N3b2hCRmZQNitwRk51WHYwbVJyMVdRVWRnRVhNcGYxZ1paYTlj?=
 =?utf-8?B?amlCdE9nT0ZSQW1jMTFBb2huaFR5c3ZPTitYZG1jVnBFU3lqYmgxM0tuT1pt?=
 =?utf-8?B?bTdlK0w3OVR3Vzl3QjY3UlI0VFA0eXJnVm5oWjRKWDVzN2xlWWV0a1ExWFll?=
 =?utf-8?B?TklIOU5aYjlYdlVza3dxQ3J3RnF0QjdvaU9ySjJTSURJb3ZQVFBDMlp6dllI?=
 =?utf-8?B?ZnFyK1FzQ0dxcGFQL0hmN2tWS2hBU3RVcG5ZZDlOM3hVRDYrVjljcDc5eEpz?=
 =?utf-8?B?ekZzZ1RuT1VpWGk3Tkw3MklRVk5pYm5oYjdIK0dpdkZXdTlDdDMyY0RydnIy?=
 =?utf-8?B?eVJnVnR4aTN2Q2tDaWVGc0p0b3hCS21oZ0g5a3gyYlJaL1o0NVJBTjE4RTlV?=
 =?utf-8?B?ZW0wR0N4QktuTThuTm9uZC9sUy9admJ6MjdnOGJnb1F6UkNqa01RQkhVcXRp?=
 =?utf-8?B?QUwzV21wcnhFU1RXYk5xSmZXSXZGS21TazNOTUVjTEZWQTJVdVhjanNRdTND?=
 =?utf-8?B?bmlqY3hsNEozaGhWWFdTellGamk3NWV5ZHBaYnJwa29jK3MwK0QrclpMbHJp?=
 =?utf-8?B?K2UreCsxZkowNEF2MmM1blBsOXg3dzVkdlAvc2RhZkMyR2NzMVNwQWYxQ0ZR?=
 =?utf-8?Q?lAhEZh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFNvdGcrTVByRnBmM0N0TmhvZkNQVTMxVktyTGM2Q3FOc0FYaEF3YndFa3l0?=
 =?utf-8?B?Sk1nbXFTRjdlcXArdGc1ZWpJRjVCakROa0x0N0FSUzQraXhaVkFqbXBLWnVq?=
 =?utf-8?B?NklEckNLS0FRTVFtUDI3b3d5WGpia3pLSmJrYlhCZjNwcGtEdnJFMnRSTG9Z?=
 =?utf-8?B?V1BTaFJRc3B0NkhEZWJMWDRnUHNBNnVFS3BFdmg0S1hpQzJNSlJPNG9aNUt3?=
 =?utf-8?B?T2ZpVFFOdE9GRVBDbTZYVXJBa3V0Wm1nN1pUZ2JsR3oxM25tR0l4ZzFLLzhK?=
 =?utf-8?B?MzU0ZldkWndEZnI4cnVWenptUm9ad0JweHFvZE1zdnpjNm1BclRZNncvdExU?=
 =?utf-8?B?TFhIQWxjSkxZdlpwVUkyT3N0djZaQ29YeU1QWSt1R2tOV0tVTzFYZHBWVDdO?=
 =?utf-8?B?djFaRTFGTWhxYnAwVnlNeEVYUlF5Y3Q1aXphUHBET25YbllJQTRXMDFtUkpZ?=
 =?utf-8?B?dXdvdWpKVVEwVVpFMEpLdEFBaWFlV0FZcTVMU3JFRFNPUm05NTkrN2hZVjF6?=
 =?utf-8?B?c1lFeDRCYmdkUTFJd0hzMlAzWnZ4eUdGK3VRREUvenI1MmpDelZyd1p2TVV2?=
 =?utf-8?B?WFNpWjhlZXlneUE3STRxUWlVc0tkVUx1MHZ0QkFWRXdoVkV4WGI1SXlDdldo?=
 =?utf-8?B?RnNPY2UwbVo2L2cxa3Nobyt2TE1NRzRleUo3NG1UaFRlckhwdnhPb2Q3UUNW?=
 =?utf-8?B?dVBFeHdRdk9PM29tYUl1NXlRNTBFNHlnMWxkQkpXM3NaazM2cTNHcjlyYWFu?=
 =?utf-8?B?MXFPYTlBQWt2dkZBZzJPU3o0cXVnMSs5UUdYS3FQZVlXNEtoK3pNbXdRR2I3?=
 =?utf-8?B?RThNOWNBaSt2UVpzRHI5eUdzaDZvblU2VzlGT1ZxaW55dHlhYzFPRUs0Nkt1?=
 =?utf-8?B?VWRKZXU5d3FNUnVoeU82WXhVbXczcWlzMit0NzRmdnJ3SzYwZlFEY0xQZEtC?=
 =?utf-8?B?bDYyZXV5NlYyampNdEdjbDNCRnlnQWhITy9DdWxvbGFuamY3Z0N5MmpGVHUw?=
 =?utf-8?B?NEdQRUh5Qm5hTHdFdjlMSGRrVHkwQm4yOTN1WkFWdzBqTTBqRHYwL08rejJX?=
 =?utf-8?B?QWtwMm9rOFlaV2NyT1R3c1ZWWWQrMGVKTE4wY3ZVdzUzYWcwL2lhWGEzUGp3?=
 =?utf-8?B?WDhoNFFGUkoyZlRUK0drMHllZzJtTEJWUm9GajFsOVNmUUZMWnMxaUdpRUJw?=
 =?utf-8?B?MmgxVG8zVEdIWUN6RS8rUzJEd1ByV3NIZGJReDd5akpEYWtSSktBL2RwQUE0?=
 =?utf-8?B?V2Z4M3JjbGhHUGhvN3h6NC9weDNVRW5qQ3RlUjdsY2hGTC9hRm5uUEVyTExo?=
 =?utf-8?B?cFFOSEp4RHNLWnpkSlhnbnQ0UklJUm5LUlgzUk9yNk9EQnBNelFvNHV0Y083?=
 =?utf-8?B?RE9va2RaU1Y0Smx3aVVNVzBaUnJpSy9mUmZjVy9rUFZ5bDBrMHdzOFpBZVdt?=
 =?utf-8?B?QVNraldnMU9lYXgyOFlQaitleEtHRU9TaGxsRjgyZWJ2VWQrYmR1SE5vdjhi?=
 =?utf-8?B?aEgwY3poU0syN0h5UDExa2ZVanA0Qjl2RTRuS05kMFZKbnB0N2ZOa2dwK3pR?=
 =?utf-8?B?ZUptaTZUcVJNbWZZWXV4TCtrQi9JZytxTVlVOGpTZ2gvU21BaHJRNUlabjl4?=
 =?utf-8?B?WnBEL1A0Y0UwZEZBakYyWmpwbWhUaWZkZTVORERxSnMxdnljbW9PWnJwbmhJ?=
 =?utf-8?B?SlZXL3VUd2doUDFaZllQSjl4dWNQYktoZjNiaVNiY0RXWVRUM1VBRjk3b3Y3?=
 =?utf-8?B?cUZCZmcrODBTNmFQZ1BpemovMk8wNUhLSG5OQjF1bm9Zb3A4ak9BTWY5dEVK?=
 =?utf-8?B?anFjaFQrSEFuT2dyWkhRc2dUbW5YNTFGVXZpeGI2eWpRcVp3Vk1IQWpwVlc0?=
 =?utf-8?B?bHhTdDNFd3plUXZhNGNpQlRiYzNmYUlPS3ZxN3cwK0FmQ001QzZHZG5PZFZh?=
 =?utf-8?B?b0lGWXJyZlBRd3hobEc2Z1N0aDk1MFRzRGprZE9iT21GSWJITk1hSUVkQ2pa?=
 =?utf-8?B?Qk1jMksrTUZVL21YT2RGY2N0aWFvN25nTjkydkVxUTFNWjUwUDNvWGJQK1BE?=
 =?utf-8?B?cENucGhkbndWVmF4cTNqdUxCU3Z0dGFvS0t3NG1zdDZaN1AvY0dnZC8zTDdV?=
 =?utf-8?Q?XgM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8efcd63-79c3-43db-adb2-08de314b9c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 02:36:34.5276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kb9aIome9io+xDuSrG9CL5q29ssSNbaHGBhfIiSaSDXYhGeWMGUUGQaHuRGBo6Kzl6e+6OI8eHlHCTt5H8Smhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11520
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

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGlteDogU3VwcG9ydCBpLk1Y
OTEgMTF4MTEgRlJETSBib2FyZA0KPiANCj4gT24gTW9uLCBEZWMgMSwgMjAyNSBhdCAxMToyOeKA
r1BNIEpvc2VwaCBHdW8gPHFpamlhbi5ndW9AbnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IEVD
QyBpcyB0byBkZXRlY3QgYW5kIGNvcnJlY3QgZXJyb3JzIGluIGRhdGEgb2YgdGhlIGRkci4NCj4g
PiBJdCBpcyBuZWVkZWQuIEkgd2lsbCBhZGQgYSBjb21tb24gaW5jbHVkZSB0byByZWR1Y2UgZHVw
bGljYXRlIGNvZGUuDQo+IA0KPiBPaywgYnV0IHdoeSBjYW4ndCB3ZSBoYXZlIGEgc2luZ2xlDQo+
IGNvbmZpZ3MvaW14OTFfMTF4MTFfZnJkbV9kZWZjb25maWcNCj4gd2l0aCBFQ0MgZW5hYmxlZD8N
Cj4gDQo+IElmIHRoZSBERFIgY29udHJvbGxlciBzdXBwb3J0cyBFQ0MsIHdoeSBjYW4ndCBpdCBi
ZSBlbmFibGVkIGJ5IGRlZmF1bHQ/DQo+IA0KPiBJIHdhbnQgdG8gdW5kZXJzdGFuZCB3aHkgd2Ug
bmVlZCBib3RoIGRlZmNvbmZpZ3MgaW5zdGVhZCBvZiBqdXN0IG9uZS4NCg0KV2l0aCBFQ0MgZW5h
YmxlZCwgc29tZSBEUkFNIHNwYWNlIG5lZWRzIHRvIGJlIHJlc2VydmVkIHRvIHN0b3JlIEVDQy4N
CldpdGggRUNDIGRpc2FibGVkLCBubyBuZWVkIHRvIHJlc2VydmUgRFJBTSBzcGFjZSBmb3IgRUND
IGFyZWEuDQoNClJlZ2FyZHMNClBlbmcuDQo=
