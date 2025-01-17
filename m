Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05422C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 06:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C6B08069D;
	Fri, 17 Jan 2025 07:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BGs9/ikj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5304806D8; Fri, 17 Jan 2025 07:49:30 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4234280312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnNu1cG4F3AGL66Ib+lH7r/rTGecEiCWJ4t7ir9mcdxOQk4K1vZScywN0a41Eq2YDkNqeNYQo8K1A/4AE+qoIiHE8bxbzVywIZ3EgU9e8Iqq1KlJVyN2CxZdTMm5B0/0HvhSGZDJpe9RyOrY0b4f1k6s/sP19XQfqSehI+HaXggtdCJlgxkGXz4IZmDqKarxBC5Z3LgXzgc4UKGImfMGqBB7K1o59QRxrLPOSLHdg38/OIY5fa9AJnFtzKQUh8Cxg+1oTuAUokzxoiszAjKTQ/0CyhWIShCDQpXruunncCVMUvQjdq6MIY+3HV+kow7Ih+YbfxKFPGMwyk4Q/Im+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPv9PQpXspjyI3R8SRG2nBIztgw/p7yy1ShbTSw8nqI=;
 b=LknilELQWpvfSOX8YH7CqRuoUEdO5Y5lcoFTTIATdO1IGF/0N3oUQhpw98bHUwJG7JjoN5GEdqqL3PWy9X2nvG539cC8UKxoWNll6G1i41hqBFHXcfq5l+Kqu3KZ0Qevs3dkucN3siVh9CpXmzbcPrE5O/pLgkb5oHkLwdkJeMZzAQ8PoYuBXpZ7VTeYb11fa9KQ3mmBWjhR95DmTKrzOXJ0IipjWiZzyYPGUTq5bYVMWvZ536r21e9OQGKAOSocYcVfFDZttdokcZSZCCRls5rVaO2vy908GYRlW17W7wg6YPQY1SRy+gZc7pXwt5AYvV9NGZukhfjo/HSpOAT6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPv9PQpXspjyI3R8SRG2nBIztgw/p7yy1ShbTSw8nqI=;
 b=BGs9/ikjmpwAcVKhM0blZEEP85AvAqC6MvNcyVEZFJ7+fsYCajfAty5Z5+8wS40t8SChMADxDVdGK7uTmY4u1AB1FvPrtCBGKt7M77Em+WaA9anhF4pw5IQESgfCY9UQQ9GXO2LkRJiUesSjV74kZdb8fZdPkPZKosGWr5UwKPUQaJ/xzNOo+yxs3xgKb6MTQ/bAbnCp3sChljzvkGkz/9MCmjfDUtk2w3qpAe2WdpssIImjNP6o/XFwK4kRS6rQYZfV53TFHU+UIjbUet+571Hpfri6IoAF+YR/ij0NINz0mcF1Q24rzYREu9aGJDmZSK3393pw2N1HmX9Fnxjfuw==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by AM9P195MB0998.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 06:49:26 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%4]) with mapi id 15.20.8335.011; Fri, 17 Jan 2025
 06:49:26 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
CC: "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "manut@mecka.net"
 <manut@mecka.net>, "trini@konsulko.com" <trini@konsulko.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, Yashwanth Varakala <Y.Varakala@phytec.de>,
 "sbabic@denx.de" <sbabic@denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Teresa Remmet <T.Remmet@phytec.de>
Subject: Re: [PATCH v3 1/6] arm: imx8m: add OP-TEE node
Thread-Topic: [PATCH v3 1/6] arm: imx8m: add OP-TEE node
Thread-Index: AQHbY1wxLzFFVPwhVkul8iJG4hU52LMaCeOAgACHRoA=
Date: Fri, 17 Jan 2025 06:49:26 +0000
Message-ID: <b134615f2061a2c843a7a76d024e2c57b55637e2.camel@phytec.de>
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
 <20250110-phytec_imx8m_optee-v3-1-6c39dab15592@phytec.de>
 <CAJ+vNU24PA3S3aEu5CjyECaF0aKKvbs7svHVuGUyHFA08NObOw@mail.gmail.com>
