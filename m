Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA16CEB2FD
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56F288F63;
	Tue,  1 Oct 2024 07:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sbxpm/nt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD6A98910E; Tue,  1 Oct 2024 07:20:25 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D5888E3A
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7j7UmXJUpFd6zMACthOFh8KOHEyQlh4yvZ8BWWvgxV9kc//95z0DfVswtPOA6RA7AfkeVK8h6gvqZJETyz9yHAd6wf4NiJ0fOJ8BHChKQthcUHixB1XvVo5pipuMQjsS+R59eLNd4IsR531PcGOuElmRlmK7WHNRYTbK4Vqk0PWuULynG5vDPUuZbnSkuYSJWoXUzwxUhDQGAtVggzIt6/ENeIUC5EmBObAni61YPKQ9kRQBLMkgpgqFiOpkSZOVQldmq24u9E9LX7GSUhQfgCoRLGm7n/hWfFNySH07Imrkac7kxpHJdhXy5SCuuVfuNOdmJCwtD9GCl9OWM4MXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ypmDG0Lqc4gUDyTnuvqPeZBg9dhp4AKPmR8zcn6BTQ=;
 b=ffo74gEqdrF67YTfwfyBGtB0SQOg19u8tFJRayag20I7lDETBFH99ZAAz14aIbfyu0BXwuUMyH86XcYAgCC2hsfOME92gshDi679ITs40oYunjAK5S5rCGuKo23Ts94YMucAkgTXHCIPc/G1gdcDUrJvodSNBNWtUePDwhwNF1zedsWsnX/eHyv4sW6rBhbvTRMx5qg04c4VsGkz5lLtIzvsS1Z/R+gKXh2OkgNao/kuhWKOy9nvcwk9PrgXa4MY+Un6lPND4RxOQ3RyRKphUrp9qwjG9vv8YYOUNfyouK42S1Rj2uGQkQYkPsMjGm0C6IRnzqlqygS2gwuBZXwqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ypmDG0Lqc4gUDyTnuvqPeZBg9dhp4AKPmR8zcn6BTQ=;
 b=sbxpm/ntAatf2nhunwmMSgDUoPSjClxPTifxPh4SUjHUyBGb/f6itN0sBNl+7HXeFQGMgQgsfJxUCkAhwRvPNVzp/nYNXi+QdAsFXD0HSLlCzQkQc9mWxYTadv2NSLhCh0c0um3OoW2u10kZHqjyMh4Lt8EaZDESYMC1cRXQpU8=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 05:20:10 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 05:20:09 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Thread-Topic: [PATCH v2 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Thread-Index: AQHbEKsm90WQaPiMa0yiBPI57rQ+k7JsGf8AgAVHBTA=
Date: Tue, 1 Oct 2024 05:20:09 +0000
Message-ID: <SA1PR12MB8697F80C18E42BB7140AFE4098772@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
 <20240927070137.21816-6-venkatesh.abbarapu@amd.com>
 <1bba9e4b-621c-4b94-befe-a3eb468a8b3d@denx.de>
In-Reply-To: <1bba9e4b-621c-4b94-befe-a3eb468a8b3d@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CH2PR12MB4246:EE_
x-ms-office365-filtering-correlation-id: 32387266-859e-4aa3-a9cf-08dce1d8b7f5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWdoUHprWlVZTHIwZGYxQUc3ZlN4STNsa1BLQUU1UmM4SFhMbU9kUmVRNVhx?=
 =?utf-8?B?bFB1aTE3L3hpL1JsbkFKbGJudjFzSHZCRmVPMXYrWU4vZmtDTVBFM0hKZUw2?=
 =?utf-8?B?Tzl2ZWJscEszQVBwKzErVFZCUGRqTEtTclR1aElzQVlPcThrNzlQd1hiYTVi?=
 =?utf-8?B?UjZ0ZENQUGp5RTk3T0daa1AzNHFBeGszMHlxUDJKYldqV0ZTa2ZiVUlDQTlt?=
 =?utf-8?B?NDRJRytWZGNrd1V2azBnVmhDaHRHaWxwYzdpRmhoZXllZE1PUjhVVURBdjA2?=
 =?utf-8?B?RnpGRk1vNTliRFNKZGdqUmo0UnJ0NVZBcHgvZlVqTnNrRDBUV1JacldWMEVB?=
 =?utf-8?B?a01kWVFHbUFtZ3J3N3gvUVRLa1VsbnY1cmZSWHhmNlVDcndHWUdFZ0pWNzcz?=
 =?utf-8?B?T1hqMHd6M3JLSE1vVHRKQ1RzNFlaaEd3SERsR1QrbEFqWEhndmpWcmFNZFZG?=
 =?utf-8?B?M2wxdjgrKzF1SE9NdFhmYVFKTDJLQ3BVd1lJREJXVDNhUlhVR28wRTh1ZlQw?=
 =?utf-8?B?a25LRmFUVXprVWdrVGVvc2N1alkxUlV1bUFNMXFDUWdSVmxEMEtwVENOZ1kz?=
 =?utf-8?B?SFdQTE1EQi9ZWURmanQxWlR6a09sVVk5U2prekpMYUI3QkorUzFUYWxYVlBD?=
 =?utf-8?B?cEwvUnQvWWZKNldwQld4ZkZXbFg0Y2JQdWp5V01udUFhRXluUXI3TUJsbEg2?=
 =?utf-8?B?ckFKQXQ5WGlXZUd5M0VaeTFLclRTMG81L0ZCTFg3NTQ5Q2krdURCUi8ycWxB?=
 =?utf-8?B?Y2RQTU9VcG9VVVhWeGttV3ZiWkNPTUxQWnVySUhKV0RwcUlKOVV1ekczMnlF?=
 =?utf-8?B?R2ZVd3hHaEVYUHVVbGs4K2QyOGR1YUNmSllLSHVSNzlveGMrdFJTWElaTGhF?=
 =?utf-8?B?czNSc29qRzVNVjVUUithTVFybFpNUDVaeERNSHg4ekZQaUxzdUt6d29uM0Rx?=
 =?utf-8?B?c094dmZrMFBMbEdjUG1jblRTcXRYS3paR0xWeENXSU1oWUVkMEs5YVVQTVps?=
 =?utf-8?B?R2JhRkFjMEwxMlUxOTJmcFRMZFBUc3hUazJKaVp4bW03YWQwQkNPM1RzWm01?=
 =?utf-8?B?TTAwQ3Q0Q2lYZXlzSEt6QnVCOUdvRHpJM1BIa0Y1QUpsdG5FMndZc3Y3Smsy?=
 =?utf-8?B?dHBsdXhkUmlwUnZFNk1aNjFCKzJ0c3pIOFFDK1VHZlZSWEZUMnlTcXJGbGV3?=
 =?utf-8?B?bW93WmphaTkwdkF6djNRL3RiSVhZRGVzSXJTcnlWanpmWnQva01US3VmOThR?=
 =?utf-8?B?U3Bkelh2Yjh0b0VVTzc2OG9MZnhYQkZVQWdqdVdUYk1BVFZwcGVKc3ZkdFpR?=
 =?utf-8?B?VmNFdElSMTVYNVZLU1V3ZGhwM2lNT05OVkdvUkJodklydkRiaWJ4VkJnOFlk?=
 =?utf-8?B?c0l4VEtEU3ltOEF1eDM3NzAxR2JVRS9uUVpTdUVCdThzOW1YNVowMkxka1FD?=
 =?utf-8?B?ZzlkTmdhMVYxNm41VWlOQkUyMWlVLzk0L25XS0ZuZlZHOTV6YXJnVzFJT0lm?=
 =?utf-8?B?SFF4dEkxbTNjQlJaSTJXcVQxRkFRd0JZVDZzWUJQclpjWS9BQUErUEZkcDRj?=
 =?utf-8?B?SytKZ3RFbkQrMTRHbU9BMEYvTURtMzRCOXRNbFNudW9vVEpMSHk3K1lCY0NG?=
 =?utf-8?B?Sm5lcHlVd1AvUWxqME9LbHRZMWRUcnJVb3drTVEzNWNTWkNxV2xhWDdTcklw?=
 =?utf-8?B?YWdEMFAwaEhhWmZMeGdXM3NjMHRIQWdIdHlyTExQNzQ5YzVnTUFLdWhYUGRD?=
 =?utf-8?B?SWpaR2xsMGhEa1p0bURRUkV3SXlPUmxyWnpVZUl1OW9JaktJaXFURUdwd2lx?=
 =?utf-8?B?QzRZK2x2V0I5RU42d2NNbE1wSzBnK1ZhOEw2VEhPY0t0OGtIbnZseERqRCtQ?=
 =?utf-8?B?ZmRHUHFldFM2MWJyRHJwYjNuNUlqeXdoNC9mRVBlUXNPK3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0Vla25yVm5vNjJITEl6L09VM3FSeCtVdXhHdWV2dE1TVDZtRVloR2Nxektv?=
 =?utf-8?B?dHlMcTAvQ2FmNVVhMTJpWVoxZzdMbGFGaWEvcEQwZFRGTzFoS1oxMDVsaGQ4?=
 =?utf-8?B?a3FWK0d0QUdYSVZRVFdEbXQ4VVp0a1YxTTBZa1RtQlVuN2V1UXFidlE1WHdK?=
 =?utf-8?B?YzJVYlEwQWV4VzVRc2Q3Z2pvdTRJeU9tS0t5WVNGenBTNUJBenBiRzIxVmhH?=
 =?utf-8?B?OE5KZmM2RTlOUEhXV1NRQmtkNUVob3RZWlo2ZzJFbDZiMTArL25xa3k4cXp2?=
 =?utf-8?B?QytEL0MrVklGL29RLzJKbE0yckU4a0RvZ3VKenhNVGh5ZG02SjhHc0ZhUERz?=
 =?utf-8?B?aHQyV0dCb21LSEZQYVV2TE9vZ1V0YW1sdXBaREtReHhMRTlVYWlrOG5jblNE?=
 =?utf-8?B?RDBacVF6bk1vVE5lb2FBN1o0TFoxbFpaZHI0b0M1TUpzOTRuUmhIblN5MUds?=
 =?utf-8?B?bjJyQ3o3N0Z0SUZxWTA0dDNqWDNydVJtb3BzcGpHT2h2Nk51REZBalBmdFJy?=
 =?utf-8?B?VUhzRWdXTHMrdW1SMnBPMzVZRklSQ1IyRnl5b3VGdlZ6czd4R2JUVVBWaUNK?=
 =?utf-8?B?WTlabVBEM1JtbFJWRkJ5T3JWRkwzaHJTbTkyRlZ5YzlZdmRiRXhYS0dkdHhy?=
 =?utf-8?B?eEVnOG1ZbU5pNVVwVHRNSmZkVkVsb2FuWGJUbTMxRjR2SnZaWXhHNDh4QkEy?=
 =?utf-8?B?RndnRWorNkR0Q1ZLNDVUOWlqMDI1b2UxdjZ4L2lTM1RZWjRndldmeFU3a3Vj?=
 =?utf-8?B?eFBtTVZZekRWQUxkc0F3KzR6RFlkM1lwUlh4R2FQNXRRY1VlelNydXFvOWNQ?=
 =?utf-8?B?a3FSMW85ZWtMYVlLVTRzb2VDNnJZK2ZHcHMwYWgzaXVWVTFHemNsdUlTczNS?=
 =?utf-8?B?VWlwcjFPQ0YzbG5pY0VtWHpYbFVrcm5YWTZYQkhOYjZEL3RIRXF3bk5hTVFL?=
 =?utf-8?B?bEMyUlY0dUJ0NWtpaWJoVkRGRWJoajByMmFrc3p6d1c5QnYva0w1L215YWNY?=
 =?utf-8?B?bVR1RUphWmhzamRhN2R0eWpvM3Q5aXQ4blQ1UmlCZ2NFd0h6OFBjS3V6OFI2?=
 =?utf-8?B?NVJHa3dYYjZrV1ZLN1h5ZEVabzFkNGJzN3pCbS9BWjRIb0lOMlpGcXV0dDdl?=
 =?utf-8?B?a1V5c2NHb3RkUnprd2ZqbkdLWXJSbmRxMVR5WHNwZzg5cFdxVlE1dU9ocDZI?=
 =?utf-8?B?UlRaaVljdS8xcVJ5K281aExjN1I4OFgrMk9GWGNHTGVZV1h0N0FXVW4xOTVP?=
 =?utf-8?B?Ym1MbHJzQllZOU16Z1A3SU1qczhibnBZTS9leGdXeHpUUWZkU3FxSWZaYll4?=
 =?utf-8?B?eWlYZWgrQ0tSVnFWdnpOZ2JFd0gvVE5BVjA0d1YyUmJiZUdvTEJtWU1YRXND?=
 =?utf-8?B?ejdiZ3Q4WVpHNFBESVlaVXpRelBhdGdUZXV0WFM4MXpBL01IbzNtTWsrT3Nw?=
 =?utf-8?B?YjN0WWVYb0xNYVFBM0d6dnhneWN3MUkybTFDUFdveUdvWnVmRGlKWWJKNDg5?=
 =?utf-8?B?bnFtaERqQjZrUGxidDIvNGFVU3JjK0xUbFBEYXorQUhmUVF5alN5UkM3cER3?=
 =?utf-8?B?cE1pZnk3RlBvNks5bjZvYjhoNGFCVDVwblc1UVhQU1hzV25mYUxFcUFEa2hT?=
 =?utf-8?B?VENLZHhpL0FQdGt6WHhlYzhEZlFCZ0J6L2c5MHhkZFlXNEMwd2R3emg3aFBQ?=
 =?utf-8?B?dzhGbnZJY0FYTTA1b2pRTjV2eEh5dEw2enM0U3lDVE9RUEFQZksyVWlQNG9m?=
 =?utf-8?B?U0tVazZFQlZQK2k0R0VwQVBXWlpHeEJkWG13aUpDa1RWVklSZWEybXJ6NmtK?=
 =?utf-8?B?QzNGM2k0S1FQNEtsWDFaYWlBVUhpZFJ5Sm4zeWhvZlc4RnQ3aTF3dVB3cmhK?=
 =?utf-8?B?OEtETSt6L2FjVU8wUjJXQWNTZVljZW0zWFMxN0NxczJNNzFrVGRlYTdKckFM?=
 =?utf-8?B?R1oybHdvcEFOWEtjMG9LNWNtMzkvOUhxRnoyZCtEMFd0OTJXT3hOQWU4RU9o?=
 =?utf-8?B?OU5kdm91RWpCRS9JZXp3VnJWRnA0TUdzR3RENmluendLSkJtTms0REhUMWNE?=
 =?utf-8?B?Q1RZS3daQXlDeTFtT0gxeWRwY01qb0txNFZmU2dVUlZCOWt0UFROZ2Vqd1du?=
 =?utf-8?Q?Ldf8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32387266-859e-4aa3-a9cf-08dce1d8b7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 05:20:09.5012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m74oNUDkjboWH3kZurzC555YKbf44vWowSLRymr9ZneE+rHX+d3Yl1JQ0ktWnPAO6uNlh1MqSABoTAjB6nKlXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjgsIDIw
MjQgMjoxMiBBTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1
QGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiAo
QU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUvN10g
dXNiOiBvbmJvYXJkLWh1YjogQmFpbCBvdXQgaWYgcGVlciBodWIgaXMgYWxyZWFkeSBwcm9iZWQN
Cj4gDQo+IE9uIDkvMjcvMjQgOTowMSBBTSwgVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IHdyb3Rl
Og0KPiA+IFRoZSAuYmluZCBmdW5jdGlvbiBpcyBpbXBsZW1lbnRlZCB0byBiaW5kIHRoZSBjb3Jy
ZWN0ICJoYWxmIiBvZiB0aGUNCj4gPiBodWIgdGhhdCB0aGUgZHJpdmVyIHdhbnRzIHRvIGJpbmQs
IGFuZCByZXR1cm5pbmcgLUVOT0RFViBmb3IgdGhlIG90aGVyDQo+ID4gImhhbGYiLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IDx2ZW5rYXRlc2guYWJi
YXJhcHVAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGNvbW1vbi91c2Jfb25ib2FyZF9odWIuYyB8
IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYyBi
L2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYyBpbmRleA0KPiA+IDAwODA4ZWQ0NWUuLjljNTBjYTA5
YzkgMTAwNjQ0DQo+ID4gLS0tIGEvY29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jDQo+ID4gKysrIGIv
Y29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jDQo+ID4gQEAgLTE2Miw2ICsxNjIsMjUgQEAgZXJyOg0K
PiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCB1c2Jfb25i
b2FyZF9odWJfYmluZChzdHJ1Y3QgdWRldmljZSAqZGV2KSB7DQo+ID4gKwlzdHJ1Y3Qgb2Zub2Rl
X3BoYW5kbGVfYXJncyBwaGFuZGxlOw0KPiA+ICsJY29uc3Qgdm9pZCAqZmR0ID0gZ2QtPmZkdF9i
bG9iOw0KPiA+ICsJaW50IHJldCwgb2ZmOw0KPiA+ICsNCj4gPiArCWlmIChkZXZfcmVhZF9waGFu
ZGxlX3dpdGhfYXJncyhkZXYsICJwZWVyLWh1YiIsIE5VTEwsIDAsIDAsDQo+ID4gKyZwaGFuZGxl
KSkgew0KPiANCj4gUmV0dXJuIHRoZSBlcnJvciBjb2RlOg0KPiANCj4gcmV0ID0gZGV2X3JlYWRf
cGhhbmRsZV93aXRoX2FyZ3MoKQ0KPiBpZiAocmV0KSB7DQo+IC4uLg0KPiByZXR1cm4gcmV0Ow0K
PiB9DQo+IA0KPiA+ICsJCWRldl9lcnIoZGV2LCAicGVlci1odWIgbm90IHNwZWNpZmllZFxuIik7
DQo+ID4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJb2ZmID0gb2Zu
b2RlX3RvX29mZnNldChwaGFuZGxlLm5vZGUpOw0KPiA+ICsJcmV0ID0gZmR0X25vZGVfY2hlY2tf
Y29tcGF0aWJsZShmZHQsIG9mZiwgInVzYjQyNCw1NzQ0Iik7DQo+IA0KPiByZXR1cm4gZmR0X25v
ZGVfY2hlY2tfY29tcGF0aWJsZSguLi4pOw0KVGhlIHJldHVybiB2YWx1ZSBvZiBmZHRfbm9kZV9j
aGVja19jb21wYXRpYmxlIGlzICIwIiBpbiBzdWNjZXNzIGNhc2UgYW5kICIxIiBpbiBmYWlsdXJl
Lg0KSSBjYW4ndCByZXR1cm4gZmR0X25vZGVfY2hlY2tfY29tcGF0aWJsZSgpIGRpcmVjdGx5IGFz
IG5lZWQgdG8gcmV0dXJuIC1FTk9ERVYgZm9yIG90aGVyIGhhbGYgb2YgdGhlIGh1Yi4NCg0KVGhh
bmtzDQpWZW5rYXRlc2gNCg==
