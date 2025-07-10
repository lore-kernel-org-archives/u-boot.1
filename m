Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B09C83F09
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 05:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133EC83689;
	Thu, 10 Jul 2025 07:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BnKq/GWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BBA483689; Thu, 10 Jul 2025 07:53:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA78583653
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 07:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONXTIXGpl2QkWphDev8t+JHiCV1QAy+grJEenQoE1RSMQmiEb16cnW2UCsBdNvY6CgKp1G5lTu8BveGlb+tIUm5/y31yX+hNtgx/biDvKQaq79ti+u1d5zTcoQgTmO4UAOwg71QlhOatiAhjIkvGiS5tsRbbKjoETJcf1OOW9zBAOrf6ckUZYWJNoieZIHJlyO0xS0LLdoaynUTFnkGSbsYu3p1VOz2iCNL6S7EOkVruEmKzMtANr5aRs5O0Hkmjy0ozcYO/2FH54JcTcSIr8CA7Kpt9mzxvF6UOsx/Q2sjxANfC+6XOfN98pN4UUct/Sl/BJlKqkZ6iyI6xLruo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwER1R0Wc8Ccdn/XKYATSMsVEM4rqP3SvNXej3hZGJk=;
 b=pFgyVcrOj2wFBV7VwGDjZJrQVO47pUBwcIDln4rVq0BR1/5WdQkwx0vJsggtphkxNnJDreplre9IAOjtDE8/7Muw4YO59JXmcYNBgKOrJeD4B1yggDflEaHpnhPIuoYTlaadXU5ppMfuGHtrfkqxMam/CxUPaRT9mf0tjSlf5DhXy2Q2ZNljaRjsbhWV5Tr500twQdfjkNiLBG61a7fajPDen0p7QbjoXcLbEDbYWf02KnoucqfVOtE14OArSdWjgsxT69kEIfQaUVLCX6lUDGrWwtbCoEqr/qTkcfs5upSQToPP7bb0iZSuS/Sm18rz3sgvcF2ualSYAazcWLZD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwER1R0Wc8Ccdn/XKYATSMsVEM4rqP3SvNXej3hZGJk=;
 b=BnKq/GWLfXbCsso7YL7Z+6k1PKJKo0WV5oSbn4ZKqavh7guXFHLE8Gv4GFKWBaJowHI5HSptUjyM7S3lN8wC0IXA62DLPaPsAFMIjZFqsxNEBrBv14QxRv5ZwApXLf2Kx7ztfBCVGSLg0a54OYffqB+zvE3wGPQT2K2KBeJnRl7vevGck+rxopeNnO2HGriq0wCnl71JN1lYTAFQUGAi0lluLZ29HmqHG5c9GZiXHpRUkhjKf+eJ1UIJFiJsyyrD9lSAB67t18J5ksBf4LDUZbEVCFoMWVp/Dzbj/Rdfq8sbd3/fG9QeyJfgJVCfd/tGiqNGQBJ3KpYzFPMUR2vQNg==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by VI6PPFB13B98217.EURP195.PROD.OUTLOOK.COM (2603:10a6:808:1::11b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 05:53:22 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 05:53:22 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Tim Harvey <tharvey@gateworks.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/6] binman: rework dropping absent entries from
 packaged image
Thread-Topic: [PATCH v3 3/6] binman: rework dropping absent entries from
 packaged image
Thread-Index: AQHb3FsoJtUnJ92Q7kyyCP54skQAqrQqOzoAgADJ8YA=
Date: Thu, 10 Jul 2025 05:53:22 +0000
Message-ID: <ccf0d5863d8505336a43524d7b871338db16fc3d.camel@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
 <20250613-binman_faked_optional-v3-3-1e23dd7c41a2@phytec.de>
 <CAJ+vNU2o3jtSMaUTd_1xms7QeAdJwTyy8Q+UiKQC56rCwk2G6g@mail.gmail.com>
