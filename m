Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C48D29DE8
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A3E883678;
	Tue, 13 Jan 2026 09:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="g4pEofVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D856836C8; Tue, 13 Jan 2026 08:13:04 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B59083693
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoxMZE/hbHExBZrtAEXOb6aJg3t6oBDzkxTmvpLURAFP83MYXforUYz4RkwPfpDAGXVk1HsCrR4dD0w1jsSrvMygFIlGDJSq0k38Nk8/3LY+UUoBWwNnMpls9aS1aT5oVbup6+BRZ0N1q0EBwzkqZ1auen5fkQKW3sGlb9U7Xkqbog+a4A0PWpSIv9c06jC5UeW2lGd9RPIsQgYfiWF5OuwGersj569ZFNDMO+ztlIT+KIkQ/Z+npqKQ8jY5GvelyExrDwnKbiygCE40nEyYJ66TYFE/DDIR5Ep5CrvnjLioRLcMB0UAcx8YibV8rcix2QgeMgA2wN85saDz8+/54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c675xAXfIhhPe2/WKCxb1cmwjBhFmp9NHS9B9teo+KA=;
 b=b0kaN+4SLdky0yGSgNuV7D/4ptWpgJrbT+6QFarxzpKwA82udQKp125iXigv4GKY210jgV8OgQhb9szdXgTUovbj4dL6AzDWi6S5t3nz2Mnwu0sJt7Af0ixcfahJMxxxS6Xi5v+ftXBWIKpk7WzcCgSHF1cJCc3bg3XVDjrUt+fY2IWDfkwwIT8YnQmf4TqJVZV7OMWLT5uzs3QSNfL3hafS2YkWcotLP9mtcp+XipWaqtF9CPqQuBuviZ6AxUt8uy1TqfTIkZymM/YxeS1JTvKiJFC4fzuRJbAI5aH5g/wLLThZxv6aHV91nVYvCBWTMVpj8M1+pPMyzFr8nMgngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c675xAXfIhhPe2/WKCxb1cmwjBhFmp9NHS9B9teo+KA=;
 b=g4pEofVY8d+DkPcdse8V+bdJH0bQdvy2Uw18MOj8CyJ9I7QNy1l9xcnTxJAMYYz+4VRzTGF/pYWyzmGdoUfqy249rABWud6KulMoGR3F24Y+nDbYHaVtXFzwY/UjJZ+bCMZ2ffMtcRWF1v0ZzENSrzhPU+f+IsvJ+PYsLCmoE7RgUuHU0KFFcSIxLC2VeO+FcIc7ATIjo5SLpMhEJ97xqHMPhV6Mn5dAa1oPkuIbFf9u/eRFc1oZ9bAmqHwIpGV/kXtpGOIJeRzxDnsoGCZJZqKBy5AF5LCN1WxruSA5Yp661lx3+LvMCixfaYbKaGdZi4SDaIIZCKpDvl+pPhOo5w==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA1PR09MB7769.eurprd09.prod.outlook.com (2603:10a6:102:448::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:12:59 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 07:12:59 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Yao Zi <ziyao@disroot.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 01/10] riscv: Add initial support for P8700 SoC
Thread-Topic: [PATCH v4 01/10] riscv: Add initial support for P8700 SoC
Thread-Index: AQHcEPR0OVXUOWJ+aE6VeDlqxFyBo7S564AAgJaqr4A=
Date: Tue, 13 Jan 2026 07:12:59 +0000
Message-ID: <2ff2fed1-da9c-46d9-94ca-d85f53cd8505@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
 <20250819103021.1518687-2-uros.stajic@htecgroup.com> <aOeNDPxxdq6oZ6wt@pie>
