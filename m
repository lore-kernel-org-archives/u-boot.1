Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26160C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE7E82CA4;
	Tue, 15 Jul 2025 08:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lhOqyUa0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DED82B07; Tue, 15 Jul 2025 04:06:53 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57AA88277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dENqG2FqcIF7+PwDb7lmblz6u2h/R8R8m6yQPyKBTM0Ib5vYSBj2Arc2DEsCtlohLP3fEeNne3chF0YbvKs9hmOtUTp6SUdjFSQm7XbGREtQ9AFPV964FYUyFweny6QJgTAIwlNr/saFGB5Xp+FY2er68Y4/4CZuPSYecfiSAhqKdYOfWTLlWyp7sxJJlBC8oycsdXp8bXWHtEwPchjiQeBLGFa6NWE4BP7YJxoNyr/IjINlGKOoMA0Ffv1rkw3MGZm2UzlCgK52QGq5gW44+TIFcrCjSonCoYGWiUPodqipzfcwf8ae/IRVcDe0Wu1/Q0EGS0LPhhKK82ySp6bxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sX1VLem7lOD1rdLIqLzbvgQNlNRP1Yp1hjhk2+rSPA=;
 b=sXpeFk2uB6iTKJcuWZCSpyVIlNEskZfdhKIMIi1A6HRLJOK3oqBX4oMzcZdHMC5BDnXmqOQau7pG+6ZL6+emDHgPQR7jQbOiN57ZyT5F4CWsnOqxEMqgdV4Ifwf4cP8QV2IoVX2X28lQgOmP2+R3GOt4jq9Eaf7YjiksHhscz8NQnjlx5mSt3fg4PJ1SwPFzvq9O4QX9mI7mPpYQ6sFM+2W9yowQkHBVZtBeEVvo2RLCwOGRbTpEnPu4QSTtEeog+5oT/Ca5oJKD3nxGCWoQ463rLEME3dBrbYzOuAMuHL8UO7uBggxMmmjN5NDneKAL7axgEulzscGKKLXHoN0VuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sX1VLem7lOD1rdLIqLzbvgQNlNRP1Yp1hjhk2+rSPA=;
 b=lhOqyUa0GOIgSvVccBoZRUwbAfcjchwWb3ehi+bZaoyaUWmrPMpIhTXRJqUW8aqbReBCTm4i5cEL5UnuFBqBhGZW5Bm+oJb3b3PSjbiaoAg2sw3UCyocIMQQlpGAX8Rm4iOuoC73uWt9h0Ntp2EbGqx7k85yOjsnN4FbMNLcPq5pbBqcLdRtPvuTzInceVfrc67lNqpIa4KVVtlutwxljdkeG2gijr+cjuSGiWnK0gR6Ew8nguienCaa1dWrIjeQu7uBgEt6WIcFxA4/lZW3LLQUf9sUY7uZwQKU5Zy7J6Xqq5GcUaiOj8l8SudUrR46SZK1VyNSo9KSberB5OLhnQ==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6029.namprd03.prod.outlook.com (2603:10b6:5:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 02:06:47 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 02:06:47 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, Tingting Meng
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, Hazim
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v5 03/12] drivers: i3c: Add i3c uclass driver.
Thread-Topic: [PATCH v5 03/12] drivers: i3c: Add i3c uclass driver.
Thread-Index: AQHbw/CfxQBSu8x9P06SDEaGaLwYQbQugfqAgARP3MA=
Date: Tue, 15 Jul 2025 02:06:46 +0000
Message-ID: <PH7PR03MB6942ACD2C038C37714BCFFDAF757A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
 <20250513101913.30880-4-dinesh.maniyam@altera.com>
 <d941d6c4-496b-e52b-6c98-3bed9137099a@denx.de>
