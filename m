Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1071D5E145
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 09:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658758901D;
	Fri,  8 Nov 2024 10:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="zrthEg7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A017C8902D; Fri,  8 Nov 2024 10:04:37 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9953C8900E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 10:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSVRPIjHVwN8OksETwyBpQ6ujnhFU466Vy+3lJ4ORjLkHCqPj/agp0KIiL+a3nmrTIrPFSOfeJRn0n2hp6RvMTW6bAJzCZ6Kx/xyB+B3ERwHJ/2E30ociP3IjB7/kHysfslcpY5rA/ypnAID8XYvHmkjvNbPGOTirE8xAXrMvAJFg/LabQ5LdHaZtocDsLMePyDolf7MlaW1e9UDHZ2WsnClCpjKHa3q5DM3xIggl9ksUhNglHEZ7oK//e5E4wdMJxJwDrdVnuhfkKznSUtwts4fbp09Q6Y7DDVBbzDd+aGclUGkmSnF9y/6/mNfM3Jmc0FWt7088guBva51YGDFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUrRsXDCQtFNC/tySrOfEg9YpQt3IbZXFVGC5830aGU=;
 b=bCCLXJbApbKd3JU26/t/GNN1yBggdVWMLOVus2SKYZsqLrhglP8Lh3sXVp4CjJ3jwONMnhkVUdOrNxribD6z0yaoV1cmR5JkuwpEYoskCUKM8I5GTLsQejJBVA04P8K79rs2GJ3q3oteg5JLxtiRUQhF4tTQYFfR8lY++wQgKiyqIZmuYaf+sjmlNb+dYG/XzOCSh9wFo5wWgEAUsvpAP1pL/CQJZM8xwXeofAe5XA90jGC7b9OMrtAqLLOvuBaCFVVQitjHSaN0WVx+Fr0pjPKr23qqPSEvNLcvAofRMbfnqWaEMucT/CAqeYCyec5Bzic2dBvKuWbULAaU+SwydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUrRsXDCQtFNC/tySrOfEg9YpQt3IbZXFVGC5830aGU=;
 b=zrthEg7pDQ8hLh4gz3hDGRtIh99GcLX4nkSLTYmpVS8KB5wW1y96ULUNSLTrZpBHu7L6zuMdRl7NT6ZVsS7BNqFkOU5ut3g8SI2ip6Td4Ee4oQn+HsIPLFjlCaCtjlK9DZZWTFuFUXvC6zs/qYbyL66TOjn4Bv4GD29Um8D0kgfv6fKPMNB+g09fzTl3OXJJAwNQ81qVl1mvClw8Kbj7C17tKG7QeKm+akD4rXzv1/mwuqXf460lxyi3cCQ/gQpyYstVfCzHJ+4eavTN4JgnggSH3EEwVGX/An/hN5mFlQYb6u/J9H6OjmTeha6bybCYhrsV7AfrE1piEBmCMXjlWQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GVXPR10MB8828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10; Fri, 8 Nov
 2024 09:04:31 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8114.015; Fri, 8 Nov 2024
 09:04:31 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "kever.yang@rock-chips.com"
 <kever.yang@rock-chips.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "patrice.chotard@foss.st.com"
 <patrice.chotard@foss.st.com>, "ion@agorria.com" <ion@agorria.com>,
 "clamor95@gmail.com" <clamor95@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] console: Use printascii for lowlevel debug string
