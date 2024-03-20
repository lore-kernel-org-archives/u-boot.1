Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0379C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1163487F52;
	Wed, 20 Mar 2024 13:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="BzxkyJcu";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="R8wFIjHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F85787F87; Wed, 20 Mar 2024 13:48:56 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9834B87E93
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710938933; x=1742474933;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n1O4zXCVPwirX6yi9yo0t7nvEzqyDWTM8bCBb2pWpHs=;
 b=BzxkyJcumpCSdSIKg9KS4bC+K8C6k6SQ4YNqGXotSe447pcgtltzgbqp
 zejiQxWevR4mI3CG8RbszbNUifq7fwgj3aj3aISTQZGyffDOpAOVbXrs5
 SE4oqRQB0Z1NjZQtdPrt1Do8wCekGXOmVsQISIZQClGKEdnghomS7Kmjc
 WvkBkNLeYW4mpVc3HJkUa+L5E6ML5j33PRDffPqIBEOFRD3uMjO7O5w1o
 3tGoJ+V4+iRlM0BWt4vvHyBD9arhlL9+lr2RI+xoV+uj25dBbCqSd7G30
 ZazAYmd0ZGsDQcH5HRNrC4wHYhymURq7b1lIv4Lw7Y6wovBol5mhOc2Y2 Q==;
X-CSE-ConnectionGUID: vbHx8y0RTgCiWT6MbfRTqA==
X-CSE-MsgGUID: 0eTrqzmxTJGQmnDX7WmBag==
X-IronPort-AV: E=Sophos;i="6.07,140,1708412400"; d="scan'208";a="18431730"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Mar 2024 05:48:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 05:48:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 05:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0VKgy8HnHI0/BcQcGU5Ci+gyGYAs8+tUSCcU1Oy/fBshbzTlwAJX1GWp7FLQ8w9Bxu6DO1h8o/aqqo2eBjZYpwsZXHC5vLqixCwWbmBb9xNu2gsMFjcE1B/15ds/fKx4Kxlk6j0Hcd0CV/Gp5/qhsgzD/NEByb4s45gTev1OoJhj9IjWMD4JsHpFPXCP4QM9om1XDSGkK0CP8sbS4eni2Pj92wyOyT4n3GfugW/6QqoPIZOaaZvJCn+4KcvRSCI+7mOc5EfmJ2kh+F4COaHD9iCO1p2eM5dHRAtnfpCz1O0NuQDWOW51R5MxEgjRmECE/guCyS/atWMcG3u466JdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1O4zXCVPwirX6yi9yo0t7nvEzqyDWTM8bCBb2pWpHs=;
 b=m+0qp+KfgBWJXLOcVDH2zkk1NqmpGr45FmM1iEfckvye3QO/qpYn+Ecacg5Puv5GoUQwYRwm53LZpkFwn44t7zs1uy2P1NtJJQUR5/zInevf7GePjAYyM81p07ZGOyGPBQHn+5z5NRb/uv+/JV+auM1UPcAwrSf5FRjGstBhZsLKTeD9eVgnL0mDvBGmfLQppdbwaWQfBhNFn3Ff5vR8uzklDU3xRJ9WX6xUfp/xmtZ37+15Rse8QqTNWoo3dxv9NCg/gMf5dySjPmVa6uubFt/UsCvZiJAEJwwUiGvUu48qbAabESoKpA3alycpTNfX6Vi+K2kP5AQ6L++N7Yd/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1O4zXCVPwirX6yi9yo0t7nvEzqyDWTM8bCBb2pWpHs=;
 b=R8wFIjHVFD5ujB8WwWQaZi+2UtMok9f4yLu5kuq/X4c12dtpfTLE39VTv8beP2LOhql5mM3ep5gIGQQb3WxybdMhquXelUei06PpF3NQ98eAiIU2JWBGWOI6JlwJWhEC3GfC9XOI7L3Awmx0IOLSk92s2xmQoR45hT78Lsxf/iUvDNcQrdNX+aUSh13Rhq0/Qy1my3caw3g7qBlNnhEKfIbxtJAC9wO0RhNcEdwMDX9/DsisbjoBffnf/TYPOpPXLSQBhZliUMz2kuKpadTyNM0MTltb1/7AtlrOCAtTiRhYw8W1d+I3FVlsAFTUr/d1k2dcqBdBHwjeZJzK43FisQ==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Wed, 20 Mar
 2024 12:48:33 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 12:48:33 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>, <dario.binacchi@amarulasolutions.com>,
 <michael@amarulasolutions.com>
