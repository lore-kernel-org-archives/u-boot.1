Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ED5C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 01:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404DB88405;
	Wed, 26 Jun 2024 03:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="QmM9JTWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4F888452; Tue, 25 Jun 2024 17:12:42 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183928815E;
 Tue, 25 Jun 2024 17:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cs-soprasteria.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=christophe.leroy2@cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF5qnRZ/1Uv7pEMLjXx/Om7505Pl1gXZZXQBZKlmgLG61KTOGuBOiAbKuJVbBDMp8LwcXg164Ccgc1V7DVLSGVftB8uMsp4RDVSt1Cdwht+3PkzIH1eUn16dQT9MlWAhPed4+yBw6Lxwh84WJFFGtg7uuVoGAKbqNNIAuV54m63CHQSz+OqvU37DIZeB7My5augG4do5G1Y2mp/jJs2uvnpoFPE0xHRRxMiM+VLymopXEFsd5Jw+r4UrCd+UE5Gu4D41jccxh246U4aq95BxGP5Dh0G2HfYRvS5GexrRHmg3V9aVPnvKdLBJzDujPQyjJ2hhA6K+HKW3xjlBw/4M+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COnwpV9B53i6nl6aHrFhOUexRnlO8zyrlHuY7QyWeso=;
 b=a01whFvPK1sWTgpjj0GBiFORhdbrWNPYiYyl0R/aA5utUWE4iMge/4BT43iTMC+T1Ta15Uwf/ez8BNbrVXZ2eHr/MfARt8qW+DT1cFomUFtXSy1V7Ta2nMauK0FeEzw4mjKgL3cZL1KHee8Zyg/zg289DQiVs23CcK3EX7erpYV8J5VF7fvyzkcYV0uatZJHkWPVT3MFjd6f4cOxWHiY50HlqGiE5uCMf+nEfpgF8jsasABiV9rIm2wwX7O5zl1Dyfls7sByFa2b02mNUcjszTulrshBGNJBW/hvj1sYW9HvWrP1HORTme5QNg5eTlGo6wBU4nwoLIAp8fOHE0QDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COnwpV9B53i6nl6aHrFhOUexRnlO8zyrlHuY7QyWeso=;
 b=QmM9JTWZIskm//B7Ttf0xF5JBc3KCGA/AycBM84Z1xZslLODPUtMlT1BGonrBPlNHu+A0B0SCkdSU4jU0eO5pgI2kPQ6u+xmsI9KpvijfJGwk/4hBoTwFxG/lNx1ofdS+2a0Q9hrDKhD9VDQTYD4IiG242FZbKpivlJAWZryEEKfWp7wQIO7kq55WryXFfDARtkLLvwZyipXoKA/ymdUlW9vWiA4uNUynLVPXTfGfB5BlTS9JSjXJwOB2SXOXjbVEO3C7q397AGrkDerQ9RUobxWgvGHn53BiVFKHFKdhH3hP1a5Puwa5RFnro6FZ24ukdcBBXTjT+qOFxnUkPM5iA==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by DU2PR07MB8378.eurprd07.prod.outlook.com (2603:10a6:10:2f1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20; Tue, 25 Jun
 2024 15:12:38 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:12:38 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Michal Simek <michal.simek@amd.com>
CC: "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>,
 "u-boot-board-maintainers@lists.denx.de"
 <u-boot-board-maintainers@lists.denx.de>
