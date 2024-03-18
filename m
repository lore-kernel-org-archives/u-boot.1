Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE2FC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 08:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2398087A80;
	Mon, 18 Mar 2024 09:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="v5HpwwmX";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="c34z2FfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C10887CB1; Mon, 18 Mar 2024 09:09:28 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706A2876BA
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710749364; x=1742285364;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GotKXYvotluoZ+Nl0SUfQU8QduP4vbkt7IMDyr+PqZA=;
 b=v5HpwwmXFIazM9KsWwtDQ4dnFA/fxxShC4PqXVspsebP6Mn6j2MrG3cr
 Dfj0rIHsnV18cdIRFIs6I+GRVxwAgNWuvBTwc5a4acWG1/Gvlco6TV+YH
 w9bK1XV4OIe+PZH7T9gWB77PnLFHAnoD/9lk2m5JDyxsdaAQ1tJCykPeA
 E0/I9V1AB5Kw7csBj8Wqrk6MMsynHW3s3XqVplYdYKMbIFeDl87pnd1Xy
 tlrTrnCTv4eJHBEM96GgaH9hjwJ1MbAdeOHtniucGIPrahsjWwXHdwutF
 xB2AU376HfYle66TkUUpXC8KE8LqojFzc8EpFCG/SL25eJoV/MSuOVPGM g==;
X-CSE-ConnectionGUID: QekSO03uTbacXSxG+ltyuw==
X-CSE-MsgGUID: m4NC5yUMS8mgb11+UFdqhw==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; d="scan'208";a="248542602"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Mar 2024 01:09:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 01:09:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 01:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlBFpR8V062IdYIduSSCWXICZrqBs3zRmVDal/dIrYy1YyIg93F5zB68MKb4HmWjpWrH8ye+RhfdspWVBNNEjupTHd8o+F+4WcVrfMtfYeaJgdtB5VHDP0CKfR0FTEKzoHyb1Li5h2TN6d+L5YSjQZ1M5aNt9rDqeMDBA7/cXV1/bl8qCLev6eHs6Tr+tRvOHDi4QEincOSe0GbGYLR6AgWDe2l0XYNRV8+CUgZp+MjL0mkV0G5K41aie0qO2OBTrfu/J1LshErxruo58CwSIEJCYOfJWs2aKoHCUZj5N2ZzpL4TVatL/erOgu9i8SKuKSRxA+xvjcQ8866oDrZdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GotKXYvotluoZ+Nl0SUfQU8QduP4vbkt7IMDyr+PqZA=;
 b=Re8n7NaxXDgyRuZ7pYa/sQfZj6aQobxb6IDi8nFr6mqbGaINyif9ppi4Y/zqePAegcRWOaV0eH/2GAO9pPtusluwvB+RvvtuwzchkEVTU77Jb8s0NbHULHv2ooi9iUIgD5/YVz3/39Bgy7vSvuo/jbCaD0OYlm3CBu9iDGv8SiBES6hZ60cmQ5iidIyv+xmc9d9PbWrrsgxj5gNiS0cse9odSyrAXECaogA8Nr8koqq5aPFs2Yumv1uW0bSojihHqdrP3Yjw6YH21YC9/073f6Y5ykSZk1O9u3sGWpqVbBdjjKvLQlzjiFpC6y3fORIwaFtqOgD/i/SFJ4Ad09A25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GotKXYvotluoZ+Nl0SUfQU8QduP4vbkt7IMDyr+PqZA=;
 b=c34z2FfPfUF5IQQPgmnzLxLAwvOfXjQIzJe/bTqsuEu4y/IoDlzb+svhS4WZFRXLPWnEqZZL9Hbzdix9vamHgfqU/KlLBxWh0w3/mrTrsq1kR4bpRZnWvdGR25SVBehJNqQg15Wg6x1XRNgg0ZJBgBr8zU2IYAC0YjjZ7WmUkq53b9jWUpBkMzdVBUvDfYwnW69mj6ot2JdQItL62rADrfl9ttvCIf0v+9nCr2QNB9K6PHGMz2twn1fuZBcrXCzVZjJ6M01ADVKfHEaA8ENtVwfNRrwQ14vzMNzZqp6zgtScR9FpLLogWQ3NQQS7hMphGikM605U5h93sGVh7lqD5g==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Mon, 18 Mar
 2024 08:09:00 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 08:09:00 +0000
