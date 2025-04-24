Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B22C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 19:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1A68056A;
	Thu, 24 Apr 2025 21:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="Y3d7PVFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E5480F9C; Thu, 24 Apr 2025 21:38:14 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C1F803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 21:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OIl3gf026088;
 Thu, 24 Apr 2025 19:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps0720; bh=oDYEKAxUt+2w4oV3N+5MTMCdtN
 DG4pr1azBAa+VPRPs=; b=Y3d7PVFHGern0AbuSnwy2g7b21NiXMn6cr5eyw+Y9r
 CfV3ErN9y4I3D9DglHYFkJI4GQD5GKYUa2RkEPbEussLe6TmAb3AFT2ecPTIkFnC
 JwchADHSFF+IZza0YlzlPd2tinjfDE4kcHaGnGbdnepamuycrz6agdRYlyeAKcPY
 kYOWk3aqvhTb28Xfc7Vp712IaZMMJTCfJsSQY6vUpgEDZ81kKYPkif/lixGZEupR
 GeDiY6dHJES0yYbvH06xCn7cLexlBj4TpoW/RNsQ0z+2LdJwgSl83ulFbdz1u7Fo
 WIdy34hIcgqRK1k4z/UR9hOMGYSxWAfV82nMVR4oX0Wg==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 467tvbgcs9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 19:38:06 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 9C978805EA5;
 Thu, 24 Apr 2025 19:38:05 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 07:37:56 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Thu, 24 Apr 2025 07:37:56 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 07:37:55 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ/Bi4luIFyKkBMQlfg1QqbZw32qGbKsyUGqEwdNTLcewG1/wbCxCt8rZ2V6ACov0rz207UhJBVZaROFo2GzbKZRX8Qr+0RU7O8hYiXm+oV9qnkboZ70vEkhikV9ml2PWbKCXTPpP9G3T13k8fM7jRTS2YTUBSIysX/atFu0wBtMzoMKrZKqKz9RZL9kNoTRgz5u6txD2VSBzu0zyRMiNxHAvg4Kwzg63FmkCb/vCxY+Brq2izo+6/QgjHhjnSYN5vCBOquj+gwtlfB7mgvRojpS90iN2B2CCW3bXyT2a/YRrgWiTnTKN67y8x+SLITBpisrco3gNrIj1wSQKdm9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDYEKAxUt+2w4oV3N+5MTMCdtNDG4pr1azBAa+VPRPs=;
 b=GV0GWkIAShlh+EgD5g4OczPrA09GfRfzK2Yaim3k+k7BJVafGOUvZiZS2Ld9HKobNpBFjks4p7txqkIhNIEbIYYmY1HxDBW+pV9ECN1r6K+Jpy6LCtXda7pxxG8RCjIPkAk3xyKzswBYOffLzkDaBtEzmhtzDNiLHLD0gAU+oAc7/rnxWLsHwAkruDmnasIGZYRRtk0B6fzIQ6Qr2gpiKx7UrIDo3w3HLlNVvrB/ZvEGwefGdsCDHPDUyuIFb1hCyOhOAM0/e7jwDqaRuJY1aJD3vYVIjgOAVP/ksse9X906zK2a+TDKBIRdGzrgbab0b24dR/CCYtEVvKiHIkXUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 PH8PR84MB3260.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1c8::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.32; Thu, 24 Apr 2025 19:37:53 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 19:37:52 +0000
From: "Verdun, Jean-Marie" <verdun@hpe.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: Wiznet w5500 support
Thread-Topic: Wiznet w5500 support
Thread-Index: AQHbs7P1niICEprfvUOJM72ihHrWULOw9bKAgABbxYSAARrmAIAAxx8O
Date: Thu, 24 Apr 2025 19:37:52 +0000
Message-ID: <DM4PR84MB197653BEC82144BDD411E631D6852@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
References: <DM4PR84MB1976607AFF39ADF74D9AAF7BD6BB2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <3f221717-b5a2-472c-888c-cc8f777cde40@cherry.de>
 <DM4PR84MB1976A520AABEBD2B1C243683D6BA2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <08c0575f-1a55-487f-825b-4246553e6b86@cherry.de>
