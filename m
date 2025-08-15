Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CEFCA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 05:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86A483A6A;
	Fri, 15 Aug 2025 07:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="j1gthb6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5171683A70; Fri, 15 Aug 2025 07:44:25 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C96E783A2D
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 07:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SW5eGXUE02cXOuelisWO5tbC5rsfag0ztaYoFWiVTBmEN6eBRM+GAk4Tn6Gdidi4saElNnqRZPXgcMw07+dG/KHZu+GF66Ed9TEr4CwOmoLgDwMnUOn32b0gGx16vfwVh/TjBE88Bm4/7E/kCj5E6hXv2Zpq6qFsB0KiwPO7kHbUJLDBqnQMusq64qVwoIYxctg6aMu/2Vna1IB49xZE5S71uPzVeuhE6zrYtUGYAWQPtvvYgina0Sk0ci4p64szcq/m1LhJms1ZtpFqpP4UkVJMMp9yU8b/Yx+3CZSMk/POueZI0HDSkLRRj+hGUVeHb22qQynmjUqKEKeZQViC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCLeuuv2LRsfiVpgw7Zc8QNZclcwonuBU71OcaBg0fY=;
 b=l+UwoPFjU6i22mY+2Vge5rCUGtci8HlYuHhiv3sJfsSldtkto+jac0buRPw/IYSDdeLSsoTjTBaA8sW5o0iFDW1phAb7CStE5Pwhu9Diglm9ah3E9Rln79eU1C5L3MMB69XQfAOA9DZXmS7tT33T3iu69XlWGYhiQIIWjwIFllPv6QSFuj3iZQ8ul0bkPGnVJmcmjsy4aRozyDLdte6geI/GYo0GkiK9I+ew1k9ozc/WB3YDk/A+gWbUBljGeofdY9EKlEGDsDwNQtAUO2s9njJ9hWeag/0rEAxxiusOxpKgN0ZW0wE2GLXSegilG3VLKp1sYnz9+qmewlnwP+w+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCLeuuv2LRsfiVpgw7Zc8QNZclcwonuBU71OcaBg0fY=;
 b=j1gthb6tl8KV1Mq0SlQtANdzEo+CNC82tSMySgrTI3YH1xLKwQ/fwwB+WGCuWX0S8TsK+wSDcHBte3ETLQKgSMD+1mC2Pou4xqfaswmra3Y10GyI5sp5c9nVYjS3juimvSc0QIQAGqbv+AtArP+mI2vPY657hpL2Uz1VsMknwjb4NcM8XLAsuaOezmhGjdT6hTbfU7/4yLRrEMot9oTqEVzJWz25vZr53fmctzJ/jV4XO1MKLNYjHhhYdcH9Q3wcR9xQyUceLZh21PxP4rCtWl6PIbvVr7b+l/cTIeEe6BVVQfrkbFKXVBx5rYbgywJAW87LclFaG8wTydxw7ZgiQA==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AM9P195MB0888.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 05:44:20 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%3]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 05:44:20 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Tim Harvey <tharvey@gateworks.com>, Fabio Estevam <festevam@gmail.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 0/6] Fix handling of optional blobs in binman
Thread-Topic: [PATCH v3 0/6] Fix handling of optional blobs in binman
Thread-Index: AQHb3FsnMYVoZScobE+z4BY4QnCudLQVzqQAgE0jRoCAAKSpgA==
Date: Fri, 15 Aug 2025 05:44:19 +0000
Message-ID: <e22d803c78a0e02747be94bac23f02da37bc13fa.camel@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
 <175096060477.1879961.6525302263431603846.b4-ty@konsulko.com>
 <CAJ+vNU1c6RchWTjX+A1dUi-WQ+m-60QacY+-dA5ScodFsc95_A@mail.gmail.com>
