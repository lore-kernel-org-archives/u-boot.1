Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4433EC021AD
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7107E80A46;
	Wed, 19 Feb 2025 03:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bPYAamdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321E180C8F; Wed, 19 Feb 2025 03:38:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10613809A4
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739932733; x=1771468733;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+KtCKs2mDG94h63ter5tyIt9+p1MLii5ATF0D4H1uPw=;
 b=bPYAamdSVpziSy8pbBOqEuJHLbaDvENI4saRBtIUvImeOcyFlf44wCk0
 QnLjP+Huf77gf7kmSv7JiMldIAuYxOhin8fNSNoul74oIDeI13mDDzbL/
 VjnGiSbXmkTasklNuTtENmK2i2Mg1u21QvsKIJ0XFK6gp+fQN9Vc+yGta
 kZUtWlY9SwalS0INBWy1Qz2OiYK6ELSWMbOBbKwhk7h9sDzIzCA94ALNZ
 xGzptXDu54j788o+ovSEMq1eNCkwkPgbyE6xpKmChCeDT598vcjxt0pcv
 vJMkCy05cXXkSjHZYvw69SSWtEwf8tXaK5EcOuDsEzqMplf+15ReU9U50 w==;
X-CSE-ConnectionGUID: 934JJ4MST4Si/p82q41PJA==
X-CSE-MsgGUID: YSXZXLZrTaqI7Fx4fKMY+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="66010987"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="66010987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 18:38:51 -0800
X-CSE-ConnectionGUID: O0GUgT4SQsS6OkrahTnHbA==
X-CSE-MsgGUID: vu544fuZSNij83VUHRHNHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="114505090"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Feb 2025 18:38:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 18:38:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Feb 2025 18:38:50 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 18:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoC+TwSA7s/jpdE2/7+YMNQcJkp/Rq96c2uVvwdblWJNdx3zhOkGGQof2fphhHbt+e3xE7tRlMduybJQFpP77bl3knNkphZOOKW7WwZ4E5GCNb2ibUhYygJToCD/b92EhN9xf1NZUTFfgFhSHykFb0WNfFhBCw3VF8onDT1x7MP2+r0blimb64i9ME8mnffSjRZwJWNYr/FPwOsTxXFIp4qFebPGSpdaI4sHNH/cMVlE8xQDmBAZ9mprb6yc3pe8tudSWtU27ik+MUGLBbhCLF/nLjwLA5A8GSYCaF6A3NsO7vVcaD16eu/1+nz2KUQ8K3fVR8nRvdTrOxIk6Ff1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KtCKs2mDG94h63ter5tyIt9+p1MLii5ATF0D4H1uPw=;
 b=ZzYz+eTYyd2K1yY47gXAVQdWgrCHiMEoWWQM9kpU7wCMcFSYcJXBpqgq00Jcjg29Ba1IFpwcNnFP6kLA3WZe/4eqjYhYlbsshcH/9uQ3Vg0e9XpyfuZKuML2EhHkfoE0npl3Pgnl3h+h8kdIxOilc8oY/m64L8/IW8oyP1mNmNjazQK8t602EQjpm8rR09CkjkTQ2Ipqo1puqJdncr2f3MzXjD7oa+1rtZuFB69PGVQG/NCj66gux3u9P8yrUBEyTD6BQTnF3GEouJqxgDY/3cKwEX8ZtT57iimmdyvavNu26Ne5m+9xgchQQsuUqDppJFAg5XO29+K8fr3q1FBx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 02:38:47 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 02:38:46 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>, "Wang
 Jie" <dave.wang@rock-chips.com>, "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad
 Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Thread-Topic: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Thread-Index: AQHbgbDbNNz6e3ZDUkKfFBKSL5OqUbNMqWyAgAFAdlA=
Date: Wed, 19 Feb 2025 02:38:46 +0000
Message-ID: <BL1PR11MB5366869F2B02F83A63FADAF182C52@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-2-dinesh.maniyam@intel.com>
 <45c759d8-472c-4825-84ee-954fbd492a57@amd.com>
