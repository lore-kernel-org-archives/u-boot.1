Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB5E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 05:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB2CB892A4;
	Wed,  4 Dec 2024 06:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRWQwHQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762DB89351; Wed,  4 Dec 2024 06:26:04 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CD988EDA
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 06:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOATp6INo4zSlQTthklUSOl6cPW/IlCMEnrICtXsINX7xD/LhcfE35Er5lA9H7j9XKa9QI+cnka5KCtO+PrMhgqFo5hvjya5NevITHNLxXPddWy7Lbselx2vioPulwOKRA3+BgttoiUM0jRweQU7cq8oLctyT1ZKu+mS58piG4x8VD8ehImcgIRLssIvz7/DHxXm6ooQPLcQ8vseyAiuQYJ1wQKfATjW3r1lr8xnf1M/XdRI4gWZW3gjqu49Rr61HlpTAPyKYHFWJj20VUhn5CUhaQ2SOGl3naWusuAr4skURINNnbMG0AMbM9C/dt3SqkuRuU52aoVpLJNbtqphSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZbV97bJFuZ9uhrMyRXYPGi16/3gUcaPCmqL1dMLE48=;
 b=MvBh7UtxcFK8aI+MWUvcgyysOzbDG+SWCl1bXEGtLcYcO/oscJq+YZNosgM3TV539etIyygYXb29K8liqPM1lAM/UnSDr1E/6UUWMoZD2WilfCaiAzrPWKBpcY3bB73GIbdW6bS7yYQgrqo+FnF+S4YNlJ0PJ/QYqrMxbz2m8ZUqspcUSJgivJkZBQOGHj9SvBjzetCpU8fy9RlHjRmbECSA5OTS4jviE9n+9gUTu4amSyrpc6+TglJOqCvK+BKIeIkviMgKWaDA7oJMgoygVv8MpYhHqpVw+lVxaCRe26lggMzWIw0oC8F6Nqn5XemJuezLZH0kYr9cq5KC8s8Udw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZbV97bJFuZ9uhrMyRXYPGi16/3gUcaPCmqL1dMLE48=;
 b=MRWQwHQwwZ4mXawZfjutJpqLNb4wOmwLPdz7tfLKI47LRBltPB42fWEStkaLok7vbda77Dps6F5SfiGPhj70WYBuBoFhFfAKItDybS2PjKejAK+MF7FI88+71J5E4KULRvvF8FlusUhi9DQELx4KooyGfY0Zwu17ERgDIF/oTuc=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 05:25:54 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 05:25:54 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "j-humphreys@ti.com" <j-humphreys@ti.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: RE: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Thread-Topic: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Thread-Index: AQHbQkij5Vr6T6wrk0eUULAzACXQBLLUWkwAgAATYZCAABZGgIABERVw
Date: Wed, 4 Dec 2024 05:25:54 +0000
Message-ID: <SA1PR12MB8697009E6C91930C33B2D2A198372@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241129102248.670635-1-venkatesh.abbarapu@amd.com>
 <c4a9d8b7-9dfc-4317-b061-e6dd887d7efc@linaro.org>
 <SA1PR12MB869712C44446C58C024B436498362@SA1PR12MB8697.namprd12.prod.outlook.com>
 <fa5ff70d-1b78-4901-ad33-f0cb163ac5d2@linaro.org>
