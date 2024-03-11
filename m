Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919E6C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 20:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 150D287EDF;
	Mon, 11 Mar 2024 21:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="rknvJ/3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6E587EF7; Mon, 11 Mar 2024 21:12:02 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CF787ECC
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 21:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9800dbbead=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BJU75N026066; Mon, 11 Mar 2024 20:11:53 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wt2je14r1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 20:11:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSItB6xo8Gi0TgGpvr3FAh8jdTBx0XaAWRJd+DlmMMDq+DYqWnrzywkOVyd8mV8q548lkr0lkYt20HN8gV8gCZBaDrjcceRGZ0OipMFQF4e6yL7GJXSAFnRTncSLv4gmEBq4JfzlBw11ihbnTyvUZc/7x4ctDqSp0ojk4JTWJ/L/CXT0QG3noh4+Bu9BQVTQEbQxlf+6R+adh5IOQhfMGUIXc8d1qhFiye89+GGUmgxd0IsCtWSUmawuGSjyWRBRVPhC736dou38kFEePnKAYO6rIiLDmC8rfHgzwTC6bWR3C6nVM6XjWsUCeh334v2yLshcoxo19vtEjM50NKngJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2nBxddpN3hO8qWzJJJJM2s5yINXFp3zhQEE6xXGkV4=;
 b=THssHPzdEEU7ste3djmaxsd5pwrb6/QF5LfMaY7LVv9E6XSLj4nUMLte429m+mPDOTM/9tHi1pDSjE7MWdsEKFaQps1ubgT6GcQvuTsp5GP7271TGDfORUtCVU+4FOp2NzCDHOUdHLw6lzC87n2/W+y26FpHepDvNCeSp4c/1CSVy1RKRIVNw4iAr0bv4jojRrPY2MBFsJ46oXTu5rs2PWuC0287j6kkT6V4eIKluVZPkq/Z2W3EDvCUZWBE/z0wAhsapbpjGR4+ImVyuA4gaA+b7MCWPkBIifJl9b4Q7CPh2/ZRny3bGSX1kZbABDTCOO3B+wdG7qNgUukavg23ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2nBxddpN3hO8qWzJJJJM2s5yINXFp3zhQEE6xXGkV4=;
 b=rknvJ/3DeB399j3hPVh+8162B4VcQMheYGyFP3AcsjuYV4lp1XlOYTcxQgPn1yKTbAC31mhoH+WLinwzgjsY1CvweKBP9+UKi4iyHse1Qt4rPi1WPFYhn5GYRnNRG1M90dvK7u6NDClm5jT/Jv79SY1RCCAx1f7igiQiRpCNP+aJDs+g/9KBXNLSIVq2ARWPEbHN3qilNS+dVyQHPbnCiJRB0sQ92m65PgwkbprcsnNocpiUzzYO0agaNj4O9SJeULeU/cGTEQG+SlPn1HgmmYjKm1oXsCryydEGOQ6UuXOtc6ggvm6s9SGWQiDWkw/87Rebajj1bGt5HdJhhmSD9A==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PA4PR03MB7487.eurprd03.prod.outlook.com
 (2603:10a6:102:104::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 20:11:49 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 20:11:48 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: Sumit Garg <sumit.garg@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Topic: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Index: AQHab2CjKZvPgmo3NEWX73nxw+EzJLEqNlMAgADZo4CAABqOAIAADGmAgAd3mYCAADMxAIAACcIAgAASz4A=
Date: Mon, 11 Mar 2024 20:11:48 +0000
Message-ID: <874jdc1qbg.fsf@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com> <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
 <87y1av12bg.fsf@epam.com> <0cda2608-856f-4650-92a6-4860a0d7c8b6@linaro.org>
 <87edcg1vcp.fsf@epam.com> <b8774081-dd8f-4154-9c39-0c0b5fd48adb@linaro.org>
In-Reply-To: <b8774081-dd8f-4154-9c39-0c0b5fd48adb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PA4PR03MB7487:EE_
x-ms-office365-filtering-correlation-id: 8f374502-baea-4ada-9288-08dc42077bc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: abroNg5sDpVkMvEjv3rcdcCISaIEHD8EWnvQ8cSHUJ4JOzH56HqG+TVNxTSbi556GU6g7HWyn1UFod1qthUHI2sDkTfzpwoS9GINV4geqa212nw+1Whg6gDpbhmHt/JXVTRm9l21Ouq2DTwJ339JV74VWes38g4r6ycJRZv2U0591jP4JvrmmJHMd84BJh8uk2aNdOlMgbBMvUQ1lXwpEnQFx36/LCIBCSPF0QDapsVatz0jyhowdB8m37bcp5ucZsb7swEfAymBhOSrMdiYSlZV7JQGcsFzzbYcFqQ/6SrB8NINGZqxAYD0neHrws+0FYr4L43fYHQdkjQeKbHZaqViCpoYIR3CBFZVk6ktfi7unstoshO4f/Qq5wQij5qEwMOh1BUV2bAnyCtIdyLlIpf/6I8dso9zkeGW1zLApCMmw/457Mw+RpGzFCe6JKeOeGOwkRHiNsIWN2Gt3s3kFrYFztTXasCtTXrWG1sdVhveONRPYiXw0/8D8ZdXkB8WtQtq75+yFZFRcjh/pO26BBUBK+EX3N+K1LwAiasoOFRRZ6/2u8dyLXqT4wdwPXkj7qj97uAzPDGew4gwZ9/Lx0UL+I/69r+FwcOi6JmzF52TB3m0u57AEQZypmjyemsjGP4zQ0nXH7fMU5aEIVXIUWPQZmS2ygXdNrPbj3q0hKg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P9JPgjhHajhDHwPPzH7/Gpk4dEPx5OCOaewOJLduLf3qII+XJa6ytPR16S?=
 =?iso-8859-1?Q?3jO8bzio1vhw/2YECo01N9i1PzzGeotF4qcisz6ivkKvdDhr1IAHkjGlYQ?=
 =?iso-8859-1?Q?gSxJkHVEZEnXq+3l9k96DKYkC7oMDLnphN+lumqL97yyeqlwFr9vRztaEs?=
 =?iso-8859-1?Q?pXYZsL8DvNUnCKAluaJBtJ/Mmr1oVaOUd7RsaxgUPfONX+W6fV75PC5+qf?=
 =?iso-8859-1?Q?UIUGkbxUHdTs6homBhzSc+3w+sysvONLL7XLE1IGxDeITzXkffULnjZ5A9?=
 =?iso-8859-1?Q?h6TS1vPAS3xl7KNEXHXTi28sA9j9vKFBq4DlbhGE/8DZRyyEi5bK1wxti/?=
 =?iso-8859-1?Q?+3ywDfd2jE18wHdHHoQhH2Nb9qSySFD2sU7/iYjY2blWjZ5092v+3OsQ6w?=
 =?iso-8859-1?Q?oj4MyF1pMM4Y7KgzDN2E+q/6pcoSG1q/7Th4+dxdh5nmM+y8K5P2RGLDHd?=
 =?iso-8859-1?Q?mPkXuqb2AnTHsoagAsmAL5XMIADUCmCimSHceDD8zoPJ1zt/xdNdKmp+HZ?=
 =?iso-8859-1?Q?7geGHGNGFyERf6yByywJygxaNnWcDdE98ZLMDv1ziat4N6rfcZB7NB7MFw?=
 =?iso-8859-1?Q?UOT8FhEJ2b+m+oK/OewSm/F9ldfvaS7vk/kTsHlaApSso5/RVXxhZRnnf8?=
 =?iso-8859-1?Q?h5xHxDIvLCtKtvY7MseurtcWOxTfCCAMovIlFDL1kMvEhE0Mlh24kjL55X?=
 =?iso-8859-1?Q?+rXyNXkp6cMGzEoBChsjK/J/QrF1igw8m1AdQa99kw0QY1G+Ff84IBRbMd?=
 =?iso-8859-1?Q?U94BGBaT8YEVoe8UyD+8RTC4smV1qqo0nKAVD5YHGNd49JpZ/Bg4vJuDHE?=
 =?iso-8859-1?Q?XIQGYgFZlIxO+k1gj7GOhLyaYCNOVEWBdJOBTb1kg30dN2v7Ef1mm57uny?=
 =?iso-8859-1?Q?ySDFAvkvuGNLOKhUE2h9hc6/o/wJVD3Pu0kiAsFulj/uJWCBRYGe1lOmim?=
 =?iso-8859-1?Q?Dt8c1mo7QkJaK3ReTuB40KVR5MPzZctbqvPhnHBxjO/3baEkHY+qelizws?=
 =?iso-8859-1?Q?23FPaWT0zcOpLSrJgACiBxZZ6t/dZry8rnKceBqApmyJHa8uBsyIZi1GMW?=
 =?iso-8859-1?Q?BLNT2CGnoUsOuIhOaDV5PM3LPoZ2EzwpJ75XbYzy/k7zY3d7uETDL3eT1N?=
 =?iso-8859-1?Q?qjEYlMLWKijeSprFmFnqadwghw695QEukfIv6oca4mhk15DxnU1bK2RnI7?=
 =?iso-8859-1?Q?2VHQSyc0ilFQ1gWA/2ks84HeBfNrjjNxSqUeSt4KUHTMqUQg9QsNhukxdm?=
 =?iso-8859-1?Q?3ANilrtkr6pJk604FIEr5C+rJD0/FgMAcSLUWu3Zvj1Id43m+ZKqRHNaun?=
 =?iso-8859-1?Q?rqpQcsEJ3zQmsgGy63UQ5YoztCsAJDM4oTpeb5kuqSHgSTUqjHxVGuju1Y?=
 =?iso-8859-1?Q?WCV0a1JdWn2X7b0KWH0RmacElwD6QqSR0OLCLQ0/6PpgGlRAlmh08CDIPA?=
 =?iso-8859-1?Q?5XX8d9ZXNkF4BnyCRc4X9pBwDhTA1sYan/eYxfVy49ZIezELobgjQWPtcD?=
 =?iso-8859-1?Q?aP256dS7EINoJeknznGbPwe4Kr5a4cmR0DW4jtCE1iSgQIinhGjWtKFyYa?=
 =?iso-8859-1?Q?8H7DaYrJ+1mDG7j3a2P/EEOZs/Y2L5tbzxuHpxfLq+1Rdsny1rl0gUluf8?=
 =?iso-8859-1?Q?2qC6uBNj3uLRinqj0k0OPRLMPd3sZxQOF1JCrNyUMFKq/Zv+srMljbzQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f374502-baea-4ada-9288-08dc42077bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 20:11:48.8180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwGw/jnjc6Yxh3GvwFk9HcFJmsgGgjaasQArvkXy520A86LYQx+815ipUvzUEfsKCzhZv2Jtk4yMvVQkKFM9c96ETSyYafqe1rarldDjn3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7487
X-Proofpoint-ORIG-GUID: AGr0L_B2BRXMA7NrW3pCor6dBR2Tw9ls
X-Proofpoint-GUID: AGr0L_B2BRXMA7NrW3pCor6dBR2Tw9ls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110154
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



Caleb Connolly <caleb.connolly@linaro.org> writes:

> On 11/03/2024 18:23, Volodymyr Babchuk wrote:
>> Hi Caleb,
>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>=20
>>> On 06/03/2024 21:24, Volodymyr Babchuk wrote:
>>>>
>>>> Hi Caleb,
>>>>
>>>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>>>
>>>> [...]
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +&tlmm {
>>>>>>>> +       /* U-Boot pinctrl driver does not understand multiple tile=
s */
>>>>>>>> +       reg =3D <0x0 0x03000000 0x0 0x1000000>;
>>>>>>>> +       /delete-property/ reg-names;
>>>>>>>
>>>>>>> This won't be needed if we can make the tiles offset in the pinctrl
>>>>>>> driver compatible:
>>>>>>>
>>>>>>> #define WEST   0x00000000
>>>>>>> #define EAST   0x00400000
>>>>>>> #define NORTH  0x00800000
>>>>>>> #define SOUTH  0x00C00000
>>>>>>
>>>>>> Hmm, I assume that in this case pinctrl driver should map all the fo=
ur
>>>>>> tiles independently? Are there guarantees in U-Boot that four separa=
te
>>>>>> memory regions will be mapped into virtual memory with the same rela=
tive
>>>>>> positions? Linux clearly don't make such guarantees.
>>>>>
>>>>> U-Boot doesn't use virtual addresses on arm platforms, it only goes a=
s
>>>>> far as reading the address from DT, nothing else, so this is totally
>>>>> fine and is how the other SoCs do it.
>>>>
>>>> For me it looks like we are depending on implementation details
>>>> knowledge. I.e MMU API does not provide such guarantees, but drivers
>>>> know how ARM MMU code is working internally and drivers depend on
>>>> exactly this behavior. But if you are saying that it is totally fine,
>>>> I'll rework the patch. No big deal. Actually, I already tried this and
>>>> it is working fine.
>>>>
>>>>>>>> +
>>>>>>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>>>>>>>> +       /delete-node/ phy-reset-pins;
>>>>>>>
>>>>>>> I suppose this is not needed as phy-reset-pins also configures the =
pin
>>>>>>> as GPIO only.
>>>>>>>
>>>>>> Well, yes. This also puzzles me up, but for some reason it stops wor=
king
>>>>>> if I leave this node intact. Looks like I need to look at this deepe=
r
>>>>>> before posting the next version.
>>>>>
>>>>> Possibly the pinconf defined in the phy-reset-pins node causes U-Boot=
 to
>>>>> misbehave, can you check if this patch fixes it (there is a bug in th=
e
>>>>> line "return msm_gpio_direction_input(dev, gpio);", it should become
>>>>> just "msm_gpio_direction_input(dev, gpio);").
>>>>>
>>>>> I had the exact same issue with the gpio-regulator driver and this wa=
s
>>>>> the solution I ended up going with.
>>>>>
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/u-boot/20240131-b=
4-qcom-livetree-v1-7-4071c0787db0@linaro.org/__;!!GF_29dbcQIUBPA!xFhZe7DKgR=
br63sirEJLuH-B0AnGs7jvx8tdJPKLTgFuZ3I3_zpVml7l23G-_vJO_JiUR-wUO4GMPJFcE-8p5=
0H3pf7nbxit$
>>>>> [lore[.]kernel[.]org]
>>>>
>>>> It is exactly this. With your patch I don't need to /delete-node/
>>>> anymore. I'll add a comment in the cover message that this series are
>>>> depended on your patch.
>>>
>>> Please can you split the power domain and clock patches into a separate
>>> series? As I'd like to depend on them for the next revision of my
>>> series, and we'd otherwise have a cyclical dependency.
>> Of course.
>> As I understood, you are interested in "clk: qcom: clear div mask
>> before
>> assigning a new divider" and "clk: qcom: add support for power domains
>> uclass", correct?
>
> Yes.

Okay, I'll send it today.

> I tried the power domain stuff out on SMD845 today and ran into
> quite a few issues. Specifically as a lot of the devices reference the
> rpmhpd power domain which we don't support (and don't *need* to
> support) in U-Boot. I'm not sure what the best way forward will be for
> this. Maybe a "nop" power domain driver?

Are you sure that they are not required?

"nop" power domain always is the option. Especially if it prints some
warning about an unknown device. I had quite a lot of issues with clock and
pin drivers that silently ignore unknown devices...

> Do you have the same issues on sm8150?

Yes and no. No, because I was lucky so far and devices I tried to use in
U-Boot does not require rpmhpd. Looking at DTS, I may only encounter
issues with sdhc_2, which requires rpmhpd for some reason. Also UFS
requires clock from rpmhcc.

And "yes", because I have found root cause for my troubles with UFS in
Linux kernel, when I am skipping hyp.mbn. This is not strictly related
to U-Boot, but you may be interested in this: apparently Qualcomm's
hypervisor enables access to RPM (maybe brings it out of reset?). cmd-db
shared memory region can't be accessed if I skip the hypervisor and try
to boot directly into Linux. So now I am looking for ways to enable it.

--=20
WBR, Volodymyr=
