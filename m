Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAB7C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 14:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA6487C69;
	Thu, 27 Jun 2024 16:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="BnJfZbpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB4F87AEC; Thu, 27 Jun 2024 16:41:28 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7138888247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 16:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infinera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joakim.Tjernlund@infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxiWVr7RhkRWuAJyLp3zJzWLi4gvOl71O5srQzq2QpHtZz685LPgtTT3J1iRQsIU/Nz4Nju3m+wd8vzPdj1ca5qibHykGsSbtq/fPfkAfge7snR6MmBt1pjmXCGbDH8IR5tCpSZ1T2xZPO+R37IVUoAaxcBe0/1hltlhgPWLdk4sRQQqz9AJE4Ur4sN/kzkW5CNWQ+wcJB3tSiwN1Z4ronCEReRHsdWYC1WOqtkkQ7x+M9TLzY8wSL9zdd7D0pZj976DDFEvuv6qqR3TF+WDLuhMmeWyeW1QwqUN740K11UhIyhL2z+5UskJNgP1hs372EZyOa86WM3/D67WxOkBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSLzGJxSPmGY+sVCN62JN6aVCO8yuDSn7CxXOdXDSDc=;
 b=SHO/hmvC5z4YPKlmu+N9BWP7LHWaFznTLmk6JL06dXawdqKwZ2GUPVso+Qq5dZ9im0fKgWCO7sph31shyrcL7QTOyOvbtCrG62N060ZrlR2jTbp8Hw+fMGoWPCuK7ojdoaL37A5xiTR8TtXnwVYz0S5FxXoeI1QNBut3Z8o4Ko8L/EdKOq7iZYn+2BTdIJOS0FK8oLAxM7rnrd8q8KYHBffhoJgfeZQZkC7WTe306SPhwLowK3kOw77isMM0c+fpQ4InEUHFpwlT2aABtcsqT1q6kHixdONXDiZwrc4xVHHv0aYUm3OD0/wHl9UNZDLFDNcDiIcaaAaxID9GEiCNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSLzGJxSPmGY+sVCN62JN6aVCO8yuDSn7CxXOdXDSDc=;
 b=BnJfZbpuzznZHyiqcwFQfzdIh5EGKdECfIlMtvod+lcrpFGjum7PqJKxVUhHG+DbzVL8Wc3WAbvdSrL181EX8LppdDZvWhtGjqAg90tC+XQZTcmWFTl77DYBBDYknxaaxzlX7gO9UJIAclFj6RRpFqYNtwVu3YvNP+FZeLQwvsFTryhVTGWvgGaAzjki1ijxDd8LPGlU+ApsmWapf1b4WXUb9oQo4ZYpJ8oux160/5OVfU4V9mIMMDht+F5H4bIDmoTMrqb6c8nj0aR1P5zHjdMX2I8iWhWaAYItrQKv9pKDNa2KrP5+l6sfmt664HJu19qpx7Uoh7S3E4OPgRNLiQ==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 14:41:22 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::24d1:393a:f0ee:5c7f]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::24d1:393a:f0ee:5c7f%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 14:41:21 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "michal.simek@amd.com" <michal.simek@amd.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] zlib: Fix big performance regression
