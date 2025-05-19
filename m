Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD0AC2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 12:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420FC81FEE;
	Mon, 19 May 2025 14:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="KGlH07d9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88A382B0E; Mon, 19 May 2025 14:24:33 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED3281E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 14:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J3WTTU004996;
 Mon, 19 May 2025 12:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps0720; bh=oNN5RcmzNemS5+YXGFYXKj3LF7
 Fbnu0G4orB+OgaVdQ=; b=KGlH07d9Z1/CQQ+gg/7BvegxF25k0Qls2XxZft4yfd
 r9kQl3X5lp5t3AbuwtWkfu1IMYgaISM38eP+MPO6LBYBKM0HZ5doY9Wr5DzGIwYD
 mYoO5m5/uiDIjc/w8RPxO4eRylEDCzGlqst1Un4pqq4j5tJzvm3odwCaVHmZqPgA
 IYgmXqatf7Q0U2nva/2NsiaB5G6z21r11T75aXdWV6KJsdchLCgJU2vdsPzQh35x
 +B5sLA6BxRnpkujn4RUMgkHm5D5+zhlAtD3kxnZM3InxL5hq96dqpqOWWbyw/NRK
 4ArtJ81BuCW0VEDVkUTb+8x3E2RRvtjcxooBNcg48uEA==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 46qjf4paej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 12:24:23 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D3439131AA;
 Mon, 19 May 2025 12:24:22 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 00:24:21 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 19 May 2025 00:24:21 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 00:24:18 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I31E9H0wxM65l/KquFyT4NP9GZtC3RuZt7rn7BkzqeBCEsVQ/qzlby/U3b/ikCG1Hd15/5xAwGKl1QbX1YXd985B9kC6J8uSsfaJBSfdLZeS8tDYYL30a6+MzSp6vUOmwwIp2Auy2ys5EoarqPocionEyjRFjXrmjrzSwz6L4lPT6RX47jhQee/LI8cSjRZefVGxN3g5xA97CM5skvjczLTslHl0itqEIBfrpMKQajkk6oURvalE61sOToc+A76fYPaQ//+u248z8Y+lLLZxUMLv9Nri6XPVro5mGY5/ejmUGtwk9A7WrI9px50DDSLZ9YjYq9HiPtK7EaF6BgsBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNN5RcmzNemS5+YXGFYXKj3LF7Fbnu0G4orB+OgaVdQ=;
 b=Eq6D82svI93DDzvmVHIR+b5QuwWhYaEOrc/fRj3eljdgzMJp3IAjdDQEru/5YnWeau4n4KtoT6H/5W7HYZjKO3y3N46nVmRSfG2flob/Ijutp37JnbGMewIHgbHHVgIMyNtDFykiFywMtY2NprXh2Q5PoMbKYcTQxyK6HRG42IcGuzqAee6XzqVOpYXcO9IecQZojRxWi7u44FyYvfk1eUNnA0rs20zY1iw9MLKy/PRHjs3X19SoeC5e4g3OhzCVbaMQpsiUipsevI95nD8LcLBv7sz/JQvWVFirpEcMxqh9dAOPXzbAI3/Yu4NMBS4UV+lvl0OKG+m4U8mA/q3DFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 SJ0PR84MB1895.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:435::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 12:24:16 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a%4]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 12:24:16 +0000
From: "Verdun, Jean-Marie" <verdun@hpe.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, "jmverdun3@gmail.com" <jmverdun3@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/1] Initial support for Wiznet W5500
Thread-Topic: [PATCH v4 1/1] Initial support for Wiznet W5500
Thread-Index: AQHbwp7xIrnosPKZPkmFc0YqeiDvV7POpWqAgAAZ0gCABP0MmoAF8FWAgAAGdeGAABngAIAAHo0q
Date: Mon, 19 May 2025 12:24:15 +0000
Message-ID: <DM4PR84MB19763571780C01B600C81BA7D69CA@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
References: <20250511180207.42945-1-verdun@hpe.com>
 <20250511180207.42945-2-verdun@hpe.com>
 <91db507e-8fab-42cd-88dc-300372ceee68@linaro.org>
 <5dc908b9-6659-47bb-bcad-134871ecac28@cherry.de>
 <DM4PR84MB197689F8308F8FBB04CF96CBD690A@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <8e930859-c73b-4bd8-b58e-474b3e70e15d@cherry.de>
 <DM4PR84MB19761284E20ABD1F1F8ED8C5D69CA@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <55d8bcb9-9f49-49e3-a0b9-02b7b7a7ff12@cherry.de>