In-Reply-To: <d941d6c4-496b-e52b-6c98-3bed9137099a@denx.de>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|DM4PR03MB6029:EE_
x-ms-office365-filtering-correlation-id: d8606c9f-c874-4cc6-a903-08ddc34440ea
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OERrYlVSWDA2YzNlcHAvNkQ3MEdiSFNnemxVSjVSWTcyMFc2WTNQODd5aFZQ?=
 =?utf-8?B?K0orT2FGUTc5YVhUdzZhTDJCZURNSnlxdys4T2dOcDNsZ3U0VTY4T2g0MDVT?=
 =?utf-8?B?Sk0rdXo4OWZaYk5PRUZTUEZaR2ZmSXlNTVFHYy9udVFjbHFyOTVJS1lwOHRV?=
 =?utf-8?B?aVNXclc5SDdsYWVSU084a3RKajh5ZFJRZ2d0MGRmOXl3ZTNJWUZ1VGNNd2R6?=
 =?utf-8?B?cHNGcUNIeXRKZ0RFZTNQZ3pEblJMYWc2ODJCSktxZmQ0eDRDQlFxd045M3dG?=
 =?utf-8?B?RnUyTnEvemxWSFFub2o5Q2ZYNm9aeGJSMVc5ZjBvaVJqQ1R6c2N5Qk9SQndi?=
 =?utf-8?B?bzBEbG9Ba2JtVTdWbGRSZnAvL1N1aGF5dGVCTlJQNmJQTTVqUG5jRGthZVpo?=
 =?utf-8?B?OXhLRVAzRko1R1dnRkFVL1VXcDc1YUQ1MTdEdmxxQm5Cb21jTXJBTFhZNUZa?=
 =?utf-8?B?ZmNNUlovdGR5TDZhUUt0YitjT0g4K1JRdXgrN2d5RjluV0dmQTNuWDUyT3Bo?=
 =?utf-8?B?NW1KNnFrS2wwclFVU1lWYjd3TTVvSnVLejNhd2hzcVd5VDBYcXh1TTJkdFVj?=
 =?utf-8?B?Qk9UVFJmMFFUQWZJSWNVQURxdVhwZkVOR3grOTl3aWdjQ1p4Nm5NMmpqMXRL?=
 =?utf-8?B?ZTFWU29lQTgrR1drQmdBbVJqakRSR0xLNEY0dks3dUo2WlpnY0g3TEZYOGll?=
 =?utf-8?B?dmUraDJWK2RFMTYwZFFDV3dobDV3aFl5ZzY4RnJzZ0ZSYlhvSzNCVU8zUFlC?=
 =?utf-8?B?ZXBRaEVndSt6bmEwcGxIN1N1ZTVVNDhMalpLMTlJYnY1cmdvTUM3TUpjWFo5?=
 =?utf-8?B?NENvOVR0VUhELysyTEFUR3Y3T1E2OUJ4cTh0bEpYQldqQXZmblpSeXVTZGUz?=
 =?utf-8?B?Z2VSY1JqNm1MSnNxZnA3aFZ0em43NmlETTcrM3M2TzUvR0d4RW1zVXlZZzM5?=
 =?utf-8?B?R2RPKzlXR2RPZ2RwQ0ErbEpNcGVjMURoWm1jbC9hL2pHdFFyeDB0RDRXTDVX?=
 =?utf-8?B?VFBETGIwZU5sdXNRT1FCeVlqaGwwQVVSamw1K2lRTjBsb216bE5YWkJNL201?=
 =?utf-8?B?ODlWR2VIR0xEUHF3bnhxUG9aUGNicjhHeGJiVnpUMHdkckM5bko2bGpPdjlu?=
 =?utf-8?B?SS9Pak1PbFhRdHpxak1RYWZEcmViR2NlZDEwK3ZNVnpYcVRlejhjWjc3MGJa?=
 =?utf-8?B?VkhaVitPQ2hyR2NxSnJDelMzeEFXQ3FiUFRnTUtva3M4R0lhczZvcFVkUkRJ?=
 =?utf-8?B?Q2JpRVN3VDVKUHZqVFI4VndrS3ZRdnV0SXlHRk1TNFdNUkM3ZTF3NXRHenNl?=
 =?utf-8?B?QjlYdFRuT0hoY1FSM2JsK29oK3dkdC92aW9hVVBNUDhKbG9GZU1XRDBLRDlY?=
 =?utf-8?B?TnBJbkFyeVdmT09IeXU2a2RNK1VXVVB2b2tGazA3cWhVc1ZQVUpZSGJJc3o3?=
 =?utf-8?B?alJrTVd1ZlMwRDN6NmRzRnlZVklCSVBUWGVGV2RmZ1FLZTA4eE1HV1R6ZUo1?=
 =?utf-8?B?Z1pMRSs1MmJmN21MaGtBN0NUZWljdXpjcHJVOSs0LzJLSHkwRWcxdWdTK0pk?=
 =?utf-8?B?bmJmUVVXWU9ySDREWThrc0JWS3lwV2Y4MWgvQzZmN0sxQmYwVDdMMWpXNVJL?=
 =?utf-8?B?L0dKbTMwVi8zZ1J0UW9RaEFEelhsNmxBaDhNVXdGWFR6bzNCdFdVZGs3TVFQ?=
 =?utf-8?B?ajlmZGRneW9wQmhZcnl5VDRvWGlEemNXWU53S3lQRFhzWDhYc1BQc0FLSDdz?=
 =?utf-8?B?ZGx2Zk91aGNBRXdZanBHVkFtOVBHbUZZWS9vUmljUXpZbUY2Nlo0ajl5TUVi?=
 =?utf-8?B?R1pBaVRtL3BWbUpnMmZTWkQ0Z2lpMGdJa3hQbDZqaXhyQkF4dm0rNXZiRHQy?=
 =?utf-8?B?UElTMzM1N1pQbUlpc2tMMW41OHZTZFdWRW1PeHBhYWoxS0dNczlySzhzMmVv?=
 =?utf-8?B?TUErb3hTNzIwcG0yMHVBSmZ4dHNkV1RNZmZvQlc2TlB6WHNaQTJsNnArUlNR?=
 =?utf-8?B?cFFEYmRDMXhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFM5a2o4d04xeHkxaXh0V3hmUUlXdnRjbitGL1JUSnltVzl0WlNzTTZtMmVW?=
 =?utf-8?B?YWpIRGpGdmJjU05SdmtYUTVEMWloT09yOG1oRjRNZzJpS0tEall4TTNqeHBE?=
 =?utf-8?B?U3VLeHNlcmRQZ05EQkd5amE1MHFxNVRjeWpNRThXaTVlRERKRCt6blZuNW05?=
 =?utf-8?B?d2tBbDhqZ2ZWa0tuY0NNdTFZaVljSnd5aVZjMkl6bWRIZlE2dWEyWUhNdmt1?=
 =?utf-8?B?RkpWQXo5MWEwWXBRcVBvY1ZBZkl3WmUzVWhkYjVWNmszSzAvNEVoN3kvOCs2?=
 =?utf-8?B?Nk1uWjNVRHo1YzJpK0EzZTdZUStmemtKWGlDVDNjd24vY3c0cHJLcnhTY0Mz?=
 =?utf-8?B?dnAxL1ZJczh3YXVzQ2s0T3VwbXJrY3ppYVIwdmk4akpRZjFFWmIzQmFpSlU0?=
 =?utf-8?B?RjJWcmx1MUFldHBKekZub25IYS8rRytOc2xabHFTemdVU01lMWZEbVAzQW5s?=
 =?utf-8?B?MjIvb2hJR1R5SzhwdUhMajlYbC83KzJibENETVpraWFEL3RYb1lSb3dTbGZp?=
 =?utf-8?B?ZmpEaFJJTnVGSU4zTXowNlVkcFhpOFJFd0ZwOUlGWlhadzNxdXEzUVNRWWdj?=
 =?utf-8?B?ZDZQajhyMVRoSnRURWMwUDdocm5pMWpSMUMrQm5udmZ5bTF6RUtsNDZMNjBE?=
 =?utf-8?B?N29lZHdNOEpvekxvdS9MNDQ5QU84Q0RKVkRNVXI0L0JvZFRITnFDbHpNWVlL?=
 =?utf-8?B?YXptWWlCNXpTV3loZ3BQb0kyc0YyVjhvcVFveHZBbTJ6VE10ekZWb08rUW1h?=
 =?utf-8?B?ZkxXcmE4MzMvWU0wMGc0N2lubVJWZDJMOW1aTWNxd3NLSnRNd0tlZWdrNGh4?=
 =?utf-8?B?SVRxbG9ZbnZYRzdQREZZVmsyOStZREx0dlRBZ1RTdzRrRTlXbTJCc054TEJH?=
 =?utf-8?B?ZUtGRFlsZ0ZqNGxSL1FUZUFoRlptQWhCY2tqYXpnZ1BYcHZ3a0FaSWpXU3lw?=
 =?utf-8?B?L3J1NGhTUzlWeFUyOWt6RTlmR0s3dHJSWHc0eFhyZ2JPYnN5Ym1NVlRROWdz?=
 =?utf-8?B?eCt4S1dNQVBrSDBuNEo3SURtUjErU1JOQnNDMklxM1owSDRhUEt4d2o5WWNw?=
 =?utf-8?B?ZkU2Z2M3eGoxNmtUUFVvWDlqZWM0aUQrK0Qyb2Z3K2ZBNWk3KzVIOUlUL0FW?=
 =?utf-8?B?MGlxU0x1eWgxSGdzWnhmTDRJdlp5dGw1MTdxdW9pMGJLRTBDYWhqSVhqN1c4?=
 =?utf-8?B?VGt2QlpPU0QwbHhra1VRd3ladTk2Uk1ZOFdZbG1LcE1ibVVxS0szVGUyWGpq?=
 =?utf-8?B?UXlvcHc4Uml4dkI2QWlqNitCK2VjTEdXeFF3NHpJZzI0SXZzT1lqV0I4R0NX?=
 =?utf-8?B?VHBld3hNQmpmNk1ncEFnbitGMVJoYk5xZEF6dEpxd2pwTXFVRGwzRitFN3Bs?=
 =?utf-8?B?TUdrdEo1VXdnOEw3ODdPS3RSSFJFQW1YUTNtdzZjQWdEVlVHMVBEbWw1UWha?=
 =?utf-8?B?aXJqT1RUcVNocU1Vek1oMUlNUG54dVRnRXdUWUlrK3RnNVZNemR4L2lSQW91?=
 =?utf-8?B?VTZURTlidGVnb1RlZW1nUTkzRTdrSSszbnIrTm56bXA3dlVBTGxZYVdrcHJ3?=
 =?utf-8?B?SDNqa1FvL1pkWGJvWGdZeExXOEpRdmo0aSsvOUtBenlWandZVDI0eFJZUWdH?=
 =?utf-8?B?VS9QNWEzVy9zRzJBVDRwRTlYa2NoOVlNSEVVV25mUXgwdkJQVllTNXVaTVpD?=
 =?utf-8?B?dWhicmgwcldOTUU2eUdWRVc3aVU5ckNmVU1Nem54bmRsaUtSNSt0bmZWbFlK?=
 =?utf-8?B?d09kZGp0VnFHZGlnbEROcXZyQklndi9PY3VVUkRLZEM3Q24weXFZOGVlcU1r?=
 =?utf-8?B?MzFpeVhOMFl3WHFXbTFSME1BOHQ3aHlyNFE0V2laOXJpWE9oMllkUjFYRWdu?=
 =?utf-8?B?UHdtM2FnTW9MN0duK1N6Y1ZQRFNVZTZHYXdEN2NOampYWGdWL1ZqVDJ2Vy9Y?=
 =?utf-8?B?N0lrR0pkbUx1c2N4ZmI2T2ZTV0Y4R3NKN2cyaU9mQ3FiRmtmYWIvS0ZoMVpj?=
 =?utf-8?B?ZkZlajNybFlyMXdsS0xGVnQ0b0JuKys5VldGZzlmR0tRWjl4S2paRFhKTDIw?=
 =?utf-8?B?dUZ3UmtHTXpaY1VocUZXNTVqNUU5cS81TXRLUWcyUjZxKzBjTnpkUlR0QWha?=
 =?utf-8?B?bDBmczJlTjU5VWtMMU5WMUhoaDAyZHFVOTMwNk84V2U4VmNLak5STjJlR0Rj?=
 =?utf-8?Q?KCtGasAJs0jdUM06WSYYQs/N8VhXuUe2pK/Rul6zob/M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8606c9f-c874-4cc6-a903-08ddc34440ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 02:06:47.0758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jagGVdcpKeSc2nj08ANWjqry7IBk5mLrO+Hj34WI4SZkbt4TAshQc4H6MWAQ3o/gMuf+DUTZ9miMwfzx67yZQ5aNdwr3IiQRrsZAPFfTev0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6029
