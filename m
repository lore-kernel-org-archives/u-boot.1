Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB2EC3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 18:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7906F82132;
	Sun, 13 Apr 2025 20:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="Zfc8lDDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A6382145; Sun, 13 Apr 2025 20:45:27 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E2238082A
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 20:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpqwIZ/tCfQKCYTrq01fm7lU4RfhKMAMn0gOEJy40RW63UAYOnSHZs8clvzL6gGRYbdcAGyZDDOevj+BPDX4jE1XD8CmPr8czQJd95SasOYdvQE1qcf3oZapOPoG7QrgxGzDRnPOORwZHqUr6CUcOOMRiJilRREoP91ye90PIWP/xEmdfMDdo4zP7nsXViFKRlHjm4mXZ5gi84lwcXNkLp4bticHuJMBYcez1qqDnHMqC7Zpm4MN1DEoa/Smkswua9QztaxNKICe4jFwryXzEUep7/eabPHSILCYXf1r6SjFNVrZ2r8ECp2fRlg0QDAcLke0K7SrVvSP4JgVXqKlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xjV1sDxwe++Jn7enGXPT9YaepdTL8J8T+YhchsbWno=;
 b=YDo1Gr+AV1ceZN+ILQYD7SLN/Bdqhglw7xijP98BTN/g6nFVxeq0vH/jW0ycR8i4sv6GQUZBYWXuWIz6JxmcPwzcEmYFqH2sMwTgI+05zH66wZOY+4ZgJwkRxn8mactrqlNQRz/UeE1wcmVj/cGjF55Wqs7DoIhAxIQzSPYr2lZhNvNyDrDiIqDxUJq4OOyn+jB+3DM5lGNoAjkjl6vUSmD/+X/0XIgnIW05qjiejnDckIZKhIBqM4w2/1nDkAegBYbrRERMEwBAQxAaG9vgEd+j+aRvDe3tNFkfZHUi0w9MhN79C/NTNpDScD9Bl9wM8JB3Tj4yFQh4rxDBfaAwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xjV1sDxwe++Jn7enGXPT9YaepdTL8J8T+YhchsbWno=;
 b=Zfc8lDDuXbYb3fT/vaN/0cNXktBwzny6QkW5DQ5P65pS6qtMSddFGLJtv1Aqu5VHyaWDfGM+D8tu/U0UV3r32yTwZbjUWoHMHAgvvdZR8GiyQIKQYgvPAJkGwRtt7bY3s4iUX68Q7NcCqpkTBO++JXtS3HevyM2ICG+BmofKsakULlIkp+kvh9ReMgV7rNJG4I7+Cvddvp5MEGDiB7BITEkPQZF4W28D53PiEoG3MVw9KKlAhAJsX1vjRllMdRE2lDFeUoqF4OmtbD8Q/DLGRT163EZekZdXxTH8Bd9/7iTWETNINhIsKkOgPZuMRlinVefCwQx6EpXshMAtZXlzIA==
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by PA2P191MB2492.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:40e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Sun, 13 Apr
 2025 18:45:23 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%3]) with mapi id 15.20.8632.030; Sun, 13 Apr 2025
 18:45:23 +0000
From: =?utf-8?B?UGF3ZcWCIEtvY2hhbm93c2tp?= <pkochanowski@sii.pl>
To: Horia Geanta <horia.geanta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi
 <V.Sethi@nxp.com>
Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vYj/H+qJ2ybk2H3sZmwaA1kLOZjPCAgAAKHaCAAUgJAIAAr1kAgALctgCAA4o2UA==
Date: Sun, 13 Apr 2025 18:45:23 +0000
Message-ID: <AM8P191MB139485C3ADFE395BA25AC119A2B02@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
 <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
 <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <2509286b-a408-4ed4-9923-465eb87376fc@nxp.com>
 <de8bf254-577d-4ef4-8e82-f29a4be2b896@nxp.com>
