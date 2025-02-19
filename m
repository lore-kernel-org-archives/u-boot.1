Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AFAC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D81801BE;
	Wed, 19 Feb 2025 21:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="o2vyX39O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C9D801DE; Wed, 19 Feb 2025 21:28:49 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A188E800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 21:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb5oC4tpEOqx6aexLQpssdo7TSsXq3E+BR61M5cXLk3owafjU9lDk7+NKqKhmWp3q8lfcekdNazcmG0/STqTnaZAgT0tsgX3xpo4yagPHsZLDekHqZg7zacv2aiRGJLRmmIzTieN5OCv9W5r9BN/lG9E492N2JaAwsYDfHjOlZjkHyOCpHWC6ZzvkFIYX6qP0tXLDjdTzzO+FPFjICB7xcgLpWecOH2LJ1AwyB6jZAFBp/BU/cUnar1wvYe80LDIe7hue2bacRNE2cTw9d8OStPEou7je1IPE8yAYLKBbNok+0TrIlW6jwNjCyTi1qBmHvG8Zz7rIYFLL3EGTRx2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IufMKGcv+TkOm97ScUQzAP6v/i0z9pbxuP2lTimKcK8=;
 b=nSS0SAIA42DVni/WhT0mIra+LfwR5INfhjZJuGFRZwx8uKZhlOjv8eayCULri0lJQkdhFqD9hayUsaqr/VAX1CF2krGgK+9rZnKRiRxbdh3yFYmblsm1JMW5WHGlPLQNYsjgP+apRVSfoK6ojo842GVn0BUsdCkS8i1aNjIwzcr/3q7KfpjqVrAG63Q8A5IZH6Smg2sHoRDCAg8R5pZVS9JHqUXeUEmgW4l87SA7Kdc2NdGuMkocbbucBxQpCGz4gIj/YEJs+owhqXwoitcU7AhfH1tqPabbg89JJD1ABesRIqu9fe9xFknLzm/wk0Ry3K63T7iRGck4iE/FXXrbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IufMKGcv+TkOm97ScUQzAP6v/i0z9pbxuP2lTimKcK8=;
 b=o2vyX39OQUsoKelW3EyJW/C+ieJFld/CnAZq9GQ2vAg6b9DXhh4JAQlJRbX2l500Rrvp6zG5AZP7xjVeD/0dok9aMesh5tZb5M5wXo4q9W+7rTTTLIgFgvKr7f8vYJJHKyV4d9tRR13akGhpqU0SRxiWlNhI5dVHkqMCBj6vv0mIetvYsu0UK/JJ2PNETwsDcA9eU0yd7e55DVZ12bFjpYD8prumHpW6SvG5oBGtSNOGi9y4A7/fHqxyexNU82gQnhEFGtuUiVAA31q9FtJQSX1iNIX1xaO6f5AHvOx5wLeN/PixqdJlvfs6uA8Ugj3PhK/e5KajrhCmn6hBnJae9w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:116::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Wed, 19 Feb
 2025 20:28:45 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8466.008; Wed, 19 Feb 2025
 20:28:45 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "s-k6@ti.com" <s-k6@ti.com>,
 "afd@ti.com" <afd@ti.com>, "mikhail.kshevetskiy@iopsys.eu"
 <mikhail.kshevetskiy@iopsys.eu>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>, "hnagalla@ti.com" <hnagalla@ti.com>, 
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "sughosh.ganu@linaro.org" <sughosh.ganu@linaro.org>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "sjg@chromium.org"
 <sjg@chromium.org>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "kishon@ti.com" <kishon@ti.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "bb@ti.com" <bb@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
