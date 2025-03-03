Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC71C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 08:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153D080F70;
	Mon,  3 Mar 2025 09:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cQNbuINx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D74810ED; Mon,  3 Mar 2025 09:10:54 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5457809A5
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 09:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoEitVByrt8qKgO2SjZz4AuOeW1tjyiwcq7kQQxnPqOYNjXZggyybfbLuSH84JOKYW3HIc/zv2ey+hpPk5kUYn8dAyV+n3vKQcqQFgFuqbxxYV6qB2R9PPZMASJ5k999E/GYXxQkwIuybfbp850CCkJERzRrJOqPkLjvlqeY0cP8fqlr+zYYBAPji6LU7lxA/TssC/mnB9m075iacqv5tjP9gzX5DJvu+PGoRNDzXw2TARN8k/8VKDindXyYExXkXc+S+bd2TsJt+dlpHkuEOSTI7XyLJXvtjAo/Fnf338vywsT1N0cXoTcLkQwzLP1+1hWn0m3Tw8UR92zJwwkTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRTnlHIbFMBOPILk3tPGN1lI2zPDUeE3YIODhPSvRoY=;
 b=P75jYmhc6Av9ckxLffGbKbDsd/4HwYPP2bxXsamzhlCifCt/L31s6BdKOtStlkesXRqdUcdUz+topM+fcbVzTwu+lJSEjmi9v+phR94W6kQWUBnLHZj/RAo84/5+Ig9DjlGF66LVi6rQqcVKemjSji5akSkzKG3JEqG80ve3MyKSvEeZEUlKJ4jqERojvpwBhVNWOM2AvrLDsxHX37//5mnHKOModYVm3UG8TOxzHU94k+9GY8/eHWmthM2aLpdsdlG8/mbt2E0LDlZMfN9nLxLSLj6vSSoaMwUnBCgh0rqgRC3yJ8Pcd39ZoqjA2V+LlKYHbdh9LGPBp3dgVKVrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRTnlHIbFMBOPILk3tPGN1lI2zPDUeE3YIODhPSvRoY=;
 b=cQNbuINxM41lCPbSMFG/3pnQq8rgYdryQyAN4+q1urW524QfhhdDSEDyBJ4ObxucA1ibFnLjpjTlNp5knnA1ThK5ZAED++YSg4m0ukgqezgaN58s71vpSYcAHD1DhxTlNjVSUxd0Z1eRF6YTY0q6nCqFf4bFzhtePUoFzKzTiUlRFtKXlI+IRxEXyrOkG1Gk2mWGxhtVqbDeaL9+qu803Kco4oOa8w2FKLk4aQvAmkpEDWo/cFa0+7cypsivppqrMoApwPbI+Yjx/ndOt9LhUcYim9IjQCkLcQgjH37VJd9tIJ1H1BFmOnl023VeSgWt/Voz+rF09hi4os6AYa9eEQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 08:10:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 08:10:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjYgMDEvMjBdIG1haWxib3g6IGFkZCBpLk1YIE1l?=
 =?utf-8?Q?ssaging_Unit_(MU)_driver?=
Thread-Topic: [PATCH v6 01/20] mailbox: add i.MX Messaging Unit (MU) driver
Thread-Index: AQHbic8ospNfadPRyEKwVnOhwZB8rrNdFLaAgAP9iZA=
Date: Mon, 3 Mar 2025 08:10:48 +0000
Message-ID: <PAXPR04MB9644D3909B71154A848B0A4AE2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-1-09594e93cc9b@oss.nxp.com>
 <579c1f50-1a7b-4663-98fe-c2687614079f@denx.de>
