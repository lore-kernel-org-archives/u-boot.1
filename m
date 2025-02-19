Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22282C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0D080F91;
	Wed, 19 Feb 2025 21:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="LQAvWqgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9423807C4; Wed, 19 Feb 2025 20:48:33 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69039800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 20:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNhPvfWhJSwKXzuDKE2RWsO7mZWYO0kbAFZKc0Vdy2CicGRT4FxpK/QtpJydBb6UXJJuxjLJ0wl2rGGeOiWn365EONb5YPi0WWlbEXPA5Ih1fGZlE82d7Kvss5yAteLT6OYi4ZOVjCMEntgyr97kynKGPTjxeveOQjXftD3cenH+8Ya78mWaFikPz84z40WVbvqxdvwp0dQht7wDLuGYeUvsudMsaBU46kGy6sbQrexaOPIyUlVnjel2HNwG1853FLO9WB0tNlmTOZBO5nXKCFKrGJ6Y8/CXPba1W9ZK5fgQ/GL2ajLHntOnJs3E7NC6+obb2QUvkG8MYo14WeIONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi0HCKoCy/9csqFT4dcFzsNLVplJf7RhVGuYRh1lWB8=;
 b=IA3u59HN4Wx9n2BDTe4Bh51Pxo6AKsBcjwjBYN2jW1Qi4tw3BMpjL3gPXPOY/nGIGiwQGRyZO4BBNoqH9oN7sadz9ho5gToeq5HP27uBR/rRUSSnE5d8WVNCdrQzctx/Nnyb+5+MuJgZTDWfxSQUWsYnvAKyrsjXb1Okb3uzAZ56hi4p9urlSGK8kULWTDelcp/VOpU76NXgWwvk5VT7iGtbM6Mid7MgbIuO/5M8Gj6gt2tULCXfq2wckHOdIwCyVpodi0H/U4PWwYucc+SSoJbASrU8Ti/kLl4y4RehBQfpfT8v4zsjv8t3sHfTKQzFleaUMntLPGEv3ud/e/yx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi0HCKoCy/9csqFT4dcFzsNLVplJf7RhVGuYRh1lWB8=;
 b=LQAvWqgJwqKl/FXbVwQUxahsvKa5+sqa/kGy2cV1VI6XBTXFz5M+OKdb/gdnkm2odOraD0KN/hkJvHhve+XG8dosWM8qV/rfN2THRIFA3eCIlLXhMdTTbJrw42gl1t1CV2ZSVy+jMo95zonY4L2/t+ZgUMiHGXyFd7+0VHalOIdBU+B3QpTGBnVIDYG0XAF6Sx7FjUQWe0Wiwf/ChW2fn6QBMsG9eglIlYtefKomPDbYvY1lBcKVQAMEZfrXlnkqcuLDCEZO8ivP18kt3m8WioRINGEgmZAYw/EglsJ8iTR94weQERQA3UnCHGfrG8Fp9V1UmmQhloCiisM/bcLwxA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.11; Wed, 19 Feb
 2025 19:48:29 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8466.008; Wed, 19 Feb 2025
 19:48:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "s-k6@ti.com" <s-k6@ti.com>,
 "afd@ti.com" <afd@ti.com>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "sughosh.ganu@linaro.org"
 <sughosh.ganu@linaro.org>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "kishon@ti.com"
 <kishon@ti.com>, "bb@ti.com" <bb@ti.com>, "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 02/13] net: ti: am65-cpsw-nuss: Define and switch to
 bind method for CPSW driver
Thread-Topic: [PATCH v2 02/13] net: ti: am65-cpsw-nuss: Define and switch to
 bind method for CPSW driver
