Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F77E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8541C801E8;
	Mon,  6 Jan 2025 10:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QZtVbIDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0A5803DC; Mon,  6 Jan 2025 10:56:30 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B9F801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7y3tEUEn1cTokenOsbN7oKBs/qKPQnsG5zT1WbjZeJeinTSVGF6Bnwkgk6ZUIFtNZMFNxBQu1hq5LCO+atlbM7Y5SPzU5miVWv13HIEtYx9f1WgyzgJVyrpv1RM+InEYs0eI82R624ffEQeGH99K+Wd0A/5u1WWcafGGUugwHdujHsAvJdd+ItAtvoT8I2YBUkBk9Codx8670AcF5ZHzdXfg/oUIFQIiYcjVOf2Rt4JtWTtzRpX+luvBbsFHn/fHI8ewq9uaz6NPfQ/MSJMX9Y8myjCUs/qH2Zeh/RxxRCCEZmFYZAJgIRgdeVwTqCYDMb2Grau3LkrGxwsbFDkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdQkYF+pSPHg+Z8V+PoKzu7xn+T2wFWh1clrcMIjgtk=;
 b=XetD/xE0C8wW20mvwLg9vPxsXjelEGbGiPCxHX8/CliscahuiQSGy9+uuJ7rWx1X+2qjMnRUp9SnGVNSMjrqIxjpXTrgtVPXg4xeXabsExAC8r3vtyRw+j8qcDGq/179O2pigbpq/yxdfpqj1el6V4U7qHrkLuKs2EPbwHvhFGKnenJikYX/3qTHHhZ6SH48oky0uYzn/+1Z+4KXL/zXn2c2me7MQYDNBeZNa2es5hc/aOOk4SYUTez05o2QBLThTkrEcOhLSZbV6UqLxkQcRZuRmr2RNF7Bc3pDjRQYd89U+vIz/QGNSfv0IdvbbPB3o5RgjoQ1n5MQla4NU1DVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdQkYF+pSPHg+Z8V+PoKzu7xn+T2wFWh1clrcMIjgtk=;
 b=QZtVbIDMCV07zfLwPb0hWpXG29SA7EosGVPqkz73PwQqoOHDZ4M5TwuBziJbPKzNqaNM6HonLSMaexCkx112+2I4iDHsOkS6M6IOhunVJs6OLOd+qDJt6kHdb2PylHSWmcecxDx5TDL+7ZQZNzGKt48L4DQ3BmfA3WCR5ngknH/ZWevSP38HnYs0vD5swcX1wTaE+iM4JHhPRx4sdQ9p34+iLJqkVef76HzfWw68hQV+oXBtse8Va7X7rAKQzdjT9v2wEpLtvStctQBZye3pe0HV01671LfpJ0gNZssqtS4bqoiW6v6yiDyXJgItAaJglaajieWLI6I+0HPxfemksA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Mon, 6 Jan
 2025 09:56:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 09:56:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAzLzE3XSBwaW5jdHJsOiBu?=
 =?utf-8?Q?xp:_add_SCMI_pin_control_protocol_driver?=
Thread-Topic: [EXT] Re: [PATCH v3 03/17] pinctrl: nxp: add SCMI pin control
 protocol driver
Thread-Index: AQHbXasmvOyVXe174EyU/5+4gPoS6LMIr8EAgAChd/A=
Date: Mon, 6 Jan 2025 09:56:22 +0000
Message-ID: <PAXPR04MB96440F6976C336998424F176E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
 <61075a72-7a89-4bcf-8d96-f9fc24dfd5a5@denx.de>
