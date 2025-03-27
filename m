Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D278C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 07:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD6EE8070C;
	Thu, 27 Mar 2025 08:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Iw6nmmBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4257681273; Thu, 27 Mar 2025 08:41:03 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E7F806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLXtGQc8Sx+Up2RhAoZdGrXxWR8qkx6rTvJ/5VCRJpfOzDyLw+o4GvwgC9CVvyDuflpp2k3IyUvmEYmMVuxZZOwyFUy3/BvQgrGOjS2NVbLfE5i6+yIniPcNHBewY/3/41tSU6ph0wCqBTMCvFYqT7MwP2Tvwrk0Gw5kOJeW9EvyOz++U1/ZJUrW1uAOfl2DvHPrdOu+5rGaJw9SUHdTi4X/Lm3pdq40ClruCHJKl8lWajC2KsfT02dK0cLZCvmCV0XTieMD4SBtNON6g9qeMD6MGUAVIhvsT7v0FUrME9VXSlL6QUrr082nZYM4pSoF2vCk13FdLu+A+Uv/y7DO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqfzyN0fIuFuUnlsdnN97lNabr8irHHJwKoMeX9F1NY=;
 b=K381+8FuNpG4mYR1lYWKMj4zt5WLLkw82qpM7jqzsm4TPQUuUuNf77i6wWujVpeOHBZ/CdJ6cNc2jAQAce/dPTx/Yiof+f/d1KnzJFVnwubYOHNZhal947Awss32hnIlNzKOfEy/tMP55soKUU1uvOgNxDRFSxbzYYOhL7KemSVzEH+99DSE0lv0bbt5X9cIQYDnt39JUQ201/XWbocH5zgcRqc3e5A690RddJ4lepgmobXmnGEaRIW9Zky3aJGM+AlzT3T7s7DV1iCO0MpHL+YDe5Ysu3w7EwqCCvojk2mxMgjBhupkNHQJk+dkf33pdjQfAUZOwJj4T0EZuZUwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqfzyN0fIuFuUnlsdnN97lNabr8irHHJwKoMeX9F1NY=;
 b=Iw6nmmBHiRIUfUVETjqRvc30ZrtEqembkRRPQArTicuI1PkOJT1T4GspsQRKcj8mNbPqbqi6tK1f6FzZgr9Ip8bPgvgB/7WEW74MdoMhmq8GSq0WYMbvStNfs1cwQBcRSRQl+tlat6l6UeOrEcfzM/YjRRlxpJi3Bl23k/8/+r5cejpR43LrYUwXI2UhP4f4WAFjHE4Q0CzzyuDKKa16CLt5G39TRaE/r67bxkeGTzC2DkPjGuloeMPwg0MkmDnnJvULHwlmmukUHiIGrNBc2oXkCqq7k22F/vjVIZmkTi4inpXjFPVGqZ7cQ9IYgTyNDvxrnqM6YzzyrBbMEVZtVA==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by BLAPR03MB5649.namprd03.prod.outlook.com (2603:10b6:208:291::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 07:40:57 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 07:40:57 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] ARM: socfpga: Drop incorrect imply
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
Thread-Topic: [PATCH] ARM: socfpga: Drop incorrect imply
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
Thread-Index: AQHblUmm6b252GIHgkaUBZm/cb9U6LN4OuZQgAC18oCADbjIgA==
Date: Thu, 27 Mar 2025 07:40:57 +0000
Message-ID: <SN6PR03MB3583F51561E9977EC38979E8A7A12@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250315012900.399381-1-trini@konsulko.com>
 <SN6PR03MB35836ECB9BAFF92F78B520FEA7DE2@SN6PR03MB3583.namprd03.prod.outlook.com>
 <20250318135739.GW2640854@bill-the-cat>
