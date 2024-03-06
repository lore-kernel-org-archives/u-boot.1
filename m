Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F62BC5475B
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 00:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C30AA875B9;
	Thu,  7 Mar 2024 01:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="lJNoDmfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE3487663; Wed,  6 Mar 2024 20:15:13 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56CA875FC
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 20:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 426HSx8B003961; Wed, 6 Mar 2024 19:15:02 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wpvx5895a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 19:15:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKa4GkZs9+xluEj6rkPVvs4Q+menHTxGllEjsTdL/ldN3rkRJhVYS9sHV1Ow9Irk1FffmrHMaL9EdE1EUGvAEof7PvKsewbyUxL7JWAeMPECGYW9R+5S1nmoZtRs0Xiviz6Eey6wGQx8ztOYV6KYYINVml+cZAN+v6CpGPQFX6GzTKpFNXDeDBynTx0sJMtDXJi0PmD+R9pmfVdfjG2hjGNlyNtS8u8ranIDlwvMjaOpMmgt0oq1HnCmfdr4cmILsg7g7WVFjV7eaaA7ftvNC4e5oRt2r4B8RAQqyhJU4X16xsHUFSfxoNJPZ92sm1rKNEm8ss8xcz1aj/5c3YBjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyGeLN+RnDeVHg3ReVKQErd74ppkupW9qdxLRDo7EP4=;
 b=nXogvc1140C/itOrjhYWnJHJFLYuZqR8b1YLaSV35FTWSvyvYNc1Noqkgi93gxqpH9IaiL/g8btYJ0atR/R1prbqd5WYWlRNAZQk+NRzKhkTr8aybp2tlxr3InAhrcJ/sUXpnH6nj+1pE4djiEivKrJQp2bhVeZWav/SCaE1OSSJdmF9vUh5w6beHGCxBoKTcv+8peC5NClAD7Z/Zk7j5MBV3LeSe1fQrgINU7a+umQmoINH18DVnNNXmuJHWD4+lbgxG2LHaicudoo2QiG9q6h7ZBVrBIzBjoTezZmj73yeIOUuk1+peuazdHOMtMl0vjlLLuYqn6eLxrpq/2wcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyGeLN+RnDeVHg3ReVKQErd74ppkupW9qdxLRDo7EP4=;
 b=lJNoDmfoeoKUtKfxOOBB61TiZzFCfCj9HtXHXcExuRqyHn7xWmjY+zv5NSWqvA5hAJWiYxUO3De2ceEo4loMlyrAPsR5CqBsdX0lXAdU7mLq66KDl3C7CTr6T5zyk9I2Y/K2bSj5TW0AqDNVknJjFMTZBq/QO6WyP2aP+HeEQ0JsHqL2mbr3f2kd/zYvQg2ujxagbdDBHB/ys0cWtPgBgAt5wFo7GDMztRvjGWu1rR77kZbxanI+rJXz9U4lqy2oXhet4b7UqZXrKl2jJxnfDatnEIoc9YQ+EJ+AncV40zc2DC6Xnb1+RyWkXnewVMHVxAtWKla5n/jXDWWjB2mqAw==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by GVXPR03MB10215.eurprd03.prod.outlook.com
 (2603:10a6:150:15c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 19:14:58 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.024; Wed, 6 Mar 2024
 19:14:58 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Sumit Garg <sumit.garg@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Caleb Connolly
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Topic: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Index: AQHab2CjKZvPgmo3NEWX73nxw+EzJLEqNlMAgADZo4A=
Date: Wed, 6 Mar 2024 19:14:58 +0000
Message-ID: <87jzmf2mvi.fsf@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
In-Reply-To: <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|GVXPR03MB10215:EE_
x-ms-office365-filtering-correlation-id: 1415c7a4-df2e-466b-c6d7-08dc3e11b6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGETEbwiLzvLQjkN1ttlDcOgPdhZ3Z9FdcQRF0dEMlZNuKaxaUT4I6bC+zXWFINznOeqEFDM6n3V56tcITzgr85S8JkadlZKjxFHkmejL/CcRH4VtFeAkHEokg8eMsAZ6d4MpXrK+LE1nOvbu9USsvC0eb6cAQThbcL+ttk/7tUFBi/r4Qhcxucz3Das1hsvkoDqaqtM7EGKXMWY2XrndKu5NU7ZBOgOhveK+yPE6qnkMcY95jQp/ZEuhV0OiAvmW6hdBZ3u41UBCPP93YxQqjNpfmXSQuXbbAN5l3vxDUkZGoSeShV1qcYsyFGfXxFGmTc8ifmoKRxxxDvedjq7RuL3UpS/J5uduKOYrsWfx3TtewkTWNzqry+g0xh8LcdYBHHyiT5ZBxWepjAhssCw1n8nTh1eqISH5vM+nZlS4xtl2kQ+iBwNjSLV33T/uH+1OwMwsMX6Ud2uMA8su/kU9fhDYOwbIAu5eAGwCIxv3e6RzGZN5DAbDXts/4CtRhmIJ0klNvNFOzkZcjW/zsyQSl2S7yDT9rWHcUqxpq++sSQ0Behjka29At7bmZGgwF7W7F+ngnP/WSitUxoiqG7jweIsokkOCDtIIR/Q0mgD7T38zpUkWQ4JAWAOWBUfo9NrNkE/lApOhUbEsMulzMqIBUmu+Ho+66Sl8A+S6lxFpik=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QjtKhFnctMha5kj5VtH4z8+Hy28BjwHWxoscZCwAiY4anHJmAcwvwtoa4E?=
 =?iso-8859-1?Q?hlYuyi1oAY1yIIK1cgvOmQ6IRJaasaGezwYaJVDvPb2twWYFcDJZoxhGdN?=
 =?iso-8859-1?Q?wslt5r62qnRzU4Y1R9QqZKVM2dIIPUsg5yIwF5R13X90ZRQFWKq1zIAhEB?=
 =?iso-8859-1?Q?hkL0NvFcnVrEfTPCNdIOswDhrTzEkhgPtsO/8u+B172avROdQS7X3tjl46?=
 =?iso-8859-1?Q?TdRM6VoSBsKA3W5Wg5BowS+jykB6/hHTrCIfJk+tmVEaa4ztxm3+cuSmxg?=
 =?iso-8859-1?Q?LFzAxkmSA6JUcg3zPNk3zgL2gLnlgAca2GdWLGb6qaat2LR8WVL5/TBwem?=
 =?iso-8859-1?Q?sBcLIFe+vyUSKTdnV73pDccIFtUYo0Fmst/tLGXhoWfGj2u04eJteJduEK?=
 =?iso-8859-1?Q?CXyngP8ldW+6r+0iAIThgt6mZclMqJiy9vAIBzwSNU6gDw4xYGIt+JNu8i?=
 =?iso-8859-1?Q?z+zNEBB+pGnYY3T27AJ+78ABkN3fYOmAiiQFeJbbM61r2lKk+LaPivMcFK?=
 =?iso-8859-1?Q?fpklG3AXZMvEEILJo5Q1yGO8GxrnHpWTeBqVpdhbdQMlUP5ZNpNDNQQpOi?=
 =?iso-8859-1?Q?uA57byYH2Twr14pHXvykrhWSSt7Je09yIrfl26DIYYTHpQ/b40MuaYEbhH?=
 =?iso-8859-1?Q?quLeRbtLO46YwXtSROCilm2048u4HQDQxelm+3pJitesrO+FkoRm2bEh0k?=
 =?iso-8859-1?Q?65roq+qslA4S9ce/7jnz+KP1OlLaIJa5tB2QH9gvkz9lOdvNwSQ/BczMoT?=
 =?iso-8859-1?Q?rUjV/bpZGYF+1SvHUdxZdIfkW6F3QAF6GDj7ZEBErqGevoZfjhwj32n8te?=
 =?iso-8859-1?Q?FYVNm3d8fJt82fXMB8C/rNkC3yUat3FAYWi0MBGmLljFUvFxq6JTVfj0y0?=
 =?iso-8859-1?Q?1iKXmRQKlcqhqdOK91Xy6zyUFG/LC27qOhGgHatL52ejoxsGpWmVkFGfTv?=
 =?iso-8859-1?Q?dFiPZalBvF7vQOGM2ndSrD0r+la0/2RDiWZRCw0ZP7ndFrKSwJNucAKtif?=
 =?iso-8859-1?Q?hOSDue6Ic7mwy+RSGvnzvCdTUVPPyn4p1LMOdU20LrA2Kfndd8M9gdbsS6?=
 =?iso-8859-1?Q?aXo8cMEA6H7B6Jo3bO56AEs8LnOgbD00FCiZdJMecFb94qQdgisOFB/Jc/?=
 =?iso-8859-1?Q?ocUOC2Ml8gMcmmEm4gytRaOEKu0RiYX+VkLEqv9++LHgYpaBA2MMnIn27J?=
 =?iso-8859-1?Q?nhIvycvV5QDgPH6VkWDnjMkGgth3mqGJtpoAH0vQui3B/zp8kogJZvLp5t?=
 =?iso-8859-1?Q?Qt+TSQhMyTUxw3rzvrV7Z6omJ4uuYZvxhMvQBbgXN2pOcvbs4Vp3YEXFlz?=
 =?iso-8859-1?Q?+7cqPGT0APbYqGhQ3nM0x52lQvz9OS4BgVbR707pTj3uRlSTbiP+hu228R?=
 =?iso-8859-1?Q?8n6pcU9FgPOPptjSeIFPpHpif2uTf44eHcCTGW92I4y2c8lITd+Te1CNgn?=
 =?iso-8859-1?Q?qU0wffS4iEUtG9D4dLv90T3NhM+zPsHsTG7ebg4pwaVl8TrLmEYpovWzXE?=
 =?iso-8859-1?Q?uGXV9JsaZkU7rKIOUWqlj2h/ud/9BY04R4nhRNP6rD15JDykrLgQ49GIcU?=
 =?iso-8859-1?Q?p3s/sI9qFAA0Is77CCVUC0g3EpsmroRE3rAd8SmOcQqDMKhxmL06pMAVnV?=
 =?iso-8859-1?Q?wG81bZokpDfLwxkcAi8wf+VWBXsvB1Ilj6BNWQexTts9gmeHPtAl7Eig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1415c7a4-df2e-466b-c6d7-08dc3e11b6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 19:14:58.4352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OA1TCWTsrAxG6QZWycorFiQxo3EdLoPanp8Tc06XKNoVEWWUCFGG/3Ocf18jY4X+9ZnVtwzgI7tF3wXB2hY80t/B3oGOTb9lR5AFdavZlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10215
X-Proofpoint-ORIG-GUID: ynbNLSIW45NTAYKbdCuIxMf9rQiHZzvq
X-Proofpoint-GUID: ynbNLSIW45NTAYKbdCuIxMf9rQiHZzvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060157
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


Hi Sumit,

Sumit Garg <sumit.garg@linaro.org> writes:

> Hi Volodymyr,
>
> On Wed, 6 Mar 2024 at 06:23, Volodymyr Babchuk
> <Volodymyr_Babchuk@epam.com> wrote:
>>
>> SA8155P Automotive Development Platform is Qualcomm SA8155-based board
>> for developers. The nice thing that it has unlocked loaders with test
>> keys support, which means that U-Boot for this platform can be
>> launched at earlier stages.
>>
>> This patch adds basic board support with only serial port and
>> networking operation. I am using U-Boot to ease up Xen porting onto
>> this board, so I am mostly interesting in booting U-Boot in EL2. But
>> more conventional setup with Android boot image is supported as well.
>>
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>
>> ---
>>
>> Changes in v2:
>>  - Rebased onto qcom-next branch
>>  - Removed unnecessary files thanks to generic qualcomm board support
>>  - Enabled CONFIG_REMAKE_ELF (this removes one extra step in the
>>    readme)
>
> Thanks for the rebase.

Thank you for the review.

>>
>>  arch/arm/dts/sa8155p-adp-u-boot.dtsi   | 30 +++++++++
>>  board/qualcomm/sa8155p-adp/MAINTAINERS |  5 ++
>>  configs/sa8155p_adp_defconfig          | 35 +++++++++++
>>  doc/board/qualcomm/index.rst           |  1 +
>>  doc/board/qualcomm/sa8155p-adp.rst     | 87 ++++++++++++++++++++++++++
>>  5 files changed, 158 insertions(+)
>>  create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
>>  create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
>>  create mode 100644 configs/sa8155p_adp_defconfig
>>  create mode 100644 doc/board/qualcomm/sa8155p-adp.rst
>>
>> diff --git a/arch/arm/dts/sa8155p-adp-u-boot.dtsi b/arch/arm/dts/sa8155p=
-adp-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..ffbf0933c7
>> --- /dev/null
>> +++ b/arch/arm/dts/sa8155p-adp-u-boot.dtsi
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Qualcomm SA8155P-ADP device tree fixups for U-BOot
>> + *
>> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> + * Copyright (c) 2024 EPAM Systems.
>> + */
>> +
>> +/ {
>> +       /* Populate memory node with actual memory configuration */
>> +       memory@80000000 {
>> +               reg =3D <0x00 0x80000000 0x00 0x39900000>,
>> +               <0x02 0x0        0x1  0x7fd00000>,
>> +               <0x00 0xC0000000 0x1  0x40000000>;
>> +       };
>> +};
>> +
>> +&ethernet {
>> +       /* Ethernet driver tries to find reset by name */
>> +       reset-names =3D "emac";
>
> This deserves to be pushed upstream in Linux kernel DT. In the
> meantime we can carry it here.
>
>> +};
>> +
>> +&tlmm {
>> +       /* U-Boot pinctrl driver does not understand multiple tiles */
>> +       reg =3D <0x0 0x03000000 0x0 0x1000000>;
>> +       /delete-property/ reg-names;
>
> This won't be needed if we can make the tiles offset in the pinctrl
> driver compatible:
>
> #define WEST   0x00000000
> #define EAST   0x00400000
> #define NORTH  0x00800000
> #define SOUTH  0x00C00000

Hmm, I assume that in this case pinctrl driver should map all the four
tiles independently? Are there guarantees in U-Boot that four separate
memory regions will be mapped into virtual memory with the same relative
positions? Linux clearly don't make such guarantees.

>> +
>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>> +       /delete-node/ phy-reset-pins;
>
> I suppose this is not needed as phy-reset-pins also configures the pin
> as GPIO only.
>
Well, yes. This also puzzles me up, but for some reason it stops working
if I leave this node intact. Looks like I need to look at this deeper
before posting the next version.

>> +};
>> diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/sa8=
155p-adp/MAINTAINERS
>> new file mode 100644
>> index 0000000000..03fac84f51
>> --- /dev/null
>> +++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
>> @@ -0,0 +1,5 @@
>> +Qualcomm SA8155P Automotive Development Platform
>> +M:     Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> +S:     Maintained
>> +F:     board/qualcomm/sa8155p-adp/
>> +F:     configs/sa8155p-adp_defconfig
>> diff --git a/configs/sa8155p_adp_defconfig b/configs/sa8155p_adp_defconf=
ig
>> new file mode 100644
>> index 0000000000..b6969767f8
>> --- /dev/null
>> +++ b/configs/sa8155p_adp_defconfig
>> @@ -0,0 +1,35 @@
>> +CONFIG_ARM=3Dy
>> +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>> +CONFIG_COUNTER_FREQUENCY=3D19000000
>> +CONFIG_POSITION_INDEPENDENT=3Dy
>> +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=3Dy
>> +CONFIG_ARCH_SNAPDRAGON=3Dy
>> +CONFIG_TEXT_BASE=3D0x85710000
>
> Being position independent shouldn't require a hardcoded U-Boot text
> base. Can you try if we can get rid of this?
>

Well, it is required if we want to load U-Boot instead of hyp.mbn. We
need correct addresses in the ELF file so Qualcomm loader will not
reject it right away.

>> +CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/sa8155p-adp"
>> +CONFIG_IDENT_STRING=3D"\nQualcomm SA8155P-ADP"
>> +CONFIG_SYS_LOAD_ADDR=3D0x85710000
>
> Ditto.
>
>> +CONFIG_REMAKE_ELF=3Dy
>> +CONFIG_BOOTDELAY=3D3
>> +CONFIG_SYS_CBSIZE=3D512
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_HUSH_PARSER=3Dy
>> +CONFIG_OF_UPSTREAM=3Dy
>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>> +CONFIG_NET_RANDOM_ETHADDR=3Dy
>> +CONFIG_CLK=3Dy
>> +CONFIG_CLK_QCOM_SM8150=3Dy
>> +CONFIG_MSM_GPIO=3Dy
>> +CONFIG_PHY_MICREL=3Dy
>> +CONFIG_PHY_MICREL_KSZ90X1=3Dy
>> +CONFIG_DM_MDIO=3Dy
>> +CONFIG_DM_ETH_PHY=3Dy
>> +CONFIG_DWC_ETH_QOS=3Dy
>> +CONFIG_DWC_ETH_QOS_QCOM=3Dy
>> +CONFIG_PHY=3Dy
>> +CONFIG_PINCTRL=3Dy
>> +CONFIG_PINCONF=3Dy
>> +CONFIG_PINCTRL_QCOM_SM8150=3Dy
>> +CONFIG_POWER_DOMAIN=3Dy
>> +CONFIG_MSM_GENI_SERIAL=3Dy
>> +CONFIG_SPMI_MSM=3Dy
>> +CONFIG_LMB_MAX_REGIONS=3D64
>
> Apart from above, I think this platform should be able to reuse
> qcom_defconfig as you can find most of the config options there. Can
> you try to reuse it?

Honestly, the whole reason I am porting U-Boot to this platform is
because I want to run Xen on it. And to run Xen, I need to run U-Boot in
EL2. And to do this I need u-boot.elf with "correct" load address and
entry point.

I am planning to publish and upstream Xen patches as well (once I finish
them). And it will be really nice if Xen users will be able use
mainline U-Boot to boot Xen.

>> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
>> index 4955274a39..268218b05f 100644
>> --- a/doc/board/qualcomm/index.rst
>> +++ b/doc/board/qualcomm/index.rst
>> @@ -7,5 +7,6 @@ Qualcomm
>>     :maxdepth: 2
>>
>>     dragonboard410c
>> +   sa8155p-adp
>>     board
>>     debugging
>> diff --git a/doc/board/qualcomm/sa8155p-adp.rst b/doc/board/qualcomm/sa8=
155p-adp.rst
>> new file mode 100644
>> index 0000000000..66db512b52
>> --- /dev/null
>> +++ b/doc/board/qualcomm/sa8155p-adp.rst
>> @@ -0,0 +1,87 @@
>> +.. SPDX-License-Identifier: BSD-3-Clause
>> +.. sectionauthor:: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> +
>> +SA8155P Automotive Development Platform
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +About
>> +-----
>> +This document describes the information about SA8155P Automotive
>> +Development Platform aka SA8155P-ADP.
>> +
>> +Currently U-Boot can be booted either as Android boot image, or in EL2
>> +mode, instead of hypervisor image. In the latter case it is possible
>> +to use U-Boot to either boot Linux with KVM support or to boot Xen
>> +Hypervisor on this board.
>> +
>> +Supported HW modules
>> +^^^^^^^^^^^^^^^^^^^^
>> +Port for this board is in early development state. Right now U-Boot
>> +supports serial console and networking. No USB/fastboot or UFS support
>> +yet. So it is not possible to save environment variables as
>> +well. Nevertheless this is enough for development as user can download
>> +all required images via TFTP.
>> +
>> +Installation
>> +------------
>> +Build
>> +^^^^^
>> +Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
>> +
>> +       $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
>> +       $ make sa8155p_adp_defconfig
>> +       $ make
>> +
>> +This will build ``u-boot.bin`` in the configured output directory.
>> +
>> +Boot in EL1 mode instead of Android boot image
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +Create a dummy ramdisk image:::
>> +
>> +       $ echo "This is not a ramdisk" > ramdisk.img
>> +
>> +Compress u-boot binary:::
>> +
>> +       $ gzip -c u-boot.bin > u-boot.bin.gz
>> +
>> +Append DTB again (binary we use already have DTB embedded in, but
>> +Android boot image format requires another DTB at the end of the
>> +archive):::
>> +
>> +       $ cat u-boot.bin.gz u-boot.dtb > u-boot.bin.gz-dtb
>> +
>> +Now we've got everything to build android boot image:::
>> +
>> +       $ mkbootimg --kernel u-boot.bin.gz-dtb \
>> +       --ramdisk ramdisk.img --pagesize 4096 \
>> +       --base 0x80000000 -o boot.img
>> +
>> +Finally you can flash new boot image with fastboot:::
>> +
>> +       $ fastboot flash boot boot.img
>> +
>> +Or just boot U-Boot without flashing anything:::
>> +
>> +       $ fastboot boot boot.img
>> +
>> +Boot in EL2 mode instead of Qualcomm's hypervisor stub
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +This approach ensures that U-Boot is booted in EL2 and it is possible
>> +to run virtualization software (like Xen or KVM) on the board. You
>> +must understand that this approach breaks Qualcomm's boot chain. You
>> +will not be able to call all subsequent loaders, so you will not be
>> +able to use fastboot for example. Use this approach only if you want
>> +to experiment with virtualization on SA8155P-ADP.
>> +
>> +U-Boot ELF file needs to be signed with test keys. `qtestsign
>> +<https://urldefense.com/v3/__https://github.com/msm8916-mainline/qtests=
ign__;!!GF_29dbcQIUBPA!0UfvyQldjKBqYC9K5XA-YFiHToTTSqPC1Bik0hYoZFjtfVhrSIOd=
YKRg45Pu_frCx0I4Shei89pxPWV2V1fqTuquDoA$
>> [github[.]com]>`_ tool can be used ::
>> +
>> +       $ ../qtestsign/qtestsign.py -v6 hyp u-boot.elf
>> +
>> +Resulting ``u-boot-test-signed.mbn`` then can be written to the
>> +board. Easiest way is to use ``edl`` tool: ::
>> +
>> +       $ ../edl/edl w hyp_a u-boot-test-signed.mbn --memory=3Dufs --lun=
=3D4
>> +
>
> Can you provide reference to the EDL tool and its usage so that people
> can recover their board if it gets bricked?

Sure, I'll add the link in the next version.

--=20
WBR, Volodymyr=
