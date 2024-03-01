Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE5AC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 08:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E96887776;
	Fri,  1 Mar 2024 09:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="chdevLO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22338332E; Fri,  1 Mar 2024 09:14:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D1E8723E
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 09:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709280858; x=1740816858;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1BUEpENFWpLpiafgt+nshG8WDx31pBIDPlVe6OR6rec=;
 b=chdevLO4NYdwcnDH/Jt/wIEu4JBHeJP7rORmFm+Er4nQ7NYh8bpU+ejm
 DEObD+ZjsJENie0w1UsMyKM6PWOdk9pT8Hj/izIYEgN8mh4VUKJD9BoPU
 8s0aOAsVAnMs++a+GzNwBB448k1BX1IzEFhJXAJYlR9NVNkYdsDqJ3ty5
 hqRQ2BKVWUFpRIMRYLiEC1Kcx6JtdGhBeVnE2qdi923B4lUtbArtryaYI
 +ktRJ+Ttl8k0FHuE38i87LEBedgIGLA2lKDHFN0aCsi7vaAFcWihHzfHt
 lmePEJ7w6DmKsQ1DyFFmMh8zaNW/N0QwXeuqXhL1KiJiuspaWfVhGGo5f g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7628165"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="7628165"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2024 00:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8527639"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Mar 2024 00:14:15 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:14:15 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:14:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 00:14:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 00:14:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMsD8de0CmJuaGvrvD9ol1HWRn6aKdSnNO46UMj74azxuvuhPSjdK56uuu6ZoE/OIJlkeAOBjBQJpA/s7kX+1ERAto8s8BPeErRiP8TgSNM2qAnl1aJ4De1tDPiCey3rT6Blpm/YxB5pyQsq6KGZbB/NyAtT8ILNY/Dil7zYnWYhCSkjdNLznVvCxvJqop8nzulhl76Vd78+c6JwzLAjDjablUpF0lc5LYxgy5bPE3MzzaXF1RYjFCK0UM4RlwL9bH22q9JhltmCGKZYBmhlUmzDRQzZ7nz9ioGj9S0HNl/z/strMk6akq6BBsOtUdZYIL2HTWNktPeMKXqK4BvMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BUEpENFWpLpiafgt+nshG8WDx31pBIDPlVe6OR6rec=;
 b=GVMdg89HjXldVU/uxRSDqtG+beUXGAcG/pauC2jsKXbHPzZ0aVhw1R1XqzZVaxjx4uVSO3xrMYsfETYs5Jfw0jtvQL+pyXq32HG8ycIwPSZlaVfBjsEYa0wdr7PpHdW8nJ0jieRChlI7baJMh1X9YNhfmLaB1lX0hgbAjmBShg+d6qnHNtvMcT1wCaXkv3gixLiudXHA7VdHh8tmPnaydGK/RtOlbuBy9su4NftFOVBE0QJ6gQBD9idMwoKP6X29TmyDgPwajBgvsQ/uML5TTd/v1djjLpIv5CxFJfDVHPUisQpJR3N7rCIsXLO+CeOjjc1HmKY6yKBKjCkPc3aCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 DM4PR11MB5246.namprd11.prod.outlook.com (2603:10b6:5:389::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.25; Fri, 1 Mar 2024 08:14:12 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571%4]) with mapi id 15.20.7339.026; Fri, 1 Mar 2024
 08:14:12 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: =?utf-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>, "Simon
 Glass" <sjg@chromium.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 1/2] arm: socfpga: arria10: add option to reprogram the
 FPGA every reboot
Thread-Topic: [PATCH 1/2] arm: socfpga: arria10: add option to reprogram the
 FPGA every reboot
Thread-Index: AQHaZaLV1vcd0JS5S0u/f6Fr1S5VLLEilWdw
Date: Fri, 1 Mar 2024 08:14:12 +0000
Message-ID: <DM8PR11MB55922996298353279B537436D25E2@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240222152102.1677445-1-barnas@google.com>
 <20240222152102.1677445-2-barnas@google.com>