In-Reply-To: <61075a72-7a89-4bcf-8d96-f9fc24dfd5a5@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8275:EE_
x-ms-office365-filtering-correlation-id: c18f5e94-ca14-4da3-4850-08dd2e386014
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TnVoYTU2ZFRtWmR0TlB0ODZvSS9qZ2V3UTJ5MHkwelVGS1ExNFcyUWYvM2cz?=
 =?utf-8?B?S0lvWkt3ZERDZzgrbHlyUE5rdk9CNDRoSzhZMDJmaVR6SFg1bmx1UjJTU0lj?=
 =?utf-8?B?NVQyeFFnZ1hOTk93YXpJc1hXMmhVeWFOSDh2aWJjd2tPbHViREZsY25hY281?=
 =?utf-8?B?VW5udzd0ck8zajNoUXpleU5ELzV5VHdrYmN1cTgzS3U5WXVTSnR3WDBiU3Fa?=
 =?utf-8?B?N2twTUVMVmlCd25PdnhiaDdlNjZwcUtMMDZUeGpNc3k2Tys0c2lsczVtdlpY?=
 =?utf-8?B?ZkFBeEtrTFpPTFJ0RjdxNzU4ald5ZWV0ZHpEd2p0V1ZscnAxdlVPSmIzU29Y?=
 =?utf-8?B?dk1rUEhLMXdQeWJuOTFsdmpiajdRUktYUmVpb2s2STU1SGhaVVVMdVBUWGd3?=
 =?utf-8?B?M1k1WHQrS0J0RGtaNlUyMVIzRlI2MlBqZUp2YTU3K0FpTTBuMm9GZHIrMWpN?=
 =?utf-8?B?Qk95ZXdYR3BRV2hBcWVxWGlGU3ZJOE9zRnRNeUF2K2pIVXJ0T2dZWTVIOGZF?=
 =?utf-8?B?bUZrMlRJcnMrZGdsbmk3Q21KK0hBc3pFVUtGNDkwRjBwZ3pieTA0RHZFRWlC?=
 =?utf-8?B?WXQwSFZyVlJKZnZwcTlYWE9nY0FOYUJrVUI2RWVGUm1zRk1IUXdFZ2hFVmZs?=
 =?utf-8?B?NlRPaERwWkE0MFZ4VnNTNWRaR1lLUUJvV2krUkZ0U1NyTGNGRmwrbG42Q1Jx?=
 =?utf-8?B?WVU0RFRJZllMSkVuUlEzU3ZVTDdXV21TOTFxMXkvclQ3REdEbC9qamYwTjFL?=
 =?utf-8?B?TmlkUE5Wc2pmaEM4cUQyc1NqNTU5SFVmOTUxQmtEbEo3WGV3b1FzN21PWHVY?=
 =?utf-8?B?T2ZnalNPbC9JR1Q4M21Zc3VEWldKVEpqc1lNVDJid1Rrc3U3eUpERmg0cnVH?=
 =?utf-8?B?YW9LUWRsZ0lIQXVIQk5Sb3BVZy83aktzWWRwQWVySHQzckpBYjhtSzBlVk45?=
 =?utf-8?B?cHFJQlgyQzRNdjRoRXhmbStFcGlKbk5LUk9hUUZRUUxvWkV0U3V5eFNZM3BE?=
 =?utf-8?B?Zzl2cFdmeElIQzdQWHQxdzJCRVd6Q3B1Z2w5c0hiajQ3L1E0VTFSNnhqRzBr?=
 =?utf-8?B?SXFGd1BsbHRPZnNsUGs0UytLV2hMMTVzdUFReURhRE1ySVhEYlVNSmxsTWJF?=
 =?utf-8?B?bm44NkV2ajB3Rm8xMU9rZWdiTHIvaXloTEM5TFptVFVGc0xvZUVNRnVMTnMz?=
 =?utf-8?B?UDg4cnE5bUlDNXljUVg3QXdSaWhDUk5WMHVBdnM3Qlk5TjJUMnRPUFl4dFpx?=
 =?utf-8?B?eDc3Yy92ZGp1NzdnQUVUak1vcjFodmJSSllkWk5OWDZJQ2RrQ3JUMTVqbVpz?=
 =?utf-8?B?dmZhaVdXZE9wZHBDdGhveHN1UWNLTUNobVRLM3hjY1BZbTRMOWhMeE5TRGVK?=
 =?utf-8?B?MHRaOWdJYTlaRHgyWlJEMHFuMkRFcW42OWtoQkhlSy9SRkVNcVltMkgrMVpC?=
 =?utf-8?B?Wkp2UzJYWnBpODVWanh3RUY1ODlXQWE4VElsL0xvVmw1QUlZS0ptaWpvM1Nu?=
 =?utf-8?B?K1ZiVFhjRTNNYjlOMWdsc3NrR1dETjhEY2owUWZaMUJoNXJRd0RmazVLd1h2?=
 =?utf-8?B?bHpIVTRqSWpQeDJrUmIzTi9XbFhhZWgyOVVBd0lUQmpjb2Q1Vms0VG5zSHFa?=
 =?utf-8?B?MlpwKzNBZGZVYlJNQ1hJUFBxWmI1VjkrZjJnNWQ0MWo0QTUrV2RPdld2ZXdI?=
 =?utf-8?B?blBuNlkxZGZCR3NBVkVJdHRKVldnb1hQZWxFazMzdDdhVHZjY05zMzZVL0Zo?=
 =?utf-8?B?VnQwL0lvaC9LWlR2cU8wZytGSDNhQ2VyMXdTb2lUd0ZJbVVudU1Odi9EZmow?=
 =?utf-8?B?MDJ3cm9BWVdxWjZ6dlhBTWF6YmtOYXlGL2x2UWtGclhYOW1RSDZXNVZCbG1N?=
 =?utf-8?B?blB1Sm9qcXBBaU00Z0RnNG1vTDVEcEs5WkpNY01Layt3dDVOdmR6ZEpIQnlK?=
 =?utf-8?Q?6NB3shpXcDt3TZ/UA/g24Djp4Tj1V7W+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXZFME9aaVFrbjNXUktXMjZiTDBGdExQK2VCMWEvbXhwNVNDeFZlaU1rWkJj?=
 =?utf-8?B?M2J2SzBwVys0UXdBTHY3NEV0aktLY09NZkp0dVFnWlllMFpmemsvZ3ErdFRU?=
 =?utf-8?B?ZjR2aTdJR3d2bGZhaE02dDNIaEIvcHY0QTNtWjhuREZyL1ZGTVZLTno4NHlt?=
 =?utf-8?B?bFNmQis0ZU1sL0pFRlBOM1gwc0tTUlZOc1JJdEIzNHArblU5eUxmcTN0VlhT?=
 =?utf-8?B?MlVNUEpHUkV6TjYvUXJMcVZkay9qcUgvTEZUU0UrMUJPc3V5L0lNSUtaMkU5?=
 =?utf-8?B?TVBOcHROTXFVVFJiWWhjL2FuWjRHeUJseU1QSGxPT0dUSjVzdkRDejgyWmdD?=
 =?utf-8?B?STB3bUlsQnhTRUR5NFM4Qm44cGlDMkx4K0tFTnRaMjBsSlU1ZEJwdUdXSGZl?=
 =?utf-8?B?RTRscGtxdVNld3EvWlJJM0orV0FjaVpzQS93a2MySkl5RCt3SjlmNkwzZ2g4?=
 =?utf-8?B?aG9MR3BUaDVZYVdaTVdRK21XL1pVdndQSER2MStUUHlmYldvbmhnZzhpOE9S?=
 =?utf-8?B?VTdSSzZGbTZZaEhROXNFUURoNS8wY0dSb2R3cEV2R1R0SUwxYWl0Ui9TOG5o?=
 =?utf-8?B?eGJwV3dOOTByVzlWb1U4RkZPSzRQRXFWZWJkdXVtRnRqYUc1aXAxL1BRRTdG?=
 =?utf-8?B?T0FsSnJINjNLcDRnc29CWDY1eVBNRW9MekU5RU1iTWsxYU12TmNlMi9VWFJZ?=
 =?utf-8?B?WWZVajZSTFptR1FSVW9RM1dpZkc0TDRQbEhIM05vc2JteitSRTA0UnIvMmYx?=
 =?utf-8?B?MEliRVpmODdHeExzUXNDREYrZHJYV2Q3UVBFU0ZXZklPVFVzYjR5RnhRSmJ1?=
 =?utf-8?B?TE1JK1IyQnh6ZnZQcWtrNWF3WlgyZm1UY09ZeGFYK3FFQnp4TXRFQTdSWi9z?=
 =?utf-8?B?Z2ZwL251cFJIWjNXOXNEMnZWT3MxWjBuMzlsWXc1WXJsay95MVVwOXRmOHAw?=
 =?utf-8?B?Q1NBYUhSNWpFd0VxOHBmSThuRG9SeFVQQ1JMWkpXd1EvRnlXMVhtY2RnODAw?=
 =?utf-8?B?VFB4cDRmSEplOVB3NytCVDh2d1FMZWR2aVV0MG54VytyL0w2UWtGenh4aXlt?=
 =?utf-8?B?L3czQWVHdGxSWVVneXJFWTF0aGJaaXNGSmVGZmIvbGtSWG5Yb2RFejIrMDZS?=
 =?utf-8?B?Tlp5NWFoS0JQcUIvSmFYNlNrSXhBbWlrZHIwSWdSMjJIQ0drZVdHRXcwU2lK?=
 =?utf-8?B?QzdLQWRwUHdYdHhOOEExbXVsRHJXMzJDZHJIYU5qK2VYVmw3aUJ4ZzlnM3Mw?=
 =?utf-8?B?WDlEcEE4REt2eGh6ZC9vUzFEQ21LamRyelhuUFo1WTVtazNIQXNqVEkwNm56?=
 =?utf-8?B?UmpvVk11Z0ZNekI2N2JDQVRYN3VKWVZETjlveDV1VnJ4cE0rU2VvVFV3TjRo?=
 =?utf-8?B?NDVOdHpmMHFURitPaHF2cHVlL1pjT1Y3eXdJbVJNSmZraUJwOTJSd0dSNGFa?=
 =?utf-8?B?TUYzUkg4ZXp0eFZycGhqb1RFa1h1VWRUb0pZTFhzWmxHTEtGd01FOXdPdFZK?=
 =?utf-8?B?YXZ1MVlsSGwrWjNNL3UvVW9yZTZLcFJMMHZpZnhYeXpUdis5WDRNT1J1OXd0?=
 =?utf-8?B?aGVFUVVYd21UZ2lOR2RvSEVtY3hKS3J5Rk5BYTFyYXJ0d3JOdjhTeFlQWkh0?=
 =?utf-8?B?c2NuckFMdUV2eFk4RXZqNFhndUxtQkFGV1NRMC9oZmNkTHFyVzVSOWU4WEdC?=
 =?utf-8?B?S2dtdDdNb01GajFyRUZ4UFJjSnFqVDJYOE5keUpSSUdvQURuWlE1eHQ2SFVh?=
 =?utf-8?B?VWg3RjIrdEJPNGJ6TCtlZ3drN3lzZDNoYmIwUEFLSHM3S21YelVldFFjQllL?=
 =?utf-8?B?Q2l3ajZyQkpmTFlIeFA5enFSVTkwS3YzRGRoRVpZc3hMS0M5eEUvYU0xaEVT?=
 =?utf-8?B?QmdyUit0VDVLNGJVbmlUK21PWnJieHcrYXFnUzJpd3JhYkYyMHphZ2VZNXZO?=
 =?utf-8?B?SEdCY2tpT01lZ09PckFkb2owZFFkdHB4OGZ3R3dUUm1WVHNVaWE4MDAzb1dC?=
 =?utf-8?B?TXczWm1FM3pEWE1Wb3A5U0tMeXIwbXRjc3hkbkxxUHVaMWQzV1BFYUk0QjNI?=
 =?utf-8?B?Rm5DWW41VDJZMHVRRXpGQVhKSkNYRlFmYnlXVEp3OFl4aWpISGRJQTNQWWNS?=
 =?utf-8?Q?/4coX9RNSNuL3QTk+OukWsmiQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18f5e94-ca14-4da3-4850-08dd2e386014
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 09:56:22.0954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxVYOWgYcNIJEuZ+BKNlVDNqItmEkBmfiWNyoN6mxFAcbzzTx0E+BMkhmdNA1344nT2qGT3mE3jNbR5JTKYfdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275
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

