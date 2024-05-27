Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FEFC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 09:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE3D88167;
	Mon, 27 May 2024 11:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aAykjjJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B19F882AC; Mon, 27 May 2024 11:15:17 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 594F587E3F
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 11:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk2lQAu90/r/XGVjEN/hioQPjd0wpX3Ky6t/8OUsNOaDM5mkey7MM4eeA+yWhwB8bnNUZ4xZ2WpNa1htQJ0du1tHyCcN4REUkAtYgtfhD/Hypyfq9/84TJ6bzwXKE8OK6EdYUdwGFOR+i3RTxw7ptm4SV+wvN6MaRx0Z/kCZa6leNQKg+o2qXhDqWvdSd2pw50OHrKlIXjwI4uCbHVI1J7xtcbAtX6ycIfCmt8R28kmIbT8k3ldL2NqT23SBBRF2J4mXk1uaXl8MWHljgwBRDHZBqYPomuaOVfqup+k4+CnBpcb09WbFnhun8iOrv8plqjsHFYswhMb6qTAdaCmRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZr8giFh0YIzxrHJBoyTasxGiHyHk1sZhKgB87SUfmA=;
 b=KbXIyp/PgvmQq/9SHO8P8eHWUt0UXjByzOEtVAA9WQbBiVwuvcchWazwspc8Rqt0lTD7Ys5nnY7Ut7ttT9yL8F5YDuo5L5yc9H9fSe0dLMxULF4lAN9hn/kJlLPcTCfyNi2vAvi0RipeLXccYzUld+MCGnzoiLdwmy1UcKQaS4Cy/V1xQjvKsNC0e+heWBWub6ONkUpJMiWfo3xJEvU2esg64h37cMCQ+c2TEj9bhfcHRhcREcTLFr1nJxQGdZDRKFAPpvtvGcaZTQrEz130aWmIlXwWq7CGMBDf2oflnAfgNJJIKEFR94M8dRCyv/KjV0QaQvEQEBOHNVxvOQOUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZr8giFh0YIzxrHJBoyTasxGiHyHk1sZhKgB87SUfmA=;
 b=aAykjjJ4TE4R2rQ+aX1Tlee01S78mfpHjQnZfAykLeHgOAfg2HaMYzBsRwMlTmAH1lpaUp8bhiotu3AH/n9vch6yaFPT1rW+aIQLkGOuJfF76P3op56K184ohtQ3nbD0EmwoezLcpWN+4wBc+fVRy5Z8Av4aJlrojTqMhz4/WKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:15:13 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 09:15:12 +0000