In-Reply-To: <fa5ff70d-1b78-4901-ad33-f0cb163ac5d2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH7PR12MB6585:EE_
x-ms-office365-filtering-correlation-id: e7130bf0-3a25-41e4-093a-08dd14241ffc
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bnVEZHVJeHkzVmhtSGhkSVErUHFvemRVeGdqOXlCNGNIRzdlRXY3TTVpNGdM?=
 =?utf-8?B?ZGxPd1pRUGVWMDdnVW1KSHZWMmNsd1dCVlhuZTlIVmozUmVvejF3dlNFeWtu?=
 =?utf-8?B?N0p6TnhZU3BSZ3VGODJvMzRYKzd5TkFJK3N0YjM0NWxzNWpHZVd3QnFWSDc5?=
 =?utf-8?B?YTJpdWE1NnljbmQ4QnpZUUp1YS9Zc2tLS01RSXprakozYXNDM3VGdW83NlJo?=
 =?utf-8?B?WlJTRFVHLzFtd3hBUnFNV3c0cDZ5ZDdSUnRla2FYMWhnREg4M3JLVWRyRS9r?=
 =?utf-8?B?MDlLcG5Zd1ZWRlRKVGhPcmpWOU5rN2loYllNL1VCcTgrNkxhaEJpVERvZVFh?=
 =?utf-8?B?dEQ5cTYxOTNVK3BHSFNRenMrMG4yWWNVTXNtK2RtcThyMUFDLzhHeTFhZC93?=
 =?utf-8?B?eHp4bGoxS0pwV2t3YjdKWitWbDJ3OUhRbnUyaGxaS2Q3UmVaOC8xcVJxSjlp?=
 =?utf-8?B?VGs1NktadlpubTIzVGRPOERZbG9rbDc1c3J5bDNDQXV2NWN6ditRRW9oRTZa?=
 =?utf-8?B?NEVWWjROQnJqT0NlNi9ENDVHa3JMWk8wbUE5cm1tYnNLZXFPejIxZlorak4r?=
 =?utf-8?B?akQ0dTB6KzV6Um5ZZTBrWWtxNWVYc2xoemR6ZDhtY2VUL0F2dThWTDBicE40?=
 =?utf-8?B?ZXZrM3RnYmNGMmkzK1RsbTBxWHV6K3F0S1c2L3Z6NW9LQkhwSHFXcGNsMTBE?=
 =?utf-8?B?YXhBeHp3M2RrbkRDRzNRNDhJOFh0cHZEVmRRZUFBaDI3K1hWcXA0QTk4WXpP?=
 =?utf-8?B?cGVGOWRjQjY1MjhJelF6ZVFPc3RvMXlJam4wVnV4Z2ZobXVOUHRaZjd0Y0Rj?=
 =?utf-8?B?VEUycmhSNGdaS1IrMXU1SUU5c3BWZTAvRXJDRUNIazlUcUhRalUyZDBxaERt?=
 =?utf-8?B?UzBQL0FuMXowb2daK1JDMkYxY3E3ZVJMS0cxN3hCTFUwaE12TFpQdXdvNW9l?=
 =?utf-8?B?VVB6elVSSmNPSjdxbndPZFNIOHdYMDR6YStwekNZb0hNNDNDWU9QU1ZJWXpr?=
 =?utf-8?B?YTlhUHYrVFA0OHJRYlgycmQ0S2x1cjlNTE1xb0NGWEVZMzZwTnhhQnNaK0FC?=
 =?utf-8?B?MDhreXp5QXpqMitZSnkwM0JhM3FwTDNhTEZpdGgrdEtnQUxpbzR0elg4NjE5?=
 =?utf-8?B?cG1Sb1FqNHBldUZkc2FvVlJISTUxZmJYY2ZsbXlNWExwQlFldG9sMXhnOVlZ?=
 =?utf-8?B?Zkx1aW03bzJSYXhVSVBvNlNuWkgwMVA5em5RdVVEeDNEMVAyZDBZbURod1I1?=
 =?utf-8?B?NThWL1RJaUw5SkNkYVlyMFdmTUJmWHh4VmJrQ2ZwSWR6dU1kQ0RrZWlhTk5v?=
 =?utf-8?B?cFpnaGY5SUdUU3puODZwWGhQM3pLSjRKYVMvK1RKeTVNS21wOC9jekVRN1ZK?=
 =?utf-8?B?V0RCS25Jc2Y1NjBmSVpXb0tEVE1EVktkS1J6UGNOMXowbE5EbnYxRnJoNVRE?=
 =?utf-8?B?RkhXdDdaYmNBQkpURTQxck9uTzRKM3RkQTNXdmd5ck94ZnNwUnJJdzEzcUx4?=
 =?utf-8?B?N0VUUXMzc01TVTlMMmRBT1BabmkxVWdGME53enNvZ2NHNmliSmNGTG5pUjBa?=
 =?utf-8?B?WlFSVTFNUktxRXpiVmY0aWwwN08ra3kvY0RJeEVIVmNxRXVEQnVwdHRGYi9U?=
 =?utf-8?B?UU9YL1lMa3FBQ01Bay9pRjJINW93cHlvaHNKd3F1aFZtT0Y0cmFKSmNZYmdN?=
 =?utf-8?B?cVNoeHZBRm1pVU5TZ3ZkdWdGNFZkMGZUV2FtZm1zVmY5MVFsaDhzaXdVK3c4?=
 =?utf-8?B?K04xbCtZOXMzaWZMQVRCdWpJckJRekZmVGxIVkt3SURDUmg1TGZEZW4yRXVB?=
 =?utf-8?B?VUxKcWFmaDVpdmgzcFpPRzNXb05KcnNBTFhGVkRWNVdCNWowbFFGeDFTMjQz?=
 =?utf-8?B?TEVtUlFXbmVZZmpJRzFtT0w3R2dhVGVySE93Um1NQS9KZXBxNEgraHk1S1dK?=
 =?utf-8?Q?ML9x8dHlC/w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1ZwQ2ZRUmF0bFFSR2EzYUMzWmVxZE9jQlVJTTBMNi9lL29LRkY1TWpxTmhY?=
 =?utf-8?B?R0gyVXNmMG9Tc01IUEVsemtrbnNKdVcxbk81emNmWFBkeE9xZitkUFIySkFU?=
 =?utf-8?B?bzJEM3NSeUM5b0FVMnUrTFd4M2pCd1V4Q0s4VXptTVVkMm9Fb2dQT0VsUTBz?=
 =?utf-8?B?bmdJQ2RuSlY4NDVKdWdUWkI2bVUwbXpDemxEeHVQdkJFaEdTdGh3dGxBazU3?=
 =?utf-8?B?RUcvN2FWczk4MHJ5bXEwNTYyQVBYTnlqVzZidGtvWmkrVGc5OW0yWlNpZG1q?=
 =?utf-8?B?bVczeWVpTzFmOS9TWVdjZktub2xXMmNKWnlvTkNBelJKWjIwSjZyNEswb2M3?=
 =?utf-8?B?OTZjd0Y2cHR2T0hqZjNTSFl3Z2xkbHZwRHQ3K1hQekJURi9Kdkg1d0s5WTgw?=
 =?utf-8?B?UU9PMk8wRXZuS05hS2ZuaXdzN0dEZHQxSXBLS1cveXFIeGZVd0FpQ1pVVktJ?=
 =?utf-8?B?T2tKQ3lyUm40YTQrMy9Kb21PUHJoWjZqTnVNUDljNHY2emJHZEhyYlBWdlN1?=
 =?utf-8?B?Zk1mc3VNVHB2TW5rTWtEQjNzTllZcVk4azNNNzNRblRGZFYxNVJOUkF2RDVM?=
 =?utf-8?B?d0RoL2EwWlh2c2UrN3pCVUlDTFFFN1dPNkxlbm84bUFZR0FzQXliMVFYVFlQ?=
 =?utf-8?B?Y1UxMnc0bUFJaXNHS280ZEFFenFlSDVjbEJua0xoYk5RRDltdzZYQzRtdGl1?=
 =?utf-8?B?Vk9YemxaY2lXek5nSkhhL3RER2h0ODN6SkhXRkdOamxWbmlpUWtsTWR2NDFj?=
 =?utf-8?B?N2NkWllGdzlhdXRTbS9Ra0o5OVRZemJBSGdIT2c3eml0RHh0VFJEWmhSbFNl?=
 =?utf-8?B?Z1I2Y3kvRzJvb0ZuOVdJT0pBcFhqa3lVYXh6eWlRdTd5OThJNFBUeklOZDVL?=
 =?utf-8?B?R0V5VU5WYWpBb3dlSUZ0WkdSdmVoclhwQzBnYTYxVEZnVG9nYXBzYmlobUpN?=
 =?utf-8?B?UUJWOUd4SHAxU3EvdnpndjNwb1F4b0VETnBwSUt3NitmSHJoSWpqUzlvK3hj?=
 =?utf-8?B?eWNMNWI2VlBaZlNJRTJKeDhwNDV2OWpuVVI5cXJwWGQyYnVJb3hwRWh1cVZh?=
 =?utf-8?B?bElkYSs5MnUyTWZUNE1FSC9Fek5hS2xkZ1ZWV0FRbkkvRm1oTHNyL2tWejdT?=
 =?utf-8?B?bkJQdWZPRVBva3JLbzhQcktRS1V6R2xtOEdUUS9JdytDU0sxd21PTzArK05l?=
 =?utf-8?B?aGJPYnZORUt6QTB5blZ6OHFKN3lOeUE1Vm1Wd2xEVWlDRXJUb1A5NDF2SUNF?=
 =?utf-8?B?TTl2bThYcGVHQ0xJOXhjRm9yd2NUZ09aSWlFVVkwWjVWbGxjVDlEejN6cmRF?=
 =?utf-8?B?MW4rdU1ZbFhOQlRyb3pOUHNjZ2F4RWlNbWJ2ZkxnajYvbTNnUi9ZMER0RU4y?=
 =?utf-8?B?SDBLby9vb3d6Q2tZWkhDUGxCTnlmWnQraVhoYVROcVdLYkdqRm53eVlFa2F0?=
 =?utf-8?B?WFk1eWZpQ2VVY2FPZ2wxRVFEbkNxUWVrZUtqMkpQYmJJbVVHVlE3amZJMW9R?=
 =?utf-8?B?QjFncWxjN1Ewc3JNQWpDK0JFeS9uaWtnTXpUcVNkZlNnQXY0b1ZyM1lpaUxv?=
 =?utf-8?B?aW9zV1lhZDhzZDA2Zm1ZWWV2Sk5nYytVUkhsNnpsV2NxNVAwbk9BbFAzN0w4?=
 =?utf-8?B?L0sxbDBBQjJUQ3c5R0IvZHk1WkZnZmwzNi9PUG0vMUtoTnVmd0NQSUxtZDBF?=
 =?utf-8?B?UjVrdTdwaWRzQ2p0WktPTlVtY3RkczFJUmxhS3lyQ3UrZjNZV3ZtRkwxcEND?=
 =?utf-8?B?cFR4RUxBeVJORHZSd0JvUVF1dU1LS2JudDhUS0F4NUk1RzJJQUFSOE5TMnc4?=
 =?utf-8?B?QWxmOWJnOFcwbmF6SytTM1VhN1FWSXlPNFptencvY2xDajRPZFFxaStpZEl0?=
 =?utf-8?B?VVU0WmNkNnpHS0ViczUydzhUb0tPKzRucDBMQlFvY0Rhc2hIekI0ZkdIQS8z?=
 =?utf-8?B?MzZEK0tYcGcyRVlmM2lGc1E3NG9sb25ZVFk4UGF3b002UXZMUWh4UDl4RXlx?=
 =?utf-8?B?M2tVQnVIU3BqV3ExL2Rmd0VlWGZ2V20zTDNyVDlvZC80OThTbGFReHBJUS9v?=
 =?utf-8?B?TVBSTkYxc2tZcElwMC9EVmlmOUtTdXUxTFhjTkZFSVNCWEZTZTc4OEdoaXdo?=
 =?utf-8?Q?gwjs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7130bf0-3a25-41e4-093a-08dd14241ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 05:25:54.4341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vy0P7IXArfDhLWQzZ+aYNmwIGkDyBxmz+ZMPC4WAye/Tj9iNEav4tRQSL8Puwf5YjVbJJkH4ktCWnAZJwe0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAzLCAy
MDI0IDY6MzcgUE0NCj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFw
dUBhbWQuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7DQo+IGotaHVtcGhyZXlzQHRpLmNvbQ0K
PiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBqYWdhbkBhbWFydWxh
c29sdXRpb25zLmNvbTsNCj4gdmlnbmVzaHJAdGkuY29tOyB1LWt1bWFyMUB0aS5jb207IHRyaW5p
QGtvbnN1bGtvLmNvbTsgc2VhbmdhMkBnbWFpbC5jb207DQo+IGNhbGViLmNvbm5vbGx5QGxpbmFy
by5vcmc7IHNqZ0BjaHJvbWl1bS5vcmc7IHdpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tOw0KPiBz
dGVmYW5fYkBwb3N0ZW8ubmV0OyBxdWVudGluLnNjaHVsekBjaGVycnkuZGU7IFRha2FoaXJvLkt1
d2Fub0BpbmZpbmVvbi5jb207DQo+IHAtbWFudGVuYUB0aS5jb207IGdpdCAoQU1ELVhpbGlueCkg
PGdpdEBhbWQuY29tPjsgQXNob2sgUmVkZHkgU29tYQ0KPiA8YXNob2sucmVkZHkuc29tYUBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtdGQ6IHNwaS1ub3I6IEVuYWJsZSBtdDM1
eHU1MTJhYmFfZml4dXBzIGZvciBhbGwgbXQzNXh4DQo+IGZsYXNoZXMNCj4gDQo+IA0KPiANCj4g
T24gMTIvMy8yNCAxMTo0OCBBTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gPg0KPiA+
DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFR1ZG9yIEFtYmFy
dXMgPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogVHVlc2RheSwgRGVjZW1i
ZXIgMywgMjAyNCA0OjA4IFBNDQo+ID4+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRl
c2guYWJiYXJhcHVAYW1kLmNvbT47DQo+ID4+IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBqLWh1bXBo
cmV5c0B0aS5jb20NCj4gPj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29t
PjsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+ID4+IHZpZ25lc2hyQHRpLmNvbTsgdS1r
dW1hcjFAdGkuY29tOyB0cmluaUBrb25zdWxrby5jb207DQo+ID4+IHNlYW5nYTJAZ21haWwuY29t
OyBjYWxlYi5jb25ub2xseUBsaW5hcm8ub3JnOyBzamdAY2hyb21pdW0ub3JnOw0KPiA+PiB3aWxs
aWFtLnpoYW5nQGJyb2FkY29tLmNvbTsgc3RlZmFuX2JAcG9zdGVvLm5ldDsNCj4gPj4gcXVlbnRp
bi5zY2h1bHpAY2hlcnJ5LmRlOyBUYWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tOw0KPiA+PiBw
LW1hbnRlbmFAdGkuY29tOyBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IEFzaG9rIFJl
ZGR5IFNvbWENCj4gPj4gPGFzaG9rLnJlZGR5LnNvbWFAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2Ml0gbXRkOiBzcGktbm9yOiBFbmFibGUgbXQzNXh1NTEyYWJhX2ZpeHVwcyBm
b3INCj4gPj4gYWxsIG10MzV4eCBmbGFzaGVzDQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDEx
LzI5LzI0IDEwOjIyIEFNLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+ID4+PiBF
bmFibGUgbXQzNXh1NTEyYWJhX2ZpeHVwcyBmb3IgYWxsIG10MzUgc2VyaWVzIGZsYXNoZXMgdG8g
d29yayBpbg0KPiA+Pj4gRFRSIG1vZGUsIGFuZCByZXR1cm4gYWZ0ZXIgbm9yLT5maXh1cHMgaXMg
dXBkYXRlZCwgb3RoZXJ3aXNlDQo+ID4+DQo+ID4+IHdoYXQgRFRSIG1vZGUsIDhELThELThEIHlv
dSBtZWFuPw0KPiA+IFllcy4uLmNvcnJlY3QNCj4gPj4NCj4gPj4+IGl0IHdpbGwgZ2V0IG92ZXJ3
cml0dGVuIHdpdGggbWFjcm9uaXhfb2N0YWxfZml4dXBzLg0KPiA+Pj4gVGhpcyBmbGFzaCB3b3Jr
cyBpbiBEVFIgbW9kZSBvbmx5IGlmIENPTkZJR19TUElfRkxBU0hfTVQzNVhVIGlzDQo+ID4+PiBl
bmFibGVkIGFuZCBTUElfTk9SX09DVEFMX0RUUl9SRUFEIGZsYWcgaXMgc2V0IGluIGlkIHRhYmxl
Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEFzaG9rIFJlZGR5IFNvbWEgPGFzaG9rLnJl
ZGR5LnNvbWFAYW1kLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFZlbmthdGVzaCBZYWRhdiBB
YmJhcmFwdSA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IENo
YW5nZXMgaW4gdjI6DQo+ID4+PiAtIFJlbW92ZWQgdGhlIFNQSV9YRkVSX1NFVF9ERFIgZmxhZy4N
Cj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWNvcmUuYyB8IDcgKysr
KysrLQ0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItY29y
ZS5jDQo+ID4+PiBiL2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWNvcmUuYyBpbmRleCBlYzg0MWZi
MTNiLi45NmY3NDlmN2E4IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpL3NwaS1u
b3ItY29yZS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1jb3JlLmMNCj4g
Pj4+IEBAIC00NDA0LDggKzQ0MDQsMTMgQEAgdm9pZCBzcGlfbm9yX3NldF9maXh1cHMoc3RydWN0
IHNwaV9ub3IgKm5vcikNCj4gPj4+ICNlbmRpZg0KPiA+Pj4NCj4gPj4+ICAjaWZkZWYgQ09ORklH
X1NQSV9GTEFTSF9NVDM1WFUNCj4gPj4+IC0JaWYgKCFzdHJjbXAobm9yLT5pbmZvLT5uYW1lLCAi
bXQzNXh1NTEyYWJhIikpDQo+ID4+PiArCWlmICghc3RyY21wKG5vci0+aW5mby0+bmFtZSwgIm10
MzV4dTUxMmFiYSIpIHx8DQo+ID4+PiArCSAgICAhc3RyY21wKG5vci0+aW5mby0+bmFtZSwgIm10
MzV4bDUxMmFiYSIpIHx8DQo+ID4+PiArCSAgICAhc3RyY21wKG5vci0+aW5mby0+bmFtZSwgIm10
MzV4dTAxZyIpIHx8DQo+ID4+PiArCSAgICAhc3RyY21wKG5vci0+aW5mby0+bmFtZSwgIm10MzV4
dTAyZyIpKSB7DQo+ID4+PiAgCQlub3ItPmZpeHVwcyA9ICZtdDM1eHU1MTJhYmFfZml4dXBzOw0K
PiA+Pj4gKwkJcmV0dXJuOw0KPiA+Pj4gKwl9DQo+ID4+DQo+ID4+IHRoaXMgbG9va3MgYnVnZ3ku
IG10MzV4dTUxMmFiYSBzdXBwb3J0cyBvY3RhbCBtb2RlIGFuZCBJIHNlZSB0aGF0DQo+ID4+IGJl
Zm9yZSB5b3VyIHBhdGNoIG5vci0+Zml4dXBzIHdhcyBzZXQgdG8gZWl0aGVyIG10MzV4dTUxMmFi
YV9maXh1cHMNCj4gPj4gb3IgbWFjcm9uaXhfb2N0YWxfZml4dXBzIGRlcGVuZGluZyBvbiBDT05G
SUdfU1BJX0ZMQVNIX01UMzVYVSBhbmQNCj4gPj4gU1BJX0ZMQVNIX01BQ1JPTklYLiBXaHkgaXMg
aXQgZmluZSB0byByZW1vdmUgbWFjcm9uaXhfb2N0YWxfZml4dXBzIGZvcg0KPiBtdDM1eHU1MTJh
YmE/DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3UtYm9vdC91LWJvb3QvYmxvYi9tYXN0ZXIvZHJp
dmVycy9tdGQvc3BpL3NwaS1ub3ItaWRzLmMjTDM2MCB0aGUNCj4gbXQzNXh1NTEyYWJhIHN1cHBv
cnRzIFNQSV9OT1JfT0NUQUxfRFRSX1JFQUQuDQo+ID4gQm90aCB0aGUgY29uZmlncyBDT05GSUdf
U1BJX0ZMQVNIX01UMzVYVSBhbmQgU1BJX0ZMQVNIX01BQ1JPTklYDQo+IGFyZSBlbmFibGVkIGlu
IG91ciBidWlsZCBhbmQgd2l0aG91dCByZXR1cm4gaXQgd2lsbCBnZXQgb3ZlcndyaXR0ZW4gd2l0
aA0KPiBtYWNyb25peF9vY3RhbF9maXh1cHMuDQo+ID4NCj4gSSBnb3QgdGhhdCwgYnV0IHlvdSBk
aWRuJ3QgYW5zd2VyIG15IHF1ZXN0aW9uLiBZb3VyIHBhdGNoIGNoYW5nZXMgZnVuY3Rpb25hbGl0
eSBmb3INCj4gbXQzNXh1NTEyYWJhLiBJZiB0aGUgY29kZSBpcyB3cm9uZyBmb3IgbXQzNXh1NTEy
YWJhLCBmaXggdGhhdCBmaXJzdCwgZG9uJ3QgY2hhbmdlDQo+IGZ1bmN0aW9uYWxpdHkgZm9yIG10
MzV4dTUxMmFiYSBvbiB0aGUgZmx5Lg0KSSBtaXNzZWQgdGhpcyBjaGFuZ2UgaHR0cHM6Ly9naXRo
dWIuY29tL3UtYm9vdC91LWJvb3QvYmxvYi9tYXN0ZXIvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3It
Y29yZS5jI0w0NDEyIChtdGQ6IHNwaS1ub3I6IENoZWNrIG5vci0+aW5mbyBiZWZvcmUgc2V0dGlu
ZyBtYWNyb25peF9vY3RhbF9maXh1cHMpLiBXaWxsIHVwZGF0ZSB0aGUgcGF0Y2guDQoNClRoYW5r
cw0KVmVua2F0ZXNoDQo=
