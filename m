Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD4CCF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 05:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4C3882BE;
	Tue, 24 Sep 2024 07:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H8mED3D1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6437D881C1; Tue, 24 Sep 2024 07:59:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E712A882BE
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 07:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727157543; x=1758693543;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VXXRpXs74EztnjyolCoTsMo/CGUP7XGcfeZS/jOBF5Q=;
 b=H8mED3D1dALoh5kqsKXbdAaPmj7posSptwbr4wDf5ocQcorxBwD7QUk3
 AJJlhD958fzzp+DXfJfCv/FuMSSZEw2zS+FgBnEsbdeRexMGQBIsjZkWT
 uRBLyXjOgBgLyllcGQHcG9zYogjdyZ6Fz0X+0QJQUEvXR8w7OplmvHfmL
 hn5yKVB3ng/XJe/tbUrpnfbyqkvcm6g6fAAecdP9yhp9sctnWPxQ6I1k1
 QwLR6u6oX+Q/fIy5LNfpbgWOjJllGXTBCZJ3SpK1TDcWWGAqH6chlgJv+
 GEpfqbj0mBV9HlwqjI1cgKOXbpZBdiOC0jZqv6RbEgmT808xh9gt1NCgY w==;
X-CSE-ConnectionGUID: 7n5eztAYR9aVfSSJGgOq0g==
X-CSE-MsgGUID: SqOhSqL8TPubiLVCBjzRZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25646640"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="25646640"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2024 22:59:01 -0700
X-CSE-ConnectionGUID: ShO7PPzXSWK9GhoPyXBiqQ==
X-CSE-MsgGUID: uZkQL61DR6+5QNMdWyrCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="76077956"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Sep 2024 22:59:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 22:59:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 22:59:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 22:59:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFwZ1CNCAxordA8dZGBsMsJ7bkcg2wJjjYyBQEsRw6xC/NrpxxXLrsOG3StCm6NPyz8hTHekWqyVwU6MDzhpGr+xlYolEjm31moid6CZqMaD0b/BWH6sAi+aw8P2V4Cq0GMOHSHxbpXmkzk0AAaLovd3OaQhWmqGsc6Rn//cLbO8fuHqv/f9I5/iTlI1Y6wiMCVZHcSCeiaUIWXjb0TyVRE7n80ExreUepVNNd+RYZDnPOvx9WkaJW0j6xI82rNFYKuVO3hndgLxXSxgd1bwCc1P5cee0WFS/rSjSEMjMMKgixxpPSqyzWGkLKQEoilexHH6/Z7CMDuj7omY+2IKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXXRpXs74EztnjyolCoTsMo/CGUP7XGcfeZS/jOBF5Q=;
 b=HWNBZ7TYo/TtM3MjJq0wi1/T6QRSWRtLlkYVOJ+HJOFG2yQHYkwJGoN2MKEO4kSBwzm58o2xIqWyVqUc2RfkPoLsXrjb/2Huy1gF/6OTnd5jWl3Vqny0jy6lPm1dIMmOe0rQiwrN3QlJ5OO3NxHHsdzovAZLGEfXety4OErjKxwXfVCWtLvs6op58ou7xEXOyD0YYAKvx3/VFUqVyMPopIIRAtG/Lkwkm00JQjRiMbl5OXewEAwzU69Gpglbijd8Z0ROysbAUjeItz/KQRS6LRbtBx6JlsBVf+RB5GcvGPNX5DOUQtXqRDTRH2H5LCxnC3XvYOJ0xKB//cV6fZQ9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 05:58:58 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 05:58:58 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 02/20] arm: socfpga: Add support for agilex5 clock
 manager
Thread-Topic: [PATCH v1 02/20] arm: socfpga: Add support for agilex5 clock
 manager
Thread-Index: AQHbCysy2wlocscw0kGQT+uNvUARDrJiQ2KAgAQzdTA=
Date: Tue, 24 Sep 2024 05:58:58 +0000
Message-ID: <DM8PR11MB5592361EBCD62F15E3864994D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-3-tien.fong.chee@intel.com>
 <a7abc927-57ff-4b0b-b636-d51dddca288c@denx.de>