In-Reply-To: <CAJ+vNU2o3jtSMaUTd_1xms7QeAdJwTyy8Q+UiKQC56rCwk2G6g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|VI6PPFB13B98217:EE_
x-ms-office365-filtering-correlation-id: ac7cfe40-4c1b-40f0-9d07-08ddbf76141c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkF0V1M0U1JCbFVjeDlNQnNzY0o1c0F0SnRSd2krcFhPQzNiQ0I3LzI0ZUs5?=
 =?utf-8?B?aTQrT3BFOWxEbnZlOEc1THRYQjNkM2ZRdFFEKzd1UnpBdGE0U2NLb0Y5eUJE?=
 =?utf-8?B?d1FsMTlpNlNNL3BPSUNsK1V0YXEyRDhuV2ZzdmE2OWNMejVYbVZDZWVMbDNY?=
 =?utf-8?B?c3JuOHY5T2JSR1JLZEc4UnRZWHo0c1d1RktuVXJReElHT3BnOGdhT29EcldV?=
 =?utf-8?B?QUp1SGNtbXpZT0VhQ0Y1QlV5MzF2dytFa1FjeElqYldIcW5CZ0laanNZczlU?=
 =?utf-8?B?a0J4V0NvQnlyN3MwZ2lZdVZiTVBPTENvK3VjeWUzVUpWS3ppWk9wc1dzdUhU?=
 =?utf-8?B?OVBtN20wVWxvNGZzbUt0THNDTnBaR3h4azhNOUs3ancwTGh2eDNvYk1vd1BW?=
 =?utf-8?B?bTFrem51Q1NKM0szd0RpQWM1Yy8vR1YzRkloYVdhWFhYd0VKcFVqZEpqRlZM?=
 =?utf-8?B?Ym9oU3o4VVBpMXdRQU1rS2Nnd1NJbysrZXVwS0tJZ0F2dlkrbkNZb29iTUVS?=
 =?utf-8?B?aW5aQVM1WFV5dGF0N1V2TkYvTDhLY1RTVFJZT1QzbGd6Y1EwVCsybVZwTjBm?=
 =?utf-8?B?RUF6Rk8yeFkzQXA3YXFlU1lTTzRjNmlKYXcrUy9IaElVV2UxWnc2U1dyekVF?=
 =?utf-8?B?V0R4emVsaWVnY3FzZk54L1U5ZVJWaGw5cGNhRjNHdWh2Qi9KS1pkbnJXNnlK?=
 =?utf-8?B?SVJ1eHdXVWJPT3h2NHV6MGYrNDBIWFBHajZMOXF2MStwUXd3L2syRWw2Qllm?=
 =?utf-8?B?QmxTY1gwNU5sdHFlSWZYWUFXUUc4c2RINncxY1ZjRmp3U3dUejZsK0cwOTBL?=
 =?utf-8?B?MUlaN3ZZUTk5dy92OFg4WERlUElCWlEvM0pDN1pVaUpxVlhORFE3Q0NCS0Rp?=
 =?utf-8?B?MFVxNlcxc1dydFJTTmFkNnJQSmMvTXhuZ3F3dS9Dak43d2s2aVJBVzZwM3Zu?=
 =?utf-8?B?NTBBNDJWU1F4WEgrd2lZdENZMGo0NVIxR3BBczRVQ01tWmsvMHFocVVTR3JI?=
 =?utf-8?B?TzVYNnpRSnE2ZzhZaHMvczZXOCtTUXJNa2Y4bWlMUGVabnZyOWx2MjJNYUJ3?=
 =?utf-8?B?RFZVVDkrWEFNOGU2M3ZnMFN0dTllcVl6NDM0bmJFMnFIL0FyYUduQTc3eVBF?=
 =?utf-8?B?VVYwVko2NlBRZkNONlQ1djZhZ3p3RU5DUmgrQ2JwdTVrMWNSd1VXcXJYOGk2?=
 =?utf-8?B?OEIxc3hpUmY1OVRzeHIvVGtMQUttUXp0VFdKdWcvQWJ6ejhwMk15WFhoSzdE?=
 =?utf-8?B?RjBhK2xHRHlWRnlPT294Vnc5YVpzWTkyYUYzWXhtQmRaNjdGd1ZTY09vTTI0?=
 =?utf-8?B?SHFMMGZPaHY5eHVDdncyU1JTcjJiNEREMU9RT3JLa0VKZ0Q1c3ZQRnlXUGZI?=
 =?utf-8?B?UnNyOWZ3dVNOaEsxTTJwWmk4dUQ0V0xTMDNScHlBQVl3ZEVZc0FEaC85ODhU?=
 =?utf-8?B?SW44Z0IxOERGdGZ1SWR3dGtuWW9OODYra1ZvdXB6amJqY0dpdnluS3NCVUtG?=
 =?utf-8?B?MVdOUTJ5dTZvMzZ5a2dnZUl4SkpmVy9xeDQ3OFNhMUFOcGFPcTlqRjBpSEpI?=
 =?utf-8?B?ZXNPMTdNRngzM0l4ZnRTRHpyRG1kcmlwdTJCY01wU3JMZUxsVkwvU2NaVEtk?=
 =?utf-8?B?QXZ2SEVyc1VTWGpqelR2RDhxRzFUYUg0NHBxdzU4U09GTndXSXRhVjhHNmZu?=
 =?utf-8?B?TFFvL1BQdUJyVjRrK2RCQWc3UWRLeDJlZXRyWmlheUN0YzlUVFBmZXA3ZEhD?=
 =?utf-8?B?bGMvajVXWnB1OXpKczJ6ZHp6ZDVKdE8xL2p1QVVER204aFZNeUx0TjEzVTBE?=
 =?utf-8?B?RkRGUTVhRWFFVWdSNHk4MUwrR0dBbXIzR2VTM0NsNDZCSGRaYjFrTXpWTnRQ?=
 =?utf-8?B?TDZ6TEJieFFwS3BkM3JxQ2diR2dYRG9TaUEySTJ1N0c5L2hBSXd6ZGpvTVRY?=
 =?utf-8?B?SWZ4OUFRMUgwZnF2Y0N5OW1KTERJUzB3N1ZOUmpIdHB1TzY1UEk2TitjTFJw?=
 =?utf-8?B?SmUweldVeTZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFp4dnNBME8vWXNiVGNkOXV0Q1dJMCtOdTZkZzZHZStGdit5YUYyOG1vZzMx?=
 =?utf-8?B?TXFiQ3pVdGdtcmovREdmMXYwRzNsNk42OEowN0gwNE5JQUliaUUrdWw4d2lu?=
 =?utf-8?B?a1AwKzFQaENML1dCYVoxK09SVDk2RkRoVklrNEs3N2hKK0RLVmR6a0p4VFNj?=
 =?utf-8?B?ejZXNFRyVjJIR2FkNVhiYjRHMGJRdUJMZ0dxcU1LWVF2MkNKN1ZLTEJ4azZI?=
 =?utf-8?B?N3FmM2xiYUJvenFyVm9wYnkrRUsvNE1NOHdtQmF3a2wzZmQ3aHlvb3J3bUFo?=
 =?utf-8?B?T2lrVnp1UDdaOEJOVS91eDBXWU5QRjFFSzdZcE1FbENhVS9nRWNwN2p1Qmxz?=
 =?utf-8?B?blJlb3J6MkhaQkhzV0s1WXpCZ0t5TEdBQXBqYmlma0kwSDAva2h5TkhFVGU2?=
 =?utf-8?B?eCtNa2RTeWhIVTRoY2tuTEprUXY3bmFHeThLZXFMOWpsM1RwaUVuN2EvOHls?=
 =?utf-8?B?YWZUTkhkcHpKR21oRkN4MDBIWDdpOXFwbURyTk9JT3ZJYmtEQnJqd1VjQ2Fm?=
 =?utf-8?B?eEFXcm9MdzFERktmVE4zOHBlQlhuOUdOYStyTWsvR0d6RlJwRThHVzdkTDhB?=
 =?utf-8?B?UGFDbHBMejExZlllaE96YmdaZmdSR2REU1RPUVdOSVArc0tLNHRKNGpCR3pH?=
 =?utf-8?B?RHN2RzlpQ3lXV0tlaC9iVFFOZWhsTnQ4Q2ZESVdOQ29LazNpcGJJQlNEeERn?=
 =?utf-8?B?RmJoZU9JdDBKeEtDZWdvcHp0djFWdFB2UXcxNCtELytjZkVtYVM0aXFtT3V1?=
 =?utf-8?B?UWQwL29UazA2aGZyNmNCSFdEeTdDV2c3NndVenhRS2RYRG1QVDdXRFhJa0dx?=
 =?utf-8?B?RnU4VHZNM1RCMktPakRuNFdOT3BJNU1GZ3ZieEpXWVowVkx5cENRT1pNMUoy?=
 =?utf-8?B?UUNEOTBwSXlPU0xVRGEyVFgzMDVIK01YcmRKblFMTDV0cGVpbDZ2ai9XYUln?=
 =?utf-8?B?bjA2bW1DNlpUSklqYS9BSk1pTmVBWmp1RFgvdFZkbzRqanN3dCtHeHo0NHBv?=
 =?utf-8?B?aVVTUmhtWmlEWUlsdDdwOXhCaVV0UjdDYVV1Sk1tK05oNGRwM1hTVGZhSFE5?=
 =?utf-8?B?dGlMNlVJamRxeWl1aTZlS05RUkdvNDRTNVFPb2dNa0FoUDlRSzBYNFFhMG1H?=
 =?utf-8?B?bVkxSW9YdUNVVzQrdzQ3a1g5WDllSTZxZThORHgxWWVNbERvWGtyZEFPcXhh?=
 =?utf-8?B?V2RGRHFoOURwb1VoM05CUDI0c2hOUlhuTDFYTGUyTkhMQURTbzVxelZxUjJu?=
 =?utf-8?B?Rnhiek1TWXQrVlNJTGo0MXdZbGFpMWR1TWVobzRjWE5tR1NqSmMzR1ducDYv?=
 =?utf-8?B?UDM2SU93T1NPSDd2ZFZtT2Z0Y1pTVGw2TzJ1UjJ3QVNncytULzJ4M3lobmxs?=
 =?utf-8?B?YS9PY2UrZWY4SXdhRjRubXF5eEk0TjZQRnpyT0JodDlvNFhKTXBpd05SRTU0?=
 =?utf-8?B?UVB6SXhwRmFlSjJEVUw3c0tDVG5aNWt6bTEydFQzekU3cS93REI2UzVRQVhs?=
 =?utf-8?B?RnAreVduVFpMQ0JWMGlHalIxTUplWkEyODJFNzBJSVVHSGJYYnUzTk5OaU5o?=
 =?utf-8?B?bnBkN1hhZmozZWk1cFp4STh5Q2N0d3FFY3pjVTB1eFcrVHI5WkNDMks3ZnpR?=
 =?utf-8?B?bHZjRGcySHJFeHpFdGVCRGF1eEp5WlBpVkMzT3Q1SXRFK1BnOWVaaE1JT3FK?=
 =?utf-8?B?UFRoSjBuaDk3eTAvSElQbnUwcGZKbElkYXBTNFBlbWkzSzhmdUkyTkZuejZU?=
 =?utf-8?B?Z2pYNjBkUWJQUGVJR1AyYjJsZlE5SUloUE9PbSs1VUxyTjkrR2hwaVNBRkMr?=
 =?utf-8?B?WXJwMllPNlB1cTRPeC94ZVd0RExqTWhpQ0RGNHB0c2dIc05BeC9CMlZOMll1?=
 =?utf-8?B?cWlmbm42aGlNTWJBblpvNjNaVDlMVWVvZW1OMTBlKy9FcFVrMXZOejRiSDBV?=
 =?utf-8?B?dzhzUmIzb2xqcEJ3M25Rc0J6ZHYyMktvTG5wRGRoMGpXUnl3U0FnZEJkaEUw?=
 =?utf-8?B?R3JiUjU0NEZvQU05QUlnQ2xyV3NucWlHS09aSXcwYUZQZkZpNFo4SS9BMTJs?=
 =?utf-8?B?cDhhK1dLaWlFUGVsRUo2enMxZkpJTEdUWGZGcWpVSzFUbWNHazUxWDRoR3Z1?=
 =?utf-8?Q?5Dt0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3A1584B9BB8064CBAE3E21FAB2852F6@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7cfe40-4c1b-40f0-9d07-08ddbf76141c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 05:53:22.0683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ovCH9hS3RuvHO76SKrydTvDH7Kp0HdYJs88NCePjjr6Tn6Iw0wgSuuXvBVN+4AYGucKHbr5DR+l+M7tiB5jHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFB13B98217
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

