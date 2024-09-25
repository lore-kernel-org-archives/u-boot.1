Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652A1CF9C6C
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 06:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1B988AD7;
	Wed, 25 Sep 2024 08:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cHMoc0gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885B588B14; Wed, 25 Sep 2024 08:13:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B01A86DBD
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 08:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727244811; x=1758780811;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XvQnHS/y0ATrwAZal/Hq2KSD2R8Apbd6DIfW0v61ACk=;
 b=cHMoc0gnbKY9wB6sPe/8uxNjOC+rm46W35HfVLS0RIYFO7RsyXrYy5WY
 cXU2h74GI8riJU5kfqKHXbvVqVzOZGtu7URZUMedVlv8X3sAMFP92u2Gv
 UN9FaZ535jj5+qCYxajyx/uacLSiWIfhhruBNTL5g93AW50z9vP9q758x
 DLQm2xQnwfgdMZQLiO8GIxv1O3tHyV1a3Ep6U4AuZEKeqA1+G5QYY88LT
 wqHj9fNXMYdKKio4OnB+bQj2tMHQXamHfy0Tv1O1szuLjVqCVDOz/+YeD
 aSnC1oqmyDix65GZQ5QPMgfejQiwpXjvVA9BiSWhLkKsqwE+Vzic/wt8O Q==;
X-CSE-ConnectionGUID: Q2qgyNwLSJS17JNXx2yhjQ==
X-CSE-MsgGUID: 8Dzvn4OOT3auFezw0s/i/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26143339"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; d="scan'208";a="26143339"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2024 23:13:29 -0700
X-CSE-ConnectionGUID: 6RKcn8xUQRWq2djMjhFShQ==
X-CSE-MsgGUID: VC5CqtM9TRe6lh5uXfMLDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; d="scan'208";a="76058163"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Sep 2024 23:13:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 23:13:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 23:13:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 23:13:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 23:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNAy8yfVgoJOAf2HrA1L4yZ3H61JBfNsVHdxGoVNy08fQRvaaqmEjcD6JN8+cheSjaQP6nujpRTvuGbuZVXl1zrlOg67CzsL1oNeVT8LGJO31dxbXwXL99rc1z1OvZB5K0yaZ6h+Eo4kJvIJOEM6CtjiK1QFwDzGSkzkk4ijiAivcx0iBiDkUc39+g1RP5RdoVZ66AEA2qyT2F3JUfCkVhQwV0+De++XWKEiWrx8eDfFAtaMu2LEdp3QZcpqhb+VddB3Mue/ago8aA7lmjZd1cIJdfMHpfUHbhFSshSkfoazY91HIqobZGt97VDQE3iZbh8GPh8WIgbc6Aqh9YLsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvQnHS/y0ATrwAZal/Hq2KSD2R8Apbd6DIfW0v61ACk=;
 b=y9LpaeV845dcylsi26l1MnADOxgBE/DrS/8A1o2s+PH51GAs3blceUisL54AUvS6wmOEcArcZpH+ExhOO/tt/INmLJjRrBevo0ruhWzaACw9OhbOOf84fuNFSVMLijVtoVwjJHfRhKkE/4YWeRwpzMzpl7PYzaDAjqxeBNyaStaLncFNw35va73TJShBUXFMXEQtggWZHZBuErvr+ku9ymodZHo3TwTKElNAEh8q5WVDdP4ZW+RMK6uzqkSWqlbGHrgr4zvTntZi4GtVPRuDBxRdbO1SwpVXcTHjWr+ND+CXi5L8znJpJbCvZqcBzfiiIzQasfJF1flRPajVOlEvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 25 Sep 2024 06:13:25 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 06:13:25 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
Thread-Topic: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
Thread-Index: AQHbCys595Xy+QfqzUelHQSJaf/ZbrJiRCeAgAQzT+CAANNsAIAAwW4Q
Date: Wed, 25 Sep 2024 06:13:24 +0000
Message-ID: <DM8PR11MB5592C49308440E5F902A4F1BD2692@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-9-tien.fong.chee@intel.com>
 <92fa9c17-bbf4-49b5-8d7c-4b7d06f60736@denx.de>
 <DM8PR11MB5592C2455A4CFA9CDE0F6DD8D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <5db7f491-e8f2-45d0-baab-fa309cb4db64@denx.de>
