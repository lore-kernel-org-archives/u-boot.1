Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC192C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 05:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF898746C;
	Wed, 31 Jan 2024 06:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mOvJ39VO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4AF87729; Wed, 31 Jan 2024 06:22:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E6AB871A7
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706678549; x=1738214549; h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=dt3UH2dSVLsuSWmZ3BAvj0YnZcqZNZT7EjoH4CtqZBU=;
 b=mOvJ39VOq2ic7hL1POp+4S/Ov5N8PTVgxQDt25mfp8QSuZ1pt9yNI4Z9
 KKN7X0Bp0YENRHm8phHXX45llep/VGoeX3liJyjfdwZ7aNimcG/uc1zot
 uf5L4PSO4/tMJMV8uxZWNJVntrW7nl7jvhwFlVM2E1wcSfouuu73p3TRi
 jQKYoyv9jAUvlibk6WXrlq1rnDJG9nRAsnhRCMHqtSX7gMV6vTBsiSRzD
 oLG3zJ7XsiCvdhqPuOXLuOQu8WN0kp6yRkKa6UXMQJg0sIzpzXep9iBN0
 KyUYPAtE0uy8nyLxkYodpUnhw2SQtiZmgPvhweEK9DvMsabGs7ZWfRoc8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403112038"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="403112038"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 21:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3922479"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Jan 2024 21:22:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 21:22:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 21:22:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 21:22:26 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 21:22:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh/mQfYge+3D5mBMzh7ea9KQHnOWe6H3M0ODqHITGr2z7ll2Vn3YrfYuWKjDp7W7CMgO8cTe0CMRZ2Lb05ieT5/6pnkuQQ0Mdv7ZYvFJyF4G8GgQwXRfpDhX8GmGz+yedYzVv+oMcZI7IwFtWboUrFNKUUl8hnJ1beTWfzH9Rl4v7wtYgjogmbqQpE7BwnSQEgo4UNh8aagFfNb4+0Sg+wuxXy7Y4n/tQ/PQFvcNGLWr9N3BXA36xz3LD1MH/7l3sKpgpRjfDSg6JCmcrgjI1FCE15yXXMv4T2SyjaKP2szUlyKdkFu6ZXAiuGOTXHXSANk/ZQUaFH949YvjhhNWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt3UH2dSVLsuSWmZ3BAvj0YnZcqZNZT7EjoH4CtqZBU=;
 b=ksGJvgr3I8vc8BjqkBGT9lh3IoR8Wi9bhAS2q2QFzurCdXCEdlznNsz2mbQ9hXE3ppU9Fi7HJ74sQ3AotST7xkpFf7BqAtiydVQR5J8tI+DkVZx2AkZfnXyMtYYoIIH2CGZs7j6SlZpR5bnXFNVEKgIrv6Hno1LbxG8gP/4Tng/PLSjb0SD9tu8gMOkY0vC/OBtaM1WKjUK2Bo7q87CmSB0Ee/O6w6QHwfD10yCVYjiomXv2dGw3hECbTSaBeS4QeDvW1kPR8PSwy6vu2vnLAlQVvM50cQY4X7TLCqW2UbyqBy0Tl4b/CAtPgVelEg4Ub7tuRBCE0si1q6uI2pM9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23)
 by CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 05:22:24 +0000
Received: from CO6PR11MB5585.namprd11.prod.outlook.com
 ([fe80::15d9:dc9b:64a8:c93a]) by CO6PR11MB5585.namprd11.prod.outlook.com
 ([fe80::15d9:dc9b:64a8:c93a%5]) with mapi id 15.20.7228.036; Wed, 31 Jan 2024
 05:22:24 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Daum, Alexander" <alexander.daum@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/1] socfpga_de1_soc: Specify Uart clock in dts