In-Reply-To: <20250318135739.GW2640854@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|BLAPR03MB5649:EE_
x-ms-office365-filtering-correlation-id: 2023e5f8-fa68-4864-9786-08dd6d02b68b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ctve28EILVUbM2w3OdxZWX5JvTY/xNXdQHHSVoAgD9q0yzX8ziFBS+IYVTX/?=
 =?us-ascii?Q?gxEW25Xl84kXcQWgXsCLbeUYuv5nW4T6htEntn+0e/m7wuqFt1YWzThGLtid?=
 =?us-ascii?Q?SatiKLiQlBOUXQnqyZsMBKfMSTtgkLo+2Pu7J2ob967GgPTp4641MDaNBnbo?=
 =?us-ascii?Q?lustC2juhe/A90KYVNy4ICsTvPhxID0TUDuyU7caNMVUfIu8gaWD9PTFIWYt?=
 =?us-ascii?Q?qTVaYm3ygcTWQpg7zYXgXrA4eZSIY7jBRcId2V0V587n2YNNxQlq1cPzL63O?=
 =?us-ascii?Q?yLuhecHuLjCY4g7WXcaV5FqvDZLayOAkFWjniArSS5ykYfDewKgi3gHswApn?=
 =?us-ascii?Q?GgipFTb98+6o5AHZ4Q/U2K4um3mCpyHGmZwPrKhahjPvZ0urObU3/ZmPEbTH?=
 =?us-ascii?Q?O3w4112I9Ao2kr1ujWFoe7mhoFrTDLrIecqxyUIV7CiptXGgpaq4KEac8CSg?=
 =?us-ascii?Q?1GTXjwnyxTV+DaEByy7iuqBkp2Qs4WUkwzUYe2+bBtCeZs5AtZya5AbxHRgV?=
 =?us-ascii?Q?RW/8txvZZM7BP0xNd3Tkx0gx/lAQOavTdSqbKXUFRJ+eYMKhKsYTpxv1gPXi?=
 =?us-ascii?Q?4lpMd7gKXG5Y7JEGHCHfYUy6Tc3fRackuk3B3We4R99GTi5T4eCMk5UojCZJ?=
 =?us-ascii?Q?0QswBi5mlVso3LyQrPVd368+5kWxog/4z0Cd34u05pUdSnOzE7RfFTaXhG4X?=
 =?us-ascii?Q?gZo4a6G2u+3NBeE5qba75tb65ZbUWy4uECxbnKJgsWpJk/9s07l+K68IrGEp?=
 =?us-ascii?Q?91+hYiQz60n7wNEHgcC0ONJLNtV/GcdSguLFALWOljghmBi1ASxusir1KN+7?=
 =?us-ascii?Q?6wrKsVle+jAQyUaD3oEYxBhrSVyLmZga3IreUsed2YlnF6rlR979eaMYWwUo?=
 =?us-ascii?Q?o3TtuohDVLM/RcV8P8s9N5JJbGy2eQKaeBAXzqjBB0Qv9vLIBd1K4ygNBSBi?=
 =?us-ascii?Q?AyMRbb13uHysZ+46Lr8T8cRgIR32ttRwQwS8iEBWFmOBxHSpZaxaxijatWUF?=
 =?us-ascii?Q?XPMhpbOFZgvxBPRmb8eUtEkwOc/uGQc5XVDU/135HAxavMvoAIHwNdXtimwW?=
 =?us-ascii?Q?MsSAOQ1K4V2zfOFTplkyNNo8Eq8L8Ol7oIcJszRKUvypgvk6UBODmogAdxfT?=
 =?us-ascii?Q?9h3vIZUUp9rqS2vQX1s0uMHynhUUrdhn9AOSxVQnWB5R4f9fNQqeB64PN/Fp?=
 =?us-ascii?Q?iO7qXU4LyNPK0tb+uUTAD9R7jFNniKdpnI2vhjjFoVVe5UvPV1wVAAyYbBVT?=
 =?us-ascii?Q?FNJQF7NsY+mTcR2PmvPf8BAPMcEs540AF1vBVo7kcahi3Le0V8l8i6NTewUX?=
 =?us-ascii?Q?JAu/6da7foZEQWX8N5AQ0bRxvRwaRYmVldKfLTwDvTN+yfRlg0GOL+j4xHeV?=
 =?us-ascii?Q?hQix1xWkhpwEHfU1uPRGBV9jY/DGUucQOiqCPZ7kfu/KLV8ggwZfQ/8yLnRJ?=
 =?us-ascii?Q?d104Nc/lIhgKcVYZu1T5F3yH1nH5UON2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKISEhOFDM3lIQYJZSRNWk4EHSGAlFTV3KZOs4GNVRH+UT2thOE5977RlyIs?=
 =?us-ascii?Q?teJrDjRzW6YYx2YQnJqNqI/wXWp49vq6O1E/XaFpCsQP2e0jDZTzF+Y3PtRJ?=
 =?us-ascii?Q?4rtU0xGnOVXWBDXevpS2hWtHvKF90M7gIsqNTkWq9uJol5E/CYrGVlUSpygF?=
 =?us-ascii?Q?5m4qUnpIPAYWiYrLe1+8Xv/9S9Jb0+AxxHvX8uOGWVP9GnoSL3McrWDyMww4?=
 =?us-ascii?Q?PEdxMtx2R+/uj7/DcR5BofXj/9MPb7iTttoRXDEJO4D8iV+RabbFVti2z/ak?=
 =?us-ascii?Q?eMEXsQshdvJeqQKPM+JAFGecAbqecvXk2omK/0iBudQcA7KL1Fycexs2f+5a?=
 =?us-ascii?Q?lbyJgeJBsMksYG+NPuNQhi3x29bir9vblFnw6K6wrZOUa0KJF35wyQ2NIKYz?=
 =?us-ascii?Q?t6OPHa9Yi8bx1zH6NPLQX+90cW+BDTWON8bkJsPD2McyDH4XfuvZzmOuq9Bn?=
 =?us-ascii?Q?NpLSqxBR0uQRJ3eC5QbjEfTMBkWQXio1zsVTlQ7whGscB9wwv2ALLeL/WeGs?=
 =?us-ascii?Q?i4IiYoG4vnaEOrdfhAoLTP+wqF02DJNKi0Feahto8GM5sUPQeQP96v/l3FU3?=
 =?us-ascii?Q?PEXeV+hOtUawjgDVnauO1kINuQVgnuipoVc1T1P3FOTfIUlbUNaQrZhnIwYU?=
 =?us-ascii?Q?GPyRuRQLMuaNpE7VjGm6aDawUR7VeKzveD46MmfqGxcqEg7DqxmD27vGsANG?=
 =?us-ascii?Q?mc4jqQ0giYMykPUgd0OcEUhljCxbb1XJCbKj4u2Wm/GrHUbYBbcpCGv6kcno?=
 =?us-ascii?Q?rKlayHpzuW6AC4UeY95p5QTssmgcDISltSC8RoA+1vyh8w/qyG6AfqvWcv0n?=
 =?us-ascii?Q?T2T5jvbBBiu1PcNrCHDpEG+ctqAkUv1Bu4vmRusqlKNrTezg+SXgIoF3aIT5?=
 =?us-ascii?Q?Sot+UPepfxtc4F2/p9YuRR9Kks4KuGXtfe7dpRXAf5S99La9YCwoDn5znuXj?=
 =?us-ascii?Q?txGhDoF3mJTbwSJ2QuyqpoQJI3WXNDN8CkwcjBJT2iEehdfGv2G6KJ+rXNGL?=
 =?us-ascii?Q?Erv5loN72HzWwyrcXRfEHqTlCU9s6prLLmhuI9dbA2mpLglpmnTPut5EmzEk?=
 =?us-ascii?Q?0DjwpEjARs5iYetE9LsiAdZHwBhGEo32skYCRx0lYknQEcv+zCDTXgUWcrVh?=
 =?us-ascii?Q?T53xGgMwklFMqG2+L+SUT+jLg/z2tl1vxSY0Mw1Tsrl5Qy5FxtFuGmvRpgK9?=
 =?us-ascii?Q?4lY+fRWGqOg2gylB6Egg5NAHTHSTdMIYSKpDL+ht4HL4q9S89lhyc79oINvA?=
 =?us-ascii?Q?QfM/f7XSnC5sNBAto3Y9SbMwJTbIdN6+wNBEKGvM2AB59MC5mLrUKkskrnxq?=
 =?us-ascii?Q?2WScHTKGBYtvBtj4lQqVebcTrOQz+x+HxolNTzM6PR0nkkLBstVGoxZuS2rZ?=
 =?us-ascii?Q?WSIsqfnn4dySvip9z3pAk6XwhQFlxsOwYekK/RfDXAyvFww/vRFNIrB7ZVz9?=
 =?us-ascii?Q?d/aWjR8aE0vjp78P5eUX21to2YSmlA3Gv6ScJTUyLnmLeWyO8VqSNpkJWKr2?=
 =?us-ascii?Q?Ggnh27VGVrQSgG4thwbI2cDIobAo13uB26kaU7XFhkxSkjdoKGosXDPhlKzP?=
 =?us-ascii?Q?8OWHJDTv7/SrOgszuyfqv9aAkxn2r0fRmngYHtT2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2023e5f8-fa68-4864-9786-08dd6d02b68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 07:40:57.5982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYpfrUKYPoj5mPLOjkDkepCPl3eeQue27kwSZpgZ/ulma3Mnqf6CBvplu3FClBaQCKy8DYpU0y+N4N5+5O8y/0hNLZ9cPmY0vqL2ry8Gw4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5649
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Tuesday, March 18, 2025 9:58 PM
> To: Chee, Tien Fong <tien.fong.chee@altera.com>
> Cc: u-boot@lists.denx.de
> Subject: Re: [PATCH] ARM: socfpga: Drop incorrect imply
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
>=20
> On Tue, Mar 18, 2025 at 03:11:44AM +0000, Chee, Tien Fong wrote:
> > Hi Tony,
> >
> > > -----Original Message-----
> > > From: Tom Rini <trini@konsulko.com>
> > > Sent: Saturday, March 15, 2025 9:29 AM
> > > To: u-boot@lists.denx.de
> > > Cc: Chee, Tien Fong <tien.fong.chee@altera.com>
> > > Subject: [PATCH] ARM: socfpga: Drop incorrect imply
> > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
> > >
> > > The use of both "imply
> > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION" and "imply
> > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE" here is
> wrong as those
> > > are both part of the same choice statement. Furthermore you cannot
> > > select/imply something from a choice statement, it must be a
> > > "default ...
> > > if ..." construct within the choice statement in question.
> >
> > I think the imply here which allows for overwritten in defconfig.
>=20
> It doesn't. The specific warning is that these imply statements have no e=
ffect.

Okay, I'm not aware this now is not working, because I tested this worked l=
ong time ago.

>=20
> > To support the "default....if...", new config for platform specific in
> > Kconfig is required. Is there any other approach better to support
> > this?
>=20
> Adding "default SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION if ..."
> to the choice statement is fine. But the follow-up question is if it's so=
mething
> worth being listed like that compared with just being set as needed in th=
e
> defconfig.

Yeah, I see the value in this, imagine most of device defconfig need this c=
onfig, then this can be centralized here with imply instead of adding this =
config to respective defconfig for looking neat. Minor devices which this c=
onfig is not required to be enabled,  this can be overwritten to disable in=
 their respective defconfig.

>=20
> --
> Tom
