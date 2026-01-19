Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68217CCF2CF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E1583956;
	Mon, 19 Jan 2026 10:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jY2EYFu+";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jY2EYFu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A440E83956; Mon, 19 Jan 2026 10:33:47 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BFE83015
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=THeKdX8BWfHLjF1t5ETB3uI+U98SrSKDF/UMb+FKl5CsSMb9MmxKVHJ/rvIun2Tj67aC4gGWPQBW9Zy4DfCtZOGNIK5+obvVhWGHqCQoZHC2Ya4TzqyXHHrQjHOeilg2pTb/Q1KExqsVxVqDL4hEGLXhGzcaB4LYOB0/gGq2p+B468AoGabIMJNP27KIuQlfVe16l4UBzA4RpsoC1tDjErpCjOrgexOsz/4cqAMoeilZ5vyrW8cMNK3TRrhq2SvsLfad/TcBunYTu+s0FoRtmg+X5NqNtUtgPn6oOCHv6lCyWFg4xibT/XIhZy8AFZfxA81RXqEDBUNSw+K+rWGyGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BitpWjJAj4s3Uo3Juv4s5Yxr6KY2lbgOC5pjVaj6sAw=;
 b=QgwhoTNxzo4A6raBbTuhlTafztZRyuguO6AalGRRTp6y4pXDup8T1D6NF6MDWqR5MVPEsvrfHdSq7lqvUsQQdW2+CkV5Ri41XJnKBI1UBnpjsA0aU8ucbOploGOtH4xTvXKWzZcB+eoTtbF78sV8ZaZl+DqIbB4a277MDYxYBSiz9kD3M/tExuOCsU0nKX7hgxOP0NCXBKrscgeuol1F/U6GhUR2bFm+JsLo7kI21pNg7UFXiJIdCW7VIm0msCG41wLLvXtxgFLvEtbhBTOzugvwi1GpbemyQNPNWWMgMgwOTAwdvnwJEsXJyga5YBP4yqZKD3ABr+7a5CesE1oiKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BitpWjJAj4s3Uo3Juv4s5Yxr6KY2lbgOC5pjVaj6sAw=;
 b=jY2EYFu+TiJaWgVPRqjmVchGG7gKe55zNELep08BjXsJAy0QgVoIQ+QJcqJFeIv3Jyu9nWCHn6KJPuaawVUR4R805LyzJEyWjG0A3MaQs6nDx1zg1l0W7iHxb+eM4S1JvYiWajvC4Pstjesx4NdNH8Ew+L/NZ92T4Go1hKXgOcM=