In-Reply-To: <aOeNDPxxdq6oZ6wt@pie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA1PR09MB7769:EE_
x-ms-office365-filtering-correlation-id: 2ef03e9e-19b0-435a-5683-08de52732f00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?THRnbDlOcUZVbHpmaDRxRzlLYi9KUzR6aUlXSVQ5ZEh6cmJnSmd3Wi9qVlV3?=
 =?utf-8?B?S0JxWTc3S1RURGhOWTA3T1VxRlVqRWhGRkpJaHZ4a2dhaVRhRmM1eXlHaGpC?=
 =?utf-8?B?eHE5WGh0T2FnZVFVaTMyR2xtcHBiTWZsM3NtVDJLWi9WNTlyS05WZk41Nm1T?=
 =?utf-8?B?eXh3bmVWc21la1VMdXY3cUZmZXB5WjdrbGw1a2prUk9NOTQ5MnI4NjNNSVdO?=
 =?utf-8?B?MEs5c3JZOWZBQUQwSXk3UjRjVnpjSVo0L1Q0MVltVXY3TVJUNW00NWpTWkZ0?=
 =?utf-8?B?VHFjOGR0MlBDbjlsVjJuemZOSmF4dGxUQkxaRXNxSlNXS3VSVC9XYk9vQTlK?=
 =?utf-8?B?cU9lWWE4QU5TSDJUUkJnVTNwV05ab05rcDZhNjZFM2F6NFcwWFZlY2lnTnkv?=
 =?utf-8?B?S29mM1cxNHl0SnZoV1Q4WjFGTUtNMXBGZWNEd09BbVltWS9KV3BMR2YzaGlI?=
 =?utf-8?B?MC9RL3ZGSnFxdkg5MDc5eEIxN2pGMEdoZTNXZEpCK3MzckhNeHo5WFgwV0FG?=
 =?utf-8?B?Umpkd3NScEhFbFEybndpOEdpY2hPbGxXbUtUcW56dzZkNjJwRy95ZlpoOW5k?=
 =?utf-8?B?Um0wUTU5SlVvVVpUY1RiaUkwZ0pVNUl2SmJnS1BsTXZHejRMMW9qbzRrZjd6?=
 =?utf-8?B?WVBPdGEreUxTNklLbHlmbVBmSW9RZzhteUxFL2pTYjlXYi9XcFVGYkFmQW1a?=
 =?utf-8?B?M2pEZnNMRDVZTWwzRlFFZHE0bm03UUwxeWE2Vi9rQnA0eUw1a0VjVEFOdlMr?=
 =?utf-8?B?RDU1TUNiT0lncTVHTXdqbnhhOTRndXB6bUg4dFgrSFVBWmFleE84Qlg0OE1m?=
 =?utf-8?B?dncvTytCM2F0dWthOSs4YXJrOEdQNmFPNUEzdm9YUGJmRVJLSmVxbnQ0eEhN?=
 =?utf-8?B?MEtoaEg3VWJkeUNGU1hMbEZJTmFGUm93SGNJaERybFoxY215ZVEzSUtRdU1t?=
 =?utf-8?B?MmdqcXlhOTZad3d2NXRDR0oxbURyUDV1U3ZyMEhoUkhIZHdDdnRNQUp0THBv?=
 =?utf-8?B?a1JYakJCZWdyaSs5R1NLWXhoSGQyZEY1YzRTdFRxK3FDZWpaMzBpNWRJMWlE?=
 =?utf-8?B?RGlJME1oNlRVQ3paNXh4eGJXTFhvdVlJTjVzb3paTzVoTVZMWnhNQnorUlYx?=
 =?utf-8?B?NHY4dlNpdHplZllMVElNZER0blFBUEJNOW90Vy96QjdKWlJLdE1DcEdGVXdp?=
 =?utf-8?B?a3U3SDdDKzdjMHRhcjdJRkJVUm1HK0NSRU9RbzVMTkJYY05HYTdKeEpodmxV?=
 =?utf-8?B?VjBkZ0dDY05sckZyd0VoWDl4aEFrY3hJcDZ5MU9sdTNTZTZycHg4cGZNbEow?=
 =?utf-8?B?M3NtR3M4NWFQa1cvN3hOa1RjeEt6ViswTUxwZnNOY2dlU1ZCK0kyN2xZN015?=
 =?utf-8?B?aGRwZStYb0N6MXgwYzliWWlMNG1mdEhxZDN0bjBuaS9BS1dIMVgwS3pCaEtm?=
 =?utf-8?B?QnJxL1dPTFAvTStqclhJOWhwWWdwY1g3RE56MVUya3ZCWjFjVk5rYm4wMHJW?=
 =?utf-8?B?cmQvQklnRzg0QSttMnZFUDBKZ2UvRDlMODJncWUwN0F4L2xaam9qd00wT2Qy?=
 =?utf-8?B?YWE3eVBDdUptT0c0VkV5M2QwQmQ3bnhQWmgvQnFzN1d3NStETDVwWHlHZFFG?=
 =?utf-8?B?cHdWZDJrMFJINDc5bllXeERTak9odzJWb29zS2lNNjdpTjl5YmZPcTJHWkR1?=
 =?utf-8?B?WnpYNGRKNXBlZGdwVU9OSExTZTBCMkQvekdQQ2sydHE4QnlOZmRudmhURHJ4?=
 =?utf-8?B?dS9waWRBelRJbnlqR2ZuZ01Vb1RPNVV2N21Ma3FtRGtPUGl0VGg5QnFpMVQ3?=
 =?utf-8?B?MzN3dmZwUmZEZkE1eFBFYlFBV1ZCQ2l1YTVrMlBscmU4ZTRQYUo3QjF5VVdS?=
 =?utf-8?B?dWVNQkhPSHlIeUM4YW5xSWlzSEFZKzVOM0d6RVpIZE92cUFMYUNQY2l0a1NI?=
 =?utf-8?B?L0hJQUVJQXN3TFNLcE9YSng4Q2NnRE1XY0FIVGNXcGkvcE4wTUlDa1RkS2l2?=
 =?utf-8?B?N0JuK3M3dDVSM0VYLzB1L0k2WlRLbXYyUC8vVUxob0h3MVN4MVVLcVUxcThh?=
 =?utf-8?Q?R1OEha?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1crekYrZ1Y4VjFYLzl1S2l3ejFiRSt5ZVY1MEFod05ja040Um10UW5kV0Yx?=
 =?utf-8?B?SS9NYUhjZVM5M3N3UENGVzlWcmk2Nis0VEdodmk0Z0N1aExmdG1Ub2gxYy9h?=
 =?utf-8?B?MjM5OURyaHhLYlZwSmNRUmlJc0kxVEhkM01tSkoydVczcWhxUkNTVkRyNm5O?=
 =?utf-8?B?NDJndUFBd1BkU3BTK1UxaHJrYzVqdG12UVo4Vy92MDlPOW1ZWndUUllPb0pG?=
 =?utf-8?B?TzFhNEo5YUx4d0JJL2I1R3lEZnlwc3o5MEFtM1BnZXg0cGo1Qm1jWTBTVE1i?=
 =?utf-8?B?WTVZcno5NGwvUmlMUHRSNjNEeHhka0hSWWNRVGdWRnJ2dk9nUE9XbFB4MlVR?=
 =?utf-8?B?NGZlSU5BdXYwTjhWNlpXdHNiSzd5M2xuWTlkQ0dFbnlrcm91aXd0TGpMT1Er?=
 =?utf-8?B?aGVNWWl1UEc4U29xSDdETnJRWncyclRPMTcxMEJidjdGVVN2NFhSNWtHbGhk?=
 =?utf-8?B?V1E1N0pLK2ZQUWt1VGRJSTdqZmJSSXQ5dHVXbnZJUmRUd3NNbGtmV3ZPUnNm?=
 =?utf-8?B?eE5PUVZOdEtiRFVMQkpXRzJZOEV0TEw2M3o4K0dsOXRUTUhjOGcyV3lJREpV?=
 =?utf-8?B?WFozcFV5TUYvTzRCUXJrb3crSWJDNkdqODZhV3hYZU9HdUVkQUZLUGZ1ZktV?=
 =?utf-8?B?VTlUSFI1NEYxY09yUjQvRnFLR2pPWWIwek0rbEdkU0dHT2EwQllyc2hTcmRL?=
 =?utf-8?B?ZlgzQ3NPaEpJU1hBN1EwclFlV2h2STMzUzlrbXlnSms5b3Q1Qmd6TWtncEFx?=
 =?utf-8?B?dUx1MmxkVndrS0dreDd1WWhTZFhZbnhiS2JOS2p3eFFKY1pYdGdyUTFtTDkv?=
 =?utf-8?B?MzZJWURxaHRhSHUwVWxEbVdhMUIxVkEvNndzYklLUVFQOTlrN2owb2ZQVW1F?=
 =?utf-8?B?cHphWnFUR3BwMmtBOC9rV1lPQTZtV3M1NVUvSmNWZFBCc1JRSW03cHoyVXZR?=
 =?utf-8?B?OUxTNGtvRkdzajlFWlJTeElkcnBleW5YejRDKythekZaMUpJdDdNZ080d2VP?=
 =?utf-8?B?OVFxSHVEN2ZMd1VEL2hwL1RUV0prTktPZTZkc0w3allDZ3RxRWxnS1dqSERT?=
 =?utf-8?B?RkFzYklnUmNndkNpZEZIT0pBeG52bWxXbUkzM3M0ZncvaXdjKzl3SWFMRzR6?=
 =?utf-8?B?SGNGYXcvZmFnNVNndnBRT000MC81N3dBOVhLcjNDN1VzTEhsT0RTQnc0bVRU?=
 =?utf-8?B?TFhKOExCdGpPMGZxQWNMSVM3NUxNZlYvVGhaR1JKWUMxWjZsQmlCZlpuazJp?=
 =?utf-8?B?anp1a3NNazNxdk94amZMS3RheHp3d2pzaGV5RWlsU0RPdkU1Ym9jWlZMcWJ2?=
 =?utf-8?B?aTNaQzRQYnBrNFhqR2NSRVRLRGZPM0lUbjFkcStZbHNla1ZxL2gxWXdtcDFX?=
 =?utf-8?B?WmJqaU5SYm5kbloxRTI4OW1VRTRsMUNLVzhLWGlMSDJUdnN2RnUvMUViM2or?=
 =?utf-8?B?SmJSRStoSlBSekxzbjZDemI3eEo0WlgyaDR2WVUyUVNlSUpMYU1QelBUWVRC?=
 =?utf-8?B?aS9Td0ZrTE5GaGNwWVpqcHpOS0dVVUl5Y3EyUmFWLzFLV3VmRTJxQUxnN1gv?=
 =?utf-8?B?N1JVWW01cERScjFzSnF0Q3R4NkhKOUhMOUdXWnpMTVJYaDJPdk1XcjZlYW1N?=
 =?utf-8?B?L1FscS9SbjJabzdnRFJGa1JmU1NKV0RIMUFTT0lQWjU4a0poY3B6Z2Q1Ylla?=
 =?utf-8?B?SVZVQVo4NEVjaTRtZzl5Q0ROV3RRTjdjWEtsRFJTSDNia0xoS0ZWb3ViNGJv?=
 =?utf-8?B?MEgyVkdNOTk1TGozdDUrUFlhV2E1NUcxZUwzbm43Z1FGbEJnbDJML2lDZmhZ?=
 =?utf-8?B?T0QyOWZvYmlUa1dZREZGT1NuNEV5Q0ZCYW40RlpPZHNSdWJkcksxNVQ1R3lx?=
 =?utf-8?B?UWU4QmU1QVlPd1lQMXlIcTMwdWkyTktRZUtITHdIYTlsZ0pxekM3NjE1NGpT?=
 =?utf-8?B?bmU1a2UzWjVnT3VLUy9OYlhsSy85TGRJRzJmMEdaS0V2TkRYSVhTdGI2TjVJ?=
 =?utf-8?B?MkVZbkR3VHhVSnYrM08rSkpVZkRZNjMzL2hGaDZDeTNqOFF1a3I4UVcyaWZS?=
 =?utf-8?B?MzlCcGRYaXVGb1FlRktnbWxzVVBNZnczdmREWVBHVEVacFJkVkQ5NEFWaWhk?=
 =?utf-8?B?bnkyNTdONkZJL3RLaGkyY1hNRE92dDg5MmZNNFRvM2pVUWFLMlBScW11NnI1?=
 =?utf-8?B?Sm5leXA5U1VDcGhLVi81bUM0cTBKeWJCNkRXWFBVOE1zNXRONEd4Z1VMeEo4?=
 =?utf-8?B?ajVWeFZmcUhvQW1VUzZzcnlNTGFWaXpQTmxrZGJ5Y1hkV0s1WUJ4YnNwaEpN?=
 =?utf-8?B?Nml3NDkrTmk1SmkvZ3ZsSzV0eEJSUjAwb01TdTJpYmVGKzVMTWZLUzNXVVZv?=
 =?utf-8?Q?xZHFt5BdVqD3niso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73D08B525C03CA458CACD170D80E10AA@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef03e9e-19b0-435a-5683-08de52732f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 07:12:59.5461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeJvZw8JVUFSfYPH3nk2MjKk7iJh7watC5CX985KjuKoBW5X3bSCpUOYPRw+jU25xqpnSa+rmcLPMDuXDIzsrLLC3DN3SffeCdruD8tAm1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7769
