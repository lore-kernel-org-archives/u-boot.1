Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6748ACFB424
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 02:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2EA88835;
	Mon,  7 Oct 2024 04:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D2cGU4P6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3640C88CA8; Mon,  7 Oct 2024 04:27:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D61886B1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 04:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728268050; x=1759804050;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uTPYT4YKJ0BVw/AFwvkz6mfEj22ErtTA57xAGwJi7B0=;
 b=D2cGU4P6iMevEKUT1sF0WAR3+POyZgm6cQzhnecB9SwQi5hEVObAOMW+
 ZpFXJBNVl0t/jn4Tx5iKVyqBDqdOCSCPDzwHZGxHtyW+6G+Il9/2MnkuI
 oMBorigBinLVN/fedNqWwOrX1EVfRSVmMsfFNBYLht6A8CiUvT60h/IWg
 iQsrTeMQIEPabNSP0kA5MBc8InsIiEI54HcXkTbQBh6d3Z6wsBPJ6p/XA
 AhzkYytvk2ECKublaQUBgM6aGmGWnc+ckgsG+kdy0ugaZxSa+0VtDE+/w
 95l7Eekuuy74S6CSjV62yyiWWNFJqDV87/MEBLMKGltdME38lSt/sG1Ii Q==;
X-CSE-ConnectionGUID: Y6xByCwkQ6G2bsKYAWpI/A==
X-CSE-MsgGUID: 41Ubp+l+TMK6IjU5xVclQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="30287240"
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; d="scan'208";a="30287240"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2024 19:27:29 -0700
X-CSE-ConnectionGUID: j8GtipPgRESBLfvmMDlcVw==
X-CSE-MsgGUID: hUS/P3eQQb68Qo9Q/XvYvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; d="scan'208";a="75300845"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Oct 2024 19:27:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Oct 2024 19:27:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Oct 2024 19:27:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 6 Oct 2024 19:27:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 6 Oct 2024 19:27:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaYNQEXLJh4W+OF9ciB1UNqMAdjQLaPG+ZL+yw5fHLTrqqIfO2fLcJUlg4jUAXHWTeVOjOJVeIOYTW9rQfXjseYw67jaC6jCOHnVuMUe9dR28KPtRbMI4E1Q94Lhe32uMwM38U5J2aZXPR5K5IUkuIyo8wTO9jKqgztQ9K1EAg4RC8hDcQTdvluFtVAV241rxP6nlFVlPNAXnOCk2kEW27Cz7Fc4Euc4WIEgN5ktO2/2OFbaUjxStewP6GM6Nlh/ILjQ0RiH8jTPajJxrgLCHO2VU7qyPZF8UXBcwEgXc545Fofh57q0vD7juE29RwbIjgj5+Stdy+9ySflGYwb7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTPYT4YKJ0BVw/AFwvkz6mfEj22ErtTA57xAGwJi7B0=;
 b=V3cPeauBUzCSxyLAhsV9+/uVmKoII2I0feFrhZlfa9hCLLkA6rSne1QHHggaAafduD+kyc+wsAYcxbM9jvgkoEibwk19ICDyT30J3ZpA3UU4zTpJ0R3sZtLOBq+LK4LGm3rLx1plQvp4HHuIBzpdO/flFKIlBXkKWP/PcpVRYswbD5VjZ2k/5tYvNUHwlqypfsJuxkynI8wAK98KNjBlUa7v91XlKKBfq8NkrDSBs8+H7puAa3Uhj5f6C8nQssp/C+oHUN+pK9n/mymPr5w6akq0w0r7jrJixCcjYYJUAVOopZu2JncvYJOone6/lAvMeXK4CF+I4pEta4ZYi5/DdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by PH7PR11MB8275.namprd11.prod.outlook.com (2603:10b6:510:1ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 02:27:24 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 02:27:24 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>,
 "Dario Binacchi" <dario.binacchi@amarulasolutions.com>, Johan Jonker
 <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>, Arseniy Krasnov
 <avkrasnov@salutedevices.com>, Alexander Dahl <ada@thorsis.com>, "William
 Zhang" <william.zhang@broadcom.com>, Igor Prusov
 <ivprusov@salutedevices.com>, "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Ng, Boon Khai"
 <boon.khai.ng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Lim, Jit Loon" <jit.loon.lim@intel.com>, "Tang,
 Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH 16/19] drivers: mtd: nand: spl: Add support for nand SPL
 load image
