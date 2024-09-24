Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC93CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DAC88599;
	Tue, 24 Sep 2024 08:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PWJ/iP9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECAD1885F5; Tue, 24 Sep 2024 08:05:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CEA88702
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727157933; x=1758693933;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2jDv9AyyD3+/Ev4Kav0jV0rlZyoOpP+GnjtZFn4KxE4=;
 b=PWJ/iP9oNnxNWAWbMBNETfj5oef5PMRISlWgnrdtD2LnP+aiuvofgnbt
 cYnvoE3Tc1/swKwdl5fU4dmpaMGU5vu1m579gNi2rBDDWd8fQTfvW54r6
 1k0nc+hYdTllzhsXGOx3/3vxuQqcTWyCQeHhSxKjEcOgYCMdOfjA8P+8n
 OtxL1GCao36K6eNUwlUWUltyxWhDJEbUkjup4PhUuY8ONosCGH+ztptAQ
 kCtr5uJkZBz9Uz3y5N4YMT8f3FMuMqyye2FPHUuOgMUGj6IlJxycI1uHr
 eIW02tE6GGbxfczz9fQrKjd/MnngwMkNa50kDaUav8tznmj4XaUoA1Hdv g==;
X-CSE-ConnectionGUID: HWYHF5+CTsOr2juLxaNaYw==
X-CSE-MsgGUID: D0ub+sPvRva4AUiS6/pbOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25647541"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="25647541"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2024 23:05:31 -0700
X-CSE-ConnectionGUID: jbe2C/QpTIiEQlv5AwfvyA==
X-CSE-MsgGUID: aFecFPddQ5KThNMoHxs7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="76081019"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Sep 2024 23:05:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 23:05:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 23:05:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 23:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/6dT92/zP0abp93GtQ7x9KlI84JDe3250DQqjpOZkEiB9SlEtmSyx/NUu5wvLSAWXaCio2KxMxo3kKrJCM8W/sOfkG18QmAbeYb6tXu+zzI2/fcL0AbqIlMjDBNofVIGCehSaepOdpxmbtwZJe4gv/f7sbPxmiMt/hi9NEXyyTfkxiJwfG54kd0IhW55jrIcWn5l20l87UnAgoY+IN1OsRIwMVfXb98PUHYwBX9hnehtjoW8lj9j9Skgz4UOV2nMjB0mWSZe/QSNZT4hrg9q2XHgobaWELIVkJlQA98ayT4dGOqAOSxMT2g5T2N5Xe6mZ/ZJzblYngcPRWTlOF4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jDv9AyyD3+/Ev4Kav0jV0rlZyoOpP+GnjtZFn4KxE4=;
 b=NW2LLjO+d52WpM+qnIel5Zr5S0ZTgiOlj2N3tjQWI+iIMzabMPhjoVboVDYHsMltTB/ML19PZxMt2OUgN1B/zLk9Zz3QuL9ExxPOO7+NKxQRonEDmxQILa++pCMrcbp20q0I0J9beFhAiyFHw/QZrxnpknNQs+zpEEnuRItY0HiuDxH84U9oitrv+Q7PMgY+8q07IZ3/EvyNudGylPq4dMesJZ3tTrpIuygN3xttR9HG6ry60sp+eYdVR0FdDC0D6Q1GLyDzRMT7i0SMqQADS/U0P+SudnxEN8O+aANT5a43ZYIW6I+6E6LNT1jQf0sq35cYOTCi+ZhggofXPWZfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:05:06 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:05:06 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 12/20] arm: socfpga: agilex5: Update CPU info
Thread-Topic: [PATCH v1 12/20] arm: socfpga: agilex5: Update CPU info
Thread-Index: AQHbCys9O7B9VRlLW0KE+ZmH9KW7erJiROwAgAQz4kA=
Date: Tue, 24 Sep 2024 06:05:06 +0000
Message-ID: <DM8PR11MB5592D6E376EFCFFCDD3D195BD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-13-tien.fong.chee@intel.com>
 <c867eca9-0b9a-49be-8779-8af711c0276e@denx.de>
