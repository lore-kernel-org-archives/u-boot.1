Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E273DC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED2583323;
	Tue,  8 Jul 2025 15:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nEu+Opyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B6683323; Tue,  8 Jul 2025 15:09:50 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D0983123
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekHTJ43p2TLBV32baMEJwiLXnA55JBTgQ/mu1ATN3En31OBI6J1T9QJKGK6t3hRjYdKC5WviV3hrDXRPkmd1wFXPnoQIwcO+8BEUra6KRayVcljR54ccdNrkEKicmSJ5lT3TW3DIp66v2LQYU8cAvNFga1SypgDisFyET7fVW7C73/L2YK0/0xqKjgUlk5xE5A9Tr5WuLXzYhmUOjrOh6BqsOCcfqDR0XL8N9CXn1EC+i9sGPAvkDlbMlX96lKU8vOfoWq9d6r+0hVtFkVLGZzYQ2m3GeLzXj95e1x6YNd906JRXgfaaw+RQwetk61mp+HKtigd7KOzDHHDLHTHu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RHNsm7D4tJyvTs2Q7BRtAxcTsWndHtsKzGEYbdyPsw=;
 b=o2KQUaBDXbV85H/m3gN4ZmACyae9UiRUZc+Bk3ZBnXHfVuSjM52sgJNZ7lOxGs1A64IfZ26D/9h7m6JV8fwrcpFRhoRPCNpxCPWArInEhqwN/nFULSzQyrMv9P/YTgykvKeWGnoxiZrPR/a0kt8qFmmT+L7xGAdAYSpzVmFy+gSKmIl58WfgkwjOKyKam8T3C7psW1Ua9iiK1XVekGo48uPcXx53c8o/qtkYMZDN0vYZ7Uiq2eGqt1e+gVvtkZ2C1p7r6jO3hPFKYWZMQAvztFexUrDwRmXPowc3OgMX5KRWFx0Rd/c7fj+68CKxoctjpS1/bsrt8s2Jl0ffNwkz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RHNsm7D4tJyvTs2Q7BRtAxcTsWndHtsKzGEYbdyPsw=;
 b=nEu+Opyvpl72EoBh2VIof3vhbkxD6XTqSu58nmeLhyqTgYQjQBEQRxc3pqEa7gYNHgMjGoHNTnWGlbYQXSMiv4n2s2UKYboPg8h+WRwaPX3e7qll8xvgrpc+CXgTVldLu6NHJ062KArcm43NiRvrHgcRlwVMeOk6odH2I0MAWMk=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 13:09:38 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::5f77:799a:c1c8:cd04]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::5f77:799a:c1c8:cd04%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 13:09:37 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v2 1/2] FWU: Add platform hook support for fwu metata
Thread-Topic: [PATCH v2 1/2] FWU: Add platform hook support for fwu metata
Thread-Index: AQHb7yt3ypI1tN5fO0uo0ubHQB/BuLQmi9GAgAGocvA=
Date: Tue, 8 Jul 2025 13:09:37 +0000
Message-ID: <CH0PR12MB5266FA6B091CABB1D95068ABEC4EA@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <20250707103918.4189148-1-padmarao.begari@amd.com>
 <20250707103918.4189148-2-padmarao.begari@amd.com>
 <CADg8p97bXHr984mEpcNdXEk9dDeW8Kn4R8hen-dp49DphC7LTw@mail.gmail.com>