In-Reply-To: <de8bf254-577d-4ef4-8e82-f29a4be2b896@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8P191MB1394:EE_|PA2P191MB2492:EE_
x-ms-office365-filtering-correlation-id: f13d5d1b-27ee-4181-5c0c-08dd7abb599f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QVRCbHczbm42OHY0OWkvNVZ0dVFYaUlXZkpOcmpuMUp4aVpodHByTStRUGo5?=
 =?utf-8?B?VG9DZldmYlo3cE43Nlhqd3BKSnBnR3cvQVhjODRFcWtqeU9FL2JzU2sreGRr?=
 =?utf-8?B?NytkaEhFZHNONE12NytKRGZEbS91UGE1Q0I2SndmQWxUTU5OMGYyUm1qUko3?=
 =?utf-8?B?K1hQbUpUT0o1aEdoQjlJeFN6YVo3OHp4cURkaTFZMXN2eHJyMXRTeG1vRGtE?=
 =?utf-8?B?RVJ6cEgwbGVNVU9VQWlkd2FjY1M2U3RJcmdrYUVuNVFNWlBUQ1JJdVRLOEIx?=
 =?utf-8?B?a200UEJSNU1wR1g4c2g5RE9jdDhoVTFDYVB6aXBrYUl6aGZ0Y29oNzVtQUtN?=
 =?utf-8?B?dnU4K3Vjdy9pK1dWbmltWEhoQ0F2WklyN1NYYXI2cEhxMnhlSE10OERTN0Jj?=
 =?utf-8?B?a1U1M042d09yK0ROUDFoQ2ttYVVYMUV3czJaWUkvelhma0kxRG9HNWJKbWx0?=
 =?utf-8?B?anFnaDVaZ3RYWkwrdE5pNlgrZXJlRjlqUnIwSEtVYnB2Smt5U2JFaGt6V0s1?=
 =?utf-8?B?b1JsdmtTaUNmNEpmUXMxaFB6SDNqNmtTaWk0K09yUjkxOFJqcnhpdnFid0hD?=
 =?utf-8?B?YTZndUhzNkNTMmFwWkg3aFBzd2Y0NnVmZ3JPcWZjR2wrWWM5RkhlR2VjVFdv?=
 =?utf-8?B?VEo0SkFqSFdlcEsrQnpNSUV4V0dSZXVHUEo5QXp5cXI2QXdyeFJ6amlqalB0?=
 =?utf-8?B?RTE0ZjNiREFjdnNNUjlZWmxIVnlDOFVtS1VkWlJHaUVjUEZNSFBoNDRrK3dp?=
 =?utf-8?B?T2VncGhOWjVUSW9xb0hTSTZZVWwra0hnREx5YkxIKzZCNTlSMWVLeExQK1dk?=
 =?utf-8?B?OTM1ZmFncGNPWityYWtiT0YzVC9keGRnRnVBUjhxYlpsQjJFd2JIVUJGV052?=
 =?utf-8?B?UGdBVTB0VEV3NFk1ZFFHOEw0VTVBditYUmdVdHF6alVEVDBqcUZXS3cvNHgx?=
 =?utf-8?B?ckttbFA1Q1VLR3VQbzJXaS85em0xVjZhYmNHaTJQellQRjV1SWJrR21YRjln?=
 =?utf-8?B?U3liWUtwbTBZMldiMWZiQ0VtMk43bmliRGpEMFRXajZQWWxZWGx1S1l2M0pY?=
 =?utf-8?B?ZHI4ajFhWFVKY3JhazRwbG0vUG1EZTlvZ3A0SVdVTUJkcHRRWUxEV09jODha?=
 =?utf-8?B?K1oyUWpWM3RWUm0vT1FPWWFrajBlblZIQzhGY0dYODUzT1dnbUUwWm9icEdB?=
 =?utf-8?B?QUQxVGxvUWw1YW5NQk9QV3hHMWdJVkVYclg1bXowYVFMNmlVVUhyUXFvbjdt?=
 =?utf-8?B?S2NIU1hEa1BFaTZQcUo0NjNWYngvSnRoOUowYTFFVGk2Y3BEMDhpaTVBZXIz?=
 =?utf-8?B?Qkx6S1JYQVdvTmNiKytpQWhFejJYVnNUVVBvK29UaElBMVZIaXppK1YzZmwr?=
 =?utf-8?B?NVVsRjhnaG9XRmtKcUtIOVZSZmdweEg3OFB4V1NGc0pGWS9WRVVmQVNyNDZi?=
 =?utf-8?B?NXdrMmI1M0p0eENmQTFFNXBHWHE1dkN5WTJObGF1Y2ExSzJJVWhQSVlkZGhY?=
 =?utf-8?B?T2RDRHU0YmZBaU9FbW8vSmwvSk5aa3dQZUFFYTBCZzhDRjNvemN2NEtBSzY0?=
 =?utf-8?B?ZDZrOXplMVgrVWVjdTZ5UlVWUEJTNlFsTHpzRk16MEZnbmpOWlF5Q3VGa0o5?=
 =?utf-8?B?NSt1cjhFOVVyZ2swMnY5Rnh0SmZBbnZPNTBvVXBCRmlXRXBDVktiMkFZb09M?=
 =?utf-8?B?aitTUkFjZXl3YVNqcktrMjhhbDczZ2RJSGFxS2Y3L3RQaVA0UlFxdElmYkVs?=
 =?utf-8?B?TDlKa0hKNExjSTdvb1NLY1pIVUgwck5CRlB2dHRheVMwMDRXN0tQL0N1b1k2?=
 =?utf-8?B?OVIzcVBmR3VFUGhpTUY4RmQ3K3Z2VDUxOUVpRUIyVzZ5dXNJbEVoQnpOSHFV?=
 =?utf-8?B?cjdURFVwUFI4WHpVd25SL1BLZGFhODNkd043NVlFdDNKenk0Yk1XWlEwSlZC?=
 =?utf-8?B?VXNlN3lRZnB5WFhySi9DQ0hZWGY3M0krejNyUS9FNzA3YzRkQlFFN1pidUVt?=
 =?utf-8?B?RmVNcWQ2bGZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWgwL21HKzBjelJIK0NVY3RHMzNPSmFac01mT0JjOC9mZXh4dDBsbjQvb3Iy?=
 =?utf-8?B?K3VSTXAxd25ENE9OcjhhbFlZSzdhNWp4N28reml4TExHYm01UVI4QjRhd2Zp?=
 =?utf-8?B?UU1nby9nSi95OXBpcjZDVmJ0eU53TzJVN2pkcU9TaVhNRzZ2MW54bk5MOG9x?=
 =?utf-8?B?SmdUTHhpTExSVXpkWC8wdTQrd3Z3ZkRuN1pwMnNKcTVBVnRrbHQzbGdmOW5E?=
 =?utf-8?B?UklzRGdBak96aVdIajBDMk9JZ1hZM2VLbFQyeDF1SGVyYzc1QmNJaVVFb04v?=
 =?utf-8?B?NU5EZG9pSkk1bStjdXVVZTR6WWlRaGdiU2xZM0xJYUtOeXkyL2h0TjhLQzIx?=
 =?utf-8?B?UU5jajMxQXdTNVdKMlNhR0ticC9ERU1oSmhOUjBlNXZWVVR5KzRtNlJSU3Z0?=
 =?utf-8?B?dkpFUEpkUTE2MHdSNWNESnQyTzRHMERaYzVwbGxubXFGNGZZVlZjSS9Lbnh3?=
 =?utf-8?B?dzNLemw0SkF2UU9oTWRIU01zaUZmd2h1R1JIZngrRWRrOFNKSHlaRXkzR1FV?=
 =?utf-8?B?MUVOZXhRRkZVakF3NWwxRmJOZmc1UWJpVUpwMW1Ob1k4U3lPTlVPRWZBYlI3?=
 =?utf-8?B?dnN6a3lVOHlVVTFKREV3VGFMbFczVjNFenFCeE0zWUQ3MGNiSjFGeHpkVEJP?=
 =?utf-8?B?M2E5T3poTHRTdFEraVVXV3VBNkdsM2N4YVp2eXZQVnNlbWY4TXgycFFTWWJU?=
 =?utf-8?B?eUhhQ3lVSWJXQWtvNkd0TzMwTlEyMFVGanJKVW5BSFVNcWFubGt4YnRpajNE?=
 =?utf-8?B?UE53QWZFTU1rTktTYzRRVDV4LzhNVEx6eUlkMVZ4YWJWRlc2TDBqQWRSc2VY?=
 =?utf-8?B?Y1FQc2hwajZhdVFDR0VmaFgvNDZORDVuQ21qMlZtU2Fpc0V3K1hPdmpDdmh0?=
 =?utf-8?B?dkRQSHQ5ZVBnYTZObVNGSzMzdjVDUEFWWDVyZE9OL2dqa3hUZ01Dc0Q3cFE0?=
 =?utf-8?B?enN2aGxvaDkyUFhRVXVOZk51RHc0S08vTHE5OFNMNVozc3pFL1RFTGpXbVh3?=
 =?utf-8?B?NUZmOEdZeEl5M3RoNDAyeWduNGNBWkVtb2NXNVpmbDJEb25pNm50YU96OXhX?=
 =?utf-8?B?NXpZRlo4QndkeVhXaDFaSlZLVXR1dnlYd1pBcS9yT1RwRmwvbElRaFRTL2s5?=
 =?utf-8?B?T2xBU0owYXB1UFR0RFAyQk41OUw1cEtEUTFES3V3dWVvMlNjVlNpN3lvYnJv?=
 =?utf-8?B?SEdKVGdpRU8wOXlpRVlRSVppRlRuaWZrOFYrNzg0b1BaYmZ2S2U1T3dCYUor?=
 =?utf-8?B?d21Ud0pwNGtRNjl1ZzFmZThmU3ViRy9kNjVmSlBOc2I2Yk1GQ01tZ09JQ21P?=
 =?utf-8?B?bmgzRlFzYmpmQWZSL20vN2JVOFk4OFliOFprZnQyeFowRFNVZjFrQXVkRVZT?=
 =?utf-8?B?Nytnc256eWdIbzVvOUdTbUNyUEhaK1JVcWtKNUNSTm02a0gzWWFxZlZHNlI0?=
 =?utf-8?B?Y1l5ZndaOVljWndyV2FwUVFmWm9aNXRnRmliR0lGNG1LVzhtQUhId1lXVXJ4?=
 =?utf-8?B?OUFGQ0E5ODN1M0QxeER4djdIUzQ5ZFJjcTBacVJkYUhVejFBazRhMGViSDBS?=
 =?utf-8?B?citqcTZvTW1kRHRIWE96ZGk2RnUrdjdDbWhWUmVhRCttNGg3MHJvM0w0cTFt?=
 =?utf-8?B?OFJUTFo5VHlWbWxCR01TdGFCZVZCWTNEazVDWW9tMUZhdGF2R2JKaTdOb1ZB?=
 =?utf-8?B?N2RvYUlQWW4wdStEZGNsU2RFckdyZkY1VFRtcVJtRzJoZjU0WmZDc0ptb0VR?=
 =?utf-8?B?bVhvMGZveXJDRFZ1eW5tTEl0dmpCZGZkNklwVUZsVCtYTlFFbkVwUGZCU0xM?=
 =?utf-8?B?dHZFQjdlVzVzZnZoMUR0dnA0RzdFSFpzY3B2YTZlZWVEejZMNjh4WEpFME5i?=
 =?utf-8?B?anNXUlFURERKWlE4R2R2K2Z3eE45d1VuSjYxYksxdmV2dFZCMWhjekhZZUtW?=
 =?utf-8?B?d0xpQTdsYzU1ejBWRGJVU3FNcFBHaWhVWGlyOHJOcWFqU3NwM0YvamwyY2t6?=
 =?utf-8?B?RTJwOWlQNWZLdmxKVFRDMGJwVklkR09XMzhBV2o0YXpzNzBEam5kUXNVQU9F?=
 =?utf-8?B?VmtRUmU0MXBaV2FjS3J6U2d5dnJJSEhyZVZNOW1ranI0SnZBOWZsRkEwWmpK?=
 =?utf-8?Q?qTNTD4tXzFk10dhWLf3qPCd4e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f13d5d1b-27ee-4181-5c0c-08dd7abb599f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2025 18:45:23.4522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAE4ZXuCZHaAMuVEHjVmZSHYaT8nYb0Zrow1jVTyl+nXSDJcGmjU9UqSEG2bR07wmHLUgdVXT5HSzOr+nmiL8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P191MB2492
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