In-Reply-To: <a7abc927-57ff-4b0b-b636-d51dddca288c@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CH3PR11MB7795:EE_
x-ms-office365-filtering-correlation-id: a8a257fc-ce73-4297-081b-08dcdc5dfb0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TC9JbVkvZjhPbzZhTTdpSHdpMmpwRHVJcGRpcUtMdnd2NmpWMkdEWklLTkg4?=
 =?utf-8?B?d3NYSTZWR3MzUWdIYW9HTzJzRUVVUVQvd1ZJVXZxNWpaeTBxeUZ5Zk1TY3lM?=
 =?utf-8?B?NjQycE9nam04ZU5HV2J6VVBjQ1ljVWFmYjJqYVZKSldyR1I5R2oyYndyWjNR?=
 =?utf-8?B?OTF6dzRCRDdlVEIweEFhaXUzUnRhc0hIQUJVUHNuK05VRlRsQ1ZteVpTUVZx?=
 =?utf-8?B?TnhvbUVqNHg2STU3Mk9tOVAyZi9BQUU1RFN0eWFwL0J2Q1hERmVYdHZVSTg3?=
 =?utf-8?B?V25RVE4vUU9RVmJPb2hqNytBOUtaWU9CY3JVdEJwc2VVclVhSm52OTdwVm9o?=
 =?utf-8?B?R1RQc2RHdkZOUjRGbDZ2RGxwSHFKTURnMXJlekFsS25CSnl3bjZwTmRLKzJr?=
 =?utf-8?B?U2sxSVRvaWZUL3kxV0pjOXRyVm5vbE81Y0FrRFpEVUpQbkh1bVh5a2VKZXNn?=
 =?utf-8?B?Ulg4STRaZnhQc2JXbmJiVVdhZGtKN1dycG40cnlLNitvK2pVWTZwcGVXaVhx?=
 =?utf-8?B?TVpYNEVmNk5aM1U2cXdrWEtGaVNYTSt0bHBWUnZrMFhrdCtQYVdOTzEvUmlL?=
 =?utf-8?B?VTIyVGg2R2U2ZlJoWUNIbkZEOUhIcWRzNFZwQkIydG5rdW1sUFZ0L0I3UVB5?=
 =?utf-8?B?V29WQ1FjNDJFK1ZRaTVEbnNFaEgzakRweVhzU2l0cWE0aFQwTGN1bzRzVWJV?=
 =?utf-8?B?NzR4MkNMalQwUDRZcXpOdVpvYy9mOUlNMnlZRFhxY1JRRjdDWXlweDVKVXJ2?=
 =?utf-8?B?OVp5b29RVUJKUHlxaXNaSWJ6T21XT2crL0p1YllYQTRZZlZpME03WFhRY2M4?=
 =?utf-8?B?YzIrbzRHTkFCeXJRTWVZd0ROazVtdTlUWXdxQU45NnhwT24wczFSY1pSL0x6?=
 =?utf-8?B?d1h2MGttaEtDU0hrUlNicmU4aGttQzR1cDB5NGZDTER1V3ZsbkxuQ2xKeVRa?=
 =?utf-8?B?WjBWNzR4WXNMV2puZll2aFlUZ3VmYlo1RkdIQWVyczBCY3YranpnbWw0cjNQ?=
 =?utf-8?B?SU9nT1dzV0R2T09CQ0YzSVZ6WGtsbVRqZU52bjZqYlVwUS9icTNxM2xJdGZq?=
 =?utf-8?B?VVhQVzF6dW1xVnRwbWdBZktsdjQzd0xTTkdxMktYSWphYU1WR2h1cFhySFkr?=
 =?utf-8?B?RERhcjhpUTJTeTBnTTc2TTVKbTJXRkNhUXYrM1BnT3RJeVh5aVY0RkM5RERv?=
 =?utf-8?B?WTBGT2d3Q1pLcjBUdW9iaHBwelJmamQvTDBJYlhDcjBtQ0lVNzAzTS9RUWsw?=
 =?utf-8?B?UjdnbVZpMng0STNpemo3VFNaOWZkK1BaQ3lMeGN5SWtZaEl5OGRBR1ViM1JY?=
 =?utf-8?B?K2Z6OWdvMmJSd2FRMDZ4TXBDL1YxQndWNVp6anBhV1JBeCs2VDZRTXJidUlF?=
 =?utf-8?B?UmZzWDBDNEQ2TEVrcFk5YlFxMVlPRlVJeXlZL3owcnZVQ2UzU0xCZzM0YWtS?=
 =?utf-8?B?MjF4M0pKYytGOFNRNHlvc2l2bENleGNtbUR2VzBwWGtpdmhBKytzTU1NVEU1?=
 =?utf-8?B?ek4rZFdoeEtGOEpmUkdlU1d0REtSVGhWZ1FkajFaZEZpditvRmZLejduWHJp?=
 =?utf-8?B?ajc0NTJWVWl0QU5BampIT1pnelo2MER2bkdNTW04NnBkalBWeFZsNGFlNVF5?=
 =?utf-8?B?NTNtTlFPcnI5K1l4bnZlV0w2eTJuR2QvK1dFeFFvSlRlQ3Y5YXhtYTBxQzhZ?=
 =?utf-8?B?Y2hVdDNOWlFYREl6RmVUSGRZa0ZvWWV6RzRCUHdjajBSSnp4SVlMWkZ0VG9q?=
 =?utf-8?B?RDduWk52MEtaNHV5aEVUeHUrUFF3NXpiZmV1ajFrRndXbkJhYnZSeDlXZWRW?=
 =?utf-8?B?QWRuaDdMNXdSMXYvWGVSenh4cDEwWXB6eWdQcnE0bW1hWHZ5VEV0ZmVWajVw?=
 =?utf-8?B?dTVtaW83U3U3MU9FcDB0N3RJTE9SOXBBMnFvQ3YwcW9oZXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU1IVTQ5bUt3T2F0dm5ieUhGWTE5TGxyZ09XT1BEMXlpOHErdEFMcEtGRmhN?=
 =?utf-8?B?ajhNRWhNK0NaL0cvUUZVSUhZMzlMYzN0MHV2Y2MwV1RsdS8zcHEyQ1FZQ2Vq?=
 =?utf-8?B?UHFrL0JUNjkwVEpNTFVPa2JzNHUreEkwenN3ZWVzNkY4Z3JUbktVQW4zUWNV?=
 =?utf-8?B?ZXp2M2dEdllxTklxcmp6MEtTMVQrVEJlby9lM01hRW5RZ0paZHlDU1R6RHV1?=
 =?utf-8?B?VUxNdkpBZm5qT1ZlQ0YwUVJvWmgwbUNJOWw4Q2pONWZNTDY1ejVBN0M3KzIv?=
 =?utf-8?B?b3BLZ0NvVEI0QURIQXBvb3Ryd0M0eVpKNVk3dS8rYjc0YkVWUG9YN3RBelA2?=
 =?utf-8?B?RVpSd01EL1RHeE9ZL3dWcVAwdGxtZGxHVWxESXM2RDJXRnplOTloZy8zREIx?=
 =?utf-8?B?MVlESkhZVDhoUTM3MlZwdnQwUU9XekN2eDk0NmY2WVNYOXYyUXA1U0RFTlE1?=
 =?utf-8?B?YlhpL094djBkOUR1WmZYbGx4SEp4ODdlbjNrTjN2UUlYMEJRYTQvR3llNU9L?=
 =?utf-8?B?YjlGQjNJRFhjNFJ2dkkrVjlVc0d1R1JOTVhmTERqdVlDSzdhQkRYUmRlR0cr?=
 =?utf-8?B?dTNRM1labnRvTDhBOFQvbENSbFdEOUFxY0VIb1VVeWFOUDh3Y21aL0FkVkVh?=
 =?utf-8?B?dmpVWHd2MjBsVDBEaVhGa3I3b0tjdkVJdWIwMGJhaEE1MUp2QVdSYjFjdkVT?=
 =?utf-8?B?SVFJK3hNVFpiUmhPK1dOSC9HaTNuUGlTclpsYjNoR1Rra0N2NUx1ZHNCWWhr?=
 =?utf-8?B?Rkw5UktmNGFZRVFocUJaUmxJcitHdGQycUtsNkFxQVlWVXBXZW9vQzM1eXBx?=
 =?utf-8?B?STNiVndDdUFPWG4wVFluMEhoTk51QWo1QXRiRzFNcGhVT1gzUjRPNkR6cUF2?=
 =?utf-8?B?a09tYXlqck53aTNnTnkvc2x1azFPZjVUSTc5dDdqWnJzQUtuTDdaZExQb2cz?=
 =?utf-8?B?TFNzWCtJL1JQNy91VDh3OVZ6VmNVbHJJZFN0d2hsdEJ5VkU5WFFwdXVDZjRZ?=
 =?utf-8?B?cjRWTDFYa0xvcDRMQlBaeWdBUHFFWDFPWEV5TGU3Rk5iUHcwOWtNdFpyLzlz?=
 =?utf-8?B?VnBwSmx4dEsxUlBwTXhoQjZ0MU9zbDFadUZucUl1dzNtMS9Vb1V3K3kzRzlm?=
 =?utf-8?B?aTZrUm5ZYnBIWTVsMWNuRVFlejZ4R000MmdQVyswUVdadWRLV1NsR001WU1K?=
 =?utf-8?B?ZWQ3TE1Fck5vQ3Nhc0JFT2VVQnRJd2Z3L0RzUWlmKzEzd0tUeFRKMmtDa3Zh?=
 =?utf-8?B?UVhFTmcrZStyWndjakJ4SkhLSXk3YkV2a055SlI4SnZHQWM3S3JwSlpGWXBy?=
 =?utf-8?B?WXFURTBUMlhBck9jeS9NVUFKcHd2cjN3a2REMkxicmt1ZWJIWDBhQVdySUhI?=
 =?utf-8?B?ODVONklOQnd6VVJETU9xTEg4eU56K3JxU1lxbjRmL013OS9wUFIzVm9jQkFU?=
 =?utf-8?B?QWxUcjBla0xiY1BMN25FZFZoMk9ENEE0c1grbVdVSXZwSitUY1VLQU1kQ1la?=
 =?utf-8?B?Q3ZiMjd3Q3hSaUFkN3lSV0JFcVZlb2FLV3pNV0xjV21FZ3VXeVYvb2J3bHB1?=
 =?utf-8?B?Rk5yTTVEVzBrcEFheUI0b2FQbS9maUt1dGpkS3dlVXdway82a0w5am1qMzF0?=
 =?utf-8?B?QUJZemx3Wk4xbzhpeVJ0Vk5EOXpWQlBCWTVuVEdDeGlZakg1Y2xaZGY1U3dk?=
 =?utf-8?B?bWdNR0o1SDdDRWoxcFpNbDNCM1dZRGkrcnRDMVh0SEpJYnJ5L2VGOXhSZTF2?=
 =?utf-8?B?bThoREJacE01VTZXTmRzaHZZeVpVSHdSRGE3ZDdZQTkvTE5PWnUzSkFLaUJQ?=
 =?utf-8?B?amYyTExWL1RoVWxtdllSaUkyeXhSWGl3a0UwdDU3aDdNTlRqUzk0ejlrWVBu?=
 =?utf-8?B?K3BKY2NvVjBKRS9OaGN1Q1JmQTdZV3NjN0xaVVBQc05ORCt0cWNjSDhPSGla?=
 =?utf-8?B?dTIyNzI1Q0ZqTWJPWGtqTVluRjhpNW5McFNDaXdONFBSZUVXK1BWbkFWMFY2?=
 =?utf-8?B?NEJ4RDdWbGJtU2ZEbFcvZHd0MmJVZHI3VHRzWG93aVdZRmFiM3Y5QnkwM0VN?=
 =?utf-8?B?TUpIUW9xMHpjSm9wK25PV3Bpb3FyN3daZ3l6NXBCRHZCTlhmWmtiMDMvZTVt?=
 =?utf-8?Q?2sQtBSHMZ+91tFv4Z0l1/NfVP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a257fc-ce73-4297-081b-08dcdc5dfb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 05:58:58.1542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TE5Q7m0/ychQoSwgk8GYFtPXjvZWgJT9fxVmQQVSEZepWtH8GkcsZKOl05JEr59wbvRmAsC2aZXsi9K/MSuRHHmTXIBKf0yxwiVxB7L41Xs=
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjQgOTo0
OCBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMi8yMF0gYXJtOiBzb2NmcGdhOiBBZGQgc3VwcG9y
dCBmb3IgYWdpbGV4NSBjbG9jaw0KPiBtYW5hZ2VyDQo+IA0KPiBPbiA5LzIwLzI0IDk6MDIgQU0s
IHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUaWVuIEZvbmcgQ2hl
ZSA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPg0KPiA+DQo+ID4gQWRkaW5nIG1lY2hhbmlzbSB0
byByZXRyaWV2ZSBiYXNlIGFkZHJlc3MgZm9yIEFnaWxleDUgQ2xvY2sgTWFuYW5nZXIuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUaWVuIEZvbmcgQ2hlZSA8dGllbi5mb25nLmNoZWVAaW50ZWwu
Y29tPg0KPiBDYW4gdGhpcyBiZSB0dXJuZWQgaW50byBjbG9jayBkcml2ZXIgYW5kIHByb2JlIGZy
b20gRFQgPw0KDQpJIHdpbGwgcmVtb3ZlIHRoaXMgcGF0Y2gsIGJlY2F1c2UgSSBqdXN0IG5vdGlj
ZWQgdGhlIGNsayBkcml2ZXIgZm9yIEFnaWxleCA1IGlzIGFscmVhZHkgaW4gZHJpdmVyIG1vZGVs
IChEVCkuDQoNClJlZ2FyZHMsDQpUaWVuIEZvbmcuDQo=
