Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9BAC36010
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 14:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A0D80584;
	Mon, 31 Mar 2025 16:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pHpKo1qA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C7C81E1C; Mon, 31 Mar 2025 16:43:37 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2D480050
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTeOTkRmM98a2+4tKmOt9aDz72fTJiCLNT6T5xpXodwCGO4zOmFX8V1fNeyFafjvAbHYM87xBIhe0TZ2txlkvTfmoSNNjFCGhrR96HWE5tMZoj/u0/F1L3BpPkoBnkrFQhmwqyOLwPFEmSe7+rQOwVkNQRWg4SyGkmHgkXSDcF+BueIUpTaXQ9qAsk+FTOtBnyWqdeP42pNVhr6nNrOTPplWoiXWSL/CKZ7W0gM3DoBKGHBsrp9Z0CmvoRc7WWtSPcKriJs58P0PbsS5ljQymRch230DbsYs0bQdd60CZvraCur5jx1hUNhjPd0UhoqyYUSVwjU2ZUxADIzYBiN97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiNPBjzziXf32MVWagOwOgszWW0GdlPXmjkR73uEmKA=;
 b=xQ/Pdc/NBwq2tP4/DC6sIeJ+rQQjkdHNJYOtzDh2oXGh0IvIR0XFPWc07VFeSyKRBT/DAIOexMBeE23hqVWaTaLtL3VegXCOGLcxnmR+WoLW0s758AIPFJxOmSqLJvuR7MhgEpmSwg8qh9XY7R+QEoo7BGP0MIHVHYq5vN6mftLVHV3T6EY/syztVRt6bUdFb4vwEDBhWmu2pSOB/X5ytmcHHvFqq0pczuUkT7bcMkwVr/32r20U1TxBfSC9466NtF2U53imbiFAjkflQGhJxmeS2C0mQq2hPuqize4vNv8cSZf2RWCaBh1WVsuiTDi+Jukoj3SmXoNpcxBwk7MfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiNPBjzziXf32MVWagOwOgszWW0GdlPXmjkR73uEmKA=;
 b=pHpKo1qA7sgqTsqgGGWLEeNAvHhiPbTwQh260bDnHdIY864NktaEdXRan41K9PctI1qR0VfDxgI8CSKUal4tX6kqMDojjZrY1hcWAk518Gv/3MyDz/DyAZiqdyUY6Qhwhcrpk07q/TXJh1IgS91pxZD6VNd8lcb67P/UcPpBxQ15BLqTSSux2NHxBhtBI2GtL6pbplDt31BJZC2Fvo4VYds1/IllrY83yFx094I5GUinep8vZLUhgHVLl+tggsHtVI/rQWpJdHkY/xYeHQl6lthViJo7PSucn/uxhzonk42pHA1cr9PHZUrg7938zy2XPmYQAkRNXOHGjLw+NOD2kg==
Received: from PAWP195MB2176.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:330::14)
 by AS2P195MB2168.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:43:33 +0000
