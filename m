Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965F5C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 09:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D5A081D6A;
	Tue, 29 Jul 2025 11:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lMC5c2Zg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6B682ADA; Tue, 29 Jul 2025 11:15:06 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CAAC80FA1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 11:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge76hy5MeZ1tJYbZC+za9mLv50wIhsvZVSyXEnqlPazDp0jQ1p4CQ34Vbi+uZgiXsRayKXOsBozGTp0MU/7Ojxv0YiW40qpUDKLhOeDoccw5Ajgc+NtjoYoCf0oAwKY49T1wKEhHDCAkWu1HA4zZDVLM/2dR97YJQYK8319aEkArSfKXrFa4zduDfq5NcTOjqkVzL2n1C2vouavHzVfGaUFblt8+IGFrl8/ShVJ/y9auxSgShm6+kMJsIjg5EI1pvXxND29VUgiRHt1S2oyaqSDeLL2aQA+OU9eXNQf1OPPaA8BpbxxBwIMQiwg7Grj5su2l7KmUI7pRSbhgRhPsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y9mFgllgEry4CL/e9JIwIdZnTqhftJs5USDP7ivvjg=;
 b=L87wO/ObS5+ebUyI0xMPEEWoG9MMxiEkWHF5hRVF+zu+44TnCCYupRQHOqZnJYAvzSiQ9EeXnX9krkiHTg/No9PEbPNtyhVp/i9VzBdWKmSNzmkzSY6eNWgfk8oNOPmf658jzKlb74hVuVKM/OaifwfkACW/NYeVRofaeb/Zj/SUULaQmWj0+UWPl4qKxth60TNndpeS0BpqSlFmFf49SQkA9CL49Y90fw1mtqCboKC1zvEllf0AkdB3sPsJ75IIFSp/T4rSOkQ7NWX8j+T6PzQTFJuztc7vJrfQhddJjRZqrCaRtBiUoqQ9WZb5P6V6V/d8Jb9UeU9drVVROgTXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y9mFgllgEry4CL/e9JIwIdZnTqhftJs5USDP7ivvjg=;
 b=lMC5c2Zg5Gmcbq44b74HUGjxvb1ZZRWqBmGdIsKgHmn74zd9Lc8HmdZVmvSTTyE9+7uarkQBfzfHSZ6xdUWrUdFST64lwQ1TOfu583GfrS6IVvtJYfk/808p2qFFzEm4/4r1ianBdtO4mTJ3kix28F/qPm3y2qkKFujzNf8ws6li7tdlLaJucQSOg/3fcNVKNRt/XRnihC0a1JoIC/LAZ8eJEcd9WYh6czDj085W4unJ0lvxMQTnAtJ3h3f4wu4taXN/e4vLzLUWuOU/ITRfdVfHxNPrGRFfk8rY4O0CpvAF0CKDi1epm5ukFno8W3lcuyqULCUb7pppqgqSVpN7LA==
Received: from AS4P195MB2011.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:588::12)
 by DB9P195MB1587.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 09:15:01 +0000
Received: from AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
 ([fe80::e2ee:5897:5a51:d40c]) by AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
 ([fe80::e2ee:5897:5a51:d40c%7]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 09:15:01 +0000
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Tom Rini <trini@konsulko.com>
CC: Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/3] Add imx8mp-libra-fpsc board
Thread-Topic: [PATCH 3/3] Add imx8mp-libra-fpsc board
Thread-Index: AQHb/U/z+tKMCi66eUS9gdWYVFkth7RC3OWAgAX6/wA=
Date: Tue, 29 Jul 2025 09:15:01 +0000
Message-ID: <a2ba593e-5c74-4cab-8075-2279e402e1c3@phytec.de>
References: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
 <20250725-imx8mp-libra-initial-support-v1-3-d9982df21a4b@phytec.de>
 <20250725135521.GB1807455@bill-the-cat>
