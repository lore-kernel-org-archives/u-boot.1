Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7AFC3ABA9
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 04:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 815DC820E1;
	Tue, 29 Apr 2025 06:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="afyqfzJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73AD18277D; Tue, 29 Apr 2025 05:18:25 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF51282102
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 05:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk4ucToRjym0xY1l3+z1TjQ8RuPjGF2t444Qflpka0vbieoWvWs+utLrwV4AP12qcJoXr4bFIGKcI4RVri+3kbfX4DCTCE5xdtRXI8kYa4CvQX98TnwpM2bZ0/PpSUfenr6fV+eoTMDQDXn05mKDmsb0FBMIp+2jQzhRx1sYy0c+t2+SAseLLb0uoowpFgBf0PUDTIk6NMkJURs8SLzICm7Bm9Q4nTdnFslCA+qXuOWYXB/lsdPbqWmLX5foQYh4OWu7fZmQ2ztfkcgPZ2aaZPFpYcWGtbURnYRcWfA6nOtxCz66P6jJW/dsAJyu0CgQDsQcSob59TP+5kgkLEOdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85NzijTZPms2Mdsp0H3EGiM3Ywrt3WwbROfzlIScjr8=;
 b=SlGWT/UcW8Xw0zrYsCTb/ok0OV/+xOSmGf29DaK8VMOmv1nTtFZWrEkj+hILVEMqCcKctzQi/eW4KpURHAt/J8U0OQ3Xdd7uszQ166Spq089YU7auX4GwlJw2RrYKZEhmpIhy+0FI+kwC5rbJOznQJ+JA6gjJ7CO74RQQfNS3d1B4mBZZnVVZk+dLBIzfM5mxtHw+04jq41Jox7UvDjm5DtIXyMqBupZpyKxUA67z7aal9/Vr8tQSWj7ccStDpgUWMQ2NMK/J0U/mZsz+KwX+iFvc/3n0vnsOGtEx+4a5FT/6cnXCC3DkofBNpZcvcQrcQuBd3bFoa30l9XMCD3J9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85NzijTZPms2Mdsp0H3EGiM3Ywrt3WwbROfzlIScjr8=;
 b=afyqfzJ4f0uABWxbrHFy45p+9/1LC1kbji4IwB27v+u2NKPSQJzfR6r+sviiykPiHEm1QSXV+KrovDH9vEmlQRwuXiSg1K9doFZszAYlrYcJ6o0A3qLXX4KyQg5aNS1k6OupSVid+/Hg36ON2wGhjf1nBqHF5JElz4lB07MNQZpBddBixltM5hojKw2zrbBnQjVbI5mS7ZPQ9mhrUHDz6HcvpaTU/HmuBeqklnYeWX2a8Lh1EkG6DvD3if95hFKymcCDBYNvaYWDO7DQpkHDQO7ADhfZ/6fEJTJV0whDFjxLtmIo78rHbfF2Nr7GxpnyYQhDHHAKjECS3dVhFKmjdA==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by MW4PR03MB6634.namprd03.prod.outlook.com (2603:10b6:303:129::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 03:18:17 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%5]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 03:18:17 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: U-boot Openlist <u-boot@lists.denx.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Venkatesh
 Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, William Zhang <william.zhang@broadcom.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@altera.com>, "Meng, 
 Tingting" <tingting.meng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>
Subject: RE: [CAD QSPI v2] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Topic: [CAD QSPI v2] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Index: AQHbrn4qitGgnbdqYEyzUH+Rq3Nj4LOzE2cAgAb6TbA=
Date: Tue, 29 Apr 2025 03:18:16 +0000
Message-ID: <BN8PR03MB5073B42BA7D4AEC4C09DD39EB4802@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250416031751.23483-1-boon.khai.ng@altera.com>
 <20250424164450.GJ5495@bill-the-cat>
