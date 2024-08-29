Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E070BC7115D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 04:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5D48806A;
	Thu, 29 Aug 2024 06:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mono.si
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mono.si header.i=@mono.si header.b="CTQ3G9YR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E680D88A1E; Thu, 29 Aug 2024 02:31:09 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1162E8862E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 02:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mono.si
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=tomaz@mono.si
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1rzzb1zDkFT4Mak5dUDyA4Iwy0XOWpRcYwTsh785Tf6QFNFYGxeoY61J7298eYEiRCWd2pfMbHNFfS0Ai4PjpUIpXrmFOhY6VK7B9JCkpapJGByTLuFfE8PvCasP2v0Hr8OCATC97pUarcz5PDYccKkarrzSt9h5occLAzb+lbfr0EkXjuJNAj67HA1ryI4VIBx7lJfH/Gaj3EpV3Ccg2MoqtX2LpztxYwmw8mM0jbut55fj0d9cemaRLIOYSNPhpMxYpUTbxx2qMtMBEiskeXenbUL4efsrgAc9THaRBKV3GVZ048yF7kMRM/biyvD6ey0WR3Ha831mhXDY/Pzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjTSN/qEuY1bqV89x0qZuaRt1PJ9vWUZamMfv8IFxYg=;
 b=oJVjORFT/yqT2oNNNJe1ApFOMJF/tDB+kgkt8dmzV/yGJa1eccIriLCKD4Nu4g3fauMqBS4RWhrBXFDA+JvC0gK1qEPL5hRrU2JvG6UYBG9japvrx30j/cDYrVOgi8R6H9o7jcIogkSt9dmMBZ/Tnj6SilB/OC1GNN3iuHAaEpoCDCdD/tU/XwQ/uzVTGhP2Si5YrfDSgzfqlHeF82298PqH131SM/9k9IRMAemFvFZRUCoYoxDLUQvClXfLSesVwQ78tdJ5FpLtgxJQ57fXsEea610V/psMkSjUSklCNMGuSJ5HPMy0JV94ZXjqgeJ9aYc/4tukhCpKQ7KkEC84RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mono.si; dmarc=pass action=none header.from=mono.si; dkim=pass
 header.d=mono.si; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mono.si; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjTSN/qEuY1bqV89x0qZuaRt1PJ9vWUZamMfv8IFxYg=;
 b=CTQ3G9YRc6URk0dQWWPZkmFsmukPSX6dTsq/mfDlNPUo/24nam27bLrHvfh7v+LKLmNRJ29vGdi5/OWCzQZY2S/71ADohsf4cQxzWxTNAw1fXVjrH9Axy8pwlerB7Ghxxh8lYd81X9fS8AGIXMgfBGnLcGW37QM7977xN66LdoQShGMEb7kSgFTDs39nF2TL+7YTGbUnlkAo4xrDqhH8OyYvIex5/YrQMhfhqT1TuPnKs3tTmqeKM/rPAGmFxaCYtQKSzWj0biplmsxbcovGskE7uInaGC7ih7Lr3jdsg08HIT3b322PkUQMKcUvUQDVs8XL5UghrIoRjUfD3EDrPA==
