Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C09C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECF080F5C;
	Wed, 19 Feb 2025 21:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="QclBQjV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A59801CF; Wed, 19 Feb 2025 19:49:22 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE85800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 19:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3V/Ee7SELmDogVOl2Gqv6SWT8+cS2EAwlz6PzmaHx5w+E5EOQGs8Bdi27XvyplDTgurZ6WXChNLM1PD3VxwauNYU3llqvYBk1snZDaP6pbqD4S1TP6KB+YhZXG7h4EZjm6wYW4ryJR3ztg1sQSVwKP2o6x4tkQcieTvr6JM2cwds8wH5hmqAXDL81nZhqN6WDgzM4/r4s5WFG2Bdf69bQoYvdrPmETSZiIvnLn+jirIwA862HMVY/XvJ8x32qQiMOhMGLArH7VKpkMJoeBq0pIYd8Y8+fekO2Rd5cRnLs9TatkTc3rjA59YTlFtP9hECSEUHaiNljwuYSwqSQ6Rgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxytkKG+s5aZJz61cx2Hlr+yT0xNhlPsYQIocREAcMI=;
 b=n/C1751zsdocoCvfKrdMCqbNP+CcP534kmz1ybWv3GtKojobOICHqUOVhD33GZ+BS73kDAjl5V2ZC9+gy9adhfsod/LkzroTJCoCjvc0eMlqUNG0FIqWUDByr0XPtotPC2Lzkn1Zys6nDG9PuqwFxOntlOEDyl6sF5ujXxcQ1OKSPK45pDApJIj+xMqYeZ96M2goHjNb6YalogCs8GAI24sDW6Yky2Yn2HhgsSyj3ZZYJ/PwL+U6LkIHz+1g0TW5LmlnGq73LMRc/fr65pExgsZcUlJ0URxppmMI9IOf78Y0M61mbXjAiXhXVpgSxxM95Nam3y4W02OH1ztaT2vOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxytkKG+s5aZJz61cx2Hlr+yT0xNhlPsYQIocREAcMI=;
 b=QclBQjV2JNFGE+PN6CpaimMnN1HH0mknd/ep7FlaiRwW1s6hmq+vMxDA+OTZfQ/6XWEBgeDIiAw4V5UWGncEev8uI4v08ckbVbUDEo2Bld6u+UE5OBUc4Zpsj0BOFYNDGpLX9pzs5rdAzX5Kvf+P/SRJvKKgfhcR9oC2InGtcS1fRFF/XtTPyVx7mD+Gcf9lxa55N82dU0amfldL08paz42Lc8L22yDzwaC2Pdb/jz8PFIpkxMofHEzIelkddAxAtXJGAVpiYhS9Xm4gCp/4xdpzPyGv3uQSg8TlKWYITm4yyjtfeYrrNoZc44V3FWZgc6V1O3fQd0bDYrmTEXFOAw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS4PR10MB6232.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.11; Wed, 19 Feb
 2025 18:49:18 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8466.008; Wed, 19 Feb 2025
 18:49:18 +0000
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
Subject: Re: [PATCH v2 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
Thread-Topic: [PATCH v2 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
Thread-Index: AQHbgrvn0zPeRVmEjUqeAavhl+tFeLNO+HyA
Date: Wed, 19 Feb 2025 18:49:18 +0000
Message-ID: <752c404bcb63afaf78055f39d583055db44f82a3.camel@siemens.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-2-c-vankar@ti.com>
In-Reply-To: <20250219104831.2315464-2-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS4PR10MB6232:EE_
x-ms-office365-filtering-correlation-id: eb0ffd8f-5727-4628-4f55-08dd51161d83
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?UE1GNEx1UlhCSGdUaVgxUWU3SHJKMVNQNGpqS24vcFVOQlJHdGpwRCtVcVUr?=
 =?utf-8?B?QmhqRENrS2UxSkdDcnA0TWpUa0U4ODBleXVHSFJlSUw2S0hRbFVsTGZpUFlT?=
 =?utf-8?B?cXB4ZjV6OSs1d3JQSGE5Umw2UldRTDV5U01TZXU0Q3BPcU5DKzVsdlQ3T2to?=
 =?utf-8?B?UHFFSjJTQVEzYmR1UVlZSnlGNFlidDJNckZFd2Y1SWJ5a3ppNWxRWC9paVpi?=
 =?utf-8?B?S1kzVlFYejVCWGFWeVZRZm90NzFpbVRJa3pRbFhibkl0Q3ZxcFhBWFJtQkhC?=
 =?utf-8?B?K1dTRnpyRjFmb090b2lUckhaWUJnL3QrL0hocXVqTlBGMHE5am9xQ052OFA1?=
 =?utf-8?B?a28rUnkySEtJOFh4YWptL25XRkM3Yk9HSERDSHpGQk0vMmt0MGVXQjM5VFhh?=
 =?utf-8?B?SXpiQ3FiUC9kTU50dnZkTFp0ODY5cDhBb0ZJQ3l6SW5URzA0Zm90eVQweUht?=
 =?utf-8?B?Y0FSdUx0dUlKb0RvT1cwUUlRVFh0cDhvcTNPaDNmUVAzbm0wTGwwb3ViN3o5?=
 =?utf-8?B?L3FGS0ZiN28wSGx4RDZjU0JCWkltMWxnTzM3RDdtZXY4dFRnYndUOGJ4SmxE?=
 =?utf-8?B?RVVNdlQrVWczTy9YUHVsQ3VqeFBOcFBwRFM2R1VqRDlCUGxXSktHUU8zbmho?=
 =?utf-8?B?aXJWK1JqM003Mlp5eVdocDNIeWRFYk5qR2ZaNzJRMm5QbWVqSGJ0UXVxOHVo?=
 =?utf-8?B?YWxEbkpFaTM0N29lZFdkak1HaEd0NXJKZUJOWGxjUmpFZ3NoYlpBRzN3RTZW?=
 =?utf-8?B?NVBSbU40bnZlS25HRmovZ015NGtGZVd6VjA4cWNmdjlhV0JlcnhyZzBzOW1G?=
 =?utf-8?B?cDEvM1puTE5QaU9ESmZUT0NPQVdjcXhoWGlQSUIzM3cwMkoxditScXVnRUp3?=
 =?utf-8?B?d3hYR2FyR200ZEZIL2tjdE5SbHFPTDdleEl6QmZWV0ZDRkxuTXVtRFljbEVs?=
 =?utf-8?B?S2hwYS9mWDR1S3BiSDc1QXFOSWFkNFVoUlFZVmZKOGVhNFdXYXEzemNwYUpS?=
 =?utf-8?B?Q09Ia2tVMERBWmloU0tzL2Q2akJYbk9HOEZuaXVpUG1CejlkbUV0UmlRYTVB?=
 =?utf-8?B?MHhzV01UWjRILzgraElEa2p6SUptSFE2b2x6SlNUTDJpbDdjZzhrUlhyUUFT?=
 =?utf-8?B?M3YwSVkzV3lBd3lqa0s4YXdCejNqUjd0dXdGMEtIMGhyRitpZm5zQXJrSFoz?=
 =?utf-8?B?WlQ5Mkd2d3JOUXdGdTRVbW5pbUlyNHd4MUdtMHYyVkFRajFQNVlub09Cb2pt?=
 =?utf-8?B?b1RvQ1NiQXZiVUFzalp3T0lHVy9zbGp0ZTJ0UnJaQ2V6WDNCYitkWlM0K2Rv?=
 =?utf-8?B?a0Vub3hncm0rZElnVXVsZ1JkdjdJeUlXbzIwMFd4MUtUbkVOKzkwMWNkM29p?=
 =?utf-8?B?VjFPZGt5M0hwbUJGVnVvUjdwcTY3UjVBNEs4eWxiaGNNazZnbHgxaEVvMHcw?=
 =?utf-8?B?UG9VaTZ5bzJSOXQ4bjFVeCtqbmZPN0Q2Ukpob1JHaWYybk1SNTVJNExaMVFy?=
 =?utf-8?B?eFhia0dsK05uOVZkdjNvMlpISmFxZlJ5S2lIYzZIdWdMaU84NUY4MVdJZEdO?=
 =?utf-8?B?L1NDNEE3S3huVjhLaUJjSzZjVUUyamFJT2FlL1I2RXZQSTU0U0pDV0FYNkla?=
 =?utf-8?B?dUtxdWd2bnFmVkhEcEw1MzNmS0pGcDdOZTkwWlY2ZTJwRG5hUkNDNjU2MzBq?=
 =?utf-8?B?NkxkUTFxL3BrZWQ0SGo4RnU3MW5BNCtMQm9MbzNjdzI5K2xtQk5jaDFPNVRw?=
 =?utf-8?B?OEQ0SGhYY0luTXVtYjhLUFhmK0JPclFZVnJYSEtCL21DY05IRDcrcFUxTXA3?=
 =?utf-8?B?MERxUytNanhOV1U4UVc2YUNrZVpkdVd2S0YweXlQZ0tjUG8vZ244QVVJM3hj?=
 =?utf-8?B?Z3RGM1lyck1BUkpuV3BWdThxVUF5YU45SVFMV3ZYeGNBUnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk1VQmh4cFd6SHFkcC8velVBa0dRUGpic2x6Y2JKcDVQMkhueFVGU043bzZJ?=
 =?utf-8?B?MmNVMjI3dGgzRFZmc0NvRXdjTC8xbzBNb3pZZDZsWjBHOGxHdnZqWDl5RXNK?=
 =?utf-8?B?bFo3MUlzenZDRUN3R2lwQ1BsYlBRcC9lZ1U3WnJxZXFiMFpkWDB0SUJWKzkz?=
 =?utf-8?B?UUZyK0MwK1Jsb3ovZEtsQ2o4bVpPZWJ5MDc5NlB2ZW1IWktYZmxPTWhqTlRB?=
 =?utf-8?B?R2QyQTNmZEpYQitlb2J6aXdPd1Z2SVczK253bXF3SEUvYnY3am5YNkFTWU5U?=
 =?utf-8?B?SE9yZS9VYlpjL09nN3RIRHdQSVRKNktzcGdvelpjMmJ6ZEMybVg0WUJBUDlL?=
 =?utf-8?B?Ty8rN3NVNWxTUFU2T0syR0ZTT0JjTDZ4MEFzbHlERVM2bklXai9lZ1lhZkU3?=
 =?utf-8?B?SnRuWWpHV093bVJldmYzbWI2U1VuSWRzSE1WTCtmRmxMVVBMaXJobGNjaGJn?=
 =?utf-8?B?c1MzR09yblEyWW4zU3NUY0I4YXhnM0RDVytDZnd0ZUo5Zll2V1Z3UXk1WG5X?=
 =?utf-8?B?ZkN0NXJnMndXUVp1cmpLSzZkTk1STzd0OHgvV0ZtVGxaeVUzRm5LK0RjV1FZ?=
 =?utf-8?B?cTRJeGxLSm1BcThZMzd3UG5pQXI1SXBOV0tLZjlzVUhnL2tGbGE2ZFkvZEI2?=
 =?utf-8?B?SDUyMnVZeHdLcUlqeURaZ21JbHpFcjgrai83VFdsaHFkRDFvRHZsRlBNQVJu?=
 =?utf-8?B?WVpzcUc0Q0o0eFVyM3ZxZEE0TWl3MXV4VisyT25VUzl5cTlPYlo4MC9MUlZr?=
 =?utf-8?B?S2NuN2VOVm1RNDBrYW1HR2swdElGMiszNGF6TDJRMVMyMURuNDdzeWw2VnNt?=
 =?utf-8?B?Z3E0TGtGdzkwRnRHVXRHVXNTTVJmTzR1SjhDTVJmRW5OWWNUVkk3WnZkUE9J?=
 =?utf-8?B?QWVMYTk5SUtuYXJvWThHaUJDdzBVZjYxaFFCbTBFc3lkSkE5Ly9Ybjk2UTBq?=
 =?utf-8?B?MjNBejJqNU5QQ09YeVJDWW1BN20vOXI0ZnNCSCtWeU8yMVlUTWdaN1FqNkh3?=
 =?utf-8?B?WDBtTFNsczlvSDViVStxTTVydWtna3NBMTJ5bGlQdUU3TEdhNzlGLzhnRm5Z?=
 =?utf-8?B?SW13V2hrenhvOVM0L2pZREFISmRiT1U5SDA1N1Z6ZnVDRjl6VlFkWDJ3aENx?=
 =?utf-8?B?UkJoYjhBUktGajd2SVdPT21KMXIzNWFma2YzT0ZoamFycEJhWWQ5QlIyZHNv?=
 =?utf-8?B?dXRJaUZ6NmhBQjZuSURkRVlCU1BrMTJ2amI1SlZLMVU4cGsveGRZUGp6RW5C?=
 =?utf-8?B?K0Zza1FJejdtQzRvTDJkVmRReHZPVTJpcnJHUTk1R1lIWmthMkttUUdmRHYz?=
 =?utf-8?B?UXFud1pzTXlKY2FtQVJybjBQYVdYeUxaRmgzVlJDSnpLYUtuWUdNaUFRSTRX?=
 =?utf-8?B?NlYxKzJpZi95WER2QzY3QWVEb1BkbS8zWTF2Z2tiNTNTdzVoSzRDb3FWTFA2?=
 =?utf-8?B?enhMalFvRDlQNmRiNUpTTWNwaFhqMjNoY2RROGM0UEs0ekM0ak9NejRRRHFS?=
 =?utf-8?B?STc5dHFNMUxDTHBNNS8vbEFCazE1TWRRUXdaWnRNV1ZkNmZQdmlhZmdkOXVV?=
 =?utf-8?B?bm1iS3hvRnlobldudjJib09ZY2xDZ2R4aFZ0TEYrZnYySDdGRzQvcW0rS3pk?=
 =?utf-8?B?ZzhNcW9vQm1MSCt1SlVXYUEwVXgvTVVQdjhQcE8xMUZwOUM1bmd2ZWhZeFpU?=
 =?utf-8?B?UDBIS0k1N25kNituZStsdURPc2lSa2VMVUk1VFc0K2pXK2ZQbkc5d1EzZ0dm?=
 =?utf-8?B?T0dld1RTMjNEV2RDNUVBeUVYckZudVphV0lMU2Rib1N1bURBcDZ6THJIeFh5?=
 =?utf-8?B?cnluVFovVktIbXdrZ2dpTTdHM216d0pFY1RkRnRiUWlkYnkwZXE2R0w4WHRL?=
 =?utf-8?B?aDlXNGtHMndlTXI3b1d5Yk9vcXhJUlMyckFNR2VwcmI4K2dOV245VFNFWi8w?=
 =?utf-8?B?QVpGRTFiVytaczYrS1FubHpxbC84b2pwT3NGbE5jVTVjcjNlMGF3Y2Z0Z055?=
 =?utf-8?B?eVpkcXpQTFU1R3lUYjdjeVo0d0U1SUtLSjRqL0hDVnpqUkQwMlNTVXRKQk4x?=
 =?utf-8?B?SGxlYm5JU3ptK0JIZTZXaVlUbHlTdDBiaVhaRnFxWFpybkNOTDMvNG9QR0Yw?=
 =?utf-8?B?YTlOWHJuRVZPTEpOT0J1M0poakNJemN6N1N5T1RQaDBldDRiQVU5M29MWnVs?=
 =?utf-8?Q?3A7SAz+MXL67W+GwtrOE6VI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08B2AD052CAE0945908F8456606A5675@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0ffd8f-5727-4628-4f55-08dd51161d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 18:49:18.2374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sx3YezifI0HhTCuTwHMEUhfNiXhv9PZqsE3YGrqA2c+6DCKSRmSCSeEzj8JxDvgMvsiLt+XRM1ZDsItwGE/zDEGMyJpRX6Yu6NHkhubqWzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6232
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
IFZhbmthciB3cm90ZToNCj4gVG8gYXBwZW5kIGEgc3RyaW5nIHRvIGEgdGZ0cCBwa3QsICJ0ZnRw
X3NlbmQoKSIgQVBJIGludm9rZXMgInNwcmludGYoKSINCj4gZnVuY3Rpb24gd2hpY2ggY29waWVz
IGEgc3RyaW5nIGV4Y2x1ZGluZyBhIG51bGwgY2hhcmFjdGVyIGNhdXNpbmcgVEZUUA0KPiBub3Qt
bnVsbCB0ZXJtaW5hdGVkIHN0cmluZyBlcnJvci4gSW5jcmVhc2UgVEZUUCBwa3Qgc3RyaW5nIGJ5
IDEgdG8gYXZvaWQNCg0KSXMgdGhpcyBlcnJvciB2aXNpYmxlIHNvbWVob3c/IEhvdyBkaWQgeW91
IHN0b3AgdGhpcyBwcm9ibGVtPw0KDQo+IHRoaXMgZXJyb3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaGludGFuIFZhbmthciA8Yy12YW5rYXJAdGkuY29tPg0KPiAtLS0NCj4gDQo+IExpbmsgdG8g
djE6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAxMDcwOTM4NDAuMjIxMTM4MS0y
LWMtdmFua2FyQHRpLmNvbS8NCj4gDQo+IENoYW5nZXMgZnJvbSB2MSB0byB2MjoNCj4gLT4gVXBk
YXRlZCBjb21taXQgbWVzc2FnZS4NCj4gDQo+IMKgbmV0L3RmdHAuYyB8IDYgKysrLS0tDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9uZXQvdGZ0cC5jIGIvbmV0L3RmdHAuYw0KPiBpbmRleCBmZDljOTQ5MjkyOS4u
NDIwZWE5ZWNmNmMgMTAwNjQ0DQo+IC0tLSBhL25ldC90ZnRwLmMNCj4gKysrIGIvbmV0L3RmdHAu
Yw0KPiBAQCAtMzQ3LDExICszNDcsMTEgQEAgc3RhdGljIHZvaWQgdGZ0cF9zZW5kKHZvaWQpDQo+
IMKgCQlwa3QgKz0gc3RybGVuKChjaGFyICopcGt0KSArIDE7DQo+IMKgI2lmZGVmIENPTkZJR19U
RlRQX1RTSVpFDQo+IMKgCQlwa3QgKz0gc3ByaW50ZigoY2hhciAqKXBrdCwgInRzaXplJWMldSVj
IiwNCj4gLQkJCQkwLCBuZXRfYm9vdF9maWxlX3NpemUsIDApOw0KPiArCQkJCTAsIG5ldF9ib290
X2ZpbGVfc2l6ZSwgMCkgKyAxOw0KDQpCdXQgaXQgZG9lcyBpbmRlZWQgcHJvZHVjZSBcMDAwIG9j
dGV0cywgYmVjYXVzZSBvZiAlYyB3aXRoICIwIiBhcmd1bWVudCwgZG9lc24ndCBpdD8gDQoNCj4g
wqAjZW5kaWYNCj4gwqAJCS8qIHRyeSBmb3IgbW9yZSBlZmZpYy4gYmxrIHNpemUgKi8NCj4gwqAJ
CXBrdCArPSBzcHJpbnRmKChjaGFyICopcGt0LCAiYmxrc2l6ZSVjJWQlYyIsDQo+IC0JCQkJMCwg
dGZ0cF9ibG9ja19zaXplX29wdGlvbiwgMCk7DQo+ICsJCQkJMCwgdGZ0cF9ibG9ja19zaXplX29w
dGlvbiwgMCkgKyAxOw0KPiDCoA0KPiDCoAkJLyogdHJ5IGZvciBtb3JlIGVmZmljLiB3aW5kb3cg
c2l6ZS4NCj4gwqAJCSAqIEltcGxlbWVudGVkIG9ubHkgZm9yIHRmdHAgZ2V0Lg0KPiBAQCAtMzU5
LDcgKzM1OSw3IEBAIHN0YXRpYyB2b2lkIHRmdHBfc2VuZCh2b2lkKQ0KPiDCoAkJICovDQo+IMKg
CQlpZiAodGZ0cF9zdGF0ZSA9PSBTVEFURV9TRU5EX1JSUSAmJiB0ZnRwX3dpbmRvd19zaXplX29w
dGlvbiA+IDEpDQo+IMKgCQkJcGt0ICs9IHNwcmludGYoKGNoYXIgKilwa3QsICJ3aW5kb3dzaXpl
JWMlZCVjIiwNCj4gLQkJCQkJMCwgdGZ0cF93aW5kb3dfc2l6ZV9vcHRpb24sIDApOw0KPiArCQkJ
CQkwLCB0ZnRwX3dpbmRvd19zaXplX29wdGlvbiwgMCkgKyAxOw0KPiDCoAkJbGVuID0gcGt0IC0g
eHA7DQo+IMKgCQlicmVhazsNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcN
Cnd3dy5zaWVtZW5zLmNvbQ0K
