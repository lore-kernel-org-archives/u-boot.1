Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5771C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 07:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0789B80F4C;
	Mon, 17 Mar 2025 08:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XJJGysV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7248B80F70; Mon, 17 Mar 2025 08:29:17 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F84480107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 08:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PA3p2G9Ugui2ktYEU4spYAP5jP2HJ492fv1jf+7ltdknbUuEK9Y0AqTKTYQ3TKSX5OvYZ4Cz5AGEyyamfN8tyiYED0gfEUJPN6nZlhNfgFPvGslPCXmwHFc62+CIP/nPT0LgXGZbehXvdODDGBki3FYGeQ+iad3BJeagUt6G3Xu51mzcSwIcIRrKay3+v6p1aET4RiAEMphmN5k06/zUsXCX7SRMJOjQrfdpf1GLPL7DeKP8B2/X/zhmYxNZMs/sRAWj4wzg7GL5R3IXmDkJUZtj6TJraxuhoTUuF02LYUML52HLkXccsfUWjJxW6+NoOfZaDWgXeQqjr772piD1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/oHXZiL7ViBWbjSD+9kFh0rBC9Qw0R5Y3S20dvKrGc=;
 b=r3xg5uGVOeRZWbrqrhlmeXD5Ol2xnUlVAWDBflhiU4KBasAI9IJd2jMzMEKM449CLklrXcqOiTzL63YXzUIw/3ZMKF0wgj3+uLnze2fb6U17nYsp7HGn+mBG6bFTL8vMx5myU95EqN5ST/07EYX+1tztdDNg7iHJnOBDMD3cdgBFTg8Bipki9eCRzlZ5uJFy9lODD9RNnlVanD8Wl4KzqKtAHXtH63tTWRl1A3EanlGCexi4jS7Hk+jy9yxPOPSdzbVueTAUyRyzpm/TODToIPdEaKryGpZKRMuEl1veL4gBKxD82NQJuZpPIyK0JSzpG3tdFEbNOHUb+YJ5UJ+aFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/oHXZiL7ViBWbjSD+9kFh0rBC9Qw0R5Y3S20dvKrGc=;
 b=XJJGysV4o852DSMblAl41yB9a3m9dX04Cdm9e66tFeEp7ZrxbR0pxVUjmUwNZHZsUxwm+zdnbte8CIuJqFUhKnwamAe3e3N0538GC1GY8Kmr9ewV+K8DdoR6QT5MrfIqHWXfFN5juRCUwxxwvdjfuIYoo0jSdxcq8m8aEuaNgTuy8ZPl/O6eMYw/0GKVKK05SCkAR4m6sB6PNKVLY10SaRjf5H518aEr16fCkimpLQzcYnZP6sc6OWJuaF+oGbFFR+CxYitJs/iK/GAv1Q1DE0fZ8Bu0Vii1UnHj5RJ6qS4LB8u2aa+OPRCeKBWt8OaLn7zteJTQwYuAJoAnzcEqUA==
Received: from VI1P195MB0269.EURP195.PROD.OUTLOOK.COM (2603:10a6:802:64::26)
 by DBAP195MB1116.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:29:12 +0000
Received: from VI1P195MB0269.EURP195.PROD.OUTLOOK.COM
 ([fe80::4cdc:e2dc:7385:1d93]) by VI1P195MB0269.EURP195.PROD.OUTLOOK.COM
 ([fe80::4cdc:e2dc:7385:1d93%5]) with mapi id 15.20.8511.031; Mon, 17 Mar 2025
 07:29:12 +0000
From: Teresa Remmet <T.Remmet@phytec.de>
To: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] phycore_imx8mp: Rework some of the RAM related Kconfig
 symbols
Thread-Topic: [PATCH] phycore_imx8mp: Rework some of the RAM related Kconfig
 symbols