In-Reply-To: <CAJ+vNU24PA3S3aEu5CjyECaF0aKKvbs7svHVuGUyHFA08NObOw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|AM9P195MB0998:EE_
x-ms-office365-filtering-correlation-id: 722d839d-5de5-4d64-a339-08dd36c31562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXBmQkJUWFFlaFFScXA2d2RTbTU1SG9xektBVFoxQ0RtNDREd2sxN3k4ZXU5?=
 =?utf-8?B?S1F2dVRKL1VjejZRdk1FVWp6anptd2txcHhXc04wTXBsalhPWkNFeFJ0N0pW?=
 =?utf-8?B?MFFMcHV5WUJpNER6VFJZaWFqbzRhM3hQQm5McFRvVEdwQzVMUUhudmdSWkcr?=
 =?utf-8?B?VTc5K013R0t1RERLcVNsN0JtczlEcjROaEF1aDcyQ00wR21NUWtieUdlMkhy?=
 =?utf-8?B?SG5QUkgwME5GUWIzWVZON0FXdWkwMmZMRzhWaVY3ZDBHNHJEaURnZHh6eTVU?=
 =?utf-8?B?N3gxRUJ4TzFDS2UzS1dwcng0SWtsWWNnOFVmU2NMcHUwVGpaNzk2Slp4Z0ky?=
 =?utf-8?B?WDY3bklBM0UrYWZkS1EyaU9rbDI5d3ZiU0d6UU5yOWs2S0JQNTdEaDljam9O?=
 =?utf-8?B?NDJOendtVGdTQ1FGUklNMGYzeW5kRVdoZWxCTjc3eVlESHE2N0pSRy8wTTlV?=
 =?utf-8?B?TFRVUUJkYUtpOFYzVktQWUJOcGRMaVdjbTI5bWJDZDRwKzJOWVBQVVZnT21X?=
 =?utf-8?B?OHlRTkt0ZDhGS3Z4K0xtd3I5OWxzSVk5ZFc1Mzg1OHM2Qk8ySnhLeEluU2lQ?=
 =?utf-8?B?eTV0NVpGWUFWZmZaOFR0c1ZwaE1GeDJuUVlaQUQwYXRYaTJ4Vm80WjVjWnBT?=
 =?utf-8?B?ZVhCa2VWWGNmMGdZd29YYXkyYlZvSHJoWWRaS01oQnRkcVVoVVAwS3pnMkQx?=
 =?utf-8?B?RFo1bk1OaENKVWNGdmQ4cEtUUjNhMEZYa0x3Nkg3NFNnMU9EbEt2SlRxbUpR?=
 =?utf-8?B?eklUSHhqNTI5SFdKcDArK09zQ3VPWUkzZmlmR2FhTHNaNy95UUZFK2xYOGJ6?=
 =?utf-8?B?bU02RGlOR2U3ZEJZQ3NRL2ZiWjdJUnNKdUJIYW52eDN0dDdTNTNnWGtEbEVC?=
 =?utf-8?B?elJBNnNDSm5CeElJMWhzTkx1STJGWkNldVFVaVpyNFhqV2haT00xUW42K3I0?=
 =?utf-8?B?UEl2SThJd0x5U08wVUlITHdFREJ6VWh4Zk1HUEUrUmh1aTluM1ZMRjFFQk4z?=
 =?utf-8?B?UUZvaGM2Nnd6T0N6SU95VkwyMG1vZEF3SmNmTzN5ZTZpcFhoWWtWV3ozbmJ6?=
 =?utf-8?B?MGIvVFNEZC9PNWFLVlNmNjlsdXY0QjNodWltdjNPdnYxekovUUVhU3dNOTdP?=
 =?utf-8?B?L3RRaG9rUWJreTBBRXlEQ2pkS2JrVzJsa2cvV1dQTG9wY2dQN3V4OTlQTVhW?=
 =?utf-8?B?VjV3SWowd09CdXNPMWZRMk12L01IcjZlWVlDVVVFK2lnNmxNSm8xTmM1RFlB?=
 =?utf-8?B?TnVBNGsvT05DRWYweFFDM1FtdTRDdm1UaTE1aS8wY1NwVG95ZWJSSW10YU9u?=
 =?utf-8?B?eFdNZ2FtdUNwZTYzdlFzeE1Tem9iVVZnSWdwTWd4L1hkUHdycnNNTjQ0U29s?=
 =?utf-8?B?SUdwbzVvTldwV1VSQVZqUkV3WG9ZYjRsNjFwek5TT21VT0RXRWdldkU1L09v?=
 =?utf-8?B?ZjlsbDk5aVgwNU9Qd2s3aTVxanRiTEhPbkVsSEFEa0hzYXhnaW15SjI0M2JW?=
 =?utf-8?B?cUxrdHFoa01wYzJRRmtZYXZLekN4UWl4dnBnMjlucUJRWHY1enJINW55aTlH?=
 =?utf-8?B?cUJxZEYwU0ZtZEtRZk1mblVRc0dram82RjdCRnArMVY5ZGJvRlFTU28wRWFK?=
 =?utf-8?B?Z3FFWDRwV3YwY0srbU1YdzBxNElHS0sxeVliWklOVmNoaFhBc2NMaTNVRnRB?=
 =?utf-8?B?WFMzZXpwSFlUYzFZb3FDVGFhY2J0a2VGQXcySUhpTEo4ZnNqMkhCMEQxbWlq?=
 =?utf-8?B?RFB4bmtaV3kreWlpMC90WDFPcjk3akJPWC81VnAvajdSNnU4alhqaXpiRXRv?=
 =?utf-8?B?dlZMZCswek5sczkvMWwrNGpkQWRTRzlBZE9QcUNYbXVvWkhHQVRnZ3ZHUmNH?=
 =?utf-8?B?TXF2TXkyWnR0ZW0xbWQ4RXI2MisrWG5vOXh3OEhtbjRMY1R2YUN5UEx3K1lH?=
 =?utf-8?B?aXp3NDdlUDVvR1RZVFh4OUtJUlk4ZHJuZTVFVkxHSitwQlVhd3hXTnB4eFcw?=
 =?utf-8?B?T09FVVVQMTBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnJQQ3NOa2liaW5TcnZxQVFHaUhxUWpya3hXWE5ScS9ZNlRhZEtSaXN1U0pW?=
 =?utf-8?B?S0F1eHlqNVdXWVVEQUt6bzN2c2tDLzBTdHVzeE1Yby9wTCtxWkYzaVdHNW5H?=
 =?utf-8?B?MmdhQ3AvMit0VUZMdWdXb0RNU2NWbWorWm40dzMxcmdQUTNpYXlNRVhMVXhK?=
 =?utf-8?B?WkNFS0J0OWlqejlTblN6Ui9ITkJVTS9MUjE0L1N0enB4MHVDOTd5b2JySFpt?=
 =?utf-8?B?d3dhVWFzV3J1Wm9IY1pkR2ZEMXFhTlNpdWl0R0swMVlCR2ZNWkk5d2RRcFN5?=
 =?utf-8?B?TWw3Z1duYUw0UkJLMUhxRmMxNW9JWWZlZFB4blZjb0VJZldOcW12dFplV1dB?=
 =?utf-8?B?ZmlwNjJBRG1QcFd4b1ozdG9rYVN6MzNyMXdsRER0MjZHYzVoOU52Rkd2VXk5?=
 =?utf-8?B?OUFOd05mcWxibVNpTGFJL21aZXN1UUVLb0grMVF1MVF3cm5oWEdtd29uNE5q?=
 =?utf-8?B?Y2p2d0lESzFSZkVqSzduc3BCdGN4b2NielBHSDVlQ3I3c1d1bzVRWC9sQmJl?=
 =?utf-8?B?eVhLTzlHMk8xb0FYVmp5S3YzaUxjNG5WQktISWIwdG90K2xYZjE0QVdDZEJ3?=
 =?utf-8?B?UWR5c29RYzNkZ3ZpNzZ6ZW9CdjVnS3pCSWtHUG1CZWVLeVhnbk9udE5jRVBM?=
 =?utf-8?B?Y1BibEpjcTcvOWVlaE5DL3ViaTZDMDRuYmhITEZ6VHJlc2w5UG55NGtSVVhN?=
 =?utf-8?B?S3VwR016Q3pOeEp3NXpqa0VTU3FXbklid2tYSncvR3BrZUx3TVNCRFUrdDdH?=
 =?utf-8?B?Zy9vblFzYXlTSVdyRGFqT3doYm5zc05QblpwUWtWOFRPd3lDR3A0ZWpETzB3?=
 =?utf-8?B?YmxzUUgvdDhwc1pVNVVMdHNUOW5zeUNLZE8xQ281a0dlYnZIN3BROVdvVWoz?=
 =?utf-8?B?a0M5cDZlZXg2VkVZeWkwN2ZYWjNDWDFIa0lnMGlrbDkzaTF6Rk40UURITHhI?=
 =?utf-8?B?TzR2TUI4a1lZU3ZzUmxjVDA4OE5vZzd0N043b3pkeEcvbHkzUEZIaWdKek9u?=
 =?utf-8?B?T3g3OHZNdVFCZXAxVUJJMmdPd1RTalVJN2ExMHVBR1hvUFFWVkVYcDVHSFJT?=
 =?utf-8?B?RmFYOGJ3NDFIRkZZQXRWRUJ5bGlzLzRiUldzNzI3V1BBZGxjdXBNSmFSOXhm?=
 =?utf-8?B?UUpMMzNqUDAzcGdwN0FOZDRHN2Zmem5aY1VMTmFkc1diUGZtQUljSDBlNzhr?=
 =?utf-8?B?bVdqWkc2T1d3S3AzdWwzb2hXZzVIWkszc1R5SjBZSlJEV2I5Y09qTnV5cng5?=
 =?utf-8?B?MERFV0tjNXZ4aHAzMEdab0t3WU16WWNBMkcrT1dGQjhZY2NUM3g0QU1DcEVa?=
 =?utf-8?B?OGZFblZ1VW9ucGxOZm5RdFM1VnkyTjJLT3VZWVRoTXJUR2czOGcyTGV2cUhw?=
 =?utf-8?B?L3o2RWFYVHNNeVQ3KzBYS2xRS3dXWWZETmlrZlloTi8xWkFDRXl3QTNpWlZT?=
 =?utf-8?B?ZktPaDJ3YkRPTmR6Y3BuYVIzRUl0aUJFQlNXcVpFY01jVFNmVWhkeUJwL1hh?=
 =?utf-8?B?NGE1SjJmMk9DanZtZ29BSDhSM05EcWdEZEhZUnc5WHBGeGMzY2V4ZEFZNVhp?=
 =?utf-8?B?T3ozL1BkdW5tTzhGNGdqaEdjZC9YSG9KUVR5Yll6bzBXQTRuQ2ROSmhEZGdE?=
 =?utf-8?B?RHpwbTB4bThsZG5xc1dIYjFLVXcrVGZBRjVWMCtJWmkwbzBvMGJRN09KY1lB?=
 =?utf-8?B?ZVppSHo0L3RWOENOaGhXNU9COERZRXZCZUlIQ0dQbmRhSEcvYXJDU09LVkZo?=
 =?utf-8?B?bDJJUllOMDFDTWJJUUU5Q3hqSUNXMnZ0cW1xL2t1S2lEZ2JLdjBVaGpTMURp?=
 =?utf-8?B?enZ6Tk9XRmJicERoV1JUS1pQMWhhREozS3IzakRXZzEwVk8rQ1FaZFkrc2p2?=
 =?utf-8?B?WjduRnpSdHBZRG0wT1VXdHlTdGczZTlTRG5mM3hObHhQQTVmU00rQXhsaGNV?=
 =?utf-8?B?SGliQURGVFV1Q0JuVnBURGEvNEFQVUh0SUFrd2JsZXlIdXlSMU9BbWY2SVJM?=
 =?utf-8?B?WFNoeWNZT2g4ODZPQzF3Y3NCYUtJUmZKR1ZqaWdpUXROZTM2VGJDNFlDcE5Z?=
 =?utf-8?B?MHhFdjdnc1pRU09BZmlON2ROZjVBRThUOXV3MUFBcFROTFN0VWpybHdQTWlm?=
 =?utf-8?Q?Q1g0FFYuCaJ6K1QhiIBdbaVmL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <206F5FF0013D344A8FAABA4701B8396C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 722d839d-5de5-4d64-a339-08dd36c31562
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 06:49:26.1616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sT3YwJmMJ1KiqoqXEcTCq0rHY5Ij9ROa0OI9BSEc06/g324+lU8bVoNtbDmv0A05UGxRB8IFgGODA6vgvk4DjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0998
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

