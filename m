Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB33CC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D32980A46;
	Wed, 19 Feb 2025 03:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VHQDbuFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61EC980C98; Wed, 19 Feb 2025 03:59:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DE5809A4
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739933977; x=1771469977;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pI17spmphzZ1tygr5vVLo3xaumAcAAk+8HYCZzE8Sg4=;
 b=VHQDbuFZ1w9xEyc9o5RUcLUPhcpjAJKNmMOgOkGlcVp0iS/s7SnAKvZY
 KghulO9fMg5uXW4mPvrvBxJJjF+S1JfMB9EoMIVEmAP5Ms8nxnmZEmV8P
 6j5wVQIebGn/ff31pY1JicDQtX+TcsoxyVNV0puCq05ACl2XHBz/jpoxe
 /odRrDXhqNggI78+vXWPvnIK6wh9XctE3lQ/oQvUk1hdDw8peaVA/Wl1C
 etzL++QylFgbBVTe3YnFzHjcQhDZjRhHUSNwW1fu5dZcZh9O0Z0uSI1mU
 hhi9ffJv16IWDvHpNPxXF3QpDN2YoTmE7X6zccCG+4cGMdAqPZLHPMXng g==;
X-CSE-ConnectionGUID: n4Mw69SKQ8yZEoCAG/jOfw==
X-CSE-MsgGUID: tFrUIcTVSL6MVIyVaXr6kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44573051"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="44573051"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 18:59:34 -0800
X-CSE-ConnectionGUID: Ea/jg2OSTzK7IhUqCdSBCw==
X-CSE-MsgGUID: N6K9swAdTUWjhvVwv6pAJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="114762730"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 18:59:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 18:59:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 18:59:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 18:59:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYirimv6KvA21CMul+HBHuQkXU5hHI/p5qu7q/wUW/yycQMuF41lGmY5pQ24AmclTxQFxE/wYWFgiTnt/mYDGX6xGqPuPR8cDbzHzGv597b4eFh5zqp861CIv3bCY4y78FYRKm4jA3NdEt8XdlZCurTjl8lAtNVVozyhHP4MemZDHssaEWtbZ9FZBD0psdkcHZkTslhOkAaPEyj29VQ3UzDE35ORheJ1eCnKsfNX1fac0Sz5Giirf8xh5xSaVtoVOcAxuJahQZpusPBJlj6X+R/ZgL5vqFVyk8dz5qmFA9Nq9CtbN+1w2KlThT8BpAYEld4byl6DBFSW5PQ6jffJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI17spmphzZ1tygr5vVLo3xaumAcAAk+8HYCZzE8Sg4=;
 b=bASxQsAa+BQDshMtfRA7jRll+km4z9N6UPQjKR2+TnHTGzgSjjFcnAYai4fpf6CzEjMEUZWT60ea5wZ5Jqf0E0MSi0thf1qJo6X8AEkHUEThabgtA9cVSq5o3EsxRgIOkQ45/sjSBRTs38g/wUtBm1OvSOOzmACqYrDF3jGN52mMX2jEewThQUhsDXZUz9Bw3MzYjZH83vXUljIqYkkNTcZdxWa/+WY96xilPjEJA4WkWdE2mFwrf+NWAGnqIXyspS8Nfl9oWWa4Almn0bo3YmzEhLO+sgRw32WTV31TWEr0xXRzjJ0JfsAZommsniD33HJyN+7qKbyRLV5E7nw4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 02:59:12 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 02:59:12 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>, Wang Jie
 <dave.wang@rock-chips.com>, "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad
 Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH 09/10] cmd: Add i3c command support.
Thread-Topic: [PATCH 09/10] cmd: Add i3c command support.
Thread-Index: AQHbgbEBCfjjKWcPJ0+TVjsFMZdvUrNNDtqAgADg+NA=
Date: Wed, 19 Feb 2025 02:59:12 +0000
Message-ID: <BL1PR11MB53662A7B53153E0BD13CABEF82C52@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-10-dinesh.maniyam@intel.com>
 <CAFLszThc6uiqNwYdrAgHEZ0gZyd8J-+xJJf0WCo-nrGw7VD9Rw@mail.gmail.com>