In-Reply-To: <45c759d8-472c-4825-84ee-954fbd492a57@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|SN7PR11MB6825:EE_
x-ms-office365-filtering-correlation-id: f4d8c6a8-979f-4389-324a-08dd508e88e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OHdVekNkMDhDMytwMCtpZnpSVEVUT3JGS0ZsWFA1aHpvdmtoazJqc1ozK2xL?=
 =?utf-8?B?TUQ3NG5sV1NkeCtMc2FjMGFucGt0T1p6d0NoRGsxaDVjVjc5NUdRbmxRSThZ?=
 =?utf-8?B?U1IzRW5iT1N4MTZDbkp5cFZyQmRQMWtGaE81Z1N6WjkrUnlOWWNUeXc4d0Rn?=
 =?utf-8?B?NUE0TGNwODhsdVAxNXhnczY2WEgwTDBJOHVTcVAxL04rdEdmdHBQLzV5Ykxs?=
 =?utf-8?B?NDZqZGdja0ZtSC9RVU1ha0xPVytuM2hPeTlwY0x3SDJHc1R1aXBvRTE1RDZH?=
 =?utf-8?B?NUx4bkJ5Qmt0NG5TQzZnUkgvRVMwSW1qVEhIUnhWbDNwWm1nTzN6N0gyZEtY?=
 =?utf-8?B?clZ1bkdwaTZiTVMrMCtNbCtsS3lnb3Y2R0VzRGpXY3EvZzBxNTdaMHYyRFkz?=
 =?utf-8?B?MjZ1SnlBc2RDd0FOeWJQNCtqZDQ2dEdaTTVHZXhlTjdIeEcvcjByWU8zNW1I?=
 =?utf-8?B?SFdYVElvQkI4Q2V0OUpIUWlqZ3ZSQkd4RzltcWtkdXo1UzJkVHlleGZvckVj?=
 =?utf-8?B?dmZrN05wMjRjT2dITDJKR0Qwd3lRVG9WREFCSHB4SGNQZVFjQ2NNSENwWWR1?=
 =?utf-8?B?V0IzQmYraTdmL0t2YmpVYjlPRHNCRmwwQzlEalhVaG1OWEVISit4QUswL2xh?=
 =?utf-8?B?QjlJTkpoUkk1djEwMlBRQ0hBdWN1czE0bXlhNE9XWmxONm5tLzRGZjZ3MmdG?=
 =?utf-8?B?NVpGdmxCVGRtcExLQjFldndQalE2ZnFPY1lzSEl6RWlldEFFSVpJd2YrS2xa?=
 =?utf-8?B?ckEvTWpHbjZ2azcyV0xtakRQUWJYZFdheXFzdTdmbWplbEhlYTFWcDUvVDNM?=
 =?utf-8?B?bEUzckY1a3NaMlo5NlFDYTFlMjl3eWoxQXJ5WkNCeXhTc0xIM0Y5UG1VbjVq?=
 =?utf-8?B?RVFnVG1iR0h3RlBqby9tMkIwa1RhT0FIK3NJQTR1aytOYU50ZllDNmlRa2Ft?=
 =?utf-8?B?azI1dzlDMUhKVk9nNHFxby9JeDNrOUYxMm1Ka2w2UHQrK3N0QXgvTjg3NHhW?=
 =?utf-8?B?bnNwbis3b3VlaDIxUXZUWUlmOUl1elNQa0FmTTdIUHJUVytjQ2pYU3RyQXRW?=
 =?utf-8?B?S2hKVEpMWUJTZ1BmbEM2Q1haQ3h0dlhjWnRoRXNrNGpSczlSc0lEOWE0emM3?=
 =?utf-8?B?dlBvMjljOXVJUjkyZ1p4cEltbXdCS3pPNmU4cWpWaUgweXJ5bGc1cWxka2J5?=
 =?utf-8?B?ZDhzaTZycmJ5MS9peVZtZkFLbXBNZTRkdDYwRUVaYW8xYjlSdkJBZ09iZ3pq?=
 =?utf-8?B?UFF1SkRWcHJ5SEE0aTdUbEVqaFBJU202eEFyNExSNlhQMmE0K2ZQbERtTHda?=
 =?utf-8?B?eTkyRlB2dWErODJKc3MwVUJ1VGNjZWxDUFQ3VWNOL2RzSjBDZVlST0V6T3Ez?=
 =?utf-8?B?ZFhSWC96ZE83ekpVYUpseFViTk9pMnZiSjRrd1ZYSGszUzZxSzBLNkdQMWx5?=
 =?utf-8?B?WEpWV3prUmxzWVQ5aVp4Slh1aW9oUkZVc0t2a3VabGRqMXpmaXNwUzhwV3k3?=
 =?utf-8?B?cEx2ekpQN1pScHBRZFJSaWEwWjI3YmViVzJscGU3TzJHeThSYUlrYnlEb1Rj?=
 =?utf-8?B?aTd2YUdWK09XU1NwVmJEWGRLRGM5YVl0bUlLQmxIVmxBaEJyMHBWeVlKdHRn?=
 =?utf-8?B?VllqNklOaXNqU1hBRUVYWFk2UUdmNUM3aFFiVkpKU1IyTDJ0RXlTSUY2NHFx?=
 =?utf-8?B?UldKa213eXpGU3JUZ1hCWVdIc3pZOTlSVGlNeWhUT1lCdlA1UHNRNVM0cXRp?=
 =?utf-8?B?cyswUkFIUmZtZS8xUGdkaEVFTUtLSkR1T0l6SnVSbXUwVGZqZjk2MkpySDFI?=
 =?utf-8?B?OVo1N1hOZGp4Ry9mRkRVS015Y0JTcWdQbVBkZXdOeHZqeURYV1JMdXZqeUph?=
 =?utf-8?B?cVhkVy9SelV2T2FSTHUvZlNkVWExRFM4ZDYrUk5Cc2Fja1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1IwWDVqbHpQNmxjZ0crS3FZOEpRVHN4eFE0MWYycDBaRkVNdnlTdEVBV3BL?=
 =?utf-8?B?eFlQSnVzdDl2SmU2RnlmcHJzRlNPTUhxYktEZnNBSmRsUVRvQzdvVDA4eFdE?=
 =?utf-8?B?aHB4dzh5QnBOUUZxcFBIQjd1bkdNRWNudDlZc0RNOHlGc3BIbXBsVXB1U0dj?=
 =?utf-8?B?TjlvK3hMS05RU1VXTGlKZ1VMSkhMc29mT0RYL0h3MTlQM2N3UHZ1dlMvSUJl?=
 =?utf-8?B?UC9WSTcyRTc3cXlQOGRvMmhYa25uYzFrWjl4ZmV6bkFDVDNOL2xBM3JVZzFo?=
 =?utf-8?B?eVY1akVIVlFVemppL0gyeDRoS1hVWmYvUHdwYjB4Wm5VRGtKSVBOb1ZuaUQr?=
 =?utf-8?B?ckorcFFoR3EwYTNVQWpiZHBlSWRxbE00VUV1bUFXaWpOMmxweEtCL1FuSTBp?=
 =?utf-8?B?bURPMTRuRkNLZmROa0xJWGhKSlQwTzdyczFWVHpqUGJhQVZCWnhsbk5hUW9r?=
 =?utf-8?B?eGZFeXVMWS91VTV3U2llM2EydVlJVzRhQ2lnd2dKVmFnaGxSSTdXK25veFZG?=
 =?utf-8?B?Q2pxcVZIVVBvYTVERitYd2xtT0tRSmpsOHN2YzJPTjhkU3JjclJQeGZEK1J5?=
 =?utf-8?B?UVhoenRmV0wzVkZZWWpndWdWbHZVcDhqMm01LzhsUkhKVmpTaFMwd3JFM3Y3?=
 =?utf-8?B?WjdwRjA0dFgwdDhsRDVWbk02bXJIakw1bC9ZcFBsa3Y1UDRlRnZucm81VUQ5?=
 =?utf-8?B?blIzSHBnaTZ6Y2lXZ1Q5ajhmNkRiQVd3UUYvZVBuaElKcFk5d083eXNVaXE1?=
 =?utf-8?B?SmJHNFQ5U0UrMkN4WUtXRHYwLzhjMktqR0R3WGR6SXhOdGk2dksyRmxySzIv?=
 =?utf-8?B?Q2gvUFU4djQ4bElUY3ZYUnNXWG5hOW1yUWdacmM4Q1lrellGR0NlVWV6M0pS?=
 =?utf-8?B?MklXTSs3dm14Uy82QnhBQmlpbUx4UGd1RnNBSUZ6dlZPOFhqS1U5Zk5sUnBl?=
 =?utf-8?B?NGt3YUJVSVV5em1ac0k2TXlwS05DT3JTdXIrMm5GYUVaL1dpWVNkL3FRTWk2?=
 =?utf-8?B?VkFyK2M1Z01lbTF1UVNIRjdFcFdweFhkTVIreWFldFRWZDRVYzdnWnl5Z0ZJ?=
 =?utf-8?B?Zmh3T2VLWk14VVpQSXFFNnRPR24zdloxbDQrdm8ySm9Fbm9EOVZBUHFWejh3?=
 =?utf-8?B?WXBWUHhXUlhDMUlldjEwUDNrNHh0VVBFQVovNXBRTEFTOFFMTmNOREh4eWRu?=
 =?utf-8?B?WTJUYy9HanYxZm8wek5DWG93ejAzVmY1SUw4WHBWZVFkVWUvZ1cwTnBHa0kz?=
 =?utf-8?B?Ym5VazFXc1UwcXY0K2Iwcm94cmM5Qk5SQ09uVzNWdWJWeklpTHBsTCtEMXBB?=
 =?utf-8?B?S0FhNGhrR1M3YStuUVlFa09JL25xZUxsdjZuclUxWWFJbEZCSnduZFAwdS9o?=
 =?utf-8?B?bFFlRXNyRkhScEVHSDNjRzFPWTNEeHFRWERWaHVKMzFFd0xGb0JhamFybGVU?=
 =?utf-8?B?cWRUMW5qQmNXU0RrOXNmOVFKKzZ5bXcyRlNFdFBTZyt4ZThqL2dmN2haL3Jz?=
 =?utf-8?B?MHBmMThkQU5kSXNKSUdENU5MQVZjOG1qVzNGdkxIdktaK3VBME13eWc0V1Ev?=
 =?utf-8?B?dEFZbElQY2xsbllSWWphZ1RWSHh6Q1dNSUdEZnNqVTM1Q3BheEQ0cTUrckFZ?=
 =?utf-8?B?UzAzUmtOd2g3NlQ2VE1ZUFA2c1MwMnJVcGZ6UnhsMVQvNU5YM0FzWTltaTRj?=
 =?utf-8?B?N0hUN0czcGJ4WC9wZHp0M0JtTkpqS1VJSmx5Z2lwUm9yUmFEVGVrV25nL2RC?=
 =?utf-8?B?ZjZST09ScFVTUzhOWmVmZlBaYWZhOUdxSk1UODFIVE9pbnh1UUVlYzZGZ2hN?=
 =?utf-8?B?YU5ZeWU2Q3dvVUlrMEpwQU5jd01hdDJzQVR0eDVNblJJMFY5Z2NobmRDU25C?=
 =?utf-8?B?SGZZOTRCaVFJbUVLdFJnaEtLbHJwOG4yR09hUkZNRTBSYVJ6aWUrd25FL21r?=
 =?utf-8?B?dW95NUtNalROOU9MTGZ2SVdsbkZ0RC9RZnRNNU5teUNlck1Hd1N4MDFSbWEy?=
 =?utf-8?B?RDFQUG5jWXYrR0RXVEVMR0oyd0J6Sk5hSUtDaTNsYll6Ni93UjdKL3ZhWE9B?=
 =?utf-8?B?UFBWbUhSb0JzRlc0dlJWNDhuQ2NnWkIrcll4UDRkbGNHWk91eGR3TDU5UGlH?=
 =?utf-8?B?TVBWSkpwQVlBTm0wWW95anUvVDNoTzBjTDVhNGVGdUJaY3V0bDAvT08vNFVj?=
 =?utf-8?Q?kebvUZ8wFrLX7H8OJZM9b/BJOk7OqtTmkll40e91Tti0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d8c6a8-979f-4389-324a-08dd508e88e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 02:38:46.8342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzNZncqNkuSI+7LrBRQKTj0rj5gqvmW7eVh8d8v3vqZRfMOYUmmzrgoQ4jmotCJot0obSc37BIoJNpeT0qxOy1Xs69frk+MlwE3IqUOekYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVrIDxt
aWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgMTggRmVicnVhcnkgMjAyNSAz
OjI2IHBtDQo+IFRvOiBNYW5peWFtLCBEaW5lc2ggPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT47
IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBNYXJlayA8bWFyZXhAZGVueC5kZT47IFNpbW9u
IEdvbGRzY2htaWR0DQo+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29tPjsgU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28uY29t
PjsgSWxpYXMgQXBhbG9kaW1hcyA8aWxpYXMuYXBhbG9kaW1hc0BsaW5hcm8ub3JnPjsgSGVpbnJp
Y2gNCj4gU2NodWNoYXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPjsgSmVyb21lIEZvcmlzc2llcg0K
PiA8amVyb21lLmZvcmlzc2llckBsaW5hcm8ub3JnPjsgTWF0dGlqcyBLb3JwZXJzaG9law0KPiA8
bWtvcnBlcnNob2VrQGJheWxpYnJlLmNvbT47IEliYWkgRXJraWFnYSA8aWJhaS5lcmtpYWdhLWVs
b3J6YUBhbWQuY29tPjsNCj4gRG1pdHJ5IFJva29zb3YgPGRkcm9rb3NvdkBzYWx1dGVkZXZpY2Vz
LmNvbT47IEpvbmFzIEthcmxtYW4NCj4gPGpvbmFzQGt3aWJvby5zZT47IFNlYmFzdGlhbiBSZWlj
aGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPjsNCj4gV2FuZyBKaWUgPGRhdmUu
d2FuZ0Byb2NrLWNoaXBzLmNvbT47IE1lbmcsIFRpbmd0aW5nDQo+IDx0aW5ndGluZy5tZW5nQGlu
dGVsLmNvbT47IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsgSGVh
LA0KPiBLb2sgS2lhbmcgPGtvay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24gS2hhaSA8
Ym9vbi5raGFpLm5nQGludGVsLmNvbT47DQo+IFl1c2xhaW1pLCBBbGlmIFpha3VhbiA8YWxpZi56
YWt1YW4ueXVzbGFpbWlAaW50ZWwuY29tPjsgWmFtcmksIE11aGFtbWFkIEhhemltDQo+IEl6emF0
IDxtdWhhbW1hZC5oYXppbS5penphdC56YW1yaUBpbnRlbC5jb20+OyBMaW0sIEppdCBMb29uDQo+
IDxqaXQubG9vbi5saW1AaW50ZWwuY29tPjsgVGFuZywgU2lldSBNdW4gPHNpZXUubXVuLnRhbmdA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzEwXSBkdC1iaW5kaW5nczogaTNj
OiBBZGQgWUFNTCBzY2hlbWEgZm9yIENhZGVuY2UgSTNDDQo+IGNvbnRyb2xsZXINCj4gDQo+IA0K
PiANCj4gT24gMi8xOC8yNSAwMzo1NiwgZGluZXNoLm1hbml5YW1AaW50ZWwuY29tIHdyb3RlOg0K
PiA+IEZyb206IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+DQo+ID4N
Cj4gPiBBZGQgYSBZQU1MIGRldmljZSB0cmVlIGJpbmRpbmcgc2NoZW1hIGZvciB0aGUgQ2FkZW5j
ZSBJM0MgY29udHJvbGxlciwNCj4gPiBkZWZpbmluZyByZXF1aXJlZCBhbmQgb3B0aW9uYWwgcHJv
cGVydGllcyBmb3IgcHJvcGVyIGludGVncmF0aW9uIGFuZA0KPiA+IHZhbGlkYXRpb24gd2l0aCBk
dC1zY2hlbWEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5lc2ggTWFuaXlhbSA8ZGluZXNo
Lm1hbml5YW1AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL2kzYy9jZG5zLGkzYy1tYXN0
ZXIueWFtbCAgICAgICAgICAgICAgICAgIHwgIDUxICsrKysrDQo+ID4gICBkb2MvZGV2aWNlLXRy
ZWUtYmluZGluZ3MvaTNjL2kzYy55YW1sICAgICAgICAgfCAxODYgKysrKysrKysrKysrKysrKysr
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDIzNyBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgZG9jL2RldmljZS10cmVlLWJpbmRpbmdzL2kzYy9jZG5zLGkzYy1tYXN0ZXIu
eWFtbA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9kZXZpY2UtdHJlZS1iaW5kaW5ncy9p
M2MvaTNjLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kb2MvZGV2aWNlLXRyZWUtYmluZGlu
Z3MvaTNjL2NkbnMsaTNjLW1hc3Rlci55YW1sDQo+ID4gYi9kb2MvZGV2aWNlLXRyZWUtYmluZGlu
Z3MvaTNjL2NkbnMsaTNjLW1hc3Rlci55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwMDAwLi4wZWRhMTY0ODJlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsr
KyBiL2RvYy9kZXZpY2UtdHJlZS1iaW5kaW5ncy9pM2MvY2RucyxpM2MtbWFzdGVyLnlhbWwNCj4g
PiBAQCAtMCwwICsxLDUxIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjANCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9zY2hlbWFzL2kzYy9jZG5zLGkzYy1tYXN0ZXIueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0
aXRsZTogQ2FkZW5jZSBJM0MgbWFzdGVyIGJsb2NrDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoN
Cj4gPiArICAtIERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+DQo+ID4g
Kw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6IGkzYy55YW1sIw0KPiA+ICsNCj4gPiArcHJv
cGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IHNucHMsZHctaTNj
LW1hc3Rlci0xLjAwYQ0KPiANCj4gDQo+IEZpbGVuYW1lIGlzIG5vdCBmaXR0aW5nIHdpdGggY29t
cGF0aWJsZSBzdHJpbmcgdXNlZCBoZXJlLg0KPiBBbnl3YXkgYmluZGluZyBpcyBhbHJlYWR5IGlu
IHRoZSBsaW51eCBrZXJuZWwgdGhhdCdzIHdoeSB5b3UgZG9uJ3QgbmVlZCB0byBwdXQgaXQNCj4g
aGVyZS4NCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kzYy9zbnBzLGR3LWkz
Yy1tYXN0ZXIueWFtbA0KPiANCj4gTQ0KDQpXaWxsIGRyb3AgdGhpcyBjb21taXQsIHNpbmNlIHRo
ZSBmaWxlcyBpbiB0aGlzIGNvbW1pdCBhcmUgcmVkdW5kYW50Lg0KUGxlYXNlIGV4cGVjdCB2MiBv
ZiB0aGlzIHBhdGNoIHNlcmllcyB3aGljaCB3aWxsIGV4Y2x1ZGUgdGhpcyBwYXRjaC4NCg0KUmVn
YXJkcw0KRGluZXNoDQo=