Received: from AM0PR02CA0168.eurprd02.prod.outlook.com (2603:10a6:20b:28d::35)
 by AS4PR08MB7501.eurprd08.prod.outlook.com (2603:10a6:20b:4e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 19 Jan
 2026 09:33:39 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::b1) by AM0PR02CA0168.outlook.office365.com
 (2603:10a6:20b:28d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 09:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 09:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7inkZtNz+rU1kEFtUWI6ZalomK8NBRoM9SeYi1d4iHleIYWpfwBAEYQiEig2pM/1CiQW6v1m+rg+YRmZEUzRp47l37pZz9AaChAia4l4VOCmcALZzCQ+KTXxtWN9yGNU69E7VLFBARjjJCloZuoYsP8wRN+ZvaedsKCO1dPycdXETc2LrtgCbjvpUUjGAFv2lT6M/Ltt7Eg3GhbqMckqxLWzP6fFWFuzL4NrEqaAFCd3k/o5nMm2R9k1RiUA1FW5l3DHOI6FXRMFJzFo2lPPKG6FPCEMO9VCaWfXJhGJN8XYQLbIWni/O3S00kXVDLQZR++sRYP2+Z7+o33GLeBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BitpWjJAj4s3Uo3Juv4s5Yxr6KY2lbgOC5pjVaj6sAw=;
 b=T7aIYpR7xFyz09M0bobQUEoM1bZGxyZ57mhk7eudmcnkbbeA6tM+MzvSXOL5xs1RhkPJkhqPy+E8F1EpigjtW4pqfJWwjTQSfwsqaylB+8Vgq+zDhuAXTTs8AEou4ke4BD4HiQl95imV27+zR+YhSklizZCBdBFYGzYwa1jL7oHZiEYJSESr6CYdCObUOKxW4KjyQou5PYLGyLbImxul0Aled4Aal0U+UsAo7hclFW1/vrjT5CnJZiiRYJZip5nTQjDeLI8FQNGiSdu1R5kSu5/XhrtmLPRDGK3S4bvPvUnwKak2xE3LvwQzTk+ZUn6O1sKAead0aVHlKqwz8pugBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BitpWjJAj4s3Uo3Juv4s5Yxr6KY2lbgOC5pjVaj6sAw=;
 b=jY2EYFu+TiJaWgVPRqjmVchGG7gKe55zNELep08BjXsJAy0QgVoIQ+QJcqJFeIv3Jyu9nWCHn6KJPuaawVUR4R805LyzJEyWjG0A3MaQs6nDx1zg1l0W7iHxb+eM4S1JvYiWajvC4Pstjesx4NdNH8Ew+L/NZ92T4Go1hKXgOcM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS4PR08MB7629.eurprd08.prod.outlook.com
 (2603:10a6:20b:4cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 09:33:21 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:33:20 +0000
Message-ID: <a0c07cb2-4e7e-4510-90aa-18060de64e7b@arm.com>
Date: Mon, 19 Jan 2026 10:32:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: lwip: tftp: Do not write past buffer end
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 nd@arm.com
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
 <20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS4PR08MB7629:EE_|AM4PEPF00027A5D:EE_|AS4PR08MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: e485c6f8-bcd5-4bdb-fe65-08de573dd43a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?TE94VWRicVp5NU02TXUvbzZMK3V0cFRWbzdCbUVBQzY5S3hpYTRDSnFCaGtZ?=
 =?utf-8?B?UUd1NFVLMzgxVlNzTityaERSSE43NnhyeVUzN25yaHJJOWhnSnh4YmZjMXNt?=
 =?utf-8?B?RzJDdWxkdVVDNk9Hc3lXNWgrc2JoV0dsZGRjSjRpNnNQamFFWVpBbVl6OWpF?=
 =?utf-8?B?S0VtdW0yR2NicnRBTVFBVkprYmNVNk1IWlZJTE01a2xyWXhVT0h3eWlEeGRx?=
 =?utf-8?B?VlhEL25tWldjNk96UmQybytpdUx1b3RLeEowbndxZmEzaVJIckRXa1RQNHRW?=
 =?utf-8?B?akxwcEZMbUQwMGdvc01rV3FpNW40aVhkL0NCMDBsQnFkVkNxN2xscXplMXpV?=
 =?utf-8?B?ZUlUajRheng4aTU3ZzZiaW9YVEJTUFVuRG5DUVJ1VGREbGE3NFdoOTJjQ29S?=
 =?utf-8?B?K1EzN0xJUWxrd3pFZ2x3aWpsbWhMWjAwWitWQXozVVpLcU5qYzR4MUpobzdE?=
 =?utf-8?B?cnpxTGhwSW01NmFJQkFBRE5LcmluUTlLMHowbVhZRndraUtRNnFMSUFKUkti?=
 =?utf-8?B?MktBRS9MNnFPbVV0QVA2NW1pbDZXd3NlbkYyMU9ac09aMWNrbTZFY0lOTGYv?=
 =?utf-8?B?cWlDU1VxQ0x2QUkzdis3RHY3dHZsdUl1WkhuTUs4WmY4Z0t2cnBYSHdEVXpr?=
 =?utf-8?B?bWV1ck90cGlsREtWV2w4MlBCSVNJWkgwZEhtcG9WeDllMjBmOEU1c2dVMUJT?=
 =?utf-8?B?dWFZSCtUSExtVllWTUt2UVZkYjNzTHVmNytoL21qcFd0dVV3YWw5MXNNK0FU?=
 =?utf-8?B?b3JmZWhkVnRTNUtuSHhQdnBTTTN6QitRQVhpRFpHTTZtbHZvdDlvZEs1WXhT?=
 =?utf-8?B?VTRZYjZDRFh4TlVYRFhjOEVPZndVd0YyQnJ2alpiMldNeUdobFNnbi9xVkdN?=
 =?utf-8?B?N1h1Y1VmYjIwZFZoQUl5V1JhVTZRT1dVQnZ0NnVKaFhXQmdkSDVXRFQ5TU51?=
 =?utf-8?B?WjN4YVY3VkxIb0YxM2xGemN4R3ArRXdaZERVdGp6RkVvbkFla3BzTGRlNHFB?=
 =?utf-8?B?YWpjVGowT2V1eXFMUjFYN2JRdE1sLzROciszcUxQRWtlOEQwaW5rZmpVYWtT?=
 =?utf-8?B?Rklpd3lXa3V3VEw2d0NiWld1TFphU2JTZmlGK1g2Z0FjMy93bVUrTUdjOS9X?=
 =?utf-8?B?b2pSTjZOR1NFVFExaWhYeitrMGxzcWc4SEFHclg1NG1KRVNNcTRKeGdoV29W?=
 =?utf-8?B?eXAyMUxqZ1A0ckdVUnprZmxsa1J6L0NNSHRKMnBVSGJXQ2R0M2NGVWlsaCtp?=
 =?utf-8?B?WmVwY3dVWnpXQnFRZ3dKdXRFeGFySGVmUzJuYS9JemtwWGU1V0xldXZjOWtq?=
 =?utf-8?B?VzNQcU02UGF5MWQzVDAvWWU0cGZCeEVGSTRwWHVXQnlYbngwTmEwV2NVekkz?=
 =?utf-8?B?aTFGa0o4bCt2NHhBeVp3ZXlEMjhRYkJlc0x6ZnZ1ZGg1cFgxcm5iRjJZWjVZ?=
 =?utf-8?B?UkptcUQ1V1BHcUJwb21Lcy92N3RDL3FjQjA0cXVGRnF6d0R0S1JUcUhLSEMy?=
 =?utf-8?B?YVBYNis3K0FFTnJ6TU9qeXlFelhGTUZZVDhmZm9BRGVEdUE2bUJOK2pwcmN2?=
 =?utf-8?B?RUtJMlpGeFRaTWMreEYwWC9yREo5Qm5LMGJmNnFOaVl1VzQzamFKc20zZU1a?=
 =?utf-8?B?TVdDNkFYS2x3VUNtN0Myc1FvYXpLMTNscE8zblJsVWEreE5VcjBCbXN6UCtT?=
 =?utf-8?B?K29HbFdCazUxclRQclRXK1BQNGJ2cE5lWmdkaTlFWVNheVozOEdGUXl3WVMx?=
 =?utf-8?B?QVNkS0ZzbjFCNFlkQWwzRjNSOVhJREV5OEdqSG0xN1hjblZMQTBvQ29qM3dp?=
 =?utf-8?B?M2lyL0tIemFxd0pNSVpsdVNsUzNWSVpHS2l6dUZOS2RqV0tEUXMrYUVIR2Zh?=
 =?utf-8?B?T2FXSTYyOHpDOFVSNURMQkZQNmZsdWVrZWVqVk02T3c5cjNiZWVWOG56SWx6?=
 =?utf-8?B?d1h0a3pkQVBHcXY1d2d1SC9BanFxbnJmUXdndWk3ek9LU3JCRTIzU28yYXRa?=
 =?utf-8?B?dWtFdEFHRjhZaS9ZRTJPNEtpRjdjU0N6VEo5QkNBMmpGWmtBVnZ2OEtLOTBS?=
 =?utf-8?B?Mzh0ZWVpeDBwN25IL2s2eXZldUpKVXpGUHh0OVJUSy81YTlTOTJaMmZFa1V6?=
 =?utf-8?Q?ujxw=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7629
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 79003fb8-89cf-4ea9-af4f-08de573dc8e5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|14060799003|36860700013|7416014|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHhOalE2cElZaldtOWY1WEVtOE1PMEROMkVQNWhhc3RHWG8rSE95Qk9CUVI4?=
 =?utf-8?B?citxL0xqdzVLTWtsK0ZBZTNQalplSDBjYnVvRGJYRUFaUXBWb3Bxbll3ejJW?=
 =?utf-8?B?SmxJK2xneUZnNnQvckcwQUN5UEV2RkVCSlB6c0F2Y2FCQXlkeHk2djU0V1FJ?=
 =?utf-8?B?SlBjdURJU080U3BidDJXZXV1cjRzY2lVNmcrK0hXYXZzK1JOcnJ0ZE0rQ1dm?=
 =?utf-8?B?UzFIb2lvdzRKWkt3K1B6VmhTMytVcmx4dUlrNHYvU0NpeXJPRDdlZlRicTgy?=
 =?utf-8?B?VkNlLy8vYkQrT0lRdmJnYmVZa21GemNpeTZPUlB5ZlFPNzROR0FhMFJpOElt?=
 =?utf-8?B?VTl0bW05U2k1L1YxaWxkOVRCWGdjcE9weWdLdERaMzdWNyt1UCtwc29XYTls?=
 =?utf-8?B?cllEWmxnbzZVTDlsNTJNdUdaaXFPYStRd2FUbElHU0s5R2t2L2w5U2JPTFcy?=
 =?utf-8?B?eUdMQnF5R1diR2xsKzZQVmxpWHFUZTR6YmpNckZmNVg0U3hTTHBMSDRDdDg4?=
 =?utf-8?B?YTZicVpMdExkRDhFNzFyeW1EL2pORHkrWE9JeVBSeUIzSjFHM094R2VTRlgw?=
 =?utf-8?B?M1V3WnFDcXhDVHBPYXA2MnlpallNZEcyVXJFeklJenhRZDJHTHd6cHRWbnZr?=
 =?utf-8?B?M3RtazA5ZUdVcnZBckppMUJrQUhQTFdZTXUwbFptb1J3SnMzYkFqWms4VDhL?=
 =?utf-8?B?R00wVFpUdWhiM3dtSk9yWU5GVldNQjR1UU8xQ2xpSUg1VUxTanBKUXRsUk0y?=
 =?utf-8?B?RThPdFRabHIzSGhyQUdiT2FnSUx4OG9CNlp5Q3BoVHVmb0JaRGM4eGt5MWFF?=
 =?utf-8?B?RXBqYWNtSTBJK280RWd6WGRsWVpQeSs2YkxzYmc4SXI3QlRHanpvNlFhcFE4?=
 =?utf-8?B?L0Y4YnExMEpsRFQ4U2UxYk9FWStCWjlxd0F4RlE4aG12QmlPM0NXRGVmaDVD?=
 =?utf-8?B?NG9pdUd1Tm5UOEJ0RHM2OUtoa296T2RxeTZyc1lQWUI4QzYvTmh3RnhmeGla?=
 =?utf-8?B?ZUI4NDhSNUlFWnpoc0hWUjdJbVpSVWwyZlhnelV0U1VueTdYcnkzWEYvaHFM?=
 =?utf-8?B?QkVzdkd0a1VuUXVHcmtEV0k0c0gwc0VRSnRodVBXL1ErQnRUbVIzVFEwRW1n?=
 =?utf-8?B?anc2eHhPd2ZTQ2lHVEh5S1dsNGk4MFdmSTlwMmwrUGRwbXpjcHNUZFl5Z2N0?=
 =?utf-8?B?ZFppa1gzejJvUGhyOXR6UFBMaGJ1aEdQNS9HaUJjQUJwZTNaZ3BPam9XcDc0?=
 =?utf-8?B?NjNmVi81SFNQb01rQ3Z6QUw2NHlvMnZoMHdiSDdseTZHbnJFb0FYaWZ6Q01U?=
 =?utf-8?B?WFRRdEtVSkJsSWRSdHFaeUxxRmdDZXM4L1IyeVRjaFpMeXJSNGY5M1EvYVdm?=
 =?utf-8?B?RXgrVlRMS3pjVGZEaFRUTVRkdEFjTmFFVVRMSEY4Z2VoV09sVWNSSmhobTBB?=
 =?utf-8?B?cEs5UUZRUWFkYnArL244czVkOFU0WDNKNk1MZ1ZON3pWSzlya2tvT3RMdXdT?=
 =?utf-8?B?Um82dGdibTJLdG5qMnl6TVhRWi9DUEpSSGZRTFRaMkJOTU1zMUxYdEhPZk5k?=
 =?utf-8?B?bEM3eE1VajFBMVlRYjhXaU5Tb2FqQ0VFSTByRks4dTY1eXVWbVlOM1hjTGNk?=
 =?utf-8?B?ZzFDYlB1bkg0QThzY2FKbXppTWhINjh3VnU0dXd6VEh3NU9WWmZ5TEd0SXFH?=
 =?utf-8?B?eVJ2eVliOHQwSlViZDdnblVBQzZpdzkvZFNRY0dwa0FXN2dUWG11aEFzNVlT?=
 =?utf-8?B?WlFjU1E4cE05cFU5THZLYWtFUUZrWmcyZXptcTRoUWx1QVkwOWs3OEJ2R2xY?=
 =?utf-8?B?ZFNkQ3gwNWhZcHZtMHZyU2UzTnpKZWhGVHpQd1MxTGRIamtQVUVFbE1MME94?=
 =?utf-8?B?WkRhQkE1Z2lCbzBsdGc1cW1ZSWF6S2JLUndIdjg1eWRqcTVtWXNObHV2L3Rn?=
 =?utf-8?B?RTUzMWlrVENsUkJTdzl1aDAweE8xclJ6SU5PNjRIaXRCUW9ta0RtdVZrRzhX?=
 =?utf-8?B?RTNVNTVwaVg5SjNqaER6aDZVM2NQV3E5cmhTY3NxaVZJMll3MGFNZldkWWl4?=
 =?utf-8?B?MitrMkQ0Y0NtT3dQdHJNQnNSNDdKSVBlS21aaVFiV0pjV2NyUUJ2VllvS3E4?=
 =?utf-8?B?SXBIWWg3dk9pWVpHeURmNG5SNUduc3FZZUZ4cmVHNzRPL240bmZ3MzVUdXZT?=
 =?utf-8?B?anZiYTBmbVFnQXlTaTVMTDRVbzBhSGVOc2lqUnpXTG0wWGpVaWJscXE4VVFr?=
 =?utf-8?B?eUJVVmw2SFp1b1BOTzl2NTBkRnBnPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(14060799003)(36860700013)(7416014)(35042699022)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:33:39.7610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e485c6f8-bcd5-4bdb-fe65-08de573dd43a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7501
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

On 14/01/2026 16:12, Andrew Goodbody wrote:
> sprintf will add a trailing \0 so manually adding a trailing \0 will
> result in an extra unaccounted for character being written. This
> overwrote the first byte of the following allocation block resulting in
> unexpected behavior.
> 
> This was found by Running 'pxe get' with no available file resulting in
> multiple attempts, using the default algorithm, to attempt to find a file.
> Eventually there would be a failed assert when free() was called.
> Failing the assert would result in a system reset.
> 
> Fixes: 27d7ccda94fa ("net: lwip: tftp: add support of blksize option to client")
> Reported-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Michal Simek <michal.simek@amd.com>
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> index ecb6c55ae1100779187e7b138d098a0ef1e48ca1..25da952e92566cbca1c64bc89c89102e74d0a42c 100644
> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> @@ -191,7 +191,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>    MEMCPY(payload+2,              fname, fname_length);
>    MEMCPY(payload+2+fname_length, mode,  mode_length);
>    if (tftp_state.blksize)
> -    sprintf(payload+2+fname_length+mode_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
> +    sprintf(payload+2+fname_length+mode_length, "blksize%c%d", 0, tftp_state.blksize);
>  
>    tftp_state.wait_oack = true;
>    ret = udp_sendto(tftp_state.upcb, p, addr, port);
> 

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
