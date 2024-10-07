Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79380CFB424
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 02:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8440E8863E;
	Mon,  7 Oct 2024 04:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NWm+jX1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FF08806A; Mon,  7 Oct 2024 04:17:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F2E886B1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 04:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728267424; x=1759803424;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2Se8sDOBCRFkpsD+snJ5A8JIA4p4ZgSaUUZhmgz4ARI=;
 b=NWm+jX1ZzBaA2FCrheRyFO3RXuLNZ59DBXLdcEH+d5Spo7JgA1jMinV9
 9NyI2tUSGBckdxKqsKnPEXxiZsh3n+Mz9fLKsuXYwIxXpFrXxLFz9ddE1
 6yNAWQwH4aGZw/PU0gtfXhHYdRfRAT0PVtmbUsZE4Qi1FwesG6eZXX5WB
 hScHLDAG3EY4YkPPFF5q38797MGt2GzeYa6ONZarX70R/wSGFxmtPTnnB
 hejDOHsuXqTeRr2E1JV9yoVDeF0JSEBh+zwP1JTSRqrEpRPuROqr8I0o3
 ziu5OUflRXyX2VTW5w0FB2OzwD3DHu/VjnYkB3Nd3XCFzfkey0mv79D1k Q==;
X-CSE-ConnectionGUID: BSzA+fzpQeKxy/C6253xsw==
X-CSE-MsgGUID: u2lcFp9nTRKD+YyLXeArgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="30286474"
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; d="scan'208";a="30286474"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2024 19:17:01 -0700
X-CSE-ConnectionGUID: 0J2A4+TYQaSmuFWEMB2Ydg==
X-CSE-MsgGUID: xxyjsle4SnuKf9EP1+306Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; d="scan'208";a="79908732"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Oct 2024 19:17:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Oct 2024 19:17:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Oct 2024 19:17:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 6 Oct 2024 19:17:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 6 Oct 2024 19:16:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVxbhmYDGJLKaP+uNTnFzR4GGaC7qK7zVHsmlIkOuJFExJwT9rh9ISL6eUtmslyEi5jrwru0HTx4t6aRXZr0A0UvPQol2v/obcuaTjqixn40dVYrtZYEq1skbITtZG0ggR+4kGcF/UuV73fF2NTz8Zx65dLfdnrj9PJ95EqMFta7zfrXCrWntFn8zOKqHXjL1O1IYtCKbQHG1p4bWSWgzX1CNC9sXxXMouZpT1txkFDt77wsZpiyLboT9e+zZNILr5UOCMKtkj2CWaGGd410SYpjqtdegEVdQKAWpi7OZ+gU0NaAVPeAA9/P6W2H33cqJYXyrlVR+dlxYvg2aSxeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1BTS7vqFiXAnDO0h/tRF7EzegcBJfPZJwPulWglfKE=;
 b=odjaW+OlWRnemYlb/Ln5oWyLQ6f8mcUBjuYatIZp5bQt9yf4QhuoobNx7MthL7F1Z2uQ/mvaWz7hj3/K+ZkrKvrWJh6Plno2ulgmo7OwLy4eql1BxYCqkHe/sNbJeGPXRUz5wLfVUUpf/R3nANHEVSJMQi+L1el2CHmmZdjQGD7F+gr/cHIMd8VgITf2HEwUJJiTrx7xsOf5k9+4+mvYOFpNHnKwi16FmTgvEpEAWue5RTXSX/aoDx/i1p+/4i3CFo37TPab7US9FYl5q1Lz5MHkD6n5HVyVIfses5DmyERvdyXuOyA9NhjmO+vjfBC511bhUpqrAB3hHsiS+9G6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 02:16:51 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 02:16:51 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Alexander Dahl <ada@thorsis.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>,
 "Dario Binacchi" <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Johan Jonker <jbx6244@gmail.com>, "Michal
 Simek" <michal.simek@amd.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 William Zhang <william.zhang@broadcom.com>, Igor Prusov
 <ivprusov@salutedevices.com>, "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Ng, Boon Khai"
 <boon.khai.ng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, Teik Heng <teik.heng.chong@intel.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Meng,
 Tingting" <tingting.meng@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH 00/19] Add Cadence NAND Driver support
Thread-Topic: [PATCH 00/19] Add Cadence NAND Driver support
Thread-Index: AQHbCkfRrroubkxwnUq7c9rCN6XZibJen2OAgBwFGQA=
Date: Mon, 7 Oct 2024 02:16:51 +0000
Message-ID: <BL1PR11MB53665E838EF44F0ADFA4DA5D827D2@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
 <20240919-roundup-radial-95d3c8e3e581@thorsis.com>