Message-ID: <54c87774-9caa-446f-bf8c-46f23b6a2422@cherry.de>
Date: Mon, 27 May 2024 11:15:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add ArmSoM Sige7 Rk3588 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>
References: <20240522165801.1871915-1-liujianfeng1994@gmail.com>
 <7e603c4d-bf76-4b38-894c-30d2cf128217@cherry.de>
 <CAFA6WYNZh4BH6y_h_BkkVgHi3rNvsWd++mC2BDwqOF-NB8eHtQ@mail.gmail.com>
 <CACQ+3oZs6xt5d3aFCBB3vesMqj3ebOoAqxkg=26Z3JMX5dU-vg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CACQ+3oZs6xt5d3aFCBB3vesMqj3ebOoAqxkg=26Z3JMX5dU-vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b98e44-5e72-4bec-271c-08dc7e2d8370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M09VQjJDQ2lsTGh3Q0gxS1NBWXJKb2IyaDN4SkFWTzF5ejNXNnM2N3d6RGpI?=
 =?utf-8?B?d2l3ZzZXVzM0TEE3RXdkTWxwNGlGREREUExvSGE5SGtZVUVqaGtZd1BIajBL?=
 =?utf-8?B?RGRSaml6MHVMSVJFUWNpUFUxa29pdjJCN0hSZzROd1FqajBPRkYrT2dqNkxt?=
 =?utf-8?B?bG5BV1pXN2d1YkFOOCtnY3pROXhDd3hnNTJnNXdIL1hPZDR4TDE1R0ZlRUR0?=
 =?utf-8?B?UG41UkFTN1RxdEtiazNFSzh0ZnFZS1F3SWtKWnB2WDZXNVVVblFkMmhyVUVz?=
 =?utf-8?B?WXh5QVR1aHpJdkx5NlBaUnpzWjk0Kzk0SWVnTlc5TGZJTTJVbHhoNitPZ1dS?=
 =?utf-8?B?c0IzS25PVmhQbGl1RUZGd284eEVWenJ1WGwxWHRyVDlIZG1TNklEczlkRUZm?=
 =?utf-8?B?R3VqeWNvSXNRYzBBRFNKQWxuaE1lYWtkbUJxckdpSS9nVG14dlMxVjhoYVdC?=
 =?utf-8?B?dmVodG9SQ0xBL2I0M1FrL21xRGpVd1Rnc0Rkc3BxVUYycy9GcG80anIxeVFq?=
 =?utf-8?B?YXlKWStLUzFZc1czMlF6NTdDR0QvSTRuenVaRGlITUtSTFRlN3A4cXNiSDl4?=
 =?utf-8?B?SmJMWTczMlZjenhDbXQ2dUU4ZnRmeFNiVktza0NKazN6elMvYjV3SDYvSnB1?=
 =?utf-8?B?VGMxeUZvTmhVYlFQdTc2eGtaNW53N2ErNEtTWk1QNlVJTVArb2VMZVZQMy9y?=
 =?utf-8?B?UURlT1h3djl1aU1FQkxRVEJ5YzdQaDNIZXRiSXVTT3hSZGRWT0RidGM1YnFn?=
 =?utf-8?B?UEZGdlFlNlhJVGRFd0JDb1FkT2M5TVd0b2hOWGFEN2ZRS0FrbGo3Q1lvM3Az?=
 =?utf-8?B?VS9uY0Mwb3RLb2Q4SVllZExOWllyTGhZUmh1S29hUmdYMi9rejVsZEhlc3Bh?=
 =?utf-8?B?UzNsVHIrUmhpRTZMWTNCb2RMOFpIeXdmQ3hPQmNyU01YZEs0Rld2VWFGKzZh?=
 =?utf-8?B?dE81bGNHRDNPUHllMHVkRmJIbDkxY3QrN2xGc0pDblVjYnJRMm01Q3RRQXpj?=
 =?utf-8?B?eEEvOUFUN044OVMvKzkzNnJMTzFNdU83RzVPc2ZJVERlNks1bWVGRkFNbHBM?=
 =?utf-8?B?WTk1bHo4SjZyRFlmUUM3WTY0UFl1eEdpUjVrS0xnTzZUTUZxRGVKcmR6TmZv?=
 =?utf-8?B?ek52dkJIV2RkQm5TazFwa0ltSWRCOExsMFR6b0VndTdaOTc3bWJUOTIzYThO?=
 =?utf-8?B?YjdxSldhaDdESXpjOFBWUGp6RGlSblRIWThOZ25sZFkreGJVcVRlcktmTi9U?=
 =?utf-8?B?bFJwOTlNV0NSQS9wQUpXckYyc2pPMHpSRVlZMzQwd0RSZjRRNkdJeG9TQzh5?=
 =?utf-8?B?bkpvUGZpSnBVbkorWkRYUDIzdWt0dnJHK1dvL3ZBU0NWeWxrdHQwclhjNllq?=
 =?utf-8?B?MG4zMnZURk1JNXI2Q1VlaDZOQ01qWWlJSjBaZ2xUaU95bERaeXZEYXZTYUl3?=
 =?utf-8?B?ZzBncmdvVmxvaWFWRTR6dkhSb1dTMEJLTHFoZVQ3RktrWjBJb3N6Rjc0Zm40?=
 =?utf-8?B?cndhb1BybXhFQ3lvRDNoQytLUU44ZzUvcmNvS3VaU3l3b3o1VlJib05VeU1P?=
 =?utf-8?B?MFIvQ3ZoNkExUHR3em1CcHEwcENyaGQ2OG5XQytMd2lrdVcxNXdHNjJvQ0Iw?=
 =?utf-8?B?di9NdVpmOGJOMHNkUUFTaWRSL0I5N0dZV2RwdXJLMlEyZlFocXZiN2p2VDF0?=
 =?utf-8?B?aGtSVlBlVURzeENuTUhzenRLdkxhM1cyU0M2WENYSlNrY2I2NHR0Wk5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(7416005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZTQ0VuYlRCSEdFMnFEMm42Z2tnZEJJQjZObVhkR1pUNEdtTjZqbEZTdXcx?=
 =?utf-8?B?SG5Kd2RwdUlnSENNWXNra1cxS1M2TkxVaDM1WFZ1MVQzalVGTkpBTjliL1Q0?=
 =?utf-8?B?anBycDZ1bE04MHpOck1vZlZXSktOeUNGSm8yYS9tdkJlcUdGa2tkY3BYL2Qr?=
 =?utf-8?B?V3dFQTNDNDFnMFdlSm9wTE1JTmxWMWozN25YemFueW10MzJmSng5WmdVVkcw?=
 =?utf-8?B?cjdtQ1dobmtRYmpiN21iSDhWM2JVU2dFZXBMTmhOd3FNV2JCMlJCTjFUaE9E?=
 =?utf-8?B?a2R4R0M4Qmdmc2M3OElEcDEwTHF3U2dNbmF0N3pBWkp1OFVndWRTdEFzb25k?=
 =?utf-8?B?bW5uSk91T1ZwTXhvYzEwY0M1cS9DRDVEc2FHNXR0SVQyVEt0WlBNUXBiUVAr?=
 =?utf-8?B?OEppR2RWa0N4cmF2RlZwRXpIU2dvbDZiTUpCWDIyM3N4VUsrdXJEQlNmR1ZU?=
 =?utf-8?B?UXJibFNCeXpwSTZPREpOM0hYTFp6NWlsUkdkZkt1cDJVckpNQm9WdTJVV04v?=
 =?utf-8?B?NWtxNW9SL0JydFhkT2NISGNJZGJ4RlBZRVE4bld4NVBEeW9EemxHcnl2Qmx5?=
 =?utf-8?B?RmgzcVI5Q3g2bEkyZEpaR29mZVZXMEVpdU1VblJtU21oSE9GMVQ0SGI1dGc4?=
 =?utf-8?B?Yk83T3dZZEUycmlWV3FiQ2Z3MWNPK3lQSU1pNHF3a2tDT093aksrdklIR0N6?=
 =?utf-8?B?eGREVlZaZHExSWdNQ2YwbnpoRDRpUk1GMVUva2NwdE9yc1VMdW9xaGQzRjlp?=
 =?utf-8?B?SzgyUDNaSjVIeFRudmdoT3ErdDhBRHNRMWdDMUprcEZTM29nVGdsekpvTEth?=
 =?utf-8?B?Rzg3L013dUV0M0h4UVdTSnE5YnppV0RsL1hwL3RxV1NWMU1RWmhBVWo1SUhK?=
 =?utf-8?B?R3BFa1ZIRHdtYTR0SVhXNkxyYkloR1pEc2FIbXpLS0Rxb2o0UUwvbnNMeDNj?=
 =?utf-8?B?OHVJNDI5UGl1d0pSZXljTjNqOFFmZGJvRUNic29HYTZBYjRuSHdKYnlKNHFq?=
 =?utf-8?B?b3ZDMklia09Kejcxd0JTbm9PbkpoaThKQjZaZDhjS3liYVl4TGRGbC8yaGVk?=
 =?utf-8?B?QWp1cC83bVplU1lMQnFTU3dhVDgzSUR5UTh2NTJGU3lPVEo4NWk3N1dnZCs1?=
 =?utf-8?B?QXhqUEMzRkI4SkRYeTdzMmxRT3ZhQTh0aGF5a0RQdld4WGJCWHdWRkFhN21Z?=
 =?utf-8?B?K21qcFZWck5Pak9YaWdleVVYd3JuQTA5Q05BQlJVc1VPc3l0Q0IrTU1wYkV3?=
 =?utf-8?B?ZzZLZlgzSUU4azBhTHVjNnlYVTFtdmp5UnJMODJobjc3L2x2UzR5a1JuQ1Fl?=
 =?utf-8?B?dDlQQnE4TW1kbGYzeXAxeXFLdFVIVldJTmZDYzM5UmJVUUZtR1l1d3ZBQ0RN?=
 =?utf-8?B?eE54NXp6UlAyVVgzeENFS2JVZXM5NkNXcU5VVk1NZkZSdk5ld2VXaHlCVEtF?=
 =?utf-8?B?d203Tk1XcHdiNG9DMFhVSGVaU0MxejQvN2dGeG1IK1dzVklObk1xWGE2Y0Ri?=
 =?utf-8?B?Zi9iZzBwakR5OHZPWHY3K1NOR0NwemlsUUd4RUkvWVYya0pMdVlqb3JOMGVu?=
 =?utf-8?B?alRGMm11dzdCazZuMzJDZkJicVkwanpuNWx0TTNha28zSkc5L1NHcHM3WGMr?=
 =?utf-8?B?UWNySEdUQWVpV1VaNlZERDZ0VktCOXljUURkbDJncVczbUlqUUVnOU5yWTRh?=
 =?utf-8?B?bHRKK1BMZWF0bktGdG0yM00zeU12SW5NZmJVSEhSc0tFQnl6RUZEMjFZQ3Qr?=
 =?utf-8?B?ZlRFWGtJb1NJYnEwaHlrMHdXYisxOWE0Z2dPZ3ZpNHI4VW9wc2Z4bmZZMFpk?=
 =?utf-8?B?ekVTeWs0dG5vWFprNGJMTm5WNWtLRmkzZVlGU1h1b3BTUURBOW8xeDYrTGhy?=
 =?utf-8?B?Q29ZeDQvQzlwQ21wMkhENmN0aWVsVjI4NzM5U3ZYSTRibWg4RVozVkpHeHFW?=
 =?utf-8?B?bzZNTFh1TGl6MXVlV2dFdGozNGh3MXA2OVE5Rm5LOUxoRUJTd2JSNW9ITG5Q?=
 =?utf-8?B?Zlo3aEpNSDI2NlNPNUY4akt6WXh6ZmxpeUt6R3VaVjB2ZjI3cXJlclZXRWg2?=
 =?utf-8?B?Ni82TWs5YmcxekFIc0VDUmpvbTBRSUh4SDFSSm05eXRWaTA4VElRNm0ybEFD?=
 =?utf-8?B?eHZ2M2dOcEJ0TzRPVURMQUgxZ1R0V2RQb2hLdDBiOFB0VFUwSkxVM3NJSlNt?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b98e44-5e72-4bec-271c-08dc7e2d8370
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:15:12.5245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpFhmstmz4Yg0MF/GkXjkv0bmvd/qdo73VT5lr+954H+TfwUBPyKRh7//k7149vUdbHUdJcI7WshNgeQ+XVnOP6W/xmlfY6nYRcqIM7Sj94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
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

Hi Jianfeng,

On 5/27/24 10:57 AM, Jianfeng Liu wrote:
> Hi all,
>> However... it seems we'll likely need to also cherry-pick patches for
>> the GPU (should probably be straightforward as nothing would be using
>> the GPU anyway in U-Boot) and the USBDP PHY... but this one we would
>> need to update all -u-boot.dtsi for rk3588(s) boards that have it
>> already to make it use the new label/DT, make sure that the driver still
>> works... etc. Maybe not a small feat, but someone will have to do it at
>> some point anyway :)
> Kernel v6.10-rc1 is released and now u-boot is not synced to v6.9.

It is, please use the "next" branch.

> What about syncing with this procedure:
> 1, Sync upstream dts to v6.9 with command update-dts-subtree.sh pull.
> 2, Cherrypick all commits of rk3588s.dtsi from v6.10-rc1.
> 3, Cherrypick all commits of rk3588*.dts* from v6.10-rc1, which will
> include dts of new board armsom-sige7.
> 4, Add armsom-sige7 to u-boot.
> 

You should be able to do 2,3,4 yourself now I believe?

Cheers,
Quentin