In-Reply-To: <08c0575f-1a55-487f-825b-4246553e6b86@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1976:EE_|PH8PR84MB3260:EE_
x-ms-office365-filtering-correlation-id: 0296cd43-7352-49ec-4263-08dd83678138
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R0l6RDIzR01ZUFkrYTNHN05lVjd0WUprU09FdTY0ZjlQTlM4dWNwRC9UcGNN?=
 =?utf-8?B?QXg2YW1kYnJLaVQ4dW81Nm0vaHVGeDR1ck5GM3ZBdmRkUTB6N3hLLzQrWEJR?=
 =?utf-8?B?VEw1UTRyVmJQbk1iZmxTcFh0dzlUYW5uQXJ3dVBLSGZydEd2N0RGdkhxWXgz?=
 =?utf-8?B?OUpGSC83ZUJ5bmZPZ0ovdnYzZ2FLU2t5VEUwWXVXZEw1Y3BFNCtZcS9VWHNU?=
 =?utf-8?B?SDNCWWk3MlRTbytXK1dGWnNsZWxZdDVtVGh6SU5kMnIwcjBkaURzTnVJS2cz?=
 =?utf-8?B?YW5rMS9CMklSRGxsYVpsTWtRc2lYOVNMWElUSE1XTmpFZDNnWnpoN3BOYUxY?=
 =?utf-8?B?NXZQOGs3S0Rpck1lZGc2c2FjQXZJbngvR1djbVo4TXpLaThLRW1EdlNnUjdI?=
 =?utf-8?B?TG9ac3lyVnVydXF6bFRjTjdjRENvd2ZCS1IxRGI4LzUyZ3VEMVpLOUxIM0xH?=
 =?utf-8?B?OVpLYWx6N2dHMHNUWUdrK2ZWZzkwcU9QTHJWY0tjaHV6azVuTVVkbnJpYVVq?=
 =?utf-8?B?bXZKTnRpNWJaZ29EQk0zcFZSSG9EZHJ3V3UzK2pIQWpPQndzNlM3UGN2dzNi?=
 =?utf-8?B?VWdyTkVNT0R3WFZHT3lSZVQyS24vaXFzU01UZ0U0RkJuNGhWL2hDckYwQ1Q5?=
 =?utf-8?B?blhjWGU3WDZGc2k1YlF2bXVyRFZjK3pGb25XRWVCOFpJWW9SOW5yTVVFcnRC?=
 =?utf-8?B?cTV6QVpaY2wyN0JsVnZlUXpPdTRnNit1V2JCc2JxUWwzaEFGWFVFTDZMQnpZ?=
 =?utf-8?B?MU5vSkJwM3VGeExqT0c0ck0yQ2hFUWl0YzIyVVR0ejlBcTJzd2p1WnBPUVcx?=
 =?utf-8?B?M3BJRFFlRHRjKzRaRDZ2YkxYQzEzTXBhU3ZMZXJhZk11dUdLQy9HV0g5SmNP?=
 =?utf-8?B?eTNrOElYN1pxOFlWc3VzamdVS0JqbzE1NngyRU9ETGJCdWw3ZTJiTEIvNHdr?=
 =?utf-8?B?Z2xWOGdNd1NvMGk5bFdDb0UxOGErU242OUZrZGVwYk93cU1hTzk4MmNBNmpm?=
 =?utf-8?B?QzNNOVdSUWluMWh4TVBQN2thZGFYMGtwcERvelV0Qlo4T1N3WHpLVnU1TWJV?=
 =?utf-8?B?ZHpwMnpuY2N3SEVWRkIwU01HaHU3Szd6eHc4SWZrZnd0ZUMyQ2dXTEFZM0R3?=
 =?utf-8?B?bU1uQ0lzdW9yejVSQ1JZYzAyTkhDcEM0SHZzdkV4dy9aOThKNXV0UzBHZ3Ew?=
 =?utf-8?B?M29iOTUyYmlVTGo3NVI1NG5uQW1oNmVsU01DZHgvcVlZa1g4ZEFxL3R4YkRV?=
 =?utf-8?B?WFMzZDVST21RNFZZbDlBazZZaTViYUp4Mko3ZmQrRUV2YTJwcGtHbGZMZ1lu?=
 =?utf-8?B?bE1kQjZ6cHF3WFVicHZaa2E2Z0NKVHN4aDFtbHhGQVpMUkVYaTZHeVE2bXlS?=
 =?utf-8?B?WTQ2RUtVUStNVWxDYkJrSmpJWmhMZXZHNjRUcW1iYU1wQjBzWkU1ekR5UFV6?=
 =?utf-8?B?anZSWHpRcDFncTdIcTZZUnBtOWkwVEdack1zTHBiSm5XTVZrdGRDNDd3cmRj?=
 =?utf-8?B?bDd5Y24xTWtsbFJSdmZOUW5qUkZpMWh6bGp5c2tJdkNYZ2xsNTVFRkdSdFdz?=
 =?utf-8?B?ZFYzdFZCU3k3M3dncDl0Yld2YmdxTDBFNjZVeWhkS2RKRjJFMVhPZjFEN2VZ?=
 =?utf-8?B?N2EvN0xhMGF2Z3Y3VDgzZkUwUEtuR0kyL1NJNWJOeXBFcWJVeTN1SmFvYkNp?=
 =?utf-8?B?dXQwdDBUM2tXM29BcU16Q2tYRG95RHo1enRvWmJQeEYyc0J4dm5ObDFNdEdy?=
 =?utf-8?B?MXZ6dExWcElBckJkZjd0TnJPVzlFM3F0YVdiMDlsNDhqMVVWMkM5dkhzSVRM?=
 =?utf-8?B?QTB1bCtGZ2MrS0RRYzBOZFEzNTJMa0pmM0g5d1o5d1F4RUJuUDFQTVRza3NH?=
 =?utf-8?B?bjVTU1hTNGxEaUJKT2tWVkFEbk5ZRDU0dDh2a0JBSzAyUzRJTmFaYW1HNjBO?=
 =?utf-8?Q?kDKbdFyA1MghEuC/q5p2GS6BWXlf2Lbp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEg4SlpEK0xTMTR6ZFNOY3krVUZHRitTT2RCanQyV05Wem4veFVtQWUwVXdT?=
 =?utf-8?B?bXhNTzg5dVZjOWh5bjByZmIwOTRwMFV6SUo0WFdmbE5Ld0F5SzJNckRuVGZV?=
 =?utf-8?B?YVpiMm5HRkE4SmcrdEpkYXpkMEFvUDRFNnNpc0QvNXNQV21xTklVWGlJZHFV?=
 =?utf-8?B?dE9xN3NSQXMwMVZ6ZXFjMVhkWGZ3L0o1YWxYb1BFcXdtZW85RDNIN2ZRSWgx?=
 =?utf-8?B?WGNCUTUvdjY2N1czYmdkQzFZODRxcVV3L1VoUGlaSnZQSW9tQ25mb2E0RlI1?=
 =?utf-8?B?N0ZRSmhJaXNyMCs4R1ExRWVIdE1SdFpuc2Vtd2NOWEhtWnE2WDBlS1VuM0Rx?=
 =?utf-8?B?aS9OeGlmNENKN2F0OEdiZCszNmpIVXFGRFduR1Z0am1RWWtUWUJQK1hjTk9l?=
 =?utf-8?B?ZWY5TkhIT2R2TktINFNzaG9tUDg2eE41Z0p1WXcrNjVQWUY2Mks2VDNSKzJO?=
 =?utf-8?B?L0xuMEMyMmhIclRnVWM2YWlrVEl0bXNxN1R6WHU3TE9aYmp2Vng1R0haNlRU?=
 =?utf-8?B?OWtMS1Q2L1gvaFNuOFV2NXlHbjgwNUUvVzljaVJaSUhVbXBGQkdrSG5jbjRJ?=
 =?utf-8?B?R3lDbm5UWlYvVzZUYzZldEVyTTQxcnM3Y0Y0cUpzUWU4bTRvQ0F1U2F2N2Nh?=
 =?utf-8?B?Ulk1MGpxUTkwWW9ab1pJN0xjYVRNZTJFdkR1SlJaWDMvSVJzaGJpTEQxTEZV?=
 =?utf-8?B?ZHpPVHJEWnM0VktzSng5T09TNjV1ZS8xM1FJWE0ycGt4TktHenhFZTRCM25D?=
 =?utf-8?B?VVRudTdKU1dTOHBnUWFWODJET2hVV2QvOFRhZG5hd2FCdURJK1AwTE4xK0Jl?=
 =?utf-8?B?cGpqRk4zZ2RMRnFKSHBxVzd4RE43UEtqY2pJVWNUWXNmb1ZkaE1tbk1scCtZ?=
 =?utf-8?B?YjhQa2N5SGdVNmVIeTBBQ1lzZ1FnUDUvOTNmOHd5anhwTGxxd2pRd1IyYnh1?=
 =?utf-8?B?RFUyWGRBTXAxRXovWUwwUjhqeGpEUnpTRFh4RWQyOGpYemp3am9ianA5SjRa?=
 =?utf-8?B?dTkwOXVvSWttTWxNbmxGenZCd3FWTCtoQ3V6Mll0RSt6aXdzTjNUWFFvZncx?=
 =?utf-8?B?Y25Rckc3ZVBScVBPWTB6M0Z5Umd6d1VTK3JxbVBLb1R6bGRMejg3bmR5NXo3?=
 =?utf-8?B?OEpmSnFwVk9NVWdXaFZlOGp6MjN6Skw1L3REdE1yaWFMQzRHdVMzNFk1bExw?=
 =?utf-8?B?SCtuSkNCbXRmdTBxL1dvV2grRW5qdjU1dXNuWCtuLzlkSGhSZWRBTlpWVndE?=
 =?utf-8?B?S3B2a1RwUUhxcUU1KzNHK1JPNlJxRGFKSGJBbk5pd2xDeWp5R0pMUnA3S3E1?=
 =?utf-8?B?eVIyV1I0dFlmdFhoOFlrWHJXVnFnWUc2eDk5NHpPQkI1TGpSUjBTalJQZVRx?=
 =?utf-8?B?eUJ4ck1PN3BwK2dRd0NIaXQ5dUNRY044R01ZLytkeEFMT2FkUjdLT3Rlb2dr?=
 =?utf-8?B?eVNhV092UEJlTjdyVEp3Q2NhNm5MNHFkOUUrZ2VaTEVON1M3dkMyUG1MWll2?=
 =?utf-8?B?QTFaVHlCT2grQStzVzFFcEltbURTUHd5eng3ZzBHSUI0T1ZtcE80M0xhSSsx?=
 =?utf-8?B?NURoZDhwYTFUWEE5YTJCRDR0YmJsdkdsM1lnejVYSmhBSXFWZWh5dzFnazlR?=
 =?utf-8?B?UXhZZGczR1RFV0h6cit1Y0lpa011Mit2VngyUUE5SHpqajNHeS84WnFRNnd6?=
 =?utf-8?B?WjV3cVpCRERjeGFCN2dyb2lFTkRvRDJGd0RyNzQvNldVY2lvSmRKM2xLRWRP?=
 =?utf-8?B?RngvTTNkQWdMTnY2Z2dEY3ZORlF1YzdQV1duRENsU2g2b0x6TEZFeVM2YnVG?=
 =?utf-8?B?Y05YeVR3UTdvelFOcnlMemZ6VTh3aXJINEhDS0tPNVVmaENHR0JVczg2Qmxi?=
 =?utf-8?B?MFlvVGEwZkFlMUFGU0lJMGFKU0s3UWFadE9CaVFDK1I2UXNSWGk4QURDWEwr?=
 =?utf-8?B?UnE4SkNxZ2NNRHZkT3VhaUVSTTVkZnNiTTBCbTdrYjVUcDExeExrQU9MVkJE?=
 =?utf-8?B?bXpuOFpHbGZhSW43NUJPcXNEOEhmTDE0VUJldjkzellNaldwRHU1U1hNbi9y?=
 =?utf-8?B?dzFiSktrQnp4LzduNHJRQW01TlFtRTQ5ZlZkMVF2STZFS1M2V2puUG1DamNv?=
 =?utf-8?Q?mWiHxBVcbKD5mia1Hf0V84Puz?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0296cd43-7352-49ec-4263-08dd83678138
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 19:37:52.8812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMf2GgIRS/XHldXVYMVKoFnnJM+xo3uf1ec52pcdd2uooFEJunrvYnUEWx8lJAT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR84MB3260
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 6WcBnQ_A2_LSJPOMbaRbLqQZpOiKFWGI
X-Proofpoint-ORIG-GUID: 6WcBnQ_A2_LSJPOMbaRbLqQZpOiKFWGI
X-Authority-Analysis: v=2.4 cv=J4Wq7BnS c=1 sm=1 tr=0 ts=680a931e cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=_EeEMxcBAAAA:8 a=XpE1AkgCAAAA:8
 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=i4amFML56KH8QqtZ9LwA:9
 a=QEXdDO2ut3YA:10 a=cWrrghZYQEAA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8
 a=NKX7cVKAccYLdryK1I8A:9
 a=8ZJCIiS-EN31ZJHw:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10 a=dpZMgbseYPk84XhQl7oQ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDEzNyBTYWx0ZWRfX0IGRhOlQLmjN
 BeTIjACGveQYG09KwJqPXLXoDjmhCleZ7TCu8SqEr0pqYbrY/wo95ETEdSJZewXInrYZQND+4kB
 G0dDHe2d/8wgdJp83DRsCwpP1h1LdUcL4m2j+k3gy7j/R+iP5soImeWDcTo/ZFnKQKXWiAYOBbz
 aNJl+VaDd8tS8SGZsxnoAzJcXYvZX92i8DGVcVlUT0i+QI6hQpXksX1f8+92BbpJoup1v7JtEuv
 vWRpGve7x05hRgI3OhOZj8IxSH5TG+Mgdcw45QvS/VYbzpPAldKyAAU3kvZw2R9mnQucfMLI2Zw
 ayvuxnjVT9rPVThWzZ7rOCXxJVuWDECfmIaODkvbCG4gp9/whAfZfjL1XwBv3smzFdSa8mkQHV5
 ScqUKqvk
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504240137
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