In-Reply-To: <20240919-roundup-radial-95d3c8e3e581@thorsis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|PH7PR11MB6605:EE_
x-ms-office365-filtering-correlation-id: 88786527-7485-4cba-1ede-08dce6761b34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tEHrBVdtlov7t2LZbJ7KWqQxI4WeGWFLeixTxqB7uKAIEy9Ce3Vn3eG1ffTS?=
 =?us-ascii?Q?uNYEBCdYyn/ySul5UhFb7hO5Tt5RMYGnX7mUhW29wM65aQs9TQfnkvsk6M6T?=
 =?us-ascii?Q?pHG0pxI/Onh21fbZOU/L54rhi/7Koqyw4MIess7wEqgfkHcVGbyNXPaq05h2?=
 =?us-ascii?Q?M6xfxKf9vM/jrhEz0GNPayhIUCw/xILYRSiAYQFQPmSce7A6TsDz7epmo68Z?=
 =?us-ascii?Q?HtDKvCM/xKHQnDgGuuo0WUqJ/tBiuKr1BZ41qYXGKFx3bjyhfe5YbnylnMCY?=
 =?us-ascii?Q?KR4xPxPGdVwmT710X92yrZFozDpgQA6psZ8mRrJxIrY2Ey9eCeKfY/R1OQ22?=
 =?us-ascii?Q?mir+/jmBzu64kqL1ZBwB1coxUMrIJr5bbwvEWSRx5L97IuosPhSpcbS1Ovos?=
 =?us-ascii?Q?fCAz25QAVMli7L0rLKpp/pAtg8WnLMG3pZ438tFsCfx3YMJBMf3WTVXdJumC?=
 =?us-ascii?Q?7VVi8fj6bNahgbllszJAk/Q8wNp2yBC1EwLJDwNjSgPdg5fwyuH7wrKvkaZ0?=
 =?us-ascii?Q?kEtjWP6MKF0t4bzaos6jPt7Cfk8MJWLYCTannSiadqykEjhMruVR3BQ4PEXw?=
 =?us-ascii?Q?jQpq32C8RA7UpfiL+ZPiM///k1+29tEnm4MMU/nMLHbZklwtjmdFsl7Zk87o?=
 =?us-ascii?Q?gE5EC0aKOQN70ELobebcm2byJK1U4m1VlNoTxgTMxLPEL5PWYk2/T9cqAbhR?=
 =?us-ascii?Q?g87Qrlq5VOU3JK0+KIJ9KRfFSRDFL0ZJ9ll3RimBjOOxFWgENB6hpnc2sLWa?=
 =?us-ascii?Q?/yVKO010C2PUBIyZxRYKYuSXCWZ7Bi45UFUJo3UNa+YrKfJsyrGjjSm36FhF?=
 =?us-ascii?Q?Kpns7tx0uAlpbsLRNTXHwHW8J/FyH6JSEYj50KJTq4XM1HA3Hk4ovhvqieC3?=
 =?us-ascii?Q?hYe9WTaSvolpavHtj0ixK9I6VvJO32LH6HU1ONpjiWi+Y4GyO4xfL4SMRCNv?=
 =?us-ascii?Q?V5RkpyVgxT6XPaUkiebV7E67Jw5OLHDgHjhFkyrssaWP1cBqZVlW/LWDqNpb?=
 =?us-ascii?Q?++F9dUvUPmgHRoSDSlCn/kOFFLE7YCDnk/bJIcfxnKVbKUHXrxcYsygFKFAY?=
 =?us-ascii?Q?NauPTAeaJ09RlxGUIjPnRK5E7CVOQam/3sLW4A+KH7MUs/gOvnBNrbxJOw4+?=
 =?us-ascii?Q?j0HaxcMd+Gi5TzpAMJUoGCJEjDC2AfQpPOCWh6pczEvxXfKpLmvx2aUzQitb?=
 =?us-ascii?Q?MjlWzFOBGQqEArJ+3AduyWQwbusAysGwCYM92jqQKodvtKYb/fDUgKIpQ8Pu?=
 =?us-ascii?Q?KTrVdjyACIyGLoSuiaFr6OP0lfa9YJe0n0d9j6Ri/SN61QSNyqtfi4Lh25iJ?=
 =?us-ascii?Q?d/t2+JZTk4OD3vr5q95sQycy6wuvcYLKdCp0ChrBw1KKPQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GPMMGP7q8FMXgnc9YBaOr+uawcX7m39OpcyZZDPJUsZvcVNB5F8rVHiC0SBu?=
 =?us-ascii?Q?qIHNjQbi0pIPzVB7/ZlNFlo8ZObYqr/4jwz2sVWkvgsFx9Ijb+0Lu2LUE0Ui?=
 =?us-ascii?Q?qDvXteSfM80iffPzrduTak0k6DLhV+cfhSf5TwJKO/wLFZAPFFRj/ffg69FZ?=
 =?us-ascii?Q?/WIz/AqSDV9Z3o4HpKJngmGNsNid8wo53Mo763cn/ecxA5oaKEhrRI+jBwtP?=
 =?us-ascii?Q?6V7bU6FZmYIlt3emM8MMsUN86mtt+tqe6n6MU7So0LPbkkxbvFJGudwIkY6f?=
 =?us-ascii?Q?OdPDTUaiJsW6qM+PPfnoI4GWfSIr5iyo+Q39TrzxJLLtmDkQ1tNp9OVcHEqE?=
 =?us-ascii?Q?xMYwns2IxWwDTuN+e+pL5aPh016wDtK8Z22G/19X2bhnURwjlkjjWB5T+neZ?=
 =?us-ascii?Q?W1Le/ZrAFi/HMYJiWwmeo2fM7iJmVBGVvT1yMTet/6OYm9Nz3skI6jB4yuAE?=
 =?us-ascii?Q?vpq/4Yec+4zherDvF6PTyd9FVhqukmmFxdbZngVKBxYPII0rsaB2V+V9ogoK?=
 =?us-ascii?Q?2ej5+i+bSrXv/cJfSjxlSizeqOb3UuvuCN7RQeyXsnBESzDEud1IyjBbzgtZ?=
 =?us-ascii?Q?fhZOhBHi+188Lb9ZabDJTVIhWDOrTomKlHiAlq3xLChNtz3kt1e/RNOV54qs?=
 =?us-ascii?Q?GR2EUxVQ95AUexthANAt9lxo2WcHaSOLABZBTxkI27gAV8kSrEoqt2FjutZD?=
 =?us-ascii?Q?/J1sbqrpvMBslmbWWitlzJ7jhNDwcSPjDnlG3LEa6z9lB1dISu9j4CTvjMq7?=
 =?us-ascii?Q?sqER0fDBqWmDklcJFy0Fz/FFa85/bX8DQC3UeIHaLp6HW9dLc17ClHJsEczW?=
 =?us-ascii?Q?glegNj3MPNm3GRVzTStaKeV/xEiXDyO1pMrcP71SdYSekfqrYQrLdM8zRqhP?=
 =?us-ascii?Q?GTrOJGvsL/DaxsMiOrytgAL77uLR6V+tKmRfJKc+6gfx+B51mOK1rMvcB7sM?=
 =?us-ascii?Q?riYQjV6G833Tt+K2h2K94/45gvjSx4n+YLdH6HACNwegknmw4OEK4y7ejnCS?=
 =?us-ascii?Q?0FPNEovQi/zJ0EYsjdLSd67o8mkt9RXxEwXw/RhEHkRLX/A9mA0RPUswC9BB?=
 =?us-ascii?Q?Ey0Ns8LjNO31CePb6IfukUU36fSlz3IpocmO9wJI+OSMQs1f/4TFvZz9aQa2?=
 =?us-ascii?Q?9Bekh8Bebv0+/gLaURC1wgz/W66olGez/JV/zXuZT0KkZIkZwmYyBXShyy2N?=
 =?us-ascii?Q?aYSlgvIYNL2Q6KSruDfc8IrpMTDXL/C6YnGqPqH7nQS0F8U8eTnrBsbcddG4?=
 =?us-ascii?Q?VM73LcLyUH57kK0jOCUvEq9SYhfR5yWaBeRfd64DAywNOhNq4A+bpabD64V6?=
 =?us-ascii?Q?hfMuIsb1j22pWvWCPlZLoDDfTJmxaopxA/SO9/FSUfbtb0u3BBkihDCFotFt?=
 =?us-ascii?Q?jx7d8k8TTGnfL1rnhw5qxwOk96QfQCe6zTg5R0lzOYDDHWJcwYRr9o7/EEPq?=
 =?us-ascii?Q?L40bYCJhDMmRX9ch/UWbYltURHY+ZSlMvdlWhiioEvV7uuUg9Q6L9v41j97w?=
 =?us-ascii?Q?HJI6gPoA7Y3XLmnZ5avQGBABTGpkk13lAiur1LTrSlORNdGUngtd080qpZsn?=
 =?us-ascii?Q?cw7gUyUjTJD0BA+VgPHknkMjULvQ5rbkGTB3H1+s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88786527-7485-4cba-1ede-08dce6761b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 02:16:51.6444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /T30D31J8uZ+kkqQCLhkT6lcIQB/GxgLxUUil5+3ugll+22hkNBDdbDH0Q8XhJHakLdUWaqF3wdgx78B/tMn/+oF+/CQ1jVDhpBBoyZCvbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
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

