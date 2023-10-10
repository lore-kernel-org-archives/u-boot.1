Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E40CD80A1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 10:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5470F86DC3;
	Tue, 10 Oct 2023 12:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3qLvFM1H";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3qLvFM1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC09C86DC5; Tue, 10 Oct 2023 12:39:43 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BC386C67
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 12:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Guillaume.Gardet@arm.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5PBt9jAVS00HBp+qwJrppOMUgGNutTtVcCz0kFWyH4=;
 b=3qLvFM1Hk7xC3SS7BKN+s0Xe0yrznTRJ/Eoo9dVEfyVqy9eN5S/EGIEY+ttcA2rW1q7uLxJHp6PnX1WXmc44o9CWvPxX4IEd02aUTH7Ss28hsCxkU8GVisR3DuXaVMsTdxZEpUQvZjSg5nG+FEgCrS1O64QcVT9yF2VWNYytqPU=
Received: from DU2P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::26)
 by AS8PR08MB9314.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:39:36 +0000
Received: from DBAEUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::ae) by DU2P251CA0019.outlook.office365.com
 (2603:10a6:10:230::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 10:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT043.mail.protection.outlook.com (100.127.143.24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.23 via Frontend Transport; Tue, 10 Oct 2023 10:39:36 +0000
Received: ("Tessian outbound fdf44c93bd44:v211");
 Tue, 10 Oct 2023 10:39:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8b5bdf0f6ec3fdcb
X-CR-MTA-TID: 64aa7808
Received: from b58b33e4801f.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 921E261D-9706-4D24-8FA7-03A73BB9FB4E.1; 
 Tue, 10 Oct 2023 10:39:30 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b58b33e4801f.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Tue, 10 Oct 2023 10:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv7L9HJHxy0cLLQDiRBsPS8B0UbGvqOZGQdCKU/Uy16MtdKANtkcUT0AvUTAFvyMO2f1wyHwJSwmcOqR90Vm6ft2YUcEO5AEw6w+s3fXYQ+pzwgXP+Z8zyi+XIJqFLbBS1wVEcUyqpKhhNS5yAAFjhFaVykwMpDXRRcXhnXXHhDhOdDY17uyaf2fgyM4oVUJlEnUAYmQVjWMOtjKKFD379fRpNxRKJICOaJLBiQjbSsCHmPvqRpiwKJnxdJor5ZXLEmC+cRmy+DOvoeepkVcEggAikohay3JK4jiiZyE1Ikq9NvI+7ansUsJFtU+oAlvxQmGCcZvuzrU+a6LxdpsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5PBt9jAVS00HBp+qwJrppOMUgGNutTtVcCz0kFWyH4=;
 b=kZVnuMqrqx0A7k3GQfTH/y9az8e5JdHspyj5aAGXgs/LDUAG02XEMRTcFKHvn4yfno124jZ/ZFAE9y0Rk4vs3FM5fqT3fzWYLb2HZuvYKPt6/qHrarGpjAE18GqrW55+kiiJl4apOfHVwQ5MdjUtXxDbeoz7oQKDhh6tO+UVA2VyLXkyGxBlgN0EMwMl2ue4vNNiumqEya34/No9DXuRFUPGrAnlm6te6B9zlhVO9GUJHy7yOoeXwo7AtEmjdo/XNNR2OpHXz3LmngCZsg3+C4qnEaGJJmGi7JZZIbtFBSeSRtE+INIvlKl23zPuYslICCBrMGJg47RBU3gJdAtTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5PBt9jAVS00HBp+qwJrppOMUgGNutTtVcCz0kFWyH4=;
 b=3qLvFM1Hk7xC3SS7BKN+s0Xe0yrznTRJ/Eoo9dVEfyVqy9eN5S/EGIEY+ttcA2rW1q7uLxJHp6PnX1WXmc44o9CWvPxX4IEd02aUTH7Ss28hsCxkU8GVisR3DuXaVMsTdxZEpUQvZjSg5nG+FEgCrS1O64QcVT9yF2VWNYytqPU=
Received: from VI1PR08MB2847.eurprd08.prod.outlook.com (2603:10a6:802:19::31)
 by DU0PR08MB9904.eurprd08.prod.outlook.com (2603:10a6:10:474::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 10:39:28 +0000
Received: from VI1PR08MB2847.eurprd08.prod.outlook.com
 ([fe80::a3db:b677:3bb0:fa47]) by VI1PR08MB2847.eurprd08.prod.outlook.com
 ([fe80::a3db:b677:3bb0:fa47%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 10:39:26 +0000
From: Guillaume Gardet <Guillaume.Gardet@arm.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: "mbrugger@suse.com" <mbrugger@suse.com>, Ivan Ivanov
 <ivan.ivanov@suse.com>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Topic: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Index: Adn7Wr0e+LRv6MRIS4aqQVJurtxargACOEoAAAB9fxA=
Date: Tue, 10 Oct 2023 10:39:26 +0000
Message-ID: <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
In-Reply-To: <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: VI1PR08MB2847:EE_|DU0PR08MB9904:EE_|DBAEUR03FT043:EE_|AS8PR08MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 1131fd99-b30e-46ab-dc33-08dbc97d32b4
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Ps3j7/dUuXx5GllyboxFNr7LU08R0YVvLozjgh3Y4fyBbVGlQFYUN9NyoS/6LL2Hwaxbz/BdEku77PyLgBlB+duCBgP6XpTNT9F39GBS3wFTcLhRdFZHx6sDP0vPUGQaZ8xIWvlO1j+qI7vniyLG+r22tHV4IL0zqQGt4xzDA38om6V4pxHPRvu6xTHrUR5A4KZaqcOBu2d7w5e1jF23Z+OZqmyjzK3ovcxYeuxboUapTOA5eHvqkjOMcgkS/8XGD/Qe5geCa8HUREy9+Cp9jIMe+QuC31A34Zq4vMPdbhKkfcYvJPiYZkRrornvGLIetOeMxpiumT4tZMBtqxAaycbe5HrZh7+zZ4W7NpHm9k7zZXNtoQUPnj4Io91TvNDnWnBjd7Iryie8bFvqUgZX2GMdLwPwkMwAjSJ6hB7IwtOB7Xaoy+ekhcy7k+cqo4yVL0o0cBqxkv4f+Nlnt56CiZ1XHSj00qAwleadogpJW77M2/l6gy6aVl1kuU5O0uxSclRV8Mo1zHwALEeuFrRFLDsXeSWttECOTGtOLUwkjaVNlOZRnH0w9J0udzfUFrR+V76cnMBlLuAuk/EZiDeqE3MVKk21GOsqybC3dloKTAc+BhdQdqqv5bk9KaEHV+R7BTokCa6RZLr2OGDzm3/ZIg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI1PR08MB2847.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(38070700005)(122000001)(38100700002)(33656002)(2906002)(55016003)(478600001)(9686003)(41300700001)(53546011)(52536014)(4326008)(6506007)(5660300002)(7696005)(8936002)(71200400001)(316002)(966005)(83380400001)(64756008)(66446008)(66556008)(66476007)(6916009)(66946007)(8676002)(76116006)(54906003);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9904
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a884512d-c035-40c5-74b7-08dbc97d2d0e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9MMoRbNXbRVW/VqymbbIaqPXie3ktLyqelhxA3mYTPIutANr/rEmTB6t7In8fZlgpFcHiprdMcxRQCOFm67vEiIzW8ZO7WPEMde2JtOsjBI5f+4Of0AllGhAodau+OHPqFbnHJ2b2IuWeSjxIUJPbjnV8D54pjqnVXJ5sFiPvpQxfzPPQSMndGV4ychQVZ6j6F4rGuQHs3iTn27MkK9spbzxmGxubv5XJgMKxvanJgAlzCV/C8R7t2qbEMLvnu4htTqZNiatydZhf0/eFIHxwSlNNdQdiiF+9g3h5X9VJf3jRs0ZMaiwsEb2ooGH/9HrNxGbduwNvHyfHbwZoIZtzJRS+VaCjGG9ZK9ZBP9mUlYlTQMavyOvNrvnLOemaeOPdG/GAyyyfWUNCx/LFM648ACu1mRuMNfpITRaaJ+qpdF+1ekCc0dtGafY3+wJ9djcg466TBq7uRHKcTedc1NoV/lfCYk+wQAwuq+wigrMgDsA8bilnyMCk0R9+gSWnu02oFpFOkBOMkSzra0OsuGGU0OZC3bB3eeKf2uxoI85SChYZSbHpJqYdVvItSt37xYM3RALKHSH5GiC75I9QSL84zBNNeW8QubKu0g4X0VughP1bmTNWeLmatJ/B9EoshZuHWluxPXS8dEKGb4L7EcY3h5GsHas9EV0Dh7oZJt/WdJ6E8srPXYK/ZgoNHFOlNNPBI8k7ESZsFNmM5b6URkPgBiFrMfc21bVruqAnN9KfByZ+QQ2jY8s1cA2H+GHcxCCYKhwaTNGWdmQUjPsrYCiw==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(55016003)(40480700001)(40460700003)(966005)(53546011)(7696005)(6506007)(83380400001)(336012)(9686003)(26005)(41300700001)(4326008)(6862004)(478600001)(8936002)(8676002)(5660300002)(52536014)(2906002)(54906003)(316002)(70586007)(70206006)(47076005)(82740400003)(81166007)(356005)(33656002)(86362001)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:39:36.1865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1131fd99-b30e-46ab-dc33-08dbc97d32b4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9314
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgUm9iaW5zb24g
PHBicm9iaW5zb25AZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEwLCAyMDIz
IDEyOjIyIFBNDQo+IFRvOiBHdWlsbGF1bWUgR2FyZGV0IDxHdWlsbGF1bWUuR2FyZGV0QGFybS5j
b20+DQo+IENjOiBtYnJ1Z2dlckBzdXNlLmNvbTsgSXZhbiBJdmFub3YgPGl2YW4uaXZhbm92QHN1
c2UuY29tPjsgU2ltb24gR2xhc3MNCj4gPHNqZ0BjaHJvbWl1bS5vcmc+OyB1LWJvb3RAbGlzdHMu
ZGVueC5kZQ0KPiBTdWJqZWN0OiBSZTogVS1Cb290IDIwMjMuMTAgZG9lcyBub3QgYm9vdCBmcm9t
IHVTRCBvbiBSUGk0DQo+DQo+IE9uIFR1ZSwgT2N0IDEwLCAyMDIzIGF0IDEwOjI24oCvQU0gR3Vp
bGxhdW1lIEdhcmRldA0KPiA8R3VpbGxhdW1lLkdhcmRldEBhcm0uY29tPiB3cm90ZToNCj4gPg0K
PiA+IEhpLA0KPiA+DQo+ID4gVS1Cb290IDIwMjMuMTAgZG9lcyBub3QgYm9vdCBmcm9tIHVTRCBv
biBSUGk0Lg0KPiA+IFRoaXMgaGFzIGJlZW4gZm91bmQgb24gb3BlblNVU0UgVHVtYmxld2VlZC4g
VGhlIG9ubHkgZGlmZiB3ZSBuZWVkIGlzOg0KPiA+ICAgLUNPTkZJR19PRl9FTUJFRD15DQo+ID4g
ICArQ09ORklHX09GX0JPQVJEPXkNCj4gPiBUbyB1c2UgZmlybXdhcmUgcHJvdmlkZWQgRGV2aWNl
IFRyZWUuIEJ1dCB0aGF0IHNob3VsZCBub3QgYWZmZWN0IHRoZSBtbWMNCj4gYmVoYXZpb3IgdG9v
IG11Y2gsIEkgdGhpbmsuDQo+DQo+IEkndmUgYmVlbiBib290aW5nIEZlZG9yYSBmaW5lIG9uIGEg
UlBpNCBCVVQgdGhlcmUncyBpc3N1ZXMgd2l0aCB0aGUgZGlzcGxheQ0KPiB0dXJuaW5nIG9mZiBb
MV0gd2hlbiB0aGUgYWNjZWxlcmF0ZWQgZGlzcGxheSBtb2R1bGVzIGxvYWQNCj4gKHZjNCkgYXMg
YSByZXN1bHQgb2YgdGhpcyBwYXRjaCBzZXQuIENhbiB5b3UgY29uZmlybSBpZiB0aGF0J3MgdGhl
IHNhbWUgcHJvYmxlbQ0KPiB5b3UncmUgc2VlaW5nPw0KDQpObywgdGhhdCdzIG5vdCBteSBwcm9i
bGVtLiBNeSBpc3N1ZSBpcyBncnViIHdhcyBub3QgbG9hZGVkIGJ5IHUtYm9vdCBmcm9tIHVTRC4N
Ckl0IHNlZW1zIG1vcmUgbGlrZSBTaW1vbidzIHByb2JsZW06IGh0dHBzOi8vbGlzdHMuZGVueC5k
ZS9waXBlcm1haWwvdS1ib290LzIwMjMtT2N0b2Jlci81MzMxNjIuaHRtbA0KDQpAU2ltb24sIGNh
biB5b3UgY2hlY2sgaWYgdGhlIHBhdGNoIGJlbG93IGZpeGVzIHlvdXIgYm9vdCBwcm9ibGVtIG9u
IFJQaTQsIHBsZWFzZT8NCg0KVGhhbmtzLA0KR3VpbGxhdW1lDQoNCj4NCj4gWzFdIGh0dHBzOi8v
bGlzdHMuZGVueC5kZS9waXBlcm1haWwvdS1ib290LzIwMjMtT2N0b2Jlci81MzMxNTguaHRtbA0K
Pg0KPiA+ICdnaXQgYmlzZWN0JyBwb2ludHMgdG86DQo+ID4gKioqKioqKioqKg0KPiA+IGNvbW1p
dCBjNzcxZTViOGMyYTE4NmZiMDcyYjZjNmY1NzFkNGEzY2M4NmVmYmE5DQo+ID4gQXV0aG9yOiBT
aW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiBEYXRlOiAgIFRodSBKdWwgMjcgMTU6
NTQ6MjggMjAyMyAtMDYwMA0KPiA+DQo+ID4gICAgIGFybTogcnBpOiBTd2l0Y2ggdG8gc3RhbmRh
cmQgYm9vdA0KPiA+DQo+ID4gICAgIERyb3AgdXNlIG9mIHRoZSBkaXN0cm8gc2NyaXB0cyBhbmQg
dXNlIHN0YW5kYXJkIGJvb3QgaW5zdGVhZC4NCj4gPg0KPiA+ICAgICBXZSBkb24ndCBuZWVkIHRv
IHNwZWNpZnkgdGhlIG1tYyBkZXZpY2VzIGluZGl2aWR1YWxseSwgc2luY2UgdGhleSBhcmUNCj4g
PiAgICAgdXNlZCBpbiBvcmRlciBmcm9tIDAgdG8gMiwgYW5kIHN0YW5kYXJkIGJvb3QgdXNlcyB0
aGF0IG9yZGVyIGFueXdheS4NCj4gPg0KPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBHbGFz
cyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiAqKioqKioqKioqDQo+ID4NCj4gPiBUaGUgZm9sbG93
aW5nIHBhdGNoIGZpeGVzIHRoZSBib290IGZyb20gdVNEIG9uIFJQaTQgKG5vdCB0ZXN0ZWQgb24g
UlBpMyBub3IgUlBpDQo+IFplcm8gMiBXKToNCj4gPiAqKioqKioqKioqDQo+ID4gZGlmZiAtLWdp
dCBhL2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuZW52DQo+ID4gYi9ib2FyZC9yYXNwYmVycnlw
aS9ycGkvcnBpLmVudiBpbmRleCAzMDIyODI4NWVkLi4wMjIxMGI5N2I1IDEwMDY0NA0KPiA+IC0t
LSBhL2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuZW52DQo+ID4gKysrIGIvYm9hcmQvcmFzcGJl
cnJ5cGkvcnBpL3JwaS5lbnYNCj4gPiBAQCAtNzQsNCArNzQsNCBAQCBweGVmaWxlX2FkZHJfcj0w
eDAyNTAwMDAwDQo+ID4gIGZkdF9hZGRyX3I9MHgwMjYwMDAwMA0KPiA+ICByYW1kaXNrX2FkZHJf
cj0weDAyNzAwMDAwDQo+ID4NCj4gPiAtYm9vdF90YXJnZXRzPW1tYyB1c2IgcHhlIGRoY3ANCj4g
PiArYm9vdF90YXJnZXRzPW1tYzAgbW1jMSBtbWMyIHVzYiBweGUgZGhjcA0KPiA+ICoqKioqKioq
KioNCj4gPg0KPiA+IFNvLCB0aGUgY29tbWVudCBmcm9tIFNpbW9uICIgV2UgZG9uJ3QgbmVlZCB0
byBzcGVjaWZ5IHRoZSBtbWMgZGV2aWNlcw0KPiBpbmRpdmlkdWFsbHksIHNpbmNlIHRoZXkgYXJl
IHVzZWQgaW4gb3JkZXIgZnJvbSAwIHRvIDIsIGFuZCBzdGFuZGFyZCBib290IHVzZXMgdGhhdA0K
PiBvcmRlciBhbnl3YXkiIHNlZW1zIHdyb25nIGZvciB0aGUgUlBpNCBjYXNlLg0KPiA+DQo+ID4g
Q2hlZXJzLA0KPiA+IEd1aWxsYXVtZQ0KPiA+DQo+ID4gSU1QT1JUQU5UIE5PVElDRTogVGhlIGNv
bnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUNCj4gY29uZmlkZW50
aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50LA0KPiBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5k
IGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55DQo+IG90aGVyIHBlcnNvbiwgdXNl
IGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4g
YW55DQo+IG1lZGl1bS4gVGhhbmsgeW91Lg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRz
IG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBt
YXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNj
bG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVy
cG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhh
bmsgeW91Lg0K
