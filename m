Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF280CFB448
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C91188CD9;
	Mon,  7 Oct 2024 17:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1KmVl55z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B898888EB; Mon,  7 Oct 2024 17:18:26 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DE58870D
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wphfS7rsY3bOv1LKmPOv53qVGEGGdmXtCX+kUR0jo9N7LG23sBH48igLq8eRM3yP0JZWBLDvht+5EWJPyGM0C6tTLaJQetpraWOOKfthtjexyVoBdiv5WEsIfEnDYDV/laS5QSiysUUa68uYcveSA9j4yzC+qHPdqc38anriC7Ef0JfwmLhRgX1EeYBV1cJzbgtBsHbcwmo3nrwFYWOh3A844Pf2FEVTf3hW/YSMBJjcXOal3rOwneaAcXBxMGh0Ujq++4yRqr7+xOUKSMvdGoWbEyUn+EozKSUfitOobBckmNaQnIXOOZ6QiGYvaItraMY4m6uVwPb2yz71chl1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHFfM/ollTTKat3E5QuUSUKoIZAcUX3TSYpHUrUhgxM=;
 b=QHmu7PE+l1hA4u/kIj6LDOMSMEzbR53TW0n5zc1tYGN39srVTgWSOdj1MdWvItkDABLnl14JkNbC3unCFMZWtyOnuKnBLB8qL4ISj6X5EuV34Q+sIOpOIj0jVJRPJcOMSlOXHS8wuo2gYEcdQ3MB0LP4FV8FY6ayzWYU7+X2+pYCpqqMalWRFRemIerCfHgc56pzMH+V1ZK66PARpBa6ZqZLjMCeWLGK45wU6CzWp717eGC6gJEWKJwcqCoGQe7TIlJ+eQDC8tl876lfPs8JODUuIStYBDJCRlLLztoeCqHD5HTwpmfO33d5OW9x2qSpYnqsapEqDG+KT5vSLLOmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHFfM/ollTTKat3E5QuUSUKoIZAcUX3TSYpHUrUhgxM=;
 b=1KmVl55zAdNrdwdySxeq27L3xVHCX1+clM203YKEu86j1+aLrDn/9EnBu/F0h/yNUBVwpWQi9v+oivAXcUBMLPCjme0fC6/hVNERezzecUO59dzzWI0004vSNxMe5BXiHgZfBs3nd3Gd1jdqQK05wpygXMqBjiTXaaM/RE+92Cw=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 15:03:56 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:03:56 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v5 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Topic: [PATCH v5 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Index: AQHbGHPcbHPY0ypAjECqbcJSdb+8CbJ7MneAgAAwbfA=
Date: Mon, 7 Oct 2024 15:03:56 +0000
Message-ID: <SA1PR12MB8697CE2214E5DD0A5A764833987D2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
 <20241007044547.23896-2-venkatesh.abbarapu@amd.com>
 <eb74b41b-9546-4c68-a724-00c2e33c9deb@denx.de>
In-Reply-To: <eb74b41b-9546-4c68-a724-00c2e33c9deb@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH8PR12MB6844:EE_
x-ms-office365-filtering-correlation-id: 1e0b5494-0983-414b-7e8b-08dce6e1442e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVR0WC9zUzBRaU91TSs2ZXl2NjJrYUlSN3RxMEVvTkk3QUVhbEZkU3gwWHYz?=
 =?utf-8?B?dnJtcjU0dEthOGlsY3hCcXNkQWo0OGVxdFMreHo5QjJKaEkyZyt5UnJiUXlO?=
 =?utf-8?B?V3hESE1xakdqbEJiSEwrVElaVmR4ejhKN1RIZk9qdmwvRkFBajZYM2xLZTF6?=
 =?utf-8?B?VE1VRVNFaWNPdXhDOHhQVHZzd1BHQSsydmZMNCtEbXlScE5lR2J0cTF2cC9S?=
 =?utf-8?B?V3NkL2tIZnFnWHI4WS9NanVGUEd6NS82MkdhUUdpaVUxOWpPUnV1VjNwM0J0?=
 =?utf-8?B?MVFvMXN1RHIxb3YwQXpDb2FubHNNVUF6U3JMMkxBbFhGVWFBUkpOUVVHQU5x?=
 =?utf-8?B?Tm5saVIwSlltV0JibTNMaHNUV3BFcFNSRVdiclhnMWE5RndLY2YrbGlNc1U4?=
 =?utf-8?B?VFFkbmhUbXVSdUw3ZU0vWXNyWEVPV1RFZ3laMXF0YXlRdkNJVy9oL2dHQ3dp?=
 =?utf-8?B?NzNBc29WYjc5Y05OYUZVZ0J3WGEyQzFZVXQzVmNFYWtpS2hhc3NWdzZjNUV6?=
 =?utf-8?B?RXUyV2kvelhpSkNvamJFbk5zdlI5UC9JQjdTa3hCOURLTEFQUnVMakxRZmVt?=
 =?utf-8?B?YWVwLzFrU0FUMUlwcDdlUnFwTC9sQ0w3YVJEQTAwR1k0aDRpR3VQdUlPMUVE?=
 =?utf-8?B?T0ViMFJod3c0c2ZwbVUzQ1FXT21aRU4rUjRXT0pRbUNKQUlUY2V5YTVtL2pm?=
 =?utf-8?B?R2RQSWQyRlU5ckVFVnJzNkE0Rmx5ckJ4MEpidDVFSVZEVkMzbjB5eHYvY256?=
 =?utf-8?B?emtYSXdqa2JVRVJ5eEkxbWlWNWxsTjVxT0wyMUVuSWpSUlNrSXVUanpJa2tL?=
 =?utf-8?B?aCt6MkZTQVZ6SmowM013dVNVcjkwS0oyL0Z3Z1J2VERHZWZNMmVGNXg1WkpN?=
 =?utf-8?B?Y2lna3prb1JvK0hnVWNyOG52WlZRRUttKzdjYUsvc0pmeHliTkNzWjBTc1pz?=
 =?utf-8?B?OHhJN2lPaUJienY1cFhOUGZRL2tiNFh3bDBmY3ZJRTZXTTRIdGhOSnUvSmxF?=
 =?utf-8?B?YXR0akhING50YmFJWDZ2djVKRCtaRFc4M3NQeUZSMXI0Mm9MZWpUK25idGRP?=
 =?utf-8?B?U1R4bUc5Njh4V3FVQnIwaUtVRnIwMGo2VENSa3c3WlNsSDB0T2VMcXlXbE1x?=
 =?utf-8?B?OGxMQkhIaXNzUWtLMFd4UUV3N2JsRUZGRGhXcnlxUkVuMldqNnFmYkI2UW5M?=
 =?utf-8?B?ZzVuL09vanZlU1ErZ1NOSVNnb3FPYkFveFAzMThvSFRHYXNzRndQd1h1K2pF?=
 =?utf-8?B?ZDBnNTgxeUlaOXlUWmZ3bWhyTVBqV0pTV1NYMXdYVmIxZW5tMVpUajdOcW01?=
 =?utf-8?B?alFDeVQ4T2hyS0hsZ2M3SFJNY2Q4ZXJQbktGY3owVXZvKzBjNDlMNjJPK29t?=
 =?utf-8?B?Q25pT3poWlMxU05rYUlkU21za2NIR290YU1HRVZxTUV5MFRybk5UeGQyZUtp?=
 =?utf-8?B?V1ArOW1pdjZRQUtKeGxUdWYwRjNtYkJmUEJqTU1KTUtmTm0zUEROS1lBTmZJ?=
 =?utf-8?B?SHBiSjFzalRrdEZ6ZHZUQnV0VjhDOCtYSG9wTDBWVklpK1RoaExQV2oxb2xP?=
 =?utf-8?B?ckdoUFFvcXJZRjJhNXVqUy9XZGkwQkI3SVRVQzFRN1h1aittaW1RODhsRDlx?=
 =?utf-8?B?QWVmUGtXZTY2RHAzZ0dDamQ5Y3NJWnhpS1ViUjF2TFE0Tkl0K2hjWG84N05v?=
 =?utf-8?B?SndyWFZlWnFDV1hldGlxeWp2QXdnNTB0UHJIV21OdlNaN29mV3JxdWNMWVg2?=
 =?utf-8?B?T3JGOXgwOFlGU3pCNW1NNi94NkFIUEw1OWZlb0pxTmE3cjYvK1EwV3Y1bjF0?=
 =?utf-8?B?QjVqZ29wM1BSUkczQThxQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVJKdlVmVFNOc2Fja3NKK2ZvR1hTZy9XdHZ2dnA5cVo3S2NhT2JObk5BR3ZH?=
 =?utf-8?B?Z29UREt3TUFuVzVvS2JaeXB0UVhJZDVrQ3dRckhET0I5TC9LZGRMbzBmR2tx?=
 =?utf-8?B?UG56UERiRGNiU0pQNE1OalZmZnZRclNLYms5T0ptVVJESXRLR1ExdXo0VzBu?=
 =?utf-8?B?ZEFQditBZ29NRGlLNjc2VXJ2RkVhRlNBT3d1SGVGUmVRcEJsZXBUWnlLYUIw?=
 =?utf-8?B?SnhXOGpSWHdQQkhvWTJIWGNZSzBySkY1U1UrekkrOUh3ZFRpTlVEOXdPdWp0?=
 =?utf-8?B?S21RbkhnVElzbU5MaFVDOVRqWmJNN1lKTC96UlMrYnZlaDFJK2VNMC90QVd5?=
 =?utf-8?B?QW9mSGQ3N2xQbDlmeHkydVBnakV2UDdlaFY0SXNLL0lDNFlXUXdGeXFRejY4?=
 =?utf-8?B?QVNkcTJEUFcxOEpOTmJCMXpRaUdnVEloTnEyQXh6bFoyWSs0aEhlSmtUMXVX?=
 =?utf-8?B?WXpWSjVrVlZvTzkzYUpGT1QzZEZLbmV3QVArd203Z2dBTzgrbjN3cFlWK3RY?=
 =?utf-8?B?RElpa0JRVy96YmE2QWVyR3ljRC9NaTFyQlN6SExnYzJwVjZEakV6MUNyNzI1?=
 =?utf-8?B?d1I4bjMyc1c3TURJMEUyMDhCQkUyenoyZzNhMm9MbjRxdENteU5zVUVWNE9u?=
 =?utf-8?B?UllvajlBUmhya3BxUGxtYTVUOVhnTkM0NmgrMUNuL25jRWYxMXFubVJ2c2N4?=
 =?utf-8?B?L3RYSVhtazBaZlIyd0trMzBHaXpPZVlFKzRLWmsvdjlMVDdyV21hZWh6MmFj?=
 =?utf-8?B?Y0hxc3p3ZUEvZndiU1l2OC94ZXU2ZnAxU1FJNUo1VGZpaXFEb2dZTFZBcGJX?=
 =?utf-8?B?NXhUTXVrUG1qd2phSUQweWhyWXhXNEJUWFR0QUx5U2lPek1QblBQTmtHYm1H?=
 =?utf-8?B?VzFUdjNvUE9wNUNyc29rMmZxRkNaYUtDd1VVV0dGbmp6UVFPUGpwTEt2VGpN?=
 =?utf-8?B?NlY4dCt0VWU3UWpLQldXeXN0bXJnbGs1cHZkWENNZ0hCRS9vUi95Z1lvT2lI?=
 =?utf-8?B?NUJsaFg3cVFwTXNPVG43NG4veHhmZjBQT203NWdPSWRvYWtPbnlxWmV2SDdw?=
 =?utf-8?B?V3k4YVk4cXRCYW1ZWVJqR3VWNlJmRC9JdlYzVDJXV2ZIR0RHemtuK0xCV2sw?=
 =?utf-8?B?SDhHeDArRXNxQ2J2eEUvQUltdTE3cUdkOTVhSVJvcjBoeFdpcVQ2MThHdVBZ?=
 =?utf-8?B?aHF4U1orakhHSmZxVzVEUThCL0t2eG5NUlBCekY5MjNxL0tRZlBwbDBwbnBZ?=
 =?utf-8?B?SVhCYUxFWGE4aUpnYVk5ekMxSXhrclU0NnBDQUowL201SDVUT3lXdWRtVExJ?=
 =?utf-8?B?R0NLalBtTmpOdVZuaWNsTnFkN3BxL0NCVFJwYjBjMGpPMU1JSUp3Y2gzSUls?=
 =?utf-8?B?eUJTNDhJSjUrcVBWQk1mbkxXRlpuNmN0ZVlQTnZMQ05CWkUzSzNlYjFDcFNW?=
 =?utf-8?B?ZWV6akdnVGE0azJvWmdGcDFaV2srNjlBNkFqU3JCbkZBbVZiTkRxM2dLNldT?=
 =?utf-8?B?RitDaEFUalkvRlF2K3o1ZmxBTjJEY1pNVzRXM1lvSjlnSnN1UENTZkhSTXBr?=
 =?utf-8?B?c3diQ1RwZjJMeC9WbHV4V0FHTGVQQk9HdWR3YTJzL1V1UlhlTEJDaHV3LzJF?=
 =?utf-8?B?Z3FDcTNBUGNIS3hGQkp1SCs0NW9UQjJQYlBiMXlrMmh6OHlBM0ZGMGw4SFRl?=
 =?utf-8?B?QXlnb25NY3Uza0ZuU1MyZ3E2Unlib25qTE1jMTZxcVpDQzRCUVM1OXI4VndI?=
 =?utf-8?B?RUs0U3FPTWxpZGRESXJzYWltVmlQTXlKcG9XTzNGSURoQm5ZZGIzbE14dUda?=
 =?utf-8?B?VXNzcjNiQ2RVVS9kc21QN2FKaUJoVjFuTDdrUis0RWNqTUFHb3k5b2YvTmlz?=
 =?utf-8?B?Q281ODhOMzcwVUN0Mkwzb3dMcDF3eDZaaHppVGg1bVNXYWk0VnNBOXZJUWc4?=
 =?utf-8?B?MytEaTFhSndyU2ZJaDViZkU0YmVOZ2E4VHJzVGF2d0trMDNUc0FxYmpqV1pR?=
 =?utf-8?B?eFVpMWNsd1grK0Y4WDkrTFRpWVliZ1JuQzVrWWZyNDVENXdwSHZrSllXSXdK?=
 =?utf-8?B?RldxanVXTlNRZWFBYTBDbzR0RU04QzNOUWxHaTdMN1FnVnVHdDlJUWdrYUUy?=
 =?utf-8?Q?lV38=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0b5494-0983-414b-7e8b-08dce6e1442e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 15:03:56.5262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIezng2zFl4y5bzCkZhpYo1WI5REnKb2UqPm6DXis2QZnbvL1Pu1i+Wry4IqNogwr8cCBXvMyKWJcLstqvEcbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciA3LCAyMDI0IDU6MzkgUE0N
Cj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsg
dS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0Bh
bWQuY29tPjsgZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gKEFNRC1YaWxpbngp
IDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzddIHVzYjogb25ib2Fy
ZC1odWI6IEFkZCByZXNldC1ncGlvIHN1cHBvcnQNCj4gDQo+IE9uIDEwLzcvMjQgNjo0NSBBTSwg
VmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IHdyb3RlOg0KPiA+IEFzIHBhcnQgb2YgdGhlIHJlc2V0
LCBzZXRzIHRoZSBkaXJlY3Rpb24gb2YgdGhlIHBpbiB0byBvdXRwdXQgYmVmb3JlDQo+ID4gdG9n
Z2xpbmcgdGhlIHBpbi4gRGVsYXkgb2YgbWlsbGlzZWNvbmQgaXMgYWRkZWQgaW4gYmV0d2VlbiBs
b3cgYW5kDQo+ID4gaGlnaCB0byBtZWV0IHRoZSBzZXR1cCBhbmQgaG9sZCB0aW1lIHJlcXVpcmVt
ZW50IG9mIHRoZSByZXNldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZlbmthdGVzaCBZYWRh
diBBYmJhcmFwdSA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBj
b21tb24vdXNiX29uYm9hcmRfaHViLmMgfCA0OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2NvbW1vbi91c2Jfb25ib2FyZF9o
dWIuYyBiL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYyBpbmRleA0KPiA+IDY4YTA0YWMwNDEuLjQz
MTdlODFlZDggMTAwNjQ0DQo+ID4gLS0tIGEvY29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jDQo+ID4g
KysrIGIvY29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jDQo+ID4gQEAgLTcsMTQgKzcsNTEgQEANCj4g
PiAgICAqIE1vc3RseSBpbnNwaXJlZCBieSBMaW51eCBrZXJuZWwgdjYuMSBvbmJvYXJkX3VzYl9o
dWIgZHJpdmVyDQo+ID4gICAgKi8NCj4gPg0KPiA+ICsjaW5jbHVkZSA8YXNtL2dwaW8uaD4NCj4g
PiAgICNpbmNsdWRlIDxkbS5oPg0KPiA+ICAgI2luY2x1ZGUgPGRtL2RldmljZV9jb21wYXQuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gICAjaW5jbHVkZSA8cG93ZXIvcmVn
dWxhdG9yLmg+DQo+ID4NCj4gPiAgIHN0cnVjdCBvbmJvYXJkX2h1YiB7DQo+ID4gICAJc3RydWN0
IHVkZXZpY2UgKnZkZDsNCj4gPiArCXN0cnVjdCBncGlvX2Rlc2MgKnJlc2V0X2dwaW87DQo+ID4g
ICB9Ow0KPiA+DQo+ID4gK3N0cnVjdCBvbmJvYXJkX2h1Yl9kYXRhIHsNCj4gPiArCXVuc2lnbmVk
IGxvbmcgcmVzZXRfdXM7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHBvd2VyX29uX2RlbGF5X3VzOw0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiAraW50IHVzYl9vbmJvYXJkX2h1Yl9yZXNldChzdHJ1Y3QgdWRl
dmljZSAqZGV2KSB7DQo+ID4gKwlzdHJ1Y3Qgb25ib2FyZF9odWJfZGF0YSAqZGF0YSA9DQo+ID4g
KwkJKHN0cnVjdCBvbmJvYXJkX2h1Yl9kYXRhICopZGV2X2dldF9kcml2ZXJfZGF0YShkZXYpOw0K
PiA+ICsJc3RydWN0IG9uYm9hcmRfaHViICpodWIgPSBkZXZfZ2V0X3ByaXYoZGV2KTsNCj4gPiAr
CWludCByZXQ7DQo+ID4gKw0KPiA+ICsJaHViLT5yZXNldF9ncGlvID0gZGV2bV9ncGlvZF9nZXRf
b3B0aW9uYWwoZGV2LCAicmVzZXQiLA0KPiA+ICsJCQkJCQkgIEdQSU9EX0lTX09VVCB8DQo+IEdQ
SU9EX0FDVElWRV9MT1cpOw0KPiA+ICsNCj4gPiArCS8qIHByb3BlcnR5IGlzIG9wdGlvbmFsLCBk
b24ndCByZXR1cm4gZXJyb3IhICovDQo+ID4gKwlpZiAoIWh1Yi0+cmVzZXRfZ3BpbykNCj4gPiAr
CQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlyZXQgPSBkbV9ncGlvX3NldF92YWx1ZShodWItPnJl
c2V0X2dwaW8sIDEpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsN
Cj4gPiArCXVkZWxheShkYXRhLT5yZXNldF91cyk7DQo+ID4gKw0KPiA+ICsJcmV0ID0gZG1fZ3Bp
b19zZXRfdmFsdWUoaHViLT5yZXNldF9ncGlvLCAwKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJ
cmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwl1ZGVsYXkoZGF0YS0+cG93ZXJfb25fZGVsYXlfdXMp
Ow0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGlu
dCB1c2Jfb25ib2FyZF9odWJfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gPiAgIHsNCj4g
PiAgIAlzdHJ1Y3Qgb25ib2FyZF9odWIgKmh1YiA9IGRldl9nZXRfcHJpdihkZXYpOyBAQCAtMzAs
NyArNjcsMTEgQEANCj4gPiBzdGF0aWMgaW50IHVzYl9vbmJvYXJkX2h1Yl9wcm9iZShzdHJ1Y3Qg
dWRldmljZSAqZGV2KQ0KPiA+ICAgCWlmIChyZXQpDQo+ID4gICAJCWRldl9lcnIoZGV2LCAiY2Fu
J3QgZW5hYmxlIHZkZC1zdXBwbHk6ICVkXG4iLCByZXQpOw0KPiA+DQo+ID4gLQlyZXR1cm4gcmV0
Ow0KPiA+ICsJcmV0ID0gdXNiX29uYm9hcmRfaHViX3Jlc2V0KGRldik7DQo+IA0KPiByZXR1cm4g
dXNiX29uYm9hcmRfaHViX3Jlc2V0KGRldik7DQo8VmVua2F0ZXNoPiBCeSBhZGRpbmcgdGhlICJy
ZXR1cm4gdXNiX29uYm9hcmRfaHViX3Jlc2V0KGRldik7IiB3ZSBtaXNzIHRoZSBjb2RlIHdoaWNo
ICBkb2VzIGkyYyBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZSB3aGljaCBpcyBwYXJ0IG9mIFtQQVRD
SCB2NCA0LzddIHVzYjogb25ib2FyZC1odWI6IEFkZCBpMmMgIGluaXRpYWxpemF0aW9uIGZvciB1
c2I1NzQ0IGh1YiBvZiB0aGUgc2VyaWVzLg0KDQoNClRoYW5rcw0KVmVua2F0ZXNoDQo=
