Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98764C021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 00:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202FE80F56;
	Thu, 27 Feb 2025 01:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Y59f/zYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4784E81109; Thu, 27 Feb 2025 01:33:47 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA0B808A2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbe/z/LweAXH9WM+otqWbvI7ORjiyeNi0JGxEYUmnl1SWpMN4Nr/MAaaBW1DtJU9RQ5OEDS+utGOA2MAL9WXYufFp/kNj91LL1TFBgY+LsX8QXTeTBsS7Cyv3DaPyhBYuaPmZCCUIK9EnIR2n6u5AU8R6Asv8iUH9AmZjXgS00couvrmxquWF/ik2FGy4In6nhcH9RVxnamUktZTxuf+OOKCCwnoBTnBHV+ALGNJDNsafCucG/QoMFCWpe6u6N4YoOSPXURa7oRD8AR+M4UZl2wOSXOJ04Uut97rphd3JjAvUioOLSIwLtMrKVzy4V81sUOnWZWrQ3dvuV9QUy+4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbXuxdhas2Uamb8h8F/W3G0djBzpqjaNbtPGaBBiU1k=;
 b=OQIYl5D0N8bI3xKUx9MJXRq/8u0aTxcLkB9728hX6Mw8ralXkWOntbvSGIDCZXy2jmORI1GWBjokhPPVZMhTMF6dE9bQV9zX3dfhqHKdwWMIqA2j32n3OKRS25qh30S3kLeBqd4IkzVeh1GpQCiKHnTCoRYeiBaoc4g+AsU6B7wcvIDr0V/R1963pEBTnBy1eros2PotzHJ13Ip0O6CxVTnG6AK/03gaj16HZ7OkIdA+7qjdcjUqKyd4Y0lZOHKz8L7/2dnPRQNF6d3DyiuA9WIz7kD9ya9Tmjjszqxkd/cUJSkXFKxJjNVw4rjaQHhoNTCRf6bjTUq2UILtqpL7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbXuxdhas2Uamb8h8F/W3G0djBzpqjaNbtPGaBBiU1k=;
 b=Y59f/zYWTJaHH8q+q/SNhjq5DqmeNR+Gc20XBZvukh38X29HTWXPWEmtYnCPd18Fo0hXJWEtmetW24LEjN4IEK18UDpIc4W7yoS1uIlF7Xec/ZYkRMw72mQ9IP8E8aaOXu4yKMp2ZfjiUcrz4APAsDLmzrrxLTQSx0xIy8B4fv5w2pMAFcBDC7Mv+2XRbjAi47XHVKFcX3Kw/b0jyo8a65fmsj4BimhiTozXjZajHD52FaFzhcE1NjUydUOwrL/TojQZ1PwmCJO2GSGPG6WrdnCutuYIYDr/ETEDuuQI3wvXV9PqKi6SVNF6c8U07lyn7EPLari0y9Bt1403SV3/pg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8920.eurprd04.prod.outlook.com (2603:10a6:10:2e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 27 Feb
 2025 00:33:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 00:33:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andre Przywara <andre.przywara@arm.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, =?utf-8?B?S3ViYSBTemN6b2RyennFhHNraQ==?=
 <kuba@szczodrzynski.pl>, Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy
 Zheng <icenowy@aosc.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: RE: [PATCH 2/2] sunxi: sun50i_h6: clock: fix PLL_PERIPH0 rate
 calculation
Thread-Topic: [PATCH 2/2] sunxi: sun50i_h6: clock: fix PLL_PERIPH0 rate
 calculation
Thread-Index: AQHbiELPa2Jr72twEke9a7e+oeoo2bNaTZNQ
Date: Thu, 27 Feb 2025 00:33:43 +0000
Message-ID: <PAXPR04MB8459F6A1AFD4D0036111C9F588CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250226113712.1257061-1-andre.przywara@arm.com>
 <20250226113712.1257061-3-andre.przywara@arm.com>
In-Reply-To: <20250226113712.1257061-3-andre.przywara@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8920:EE_
x-ms-office365-filtering-correlation-id: 5718f0eb-a7c4-4a65-d7c5-08dd56c6640c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGlMc0JpL0QycDFWMlQ2SFF2bUt3MjhtajhnSlcyb1B0eGlRbmlGUDd2WUJo?=
 =?utf-8?B?K3AvUldDNDJONi9ZMmlEb2duVnNIZnVNWWNRSllkbzljeXMzZk9KSjYxejlT?=
 =?utf-8?B?QitlcUtJczhMeWpKcUVCd0hZczVvZ01zRHBwcUNyYjZzSjVqUHRMYTBuVU80?=
 =?utf-8?B?L2xwSVE1M3haK2JoaGtlMGN6TWZxYXFaY2VQZjBFaHgvQmlGTTdmeUtUNWtm?=
 =?utf-8?B?K1lhbzdwRmlaaXJvRU0xWTdnQWUrdThuNzhodTNmYjkxditjb21HNFhpa20y?=
 =?utf-8?B?TFpuU2h3L0pjeDBQMjB3MEVLd2pZQTRUTkpBdEp0Y0ZRdm5ORnZIbW03Z1RT?=
 =?utf-8?B?dmpFRGx4cUhRSmtHaE1YbytlekQ4OEhBUGhNV0xWc3RuV0t2ZnV3cUplbXRt?=
 =?utf-8?B?VHd6TWhRbGUrdHBndXVTMjIrYkRTVVk1b3pNbXdkK2ZudkhlQVR0M1lGYnR6?=
 =?utf-8?B?NW50SWFsdlEyZW1IVFdxTlRkZVJTUWwyVkFrWkRnTEpZcFdvZ1VXS1JJSWh4?=
 =?utf-8?B?eitodEc0eHBQbEJDV1hjSFRwcDBFWGhFYzVkOHljK0p4ZmNPTGtVc2l4RGhB?=
 =?utf-8?B?Q1Nlb2tnTWloNUd0Zk1HUDE5SXhwR2pMemtkRnZiR29KQWJLdlpvYXFDRWI5?=
 =?utf-8?B?L24yMEZ6NStkZnlxTC9hTWpvTWwwcHNQUHB3RDNBWHI1aDZ1ZCtmUE9tWFlJ?=
 =?utf-8?B?SDk2ampTMTBnVDRMeGQ4TFdqVHdYRWJhVVpJTDUzZ0FiVXlZTExIaGxQRnVN?=
 =?utf-8?B?blZxOGRBTmVRQXBsSmkwNG5FWXN4cWRsSnJlZUxIblpxc3Vrd3FoTExUc3Ni?=
 =?utf-8?B?SnB4VDY0THdRQ29PdkQ1NTNCTkJqQnVkS202RUFKSzhTaklhOEpqS3BBb0wr?=
 =?utf-8?B?YnNuUjlWWWw4RVVrWkEzUFBiSTd5Wm8rTytaaEw0d2dQNzExMUFOdDgrb0tO?=
 =?utf-8?B?VUp0K3MybGZZS0syYmxDcjZkWmR4b0ZnYmlHSmJKTEZyemZFTlJGOGN2ZzR4?=
 =?utf-8?B?MzV5RTA0VVVOYjhXTmVET2EwZndIeHhHRGc0RDhHSHEwSEhtNllwRUNGeFho?=
 =?utf-8?B?Y3dFdUFTYmc0eVdIUHJEYWY2ZzF0SUcweUN3QTVTcjlnYmxyMzlSNWRJdmxi?=
 =?utf-8?B?cXJrS1V3bUlFd1dzb08zY3p3TVVpTEtOU09aOWttbGppNmx0Ylk2YW96UEdz?=
 =?utf-8?B?U25Lc28zRjRMdk9oYklIK1o2MEVRY0k1d1poaWxia29UV3NZeHRwdCtzMnNl?=
 =?utf-8?B?aVg3TkY5bnhEM2g1WWZwcEdrUFpWcGs2K2dGRzNBTm1HdFB2WGRTNGZIOGdx?=
 =?utf-8?B?ZVU4azdzU2FtZ2JVNkxvb0JLYjUzb3Y0eHJkL1VDb0xYTHFGcHc4QW5FT2Rn?=
 =?utf-8?B?QVMvWHBSeGtQK3plRkFZM2g0L1p0YzJscUtqWkFLQ1hzWm0rbVY4TTgrV2J2?=
 =?utf-8?B?N0d1TlI5VFIxKzNicjU2ZW40TFpyVE1VZFBrSXZ4SHAzTDZGMHE5b1diQllv?=
 =?utf-8?B?OVpFN1FwWk1aN3RPM3dKdmJvZkQ2VmpIWS9tbDVWaTUxNHJEaERPOFZ2T0Uw?=
 =?utf-8?B?S1QzMmxnK2Q3RFpGRWdHaE12KzlXREtOYmJPV0ptcHNxaXppRElrNE5TbTln?=
 =?utf-8?B?enlHWEhTeE5rWjhLVFFwZEZjcEtBaXJhd1kxN2ptRzd0eFJObGNQWGtFTUs4?=
 =?utf-8?B?cGw1d1RHZ0JjRjkrL3A2azVvY0lhTEN4bUZuRURxUDJ3V0FPclFEVStuK3d2?=
 =?utf-8?B?OU05SGpkd1JDUFNBcExXb0JrbVlucXFER3N3Z2FFRVJDZklkTGR2YTVUbXhx?=
 =?utf-8?B?NkdsRHVhS0dYcEhCeWZKK2twSitXYkRMdWs3N2RtclRLbUduTGxucWNNUmdF?=
 =?utf-8?B?ZGF3SGIxR0hpdkdjUEoxbERDUzdNOWZoQnl6NHFKWkcwMkRGVzhmUXFvYURU?=
 =?utf-8?Q?I5u4E629MUivyHbMQgk3br5js480+ioB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0h2dEgxT1c4S0FrQTNGb1RYdHM0OVdYeXY0VVZoaDFaelFmMXJ0M24zZjhH?=
 =?utf-8?B?dnZKcWlLcjArYUczREQwQkdyS25ybGI3emZNNlNTRllPcnREUWlUTzJTcEI3?=
 =?utf-8?B?VUhRd0VyR2kxd3ZaN3NJbzVpSGtCelExZU1Cc2lsWTJuYnB4S1RCWVlnNytk?=
 =?utf-8?B?TFFjMndLSHRiSElRV29FRXRsazhjVEwrenM0TldRZ3Z5UGpEV0hVSDlVL3Rm?=
 =?utf-8?B?Ym5TemZuOXc2MWswczdEa1psc0p0d2tXazh3UWFoK1dWc1VBbURzcEh3TmlF?=
 =?utf-8?B?bytGT3RlcnpYelJ3b0xJRUFlWXJXZDVrdk9HeHFJR0NaVlBSODFaMjR0SmxZ?=
 =?utf-8?B?WUZpM1Z1Q1o2cmVnZjFVRHJRUmxpU2pEUVFxL2ozekQvM09uMm5HeGcrVWJX?=
 =?utf-8?B?M3Nja21iMmJJWkdaVTd0M2dXZTBXN1UzY2tWTzk0OVZseUxlRFQ2aW1qSGE0?=
 =?utf-8?B?b2p3Y0dVZG1Ba1dmdFpGR1h1QmdMTzN1Qkp6SUFGdUR2YmdxaUlrU2dyQzBy?=
 =?utf-8?B?U2VmdWtIa2E4eldiU2gzd3hiajhXQ3NBQ3MvVHNLYW91aGlqaGZ6VVVrOHJZ?=
 =?utf-8?B?WVBVa1czbk04aXJGRUtlek4wdFQzeThqL2ZPY3dvcnVyaWdPZ0huUzI5c1Iv?=
 =?utf-8?B?MHNYRTVPalVoaEM5cFV3YTdudUhlOFloMmx6RDl2WmVyQ24raDdDaUVOVlRD?=
 =?utf-8?B?NHFMNVhqZ0FadUVzMm9mZFdGeVUzTEJ6YUprZlppTkhSZnBYTzllWFQ4SC93?=
 =?utf-8?B?KzN6a2NVRU5zdFJYVnlZTTJTSEJFbVVLNGRzWmJ6cjB6RG1NbTkzMkJ3Y2J4?=
 =?utf-8?B?Ti96b1BUbVV4dU1ucG5xdmFrSWx2ZWtrbGxLQml2aUM2anlZaS9vOEJZK1Vx?=
 =?utf-8?B?VHBHWERSYzFHUjdhMmpKU1RKSFRyM1g4T3htYUYwb0JxME00eGYwT25pSG0r?=
 =?utf-8?B?TXlocGpGY0hLL01la293a3lVKzJBb0V1bXpnaEFySXBRU3ozSEYzNmJtN0U5?=
 =?utf-8?B?UFgzeWY0cjVnU0VkTGJWR2lLTDFoS3l6d3A1UU11Rk8vZEp2NElCRVZwdml0?=
 =?utf-8?B?Si8vYkd6a1YwZG9xYkJ0eE5GU0oyV3ZBaVUxbEJEUGdPb3FCN1djbzd6cmts?=
 =?utf-8?B?QzF3UnpxdGVNeVJFUGI1WnpBd2dwSnNid0QvZnZ1RUw4YTE3eEZCL29VMTJZ?=
 =?utf-8?B?YWluYy9VVGJRZjB5bzNPTmhKbG51Z0VJS1lOSk1ta21EcUl6eHFkTTdDRXhT?=
 =?utf-8?B?ZFZ5UitBQ0xmWWJ6UUp5SWFEeXJ0cEl3UmZVRHRzNDdWRHhnQjdmd09LdFla?=
 =?utf-8?B?WFJlRksvK3VkSm5PY2pla0wzcVNXR2VwNzhEdFRnemppRzlMclcxUGZUSXVt?=
 =?utf-8?B?djNFUXd0ZFlaZlAreUlnSVFlWGdRK1lXQkdOZlFwem94L241OTJzNHUxdENZ?=
 =?utf-8?B?Rkoyd05oaUZYYXpCQUp6TkhZck5Fc002eXJuK0ZoOVVTbHJjWFZmV0tieFo1?=
 =?utf-8?B?QitBNy9TWHN0MFloTEE1WFFjbWhjUTJZTkZIU3V6UG5yamhqL2hnbk1ZMVBs?=
 =?utf-8?B?Rlg5QUUxZE5Renk3RE1IS2plNENFQUJBQTdiY1V0VUhKc1VObUZ0RW4vTmlq?=
 =?utf-8?B?L0RJYWp4MERKa3F2TjRsRER5WVh2a0hLSmxmc1M0aXRFUEkvMENiNEVIMnNQ?=
 =?utf-8?B?ZlhCUkdCVW8xQy85Y1NFR1g2TnhvOEdjRy93cTR0VTFKTTdBeVdyWUw3dGpo?=
 =?utf-8?B?V2lra2QxTEorREU0OGpLTHZkQU04ZWFvVm5NSFFYSC9WbnZUeVl4OU56bXdq?=
 =?utf-8?B?REFmMlZwN0pFS3ZiQ2hOaUp5Z2R2elVVR0hCbDVSSGRpMnFkTENkK2dybTg3?=
 =?utf-8?B?OUJMNEc1b2pnNWdyVyttTEUvd2NWd2NMTDg2YXFRQWF2clpMUXVQQk55TThD?=
 =?utf-8?B?Sml2TE04WVZHdVp3aUtORHJKRGFtbVhKdzVUczRYRTBVazZQZ2U1NTFQTFJz?=
 =?utf-8?B?S0E5K2ZQbnZJZUplcGJRUm9IY1QrQVIyUTlWWnpUWWZVK1pHbTExdTk4aTR0?=
 =?utf-8?B?K0pGQ01mWVNob2ZDUFBiSVhzTzArMlFwS2FYa0d6aUxHL1hHc1BtTWx0NXc4?=
 =?utf-8?Q?PN3U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5718f0eb-a7c4-4a65-d7c5-08dd56c6640c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 00:33:43.8399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMcQZ8QZ1iT7MPcJ+51zpw1HzWaHMQb5LUeBPiUJKUtczGDsFBSFWF/ar8OuX8SrQZDm5V7bP+Z7Em+8pYn5PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8920
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

PiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBzdW54aTogc3VuNTBpX2g2OiBjbG9jazogZml4IFBMTF9Q
RVJJUEgwIHJhdGUNCj4gY2FsY3VsYXRpb24NCj4gDQo+IE9uIHRoZSBBbGx3aW5uZXIgRDEvUjUy
OC9UMTEzLXMzIFNvQ3MgKE5DQVQyKSB0aGUgZmFjdG9ycyBlbmNvZGVkDQo+IGluIHRoZSBQTEwg
cmVnaXN0ZXIgZGVzY3JpYmUgdGhlIGRvdWJsZWQgY2xvY2sgcmF0ZSwgYXMgaW4gdGhlIG90aGVy
IFNvQ3MuDQo+IA0KPiBDb3JyZWN0IGZvciB0aGF0IGJ5IGFsd2F5cyBkaXZpZGluZyB0aGUgY2Fs
Y3VsYXRlZCByYXRlIGJ5IDIsIGV4Y2VwdCBvbg0KPiB0aGUgSDYsIHdoZXJlIHdlIG5lZWQgYSBk
aXZpc29yIG9mIDQgKG5vIGNoYW5nZSBoZXJlKS4NCj4gDQo+IFRoaXMgY29ycmVjdHMgdGhlIFBF
UklQSDAgY2xvY2sgcmF0ZSBhcyByZWFkIGJ5IHRoZSBNTUMgZHJpdmVyLCBhbmQNCj4gYWN0dWFs
bHkgZG91YmxlcyB0aGUgTU1DIHBlcmZvcm1hbmNlIG9uIHRob3NlIE5DQVQyIGNoaXBzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmUgUHJ6eXdhcmEgPGFuZHJlLnByenl3YXJhQGFybS5jb20+
DQo+IFJlcG9ydGVkLWJ5OiBLdWJhIFN6Y3pvZHJ6ecWEc2tpIDxrdWJhQHN6Y3pvZHJ6eW5za2ku
cGw+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1zdW54aS9jbG9ja19zdW41MGlfaDYuYyB8IDE1
ICsrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1zdW54aS9jbG9j
a19zdW41MGlfaDYuYyBiL2FyY2gvYXJtL21hY2gtDQo+IHN1bnhpL2Nsb2NrX3N1bjUwaV9oNi5j
DQo+IGluZGV4IGI0MjRhNzg5M2VhLi4zNTk1MTNkMTY2OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vbWFjaC1zdW54aS9jbG9ja19zdW41MGlfaDYuYw0KPiArKysgYi9hcmNoL2FybS9tYWNoLXN1
bnhpL2Nsb2NrX3N1bjUwaV9oNi5jDQo+IEBAIC0xNDcsMTUgKzE0NywyMCBAQCB1bnNpZ25lZCBp
bnQgY2xvY2tfZ2V0X3BsbDYodm9pZCkNCj4gIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfU1VOWElf
R0VOX05DQVQyKSkgew0KPiAgCQlkaXYxID0gKChydmFsICYgQ0NNX1BMTDZfQ1RSTF9QMF9NQVNL
KSA+Pg0KPiAgCQkJQ0NNX1BMTDZfQ1RSTF9QMF9TSElGVCkgKyAxOw0KPiAtCQltID0gMTsNCj4g
IAl9IGVsc2Ugew0KPiAgCQlkaXYxID0gKChydmFsICYgQ0NNX1BMTDZfQ1RSTF9ESVYxX01BU0sp
ID4+DQo+ICAJCQlDQ01fUExMNl9DVFJMX0RJVjFfU0hJRlQpICsgMTsNCj4gLQkJaWYgKElTX0VO
QUJMRUQoQ09ORklHX01BQ0hfU1VONTBJX0g2KSkNCj4gLQkJCW0gPSA0Ow0KPiAtCQllbHNlDQo+
IC0JCQltID0gMjsNCj4gIAl9DQo+IA0KPiArCS8qDQo+ICsJICogVGhlIGZhY3RvcnMgZW5jb2Rl
ZCBpbiB0aGUgcmVnaXN0ZXIgZGVzY3JpYmUgdGhlIGRvdWJsZWQNCj4gY2xvY2sNCj4gKwkgKiBm
cmVxdWVuY3ksIGV4cGVjdCBmb3IgdGhlIEg2LCB3aGVyZSBpdCdzIHRoZSBxdWFkcnVwbGVkDQo+
IGZyZXF1ZW5jeS4NCj4gKwkgKiBDb21wZW5zYXRlIGZvciB0aGF0IGhlcmUuDQo+ICsJICovDQo+
ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX01BQ0hfU1VONTBJX0g2KSkNCj4gKwkJbSA9IDQ7DQo+
ICsJZWxzZQ0KPiArCQltID0gMjsNCj4gKw0KDQpOaXQ6IG5vdCBzdXJlIHlvdSBuZWVkIENPTkZJ
R19JU19FTkFCTEVEIG9yIG5vdC4gDQoNClJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCg0KUmVnYXJkcw0KUGVuZw0KDQo+ICAJcmV0dXJuIDI0MDAwMDAwVSAqIG4gLyBt
IC8gZGl2MSAvIGRpdjI7ICB9DQo+IC0tDQo+IDIuMjUuMQ0KDQo=