In-Reply-To: <CADg8p97bXHr984mEpcNdXEk9dDeW8Kn4R8hen-dp49DphC7LTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-08T13:07:47.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|MW4PR12MB7285:EE_
x-ms-office365-filtering-correlation-id: c4e8029f-b736-4bfa-22b4-08ddbe20b0ef
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VlRnbXZLcEQ5dklkUkc4Z2xvUlBuQmtqeDJDcVdpNG5GTVRpdC9KcW1FbW8v?=
 =?utf-8?B?MEtpRGVVOFk2V21rblk4VFZsL1J3TWRsbUg2MjdidlM1YmZXQktMa01aSkE2?=
 =?utf-8?B?aUlycnZzQS82eWZRU3Zaa1RQMVoyRGZVT0EwT3JweGN1VzM3RXV4ejFxcHhN?=
 =?utf-8?B?V0liRStkRnhUL1JENTlTZlpnVTBEdGlIUlkyTno3R2E5TDhYZG1IUjJteVR1?=
 =?utf-8?B?dFNyMkZQNklTSnp3S1crNUJPbjFaSE9LUnpVTnYyeEIwbEFCTllWRUFrRzFL?=
 =?utf-8?B?WGxIY3I5NkFZb25hZjZYbGtBZ2ZZcnRtSFR1SWhhNUVLZGF2bzJNbm1nUDNt?=
 =?utf-8?B?bU5hb002LzhtZGVTVVovcTUxcFBvZnVNL3d2bW90TVYrVzVnVHBWVWhDOHRi?=
 =?utf-8?B?Rmc5cThVSUVSN1RwTHkyZ1k2R1o5OGNybjF4SExwQmZoendxcTVSeXMrV2Zy?=
 =?utf-8?B?bUJGWG42cmVTSkpMT3lhaC9mNG0vT3pmZGZuSVJBMk1mcE5yeGl0QlNIaGNu?=
 =?utf-8?B?MzFNV0tVQnRiOVdOdlYwK08vRjc3ZmVsNHE1WEZmclBzZm5QbXZ0UHZmNGxT?=
 =?utf-8?B?WTdFUGJuVnZsbENaTFU5NHFIaG5BVXJRUjZTd1FRUzFVZGRxZzJpQ0J2bmQz?=
 =?utf-8?B?aHhYM0FmVlZpRjk4b2xOZHdMQkl3WTVPVUhVRHlKUms2RmdiSXkxek9MNWc4?=
 =?utf-8?B?Z0w5T2hxa0tNcFFSdE5RWGx0amcwL1ZKZDA5K0VNSEtLeFVNYXRDZHpLbkVV?=
 =?utf-8?B?Nmd4UWh0U3NPSUVsTDlndzg5akxDemNRd1lkOElwS0Z5N3NxNDBUQWxnNysy?=
 =?utf-8?B?TnZjSXRZR01rNGN6Z1N3Y2VkNlF1UHdqUlQ1ejc5YncyQ1R5bzZySFBCYWEz?=
 =?utf-8?B?VVh5NW5rWEJieXFKTUNPTlNBYmJJdXB1b2tXd1Q2dTZrcFpwc3VnNGVFTTRq?=
 =?utf-8?B?WVhNYzh4UUJzZStnczNpTTFnSkdVd2NjM2J3bzNxcmUva3l6djRZYlZwcmdR?=
 =?utf-8?B?TEZHUEF5VjlSR29najZEYm9lK3NXTWR0amVVODk5VHIyT0ZnR1BhYzlqVm9W?=
 =?utf-8?B?dFF2TXIvdTVpbzFBSUVMc1IzYXNlYTVZL29EUWNNNmF1MlVXM2NqQUZYa2xx?=
 =?utf-8?B?cnhTYjk0emo3NXB4citNNlpsb0RkQzZ3MjBGdWxvcGF2NVhYdVh6cFZZN1o5?=
 =?utf-8?B?ODM0VzcyeklRVms1Zk5uRHJxWnlYamJHQnJvRVE5ckpscTc2ZWtjZVlSbTRw?=
 =?utf-8?B?OHV6MEUxY0VibkVlUnBYZmluZ0htSVBmdXBNdXJ5M0wrUktVM2JUT2xyb2d1?=
 =?utf-8?B?T3FJUk1zc3d3YWI4dmZxTmpvazlpeU8zbjAzWTJFNjZ2eHAySEYvNklsa3d4?=
 =?utf-8?B?WWRVcDRLNWJUcVhmS1hpa2pTMzYzaldyczEyWlorbzZtM3JmV3hGR3pQdDdU?=
 =?utf-8?B?VG1uaS9wdXo3TFRQK1NsVzY5Z0Q1VnNGbXRyOFUwWEdQcGErQm5PKzJmSm5r?=
 =?utf-8?B?R3B4UzNUSGNaaTMzeXBneTFFa3JsMDRpdVJVRjRtb2xLT3IrcWprcUpyWFpM?=
 =?utf-8?B?OTlRVUtCQUMyQm81enkvdWlKWUIzc2gzT0VvaXhRRkdQUVhON05pVjdLdXky?=
 =?utf-8?B?eEpKQXZIbGRab28zOEZQN1dHdG1xV2EzYlZ5RHY4MlFmbW4xekdGN2pNVkww?=
 =?utf-8?B?eE1FNWRmMjljRHBmTTU2cXVVMTlqNnJKYm1ERDQ1VkZxL3ZZeVBmVm1oSFNV?=
 =?utf-8?B?UU9SOGd0a3lEODY4aUZBRUt4UEpsenlvY3F3UmpNQTdkS0pNYVJUWFU1RDFF?=
 =?utf-8?B?WEppelZuTTJ1Uy84R0tIOTluQldVOGJlOTlWNkppVllmdnlJbVlYcHdDMFJH?=
 =?utf-8?B?QVdkRlRSMXJvaWxHWUJqMitEUmtVSG9IQmxRc2x2dEQwVUxHbW9TckpxVTlY?=
 =?utf-8?B?NUxxbnlZOXRHcmdkZFJXalRyN1FvOERmYXcxa1FaN3BRYVdNRWJMcCtUcE4v?=
 =?utf-8?B?cUtmMEFuU2RRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTVLODhoMEJCMU41NGxmUjUxMFpTOXVSK1JwdUIvbEJodi83M3F2a3ZpeENU?=
 =?utf-8?B?VWp0bHhnekxNNXd2dUZyQXpHZUh6T2tnMzNnQW0xWnRpZC92ZUdCTXk5N3Br?=
 =?utf-8?B?akhQWUxTOUdtUGg1M0JMcldiNUplYTVRSTkyU3EyUU1qdlhzaFhCcFBpTnAr?=
 =?utf-8?B?cHlFaE1jSElVQmVpcGtzN09VRXEvWmZvSFF2d014Zk5CS3NOaWM5NjFQNkwv?=
 =?utf-8?B?a3lVdlluVUcxM29ucWhsaC9rZGZlcm8yTW1mR0JkcGhVR1RKbzNqODNTc0Yr?=
 =?utf-8?B?NCtGcUZlY3FlQXFreE5pQnpHY1AyVjJHQi8vSVN2eUkvWFU0c0FEU3MvRTdF?=
 =?utf-8?B?QlV5ZXZtNXVxbHRxNzVLRjRXWElWYVJrblRmUVdONG9KWlBwODhHNjlSRTZ0?=
 =?utf-8?B?NDV5VmNHY0kxcWUzamozbGR5SlJTdDNLL2lqb09uUnIxUkNpRXllZUJlN004?=
 =?utf-8?B?L0h4d2crKzlwNHVFZkovN0tZcEMwcDByYXZmckM0Mk1OR09KOUVWRFRIQTlR?=
 =?utf-8?B?bkZZQk51WFFZQkxOS2xMcCtncVY1VGxYL3JwK3RQV21LUC9HSFdyenRVVFVU?=
 =?utf-8?B?YkdKbVhjTndoWE5WZys4ZDBsVUNzUG8zNUJHQU9LLzVQcUd2bkkzSkMzdFNW?=
 =?utf-8?B?RG5Gb2dBWE5sb3pUTjlPaWVCakV6dFFDdmd4Sm1aNXg1UGN3OUdnckl0NWky?=
 =?utf-8?B?dXIzbzVuTlhFcmJoR1RkaWlSRG04T3p1Y0hyN1FLZVdjOVp4NDh5a2hHOWVU?=
 =?utf-8?B?MGdIbG16UGpwNHdEWlBzRjhSVnRsYVoxQm5iZDhHRWpoWXhkYXNMd3RyZC82?=
 =?utf-8?B?SEVFY0xjdEgwYWVMN2o1bmpWa3podkVJQnRhU3E3Y3BXNGpzWGQ5UXRNTUxy?=
 =?utf-8?B?MkZQN1ltdXB3YjJld0tpbUNPdWlaelJBNTlyTkFva2hsQ3YvU212ekhSSStZ?=
 =?utf-8?B?NmUzcFV6VEJYV2kxZVBzUys1Tk5IaUpaS3YwOTd4SmJ2NUVIVkkwWHI1VTJP?=
 =?utf-8?B?YWdVZk9rK0d1aXd5bDhERGFzQjJTM1pWMStzZ2FhSm9UUjdidUxOa2VkTVRN?=
 =?utf-8?B?Qkhmd0NBK2VEbGxHTlRBSlM3UnpjS3d0K2k2NGV1MmUxQjE1L0tWY0IrMFpa?=
 =?utf-8?B?ZThzRVdWQVdldE9GMUhlV0QwakM2RjFNb3M5eFlmcHJIRnBxeE9uaytmU3ZZ?=
 =?utf-8?B?MEtBdlV1OWRFblpqb0dwUE5iMThpRkgvcGxqV2grOEpjaHhRVTlET0xlVzIv?=
 =?utf-8?B?UU50Sm5QQ1BRUnhwb3I1eHliYmF0ZDkvaEt5NE9OWHBTSTcyblBtcDBINWJI?=
 =?utf-8?B?b3FzVXhXKzdTd08yQ2NGdlVqbFhOYktNdllobTh0S2RkbGxUTFAwTzVDdkk3?=
 =?utf-8?B?SmxXamhIclFJMTdIUnJFcUdZb0NXN0VwZEdKMGFDU0lxeldhbE9WbnFGYXVQ?=
 =?utf-8?B?dWk4dUh3M2NtWmd0TXh2Z3R6YlVtSUIvSllucWx4dkVkOEQ0ZVZuYVdISTdN?=
 =?utf-8?B?SzdKNi8yb21jTmwxelNuOXhRM2VZS3RNVUFFd2EwdHJkSTFsTmxxMFB1RHIz?=
 =?utf-8?B?WVdYTFMvUW1wQ25lUzRqKzAyUVlkaXUrOHlhS3JRWUI4eG1oWnJWZjF1Snh5?=
 =?utf-8?B?b3FNeVRDajdUV1F2TkdWUUxETytrRjZ3dTN3NXVCUmNCNkhSTk9sVXZhRnA5?=
 =?utf-8?B?OEVnU096SFhXa3BydTk1VjZQMUt1Ky9EUzFSUkQrTDlqU3lkZks1blN4eW1y?=
 =?utf-8?B?MTUzUTd5OGIrdkJkOHhJVzJiZ25UOHkxVlBBVUhwTzBQcGFza1J2Z0VJQm53?=
 =?utf-8?B?UTYzWnBwZit2UWQxd3lrZTZuMHpMbWd4Y1Nya0VSNUhBL21lOHhJSjBlcGpN?=
 =?utf-8?B?VGJoRFBwQ1hZVmtTZVpHWE1XL0IxdVdDV0lkQzVqbTJ6MUN2VC9yd285cEhF?=
 =?utf-8?B?OFpxb2tUbU9jc0VNaEFhUE9kcmh5ZWRqUHFCNmROck4zVzZCYTdQakpUQXBP?=
 =?utf-8?B?MWJUdXo4UHpES1p3dEFkZWkvZFRJTy9rSTRkeWM5ZG5jalVTRStvYVRadmdO?=
 =?utf-8?B?NlpSeTBWdkJKUXZvdDJZcS9Ka2k0MndOREIxNHRpeis1ZkdVeE8yb25aSTgw?=
 =?utf-8?Q?16h8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e8029f-b736-4bfa-22b4-08ddbe20b0ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 13:09:37.2961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2hHBRC/nmfJD0ESldIO1n7sCifkQ5ikxJH5aoOVLT49XTB0Kt4tgDdXfxkMcg/zZaDMQDNgSbkZPs4hYQZDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgU3VnaG9zaCwNCg0KPiBGcm9tOiBTdWdob3NoIEdhbnUgPHN1Z2hvc2guZ2FudUBsaW5h
