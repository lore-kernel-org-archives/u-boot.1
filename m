Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3400EA811B
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 14:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7FF483CEA;
	Tue, 10 Feb 2026 15:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NOVATECHWEB.onmicrosoft.com header.i=@NOVATECHWEB.onmicrosoft.com header.b="Fxm4jkE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E46A83CE3; Tue, 10 Feb 2026 15:38:59 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E802F83CB5
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 15:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm2OhhTXDW1zuYPqZxTVwHQvMkPrbiSY9PFL14wgVjR3aty/GHcPcDSUqXBIKr34NXofQ5ToG+8fIi4rflnaRJ64OYf5w260G6SB1O3B8n8JHL84n/LbJT49k+LZ76nV02DHfmZXxUYBwHNQNCy3ZWiM/EUrxk1qlWMgQgS/TM/3dFFNUZR7ilVozSS/W6n6gnfH8AKv3obWhgMZoSgvUetjl3mvgqwBUqQaYl+91N5a5ZVPwOPMS/rBDnfXhTc/15og3JRIVmUrWaR/04scRU8IJOatnWWzED0xUEOkHuZCXC0GrqRVUEk5b2qGxOXoeeHqqeLaZfjH+K25rFqNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BmeC4LRxoKSdlcfb2hH+5nQuX5fI18MfcficUAyS/A=;
 b=QnYjHjiib4lBHeqLreZw1W1LnBIia2Hxl9WbTMQcmHkgFNQmHAnljIsGu8Rgzm2gnJO7WR/6QMNuxu99zXCIluiBLjD2bbyIeZ9trVWxpIYBJr85J5D6YByS6HWW7SRm+d3kUt6GMxkQEzYB2RlnU78VSRAlTYufEr/nqSnK/ntvX2RZ/w2qboQRwFhQIPuK8muGO8f7xLMpiJuK09AxNs5nEoAeRzdNSI3wzZ5n80FwdekeM7z1j1PqKbBQa/2goTBE4v7A3JQWHL8dGZYZLawVQNjUZNWqK3OD9OPXJI048sV3oQcPJbu/MQ2rJnfz1mVeq0EzMam+R/ep3N6+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=novatechautomation.com; dmarc=pass action=none
 header.from=novatechautomation.com; dkim=pass
 header.d=novatechautomation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NOVATECHWEB.onmicrosoft.com; s=selector2-NOVATECHWEB-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BmeC4LRxoKSdlcfb2hH+5nQuX5fI18MfcficUAyS/A=;
 b=Fxm4jkE3sAoM5cfEYJ2FnhwzaJ+If1+FHYHfjONSlqDUtKqTdBSChkhNL8yVd7mpAoqm438iVDIA9mHmodo1UhIPkVPcHJiRlNQNgayewPhpwn4cqN/ZGJqdoYETTvVj6kSx6DCrcmIfoXMg/Jhp6UwUN9bEbWI2x05m/ui0xqA=
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com (2603:10b6:a03:4fa::13)
 by CH3PPF24649D10F.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 14:38:52 +0000
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::12bb:dffa:2e93:aad1]) by SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::12bb:dffa:2e93:aad1%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:38:51 +0000
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "bmeng.cn@gmail.com"
 <bmeng.cn@gmail.com>
Subject: Re: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
Thread-Topic: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
Thread-Index: AQHb9QK0U282p1IGiUCAQWRVnThtfbVyh+wAgAA2cgCACoVsLw==
Date: Tue, 10 Feb 2026 14:38:51 +0000
Message-ID: <SJ2PR07MB97113A17DC42B9E4E87E95EB8162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
 <20260203181444.GQ2603314@bill-the-cat>
 <CAFLszTgLx_TtEO-8qq_9uojLd7PgFdUuhs5_6kYqL7GuzFt7ow@mail.gmail.com>
