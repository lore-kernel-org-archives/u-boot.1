Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F32CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDEFA82C84;
	Mon,  8 Sep 2025 10:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oI4yDqDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FF282CF8; Mon,  8 Sep 2025 10:28:23 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B343E82A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSE3a1HCyBBIpstfo3ph0QPx8XWoswtIvD7zotPpCWuEoFx7Uc95H2mfZf2/+7ryWivKT7FwDfaOzCb1jBtcecIXt2re2x1PVQ0Mhtm8b/Ta4+nbPRCl2lRHtfYY+U/8T+lrXdYpqMT5Qi9DYPznTbSgVU52q+/dc/zylcNHXtcsBh5QQnNt96zW/Hn0EOcmw9HdgraAmd7ZjUbhg9diDnM+Z6mCA3Sc5EEMDH8Tca8r7amwFJvI2Ef9V9f2twRBBahYF+UUsrQpv4HiHZWHN4ZkVBWAnlDLT/0DtBYVNSxOd55KwbrQljsp3JY2QklFlP/UMfd01cW7KhYAEoitmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAULJIKPNWVD0Pyv9zGjxDE+RI4dxqWI+s9JEcrfjq8=;
 b=WkMNfCm8lsIKGdALonBpZ6AdsH2zaTXtIJ12WW+IDwab8aO2Xjb21V3PZNHFa/g8G+kQ4tKFQQsUhbYllDLP7dOc9VhTgBrxihct0pZ6xyj3vr11K0mIFELuYQUHnGLx99z6ygBHaJBiTw86SR6lIVN3xWHQXkH+CHjawGRz1TLJVyB1fKOv05R8DCkfm8vXpK01o66p/MjFdRW1wX2qcN0VM1hyjWNAzN6dtxbI6lYz4Ry3ogN8MbCGR9lnLLVv6NqpAwNcsv+dsTOqJydGI0IcD1rb4XYoEMJLxddHtAeHqehJoWeO8wrk/TpdEhws7KGW/zggvUY0VtxmQqtluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAULJIKPNWVD0Pyv9zGjxDE+RI4dxqWI+s9JEcrfjq8=;
 b=oI4yDqDW5c8E4Zo8KIHnWwY6qlvXLZxPp8OGcuQWOOCI8Sdu02zKWvuh88ggABGzoe2ZgKvy4XIa+2P88nHwEWe8DB26N/c/Zp6I7TofTgxRs66KzMybLy34lGS1FqF3HyF8dxzqd2yBOKMnarzsJB++HTvcWX2U+8KCmYdkoJR9UBPNc9eKk8YabOMcTVhb24w8alWtGJCLQtnSlSDFk4+7ZKU8ok5O2XHR5AQpXGSLhbQPwN6wGJ6tJEw9V4tZgX3fBYJx3aicMu/yIAiRqBEc4Ez8bp1Nv3Lv8Hy4ep/+wBEwtJlpS1VRjR4GAxe9T+l8QmhNg9PFq35DP7arpw==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by AS4P195MB1431.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:28:16 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 08:28:16 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Jan Remmet
 <j.remmet@phytec.de>, Benjamin Hahn <b.hahn@phytec.de>, Yashwanth Varakala
 <y.varakala@phytec.de>
Subject: Re: [PATCH v3 2/3] doc: phytec: update imx8m docs for optee builds
Thread-Topic: [PATCH v3 2/3] doc: phytec: update imx8m docs for optee builds
Thread-Index: AQHcIIqbxdDxdTeqa02Y/oe4dswUeLSI8/WA
Date: Mon, 8 Sep 2025 08:28:16 +0000
Message-ID: <4235545091de49b243e9d49eac04a5987bd6c96a.camel@phytec.de>
References: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
 <20250908-imx8m-optee-enable-v3-2-14bfe249b3c6@phytec.de>
