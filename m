Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F964C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1D380977;
	Wed, 26 Feb 2025 07:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1NBDp6hg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5256F80F12; Wed, 26 Feb 2025 07:48:19 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F008006D
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqvskR2q6UNzIAwyf0UR3H5Kva3WvBI2lIWCJv23mm9WRtd4/7jplDooTkZciKlhpu0FwTuea0b7vUUdBunhlPhIYIdKJrmCAZzjp8P2LmEtXSLj9n4Aq/uhsmf+M1p0Ad+yfI9jMZebyt8M0CoHbUh6fvJa1zxOOl0xRWoGVfTPs2BM630W8q/on81vpczxCkCbRqeHSnL8cSswAki4noFuKhkviggmm6+llo3NmmP2f/i1Bhyzx95ebdeDdv+m+fmSrOonfKbzPVM7tw+TbGl1i2zYbXGkZyjAg37ANoHFRKpEAySIKTHux3MnIXrsHBaKe5Kf+NXkxVsg8h1Byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N1Ur6dtwwQhVhUtSyhKgNLMPNkj0MFCxOLSpUN6FA8=;
 b=SOgRFdPhPaX+Pi7UxKsAOgUihR+8qPxVQsJ05u1lTTCFuvXY0wegID3fbEpDwfa9vy/MfXc8O9gtPLxgugBCW9pW7CGtKJHxDEWpfpCFnl/wxm60jyp6F8qbNY+ML5eJ0f9uQq775j665jMCOOeez8WbDlplBcwvucPGm4Iy79cQ1v6Y6GbRmYuZFC/epk8Tg4IKFJew0djh3moaWkSgHg3Gk6B18xKoEcVdc9xp/cHkAmCBvWu+zsT83EkUdlrr3W2rS92J/AV9eEZI/EZftB67yl1O/AoPZw1Q48Sa5853QighxhwuINBHDotUfs7n2plUin7D2miFySbpCTBGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N1Ur6dtwwQhVhUtSyhKgNLMPNkj0MFCxOLSpUN6FA8=;
 b=1NBDp6hgqH9b0NwKHoz0dDDpDYpXuta14ZBJw7h7PCHAh7Z0T/tSladV4u9cBy6xrZZZYU5rZb8CYpHs6Zl1IdifYe/drr3qmzyCey0daBzccBXx2VB4e+7Xyj+wi3ENcq/VKDImF+Ri/N2MwuNM6/FGl3vWulWTZk8A/78tHTE=
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 06:48:12 +0000
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf]) by SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 06:48:12 +0000
From: "Kummari, Prasad" <Prasad.Kummari@amd.com>
To: "heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Simek, Michal" <michal.simek@amd.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>
CC: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, "Begari, Padmarao"
 <Padmarao.Begari@amd.com>