Thread-Index: AQHblUmu3G+J04Zh3Emqmh53KMyQZbN28fqA
Date: Mon, 17 Mar 2025 07:29:12 +0000
Message-ID: <03559683db3004621f7b68f0f89c64a4e0719fba.camel@phytec.de>
References: <20250315012916.399442-1-trini@konsulko.com>
In-Reply-To: <20250315012916.399442-1-trini@konsulko.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P195MB0269:EE_|DBAP195MB1116:EE_
x-ms-office365-filtering-correlation-id: cc98aee2-a7c4-450d-0e5b-08dd65256a3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkVnVnloV3N0ck9INGRock1UeUprQ2FpQkdUd3B0VTlOVDNoRE5YNTRzaUw3?=
 =?utf-8?B?RnNiT3NxN000Wk5tTStPTitSMSs2QXU5VHdRZEgyVXhXSzZyK0NnVldrNEJ2?=
 =?utf-8?B?eDNRbVRHRnpJQU9YeXF2aGJETUI0WTluQkY3ZnkrU3NKZjhENDFZMU0wZjRq?=
 =?utf-8?B?R1hBNGxPQkI4ZTNBbjA3bDUvRWp2ZDdMWlEyZHhMOEpKZ01YWjRpRjVHbng0?=
 =?utf-8?B?NjVhV1B1ZmxwcmxkMGhDN0RvdUFOK2RDeE1Xa3JNNHBvUjg5cWpJSUFNcUVk?=
 =?utf-8?B?aUlTTUc0STJkeU5FRXp4RVIwYTlOd0NybG45ZWo0bXh0dG9BLzNlbzBjWVNs?=
 =?utf-8?B?L003SDNja29neGRCaFI0TUlhRmdCaGhFSUd2STFiOWsvMThUQXBrSkpBU2dT?=
 =?utf-8?B?Tk1iL1ZLZVUreGs2UUswa3Y1cy9hdExGbFdLd0FQV1VGdEl1ekNFWFIxbEx6?=
 =?utf-8?B?cWlWbUZ4T3Y5V0Fpb3paNjJCcEJOZURYZUZiUU11UUIwZURXaVhaNFlLT3FB?=
 =?utf-8?B?bFNjMDB6aEI1TTBkMEYzVzI1WG1HUEhRbEdZTm5MWmNKMnJaYW0rL1hUa0tX?=
 =?utf-8?B?MlZFWnpUaFk4a2hUQlNYMmxDc2dxT2VGSldRV2t5MHJuNXhhVm5WNCtNWnY2?=
 =?utf-8?B?dlVCUUVwWkpMVGYwL0pJU3k0cGZIQjZxeDFhby9RQU5EWWJUb0VhRFI5YWRV?=
 =?utf-8?B?dDhLYWNnR0FjUGtROWdBenRaK2pieldUaXVIY0hHN0NxbThHK2ZSbUlFMWl5?=
 =?utf-8?B?UHRzOExPbVVVdCtUcjZ4enQzVXNvaFJBUUpBRlJKSEx6RXZNaG5mRVgyOWha?=
 =?utf-8?B?MXNKcHRZRWNKWjR4TGpSOElHUzk0M0U3VjZaenJJSUpPUXhyOTM4TzFGMUM2?=
 =?utf-8?B?bFpqRTdmaWVQWWFPRGU2QzJEVGtoVi9BckNQNUdlWWZLVHJHTHlOa0FEdGc5?=
 =?utf-8?B?ZjQ3NlZNQ2xZNzVudmxUWWtzMDlpbFNOeDl5NlpxblRiWE1HMnZGSVpwS3Zi?=
 =?utf-8?B?ZUg5M08xRk1IS2hqb0FiK0s4aXpYNFJGS3NJak1YNkxxbG9zSmxWbnpOOC9S?=
 =?utf-8?B?Z0VWVVJJenlXaGpFTUwxbUsyR2ROdHIzaTZFTXdpb0ZqOWN3V0w4MVI0YTRY?=
 =?utf-8?B?c0pZcmNuVW9yaGtSMFN0dXlwb0NWSWJLY2NBWmgwUmtGVUowNy9PZTFUanh1?=
 =?utf-8?B?WWx1Ui8xTE5BTWI1ZGpCbXU0UjIrSkZSTVQ2UldiSW50QmkycE9KVW91UlRF?=
 =?utf-8?B?RnBES2h1bGNwL21CeVRKM0FrVGNwUjNDMDdEdkdsSmJxQWhIUG1WWVBqcWg1?=
 =?utf-8?B?Q0V5bWVNaTVqV3RjeUtjU3F3cVgwcENLOE5rTWVReURYcjlBeGVWcnJGZ0VK?=
 =?utf-8?B?R09ZMU11TDgrTlpSU2NsdVF1UnJmUDdHQUluT0tVQWQyUyt4dC9jb0w3dDYw?=
 =?utf-8?B?dUhhRXJyTnRSc1hrMVlIQzUvTFJXZlIxNzRtaC8yT2ljMngvL2JSbnVvU2hI?=
 =?utf-8?B?eVVtVExmU2VrZGNXL3luTnd4NUhHTVpQQ21WcUl6VURrZmNMSUM1bWRGMDJq?=
 =?utf-8?B?cit3bkxBOFJld2xEUnJPY1V1eHI1N0czYlo5L05aOGhWakxuWVJMdnFvYWgx?=
 =?utf-8?B?dHJEeW1WMmFqeFlSTGwzbTB4V3g1N1lRZTRMSGtvZkV3cjgvam1uWnVqWEZY?=
 =?utf-8?B?MTFpMXVWeHZpdlA4QlJUUlZoVjArNmNuWlpZbGpHSzhicXZjeHI4M2xtQ0ZD?=
 =?utf-8?B?YU9jQnhZUFUzay91aWg1a0FUZXRobC9HcUlybTNGRDV2QnNlOFVjcU5WYTBw?=
 =?utf-8?B?eEt5NkxyOTdObDQ2SWRjZmxiL2h1cHNaczBiK2J6aE9lcVpDZldGTXdxQmoz?=
 =?utf-8?B?ajdFaUQ5SzZQQ2VuYzFxaUxYNGRMMmhYbzZTS05YN0ZMNWhFblV5VFgvSys0?=
 =?utf-8?Q?8ZUl7HaGK2MLi7ZxtoY45PydpbsXxYyH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1P195MB0269.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3JnYWQ1WDc5WDRodjU2YVZrcUNTYmkyeXVBWXg3UW9LUjBaR2R5WWkwcGZi?=
 =?utf-8?B?NWMzVHl0Vy9UTElkZkpPQTFXZVZhM3ZibDYxUWt2T1B3bDRGaTlGQkNSSVVG?=
 =?utf-8?B?S1BNZmFUaU56dEgyZnQzZWxPWWZlV3Vnblp2OXI4MVlxdHBNREhNWmg1bTdB?=
 =?utf-8?B?MXdSTkE3djJGZWRxVDZXVGlZWGVvMFhNU29FMlF5SGp6V244a2h6aG5meklU?=
 =?utf-8?B?bnlMOWxTWk4yZkdOcG9DZU5BOFliVmpMZFlRMmYzU0pKNnd3aUdmekgwU2g3?=
 =?utf-8?B?SklDK3VyZGI5Mm04anRzOFdhTEJNM1lYbEh3cGpEL2psbEc3YnlOdzk4K0Nn?=
 =?utf-8?B?ek9GQ2VWNVJHWXNTMllWcUp6YVVtUEpEVHpqbFI5NWVINjkxcWR3REw0VGNz?=
 =?utf-8?B?dmZlSSt2cy84Z1VhQnB4eklWOGFZeDczNUl6ZHIzd0EwblYyb0xDblZucXFZ?=
 =?utf-8?B?d21BNk5xMnZrc3ZQWmhtNjJFVTIwSUZ0MVk3TTA4Qml5NUtDUW85Q2FJa3lk?=
 =?utf-8?B?Zlk3UDBRdVJnV25VV1QvNTFCcURkWkhqUGZQdHlOVTRyaDVNTEM1aXJQTjZt?=
 =?utf-8?B?WHdMQUtQUjI2YTNkdjVQb1dmeU5xNUppNWIrNXJ1V1ZwS2wzUzJybmFKQnM0?=
 =?utf-8?B?cWZYSTRFczRENXppdllCeUNvWnFpUFFIMXQyYTU4TzY0ejltTG5OTjI1c3Z2?=
 =?utf-8?B?Z1ZmN0JtdTc3K1VwWjRpMExHRm1KUEdvTzVkSHBzSm11aCtRQVV4NGdyRy9Q?=
 =?utf-8?B?MVpjOUF2T2RNanZacTJKTVNiSlpCWEIveDFlaEV6V0JrQjJ6S3VDVmcwMk12?=
 =?utf-8?B?akFHYi90WlNmenhJaVhSVmFGUXY1cFR2RWZHWHpuZTY0OWtWM0ppK2RuQWxz?=
 =?utf-8?B?ekh5QXRDcjh5Y0tkMTFpSiszWUJUamVsM2JwdWtRRVVwajlKMXBvdFpIM3k4?=
 =?utf-8?B?aG0wRHhuWUlMdWsvYWRVd0pNdS9FdTZIK01lODZldnNjWEN6eWg1NGdVaVYw?=
 =?utf-8?B?djZwMmF0V2RjUWR6Vi9wS05OWFZ2N05sWE1BOWtxZnBGTmJndmJva0xDYnBx?=
 =?utf-8?B?R3pQeDBEZnRQS29vTTNGbmFkc2tQb0xaUWRmUG5Fb2pINWYyZzJlcjRUYlRt?=
 =?utf-8?B?d3kwaEQ0b3dOdHpDY1c4WXpaTXQvQUtUZnRoaDBoR3dWT09zRjV6ZndiVlRZ?=
 =?utf-8?B?aWRyZTc5K3JJbVlIS2dlTVYyOFBpMk9uNCtuOHYrV1BlV3dmV1RXeTF6cEpj?=
 =?utf-8?B?ZDUzbFgyRUQza094VHRidnRESGpLWHFCdmhtcHVmNnRDSTNRd3hLN2JsSlpY?=
 =?utf-8?B?VHhqdGsxZVZ4eGsxUllCTEtOVm9oQ2JQVFhSQWliR25DZjZJeW1ENWhmbjBh?=
 =?utf-8?B?L0UxOW01L3laTmJNVTUxQzZJcGVVQWl1UTFUVG1jMkRGWFlQTHIyZTh5R3JV?=
 =?utf-8?B?WGFJdnhvZ3pkUjMxN0pRdk1RejRMUFF2WXE0T3RWMWxsSW1TS1VMenZPRjYr?=
 =?utf-8?B?WXk5TjRPTGhNT3NiK0I4OGs5ZmhUUWsrWG9QOXVKQndWbFJKeFhPUjhBbjJ1?=
 =?utf-8?B?Q0c3UGYzM0hKdDgybGR2K1JhNnN1U1RmbTR4V0dlczh6U1hvV1JMUktUdHFW?=
 =?utf-8?B?WlhFYXJ5cUNRa0ZtbDFiZDZ1a21rcmQvRjhnRG5rMW5SOEc0SkVwc05sS3lS?=
 =?utf-8?B?a1JleVFLNTNYaFJBenhqRVBKaC9BSlV4WGJiNzRUVWFYbDFVL0pEckw5eHJQ?=
 =?utf-8?B?QnoydkZwTm9xckZzZWZtenFkcUtFWENkOTg0QnZmbjl1TWVkS2VpYzBUaFpG?=
 =?utf-8?B?a2Q1NFA3S1puOUUwbmsyK2ZkdSs2ZURRY0oxZXlCU2xiWVdoVGpQZDFLSkxt?=
 =?utf-8?B?RzlNbmgvN2hUNGowTGxBV08xcGZSa3hRWVB6Rm92L0xIUC9Id1BiVzJ1ZTFz?=
 =?utf-8?B?blZVNndyT3UxUjNiYzE5T2ZycGNncmsyYmFxd01tcTFoaldXMTd0azJ3UDlP?=
 =?utf-8?B?SG1BQVBseUNkcWhrUnphaVEvaW4vSjdneDFlbWZrTWZVTzc2UEVxTGVZN2VU?=
 =?utf-8?B?NHkzMjVmOHJHUXdGdnhoalhuZ1dlUkdidXhWNlY0dHJuR0xqUjZhblhIMS94?=
 =?utf-8?Q?fCmlSWOhQLwBwF+yVT8TTLgpI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D48D70FB1AEAD4EA1D7EE5C92210BEF@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P195MB0269.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc98aee2-a7c4-450d-0e5b-08dd65256a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 07:29:12.6559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFZ+9hovedP3mZSPMHPcFeZzCjUhndE8K1cPadBdO4w9NjmPQqWDuDzAiFdKz1HlOLrLxYf8Ybp1dG0a6R8Yjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1116
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