cm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgNywgMjAyNSA1OjE5IFBNDQo+IFRvOiBCZWdh
cmksIFBhZG1hcmFvIDxQYWRtYXJhby5CZWdhcmlAYW1kLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0
cy5kZW54LmRlOyBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IFNpbWVrLCBNaWNoYWwN
Cj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0g
RldVOiBBZGQgcGxhdGZvcm0gaG9vayBzdXBwb3J0IGZvciBmd3UgbWV0YXRhDQo+DQo+IENhdXRp
b246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2Ug
cHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5r
cywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gTW9uLCA3IEp1bCAyMDI1IGF0IDE2OjA5LCBQ
YWRtYXJhbyBCZWdhcmkgPHBhZG1hcmFvLmJlZ2FyaUBhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IEZXVSBtZXRhZGF0YSBpbmZvcm1hdGlvbiBpcyB1bmF2YWlsYWJsZSBmb3IgcGxhdGZvcm0t
c3BlY2lmaWMNCj4gPiBvcGVyYXRpb25zIHNpbmNlIEZXVSBpbml0aWFsaXphdGlvbiBoYXMgbm90
IHlldCBvY2N1cnJlZC4NCj4gPiBUaGUgaW5pdGlhbGl6YXRpb24gZnVuY3Rpb24gaXMgaW52b2tl
ZCBhcyBwYXJ0IG9mIHRoZSBtYWluIGxvb3AgZXZlbnQuDQo+ID4gVG8gYWRkcmVzcyB0aGlzLCB0
aGUgRldVIHBsYXRmb3JtIGhvb2sgZnVuY3Rpb24gaXMgaW50cm9kdWNlZCBkdXJpbmcNCj4gPiBG
V1UgaW5pdGlhbGl6YXRpb24sIGFsbG93aW5nIG1ldGFkYXRhIHByb2Nlc3Npbmcgd2l0aA0KPiA+
IHBsYXRmb3JtLXNwZWNpZmljIG9wZXJhdGlvbnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
YWRtYXJhbyBCZWdhcmkgPHBhZG1hcmFvLmJlZ2FyaUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBp
bmNsdWRlL2Z3dS5oICAgICAgICAgfCAxMSArKysrKysrKysrKw0KPiA+ICBsaWIvZnd1X3VwZGF0
ZXMvZnd1LmMgfCAxOCArKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
OSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9md3UuaCBiL2lu
Y2x1ZGUvZnd1LmggaW5kZXgNCj4gPiA2NDQxZGUzNzBjOS4uOGQwYjg1NmNjODEgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9md3UuaA0KPiA+ICsrKyBiL2luY2x1ZGUvZnd1LmgNCj4gPiBAQCAt
MTI5LDYgKzEyOSwxNyBAQCBpbnQgZnd1X3JlYWRfbWRhdGEoc3RydWN0IHVkZXZpY2UgKmRldiwg
c3RydWN0DQo+ID4gZnd1X21kYXRhICptZGF0YSwgIGludCBmd3Vfd3JpdGVfbWRhdGEoc3RydWN0
IHVkZXZpY2UgKmRldiwgc3RydWN0IGZ3dV9tZGF0YQ0KPiAqbWRhdGEsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICBib29sIHByaW1hcnksIHVpbnQzMl90IHNpemUpOw0KPiA+DQo+ID4gKy8qKg0K
PiA+ICsgKiBmd3VfcGxhdGZvcm1faG9vaygpIC0gSG9vayB0aGUgZ2l2ZW4gRldVIGRhdGEgY29w
eQ0KPg0KPiBUaGlzIGNhbiBiZSBwaHJhc2VkIGJldHRlci4gU29tZXRoaW5nIGxpa2UgInBsYXRm
b3JtIHNwZWNpZmljIHByb2Nlc3Npbmcgd2l0aCBGV1UNCj4gbWV0YWRhdGEiLg0KPg0KT0sNCj4g
PiArICogQGRldjogRldVIG1ldGFkYXRhIGRldmljZQ0KPiA+ICsgKiBAZGF0YTogRldVIG1ldGFk
YXRhDQo+ID4gKyAqDQo+ID4gKyAqIEl0IGlzIGEgcGxhdGZvcm0tc3BlY2lmaWMgZnVuY3Rpb24g
dGhhdCBwcm9jZXNzZXMgZnd1IG1ldGFkYXRhLg0KPg0KPiBNb3JlIGRldGFpbHMgcGxlYXNlLiBU
aGlzIGlzIGFuIEFQSS4gU29tZXRoaW5nIGxpa2UsICJQcm92aWRlIGEgcGxhdGZvcm0gc3BlY2lm
aWMNCj4gZnVuY3Rpb24gZm9yIHByb2Nlc3Npbmcgd2l0aCB0aGUgRldVIG1ldGFkYXRhIi4NCk9L
DQoNCj4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIGlmIE9LLCAtdmUgb24gZXJyb3INCj4g
PiArICovDQo+ID4gK2ludCBmd3VfcGxhdGZvcm1faG9vayhzdHJ1Y3QgdWRldmljZSAqZGV2LCBz
dHJ1Y3QgZnd1X2RhdGEgKmRhdGEpOw0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIGZ3dV9nZXRf
bWRhdGEoKSAtIFJlYWQsIHZlcmlmeSBhbmQgcmV0dXJuIHRoZSBGV1UgbWV0YWRhdGENCj4gPiAg
ICoNCj4gPiBkaWZmIC0tZ2l0IGEvbGliL2Z3dV91cGRhdGVzL2Z3dS5jIGIvbGliL2Z3dV91cGRh
dGVzL2Z3dS5jIGluZGV4DQo+ID4gN2YwODVhMDIxMWYuLjllOTEzYTA0ZWQ0IDEwMDY0NA0KPiA+
IC0tLSBhL2xpYi9md3VfdXBkYXRlcy9md3UuYw0KPiA+ICsrKyBiL2xpYi9md3VfdXBkYXRlcy9m
d3UuYw0KPiA+IEBAIC02NTUsNiArNjU1LDE2IEBAIF9fd2VhayB2b2lkIGZ3dV9wbGF0X2dldF9i
b290aWR4KHVpbnQgKmJvb3RfaWR4KQ0KPiA+ICAgICAgICAgICAgICAgICAqYm9vdF9pZHggPSAw
OyAvKiBEdW1teSB2YWx1ZSAqLyAgfQ0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiBmd3VfcGxhdGZv
cm1faG9vaygpIC0gSG9vayB0aGUgZ2l2ZW4gRldVIGRhdGEgY29weQ0KPiA+ICsgKg0KPiA+ICsg
KiBSZXR1cm46IDAgaWYgT0ssIC12ZSBvbiBlcnJvcg0KPiA+ICsgKi8NCj4gPiArX193ZWFrIGlu
dCBmd3VfcGxhdGZvcm1faG9vayhzdHJ1Y3QgdWRldmljZSAqZGV2LCBzdHJ1Y3QgZnd1X2RhdGEN
Cj4gPiArKmRhdGEpIHsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICAvKioNCj4gPiAgICogZnd1X3VwZGF0ZV9jaGVja3NfcGFzcygpIC0gQ2hlY2sgaWYgRldVIHVw
ZGF0ZSBjYW4gYmUgZG9uZQ0KPiA+ICAgKg0KPiA+IEBAIC03MTIsNiArNzIyLDcgQEAgc3RhdGlj
IGludCBmd3VfYm9vdHRpbWVfY2hlY2tzKHZvaWQpICB7DQo+ID4gICAgICAgICBpbnQgcmV0Ow0K
PiA+ICAgICAgICAgdTMyIGJvb3RfaWR4LCBhY3RpdmVfaWR4Ow0KPiA+ICsgICAgICAgc3RydWN0
IGZ3dV9kYXRhICpkYXRhOw0KPiA+DQo+ID4gICAgICAgICByZXQgPSB1Y2xhc3NfZmlyc3RfZGV2
aWNlX2VycihVQ0xBU1NfRldVX01EQVRBLCAmZ19kZXYpOw0KPiA+ICAgICAgICAgaWYgKHJldCkg
ew0KPiA+IEBAIC03NzAsNiArNzgxLDEzIEBAIHN0YXRpYyBpbnQgZnd1X2Jvb3R0aW1lX2NoZWNr
cyh2b2lkKQ0KPiA+ICAgICAgICAgaWYgKCFyZXQpDQo+ID4gICAgICAgICAgICAgICAgIGJvb3R0
aW1lX2NoZWNrID0gMTsNCj4gPg0KPiA+ICsgICAgICAgZGF0YSA9IGZ3dV9nZXRfZGF0YSgpOw0K
PiA+ICsgICAgICAgcmV0ID0gZnd1X3BsYXRmb3JtX2hvb2soZ19kZXYsIGRhdGEpOw0KPiA+ICsg
ICAgICAgaWYgKHJldCAmJiByZXQgIT0gLUVOT1NZUykgew0KPg0KPiBJcyB0aGVyZSBhbnkgc2Nl
bmFyaW8gZm9yIHJldHVybmluZyBFTk9TWVMuIFRoaXMgaXMgbm90IGEgRE0gdWNsYXNzDQo+IGNh
bGwgd2hlcmUgYW4gb3BlcmF0aW9uIG1pZ2h0IG5vdCBiZSBkZWZpbmVkLg0KPg0KTm8sIHdpbGwg
dXBkYXRlIGl0DQoNClJlZ2FyZHMNClBhZG1hcmFvDQoNCj4gLXN1Z2hvc2gNCj4NCj4gPiArICAg
ICAgICAgICAgICAgbG9nX2VycigiZnd1X3BsYXRmb3JtX2hvb2soKSBmYWlsZWRcbiIpOw0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAg
ICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4gIEVWRU5UX1NQWV9TSU1QTEUoRVZUX01BSU5f
TE9PUCwgZnd1X2Jvb3R0aW1lX2NoZWNrcyk7DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
