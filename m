Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492D6CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 04:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742B388387;
	Tue, 24 Sep 2024 06:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wkf5IZTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A72988387; Tue, 24 Sep 2024 06:45:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82915881C1
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 06:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727153130; x=1758689130;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DMPa/Mv5VNQjWesFI5pUe1ozUJ0c6sa8RXkWITR/z1w=;
 b=Wkf5IZTqn3AbJr2w0/Irwgo3wrgm8WW+5maI7UzftOUJ2Zw/CrqFS31c
 5JV6Bz5eXzE1AqBkzPkSYofD8Y9xI1wCVxpUC4i8MSrUkU72JVV4OpvFB
 Gz53Ge8+E3jxIKx6rqvYkvdleP+QWL+1olCWj8Yg4ND9ohdKCYfcIJq6y
 UbZapBc5IG3VWj4FcPjjq/89/1BtcW8KhyFSq/e17epGTpJhvd3mZcG9G
 CV3RUeHAancB0JEocA5S+dYkPkdbpOOUuiEuOCN0EoVaQhgU6+bV8hvDB
 kRkVrh7g39oPu1Pbo9W4Nzfh13+w6dAHUvRktlB3G28BkLEEkIM88rWxV w==;
X-CSE-ConnectionGUID: Nde71HpbR26apHgnQodc5Q==
X-CSE-MsgGUID: IgQKMYoiQjewAfuVlBNHzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25602206"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="25602206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2024 21:45:29 -0700
X-CSE-ConnectionGUID: mK6tqnBYRdiggYS1y9DT4w==
X-CSE-MsgGUID: Chc8lW3NSL+cTYPxq4/NPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="71555275"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Sep 2024 21:45:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 21:45:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 21:45:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 21:45:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 21:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j18MRVQV8frjG+lYTBvfqTuHqV0Nb7N5dAOkl3L0PHQyxWcdovPAL6/hRwttKdcJXJQafVqbXMqYP0RMDhKr8IjxHw7XKZIkTxzVcxZXsnFftHIHZCCw4f1qyTFQQoMGoaYfwjd+3jmEFR/mAm6805uMry8SI1uLaDCK7aD/NElELoKJfrlmJv5MtMtxLiaohILCSeShz4WJdUwrHz3C5NdWru33gEwE6AvDoLHEs1XAB2cKODtqfo4OZkY+9eGEVuh1pZ2G22Py2bItNKFeUIuQpMdidByPak346xBzhH3RefyJUrko/U644FiRq6ln1q6GlMal/RKboY4JdwCxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMPa/Mv5VNQjWesFI5pUe1ozUJ0c6sa8RXkWITR/z1w=;
 b=PKQHgv5WtX3ReSJ+lhg8hLK2vXlMOZCGEaMpiSE6z+fSWDy4X/ovKVZc7eKm+wx1+h8xw68f670Hv00uLug2t9cYSUkIoKAYaS/krfuUq+QHsbT/1Leo+7+Tsdyq8O/NZGTZQSTZdU5fGhxLAur1RtWFcg/tpHqLXQR4lNThQXKSYYgRZyhjrDekvHf6VddTQT5hCFIUHsW0CCasBzANlmFvqzGJQaz06fOduClUq4xSJL2iirlvpq+sAjpA7QzBbaOwboZUEz5jtETIjT8kog/MRwjAZc0XyppqEZnlu+K7VsaA5xiQQj1GRBE/aXK8XmIDKIrFkYrPkDvFR8Sltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 04:45:24 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 04:45:24 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 01/20] arm: socfpga: agilex5: Add new system manager
 base addresses
Thread-Topic: [PATCH v1 01/20] arm: socfpga: agilex5: Add new system manager
 base addresses
Thread-Index: AQHbCys3BXDX8cmMF0aGdaYWqfn2prJiQ0KAgAQdeLA=
Date: Tue, 24 Sep 2024 04:45:24 +0000
Message-ID: <DM8PR11MB5592DFA8540E89B15ECDC125D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-2-tien.fong.chee@intel.com>
 <9eca93ee-0368-49b3-951c-6953d8b2a3b6@denx.de>
