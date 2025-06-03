Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04355C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 13:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7236580F9C;
	Tue,  3 Jun 2025 15:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=NOVATECHWEB.onmicrosoft.com header.i=@NOVATECHWEB.onmicrosoft.com header.b="KBbKMhCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F7981E25; Tue,  3 Jun 2025 15:57:21 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E7E80AE1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzngdNA00jJd+iC7oKgB0EaWlJToN7PqmAzX31tke2Paacl4JOcQ0frBsH+9MXx3FTnqg6IZ08XRf9LO++4rFW6MVApvjT2VjlXcQ6D7eumT/G3rhR+wHUApTd1rY/9w0LZaDvZ7Hc4DuOYH0GhFLxCMBS3gGJve0G5Qopj8VeuW/+wapB0ciLGgZaFQgovY2slToYGp7ggu16/+f+dZvr7HCLQO0LDHYu38fMSBPaSZ2GB4xEwXHKc37DKbGnAHdKob4lCXlw5kcnU1zgntlxdGesMILY7ltxaIuXd+m9aY1l9jF840az/xaF0/g4QIAN9Gu0QUnSmnkmOLhk45kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8TxHeZ0vVF7eNnpljDZkdDRPCndHETuXX0WE3+ZVVY=;
 b=dX5IN0JKfpDlSXrfjYugU876KHXsclqxBuKhN5s8eRdoIcdrdGmEK10DhDJoXsk+cXizQuT5UKG/XSQ+wEASQMq2r3hH55eVmxprYJQYs+jl5lcsLt6XxO99rwA16rQyHAGlai3Diwlf4n5iYte2N6KiMlPrhSaMQlO1VZWM8uFdhvdWh8uXA4g7lN1avcEYDdoE5lchlKuGXi2PZytMUUZEueF431oU6k7djN19DfBJXHufpucIWfNQzUhXAhiHGfn0IsV5mSkOMevgzeRtZU1ejLVSW6+A5fTUzksNQjLMU99/8meqtPZvusd88Q0dCpsv98bhKKWENIK973qwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=novatechautomation.com; dmarc=pass action=none
 header.from=novatechautomation.com; dkim=pass
 header.d=novatechautomation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NOVATECHWEB.onmicrosoft.com; s=selector2-NOVATECHWEB-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8TxHeZ0vVF7eNnpljDZkdDRPCndHETuXX0WE3+ZVVY=;
 b=KBbKMhCjIcxNqC8OMTEknukF+SmRWQi8rssTfdpXtQq1IC/Zt3CIVKnz7GJ8f2xTZ4a/4VT/uWQFy6Z04T1WvHOQOukp9we3r9XOq1aMn5ltNfQv+ShzpST3MabSNIR2nuSt+Pw5Lxm8xEo0+bVp9zK7Rp6FpcrHf7fxJq7UH1U=
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com (2603:10b6:a03:4fa::13)
 by BL4PR07MB10483.namprd07.prod.outlook.com (2603:10b6:208:4e0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:57:14 +0000
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::5ee9:2fcc:af97:aed7]) by SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::5ee9:2fcc:af97:aed7%5]) with mapi id 15.20.8769.022; Tue, 3 Jun 2025
 13:57:14 +0000
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] dtc: Add Kconfig option to pad device tree blob
Thread-Topic: [PATCH] dtc: Add Kconfig option to pad device tree blob
Thread-Index: AQHbybRGYdDSk0PxskW8cYbd6wk5RbPwiKCAgAD/gUQ=
Date: Tue, 3 Jun 2025 13:57:14 +0000
Message-ID: <SJ2PR07MB9711838697E12AB9B1A53015816DA@SJ2PR07MB9711.namprd07.prod.outlook.com>
References: <20250520182305.3819776-1-eric.schikschneit@novatechautomation.com>
 <20250602223101.GA1230232@bill-the-cat>