X-Mailman-Approved-At: Tue, 15 Jul 2025 08:33:25 +0200
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpa28gU2Nob2No
ZXIgPGhzQGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCAxMiBKdWx5IDIwMjUgNDoxNCBwbQ0K
PiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBhbHRlcmEuY29tPjsgdS1ib290
QGxpc3RzLmRlbnguZGUNCj4gQ2M6IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24gPHNpbW9u
Lmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+Ow0KPiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVt
Lm9yZz47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbw0KPiBCaW5hY2NoaSA8
ZGFyaW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBJbGlhcyBBcGFsb2RpbWFzDQo+
IDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+OyBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXBy
b24uZ2xwa0BnbXguZGU+Ow0KPiBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxp
bmFyby5vcmc+OyBNYXR0aWpzIEtvcnBlcnNob2VrDQo+IDxta29ycGVyc2hvZWtAYmF5bGlicmUu
Y29tPjsgSWJhaSBFcmtpYWdhIDxpYmFpLmVya2lhZ2EtZWxvcnphQGFtZC5jb20+Ow0KPiBNaWNo
YWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgRG1pdHJ5IFJva29zb3YNCj4gPGRkcm9r
b3NvdkBzYWx1dGVkZXZpY2VzLmNvbT47IEpvbmFzIEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT47
IFNlYmFzdGlhbg0KPiBSZWljaGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPjsg
VGluZ3RpbmcgTWVuZw0KPiA8dGluZ3RpbmcubWVuZ0BhbHRlcmEuY29tPjsgQ2hlZSwgVGllbiBG
b25nIDx0aWVuLmZvbmcuY2hlZUBhbHRlcmEuY29tPjsNCj4gSGVhLCBLb2sgS2lhbmcgPGtvay5r
aWFuZy5oZWFAYWx0ZXJhLmNvbT47IE5nLCBCb29uIEtoYWkNCj4gPGJvb24ua2hhaS5uZ0BhbHRl
cmEuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWltaUBh
bHRlcmEuY29tPjsgSGF6aW0NCj4gPG11aGFtbWFkLmhhemltLml6emF0LnphbXJpQGFsdGVyYS5j
b20+OyBMaW0sIEppdCBMb29uDQo+IDxqaXQubG9vbi5saW1AYWx0ZXJhLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NSAwMy8xMl0gZHJpdmVyczogaTNjOiBBZGQgaTNjIHVjbGFzcyBkcml2
ZXIuDQo+IA0KPiBbQ0FVVElPTjogVGhpcyBlbWFpbCBpcyBmcm9tIG91dHNpZGUgeW91ciBvcmdh
bml6YXRpb24uIFVubGVzcyB5b3UgdHJ1c3QgdGhlDQo+IHNlbmRlciwgZG8gbm90IGNsaWNrIG9u
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgYXMgaXQgbWF5IGJlIGEgZnJhdWR1bGVudCBlbWFp
bA0KPiBhdHRlbXB0aW5nIHRvIHN0ZWFsIHlvdXIgaW5mb3JtYXRpb24gYW5kL29yIGNvbXByb21p
c2UgeW91ciBjb21wdXRlci5dDQo+IA0KPiBIZWxsbyBEaW5lc2gsDQo+IA0KPiBPbiAxMy4wNS4y
NSAxMjoxOSwgZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBEaW5l
c2ggTWFuaXlhbSA8ZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbT4NCj4gPg0KPiA+IEVuYWJsZSBp
M2MgZ2VuZXJhbCB1Y2xhc3MgZHJpdmVyLiBUaGlzIHVjbGFzcyBkcml2ZXIgd2lsbCBoYXZlIGdl
bmFyYWwNCj4gPiByZWFkIGFuZCB3cml0ZSBhcGkgdG8gY2FsbCB0aGUgc3BlY2lmaWMgaTNjIGRy
aXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFu
aXlhbUBhbHRlcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZG9jL2FwaS9pM2MucnN0ICAgICAgICAg
IHwgIDggKysrKysNCj4gPiAgIGRvYy9hcGkvaW5kZXgucnN0ICAgICAgICB8ICAxICsNCj4gPiAg
IGRyaXZlcnMvaTNjL2kzYy11Y2xhc3MuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gICBpbmNsdWRlL2R3LWkzYy5oICAgICAgICAgfCAgMSArDQo+ID4gICBpbmNsdWRlL2kzYy5o
ICAgICAgICAgICAgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICA1IGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgZG9jL2FwaS9pM2MucnN0DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9pM2MvaTNjLXVjbGFzcy5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9p
M2MuaA0KPiANCj4gUGF0Y2ggZHJvcHMgZXJyb3IgaW4gQ0k6DQo+IA0KPiBodHRwczovL2Rldi5h
enVyZS5jb20vaHMwMjk4L2hzL19idWlsZC9yZXN1bHRzP2J1aWxkSWQ9MTc5JnZpZXc9bG9ncyZq
PThhMDYNCj4gZDEwYS1mNmFhLTU1NzEtMTQ3Ni1mMDJkYTFhOTVmOTYmdD05MGJjOTc1ZS1hYTI4
LTU1NjYtY2VjMy0NCj4gMzQ0NTc4YzVhNTNkJmw9MTQ2DQo+IA0KPiANCj4gLi9pbmNsdWRlL2kz
Yy5oOjU0OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdyZWFkJyBub3Qg
ZGVzY3JpYmVkDQo+IGluICdkbV9pM2Nfb3BzJw0KPiAuL2luY2x1ZGUvaTNjLmg6NTQ6IHdhcm5p
bmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3dyaXRlJyBub3QgZGVzY3JpYmVkDQo+
IGluICdkbV9pM2Nfb3BzJw0KPiANCj4gUGxlYXNlIGZpeCB0aGlzLCBiZXNpZGUgb2YgdGhpcywg
SSB0ZW5kIHRvIHBpYyBrdXAgdGhlIHNlcmllcywganVzdCBvbmUgbml0cGljayBvbg0KPiBhbm90
aGVyIHBhdGNoLg0KPiANCj4gYnllLA0KPiBIZWlrbw0KPiANCg0KU3VyZSwgbGV0IG1lIGZpeCB0
aGlzLg0KDQpSZWdhcmRzDQpEaW5lc2gNCg0KPiAtLQ0KPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVy
aW5nIEdtYkgsIE1hbmFnaW5nIERpcmVjdG9yOiBKb2hhbm5hIERlbmssIFRhYmVhIEx1dHoNCj4g
SFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56
ZWxsLCBHZXJtYW55DQo+IFBob25lOiArNDktODE0Mi02Njk4OS01MiAgIEZheDogKzQ5LTgxNDIt
NjY5ODktODAgICBFbWFpbDogaHNAZGVueC5kZQ0K