Thread-Index: AQHbgrvrNw9sOyaS0Emv0VN3SHF6JLNPCQSA
Date: Wed, 19 Feb 2025 19:48:28 +0000
Message-ID: <f3d550a323fae44604d1d5c76053b86d2bf44fc8.camel@siemens.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-3-c-vankar@ti.com>
In-Reply-To: <20250219104831.2315464-3-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7189:EE_
x-ms-office365-filtering-correlation-id: 4fbb446c-3c7b-4eba-e5a5-08dd511e61dd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Z09KZHB0SkJDVnNaaHY2dHNVeWczMTJSMG50cWIzNzN0RTF0aDBRT2M1Rjh2?=
 =?utf-8?B?blpkbld3dkN0d2l6N1RYZ1JYZWNsc2c2ckVKVFNKbFZGRXpiSTVXRUxEUE1i?=
 =?utf-8?B?cCt1UlhWYmR3WnFCcXRNWDhLblV1VkxFeWJZWldteGpmSkRnWG1ZZmw5RDNN?=
 =?utf-8?B?V2JISER5MUFtZnRWREJCdzZSd2lVRTNQSjI2amIySTE4U0w4SlJsSjhqQ3Nr?=
 =?utf-8?B?ZlRDc2FXbHVWODBoVGJXNVpCdVl4K0I5S1hBSGdCSzdMTkxJQXRhRm1YTjFH?=
 =?utf-8?B?cHJsVG8xTVZDUzBieDB0VVdTQ3pLTWF5bFJTeFFmdUNNcFp0SkhnRzgvcUFi?=
 =?utf-8?B?cE5mdHRXZ0JDY01MMVk3UU1vUWlaMlMxSVpwbll2VWo5V3Y0cjBqSlNOYlVm?=
 =?utf-8?B?N2NzbjlaaStNOVdiNmJZWk5uaVF6WndEL3lNckVubTRVY3Y0VGcxcktmRUM2?=
 =?utf-8?B?VCtTc1hVRkRhVGJwcHZHUHJaUCtzd3JHOTMwdG9UR3NlRFhXRTJROTdXQzRh?=
 =?utf-8?B?UnlJQVg1RStZS2xnK0hBK0JzR1BKNDJWL3B3MSt3TGVvZkJibWJjbmhodVFQ?=
 =?utf-8?B?eUt1STRGZ0NGU1BNd01oc24rZ3FPdVFSU2ZiQURzVkQ4SWt0UnZvZjZoeDRz?=
 =?utf-8?B?TmoyRlJmNGMreGdmK0piMHI4VHd0MkdFL3FqZDVQaWdWb25Tdzh2VnBQbkl6?=
 =?utf-8?B?YlhBaUJrdmVHU1VrU0paMkkvVHYvT1cvTHV3YWh4Q1B1azgxTGxkUDl2TXlX?=
 =?utf-8?B?SkVGOUNQZkozUllhMmxPOXV3dDJOWjdGUytZU05hTmlxa2J4SnhlVG9HVE82?=
 =?utf-8?B?ZUN0WDMvL0xjb1A2bEgrR0ZPVGd6L2kvcGNxcVVqVHE4U1Y4VlZBa09vL25N?=
 =?utf-8?B?Nlp5SnBJTEx2WVJqeUhTS0Q3U0RGZHJOU2d6VzV1ZEJOTTEwdEhCQ2pIazlE?=
 =?utf-8?B?RWg5WmpqZVJJN0RZa1hENlRoVjRaeXgxTFlVQ29ENldLVkFSbzBjOXhrOEM2?=
 =?utf-8?B?dFNwL1JNY3pRT2huMktyZHRtNi9hOHRwRlZ4RkhqY2ZodTltbXhLY3E1RDRD?=
 =?utf-8?B?OWhXa2phKzBUdGhFVUI1UFExVFdsL0pWWjFtNUp3NHZxYi84cld0TnlrZFJP?=
 =?utf-8?B?eklKVkpGNVVaMzdRcGl4TnU2N2wyeUZiQTZEODYyVXRwUjVRRjVYVlZFNll5?=
 =?utf-8?B?SVlxYUxBNHlLZGxtY1N1d0UxdGtXMU1kQlM0c2ZCdFhLNEx1QTBGcnA1YUZH?=
 =?utf-8?B?aEEwSFB3dlpXSVZCT2FNS3p0UnZwUmFaNjFCMTlBS2lmdTlRMHdPVnE0UnNh?=
 =?utf-8?B?VzBObWR6OS92aDg4alVnVGhQbGZPZ3NoTk9iK0NPWG5KaElCQnJaak1ETzQ3?=
 =?utf-8?B?c0pkdFlHbmprSkdVU2tJZ0JCaGozWmtETmJIK0Q2Z1lwbGpIRkpUMGMwUEtO?=
 =?utf-8?B?M2lWOVRHeXdPRkQ5S0kzYTVHb1d5eVRlTmpkOFpIOG4wckZheHdMaGhBQXhv?=
 =?utf-8?B?QlJra0k5L2ZxY01DTk9zS3Ixbkc1SWJGdzViTWI4MUxiQURDUXJCVUdNOHcy?=
 =?utf-8?B?clRwU3Fyc3ltY1ZDZXRHS0NJN2VRK2lCT3JzYnN4RXc3OTdWdGRGZkF5S2tT?=
 =?utf-8?B?b0R2aDJXQWZsYXBBSW13Qk42VmRJMElIRmUwK3RMaHovWG5heTNVZmpIMUNV?=
 =?utf-8?B?NkZRdVI1eVFvM1Fxc1JPbTljVXhRUHFnNDBVejhVZ1R4K3FxUDRydy9JWTVC?=
 =?utf-8?B?S3IzMWE1RnZqSGtxUWNpcC80Y2NISmIvNEpEaDJaTmFYaWFYek9BZ21kSVBE?=
 =?utf-8?B?Z1NPY0hPaFRuS3hRVE9zK1JxTFBBaFF0Vi9FZWU1dEZOUWZNaUgzNlVrSUpH?=
 =?utf-8?B?b05aVjIrdzAyZkZtMndNTkg3WngxMG9pTG9zNVY2eGhLbmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzltVHh4R1Vkc09VR0VKUVFuOEdDNG5VVm5UcUREWUkzdEh5aHlrcFZ5dy84?=
 =?utf-8?B?Mk1PQkZBUjVLRUVqVmVRVzRaTWIwaS9Wd015WUNCQnJmUUdoVmgrZUxlRVZo?=
 =?utf-8?B?bFpqcFZuWkhnNnBJYm5EZjdlMTg4VFNHZkNDVnp2YmU1YUFoalVjZ21ucHov?=
 =?utf-8?B?eWVrdjJJaVdBZW9wekk4alJVRHQ3UkVGbnJaM3dyekhvVS9zRDlGT0pIZEpp?=
 =?utf-8?B?TmxQc0pEWlYvaFZVYjF5dGNCbU9hcUpTbUtaOUlFbm11YXc4ZG9acjZIYjNO?=
 =?utf-8?B?U3hZVHhiaFE3NE5SQ3QvRjhjYzhvOVVtYWYvaG5XaWFKL3dpMTViaHUxWG1X?=
 =?utf-8?B?RTJGR0ZGeWlHTFJEQTkxaEcwNkR1d2I3M0hocm15WXVCV2FsQXF1RWdwd3FN?=
 =?utf-8?B?bjNaNU8za1c5NG56YUNrVDVoYUhiZTZyNnVZTW9vRVdMN3dRb3dCOUNZckIx?=
 =?utf-8?B?MlREWXlKM292V3c0WnRBU25vcXZyWHBOVWFQeXhpVXNTNThoZGJlci95TWlI?=
 =?utf-8?B?Q3pOc1Nyc3NQRkx2OTBKUUJuMXZ1Y3B2dUJmaThjdWdNZlppeWpDbTBUbkZ4?=
 =?utf-8?B?WGJsMytMY25OQkZTNVpnZktQcWpkL3FIRkxxM3hDSytDWXAvdktlbUgvcDdG?=
 =?utf-8?B?UDVjRHNMckZTNWhQb04zQzU5dkI4M3ZLMkFIUmQwUXlQd1JwT0ZEMlA5THBt?=
 =?utf-8?B?bUpZbUx6REtiblQ5dFpQTi95NXE1aWkvS1Jvc0ZWQ05zR3Y4dlJFODIzNVB0?=
 =?utf-8?B?R3FWYmlHMnE4NUo1bXBpVUJSR0h2RWovQTFCNmNyRm10bEJ4U2xYdUFBd2Q5?=
 =?utf-8?B?ejBCZGpQdEV5ZTJoLzdFbHZrT1pneGsxcUFBV2VSNlo4TWZiNklOM3YzQjA3?=
 =?utf-8?B?d1dBUGNmLzhVZGtqSDZyRWthSVV4dUpRVzlxdWhZbzFxK3BYbGREamdqQ1ZE?=
 =?utf-8?B?cU4zRnp0cmVyZkI4bXAwdndONHZoSW95WUJZWUFvRzNwWU1rSDRCTFNTRnFt?=
 =?utf-8?B?ZlBxTjNtMHhsdnZ2emtUYmNUUU0rV2xBVDlUMTl3TFhtZTZwRXE2R3JqaTR1?=
 =?utf-8?B?aG9lWmwrUHRSbnpQU24yTDJqRXJMUCtCSlFhdDZVMmhDK1Z5ZjBOYjYyYUcr?=
 =?utf-8?B?VUFMVElROC8wMVdnb3luS0ZYVTJFNzUvd2tMd1BQSmtnQTJVRXJ0enlHNUl6?=
 =?utf-8?B?OFVZYXZZOFVvbjdkdFlOQlprYU5aTmd5TWEzZlpDNHVpVEFYd0dYTjVIYmJY?=
 =?utf-8?B?RlhsWmlyVXA0REZ2NWpIZUU3OXFGaUlMSkVxWmoxWUVGd2xYS3hxNHBLdDU2?=
 =?utf-8?B?Y1M5cXd0MGdmbURpNDFOVW9kRXh2MHFaS2hnbktORDZpajdwS292cng5R3Vw?=
 =?utf-8?B?RkdsaWdsNzQxNndidTFVYU1BS29KUUhIcTI4RmFTWGYzd2R2dXhtZHVlUE5U?=
 =?utf-8?B?WEJFbWJ4Yk52Wk1MZldvL0Zwa0xIeUU0Z2JFbDl3QlF4QWhHenoyM1NtbFJQ?=
 =?utf-8?B?Unl6SlVKQWhYM1hQMktPSUNJbXV0M1g4MTJ3U0VnMlRudnIreTZCZ2lRem1W?=
 =?utf-8?B?M2lCaWUvclZZRmZhRTFVeFRDWHBiWnFuYzIwTSs1TXo5TnFuV2N3NW9ISGZr?=
 =?utf-8?B?UHp4WWI3RHpJZzNHbFhjV0NmaVNVdWwwMWpBNFZ0NUt5RTdnazFjS24xMEtp?=
 =?utf-8?B?UHdVRTV1VitUTFBuUlBra1FGeFNhWEF0emlLbi9XZjlXbEZDaERhbkZqcys2?=
 =?utf-8?B?eU1wRE55eTNHNktkL0RuSUpRNnZNSU1OMEpQaTc1aThhNlJqMit3YlNOWFZm?=
 =?utf-8?B?Q3ZaRHYzdzFPd2F1U255ZlBCOUlCLy9ZVmVxL2h5MmQwZC9EYTQ3RHlVQzFv?=
 =?utf-8?B?YlVwd2Z5Q1J2MzZJODRiNElKQXU1Y0VkZ0oyZWpoa2tOYjQrRGM4UXQ0T09z?=
 =?utf-8?B?b3JJTDVGaTdla2V0TmRCZjF2ZjIvd1A3akRNbnhoWWxaS1UwcVRXeXREQkZh?=
 =?utf-8?B?cE80bE91Z2p2RWduNzBXR0hhcTBDdmFGZGcwcVVRUmNBZmgyT1hnZHlsTW9h?=
 =?utf-8?B?emhwdXlnRmVtU1dqNkhSYUFoUUd4QmtZM2laK2t1MFdKOWpsalcyeFdKSDlL?=
 =?utf-8?B?WWF4aCtEU1BBU1l2aVJubmMwZWZ1V0VqakQvMklzR2svTVZhTnhOdS9mbHFQ?=
 =?utf-8?Q?kxm28KPCDSlwLE5j82ebiJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F61C0164BB52E4C955FC191873D044F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbb446c-3c7b-4eba-e5a5-08dd511e61dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 19:48:28.9260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+J7duCDTOEQmSgHXIRCggMPPnIWuaVviQiI2HMN1OhC/U8y+tJY2bB7BbZpKOYUhdS5kmu2gcQFejkMTEqZsEPpGgTafG4/VcW0p1/YwkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7189
