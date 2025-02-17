Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC54C021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 07:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E4980F18;
	Mon, 17 Feb 2025 08:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="gZmhO36g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF90A80F53; Mon, 17 Feb 2025 08:21:11 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::711])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934AD80C7E
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 08:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/JTdG5ULLQQg/SXlRfSZPDFed1p2LlzwYACnWIx3APKn9vY4oURQc+t5vhwD2oRqQdS6hkRx+GufQjR9/wUWJuKbzZt97wHk9SWqv31mfzidLcOmvnus8zSeIOoRX4jhacgtEZq4Q+NOcQood1OXSTv37u1OhWYQ3mPiPgrnwh1CN3ZUo3azt/XTTiluQBH9ghETv7iCBzQyxT3E7y2JkisSre+lgv3lHk6zYz8giIS8fi9ryTM0ZkIn9rmTJ2NI1XgstwvC4x9QAgSCTLRUYYdJxZUd55iZ2cgi+WQOZ5SgLQptlz/jjkMZqtVe2yzAPT/JfFDBti1BTzn1YVmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r34IGjehWl5OXhYbCfQOJWrEYjq8db6lgX9ZMDlcN7A=;
 b=wrdm8yeuC+hRunEEtrYvTpXKsivIsv/qNd3fbwUXkvF1qhqrcQu33+3+7SA+NMn+e80P1hxN0uXNIn05gr7UmGYCgvi4cnJI3Il045lOSHAhaxb6AD794L7hoJP/QazCJIIWjP+v44l2Vdc0doctA/j1hVMjsnyD7Ypg4ifbyAurec2ty4iJuYEBVbQ5Wh1f64LdAJEqIFgzB10bBOFJ67zPkgfHEtX+DF0wHR0tCG5B2QKn/tzROeB8f2PsMe4K+C+fqJa7S2qeTEApsfKrHqUohoAOu0LgaG6lNQXrvuVeVwi4YQa/0n78yq/MgCRIUkwvSPpKzRdplmyzgkCfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r34IGjehWl5OXhYbCfQOJWrEYjq8db6lgX9ZMDlcN7A=;
 b=gZmhO36gbQL5vMPsf0djl4bb8thAQKgJ4k0nPOKzrFdRqgT7vjhBn5XRDH2OsOT3rpz+b+QqEnmmYK1FwdB797sAd2kdSU4avgRun9CYeK01Ewni4cU3YvmmPA2Png08tmREivVUq5L1nWdK8O2xSasMH6GzNQkjyrgvSrJv9C4X7GVXV6XrfZipFkNM8hP3eWsOq+7amu8SEThlac5xWfnGmgVjwR6lCeTRvZajnGkXly35rxCbf0g6erSL2BfpN6WDIHac8mi3/RGeERDlMgxz1Dqm9D+babMzwJugUdh6J/StCEqsk1aE1BMmpaRzHNHoQU+Tq60IveUtpBqafQ==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by DU0P195MB1932.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 07:21:07 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 07:21:07 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Topic: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Index: AQHbcjjLfXNkb9lhtEeZVLV5ci3/5bNAlVuAgARWDACAAG+WgIABHk4AgABwngCABEqqgA==
Date: Mon, 17 Feb 2025 07:21:07 +0000
Message-ID: <8efb1beb7dc94f16919b00fa88fc8048eec80905.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
 <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
 <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
 <d3bfaf2fda01b1ace77d3335028bb5adcf536197.camel@phytec.de>
 <CAFLszTjhYPkaQdtxrNNkLnfg=YkJ6f7JRtg=jPjDR2h_DD8Wkg@mail.gmail.com>