Subject: Re: [ANN] U-Boot v2024.07-rc5 released
Thread-Topic: [ANN] U-Boot v2024.07-rc5 released
Thread-Index: AQHaxm0FAqyE7DrRlkOEjCCn8HqPdLHYl1+A
Date: Tue, 25 Jun 2024 15:12:38 +0000
Message-ID: <e396268c-e106-4bb8-a40d-e0582e556c6b@cs-soprasteria.com>
References: <20240624193035.GK38804@bill-the-cat>
In-Reply-To: <20240624193035.GK38804@bill-the-cat>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|DU2PR07MB8378:EE_
x-ms-office365-filtering-correlation-id: 6003b312-3855-4d8c-feec-08dc95294028
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?YTFmUW1BN2tLVnIwQ0lFc0pYVjhtdmlIS3pzQm5YNUhSbmxFSXJLMTg0TStH?=
 =?utf-8?B?dGlMRE1UQ1NHajZWdXJscUUyUCtBVDA1ZU5Ya1FWT29iMy9ONXUrbDFXQmpR?=
 =?utf-8?B?T2xjV0ZacjcrR1BFR1hmaWptWWI2emwxQUsrUEkrZUJQTVpsUlo2MThEZkdq?=
 =?utf-8?B?c3lVUnNmNW9ZSmRZOXl1cW5WaXdFZUlwcm5vTFg3QjIyRVRqNk9BeVgwWEJY?=
 =?utf-8?B?aXYrTTlTZHozSExPQm5qYU1ZdXhib3kxRlZJOUNwMVFrOTJqM2lxYjAvOVNY?=
 =?utf-8?B?dis4STRoTCthZlhuZkxYTFcyMXFXc0o1VWFYd2I1T3NDZ2RRMzgzbVQ2UE9p?=
 =?utf-8?B?QXJpa2lpTTBRZ2tvekNHbEZiOTNQa2JENm1lUklFRTN0ZmREaVFVdHlpNmMw?=
 =?utf-8?B?N2lhRnBsYlNzUlJtWjErTElGWUV1bzVkN2NhT3F6cHBjU0RROWNGTzlWU2V3?=
 =?utf-8?B?QzU4ZEMzYzdHKzNFS1oyWHVTTVBldExxLzllM24wVzFyeUp0QldKb29WV09v?=
 =?utf-8?B?MG8xYXRZQnNWTWZpRnE4cFBBRGdlQnpjNU41WFBBODZ1cEk2QXg1T1BFY0hw?=
 =?utf-8?B?VHNwT0NBRnl6aUhyc3dRdXlCWWRzUlFNUm5VL3hLUWwzSGlLbmFLMk9aVzV3?=
 =?utf-8?B?T1FLWERWNjNVa2J3a2RIY3dHd0x6V1p6MVpaU1FKYjFjc2JjVmVvUXpkTTlr?=
 =?utf-8?B?ZU4zUmhrSCs3eWlzVG8ySTl0SHQvNmRyeENLS2NmMzRlVkNwTy9nYlFqK2I3?=
 =?utf-8?B?VWs5dFFiNDZ4MlAxd1FCdk1LcDUzZUt5Zk9UMmxBWVozK21aS1ltY0Q4WU5z?=
 =?utf-8?B?QzZFM3laY0NJc2FHMXJtbElXNjR1WE9PanczdDBGNGJ4TUNWY3dyemRSWTJ4?=
 =?utf-8?B?U2hhNFlsb3h2TDdCRXM0cHZMV1RDTThuaUpPS0xVYjBpNXpvc0licFlKdERm?=
 =?utf-8?B?dkZhTlc1bGNGVVBPZWpxdjdIdkRic1NlSURzNytRSFF1aGFEdGkvWm5SZzZD?=
 =?utf-8?B?bFZGTVBWMXB6bVVGbFdDazV2OWpPZlE5RmFKK1gvek1Ya0hFU2ljTk1FRGth?=
 =?utf-8?B?Y0xqNnR6Rmw1Nk5vL1BMMHV4MFdudWp3TXBHNVplb29qalVtZmF3S2sra25Z?=
 =?utf-8?B?WWRqcSt5cWhWYnNBVmNtSTFtandSUWdGdmNYNXdUc0VoVFhuQ1drREpGMFY5?=
 =?utf-8?B?SytSVjVzYzJDVjJDMG1jSWs0THZOQ1RFUUNWYll1b3BQTkhYMHZEWngxK25x?=
 =?utf-8?B?UVZGVGtDaXd4eTM4bFRiUG1DVGQ0ZExlOWVETTdSclZFMmNuN3JYYzFrUjEx?=
 =?utf-8?B?dlF0aEVsR25wZlc3K1JJd0J1UmQ2SCt4cGNFM2lWTnV6U3RvYmJTZnEzWGlx?=
 =?utf-8?B?ckMyRDAyUEM0ZVFsbHc5NnZZYjlPbzJ5bCtteHR4M1l1dm1IaExrZmlqeUpw?=
 =?utf-8?B?ektERkJYdndEZDNWWUJwMzhPR0YrYWV2ZjZGODM4NXdhUW43R01PbUFtZDhO?=
 =?utf-8?B?aExWNitQdTJvYzhLYnY5V0VBRE1FTnBGeDhuYjMvNEx4cHlveS9HMEVlWUEy?=
 =?utf-8?B?Z2h4aFh0cUxpWFlpMzRlVUZVWGIzSDFmYW5ldWZmMzVvVkZjT3J4TkwySzJJ?=
 =?utf-8?B?L2gybm84d3R5Y0luVXdMR2xTL0lDdEVobnprUGRkRThvUDZmRmcwMFI2dCsy?=
 =?utf-8?B?V1hlTjBhcUp3WlpKd2VvVGwyRk9ScmhWSVpjTUxkU0FxWVlOeExHeUE2UjBQ?=
 =?utf-8?B?TnRyY0l5cysxT1FCMjFPNkV2MWtERC9WUHcrbFMrRWg3QWtqU0NVOWl3UnhN?=
 =?utf-8?B?NTZGeUxobnBjQ2hJUHNramRmeGVnWXRRVVF2c0V6ME5vbk5HK2xmaVFHZHBS?=
 =?utf-8?B?Wk83OVhNSnkxWUZRWnVReFV4amwwR0pHL2N6MDRrRkNsbEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR07MB4962.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDdEUGRRak03S1ZyajlPYnR3VzExYUpBL0JWZ25ZS1FoYW9oeHhTOGRiWGpi?=
 =?utf-8?B?R0prVUxkVlZWYmNkWmFTYmNRQXhNRUsrSHBiYlBISytDQ2VxWkVURm5JUGFj?=
 =?utf-8?B?bVlDL0M0Uy9VSHQ1U2IyY3FvYlF6Wkg5R0UzamFRVXljQ2huWHFJQ1BsaFFM?=
 =?utf-8?B?ZEh4OTQ2empGWnBDRGI2SXRZQjdJOEE2T2RTSDVTL3dFdnZXbE9ITWNtOTdu?=
 =?utf-8?B?Vmx1MlQrREMwT0tQWFlyUVg0WXE1OGZTVm12ZFR2Mk9PbFA2bmhlSkRnUkRm?=
 =?utf-8?B?N2JYNzZnQ2ZuWkFPTk5oMjFBcTZoOXpUNENOZ2lEZjlCNVI4TXk2Z2pURnl3?=
 =?utf-8?B?eGs3VXJHR2xlM3NHa1lKbzIxVlhwdjNUN3RSWWEwbGRzRG1venYzL1Fmaks1?=
 =?utf-8?B?S01Ea1k0QTFkLzFkNXJlUk50eTVVZS84dDF6TzNYcXZBcDE0cldJL21XaXZR?=
 =?utf-8?B?V3BtVXZ1d3Y3MGhybHdBWko4Y1ZPOHgyYU80S1VZQjEvSkJPZjA1QkZqWEZt?=
 =?utf-8?B?Y1dHbnRiNlZsUXNUUjNERTdrbTFPaVpSMGd4N3JaT0Z5QitVN2c2RkQ5MTFz?=
 =?utf-8?B?eHRLOG5Deko0SVJjVnhNY1hXRGVwdVNyZkJ3L3dWZG0zRHMxZDNzTE9GNE15?=
 =?utf-8?B?dktDdWFQZmRRWmZxVkt2UndLdFlGTG9CNjVWZVBsbDdydklVWTBaZVlacUtL?=
 =?utf-8?B?VldxZEFYZHFnWHViRXQvUjBBUG4yYUVmMm9YMWYzMTJ3T0M2bHc3SmY5MGoz?=
 =?utf-8?B?cEY2SEx1UVZGQUhsaTd5d1RhWkthMDBqbHdVSU5DSXdldk0yRHplTXNEdVVR?=
 =?utf-8?B?MkxxZzMxbzBzK3RpUzU0czZZL0ZyZkRIUm9MOTJNWHRqT09IenA2Wkk0TFRR?=
 =?utf-8?B?V3pyUHVobHZjODBvekk0SXc3OWNQTmM5UitRK29uRVBOQ0dkVmczLzJGVW9o?=
 =?utf-8?B?RUg3V0FWZ1RYTit1dmczTm83ek8rM0FseFJ5Yk1Kc2J6Lzl6ZGQwQ3BKRElt?=
 =?utf-8?B?b1RHK1Y3UUl2Rkh3T1diVEI5UmNhK0phN3JUNHh3TS9BZVdpaTFJdnNZTmJL?=
 =?utf-8?B?Zmd5dWFxVXdiRm5EOXJleHdzQkJ2S0RrV2xWM25UV1hRNHAzblV6SXc1Wk9z?=
 =?utf-8?B?TEd6akNNNW50SWJ2WVFQOVl0b2p5ZVZrNnZvWkRYRHdscnBENEF4WVlKNlBG?=
 =?utf-8?B?WEtEVHZRTWdaek5MbHBMVWdyTTlCckdCamt3YzR5TG5MejRvQnpEcnNHQWJt?=
 =?utf-8?B?R2p3ZndnamJGOWhpK2VHbDVlbnl5ZGVyRjN6V2NFZmlVaTZaSytHSkVmSjdx?=
 =?utf-8?B?dnd2SGRVS3JNVnRJeG9YQ2NLUDl5MEJ2blVoNGdMTDJmQ2VSVUhZb2tKVXdW?=
 =?utf-8?B?OUZXRlZBQlZLNzliQnRpRGZSUDMxRzBaSE1zUEkvK2x6K05USWdLeUFRRm5Z?=
 =?utf-8?B?a1ZNY1g3bklEdTBSOEZ2cSt0anFhWTRRWmUyS010aWZWUit3bythdEt1QldN?=
 =?utf-8?B?NzRVQVQxV2JLUXA4UzNZVkZHZ0ZZU2RwbU1HallkdW1GcFZQWHBhazRwV29S?=
 =?utf-8?B?bWJWdmVYNmJheU83YXZ4NVg3L0lQVjVpcVptckpOcjdoWEIyT2NmbHNzb09R?=
 =?utf-8?B?S1hZdFdvbDFoZnBUUWN6SUllcWVtM2xpRXdqcDM1ZzQ5Y1FFTDB1U0tVVzlt?=
 =?utf-8?B?aVdpREZZWlhleCs5b3dRSEd4a1JPTlVEQkR4NXNmWUFhR3FlcE93UHhiM3cr?=
 =?utf-8?B?Z294c2xCeWJGRXZUVEpGS1RHeWk5Sy9UVUMySHV5V0lreHVQOFh3U0lZWk5h?=
 =?utf-8?B?WHZNTVZPSElNbmpneW4zNnBmMWVDSVkxRlhNamVkUVFYOXIzSnlxbzVZTGpG?=
 =?utf-8?B?K3BKQy9CUXVwWlBlOWRldDI3MC9qdnQ0ZVBMU2tzZFVKQXpwcUZvVHdWWHpP?=
 =?utf-8?B?cGtjWkcycHhkdDdPLzNTVXA5enV3Wk4wSjh4QThqRXJzZ0tzclBYOFVJVFFo?=
 =?utf-8?B?RW9CanZBT0tWazZsK3ErbGRUZXA5TE02NTFWQmNNK0tiRklJT0c3U0puRDNW?=
 =?utf-8?B?Nkh1Mk5uMUpWay9Vd3c5ZlRjaFVYMjB6U0hFYmFyNEY1UGkxUWZsV2pwZ0Mr?=
 =?utf-8?B?eXFjQ29wU0hiNVlTQXN5NFZKRTM4SUN5TmpCR3YzVVVtNlh4eTI2bk80SGVN?=
 =?utf-8?B?bjZta055Wnp0SWVMRi9mSFRQS05hUk1adndzd1I5cUZ5aWsvL0cvRG9zaHZG?=
 =?utf-8?Q?LoNy9vgW+Y/mWsoKPU6edXg7gt59lhl10s8RqmOSMk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B25C82F1887BD94FB35B3FA1152FA344@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6003b312-3855-4d8c-feec-08dc95294028
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 15:12:38.1975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngxfJml5c40ZID/1jOXVlqYUSh9SItSSy/3PlivPjuoY1HdS2bgxjS17qyB+xvbu/Y5jXwhTrDo0Y+CPkQ07XDpxzIveJ8pJUA8dGtrYvP8b5xPJgwi7aPlw1gmgVtLL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8378
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC: 
X-MS-Exchange-CrossPremises-originalclientipaddress: 2a01:e0a:511:aad0:9f10:86ad:5cd0:9703
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating; SFV:NSPM;
 SKIP:0; 
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DU2PR07MB8378.eurprd07.prod.outlook.com
X-Mailman-Approved-At: Wed, 26 Jun 2024 03:59:08 +0200
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

