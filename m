Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA67C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 08:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A72808B6;
	Fri, 28 Feb 2025 09:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ir7JfdAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83EF280BA4; Fri, 28 Feb 2025 09:07:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7A1807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740730070; x=1772266070;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MIbxIKOTfxUNxcMP9TXoI/gUJADfHwTJNv2lheaIyOQ=;
 b=Ir7JfdAYauAz/JT4ZaOYYA5cCG3J2K4nhwtVOjDeAzFKlf/547k8HNoL
 G/kc2qqxYovcaQiG1iJb5iQyMFbZYFhl87CjKVEsOxn3W2marq5cP7exL
 fzN7CFFwIousgaQ4KD/EiZbmpMbpMu4/H55smUJQ2dLn+ettXUstUQaO3
 KrOTgl0xP8/PmZ1QK0anrw9IoQnpIG5oefUgdBonAOC4pdCFgIMF8Re8l
 +ZMshsB/hbWQa8tg0J7btr8eWA8jTF4ycZ1WxFfgIeNHHDoOnNmQRfDuk
 XP8CG+XCizzef+ZpEqXhRQgN/zXEC57RIWTItv5J75Jx80Mbu1+cG3HfD A==;
X-CSE-ConnectionGUID: hHLmt8sRSt6nBORh3E34Qg==
X-CSE-MsgGUID: VLACE6j7RLSZFGJbOMVKAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="67024911"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="67024911"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:07:47 -0800
X-CSE-ConnectionGUID: Ro0QaiwyRFan4W6FMZa6qA==
X-CSE-MsgGUID: G/v/kN3FTrWXwVDPxclp5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="148189688"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:07:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 00:07:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:07:46 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:07:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9BEyXHMgihOfjLUgtLAywqPlFqOyEZzT2nh+iNqHTtdz1wBCv4xRWeCd50Jm9vpyPOY8RYmAnR5PATf4EYuQY7gOtprfiWJc3d3hguVrejwPwT1nrrPDiwcHQxSw8OYVs69Evra2d2EMNhPe/pDTkV6EulwpeP3ITo6pwwUAWYHlYzE/fBAmgP8ahHqWH7dG0oGRQO//rzOkxlwxdVYaCRzs0t2/QjVeq3Yltc/eYOMoiuLAM9R9iKotoSj/QmOe7uN+HzmP+zOe0PXorc+aWF+GoyYnMv5c2aMDSqjKA7X4P7Q/l2xBi7OrSQeZnAtanNDRiQ9VJg1aU1woDuAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIbxIKOTfxUNxcMP9TXoI/gUJADfHwTJNv2lheaIyOQ=;
 b=fRUBOJot6CC9U+mQBfSCCYMxciktM5khDgrMH1mopcg4eg281Su7TtJ4R+HUgc+BnAa8OtGSsU01shNK6/ZK8++CEQglWlURxxicOWhCVVMUxsxFtguU27/PVlXiMMbRcLkYtbeBf1Jay9JbPdZehFhPBhfAu8OeaHhQ50UWMJtROcnt8SR6K8i+47xGOxhmX79oKqitnzGEY6fa7L5UTR109SlJj051z5FzAA445+25YeJXs+YDPjIIu+TYp40FWxrVcNB30uSmn8MJ3bL9Yk9sKGtJQ4RvL/xGYBHSTTCRI6MmrBUj4WnPVfU3g8+XnthfUAJ3eb/WcJpHlPm6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 08:07:43 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:07:43 +0000
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
Subject: RE: [resend v3 17/19] drivers: mtd: nand: Enabled Kconfig and
 Makefile for SPL_NAND_FRAMEWORK
Thread-Topic: [resend v3 17/19] drivers: mtd: nand: Enabled Kconfig and
 Makefile for SPL_NAND_FRAMEWORK
Thread-Index: AQHbiGpg6/x4KnuGf0OEj4ma0YfhQrNbrKQAgABqTRCAADUMAIAADwiw
Date: Fri, 28 Feb 2025 08:07:43 +0000
Message-ID: <BL1PR11MB53660AD35AFFA285A584C36582CC2@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
 <20250226161833.53689-18-dinesh.maniyam@intel.com>
 <CAOf5uwkKE-W0pPMB50rBs3Fa7Mdh75zU9nYNG2DpNLqjrp=ORQ@mail.gmail.com>
 <DM4PR11MB5373F5322F7554073B29508182CC2@DM4PR11MB5373.namprd11.prod.outlook.com>
 <CAOf5uwmMG5p+VAShYiXqEpX4d+qAkmHUS71q3gTmp=hgSLGQiA@mail.gmail.com>