CC: <Balamanikandan.Gunasundar@microchip.com>, <eugen.hristev@collabora.com>, 
 <Bin.Li@microchip.com>, <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
Thread-Topic: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
Thread-Index: AQHaeqVdowafu/slREqOi+gSHR5Ol7FAkqAA
Date: Wed, 20 Mar 2024 12:48:33 +0000
Message-ID: <PH8PR11MB6804590831B23F4D81721C9282332@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240320090214.40465-1-ada@thorsis.com>
 <20240320090214.40465-7-ada@thorsis.com>
In-Reply-To: <20240320090214.40465-7-ada@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|IA0PR11MB7378:EE_
x-ms-office365-filtering-correlation-id: 20799457-9c60-4a3e-2b0a-08dc48dc0d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2BVt/zc4iwCpjx0OonYRUC09f7olBDb5JOq9/RrgJz+EDDrP7pfRH64gHAjEtiQxnyK/BxZAnbL62mWzYDIu1GhPZQUAnKBYO03wpEDBElQDs9EOd8RrniBMHmRSp1sKdorINfVrgzIwxkwRy5hjLkWuQ/AQ0t7K8t7ZCevq8vjnQXNA4oRuJg6dJ6SI9R9mQUK4T1yf3DU9j57P7mKmnbsoyFTd29l5nUuMjXYu5IatRSI0wAHbPg7Gess+o7kCaNLLchRDrvfdRyR3BqRVz73fJhG1zEwfWklF50aAotd1gW3D4aPCV5+e5i3rPHcsQyAxCVuM+7InQDRDq8IBN9I1UxoHCF4D783hfqt+4Vw95nFT3mKbRkwMa3YI4aAI6kncN1GaylNKO7oJVYfJcYf8mZ+UBRSCU7cfnBtg48XYtmOsicLmIYPW91nA6XRJAS98z9DhsAZH3607MoOvvlfvw8zYww0ytkv2t4SM2TVempsuL42LdvmnOV/2md3goiGDlyKAzrWA2CaTQ7EKm0XwDarweOE7nQUv8IsLaiDrdLyWRcgKg7wiXuh2LbRpjGcXgAKZq7QcUg1Lu+ZCNiz/3hY0nKkfLkVMbJJfFMD6jnlc+NMr+ZB3bNs1lXUibtO4u12IARdomFk+Vd8SUiyi1/QFHEKiygGbgRG9ppsQEoFslG/2WV1TMDGNR0b5Xd9R5IHETS2u4Vg5gFM7pvnIlAkVQeQd/LP18SrzL8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OExNd3RWMlZTMUtDTmV0MW02RnFuWGlSd2F2TjhrTmgxRkNWcldLTG9ST0VZ?=
 =?utf-8?B?SDJ5SVl0SDRJVHd0L1lBdExSYm00UWVtVW5vVlJQTGZONlRkOXUwcVcxMmEy?=
 =?utf-8?B?ZHp2RmR3NkFJRVVZR0h0cmVFVXdoSTYrWW8vR1NBZGVoMG5aRUxpSUZzTVk1?=
 =?utf-8?B?eEg3OTRlcndSQy9TSmRobW54MDl5TEJiaE5zL21yblFrcURvZGJOYkE4VTd3?=
 =?utf-8?B?VmxhdUhVZENUSThVR1FzNGh1UTM4aG9tS0VFSGxkckdpaFlRTE5wMEVoN2d3?=
 =?utf-8?B?bld1cFhWVmJvWnJKNGZSL2hjdjVkc2Q1NEFINVdBVkh0Qm5aMVBhU3p5ZEkx?=
 =?utf-8?B?NnJMTVQyeVlCRnhMRFlnNXc0VjZ2RUZWcGsraWZCdS92TkcxaXlVRitYSkVm?=
 =?utf-8?B?NHdhcDcxZVBBVjUycmk1V3FKR2JxSDBsOWR2WVA1ekMxQ1Bmb2dHTVpNM0dO?=
 =?utf-8?B?dk81NFk5NHhDNEVPQVhpUjNhQTdFZDVob080NUZlNk9yKzA5Ti9RbHBoNVYz?=
 =?utf-8?B?S3V1N084OG9IU3dEcEFDQUFxOURTRzJmL0tycXByVjNZMW4yMC9kRWJGZzNQ?=
 =?utf-8?B?cU9DM3NCZFAvK0U5UGEzdHBFVEZyRThRTGs1MWkrdzRLQXdyUC9ueTB5Vk1I?=
 =?utf-8?B?dnRnYkhWWlF0K28walNGQTBabndITS8wNGU4a1hJV2RWaTcyYlBSZVk5NTN4?=
 =?utf-8?B?NXVMekd5UHdFd1EyUWllNE5QUS9xRG5namgxbGFuTjJ0QzNpbWF4QlZncnVT?=
 =?utf-8?B?VHFBcml0MjBWSmRUK2FnWlBwcXYzWmZxeWRjQVdXbElDdDZoQmRBNEpPUXFy?=
 =?utf-8?B?NGx2WE1hMmo2NU9EMHNZMVF6MHhIRGZvU1pwanFvYllNTEVxZGsyQzhFNlhR?=
 =?utf-8?B?a1UrTnN1TDFWcUt3SlJhdEw2SzdZRXhUU015V2RXWlduOE83T1dvdmY0ZllO?=
 =?utf-8?B?dlAyNFdmaEVjYkhJamdVQzFGVE5La3hmeGJOVkpqYnRlRGNyZW1SY1hNVGh0?=
 =?utf-8?B?TVA4SzZCSUk1dDdnTVZpNHE5OTRlTzErbnZQU0tNeGVHc0xXY21UVFp2andh?=
 =?utf-8?B?QXcxZ0tUZGR1bU5FTDFXNHJ3bjIwL1RuK2Vkc3NicS9rU25RUUluc0FjRzlT?=
 =?utf-8?B?NWJvTVYwaFM4ZjkzTnU4Rit4SkxFRFo4UVFrNnkvbE5xcEZvSHpqN1Exa2pK?=
 =?utf-8?B?a0hCUE1PTmZhTDJvd3htc2NkcStCMFVhSnpsWmVhZHlXZkJGVE5tQTdLRys0?=
 =?utf-8?B?cGF1YzV3RkRRNWZDNDBSR0ZOald2eW5IK3RNSURaTE90MlJldHYwMUpLam1k?=
 =?utf-8?B?emRoK2hIdmFmcVZKbzlpT2wzeVRmRjg3b1QwOGJ1SVpFRTJoVk9nUmdLNjI5?=
 =?utf-8?B?bXNqRW5xSUhZSkZaRTlSRndqcUVla0VVdm1KQ0p5U0Vra1NNT1Q1MHJUK1hj?=
 =?utf-8?B?Mnc2dXY2djF0b0tqY0Zpbld5NDFYUS9GU3pVYmN0eXB4RVNZS1F6cjd1emhk?=
 =?utf-8?B?VG45QmlIYWxObnp6NllNWlgzQUZYcFA5NDNUajg5dnhFSjBDVng1UHY5WjVx?=
 =?utf-8?B?Wk5KditTRzMzZUpyNXhzejhtWFRBZkxtMjF2QllTaTQ1UkFSek1NTldPc00y?=
 =?utf-8?B?bVZTb01wczcxcGY4aTMwQWJON3drdE5ZQ3Zka2ZILzlFMElmZUpsZ1NJVG9H?=
 =?utf-8?B?S2ZqdHgyTWNQbUFocDBlSGo1Q1FBWUE5S25PbTVlc3RlL2diMENVSEdmdWl3?=
 =?utf-8?B?WDNIQ1gvV3VUV20vTi94QUdiVWpyYTF2ZmdhcFFJU0VhbGpOUFFHS0FXYjZx?=
 =?utf-8?B?MHZSdnE3QUhRMHdhN1RuVS9haGRMdEU0YjNGb2VTbnVCajFZeFZRNUNLNk9O?=
 =?utf-8?B?ejFUMHc1SUJLbkxlS3pLZDZEb3o3T3Y5TTBMU1Jwa0JWN2krQnhxT00zUDBU?=
 =?utf-8?B?MnJPTnJ1cm9ZZjdQTFEyMjRFSEkyblRBUnRhYk9RVUhWM1VKRlNkMzUxUkl2?=
 =?utf-8?B?bC82eGlZZEFjdUlreE9YQk5veVpWUkY3YUJZMng0QW1Ici82Wkp0MHliL3lW?=
 =?utf-8?B?N1cwVXREaWhoNzdsaUZDVHFUNzJCUTZUQnFJTXIzVVlxbVY0S0hMVnhKQ1Zs?=
 =?utf-8?Q?/OsK+qe+YF0bFlFrjSJYoLGvP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20799457-9c60-4a3e-2b0a-08dc48dc0d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 12:48:33.1606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0fQoAOl/s7PBOeDCuwxMqoV7xU+TN+UCZxGNI8fF77e/GRst3ur/jsjK1LaJKxTuyLBOgNwBH3eykZm3GstFcwteonJsvFFRKwweR2lACU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
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

SGkgQWxleCwNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoN
Ck92ZXJyaWRlIHRoZSBPTkZJIHRpbWluZyBtb2RlIGF0IHJ1bnRpbWUuDQoNClNpZ25lZC1vZmYt
Ynk6IEFsZXhhbmRlciBEYWhsIDxhZGFAdGhvcnNpcy5jb20+DQotLS0NCg0KVGVzdGVkLWJ5OiBN
aWhhaSBTYWluIDxtaWhhaS5zYWluQG1pY3JvY2hpcC5jb20+DQoNCkkgdGVzdGVkIHlvdXIgbmV3
IGNvbW1hbmQgb24gYSBuZXcgYm9hcmQvc29jIHNhbTl4NzUtY3VyaW9zaXR5IPCfmIoNCkkgZmlu
ZCBpdCB2ZXJ5IHZlcnkgdXNlZnVsICENCkkgYWxzbyByb3VuZGVkIHRoZSBtYXN0ZXIgY2xvY2sg
dG8gMjcwIE1IeiDwn5iKDQpUaGFua3MuDQoNCj0+IG5hbmQgaW5mbw0KDQpEZXZpY2UgMDogbmFu
ZDAsIHNlY3RvciBzaXplIDI1NiBLaUINCiAgTWFudWZhY3R1cmVyICBNQUNST05JWA0KICBNb2Rl
bCAgICAgICAgIE1YMzBMRjRHMjhBRA0KICBEZXZpY2Ugc2l6ZSAgICAgICAgNTEyIE1pQg0KICBQ
YWdlIHNpemUgICAgICAgICA0MDk2IGINCiAgT09CIHNpemUgICAgICAgICAgIDI1NiBiDQogIEVy
YXNlIHNpemUgICAgICAyNjIxNDQgYg0KICBlY2Mgc3RyZW5ndGggICAgICAgICA4IGJpdHMNCiAg
ZWNjIHN0ZXAgc2l6ZSAgICAgIDUxMiBiDQogIHN1YnBhZ2VzaXplICAgICAgIDQwOTYgYg0KICBv
cHRpb25zICAgICAgIDB4NDAwMDQyMDANCiAgYmJ0IG9wdGlvbnMgICAweDAwMDI4MDAwDQoNCj0+
IGhzbWMgZGVjb2RlDQoNCk1DSyByYXRlOiAyNzAgTUh6DQoNClNNQ19TRVRVUDI6ICAgICAweDAw
MDAwMDA0DQpTTUNfUFVMU0UyOiAgICAgMHgwYzA3MGQwNQ0KU01DX0NZQ0xFMjogICAgIDB4MDAw
YzAwMGQNClNNQ19NT0RFMjogICAgICAweDAwMWYwMDAzDQpOQ1NfUkQ6IHNldHVwOiAwICgwIG5z
KSwgcHVsc2U6IDEyICgzNiBucyksIGhvbGQ6IDAgKDAgbnMpLCBjeWNsZTogMTIgKDM2IG5zKQ0K
ICAgTlJEOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA3ICgyMSBucyksIGhvbGQ6IDUgKDE1IG5z
KSwgY3ljbGU6IDEyICgzNiBucykNCk5DU19XUjogc2V0dXA6IDAgKDAgbnMpLCBwdWxzZTogMTMg
KDM5IG5zKSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiAxMyAoMzkgbnMpDQogICBOV0U6IHNldHVw
OiA0ICgxMiBucyksIHB1bHNlOiA1ICgxNSBucyksIGhvbGQ6IDQgKDEyIG5zKSwgY3ljbGU6IDEz
ICgzOSBucykNClN0YW5kYXJkIHJlYWQgYXBwbGllZA0KVERGIG9wdGltaXphdGlvbiBlbmFibGVk
DQpUREYgY3ljbGVzOiAxNSAoNDUgbnMpDQpEYXRhIEJ1cyBXaWR0aDogOC1iaXQgYnVzDQpOV0FJ
VCBNb2RlOiAwDQpXcml0ZSBvcGVyYXRpb24gY29udHJvbGxlZCBieSBOV0Ugc2lnbmFsDQpSZWFk
IG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5SRCBzaWduYWwNCg0KPT4gbmFuZCBvbmZpIDINCj0+
IGhzbWMgZGVjb2RlDQoNCk1DSyByYXRlOiAyNzAgTUh6DQoNClNNQ19TRVRVUDI6ICAgICAweDAw
MDAwMDAzDQpTTUNfUFVMU0UyOiAgICAgMHgwZTA5MGUwNg0KU01DX0NZQ0xFMjogICAgIDB4MDAw
ZTAwMGUNClNNQ19NT0RFMjogICAgICAweDAwMWYwMDAzDQpOQ1NfUkQ6IHNldHVwOiAwICgwIG5z
KSwgcHVsc2U6IDE0ICg0MiBucyksIGhvbGQ6IDAgKDAgbnMpLCBjeWNsZTogMTQgKDQyIG5zKQ0K
ICAgTlJEOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA5ICgyNyBucyksIGhvbGQ6IDUgKDE1IG5z
KSwgY3ljbGU6IDE0ICg0MiBucykNCk5DU19XUjogc2V0dXA6IDAgKDAgbnMpLCBwdWxzZTogMTQg
KDQyIG5zKSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiAxNCAoNDIgbnMpDQogICBOV0U6IHNldHVw
OiAzICg5IG5zKSwgcHVsc2U6IDYgKDE4IG5zKSwgaG9sZDogNSAoMTUgbnMpLCBjeWNsZTogMTQg
KDQyIG5zKQ0KU3RhbmRhcmQgcmVhZCBhcHBsaWVkDQpUREYgb3B0aW1pemF0aW9uIGVuYWJsZWQN
ClRERiBjeWNsZXM6IDE1ICg0NSBucykNCkRhdGEgQnVzIFdpZHRoOiA4LWJpdCBidXMNCk5XQUlU
IE1vZGU6IDANCldyaXRlIG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5XRSBzaWduYWwNClJlYWQg
b3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkgTlJEIHNpZ25hbA0KDQo9PiBuYW5kIG9uZmkgMQ0KPT4g
aHNtYyBkZWNvZGUNCg0KTUNLIHJhdGU6IDI3MCBNSHoNCg0KU01DX1NFVFVQMjogICAgIDB4MDAw
MDAwMDMNClNNQ19QVUxTRTI6ICAgICAweDExMGExMTA5DQpTTUNfQ1lDTEUyOiAgICAgMHgwMDEx
MDAxMQ0KU01DX01PREUyOiAgICAgIDB4MDAxZjAwMDMNCk5DU19SRDogc2V0dXA6IDAgKDAgbnMp
LCBwdWxzZTogMTcgKDUxIG5zKSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiAxNyAoNTEgbnMpDQog
ICBOUkQ6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDEwICgzMCBucyksIGhvbGQ6IDcgKDIxIG5z
KSwgY3ljbGU6IDE3ICg1MSBucykNCk5DU19XUjogc2V0dXA6IDAgKDAgbnMpLCBwdWxzZTogMTcg
KDUxIG5zKSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiAxNyAoNTEgbnMpDQogICBOV0U6IHNldHVw
OiAzICg5IG5zKSwgcHVsc2U6IDkgKDI3IG5zKSwgaG9sZDogNSAoMTUgbnMpLCBjeWNsZTogMTcg
KDUxIG5zKQ0KU3RhbmRhcmQgcmVhZCBhcHBsaWVkDQpUREYgb3B0aW1pemF0aW9uIGVuYWJsZWQN
ClRERiBjeWNsZXM6IDE1ICg0NSBucykNCkRhdGEgQnVzIFdpZHRoOiA4LWJpdCBidXMNCk5XQUlU
IE1vZGU6IDANCldyaXRlIG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5XRSBzaWduYWwNClJlYWQg
b3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkgTlJEIHNpZ25hbA0KDQo9PiBuYW5kIG9uZmkgMw0KPT4g
aHNtYyBkZWNvZGUNCg0KTUNLIHJhdGU6IDI3MCBNSHoNCg0KU01DX1NFVFVQMjogICAgIDB4MDAw
MDAwMDQNClNNQ19QVUxTRTI6ICAgICAweDBjMDcwZDA1DQpTTUNfQ1lDTEUyOiAgICAgMHgwMDBj
MDAwZA0KU01DX01PREUyOiAgICAgIDB4MDAxZjAwMDMNCk5DU19SRDogc2V0dXA6IDAgKDAgbnMp
LCBwdWxzZTogMTIgKDM2IG5zKSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiAxMiAoMzYgbnMpDQog
ICBOUkQ6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDcgKDIxIG5zKSwgaG9sZDogNSAoMTUgbnMp
LCBjeWNsZTogMTIgKDM2IG5zKQ0KTkNTX1dSOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiAxMyAo
MzkgbnMpLCBob2xkOiAwICgwIG5zKSwgY3ljbGU6IDEzICgzOSBucykNCiAgIE5XRTogc2V0dXA6
IDQgKDEyIG5zKSwgcHVsc2U6IDUgKDE1IG5zKSwgaG9sZDogNCAoMTIgbnMpLCBjeWNsZTogMTMg
KDM5IG5zKQ0KU3RhbmRhcmQgcmVhZCBhcHBsaWVkDQpUREYgb3B0aW1pemF0aW9uIGVuYWJsZWQN
ClRERiBjeWNsZXM6IDE1ICg0NSBucykNCkRhdGEgQnVzIFdpZHRoOiA4LWJpdCBidXMNCk5XQUlU
IE1vZGU6IDANCldyaXRlIG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5XRSBzaWduYWwNClJlYWQg
b3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkgTlJEIHNpZ25hbA0KDQo9PiBuYW5kIHRvcnR1cmUgMHg4
MDAwMDAgMHg4MDAwMDANCg0KTkFORCB0b3J0dXJlOiBkZXZpY2UgMCBvZmZzZXQgMHg4MDAwMDAg
c2l6ZSAweDgwMDAwMCAoYmxvY2sgc2l6ZSAweDQwMDAwKQ0KIFBhc3NlZDogMzIsIGZhaWxlZDog
MA0KDQo9PiBjbGsgZHVtcA0KDQoyNDAwMDAwMCAgICAgICAgICAgICAgMSAgICAgICAgfCAgICAg
ICB8LS0gbWFpbmNrDQogMTA4MDAwMDAwMCAgICAgICAgICAgMSAgICAgICAgfCAgICAgICB8ICAg
fC0tIHBsbGFfZnJhY2NrDQogMTA4MDAwMDAwMCAgICAgICAgICAgMSAgICAgICAgfCAgICAgICB8
ICAgfCAgIHwtLSBwbGxhX2RpdnBtY2NrDQogMTA4MDAwMDAwMCAgICAgICAgICAgMSAgICAgICAg
fCAgICAgICB8ICAgfCAgIHwgICBgLS0gbWNrX3ByZXMNCiAyNzAwMDAwMDAgICAgICAgICAgICA4
ICAgICAgICB8ICAgICAgIHwgICB8ICAgfCAgICAgICBgLS0gbWNrX2Rpdg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpNaWhhaSBTYWluDQo=
