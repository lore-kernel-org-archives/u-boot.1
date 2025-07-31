Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666ECC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCBB783824;
	Thu, 31 Jul 2025 13:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lt34aRdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFB383890; Thu, 31 Jul 2025 13:48:34 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::711])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E43483816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CU5jCaQpmM1Xat/PfsZKpz9CxDRZrpBejK278VV0QYYMee6dOGp0MxRQhTjRSmnasGaPGDbWpqFOrdHlvSt3FcvN2oFu/3G4BU+RCqBsW9UQjpZqUjmeq8uUUHjU0P9NLAgNTVWeSAg7CA/MNgZuXFI+3GL2DoSr5tzBS66Y+x/mIG+yN+yWPxVJ7CsVPOmB18Z2N5gz8Hfch2Ou7OdpscmpTXGJV3DLoCGPAGxFhEU8tTN81nRBna+gLYxL8sbY5nfIVYV9O+9fMA2LX2NVMZbDdo/rla6BV5XHT3MAVLMIGzqi1GFUnJ49/qGM6RjodEEf5gRQ4rtRY3CCYFWvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvUhjAtVzebCSrXmgpkPWHG/rKIpM0ctbZp4wI5gfmo=;
 b=tglhzQd30wGdMeMhJOk9a+IsHOF1ltx6tWnpfnYIgX8ii8xwai1rSc2tpycy0gOxh0OAh4sECUAeiHCy+G04dGMBbdEYje6JRn9r7ApevD0OKNC84PqMDPqWL1CmIzt0L4MeQe3ANqc8N+Mu9d6Wn6vGuQAr+W+hH7dS0yvZBmVbzv08H0mVkOTy2jUpWqBhQHqu8MUbl3tuAtjEyAByMtXv7m7FX3PTQFrrPxNTS+lrIqn0pd+cAojpypNGo4eMPgXmhRttPO7Wkn4dViW9HU9Y2E1lxyxjuOTllFzBYv+sN/pCdLDrbKTKQ0wS6Fo1C88jq8Ucm6sJLDwmq770/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvUhjAtVzebCSrXmgpkPWHG/rKIpM0ctbZp4wI5gfmo=;
 b=lt34aRdFeqnBB4yieeniQNO1ybQxu/VovxIfzOPoogEDLF0fjHsUcHPcEtOFp+QmtlvymfAgLcuODsywSwvjJqx+g6H7pTQdY3IIB9rP+CcBBfsrA3/z4mgA8JT4GkVToWe1kkABNrxNVHW7VsvTs56CUX+Fwle9elDr+Emdpfsj9xg3B/bMNE4HUTkqw+FrQywErpwO4sxkUbLxkLeJehElAOQ72bVcsSlXtTELiX6+zCkIRzae/mDi0ziYQ9KEy1pBTHFUjSjS0l7Vz4z55bzFfmthZZh8Zps3A3PdV/Iu7A+1d2XEu+KgNJRJbIb+O5JSTFXcXqCMfZXku499yg==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by DU0P195MB1932.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 11:48:28 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8964.029; Thu, 31 Jul 2025
 11:48:28 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Aristo Chen <jj251510319013@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 "al.kochet@gmail.com" <al.kochet@gmail.com>, "paul.henrys_ext@softathome.com"
 <paul.henrys_ext@softathome.com>, "bb@ti.com" <bb@ti.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, Garrett Giordano <ggiordano@phytec.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>, Daniel
 Schultz <D.Schultz@phytec.de>, "d-gole@ti.com" <d-gole@ti.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>, "carlos.lopezr4096@gmail.com"
 <carlos.lopezr4096@gmail.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v1 5/5] test: Add test case for FIT image load address
 overlap detection
Thread-Topic: [PATCH v1 5/5] test: Add test case for FIT image load address
 overlap detection
