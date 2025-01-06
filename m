Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9752E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 10:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E5A801E8;
	Mon,  6 Jan 2025 11:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iGNMm04a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B3D8036B; Mon,  6 Jan 2025 11:41:57 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E5C801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 11:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5HjxDA3Rrqn9lpQEMYoP1BUIL3yRnpFETC0DtrVjEsMu5G/y8JszrwTJ7rsrL/vHNxsYibLiDT4b9eJrlJUmf+y6y/92NgZbtI8evMK9wu3JBvR/s7jSr+0/4SXWa1zFW8j1vhZk+NSWf+PydxhcLca6dgVM3gUqPhQgfakz3oLaUSo/enwV4dOtnb3hCNomN53u0M5/ieuTuf0han7M09DT5ovUzWLZVbEuWn23qgBVSZogef2/H8jiI68ysgOGcMEm/QAlgYEtmzVONp9cnZzvLCa4eM5c8tcyJCZNvUszt3qIWd+Rx4xYEZBftPjKISTzwJqPG+2+L2BwMNhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0UdKUgZ8/ioWQFt5MSN9WbnhAPMivYBzLTjWc3Auow=;
 b=XLr4z3m9H/Xt216rMS5JUErTlRp9PHojApuAzm1VbwBM1nrveGP9hKClpoHh1S9PHTqiKAQJUb8Uaj47Txbjm4XwyFEaPtv4iNEKjjmuZonoafXauSClDzzyGK0qKFnDtQrpZCB7KTQdSWTUpPF1pnaeM6YJvwEYd99h8qOhJG380jdnkw/Tl6hXLL1vXY8OZET+EOYvJG+N54zO3kGwqR/dZaLoALb7DzXdrwSiZUKEoL3GmZsDr/3S2FgDKI432m1+R6A/r1+ScneR/ArmCLY4QOOtARrwX0Ggz1l9ezd8oKMErebAfXPBCoqlVI877bFsU2m0ipnmGPew561hWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0UdKUgZ8/ioWQFt5MSN9WbnhAPMivYBzLTjWc3Auow=;
 b=iGNMm04acbT6l+t3OJvLP8DkdjXN8W/GshwpTyDDHpZxNGSR6Cu6iXQciKdi2ZkeMBeUsteWIRtYMrj5FJg/N9fJ81dmW1+jwLdYhEKGmjgnTUmSP8IE46M0K9+RfaqHKAGBbek+JOrTdEw6H+5OjvNMITmhi0kHjImmtb+vC0UmGXwjJhcbg+UsuVS7F7r6IvKxLDqNNLay9Wk2TK0JOKE7MNm7Mrv3l+GfEfH9rmo7PE3FM4z0zDw3IJE8WwLaEZpzyu3z/Rzmf0rfkcgNiGStLm2tonVsF1yJsQrAjvXYP46AU0KuYshFsfiKxBtT/AbTcqP9to/hDpKXtapXkw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 10:41:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 10:41:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDA4LzE3XSBzY21pX3Byb3Rv?=
 =?utf-8?B?Y29sczogdXBkYXRlIHN0cnVjdCBzY21pX2Jhc2VfZGlzY292ZXJfbGlzdF9w?=
 =?utf-8?Q?rotocols=5Fout?=
Thread-Topic: [EXT] Re: [PATCH v3 08/17] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Thread-Index: AQHbXasz9hKLWxjZxkmCtOuCI20Tj7MIsLWAgADXCYA=
Date: Mon, 6 Jan 2025 10:41:48 +0000
Message-ID: <PAXPR04MB96444924697478EB9C2CE46CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-8-6744df5dc020@oss.nxp.com>
 <a563cb62-7922-4a68-a24c-534e583b7dcb@denx.de>
