Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D12EEF3718
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 17:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB7183F2A;
	Mon,  9 Mar 2026 18:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="fdHWUi8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE42783F53; Mon,  9 Mar 2026 18:29:23 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F79A83F20
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 18:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPC35eMbBSBPQYO9iIGLqrbIOrZTezTM30CNUnvA34I8JzdC9RM9Cbe7yXrUmaxtmwd/nTIY0zyJobay4j/rkTc7XwbMpIs+8tJDqnQmSEUiwP9rJq/W7HvR0pgHNn5GxqF9a929ihFP9ECB4E0EW/fhsPIeYAXVXjrm0/t7zxj7nDVcfs/6LMw6ydio/jtdo3wBUs7D9Tkhtc8G0aQYq9zVuVEReRKA8qDQr+BfIbHW6Q5LZQRk5O42ufOuhvpfns+UQ2FcOu+vcnI6tNATLnoC+mJXg8hTANpE8haOHq6KdNt7Sb1ZcE266WzY46SWksTWgH3Y944S6QA4iNlKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji8BK/3fiHp0fhWp0cyWjrHAAw4P5uVkzMSDSs7/IFY=;
 b=PyQAg8fgBRffFrRJvl5BjdpIeMqGYt228kiqlP4RPt+HnFakkfzUhieUlaKcTXvFuPGoufRKm6pz6IqPinybnHYS7GNGnMP1Xi2cpVZKey4SKKm4a13HVCt2eograZiq35BKnjct9REpiinKP6w8Y1DumP4E578WfZHpqib+m+hiyVEwmerARPJzM/5SoU+z1vhrKYYYLRYCCh7uh0xfS0uW27y+Ghw9bZ6rgUjR7T1wpsTy8OzKAyBovuq6JFENvJcppOpk3nxFkBghuc4CNc9fDkUOPcbUarY+mtHN+9+BaxmN1CYD7fTFYhyDZy8EzUVByu6IJUv8uT2yNiD4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji8BK/3fiHp0fhWp0cyWjrHAAw4P5uVkzMSDSs7/IFY=;
 b=fdHWUi8ZNVocEv68AVEfM1scpkFR0z7M/NSLohp4tJNkVqiBv8qIqlThY9Hb+fnEwpDcyHgOkAeR6de2sGQiDXx9q4C1FF4rg+Jl48oxUQ75XFKxde9TkgDPpB52MqR5cSn4l5sXDcRBX/b4uvvtXxPHXJ6IS/xvWe8/t0Tu9lPK1M/Su4/+AlsMKSxjgNyPdf/eJI+lZZMvVkWaE5Z5TVLX8DCfN7pig5SRQ7IYXqC8UxPf2f2WXTSZXy98jnj09S2kI68gh6mclapKV0My2eIpfk/rh9bD5++l+NiR/yzsiGgB5t6TnoqeT9Y6uzCqn7o6EjppXIUE6+aQrw62Jg==
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by PAWPR10MB8066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:384::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 17:29:18 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 17:29:18 +0000
From: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "daniel@makrotopia.org" <daniel@makrotopia.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>,
 "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
 "simon.glass@canonical.com" <simon.glass@canonical.com>,
 "eballetbo@kernel.org" <eballetbo@kernel.org>