Thread-Index: AQHcAIeDbVAhrF+3P0i+89D+OmUvFLRMIQAA
Date: Thu, 31 Jul 2025 11:48:28 +0000
Message-ID: <a082bc0a8667f918a1ba80b677f9285527f479bf.camel@phytec.de>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-6-aristo.chen@canonical.com>
In-Reply-To: <20250729125022.4220-6-aristo.chen@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|DU0P195MB1932:EE_
x-ms-office365-filtering-correlation-id: 9d357468-5695-4099-9509-08ddd0282a51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZjRpNURRS0NGNy9UcFVLS0wrQWJpWDJHVUVUQ0pVdU15dkRYM0dLVnlpeW5w?=
 =?utf-8?B?MjVvL1VERWFSR0Fqbm05VHBONC8zZk1jTFNlMld3WlNMWSsyUEpseDZnQWN2?=
 =?utf-8?B?bHlIUnJwL1dQVnRlMmFyMHNFSllqOHY1YU0rRUxsSlVDRE1KOXlZVmpTWGhw?=
 =?utf-8?B?QVV0dkdxQk1BU3FTd01XU1g3d21tRTR4NktlVmpWVGdhY08vRjhRYnRkV0Vs?=
 =?utf-8?B?WkFHaHhIWndFVTYxaDRlZkpOY01PbnhyMWRLdFd3ejZxMlM2SGhVdzg1NFZ1?=
 =?utf-8?B?ZmUyckN3b2tDdzdPQmppNG9DY1NsMXl6a05CdkNwTVVkQ1BlTlhXeUpJK0dX?=
 =?utf-8?B?TzRMUjFsU0tKNGd5cjlLYk5hSEwwMGVlZmtzc0ROckd6SUd3K3pIMUxtSXNC?=
 =?utf-8?B?TWQrUWxMRXAxem1VSkR6MXRrVjJ3cWxPdWQvYThldXVCYWlPMHFDMWwya29X?=
 =?utf-8?B?RnZjZm8xczI5di96R3ZpZ212N1ZDckwrajE5SDhDSzl4c1NOK2ZsN3dVSmdK?=
 =?utf-8?B?R1cxZXd6SHk1REVXM1R6eGJmRC9UN1JPdDg1azdDajhIU1MwVUk2Uk1ZVjV6?=
 =?utf-8?B?Z3RuV200d3RNbmYxbmY0bWpYdk1tSWtTeWV6Z1lYcXY0YXc5SzZxTDRrQXQv?=
 =?utf-8?B?aUtVc25STkZOcTQxc2xnUEF3TjVocHNhQVpCZStRRXp4UkgzVm95cXdraVVB?=
 =?utf-8?B?K1N4enRhQmVoNUdMdzdWQjFHSVhra3ZCNFAwRmo1ZXY4NXZNTlR2WUQ4TEpm?=
 =?utf-8?B?bDErVCt0TE1ZOFpsME9OeThFb1o4VVMyVGpMalZuVmlGeGNhQUptUXNTU3c2?=
 =?utf-8?B?eDdoUFZPSE93SFV6SHVwcnVZSElRUGVoTzZQWWNoZWdrUVN6SkRhWnZTR05a?=
 =?utf-8?B?TDV0S2xIQ2tWOU92RjJJcVBZbmxwZ05yQVB4NFZNSVJBWHdpTm02Z0pxbHNo?=
 =?utf-8?B?eENlL1FHdW9jNC9ZdVlYZ0FuNlJGc3Evclo1QXFWMTkzcGNNdDNtWlVqbXdT?=
 =?utf-8?B?QnVKbFByL09rRm5oeFU3YmhHa0tHSWMzUGFsdlAyU1VHRFlXcWFhNC9wWGI1?=
 =?utf-8?B?a3RqS0tMNndQWjVoTjRDUm1JaXFVU2U3WGpiTXp2OUdXQzdwWExWYXBha0tB?=
 =?utf-8?B?emp1MWFJMHQ5a2RuQXVGT2N6NE4xS0dVS2RkU2Z5aWttQlFqQVRIUVlOeDgx?=
 =?utf-8?B?cVU2cCsyeHJHVHNJQjJYaHA4bzVjT1pzZnRPTmFSaGl6ZU0vbzZrREZHZ1BG?=
 =?utf-8?B?OHJZUkJtRkt6aENLckQ0VHkwRy8vQThYbVBwR21xdWtONWVuZENBWGh0TEpB?=
 =?utf-8?B?cmc0cnFrU1BFbFNiR1N2dWJHZXBIWGNJalpib1dlc3VFUnJTRFNqWEFSMnpM?=
 =?utf-8?B?VzVmRnB0OWRTRGlDSUIramhOWUw4SGtnYjBzV2FrblYwYjVFdmNFdTFEUm1C?=
 =?utf-8?B?Tjg0VW5kZGJVSGJtT2llOFJaQm5OK1JLVTJ1Wm9mamU0V0tLUnd6U2JXYWRK?=
 =?utf-8?B?SmQzZEJIT0FBYTRzT0NoaW1QeGYrTXNUYk9jd3AxcFlkVGh3b0NHcWF2cXBL?=
 =?utf-8?B?aU9ISWw3d1U5Y1RGYmJTZ0s4aU5pZEtVUlBkcXRCNHlYNlhDUTBPOGozcU01?=
 =?utf-8?B?Vm1FVUJOeXAxMjF3SjdTYXdGaFRRdTBpZitxQU1XcGxnYU50TzRqUy9INkx2?=
 =?utf-8?B?Z0hNODN6K28zcFdRZkNiSVhRQ3Nta0Z1cFhtczQ0di9qZEx5dnZvZlRtZEM3?=
 =?utf-8?B?S0lkYnA2bXVkNWxpNTBoaG5Eeml1QVJkQTBFb3g5cVFpY1I2dmNBRnlkbVlh?=
 =?utf-8?B?dmxLOFpocVBNK2hkTzMrY1dNbFBSOHZQZmtDQ2tpYnU0emlxQnpNTldLaSts?=
 =?utf-8?B?ck54aWdnbHJXT3l2eWt2a2R4ZXhYV3Q4WFcwOGZuWWlJVDZjdGh3UWVlUkFJ?=
 =?utf-8?B?VEZ4TFNhZXhIbHBoUTEzeHp5RFhGa3BhR2xwMk91OTFTVE16VHVKSGlFaWly?=
 =?utf-8?Q?MlU26fSt7m3IBbzTp90D4Ezk93eso4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umx6Ty8xNDhkUjBzRy9ySC9VSGRIMEZJbmluM3pheFMvQ2x2a3FBcCszSEZn?=
 =?utf-8?B?ZzYzQnZNWklFWCs3OElBQnBWMmlSeWZ4YWFuaXluMng4VHUvc3NBc01oTXZW?=
 =?utf-8?B?MlNUUnB4dUw5ZW5TckRzOTVBd25RaDd0M3k5bS8rOHZJU05MajdYSnA3Q3l1?=
 =?utf-8?B?Slpjc2wvRjEwQkRYWmsxcGsrT1RTbk1zbHVEWHllUU4vUUphb0VKbmdCZE5k?=
 =?utf-8?B?S3JtOGYzeWE0Q0dhb2tTc1lFbkhuQW9RS3UxTWU0UkQ5ZGNWMnhjM3FjN25D?=
 =?utf-8?B?TTBxUndlUkEreGxHcDA0OUJ2VUIrc2ZreWY5Q3UzSjNZeFk4bHZ0UHlzU1I4?=
 =?utf-8?B?N3dpMnpORllWS1NJUUc0Z09vb0todndBU2Y0c3k5TDkvSDE4T25jVlFTMjds?=
 =?utf-8?B?VzkyUGhSNjgyVDRkbnhDbU16RFFUVjVGdUpZbUNGMW45akRtTE9KVHl3RjNS?=
 =?utf-8?B?VFgzdkk1RkNHU25jZkhuY3JHRlBGNEpqMWhEUFk1dWoxRVFnMnl0S2srMVpm?=
 =?utf-8?B?R0hRQjJLZm9ldUl1dTMvVEYzTHNaQkFyNXhWaWpSN3J0UVJpTXQyN3NyZWl1?=
 =?utf-8?B?ZTVSSUZib3ErWFhWNVpVTEg0eWF4VXF2MHpvbnEyUld0MHRKM3dGUEszekow?=
 =?utf-8?B?KzVkeDM0UnFTWitRZWpCaEVHeTdONHRZVlFCRUFvNHpycStyV0cvMktZc29o?=
 =?utf-8?B?NDlUV0g1RFdEZWU3UUtHaytpTzdaeFp2UCtYb1Bwb05pWmFjR3pUMDMvWFVy?=
 =?utf-8?B?czA0K2ZWdTEwd0RJRGFlcHFqemgxZ0dRRk9CVXRhbGFVQ1hzS0F1YmN5MW5F?=
 =?utf-8?B?a0ZZSlNjeFlzNTFEUy9vTnlZUXpCb2gyaFV2N0hjWEk2RU5KZHdHdmdUSC9F?=
 =?utf-8?B?NjUydFBLY1FiS052VXlhUVMxejdKdTFRU0diM0lwc01GbXI1dUFJODFWRXZ2?=
 =?utf-8?B?Z1ZKR21JZU8zd3M3dk1kMXdsSXNpeTRWeUhpWkVWRVoyQWtGVnB2M1NYeHV5?=
 =?utf-8?B?ZmJpRStURWQ0c3E2a2Q0UnpCK0pUSzBBUXgzMFJsMnVoZnJKd1BTQlN4dEI0?=
 =?utf-8?B?TFVRcWVMMWxsa2dHWDhWK3daMjBtNGFvUlZqM3M2QXZLZzdRQjdiKzJmZWRv?=
 =?utf-8?B?Znd3d3ZFWnQ1QVVTcVJOTkxIeCt3Z3RmTG1qOGdJd2l0dzRnL2t2MlVxMjRa?=
 =?utf-8?B?aWpLQVNsb1RWQWNZMy9ld1ExdjdFR3Rxckg1MXNCZ29QUUxEdmMveEYrdk1w?=
 =?utf-8?B?b0NveGJNWVBoR2ZranNNemlYK0VKbVFuTWt2bXZDR0ROeEd6N0FzZ2ZaQjI2?=
 =?utf-8?B?VmE4NnVXM21pQ1R5dmNTRERoY2MxKzFBeEY5bHhxN0RidTVhV0ZQSzJYejY2?=
 =?utf-8?B?SzZXTXFEZGpDMlY0OWw1TE5KeTlsOFBIejQyaFNaWEp3cXVmUTl1Y0s4c1FP?=
 =?utf-8?B?dnBDVm1QaGFmMGhPQVFlSzlNdy94d2VJOEFncHB4b1dQbW1zSjhpa2ZMbFV0?=
 =?utf-8?B?Qi9VTW4yZ0tad0djeFpoWG8yRmZLMjdza3A2UEtPbUVvV2dHbEhzK08rL2FC?=
 =?utf-8?B?c00vM01yVTkzTjhES29wZXJYRjRqaWZIbzAxZEVsTHZxdmgzcHcwWXZXRVkv?=
 =?utf-8?B?QWIyYU1vWHRLb3RjbG1WQmc3UGU3cFIzd3NIdUVoUW5TWnlXU1JxMG1yMzEz?=
 =?utf-8?B?YnZOT3lHRU52R2x1SmRZaldFTWhJdE5KRXQzdU5DVXE1YVpBWG1FTWlnUnNP?=
 =?utf-8?B?dDlTZ1BDaEYrN0dpamo3YmtDeXJyVjcxekgzbVBjWTgrZUkyUnR6NElXUm1m?=
 =?utf-8?B?K0ZpZlBoZTl0Z0RMUktVakxpVitzbG1RQXI0OW9JSW95K3h2bXp3OHBZSmty?=
 =?utf-8?B?TjVhRUxpcVpjTncyUmpkUmMxc2RBVjNyRW4yVVFrZExZTW5INUhxMmMzKzgr?=
 =?utf-8?B?WHhwNmRiWWZRU3JDTk1DTTEyUDVsQjI0N0REL2diejl6NFd3cSticVF0bDVM?=
 =?utf-8?B?YTZ4eWdVdmZZTGJoc1BVaU1YRy9mTWM2dFJIb2J6cGxRYW9kQkQ4MTNQRGda?=
 =?utf-8?B?d0NSMEdZeHVpeVhLcmJyZDFaaDdaLy9oQi9Fd0RjNlUwUlc1OW5MVm1PUEpy?=
 =?utf-8?Q?sbg8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C20A80F2A4DD364581F48549E8F2CFA5@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d357468-5695-4099-9509-08ddd0282a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 11:48:28.3504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yZcMXKxo8ARW6RCTWDS/ljR7nZCdhuC90rJ7h+hry07Uhfy7z4FGYlA47GP38+cZzvDAKXSjm09uRi1bEGpNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1932
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