In-Reply-To: <a563cb62-7922-4a68-a24c-534e583b7dcb@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PAWPR04MB9911:EE_
x-ms-office365-filtering-correlation-id: ca1d2e98-ecdf-4232-9a83-08dd2e3eb90a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?K0haQnEveU5pUzlid1FYaVpBdlZSY0JyK1RaS1V1Q3Vvdy9qTmx6RTJCeG5R?=
 =?utf-8?B?QWE0TkpEY1JJZys0L1h0eVhmS1VmVGZ6YXExTjlwbTA3TXlWS1pNTWtxMzhx?=
 =?utf-8?B?WlR4eVV3K0ZCU0QyS2J4SE5DTDdIZTZ4c3VhK2VsbElOdlY1T3UxR3U0YldI?=
 =?utf-8?B?MzVTdjJqWTdqckNCZmtRNHF0L1lVY2VqVGdBSE9CM3poa3RwS3JxbEw4OUVQ?=
 =?utf-8?B?OUFpZndNZVMrdC9SQTlZOENGbU51V1pVbzh3b1ZobE82N0hIQ25vSllucHkx?=
 =?utf-8?B?WHR5NlRQTHA4RldzbXNlYUxoZ2lJelBOU0Y0YS9QNHdtOTVMVFNLeUJadmY3?=
 =?utf-8?B?ejYxYmx6Vk5heUVGN1N0czZ4NUppazY1QmZGTHo3Qmd5VkpCeVQ5SWlIUUoz?=
 =?utf-8?B?ZFNBREl6V3lSOFN5c2Y0eUJrMWRkRFoxK0ZUOWkxUk9CWnVCZjdZdWR5U1JD?=
 =?utf-8?B?RzBNSEVSSW5la3BYSkZUU2VmU2t1aXRSbDB5R1BkZ0hiRzRmeE1kS2hWQjR2?=
 =?utf-8?B?M291a0tuYzNuUlFrZ0xjM0p6RExmM29OY1JoeHhsTk9zaHFRb3JiZG5qNnFo?=
 =?utf-8?B?SG5RQ2lGU3ZGSzVpaktPSmRJNXlXOFlHTGhqanZpcjRQbDE1d1I0TXdvVXVj?=
 =?utf-8?B?c21EOHNTa3lPUjJqOTUwbGIvVU5aa2I0MDZOZHJ6UmJoTUlBL1hOZkVlc3U3?=
 =?utf-8?B?SG40R3NBRWhQZ3Y5SUNCaCtuaE5CdUhBMThJQ2VLZmNKUkoyQnRaYlQvc1VY?=
 =?utf-8?B?cjhjR202aWplL0JRNFJPNHRUQnkrVkVMSDRuS0t0Ym9kcDE4TDlTSlhLaXB2?=
 =?utf-8?B?MnFhZVhXS1pNcXE0WGo5WU9HUjNGaUNJcGE5eTdHKzZvYVczK0RUc2lTaURn?=
 =?utf-8?B?eEFYQmhldW9yeWUvZUFEWitKRUF6MitXOUtxa2QwMTdZdk8rLzZZZVI0cFFa?=
 =?utf-8?B?TmR1OG42RHpnWHRiUnF6L1Rqd0l0T3FJcGwzZmxuajhKR0FLVHBKRlppMk0y?=
 =?utf-8?B?SGdtSTF5aGg4c21XVDhHS0tLeDQ3a0ZDNGtsSEl6c1hNTURxcDJ2dzFPamJB?=
 =?utf-8?B?ZGFFZzRyeVJGWHNVam9kTkViekRNd1lMM2lVV0gxaFZYU3lJTU5sR2FrSUNO?=
 =?utf-8?B?WUZQRmN3OU5oNitlVzJ1MXI1aDZHWDVDc2dWbEVlR3lXZXBIK3hNdHN4WmJN?=
 =?utf-8?B?SmNUZ21wM3N0aW9mMkdKM1cydU4zdFlRbW5BVzJZVGhVeGlqNFJSS2x2RXlk?=
 =?utf-8?B?TUwvRit6STFHOWh6akF2Q0tHLzNzNDk0RG5qMllDWjVaeDJab0lqTmtvc0Jq?=
 =?utf-8?B?QlhHUFRPRDFTcWwwOXcxVllOQ2FqVllveWRtajk0YmUvN2MwczArS2JRa2Zv?=
 =?utf-8?B?WWRiMm5tYmVCbEFleXdpdERVVHJiSmkyMjdrUWxPWGNlMkp6RWFsdEFFdFRu?=
 =?utf-8?B?cGErQjVZSFYyd2JLYzBvcjdiYXNpSXhmelAzNGVHTnRJY2Nsai9lSkJIZW9Z?=
 =?utf-8?B?M0VDTGZDbjluV1E0MzR0dWRmdUpHNTFndytwZWkvN3VlZnJJSWtVczVjWkVo?=
 =?utf-8?B?ZUFSam1YUndlNGdpemZzZ0xRTGt5ay9remFQaVpDVkhWS1NQK3JqTmVVZ29R?=
 =?utf-8?B?L0xaS3IzNWVQUUhHK2hyRzBqTXB6MjUvaDl4ckhTdUZCR0o4TTUwQkdhejZP?=
 =?utf-8?B?a0xDNDBzU0x1V1lzZGlLcUNOaDYraENxMHNNN2QxZjVHK3k5azlpd2IwTi8y?=
 =?utf-8?B?djFmMWJCRVQ1bFBVa1hDMTNMRm5hSXVibWpqblVRRlMyRTRLbC9mK3FnaFFh?=
 =?utf-8?B?MlBlaHBjTUIrVkJtQ1pDVW9tZ3RSKzVoVjdMc2tpVFFyeWU1VzdYTlgvckdQ?=
 =?utf-8?B?YUpLMWhZM1RxL1BYUWtSS3pMSWRyVURFdVpRZHpFRkU3bjhlczk1T3luNVp5?=
 =?utf-8?B?NmFBYzR3Vy9vY0xRd3UwWE9ZbndnQTQ3S3E5MWxzZE9abzNrbzcrVVIvRDdK?=
 =?utf-8?B?aGZmem1wOVNnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3ViaVJ2Y2NaQVpVQVVhQ2VmSUFZL0gvaE5TV0V2N0txS0hDZ1p3SzhnOHJ4?=
 =?utf-8?B?cUJGbTVuNGhmM0l4aVVwamNWWE9NSTZDaFBEUTIvdFdsc0ZMM3VIZ0t4eUE0?=
 =?utf-8?B?K1o3OTYxVjRKWDU5ZXhDUEQ1NFVFYjdsUlVEN3ZtdmJIQythOTlETGltTTBm?=
 =?utf-8?B?K1lXMFcxdkQzKzVEMzkveVk4QVhoL2hxL253aExyTGErTWFXbjBMTlI4MVlp?=
 =?utf-8?B?TkRLY0o0clZzWFBJRGxvUVNmOFdmMWRtSm5kWE5oQU0rNnZ3UDU2YkpuWGxZ?=
 =?utf-8?B?dzdZTmorNVcyWUMrUThYNUxjbGVlc2ZHQXAyd0FMc1pLaGNPSFlVbEZJUlcx?=
 =?utf-8?B?QnVOTWI3enozamE3WmNtVyt3UzQ4eVh3YXBoZ2I4NlBMekR3UjQyK1hwVDl4?=
 =?utf-8?B?a3FMY3lXbFc5TDgyNk14b0pndmxrdjl5Z3AxVWlLRE1WdVJuWEUvZitSSWJ0?=
 =?utf-8?B?dm40cjdKc1NEb21oOHRmbnNEQ1d1UEJXSnE4b2dPUlNqTkI5cTkvK3p5T25B?=
 =?utf-8?B?OU9PY29scFlFY2FSTFhzWG1Bd05NR2VvTU9aTDluSzdKN2tGWk1sOCsxRzdl?=
 =?utf-8?B?YkxHeUtyYVF0SXIwa0kvelZZaWlkRnhrL2tvWmlLbkV1aWdCSk90bGdVK2FN?=
 =?utf-8?B?cGkyTTBudkR1U2QxUTdlUk1MdnZKc1Z0UThUSkVTR1duVXdNV2xZcmNOT1ht?=
 =?utf-8?B?ZXlnVG5ocGd1ZUZjcFQyMVZqWHZRQnVhVjJuNjFNK2xJR25vNzFEb2ZCOVky?=
 =?utf-8?B?UTdnMUREV3I2c1B3bHdvdVpYVC9rd3hRVURyQ2Z0TktZVS9leDlMOS96UG9w?=
 =?utf-8?B?bEdoSDJmUkNxbVJjWFZnTkpiK3BXeXFqZnpiRmk3aWxQRDFRZEdUUGd4dDNZ?=
 =?utf-8?B?ZTFGdnZ3VDlLNlpCajRTbVFNL01pL0cxV01rQkVYRmF2VGRhWHZGRXZhclJr?=
 =?utf-8?B?WlQxanZ6aXFwUkZuU0o3UnU5NWRQelhXdkJVRXNscHlrZGhuOG1LOXBtK01L?=
 =?utf-8?B?eEk5T1IyTTZmRVgxaTA5ZksvVHRRcHJScWR0QWZERitDc2g2R1hOVExzS2xV?=
 =?utf-8?B?MGl5Y3c4SXBHWVZWSlNhaFNMdDJGWGhETEtKRThhRXN1bjVWenhLMWRKNHh1?=
 =?utf-8?B?UTlnV3BKb29ERlNWNlJUeUc3NFRaZEhTUHBqUjhOMno5OThwN1FvUzRkbnJv?=
 =?utf-8?B?N3I4WnFQVzJHNHBLUmR0SDdhK1NCT2FSNDcrdzE0MlgyVWhlL3JxQ21IRE05?=
 =?utf-8?B?UFdzeGFsSTNXUGM3MlF2VnU4YlVvRFVwZ3VvcnhySVRTSHNIa2cySHk3T3RC?=
 =?utf-8?B?cnVMWnUvYWNxdHErNEpaY3IvNkZ5dXpDUUREb0JuclF3M3BWSzBiaXRmVkZ4?=
 =?utf-8?B?Y3l6VDlkVDdWRkltSExMS1FpdHhaQVJWclBIeC9Bdk5abThpS2VmZ3ZaQkU2?=
 =?utf-8?B?NEhWYVdmZ21GT1ZqbnFwQXNLcUZLRklESWtvNDhwQlBpN0lUQ3cyY1dicFBB?=
 =?utf-8?B?QWFEbkdoK2wvUksxQmcrYjRJaGk1UUJuS2JZMHdXemJwRExDYWp5WFF4bFVX?=
 =?utf-8?B?Z3I3MS9uZVkzMkxlbFQ1SFVkUXlHRXl2RFpDcnV5MFd1MVd4VTdlSGtGNmRN?=
 =?utf-8?B?b29PbEx4cXR5cStpYXhNMTEwMjdWbm5EMDgvRG9Bc0lBQjJLOWdmMHhMakhs?=
 =?utf-8?B?S0NOV3psaWNDdW9sbEhVNC9va0FnbDRpNktWNGNYekNSbUFkVEtiRnZUNjZq?=
 =?utf-8?B?ckhDSUFQdDZCSEwyUkFQWFA0N0x1ZEtSR1h6WUg3WVdEWGE5UmU5R2MxaGRY?=
 =?utf-8?B?b2pOQlQrRVZYaUM4akRBR2IxWVlsNEZEVTZ3RHdVUURhNkszcjd5QW5HS09S?=
 =?utf-8?B?VnNibVRjQkFHK09CTFBwMGJwQm5IdWZaQ3ArZTE3ZWNyMC9td29IUkRNMlZN?=
 =?utf-8?B?SDlYYTU3QzdYUWVib0hsWTcvOGlFQkVGdzNCV2tQMG13bmd3aTJTMjBTSzUx?=
 =?utf-8?B?b0ZOOFMvdlRaZVBaZ1luYlFkcU43QS9iUTAzemU0OHVCRWl4N1VwdEY4RENj?=
 =?utf-8?B?cVcxRW1tN2FZa3ZnNkRlZ0ZLdzE4MWJOdGw3bElBZmV0N1lhR2RtamJFN1py?=
 =?utf-8?Q?FGr0nHyNS/4fRQ7Q1tGVaMOzY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1d2e98-ecdf-4232-9a83-08dd2e3eb90a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 10:41:48.3340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvkXMg5rdWRvPn2JRA1f0vk5TGKsOHjbCTNhPoxAcjuzk8WOA58vsAtg8tZUPYw40FRIAI0S2m22LLEq+yKgOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911
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