X-Mailman-Approved-At: Tue, 13 Jan 2026 09:42:06 +0100
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

DQoNCk9uIDkuIDEwLiAyNS4gMTI6MjMsIFlhbyBaaSB3cm90ZToNCj4gQ0FVVElPTjogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gVHVlLCBB
dWcgMTksIDIwMjUgYXQgMTA6MzE6NDJBTSArMDAwMCwgVXJvcyBTdGFqaWMgd3JvdGU6DQo+PiBG
cm9tOiBDaGFvLXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4NCj4+DQo+PiBBZGQgaW5pdGlhbCBwbGF0
Zm9ybSBzdXBwb3J0IGZvciB0aGUgUDg3MDAtRiwgYSBoaWdoLXBlcmZvcm1hbmNlDQo+PiBtdWx0
aS1jb3JlIFJWNjRHQyBTb0Mgd2l0aCBvcHRpb25hbCBtdWx0aS1jbHVzdGVyIGNvbmZpZ3VyYXRp
b24gYW5kDQo+PiBoYXJkd2FyZSBtdWx0aXRocmVhZGluZy4NCj4+DQo+PiBUaGlzIHBhdGNoIGlu
dHJvZHVjZXMgdGhlIGluaXRpYWwgcGxhdGZvcm0gY29kZSBuZWNlc3NhcnkgdG8gc3VwcG9ydA0K
Pj4gdGhlIFA4NzAwIENQVSBpbiBVLUJvb3QuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhby15
aW5nIEZ1IDxjZnVAbWlwcy5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBVcm9zIFN0YWppYyA8dXJv
cy5zdGFqaWNAaHRlY2dyb3VwLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL3Jpc2N2L0tjb25maWcg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICAgYXJjaC9yaXNjdi9jcHUvcDg3
MDAvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAxNCArKw0KPj4gICBhcmNoL3Jpc2N2L2NwdS9w
ODcwMC9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICA5ICsrDQo+PiAgIGFyY2gvcmlzY3YvY3B1
L3A4NzAwL2NhY2hlLmMgICAgICAgICAgICAgICAgfCAgOTMgKysrKysrKysrKysNCj4+ICAgYXJj
aC9yaXNjdi9jcHUvcDg3MDAvY3B1LmMgICAgICAgICAgICAgICAgICB8ICAxMyArKw0KPj4gICBh
cmNoL3Jpc2N2L2NwdS9wODcwMC9kcmFtLmMgICAgICAgICAgICAgICAgIHwgIDM3ICsrKysrDQo+
PiAgIGFyY2gvcmlzY3YvY3B1L3A4NzAwL3A4NzAwX3BsYXRmb3JtX3NldHVwLlMgfCAxNjkgKysr
KysrKysrKysrKysrKysrKysNCj4+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLXA4NzAw
L3A4NzAwLmggICB8IDExMCArKysrKysrKysrKysrDQo+PiAgIDggZmlsZXMgY2hhbmdlZCwgNDQ2
IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvY3B1L3A4
NzAwL0tjb25maWcNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvY3B1L3A4NzAw
L01ha2VmaWxlDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2NwdS9wODcwMC9j
YWNoZS5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2NwdS9wODcwMC9jcHUu
Yw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9jcHUvcDg3MDAvZHJhbS5jDQo+
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2NwdS9wODcwMC9wODcwMF9wbGF0Zm9y
bV9zZXR1cC5TDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2FyY2gtcDg3MDAvcDg3MDAuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25m
aWcgYi9hcmNoL3Jpc2N2L0tjb25maWcNCj4+IGluZGV4IDA0ZWIwZTZmMjNjLi40ZWFmMGUzZGI3
MSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3YvS2NvbmZpZw0KPj4gKysrIGIvYXJjaC9yaXNj
di9LY29uZmlnDQo+PiBAQCAtMTMxLDYgKzEzMSw3IEBAIHNvdXJjZSAiYXJjaC9yaXNjdi9jcHUv
amg3MTEwL0tjb25maWciDQo+PiAgIHNvdXJjZSAiYXJjaC9yaXNjdi9jcHUvazEvS2NvbmZpZyIN
Cj4+ICAgc291cmNlICJhcmNoL3Jpc2N2L2NwdS9rMjMwL0tjb25maWciDQo+PiAgIHNvdXJjZSAi
YXJjaC9yaXNjdi9jcHUvdGgxNTIwL0tjb25maWciDQo+PiArc291cmNlICJhcmNoL3Jpc2N2L2Nw
dS9wODcwMC9LY29uZmlnIg0KPj4NCj4+ICAgIyBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgb3B0aW9u
cyBiZWxvdw0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2NwdS9wODcwMC9LY29uZmln
IGIvYXJjaC9yaXNjdi9jcHUvcDg3MDAvS2NvbmZpZw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+IGluZGV4IDAwMDAwMDAwMDAwLi43MDIzNTc1YTZiZQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4g
KysrIGIvYXJjaC9yaXNjdi9jcHUvcDg3MDAvS2NvbmZpZw0KPj4gQEAgLTAsMCArMSwxNCBAQA0K
Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+PiArIw0KPj4gKyMgQ29w
eXJpZ2h0IChDKSAyMDIxLCBDaGFvLXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4NCj4+ICsNCj4+ICtj
b25maWcgUDg3MDBfUklTQ1YNCj4+ICsgICAgIGJvb2wNCj4+ICsgICAgIHNlbGVjdCBBUkNIX0VB
UkxZX0lOSVRfUg0KPj4gKyAgICAgaW1wbHkgQ1BVDQo+PiArICAgICBpbXBseSBDUFVfUklTQ1YN
Cj4+ICsgICAgIGltcGx5IFNJRklWRV9DTElOVCBpZiAoUklTQ1ZfTU1PREUgfHwgU1BMX1JJU0NW
X01NT0RFKQ0KPiANCj4gU0lGSVZFX0NMSU5UIGhhcyBiZWVuIHJlbmFtZWQgYXMgUklTQ1ZfQUNM
SU5UIGJhY2sgdG8gMjAyMywgYW5kIGluDQo+IFBBVENIIDIgeW91IGNoYW5nZSBTSUZJVkVfQ0xJ
TlQgdG8gUklTQ1ZfQUNMSU5ULiBJIHRoaW5rIHlvdSBzaG91bGQNCj4gc3F1YXNoIHRoZSBjaGFu
Z2UgaW50byBQQVRDSCAxLg0KPiANCj4+ICsgICAgIGltcGx5IENNRF9DUFUNCj4+ICsgICAgIGlt
cGx5IFNQTF9DUFVfU1VQUE9SVA0KPj4gKyAgICAgaW1wbHkgU1BMX09QRU5TQkkNCj4+ICsgICAg
IGltcGx5IFNQTF9MT0FEX0ZJVA0KPiANCj4gLi4uDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3YvY3B1L3A4NzAwL3A4NzAwX3BsYXRmb3JtX3NldHVwLlMgYi9hcmNoL3Jpc2N2L2NwdS9w
ODcwMC9wODcwMF9wbGF0Zm9ybV9zZXR1cC5TDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4g
aW5kZXggMDAwMDAwMDAwMDAuLjdjNDQ3NWEwM2RkDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi9hcmNoL3Jpc2N2L2NwdS9wODcwMC9wODcwMF9wbGF0Zm9ybV9zZXR1cC5TDQo+IA0KPiBDb3Vs
ZCB0aGlzIGZpbGUgYmUgY29udmVydGVkIHRvIEMgbGFuZ3VhZ2U/IFRoZW4gaXQnbGwgYmUgZWFz
aWVyIHRvDQo+IG1haW50YWluLiBJIHRoaW5rIG5vdGhpbmcgcHJldmVudHMgdGhpcyBpZiB5b3Ug
Y291bGQgcHV0IHRoZQ0KPiBpbml0aWFsaXphdGlvbiBvZmYgdW50aWwgaGFydHNfZWFybHlfaW5p
dCgpLg0KPiANCj4gRnV0aGVybW9yZSBJIGRvbid0IHNlZSB0aGlzIGZpbGUgaXMgaW5jbHVkZWQg
aW4gYW55IG9mIHlvdXIgTWFrZWZpbGUsDQo+IHdoaWNoIGlzIHN1c3BpY2lvdXMuDQo+IA0KPiAu
Li4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLXA4NzAw
L3A4NzAwLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2FyY2gtcDg3MDAvcDg3MDAuaA0KPj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwLi41Y2E5YjRiOTQ5Nw0K
Pj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLXA4
NzAwL3A4NzAwLmgNCj4+IEBAIC0wLDAgKzEsMTEwIEBADQo+PiArLyogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4+ICsvKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyMSwg
Q2hhby15aW5nIEZ1IDxjZnVAbWlwcy5jb20+DQo+PiArICovDQo+PiArDQo+PiArI2lmbmRlZiBf
X1A4NzAwX0hfXw0KPj4gKyNkZWZpbmUgX19QODcwMF9IX18NCj4+ICsNCj4+ICsjZGVmaW5lIENT
Ul9NSVBTQ09ORklHNyAgICAgICAgICAgICAgMHg3ZDcNCj4+ICsjZGVmaW5lIENTUl9QTUFDRkcw
ICAgICAgICAgICAgICAgICAgMHg3ZTANCj4+ICsNCj4+ICsjZGVmaW5lIE1IQVJUSURfSEFSVF9T
SElGVCAgIDANCj4+ICsjZGVmaW5lIE1IQVJUSURfSEFSVF9NQVNLICAgIDB4Zg0KPj4gKyNkZWZp
bmUgTUhBUlRJRF9DT1JFX1NISUZUICAgNA0KPj4gKyNkZWZpbmUgTUhBUlRJRF9DT1JFX01BU0sg
ICAgMHhmZg0KPj4gKyNkZWZpbmUgTUhBUlRJRF9DTFVTVEVSX1NISUZUICAgICAgICAxNg0KPj4g
KyNkZWZpbmUgTUhBUlRJRF9DTFVTVEVSX01BU0sgMHhmDQo+PiArDQo+PiArI2RlZmluZSBNQVJD
SElEX1VBUkNIX1NISUZUICAwDQo+PiArI2RlZmluZSBNQVJDSElEX1VBUkNIX01BU0sgICAweGZm
DQo+PiArI2RlZmluZSBNQVJDSElEX0NMQVNTX1NISUZUICA4DQo+PiArI2RlZmluZSBNQVJDSElE
X0NMQVNTX01BU0sgICAweGZmDQo+IA0KPiBJZiB5b3UgY29udmVydCBwODcwMF9wbGF0Zm9ybV9z
ZXR1cC5TIHRvIGEgQyBmaWxlLCB0aGVzZSBtYWNyb3MgY291bGQgYmUNCj4gc2ltcGxpZmllZCB3
aXRoIEdFTk1BU0soKSBhbmQgRklFTERfR0VUL1BVVCgpLg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBZYW8gWmkNCg0KSGkgWWFvIFppLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgYW5kIHN1
Z2dlc3Rpb25zISBUaGUgY29kZSBmcm9tIA0KcDg3MDBfcGxhdGZvcm1fc2V0dXAuUyBoYXMgYmVl
biBtb3ZlZCBpbnRvIGEgQyBpbXBsZW1lbnRhdGlvbiBpbiB0aGUgDQpuZXdlciByZXZpc2lvbiBh
bmQgdGhlIGluaXRpYWxpemF0aW9uIGlzIG5vdyBoYW5kbGVkIGZyb20gDQpoYXJ0c19lYXJseV9p
bml0KCkuDQoNCkJlc3QgcmVnYXJkcywNClVyb3MNCg==
