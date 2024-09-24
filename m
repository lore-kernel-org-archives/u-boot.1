Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FCCF9C72
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C012881C1;
	Tue, 24 Sep 2024 08:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ELQAkAVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2084E87705; Tue, 24 Sep 2024 08:03:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD388841E
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727157792; x=1758693792;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sjqatAC0AtZnya8gP0oFVjOufWDoApORxNTopj2vpPE=;
 b=ELQAkAVhMTop6uqYu22+QqfnAWh0sDL3QIsnY9MCX/bslZSU8VGdyuLc
 wGcIHRySj4HZREiSKgc+TtXEsZxfocVGwb7wrAFyksl49z6YlU3GAmgg/
 2fggN0TIdlzFWP5R1MmTo5Rc0KmrtgwZF4MEb2AFuLq5fcm1UCbhq4LNX
 W/Y9F7+WbEddtTIJoe0Ul1X5MqRLLr0OvRwyN/fASkR4H0yJljEX9utke
 ZgtSEL+GqksFbdilZGvVyMrVGJwELxlkCpow4o6/oho3RbwKKpESuwbkX
 /zSLf8PoTs+Yewu9b1a6g6Ioc/3UxrERL2cEB140kaZhcciAe6orALztS A==;
X-CSE-ConnectionGUID: CK0YC9ABRBS5oNrAPLuJvw==
X-CSE-MsgGUID: QHjN1MNvRQ6Jar8Fj/Jc1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36718605"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="36718605"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2024 23:03:11 -0700
X-CSE-ConnectionGUID: FcsRkxnXSQizub/vce5xxw==
X-CSE-MsgGUID: SDSw+yx4Rky1MDG4jgXnqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="94642332"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Sep 2024 23:03:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 23:03:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 23:03:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 23:03:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 23:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULl6hEWSkckWESXgUPUMm4928v7nrOlhzCECLUz9Jjr+qL1NvZQMS85msNeXpGUmg1cudq5tkDTb0qj9Embfzel+eisNQS/4mgZZ+php4RfR3PSctzV4lCYxA4YFToQHE5VZbyon202Hr3tS5NKhICzl7Pq7xl9PLmiWe5Y8Gm69apxyNCbTdJnI19pQibTjdfomW9DveN3FQkb3gUcDx6JErQG2rrkeZiyZLaRLCSROZgqQ+u/H2AHi1Fboaea77CpB+BEFEC47z+BrSd/zwOzdtdhyQm1Jpr7GkqL19JXZnfggJUa2XF4m1UHBU9qm68dZouaxSqHCgB8nt/KVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjqatAC0AtZnya8gP0oFVjOufWDoApORxNTopj2vpPE=;
 b=ZkP3zjqz5ndTnDs+ilTmF8imRdyKOp5QhPpr7OvB/yPcuEK7MqfjHk/oU0Bvq3eBLOnImwfp/qkJYxCdzjnbNJ73OI4v/xZQytv1dwEa+VIbke9Y9P1bnf6qRAsdW/ZuyOhDpvj9slS2yQjzRN2NVxh6N0iFouZc97z5tHMac+xur6EFDs8FHbu4Z2FrmWi6BMHUDsIo/PGbtPiV5vjrTEsYlizvjsg9ZcDr/q4wayWNkUTrlZBlq76//IvqdGTuNYTov7uuHUXr/AZmvttPUeylYXacsud7Qxft2sUH3oQs0ACYFMnk8+D58sO4STSkR+hN4G7hkhYr9nFkeV0Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:03:07 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:03:07 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, 
 "Rao, Mahesh" <mahesh.rao@intel.com>
Subject: RE: [PATCH v1 15/20] arm: socfpga: smc: Add memory coherency support
 to mailbox command
Thread-Topic: [PATCH v1 15/20] arm: socfpga: smc: Add memory coherency support
 to mailbox command
Thread-Index: AQHbCys+0Kk0GlOpdkGVODk7Z33Wu7JiRnmAgAQx58A=
Date: Tue, 24 Sep 2024 06:03:07 +0000
Message-ID: <DM8PR11MB5592F3DC00863BA529C2C2C6D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-16-tien.fong.chee@intel.com>
 <ff0e3d55-52eb-4dce-bcf4-04a6a5930d1e@denx.de>
