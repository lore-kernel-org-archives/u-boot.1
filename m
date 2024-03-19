Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25590C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 21:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8501E88010;
	Tue, 19 Mar 2024 22:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="ZoJQ2lJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E43F88079; Tue, 19 Mar 2024 22:19:02 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9490B87DC8
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=98084f4c34=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42JFBiwV032070; Tue, 19 Mar 2024 21:18:54 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wy9b89xs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Mar 2024 21:18:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOeyd28AE9lq/ipJG/0JiNmkbvI0cL+qyQxXzMf3RjW92npCx8FSV0J4nVaNqlwmCNCkowoYLMQ3xsmvRzuvEYL2+3m47u0owX9sh6x4UUtJdvel++QHFJvolSg8c5k6cxltLkwiMJ6Qgd6oa5qN817Y/ksnvNdbZYOtAOrNGeodMPyP71KlEh6FaEVweBA2artNedJWrv4+QyHwO0DqSfWEJMbcXg56lS2gJ4U9N3cr1RFREvzd4YMRW3poSbzyEnks6A88L7FIqL/ckjQFC14THwpqqwSTPVpAB/rvxv/z0xTCYGNtUkDZxx/cfANxNjH71Yik5xnC6j3E0rs/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu7/ce3/rJHGrStN9AQGlWql63+1EOLh0K6ppuHnnJk=;
 b=G6rjuC+AxZ6GU8z6stSHodYvWl8PbDUQXPhNYodWxMuZyB6KAPeK1yYAUAuGQzSEyYjM8RXZn9Z8rmqhGd9dXxzeHwIShEAdOGfUrYWWNIy+04ZhuzqZAcxCGXw1wJRNRhiEwaDi/5w80WMypjEcq5FjAGT1Y5WthrLu5AeglYQtRiWFjwVAhErE2nwkUlUZ/aRmZ9sfkGrnsKNZosdjq+v0bsxIrHY42J2Hmrlatlqmoj2Dv8YD3WVyVw8/9ae1XpYI/A+BvMD+hZZMx3H7SngZ/n8tItrtEVKUQJookeucq5fxGL6qDQHl+u/XqlL+aB2dUc+Yy+MYFRDAtcz2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu7/ce3/rJHGrStN9AQGlWql63+1EOLh0K6ppuHnnJk=;
 b=ZoJQ2lJ2talqd7ow3MD7xG8IEiBbekCsQhtd2AXxkedy7IJuuuMr57eZtrOPVVQOgCGasVbkfVc90ZO4dFl7Je3F8ANZ4xkWHl0egDRDjGkxSzmPwqUpgeXvtGyDHBBNg2xOxX5CX2aL9FV3WCxbKDaxhm2aOTlW7pkXc8QC2ovwxqMoANTFtW2yDxJ7Enw4HBzfaJ/JQffllLrpfb+PGbsOprkFVJVqZUBMq1bBgHkw9A3/yZNOazapKcuVNv0yT/wijmXGjM8QApYJQ2CiGSeSXFRcyMoH+4CJV6BkbwfB4rVNJmGXGGUu9Mfr0nn1s0pYIBf0H+lJCSEXDTGnTg==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PA4PR03MB6941.eurprd03.prod.outlook.com
 (2603:10a6:102:e7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 21:18:49 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 21:18:49 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
CC: Caleb Connolly <caleb.connolly@linaro.org>, Sumit Garg
 <sumit.garg@linaro.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Topic: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Index: AQHab2CjKZvPgmo3NEWX73nxw+EzJLEqNlMAgADZo4CAABqOAIAADGmAgAd3mYCAADMxAIAACcIAgAASz4CADKaMAA==
Date: Tue, 19 Mar 2024 21:18:49 +0000
Message-ID: <87jzlxzzrb.fsf@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com> <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
 <87y1av12bg.fsf@epam.com> <0cda2608-856f-4650-92a6-4860a0d7c8b6@linaro.org>
 <87edcg1vcp.fsf@epam.com> <b8774081-dd8f-4154-9c39-0c0b5fd48adb@linaro.org>
 <874jdc1qbg.fsf@epam.com>
In-Reply-To: <874jdc1qbg.fsf@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PA4PR03MB6941:EE_
x-ms-office365-filtering-correlation-id: 9cab84b3-2cfe-4dbb-8231-08dc485a2b98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iBP8dJhYF0jTaMzrJ2+mGZn+8wr6EIl15tTMv2Z/tXwJUM++hiLSnZDLHlS69P8FzMsBQzupgtkLkcUoMGAVb7GBDAQM3aXjlhYT+UIz3B1TtYOSSkEEWUSCw/g94uHdkfPAH9sYmJp5uTEZI2YgAmyrjUGS6RG8DYTdr7MiaKt92bILvltT+BaVXcQiPvwxTvuXD5R75noFAXDTb8150yTMj4WVHc5wkRlv/Z/ZUs8JQpCy9wlxVfEgoNxMLaWa4AiOlwe+rlW/F2vMihasgVWi3ogT0nvtpcmPn1IP/HdSuWfbebxcXHVTao5XRQWU5aMV2peWzzMu7xue/icd3gSSm1OP0i6zzYnELxAx0PIRCoiIM/OE2ih5Atttwf0e/cn91I7PS1MJC4jtF6WE/77Dk2gtaRjnCmTlL1w0s06eQ79Ws9f961XD9ss0tzxj61uf0f8TL7EPlmaDt+tCP3ohqqSGDdDl1NYdB8XdqXT++8RIk2JA8faTgwqMIzBoRfi6nqqDXeKeTZkOklrrIzXm93fIliVWhG9yeUVA8Lzdef/dFnYAceTWUsFFSh6CtGaAQex8fdfj6p1VB0TgBSABAwGu1O7LkJMwqfL93eYVSUptj712TY0I+TE7L48viJGKV6Lxp4HPT+JP9lwG+UDbcC4n/GlkmbhNOhk4TI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hn/WLOf9SjJ31ikCUXSUct68nLkdTs5e5t9VhqeQKf9kBur5YekEKOwnjI?=
 =?iso-8859-1?Q?OFJ87fwvRQL5Bud800N2seNMZh65b/rAb3ns+xc1YIZinzUul4Nsvpo/Ap?=
 =?iso-8859-1?Q?LsADeFd+s6woGRqmBzICs+XRCG4/yTcthwl4gHoY3IFM7yuRQCGSG99xIq?=
 =?iso-8859-1?Q?211bhmUobwu++8H6lJub6CcGkOSnDRrfJioFhl9T2D35uxCu64LwzcNW3D?=
 =?iso-8859-1?Q?Pab7JPrpPqT4+PyAvlmEFpf2pnMm6HahRhvKn2Uhn73v8Ti+g8hb1SgCSD?=
 =?iso-8859-1?Q?XDZ78dEQp8AKCqc5TbA+MtVDb9R8jRGpn/njvT6YsLkEWzAuhVJTkfFmcc?=
 =?iso-8859-1?Q?iii+tedEInusOiW9ccMtXqXdfCiXMXlAgQgF2+n/l3LxqaYxtuwVrXCWjU?=
 =?iso-8859-1?Q?ec6XGQX+svq0rCrT8e8tWhQknlnJZsyAEqIBJeKEPAPqSoTR1Emd9d8tOB?=
 =?iso-8859-1?Q?ZIYawa6u2cm6muB0FobFkmYgQmZ2igN6rzzQYtJ4TfMi8UB8odt62vkzYy?=
 =?iso-8859-1?Q?7qjomdQYI0ZVCTu+FSGNroKKghNrg0Erbhj55XQqS2QfxsA86A3Eujm3IR?=
 =?iso-8859-1?Q?mvRENcbW0bCOQ4bEMlK4MpuwsMq1oyfE+N4oo0x6RAfyBxPIDvPZokhCIP?=
 =?iso-8859-1?Q?QSni//RrcC1nMJeAbMCt8FcvNBXmMVTydWdv4iWskLuetpjg2ZJNjLEdLv?=
 =?iso-8859-1?Q?2AnI3VjQeVx5P+gueN5slfnKTkZdP9HWJ3ujt9abfFBKXKZfCeBS6E3U3B?=
 =?iso-8859-1?Q?4mfoYBOcuiQJR010WVwnKR1SOzdY05qvfwLfpZ9aXE+CRoF086KEVnapoc?=
 =?iso-8859-1?Q?QO0hqbiYvJXl19/Igzefw+LvlazZ3wM95l7pAvyNzrtvGMR+6ZA45SW/93?=
 =?iso-8859-1?Q?vTAtsTjI7+MEcf46w5bNuRwszsNfBDlYiBcRRgAL+92iprgH2zrEoZgrg9?=
 =?iso-8859-1?Q?E7en39NPzodWqX+tkWm4KXQZrPnNeb1s6mB3j70tdXeYGLQABCs5B1y0Ki?=
 =?iso-8859-1?Q?qjQJLOkVcCW2Ke7UQC1aFEUFl08SRj10w4mytRIwFFJ6flcV+sr80ige0I?=
 =?iso-8859-1?Q?pfEqUaRdsEsbnnKpOBoyTfP9/yuxMrJy/DLISarBXTuMEIGwaqZ9wFgvzl?=
 =?iso-8859-1?Q?Ip9qHzWclze6t3eIIaIEohR1xirPPwlAWNxckH3V3cYmOSrsDL6XA8AS1w?=
 =?iso-8859-1?Q?ZEeW3XMZpuLpMS/nr6fI058SlBzKMfqphs8X+kOcliLwiusy6GF6RAk/Id?=
 =?iso-8859-1?Q?9l3RdSgsxdzyenRKZhpQ2CXkV96hP5mQ9MWMwhJ3cuOghuFoTt7NXRiSfE?=
 =?iso-8859-1?Q?mWInf6djgVueVbq1Y1uAgfv+4xhVOEc3mhcDY0ZJ2SCqIhIFq+qSb9A49g?=
 =?iso-8859-1?Q?eN7umfA9Kp7Td8xKoRG8yRrPd/axj84BvlPuN5uoYtumDns0MNgkAKhlIT?=
 =?iso-8859-1?Q?wxcP24aY0Q5GkEm3RpX3k1L3bS6759VNiDO/ZksIdbz2O6x7+jXlINB4ol?=
 =?iso-8859-1?Q?48BZ9q2poQ8MV+AQ2wNdhlqeFpSLblexwxsN/alOBEkMRcfxlTExCbk4p7?=
 =?iso-8859-1?Q?NCCYlkZf3ZypwgbNLymLJGDC925inl4JnUFLNVnBsj98oSoDMrjHsE55/z?=
 =?iso-8859-1?Q?fmhQ79ZP/V/gLR2+vXQqzT7ahjo4q3O9A5f4JOPaKNF1IPFD2Jdvuqkg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cab84b3-2cfe-4dbb-8231-08dc485a2b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 21:18:49.5163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmcDT1BxHrHH3Vs1eqJTG5cFHBTlK5/3+4v2edY93vMON6Bhh/nhKxOtZz0w4WyVp4nzEjQM2aCahqQko7xsFKuYN3b4s+OB/IQYjs6gH78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6941
X-Proofpoint-ORIG-GUID: MBnoQLIVZ0IcOubqLWaw3w8zEq4Jqe7J
X-Proofpoint-GUID: MBnoQLIVZ0IcOubqLWaw3w8zEq4Jqe7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190165
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


Hi,

Volodymyr Babchuk <volodymyr_babchuk@epam.com> writes:

> Caleb Connolly <caleb.connolly@linaro.org> writes:
>
>> On 11/03/2024 18:23, Volodymyr Babchuk wrote:
>>> Hi Caleb,
>>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>>=20
>>>> On 06/03/2024 21:24, Volodymyr Babchuk wrote:
>>>>>
>>>>> Hi Caleb,
>>>>>
>>>>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>>>>
>>>>> [...]
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +&tlmm {
>>>>>>>>> +       /* U-Boot pinctrl driver does not understand multiple til=
es */
>>>>>>>>> +       reg =3D <0x0 0x03000000 0x0 0x1000000>;
>>>>>>>>> +       /delete-property/ reg-names;
>>>>>>>>
>>>>>>>> This won't be needed if we can make the tiles offset in the pinctr=
l
>>>>>>>> driver compatible:
>>>>>>>>
>>>>>>>> #define WEST   0x00000000
>>>>>>>> #define EAST   0x00400000
>>>>>>>> #define NORTH  0x00800000
>>>>>>>> #define SOUTH  0x00C00000
>>>>>>>
>>>>>>> Hmm, I assume that in this case pinctrl driver should map all the f=
our
>>>>>>> tiles independently? Are there guarantees in U-Boot that four separ=
ate
>>>>>>> memory regions will be mapped into virtual memory with the same rel=
ative
>>>>>>> positions? Linux clearly don't make such guarantees.
>>>>>>
>>>>>> U-Boot doesn't use virtual addresses on arm platforms, it only goes =
as
>>>>>> far as reading the address from DT, nothing else, so this is totally
>>>>>> fine and is how the other SoCs do it.
>>>>>
>>>>> For me it looks like we are depending on implementation details
>>>>> knowledge. I.e MMU API does not provide such guarantees, but drivers
>>>>> know how ARM MMU code is working internally and drivers depend on
>>>>> exactly this behavior. But if you are saying that it is totally fine,
>>>>> I'll rework the patch. No big deal. Actually, I already tried this an=
d
>>>>> it is working fine.
>>>>>
>>>>>>>>> +
>>>>>>>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>>>>>>>>> +       /delete-node/ phy-reset-pins;
>>>>>>>>
>>>>>>>> I suppose this is not needed as phy-reset-pins also configures the=
 pin
>>>>>>>> as GPIO only.
>>>>>>>>
>>>>>>> Well, yes. This also puzzles me up, but for some reason it stops wo=
rking
>>>>>>> if I leave this node intact. Looks like I need to look at this deep=
er
>>>>>>> before posting the next version.
>>>>>>
>>>>>> Possibly the pinconf defined in the phy-reset-pins node causes U-Boo=
t to
>>>>>> misbehave, can you check if this patch fixes it (there is a bug in t=
he
>>>>>> line "return msm_gpio_direction_input(dev, gpio);", it should become
>>>>>> just "msm_gpio_direction_input(dev, gpio);").
>>>>>>
>>>>>> I had the exact same issue with the gpio-regulator driver and this w=
as
>>>>>> the solution I ended up going with.
>>>>>>
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/u-boot/20240131-=
b4-qcom-livetree-v1-7-4071c0787db0@linaro.org/__;!!GF_29dbcQIUBPA!xFhZe7DKg=
Rbr63sirEJLuH-B0AnGs7jvx8tdJPKLTgFuZ3I3_zpVml7l23G-_vJO_JiUR-wUO4GMPJFcE-8p=
50H3pf7nbxit$
>>>>>> [lore[.]kernel[.]org]
>>>>>
>>>>> It is exactly this. With your patch I don't need to /delete-node/
>>>>> anymore. I'll add a comment in the cover message that this series are
>>>>> depended on your patch.
>>>>
>>>> Please can you split the power domain and clock patches into a separat=
e
>>>> series? As I'd like to depend on them for the next revision of my
>>>> series, and we'd otherwise have a cyclical dependency.
>>> Of course.
>>> As I understood, you are interested in "clk: qcom: clear div mask
>>> before
>>> assigning a new divider" and "clk: qcom: add support for power domains
>>> uclass", correct?
>>
>> Yes.
>
> Okay, I'll send it today.
>
>> I tried the power domain stuff out on SMD845 today and ran into
>> quite a few issues. Specifically as a lot of the devices reference the
>> rpmhpd power domain which we don't support (and don't *need* to
>> support) in U-Boot. I'm not sure what the best way forward will be for
>> this. Maybe a "nop" power domain driver?
>
> Are you sure that they are not required?
>
> "nop" power domain always is the option. Especially if it prints some
> warning about an unknown device. I had quite a lot of issues with clock a=
nd
> pin drivers that silently ignore unknown devices...
>
>> Do you have the same issues on sm8150?
>
> Yes and no. No, because I was lucky so far and devices I tried to use in
> U-Boot does not require rpmhpd. Looking at DTS, I may only encounter
> issues with sdhc_2, which requires rpmhpd for some reason. Also UFS
> requires clock from rpmhcc.
>
> And "yes", because I have found root cause for my troubles with UFS in
> Linux kernel, when I am skipping hyp.mbn. This is not strictly related
> to U-Boot, but you may be interested in this: apparently Qualcomm's
> hypervisor enables access to RPM (maybe brings it out of reset?). cmd-db
> shared memory region can't be accessed if I skip the hypervisor and try
> to boot directly into Linux. So now I am looking for ways to enable it.

I want to share the solution, in case if someone got the same
problem. It all boiled down to correct memory attributes. Qualcomm's
hypervisor mapped cmd-db shared memory as non-cached in Stage 2
translation table, while Linux maps it as cacheable in Stage 1. Thus,
the final memory attribute was "non-cacheable".

Xen, on other hand, used default mapping which is normal cacheable
memory. And of course this lead to cacheable accesses to cmd-db. For
some reason this caused the hardware error, which manifested as a secure
interrupt (while I expected SError at most), which in turn led to
endless loop somewhere in TZ.

I am going to fix this by applying the correct mappings in the Linux
cmd-db driver. Plan B is to have workaround in Xen, but I really want to
avoid this.

Right now I have a working Xen that is able to boot Dom0 straight to
console, if anyone interested.

--=20
WBR, Volodymyr=
