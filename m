Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD261C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 18:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C0387E3D;
	Mon, 11 Mar 2024 19:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="pMbm1dx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E03987E3D; Mon, 11 Mar 2024 19:23:12 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015C487F12
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 19:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9800dbbead=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BI11kC016722; Mon, 11 Mar 2024 18:23:07 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wt25w94m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 18:23:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiZvuNDwDfDx6WmTGFfG/WVUaO1amN4u0Ng+u9k2l7O0hMBaR4TkBq+/LnLxL8kXUVS84wMsTBh0VXzRAxO06qGHJB2DgewhJjfS7To7sVW6USEb6/sQiLptjB3IhfUY1paVpekK/VCejYG0EIQlw6iLLlpTqiQzsj+egF/Py+HMzYEwgDivzvuMiv5iX2M1H7We7RwxUcVgcKUPMLtXIGq1W2WYiVgMYhafxfHudSGxEQ40GVYgxYAaNJ35wLFktDDLGurEsZce6Yf7jpJM8CPBEQ8D+YzKzv54pJLZgAKqK8jn0/WK7Fcbhr2sElz7BNITcwjebW9UTcTce4x+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsndnVuV+bR4gA9RmgmwklC34oyBIQqxTQwsrTOlcm8=;
 b=S7TbFVCpFvhQYQQr02rVShFGzCmk6YHfQZrVB0suPxaE90WCGJGOBFfg/QvdUfSWRbnKLTwCaozj1nxNlUYknGkXYJ9/bomsen0mPP7j82CPhlWhxk4gLlNG0zyxf7i9NA2dDJ8tylRgt/O0fXr4k9c99u+0+yfdyUAPBj4yAxFnrxtI6wOwOJ58Vy4YT4+U5LMJugfefE81Tc+AiNPV21GM3k7fhcQsppRmJHUN9AISjqif9gOUk/IG/RkMhbJtv3cCrHmJLkcJkrXsCSqkP5l8vSki/aytOPnzcV1c/4x6Qw+2H1PrGQNxgMAtGXa5JGicunDsInSOnw0VRqLVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsndnVuV+bR4gA9RmgmwklC34oyBIQqxTQwsrTOlcm8=;
 b=pMbm1dx/LlY1c0wq2tIZJOQcuELBiMsehsv8GylIj2Ahl8OLikZbbn2otAVNAQAnpeZ4vhzzUZ/QQOrf/aL/SKbxvc0gftPek7m3qByZh/QdIDqys4k7vkSlMXfNBnijqFFyf3l/Z39xH6vhC7hbPGg9Mr//zoE6wMZz7uP+WWstpJOnl+mAdiR+z8ohoDokjySjfJHG9phRvieo4A5G7Ne9y/psrssuvI4qyqMvk6Tr/9YeJQ2Z/+n43J+AswmMgpPxDtUC6zAxAOZ+96hE1ngSRkT08jdcG+u4YkxA+9dS5BAAkM5doen0QImbUijIH6wUR9+WVb2OS7aH4zRkKA==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PAXPR03MB7715.eurprd03.prod.outlook.com
 (2603:10a6:102:207::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:23:04 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:23:04 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: Sumit Garg <sumit.garg@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Topic: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Index: AQHab2CjKZvPgmo3NEWX73nxw+EzJLEqNlMAgADZo4CAABqOAIAADGmAgAd3mYCAADMxAA==
Date: Mon, 11 Mar 2024 18:23:04 +0000
Message-ID: <87edcg1vcp.fsf@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com> <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
 <87y1av12bg.fsf@epam.com> <0cda2608-856f-4650-92a6-4860a0d7c8b6@linaro.org>
In-Reply-To: <0cda2608-856f-4650-92a6-4860a0d7c8b6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PAXPR03MB7715:EE_
x-ms-office365-filtering-correlation-id: 13d53f59-67e4-4d87-d291-08dc41f84ab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EvBB/wfkU62YBjvryFso9n7MDhTmIpg/DNrwMrYFCRSepKOdbRl01JrDvE2gel7/P9UOekaFGyYqLMD31mYfCOMmUOHTr5ijWOSyVzR8OVysoRQ6DhVWkSSjCMD4h+IGY0bjYnqhQOzvCr3Hn7OI7FtaRdDc73gmT1EApaY0CxP0gjp8A6qOQ2iqYHy8u4xoU2F39saXq3PhALRnfjip9hhM4C8hZ/mfuFIio9iTj/cVCJhEsFwwXl3g8O+1h0bCQvy9ryL5hYErEMD3GS1+Cv/w/ObFN2ejEFyqX4D6lbKRDh4CNpecvX0UM4fHE98TnA4BpTJFC3M82yAWLoQq8BoHK5dkvPQDeyaXlGLDwZy58lhv9K2TVtG/2qmCIk0d2AXFPgCILICpzhIqsMOa+moUWDP0z5A9b+mWwN3RxQ6z9Bh8Qf6BuuTVnaLtfut8IrM6TpA9toAN0ic3LwH9TiP7A53h8F0K8Rq+lW5dpWh3XWojtcyQwGoxWN9eh1GPBNaIzUYR39CXFwED0pc7yoQXxI5fDiuGNux+E3fyREXKJgaZ/rojwHz8Hx4xMGT05hxyjWGbWpTPNsqwbyKu4Eka+BTwHZRnDm2wu6U4gGFGDCYoOQ6WgFgKBr0q8z9hOOlh49wcgXPGidK+idPYTG0/wcAirHu/4j188km6n6I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rgRKMymlFne+SeRJdX+aht4lltD6H1N6RK39taI4FKXm0lgcq8SktIBH2K?=
 =?iso-8859-1?Q?qyck+ic2KEVMpFxPAC9VaK3LzDQJKkmqm8hq6GB4uP9USccSI+M5yWK/S4?=
 =?iso-8859-1?Q?I1OAZOMJI+/YxrFEuDMAlEU7K8b+WKRAJvoOQKm6pvDD43rM8UJrIqeFYC?=
 =?iso-8859-1?Q?a2gDK9fdITDDLpZYPLDUnIF6yjJipHjpO3ClixVzPmY+QR2M0/Uh8D9g3u?=
 =?iso-8859-1?Q?LOv4pUKaeQ98ne2u/vPR1qVq6NkhYWjpEmcOXrqlkrOPFwdNVcIUApnxOB?=
 =?iso-8859-1?Q?P+xyucc4e0fxR2bBstECSiIf3y/PPdAIKYOgYlsEQEJUwwSh+k04Zco9xA?=
 =?iso-8859-1?Q?fkc6CUSAveNchIxHWISDqj662YhvZ8LnA4tkA4zKhXBj9/o+G65qHU2avU?=
 =?iso-8859-1?Q?ogD/Oj41rmjjo+XpEOMWuPBqLOyG9CxxA16381i+r4AiwSZMV5rnSps/zK?=
 =?iso-8859-1?Q?BoN4RtLOjMNsV4d2wR9cexFiPdntygS/QprlqktNOVd+nWZuGtmF7PXACp?=
 =?iso-8859-1?Q?VvYSVc0jYaaZ9XIppfQYKOWItnYAInVeEdqky5DT8dcA3jj2cVX5HC0qWb?=
 =?iso-8859-1?Q?+hFs1fnchbWgXO5nd35RlbGu5MlitJK3KsgICRzk/zU0dJqNngsWc4vBn6?=
 =?iso-8859-1?Q?27AoiKQ581VEi+bk8k0sHfZtYyUzOspn9P2sqxxrSzEEW5Tkh5VCfdW0n6?=
 =?iso-8859-1?Q?hvu+2piOV22MLb0mRxYtXX+TsjyE0eMqEjNyhmlBdJf0ygaUMJR3+7aF7m?=
 =?iso-8859-1?Q?a6Xsy/O1QlDthdo5YrqmcubdVQjkKzuo7BBtNnAZaTYs8Z3iHgpFLQZoyE?=
 =?iso-8859-1?Q?fRKYVGdN13yoPF8uMJwohNh3nwxHMGKmXIJMxy2UJXsq1sAdEwMIIaFztN?=
 =?iso-8859-1?Q?DwcauJAXOMxBA9ZuWgXM80qtLPQ31YviVVX17KDzjaw73ryDyQicaAwWfT?=
 =?iso-8859-1?Q?Gk9p6eUAenl+fhGKUKzgV9RnShBFdInTuwajzqsMgpw6n4nmzebUQlwcXm?=
 =?iso-8859-1?Q?3A5ENRLhQZdwE7RE+gH9ZWdMyInhwB1Nwc9/lvslZJH+pCbCVn4zxFpDHY?=
 =?iso-8859-1?Q?Q1fxM7FzkGO0n/Q0Ze0xs7Hp6kmUyv25OhwlqBOGb3InLGhv/HC7mM5LWE?=
 =?iso-8859-1?Q?eZU1g6yKsVabB7g70T3M1Hw9chGRpg8/x7J/yHqSCuVqEZglhe1If3i5nw?=
 =?iso-8859-1?Q?dqkbYgx5fsJg+y6UEarlmDdo/a1ZPtAAmS56FfGE796uVODnng8u6jzLNt?=
 =?iso-8859-1?Q?WVtgU6Izy5OEA0qgTbbO0rDgYJ4RBF6wvv8DsRR73rc4GVzyRCoiB+sbDM?=
 =?iso-8859-1?Q?TfKYcOSh+7uHEbb2G531vOLCNHMEOm9+m6hbCKaKlL2wXoFKy7xX8aiOql?=
 =?iso-8859-1?Q?o4/73HjBsbCVX4bD1MliaK0z3f5LROTlaAeEDK0BJVqTn927maJhWddLYB?=
 =?iso-8859-1?Q?U7/aK9LuT3UfqEldjY3gOSWfVWZEPivfYOaQpowPX/qAwRUcxXJwV/nmMI?=
 =?iso-8859-1?Q?dgkbHJUQ9ifBCUlvPHcAL5iTROZ5EBH3aBk8YlyvHETEM70aihtvfuijdC?=
 =?iso-8859-1?Q?oWPR9/mGVlh33h4AugOTSr5gcf/MAoaw8BSrul8hTxliD6AvbN0W+D91Au?=
 =?iso-8859-1?Q?KcUoPn08UWA35cbPByVYjUVGo0EtN/wthC74HNr/Nh265He7RYaetlrg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d53f59-67e4-4d87-d291-08dc41f84ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 18:23:04.0592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6uSINa4PMppT3YeR9dwQLHw0SQX1F7a24gvqH3QW7ydViuBjz0lDS2JXwRS0MMfWhqDMpss1B6uBsMVD2xGAT0bngeyBM7vmEmCuDKR81M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7715
X-Proofpoint-GUID: XFlkC1mysXitiq1NbvuGr4UEnnmg1p20
X-Proofpoint-ORIG-GUID: XFlkC1mysXitiq1NbvuGr4UEnnmg1p20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=956 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110140
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


Hi Caleb,

Caleb Connolly <caleb.connolly@linaro.org> writes:

> On 06/03/2024 21:24, Volodymyr Babchuk wrote:
>>=20
>> Hi Caleb,
>>=20
>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>=20
>> [...]
>>>>>> +};
>>>>>> +
>>>>>> +&tlmm {
>>>>>> +       /* U-Boot pinctrl driver does not understand multiple tiles =
*/
>>>>>> +       reg =3D <0x0 0x03000000 0x0 0x1000000>;
>>>>>> +       /delete-property/ reg-names;
>>>>>
>>>>> This won't be needed if we can make the tiles offset in the pinctrl
>>>>> driver compatible:
>>>>>
>>>>> #define WEST   0x00000000
>>>>> #define EAST   0x00400000
>>>>> #define NORTH  0x00800000
>>>>> #define SOUTH  0x00C00000
>>>>
>>>> Hmm, I assume that in this case pinctrl driver should map all the four
>>>> tiles independently? Are there guarantees in U-Boot that four separate
>>>> memory regions will be mapped into virtual memory with the same relati=
ve
>>>> positions? Linux clearly don't make such guarantees.
>>>
>>> U-Boot doesn't use virtual addresses on arm platforms, it only goes as
>>> far as reading the address from DT, nothing else, so this is totally
>>> fine and is how the other SoCs do it.
>>=20
>> For me it looks like we are depending on implementation details
>> knowledge. I.e MMU API does not provide such guarantees, but drivers
>> know how ARM MMU code is working internally and drivers depend on
>> exactly this behavior. But if you are saying that it is totally fine,
>> I'll rework the patch. No big deal. Actually, I already tried this and
>> it is working fine.
>>=20
>>>>>> +
>>>>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>>>>>> +       /delete-node/ phy-reset-pins;
>>>>>
>>>>> I suppose this is not needed as phy-reset-pins also configures the pi=
n
>>>>> as GPIO only.
>>>>>
>>>> Well, yes. This also puzzles me up, but for some reason it stops worki=
ng
>>>> if I leave this node intact. Looks like I need to look at this deeper
>>>> before posting the next version.
>>>
>>> Possibly the pinconf defined in the phy-reset-pins node causes U-Boot t=
o
>>> misbehave, can you check if this patch fixes it (there is a bug in the
>>> line "return msm_gpio_direction_input(dev, gpio);", it should become
>>> just "msm_gpio_direction_input(dev, gpio);").
>>>
>>> I had the exact same issue with the gpio-regulator driver and this was
>>> the solution I ended up going with.
>>>
>>> https://urldefense.com/v3/__https://lore.kernel.org/u-boot/20240131-b4-=
qcom-livetree-v1-7-4071c0787db0@linaro.org/__;!!GF_29dbcQIUBPA!xFhZe7DKgRbr=
63sirEJLuH-B0AnGs7jvx8tdJPKLTgFuZ3I3_zpVml7l23G-_vJO_JiUR-wUO4GMPJFcE-8p50H=
3pf7nbxit$
>>> [lore[.]kernel[.]org]
>>=20
>> It is exactly this. With your patch I don't need to /delete-node/
>> anymore. I'll add a comment in the cover message that this series are
>> depended on your patch.
>
> Please can you split the power domain and clock patches into a separate
> series? As I'd like to depend on them for the next revision of my
> series, and we'd otherwise have a cyclical dependency.

Of course.

As I understood, you are interested in "clk: qcom: clear div mask before
assigning a new divider" and "clk: qcom: add support for power domains
uclass", correct?


--=20
WBR, Volodymyr=