> -----Original Message-----
> From: Alexander Dahl <ada@thorsis.com>
> Sent: Thursday, 19 September 2024 2:06 pm
> To: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> <michael@amarulasolutions.com>; Johan Jonker <jbx6244@gmail.com>; Michal
> Simek <michal.simek@amd.com>; Arseniy Krasnov
> <avkrasnov@salutedevices.com>; Alexander Dahl <ada@thorsis.com>; William
> Zhang <william.zhang@broadcom.com>; Igor Prusov
> <ivprusov@salutedevices.com>; Chee, Tien Fong <tien.fong.chee@intel.com>;
> Hea, Kok Kiang <kok.kiang.hea@intel.com>; Ng, Boon Khai
> <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Teik Heng <teik.heng.chong@intel.com>;
> Zamri, Muhammad Hazim Izzat <muhammad.hazim.izzat.zamri@intel.com>;
> Meng, Tingting <tingting.meng@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: Re: [PATCH 00/19] Add Cadence NAND Driver support
>=20
> Hello Dinesh,
>=20
> Am Thu, Sep 19, 2024 at 11:54:53AM +0800 schrieb dinesh.maniyam@intel.com=
:
> > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >
> > This patchset add Cadence NAND driver support for Intel Agilex5
> > devices.
> >
> > The NAND driver is leveraged from the cadence-nand-controller.c from
> > Linux. U-Boot will support read, write and erase NAND with Cadence
> > driver. The driver further enhanced in U-Boot to support NAND booting
> > from FSBL and support boot to kernel via UBIFS.
>=20
> Could you please add to your U-Boot commit messages the exact Linux versi=
on
> you used for porting?  This makes it easier in the future to re-import Li=
nux
> bindings, dts, and driver updates to U-Boot.
>=20
> Also avoid phrases like "This patch is to" in commit messages, this adds
> redundancy for no reason.
>=20
> Greets
> Alex
>=20
> >
> > Dinesh Maniyam (19):
> >   dt: nand: add cadence nand dt-bindings
> >   arm: dts: agilex5: Enabled cdns-nand dts setting
> >   include: asm: Add support to read/write 64-bit
> >   drivers: mtd: nand: Add driver for Cadence Nand
> >   drivers: mtd: nand: cadence: Add support for read status command
> >   drivers: mtd: nand: cadence: Add support for readid command
> >   drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
> >   drivers: mtd: nand: cadence: Support NAND_CMD_RESET
> >   drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATURES
> >   drivers: mtd: nand: cadence: Flush dma descriptor
> >   drivers: mtd: nand: cadence: Poll for desc complete status
> >   drivers: mtd: nand: cadence: Use bounce buffer
> >   drivers: nand: Enabled Kconfig and Makefile for cdns-nand
> >   configs: nand2_defconfig: Enable configs for nand boot
> >   drivers: mtd: nand: base: Add support for Hardware ECC for check bad
> >     block
> >   drivers: mtd: nand: spl: Add support for nand SPL load image
> >   drivers: mtd: nand: Enabled Kconfig and Makefile for Cadence-SPL
> >   drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE dependency
> >   drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nand SPL
> >
> >  arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
> >  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   28 +
> >  arch/arm/include/asm/io.h                     |   25 +
> >  configs/socfpga_agilex5_nand2_defconfig       |  169 ++
> >  .../mtd/cadence,nand.yaml                     |   98 +
> >  drivers/mtd/nand/raw/Kconfig                  |   19 +-
> >  drivers/mtd/nand/raw/Makefile                 |    2 +
> >  drivers/mtd/nand/raw/cadence_nand.c           | 2386 +++++++++++++++++
> >  drivers/mtd/nand/raw/cadence_spl.c            |   96 +
> >  drivers/mtd/nand/raw/nand_base.c              |   71 +-
> >  include/cadence-nand.h                        |  528 ++++
> >  include/linux/mtd/rawnand.h                   |   13 +
> >  12 files changed, 3424 insertions(+), 25 deletions(-)  create mode
> > 100644 configs/socfpga_agilex5_nand2_defconfig
> >  create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
> >  create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
> >  create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
> >  create mode 100644 include/cadence-nand.h
> >
> > --
> > 2.26.2
> >

Hi Alexander,

The patch I leverage is from the path /drivers/mtd/nand/raw/cadence-nand-co=
ntroller.c  from the stable version 6.11.2
 Please expect the next version of this patch,=20
in which I will remove the "this patch is to" commit phrases and minor refa=
ctoring of code to match the stable version 6.11.2.

Thanks
Dinesh

