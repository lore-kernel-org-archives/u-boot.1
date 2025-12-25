Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A3DE7AD47
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 10:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C03B8433B;
	Thu, 25 Dec 2025 11:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Cf0tX9jX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF0884347; Thu, 25 Dec 2025 11:41:53 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB8884337
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 11:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V96zCO/w2oP9YN3TzcJZMC/xGw4D1/AromaU9TiWphXVhSlQLC68iBBq6zxaxxNIWjRKXhf6ojwKP58r/md+6Tv4s7QAmnUZHpc/c+b+oDZs0Eia37Ou7H47qsMtuWgCKdIQoTLGOEmuVxT9NerEcEsFvMS1TeLyBbGoOCgZikZLlrq+iejfDQQyALAz0W7nA5P04uM72zEuC2CE9qwaUAWbGyCrrPL0VtuKOKv4wWSQjqR3oA9UJNR487diweCx89myy4uQIEGKNLk5Bu9m97bL0XSl5kfu6RaVZ7SfUmBHXoB7v0kaFxWcLwQ1KNq7Zk7D6IIZzaPDrnThYbnpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOGfpyAXv8lkj99nQJsmsdmwCTxiXA/b4mglT8hCC1U=;
 b=iFWGFKkbMjJmKMPbMNGGlsZaVU6ANODeKtF+JxAhGBj9XNqdCZC0v2PTLF2Mv2XE3FxWA3CFKZ4EVd4lySelpgw9Ng36JBChoKvG1pSw5mozl+k23q0DxVEwGchDvcnRmxMRQlzPdReA4X8fynjPOrqju6qUvqN4OF0Y5/OCMmhiaWbiNvaOQpJO6JI/uX6r9YIDaD+5SRyed2id666B2+qb7eqP9qUW8yr4Enw6kNgEjseIcXhjCo1fEkGo8XB+TbkpNjW2sQ2NJEYflzf9vpXMecst46uNLTtJFLaFUNCsokWrEhEGLUPaWMv0lhMentROY/7qS8ImFQVX+gkiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOGfpyAXv8lkj99nQJsmsdmwCTxiXA/b4mglT8hCC1U=;
 b=Cf0tX9jXwQZgPAWMtjsC5t1nS1W1xmYlmRBQcLIsj2WIcCW4VTIogXFus2tufzLIR+6J5Y69A9UGJPiS0ycME3hgkLLs4+Tk4e2TCq005SmCJBytdupxxp/ICswoI6baYf2hh4k14pg/iQbZOq4p9x9jvgoBYhzqU4RzYxuba5sioldRu6hIhB769eUPQR7sPyIwq03yBlDYhCZSTYhtA2BXkQocty7UoH3mnBUvx/0wjASxSwqlU7QkXsCrJvJJlL14hBvNYH26KjaQaigyipyoPNi1ujsdecPe8yvduLTjGB2BdmFUrU8l6XWEhZyPcec29dPfUAmFQkd88D3BFg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8374.eurprd04.prod.outlook.com (2603:10a6:102:1bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 10:41:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 10:41:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Ye Li
 <ye.li@nxp.com>, "tharvey@gateworks.com" <tharvey@gateworks.com>, Peng Fan
 <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Lukasz
 Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, Kever Yang
 <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz
 <quentin.schulz@cherry.de>, George Chan <gchan9527@gmail.com>, Simon Glass
 <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMi83XSB1c2I6IGVoY2ktbXg2OiBGaXggdXNi?=
 =?utf-8?B?X29jX2NvbmZpZygpIGZvciBpLk1YNy84TS85LzdVTFAvOCBhbmQgOFVMUCBw?=
 =?utf-8?Q?latforms?=
Thread-Topic: [PATCH v1 2/7] usb: ehci-mx6: Fix usb_oc_config() for
 i.MX7/8M/9/7ULP/8 and 8ULP platforms
Thread-Index: AQHcdYsSNIBUKofri0q5BlaV0/558g==
Date: Thu, 25 Dec 2025 10:41:48 +0000
Message-ID: <PAXPR04MB9644117D0D40EE8A9FFE5CB3E2B3A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-2-504115a53020@nxp.com>
 <e314692d-452c-452e-ba44-1469a8bcd9b5@mailbox.org>
In-Reply-To: <e314692d-452c-452e-ba44-1469a8bcd9b5@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PAXPR04MB8374:EE_
x-ms-office365-filtering-correlation-id: 207a2caa-8a98-439e-66ae-08de43a23512
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?b0tmWi9MckM3NEU4WlBkenVmWXdiTTVPMGZIUzVTYzh4ZXBVRVJWOWlqbU84?=
 =?utf-8?B?c1Rweng0dHErd1pNTXJjTUpBcU9PWTl5UUxYQkNvOGROa3BBK0pmZCsyRVg5?=
 =?utf-8?B?NnE1RUZsVDQ4V05wTEsrSmd0RlhpQnBOQkJjak9weFZGT1J0aUNpYUh5Wkkz?=
 =?utf-8?B?WE9EZUUzQi9XZEM2SVFZM2dZSnFOVHFrVnRUWEEwdTVON1pGZExrSExwMWdp?=
 =?utf-8?B?QklEeWpyYndYdm11azA1L1l4d1ZYSjVkRDZ3aG9XaGJDR3JCNTlKTGFudDNw?=
 =?utf-8?B?ZkVMeXRLTFhmTURKNUJSQVN1aTBVYUlVajhBb1ByY2JWNG5TSUJUcVBWc0s1?=
 =?utf-8?B?NTZxeTdiY0JxVXN2NSswODFLK3hheTNHR3BkNThTNzNrSS9kM1lMdkd2YlFG?=
 =?utf-8?B?RFlFNmMrVGNFV29jbjNLZUNPWlR1dnM1VDZCM0lnM3dERUZtdUQ3WTIvUWgv?=
 =?utf-8?B?SCtXTHdpcjhWT0ExNUI2ZFFVWXdNREdnaW5ab1o0KzNSWWJpNEhBZE51REc3?=
 =?utf-8?B?TWIwNEsrQ1B1bUNjSm0wS2hMWGdSdElsOW9DTjFKM3NHUXRvQkRudUVxMit3?=
 =?utf-8?B?UEI5RFRWUVZuMTEyaVZJd0hqWHFLN1RramtlekRHc2xtbGRBMWtFQ0ZxcHRR?=
 =?utf-8?B?akRVNzhHd3c4ZGdrVkpZK3ZiQ0tyL3hRRzhta1pPejVmSnZTWUlGdjl5aUJS?=
 =?utf-8?B?c01RMGZNc2xJVGFEMWFUeXd0aE9GUVF4dVZrRnBrZ3dHNGxzMkY2RGlZRTMr?=
 =?utf-8?B?TUw4Nk9ZRjVtc2pOaE5oQnhCS1cyWTV4R3ZzSCtVclpiOGRZaUl5NTZiUk5s?=
 =?utf-8?B?NFN5OE1ldDRwTnNRNmRBYkRseTRYTGw0cUFMMXVHYmcyUzhXaEJlYnBSVDNS?=
 =?utf-8?B?cmJvZUo5Z3Q5cTBXQjJVNVpLejZOWXFoLzYyZ3poL2luTURMbEZ1eDU0V3VD?=
 =?utf-8?B?N1M4MUhLWlpWY2dENzRUamhmMkVpSjFSUnBqZGJaTndKTGNSMmo5Zlc3cVlh?=
 =?utf-8?B?eFhUdUlncGdVZVpKTjAvZ1poOTJEaWNQVm5pQVBSZDBWa2MyVjRTSDZTZkpR?=
 =?utf-8?B?UFYxOTZJL0tVcUZSK3M4TGhreGU1ZFhYYjJVa2VyUDIwYjl3Z2syT0ZqRko5?=
 =?utf-8?B?a3NkZHB5ZTZwME4vVU1jQyt4bTRzNC8yZUMwMzAra216U211VkprQUtFazRU?=
 =?utf-8?B?NFltc3ZTZGpycnhiWTMwbG9ISThSTXhLMkcyY2FiR3ExUHQyVGViMU8xcWtC?=
 =?utf-8?B?UTkraVZFd3EvMjRxOXF6bmQ4ZVdOeTRKTUN3TEdSVWtKTWpQZnZQcmNSVkxa?=
 =?utf-8?B?Ly9jVW9pUE9aSTFTYjFmQXYrYUFtT2I0SEwrQjh3RkwrUzYzZnVZcFRHSHFP?=
 =?utf-8?B?Z1NiZWwwMTM2UDhaS1FWaWNCdWJwL2dBQ0FkeTNzdTBRVkQ2Y3JOZC8rb0xi?=
 =?utf-8?B?bHZkbVpDR0JPQzFNdWFiKzRzbU9PN0ZNdUZzK1Z0bHlKQ2RIREpMcEJzUnpY?=
 =?utf-8?B?KzRzQ1FqSCtpc2dhd21Wd2duVFFqODFzYndLMWJaZDlLbmZGeFpWQWdDcUto?=
 =?utf-8?B?S0ZrY0JXbHNYVlcwWmZyeXFIdTV1WG5JK0ZGQlRybmJaTUs3anJiZnBOUEN3?=
 =?utf-8?B?b1loOUdSUjJPWGROSUFQR0xNdDNGWUVmUDdzMEprdURJUWVRWnVHajdTMEdw?=
 =?utf-8?B?ZEVUV2l4UUNZVVhrNHhnUEZCUU83RlZHa1MvL3NEcmNXUWlSa01yZ3NaWWlk?=
 =?utf-8?B?Y25OM1hpcGJvaFhDRFhUNUl1c3NtYWVJd1E5UW5kWGMxSUpSZ0t5N3R3L2U3?=
 =?utf-8?B?RkZMd1BnZHl5Ty9nVllBeS9JZzNDbUtkclNYdTQ5MUppc0dhMFU3MFh5K1N2?=
 =?utf-8?B?UDlPdmNDNSttbE5zbHpabWFSZmhZcC9KMGtYMFF5ekx6N3JDc0NZcG5LNitM?=
 =?utf-8?B?Qlg1WEJKeGdwUGZod0FwREEyYlVtb2dTZVg4Q0Y5SkpXVlFBcHYrRjBoY0xn?=
 =?utf-8?B?U3pjT3JtSzFqYWRRcTlnUzhzVndJVTdnYmdLMlFKLytzcXJIRTJpNGZvWnpr?=
 =?utf-8?Q?5gJb9a?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnZjcTBEVnJGTlhhSTRaOGZhRXpNQkdMamtKWmpzdEV4TU9XNVNUdzgwbVFY?=
 =?utf-8?B?M2RPZkoyUjNhRWJGSXVzM0xkUklGVU8rUU53dW5NNFdGYUgxV0xMMkVnejhE?=
 =?utf-8?B?V3VqNEt3SE45aVYvNmNVNXlGSkdGdGRBejVoaWRVREFGY1pjdDQ4ZnVvRW5L?=
 =?utf-8?B?d0hYUlJmTURlMTZmVlhVVkQwemxiSjFET2RsSXBoY3lwZWVhajVUT1I5bUZY?=
 =?utf-8?B?ZE1UbUhNT1lQaGJGNGNJdC9ZbDVXcS9kemhJVkl2ZUQ1dURJQjJlQmFzUVRt?=
 =?utf-8?B?dzNucHNka0ZmWjdINDNRWjlHaDl5enZYOFNNckp5bU5rSGpSUW1KbmVWaVFH?=
 =?utf-8?B?YTdZZTYxcFovSEZkMW5CRlROa0NRei9hcDJyTVhvRG5FOXdzNG9RNGdnSnhV?=
 =?utf-8?B?dUlVV295bmxBUTNtaE1TOEhVeGxFOHMvNDZkTWhmcmxjOXoyeElUSHl3STlM?=
 =?utf-8?B?RWl1dzNoK2R1ZDJocGFNOGhTZ3ZRVGE5NS9KeG16TVJtTEp1WFMxVng2UzlT?=
 =?utf-8?B?Uko2YzB6VnVvSHRqQnBCc1ZVSGUrWVdIa1oyeEx3MjJTbFJwRWltTFliNjZk?=
 =?utf-8?B?ZkplT1JQcm9KNmxMUzdrZVZ1blc1SDl4MXltbmwzQ0JuMlZhNUhrRzZPNFRo?=
 =?utf-8?B?K2JubDl4eE9iZ05acFZ3SGVHN3pVanZoZlZpTVBVeWVLekc0T1pZY2NSZzJ4?=
 =?utf-8?B?N05VSG9pWHR4ZkgyYkZOWnVzQlQ3OWEzRHczS3IvSnJTd2hjaHp2dS8wbS9y?=
 =?utf-8?B?ZHNEcDZtY3hrOTE4QTdlU2xJTE9BN1NqZnIyMi9wWTRORWFYdzRKWG1ycThR?=
 =?utf-8?B?MWJSL0hEMmZ0NEtjVWV1YjZFYkF4a2VuKzlrYzRsTUpUUDVDMUVuNFE4WEI4?=
 =?utf-8?B?TkpIQlAxL0JPeG9Kb3RURFFudzZLWVZTckw3cTN0dDdpeWtMQWc1eFNodFQy?=
 =?utf-8?B?UU5HZ2lnTVhjZXI2cHMxMlluekwydkowMWhueXhQcWZVTjNvNXIvOE1BZkhL?=
 =?utf-8?B?RGR4OS9RekY5eHZOTzJnWnppZ2lnTjc4VFdXTFQ5Ri9BYlVOWjByVGVRTldi?=
 =?utf-8?B?MmtCL1NLMFk3bExUeGdaUmNYRnNpRVZnVk1PYWZXdWJnaWVHcDVmVmRXSy85?=
 =?utf-8?B?S0xpTEMzL0pZMlM2MEpZZTZaQlNVbnVBY0xFRUQwY2lQRTZkVFpMem9ocExj?=
 =?utf-8?B?Ym9jNjVqTzVTRHUreTBjd2VPd3VjWE44RlI1U1AybWtnOVV3WGhTUzAzSnV6?=
 =?utf-8?B?RDVmR2pQc2lVUUVnOHBraysvelkvSGN5Q3VZYWo3VHhJcnViK1g4UmwwTGtu?=
 =?utf-8?B?c0w2dll6K0M2L3dIQWpDSnJWdEsvZkVYTDhEV0ZiM0xpN2d6QkVYMVE4b1NH?=
 =?utf-8?B?aHZkcFhXWmV4L1lZek9XRDErMXNCNGJqYnJmRE5kYWM2ci9Cc3F2SHdaeGJW?=
 =?utf-8?B?ckd0R1Jnc2dEcGZJVFhMSmVUdWFjSzNmUmpTSTJUa1pzVkU1RUpKR0lxMU5n?=
 =?utf-8?B?RWNRZ0tsYXdXQkpnNWMrMjg0cVVvWFBjRVh2WXdFZ2ppRnJmajBIWXllaFRO?=
 =?utf-8?B?a0tIQzIwOWlxMzBnS0syYlh6TnkrZy9KbmVBbzdGK0VmVllDeC9Kdm9JQWdT?=
 =?utf-8?B?TVphTFRMMi9XM1FmMnhGajZGck9wenN6cENvemJkUU4rZ2QyS2dmN0ttcG5J?=
 =?utf-8?B?WGNtREw0NE81MU5OK200T3FUaTRPTHlMSHE2MWJGbzBzVXRSekdJVmFzZ3U0?=
 =?utf-8?B?RWtJZXJrSTJ3dXhFTWlmSDgzWUI5dUEycGgvQ1EvYXhQeC9Qa3A3SEh5dVV0?=
 =?utf-8?B?dHFnV3ZHYzZ0NStDdnpCbzE5MDdsUUZrZzFrVlZwWXJYZE4rMEh2TTlHWE10?=
 =?utf-8?B?Nmw4TzI5RVZKc29RRWgzQU9VN3hDazRRaVZiR3NCc3VOYitDdmFqbjV2dTBo?=
 =?utf-8?B?cFZOK1N3SEt1QWwzT1dZWHFjRUVpZDBNNXNQZVNQV1krZmJ0enVMTUZCTGFF?=
 =?utf-8?B?NW1HSzM3VlNnaTNHbzRLZWY0TTZHSUtpRnV5a2s2OHB4dWw0TUtMaERXYTBZ?=
 =?utf-8?B?elhQWCtMQTNVS3RKb09oMTJGR2VJSDRHVUYxN1ZIbyt6NnJwNzVzVVdIRnVR?=
 =?utf-8?B?b3hOOFJBOFd5cDhMNExXa3dOanFJcmtXNXYyVDhIRGU1aGh4d3ZpTmtPNjMx?=
 =?utf-8?B?TmhuTGJWNkdtZ0dWdy94Qm9TdGxGSnlTUk1JQWR5bWJLUVlPQWdJV3pWNVRQ?=
 =?utf-8?B?MWxZejgzQ2ZhWno1dEU1NElPa1pSL253aU5udFdPNGxYN2ZsOEp5eSt3VTgv?=
 =?utf-8?Q?jmMd6jRn5ZhNdU7kNR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207a2caa-8a98-439e-66ae-08de43a23512
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 10:41:48.7062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xy/g4ItxpuHgW7gVByEMolOKOsK3qPOb5pAFw55J8rg0PgORdNQ6LWzTkNqPuNuklSyh0ZxcluOTx2qSnjn4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8374
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
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMuaciDE25pelIDE5
OjE2DQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+
OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbngu
ZGUNCj4g5oqE6YCBOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAbmFibGFkZXYuY29tPjsgRmFiaW8g
RXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtv
LmNvbT47IE1hcmVrIFZhc3V0DQo+IDxtYXJleEBkZW54LmRlPjsgTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPjsgWWUgTGkNCj4gPHllLmxpQG54cC5jb20+OyB0aGFydmV5QGdh
dGV3b3Jrcy5jb207IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4gTWF0dGlqcyBLb3Jw
ZXJzaG9layA8bWtvcnBlcnNob2VrQGtlcm5lbC5vcmc+OyBMdWthc3ogTWFqZXdza2kNCj4gPGx1
a21hQGRlbnguZGU+OyBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyBLZXZlciBZYW5n
DQo+IDxrZXZlci55YW5nQHJvY2stY2hpcHMuY29tPjsgSm9uYXMgS2FybG1hbiA8am9uYXNAa3dp
Ym9vLnNlPjsgUXVlbnRpbg0KPiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QGNoZXJyeS5kZT47IEdl
b3JnZSBDaGFuIDxnY2hhbjk1MjdAZ21haWwuY29tPjsNCj4gU2ltb24gR2xhc3MgPHNqZ0BjaHJv
bWl1bS5vcmc+OyBEYXZpZCBaYW5nIDxkYXZpZHphbmdjc0BnbWFpbC5jb20+OyBBbGljZQ0KPiBH
dW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjEgMi83XSB1c2I6
IGVoY2ktbXg2OiBGaXggdXNiX29jX2NvbmZpZygpIGZvcg0KPiBpLk1YNy84TS85LzdVTFAvOCBh
bmQgOFVMUCBwbGF0Zm9ybXMNCj4gDQo+IE9uIDEyLzE2LzI1IDc6MzggQU0sIGFsaWNlLmd1b0Bv
c3MubnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29t
Pg0KPiA+DQo+ID4gVGhlIHVzYl9vY19jb25maWcoKSBmdW5jdGlvbiBwcmV2aW91c2x5IGFzc3Vt
ZWQgdGhhdCB0aGUgb3ZlcmN1cnJlbnQNCj4gPiBjb250cm9sIHJlZ2lzdGVyIGluZGV4IGFsd2F5
cyBtYXRjaGVzIHRoZSBVU0IgY29udHJvbGxlciBpbmRleCwgd2hpY2gNCj4gPiBpcyB0cnVlIGZv
ciBpLk1YNiBidXQgbm90IGZvciBpLk1YNy84TS85LzdVTFAvOC84VUxQLiBPbiB0aGVzZQ0KPiA+
IHBsYXRmb3JtcywgdGhlIG92ZXJjdXJyZW50IGNvbnRyb2wgaXMgbG9jYXRlZCBpbiB0aGUgVVNC
IE9URyBDb250cm9sIDENCj4gPiByZWdpc3Rlciwgd2hpY2ggaXMgYWx3YXlzIGF0IGluZGV4IDAu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgZHJpdmVycy91c2IvaG9zdC9laGNpLW14Ni5jIHwgNSArKysrKw0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1teDYuYyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1teDYu
Yw0KPiA+IGluZGV4IGNmYWY0OWQ2N2YwLi4wM2ZmNGNlMTBkNSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3VzYi9ob3N0L2VoY2ktbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2Vo
Y2ktbXg2LmMNCj4gPiBAQCAtMjgwLDcgKzI4MCwxMiBAQCBzdGF0aWMgdm9pZCBlaGNpX214Nl9w
b3dlcnVwX2ZpeHVwKHN0cnVjdCBlaGNpX2N0cmwNCj4gKmN0cmwsIHVpbnQzMl90ICpzdGF0dXNf
cmVnLA0KPiA+ICAgLyogU2hvdWxkIGJlIGRvbmUgaW4gdGhlIE1YUyBQSFkgZHJpdmVyICovDQo+
ID4gICBzdGF0aWMgdm9pZCB1c2Jfb2NfY29uZmlnKHN0cnVjdCB1c2JuY19yZWdzICp1c2JuYywg
aW50IGluZGV4KQ0KPiA+ICAgew0KPiA+ICsjaWYgZGVmaW5lZChDT05GSUdfTVg2KQ0KPiA+ICAg
CXZvaWQgX19pb21lbSAqY3RybCA9ICh2b2lkIF9faW9tZW0gKikoJnVzYm5jLT5jdHJsW2luZGV4
XSk7DQo+ID4gKyNlbGlmIGRlZmluZWQoQ09ORklHX1VTQl9FSENJX01YNykgfHwgZGVmaW5lZChD
T05GSUdfTVg3VUxQKSB8fA0KPiBkZWZpbmVkKENPTkZJR19JTVg4KSB8fCBcDQo+ID4gKyAgICAg
IGRlZmluZWQoQ09ORklHX0lNWDhVTFApDQo+ID4gKwl2b2lkIF9faW9tZW0gKmN0cmwgPSAodm9p
ZCBfX2lvbWVtICopKCZ1c2JuYy0+Y3RybFswXSk7ICNlbmRpZg0KPiBDYW4gd2Ugc2ltcGx5IHBh
c3MgMCB0byB0aGlzIGZ1bmN0aW9uIGFzIGluZGV4IGZvciBub24tTVg2IGluc3RlYWQgb2YgdGhp
cw0KPiBpZmRlZmZlcnkgPw0KDQpFdmVuIGlmIEkgbW92ZSB0aGUgY29uZGl0aW9uIGZyb20gaW5z
aWRlIHRoZSB1c2Jfb2NfY29uZmlnKCkgdG8gdGhlIGNhbGwgc2l0ZSwgSSBzdGlsbCBjYW5ub3Qg
YXZvaWQgY29uZGl0aW9uYWwgY29tcGlsYXRpb24gYmVjYXVzZSB0aGUgbG9naWMgaXMgcGxhdGZv
cm0tc3BlY2lmaWMuDQpHaXZlbiB0aGlzLCBpcyBpdCBhY2NlcHRhYmxlIHRvIGtlZXAgdGhlIGN1
cnJlbnQgY2hhbmdlIGFzIGl0IGlzPw0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg0K
