Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90535E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 03:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A75D8018E;
	Fri, 13 Dec 2024 04:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GJcuFV8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F69801A0; Fri, 13 Dec 2024 04:29:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5920800D7
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734060541; x=1765596541;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jYZ6hOuEg+DTw2CI998nmVUzTPZQazzPnoMS86CGnxM=;
 b=GJcuFV8UYhSKEZh2BscODGyzxAxtVPFkoYThjW1WnyJIrj+lZvQX6IqR
 f3NK11DSYRDpz1SdOJ9djh2pfzWJ+LBmfxyV+VxGmQQsVDBJLMP162r4r
 1LguysoNXZXpA6U4Ki+MzPa5QUxyqDgq13zUKGCaOj8yeYjrZBVboX3mq
 wpzI8TeetE4eFTafKxotA2RaHQGhhREguUlJb9JIF7UQLXul+hXBYJGVk
 VI3BtwQZwo70FKYKuQlnUtHyHVHCoBkPtU7UcOpMp012YzdBBAYVPnceq
 PkxXURLZcM+NIfgg7URHhlG2vGMiAfExXyvImMM2htcg2eoTuo7zEdWTr g==;
X-CSE-ConnectionGUID: ayjEmAxJSJ68tEhTKm7V7Q==
X-CSE-MsgGUID: EQHj/YxYRWG/cVFAyQTGsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="33835465"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="33835465"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 19:28:59 -0800
X-CSE-ConnectionGUID: Vmfyfr5hS7aFAUoEGrlTyw==
X-CSE-MsgGUID: 9qmb5o6ERGSElQuTovvkqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="96858463"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Dec 2024 19:28:59 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 19:28:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 19:28:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 19:28:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so0yThZLDqHmu5D8BTJmwgVzqpFXOMTdL0s+cdOFptI9BM0GoMpgoVQwc0MErV1ziEyXu+2CfZl1FxW4oSBFbgBMNCf4szpfHL3jq8twfC9559OU5zQmMZh+8B9XMw0Is1h3UDLYphznzQwmHzWqvIBsO+T57iA8GqbpmUr/vTUVKKbE6kPxON9SMjo/0sod4GMQKTD16+XECmxwhH8S+Yf1LbYMGXMRwy7SdcIvcpVtEAzZsjG847UzJYGQnM406gMlRmeVavg1CoFtaPpph5U2ZFV0L9ikVhEpVZGH82AWA0Eb5QXgF8lBOkCBaJ6yMFbcGppbS1QohnW7ZoC13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYZ6hOuEg+DTw2CI998nmVUzTPZQazzPnoMS86CGnxM=;
 b=DViSDDzWAUe7FvP7+4W50Ha91VZaj1zzNWNj4ISjdG8mGfqz0UPSI2tGmkDE/DYCTmgerkx864At37ymRw4PLa6qC9RzMAa/iQqcanu+8iOhsga2vHPZqfY9nv/Hdppdsfg6h6+ty9uM1AK2G64GqmgcPKMYyP0yarSHfKCh/Wcon19dmOp2+G4wehHcu5zTE2HMLVXszOsU76R+rMzVDypjs0XKj48VPavz84oZiIK2maQUtXA7cz03syI/GHG6NRPhqy/FlYuTCNClzuPJTaSmMxMh2ai+AWfpJrb/dwOjQowLQAJjH8mZ8MVcokVuSr1zxtK4Pw3ul7CwmXjRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 03:28:14 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 03:28:14 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, Dario
 Binacchi <dario.binacchi@amarulasolutions.com>, Johan Jonker
 <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>, Arseniy Krasnov
 <avkrasnov@salutedevices.com>, Alexander Dahl <ada@thorsis.com>, "William
 Zhang" <william.zhang@broadcom.com>, Igor Prusov
 <ivprusov@salutedevices.com>, "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad
 Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [resend v2 15/19] drivers: mtd: nand: base: Add support for
 Hardware ECC for check bad block
Thread-Topic: [resend v2 15/19] drivers: mtd: nand: base: Add support for
 Hardware ECC for check bad block
Thread-Index: AQHbRveJIYa/ofiJPU6+DzbO5n57K7Li/B+AgACTqUA=
Date: Fri, 13 Dec 2024 03:28:13 +0000
Message-ID: <BL1PR11MB5366A5AA28308B83D7AD450A82382@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <20241205092315.25060-16-dinesh.maniyam@intel.com>
 <CAOf5uwnrJa3HcdMgu7SNjrG4h+71E4=BReCj_Cfz19cJbDwAWQ@mail.gmail.com>