In-Reply-To: <20250602223101.GA1230232@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=novatechautomation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR07MB9711:EE_|BL4PR07MB10483:EE_
x-ms-office365-filtering-correlation-id: b83db0f1-de43-4b6c-acf4-08dda2a68b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?bU9hN25ZZ09Bb0k3ZjgydlplRFd1dXA3TFVoOFFreGtTUjlGSEYxTFI5aEp4?=
 =?utf-8?B?RmxKelpHNmNhc1pVRFlVQTdTTGlrV2ZzRzh5Y3h2Ukx4UWNDL29DTS9wdm4v?=
 =?utf-8?B?Q3NyK05WL25jczNOZmQ1S2JQdllRZnBzUnFVaXlicGIzcGxRdm0yQ3dQUFRT?=
 =?utf-8?B?d1ZodXA3TE1ZS1BUSDJSYlJtNkg4cm0vajAxeDRoT2d5T0FpRGJJdmpLOVhD?=
 =?utf-8?B?U29PTm9MUTBMcWdLZ0NpSUhQcGlSYmNxSzVhcEZ4WEJBa3VPdTVsa3JQdmFH?=
 =?utf-8?B?QUE0Rk51alVKeFk0cTduSENhM0xrRzVGNUh2dHo0ZzIvS3ZMNUVNOVFWbGlh?=
 =?utf-8?B?RXlqcjZhbFBzU3FoazFSR0tGN2VOcHMvVmNmc1ZRaDZTRi9DMEZQY0xGRDly?=
 =?utf-8?B?NlVsYkZFOTM0QmZOdyt5UFFSUjFzemxXMWp5UStoR3lud1ZJN1M1M08xcW9R?=
 =?utf-8?B?R3RSYWtRT1FOSFBGY0dHZWllSWYrY2h6RjNsQzZHZ0kwZCtidmxCL2FrZXVj?=
 =?utf-8?B?K1h6dEQ2RDZBUFZYOEdMWTcxMzU4ZDF1RHh3L0Z1ODNHTDdIdzM4Q1ZyWWpH?=
 =?utf-8?B?NmVubCtlMk81Y3RoWi9GamlhYVlONUJKdThiNi9iMEtaREM3WEJ2WXE0ajJZ?=
 =?utf-8?B?Zlp0SDU0aWlzc3RSdFhXRmRiejQ3d09NaFkyR2xyUGpNUWdKRW05UVdXR3Ju?=
 =?utf-8?B?TEFvQTdDVlJ4V21TSmE4eThsY0Fxdm1VK2ZOZWRWdXZCMEZqY1VLc3FDQVFa?=
 =?utf-8?B?RzkwM2c5WjQreUNITU1iSGVMSk5jcnQ3WGh2bDdXVXdPUEFuN1RjTjB3NU1R?=
 =?utf-8?B?aGVOeXNncXpsVDUzWmg0WDBPMXRoaitkV3RUdi83WUJ2OUZja2tYNUtHSlJG?=
 =?utf-8?B?NFhvNmZybGlVZU90dDB4dVRTNHRmR0UzSTliT1ZNbHZZWU13SDNacGdxK08r?=
 =?utf-8?B?VUx2UEt0L3VrcjVPYURRUklwc21vYkd6YnBzWHk1ck8yK0wyMGRPODBKT2x4?=
 =?utf-8?B?WXNXMnZ1Q3E4cDUyL0s2RWkxSmRVY2R6K3h0VlplSTg1d2dRc2pOTVFqejJh?=
 =?utf-8?B?eEtUTXhWdjFMSU5yMDBDZlFSRU5QUFRtUDVXZTkvaUo5dVhZcmFQVm5hME5u?=
 =?utf-8?B?YkNBNjBxQWF6a2pJWE5KYUxoTmVjcmhlSmFodm8yc1UvbWM5YmVHMVFsL0R3?=
 =?utf-8?B?eUtmRGdlL2NHQzRxY0QxV0NhNmpoSGhKV2dNdUdmNXJPenNPQ3BYY2N1VEtB?=
 =?utf-8?B?ZW5PeTNqSGJsVi9EcmNId1RIYkNVVDQ5d1BRNnY4QVF2WG4wemFvcmsydzhJ?=
 =?utf-8?B?R1VwVlZtMU1uZmREWUNDRnZaV2gzS2Izd05qZXhJNjRsY2kvdXhTVXkwK2dZ?=
 =?utf-8?B?SURIaE9sWkpPNkRUOEQ1djYwbUtoRzlWYTd5U3JTU3NCZ2tpcDNrRkNuVkRO?=
 =?utf-8?B?LzdIM0ZzaDR6SzRSNUpTZ1pxRW1RZ0M0aDQ4NzhhV0pIOTRUOGx2UmdlcC9H?=
 =?utf-8?B?dloxcnY4VjZpeDVhQ2xrQVdNT2MrODVLc0V5clRTTEZwOWdnZU1iTW9yUlNL?=
 =?utf-8?B?ZkVnKzNkVHA4V3RtVFlQY1BEamRpUkZHYTI1Q1lWL2N4OGkra1BtNG5aTFQw?=
 =?utf-8?B?Qm1ObE9RZDdxdmc1SUM5NVdsNFV6SDhVN3ZobkgwZkNSbGxRdTVTbHFrV1Ja?=
 =?utf-8?B?djFlUjZBbFRBanB5bWlCNmg2d21HdTN1WjhhdHRET01FcUJRaHRGdnRra3Jo?=
 =?utf-8?B?eFlwZzJyVlk3bHcwY3U1SlBQZVB6OXBVSTBpYkUyMDgyaHVoUDdCNHVQOEpQ?=
 =?utf-8?B?alFlZjN1bXZFRno4YkJGL2JaT2dGY3MrdGhHZ2Z3NE01WFBXbWZoQ3pxWlZu?=
 =?utf-8?B?ZU5mWXpLbU00Z3dmVjNMOVluVzg2S3hqdVk0em1jYUJIa05sdkN2YVBObk5y?=
 =?utf-8?Q?myIm3736rlE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR07MB9711.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUlxYWdWOFJFNCtOc0RCV2V5a05RalJLOXVkT2J3MGNjcVBjL2lmZTAyUDds?=
 =?utf-8?B?UlNhMDBNQXlrSzZwV3BraFUxNHZ2Q0tXMkpHdEtVNXFaODdJdUF2a0NJT040?=
 =?utf-8?B?SjJ5Um5UZlo1NklmQnJZbzVETjBGRklPSERXbXQzRlQzbklzL0RrbStKQTdS?=
 =?utf-8?B?amFiWGFqUDdEeVk4Yy9tUU8vVmlmR1hIZC96Wjdaa0s0TVNQNUVVNXdaVVNK?=
 =?utf-8?B?Tnk4eUVmTm5HMS9qcE1LampGSVpOUzNPcVQ1R1kzODBXUjZYS0xnamgwb3Iz?=
 =?utf-8?B?ZWpWd0t5M1hyek5wNmxicFkrTk9VSTJFRmptMm1ka2t3eHhsb0JOMzNiNHhw?=
 =?utf-8?B?NEZ4TjVNeFIyeGtlV2NsSXVSNEw5QmRON0pEbFU0NHlpcmEzelRka1ZZNFVP?=
 =?utf-8?B?Zllram5DTUZtd3ZoVTRNcENDVHYvcDJ0WnFaNmxNY1pRc2gvZTlJUzRyRmNE?=
 =?utf-8?B?L3IyUDIxQjRaaC9OeXZnZGFIQTk3SGJHYzdFMkh2dWZaSnVGTmF2a3VxbG5M?=
 =?utf-8?B?bHdjQlhLbjc1ZUdxSWFQdlFXeEp1cUM5RjNHWFQ2Q1RUS0tDWm1ULzZ6M2Rz?=
 =?utf-8?B?N2ZIazU0cFZnUDdaRytNdnlkaFNjcVdUV3UwMVBsUTkxbHpQRUNWV3dkRzRN?=
 =?utf-8?B?SktBSklOSXZMSVE3NUxzWVNRdFBBWTljZFZabWlMRVA2aEtRZ3l6aWwvbmlS?=
 =?utf-8?B?YVhlUHllMEUzNCtEeXZab0NhOTUzVmo0RmxKUExSSmk5YWZvaWtSRmxPMFZ2?=
 =?utf-8?B?cUJEa0VQSjR1RnRiSlU1SkVwTXFWdXhWcG15ZWRwMm00bTBtREdKRW1PbCta?=
 =?utf-8?B?cnBnVFF4YkRCY0JmYlRob0R6c0FVMHNQQ3oyaTBJREl3S2dkZDZsMm9aejhs?=
 =?utf-8?B?YlpKRmxuUzRiejdQWnpVc3dTQUxBWXRMeTlaSXJtb0ZFTHpJLzhUekxJalVR?=
 =?utf-8?B?R2EvRzVFcGcxL3dBQTdLYTA2TEc4VlZTWm5vKy8wbEhHa0Irazg5ekZxckti?=
 =?utf-8?B?UlVMR1Arbzl2Z2RBT3hJZzdnVnNiSVNlMHBVdEt6cy9CTHhoNDNyY29QMFBC?=
 =?utf-8?B?Mk40cW1QdU1rdExFZm5pekdYSWFVRk1WQXpiVEFDcEx3Vzc2blFZc0JEWVNh?=
 =?utf-8?B?b0FaVXpFeUtaNGhxaFFiak1lang2VXd6S3B4WHIrUUhoQzEyVnpzUEJtZ2pD?=
 =?utf-8?B?UEYreHJBR2RiclU0VVlkalUxZUpSL1E5YkRRT3E3QjV0RnIrSkRTSTU2dGVX?=
 =?utf-8?B?Z21ZaXNvR2l2a1Bvd1AweHJlRGlFcW1KdXpLRTQ0T0tZM2thOW5JVFBoWHo2?=
 =?utf-8?B?U3NGbDNBVjB4cVovY1N4NkduNWtrTEQ1bXhxY1Mya1BEbGZNV0JZUi9CNzFQ?=
 =?utf-8?B?U0kvWmhmcXhjOS82RU80czQ4R2ZrK1RYSHh0NUVUMTVhKzBwT0hISkhHNmhL?=
 =?utf-8?B?Uno2bU5SeWNJYVNodUhPS0dOeFpOV3JIQmttT3RNdnBGRE1GeVdyU3VCSFd0?=
 =?utf-8?B?OXhLOEdGdGhkY0xrbWdOeXhjbEtRY3NqZmdsa2F0dlF5UUNGcUhTeVNYdDFK?=
 =?utf-8?B?U2FjR1l1b0VYbjZwdDlGV0M4eGZ2b3pTZE1pS0U4U1l1V2Q5OWlPbm50YURz?=
 =?utf-8?B?eWZPL1VIVmp1bGViZEFGaU4xdkhQKzlnUE5JbytMNHBZbWxtczhXK1ZNU0Fq?=
 =?utf-8?B?VlVmK2o3NnR5dUgyMllZOC9rTHNtOVhQWDg1OG5NNmVIZjVhSVpqdTFRdTFs?=
 =?utf-8?B?Y016RFViTDZ5RU5mMjhBazkwMDloWlpHdTBUZHVsNHZBUUVqa0czM1hiT0hk?=
 =?utf-8?B?ZzVkMldPekNTNEhaakVBMlFNUkgrazFHVVgvU0cwWEFLNzk2MFlNOFJZaUZu?=
 =?utf-8?B?OGJ2cTFCeHV2STd0Tld1aFNTSkY0eUNHR0ZwSTFHRGlIZUdmVkVoVnBUT1Bl?=
 =?utf-8?B?WmlaR0l2NVA3VlpRSjNoM3BHWi9jUzhDLzhxWDdtbTVDdlM4V2pub05GQUl0?=
 =?utf-8?B?VURtOVlreEdxZE5oZENrVnp3bERSMjBKYXRWMXltM252c1MzUFgzN1BadlRn?=
 =?utf-8?B?VTVVaFJaSmpCSWtmTTRpVWxPaEZRNmdQN3I3b3d1OUdyV2JYVjZCNWd5eUVQ?=
 =?utf-8?B?b3o2TldBTUFrdWxSZ1VxWlRLcVhuSlgyV0tCenZyOEVud3ppd3l3a01zaFJX?=
 =?utf-8?Q?KtN39xho9RjOozBohTcRP04=3D?=