Thread-Topic: [PATCH] zlib: Fix big performance regression
Thread-Index: AQHayGwo7aI/a5y3yU+bgGJsTVaB7bHbr00A
Date: Thu, 27 Jun 2024 14:41:21 +0000
Message-ID: <0b10b77fb60b78a2619b445f93af1545221e65f2.camel@infinera.com>
References: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
In-Reply-To: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|CY8PR10MB7148:EE_
x-ms-office365-filtering-correlation-id: a9e12b21-89b1-4b14-63f6-08dc96b7367e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?azVHOWQzMlgxMW1vVG8rRmhjSklFWEZTNGZwWFV3cEk4UW9xTTZEcG90ZVJ6?=
 =?utf-8?B?blZIcXh5QUZmbzRzYTBvRUZtSzNGcVJhZ2hQZDNsSHlnLzZ5VXpKSWFaUWs4?=
 =?utf-8?B?OG53dU5QVitUaWYvaDZ0SmEwZHMzWWJsWjMxZEhqWFNZTHdpT1lsNm0zQWRq?=
 =?utf-8?B?YUxjM1pCLzVDK0NRK2w2ejliZEl1aEV6VU05cXVLcGdwMDZVUjJHcEVLN2lO?=
 =?utf-8?B?Y2FMdE1GbkV6SFg1RFJJQXNnNExhcjA3Sm8ydFR3YjhPT2NEK1lnTHFGWG9x?=
 =?utf-8?B?TzcvYmRLMnN4QVRiSlR6ZTY0cU9sSUVsWDJHV0RDQVF3MzNaTXQ4ZUlGQ0kv?=
 =?utf-8?B?Si9sL0tJUldZUFMxOW9jSGR3aXRhcnYzdEY1Qnc3NzVMUnREZXRHd3Z4bXk3?=
 =?utf-8?B?MGNhbkcydGhKZkZYeEpJSmE3OUQ1aGhib3NqTEM1UzFBWkRmRzBLNUt1S0VO?=
 =?utf-8?B?QVZ5eTE1V0JUSmVaTHNsN3pzTVdYaFNiSS9OQXhwd2c4QWNXNC9RaER5aGFC?=
 =?utf-8?B?VXFNaC9nY2FxLzhhb3lxNG9OcSs4NXl6UjE3bUVkT0JFMlArK2I5aFJNUlRP?=
 =?utf-8?B?bEZiQ05lcjRVWVVnUml4TE1BWG0zekhHVi8vVWJHRUpyRitNY2Qxb0JOZmFX?=
 =?utf-8?B?RHlGbnI4dG5SYlVZOVZaSkdiSGtEcnZHdndrdEJOcXlnZFlqQ2RWdzFYUmRW?=
 =?utf-8?B?RnNDeXphUEFuVmgzSEtDTTdzQ0d6WGw3dUUzN0puUzhtc2JkeHFtaTd2ODhJ?=
 =?utf-8?B?cHBPQmRpQjJQcE5hK0daS2h3Q2RhTnlMY292WDRubStKK29Vdnk0UzhTT1dw?=
 =?utf-8?B?Wm9VUy91cEVKM3B3K1BkVWlkb3hYdGtacjZTanV6c3N1MGNGWm14VFAwWTJo?=
 =?utf-8?B?cjlBTXFTMTAxY2VTWlFPNWl5YTduR1BURHVTY2U2STF6VnZIWG5SQk9sdFcy?=
 =?utf-8?B?a3pXM29QbnN0UHhGQklGSUdGZ0JYKzI4UTZRUVJLeTcvTmRGY0FJMnpjeCtO?=
 =?utf-8?B?aVo3dUxGMXRPZ2pOMFlOMi9XblNaTG8xZTIxYWkzd0xRQzMzZ0VFZDUzMU11?=
 =?utf-8?B?VHFha2VCbmpqeEpTVStsZDhGN2NPVjVIc2ZsV2NxekMwcS8wcVJvMmNFK3Zs?=
 =?utf-8?B?bTNBV1ZSUi9aOSt3NU5lbm9BVFllcHdBem5QbWhydXhzTlBzckZtanBoWDZE?=
 =?utf-8?B?UDlEMkJ0YURIMkVDcW4zdDJJdkZDN21NNGt3c01oU3N6NVVPN2ZnMWNjenIx?=
 =?utf-8?B?NnJrdllMWEl4Z1FmUlE2N1BVQTByT095c01pd2dhcmJ5SDlPdlRRamZ3M05I?=
 =?utf-8?B?T05FQXIrMWR4U2pNdCt1MnpiZVZvRWdqS1IxMTlRQjFIcVR6RTUwN2lSWDcy?=
 =?utf-8?B?NmVyUkhvckxBWFVYOWdESnpJQXhkZVZFZmljU3pVNmZ4bCtpVzFEZ0NyQzdw?=
 =?utf-8?B?TUZ4OVorc0RaWnhPdlBMdmZZWWozbGV5dC9HeUg1YUF2NjREYTJRYzJqc1Az?=
 =?utf-8?B?RnFLUXNwS3ZwLzE1dXZpZWxWQXg5Sk9ZejBIK0pPNGVxd3RkRmpJbFlwb3Bq?=
 =?utf-8?B?Sk1HcUkvcTZQVjFKNU1pbk5raVVHMnhvbG1BdjRXQnJvckE3anhVNGJkTURZ?=
 =?utf-8?B?aUt6YlNDaUp1L2RjZTd0NEo0RmNEMGsraC8zRjhVeU4vWWJkMWJob2dhTnk5?=
 =?utf-8?B?M2syNEhRS2NrNm0vbTVhZ1crZHYwR3JGbkI5WnlGdFpBYzQ0MzVIcktrZDhp?=
 =?utf-8?B?dTNZZ0lEeTZRRmtQS0JyMko5aFBoRml6YmNHNGdOL1lDQmpXaVA4V20zR1Uz?=
 =?utf-8?B?YXA0WlcxSkxBNC95VXpNTUY5L01oUThWaU5BeWhzYldkcTJZYi91Q0FqMi9m?=
 =?utf-8?B?dGpOclBuRTRKOEs4OHJkakFoN1pYMDZnMU5kWXh6WnRrRkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4615.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJuZHhqSmwvcHQ0bFBibFRiMnlILytmUzIzY05Za2UwVytaM0F2cm9xSG9z?=
 =?utf-8?B?VVlDN3Z0T0pXUExkc3ZiaFpPYk96aXRFd2VIYmY4ZDIwUlhTc09YUHdhY2Zn?=
 =?utf-8?B?Sms5alF3QjJHa0dRMUt4UGVSMHFJR01LeW5OaC85OS9GQ0J1VEhxZTdseDZK?=
 =?utf-8?B?MzNjRDFmYjl6YjlRNHlVc3hoS1NLZ2ZJTndzSmJBc2QvTHN3Y09tWjBQcGZ6?=
 =?utf-8?B?UlJmWlRJdTQxMldQbUFVTXlMdEtpVFQzS21LN1VoMWJVcGt3SHhDRUJCRytL?=
 =?utf-8?B?STZ3M3VIUGpxMnZrVldwVEZyMExOMmFtNndUbUROcy9MMmIvckRPQ3UrZEM2?=
 =?utf-8?B?K2U5L3p1YmZYbTNGQUx0ZzdmN0ZCS2VlRm1zSUdVZ3F1QTNZMy9xRHY5ck9i?=
 =?utf-8?B?emZoNzJXMDBzNjI4bG5lZHdSV3ZQZFF3RFgxRDZ5NHBmZ2lXK2s2WHRrL2Vv?=
 =?utf-8?B?RkI4eDhndnU3TWYxY0Q1QlNGY3FzMFdOSlhjbkNmVjhBeFNJVlhVUzFjdXls?=
 =?utf-8?B?T3VwemNDejFtbE8wdkhIajVqY0IwQU5CbFpzbTR0Q1B4VjUxKytWMCtBSk1Y?=
 =?utf-8?B?TVVoeHBYZnZrbjJZM1JkZ01VQUM4c0pyTlJWUEF3N3hRMUJpTzBndzY1cW4w?=
 =?utf-8?B?ME5CSGRBZ1BzODFZeU5Pcld1VVdkQTBxcVA3cG9TcENsR3RVMTl0QUhhaEJ2?=
 =?utf-8?B?L1JNSGNzUDdBem8reTQrQm5kQ0wxazVJajBndkp6OU9ybWhCNG9CdnFzcWov?=
 =?utf-8?B?c3gxUng4RG5QeHcramJKNzliQTlKZjR6SWk4dUJMNDNxTWxrV0MyWTl2djA4?=
 =?utf-8?B?UVVyVnljQXZHclJmaDQzK1Z3cEROU2RuOTFBK3ZoK1hRMkhqaUwwNFpHUnd1?=
 =?utf-8?B?YXBWTlJFb1d5LzRVNWQ4aGtpdE1PVktUUVpyN0FlN2M5Um9uRjNiNTNZY1dE?=
 =?utf-8?B?c1F3U2VlQmNVOXFmcXZ4aVk3TFlkUFZDSndGeXJOejRiUFpVRUhyVCtQZDJE?=
 =?utf-8?B?TVlIMERSMUVoemUvVVlNdEd4L3VKSGppTnBHdWl5TWt2OWdyRzVQS3F6MWl6?=
 =?utf-8?B?NVF5U2ZabzhKVG1jQmVnWElsTEdEanF3MWpHZ0dCSTh0ajlMK3oxbnRhT3FP?=
 =?utf-8?B?NnBKV0duc01IYWdiTnFldWl4V29acVE5cTg1c2krK1lyT3MwMlZKaE5nRTNq?=
 =?utf-8?B?SW5XVU4vcGV6eXRiK2R5dUsrakdLZGEwbk1RTk9YV1Blb1IwYWQvRlNsbXpL?=
 =?utf-8?B?RXdwMFU3Ny9RZk1JTWRzMFZteWJQSlBtZ1dObTdQL2RpZkNwT3c5ZERqakVJ?=
 =?utf-8?B?OGVyUmZObHQvY3RrWTdOa3hVWmdQT005a3VHcHMzQTFERjc1cExUenNDb1Bk?=
 =?utf-8?B?SGRUS1p3bGI4UUhJM0xNazZGWW5wcVgreHZNTEY3c1FJMG1kR2VsM3hsZE1Y?=
 =?utf-8?B?dXNUc3F6bU92aVFVbkdpVXF4eVlZaWF6SE1WVExxbHowVzFLSnpsRUNzbHR0?=
 =?utf-8?B?UXB6VUdFSk80VENmNTlLekdFd3o2UEtsNzVaZm5ZVjdCSjlmSURUMmpSVWwr?=
 =?utf-8?B?WStMckNVRUlvWllJK2M3ZFBmWmhLNjZkM3VBd1Zid1V5V0ZxQ28xR0NRbmlI?=
 =?utf-8?B?RjRHeWd3VEtmNTBOSHZuQVpUYVI5V2k1Vys4a1NYQk4vWUFZN3VncVJvaG9r?=
 =?utf-8?B?RlhQWlBKVmVnejhFODY1UkNuRm53U2NVOURPbTcyWUZnaGtia0FYZzBCTllU?=
 =?utf-8?B?VzZDc2F2L2E5aGI0TDM0UWJ4NFFrcHBYL0E0S3ZlMDBVR2c4V3FNdGdEalBm?=
 =?utf-8?B?N3c4bEpoREVxejFuL2hIZm5RVW1rODZaNkxSZ3RRT0VGUkV3bks5OCtac2tt?=
 =?utf-8?B?dDNVZDg1VGhhNmxrdXFVdUVoNWdzVjh5RHVYZUtrbHhUblA1MDVuNWxrcC9T?=
 =?utf-8?B?OHVsL2JOdVdJcnZsS0VTSDN6aWMvUTNkMWVnd2crN2h3alRJT25PdlVyOEpN?=
 =?utf-8?B?d3ZvRU5aMy9TcFV5cHZwaUFuQ0lManRnVEZYQ1AwV2RRMDBTMkxyMTgwMXVr?=
 =?utf-8?B?RWRXeDZRZVpEMzlVMDhSdkljdjJjamdyczBydkp2elM1T0JkRHowcVdsRU8v?=
 =?utf-8?Q?WoAVxfi6+qRVlfmnrG1rtEN0Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEE6A80A98977C49B314C4C444830B4F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e12b21-89b1-4b14-63f6-08dc96b7367e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 14:41:21.6913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3K2iIbYiwG1/8T1qCql+1y0N3HRfdwdNr73/9XpfH6tfEfldffk/EMxHwScdVze+0SAP1PrXu+NHE+EHn1Mk+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
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

