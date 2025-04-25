Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029D7C369AB
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 01:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B908809D4;
	Fri, 25 Apr 2025 03:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="kfrDZqRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFCB7810EB; Fri, 25 Apr 2025 03:13:01 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8AD8082A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ON0Ddg015768;
 Fri, 25 Apr 2025 01:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps0720; bh=fe/8FxZZD00skroqrlk6tQhQes
 PouSwSXyY+bbJow2Q=; b=kfrDZqRUZbB2Yks4Y6vfJHppztZ+dwHhHrcwjXxiti
 vxyCK9XS6naFJ+JcyldGGmZ5cljMP1QVmWImnCRxcnxzdcCZkmA2mvyLVo13zkso
 ByT6ijET2RnGsuVU6NRDeOskNa816HptyOVqlX7ttYOWQYIHfZhzd9Ooh7aISn9Z
 Zw6TEF3LtEN3dFOWet2daySbtM515OBQM0DDObJ4Y0X3XW8+LF6eCm9ytVsLGPBw
 O2GQFLPa9e5pgVmGxXgyhKWUoX9tTIOVh+ivnWxKjtYrL9oFo+9ColaYc7SIoKqf
 SWU+i++/Pkky5nVTHJkPvYDbKGgjnFL/gBKOVaVuFBQQ==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 466jjhe4sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 01:12:55 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 1330980045A;
 Fri, 25 Apr 2025 01:12:45 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 13:12:17 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 13:12:16 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Thu, 24 Apr 2025 13:12:16 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 13:12:16 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQ2e1GOfrQaFJtggeQS2zMb/rWWWaOuYKmBipkoclGzNOx5SHAOzWgQpQJo9UlLAFALy9n/YA1nL+X55n+PDTSAEBkRnkMXXNP5ZfgDEq6JOpAcVhWEUShbxsWeNrNhB2Q8pQLAUxYGW2KHd+Laj1vSMMoGEjA6EcGu3TEBrlNqxKVs1Km5c3iL52ofAZv1xT/YgPogne3BLCahiwxxwcgFLaJUpTr3V75ROr5SFNHMnn3AzfckDA77vYHHCAxTxUzgcHRPAoFN9UzDNfOu3wA27uM/pdDmkzPG3hM+enCqpcSwez0a4KtzEUWLxgLaMdQ8l4xPl5VJDxD+UQ7Zahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe/8FxZZD00skroqrlk6tQhQesPouSwSXyY+bbJow2Q=;
 b=NPrAug9K7ZARNp0FbAlKLwJVVYuK3zDaphDNPFhH3nfxZsZZy4izNxjZU3o3knmBFrG2glbixhHX3d1iuoA4JRYFLMGBBFTdhrIBoJ6zUvOphpdbVL46FSu1npJCcp6W+fYLMLLog2yZ9DnG8tdJxfB+7lncwzIrLvwRVEk0U/JJbpuTS5is+AyzPmiia5nEM34x9DHWhfxTvEAErZvTJYLgV2GyeSHytaAlC+7quU35ufytR9grSnFHHfT7yltTt+J110GAGuWAyIFou99oBQjMPQsv6uQLZ4NGToLGNqbbsMu58kmfQ53VS6yl9DvuwdtTnZ9XZhlIHdUV9iI9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 PH7PR84MB1485.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:150::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 01:12:13 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 01:12:13 +0000
From: "Verdun, Jean-Marie" <verdun@hpe.com>
To: Tom Rini <trini@konsulko.com>
CC: "jmverdun3@gmail.com" <jmverdun3@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/1] Initial support for Wiznet W5500
Thread-Topic: [PATCH v1 1/1] Initial support for Wiznet W5500
Thread-Index: AQHbtWH2ehgE41bbj0SsFq6Bc7n3CbOzfeUAgAAU6Go=
Date: Fri, 25 Apr 2025 01:12:13 +0000
Message-ID: <DM4PR84MB1976B25BCB895B1235186328D6842@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
References: <20250424214335.57230-1-verdun@hpe.com>
 <20250424214335.57230-2-verdun@hpe.com> <20250424235518.GQ5495@bill-the-cat>