From: <Mihai.Sain@microchip.com>
To: <eugen.hristev@collabora.com>, <ada@thorsis.com>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>
CC: <Balamanikandan.Gunasundar@microchip.com>, <u-boot@lists.denx.de>
Subject: RE: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Topic: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Index: AQHacHYz5NjLBjcwWUSp31aMRMD+07E9M2MA
Date: Mon, 18 Mar 2024 08:09:00 +0000
Message-ID: <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
In-Reply-To: <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 20a74310-ceb7-49db-98b1-08dc4722aae7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gwtAbQxTNrRpbP5iP2zEC5xIX3oV+eAha111Lkm1OfejUq+GS8qf776k+bupvwaUEM+lOhZs9L6DOgLalrslFSTtstxGp6baG2hgRWfaH+eQGCRA88KFMwr+w+SJErhpjEA7IvDJyOxCfCqMIodEOU/QggM3FvkgsAfqlN7U3xhcSRoeM+3IAuV3bzmawbYSr9ntSwRkOLieYzvBhRMIBqod6dQRYcmquLWhJm2n4CE+UnSSqmA0WgJsKdpPbaHU8kFpUvn3NuH9eUii7s95Zz3JCSAB5uddC7ng2j5zrNxZwrMrZUXx+RPvmbgRJWlO96e8JipvtYEeOeG3+RVkAk5HEVeyqD08IXXXLHBFqexzD9qXKCvJo4/197X6T2sRMpWjp8vpTcGLa3s3VlNFBDQDkDy67PLj3dQ5RDeKUIR+SR6CTbAItEuJJQh3gNrYdkaOKVfywgd5ic9wJ8UJj86nffzWvBZcOweiyEa6dW1jqcXJJW8A9lq0qMc0a+LwpCf+jbYMtzH5Uajlpb++r8kqx021VhHVsDbsb/OF1f9zD5NE5rV10wK6XY/cjXY8LRZnp4/C7lwHG42zjQ3erMjdztln4lZMAfVKyIPn+O7v4AnDlIfxnSrx/B1KQ7eBShZdXMnAPtBhV2EBfdyEzi7svVVbbJ0rHRQ9RtnpQCG3V7Av5LVu4KuDVHDiDi0RD5BjFCepS5R/iQ16kuK0yNSFoSgdLCbd6yxvz41ipQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEF0ak5ZaEp4emRBL1I3WVlhalRRYWdZSURXL3JzbmE5OTNwMEMxeVQrcWhM?=
 =?utf-8?B?YWRjcjFhNnN6enZjMGtzNVpNQVliQjY2MXFnQ3ZJa2lzQkJyUy9CSWh0bExJ?=
 =?utf-8?B?LzFub2Q1VjRRTVBnL1BmZ2x0SGhBcDF5UFpISWVkMys5ejROUExlRTJrL1lL?=
 =?utf-8?B?djM1bUtzYU02US84bnZrNXFTQmtocFg3cnRCd3lGZk0zZ29xZ0lQZWF2b3lM?=
 =?utf-8?B?K1ZOY3d5R1RQT3hrZE1IdENjSlRmRGo3N1NoWG11UFdNU3NaVy8rM01ZYmlt?=
 =?utf-8?B?Z05NUzRhbS9lcSs0MkNMaDJTek1WbkRmZzJrZlhtRzJtUnVpMDVXR012TlNU?=
 =?utf-8?B?TFFWSVVMb3hlVUpUQklUUnZSRHMrMFUxbHZ2a0ZWLzRTMjNqU3g4aGVSaGgv?=
 =?utf-8?B?bUxhTGxncDA5RHNnMFpyYUszRUFvSGthN3dJVFMrckg2ZTN3K0xZYTlZeW1L?=
 =?utf-8?B?RU82MnFxQnhzRjdCUkN5RkRRTWVMdGpOdEthZXpYSHJRc1NvNnNCdU9oN1JG?=
 =?utf-8?B?ZWZWdC82Ukd0SHVVbWpUUE9Mb09wdlAwSngvUXJIaTNEZklrMVllK2NqQi8y?=
 =?utf-8?B?Y1Z2N2VXemtpTHRmelJsRnRHTkxDNytOTDd6UklFaCtkMXRvZXdBUU1BNHdI?=
 =?utf-8?B?RGFpVHdoK3U4bG5mK0ZZVVBKZG1JVDMxR0RZQzlSY0FZN3VoWHQzTDFUT0J2?=
 =?utf-8?B?NFFRVk9hQ1NucGxzNzVUYUsxYUo4ajhxZmxYdnZ1VUl0WEIyU1d3M3plcGt2?=
 =?utf-8?B?QWc2bzBQa3A3dUw4eDlXbEY3ZmtpZFlWcDB2dTYyQTVROFdWNzRHWFFhUEVv?=
 =?utf-8?B?b2hWWVRTeXFnQ2NnSXZDNnNxRUFqTFFNZEtaTEdrWkZxVmQ4ZGZHVHZrRDhY?=
 =?utf-8?B?eXpaMm5SQVBxK2lYR1ZxRVQ5c2tXOXBRclBQSTNqbVQvcHVzUW41MEhNQ3Fa?=
 =?utf-8?B?QktnRUN2MDRscjhldWVTQVNNeG1qYW44WTdtUERZN2pZTEh4SkJaTnhNaGRo?=
 =?utf-8?B?ZlZLRUhzVW54bkVEU05kRmloY1lDODNrQXhMc01PbEJzWDhpT1FibWpGR0NL?=
 =?utf-8?B?OUx1VkF0MmpjRS8reHZxc0dyQmI2ZFcxV2JJTnQrdEtCSFViaUFlVVkxOTd3?=
 =?utf-8?B?QkpCcXkzbkJVYkpEbDRzOU5ocjRxU1hDcGxwa2l4MkozUDdSZWk2OUU3OS9Q?=
 =?utf-8?B?cm55OVZPM1lCYUd2RWtqTmtjR29JSmtDam5oSFpYMVRZcDc2QlpvMnIxQWtC?=
 =?utf-8?B?Y3A2NzZvSjVvVVJzdC9HR3hVL1FERzJRQXd2N1h3NkdqcEFzOXptS2xwaU9r?=
 =?utf-8?B?QXFkVURnNjVUUDB1L0ZlOVdrUDVrR1k5a1dzWXZtdVY2SFBQVkk5OHIvMmVQ?=
 =?utf-8?B?ZG9QSzA3c21zYnNZTFV3c3BzSTBqY09RQzZCMjZJR2dJcngyTVVhdWhMZ0hL?=
 =?utf-8?B?dHkwM1NhazN5SXV5WitERVdaTlB3SFVYandxZnFNWHQ3MitWQmUxWWNBcnRS?=
 =?utf-8?B?RGp5UXpad3V6Y29zRmZDdmkwclA2dE5nRnJkc1M5L2JZRTlENlJadG9VL0J2?=
 =?utf-8?B?bXgwTy9KWHJzL2ZXNVRhV1ZyVC9FTHdpTmI2SlVSQkdNcENZSWhsQm9zR3NM?=
 =?utf-8?B?ZHNUU3phZXhKVkJQcVhqcnpNNnBIcjh5L1h6Y3lucmdiejEzRWNNOHN4Mmxt?=
 =?utf-8?B?a2pCRnRIZzJyM1d5ZDc0NTVObFlOVWR6cVFGVytxMTc1TmZpRVRxSzdHOVQr?=
 =?utf-8?B?cXkxSnQvYURTWE1LMHJZNW1keWFQWTVsd3B4ME03TXNKbEU4cXFCS3ZWQTVW?=
 =?utf-8?B?dkwzOHg1ckJwdm1LanJjVzYwbVhvcnQ3ME1DNDNNUk1HMnZEQ3ZjRG9PSTd1?=
 =?utf-8?B?QTRRZFFqNGJiNGxjS0lNOG5UK0RJMnhTZUUyT0N6NkdQUG82bGI1dGQycVhF?=
 =?utf-8?B?SDhmRkNzeFVqbXlUUFpGSmtDbWdob0l0aCtzdnQ3ZkRVYXlGQjd4OHFzQTZJ?=
 =?utf-8?B?MFZIV29tUU44dGhFc0FaemVMeWZTZTBOS1FHTlBEcFg1bUxVWDZyVnVFMkV2?=
 =?utf-8?B?MnV2YkYySWt6dkJiWE9PbkhqTUErQTd4SExiL0h3TWFyNG9TNWp0MTMrZWYy?=
 =?utf-8?Q?M1/cA1w+Us1rWg1ptuhTyLiGH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a74310-ceb7-49db-98b1-08dc4722aae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 08:09:00.1010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8g0ydTWVRF61bV0GU17xm5B20591igjThAG2rmubC/zE9HBXBkjKeRAMYXiIJNmWBRCxvHFhnuxPBHrgY3tOP/YU0DXrcp6XctWa5BIxYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
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