Subject: Re: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
Thread-Topic: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
Thread-Index: AQHcrQf4iKfyPquL1k6tmhf5MF7Y3LWmenOA
Date: Mon, 9 Mar 2026 17:29:17 +0000
Message-ID: <34161583f77cb999a04789bf6798d6fbd2c4e234.camel@siemens.com>
References: <20260306012019.800588-1-sjg@chromium.org>
In-Reply-To: <20260306012019.800588-1-sjg@chromium.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5019:EE_|PAWPR10MB8066:EE_
x-ms-office365-filtering-correlation-id: f45ac560-3dae-450d-b2a3-08de7e016488
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|6049299003|1800799024|7142099003|38070700021|4053099003;
x-microsoft-antispam-message-info: Mzu0yBYunV4MIquzKQzmqBWhht/CR4Jre+jrRkxdYIonN/E8x7IOh3OrG1Pgu/zEn2kCKPvA5S3G7yRGTk4EZb1ngCmhQn8CMFhg+bMx+NkTUoSh1+5cuElNG161CrVobC/sLt//yGzQsKb25EpwqvokYvnPVXp9XRMUnJDu7tC25CLnuiXhUKU70lGxICC9IU7e81ZzEQklIbnQJ0p5WOoxIhsyP7Uzbrv9FsbQ37QJNNx8x1jgrh30s+6u2yD5TRWzx6Sl/61X0gnjkdjZJUEY0msUTY5vxvggM69p8WQkA6MRg2NWiIXd/DFoXE7i0nclnlmg+rQexotY5vKG+mQVk7nXTpI5vHhSBIjKv+0idkdlbfP75k/SfVyVi2i4NEFtsWr4hjhhxQ43ImknlFMzc8oPqT00eO0NK44jfnMsG2Mh0wdHY2q8S7CLtpwajt69RePLhKZP63dFxMxAGJKpVcEOqpFxaWyD0j8vKSvlHQCXkYoAfkgbjcF05CqU1S3XgwQENbTjgmQIn5unzxGI71XO32W+W4QLyxGzb1sVdvTXGZpB346Fyv6CpROviO8qtucX13Qprz17+Gt8vvxtW8P1zHFjLgC9pTO5si82QAd9XF3jJpAnYA+N72zsquKf/T2tl44WlNEMLj3d4eP3Kuh14SBtKBMtJh5LoQGCCjzS1Q77xnTpn1b/Z5Ra+8mOTYXULsMt28Ue5bDC4VO5q9Dd0iy2ofm0PNGhhdh9s3vr9wNz1ph107bqwaWQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(6049299003)(1800799024)(7142099003)(38070700021)(4053099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0FTVm5wSVNNdHFMU1g0cjBHcmM2aTRiREVsRUVyS0lUb3JsR0Z0WDdYWk5E?=
 =?utf-8?B?UnZWQWV4YStWUERCekpVN3pLVjU4UmR0dWhBQ2RXQUcvb0cvT2xQN05CWml2?=
 =?utf-8?B?RlRPTnRmaFhPTUlWNWtIY01rZDlQT3RzSW5QVFpGeTZxaU91dVg1NXVrV1R5?=
 =?utf-8?B?cWYvOW1UbDErWHBqYUhWV1JEUGFidGFDQ1VQVHF0YjJDaldyL0VDYnduL2lJ?=
 =?utf-8?B?ajhoczVUelQyZEFMWGlYMUV3UGh5V1BqQ3FURTFyTnlsT2RkV0YzVytXZnB6?=
 =?utf-8?B?anpmdm9yRDdIUTJpY3pDaDRlelVWYlVudjhPS3VqWnVtU3RFSkhTamZNTGIv?=
 =?utf-8?B?c3o2UEZXQyt0WTNHT1lDKy9OUlpxTk44T1JOTmlTWmVESHB5U0lJZ25OdmRI?=
 =?utf-8?B?dUhSRHZ4b3hUSWs1TkdHZmZhK3hWM1d1cWJxcWllTzZobmJ1OGNPUi9xb21o?=
 =?utf-8?B?Z0F2SzY1M3dPQm9lb3JIbENoblZnazR1QWk3dWFoMG1CWnBTNmp2VHdBcjFT?=
 =?utf-8?B?RkFSaS9zMGkvSWtCY1BvOFVseTVUdytzL2RWeDZIWWYwM3YwV2tDd0NjMkZa?=
 =?utf-8?B?dDdWNmZDcW9aNzA5K1gwNEthUkkzckNLWWt2ZnRybjVkWTU3a3VLMUlhdTNm?=
 =?utf-8?B?SVZzMlIrWGwvVmNRbkpFOWZZbElhRnpsS3dQb1dpeTN4N2FXd1VVT2NhRU8v?=
 =?utf-8?B?ZHdGUnM2RHJReWhmUC9SVVN3TGtXWkFjL1FoQVJ3VnVIZGJjcFFQbVI2QWFq?=
 =?utf-8?B?SUZXRU9RREY4VzlyWE85Q2o4cmQ4Yng1NWg5bU1sMlhQM3JTRnVTU1V2YkJ0?=
 =?utf-8?B?TEVNa09OSGwzNVVmNnM1VE5zZ21iWTZQSU1KeXZZb0FEb0VFUGRRSWRkUkxn?=
 =?utf-8?B?NkpaQzRjdXNUTHVmVFd1NUlyMFhjYVlNVlZiZjdXK242WHNJQklSZy9sYkd6?=
 =?utf-8?B?dGxuM2wzNUNSVnNjNzdpeFlIZHdJZzd1NmNvZVVvYm9QWkpZZXd6ZjBZSVJw?=
 =?utf-8?B?eVYrZzZ1cjI2ZTRzYkY0NTNGZklIWE9wQ1hOa01aYXB0WTdaUUhFZ3QvWFhv?=
 =?utf-8?B?eVFxdHcxaDNqUDBSQjJNNHd3dGZsNElXT0YvYW1oMHZjZnJjRTN1S25mNk84?=
 =?utf-8?B?NmFaTU5ma0VZTE9IU01yUCtwUHEwR2Z2U3ZyNEdmWk5qWVNIeU9mYktXSVZI?=
 =?utf-8?B?K1dkZ2FadjlDOFgvcEdzNHIzUU10SENObGVQeTkwenlFWlc5VWs5czBUYUhs?=
 =?utf-8?B?YVQrVlFEd01XZFZQekhxcjBTWGJKV0Y1dllsaSsxeGQ2STdLdHV5ekpJL0hR?=
 =?utf-8?B?bFdaYzJjcUhSWERFb0huWnE1RUlUQ1Y0aWJISUZ2QjhocTYyVWtSOUFxUzVq?=
 =?utf-8?B?THpWaXZlYTJlcUE2STZhRlJabzI3aER4aGladlZudUlPbGd2VHoyQ2lHQ2I0?=
 =?utf-8?B?dDloeC9aQk9WL1FwYWdabTdCSDdrWXVkMWdUMkdiYWFYRmF4bzJ2MzVLV3hM?=
 =?utf-8?B?MDFkZDdkSktEckp2YURmYzIwV1BGVktGWm1qTjRkSXBXTDFXck1iZXVya2Yv?=
 =?utf-8?B?VWFTOHpPZ1NqRDJLZ2Q2NC9EeW9vS29kQUQzR0trU2s1VWRMT29oVVd5TDB0?=
 =?utf-8?B?TU5iS1pvUTE1UGVza3ZRbWdncU9RZGsyTys2N0NqdjhmdGlwRXVKUzkybjdk?=
 =?utf-8?B?dXkxemlqSUxzYjZNbTBmbzE4czRPVzh2REZHK1V3bmYxWlVrMUxJZzBQTWkv?=
 =?utf-8?B?aEh1bjRLd05MSGcyY2g3YkpUdnlCTnhEazJmeGI0ajVBUk1QcGQvRTk4aE41?=
 =?utf-8?B?S1d3Y0tEUVRrakZ4VStDdmRWbnNrbFF2SjNhVVlqYnJSdDNhUnBLMW9zSEY4?=
 =?utf-8?B?aFROYWV6RGdGZHZtUGEyeFkxK0tmUVk3S3R2MXZTQythRGdVYytNTkh0RGZ0?=
 =?utf-8?B?eUM2YW9xNW9zcURBSTBJZExWaHNFQSszL2l5NTlDRWU2SlZEMmFaTmZwblNz?=
 =?utf-8?B?cmlmc0VmN1JuVDkwa1NWNU53MTF0YU5FVGwyL05xUGFSbzRHVG9VdDUwK1kx?=
 =?utf-8?B?T01ZbmlPNmk0L0FOSE90MWZXaG9MMy9zNzZYOUpXek9SS1ljV3hSbGRtVDZM?=
 =?utf-8?B?cFBzdFFmY3dmT2J4cUlQTy9hcDZLT0FWUWE5c1BXNE9YaTlYcWVzSlBFUFND?=
 =?utf-8?B?d1BtK1ZVZVlid3NoNVdJVEw5bjFtc3l2UFFCcFFHMXU5VkFnbkJ4OGVzcm8w?=
 =?utf-8?B?aVVUZ3VkTmQ2dk82L0I0OUlTQ1gwWGRGbFZuclVzSVppYm55UmtlcndMalY5?=
 =?utf-8?B?OHFiYldaR3lBc2E4M3dzdThGT2UrTnRkK1ZoL2N5WHdTWEhFQ0cxWWhRTnJD?=
 =?utf-8?Q?dthYJcOaqzLWZi2U=3D?=
