Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2080DC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537AF88373;
	Thu, 25 Jul 2024 11:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="y00rwJoS";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="rv88fEZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3945F88361; Thu, 25 Jul 2024 11:33:29 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7766E8841E
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=929517236=Balamanikandan.Gunasundar@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1721900007; x=1753436007;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rTAbUEq6DfYghJgWYvcPgY2X7U+JiEHRwX+BIImtiN4=;
 b=y00rwJoSLoQWwYHfzapHyaBwXzOehcT7Pbc7HzGC282NSsSNVBtNB8q9
 v2vlAncCo3MlAFquYqCwxMD2qKjJIkzNgbWpCtH5GrQeLvIExrqeLhgFC
 YqVtawMdbdQ3C4b5z30a9Te2m+eiDSoiB+WPjEKlMvSq9aol+TxFIaYVP
 8ofNkepA+TVyLV0YwuznKLHGDI1gWpfTA+CFbRqigsIX65BLtpzJumhSU
 99sRBsPlRwCpIbx6frWycRxQfJlRrfE6P9ZtK0ea19zs/ZTKU64s5WFaF
 ye0GCwdK2rXjtmdlJXxB2h4s2oXvAT6l3Nja3UUhDoZB8tHhqQovlNfQh A==;
X-CSE-ConnectionGUID: xj7TlviFSoi9qcYiHehpLw==
X-CSE-MsgGUID: 63psgydfRRCxDJbfmcGEPw==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="29674107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Jul 2024 02:33:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 02:33:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 02:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxk8hXnCqbsbgxqghPff+bbExAGRXUE3N6SIxKmSyitI5bhr2JHCyPS+Qs+5rnkmjN2GJLHeKTZ7JEl0qySVkEibXlLr0hyzgWAXtomHgvjAwU957IyvFdBgBAMaQOuZiwU57XbdlNjufx/YqpqOHi8SGqNGxcERoNV50BD4zM017LWJ6Yf1aaLcMhvhQ1wip1ndzUT+l3Gs9GJOj165M11kUAIQ1B7BKvKzyYWsKVEFQPOnKyY1+ZvX0brwFpGfCP4cfBA7HlDNHmxdZB4yrcH45yyd0CC4Q0/DzB0XMLqHRSebv1KxXAw1cBY1zaRL3Zd7EPIoX3P1j1P3J7yAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTAbUEq6DfYghJgWYvcPgY2X7U+JiEHRwX+BIImtiN4=;
 b=E757InZoQ3O4H3pt6f43KnGoaeAd0GmDuUWC700xPRg5jPmTGXW0q6rMu66TaC8zfiIG6+Z98fiLkKyxX9MFzQq7dN6FCaqikiQwRLO1VaJCJAv0BPl8CsIbPOjCXtdRkdsYyRO8FJitYb7vIlM2yzQ5FpLsc+FYPjMZwqokI3QBY37RvXQmGQYRyPkrzVbPy+VDROEKAbL5Pa39B4PVusK3gOqJYhVvqRwDTbKvFWrWlg2HaGZKpezezMaDFkiXQkWQdUjW2cafmQiNiO9pH0hqJ87MYWKgkV9he8ft+Fomi9Lz5a9/u+ltRTdNT/H4OKdL1ftx5F/9LGC+7B9ztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTAbUEq6DfYghJgWYvcPgY2X7U+JiEHRwX+BIImtiN4=;
 b=rv88fEZLWkpk0Q85dq+UxGRpUJyiD7ueYNT1AIn+mjly2y8chxNH8X2ZLdl+ChX9oEQ+OSHHDmzfE58eGJq4g7rXv/AGok192S9vNbvsQTdzI9zuJNaQhXQgVya6NOtVqIE9qZPmLGnr7kkRaEVUfY+Iwzt9dWM7jFxPSd8BOygcbYMfMkiHckUVakfto1xWwnh9wpNBOWdMmheeEI42x2GrznLqgz+wbp/nAXQNw3MmEHi3qfqGlXn0XeIBKacywFFWmUi6df3W1pts0GqNcLCUE25COxnvBuW0X47MNkNyCNcG99BuT2TDtQ9jCpKUxOF8hc9kX3Z2zP/sXPeMzg==
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 25 Jul
 2024 09:33:13 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%7]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 09:33:12 +0000