In-Reply-To: <20250725135521.GB1807455@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB2011:EE_|DB9P195MB1587:EE_
x-ms-office365-filtering-correlation-id: f6d0e20f-5c12-4b12-98b3-08ddce806580
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TnFIQmtTZVgwa2VTaHd2YUg5dGp5YTgwbllDSmZxWTNsenl4WlVaWC9lcDkz?=
 =?utf-8?B?V0M5UHFPa2xKMk1oZVhNQTEzNlJIRy82SWNWRGVLZUU1SDA5RDZWWXpYUGk0?=
 =?utf-8?B?VUJLc3lxRHJzQUFweW5Ib0EwV1J0R0w2VFVISW0wQ2t6bzRRUFRqU2ZhYWE5?=
 =?utf-8?B?Y0FsalhMbjNDcTh1QzZzUERCOWRTdGJuTXM1M1JFZWlXZU1VaWxHcGVUSjly?=
 =?utf-8?B?WVdiR0R1WGdQbmVEaXpRL0xsNXlHcmZCcFZoeHcwTjc4L3pYN0hvYTVieTRi?=
 =?utf-8?B?QmxFS09PaVFGSkVkWmQ5MUNuOW5uNlJvTXp4Rytta09LV1NrQjJTQ0UvUGF5?=
 =?utf-8?B?aFQ5VnBud0dHc2Z2NWhNYkpONG9mUnc1S0hyZUMzdCtIL0Z6MlhZZ3BUSkVu?=
 =?utf-8?B?OW5IeTFNdVdjM2hzS21PelVPR0VjQjQyNzlWMjJpWERUdVppQUVwMTl2M1Jk?=
 =?utf-8?B?TUVmVjJRTGpnZm92L1FQK3dBRlhFb2NXUzdrcXhUaW9sZlA2UnFEMWMxWm9V?=
 =?utf-8?B?dU1MZ0Z6akNUY1FXeENaOVVjYjhSZXVLdWU5UGVVN2dsbngvQlMwNFBXYjRO?=
 =?utf-8?B?ZjdaWlRkYVRsYk16V2tGemNEc1Q3aUh3QXExRWxZWnRiU1htS0pNY1hEZVM1?=
 =?utf-8?B?R0E3ZnFZalRiRzZpejdzcmpWeVROMVdZdW1pTVVvWTVvaWd4cG9RRE0xY2xF?=
 =?utf-8?B?dmhnS0FKQzNlNTFDcHU1d3dBYTFycFdHMzFQUUI0VUJxM2JycDVUOEVxWFdU?=
 =?utf-8?B?bU1VM2h3aE1ZUzJXVDJ2dGZvSG1Gd2hzaEVYS2FiL0NSTnVMOVVIUEJoRUZF?=
 =?utf-8?B?VjczNVh2T3RyZjhyM2lEeXpOaDMveWF6UzhHeHdTK2h4U2hvR29IcTlhbWdj?=
 =?utf-8?B?UmNzaitpcDZObmx1TUJjQkRucmZVVUxIcys2Y2pZYk5XSHBPSFpsMlNZU2xE?=
 =?utf-8?B?ME0xOHQyM2doUjdvd3R4a2tXaFF4N0tPczZpSVhJV1VXK1lBT1FYWFpDZU9G?=
 =?utf-8?B?c2R1NFVmekVGWHE4d3JBbnJNQzZZa1NEenRLaXZmMW1lQytlZmVMN1A0a2c0?=
 =?utf-8?B?S0xLSnJIVjFaSC85NEJNUW55QzlyRmhlckwzYVV6eTY3ZVU3alc0bUJvMTd5?=
 =?utf-8?B?M09sWDVjRjI2MU9hRlc4N3ZNbmpIQlcyWElpVEtXQ1JhSU1ocytLc2dLSlVB?=
 =?utf-8?B?aEFnRzdJOVRsRmJSUjU4ZVBpSTdpOGxnUVIwOTZZQUFGUVJxUy9qQVc2MlFt?=
 =?utf-8?B?bHFCc1NoVzZRRWM5OHdUdnJUeDFVNXdxQkY3SG05MTlGdXBRaHE2SVJXaVJk?=
 =?utf-8?B?TTVYd1ZuS1R3ZFZ0ODA1NGZ3aE5IUXhQcW5pUlp2cVB5dWYvWVZmZXZQMWht?=
 =?utf-8?B?a015dThEeGpWMDF5djV5d21CcWg1YitJT0VINDd1bVRYMTNzZkt1SGw3OHU2?=
 =?utf-8?B?Uk15L2ZXY1p5d0ROVytzY21raGZ0TDZWUmkzY21pc21ZN0hZT0hRb3RSOHNo?=
 =?utf-8?B?cEpHa1EybTNSRHI2R1liVFFUd3RnQTNlcDFnSklXN3FxTklkWFVXWXVzT0hk?=
 =?utf-8?B?ZjMzR2dhcGxEMjBkdWtuM3RLRWtTaWFMcy9kdWxReWcrcTlLSit1Z1JIb0g1?=
 =?utf-8?B?d3VxQWhxalN2Y3VaQ1daY2w1eS9SbktmT0pPbS84ZHNPdDgxbE9MUFlqc1Fv?=
 =?utf-8?B?b0tJdTM3WURoUGRBZmNiUzNnMjllbWk2OG9xcHo5eTlkNEpyVTB0ZmtIZnVH?=
 =?utf-8?B?K2o2ak05UUhQZmVST3I5VGQxMlVsaG5ZTHZCangvRFc3ODFCTXlsa0d6Q015?=
 =?utf-8?B?UHY5N1Mzc2gzZVQ3RkhqRnNjekp2NzZNT3kxb2p2YjN4OUV6LzNHY2VYbkc2?=
 =?utf-8?B?Y1dNTDU3NmVUdXNJdllQUnhJMVF4Y05EaXMxZ3hXZHpIdFZzU0RVcHV2RjJK?=
 =?utf-8?Q?0kpqAvHoB08=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB2011.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjVQMDNRSW5wNVd6YU5FWEhwUWV5SkZmVzYydElNdURpVDUrc1l2cURCNEo3?=
 =?utf-8?B?dERtWUN0aUFQT3phbkhSODZYMVhkVDBOcllGaFJIbTc5K1MwNFd2cFFiWWVz?=
 =?utf-8?B?ZkYvMUlibThZQXVZOGY1M09rOE11TGVHUnZIVy92QTRGUVA1U3h6UzVoRUR6?=
 =?utf-8?B?eEh2bXAySE50ZEZBcEg4WmdpM0Q3NGRzVktWK2hIMUw5dWdSUjgvZlZic0RK?=
 =?utf-8?B?bzBDZjQ2dTNuZXdEUTVXMEZ4ZFlHRnhvSUpWSzhyTkRGb21ZN2owelJkOURo?=
 =?utf-8?B?RjBMc1Rrb1p0ZmFhYlB6WnlDbFFqR01CaXhkQUErTUlEUGhFMVgrUDlzVXNE?=
 =?utf-8?B?OUYzWDBOVGlOazZLdjVsdUxhZGlyS1gwcXEvSzhSbitIbnM3cDBpRmlIY2FT?=
 =?utf-8?B?eHprSU84SVdLVWh2NTg5RmpQdmVYTTdnakkyK3pxRXNkSFVzQW45bWw2bGh4?=
 =?utf-8?B?SEpnWVpHK2F2cFFkakhsMHJyNHoxN3VwWEZTVHJzQlN3VnVWWWMwSGdIWm04?=
 =?utf-8?B?cjJlT3lHMy9MWjBWS2lIK2I3MmtJT3JZcE9oS21YY0FKUkZpZVdIeHVPQ1h1?=
 =?utf-8?B?ZE85eHo5Y3VPdmtSUTRhTmVFU0xPUng5OHUxQW14VEVQOVlzN24xUEl2YnJt?=
 =?utf-8?B?N2l3ZDA3TEVHcEtvc2RVK1JGdk9ML3NBYlVDR0VvR0xLVEdtV29Sa0pFNzZS?=
 =?utf-8?B?M1NNZlAyRmxFU0lhckFHN0JZVnZLOXppcm9GT3J5a3RtNUhPcGc1ZWJ0RkRR?=
 =?utf-8?B?cHNXRGs1TGRwNmd3QUxJdUhFSStOR1FhbnMySmJKc2owV3pBK0tVWjdyMVRV?=
 =?utf-8?B?Vms1UjYvL1RTcnFyWldWNWgyVjAyK090M0JLeDJGaXlPZmlZS3oxb0Vvc1BK?=
 =?utf-8?B?TSt0cHdQQWw0eDZPMlAvcUtkSS9QOHN5TUlvUVNudjNsK1pCQzh3emxzYVkv?=
 =?utf-8?B?SUxsVHhFVFIrWHhKbVREYkpGYXBJa1lvYW1FNHZscDhYcXZ1Q0RWVGRETzRy?=
 =?utf-8?B?c1VGWDF0S2pEc3VXTlNsTmo2L1ZwU0ZZVkJOR21jdmx1UDczV016a21RS3VR?=
 =?utf-8?B?Q0pIZ2NYY0dMSDZzWnY2VklMdGlJL0QwOHhvckMvWjlXNG8wdlRlWE0vMXlV?=
 =?utf-8?B?VmtVUkxJS0oxOWNBN2U1ZDZ1enJvNnlFTlliNmtKMHVORFJuS0J3Vk1LdUJj?=
 =?utf-8?B?NTllSmNxV3Jwb2tMeW1BOVRBMDhIeHJkdHhvSTdNSEZ0MTlhdFBKSXA4ZGRU?=
 =?utf-8?B?OEwvcUxCZUliamxtUzlLZ29EZmpsSDFhbmlsWXI0WEJ1SHZOMVhXMlZvSHBt?=
 =?utf-8?B?KzA4R00xRXdpUXZ6b1M0STA0S0JKeWNHMXUxNi8rOTRwMXcrY0E4amRJYmtS?=
 =?utf-8?B?ZG5sTDkyeXhzRzA3N3p5c0lSVmgzWTZEeXZhUlFPdmZXVEVaZS93Mk51ODBL?=
 =?utf-8?B?OEUxS3M2VElpZDk3dDVBWUMva2JYMWxodXJORFNZU2V4MyszRFZCeDBtSUds?=
 =?utf-8?B?MHZCZDNlV1d0M1hldCtUZjNkMVdVcVpjRVNiMkZOU0pZV1BHem9hWjNoZnE4?=
 =?utf-8?B?bDV2d3FMRG9XZ1VNVlRaUGQ1SjlqaGJuak8zU1VPbFo1ajBNUkp1cm1kMU5W?=
 =?utf-8?B?NnhrL1ExaVQ5VENtNTBFbE1VM3Bkdzk5MVNjclg1RDdZUTliZUlMY3l1cEdY?=
 =?utf-8?B?aS9SRnlrS24xM2p4SlFrMVRBbC9LWnQyVEVXSVdGZnFtQm5oUE9CempPT21a?=
 =?utf-8?B?Slc1NDNEZWM2K0J4YmtTOW5acHdrQWhUS3JnWUQ3WG5RbTd2M2trMGJ5aXlP?=
 =?utf-8?B?S3ZKekNXTE5KM0tReVBadEVaUFFWdFl5WFdNRG5saXlUWE1ESFNKV0NJOTdJ?=
 =?utf-8?B?K09XNjI2WlIvcGR2c1RTS0hJbERmd0VEQ3k2dnFHd2lyRGs4MFM2NVNNMWxp?=
 =?utf-8?B?T29BckV1V2lGOThEdWNlRVVHbDNtcWRWeTZydTAxYUVsZFF0cUdtdGpraFZQ?=
 =?utf-8?B?NFEvOGd4WWhZMnd5R3UrbmI1Ykk4K0kyYWpXZjFJVG90Z29hUFhYdlpqWmFn?=
 =?utf-8?B?ZE8ycm94ZkNlL05ZN2hJNlBma3Z1alFqeCtldEFQYmNMWVkwVnQrbkV4MmNH?=
 =?utf-8?Q?AACk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D69C07E51BD11D4DA222A05C2E8F4B3B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d0e20f-5c12-4b12-98b3-08ddce806580
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 09:15:01.0406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58gMXo/xgXKM7yCmHGxky4MHmPXLZj2WIVOx7bhVqE51GgLEhBeTqwEmgMCv9scS5fXkvq4QTk1vXYzRCqYI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1587
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