Received: from PAWP195MB2176.EURP195.PROD.OUTLOOK.COM
 ([fe80::ea1e:17ff:23ca:3c0]) by PAWP195MB2176.EURP195.PROD.OUTLOOK.COM
 ([fe80::ea1e:17ff:23ca:3c0%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 14:43:33 +0000
From: Leonard Anderweit <L.Anderweit@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "sjg@chromium.org"
 <sjg@chromium.org>
CC: "brian.ruley@gehealthcare.com" <brian.ruley@gehealthcare.com>,
 "marex@denx.de" <marex@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "paul.henrys_ext@softathome.com"
 <paul.henrys_ext@softathome.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
Thread-Topic: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
Thread-Index: AQHbX7Gt4h/XxSZIi0u1wPbD5UCxvbMJ0fQAgABn14CAAHVggIAAcmyAgANflICAKi5JgIABukaAgACFe4CAAEW7AIAC6eMAgAp/l4CAABVlAIAebDcAgAAJewCAACWVgIAAOO4AgAeHdwCADIWSgIAAPysAgAAG6wCADRJZgIAAHG4AgATNQIA=
Date: Mon, 31 Mar 2025 14:43:33 +0000
Message-ID: <0261fb66f34d30c6fc3ea1995bf23d4a055dfb6b.camel@phytec.de>
References: <20250105203714.158480-1-marex@denx.de>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
 <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
 <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
 <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
 <CAOMZO5ARze74UsOqUbMLfsyjfFcpBQ38hgqTZnrP4ZkqNOZiTQ@mail.gmail.com>
In-Reply-To: <CAOMZO5ARze74UsOqUbMLfsyjfFcpBQ38hgqTZnrP4ZkqNOZiTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWP195MB2176:EE_|AS2P195MB2168:EE_
x-ms-office365-filtering-correlation-id: d16e648f-6504-428b-8c4f-08dd70626970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K29OcDNwVUZuQ1VIT0FFWHhpZ0ZKQ1k3d1NyWXU5THdDOUxJOFFRcXk3RGZ3?=
 =?utf-8?B?akwwaEhod0pBY0pmbVF2bjZjbzVvcWlrelRtQWV6VDhNbUwzZE10Q1U0aHlU?=
 =?utf-8?B?Q08vWGJZUnZNM0JoWnZ6QnlMM09ibVJSZ3ltOVZTUWZTY3VjUXNDaVNrM2NR?=
 =?utf-8?B?Q0NLb1F0MnF2Q0NLWlZVVDFjbFFNUEFvczdtOGZkTkFkN1FveEYwcEhlSzFw?=
 =?utf-8?B?UUJWS1FQUlo1UjRndUw5clBiZmtzVXhGMncrRGd0OFhwWXJVZzU0Y2N0V0VO?=
 =?utf-8?B?Q0EvNnNrdkY4UlhVN3ZWdDVOeWpSQ0VmU0pSdm5kM2t3R1Z2bTROMEFsMGE4?=
 =?utf-8?B?RkVIM1lWQWJpc01oVDBybEhUZ2VGNFI0WXVIZDJDMEtYMFRUTkRiU0hVazhm?=
 =?utf-8?B?dGRvbzJteGdEYTRXWHBCS1ZzblJ4OUx0MDA1bkJTbjFIRzYwVkdsNjhFcURK?=
 =?utf-8?B?RlZuMWc0dVRqYUJuV2R1YWxSdWFzS0pqTlc1clBCbnlZNGZMRFVGbzFaUGJT?=
 =?utf-8?B?UW5PaEdrNmhLM3J5NVRSNUlGeHUyS0kxb0lHWm9xTzJGSS9lQ2dINUdDbXA1?=
 =?utf-8?B?cnFiTzNoeXFQZ0tHZ0dXVTJ1VUJwQjhkSURzc0d1TXMrdVYxbmc0aFBTNnBN?=
 =?utf-8?B?c3ZBem1pVzFoa1htb1pEWEVaYUU0czhRcFJ2d08xdGZnWW9HWDBSOExPVG1L?=
 =?utf-8?B?OEYvTVB3WEMwT2tOa3NlUW5iYWkxTGRZYi91VGpBaktrTG1tQUxiR3pZa25T?=
 =?utf-8?B?UlVGTXYwdUNOK0NQYkJ6anBici9ibnp4U3hPZFVrTFk5NXk1S2pqbTJqSTVL?=
 =?utf-8?B?N29nMHVCTjhNNmlMZXZ0cXIwWjd4Z3laL0xEOHc3ZG9DMitmMlBOYVlWS0xN?=
 =?utf-8?B?ekw0WjhNbnNuTS9sdDJhQkJueTBQdno1TkRTWnp1MU9CMHNnWWVHRERYZ0F2?=
 =?utf-8?B?ajN6emZBMEliaitJa0pFSWZBTjFkYTA1TnhCNVphRm1ZZjhWSVRicmptSGt4?=
 =?utf-8?B?UXdhMEhCQUc0RWZYckloelMzRWxZN3h0cFNKbmZuYzJqQlNXYzFISDhnN21L?=
 =?utf-8?B?OCtaZHJnSlN2MzRJNXJPYzhlRTdnNXZGcjFodlJEQmFKV0dCcEp2TGZHZ2pt?=
 =?utf-8?B?dU56UVhKMytIbVZUT25SWE5SVlVXNFhUK01PanhackdQWEJSZGp1WVczYzFm?=
 =?utf-8?B?TGdyRFBHcVZYMWJGNDBySGxTZk5wNEJQTjA3T1NKekphZVl3THpIOVd5d1BH?=
 =?utf-8?B?Y056UXlVM1N1NDRaMWNzTUE3VW1mV1E2MStjWVRVYmFtOUJ6ei9uS0xCNmlx?=
 =?utf-8?B?WHdTM1YzV3NzOCtIcVMwUHJtT1l1Skhkc3BCelRscnk3U25RdnFiM3VrTTR0?=
 =?utf-8?B?T3VkRGp2WjlIY2g4aFJ5MmNVb0Y3S0xJRGwvWEw0UVdDekZxNWZ3MFF5UTg0?=
 =?utf-8?B?bmhNM01rVFB5NXZ5cCtVTlF0N21vQW9iSkRKL0ttdGkrclpYb0NPaGgzSzA5?=
 =?utf-8?B?QXFYUmdZRmZ1U1llblVRM0NVYW5xSlBSWi9qaUJ1ZW9xanZJM0Nna2gwTGJO?=
 =?utf-8?B?Wk1jU2l2SExObGlZOVNhaFlYWCtLYU41RjZOUllsYkJJU1h6M085U3phTjZB?=
 =?utf-8?B?enQyWUlrVnAyUVRnRzBXT3RwdkRaVlJTa2UwSFVpbFZzMVduMWZNZXlpeXZt?=
 =?utf-8?B?SExWZU5MVnpHdWpqMXBTR25hUytCQXhrN2ovZWNIYkQzQmFkMWxHQjNUelRR?=
 =?utf-8?B?UDZCWHk0Y1NzSUZTNFZMbGRRSTJyM2tiZkx1ZGpuRGlXTnp6ays3aFJFc0oy?=
 =?utf-8?B?OGpVUG9TWUg2dC93SWc4bkZPVHFCempJbjN0RHc2ejc3SDdaMXZPZWtGd28w?=
 =?utf-8?Q?V7Pi8xoykdMUB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAWP195MB2176.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG8yQWtQY0VIZTRpMHU2WFhBUXJVb0hJbGpoM2pmMXNoMkh4NnF1aVpkRU5E?=
 =?utf-8?B?YnhEYzhhdDVNQjFvT2ZsZVlRWGlVaEE3TUVMODJ3RTJTOTAvZytOcDRTdHpE?=
 =?utf-8?B?WEdzbnBPaWRXU1luZldMMGFERGlZbDN2UzhrdFB5V2JHMFllcmVYbzc4UFcr?=
 =?utf-8?B?QS82NjNzQklkM0srbzhRUkFTcTF1QzJNL0xtSVNyVzhJbjhhWm5aODJjcmxD?=
 =?utf-8?B?c0djeGlKTUxucFFGTmFJcG4rOEdaTWxrQ1hYYzd4RW5TZllhQTRIR1U3K0lU?=
 =?utf-8?B?dVVPeEs4SzhYSzB0MmNIdVVPUEltRGNYNGdzQ2hjUUlZOERJS0pZNGM4Y1BF?=
 =?utf-8?B?VS91VFI3eFJibktqUmwwcHV5MkNSQkhwYW96aDlqQmk2eUdIR3ZPRGZVdHRW?=
 =?utf-8?B?TDlMdjZtVTFMUWtPQVlhblNCY2phVm15N0VQdGRNai9lcEdJdGU3aVRJZlE3?=
 =?utf-8?B?Rm9KUUdLZ2JnRWNiSXgxY0xmVHNkZE81RFpGeUsvVkx2d25QRktWanhHY29F?=
 =?utf-8?B?S2ZpZmR6bGpaT2NqSHBUdVJZYk5XMGM5b3JkcVYwQ1lyNUhXdU1VK3liYjdh?=
 =?utf-8?B?bTVPZzExRTU4K2dYeDIwZWtNL3A2c1R1eG5vRGxkTCtSVUFXQnlJT0JYNkVz?=
 =?utf-8?B?ZGo5NlFtdmhsRUtjNTlVamM0YnNTcCtnUDBUdWRLZHo5VHc5VWpHVHAxcm5r?=
 =?utf-8?B?eU9LU2xCakVOeE1UM21mYlR0WklFZ01IcUl5c0p5ZVFNWDkvS2RqbTQ4VGE1?=
 =?utf-8?B?Y0R5cWRaYlprRks2bGVYUDJWSDhHdTZuQXFQYzNlQXhEOEdOTVlsTUhsTnl5?=
 =?utf-8?B?RWNDM0RyckdUbSs5RXdjQ0xIYnFxWUdVYmxscUh6eEJBc2QzR1lVeENHcGlk?=
 =?utf-8?B?S3hiTDl2VGd2RGNBSW5uUVZKLzdLODhxdldxekY0dHp4RUVRM1l6dFlwSEps?=
 =?utf-8?B?VEdwc2xIVlhNRGQzRTN0NDhDRVVsUm9ZaFZEWWM4ZE9xR3pLN2Z3SSs4MUZB?=
 =?utf-8?B?MzJKR3hkdER1M3E4WFFhRFk3bWRPVTVlMTdqUi9TNDZLYU1xZ3VRZjVqaGhU?=
 =?utf-8?B?b0lWdXhmbDV1eTdwSEFGWGZPQnBLazc0NU1OblNvbVdKWVE5c1ExSFM1bitK?=
 =?utf-8?B?c1Q1cGtZWmVWcmxLaFJ6Yk9DeEtZeW5oV2JDa3dPL0tXRGJrVzJUK3lIa3l1?=
 =?utf-8?B?ZGF6cVdtVXBpbU1BN1JqQ0pFemhBU0x4bDNVeFA2NXd5Ylo2L2UyS1BESm16?=
 =?utf-8?B?YlB4WGFGMVlnR2lHS3lvV0RKc292bW1Fa3Jvc0taY1VyZ3hCNjdZMU13MjBR?=
 =?utf-8?B?ZWxzdGNGSVBlWXdndEN4ZDRaTUgzUENzTEJRL0N4MHd1eHVIZTFsdjRWckFx?=
 =?utf-8?B?SDVoa2k2eVNNMGlvSDFzZlBBZlNvemhIMnFYMU5URmpJaHlJZkp1MGkwbCtz?=
 =?utf-8?B?cWJNOEtONHpTZFd4VWp6M1FJdlg1U3ljeGxoK3ZvOGNrYzF5dkNMTTFwTDJT?=
 =?utf-8?B?N2x0WWtXblhwOWRJTzRqY3ZFY3dWTy9HU1p2NmFBUE96dFpXcGhvS1Zrdkts?=
 =?utf-8?B?Y0hUbmZSOU5Wc2FFTE5WWVZDUTZGcy9vTGxDNGpMOEdFeTVSenhMTHRCWUxH?=
 =?utf-8?B?bEczTjVlT3Yxd2ROTHBvcS9VeDQ4clhWaWpwR2xpemFUQmhvVHIxRytyY2d3?=
 =?utf-8?B?cUdMY25vU2FrK2l6MFVYNmlGVWxLZjNyTWVENmdRY3VqaWxmbXhjd2dsYzFU?=
 =?utf-8?B?bnBvL09UcUZsOVRUQld3NmNOeWlsZGdvR3dYMTdGWTgwc1Q5M2o4NnJoWGFh?=
 =?utf-8?B?UXhxSmJ2UVZ3Y2lpMDNDb1hxdHBUV3E0YkVQek9zSGMvSThBY0NyNTA3SG96?=
 =?utf-8?B?UjhDSlY5SXFpNUhTbDZ0M0RpNXRaekprU0xsUHpxeGlWOEVpMHRoU210ZDJw?=
 =?utf-8?B?U2c2QittL3lSNVB3cHhWRFdiZ2RjdGxwOHBHOEFTeVRyMExCbXh1TDRlWlI1?=
 =?utf-8?B?UEF4MEdSd3BEU1g2Vnp2czRTTG1nR0lSV3g5NWVrSGV0d1FWQlJzTzRQSEhX?=
 =?utf-8?B?dGx5Z0paeE9YYXhrRGh1NVZrNFhNWGNzdU9xVDlJbkZVWldraWhHeE43eEZM?=
 =?utf-8?Q?y+mJWMephlKVQCepU6Bdv6EVt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70FEBDA9FF09F44594B6B11EDFDF8744@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWP195MB2176.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e648f-6504-428b-8c4f-08dd70626970
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 14:43:33.4194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mmpj0cQL7HqvFVErRKzKjrEPGpXd4BPPH5T1mXfMsSxm0TmbDoEK25QxoUz/VsKNf9nMFm9OfYfz6ppLh75aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2168
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

SGksDQoNCkFtIEZyZWl0YWcsIGRlbSAyOC4wMy4yMDI1IHVtIDEwOjIzIC0wMzAwIHNjaHJpZWIg
RmFiaW8gRXN0ZXZhbToNCj4gSGkgU2ltb24sDQo+IA0KPiBPbiBGcmksIE1hciAyOCwgMjAyNSBh
dCA4OjQy4oCvQU0gU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+IHdyb3RlOg0KPiANCj4g
PiBEaWQgeW91IGZpZ3VyZSBpdCBvdXQ/DQo+ID4gDQo+ID4gSSdtIG5vdCByZWFsbHkgc3VyZS4g
SXQgd29ya3MgZmluZSBpbiBteSB0cmVlIGFuZCBJIGp1c3QgdGVzdGVkIGl0DQo+ID4gbm93LiBQ
ZXJoYXBzIHRoZXJlIGFyZSBzb21lIG90aGVyIHBhdGNoZXMgbWlzc2luZyBmcm9tIFRvbSdzIHRy
ZWU/DQo+IA0KPiBBcHBseWluZyB0aGlzIHBhdGNoIGNhdXNlcyB0aGUgZm9sbG93aW5nIENJIGVy
cm9yOg0KPiANCj4gaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS91LWJvb3QvY3VzdG9kaWFucy91LWJv
b3QtaW14Ly0vam9icy8xMDc5MjM2DQo+IA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT0gUnVu
bmluZyBiaW5tYW4gdGVzdHMNCj4gPT09PT09PT09PT09PT09PT09PT09PT09DQo+IDE0Mi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLg0KPiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4NCj4gLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQo+IC4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi5JbWFnZQ0KPiAnaW1h
Z2UnIGhhcyBtaXNzaW5nIGJpbnRvb2xzIGFuZCBpcyBub24tZnVuY3Rpb25hbDogY3N0DQo+IDE0
M1NvbWUgaW1hZ2VzIGFyZSBpbnZhbGlkDQo+IDE0NC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uSW1hZ2UgJ2ltYWdlJyBoYXMgbWlzc2luZw0KPiBiaW50b29scyBhbmQgaXMg
bm9uLWZ1bmN0aW9uYWw6IGNzdA0KPiAxNDVTb21lIGltYWdlcyBhcmUgaW52YWxpZA0KPiAxNDYu
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLkUuLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4NCj4gLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQo+IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KPiAuLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi5zLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4N
Cj4gLi4uLi4NCj4gMTQ3PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID09PT0NCj4gMTQ4RVJST1I6IGJpbm1hbi5mdGVz
dC5UZXN0RnVuY3Rpb25hbC50ZXN0TnhwSW14OE1DU1RNa2ltYWdlTWlzc2luZw0KPiAoc3VidW5p
dC5SZW1vdGVkVGVzdENhc2UpDQo+IDE0OWJpbm1hbi5mdGVzdC5UZXN0RnVuY3Rpb25hbC50ZXN0
TnhwSW14OE1DU1RNa2ltYWdlTWlzc2luZw0KPiAxNTAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLQ0KPiAxNTF0
ZXN0dG9vbHMudGVzdHJlc3VsdC5yZWFsLl9TdHJpbmdFeGNlcHRpb246IHN0cnVjdC5lcnJvcjog
dW5wYWNrDQo+IHJlcXVpcmVzIGEgYnVmZmVyIG9mIDQgYnl0ZXMNCj4gMTUyPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+
ID09PT0NCj4gMTUzU0tJUDogYmlubWFuLmNiZnNfdXRpbF90ZXN0LlRlc3RDYmZzLnRlc3RfY2Jm
c3Rvb2xfZmFpbHVyZQ0KPiAoc3VidW5pdC5SZW1vdGVkVGVzdENhc2UpDQo+IDE1NGJpbm1hbi5j
YmZzX3V0aWxfdGVzdC5UZXN0Q2Jmcy50ZXN0X2NiZnN0b29sX2ZhaWx1cmUNCj4gMTU1LS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+IC0tLS0NCj4gMTU2Tm8gY2Jmc3Rvb2wgYXZhaWxhYmxlDQo+IDE1Ny0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAtLS0tDQo+IDE1OFJhbiA1ODEgdGVzdHMgaW4gNS4wMTJzDQo+IDE1OUZBSUxFRCAoZXJyb3Jz
PTEsIHNraXBwZWQ9MSkNCj4gDQo+IFdoYXQgbmVlZHMgdG8gYmUgZG9uZSB0byBmaXggdGhpcyBl
cnJvcj8NCg0KVGhlIGVycm9yIGxvb2tzIGxpa2UgYmlubWFuIGlzIG5ldmVyIGJ1aWxkaW5nIHRo
ZSBtaXNzaW5nIHRvb2xzLg0KUnVuIHNvbWV0aGluZyBsaWtlOg0KLi90b29scy9iaW5tYW4vYmlu
bWFuIHRvb2wgLWYgbWlzc2luZw0KYmVmb3JlIHRoZSBiaW5tYW4gdGVzdHMuDQoNClRoaXMgdGVz
dCBzZXR1cCB1c2VzIC5naXRsYWItY2kueW1sLCByaWdodD8NCg0KTGVvbmFyZA0KDQo=