SGkgUXVlbnRpbiwNCg0KSSBoYXZlIHVwZGF0ZWQgdGhlIGNvZGUgb24gbXkgZ2l0aHViDQoNCmh0
dHBzOi8vZ2l0aHViLmNvbS92ZWptYXJpZS91LWJvb3QvdHJlZS93NTUwMA0KDQpJIGhhdmUgYWRh
cHRlZCB0aGUgY29kZSBzdHlsaW5nIGFuZCB1c2VkIExpbmRlbnQgYXMgd2VsbCBhcyBjaGVja3Bh
dGNoICh3aGljaCBpcyBzdGlsbCByZXBvcnQgQ2FtbCB2YXJpYWJsZSBuYW1pbmcgaXNzdWUsIGJ1
dCB0aGV5IGFyZSBjb21pbmcgZnJvbSB0aGUgbGludXgga2VybmVsIGFuZCB0aGluayB0aGV5IGFy
ZSBhY2NlcHRhYmxlIGFzIGlzKS4NCg0KSSBhbHNvIHJlbW92ZWQgdGhlIG5lZWQgZm9yIHRoZSBz
cGkgcGFydCBvZiB0aGUgZHJpdmVyIGFuZCBoYXZlIGEgc2luZ2xlIGRyaXZlciBub3cuIFRoZSBj
b21wYXRpYmxlIG9mIHRoZSBkcml2ZXIgaGFzIGJlZW4gdXBkYXRlZCB0byBtYXRjaCB0aGUgbGlu
dXgga2VybmVsIG9uZS4NCg0KSSBuZWVkIHRvIGZpbmQgYSB3YXkgdG8gc2VuZCB0aGUgcGF0Y2gg
aW4gVFhUIG1vZGUgb24gdGhlIG1haWxpbmcgbGlzdCwgaWYgeW91IGJlbGlldmUgdGhhdCB0aGUg
Y29kZSBpcyBnZXR0aW5nIGNsb3NlciB0byB3aGF0IHRoZSBjb21tdW5pdHkgd2FudHMuDQoNClRo
YW5rcyBhbGwgZm9yIHlvdXIgc3VwcG9ydCBhbmQgaGVscA0KDQpKZWFuLU1hcmllDQoNCg0KRnJv
bTogUXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QGNoZXJyeS5kZT4NCkRhdGU6IFRodXJz
ZGF5LCBBcHJpbCAyNCwgMjAyNSBhdCAxMjoyNOKAr0FNDQpUbzogVmVyZHVuLCBKZWFuLU1hcmll
IDx2ZXJkdW5AaHBlLmNvbT4sIHUtYm9vdEBsaXN0cy5kZW54LmRlIDx1LWJvb3RAbGlzdHMuZGVu
eC5kZT4NClN1YmplY3Q6IFJlOiBXaXpuZXQgdzU1MDAgc3VwcG9ydA0KSGkgSmVhbi1NYXJpZSwN
Cg0KT24gNC8yMy8yNSA0OjM3IFBNLCBWZXJkdW4sIEplYW4tTWFyaWUgd3JvdGU6DQo+IFlvdSBk
b24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB2ZXJkdW5AaHBlLmNvbS4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50PGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2FrYS5tcy9M
ZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb25fXzshIU5weFIhaHo3NFdHRzRHNVYzNEZUbXJi
em5TLUx0ZlcxbDBtaVNBaGRBdElUX21xLTVoNUItandaNmVPcG94SWpJNk5wRVJWX2pLZ21FZGQt
bXk3S0FlMG52NHFvJCA+DQo+IEhpIFF1ZW50aW4sDQo+DQo+IEkgd2FzIGxvb2tpbmcgZm9yIGV4
YW1wbGUgbGlrZSB0aGUgb25lIGluIHBtaWMuIEkgd2lsbCByZWZhY3RvciBteSBjb2RlIHRvIHRh
a2UgaXQgaW50byBjb25zaWRlcmF0aW9uLiBUaGF0IGlzIG15IGZpcnN0IGRyaXZlciB0aGF0IEkg
c3VibWl0IHRvIHUtYm9vdC4NCj4NCj4gVGhlIGxpbnV4IGtlcm5lbCBoYXMgYSBzcGkgc2lkZQ0K
Pg0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvd2l6bmV0L3c1MTAwLXNwaS5jDQo+DQoNClllYWgsIGl0J3MganVzdCB0
byBzdXBwb3J0IHRoZSBTUEkgd2F5IG9mIGFjY2Vzc2luZyB0aGUgcmVnaXN0ZXJzIGZvcg0KdGhl
IHc1MTAwIGRyaXZlciB3aGljaCBzZWVtcyB0byBiZSAibm9ybWFsbHkiIE1NSU8uDQoNClRoZSBu
b24gLXNwaSBkcml2ZXIgaXMgc3RpbGwgc3VmZmljaWVudCBmb3IgTU1JTyBJUHMgKEludGVsbGVj
dHVhbA0KUHJvcGVydHkpLCBsaWtlbHkgdGhlIG9uZXMgaW4gYW4gU29DL01DVSBhbmQgYWNjZXNz
aWJsZSB2aWEgc2ltcGxlDQp3cml0ZWwvcmVhZGwgdG8gYW4gYWRkcmVzcy4gWW91IGNhbiBzZWUg
dGhhdCBiZWNhdXNlIHRoZSBkcml2ZXIgaGFzIGENCnBsYXRmb3JtX2RyaXZlciBzdHJ1Y3Qgd2hp
Y2ggaXMgdXN1YWxseSBmb3IgZHJpdmVycyBvdXRzaWRlIG9mIHRoZQ0Kd2VsbC1rbm93biBidXNz
ZXMgbGlrZSBJMkMsIFNQSSwgZXRjLi4NCg0KVGhlIC1zcGkgZHJpdmVyIGlzIHJlZ2lzdGVyaW5n
IGFuIHNwaV9kcml2ZXIgc3RydWN0LCB3aGljaCBpcyBmb3INCmRldmljZXMgb24gYW4gU1BJIGJ1
cy4gSXQgZG9lcyBjYWxsIHc1MTAwX3Byb2JlKCkgZnJvbSB0aGUgbm9uLXNwaQ0KZHJpdmVyIGFm
dGVyIHNldHRpbmcgdGhlIHc1MTAwX29wcyBhbmQgYSBmZXcgb3RoZXIgdGhpbmdzIHByb3Blcmx5
Lg0KDQo+IEFuZCB0aGUgZGV2aWNlIHRyZWUgc2V0dXAgaXMgYSBsaXR0bGUgYml0IGNvbmZ1c2lu
Zy4gUm91Z2hseSB5b3UgY2FsbCB0aGUgbmV0IGRyaXZlciBmcm9tIGEgRFRTIG5vZGUgd2hpY2gg
aXMgYSBzcGkgc2xhdmUsIGFuZCB0aGUgbmV0IGRyaXZlciBpcyBwcm9iaW5nIHRoZSBzcGkgc2lk
ZSB3aGljaCBpcyBub3QgYXR0YWNoZWQgdG8gYW55IERUUyBub2RlLiBJIHRyaWVkIHRvIGRvIHRo
ZSBzYW1lIGFwcHJvYWNoIHdpdGggdS1ib290IGJ1dCBkaWQNCg0KV2h5IGlzIG5vdCBhdHRhY2hl
ZCB0byBhbnkgRFRTIG5vZGU/IFRoZXJlJ3MgYW4gb2ZfZGV2aWNlX2lkIHRhYmxlIGluDQp0aGUg
c3BpIGRyaXZlciwgc28gaXQnbGwgbWF0Y2ggYWdhaW5zdCB0aG9zZSBjb21wYXRpYmxlcyB3aGVy
ZXZlcg0KcmVxdWlyZWQgYW5kIHByb2JlIGEgZGV2aWNlIGZvciB3NTEwMF9zcGlfZHJpdmVyLg0K
DQpDYW4geW91IHByb3ZpZGUgdXMgd2l0aCBhbiBhdHRlbXB0IHlvdSBtYWRlIGF0IGRvaW5nIHRo
ZSBEVFMgd2l0aG91dCB0aGUNCnBoYW5kbGVzPyBNYXliZSB0aGVyZSdzIHNvbWUgbWlzdW5kZXJz
dGFuZGluZyBzb21ld2hlcmUgb24gaG93IHRvIGRvDQp0aGlzIChvciBhIG1pc3Rha2UgaW4gdGhl
IGRyaXZlciwgdGhlcmUgZG9lc24ndCBzZWVtIHRvIGJlIHVwc3RyZWFtIERUDQp1c2VycyBvZiB0
aGF0IGRyaXZlciA6LykuDQoNCnN0cnVnZ2xlIGEgbG90IGF0IGRvaW5nIGl0LCBhcyBpdCBzZWVt
cyB0aGF0IHUtYm9vdCBuZWVkcyB0byBoYXZlIGENCmRldmljZSB0cmVlIG5vZGUgYXR0YWNoZWQg
dG8gZWFjaCBkcml2ZXIgdG8gZ2V0IGl0IGFjdGl2YXRlZC4NCj4NCj4gSSB3aWxsIHRyeSB0byBn
ZXQgYXMgY2xvc2UgYXMgdGhlIGxpbnV4IGtlcm5lbCBkby4NCj4NCj4gVGhlIGdvb2QgbmV3cyBp
cyB0aGF0IGl0IHNlZW1zIHRoYXQgSSBkbyBub3QgaGF2ZSBhbnkgcHVzaCBiYWNrIHRvIGdldCB0
aGF0IGZlYXR1cmUgb25ib2FyZGVkIGluc2lkZSB1LWJvb3QuDQo+DQoNCiBGcm9tIHVzLCB0aGVy
ZSdzIHNlbGRvbSBwdXNoIGJhY2sgd2hlbiBpdCBjb21lcyB0byBpbmRpdmlkdWFsIGRyaXZlcnMs
DQpzYW1lIGZvciB0aGUga2VybmVsLiBJdCdzIHVzdWFsbHkgb25seSB3aGVuIGNoYW5naW5nIHRo
ZSBjb3JlLCBzdWJzeXN0ZW0NCm9yIEFQSXMgdGhhdCB0aGluZ3MgdGFrZSBtb3JlIHRpbWUsIGRp
c2N1c3Npb25zIGFuZCBjb21wcm9taXNlcy4NCg0KPiBUaGUgY29kZSBJIHdyb3RlIGlzIHJlYWxs
eSBhIHF1aWNrIGFuZCBkaXJ0eSBpbXBsZW1lbnRhdGlvbiBhcyB0byBydW4gYSBkZW1vIG5leHQg
d2VlayB0byB0aGUgT0NQIFN1bW1pdCBpbiBEdWJsaW4uIEkgd2lsbCBub3cgbWFrZSBpdCBjb21w
bGlhbnQgd2l0aCBjb2RlIHN0eWxpbmcgYW5kIGV2ZXJ5dGhpbmcgbmVlZGVkIHRvIGdldCBpdCBh
Y2NlcHRlZC4gSSB3aWxsIGp1c3QgbmVlZCB5b3VyIGhlbHAsIHBhdGllbmNlIGFuZCByZXNpbGll
bmNlIHRvIGd1aWRlIG1lLg0KPg0KPiBGb3IgdGhlIG1vbWVudCB0aGUgb25seSBjb2RlIGNoZWNr
LCBJIGFtIGRvaW5nIGlzIHRocm91Z2ggdGhlIGNvbXBpbGVyIHdoaWNoIGRvZXNu4oCZdCByZXBv
cnQgYW55IHdhcm5pbmcuIEkgd2lsbCBhZGQgb3RoZXIgY29kZSBjaGVja3MgZnJvbSB0aGUgbGlu
dXgga2VybmVsIG1vdmluZyBmb3J3YXJkDQo+DQoNClBsZWFzZSBoYXZlIGEgbG9vayBhdA0KaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZG9jcy51LWJvb3Qub3JnL2VuL2xhdGVz
dC9kZXZlbG9wL2luZGV4Lmh0bWxfXzshIU5weFIhaHo3NFdHRzRHNVYzNEZUbXJiem5TLUx0Zlcx
bDBtaVNBaGRBdElUX21xLTVoNUItandaNmVPcG94SWpJNk5wRVJWX2pLZ21FZGQtbXk3S0FlOXI4
aHVJJDxodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6L2RvY3MudS1ib290Lm9yZy9l
bi9sYXRlc3QvZGV2ZWxvcC9pbmRleC5odG1sX187ISFOcHhSIWh6NzRXR0c0RzVWMzRGVG1yYnpu
Uy1MdGZXMWwwbWlTQWhkQXRJVF9tcS01aDVCLWp3WjZlT3BveElqSTZOcEVSVl9qS2dtRWRkLW15
N0tBZTlyOGh1SSQ+ICwgSSdtIHN1cmUgdGhlcmUncw0KZ29pbmcgdG8gYmUgc29tZXRoaW5nIG9m
IGludGVyZXN0IHRvIHlvdSB0aGVyZS4gU3BlY2lmaWNhbGx5IGNvZGluZw0Kc3R5bGUgYW5kIHNl
bmRpbmcgcGF0Y2hlcz8gTm90ZSB0aGF0IFUtQm9vdCBhbHNvIHN1cHBvcnRzIHNlbmRpbmcNCnBh
dGNoZXMgdmlhIGI0LA0KaHR0cHM6Ly9iNC5kb2NzLmtlcm5lbC5vcmcvZW4vbGF0ZXN0L2NvbnRy
aWJ1dG9yL292ZXJ2aWV3Lmh0bWwgLg0KDQpQbGVhc2UgY29uc2lkZXIgdXBkYXRpbmcgdGhlIGJp
bmRpbmcgaW4gdGhlIGtlcm5lbCB0cmVlIHRvIGEgWUFNTCBvbmUgc28NCnRoYXQgYm90aCBwcm9q
ZWN0cyBiZW5lZml0IGZyb20gaXQgOikNCg0KQ2hlZXJzLA0KUXVlbnRpbg0K
