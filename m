Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A182CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5795F80398;
	Tue, 12 May 2026 11:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="LOGelfCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F761801A9; Tue, 12 May 2026 11:01:27 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3686801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntMuEnCZe2yt+rFO2soflG8lfSWCxX0RfkQWYrRASGhR1RQIBrH9W4h518VkDJYn5Lj4FVeOO2XqGSZXiljVyug1vbQ+/XAdpd5ie/6IAmd+eCwwHjXtAozo8D0aM6B5/et3503UK/lwt7oO+NckvSn5ELSzvluHqTspgEAbhTihZxnQg2kge4J4hXthZIscLCFy4/maoDmPAUX1AdQwFKuJskIWosRlqqFPqBmjx/7roz8+uY5fdon8t/M4MehSVDenAboBh+mbTs4NMfLvaxb84Vt+zCO/tBrcW1i6GIij0xSFW9zJAWe+/J6nPSLZanb0gCWsxf3ZkQEhMezmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zB4TxF+0PS0ixFaTev+hDSkObnCqdyktj+onTM0HWM=;
 b=Cy9Ck5dDxz1YF7wVfIAnErLwXul4MwRhB+qC/MEpnc7o5vuEsnJvTF1Vs3O4DAcdO4qaxYDDFzEbDvN6cbfJ6+8BU/PFEH0SAiXCJ+DjITa5VrmDzbjyNZbHclnNj4kpvtIXZfZOLcopztUT+3yBs9iFIjoyVRorrjYIXTAsM5s7dV+jt9A7Z23fZGh6dO8avWUJjci9qnUhxr8a56622bkDEeEdDBNMAQXV+tRUcnHU/TTAYRiXlX8UM+wSaXfq+nF9ZQV1MwaJ92eCLxZxka4l/SJTQ5GubTpHB+VexvE2nWYlGeTph6hjXNtvZzehwGCBzvSDc9s8bOVP+7An1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zB4TxF+0PS0ixFaTev+hDSkObnCqdyktj+onTM0HWM=;
 b=LOGelfCzeYdKYW/L5P7W0WwN7DJwPaLA6yqfjY+6Be+6eEnkILDwhlqyCuDYgfku1CzgE6pnE4/jAE5AaWg2ahaSukVeYrzxneUHEzQWKsYjy/YmuuH6UU10QPrlTbqAnOmUeKMjDqp7xBRlbwfeJvZ8cZQraHZzGkylcQtv25GeTFM09GeYQjk62VYMtDuoV6ByYDCC6Gp64VvQGej6g6AJTT+SpCdHYYbUj14cguXow+FUEQKX8m1atg3ZuLP41oFJJQZq2+8pwhhfc0dGf59L1MbLxzHTcox1PvjRm4X163uhDGyw0LrDoCAUQvmPtjMfjeJbbaP5P1Ebcal/1w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB4PR10MB6967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:01:22 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:01:21 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "anshuld@ti.com" <anshuld@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/4] Pass reset reason to Linux via FDT
Thread-Topic: [PATCH 0/4] Pass reset reason to Linux via FDT
Thread-Index: AQHc4YKbPhcIXwE7QUeT2wyGKQDc9bYJ5EuAgAA0fAA=
Date: Tue, 12 May 2026 09:01:21 +0000
Message-ID: <28a1a10bf189b97b5818da030595823e7931e334.camel@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
 <177856520962.106112.6840715298573844869.b4-review@b4>