In-Reply-To: <CAOf5uwnrJa3HcdMgu7SNjrG4h+71E4=BReCj_Cfz19cJbDwAWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|DM3PR11MB8713:EE_
x-ms-office365-filtering-correlation-id: 8246ad3d-e351-47b3-45e8-08dd1b262d59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bnZMY0FMak0yTHFXc3JMOVB1ZENGK3hqVXl0d1oyQ3RQRmp1TEhTdXhndlBr?=
 =?utf-8?B?TkF3eDZsbEFDdW5EcjR1d2pvaUxjby9PZlJKSzBRdVBISUMwVTdrbjBZTmRN?=
 =?utf-8?B?K0J6UU9JUlk3WUVmTDMyVDZNbkpnc0tSY0pScmlpMXlFdlBrcnp1YjlUUkdM?=
 =?utf-8?B?NFFoTnZROG5Cc1ZBZUNoNkZzQkkzWkN3WURIMFc2V3FrRUhBcHFCemtmVm5o?=
 =?utf-8?B?RUNZMysvWE9OcDZFRG5HNldhUWg5eVJmMW1nUXVjR3A1cGtaeitIc1QrRG01?=
 =?utf-8?B?OWkyS3dRYmZhSG41S29Bcm5kWjVtaS80bVZhdGlOQ3ZvVWxteFBySFRqSTF3?=
 =?utf-8?B?SmdLaCt5ZWk5a0ZjUHBOSW1oNUs4S0cva1J5YjdyRDF4RE03UnR4eUFXdFRp?=
 =?utf-8?B?TFhIcDdrcVN2TnBOdGV6cXRDTmhnVFBMN3pVbmJxS0ZBNFpqNkZocWhhc3BQ?=
 =?utf-8?B?c3dZOXl2amlqcTltcFJkeEpQdjA0T091V1ZNWlc2UEVuc3lFby8zUDJsVmgz?=
 =?utf-8?B?Q3NrVDhYQXBIM0g5Qk05bWdwVDRzbjNOZ0pjM3VrOXJKdkNPQkkxbzYzRkE3?=
 =?utf-8?B?UEdKR2V5c1UyQVR0dzZMM08zeGRKNXFKSE1wZm9ndjI4MnEvL1hoeklUbURh?=
 =?utf-8?B?NGtFczNBUldkTnlUN2NDMnVjQS9OOGZEa3RKYm9aVHVxQTRoY3duaitvSmFK?=
 =?utf-8?B?Vzd3WXJ2WTVRcGRtRzJOSnplTFhYVG9XcnM3WmhxWm12eG5hOXF3QmxVNFJR?=
 =?utf-8?B?Unl2M21veVgxRUZmQ0UwS3JhOERRNVhMR2VQZHJodjhiUnFnNXoybkY0QnYr?=
 =?utf-8?B?YzNzMmYvTHdaSTNZdFRvU3JuZG1LQ2VsdGVaRDkwZzZ0a3ZNczEwN20zWFB5?=
 =?utf-8?B?WDM4SGFyV1FRdXF6SlRaV3ZxSjhFOWRQWDBZUkU0Zk1tZkl2MzRyamlKMmor?=
 =?utf-8?B?bEE1SGhLdVdlVDRSZm5wTndIZllaVGtJb2l1TkVicDJ5MDBxZmJyaFdFQWJL?=
 =?utf-8?B?anVEU25CTEFVd29TYVZiS2cyaksyeWp1WERaVkxSbStTcjUwVUduQW1adm5m?=
 =?utf-8?B?OWxBR3ZTdHNJU08yZ3pWd0JqTnNRZlZvK1lHbFUwR2V0UU8wdDVqbFg2ZTdW?=
 =?utf-8?B?bmdtL2kzK2hjRWtOYmVBTnF0eDBGMzlJazhUUjJNZ3RtSWlqbnlGQS9Ed1Yv?=
 =?utf-8?B?WllyU25sb2pnU1JiZitsd1Q5V0d0L3hIVGk1SXZwbUd2WmFZVVlucUNOYXk1?=
 =?utf-8?B?TUM1RmlLWUNnWWlHZTJnVWc2cU5laU1uUFJwSTllV3VRN3k1cmRKRnNONjVZ?=
 =?utf-8?B?NWsvL01IMklVa2RyNDB3OEZqWGlVYmNHaThiL1l4RnU4N3JRYWlhOHFNNjZv?=
 =?utf-8?B?d1Y4SGY3M2NicGNKNUtPQjNFOUhOTU03bVZLRUdRbklqQWNLZ1lJMk01aTA3?=
 =?utf-8?B?UXNWakY2VTNnS2l4Qis5ek5RQnFsT3F6WitPMGtiZVF3TFFCUzYrcVRGYTFh?=
 =?utf-8?B?Ulk4bTBiTm1YeFppcnNVaW5sb3g3dWJzb1pVanV3YktTMy9BYklWWEpLSUdV?=
 =?utf-8?B?SzZWRXhlYmJtVGNwTmVpdTZJc1FYdlh0T2dvUnlUc3AvWlIwWFVjQmFRQ1Vj?=
 =?utf-8?B?cWFXZWJZRlZuVE5XRlE2T201S1R0UXB2a1pOcDRlemdxTnlxR2ZvSUtPR25l?=
 =?utf-8?B?aUVaaDV1Um9wUGQyTTBRd3lZaFhVN1Vta0huY2svZXFiSHR1SklUSEk5U3lJ?=
 =?utf-8?B?d0lSdU81cHgwR1ZqM21heW8zbWZ4UTlQSEJSR0ZRVEFKMGxVc0Iwbi9JbVVu?=
 =?utf-8?B?YjJWMTlZNEpTL0txemo1RWUxQXFYbWQzSll1YUV0bE1RRjZPZVNTUy9sY1R4?=
 =?utf-8?Q?o7wGj2YFqDYyv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sjdybzgyb1lYNG5LbWwzWFZqT0s1b3dsTGFVNmVGNFpjTVlsTWRITlpXZmJk?=
 =?utf-8?B?QWpRVWhXMlNjRlNiVVVBOTVOQytiMmNmU216bU5RdlNnQ3krNW5xTnRPODVK?=
 =?utf-8?B?dzAvY2xVeWZaMGZlcUpmT2dRMFcwdlptdjF4cFpYYTBrSWliVCt1Y3VWRXRx?=
 =?utf-8?B?RFVSY2xwbUt2KzYyNFROV2FVSXIwb2JZb2dsbXZRV2dOdnlGbFE0eWh1KzZD?=
 =?utf-8?B?ZjNWQkM0V25oaDlCb3FNaC9JL0pYVzNzYWFEYnAwRTRwc0Q3dnA4bXQzVjVD?=
 =?utf-8?B?NjRyZUJtWU9pSWFUZVdhRUs5QWlrN0UrRDhoRFRRVms3emIxS1FRNUZyYzZ3?=
 =?utf-8?B?SnF2endLTWlFdFAzczJJNGR1WS9HYjliblRldnljWDFSaHFpZlAwVzFWL2l6?=
 =?utf-8?B?VTN1aTJhWW1wQWpkbkJiSGhWQURXVEY2UHI2amVQVHAvY01pK3d6b05vTzBl?=
 =?utf-8?B?L0FrcHl4dkYzODVqa25zQ2s5L3BXKzFDd0srQkpldEZBRlFnQ3ExK2VHcWc3?=
 =?utf-8?B?dVdwaStXZmpNdUN5UWJTRGlVMXAvU2RzakdEMnI4ejU1QUk5Q1dONGpTU05C?=
 =?utf-8?B?MFp1UHZ4NEQyc0pma3ltZ2FFOEdHTEJpakloMkpQVkxXNUtLUEJ6K1ZFcUQx?=
 =?utf-8?B?SGRxYjJweXpia1NiTW9rSjE3T0lyMk83NExza09tYzNRUWE4UENxU3A3WVBH?=
 =?utf-8?B?MjRTL01VQ3RvM0Q5Z1dYYlNKY1NjZS8zNHhmbzJkaG8wZWh5U0Jnb1VBSTdh?=
 =?utf-8?B?ajRrSkl1NmVHUkRKSWFXQTJzNDExZkloTG9WN2dZY2NCdmxKQTVGcDBNbldV?=
 =?utf-8?B?eWZoWXpveFVlcHViSzEwQWJYenRxK3ZKQStpamxjUlB5M3VYN3crcWdreEo4?=
 =?utf-8?B?QnVabUxVMVRaQWtlZjN5UXFCUzVVU080WjhtQW9pZkxCRlp4MWFFTVhGK1lu?=
 =?utf-8?B?b1hVWG81cVFtQkRUUjVNRGxWRGZuWmxhN0NIZFZieTU4MUVFMHZWaDlrd2cw?=
 =?utf-8?B?VTRmbXpoVFRRTjRXbERnRkV1blFIbmErMkJTWGhTT3Jjc0R2Z0Z0WDB1N1pH?=
 =?utf-8?B?b2RGQkNtTkcyR29qYzAxNU9udWNvcWc2L2FiVUtVQlREb3lLalFSbUtHbHBK?=
 =?utf-8?B?UllEa3JNVmg3SThsZ29OeVlEd0kyM3dvcjRMaXFPZ3loODMxdCtNa0NrVWY4?=
 =?utf-8?B?Y01RNTMzNWdoa1cvZFRZaElGWVNUWU1lVkJhY1N4RnhHRlZOS1RzMWt6NDha?=
 =?utf-8?B?TDk3aEJhWXRBUkNNeGluMDhtUEZFUDNpOHlGZzY0VFdPNnFGNkwwaFB4SDNO?=
 =?utf-8?B?elVvWkViaVpSTGRxcWt6Nno4WmVjM3NnQnhqZ1J2YTk2cVUyL2tjWVJLUHlh?=
 =?utf-8?B?Tk1PMzBHNmJJR1c5NVZDMnduSFhkaWFwc2U1d0dLcURBWHRjUWNSWkFTQWpr?=
 =?utf-8?B?MEE2MG1ZN1BHN3VhcGNHU0wyajQzNHUxaHVSZ0MwbGl3QkU4MWl4cW5aS3Zw?=
 =?utf-8?B?akRzclhnS2Q4U3hkOUgzeVBLTTQra3dnRlp5RTk5WWpIYS8ra1ZsRnhrV1VG?=
 =?utf-8?B?NHE5VWpkeGZWZmozT1FMdVJDVjNaMVBTbjVMSmVoOFRvS0JZVFIrUFRRazZm?=
 =?utf-8?B?ak1VYVZ4OWpmZEFQa0J2SUFWaVlBK2tMOGtPUWY4VDRvWTRjMEJWRHRXWmpO?=
 =?utf-8?B?cms1MysyL0xnTXhjVzRrRnBDZFNqdC9XQ3c4NmN1Z252L004ajM0OHN0Rk1a?=
 =?utf-8?B?Nk55NEw5Tmt1R1VST211RndoNXZjMDVyNlFrbmNaQ1ZNbEdPcTlVeXR6Tkpi?=
 =?utf-8?B?eWxWcHFrTzJhd1JyK2dGemVvb3YrQlpkSGR3SHdIQzBRVnZTbXE5NThrSC9N?=
 =?utf-8?B?dU15Zkk5eUUyZUdHcUdJTEJtbjZnWmc2cEFCemxTYUFpL2ZEK0xnREM1R2ho?=
 =?utf-8?B?WmEvS1RITXBmRlJrVTczTGxtMmRHT09aRU95SThzTGRkSERFL1Rud3hKQ2t5?=
 =?utf-8?B?bjdVSmVpL243cWpRWWdCRStiYmQ0eGNDcTBMNEhlc29TZTc0SEtKVzlxVmRa?=
 =?utf-8?B?VW9iR2JvV29rd1lFZ1R3QmxaTWFleUtXVWhacHBBN2lKL0h2d0NncjZBc3F2?=
 =?utf-8?Q?NpjGnysfB0ukvAKOsYaC5/FgB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8246ad3d-e351-47b3-45e8-08dd1b262d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 03:28:13.9664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKwZVk72riLYdamiQbUlHidcRprUMHmQnQqGnDDLGEXb1TZ/nUz32gvg7AKm+HUZUr69+Q4WpNYxLLBzTjwzYk2KTj27M25ya0iYxHcYMZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBOYXp6YXJl
