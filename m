Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA80C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0467283744;
	Tue,  5 Aug 2025 16:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="dr1l/Kid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783F0832EB; Tue,  5 Aug 2025 13:03:14 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C952683189
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCq3iOdthWpF6LWokHP7dpAqNhfPk/kxpz2qKUas3b+mRceK6CTfYHh2b6CXSjLX4puu+DqnQm5BJftbP/TkLA4Cod2/E6GhwJPBzQK2vji9rUod/bb9D24yVm58FMJO4xV4E1VpRtGdx6/P24RhOAjhnjECNuceBiWk3B6cJdJINLhFFDFUPZz9P8yqzs0lkbQP66XIXDcm6mGqvsU9exUNaR3ki6b9YZNEAYj4Y03jmcoQ4MID7/8+C0bTz1YxGNKvwIdNkGwbtL+2V9KcW3Nn4hvNylPs/6mBCPLKpgiWYDDImBQMLmOsS+f4xLoTg3r2MPduvtV9na/pfbyVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv8uvjHufFmnxUDjUGAcqGS4/Wlam4f1RBGIX7743N4=;
 b=LTXOpd+a4CuFE5Cr+Xhz/5h1XkbxoMA+Q6wcaOkFJjoDaUTiD0jZZ7WMiqb2+nq9oDY7IbM0GJoc2vZrz7xOtlMWja2euk6h2uEvVOgqCat/BSwDax3cC0uat5zC8vw0Ke/+UtNq7cLNXJ8OpLf1W93bX4hZTzBw6dvFqajPXww0FgRd6gbqqntzWFgc1FiXwrfYP8GNrLchSqJbJDbduCgcuWajMIzlsSVm1jTIEaAVFduJ5iaPx/1Iw7tOsl92/C8iX8YJtDoLwcMQREbxU1OAZ0aLeRxmkH4wKkANutLiULlMy+fhTy3O5L9lnozED4bc7tbyG0ldX6Ti3zMChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv8uvjHufFmnxUDjUGAcqGS4/Wlam4f1RBGIX7743N4=;
 b=dr1l/Kid8qc6H8Y+0zykcoeF9fULdKcJ9vLPrthCJVUlUllIULMlP98wwSaLHUowPaUGENvndzgkb0rNWGann5ZqwjxGAb9ZL5OKMyttIhTrmnNrdmEJoRSBsvLjVdo7bgrb0J/XlAj/x5Kz8ZdVpn1gW7d5oFNI1xlDmYr7ewafBmMuK3ws6i9rMxrNPm3laRgpJQ6RGn5U4dlEXcp+O9d0GRywasZhcTL0Ehp8Z1JKMnYrLFa73s8E6QYzhZTzWb1WubJxOb0kNrJSon9eJtuCXnnGVtBpACjHpGCe80+QPvQkx1Y7ZBz4vgY+/WL1Xz0m/4pdkf5al7TuXmWQRQ==
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com (2603:10a6:10:291::22)
 by AM8PR06MB7650.eurprd06.prod.outlook.com (2603:10a6:20b:357::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 11:03:05 +0000
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d]) by DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d%6]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 11:03:05 +0000
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: RE: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Topic: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Index: AQHcBe0S3kynZXd3OkScXc3RsybZB7RT4fIAgAADLRA=
Date: Tue, 5 Aug 2025 11:03:05 +0000
Message-ID: <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
In-Reply-To: <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.22.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB7849:EE_|AM8PR06MB7650:EE_
x-ms-office365-filtering-correlation-id: fe662660-3304-4249-c772-08ddd40fa764
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHl4UXNoUndVN3UwN1dJaU9JeHNET1JyNmJjRFM4T0dzK3h5K1pZRTAyNkRY?=
 =?utf-8?B?U0RtNVZWSThVdHZJdVpUb1VrVW95WkxzeHFkY1BhazZ1TnY5SVpseVJOQ05U?=
 =?utf-8?B?Z0ZCU0R3WTFWSEJvVE9ySU1Yd2tpYlhkR09kL3dGUlZ5ZWNEM3pJMnRyL2F2?=
 =?utf-8?B?V2dnMXNZUnltQ1Y2SE4vbDRaSTMyeVRsK0dqRFM2K2oxdE5nMk1TcGQwQkho?=
 =?utf-8?B?VkxrcXArR2IxSFdtWTB2aGxZaUZXYVgzbU5mNFVscFRRZU8wZFJDR25uQ0dG?=
 =?utf-8?B?NzhYQmhhOWgxOHpkUGdWNnEyWDh5YTgyTTNzMUVCN1B0ZVhsZzVoTHgvT0lx?=
 =?utf-8?B?TS9Tb0plQnh6VWhQTDhyemExODJ2N2ptTWVWb1FsWWlPYU1KNW9LenBmT1Qx?=
 =?utf-8?B?SDNwY3ZQNTlXbVhrR2NrMDhLRTNJejVBSTBUaFRSWG45WWRaQXg4N05Scjdp?=
 =?utf-8?B?Y2tlQkRXNklEN3F0TzJ2KzN6enoyZHVPaTlCWkp4TEtIZzBRaHdnM0g3QW1n?=
 =?utf-8?B?TjdQaUREUGt5ZTFWekF1Z1JNRXZubFRpNGR2R1BVMTFMQnJEZWljUkFlazNp?=
 =?utf-8?B?dldnemZMQ3BBZ0hGcDAzZVpVVS9UN3BrK2hUaVFLSUxPZ1NUdTBSNmZEcG41?=
 =?utf-8?B?dTlmLzQ4cHh2NmJ2YzdPQXpWdDVvNXVmRzN5RGt2ZzBVUmdaNk5xVUFadGwv?=
 =?utf-8?B?QzVVdUhsUWl5UmlMbjZNamJ5WUJ1SlZRTklZKzQxSWN0N09FYUs4WENXLzBZ?=
 =?utf-8?B?QmVZc1RiSkNtTDBwRjg0di84Ymo0YkFXTkFtcEgwT3ZIbExtVVB4OUwwQjdF?=
 =?utf-8?B?REdWQjIxSG8zdGFQUWNobW15MFUxc05BQWJuamtzSUV2ck9UNWNsZTVBSktj?=
 =?utf-8?B?ZldXZmY3OFNCaGplUXcrcU5TQVVmWkM1cVhubXk3RWZmUUtUU2UzbkxwUE9N?=
 =?utf-8?B?UjRCK0ZQTUsrN1NuYWFZUHNyU1RlQ2RNV3lIcGhxTHNSME53QTVFcm9zK2Q3?=
 =?utf-8?B?clVkUXR5WnhEdnNlcGE2U3poOFZKNDlQeFE5MHhRMGxmTTB1UlRWNVkzRjNL?=
 =?utf-8?B?QndUMlNiSWtHcGlFVVIyeU8xWXFkazU5ZzEreDB2Z0Q3YWhsVnFTc0laL2Rs?=
 =?utf-8?B?QVYyUEtxY29YWWJQWm9sMWxsdkpwRENjUDJJK1BwREVHZWlmOG9jWHBXbXlq?=
 =?utf-8?B?cnhSeHVLbHQzZDA5azFJLzFhV05WMUV0VEdnbUdkZzY4OElqcUhEbmpEQStT?=
 =?utf-8?B?c1U1QVlRMDZJcW5MZlNDbWdZNjB4MGFEYXdKTEhqQkNqWGxDRjZzaXlHdUZJ?=
 =?utf-8?B?Q1o2RFRKVzhTbXlkYWM1dGVseURMdXZrRjNuRGhXU0NnZnNYZVlEaEJvZTZo?=
 =?utf-8?B?RFRhV2RlZU1PMmRoT09ka0dPUWhaTUdPS3RBckZJZ214ekZzMHc4SGNySUE3?=
 =?utf-8?B?OWQ0QXlyZTN4UTBmbTBXbVlJQWhNV09qY2RaSnpMUlJZcFRPdmQzczBSY3Nz?=
 =?utf-8?B?Ymo5V3JPYVdWRTdDYjZHQVk5MUUwR0JuVi9zSkhEcUNicW1vbnptVzNzdE03?=
 =?utf-8?B?cUJ1UGFDTndjaGN6QXM4bUtFOEg0Tm5qc3hSeFBEbmk5bk1zaWVFTDltN1Vo?=
 =?utf-8?B?ZEZDVnU4c1dRNHMrMHNjQk42N29rWmNKZlJ0SjQreXZoMk9VS3JYRDNmcUJr?=
 =?utf-8?B?YlVvMVg4dTA2d1k0d01GQnFaRlA4bmJTTUZ4TkFxQUUyOXV4cEl3SjlkUXpk?=
 =?utf-8?B?azJDcEMvclJGM0RwZFBiNVJORFQzbmY0RnBsc1dlSEFjcFQzSHFjV0JCMEFn?=
 =?utf-8?B?aWRiRmxaaU5MdkxqL01WZnhmN3BJTlVTL2dRTkRCT0dZZk5yZU9udDdwQStT?=
 =?utf-8?B?MU1jaXlUenJrYmVVVlJWais5REpGdnAwaHpTZmRZNGc0ZzA1a1krVFduL3Zh?=
 =?utf-8?B?b1lMVHRDaUQzSTUwTitRY3VsK0IrcHkrZTZEN0FHWGh0dWMvblV2L0RNL1Nr?=
 =?utf-8?B?aEdRRU1TWkVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7849.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2VBT2lON0lMbm5laG13K09EbTQwakdRTm5LeXcvVTVIYmN2ZXJoQXpjZmtz?=
 =?utf-8?B?WDdaK0lST1R0aGM4NWlWZlJ6WElnS0Z2ZEJxNno2ZGFNYjlHMDhEa1l6Q3Bm?=
 =?utf-8?B?dGpqb05ZWVZlTXdlM0dWc29jNUh3UTV6d0duVWtnSlVXbkxYblhGbmNHRHBW?=
 =?utf-8?B?dzVSZFA4Nkp0cWFiTnZpZExFUk92cGxheW1PY2IrRHAyVzBmVk9LNGxvNTV6?=
 =?utf-8?B?VjZPQlR2OEg0ZVp4NGJwYUtxaStSSTVBN2VZMWpTZklVM3V6ekxzMW8zamNC?=
 =?utf-8?B?RDB3Y2dZaU9hOGZ2TWcxaXNGSXovSk1qSGM0eTc1WTJWTWNRd1dKMnJ2VjlB?=
 =?utf-8?B?SVg5dDFvMXpsdXdhMm9qM2liUE1JNkJXamJZTWNsZGx5alprMFhRMjBYeitq?=
 =?utf-8?B?TldMVWIydWNEZ2Z3azFXWThsZHZGVHJmVjN3UkRWVWR1N1BKLzdlRWd4K1Yy?=
 =?utf-8?B?MFVreEZ5ZCsrZUE0VHhQaGs3ZzNvYkd1VzVEL0gwNmE3UDZNaWFhYTdWWVF4?=
 =?utf-8?B?WnEvYlhpa3VlYU03UjJZMk1vV2pKRExMbUhPQ0ZnYWtiNzRkL2tDcFRWVFcr?=
 =?utf-8?B?R1pPOEJTNG9Rdy9WZUNYQXNnbVBLMlR2YXlZZVc2TmFnaHRvZUswdjgvT09X?=
 =?utf-8?B?bkQ1SCtaeUliNVFBSnhQcE5xdEozcWtKNERsaVp4ZVBocTVzWnpEV1RQejYy?=
 =?utf-8?B?K3Nnc0plV3hITnpNZWI0blhibjl4M0VvYTloajZTeHc4L0NRNnhlTGFIc0lE?=
 =?utf-8?B?Q05WQVZpWUwveElnK0k3SWppNHJHMy8ySkV4bmRldWdzVXNjLzdwVVQ1VHRm?=
 =?utf-8?B?dU5WbWlsdFpqM0RWalk5MWZ5Rms1YS9uaENCUnA1ckV0dUpWd1ZueUFkVjI4?=
 =?utf-8?B?MDhCSlRpMnMzRTR1L3loa3lyN25Rd0psU0U1THRqRDBJNEN4VUdnbVBmKzFm?=
 =?utf-8?B?S0FQOFBzR0pSY3l2dk1VQlM1dk9aTUZsbUJwdUZ4OWdGK29TYlIzZE9GMkpo?=
 =?utf-8?B?Q3JxYnR2M1JhNis3R0JPYTV5MzlqWXNrNjZnTUlGTkhOL0lTdXRHK3l4d2RC?=
 =?utf-8?B?ZG42b1Z6aUxXWWRUU3Btb2c3bC9zWHBMNzNpQWUwbXRTTkNpU2xFQlFmWmtn?=
 =?utf-8?B?dW0xNHRJY1Y5bC9ycFJzTFJPVTV0OUpYWEliL1NVZkh1cm5qVmxsQmp4T2U5?=
 =?utf-8?B?WnBXbms1QUljN2lOR2NzQmdxY0ZzK1FyODRFMXJYY1JwSTBjcmtFTitsMGxy?=
 =?utf-8?B?aVRRUlBpdUZNVmNaSWl3VHkzc1EzN3NjRmdnSHk1VG1DVXFsbUQ4bUY4eDF2?=
 =?utf-8?B?SUI3QlIyNm42eGF6a1BuQjE4QzlqYzBaNzNTa1d1VVZUNEV5ZXBjMUVxMG1z?=
 =?utf-8?B?OXc5SnBxWGs4aHUySUMxeC9NazliMHphQkwwZjg3aGFEQXp4MUxlcFFRbGV6?=
 =?utf-8?B?TjBVK0wxaTZ2YVZZOXl2SjFWZVkzT2ZBTlBKS2hHSlU5MDd5VzFvaVYxTUUv?=
 =?utf-8?B?N2NyV1RwOXB3U3lBblVnMzY0VHNBay9FejIyRGgrOXVnVnltSzd0RmJKaTd4?=
 =?utf-8?B?ME9jUk9kMUR6RGQ3T1FGcUs4VGdJcFdXeGRFNjM3SmtQbUJrUVBkZ0FseXlU?=
 =?utf-8?B?c0xFcmdMc3NibGN5Njg4bXMveFZlWnJLS3RZSWdyS211ZXNuR3B0cnpPREU0?=
 =?utf-8?B?L2RQa1VlNmRpTGVLQ2ZuZDRkUmJNdDA3VGJaUGNaZXRoc3FmTmltOFFCMktu?=
 =?utf-8?B?U01KYjA1dGtxNXJsZDRnUlRXaFNzNzVWWWs0KzFibjA1Z2w2OEwxNjBtOU1s?=
 =?utf-8?B?NTR4VEhYYStkMjVwd0hUeG1xbjcwUjA5L0dVL1ozWnR5WnVwcTdZMlZFQlJl?=
 =?utf-8?B?dlFQYUdDOXJhL2N0V3diNzZnOFZnYXpFczRhZWJtUDNveHBpOVR6R2RGSGh4?=
 =?utf-8?B?eVFqN2pEaEptVVdOR0EvK2tIUmoxcG9EalFldzM4TFgxa2Z0eGRjaXRoR3Jn?=
 =?utf-8?B?N3pKRHU0Q3ArNkh6OG9Ydkg3Y3B0L1hPeUozb09KeWpBUVJWcVAxVFprTnVF?=
 =?utf-8?B?dXllZEh2MitDc0ZVZmwrS0tERWYxNHhnQ3ozQTJoMFBDS1RFSUJwRUlvVFk3?=
 =?utf-8?B?b1ZwMkdFT1VlUjlpc2JjWVNoKzBoVzloVE5LRFRZU3hIdVlJZmdUWXQ2M0JX?=
 =?utf-8?Q?y428wl4gp87Ua9ZUtaJs9Gk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7849.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe662660-3304-4249-c772-08ddd40fa764
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 11:03:05.4045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrtwEDpZEIECN96HkNSWsyaAP2WzOmYhUZPz8RjfOevLys6Vs4J3GGqFT2Fw06m6OpIoR674Mc9+znVmDhQxJyl64eXHo8JMtopvmf0lB3e3xmOxm8jaeNZWiXYPgrwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7650
X-Mailman-Approved-At: Tue, 05 Aug 2025 16:22:00 +0200
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