In-Reply-To: <CAFLszTgLx_TtEO-8qq_9uojLd7PgFdUuhs5_6kYqL7GuzFt7ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=novatechautomation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR07MB9711:EE_|CH3PPF24649D10F:EE_
x-ms-office365-filtering-correlation-id: 3efddd98-c845-486e-4441-08de68b21c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MkNwUEFOMDhGdmdQZVNlWi9Cb2FTYTBzWGFkbFhldHlIU041L2IzenVzZVFl?=
 =?utf-8?B?a3dReHA0OVc5T292N1lCS0t5VFNJc3h6VXRMNVhEeEpnMXpiQVh3UVY4VHgx?=
 =?utf-8?B?U1VHb1FPZ25PNS9mQnNDMUZ4QjkvM3JQUFRBdFY5S2pqUGpRSnh3S2F5Nys2?=
 =?utf-8?B?SGZXQVRtV1Q4cGdOYWZ2aWhpRXcwYXp6MVM5NWdHamlFblc5RHNtRDRRcG9u?=
 =?utf-8?B?Tkx1SkJxWG9xb1JCZ25VcEQ0T0JxcVJBUGZITWRUYWpJMEVQQVZ0cU9sWEtI?=
 =?utf-8?B?SzZTZFdQa1F2dDRoMTRMM1VQVSszWHlyWW1saEJhelV5Zml2MEZDSzdndDVV?=
 =?utf-8?B?RVF1TjVJYTlmaTlNSjgvdzA5cEVEZ0M5Ulg3cGppZWpvc3JWY3ZaNHRaeGow?=
 =?utf-8?B?aDVpTUxtdFg0alp3eTB1NzhHSUFHcWFDdytOYjNjL001aEJpSGVPMDI4Q1N0?=
 =?utf-8?B?cTJUY0VETGcva05CbVA2azRsaThqblBhTks3U3VoVm9TUzJ4Qm1vRDVyR1Ev?=
 =?utf-8?B?TlpBUzNxUG84L1U0SEJXQzJvVVlDRWIvTDBrb1E4MVhmSjVocnFDREZLT1dx?=
 =?utf-8?B?NXE1ZTZmR1dnM25KV201WE9BRkt5UHhlVnQvNHJhWlJKTjF6YURkc2xSQ2dZ?=
 =?utf-8?B?VzFLajNGY3RjQ0l5M3dXWW96elp5cFlGVmN0SmxaTlprR0RkRkZudXB0cmxv?=
 =?utf-8?B?dFd6aWFnNWhBU24rTW00aUkyaVlESFpqZ3pQYUR1U0p0NlRWRTlLQ25xK2Jl?=
 =?utf-8?B?eUp0TTQrclJ3dVdaaTZ5cHprNTlhMkIra29NZy9YRTU2UTZFKzBnbnFpRVBW?=
 =?utf-8?B?MFo2NDBFb1pWZW42VFpSMWJMWnhaL05QNzE3Y25Hc1kvL05RNFBUVDM2Nk1K?=
 =?utf-8?B?bEhBVlBrc0JSMGtGTkFsZ1Y5YUVTRy9kV1NDZ0hJL09vaXpvaHoyZDY3QWYv?=
 =?utf-8?B?SzBBZzNHdUdUTmtGUFp3ZHFkNFYrdjN0SVJocjczOTBoM1ZXOHVIRzRKRVVE?=
 =?utf-8?B?OEt0Z1dJRWttK3FFTTgreU5Oajh3Mk54M2pVWjVPY3VCRktCdlJlV2JyK3FN?=
 =?utf-8?B?cmNBVFRSblUzUkcwaXB2YWF2VUhjUnU4YmZaOUh0a0JRcys3TUE4Z3JIczI2?=
 =?utf-8?B?bEZyTDd1TjhpLzNCRXFqQkZPV2VGalJyZENxWjlUbDh1K0Y3eVBzQytxTk93?=
 =?utf-8?B?eDFQM0xYeDA5TkJiU0VkVVZPUGNLbmhFMjVNaVMwT0FndUxCcHEwL21IQkMy?=
 =?utf-8?B?S0lHVjYyQlo0V2VhUW13Vmo4R1dHWjFaSEpaY1RnR3hZK1ZDUTBOWkVPMStt?=
 =?utf-8?B?TlNaeCt0WGN6dzI3WWNWUGUzcVkreVYrY3M3RzJnaWluYVRjTjBxb3ZNUFBF?=
 =?utf-8?B?ZFMyT2F3OUJoYTZGWDRyNjh6eFlwU3M0K0FkSUpJQXgvd1h5Nm5xeGI5VTRt?=
 =?utf-8?B?OHNOcEF3OGpYb3RyakMzNFdKZnJ0ckhGdGJFUWZFVDdwRm91T0lDYmRUOEI0?=
 =?utf-8?B?ZDdVTjRrYlpoRWpmWTh2SGdHOHg2R21pcURkRHplVTBqTHN3eVJUZm44R3oy?=
 =?utf-8?B?enEraWpCVG15ZlZja2NtNmRVd1JaVjlFUTJpUnpMcnk1c0lrYjc4UDBtejVx?=
 =?utf-8?B?U0lmSTNVY0xHNTVNN1IzS0FjdmpTRnhhbXlDYUNzTHJlSldUUlMvM3ZVL3VE?=
 =?utf-8?B?dHp6NE1WMjRhRWIzQTZFMG9DVmpVUUR3QmYrMk1iOWR4ZGFrNjltakZURmFC?=
 =?utf-8?B?RjZNZXRhL0NpWXVTeFdobHRWTXo3ZGROcFVmbitjTGFrd3h4cXpBYXJPVmh1?=
 =?utf-8?B?QWIwTUU3N25ja3Q0ZklKa25GZFozNWxFS3JqdkFZYVl0UWRQWWgrak04TERB?=
 =?utf-8?B?VWdTQ000c1dNaG5zRnFxekJsS1ZidjlUR0k2WHZza2wrODErN05EM2dPNUVv?=
 =?utf-8?B?aExsSXhqcUNvZ2ZmODNEeEJNTmNMbkJadUZyaE5YbStGeUlWZmxWU1JaSitu?=
 =?utf-8?B?cGxlVjZlU3lQc1J5OFJNNnpPbzVWZUZzUEw1aU5YdC9pQzBWaVlZVXNYSlAy?=
 =?utf-8?B?NXhRYU9Gck9heVNQeXBDS2tyWmVmUTk5TytiNVUxYVlGWGN2ekxObGlaOEFG?=
 =?utf-8?Q?Z2YF1bCkhJ7NQShVRdvanislP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR07MB9711.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk9QSDRhVDZMaStmSC9ZUW1kR0x4KzVCdythU080Q01lWE1yUEErMmlXT0h2?=
 =?utf-8?B?dDVOOC9RdDF3SkFGOEoxanovb0xDT3gwVTdXaVRxWEFsT2ZMN3NkamR4MDd3?=
 =?utf-8?B?UWNQZzlDeXlPdFA4OCtvNXVEK09XYzEzZEhOUGZ6a052a0YyUlNnalBGZEdv?=
 =?utf-8?B?OHg0STlYYjh6MWFienUwSzd0dktVVGJhVllpSVlUUmV3YkVDcGF0M2ZmN1Mr?=
 =?utf-8?B?czFRMmpwSExJTElDQ1d2OUlRVHNMczNsMDJqVjRPWERPWWEvVUY5aEpUNXd6?=
 =?utf-8?B?UjhqN015ZU9DbVpNd3NLanpKN3FFS1VWZjhJc0ZqQldjdEV5Y1RHOU9XTU1M?=
 =?utf-8?B?YzZncE9pNmh2Q0hQZ1hsSDhMNWRFSXRTQTR4NFlpbGpDb3lJcUxpZlFkYmly?=
 =?utf-8?B?akdqRWpDOW5LMk5HSnIxemJGdE92bWVKbWdqYXlabVBrTjYrZ2xFWWdHZlhS?=
 =?utf-8?B?TXVRS2VDbW1GQUh0MWYrcjQ3WjRwTGFnbXVQdlhlU2RyUzRTMysvWlBNZ0ZZ?=
 =?utf-8?B?aWUrV2owL1U3RlBLV3YrMHRzRy96YWdZaFFZTEJnNlh5RThDQ1BSMUMxSmZS?=
 =?utf-8?B?TGFKdTVmY1o3MHlmYXRPR29FdFMrK1I5VkpnNmIzY05YMVhVeUVOd2ZKWWln?=
 =?utf-8?B?SXNGZGlUQUlBMnowL3hObnFIUFZMSDJDY1hwYWUveXpqNWd4bnFkQmwwRXhV?=
 =?utf-8?B?U0xIQWR3YVJiY2RPSmFEZU1PbHJGWUNIYnRqb0srRU1BYk5TRnhEVzFVdXdk?=
 =?utf-8?B?aUxKaVI0dW9PU3Y1N09OSkV0NS9WVk1keGI4Z3czWUFqbkQyR0dQUXV4YnJ3?=
 =?utf-8?B?ek9idU9mVU9hUnJWRHA5Sm9FcFYrOGVtSllFM3RKcGJlY2dHa1FwcnUvSEc3?=
 =?utf-8?B?TzNadDJuWDVqYkpnc1EzK28wTi92cVZ2TmxjanUyZ2RXNzNERW94NnZFbWdl?=
 =?utf-8?B?WkFnNWJ3RzNXcFRGNGduNnErTzlZa3cwMFBLQmNxL080dlRsV2ZmNHI0OHVy?=
 =?utf-8?B?d3hFakRGWDlaZC8vRk5jbzBTMytXY2RzTnhWTG9EVlo1VGVQQStMWkF3SlVH?=
 =?utf-8?B?ZW9uUGFtU1ZsR3VHM1BTaHlwazZIeE9OR2ROb3lWUHhsRW15dVMrV1N0cU1x?=
 =?utf-8?B?aG02ZWRaRWdTRExRaHdBb2ZmaEdYSC9qRU5hMTNrMGhibGtrQ2ZaRmRjTmxq?=
 =?utf-8?B?clpGQ2tNdHBmMDdONWpxaURRZkJ4VUVEYU9QM0tZbW5OVEVKa1JVQnpqYWth?=
 =?utf-8?B?WTdBN1hjOE1XY3o3c3FodnlSUnNDK0owbVQ2aWNGdHVidFJVMjRNV1RMZEFw?=
 =?utf-8?B?YzJMMzdMb2MrMjVrcFpGSGVRbktwMmxIVkhaSkUxdE11b2Q3MnVha3FHSGM2?=
 =?utf-8?B?elRPNU9XL1FUUzNIc0NBcEl2MWVzQmJoMUVEd3lka09kWlB4R3F4dlB1Y09j?=
 =?utf-8?B?Rm96U1VZTDdTcjgrSWVxMkJ2OVhLV0lyc0tYTElmRWNsSU55ZVY4VGZJbE42?=
 =?utf-8?B?bERsUnpUUGc5UWdjbmxsUnNVVjVSRitpNVFYc2ZjYjVLNmNUeDhHS2JlS052?=
 =?utf-8?B?QUxaZ0RtenNWd0pSdWI5RDQwaVFXMFhTYk14LzdlNHlPK1pDOGJrVVRsVGVw?=
 =?utf-8?B?emhCR2tUWTVlY1REOVB2Ky9DbGJvYmJqWWFQVW5VOFIzd3J5OExRRlBmbGdj?=
 =?utf-8?B?Um1yRjZZMUhlVlNEUk1ldStnbTNyV0ZyQ2ZpMHNmWmNYQTZMZGJQSE0yUjZT?=
 =?utf-8?B?U1AzeDB2OG15M0FJdVNqcjkwcC94VTgzY1E3enJHS1Jva3JQeXFEb3BUUzFN?=
 =?utf-8?B?bmZwaTFVaEdhTlpQYXZ5OEJOVWwwcytXdXY4dzljTGhxL2kxK1hiL3ZhMDZ6?=
 =?utf-8?B?VVFwMjY0d2FUdzZOTHhIL3QzUEpLdGYxN0dsTW1QRlBNU3o1WHNRd05wOUNi?=
 =?utf-8?B?Mm56N1dFdUJ4RWMxZW9JL1dhWFBuZGZHdTBkalRzMmdCY3lVaER6bDFyQTFn?=
 =?utf-8?B?ejJhaFE1L0V2YW9SWHRnaTVpRk9tZ2JKRGhpWm5tZVd5d2tZNUxLbnVZdVl6?=
 =?utf-8?B?SVB2QlFpcmo5TmRuS1JmeWlZNDlOZGhtN3lyV1BaOUpLSTVoZmhFVC9xVGJX?=
 =?utf-8?B?OFFHR1gwbS9WL1JoMFNQd3Z4alc4WEc1ek95NHRobCtFYmZ6bWE5RXl4aXVE?=
 =?utf-8?B?K3hLUi9UTkJRTE00QytYV0hnL3FwRE53aUpTUWVtZE5XUGVYbU5jMUVpZE8z?=
 =?utf-8?B?VjZiSXFJbFlsZ0U2ZkJNS1NzSEFURkQyMlFZL1JEMThWTnpVRnVaakVVcnZs?=
 =?utf-8?B?ZmxmSjBFcVJ0M0dudDBORWovanIxYjFwTjRaL25NL1lQUFc4VEJPeUx5SXZu?=
 =?utf-8?Q?4/oAY4Km5yH/sPsP8ozx3L5HQta2DnY7HH3sV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: novatechautomation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR07MB9711.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efddd98-c845-486e-4441-08de68b21c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 14:38:51.8672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb0f6598-d3e5-4ff3-a8b8-fe893d304059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSfjuj9J2HX94xGmmITp6mtcCskYpT/wgpCL30Ob63eAUOvZieZyFy3YwKnu+Fex3Tg5sPI5TQSwTzBxpOrUbIaAhRd/OrnniSbeerXgotbxcWrY0Io4YcWhPKW7IU+vBx9mFOhGiwfSDlF4/6CDsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PPF24649D10F
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