Thread-Topic: [PATCH 1/1] socfpga_de1_soc: Specify Uart clock in dts
Thread-Index: AdkgPdOkwIVbRbEWQdyCP+tiVerQFkzx2UcQ
Date: Wed, 31 Jan 2024 05:22:24 +0000
Message-ID: <CO6PR11MB55854C5796874CF52DF88ECBD27C2@CO6PR11MB5585.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5585:EE_|CYYPR11MB8405:EE_
x-ms-office365-filtering-correlation-id: e3c0ae1b-7804-407e-9885-08dc221c9b7d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WjCsa1WTVYUzILh/ayn2xNKlmK3qw7cMCiFfRt0QkYIOf4SsJu8/oOfUTtIw+F33aQqz8hqls/o5r+DDzvei7H2tRyzSEJrQpnxsApA1rHX059dhpoUSyRJ3hMv4zv8EraolON9xAFiTmgtQmWf1Mbg1RaXjtDKut5u6nCGIm6xDkXwMRK5obsEg6vtlnLJrZFHB+CwY8PvsBaSpGruyP0pUt6SqApLcJ5Hd0R4U5iH+suQl3rpOXvReZO2E2lYxXUGwrUhmMAHdLlUcvWt5puqwfqfvVt+cEro+Y5ISe8+CyTQR508z71i1LKaZXJcEWdPHTGv+rgcjPlB9/NRTNTJA/kZBtd2MGCFD+7GdfN+r23Q4vynDD0hWfQ+oHshFpaNcTi4HgJ9JzN4VLhAbujLKVbJXlIkjWwVI7xwiVgUp9YDScKZPjZH/uCBXX6n13Sw+KsfpEV7Jorm/mwbdUtS7BBAkstV2Qe7R3MlwY3wkRNSsgRKNdh3g7pzX8vYIrLk3/HDhYzyZtJPlrEwGYu7P/3VdSGZUl3+twSCl51mx2XVRsBj2CM+fiG4ul16JmPV4KqEASps5tGqgXbKk4BYHh93VUX3gMp1vMDvJKz4h8yWpHJAPL+R5mPa8999H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5585.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(83380400001)(478600001)(53546011)(41300700001)(6506007)(7696005)(71200400001)(8676002)(9686003)(8936002)(52536014)(122000001)(55016003)(82960400001)(316002)(64756008)(66946007)(66556008)(66476007)(66446008)(2906002)(4744005)(33656002)(5660300002)(38100700002)(38070700009)(76116006)(110136005)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L09sN3hvQlZMZnh6TkhPRW9hMHR5UXZsTzRJSTVoZFB3NEhaSTQ2R3RoV2NG?=
 =?utf-8?B?Snh2ZWRnais3TmR2emw4QkJsUmVnT3NVN2FWOWNoWjMzc2w0b3RhMzQzYmEz?=
 =?utf-8?B?dlUwRS9sRllWQ2d1cFJqa1lsbFJUcGtwUHZPMnFGZlp3S1hhbThvV2d0Q2lE?=
 =?utf-8?B?d0gvNUtSYlRVTnd3K0ZZbHlLRk9QN2Noc1E5MXYyUys0UXV0bEZza1R3MHRO?=
 =?utf-8?B?WHhyM0I2VERjL3hjTVBFdFNPWjI3M2liYm1yNkFPYlpTYThCenJpd0h4dk1F?=
 =?utf-8?B?QmlLakN3MVhGRWZGaXV1QUpVOUZBNkRpZlNHb2pwdVJubGRTdURhK3YzeTNn?=
 =?utf-8?B?YjNva1pFdG1VNFRzbFd4L1krZWo1WGQxMGdZQmpnektKTDJvSE1aU0oxLzVZ?=
 =?utf-8?B?NjlxNC9LbEdXaEtOZitLNkh4WUZwZ3g5a1FnOWJudGhjZDYxcGNEU0k5bWxH?=
 =?utf-8?B?TExBK2dvRVI3TTJlWldjODVCZTJady9MWmZvT1FsVGYxR3dQelFMVU5PdTZj?=
 =?utf-8?B?NzNXTWY5bHZNVzBEMUpzcDdMRldBKy9lamMrbUlJUllKbWNmd3pSc2NiMDN1?=
 =?utf-8?B?OThDRzg0U0h2eDZRdkdLT2lMZ2paUjJLb2NsRVFzditRZzdwZ0xPWDlKbEIz?=
 =?utf-8?B?L3BNaDVmdmhhRWR6Z0VNTXBZT3Ird3Rrd2w0Wmswa0lLMVN2TlNKd05vNGdl?=
 =?utf-8?B?M1dSMWFzNXlUZVI1a2xVVDRKMFlYR2NtZ3RwWU5nOEhNUGJ5OWhHakppcEM5?=
 =?utf-8?B?UXZFSFlZcXBIMEN2ejYwYVRXd21waGxydGRxUWVlZW8yUDRqazd3Z1k3eENN?=
 =?utf-8?B?bFpTdS9URm1HZkRBWW9mYmgwaXNyQ0RJeTlyWlV6SldjditDdDZLQ3F0Q2lE?=
 =?utf-8?B?TnpYZE5BTHlCTTRvYzRVWmhNY1NTNnVoeTVNa2xVOGlqNDNhTXRYeUVKTXZY?=
 =?utf-8?B?cEdwM3ppTllzbk5ieW8xdmg0T1dMM0s5RkIwMFN4SDdOMlJtYnNrTjNHaXZ1?=
 =?utf-8?B?cXlGUElscnhIRHZCMnh4cTBpc1ZIbWVPSjVOTlNkcHZRTVA4RHNpVXRGTnNU?=
 =?utf-8?B?K3k5TEo2NFdkUUVLSVlnY1Qvd1gxMGNDQkc1UjNBRXY2YWRKdUljSTgrRStS?=
 =?utf-8?B?TDd0a2xYQWZyZkVhdFhhZ2p5cjVJbHpNMnBKVytPMHZUejRLenZBQ1J3MVh2?=
 =?utf-8?B?aG1SWmdSOVMyUWFuL2QyRkF1NHFiNWtLb0J4eWxzSUNOZm96Y0lwWkM1dnYv?=
 =?utf-8?B?ajlBU3JSaEJXdWVERlEwMkFPN21OcVhKTW91TkhPeFdQbHlUdHZpaC93U2R4?=
 =?utf-8?B?eU5KRlArcEFiclNibUE0N1p1N09VNVNkSy9KMk5ncFVmWWQyUEVuOHp6SFBJ?=
 =?utf-8?B?MDFnM1JjdVJKaGtMOUlLMU9CVHpJN2EwMVVFdEEycjdDaGxzeWtNaE1Ma2JX?=
 =?utf-8?B?anQ3U2NVUlBYOWt3K3BpRFRKUjZFd0VhYzhGWVU3MXBlWnJTWGhrM0ZFRlhm?=
 =?utf-8?B?QnloQ0l5MFVVa09vY3lZSnBzNkZEN0tKS1lxbmQ4aG5VVjN6Tm9tbTlPZlYz?=
 =?utf-8?B?bW54WnB6d2N6ZXdoNnkyZWJjMHlWdmtXaG9HWUNqUms2SlIvT0RPYWVrVThE?=
 =?utf-8?B?Tytnc2Z6OHpBZ2NPUVlBWWJNWUNLUHlYUGpnL2sycnZ4NjMzditWR2FBa2lI?=
 =?utf-8?B?ZC93TjhxSnpHdFhxbUFLUkt2akkrNTZpeEhMb2dUOTVmOVRLQWQyQ010V3J5?=
 =?utf-8?B?a1lva0dVOFo0eEI0K2YySFp6UlF0ZHppbmFCeG5SeWR4bE5WTE8xOGNLbmJZ?=
 =?utf-8?B?aktIcnVOcGFwVVhIRjhwZ3hpbVlMVEo2bXQ2bnI2U1NkU0U2RC9YaldYcHZE?=
 =?utf-8?B?RjNvU0srYmlJRnJTcktVZndBdXRsK3FVK1BxcWJxWk15NDlJV3NIVUJjM25r?=
 =?utf-8?B?NHZTVGRuVDFmYW9ISzJWblE4K2t3VjV4TG1NT1VjN0E4VlNoT3VJZDdENzZI?=
 =?utf-8?B?RWZXNmtrTjNwWDh0elkybG0yUWV3ektLc3N5a09LUVpCYXRoZCtFRm02QWJL?=
 =?utf-8?B?dUVibnkzTzVXRXhrMXEweG1UN1ZGSzJKMnlFZnIxZE1ST05MbEdNT1RaanB0?=
 =?utf-8?Q?xBbkj3FhXmGW7O2vJ85Mo72/f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c0ae1b-7804-407e-9885-08dc221c9b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 05:22:24.2748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/KMgU2mx92E9jywiUYfPI3cHNRjjCvQguHDyK1RocLMP52xdYSC0x6KuO6GfdDXA9udGYQ1EcXFefbZJ7OYmL1ejElejYH/HhJEtBgUvpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVS1Cb290IDx1LWJvb3Qt