PiBEbyB5b3Uga25vdyB3aGF0IHdvdWxkIGJlIHRoZSBzaXplIG9mIG1lbW9yeSB0aGF0IHRoZSBr
ZXJuZWwgd291bGQgYmUgb2NjdXB5aW5nPw0KDQpObywgd2UgZG9uJ3QuDQoNClRoaXMgY29kZSBp
cyBjb21tb24gdG8gbWFueSBvZiBvdXIgYXJjaGl0ZWN0dXJlcyBhbmQgYm9hcmRzLCBhbmQgdGhl
IHJvb3QgZmlsZXN5c3RlbSBzaXplIGRlcGVuZHMgb24gYSBsb3Qgb2YgdmFyaWFibGVzLg0KVGhl
IGlkZWEgYmVoaW5kIHRoZSBtZWNoYW5pc20gaXMgdG8gYXNzaWduIGFzIG11Y2ggbWVtb3J5IGFz
IHBvc3NpYmxlIGFmdGVyIHRoZSBzcGFjZSBmb3IgdGhlIHJvb3RmcyBpcyBhc3NpZ25lZC4NCklu
IG90aGVyIHdvcmRzLCBpdCBjYWxjdWxhdGVzIHRoZSBhZGRyZXNzIG9mIHdoZXJlIHRvIGxvYWQg
dGhlIHJvb3RmcyBkZXBlbmRpbmcgb24gaXRzIHNpemUgYW5kIHRoZW4gY2FsY3VsYXRlcyBob3cg
bXVjaCByYW0gaXMgbGVmdCBvdmVyIGZvciB0aGUga2VybmVsLg0KDQpUb21hcyBBbHZhcmV6IFZh
bm9saQ0K
