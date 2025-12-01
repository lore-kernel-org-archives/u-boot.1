Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EF9D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265B683C0E;
	Mon,  1 Dec 2025 12:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hbc8ZOQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16DA83C13; Mon,  1 Dec 2025 12:07:57 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A74E583C0C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeanhgPWv0wo5bqG1U5NlLpWV+WIOdRiNelgou/CyHgHokKG6NV/ej8juK/CftQUOMQRZzcjYl9FJ31uTkk/YwnRy1en6jTLS29SnXjHrIQtUdhJXFlZ2BUFUrk0AiHhMxMlDGVWROowZW+/KC9z+cPfJ8hmKXaLeaJq9VWPosHVv2McsPwDMKRpBHoD5sZsRtn9lx8Y5Swo4W4ht53FUZI/iL+0aJfrUa/VwsvIhp2Ba3T3Q8uSNPPHKXHZgwktWlgZJJHEnb8E+qwwYh+yTit7OFcFIbMaox1hPjKL0NHlSr5er8XCwqbGLffLqhO+S8O5sUygoeK+qalVG/qMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8XbsYgT3dJ8Rm9nxLPUk+bzUky2NIbNSJLVa7kRq0g=;
 b=c8Mvg4UXONONMfbfDyUhzBRxTlOAl7D2YmyYJ1vO+4ru5SVvngajdQXgrneolRLt9/X8T4IyMjcP5nZ67Ve8Y6cK97rE9DHLmNPqNnuqWqY8P9re85kpQSBeDu0ZvBMV7qDYggSvAnMixVeqPTqiCz40awJilvGOjs/3b1j5vp8YV+RhfQvdSwt9mO36aWR7vCp6FAHA3Aht0K7f5kDeSX3zeGLWkq58yj2J1gJ4nkfqjzoVz9+6qEx4xzJsZQ5W7eR4AtmL8l7sKm8prNVd2vdR9S3ReEBbFb6wPQi7y8hpWWy3RJPhl+NmYH3S50WbfyPUmrzGy6+ZHnTW5pd3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8XbsYgT3dJ8Rm9nxLPUk+bzUky2NIbNSJLVa7kRq0g=;
 b=Hbc8ZOQ/nFOXoxhp+5g5EXnUXS7RsJT03Pyg9L1z5YcrSF1quRPYQdVXIypDRIJDidQ4D/I9TKaV8PsB1blzRwi3aUB0a9UG7Coo1zXOiNoI2VzgrSvmqC+b8JESZlW4ODK3mU7FbtYvOAscHiZZlgbMnr3XScgeyIy36+OipiTIYSzY+rMLMeraSdMC80eBAPRultMPJRUNwgyDhDfy63+qka9SiQrJt/9d/836tZgm5uh+ogPHaGW35IcnxRDh2rAhFb1F4S3isgg3TSqk49xZJXBbx2bSbiVf+rFYh8lhqELYDX9iAcIfr9ho4ViVZ7WaZ7geR3eHgQMt/KoHKQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:07:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:07:53 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>
CC: Marek Vasut <marex@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, Ye Li
 <ye.li@nxp.com>, Fabio Estevam <festevam@gmail.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Stefano Babic
 <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Simon Glass <sjg@chromium.org>, David Zang
 <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS80XSBlaGNpLW14NjogQWRkIHBvd2VydXBf?=
 =?utf-8?Q?fixup_implementation?=
Thread-Topic: [PATCH v1 1/4] ehci-mx6: Add powerup_fixup implementation
Thread-Index: AQHcYrK9Uj/coRYAcUKHYFrQ+Go/tw==
Date: Mon, 1 Dec 2025 11:07:53 +0000
Message-ID: <PAXPR04MB9644482227D883EDAF12D3A9E2DBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
 <20251128-usb2-v1-1-25ec5ac127ff@nxp.com>
 <a016c693-071e-47f2-b5a8-f03ccaa7a7f9@mailbox.org>