In-Reply-To: <20250424164450.GJ5495@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|MW4PR03MB6634:EE_
x-ms-office365-filtering-correlation-id: 18a7a106-c1c5-47ab-fe16-08dd86cc7c28
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jvVv+5Vz+NDHmtjDlpIQvWXiPF0GnAhFawsYHKnnFIu1jsNZwuI1qBCZDemv?=
 =?us-ascii?Q?1l17kJSY+n7nuH2IpS7nwXFSzfJwq2hBBLrBa74e0BUr9VuRfus/FcRRuZyd?=
 =?us-ascii?Q?YVld9kteCUIrhVFQa+BMHlGg9k6lEYYknhjOhA+ENCB1KuKZkAoeICBmf99v?=
 =?us-ascii?Q?Owl2Xy0racyLNwXQJcOcZk+i4Wbt8kRQxtro7dQfXKJbuBX6QT0UcKr4MuJk?=
 =?us-ascii?Q?Am3c5jVVVsdqxKH6HObaDiZXbgNjzjU6O12bZAxD3vF2ZEJub8bZHUw6pl2o?=
 =?us-ascii?Q?WKJiOE1o+BWXY4k4/mG9lekxMO7tXpXKZOfWz67NYZUgIsZPbahB6UolRD2Z?=
 =?us-ascii?Q?3tuDm5mRiGsoVYJENPGR6T6qs6LNdVt5wrq0BF769I2kSFTijPUGi5Qu//C5?=
 =?us-ascii?Q?sEEGAiVmmOkp7wTPVLYentYhB2Q5H7pERab5KDJdurD73vd3TlNwelBMsuiQ?=
 =?us-ascii?Q?kBz1MW2hqU4lR7qVZ3zja/yqh2R1J9aHBETvFQVPJeIvDMHNMhB9J+O9/TRd?=
 =?us-ascii?Q?WXD3e3AHlEsxF38jxYeeZJfrT7TIXHAo70/SmXgGFNVe97yXorhEo330UfmR?=
 =?us-ascii?Q?eNEfIwrcWRplLeWn5oPlvMyquHNBWDDQSnM/uLEElv10Xx3pH5YtOVhYGM0k?=
 =?us-ascii?Q?eKk/+i5U5b0vmlf0w1SpMrvPLlT6ENYJWd6peRB3veu1yCXq7Q3Le2zmcWxn?=
 =?us-ascii?Q?XMpHmiPIuJVDW7is2c61ERroA0/caHWNlSTJ5mEtNjI+W4JsxaaFjx9qHdK9?=
 =?us-ascii?Q?shOKwgphODI6re9GzJIHdyuXh5L+O2oEatAhRFtoNvUFhEwHfD4GQCWy1zmx?=
 =?us-ascii?Q?fJsBsvplW7em6HuMQtVxEphDmmjlMQGjDZOPEvVdaj8bfB5fhB0l101/8UsX?=
 =?us-ascii?Q?grsY820VPI71zIKTg3t47nICj2EkDDTWrprWkgbkIFHhds8HwtzI0aX5i4WH?=
 =?us-ascii?Q?5saFeE085Ly0htl4T1tYUD7Dd63aiMuU+x/72v1npotmVbq7fuH6CkInfo36?=
 =?us-ascii?Q?9vrN7gZMhGZa0/eIUdClwAkowTnPu7lXebHBkdd2/qQY0Zf/7CfDrnq0bJUl?=
 =?us-ascii?Q?ge+nIbBvwt0P833vXzMf0fSyMtQkMfgS+fLzX6HQNL6Ei4J6x6odpi76TXTi?=
 =?us-ascii?Q?HxzvEw1mDAKRxLklCtJgsS1pnyfEnifDRctx+Qy1+Q6i46K2GNqKo6gMNNAD?=
 =?us-ascii?Q?qjqQH2q/XLpEohd/wcNBJZWfhJ/kSvXlXe/JYoWsQCb2jgy9O+4Zc3xesyJd?=
 =?us-ascii?Q?KMp9gkpLwImQYf5QsMUzPXnoWnaQboPoCbuLMz1WlNSe6jjhdFbLdDxYCiQ3?=
 =?us-ascii?Q?ziUli5HZdX8GmTbSl6/IXEUd4WWrkx4x+XWNmrOtiMEIqcrhUPXtwCS+Ll1R?=
 =?us-ascii?Q?aavpEBCOsRKIefszrtRwW5jmm3ZYZ6bv2eLn2Jon3rZK8K7UJmYyNUbVfmYf?=
 =?us-ascii?Q?w/utmuo4t96qfNfqnEhONb2pvYuWc249mnijuRd5/NXTwwn4KLXHaKlgqqio?=
 =?us-ascii?Q?XnylPbnBXwtT2mI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR03MB5073.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sev396D8MAlQXnJoqqSv/bA9KTqsZhJXDyiTnI1Ky/m4G8GGE6A7ggywMxuf?=
 =?us-ascii?Q?5SAtYbMe3RCjHs59qmRlZULj9QBYX03vdJQlN3pcPXx+ms2+IrbJVMSktozZ?=
 =?us-ascii?Q?oQy2cn5LPd/nLJUKcEa9IFMjD+P2X7JwiGABRYsSgUu2UIy94sL0jGuVZqIt?=
 =?us-ascii?Q?8R/McjqzWXa2mw/zbXLX4JNkBmdqd7y+XvWA9ASRafFivHS+lOBRijOafUGi?=
 =?us-ascii?Q?coLFBGte2JPWf6X15khh9AOOAKpMBxOxAtQa3ohu+jtDWA3h0EOMcNQ/qHI3?=
 =?us-ascii?Q?f0RVrAC4ZjAdkhF9ItQe23TSVE1U8IOu/2j+PWcrgCiTD63El53MBJ8/QMnF?=
 =?us-ascii?Q?CEMBSehdVuUoV8IAjPa5ojbtDUhqv7kBa4JfseIipsWkwLlPhYtthIU8h4TV?=
 =?us-ascii?Q?wc4uKsQaRQHr/XwfdLl33lBBU1cLBO04RPOa+vd5NqeYChs87Lf5DhyOm7Ys?=
 =?us-ascii?Q?PAlMDn4WFbYCQbB+eSQI6UAMpWgwIYQO4IozUMMh1aAX+YJfSebkSROAxRKz?=
 =?us-ascii?Q?p/CNkDcwyicgwa1AE2g9eyX7cydzbXX9bfPkzAVEg4kt/k35twJ+pIIqb03a?=
 =?us-ascii?Q?GRkSA1QDeRxZJZbAOSZl0ZrNBblpaBhYuHJaHCSWHqzu6o97OT69fdoW4ikt?=
 =?us-ascii?Q?gGlEQZBNLNfHAmloA2kfGvaTV4O+mC1eZcXUS7vvpQNYvCs2Cnro6YoeeaI1?=
 =?us-ascii?Q?FsEAFvGh6Jz4aPLs4/PlpOHbyHzj6HpjQnMCo8M1Qc15OOGbEcHW7i3jzQeM?=
 =?us-ascii?Q?mTEEobqYUm4Dfm7HlV4pjzhOEZpR44CMxbVb+QFjaFaVyGLhvaDXCmTV1oNz?=
 =?us-ascii?Q?e0f3/MnLDR90QaSZXxrHK2SlBTrQJFGMbsPdGC+7cNsO3jFjhJvMSsfnU81C?=
 =?us-ascii?Q?aWuyxwcFRi9UvzIPO7GGWerGTDVR52cWzqL3DuNtmDW/P0CEAxg3CEFYfbbX?=
 =?us-ascii?Q?T95tP24tNIUWelBeBWT3humt4CjbqbfyJRVD2k8JBl2iulXG9sXqnQzJ69Fz?=
 =?us-ascii?Q?hDdF8DN4ostOJ396yL8KyRrZ2eo3WGH+6hHPTd0V7utjioU25YGssoc91+lD?=
 =?us-ascii?Q?q9fVjYlJp2eKnaxKBns44SZRfCgxdenn6AnvDo6P/O5GLbHwNvx/q8D9M9FW?=
 =?us-ascii?Q?J6ol2BoIG2IE9SJQ40fEnB4+NO+m+VhRs4M1kd6ymbsOiFP/4IQvYBxTej4V?=
 =?us-ascii?Q?KY4lTHZwhINyCZ5Iw3C8Upm2+fTqxogt+jE4RQXgOp4C/3RQ+V+fnSuPWE1r?=
 =?us-ascii?Q?8L9oZamV2pbrYD//5zYDPrtG4PIM2J7FpSCB5/H8+dOuKLGuAUWhZOyIGTyl?=
 =?us-ascii?Q?wZN9a24CNvswOcguZzhme1DBxEFWeTSimniwVu6o2qY23WbvqXhWZt8kgXCj?=
 =?us-ascii?Q?tL93LUwxRzHOMr55oh6kMjdbvhkLBTRODXQlfDLKlLSweqXNcpbbePdYb0F0?=
 =?us-ascii?Q?1u7wuJoels26xq6wC2enSn1KUrGieeQnnPCeY6la/SKDETG6B7a3m+C2WMBA?=
 =?us-ascii?Q?gjMpnzbpHXecK6ZsbXq9nrJPcInbpunBSsQFsPPiQXMmIoHyacT8JEJt/Kwp?=
 =?us-ascii?Q?A0vGU9YVQCAlWO5IEfvWPgQ+aUQglZH38ozHV+1o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a7a106-c1c5-47ab-fe16-08dd86cc7c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 03:18:17.0758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PIWDxdSV56euKW5EKloEmq6Gi3cJlMfNCpd//CrO50Mh2JLMWwIHkTIcgokq6j8L+k60GB0cMPAom4nukuzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6634