From: <Balamanikandan.Gunasundar@microchip.com>
To: <michael@amarulasolutions.com>, <zli@ogga.fr>
CC: <ada@thorsis.com>, <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>, <Balamanikandan.Gunasundar@microchip.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: Use ONFI ECC params if available
Thread-Topic: [PATCH] mtd: nand: raw: atmel: Use ONFI ECC params if available
Thread-Index: AdrSTW6mmB6pXteCRRSkKoT1NBAEcAATWGAAAauShtAAAI4NgAFKlc4A
Date: Thu, 25 Jul 2024 09:33:12 +0000
Message-ID: <22dfc609-f16f-4105-8e81-352caf100b25@microchip.com>
References: <PAZP264MB2974E713F54A40AB9B17DB85B1DB2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
 <20240710-talcum-repent-307fd836d683@thorsis.com>
 <PAZP264MB29745BAD4E854E1884E5A9CDB1AC2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
 <CAOf5uwmN5t5Mvg8GZe-F=B5ykmeuLfw69ctS5GZvOYZcZczsmA@mail.gmail.com>
In-Reply-To: <CAOf5uwmN5t5Mvg8GZe-F=B5ykmeuLfw69ctS5GZvOYZcZczsmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|SA1PR11MB7085:EE_
x-ms-office365-filtering-correlation-id: 4f8f6a4c-9c5d-484e-eb42-08dcac8ccd7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SCtOTlhSUDlRdzhOZ3lRd1BSK1VVNlpvZVVXa2ZORzAxNGswTVlWL25VeXZM?=
 =?utf-8?B?bnY1cUJTc080SnRGRkRLZWI5b3dPS05IWVltOXQyY0JwYXJKUjdnSDJIQTMv?=
 =?utf-8?B?MEdKdkhQWXhQaXBORFVZUXZxanpobVVZMGtja3pwbnB2R05lVVlkUHJqUkdn?=
 =?utf-8?B?Z1d4RHlYUysxVVV4b25FMklOSXRMaEIxaG0rVXU3VFlaRTRzKzhiYi9DLzhB?=
 =?utf-8?B?NzFBQWE2dWI5TmFKQnZ4L0pzZVRPYUFYYWU1U0FvTEYzQUVSY3FRdFNWVFo3?=
 =?utf-8?B?STZ0OWFOWkZuT0tqb1Q1a0ZqR1FpQjlLSTVvR3dxamRYSldMSGpoUEFTZmdN?=
 =?utf-8?B?QzBVRG94RitMQmtFcm03d3h3WkplYnRQb3hxMjVDQTV4ZnVvSFpvdFVSWTVm?=
 =?utf-8?B?Ui9MVXhaQUJZYTd3RkRTalcrZXY0MGl5anNhem9xdmxpOUZXdUdlZUxVcmtV?=
 =?utf-8?B?dUxJbEsyajZTYjV3Q3Z3c1JveVZVZTZRWFQ4WVNRd1JjNGhlUGp0b0ZKZkhN?=
 =?utf-8?B?WTFjVlFQWDJsaVRKbTRtancrTmNKTkg0N3BRcUlHNkU1L1lxdFczVlhGTWxY?=
 =?utf-8?B?Q1FuekM4SlQvV2ZyYWlMd1pKaFRmOHd6Yk5Cc2NaeElNOGdCREFmM1lBcFhm?=
 =?utf-8?B?dzVLMEtVMncwOVVNRVUwaHBrbHVDMjlLNGZDSEMxcG9qM29NNWJkNkwrVFVY?=
 =?utf-8?B?WkFrVEd0MURxemFNb0lDOEtMUlB4ak1BTFZhdWRCc0kzbXlZOGJCV2RFTWhY?=
 =?utf-8?B?LzlHcWNnYytqVlNRMi9qb2xsTFlHY0RhVDdEcTZEOTJiZFoyR1pPSTBlZmdq?=
 =?utf-8?B?TmlCSHQ5OEZyZW51Vm8vdVVRSlRDcUZ4TFMrbXZiUEJ5K1VEMkNBb3d3cDFx?=
 =?utf-8?B?eHkyb0dLQzl0THErampITnZGcG54aDJGaHREQzU5V2dVNHJ1Y0FTQ29QblZZ?=
 =?utf-8?B?cTNvc1Jmc2hTRnU0SnIyYlNPeW1yWjl1cmZoU1F4U0w1Kzh1NkJYOWNQUFZs?=
 =?utf-8?B?bzUvN0hBVWFNeVYzYWlSN3lsV1BsMlRzcG94NHRqTG5yZjhIcWdFUjljY3lo?=
 =?utf-8?B?MnFiOTNRNUI2dEwzeVNOa2FjaHJteVNGR2N3MFgvaXpSRk9uazdRSkNTYVRm?=
 =?utf-8?B?UkZpbnBKU2dRdk9MMUlMa2VrT1lUUjhaNTBoRzFXYlIyWVVTbVN1ck9DTnBv?=
 =?utf-8?B?TGhDVGxUaWlYcWtKb1JmcC9Zb1cydW5ZY2FsYmRFRHlXWENKTmtMaXRYNlN2?=
 =?utf-8?B?Q2czMnRJdFlxU1FTd3A5UDZ5QWFrZndRZ0xTTnEveEJJRzFSZ3pLUnFOVDRN?=
 =?utf-8?B?TjJUNy9oeEEzZ0hGdWhQVUQ0ZDVybE9wWWdVUHArSmszVS9jODN6VXY3MXpY?=
 =?utf-8?B?Z250eWIrMXRuNTIwbVpOWTFuZFIvT0dEZDN5QXRMTlJFMHZjVDVNd0NHekpx?=
 =?utf-8?B?Ym1Pa09LaUhTckZ4R3BRWWxES01GcHZIdmRDZGxTTy9MZitwWktvQzNibU41?=
 =?utf-8?B?L0E2SFE4OGcwVTBaRGF6ZFhMUGFzd0ZTS2playtITFdvdHFrUFlZclhjNXFs?=
 =?utf-8?B?cVoyUGRWME5nU3dIZ3VGQ0JpaUdNb2pjUlJIMzVWam5IYVNhQkowS25XZElK?=
 =?utf-8?B?czlOaG9XaFh1TEZLajRzV0pkek1zNk9NZjhZZmlZS1lXbkxSaG8vODF5V1hO?=
 =?utf-8?B?dW9HQlBUUUpKUFdQa0N1Q0N6dUpmblNhZlM2Q0JGNEJ3UnpGWkRhbDRsL3Vl?=
 =?utf-8?B?eS9yYVR2RWpUUSs4eG00eDJPQ0ZHWlNsbnVGVThlcWVFdnc2NFArS1dLSkQ2?=
 =?utf-8?Q?Z+bViVSceqh1mO0poez6voOhE7ZWoZHj7qLvs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6231.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlRmM3ovWXFuTE9LMHJUUDFhaUdwak55RDRsR2htM2VoRys3N2Q5NXE5S05F?=
 =?utf-8?B?ck1oQjY2L1AxM2owblozbVdrK3ZLWVQyTW9iQm5xTlpLKzhaZHV4ZUJ6SGdS?=
 =?utf-8?B?NDlWOWsrNFY5NXBndzFvaFVlZmNSNE8rNkcyUjF5T0FiSGdWZWtCNVN2dnJQ?=
 =?utf-8?B?eExWckNOcmxzQ0wvZnZIU082M0tEZWJxSHdaS2d1eko5eWE1QjBpTHhrczBP?=
 =?utf-8?B?a1Z1TFBrYkt6NzJ2VFkyWmxCdEFlcm9hd0JzUHg0MDc4VlgrYnZqWmV6YWo5?=
 =?utf-8?B?Q0VmYitLVmxZbmltcUluSGVZOWlIZ1MzK2tKUlhjOER4S1V6SFduclVOVFpj?=
 =?utf-8?B?WkVDRk1mamZqMWpnSlNoTEpsa1VOSFJUUWp5NTZhR2lPdTcycFN2YW1Qem5v?=
 =?utf-8?B?dFo2UndVUXR4WGJseERVc255YjQyeVhsOWZXb2NmTWlPWHVFM01xUGZ4UitR?=
 =?utf-8?B?Si9pYXY3MVJTbXhidGlwUktkWWhkS0NsQjJoWUNCaURXV2RKRWk3TTh6YzE4?=
 =?utf-8?B?YXNZRnBHNEZIRENva3dobTdINlNBMWcxTzBBYXpFYnlQUGcwTzREZnNwQ1Zl?=
 =?utf-8?B?dGhBenZLOVFzbE5MZzRMbWY4TnlBWlV2MkllZXZSN0ZuWjlHSG05dWRoVXR2?=
 =?utf-8?B?TWhLMk5OQnVnMWM3enpic1BoU0s5MkViNVY5Qmc1c3Q2N2l3UTMwY1V3UTUx?=
 =?utf-8?B?eURBbmR6MGc0Z21KS1IvV0QvbjVReCtNM3dJS0pYSmVkaGNmSHlhc3B6RUxY?=
 =?utf-8?B?WGgrZ0xhcjl0U2V2cDVCQnU4MVB2UHBvUndndjZ2akM3Y3Fmb3BjcDZZNExV?=
 =?utf-8?B?b25oQnFRcDhUVzkzbzEzV2FQeWJic0NydkV6UUdUenBGYS9RMkxRSnZEdUY2?=
 =?utf-8?B?R2JoRzRUNnZZWEV4cTZhVTJKK0VQTTh6ZVZtUmI2cFlrcGNLUU9ZRVIxbC96?=
 =?utf-8?B?dUhTNjFYeHZ1WEtyZTMwY0tyYkJFcDhPaGdIUUFtUWxOZklWNk4vaVlnc2E3?=
 =?utf-8?B?YlZuR2JQTVVMTGp1M3NWR0ZLenpnbktqTFRFMkt2M01lNHcyeURiU0pPOEJW?=
 =?utf-8?B?dmV6Zm5CbU1hdXR2UW1kN2ZkaGc5NnVQeVpjN242U3NVLzRGc0tZSjIweU55?=
 =?utf-8?B?VkExbjlyT1NBM3BqNFNMR3VyOGYrS0xTZDZ5NmswZE1EWExmeUNMT2J0YlUz?=
 =?utf-8?B?MWhCLzNPUGVRM0Z1S3BOdXdNcUpLcHc1c1pSbW9yazRXR3UxVm11QlVJcVQv?=
 =?utf-8?B?dENFMS9MTXU1WmYrenJXcXlNOFY0YlpQYWVaWVZFaE5FUUtrK0srUUE0akUx?=
 =?utf-8?B?c2RZMEdST0hSSy9HNVBxNGIyQ2dtcllTeVE1RGZQdEZ6SGcrMFlhZVp2MVVR?=
 =?utf-8?B?OVA3cDEycXZoZUkwL3ZRMjExZ3d6Z1krS2ZiRlI1U1VVQm90VzhMRitvREF5?=
 =?utf-8?B?U090T0E3ZkMzaEdEWjZPTU8vdUVXVDJCcy9WT1NPMXZFWXZVWEhveVFPN3Vm?=
 =?utf-8?B?emJKaFczOXVaL0FnMVNKTTJGclJQZ2QwUi93anpHaXVyZ0NSUkxIMlA1d1Jt?=
 =?utf-8?B?RjU5eGpSSkpuMytvSWtUbmdjVWJpVnBjOURpNUs3V0pYVzRyRHp6cG9VOG1p?=
 =?utf-8?B?RVIxdk9GUFlTc21qdXVVY0tKRm0wU0lrTkFBVHB0UjlzbjAweEh4aEpGNUV6?=
 =?utf-8?B?TEtvOVRQYjlsRFRLWHRjdnBmM0ZieTRSTGhJOGxTdldQRHRsTlJmbTRpM2g3?=
 =?utf-8?B?WnVnTEM1RXQzRmkvRklvSkhJN0NTbjZHUDNhK29adXFUNDlUaU9yTWo5Snp0?=
 =?utf-8?B?dzhLYVp6M1J3WDVxWi9sR2dLZnhHVWFsS1RnZVhUUGhhZlJsTzVURE1BWU5L?=
 =?utf-8?B?aEE4WEFSWHBhZVNnMjZKb1FmMVFoVXZXaXdEWkJQakpGaDVicURXV1AvalNn?=
 =?utf-8?B?OVFlTkx6VTFPWnpmdUpaM1cvZ3dwNGpVeENMZ2xWYld6R1lTeS9WV0RRSnh2?=
 =?utf-8?B?NDAvNUpYSFBWaFgvcFhxN1pIZlJ1RUt5dmR6aWtLcW9pYjg2SzZGbDFNakx3?=
 =?utf-8?B?aHYyczhWcUxUSHZ2QUlPZzhyM004R1g2RlZPa0NrVkR5a1FaRGduR0toV01o?=
 =?utf-8?B?Zit3VUNTN09YSjhpOTJWcUlUMXR2L1JPdkhac3ZCYldVeElxM29MNDR5UTN6?=
 =?utf-8?Q?vsbZzSvOHG9/XED7ycyT5aM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1445BFC2BAAA4146851546C28DD87865@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8f6a4c-9c5d-484e-eb42-08dcac8ccd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 09:33:12.2365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8XUZsAgAwikf54o979KZvp7q97plzRKaR4NVgJ7jJwUEJJXXe3TMl0yozpeGFfXHMn1Rh+KLEtksIFLaT7b+IVWknAmh88y0A5sL0CkQs5OPO7EgLoW1GvcdteLvWEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
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

SGksDQoNCk9uIDE5LzA3LzI0IDE6MTcgYW0sIE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSB3
cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaQ0KPiAN
Cj4gT24gVGh1LCBKdWwgMTgsIDIwMjQgYXQgOTo0MOKAr1BNIFppeHVuIExpIDx6bGlAb2dnYS5m
cj4gd3JvdGU6DQo+Pg0KPj4gT24gMTAvMDcvMjAyNCAwOToyOCwgQWxleGFuZGVyIERhaGwgd3Jv
dGU6DQo+Pg0KPj4+IERlc3BpdGUgdGhlIG1pc3Npbmcgc3BhY2UgYmV0d2VlbiAnaWYnIGFuZCB0
aGUgb3BlbmluZyBicmFja2V0IChjaGVja3BhdGNoDQo+Pj4gc2hvdWxkIGhhdmUgdG9sZCB5b3U/
KSB0aGlzIGxvb2tzIHZlcnkgbXVjaCBsaWtlIHdoYXQgZ290IGludG8gbGludXggd2l0aCB2NC4x
MQ0KPj4+IGJ1dCB3YXMgY2hhbmdlZC9yZXdvcmtlZCBtdWx0aXBsZSB0aW1lcyBhZnRlcndhcmRz
LiAgSSB3b25kZXIgd2h5IHRoaXMgd2FzDQo+Pj4gbm90IHBvcnRlZCB0byBVLUJvb3Qgd2hlbiBp
bnRyb2R1Y2luZyB0aGlzIGRyaXZlcj8gIEluIDZhOGRmZDU3MjIwZCAoIm5hbmQ6DQo+Pj4gYXRt
ZWw6IEFkZCBETSBiYXNlZCBOQU5EIGRyaXZlciIpIGl0IHdhcyBjbGFpbWVkIHRoZSBkcml2ZXIg
d2FzIHBvcnRlZA0KPj4+IGZyb20gbGludXgtNS40LWF0OTEsIHNvIHRoaXMgZmVhdHVyZSB3YXMg
cHJvYmFibHkgZHJvcHBlZCBpbnRlbnRpb25hbGx5Pw0KPj4+IERvZXMgYW55b25lIGtub3cgd2h5
Pw0KPj4+DQo+Pg0KPj4gSGksDQo+Pg0KPj4gU29ycnkgZm9yIHRoZSBmb3JtYXQgaXNzdWUuIElz
IHRoZXJlIGFueSBjb21tZW50IGZyb20gbWFpbnRhaW5lcnMgPw0KPj4NCj4+IEknbGwgcHVzaCBh
IHYyIGlmIHRoaXMgcGF0Y2ggaXMgY29uc2lkZXJlZC4NCj4gDQo+IExvb2tpbmcgb24gaXQuIEFu
eXdheSBleHBhbmQgdGhlIGNvbW1pdCBtZXNzYWdlIHdpdGggb3JpZ2luYWwgaW5mb3JtYXRpb24g
b2YgaXQuDQo+IExpa2U6DQo+IA0KPiBVcHN0cmVhbSBjb21taXQgPHNob3J0IHNoYT4NCj4gDQo+
IFRyeSB0byByZXBvcnQgc29tZSBvcmlnaW5hbCBjb250ZXh0IGZyb20ga2VybmVsDQo+IA0KPiBN
aWNhaGVsDQo+IA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5IGluIHJlc3BvbnNlLiBUaGlzIGNoYW5n
ZSB3YXMgYWNjaWRlbnRhbGx5IG1pc3NlZCANCmR1cmluZyBwb3J0aW5nLiBBbmQgd2FzIG5vdCBk
cm9wcGVkIGludGVudGlvbmFsbHkuIFRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KDQpCYWxhLg0KDQo+
IA0KPj4gLS0NCj4+IFppeHVuIExJDQo+Pg0KPj4NCj4gDQo+IA0KPiAtLQ0KPiBNaWNoYWVsIE5h
enphcmVubyBUcmltYXJjaGkNCj4gQ28tRm91bmRlciAmIENoaWVmIEV4ZWN1dGl2ZSBPZmZpY2Vy
DQo+IE0uICszOSAzNDcgOTEzIDIxNzANCj4gbWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbQ0K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IA0KPiBBbWFydWxhIFNvbHV0
aW9ucyBCVg0KPiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MDQo+
IFQuICszMSAoMCk4NSAxMTEgOTE3Mg0KPiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IHd3
dy5hbWFydWxhc29sdXRpb25zLmNvbQ0KDQo=