In-Reply-To: <20250908-imx8m-optee-enable-v3-2-14bfe249b3c6@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|AS4P195MB1431:EE_
x-ms-office365-filtering-correlation-id: 88de6632-2c4e-4c7e-deed-08ddeeb1a8db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OXBGZWYyMEJCZDR6cVhkalFwTHl5ZVdkcjZlRHo4R1VuNTI5T3BaWGpPSjM3?=
 =?utf-8?B?SnVNaC95RUFucFdmbll0SVZlNUtEVjJlSUpaWDlNbzh3SVJ5eTZHcGNkckZK?=
 =?utf-8?B?ME9TK1M3RUVCaGFyNitwc3hEMTJOL240ZXFQMlA2NW00MVptKzcvUm1qWWlR?=
 =?utf-8?B?UmtnQU9QeUhlZ0J1SkZVTlN2TXVtNjU5elUvMksvdG9xM21XS3lGUHRpcGRz?=
 =?utf-8?B?clVleTUvcFpzNGc4OWF0dHVqUzFwTE54THJPLy81RjB2QzVYR2x2RW1CNytG?=
 =?utf-8?B?M1hzWlgvVk4wWHp6RWo1NGF2Q3dmb1dKR0d4Y3NRUklMUzN6VWVXdmNZMFo5?=
 =?utf-8?B?SmlOTStIbXVwVmMxWkE1NmlyK0pRd2NlNzJUZWRhNDRvc2VRRkZjSE5aQ0Qy?=
 =?utf-8?B?N1lZUnZMSEIwdFJoRjg3MUZGb1VJKy9LN0labVUyMDl6WjdtL3lRak1LYUtI?=
 =?utf-8?B?Q3ZtZzRucWJZbFUwQS82eXoxVzM3RUlKWFVCc0luWVl1WkZNNytMWDBCdUpt?=
 =?utf-8?B?bjB5YjM2UWo1eFQrRWw2R2p5QnZLQ1ZtY0l1VHozVjJTdlFNczFJTi9RMjVl?=
 =?utf-8?B?cjgyRElSOXBHbkNDaVdFRkZYZGlRTWJTMHRUMEdHVm5MdUFsaUJsOVpHMnp5?=
 =?utf-8?B?TFhCWnVYTTRhWWp3QnkrSE0yanJBNWU4a0dRaFdGeWd1STlGclkzSkZJdFU2?=
 =?utf-8?B?WHN0a2FtVW9sRWZmVEJwTll3TWFoU01Sb3JQc0ZqaGNmejcvMGRZZndvRWtx?=
 =?utf-8?B?ZUxwRTRJdE9HdTQrbVJqWm1FYTdKUEVNR3hTZm9kaVJIdE1oK3EyOU12bUdB?=
 =?utf-8?B?TVk5Y3ZZQ0xJV1czUDlla3VJUXhmK2U2eHBRaytWcFd6RW0yZ2F2S1BIRDlR?=
 =?utf-8?B?NmN3SExuQ0VOUGdMZzh5NUFYT3lDMWxibWpqQkMybUxUOUFyTGlmMVQrcEJT?=
 =?utf-8?B?VlhxeSs1Q0tWMHg1VFJhUy9mNXdBVzc3UFY2K3lPa2g1SmEvQ3NSdzBZV2JT?=
 =?utf-8?B?UUNrVDVLd1BtcVRBTEpzVEZCcjhGbnJOOHVsU0RtcGdIbEk5UzZ3THArZ0du?=
 =?utf-8?B?MEVxajNmeUI0bjVQRFVCRDVrbkxwYWh0WEVFNVg1ME9DdUpvRHFUemFReVJF?=
 =?utf-8?B?aXJENmEveHJteU1WTG9ySnJZaE8wWkk5UmlwaldDZCs5VTk3MitnSDFSRG83?=
 =?utf-8?B?QlhLcmppZitVTTNLMGtxNC96a3JPdHJsVU5jQVhrVitMSFdIc2hZSi9JMVpz?=
 =?utf-8?B?d1dWVlBGNEFrci8xTW9WbTdLK2llSkNHdGVBTW5zOTZnbHRjbU5MUzF3dHRn?=
 =?utf-8?B?bk1CZ0V5SWJNd0locnFGa0tUemxtRGgzUThlQXkvOWRxVXlub1BwSDhVL0I1?=
 =?utf-8?B?TGhlVE1VbTRkQXBWR0l5MmovL0w0M0pEdHV6OXhKUHdxSXZGV1ZBR3hvbjRW?=
 =?utf-8?B?aEhRbExpUHpIYWlzNWk5MEhta2d2MW53K29PV1BZVGI1Y1dnajJDOUwvNysr?=
 =?utf-8?B?cjd4bFc3SUpwSW8rNCtLNXJkVkZ2NE40bWFickZvbXUwQUtnTExzMnVtYUtK?=
 =?utf-8?B?OXNJZ05pbmtCeVBzOVU4bDMwVndOSEdubFlvSGFRQzZ0TjdqWVhkdUIwVjRX?=
 =?utf-8?B?Z3p5NUVCZFRpR3hTU0ladE5LWjdtUjFKazVCUmEvbExuU280RTR2RU84SG04?=
 =?utf-8?B?TTRsRHcrM3pYYWt5ZG9SNmNLRE5iNFRzbDVjNXkreWZFS21QbjhKOSs5SUJM?=
 =?utf-8?B?Y21KRitrRDJkSm9teDdQQUx3c1RCTnhpSXVMUjhnd3hUWmFFSGV6STlXZFpJ?=
 =?utf-8?B?c3ZwN2FsOVRUaXk2NisyVUdVKytuY1VYcVJzOGVjZ1pmVnlPdkkxeVcrVXdt?=
 =?utf-8?B?NG5jcFhsVUpGUVF1VThkSHZIRFJaR2dzOGpDOElwYlhSZE9zY2doSnl4NGxh?=
 =?utf-8?B?TVZPbkdGSGxuTGcwU3ArTUt1QkRKNi9KbXVqMjlscnNsL3VmU2Q0cHpCQkNj?=
 =?utf-8?Q?ScuPcQNdMsX7zMUMk2OULX3hIm6OhY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVE4SjR0NWhhSEh3c1JmNHZTNFhxK3RZTTNXTGllQjY1MDlTRWFhUVpDSDdh?=
 =?utf-8?B?bXE3N0xhNldXd2VaTlVNNHZpd0xTcUJCNFllV3VrYUdxSkVJYUZHbXNKUi9o?=
 =?utf-8?B?Uk9iVU1ubWJJc0JyRUV4L3RvSEFrUkFYQ1J2eEN3L2l4VU82b2c5cC9mV2FM?=
 =?utf-8?B?UTRaVWxyT0RMUCtYRlVCZUhMN2RGSjkrSytHQzREYkVjaUZDcDVxRiswNlh0?=
 =?utf-8?B?U1lrZ1htUy9CTjgwd0RrbitvRHpKbGZpaVFVNWFDTk45ZFQvOFI2SDNieEtG?=
 =?utf-8?B?c2ZSMVl4ZmczZnFQOFdpQnVwTFRJZXRpMXRVMW1BMEU2R1hDMkd4V3ZlaFJ6?=
 =?utf-8?B?VW90UGgrU1FBUEpieUNtZnJ5dUNrdWlVV2pRWU1HTlRBWDV2OWZBbUdVNUM5?=
 =?utf-8?B?Q0wvYW9JZ3plby8xdGVQL0YvYlNYS3VBQ0ZHMGR2Qnp4cVJyaVhjM0pvR3p3?=
 =?utf-8?B?dWVDUWtqaGhYK1V5aWdDbmMvSmljMFRuRFpIQ0FxcVFkTXFqTWpiMzM1L2I0?=
 =?utf-8?B?ZkdnSVkrTXBYblhCSG9IS09wdktwV0ExenkvNlZ1WFBFN3E5TnB1czZLNjZW?=
 =?utf-8?B?OVF6QWdkK3J0NFZkMkFoMnRnOTFXRzl3TGZ5bWJkK3pjSFcrYU9rRVVpZnZr?=
 =?utf-8?B?VE9SZnVZb3pEK3FuU2FtQndJZmlKMGFtRjBHN1BCQWVva1lKa3gxY2R5L2Ns?=
 =?utf-8?B?TW00azM5YkFnQSszaVMyVHJ0MVhVNVBpN0pqTkJpUm9rK0RWNytrRUFvNGdK?=
 =?utf-8?B?eXZwUi84Nk5BMU9vckY0Nzk1bCszQ0ZEM25lMTBvYTcrcUp5alRnUlhVWFFG?=
 =?utf-8?B?dGVtNmdxcW9qSm85N2M3V2taR3JJNWYrdXNwTkNxZU9HdEFYWHIrWWZlUG0x?=
 =?utf-8?B?ZmFEY2lxb1ZKeURzZlpBaXBTclgreXJNQXRNek1QYzlHU1RMWjUyVndNMFdT?=
 =?utf-8?B?N05hdFdTSzcwT1cwS3I1QWxqNjlIdDlrWHhxVDBUeEdGeDZvZC9vbmJyYjBE?=
 =?utf-8?B?a1VyaWdkdWFvc3NRa3g2bSs4SEhwV3AwT3pFMWg3dUtqUkxEZHdpdWIxK1VQ?=
 =?utf-8?B?cWpKb0ZLUWsyNXdlSlVYVXlQV1drRFF2ZkZITURqenE3TWdQOEltWUlDTHBL?=
 =?utf-8?B?QWdIZ3czSGhiWGQzNmt2NXFYTEwyV2JMdXI2cWJRK1lrWDg3T2h4QVVHSktD?=
 =?utf-8?B?NW9tQ3lFa3F2cmN1cTJUOTBRalpQOW5BNlViY2xvWnpOc3hkWDFmbUNMRTlE?=
 =?utf-8?B?YlhNVEpiM0djbkdIWDRNMnAxVUVRMnBNcTJVc0hXNjJvVTRzQWY4QkRBcmFG?=
 =?utf-8?B?cjlTRldBcHhXRWhVTWdJd1drNnRmaC9IY01DaVRuS1RBWVVyb3VEcXFZcStJ?=
 =?utf-8?B?b3NRTXgwcjlIRVhUQzV1OVVQRDk1L1U2N3lrVWY3MndmN2xWUUVkbVZzZG5i?=
 =?utf-8?B?T25QNStheVBpMk5jODJWTitlY2xId0Q2ZjJnS2tlK29LNzlFU2J0ZGZCb2lW?=
 =?utf-8?B?K0dYSXpKR29jU2l5WlN1ZWplQkI0YSt6WWlCZjUyL0lhMmVzc0MzWFBvbi9a?=
 =?utf-8?B?ZExjU3VoL0VOVHYyeTBRb0g5YnFHVlY3WWRzbWdRRUlFK1hyeVNJQW1saW5S?=
 =?utf-8?B?VHpIS3o5SkVweHUvTmY0aU9yTTdkZ1V2Tmh0R1piOG40WlBhMFdMOHBwM3R3?=
 =?utf-8?B?MFhOd0pkNmRLSG1Gb0dGREIxY3Z3RzNTVHRQdzRCMGtDV1BoLzY4dkY3ajhw?=
 =?utf-8?B?MUprWWcxZkpRZmxWM3F4YXJHb1RyeDI0U3lHeUFRMngwOU5BZ05ucVZHcGFW?=
 =?utf-8?B?Z0c0eTdWeU4vL0ZvRlBsa2pzRGxqMkttb3REVUYrWjFaTDJuc0JsNXFSQS9y?=
 =?utf-8?B?SlFPSnR3M0ZFRTFBK2NLcVFPNCtnWDJ2MnVwWkxSOTlHdjZmUDgwK2psZ2RD?=
 =?utf-8?B?Nm1YcXg4MTlWUFlvcEk2b1Jic05BQnJ2U2hId1FHMStqdm4xUXZxcEZ1M2JT?=
 =?utf-8?B?dGRHS1VTaUhLam0yWmhFa1c5eXprSWpTbjd4R0tTcnVmejZVYVdVMG9LQ1hq?=
 =?utf-8?B?dU1WYkxETzVUeFR4bkJwampFcEI2MGdrVXl5M2tNM29YS1JKbFk1c3lNMGNB?=
 =?utf-8?Q?opEQSL9sU28KCjk6GjgPmaxXM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50F6E085EFEDBA48832257AABE40A7B8@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 88de6632-2c4e-4c7e-deed-08ddeeb1a8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 08:28:16.5653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgpUI3GZ34pJ3bK3wF2tdz1ys4ZoPl3y+Y4gzPzrLBV98Lh5leJtbxFq7P6Z0BfSrzXEPsm9jul5lg5ZOe9YIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1431
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