PiA+IEBAIC0xNDEsMTEgKzE0MSwxNCBAQCBzdHJ1Y3Qgc2NtaV9iYXNlX2Rpc2NvdmVyX2ltcGxf
dmVyc2lvbl9vdXQgew0KPiA+ICAgICogQHN0YXR1czogICAgICAgICBTQ01JIGNvbW1hbmQgc3Rh
dHVzDQo+ID4gICAgKiBAbnVtX3Byb3RvY29sczogIE51bWJlciBvZiBTQ01JIHByb3RvY29scyBp
biBAcHJvdG9jb2wNCj4gPiAgICAqIEBwcm90b2NvbHM6ICAgICAgICAgICAgICBBcnJheSBvZiBw
YWNrZWQgU0NNSSBwcm90b2NvbCBJRCdzDQo+ID4gKyAqDQo+ID4gKyAqIFRoZSBudW1iZXIgb2Yg
ZWxlbWVudHMgb2YgQHByb3RvY29scyBpcyBzcGVjaWZpZWQgYnkgY2FsbGVlLXNpZGUuDQo+ID4g
KyBDdXJyZW50bHksDQo+ID4gKyAqIHNldCBpdCB0byA0IGlzIGVub3VnaCBmb3IgaS5NWDk1Lg0K
PiA+ICAgICovDQo+ID4gICBzdHJ1Y3Qgc2NtaV9iYXNlX2Rpc2NvdmVyX2xpc3RfcHJvdG9jb2xz
X291dCB7DQo+ID4gICAgICAgczMyIHN0YXR1czsNCj4gPiAgICAgICB1MzIgbnVtX3Byb3RvY29s
czsNCj4gPiAtICAgICB1MzIgcHJvdG9jb2xzWzNdOw0KPiA+ICsgICAgIHUzMiBwcm90b2NvbHNb
NF07DQo+IENhbiB0aGlzIGJlIG1hZGUgc29tZWhvdyBmdXR1cmUtcHJvb2Y/IEZvciBleGFtcGxl
LCBmaWd1cmUgb3V0IGhvdyBtYW55DQo+IHByb3RvY29scyBhcmUgc3VwcG9ydGVkLCBhbmQgdGhl
biBtYWxsb2MgdGhpcyBzdHJ1Y3R1cmUgd2l0aCB0aGUgcmlnaHQgc2l6ZSBhbmQNCj4gcXVlcnkg
YWdhaW4gPw0KDQpIaSBNYXJlaywNCg0KQ3VycmVudGx5LCA0IGlzIGVub3VnaC4gMTAgcHJvdG9j
b2xzIGFyZSBkZWZpbmVkIGluIEFybcKuIFN5c3RlbSBDb250cm9sIGFuZCBNYW5hZ2VtZW50IElu
dGVyZmFjZSBQbGF0Zm9ybSBEZXNpZ24gRG9jdW1lbnQgVmVyc2lvbiAzLjIuIEkgY2FuIG1ha2Ug
YSBuZXcgcGF0Y2ggYXMgeW91IHNhaWQgaW4gdGhlIGZ1dHVyZS4NCg0KQmVzdCBSZWdhcmRzLA0K
QWxpY2UgR3VvDQoNCg0K