In-Reply-To: <55d8bcb9-9f49-49e3-a0b9-02b7b7a7ff12@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1976:EE_|SJ0PR84MB1895:EE_
x-ms-office365-filtering-correlation-id: 436795e0-2881-45f6-855c-08dd96d01240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?k/B1blxsufzwds3YqqYIdcwJTTUNGlmjAfVZtelL8F290Ed6zw0gLEIe?=
 =?Windows-1252?Q?ef8JTRWmGW4SYH6gp4aE5KhjocW1e1PYyYIAsFssdW4iK5agJUj2kRt2?=
 =?Windows-1252?Q?z5jlJy3xoAEv/tlBslr7EjLEdLNrin5AXZF4fcK21Igt3kyOrK+UtOTG?=
 =?Windows-1252?Q?6zm8eYBoHki7+K1xC6H+o/OokDmmUUjUabkTRGvOf7ZqzOvhYsme1vde?=
 =?Windows-1252?Q?e5ocp8B1Eqd1lwkDb8/1YUhcE2FyJAvV/epP2b9b0EfFCOeur17M4f1S?=
 =?Windows-1252?Q?FO44187V7+pJb7k75ZhHgAcJn8BlqQ5YvhthhJvFKNI7u5t8OKbdJHsd?=
 =?Windows-1252?Q?/E2hqY28OD7N1f+0UBj9TecnxqmbNoTB9U3EBWEjmH4amcBqw86Btus5?=
 =?Windows-1252?Q?BHvTt6Pu6UJmhhBe+mtlGSptZL3qX0bmvbsA6Z/OI+oaEXe8VqcWxjqc?=
 =?Windows-1252?Q?HSsgb8oxXJT4dg3UVUvo+mgaV/ZivcQyoJr4f+A9YuyWOsq731AXPwjF?=
 =?Windows-1252?Q?kTsMUvQy4/XBw5QXBtYxbMByodZWUgnlCjetZ6fWBCu7IR9k36GySnvt?=
 =?Windows-1252?Q?SymBZxALBvPzRFLpUEcSUJ6Gq5eDzNNDbuvss0Enpm/a5riIJHdRNbBq?=
 =?Windows-1252?Q?6LkLf46aewPIXk/kidUCkNqa9uW0UfS86BO8x4swSsJ3ldjBx7A5KjKt?=
 =?Windows-1252?Q?RgGOsqENko12VHylZe07IA4mA+vBL14pT3XgCCZgKfWig8dQQW8a7HAW?=
 =?Windows-1252?Q?4m8mgHg7BE5QnqKuQD1SAk8ujpPKK9yx3oVdatXDDHM7iocOz87B44rP?=
 =?Windows-1252?Q?ZlOL8cTJ2ptoCZN0qidMDjBfcAPy3XuzQvuO93euJlf62+8OoPKIzeVl?=
 =?Windows-1252?Q?flgnshFGMu2CC1iK1ktwPzKrsRE+G/Azr1Ovyl5UlNM3s2tL9Wy5iwtM?=
 =?Windows-1252?Q?wojcTNCfOLo7nvBUCXDNPDZ86hvcuGBWW86XSz6vaPCBaxLqqfYFSnM7?=
 =?Windows-1252?Q?jhJQesH8L/pXZwJW7rQjT2nfGWu/m0W0STz2lO5QnRD9I3czyDapyDOD?=
 =?Windows-1252?Q?SWcg/k6Zg7rXYJoK38U8kq2mN81BUOlGdG0T0s2tVFW6YPfHgHssWHCQ?=
 =?Windows-1252?Q?u5H6QfYPtq6OevsYSjihOC2tDZe9ghFUF8PjihfMETTxOHsLIUE70lRR?=
 =?Windows-1252?Q?ulLj/cOdoRo6Uhl+K3FAJvwwFRr9roWk+vIIH6cKLIHYwERoUQjh9glQ?=
 =?Windows-1252?Q?bdkPrm+wLcVG1oobl06Lhh8gJW159eEaiNuhnYKw/R+uNCQBWfYWgYhf?=
 =?Windows-1252?Q?waUi708mo/5NB2RHCBI4+AKDhPgNHjIVW4DKLORentbgOYDv/R8wBmty?=
 =?Windows-1252?Q?dfPwu2c/o27YSGPNp2fQxmlD67O68zWndKleC/1fuj2k/ISm6MKWdMzq?=
 =?Windows-1252?Q?vwTwFpIDV5j3/knx1eGPpE9f21JKEmNIcvwE4hbh1VFtxUZInAZt7NFa?=
 =?Windows-1252?Q?jrqA/xOhi5D5yYHKa2dfuntYYeE2AQT7GYajPir5XZL+3+Xx80uirPH4?=
 =?Windows-1252?Q?SiBZ04/G5u+POCQZ0QfE0FLwLpBogdDw06tvLA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?jokQ886Hwb/cX0clPRbexLSaV/AkBDh56jlb1bl2ujONMdXqz62r74hR?=
 =?Windows-1252?Q?CaMyfSaHdh/FxbDJsK1ZBS01SakYv85AOVHRyzSWHipUOgckzzIWStWL?=
 =?Windows-1252?Q?Y+wfDltC2Uek4mkZPTbui3y3BTw8AH40RXOy0o+IC1H8295hmFWUg7x3?=
 =?Windows-1252?Q?VNPgxsx0Gf1laltF6Je8r2py8RV8ceRQLt7Z9xEMKhmUrdYESxx4g1K3?=
 =?Windows-1252?Q?zW7S6yNdQZ0ZZ4BqrjfW5Yf3u7xvFqPSNYz6hqjVEHpU9YN73pBrCzuf?=
 =?Windows-1252?Q?o7mzjFHyYcfwfsnPCBz2F3gSoS9JUs9CI/QZtZqxqx0KodjDrk0CF9xI?=
 =?Windows-1252?Q?VeN6tXXxd2roNSWoJ7sSQFfjjalEQzNaICT9KpcwS67e6Oxmh32IWpb1?=
 =?Windows-1252?Q?ehEnu+FskIaWkD5UvyyT0AHtwKRA6lJUeoSm0NzAm0SVFvqQgy1Qdgu8?=
 =?Windows-1252?Q?U7oEAjF68d/hSk8HgGTbft6MO34dccRFrB0N/BkT/SbB54DVh2M0NKBu?=
 =?Windows-1252?Q?PBmPP9TOSdQehpzFSbY3uv9SHt0nG3T8gsfShhRIWa6CbYFJdDV/7Ats?=
 =?Windows-1252?Q?rfaxUk5cRwJERx/Zh9o6r6+Ci9ilmfnsdgJW5ZDaQE3yMydYA2aoZTp4?=
 =?Windows-1252?Q?E01Q/HRLdoz6ohLTTZQGqlgwVG4la/JrQfDqOSpKe6u1PYaXZDM2EWHv?=
 =?Windows-1252?Q?xsNZQoVnkzkjuoApYqZwXPwKCmQVvAxU8hBo5FBmn+cux30IbH8bLKmA?=
 =?Windows-1252?Q?H4qSBM0eA9RYCt0qkD5qT5XLLqqd46iq8m5OgUCZqU3GLZQOMZKr5EOy?=
 =?Windows-1252?Q?+5Pw1bSe2IMDUja34hjkod83BmyqOvxOj+qbLI07pAXEyLBKGuHhz+Ws?=
 =?Windows-1252?Q?IIGSmswJODX9J7+VvKD1RiF3n34ISzzYv5SQ8luYy9lUkNdQtvX+quKE?=
 =?Windows-1252?Q?dtSumzdhm8WCdOlnjZ1WDL8JfnJGzM+vLwnyoqrrb4Q02TLkI6N70vMF?=
 =?Windows-1252?Q?5ERlDoif7n3PBAHghPuzOqB3cv2DZISPpoqS+3Tlvl60Ott1oilWBYhq?=
 =?Windows-1252?Q?+JVKvenu3ylONBt+VDQnPosngFmnv5k9tU1okOnjOBpYPz6t0MeLZ1B1?=
 =?Windows-1252?Q?xmHlw+vJQUNyEsvb8T1qdyVy9oqt1+iggii0xZpqULzjCjsF/gJZ/skF?=
 =?Windows-1252?Q?sva6UZ5PiCo1fgibjOk9FeVardUBcLJhbeo/fpSTKygD0OYxIPOJ0Ui7?=
 =?Windows-1252?Q?p/7kGX7oojWYQCW0ROdCvJyTJ3fpGCw8vYGhgWrJxgLUsxj/u0CSqlBL?=
 =?Windows-1252?Q?js97A98zXY+9ajtBXDVMYzyO4t2ZuUMh1+ozzvL2Aiz8faGmLPFYj5MO?=
 =?Windows-1252?Q?pJlDr/PtCfWa6h8vZOW1o+fODXPRw2ZWuTuND0OlG2RCeZ6Of3YB+B2a?=
 =?Windows-1252?Q?eyLHEU6zn/3Laag3Lu/m93aF4XjV0/izI6XbJ1dFsiXV28YY1/ugzkLI?=
 =?Windows-1252?Q?DjM73SsmDjn7B4eV9qX9BoLHeWhOoAXdAuKc0y81543f6/AN56wRDZny?=
 =?Windows-1252?Q?8WGZYPJeZkSiZ0/qIK52S9zQT0i+/YmXKPcEVvlIqYNsX2SgcAWlAovu?=
 =?Windows-1252?Q?eLQDX3xC+OE+hSV7fNjdeomil8Tj0tuCrG+NOIO4DbjCYZZ3/sFYbkN7?=
 =?Windows-1252?Q?npP/h3wxvT0FsnlfAYePjjmyN18hcLT8?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 436795e0-2881-45f6-855c-08dd96d01240
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 12:24:15.9988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsmzRKiEUNfUQDNelltgG/0xeZ5sZY8g/DLBdhpjzthTzRvbc4J9DgNyZkt+/CPW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1895
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=OeiYDgTY c=1 sm=1 tr=0 ts=682b22f7 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=eBa-zNFgqhsxVPngS5wA:9 a=pILNOxqGKmIA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=gMTP1np7ffj2MFWODVwA:9 a=ThE-rhZdb9ywW8gz:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDExNiBTYWx0ZWRfXxsoOYKlZlQyU
 KJ1yauQs2Zdj3yVUEhc5IKRxQU/XoGwC4Ye/TOTdZLKmema5Fj8R2nyaDyttUpGMouNCt5nkgBO
 CuVvOii8YVczhmyMFNg2uoMQNSfIhPAX3tERubk3gY1Ka+jFz3cuZx5qJY4rELVHCAp6rygu+P4
 +PacWL5rYKWNlF0kZrBbSXxz4If0Ub+9pj1amBjdZlC8qq8s3b9An5Pi9eqACcyNzyqRj6FeuNv
 aoHZzShW5Jffs7D1MR4H2mqqMK5Ln7FjK7KLo/P9xvuzwfEuyjIkAyhslYOkEwe6by2Qt6DGJVY
 7YzUBgefjau6VgZ1XY2KGn7h9WyHOXmqfO3RVmUa3qYrp7cLc19S2Vc8rkMBEMqaQHvcJ/0pVNV
 eQf7dU/y