In-Reply-To: <177856520962.106112.6840715298573844869.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB4PR10MB6967:EE_
x-ms-office365-filtering-correlation-id: 0e865e42-935b-42f7-44ba-08deb005098b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|11063799003|55112099003|38070700021|56012099003;
x-microsoft-antispam-message-info: LzbvOLrdaIND2JJ+VB3FFdKaTkRrwo3c28U35l6sHMAq5K2KJBYVYg9rA/urgyJg3tI0ATkNTTAQkX+shrREpbqSzDyqzEkiYyzo1utpU9RLdOgo11Bm4xXkemOfkQHQQ+ZwAfHstqxv4Vws/sKh7oIuiy0Am4JgjddMHw7aWOogd5MwAO0hT4y0ObvjRgZnqGpSCUSxXU5zuJhsz9LQhmWB7Zd76yl13oyJaLAZWXHQjT9HU6opCRrqAriMMaOgL6E9KEYqrQA0sC+q2ha8pBWV6IvFUJlyLfMYzu9AA8WE4t9s2zCLqobmPPBB8Mn2QDWLhwX2ZTulPEituUmzaSUkpjtEj6D8MY+mqe4qKdpJybQNxJihSkJ6fESwYhtDJr6fjKUxplz8ln9UPntWRmYHP3RWX0LEw+TZZ1rD9dL3VKHIgwZT20pMW8C9NNb11Hc4gKCbVlzoCsQvslSY8ab58McX/uO4lndK3DgII1DaQTSCRA+LhbFUmSKMl14rpEH/fCz2FiwpB86rr76scJcqbEE/9PlD1ijaKtAZNpfEjZQUh21xqClge4ucuwYHl9I6u7uTNN/pKSQQg/f89MqfhgNWO+H5XpXysEGrbSeSos8SL3ql/a08ORS04XUzWoeN98XhJdmTBqCin/RCADgC3a5trxEUY/jQ9VivWdWIxu5HrBv3EWxX15KlXF5LA4t6dmVPGf0fwid7w6REkA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799003)(55112099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkhFSURPL1cyNmRucWF4N3lmbVAyWVBLaDZxZHMxNkhzbHVxSFFZUUdldjZU?=
 =?utf-8?B?SFprOHVrK3dzcDN3dzE1ZDlaUzVZNEZsSU5taFE3aVhrOXJjWTY2cXN6dEFt?=
 =?utf-8?B?NjlPS0xiSEZOYXJ1bE5Pby91bVBlOTdtN1BlVS9OVXRXUThXOGdkU3JpMm1T?=
 =?utf-8?B?ZmhyaE8rQzRTeXE3RmlkenI2NCtKUlExZWJ3Vjc1bWhIcGxyMlVPMUpRTUwv?=
 =?utf-8?B?K2RqeXV0Nzd5RXpaS25DWERzTExXNTdPSnJJNmwwYUV6UDFMQVBnM1B6Y1l2?=
 =?utf-8?B?ODNaeE40TzFFREw3WEYxRThjZndmbVFzcENQVWVDNGpPV1BwdWxIdmVXR0d6?=
 =?utf-8?B?KzlxelFaT2x2K2RaUHYxbUw3aDNSMUp5TlpqZ2VpMUVIWnJPaXZObkpzb0JM?=
 =?utf-8?B?OHJXTjVna3JCR3l4RHZUeWhMeHpjN01mZXZ5L1YyaVZHazhlYVRkOGl1Qmkx?=
 =?utf-8?B?bTlwUmRXRGdIRkJzdE11QVhZeDNDc3JPV2tjYkZxL3YvdG90Njc4dGhEanZU?=
 =?utf-8?B?cXZrdFR1MG9OUHNiWUtscEt5SG82QXovMWJRZEwrVEUzS1Nva1A1ci9hQ3ZC?=
 =?utf-8?B?alBoSjM5OXZZSDNiK0ZmRExURU9NcWpRVjhFaEltVnEvSWRXc1RCckF3Q3dv?=
 =?utf-8?B?NXQwanNvMUdRcjZqemFxOFdtMmIzSGF0a1pUdVNqRFdIMDIrdHp3UWN5NDho?=
 =?utf-8?B?UTU0Y3FqR0tlbDhyTUJHUDNYdUoyRUpRREcvaVhjYTJrWFA2TEN6dTRqbndJ?=
 =?utf-8?B?b1ptWVBvYjJZZEJPd2NHdEU3M0tIMWZjUHE5QTRWTGRWWmw0UW4zWlpxZS9X?=
 =?utf-8?B?RVAxZ3BPenZWelpSbVpXZ2xYSEhxdFBZdENtODNBZExtR2t6RGEvcTMwRkZ1?=
 =?utf-8?B?dk1HOWdLbEVmcXY2RXlNd2FmUXpHSGRmYWVMSE1STy9qWlNHR2VvalBvTGJH?=
 =?utf-8?B?SGU3OXIvQjhCLzhjaWZCM293dmc1dUd5NlFlVURBS3lTRWVaMUhPZlRRVURw?=
 =?utf-8?B?T2lGTk45OGxXSlh4L0llN0hoOG84STRKSWtwNEE2b0taZ0ZpWk85UTVDRnho?=
 =?utf-8?B?V09pMnVSeStoemEwbFFQTVJPZTB0NjE5ZTYyanlaK0RVaDI0VXZLZmpOTFd6?=
 =?utf-8?B?dWRxQUFmckFBUW9KWTMzT0JVWlIvZnZsQXJBeFZ5VkJ5WWhXb0ErZTVsRmNz?=
 =?utf-8?B?MjlEaEU2QkhyT1pQcDdkNlF0UkZGeTZKZENjcXgzUXpBSEVNSWp4NVlJZks3?=
 =?utf-8?B?OU5haXlndDdVRFVuRUorMWlWOEs5Zy9EQkpveU13YmtVdXE3b1ZoY2lTc0Q5?=
 =?utf-8?B?ZGJxclNhYVc5dnZKY0JwdUFiNTZsRXJ0blF4T1o5SGZSWkJEOTNMdnh6Rjdh?=
 =?utf-8?B?YmNiTmpaMGd4dldlUXUzTGJSUi9GVFN3QXYxVVd6YzRIbjJDRWltZ1o5a2VU?=
 =?utf-8?B?c3Q4SUUveVRjbmRIWVVjTnBabXBZTzQzcEdWNVNrSEUvSXJXRUpvMG5OQ3lj?=
 =?utf-8?B?R1Z5ZC9NWHRpQnVVZC9ocysxVDdQU05CYUJ2UllnRS9aUnB3ODJCSlNlaHhh?=
 =?utf-8?B?Wnh1NVJxbENvMEhHL2pXWWVROGYzWUUyemRHSkJ0a2g1cVBUYnptMmtSM1JM?=
 =?utf-8?B?am53K3NZQlMvdnFCSzluQ2lIY0tIaENleURlTXgzT283MVh0VWxQUzYxQjdr?=
 =?utf-8?B?dUtWb2RCT0xNRFI3MGNITlpOT2hqM2VkNVRXZFBuT0tGOGF5b1BPT2lMVnU4?=
 =?utf-8?B?ZXhSMU5UcDlkQ0dPaWpyWDVmaWFUWnhVTnBRSUlJa00zekVTeWN3VFZ0Wjdp?=
 =?utf-8?B?RHB0ejRjWGRZckNYSXhSNFk5TEVCakhENFFoR3dpMHc3R01Id0FiREI3aTNW?=
 =?utf-8?B?YlFQbFlOVjU3bzFtWm5FOStVYUZiSDFiY0Q2M3VhUklRTVpqMkgrcittWGwr?=
 =?utf-8?B?TUtMYnBRd204QzZ6UjNsMXN0bGFmeW41S3ViQ21TV1hOakk5NVNJN21aWjQ0?=
 =?utf-8?B?bWF3UmJtN1NnUm85YVQ5V0FhWklSbEpuY09xNG5GTFA2aGUydHl1aW04K0N3?=
 =?utf-8?B?L0NXTzZWTjJEdnp2VE51a1B3Mkc2NERFYjlJWDVRRThwbEVDQUFTSnFmanRh?=
 =?utf-8?B?a2d1bW1vSDNJOEpNNkFGV3JNZmg0dGEzQThjMnYyMUxMRDRzRk94Tld6d29Y?=
 =?utf-8?B?c3JpOEtyYjliQ2xuNkY2V0dsem1uNWxxMjlhOUllbkpkVUJlRUN6eG1IT0Mv?=
 =?utf-8?B?MzB4eVpWV21MbjJYUDE1cGpWK2NIcHZUNXA4QTB0dzh2Y2FXVFBZWURTdUVW?=
 =?utf-8?B?RytGcEhiM2FNdmpYOU92K3A3MGszUGxNcmxmQjlNTnRKNTJ5K3NBQk9jMzJK?=
 =?utf-8?Q?uXZwrBhFckoBE6M0ru9EJNX6Tm9sXMx61vqcz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74E3DD14C671E84AAF1B8FDA37BA7E8E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e865e42-935b-42f7-44ba-08deb005098b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:01:21.3931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RNnFt2gopmsu2qEl8Zi42AER0V9JmnwiRQ2ihRf0o7PG8thGAJ4Dh4EZ4uVbPcLtWE5bOFvULCpx7v9fJRApYCcye7kWdR7ZmMw4g2djKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6967
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

SGkgQW5zaHVsIQ0KDQpPbiBUdWUsIDIwMjYtMDUtMTIgYXQgMTE6MjMgKzA1MzAsIEFuc2h1bCBE
YWxhbCB3cm90ZToNCj4gT24gTW9uLCAxMSBNYXkgMjAyNiAyMjoxMjoyOSArMDIwMCwgQS4gU3Zl
cmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4gd3JvdGU6DQo+ID4gRnJvbTog
QWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+ID4g
DQo+ID4gTWFrZSBnZXRfcmVzZXRfcmVhc29uKCkgYXZhaWxhYmxlIG9uIFRJIEszIEFNNjJ4IGFu
ZCBBTTY0eCBTb0NzIGEgbW9kZWwNCj4gPiBmb3IgZnVydGhlciBTb0MvcGxhdGZvcm0tc3BlY2lm
aWMgaW1wbGVtZW50YXRpb25zLg0KPiA+IA0KPiA+IEludHJvZHVjZSBuZXcgQ09ORklHX1JFU0VU
X1JFQVNPTl9GRFQgb3B0aW9uIGFuZCBvcHRpb25hbGx5IHBvcHVsYXRlIHJlc2V0DQo+ID4gcmVh
c29uIGluIEZEVCBwYXNzZWQgdG8gTGludXggdW5kZXIgL2Nob3Nlbi9yZXNldC1yZWFzb24gd2l0
aCBhIHN0cmluZw0KPiA+IHJldHVybmVkIGJ5IGdldF9yZXNldF9yZWFzb24oKS4NCj4gDQo+IEhh
cyB0aGlzIGJlZW4gYWxpZ25lZCBvbiB3aXRoIGxpbnV4LWR0IGZvbGtzPyBJdCBtaWdodCBiZSBi
ZXR0ZXIgdG8gcHJvcG9zZSBhDQo+IERUIGJpbmRpbmcgdG8gbG9jayBpbiBhIHNwZWNpZmljYXRp
b24gdGhhdCBVLUJvb3QgYW5kIG90aGVyIGJvb3Rsb2FkZXJzIGNhbg0KPiBjb25mb3JtIHRvLg0K
DQpHb29kIHBvaW50ISBMZXQncyBkaXNjdXNzIHRoaXM6DQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvNTc5ZmNiYzE4NmFkMmFlZWEzYzIwNmFlYmM5MDFiNjRmYzY2NWRiMS5jYW1lbEBzaWVt
ZW5zLmNvbS8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVt
ZW5zLmNvbQ0K