In-Reply-To: <CAFLszTjhYPkaQdtxrNNkLnfg=YkJ6f7JRtg=jPjDR2h_DD8Wkg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|DU0P195MB1932:EE_
x-ms-office365-filtering-correlation-id: 93caa40f-d2fa-4919-2a4d-08dd4f23a595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZzFMK0NoM0lwY2x6RitMWUk0UHk5K093ZVowREIzS1RMVm10T0VpZGFUWUlh?=
 =?utf-8?B?SGYxdmZaT1hzd0ZLSkUrb3k3WEtUOVVFUmc2K0h3WXgrTmtJcnFWcmRNa1JI?=
 =?utf-8?B?Nkc2VXFkSGNhYlRiK2FOdHRZNno0WTVQLzdQZENaMjlHRklQMDhRT0xQR2Ji?=
 =?utf-8?B?QmkvNW1zY0hYNXk1cENlLzlPb2k4WWhqeVNHSFMvQ1Yzam5tUWUraW5tVmN5?=
 =?utf-8?B?bDVQMkRXcTV1U3hNRGJZdUlscU14UTlDY2JvdHEzSUtBRm9QVlhabWpzOXd2?=
 =?utf-8?B?M2F3aFU1SzNhdzBWN2Y1MzdVYVV0OU5xd28rd0hocHhJNlpnUXEvL2N0bmxq?=
 =?utf-8?B?eURkdFE3N05BZ0dCK0NBbUM5cHJjL05hME9YOGRkdXR3TmVTQXo3R2hSNDdk?=
 =?utf-8?B?WG5EdVhiQUttOUxScnpWYUpWRlZieWVLeXk5S0ZtVWhnZ0dzbkJhOVI5Y210?=
 =?utf-8?B?bFd4eWdtS01QdWNxUDd2V1FQeHM1Nnd0VGo4UnkzQ2RodDRGTmFEUHhJOVhi?=
 =?utf-8?B?VDM5a09DSWRma0F1Z3c3Q0FVb1NXemlwNDY4ZGkwQ1Nlbml6VkZGRG51UlFV?=
 =?utf-8?B?RWFoTFlMSW9qa0tSeVhFZnlZYnhDRkFINXErTk82bkVqWUNacVVNc2ZIMDVG?=
 =?utf-8?B?aTByWWdwRWNld2VqT3FyRGpOSUxkT09mNGo5MjNXWTFzNFRsa3R4K3Vzdnd0?=
 =?utf-8?B?bHdSVEcxbVBYRmxGdWErQmxwTXJSd1MvSmNrZFE4V0Z3bU9rN1ljU1Iram1q?=
 =?utf-8?B?amE0a1cxMVFHNWgwQ0xBd3FlWXBiUjZpUUd6WEFQM01DMVVOWHZRSWFOakMv?=
 =?utf-8?B?WVFibUxZODVJdTJKakFpYytUMjljckpwQUtaenA0U0h2V1lxNkhLdmZjdXFZ?=
 =?utf-8?B?aDZWMmg1Z2tyN0k1eXZEZGRWaHhUazNuUm1ScFF0OG01Tm04WmcxczNCdHh5?=
 =?utf-8?B?RERCRTZlTThveXpTYml4NlBGR2s3OHZrTm5yaWszZlZ1ZGVlSGk5ZGQ1aDR6?=
 =?utf-8?B?ZHV0S1VTb21DdjFSNnR1dkZTSHExcFNNM21tSWlQUklwQktqYzV3T3ZHNGlZ?=
 =?utf-8?B?R3EwMW1WNmkwNVNKQWRRTGFkMjRjZ3MremtxWGVwQUEyeGFoQ1hLdy9JY2lU?=
 =?utf-8?B?SkR4M2o0Sm9KdVFycDRkcE1rdllRaXRJcEdvQ3lGZC9BdnNiWkZ1b2p5cXN6?=
 =?utf-8?B?VzB0ck10U1NvZjI1VFErNnpSNmZvTjVJWERtbG16dUl1Q2ZveFlUSVRTZnkx?=
 =?utf-8?B?cWJhRzhLaFJCOVl4RXBMdkxISzZaUElpZzlYNkhDYWV3KzhHZ3l3L1cvbkhM?=
 =?utf-8?B?RmRkZHptOHlQQ00vK0g4NkNXZ29KaVQ4bXFyWW9PRExseUdqMlk5TFJaMWE2?=
 =?utf-8?B?bDlFYURTS3dNS1FkUDhFZW1uWmdXaFRyWFBQR1c1WU95QzRwd2U0UkFSN21G?=
 =?utf-8?B?TFFtd1A2akpuMlpueEt3N1Z1NUx3Wkd4Z3dRbThoc2hOTlB3RUdqUUpuNmVx?=
 =?utf-8?B?TFZmdUVvakJ1ZlhwUTFZMGwzNTgvNzNSTVBoa3NmTGZyby9ET3RJbWdsb05L?=
 =?utf-8?B?REg5eFN3T3JwTEk3UXJFVzB1LzJBUWlkTUtub0h4WUJ2ZHN1RkhOa0wzcUNN?=
 =?utf-8?B?aWd1bnBBQUJwVjBZS2VyaXFqdnl0WXdiMGhxVllIcVBHd3VsRC9XNFpvTThq?=
 =?utf-8?B?UGxla0xjRGZ4SWZZVXNzbGk3eUNnOW5hTmY0U2F4dC9oNnhLUHBRVUllV21L?=
 =?utf-8?B?ZmVMRDNJa3NWRkhGNUlvV2xNSjBKRnBxNHNVVGNETnFuRjBNbXNSYkhkQXRu?=
 =?utf-8?B?bmdOOEZMTStjazBPRzJMZXJITHRXRzF6TGFvTkRyZ3I0QXV5d2pMWXF5MGlq?=
 =?utf-8?B?WSthMHR0T1NFRWdEdm1zOWV3L2w3Q3lmZkQ1NlpXL3o3elk2dGxhMklvUEZq?=
 =?utf-8?Q?Dq678WlwDyCMfRYUriAsuJRy7tBpabRA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enpOTnJwYTRWcmplRGJQb1dMQ3ZqdzJJMExkQ2VmU0NncVdKRzdxdU5Rbkpz?=
 =?utf-8?B?SEJwWEhsczZHbFRENmVVa1FGRTZSa0s1WmpuYmFIbWVybUo1bGxkYy9ZeDNW?=
 =?utf-8?B?dmdBNnBwUTBqbmJLTmRQSUhQNUk2d0t3Ujhpd0dLTm5lakViVVVpYmRiNXFt?=
 =?utf-8?B?MUgwb3FKM2xUaTJySC9wZ2VtYmlLdUo5cyt5eVJlbkN3Y1h1RWE2NC9vOFZV?=
 =?utf-8?B?UGVJdW1neXQ0eEFjT1gyU2VaandvZTM3SjZGOStnOW1QWnhLdXo0Z3dJYmhH?=
 =?utf-8?B?cnpNSG1rUVRra2tuUjJ1cFJGQ1RoSEw5ZEk5NjFIWUhHSU1CK0tzRUp1VlNJ?=
 =?utf-8?B?VDBVeUxTWFNGWVdQWXZQVllwUkdTeU5oazUyYnMyM2N0TEptVmJTaTdOVjM5?=
 =?utf-8?B?Y2FwcTlQcU5KWXpUS1NmV1BsNXNCV3JrRE04S2JMS0s1NWhVc3pub0RyV0xi?=
 =?utf-8?B?RVp2cUpnbjg1MVNIYk9tdmUyR2pDdVpHeVZMcGs0QjROZE1DVlRYWVB4aTdW?=
 =?utf-8?B?cW5BTHVCT3g4dUtaK1ZSdzZXUUtCVDJlWHNXdkI3YVhlRUxybDRCU3lvTzlR?=
 =?utf-8?B?OWw4K1hUY2EyYkxTeVJudll5K01yeHM2M3FzMm5UK3dZcXFTdVhPbHRnQ1dJ?=
 =?utf-8?B?TURYdlhvcmFmSE1iN2t3RitWS2R5cXZDZ21zc0YxMzlQWWMyMDhtdnVSaUNB?=
 =?utf-8?B?S2xvblNEY01zeTZCUUs5SlNGVkpvMFY3UTFiTENqdTJ4NmtzMm9hQXRLU2ZW?=
 =?utf-8?B?Y0VQSFVhalJQMnJVMU9pR3JYRkk4NTJNQjdzU29LZ2ZBZWxNYnFEWUkxQjBE?=
 =?utf-8?B?dVhXM0R6Ym9lZXpVZmVjTFkxRUF1UlVPQ01IeUhPd0UySkZQMjhQbjB0LzQ3?=
 =?utf-8?B?ZXVVVHFQZE9OaVdqdTFUSlg4MjEzMkhwTUFCMUpYeUpONm1aM2VnQmlxaXh2?=
 =?utf-8?B?aHNkRFN0a243T2tLYnhzdjdjZFdPWmNnZWFZZkl0UVJKQ3FPSUVRSnhwWnBo?=
 =?utf-8?B?K2lvZjVCbEMwRjVLSE1peTZtYzA4eGcxMS9kRmlaTGVyZlg4Y2x1ZFVnZ2pL?=
 =?utf-8?B?YWd2QTc5MUdmdW04ZHcrcXZVZ1VVdXBvanZxUXBmSGVxNDBQdjVoVFExR3ZV?=
 =?utf-8?B?N1dKUjl0cXFncGJqWTlaTTNocDZrNFZJd2g2Q0xiYkpMYUVrVFZKVzJjQi9a?=
 =?utf-8?B?ZTd4UTVVT0pPVnV2cEVZYWwzU2dZdEpvUU50Ty9VSHhmRlJKZHVQOTl5TUNa?=
 =?utf-8?B?VXFWWGp5WHhzTWZVeWNqZzV1YUhDWkVzQnhyWVlaTEY3Ny9tSE8rVU1sN1o4?=
 =?utf-8?B?cTZieE5NK2ZWM25mZUlacEd0YUJ0eXhjTkVtSGtNVXBIVGw5bk93Y3czcVlE?=
 =?utf-8?B?ZmlEalltbHJHVmxQSWFXN0UyQTQyOUJTM01panZFUXFCUU01Nk5KTXBOM09T?=
 =?utf-8?B?WDI4ZlZmbndzY0JZY1ZDdFJWNGZIQk9IT1FiQWtUQys5NnNDd1pPZEhZZzFR?=
 =?utf-8?B?c2tDc2k3WTh4TmdoUzlXWEkvUzV6aVFsbXI1NDh0ZkhURjRUTzk1Qm1jSWRO?=
 =?utf-8?B?SXU4ZnJIYXNYVHlCLzRieDZNRFlKSU9adEQ1L3dXY3JieUZBZlgvWWpZcGJa?=
 =?utf-8?B?SHdYbnR3OGE5RUZYNi9PcGVtQWp4WVJlRHVZUDdSemxoREZ4ODVlMDJWREZm?=
 =?utf-8?B?dDRmTXhYUEJFQVRhNmo3K1hMS3dBZzQxOGd2VzhHZWhUbkRYcVRzdlNmOFlT?=
 =?utf-8?B?U1ZXY282YW5JWDhrYVhORnRDdDZNM3RYYnhuYUtvSlQ0VW1mQjFoUnRxL1RQ?=
 =?utf-8?B?RXMrYlh5WXo5SU9rVU9zSlVITm1MKzdQMWc2MDBBUEJSSmhROTY4cVR1WWp2?=
 =?utf-8?B?bjlOU0VVbWxxbyt0eXBoM0pDQm9VMlFCV0dnY0padytUUWJ1MmVCaTJrTC9W?=
 =?utf-8?B?OWJvZG5nZnpFMXhYNStnYzVjMFI3TjdQelIvYkhCNDROOGowUTNSVXAxSnpl?=
 =?utf-8?B?WGVXcWJhTUVNOFlEZDBmSHpvekFSQ0xYcWtYaFZKbzZyWXZYUzNLanQrY3Jz?=
 =?utf-8?B?NXM2WVRSWFQ5SElDZi9kTUVZL2hwRXQvVmdxZUlWa3FnbHdGUUpuNEgzbmpV?=
 =?utf-8?Q?CYDRLjkyvNuA9cKWVWvXOC800?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1252A3525926844D93E28BB839F70900@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93caa40f-d2fa-4919-2a4d-08dd4f23a595
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 07:21:07.6446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSGTjYfnFjz83B/OKEkGFUW65LDcg7Yby+ycQCt34L/3FVUo5UNk9VACPrJPxTkTdKmnnNGI838AwQwaPyQ5Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1932
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