SGkgVGltLCBGYWJpbywKCk9uIFRodSwgMjAyNS0wMS0xNiBhdCAxNDo0NSAtMDgwMCwgVGltIEhh
cnZleSB3cm90ZToKPiBPbiBGcmksIEphbiAxMCwgMjAyNSBhdCA0OjM14oCvQU0gWWFubmljIE1v
b2cgPHkubW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOgo+ID4gCj4gPiBBZGQgdGVlIG5vZGUgaW4gU29D
IHUtYm9vdCBkZXZpY2UgdHJlZXMuIFVzZSBhIGtjb25maWcgZW50cnkgdG8gc3BlY2lmeQo+ID4g
bG9hZCBhbmQgZW50cnkgYWRkcmVzc2VzIGZvciB0aGUgb3AtdGVlIGltYWdlIGluIHRoZSByZXNw
ZWN0aXZlCj4gPiBkZWZjb25maWcuCj4gPiBEZWZhdWx0IElNWDhNX09QVEVFX0xPQURfQUREUiBp
cyBzdXBwbGllZC4gVG8ga2VlcCBpdCBzaW1wbGUsIHRoZSBzYW1lCj4gPiBhZGRyZXNzZXMgYXJl
IHVzZWQgZm9yIGVhY2ggU29DIGFzIGFyZSBkZWZpbmVkIGluIHVwc3RyZWFtIHRmLWEKPiA+IChC
TDMyX0JBU0UpIFsxXS4KPiA+IAo+ID4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9BUk0tc29mdHdh
cmUvYXJtLXRydXN0ZWQtZmlybXdhcmUvdHJlZS9tYXN0ZXIvcGxhdC9pbXgvaW14OG0KPiA+IAo+
ID4gU2lnbmVkLW9mZi1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+Cj4gPiAtLS0K
PiA+IMKgYXJjaC9hcm0vZHRzL2lteDhtbS11LWJvb3QuZHRzaSB8IDE3ICsrKysrKysrKysrKysr
KystCj4gPiDCoGFyY2gvYXJtL2R0cy9pbXg4bW4tdS1ib290LmR0c2kgfCAxNyArKysrKysrKysr
KysrKysrLQo+ID4gwqBhcmNoL2FybS9kdHMvaW14OG1wLXUtYm9vdC5kdHNpIHwgMTcgKysrKysr
KysrKysrKysrKy0KPiA+IMKgYXJjaC9hcm0vZHRzL2lteDhtcS11LWJvb3QuZHRzaSB8IDE3ICsr
KysrKysrKysrKysrKystCj4gPiDCoGFyY2gvYXJtL21hY2gtaW14L2lteDhtL0tjb25maWcgfCAx
MSArKysrKysrKysrKwo+ID4gwqA1IGZpbGVzIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCj4gPiAKPiA+IAoKWy4uLl0KCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
ZHRzL2lteDhtcS11LWJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9pbXg4bXEtdS1ib290LmR0c2kK
PiA+IGluZGV4IGQ3YTgzYTc4ZjRkLi45M2UyZWYyN2Y3YyAxMDA2NDQKPiA+IC0tLSBhL2FyY2gv
YXJtL2R0cy9pbXg4bXEtdS1ib290LmR0c2kKPiA+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg4bXEt
dS1ib290LmR0c2kKPiA+IEBAIC0xNDQsNiArMTQ0LDIxIEBACj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfTsKPiA+IMKgI2VuZGlmCj4gPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRlZTog
dGVlIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXNjcmlwdGlv
biA9ICJPUC1URUUiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR5
cGUgPSAidGVlIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmNo
ID0gImFybTY0IjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21w
cmVzc2lvbiA9ICJub25lIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBvcyA9ICJ0ZWUiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxv
YWQgPSA8Q09ORklHX0lNWDhNX09QVEVFX0xPQURfQUREUj47Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50cnkgPSA8Q09ORklHX0lNWDhNX09QVEVFX0xPQURfQURE
Uj47Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVlLW9z
IHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZmlsZW5hbWUgPSAidGVlLmJpbiI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wdGlvbmFsOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gKwo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZkdCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbXByZXNzaW9uID0gIm5vbmUiOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXNjcmlwdGlvbiA9ICJOQU1FIjsKPiA+IEBAIC0xNjQs
NyArMTc5LDcgQEAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmR0
ID0gImZkdCI7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpcm13
YXJlID0gInVib290IjsKPiA+IMKgI2lmbmRlZiBDT05GSUdfQVJNVjhfUFNDSQo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvYWRhYmxlcyA9ICJhdGYiOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvYWRhYmxlcyA9ICJhdGYiLCAidGVl
IjsKPiA+IMKgI2VuZGlmCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07
Cj4gCj4gSGkgWWFubmljLAo+IAo+IEFzIEkgbWVudGlvbmVkIGJlZm9yZSwgSSBzdGlsbCBkb24n
dCBzZWUgaG93IHRoaXMgYnVpbGRzIHdoZW4gdGVlLmJpbgo+IGlzIG1pc3NpbmcgYmVjYXVzZSBz
b21lb25lIGlzbid0IHVzaW5nIHRlZT8KCldlbGwsIGJlY2F1c2UgdGVlLmJpbiBpcyBtYXJrZWQg
b3B0aW9uYWwuIEluIG15IGluaXRpYWwgc2VyaWVzLCB0aGlzIHdvcmtlZCBhcyBleHBlY3RlZC4K
QWxsIHlvdSBnb3Qgd2FzIAoKICBCSU5NQU4gIC5iaW5tYW5fc3RhbXAKSW1hZ2UgJ2ltYWdlJyBp
cyBtaXNzaW5nIG9wdGlvbmFsIGV4dGVybmFsIGJsb2JzIGJ1dCBpcyBzdGlsbCBmdW5jdGlvbmFs
OiB0ZWUtb3MKCgpTaW5jZSBTaW1vbiBzdWJtaXR0ZWQgWzFdLCB0aGF0IGJlaGF2aW91ciBjaGFu
Z2VkIGFuZCB5b3UgZ290IDIgbWVzc2FnZXMuIE9uZSBlcnJvciwgb25lIHdhcm5pbmcsCmJvdGgg
Y29udHJhZGljdGluZyBlYWNoIG90aGVyLgpJIHRoaW5rIHRoaXMgaXMgYSBidWcgaW4gYmlubWFu
IGFuZCBJIGhpZ2hsaWdodGVkIHRoaXMgdG8gU2ltb24uCgo+IElmIHRlZSBpcyBub3QgdXNlZCwg
d2Ugc2hvdWxkIG5vdCBnZXQgd2FybmluZ3MgYWJvdXQgbWlzc2luZyB0ZWUuYmluIC4KPiAKPiBJ
IHNlbnQgYSBwYXRjaC4gUGxlYXNlIGdpdmUgaXQgYSB0cnkuCgpJIHNlZSB0aGF0IEZhYmlvIGRv
ZXMgbm90IHdhbnQgYW55IHdhcm5pbmdzIHRvIGJlIGVtaXR0ZWQgcmVnYXJkbGVzcy4KSSB3b3Vs
ZCBsaWtlIHRvIGdpdmUgc29tZSBleHBsYW5hdGlvbiB3aHkgSSBpbXBsZW1lbnRlZCBpdCB0aGF0
IHdheSBhbmQgd2h5IEkgc3RpbGwgdGhpbmsgdGhpcyBpcyBhbgphZGVxdWF0ZSBzb2x1dGlvbjoK
ClRoZSBPUFRFRSBrY29uZmlnIGlzIGZvciBVLUJvb3QgZHJpdmVyIHN1cHBvcnQuIFRvIG15IGtu
b3dsZWRnZSBob3dldmVyLCB0aGlzIGlzIG5vdCBuZWVkZWQgdG8gaGF2ZQpPUC1URUUgYmUgcGFj
a2FnZWQgaW50byB0aGUgZmluYWwgaW1hZ2UsIHRodXMgSSBzaG91bGQgbm90IGhhdmUgdG8gZW5h
YmxlIE9QLVRFRSBkcml2ZXIgc3VwcG9ydCB0bwpiZSBhYmxlIHRvIHBhY2thZ2Ugb3B0ZWUuCgpQ
bGVhc2UgZ2l2ZSBtZSB5b3VyIG9waW5pb24gb24gdGhpcyBtYXR0ZXIuCgpZYW5uaWMKClsxXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy91LWJvb3QvMjAyNDExMDYxNTM1NDQuMTI3NzgzNS0xLXNq
Z0BjaHJvbWl1bS5vcmcvCgo+IAo+IEl0IGxvb2tzIGxpa2UgRmFiaW8gaGFzIG1lcmdlZCB0aGlz
IGFscmVhZHkgdG8gaW14L21hc3RlciB3aGljaCBub3cKPiBmYWlscyB0byBidWlsZCBmb3IgaW14
OG0qX3ZlbmljZSBib2FyZHMgYmVjYXVzZSBvZiBpdC4KPiAKPiBGYWJpbywgZGlkIHlvdSByZWFs
aXplIHRoYXQgeW91IG1lcmdlZCB0aGlzIGFscmVhZHkgYW5kIGlmIHNvIGhvdyBkb2VzCj4gaXQg
d29yayBmb3IgeW91Pwo+IAo+IEJlc3QgUmVnYXJkcywKPiAKPiBUaW0KPiAKPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLWlteC9pbXg4bS9LY29uZmlnIGIvYXJjaC9hcm0vbWFjaC1pbXgv
aW14OG0vS2NvbmZpZwo+ID4gaW5kZXggYjI1NGE1MGIwOTEuLjhhZWIxZWE3NWY3IDEwMDY0NAo+
ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1pbXgvaW14OG0vS2NvbmZpZwo+ID4gKysrIGIvYXJjaC9h
cm0vbWFjaC1pbXgvaW14OG0vS2NvbmZpZwo+ID4gQEAgLTM3LDYgKzM3LDE3IEBAIGNvbmZpZyBT
WVNfSEFTX0FSTVY4X1NFQ1VSRV9CQVNFCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgSWYgZW5hYmxl
ZCwgcGxlYXNlIGFsc28gZGVmaW5lIHRoZSB2YWx1ZSBmb3IgQVJNVjhfU0VDVVJFX0JBU0UsCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIGkuTVg4TSwgaXQgY291bGQgYmUgc29tZSBhZGRyZXNz
IGluIE9DUkFNLgo+ID4gCj4gPiArY29uZmlnIElNWDhNX09QVEVFX0xPQURfQUREUgo+ID4gK8Kg
wqDCoMKgwqDCoCBoZXggIkxvYWQgYWRkcmVzcyBvZiBPUFRFRSBpbWFnZSIKPiA+ICvCoMKgwqDC
oMKgwqAgZGVmYXVsdCAweGJlMDAwMDAwIGlmIElNWDhNTQo+ID4gK8KgwqDCoMKgwqDCoCBkZWZh
dWx0IDB4YmUwMDAwMDAgaWYgSU1YOE1OCj4gPiArwqDCoMKgwqDCoMKgIGRlZmF1bHQgMHg1NjAw
MDAwMCBpZiBJTVg4TVAKPiA+ICvCoMKgwqDCoMKgwqAgZGVmYXVsdCAweGZlMDAwMDAwIGlmIElN
WDhNUQo+ID4gK8KgwqDCoMKgwqDCoCBoZWxwCj4gPiArwqDCoMKgwqDCoMKgwqDCoCBUaGUgbG9h
ZCBhbmQgZW50cnkgYWRkcmVzcyBmb3IgdGhlIE9QVEVFIGltYWdlLiBUaGlzIHZhbHVlIGRlZmF1
bHRzIHRvCj4gPiArwqDCoMKgwqDCoMKgwqDCoCB0aGUgb25lIGRlZmluZWQgaW4gdGYtYSBpZiBu
b3QgcHJvdmlkZWQgaW4gdGhlIGJvYXJkIGRlZmNvbmZpZyBmaWxlLgo+ID4gKwo+ID4gKwo+ID4g
wqBjaG9pY2UKPiA+IMKgwqDCoMKgwqDCoMKgIHByb21wdCAiTlhQIGkuTVg4TSBib2FyZCBzZWxl
Y3QiCj4gPiDCoMKgwqDCoMKgwqDCoCBvcHRpb25hbAo+ID4gCj4gPiAtLQo+ID4gMi40My4wCj4g
PiAKCg==
