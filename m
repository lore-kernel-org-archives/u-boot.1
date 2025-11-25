Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0695D1036D
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 00:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16093840C3;
	Wed, 26 Nov 2025 01:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=sandia.gov
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sandia.gov header.i=@sandia.gov header.b="W3xFKsim";
	dkim=pass (1024-bit key; unprotected) header.d=sandialabs.onmicrosoft.com header.i=@sandialabs.onmicrosoft.com header.b="purXcst8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6487784154; Tue, 25 Nov 2025 23:19:52 +0100 (CET)
Received: from smtp04asnl.sandia.gov (smtp04asnl.sandia.gov [198.206.223.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE5284142
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 23:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sandia.gov
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=npyonke@sandia.gov
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=sandia.gov; i=@sandia.gov; q=dns/txt; s=snl;
 t=1764109189; x=1795645189;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Xx+RwwxyQd2T6H5oA1ypAHB83pFf2CIEXfr3dZ7Qv28=;
 b=W3xFKsimCr+AfIrbMdXC8RfP1h1iduUgccbZ9nA0K9b7yZxwPz5em4/T
 iGAUD4dADDdtp+8SskI/cSeNSR7scOPpoZdkMigaucERF6Io0Ogs8c3wR
 rZBcX+6v7MPiX1+so2aAR3b+7IAB1WMl2jTGwh1bkT+lXf5cK885ZRzsO
 A3XKZHdqriNXwtdW6GwHu7pctPzZaypabazDjc4mI98OzqcQE8j7pjmrp
 +4B7ez2dZsOT6m8yvY41dH0+L7lkBg6sv0rs51eFY+RWMsewg2eL0x6cm
 EcI2U0A5tf7pyVhGbVgTwyu33oZ2YjCyrl76Ag1wPJMBPpYuGwTGFk9VG g==;
X-CSE-ConnectionGUID: km8J5Q+3QvqiWbtieAWNAA==
X-CSE-MsgGUID: 0TbAMspwQUiDSIVmQyLs+Q==
X-IronPort-MID: 20953528
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="20953528"
X-IronPort-AV: E=Sophos;i="6.20,226,1758607200"; d="scan'208";a="20953528"
Received: from unknown (HELO mail.sandia.gov) ([10.253.59.6])
 by smtp04asnl.sandia.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 15:19:47 -0700
Received: from exch02asnlnt.srn.sandia.gov (10.253.59.5) by
 exch02asnlnt.srn.sandia.gov (10.253.59.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 15:19:46 -0700
Received: from BN8PR09CU001.outbound.protection.outlook.com (40.93.12.54) by
 exch02asnlnt.srn.sandia.gov (10.253.59.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 15:19:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyWmar/usEqjZAv0OATNRWmq4GNUwPZiJ8y+pICDHqiXE286iZCVW/QO+P0zNPw+CCFN9YtxUW8J8XKfTc5IA9T0/srI6XtP9D9RGTr+egll1NUb6G6qPrLtyTzNEreKGiXdAGO3CCDm2ugQdLeGRJYv2PCD8/j9xeP40CLaW/RJReuTjLFTZC78EAYsrSZ3nNqk+9qQfCFzqs/UuE+HdgZg6uESwwsGLQHUF5ZgnNWETM5uBdNQFCltZRHJUvXYvCobgKVRXkQxZU++W0x2IFrM8Z5NeA2DdGYYCkrSSbhxwb8qfEwqInIBtrqeG6awAzVeKB+TfbjRJ+kTCqd8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx+RwwxyQd2T6H5oA1ypAHB83pFf2CIEXfr3dZ7Qv28=;
 b=uBpAZtHlUBqvB9ju++i3O48MV5+ZJblqbJoYrdsuLOc8OdBVirqFD0902px+7Gbyua0fgba9XRnYnnhSW11hjptAXPI0Fv3v1iczkGqXvdc8WbXRnqBOQwtWB/cLb9hNx9u9o0Qunxe0us0k+pxgIGxrY/hYhtFKnSH2ALZOPruyPCGy0IjtQl7MSOP5YdMgZGF3bwfrMqkeeFffdUnpDuESTRrB2STUPRIv8eZfIN0nq5u3lC7bju1/MOjQB4d/dhQbdLFn3hpu1ZWFU2qGssH3jHFYYyCTw4QmX2qeACrCPp2k/6VPUYle11RDxjnm+/UMyxkXBipLQYbgLqdv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandia.gov; dmarc=pass action=none header.from=sandia.gov;
 dkim=pass header.d=sandia.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sandialabs.onmicrosoft.com; s=selector2-sandialabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx+RwwxyQd2T6H5oA1ypAHB83pFf2CIEXfr3dZ7Qv28=;
 b=purXcst8Ilpl+jnSyGUiKDT+sCIrnV/EMZ1Mn4Fwp74fdu6GecrajGbeLjtC7FQ4OTrMtAZIwjWxF9NDAtdh3ktU939NtzZbjbagGQ8v+EHgWJhunWYB3dVLlN06OTzSZT9bha68ZOmMmxGop3dCSqjC8sEkXvipEyj4KMuSKHU=
Received: from BY5PR09MB4977.namprd09.prod.outlook.com (2603:10b6:a03:246::13)
 by DM2PR09MB12052.namprd09.prod.outlook.com (2603:10b6:8:2cd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 22:19:44 +0000
Received: from BY5PR09MB4977.namprd09.prod.outlook.com
 ([fe80::44d4:280c:4015:ffb7]) by BY5PR09MB4977.namprd09.prod.outlook.com
 ([fe80::44d4:280c:4015:ffb7%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 22:19:44 +0000
From: "Yonkee, Nathan Paul" <npyonke@sandia.gov>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXTERNAL] Re: tcp server with tftp
Thread-Topic: [EXTERNAL] Re: tcp server with tftp
Thread-Index: AdxZqh61gz4JvBHsSn2SJ7Aa8M7C1AAOBPYAAR3GitA=
Date: Tue, 25 Nov 2025 22:19:43 +0000
Message-ID: <BY5PR09MB49774DD871FD132EC996D077D2D1A@BY5PR09MB4977.namprd09.prod.outlook.com>
References: <BY5PR09MB49772032490F7E91C03B9760D2D7A@BY5PR09MB4977.namprd09.prod.outlook.com>
 <faaa20665a2fa04ee12ec08b2c3d1250@nathaniel.land>
In-Reply-To: <faaa20665a2fa04ee12ec08b2c3d1250@nathaniel.land>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandia.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR09MB4977:EE_|DM2PR09MB12052:EE_
x-ms-office365-filtering-correlation-id: ad5ae6e8-7885-400c-b66f-08de2c70bc46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xeAO26wVFIlOxq8Zk9SXyfT/dpQhQ+X5nH0DujGssaja58IW0q9SySM63sKf?=
 =?us-ascii?Q?E83amwaYNL18OZGtneQj5c7hyUUzUcceiQtqOvAou6i7q7EEwu/6ROx+pw72?=
 =?us-ascii?Q?tRUwFDSLc5TbyinaBzGW+jReOzalfCYxKnmGteNX2jLfof5PhYIcBCTQqX32?=
 =?us-ascii?Q?d0NM4Gwdh577TIueVjuE3mUVMAf+s0p7pWVS94HjWosI9U1Yh9P3y3S6zcSG?=
 =?us-ascii?Q?L1wU0qLuPT1mHiJbW4N51SLHufhlIdnBCnLRDkqbWWjNZ8rSQxlaDv2hnQ+9?=
 =?us-ascii?Q?GgUYwoDSmDRUww0wjBBO1wxXR6/r698WKCZEe8Ldo5wEzGiXzub1fdGfxVR8?=
 =?us-ascii?Q?zRqBEfTGMeOW/UL8UHjOtiB3W+Zc7zbYqocf+JKrBrDrHYAWMVjAgYiJYSFz?=
 =?us-ascii?Q?kVEGOFEwpH8Z00AvSAlccuaghuBk0t4fKj+Kdckm0Na6Z9Fm+/G7M6hXr3rO?=
 =?us-ascii?Q?9kADyj7I3/dEF+SLntr+SjMxiypnDB63rWQweVo4Qi8WoVadYOQ9rRzaVeEF?=
 =?us-ascii?Q?OlxuGXfwn0sbF9k5+n7qsBGtzLVwridVpKf/ThzhmB8vQTgrlMp4eiZEAxbi?=
 =?us-ascii?Q?mFpooZoa1N6vcUh78X4W6vYBA4qYHM0SQkxccZGG1mRz6CWlFSeL42Px7LQU?=
 =?us-ascii?Q?HHgD/sy48BfC18u7ErbIYtUr3Qm1NzpYiUuL7G5GewsnK9clpgnrOeHdx2Uf?=
 =?us-ascii?Q?THYtXCjV55rVks3NLfO12xPO+cA5Oud22ozQVXoViAtUxHpyypZ/eTXNXUBV?=
 =?us-ascii?Q?LSLHhRZyR0LcUZTkiqM/vJ/7igLm+rVTGRSnz6AAfVzA0sFKltK/06zccctU?=
 =?us-ascii?Q?mC17INQvA9LJ2VwOEmlub6wjd2QxOqquka1/uCnmMO8YCtd4kqvWR/12d03p?=
 =?us-ascii?Q?QbTay0DI75zaU/B2OjRoivaS7gAvuZaKRCg6ruXf5JSUfhpoKSR35qcUvzKc?=
 =?us-ascii?Q?6vU6LzTWHNUM/QrnC6boaidOkhF0ceuD3H76gQHCpLsZ3vwxVByq0wt/CzgN?=
 =?us-ascii?Q?zlDZHZM6cfXrBonpQW3XXtwetl7hUy6AXb+YpLKxP+JW8D1qX+ASeK860Vkp?=
 =?us-ascii?Q?mOeAOxRwQMlSs8HYkFFvqYG044CEpI72WmUWtuScPrYdus0aA1DzxfcDwnm4?=
 =?us-ascii?Q?liRZYH/c06GxWADtK1845vVLBTsdVlVpRk5iE0sGtYxO7D2f2eeR5hT74YsU?=
 =?us-ascii?Q?xyD7s1fHfnu25vn6E/TndJemQR8O4BCDqG6dZ5s9JSG4WExRTpTGZpP+ezGy?=
 =?us-ascii?Q?XW6ulvsrHXjy9TKY/z6vmEc4SR33Docfk3lfiykBioyX5XwI4Zr0CHTFVIi+?=
 =?us-ascii?Q?TWo0OxvBJPsp3J1ht8tMgE/c7qn/wsu1DGjfKrgoqGOQIAEo8ed1qVVOjT7B?=
 =?us-ascii?Q?Mo7GjDn4oKd/gjY09GFkrM/vUlmfQkXpDuogQRQBQNvpf9tS3AafYMdECzax?=
 =?us-ascii?Q?//uBhqQJazc0AMTw2hqGOM72ibaCvYgW33TA8v2fMWXpnVA7okxWTNwQoV32?=
 =?us-ascii?Q?xsP7XTZkHoguROIbLnCXdE+dXwpo/+PY7dKN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR09MB4977.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT; SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8UlWbyfpBFlw9eT29Vh2bakgxgQwEhuSgt2vDKqKWORtUaVsBVlNZC0X4t+r?=
 =?us-ascii?Q?UMSnByYsHlvftM9SFFA+1k+lSGbYZeVq/oBEMKvhr677pfPLJozCFhxskN6Z?=
 =?us-ascii?Q?vTdowkcXy386dUV60aQZ+TzVsBZl9tcVDaj2Gt0tNl0pf2vmiR+7dK0FWSKu?=
 =?us-ascii?Q?LaAI56oj/jU5/EhFJu1dtdjYPiuRVPk3NX9xnCkvV4tDK4FjwOKOm6T4cLv1?=
 =?us-ascii?Q?lsDvRUN0sCvMxxcfMzUJKOtElINs5woF2h+Rg7h0oFvP3qT0rnwZjiAvT4IV?=
 =?us-ascii?Q?Bn5soTCzbBP4EJ/kQUvvpqnSV+nxUwag9fOUtz7hE0M2+6Y09UIp0YldBR1G?=
 =?us-ascii?Q?6gqOlbOw3OuVe+Q4abwn7nwmyGiZNebabpMyzRv67Z+zNWY7RcORuB95jJeh?=
 =?us-ascii?Q?Di/br7WB9IzZ6vFNcIUFuiCqtdJICrD3yxKC9Hq2htoN4VN5EZqKheNhPP4s?=
 =?us-ascii?Q?vJ+qZSWkaz76Or2dz6s7mvn573QUxuvxevUaKlYVuruC/CdQq6PnrDsV9s8v?=
 =?us-ascii?Q?YEh4cdCU1PcQm1TcNzMnadm7klgaMu29+hnNxd+Y3+u043GiZXmPDiEbZ5Sx?=
 =?us-ascii?Q?AYIMVP8lUS6dFUKgfMneKvSuR2Q5xA3tpKARPynpzRmJTHDDfDpsfrE+rch9?=
 =?us-ascii?Q?LtdXSJuXgSDCqWXbspWDuxvdcsmzKdnwrMK26/L44Jc6zYc3WaBGy5M3b0rD?=
 =?us-ascii?Q?PjSa/8YZ+FWtMujLA8EbRWK+n3e4iwstS/lYaMHxym5YiD9iVN9IwRLsoI+g?=
 =?us-ascii?Q?LGwXhEQ32eKEFTeOY0rq4iWvI4KRjlD+P+7ljut9WIIJi4/CbrjjkYpJway6?=
 =?us-ascii?Q?CDtdr1AJDm6Ljdw4x2xK4u7iyObxJFzeZORWt9ANKB3G1Go4PiWXQZBMHvxG?=
 =?us-ascii?Q?q6/mL54yWvptNZmhpUVl1HaIv0gqb+hwOddGzWc++lPrAaeQNDllgvHAe04I?=
 =?us-ascii?Q?N/cSmmFlD40EguWxZPrUaMfTJNg9kjEVNWmCPXARKZeO3klOo9WZh11rBAHj?=
 =?us-ascii?Q?4ayXViB47q5O35hmaiQhzlMCrQLP/INJ9XbNt4ToBvnkGRsfKPoi6GnDtmG2?=
 =?us-ascii?Q?fZA8L65v+1yGc8bY141xRShqThiPQ6HR1DgdyNiD0TQTscYHcfJUZvvdYF0v?=
 =?us-ascii?Q?T/d5ETmQpDY2RdAq+UfUzMVV45D7ajp5SaoTXC02za9JZzpnyZ0zPMm/UOdm?=
 =?us-ascii?Q?sT35IGdfIsezoIPfTSf0KPT2twSTtxLHYH48tjVVanmvZiOBYU9qYkWc9av9?=
 =?us-ascii?Q?I/+W4VOfa+Y2uAVjbeeUfvII9b+F3hkK3QBHVjRTpt+PkroENqBCH2Y3QSav?=
 =?us-ascii?Q?++9XX2Al2sWQGinzYf9gpP0G/Wz8SdUwYPuJAdVSVvgAArzJG+gAoU54nhNr?=
 =?us-ascii?Q?jkZC5eAa/SjeD5NQhj+S9ujdCT2qm5Qsoemya0qA8zHRYBzy9FNae89rAJ6q?=
 =?us-ascii?Q?BsXvkQ2VQSMYSwC0cgwTXMqwlblvfnhM2A/fql3VYknfkz9EecLLiGYFYX4y?=
 =?us-ascii?Q?JJeT//eScb+8VkOgvShriEPQX/C0eXh+bqUmFgdWtuiCYkhw9pXzxknIAdGl?=
 =?us-ascii?Q?Rc0Typ65ENncHXzCFu0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB4977.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5ae6e8-7885-400c-b66f-08de2c70bc46
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 22:19:43.9207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ccb5a20-a303-498c-b0c1-29007381b574
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR09MB12052
X-OriginatorOrg: sandia.gov
X-CrossPremisesHeadersFilteredBySendConnector: exch02asnlnt.srn.sandia.gov
X-OrganizationHeadersPreserved: exch02asnlnt.srn.sandia.gov
X-Mailman-Approved-At: Wed, 26 Nov 2025 01:14:48 +0100
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

Thanks for the response. I am sending files from the pc to uboot. I tried w=
get and still get connection error -13 from lwip. It's coming from the func=
tion bound by tcp_err.

Nathan Yonkee
Sandia National Laboratories
Department 5324, NPC Motion Systems
npyonke@sandia.gov
505-844-7031

-----Original Message-----
From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Nathaniel Hourt
Sent: Wednesday, November 19, 2025 10:55 PM
To: u-boot@lists.denx.de
Subject: [EXTERNAL] Re: tcp server with tftp

[You don't often get email from i@nathaniel.land. Learn why this is importa=
nt at https://aka.ms/LearnAboutSenderIdentification ]

On 2025-11-19 17:16, Yonkee, Nathan Paul wrote:
> Hello all, I am writing some custom uboot to run a tcp server to
> communicate with our lab computer. I would like to be able to do a
> tftp file transfer while the server is connected, but when I try I get
> error -13. I wrote a custom tcp server with lwip and I am using
> tftp_loop() to do the tftp transfer.

TFTP is usually a UDP-based protocol... Are you sure you mean to be using T=
CP with it?

If you're just looking to send a file to your device with u-boot, have you =
looked at the wget command?
https://docs.u-boot.org/en/latest/usage/cmd/wget.html Or are you trying to =
send a file from u-boot to your lab computer?

-
Nathaniel
