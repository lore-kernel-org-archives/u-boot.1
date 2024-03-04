Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA167C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5652A87FDD;
	Mon,  4 Mar 2024 17:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="oGsjjHDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B73C787FDC; Mon,  4 Mar 2024 16:51:42 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F8C875FC
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9793f3b8af=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 424FIDgt004244; Mon, 4 Mar 2024 15:51:27 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wnefxgtyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Mar 2024 15:51:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhDj6XKa26sHOXWIaW/zmBqOaePkvPOHVQEjkFfAoJEKgkNVZ+6kvtnFitB4U5f/1CFYGPxaVDba+K0F+hI8VFMdCsKx6FKfaVT87Z6Ai1XAKLsClEei5yvSSriMcjljnr3UD6EuSlCvTK3Q4ANLIYlYoOyXJ260E2g1GVMbO3aWxQrEoEYANYHd2zWMWhJM0lioiL3psmo2M9k+XMeNQi30qD5jcI2hbpar5RvwgNGmXVPT20dcetE/QW0qLLyEYeNV0V6B0gy86e0VOpmeTnUUlQLlOlmun1HrrLKTdHKsPEzKTMnlJZ0nIOocd3MG+bwqaigne0x/ysgJS1Qb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqH/6HCagOEIPMT6FyYgmp8xkevhCwQPHuht579LsxI=;
 b=lOU3EJqAi8tYvqCxFtpCVpu8ESPTRq5ob2Q2OT+HDStvaeq5yhIkrn2Nb9LZqhwNoyRUbOqzyekDTZ9Ej35nNFVQARyPVsJFeQXqXIg2y2gQXe/NghpH7MppZ2v5Fo1cIT9KZ8etxdGMBPp31jxjHxedox82Y4AeQN60Nfh6F3UwRTQ3ZoGhCfVKPWooG98nioPaU72x9xWxDIrRc29oiF5hBkXooC/ZFtaaglVfMOKpy0gNM4fmZ1C3h1SFLILF2uSzkLajpj4yIHEbTMR7U+Oq2qjmz15ir/5gBEYIJnTQg1HKbjy9a6BUcrIJN3QbxaSWdf+vLdqyTeCbrq92FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqH/6HCagOEIPMT6FyYgmp8xkevhCwQPHuht579LsxI=;
 b=oGsjjHDp6xoROWX47dJR5Ic6PC8HVTlvq7ss8Wy6GnsZo+oV5LiiSmSwcplxjq6w1sMXsBNL0qaj0B8S6IF3WfPxpBhdQZ/pc/Gu3wQTqUa0Y0knQ9rcSJDJ9bnJh3FwPT8xWKe7RLWQfSdHTIb4YDjQfL8Uiu/SYbSX9s+uV6fhM8OUodbTHMX9Fd9Zaku84VLXqXnXM70N+3WUgyb27fx2YvTKlrc/6VA6NVl+O9cEasX73rM+6HpnN1qITmGM4z3fCDn7bm/PM8jVUiSYxZ16o5umyFEarwZ6XbJG+5hnfs/88nunlB5gopbb4RI2OdNkFvr4ark2k+VRcXljaA==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PAWPR03MB9690.eurprd03.prod.outlook.com
 (2603:10a6:102:2e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 15:51:23 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 15:51:22 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Stephan Gerhold <stephan@gerhold.net>
CC: Caleb Connolly <caleb.connolly@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Elmar Psilog <epsi@gmx.de>, Joe Hershberger
 <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Ley
 Foon Tan <leyfoon.tan@starfivetech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Neil
 Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Thread-Topic: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Thread-Index: AQHaaxqISgHy6uye4kSlwIGnnVXBNbEjE/qAgAAemoCABGilgIAAIZOA
Date: Mon, 4 Mar 2024 15:51:22 +0000
Message-ID: <87r0gq3shy.fsf@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <dc97490e-4029-41e2-bbbd-b1351f5cf9eb@linaro.org> <87bk7x6c88.fsf@epam.com>
 <ZeXN7EZHU89qS5PF@gerhold.net>
In-Reply-To: <ZeXN7EZHU89qS5PF@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PAWPR03MB9690:EE_
x-ms-office365-filtering-correlation-id: 581c8bff-3d91-4ccf-8ba0-08dc3c62f10e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFBwTKu7hJ++K3tkPBsxV580yZBqBwY/ncZpsoKbpJ91R/3/D3aH6NM/ec9Jm7P7vCIy4fGmdlOqr1wBqKe8yA3TT2vfXwM7UL4dtoEILzBRsE6OtAY8tLOoY7kYeXSxi4m1ibpp9Yjxj3CUvtg5AIKAH82KO9J86FMkK75YFgOB0TSQnHJrdLkdtxl4tzrMWfh60Lrf/K0lO05nICR2NjNvkgfmB9+0+TxB1NzzWRJ2kowY4xHhQNS36/DfNg1p6I+jLZ++tbzEaz4eP+R2MqXi2ZbSFqr5c9fnOtfuv1P0n7aS0azmqr81c10dfLv6doScSrTLARxEl7xUsPXOh9781YOKzSy3Qj0fswMnBp7i6BxiQcUIe0UCJKOIaROzS5iUB/orIxbONmEzaLW96qp7RvCa2gsS7Uf75/Pt5GWatBP0S2609bs6rmyV4u0CgAt/gpAjXfCJ/T9mQRXBOIrFOjveW5tANQRtimg+vVkCLPLDcPCOmNhwju6Uu2wxKY0aUHfR8GejTIwj5q2ix6CG7GJo51USemHnm1c27hiGVHvhoB3gdyYzpzXfLDtRBOZUZDuhLggT3Z9uEgiVtZiX2EF4uU3htmsaQWl+I0Ur7Ww7tn14mDB7hs+0W/WatXzRDd8J/VVRIBKa2G4crdKzJA0zhEnWRn/eLKECKd4QgWOThZmJ9CuLXqEa9f1KsnuMkQiET3bj2OdwI/YkgrSy1hKzZPQiDJQV8EJP68Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MMETnsPIAXys1Vd3h3LwYGarKL7bSPMuRlXQUtXMLStgIQOeGatUP+1Naw?=
 =?iso-8859-1?Q?e04yWjY/r05LM24qKcNQmYhr4Ny0Eexs/+55HHUz2kVeukZDdY/HfXdi/+?=
 =?iso-8859-1?Q?7LnIK1Y6PmnA4mH5xuHIHogjr8PjTjACJIhDUqmG3LQO/5NR7WAaxd7GNw?=
 =?iso-8859-1?Q?jMqqGQfm4F0MBjc5KCDT8tLFhynyMkViosy2s68A/Pils18cKEiw87btML?=
 =?iso-8859-1?Q?KXVroWNPmMXXwiKwvSP3CWiQvqFbfY551VVV4YaGcxw/jSSqaY/ON8BHX7?=
 =?iso-8859-1?Q?nIFvXbCA9w61oSKKJZjjtGwi74WABDHlnbqfjmSk4jOLpzmIIM057NKXc1?=
 =?iso-8859-1?Q?LsNhBMpw9e6SsIuWbR/Qx0n4cIFHF+OEeSMOxbj9rJlYk12dq2WcmiojV6?=
 =?iso-8859-1?Q?KGEsk2CKiuBA4naOcwITVqeo3+L4rLrRQbZ1HPdJoirm2cWVYZSVN5f8Rb?=
 =?iso-8859-1?Q?rhRXXcCjob9Rn/mdCihKL5hNfGfYyn6qdMHmxu+fECKDQZ+IEtnhCtxkK4?=
 =?iso-8859-1?Q?k6wA7dN3aEEqMoqHYulpPfdtnceYHxIFs5QErtgXQRHoD7eRxq2D+iSwYR?=
 =?iso-8859-1?Q?6L08p06GzAZXHW4BkIE9GZpWJpXaIN6YPa184ytuv61vp/sCBv2bkpMQWB?=
 =?iso-8859-1?Q?HMVWv9vpGWLGTh/bC3pDkwwdi+lXz/ctHvgF6HdtctYCLooAPPOEC385fn?=
 =?iso-8859-1?Q?0wQySEi41wgHhY4Vx/5A4BlWTPPLhFOeSxEn2oJD3yPx0y8dPLp2V/atrT?=
 =?iso-8859-1?Q?X76bWYe8ee9/mRZRWQcH1S4x2C4JYPvSvNuu2fN9nDfhr+uMqLXeFOsQzK?=
 =?iso-8859-1?Q?3bgYySyR8/MSWeYBzsfLGg/tqCxr6+ewxBMqHY7DGkmuEXVl8T758sqwJL?=
 =?iso-8859-1?Q?Ah5OH8SCe8c4XXgVKJQz49vzgop3RbIZ9elswJzl8gEP/d9uALmw4I2pzd?=
 =?iso-8859-1?Q?+3x+vd3RPq59iIPOHI07eKtrraf5I9PyfmvmGjYzJs/TrbmkW/xCTavNrX?=
 =?iso-8859-1?Q?jDUG0B/dDfoEMSorlz99+igCQ1vj5xz1WhT4+zVccbj0wMds+maVtsW7yE?=
 =?iso-8859-1?Q?Q8xJhd1l3E94L0ZrTQdw6jKslTb3jOLTWQcA4mWz56iKMq0VPr208gpXPp?=
 =?iso-8859-1?Q?LBZc7xI+JhcUCFw3Nie/n0GcdIV0vRB1yv8vkK6nJzN8DZZ3z3dp0r7tBQ?=
 =?iso-8859-1?Q?y8e/2CwED6Yh63i0dEzc5wPnsN0brHPcK3nvHjXx+2JTM8ITcDc2dBu0xf?=
 =?iso-8859-1?Q?snmgGp0ECWQt8mHrIsCu0EPPzUvOCMQEfwAXvi80UwMdz1+ilKbyStzSrT?=
 =?iso-8859-1?Q?5UyhLW6vXT/SfBYosEOh+VahvYMF5sxue/OaWJUgsDRMLCt5H/RxwbbS3N?=
 =?iso-8859-1?Q?imUHw2k/aD/odTjxLco7iwy+94FUgY5ZbSsWB3IC6SiFETg+HBm7/fvUui?=
 =?iso-8859-1?Q?jfP5TfNYJiQ788Ww+OhPClXTBjMQmMgPdOY+DXC8RsI8+FMJOhlh3Iq0id?=
 =?iso-8859-1?Q?WO8HJYXiYcPknjFnECBcvzKAijsebdQKEDU43SGeHIy9RrvhUx/IvpmKJ4?=
 =?iso-8859-1?Q?NOJKVtsINebefx3BkqeaUMLEUiKd74kfBTWka5ssI2lv69MoDBKwyM+U9H?=
 =?iso-8859-1?Q?NVAOehRjhLG00+bVLDQ9jQusMj+ZXfvWqSqhtzjFSmLvsRZVtC5sS46w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c8bff-3d91-4ccf-8ba0-08dc3c62f10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 15:51:22.8247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLZVRCyfrywXxC1AI5MUw2CsCusAGwFYNUuI7utpaiyLwexzSaC9ZMzO4y+28ofp5bfNm/uLoHTqEzcH7CvU/+qYpce0VwILaIL036+ughk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9690
X-Proofpoint-ORIG-GUID: c7eNr5eV2NNHbSl0r-qQ52DxkRj3XyRs
X-Proofpoint-GUID: c7eNr5eV2NNHbSl0r-qQ52DxkRj3XyRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_11,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=662
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403040121
X-Mailman-Approved-At: Mon, 04 Mar 2024 17:30:21 +0100
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


Hi Stephan,

Stephan Gerhold <stephan@gerhold.net> writes:

> On Fri, Mar 01, 2024 at 06:25:39PM +0000, Volodymyr Babchuk wrote:
>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>> > On 29/02/2024 14:21, Volodymyr Babchuk wrote:
>> >> This patch series adds support for Qualcomm SA8155-ADP development
>> >> board. Main motivation for this series is to allow running
>> >> virtualization software on this board and U-Boot is a good way to
>> >> break Qualcomm's boot chain at EL2 with more convenient ways for
>> >> uploading and running the code. With this patches applied it is
>> >> possible to upload and run Xen on this board. KVM probably should wor=
k
>> >> too.
>> >
>> > This is really cool! I've experimented with this on SDM845 and SM8250
>> > but never really did anything with it... I'd love to take a look at yo=
ur
>> > Xen branch?
>>=20
>> Honestly, there is nothing to look at right now. I just implemented
>> early printk serial driver for the qcom, made hacks to the device tree
>> and trying to boot Dom0. I already expecting issues with the GPU,
>> because it has own SMMU without virtualization support and Xen already
>> complains about it. So I had to remove it from the DTS for a time being.
>>=20
>
> Did you enable all the clocks/power domains/etc for the GPU SMMU? If I
> remember correctly it is off by default and all registers read as
> zeroes. The SMMU driver could easily get confused about the capabilities
> of the SMMU (e.g. the stage 2/virtualization support) if all the ID
> registers read as zeroes.

Ah, this is a great idea, thanks. I tried a quick test by enabling only
clocks that are provided by GCC, but looks like I need to enable GPUCC
clocks as well. So I need to write a driver for GPUCC or at least
figure which registers to write with a debugger. I'll try this later.

By the way, do you have any suggestion about my second issue? When Linux
in the Dom0 tries to access UFS, CPU gets a secure interrupt and hangs in
TZ. I had the same exactly behavior when I tried to access EMAC without ena=
bling
clocks and power domains in U-Boot. But Linux should enable all
prerequisites for UFS... I suspect that there is an additional
initialization needs to be done, but I didn't figured it yet.

--=20
WBR, Volodymyr=
