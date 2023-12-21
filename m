Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77D4C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 12:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22AF087751;
	Thu, 21 Dec 2023 13:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JusuEMJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D3B876E8; Thu, 21 Dec 2023 02:59:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87EF387732
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 02:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wan.yee.lau@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703123947; x=1734659947;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l+JqyBfb3tnxGPtfSoXbQacurqt35om0lRUHqBUfjV8=;
 b=JusuEMJ/kWXf9WK5Wwl6JVWnDbRMa+hvfXQcwifAvOKeo5/ltDLbF26i
 QRIU1az7zOtSgQdiaU0KMpXLb2Z/o7JJSYt9FxAD0DK9N30ODJPRgsNjA
 XA7R5kppQpydnqJMwVIQSuzbGz6f1Lg41E0V2hTNDDoDck0fY9VorX9sh
 8u/nHdZPGwi7QhaNMjN4YhnR1ObKiEyRTED16H3sPJNCmlsUrtTHrY+6O
 ltEKM2UaLShsRn4LkM5qNo2b5YclMgarE/3AYxnUzjw/1yxUT4A1ok5Yc
 n3bEOKGeUtH6tMzQ96qShgmTga+zHVG/jvm4FLU0TKBy2oNSR4ESNdsLh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="398690947"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; d="scan'208";a="398690947"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 17:59:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="776542886"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; d="scan'208";a="776542886"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Dec 2023 17:59:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 17:59:04 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 17:59:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 17:59:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 17:59:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd7pxCw6gJpzsPN8TrbNv/YPpkF0MtHqXP0NviYgcPWeWZ8h2BqWOCGwvoN0LNyzX753yCNoJXU1IimrF5TMXWp9xV1XvngZMRwUsJfst99jMrd1b7WYIP9P2NOqNSe9tOdKzqImUxI9XfwGqqZg8WbSqXKrHDGV8W8VflkHWuUN4acoa6TZB+ZgOcdA8s4FdaiWH7MYyL+NauAT+jz72BdLT5dZTDZAMiqV5S2+cBLsukYr6PjPyJMAadcDG7YKmkTqO4gIN7/ZWEwTVHpgotcYgtmWZ4LkYabJKOgHHXtN34+3nLgwfzYsNK0HeDmJqigaVAmWCU+igKf9kG00ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+JqyBfb3tnxGPtfSoXbQacurqt35om0lRUHqBUfjV8=;
 b=SmJoIp8pVLjGNe68MiH23O9dm1XjXGcNDuBt6pKnJ/89Y15na4DhhSGM5u7eEkdMWZIZBMfGmcAiFWuaKYLWLEHoyTuaDjk/7EbE9wyrTvr4i14jW0Wkmm6JZBPt0obM74VJgZpTgsT8L79ZR0/7yiKQRXQmyzCVdVKBh+HbR4YwT2Hj8Dv0uT7i7GPhsG8mShgh8YulMzfdg47X1z+29P1Fl83bonH/ulkIo98+vxEZg/Wtj88wM6Plo40jh3jIvRA7seJELdw4bt4blQBOQZCAUYFtc2EEh0oczvF2IElFL5gAh9bhWlXulH8u8PRaXbgUEMae9WinK8HgZRQ/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4552.namprd11.prod.outlook.com (2603:10b6:208:263::9)
 by CH0PR11MB5507.namprd11.prod.outlook.com (2603:10b6:610:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 01:59:02 +0000
Received: from MN2PR11MB4552.namprd11.prod.outlook.com
 ([fe80::aa74:7870:c6e7:5708]) by MN2PR11MB4552.namprd11.prod.outlook.com
 ([fe80::aa74:7870:c6e7:5708%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 01:59:02 +0000
From: "Lau, Wan Yee" <wan.yee.lau@intel.com>
To: Marek Vasut <marex@denx.de>, "Chee, Tien Fong" <tien.fong.chee@intel.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Thread-Topic: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Thread-Index: AQHaMklyixczvViI4UynCR3WXVD3cbCwXhiAgAEgnFCAANrwAIAAopIQ
Date: Thu, 21 Dec 2023 01:59:02 +0000
Message-ID: <MN2PR11MB45528C0C90F9EFCF41312795B695A@MN2PR11MB4552.namprd11.prod.outlook.com>
References: <20231208083726.26906-1-wan.yee.lau@intel.com>
 <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
 <edccf82f-2c65-4f09-bd9d-f94765ae015d@denx.de>
 <MW3PR11MB4553AD65903767C338B8E43AB696A@MW3PR11MB4553.namprd11.prod.outlook.com>
 <c85be092-64de-4bac-842a-b7d1d4587d84@denx.de>
In-Reply-To: <c85be092-64de-4bac-842a-b7d1d4587d84@denx.de>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4552:EE_|CH0PR11MB5507:EE_
x-ms-office365-filtering-correlation-id: 0a79ca0b-85f8-48ec-ad57-08dc01c867b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSuxEujLeADqfiJpyyCNg2ELHrybXObtg1Z1+QA5Pq+m0J++9AiFCOcpwz6WpFGSe7wEzmwN67Tppz3jcRZPF3ShwzMqxhHuKVcRPkcva3xxk6mmtjezCl6r8x4Q4NYZfJeR4xZji5v7aeRUCwh1d4YpfQRGVMIjYOSp+Pz2YgZGZ7XnOX6SxSpMqmZmlpMxkAvVWeFqaNlXxF3pwvo6LKdft1CDpIv/nrNw1UZzGaRztzKA5B/kRwPcwnyxl0Sg3SHuqpUb6p1MDkkhU1RyAQyvt26tNkw+ckzKTZYleoJvs7jJ5BHsTtxWBLSy05glGZu/K1FYOmGY+D7n7hYXERt6jb9ww6g5+unoS3COhXJUwj6O0tae5wEai2tfOGgTNIlDLZyqWq68FaNX7o90bVt8TFWLjxan+668IxExI/eseltYOBw5z/M3Ex5H/nmReP7VEqzLdcDtm7Hz7VVMj+SbJKhQPEzeKtQqmjlag6eFO9DS/4DkMffYOwW4THDmZu81klzw7DIOpAF28udcR8QkHBwRl6ZcVy/mpmI6F42QJ18zC7cQ2xjlYurJplRHk9FRJpZIvbhAded5ubuxW6WTefZV1LTSxcKLyBCVITQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB4552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(64756008)(122000001)(2906002)(41300700001)(86362001)(33656002)(71200400001)(38100700002)(82960400001)(110136005)(26005)(66476007)(54906003)(83380400001)(66446008)(76116006)(66946007)(66556008)(8936002)(8676002)(5660300002)(4326008)(7696005)(6506007)(52536014)(53546011)(9686003)(107886003)(316002)(478600001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEpRNldENjJPSWlRMnIvOWloM290K242emtWS0gzQS9sdzlpNFpjdGc3L3FB?=
 =?utf-8?B?aGg1eGtESmNBUUJTVEJ4bEp5STlHamlKeDhXN1RvcEloaVBmSks3UVFLdVlX?=
 =?utf-8?B?aTRuUFdEcmtZamRhWGNhMFRvUUhpMjBnOWhJVzJqZnNjRGtkUkZpMldFSGhq?=
 =?utf-8?B?WDFta0xzbGFYLy9xNjhiVEN3WHJXQVoya25pV3lIckNGYjFleENmMmZsdTV5?=
 =?utf-8?B?YUlURkZrbHBQZExIT1VXU09zTEZnMjkvMWI3VGZ5WDBHNXZvODBoM0RZSXhF?=
 =?utf-8?B?dkgxa0ZVOVdnZXJ0aHZqUUd0K2JSUXRRTTdMV3hsRnVrZ1JiWW12dnVodzU1?=
 =?utf-8?B?VW82RlBFeG80TzNjM3R6RExqLy8rY0cyU2pmaERMaG16cnIweTFKcXJxNEow?=
 =?utf-8?B?UnpESU5wdlJOSXBVRVF4V3lCbzNyaTB3T3JYRUFwcExVZEs2V0VwZVdQRDFa?=
 =?utf-8?B?eTVJRTBIUjJ6NDBHMVF1dXhJZ091ZFo1SFQ4MXNQSCtSTGhpSnZjUmY5NzU1?=
 =?utf-8?B?WjVyT2ZMWmhqV25UTDNhNDI5Q2t3VHhyOFpsaUtYOVg2dmFjbGVzYjBzUnZC?=
 =?utf-8?B?M3IycmJZaExLWGg2MnFKem1NQ1M3VDVCcGw2VTh5MWQzWWdZYWxBMWVTOGNw?=
 =?utf-8?B?U3lMbXBkM1RlODNCNXlNdFZqZ0FBSEV2cUMrM0QvUE5JNTAzTTlwZHMyOWlU?=
 =?utf-8?B?U0g2K0VUaHMrTmJ1YlZxbWlhc2Ywc1pZMStKU2hSWHEzOEFPbWJRU2V1Qkhr?=
 =?utf-8?B?d29NdnAyK3FzTy93SDFJd0hEaC81UENYaGI3Zyt2R2FYOXJZWFNZbFZ5QmdS?=
 =?utf-8?B?UWI0cEJvMWhJY3R2VjgrU2k4N00rS3p2SGsvYnlHQmlVbktrcEU5bE54Um1s?=
 =?utf-8?B?cmZGM25wWjNIVmZYeG1TeXhWZWpKMmt5RkZiVS9oY1Z5R0lqSGpjeXhRbEF0?=
 =?utf-8?B?eG1La0FQTjMrdFJkSStXWExQRng4WVdFMjIwZ2VGT3ZkRnZ2RXhLVmpOVU42?=
 =?utf-8?B?dnBGcDc3cE1uN2JWeTVWLzN3UmtjakRoaUJTY0wwd1YxaG5OaUxCcEZQQ1dS?=
 =?utf-8?B?RkpWZk0xclFhVTU0L0ZjT1ZIYUVxL1cvczBMcmRDTXVpbU90TUJUL3pzTlA1?=
 =?utf-8?B?cUFzSGp5akhTV3RvR1lKTXlKVzVzQkNmZHpZbnNnS1hBSTd5UGt6TDQ5STc5?=
 =?utf-8?B?R1FldklKWU9NeHVpbWY1akJ2V3NFZFVNTHZUYTZUYVI3d0U5QVNDdkQyb3Nt?=
 =?utf-8?B?bnJkK1JjM1MvMXZ0R1hYM0FaZmQxUUg3c0hlRFN6SlVjZHNzRXJvTUtpSHVt?=
 =?utf-8?B?SytiS1NqMXVPOUR2UnBYRmJ6UXg2QXltaFZuNG5HaUEvZkYrRUh3NXR6akk2?=
 =?utf-8?B?Vyt1dXE1bDY0WGtkZXUvWmc2dnNRNmJYSERtdk9uaExLenRBeE42endubDht?=
 =?utf-8?B?SFJLbm9jU2JqdG4ydUFJbXZYUlFZaTZGcWpua3RUOGNZcGdtYmR3L0EveTQx?=
 =?utf-8?B?UUZEMXJraGV1R3dNVDdIN2UzSHVVSWt2ajJUenNTT2QwbzBTTGhqaEpTL3A1?=
 =?utf-8?B?Y1VGWmJkRXBJOVRoS3RwaHQ4MzY1a2diRHJ5ckprYTU0NU0yYTZXOElVR1RN?=
 =?utf-8?B?RlZYSk56Y1RyVmh0akVabDF3Z2twbTlLMjNzN2NhMlo0UnVPS0hGQVNHd2Zo?=
 =?utf-8?B?M096bGRGcXdldTliRitRZEtzRVVkQm5YNlpoY24rWkJLR2FDd05VQTg3S3Z4?=
 =?utf-8?B?MW5OWThFWklYZjhYTnRSZHBiSVQwU1piT1NITVVDYWVWczVrZG9YWXE0Yjhy?=
 =?utf-8?B?MmlGeElyU3BjdDVoOVZnRnJ6RCtxSFM5cmNwNHRQZ05SUUNwenR2K0hRakhr?=
 =?utf-8?B?U290dG5qb2puZkNPbWlEVzZDdmdqZGt3TlN5Y1NRb3plWXRxNUtpUFRYNWxv?=
 =?utf-8?B?OXlMM0JrTVNpbEs3TkJ2QXNDY0lKR0NGOWFsbC9HUTRjekk5VUFHT1Bjbk9J?=
 =?utf-8?B?RzRjMlorWDdqR1haN2Y2Z1hwMXo1T0tEZTNRbkNaeFQ2UVpsVWM2TG9RLzhF?=
 =?utf-8?B?aHVYWmpPZGlubnBiNFY2VTB1Y3RUTUg5V3RNdDE1WmQ3WVV1MVVlWGd0ZW0y?=
 =?utf-8?Q?WtF7a8yHv7tTmdPY42im/amKT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a79ca0b-85f8-48ec-ad57-08dc01c867b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 01:59:02.4540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RBh6NmLYKt3ocEoVHWxIblao9E4CECm6NXqKXhNM8wSXGM6DxIclmW5PZjaAYyCUNotqFFXHUh1fzHascTtTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5507
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Thu, 21 Dec 2023 13:26:33 +0100
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAyMSwgMjAyMyAxMjoxMSBB
TQ0KPiBUbzogTGF1LCBXYW4gWWVlIDx3YW4ueWVlLmxhdUBpbnRlbC5jb20+OyBDaGVlLCBUaWVu
IEZvbmcNCj4gPHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRl
DQo+IENjOiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IEtldmVyIFlhbmcgPGtldmVy
LnlhbmdAcm9jay1jaGlwcy5jb20+Ow0KPiBCaW4gTWVuZyA8Ym1lbmcuY25AZ21haWwuY29tPjsg
Sm9uYXMgS2FybG1hbiA8am9uYXNAa3dpYm9vLnNlPjsgSmVhbi0NCj4gTWFyaWUgTGVtZXRheWVy
IDxqLmxlbWV0YXllckBrZXJsaW5rLmZyPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0K
PiBWbGFkaW1pciBaYXBvbHNraXkgPHZsYWRpbWlyLnphcG9sc2tpeUBsaW5hcm8ub3JnPjsgS29u
cmFkIER5YmNpbw0KPiA8a29ucmFkLmR5YmNpb0BsaW5hcm8ub3JnPjsgU2ltb24gR29sZHNjaG1p
ZHQNCj4gPHNpbW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+OyBIZWEsIEtvayBLaWFuZw0K
PiA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+OyBNYW5peWFtLCBEaW5lc2ggPGRpbmVzaC5tYW5p
eWFtQGludGVsLmNvbT47DQo+IE5nLCBCb29uIEtoYWkgPGJvb24ua2hhaS5uZ0BpbnRlbC5jb20+
OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVsLmNv
bT47IENob25nLCBUZWlrIEhlbmcNCj4gPHRlaWsuaGVuZy5jaG9uZ0BpbnRlbC5jb20+OyBaYW1y
aSwgTXVoYW1tYWQgSGF6aW0gSXp6YXQNCj4gPG11aGFtbWFkLmhhemltLml6emF0LnphbXJpQGlu
dGVsLmNvbT47IExpbSwgSml0IExvb24NCj4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5n
LCBTaWV1IE11biA8c2lldS5tdW4udGFuZ0BpbnRlbC5jb20+OyBUb20gUmluaQ0KPiA8dHJpbmlA
a29uc3Vsa28uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gZHJpdmVyczogbWlz
YzogQWRkIHNvY2ZwZ2FfZHRyZWcgZHJpdmVyIGZvciBJbnRlbA0KPiBTb0NGUEdBDQo+IA0KPiBP
biAxMi8yMC8yMyAwNDowOSwgTGF1LCBXYW4gWWVlIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBj
YW4geW91IHRyaW0gdGhlIENDIGxpc3QgdG8gcmVsZXZhbnQgcGVvcGxlID8NCj4gDQo+IFsuLi5d
DQo+IA0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvbWlzYy9zb2NmcGdhX2R0cmVnLmMNCj4gPj4+PiBA
QCAtMCwwICsxLDExNyBAQA0KPiA+Pj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMA0KPiA+Pj4+ICsvKg0KPiA+Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgSW50ZWwgQ29y
cG9yYXRpb24gPHd3dy5pbnRlbC5jb20+ICAqLw0KPiA+Pj4+ICsNCj4gPj4+PiArI2luY2x1ZGUg
PGFzbS9pby5oPg0KPiA+Pj4+ICsjaW5jbHVkZSA8Y29tbW9uLmg+DQo+ID4+Pj4gKyNpbmNsdWRl
IDxkbS5oPg0KPiA+Pj4+ICsjaW5jbHVkZSA8ZXJybm8uaD4NCj4gPj4+DQo+ID4+PiBQbGVhc2Ug
bW92ZSA8YXNtL2lvLmg+IGFib3ZlIHRvIGhlcmUNCj4gPj4+DQo+ID4+Pj4gKyNpbmNsdWRlIDxs
aW51eC9zaXplcy5oPg0KPiA+Pg0KPiA+PiBBIGdvb2Qgc3RhcnRpbmcgcG9pbnQgd291bGQgYmUg
dG8gaGF2ZSBzb2NmcGdhIDY0Yml0IG1haW50YWluZXIgLA0KPiA+PiB3aXRob3V0IHRoYXQgLCB0
aGVzZSBwYXRjaGVzIGFyZSBvbmx5IGJlaW5nIGFyY2hpdmVkIC4NCj4gPg0KPiA+IEhpLA0KPiA+
DQo+ID4gSXMgb25seSBvbmUgc29jZnBnYSA2NGJpdCBtYWludGFpbmVyIG5lZWRlZCBvciB0aGUg
d2hvbGUgc29jZnBnYSA2NGJpdA0KPiBtYWludGFpbmVyIG5lZWQgdG8gYmUgaW5jbHVkZWQgZm9y
IHRoaXMgZHJpdmVyPw0KPiANCj4gVS1Cb290IGN1cnJlbnRseSBkb2VzIG5vdCBoYXZlIGFueSBT
b0NGUEdBIDY0Yml0IG1haW50YWluZXIsIHRoYXQgbmVlZHMgdG8gYmUNCj4gZml4ZWQgLg0KDQpD
YW4geW91IHNoYXJlIHRoZSBzdGVwcyBvbiBob3cgdG8gZ2V0IHRoaXMgZml4ZWQ/IElzIHRoZXJl
IGEgZ3VpZGUgb24gaG93IHRvIA0KYWRkL3Byb2Nlc3MgbmV3IG1haW50YWluZXJzPw0K
