Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2854C5475B
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 00:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC61887DC7;
	Thu,  7 Mar 2024 01:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="juMCr6sY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142D987D70; Wed,  6 Mar 2024 22:24:37 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7645877FB
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 22:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 426FGnNO003353; Wed, 6 Mar 2024 21:24:28 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wppcxj957-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 21:24:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKHBx/JftCZZkwoKSKiJLyBPoZhRTfiUWzMi06BVvmDZDjBoAV+VOE8Ej67gUHLjrR4a9eUOultJHMPrHPktfd7l2mtuhYKXyDhq6+/XRMb/36vnEIcQkhCtADOxTo8qOchWvUG3AOK4PA+VOhi/W8VLKilBXv3Dg5a8py4utGbdprWoFWjmhX6gOSGyYUdgDjsUciVWZwB35t6qXTanf1mLd6dWS6xlszSW48f7rcEupIGiiD2Z+nyLD3DE8Pd9pypVCr7jJvyUowGv8ZeYWCPRBrI6J2hoPnhGJvQDcr9byw1AAmKL7V8ZPqqmzq+NY1SdyI5+R0ZHSuvaYVRyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ocOzbIsd6ycuvYU5mi/Sb50l0JCjPt4xXk4OgzEHCs=;
 b=PMrLQ4x4U2AF0gMyyV37JJSRQHTF7mDkizMmmXANpzRFlpE9MdjrpKFajDGE7WN4I14FlyqVc1JoVb0362pr6Pys8r+jtLbgPptXKXrBS/ajhS5FGwHOZ8k7k93s9CYlwdjTM6IFIcgmT+JfFPgW3lU7s+MUqvCQ59dqU/qrcRXxoP5hm55S39lYS9oRo1Kh8wt0cH5A3kCDQot0n09pffaQHX9GMWfEvmbhXHlX1fR/Ha1CyKdPg/kwjTI5PzqvQbkR1EnQ8WMyXOuMwv982CGpqmIH++zaW7Dce5Am9Z355m/kAwRo29klxeFcKLPwsdV6HeceUbqMJq9uUAuy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ocOzbIsd6ycuvYU5mi/Sb50l0JCjPt4xXk4OgzEHCs=;
 b=juMCr6sYRGDpuDhNHolUUDmo+NVkwWeLJBmykemzU//4r70D2Qwjbl1CTtSVeTTxUTiKje2JLFi8AgHHgfLYbNSeVZoJvNWmPYhcFGAxG6QSvaq3lRRlUrWfm8e60dQWdUTUq0I1WIv2MolaOeJfMqKyBCF+NVCFp0sKqd9AmWGYsDLmsj+sLYNRtVaDL9NSAHIMIVArwBWehagFQxTn+sjlPOLMNk0008C0fUdbUnEatma7TMnlqE9BWJLy7F/3TmGc0VWSH8VzWL0yqx0SP42tAaKEE5lhZs9IsdHDqzE4o1S1k8J+XlM3+fyseiwmcDf4ToufRzm+BDr74MHHgA==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by VI1PR03MB6285.eurprd03.prod.outlook.com
 (2603:10a6:800:137::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 21:24:21 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.024; Wed, 6 Mar 2024
 21:24:21 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: Sumit Garg <sumit.garg@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Topic: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Index: AQHab2CjKZvPgmo3NEWX73nxw+EzJLEqNlMAgADZo4CAABqOAIAADGmA
Date: Wed, 6 Mar 2024 21:24:20 +0000
Message-ID: <87y1av12bg.fsf@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com> <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
In-Reply-To: <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|VI1PR03MB6285:EE_
x-ms-office365-filtering-correlation-id: 8d90837d-5d7d-4443-7a9a-08dc3e23c9b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRSPvZkctMtacixd6dfDfdFcZEFwGHgkuzWxgwYMN03zRLO+dHHkg4S6vZFgaPjKgdtNRk3fF3LTO4d9z/2d/0Om126zqwoODvTqKpln4ArsAjmIlLnP24fio0lW7Zt+4M6MBGOcD4Q/dg6XxzYcdf6Q79XhpOEaGPLTKR30kp53d5EYLkL7FcZHB1ga4Ur6ouPn5b8DiLVrsPvkKZD1MKLMdIXDGxVWEiToqdfHgDuQv8Vaw5HeKRYROH1VaOv6z8h6KudeQXIpvhPyVaRQ+HaahrRFNlSgmzScS+Axo5uW9Jyx3vBiYY3gm2L/7p9TVuZgNN7T4xInENdfRUTyz2Ebd7aGqeiE+uFDDXTLvxhLP7m7uUFXn89I3Wt9xQO+ZKG6KJD5AJ4iai3ucjEW5yxYVnA1Z2gZGJk6yVOpRBDLQkcn+F5vUQCpnIsOxByF491uRfsuD/C5ZaekWpSiyP/cDRs1tN1d/v5sdX/qT1ay8JBSAflx/i0f9bb+Y2LxKucDUSBDzD0V7kU5Jgo4sFPlPWAdaY3NjgulSiliob/BKWYWDi8Ee7fUQOT/xkSIDz74PXWy9jpur/CsbaVJ1+U10YYOXVk9JFQyYCyAT5oT3ycxVkwI9d0tXxJ2Pp7P8YKHCrfelQYXwgwpk96wfQwx+Za9nVXvIIluFPmmF2c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SjHw3rBh3XQSAgnT4tbV7YmM8KQvrmIRtJSB9yGaUtDiRIdDAtFaazQeT1?=
 =?iso-8859-1?Q?HIuRWg+sUdqqK0NweILMPcoQGlouS8Ebxrxlrk5byJ6pkTXYU9ymCFnIsj?=
 =?iso-8859-1?Q?jAMbJKMheNtbZdy7rmaKzD0DbXZpzv81ETGDBfLiNfRx9o+O5zP5Mvmi5g?=
 =?iso-8859-1?Q?WxO2hBXylqjLB/mQ8Sf0wCrHNbWy/xHjKJI0ohsj1uYjPmBEweU9kqeFaf?=
 =?iso-8859-1?Q?KYDiAforHhzD2aHLj7tEqnFaxrnc4rzURqQtw4Y05GdKi/fPIHzd0TyxbH?=
 =?iso-8859-1?Q?OMTKKGfr2Gh8SvZM6egQcBJVcyoHaBbhJYos36hTkjLFdkrVD9hyjbulvO?=
 =?iso-8859-1?Q?NHqbUPKhRK1f5AhJxPfnW//p3FzvGyXsZysMDC7YTHvslpoUFWiHvBWxyx?=
 =?iso-8859-1?Q?uZnH93jE/I2DgfvfiMalp21nxFzSDLRhjnfCQotmJSADgep6y9isj/WtoY?=
 =?iso-8859-1?Q?CDuBFo5gM7swOTLupetYt5I6Xr1uTPLpzLheKhZaf7Cvs7sJZuwpsKF14V?=
 =?iso-8859-1?Q?8xhcj4+tH/T0fiJeL/DXAXmzBrgsOuXce7pDhvYtCSi/bOO/ERKOTnjQnT?=
 =?iso-8859-1?Q?d6zmRVBobBoeevy7e1oP40dALsKUPbtZqfsKGW8JXc/t32pZQz/zqKBEax?=
 =?iso-8859-1?Q?d/UX9iQYJZr2byAHl2W+Weo2U09SeA7UKfk2nWeFW1+aEE0VO8ZLJFztjo?=
 =?iso-8859-1?Q?ysU+4NhYSc6+dgl3d7SgRfoBm1phpBFuaMe25PQNuZjtuIkrSzMErKTjEL?=
 =?iso-8859-1?Q?21ASUCehVuIrQiQuXg8Zn7/n0O6MFPQGgYPYjB72c/vxtMljxyr1bXkXrK?=
 =?iso-8859-1?Q?n0WLeDqxirbN+iMrY/lXQIElyuaIf0kh1KSXSP4UD05rgzK2Thuq7PMvXU?=
 =?iso-8859-1?Q?1VZj4HZgT8lkezbRNY8Y3r47R3unmJli+sHXshQKzcaCsqc3dAOBFZJTd3?=
 =?iso-8859-1?Q?NELgMra6NbK/7/wMag0GhRIl1ueVei+uzF2FwNPktP6DoM5SgQDOKpacn6?=
 =?iso-8859-1?Q?I2NDOh700OD5ASi/960srisGRVxo3ifBlDboRJa8IV0X7Eyngs2P+ZHOPr?=
 =?iso-8859-1?Q?Hp6Y/+6BSKRmp7o+pZGfrlNxBQLF0M2uM7OdIFuD0FtFp83g86Pzl4vrOE?=
 =?iso-8859-1?Q?ETfYIiuU+NYu0fk4XMOR7kGfwxXaq+7p7nZeMc25OKYkxiuLEpIZXOqKXy?=
 =?iso-8859-1?Q?j09b9hpAVsoNgeo+6d0iXuCzqab+W8ADJPWSEWLmdC+/mcxTF928kOONUT?=
 =?iso-8859-1?Q?0oUxU3SycBCAOpE7uYDe9DNdJ46OqacriV6Bjb968YBG21588JRHpCBlNJ?=
 =?iso-8859-1?Q?LU8VxvejOYZOlwvrHNVTVjJ0hXm3lJWiA44ZtoykmlaxVBf7wdE86QVBKs?=
 =?iso-8859-1?Q?iX5FmLltMfV3P5bTYYnF6Q5IHdD02TVZPWVqgGVSxOopxCPo42N2678WKP?=
 =?iso-8859-1?Q?1XCEOWNsAPoFOIpKUfGczl1mI1tF8GXIUWIfnhl3eKub9DEGpqxXF8ZDmS?=
 =?iso-8859-1?Q?2N3HQ661VCyGXvcJV1PMmInd+R9gnEI2R/YdC0pPIyHRnDvKiiDze/8tty?=
 =?iso-8859-1?Q?qRHCiW4LYTUbxEOtHIE+uiYXgKLdZoj4h8WEWuze5eUn3d2MHGP6Oo6wJn?=
 =?iso-8859-1?Q?XLhbOW0UH2FEqJ2jhaTIrMHbBTo4pdzUnILOyX8gW6i0nhXOkEimfrfg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d90837d-5d7d-4443-7a9a-08dc3e23c9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 21:24:20.8106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLZASyqbNYmH1d86XD17Gwd95k/OcjPtjywoVl7CbtdzjGSMKvdjzky/VAsYoNcNqBjvbd9SCwxwcuZroMDOhd1dJXvG5ZPo9ZvYXUhoJdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6285
X-Proofpoint-ORIG-GUID: wiw0SRypZ-MiT6-AUR3dmgkPnCMx1jPh
X-Proofpoint-GUID: wiw0SRypZ-MiT6-AUR3dmgkPnCMx1jPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060172
X-Mailman-Approved-At: Thu, 07 Mar 2024 01:13:47 +0100
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

[...]
>>>> +};
>>>> +
>>>> +&tlmm {
>>>> +       /* U-Boot pinctrl driver does not understand multiple tiles */
>>>> +       reg =3D <0x0 0x03000000 0x0 0x1000000>;
>>>> +       /delete-property/ reg-names;
>>>
>>> This won't be needed if we can make the tiles offset in the pinctrl
>>> driver compatible:
>>>
>>> #define WEST   0x00000000
>>> #define EAST   0x00400000
>>> #define NORTH  0x00800000
>>> #define SOUTH  0x00C00000
>>=20
>> Hmm, I assume that in this case pinctrl driver should map all the four
>> tiles independently? Are there guarantees in U-Boot that four separate
>> memory regions will be mapped into virtual memory with the same relative
>> positions? Linux clearly don't make such guarantees.
>
> U-Boot doesn't use virtual addresses on arm platforms, it only goes as
> far as reading the address from DT, nothing else, so this is totally
> fine and is how the other SoCs do it.

For me it looks like we are depending on implementation details
knowledge. I.e MMU API does not provide such guarantees, but drivers
know how ARM MMU code is working internally and drivers depend on
exactly this behavior. But if you are saying that it is totally fine,
I'll rework the patch. No big deal. Actually, I already tried this and
it is working fine.

>>>> +
>>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>>>> +       /delete-node/ phy-reset-pins;
>>>
>>> I suppose this is not needed as phy-reset-pins also configures the pin
>>> as GPIO only.
>>>
>> Well, yes. This also puzzles me up, but for some reason it stops working
>> if I leave this node intact. Looks like I need to look at this deeper
>> before posting the next version.
>
> Possibly the pinconf defined in the phy-reset-pins node causes U-Boot to
> misbehave, can you check if this patch fixes it (there is a bug in the
> line "return msm_gpio_direction_input(dev, gpio);", it should become
> just "msm_gpio_direction_input(dev, gpio);").
>
> I had the exact same issue with the gpio-regulator driver and this was
> the solution I ended up going with.
>
> https://urldefense.com/v3/__https://lore.kernel.org/u-boot/20240131-b4-qc=
om-livetree-v1-7-4071c0787db0@linaro.org/__;!!GF_29dbcQIUBPA!xFhZe7DKgRbr63=
sirEJLuH-B0AnGs7jvx8tdJPKLTgFuZ3I3_zpVml7l23G-_vJO_JiUR-wUO4GMPJFcE-8p50H3p=
f7nbxit$
> [lore[.]kernel[.]org]

It is exactly this. With your patch I don't need to /delete-node/
anymore. I'll add a comment in the cover message that this series are
depended on your patch.

(and sorry for the mangled link. It is our corporate mail server doing)


>>=20
>>>> +};
>>>> diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/s=
a8155p-adp/MAINTAINERS
>>>> new file mode 100644
>>>> index 0000000000..03fac84f51
>>>> --- /dev/null
>>>> +++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
>>>> @@ -0,0 +1,5 @@
>>>> +Qualcomm SA8155P Automotive Development Platform
>>>> +M:     Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>>> +S:     Maintained
>>>> +F:     board/qualcomm/sa8155p-adp/
>>>> +F:     configs/sa8155p-adp_defconfig
>>>> diff --git a/configs/sa8155p_adp_defconfig b/configs/sa8155p_adp_defco=
nfig
>>>> new file mode 100644
>>>> index 0000000000..b6969767f8
>>>> --- /dev/null
>>>> +++ b/configs/sa8155p_adp_defconfig
>>>> @@ -0,0 +1,35 @@
>>>> +CONFIG_ARM=3Dy
>>>> +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>>>> +CONFIG_COUNTER_FREQUENCY=3D19000000
>>>> +CONFIG_POSITION_INDEPENDENT=3Dy
>>>> +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=3Dy
>>>> +CONFIG_ARCH_SNAPDRAGON=3Dy
>>>> +CONFIG_TEXT_BASE=3D0x85710000
>>>
>>> Being position independent shouldn't require a hardcoded U-Boot text
>>> base. Can you try if we can get rid of this?
>>>
>>=20
>> Well, it is required if we want to load U-Boot instead of hyp.mbn. We
>> need correct addresses in the ELF file so Qualcomm loader will not
>> reject it right away.
>>=20
>>>> +CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/sa8155p-adp"
>>>> +CONFIG_IDENT_STRING=3D"\nQualcomm SA8155P-ADP"
>>>> +CONFIG_SYS_LOAD_ADDR=3D0x85710000
>>>
>>> Ditto.
>>>
>>>> +CONFIG_REMAKE_ELF=3Dy
>>>> +CONFIG_BOOTDELAY=3D3
>>>> +CONFIG_SYS_CBSIZE=3D512
>>>> +# CONFIG_DISPLAY_CPUINFO is not set
>>>> +CONFIG_HUSH_PARSER=3Dy
>>>> +CONFIG_OF_UPSTREAM=3Dy
>>>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>>>> +CONFIG_NET_RANDOM_ETHADDR=3Dy
>>>> +CONFIG_CLK=3Dy
>>>> +CONFIG_CLK_QCOM_SM8150=3Dy
>>>> +CONFIG_MSM_GPIO=3Dy
>>>> +CONFIG_PHY_MICREL=3Dy
>>>> +CONFIG_PHY_MICREL_KSZ90X1=3Dy
>>>> +CONFIG_DM_MDIO=3Dy
>>>> +CONFIG_DM_ETH_PHY=3Dy
>>>> +CONFIG_DWC_ETH_QOS=3Dy
>>>> +CONFIG_DWC_ETH_QOS_QCOM=3Dy
>>>> +CONFIG_PHY=3Dy
>>>> +CONFIG_PINCTRL=3Dy
>>>> +CONFIG_PINCONF=3Dy
>>>> +CONFIG_PINCTRL_QCOM_SM8150=3Dy
>>>> +CONFIG_POWER_DOMAIN=3Dy
>>>> +CONFIG_MSM_GENI_SERIAL=3Dy
>>>> +CONFIG_SPMI_MSM=3Dy
>>>> +CONFIG_LMB_MAX_REGIONS=3D64
>>>
>>> Apart from above, I think this platform should be able to reuse
>>> qcom_defconfig as you can find most of the config options there. Can
>>> you try to reuse it?
>>=20
>> Honestly, the whole reason I am porting U-Boot to this platform is
>> because I want to run Xen on it. And to run Xen, I need to run U-Boot in
>> EL2. And to do this I need u-boot.elf with "correct" load address and
>> entry point.
>>=20
>> I am planning to publish and upstream Xen patches as well (once I finish
>> them). And it will be really nice if Xen users will be able use
>> mainline U-Boot to boot Xen.
>
> I would like to enable the SM8150 drivers in qcom_defconfig (for
> chainloading and supporting other platforms). But I'm totally fine with
> having a separate defconfig for this board with this configuration.

Yes, this is a good approach. I'll do this.

[...]

--=20
WBR, Volodymyr=