SGVsbG8gU2ltb24sIFRvbSwKCjEuIFRvbSAtCj4gQW5kIHdlIHNob3VsZCBzcGVsbCBvdXQgdGhh
dCBkZXZpY2UgdHJlZSBjYW4ndCBzZXQgdGhlc2UgYW55IG1vcmUgaW4gdGhlCj4gY29tbWl0IG1l
c3NhZ2UsIGFsb25nIHdpdGggc3BlbGxpbmcgb3V0IHdoeSB3ZSBjYW4ndCBkbyB0aGF0IGFueW1v
cmUKPiBzYWZlbHkgKHdoeSBjYW4ndCB3ZT8pLiBUaGFua3MuCkkgd291bGQgYmUgaGFwcHkgdG8g
bW92ZSB0aGUgY29kZSBjb21tZW50IGludG8gdGhlIGNvbW1pdCBtZXNzYWdlOgogLyogTk9URTog
VGhpcyBicmVha3MgdS1ib290IGFiaWxpdHkgdG8gc2V0IGJvYXJkIG9wdGlvbnMgdmlhICAgICoK
ICAqIGRldmljZSB0cmVlLCBidXQgZ3VhcmFudGVlcyBzcGVjaWZpYyBrbm93biB2YWx1ZXMuLiAg
ICAgICAgICAqCiAgKiB5b3Ugd291bGRudCB1c2UgYW4gdW5pbml0aWFsaXplZCB2YXJpYWJsZSB3
b3VsZCB5b3U/PyAgICAgICAgKi8KVGhlc2Ugc2V0dGluZ3MgY291bGQgYmUgc2V0IGJ5IGRldmlj
ZSB0cmVlLCBidXQgZXZlcnkgZmR0ZGVjKiBmdW5jdGlvbiBtdXN0CnNldCBhIHZhbGlkIHZhbHVl
LiBJZiBhIHVzZXIgaGFzIHNvbWV0aGluZyBzZXQgZGlmZmVyZW50bHkgdGhhbiBjYWxsZWQgb3V0
IGluIHRoZQpGU1BfTVI1IEludGVncmF0aW9uIEd1aWRlIHRoZSBib2FyZCBzdGFiaWxpdHkgd2ls
bCBiZSBjb21wcm9taXNlZC4gTWFueSBvZgp0aGVzZSBzZXR0aW5ncyBhcmUgY28tZGVwZW5kYW50
IHNvIHdlIHdvdWxkIG5lZWQgbXVjaCBtb3JlIHJvYnVzdCBlcnJvcgpjaGVja2luZy4gVGhpcyB0
YXNrIHdvdWxkIG5vdCBiZSB0cml2aWFsLiBCeSB1c2luZyB0aGUgc3BlY2lmaWMgdmFsdWVzIGNh
bGxlZCBvdXQKYnkgdGhlIEludGVncmF0aW9uIGd1aWRlIHdlIGFsbG93IHVzZXJzIHRvIGJlZ2lu
IGZyb20gYSBkb2N1bWVudGVkIGtub3duCmdvb2QgY29uZmlndXJhdGlvbi4gTWF5YmUgd2UgY291
bGQgc2V0IGFsbCB0aGUgdmFsdWVzLCBhbmQgdGhlbiBjaGVjayB0aGUKZGV2aWNlIHRyZWUgdG8g
c2VlIGlmIHRoZSB1c2VyIHNwZWNpZmllZCBhIGRpZmZlcmVudCB2YWx1ZT8gSWYgdGhlIGRldmlj
ZSB0cmVlIGRvZXMKbm90IGNhbGwgb3V0IGEgc3BlY2lmaWMgc2V0dGluZyB3ZSB3b3VsZCBub3Qg
d2FudCB0byBqdXN0IHNldCBpdCB0byB6ZXJvIGZvciBleGFtcGxlCmFzIHRoaXMgY2FuIGNhdXNl
IHVuZGVmaW5lZCBiZWhhdmlvci4KCkVyaWMgU2NoaWtzY2huZWl0ClNlbmlvciBFbWJlZGRlZCBM
aW51eCBFbmdpbmVlciBJSUnCoCDigIsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KRnJvbTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+ClNlbnQ6IFR1ZXNk
YXksIEZlYnJ1YXJ5IDMsIDIwMjYgMzoyOSBQTQpUbzogVG9tIFJpbmkKQ2M6IEVyaWMgU2NoaWtz
Y2huZWl0OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsgYm1lbmcuY25AZ21haWwuY29tClN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8yXSBGaXggeDg2IGJheXRyYWlsIGJvb3QgZmxvdywgVVBEL1ZQRCBVcGRh
dGVzCgpIaSwKCk9uIFdlZCwgNCBGZWIgMjAyNiBhdCAwNzoxNCwgVG9tIFJpbmkgPHRyaW5pQGtv
bnN1bGtvLmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1bCAxNCwgMjAyNSBhdCAwNDowMjo0OVBN
IC0wNTAwLCBFcmljIFNjaGlrc2NobmVpdCB3cm90ZToKPgo+ID4gVGhlIFZQRCBoYXMgYmVlbiB1
cGRhdGVkIHRvIGluY2x1ZGUgYWRkaXRpb25hbCB2YWx1ZXMgZm91bmQgaW4gdGhlIEludGVsCj4g
PiBGU1BfTVI1IEludGVncmF0aW9uIEd1aWRlLgo+ID4KPiA+IERpc2FibGUgTVJDX0NBQ0hFIGZv
ciB0aGUgYmF5dHJhaWwgcGxhdGZvcm0gYXMgdGhpcyB3aWxsIGJyZWFrIHRoZSBib290IGZsb3cK
PiA+IGFzIHdlbGwuIFRoaXMgaXNzdWUgaGFzIG5vdCBiZWVuIGRpYWdub3NlZCBmdXJ0aGVyLCBi
dXQgSSBzdXNwZWN0IGl0IGlzIHNpbWlsYXIKPiA+IHRvIG15IHByZXZpb3VzIHBhdGNoIGFuZCBy
ZWxhdGVkIHRvIGhvdyBtb2Rlcm4gR0NDIGdlbmVyYXRlcyB0aGUgbG93IGxldmVsCj4gPiBvcC1j
b2Rlcy4KPiA+Cj4gPiBQYXRjaCAyIG9mIDIKPiA+Cj4gPiBVcHN0cmVhbS1TdGF0dXM6IFBlbmRp
bmcKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNjaGlrc2NobmVpdCA8ZXJpYy5zY2hpa3Nj
aG5laXRAbm92YXRlY2hhdXRvbWF0aW9uLmNvbT4KPiBbc25pcF0KPiA+ICsgICAgIC8qIFNldCBh
bGwgdmFsdWVzIHRvIGtub3duIGdvb2QgZGVmYXVsdHMgYXMgZG9jdW1lbnRlZCBpbiAgICAgICAq
Cj4gPiArICAgICAgKiBJbnRlbCBGU1BfTVI1IGZpbGU6IEJBWVRSQUlMX0ZTUC5ic2YgICAgICAg
ICAgICAgICAgICAgICAgICAgKi8KPiA+ICsKPiA+ICsgICAgIC8qIE5PVEU6IFRoaXMgYnJlYWtz
IHUtYm9vdCBhYmlsaXR5IHRvIHNldCBib2FyZCBvcHRpb25zIHZpYSAgICAqCj4gPiArICAgICAg
KiBkZXZpY2UgdHJlZSwgYnV0IGd1YXJhbnRlZXMgc3BlY2lmaWMga25vd24gdmFsdWVzLi4gICAg
ICAgICAgKgo+ID4gKyAgICAgICogeW91IHdvdWxkbnQgdXNlIGFuIHVuaW5pdGlhbGl6ZWQgdmFy
aWFibGUgd291bGQgeW91Pz8gICAgICAgICovCj4KPiAvKgo+ICAqIE11bHRpLWxpbmUgY29tbWVu
dHMgbGlrZSB0aGlzIHBsZWFzZSBwZXIKPiAgKiBodHRwczovL2RvY3MudS1ib290Lm9yZy9lbi9s
YXRlc3QvZGV2ZWxvcC9jb2RpbmdzdHlsZS5odG1sCj4gICovCj4KPiBBbmQgd2Ugc2hvdWxkIHNw
ZWxsIG91dCB0aGF0IGRldmljZSB0cmVlIGNhbid0IHNldCB0aGVzZSBhbnkgbW9yZSBpbiB0aGUK
PiBjb21taXQgbWVzc2FnZSwgYWxvbmcgd2l0aCBzcGVsbGluZyBvdXQgd2h5IHdlIGNhbid0IGRv
IHRoYXQgYW55bW9yZQo+IHNhZmVseSAod2h5IGNhbid0IHdlPykuIFRoYW5rcy4KCkFnYWluIEkg
YW0gbm90IHNlZWluZyB0aGlzIHByb2JsZW0gd2l0aCBtaW5ub3dtYXgsIHNvIHdvdWxkIGxpa2Ug
YSBmZXcKbW9yZSBkZXRhaWxzLgoKUmVnYXJkcywKU2ltb24K