SGkgU2ltb24sDQoNCk9uIEZyaSwgMjAyNS0wMi0xNCBhdCAwNjo0OCAtMDcwMCwgU2ltb24gR2xh
c3Mgd3JvdGU6DQo+IEhpIFlhbm5pYywNCj4gDQo+IE9uIEZyaSwgMTQgRmViIDIwMjUgYXQgMDA6
MDUsIFlhbm5pYyBNb29nIDxZLk1vb2dAcGh5dGVjLmRlPiB3cm90ZToNCj4gPiANCj4gPiBPbiBU
aHUsIDIwMjUtMDItMTMgYXQgMDc6MDEgLTA3MDAsIFNpbW9uIEdsYXNzIHdyb3RlOg0KPiA+ID4g
SGkgWWFubmljLA0KPiA+ID4gDQo+ID4gPiBPbiBUaHUsIDEzIEZlYiAyMDI1IGF0IDAwOjIxLCBZ
YW5uaWMgTW9vZyA8WS5Nb29nQHBoeXRlYy5kZT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBP
biBNb24sIDIwMjUtMDItMTAgYXQgMDY6MDggLTA3MDAsIFNpbW9uIEdsYXNzIHdyb3RlOg0KPiA+
ID4gPiA+IE9uIFdlZCwgMjkgSmFuIDIwMjUgYXQgMDM6MzAsIFlhbm5pYyBNb29nIDx5Lm1vb2dA
cGh5dGVjLmRlPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIGJpbm1hbiBk
b2N1bWVudGF0aW9uIG9mIE9wdGlvbmFsIGVudHJpZXMgaXMgbm90IGFjY3VyYXRlIGluIHRoZQ0K
PiA+ID4gPiA+ID4gc2Vuc2UgdGhhdCBpdCBkb2VzIG5vdCBjb3ZlciBibG9icyBlbnRyeSB0eXBl
LiBBcyB0aGlzIGlzIGFsc28gdGhlIG1vc3QNCj4gPiA+ID4gPiA+IHdpZGVseSB1c2VkIHR5cGUg
dG8gaGF2ZSB0aGUgb3B0aW9uYWwgZW50cnksIGRvY3VtZW50IHRoZSBpbnRlcmFjdGlvbg0KPiA+
ID4gPiA+ID4gd2l0aCBmYWtpbmcgYmxvYnMuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KPiA+ID4gPiA+ID4g
LS0tDQo+ID4gPiA+ID4gPiDCoHRvb2xzL2Jpbm1hbi9iaW5tYW4ucnN0IHwgOSArKysrKysrKy0N
Cj4gPiA+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvYmlubWFu
L2Jpbm1hbi5yc3QgYi90b29scy9iaW5tYW4vYmlubWFuLnJzdA0KPiA+ID4gPiA+ID4gaW5kZXgg
OTkwZmMyOTU3NzAuLjJiYWZhNmNhNDA4IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvdG9vbHMv
YmlubWFuL2Jpbm1hbi5yc3QNCj4gPiA+ID4gPiA+ICsrKyBiL3Rvb2xzL2Jpbm1hbi9iaW5tYW4u
cnN0DQo+ID4gPiA+ID4gPiBAQCAtMTE0NSw3ICsxMTQ1LDE0IEBAIGNhbGxlZCBvbiBhbGwgZW50
cmllcy4NCj4gPiA+ID4gPiA+IMKgSXQgaXMgbm90IHBvc3NpYmxlIGZvciBhbiBlbnRyeSB0byBt
YXJrIGl0c2VsZiBhYnNlbnQgYXQgYW55IG90aGVyIHBvaW50IGluIHRoZQ0KPiA+ID4gPiA+ID4g
wqBwcm9jZXNzaW5nLiBJdCBtdXN0IGhhcHBlbiBpbiB0aGUgT2J0YWluQ29udGVudHMoKSBtZXRo
b2QuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC1UaGUgZWZmZWN0IGlzIGFzIGlmIHRoZSBl
bnRyeSBoYWQgbmV2ZXIgYmVlbiBwcmVzZW50IGF0IGFsbCwgc2luY2UgdGhlIGltYWdlDQo+ID4g
PiA+ID4gPiArVGhlIGVmZmVjdCBkZXBlbmRzIG9uIHRoZSB0eXBlIG9mIGVudHJ5Lg0KPiA+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ID4gK0Jsb2JzDQo+ID4gPiA+ID4gPiArfn5+fn4NCj4gPiA+ID4g
PiA+ICtGb3IgYmxvYnMsIHRoZSBlZmZlY3QgZGVwZW5kcyBvbiB3aGV0aGVyIC0tZmFrZS1leHQt
YmxvYnMgaXMgcGFzc2VkDQo+ID4gPiA+ID4gPiArdG8gYmlubWFuLiAoVGhpcyBpcyB0aGUgY2Fz
ZSBieSBkZWZhdWx0KQ0KPiA+ID4gPiA+ID4gK0luIGNhc2UgLS1mYWtlLWV4dC1ibG9icyBpcyBz
ZXQsIGFueSBtaXNzaW5nIGVudHJpZXMgd2lsbCBiZSBmYWtlZC4NCj4gPiA+ID4gPiA+ICtJZiBu
b3Qgc2V0LCBpdCBpcyBhcyBpZiB0aGUgZW50cnkgaGFkIG5ldmVyIGJlZW4gcHJlc2VudCBhdCBh
bGwsIHNpbmNlIHRoZSBpbWFnZQ0KPiA+ID4gPiA+ID4gwqBpcyBwYWNrZWQgd2l0aG91dCBpdCBh
bmQgaXQgZGlzYXBwZWFycyBmcm9tIHRoZSBsaXN0IG9mIGVudHJpZXMuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gSSdtIG5vdCBxdWl0ZSBmb2xsb3dpbmcgdGhpcy4gVGhlIHRleHQgc2VlbXMgT0sg
YnV0IHlvdXIgaGVhZGluZw0KPiA+ID4gPiA+IGltcGxpZXMgdGhhdCB0aGluZ3Mgb3RoZXIgdGhh
biBibG9icyBjYW4gYmUgZmFrZWQuIEFsbCBvZiB0aGlzDQo+ID4gPiA+ID4gZnVuY3Rpb25hbGl0
eSBpcyBvbmx5IGZvciBibG9icy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBoZWFkaW5nIGlzIGEg
c3Vic2VjdGlvbiBvZiAiT3B0aW9uYWwgZW50cmllcyIuIFRvIG15IGtub3dsZWRnZSB0aGUgIm9w
dGlvbmFsIiBwcm9wZXJ0eQ0KPiA+ID4gPiBpcw0KPiA+ID4gPiBub3QNCj4gPiA+ID4gbGltaXRl
ZCB0byBibG9icy4gQnV0IGJsb2JzIGdldCBzcGVjaWFsIHRyZWF0bWVudCBpbiByZWdhcmRzIHRv
ICJvcHRpb25hbCIgZHVlIHRvIHRoZSAtLQ0KPiA+ID4gPiBmYWtlLQ0KPiA+ID4gPiBleHQtDQo+
ID4gPiA+IGJsb2JzIG9wdGlvbi4gSGVuY2UgdGhlIHN1YnNlY3Rpb24uDQo+ID4gPiA+IA0KPiA+
ID4gPiBXaGF0IHdvdWxkIHlvdSBsaWtlIG1lIHRvIGNoYW5nZSB0byBtYWtlIHRoaXMgY2xlYXJl
cj8NCj4gPiA+IA0KPiA+ID4gT2ggSSBzZWUuIEFyZSB5b3Ugc2F5aW5nIHRoYXQgb3B0aW9uYWwg
ZW50cmllcyBlbmQgdXAgaW4gdGhlIGltYWdlDQo+ID4gPiB3aGVuIHRoZXkgYXJlIGZha2VkLCBl
eHRlcm5hbCBibG9icz8gSWYgc28sIHRoYXQgc2VlbXMgbGlrZSBhIGJ1ZyB0bw0KPiA+ID4gbWUu
DQo+ID4gDQo+ID4gVG8gY2xhcmlmeSwgb3B0aW9uYWwgaW1hZ2VzIGFyZSBmYWtlZCBvbmx5IHdo
ZW4gdGhleSBhcmUgbWlzc2luZy4gU28gaW4gY2FzZSB0aGUgaW1hZ2UgaXMNCj4gPiBtaXNzaW5n
LCBhDQo+ID4gZmFrZWQgaW1hZ2UgaXMgaW5kZWVkIHBhY2thZ2VkIGludG8gdGhlIGltYWdlLg0K
PiA+IA0KPiANCj4gT0ssIGJ1dCBJIHN0aWxsIHRoaW5rIGl0IGlzIGEgYnVnLsKgDQoNCkkgZGlk
bid0IHF1ZXN0aW9uIHlvdXIganVkZ2VtZW50LCBJIHNpbXBseSBkb24ndCBoYXZlIHRoZSBicm9h
ZGVyIGdvYWwgb2YgYmlubWFuIGluIG1pbmQgdG8gYmUgYWJsZQ0KdG8ganVkZ2UgaWYgdGhpcyBi
ZWhhdmlvdXIgaXMgdW5pbnRlbmRlZC4NCldoYXQgc2hvdWxkIGhhcHBlbiBpbnN0ZWFkPyBTaG91
bGQgdGhlIGltYWdlIHNpbXBseSBiZSBhYnNlbnQgaW4gdGhlIGZpbmFsIGltYWdlPw0KDQo+IFdo
eSBhZGQgYW4gb3B0aW9uYWwgdGhpbmcgaW4gdGhpcyB3YXk/DQoNCkJlY2F1c2UgaXQgc2VlbXMg
bGlrZSBhIHNpbXBsZSwgZWxlZ2FudCBzb2x1dGlvbi4NClRvIGVsYWJvcmF0ZToNClRoZSBnb2Fs
IChpbiBjYXNlIG9mIE9QLVRFRSkgaXMgdG8gaGF2ZSB0aGUgYmluYXJ5IHBhY2thZ2VkIHdoZW4g
aXRzIHRoZXJlIGFuZCBub3QgcGFja2FnZWQgd2hlbiBpdA0KaXMgbm90IHByZXNlbnQuDQpQcmVj
aXNlbHkgYmVjYXVzZSBpdCBpcyBub3QgcmVxdWlyZWQgZm9yIGEgYm9vdGFibGUgaW1hZ2UsIGJ1
dCBtYXkgYmUgYWRkZWQgdG8gZW5oYW5jZSBmdW5jdGlvbmFsaXR5DQouIEkuZS4gaXQgaXMgb3B0
aW9uYWwuDQpJIGZvdW5kIHRoZSBVLUJvb3QgZG9jIHRvIGV4cGxhaW4gb3B0aW9uYWwgZW50cmll
cyBhbmQgdGhvdWdodCBpdCB0byBiZSBhIHBlcmZlY3QgZml0LiANCldoYXQgZG8geW91IGhhdmUg
aW4gbWluZCB0byBhY2hpZXZlIHRoaXMgZ29hbD8NCg0KWWFubmljDQoNCj4gDQo+IA0KPiA+IEhl
cmUgaXMgdGhlIGltYWdlIG1hcCBmcm9tIGFuIChwaHljb3JlLSlpbXg4bXAgYnVpbGQuDQo+ID4g
DQo+ID4gTWlzc2luZyB0ZWUtb3MgKGZha2VkKToNCj4gPiANCj4gPiBJbWFnZVBvc8KgwqDCoCBP
ZmZzZXTCoMKgwqDCoMKgIFNpemXCoCBOYW1lDQo+ID4gMDAwMDAwMDDCoCAwMDAwMDAwMMKgIDAw
MTU5ZTEwwqAgaW1hZ2UNCj4gPiAwMDAwMDAwMMKgwqAgMDAwMDAwMDDCoCAwMDE1OWUxMMKgIHNl
Y3Rpb24NCj4gPiBbLi4uXQ0KPiA+IDAwMDU4MDAwwqDCoMKgIDAwMDU4MDAwwqAgMDAxMDFlMTDC
oCBmaXQNCj4gPiAwMDA1YjAwMMKgwqDCoMKgIDAwMDAzMDAwwqAgMDAwZTQ5MTDCoCB1Ym9vdA0K
PiA+IDAwMDViMDAwwqDCoMKgwqDCoCAwMDAwMDAwMMKgIDAwMGU0OTEwwqAgYmxvYi1leHQNCj4g
PiAwMDEzZjkxMMKgwqDCoMKgIDAwMGU3OTEwwqAgMDAwMDg0NTjCoCBhdGYNCj4gPiAwMDEzZjkx
MMKgwqDCoMKgwqAgMDAwMDAwMDDCoCAwMDAwODQ1OMKgIGF0Zi1ibG9iDQo+ID4gMDAxNDdkNjjC
oMKgwqDCoCAwMDBlZmQ2OMKgIDAwMDAwMDAwwqAgdGVlDQo+ID4gMDAxNDdkNjjCoMKgwqDCoMKg
IDAwMDAwMDAwwqAgMDAwMDAwMDDCoCB0ZWUtb3MNCj4gPiANCj4gPiB0ZWUtb3MgcHJlc2VudDoN
Cj4gPiANCj4gPiBJbWFnZVBvc8KgwqDCoCBPZmZzZXTCoMKgwqDCoMKgIFNpemXCoCBOYW1lDQo+
ID4gMDAwMDAwMDDCoCAwMDAwMDAwMMKgIDAwMjJiNWIwwqAgaW1hZ2UNCj4gPiAwMDAwMDAwMMKg
wqAgMDAwMDAwMDDCoCAwMDIyYjViMMKgIHNlY3Rpb24NCj4gPiBbLi4uXQ0KPiA+IDAwMDU4MDAw
wqDCoMKgIDAwMDU4MDAwwqAgMDAxZDM1YjDCoCBmaXQNCj4gPiAwMDA1YjAwMMKgwqDCoMKgIDAw
MDAzMDAwwqAgMDAwZTQ5MTDCoCB1Ym9vdA0KPiA+IDAwMDViMDAwwqDCoMKgwqDCoCAwMDAwMDAw
MMKgIDAwMGU0OTEwwqAgYmxvYi1leHQNCj4gPiAwMDEzZjkxMMKgwqDCoMKgIDAwMGU3OTEwwqAg
MDAwMDg0NTjCoCBhdGYNCj4gPiAwMDEzZjkxMMKgwqDCoMKgwqAgMDAwMDAwMDDCoCAwMDAwODQ1
OMKgIGF0Zi1ibG9iDQo+ID4gMDAxNDdkNjjCoMKgwqDCoCAwMDBlZmQ2OMKgIDAwMGQxN2EwwqAg
dGVlDQo+ID4gMDAxNDdkNjjCoMKgwqDCoMKgIDAwMDAwMDAwwqAgMDAwZDE3YTDCoCB0ZWUtb3MN
Cj4gPiANCj4gPiBZYW5uaWMNCj4gPiANCj4gPiANCj4gDQo+IFJlZ2FyZHMsDQo+IFNpbW9uDQoN
Cg==