Subject: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
Thread-Topic: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
Thread-Index: AduIGmYRLgVhbXGkQhuPrQU5OKYlTg==
Date: Wed, 26 Feb 2025 06:48:12 +0000
Message-ID: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7c8d8e23-93f3-4268-ab52-7a291a08a162;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T05:22:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6685:EE_|SJ1PR12MB6076:EE_
x-ms-office365-filtering-correlation-id: eefbbe86-1fac-436b-9028-08dd563189fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|8096899003|7053199007|38070700018|220923002;
x-microsoft-antispam-message-info: =?us-ascii?Q?FHjlsecXBis9IETDqBYGrpCuKvaKMd52z6wVoSJPfhbqvTPbmnmK1c1v271V?=
 =?us-ascii?Q?N7lknhppL7Z7PHjr8sCtENbqLcFqLfpqeLWDK46yKciw9z8700CLfrd//TPH?=
 =?us-ascii?Q?IphRa1hDBBjYxd/vMcnoX5889mSFK66m2pL0shwimDaLWJLJIjqtM5lgjkUC?=
 =?us-ascii?Q?PGnyz0yaFmxo+UtW51LT6qRBX6yVE0ZjaVI8ttnuhESYaYRWOiShGeoOn+Mn?=
 =?us-ascii?Q?WvJUBWrzO9YR1F/RdJvjyoLulSbBtV0A0aF0lgn6PnBO59WkebfTrcF3LwvN?=
 =?us-ascii?Q?R0OXEr2skXIXFVOoTjN4vdY3XTuSFj9RvYe4r/y+Ish6AGBIIAR8bdHdS+p0?=
 =?us-ascii?Q?+Bja/+OG4EQVIJo/c9CN2Ao7ljhwSk6Q+9KYGBODr4TTCX6IgLUiTby60j3C?=
 =?us-ascii?Q?UzXtUCcTdIA0hBpkMPy6Lo3/ygIyvNJi1nD/u0rpts7zKM4nIR+TsakSOC7J?=
 =?us-ascii?Q?adqtmxL3yuun6h3egDyePMDsRxaXclYOARJ1zd0rLOqmtG45wm7mTGR3Bc+w?=
 =?us-ascii?Q?ThrXGFUIlo48dKukvvZpx888qc4BRHu4u2UTTq9JVR7WF2ii8UuEndv4cvXu?=
 =?us-ascii?Q?sdGv3XyzAS0Yesp9WJesQqVITUivVT5KPeN9YBPsi6lLgry5F2W7GIqsb9QD?=
 =?us-ascii?Q?OwG8DyM92Oeq84g5s6efmkX0ZYQNOC6zrOFAmLu1yaK6zsS6WBBfkw5DK12o?=
 =?us-ascii?Q?Ggh00EjwISRYb85hnlor6m1SdDn/O3NHw6oZahncUkj+C0StvK6pxYpZ50BK?=
 =?us-ascii?Q?i6mI3k3WJYlqAwLdWS5an0cso+pDyEECNfYh7cR+6HOiMiS0D3h/bew5RPEu?=
 =?us-ascii?Q?xJMIVH0iZlaHvQN17smK27eYjDVylN2lNmk3Ozrl4c8RDmy61crfCC9BmegI?=
 =?us-ascii?Q?ZCOewGP3bf1sTxMy9si3X7mH01Z8DOM2RkbWN84dkeYFB8iNydQicNrTanwC?=
 =?us-ascii?Q?p4OMOWgzirR+9FgcCsX9Fc1wcW+/1dUvTaAhqdlOF7YuYrl8yaNpGchAHLxp?=
 =?us-ascii?Q?0NqIP1tS5rfGaSWmg9aL2BsC9f8BGAb54FJ37GhTNLtY6MujJkUbzy+VgVZk?=
 =?us-ascii?Q?khhvofWGNcOTFbfYhJSEIB8sQZZ46jrXpmBiwwG0Pitpi9a+MzRj+9ulAA+y?=
 =?us-ascii?Q?B5wzu6Ho329a2ZiLKnP/MRoyKqyshVkbw/rlI7g2bEnp6LogCHgAtwLsFO1f?=
 =?us-ascii?Q?pKrbtdvBv1JVwVRCd/oS2CsaYlSySItEKXhXXEcEnQt8eaMRAG0pPT/Lglcv?=
 =?us-ascii?Q?jxZYQBuG006mJraNZiZFR/An4EOdqUBKK8SPknPGxLg0iT1NUALgelmQuUEL?=
 =?us-ascii?Q?7ADEeiJZlSZgCMgUlC8WLOHQSzDQLT5gasSewozf3UQ/PYvU4If3CPSyUrQY?=
 =?us-ascii?Q?xY86uB97bRjJHUlwT6dp+R+7jphRx/hAdJJHVUBDTnnnVm2D6pmxNG0kQZwV?=
 =?us-ascii?Q?pDHcKyuKtyEc86d815nspgwrCJQtSlegie3sDjDSOt/9eFeZhB/15A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003)(7053199007)(38070700018)(220923002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GmEn9iEHNQHm5yN8JYQcFf+NN2yPo2HJVpCvvzgRqDRX051gRC8wwVItbHi9?=
 =?us-ascii?Q?DVncuXRctXoo5dIs1wVcXcfL9QxoOum7EjxV1R29Ilkuu77qbbmQNi9NI2NK?=
 =?us-ascii?Q?wgnzgyqANpd3xiPlzAZ6F1MhNNxEaId/xhB0rczEa2tQOSlCKPd4DEG75WNl?=
 =?us-ascii?Q?f2ZpookWQhklkSYxJihgg5l/pglDk4nxerZpf7sAX2zsyAUVnLCDfFfRQTN8?=
 =?us-ascii?Q?LZi8brLauczpdM8xkXv3EFm5ca6eBFi4nJgfs5PV8+4mtVRhJh9nLTXQrNUe?=
 =?us-ascii?Q?DhtaN2TPiV27WFTMP3C+Wdzb0XuRH7Ub0axL9NC7UeTWmQUdZWPdX/GD/Zay?=
 =?us-ascii?Q?c4l01FGRNSzKRenJyuHUVC1lNIAX2eLJtdtg/JHRl71z9/MPdAgwsqSVLvHd?=
 =?us-ascii?Q?y9+PFhDY3C38AZnBbdLDNX4nl39dQv3QfaKW9eZTkdx+CNtYby3M73tMlTvs?=
 =?us-ascii?Q?Xg93c3rsRj1qIN5tihlyRRNf4NPg35z2D3Hnt8wfblwBSLj8Ve8Ghq1Wl26y?=
 =?us-ascii?Q?/P0uTsE5EYKFJRBM328uOZmscjK5L5hHoZsHqBbSnLqUvpHDuLiPlnEn9hjl?=
 =?us-ascii?Q?b+XpEiuLD9m3eGnvn4z2p6Nct/KJHtE0DLC226kqFQMOzLURf/KIZ7t9qTsp?=
 =?us-ascii?Q?QTaptUSNxNHRLj3Mc8nOxr4O+Ob7o7BSOzauMEgQOWiyL3bDuzq+cg0LsDPX?=
 =?us-ascii?Q?0JojDczC8CNoUw6NfLwevSuy0FXew7C9eAZE6nrYRm/oyV+lQadjN94vn0vj?=
 =?us-ascii?Q?uhSASCK7lNcS0c7yZ0qPGtkEQEHwK7bHDoCtV5m2YtYNfIAVZzxY9SGoPrLZ?=
 =?us-ascii?Q?mNCotdUn+LJEkxWabyNC74jpkckm0syjWHtDuc1h6GruBH0S7vADi46ZjUFw?=
 =?us-ascii?Q?mLmqbVnPidaWRIsvujgJdZG/WyvZE9dyARQ5wFbdOelfKPyAsdZi51rcCMOz?=
 =?us-ascii?Q?KXnLTYOAkoyoFV6xVZ8d1CaJjZhCbNv8JYaR9zTpPh79CKLG32JSyLAJ8QVM?=
 =?us-ascii?Q?2Gy0eJ45KSmcrwyYcg833m5ABD25zNaRMkJJA4x6y2tGdvovN3EoWzF+rwbd?=
 =?us-ascii?Q?qnjaE+/yV3g0XgN0iCTKw6iBON3wTLi4NLBJAjIQD9uu0kNQ10Ntjf8NWr5d?=
 =?us-ascii?Q?TpjZKH/xK0fyEQcGPhEX3VXrgh26iRh/qEt3ycuD/jWrYDWPQ7lC80j+HyqM?=
 =?us-ascii?Q?EAQ+EuhGauy6c4Ajynopq3LBahK9rrKgpKswxYiXa/kpikIOc6wX8Hk4JS5B?=
 =?us-ascii?Q?g8gzxzt12u9ubAgUUAXiYhZoaTfMGSr2Q6WY2PmufUQU04z3ofxP+wm+WBqO?=
 =?us-ascii?Q?ExAdl3XG1mp+HPLv46JGrtDyfTX7rpM9ZIynbsxohrebfREEkp3ig9fvmUkP?=
 =?us-ascii?Q?L7WK1065b1BBcP0vrJ7XuF35nGX4e0mWonZGIsr5ZxiBqUHxGxebJVcDSJfj?=
 =?us-ascii?Q?GBwRRUiHvYUx9knl+qilW4sP+MNR0Lekdn7ZKutBfE9TWdTdmjRLFcQPkUAS?=
 =?us-ascii?Q?jmHAAsFpwxy3gZqQm2UVmiHARrQ7AB5ezAvepHDU5cplVr9JAJZHibbAVr5H?=
 =?us-ascii?Q?UYeyHwkf1e/sHwW8boI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefbbe86-1fac-436b-9028-08dd563189fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:48:12.4766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtICOg6ZHPOucr87fWs4W6RZJcqIp1vQw9FRUxRBdVLBSftx3HWnzVbJKe9ivfkr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Heinrich,

Regarding below commit.

commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85
Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
AuthorDate: Tue Jun 14 08:02:03 2022 +0200
Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
CommitDate: Sun Jun 19 15:53:09 2022 +0200

    efi_loader: initialize console size late

    If CONFIG_VIDEO_DM=3Dn we query the display size from the serial consol=
e.
    Especially when using a remote console the response can be so late that
    it interferes with autoboot.

    Only query the console size when running an EFI binary.
https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@c=
anonical.com/

Commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85 modifies the system to quer=
y the console size only when running an EFI binary. However, when CONFIG_EF=
I_CAPSULE_ON_DISK is enabled, the console is still being invoked, which sho=
uldn't happen. This results in issues on our terminal, which cannot handle =
the resulting characters, leading to incorrect display and halting the auto=
-boot process in the U-Boot shell.

Log Output:

Warning: ethernet@ff0c0000 (eth0) using random MAC address - ee:df:0a:38:a8=
:c4
eth0: ethernet@ff0c0000, eth1: mrmac@a40f0000, eth2: mrmac@a40f1000, eth3: =
mrmac@a40f2000, eth4: mrmac@a40f3000
Cannot persist EFI variables without system partition
Missing TPMv2 device for EFI_TCG_PROTOCOL
Missing RNG device for EFI_RNG_PROTOCOL
Hit any key to stop autoboot:  0
Versal> [42;173R
Unknown command '[42' - try 'help'
Unknown command '173R' - try 'help'
Versal>


Debug logs:

Before entering the U-Boot shell, set a breakpoint at getc, which is invoke=
d by efi_setup_console_size() and display problems and auto-boot interrupti=
ons.

 xsdb% bt
    0  0x7ff0d648 pl01x_serial_getc()+2011873280: drivers/serial/serial_pl0=
1x.c, line 339
    1  0x7ff0d134 __serial_getc()+2011873316: drivers/serial/serial-uclass.=
c, line 310
    2  0x7ff47dcc efi_setup_console_size()+2011873540: lib/efi_loader/efi_c=
onsole.c, line 291
    3  0x7ff4e40c efi_init_obj_list()+2011873316: lib/efi_loader/efi_setup.=
c, line 225
    4  0x7fed699c main_loop()+2011873324: common/main.c, line 61
    5  0x7fed69d8 add_mem_region()+2011873280: common/main.c, line 84
xsdb%

code snippet: Disabling the efi_setup_console_size() function prevents the =
issue from occurring.

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..ad68ac19526 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -220,9 +220,10 @@ efi_status_t efi_init_obj_list(void)
        /* Initialize once only */
        if (efi_obj_list_initialized !=3D OBJ_LIST_NOT_INITIALIZED)
                return efi_obj_list_initialized;
-
+#if 0
        /* Set up console modes */
        efi_setup_console_size();
+#endif

Regards,
Prasad.