Thread-Topic: [PATCH v2 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
Thread-Index: AQHbgrvn0zPeRVmEjUqeAavhl+tFeLNO+HyAgAATpgCAAAgigA==
Date: Wed, 19 Feb 2025 20:28:45 +0000
Message-ID: <9aaddf18c6ff3e794d00adce005559638d254e21.camel@siemens.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-2-c-vankar@ti.com>
 <752c404bcb63afaf78055f39d583055db44f82a3.camel@siemens.com>
 <2d6a2eae-3825-4a03-a29c-4775f38dc535@ti.com>
In-Reply-To: <2d6a2eae-3825-4a03-a29c-4775f38dc535@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3148:EE_
x-ms-office365-filtering-correlation-id: 1bd72678-ac28-497c-16a7-08dd5124021c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?N1NiSkhoemtISURRM1VwTEpHcHloRHIyejJrNU9mN1V3cUgvWDd4dmpZVjJI?=
 =?utf-8?B?cW5lRUk4Q1phZENOME1lVzZZYUZvNCtLVUpFYUVUbE5wU1dYaU9EZWlQZ1Z5?=
 =?utf-8?B?SmVFTHdQWnNWSHJOQXRldXVxWGRCckNYbG0waHV1NW15dnlnOTJTSUgzbG5W?=
 =?utf-8?B?Rk9HTkR5TjBoYW05L0FvdmptNWwrQlM4VEQ5YStiMnVPencvMTdONWloS2pB?=
 =?utf-8?B?TUFWb0ZiUDJHaFZ5UWFmckdEa2xoNmtzdUhKZjFUYkMzemRUQk15L3NIT3ZS?=
 =?utf-8?B?SlhQOUxOM3BDNWhKbUNqOW5xYjBJbW4yNnB6RFU2OGowRURkakhBZEZNMkRR?=
 =?utf-8?B?MHlXYUcvQVJHaFZ3aW9nWFNUYndlUk5XWTdFUCtVWElpVUpMZEIvS3E3NWlt?=
 =?utf-8?B?YWxvMUxnQXJ0dmM4bnlDdGJRd1lROUtDaldZamhhZFJOR0ExK2VFYW91YTk3?=
 =?utf-8?B?RURUZ0ZpbnlZUHB3L3pOU29oeGYrSlJCNS96TmcrV3FyZm1tdUtiZE5KbXBI?=
 =?utf-8?B?V1BWME55OWhuWHJaVHZEbkdXU1JxNkxBWFNRRkRzUUZhcXQ3SVk1L0M2T3VP?=
 =?utf-8?B?RTlSV3pLUXhQUktPQWdKbXF6WXRheURHOE04TFp1bllSeHRRTU5VYU9mdzVU?=
 =?utf-8?B?OThTQmpVUkFKbXZDbFViMDdyUlliRHAxd3Jmb2x2TWE2WTRCUW5lY3BxNzkw?=
 =?utf-8?B?M2R6ME85R3ZJa05ZTnNLKzhQZFFYNmYzdGIzTi8zQVBvS0lXdFBrMnRXcWR2?=
 =?utf-8?B?T1dOa0kwaHlDYUJYQ0Y5ZlFRUWZtZ1ZmSzQ3RTJUK1VPZzV6T3ZJS294em1S?=
 =?utf-8?B?QUM4ckNOVzFpTVRPVW1zeVVMUTNRelRrTG1oQzZ5bGtDaTdZNzBuUGVXVE5m?=
 =?utf-8?B?TnZjUzRtaVEwYm4vdDhkbDFBc2VhellnaThlbytzcnJka2taeG5udnJZMFhO?=
 =?utf-8?B?anZKTEFieXdjYStIYnZLc2VvQU5OU2EyTEFOdGhxL2MxWElETHRjVWFGSjV5?=
 =?utf-8?B?ZDNWUDNQZ05MY2tMTjF4K2llcmZtRVVoc2xuYmJJOHJibndXVlR3Umx5dUQ3?=
 =?utf-8?B?OWo4cjhoSllYTmU5bDI1WWZUYVE3RjJIQWxkVmtQR2NQM2dRZTNIZmU3V2Z6?=
 =?utf-8?B?ZnJJOGtXL294azZ2ZjdNU1c0dUF1RmRpbEE2bzY5OC9rYjJtNmhBVWM2ZkR4?=
 =?utf-8?B?Z204M2JOakJkRmtaSmZFeWhaYjFFS2JrZDFqY01QS0s0TUtCWnB3SGRXWmcw?=
 =?utf-8?B?OTJaUVlydnZIVjhHUk5MUzdnWU1KM1hDZXZQa1NyaEtBbVBoS1h3MnpNb2ll?=
 =?utf-8?B?MmFRNzVLRzFUOWQ1Y2NPU3FlZUhvamlIblV3OXhIU05sVXBBRlRLMmxtTURX?=
 =?utf-8?B?WjZ6ampVaXo4c3dNOERRVmJzN3U3OUpJRndDYVpUUk03ZXUwakJsTUxvOWhF?=
 =?utf-8?B?SllJdVdKenM1dzVZaTM5RTRQbFp2bW9QWE9ROVY0RGt2YkRzcmFFS0xlUnZo?=
 =?utf-8?B?amlTZUhtVDgyVXMyb3ZNWkFJZVRKOGFBempWOFNKSTBzbFZRZlFjQTRTZ2Rs?=
 =?utf-8?B?NXJocXEyTklXMzFPRVAzZ1doZGNtNVJ1STdwb0ZnNytXOGFnREtZSGcrSGxj?=
 =?utf-8?B?eDBqOVBHRFdvUFJadC9MSWhHUUw1Y2VuK01NSzFSM2txb1ZGTXdIZ2U2N0cy?=
 =?utf-8?B?a1pNMk1FVS90Tm9WOGlrUmV0WFJsY2h2R3J6NkVQNHZ2V253K0JSSktzOTRS?=
 =?utf-8?B?SENHZVlVUFppSTg2Ti96am45cGV2U2U0L2s3NFRVZkpWZEdwOGNtdXdBSjRj?=
 =?utf-8?B?clMrSTMvQ295aWtoWXJsRC90b25YUzVHNWt5N095VEdqMTd2R1BwOERKbGNm?=
 =?utf-8?B?MEdXbUtMZXArRU5wMEhXTkNuZ0R5eWMxbVM4WDVRUFlFdm5ySHZMcXF2dmZl?=
 =?utf-8?Q?Xl5J8HZ8OTo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzlTWS9YTmF5cCtkdTFNSG5JSlRMelpYOE9KZk8xZmpBbmxMVjg3dlZmVWN2?=
 =?utf-8?B?U3YwUnBnZFJwUzNIL0YxeVlBWFM2ci8rQlA5K0ZGUzV6QStmZVFncnpPRlZk?=
 =?utf-8?B?aVdXbjRwdHV5anJwSmpFc2JPL1l5RGdsVHRxbmtMdEhKdEZnWnl1azI3cFRW?=
 =?utf-8?B?VnZMVlE4SXJ4R3NLUGZQMW5nQmlsdXEwanl6akEycDNXQjlHN3dRVWUwNElZ?=
 =?utf-8?B?a3NYNmo1TWNzb0s3MUJJSDdaa2E4UDA4dE5kZWNZVVM1MjZNbzdoM1R2SDd5?=
 =?utf-8?B?ZTJWUlhuRjRablczSFBVbWIyWGZiNkIyY25YaHFsbnZBK1UzdWJqUlBqSElQ?=
 =?utf-8?B?M3FUV2U5UnZjZllFbEp3U3NNOTNYK2o3Wlg2Q2JqUnp5SmJNRHVsdnJybE5w?=
 =?utf-8?B?V1dJM3Q1aFdGNnBiRW9KVVRCYmlaZWtOWldRMUR4SDFyWVVIUktPWWdiZVNP?=
 =?utf-8?B?S0FwMWYyUzg4MXJaWnBGMVA3bHdBV1FRVWYwL3E0eC9sSGlHZXhNaFJjWkRP?=
 =?utf-8?B?bkdsQVAwVHlBSFJYSkZOZThzMWF6WHVueXl6bU5KWTBadTVKcHZzajdqUlYy?=
 =?utf-8?B?b0RXMlNNcjZSOGQwcG5pQThBYWxsN1RLQWxHVVl2N2thU3hxKzZ0OG51Y0s3?=
 =?utf-8?B?dmZzTFI2S2twMmRidUlsSlluQWduWC9XWURndXRtT2JZSEwrelBnZzE5SDVN?=
 =?utf-8?B?OUl6SXg2Zlh1aUhaYjJnQVNIbVJyeXF4d0FyOXVyYXJsdWpNSk5zWXdFRjls?=
 =?utf-8?B?dmN5Nk5PWGRzVmY5NVFpY1B3amJJQy9ycGI3V2VKamFuV1dLOWhQNjRhS2tw?=
 =?utf-8?B?anVxcTQ5Zk5QaExOdmVYdi9KNmhqd1hYZTJuRElPeHF3YUpkM1NNcUlBYi9W?=
 =?utf-8?B?MVlOZEkxdWM4bkM1VWpNc04xbFdUQ0U5N0VKYkhjdTNHaFhJNWpGSnF6MDZw?=
 =?utf-8?B?MEpIVW1WMkFiTmxuWXhJRFBaNlJKczNSUHlhSWxkUTlVU2FyK2lqTDZDbGtj?=
 =?utf-8?B?NkVGN0tLODdzVWNRMFBqN0UwRkhiTnVJb0lWc2NvWC83TGhvREdZYm5GT2Rk?=
 =?utf-8?B?Vno2b29NenZoVjZ4RTVNdUNlK2ZrWDJGanZiTDhOZEM5eTdjaTFLRlE2Rndn?=
 =?utf-8?B?dktaQUxCbGFIV1NlUERGN2hUUGNkczNaQlJWcUJWYnNuZndrRFBHUUM2U1NP?=
 =?utf-8?B?emsraGUxYi8vR1ZhQ01iV1cyeXJ0OHZ2V0lMcndBdVN2L2RMY0MybStWNGN1?=
 =?utf-8?B?emFiQkhlcUpFVDhneWx0Zk9yMmVkMUNxQklkQjB0UGdBV2M0eW44YUREMWlV?=
 =?utf-8?B?U0ZQU0lwT1ZMZkdlUXd0NnU3a1orVjFtMmhHRG1KbXA1WEJtc09DS1Nic0Zy?=
 =?utf-8?B?bUNzR3ZRWXRaYUx0Ny9GT2pvYjJORWpWU1cyQlg5V3V1WFJpbm5HQkkzRmh6?=
 =?utf-8?B?OUNvdXNOaGJaaWd2UHVDYlo5M2h3SGZ0bVFJYXd0OXNNTDF4VTJ6TjJrTGJz?=
 =?utf-8?B?RTdTYjAwbzAvQmlHQlVhS3c2aG10Qjl0RFRmZTdtRWRHZTRxa014Sit2QW5M?=
 =?utf-8?B?b1lDWE91NENFVmtVS3RjS3lQMHVVb1NsSDBIbVNhUmxjVDg1ck0wbnhJUDF6?=
 =?utf-8?B?cmZMTFJvaFF5WUVnOUN1M294dlBUL0Z3YllzSmtkMUZ0dnRGOWJYQjNYWGNJ?=
 =?utf-8?B?TWlhemhiVWVZdzQrQ3Q5U3RSVXcxa2tBbHczQ09BZURyY1VMelIrc2h1WVYr?=
 =?utf-8?B?alhueVpjS1p6c2lYbVBkZUp2VndsVGZGWjFQaE1MUWdJMzh0Y25qb1Q0Z0wv?=
 =?utf-8?B?Y2NRUlAxazZwY3J0aExoaGFkRVAyTG8wVW5CYUs4Y2xib1gvZWw1aWZvekV6?=
 =?utf-8?B?WUV1dW1ydGxEWjFUQmJBOTV4WHNIVXNKa3JCSmxiSjI2SVRUczdHQmlyY0Rx?=
 =?utf-8?B?SWtqVStISno1TVZqaW5Oa3hDTXE5WGZDZVllQmVYV2cyejNkdnEyNnpqZFlI?=
 =?utf-8?B?ejB5Rm5YcXNrWVVCVlUrRVJ4eG12bzAzSkFsWFp1emtsZDkvREFkUzdBaVUx?=
 =?utf-8?B?a1hLN0M0aEs0c09ybmJ2Zlp5eHM4clZPT0NleVlqa0pORlg2cXJZUElWY25i?=
 =?utf-8?B?MnI1djRZNXlGYW1SeWJRVXNEUDFVMDRvakhsYzZlc3BCeUdrSnYwdGxGZlVW?=
 =?utf-8?Q?6IInIab4S75htYM8hAkx1qU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6124FE9150328D4185984A01C630C7A6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd72678-ac28-497c-16a7-08dd5124021c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 20:28:45.2227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yt0jg3YRxgvtiklumK9xbFYKRC79xLPix3cnVF7yZBIvI5YalEdzxtDRt9pbxZDugzZTjff3vp0j9uDroADrBF7CKkwscB1IPCcfAnmz07c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3148
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

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDAxOjI5ICswNTMwLCBWYW5rYXIsIENoaW50YW4gd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDI1LTAyLTE5IGF0IDE2OjE4ICswNTMwLCBDaGludGFuIFZhbmthciB3
cm90ZToNCj4gPiA+IFRvIGFwcGVuZCBhIHN0cmluZyB0byBhIHRmdHAgcGt0LCAidGZ0cF9zZW5k
KCkiIEFQSSBpbnZva2VzICJzcHJpbnRmKCkiDQo+ID4gPiBmdW5jdGlvbiB3aGljaCBjb3BpZXMg
YSBzdHJpbmcgZXhjbHVkaW5nIGEgbnVsbCBjaGFyYWN0ZXIgY2F1c2luZyBURlRQDQo+ID4gPiBu
b3QtbnVsbCB0ZXJtaW5hdGVkIHN0cmluZyBlcnJvci4gSW5jcmVhc2UgVEZUUCBwa3Qgc3RyaW5n
IGJ5IDEgdG8gYXZvaWQNCj4gPiANCj4gPiBJcyB0aGlzIGVycm9yIHZpc2libGUgc29tZWhvdz8g
SG93IGRpZCB5b3Ugc3RvcCB0aGlzIHByb2JsZW0/DQo+ID4gDQo+IA0KPiBZZXMgdGhpcyBlcnJv
ciBpcyB2aXNpYmxlIHdoaWxlIGxvYWRpbmcgdGhlIGZpbGUgdmlhIFRGVFAuIEkgdHJpZWQNCj4g
dHJhY2luZyBiYWNrIHRoZSBlcnJvciBhbmQgaXQgd2FzIGR1ZSB0byBzdHJpbmcgY29weWluZyBp
biAidGZ0cC5jIiBmaWxlDQo+IHRoYXQgSSBtb2RpZmllZC4NCj4gDQo+IFNpbmNlIGNvbW1pdCAn
ZTJkOTZhYzllZTlmODFjOGY3MjQzNWJmZjU1ZjkyNGQyN2FkOTJkMScgaGFzIG1vZGlmaWVkDQo+
IHNwcmludGYoKSBmdW5jdGlvbiB0byByZXR1cm4gdGhlIHN0cmluZyBsZW5ndGggaW5zdGVhZCBv
ZiAwIHNvIGl0IHdhcw0KPiBub3Qgc2VlbiBiZWZvcmUuIEFsc28gZnJvbToNCj4gaHR0cHM6Ly9n
aXRodWIuY29tL3UtYm9vdC91LWJvb3QvYmxvYi9tYXN0ZXIvbmV0L3RmdHAuYyNMMzQ3LA0KPiB5
b3UgY2FuIHNlZSB0aGF0IHdlIGFyZSBpbmNyZW1lbnRpbmcgcGt0IGxlbmd0aCBieSAxIG9uIGV2
ZXJ5IHNwcmludGYoKQ0KPiBjYWxsIGJ1dCB0aGF0IHdhcyBub3QgZG9uZSBmb3IgdGhlIGxhdGVy
IHBhcnQgdGhhdCBJIG1vZGlmaWVkIGFuZCB0aGF0J3MNCj4gaG93IEkgY29tZSB0byB0aGlzIGFw
cHJvYWNoLg0KPiANCj4gPiA+IHRoaXMgZXJyb3IuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IENoaW50YW4gVmFua2FyIDxjLXZhbmthckB0aS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IA0K
PiA+ID4gTGluayB0byB2MToNCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAx
MDcwOTM4NDAuMjIxMTM4MS0yLWMtdmFua2FyQHRpLmNvbS8NCj4gPiA+IA0KPiA+ID4gQ2hhbmdl
cyBmcm9tIHYxIHRvIHYyOg0KPiA+ID4gLT4gVXBkYXRlZCBjb21taXQgbWVzc2FnZS4NCj4gPiA+
IA0KPiA+ID4gwqAgwqBuZXQvdGZ0cC5jIHwgNiArKystLS0NCj4gPiA+IMKgIMKgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlm
ZiAtLWdpdCBhL25ldC90ZnRwLmMgYi9uZXQvdGZ0cC5jDQo+ID4gPiBpbmRleCBmZDljOTQ5Mjky
OS4uNDIwZWE5ZWNmNmMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvdGZ0cC5jDQo+ID4gPiArKysg
Yi9uZXQvdGZ0cC5jDQo+ID4gPiBAQCAtMzQ3LDExICszNDcsMTEgQEAgc3RhdGljIHZvaWQgdGZ0
cF9zZW5kKHZvaWQpDQo+ID4gPiDCoCDCoAkJcGt0ICs9IHN0cmxlbigoY2hhciAqKXBrdCkgKyAx
Ow0KPiA+ID4gwqAgwqAjaWZkZWYgQ09ORklHX1RGVFBfVFNJWkUNCj4gPiA+IMKgIMKgCQlwa3Qg
Kz0gc3ByaW50ZigoY2hhciAqKXBrdCwgInRzaXplJWMldSVjIiwNCj4gPiA+IC0JCQkJMCwgbmV0
X2Jvb3RfZmlsZV9zaXplLCAwKTsNCj4gPiA+ICsJCQkJMCwgbmV0X2Jvb3RfZmlsZV9zaXplLCAw
KSArIDE7DQo+ID4gDQo+ID4gQnV0IGl0IGRvZXMgaW5kZWVkIHByb2R1Y2UgXDAwMCBvY3RldHMs
IGJlY2F1c2Ugb2YgJWMgd2l0aCAiMCIgYXJndW1lbnQsIGRvZXNuJ3QgaXQ/DQo+ID4gDQo+IA0K
PiBXaGlsZSBkZWJ1Z2dpbmcgSSB0cmllZCB0byBkZWJ1ZyB0aGUgcGt0IHN0cmluZyBhbmQgSSBj
b21lIHRvIGtub3cgdGhhdA0KPiBiZWZvcmUgdGhpcyBwb2ludCAnbnVsbCBjaGFyYWN0ZXInIHdh
cyBnZXR0aW5nIGFwcGVuZGVkIGJlY2F1c2Ugb2YNCj4gaW5jcmVtZW50aW5nIGEgcGt0IGxlbmd0
aCBieSBvbmUsIGJ1dCBub3QgYWZ0ZXIgdGhpcy4gSXQgd2FzIGp1c3QNCj4gYXBwZW5kaW5nIGEg
c3RyaW5nLCBzbyBpdCB3YXMgbm90IHByb2R1Y2luZyBhICdcMCcuDQoNCkRvZXMgaXQgcHJvZHVj
ZSBcMDAwIG9jdGV0IGJldHdlZW4gdHNpemUgYW5kIG5ldF9ib290X2ZpbGVfc2l6ZSB2YWx1ZT8N
Ckkgc3VwcG9zZSBURlRQIHByb3RvY29sIHJlcXVpcmVzIGl0Pw0KTG9va2luZyBpbnRvIF92cHJp
bnRmKCkgaW1wbGVtZW50YXRpb24sIEknZCBzYXkgaXQgd291bGQgaGF2ZSBwcm9ibGVtcw0KZW1p
dHRpbmcgJWMgd2l0aCBwYXJhbWV0ZXIgMCwgbm8gbWF0dGVyIGlmIGF0IHRoZSBlbmQgb2YgdGhl
IHN0cmluZywgb3INCmluIHRoZSBtaWRkbGUuDQoNCldvdWxkIHRoZSBmb2xsb3dpbmcgcGF0Y2gg
Zml4IHRoZSBwcm9ibGVtIHlvdSBvYnNlcnZlPw0KDQpkaWZmIC0tZ2l0IGEvbGliL3RpbnktcHJp
bnRmLmMgYi9saWIvdGlueS1wcmludGYuYw0KaW5kZXggMDUwM2MxNzM0MWYuLjBlNjIwYjI3MmQ4
IDEwMDY0NA0KLS0tIGEvbGliL3RpbnktcHJpbnRmLmMNCisrKyBiL2xpYi90aW55LXByaW50Zi5j
DQpAQCAtMjk5LDcgKzI5OSw3IEBAIHN0YXRpYyBpbnQgX3ZwcmludGYoc3RydWN0IHByaW50Zl9p
bmZvICppbmZvLCBjb25zdCBjaGFyICpmbXQsIHZhX2xpc3QgdmEpDQogCQkJCX0NCiAJCQkJYnJl
YWs7DQogCQkJY2FzZSAnYyc6DQotCQkJCW91dChpbmZvLCAoY2hhcikodmFfYXJnKHZhLCBpbnQp
KSk7DQorCQkJCWluZm8tPnB1dGMoaW5mbywgKGNoYXIpKHZhX2FyZyh2YSwgaW50KSkpOw0KIAkJ
CQlicmVhazsNCiAJCQljYXNlICdzJzoNCiAJCQkJcCA9IHZhX2FyZyh2YSwgY2hhciopOw0KDQoN
Ci0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