X-Mailman-Approved-At: Wed, 19 Feb 2025 21:04:12 +0100
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

SGkgQ2hpbnRhbiENCg0KT24gV2VkLCAyMDI1LTAyLTE5IGF0IDE2OjE4ICswNTMwLCBDaGludGFu
IFZhbmthciB3cm90ZToNCj4gQ1BTVyBkcml2ZXIgaXMgZGVmaW5lZCBhcyBVQ0xBU1NfTUlTQyBk
cml2ZXIgd2hpY2ggbmVlZHMgdG8gYmUgcHJvYmVkDQo+IGV4cGxpY2l0bHkuIERlZmluZSBiaW5k
IG1ldGhvZCBmb3IgQ1BTVyBkcml2ZXIgdG8gc2NhbiBhbmQgYmluZA0KPiBldGhlcm5ldC1wb3J0
cyB3aXRoIFVDTEFTU19FVEggZHJpdmVyIHdoaWNoIHdpbGwgZXZlbnR1YWxseSBwcm9iZSBDUFNX
DQo+IGRyaXZlciBhbmQgYXZvaWRzIHByb2JpbmcgQ1BTVyBkcml2ZXIgZXhwbGljaXRseS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IENoaW50YW4gVmFua2FyIDxjLXZhbmthckB0aS5jb20+DQo+IC0t
LQ0KPiANCj4gVGhpcyBwYXRjaCBpcyBuZXcgaW4gdGhpcyBzZXJpZXMuDQo+IA0KPiAgZHJpdmVy
cy9uZXQvdGkvYW02NS1jcHN3LW51c3MuYyB8IDEyOSArKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKyksIDU0IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMg
Yi9kcml2ZXJzL25ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+IGluZGV4IGM3MGI0MmY2YmNjLi4x
MmM2NjA5NWNjZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvdGkvYW02NS1jcHN3LW51c3Mu
Yw0KPiArKysgYi9kcml2ZXJzL25ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+IEBAIC0xMzIsNiAr
MTMyLDcgQEAgc3RydWN0IGFtNjVfY3Bzd19wcml2IHsNCj4gIAlzdHJ1Y3QgYW02NV9jcHN3X2Nv
bW1vbgkqY3Bzd19jb21tb247DQo+ICAJdTMyCQkJcG9ydF9pZDsNCj4gIAlzdHJ1Y3QgcGh5X2Rl
dmljZQkqcGh5ZGV2Ow0KPiArCWJvb2wJCQlwcm9iZV9kb25lOw0KPiAgfTsNCj4gIA0KPiAgI2lm
ZGVmIFBLVFNJWkVfQUxJR04NCg0KWy4uLl0NCg0KPiBAQCAtNjc1LDYgKzcyOSwxMyBAQCBzdGF0
aWMgaW50IGFtNjVfY3Bzd19wb3J0X3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ICAJY2hh
ciBwb3J0bmFtZVszMl07DQo+ICAJaW50IHJldDsNCj4gIA0KPiArCWlmICghcHJpdi0+cHJvYmVf
ZG9uZSkgew0KPiArCQlyZXQgPSBhbTY1X2Nwc3dfcHJvYmVfbnVzcyhkZXYtPnBhcmVudCk7DQo+
ICsJCWlmIChyZXQgPCAwKQ0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwkJcHJpdi0+cHJvYmVfZG9u
ZSA9IHRydWU7DQo+ICsJfQ0KPiArDQoNClNvIHRoaXMgcGFydGljdWxhciBwb3J0IHdpbGwgcHJv
YmUgdGhlIHBhcmVudCBkZXZpY2Ugb25seSBvbmNlLi4uIEJ1dCB3aGF0IGFib3V0IHRoZQ0KbmV4
dCBwb3J0PyBXaWxsIGl0IHByb2JlIHRoZSBzYW1lIHBhcmVudCBvbmNlIGFnYWluPw0KDQpJcyBp
dCBhY3R1YWxseSBuZWNlc3NhcnkgaWYgZGV2aWNlX3Byb2JlKCkgYWN0dWFsbHkgZW5zdXJlcywg
dGhhdCBhbGwgcGFyZW50cyBhcmUNCmJlaW5nIHByb2JlZCBmaXJzdD8NCg0KVGhlIHByb2JlX2Rv
bmUgeW91IGludmVudCBpcyBwcm9iYWJseSBtdWNoIGJldHRlciBzZXJ2ZWQgd2l0aA0KImRldl9n
ZXRfZmxhZ3MoZGV2KSAmIERNX0ZMQUdfQUNUSVZBVEVEIj8NCg0KPiAgCXByaXYtPmRldiA9IGRl
djsNCj4gIA0KPiAgCWNwc3dfY29tbW9uID0gZGV2X2dldF9wcml2KGRldi0+cGFyZW50KTsNCg0K
LS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