Thread-Topic: [PATCH 16/19] drivers: mtd: nand: spl: Add support for nand SPL
 load image
Thread-Index: AQHbCkf6GJDaYnKGtkKvSTDUbvpDX7J4YE4AgAJK8iA=
Date: Mon, 7 Oct 2024 02:27:24 +0000
Message-ID: <BL1PR11MB53667F57F3C1DF38A4518CA2827D2@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
 <20240919035512.13854-17-dinesh.maniyam@intel.com>
 <CAOf5uwk+CHPbGvLH=pjqbh1qiKg-xXMXFCP7iS9hXcHf9xDFmQ@mail.gmail.com>
In-Reply-To: <CAOf5uwk+CHPbGvLH=pjqbh1qiKg-xXMXFCP7iS9hXcHf9xDFmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|PH7PR11MB8275:EE_
x-ms-office365-filtering-correlation-id: cd96be35-4f31-421b-4f41-08dce6779487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RExIUmZibys2c2k0OFRMZ1hyNGtjYjFYa1N6b2VvRmE0YnFXWXBFTGo5RWkv?=
 =?utf-8?B?dExZMyt1eVhrT3BNdkxHY0pLcGlyWDFlT2JnSnM1YW9UV3o1WTZJallVRzZ5?=
 =?utf-8?B?TWFkYk5GS3BtVkxYTW9ST0krUDdBM3R4QWpCQXNIZEdUWFludTNQT2NIME1p?=
 =?utf-8?B?VENOUTZ5R0RaKysraFBOUWxkYjJ1NWd1UDNHOWQ5aVRXcG5nWkJCK1ljNWdy?=
 =?utf-8?B?ODI2d0dWeXFyZ2NSWjQ0T3k0Ri9rajBHU0RrWGl4UmJ6MDRVNFd6Y1ZMV2pq?=
 =?utf-8?B?elNJd0xucVg4b3E2dnFIZmp5M3M2cmp5WGZkMWo3S1Fhd1BZOHNaWmdEZmhj?=
 =?utf-8?B?T2xIWHhQbVVYK204clNFY05SaWRHZy9DUlJEeTBwN292VjFGS1ZWejVTN2pw?=
 =?utf-8?B?YXp5dUdvbUVhbUpTRTEycis1dmwrL3hITDZKRlpjVkJEbkxXcWdldlVkQ3lq?=
 =?utf-8?B?NkRwVFRXbU56NFV6MENkb2J5cWswb3Bvd2IyUlNzWlE3QUhtVTl2dGNYSHN4?=
 =?utf-8?B?U2QvbGFjL1p1YXJ6MW9raGFid2NrYmd2cEt6TnRWQS9YYndxU2wzMURvTUZW?=
 =?utf-8?B?NHppcnp4azVYMHltTWNpaTVZZldZNkdEb3FlcHFSQ011VzQ4bFBydlViRjQr?=
 =?utf-8?B?cUtFL09mTFZkNnAvMFNVZGliaFVGY084VDRJWnVjOE9SNFVaWXJ0RWVXcHVv?=
 =?utf-8?B?UFd1VWdMcHBQeUh1NXRNbHdzenVNZ2lpMGpleE1vRWF3WTVaaVVieEJhUzR3?=
 =?utf-8?B?TlFyakdUeStVRUd0UWlKMjU2NEtjajFlYWdhSlZnTWw5cElVWnAzamhCUURt?=
 =?utf-8?B?SFFvTTJwemNsT09YUGZoL3RrNk9kVm1wcEM5RjlGQVpTdVBDcVgzODRpYmpp?=
 =?utf-8?B?UXNESWRXMmQvTlR3NFU4SDlDbXcwcFRnMmxrdURBTndkL2tqd3F6bk9sK3Zt?=
 =?utf-8?B?V25NYU5PanByeklJQ1BPZzY3OUJRQmtwaGVkN3JVNitHQ0gzQUo0MVVpWUUx?=
 =?utf-8?B?b0NIMDJHZkgxaWxOTEdWaEFob2o2SDFpRWFJNE56SVE0dWpGNHYwaFRLeHhL?=
 =?utf-8?B?Z2k0Y2c4R292ZkJ3aGdtOWl1dFNzUHlkLy9mSGE4MU51aGpZSitRbHY5OWZa?=
 =?utf-8?B?S2sxUUNNRVdOQmN6NENaUmNzT1NNZW1BMEgzTHdjRm1CeG1Zd29SdFhsK3hR?=
 =?utf-8?B?MVRpRGlCcm13S0dQakYyRlFCcXNxdUZ1K2xCTGx1K2FZRUg2T3pXQ3lZS3Q5?=
 =?utf-8?B?VlhISUxVWGt2R28xQzNxTEkxMnNHVXYwRUt4TTBwc29QQ29hdmI4WjVhait6?=
 =?utf-8?B?Q3ZBeGMrVld6SmpQUjN2cm95b01PZFk2TFZMR3d0cnpnaTAxR00wRm9xRWJJ?=
 =?utf-8?B?R0ZmWTVjRGR2bFJQOFJkSFpnRFlEallsV00yY2lEMm1zMTBFSUVpaTAwdHlW?=
 =?utf-8?B?dDc3UmlNS0xoUkpFKzBQNUFndElSV1VxTm1pSkIrNjlxa3RLekRjbnM2MjRZ?=
 =?utf-8?B?dDVFNDlpWjZlSk93TTY4Y2cwM1hFeHJMdWp3YUFLYzloQ2k1czBYMHdlMzhL?=
 =?utf-8?B?aFFKaWhQeG9BVktuWU1KWXVyZFdmZmJBZVdoN3pXNDZXcnlMVkZsN0dwd2l3?=
 =?utf-8?B?WTc5NGsvY2ZVamdZeTZrVW5nRTNkZndrNElrVWZubWVwQnBkY2NxWHF6MWIy?=
 =?utf-8?B?SllUNmxPeXIzZ2xFelVUN0NkcERNY0hZOC9FV0g3WEgyWDkycGptY3FnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0YwVHZmSlpKeFlvZzhMV2ZaS3dJd09wYkE1c2VWYWZKeTJ2RVJCUDZOaHdw?=
 =?utf-8?B?bGFOc1BUTFR1UncwbHgwbENocy9tODhCMEZqK25YQi9VUzlISVIrQUIyRmZQ?=
 =?utf-8?B?ODdNbUJJWXBLVnFtaWc4b2RyNHdsWVA0cFprclVOQ2hwcnNFRjZsQVdrVHhm?=
 =?utf-8?B?b1hkcVlnY2xjOURUdTQ1ZHZvOTllaUF4RjY4cGh6cWZnZEhndEJEKzBIbFN0?=
 =?utf-8?B?RnVvMkdIeFNBRk83Q3RJaThsUktBOHpwemVMeHZQUG5nK1RIS0hMYzVIZHdT?=
 =?utf-8?B?RWh1ZlJGaG5GeHRTWEMydUtzUXRzbjRZWk5uSVU4TWFVWExldUVwK2RwajBY?=
 =?utf-8?B?NVU2MXhlSisrL1cySEtMTXdpa2lBYlc3R1N3REZTQ0pyUk1xMXpjeWNPbFZL?=
 =?utf-8?B?b0krcHZrMms5SVRlQXNLb3pGdjVJZEl4a2NXR0hhbm9ZOUxXbnhXSnBMYUo3?=
 =?utf-8?B?NWhSYVVtTFdSdUpVU0NRbTUvbUNVSnl5Snc1SytSamdGb3UrdStxbml5dERm?=
 =?utf-8?B?ZnZDcGFqNFhPVURsVlgyNTRraFQ5ZDFIaERxL1lkVmRQNlBXeGcyWlN0TnlZ?=
 =?utf-8?B?cllRTGZqeDV0bS9hTXZnSTZUdGt5NWxpd1RCRnRMNXJFdWljK3dZMks5YnZZ?=
 =?utf-8?B?UXhYelhwMkhyWnNocUcwejB5N05TMWoraE5QcEw3SUFHMnJXVlp5RzgxZ0NT?=
 =?utf-8?B?eU01TlcwdGwwTFY2RC9zbFc3a2JaOEZCUEd2blBhb053Rk5wUWRidHI1UDJR?=
 =?utf-8?B?Wm00NDVrREZ5Z1BTK1ozOU5nendDUVREUVpKQnYrRzhiYmNVdzM1Z0FYY2FB?=
 =?utf-8?B?aGp2WjN6Zngza1JucTBUUml4aTZ4ajBiTzc2emFGRnB2VGs2TnFseEdnZk96?=
 =?utf-8?B?QlQ3aE8xRm9UaDNxdVB0OWVDTDQvUVQySDlWQVoxeS9RUDhGenZyN28ya01u?=
 =?utf-8?B?WStUQ201SU9FWStHZDdiL2ZqWDZrKzFMdThYeURublRGUnVGQ1FNTk81RWdB?=
 =?utf-8?B?S2ZobHhGRWk5V2JFcXVoN2c5MEJUSWljYVZDRlVJU3hmWldJLy9sV2F0bEVQ?=
 =?utf-8?B?Ly9xOWp1NER6b0JiS3UzNnl3R2JENlcvNjJnL3dsVklqeHZsc2ZEREhscUZq?=
 =?utf-8?B?NGdkZXN2TE9CMTZCdUM2UXk5UEpUYThvTm50ZXQwSS9maDRrS21MSkJUWndZ?=
 =?utf-8?B?a012SEQ1RkljQk83ZE14SkIyRi9aTGs2VDdONHJ0amREaVQvVWFsMkVWTkNj?=
 =?utf-8?B?TzZJRElFV0tBTlZuZ1hubjBodktyMCs3RHM2d1hpcHhqL0NReitGMkZXRG9N?=
 =?utf-8?B?Q1pERCt3ODNYVy90bEZpWXdrNUlmMW0wem05N0RHempuOUNUSSt2OWhmeU55?=
 =?utf-8?B?NHl0alNsYmtwclF2U01DMkxDYzZiSFk1NXZ5cktucU1TcXFrek5zMzEzMDVT?=
 =?utf-8?B?cTdWaHBoTXdkNG5GY3liM082TXRYT3FMZEtNUDVZVm1aRHJGSkU2Y0hSaURP?=
 =?utf-8?B?d05GY1pDYmdxSnhkbTdSSElaWmVuVFFQcFNrc2U5K1FwT3BrTVAwVks4Vk55?=
 =?utf-8?B?clJUZ04xMGxZdkY2Um16MnBBcVRDcEVsMUVMOEl2cWFSODNGMlpRZTVxTFk2?=
 =?utf-8?B?ajI4d21tUGlhd2tVa1ZtV1loT2wyNmFiWnJHK25nc29TK1M1dmJoK1RVTldy?=
 =?utf-8?B?bHhWZGRIcG9tOU0yTzhucFN4OEJjNE5VVVprbFVocmE2aHhaNU5FUCtzSmEv?=
 =?utf-8?B?dk14c0lGVnZ3YllyZXpIbkVHR05JWnJtYU1uK2JVVnllMC9lOW9xdlQ1K29z?=
 =?utf-8?B?OUtYRDAyd0VYTFU3ZU44MGV3UUpjRUFRMGdZUXIrYlRUOW9GVzRCZ21GaHNO?=
 =?utf-8?B?cTQyRDVxdWplSTlNTGtvS2FMMngyaXl5dzQzKy83Und5cllwbXU2cC9BbHhr?=
 =?utf-8?B?NzhPT2ZhQnZpK3BDZkNzdFAyWXJqVWRLWis1b3lkaWYxQ2pWRDl1ZXM0eSt3?=
 =?utf-8?B?ZlhTNlZaR0dmRzlucjMzdzJ6WlJtMS9oTFc5U1NaemhFTEpqeDJBNFNnZ1dN?=
 =?utf-8?B?MkFUYm5lbk1Ock5EaWZaZUFEWWI4U0JkSnc2bDR4eXBMVFJhb3greXdnQzhC?=
 =?utf-8?Q?Nbwxhkh87d9+4yGRGuDUkiX5C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd96be35-4f31-421b-4f41-08dce6779487
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 02:27:24.7028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhflZH1+3NWDWAuMCN7aJ0mNgutar7u7ufWP6gS9VMNS4CE9EVIjLX7b9z9Nke2SfFO/Ff+gx92zDzQSNx39zp/PPUyGPrqvCXHOX/Vpmnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8275
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIE5henphcmVubyBU
cmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5
LCA1IE9jdG9iZXIgMjAyNCAxMToyMyBwbQ0KPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gu
bWFuaXlhbUBpbnRlbC5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsgPG1h
cmV4QGRlbnguZGU+OyBTaW1vbg0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47
IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbw0KPiBCaW5hY2NoaSA8ZGFyaW8u
YmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBKb2hhbiBKb25rZXINCj4gPGpieDYyNDRA
Z21haWwuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEFyc2VuaXkN
Cj4gS3Jhc25vdiA8YXZrcmFzbm92QHNhbHV0ZWRldmljZXMuY29tPjsgQWxleGFuZGVyIERhaGwg
PGFkYUB0aG9yc2lzLmNvbT47DQo+IFdpbGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJvYWRj
b20uY29tPjsgSWdvciBQcnVzb3YNCj4gPGl2cHJ1c292QHNhbHV0ZWRldmljZXMuY29tPjsgQ2hl
ZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+Ow0KPiBIZWEsIEtvayBLaWFu
ZyA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+OyBOZywgQm9vbiBLaGFpDQo+IDxib29uLmtoYWku
bmdAaW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNs
YWltaUBpbnRlbC5jb20+OyBUZWlrIEhlbmcgPHRlaWsuaGVuZy5jaG9uZ0BpbnRlbC5jb20+Ow0K
PiBaYW1yaSwgTXVoYW1tYWQgSGF6aW0gSXp6YXQgPG11aGFtbWFkLmhhemltLml6emF0LnphbXJp
QGludGVsLmNvbT47DQo+IE1lbmcsIFRpbmd0aW5nIDx0aW5ndGluZy5tZW5nQGludGVsLmNvbT47
IExpbSwgSml0IExvb24NCj4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5nLCBTaWV1IE11
biA8c2lldS5tdW4udGFuZ0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMTYvMTld
IGRyaXZlcnM6IG10ZDogbmFuZDogc3BsOiBBZGQgc3VwcG9ydCBmb3IgbmFuZCBTUEwgbG9hZA0K
PiBpbWFnZQ0KPiANCj4gSGkgRGluZXNoDQo+IA0KPiBPbiBUaHUsIFNlcCAxOSwgMjAyNCBhdCA1
OjU24oCvQU0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBEaW5lc2ggTWFuaXlhbSA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiA+DQo+ID4gVGhp
cyBwYXRjaCBpcyBhZGQgc3VwcG9ydCBmb3Igc3BsIG5hbmQgdG8gbG9hZCBiaW5hcnkgaW1hZ2Ug
ZnJvbSBOQU5EDQo+ID4gdG8gUkFNLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGluZXNoIE1h
bml5YW0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9t
dGQvbmFuZC9yYXcvY2FkZW5jZV9zcGwuYyB8IDk2DQo+ID4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNlX3NwbC5jDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9zcGwuYw0KPiA+
IGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9zcGwuYw0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMC4uODQxODAxNDIwZA0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNlX3NwbC5jDQo+ID4gQEAg
LTAsMCArMSw5NiBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogICAgIEdQTC0y
LjANCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI0IEludGVsIENvcnBvcmF0aW9u
IDx3d3cuaW50ZWwuY29tPiAgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxjYWRlbmNlLW5hbmQu
aD4NCj4gPiArI2luY2x1ZGUgPGRtLmg+DQo+ID4gKyNpbmNsdWRlIDxoYW5nLmg+DQo+ID4gKyNp
bmNsdWRlIDxtYWxsb2MuaD4NCj4gPiArI2luY2x1ZGUgPG1lbWFsaWduLmg+DQo+ID4gKyNpbmNs
dWRlIDxuYW5kLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPiA+ICsNCj4g
PiAraW50IG5hbmRfc3BsX2xvYWRfaW1hZ2UodTMyIG9mZnNldCwgdTMyIGxlbiwgdm9pZCAqZHN0
KSB7DQo+ID4gKyAgICAgICBzaXplX3QgY291bnQgPSBsZW4sIGFjdHVhbCA9IDAsIHBhZ2VfYWxp
Z25fb3ZlcmhlYWQgPSAwOw0KPiA+ICsgICAgICAgdTMyIHBhZ2VfYWxpZ25fb2Zmc2V0ID0gMDsN
Cj4gPiArICAgICAgIHU4ICpwYWdlX2J1ZmZlcjsNCj4gPiArICAgICAgIGludCBlcnIgPSAwOw0K
PiA+ICsgICAgICAgc3RydWN0IG10ZF9pbmZvICptdGQ7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYg
KCFsZW4gfHwgIWRzdCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4g
Kw0KPiA+ICsgICAgICAgbXRkID0gZ2V0X25hbmRfZGV2X2J5X2luZGV4KG5hbmRfY3Vycl9kZXZp
Y2UpOw0KPiA+ICsgICAgICAgaWYgKCFtdGQpDQo+ID4gKyAgICAgICAgICAgICAgIGhhbmcoKTsN
Cj4gPiArDQo+ID4gKyAgICAgICBpZiAoKG9mZnNldCAmIChtdGQtPndyaXRlc2l6ZSAtIDEpKSAh
PSAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHBhZ2VfYnVmZmVyID0gbWFsbG9jX2NhY2hlX2Fs
aWduZWQobXRkLT53cml0ZXNpemUpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIXBhZ2VfYnVm
ZmVyKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGVidWcoIkVycm9yOiBhbGxvY2F0
aW5nIGJ1ZmZlclxuIik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9N
RU07DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHBh
Z2VfYWxpZ25fb3ZlcmhlYWQgPSBvZmZzZXQgJSBtdGQtPndyaXRlc2l6ZTsNCj4gPiArICAgICAg
ICAgICAgICAgcGFnZV9hbGlnbl9vZmZzZXQgPSAob2Zmc2V0IC8gbXRkLT53cml0ZXNpemUpICog
bXRkLT53cml0ZXNpemU7DQo+ID4gKyAgICAgICAgICAgICAgIGNvdW50ID0gbXRkLT53cml0ZXNp
emU7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBlcnIgPSBuYW5kX3JlYWRfc2tpcF9iYWQo
bXRkLCBwYWdlX2FsaWduX29mZnNldCwgJmNvdW50LA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmFjdHVhbCwgbXRkLT5zaXplLA0KPiA+ICsgcGFnZV9idWZm
ZXIpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGVycikgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGZyZWUocGFnZV9idWZmZXIpOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBlcnI7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgIGNvdW50IC09IHBhZ2VfYWxpZ25fb3ZlcmhlYWQ7DQo+ID4gKyAgICAgICAg
ICAgICAgIGNvdW50ID0gbWluKChzaXplX3QpbGVuLCBjb3VudCk7DQo+ID4gKyAgICAgICAgICAg
ICAgIG1lbWNweShkc3QsIHBhZ2VfYnVmZmVyICsgcGFnZV9hbGlnbl9vdmVyaGVhZCwgY291bnQp
Ow0KPiA+ICsgICAgICAgICAgICAgICBmcmVlKHBhZ2VfYnVmZmVyKTsNCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgIGxlbiAtPSBjb3VudDsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFsZW4p
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgIG9mZnNldCArPSBjb3VudDsNCj4gPiArICAgICAgICAgICAgICAgZHN0ICs9
IGNvdW50Ow0KPiA+ICsgICAgICAgICAgICAgICBjb3VudCA9IGxlbjsNCj4gPiArICAgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gbmFuZF9yZWFkX3NraXBfYmFkKG10ZCwgb2Zmc2V0
LCAmY291bnQsICZhY3R1YWwsDQo+ID4gK210ZC0+c2l6ZSwgZHN0KTsgfQ0KPiA+ICsNCj4gDQo+
IFdlIHNob3VsZCByZXRoaW5rIHRoYXQgd2F5IHdlIGhhdmUgbmFuZF9zcGxfbG9hZF9pbWFnZSBh
bmQgY3JlYXRlIGEgd2F5IHRvDQo+IHVuaWZ5IG1vcmUgU29DDQo+IA0KPiA+ICsvKg0KPiA+ICsg
KiBUaGUgb2Zmc2V0IGF0IHdoaWNoIHRoZSBpbWFnZSB0byBiZSBsb2FkZWQgZnJvbSBOQU5EIGlz
IGxvY2F0ZWQgaXMNCj4gPiArICogcmV0cmlldmVkIGZyb20gdGhlIGl0YiBoZWFkZXIuIFRoZSBw
cmVzZW5jZSBvZiBiYWQgYmxvY2tzIGluIHRoZQ0KPiA+ICthcmVhDQo+ID4gKyAqIG9mIHRoZSBO
QU5EIHdoZXJlIHRoZSBpdGIgaW1hZ2UgaXMgbG9jYXRlZCBjb3VsZCBpbnZhbGlkYXRlIHRoZQ0K
PiA+ICtvZmZzZXQNCj4gPiArICogd2hpY2ggbXVzdCB0aGVyZWZvcmUgYmUgYWRqdXN0ZWQgdGFr
aW5nIGludG8gYWNjb3VudCB0aGUgc3RhdGUgb2YNCj4gPiArdGhlDQo+ID4gKyAqIHNlY3RvcnMg
Y29uY2VybmVkDQo+ID4gKyAqLw0KPiA+ICt1MzIgbmFuZF9zcGxfYWRqdXN0X29mZnNldCh1MzIg
c2VjdG9yLCB1MzIgb2Zmcykgew0KPiA+ICsgICAgICAgdTMyIHNlY3Rvcl9hbGlnbl9vZmZzZXQs
IHNlY3Rvcl9hbGlnbl9lbmRfb2Zmc2V0Ow0KPiA+ICsgICAgICAgc3RydWN0IG10ZF9pbmZvICpt
dGQ7DQo+ID4gKw0KPiA+ICsgICAgICAgbXRkID0gZ2V0X25hbmRfZGV2X2J5X2luZGV4KG5hbmRf
Y3Vycl9kZXZpY2UpOw0KPiA+ICsgICAgICAgaWYgKCFtdGQpDQo+ID4gKyAgICAgICAgICAgICAg
IGhhbmcoKTsNCj4gPiArDQo+ID4gKyAgICAgICBzZWN0b3JfYWxpZ25fb2Zmc2V0ID0gc2VjdG9y
ICYgKH4obXRkLT5lcmFzZXNpemUgLSAxKSk7DQo+ID4gKw0KPiA+ICsgICAgICAgc2VjdG9yX2Fs
aWduX2VuZF9vZmZzZXQgPSAoc2VjdG9yICsgb2ZmcykgJiAofihtdGQtPmVyYXNlc2l6ZQ0KPiA+
ICsgLSAxKSk7DQo+ID4gKw0KPiA+ICsgICAgICAgd2hpbGUgKHNlY3Rvcl9hbGlnbl9vZmZzZXQg
PD0gc2VjdG9yX2FsaWduX2VuZF9vZmZzZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKG5h
bmRfYmxvY2tfaXNiYWQobXRkLCBzZWN0b3JfYWxpZ25fb2Zmc2V0KSkgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG9mZnMgKz0gbXRkLT5lcmFzZXNpemU7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgc2VjdG9yX2FsaWduX2VuZF9vZmZzZXQgKz0gbXRkLT5lcmFzZXNpemU7DQo+
ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgc2VjdG9yX2FsaWduX29m
ZnNldCArPSBtdGQtPmVyYXNlc2l6ZTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAg
ICByZXR1cm4gb2ZmczsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IEhlcmUgdGhlIHNhbWUNCj4gDQo+
IE1pY2hhZWwNCj4gPiArdm9pZCBuYW5kX2Rlc2VsZWN0KHZvaWQpIHt9DQo+ID4gLS0NCj4gPiAy
LjI2LjINCj4gPg0KPiANCj4gDQo+IC0tDQo+IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaQ0K
PiBDby1Gb3VuZGVyICYgQ2hpZWYgRXhlY3V0aXZlIE9mZmljZXINCj4gTS4gKzM5IDM0NyA5MTMg
MjE3MA0KPiBtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gDQo+IEFtYXJ1bGEgU29sdXRpb25zIEJWDQo+IEpvb3AgR2Vl
c2lua3dlZyAxMjUsIDExMTQgQUIsIEFtc3RlcmRhbSwgTkwgVC4gKzMxICgwKTg1IDExMSA5MTcy
DQo+IGluZm9AYW1hcnVsYXNvbHV0aW9ucy5jb20gd3d3LmFtYXJ1bGFzb2x1dGlvbnMuY29tDQoN
CkkgYWdyZWUgd2l0aCB5b3VyIHBvaW50Lg0KSSB3aWxsIGxldmVyYWdlIHRoZSBleGlzdGluZyBu
YW5kX3NwbF9sb2FkX2ltYWdlIHRvIGNvcnBvcmF0ZSB3aXRoIHRoaXMgbmV3IENhZGVuY2UgTmFu
ZCBkcml2ZXIuDQoNClRoYW5rcw0KRGluZXNoDQo=