QW0gRnJlaXRhZywgZGVtIDE0LjAzLjIwMjUgdW0gMTk6MjkgLTA2MDAgc2NocmllYiBUb20gUmlu
aToNCj4gQXMgdGhlIGNvZGUgaXMgdG9kYXksIHdlIGdldCBhIHdhcm5pbmcgYWJvdXQgInNlbGVj
dCIgc3RhdGVtZW50cyBvbg0KPiAiY2hvaWNlIiBvcHRpb25zIG5vdCBkb2luZyBhbnl0aGluZy4g
SW4gdGhpcyBjYXNlIHdlIGNhbiBlYXNpbHkgZml4DQo+IHRoaXMNCj4gYnkgZHJvcHBpbmcgdGhl
IHNlbGVjdCBsaW5lIGFzIHRoZSBmb2xsb3dpbmcgY2hvaWNlIHN0YXRlbWVudCBoYW5kbGVzDQo+
IHRoaW5ncyBjb3JyZWN0bHkuIFdlIGFsc28gZHJvcCB0aGUgImRlZmF1bHQgZmFsc2UiIGxpbmUg
YXMgZmFsc2UgLyBuDQo+IGlzDQo+IHRoZSBkZWZhdWx0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFRlcmVzYSBSZW1t
ZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4NCg0KPiAtLS0NCj4gQ2M6IFRlcmVzYSBSZW1tZXQgPHQu
cmVtbWV0QHBoeXRlYy5kZT4NCj4gLS0tDQo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1w
L0tjb25maWcgfCAyIC0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL0tjb25maWcNCj4gYi9i
b2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvS2NvbmZpZw0KPiBpbmRleCBiZGY5ZTk3YmVhYTYu
LmNhZjljYjBjM2MzOSAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1w
L0tjb25maWcNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL0tjb25maWcNCj4g
QEAgLTQ1LDcgKzQ1LDYgQEAgY29uZmlnIFBIWUNPUkVfSU1YOE1QX1JBTV9TSVpFXzRHQg0KPiDC
oA0KPiDCoGNvbmZpZyBQSFlDT1JFX0lNWDhNUF9SQU1fU0laRV84R0INCj4gwqDCoMKgwqDCoMKg
wqDCoGJvb2wgIjhHQiBSQU0iDQo+IC3CoMKgwqDCoMKgwqDCoHNlbGVjdCBQSFlDT1JFX0lNWDhN
UF9VU0VfMkdIWl9SQU1fVElNSU5HUw0KPiDCoMKgwqDCoMKgwqDCoMKgaGVscA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqAgU2V0IFJBTSBzaXplIGZpeCB0byA4R0IgZm9yIHBoeUNPUkUtaS5NWDhNUC4N
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgIE9ubHkgMkdIeiBSQU1zIGFyZSBzdXBwb3J0ZWQuDQo+IEBA
IC01NCw3ICs1Myw2IEBAIGVuZGNob2ljZQ0KPiDCoA0KPiDCoGNvbmZpZyBQSFlDT1JFX0lNWDhN
UF9SQU1fRlJFUV9GSVgNCj4gwqDCoMKgwqDCoMKgwqDCoGJvb2wgIlNldCBwaHlDT1JFLWkuTVg4
TVAgUkFNIGZyZXF1ZW5jeSBmaXggaW5zdGVhZCBvZg0KPiBkZXRlY3RpbmciDQo+IC3CoMKgwqDC
oMKgwqDCoGRlZmF1bHQgZmFsc2UNCj4gwqDCoMKgwqDCoMKgwqDCoGhlbHANCj4gwqDCoMKgwqDC
oMKgwqDCoMKgIFJBTSBmcmVxdWVuY3kgaXMgYXV0b21hdGljIGJlaW5nIGRldGVjdGVkIHdpdGgg
dGhlIGhlbHAgb2YNCj4gwqDCoMKgwqDCoMKgwqDCoMKgIHRoZSBFRVBST00gaW50cm9zcGVjdGlv
biBkYXRhLiBTZXQgUkFNIGZyZXF1ZW5jeSB0byBhIGZpeA0KPiB2YWx1ZQ0KDQotLSANClBIWVRF
QyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2Vy
bWFueQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1pdGV6a2ksIERp
cGwuLUluZy4gQm9kbyBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFu
ZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8IFN0Lk5yLiAy
Ni82NjUvMDA2MDgsIERFIDE0OTA1OTg1NQ0K