Thread-Topic: [PATCH] console: Use printascii for lowlevel debug string
Thread-Index: AQHbMblUxzPSe4bbpkmcGtPXSLIYrLKtFv0A
Date: Fri, 8 Nov 2024 09:04:31 +0000
Message-ID: <395b0a3f963eb31b5c592e2bef09b6fa9df5524a.camel@siemens.com>
References: <20241108163612.1.Ib408a6723ba954c932968419678bd45b0767a470@changeid>
In-Reply-To: <20241108163612.1.Ib408a6723ba954c932968419678bd45b0767a470@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GVXPR10MB8828:EE_
x-ms-office365-filtering-correlation-id: 4160db0b-3e0f-4481-300c-08dcffd45bbf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aTYzWEZlU2dNK2E1b0s5YkloLzY4b3NacWE2S0dhWFFpSUZYL3FqeFpZaGMy?=
 =?utf-8?B?MWlMdDB4dHNUNEtOMHp5elFsbEYva2c3N25kSEh4dzQwMDM0QmRiWC9iaHdK?=
 =?utf-8?B?TXgyK29paGhramhWeEp5TjNreWJkOWVUZmgzVlF1TEFublNYaFhJdVRQaDNm?=
 =?utf-8?B?OGRlc2VrUGd3a0ZvdGpqbG5CeDJTSHN6cmhNUzVmT01EYjFWVENFVS8vZERz?=
 =?utf-8?B?V3J6R2lSc1F1bHppSitvNDNEaTE2SlZaM0gyT1pnMzY1Rjh6bXdqUm9SbWQ3?=
 =?utf-8?B?WUxER0hDWWt4SFBtM3RKZTQ1ay9xMkhDdTlBNU1CQzdsVkpWZXBleVJIdEFD?=
 =?utf-8?B?SFJNRWtyYXJjZ0lmd2lQWC91cmlNNjhTOFZjTzJPZlBOVmVZNy8zZkZqb1pt?=
 =?utf-8?B?UXhGUFBGaEFsZ3RWcWpiZFhCVkdDT0lJeG11RlhHZlRMOUZVR2lEVTltSkdG?=
 =?utf-8?B?bXN0SDRnUXZUcWFxUHU3cVdHM1JVOUIwS3BCbU93Mi91c2lPTkVibVFDOWJj?=
 =?utf-8?B?bFFGa2JoMHQ2endIUE9BNVA0UjB5R2YxVlptUFRxUVdROXR3bGNqRUNwTUhR?=
 =?utf-8?B?TUVCTndabXQwb0swazNBbTdYYkdpVDJ1U1RLM1dzbnRYQzdiNUNjanZyUmdS?=
 =?utf-8?B?YS9HZDNMb2FFVFB4dkZRQkt5VVZDc2kyN1ZjYnp5R0Y5KzBVUG5UdXVmSGFl?=
 =?utf-8?B?Y0t0VElZci96YmRtbkpJTklpaXcrMGpaSVVVNlgvcVNUOFlDbnNSL29BcjNI?=
 =?utf-8?B?b2F6YmZyMVk3eXlaSFJFeUVqd3RYWTRaM2dRajVuN2J3RStGcDBsZGtteDlH?=
 =?utf-8?B?QVovblRSWFdLMEhVT2hXSjlGYkVxdncxdkEyYWFZZFd3QkhXMGRPQXdYZFZO?=
 =?utf-8?B?d3pNSG5XMndCYVIrWFBqQkc1TzRpa2ZMTzJHTmNZSDlYNHV4L042YmU4TmR2?=
 =?utf-8?B?UWZDNzNzMXJUKzBHeEFSd0hJOVkxWVdGZnVuYzZ2dHhuWXlSRXoyUnhDUUpG?=
 =?utf-8?B?MXFCdlhOQWVZRCtRT3M5M1hQcFJjbzIyZ3dIMUVkTGpoS293Z1BlSGR0cUta?=
 =?utf-8?B?a0ptTHlSSWVyaGdqV1V5MHZjWmVuZFNjM1dBaHRXNGpvakEwSXh6REFYVGJX?=
 =?utf-8?B?Nm10dlVralZPWHIvK3hiUW5XQkg5cklQUVI1bU9hbHZsZnFmSWw3R0Z4aHJu?=
 =?utf-8?B?b2xCanVvcFV5L0VlRW5ndGE3ZEVpYll2N3FmbkZ5RlA3K3pZbW5CN3dxUEp6?=
 =?utf-8?B?aWo3VXFRWm9IUHNsbEErMXYycHJQOHJ2N3RObXVQVTBrWUR6WVpwSXJsdmUw?=
 =?utf-8?B?MXpISzRvWUFGQmlpVmZBNUY1ZnNCNlE2eXFheWUxTVNxN1g5aFYzejFnMlBX?=
 =?utf-8?B?N1dPdDVYR3FHUWVWTjZGbmpsQzhzQ2pIVmQrVngyeUlQaElDMkVSa0VJT3ll?=
 =?utf-8?B?UC9JdXM1M2hRbEJYUHZqL3lFSnhLSHZSQWlSQjJ1U2JHWWlGcFFIVU54N1BM?=
 =?utf-8?B?cVQ1WklZK0FWd3g4OUJuR1pjYzl2OHNFNkJUaEhPYXhLdG5ZUCtyMmdUT0I3?=
 =?utf-8?B?VHlRb1lpMm8yNVNLSUpwSFc4dmtrYW5hR0Nyd2x4Qk9oakQ1bGRkSnhHemhD?=
 =?utf-8?B?WDE5L2t3OE9ycXZMSURBenVKMFk2RERLcjJ0bzlCRk9zZktNYXdhVVA2NXd1?=
 =?utf-8?B?SW1IajdrdTdBeENpcitnWWU4M0hpNm1qcFp2R29hQ2RrTDMrS25kOThra0la?=
 =?utf-8?Q?+E8/JhpOCXd7Z9w2t7xF5bVhuf+9Xm3NaDIzds7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDcrT253MStpdU5sTm52U0hLQlFxdzhtR08rTXNkRERmQjRUZk9XQVpxUWs5?=
 =?utf-8?B?QTJ3OTBLeTEzWDhOV3VDNWVaNUpLaGZ5VjU4ZkNpRXNhK1R2M2VqUmljZ2Zj?=
 =?utf-8?B?eW1mZktKcE5DZDFZYnhqVEZ6V1M3VUFBZi9sUnVUd2hEc3Qwd2RGZ2NsdXVH?=
 =?utf-8?B?aXIwblkvdDZDM0k2WHE0YXFsYWFSZWdQT2FjUmt4d2gyZTQ2c0dXcmRrWUZs?=
 =?utf-8?B?TlhnaTVpYmhRQlJ0dFVORkM5SzNaTnVlSWYzMGRHalc3WFRCWHVVcE5KU1Zk?=
 =?utf-8?B?UjNGT01OT09DTi9yZTJKcCtqWDVFK00wM2R0L3A2UE5qcXcxZnRDVzVoNXNG?=
 =?utf-8?B?TmNidGxwMUlYRTNSV0hKbkVHUEVRZXZsWmdWVS9TcFVieVhFWVFxTXdkNTFi?=
 =?utf-8?B?U3poTmt1Q29FRDhiQXRpVDFWNFRJWGFwOUZtanN3WWwySGxwSmxCdTUvSnFF?=
 =?utf-8?B?d2JYbTJkZW9RamxlMm9abU5nMGxrYU15aGRObFpwVFZjY3AzdHpabHc1bFhR?=
 =?utf-8?B?VWY0ejVPTCtEaVBWMElOUjRDVlN1eENla2FsUkE3RzYya1VrOXBjVStreUx6?=
 =?utf-8?B?Zlk4OXdiUnpnUlc3NGEzTittSTdSUXIyYzcyTHBPMzJmUU1zNWdwd2F6MTJ0?=
 =?utf-8?B?UHpvMkxpTUcyT3JNTVdJRXdITEhxL2wxZnF4SVc5bEFQcnk2dVdWZ3JBLzZL?=
 =?utf-8?B?ZG9mLzFHV2VZdXhMNWNrbzg5ajZIMTlPSWgwZ1VjWDkxYks0T2VtNnhnM2Np?=
 =?utf-8?B?azV0U3UvQ21sUlB3OVFpbHVvRlNvQWRTUXRXZnNhZmNIcTNsdWZ5dkhrYXMy?=
 =?utf-8?B?S0dINTZKS3U4WlBuS0tKQks3MEhCcWdBV0JaczZCZjYwcEt6cHY3d3lyNEZH?=
 =?utf-8?B?Z2ZTQ0xPay80a0xTM0RRekdkUDdPMlYzQXIrY095TURXQkRXTXRnZ2h5YXlB?=
 =?utf-8?B?QTBDR0tET0tNNTVOV05GMWJ4WEd0VlZtUGY0a0Q0Y1VIWFVBZzg1MDc1Z2Rj?=
 =?utf-8?B?UjA2dVkxL1JMZ0V2blducCt5VWxDTE5TRy9Oakhyc0RVMGRnMzE3elk1L2U0?=
 =?utf-8?B?Qkh6aEQ4TVlWWlJkS21KaHVYOHUvc0piQVVxOU80NlF2YzlSV2Vrc2NMb2pa?=
 =?utf-8?B?cDVvRVMyZDEvZlZTZlBIbVYzTFYzbTdVeEdBanFRZ3daYTRMbi8xTi9CdlJH?=
 =?utf-8?B?bmR3bXBHY2lDTXBRWFdsMWRJZHFXRDhiUFk4SlVZTW5zYThoRTFMOWQxMUdW?=
 =?utf-8?B?S0M1S0xaMkZoc0Q3VW43UGJsWklkRS9pZFVTK2Jrd1FDZ2dsc3BnV0RGUTht?=
 =?utf-8?B?ZGJ4akk3YW1pV1pmRW1NSUhDSEg5aUpiclo3dHk2WldEUmlrdSt4TlNKckRv?=
 =?utf-8?B?Mnc1c0xXVkhDZEt4dTJsWGNJZzYxV08zekEvSlNvNitpQ2NLVzdqK1J2ZnVW?=
 =?utf-8?B?NnVpbmhzTGxkNDZWaHBudzF1UVBpdGkrT0JxNjBVRkpOZWZ5QkVia21vMEZQ?=
 =?utf-8?B?N1o4ampsOWR2UnNEWC9GMU9iSTZibTNZVG5JVnhoMHJJQVZqZUVRYXpueFBJ?=
 =?utf-8?B?SHl3ZlhkMXVQVXJOSU1hTDN6Q1VHOW4rTWsyZzhSaXNTN2h6M3ZtUXJ4aURY?=
 =?utf-8?B?NjJSSldLMll5Wm0waGh0ZzI4U25lVmo1dG9vWUE3OG9WbWVobHhEem9MMXZU?=
 =?utf-8?B?MG5zNlBLTVB0a3Nramg4QWNzYkFmajN1bkpsMVhkdE1rbitDZ3JsOEh5Q2to?=
 =?utf-8?B?TFNPN0NaSXNDUyt0Q01OV3Fhdjdxekw0bHRiVlQvWmNMZ3plWStxRi8rWlpi?=
 =?utf-8?B?ZlJEdVlnbnllcTV2c3pNbEY2c1dSeTJ1OEh0SHBsbS9sclRMYnRBVFBSMDZs?=
 =?utf-8?B?ZS9HcVFxdzFuT29uUmN0eXljWWxkbXArUkpsc2MzQ2N2eCs5K3RUcEpGbFNH?=
 =?utf-8?B?dXhCQUF4ZTFhOEhqbE9Gbk51Y3htY1Z6ZGlSTVlnbDZ3Nktjc2ZRSVYrUloz?=
 =?utf-8?B?MUZEaHhmNmJKN0pycVNpajJoVTRVQ0RmaThKZW9neE9haGxVSFB6TjEzeWNu?=
 =?utf-8?B?TEdPUE9PQjdrUFM3NlNhbGFBOWZVRzEyZ1lZVnFSWE9qOURhVFA0bkMraHZ5?=
 =?utf-8?B?UkhTZ0VTdXRxN1JkVkVBWUJubTVTSzdIVHZQU2RYbWJ1dm94clpTOGl4aXpi?=
 =?utf-8?Q?jKk1NDsKYLfthv8zuEXiLFI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24BF491667497A41B03A65EF0F3C1852@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160db0b-3e0f-4481-300c-08dcffd45bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 09:04:31.6895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJU9tBtbTVWMjhcyWVyc/08Rd3kCHO0cVG2xKJuwv8rO70Rdi9GAuwpSh5HEj2qbmImnO+aW/twGG/jA+ZAb4NAxPb0cPmJ65Fqia4ituVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8828
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