In-Reply-To: <c867eca9-0b9a-49be-8779-8af711c0276e@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CH3PR11MB7795:EE_
x-ms-office365-filtering-correlation-id: e27adef4-addb-4d6e-7c62-08dcdc5ed6d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ODBXb2VrRTZOY0RtU2JGZURoYWxSZGo4MSt4Q1dTQksra2dONXhhMHdRU1l0?=
 =?utf-8?B?QUVHNndoY0RueUZiU0VCYXNxbXNWQWxEbjU3b2l0VEhJa3lvbzdWUDhIYXlS?=
 =?utf-8?B?Lzl2TkdkTytnRFlpeC9NVjhJdlJqQm9jd25nNGllQkRwNGhYZ2VObFMxS3l1?=
 =?utf-8?B?Ty85cThjUUFCS3dBR01aOERzK2ZHd0UyWnB5R2UyWVlreWdBMHFJaDNUbGRo?=
 =?utf-8?B?TmEyNVRwY2dpZkJsaDNYV1JSU1k1a1lId3NoWThjVy83VE05MGpkenl2VHdB?=
 =?utf-8?B?bFg1elZpdXJvRW94MTFPc0QzbElkK3NRT0Myc2U4MlUvNUpWUXV6S0xEa2dQ?=
 =?utf-8?B?TVlLY1lOS0FvSk1EMWNNUGhxZmsxTHpSQ3pvTEt5Z3ExMWpvTHZTYXBaOXox?=
 =?utf-8?B?OUpXYjRKU1NDMFRRamFEVTNnc0Zqa2ZJMk1mbUxrNzk2eitWbCtOV1hoYXl4?=
 =?utf-8?B?Z2xJejRNcUk0M1VwUGViK01lNXQyaDg3M1hub2lHTStQNENnZkN1UDk2ck1w?=
 =?utf-8?B?THFraVlDWGc5ZjVpeCtmbDVuMENkRkNyaGNsL1J4ZFlHeHVjYzhLZWx2S2Ez?=
 =?utf-8?B?R1dqZnFiVmpmaGZKd1dQaklZRW1MemREQWhVTjkzQ0hWcjMvQWZYU3EvOXVy?=
 =?utf-8?B?MUpXd2lWaWtXYitwWHdJOU5oSzZLSDVuUXcwdmcvYmhCRjVBR3BIaWZyaGNP?=
 =?utf-8?B?L0pudUtTOTdMRGEwcVlDeWZyRmVEZmlwc0crM2c1VUFZb2xqOEY5SGdCTXFS?=
 =?utf-8?B?NVIxb1E2dENzY1pydU5KcUkzQ2RXODExUXB6MGw0VGZzNkQvdjB5Y1dLZVVC?=
 =?utf-8?B?ZGxzWVA3eDdEUi9XMmZ5WTA3cmJydnVaZTJ2N3VkcHpGckN2eXQ5V0k3OU4w?=
 =?utf-8?B?VTJHWkQ2VUJYVk4xTy93RG9ZUzhjeUNUUEwrejhwWDhBMlVudWtjSkplcmNV?=
 =?utf-8?B?U3pKNXNhZGtBVmFzV0V3dFV2MDRSRUFzTW9tTHBVTElYRVRIVEZIN2lsMTlj?=
 =?utf-8?B?MXdKWGFGVVNSZDh2Mldod3ljNVlpaERjNW45dGFzV3dPVEpFeGVZcTNKbmw1?=
 =?utf-8?B?RVJwVU5JNmwxd2NpcUJyVHpWNkpMOWs1MlRnUkxYREozU3hsT0hnTXl3WFVV?=
 =?utf-8?B?Tlc4MVJ3ZDVoYXg3d2xqVU93L0gxbE9Cdzhjd2ExOVg5NFdoMGQxVXo1eVhT?=
 =?utf-8?B?cWN0NDRycjR0eEw5bzFGZUtMTGxLVzJrWmtuZGM2dWJ0NE45T2ZtREJtUDJT?=
 =?utf-8?B?Smh0ZU45KytlTGNzcjVZbUtMelgrY0xjdEdpQ1VKTFppK00rOEtoN0kwVndJ?=
 =?utf-8?B?ZC9QT0p4MEFvOGZFeXdmSG54U1lUWjBWVHJYWm5UVXNzS3Q2NTlsYkE4T0Uz?=
 =?utf-8?B?ZnA5QjNVUDYxdkJRczFrWm1RUFAzaXc0VGNTNkViNThJVDQvUk4vb1hhYi9V?=
 =?utf-8?B?VHJySG1QRmM4NEZUTCtlOEI2czdsUjZjZ3hhd1hwOU4wWWJGdGpCZWdQUTNj?=
 =?utf-8?B?ejVzSENwSk81U1hBU2oyOGhVRENnVTZ5QjJEMSs1VmVwRjlKNWhKVzdjVTV3?=
 =?utf-8?B?aktlejdPNEcxR21xbklQenBYM3RtSEdhNFBsYjJJUmhoSFlKQ0YrZ0xyOXJX?=
 =?utf-8?B?NTZVTHNpSkJ1WVhjdzl5d201OUQ5UEtTdS9ZVFE3RUhCYWt3Z3dRSVp2NDYr?=
 =?utf-8?B?MGFSWDRiYllaYk1XWUdCVDErUU41Tml2Y3pHakU1cVhON3lnTkNVeWZ2ZWp0?=
 =?utf-8?B?SzlOUkltL2F5dG92NDF3dVVQUnZ5UDhsY1cwQmMvNzZJbS83UXdQYjBMbFBh?=
 =?utf-8?B?dFhuZ05tQVNqaUpVc2xndnp0ejJ1Ni8xRnJSaGY2UEdQL0tmSUU3OEtqanJK?=
 =?utf-8?B?NExOVE9zTXFjQno3MnQ4Ynk2YW41Q2ZoWXV5bUt5eStiTVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDVQUXZXeDVTb2U5QXVNTnNhalY4QWdxaGlNS0EwNDN4bXpvZzE0MTV4emJX?=
 =?utf-8?B?RlppMEJOK2V4cUdOaVFhcStybjV5S0Y0elZpKytodFJYRkhRbEN4clU4aC9V?=
 =?utf-8?B?VHZ6Q3U3UEgyaHJqNEZwOVB3WkRod2hzM2p6dWtreGtNelZtNmplbkRIdEIr?=
 =?utf-8?B?QUROczZZMEM4eDdqMGhBU0N2WWpjaDB0TVFnbGptRFlqb09iRlU0aVMrTkVN?=
 =?utf-8?B?bFFBUUdpWWY4SGNtWGJhRnFId01zODQyWFRMa2NQUGl3OFFjTDllSGhoZ3FX?=
 =?utf-8?B?b3grRFJwN283UkJ5S09Xbzh1TCsramhGMGdaRkRrZ3h5bVYvNXkwZUNXVmtp?=
 =?utf-8?B?RXQ5dWVJdkVpZU50SzJGUk9XRGZWZU1NakRhNDdWY1R6VVBPT3pveUpqU1U0?=
 =?utf-8?B?ZitqcHVVUmZsUXVqNGhPQk5ObU4vQ2ZkalFmUW83SHpZTlJMd01zSmFXTmto?=
 =?utf-8?B?ZkRrWlhOZ2d5OEdaNzNmRms0elNTV2k3eml0WGQ4Y0RMTUlxWjZ4b0lidzhM?=
 =?utf-8?B?cUoyaXU1OSsxeDI4YXdUTkE3RXEwTzBYL3cyRDFsd281a3pmck9aNm1UMENo?=
 =?utf-8?B?azhOWWNKYU5wOWFudEYwOEVRb29HRUNJZHd2dGRiMUN1MDBFL2dMQUxEOU9k?=
 =?utf-8?B?bXFwMytQbGlqTHpoS3lsQ0d4V0hWTEJ5MVpXckV2YlZCM1pJZFNuaVVNV3Fk?=
 =?utf-8?B?a0szdXFObjloaWdKT1hoZExFLytGbFRZVUcya0Z4SFZLSXdSWUN5WWdrV2R3?=
 =?utf-8?B?eU9oVWJBN2lobi9jREV5QjRwRytISHBpVUVYeVhESHpVT3dYaUV3TkNmQUYr?=
 =?utf-8?B?QkV2dDdNNy9JZDRzb1hqbzYyT0JlVTlEV3R6NWMwNnIzM29qUEQrU2MyK25h?=
 =?utf-8?B?WVVkMS9ZR1crUXlvdnBHNU02MVo0bEl6eEs2WG4vbCt2aGxZc3dMejU1SlVV?=
 =?utf-8?B?V3NhVy8zekU5bDRFN3l5OEpyYzlDR1pMajhVZlozdm9lcTNIeGRsSzFlR0Ew?=
 =?utf-8?B?aGVyM2Vra2FmRzNLUkdYaVRvVUxmMVcyT3VEaEtiN0xZWGRjU3NWYUVtU0FR?=
 =?utf-8?B?THNzcW1vY3UyK0RZVjZ0VWEzcFJTRTk5alBaTU1xUWRsRjlUR3Jza2dhMjFN?=
 =?utf-8?B?QzF5eTkwZmZtWmFlL3pvb0o4TXZHdXJxam40OEtsY1FmcHBaV3RlN3VvdGJs?=
 =?utf-8?B?MTU0d3pPbEVhUnJLV3Z3S2kxQ2prckdqNUh1MVdEUkthYjdLbnkzS0tkRGdF?=
 =?utf-8?B?SWMzMGhFZ1RzNXduNWdMMTN0WGhJNEVlRkJoMmVneTJSRWpWNmtWd05WcERH?=
 =?utf-8?B?Q1RtUFJiWWNqVnBkV2xpbGNaNzRoT0gwVEtlNGdldVE3NXA4aCtKeHdNVGkz?=
 =?utf-8?B?OURTOEMwZGhzSWwrU2N4WE9yZE4wZy9zdlRZYXRGVHEzOG9IKzlybmYxTWZG?=
 =?utf-8?B?WllCUW9rbm1hNUxRaFpVNm0yU0VRQkRuakNEWXpsL2RPTWpzeFV0TzVndUF6?=
 =?utf-8?B?d0IvaWhNb2RmRFNhMGZ2SU9CQjluUWN1SWJIK1hWY1ZMcXJINy9BckZMTnZn?=
 =?utf-8?B?cXpwMWVIVkNBbWxrY2tOV3JidWhtS1VMMkhLaGhKdFZ1L0Z6QUxuWVFaNVJH?=
 =?utf-8?B?dCtXaDQ4ci9jNFZSRjFuSEVMbCtOT0xLdGRkb0d1eFl2Q1NuOGhtRDd3WDRu?=
 =?utf-8?B?UWppMDQ0TWNxYXlrMExqbEs2RUxTb3dWbm1XaXcrTHJnZDN1OFdkL0hyMUQ0?=
 =?utf-8?B?VlZ5SDRqT1BaYTd5VzY3Tm1md2dOQk8ybzVEVjJHRFZKNDFPVDdVMURVbEFv?=
 =?utf-8?B?ZllhZk5xcUJqNkNsbGllcFNENWZTWEdVc2hDbHlHM0R1TjZRNDIvVnh1U1JV?=
 =?utf-8?B?SmlXV2ZJbDJiVkNjdnFsRjU3eWo0U1RwS3ZtemM4bE9RN09EUnNFMGZDMEEv?=
 =?utf-8?B?OXhXZndkVlJEK2lvSTBmdEpEa0tLUlFSR1RGcGFmNVN5YzFJSDB6ZmJYRHhx?=
 =?utf-8?B?dmlOY2QxdE1XSlZNL3QvL0xXSHdLM2FaZnMxekQzTUZBcTdpb1ArZC9BTjFK?=
 =?utf-8?B?QmJTalZDbTZLek84YURoNVppTUU2Vk85VFE2OHg2N2Q3SlpqVXYzc2tJRUZY?=
 =?utf-8?Q?S7njkv/NAIXH2vkhLsuwA5w1J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27adef4-addb-4d6e-7c62-08dcdc5ed6d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 06:05:06.8550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTAX98k21AECpkQrIDkbG3nQLBminx56FwQy5I/oIy7wMqi7BE3h2sIWYMVuuPBE8B3USQHEgQSUeLbDPEsKmnyR5X/t9Du6mXBlM7X9Ip8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjQgOTo1
MyBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMi8yMF0gYXJtOiBzb2NmcGdhOiBhZ2lsZXg1OiBV
cGRhdGUgQ1BVIGluZm8NCj4gDQo+IE9uIDkvMjAvMjQgOTowMiBBTSwgdGllbi5mb25nLmNoZWVA
aW50ZWwuY29tIHdyb3RlOg0KPiA+IEZyb206IFRpZW4gRm9uZyBDaGVlIDx0aWVuLmZvbmcuY2hl
ZUBpbnRlbC5jb20+DQo+ID4NCj4gPiBVcGRhdGUgdGhlIHByaW50IGluZm8gcGVyIEFnaWxleCA1
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGllbiBGb25nIENoZWUgPHRpZW4uZm9uZy5jaGVl
QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtL21hY2gtc29jZnBnYS9taXNjX3Nv
YzY0LmMgfCA3ICsrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXNvY2Zw
Z2EvbWlzY19zb2M2NC5jIGIvYXJjaC9hcm0vbWFjaC0NCj4gc29jZnBnYS9taXNjX3NvYzY0LmMN
Cj4gPiBpbmRleCBhNmNjNzg0NTRkYS4uOTVlMWMwN2UzOWYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm0vbWFjaC1zb2NmcGdhL21pc2Nfc29jNjQuYw0KPiA+ICsrKyBiL2FyY2gvYXJtL21hY2gt
c29jZnBnYS9taXNjX3NvYzY0LmMNCj4gPiBAQCAtNDUsNyArNDUsMTIgQEAgc3RhdGljIEFsdGVy
YV9kZXNjIGFsdGVyYV9mcGdhW10gPSB7DQo+ID4gICAjaWYgZGVmaW5lZChDT05GSUdfRElTUExB
WV9DUFVJTkZPKQ0KPiA+ICAgaW50IHByaW50X2NwdWluZm8odm9pZCkNCj4gPiAgIHsNCj4gPiAt
CXB1dHMoIkNQVTogICBJbnRlbCBGUEdBIFNvQ0ZQR0EgUGxhdGZvcm0gKEFSTXY4IDY0Yml0IENv
cnRleC0NCj4gQTUzKVxuIik7DQo+ID4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfVEFSR0VUX1NP
Q0ZQR0FfQUdJTEVYNSkpIHsNCj4gPiArCQlwdXRzKCJDUFU6IEludGVsIEZQR0EgU29DRlBHQSBQ
bGF0Zm9ybSAoQVJNdjggNjRiaXQNCj4gQ29ydGV4LUE1NS9BNzYpIik7DQo+ID4gKwkJcHV0cygi
XG4iKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKw0KPiANCj4gcHJpbnRmKCJDUFU6IEludGVsIEZQ
R0EgU29DRlBHQSBQbGF0Zm9ybSAoQVJNdjggNjRiaXQgQ29ydGV4LSVzKVxuIiwNCj4gICAgICAg
ICBJU19FTkFCTEVEKENPTkZJR19UQVJHRVRfU09DRlBHQV9BR0lMRVg1KSA/ICJBNTUvQTc2IiA6
ICJBNTMiKTsNCg0KV2Ugd2lsbCBmaXggaXQuDQoNClRoYW5rcyBmb3IgdGhlIGdvb2QgY29tbWVu
dC4NCg0KUmVnYXJkcywNClRpZW4gRm9uZw0K
