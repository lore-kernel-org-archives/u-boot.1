Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27850C9EC90
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A0383B0D;
	Mon, 12 Jan 2026 14:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="JeORpDV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 820AD8391B; Mon, 12 Jan 2026 14:22:43 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56CAC8388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW/ERTtX7s8wqzZ55pg6IiF777AbdUFdOc0wROcS/PASlHR6lVF694zCXne1+YxGqw+aoW9PEFtJ3bnvV/EBbRZOC/rhOx1yk5d60CB/WWiy/t6SfapH8AvYsHlt23Ip20G0VY8GNI0oeh4isql1J+Ac74v/YBCCuICbpgnAJX3gz3tsT2IqiuJW6zpG103C/SVngjPkjNNGD/lxCHBVhSFrV/rfucQTAf8Hxe8Ea8FQu47gMzCcy5ilWk/Yzg0oUT4MaIB7BpXGcz8RyiarlOR34AT3qchPzEq12D35BPPQ9XIgBSX1o5twtBNFAu05KhmpbARnPWex8UoIObarVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rjA5pjZNGwmxJs3bQIcmoZfF9pEKhIVUgwwjLmJiu4=;
 b=sw1yaKm+bD9ip6HOQKTKKWicyKA70ymSnk9A60O/2ZYga3yUjSojV2AsXrzzmzayxH0aHMG5CPpjtzmw2WcAqOBB0ICYNvtVmAATDnXxYg18yvRsHzSULpe3VfPc5QkYH9MjNwMbnH5akCczla2kTTrvkM78+h4UMLXvV+hIPtZTgm6Jx+wFkGzwUvaHtcdtNRfiQ1FLaqJfWFxNENIgoH0+ebWPMeQZ5Oh2wR/j7+8JyDpoV8G9/LJn5qNll/9760IK/7VI7xnLpyGBoKdWiNdKcLTNNj3Q1ozpah5iRqmTB6CxIbWquvxK1U6Q4ZLUtCKfs8jAjP74x55z2R9MDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rjA5pjZNGwmxJs3bQIcmoZfF9pEKhIVUgwwjLmJiu4=;
 b=JeORpDV1FXesHxxGX+PzY/H0xlfSg3VVeGCv3PghX2rBjrl7KwLdHhF+XGPM5g3JtSkiuegz913/NPrDfUoL/9rv0pa91JO+4G7szzYe45tsYtkYtdyg/aX/1g1Tl78A87kntB5RyZVikaamR7FANlNfFvVJUlkzFddaDXf8EOdmZKti4f2Vowx9y06Hxejj5fJOHK/wLhx83E8o4hqf5NuM7d+sDQmxwEJ4DJ6iDpcHaFPRkMjU4j+h+rYOMqPwVPvnGrZpLn2bWlT7Qa9mnR1H3mVoouXiODozIxxAWiCqA1EEN5cP5hVkr33cRhscH20vlNhDdL4ALcsN9j1y+A==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DB9PR09MB6743.eurprd09.prod.outlook.com (2603:10a6:10:4c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:22:38 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:22:38 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "rick@andestech.com"
 <rick@andestech.com>, "ycliang@andestech.com" <ycliang@andestech.com>
Subject: [PATCH v5 00/08] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v5 00/08] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcg8aFY5oEILvt60SCk798kaqHEQ==
Date: Mon, 12 Jan 2026 13:22:37 +0000
Message-ID: <129b77cf-cac3-4608-a55c-5d95b7abec5d@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DB9PR09MB6743:EE_
x-ms-office365-filtering-correlation-id: eb30fd91-5818-4f8b-33aa-08de51dda7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZFpwVktjbnB0RVVjYmd5R3N6czZHbHBoZ1pTbEpvbkxUdHVvMGRQQ2hRTVUv?=
 =?utf-8?B?TnJwSjI2TDBMS3N5UE5NbGE1T1JSdUovMUJ2YVZYTHRNSlZFdDRDMXhyODIw?=
 =?utf-8?B?Ti9PRHcxUkU1emNwZDhjUmdsd0psT3U3bTN2UnNVYmJXV0hlZ1Rja3pVd0Er?=
 =?utf-8?B?SzVHLzQwb1l4bnR0YmJtTkdSV0JxbEFQa2hzTmtPeVRBRWpVU0lHZ2F6NXp2?=
 =?utf-8?B?ZWJLd3JrRFcwRGJLYjNPMkNEQ09lcnpGTkF2QzI2R0pKeTZFdWFJNjRkMDdU?=
 =?utf-8?B?TmFEVGE2NiszaFRYalovK0tMOThaZXlWdVk0NVY4Z3dEM0RjNjRMWGU3cmR3?=
 =?utf-8?B?WFZhNEpXZ2duODUxTHorbzlvbXA3d2tWZmRlVllqa0hkVGRyWnFjanpwQmNP?=
 =?utf-8?B?REEvcjdUS1AyODQyK0IvUldxTXV2QkFZaS9JVzY4Q1pxUGo5dWlOVHRFVGVw?=
 =?utf-8?B?a3RMMldUUnA0TU5XTGhrR2R1N2Z0N1pzeTZiYzlISlJuMUlXclNsT0FkeUpy?=
 =?utf-8?B?cUhMRitmazNxNWVsa1FRMjNjTDNZNURsZXRha05LcXF5RUhkTWU5OGtpQzNs?=
 =?utf-8?B?S3BaaTRkYmRVbXRQanJyZDVXSktmTHBBL0s0S1Y2bmg2YndJRDR1U0Y4cUpt?=
 =?utf-8?B?STU5UmxIcWNrVnVoNU9Vb2c3d09DSFhMQTVoN1VUSmQySHhWRVlET3o5cURk?=
 =?utf-8?B?dFdOUGNxQ1dub2VXR0owY0hiVUx5anh3OWhZbGVTdy9wdXY5MU9md01yU0VU?=
 =?utf-8?B?VGhCUTdCY0lHL3NIYTVGVXZDS1FocnJuT0VHZ3BOdEk5ZjNpbXh4dW1UUUZC?=
 =?utf-8?B?dnNvYkZyQUN0MGZlOFEvZzQ5K05lSCtheHdtaHlDSFN0QU5PUnRvaExsMm81?=
 =?utf-8?B?Znc4cDMvMzh2NVB3VW50eURQS0JDV1gwdzl2QzZUdmVPYjBGZXRGbyt6dTc4?=
 =?utf-8?B?c0NUcG1FOVRaWC9YcDZDbVI2REVFTkkzTzZ1dnRQMG9FK080Y1dRZ1Z6RUtW?=
 =?utf-8?B?UXp4Rmh3TlFDYzNBSVd3elkvNWJZRjhSZ2ZuN1diWC8ySmlabnBYdUFsLzZS?=
 =?utf-8?B?MUQwL3dhaDhic2ROYTBDMVpHTFNJUk5QcDQza3NNTzgxempBeGl2ZVdLNnQ2?=
 =?utf-8?B?Q0t0L0VYbG1sZ01IaWtkejhYTm4wYVdnVVR5RW0wUXZ2Yk96K3RON1l3Mmdi?=
 =?utf-8?B?bjZCT2JkdmtselVNMW9sVEVwbThSYUhIWUJSNU1GbUtFV2ZiRnBNTm9FRG1h?=
 =?utf-8?B?TS85Zkl4YkRnY25YK2krcGF0SDVxWVhFNXI0UVJhT2RnNkgwc291ckpMUTI5?=
 =?utf-8?B?Q2J1UjJQRXExMkFEQVR2OU1Oa2s0Szg5VG8wVGFwZVo2bkg2SCtOamlSbjQ1?=
 =?utf-8?B?SXhhOXYvKzRoM2V1SHMrb0l6QS94RlJDb3A1Ry91bEZadXVGblh5Nzd6RFJV?=
 =?utf-8?B?OXduYlVSS0pDc0lIQTlqQmp3NVFDVG1qaGNSeVA5d2FWNXZFMVNaSFZuLzNJ?=
 =?utf-8?B?MjJYaXdINFVzU05iWWNJVzV1cURXT0tMN0Fzd0luLzdXRlluVDBxSnQ4WnVk?=
 =?utf-8?B?WU9UeXp0SlhhdHNoWUR0K2lyN3oxTGdrNTFRVWNTdlFUYkNvWG1pSjFKVEl2?=
 =?utf-8?B?akJMZ3ZJa25JNGl1VENHYUVwMDRQV2h5NUJZdjBNMldxUkpXQ3hsc0ZwVU9k?=
 =?utf-8?B?L2FtUGtaWmFzZk5JUG53RHlnUk45azdMc1Q5YlBkL1EyZ214VkN4YnF5a0RN?=
 =?utf-8?B?cDJob3lERDZGdXNXdVJic2tIRk4vM0JYNDZKc0ZHcXJCcVdrMFhQL0JEMVFt?=
 =?utf-8?B?bmtxdEVZK2x6cXY5b3RrVllwTTdCNElKNThQWjB6RXdVYkJiQ3A0cXI5L3VU?=
 =?utf-8?B?aFAzaHU5WHlLQWVJT0lPR2d4Ukk0c3o0Qi81dC8wSHFQaWxhQ3IrK3BvVmlX?=
 =?utf-8?B?SDNOMEw1S1hHTm84bnhEWFBUc3RSNTk0SXNCbHB5eEJHaXB2SmJ0YUtRUXda?=
 =?utf-8?B?c05OWEJFUVpFYnpWMGZHN2VLRE9uSzF4NXZvTTNnV0xGM3o4bmhGRk93T3M1?=
 =?utf-8?Q?E/C6h2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGxYOHZ5MnFvR2crZ3lZSWV0WjcvRXpQRzU3NUF3QlZhNStWYmtkN0t3SEpM?=
 =?utf-8?B?MjdhMGJlQy9sOG5lR2NwN1JhTTY5RWJlZmJ4STFSaVg5eTJ6d3dPS002RGRI?=
 =?utf-8?B?VGFaQmpSMk9WdzFNTGJXVVJBTlBpWnpqWlFxd05XVWdieDFScm15ZWpZa05w?=
 =?utf-8?B?OGRBVFBVZjJiOGNXQnN4ejVsZWpteGtweVBndlJZVFZCcFN2RXYyaUZZdnJR?=
 =?utf-8?B?bVB4eG5LRnlZUzJ2QlAvL1R5dmNyQmlTOGp4bjhmMFdnR1hUT1B0V0FHbE5Q?=
 =?utf-8?B?cmJPaTlzMzhpRS9rUXVsRXV0bWgvL1E1YVR2eUtRcEJUNExUMVVpQ2dDbGo0?=
 =?utf-8?B?aDN2NjdYZFp4bWxQWUEybGFteldoOFYycURaNlMzUzlIUEkxRDY0eG83OFov?=
 =?utf-8?B?VEFFdGptY1JwclF3QWNBMTZxczFkUjBjMzhCSHNldkxGUWZaWlFwK1NVOW56?=
 =?utf-8?B?R0l2WlNYekdLTlBaaTJjZUpHbk1KL1g2cTJBRTU3Y3I3VnY0WWNxU3FsdWFK?=
 =?utf-8?B?R1ZYQWdwZXV3NnpEd1Z4V1VlS25GNTRoWk9YUmlicEJPejNHcXlJajgyQWpp?=
 =?utf-8?B?OU1CalA4UXc1SlhTazhWTHFFWHlSTWVJdmpYOUwySEM4WlUzcHFQdklyOFFM?=
 =?utf-8?B?Z3A4RHl2VExXVW5leGdUcStTZVNmMmp3enh2bWptSVNSV0ZXdUllckVLZEIz?=
 =?utf-8?B?M1ozT3hJWWl5ZGhKaFNpUWVEa1NOMDNQRGYyUVk4V3hNcTJ5ZmJLbHFCbHVF?=
 =?utf-8?B?by9ZTnBxWnErRkN3MmdMMUxRY0ovZlBXUWl2UXRYV2ZPbU16aE5PUksvTmVw?=
 =?utf-8?B?M3NIdkg1dzRYWWQ5ZTNFZjdCczBKaURtTGladFo3eWxQTHZNbFpBc0dyY2dw?=
 =?utf-8?B?MCtreWJPM2dhSVlaeC9VbjlTdENJcHdvWVlkTmpvRFVzcXNtdFZZcDVQelpm?=
 =?utf-8?B?TC9NWjc2OWp6VU9XUFF6SVRpa3NLdXErN3Z1NkZwRm1scW9rVnVLTWdHTzg4?=
 =?utf-8?B?aldDQmE4bHQxdkZxcEx5cGNiZTJZOGtUb280ZmJuYWoybVZhWjNTWUZkU0FP?=
 =?utf-8?B?OUxUaVNSYUwyZEhxYVRsMDZzditjOVVUTm1MY2M4aFF2K0Rva09pZFlEWjl6?=
 =?utf-8?B?Ukh2LzZjRzVjMWgxcklOOEtFTVczV280eGxoeCtKaG8rWTZPQ3RPbVdxOW9Q?=
 =?utf-8?B?TVYvRXJ4bmlKVGVGVVM4TDFPYzB3dEo2ZjJkL0piTWpyNmFEU3V1MG1XNGR5?=
 =?utf-8?B?NXVoUzdoYXkwWFRzdXNuRDJDK3ArNmRpK01RcUlqN2tGdVZpcXRyMU1WUC9G?=
 =?utf-8?B?blBvejBCVzN4YXNhTmptUC9LWndvVzBWNGtlSENwL1NPZjR1Z3YwS0JvaUsx?=
 =?utf-8?B?dFVoOVBLcFo0RnBWdnh6NjF3QTRZb1kycUZUcUx3ZU1qRUZOV0ZOcXBkUUZx?=
 =?utf-8?B?NHM4Y3VhOHhNcnNyc2VhdGttRlF3czVXZGZhK3Z0VS9LMHdYMmE5djF6NGtC?=
 =?utf-8?B?cXh2OU9wUi9KY3N0amZnck1CMWdmWk9VTXNxdERZK3M1MGNpem56Vmk1dmNP?=
 =?utf-8?B?TDllc1pRMldZY0tMN1RqY2Z4YUJ1RHhtM21ZRFlPVlZXZjFXTjMraFBqY2RK?=
 =?utf-8?B?a0NzeXl0cnZJL0MrSVpwUjZiU3FZdmpnalZVZEgrWEZlY3NCOHBheXRBZUU1?=
 =?utf-8?B?Slk3QUdnV1ZadFhIRkRiMVR4R3l1NlZON2dwd05qYWpFd2VoM1FwRWc2ZGp5?=
 =?utf-8?B?UnIxcHdLWHdzaHh3dzhHR2dVU21ldFEvSm9LSEpwZ0VEWEJLZm1mT2p0MTE0?=
 =?utf-8?B?NkY4ZlF2T3NObkRqMmdNTHN4ZWdQUXJiUFhzM2FqdG5EdU45LzJ2RjBWWjNE?=
 =?utf-8?B?dlFvNkRzeS9WV2JSclZKMXFLRFk3cGZGKzlDbkVFRHduQ2tJajZxbkQ2aEp1?=
 =?utf-8?B?WG1ZUTM0UGY5Z0FMSVVFTVZRV1pETDNLQVpQeXljVkFiN2paby9WYjRaamxo?=
 =?utf-8?B?U2J0cGgycjc2elpaL2ROeHZJcmF1OE5PQldzL3Bna3FxYkg5NXdOdDgxRGRl?=
 =?utf-8?B?QUF3OXJRYzkwUVFRMGFQLzRENWdab2lROE9LQVpzUko2VmxqWjdGLzF6MzZC?=
 =?utf-8?B?SFk3VDJQNW5QSzc3c3kwMkVhYUtJWWZRL3JwNUM2bkpkZUt2Sm85bWE5aTdT?=
 =?utf-8?B?ZFZNR1dYL29vOVQvaUx6M1JMcDMxTWNEL01CTFFJcGN2RzE5YmVmdTMrV3Ix?=
 =?utf-8?B?T0RQcTFKNTJlVEdWdmlNbWFSd2l0MDlkQlhZdzR4M3J4VnNROFRpbkNGdlJl?=
 =?utf-8?B?d3BhWnBJTU5RZ0JTSXN4bGNNNXkxT0YwbXAvL2x3bC9tM0llMU5HSG9QcW1u?=
 =?utf-8?Q?9eabV8UISRNmwVXY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3720E32D1005F34D93F5B88B7FFFB369@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb30fd91-5818-4f8b-33aa-08de51dda7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 13:22:37.9880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+NOtACE/jLNQ81z2MdtB+s0ViXviLTMPfSz5SGeGJNzeRfsg7FcOcN5u6yqIsa3p/S3AiwRBXn8gg48WPCnSSDUibZCoWiVKf/tMgD5X+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6743
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:29:31 +0100
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

SGVsbG8sDQoNCmp1c3QgcmVhY2hpbmcgb3V0IHJlZ2FyZGluZyB0aGUgc2VyaWVzIGxpbmtlZCBi
ZWxvdw0KdG8gc2VlIGlmIHRoZXJl4oCZcyBhbnkgZmVlZGJhY2s6DQoNCmh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9saXN0Lz9zZXJpZXM9NDg2NDE4DQoNClRoYW5r
cyBpbiBhZHZhbmNlIGZvciB5b3VyIHRpbWUhDQoNCkJlc3QgcmVnYXJkcywNClVyb3M=