X-Proofpoint-GUID: aMcs4xOteDDKCLbQMDLREGDcUFZzz5dd
X-Proofpoint-ORIG-GUID: aMcs4xOteDDKCLbQMDLREGDcUFZzz5dd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2505070000 definitions=main-2505190116
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
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

>> Typically what happens in open-source projects is that once the code is
>> merged, the contributor disappears :) So there's usually reticence to
>> merging code if there's some on-going discussion. Here, the struct for
>> cmd change suggestion is not a blocker as it's mostly cosmetic anyway
>> and it didn't prevent the code from being merged in the kernel (and it
>> isn't a bug that we should fix in the kernel), so that's fine with me
>> (I'm anyway not the maintainer so I wouldn't have the power to veto this
>> :) ).

I can maintain it at least for a year without many issues. I need that code=
 for many projects inside HPE, so it is not that hard on my side, and I wil=
l work with u-boot during the next couple of months. Promising anything aft=
er a year is tough to anybody, but I will give it a try without any issues.
Other good news is that I soon got contact with other end users who tested =
the patch on live systems (different than my dev platform). So looks like t=
here is some interest for this device.

So stay tune, and new update on Wednesday as soon as I have tested the new =
patch. We can then decide what do we want keep and remove. I strip down the=
 code the the =93easiest=94 code that it could be, which is simplifying it =
against the kernel perhaps too much as you mention, but it is also easy to =
maintain that way.


