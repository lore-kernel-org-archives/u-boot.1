Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7C0C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 06:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426B183346;
	Thu, 28 Mar 2024 07:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UdneS8oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4FC880BB; Thu, 28 Mar 2024 07:39:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D9B683330
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 07:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711607944; x=1743143944;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7GJjE6z/L0A9TTrEVbFJ2Ae7vzMsmunLTfchtp/aLXM=;
 b=UdneS8oqWPibIYugUYBTGeXdzdrJhydAkcK8fVH1IOi0rVpB/ziFscb6
 24kQcBQk4cRDK3YDNmSD2j8fHC0f2RRZmPZ+HMXxF8fyeE7c0Tx/CgFOL
 yMxp4qNHKqrGsyPBKQYC/JdBTsFQuVE+ml1Wmt8/9fHHpka/psTSKU4Rd
 JgkinVz/J6l6sEjiegxxzyuvPHnxkNpveyUUVSwi7QrpnODGU2xEPszkb
 0tIyBEu1ZNxo1OInrx2e/F9fkYpTJftb65VAbKw0IiQ/PTIPPJ3OBFsZr
 xUsxqv7+je7jZLgRBDnD/HsZe3dEU9ZlSclZdOLYIZWyeAobfSdtC3xOn w==;
X-CSE-ConnectionGUID: FXuSt41tSGCXcA4ygWxAEg==
X-CSE-MsgGUID: JaoMKKdfT2aptsxFr5C9Ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17375783"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="17375783"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 23:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="16371478"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2024 23:39:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 23:39:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 23:39:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 23:39:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 23:39:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZlHPY5mf5HBvoeYCb3IukF9v3G6SgsqnXupiISGdIrnbsF47piQfZHzLPN91LvFkhGgNxwDH+GxTBcTUvrk1FJGzD5FrwilW+QSzy9sLJU3iyAChHSvT68gmF+qTimbGHFunDmrOn0gZHYmJk/jTIq9Hvp0VZ8gAMC2k0C5YscHK4J7AF55iyRQyISedtvT+7XbZuMIWutIAEYqndQsJ/9AmyI+YD6B7XMQLXdKHcZogn+lO4mMPqvfZ7M+speqm0HWSL531RJVfloDIDlpsylWCjjDKo6/RpuoMGlMhm7AgIC2JRHnD5655rYwzcZPR5jxZRNH1mC1bcJ7g+Kgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GJjE6z/L0A9TTrEVbFJ2Ae7vzMsmunLTfchtp/aLXM=;
 b=L/wt5+C6ClIqlJl+kHQHN5FAYm38bhOSL6UofNDqnnBjfTkE2qdnfNNon6yw7QxHaqwmMtUHs+eogqSPSjuUbFeXr4smhzxovV4b1kH4sC+ywtMw//Z7vi4LfGznvjJzl0rGHuOVE49TWQcHsbfNKkECegUcjrY80dw5Bh6ntyEW1NVl/LEDsg9q2/PaK2Puy1h2AwI23TXFbhq+9T0wXRW1UW/fDKlPGSntBdTFaxnThkPVHvnoOXk9XcKwI8NQmxiCnQLSYtdqpgltbpq2XSF4zYOK4nbaKjzSRdg3iDLLTIKAXXD647gg6d3TTpfhlbyaCsuwYqEyGRHXnPIFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15)
 by SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 06:38:58 +0000