In-Reply-To: <20240222152102.1677445-2-barnas@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|DM4PR11MB5246:EE_
x-ms-office365-filtering-correlation-id: c3ec274e-2cde-4887-d870-08dc39c793f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 49iVSnCODpydgSCfh+HgahLYu/gB67QbZU1D7s15jDZD6iqW56hAE5XJTq/bAi2t8+fKC8AgJi7dYek5Lo/pyJflZJ5MMc+gNxIszKTcJVGUQb2mPyn4+jRG70YPHfzA0rDe//5XZxMSfX1YwgWDkocEQqneF7esj3rOLMGB4bDQC2uLpmD23p+bPSL4D8Wk7+yj8jd8xgFEAeI7rlaAGperWVbWoTaUFuN43tdryqJo43HIlXgXnSWcQPcrAVKkKXm3kZoSM4R1AB7eoM/dpq74NB2/uB4D6tmaX+IVzGXUzKMfDVsAj8ArFbe2tAg0jPFZA2SoUad93LJJ53gEr/JfE2gGDh5QdmHYM71+CgUCkNPxFnJU5Fz94x9D5sd1MK5NUfZi5BYWR7rCa1Rv/K9z03dPdDT2eWx4kXQSeQIZAkUHwu2uYYJllF1U8JrQqJnkRVlYH8n/kjihBjTUTIlSVSvMgEPPFI37IZot4w72e4eqzwhNQ3QV50GcTNC5/V+GjG1CMNcq71YW2VpNPfA9AoquouEUbN+ifhM4z+/2tVhBqggp5bAZhczTMV6L+0i2WC1sdbipBx+mF2254RmZF8cbZREVTq8ZOHDVMYpDYcfvX78v72e2ykKfpnLWgZCQ3Bt0351kgpcukbsH9+y4gaQjX4xDqstDz11jNMKpaoutNmHIzJxuZw9ivlZVc2mauQa0+JH1RIzppvgm2Xg296s17jIBDiUHL+0zzDw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDdJYkpUd1NKK1NubW1wdW9JNTNJVms3NEt0OThkNFRYM2oya1AwenZRS2Zh?=
 =?utf-8?B?SmlMUUZyd2N1bVJrRTdkbHpnS24yQzBiZHE1bUlIMnQxN3pkbFl2V29SWDVz?=
 =?utf-8?B?TXJjTTdyUkVVV2tOYlRPSlBpS3puQ3kyYnhsQUxHaXFtYUlqNnM5cVNobHhk?=
 =?utf-8?B?TEZ3SUo1Q0xXSlB4REFzOFNodmR2YVV5WkZ1RHBhS1o1YVEvTWlJQW9XSXZl?=
 =?utf-8?B?K2JvUW9ad1BaT1FpeEJsRE91MkVWOW52S3ZvLzZRVHk3TzZJWjY3RVN0VDNm?=
 =?utf-8?B?WldLOFFsZnRTNUtpV2dGTkpBc2FQWlNwQ0lOUVBpMnJUaVdGdnArODlHblVv?=
 =?utf-8?B?OHROWkRPeWh4OGVpUVlON0NPcXB4UHB0U29pQ21YUURMZENpczJ2UTRVekMy?=
 =?utf-8?B?amhXbzBhMjl4bHU4WnFxTGtYUGdFdzNVYUhYbmhDb3FBUUxoKzVWS2F5REV1?=
 =?utf-8?B?N0NOeVBnSjJxL05EZWJMSTNXM2Fpb01YczAxTzVCWmF1Z1lsZzhBVUdSSUdt?=
 =?utf-8?B?amJSVStuMGhvQWdmblppSit5NzFnOEpicDVlTE9yWVdRZE15ekFTUVRqeXRw?=
 =?utf-8?B?V0lLcVlEVW5hTXAydFJBT3dSSW9pS21TMjE0VmFaYzVRS3VGMkdpZS9mZWtK?=
 =?utf-8?B?S1NtVWJZOTFPc2pFUWFTOVpGY1JJYncwamtheDlHZWpyWGtBWVB5aDFBQ1p5?=
 =?utf-8?B?YTQ5TTFwTFVCcDR3OWN5d2J0NlFLRDlWYitJUm5wS2ErMEV2WXAyQUFTSjhK?=
 =?utf-8?B?dlM2M1paZkIvZUxtWkRzZUZlbUhGU0NtbE4vUnViVnBsUmZrc3d0ZVM2a2dr?=
 =?utf-8?B?dnplakVzaG9oVllvaXRLRXJoN2JiTnFCdzVyYk85WVZ4dlkxMGhubUw2RllK?=
 =?utf-8?B?SHYyaHdDTUxQODRLaFdPN0RjZWVDVXUvRXFjTGV1d0J4bWIwbjk0NXdRczVa?=
 =?utf-8?B?U3VKOWtaM2p5KytvMmVwOWN6UnFHQllnb1g1VVFjQjFyRVhzYVl2amdheDlh?=
 =?utf-8?B?U3c0NExjSUpicXJ0OGV0aVlaVG1OcUFZQWpXdUVvejkxeFpYV1BBR3ZlREhQ?=
 =?utf-8?B?aS92dmp1S3FMK0VCbGprT1VZWlpCaXdvems3YVZxZ3dzVExLcGdmZ2t5SUhO?=
 =?utf-8?B?NS9WOE1NSHNuZU5EOXppSnNHOW5oOUxKTXBQVkU5WldFZDJlY04wVzlZb2FE?=
 =?utf-8?B?YlRlVVVFckZ3eGRRaXN6RDJaU1VNU0NudEs2TGpISUMza2tSSnhROUhYZW1a?=
 =?utf-8?B?cnUvd0hWNmVDQ1d4enVqdlVvTEI1a2VlU1RFMkZJbkJRWGpqeC9pMmhyUkYr?=
 =?utf-8?B?OFkyaDhBdm5CTDkzL3Y3WHZtNjFyYVF2T0JFbEhUYmlQZHEycjZrN3F5amRv?=
 =?utf-8?B?Yi9RQVhmMFZtdjUybnE0U3lJMzlNYy81RG5jNkxmUlFYUlRhTlI3Ti9xV3B2?=
 =?utf-8?B?UFJMTzFUVnloek9RMzhCTm45MmxTTUxsRGgrZlFiRTN3SVZZaXRrOWZLYVZR?=
 =?utf-8?B?RXIyV3RweFhOdFVEMUoxclZscytYSHZWUnFvOURvNUVOQnp0SmxxclF3cERr?=
 =?utf-8?B?bWhsWFBRRG40cWh2NHU3VWUydFc4dDdraGNFeUlqWXcwUU0reStRck5xNUgz?=
 =?utf-8?B?VjBVNVpOM1EvcGFDRWRwTFVpaXNsenRFeDVGRkJtRVZMaWJiemV1WExIQ282?=
 =?utf-8?B?OFhDUXk3cTdoTlFBdUxLSEIzVlBoY3E1TzQvQ0tEbERhdEdvYWJUNStYQTNT?=
 =?utf-8?B?aWg1aGpnelBSY21kRndZd3FKOEVEcTd4ZXNLemhxY09jRU14NnBnNUFXckh2?=
 =?utf-8?B?UURvdDBpSm04YjgvVzJzZEdBUkVnNUxkSVEyTWpLZmR6TURYSzFJZC8xeUdo?=
 =?utf-8?B?Z1JlT3FvNjNWV3RpQkpST01GYS9NaHBKdXZBdGhSQ2ZPMDErdDJiNGMzb0dt?=
 =?utf-8?B?Zm1VdzRVYXpYb1pISE00VEtDQnF0ZjF1akhURTBCMngzSUFicHVyVWVCMXN5?=
 =?utf-8?B?YTR0Y2hDSkVaUndNOTZFd2s4eWNLeE1XZmsydElpVzlqMnlQTkJzZDRmR1Zw?=
 =?utf-8?B?MTNLQ2hxNHBKWHE0T2tMTkxIa2xaY0xib1ordkNYWVZuK2ZYUXRVZS84a2xT?=
 =?utf-8?Q?utLHl3XOa6smIDwPvbhH2oYW/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ec274e-2cde-4887-d870-08dc39c793f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 08:14:12.3154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3bSrWBjgi3QmIC9Sl0Lm8xGsVOo3eSyBRJdc/joWzodl465Ht1ccQ+bQFUsPhiiFMGDQGl31HJY+LvsRxjZRiVKV+2a5sV/Oo9M5hU1Vuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5246
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGHFgiBCYXJuYcWb
IDxiYXJuYXNAZ29vZ2xlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDIyLCAyMDI0
IDExOjIxIFBNDQo+IFRvOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogTWljaGHFgiBCYXJu
YcWbIDxiYXJuYXNAZ29vZ2xlLmNvbT47IERpbmggTmd1eWVuDQo+IDxkaW5ndXllbkBrZXJuZWwu
b3JnPjsgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+OyBTaW1vbiBHbGFzcw0KPiA8c2pnQGNo
cm9taXVtLm9yZz47IFNpbW9uIEdvbGRzY2htaWR0DQo+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRA
Z21haWwuY29tPjsgQ2hlZSwgVGllbiBGb25nDQo+IDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+
OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBh
cm06IHNvY2ZwZ2E6IGFycmlhMTA6IGFkZCBvcHRpb24gdG8gcmVwcm9ncmFtIHRoZQ0KPiBGUEdB
IGV2ZXJ5IHJlYm9vdA0KPiANCj4gQWRkIEtjb25maWcgdGhhdCBlbmFibGVzIEZQR0EgcmVwcm9n
cmFtbWluZyB3aXRoIHdhcm0gYm9vdCBvbiBBcnJpYSAxMC4NCj4gVGhpcyBvcHRpb24gYWxsb3dz
IHRvIGNoYW5nZSB0aGUgYml0c3RyZWFtIG9uIHRoZSBmaWxlc3lzdGVtIGFuZCBhcHBseQ0KPiBj
aGFuZ2VzIHdpdGggd2FybSByZWJvb3Qgd2l0aG91dCB0aGUgbmVlZCBmb3IgYSBwb3dlciBjeWNs
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgQmFybmHFmyA8YmFybmFzQGdvb2dsZS5j
b20+DQo+IC0tLQ0KPiANCj4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9LY29uZmlnICAgfCA4ICsr
KysrKysrDQo+ICBhcmNoL2FybS9tYWNoLXNvY2ZwZ2Evc3BsX2ExMC5jIHwgOCArKysrKysrKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vbWFjaC1zb2NmcGdhL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLQ0KPiBzb2NmcGdh
L0tjb25maWcgaW5kZXggMTE0ZDI0MzgxMi4uODkzMDNmMWYxNiAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm0vbWFjaC1zb2NmcGdhL0tjb25maWcNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1zb2NmcGdh
L0tjb25maWcNCj4gQEAgLTgwLDYgKzgwLDE0IEBAIGNvbmZpZyBUQVJHRVRfU09DRlBHQV9BUlJJ
QTEwDQo+ICAJaW1wbHkgRlBHQV9TT0NGUEdBDQo+ICAJaW1wbHkgU1BMX1VTRV9USU5ZX1BSSU5U
Rg0KPiANCj4gK2NvbmZpZyBUQVJHRVRfU09DRlBHQV9BUlJJQTEwX0FMV0FZU19SRVBST0dSQU0N
Cj4gKwlib29sICJBbHdheXMgcmVwcm9ncmFtIEFycmlhIDEwIEZQR0EiDQo+ICsJZGVwZW5kcyBv
biBUQVJHRVRfU09DRlBHQV9BUlJJQTEwDQo+ICsJaGVscA0KPiArCSAgQXJyaWEgMTAgRlBHQSBp
cyBvbmx5IHByb2dyYW1tZWQgZHVyaW5nIHRoZSBjb2xkIGJvb3QuDQo+ICsJICBUaGlzIG9wdGlv
biBmb3JjZXMgdGhlIEZQR0EgdG8gYmUgcmVwcm9ncmFtbWVkIGV2ZXJ5IHJlYm9vdCwNCj4gKwkg
IGFsbG93aW5nIHRvIGNoYW5nZSB0aGUgYml0c3RyZWFtIGFuZCBhcHBseSBpdCB3aXRoIHdhcm0g
cmVib290Lg0KPiArDQo+ICBjb25maWcgVEFSR0VUX1NPQ0ZQR0FfQ1lDTE9ORTUNCj4gIAlib29s
DQo+ICAJc2VsZWN0IFRBUkdFVF9TT0NGUEdBX0dFTjUNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtc29jZnBnYS9zcGxfYTEwLmMgYi9hcmNoL2FybS9tYWNoLQ0KPiBzb2NmcGdhL3NwbF9h
MTAuYyBpbmRleCA5ZWRiYmY0YTI5Li5kNWQzMzI3YTQyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bS9tYWNoLXNvY2ZwZ2Evc3BsX2ExMC5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtc29jZnBnYS9z
cGxfYTEwLmMNCj4gQEAgLTEyMiw3ICsxMjIsMTEgQEAgdm9pZCBzcGxfYm9hcmRfaW5pdCh2b2lk
KQ0KPiAgCWFyY2hfZWFybHlfaW5pdF9yKCk7DQo+IA0KPiAgCS8qIElmIHRoZSBmdWxsIEZQR0Eg
aXMgYWxyZWFkeSBsb2FkZWQsIGllLmZyb20gRVBDUSwgY29uZmlnIGZwZ2EgcGlucyAqLw0KPiAr
I2lmZGVmIENPTkZJR19UQVJHRVRfU09DRlBHQV9BUlJJQTEwX0FMV0FZU19SRVBST0dSQU0NCj4g
KwlpZiAoaXNfcmVndWxhcl9ib290X3ZhbGlkKCkpIHsNCj4gKyNlbHNlDQo+ICAJaWYgKGlzX2Zw
Z2FtZ3JfdXNlcl9tb2RlKCkpIHsNCj4gKyNlbmRpZg0KPiAgCQlyZXQgPSBjb25maWdfcGlucyhn
ZC0+ZmR0X2Jsb2IsICJzaGFyZWQiKTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybjsNCj4g
QEAgLTEzMCw3ICsxMzQsMTEgQEAgdm9pZCBzcGxfYm9hcmRfaW5pdCh2b2lkKQ0KPiAgCQlyZXQg
PSBjb25maWdfcGlucyhnZC0+ZmR0X2Jsb2IsICJmcGdhIik7DQo+ICAJCWlmIChyZXQpDQo+ICAJ
CQlyZXR1cm47DQo+ICsjaWZkZWYgQ09ORklHX1RBUkdFVF9TT0NGUEdBX0FSUklBMTBfQUxXQVlT
X1JFUFJPR1JBTQ0KPiArCX0gZWxzZSB7DQo+ICsjZWxzZQ0KPiAgCX0gZWxzZSBpZiAoIWlzX2Zw
Z2FtZ3JfZWFybHlfdXNlcl9tb2RlKCkpIHsNCj4gKyNlbmRpZg0KPiAgCQkvKiBQcm9ncmFtIElP
U1NNKGVhcmx5IElPIHJlbGVhc2UpIG9yIGZ1bGwgRlBHQSAqLw0KPiAgCQlmcGdhbWdyX3Byb2dy
YW0oYnVmLCBGUEdBX0JVRlNJWiwgMCk7DQo+IA0KPiAtLQ0KPiAyLjQ0LjAucmMxLjI0MC5nNGM0
NjIzMjMwMC1nb29nDQoNClJldmlld2VkLWJ5OiBUaWVuIEZvbmcgQ2hlZSA8dGllbi5mb25nLmNo
ZWVAaW50ZWwuY29tPg0KDQpSZWdhcmRzDQpUaWVuIEZvbmcNCg==
