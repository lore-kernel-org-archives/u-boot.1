Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3643C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567D7871A5;
	Fri, 22 Mar 2024 11:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="xiUflYNr";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="DWltSMki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957C486FCE; Fri, 22 Mar 2024 11:02:49 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E98F88126
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1711101761; x=1742637761;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uDFYVkOhen4yYjnojvQlkGlHJ/TSmKQi+OgIsPMHLWI=;
 b=xiUflYNrEqIDMB+j5AGsR5G5THGOAom8mMqXeAQ/evC0g6WB6Q+jkTK2
 mg0tkz3WqK/Y3JTvLVaZt+mTxTr4d02y4sCF3WSNKd+D+FostzO+pM/9i
 UddAHFX35MO3bc7OCM9ZbLERoc+UD47NjfeIlGHxaxL1mV2yhcjS/jkf7
 S3zhBxSBdu4/IMvL7/fjbzGGV5UW1E3buT+PHZ1nhJBrtqdYmUFU4SQs8
 kmPGy/fc6jJiahbClaOEUpGQPwDo7fNrh5HQXY04RE86cFWFU6bZFarbR
 a6GzdDHRToaZVLA1ph5RB9auhDJYYLLSp02TZuJ7/42S9aJcjkIKpm9zl g==;
X-CSE-ConnectionGUID: baug0LqaRsi8jMhBi12F+g==
X-CSE-MsgGUID: wEcJcTBDQBGQ6ClWc8k+4w==
X-IronPort-AV: E=Sophos;i="6.07,145,1708412400"; d="scan'208";a="18019149"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Mar 2024 03:02:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 03:02:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 03:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caZ4X1pJLQnJdCwoS5heW4gOj8jsWKOnjOV9EC3TTsGQ/CFVpzjOVisQh2cZJwiy5e8+pWKRtuaokjg7EOV+MIdUOAK3KcDpdCXuHlaR1gd9rO28SDFG2YYlMbIKw7byLBglZ/qMw7MafuGrCRyTGAXxsShxL4t076VYdGw+uaqEQ8HoNYZF3YqoNgYmViHqSkUiSyz5qVeaYTzPmhxQbJMsI139qakiPGRCGl7O4IzjIYmxpoDRiQPjALIjVbzQzrk1+pBkI6aiI2gVH9YJziWk7vQR7MXL6a/GKuwZMlcGI1Ivyxmzb+txShntpuAIIxbp2Zk2e3L6SjUVMnj2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDFYVkOhen4yYjnojvQlkGlHJ/TSmKQi+OgIsPMHLWI=;
 b=eRnNDIrrePBCVQ9gdMjVb8o7+QJz0CXHTWviMaSaVSHHu9Wb5+FBtePk5ODYg0mR+R1Q4/eePhEf6zkCJeXRGkIbMuDn+0cvTaz+xGwQVKJX0pSFhHhUnfZ+L60JBnfLWiUSuzUQLH/7P3fCc9zwQRhLDUIyA5VQd6ne8S7JNkn05mXwadMze9V30IOlnbq0cSXS5qZ7juD91vR/bdlDQoTgJs9xwcQmUafPJKR/C7NHdixShxjS7OqwSzNZ0i8ZGG4G3JbUZNwL2NlMRLmf3V2flMhcrvLtQWRlfNGTOB/YID855dG/LHVgXt6xS+oNFad3P86XMZgOd1YeGPRP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDFYVkOhen4yYjnojvQlkGlHJ/TSmKQi+OgIsPMHLWI=;
 b=DWltSMkiRwk8z2lLWHKEqjf6CGsL28E6F22EryYNYaryFcFE4mi7k9pHEbh5Onj2dJscHOJ0kaBRaYpGpdpzGELYs7VqejoBx0WON91RLb808nZNBJE9cEH37qSxKKbVofL9So8Q0YtQNcGk52ZionRBclX2XvvNe+JoBDF9GY+CHZOL9izL/NoCfn4596EsHBeukUqf7Y4v8fNK3RGE6NMR3DrZC/J/B8gquW1aWw3725dp8JFypTSMe/pBekZUUKnIGrtUg/f7t7Po/vW7Vf0Zyttitvn5uaLMCkMeFwH8yxFZerwuiB2JClRAbOUGpqOEEhQoEBXV5bqNnpww9w==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by CY8PR11MB7338.namprd11.prod.outlook.com (2603:10b6:930:9e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 10:02:29 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 10:02:29 +0000
From: <Mihai.Sain@microchip.com>
To: <michael@amarulasolutions.com>
CC: <ada@thorsis.com>, <dario.binacchi@amarulasolutions.com>,
 <Balamanikandan.Gunasundar@microchip.com>, <eugen.hristev@collabora.com>,
 <Bin.Li@microchip.com>, <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
Thread-Topic: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
Thread-Index: AQHaeqVdowafu/slREqOi+gSHR5Ol7FAqWrAgAFCSQCAAZ0ycA==
Date: Fri, 22 Mar 2024 10:02:29 +0000
Message-ID: <PH8PR11MB680480DD4A44E187DFC4A9B782312@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240320090214.40465-1-ada@thorsis.com>
 <20240320090214.40465-7-ada@thorsis.com>
 <PH8PR11MB680479987099973E85D6CC6C82332@PH8PR11MB6804.namprd11.prod.outlook.com>
 <CAOf5uwmeW0_0rjXgoPBHK2XPYJk=D9Cdw4Qc7rQ_TPuOanCHwQ@mail.gmail.com>
In-Reply-To: <CAOf5uwmeW0_0rjXgoPBHK2XPYJk=D9Cdw4Qc7rQ_TPuOanCHwQ@mail.gmail.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|CY8PR11MB7338:EE_
x-ms-office365-filtering-correlation-id: 262599f0-e06e-45ab-28c1-08dc4a572f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jTrXr+PqALSyTi8puwl4UqoH/zP3QDC7JHzBYneaQ7vWqYhqyas9OxaFGE5e4wxbpgctzl+z+lA27mPDgNJAGbm2m8O60RxaD/W+SnkmyfVTzS9ilc2numm10yvZUAykoR80haXgDiv+1XkQ08tjrqExB4rGxD4kq894WK+LfhvZqJ6415+qZE6qkWdsccXrM6n/Yqatk7VQgmSTYs/15vyPCFptWazs3H1tqgfQjwFPbiY4A1V1zsPvTnawYFNoGH8YenEtIc7HSp6Sy0+N0YsW31DvpjlgOYMweO725LY0KZ+h9K6P9fYckZAfXh2NzVpiJLaS6WZjtukAXlmrDOxxJ+QHGVElmgmBDaROrBTQ0vSWSegrbGoLGUtXazKQbLM1JGsneWQiHEJL8HfEsZtUPmScJTUfK0iacnkMvvaJKrUATEW8sVCvrrCtjvcdMVZ+0xnwcx+DrzjWfbKj47gLf5f64DlzZ+9+VfRWh5YFTiE6rhGtPzBIS0IP0Rq5uE5O8XNLC/pHmgoPkqjeqY6BYov9W3VNqpkIJAhred5S/l/rqKdE425FK6GG4HDUgWIiUlgaNnUqPdsOWQZQzIYgGv9HyNXMbb4P9zJ7CQ516BSMx1aZ7dbM+BQHCzT0uFXI5hmyMReUeLi8kQxdRD4KVOJtH9VrYXLMuBUGzVuyG7IuWxGrN/SSC0nijbycayp/WqLAV2IQHAJSkeV7rg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1BlK1ozbUFpYWR2RzJyR2pxK205TTdNcVRkNE9XV09VZUtidGRqNnpWWnV5?=
 =?utf-8?B?SnVOWjNYRXpSaVpPK0xJTTRLV3AxNDVlRE5KOUVqaUdWcG1HRnVCVFkzZnpo?=
 =?utf-8?B?cHRnLzJvNVJzdGFPRDdvcklXNGlpZ2VudjVKMUxYbHlBR3llSXlhcGw1WlZl?=
 =?utf-8?B?cklxcmdveWFLV0JwT1VNT0Fwek1pejNTZm52djVGTlRZVE53MmtoQlZwRmdP?=
 =?utf-8?B?VHpkQ090TjN2RkhxRnM3TnNMblE2bms2aCt0anI3NTZjTWI4OXp3em1UU05h?=
 =?utf-8?B?cGhIWU4zUE1JQVpndGFsa3VEWm1hd0UyeVN5SGtkTFU1MFVJUlU5elI5S25x?=
 =?utf-8?B?aWNuZFZkZ1dRUHpQOCtnQU1ZRzJ0VVJEUzF1ZXYzaDlpSEU4cHFpNDJWRUVM?=
 =?utf-8?B?NTFQUlQrLzRmdlFYN0ZMT1Rpb3lIUTJyK2ZSUXAyUHlmTWRHelRVM1p4U1Z1?=
 =?utf-8?B?SHFRdHNqMXNCVC8xMHAvK1NQaTdiWUgxKzFZWmhZeW8wYjJsNlJTenU5dERt?=
 =?utf-8?B?M0YrNlg0RnhpNDNCN2oyR3FiV2F6UWxxY2tpR2hTMDlWcUxyZ2JmTTFmMTdE?=
 =?utf-8?B?TjRoVWUzSWRJcDNibzZKeGhhT2Q5eVQ1Q1ljNEtzcnExM2hEeVZ5N28yU01v?=
 =?utf-8?B?TGJqbTV1TE5DajcxZDNSVFBPTHZxdmFiRWZvbnBhQ0NzcElqd0QwTU9Nclll?=
 =?utf-8?B?alJzVHBwZUZnWjI3blV4OXkweCtiak1YYjlrNWh3ako4a2JZQ1dyMFQ1OUV6?=
 =?utf-8?B?bXlVT3lGRkllR0llRW1vR1JCN1VuSmVBQ3k4SWRsU2RiNnh5NjhqUlFqM3Fz?=
 =?utf-8?B?WjZsb2srOUNYNWliMDJWeTl0a1RzUjVjNmljVFdmZmxmUmlSanRKTFFvTlM5?=
 =?utf-8?B?K2k1Q29IR28wcmZyRlFBWFFlV2pIbW1HU1d1a3VQeXY2QitiZkd0TDRTMUth?=
 =?utf-8?B?QmNsK1F6TWIwK3crdWpzMFl4MUxQeS95L3M3VUZpZE5XWWtid1NoZWVoQUw0?=
 =?utf-8?B?ak1INEJEWnZNVEpqVit0dnh0a0NBdVp2VzFTSGc4R0R6OFZtNU9KL2xSZ3J4?=
 =?utf-8?B?L01jV3JuN3hGWmJMbjQybzdSbllReEJ4NUN6Qlh1TEpBSkdIcDRKMVlZVm5o?=
 =?utf-8?B?Y0RoaE9STUo4SHNqVUFLbXp0bjRTTlZrd3hFZzJGaWJXcmhSbHdPOHVyL3lD?=
 =?utf-8?B?aDh4bGZrRnlJM1lTK1k4VUlNaTY0QjdhZXBkUVMvSkcrN2RPZm5admZqMFlp?=
 =?utf-8?B?eWtKeXh3RzFTU0tRazVSNFlDOU81TmlGUnJMVGpDTkRUbStGSkhjSDhOaEFQ?=
 =?utf-8?B?VHk5Z215ajhmS3FlR3V3M2w1R090RWxiNTNjeXhET1Q4LzU4TjZSb29LcnRp?=
 =?utf-8?B?cjMzc0FHb1Y0alRNb28xcVM2UkZJM0JwMTBkWG5hU2ZoREdJMi9oV0F0Y3Mz?=
 =?utf-8?B?ZEJQclR0ZmpwNituVVo0amtlaU1ZcXlPVTJ4ZmRBRmppalhlNTlCRjhnNGl4?=
 =?utf-8?B?cTdYTFB2aXp3ZWhISGRtZjhHemhSQVp4eEpqZkd3b2lwQUR5U1l3UDFHOWRR?=
 =?utf-8?B?Q1pVVjZnR3JaRDRuZ3VjdHZEYlM2eHpBaVV0a2NhV05pNFl5V09tVUQ5NjAr?=
 =?utf-8?B?T3p6Zno1SUlPMkxDQVRHYWV3L0FzMjNjMjJJSFRWR0hVVFlIUnZCNFZ1L2FO?=
 =?utf-8?B?NkFMUCswVmdlYmdGRVpFWmlkdUg0QWpGZXhhYitKM3dWblkxSzJ4KzVrVCtv?=
 =?utf-8?B?cXljMThTN05JN0xKeUh5VFR5VVhnQVRWenRxRGg5TjRySW1vcWJ4T1V5Vnln?=
 =?utf-8?B?Qnp6VWFQNDdjZll4Y1UyZFBSYjNLT1ozTDFYODVGMkpJUUVHNHJYOGN0TFVy?=
 =?utf-8?B?bkZESFBaUUxxR2VrWGVhSHAwNC93enBxTUtUZmtNejBDU3hrQlJwYnRST1U5?=
 =?utf-8?B?UTFoODBscWhnVnFKanpRYldxRFdCb3h5WkpueldpY2lMVGJrOFNQU0dSMzVT?=
 =?utf-8?B?L3VVV0pOMEdBVGkybjVCN2xYL0NDZ3NYQTdNU2VEL1ZyYTZmZ1J0a3BaUXk1?=
 =?utf-8?B?SGk3bVZNUnV6YzJhdUlDSTBwazdMMXhId0ZGa3dkT0FZZ2FUUmdNMEE5bWtr?=
 =?utf-8?Q?C91hx+NosfsLf7Wx+rdLs9ZJB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262599f0-e06e-45ab-28c1-08dc4a572f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 10:02:29.4821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nx6Kr0s1ryaegDDpmlgLRWSpfCiXuQJrAFoCzqW4gfk+/lauUxVsrlxBAnIAPG8jsfBvnbVxElphgkYe+fIX5T5tXyND/7PKqc+eBZfH9Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7338
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

SGkgTWljaGFlbCwNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KDQpJIHRoaW5rIHRoaXMgY29tbWFuZCBjYW4gYmUgcmVhbGx5IHVzZWZ1
bC4NCkxldCB0cnkgdG8gaGF2ZSBtb3JlIHRlc3Rpbmcgb24gbW9yZSBib2FyZHMNCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkkg
bWFuYWdlZCB0byB0ZXN0IHRoZSBjb21tYW5kIG9uIHNhbWE3ZzU0LWN1cmlvc2l0eSBib2FyZC4N
Cg0KSSBhbHNvIGZvcmNlZCB0aW1pbmcgbW9kZSA1IGZyb20gY29udHJvbGxlciBkcml2ZXIgKGNv
bmYtPnRpbWluZ3Muc2RyLnRSQ19taW4gPCAyMDAwMCkuDQoNCj0+IG5hbmQgb25maSAwDQo9PiBo
c21jIGRlY29kZQ0KDQpNQ0sgcmF0ZTogMjAwIE1Ieg0KDQpIU01DX1NFVFVQMzogICAgMHgwMDAw
MDAwNA0KSFNNQ19QVUxTRTM6ICAgIDB4MTQwYTE0MGENCkhTTUNfQ1lDTEUzOiAgICAweDAwMTQw
MDE0DQpIU01DX1RJTUlOR1MzOiAgMHg4ODA4MDVmNA0KSFNNQ19NT0RFMzogICAgIDB4MDAxZjAw
MDMNCk5DU19SRDogc2V0dXA6IDAgKDAgbnMpLCBwdWxzZTogMjAgKDEwMCBucyksIGhvbGQ6IDAg
KDAgbnMpLCBjeWNsZTogMjAgKDEwMCBucykNCiAgIE5SRDogc2V0dXA6IDAgKDAgbnMpLCBwdWxz
ZTogMTAgKDUwIG5zKSwgaG9sZDogMTAgKDUwIG5zKSwgY3ljbGU6IDIwICgxMDAgbnMpDQpOQ1Nf
V1I6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDIwICgxMDAgbnMpLCBob2xkOiAwICgwIG5zKSwg
Y3ljbGU6IDIwICgxMDAgbnMpDQogICBOV0U6IHNldHVwOiA0ICgyMCBucyksIHB1bHNlOiAxMCAo
NTAgbnMpLCBob2xkOiA2ICgzMCBucyksIGN5Y2xlOiAyMCAoMTAwIG5zKQ0KVERGIG9wdGltaXph
dGlvbiBlbmFibGVkDQpUREYgY3ljbGVzOiAxNSAoNzUgbnMpDQpEYXRhIEJ1cyBXaWR0aDogOC1i
aXQgYnVzDQpOV0FJVCBNb2RlOiAwDQpXcml0ZSBvcGVyYXRpb24gY29udHJvbGxlZCBieSBOV0Ug
c2lnbmFsDQpSZWFkIG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5SRCBzaWduYWwNCk5GU0VMIChO
QU5EIEZsYXNoIFNlbGVjdGlvbikgaXMgc2V0DQpPQ01TIChPZmYgQ2hpcCBNZW1vcnkgU2NyYW1i
bGluZykgaXMgZGlzYWJsZWQNClRXQiAoV0VOIEhpZ2ggdG8gUkVOIHRvIEJ1c3kpOiA2NCAoMzIw
IG5zKQ0KVFJSIChSZWFkeSB0byBSRU4gTG93IERlbGF5KTogIDY0ICgzMjAgbnMpDQpUQVIgKEFM
RSB0byBSRU4gTG93IERlbGF5KTogICAgNSAoMjUgbnMpDQpUQURMIChBTEUgdG8gRGF0YSBTdGFy
dCk6ICAgICAgNzEgKDM1NSBucykNClRDTFIgKENMRSB0byBSRU4gTG93IERlbGF5KTogICA0ICgy
MCBucykNCg0KPT4gdGltZSBuYW5kIHRvcnR1cmUgMHgxMDAwMDAwIDB4MTAwMDAwMA0KDQpOQU5E
IHRvcnR1cmU6IGRldmljZSAwIG9mZnNldCAweDEwMDAwMDAgc2l6ZSAweDEwMDAwMDAgKGJsb2Nr
IHNpemUgMHg0MDAwMCkNCiBQYXNzZWQ6IDY0LCBmYWlsZWQ6IDANCg0KdGltZTogMjIuNjM4IHNl
Y29uZHMNCg0KPT4gbmFuZCBvbmZpIDUNCj0+IGhzbWMgZGVjb2RlDQoNCk1DSyByYXRlOiAyMDAg
TUh6DQoNCkhTTUNfU0VUVVAzOiAgICAweDAwMDAwMDAxDQpIU01DX1BVTFNFMzogICAgMHgwNzA0
MDUwMg0KSFNNQ19DWUNMRTM6ICAgIDB4MDAwNzAwMDUNCkhTTUNfVElNSU5HUzM6ICAweDg4MDQw
MmYyDQpIU01DX01PREUzOiAgICAgMHgwMDFmMDAwMw0KTkNTX1JEOiBzZXR1cDogMCAoMCBucyks
IHB1bHNlOiA3ICgzNSBucyksIGhvbGQ6IDAgKDAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQogICBO
UkQ6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDQgKDIwIG5zKSwgaG9sZDogMyAoMTUgbnMpLCBj
eWNsZTogNyAoMzUgbnMpDQpOQ1NfV1I6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDUgKDI1IG5z
KSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiA1ICgyNSBucykNCiAgIE5XRTogc2V0dXA6IDEgKDUg
bnMpLCBwdWxzZTogMiAoMTAgbnMpLCBob2xkOiAyICgxMCBucyksIGN5Y2xlOiA1ICgyNSBucykN
ClRERiBvcHRpbWl6YXRpb24gZW5hYmxlZA0KVERGIGN5Y2xlczogMTUgKDc1IG5zKQ0KRGF0YSBC
dXMgV2lkdGg6IDgtYml0IGJ1cw0KTldBSVQgTW9kZTogMA0KV3JpdGUgb3BlcmF0aW9uIGNvbnRy
b2xsZWQgYnkgTldFIHNpZ25hbA0KUmVhZCBvcGVyYXRpb24gY29udHJvbGxlZCBieSBOUkQgc2ln
bmFsDQpORlNFTCAoTkFORCBGbGFzaCBTZWxlY3Rpb24pIGlzIHNldA0KT0NNUyAoT2ZmIENoaXAg
TWVtb3J5IFNjcmFtYmxpbmcpIGlzIGRpc2FibGVkDQpUV0IgKFdFTiBIaWdoIHRvIFJFTiB0byBC
dXN5KTogNjQgKDMyMCBucykNClRSUiAoUmVhZHkgdG8gUkVOIExvdyBEZWxheSk6ICA0ICgyMCBu
cykNClRBUiAoQUxFIHRvIFJFTiBMb3cgRGVsYXkpOiAgICAyICgxMCBucykNClRBREwgKEFMRSB0
byBEYXRhIFN0YXJ0KTogICAgICA3MSAoMzU1IG5zKQ0KVENMUiAoQ0xFIHRvIFJFTiBMb3cgRGVs
YXkpOiAgIDIgKDEwIG5zKQ0KDQo9PiB0aW1lIG5hbmQgdG9ydHVyZSAweDEwMDAwMDAgMHgxMDAw
MDAwDQoNCk5BTkQgdG9ydHVyZTogZGV2aWNlIDAgb2Zmc2V0IDB4MTAwMDAwMCBzaXplIDB4MTAw
MDAwMCAoYmxvY2sgc2l6ZSAweDQwMDAwKQ0KIFBhc3NlZDogNjQsIGZhaWxlZDogMA0KDQp0aW1l
OiAxMS42NjEgc2Vjb25kcw0KDQo9PiBuYW5kIGluZm8NCg0KRGV2aWNlIDA6IG5hbmQwLCBzZWN0
b3Igc2l6ZSAyNTYgS2lCDQogIE1hbnVmYWN0dXJlciAgTUFDUk9OSVgNCiAgTW9kZWwgICAgICAg
ICBNWDMwTEY0RzI4QUQNCiAgRGV2aWNlIHNpemUgICAgICAgIDUxMiBNaUINCiAgUGFnZSBzaXpl
ICAgICAgICAgNDA5NiBiDQogIE9PQiBzaXplICAgICAgICAgICAyNTYgYg0KICBFcmFzZSBzaXpl
ICAgICAgMjYyMTQ0IGINCiAgZWNjIHN0cmVuZ3RoICAgICAgICAgOCBiaXRzDQogIGVjYyBzdGVw
IHNpemUgICAgICA1MTIgYg0KICBzdWJwYWdlc2l6ZSAgICAgICA0MDk2IGINCiAgb3B0aW9ucyAg
ICAgICAweDQwMDA0MjAwDQogIGJidCBvcHRpb25zICAgMHgwMDAyODAwMA0KDQpCZXN0IHJlZ2Fy
ZHMsDQpNaWhhaSBTYWluDQo=