PiA+IFRoaXMgcGF0Y2ggcHJvdmlkZXMgYSBkcml2ZXIgZm9yIHRoZSBTQ01JIHBpbiBjb250cm9s
IHByb3RvY29sIHdoaWNoDQo+ID4gaXMgYmFzZWQgb24gQVJNJ3MgU3lzdGVtIENvbnRyb2wgYW5k
IE1hbmFnZW1lbnQgSW50ZXJmYWNlIChTQ01JKSAzLjIuDQo+ID4gQ3VycmVudGx5LCBvbmx5IHRo
ZSBQSU5DVFJMX0NPTkZJR19TRVQgY29tbWFuZCBpcyBpbXBsZW1lbnRlZC4NCj4gDQo+IFdoYXQg
aXMgdGhlIFNDTUkgcHJvdmlkZXIgZm9yIHRoaXMgcGxhdGZvcm0gPw0KDQpIaSBNYXJlaywNCg0K
U3lzdGVtIE1hbmFnZXIgd2hpY2ggcnVucyBvbiBNIGNvcmUgc2V0cyBwaW4gb3IgZ3JvdXAgY29u
ZmlndXJhdGlvbnMuIFUtQm9vdCBzZW5kcyBhIFNDTUkgbWVzc2FnZSB0byBTeXN0ZW0gTWFuYWdl
ciB0byBwZXJmb3JtIGhhcmR3YXJlIG9wZXJhdGlvbnMuIFlvdSBjYW4gcmVmZXIgdG8gdGhlIHNv
dXJjZSBjb2RlIGZvciBkZXRhaWxzOiBodHRwczovL2dpdGh1Yi5jb20vbnhwLWlteC9pbXgtc20u
DQoNCj4gPiArI2luY2x1ZGUgInBpbmN0cmwtaW14LmgiDQo+ID4gKw0KPiA+ICsjaWYgZGVmaW5l
ZChDT05GSUdfSU1YOTMpDQo+IA0KPiBVc2UgSVNfRU5BQkxFRCgpIG9yIENPTkZJR19JU19FTkFC
TEVEKCkNCj4gDQo+ID4gKyNkZWZpbmUgREFJU1lfT0ZGU0VUIDB4MzYwDQo+IA0KPiBXaHkgY2Fu
IHRoaXMgb2Zmc2V0IGluZm9ybWF0aW9uIG5vdCBiZSBxdWVyaWVkIGZyb20gdGhlIGZpcm13YXJl
IGludGVyZmFjZSA/DQoNClRoaXMgb2Zmc2V0IGluZm9ybWF0aW9uIGlzIG5vdCBwcm92aWRlZCBi
eSBTeXN0ZW0gTWFuYWdlci4gREFJU1lfT0ZGU0VUIGlzIHVzZWQgdG8gY29udmVydCB0aGUgZGFp
c3kgcmVnaXN0ZXIgYWRkcmVzcyBpbiBpbXg5NS1waW5mdW5jLmggZm9yIFN5c3RlbSBNYW5hZ2Vy
IHRvIHVzZS4NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gPiArI2VuZGlmDQo+ID4g
KyNpZiBkZWZpbmVkKENPTkZJR19JTVg5NSkNCj4gPiArI2RlZmluZSBEQUlTWV9PRkZTRVQgMHg0
MDgNCj4gPiArI2VuZGlmDQo+IFsuLi5dDQo=