In-Reply-To: <CAFLszThc6uiqNwYdrAgHEZ0gZyd8J-+xJJf0WCo-nrGw7VD9Rw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|MW4PR11MB5774:EE_
x-ms-office365-filtering-correlation-id: f2f0835f-958b-491a-de34-08dd5091638d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Rm1LNzBxTWhIV3hnYkJsZW1kNk9ZTTRFYzY4WGJMb2Q3MVlsakordThGaC9i?=
 =?utf-8?B?TTRXdC83RnRoM2wvM1BlSzJyMkF0ZmdIbkxPVlJHTzhvZmp6Z3JVTEl3cWNZ?=
 =?utf-8?B?K1Z3dk5OQWdGNlZmWHhVaUxlZzVpY1UweUh2UVo0YjlPQmQvMWJENitNUG9a?=
 =?utf-8?B?YjU1N1EvSnAvb2Uwd1gzSjExRnRSb3ppN3Aya1oxYjZyNVlpeGozQW9zcnE1?=
 =?utf-8?B?aVFQZGtRZHB4aXVZVWVlL1FPbUZaSkFFZEcxb2N5d3lhSUFkdW5MZjYxLzZV?=
 =?utf-8?B?YytiVWE5bG1LcGpmdWNxb3J4YVd3YXdLRkRYZEFRQ3JtclFLUlY4d1FaSzE5?=
 =?utf-8?B?T0FKUnNpdUV3b3MvYmxUVnJjSTBIeWJZTjlIRzUrWWtiNWUxQjZuaU8weG9E?=
 =?utf-8?B?S1dnZk9TbUxodGtpa3ZIY2dYdHRtUU1nOGNLTE5jZTAzM3l6aC9YWmlOQVgz?=
 =?utf-8?B?OGROOVY3SncvWnhtdmp0c2FjUENBT1pXc1pDY3FIVXFQczdHL1ZJd3VpaWEw?=
 =?utf-8?B?SHZiNHFnalJqeStjYlVJRi9nV3ZaTElic0VROXJKRDFMc294UUkxRDJSV0w0?=
 =?utf-8?B?YmIvSDdPYU5lQUEwNEVxbWpJVlJKY2ZrNElmN2paUkR0K0toRlFtbkdHaG1w?=
 =?utf-8?B?M3FPM0tzOUw3WlJzbHhQTElMcmJTOXBvN3JiVXppaU1WZzFGVVQraFNiR1lU?=
 =?utf-8?B?YjhUVGNlb0dqNUlmRFkwdDJQM3dVREdkaEcwR1k4amxBRkJxUVpYVFh0anZm?=
 =?utf-8?B?c2NOekdrSGdJbWNGSjY5VGFETzBCUURPbEt3bkJDTVdwSWJvU2Zzd2t5a3VT?=
 =?utf-8?B?RWJ2SGJMV09NbkdwODNyZ3YvQlNwcklwdGFJSGtrdjMzY2VhekpXNnc5UDVU?=
 =?utf-8?B?TzZSZGN0NFF0L0FLSnQ2K2RzWUJNanpjTTZFSVUyZzV3WHhmT2Y0cW9Jc2gx?=
 =?utf-8?B?bkdBMlQyV0c5TEdMVDNmWkRqTFUyOTZ1c3N6NForUWZjR0FCUHJGRExCZkZC?=
 =?utf-8?B?UUxWVHVNbDV3eTVhTVM1WVRnRko2eWxMVkRRQ2lla1ZBV01CWUtSQktOSEIy?=
 =?utf-8?B?b2k4OVgwd3Q5ZUpxZzVIaE5iZ2trd2RMdGFnb2I1OGF1aXV3OUxkWElkanFi?=
 =?utf-8?B?andBUjdGdWpFWHl6M0ZIaHFyTGJvTnozTkx1c09ZcENBYXZOZ1RrTlZKZ3Fz?=
 =?utf-8?B?dmNhOG5zYW5tK3BRMkZ3TnVKakFsK0VoZnVIVnFpWjJERnUxRTFuMkxBQWpM?=
 =?utf-8?B?RXRMM0JGcHh2WjRQcjFRM0luWWZmKzZ6Wk85SG40eDdaOXVRekZGT0ZsL1pq?=
 =?utf-8?B?RmtxZHYzUzVQc3FPUDlkNWd6TmRaRkZQblMybFozVlZJTE42N2c0ajNzVmtO?=
 =?utf-8?B?OHZIMjZGU3NzWWZUTEdpTzNUdnlLUWxoOEh3WjRZem1CZVZYOWpPRjZLMjI4?=
 =?utf-8?B?S2Fac0JNWk03MkNNbVBYOE02eXBnbnFlbDcvRnE2OE9qQy9oT0pESjB1VHpI?=
 =?utf-8?B?SDFtVUxibmN2dEJqSjVDYllkL1N2WVRWWlIzM0lENTM2U1ozaG8yVVc1Q2ps?=
 =?utf-8?B?MDZnRy9WY21kT0Q4VG0rZ2NqRFEyVnRwQ21LaDlpVk9BOEJ0cVFrZGRPZm8v?=
 =?utf-8?B?T2w5NXVpYjhjamNuQm94NjFlR2YySEhURDE0NmFMM29MNlAvNGk4MzVFNTdN?=
 =?utf-8?B?MkJJZkp5YmhuV2k2NjhQNzRhbTNJNzA1bWZUdnRndlY0eE5pbjBBRmlVaDJC?=
 =?utf-8?B?cUVFUEswSlJrOWZzR0lvUFNZTFVnekpTRXRzOE1VRk9BMXBPMnE4RFRNYzBs?=
 =?utf-8?B?RlBpSFpzTkRKRjZNMnpobXh4eEgzQ09TNm0vQWs3R1hOMkdvZkd5QlZ4SDZ5?=
 =?utf-8?B?cXhVYVducEpJNU11ekpnL1FvUkRWMFhTK3VZRWg3LzhlNHFmVk5KMkx0TkVI?=
 =?utf-8?Q?68nSL0N9BFm1ImnwMqS99VphFcZFe7QX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXl6Z1ZUM1VJMGtNNGZSWDJPZ2puNUN5WFBaQnZPS1NOVDlYMUV2WlJTVkxO?=
 =?utf-8?B?a0ZLWmF0ZHc4TWI4bzNoMW0vOHlObUFUOXBxYkxCSWxDdnptZDNjUlhtSEF3?=
 =?utf-8?B?V2JNS0luOE1rZ1R0SUxXSmIvbm9qTVhIZFVrSUhhZFJHVEppM1NNN3k3TzVU?=
 =?utf-8?B?bmFTVzM5d1J5KzdFK052QW0zazU1V0VaV0JHckttTXFFZEhwZUNKWUJGRmk4?=
 =?utf-8?B?NEEvUC9PODk4N1hYc09VYWszdFlRUTdiZmRSSVJhUlNLaTBva3JPN0ltT1o3?=
 =?utf-8?B?d1RDc3ZBY25wMHVtWHNvejlMWmdQVnVaV0Y4Z1VtejQrYXNPd1UwTnZ3Rmgv?=
 =?utf-8?B?dmhoLzBOMS93eWN4N29leDc0cmxGc3pZN2M3VVlsMmRXUEZ2SlRhbWVaZDVm?=
 =?utf-8?B?MDgzeS9nekZMV2orekFPVWkrU1FVR1VlYkh0NFFzOTJ2MTJBdFJMTnNzU1k1?=
 =?utf-8?B?ZG9RaVhuY3BKU0JaYXJKdERSbFNlaGsrb0w4cHUzUjBVQ2VSRVRlM21ZVkZ4?=
 =?utf-8?B?UWdYZ3JTWG5sUEttc1l1M3ZabzYxOS9rTUx4a0JWc3NPSGpkUTI4WW54a3Fj?=
 =?utf-8?B?RFYrSVZkYkp2SHUwcmFINTh2SWtYVGxmcHVWaTJwRHdwcUNGeFJiSURvTWFw?=
 =?utf-8?B?SGt3WnUvakJBbEF1RHlkTGU1VHlPNnJQUkthaWNOYnE2L1g5TnBGL1A2STdB?=
 =?utf-8?B?WURLWDdKek9va21xK1BXTk1seDdxSTBOUnRSYVlPSnFMZGJNUkJTcDNNWXov?=
 =?utf-8?B?L3FYazRkUzgwQmlqT0lJUFBXbWFURmpncmtnSWRMUkc5U2hZZmJoRjBOa0hn?=
 =?utf-8?B?bzJUTjdTV0lOQm1xQkQ0VUIyUnJqS0g5bnJYTVJpLzREalArMmZ1QnhGL1JP?=
 =?utf-8?B?SlZkTDN5STc0SEV5eDN6dUVDdm5NSTN5OHhjazl3OUJlZ2ZsSHlwVWNmK1Zv?=
 =?utf-8?B?SHdlb29JdjhiWXprRWRXWDU1c2VTbjZCUnZYUk1wdDlTbmgyNkhxc2hmSWha?=
 =?utf-8?B?WllLU3ZoWVBUR3FaMzdGekYrRHl3L29QWDdkT3JUczBGR1dtMlRsR2JsbGdG?=
 =?utf-8?B?Y3RhZlR5ek05WkR4WUNBODJvalhyZDB4T25OZGltUU94azZqSUY3VEtPdE5O?=
 =?utf-8?B?SHJlTnpPV0N4YTQ1YlNWdS83K0VFVkdSVVJTdXRHSzIrbTFGaTBUemh1cHR1?=
 =?utf-8?B?Ry9zU0Y2MnBvbFMwdkJtNUY5NGNNQTA4bnM5bFBrUnZHenduYyt1NXRWK0da?=
 =?utf-8?B?QTFMcXhmMUJHREpqK0hIbG5VNnZnQ1hNYytkU0J1b1NaMXd5Um9YU3g1TzQ0?=
 =?utf-8?B?ZldsZkxPcTNhdVIzdnBGMDZWTWNFMDBZLzNPemtHa3RYb0Fxc2JuMndUVnpa?=
 =?utf-8?B?MDlnQnVaOG1nVTJwM2dGZGkxamU2K3hCaVlUNzFPMGxvUUlzTHVzVlNPcnhl?=
 =?utf-8?B?dXR3dFpKREdtTitBbjIzMDdtWjgyL2JLNU4vdWRnQm9zYkxtTW83Z1l5TkF0?=
 =?utf-8?B?V1dNY29WWEZwMWR0VU02dkR4VnNNMHZ2b1kyb2xVZXBVWlliMS9GTXFIMXF3?=
 =?utf-8?B?U2RhZFJGTGNkcCtoeFFsQThRODRXTW92OUg0UnN1Lzdjbjh6OE5YK21rcm1M?=
 =?utf-8?B?Q2w2dHI1dEt6MThxRFdiTkhkTUI0L0Ixc09HTUFUQ1VpQWlLU29hRC9ETTJU?=
 =?utf-8?B?Yjg3YStHbXNVVHR4SEJRZEs3QmJVa242RFpCaDNBK0g0UW1wNnlWK0U1a3NE?=
 =?utf-8?B?MFFSUkpJb1RSbVBVckN4SEtQeWJ2V250SkdsRFZFMGdiaENwYjJYUVRKN2lt?=
 =?utf-8?B?QVZLL1Y3Q3N1ZzNZOHhWUUJobUpWd3QrWnBTbHdPcCs0dTg2NThVN2pZZFZi?=
 =?utf-8?B?dkFGa0xXZ3MzbDVHWCtHNHpNNlpaT3hIczBUUnY2S0RWQmt6cnI0Tm1TQ0Jy?=
 =?utf-8?B?ZktKV1VQM2MvVERVS0xyV3FlREtXYTd2ZEVBbmVRRW1LMHNyOEV2WVpnTC9D?=
 =?utf-8?B?QmwvMUZWSjlhQzFrRkVTMjU5QndLT2FNNlV1eHFEWlR2aXVhQUxXTlNLUSs5?=
 =?utf-8?B?akg2UjF6WnAyclY5MXZobXB5VnlGQ21tS2JRM3RlS2FVR0x2cUVHRW43MlBH?=
 =?utf-8?B?TTcyUXVFWUZiWFptcU9FOWlqcjIwWGZGRkxkdkpmNjExTk5nNk5nSk9wb2My?=
 =?utf-8?Q?WesMVhGK5Xr4Yef+fhkAY//zsY+yK7jhrtob8Gi/k4Zc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f0835f-958b-491a-de34-08dd5091638d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 02:59:12.6934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92AzaUoIKYCRENeFrbbWJ9uBhpajzw2OruLcoFWCoSn6Vwb8vuQN5MTNzqcEg6hFwNsjpa26otrLFZ4p/odgKJphtAzYDexbKuKA264HbKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gR2xhc3MgPHNq