In-Reply-To: <5db7f491-e8f2-45d0-baab-fa309cb4db64@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MW3PR11MB4619:EE_
x-ms-office365-filtering-correlation-id: 5c868c63-917d-4724-4abe-08dcdd292a1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZmkvZVZzZFBtVUdHdHNaVGhNZUduNTlhQXlHdW9mZGNoMUR1UGVmdFlPM2Z1?=
 =?utf-8?B?cWtWSE1VVk5QL29BTnVYNkw4b1JvK2FHMXkwWS9zUFFwVWpJTml6SDQ3VlJa?=
 =?utf-8?B?emVrdTJoeWRYZXRHcEJKT0oyM1o3NWI3bHNKWkU1c1d4TXAycmZWbTNGMSs3?=
 =?utf-8?B?VHQ1THkvb096RURyaERQUlJkakVJTVZxb3J2OGd2anVqOWVxWWw5Z0hoa1VS?=
 =?utf-8?B?VUh4aHF6UkJ3TWpLZlRWT1I2Ym10a0hURmRyOGdKenhwNGkrT3MzWXZVSnd0?=
 =?utf-8?B?RlBkOG9mRnJuQ2lBV0R4NUozdzZiaGxRTHh0SEUrdlIranVUZHplNVZaSUFt?=
 =?utf-8?B?dXB0MkRRVWdqcllrTHJhR2RRWGVaMm9qRTZ1UlNtemZQSnhmbXB6dnlxNnVM?=
 =?utf-8?B?VFF0bzRnTWNud0ZNdlROWHoxU1ZQeXJTYkN0U1l3R1N5d05qTERxbUM3VDBm?=
 =?utf-8?B?MXBRVGRQQ0Z5MUtWMisyMS9qWFRRTUp4U2FqdVdwa2RISGpBSWlJSE85a0ov?=
 =?utf-8?B?MkYyaVJnYVNOcWowQjRpZzRSVU50Nm1URmNCRXhzamtkQStKTVVOREwybzBl?=
 =?utf-8?B?bVAzeENuRkMzUENKazNHdnI4WXVCNGNnMHNWRGJTS2oyR1BoMjJ4cS9VTjh6?=
 =?utf-8?B?UjVFNDBJWW11MlMxYktBSE8wNllHRHFjZTNZcEJpYmhSMU4xUnFiMUZQb0F0?=
 =?utf-8?B?aHNxN0xZMFhITXppVjhXYWFBQVZXbDl5TjJhLzNrK1VzUHRJc3k1ZXVzbnlo?=
 =?utf-8?B?QVh6RFFuNmNFdTVmcFlhTnAxbTdFNFJ6WUVNM2JWM0h2NkpDajZQOVJ2elpo?=
 =?utf-8?B?MXk3UjlrNGVpRHhBanFhRnhva1B0NkQ5T2d5WS85MVdmUzhBVVc1dTZiUDk5?=
 =?utf-8?B?bWF1L0xDeUpLQml4U2NUbFN4VGdtSmEyaVgxKzE1NFdxd3RqeGdUem03eVh0?=
 =?utf-8?B?VmJ6YkVVUXVhazgxU2hETFgwOC8wRnRyVVVjb1ZRSVRQaDdqYWcwQnVYUzYw?=
 =?utf-8?B?TlludFNGSUtGZ1NObjNKam56dTkrVEI2Y0lTQUQzQUFJNCtSVmpOZlgzSEtK?=
 =?utf-8?B?R3RXYmtJNUwzS21uRUI4MXB0RjFzVFZVdFVxMHZXYnlhVnEwQUdCdXoxeEV6?=
 =?utf-8?B?SE1KREFETTRzbTRzbStPRTBWUjlsSnNDTHd4LzVRNk12OU1WREFsMlZqM0Jy?=
 =?utf-8?B?a2JGK2ozT1FNOGRLUTgzanYvUkhTVjFES1Z6L1hmZUdPYklLRXJlQm9meG0v?=
 =?utf-8?B?ZnB3VldSUXB3QTdFNGJNVGYzbStmWXdKdjcvRkRhcmRpT3VBNUhTLzZNZ2Ux?=
 =?utf-8?B?TSs5b2JiVW51SllSblVDRndOdWVvOWZaeUdVZmYrM045VkFHeER4aDI2Nzgy?=
 =?utf-8?B?blZ3MVhJTjlrSGdwMis2OWh2ZXp2aTV4d0NRSUp5cnJEd0g2eWpoRDZ3ZzZm?=
 =?utf-8?B?N2grOWpYVDA0UTNCb3k2ckpLWUI5empoYVBTeEQyaDh1bkNYaGEzc2JQazA5?=
 =?utf-8?B?amNZcmxKNnhiWW1Rb3hYVlB5bkk0aGxWMXI0RE92U2NwYWl6QWNPZU9aYlBu?=
 =?utf-8?B?TStzUjlyRWVyNHVPK1k0RGFCTU42N2NVODJ0aWpvU211ckMwQ3hjRElIMVBX?=
 =?utf-8?B?YkNncEQ1d25YT2FSRzR6bGtMNC9RTCttUGFETmtranRVa1d0ZDNOMEQ1NzNL?=
 =?utf-8?B?dDdMQVp1UEg5SWpkaXI1czN4UllKUnBTMXBVcFp6YURTZnN1UHNja2hFM0Jk?=
 =?utf-8?Q?00IsUQ0sIz4Ers0CoA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b05tZlcxVnU5aURmSlk4Ui90eDV1c2tsT1pRRmR5YWo4YVUrczJpQSt5b0F3?=
 =?utf-8?B?cFgzS3ZxQ3IwZURmQUVFVXpSN2E5Zy9TblFIdGN4M2NmVWNwWDExNUxMZENZ?=
 =?utf-8?B?U01jRVFOaFlFczAzM1d1NStGNS9PclNWN1VSYjlOMEpOTDJadDAxVVg3bk16?=
 =?utf-8?B?VVk4NGtZREV4cXpZdXZYNElXbmVmcWlOcENGWGErYllReVFuS1hHSXIxaEtP?=
 =?utf-8?B?eHgwVEhhNnhYSlI2dGV5aUVHK0xYZzJzN2M2OTBMOGFjQnozT2JBMkxVOHIr?=
 =?utf-8?B?TWd6TzhEOThYUjk2SmVaQnZyNVQ2NmlYc055Z2VDSE9XUElEVzZ5bm1YRVNz?=
 =?utf-8?B?VHJVYXh6SDIybTM5dGRob3ZDcnRveE5rZ0h3UmtXaEt2RDdBNVA1b0JvZWRP?=
 =?utf-8?B?WnJkenlNUDRpY1VhOXYwRUVPdHlJY3REVk4rN0JBOGVyQkZYY3Z3dGhqVDZE?=
 =?utf-8?B?MVdtSEZuTytSTzl2OVVyQW8vVHBWcmpRVE0zamZZbktaY21FQlFsTDMraXQ1?=
 =?utf-8?B?YjloYVhRWDFBVE1Lei9lak1vdVd4RkkrL0hDWjlvZ3BBNk95azI2Zy9TazVR?=
 =?utf-8?B?Y0N5VzVzcTcwZlVaR2dtVXEwQ0tYUGR0bUUwdStJRkpZZnZjVUFnQ2tSRG95?=
 =?utf-8?B?b1lEZ3dOWHhJQWIzWUpUU09IK0U4WTBOeXVqVmFBVVdJV0R6aythVy9LcTJ3?=
 =?utf-8?B?Zjd1TC83UGFGdDcxUFlhSUViUU1Uc3ZXcEU0UnZ4Yi9zbXVqWHB1WlFMQ3Qv?=
 =?utf-8?B?bWpyQnJYOEZyM3l3U0grS1NEVWJOcVd2MmRmMnVYNWNrempIczBZd3dxdFBs?=
 =?utf-8?B?QUhjS0lYNzlvV1dGTDVuYUtpUlQzQVF3QjF1aWZlaFJwcFplS1RkNHFQVnVH?=
 =?utf-8?B?MVFHYnJBUWRVZVVydFcrclhuUzMvcjA3SXp4aklrSzdyTnBENXZXcXFKQkJl?=
 =?utf-8?B?c3lLYVV4UlB6SEtzczlLcFN1V0tFRWM0dGpTdjRDTC9uaUVqdmV2NHZ3dkg5?=
 =?utf-8?B?dnJrazRvTkw1UWdaV0cyOXltTEhKTlRYMEw2ZzFWSW5XUWxFNXhpK25XUld5?=
 =?utf-8?B?bzZWc0tFODZQMTNrUzI1MUFIenJsTVArSnkxVVVIS0VSbUZUQ1lFQkRKWW1j?=
 =?utf-8?B?MVoybjlVL1IwdWoyWWZjakZYOWlYWW9TQmF1WjY3M1lPbS9uUzU0dU9sQ0xO?=
 =?utf-8?B?ZVk2MDNrdCtoTVREbzg0SHl3QkcwT2RRRW1XQktGVHJOZk5IdFhqR0FIRm9h?=
 =?utf-8?B?Q3pBUlN4bkwwZkMzT2NOdCt0RHNDZzlnUnRkWTFHeXdVbjJlc2x0YlVidkNa?=
 =?utf-8?B?bDd1My8vVEV6OEc2VW9vVnJZZEhxTkpsbFZpQkhHc2xDaVpLVWpKT2svcVlM?=
 =?utf-8?B?N0MrbTViRHJEZEsybE9xWjVzWWJYcGhVdDBrUFFIdDJzWHB5N2dnc3dqenRV?=
 =?utf-8?B?NXFaUVJPRHdqQWtUa293YVUvZEVRdDlrdjVScG5tTlFzRzRMRTFoMGZ5NHI1?=
 =?utf-8?B?NlpNL3ArOFR6SW5LTVRSU0xKTE5GTFV6Z2F5bjZTNGxvbEdrZ2NDWlR3WkFK?=
 =?utf-8?B?SEdrOUxKelREM3Q5YU5tQXozM3h3b3lvazlQVXBza0Z3ZmVpa01sajRSVFJ2?=
 =?utf-8?B?ZS9nY0tyUDlvNC9SUWFWb3J3Sk4zakkzL0pvSC9rendoS2tkK0pQY2lPazN4?=
 =?utf-8?B?VXc0MkZTQS9rd2xnZ2NrU1FVQzZBZGlZZ2FDbDJqdkV0U3lGVGRZOWltOG5G?=
 =?utf-8?B?RXN3bGJEamFXcEtGWnA1MnI2Q1k2RHdkeWpkTGRUckhkVGoxVG1lYkxyUDhz?=
 =?utf-8?B?bnRMdXVOeFRObE1OaENHRTg1VWUwSzEwUXBVWGlYdUxtbXU5Nkx2cWZBUThW?=
 =?utf-8?B?bkl2NEtZQ3pEOVcraVYreFlVOHI4SHdkV0xwZlBLQU9pYUlDTFo5K2JXcVY3?=
 =?utf-8?B?VHo1aW9LL3QzOGFyN2xTQkNGalkwYzFVNTRzQnQwdXRYZ0RDcHRNZTBmWGJk?=
 =?utf-8?B?bEdyQ3VneTBpeTZlWHZmYXZ3Wm93VnVqUVVQbVNkMGRLbkJMQzV5R0hQWFVP?=
 =?utf-8?B?d1drWGlsRFBIajF3SFFnYStHZEQwR1EyTjRKajJvOW12SlNuOEVCQ2Nrd0Zk?=
 =?utf-8?Q?6bWaB88egJk8gQoK+oy6Tc3VW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c868c63-917d-4724-4abe-08dcdd292a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 06:13:24.9112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OykKiowJOpb+fvzJSln2RmJo65pfsiGaZF9XCLg4WewStfUDxxSKGMKjo1dDHUa+EfvXNCyxU56m3vM3k3eTeHpk48Exa/pZUr1ELgNBz30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI1LCAyMDI0IDI6