In-Reply-To: <CAJ+vNU1c6RchWTjX+A1dUi-WQ+m-60QacY+-dA5ScodFsc95_A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AM9P195MB0888:EE_
x-ms-office365-filtering-correlation-id: fa99be4b-4583-4059-cb47-08dddbbec7d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZS9LNmVZRWdiSm5iZlQwSytmSEJvUzVqRUNqNlZ3SzVDQzU5bXBnMXNoQm80?=
 =?utf-8?B?dUtsQkgyL2p3YWxncVFxM2s2bTIvMVlIWEUzU0dSTGFOY3NrUlJTdDVzamU4?=
 =?utf-8?B?OUZINVowL2JCcVBTeWhoYXF1bWJuWnFRZFFBc3ZkSkR4TGNvNnhrS25aRFZR?=
 =?utf-8?B?SVJLNitIak5rUnNuR2k5bFJlZUdTZ0lFckpkdjNlVVc5K0IrcjRVSW0zMG0y?=
 =?utf-8?B?WDN6bXdHVHl2Uk9xbUVVRS9YR0VtU2Nab1VYcWRCazZFREZPZEI4SndGbWtV?=
 =?utf-8?B?eGZ3amo0VEorV2ZoRDRPengyNExCUnlmamVESmtwb2tETVJ0SHczb3d5QmR0?=
 =?utf-8?B?ZHFRaDR5bnQ3cGdQcGF6ODRVa2JNd3RMdUtxZDdjYnhrQndlUk56OVFpVHVQ?=
 =?utf-8?B?am95VUgvREhXcW83SXZBS0ZzTkNrd2tsTTUrbDJUdDlhU0RXMWs1amZoUFMw?=
 =?utf-8?B?ZkU4UHRWZGs4VU1ZUTlZajMrR0RjSGNlSjJIMkNDQUk4MmFZNWo2bmJSUHZx?=
 =?utf-8?B?cG81b1FTeS9qTStTQTdNbDJCbjJzd0FTVWd4M3FkWEFHQ2R5VmZhWVg1aFda?=
 =?utf-8?B?dmJjR3FIVGt4dm5HTlVQdmJ2bDdKUDhGT2JGZWlZQVpyQ0ZzQ2NwNzJZR0RH?=
 =?utf-8?B?RFVLcTVNQW15czFBNmJGb0QyL1p0NnJrdkdZbk1TdFY3dWF3M0dFbzAwVkFY?=
 =?utf-8?B?SHVrQTZqZDFEZlUzZU5RSjAzK0RJVWVSMW9IdnJvM3JkUjVDS0pZQTlmWjRJ?=
 =?utf-8?B?T1oxOGRuUUZKcVkzUWFweFcrYWNvdS9KTU1FNjBMUFh0REh4UDZIRy9UQWZi?=
 =?utf-8?B?QzNpclp4aC9wbWZLL3drblZ1c21vbDl0Yk55TWlWc09ZTjFkb3Q2Ny9jL3BK?=
 =?utf-8?B?MGNFbkU1V3AxN3dlbmFCSXV4ZHdvdW01LzZmTDI1SzNiVEVkNXNMSHgwcW8z?=
 =?utf-8?B?L0dOK2VYY2V4N0c0T0c2VnpycVV5MWdxNzNzd2RxOWdaYW10RlhLcVZCRDYv?=
 =?utf-8?B?Yi9ST2NiMmFwWFVqcGFsNXFPc3dOWnBEc2tNUUNQTHNpenphVjdRVitmRWdL?=
 =?utf-8?B?Q1RBY2x4TkdSL1JKRjFpNm96eTVxQnM4ZUhidFlJd1BiTndUVndHRnlXcmRs?=
 =?utf-8?B?NXNkdWdtam9lNCtpMmVLY3lNR0VUa0RUaW5qdi9qL0FoeGFobzJnUk9VYWZV?=
 =?utf-8?B?NEtuek03blBXNmRteUtjbWJWZ2dSNVZpZ3JyRVp6Zko4NFVNMFZpUWN6V0tE?=
 =?utf-8?B?c0V3SFRoNXBuSTJvUHMrM3haVFFpbVFqaHlyZzJNaEwxbWlNRHcwa05oYTds?=
 =?utf-8?B?alpxMmNUNmpjZnptSmt2VTRHNWtSMTVwcjVTVk5RbzRWemNYKzJ1bUsxeE42?=
 =?utf-8?B?SnljdGVyL0JnTFZzdk15QzRvN3BIbnlxQ1ROWVhWWjNqYkVicURRQzJUYkJv?=
 =?utf-8?B?eXpmZGVteTVlTm9wRk4yUHpZQjJWaVQvK2JnU016UmFGK0hreUFiZ29CQitk?=
 =?utf-8?B?Q3l6RmREVE52M2lqcWlFaDk3Zjk4cXJWckhWUlZrd01WU0Z3UlpyZzIrTlFY?=
 =?utf-8?B?eStmQnlpd0lRajFSOERROUFGZE8vekxibUpjWHlnN0gvMjgvTktiZ0Vac21S?=
 =?utf-8?B?WThaZTFVNTNzdEZsWTYzK285cG9VYzVhS1VSRktNUnB6UnZURVZSbStkQzhz?=
 =?utf-8?B?OXU4Z1hzQVU2SXJRdWdCYlpmaFpCa0piVzNsbjhJQ205Z0h5RjlXdGIxdFdp?=
 =?utf-8?B?QlFEOXYxdXcxb3hJL2JCZWJweWxLWmlhYm8yRkI2KzhtejZvV2E2Nm1uTjJw?=
 =?utf-8?B?RjZRbVFVWFdUdDJ1NUx0dnh4SVR4QUhRb1BsbkRBcjhBMEVGQ2ZsWDNpUTBo?=
 =?utf-8?B?YTlXUkJ1RTNLeDFGRFhmMUJWQXZvcVBzRGhmSzhtakhHMUIrUnl5bzh5THhY?=
 =?utf-8?B?V0U1QkRTY3NrcWlMUzVPNExLYy9QcExqRDNxWXN5TmFPNzYvemxzdlFiM2d3?=
 =?utf-8?Q?iHyXrMqyAt/iEEbXwGuNQ31ijTSD8g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NThUWEhWc1pOZU02UkJPeWNPMWs3anA1SVZWeWsxTmdzaVdURHVrSTFGMEdR?=
 =?utf-8?B?elVqbHFnNXZwREd2MUd1Qm9mejBIaHAweUVJNXNtYU45SnlpejUxc3JuR1ZN?=
 =?utf-8?B?T21hUzlQVDFwN2VNRUJhSlJmeDVhZ2J4UlhGelNGMGlkdGtmVjlPNFlCL0xo?=
 =?utf-8?B?TmVIb0dEUUMxT0JyaU45cTRYdTI5TUdlOFN6SEtPN01ScHpzNUlqaE1LeVpJ?=
 =?utf-8?B?cTNRV0xZb2x3QzJKTkNrbnpFeGQzL0syQlcvaDNLcFA2N2lQbTJYckhHMEU0?=
 =?utf-8?B?YWd0MHdSTkZ6dUYwUHdlS2JPemJvNGdlSEZTUFoyUmxCbWgvQVJUSEI4cFNp?=
 =?utf-8?B?SUZvNktYcTFucGdncUNxT3paNmoxQ2RxTTJ1UUpTQlJmQVUyREdJSzVCQnRR?=
 =?utf-8?B?R3k4andKMW9UaGllbHdOU0FXdzlSQ0txSzhkZVNldEpCcDlSa25XNkhKWXAr?=
 =?utf-8?B?a1Y2TDJIUVhOOXFuTjRzWVAxNUJEKzNyQVlLMCs1UXlVWmpGUU11ckpFZmdR?=
 =?utf-8?B?Nk0vQWdCeHNEcW9UV2dXaWtVSFlFMHJTQVk4ZEZ1b1dEWVFDeFhyMG9zMDhx?=
 =?utf-8?B?M3p6blk4UWVZSzZNdlB3TllLQ0dVa3RTdEIvWlNxQ0dGbDZoaEsvNU9uV1l2?=
 =?utf-8?B?d1ZiU1J3MkNrL2tMSHAzcmhrT0NHaENYME5jdUl2bHZlK1lHeVFhWWZOaVJr?=
 =?utf-8?B?S29tUjMyM3RXSi9WSlRhaExnL2ZTSnFueGtrOWZpcEZkQjg3TG1xT0lEWVVn?=
 =?utf-8?B?V0I0QTZHZ3Q1a1BiQm1HSFVqQ0lWMkticTFrenlUVlVBb0VoYTM0K0hVWU92?=
 =?utf-8?B?Mnd1Q0l5ZGpHMi81VlcwQTAzWWw3aTE2azFQTnJMMCs0U0gzaGpmMVRoM3dC?=
 =?utf-8?B?WnltY3RTVmZhb0pTRGc2UEVNVDdteUk4Zmx6Zjh2Y0VxYkJPaXFSd2VPRUdI?=
 =?utf-8?B?NUs4SHpHSkp4b05BTFNvbHFjT1c3bHh5amxqREJiUTUyVVJPOWYvSkNQU250?=
 =?utf-8?B?WGhSUUJDaXZCNkRNODJkNyt6MjN0RGJFdUFRN2ZGd202bm9lekhvbjF6ZkFQ?=
 =?utf-8?B?WE1pckxpaFBDbjdLdWxjMi94Ukp1RUJBTEppM3pnYkZLY2JYNDY1TFJERllI?=
 =?utf-8?B?ekY5T1JKeDJJemJ0M01pRnkrTXl0K0ZkQm10U1lhMzQ0UEJYOEgrQm1TVXJT?=
 =?utf-8?B?eWh1UGx2UUhDczdGdTlFSzVrb3FGMUNmdGYvRk1JQ2NId1crY3M1dGNyc2VD?=
 =?utf-8?B?YmJIKy96SExmWEVOdzFzNGNnWWUyYjhBdFRNc3krcW5MVVQ0VG0rc2NrTmJ4?=
 =?utf-8?B?MzczR3ZqZGpmalRFZTUyUHJWK3F4K3BYRWY5djVQVUVGenRvMHBpV0FCaEFz?=
 =?utf-8?B?VDJFb3VFOXo5anlvcStQMERQTTM4dktiZDhxQmFyM1dXOXRjNWdZa0duNmFl?=
 =?utf-8?B?a1JNWjJFYm16U05YaElCSG1BUXNuQkxyaXBRUmxEdWd6VWdMc2hPRXVSdXBt?=
 =?utf-8?B?aUlHVktDUGZsMmN4Q0lVV2s3OFNkMjJkbHJ1TXZTaUZpLzNaSG9UNWRVNm1l?=
 =?utf-8?B?RkRLRzhTQW9OZG9yRURXRVhETloyUG1Fb2RvdGpYZ0xxczlxY0NOR3RrSW5O?=
 =?utf-8?B?Z20xYjl5T24xV1JKMUY4T0RQRUpHWGJGNmJXbFR6Y3hwREFmOXVERlhnUWZE?=
 =?utf-8?B?NExMY0drSnZjcHl4ZTBBenZwVHJqVXFtanRwbkhwOWQ5Q3JlanNncmpYM1hv?=
 =?utf-8?B?MHFVdURuejB2LzE1cUlZTFVQY0tSMXRJWlFkaklGQlcxMkFvS1J6M2lKWDAy?=
 =?utf-8?B?R2hrYnM4TWRCSUNhUjBuR1NkOFRLUkJFOUJlWFRXdlVucjROVk1XK1JBV254?=
 =?utf-8?B?SUZqUWR0QjZRcGNUcnVUM1lFOFkzU3hOeDdjWU1ScmNsUUhRUzhsSlE1YjNC?=
 =?utf-8?B?MFY2SnRTRzdVcUFRSE05QlV2TkRoVXNsbDZmOFA4Wm9TSitQcmdXVlhJQUho?=
 =?utf-8?B?b2hOSnpsVzRINC95NmREdGxKU0YwMU1NcnBURy84YUg3SXFCV2NNYzRZWUhP?=
 =?utf-8?B?MGUrUGdmRFB4cnUxeUpIeUtEZG9idkgxNEg1WGptT2p0akE0aDMrK1VMY0tP?=
 =?utf-8?Q?k6I0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE93A7EC126E2E449545CDD3B1639C43@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa99be4b-4583-4059-cb47-08dddbbec7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 05:44:19.8970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k727pN7oJNFPcjBN+8Delm8HcEmVXcS9XkvH585RK0PPzOQz/yhyR01V8teeJIagIZi+3YBXV/GVO9IMCYpqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0888
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

