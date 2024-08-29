Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15008C83F16
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F74588A2D;
	Thu, 29 Aug 2024 17:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="fZoU3SLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE25D88A75; Thu, 29 Aug 2024 17:51:05 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5625889FF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oliver.Gaskell@analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFdTKJ022331;
 Thu, 29 Aug 2024 11:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=FXiQ4
 /W+giQA5UCu74jmndSUWDmUH8buu3/ilfcyCPs=; b=fZoU3SLmZraaeLhazr+YV
 jsX74a0XIzHN7aBWi2vEn/vN/hMiGAuMwLKjmIorI4d+sGuxpPY+HWmXtcs3J2MY
 Nt8AQYbE3fpHGiv3rcGWw0RVJE7OiHbIbN7pHav/GfMH5PUIS6tNHSe/+rezIi8i
 Jtvyfqsf54Ru4GPmLZ++HphL+1t1sIRsbk3xyBjtMF2d9M0ZHIiheWH/US0wi1LP
 JjozftFC15L+SNO/G1/oDK3PNilDfj7ZRX9gcnTrsLFm+Rftx0UgWHksQppJkpdy
 VeBWKFji0sd205ZYapoQbRiecnhDHuz/zVFy/zRYcaC1MVICChLjr4wBoGmIFGaK
 Q==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41aend33qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 11:50:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8Bpr5GgxzNiN8FGp5jnzdje7+DDPGSoh7N+t94dN3uoLhr6Vswyua05+acyv73PTLkvBmULJdmLLKO5nRpCtBhX/zZYrwdBWDhMhnnFJyacJd4WO6a756kJDFt8lt7N1HtlmbJvSsLZ4VePiI53ZHPQmNhog5JbJL/czbwKeHEZ1b8Sg73NsqeXlM7M0yEpbjVSnAaD+U1RlI9xWCUKQmoE5gKxmk8nPQvAesb6vYYHCGDe9KYTTo0xdkPJLCTKsbNY1DudRbCX3heDhMxfy05HTCV55hVqu2AsgW6s+IG/2fNIBaz/VKIttlbcLglRWW6zzECq+JmQFoeSZsyTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXiQ4/W+giQA5UCu74jmndSUWDmUH8buu3/ilfcyCPs=;
 b=B4uMmj1GJvxCxrp7vksr2cs9in7j8LkjIEGfNpwo/AuoiZVkrKzQtVkwc7a1B9tL6rlCg3X19VeGrgt6lBR+SbL8KcO94Da6Z+f+84D6TJWc4rApniVjATUN0EmYWx9UgsmVO+n9V0/ZPVIysjBRtDD9jziZnhh/0n63hpheSp3KgOVkBLVg1nhKPi8ZhvxEQ+y/JJa2wv35Tc5lA8XjLpAHycnKbMi8eRsXse2cEXKgfjJ4RFTgdR6zJc41fxBxdpnNz75WboNXXMpeEg5+sjWZEM4mf9Oq4aoafmn+iKOkhNRsSKJPmXKFZLcWwLBBIlpmVxn4mZs90AFPJCLShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN7PR03MB7275.namprd03.prod.outlook.com (2603:10b6:806:2e8::11)
 by SA2PR03MB5769.namprd03.prod.outlook.com (2603:10b6:806:11b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 15:50:56 +0000
Received: from SN7PR03MB7275.namprd03.prod.outlook.com
 ([fe80::31cc:7df5:65bc:7a7c]) by SN7PR03MB7275.namprd03.prod.outlook.com
 ([fe80::31cc:7df5:65bc:7a7c%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:50:56 +0000
From: "Gaskell, Oliver" <Oliver.Gaskell@analog.com>
To: Tom Rini <trini@konsulko.com>
CC: Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Greg Malysa
 <greg.malysa@timesys.com>, Ian Roberts <ian.roberts@timesys.com>,
 "Bimpikas, Vasileios" <Vasileios.Bimpikas@analog.com>, "Agarwal, Utsav"
 <Utsav.Agarwal@analog.com>, "Artamonovs, Arturs"
 <Arturs.Artamonovs@analog.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Linux Factory <adsp-linux@analog.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: RE: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx boards
Thread-Topic: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx
 boards
Thread-Index: AQHa+TLM+4kDAEwD0kOdcGvZyQfyQbI+U4eAgAAD41CAAANWAIAAByKQ
Date: Thu, 29 Aug 2024 15:50:56 +0000
Message-ID: <SN7PR03MB7275A514335195C93FF8D328E1962@SN7PR03MB7275.namprd03.prod.outlook.com>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
 <20240829145143.GA2479150@bill-the-cat>
 <SN7PR03MB72754C566D3532701567AC38E1962@SN7PR03MB7275.namprd03.prod.outlook.com>
 <20240829151649.GD2479150@bill-the-cat>
In-Reply-To: <20240829151649.GD2479150@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG9n?=
 =?us-ascii?Q?YXNrZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVl?=
 =?us-ascii?Q?ZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzkzMjE4M2MtNjYxZS0xMWVmLWEw?=
 =?us-ascii?Q?MzEtNzQ3ODI3ZWE2MDUwXGFtZS10ZXN0XDc5MzIxODNkLTY2MWUtMTFlZi1h?=
 =?us-ascii?Q?MDMxLTc0NzgyN2VhNjA1MGJvZHkudHh0IiBzej0iNzMwNiIgdD0iMTMzNjk0?=
 =?us-ascii?Q?MjAyNTUxNzYwNjQ2IiBoPSJ1dWdOa0dyV201T0NQODFlZmlVRVI2VUdvNEk9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFEZ0RBQUFHZDZBN0svcmFBU09lWjdYZ3ErNFpJNTVudGVDcjdoa0RBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFTZ0lBQU80QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQTNMaFNmZ0FBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dC?=
 =?us-ascii?Q?bEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tB?=
 =?us-ascii?Q?WlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJm?=
 =?us-ascii?Q?QUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBTzRB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQXpnQUFB?=
 =?us-ascii?Q?QU1BQUFCT0FBQUFBQUFBQUdFQVpBQnBBRjhB?=
x-dg-rorf: true
x-dg-refone: Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7275:EE_|SA2PR03MB5769:EE_
x-ms-office365-filtering-correlation-id: 0ee5c0a0-3d04-4ea1-c2da-08dcc8425ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eIgw9ywP8q1MzHS7n+aFmh43NbryjjQjzj9tQkNiZIxfAh/36lRe00xBriTM?=
 =?us-ascii?Q?ptRPFA4y2zsAIwo9ZfjOBUIHp3hhmENUEz3kKA1a6HXWLpzgzqmnZNNWFq6P?=
 =?us-ascii?Q?5gQvYjbsyViGGLs+EiOmnW+9jiWTSnHv8y8F2RSla2NsnmbA46KB+Q8vvSkQ?=
 =?us-ascii?Q?Sc8wFDLc7RzveUf/zBegn7EfIEdG18X/bl9h1p8V0HuZ3Tt3q9KDYhqbGKIs?=
 =?us-ascii?Q?IAOi9SlrRwht2UQYuNBEqecLpCD/W1l6qd3a8tRHF4/eongQpguUS1AX7ecE?=
 =?us-ascii?Q?DPTj6AgEQqcwnjraPu9W2mqbYXUp56R7JN5DoaaiFIcEo5GIp3vTYRwyqdCw?=
 =?us-ascii?Q?Nc0z3wT6xc34ykoA3JdH1iaG0Pqipcubt8tr+FdNrIXxGzpAhb+SJvlj3Dng?=
 =?us-ascii?Q?T+fAzygtUG7nwDsVBQBtaJ0Yv608SL3Us4ciKDqKR/HdhOLAoxC76kD0Dwvg?=
 =?us-ascii?Q?Y0zqxXR+d8AKuq1BhuQeE1XdNmboKo/vA3xJJjzZV+KivL6VhmXop0cDYptl?=
 =?us-ascii?Q?VE1axwemjhELG1L/lxdS9+wIfLJKEEVZKVyiVa4HyC4MKM30tRuz917eOLYl?=
 =?us-ascii?Q?QR1LaJYtf1rvz3gSU5lGfVRPRw9L3ankXhdt5qCZkrYLyijDFOiisC+8nmLd?=
 =?us-ascii?Q?ayNvtn+pq3COaw2zEEbOUMVphTMH2dwKjofNAUXTM//CqiBJHCw8GmMkErRc?=
 =?us-ascii?Q?3V4vqbb2YPbQ261jsyPMGBFrUZkcMlKrbvp8LzwEfpP+KXQ6w6RjDyiYj/Qy?=
 =?us-ascii?Q?uQgtj9SmdCSGDs50lpiR1liPWFN6LURXoLMp9lbIDvjXmCV1xOj0t/W88uB5?=
 =?us-ascii?Q?ZyiyprVhM9ELdIBhJ84v+8XbuJrrvUt04v0TH090awYH5GUNusuIODV1pxVM?=
 =?us-ascii?Q?TdtRSWc1J4sO1NhkxOdCkjIm/VgkkvbFMplm3W2M4p15ykXKSbHWWxIfFwIp?=
 =?us-ascii?Q?UOA2LBvV6u8Ta3mfInhLLqi+YDnEcG6PyzMRfDxlW6B0QzX+23g+n2ZKx7YD?=
 =?us-ascii?Q?YiLDYz9HPjev5W0U77E43E6EA2a8/guNHDnB1+3Rv32owNs6ahnKuJfqK2b2?=
 =?us-ascii?Q?Fi5SULubHFWYUxBXX5kgCGZsSOkoMSOJNIrlcPsDyspnl5oYKWpib93O8dDT?=
 =?us-ascii?Q?yQDeq3WGffzJfz1BmGZUZ9wKD7I69cH1DyA14W/mgM3DR1rWwtU5oGRgB/MR?=
 =?us-ascii?Q?YR5P8EiVF3lx1qS0pzLZnkcHcXAw9vjhNsrKutaaTUpBOVumKt/eh5be5b3e?=
 =?us-ascii?Q?ogb3y0WFhibrw4MISQb1ahDZsSdRckVurx/EhGG25Qjo2Lu2VTcztNXKXVeU?=
 =?us-ascii?Q?MUP4/v+N7deNdHoDKtNCIBQlfrnRPVcPSLOp7zVKJBTQEUo4Hj6F2s1h9eo5?=
 =?us-ascii?Q?xy9dmSk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR03MB7275.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WltxpRPflFo5zbuZk8rv3TPHovJG1WhEhs/85Ep2NsIlofUzAl9pCXLJAzvf?=
 =?us-ascii?Q?1ZGX6vDk/jelH4kVlZ7Rl8epABM63B9vwhKfcRdUDLu+vPFzRSfIzGOIWSJr?=
 =?us-ascii?Q?CsI5Advzkjc5lsXTZeIGfH1xR7+rfoBykSA7fgiFlEqFlLNIvr43MTlTbsd1?=
 =?us-ascii?Q?zKZ8FwB5OKYi0w+7IR2uXAJrYLw3eNxQ6qX5Kf2luZDPrSM+jIvHtCWDO3S4?=
 =?us-ascii?Q?X85SxqxC4nDkUei3fwI7ki6QCo0NLdfcZyA32+GxRXceNjbbBqWhsi770IMV?=
 =?us-ascii?Q?ng3B1T6mwwKwSTyDVpA4Y8khR8bnsgs/+pmh52B7EySUA1OBSx6vt8G/i9CG?=
 =?us-ascii?Q?eTML8MvnvH5y31ZUyi5boKpWxJFnlwDQVekLQ5YoIeS1MDOQcmzhKgDdOxAe?=
 =?us-ascii?Q?3JXr+IV+6jAXwiHtEjlF5W5sv0Q3TI9wZNWc48exq4x7ovloji0uUuL+zNFu?=
 =?us-ascii?Q?WZYA5N6VEGdBFxNGdfAuyjqHqub/w6uVxLu5gQIcWbSMB1YaSdws3XtV0ZcI?=
 =?us-ascii?Q?AFBj5uS9oZg/OwcZmro+hWYkfNyDr3cyHscyPSwXDpbpwxx8T0VblbZ49ngK?=
 =?us-ascii?Q?eN7MYGKgXh5imWadoZOK7f2u65cn/yLDV3/3ri3jzoSQlmQEeb05wQIrWE6Q?=
 =?us-ascii?Q?+0CATiF8kEOxDocy6YbVwyLMLyIGktSdx//oHQCYsHVV4BMTABDzUKGqF+gy?=
 =?us-ascii?Q?CEJcCjcmPJS9gjwb5lFxEbTQQYx+4jJLnByODCJFBPsd5HCEvgTRHYF9ehFX?=
 =?us-ascii?Q?IbCO3H4fvJC+Q4NaGV4hpwCqKIcO/G+hdGsphRtrlRVH6PdbR1cDrUh2bk0w?=
 =?us-ascii?Q?Lm+DrEnPkYV/bNqDahJU7NIp1QyvQ6wgMz78EhJL4q5vM99psow1OLdRFBdD?=
 =?us-ascii?Q?xZjfVTBxTSao60aENwht7NxfiiDXUlNEqIQEYYscycl4bFP5m3gOn2f1dfsd?=
 =?us-ascii?Q?xqFbcntewiRVUgjcspQw5pzI5yneOSvGnL/7gzOCFCSFx6eAQMgRtLTU6y+E?=
 =?us-ascii?Q?tyQPuNAaoVD9gx4hKUEmYgt9m99rhtJKDCJMIZlFms1RdHv06P9wc+ajsoeE?=
 =?us-ascii?Q?2QcjwCvpTYtw5kFGjEF09k8htd4DxrX3YUrVwEg4sbp0gWz9nxFWdje/ZpJA?=
 =?us-ascii?Q?WeTuBrtWoC9AFrY5B2gkPWr8NpZoBKIdJLvz9rfOfUty5W9ILSiSMdFNzMgf?=
 =?us-ascii?Q?9iAyBHDEe1Zx/pRUAY/DlxLI9K1h3UMgoK1HE5pIzy3yDuBIMC14C9RnEzsQ?=
 =?us-ascii?Q?uXgBcK4YrnTWd7OdcdsSAd3oi7G/EbW0TDgixo5xznUlf6pva+yQ04uxY7oV?=
 =?us-ascii?Q?lt9IHtl73g7dQi2LXg6vOd/hGx2+ifIyn2CDsAicpKkLSZ0e2tYUaUxUC/kW?=
 =?us-ascii?Q?F9TtJXn7tlDvAeGWg4hjnPYCpl45xcrP9qLaJ1H90sbyzL9d0gyg3JKERThQ?=
 =?us-ascii?Q?rHWjKlHqwy5L4KQYTivZ1j8lM++hjU1PzDaZz3esuGkEFtvDI4uECMgFnBnr?=
 =?us-ascii?Q?GaPbvZA4iCL65Q0Uq/zttUp3wHzU4II4PHkK44w6b93t0xU24ZsTtyjAoIRW?=
 =?us-ascii?Q?5E08itGbixu05gnIUJqcXtFv6ARJydf7ZaYJ8tT4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee5c0a0-3d04-4ea1-c2da-08dcc8425ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 15:50:56.6087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysGoWVvWHB7v3LMrK42/mbuWAWPgo7GJGAM9ZdjSrwan6GPv7ssKcn4x6Fd5MWN26RRoY0VUMM4kpleJx+nq4ggjVk8VYJz5027jANlxdUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5769
X-Proofpoint-GUID: 0L3-lNZ2emxAwRpcoyuMWVivIvpSZsJl
X-Proofpoint-ORIG-GUID: 0L3-lNZ2emxAwRpcoyuMWVivIvpSZsJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290111
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, August 29, 2024 4:18 PM
> To: Gaskell, Oliver <Oliver.Gaskell@analog.com>
> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Malysa
> <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>;
> Bimpikas, Vasileios <Vasileios.Bimpikas@analog.com>; Agarwal, Utsav
> <Utsav.Agarwal@analog.com>; Artamonovs, Arturs
> <Arturs.Artamonovs@analog.com>; Rayagonda Kokatanur
> <rayagonda.kokatanur@broadcom.com>; u-boot@lists.denx.de; Linux Factory
> <adsp-linux@analog.com>; Trevor Woerner <twoerner@gmail.com>
> Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx
> boards
>=20
> [External]
>=20
> On Thu, Aug 29, 2024 at 03:06:31PM +0000, Gaskell, Oliver wrote:
> >
> >
> > > -----Original Message-----
> > > From: Tom Rini <trini@konsulko.com>
> > > Sent: Thursday, August 29, 2024 3:52 PM
> > > To: Gaskell, Oliver <Oliver.Gaskell@analog.com>
> > > Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Malys=
a
> > > <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>;
> > > Bimpikas, Vasileios <Vasileios.Bimpikas@analog.com>; Agarwal, Utsav
> > > <Utsav.Agarwal@analog.com>; Artamonovs, Arturs
> > > <Arturs.Artamonovs@analog.com>; Rayagonda Kokatanur
> > > <rayagonda.kokatanur@broadcom.com>; u-boot@lists.denx.de; Linux
> Factory
> > > <adsp-linux@analog.com>; Trevor Woerner <twoerner@gmail.com>
> > > Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices
> SC5xx
> > > boards
> > >
> > > [External]
> > >
> > > On Wed, Aug 28, 2024 at 11:02:08AM +0100, Oliver Gaskell via B4 Relay
> > > wrote:
> > > > ADSP-SC5xx is a series of ARM-based DSPs.
> > > > This comprises the armv7 based SC57x, SC58x and SC594 series, and
> the
> > > > armv8 based SC598.
> > > >
> > > > This patch series includes configurations, init code, and minimal
> DTs
> > > > to enable Analog Devices' evaluation boards for these SoCs to boot
> > > > through SPL and into U-Boot Proper, as well as devicetree schemas
> for
> > > > the added DTs.
> > > >
> > > > This patch series depends on ("arm: Add Analog Devices SC5xx Machin=
e
> > > > Type") (https://lists.denx.de/pipermail/u-boot/2024-
> April/552043.html)
> > >
> > > Since that series has been merged since early May, what is this serie=
s
> > > based on top of? It should be based on top of current (or close enoug=
h
> > > to not matter) -next. Also, has everything been passed through
> > > checkpatch.pl and the results looked at? Thanks.
> >
> > I made it on top of -rc1, just tested and I think it applies cleanly
> > to -rc3 and next. Wasn't sure on the policy re. patch series
> dependencies
> > so just wanted to be 100% sure that was clear.
> >
> > It has been run through checkpatch, there's a few warnings that I think
> > are OK. Only warning I missed is about the Co-developed-by tags not
> > having matching Signed-off-by tags - if this is an issue I can make a v=
2
> > that fixes this.
>=20
> OK, thanks for elaborating. I forget, what is the plan to upstream these
> dts files?

We're currently in the process of upstreaming support for a single
platform (SC598) to Linux, and others will likely follow, so we'd like to
have the minimal device trees in this patch series in U-Boot for now so
it's possible to boot the boards from source. As and when the devicetrees
are in Linux, we will remove them and enable OF_UPSTREAM for the relevant
boards.

Thanks, Oliver