In-Reply-To: <ff0e3d55-52eb-4dce-bcf4-04a6a5930d1e@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CH3PR11MB7795:EE_
x-ms-office365-filtering-correlation-id: cb5b1848-1848-4abc-f8e8-08dcdc5e8f96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U25YZG9kR0R3UERsa2UzQ3NXVWJEald4T0twZGU5SDJLd2VzcEdyUk56bXp6?=
 =?utf-8?B?ekpoQjNDSzRUQlI0QU9ZYnhsSWNFNjlodkhkOFRXSXBSakFsa21zTW43TndE?=
 =?utf-8?B?N1Y4NFZIRFA0UzNJalh0TVlnWkdLZnBFTGdKL2xJVkt6aytVYlRKME83YlhD?=
 =?utf-8?B?RUZ6elhpNXBWUXJ0dk5qdXZiUUZlWVpuaDgrVU5iQTRxYnpiWnlyanZBMFFq?=
 =?utf-8?B?WWQxT2dneHN3WC9JM2d0eU5KMEF6NjNqQUhJYkJjakVVaHI4VU5xMHpSUkwx?=
 =?utf-8?B?K0pQbnJHNVgwN1BUcFdPSFZ5WWZRblhLMElFaStKSHB4Zm9GNjVHT2xvZmFT?=
 =?utf-8?B?TXVWbHV1VVVRWStUOEFiL1FyWjA1emREdnV1UDZGdFFNM0p5dWM3S045MzlL?=
 =?utf-8?B?RFVVc0I2YXkwYmN2V2lLNEcycXJTQzNKYXNZMWxGbWdSYzBOYTFRVmloVUxR?=
 =?utf-8?B?WjI1aWxXcUp4UzhpNm00UnlQUHptclcreXpnWTVtNjBFQjJTcUR1N21ZUFNC?=
 =?utf-8?B?NWN4aFBFNVh1N1hDREpRbjNtVjIxSDdPbDdacHlKSXVNMEZxTGFYWFRzVTFN?=
 =?utf-8?B?VUdhRlhoSG9MWWdqTEtucmhRcGN3RmlUM01MOHh3clFIMWhhbjZBYWtTSmlh?=
 =?utf-8?B?bjN2bENQcTNMaTl3NTkrb1UwZGs1eVJSK3NSbGJyYmhPM3VjZXlZMUJqbGo0?=
 =?utf-8?B?REtlTEh5L1g5UW5YSFB0SG4vVDhqR2dydzV1Nm9lKzN1TTNYY0N5QTBXRVlP?=
 =?utf-8?B?L09hdzNKdFJNclVBTGZxcFlhenpwTXJ2Q0dkUFVVU3ZoTHNCMTlEN3RBU2Zk?=
 =?utf-8?B?NGhNQ0tUNlFkQ3FVaU1Jb3pNcFhSdW1kODdVYnlhVm1PdlFQWVJXZ05VZUVB?=
 =?utf-8?B?V1dpdmpLUEIrNisycFdMeTAvVUpoRWFiOTErd1hpM3Fpc3I1NEtzeVF6YVh6?=
 =?utf-8?B?cm5QZkMxY09mR1ZnZ2NPT1RVc2FaQ3Y5U0hjM01NZUZnMmJuYytqejFBa21C?=
 =?utf-8?B?cTA4bmxkdEtRNUgxMkc2U2pxTWg3WGhLcWZwV3hjT1Yvc2taQTk4aE80bTIx?=
 =?utf-8?B?KzdCd0Fwck9wT2JlOWF5T1lacmFWOFdmVERZS2tGcnMwRncvSTlUVzdDWlZU?=
 =?utf-8?B?MytyZkxUMHNud2tISm8xLzNEOUExcDJndGt5eUY1MnFQR21ZNmE2RWhCM1B1?=
 =?utf-8?B?S0hBWEdzWjZ3WTExMUZXdTQ2YjR4NlNjclR1UkZyMkR1Vmh2cmgrVUJRRm11?=
 =?utf-8?B?WkVJSzNMUjF0MVlRazRGN2QyeWtJSS9xVUtpQUlFY1NrZTRoNFZYZzMvQ3BR?=
 =?utf-8?B?bW9UQjZZTEMwbFlxOUMrNmh1a1ZYVmNGUVl0bFh6elhwWEU3cTd5VW1NSENR?=
 =?utf-8?B?R21abC9HcWtwYnV2R3NJbFI1SXRCNjlYaGxXWHFFUkx3RmRTY3NCT0U3Q2lB?=
 =?utf-8?B?YUhBZ3Z1bDBhTnVwdldLdGVsTzRCMHJCck1odjlvb2hrZDdQY293VW5JSVhl?=
 =?utf-8?B?enQ4dnNJLy92RSt6aEVRSnNpYnI1MGwwQUl1bW5aVkUvaGVQb2pZeWQ1MFlt?=
 =?utf-8?B?d0xLNU1RT2NpL1I0Zzh3UDgrRVJydDVydFJCUGJqbU11eWs3K0pyV29EaEtZ?=
 =?utf-8?B?dTVUbmtWK1IwU2NRS0xHL0RYWEQ2T3hOZTYzNmg4dWExNmZnWm1Vc2s0ZmZU?=
 =?utf-8?B?Y082b2dMN1J3cGJXV0lraDZNZmlURG9yazRnNUlOQzFCdzNxc3BDRld5aFVs?=
 =?utf-8?B?SzVSSG4za0pSRXQ4Y3RrdGlHQ2lWaXFLNE9vVytyV1M4eVptQnA1Z0h0bGhs?=
 =?utf-8?Q?2TPmNS361aEvfat8c8whtaQexIkqQkRX/sxaA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1JFd2NFdklTUlllWUtQcjVBV2lSeWZNNFFINjMwT1dnMTJkSGl4UlEyUjFN?=
 =?utf-8?B?MVJZcDRFdE5VL1REK1ZqYjlTUnFpbit2OVZ4alp1TVBpQ1NVa2w5UzZodzBp?=
 =?utf-8?B?NU9MWlcyWi9yVHVsUEVxRFpRRWhzTmUrbzJTcTR5a3Y4UXN2clpYejV4MDk1?=
 =?utf-8?B?d1JIOHc4bnVWbTBldTlkTVcyZjg0WEZVcEd3R25HRUUyUlZXVkYwM0hMMEhh?=
 =?utf-8?B?d3VqcWZCOXZyZGFENnNnalhaNlBiNHZrYlpla1RaQWd1UE5NOVBOVy9jQTNY?=
 =?utf-8?B?QUgwV1ljc2RCWW9oQnNGSW1jbXZ2bWpRcm5oSUdKNlRLWElZaWFWdUVkaXNm?=
 =?utf-8?B?QWlPWHRzbkRhTTFrb3NYcE1YY2lKN2ZMY1grVHcyMEtmcTI2MUNzZkNHdGJx?=
 =?utf-8?B?ZkcrVEZsZ3dQVnd2WDNWU3lyMmhWRVdIZytoL2Rvb1BndFoyT1dpdkJKWGRr?=
 =?utf-8?B?Um9uU3Q5ZnYzYUFwUjQ3bHl1MG5EL0phSW1HcGlBNXNKZVZxS3U0NjlpL2tU?=
 =?utf-8?B?ZUxicUFBM2Z2TDB5WVpHNnNORWcvaTN0V2FTem16SHpFSi9tWWpnbzJxOTMr?=
 =?utf-8?B?YXRHTnJrQmUvM1plU3FtbmFTWU1IOXhIZ3RjVm9QVndsZnVIREYzanY3NVVC?=
 =?utf-8?B?cmh1UDZqVzVaSkVXMjZSL3FpTERYOTlDS09veG1VRm1LdGRuRHpLN05CdHJH?=
 =?utf-8?B?MC9FWEZZdkE0YmlaUzlRQmFUVUtiN1E4UkpzTGd2VHlwdHdmZ3BNTi9xeWkr?=
 =?utf-8?B?a3lveUZ4dEw2YVIxdktmWjhhL045WFcxVXBLUzI2eDdXamcyTmg3NGxUMUpP?=
 =?utf-8?B?ZUdHY1NoK1dsZElFbHJOWXMvMzdPNDd4T1VYcDRFN3IraENrd01FNUp0Zk9T?=
 =?utf-8?B?cmFwdkUvSHZzSUtvT21EWGZtZ3JxYWJSL2NzSjJHaWpwRkxHUHViTmpkNFIw?=
 =?utf-8?B?WW5pUWZHVzM1c1RqazZyWlc1OWFrSDZMdHJ1SE1jWHovU0R3OVF4eVN0MzAz?=
 =?utf-8?B?VXEyTVYzbGxYOVE5eUh3TG9HdDJMa1lpWFAvR0NlVW9WVFhzUXBsd0FaYWc2?=
 =?utf-8?B?WXdFUXh3M1FNNlp0SllZT1JnalFGVmwreThZRTBCeFl5emFNd083bXFCUHdI?=
 =?utf-8?B?cnNld1MrUUFWa1QrSWYxV1ZQZVRYdEc1dHJrVWJ3RFNyYUw3cXVXazZXT0FE?=
 =?utf-8?B?L1BqRHB1SHFBY2xFZFNpMUlYOFYzN3R0clN0cGVQYklQNno5OFZqMkFzL1hM?=
 =?utf-8?B?eUk1cllJWmtNOTJUTnozanJSU3dCMGxYTlJRSkJONlI2dmJwWndIRVZTU29s?=
 =?utf-8?B?NjJlcnlkbSs2ZWQ4R004QjE4bWE1bFRobHBkaWViM2NWelNrQnZLRjhpSnhu?=
 =?utf-8?B?YjVMM2x4WGQ2S0NnUTNuZFQrcDBrS1FteU5TY3ZSS1J0S2svZ1QxZ016Rlhh?=
 =?utf-8?B?MC9ESUZiSFNVMkpkcFFRZ0gvdXZnLzVIT1NFTnJxT0dCa0REazZUTlIxSFBK?=
 =?utf-8?B?SEJUL0J3eVkwREZQaEVFUElVTjJKSlBFb2grNVZqOHFSUXh2b3VEaUNFSUE1?=
 =?utf-8?B?RmxXQ1B1VDZ5SlZ3WVRmeHlvTGxka1RKN3dKbThuUjF5QmZENTFrbm1nTFl3?=
 =?utf-8?B?VnhPbm5EMmtUa1I2aEdvSkNMVjA3TlFKbUVGemtDM3NrbTV2L0VoWFg3MFFX?=
 =?utf-8?B?R2RzaVJPaklLVTUwRU5SdmhwNFRNQkVISmFaTUpzZThKUGp3RUtlUmZMMGtN?=
 =?utf-8?B?RUd1WU9aUWJieWVzNHZTM2txTHhOWE0vcU9MTUZFVnM0TDBKb29oVEpBZGR5?=
 =?utf-8?B?Q0VmQ0pSSkJCYVROY2E3dnpaN0xzSTRYaEtxV0d3RlJkY0pOOCtUY2RRYkh1?=
 =?utf-8?B?N0N6VmhVVXVlSkNQamFzTHpZVENXY2lyQmdjVHQxMjlCZmNyYTVHQUdiTE43?=
 =?utf-8?B?TUNyV3k5c1hnSkQ1amltOXVkTWtkc00xOU95MEM5bXhKNHlCdC9vZUZ2TW5W?=
 =?utf-8?B?TnZSc0tQbytla1FJZ253ZS9kZ01YMnlPcGVaUmp4cC9aSW1WYU5YK2R5VFcz?=
 =?utf-8?B?L1pBaGp0N3hGay8wdm5yR2ExL3Q0b2cwamY2SHRRSTJkWFFyYkxUbWxuU2NN?=
 =?utf-8?Q?deZjkCOilAku6TVTNZVeCr2Ng?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5b1848-1848-4abc-f8e8-08dcdc5e8f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 06:03:07.3401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4Ss72i/YuFjHV/ljG0Vm0ihdE2JEXrIs0R6yhC7gxoiXTOz2kdz3/blwsZ0W+DcRkPcSZGbrz2x5XX4/IM9D3e7Pzm8pxgG4MUfBUg4XxI=
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
OSBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT47
IFJhbywgTWFoZXNoIDxtYWhlc2gucmFvQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MSAxNS8yMF0gYXJtOiBzb2NmcGdhOiBzbWM6IEFkZCBtZW1vcnkgY29oZXJlbmN5DQo+IHN1
cHBvcnQgdG8gbWFpbGJveCBjb21tYW5kDQo+IA0KPiBPbiA5LzIwLzI0IDk6MDIgQU0sIHRpZW4u
Zm9uZy5jaGVlQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUaWVuIEZvbmcgQ2hlZSA8dGll
bi5mb25nLmNoZWVAaW50ZWwuY29tPg0KPiA+DQo+ID4gQXMgY2FjaGUgaXMgZW5hYmxlZCBpbiBV
LUJvb3QgYW5kIGRpc2FibGVkIGluIEFURihCTDMxKS4gV2UgbmVlZCB0bw0KPiA+IHBlcmZvcm0g
Y2FjaGUgZmx1c2ggb2YgYnVmZmVycyB0aGF0IGFyZSBzaGFyZWQgYmV0d2VlbiBVLUJvb3QgYW5k
IEFURg0KPiA+IHVzaW5nIHNlY3VyZSBtb25pdG9yIGNhbGxzLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWFoZXNoIFJhbyA8bWFoZXNoLnJhb0BpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogVGllbiBGb25nIENoZWUgPHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGFyY2gvYXJtL21hY2gtc29jZnBnYS9zbWNfYXBpLmMgfCAxMyArKysrKysrKysrLS0tDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXNvY2ZwZ2Evc21jX2FwaS5jDQo+ID4g
Yi9hcmNoL2FybS9tYWNoLXNvY2ZwZ2Evc21jX2FwaS5jIGluZGV4IGViYWEwYjhmYTE3Li5kYWM4
ODhjMzk5Zg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL21hY2gtc29jZnBnYS9zbWNf
YXBpLmMNCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLXNvY2ZwZ2Evc21jX2FwaS5jDQo+ID4gQEAg
LTEsOSArMSwxMCBAQA0KPiA+ICAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAr
DQo+ID4gICAvKg0KPiA+IC0gKiBDb3B5cmlnaHQgKEMpIDIwMjAgSW50ZWwgQ29ycG9yYXRpb24g
PHd3dy5pbnRlbC5jb20+DQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyMC0yMDI0IEludGVsIENv
cnBvcmF0aW9uIDx3d3cuaW50ZWwuY29tPg0KPiA+ICAgICoNCj4gPiAgICAqLw0KPiA+DQo+ID4g
KyNpbmNsdWRlIDxjcHVfZnVuYy5oPg0KPiA+ICAgI2luY2x1ZGUgPGFzbS9wdHJhY2UuaD4NCj4g
PiAgICNpbmNsdWRlIDxhc20vc3lzdGVtLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvZXJybm8u
aD4NCj4gPiBAQCAtNDAsMTAgKzQxLDE2IEBAIGludCBzbWNfc2VuZF9tYWlsYm94KHUzMiBjbWQs
IHUzMiBsZW4sIHUzMiAqYXJnLA0KPiB1OCB1cmdlbnQsIHUzMiAqcmVzcF9idWZfbGVuLA0KPiA+
ICAgCWFyZ3NbMl0gPSBsZW47DQo+ID4gICAJYXJnc1szXSA9IHVyZ2VudDsNCj4gPiAgIAlhcmdz
WzRdID0gKHU2NClyZXNwX2J1ZjsNCj4gPiAtCWlmIChyZXNwX2J1Zl9sZW4pDQo+ID4gKw0KPiA+
ICsJaWYgKGFyZyAmJiBsZW4gPiAwKQ0KPiA+ICsJCWZsdXNoX2RjYWNoZV9yYW5nZSgodTY0KWFy
ZywgKHU2NClhcmcgKyBsZW4pOw0KPiBJZiByZWFsbHkgbmVlZGVkLCB0aGUgY2FzdCBzaG91bGQg
YmUgc29tZSB1aW50cHRyX3QNCg0KU3VyZSwgIHdlIHdpbGwgZml4IGl0Lg0KDQpSZWdhcmRzLA0K
VGllbiBGb25nDQo=