In-Reply-To: <a016c693-071e-47f2-b5a8-f03ccaa7a7f9@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB8PR04MB6970:EE_
x-ms-office365-filtering-correlation-id: 4589a600-9e3e-4aa7-778e-08de30c9dff5
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YkV6L1BZY2FyWE9HbVN1alAyMGtmcHZjNzdFdFl6YXhXU2EzQkNEaEt1ZjBk?=
 =?utf-8?B?RUJZaGhvTE9iNWFQK2d4QjVzdWtWUmxxeUx1VUM0eHM4T0Y1K1BkSzN3OFlY?=
 =?utf-8?B?OGdIL0phSzZGVG9wVDl5Q3JOWis0ZUFEekwyTUZRSStqbWFleXA4WVhMdkI5?=
 =?utf-8?B?ako3MFh6M3puaHJBRmR6UG1pZkVoM3pGNlhZMG1mbnBlVnlWSnVad05rRkR6?=
 =?utf-8?B?UmN3K0kycGluQTZMc1BZdHU2dnQ2SElDY0hYaFdqeTgrMWI0THdJNm5tVFZR?=
 =?utf-8?B?UFRzK3ZRelFTS1ZUZEk3a0hWTnJ4OTFTWncvdTJ5djFMRG80c3I4SXJvNjVX?=
 =?utf-8?B?bzhRUUg2RXJ0MERaQkRhdnRTdnc0MXpnQXVQR0FOdVRuc1F4K3NOT2pxZHps?=
 =?utf-8?B?VVNLYlpUUHE0aFN1SjFUU2RBVkRyM092VTBNUVNNOGUrQWNYMzE3MHl6czhG?=
 =?utf-8?B?M3NUQ0QzdVBBTFd2UTZyRVJJcHBuOS9jU0ZPVnZWY0VkV1JGVUpmaTR2TlZR?=
 =?utf-8?B?Vm43WlVLM2QxOFpwdGVuZWppMzBGcmE5dEhrSEFhK3VUNThoNHNYcm5qSEpI?=
 =?utf-8?B?bVVBekFacWIrSWhEOTgzQmp5ZlBKdUFRTXZ0dDBTQUFiRlBKRTZTNXFwQWdi?=
 =?utf-8?B?QWNwMjMxOGRiek5UYzkrVjVwdkE4UWZTelY0MDlFSVo5Q2gxNTlJbHdOcDNu?=
 =?utf-8?B?YXlmakI2bjhyNmNiQ3FEdjROQ3FLYkd5L1RsNEt4cW8rY2ZVNFRqd3lEOTdv?=
 =?utf-8?B?S0FjMHNPekhQNzUyeVMrblBpNForWFZnV2ZwNG95c2hMaHNSNWZtOFAyQm9C?=
 =?utf-8?B?NldtSmdZQkF1aXFLQjNEcVdibXdZRTllUDEvbFl0OWxCeEYwTndtRTJzQWx2?=
 =?utf-8?B?KzlsSjY0Y1NXeDNhU0ZRenNhTnJOKzR1YnUxcHZVRS9EcGpmaE0zMWtDd3VP?=
 =?utf-8?B?bmN1VU1NeDMzTGpQT05jdklsRURrcGpsbURBVW51MXMwakV6eURWVlZkdUds?=
 =?utf-8?B?K2E4bC9WVXdaeitHTWdQOW14UlBIYSsxOVd0NU5UT3ZBNXJaTnh2UUJ1cHVF?=
 =?utf-8?B?bnlIemRRYkRPLzY0RmQxRjRkdWlBcEJJUzViV1U5cHo5c0w2QUh4WFVmd0k0?=
 =?utf-8?B?Vy9YVGZZT1lGRitRSHZ6TEV2UzFmT2VCZTkxc0FYVFBsaHdJY3NrTWVJWE1W?=
 =?utf-8?B?Rms5V0hwVjZlRWM2cW1YUmNYTkFmQVJQR2lkSnlmZDNWWVM5WkErd3pjL2xi?=
 =?utf-8?B?SkR4QUZwZ1RnN3k5VWYyRXNrVXI2ZTRsQjlPeHQ3c25YVlV6VHdrdXNYLzdt?=
 =?utf-8?B?cnBUQWpTWkdiWVMyVkNJbmxZQUlGa29iQVJLajJ0aCttWlZlckFacCs5ZG5X?=
 =?utf-8?B?MS8rZGgrSmtjTnVPWjZtQ1RyS2gzQUQzbzJYUXNrTXRzMm9oSkRabmtraXN3?=
 =?utf-8?B?MU9YZEpUUjg3SWhPV0FHcDNGTVlZbFgzSk9UOUVYYXk0UjZRV3NudU82Ylcv?=
 =?utf-8?B?NlVmeGpUNnpPL0NNaGxmUitQUSs4WHNMdFRWT1B4eWpHTHVRZW9SUUlDa05I?=
 =?utf-8?B?ZW5NcnFnY0Y1blR1WUVrZnVoOXNrODhSdTFwT3NOandrVUZOV1NZNHFrV1Ev?=
 =?utf-8?B?cWgzclRtMEdGVTdDMGZhTDRsWFZQUUdiRWtsMmc3UXg2K05vQm5LK2dHQkFZ?=
 =?utf-8?B?OUlKblJvaHBQb0w2Vno5WC9tSkg2THRPR0szL0YzVm40dEpxV1Y4VjA4WERV?=
 =?utf-8?B?aEdiUEFURDBFZ281UW5XdnRhOEE1SS9rNDF3aHAwSjNYOWhjOFZJWEtnR3Aw?=
 =?utf-8?B?R283WS9pdE4weVZJS0FkK043L2g3Z3lHemY4dTdMTHpkQlcweENoKzhGamd4?=
 =?utf-8?B?aUNiUGZyOU93L0ptMm1aVjZJZmtWTUhyTHQ4akJwMG5HeEl0WG5peU1tTHc0?=
 =?utf-8?B?YjkwNEoyQXVqUEhmS3hGcWdnV3YvME1xTzB0L1RQd1NwNTNUa2hxUGNnUW5I?=
 =?utf-8?B?dUxzYTI5MXhOQ0NWSkxSUmtrT3FNREVXVmNxTEx1MUI4cWt4N0VGTWhrb3lq?=
 =?utf-8?Q?bF86VD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlFuRDZ0MmVJSlVnbHhDdTMwbFB0QTJnRHF4RjNreXo4enQzYXhRcDNOUkd6?=
 =?utf-8?B?TVQrcC84QTF2NExRS0kycHhIaUlzVFVGQ2libzBUMXZhNzM4bHpsd3VkMGlO?=
 =?utf-8?B?OThTL0ZZcEdWaENVQnFXcnRqam9RR1NpeDBLeG83Lzl3WjFoYWp0VUZxWU5I?=
 =?utf-8?B?R2QwTXBmbk9kNUtlNnM0anFaN0ttTEh3WnlHUDRteG1aN3kvYnFwQ3dVaUh1?=
 =?utf-8?B?OGhwUDJTY1UvT0czUVlmckZ1VEx5TWRZOG5BY1lBOVVGaW9wTWtPZjhud2s0?=
 =?utf-8?B?bVg3SkovR2NVUVNXU2tydDBWVXU4V1ptRE9kTk5oVzAwZ2xTRngvWlpjSUpI?=
 =?utf-8?B?VUtqdTlNQkZSb3RXSkFVM0hvV0R6cE8yS1dEZ1FzbHRzeHp5UVhnSVZKcVly?=
 =?utf-8?B?cWIyZGdrSFlnOWkvNzJVcnY2ZXlNYW5Yd1FnQlNEUXEvLzJmb2xySFdodTVB?=
 =?utf-8?B?UmU5OUU4TXBoRTU2UXRPbGtOVFpCVXV5OURrb1NGU1RMSExQQ3oyQmUxaHN1?=
 =?utf-8?B?T3JOcEt3ZnBHZHp3Zkc0UUZNemZBUFcyVndib24yMllrTzRvOHBmQ1lpbkx2?=
 =?utf-8?B?UDBRdERSUXpuem1MWWM1MzhPaFVMTkhudUNsUWZnVkdHZCthZU9PU3pqV2pz?=
 =?utf-8?B?cGplY1dnanBaczB3QWYrNkN5d0tETlpBcUpnNm43YzQ0Y3ZtczJGeHl5bEhm?=
 =?utf-8?B?ODR5bklGZnVYenltSVA2VkFXTHVSVE9tUFhsdXdraFNKWGJ1aFdNWHAvb1NW?=
 =?utf-8?B?d1lHajVic284VE5HK3hQNnNMa21WVmo0Y2tlZFBkTUI4TUFSV3o5ckRKNm1n?=
 =?utf-8?B?b2RhQTFxWTcwcjYyRnpSNlVrZ002a3EvbHROeEZydXFvSk0ycEZxU1c0QlRr?=
 =?utf-8?B?UHJQdnAxWXhjNTlXR2dHbDlaTzhnRFhNRkViTmlzeGRsK1lDSDFCTTZaU0Fr?=
 =?utf-8?B?UDlHTmRpVmhVSzNoK2NzY3pLM3Q3RWhsZFlYd09weHVmeHVIQ0ZqSTRjeGV3?=
 =?utf-8?B?SXlPL1oyU0RrVWNtdzI5bENPOG1SNlh2THFQOWFtL3RzZGJVZGhveGhQcnJ4?=
 =?utf-8?B?WVFMWEt1ZCtTNTNweWhLdEVJeENJSWhBZS9kSFNKV0Y0Z21LSnQ0QzR3K0dn?=
 =?utf-8?B?VllaYmNneUw4NlhMR2srMFBSM3RxTW5UN3M1cHQ5ekdnSFkxMGMrR2I4cE1W?=
 =?utf-8?B?UnB1VnZHaGNEQUdabE13SXpKTTNmcGcwN2xxOTcrUlBTSXU2eU5kVXRQei9t?=
 =?utf-8?B?c1NMSE1MVEVMOHE2SFhVRXVUa0NnNUFxZTVSU0cvZTg5Z3VGbGJVWkZDQi9Y?=
 =?utf-8?B?OG44YmV1QVNPWURaOHk1NEMwQ0JMNFp5eEZ0OXpEUmNzU1NodHBoczFIWlZI?=
 =?utf-8?B?VmRPSncxV2l5dHppeFpKM1BXeHZ0SXh5RW9pUVBlV1oxck03L1ZxdnZTMWFk?=
 =?utf-8?B?MFZjQUpGaEpETSs5cVFGbjN1OTZSTmZpU1FvbEpSQUZVOGVVMkZ6a1NYaXR3?=
 =?utf-8?B?UnpTb1Z0Z3B3N1doOXB1eHpRQlUyVFhKbkxuWkZ6OFRubDJvbTJxTUZGMGJk?=
 =?utf-8?B?NlVCbnpMOTF5WWFkTS8zUythVTUxUHRwSHZFbDRNcURJbDRFay8xS0U0cTVt?=
 =?utf-8?B?T0g4S0VVbWFoZlY1Z2NkODIrbm1scGlJQ250VS9DejZ2bktFUi80YzhPZkty?=
 =?utf-8?B?c0p3WXBWY2ZBbXA3Q1VXNXNxclRqY3Vlb3FSdkpqdU55NzVVNmNRSVNnQUFL?=
 =?utf-8?B?c3hGbzBLbmxaS0R0MGFlaTJ4R1pBU2lNenZxdWZId0lUSUpRVm40Nmc0aU9T?=
 =?utf-8?B?MjVBbFdTeU9zaGJZQ1RubFh6c0hlWXNOUldiNlhnWTRibGJaQ0JObjF5Y0VY?=
 =?utf-8?B?M1NOdjlub3l0RGo5SkZJazRrK21HR0ZBOW02ZDIyWXlpRUdmSVZhQk5Pbmt0?=
 =?utf-8?B?YlpVY2N2cDFnY0wyeWFqSnFLVGxROWdaTGxkL3gzMTdIK2RUa0g3UUlhMitD?=
 =?utf-8?B?QWdEY09yd3VwVFV4aklQM3NoWXJDbkI3dnNUdGJZTDlEVC8yRmwxTVZYVmMz?=
 =?utf-8?B?eGgzTnJSRFlxTFlpaFVIRzNpTnU5TFdob1oyRjFYMENnMTV1RGs1T1VxRkpM?=
 =?utf-8?Q?6Utm+itsUIQ/BPE3G4HC+Sn1m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4589a600-9e3e-4aa7-778e-08de30c9dff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 11:07:53.6815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHItdX9CRIMXycT95X7pAytYSGaFKPTM8ZHKxV3yy9DsGpbYV7V+Hc6lzt/aF/nGVTXvgvpjEsgULLWwyQeOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMeaciDMw5pelIDk6