In-Reply-To: <CAOf5uwmMG5p+VAShYiXqEpX4d+qAkmHUS71q3gTmp=hgSLGQiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|IA1PR11MB6098:EE_
x-ms-office365-filtering-correlation-id: fe982530-7d20-4fdd-3490-08dd57cefa7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RTE3djNoVXAvakVEeWc0ZzY4UGNEVGNhYzhOdlNUcHg3bTNLaUNvSlBjUzds?=
 =?utf-8?B?ZGNuUzh3a1RyMXBiUHJkbEtpZjIxSnhTNTR3N0podTBMcTNyVkFqM2F1SGJW?=
 =?utf-8?B?QlFPOHNibzc1bEc3ZzZWanBwWFZSQ0pBRzBHenpFdlhBOGNKNE04VU8wOUNs?=
 =?utf-8?B?Z01GanhCbkxuZmhWcGtDUXBZYXhRV0VHR0hndWU3cWZIVno5S3JIQXYzeFg3?=
 =?utf-8?B?MDloR2xFMFhXWjlvOU9kZXdmR1NLb284YnpZUzZnNnBlakY4TWJpV01SakdS?=
 =?utf-8?B?NkFNSU9ndUJ5U2h6ZTNEclNRVHFlR0sxRGJ5UEdObWo0WWthcmVsZnM1TVZi?=
 =?utf-8?B?a1c0MWZHZG9YdXRPUXVHbWRXL0VEUFlyeVg0MUlWdTVxV2poVjI1ZmxYbmQx?=
 =?utf-8?B?OGlDT1I4RmkxQnU5Mmk0MHozTml5ZTRvTmMzWThscXdkSUtuYWJzSDV5ZGc4?=
 =?utf-8?B?K0RmeDJ0cTgwbEVVa25vK1dTWTNGTVBVekY3SklZVVVIeWgrQkloVFFORmhR?=
 =?utf-8?B?Uk1aYmRrbVduMkN4eVJoMXljK01pdFB1S2RGUFQxcGN6T2Z0b3ExOGR3Qmxx?=
 =?utf-8?B?L3hHZnJjRUp2NWQwSlpNYVMxcS9lMTc2ZTk5RmswdWhQZm9NNXdRdVNtd2pr?=
 =?utf-8?B?dE1ZK3dhdDRibkFxbzZMZU5zMWZWa0VOTStpMFg2bXQzR2NyeDBOYm80a0g4?=
 =?utf-8?B?QjJDdHk0blRSeXdIcSsvaUdpTkJwOUU2bE9pOHh3QnlMVmVtc28yamlzdlJ1?=
 =?utf-8?B?NThodUpzRmVYeE9BaUp2bE9meFJFMHowY2ZYWmg4N3h5aUdibUhwbVZYYVZ3?=
 =?utf-8?B?Mi8xZmFBbFlBUVJCM3Q3dzVaQVJQNnROQjc3RFVTVHV5bWFHRWhtN1hPRm5M?=
 =?utf-8?B?VmhyTFByK0syMXJJc3BrK1VNNTVtNmVrTFIwbjd5OFBSaWFFczltS3JCY2t4?=
 =?utf-8?B?ZmVqZXZCeDUwRmFxd3p0bElQYlkzb1NrejdnWVdNRGFiaHBvNzFUTmQ0VGZV?=
 =?utf-8?B?RzRDa2YyWjloeEpCV1dOYS82c29ETHRHMjhyTzBRcTdMVEZzTG9lb3dObHZ5?=
 =?utf-8?B?VGJoeXl1ajVtWWpUdUtVL0IxdURiZkhDeE5FSTkzaXUyUTNpRVg1aEowMlZE?=
 =?utf-8?B?VkhOVHJVeEdlWlNKaW9OU1NjNFJaR0hnMzJ3ZC8yOFFPYk9NazUyc2hLZVI3?=
 =?utf-8?B?U0ZqQzEzSzIzWnZrODZOWWp2c21abWkxUzlTd3crUWVxZWp6TmxjOTZEZzZO?=
 =?utf-8?B?aW1xUzIzOGRaZ0Y5RGp4YzZ1RmRWNk4xdHdIV1BjL1U1WDZQc20rdWhOUXhi?=
 =?utf-8?B?a204R1VQRGE5K1JIUExBVGtmZU1WQnRSVkQ0N1FkNGpSdVZjZ3cyTGxPV2tl?=
 =?utf-8?B?VEhxRU44citRSE96Ym03cWsvcmJWajN3QytvRmVlcDYzTElMUXM4RG5NK2Jq?=
 =?utf-8?B?TG1paWtYMUpBRGEvMjM1MFc1bWxRSGpVSVFKUVVIK3pDSS9tSk1KVFVDUWhJ?=
 =?utf-8?B?KzVIeHh5OEFvZkh5dFpWZk9HRHNnaWs4YTJ6STA1a0EyRkttWnIza2QrMkt2?=
 =?utf-8?B?Mk9SaU1ONEtWV21tZUozeEIzV3JGNFg2YnZtcHZsLzNOcDlmcEdCYTZ3UlZH?=
 =?utf-8?B?VmRyczVLekZxOFR4SEFBNTdSUERiRzVHanVEdFZmS0tvT1FoeXpkSHhvSXZt?=
 =?utf-8?B?SXdSWmpXdlBTSnBocUVib0hRVWNBTkpXdnVyT3RKU0xtTzY4NWZ0MHp0SXlx?=
 =?utf-8?B?bTByNCs1SnZpWjR6M1B6amNRRlN1MjNrcldIWVhTMGRBT0FubW42QUpHUmVX?=
 =?utf-8?B?bFhFR2hsZW9iU0JiY2Y3RVZQc3c4Z083VWFtbHpyMGFlOWpvU0ltQXlySUNy?=
 =?utf-8?Q?Gy3wax9UW8z0C?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm42Q1lkdVgwRDN5czBHVENhc1pzQU5OaEZOOEh2Nm0xcU5peHRFVDdGYllj?=
 =?utf-8?B?LzJwNjRvTDVaQ2lyWXkveFdBL2RibEdQQkYyK05qdW9kNHlWZHNiRkYzSTBk?=
 =?utf-8?B?UGlZaUJjVUhab1BsZjV3eEU0ci9VSTY2SkttV2ZiaWpyMEVyMFZFYUZ2OGcr?=
 =?utf-8?B?ZEQ5YTBnMFR2Q2VpV2h2aFBvdktMS0NzSG95L0k0VGdLTXNlU0hLU1gvSWxp?=
 =?utf-8?B?b285ck94eHZlSjBiQWlGd29Zc05NeWZxbnlUNDVTTTVqSnpuT3hRNTFDQlVS?=
 =?utf-8?B?di9RU3BybmtsZ3RyNk9mWCt2TnoveFYvNlpndnREMnFLT0o1MWttY1lDVzBP?=
 =?utf-8?B?SDlURExFL3RhL3VubElPRlVsdXorOS9wU1FsUzBhMVFZdDMzUk8vdFhCSmNH?=
 =?utf-8?B?UHNkaWVuZm0xWFgweSt1VXBaTG1RZE1sNk9xV2c4NHZEUU5UMHlQNG5lQVJQ?=
 =?utf-8?B?OWg0TXgyR2dJdUUzOXBpaVkwekNEU3M1QnRIWUJzdlJoNFpFb2NlRUZTQ1o3?=
 =?utf-8?B?T2FUSE1BU2NCRGpEeEtUQmpJamxENEc0eVUvdGR2bzdYRkFLVnJ2V2dPTFVR?=
 =?utf-8?B?VkRHeTZTZ09iVkpiYzcxMHBhRjBvbFRTUjhPQmNmdFJhd1BXM2JWQlhHek9h?=
 =?utf-8?B?NjdRTzhKdGIzU0pjZjZsZVh6clBTeTA1WGRsa2psK1FueVR5MDI3SGZlSmVn?=
 =?utf-8?B?M1VRQ2dpQXM3ZVdHN1Q3YjFET0hlSVZ0NzNrclJyZkRRRmRpWnRqNFlyUXkw?=
 =?utf-8?B?OEhqOFJoYWlHYVVqWHB3L1p5NlMzUkpocVk0ZTJVVFlDV2dQV2tsZG41ZjFx?=
 =?utf-8?B?S08vNlVadEhIVUN4VG1XaFY2U3pvN0FCdEF4MkJIK2NwS0gwQVhvVkMvOFhn?=
 =?utf-8?B?MkdHeUllVURmQUl4dFAzLy9RYXhiQVcvK3NWbVNwUDAxc08xUTdRbXRhWWxK?=
 =?utf-8?B?QkVrdjM3blBjUnFtbUl1VVJkWlJZcXF3VE83cEFWOHU1RUswVlJrWERYcThZ?=
 =?utf-8?B?c2t2UXZxK3JhOGFIZVhWNDRYRDhzL1FqelJIUEluUmJFMVFUeEdUbENjQ3Yz?=
 =?utf-8?B?TWNxbFB0UGRyZU1IdXlxZFNZblRrZktMalVobC9MRUp2MUsxT1oyQ0xzNThP?=
 =?utf-8?B?ZjU4czV4c1RrakxXRVZTKzY5bm1KSVpYQjJ2WHFCNnZHM05hK2JKZHZ3R25w?=
 =?utf-8?B?STBsNEFJMWhvQUpxdUs1dTNZd0lZeGZQc3lUcmRJQUMwZlJXZTkxMkp4Rm5l?=
 =?utf-8?B?K2p3VHJodXFqZ1RXczgyRjdrUmFLaW1aL3FDNWpDOTVpa3RFMmZrQWlUNm9k?=
 =?utf-8?B?bzk2L3lsRWNwdFRTb1dDeU05VWZHMGpMVFFpbDZHamlZc1Q3U0wwalh0MXJ5?=
 =?utf-8?B?bWZaQVVaTlJMR1I0NmpXOC9yOVFvWGpzaVpFeExXc2FMUlNvOG55WVFBSzZl?=
 =?utf-8?B?b2Z5ZVVTcE0zMmRRZ1VsU0lEa09OdXMvc2QzMXVkNnFyR0NKc0Y3YjQ3UE5U?=
 =?utf-8?B?NTY2TGJKWU9kODVhOFdsWk8zbE9zVlVCRy9hRFhwQUhMTmM1ZURHT0tYMU5k?=
 =?utf-8?B?Z0RJeU5yVDkxUXZPUWc1MlhzWk55VjFyNSsxc3FtMmNpSnA3K3JuOFJnZGNo?=
 =?utf-8?B?RmtXaVpKd25lcTc1ZFpLT044V2JPelBTKzlGSy90cHJSZWkzaHpBb1JKTjBO?=
 =?utf-8?B?U0drblVESlZtUjJqY0ZKdmNhQnFWVUtmRHB3MGlrZlpvRFBBRFg2ZnFEeTBk?=
 =?utf-8?B?UG1ISXZoU0VlS05jVmJCYjZHZWw0ZlJQRTk2a2dWdnNIbFRlOEtGRGxTdHZD?=
 =?utf-8?B?WXZjN0IyL1crcTFRZENIMWNsUEdoUmh3eXp3cFcxRXlqS09wNWt0NnFWdlpl?=
 =?utf-8?B?MnZBMm00YTJXM3ZpWlFEYUtKOUZjbjRocDQxZXVTa3JVcEZPbklkU3ptdFF3?=
 =?utf-8?B?QTFReWt1MlQxa1dsTzhjaTRXWWp3WWdDanp2SnFsSjBkTmcxbVYyVUt2d25x?=
 =?utf-8?B?Z0ZNT3ZreEd6NFRHVWwzWEJPVHFMQVIxcVpLQ0JGVld2QVVFWjh4UjZ4dXc4?=
 =?utf-8?B?em0wVi9ieTNjVi95UFA1cUpEMnI0WWVvSmdJT2YyblM1RFo0ZjBzblI1Q1Jz?=
 =?utf-8?Q?5HG3d0IFwR6n9Tjy1d5uicPLi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe982530-7d20-4fdd-3490-08dd57cefa7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:07:43.3608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/7/0VrjdkhuhA49ahyBoKwJ3puy/N9EqH82w564n2mJEMzMfiHxIxolVNf9h5wQZNo8iOnfI1522gfrnaPzml6WgiYUIoZgig6WxeZkyZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6098
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
YXksIDI4IEZlYnJ1YXJ5IDIwMjUgMzowMCBwbQ0KPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5l
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
IFJlOiBbcmVzZW5kIHYzIDE3LzE5XSBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEVuYWJsZWQgS2NvbmZp
ZyBhbmQgTWFrZWZpbGUNCj4gZm9yIFNQTF9OQU5EX0ZSQU1FV09SSw0KPiANCj4gSGkNCj4gDQo+
IE9uIEZyaSwgRmViIDI4LCAyMDI1IGF0IDU6MDLigK9BTSBNYW5peWFtLCBEaW5lc2ggPGRpbmVz
aC5tYW5peWFtQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWljaGFlbCBOYXp6YXJlbm8gVHJp
bWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5
LCAyOCBGZWJydWFyeSAyMDI1IDU6MzAgYW0NCj4gPiA+IFRvOiBNYW5peWFtLCBEaW5lc2ggPGRp
bmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4gPiA+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsg
TWFyZWsgPG1hcmV4QGRlbnguZGU+OyBTaW1vbg0KPiA+ID4gPHNpbW9uLmsuci5nb2xkc2NobWlk
dEBnbWFpbC5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsNCj4gPiA+IERhcmlv
IEJpbmFjY2hpIDxkYXJpby5iaW5hY2NoaUBhbWFydWxhc29sdXRpb25zLmNvbT47IEpvaGFuIEpv
bmtlcg0KPiA+ID4gPGpieDYyNDRAZ21haWwuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47IEFyc2VuaXkNCj4gPiA+IEtyYXNub3YgPGF2a3Jhc25vdkBzYWx1dGVkZXZp
Y2VzLmNvbT47IEFsZXhhbmRlciBEYWhsDQo+ID4gPiA8YWRhQHRob3JzaXMuY29tPjsgV2lsbGlh
bSBaaGFuZyA8d2lsbGlhbS56aGFuZ0Bicm9hZGNvbS5jb20+OyBJZ29yDQo+ID4gPiBQcnVzb3Yg
PGl2cHJ1c292QHNhbHV0ZWRldmljZXMuY29tPjsgTWVuZywgVGluZ3RpbmcNCj4gPiA+IDx0aW5n
dGluZy5tZW5nQGludGVsLmNvbT47IENoZWUsIFRpZW4gRm9uZw0KPiA+ID4gPHRpZW4uZm9uZy5j
aGVlQGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+ID4gPiA8a29rLmtpYW5nLmhlYUBpbnRl
bC5jb20+OyBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsNCj4gPiA+IFl1
c2xhaW1pLCBBbGlmIFpha3VhbiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAaW50ZWwuY29tPjsgWmFt
cmksDQo+ID4gPiBNdWhhbW1hZCBIYXppbSBJenphdCA8bXVoYW1tYWQuaGF6aW0uaXp6YXQuemFt
cmlAaW50ZWwuY29tPjsgTGltLA0KPiA+ID4gSml0IExvb24gPGppdC5sb29uLmxpbUBpbnRlbC5j
b20+OyBUYW5nLCBTaWV1IE11bg0KPiA+ID4gPHNpZXUubXVuLnRhbmdAaW50ZWwuY29tPg0KPiA+
ID4gU3ViamVjdDogUmU6IFtyZXNlbmQgdjMgMTcvMTldIGRyaXZlcnM6IG10ZDogbmFuZDogRW5h
YmxlZCBLY29uZmlnDQo+ID4gPiBhbmQgTWFrZWZpbGUgZm9yIFNQTF9OQU5EX0ZSQU1FV09SSw0K
PiA+ID4NCj4gPiA+IEhpDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBGZWIgMjYsIDIwMjUgYXQgNToy
MOKAr1BNIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiBGcm9tOiBEaW5lc2ggTWFuaXlhbSA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiA+ID4g
Pg0KPiA+ID4gPiBFbmFibGUgdGhlIEtjb25maWcgYW5kIE1ha2VmaWxlIGZvciB0aGUgU1BMX05B
TkRfRlJBTUVXT1JLIHN1cHBvcnQNCj4gPiA+ID4gaW4NCj4gPiA+ID4gYWdpbGV4NSBmYW1pbHkg
ZGV2aWNlLiBUaGlzIHdpbGwgaW5jbHVkZSBhbGwgdGhlIGJhc2ljIGZpbGVzDQo+ID4gPiA+IG5l
ZWRlZCB0byB1c2UgdGhlIGV4aXN0aW5nIG5hbmQgc3BsIHN1cHBvcnQuDQo+ID4gPiA+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZpZyAg
fCAgNyArKysrKysrDQo+ID4gPiA+IGRyaXZlcnMvbXRkL25hbmQvcmF3L01ha2VmaWxlIHwgMTAg
KysrKysrKysrKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+
ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9LY29uZmln
DQo+ID4gPiA+IGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZpZyBpbmRleCBhOTUxNWM3Yjc0
Li5kNmFjNzMwMjI0IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9L
Y29uZmlnDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L0tjb25maWcNCj4gPiA+
ID4gQEAgLTgzNyw0ICs4MzcsMTEgQEAgY29uZmlnIFNZU19OQU5EX0hXX0VDQ19PT0JGSVJTVA0K
PiA+ID4gPg0KPiA+ID4gPiAgZW5kaWYgICMgaWYgU1BMDQo+ID4gPiA+DQo+ID4gPiA+ICtjb25m
aWcgU1BMX05BTkRfRlJBTUVXT1JLDQo+ID4gPiA+ICsgICAgICAgYm9vbCAiQ29tcGlsZSB0aGUg
ZW50aXJlIE5BTkQgZnJhbWV3b3JrIGludG8gdGhlIFNQTCINCj4gPiA+ID4gKyAgICAgICBoZWxw
DQo+ID4gPiA+ICsgICAgICAgICBTb21lIGRyaXZlcnMgcmVxdWlyZSBhIGxvdCBvZiBmdW5jdGlv
bmFsaXR5IGZyb20gdGhlIE5BTkQgZnJhbWV3b3JrDQo+ID4gPiA+ICsgICAgICAgICBjb3JlIHdo
ZW4gdXNlZCBpbiBTUEwuIFRoaXMgb3B0aW9uIGFsbG93cyBjb21waWxpbmcgdGhlIGZ1bGwgTkFO
RA0KPiA+ID4gPiArICAgICAgICAgZnJhbWV3b3JrIGludG8gdGhlIFNQTCBpbnN0ZWFkIG9mIGl0
J3MgcmVkdWNlZCB2ZXJzaW9uLg0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gVGhpcyBzZWVtcyBu
b3QgcmVsZXZhbnQgZm9yIHRoaXMgc2VyaWVzIGFuZCBldmVuIEkgZG9uJ3QgbGlrZSB0aGUNCj4g
PiA+IGlkZWEgdG8gaGF2ZSBpdA0KPiA+ID4NCj4gPiA+IE1pY2hhZWwNCj4gPiA+DQo+ID4NCj4g
PiBJIGFncmVlLiBJIGNhbiBkcm9wIHRoaXMgY29tbWl0Lg0KPiA+IFdlIGFscmVhZHkgaGF2ZSBj
b25maWdzIHRvIGVuYWJsZSB0aGUgbmVjZXNzYXJ5IGZpbGVzIHRvIGJlIHBhcnQgU1BMIG5hbmQg
YnVpbGQuDQo+ID4gSG93ZXZlciwgZHJvcHBpbmcgdGhpcyBjb21taXQgd2lsbCBjYXVzZSBhIGNv
bXBpbGF0aW9uIGZhaWx1cmUsIFRvDQo+ID4gb3ZlcmNvbWUgdGhpcywgc2hhbGwgbW9kaWZ5IHRo
ZSBzb2NmcGdhX2FnaWxleDVfbmFuZDJfZGVmY29uZmlnIGFuZA0KPiA+IG10ZC9uYW5kL3Jhdy9L
Y29uZmlnIGZpbGVzIHRvIGluY2x1ZGUgdGhlIHJlbGV2YW50IGZpbGVzIHRvIGJlIHBhcnQgb2YN
Cj4gPiB0aGUgU1BMIG5hbmQgYnVpbGQuDQo+ID4gV291bGQgeW91IGxpa2UgbWUgdG8gcmVzdWJt
aXQgcGF0Y2ggMTMgJiBwYXRjaCAxNj8NCj4gPg0KPiANCj4gQnV0IHRoZSBvcmRlciBpcyB0b3Rh
bGx5IHdyb25nLCBJIG1lYW4gdGhlIHBhdGNoIHRoYXQgaW5jbHVkZSB0aGlzIGRlZmNvbmZpZyBj
b21lDQo+IGJlZm9yZSB0aGUgYWRkIG9uIG5ldyBzeW1ib2wuICBTbyB0aGUgY29tbWl0DQo+IGVi
MTlkZWMyZDU1YjU3YWI5OWNkNzViMTViMDRmNjllZTQ1N2ZmYzkNCj4gY2FuIG5vdCBidWlsZA0K
PiANCj4gSSBtZWFuIHdlIHNob3VsZCBoYXZlIGEgYml0IG9mIGJpc2VjdCBhYmlsaXR5IGhlcmUu
DQo+IA0KPiBZb3Ugc2hvdWxkIGFibGUgdG8gYnVpbGQgd2l0aCB0aGlzDQo+IA0KPiBpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9LY29uZmlnIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcv
S2NvbmZpZyBpbmRleA0KPiAwMWQxODFiZjQ3Ni4uN2FiODQwYTllNTMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbXRkL25hbmQvcmF3L0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9y
YXcvS2NvbmZpZw0KPiBAQCAtMTk1LDYgKzE5NSwxMSBAQCBjb25maWcgTkFORF9DQURFTkNFDQo+
ICAgICAgICAgZGVwZW5kcyBvbiBPRl9DT05UUk9MICYmIERNX01URA0KPiAgICAgICAgIHNlbGVj
dCBTWVNfTkFORF9TRUxGX0lOSVQNCj4gICAgICAgICBzZWxlY3QgU1BMX1NZU19OQU5EX1NFTEZf
SU5JVA0KPiArICAgICAgIHNlbGVjdCBTUExfTkFORF9CQVNFDQo+ICsgICAgICAgc2VsZWN0IFNQ
TF9OQU5EX0RSSVZFUlMNCj4gKyAgICAgICBzZWxlY3QgU1BMX05BTkRfSURFTlQNCj4gKyAgICAg
ICBzZWxlY3QgU1BMX05BTkRfSU5JVA0KPiArICAgICAgIHNlbGVjdCBTUExfTkFORF9FQ0MNCj4g
ICAgICAgICBpbXBseSBDTURfTkFORA0KPiAgICAgICAgIGhlbHANCj4gICAgICAgICAgIEVuYWJs
ZSB0aGUgZHJpdmVyIGZvciBOQU5EIGZsYXNoIG9uIHBsYXRmb3JtcyB1c2luZyBhIENhZGVuY2Ug
TkFORCBkaWZmIC0tDQo+IGdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L01ha2VmaWxlIGIvZHJp
dmVycy9tdGQvbmFuZC9yYXcvTWFrZWZpbGUgaW5kZXgNCj4gOTM2YjU0ZTNmZjMuLjM0Y2JhNzcw
NDZhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZQ0KPiArKysg
Yi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZQ0KPiBAQCAtMywxOCArMyw4IEBADQo+ICAj
IChDKSBDb3B5cmlnaHQgMjAwNg0KPiAgIyBXb2xmZ2FuZyBEZW5rLCBERU5YIFNvZnR3YXJlIEVu
Z2luZWVyaW5nLCB3ZEBkZW54LmRlLg0KPiANCj4gLW5hbmQtZnJhbWV3b3JrLW9ianMgOj0gbmFu
ZC5vIG5hbmRfYmJ0Lm8gbmFuZF9pZHMubyBuYW5kX3V0aWwubyBcDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgbmFuZF9lY2MubyBuYW5kX2Jhc2UubyBuYW5kX3RpbWluZ3MubyBuYW5kX2FtZC5v
IFwNCj4gLSAgICAgICAgICAgICAgICAgICAgICBuYW5kX2h5bml4Lm8gbmFuZF9tYWNyb25peC5v
IG5hbmRfbWljcm9uLm8gXA0KPiAtICAgICAgICAgICAgICAgICAgICAgIG5hbmRfc2Ftc3VuZy5v
IG5hbmRfdG9zaGliYS5vDQo+IC0NCj4gIGlmZGVmIENPTkZJR19YUExfQlVJTEQNCj4gDQo+IC1p
ZmRlZiBDT05GSUdfU1BMX05BTkRfRlJBTUVXT1JLDQo+IC1vYmoteSArPSAkKG5hbmQtZnJhbWV3
b3JrLW9ianMpDQo+IC1OT1JNQUxfRFJJVkVSUz15DQo+IC1lbmRpZg0KPiAtDQo+ICBpZmRlZiBD
T05GSUdfU1BMX05BTkRfRFJJVkVSUw0KPiAgTk9STUFMX0RSSVZFUlM9eQ0KPiAgZW5kaWYNCj4g
DQo+IE1pY2hhZWwNCg0KWWVzLCBkZWZjb25maWcgc2hvdWxkIGNvbWUgYWZ0ZXIgYWRkaW5nIHRo
ZSBzeW1ib2wuDQpXaWxsIHRha2Ugbm90ZSBvZiB0aGlzLg0KSSBjYW4gYnVpbGQgd2l0aCB5b3Vy
IHN1Z2dlc3Rpb24uIFdpbGwgYWRkIGEgbmV3IHBhdGNoDQp0byBpbmNsdWRlIHlvdXIgc3VnZ2Vz
dGlvbi4NCg0KRGluZXNoDQo+ID4NCj4gPiA+ID4gIGVuZGlmICAjIGlmIE1URF9SQVdfTkFORA0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvTWFrZWZpbGUNCj4gPiA+
ID4gYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZSBpbmRleCA1OGZkZTMyNzJmLi4wYTMy
ZTE4NGRjDQo+ID4gPiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jh
dy9NYWtlZmlsZQ0KPiA+ID4gPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZQ0K
PiA+ID4gPiBAQCAtMyw4ICszLDE4IEBADQo+ID4gPiA+ICAjIChDKSBDb3B5cmlnaHQgMjAwNg0K
PiA+ID4gPiAgIyBXb2xmZ2FuZyBEZW5rLCBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nLCB3ZEBk
ZW54LmRlLg0KPiA+ID4gPg0KPiA+ID4gPiArbmFuZC1mcmFtZXdvcmstb2JqcyA6PSBuYW5kLm8g
bmFuZF9iYnQubyBuYW5kX2lkcy5vIG5hbmRfdXRpbC5vIFwNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICBuYW5kX2VjYy5vIG5hbmRfYmFzZS5vIG5hbmRfdGltaW5ncy5vIG5hbmRfYW1k
Lm8gXA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgIG5hbmRfaHluaXgubyBuYW5kX21h
Y3Jvbml4Lm8gbmFuZF9taWNyb24ubyBcDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
bmFuZF9zYW1zdW5nLm8gbmFuZF90b3NoaWJhLm8NCj4gPiA+ID4gKw0KPiA+ID4gPiAgaWZkZWYg
Q09ORklHX1NQTF9CVUlMRA0KPiA+ID4gPg0KPiA+ID4gPiAraWZkZWYgQ09ORklHX1NQTF9OQU5E
X0ZSQU1FV09SSw0KPiA+ID4gPiArb2JqLXkgKz0gJChuYW5kLWZyYW1ld29yay1vYmpzKQ0KPiA+
ID4gPiArTk9STUFMX0RSSVZFUlM9eQ0KPiA+ID4gPiArZW5kaWYNCj4gPiA+ID4gKw0KPiA+ID4g
PiAgaWZkZWYgQ09ORklHX1NQTF9OQU5EX0RSSVZFUlMNCj4gPiA+ID4gIE5PUk1BTF9EUklWRVJT
PXkNCj4gPiA+ID4gIGVuZGlmDQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMTkuMA0KPiA+ID4gPg0K
PiA+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hp
DQo+ID4gPiBDby1Gb3VuZGVyICYgQ2hpZWYgRXhlY3V0aXZlIE9mZmljZXIgTS4gKzM5IDM0NyA5
MTMgMjE3MA0KPiA+ID4gbWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbSBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQo+ID4gPg0KPiA+ID4gQW1hcnVsYSBTb2x1dGlvbnMgQlYN
Cj4gPiA+IEpvb3AgR2Vlc2lua3dlZyAxMjUsIDExMTQgQUIsIEFtc3RlcmRhbSwgTkwgVC4gKzMx
ICgwKTg1IDExMSA5MTcyDQo+ID4gPiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tIHd3dy5hbWFy
dWxhc29sdXRpb25zLmNvbQ0KPiANCj4gDQo+IA0KPiAtLQ0KPiBNaWNoYWVsIE5henphcmVubyBU
cmltYXJjaGkNCj4gQ28tRm91bmRlciAmIENoaWVmIEV4ZWN1dGl2ZSBPZmZpY2VyDQo+IE0uICsz
OSAzNDcgOTEzIDIxNzANCj4gbWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbQ0KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IA0KPiBBbWFydWxhIFNvbHV0aW9ucyBCVg0K
PiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MIFQuICszMSAoMCk4
NSAxMTEgOTE3Mg0KPiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tIHd3dy5hbWFydWxhc29sdXRp
b25zLmNvbQ0K
