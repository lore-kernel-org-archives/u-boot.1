Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7F1C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 08:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0496F880BB;
	Thu, 28 Mar 2024 09:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YF7+GW+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FCC3880BB; Thu, 28 Mar 2024 09:01:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FF388096
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711612862; x=1743148862;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=EeBykxPjWLijXdm/GilBr4DM9CDHdHDxYcupNv+Zi4Y=;
 b=YF7+GW+ppzohu7oZiWNkFd3YjrpmFRDGS2mpOUZfN0zpJmsdMxQ795pe
 pcC0kjal89JcwsxxsxBmmubo/Pzrv/Ji4azdndFjeO6HCDHnYFpvOkAB0
 KATdI2lml6iugufSKk4rJU6aBuwOsJvRKyjVlXKGTh088SVG3KOUwZaBM
 fooH7KD6Zi2f+LxpfzL+dl01DQvqPz8J34sojDVlzQ6J8lPD9R4oLNP38
 DYE38KUu+9M+2YxlsffeITMrXeCYuo/5Cm8AiUs1ntRnL+xvX0Wkqp+va
 aXJ4q3E+YDfomZPbfGxy9g/D7Jnl95IPMQMcREjJVpPegdwYvk7qQfHxS Q==;
X-CSE-ConnectionGUID: SyKczpQbQQSCG4G4/kRdYA==
X-CSE-MsgGUID: doDwFThZQaGm9SVrBLTBYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10545831"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="10545831"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 01:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="16601602"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2024 01:00:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 01:00:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 01:00:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 01:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0AKtoBkuAN/qZ1xv4AzMx1R/hzXEwAetNTskpGjV01spGy3Hmr8FcYh4iYa+E3Vr5oZOBL38Hx/9DaOaCOmDf2mW0NYZcp6AfOTtQ761nf6QqxIoR1t8TdW4ON4yiZIxf/ADHsT10AQRP4dMyg+/ZBKmnauK4phwZPT130y/ILOxfLSjkA5QkYCTkRobh+p4kHFoFtdssmy4b/V6b5aYvlSa9VZflw3xeSLp3JIrzUgB5Li8w294udmp1INgfn9xTOZfiNRIUP7zk0duxKXt1WQE5tBH4BT1W41UpWDKP6INLxEtrPO8182+/mOWUv+5GF8sp4fw3Pi60WLmSB4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeBykxPjWLijXdm/GilBr4DM9CDHdHDxYcupNv+Zi4Y=;
 b=JXaZ+kSSTD5D2Yviwt8X8l/9oufkmcNpwD7EQtA3prf+qZw3mmp1nuwgqSRv5eYOkoeyEtqIuSdU1iYFJVe4eWWLoxwGbigONvJpNwRLPesE19GC7E0O5hM1DmwLSdx04JCLPirZMiO1e3uFb37cQnqOL0Ws5JLcINV3gksxLcQB2u8ycdN850jZGTGizDeyuRN3iNEX8n/KIRQUzR/2fxDT5/kfK50+d/RXCR2A68jR47Xq+R7Qez5XnZFi+StYDq8W3OqQ4QsoxPTU3MJ7mGUdddimM29o8w19LwplBvhaBA2L5YNvS6N6DDOwC6D5DJuBNUdkxDjZhzCh/Dhe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15)
 by CY5PR11MB6536.namprd11.prod.outlook.com (2603:10b6:930:40::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 08:00:55 +0000
Received: from PH0PR11MB5593.namprd11.prod.outlook.com
 ([fe80::578a:c773:871:ca82]) by PH0PR11MB5593.namprd11.prod.outlook.com
 ([fe80::578a:c773:871:ca82%7]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 08:00:55 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: =?utf-8?B?Ik1pY2hhxYIgQmFybmHFmyI=?= <barnas@google.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "\"Marcel Ziswiler\"" <marcel.ziswiler@toradex.com>, "\"Martyn Welch\""
 <martyn.welch@collabora.com>, =?utf-8?B?IlBhd2XFgiBBbmlraWVsIg==?=
 <pan@semihalf.com>, "\"Simon Glass\"" <sjg@chromium.org>, "\"Svyatoslav
 Ryhel\"" <clamor95@gmail.com>, "\"Tom Rini\"" <trini@konsulko.com>
Subject: RE: [PATCH v3 2/2] chameleonv3: set in defconfig for FPGA to
 reprogramevery reboot
Thread-Topic: [PATCH v3 2/2] chameleonv3: set in defconfig for FPGA to
 reprogramevery reboot
Thread-Index: AQHagOYPkBjHPKJXrUiixuYcmPEdDA==
Date: Thu, 28 Mar 2024 08:00:55 +0000
Message-ID: <PH0PR11MB559364D7EA3E74053442D661D23B2@PH0PR11MB5593.namprd11.prod.outlook.com>
References: <20240319181949.3083508-1-barnas@google.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5593:EE_|CY5PR11MB6536:EE_
x-ms-office365-filtering-correlation-id: 1a226556-d506-4e5d-23ff-08dc4efd3203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HULo6319MwZvNySdDXjLHTmNKbFSlJYPerpWYJb1XnNkTiVD7fVgC4hQwFpCoo8yWRCZQnNh826r2lIQ4xur9C+tH4JYbXXmxBdUBPsYJCxSDKFYKEXHiyr9BAuE4YUfgRRSBOymOOB+VeztkEgBHUjtcmL7dDgb9fA+E8NmgrG13wqETJ3wbUj7IVl3TEtU7g20BxC4mOcEhL7cs8vLKRaqglGa2zG+6dAvTTPpBBlRZZiev8XjHC3tTgk+DWRSLWXJFAfVGVKSHZZD8aL50uLuVtdN+6dKm2KelZ39MndLL414LIPTViPJo3MHvOkg4qS+NaQS10TBZDgytPUT0QGoehwT7lkhSbRBnay5vbw2/WeL4Ozax1y41HIkYMt13KIXOAaBpQNSfPbFGvM5MNy+08B8EO2IfvtDUMqNWfzZORdX+s0n7vqBvlx8xkYp7CZ5mI7ClxrEcXRDoj4oj0FkRn1+NyiX3bR2+1t7+DC+s885+mok5yxHef4GfZHt1ycRxf3ZEdLSLC0JO89wFx6Vg2EGVM68CFm2Lk4f7s7+U9bfByehdk5z6bMKHmPQH6qGd5bmFmYcqseha+tgnfo0mwdpgQ37k2xApvMDJYUywfQZ3wRJRuugt/j+laXH8caalaxHjiK63TBhjWu2gVURPHIIMjC6OjQcQRPmqXOKJYuHc6lr0LFYHgeAMoEvquo7HIEy04hOsnkbatsYfXLAO7PBbzPq69D/QBfz1kM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5593.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUd2MktWUWd6VzQrWkFzdkM0TjNzazE3RjIzUnA4bCtJekMwZzhlMWNhVFQx?=
 =?utf-8?B?WXdnRDlSWTlmSkJmRU5NU0JveklHU240cVdEK1dGczRTMWlVUjJTQ3B3aUhz?=
 =?utf-8?B?T3RRMzI5RFVtVzl1M0ExTWQ1UVpHU29McjZJdTB3ay9HL3J0WkFCR01yRDNi?=
 =?utf-8?B?cUltSmt6ZWxETDRuak9kdzFTM0VpalpwYjdKM2dTM01nSlIycGZDUFJrS0kv?=
 =?utf-8?B?aCt5QXZXV2xZTVhmN0o5bzFpV1VkekVpTTg1TGFiN3ZQSVNSVExvbDdkeXhW?=
 =?utf-8?B?VGpxZVZaT2lsWU5mSEN0MXo5bkVWbmpZdThLcWFRbFZRNTJna2NXcE1Za1Ir?=
 =?utf-8?B?U0pmV1E2cHlHeU43WEhJcHdndHRzdVdrR2U5VWpRUU9Hei8yeDJuZk1zWkk1?=
 =?utf-8?B?aUF1dTBwV2YxcXRmYzlsSzJUb1B4Q0oxSkN2WGFWNFk5Y1VZNWQ4dEVVWGhX?=
 =?utf-8?B?bFF5NGdTNXdROHNSbzJOTVkzVUtjRUpPdW40Unlka3F4d2hrYXRIV1k3REpG?=
 =?utf-8?B?TGVrVVEwSWdvaEVuejQxWVdmNEFrZURCWTZoMmtwaEFxUFRqY3JHWFlmTHor?=
 =?utf-8?B?akdkdm10Q1pCNVNXbEI5dHg4ZmFydktXVGpXSTJrZjFrcERzUzdiUFAxTitH?=
 =?utf-8?B?QXNPWXEvaHJHSDB0M3VlZFlNWTk3VmEyK294UDF0ZjI5RGJnSUtMVDlYWVdx?=
 =?utf-8?B?RjBBRDQ4NFNQMTJsbnVrbDh2V2hWVndLM1FGRFhBazVjMklMdHdReDFrakh2?=
 =?utf-8?B?UkN6UlhzWXAzU3MzZTR5VlZBNUFXVThiejZDemRaczUvSXRzeXNGVEp5R2Q2?=
 =?utf-8?B?T0NsdEt2QldWMURJR0twRzV2MTIzcXMzNTNvVkNYQ0Y2TGt3ai9SRUdBZ1dU?=
 =?utf-8?B?VG1qcnJvOFY4U2Y1TEpnN1NiNldkOUZrNzRyWVQvWW1FRWtLUXBXUUNmeDhG?=
 =?utf-8?B?OVZvRFU4L2k0Rk1XcHg2OENCcWRzQVZZNDZIUFJ4ajVqRkxubGFlMDhSOE9R?=
 =?utf-8?B?TDdCVGNWMU5OUStySDAwcnVhSFBNZUN1YUJjZzRGMXVrcnhuOXZpV0tkMTJC?=
 =?utf-8?B?bVEvODh1QUZOU3BmR0N4bjlrQnVMQ1BsTURJSjl4SWlZazVjVGx1WE93NDJS?=
 =?utf-8?B?Y0cyd0xDdHhDejVkTkVlVVdPMTgzK2NyTFJ4ZncxRDFTNHZWNkhGUUdiZkFi?=
 =?utf-8?B?YWU2aDM3WkVHMnJxanZvbW5BY0U4UWl3NkpoWCt6ZnZYN25qWVJiQUVTWjIw?=
 =?utf-8?B?N1dYRXYrTldGMEIwUlpkUUN2dWFpT0ZSRmNaa1dLb3czZDdHQXpjaUJlanpz?=
 =?utf-8?B?K0w4emdtQ3kwY3pTWTlKMkw3bXo3THN4MjF5S25JbzZjNDdJUC9jdzBXc3gy?=
 =?utf-8?B?NlFvL3FMOUpQcCtyZUlmdTdZV3h2c1VMY091YWZNZzdDT3gxRFNma0JHZ2tH?=
 =?utf-8?B?cU1kb2liZmxUVWZWV0orOC9JT0R4N3RRdlpabGhYSGZCdTlTeEdKMTVnaGk5?=
 =?utf-8?B?V1hFOVVrWGpsQjRzQVhUcUZXT01FbEdQUkxYT1dwMFlTNEkvZm1KTDVoV2pt?=
 =?utf-8?B?ZmdKSGpKRkdURndpVHpubDFQNjM4YmJaWFBFbEFtR0htRkdaYXJJeUpnMmw3?=
 =?utf-8?B?ZDRRbjMxOS9oYjJURUxma0R5OHZQNlVsWnJ4ZWVncDlxMVZlWHJzZnFSZHpD?=
 =?utf-8?B?cHlCWjQwYVVJVkFBekM1cVlpT2JLM3ovUVpUZGxTdWVjdnpzZmpjUWI3dlVW?=
 =?utf-8?B?ODRaTU1pcEZzdzlPbG1SY2M4MzQrWkRvTU9HVnp1RG1sOTR1a2Q4MG1FNE1o?=
 =?utf-8?B?OGtuaGFjdnJDbHBDb09rbkFOOFB4NTNtRDRXZ2NmNjV3RWlxQlc3NWh2SGlQ?=
 =?utf-8?B?YzYwY1dtdTlOdVJoWWVmYm1zc0pUZlFRbldTaFVqb3YvOEhJV1B0VDcyUm5Y?=
 =?utf-8?B?bEc4dW5JczhOeEVrWG1LZEp1bXJtN2RFTFQveUZLLzZNclQ1YUh4aDdzeExY?=
 =?utf-8?B?WE9YMUtPaXVWcnl6YmJlSmx1Y0cwR09XYnFlbklXWVBkT1VWd0VWVCt0cEVo?=
 =?utf-8?B?azNaUS9NdFlIZy90b29UN1NFNEpBODdLZTd0Vmd3ZzdOUCtsUnJIMFlHa1FN?=
 =?utf-8?Q?DWGNfa7yguEqV90v70gFyQFpM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a226556-d506-4e5d-23ff-08dc4efd3203
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 08:00:55.2466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggJrgsEubxTLzxUcYFJMyPma9alvokr+Poi4wfL21dyFPJsotcpoLhkTDy6ap7Id/VmqGw88mIl4v0pkNaJUqAyhDj7JKupecl900xPsDME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6536
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
Ym91bmNlc0BsaXN0cy5kZW54LmRlPiBPbiBCZWhhbGYgT2YgIk1pY2hhbA0KPiBCYXJuYXMiDQo+
IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjAsIDIwMjQgMjoxOCBBTQ0KPiBUbzogdS1ib290QGxp
c3RzLmRlbnguZGUNCj4gQ2M6ICJNaWNoYcWCIEJhcm5hxZsiIDxiYXJuYXNAZ29vZ2xlLmNvbT47
ICJNYXJjZWwgWmlzd2lsZXIiDQo+IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+OyAiTWFy
dHluIFdlbGNoIg0KPiA8bWFydHluLndlbGNoQGNvbGxhYm9yYS5jb20+OyAiUGF3ZcWCIEFuaWtp
ZWwiIDxwYW5Ac2VtaWhhbGYuY29tPjsNCj4gIlNpbW9uIEdsYXNzIiA8c2pnQGNocm9taXVtLm9y
Zz47ICJTdnlhdG9zbGF2IFJ5aGVsIg0KPiA8Y2xhbW9yOTVAZ21haWwuY29tPjsgIlRvbSBSaW5p
IiA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjMgMi8yXSBjaGFtZWxl
b252Mzogc2V0IGluIGRlZmNvbmZpZyBmb3IgRlBHQSB0bw0KPiByZXByb2dyYW1ldmVyeSByZWJv
b3QNCj4gDQo+IFNldCBDT05GSUdfVEFSR0VUX1NPQ0ZQR0FfQVJSSUExMF9BTFdBWVNfUkVQUk9H
UkFNIGFzDQo+IGVuYWJsZWQgaW4gY2hhbWVsZW9uIHYzIGJvYXJkJ3MgZGVmY29uZmlnLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWljaGHFgiBCYXJuYcWbIDxiYXJuYXNAZ29vZ2xlLmNvbT4NCj4g
LS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIFVwZGF0ZSBkZWZjb25maWcgdG8gdXNlIHJl
bmFtZWQgS2NvbmZpZw0KPiANCj4gIGNvbmZpZ3Mvc29jZnBnYV9jaGFtZWxlb252M19kZWZjb25m
aWcgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2NvbmZpZ3Mvc29jZnBnYV9jaGFtZWxlb252M19kZWZjb25maWcNCj4gYi9jb25maWdz
L3NvY2ZwZ2FfY2hhbWVsZW9udjNfZGVmY29uZmlnDQo+IGluZGV4IDZlYTYxY2E2ZWEuLjc1MDZh
YThkMzIgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3Mvc29jZnBnYV9jaGFtZWxlb252M19kZWZjb25m
aWcNCj4gKysrIGIvY29uZmlncy9zb2NmcGdhX2NoYW1lbGVvbnYzX2RlZmNvbmZpZw0KPiBAQCAt
Nyw2ICs3LDcgQEANCj4gQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9InNvY2ZwZ2FfYXJyaWEx
MF9jaGFtZWxlb252M180ODBfMiINCj4gIENPTkZJR19TUExfVEVYVF9CQVNFPTB4RkZFMDAwMDAN
Cj4gIENPTkZJR19TUExfRFJJVkVSU19NSVNDPXkNCj4gIENPTkZJR19UQVJHRVRfU09DRlBHQV9D
SEFNRUxFT05WMz15DQo+ICtDT05GSUdfU09DRlBHQV9BUlJJQTEwX0FMV0FZU19SRVBST0dSQU09
eQ0KPiAgQ09ORklHX1NQTF9GU19GQVQ9eQ0KPiAgQ09ORklHX0ZJVD15DQo+ICBDT05GSUdfU1BM
X0ZJVD15DQoNClJldmlld2VkLWJ5OiBUaWVuIEZvbmcgQ2hlZSA8dGllbi5mb25nLmNoZWVAaW50
ZWwuY29tPg0KDQpSZWdhcmRzDQpUaWVuIEZvbmcNCg==