MIME-Version: 1.0
X-OriginatorOrg: novatechautomation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR07MB9711.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83db0f1-de43-4b6c-acf4-08dda2a68b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:57:14.2174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb0f6598-d3e5-4ff3-a8b8-fe893d304059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNwWAZJsOrj/k/LiHia5AqWVDdvIs+BmiX9ihcO56hwWBeMA7w1bBHvk3UMmEcX5FRmGsl+2hoURliWxAeL+B4qfKDUOXbu9pU8ehi27h2bsgQMi0a6sMRtl7rP1gvYCHAs5y9BFxVJ45dysw3NJ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR07MB10483
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

VG9tLA0KDQpJIHRoaW5rIEkgdW5kZXJzdGFuZCB0aGUgcHJvYmxlbXMgeW91IHN0YXRlZC4gT2J2
aW91c2x5LCB3ZSBkbyBub3Qgd2FudCB0byBjYXVzZSBhbnkgcmVncmVzc2lvbnMsDQphbmQgSSBh
bSBoYXBweSB0byBtb2RpZnkgbXkgcGF0Y2ggYXMgeW91IHN1Z2dlc3QuIEkgYW0gdW5zdXJlIHdo
YXQgdG8gZG8gYWJvdXQgeW91ciBkdHMvdXBzdHJlYW0NCklzc3VlIHRob3VnaCBiZWluZyB0aGF0
IHBvcnRpb24gZ2V0cyBzeW5jZWQgZnJvbSB0aGUgbGludXgga2VybmVsIHNvdXJjZSB0cmVlLCBj
b3JyZWN0PyBBcyBmYXIgYXMgdGhlDQpBUk0gLyBBUk02NCBpc3N1ZSBJIGNvdWxkIGNoYW5nZSB0
aGUgZGVmYXVsdCBsaW5lcyB0byBzb21ldGhpbmcgc2ltaWxhciB0bzoNCg0KZGVmYXVsdCAgNDA5
NiBpZiBBUkMgfHwgQVJNNjQgfHwgTTY4Sy4uLi4uDQpkZWZhdWx0IDMyNzY4IGlmIFg4NiAmJiBF
RklfQVBQDQpkZWZhdWx0IDANCg0KVGhhdCBzaG91bGQgYWxsb3cgNjQtYml0IEFSTSBwbGF0Zm9y
bXMgdG8gYmUgNDA5NiwgYnV0IDMyLWJpdCBBUk0gcGxhdGZvcm1zIHRvIHN0aWxsIGRlZmF1bHQg
dG8gMC4NCg0KDQpFcmljIFNjaGlrc2NobmVpdA0KDQpTZW5pb3IgRW1iZWRkZWQgTGludXggRW5n
aW5lZXIgSUlJICDigIsNCg0KDQoNCk5vdmFUZWNoLCBMTEMNCg0KMTM1NTUgVy4gMTA3dGggU3Ry
ZWV0IHwgTGVuZXhhLCBLUyA2NjIxNeKAiw0KDQpPOiA5MTMuNDUxLjE4ODDigIsNCg0KICDigIsN
Cg0Kbm92YXRlY2hhdXRvbWF0aW9uLmNvbTxodHRwOi8vd3d3Lm5vdmF0ZWNoYXV0b21hdGlvbi5j
b20vPiB8IE5vdmFUZWNoTGlua2VkSW48aHR0cHM6Ly93d3cubGlua2VkaW4uY29tL2NvbXBhbnkv
NTY1MDE3Pg0KDQpSZWNlaXB0IG9mIHRoaXMgZW1haWwgaW1wbGllcyBjb21wbGlhbmNlIHdpdGgg
b3VyIHRlcm1zIGFuZCBjb25kaXRpb25zPGh0dHBzOi8vd3d3Lm5vdmF0ZWNoYXV0b21hdGlvbi5j
b20vZW1haWwtdGVybXMtY29uZGl0aW9ucz4u77u/DQoNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCkZyb206IFRvbSBSaW5pDQpTZW50OiBNb25kYXksIEp1bmUgMiwgMjAyNSA1
OjMxIFBNDQpUbzogRXJpYyBTY2hpa3NjaG5laXQNCkNjOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0K
U3ViamVjdDogUmU6IFtQQVRDSF0gZHRjOiBBZGQgS2NvbmZpZyBvcHRpb24gdG8gcGFkIGRldmlj
ZSB0cmVlIGJsb2INCg0KT24gVHVlLCBNYXkgMjAsIDIwMjUgYXQgMDE6MjM6MDVQTSAtMDUwMCwg
RXJpYyBTY2hpa3NjaG5laXQgd3JvdGU6DQoNCj4gVGhpcyB3aWxsIGFsbG93IGFyY2gocykgdGhh
dCB1c2UgZGV2aWNlIHRyZWUgYmxvYnMgdG8gcGFkIHRoZSBlbmQgb2YgdGhlDQo+IGRldmljZSB0
cmVlIHNvIHRoZXkgY2FuIGJlIG1vZGlmaWVkIGJ5IGJvYXJkIGZpbGVzIGF0IHJ1biB0aW1lLiBU
aGlzIHdpbGwNCj4gaGVscCBwcmV2ZW50IGVycm9ycyBzdWNoIGFzIEZEVF9FUlJfTk9TUEFDRSBm
cm9tIG9jY3VyaW5nLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNjaGlrc2NobmVpdCA8ZXJp
Yy5zY2hpa3NjaG5laXRAbm92YXRlY2hhdXRvbWF0aW9uLmNvbT4NCg0KSSB3YXMgdGVzdGluZyBt
ZXJnaW5nIHRoaXMgYW5kIEkgZm91bmQgYSBmZXcgcHJvYmxlbXMsIHNvcnJ5Lg0KDQo+IC0tLQ0K
PiAgYXJjaC9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgNyArKysrKysrDQo+ICBhcmNoL2Fy
Yy9kdHMvTWFrZWZpbGUgICAgICAgICAgfCAyICstDQo+ICBhcmNoL202OGsvZHRzL01ha2VmaWxl
ICAgICAgICAgfCAyICstDQo+ICBhcmNoL21pY3JvYmxhemUvZHRzL01ha2VmaWxlICAgfCAyICst
DQo+ICBhcmNoL25pb3MyL2R0cy9NYWtlZmlsZSAgICAgICAgfCAyICstDQo+ICBhcmNoL3Jpc2N2
L2R0cy9NYWtlZmlsZSAgICAgICAgfCAyICstDQo+ICBhcmNoL3NhbmRib3gvZHRzL01ha2VmaWxl
ICAgICAgfCAyICstDQo+ICBhcmNoL3g4Ni9kdHMvTWFrZWZpbGUgICAgICAgICAgfCAyICstDQo+
ICBkb2MvYm9hcmQvYnJvYWRjb20vYmNtN3h4eC5yc3QgfCA2ICsrLS0tLQ0KPiAgZG9jL2RldmVs
b3AvbWFrZWZpbGVzLnJzdCAgICAgIHwgNSArKysrLQ0KPiAgc2NyaXB0cy9NYWtlZmlsZS5kdHMg
ICAgICAgICAgIHwgNCArKysrDQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvS2NvbmZpZyBiL2FyY2gv
S2NvbmZpZw0KPiBpbmRleCBlYTMzZDA3YzA4Ni4uYTY4M2FmM2Q1OTEgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvS2NvbmZpZw0KPiArKysgYi9hcmNoL0tjb25maWcNCj4gQEAgLTYzLDYgKzYzLDEzIEBA
IGNvbmZpZyBTWVNfQ0FDSEVMSU5FX1NJWkUNCj4gICAgICAgIGRlZmF1bHQgNjQgaWYgUklTQ1YN
Cj4gICAgICAgIGRlZmF1bHQgMzIgaWYgTUlQUw0KPg0KPiArY29uZmlnIFNZU19EVENfUEFEX0JZ
VEVTDQo+ICsgICAgIGludCAiU2l6ZSBpbiBieXRlcyB0byBwYWQgZGV2aWNlIHRyZWUgYmxvYiIN
Cj4gKyAgICAgZGVmYXVsdCA0MDk2IGlmIEFSQyB8fCBBUk0gfHwgTTY4SyB8fCBNSUNST0JMQVpF
IHx8IE5JT1MyIFwNCj4gKyAgICAgICAgICAgICB8fCBSSVNDViB8fCBTQU5EQk9YIHx8IFg4Ng0K
PiArICAgICBkZWZhdWx0IDMyNzY4IGlmIFg4NiAmJiBFRklfQVBQDQo+ICsgICAgIGRlZmF1bHQg
MA0KDQpJIGJlbGlldmUgdGhpcyBpcyB0aGUgbG9naWMgSSBzdWdnZXN0ZWQgYW5kIHNvIHRoZSBw
cm9ibGVtIGlzIG9uIG1lLiBGb3INCkFSTSAmJiBBUk02NCwgdGhpcyBpcyByaWdodC4gQnV0IGZv
ciAzMmJpdCBBUk0sIHdlIHNob3VsZCBiZSAwIGFuZCBsZXQNCmluZGl2aWR1YWwgYm9hcmRzIHNl
dCB0aGlzIGFzIG5lZWRlZCAobm9uZSB0b2RheSBidXQgeW91ciBib2FyZCBkb2VzDQpuZWVkIGl0
KS4gVGhpcyBsZWFkcyB0byBzaXplIGdyb3d0aCBhbmQgdGhlbiBmYWlsdXJlIG9uIGEgZmV3IHBs
YXRmb3Jtcw0KaXMgaG93IEkgbm90aWNlZCB0aGlzLg0KDQpUaGUgc2Vjb25kIHByb2JsZW0gaXMg
dGhhdCB0aGUgTWFrZWZpbGVzIGluIGR0cy91cHN0cmVhbSBhcmUgY29uZnVzaW5nbHkNCm5vdCAx
MDAlIHVwc3RyZWFtIHRoaW5ncyBhbmQgc28gYWxzbyBuZWVkIHRvIGhhdmUgLXAgMHgxMDAwIHRh
a2VuIG91dCBvZg0KdGhlbSBhcyB0aGV5J2xsIGdldCB0aGUgdmFsdWUgdGhpcyB3YXkgaW5zdGVh
ZC4NCg0KLS0NClRvbQ0K