In-Reply-To: <579c1f50-1a7b-4663-98fe-c2687614079f@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB9085:EE_
x-ms-office365-filtering-correlation-id: 89c057e1-2909-4540-f0b3-08dd5a2ae7e9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?K3BiWG5IOWpTTVNoMGFjMFZCRmdMemNSOHJZSlpHSWtQZE9tNFRoMC9lUlRp?=
 =?utf-8?B?bVc3OE5Rb3RxWXh5K1VleW12V1ZjcnRzSGtka3ptSk4rSWx5Q1h6OGpsNVhr?=
 =?utf-8?B?aXdGWGkzWDROTTdabTVDd24xcnlqQlJKN1dTRmpLY1NJRFlRME9COXU5YjZ0?=
 =?utf-8?B?U3J0NURDcGtmY1lUNSswWm9ndGprOXNCRko1NWw2RG8wLzFKZlhwVjRLbTgx?=
 =?utf-8?B?REU4eXliMENhMXRGNFVsOXgwOUtLczZ2NmlmRDFpNnJmRi9UNmZ1SGw2QzZG?=
 =?utf-8?B?SG0zV0o0UE5qWVJYcTBBd2dVVS9DTlFoYmZiajRMT0M1VDZUMHJncXRleVJM?=
 =?utf-8?B?dU1KMmR4bDlFcitaTE51eWVqSVlQai9lbzA1ajIrWjJ2WW9vL3paMEVWcW1x?=
 =?utf-8?B?dkROSFdXOEdVOEZZQ0Ewb0lBallzR1V6WlZhM3JtcTNmNjR6eTBadlk4UUdY?=
 =?utf-8?B?K3M2cGNaaDE0NkV5eFExcEJMang2Nk5xanZ3OUg4YmdIbXZCWDZTVE9SaVN5?=
 =?utf-8?B?UE1MZGljeEtQQVNFeWgxMmJ0MEp4MUo2UDFkelNYM3liVHo2ZG9SVzNMSy9s?=
 =?utf-8?B?c2Zra213WlVUbXcyTTFVb0F3dTlWUFVucUtOVXVVWnFMdUo5dlNSK2VYanY1?=
 =?utf-8?B?YWVYK045eWp3akUyNWFlU01oTGxKWUFwcWUxREhuQi8wMVlxVEk1anY1L2Vt?=
 =?utf-8?B?QVNVVmVhM0lMTkdERzBwdTFiQ1ZWbktsS0lVWm1xY1BScncwdjdmUDJ2R09T?=
 =?utf-8?B?N1M2ZTZKbERFeFljbFEwLy9OVU1SaTgvRTdmVGxxdm4yT1RIT1FIVHNCbkdE?=
 =?utf-8?B?dWdpRDZOSVpKVnVRMWs2ZDJSNzIyTE1RTUNQeTJPaWdxeVRsaXVyMHhUcE41?=
 =?utf-8?B?bTlKRWs4OWkxSFVOVXhmdjZwUmJNdjJkS0d2MmNWQ3ZiRTVocFNTb3l0Wllv?=
 =?utf-8?B?UnVUQ3JRaHB3dFdwSE1iSmhMUTM5dUxmaHlXL3hvRURqNkR5WCsrcllsMVl3?=
 =?utf-8?B?MHcxaUVnenlHRjdHT2UydHduZmN5aFVuWWJORnpIRWdOazBJOEtDcWtucjRI?=
 =?utf-8?B?UDFsWUNwODI0Qy9GQnlCNlVzYmZGaWdiMmxsVDNHd2E0VU9RREhLN1BGOWF0?=
 =?utf-8?B?bmFZQmIvQnZtTVpqZU9GK05CY05rTHJBSGd2VktYeEQxQVVzSWFSOGI2VFZ5?=
 =?utf-8?B?ejI0dHF6WS9uYXRucm1IVlh1Q1hZZEpPaWtnaktRWWI2UzNsUWpoMjhtcWhJ?=
 =?utf-8?B?TlRUZDkxMlhlT2dkeStocXQ0QnpSak9BQ3FRSWtSeXZJd3JsMzN6U04wd0Ro?=
 =?utf-8?B?MDVWWmo3c25Qb2YyalAwcE5nMk4yVU5BQjJMcit3SytUTG11dzRIV0wvNStq?=
 =?utf-8?B?T2gzSGxoUTJLQUFlelpyQVlhZHNMU2JiT1RUTHpsYlZhQXp0aGhmWEQrY3NQ?=
 =?utf-8?B?a0NpZHpJaUY0VUg5Zmhka0hob0FwMkdxTTJqaHRYZGwwMjJtRi9KMnlIQTFo?=
 =?utf-8?B?VTNaTEtjU3FxYzZIOTFrNGhUcFdIZE9XK3lqczgrT3Z5T2g1anZoR2lhL1hY?=
 =?utf-8?B?QU1Hc1BHSEdWS0NUeWNtbExQVXhuV2YrMm9TaXRFWGdDUy9hb3BXR3VNb0RO?=
 =?utf-8?B?ZzkyYy8vM1dPa3h5L043SjlHbWxjaUQ1R2g1SVg4SUZUT05JdmV5Q2JqTlhW?=
 =?utf-8?B?WU9uNXduNUh2Q1RuYnRnbGVWcjdDUEhDMzFNNXdzekpJWEF6SmQyeFJYTHpl?=
 =?utf-8?B?Szd6bXBqWWFVWGVuY1lrTXgxSmpBMGFSUHovZW91UjYyVGY1SmpGclJxcERT?=
 =?utf-8?B?Z2xqOUpqRUEzWTROQ0haVGoyWTdtYitQZEtGL2Y3SU1NZXBmVUpTdW9OM1J6?=
 =?utf-8?B?aFg4eUFOZU9NM3kyOEY3TFR2VHUrUFNhTEhwT29MZE84Y3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUsrR3N1MXlnYTZlK1hKVWt3NGRHZUZxV21ROGJFVjlHTDBxZ3F2NlpEcEkw?=
 =?utf-8?B?YWRscVFiMTV1UEFGWENsRUFDMENIc2JqZ2E0cWJrY3YvWGx2SEIrYU9PT0Zs?=
 =?utf-8?B?a0FDbG9GNUNyZTNubS8zS3pYZFFRRnh6LzNjMkdaOU1CdlNadmxBRitralBv?=
 =?utf-8?B?V2QvSFpnRWRIc1lIdFh2MVFXRCtITm43YTUzS1M5bEJaZGFkQnNHWloxMHVu?=
 =?utf-8?B?bTZzS1F0U05DYkFsNGxrMUgxemhIQWllK2FDUzJORndQZHEycFg4eGxheTJQ?=
 =?utf-8?B?b3RMbUJpZUZlaHZpY2pGeEtWZUY5RVowSFhjRlIzUHNDUHIxU1JqaDRkdnRL?=
 =?utf-8?B?NC9BOUZGQzcvOG5MVnBmK2pidk4xa1JnZmtHSEZnenpQRWVVREIrVDNjUEJj?=
 =?utf-8?B?cWdpRzNaNko4NGpoS3cwYTFQV1hKaTdoTVJIOUJ0c0ZOdGtBRjYwNUVYSjRL?=
 =?utf-8?B?cUVqL3FpOFhZQU93UmVDaUJBSWo2Vyt0SW5OVXA5VWsrZnU5MkgwczFKcDQz?=
 =?utf-8?B?TUNsV0VyUXFHeFRNUHhHQ2RlODFnZDhyR29vTXdxL01lMzk5c0UzZ0djV1Jx?=
 =?utf-8?B?dW1DbU10dUF4ck9NWnVQYTNRQmFGY1BRNWkzNGI0ald5NXVnbkhxMjdqYmJx?=
 =?utf-8?B?VDdsTlFsT0VMVkJWcXB6cFhTcTcyOWg5T0Q5QmtIeEhQRW5NUUE1NjM1WG0w?=
 =?utf-8?B?SEs0N3pIQUNKR2hXSEZlcXIvaTZpOENQMThsb1ZNL2Y5WVB2TEsrdjhZaUZ1?=
 =?utf-8?B?MTZIWHlObWU5UTV1MnR2ZXJ1Q3F0LzR3WUJ5UmNhWHhFSForUDlUM3BqckFj?=
 =?utf-8?B?MTZvRW90a045MmxWQ0lqaG1Qa3dKSkNhYVZvTVRYMEcyOUFnbXUzWkNvM1hQ?=
 =?utf-8?B?aHhpY25BaTJVQXdJaUdqd3ZicFlNU3h4dHlPS21SenlJaEdQYlg2STROUzBs?=
 =?utf-8?B?Rk9reXpnUG0vRmFuTXlTV1BqRWI5UzZlNmh2TXZlSmRwajhRSlRLc3YvNEdz?=
 =?utf-8?B?Q2UrR1lBbE1Dc0J4cjJFcnRZTEY5dGVQbmJneVV3eUN4MlZTOGV6WXVzdkhP?=
 =?utf-8?B?eGlMSmlwazRWaEh2cEVrOXF5d2pVR3hKd1ZBdVIyckdQd2R1OXRQcWJ2UWhz?=
 =?utf-8?B?aE8rYlB6UktSUVlWSm1DNkVUeGtaNjhhbXp5aHFkMDBDUlRDdUJ6Ukw1Nysx?=
 =?utf-8?B?QXg0K0k2WUIvbktNWng2b1VxTHlJaktUdSs4aDB5QVg3Y0NTa1ZKM3MrOXBQ?=
 =?utf-8?B?RWN2Z2hVUWdLVmhaZU10NlppUTdoWjZaU1FCT0NwNE0wZEVkT1JGQUxyMHNh?=
 =?utf-8?B?R0ZiSjVad0RybldNc1hkK1hTY245bXJQeDFEU3NtdXZFNWZJcnpyYTNSUzFE?=
 =?utf-8?B?RmhLMC8wS3duM0c0Q05CNXlPRTVrdEtpd3JSaDVBREJwMXFQZG5LeEhrNEd4?=
 =?utf-8?B?L3VOemk0NndETVUwV0tCUmpOYVpVK0dLTzNObitNNS9BeTVJYXNSZkc4TXg4?=
 =?utf-8?B?eDNYaHhyb1lLdkJSbzRISmJXZFBuQ2I0djI4WDZoTzNhMlFlWXFXK3hZeE45?=
 =?utf-8?B?RU9hMy8vWE5yQ1hsYlpUYTRtZU9XdHJpTkVJL2lha1gwMG96VEplZFArRWpZ?=
 =?utf-8?B?LzNvYThBTmY3MG9odmZjSDlKWk5ocnk3eXQvY1AzN29aS3NuQUgwbmtEaG9R?=
 =?utf-8?B?b1RWRjhtRmMvVXBqRzkvaWd5MDZ4MzNMRmtqanhnR2ZpRDFFTWtBcTljbjE1?=
 =?utf-8?B?bC9VV2lrT1JDamtmanB0SVFSTUFSMlJXOGVCa0pZMnIrU21zbkZpUEQ1VXJi?=
 =?utf-8?B?WHpQeGxSTjJheUd0RlJpS3FVSVhYUk52bW95SzlaQkdZNVNsM1Q2S1JZcHhS?=
 =?utf-8?B?TUJzN2o1YVBoZ2dMM05kaDRhTEFiRlFUSklSdU1oNUZYNGk1eGUyZUNtQ3By?=
 =?utf-8?B?Y0JIRThiZks5NlY1Tk9nRk1xYW5mU0I1K3F3SnN2OFZaazQwNlFMR0MwUksw?=
 =?utf-8?B?R0FyczQ1Z2s2aVVITXhkNmFCOGY0VG5uaXZxSEtkVFpGMEx3ZklJY1VsWEl3?=
 =?utf-8?B?eVRpM0YzN3VHRVZnZXBqY0tnakh0VkU0Z21heWVmMkNTbnBUcEVWalVCUXcr?=
 =?utf-8?Q?pi65ZEi668Hj8bCF993J+j8Io?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c057e1-2909-4540-f0b3-08dd5a2ae7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 08:10:48.2255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yG7JYFjlJ23Ff9Uys6LE1aXI+/65ITuxwQqGhAJkXKEm356ofMdPwrZGaCVDAEUUaJIAA5FSDt5vyC57HFJO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgx5pelIDM6MDkNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+
IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3Qt
aW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0u
b3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gQWxp
Y2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5k
ZTsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBWaW9yZWwgU3VtYW4NCj4gPHZpb3JlbC5z
dW1hbkBueHAuY29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+DQo+IOS4u+mimDogUmU6IFtQQVRD
SCB2NiAwMS8yMF0gbWFpbGJveDogYWRkIGkuTVggTWVzc2FnaW5nIFVuaXQgKE1VKSBkcml2ZXIN
Cj4gDQo+IE9uIDIvMjgvMjUgMTE6NTMgQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gPiBG
cm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggcHJv
dmlkZXMgYSBkcml2ZXIgZm9yIGkuTVggTWVzc2FnaW5nIFVuaXQgKE1VKSB1c2luZyB0aGUNCj4g
PiBjb21tb20gbWFpbGJveCBmcmFtZXdvcmsuDQo+ID4NCj4gPiBUaGlzIGlzIHBvcnRlZCBmcm9t
IExpbnV4ICh2Ni4xMi44KSBkcml2ZXINCj4gPiBkcml2ZXJzL21haWxib3gvaW14LW1haWxib3gu
Yy4gSXRzIGNvbW1pdCBTSEEgaXM6DQo+ID4gMzlkN2Q2MTc3ZjBjICgibWFpbGJveDogaW14OiB1
c2UgZGV2aWNlIG5hbWUgaW4gaW50ZXJydXB0IG5hbWUiKQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgdWRldmljZV9pZCBpZHNbXSA9IHsNCj4gPiArCXsgLmNvbXBh
dGlibGUgPSAiZnNsLGlteDZzeC1tdSIsIC5kYXRhID0gKHVsb25nKSZpbXhfbXVfY2ZnX2lteDZz
eCB9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OTUtbXUiLCAuZGF0YSA9ICh1bG9u
ZykmaW14X211X2NmZ19pbXg5NSB9LA0KPiA+ICsJeyB9DQo+ID4gK307DQo+IERvZXNuJ3QgNi4x
Mi55IGFsc28gc3VwcG9ydCBNWDdVTFAgYW5kIE1YOFVMUCBNVSA/DQo+IA0KPiBBbHNvLCBwbGVh
c2Ugc3BsaXQgdGhlIE1VIHBhdGNoIGludG8gc2VwYXJhdGUgc2VyaWVzLCBzbyBpdCBjYW4gZ28g
aW4gc2VwYXJhdGVseS4NCg0KVGhlIHNlcGFyYXRlIHBhdGNoIGZvciB0aGUgbWFpbGJveCBkcml2
ZXIgaGFzIGJlZW4gc2VudC4gUGxlYXNlIHJldmlldy4gVGhhbmsgeW91Lg0KDQpodHRwczovL3Bh
dGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvcGF0Y2gvMjAyNTAzMDMwMzUyMzEuMjY4
MDE5OC0xLWFsaWNlLmd1b0Bvc3MubnhwLmNvbS8NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3Vv
DQo=