Received: from PH0PR11MB5593.namprd11.prod.outlook.com
 ([fe80::578a:c773:871:ca82]) by PH0PR11MB5593.namprd11.prod.outlook.com
 ([fe80::578a:c773:871:ca82%7]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 06:38:58 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: =?utf-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>, "Simon
 Glass" <sjg@chromium.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 1/2] arm: socfpga: arria10: add option to reprogram the
 FPGA every reboot
Thread-Topic: [PATCH v3 1/2] arm: socfpga: arria10: add option to reprogram
 the FPGA every reboot
Thread-Index: AQHaeioYwDkDP8sswUOFvJnY//7Ka7FMwNXg
Date: Thu, 28 Mar 2024 06:38:58 +0000
Message-ID: <PH0PR11MB5593F58E96A7ADCFB924993AD23B2@PH0PR11MB5593.namprd11.prod.outlook.com>
References: <c0cbfa06-9206-4ca6-ad51-ad7b0e54cf1c@denx.de>
 <20240319181949.3083508-1-barnas@google.com>
 <20240319181949.3083508-2-barnas@google.com>
In-Reply-To: <20240319181949.3083508-2-barnas@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5593:EE_|SA1PR11MB6847:EE_
x-ms-office365-filtering-correlation-id: 20a7259c-e667-4541-32e6-08dc4ef1bf2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWjKIykS4fGQ2Qz71ZNNTk2ToIDRJIHQH/rh+5U5OXc7Xcuyab14kaIczZy0LC4tkYzgC6Fsxvpo3f5JMSz80du227HCqHKPgXvkO7YFcRPVmH+yYdZooU7xCOp7xRXPyAwIKSKzjmVcpWnv9VE6uhMBR1Hz62uEKTwmoqViFIYVytv9jzlMG6CSqA6eWCyyj+YegiWtpFkZspcHMvNGBNp6YWdkJqXhiN3EyZ4TsV1jv1kX2D5R+v8YVHxPqXoTHKMUn+baj1KodbOgBbEkSihY1Q3/zWvHJSY2FXCykA2XjhpXPGZrqrZ3b1EdzaLUMBeT2dmvDtTVf5kQE41Owg57jhQDNhDsjrhI0NnS8/oYrqXPeRCJ8VmvObbqwmDvHYAxyNG+Qm4xHeYNYOrc2JDirmXT9U0b4H8TqGkM4pNzzwiDYc6dtS253kS0qWaGDupuWsiT+KNep9EywHaQqgXhA967sTb4aKM2AXfzDwkMvaWgd3aXg7FmscRQThg58DE0CcDwtdyxDuw4xsQKLUj45tUVQGAZThnP6WAjvnh9l7G9d8n6S0hpxBbSWjZR8IKP2FRNle7wYtSj3bL/HgBMdNucUxgmn9Xts1nlSGjyLrg33sOZgDkXaERPB0P6KB/tlemH7TWKa07Hm278NMvjmMIBfSeSyOV6oOQ96r2XWYokqIMQ/gF9/TWEMSPXaGunwfYpwv28sAJPCcLKl9Is0Xd5SlWl2HSDliYrkBA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5593.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnNQOURaY3V5L2NEYUJjY2lCT08wVnRuMUx6cFkxRmtRNHQrZkFydUhqdm1v?=
 =?utf-8?B?Uk9yanYrZnJlTHBxVW82c2U4YUo4b3d3cm40dVNSQ0c2YmY2Tm5WSHJYcktY?=
 =?utf-8?B?SWNKdWNpbmdJSldQS2lwOC8vZytHL1pLNkxVTDA1Q3Rsb1MzaUtQL0ZYNEhJ?=
 =?utf-8?B?NVpPZlorN045YXhwaHo0Y1M2MW1iVmtmVWRzVWdqZ0FaamZmeXFlU2hacHJi?=
 =?utf-8?B?Z0E3bUF2Z29sSXdBTVBWa3p6K0xhdTZXaStXOWlDMFRpNVRwSFlPM3RvbXlx?=
 =?utf-8?B?S1EwZ3FRSlNWMDhmb2kxYksrN0ZER3I3WHc5TisxZ3hVMmdGdWQ4UGN3OXNQ?=
 =?utf-8?B?SXZNNWtsMmd4d1M0OVE4SjVnMG1DcnhrTkllNkFCRnZ5L1lyK0JwSmhPaGo4?=
 =?utf-8?B?WHZTYTBaVGh6b0NackhyMGhJaDRFNFlGMTIranprUFpDd1FUQWhWNmZGMzR5?=
 =?utf-8?B?cmg1dTFKWldoSEZYUW50dzZaaTk5eW92S0E3cTdYak1PZ2RnTXkzVGwxU2pG?=
 =?utf-8?B?dlhWVXlCMDR5NCtZMjRtWFIvOGZxUGlYM1F0RkkwNG1Ba2NCSVJYYlp5d0g5?=
 =?utf-8?B?NUxSVGFmTHN0dHNNeERKeXowcUptL0tjTHB5SGxEYzI5TzBCTFUxOTR2eWhl?=
 =?utf-8?B?UHN0bXgxTUsvbFZIT3NnL2V5dkorLzMrZk1OWk9nVVVFRkxDbWFrUXlMQ1oy?=
 =?utf-8?B?eTYrTTRrSmljZW9JUzgwZmNxSSsvYmtaV3pocjhpUGtCY0Ixa2luNGVia2FS?=
 =?utf-8?B?bGFmblNBNStCQmZyOFMzdi9KN25hRGVDdEkrc0FlSFZNbklrSkRWNTFLNXRN?=
 =?utf-8?B?U2FVSEVoOWJCQiszWUNTZmdkck9yMm9IeTl4OEVkQ0xlZFFDenBaUi9GbFNH?=
 =?utf-8?B?WkUxb2hGUEFQSU1mRXFneEM3Z1RBU1hGVGp1MThmWFRjV0FKczhwemRJSmpW?=
 =?utf-8?B?TlJIYVI0c2ZsOWNGMS9lcUtrT0tHekljeGxTQVRDMlNGeE5SSjgwSzVXNCtR?=
 =?utf-8?B?TCtSZjVJYUc1QmNORklydVhwZks1Nm5sNkpLM3ErUFZwVjNjaHBVc0VmdEwr?=
 =?utf-8?B?anoyVGhVVis4WTRFUFRvL2ZMTXhwMTBvVCtHRy9MVjEyOEhhQ2ZXNHlnb3py?=
 =?utf-8?B?c2EyenFsbCt6anorWjhmYVRhUUxyVGdQNGNzdkVGeEhCanFwK2ZyMll4cE9u?=
 =?utf-8?B?ZFFEWUE5aENMdlNzNy9jeUFTQWlobzJpb29MSXU2UVBBTGgrQVE1WkpIZ3BB?=
 =?utf-8?B?SXlzZ1BVZTZzaUlJajA3cnRCNHNyQlRpN0YyRW1vYmFZV1N3aWpnU3c4OFkr?=
 =?utf-8?B?LzB5NjJiQ2Z5dTNlR2ZFSk03RnN3aVU0MmNrWU1zNHhHK0xhMFdFbGdFdWhu?=
 =?utf-8?B?NHVSeUNyQ1l1Q3pRS0swTUc4Y2xMVm5IU3FmaUNKTDZMU016NnVvMUo0cWxj?=
 =?utf-8?B?alZXK1M5K3FRd0tqZEFiZSszZTlvcnQzMm03OGlSN1FNckdyd3duRnpLc29I?=
 =?utf-8?B?RThwdFg5ZWJnSXRnVksrWmNyQk90WDJ1MVgvejJweFA2VmdHbnhoVVBaa05t?=
 =?utf-8?B?ZTNZUE5SaG9WMGdVYnRNMVpPUXJ6eVEvTDRqV3RlNHcxMVBMWVAvYVBTSTVZ?=
 =?utf-8?B?SGNLZnFxd3psR1l0ZmNKOC9iaU43bzVKR3RodjhWMmdwbkQ5QnYxTGx1Nmdl?=
 =?utf-8?B?N3VPVFM3L0RLdmxiWjVRa09uMmxmM1RDL0l3R0hqYUFmUlorNDVPTEFiRUxH?=
 =?utf-8?B?dXpBUzFEQ3hJQ0RpUWNkMnB0TXdQSStlTi9McFB1ZEVFOXp4QkFqRWF1elZj?=
 =?utf-8?B?VmZQUU4rU0JhdTFuaEdSTlg1MFI3NnhoRGVHWjZEMWFMWnV2TURQRDlUZHdX?=
 =?utf-8?B?WjB5YTNZa2FnejhpMUI2a3p4WlRJTWw0WVJCc1lMeVRTblR1OSt1UjB2R3FC?=
 =?utf-8?B?eDVQZ0E5YUNxYU9hSGxlRHo2WWVFbGhXaWQxdjZSSzBraWVDMVRsd2VkUG12?=
 =?utf-8?B?dlhyOElmSHZCcW9kL0dnUG9IYW1qRGd1VjlMcXIrY1h6c1hyZ0VxTWJpZ3FI?=
 =?utf-8?B?TmZJajFZanUxQ2JJaU5CNisrVXgrdlNOcGJ1elpzenZvdnJDaHYwT1FrOVF6?=
 =?utf-8?Q?eVKLsb7ELE+a+fgK1QYsZwfeq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a7259c-e667-4541-32e6-08dc4ef1bf2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 06:38:58.1264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqZ/F/bK63gvGShulOsS92mg2RsquBNJYdQgN4pyECp61vT4G7dgmemtBuTOwslhnyrM8ks5/Cwhp3bAhfM8021SwrpKIggRN3CeGPcV4rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
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
IDxiYXJuYXNAZ29vZ2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyMCwgMjAyNCAy
OjE4IEFNDQo+IFRvOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogTWljaGHFgiBCYXJuYcWb
IDxiYXJuYXNAZ29vZ2xlLmNvbT47IERpbmggTmd1eWVuDQo+IDxkaW5ndXllbkBrZXJuZWwub3Jn
PjsgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+OyBTaW1vbiBHbGFzcw0KPiA8c2pnQGNocm9t
aXVtLm9yZz47IFNpbW9uIEdvbGRzY2htaWR0DQo+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21h
aWwuY29tPjsgQ2hlZSwgVGllbiBGb25nDQo+IDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyBU
b20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjMgMS8yXSBh
cm06IHNvY2ZwZ2E6IGFycmlhMTA6IGFkZCBvcHRpb24gdG8gcmVwcm9ncmFtIHRoZQ0KPiBGUEdB
IGV2ZXJ5IHJlYm9vdA0KPiANCj4gQWRkIEtjb25maWcgdGhhdCBlbmFibGVzIEZQR0EgcmVwcm9n
cmFtbWluZyB3aXRoIHdhcm0gYm9vdCBvbiBBcnJpYSAxMC4NCj4gVGhpcyBvcHRpb24gYWxsb3dz
IHRvIGNoYW5nZSB0aGUgYml0c3RyZWFtIG9uIHRoZSBmaWxlc3lzdGVtIGFuZCBhcHBseQ0KPiBj
aGFuZ2VzIHdpdGggd2FybSByZWJvb3Qgd2l0aG91dCB0aGUgbmVlZCBmb3IgYSBwb3dlciBjeWNs
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgQmFybmHFmyA8YmFybmFzQGdvb2dsZS5j
b20+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBSZWJhc2Ugb24gY3VycmVudCBt
YXN0ZXIgYnJhbmNoDQo+IC0gRHJvcCB0aGUgVEFSR0VUXyBwcmVmaXggaW4gS2NvbmZpZw0KPiAt
IFJlbW92ZSAjaWZkZWZzIGFuZCB1c2UgSVNfRU5BQkxFRA0KPiANCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gLSBSZWJhc2Ugb24gY3VycmVudCBtYXN0ZXIgYnJhbmNoDQo+IA0KPiAgYXJjaC9hcm0vbWFj
aC1zb2NmcGdhL0tjb25maWcgICB8IDggKysrKysrKysNCj4gIGFyY2gvYXJtL21hY2gtc29jZnBn
YS9zcGxfYTEwLmMgfCA4ICsrKysrKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1z
b2NmcGdhL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLQ0KPiBzb2NmcGdhL0tjb25maWcgaW5kZXgg
MTE0ZDI0MzgxMi4uYTg5YmQ4Y2E1OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1zb2Nm
cGdhL0tjb25maWcNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1zb2NmcGdhL0tjb25maWcNCj4gQEAg
LTgwLDYgKzgwLDE0IEBAIGNvbmZpZyBUQVJHRVRfU09DRlBHQV9BUlJJQTEwDQo+ICAJaW1wbHkg
RlBHQV9TT0NGUEdBDQo+ICAJaW1wbHkgU1BMX1VTRV9USU5ZX1BSSU5URg0KPiANCj4gK2NvbmZp
ZyBTT0NGUEdBX0FSUklBMTBfQUxXQVlTX1JFUFJPR1JBTQ0KPiArCWJvb2wgIkFsd2F5cyByZXBy
b2dyYW0gQXJyaWEgMTAgRlBHQSINCj4gKwlkZXBlbmRzIG9uIFRBUkdFVF9TT0NGUEdBX0FSUklB
MTANCj4gKwloZWxwDQo+ICsJICBBcnJpYSAxMCBGUEdBIGlzIG9ubHkgcHJvZ3JhbW1lZCBkdXJp
bmcgdGhlIGNvbGQgYm9vdC4NCj4gKwkgIFRoaXMgb3B0aW9uIGZvcmNlcyB0aGUgRlBHQSB0byBi
ZSByZXByb2dyYW1tZWQgZXZlcnkgcmVib290LA0KPiArCSAgYWxsb3dpbmcgdG8gY2hhbmdlIHRo
ZSBiaXRzdHJlYW0gYW5kIGFwcGx5IGl0IHdpdGggd2FybSByZWJvb3QuDQo+ICsNCj4gIGNvbmZp
ZyBUQVJHRVRfU09DRlBHQV9DWUNMT05FNQ0KPiAgCWJvb2wNCj4gIAlzZWxlY3QgVEFSR0VUX1NP
Q0ZQR0FfR0VONQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1zb2NmcGdhL3NwbF9hMTAu
YyBiL2FyY2gvYXJtL21hY2gtDQo+IHNvY2ZwZ2Evc3BsX2ExMC5jIGluZGV4IDllZGJiZjRhMjku
LjM5ODFkMmQ0ZjEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL21hY2gtc29jZnBnYS9zcGxfYTEw
LmMNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1zb2NmcGdhL3NwbF9hMTAuYw0KPiBAQCAtMTIyLDcg
KzEyMiwxMCBAQCB2b2lkIHNwbF9ib2FyZF9pbml0KHZvaWQpDQo+ICAJYXJjaF9lYXJseV9pbml0
X3IoKTsNCj4gDQo+ICAJLyogSWYgdGhlIGZ1bGwgRlBHQSBpcyBhbHJlYWR5IGxvYWRlZCwgaWUu
ZnJvbSBFUENRLCBjb25maWcgZnBnYSBwaW5zICovDQo+IC0JaWYgKGlzX2ZwZ2FtZ3JfdXNlcl9t
b2RlKCkpIHsNCj4gKwlpZg0KPiAoKElTX0VOQUJMRUQoQ09ORklHX1NPQ0ZQR0FfQVJSSUExMF9B
TFdBWVNfUkVQUk9HUkFNKSAmJg0KPiArCSAgICAgaXNfcmVndWxhcl9ib290X3ZhbGlkKCkpIHx8
DQo+ICsNCj4gKCFJU19FTkFCTEVEKENPTkZJR19TT0NGUEdBX0FSUklBMTBfQUxXQVlTX1JFUFJP
R1JBTSkgJiYNCj4gKwkgICAgIGlzX2ZwZ2FtZ3JfdXNlcl9tb2RlKCkpKSB7DQo+ICAJCXJldCA9
IGNvbmZpZ19waW5zKGdkLT5mZHRfYmxvYiwgInNoYXJlZCIpOw0KPiAgCQlpZiAocmV0KQ0KPiAg
CQkJcmV0dXJuOw0KPiBAQCAtMTMwLDcgKzEzMyw4IEBAIHZvaWQgc3BsX2JvYXJkX2luaXQodm9p
ZCkNCj4gIAkJcmV0ID0gY29uZmlnX3BpbnMoZ2QtPmZkdF9ibG9iLCAiZnBnYSIpOw0KPiAgCQlp
ZiAocmV0KQ0KPiAgCQkJcmV0dXJuOw0KPiAtCX0gZWxzZSBpZiAoIWlzX2ZwZ2FtZ3JfZWFybHlf
dXNlcl9tb2RlKCkpIHsNCj4gKwl9IGVsc2UgaWYNCj4gKElTX0VOQUJMRUQoQ09ORklHX1NPQ0ZQ
R0FfQVJSSUExMF9BTFdBWVNfUkVQUk9HUkFNKSB8fA0KPiArCQkgICAhaXNfZnBnYW1ncl9lYXJs
eV91c2VyX21vZGUoKSkgew0KPiAgCQkvKiBQcm9ncmFtIElPU1NNKGVhcmx5IElPIHJlbGVhc2Up
IG9yIGZ1bGwgRlBHQSAqLw0KPiAgCQlmcGdhbWdyX3Byb2dyYW0oYnVmLCBGUEdBX0JVRlNJWiwg
MCk7DQo+IA0KPiAtLQ0KPiAyLjQ0LjAuMjkxLmdjMWVhODdkN2VlLWdvb2cNCg0KUmV2aWV3ZWQt
Ynk6IFRpZW4gRm9uZyBDaGVlIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+DQoNClJlZ2FyZHMN
ClRpZW4gRm9uZw0KDQo=