SGkgS2V2ZXIsDQoNCk9uIEZyaSwgMjAyNC0xMS0wOCBhdCAxNjozNiArMDgwMCwgS2V2ZXIgWWFu
ZyB3cm90ZToNCj4gVGhlIGxvd2xldmVsIGRlYnVnIHdpdGggQ09ORklHX0RFQlVHX1VBUlQgaGFz
IHByaW50YXNjaWkgZm9yIHN0cmluZw0KPiBwcmludCwgYW5kIG5vIG5lZWQgdG8gY29udmVydCB0
byB1c2UgcHJpbnRjaCBub3cuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZXZlciBZYW5nIDxrZXZl
ci55YW5nQHJvY2stY2hpcHMuY29tPg0KDQpMR1RNLA0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBT
dmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiANCj4g
wqBjb21tb24vY29uc29sZS5jIHwgNiArLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29tbW9uL2NvbnNv
bGUuYyBiL2NvbW1vbi9jb25zb2xlLmMNCj4gaW5kZXggMjIyMjQ3MDFlNDUuLjg2M2FjNmFhOWRj
IDEwMDY0NA0KPiAtLS0gYS9jb21tb24vY29uc29sZS5jDQo+ICsrKyBiL2NvbW1vbi9jb25zb2xl
LmMNCj4gQEAgLTc0NSwxMSArNzQ1LDcgQEAgdm9pZCBwdXRzKGNvbnN0IGNoYXIgKnMpDQo+IMKg
CX0NCj4gwqANCj4gwqAJaWYgKElTX0VOQUJMRUQoQ09ORklHX0RFQlVHX1VBUlQpICYmICEoZ2Qt
PmZsYWdzICYgR0RfRkxHX1NFUklBTF9SRUFEWSkpIHsNCj4gLQkJd2hpbGUgKCpzKSB7DQo+IC0J
CQlpbnQgY2ggPSAqcysrOw0KPiAtDQo+IC0JCQlwcmludGNoKGNoKTsNCj4gLQkJfQ0KPiArCQlw
cmludGFzY2lpKHMpOw0KPiDCoAkJcmV0dXJuOw0KPiDCoAl9DQoNCi0tIA0KQWxleGFuZGVyIFN2
ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