Content-Type: multipart/mixed;
 boundary="_002_34161583f77cb999a04789bf6798d6fbd2c4e234camelsiemenscom_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f45ac560-3dae-450d-b2a3-08de7e016488
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 17:29:17.9304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qufcAaIUng9c5dl68WMV9KlzuyIdQGJerRg9qOkhr3uyAyWPulMGXdC9fSWmHQLVJxnei42FDuFcgRj/bNXa23Td7MI0uH+NcA+tYcjGCGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8066
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

--_002_34161583f77cb999a04789bf6798d6fbd2c4e234camelsiemenscom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <F96A5D665EB14242840F25711C90F144@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI2LTAzLTA1IGF0IDE4OjIwIC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
RnJvbTogU2ltb24gR2xhc3MgPHNpbW9uLmdsYXNzQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBUaGUg
aGFzaGVkLW5vZGVzIHByb3BlcnR5IGluIGEgRklUIHNpZ25hdHVyZSBub2RlIGxpc3RzIHdoaWNo
IEZEVCBwYXRocw0KPiBhcmUgaW5jbHVkZWQgaW4gdGhlIHNpZ25hdHVyZSBoYXNoLiBJdCBpcyBp
bnRlbmRlZCBhcyBhIGhpbnQgc28gc2hvdWxkDQo+IG5vdCBiZSB1c2VkIGZvciB2ZXJpZmljYXRp
b24uDQo+IA0KPiBBZGQgYSBmdW5jdGlvbiB0byBidWlsZCB0aGUgbm9kZSBsaXN0IGZyb20gc2Ny
YXRjaCBieSBpdGVyYXRpbmcgdGhlDQo+IGNvbmZpZ3VyYXRpb24ncyBpbWFnZSByZWZlcmVuY2Vz
LiBTa2lwIHByb3BlcnRpZXMga25vd24gbm90IHRvIGJlIGltYWdlDQo+IHJlZmVyZW5jZXMuIEZv
ciBlYWNoIGltYWdlLCBjb2xsZWN0IHRoZSBwYXRoIHBsdXMgYWxsIGhhc2ggYW5kIGNpcGhlcg0K
PiBzdWJub2Rlcy4NCj4gDQo+IFVzZSB0aGUgbmV3IGZ1bmN0aW9uIGluIGZpdF9jb25maWdfY2hl
Y2tfc2lnKCkgaW5zdGVhZCBvZiByZWFkaW5nDQo+ICdoYXNoZWQtbm9kZXMnLg0KDQpXaGlsZSBn
cm93aW5nIG1vcmUgZ3JleSBoYWlyIHRyeWluZyB0byB3cmFwIG15IGhlYWQgYXJvdW5kIHRoaXMg
SSBmb3VuZA0KYSBtZWFuIHRyYXAuIG1raW1hZ2UgcmVhZHMgYSAnc2lnbi1pbWFnZXMnIHByb3Bl
cnR5IHRvIGRldGVybWluZSB3aGljaA0KaW1hZ2VzIHRvIGluY2x1ZGUgaW4gdGhlIGhhc2ggcmVn
aW9ucy4gV2l0aG91dCB0aGF0IHByb3BlcnR5IG9ubHkNCmtlcm5lbCwgZmR0IGFuZCBzY3JpcHQg
cHJvcGVydGllcyBhcmUgaW5jbHVkZWQgYXQgaW1hZ2UgZ2VuZXJhdGlvbiB0aW1lDQooc2VlIGZp
dF9jb25maWdfZ2V0X2ltYWdlX2xpc3QoKSkuDQoNClRoZSBuZXcgdmVyaWZpY2F0aW9uIGNvZGUg
d29ya3Mgd2l0aG91dCBzdWNoIGEgd2VpcmQgaGFyZGNvZGVkIGxpc3QuIFNvDQphcyBzb29uIGFz
IGEgRklUIGltYWdlIGhhcyBlLmcuIGEgcmFtZGlzayBhbmQgaXQncyBub3QgbGlzdGVkIGluICdz
aWduLQ0KaW1hZ2VzJyB0aGUgdmVyaWZpY2F0aW9uIGZhaWxzLg0KDQo+ICtzdGF0aWMgaW50IGZp
dF9jb25maWdfYWRkX2hhc2goY29uc3Qgdm9pZCAqZml0LCBpbnQgaW1hZ2Vfbm9mZnNldCwNCj4g
KwkJCSAgICAgICBjaGFyICoqbm9kZV9pbmMsIGludCAqY291bnQsIGludCBtYXhfbm9kZXMsDQo+
ICsJCQkgICAgICAgY2hhciAqYnVmLCBpbnQgKmJ1Zl91c2VkLCBpbnQgYnVmX2xlbikNCg0KVG9v
ayBtZSBhIHdoaWxlIHRvIGZpZ3VyZSBvdXQgdGhhdCBhIGZ1bmN0aW9uIHdpdGggdGhlIHNhbWUg
bmFtZSBpcw0KYWxzbyBpbiB0b29scy9pbWFnZS1ob3N0LmMuIE1pZ2h0IG1ha2Ugc2Vuc2UgdG8g
cGljayBhIGRpZmZlcmVudCBvbmUgOi0NCikNCg0KDQpjdQ0KTHVkd2lnDQoNCi0tIA0KTHVkd2ln
IE51c3NlbA0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