bm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPiBTZW50OiBGcmlk
YXksIDEzIERlY2VtYmVyIDIwMjQgMjozOCBhbQ0KPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5l
c2gubWFuaXlhbUBpbnRlbC5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsg
PG1hcmV4QGRlbnguZGU+OyBTaW1vbg0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNv
bT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbw0KPiBCaW5hY2NoaSA8ZGFy
aW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBKb2hhbiBKb25rZXINCj4gPGpieDYy
NDRAZ21haWwuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEFyc2Vu
aXkNCj4gS3Jhc25vdiA8YXZrcmFzbm92QHNhbHV0ZWRldmljZXMuY29tPjsgQWxleGFuZGVyIERh
aGwgPGFkYUB0aG9yc2lzLmNvbT47DQo+IFdpbGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJv
YWRjb20uY29tPjsgSWdvciBQcnVzb3YNCj4gPGl2cHJ1c292QHNhbHV0ZWRldmljZXMuY29tPjsg
TWVuZywgVGluZ3RpbmcgPHRpbmd0aW5nLm1lbmdAaW50ZWwuY29tPjsNCj4gQ2hlZSwgVGllbiBG
b25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA8a29rLmtp
YW5nLmhlYUBpbnRlbC5jb20+OyBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29t
PjsgWXVzbGFpbWksDQo+IEFsaWYgWmFrdWFuIDxhbGlmLnpha3Vhbi55dXNsYWltaUBpbnRlbC5j
b20+OyBaYW1yaSwgTXVoYW1tYWQgSGF6aW0gSXp6YXQNCj4gPG11aGFtbWFkLmhhemltLml6emF0
LnphbXJpQGludGVsLmNvbT47IExpbSwgSml0IExvb24NCj4gPGppdC5sb29uLmxpbUBpbnRlbC5j
b20+OyBUYW5nLCBTaWV1IE11biA8c2lldS5tdW4udGFuZ0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbcmVzZW5kIHYyIDE1LzE5XSBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGJhc2U6IEFkZCBzdXBw
b3J0IGZvcg0KPiBIYXJkd2FyZSBFQ0MgZm9yIGNoZWNrIGJhZCBibG9jaw0KPiANCj4gSGkNCj4g
DQo+IE9uIFRodSwgRGVjIDUsIDIwMjQgYXQgMTA6MjTigK9BTSA8ZGluZXNoLm1hbml5YW1AaW50
ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFu
aXlhbUBpbnRlbC5jb20+DQo+ID4NCj4gPiBMZXZlcmFnZSBsaW51eCBjb2RlIHRvIHN1cHBvcnQg
aGFyZHdhcmUgRUNDIGludGVyZmFjZSB0byB2ZXJpZnkgbmFuZA0KPiA+IGJhZCBibG9jay4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRl
bC5jb20+DQo+ID4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAtIHJlbW92ZSB0aGUgInRoaXMgcGF0
Y2ggaXMgdG8iIGNvbW1pdCBwaHJhc2VzDQo+ID4gLS0tDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
bXRkL25hbmQvcmF3L25hbmRfYmFzZS5jIHwgNzEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9tdGQvcmF3bmFuZC5oICAgICAgfCAxMyArKysrKysN
Cj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jhc2UuYw0K
PiA+IGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMNCj4gPiBpbmRleCA0NDAxYmRj
ZGI5Li45YjFiMmQxZjg1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L25h
bmRfYmFzZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMNCj4g
PiBAQCAtOSw2ICs5LDggQEANCj4gPiAgICogIENvcHlyaWdodCAoQykgMjAwMCBTdGV2ZW4gSi4g
SGlsbCAoc2poaWxsQHJlYWxpdHlkaWx1dGVkLmNvbSkNCj4gPiAgICogICAgICAgICAgICAgICAy
MDAyLTIwMDYgVGhvbWFzIEdsZWl4bmVyICh0Z2x4QGxpbnV0cm9uaXguZGUpDQo+ID4gICAqDQo+
ID4gKyAqICBDb3B5cmlnaHQgKEMpIDIwMjQgSW50ZWwgQ29ycG9yYXRpb24gPHd3dy5pbnRlbC5j
b20+DQo+ID4gKyAqDQo+IA0KPiBEcm9wIGl0LiBJIGRvbid0IHRoaW5rIHRoYXQgYmVjYXVzZSB5
b3UgYWRkIGEgZnVuY3Rpb24gaGVyZSwgeW91IGNhbiBhZGQgYW55DQo+IGNvcHlyaWdodA0KDQpO
b3RlZCwgd2lsbCBkcm9wIHRoaXMuDQo+IA0KPiA+ICAgKiAgQ3JlZGl0czoNCj4gPiAgICogICAg
IERhdmlkIFdvb2Rob3VzZSBmb3IgYWRkaW5nIG11bHRpY2hpcCBzdXBwb3J0DQo+ID4gICAqDQo+
ID4gQEAgLTMwNiw2ICszMDgsMzUgQEAgdm9pZCBuYW5kX3JlYWRfYnVmMTYoc3RydWN0IG10ZF9p
bmZvICptdGQsIHVpbnQ4X3QNCj4gKmJ1ZiwgaW50IGxlbikNCj4gPiAgICAgICAgIGlvcmVhZDE2
X3JlcChjaGlwLT5JT19BRERSX1IsIHAsIGxlbiA+PiAxKTsgIH0NCj4gPg0KPiA+ICsvKg0KPiA+
ICsgKiBuYW5kX2JibV9nZXRfbmV4dF9wYWdlIC0gR2V0IHRoZSBuZXh0IHBhZ2UgZm9yIGJhZCBi
bG9jayBtYXJrZXJzDQo+ID4gKyAqIEBjaGlwOiBUaGUgTkFORCBjaGlwDQo+ID4gKyAqIEBwYWdl
OiBGaXJzdCBwYWdlIHRvIHN0YXJ0IGNoZWNraW5nIGZvciBiYWQgYmxvY2sgbWFya2VyIHVzYWdl
DQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybnMgYW4gaW50ZWdlciB0aGF0IGNvcnJlc3BvbmRzIHRv
IHRoZSBwYWdlIG9mZnNldCB3aXRoaW4gYQ0KPiA+ICtibG9jaywgZm9yDQo+ID4gKyAqIGEgcGFn
ZSB0aGF0IGlzIHVzZWQgdG8gc3RvcmUgYmFkIGJsb2NrIG1hcmtlcnMuIElmIG5vIG1vcmUgcGFn
ZXMNCj4gPiArYXJlDQo+ID4gKyAqIGF2YWlsYWJsZSwgLUVJTlZBTCBpcyByZXR1cm5lZC4NCj4g
PiArICovDQo+ID4gK2ludCBuYW5kX2JibV9nZXRfbmV4dF9wYWdlKHN0cnVjdCBuYW5kX2NoaXAg
KmNoaXAsIGludCBwYWdlKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbXRkX2luZm8gKm10ZCA9IG5h
bmRfdG9fbXRkKGNoaXApOw0KPiA+ICsgICAgICAgaW50IGxhc3RfcGFnZSA9ICgobXRkLT5lcmFz
ZXNpemUgLSBtdGQtPndyaXRlc2l6ZSkgPj4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
Y2hpcC0+cGFnZV9zaGlmdCkgJiBjaGlwLT5wYWdlbWFzazsNCj4gPiArICAgICAgIHVuc2lnbmVk
IGludCBiYm1fZmxhZ3MgPSBOQU5EX0JCTV9GSVJTVFBBR0UgfA0KPiBOQU5EX0JCTV9TRUNPTkRQ
QUdFDQo+ID4gKyAgICAgICAgICAgICAgIHwgTkFORF9CQk1fTEFTVFBBR0U7DQo+ID4gKw0KPiA+
ICsgICAgICAgaWYgKHBhZ2UgPT0gMCAmJiAhKGNoaXAtPm9wdGlvbnMgJiBiYm1fZmxhZ3MpKQ0K
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiArICAgICAgIGlmIChwYWdlID09IDAg
JiYgY2hpcC0+b3B0aW9ucyAmIE5BTkRfQkJNX0ZJUlNUUEFHRSkNCj4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+ID4gKyAgICAgICBpZiAocGFnZSA8PSAxICYmIGNoaXAtPm9wdGlvbnMg
JiBOQU5EX0JCTV9TRUNPTkRQQUdFKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4g
PiArICAgICAgIGlmIChwYWdlIDw9IGxhc3RfcGFnZSAmJiBjaGlwLT5vcHRpb25zICYgTkFORF9C
Qk1fTEFTVFBBR0UpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBsYXN0X3BhZ2U7DQo+ID4g
Kw0KPiA+ICsgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qKg0K
PiA+ICAgKiBuYW5kX2Jsb2NrX2JhZCAtIFtERUZBVUxUXSBSZWFkIGJhZCBibG9jayBtYXJrZXIg
ZnJvbSB0aGUgY2hpcA0KPiA+ICAgKiBAbXRkOiBNVEQgZGV2aWNlIHN0cnVjdHVyZQ0KPiA+IEBA
IC0zMTUsNDAgKzM0NiwzMiBAQCB2b2lkIG5hbmRfcmVhZF9idWYxNihzdHJ1Y3QgbXRkX2luZm8g
Km10ZCwgdWludDhfdA0KPiAqYnVmLCBpbnQgbGVuKQ0KPiA+ICAgKi8NCj4gPiAgc3RhdGljIGlu
dCBuYW5kX2Jsb2NrX2JhZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgbG9mZl90IG9mcykgIHsNCj4g
PiAtICAgICAgIGludCBwYWdlLCByZXMgPSAwLCBpID0gMDsNCj4gPiAgICAgICAgIHN0cnVjdCBu
YW5kX2NoaXAgKmNoaXAgPSBtdGRfdG9fbmFuZChtdGQpOw0KPiA+IC0gICAgICAgdTE2IGJhZDsN
Cj4gPiArICAgICAgIGludCBmaXJzdF9wYWdlLCBwYWdlX29mZnNldDsNCj4gPiArICAgICAgIGlu
dCByZXM7DQo+ID4gKyAgICAgICB1OCBiYWQ7DQo+ID4NCj4gPiAtICAgICAgIGlmIChjaGlwLT5i
YnRfb3B0aW9ucyAmIE5BTkRfQkJUX1NDQU5MQVNUUEFHRSkNCj4gPiAtICAgICAgICAgICAgICAg
b2ZzICs9IG10ZC0+ZXJhc2VzaXplIC0gbXRkLT53cml0ZXNpemU7DQo+ID4gKyAgICAgICBmaXJz
dF9wYWdlID0gKGludCkob2ZzID4+IGNoaXAtPnBhZ2Vfc2hpZnQpICYgY2hpcC0+cGFnZW1hc2s7
DQo+ID4gKyAgICAgICBwYWdlX29mZnNldCA9IG5hbmRfYmJtX2dldF9uZXh0X3BhZ2UoY2hpcCwg
MCk7DQo+ID4NCj4gPiAtICAgICAgIHBhZ2UgPSAoaW50KShvZnMgPj4gY2hpcC0+cGFnZV9zaGlm
dCkgJiBjaGlwLT5wYWdlbWFzazsNCj4gPiArICAgICAgIHdoaWxlIChwYWdlX29mZnNldCA+PSAw
KSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJlcyA9IGNoaXAtPmVjYy5yZWFkX29vYihtdGQsIGNo
aXAsIGZpcnN0X3BhZ2UgKyBwYWdlX29mZnNldCk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChy
ZXMgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXM7DQo+ID4NCj4g
PiAtICAgICAgIGRvIHsNCj4gPiAtICAgICAgICAgICAgICAgaWYgKGNoaXAtPm9wdGlvbnMgJiBO
QU5EX0JVU1dJRFRIXzE2KSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgY2hpcC0+Y21k
ZnVuYyhtdGQsIE5BTkRfQ01EX1JFQURPT0IsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNoaXAtPmJhZGJsb2NrcG9zICYgMHhGRSwgcGFnZSk7DQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgYmFkID0gY3B1X3RvX2xlMTYoY2hpcC0+cmVhZF93b3JkKG10
ZCkpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmIChjaGlwLT5iYWRibG9ja3BvcyAm
IDB4MSkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJhZCA+Pj0gODsNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBiYWQgJj0gMHhGRjsNCj4gPiAtICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBjaGlwLT5jbWRmdW5jKG10ZCwgTkFORF9DTURfUkVB
RE9PQiwgY2hpcC0+YmFkYmxvY2twb3MsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBhZ2UpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGJhZCA9IGNo
aXAtPnJlYWRfYnl0ZShtdGQpOw0KPiA+IC0gICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAg
ICAgICAgIGJhZCA9IGNoaXAtPm9vYl9wb2lbY2hpcC0+YmFkYmxvY2twb3NdOw0KPiA+DQo+ID4g
ICAgICAgICAgICAgICAgIGlmIChsaWtlbHkoY2hpcC0+YmFkYmxvY2tiaXRzID09IDgpKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlcyA9IGJhZCAhPSAweEZGOw0KPiA+ICAgICAgICAg
ICAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVzID0gaHdlaWdodDgo
YmFkKSA8IGNoaXAtPmJhZGJsb2NrYml0czsNCj4gPiAtICAgICAgICAgICAgICAgb2ZzICs9IG10
ZC0+d3JpdGVzaXplOw0KPiA+IC0gICAgICAgICAgICAgICBwYWdlID0gKGludCkob2ZzID4+IGNo
aXAtPnBhZ2Vfc2hpZnQpICYgY2hpcC0+cGFnZW1hc2s7DQo+ID4gLSAgICAgICAgICAgICAgIGkr
KzsNCj4gPiAtICAgICAgIH0gd2hpbGUgKCFyZXMgJiYgaSA8IDIgJiYgKGNoaXAtPmJidF9vcHRp
b25zICYNCj4gTkFORF9CQlRfU0NBTjJORFBBR0UpKTsNCj4gPiArICAgICAgICAgICAgICAgaWYg
KHJlcykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmVzOw0KPiA+DQo+ID4g
LSAgICAgICByZXR1cm4gcmVzOw0KPiA+ICsgICAgICAgICAgICAgICBwYWdlX29mZnNldCA9IG5h
bmRfYmJtX2dldF9uZXh0X3BhZ2UoY2hpcCwgcGFnZV9vZmZzZXQgKyAxKTsNCj4gPiArICAgICAg
IH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gIC8qKg0K
PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L210ZC9yYXduYW5kLmggYi9pbmNsdWRlL2xp
bnV4L210ZC9yYXduYW5kLmgNCj4gPiBpbmRleCAxNGY5M2RhYjBhLi4zNWViM2I1Njc4IDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL3Jhd25hbmQuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvbXRkL3Jhd25hbmQuaA0KPiA+IEBAIC00LDYgKzQsOCBAQA0KPiA+ICAgKiAgICAg
ICAgICAgICAgICAgICAgICAgIFN0ZXZlbiBKLiBIaWxsIDxzamhpbGxAcmVhbGl0eWRpbHV0ZWQu
Y29tPg0KPiA+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+DQo+ID4gICAqDQo+ID4gKyAqICBDb3B5cmlnaHQgKEMpIDIwMjQgSW50
ZWwgQ29ycG9yYXRpb24gPHd3dy5pbnRlbC5jb20+DQo+ID4gKyAqDQo+IA0KPiBEcm9wIGhlcmUN
Cg0KTm90ZWQsIHdpbGwgZHJvcCB0aGUgY29weXJpZ2h0Lg0KPiANCj4gPiAgICogSW5mbzoNCj4g
PiAgICogICAgIENvbnRhaW5zIHN0YW5kYXJkIGRlZmluZXMgYW5kIElEcyBmb3IgTkFORCBmbGFz
aCBkZXZpY2VzDQo+ID4gICAqDQo+ID4gQEAgLTEzMSw2ICsxMzMsMTcgQEAgdm9pZCBuYW5kX3dh
aXRfcmVhZHkoc3RydWN0IG10ZF9pbmZvICptdGQpOw0KPiA+DQo+ID4gICNkZWZpbmUgTkFORF9E
QVRBX0lGQUNFX0NIRUNLX09OTFkgICAgIC0xDQo+ID4NCj4gPiArLyoNCj4gPiArICogVGhlcmUg
YXJlIGRpZmZlcmVudCBwbGFjZXMgd2hlcmUgdGhlIG1hbnVmYWN0dXJlciBzdG9yZXMgdGhlDQo+
ID4gK2ZhY3RvcnkgYmFkDQo+ID4gKyAqIGJsb2NrIG1hcmtlcnMuDQo+ID4gKyAqDQo+ID4gKyAq
IFBvc2l0aW9uIHdpdGhpbiB0aGUgYmxvY2s6IEVhY2ggb2YgdGhlc2UgcGFnZXMgbmVlZHMgdG8g
YmUgY2hlY2tlZA0KPiA+ICtmb3IgYQ0KPiA+ICsgKiBiYWQgYmxvY2sgbWFya2luZyBwYXR0ZXJu
Lg0KPiA+ICsgKi8NCj4gPiArI2RlZmluZSBOQU5EX0JCTV9GSVJTVFBBR0UgICAgIEJJVCgyNCkN
Cj4gPiArI2RlZmluZSBOQU5EX0JCTV9TRUNPTkRQQUdFICAgIEJJVCgyNSkNCj4gPiArI2RlZmlu
ZSBOQU5EX0JCTV9MQVNUUEFHRSAgICAgIEJJVCgyNikNCj4gPiArDQo+ID4gIC8qDQo+ID4gICAq
IENvbnN0YW50cyBmb3IgRUNDX01PREVTDQo+ID4gICAqLw0KPiA+IC0tDQo+ID4gMi4xOS4wDQo+
ID4NCj4gUmV2aWV3ZWQtYnk6IE1pY2hhZWwgVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1
dGlvbnMuY29tPg0KPiANCj4gLS0NCj4gTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpDQo+IENv
LUZvdW5kZXIgJiBDaGllZiBFeGVjdXRpdmUgT2ZmaWNlcg0KPiBNLiArMzkgMzQ3IDkxMyAyMTcw
DQo+IG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiANCj4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4gSm9vcCBHZWVzaW5r
d2VnIDEyNSwgMTExNCBBQiwgQW1zdGVyZGFtLCBOTCBULiArMzEgKDApODUgMTExIDkxNzINCj4g
aW5mb0BhbWFydWxhc29sdXRpb25zLmNvbSB3d3cuYW1hcnVsYXNvbHV0aW9ucy5jb20NCg0KVGhh
bmtzIGZvciByZXZpZXdpbmcgbXkgcGF0Y2guDQo=
