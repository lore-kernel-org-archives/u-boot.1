Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B955CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 10:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C7ED86E02;
	Fri, 13 Oct 2023 12:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="u+wakSRR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="u+wakSRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E52586B95; Fri, 13 Oct 2023 12:09:18 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CD986B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 12:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Guillaume.Gardet@arm.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9A8vbNTNGiQGf+2DRo/yD4s/6IMXJZ9VIk+uOuNhqk=;
 b=u+wakSRR4YIEDtILzdvVWlesTHJ456aMK5qX69er+Rc3B6PJDwyBCm134gpTVok1y8qWkkNzfhpF/304t5TXFJdfYUcI7v12KrGL57FGmOajuX2yqDGjGpG/QB7snpl/4JdpwioLNU4kQ99Gu30p0O1DIjE5rrYjuHhEX6ZzCbA=
Received: from DB9PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:1d9::16)
 by DU0PR08MB7462.eurprd08.prod.outlook.com (2603:10a6:10:355::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 10:09:06 +0000
Received: from DBAEUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::86) by DB9PR02CA0011.outlook.office365.com
 (2603:10a6:10:1d9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 10:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT025.mail.protection.outlook.com (100.127.142.226) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.18 via Frontend Transport; Fri, 13 Oct 2023 10:09:06 +0000
Received: ("Tessian outbound 0ae75d4034ba:v211");
 Fri, 13 Oct 2023 10:09:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f9a62b1c7a921fe1
X-CR-MTA-TID: 64aa7808
Received: from b57b2995af0c.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 9AC614C8-8ED6-448F-9E19-F165AF741026.1; 
 Fri, 13 Oct 2023 10:08:59 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b57b2995af0c.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 13 Oct 2023 10:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCg7dpFqjf5cH+AUyQLaVRT3p81iyB9ITeW+lIwc/1MqLrarhdWvniWcHZVnnb6ywn7p8LUWCR7w5j6Ra3w8r08rorplcBkU0Usd3e8RwRo9Tpb58UBBSkWi47o36N2cvkfsMPIBOVBCb7LJr8d6uh3ihteMmh1LGFmnEpa6X3a5i50qKh7k5noSpHaISQ8rdhCnDMvQw0MTYIPyHvAgGFoVIl7zpAT3x7DZgCFD1G6TS49+Bvz1bn4bxXM+H2TrBn4bXSCb9b14YbXn71HCjtIU3nkC7EmBkVXGYFGaFh9b5QkGV9rBoMcfnjQ0f6cOXk52axDPHnoPfSm4VNsWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9A8vbNTNGiQGf+2DRo/yD4s/6IMXJZ9VIk+uOuNhqk=;
 b=VtIrlzEuKL9qcBzefbo4SWujjoc+4PATB6PBN3a8vLBrZMf5BcVh08abXcz6/EJh7GHOakWfYilrijtm3vSibRj5DKpNSh24FU2SYn6hFGgbKB+cpBW67ShL7xZXiILwW1weczL3KZ5/SdsvpTcJHvnZZ+e/eOOnjmS2asJ8osTZKBKvpRW41sDPiORPi6s6GjJHvRH5Q3NlvSytXxRi1nU4LpB2gmW+8h2dVASb8Sm266oPGrwwNqlmjDYovYrbKEWatk0I2vSihLeWAyTUvYFG5kN+HYPHHtXfyXQw1StmZMVfQfba9ilDQfg/7kucLj3XIG9qnEuHuQCbR0n8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9A8vbNTNGiQGf+2DRo/yD4s/6IMXJZ9VIk+uOuNhqk=;
 b=u+wakSRR4YIEDtILzdvVWlesTHJ456aMK5qX69er+Rc3B6PJDwyBCm134gpTVok1y8qWkkNzfhpF/304t5TXFJdfYUcI7v12KrGL57FGmOajuX2yqDGjGpG/QB7snpl/4JdpwioLNU4kQ99Gu30p0O1DIjE5rrYjuHhEX6ZzCbA=
Received: from VI1PR08MB2847.eurprd08.prod.outlook.com (2603:10a6:802:19::31)
 by VI1PR08MB5517.eurprd08.prod.outlook.com (2603:10a6:803:139::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 10:08:57 +0000
Received: from VI1PR08MB2847.eurprd08.prod.outlook.com
 ([fe80::a3db:b677:3bb0:fa47]) by VI1PR08MB2847.eurprd08.prod.outlook.com
 ([fe80::a3db:b677:3bb0:fa47%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 10:08:56 +0000
From: Guillaume Gardet <Guillaume.Gardet@arm.com>
To: Simon Glass <sjg@chromium.org>
CC: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger
 <mbrugger@suse.com>, Ivan Ivanov <ivan.ivanov@suse.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Subject: RE: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Topic: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Index: Adn7Wr0e+LRv6MRIS4aqQVJurtxargACOEoAAAB9fxAACSUYgACMvy5Q
Date: Fri, 13 Oct 2023 10:08:55 +0000
Message-ID: <VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1PR08MB2847.eurprd08.prod.outlook.com>
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: VI1PR08MB2847:EE_|VI1PR08MB5517:EE_|DBAEUR03FT025:EE_|DU0PR08MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bece3ec-b265-44c9-a8da-08dbcbd46f55
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: K0dP/xdE1Olp5k0pno1F0ToBczELMgJFHy4h0dHjxwX6tjDyIkKutwtAa8U8GQFbLRyMFKtxeyt9lB7AVV1jkdHd88IgCfB1Mt3171o7PJHEsNxQhUdeD29Mf7Sh2+buc+YeKU4n0AeIVqJQtNG1raydeDFe8Z8Uf8VZG2SeeUm3eIExQblq4c2ZjZGb3jYKaAHEk8NVjZX3wzqmqUIkKdcAG/8qrLSKf7PnKpOxPN453bpDRedliQ2c9F8pOG49SVIFKqo0bRhVW5O8AxSj2SbWjQEyyjPwjYwgIzj2+lrYaelhnq6kt8e14eao8IP7jcC621m/q+l87CbFExoA9jIUnD46EOYaAPGByjdMCRMsNzD5OIq3N0jPIMIND6dFf90FpTMWpTIo08PazS7t3jfpmwiEAoRm61rLbp4tuwav5Rpkn7dIT8C8ITQ1r8eytrB3tsBMTDHmE6GtbldT21Rptdoyh+DBMH2tRFY94HujnzjzKOGcx49bI4A+mSyb6hYy/esjtum5tBcryPnPgDAdNR+TpLegVATq5kz/yNGoSmeTUIU/7UXCiHD6cZaCRfDgILDk+OmUd/mjBgGiPP9MTunSe83Yh7yenq5D140qun31Vz3ZN0xCxyDgdHZbIl09n0rWD51Sgfrzw8pabw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI1PR08MB2847.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(5660300002)(52536014)(21615005)(64756008)(66556008)(66476007)(76116006)(66946007)(316002)(6916009)(54906003)(66446008)(2906002)(33656002)(83380400001)(166002)(9326002)(4326008)(8676002)(8936002)(41300700001)(38070700005)(478600001)(38100700002)(122000001)(966005)(86362001)(53546011)(6506007)(7696005)(71200400001)(9686003);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5517
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e4b450a-bd78-4183-38e3-08dbcbd4691c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJsclLe/wsabsKgxEMCmI0Pi6oRwbApTxfe1FADoSlqzH+7Y/ZGo9Lj1Y5WlbXd64Yu99TH/Kky1W3SrSBKgtjbbuO0epklG9+Cg3zJympRseL5aH0bXzQDJFo40Ci7qoXl21pp2PUO3dDzvfnZ1wqC9ISnfcWD5qhWBPY46/pvXnccOe7rYaRQAPDRILkh3To1c13VCKgOnvm6QP+MUZSTSbKgFuIno1vQR3OXS9jOPOh1kIaKbcXMRilMApOUcbZwjrmQXMuMANQOcfqDfXtIHrEtjK0WH+wLzgLJrwzRH4+xvjdugUFHy1aALmKiZSdfvj4xB53Ha8PkwKSASTt2STi6jO84J8xiqomH+9jNs1aaecfvY42X/xZt+ZVuvTnnjmi7dMfgNrd57raKk2+adWXXNynjRKVEcTZcDtWNXtxo0qLaFSiAAfc9zqapSFwRwsf45x/4rGr5exh4ukdeeybV6CR2zcqmYGRYYfe31DC+p17T6ohOAHv+0kOPQMCtmfN2/viNC3K5GajjXlL6v/CxXQI/1xVCFbH79IqRb7ucZYu6qkRjvomZFdqXZR5AzfgprE7/qJx69rICLe7K7tJVRSbk4pfb8Usbapthk6rAb9rvu6Jr/WkP4Lz3f5OTPVu3ysIdeX5Dyo+PwFuaGb0VoPIFhRA1mZ1aNwR20vjmsRgANAtIptIRKhiyzysXX6AM6+Fy+31RIEPyw5rX2lVu5sg/j8nAa0FPDxCS6fCxDoB1bP5uA0vj5ruT4TOnOrvfwalU9PsPmCs0dQA==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(6862004)(52536014)(8936002)(8676002)(5660300002)(316002)(9326002)(41300700001)(54906003)(2906002)(70206006)(7696005)(83380400001)(336012)(6506007)(966005)(53546011)(70586007)(21615005)(33656002)(9686003)(36860700001)(82740400003)(166002)(4326008)(478600001)(356005)(81166007)(47076005)(26005)(86362001)(55016003)(40460700003)(33964004)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:09:06.4290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bece3ec-b265-44c9-a8da-08dbcbd46f55
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7462
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

SGksDQoNCkluZGVlZCwgeW91ciBwYXRjaCBbMl0gZml4ZXMgbXkgYm9vdCBwcm9ibGVtLg0KDQpU
aGFua3MsDQpHdWlsbGF1bWUNCg0KDQpGcm9tOiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9y
Zz4NClNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMgNDo1OCBQTQ0KVG86IEd1aWxsYXVt
ZSBHYXJkZXQgPEd1aWxsYXVtZS5HYXJkZXRAYXJtLmNvbT4NCkNjOiBQZXRlciBSb2JpbnNvbiA8
cGJyb2JpbnNvbkBnbWFpbC5jb20+OyBNYXR0aGlhcyBCcnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNv
bT47IEl2YW4gSXZhbm92IDxpdmFuLml2YW5vdkBzdXNlLmNvbT47IFUtQm9vdCBNYWlsaW5nIExp
c3QgPHUtYm9vdEBsaXN0cy5kZW54LmRlPg0KU3ViamVjdDogUmU6IFUtQm9vdCAyMDIzLjEwIGRv
ZXMgbm90IGJvb3QgZnJvbSB1U0Qgb24gUlBpNA0KDQpIaSwNCg0KT24gVHVlLCAxMCBPY3QgMjAy
MyBhdCAwNDozOSwgR3VpbGxhdW1lIEdhcmRldCA8R3VpbGxhdW1lLkdhcmRldEBhcm0uY29tPG1h
aWx0bzpHdWlsbGF1bWUuR2FyZGV0QGFybS5jb20+PiB3cm90ZToNCj4NCj4NCj4NCj4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBldGVyIFJvYmluc29uIDxwYnJvYmlu
c29uQGdtYWlsLmNvbTxtYWlsdG86cGJyb2JpbnNvbkBnbWFpbC5jb20+Pg0KPiA+IFNlbnQ6IFR1
ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMgMTI6MjIgUE0NCj4gPiBUbzogR3VpbGxhdW1lIEdhcmRl
dCA8R3VpbGxhdW1lLkdhcmRldEBhcm0uY29tPG1haWx0bzpHdWlsbGF1bWUuR2FyZGV0QGFybS5j
b20+Pg0KPiA+IENjOiBtYnJ1Z2dlckBzdXNlLmNvbTxtYWlsdG86bWJydWdnZXJAc3VzZS5jb20+
OyBJdmFuIEl2YW5vdiA8aXZhbi5pdmFub3ZAc3VzZS5jb208bWFpbHRvOml2YW4uaXZhbm92QHN1
c2UuY29tPj47IFNpbW9uIEdsYXNzDQo+ID4gPHNqZ0BjaHJvbWl1bS5vcmc8bWFpbHRvOnNqZ0Bj
aHJvbWl1bS5vcmc+PjsgdS1ib290QGxpc3RzLmRlbnguZGU8bWFpbHRvOnUtYm9vdEBsaXN0cy5k
ZW54LmRlPg0KPiA+IFN1YmplY3Q6IFJlOiBVLUJvb3QgMjAyMy4xMCBkb2VzIG5vdCBib290IGZy
b20gdVNEIG9uIFJQaTQNCj4gPg0KPiA+IE9uIFR1ZSwgT2N0IDEwLCAyMDIzIGF0IDEwOjI24oCv
QU0gR3VpbGxhdW1lIEdhcmRldA0KPiA+IDxHdWlsbGF1bWUuR2FyZGV0QGFybS5jb208bWFpbHRv
Okd1aWxsYXVtZS5HYXJkZXRAYXJtLmNvbT4+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEhpLA0KPiA+
ID4NCj4gPiA+IFUtQm9vdCAyMDIzLjEwIGRvZXMgbm90IGJvb3QgZnJvbSB1U0Qgb24gUlBpNC4N
Cj4gPiA+IFRoaXMgaGFzIGJlZW4gZm91bmQgb24gb3BlblNVU0UgVHVtYmxld2VlZC4gVGhlIG9u
bHkgZGlmZiB3ZSBuZWVkIGlzOg0KPiA+ID4gICAtQ09ORklHX09GX0VNQkVEPXkNCj4gPiA+ICAg
K0NPTkZJR19PRl9CT0FSRD15DQo+ID4gPiBUbyB1c2UgZmlybXdhcmUgcHJvdmlkZWQgRGV2aWNl
IFRyZWUuIEJ1dCB0aGF0IHNob3VsZCBub3QgYWZmZWN0IHRoZSBtbWMNCj4gPiBiZWhhdmlvciB0
b28gbXVjaCwgSSB0aGluay4NCj4gPg0KPiA+IEkndmUgYmVlbiBib290aW5nIEZlZG9yYSBmaW5l
IG9uIGEgUlBpNCBCVVQgdGhlcmUncyBpc3N1ZXMgd2l0aCB0aGUgZGlzcGxheQ0KPiA+IHR1cm5p
bmcgb2ZmIFsxXSB3aGVuIHRoZSBhY2NlbGVyYXRlZCBkaXNwbGF5IG1vZHVsZXMgbG9hZA0KPiA+
ICh2YzQpIGFzIGEgcmVzdWx0IG9mIHRoaXMgcGF0Y2ggc2V0LiBDYW4geW91IGNvbmZpcm0gaWYg
dGhhdCdzIHRoZSBzYW1lIHByb2JsZW0NCj4gPiB5b3UncmUgc2VlaW5nPw0KPg0KPiBObywgdGhh
dCdzIG5vdCBteSBwcm9ibGVtLiBNeSBpc3N1ZSBpcyBncnViIHdhcyBub3QgbG9hZGVkIGJ5IHUt
Ym9vdCBmcm9tIHVTRC4NCj4gSXQgc2VlbXMgbW9yZSBsaWtlIFNpbW9uJ3MgcHJvYmxlbTogaHR0
cHM6Ly9saXN0cy5kZW54LmRlL3BpcGVybWFpbC91LWJvb3QvMjAyMy1PY3RvYmVyLzUzMzE2Mi5o
dG1sDQo+DQo+IEBTaW1vbiwgY2FuIHlvdSBjaGVjayBpZiB0aGUgcGF0Y2ggYmVsb3cgZml4ZXMg
eW91ciBib290IHByb2JsZW0gb24gUlBpNCwgcGxlYXNlPw0KDQpUaGlzIGhhcyBiZWVuIHJlcG9y
dGVkIGF0IGxlYXN0IHR3aWNlIGJlZm9yZS4gVGhlcmUgaXMgYSBmaXggWzJdIHdoaWNoIGlzIGlu
IG15IHF1ZXVlIHRvIGFwcGx5Lg0KDQpSZWdhcmRpbmcgdGhlIGRpc3BsYXkgcHJvYmxlbSwgSSBn
b3QgbXkgcnBpNCBydW5uaW5nIGFnYWluIGFuZCBGZWRvcmEgaW5zdGFsbGVkLCBidXQgSSB3b24n
dCBnZXQgYmFjayB0byBpdCB1bnRpbCB0aGUgZW5kIG9mIHRoZSB3ZWVrIGFzIEknbSBhdCBvc2Zj
Lg0KDQpSZWdhcmRzLA0KU2ltb24NCg0KPg0KPiBUaGFua3MsDQo+IEd1aWxsYXVtZQ0KPg0KDQpb
Ml0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIwMjMw
OTIzMjA1MDE3LjE3NTQzNDAtMS1zamdAY2hyb21pdW0ub3JnLw0KDQo+ID4NCj4gPiBbMV0gaHR0
cHM6Ly9saXN0cy5kZW54LmRlL3BpcGVybWFpbC91LWJvb3QvMjAyMy1PY3RvYmVyLzUzMzE1OC5o
dG1sDQo+ID4NCj4gPiA+ICdnaXQgYmlzZWN0JyBwb2ludHMgdG86DQo+ID4gPiAqKioqKioqKioq
DQo+ID4gPiBjb21taXQgYzc3MWU1YjhjMmExODZmYjA3MmI2YzZmNTcxZDRhM2NjODZlZmJhOQ0K
PiA+ID4gQXV0aG9yOiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZzxtYWlsdG86c2pnQGNo
cm9taXVtLm9yZz4+DQo+ID4gPiBEYXRlOiAgIFRodSBKdWwgMjcgMTU6NTQ6MjggMjAyMyAtMDYw
MA0KPiA+ID4NCj4gPiA+ICAgICBhcm06IHJwaTogU3dpdGNoIHRvIHN0YW5kYXJkIGJvb3QNCj4g
PiA+DQo+ID4gPiAgICAgRHJvcCB1c2Ugb2YgdGhlIGRpc3RybyBzY3JpcHRzIGFuZCB1c2Ugc3Rh
bmRhcmQgYm9vdCBpbnN0ZWFkLg0KPiA+ID4NCj4gPiA+ICAgICBXZSBkb24ndCBuZWVkIHRvIHNw
ZWNpZnkgdGhlIG1tYyBkZXZpY2VzIGluZGl2aWR1YWxseSwgc2luY2UgdGhleSBhcmUNCj4gPiA+
ICAgICB1c2VkIGluIG9yZGVyIGZyb20gMCB0byAyLCBhbmQgc3RhbmRhcmQgYm9vdCB1c2VzIHRo
YXQgb3JkZXIgYW55d2F5Lg0KPiA+ID4NCj4gPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBH
bGFzcyA8c2pnQGNocm9taXVtLm9yZzxtYWlsdG86c2pnQGNocm9taXVtLm9yZz4+DQo+ID4gPiAq
KioqKioqKioqDQo+ID4gPg0KPiA+ID4gVGhlIGZvbGxvd2luZyBwYXRjaCBmaXhlcyB0aGUgYm9v
dCBmcm9tIHVTRCBvbiBSUGk0IChub3QgdGVzdGVkIG9uIFJQaTMgbm9yIFJQaQ0KPiA+IFplcm8g
MiBXKToNCj4gPiA+ICoqKioqKioqKioNCj4gPiA+IGRpZmYgLS1naXQgYS9ib2FyZC9yYXNwYmVy
cnlwaS9ycGkvcnBpLmVudg0KPiA+ID4gYi9ib2FyZC9yYXNwYmVycnlwaS9ycGkvcnBpLmVudiBp
bmRleCAzMDIyODI4NWVkLi4wMjIxMGI5N2I1IDEwMDY0NA0KPiA+ID4gLS0tIGEvYm9hcmQvcmFz
cGJlcnJ5cGkvcnBpL3JwaS5lbnYNCj4gPiA+ICsrKyBiL2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9y
cGkuZW52DQo+ID4gPiBAQCAtNzQsNCArNzQsNCBAQCBweGVmaWxlX2FkZHJfcj0weDAyNTAwMDAw
DQo+ID4gPiAgZmR0X2FkZHJfcj0weDAyNjAwMDAwDQo+ID4gPiAgcmFtZGlza19hZGRyX3I9MHgw
MjcwMDAwMA0KPiA+ID4NCj4gPiA+IC1ib290X3RhcmdldHM9bW1jIHVzYiBweGUgZGhjcA0KPiA+
ID4gK2Jvb3RfdGFyZ2V0cz1tbWMwIG1tYzEgbW1jMiB1c2IgcHhlIGRoY3ANCj4gPiA+ICoqKioq
KioqKioNCj4gPiA+DQo+ID4gPiBTbywgdGhlIGNvbW1lbnQgZnJvbSBTaW1vbiAiIFdlIGRvbid0
IG5lZWQgdG8gc3BlY2lmeSB0aGUgbW1jIGRldmljZXMNCj4gPiBpbmRpdmlkdWFsbHksIHNpbmNl
IHRoZXkgYXJlIHVzZWQgaW4gb3JkZXIgZnJvbSAwIHRvIDIsIGFuZCBzdGFuZGFyZCBib290IHVz
ZXMgdGhhdA0KPiA+IG9yZGVyIGFueXdheSIgc2VlbXMgd3JvbmcgZm9yIHRoZSBSUGk0IGNhc2Uu
DQo+ID4gPg0KPiA+ID4gQ2hlZXJzLA0KPiA+ID4gR3VpbGxhdW1lDQo+ID4gPg0KPiA+ID4gSU1Q
T1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBhcmUNCj4gPiBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsDQo+ID4gcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRv
IGFueQ0KPiA+IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUg
b3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55DQo+ID4gbWVkaXVtLiBUaGFuayB5b3UuDQo+
IElNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0
YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2Vu
ZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBv
dGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhl
IGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCklNUE9SVEFOVCBOT1RJQ0U6
IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZp
ZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFu
ZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBp
dCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFu
eSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