SGkgQWxsLA0KDQpMZSAyNC8wNi8yMDI0IMOgIDIxOjMwLCBUb20gUmluaSBhIMOpY3JpdMKgOg0K
PiBIZXkgYWxsLA0KPiANCj4gV2VsbCwgb25jZSBhZ2FpbiBJIG5lZWQgdG8gY2hlY2sgbXkgY2Fs
ZW5kZXIgcmVtaW5kZXJzIHNpbmNlLCB3aG9vcHMsDQo+IEknbSBhIHdlZWsgbGF0ZS4gVGhhdCBz
YWlkLCBsb29raW5nIGF0IHRoZSBsaXN0IG9mIGNoYW5nZXMgaW4gdGhpcw0KPiBzbGlnaHRseSBl
bG9uZ2F0ZWQgcGVyaW9kLCBJIHRoaW5rIGl0J3MgT0suIEF0IHRoaXMgcG9pbnQgd2UncmUgYSB3
ZWVrDQo+IG91dCBmcm9tIHRoZSByZWxlYXNlLCBzbyBpdCdzIHRpbWUgZm9yIGNsZWFyIGFuZCBv
YnZpb3VzIHJlZ3Jlc3Npb24NCj4gZml4ZXMuIElkZWFsbHkgb25lcyBpbnRyb2R1Y2VkIHRoaXMg
cmVsZWFzZSBjeWNsZSBzbyB0aGVyZSdzIGxlc3MNCj4gY2hhbmNlcyBvZiB1bmludGVuZGVkIHNp
ZGUtZWZmZWN0cy4NCj4gDQo+IEluIHRlcm1zIG9mIGEgY2hhbmdlbG9nLA0KPiBnaXQgbG9nIC0t
bWVyZ2VzIHYyMDI0LjA3LXJjNC4udjIwMjQuMDctcmM1DQo+IGNvbnRhaW5zIHdoYXQgSSd2ZSBw
dWxsZWQgYnV0IGFzIGFsd2F5cywgYmV0dGVyIFBSIG1lc3NhZ2VzIGFuZCB0YWdzDQo+IHdpbGwg
cHJvdmlkZSBiZXR0ZXIgcmVzdWx0cyBoZXJlLg0KPiANCj4gV2l0aCB0aGF0LCB0aGUgZmluYWwg
cmVsZWFzZSBpcyBwbGFubmVkIGZvciBNb25kYXksIEp1bHkgMXN0LCAyMDI0Lg0KPiBUaGFua3Mg
YWxsIQ0KPiANCg0KRm9yIHlvdXIgaW5mb3JtYXRpb24sIEkgaGF2ZSBzdGFydGVkIHRlc3Rpbmcg
djIwMjQuMDcgb24gbXkgcG93ZXJwYyANCmJvYXJkcyBpbiBvcGVyYXRpb25hbCBjb25kaXRpb24g
YW5kIEkgaGF2ZSBhIG1ham9yIHByb2JsZW0gOiBVLWJvb3QgDQpkb2Vzbid0IGdldCB0aGUgTGlu
dXgga2VybmVsIHN0YXJ0ZWQgYmVmb3JlIHRoZSB3YXRjaGRvZyBmaXJlcy4gSSBoYXZlIA0KdG8g
ZGlzYWJsZSB3YXRjaGRvZyB0byBnZXQgaXQgcnVubmluZy4NCg0KVGhpcyBwcm9ibGVtIGRvZXNu
J3Qgb2NjdXIgd2l0aCB2MjAyNC4wNC4NCg0KSSBiaXNlY3RlZCBpdCB0byBjb21taXQgMzQwZmRm
MTMwM2RjICgiemxpYjogUG9ydCBmaXggZm9yIENWRS0yMDE2LTk4NDEgDQp0byBVLUJvb3QiKSBh
bmQgSSBhbHNvIGNvbmZpcm0gdGhhdCB2MjAyNC4wNy1yYzUgd29ya3Mgd2VsbCB3aXRoIHRoYXQg
DQpjb21taXQgcmV2ZXJ0ZWQgb24gdG9wIG9mIGl0Lg0KDQpBbnkgaWRlYSBvZiB3aGF0IGlzIGdv
aW5nIHdyb25nIHdpdGggdGhhdCBjb21taXQgPw0KDQpDaHJpc3RvcGhlDQo=