--_002_34161583f77cb999a04789bf6798d6fbd2c4e234camelsiemenscom_
Content-Type: text/x-patch; name="0001-machbunt.patch"
Content-Description: colorized hexdump showing regions for hash.patch
Content-Disposition: attachment; filename="0001-machbunt.patch"; size=2141;
	creation-date="Mon, 09 Mar 2026 17:29:17 GMT";
	modification-date="Mon, 09 Mar 2026 17:29:17 GMT"
Content-ID: <BCB2213249BADC4DB512CE39C52430C2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

RnJvbSAwMDAwY2I4NjQwYzQ2Y2ZkZGJlNDM5MzA1MzYwOTUxMGIyNWJhODJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWR3aWcgTnVzc2VsIDxsdWR3aWcubnVzc2VsQHNpZW1lbnMu
Y29tPgpEYXRlOiBNb24sIDkgTWFyIDIwMjYgMTg6MTM6NDcgKzAxMDAKU3ViamVjdDogW1BBVENI
XSBtYWNoYnVudApUbzogdS1ib290QGxpc3RzLmRlbnguZGUKClNpZ25lZC1vZmYtYnk6IEx1ZHdp
ZyBOdXNzZWwgPGx1ZHdpZy5udXNzZWxAc2llbWVucy5jb20+Ci0tLQogYm9vdC9pbWFnZS1maXQt
c2lnLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ib290L2ltYWdlLWZpdC1z
aWcuYyBiL2Jvb3QvaW1hZ2UtZml0LXNpZy5jCmluZGV4IGY0MjZlYWQxM2MwLi4zMzBjMTVmNGIz
YSAxMDA2NDQKLS0tIGEvYm9vdC9pbWFnZS1maXQtc2lnLmMKKysrIGIvYm9vdC9pbWFnZS1maXQt
c2lnLmMKQEAgLTIsMTAgKzIsMTIgQEAKIC8qCiAgKiBDb3B5cmlnaHQgKGMpIDIwMTMsIEdvb2ds
ZSBJbmMuCiAgKi8KKyNkZWZpbmUgTE9HX0RFQlVHCiAKICNpZmRlZiBVU0VfSE9TVENDCiAjaW5j
bHVkZSAibWtpbWFnZS5oIgogI2luY2x1ZGUgPHRpbWUuaD4KKyNpbmNsdWRlIDxjdHlwZS5oPgog
I2Vsc2UKICNpbmNsdWRlIDxsb2cuaD4KICNpbmNsdWRlIDxtYWxsb2MuaD4KQEAgLTU0LDEyICs1
Niw0NyBAQCBzdHJ1Y3QgaW1hZ2VfcmVnaW9uICpmaXRfcmVnaW9uX21ha2VfbGlzdChjb25zdCB2
b2lkICpmaXQsCiAJaWYgKCFyZWdpb24pCiAJCXJldHVybiBOVUxMOwogCWZvciAoaSA9IDA7IGkg
PCBjb3VudDsgaSsrKSB7CisJCWRlYnVnKCJcZVswNCVkbSIsIGklNSsxKTsKIAkJZGVidWcoIiUx
MHggJTEweFxuIiwgZmR0X3JlZ2lvbnNbaV0ub2Zmc2V0LAogCQkgICAgICBmZHRfcmVnaW9uc1tp
XS5zaXplKTsKKwkJZGVidWcoIlxlW20iKTsKIAkJcmVnaW9uW2ldLmRhdGEgPSBmaXQgKyBmZHRf
cmVnaW9uc1tpXS5vZmZzZXQ7CiAJCXJlZ2lvbltpXS5zaXplID0gZmR0X3JlZ2lvbnNbaV0uc2l6
ZTsKIAl9CiAKKyNpZmRlZiBVU0VfSE9TVENDCisJaSA9IDA7CisJdW5zaWduZWQgbyA9IDA7CisJ
d2hpbGUgKG8gPCBmZHRfdG90YWxzaXplKGZpdCkpIHsKKwkJaWYgKG8lMTYgPT0gMCkgcHJpbnRm
KCIlMDh4OiIsIG8pOworCQlpZiAobyUyID09IDApIHByaW50ZigiICIpOworCQlwcmludGYoIiUw
MmhoeCIsICgoY29uc3QgY2hhciopZml0KVtvXSk7CisJCSsrbzsKKwkJaWYgKG8gJiYgbyUxNiA9
PSAwKSB7CisJCQlwcmludGYoIiAiKTsKKwkJCWludCBvbiA9IDA7CisJCQlmb3IgKGNvbnN0IGNo
YXIqIGggPSBmaXQrby0xNjsgKHZvaWQqKWggPCBmaXQrbzsgKytoKSB7CisJCQkJaWYgKGkgPCBj
b3VudCAmJiAodm9pZCopaCA9PSByZWdpb25baV0uZGF0YSArIHJlZ2lvbltpXS5zaXplICkgewor
CQkJCQlwcmludGYoIlxlW20iKTsKKwkJCQkJb24gPSAwOworCQkJCQkrK2k7CisJCQkJfQorCQkJ
CWlmIChpIDwgY291bnQgJiYgKHZvaWQqKWggPj0gcmVnaW9uW2ldLmRhdGEpIHsKKwkJCQkJaWYg
KCFvbikgeworCQkJCQkJcHJpbnRmKCJcZVswNCVkbSIsIGklNSsxKTsKKwkJCQkJCW9uID0gMTsK
KwkJCQkJfQorCQkJCX0KKwkJCQlpZiAoaXNwcmludCgqaCkpIHByaW50ZigiJWMiLCAqaCk7CisJ
CQkJZWxzZSBwcmludGYoIi4iKTsKKwkJCX0KKwkJCWlmIChvbikgcHJpbnRmKCJcZVttIik7CisJ
CQlwcmludGYoIlxuIik7CisJCX0KKwl9CisJcHJpbnRmKCJcbiIpOworI2VuZGlmCisKIAlyZXR1
cm4gcmVnaW9uOwogfQogCkBAIC0zODUsNiArNDIyLDcgQEAgc3RhdGljIGludCBmaXRfY29uZmln
X2dldF9oYXNoX2xpc3QoY29uc3Qgdm9pZCAqZml0LCBpbnQgY29uZl9ub2Zmc2V0LAogCQkJaWYg
KG5vZmZzZXQgPCAwKQogCQkJCWNvbnRpbnVlOwogCisJCQlwcmludGYoImFkZGluZyBoYXNoIGZv
ciAlc1xuIiwgcHJvcF9uYW1lKTsKIAkJCXJldCA9IGZpdF9jb25maWdfYWRkX2hhc2goZml0LCBu
b2Zmc2V0LCBub2RlX2luYywKIAkJCQkJCSAgJmNvdW50LCBtYXhfbm9kZXMsIGJ1ZiwgJnVzZWQs
CiAJCQkJCQkgIGJ1Zl9sZW4pOwotLSAKMi40My4wCgo=

--_002_34161583f77cb999a04789bf6798d6fbd2c4e234camelsiemenscom_--