SGkgVGltLAoKQW0gRG9ubmVyc3RhZywgZGVtIDE0LjA4LjIwMjUgdW0gMTI6NTQgLTA3MDAgc2No
cmllYiBUaW0gSGFydmV5Ogo+IE9uIFRodSwgSnVuIDI2LCAyMDI1IGF0IDEwOjU34oCvQU0gVG9t
IFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IE9uIEZyaSwgMTMgSnVu
IDIwMjUgMTQ6MDI6MzkgKzAyMDAsIFlhbm5pYyBNb29nIHdyb3RlOgo+ID4gCj4gPiA+IFRoaXMg
c2VyaWVzIHNvbHZlcyBhIGNvbnRyYWRpY3Rpb24gcmVnYXJkaW5nIGV4dCBibG9icyBwYWNrYWdl
ZCBpbgo+ID4gPiBiaW5tYW4uIFdoZW4gdGhleSBhcmUgbWFya2VkIGFzIG9wdGlvbmFsLCBieSBk
ZWZhdWx0IHRoZXkgYXJlIGZha2VkLCB0d28KPiA+ID4gbWVzc2FnZXMgYXJlIGVtaXR0ZWQuIE9u
ZSBzYXlzIHRoZSBpbWFnZSBpcyBub3QgZnVuY3Rpb25hbCB0aGUgb3RoZXIKPiA+ID4gc2F5cyB0
aGUgaW1hZ2UgaXMgc3RpbGwgZnVuY3Rpb25hbC4gQm90aCBjb25jZXJuIHRoZSBzYW1lIGJpbm1h
bgo+ID4gPiBlbnRyeS9ibG9iLgo+ID4gPiAKPiA+ID4gQmlubWFuIGlzIHNldCB1cCB0byBoYXZl
IGZha2UgZXh0ZXJuYWwgYmxvYnMgaW4gY2FzZSB0aGV5IGFyZSBtaXNzaW5nLgo+ID4gPiBUaGlz
IGlzIHJlZ2FyZGxlc3Mgb24gd2hldGhlciB0aGV5IGFyZSBvcHRpb25hbCBvciBub3QuCj4gPiA+
IFRoZSBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBhbGxvdyBkaWZmZXJlbnQgdHlwZXMgb2YgZW50
cmllcyB0byBvdmVycmlkZQo+ID4gPiB0aGUgZmFraW5nIGRlY2lzaW9uOyBhdCBsZWFzdCB0aGVy
ZSB3b3VsZG4ndCBiZSBtdWNoIHNlbnNlIGluIGRvaW5nIHNvLgo+ID4gPiAKPiA+ID4gWy4uLl0K
PiA+IAo+ID4gQXBwbGllZCB0byB1LWJvb3QvbmV4dCwgdGhhbmtzIQo+ID4gCj4gPiBbMS82XSBi
aW5tYW46IGRyb3AgImZha2VkIiByZXR1cm4gdmFsdWUgZnJvbSBjaGVja19mYWtlX2ZuYW1lCj4g
PiDCoMKgwqDCoMKgIGNvbW1pdDogYTY1N2Q4N2YwODc4OWM0YzUwNDIzODk3YmQ1ZWUwNTJjNjIy
M2VlNgo+ID4gWzIvNl0gYmlubWFuOiBtYXJrIG9wdGlvbmFsIG1pc3NpbmcgYmxvYnMgYXMgYWJz
ZW50Cj4gPiDCoMKgwqDCoMKgIGNvbW1pdDogM2FlNjY4YjlkMjEwMWQxMTFkMjU3ZWU3ZDg5MTJj
MTljZmIwZTEwMgo+ID4gWzMvNl0gYmlubWFuOiByZXdvcmsgZHJvcHBpbmcgYWJzZW50IGVudHJp
ZXMgZnJvbSBwYWNrYWdlZCBpbWFnZQo+ID4gwqDCoMKgwqDCoCBjb21taXQ6IDIxYmMzNDMzYTQz
ZDNhZGQzNDMwNTQzYzllZWUyYTk1ZDRkZWUyZjYKPiA+IFs0LzZdIGJpbm1hbjogYWRkIGZha2Vk
IG9wdGlvbmFsIGVudHJ5IGNhc2UgaW4gQ2hlY2tGb3JQcm9ibGVtcwo+ID4gwqDCoMKgwqDCoCBj
b21taXQ6IGY1ODE3ZTA1ZWZkMzlkZDQ1NWMyZTZhMGYwNjIyZDcwOWZlN2VhMmQKPiA+IFs1LzZd
IGJpbm1hbjogZnRlc3Q6IHBhc3MgYWxsb3dfZmFrZV9ibG9iIHRvIF9Eb1JlYWRGaWxlRHRiCj4g
PiDCoMKgwqDCoMKgIGNvbW1pdDogZTc0OWQ2NGI0NjIyODA2MDcyYzU2YTgzOWNmOWEzNmE1MDgx
YjU3NQo+ID4gWzYvNl0gYmlubWFuOiB0ZXN0OiBhc3NlcnQgb3B0aW9uYWwgYmxvYnMgZG9uJ3Qg
Y2F1c2Ugbm9uLWZ1bmN0aW9uYWxpdHkKPiA+IMKgwqDCoMKgwqAgY29tbWl0OiAwZGJiMGE4ZDFm
MmFlZmIyYTdmZGQ4ZTYyN2VkZDk1NWU0ZmU4ZDNhCj4gPiAtLQo+ID4gVG9tCj4gPiAKPiA+IAo+
IAo+IEhpIFlhbm5pYywKPiAKPiBJIGhhdmVuJ3QgaGFkIHRpbWUgdG8gZGlnIGludG8gaXQgaW4g
ZGV0YWlsIHlldCBidXQgaXQgbG9va3MgbGlrZQo+IGlteDhtIGJvYXJkcyBhcmUgZmFpbGluZyBh
Z2FpbiBpbiBtYXN0ZXIgZHVlIHRvIHRlZSBjaGFuZ2VzIGFnYWluIGFuZAo+IHBlcmhhcHMgaXRz
IHRoaXMgc2VyaWVzIHRoYXQgaXMgY2F1c2luZyBpdC4KClRoYW5rcyBmb3IgcmVwb3J0aW5nLAoK
PiAKPiBIZXJlJ3Mgd2hhdCBJIHNlZSB3aXRoIHRvZGF5J3MgbWF0ZXI6Cj4gbWFrZSBpbXg4bW1f
ZXZrX2RlZmNvbmZpZwo+IG1ha2UKPiAuLi4KPiDCoCBCSU5NQU7CoCAuYmlubWFuX3N0YW1wCj4g
SW1hZ2UgJ2ltYWdlJyBpcyBtaXNzaW5nIG9wdGlvbmFsIGV4dGVybmFsIGJsb2JzIGJ1dCBpcyBz
dGlsbCBmdW5jdGlvbmFsOiB0ZWUtCj4gb3MKPiAKPiBiaW5tYW46IG1vZHVsZSAnaW1wb3J0bGli
LnJlc291cmNlcycgaGFzIG5vIGF0dHJpYnV0ZSAnZmlsZXMnCj4gbWFrZTogKioqIFtNYWtlZmls
ZToxMzM5OiAuYmlubWFuX3N0YW1wXSBFcnJvciAxCj4gCj4gSSB0aG91Z2h0IEkgaGFkIHJlYWQg
c29tZXRoaW5nIGFib3V0IGEgd2FybmluZyB0aGF0IHdhc24ndCBhbiBlcnJvcgo+IGJ1dCBhYm92
ZSBpcyBjbGVhcmx5IGEgYnVpbGQgZmFpbHVyZS4KPiAKPiBBbSBJIG1pc3Npbmcgc29tZXRoaW5n
IGhlcmU/CgpNeSBpbml0aWFsIGd1dCBmZWVsaW5nIHNheXMgaXQgY291bGQgYmUgcmVsYXRlZCB0
byB0aGlzIHNlcmllczogCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3UtYm9vdC8yMDI1MDcwMS1w
a2dfcmVzb3VyZXMtcmVtb3ZhbC12My0xLTI3MDE4OGIzMzVhZUBwaHl0ZWMuZGUvCgpNYXliZSB0
aGUgY29tYmluYXRpb24gb2YgdGhlIDIgc2VyaWVzIGNhdXNlcyB0aGlzLiBBbnl3YXksIEknbGwg
aW52ZXN0aWdhdGUgYW5kCnJlcG9ydCBiYWNrLgoKWWFubmljCj4gCj4gQmVzdCBSZWdhcmRzLAo+
IAo+IFRpbQo=
