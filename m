Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87806E8181F
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB4886B95;
	Tue, 26 Sep 2023 08:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Js0htvyc";
	dkim=pass (1024-bit key; unprotected) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gh1nOjVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CE586BEB; Tue, 26 Sep 2023 08:13:31 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3417B86B93
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Durai.ManickamKR@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1695708809; x=1727244809;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=XVAcTBBTAkBtXbXP2BIYVO3bp74Sh36DefnGt3VgXhg=;
 b=Js0htvyc38rKMyuMQDtmR53ieaNoYV92rzlVOhY3qKExCnb4MzTNC7Pw
 zy5O12hoPt5FEMa/9QBYwiEqROy0gQb6OWfUkYltV4VwPxsoV0QkanC12
 XAPMpj45hFvTmwKHHiV4NYAOSkSxvLxWofvr7drLxbP0zhXJAI9MPui62
 ZBwStsTh338xIsntuNHyU/E/OeuJhRMVzXts63e0rj4oPUydscdz2JdAQ
 S5haV+5dVMgUyiyCaPJBok9TiFCsarn8hhRtR9MBh+ql34bvujgZwJe4P
 gzCIamqnuDAIKErAI3E3ylnwtrOt7KFWRr8VePFCuticsTNrTaLs4hqQS g==;
X-CSE-ConnectionGUID: +ikAAnS2Th+C3ayQ1rv3ag==
X-CSE-MsgGUID: FbGHGlBbQA+gAs9yhHlVmw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="173584596"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Sep 2023 23:13:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 25 Sep 2023 23:13:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 25 Sep 2023 23:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiLjmO56MIUyB49VhDgmL+jMnsYVxCq0E4oPJbMbIcuEb7GhVh4JsAgyKin6pgw+QKw3viCQtwSM2OXLdx2MpPhnqbT/kAwD10iv69Q4OheFpH//WTkYXpX+bVwa9aA96gzYamcETtPuBmND2jPPlnWDpPuXsUHKguyph+y1N4TFdS/HYLBB5HcLarYxqgKPdItnkrwBZMoTfHZWndQMHlgAI56voNd+WOVYzqOx/MuC+Y/FFDRATqWdU4E8U2oY6kYjSGkCPm4qeBOY5OrzjUsKHVh1Nl8hQIsHWM6dXLiZXfSvToFE41MT1r5tHgu0TYfvsWVSPe8hbEMMCbfwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVAcTBBTAkBtXbXP2BIYVO3bp74Sh36DefnGt3VgXhg=;
 b=mCv5jM3SjgrTA/tlW9s5ShUXVUp3iGIQOeZgCfDxGw65texoY6DJ0SoH5eTRFoKFE4silf0XncYj147GB1K254MlMHw9svhxU8sVKp7K9LsjRJdBIpIDjbBczpnBXjGo/HBNLWGiXeLzPul2NYMprvXz3x39OSyWbM94i/EqmM7uPKiUgPEWxgQohPmKfu67Pf7CkLBO3wG6klUc6tCFuTsRZT+5K/Q4ZmJ29iImZnvAewAuwIAbeQ8JfOiOXio8+LBEj5bU4TuXVf2L0DvzPPmArB6x5U6udgGOUYGY+vShaj8jjsYFnhMdKcH8XtFIVqFc37NpFx0vfFINqeDMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVAcTBBTAkBtXbXP2BIYVO3bp74Sh36DefnGt3VgXhg=;
 b=gh1nOjVuBzk1UDN6JmcNAcy8C7S8a3pO5lYzlWWElN3axF43xGq0On3L383mo88Gfz9XzvbiEwLm1QJ7+zjirxNejDnLR9ewuQNQf4AZ3wYUp89sdxNxjXeOnNZD170cnY/2EQyhSLOLE4bd63g/87neR5cdMpRXSk6kBsjhza8=