MDUNCj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47
IHUtYm9vdEBsaXN0cy5kZW54LmRlOw0KPiBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29t
Pg0KPiDmioTpgIE6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsgTWFyZWsgVmFzdXQNCj4g
PG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vs
a28uY29tPjsgWWUgTGkNCj4gPHllLmxpQG54cC5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZh
bUBnbWFpbC5jb20+Ow0KPiB0aGFydmV5QGdhdGV3b3Jrcy5jb207IE1hdHRpanMgS29ycGVyc2hv
ZWsgPG1rb3JwZXJzaG9la0BrZXJuZWwub3JnPjsNCj4gUGF0cmljZSBDaG90YXJkIDxwYXRyaWNl
LmNob3RhcmRAZm9zcy5zdC5jb20+OyBTdGVmYW5vIEJhYmljDQo+IDxzYmFiaWNAbmFibGFkZXYu
Y29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBMdWthc3ogTWFqZXdza2kNCj4gPGx1
a21hQGRlbnguZGU+OyBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IERhdmlkIFphbmcN
Cj4gPGRhdmlkemFuZ2NzQGdtYWlsLmNvbT47IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+
DQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MSAxLzRdIGVoY2ktbXg2OiBBZGQgcG93ZXJ1cF9maXh1
cCBpbXBsZW1lbnRhdGlvbg0KPiANCj4gT24gMTEvMjgvMjUgMjoxNiBQTSwgYWxpY2UuZ3VvQG9z
cy5ueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+DQo+
ID4gV2hlbiBkb2luZyBwb3J0IHJlc2V0LCB0aGUgUFIgYml0IG9mIFBPUlRTQzEgd2lsbCBiZSBh
dXRvbWF0aWNhbGx5DQo+ID4gY2xlYXJlZCBieSBvdXIgSVAsIGJ1dCBzdGFuZGFyZCBFSENJIG5l
ZWRzIGV4cGxpY2l0IGNsZWFyIGJ5IHNvZnR3YXJlLg0KPiA+IFRoZSBFSENJLUhDRCBkcml2ZXIg
Zm9sbG93IHRoZSBFSENJIHNwZWNpZmljYXRpb24sIHNvIGFmdGVyIDUwbXMgd2FpdCwNCj4gPiBp
dCBjbGVhciB0aGUgUFIgYml0IGJ5IHdyaXR0aW5nIHRvIHRoZSBQT1JUU0MxIHJlZ2lzdGVyIHdp
dGggdmFsdWUNCj4gPiBsb2FkZWQgYmVmb3JlIHNldHRpbmcgUFIuDQo+ID4NCj4gPiBUaGlzIHNl
cXVlbmNlIGlzIG9rIGZvciBvdXIgSVAgd2hlbiB0aGUgZGVsYXkgdGltZSBpcyBleGFjdC4gQnV0
IHdoZW4NCj4gPiB0aGUgdGltZXIgaXMgc2xvd2VyDQo+IA0KPiBIb3cgY2FuIHRoZSB0aW1lciBi
ZSBzbG93ZXIgPyBNYXliZSB0aGVyZSBpcyBzb21lIGJ1ZyBzb21ld2hlcmUgZWxzZSA/DQoNCk9u
IGkuTVg4VUxQLCB0aGUgQTM1IHN5c3RlbSBjb3VudGVyIHVzZXMgdGhlIGludGVybmFsIExQTy4g
VGhlIHRyaW1tZWQgZnJlcXVlbmN5IG9mIHRoZSBMUE8gaXMgbm90IGFzIGFjY3VyYXRlIGFzIGFu
IGV4dGVybmFsIG9zY2lsbGF0b3IuDQoNCkJlc3QgcmVnYXJkcywNCkFsaWNlIEd1bw0K
