Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F006C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 17:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5BEC875A0;
	Sun, 31 Dec 2023 18:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k3I4/Yzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8CAA87721; Sun, 31 Dec 2023 18:58:01 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E055487227
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 18:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvCO2oliKx2keugnbnYiGncw5DQDTazcP/t87JmRHIUNeG5sTwLvAT92X5rzFvnbG4pgwiYdvxQps4/nq/wgLUMXoRuTPUlqQd6d/WTyZA6MayFPboLq6ns1kgDQvU0urN4KEra1MoUZeuaiCt2Nhy8jvhNk605PLwajEKZ3UqUgxxb72iDVkDkwZVPZxj5tSirkClLgzWM2NAV+Tx/IFRKjNKthFKnpS0sHci/kgbD+V0m0XhUOGCh/fuRETGJbflRUhwtBchwV69swyqH6AemtXvPNsh2v99vHfGygP+YHHHgA/d65y/paCyZx7tCTbFNJZKjgvLrEAT1R6MFFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlGeauoYio7o2MstqZLGoj9biIAkdEP835ZL82M0Afg=;
 b=Lj2vIlHyo08mEWPyKClOgUyXZ2tLjQH2YLmW86XKO784dMunXLaRjO93dNSER+P82IlS6F91vXx19evNmcX9Y6cgLwnxlbthziOzZ21K+St67Gwk1wuScwcsw7Z9sQpzkdXDc9A9c9uCNltLGq2WI0aqzbiCa7RG6HzNYoQVV7Z3+iBubO3TcU9ZdXH8hl1yCwbjOzTTyTJ607Z7ktkePKGJP1e260WtWz65Ay5COtX/+il6yyc1uRzpq2OVEWowbhAuSeY1g+3N/JOnf3WOUoWiAN37IZtD39K63GQWD9f/VWDq6+SzHFqqWUAiOXwfSkrjZIlFOLwjdHvG0X/2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlGeauoYio7o2MstqZLGoj9biIAkdEP835ZL82M0Afg=;
 b=k3I4/YztLnElhwOm3kCPW4ODLhs8gQdYsqjjXm3ZI0DqLpYAt5QQIU5JWMY7Rtu7xqf+QhVWR/5H80U5q+oMXcW2Nqd4KuPVaUBJuBEy7MlditojmPm7o9EFCTYGjUjMI/w7ZG8JCZbB0Pm+k1Rs/o6KDdeTo4VsmlwDznZ4RP0=
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Sun, 31 Dec
 2023 17:57:48 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::9304:6c11:c65c:2324]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::9304:6c11:c65c:2324%4]) with mapi id 15.20.7135.023; Sun, 31 Dec 2023
 17:57:48 +0000
From: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
To: Jagan Teki <jagan@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "Simek, Michal" <michal.simek@amd.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "git@xilinx.com" <git@xilinx.com>, T Karthik Reddy <t.karthik.reddy@amd.com>
Subject: RE: [PATCH v2 01/30] mtd: spi-nor: Add config to enable flash DTR
Thread-Topic: [PATCH v2 01/30] mtd: spi-nor: Add config to enable flash DTR
Thread-Index: AQHaKCcYnNz49knuqEOxWlQ2geX+/7Cx3EGAgBHyjnA=
Date: Sun, 31 Dec 2023 17:57:48 +0000
Message-ID: <BL3PR12MB64506B6013FFB4CFAD2D0746D863A@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
 <86732ea5dfb703525e50bfbfbdeea188832611c1.1701853668.git.tejas.arvind.bhumkar@amd.com>
 <CAMty3ZDaZO_QCSx0MNUdtHqfzyDB-uRKc3QN+fRj02TzkCsMAA@mail.gmail.com>