Received: from SN4PR22MB2870.namprd22.prod.outlook.com (2603:10b6:806:209::5)
 by PH0PR22MB2982.namprd22.prod.outlook.com (2603:10b6:510:14a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 00:31:02 +0000
Received: from SN4PR22MB2870.namprd22.prod.outlook.com
 ([fe80::5f68:bf29:bbc9:f5ca]) by SN4PR22MB2870.namprd22.prod.outlook.com
 ([fe80::5f68:bf29:bbc9:f5ca%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 00:31:02 +0000
From: =?utf-8?B?VG9tYcW+IFphbWFu?= <tomaz@mono.si>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?utf-8?B?R3J1YiBkb2VzbuKAmXQgbG9hZCBkZXZpY2V0cmVl?=
Thread-Topic: =?utf-8?B?R3J1YiBkb2VzbuKAmXQgbG9hZCBkZXZpY2V0cmVl?=
Thread-Index: AQHa+aq5s5if99FqF02wvYWB7MIEcw==
Date: Thu, 29 Aug 2024 00:31:01 +0000
Message-ID: <7cbce75d-51fe-4c87-9c90-01e86a06f0fe@Spark>
References: <7f33e3d7-e5ab-4c1d-a69a-153a50a6b0c2@Spark>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mono.si;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR22MB2870:EE_|PH0PR22MB2982:EE_
x-ms-office365-filtering-correlation-id: 56cfaad7-e7df-4db3-cec6-08dcc7c1dc65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZEw0UGQxMVQzQkFwUmFDdVNxanB1WTJHUWI0enVZazFOaHA4bnlyU1N3NmZ3?=
 =?utf-8?B?Vzh4R0xWNFd6U2FsTDBCSHh1OXRLVnJOYXNMSW8vTnRvV0JLTFJtMUdzdDBM?=
 =?utf-8?B?UnlKUE1pTEw0eU54ejNnQTM1Mk8vWmtsR2RDOERzMk5vZUNTY1dJVTl3NElm?=
 =?utf-8?B?c3NOY3dxSzJVcjV1T2ZSVWhXNGE5RFU4VUVLSzcySUVBZ3ZRTGJ2REhYTDNj?=
 =?utf-8?B?cy9yRkwrRzcyRkZheVprVzFEQTVMNVMwWXMvQ3BhaW10SWZKN2V1aFZKRTJJ?=
 =?utf-8?B?QVNOcUc1ekEyN1lPUUNxdzZtZGgxckpKSC9Nb3BzejRINDlaZ0FHQVpQWjV3?=
 =?utf-8?B?RGc4YXBORGxOMmp1RndHcUhFQXNLOEFZVWlzVFFBVzRFcjVZNTNlOUlURDVp?=
 =?utf-8?B?ckJBS3UzaUd3VUp3YVF0SXBlbURNdFN4N2wvWkhQR2RzMWJRbWN1a2RTZkJ5?=
 =?utf-8?B?WFR2Smx2Z2t5RkdXMWR3NS8xV3lock03R211ZnN4dlJzVXNORS9EaklFQTFR?=
 =?utf-8?B?SlBmdHpJZytvUmJJY0hRMmNFVUhOclVvY2dmMFQzMXNrdjFDdi83TmJNSUVT?=
 =?utf-8?B?K3VUQm1HUVB6WU8wWXF5cG9keWdCT0VIZUtBVHdSRjREVXJlclQwNkRWbWdl?=
 =?utf-8?B?amVKb1NQb0VJOVcxcU1PS1YvVmttS2tpZ2xMazF2WTBpS2lneVdzNHVvbW1X?=
 =?utf-8?B?QU4zTHZDTUR0bmZXMEdBb2YyQ2NmQ2tzektTbS9Bb0U4RTc3dU9KWmdQSnd4?=
 =?utf-8?B?UjlEalhDc0h3OWdrQTB5aUJUUmVKOEo5d3R6a1NXVEplYVBHN2dBVDJVTWFG?=
 =?utf-8?B?YzZpRDVSUXRvZVN6emx2OHVtS3dZZENNay9vbC9oWVNWQUxGZjM5YzhDMWdL?=
 =?utf-8?B?UmhxZ0loLzhvZkxkRWdwckhrS0FjMWlKZmlGT2k0YzRjS051NzhrUVJDR1FH?=
 =?utf-8?B?QkRVaFhYdFFoYjBhZkQwSTBsdFBwM1hzTXBwVEFJbTlKcU5aQkV1bzV1M3BE?=
 =?utf-8?B?bFFLOTR1U21NU3d2ejg1bVJ1YzR0WFBRTXVQRlhuelZrRzNsOExneVZWb3Ra?=
 =?utf-8?B?Qjl0OVQ1enMrTlJVVzZJN2Ixd2UzbnBkOC9vd0UzVVFVQVJqRDJDLzZCYWVW?=
 =?utf-8?B?RHRoa01tL0xuWXVaMWIvY1pUbVhydFJ5TlU5Yzc1b0JZNmt6aW9RUWpTeTgw?=
 =?utf-8?B?RitRWWUwa1VTcHZOWTcrK2RBMEllM0VIRDNBQU92OFNYNllsbDJHRmpMSm5y?=
 =?utf-8?B?ZHlxdUJyd1ZsYS9uUlFmSTNZM0ZoT3JJbUVSd0MrWFkvcExsQVJpSm50VzJB?=
 =?utf-8?B?SktnUFZ0aGlhV1MzZC8zOHJWRDRyNjFIWXJIaExJRm5RL1IwL3JyL3ZzbU5M?=
 =?utf-8?B?TkJVYlk2WVNmYjkrZTF6UEZydG1iT0dHVzB0QnVlYTR2US9KZUY1NXBidGR1?=
 =?utf-8?B?L3B5Rk1VdHlJRGFGdFBmMDhtR2dRY1NHVGFMNmhQU01TZXJWTjZzTVpEWldK?=
 =?utf-8?B?eCtUMVFjUWZTNkROaTQ1aXFvODZEUlRjK1MzcFVVS0xYQUJ2Zm5zUEtsaFdR?=
 =?utf-8?B?NTNFZnVuWmNpTFdXNmRPUDJJVXJZQ3FubFZOMXcyM1hmeEEzZmI1RVZ0WDkz?=
 =?utf-8?B?dmN6WkFQMTNiSHpWTjVBRDJSa2I0eXdWV24wMXhQdVcvd3pEeUtYMnJrMm5i?=
 =?utf-8?B?MllJTUY1a0o3cDl2amV5MWJmdzNpZDFka3VmNkliTHJOZmpwUG5Tb3AzWjVn?=
 =?utf-8?B?NkFjZytPeGUwbXVFbDdjQVc0aFFiOG0yR202ekpQckJTK0JZUGhOSUxLOStW?=
 =?utf-8?B?bjd5R1pFc2lvbmVRb0pvem1Td0QxQmU5NmNwZGxNVFpMUmh5eDQ5MEFWaHp0?=
 =?utf-8?B?V05HOUlKQlVzUUhaTEl3cTlDTUtJM2pkb1ZBWDZ5N3VJYkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR22MB2870.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnprU0MvSXI2bWZDZnlTaEpuakNWVENhV0ozNVFtY01PLy8zbGY4UkZqRGdt?=
 =?utf-8?B?UmdNbUdoRUEvK3VkTU40dStNY0JPNkt3a0JOT2EyellQVXRWMjViM05Wb2lu?=
 =?utf-8?B?UzgvWU1pS2t0N1gvNlUvK2l4cC95NmRkdW9XQWk3RHFTalp3YVRrZ0NrenN5?=
 =?utf-8?B?UXRyNk9MKyt2SGJKMGFTVGRYRTZpZWtZQ2RaNWdQdUwxWVFHZTIzVlVwOEho?=
 =?utf-8?B?bkJWZlp1YjBJZTNONGEycVZHNHkvZmJ0cklvTThJcWFuc3FzOXhVSzk2Ym8x?=
 =?utf-8?B?SS9nRUZYaXIrL0s2UlBFVDdRaVhQa2tIdU93Nm00RzFHaXJleGVCSkQxb3Fu?=
 =?utf-8?B?L3I3UmxocE1QUVFVcDZoMHRPa1N5THZuWVhyMCtGWldRNTdpbWtzam56RXZL?=
 =?utf-8?B?dlNib3hGVURaTXVMN1R4U1ZtVFJSMno5VDMwUmNzNEdXbnY4cXg0QUwvanRa?=
 =?utf-8?B?cW11aHpVblluTDZWWmVHZTZ5Y3lraGJoRjlzcjZGSHhKeFBSNkVrV3pCRTR5?=
 =?utf-8?B?V3VLUEd2YTV4OWRWMHpsYmRhWWFCYitsRjF0RFM4YzRJMGI1YmhiT000K2Ez?=
 =?utf-8?B?aE5wUE1mbHAwNFJYRkFxa2djK0xpWkNwYjl0NCsrUWR5TGRKWnhRNVlmVUJO?=
 =?utf-8?B?VzhxODN3M2FyQURLbWE3ZjVTVk1PUzEzTkRXdEkzQnF2V212TEVxNDZaVDdm?=
 =?utf-8?B?TjRvTWVhOSs0cTN6bWsxNzRPby9pYVlOSzZyYnMxZm40NHp0MVV1VVdvdzFZ?=
 =?utf-8?B?NTRqT2tpZUJIV3JiVHorMjVKMzdtZFhITStHN3RlNnNWY0RmV0JwU0pkMGRi?=
 =?utf-8?B?R2xRb21qVmhkYWY2alhJZ2d3UGJaSHRCTE5ud2FUdXhJcXNBTFg2L1NWSWhF?=
 =?utf-8?B?NS9mRWRacDVOaHNEK3Nlb1g0TVlSNEUwZWo3dy9Xano0NENDdmxEUXRKMHFX?=
 =?utf-8?B?Yis1Q3RGNVUzZDA1OHBjbDRnNVplMVNDbXpWOWFrenRoOVIwdTg3RXN0eVBU?=
 =?utf-8?B?QVVoam5ZUmxGbktiYXNNQ2tNZUg5SG1ZT1I1M1VMZUhKdElreG1RdFR2UHpG?=
 =?utf-8?B?SWo0a0RVT1FGYUZ5L0VJSC9Xd0o4WTVlYU14QzMrSmlQY1dQRHpxK0lRQm04?=
 =?utf-8?B?YlRDK0tsM09qNXhhNVFQb0ZndnlGbTFYcXdTWXZsY2VBaDh1UG9LWlhEc3Jl?=
 =?utf-8?B?VVcybUd4eFFyR0FUYUFHMWY3d0pSYkZ4S05mM2pDdVBkQkhEb00yYjNWYU4w?=
 =?utf-8?B?TXpaUnhGc2tVU3drRzhtdmw1NitUUnkzUWtTU05ydjJVRVNmdzgvN243NndD?=
 =?utf-8?B?NXFOZVlNRGk1aGpxMmh5R0xOZ0NZS1hYUGEvdVlXL1h2d21oSTd0YXg2TWo5?=
 =?utf-8?B?VS9UaXVodGlXbFB6WEJ2dlc2M2dCY3M0UVVpNFZtbGk3NllJS0xYZlVqTTFn?=
 =?utf-8?B?QklDUHpqV29QdTBIYlJ6TWxwYnBXalA1d2d2aXN1R2N2eE1VVDAvc2paaFpw?=
 =?utf-8?B?MTNFTmR3TjF2a2lRdHZNWnRMM3hEUXBnZnovaVhlSEFvMWg1QjRhTnkvSmFp?=
 =?utf-8?B?NVBnaDdEajNEckRtdHljLzNwZ3RDQm5EYk5aWnhYb25pbnFWdTBkbXQ1dnV3?=
 =?utf-8?B?MkM4aW84S1BjSUUrM01kdXBHdmxNeEVJcDN4QmV6UmFYeXZ6SitpK1Q3bjdO?=
 =?utf-8?B?cnE3RUxHR1hGaVg2Y0szSnpwd3IydUMvSFQwcGVFWDVoa1IydzBVRmhpUE9m?=
 =?utf-8?B?RDlvYlRQNnNkekRUc0ZHcll3RW5MRXdSU1pzeFlNS3FFdlRuRWNBQ0ZSNDJI?=
 =?utf-8?B?VXo5SFNDdjdLanJROHdlaVJXS2hUZlFSVnMrckl4ZmxkSDc0WU05L2JBeEE1?=
 =?utf-8?B?aWxaNWlUdEU4K3kwckp1VnpjYjBZSWQ2d3dyL0hueEhiRDU3VTlacUtoclRV?=
 =?utf-8?B?ZE9aeURoSFdOZHpqeXZyQzd4cWU5Q0xmeENoMmVqZFdtaHJ4alc5ZEUxL3R4?=
 =?utf-8?B?UmZIS1RYcVdTUlZVbXBaWVJmWjV4UzZwcGJzMytwaGJGWlVDRmdOcEJOZnBU?=
 =?utf-8?B?SW81ckR3MVF3ZUY1RjN2RUl0S3ZQWktQVVhVUExuM01rdVlxbWNhM2c0MEJo?=
 =?utf-8?Q?Mv6/mriNLdUgiai2gQ12u/gXo?=
Content-Type: multipart/related;
 boundary="_004_7cbce75d51fe4c879c9001e86a06f0feSpark_";
 type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: mono.si
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR22MB2870.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cfaad7-e7df-4db3-cec6-08dcc7c1dc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 00:31:01.9933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8511cf05-6076-4943-8b43-da9210b18021
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vt4PK86esCgGPeQd3xM5khTFG6EQGoxr1I6/ymf5HIsIf25W9vDEqIJnABJROmk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB2982
X-Mailman-Approved-At: Thu, 29 Aug 2024 06:14:22 +0200
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

--_004_7cbce75d51fe4c879c9001e86a06f0feSpark_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SeKAmW0gd29ya2luZyBvbiBhbiBhcm02NCBib2FyZCB3aXRoIGFuIE5YUCBMUzEwNDZBIENQVSBh
bmQgSSBzaW1wbHkgY2Fubm90IGdldCBHcnViIHRvIGxvYWQgYSBkaWZmZXJlbnQgZGV2aWNlIHRy
ZWUgdGhhbiB0aGUgb25lIHRoYXTigJlzIHByb3ZpZGVkIHRvIGl0IGJ5IHRoZSBFRkkgU3R1Yi4N
Cg0KPT4gZmF0bG9hZCBtbWMgMDoxICRrZXJuZWxfYWRkcl9yIC9FRkkvYm9vdC9ncnViYWE2NC5l
ZmkNCj0+IGZhdGxvYWQgbW1jIDA6MSAkZmR0X2FkZHJfciAvYm9vdC9kdGIvZnNsLWxzMTA0NmEt
cmRiLXNkay5kdGINCj0+IGJvb3RlZmkgJGtlcm5lbF9hZGRyX3IgJGZkdF9hZGRyX3INCg0KQXQg
aGlzIHBvaW50LCBJIGdldCBhIGNvdXBsZSBvZiBlcnJvcnMgbGlrZSDigJxzbW11IG5vZGUgbm90
IGZvdW5k4oCdLg0KDQpIb3dldmVyLCBpZiBJLCBpbnN0ZWFkIG9mICJmc2wtbHMxMDQ2YS1yZGIt
c2RrLmR0YuKAnSB1c2UgImZzbC1sczEwNDZhLXJkYi5kdGLigJ0sIHRoZW4gSSBnZXQgdG8gR3J1
YiB3aXRob3V0IGFueSBlcnJvcnMuDQoNCkFuZCB0aGlzIGlzIHdoZXJlIEkgZW5jb3VudGVyIHRo
ZSBpc3N1ZS4gQmVjYXVzZSBJIHdvdWxkIGxpa2UgdG8gdXNlIGEgZGlmZmVyZW50IERUQiBmb3Ig
Ym9vdGluZyBMaW51eCB0aGFuIHRoZSBvbmUgdGhhdOKAmXMgcHJvdmlkZWQgYnkgdGhlIEVGSSBj
b25maWd1cmF0aW9uIHRhYmxlLCBJIHNldA0KDQpkZXZpY2V0cmVlIC9ib290L2R0Yi9mc2wtbHMx
MDQ2YS1yZGItc2RrLmR0Yg0KbGludXggL2Jvb3Qvdm1saW51ei02LjYuMy1hcm02NA0KaW5pdHJk
IC9ib290L2luaXRyZC5pbWctNi42LjMtYXJtNjQNCg0KSW4gdGhpcyBjYXNlLCB0aGUgZGV2aWNl
dHJlZSBpbnN0cnVjdGlvbiBnZXRzIGlnbm9yZWQgY29tcGxldGVseSwgYW5kIGJlZm9yZSBJIHNl
ZSBrZXJuZWwgbG9hZGluZywgdGhlIG1lc3NhZ2Ug4oCcVXNpbmcgRkRUIGZyb20gdGhlIEVGSSBj
b25maWd1cmF0aW9uIHRhYmxlIg0KDQpJcyB0aGVyZSBhIHdheSBmb3IgbWUgdG8gb3ZlcnJpZGUv
cmVwbGFjZSB0aGUgZGV2aWNlIHRyZWUgdGhhdCB1LWJvb3QgcGFzc2VkIHRvIEdydWI/IEkgdHJp
ZWQgcGFzc2luZyB0aGUg4oCcZHRiPeKAnCBwYXJhbWV0ZXIgdG8gdGhlIGtlcm5lbCBib290IGNv
bW1hbmQsIGJ1dCBpbiB0aGF0IGNhc2UsIEkgZ2V0ICJFRkkgc3R1YjogRVJST1I6IEZhaWxlZCB0
byBoYW5kbGUgZnNfcHJvdG/igJ0gYmVjYXVzZSBrZXJuZWwgd2hlbiBib290aW5nIGRvZXNu4oCZ
dCBhcHBlYXIgdG8gaGF2ZSBhY2Nlc3MgdG8gdGhlIHNhbWUgZmlsZXN5c3RlbSB0aGF0IEdydWIg
ZG9lcy4NCg0KVGhhbmsgeW91IQ0KDQoNCih0aGlzIGlzIG15IGZpcnN0IHRpbWUgdXNpbmcgKmFu
eSogbWFpbGluZyBsaXN0LCBzbyBhcG9sb2dpZXMgaWYgdGhpcyBpcyB0aGUgd3JvbmcgYWRkcmVz
cyB0byBzZW5kIHRoaXMgcXVlc3Rpb24gdG8pDQoNClRvbWHFviBaYW1hbiwgQ0VPDQpNb25vIFRl
Y2hub2xvZ2llcyBJbmMuDQorMzg2IDMwIDY1MSA2NDUNCg0KW2NpZDoxOEVCMkZFRTQ4NUE0REQ3
QTFDRTcxNkNFMTRGQ0JDN10NCg0K

--_004_7cbce75d51fe4c879c9001e86a06f0feSpark_
Content-Type: image/png; name="18EB2FEE485A4DD7A1CE716CE14FCBC7.png"
Content-Description: 18EB2FEE485A4DD7A1CE716CE14FCBC7.png
Content-Disposition: inline; filename="18EB2FEE485A4DD7A1CE716CE14FCBC7.png";
	size=5014; creation-date="Thu, 29 Aug 2024 00:31:01 GMT";
	modification-date="Thu, 29 Aug 2024 00:31:01 GMT"
Content-ID: <18EB2FEE485A4DD7A1CE716CE14FCBC7>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAJYAAAAmCAYAAAAmy2KXAAAAAXNSR0IArs4c6QAAAKRlWElmTU0A
KgAAAAgABgESAAMAAAABAAEAAAEaAAUAAAABAAAAVgEbAAUAAAABAAAAXgEoAAMAAAABAAIAAAEy
AAIAAAAUAAAAZodpAAQAAAABAAAAegAAAAAAAABIAAAAAQAAAEgAAAABMjAyMzowMzozMSAxOTo0
MTo1MQAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAlqADAAQAAAABAAAAJgAAAABJtZgxAAAACXBI
WXMAAAsTAAALEwEAmpwYAAAGrmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4
bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPgogICA8cmRm
OlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1u
cyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxu
czpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6
dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnht
cE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgICAgICAgICB4bWxuczpz
dEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIgog
ICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAg
ICAgICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4w
LyI+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+MTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAg
ICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+MTA5MzwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAg
ICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4yNzY8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAg
ICAgICA8dGlmZjpJbWFnZVdpZHRoPjEwOTM8L3RpZmY6SW1hZ2VXaWR0aD4KICAgICAgICAgPHRp
ZmY6UmVzb2x1dGlvblVuaXQ+MjwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICAgICAgICAgPHRpZmY6
SW1hZ2VMZW5ndGg+Mjc2PC90aWZmOkltYWdlTGVuZ3RoPgogICAgICAgICA8dGlmZjpPcmllbnRh
dGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpYUmVzb2x1dGlvbj43Mjwv
dGlmZjpYUmVzb2x1dGlvbj4KICAgICAgICAgPHRpZmY6WVJlc29sdXRpb24+NzI8L3RpZmY6WVJl
c29sdXRpb24+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4K
ICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAg
ICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFmZmluaXR5IFBob3RvIDIgMi4wLjQ8L3N0
RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+cHJvZHVj
ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAyMy0wMy0z
MVQxOTo0MTo1MSswMjowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAg
ICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8
eG1wOk1vZGlmeURhdGU+MjAyMy0wMy0zMVQxOTo0MTo1MSswMjowMDwveG1wOk1vZGlmeURhdGU+
CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMjMtMDMtMzFUMTk6NDE6NTErMDI6MDA8L3ht
cDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxwaG90b3Nob3A6SUNDUHJvZmlsZT5zUkdCIElFQzYx
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

--_004_7cbce75d51fe4c879c9001e86a06f0feSpark_--