SGkgVGltCgpBbSBNaXR0d29jaCwgZGVtIDA5LjA3LjIwMjUgdW0gMTA6NTAgLTA3MDAgc2Nocmll
YiBUaW0gSGFydmV5Ogo+IE9uIEZyaSwgSnVuIDEzLCAyMDI1IGF0IDU6MDTigK9BTSBZYW5uaWMg
TW9vZyA8eS5tb29nQHBoeXRlYy5kZT4gd3JvdGU6Cj4gPiAKPiA+IFdoZW4gYmxvYnMgYXJlIGFi
c2VudCBhbmQgYXJlIG1hcmtlZCBhcyBvcHRpb25hbCwgdGhleSBjYW4gYmUgc2FmZWx5Cj4gPiBk
cm9wcGVkIGZyb20gdGhlIGJpbm1hbiB0cmVlLiBVc2UgdGhlIGRyb3BfYWJzZW50IGZ1bmN0aW9u
IGZvciB0aGF0Lgo+ID4gUmVuYW1lIGRyb3BfYWJzZW50IHRvIGRyb3BfYWJzZW50X29wdGlvbmFs
IGFzIHdlIGRvIG5vdCB3YW50IHRvIGRyb3AgYW55Cj4gPiBlbnRyaWVzIHRoYXQgYXJlIGFic2Vu
dDsgdGhleSBzaG91bGQgYmUgcmVwb3J0ZWQgYnkgYmlubWFuIGFzIGVycm9ycwo+ID4gd2hlbiB0
aGV5IGFyZSBtaXNzaW5nLgo+ID4gV2UgYWxzbyByZW9yZGVyIHRoZSBwcm9jZXNzaW5nIG9mIHRo
ZSBpbWFnZSB0aGUgZm9sbG93aW5nOgo+ID4gLSBXZSBjYWxsIHRoZSBDaGVja0ZvclByb2JsZW1z
IGZ1bmN0aW9uIGJlZm9yZSB0aGUgaW1hZ2UgaXMgYnVpbHQuCj4gPiAtIFdlIGRyb3AgZW50cmll
cyBhZnRlciB3ZSBjaGVja2VkIGZvciBwcm9ibGVtcyB3aXRoIHRoZSBpbWFnZS4KPiA+IFRoaXMg
aXMgb2theSBiZWNhdXNlIENoZWNrRm9yUHJvYmxlbXMgZG9lcyBub3QgbG9vayBhdCB0aGUgZmls
ZSB3ZSBoYXZlCj4gPiB3cml0dGVuIGJ1dCByYXRoZXIgcXVlcmllcyB0aGUgZGF0YSBzdHJ1Y3R1
cmUgKGltYWdlKSBidWlsdCB3aXRoIGJpbm1hbi4KPiA+IFRoaXMgYWxzbyBhbGxvd3MgdXMgdG8g
Z2V0IGFsbCBlcnJvciBhbmQgd2FybmluZyBtZXNzYWdlcyB0aGF0IHdlIHdhbnQKPiA+IHRvIHJl
cG9ydCB3aGlsZSBhdm9pZGluZyBwdXR0aW5nIG1pc3Npbmcgb3B0aW9uYWwgZW50cmllcyBpbiB0
aGUgZmluYWwKPiA+IGltYWdlLgo+ID4gQXMgb25seSB0aGUgYmxvYnMgYXJlIGRyb3BwZWQsIHRo
ZSBzZWN0aW9ucyBzdGlsbCByZW1haW4gaW4gdGhlCj4gPiBhc3NlbWJsZWQgaW1hZ2UuIFRodXMg
YWRkIHRoZW0gdG8gdGhlIGV4cGVjdGVkIHRlc3QgY2FzZSBjaGVja3Mgd2hlcmUKPiA+IG5lY2Vz
c2FyeS4KPiA+IAo+ID4gSW4gYWRkaXRpb24sIGEgcmV3b3JrIG9mIHRlc3RQYWNrVGVlT3NPcHRp
b25hbCB0ZXN0IGNhc2UgaXMgbmVjZXNzYXJ5Lgo+ID4gCj4gPiBUaGUgdGVzdCBkaWQgbm90IHJl
YWxseSBkbyB3aGF0IGl0IHdhcyBzdXBwb3NlZCB0by4gVGhlIGRlc2NyaXB0aW9uIHNhaWQKPiA+
IHRoYXQgb3B0aW9uYWwgYmluYXJ5IGlzIHRlc3RlZCwgYnV0IHRoZSBiaW5hcnkgaXMgbm90IG1h
cmtlZCBhcwo+ID4gb3B0aW9uYWwuIEZ1cnRoZXIsIHRoZSB0ZWUuZWxmIGZpbGUsIHdoZW4gaW5j
bHVkZWQgaW4gdGhlIGltYWdlCj4gPiBwcm9wZXJseSwgYWxzbyBzaG93cyB1cCBpbiB0aGUgaW1h
Z2UgZGF0YS4gVGhpcyBtdXN0IGJlIGFkZGVkIGFzIHdlbGwuCj4gPiAKPiA+IEFzIHRoZXJlIGlz
IG5vIGdsb2JhbCB2YXJpYWJsZSBmb3IgdGhlIGVsZiBkYXRhLCBzZXQgdGhlIHBhdGhuYW1lIHRv
IHRoZQo+ID4gZWxmIGZpbGUgdGhhdCB3YXMgY3JlYXRlZCB3aGVuIHNldHRpbmcgdXAgdGhlIHRl
c3Qgc3VpdGUuCj4gPiBGb3IgdGhlIHRlc3QgY2FzZSBnZXQgdGhlIGZpbGVuYW1lIGFuZCByZWFk
IHRoZSBjb250ZW50cywgY29tcGFyaW5nIHRoZW0KPiA+IHRvIHRoZSBjb250ZW50cyBvZiB0aGUg
Y3JlYXRlZCBiaW5tYW4gaW1hZ2UuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29n
IDx5Lm1vb2dAcGh5dGVjLmRlPgo+ID4gLS0tCj4gPiDCoHRvb2xzL2Jpbm1hbi9jb250cm9sLnB5
wqDCoMKgwqDCoMKgIHzCoCA1ICsrLS0tCj4gPiDCoHRvb2xzL2Jpbm1hbi9lbnRyeS5wecKgwqDC
oMKgwqDCoMKgwqAgfMKgIDYgKysrKystCj4gPiDCoHRvb2xzL2Jpbm1hbi9ldHlwZS9jYmZzLnB5
wqDCoMKgIHzCoCAzICsrLQo+ID4gwqB0b29scy9iaW5tYW4vZXR5cGUvbWtpbWFnZS5weSB8wqAg
MiArLQo+ID4gwqB0b29scy9iaW5tYW4vZXR5cGUvc2VjdGlvbi5weSB8IDE2ICsrKysrKysrKysr
Ky0tLS0KPiA+IMKgdG9vbHMvYmlubWFuL2Z0ZXN0LnB5wqDCoMKgwqDCoMKgwqDCoCB8IDE0ICsr
KysrKysrLS0tLS0tCj4gPiDCoHRvb2xzL2Jpbm1hbi9pbWFnZS5wecKgwqDCoMKgwqDCoMKgwqAg
fMKgIDIgKysKPiA+IMKgNyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAxNiBkZWxl
dGlvbnMoLSkKPiA+IAo+ID4gCgpbLi4uXQoKPiA+IGRpZmYgLS1naXQgYS90b29scy9iaW5tYW4v
ZXR5cGUvc2VjdGlvbi5weSBiL3Rvb2xzL2Jpbm1hbi9ldHlwZS9zZWN0aW9uLnB5Cj4gPiBpbmRl
eAo+ID4gMWQ1MGJiNDc3NTM0NzAyMDE5NTAyZDA4Zjg2NDhkNGM5YTM2N2MwZi4uMDNjNGY3YzZl
Yzc0YzZmYTc1YzkzNjJlMmZlY2RiMGU2YQo+ID4gYjU2OGNiIDEwMDY0NAo+ID4gLS0tIGEvdG9v
bHMvYmlubWFuL2V0eXBlL3NlY3Rpb24ucHkKPiA+ICsrKyBiL3Rvb2xzL2Jpbm1hbi9ldHlwZS9z
ZWN0aW9uLnB5Cj4gPiBAQCAtNTM3LDcgKzUzNyw3IEBAIGNsYXNzIEVudHJ5X3NlY3Rpb24oRW50
cnkpOgo+ID4gwqDCoMKgwqDCoMKgwqDCoCBmb3IgZW50cnkgaW4gc2VsZi5fZW50cmllcy52YWx1
ZXMoKToKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeS5Xcml0ZU1hcChmZCwgaW5k
ZW50ICsgMSkKPiA+IAo+ID4gLcKgwqDCoCBkZWYgR2V0RW50cmllcyhzZWxmKToKPiA+ICvCoMKg
wqAgZGVmIEdldEVudHJpZXMoc2VsZikgLT4gZGljdFtzdHIsIEVudHJ5XToKPiA+IMKgCgp0aGUg
cHJvYmxlbSBpcyB0aGF0IEkgZm9yZ290IHRvICJwYWNrcG9ydCIgdHlwaW5nIHN1cHBvcnQgZm9y
IG9sZGVyIHB5dGhvbgp2ZXJzaW9ucyA8IDMuOS4KVGhhbmsgeW91IGZvciBicmluZ2luZyB0aGlz
IHRvIG15IGF0dGVudGlvbi4KCj4gCj4gSGkgWWFubmljLAo+IAo+IFRoaXMgc2VyaWVzIGp1c3Qg
Z290IG1lcmdlZCB0byBtYXN0ZXIgYW5kIEkgbm90aWNlZCBpdCBmYWlsaW5nCj4gYnVpbGRpbmcg
aW14OG1tX3ZlbmljZSBvbiBteSBVYnVudHUgMjAuMDQgZGV2IGhvc3Qgd2hpY2ggaGFzIFB5dGhv
bgo+IDMuOC4xMC4KPiAKPiBtYWtlIGlteDhtbV92ZW5pY2VfZGVmY29uZmlnCj4gbWFrZQo+IC4u
Lgo+IMKgIEJJTk1BTsKgIC5iaW5tYW5fc3RhbXAKPiBiaW5tYW46ICd0eXBlJyBvYmplY3QgaXMg
bm90IHN1YnNjcmlwdGFibGUKPiBtYWtlOiAqKiogW01ha2VmaWxlOjEzMzY6IC5iaW5tYW5fc3Rh
bXBdIEVycm9yIDEKPiAKPiBEbyB5b3Uga25vdyB3aGF0IHRoZSBtaW5pbXVtIHZlcnNpb24gb2Yg
cHl0aG9uIHJlcXVpcmVkIGlzIG9yIHdoYXQKPiB3b3VsZCBuZWVkIHRvIGJlIGNoYW5nZWQgaGVy
ZSB0byBzdXBwb3J0IHRoZSBwcmV2aW91cyB2ZXJzaW9uIG9mCj4gcHl0aG9uIHRoYXQgd29ya2Vk
PwoKQWJzb2x1dGUgbWluaW11bSB2ZXJzaW9uIGlzIDMuNS4gVGhhdCBpcyB3aGVuIHR5cGluZyBn
b3QgaW50cm9kdWNlZC4KClF1b3RpbmcgZnJvbSBiaW5tYW4gcHlwcm9qZWN0LnRvbWw6Cgo+IGRl
c2NyaXB0aW9uID0gIkJpbm1hbiBmaXJtd2FyZS1wYWNrYWdpbmcgdG9vbCIKPiByZWFkbWUgPSAi
UkVBRE1FLnJzdCIKPiByZXF1aXJlcy1weXRob24gPSAiPj0zLjciCj4gCgpCdXQgdGhlcmUgaGFz
IGJlZW4gYSBwYXRjaCB0aGF0IHRyaWVkIHRvIG1ha2UgYmlubWFuIHdvcmsgZm9yIDMuNi4KZGU2
NWIxMjJhMjUzNCAoInRvb2xzOiBGYWxsIGJhY2sgdG8gaW1wb3J0bGliX3Jlc291cmNlcyBvbiBQ
eXRob24gMy42IikKClNob3VsZCBJIGNyZWF0ZSBhIHNvbHV0aW9uIGZvciBweXRob24gPj0gMy41
IG9yID49IDMuNz8KCllhbm5pYwoKPiAKPiBCZXN0IFJlZ2FyZHMsCj4gCj4gVGltCg==