Ym91bmNlc0BsaXN0cy5kZW54LmRlPiBPbiBCZWhhbGYgT2YgIkFsZXhhbmRlcg0KPiBEYXVtIg0K
PiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgNCwgMjAyMyA1OjExIEFNDQo+IFRvOiB1LWJvb3RA
bGlzdHMuZGVueC5kZQ0KPiBDYzogIkFsZXhhbmRlciBEYXVtIiA8YWxleGFuZGVyLmRhdW1AbWFp
bGJveC5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzFdIHNvY2ZwZ2FfZGUxX3NvYzogU3BlY2lm
eSBVYXJ0IGNsb2NrIGluIGR0cw0KPiANCj4gVUFSVCBvdXRwdXQgd2FzIGJyb2tlbiBzaW5jZSBj
b21taXQgYzQwMmU4MTcwMjQ1ICgiZHRzOiBhcm06IHNvY2ZwZ2E6DQo+IG1lcmdlIGdlbjUgZGV2
aWNldHJlZXMgZnJvbSBsaW51eCIpLCB3aGVuIHVhcnQgY2xvY2tzIHdoZXJlIHJlbW92ZWQgZnJv
bQ0KPiBzb2NmcGdhLmR0c2kNCj4gDQo+IFRoaXMgcGF0Y2ggc3BlY2lmaWVzIHRoZSB1YXJ0IGNs
b2NrIGZvciBERTEtU29DIGJvYXJkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIERh
dW0gPGFsZXhhbmRlci5kYXVtQG1haWxib3gub3JnPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2R0cy9z
b2NmcGdhX2N5Y2xvbmU1X2RlMV9zb2MuZHRzIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvc29jZnBnYV9jeWNs
b25lNV9kZTFfc29jLmR0cw0KPiBiL2FyY2gvYXJtL2R0cy9zb2NmcGdhX2N5Y2xvbmU1X2RlMV9z
b2MuZHRzDQo+IGluZGV4IGZmMWU2MWUwY2IuLmY0OTM1ZDA2ODkgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvYXJtL2R0cy9zb2NmcGdhX2N5Y2xvbmU1X2RlMV9zb2MuZHRzDQo+ICsrKyBiL2FyY2gvYXJt
L2R0cy9zb2NmcGdhX2N5Y2xvbmU1X2RlMV9zb2MuZHRzDQo+IEBAIC03Niw2ICs3Niw3IEBADQo+
IA0KPiAgJnVhcnQwIHsNCj4gIAl1LWJvb3QsZG0tcHJlLXJlbG9jOw0KPiArCWNsb2NrLWZyZXF1
ZW5jeSA9IDwxMDAwMDAwMDA+Ow0KPiAgfTsNCj4gDQo+ICAmd2F0Y2hkb2cwIHsNCg0KUmV2aWV3
ZWQtYnk6IFRpZW4gRm9uZyBDaGVlIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+DQoNClJlZ2Fy
ZHMNClRpZW4gRm9uZw0KDQo=