In-Reply-To: <20250424235518.GQ5495@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1976:EE_|PH7PR84MB1485:EE_
x-ms-office365-filtering-correlation-id: a8e883be-b5fa-4283-01e1-08dd83963658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?R2ovWlhyN2hoWlkweURTQy9vT0tLbFhHNGN3VnRlSXQvTVFuWlRkQ1dzcVVC?=
 =?utf-8?B?bWo5Wk5HaTREdnkyQzRHdEI5QnliRkE4Vy9sYkJ2M3dwNXo2N3daOTdXdTJG?=
 =?utf-8?B?cXBjTUdzRmZmakczanRuV212Wnh2V0o0cGR6NWZnOW1UcmVnVFZSTCtRczZR?=
 =?utf-8?B?RTVQYWpCYjJSM2FheHFpRGlsWGJLeFcxemFLTXZWbStzeWVMdG95UzNsbHh4?=
 =?utf-8?B?cFRJRjE2RGNYa1ZQbUlRMHZReDArZ1VGRGtqNjNSMjBWaTBPTExJamg5YUhW?=
 =?utf-8?B?dTJaVHVrVGhDMlpaMFJqOGRiV0RzUmFZSkMwS1JTdHJQYTh3R21neDZ4clM1?=
 =?utf-8?B?WXR2ZEpIN2ZYdlFybUNJTG84MUx3cHY3RWdaZ2NJWnN0ZXdCbW9KK2ZPaXFJ?=
 =?utf-8?B?REFMZ3pWRm55TkNJRXBCNmhLS1pacTd2YW1vMnUwM2hvZ3k0N2VZU2g5VTVP?=
 =?utf-8?B?a093Q2NSVStha0lmNnB0eDh6cjg5OVFSVE5VVzVOQ1AwLzBXeVA5OEpjTlZD?=
 =?utf-8?B?aUdHNHQvcXY4MnIyNWFUeDU3cThsWjlQSis1dG5OMWhmS0JrQUFxT3JYQkJm?=
 =?utf-8?B?Z3JnQS9rMjZhU2lDVDNRYmZDY0haaE4ycTd0OERSYzhYWGtFUzRsUmtwb2tE?=
 =?utf-8?B?N1k1VUgzQ1cwVU5qTUdnbzRjMWhCOEVGUXkzZzhOZE83NlQ1bmtuOGFNbnFt?=
 =?utf-8?B?anUrVnA3cFJ6WHdwakdzY3FGV1pBWW4rdjcxVWlXSnhIV3d5Zm91dzAzMlFZ?=
 =?utf-8?B?SXp0WG5jVEtPYXJlZ3I0a2RGblZLamVPQldabk92a0JqMFZtdTgwbUNKUnNt?=
 =?utf-8?B?bDBQQkdXeVUrL3dXbk9YdTdrUnlueE1RUWdKbkIzcGR4NHRBUmk1Z1NuL0ZC?=
 =?utf-8?B?UEtScll1OXRvN1I0eUMzSmN4WGk3V0RRTnp0UDRWaS9IZ3RJeUVSYWl4MU56?=
 =?utf-8?B?VFJYSFRzVUgvRzFBRXFyTlZFTVBjR3Q1eExFbzNsZHlTY1dibXVRRDE4aWt0?=
 =?utf-8?B?L0luRUdha1ViWURlSVVwQlJKRGhvZ3FvZC9aNlkzamVrQlhiWW51VnNJcmRs?=
 =?utf-8?B?Y0cyeFNDWkJJcjBleVFNaVF4VldzNVVuS3J0emZvVnhCVDZLNElkdHlEcXYr?=
 =?utf-8?B?SkgzbjJKNGFzcVJ2SFIvcy94dSt0UFB1RlJ1OURMd2lMblRDNS8vbzNSWmEx?=
 =?utf-8?B?WGNWU0UxamFWT2ZIWWJyVzVSWnRYelNlcnlSM3pXOHVSU0VYL2V6TW9ObXk0?=
 =?utf-8?B?RVZ6T1FKWXlZSUVXZERtcnF6dktzR1RNNmpuT2s2a0c3VlhLQ1FqUjEzMnJT?=
 =?utf-8?B?NmdXL1BuUFR2dXFQYzI3UTBSVXpRMlJldnNwM1lOQ2NlejZmdE90MnkyOVJn?=
 =?utf-8?B?TU9RWFBZUWJVWXJzTDYzNnZVVzBraExoNW1UaXZRdEpldEVpVDRvKzBQWi9s?=
 =?utf-8?B?ZDB5VTdYdmFYemIyaDRndWp6ZUdtZis2QWtCUVR0OGRFN0V4UFdpVk9KYzdF?=
 =?utf-8?B?MXdrVGJKUzB5b0o4dlF2ZGQ2aEk1aXcrNWZhQkI2UmJaT3NGR2srTlo3UFNw?=
 =?utf-8?B?NXFmTWk0dU1Hd2RBNGhsblE4eENEZk5FeTVxYmVpK2JkandndENoa1I4UXo5?=
 =?utf-8?B?MkdXWWdvZFphSzk2Sk1XZTd4d0M1REZjMGR1Qm1KcUJBaHUrTGNBbVV1KzZ0?=
 =?utf-8?B?NCtEdXFHM0h6MDg0dkFmYW15QzE1M3l2VXBZWWpJTmJ0ck9jSDh0bWdVQjZF?=
 =?utf-8?B?WHIwVUxpN29aUWZQU2dyRXlDdnZpQWhMWjMyVVBTRTlDVXJkdllUbngxWnFL?=
 =?utf-8?B?Mm9QbjFaMXdjTTNBNzArRGxMQWJmZi9ybmhiaXppL0xtL0VFaU4rdHRzbEdX?=
 =?utf-8?B?dm9OMnRTZTJWWlQ4blNYaGZxN0E0bjlYdzR2NDhDc1MweU1UU1JLK3BVZGJU?=
 =?utf-8?B?QzVZcHMwdVVoZUR4cm13ck1PdDZmK3BVaVJzdzZhb0pyS1p3QThaZk1xWFR0?=
 =?utf-8?B?dWFrYklwMFF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjEyWmw2VjlZZ0dlUkdLWXliOFZ1R3pPTDg0Z2ZiSW43ZjlXckdlVDJNdFAx?=
 =?utf-8?B?SlJ2cUhpc3JNNUlkbGVacHBldEdtWnJnS0s5MEV0TDROTk9qWk1YU0ZWaTlk?=
 =?utf-8?B?U1RMSDRKT2JOTGZMQ1JzR1c4RTdhdmhONlZqSXVZWUxaU1VnNXd6ZTJhbVdG?=
 =?utf-8?B?cFB1Q1VFWnhEcVR3cC9CdmNJUE52MkIvUXBhYlN4eldIOXBSMnhWdVVXbjNO?=
 =?utf-8?B?Y1FSTkdXT1RxeUdlWVJSc01QdVFnQkprcm9zMTg2UnJQRUw1aklwWjJyQkxY?=
 =?utf-8?B?QlYrNzFPT0FWdXQ3M2VYbmRKUmdXM3o4UFNBbU5vdnhjaVh2NWZBdDRUNlBD?=
 =?utf-8?B?cEdDNW1hQnJSdUNJeGhWRnM2SnFiN3M2QVh1OGpkcVVkdGlXbU1WSVdudjUz?=
 =?utf-8?B?dlptRE5vS1RXV1ZxbG4wWVo1S09WcFZJOVRId2ZCeXNSdHdFM1pPZThtNnFi?=
 =?utf-8?B?aHhjdEdlVi8xMEwyVmlvODU4Z0lqR2NxenhKSTArZUp4cVlGbDJpaUptMFpj?=
 =?utf-8?B?bk5aMVcwUnEvNkg2Y2hPck1RdkFBRmNxRDVZdG9lemtxdGIxWVJLdUtGbkRo?=
 =?utf-8?B?eUdDalBPVGEwMWxGRGY0QkZjdytPQlgyVWdNRFBoWnFHU1drUUdNUVBHajRE?=
 =?utf-8?B?K2x1Q1BIN1hsZlhsWlJUYlBoWFM2Ym03c1hYaEloNGtnRHc2emlnUVg3K0Fj?=
 =?utf-8?B?VW5NR2VwR3JZblhMd21USHVWd2t2THFxaDRlSThZdlVtelZqeDkrbzQ4c2NM?=
 =?utf-8?B?bmhOUThCQk5BcVVZTVBxUG1VL01uS0M4RXBVWDVuNCtobGozQ2RHdUJMTVJV?=
 =?utf-8?B?UFY5Z25FWktzY1ZIUy9YU2pYNm1Iak11RW1TUFJBZUE2ckY5YWxLbHVLN29Y?=
 =?utf-8?B?N0FMZnFVUGZhZUp0YkhCRHErR2NrOEJOWXVSamx5NHBlYkdWSzhwelVXcUM1?=
 =?utf-8?B?eVpMTnJrZmlneHZxVEloMlhONUcrT3pPcjlRbWRXOUdvM056UHhYYTBkZS9h?=
 =?utf-8?B?Qk01SkZEaUlTZnd3WFpJZm9rTVU3ZjMvbnMxZFh5ckFDci9uZGlZVjBqNFVS?=
 =?utf-8?B?dDlZQ1FiczdySmIwUEpsNW9wNjRwZjNERG5TWHcxV1VDYWRPMUFUMGtlS0pL?=
 =?utf-8?B?ajhjMXVJYU1oN2RhVy8vYldYZ3Z2TDlOYS9oQUFsaktzaGFnMjEzZTR6b2J0?=
 =?utf-8?B?QWVPdHBiWGJKbUtxaUVkVER6MFl2cytQelgvaHhTUUVHVGhCRHlKK3FTU2xZ?=
 =?utf-8?B?Z2NuUHROZGUrSWhFMlRZTVVOazZKbjZVcFhQemdtK1dobU9XVEFRbHRYVUtF?=
 =?utf-8?B?amVrUkNNS1Y3NTVQM1hhM2ppeWE1bGZOc1BxeWRkcXUzaFFYWnpVTUNUZlZk?=
 =?utf-8?B?TGw3c2dxUlVOekN4TkxhMk9rL1VCZUN6S1UxYmk2eGg5dStQQmpuZzBnUlZG?=
 =?utf-8?B?eXFzSlVTOGVTSTdRV3ljZ3ErZnFvR3dtVkVrQjdxNlJ0MUhRKzFYc0xDYUVo?=
 =?utf-8?B?S2hVVUhKYWh4RUkrbk9LRXFLVVd1Y2lQblRKeHlGekhBK0w4UFJ2SGFsazAr?=
 =?utf-8?B?OTR0ZURsQzdTbDN4OUtoNFlxakNjTjRlMmlLS3ZWQW54TnVvV09OT2lIZzhw?=
 =?utf-8?B?aXZhMkJSQWNRTmlFVk5YWWtyQThFRkdlbWU3dHdyb3Jma1YrMzl3K0Nkanpk?=
 =?utf-8?B?Mlp5clptcEtGbDVnMGJPVkdkTi9PbEJUWVd6dDkwL0FZVlcwNGU0azhXb2xm?=
 =?utf-8?B?QTBrQjJwTXBoMDRaZkZaT25aYWN2M3lWMWUxK1lpbVdPVWpPQVZPUGI5dksw?=
 =?utf-8?B?cHZ1ei9kaHVES0dGa0JYcitYa3JjUXBiTDVHTm5SVzZ5TEZSRnMzU25xUDJT?=
 =?utf-8?B?NnBkc0ZKbzVPTG81QS9keTRCNkh1YjRmUFNmVzBwRGJxWG1SbkxFcXZ4TXdt?=
 =?utf-8?B?bWpPV0RmbnlQU2pmTllWZWdGeG5pRXJMQXV0cERxRlcycGJ4SkZEQWMwdTFN?=
 =?utf-8?B?SWpGNUhib2Exak5YdGVCUFVTU2ZPVVJYc1l2UlRXaGpGWUk4bzJhZm1FR2NL?=
 =?utf-8?B?TGpRMXJNVVRncVFsM1Z0cFhIU0xpRHF2RDJuTHRBTEUvVUlBK21XT3Q0d2l2?=
 =?utf-8?Q?fqZxOmUHNHDioyHicXFbv3DO5?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e883be-b5fa-4283-01e1-08dd83963658
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 01:12:13.6327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JatNKBCzzo6E1Rq7Oulyu2iDnuTkJJ5lbUNrAW6HhYdmcwOYYtX8L3oDyrgrB0C/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1485
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: JmNwck7yV8PuDRY1vDOqMNjDJJddNaxt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAwNyBTYWx0ZWRfX0BMygiRvypMu
 +S6mR79QV59O5sCqvkHHn/stgWS0oECtph9CVLyGLmQy/y8czwJssqw8TmkixY5VWRmpQZJy4YE
 lL6VPJLuGGGqpCVByVt3IRo/OW36SVPwC4lUEO6STNDPob92U2XRa+TfOwbhMapKgvyqqd+Zic6
 P1Z4yclvyEYKtAOAkA3fnDg7ZDbr0HRCZYDW/+MfMo313FHZ3rieC8s2VrH7ngzzuuKccmIYZpK
 zwKm3MCXWGwIoyJoW2sSVzzDfc/J8BURYl+3K9sFX0V6C8ZjOHkWHstsqNKJPSZAFJVDdl21Q8/
 sDbAmU1I/qqCKjJEx3a/pC57wkmW2x3gsspPO2uzj2xm3fQYYp/dah5w5ocfcXsr4y7AHuzzzXb
 qoU3803w
