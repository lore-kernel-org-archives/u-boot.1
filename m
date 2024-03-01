Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A00C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 20:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD07F8812F;
	Fri,  1 Mar 2024 21:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="oK4VOllb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C291A87DC4; Fri,  1 Mar 2024 19:26:00 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 993A887D37
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=97901b73a3=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 421E8Iv8021506; Fri, 1 Mar 2024 18:25:44 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wjvvq3wu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 18:25:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwJvTyiEiQR6dl8hDaBBrla/9SM5CU1xehUW24hThdOMOhkfJYqKFywSE5LSoItNAj+8jk0MNYeOr9Pfdn1EEdo/gnMMG1Q/awxnbaj/HslS9AO+mHuVfl9mtX5zmgFUPgTXqhKnbzw56HctblcNIFz61Gf3b5Z0vBDG1hfX4mAVylTT+PmDbsLVtarJ664K8YvO7tir/iZSkhVcuz5uE6m+qgZGdNRL9wYOtPS9CcJjcph+w7LgUbXZZ3ul/KIWgyjUPeJTq/BR5LHBPYZo0me5dCvZqD6GJJLrJOKE11JtcBh7exx9AZhbGYBtxQG/k2SBZGLl7ZvvVf4UeXNtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvQ3TMIW+/JDW4QQnU0p2xmqPslA3WuUyoOKZwZIyrM=;
 b=Pe4BaI6jGSvH4jOyCUGu8C6QN1AJtl4qjXlpsSzq5l29t/Ac5tYq7QTYzWXDzrysSzhSpjSH+UItXEkKSQC+M0Skt7sDgZtzSlRyp4IfpW/bshoHomtiiFN3uIWun65EOMHfSrzgcHzaPFub7wfg1lfYxbvj55AMp2rq0LhWzd0js8SNdWRZUqYIWb8aCBFeeSLaK97Lx4aiKfRtLW2oc+E9qrU7KAlOuN5rG/YjoR341rUh4XaeadLKEyD9sTTTTIMYvduiwKUKz4mYjl44+tqCVn4aB6FDW8hsRiLaIdNSq8pe3fNV14BG3wDFso7ykCo2MP3mNAAkOaPjaF8yzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvQ3TMIW+/JDW4QQnU0p2xmqPslA3WuUyoOKZwZIyrM=;
 b=oK4VOllbCLM9PlUHet8EKQRFO6cJzAprE5ZbDEkmPMdstPmI2E8IxS06d0q1ijz+OLZeNCsEMUvbefr+Cc9ljfNlP+8spAPnY4YrwzOi7ayQDmZpMzT7SpMe4mh1j4mwZVQyO4k0K4vCbTuIfuAXI+9PFQSGUphF/Y7fw9z9dH3Yi2Kp5AuAPuN/rY7jxN5PZAnEUURLoJ79/qcDkCHPcDhpWjhzr2yO/6AG/YjcLTRoL7rQG8JTs7TRT+FLk1S6zUnfh2Ac/HnEfYHO4zhHGT8mNVXqPBG8mqB33yTkeVNZz/8FMXJjUG4DlwlemCNqxEoKTUIFnaEGvTqLCyYNSw==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by AS4PR03MB8673.eurprd03.prod.outlook.com
 (2603:10a6:20b:589::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 18:25:40 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 18:25:39 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Elmar Psilog <epsi@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Michal Simek
 <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>, Ramon
 Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Thread-Topic: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Thread-Index: AQHaaxqISgHy6uye4kSlwIGnnVXBNbEjE/qAgAAemoA=
Date: Fri, 1 Mar 2024 18:25:39 +0000
Message-ID: <87bk7x6c88.fsf@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <dc97490e-4029-41e2-bbbd-b1351f5cf9eb@linaro.org>
In-Reply-To: <dc97490e-4029-41e2-bbbd-b1351f5cf9eb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|AS4PR03MB8673:EE_
x-ms-office365-filtering-correlation-id: 2a2024a5-360d-4023-a0c5-08dc3a1cff75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vM9e4r7e+KDRudrFn4cCUFQhwbjgfus33BsZSYs4xVNlCa8wCsL0ZyxsacszRldUBAhQNLOk71PHtPeMaBzhVKJ47+i635Lf5EqrAHyVtert/ozvgr2cG5AEBgU2faKAsfMUReLv9od5mOr84vHbDBdzA+z38F9Rbksx2mBzubd/FDvvO/RSSK31Rz75r+8726InKUg3MMIrI1I27mWbYznXbGTkWkoR5f6BxJmFzk7B0YL9Ue3AjcHFVq1iFRmwPfzDc7CpjkM+MQueB78GMurMaJd9z+1o+cQXwyPU18r3eT0cfFMiHRqGpxr9KJwdxSFZ4xO2Nh7byL/3Bp34zx9ntw1ThthJ1aa2ycuOHQfcpinflFoSxaK5T6HviPNXgZPGjo1+K86pPP66xkxk5AQzKKGi/yCMj4ziRBYr5zeH7C8oJXOWbHnvlq0eGTcfhZju3AJWVTb0qh8KqYOt0l9q/j6vmEeOzS2VSWpz347dKKjsmPLMNyb619aA904ElqdO+jsxNQMySGx+rYLZb7KvaozIUqK0yxBqkw6BkfQ+Isc0sxyTkBlQQhcESGDqQ+jrbfgxYwuU2jJql3kPh2LddDUP0HDSqU6f7LJ0y68DlWwgxJDyguC5SABT1N7NF+dcET/29h5repoPlgp7km8dKr72veTWjl0gGsGV91fGdPivGWmX5QoZ0Gi73HzlRQmZGtZtW3jGt1iLIqVLxvjhfptUFWsXsyu7Zi8fp2w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EKOaxIN6sRhR2SVLhJJ+ValPiZw/Vxl0HrQdsw2NGTrbjxaTwyH5V7WTSg?=
 =?iso-8859-1?Q?iajuEMtGrtX9XNPbDXlT32RZTFZhEO3JpK5kYK96H+bEw5kJ4qFA0h+UPH?=
 =?iso-8859-1?Q?KsphV2Hc80mwNQ+2/rCFHdArM4z/OVhnimwNpOeoyOEchrn/DrTRHzsZ37?=
 =?iso-8859-1?Q?WjYs3fIlDtqpFsRiHkXrms9L+QWssPxYxl5Pi4jDQK0zO3EjLMKcGszEiE?=
 =?iso-8859-1?Q?ujWP3fvjuz2MaCj0v8vabKGjFTrmQwQWIgKXx3cmGWi17H1nAIGLeRyR15?=
 =?iso-8859-1?Q?mLR0O1d8CKvtrdBa4L7Q1YWMAQeUqFNXetGxyanpp0lTRjEYbRCQLvgxYy?=
 =?iso-8859-1?Q?iP6gfOB5tS1DojCNASDIsmBQXFIkMjNSrHK40IEP1CIaBJfMrNu2Q/aahH?=
 =?iso-8859-1?Q?uwZZA5rAH1UK2VMkWrxu13KYUkRfhOrC9psEyomrm9nMljESng41kscZ+g?=
 =?iso-8859-1?Q?AA9kDz6RZ1r/4Z8XaEk+4rJg1QKyWh9kGuMcXFjrgy7h6+ZKaf9KLKbHjV?=
 =?iso-8859-1?Q?rjwOD92fiPYUkbNbbPh46IFDnj/d2G7TOTxL8uJecNYk7xbD2idzSk8oaa?=
 =?iso-8859-1?Q?0v3d+VaJISrAnIdO7rrygm0OCH2sdnTVE9R++o7LF+Q/dEzrocMh5kxgwy?=
 =?iso-8859-1?Q?EvdMubo6MIrFCgIVMJPohf6r4Am0PIMpl4L5gbRltl2kxclTLpTLmt69Ly?=
 =?iso-8859-1?Q?h2CSTo0lFkYTjvRdCqG2qo2pDykmJJnnGfkKvoext/dwcL0KANs8OAElwy?=
 =?iso-8859-1?Q?f2+1FmfK5rEk6vLICRi7Qm4YFW6XAlvFixWWZTVEOV2kwdsO8GvWVZKFoN?=
 =?iso-8859-1?Q?FC/EynDqruCXNRFLWf8KYN2oGDT193hpTBnaAuEbXj2XVYB/NstJM4ONXR?=
 =?iso-8859-1?Q?cMwcppgbLKDR2/NWVrlwSQx2KXuNmGy0Zl40AWNLQBO/K7fbzN0IvDSqpz?=
 =?iso-8859-1?Q?PEdKv8Y6Qy14LK6oKL6Ad6BqVG96pF24RanP2eD8JdW1bPp66188IKDnbk?=
 =?iso-8859-1?Q?9leyqcZwavOgL+af5PkeKX8Vwyz58AR+/+H5poSNhtCpyf+bNBE4rJN0zp?=
 =?iso-8859-1?Q?c3c5j/ufkjJi6V4tnqGd4iFl9nb/GWR1FzSNFzoWRMZeeWkMdGoFPOW4Ga?=
 =?iso-8859-1?Q?zB8yQc42lc21etlqMr+BIxNHfelWyzJ+AxamIDQ3f90L0e7HaYjfIU5pKE?=
 =?iso-8859-1?Q?6ZUIHprQjV/Gsyug6XczV+duMkuWc40NWq5EE7JpjIUdP452D2EZnmXhZs?=
 =?iso-8859-1?Q?LNiTNvu+3NqoXqHGrxU71BncSCdvmYS0ivws9dOut+eFt1wPTlCOQqTPV5?=
 =?iso-8859-1?Q?6I469hyNxvtAe2FArKDLho5iqQwez34RM9Sx0BXXzcSZfyZk76yFBHIhlP?=
 =?iso-8859-1?Q?DdSZ9mV0LhoyaMS7rSfjMls2gyJ9t+GgWHv93K9xW6ko8T7eP0iTiTVkgI?=
 =?iso-8859-1?Q?M9K0ykgwpWqqvu+1FIuu6uR4sK/w4lkG9fGsUzPnbL/BwxUg5FUiaLVuqq?=
 =?iso-8859-1?Q?LrlcqW1CwlYbf/4F57CXeRozeNobJjgarrB9rj923XgmemaliOPLl1Ej57?=
 =?iso-8859-1?Q?fjhKfBjEGVqQWETj3coyqopDU3gcGejwINGfUlGhPkDdU0aWo0dJIVrWN1?=
 =?iso-8859-1?Q?TATyD2XEow7tZTFmoo2tMDwl2KBiPHPPocokl911kcxrxuhNu+2roNYg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2024a5-360d-4023-a0c5-08dc3a1cff75
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 18:25:39.8868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdndYRDddAPXg0ftqwhKX2R2SuucwzoDYm8tBcVhZIfexuU7y29dCdaBsGZLDqBGlm5AmBb+QGg2kxX8MhOr0VaK9VQ0q0bkPJzgUrVJ64w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8673
X-Proofpoint-GUID: 1ypyLNuwQJoalTe3GXxFwfEnFdd-HqjT
X-Proofpoint-ORIG-GUID: 1ypyLNuwQJoalTe3GXxFwfEnFdd-HqjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_20,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=282 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010152
X-Mailman-Approved-At: Fri, 01 Mar 2024 21:30:21 +0100
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

> On 29/02/2024 14:21, Volodymyr Babchuk wrote:
>>=20
>> This patch series adds support for Qualcomm SA8155-ADP development
>> board. Main motivation for this series is to allow running
>> virtualization software on this board and U-Boot is a good way to
>> break Qualcomm's boot chain at EL2 with more convenient ways for
>> uploading and running the code. With this patches applied it is
>> possible to upload and run Xen on this board. KVM probably should work
>> too.
>
> This is really cool! I've experimented with this on SDM845 and SM8250
> but never really did anything with it... I'd love to take a look at your
> Xen branch?

Honestly, there is nothing to look at right now. I just implemented
early printk serial driver for the qcom, made hacks to the device tree
and trying to boot Dom0. I already expecting issues with the GPU,
because it has own SMMU without virtualization support and Xen already
complains about it. So I had to remove it from the DTS for a time being.

Anyways, right now my Dom0 does not want to boot due to some issues with
UFS. I suspect that some power domain or clock is disabled or some
other bit of initialization is missing in the mainline Linux. And
reason why bare Linux kernel have no issues with UFS is because
aboot/xbl does proper UFS initialization, while in my case I am skipping
the android bootloader completely...

I'll publish my work when I'll get Dom0 running.

--=20
WBR, Volodymyr=