MzYgQU0NCj4gVG86IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsg
dS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbW9uIEdvbGRzY2htaWR0IDxzaW1vbi5rLnIu
Z29sZHNjaG1pZHRAZ21haWwuY29tPjsgTWVuZywgVGluZ3RpbmcNCj4gPHRpbmd0aW5nLm1lbmdA
aW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWlt
aUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMjBdIGFybTogZHRzOiBhZ2lsZXg1OiBFbmFi
bGUgWEdNQUMNCj4gDQo+IE9uIDkvMjQvMjQgODowMiBBTSwgQ2hlZSwgVGllbiBGb25nIHdyb3Rl
Og0KPiA+IEhpLA0KPiANCj4gSGksDQo+IA0KPiA+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0
cy9zb2NmcGdhX2FnaWxleDVfc29jZGstdS1ib290LmR0c2kNCj4gPj4gYi9hcmNoL2FybS9kdHMv
c29jZnBnYV9hZ2lsZXg1X3NvY2RrLXUtYm9vdC5kdHNpDQo+ID4+PiBpbmRleCA5ZWIyMWQ2NTQy
OC4uNzVhYjA1MDMxYmMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9hcmNoL2FybS9kdHMvc29jZnBnYV9h
Z2lsZXg1X3NvY2RrLXUtYm9vdC5kdHNpDQo+ID4+PiArKysgYi9hcmNoL2FybS9kdHMvc29jZnBn
YV9hZ2lsZXg1X3NvY2RrLXUtYm9vdC5kdHNpDQo+ID4+PiBAQCAtMTIyLDMgKzEyMiwzNiBAQA0K
PiA+Pj4gICAgCWJvb3RwaC1hbGw7DQo+ID4+PiAgICB9Ow0KPiA+Pj4NCj4gPj4+ICsmZ21hYzAg
ew0KPiA+Pj4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4+PiArCXBoeS1tb2RlID0gInJnbWlpIjsN
Cj4gPj4+ICsJcGh5LWhhbmRsZSA9IDwmZW1hYzBfcGh5MD47DQo+ID4+IFNob3VsZG4ndCB0aGlz
IGJlIHBhcnQgb2YgTGludXggRFQgYWxyZWFkeSA/DQo+ID4NCj4gPiBUaGlzIGVuYWJsZW1lbnQg
bm90IHlldCBpbiBMaW51eCBEVCwgSSBiZWxpZXZlIG91ciBMaW51eCB0ZWFtIGlzIHN0aWxsIHdv
cmtpbmcNCj4gb24gaXQuDQo+IElzIHRoZXJlIGF0IGxlYXN0IGEgcGF0Y2ggcG9zdGVkIHVwc3Ry
ZWFtID8NCg0KSGF2aW5nIHR3byBwYXRjaGVzIHBvc3RlZCBub3cgaW4gTGludXggbWFpbmxpbmUs
IGJ1dCBnbWFjIGRldmljZSBpcyBzdGlsbCBub3QgeWV0IGFkZGVkIGludG8gdGhlc2UgZHQuDQpo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvYXJjaC9hcm02NC9i
b290L2R0cy9pbnRlbC9zb2NmcGdhX2FnaWxleDUuZHRzaQ0KaHR0cHM6Ly9naXRodWIuY29tL3Rv
cnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2FyY2gvYXJtNjQvYm9vdC9kdHMvaW50ZWwvc29jZnBn
YV9hZ2lsZXg1X3NvY2RrLmR0cw0KDQpJIHRoaW5rIHdlIGNhbiBkbyBhIGNsZWFudXAgaWYgdGhl
IGR1cGxpY2F0ZWQgZm91bmQgaW4gVS1Cb290IGxhdGVyLg0KDQpUaGFua3MuDQoNClJlZ2FyZHMs
DQpUaWVuIEZvbmcNCg0K
