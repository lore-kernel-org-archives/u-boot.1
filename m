Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0922C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C479387FEC;
	Mon,  4 Mar 2024 17:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="GGxW3pYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C436387F9F; Mon,  4 Mar 2024 16:56:12 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8DF87F9F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9793f3b8af=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 424FID1X032312; Mon, 4 Mar 2024 15:56:00 GMT
Received: from eur03-am7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2232.outbound.protection.outlook.com [104.47.51.232])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wngtjg4h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Mar 2024 15:56:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYA+drwROTph7a5govkxIoI0O6XzHPJQ9VrvfieRxkz4zkydkyOwMNzYSQyPj8MNTlMPAFE+uqIPxJbDWYeHU0JWFwEOaZ/BZ+lxacJIAXrUzpoMlpOxz+p3FFAnALVHOrGvCFFigyoLUGkk3AMIPJpvk4TzXVkUl0vO+jiJF5Z1JQjSsZQtqgmK/ZWShrUZzmiCouRu9B+XpolXXNwJ+1TIRjR2lV4UwSyHi40zddTRFz7kBFVl49QhJkmi70eWPfd8IAUM+bPJGTKJhxyOxhrh9HJmiFlpIA0kckNggWh95vdTZwD5dWNqw9HiakkbJPIY7zTKWCoBuVywquqzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS3SZLvwnEOCUE/xslieKg5X9S14zFiijXhLs7rMg90=;
 b=HjJDLisy1eJ1BqCJQ2hmRojaovspngJEW0yLKhHhdRk297ilG/ANO+LQSn6j5ihQGjxH1DHMsWgnWXYItmdO40Y1zhPSoPPxjXrMdaK1EZDVF3Qmnji6ltbwsrVnCnHIX5OA7Uujky1UIu/aWPahAmjLGDzKGN7JQ7cCXYF0Y7FkXycsN1eKB/4Dd6yzFZuNz76ZyfP8JtYAhRyEgvxVXijwB6gPxBr5qrHFty5eGOtD4jODLFO0YlrQp8bUqvIK2xst//9wO1S4P1xmSvrox3cog9aOaARbghnVeawzhqTmrCToW+Tz9RQXuGNqCrYiaAvu9tfUDa/PLWtc/k5tmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS3SZLvwnEOCUE/xslieKg5X9S14zFiijXhLs7rMg90=;
 b=GGxW3pYa94p5BAjAO6319Se7GZhCjPdn0ClktshtqKxc79gOdamNAjdYhY3ZfxRpizU136LCvzZtb3LX2/JHcA41a1X/6BsVIXykKkTH49PRZFVUdo+LlHKjzR/RtI04PNIQcNq9Wcr29k1D/tJogCbPn/vBTHcSBa3O5ZVAqqMfXqZO1lmG6L5yzHSVutqjRrv3VtYfqg+P1UGtoQFTcYRkcZZW5uVI2pvtVFyQTlShVywszISlofV4eI98jliCJX/QY9xe1hkLrihBfEF/fUi1ee/uFGGg9on9VKO2017Yq6llzmlxM4+9YasyNvDLwGz959wJvqnLIA5tS2/cGQ==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by GV2PR03MB9524.eurprd03.prod.outlook.com
 (2603:10a6:150:da::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 15:55:56 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 15:55:56 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Stephan Gerhold <stephan@gerhold.net>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Caleb Connolly
 <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>, Neil
 Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Topic: [PATCH 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Index: AQHaaxqK+jMULOxtT0+c/deQ37vtVLEnnGqAgAAlBYA=
Date: Mon, 4 Mar 2024 15:55:56 +0000
Message-ID: <87h6hm3sab.fsf@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-9-volodymyr_babchuk@epam.com>
 <ZeXO8wOAi7az0kgN@gerhold.net>
In-Reply-To: <ZeXO8wOAi7az0kgN@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|GV2PR03MB9524:EE_
x-ms-office365-filtering-correlation-id: b1e49574-d10e-4a8b-fbdc-08dc3c639457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: er8HuP3vqNug1D9n6l3xsXcU4ed5TOWa+93ipTRxmX/Nd3tuy56Xxa6O7N/ksunPFVVec0QzIAnxSbO1vRWLBpUkPC9M474CCghZA2APX94v0cmHdOxQRbGZrRCdeUXW8sWw4HU4M535vBKrccgemgGn0M4VlLnMnvPJXuwnEWaAxVjVSPEHUEoD1yZRqb/gCVGDfrwljFV7h7sM6wLeIRRWZuLJYaQpAayy19mqneXdxi81Icn8J1szas6bkLXGEgM7GzZz/bt4JtO9kfKJBC/BUfsNySJzZee75CI82T9hgAJX0f4zCUDeGtYPWiASa8PXa4zidQbaEinEl7Zr2YwSdrHlygUoBdphBR0IhaYON2gQaFy9DXs/1IaFaicgsVnggAojT7GImcb279Cd96j/eF7+7gml4vQ1w516eSkg93Hgw6Be26ax3KjbfINiYq/KI0iEL5/R+leFDFrTm9+97aXZndxUjWc5wadTrPovai5TkLqz7985U6rQZFcIRirS9xWBlRxSZugmEihrxA0lRM0SNlh07IbMyYQ7199PJjSRSPa54nWXmB1Zt7dImIHgXY9HBINDbjkb87Pnl0Udp6T8AY411YgtdGIv3iymvGxgiaJ/oJQa7uD/og9mxoD9pB3HILdjWQRItXRDCoToBw60bJJFNlbyfT6tZnw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uw/2DKCaD6zAarlQ/Tj/yiSwlNQ0xJuYLitsuO1cLVKM0Ar9byHOsJbQEF?=
 =?iso-8859-1?Q?uZeJrlLgcCQeD7SHXMJEZlfU+Z5HhK7BI93fykt1Lv5xTKgLax9HjZyT3B?=
 =?iso-8859-1?Q?/dWJL7S23McGNzKnpaRh1L1nQtMXLcVdugbGTyNWzsmbuEpYJfs4WVUEHO?=
 =?iso-8859-1?Q?x0R6K9pgTsn5eiPI4OPRhlwUhyBuMq8JgulNguwKUiwlr1b44fPxABDRw1?=
 =?iso-8859-1?Q?ajLOt3ndUcyhB8tca9XynXjUA5w465rVIfah7l4FYzk28Oa22q+JiDcjY2?=
 =?iso-8859-1?Q?tl8wJyWvUsR38wCJ8M0pEtjO6jH7P72pN149h3XUVBUMszJG6eFnwkk3pe?=
 =?iso-8859-1?Q?sYO2N4BrGrAGUcULQMpVYFfatrMZpHS7pvZ/t4l11pgHBzKo9tt05WguUs?=
 =?iso-8859-1?Q?hnm7e+jrHc9AwZJijyW+AVuMxc1rEFcF3IRzrlFDhqIyxbQ5wkOGCQExdn?=
 =?iso-8859-1?Q?3oeaK8WkQQGDq9zsFsaFSaBlO87WGuVILtiYWFLecmqTdVyk2IgPTfl/Y2?=
 =?iso-8859-1?Q?/bknqjWeUV2i4DY2a6f+leNPgyi0rhzogDblUWjJn1DLy/VyokNRizaZXi?=
 =?iso-8859-1?Q?c51CnTIJWWTPxw3qw+rGgfY+5XMzyu7Dm31B8kMPRQawDV9pn4oUcaPupf?=
 =?iso-8859-1?Q?2hcoi5REvT37DUC4Etr1cANCTSMjQbirtUhXZFSiADtKvN/s9QRmlyDpPI?=
 =?iso-8859-1?Q?E1jA1mBMSG30UT/jVuNBT7Eijh/QZTOYP1ECZf6QZ5r9A6+e9LqWtDPhSV?=
 =?iso-8859-1?Q?wG7PG+NaseeUuv5Q+J4fRPBlG6+WDiGeNt6K6PinXkmChe219v4PRVylZZ?=
 =?iso-8859-1?Q?r4mfogBwCm5bgKbBHAYlYy5RD8pvnYnppI8FGHTubDlYjmqfvhzqr3vPuL?=
 =?iso-8859-1?Q?4bHpl0pR4Kg/QmSsXwdodSDXYq15/cAmXQKb1/zpaNRPoCgHMeUXmGsF+8?=
 =?iso-8859-1?Q?qsGCaoSIxEH/ht0nXguWm6G0MMJUrheE63sctaD5RncECEkOZm9by6e0WO?=
 =?iso-8859-1?Q?dQBTxLpajBAlu0Tle7TuG9SPff0XMm4lpr3/wLeJH1s4Wr+OaKcNYmKTMv?=
 =?iso-8859-1?Q?eJkPpGTqUn+C/NWigWXILICd/AI7/8klyXcdsNAAsJ+5gZxuGszA2imkC9?=
 =?iso-8859-1?Q?NUGRnWQIYE225RDPAktuwrtkfLIU49V1Y4232V6r3MJEZfTsn0o1cEBDFn?=
 =?iso-8859-1?Q?R4qoYzBjFZpJqBBiv7A4FPBM04rcq1PixsaSipD3ctzKQ4HeCPAT1fQc+H?=
 =?iso-8859-1?Q?hCoky9BJjUBAQSR5B24KjAX7sP4xAC42jfyOLSBGonx2buJJHhwrp4J0lV?=
 =?iso-8859-1?Q?3V7w5iyJ8XORVAyNurq+evpk1oZ/9hdWIsAbXhMRIxz9mr6nbwshb4ASFj?=
 =?iso-8859-1?Q?xifjJHuKaevFEaScNqAjb5LcutptWJK6AVNJC5muT4mWlBUS/REGDSUc+c?=
 =?iso-8859-1?Q?z3Ys6p+oRRPzkhK7HKStdUa/aBKigUgYHgII0McSIREWbPCL/vcF1NVwZv?=
 =?iso-8859-1?Q?egozTVN0e59acEPLuNWE6usHyoU0f4V611qPI3tqjaM3ffIUND3parqrAP?=
 =?iso-8859-1?Q?Jei5RVuCFDLzQU8bMfdSK9aYmqtp+8qCs6EJXTcXpnqPsnfagmswrnP7b8?=
 =?iso-8859-1?Q?sTOp/XWJCTNMlTi8OmiX6PBIPB3f4BEG0QzQq5RvaOC0BQPhNIMSSG2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e49574-d10e-4a8b-fbdc-08dc3c639457
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 15:55:56.7402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBC/ST6wVTaREC356XX3Lt0uCRpe0DC16j8jyM6eax/2oaJVxnzMRMk8vvshv/QVV7/txgfYKLMurxuO+wAlo2JTcJwOy0cp6SvIWJBaeVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9524
X-Proofpoint-GUID: 1FD_3S7uANJCTq-2DyuG6c6YHix99sHa
X-Proofpoint-ORIG-GUID: 1FD_3S7uANJCTq-2DyuG6c6YHix99sHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_11,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403040122
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

[...]
>> +This approach ensures that U-Boot is booted in EL2 and it is possible
>> +to run virtualization software (like Xen or KVM) on the board. You
>> +must understand that this approach breaks Qualcomm's boot chain. You
>> +will not be able to call all subsequent loaders, so you will not be
>> +able to use fastboot for example. Use this approach only if you want
>> +to experiment with virtualization on SA8155P-ADP.
>> +
>> +We need to create ELF file from the u-boot binary. We can't use
>> +existing U-Boot ELF, because it does not include appended DTB
>> +file. Easiest way to do this is to use ``create_elf.py`` from the
>> +following repository: `qtestsign(lorc)
>> +<https://urldefense.com/v3/__https://github.com/lorc/qtestsign/tree/cre=
ate_elf__;!!GF_29dbcQIUBPA!3iokDDZXQGZNS3GK2oGM-SU5Trj8ZSmx5FY-uvFKY0LDzDLh=
8LSVkBNS5r9QX-LGFKObs1tNmLdELls6iGQPZ3Aq$
>> [github[.]com]>`_: ::
>> +
>> +	$ python ../qtestsign/create_elf.py u-boot.bin 0x85710000 u-boot.mbn
>> +
>
> Have you tried using CONFIG_REMAKE_ELF in U-Boot? That should
> effectively do the same (build a new ELF based on u-boot.bin with the
> appended device tree). The Qualcomm DragonBoard 410c port is using that
> option to solve the same problem.

I didn't knew that there is a such option. Looks like this is exactly
what I need, thank you. I'll include this in the V2.

> But I'm glad to see that the ELF abstractions in qtestsign worked well
> for your purpose. :-)

Well, I was surprised that pyelf can parse ELF files but can't modify
them. So your tool come in handy. I was going to make a PR that adds
this create_elf.py script, but looks like we don't need it.

--=20
WBR, Volodymyr=