QW0gRGllbnN0YWcsIGRlbSAyOS4wNy4yMDI1IHVtIDEyOjQ4ICswMDAwIHNjaHJpZWIgQXJpc3Rv
IENoZW46Cj4gQWRkIGEgbmV3IHRlc3QgY2FzZSB0byB2ZXJpZnkgdGhhdCBta2ltYWdlIHByb3Bl
cmx5IGRldGVjdHMgYW5kIHJlcG9ydHMKPiBtZW1vcnkgcmVnaW9uIG92ZXJsYXBzIGluIEZJVCBp
bWFnZSBjb25maWd1cmF0aW9ucy4KPiAKPiBUaGUgdGVzdCBjcmVhdGVzIGEgRklUIGltYWdlIHdp
dGgga2VybmVsIGFuZCBGRFQgY29tcG9uZW50cyB0aGF0IGhhdmUKPiB0aGUgc2FtZSBsb2FkIGFk
ZHJlc3MgKDB4NDAwMDApLCB3aGljaCBzaG91bGQgdHJpZ2dlciB0aGUgb3ZlcmxhcAo+IGRldGVj
dGlvbiBsb2dpYyBhbmQgY2F1c2UgbWtpbWFnZSB0byBmYWlsIHdpdGggYW4gYXBwcm9wcmlhdGUg
ZXJyb3IKPiBtZXNzYWdlLgo+IAo+IFRlc3QgdmVyaWZpZXM6Cj4gLSBta2ltYWdlIHJldHVybnMg
bm9uLXplcm8gZXhpdCBjb2RlIHdoZW4gb3ZlcmxhcCBpcyBkZXRlY3RlZAo+IC0gRXJyb3IgbWVz
c2FnZSBjb250YWlucyAiRXJyb3I6IE92ZXJsYXAgZGV0ZWN0ZWQ6Igo+IC0gRXJyb3IgbWVzc2Fn
ZSBpZGVudGlmaWVzIHRoZSBzcGVjaWZpYyBvdmVybGFwcGluZyBjb21wb25lbnRzCj4gwqAgKGtl
cm5lbEAxIGFuZCBmZHRAMSkKPiAKPiBUaGlzIHRlc3QgZW5zdXJlcyB0aGUgb3ZlcmxhcCBkZXRl
Y3Rpb24gZmVhdHVyZSB3b3JrcyBjb3JyZWN0bHkgYW5kCj4gcHJldmVudHMgZGVwbG95bWVudCBv
ZiBGSVQgaW1hZ2VzIHdpdGggY29uZmxpY3RpbmcgbWVtb3J5IGxheW91dHMKPiB0aGF0IGNvdWxk
IGNhdXNlIHJ1bnRpbWUgZmFpbHVyZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogQXJpc3RvIENoZW4g
PGFyaXN0by5jaGVuQGNhbm9uaWNhbC5jb20+Cj4gLS0tCj4gwqB0ZXN0L3B5L3Rlc3RzL3Rlc3Rf
Zml0X21raW1hZ2VfdmFsaWRhdGUucHkgfCA2NSArKysrKysrKysrKysrKysrKysrKysrCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0L3B5
L3Rlc3RzL3Rlc3RfZml0X21raW1hZ2VfdmFsaWRhdGUucHkKPiBiL3Rlc3QvcHkvdGVzdHMvdGVz
dF9maXRfbWtpbWFnZV92YWxpZGF0ZS5weQo+IGluZGV4IGVmOTc0YzhjNzYyLi41MWY3ZjY0YjI1
NyAxMDA2NDQKPiAtLS0gYS90ZXN0L3B5L3Rlc3RzL3Rlc3RfZml0X21raW1hZ2VfdmFsaWRhdGUu
cHkKPiArKysgYi90ZXN0L3B5L3Rlc3RzL3Rlc3RfZml0X21raW1hZ2VfdmFsaWRhdGUucHkKPiBA
QCAtMTAxLDMgKzEwMSw2OCBAQCBkZWYgdGVzdF9maXRfaW52YWxpZF9kZWZhdWx0X2NvbmZpZyh1
Ym1hbik6Cj4gwqAKPiDCoMKgwqDCoCBhc3NlcnQgcmVzdWx0LnJldHVybmNvZGUgIT0gMCwgIm1r
aW1hZ2Ugc2hvdWxkIGZhaWwgZHVlIHRvIG1pc3NpbmcKPiBkZWZhdWx0IGNvbmZpZyIKPiDCoMKg
wqDCoCBhc3NlcnQgcmUuc2VhcmNoKHIiRGVmYXVsdCBjb25maWd1cmF0aW9uICcuKicgbm90IGZv
dW5kIHVuZGVyCj4gL2NvbmZpZ3VyYXRpb25zIiwgcmVzdWx0LnN0ZGVycikKPiArCj4gK2RlZiB0
ZXN0X2ZpdF9sb2FkX2FkZHJfb3ZlcmxhcCh1Ym1hbik6Cj4gK8KgwqDCoCAiIiJUZXN0IHRoYXQg
bWtpbWFnZSBmYWlscyB3aGVuIGxvYWQgYWRkcmVzcyBvdmVybGFwIiIiCj4gKwo+ICvCoMKgwqAg
aXRzX2ZuYW1lID0gZml0X3V0aWwubWFrZV9mbmFtZSh1Ym1hbiwgImludmFsaWQuaXRzIikKPiAr
wqDCoMKgIGl0Yl9mbmFtZSA9IGZpdF91dGlsLm1ha2VfZm5hbWUodWJtYW4sICJpbnZhbGlkLml0
YiIpCj4gK8KgwqDCoCBrZXJuZWwgPSBmaXRfdXRpbC5tYWtlX2tlcm5lbCh1Ym1hbiwgJ2tlcm5l
bC5iaW4nLCAna2VybmVsJykKPiArwqDCoMKgIGZkdCA9IGZpdF91dGlsLm1ha2VfZHRiKHVibWFu
LCAnJycKPiArL2R0cy12MS87Cj4gKy8gewo+ICvCoMKgwqAgbW9kZWwgPSAiVGVzdCBGRFQiOwo+
ICvCoMKgwqAgY29tcGF0aWJsZSA9ICJ0ZXN0IjsKPiArfTsKPiArJycnLCAndGVzdCcpCj4gKwo+
ICvCoMKgwqAgIyBXcml0ZSBJVFMgd2l0aCBhbiBpbnZhbGlkIHJlZmVyZW5jZSB0byBhIG5vbmV4
aXN0ZW50IGRlZmF1bHQgY29uZmlnCj4gK8KgwqDCoCBpdHNfdGV4dCA9ICcnJwo+ICsvZHRzLXYx
LzsKPiArCj4gKy8gewo+ICvCoMKgwqAgaW1hZ2VzIHsKPiArwqDCoMKgwqDCoMKgwqAga2VybmVs
QDEgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc2NyaXB0aW9uID0gIlRlc3QgS2VybmVs
IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhID0gL2luY2Jpbi8oImtlcm5lbC5iaW4i
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eXBlID0gImtlcm5lbCI7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYXJjaCA9ICJzYW5kYm94IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBvcyA9ICJsaW51eCI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcHJlc3Npb24gPSAi
bm9uZSI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9hZCA9IDwweDQwMDAwPjsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeSA9IDwweDQwMDAwPjsKPiArwqDCoMKgwqDCoMKgwqAg
fTsKPiArwqDCoMKgwqDCoMKgwqAgZmR0QDEgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
c2NyaXB0aW9uID0gIlRlc3QgRkRUIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhID0g
L2luY2Jpbi8oInRlc3QuZHRiIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHlwZSA9ICJm
bGF0X2R0IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmNoID0gInNhbmRib3giOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9zID0gImxpbnV4IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb21wcmVzc2lvbiA9ICJub25lIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2Fk
ID0gPDB4NDAwMDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5ID0gPDB4NDAwMDA+
Owo+ICvCoMKgwqDCoMKgwqDCoCB9Owo+ICvCoMKgwqAgfTsKPiArCj4gK8KgwqDCoCBjb25maWd1
cmF0aW9ucyB7Cj4gK8KgwqDCoMKgwqDCoMKgIGRlZmF1bHQgPSAiY29uZkAxIjsKPiArwqDCoMKg
wqDCoMKgwqAgY29uZkAxIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZXJuZWwgPSAia2Vy
bmVsQDEiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZkdCA9ICJmZHRAMSI7Cj4gK8KgwqDC
oMKgwqDCoMKgIH07Cj4gK8KgwqDCoCB9Owo+ICt9Owo+ICsnJycKCldoeSBkbyB5b3UgY3JlYXRl
IHRoZSBkdHMgaGVyZT8gCkkgdGhpbmsgaXQgaXMgYmVzdCB0byBzdGF5IGNvbnNpc3RlbnQ6IGNy
ZWF0ZSBhIGR0cyBmaWxlIGFuZCB1c2UgZXhpc3RpbmcKX0RvUmVhZEZpbGVEdGIgYW5kIHRoZSBs
aWtlIGZvciB0aGUgdGVzdC4KCllhbm5pYwoKPiArCj4gK8KgwqDCoCB3aXRoIG9wZW4oaXRzX2Zu
YW1lLCAndycpIGFzIGY6Cj4gK8KgwqDCoMKgwqDCoMKgIGYud3JpdGUoaXRzX3RleHQpCj4gKwo+
ICvCoMKgwqAgbWtpbWFnZSA9IG9zLnBhdGguam9pbih1Ym1hbi5jb25maWcuYnVpbGRfZGlyLCAn
dG9vbHMvbWtpbWFnZScpCj4gK8KgwqDCoCBjbWQgPSBbbWtpbWFnZSwgJy1mJywgaXRzX2ZuYW1l
LCBpdGJfZm5hbWVdCj4gKwo+ICvCoMKgwqAgcmVzdWx0ID0gc3VicHJvY2Vzcy5ydW4oY21kLCBj
YXB0dXJlX291dHB1dD1UcnVlLCB0ZXh0PVRydWUpCj4gKwo+ICvCoMKgwqAgYXNzZXJ0IHJlc3Vs
dC5yZXR1cm5jb2RlICE9IDAsICJta2ltYWdlIHNob3VsZCBmYWlsIGR1ZSB0byBtZW1vcnkKPiBv
dmVybGFwIgo+ICvCoMKgwqAgYXNzZXJ0ICJFcnJvcjogT3ZlcmxhcCBkZXRlY3RlZDoiIGluIHJl
c3VsdC5zdGRlcnIKPiArwqDCoMKgICMgQ2hlY2sgdGhhdCBpdCBpZGVudGlmaWVzIHRoZSBzcGVj
aWZpYyBvdmVybGFwcGluZyBjb21wb25lbnRzCj4gK8KgwqDCoCBhc3NlcnQgImtlcm5lbEAxIiBp
biByZXN1bHQuc3RkZXJyIGFuZCAiZmR0QDEiIGluIHJlc3VsdC5zdGRlcnIK
