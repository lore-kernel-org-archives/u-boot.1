Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD33C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 02:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E000882C87;
	Tue, 29 Jul 2025 04:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B8CIIgtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F4182CA4; Tue, 29 Jul 2025 04:21:27 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F0A682BF6
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 04:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpJsvfDN6uYZqQR6/fs1aQvEZsDcxVpmkPJZqJPIGdr7d9Sep8n/3t0larEsxknUR7gMFnQeHHdDnz8r+Qesx0zuZ2XE0deuFicdf3fKZkoxBjz8MrWwS6QQY/LXrWnfW03xn/NxX5XHD1q0H1p0qFq75f+ksRMretrDtz+amWYD1cT1srVNgwuIQYIi2bNLLZcrN1ojcIkSX6FblsHfuHoyJnB49pcveqGbVw/mJLlW4IEZLL+4EOKeRDelCnobeq9FB9H5ZA+sDw2cwxRUFLzg+s5yvdmd+av0iODNXTw/G0uUI46xkpi8xbpK0qAVKzgpnhCjE/g5uJFH3r/wTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6xfj4SDo19vfnT5scYexMwStkkAEDzA4JupaxSmUbA=;
 b=QElb2BzpVIICN4GJttKmbGHL67Tlzc14OmSL14yosYnIh9iVJnxRPmAazRt21AmAOmGoDVcrLxQLaHRbpMU9IDgzILlBZVeOvPaUOqwyq5nW8cUy5opWtGFveshRuNuza0xhkz+oK5KSqv9xk9Xzar9U+E3XJYg2/liPfJf2zIHDwQ2MW3gI8kaXJQTQyB5ENXmODU6RDYfqB7nnz8PxldMPkHznbJvCc8GrQdv/dYbSXBwUe8veML4Zbz0cqiExz9QleeHIh4j0inUN0Ba4hRKjIPbtNRDYthe2bTjEO2GPqyrnvdjnphDdz6dbVMYDcE++UoViEUK2C57zhIcHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6xfj4SDo19vfnT5scYexMwStkkAEDzA4JupaxSmUbA=;
 b=B8CIIgttFRuQ9LG/WorUZz8ENhzyLqTPzfxpRu/BU8jUUEXm1S4N7H/d9Id4f/5lCkeMPs2NnLmhZJlZoflcRZCsRAq4DN2MXWugXj77nId/wT01KnxFMl/q9ssjmpz+fSAXPoRM57t7xAfslB/hO5BaEc3iz15+zzT72QiNPh/rx/opmROGIWUGRj3JqRiYE8RK+3/7ECGCJLI3iPTpDizpDUNCYoBgS1YbS3rQhVyS7LxJtBgedbRWI7KbzhJ6++JkIUqmjaEXOQB6bxaICfHYaQZxmpM74dlmhuecqwLha73WXvxHPXbu+ok3Obd6q/l6hhOI2s2tWZxTyDaUGg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB9758.eurprd04.prod.outlook.com (2603:10a6:150:110::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 02:21:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 02:21:19 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC80XSBpbXg6IGFkZCBpLk1YOTUgYjAgc3Vw?=
 =?utf-8?Q?port?=
Thread-Topic: [PATCH v2 0/4] imx: add i.MX95 b0 support
Thread-Index: AQHb9VNopRnJWXkO/EGKWMdbKsFiUbRH6K6AgACJB0A=
Date: Tue, 29 Jul 2025 02:21:19 +0000
Message-ID: <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB9758:EE_
x-ms-office365-filtering-correlation-id: 8d49034f-6900-4c35-8461-08ddce469ae2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TitzOXhvb2xiM3RUR3pKZnZNZndlblFNc0c1T2xUQUJCdjFPTWk5MXloNXdh?=
 =?utf-8?B?emEvT2pNN2xTc1NsckQrQmhodUR5bXJhWFNObnE3TkdiKzNCQzVyVFhEM1JH?=
 =?utf-8?B?TE5tNXpRbmNwQTZTN1plVVVsTUkwZk1rcnFYNngraTlqVStkZnRQcEs5N3VI?=
 =?utf-8?B?bUNOamo5U1lhTU9GZWpQanFxdE9Fa2xjZ0o0cFVWMHA1RkFMWi9ic0Z5MDVt?=
 =?utf-8?B?d0JOK0xRR0twNFRUR24yWVdVa0tRVE1hcTF3QkRzQ2J3b2U1VE1KY0NyTUVW?=
 =?utf-8?B?SHdEdDlSNXFWZ1diODFwN0JQNzJJSEtzTjNaK1JJQXREQ241YnhocitKb1gz?=
 =?utf-8?B?NUtNZVpkWk04eWlMY1paSytIMTBLLzF6aHpLUEt5WFJWSExHYy9HRUFRajZi?=
 =?utf-8?B?RGpyNEtMM2dwb3ljekpMdXBWTmI2U2prZ0FIOXVJVndBc3hqTGhQeWZpTTIr?=
 =?utf-8?B?dXhqL2psT3BHVDMrb0s1dy9rVnk1MGM5N2tmcG5YUlNoaUlTeWFUTlo5dExE?=
 =?utf-8?B?NTVENHVXMWZpODZSOHdINUViUnZIU1JRS0lPZ2c2cmxPSmRrQXRDa1ZGRW03?=
 =?utf-8?B?eVVRa0xEcTQ3WFcrWHlNMHpmWDRHV1A4R3A0UkU1N0VUajkvbU5NcTBzVEhr?=
 =?utf-8?B?YXdWc3hPYWZPRXcxaVdkdGtXcnQ5MDMvajdSWUV4QjMxMEdiYnNkTHU0cVRH?=
 =?utf-8?B?KzlnbVVyYlA0RjdEVEtvc2xTK2Y3Umt2QU4rUFVIbTFia21qdEo0ZmZlanZa?=
 =?utf-8?B?SFhoU2x1UDRRZGJUUCtrMk93UVpYcEQ5ZWFMNVNtdUkvL0txckc5MVR4MTdD?=
 =?utf-8?B?eUJ5eVBwUVp5T2RmZXJWa3pYcU1pb2NlblpsRVNQUm5PRjQxcFNjYVRXYTRP?=
 =?utf-8?B?YzNKVlVKNENGcWd3bmR4N2JLU20xaU13Ly9tMXEwcmo0czVMTEpSemkwdUd0?=
 =?utf-8?B?NXRPUUh1N1BZa1hzZmpaQkIvb3pYVmNma1RHVE5PaVF1ZmM5ZWI2U1k4NFk0?=
 =?utf-8?B?N1ViUC83ZXgyNGVOVitkZHpGcmJyL3hNWnpnZ2xnc3praSsrV2tyZ1doSFV2?=
 =?utf-8?B?T3FWOWhaSENGTFBvLzlQa2VJL2FudzVJU2U1NWpseGhzVEJQdTFUeXRZWVpl?=
 =?utf-8?B?QWRvZ0FmZmhuazI5N0hOYmhZQTNkTGdWc2FLc1NSdFg1WmRQbmFJRHgzTE9O?=
 =?utf-8?B?cHhCWDhWWXNtSmJpMVU0V3p4K00wZFhiNDZQSFFrMW9KNWRwTzBJS2pJU0xm?=
 =?utf-8?B?NTZ1VjNtK0FCQVk1N1dvajAwUWpXTGVKcVBoOG96ejlsUm5XOU5QWnBwaWRz?=
 =?utf-8?B?ZEdjLzZvNVQvT3NTcFJsSnkvQldpRGRyZjdOanlJNFlaQnQxcGwvSUFYcXdD?=
 =?utf-8?B?T3puZHMvclh4MGR3Q1dlOTlWTVpXQ3d0c01SaGlvOEpBYS94NjlyNVZPRDZl?=
 =?utf-8?B?aHRVSWtya0k0N1pHQ3lEV1BlRkRoTmQ3ZmhYLzBaKzVUdVRKd3UrOFNoMXE4?=
 =?utf-8?B?VVJ6aGNGR09rbzl4UGEyM29pU1VPK3J2T1lremQxMXQzNWhYeEFZd3Y5dVpK?=
 =?utf-8?B?SHBDNm0zR0VSK2VVOS9POFZ4WDhKMUtlWWRSUWZBQUVzdnZld3RsL2k2WkM0?=
 =?utf-8?B?RDFSWVNFSFUrSHowNzQyYUJnZmRpRmJndkhDb0ErT2ZxMjJCdTZ1OUN1L2Z5?=
 =?utf-8?B?akg1UXFkT0hqWnlUS1JrZFoyWXR1QnMrM3ZSbDg5RmV5d3BhZjdzRGhBRUFi?=
 =?utf-8?B?cVJQMGlTcmlXbVVvRVVldGN4cC9NdmxCYXNMOGNnSEl0OXpFTjgxM0ZVYnRG?=
 =?utf-8?B?WjdYaHJ5TjZVb2VJeFlpamx1dk9OdnpKbElBa2pyRHJXMnZZeFM0L0JxaEJ6?=
 =?utf-8?B?TVdUdVYvSFRUOG9lTTl6MlZndDZ3cVdqU1hkaTVycUh5YWUzNTFrUWRCeWVM?=
 =?utf-8?B?cWJleHQvM3hqb1ltejZwejkranlPK3hRMTljOWFuSktURUY4ZnRCUXhkZWZK?=
 =?utf-8?Q?2mMPb7k5dXSPlB17wPvvFtM2zmNz8g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHhwWWp5ODdHTW11SlBOTXVqdkN0UE5DZWszZkI0RmhJcWRUOHgva25RRnJz?=
 =?utf-8?B?RUJOYWsvUWw5TzBXRWJ1WXVLVUhXTFBleEdQQ1BBdkNKQWZWY0poZTdVNU8r?=
 =?utf-8?B?TTUzTHU0aTR4Y2plYU85NjZGam1OUE8vc2xCVlhQeENoRk4vdGhVeFVxc1NE?=
 =?utf-8?B?MWltaFVtUkphU0FEQmFnUVdYMnlDRXJHQmJiVmRNY3IyeVJ4WVc5dkRmTHFI?=
 =?utf-8?B?S3ZBaFhyd1JRUllVcXlVcUIvcUgrNnBwMEFJNmorWCtxbUZPd0FGYndiNHZ5?=
 =?utf-8?B?a21IMUVXR3I2U3VYUm5MaVo0aHJnZXVrS2pzM1hWUXpoa2Y0amh2bnN0c3U0?=
 =?utf-8?B?VUU0dHdCZ2hjNWRoYVpkdDUvbmJRUlU5dWZpZCtza1VjTmVzTW9QMzRrY2tl?=
 =?utf-8?B?RXUvWHNaOFVLbU1DSEx5RXY2RC84cmNRSHAxVG4yYWM3NDM3L25LYzNwbmtE?=
 =?utf-8?B?SVN3dWVXeGpMLzhqZFNMRk4yUy9EZEVWQU5lcENLOVZ0YlFCOUZKWm93WEJU?=
 =?utf-8?B?djlaRXNka3p0TXN1SFRMaHJmVjBoZkQvN1AvMnp6bTc2RCttejRaQysvU1dP?=
 =?utf-8?B?Q0xUTkREUzZBVndnd1pySlZlclFXNkJidjdaMjU5Y2NlS0tISlZUMHJNNGJQ?=
 =?utf-8?B?UU40S2JlUHdFZkVaSXlneHRaZmZmSWVaT200Wm1odWNSZUJWNk1uR2dlRElM?=
 =?utf-8?B?MS82dGlUK1dtSmM1TVd6ejhVaWpNQ3g5L3RXRjRGdnJtNmhpdkFROG51Ri9y?=
 =?utf-8?B?Uks3U0xZM1psRm51ek9QMXJEMlBydUZyRWJFMjFpbUhSVmVhUDN5ZGlFUTEr?=
 =?utf-8?B?dDY1NVd1aHYxYStjeVU2Y1JuZXUyMzhrZXVQc0xsd2xweFBnaFJsQ2lIWlVD?=
 =?utf-8?B?alJVeXdzMFQ2ZnF4WHowUjVVckFaeDIzL3JVelgzZFMzd1NySjl0Q21HZ2NQ?=
 =?utf-8?B?WjBkWGZaN2xiU00wenRXVUVuMENMYVBOZVpsb21RMGhKWUxYdXFNaUVzSEx0?=
 =?utf-8?B?YVdTS1FEN0h6VURsdWdrdEtOMVBkK0dCajNWR0d3dk11WUNKVStMN2NSM1I0?=
 =?utf-8?B?QWt6K3drRFZmN0VKKzhOdGFodFc4ZjExdjRvdWE5TWxqK2p4eWcrNlBFdTZk?=
 =?utf-8?B?eS9NRHRqUVhLOW1PbGk1SzZYN2JKR0xIc3RYVVhXUEdCZDV3RU9VUXQrR001?=
 =?utf-8?B?ZWJCdU5zWG0rMUdZNnJhcnVtcWJqWERldkV1cVp6Z3cydjlEYlZFdUYwVWlQ?=
 =?utf-8?B?TWQzOVpuSUIxKzUwTEN2YktYeEFpbWt0UXdmc1l0Z1R6Y0xMTWhNQU5KQVYw?=
 =?utf-8?B?L2VYOFNHd0RJenFxcjN3SFhKdElVOHg5U01mZUs1VVUwODNrZzI4MW8vTTlw?=
 =?utf-8?B?MG50TVFyOE5FZncyN3dIM2dyNkxBRmVaeHoxZDBOdmFEZkJ1VDJsZXMyVS9L?=
 =?utf-8?B?aEJTakNvc1llMjBXakpEeEdjc0JJRnVqSkpRYmRIbE90VlFoNWFMMi9ydVpq?=
 =?utf-8?B?NXVCZ3RibnNydzFCTkhQcFIybXlLYVdxVDRiNDNpSU9aL1g2RCtHMC96VjdT?=
 =?utf-8?B?NEdSNnlSWlJ0L0lIODFWdHdCR0ZrdEl4TzFXZHJpMjdXQUpjaGNKL3ltazh1?=
 =?utf-8?B?MXNSWGYwY1dzZldlQmREdXBFa2owa2VZbGV2cmp1Qk9hVkJ6N1NoL3RqVXZT?=
 =?utf-8?B?N3JIdFBvV3d4bW5oeFhjSjQxNmVKWm44cnM3QU1UUWlkdmtRMkpLRWFHWHFk?=
 =?utf-8?B?czFJQUxZYnd4ZzhPa1hIRExBUExJRmtTZzZ5cys0Z2pySUdKaituYzgrNHY2?=
 =?utf-8?B?ZHJTQ3Jtb09pVWZQWnJKSSt4OVFJblpPVm1ZZXpEU01jcStYTUhFYmxVeEJI?=
 =?utf-8?B?Y2NrbkgwSWoyNmZudHBPeU5CakRDNlFYRVh6R0l2S3l1YTMvQk1XMm5CZ29p?=
 =?utf-8?B?endsWnVxWWp3VWhJcFE0L3REOGdQeHh4T3JueUVqaVJiUGRNTFAybmluMm9P?=
 =?utf-8?B?cXpEVmxpSFdUOE1Md0pLNkJwK1pWZ2VUMjloVjV4bWg1S2dNZm9SNEhlT0hO?=
 =?utf-8?B?K0lPZ1BXS1VqRngwQjRyVHAyOHpvS2djd2hwdFB3bi9pSTZLUG9Nc1FqbzFU?=
 =?utf-8?Q?h7LiBMBaaFnR9h5ivtWHDUO6a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d49034f-6900-4c35-8461-08ddce469ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 02:21:19.7734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zLhRKAvbFxl59/KWqQw19uNyLRNRx8KFSh1bvcdRgFBTHsgPG0jKxWs6GBXCDTinl6FmFQ9jqSqClnpLZQR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9758
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

SGkgVGltLA0KDQpBMCBoYXMgYmVlbiBkcm9wcGVkLg0KDQpQbGVhc2UgdXNlIG14OTVhMC1haGFi
LWNvbnRhaW5lci5pbWcgYW5kIHRoZSBvbGRlciBpbXgtb2VpLCBhbmQgdGhlbiB5b3UgY2FuIGNo
ZWNrIGlmIHRoaXMgY2hhbmdlIG5lZWRzIHRvIGJlIGFkZGVkLg0Kc3RhdGljIGludCBfX3NjbWlf
Y2xrX3NldF9wYXJlbnQoc3RydWN0IGNsayAqY2xrLCBzdHJ1Y3QgY2xrICpwYXJlbnQpDQogew0K
ICAgICAgICBzdHJ1Y3Qgc2NtaV9jbGtfcGFyZW50X3NldF9pbiBpbiA9IHsNCi0gICAgICAgICAg
ICAgICAuY2xvY2tfaWQgPSBjbGstPmlkLA0KLSAgICAgICAgICAgICAgIC5wYXJlbnRfY2xrID0g
cGFyZW50LT5pZCwNCisgICAgICAgICAgICAgICAuY2xvY2tfaWQgPSBjbGtfZ2V0X2lkKGNsayks
DQorICAgICAgICAgICAgICAgLnBhcmVudF9jbGsgPSBjbGtfZ2V0X2lkKHBhcmVudCksDQogICAg
ICAgIH07DQpUaGlzIGlzIHRoZSBwYXRjaCBsaW5rIG9mIHRoZSBjaGFuZ2U6IGh0dHBzOi8vcGF0
Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI1MDcwNzIwMjAzNC4zODU4
OTAtMS1hbGljZS5ndW9Ab3NzLm54cC5jb20vDQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0K
DQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBUaW0gSGFydmV5IDx0aGFy
dmV5QGdhdGV3b3Jrcy5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDfmnIgyOeaXpSAyOjAy
DQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBZ
ZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4g5oqE6YCBOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAbmFi
bGFkZXYuY29tPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJv
b3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47IFRvbSBSaW5pDQo+IDx0cmluaUBrb25zdWxrby5j
b20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsgQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47
DQo+IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjIgMC80XSBpbXg6IGFkZCBpLk1YOTUgYjAgc3Vw
cG9ydA0KPiANCj4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMTE6NDHigK9QTSBBbGljZSBHdW8g
KE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IEFsaWNl
IEd1byAoMik6DQo+ID4gICAgICAgdG9vbHM6IGlteDhpbWFnZTogQWRkIDIgbmV3IGNvbW1hbmRz
IENNRF9DTlRSX1ZFUlNJT04gYW5kDQo+IENNRF9EVU1NWV9ERFINCj4gPiAgICAgICBpbXg5NV9l
dms6IEFkZCBpLk1YOTUgQjAgc3VwcG9ydA0KPiA+DQo+ID4gWWUgTGkgKDIpOg0KPiA+ICAgICAg
IGFybTogaW14OiBVcGRhdGUgRUxFIGdldF9pbmZvIHN0cnVjdHVyZSBmb3IgaS5NWDk0DQo+ID4g
ICAgICAgc3BsOiBpbXg6IEFkZCBzdXBwb3J0IGZvciBuZXcgUFFDIGNvbnRhaW5lcg0KPiA+DQo+
ID4gIGFyY2gvYXJtL2R0cy9pbXg5NS11LWJvb3QuZHRzaSAgICAgICAgICAgIHwgIDggKystLS0N
Cj4gPiAgYXJjaC9hcm0vaW5jbHVkZS9hc20vbWFjaC1pbXgvZWxlX2FwaS5oICAgfCAgMiArKw0K
PiA+ICBhcmNoL2FybS9tYWNoLWlteC9pbWFnZS1jb250YWluZXIuYyAgICAgICB8ICAyICstDQo+
ID4gIGFyY2gvYXJtL21hY2gtaW14L2lteDkvS2NvbmZpZyAgICAgICAgICAgIHwgIDEgKw0KPiA+
ICBhcmNoL2FybS9tYWNoLWlteC9pbXg5L3NjbWkvY29udGFpbmVyLmNmZyB8ICAxICsNCj4gPiBh
cmNoL2FybS9tYWNoLWlteC9pbXg5L3NjbWkvaW14aW1hZ2UuY2ZnICB8ICA1ICstLQ0KPiA+ICBj
b21tb24vc3BsL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICB8ICA3ICsrKysNCj4gPiAg
ZG9jL2JvYXJkL254cC9pbXg5NV9ldmsucnN0ICAgICAgICAgICAgICAgfCAxMiArKystLS0tDQo+
ID4gIGluY2x1ZGUvaW14OGltYWdlLmggICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKw0K
PiA+ICBpbmNsdWRlL2lteF9jb250YWluZXIuaCAgICAgICAgICAgICAgICAgICB8IDExICsrKysr
Kw0KPiA+ICB0b29scy9pbXg4aW1hZ2UuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDU3DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMTEgZmlsZXMgY2hhbmdlZCwg
ODYgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+ID4gLS0tDQo+ID4gYmFzZS1jb21t
aXQ6IGNkNzlhMjgzOWIwMTU3MWI2ZjI5MTVjMjE5ZjcxYzA1ZTNjOTc0ODINCj4gPiBjaGFuZ2Ut
aWQ6IDIwMjUwNzA4LWlteDk1YjAtZTEyYTEzNTUyNjU4DQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMs
DQo+ID4gLS0NCj4gPiBBbGljZSBHdW8gPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4gPg0KPiAN
Cj4gSGkgQWxpY2UsDQo+IA0KPiBJdCB3b3VsZCBhcHBlYXIgdGhhdCBzb21lIG9mIHRoZXNlIGNo
YW5nZXMgYnJlYWsgY29tcGF0aWJpbGl0eSB3aXRoIEEwIHNpbGljb24NCj4gY2hpcHMuIEkndmUg
dHJpZWQgcm9sbGluZyBzb21lIHRoaW5ncyBiYWNrIHVzaW5nIHRoZSBvbGQgYWhhYiBjb250YWlu
ZXIgYW5kIG9sZGVyDQo+IGlteC1vZWkgYnV0IGFtIHN0aWxsIG5vdCBhYmxlIHRvIGJvb3QgbXkg
aW14OTVfMTl4MTlfZXZrIHdpdGggQTAuIENhbiB5b3UNCj4gcGxlYXNlIGV4cGxhaW4gd2hhdCBp
cyBuZWNlc3NhcnkgZm9yDQo+IEEwIHZzIEIwPw0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiANCj4g
VGltDQo=