SGksDQoNCj4gRnJvbTogSG9yaWEgR2VhbnRhIDxob3JpYS5nZWFudGFAbnhwLmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBBcHJpbCAxMSwgMjAyNSAyOjI5IFBNDQo+IA0KPiBPbiA0LzkvMjAyNSA3OjQ2
IFBNLCBIb3JpYSBHZWFudGEgd3JvdGU6DQo+ID4gT24gNC85LzIwMjUgOToxOSBBTSwgR2F1cmF2
IEphaW4gd3JvdGU6DQo+ID4+IEhpIFBhd2VsDQo+ID4+DQo+ID4+PiBGcm9tOiBQYXdlxYIgS29j
aGFub3dza2kgPHBrb2NoYW5vd3NraUBzaWkucGw+DQo+ID4+Pg0KPiA+PiA1LiBUaGUgbG9vcCBp
bg0KPiA+Pj4gY2FhbV9ybmdfcmVhZCBpcyBjYWxsZWQgc2Vjb25kIHRpbWUsIHRoaXMgdGltZSB0
aGUgYHByaXYtPmRlc2NgDQo+ID4+PiBjb250YWluIHN3YXBwZWQgZGF0YS4NCj4gPj4+DQo+ID4+
PiBJbnRlcmVzdGluZyB0aGluZyBpcyB0aGF0IHRoZSBqb2Igc3RpbGwgc3VjY2VlZHMgYW5kIHRo
YXQgc29tZSBkYXRhDQo+ID4+PiBhcmUgcHJlc2VudCBpbiB0aGUgYnVmZmVycywgYnV0IG1heWJl
IHN3YXBwZWQgZGVzY3JpcHRvciBjYW4gYWxzbyBiZSBhDQo+IHZhbGlkIG9uZT8NCj4gPj4gSSBh
Z3JlZSB0aGF0IHRoZSBkZXNjcmlwdG9yIHNob3VsZCBiZSByZWluaXRpYWxpemVkIGZvciBlYWNo
IFJORyBqb2IuDQo+ID4gSSB3b3VsZCBhZHZpc2UgYWdhaW5zdCB0aGlzLCBjb25zaWRlcmluZyB3
aGF0IEkgc2FpZCBhYm92ZS4NCj4gPiBIYW5kbGluZyBlbmRpYW5uZXNzIHNob3VsZCBiZSBkb25l
IG9ubHkgb25jZS4NCj4gPg0KPiBCdHcsIGxvb2tzIGxpa2UgdGhlcmUncyBhbm90aGVyIGlzc3Vl
Lg0KPiANCj4ganJfZW5xdWV1ZSgpIChkcml2ZXJzL2NyeXB0by9mc2wvanIuYykgaXMgdG91Y2hp
bmcgdGhlIGRlc2NyaXB0b3I6DQo+IA0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBsZW5ndGg7
IGkrKykgew0KPiAgICAgICAgICAgICAgICAgZGVzY193b3JkID0gZGVzY19hZGRyW2ldOw0KPiAg
ICAgICAgICAgICAgICAgc2VjX291dDMyKCh1aW50MzJfdCAqKSZkZXNjX2FkZHJbaV0sIGRlc2Nf
d29yZCk7DQo+ICAgICAgICAgfQ0KPiANCj4gaG93ZXZlciB0aGVyZSdzIG5vIGNhY2hlIGZsdXNo
IGFmdGVyIHRoYXQuDQo+IA0KPiBUaGlzIHdvdWxkIGFmZmVjdCBwbGF0Zm9ybXMgd2hlcmUgQ0FB
TSBpcyBub3QgSFctY29oZXJlbnQuDQo+IExTMTA0NkEgaGFzIGEgY29oZXJlbnQgQ0FBTSwgc28g
d2UncmUgbm90IGhpdHRpbmcgdGhlIGJ1ZyBpbiB0aGlzIGNhc2UuDQo+IA0KDQpJIGhhdmUgc2Vu
dCBhIG5ldyBwYXRjaCB3aXRoIGEgaG90Zml4IGZvciB0aGF0OiAiW1BBVENIXSBjcnlwdG86IGZz
bCAtIEFkZCBjYWNoZSBmbHVzaCBhZnRlciBqb2IgZGVzY3JpcHRvciBzd2FwIi4NCkkgY291bGQg
b25seSB0ZXN0IG9uIExTMTA0NkEgdGhvdWdoLCBwbGVhc2UgcmV2aWV3IGlmIEkgbWlzc2VkIHNv
bWV0aGluZy4NCg0KQlIsDQpQYXdlbC4NCg0KPiBSZWdhcmRzLA0KPiBIb3JpYQ0KDQo=