X-Authority-Analysis: v=2.4 cv=LpiSymdc c=1 sm=1 tr=0 ts=680ae197 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=XR8D0OoHHMoA:10 a=k-42gJp3AAAA:8 a=MvuuwTCpAAAA:8 a=Sx2EFBvE7cSJ4GHIGtoA:9
 a=QEXdDO2ut3YA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=HgXoxNPxa_RtVAKZa1YA:9
 a=d-SaV8vCNFUZ317c:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
 a=lqcHg5cX4UMA:10 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: JmNwck7yV8PuDRY1vDOqMNjDJJddNaxt
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 spamscore=0 clxscore=1011 mlxlogscore=698 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2504070000 definitions=main-2504250007
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGkgVG9tLA0KDQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2Vz
IE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/DQojNTE6DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
DQpDSEVDSzogQXZvaWQgQ2FtZWxDYXNlOiA8VzU1MDBfU25fUlhNRU1fU0laRT4NCiM1MzA6IEZJ
TEU6IGRyaXZlcnMvbmV0L3c1NTAwLmM6NDc1Og0KKyAgICAgICB3NTUwMF9zcGlfd3JpdGUoZGV2
LCBXNTUwMF9Tbl9SWE1FTV9TSVpFKDApLCAweDEwKTsNCg0KQ0hFQ0s6IEF2b2lkIENhbWVsQ2Fz
ZTogPFc1NTAwX1NuX1RYTUVNX1NJWkU+DQojNTMxOiBGSUxFOiBkcml2ZXJzL25ldC93NTUwMC5j
OjQ3NjoNCisgICAgICAgdzU1MDBfc3BpX3dyaXRlKGRldiwgVzU1MDBfU25fVFhNRU1fU0laRSgw
KSwgMHgxMCk7DQoNCkNIRUNLOiBBdm9pZCBDYW1lbENhc2U6IDxXNTEwMF9Tbl9NUj4NCiM1OTI6
IEZJTEU6IGRyaXZlcnMvbmV0L3c1NTAwLmg6MjM6DQorI2RlZmluZSBXNTEwMF9Tbl9NUiAgICAg
ICAgICAgICAweDAwMDAgLyogU24gTW9kZSBSZWdpc3RlciAqLw0KDQpDSEVDSzogQXZvaWQgQ2Ft
ZWxDYXNlOiA8VzUxMDBfU25fQ1I+DQojNTkzOiBGSUxFOiBkcml2ZXJzL25ldC93NTUwMC5oOjI0
Og0KKyNkZWZpbmUgVzUxMDBfU25fQ1IgICAgICAgICAgICAgMHgwMDAxIC8qIFNuIENvbW1hbmQg
UmVnaXN0ZXIgKi8NCg0KQ0hFQ0s6IEF2b2lkIENhbWVsQ2FzZTogPFc1MTAwX1NuX0lSPg0KIzU5
NDogRklMRTogZHJpdmVycy9uZXQvdzU1MDAuaDoyNToNCisjZGVmaW5lIFc1MTAwX1NuX0lSICAg
ICAgICAgICAgIDB4MDAwMiAvKiBTbiBJbnRlcnJ1cHQgUmVnaXN0ZXIgKi8NCg0KQ0hFQ0s6IEF2
b2lkIENhbWVsQ2FzZTogPFc1MTAwX1NuX1NSPg0KIzU5NTogRklMRTogZHJpdmVycy9uZXQvdzU1
MDAuaDoyNjoNCisjZGVmaW5lIFc1MTAwX1NuX1NSICAgICAgICAgICAgIDB4MDAwMyAvKiBTbiBT
dGF0dXMgUmVnaXN0ZXIgKi8NCg0KQ0hFQ0s6IEF2b2lkIENhbWVsQ2FzZTogPFc1MTAwX1NuX1RY
X0ZTUj4NCiM1OTY6IEZJTEU6IGRyaXZlcnMvbmV0L3c1NTAwLmg6Mjc6DQorI2RlZmluZSBXNTEw
MF9Tbl9UWF9GU1IgICAgICAgICAweDAwMjAgLyogU24gVHJhbnNtaXQgZnJlZSBtZW1vcnkgc2l6
ZSAqLw0KDQpDSEVDSzogQXZvaWQgQ2FtZWxDYXNlOiA8VzUxMDBfU25fVFhfUkQ+DQojNTk3OiBG
SUxFOiBkcml2ZXJzL25ldC93NTUwMC5oOjI4Og0KKyNkZWZpbmUgVzUxMDBfU25fVFhfUkQgICAg
ICAgICAgMHgwMDIyIC8qIFNuIFRyYW5zbWl0IG1lbW9yeSByZWFkIHBvaW50ZXIgKi8NCg0KQ0hF
Q0s6IEF2b2lkIENhbWVsQ2FzZTogPFc1MTAwX1NuX1RYX1dSPg0KIzU5ODogRklMRTogZHJpdmVy
cy9uZXQvdzU1MDAuaDoyOToNCisjZGVmaW5lIFc1MTAwX1NuX1RYX1dSICAgICAgICAgIDB4MDAy
NCAvKiBTbiBUcmFuc21pdCBtZW1vcnkgd3JpdGUgcG9pbnRlciAqLw0KDQpDSEVDSzogQXZvaWQg
Q2FtZWxDYXNlOiA8VzUxMDBfU25fUlhfUlNSPg0KIzU5OTogRklMRTogZHJpdmVycy9uZXQvdzU1
MDAuaDozMDoNCisjZGVmaW5lIFc1MTAwX1NuX1JYX1JTUiAgICAgICAgIDB4MDAyNiAvKiBTbiBS
ZWNlaXZlIGZyZWUgbWVtb3J5IHNpemUgKi8NCg0KQ0hFQ0s6IEF2b2lkIENhbWVsQ2FzZTogPFc1
MTAwX1NuX1JYX1JEPg0KIzYwMDogRklMRTogZHJpdmVycy9uZXQvdzU1MDAuaDozMToNCisjZGVm
aW5lIFc1MTAwX1NuX1JYX1JEICAgICAgICAgIDB4MDAyOCAvKiBTbiBSZWNlaXZlIG1lbW9yeSBy
ZWFkIHBvaW50ZXIgKi8NCg0KVGhpcyBpcyB0aGUgZXJyb3JzIG1lc3NhZ2UgSSBhbSBnZXR0aW5n
IHdpdGggY2hlY2twYXRjaC5wbCBmcm9tIHVib290IHJlcG8uDQpBbGwgb2YgdGhlc2UgTWFjcm9z
L2RlZmluZSBhcmUgZGVmaW5lZCB0aGF0IHdheSBpbnNpZGUgdGhlIGxpbnV4IGtlcm5lbC4gRG8g
eW91IHdhbnQgbWUgdG8gYWRhcHQgZm9yIHVib290IG9yIGlzIHRoYXQgc29tZXRoaW5nIGFjY2Vw
dGFibGUgPw0KDQpJIGFzc3VtZWQgaXQgd2FzIGFjY2VwdGFibGUsIGFuZCBzZW50IGEgdjIgb2Yg
dGhlIHBhdGNoLiBJIGNhbiBtYWtlIGEgdjMgd2l0aG91dCBhbnkgaXNzdWVzIGlmIG5lZWRlZC4g
V2hhdCBtaWdodCBiZSB5b3VyIGd1aWRhbmNlIGluIHN1Y2ggY2FzZSA/IEV2ZXJ5dGhpbmcgaW4g
dXBwZXJjYXNlID8NCg0KSSBkaWRu4oCZdCBhZGRlZCBteXNlbGYgaW50byB0aGUgbmV0IE1BSU5U
QUlORVIgc2VjdGlvbiBhcyBvdGhlcnMgZGV2IGRpZG7igJl0IGRpZCBpdC4gSXMgdGhhdCBzb21l
dGhpbmcgSSBuZWVkIHRvIGZpeCA/DQoNCkplYW4tTWFyaWUNCg0KT24gNC8yNC8yNSwgNDo1NeKA
r1BNLCAiVG9tIFJpbmkiIDx0cmluaUBrb25zdWxrby5jb20+IHdyb3RlOg0KT24gVGh1LCBBcHIg
MjQsIDIwMjUgYXQgMDk6NDM6MzVQTSArMDAwMCwgdmVyZHVuQGhwZS5jb208bWFpbHRvOnZlcmR1
bkBocGUuY29tPiB3cm90ZToNCj4gRnJvbTogSmVhbi1NYXJpZSBWZXJkdW4gPHZlcmR1bkBocGUu
Y29tPG1haWx0bzp2ZXJkdW5AaHBlLmNvbT4+DQo+DQo+IEFkZCBzdXBwb3J0IGZvciB0aGUgV2l6
bmV0IFc1NTAwIHNwaSB0byBldGhlcm5ldCBjb250cm9sbGVyDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEplYW4tTWFyaWUgVmVyZHVuIDx2ZXJkdW5AaHBlLmNvbTxtYWlsdG86dmVyZHVuQGhwZS5jb20+
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L0tjb25maWcgIHwgIDU0ICsrLS0tDQo+ICBkcml2ZXJz
L25ldC9NYWtlZmlsZSB8ICAgNyArLQ0KPiAgZHJpdmVycy9uZXQvdzU1MDAuYyAgfCA1MDggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9uZXQv
dzU1MDAuaCAgfCAxMzUgKysrKysrKysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDY2MiBpbnNl
cnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L25ldC93NTUwMC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdzU1MDAuaA0K
DQpUaGVyZSBhcmUgc3BhY2luZyBwcm9ibGVtcyBpbiB0aGUgS2NvbmZpZyBmaWxlIGFzIHdlbGwg
YXMgYSBudW1iZXIgb2YNCnVucmVsYXRlZCBhbmQgaW5jb3JyZWN0IGNoYW5nZXMuIFRoZSBNYWtl
ZmlsZSBhbHNvIGhhcyByZW1vdmluZyBvZiBvdGhlcg0KZHJpdmVycyBpbiBpdC4gRmluYWxseSwg
dGhlIGRyaXZlciBpdHNlbGYgaGFzIGNoZWNrcGF0Y2gucGwgaXNzdWVzIHRvDQpyZXNvbHZlLiBQ
bGVhc2UgbG9vayBpbiB0byBhbGwgb2YgdGhpcyBmb3IgdjIsIHRoYW5rcy4NCg0KLS0NClRvbQ0K
DQo=