Received: from IA1PR11MB6539.namprd11.prod.outlook.com (2603:10b6:208:3a1::8)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 06:13:18 +0000
Received: from IA1PR11MB6539.namprd11.prod.outlook.com
 ([fe80::1e48:8e4e:b65c:af6a]) by IA1PR11MB6539.namprd11.prod.outlook.com
 ([fe80::1e48:8e4e:b65c:af6a%5]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 06:13:18 +0000
From: <Durai.ManickamKR@microchip.com>
To: <u-boot@lists.denx.de>, <Hari.PrasathGE@microchip.com>,
 <Varshini.Rajendran@microchip.com>, <Cristian.Birsan@microchip.com>,
 <Nicolas.Ferre@microchip.com>, <Balamanikandan.Gunasundar@microchip.com>,
 <eugen.hristev@collabora.com>
Subject: Re: [PATCH 0/4] Add support for sam9x60 curiosity
Thread-Topic: [PATCH 0/4] Add support for sam9x60 curiosity
Thread-Index: AQHZ7K4OFKSfT7slV0yUm6+/NdDbOLAma58AgAY8FoA=
Date: Tue, 26 Sep 2023 06:13:18 +0000
Message-ID: <a11db1f4-0d45-9056-a7a3-60a451fe7f1b@microchip.com>
References: <20230921170631.45752-1-durai.manickamkr@microchip.com>
 <20230922-gangrene-evolution-9c087f58f165@ifak-system.com>
In-Reply-To: <20230922-gangrene-evolution-9c087f58f165@ifak-system.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6539:EE_|MW5PR11MB5785:EE_
x-ms-office365-filtering-correlation-id: 5320479c-7df0-4f78-1443-08dbbe57ad6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gSMNS7dQNGaKMUM6zMFUpVaQ74f5MLs6Q85sWxBM3CWjwzjzN1uesAByLMxqjUazdsZUMh7BHzonKLMyNhXq19dfD+CeQ6kAKD4P9Z5FPlcbniWMuDC7rV+Cax09mbM7nm/b9/31Jpfzw7fsp1O744VL3F/rI7B30OiJ9XI/7aAaLiqdYk7Z5tfYnaSlmNEncGefCNDNJ2jbEastFcXAzF3tWRNvO29KYvDKiUyXkKOqPSQInbjHN2qsfxmfN6svyQafaFO0wP7YSv9yGoFCILqp138tlgicbqxeSH2LReFJbU29vHwUmmaVLv2Eo5WzCORpNpmjEopVPk492ZxCo3Hr5/kk92EVOjlWVhdYEGsW5GMDyN47cwAtqok9K98kX4kMvVMO6S9AAOBUJ5eOfWm75Mfp7Jo4c25UjGM9dJfgcLvFH41yzsgjOt+tSuY9D3L3GBUWks+2slnxa29FIrcXF+ive1/ItbgeMBp04+ZNtUlfTDp89zIasLxHnbYjJ1A3JD0y4+Jn3sQmROxF+QRyiyfDKn0uJd20EQSqfRajPbA4M+nIaVm48ykGfWWIIz/VaPKh29UeL0xTdVjEg0ysm116OmWxfeDDk0HGAxnzs4xg6nstlLc3vC63Wg+z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6539.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(122000001)(6512007)(53546011)(6486002)(6506007)(26005)(71200400001)(2616005)(66476007)(36756003)(66946007)(110136005)(91956017)(64756008)(8936002)(76116006)(66446008)(66556008)(31686004)(2906002)(86362001)(8676002)(38070700005)(31696002)(5660300002)(41300700001)(316002)(478600001)(966005)(83380400001)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHhIeUxJQ1BybGw0aWI5MHNhU2o0U05PMEE2amFiTGU3YlgvME9iZFU1dGo2?=
 =?utf-8?B?T1Y3VFpLS0QwVko5RVNPYmwyVkx6YlNwMHhScUJBR05GbDNnTjZ6eXZiQ2Ru?=
 =?utf-8?B?WWpNNy9qYldkK2wrRVdpWkNjdms3ZzBNWGFtNk9RRkpWbUFBWWRoYjQwVEdi?=
 =?utf-8?B?S085OVlaVXVlOEFyVU5tRm10TmlSbmtlS3RERGNjUVU0aFVkMUNYNlBQK2dF?=
 =?utf-8?B?OVVXQTEvVHhvb1ZSL1ZNbkFtWUdHOUwrOHl1TlpRWjBna2o1eE94aVBPVTAz?=
 =?utf-8?B?WWQvaTNtT1lZWUM0NitpcFcvZ1lCQWRCTElZeXdiZFpmV09SbGJxdVc3bzZu?=
 =?utf-8?B?SDZPVURydXJxZ3NneE9rNXZxMTBNS3ZXTlp3ZHhUNHBwMjNrSE00cHpmTktx?=
 =?utf-8?B?M0hya1ZXbU1qQWRTQ1Y5N3BrOVlvMGsxVkx6YUFIWmZ2eUxjaHN3MjdJVE9C?=
 =?utf-8?B?TWN6TG5RRUVQWndkeUZLQ1JyTlZ2Yjc4cUJ1NHZjNzRXRlpydWx0cEhqOVdC?=
 =?utf-8?B?MjRYV0E1d3AwVWVUZ0E4NXVwemFwREFiblQxNzBvazB0RUdPQ0xNWWszekNT?=
 =?utf-8?B?cFk1dlNjbzJ0VFBoTGM5cHdYMDZadlFMRlkvcnJNZmJHOFdqd3pQWmdCcG90?=
 =?utf-8?B?UWtwQVpQODZOUUxPdTcyWFZZVVNtSGIrWUNJUm1zeFR2NytQbEhLVFVJQnho?=
 =?utf-8?B?a01ySWNqU1AyY0xkQ21OeTNxTnN3V3UvTFhuOXlYcitRNmd5dGJyZW4rSk00?=
 =?utf-8?B?RlhrT3VFWHN1OC8xL0NEL3kzM3lyTGV4V0VxaTRGTlA2anBPUjM5Y3pKZ2NC?=
 =?utf-8?B?eTBSL2xGcXBzU3cvK2hyaWFhWWcwL21Cdllmc2hURUUwSWZJdk1nRXdYbFBM?=
 =?utf-8?B?M1ErYkVJWFlOUFU3UjFGc1BpSnZnRi92RmNLSFU1Q3orZitKaHlCandvZ0NR?=
 =?utf-8?B?Z3NReDYrV3dwc0R5YStTY2lSUFFwdnlnYnJvaU9jM1lIck02NjhnYmIrbmtD?=
 =?utf-8?B?NXBNM2Z1UlRNVzlyS3VNQXNvODBTcUN3MTFuajZ0WDB2VlgvY0I3WmxGWFFi?=
 =?utf-8?B?NURNR1lvSklSa1NESktkazFuUGxPZDJvREFWY0ttUkxYV2dpVzVZSlRlUlM0?=
 =?utf-8?B?YjJRZ2pzcWp4aU4ySTRUS2Rla2dhQmpuNWZHWE9rQUNPMGZBWStkTWxYU1FD?=
 =?utf-8?B?elBNakxKSnRPUHE2SmhtbmR1OFgzd0c3YXRRWU5vdVhBLzNpVzN5VEczRTZC?=
 =?utf-8?B?Z1lVOTRaQW1LR0kyMk92ZXl3SGhZRy9yL2F6RzJmcGsvMVpib3lOeWlRTld6?=
 =?utf-8?B?VndRclQzQ0tPRVpMU3ZUMlpFdU8wdkJ2WXE2Tk1ObVhxaDZFc2pEeWROVWwr?=
 =?utf-8?B?dFVKZ085N2lkUUZ4R0lvb0UvT0tsMGVEK09yVEtnMDh6YXFsZG1NZXJpQnJz?=
 =?utf-8?B?YS84dERqU0lxbUk1Q0c0aDgwdDRhQUZvMXpvQkNSc3dmZzdDZ2oyRjFoaUZE?=
 =?utf-8?B?eitnZlFFNDg2WVpqNDBOTUswNlZhNUhXczU1bmhvbmVubGYrcmI3SzNpREht?=
 =?utf-8?B?WWg2NTN0NXh4T0I4SnN4WlJBOFFEK2xLMmxRUFBVOXNqazBrbkhPWW1PV2ta?=
 =?utf-8?B?T3dEOUFBUWllSGhBUDVsWi9pRERXV1NLU1c1cndrMk5GWlB6dFF4eW5oM1lM?=
 =?utf-8?B?UmFpMWJnRDRkSWNQQXdJMjZETlFzRTFrbTcvNHJKSVdJczBULzg2U29yVVJU?=
 =?utf-8?B?YjFOZU1GK2c2bVNxamdySHdDV3lQM2FCN2JIdERaeCtJOHpjRXBVSjV4aVJ4?=
 =?utf-8?B?T243cHpqN296ZVdmUVRydkYrSktRTzJZYjJidW1lWHNOUnA1NTRnSi9sZWdX?=
 =?utf-8?B?bWNRSTNKUUVkaHJFRmRnRkxPQk53b25Ra294QzVkR3I0T3hFQ0d4MUx6OFhL?=
 =?utf-8?B?eFo5amlKSGdvL2RwSS9aTlF3V3d3VHA4djJ2UzRyUGtKblZrS1BpMDFacTZm?=
 =?utf-8?B?dGM3dUlBMkg4YWMvUnJJVTNndnpqMnN2WWNQWWVpZm1maytneTNEdnlyL2pE?=
 =?utf-8?B?a1dKUDhjVlNSUk1BR2Y5MDlBY1ozaDVGYnk0TEF0OFc3UVRaWlhYYkpvWkpR?=
 =?utf-8?B?VVFWeXJvWklOSkx3eUNlWERPVVBMQWNJY0p5OHpFUHowSE4yT2JwUVpicXBk?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CAA47CCC2122E4C9BD3176228323316@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5320479c-7df0-4f78-1443-08dbbe57ad6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:13:18.3623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClXBzbMB69xpqiUQeNtUglB7Qgz55sSPob8BRSkHtGK9GuQEn0R9mguUoB4amFeX4mGRy+5DcP7+vChJVkh+6CgLhXKOCVvxWC6wa0O9OcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
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

DQpPbiAyMi8wOS8yMyAxMjozMCwgQWxleGFuZGVyIERhaGwgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBIZWxsbyBEdXJhaSwNCj4NCj4gQW0gVGh1LCBT
ZXAgMjEsIDIwMjMgYXQgMTA6MzY6MjdQTSArMDUzMCBzY2hyaWViIER1cmFpIE1hbmlja2FtIEtS
Og0KPj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBib290IGZyb20gTkFORCBzdXBwb3J0LCBjb25m
aWdzIHVwZGF0ZSBhbmQNCj4+IGZpeGVzLiBUaGUgY2hhbmdlcyBoYXMgYmVlbiBkb25lIG9uIHRv
cCBvZiB1LWJvb3QgdmVyc2lvbiAyMDIzLjA3Lg0KPiBXZWxsLCBpbnRlcmVzdGluZy4gIEkgc2Vu
dCBwYXRjaGVzIGZvciBOQU5EIGZsYXNoIHN1cHBvcnQgb24gdGhhdCB2ZXJ5DQo+IGJvYXJkIHNv
bWUgd2Vla3MgYWdvIHdoaWNoIHdlcmUgYWxyZWFkeSBhcHBsaWVkIHRvIHRoZSBhdDkxIGN1c3Rv
ZGlhbg0KPiB0cmVlOg0KPg0KPiBodHRwczovL3NvdXJjZS5kZW54LmRlL3UtYm9vdC9jdXN0b2Rp
YW5zL3UtYm9vdC1hdDkxLy0vdHJlZS9uZXh0P3JlZl90eXBlPWhlYWRzDQo+DQo+IFRvbSBhbHJl
YWR5IG1lcmdlZCB0aGF0IHRvIHRoZSBtYWlubGluZSBuZXh0IGJyYW5jaC4gIEkgc3VnZ2VzdCB5
b3UNCj4gcmViYXNlIG9uIG5leHQuDQoNCkhpIEFsZXhhbmRlciwNCg0KV2VsbCwgaXQgaXMgcHJl
c2VudCBpbiBjdXN0b2RpYW5zIG5leHQgYnJhbmNoLiBPbmx5IHRoaW5nIHdoaWNoIGlzIA0KbWlz
c2VkIGlzIHRoZSBOQU5EIGRlZmNvbmZpZyBzdXBwb3J0IFtQQVRDSCAyLzRdLiBXaWxsIHNlbmQg
b25seSB0aGlzIA0KcGF0Y2ggc2hvcnRseS4NCg0KPiBBZGQgRXVnZW4gdG8gQ2MsIHNpbmNlIGhl
IHN0aWxsIGlzIG9mZmljaWFsbHkgbGlzdGVkIGFzIG1haW50YWluZXIgb2YNCj4gdGhlIGF0OTEg
c3R1ZmYuDQo+DQo+IEdyZWV0cw0KPiBBbGV4DQo+DQo+PiBEdXJhaSBNYW5pY2thbSBLUiAoNCk6
DQo+PiAgICBjb25maWdzOiBhdDkxOiBzYW05eDYwX2N1cmlvc2l0eTogdXBkYXRlDQo+PiAgICAg
IHNhbTl4NjBfY3VyaW9zaXR5X21tY19kZWZjb25maWcNCj4+ICAgIGNvbmZpZ3M6IGF0OTE6IHNh
bTl4NjBfY3VyaW9zaXR5OiBBZGQNCj4+ICAgICAgc2FtOXg2MF9jdXJpb3NpdHlfbmFuZGZsYXNo
X2RlZmNvbmZpZw0KPj4gICAgQVJNOiBkdHM6IGF0OTE6IHNhbTl4NjBfY3VyaW9zaXR5OiBFbmFi
bGUgTkFORCBzdXBwb3J0DQo+PiAgICBBUk06IGR0czogYXQ5MTogc2FtOXg2MF9jdXJpb3NpdHk6
IGZpeCBlZXByb20gY29tcGF0aWJsZQ0KPj4NCj4+ICAgYXJjaC9hcm0vZHRzL2F0OTEtc2FtOXg2
MF9jdXJpb3NpdHkuZHRzICAgICAgIHwgMTA2ICsrKysrKysrKysrKysrKysrLQ0KPj4gICBib2Fy
ZC9hdG1lbC9zYW05eDYwX2N1cmlvc2l0eS9NQUlOVEFJTkVSUyAgICAgfCAgIDEgKw0KPj4gICBj
b25maWdzL3NhbTl4NjBfY3VyaW9zaXR5X21tY19kZWZjb25maWcgICAgICAgfCAgMTQgKysrDQo+
PiAgIGNvbmZpZ3Mvc2FtOXg2MF9jdXJpb3NpdHlfbmFuZGZsYXNoX2RlZmNvbmZpZyB8ICA5MiAr
KysrKysrKysrKysrKysNCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMTIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZmlncy9zYW05eDYwX2N1
cmlvc2l0eV9uYW5kZmxhc2hfZGVmY29uZmlnDQo+Pg0KPj4gLS0NCj4+IDIuMjUuMQ0KPj4NCg==