In-Reply-To: <9eca93ee-0368-49b3-951c-6953d8b2a3b6@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SN7PR11MB6972:EE_
x-ms-office365-filtering-correlation-id: 26d5bd25-0d8d-4347-1687-08dcdc53b45d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U0dVNEIwNGNjcjdHWlFQcDEvdG9jcXM1cTVseXNCaGR6bHd3YUUvWS90TjJP?=
 =?utf-8?B?WDV5UUticVJPT0o0dmVHN25JTHhvNFhOdlJ0RnlxSUg2VUJ4UWltTWk3dkQ5?=
 =?utf-8?B?UGp5RnA5ME16LzFxRC9kRUpPQk1UYXZTVDZFZlZRcVlHNnZ3NkhqYklRLzBS?=
 =?utf-8?B?SDRlaGYyMWsydkpBRkltTW9kamxNSEs4RnhidGJvYjd0alJ4YjduUVBubFF3?=
 =?utf-8?B?TW1XVDQvUVdYdmJWaHdKOStvemlXd2piVkZyM3N5VGR2ZWJMR1A4bmhFVGZM?=
 =?utf-8?B?TlJjVWxQMDBNMmErcVZVMnRZZyt5NDBSUHluOTdxSWhxSjVFWGFETHhrb2NL?=
 =?utf-8?B?cTB2SUV4aXloV0tMTzFSTHRZMjNQdXlJbUI2Ui9wZzRPRjZSNlRzcnc0eldi?=
 =?utf-8?B?bDhhSWlXQnduVENWdWlqS05KY0lUMkFKODZRR2ZheUx4cHpzb0lkY1ZxSHpa?=
 =?utf-8?B?dDd2UmtBWTcrQjJFaDUzSnZOeGZhaG1TV3p4VFZYTXVhOHI5Smk3M0dWSDNl?=
 =?utf-8?B?Y2gwUm8wTVVpeDVLWVpqSTFwTlhrU0tCM215aFFpMXhjbHpFc1lzOVZZYS9w?=
 =?utf-8?B?WUNLQWRNb1huSEZoa0dNTUhrOXZteEJ3R3hPSWZLMzk3N3hnOFE3U0hHQTJs?=
 =?utf-8?B?WmVCck1GNmJXZTQ2VmozQjVhNmRuNkl1VDAyeFdQK2cwSWsrRlBVUmpDcGlO?=
 =?utf-8?B?RDJIcmoybHRPTCtQOWtXRWR3YVVxK0JXc0Ztam1vSklmMVhxd3hVKzVMNXVX?=
 =?utf-8?B?bW40dXgwU1BHREZtSXdDMVFpZ0M4QXVtclNtUXp4NTZDeDRpc3NsejVXbldJ?=
 =?utf-8?B?SFNTd0VvaHZpSm96cU9sMkY4Q1hJM2c0dStzUkpsMVEzZ0hkaHQyb1hHRmpo?=
 =?utf-8?B?OHc2bFlCQlQxK0NQMkx3clljcTcwcG05WXRRamtlQWsxSzBIcE5IMGVKWU1E?=
 =?utf-8?B?MWM4NHFTTFY0U0k1bGZIWG5ERHBIamF1NjBxVTdGN1A2QzZIdmhYdG8wQ2F5?=
 =?utf-8?B?eUtzeHBKOVVJa25JM0dFQUhMTE9QRXZ1WENuSVBtcHRnVEpnb3VjamVKR2hq?=
 =?utf-8?B?ZktjNEVzYm1lRy9PNlhsR1FyUm83T0lYVS9XNHRvVEVXakNRekoxNHVDR3hZ?=
 =?utf-8?B?ZWdkelVSSVZ6U0hiLzB0eDhycmx2SjVmT3p0NTVmMXphc0xMb3ZUZVBkSGVJ?=
 =?utf-8?B?OWNnalJ1ZGxwY1cydmpsaUxhVElSVXpKU1E4ckNQUUZQMWl3OWJUVlZmT1hB?=
 =?utf-8?B?WXIzRUovSjZON2plUFo3ckVPbHZXTStiaXVlZGN5Z0pZTGpSd2VWSkdsUktp?=
 =?utf-8?B?QjRkRG0xSmdwZTRUMEt3N2s2RVFuaTRQZ2xzblNKd1BXb1kzVENuNHUxbkpz?=
 =?utf-8?B?YWpHdFlLQjhJUUU2S3ZZbXk2NytXTFF5eTRlY0YvRWJTaVZjM1A0QWdSTzBK?=
 =?utf-8?B?MDRaekViY29tdDJqUjNzcm1LVEdKZHNZbERmeFlnbThrTnJ4T25KYnh4Mnpy?=
 =?utf-8?B?SjZJbE1CZ3RzQWNxZk8wVTA5cStOalZ4RHZuTFZKNnJrSXhXUVg4N2F0YWE1?=
 =?utf-8?B?eVRPN0lpaGVLUFdqUVF5b0I5SXRsUytTVHRxZlUxY05JZDN1VEdXcFdnUFN4?=
 =?utf-8?B?ZnpjMXFEUU1zVEJibTgvYkJzOGpXT2V4TThlK2ZoQkFRMDl5b1ZQQWdVMWpH?=
 =?utf-8?B?dVl5MVdrb0lFem5yN2g1TStiaXE0N3FyRjRINXBKQUJaU1lpY01xQit5WjFB?=
 =?utf-8?B?NXhvZGl4YnIwa1A0MEZPbnRjaHM2WTZob2tzdWFpbDBKVDViT2dyU2ovb2Q2?=
 =?utf-8?B?Sk1qcHYxTUI4aWVWa2IvRWhTbkFCUUlCb1QzTS96MmwyUUdYbkV3MGZPRzFF?=
 =?utf-8?B?OEZQRE5SdElIQk9qNEJwRVhTV0xGdEZIWmF4SXZWYWhzY0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHc0dzBMRDlyTzZFRU1ZMS9YM2U0MEVtZjZ5OE5ITmcyTEkzR09OK1dyZUZF?=
 =?utf-8?B?NDJhbjNuVEY3MDgzUXlMYVRmZ3crbnlybnFXblBvanZBSUdpMTE1Ri9VOE9a?=
 =?utf-8?B?OHA4N2hGQnpjU0x0djJQYlMxZ1JxVnR4ZFhLK1lRNEVXTG0yOGpyeGYwOER1?=
 =?utf-8?B?WjBXbmJlTzArY0NEckJ0RzZPbHVNc1FuWEpCNnZrSFhPTUlidU9BVFFndXkv?=
 =?utf-8?B?dWZpcStmL29mMFBDNE96NWNyV3NGa01NdGNGYWVYelhsK0ljRk5oTFJLMU94?=
 =?utf-8?B?cFdXVzJRNGlNZW9MYVdYTW9JamxSK2FRM1hSYzdFdW96SGRFOFl1MlROcWo4?=
 =?utf-8?B?Q0p6ZzlGS21vSnhpOWZna3pReVh0SENIZkRQWk1PS0NoS2RYdDZpa0FjcDZu?=
 =?utf-8?B?dVU3VU90TDdNWVhoVTFwUWx3U0I5ZE5vbVMwaVVZVmxPeGpQeXlnZytqY3BX?=
 =?utf-8?B?ekMvZGlnWWozdkxwRjEzcnZDbHk3OW1XclRrVVBrVEc1bmhOYmJtTHFZMURL?=
 =?utf-8?B?YlFsZFNIUytJVW5vdDdtRHhmY29qT1JjVzJMaWwvQlB0QzY1d3NvTzhEVHMr?=
 =?utf-8?B?emYxVi9XWXVWeHBweU9mQXIxMXFVSUpiejQyUGJJV2lGYUhKQk5JekN1U0R2?=
 =?utf-8?B?clYxN3RuY2dKc3M1UGFOcFdPd0V1cGRUV0htYWxXdVYyN250ditKeDZjWHF5?=
 =?utf-8?B?bnhXUUY1ZE9tbGdFZGtvTHRRczMvcWNJSDRuMTFzTHJzYVhxbngxejJoM2JB?=
 =?utf-8?B?Y3NLeTI2Yk1uRTRTV2diTzVnakR6d0NPZmdsUVlraTFVdGh6MUFoL1l3UW5J?=
 =?utf-8?B?SFBEc3N1VGpmZlJOUFQvMEtac2h2UTNpRDNzYUdxWGlVVjhzZVJUMGU5ZmFr?=
 =?utf-8?B?U3Q0a25mOVlFdmdBNEJGZ1lsRTlFVGVRa3k2UGptYUhxL1BpSTdJRG5rQXRj?=
 =?utf-8?B?UUErT1JtYmdMTTZoalNHUTRZNzZsaFFtdGV2MlpuQzJXcDc0TnU5WHQrZFoy?=
 =?utf-8?B?ZSs2cXd6MjdhTlJZbFI5VzhZTDlxNjhmL0VETUdYOEk3ODZJVFNRQTF1Wlhm?=
 =?utf-8?B?cE05bXk2TFFaZzB1UVFlUXpJWmxvQjd3V0xOUlZQQTIzSkhOV1VDT3Z6OUQ2?=
 =?utf-8?B?UXI4bk00Mm1wY1dra0RHb0tSZko0N0M5Sy9Xem5GUUNld215OVBucDR3Wncv?=
 =?utf-8?B?ZW5HN2hyZ3UrcjJuK09PRjF4MzJGdmlZMEFuVjBHZlFKUFhpaDM5T0VPWkZO?=
 =?utf-8?B?T0haZFJxbTBDVnJUU0NVbW9Ec051SXZrWHplTFpjVEZJMi9zd2hjbk1sNFdW?=
 =?utf-8?B?NUQydWFmRU81QnplMS9iS0dYcjFIN2xOWVhNcEpEdVJza3hUOVRRWjlQVTdU?=
 =?utf-8?B?Tng3REtTemhqK2NhYUFyTS9MVTVlcEszdFZpNDJjNDUvUlJLKzZ2VnpRTWR3?=
 =?utf-8?B?dkwvL25PWnBEMVczZzMyTmdmZXFmR3hpUkljQXdaTEd5Z3lXV1EwY3VnMlRS?=
 =?utf-8?B?Ujc4WXUveEpVVnA4N2VzQzUyVmUzNTVSOHhpZ1VmVGRZV0pOMklUVnovczd1?=
 =?utf-8?B?T1hnc0Z1ZGFJejdyTStrU1VYUG16cUhscnU0dTJwbzFRMCtzTEdCNmtvR2lK?=
 =?utf-8?B?YzdkOXQwclNNRTdZQ0YzNWFMYnBtTlNwdittMWZKQlRkeVFJQ2NieFhPWHRJ?=
 =?utf-8?B?a0ZFWUFKOEdYOHJvYVkzc2ZIMjlNYzBYSEY3RjhTUjZMQ3ppT2k4UkVuSXIy?=
 =?utf-8?B?aVJKRHJ1YW52ZnYyM3FMWFVFVDhHY09DNXRWRzVHWHZLdWpmb2ttb0pXSGVl?=
 =?utf-8?B?WXFPOFNHRGtxYkpyUGJRWkJHeUZWaGFEYjdpU0I1ckFjV293c0dFQTdrdHJ1?=
 =?utf-8?B?cVp3UWIwS1k5QWV2ME11OHBncVd4dW0ybVJSYTdzSXgxZ0pORC9iYzFoeXlT?=
 =?utf-8?B?bVZqcTZHMUVQcGdzYytZcGgwYmt4OHdUbnhobkxVSURBUXY5MHloZysrYmZk?=
 =?utf-8?B?OC9PRTR2MGppQ25XOGdFRzJSbTFwTWRTTGRZMGkwL0xPMGlub3pwQkN1OUJH?=
 =?utf-8?B?aWpPK2NQb0FHdkxFcThCZjdvSDdFVWlSSFo0anR4U294bGg4Vk5hNUFpSm5p?=
 =?utf-8?Q?DTIXi1rq00LnIP1uH/ilMphQF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d5bd25-0d8d-4347-1687-08dcdc53b45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 04:45:24.5550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjLjcgSDhHWt1ocjYLK19tM3WTHuQFVyaAxp1wpnozf5PmiorpVqExKUlFZ850YCeYYtjmVB4OZePOdgSHTI7Vr4qCnPchGEAkEJ8OFhunE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjQgOTo0
NyBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMS8yMF0gYXJtOiBzb2NmcGdhOiBhZ2lsZXg1OiBB
ZGQgbmV3IHN5c3RlbQ0KPiBtYW5hZ2VyIGJhc2UgYWRkcmVzc2VzDQo+IA0KPiBPbiA5LzIwLzI0
IDk6MDIgQU0sIHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUaWVu
IEZvbmcgQ2hlZSA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPg0KPiA+DQo+ID4gSW5pdGlhbCBj
cmVhdGlvbiBvZiBuZXcgc3lzdGVtIG1hbmFnZXIgYmFzZSBhZGRyZXNzZXMgZm9yIEFnaWxleDUu
DQo+IEhvdyBtdWNoIG9mIHRoaXMgY2FuIGJlIGNvbnZlcnRlZCB0byBEVCBwcm9iaW5nID8NCg0K
WWVzLCB3ZSBoYXZlIGRlZGljYXRlZCByZXNvdXJjZSBpcyB3b3JraW5nIHRvIGNvbnZlcnQgdGhp
cyB0byBEVCBpbiBjb25qdW5jdGlvbiB3aXRoIHN5c2NvbiBzdXBwb3J0IHRvIHByb3ZpZGUNClN5
c3RlbS13aWRlIGNvbmZpZ3VyYXRpb24uDQoNCkkgY2FuIHB1bGwgaW4gdGhpcyBmb3IgQWdpbGV4
NSBmaXJzdCBpZiB5b3Ugd2FudCB0byBzZWUgaXQgaGVyZSBvciBzZXBhcmF0ZSBzdWJtaXNzaW9u
IG9uIHRoZSBjaGFuZ2VzIHNpbmNlIGl0IGltcGFjdHMgYWxsIGRldmljZXMsIG1vcmUgdGVzdHMN
CmFyZSBuZWVkZWQgdG8gY292ZXIgYWxsIGRldmljZXMuDQoNCkxldCBtZSBrbm93IHlvdXIgcHJl
ZmVyZW5jZS4NCg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KVGllbiBGb25nLg0K