Z0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIDE4IEZlYnJ1YXJ5IDIwMjUgOToyOSBw
bQ0KPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+DQo+IENj
OiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsgPG1hcmV4QGRlbnguZGU+OyBTaW1vbiBHb2xk
c2NobWlkdA0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IFRvbSBSaW5pIDx0
cmluaUBrb25zdWxrby5jb20+OyBJbGlhcw0KPiBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFz
QGxpbmFyby5vcmc+OyBIZWlucmljaCBTY2h1Y2hhcmR0DQo+IDx4eXByb24uZ2xwa0BnbXguZGU+
OyBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFyby5vcmc+OyBNYXR0aWpz
DQo+IEtvcnBlcnNob2VrIDxta29ycGVyc2hvZWtAYmF5bGlicmUuY29tPjsgSWJhaSBFcmtpYWdh
IDxpYmFpLmVya2lhZ2EtDQo+IGVsb3J6YUBhbWQuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwu
c2ltZWtAYW1kLmNvbT47IERtaXRyeSBSb2tvc292DQo+IDxkZHJva29zb3ZAc2FsdXRlZGV2aWNl
cy5jb20+OyBKb25hcyBLYXJsbWFuIDxqb25hc0Brd2lib28uc2U+OyBTZWJhc3RpYW4NCj4gUmVp
Y2hlbCA8c2ViYXN0aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvbT47IFdhbmcgSmllIDxkYXZlLndh
bmdAcm9jay0NCj4gY2hpcHMuY29tPjsgTWVuZywgVGluZ3RpbmcgPHRpbmd0aW5nLm1lbmdAaW50
ZWwuY29tPjsgQ2hlZSwgVGllbiBGb25nDQo+IDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyBI
ZWEsIEtvayBLaWFuZyA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+OyBOZywNCj4gQm9vbiBLaGFp
IDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlm
Lnpha3Vhbi55dXNsYWltaUBpbnRlbC5jb20+OyBaYW1yaSwgTXVoYW1tYWQgSGF6aW0gSXp6YXQN
Cj4gPG11aGFtbWFkLmhhemltLml6emF0LnphbXJpQGludGVsLmNvbT47IExpbSwgSml0IExvb24N
Cj4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5nLCBTaWV1IE11biA8c2lldS5tdW4udGFu
Z0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDkvMTBdIGNtZDogQWRkIGkzYyBj
b21tYW5kIHN1cHBvcnQuDQo+IA0KPiBIaSBEaW5lc2gsDQo+IA0KPiBPbiBNb24sIDE3IEZlYiAy
MDI1IGF0IDE5OjU4LCA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+
IEZyb206IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+DQo+ID4NCj4g
PiBBZGQgaTNjIGNvbW1hbmQgZmlsZSB0byBzdXBwb3J0IHNlbGVjdCwgZ2V0IGkzYyBkZXZpY2Ug
dGFyZ2V0IGxpc3QsDQo+ID4gcmVhZCBhbmQgd3JpdGUgb3BlcmF0aW9uLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogRGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgY21kL2kzYy5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE5MyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2kzYy9tYXN0ZXIvZHctaTNj
LW1hc3Rlci5jIHwgIDM1ICsrKysrLQ0KPiA+ICBpbmNsdWRlL2R3LWkzYy5oICAgICAgICAgICAg
ICAgICAgIHwgICAyICsNCj4gPiAgaW5jbHVkZS9pM2MuaCAgICAgICAgICAgICAgICAgICAgICB8
ICAgNCArDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjMzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGNtZC9pM2MuYw0KPiANCj4gUGxlYXNlIGNh
biB5b3UgYWRkIGRvYy91c2FnZS9jbWQgaW4gdGhpcyBwYXRjaD8NCj4gDQo+IElkZWFsbHkgdGhl
cmUgc2hvdWxkIGJlIGEgc2ltcGxlIHRlc3Qgb2YgdGhlIGNvbW1hbmQgdG9vLCBsaWtlIHRlc3Qv
ZG0vYWNwaS5jIG9yDQo+IHRoZSB0aGluZ3MgaW4gdGVzdC9jbWQvDQo+IA0KPiBSZWdhcmRzLA0K
PiBTaW1vbg0KDQpOb3RlZCwgd2lsbCBhZGQgdGhlIGRvYy91c2FnZS9jbWQgIGFuZCBzaW1wbGUg
dGVzdCBmb3IgdGhpcyBuZXcgaTNjIGNvbW1hbmQgc3VwcG9ydCBpbiB2Mi4NCg0KUmVnYXJkcw0K
RGluZXNoDQo=