QW0gTW9udGFnLCBkZW0gMDguMDkuMjAyNSB1bSAwODozMyArMDIwMCBzY2hyaWViIFlhbm5pYyBN
b29nOg0KPiBPUC1URUUgY29uZmlncyBhcmUgZW5hYmxlZCBieSBkZWZhdWx0LCBjaGFuZ2UgdGhl
IGRvYyB0byBubyBsb25nZXINCj4gZGVjbGFyZSBPUC1URUUgYXMgb3B0aW9uYWwuDQo+IEZ1cnRo
ZXIsIHBoeWNvcmUtaW14OG1tIGFuZCBpbXg4bW0tcGh5Z2F0ZS10YXVyaS1sIHVzZSBkaWZmZXJl
bnQNCj4gYnVpbGQNCj4gaW5zdHJ1Y3Rpb25zLCBzbyBkaXNzb2x2ZSB0aGUgY29tbW9uIGZpbGUg
Zm9yIGJ1aWxkaW5nIE9QLVRFRS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5
Lm1vb2dAcGh5dGVjLmRlPg0KUmV2aWV3ZWQtYnk6IFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBo
eXRlYy5kZT4NCg0KPiAtLS0NCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vTUFJTlRB
SU5FUlPCoMKgwqDCoCB8wqAgMSAtDQo+IMKgZG9jL2JvYXJkL3BoeXRlYy9pbXg4bW0tb3B0ZWUt
YnVpbGQucnN0acKgwqDCoCB8IDE0IC0tLS0tLS0tLS0tLS0tDQo+IMKgZG9jL2JvYXJkL3BoeXRl
Yy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdCB8IDE5ICsrKysrKysrKysrKystLS0tLS0NCj4g
wqBkb2MvYm9hcmQvcGh5dGVjL3BoeWNvcmUtaW14OG1tLnJzdMKgwqDCoMKgwqDCoMKgwqAgfCAx
OSArKysrKysrKysrKysrLS0tLS0tDQo+IMKgZG9jL2JvYXJkL3BoeXRlYy9waHljb3JlLWlteDht
cC5yc3TCoMKgwqDCoMKgwqDCoMKgIHwgMTMgKysrKystLS0tLS0tLQ0KPiDCoDUgZmlsZXMgY2hh
bmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL01BSU5UQUlORVJTDQo+IGIvYm9hcmQvcGh5
dGVjL3BoeWNvcmVfaW14OG1tL01BSU5UQUlORVJTDQo+IGluZGV4DQo+IDc2MzFlMWNiMzMxYjYw
ODMzNTYyMGQwZGI0OTEwNDQ1OWY2NzNkMWQuLjU4YzVlMmQwYWY5ZmU0MDRhNTk5NWZlY2M5Ng0K
PiBjZGJhYTU4NDVmOTc5IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4
bW0vTUFJTlRBSU5FUlMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL01BSU5U
QUlORVJTDQo+IEBAIC05LDYgKzksNSBAQCBGOsKgwqDCoMKgwqDCoGNvbmZpZ3MvaW14OG1tLXBo
eWdhdGUtdGF1cmktbF9kZWZjb25maWcNCj4gwqBGOsKgwqDCoMKgwqAgY29uZmlncy9waHljb3Jl
LWlteDhtbV9kZWZjb25maWcNCj4gwqBGOsKgwqDCoMKgwqBkb2MvYm9hcmQvcGh5dGVjL2lteDht
bS1waHlnYXRlLXRhdXJpLWwucnN0DQo+IMKgRjrCoMKgwqDCoMKgZG9jL2JvYXJkL3BoeXRlYy9p
bmRleC5yc3QNCj4gLUY6wqDCoMKgwqDCoGRvYy9ib2FyZC9waHl0ZWMvaW14OG1tLW9wdGVlLWJ1
aWxkLnJzdGkNCj4gwqBGOsKgwqDCoMKgwqBkb2MvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1t
LnJzdA0KPiDCoEY6wqDCoMKgwqDCoCBpbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaA0K
PiBkaWZmIC0tZ2l0IGEvZG9jL2JvYXJkL3BoeXRlYy9pbXg4bW0tb3B0ZWUtYnVpbGQucnN0aQ0K
PiBiL2RvYy9ib2FyZC9waHl0ZWMvaW14OG1tLW9wdGVlLWJ1aWxkLnJzdGkNCj4gZGVsZXRlZCBm
aWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4DQo+IGM4M2RlNWNjN2NmNGEwMjI5Y2JkODlmNGM3ZDJi
ZmQ4NDQ4Y2I3MzUuLjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMA0KPiAwMDAwMDAwMDAwMDAw
DQo+IC0tLSBhL2RvYy9ib2FyZC9waHl0ZWMvaW14OG1tLW9wdGVlLWJ1aWxkLnJzdGkNCj4gKysr
IC9kZXYvbnVsbA0KPiBAQCAtMSwxNCArMCwwIEBADQo+IC1CdWlsZCB0aGUgT1AtVEVFIGJpbmFy
eSAob3B0aW9uYWwpDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0N
Cj4gLS4uIGNvZGUtYmxvY2s6OiBiYXNoDQo+IC0NCj4gLcKgwqAgJCBnaXQgY2xvbmUgaHR0cHM6
Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy5naXQNCj4gLcKgwqAgJCBjZCBvcHRlZV9vcw0K
PiAtwqDCoCAkIG1ha2UgQ0ZHX1RFRV9CRU5DSE1BUks9biBcDQo+IC3CoMKgwqDCoCBDUk9TU19D
T01QSUxFPWFhcmNoNjQtbGludXgtZ251LSBcDQo+IC3CoMKgwqDCoCBPPW91dC9hcm0gXA0KPiAt
wqDCoMKgwqAgUExBVEZPUk09aW14LW14OG1tZXZrIFwNCj4gLcKgwqDCoMKgIENGR19UWkRSQU1f
U1RBUlQ9MHg1NjAwMDAwMCBcDQo+IC3CoMKgwqDCoCBDRkdfRERSX1NJWkU9MHg4MDAwMDAwMCBc
DQo+IC3CoMKgwqDCoCBDRkdfVUFSVF9CQVNFPVVBUlQzX0JBU0UNCj4gZGlmZiAtLWdpdCBhL2Rv
Yy9ib2FyZC9waHl0ZWMvaW14OG1tLXBoeWdhdGUtdGF1cmktbC5yc3QNCj4gYi9kb2MvYm9hcmQv
cGh5dGVjL2lteDhtbS1waHlnYXRlLXRhdXJpLWwucnN0DQo+IGluZGV4DQo+IDBkOWUxMDI0Zjhj
NTMwMGU5MWEzYTRjMThiMmJhYmQ1ODUzYTA4MjQuLjdlZmM5MzkyMzYxYjRhODY3Y2UyYmMxOGRi
MQ0KPiAxYWFjZjMxMjA4ODAwIDEwMDY0NA0KPiAtLS0gYS9kb2MvYm9hcmQvcGh5dGVjL2lteDht
bS1waHlnYXRlLXRhdXJpLWwucnN0DQo+ICsrKyBiL2RvYy9ib2FyZC9waHl0ZWMvaW14OG1tLXBo
eWdhdGUtdGF1cmktbC5yc3QNCj4gQEAgLTksNyArOSw3IEBAIFF1aWNrIFN0YXJ0DQo+IMKgLS0t
LS0tLS0tLS0NCj4gwqANCj4gwqAtIEJ1aWxkIHRoZSBBUk0gVHJ1c3RlZCBmaXJtd2FyZSBiaW5h
cnkNCj4gLS0gQnVpbGQgdGhlIE9QLVRFRSBiaW5hcnkgKG9wdGlvbmFsKQ0KPiArLSBCdWlsZCB0
aGUgT1AtVEVFIGJpbmFyeQ0KPiDCoC0gR2V0IGRkciBmaXJtd2FyZQ0KPiDCoC0gQnVpbGQgVS1C
b290DQo+IMKgLSBCb290DQo+IEBAIC0yMywxMiArMjMsMTkgQEAgQnVpbGQgdGhlIEFSTSBUcnVz
dGVkIGZpcm13YXJlIGJpbmFyeQ0KPiDCoMKgwqAgJCBjZCB0cnVzdGVkLWZpcm13YXJlLWENCj4g
wqDCoMKgICQgZXhwb3J0IENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUtDQo+IMKgwqDC
oCAkIGV4cG9ydCBJTVhfQk9PVF9VQVJUX0JBU0U9MHgzMDg4MDAwMA0KPiAtwqDCoCAkICMgd2l0
aCBvcHRlZQ0KPiAtwqDCoCAkIG1ha2UgUExBVD1pbXg4bW0gQkwzMl9CQVNFPTB4NTYwMDAwMDAg
U1BEPW9wdGVlZCBibDMxDQo+IC3CoMKgICQgIyB3aXRob3V0IG9wdGVlDQo+IC3CoMKgICQgbWFr
ZSBQTEFUPWlteDhtbSBibDMxDQo+ICvCoMKgICQgbWFrZSBQTEFUPWlteDhtbSBCTDMyX0JBU0U9
MHhiZTAwMDAwMCBTUEQ9b3B0ZWVkIGJsMzENCj4gwqANCj4gLS4uIGluY2x1ZGU6OiBpbXg4bW0t
b3B0ZWUtYnVpbGQucnN0aQ0KPiArQnVpbGQgdGhlIE9QLVRFRSBiaW5hcnkNCj4gKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gKy4uIGNvZGUtYmxvY2s6OiBiYXNoDQo+ICsNCj4gK8Kg
wqAgJCBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy5naXQNCj4g
K8KgwqAgJCBjZCBvcHRlZV9vcw0KPiArwqDCoCAkIG1ha2UgQ0ZHX1RFRV9CRU5DSE1BUks9biBc
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgQ1JPU1NfQ09NUElMRT1hYXJjaDY0LWxpbnV4LWdudS0g
XA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIE89b3V0L2FybSBcDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqAgUExBVEZPUk09aW14LW14OG1tX3BoeWdhdGVfdGF1cmlfbA0KPiDCoA0KPiDCoEdldCB0aGUg
ZGRyIGZpcm13YXJlDQo+IMKgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gZGlmZiAtLWdpdCBhL2Rv
Yy9ib2FyZC9waHl0ZWMvcGh5Y29yZS1pbXg4bW0ucnN0DQo+IGIvZG9jL2JvYXJkL3BoeXRlYy9w
aHljb3JlLWlteDhtbS5yc3QNCj4gaW5kZXgNCj4gMDhmNTk0OWUwMmQ4ZDJiZmJhNzE4NjdkOTNj
MmIzZWQ4ZmRjNjdlMi4uYmE2Mjk5YTk2OGFlOTk4MGQ1ODNiODdiNDZkDQo+IGNjY2JhNWFhNGEx
ODYgMTAwNjQ0DQo+IC0tLSBhL2RvYy9ib2FyZC9waHl0ZWMvcGh5Y29yZS1pbXg4bW0ucnN0DQo+
ICsrKyBiL2RvYy9ib2FyZC9waHl0ZWMvcGh5Y29yZS1pbXg4bW0ucnN0DQo+IEBAIC05LDcgKzks
NyBAQCBRdWljayBTdGFydA0KPiDCoC0tLS0tLS0tLS0tDQo+IMKgDQo+IMKgLSBCdWlsZCB0aGUg
QVJNIFRydXN0ZWQgZmlybXdhcmUgYmluYXJ5DQo+IC0tIEJ1aWxkIHRoZSBPUC1URUUgYmluYXJ5
IChvcHRpb25hbCkNCj4gKy0gQnVpbGQgdGhlIE9QLVRFRSBiaW5hcnkNCj4gwqAtIEdldCBkZHIg
ZmlybXdhcmUNCj4gwqAtIEJ1aWxkIFUtQm9vdA0KPiDCoC0gQm9vdA0KPiBAQCAtMjMsMTIgKzIz
LDE5IEBAIEJ1aWxkIHRoZSBBUk0gVHJ1c3RlZCBmaXJtd2FyZSBiaW5hcnkNCj4gwqDCoMKgICQg
Y2QgdHJ1c3RlZC1maXJtd2FyZS1hDQo+IMKgwqDCoCAkIGV4cG9ydCBDUk9TU19DT01QSUxFPWFh
cmNoNjQtbGludXgtZ251LQ0KPiDCoMKgwqAgJCBleHBvcnQgSU1YX0JPT1RfVUFSVF9CQVNFPTB4
MzA4ODAwMDANCj4gLcKgwqAgJCAjIHdpdGggb3B0ZWUNCj4gLcKgwqAgJCBtYWtlIFBMQVQ9aW14
OG1tIEJMMzJfQkFTRT0weDU2MDAwMDAwIFNQRD1vcHRlZWQgYmwzMQ0KPiAtwqDCoCAkICMgd2l0
aG91dCBvcHRlZQ0KPiAtwqDCoCAkIG1ha2UgUExBVD1pbXg4bW0gYmwzMQ0KPiArwqDCoCAkIG1h
a2UgUExBVD1pbXg4bW0gQkwzMl9CQVNFPTB4N2UwMDAwMDAgU1BEPW9wdGVlZCBibDMxDQo+IMKg
DQo+IC0uLiBpbmNsdWRlOjogaW14OG1tLW9wdGVlLWJ1aWxkLnJzdGkNCj4gK0J1aWxkIHRoZSBP
UC1URUUgYmluYXJ5DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICsuLiBjb2Rl
LWJsb2NrOjogYmFzaA0KPiArDQo+ICvCoMKgICQgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNv
bS9PUC1URUUvb3B0ZWVfb3MuZ2l0DQo+ICvCoMKgICQgY2Qgb3B0ZWVfb3MNCj4gK8KgwqAgJCBt
YWtlIENGR19URUVfQkVOQ0hNQVJLPW4gXA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIENST1NTX0NP
TVBJTEU9YWFyY2g2NC1saW51eC1nbnUtIFwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBPPW91dC9h
cm0gXA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIFBMQVRGT1JNPWlteC1teDhtbV9waHlib2FyZF9w
b2xpcw0KPiDCoA0KPiDCoEdldCB0aGUgZGRyIGZpcm13YXJlDQo+IMKgLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gZGlmZiAtLWdpdCBhL2RvYy9ib2FyZC9waHl0ZWMvcGh5Y29yZS1pbXg4bXAucnN0
DQo+IGIvZG9jL2JvYXJkL3BoeXRlYy9waHljb3JlLWlteDhtcC5yc3QNCj4gaW5kZXgNCj4gNTBi
ZTk5MTI2NTM3YTJkYzUzMjNiZDQ5YzE1MTNiMTk2MTgyYzVmMy4uZTEzODViZTI1ZTFhODYyZGI3
MDIxZTI5Y2Q1DQo+IGQwZDNiYTY4Y2MwMWIgMTAwNjQ0DQo+IC0tLSBhL2RvYy9ib2FyZC9waHl0
ZWMvcGh5Y29yZS1pbXg4bXAucnN0DQo+ICsrKyBiL2RvYy9ib2FyZC9waHl0ZWMvcGh5Y29yZS1p
bXg4bXAucnN0DQo+IEBAIC05LDcgKzksNyBAQCBRdWljayBTdGFydA0KPiDCoC0tLS0tLS0tLS0t
DQo+IMKgDQo+IMKgLSBCdWlsZCB0aGUgQVJNIFRydXN0ZWQgZmlybXdhcmUgYmluYXJ5DQo+IC0t
IEJ1aWxkIHRoZSBPUC1URUUgYmluYXJ5IChvcHRpb25hbCkNCj4gKy0gQnVpbGQgdGhlIE9QLVRF
RSBiaW5hcnkNCj4gwqAtIEdldCBkZHIgZmlybXdhcmUNCj4gwqAtIEJ1aWxkIFUtQm9vdA0KPiDC
oC0gQm9vdA0KPiBAQCAtMjMsMTMgKzIzLDEwIEBAIEJ1aWxkIHRoZSBBUk0gVHJ1c3RlZCBmaXJt
d2FyZSBiaW5hcnkNCj4gwqDCoMKgICQgY2QgdHJ1c3RlZC1maXJtd2FyZS1hDQo+IMKgwqDCoCAk
IGV4cG9ydCBDUk9TU19DT01QSUxFPWFhcmNoNjQtbGludXgtZ251LQ0KPiDCoMKgwqAgJCBleHBv
cnQgSU1YX0JPT1RfVUFSVF9CQVNFPTB4MzA4NjAwMDANCj4gLcKgwqAgJCAjIHdpdGggb3B0ZWUN
Cj4gLcKgwqAgJCBtYWtlIFBMQVQ9aW14OG1wIFNQRD1vcHRlZWQgYmwzMQ0KPiAtwqDCoCAkICMg
d2l0aG91dCBvcHRlZQ0KPiAtwqDCoCAkIG1ha2UgUExBVD1pbXg4bXAgYmwzMQ0KPiArwqDCoCAk
IG1ha2UgUExBVD1pbXg4bXAgQkwzMl9CQVNFPTB4N2UwMDAwMDAgU1BEPW9wdGVlZCBibDMxDQo+
IMKgDQo+IC1CdWlsZCB0aGUgT1AtVEVFIGJpbmFyeSAob3B0aW9uYWwpDQo+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICtCdWlsZCB0aGUgT1AtVEVFIGJpbmFyeQ0KPiAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gwqANCj4gwqAuLiBjb2RlLWJsb2NrOjogYmFzaA0K
PiDCoA0KPiBAQCAtMzksNyArMzYsNyBAQCBCdWlsZCB0aGUgT1AtVEVFIGJpbmFyeSAob3B0aW9u
YWwpDQo+IMKgwqDCoMKgwqAgQ1JPU1NfQ09NUElMRT1hYXJjaDY0LWxpbnV4LWdudS0gXA0KPiDC
oMKgwqDCoMKgIE89b3V0L2FybSBcDQo+IMKgwqDCoMKgwqAgUExBVEZPUk09aW14LW14OG1wX3Bo
eWJvYXJkX3BvbGx1eCBcDQo+IC3CoMKgwqDCoCBDRkdfVFpEUkFNX1NUQVJUPTB4NTYwMDAwMDAN
Cj4gK8KgwqDCoMKgIENGR19UWkRSQU1fU1RBUlQ9MHg3ZTAwMDAwMA0KPiDCoA0KPiDCoEdldCB0
aGUgZGRyIGZpcm13YXJlDQo+IMKgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQoNCi0tIA0KUEhZ
VEVDIE1lc3N0ZWNobmlrIEdtYkggfCBCYXJjZWxvbmEtQWxsZWUgMSB8IDU1MTI5IE1haW56LCBH
ZXJtYW55DQoNCkdlc2Now6RmdHNmw7xocmVyOiBEaXBsLi1JbmcuIE1pY2hhZWwgTWl0ZXpraSwg
RGlwbC4tSW5nLiBCb2RvIEh1YmVyLA0KRGlwbC4tSW5nLiAoRkgpIE1hcmt1cyBMaWNrZXMgfCBI
YW5kZWxzcmVnaXN0ZXIgTWFpbnogSFJCIDQ2NTYgfA0KRmluYW56YW10IE1haW56IHwgU3QuTnIu
IDI2LzY2NS8wMDYwOCwgREUgMTQ5MDU5ODU1DQo=