In-Reply-To: <CAMty3ZDaZO_QCSx0MNUdtHqfzyDB-uRKc3QN+fRj02TzkCsMAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=357ee995-a2cf-48f2-9bb2-38fbbdf4e6a3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-31T17:34:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|SJ2PR12MB7798:EE_
x-ms-office365-filtering-correlation-id: aa83bbc5-fdb2-4281-b9f3-08dc0a2a0012
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nYxAi/mpeD60mK4WPIL9T6qRC4AIiD7ZMd6FxkKFtF6EtXTeQ7XxVJMuk+3uX64nFHQU53DVDEOLOHCFfbaIa2mPPz1tAl3Cm3OsHFKpZQ64yeBN4gUNl0QfhtJ62MwlvFkbwn2cUE+0iYHA9XseXeBa9z10AgAWsHb7DVmv92CMW6QQrm8K1BnpzfvA+eqfn6EBHDDIj/loegXYG5NmkQKejn8vfby8hD8u6xi5sZfrcJkAisd9mFu4DXV5Bi4BfNhIsv460gjRxQGW3S0u5DYBes+GByb8mk2qtecKBc64JzYxCGKjcTai8DgIYoODki++OFDiz1MgORsGAjtiVwC7pcWI69LrQQqC6ZFuIVyRe6vk3HRZ0E+AbxK6WRq++gktnAwpXvxbPKgA/rMZVaJP/4R21nJrV4c/LE3mCm48v9LiDUyxX2vxK5fY9bsOcdEJX/qNRnX674mgzaDEhCQ8rZ8TF8VXf5RhrmONcEaheW1UxlwGiy9pD/tSKIDDBFuxLqdpSVc5EVNfMch6QrcTbEVsmqhgpQ6BLIi6ARz9pMZRCoy0ykr1C2XtnXC/8r49Z2MAMEa4qmaNWAAqgK39KWtrLuXaylIbIJq6W+oDqnkl4KmMsvCRQknPQ2atDGWQf8UtntDsmwDx9vcY/2YEu4/nVo1hWENlPadjZs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6450.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(8936002)(8676002)(316002)(54906003)(4326008)(52536014)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(71200400001)(83380400001)(53546011)(7696005)(6506007)(9686003)(26005)(5660300002)(2906002)(41300700001)(33656002)(38070700009)(122000001)(38100700002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TENyTWFVeCtJbkdGUHVRMzVuY3Mxd3c0R0hDL3pJcE9ZT285M0luQVNsS1NG?=
 =?utf-8?B?RncwdHZBbmlMc0ltMjkyNGV3QkloeEU0ZkNKYXhpVlMwYi9Sd29NNk1UUFZM?=
 =?utf-8?B?SFQ2VjJDa2N6dDUzU04wbmRzZWRPYXNCaFRXQXEwZlg3dldlc1FmaDRiaUo0?=
 =?utf-8?B?VHlCNENNODc3d3Zjd3YyOHV6U0dKWlJaZnVVelFKbXVtM2tuRmxrcFJyMEVp?=
 =?utf-8?B?ZFRqcWNhRWFmc2RMbURKaEIvSHVvemVtQ0g0Kzh1clJzVGdFUUJ4OG9KaGE1?=
 =?utf-8?B?ODFNSlFCcXlqMEozRUZ3c0RyZnBWQ04wdzBhRVJERStndU5EcEx5YVRCZXpR?=
 =?utf-8?B?b0NNY25CRmhWNVptaldLU1c4MXVrb09rMVRqR3IrVTc4RFoxQ1lteTZYZnd3?=
 =?utf-8?B?SE5MY3FPdTVEOWtWQnJtTVZLWWJyWDFUZDdpTnp5Ny9yRnFPUDlSejNJeGhP?=
 =?utf-8?B?b1I5Rkp6cmxJKzFEaXNKNXREVXJPQUdnTVhKbWhxaG56MDM1RHZxMUpQQVBK?=
 =?utf-8?B?WmxBNmdOb29GaVRDa3M1TUhYZnBVQll5Vmd5Mm8yUWdRRXhtYVB0RmR3K2I4?=
 =?utf-8?B?RWpWd0h0d0Zlbm0zaENHdTBOOS9VQ0lEdVNLMk1FUFlCbmU1NWJhM0RjN1NO?=
 =?utf-8?B?Z3ROZEFieTgzeUl0Y1c0WkhEd2oySm1RVWhzMU5GaEVFVk5obVh2UHBaYnY5?=
 =?utf-8?B?TWl4RHFlNlNnd2ViT2hqM1dteU42NzF4dm1wWnBxUHNranVPYVFVa1VuMUhu?=
 =?utf-8?B?UlJCM1N1d0Q4eXppRDlPVlFNdnhDVWtLNEZ5c2dmbFBSclVmNjhJdzI5UlJS?=
 =?utf-8?B?VE1SQm4ybmV6UjIwaDlkUjRzRFR5MGpud0tZOUlhQ2c0ZlhiQk44M0FJQ0JH?=
 =?utf-8?B?cWhCODlLcTM1TWdDUjZjREtLOWpHMnBDZ05SL25kd21Vd2dkRUdUd0VuNmI1?=
 =?utf-8?B?dTVTRExOdnVlOXdMcFJGVTVva2FIZmI4QmY0ZDZsV0hOYk9vRVVjdnRId3ha?=
 =?utf-8?B?UFowN2N0T1dPeDFNa3BYd3E0NDYyaTZFZUhXVENRU1g5RUdQanVJdVpQKzJy?=
 =?utf-8?B?djRnbnJvUzFtc2loSnRMSTRRRkNtRlVWWnp4SlhBcDZNeGhEL1RtVmNWZXdm?=
 =?utf-8?B?SHZuNkowUFZNQUJtY29XVzQ5bk5YNVdpbFJBSkc5MStaQ0Z5dGIyVVN3WlBi?=
 =?utf-8?B?aWZvMzhCQWxjQnhnQnQwcGpDWUdDMmE2WldSQ2FYa2lVMkg5WEdTTnQvNzFV?=
 =?utf-8?B?K0RzMkkvN1BkQndSekZUR3VMOVZsM1o3Q0RRbVJUSmdhVDVxT09FSXp2NmZk?=
 =?utf-8?B?ejExRHkyMlBxQ1JsZ3d5MGJhcDJNcGRVSzhic2FqM1RFSXVMNWdSTzNtWExZ?=
 =?utf-8?B?TVUrSlUyL3pvYVRmMzFvbVh2SXE5TjhVMlRpb3NGRkQrazBueUUwSC92Szhx?=
 =?utf-8?B?TXRQRTVGemtPNUl2WE9IajhMQlVwZ0FYYm9laVhWSXlQVlNUY1RsUERXcEFx?=
 =?utf-8?B?RXlZbDluc2k5ak8yeHpaKzhQNWNIS3RtTEh5ZlRVMHpQRVp4YW9PZjVaaXBn?=
 =?utf-8?B?K0JieXJDK2hUTEpxRnBrVStUam5ZdTVTNFQycGVJUHVtbWdIYlNMZ0ltNHJT?=
 =?utf-8?B?NXFWaWhuSk1MdTJlRGx1WVdRNldrZlIyZVhicVd5NmRrNTR2SDdHb3FocXd4?=
 =?utf-8?B?M01udlQvK1ZVZkhpUXR0SXIxSmRDWllPWUdPcW9Pc25LeWhqUWhGMGsxVGRs?=
 =?utf-8?B?Q004UlZiczR3cHJ3NGl3TWxuZFMrSTMxbnk5MTl6U1dOZ0lsYmZQOWYxOUNj?=
 =?utf-8?B?MkhSMWxzaGNnUWtYREpSVU1xam11KzllZ0QxM3h3UVpJeFB2eUFNMFFQV3JQ?=
 =?utf-8?B?N04vNzk3eXh5MnRaNzBEMzNRbGhRRStlaTVVQVFZOGdxdno5bndhWnhhVHlr?=
 =?utf-8?B?bjZSYmtKT1RNeEUvTkIrbnR5dFZSa1BOcU92VFJFVTI0UzJQYXhncElNdFFk?=
 =?utf-8?B?dHhDZW1UaG1aV254a3JweTc5UmFzN3laVFlLbXROVHBCTktIblN3ZGw2YW1i?=
 =?utf-8?B?QnBSOUl3Ni9mT2R2ZzRqTi9kUUdRaEdqN3Bpa2hmN0UvMUMvbE12ZHkxaGNS?=
 =?utf-8?Q?swF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6450.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa83bbc5-fdb2-4281-b9f3-08dc0a2a0012
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2023 17:57:48.5303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CM4P7mdEXDMRKdZv6PtRO/6hc7oT9N6TSIPfXKtE0g+QFikM+BGbGgtgisCHrors7q+hK+G1rIS83FUMDDPOsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEphZ2FuLA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphZ2FuIFRla2kgPGphZ2FuQGFtYXJ1bGFz
b2x1dGlvbnMuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDIwLCAyMDIzIDE6MDAg
UE0NCj4gVG86IEJodW1rYXIsIFRlamFzIEFydmluZCA8dGVqYXMuYXJ2aW5kLmJodW1rYXJAYW1k
LmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBqb2UuaGVyc2hiZXJnZXJAbmkuY29t
OyByZnJpZWQuZGV2QGdtYWlsLmNvbTsNCj4gU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFt
ZC5jb20+OyB2aWduZXNockB0aS5jb207IGdpdEB4aWxpbnguY29tOyBUDQo+IEthcnRoaWsgUmVk
ZHkgPHQua2FydGhpay5yZWRkeUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAx
LzMwXSBtdGQ6IHNwaS1ub3I6IEFkZCBjb25maWcgdG8gZW5hYmxlIGZsYXNoIERUUg0KPg0KPiBD
YXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4g
VXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcg
bGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFdlZCwgRGVjIDYsIDIwMjMgYXQgMzow
MuKAr1BNIFRlamFzIEJodW1rYXINCj4gPHRlamFzLmFydmluZC5iaHVta2FyQGFtZC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gRnJvbTogVCBLYXJ0aGlrIFJlZGR5IDx0LmthcnRoaWsucmVkZHlAYW1k
LmNvbT4NCj4gPg0KPiA+IFRoZSBzcGktbm9yIGZyYW1ld29yayB3aWxsIHNldCB1cCB0aGUgZmxh
c2ggcGFyYW1ldGVycyBieSByZWFkaW5nIHRoZQ0KPiA+IGZsYXNoIGlkIHRhYmxlIGZsYWdzLCB3
aGljaCBpbmNsdWRlIGNtZCBvcGNvZGVzLCBhZGRyZXNzIHdpZHRoLCBkdW1teQ0KPiA+IGJ5dGVz
LCBhbmQgYnVzIHdpZHRoLiBJbiBjYXNlLCBmbGFzaCBzdXBwb3J0cyBvY3RhbCBEVFIgbW9kZSBh
bmQgdGhlDQo+ID4gY29udHJvbGxlciBkb2VzIG5vdCBzdXBwb3J0IHRoZSBEVFIuIFRoZXJlIGlz
IG5vIHByb2Nlc3MgdG8gc3dpdGNoDQo+ID4gYmFjayB0byBTRFIgbW9kZS4NCj4gPiBUbyBhdm9p
ZCB0aGlzIGlzc3VlLCBjcmVhdGUgYSBLY29uZmlnIG9wdGlvbiBTUElfRkxBU0hfRFRSX0VOQUJM
RSB0bw0KPiA+IGV4cGxpY2l0bHkgc3BlY2lmeSB0byBlbmFibGUvZGlzYWJsZSBmbGFzaCBEVFIg
c3VwcG9ydC4NCj4gPiBUaGlzIGNvbmZpZyBpcyBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPg0KPiBX
ZSBjYW5ub3QgY29udHJvbCBjb250cm9sbGVyIGZpeHVwIGluIGZsYXNoLCBEVFIgcmVhZCBiYXNl
ZCBvbiB0aGUgRFRSIGZsYWcgSSBkb24ndA0KPiB0aGluayBhZGRpbmcgZXh0cmEgQ09ORklHIHRv
IGhhY2sgdGhlIGNvbnRyb2xsZXIgd2l0aCBpbXBhY3QgaXMuDQpbVGVqYXNdIDogQnkgZGVmYXVs
dCwgdGhpcyBjb25maWd1cmF0aW9uIGlzIHNldCB0byBEaXNhYmxlZC4gSXQgc2VydmVzIGFzIGEg
Y29udmVuaWVudCBvcHRpb24gZm9yIG9wZXJhdGluZyB0aGUgZmxhc2gNCiAgICAgICAgYmV0d2Vl
biBTRFIgYW5kIEREUiB3aXRob3V0IHJlcXVpcmluZyBhbnkgYWRqdXN0bWVudHMgdG8gdGhlIG5v
ci1pZCB0YWJsZSBmbGFncy4NCg0KUmVnYXJkcywNClRlamFzLg0KPg0KPiBKYWdhbiwNCg==