X-Mailman-Approved-At: Tue, 29 Apr 2025 06:26:35 +0200
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
> Sent: Friday, 25 April, 2025 12:45 AM
> To: Ng, Boon Khai <boon.khai.ng@altera.com>
> Cc: U-boot Openlist <u-boot@lists.denx.de>; Jagan Teki
> <jagan@amarulasolutions.com>; Michal Simek <michal.simek@amd.com>;
> Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>; Tejas Bhumkar
> <tejas.arvind.bhumkar@amd.com>; William Zhang
> <william.zhang@broadcom.com>; Hea, Kok Kiang
> <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Meng, Tingting
> <tingting.meng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: Re: [CAD QSPI v2] spi: cadence-qspi: Add disable STIG mode quikr=
s.
>=20
> On Wed, Apr 16, 2025 at 11:17:51AM +0800, Boon Khai Ng wrote:
>=20
> > Adding quirk to disable STIG mode since cadence controller has issue
> > for read/write using the STIG mode. STIG mode is enabled by default
> > since 2023.04 for small read/write(<8bytes).
> >
> > Updated STIG mode reading from dev_get_driver_data by assigning to
> > platdata struct before read quirks variable.
> >
> > The STIG mode is disabled for normal read case and enabled for QSPI
> > Jedec ID read/write since it requires STIG read/write.
> >
> > Porting from linux implementation
> > https://lore.kernel.org/all/20241204063338.296959-1-niravkumar
> > .l.rabara@intel.com/T/
> >
> > Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> > Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>
>=20
> Applied to u-boot/master, thanks!
>=20

Thanks a lot Tom.

Regards,
Boon Khai

> --
> Tom