SGksDQoNCk9uIDI1LjA3LjI1IDE1OjU1LCBUb20gUmluaSB3cm90ZToNCj4gT24gRnJpLCBKdWwg
MjUsIDIwMjUgYXQgMTI6MzU6NDBQTSArMDIwMCwgQmVuamFtaW4gSGFobiB3cm90ZToNCj4NCj4+
IEFkZCBuZXcgaW14OG1wLWxpYnJhLWZwc2MgYm9hcmQuDQo+PiBVU0IgaXMgbm90IHdvcmtpbmcg
eWV0LCBhcyB0aGUgZW50cnkgaW4gdGhlIHVwc3RyZWFtIGRldmljZXRyZWUgaXMNCj4+IG1pc3Np
bmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gSGFobiA8Qi5IYWhuQHBoeXRlYy5k
ZT4NCj4+IC0tLQ0KPj4gICBhcmNoL2FybS9kdHMvaW14OG1wLWxpYnJhLXJkay1mcHNjLXUtYm9v
dC5kdHNpICAgICB8ICAgNzggKw0KPj4gICBhcmNoL2FybS9tYWNoLWlteC9pbXg4bS9LY29uZmln
ICAgICAgICAgICAgICAgICAgICB8ICAgIDkgKw0KPj4gICBib2FyZC9waHl0ZWMvaW14OG1wLWxp
YnJhLWZwc2MvS2NvbmZpZyAgICAgICAgICAgICB8ICAgMTYgKw0KPj4gICBib2FyZC9waHl0ZWMv
aW14OG1wLWxpYnJhLWZwc2MvTUFJTlRBSU5FUlMgICAgICAgICB8ICAgIDggKw0KPj4gICBib2Fy
ZC9waHl0ZWMvaW14OG1wLWxpYnJhLWZwc2MvTWFrZWZpbGUgICAgICAgICAgICB8ICAgMTAgKw0K
Pj4gICBib2FyZC9waHl0ZWMvaW14OG1wLWxpYnJhLWZwc2MvaW14OG1wLWxpYnJhLWZwc2MuYyB8
ICAxMTQgKysNCj4+ICAgLi4uL3BoeXRlYy9pbXg4bXAtbGlicmEtZnBzYy9pbXg4bXAtbGlicmEt
ZnBzYy5lbnYgfCAgIDMwICsNCj4+ICAgYm9hcmQvcGh5dGVjL2lteDhtcC1saWJyYS1mcHNjL2xw
ZGRyNF90aW1pbmcuYyAgICAgfCAxODQ2ICsrKysrKysrKysrKysrKysrKysrDQo+PiAgIGJvYXJk
L3BoeXRlYy9pbXg4bXAtbGlicmEtZnBzYy9zcGwuYyAgICAgICAgICAgICAgIHwgIDEzMSArKw0K
Pj4gICBjb25maWdzL2lteDhtcC1saWJyYS1mcHNjX2RlZmNvbmZpZyAgICAgICAgICAgICAgICB8
ICAxNzAgKysNCj4+ICAgaW5jbHVkZS9jb25maWdzL2lteDhtcC1saWJyYS1mcHNjLmggICAgICAg
ICAgICAgICAgfCAgIDI3ICsNCj4+ICAgMTEgZmlsZXMgY2hhbmdlZCwgMjQzOSBpbnNlcnRpb25z
KCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg4bXAtbGlicmEtcmRrLWZw
c2MtdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14OG1wLWxpYnJhLXJkay1mcHNjLXUtYm9v
dC5kdHNpDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi44
ZjBmODZkOWYwOWUNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg4
bXAtbGlicmEtcmRrLWZwc2MtdS1ib290LmR0c2kNCj4+IEBAIC0wLDAgKzEsNzggQEANCj4+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPj4gKy8qDQo+PiAr
ICogQ29weXJpZ2h0IChDKSAyMDI1IFBIWVRFQyBNZXNzdGVjaG5payBHbWJIDQo+PiArICovDQo+
PiArDQo+PiArI2luY2x1ZGUgImlteDhtcC11LWJvb3QuZHRzaSINCj4+ICsNCj4+ICsvIHsNCj4+
ICsJd2R0LXJlYm9vdCB7DQo+PiArCQljb21wYXRpYmxlID0gIndkdC1yZWJvb3QiOw0KPj4gKwkJ
d2R0ID0gPCZ3ZG9nMT47DQo+PiArCQlib290cGgtcHJlLXJhbTsNCj4+ICsJfTsNCj4+ICt9Ow0K
Pj4gKw0KPj4gKyZyZWdfdXNkaGMyX3ZtbWMgew0KPj4gKwlib290cGgtcHJlLXJhbTsNCj4+ICt9
Ow0KPiBQbGVhc2Ugbm90ZSB0aGUgYm9vdHBoIHRhZ3Mgc2hvdWxkIGJlIHVwc3RyZWFtZWQuDQoN
CklzIHRoaXMgc29tZXRoaW5nIG5ldz8gSXMgdGhpcyBkb2N1bWVudGVkIHNvbWV3aGVyZT8gVXAg
dW50aWwgbm93LCB0aGlzIA0Kd2FzIGFsd2F5cyBkb25lIGluICotdS1ib290LmR0c2kgZm9yIGFs
bCBib2FyZHMuIE9ubHkgdmVyeSByZWNlbnRseSBzb21lIA0KazMgYm9hcmRzIHNlZW0gdG8gaGF2
ZSBhZGRlZCBib290cGggdGFncyBpbiBrZXJuZWwgZGV2aWNldHJlZXMuDQoNCldoeSBpcyB0aGlz
IHN3aXRjaGVkIHRvIGtlcm5lbCBkZXZpY2V0cmVlIG5vdz8gQXMgZmFyIEkgc2F3LCB0aGUga2Vy
bmVsIA0KZG9lcyBub3QgdXNlIC8gZG8gYW55dGhpbmcgd2l0aCB0aGUgYm9vdHBoIHRhZ3MuIFRv
IG1lIGl0IGxvb2tzIGxpa2UgDQp0aGlzIGlzIHNvbWV0aGluZyBmb3IgVS1Cb290IGFuZCBub3Qg
c29tZXRoaW5nIHRoYXQgdGhlIEtlcm5lbCB1c2VzLCBzbyANCkkgd291bGQgZXhwZWN0IHRoaXMg
dG8gYmUgaW4gdS1ib290LmR0c2kuDQoNCj4NCj4gW3NuaXBdDQo+PiBkaWZmIC0tZ2l0IGEvYm9h
cmQvcGh5dGVjL2lteDhtcC1saWJyYS1mcHNjL01BSU5UQUlORVJTIGIvYm9hcmQvcGh5dGVjL2lt
eDhtcC1saWJyYS1mcHNjL01BSU5UQUlORVJTDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4g
aW5kZXggMDAwMDAwMDAwMDAwLi4xNmIxOGI2MDVlMGQNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsr
KyBiL2JvYXJkL3BoeXRlYy9pbXg4bXAtbGlicmEtZnBzYy9NQUlOVEFJTkVSUw0KPj4gQEAgLTAs
MCArMSw4IEBADQo+PiArTGlicmEtaS5NWCA4TSBQbHVzDQo+PiArTTogICAgICBUZXJlc2EgUmVt
bWV0IDx0LnJlbW1ldEBwaHl0ZWMuZGU+DQo+PiArVzogCWh0dHBzOi8vd3d3LnBoeXRlYy5ldS9l
bi9wcm9kdWt0ZS9zeXN0ZW0tb24tbW9kdWxlcy9waHljb3JlLWlteC04bS1wbHVzLWZwc2MvDQo+
PiArUzogICAgICBNYWludGFpbmVkDQo+PiArRjogICAgICBhcmNoL2FybS9kdHMvaW14OG1wLWxp
YnJhLXJkay1mcHNjLXUtYm9vdC5kdHNpDQo+PiArRjogICAgICBib2FyZC9waHl0ZWMvaW14OG1w
LWxpYnJhLWZwc2MvDQo+PiArRjogICAgICBjb25maWdzL2lteDhtcC1saWJyYS1mcHNjX2RlZmNv
bmZpZw0KPj4gK0Y6ICAgICAgaW5jbHVkZS9jb25maWdzL2lteDhtcC1saWJyYS1mcHNjLmgNCj4g
VGhlc2Ugc2hvdWxkIGFsbCBiZSB0YWJzLg0KV2lsbCBkby4NCj4NCj4gW3NuaXBdDQo+PiBkaWZm
IC0tZ2l0IGEvYm9hcmQvcGh5dGVjL2lteDhtcC1saWJyYS1mcHNjL2lteDhtcC1saWJyYS1mcHNj
LmMgYi9ib2FyZC9waHl0ZWMvaW14OG1wLWxpYnJhLWZwc2MvaW14OG1wLWxpYnJhLWZwc2MuYw0K
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uODliM2I2Zjkw
ZWNiDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9ib2FyZC9waHl0ZWMvaW14OG1wLWxpYnJh
LWZwc2MvaW14OG1wLWxpYnJhLWZwc2MuYw0KPj4gQEAgLTAsMCArMSwxMTQgQEANCj4+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPj4gKy8qDQo+PiArICog
Q29weXJpZ2h0IChDKSAyMDI1IFBIWVRFQyBNZXNzdGVjaG5payBHbWJIDQo+PiArICovDQo+PiAr
DQo+PiArI2luY2x1ZGUgPGFzbS9hcmNoL2Nsb2NrLmg+DQo+PiArI2luY2x1ZGUgPGFzbS9hcmNo
L3N5c19wcm90by5oPg0KPj4gKyNpbmNsdWRlIDxhc20vZ2xvYmFsX2RhdGEuaD4NCj4+ICsjaW5j
bHVkZSA8bGludXgvaW8uaD4NCj4+ICsjaW5jbHVkZSA8YXNtL21hY2gtaW14L2Jvb3RfbW9kZS5o
Pg0KPj4gKyNpbmNsdWRlIDxkd2MzLXVib290Lmg+DQo+PiArI2luY2x1ZGUgPGVudi5oPg0KPj4g
KyNpbmNsdWRlIDxpbml0Lmg+DQo+PiArI2luY2x1ZGUgPGZkdF9zdXBwb3J0Lmg+DQo+PiArI2lu
Y2x1ZGUgPGpmZnMyL2xvYWRfa2VybmVsLmg+DQo+PiArI2luY2x1ZGUgPG1paXBoeS5oPg0KPj4g
KyNpbmNsdWRlIDxtdGRfbm9kZS5oPg0KPj4gKyNpbmNsdWRlIDx1c2IuaD4NCj4+ICsjaW5jbHVk
ZSA8aTJjLmg+DQo+PiArDQo+PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX1BIWVRFQ19TT01fREVU
RUNUSU9OKQ0KPj4gKyNpbmNsdWRlICIuLi9jb21tb24vaW14OG1fc29tX2RldGVjdGlvbi5oIg0K
Pj4gKyNlbmRpZg0KPj4gKw0KPj4gK0RFQ0xBUkVfR0xPQkFMX0RBVEFfUFRSOw0KPiBQbGVhc2Ug
YXVkaXQgdGhpcywgZ2QgaXNuJ3QgcmVmZXJlbmNlZCBmb3IgZXhhbXBsZS4gVGhhbmtzLg0KDQpJ
IHdpbGwgZGVsZXRlIHRoaXMgbGluZS4NCg0KUmVnYXJkcywgQmVuamFtaW4NCg0KDQo=