T24gMy83LzI0IDExOjEwLCBBbGV4YW5kZXIgRGFobCB3cm90ZToNCj4gRm9yIG5vdyBhZGRzIG9u
ZSBuZXcgY29tbWFuZCAnaHNtYycgd2l0aCBhIHNpbmdsZSBzdWJjb21tYW5kICdkZWNvZGUnIA0K
PiB0byByZWFkIGFuZCBkaXNwbGF5IHRoZSBjb250ZW50IG9mIHRoZSByZWdpc3RlcnMgb2YgdGhl
IFN0YXRpYyBNZW1vcnkgDQo+IENvbnRyb2xsZXJzIChTTUMvSFNNQykgZm91bmQgaW4gZGlmZmVy
ZW50IGF0OTEgU29Dcy4gIE5lZWRlZCB0byBnZXQgYSANCj4gYmV0dGVyIHBpY3R1cmUgb24gd2hh
dCByYXcgbmFuZCBjb3JlIGFuZCBhdG1lbCBuYW5kIGNvbnRyb2xsZXIgZHJpdmVyIA0KPiB0cnkg
dG8gc2V0IGFzIHRpbWluZ3MgYmFzZWQgb24gT05GSSBwYXJhbWV0ZXJzIG9mIHRoZSBjb25uZWN0
ZWQgTkFORCANCj4gY2hpcC4NCj4NCj4gVGVzdGVkIG9uIFNBTUE1RDIgYW5kIFNBTTlYNjAgYmFz
ZWQgYm9hcmRzLiAgRXhhbXBsZSBvdXRwdXQ6DQo+DQo+ICAgICBVLUJvb3Q+IGhzbWMgZGVjb2Rl
DQo+DQo+ICAgICBtY2sgY2xvY2sgcmF0ZTogMjAwMDAwMDAwDQo+DQo+ICAgICBTTUNfU0VUVVAz
OiAgICAgMHgwMDAwMDAwMg0KPiAgICAgU01DX1BVTFNFMzogICAgIDB4MDcwNDA3MDMNCj4gICAg
IFNNQ19DWUNMRTM6ICAgICAweDAwMDcwMDA3DQo+ICAgICBTTUNfTU9ERTM6ICAgICAgMHgwMDFm
MDAwMw0KPiAgICAgTkNTX1JEOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA3ICgzNSBucyksIGhv
bGQ6IDAgKDAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQo+ICAgICAgICBOUkQ6IHNldHVwOiAwICgw
IG5zKSwgcHVsc2U6IDQgKDIwIG5zKSwgaG9sZDogMyAoMTUgbnMpLCBjeWNsZTogNyAoMzUgbnMp
DQo+ICAgICBOQ1NfV1I6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDcgKDM1IG5zKSwgaG9sZDog
MCAoMCBucyksIGN5Y2xlOiA3ICgzNSBucykNCj4gICAgICAgIE5XRTogc2V0dXA6IDIgKDEwIG5z
KSwgcHVsc2U6IDMgKDE1IG5zKSwgaG9sZDogMiAoMTAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQo+
ICAgICBTdGFuZGFyZCByZWFkIGlzIGFwcGxpZWQuDQo+ICAgICBUREYgb3B0aW1pemF0aW9uIGVu
YWJsZWQNCj4gICAgIFRERiBjeWNsZXM6IDE1ICg3NSBucykNCj4gICAgIERhdGEgQnVzIFdpZHRo
OiA4LWJpdCBidXMNCj4gICAgIE5XQUlUIE1vZGU6IDANCj4gICAgIFdyaXRlIG9wZXJhdGlvbiBj
b250cm9sbGVkIGJ5IE5XRSBzaWduYWwNCj4gICAgIFJlYWQgb3BlcmF0aW9uIGNvbnRyb2xsZWQg
YnkgTlJEIHNpZ25hbA0KDQpBZGRpbmcgTWloYWkgYXMgaGUgaXMgdXN1YWxseSB2ZXJ5IGludGVy
ZXN0ZWQgaW4gc3VjaCBkZWJ1ZyBpbmZvcm1hdGlvbiBhbmQgbWV0aG9kcy4NCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpIaSBBbGV4YW5kZXIsDQoNCkkgdGVzdGVkIHlvdXIgd29y
ayBvbiBzYW1hN2c1NC1jdXJpb3NpdHkgYm9hcmQ6DQoNClUtQm9vdD4gbmFuZCBpbmZvDQoNCkRl
dmljZSAwOiBuYW5kMCwgc2VjdG9yIHNpemUgMjU2IEtpQg0KICBNYW51ZmFjdHVyZXIgIE1BQ1JP
TklYDQogIE1vZGVsICAgICAgICAgTVgzMExGNEcyOEFEDQogIERldmljZSBzaXplICAgICAgICA1
MTIgTWlCDQogIFBhZ2Ugc2l6ZSAgICAgICAgIDQwOTYgYg0KICBPT0Igc2l6ZSAgICAgICAgICAg
MjU2IGINCiAgRXJhc2Ugc2l6ZSAgICAgIDI2MjE0NCBiDQogIGVjYyBzdHJlbmd0aCAgICAgICAg
IDggYml0cw0KICBlY2Mgc3RlcCBzaXplICAgICAgNTEyIGINCiAgc3VicGFnZXNpemUgICAgICAg
NDA5NiBiDQogIG9wdGlvbnMgICAgICAgMHgwMDAwNDIwMA0KICBiYnQgb3B0aW9ucyAgIDB4MDAw
MjgwMDANCg0KVS1Cb290PiBoc21jIGRlY29kZQ0KDQptY2sgY2xvY2sgcmF0ZTogMjAwMDAwMDAw
DQoNCkhTTUNfU0VUVVAzOiAgICAweDAwMDAwMDAxDQpIU01DX1BVTFNFMzogICAgMHgwNzA0MDgw
NA0KSFNNQ19DWUNMRTM6ICAgIDB4MDAwNzAwMDgNCkhTTUNfVElNSU5HUzM6ICAweDg4MDQwMmYy
DQpIU01DX01PREUzOiAgICAgMHgwMDFmMDAwMw0KTkNTX1JEOiBzZXR1cDogMCAoMCBucyksIHB1
bHNlOiA3ICgzNSBucyksIGhvbGQ6IDAgKDAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQogICBOUkQ6
IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDQgKDIwIG5zKSwgaG9sZDogMyAoMTUgbnMpLCBjeWNs
ZTogNyAoMzUgbnMpDQpOQ1NfV1I6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDggKDQwIG5zKSwg
aG9sZDogMCAoMCBucyksIGN5Y2xlOiA4ICg0MCBucykNCiAgIE5XRTogc2V0dXA6IDEgKDUgbnMp
LCBwdWxzZTogNCAoMjAgbnMpLCBob2xkOiAzICgxNSBucyksIGN5Y2xlOiA4ICg0MCBucykNClRE
RiBvcHRpbWl6YXRpb24gZW5hYmxlZA0KVERGIGN5Y2xlczogMTUgKDc1IG5zKQ0KRGF0YSBCdXMg
V2lkdGg6IDgtYml0IGJ1cw0KTldBSVQgTW9kZTogMA0KV3JpdGUgb3BlcmF0aW9uIGNvbnRyb2xs
ZWQgYnkgTldFIHNpZ25hbA0KUmVhZCBvcGVyYXRpb24gY29udHJvbGxlZCBieSBOUkQgc2lnbmFs
DQoNCkJlc3QgcmVnYXJkcywNCk1paGFpIFNhaW4NCg==