T24gVGh1LCAyMDI0LTA2LTI3IGF0IDEwOjI1ICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiBDb21taXQgMzQwZmRmMTMwM2RjICgiemxpYjogUG9ydCBmaXggZm9yIENWRS0yMDE2LTk4
NDEgdG8gVS1Cb290IikNCj4gYnJpbmdzIGEgYmlnIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gaW4g
aW5mbGF0ZV9mYXN0KCksIHdoaWNoIGxlYWRzDQo+IHRvIHdhdGNoZG9nIHRpbWVyIHJlc2V0IG9u
IHBvd2VycGMgOHh4Lg0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGF0IGNvbW1pdCBkb2VzIG1vcmUg
dGhhbiB3aGF0IGl0IGRlc2NyaWJlLCBpdA0KPiBlc3BlY2lhbGx5IHJlbW92ZWQgYW4gaW1wb3J0
YW50IG9wdGltaXNhdGlvbiB0aGF0IHdhcyBkb2luZyBjb3BpZXMNCj4gdXNpbmcgaGFsZndvcmRz
IGluc3RlYWQgb2YgYnl0ZXMuIFRoYXQgdW5leHBlY3RlZCBjaGFuZ2UgbXVsdGlwbGllZA0KPiBi
eSBhbG1vc3QgNCB0aGUgdGltZSBzcGVudCBpbiBpbmZsYXRlX2Zhc3QoKSBhbmQgaW5jcmVhc2Vk
IGJ5IDQwJQ0KPiB0aGUgb3ZlcmFsbCB0aW1lIG5lZWRlZCB0byB1bmNvbXByZXNzIGxpbnV4IGtl
cm5lbCBpbWFnZS4NCj4gDQo+IFNvIHBhcnRpYWxseSByZXZlcnQgdGhhdCBjb21taXQgYnV0IGtl
ZXAgcG9zdCBpbmNyZW1lbnRhdGlvbiBhcyBpdA0KPiBpcyB0aGUgaW5pdGlhbCBwdXJwb3NlIG9m
IHNhaWQgY29tbWl0Lg0KPiANCj4gRml4ZXM6IDM0MGZkZjEzMDNkYyAoInpsaWI6IFBvcnQgZml4
IGZvciBDVkUtMjAxNi05ODQxIHRvIFUtQm9vdCIpDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCj4gLS0tDQoNClRoYW5rcyBm
b3IgbG9va2luZyBhZnRlciBteSBvbGQgb3B0aW1pemF0aW9uIDopDQoNCiBKb2NrZQ0K
