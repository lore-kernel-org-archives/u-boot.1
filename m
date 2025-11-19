Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A921ECF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E09683F50;
	Wed, 19 Nov 2025 16:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="RzEu1Z1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 697A583F62; Wed, 19 Nov 2025 16:18:58 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5388783EF9
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5LY5lZidtz0QcFWLT6f9tCGpyHcXweXlpcSY6NTkOBM4RaA1eEzrXakao0eXA7tfnOvfNdCNpKE/z9XkmAZRAqFekQifBdtPRrFlZeZR9ujULeS1Zjyor6eREuuet/4gAlo1FsWtEXcJnbVDwnkJXGqLF2Y14ANx/3QBAdj/Wc/2fTycY5YG0MhwQ0YvqGGrZwL08i5Lbuqq2QUHqhmMnaW9Up3HlTeD1lf/AhMKdz1t0rhIHJYRra2KCJvAIG8bMX0ZyqGUD2+hWOqy9PSBg5zBRTOK6ERTc3fI8CCpcspPCrgMbukb0rs/95zccI7Zgty7Bgx26PZTyCPa/k0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsJKnFhSI+/ESX76Va/t5WF1kL/Im9Z0ti8SHHzHYSw=;
 b=oL5+ksU6XUSqYtde5xjVhbxOs0gsbiP8yCTXI51zzkZ1d3txcsRURbK5TLufTDCuAAet6PVTUIMBP/9PhroEJtw3bQwe2N0F4uqzaysk603uN92yMkNd8/13Qo/u6nrx1wgro47yUFbB0COS/N5ZOIxAEqco8X5/dwgh0MVtE6lF6X7ShaKtN5nbNoN4opFw2kPcBQbXjPpHezdNjpmbwNc/rS2tXhrwjkB49lOT9ZWMxAOFkW23ctuKdnrlCiHPp3bf8NMhEFAv2AWb4/eoKQxAy0I7Su2QqJzU1Kpuoix7hGWKV1s3m6mKbXkwOXtaMVQ3x/HeE+tSWPLKH62hMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsJKnFhSI+/ESX76Va/t5WF1kL/Im9Z0ti8SHHzHYSw=;
 b=RzEu1Z1S7IMxFqIaVdVPm5EbpbjK1zO+93tK3ojX4mjP7oSQP4yuwpYKyrrMQREQch7vL7mfMsC5OtTgSZjHi2Do6G4q85Rpwo6GCkZ0MDAQm03a4NzETvxRJXS7f/MUuTB3Co+byIw/fjZgmtE4jBT+pvJuhLKZa8wAoDln1kfcsdAf+65CyYlxckZZVJEKNtSTBozffqETcWvJszNV9ZAO2iANshohSZIkIZx+1QTL53ObTTh9J+WOau4GzSRSHamhrOUrFAOmE9HNOsKEgu97HLELQwdxkGT8b7QMAN1jAAFgUmdKICDsCa942Nkan276cfJQXWZocy9Fmv3TiQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB3981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:18:54 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:18:54 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "hs@nabladev.com" <hs@nabladev.com>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>
Subject: Re: [PATCH] capricorn: Stop disabling device tree relocation
Thread-Topic: [PATCH] capricorn: Stop disabling device tree relocation
Thread-Index: AQHcWWPdmzrU535KLkC1UE9JiKmfj7T6HNSA
Date: Wed, 19 Nov 2025 15:18:53 +0000
Message-ID: <6215a48464a7d163e517f610670c928dfa6ed40e.camel@siemens.com>
References: <20251119145025.842054-1-trini@konsulko.com>
In-Reply-To: <20251119145025.842054-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB3981:EE_
x-ms-office365-filtering-correlation-id: 602f35c2-78c9-41c2-dbe4-08de277ef3bc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?c2NGT2R1QjhBeVE4R1ZHZjRUU1RJdldKa0NrbkkrSWc4ajR1RktvRExaL0Nh?=
 =?utf-8?B?QXhvRGl6dUY4OW96cDd4NVRSTjFQeEZza1VjNFhVMTYycXRnbnY2cktkanQr?=
 =?utf-8?B?L3Rna2xMamxmeTEwcUlDbE50R0FpVWNXOUJUd2tXU0U1M3ZVdGlpR1ZUUmFO?=
 =?utf-8?B?U001M091RSsranZyVUVNQXphUUJzeFZpcmFaUU9zUzVrWmNmaWFnR2d5Zk1z?=
 =?utf-8?B?dUM3MWZVTkhEMjY5cFVBRzhESy9Gc1dhcEE0REhRMnYwUDMvZUxwZmVkSnZ0?=
 =?utf-8?B?OXJoQWRETitZRHNmNStITWUrbmJuaHYvRUZJTWk0b2taNUJjcjYrdDljMEt0?=
 =?utf-8?B?M2c4T2hONEpRdG4vTTRWTHVIWXZqVmMwcXdMaXBmbS8zcnRaN1pOVm9NWVB0?=
 =?utf-8?B?cFN3YjBsVG5veGJJU1dLUWhBMUZCQjJkOHdlcm9iSDV6TzJLYzVabUFreHFI?=
 =?utf-8?B?bnc4TklDcEt6Z040ZCtLVFByK2RzM3BqQ2h5c3Q1QkxIV2xWWWVhMkJpak5M?=
 =?utf-8?B?S2FqWUcxVVR3ODk1YVM3SG5VZHF1VkdmUHY3cGRDZWxjOG9LVTcwYUVvSE4v?=
 =?utf-8?B?ZFpoRnFIVnUyYVo0UmkvRnpEZjBwS1RzR3ZYTXU3cmtFN0d3dzJERjJOMngv?=
 =?utf-8?B?VEtNY2V1anh0RHM3V2NLTWs4UzFLOGN4K0ZXMytrcUloSVF2UGVmNVFWalN1?=
 =?utf-8?B?NUswbzB1dEdZTGRBcVVUZU9aY09zWTRnV3dWTmtKbHlZOVN5ZWJjOS9JWnhV?=
 =?utf-8?B?NXZaT2pkSExRRTFsTkRMNkpxWG9rSXIwTmprTDlkc05Pak4xUTBpY1NuZTN5?=
 =?utf-8?B?bmlteDFSY0JXeW03U3oyQUt6RHh4cDcvUDVYbzFLeHgyOVB1bTVWZE9JZHJW?=
 =?utf-8?B?aXUrYUIvTjRFNjJkNC91TmwrdFNva24vbHlZaVQxVWpxQktWZ2dwNExBaVpG?=
 =?utf-8?B?MDFtQldDenJpSFpZazd0bUcyb0dDdDk1K2Z6T1Nra05PUFlWYnFwZ003K1pt?=
 =?utf-8?B?K3ZSSzFEdDB3QUpCWEVaUUZxbU1qL2JLSmhENlNnaXdVd20yTERicHVoRkZj?=
 =?utf-8?B?T0liZkZCbzRIOTVkdVpBRFN3TWpXcFpHRkpXajZJbUZLSEZ6dCtPMTBRamkv?=
 =?utf-8?B?Wk5YS2Q4VVl3dk9UdjhmZmVTT2t2NTZLQ1pNUGxDZkFKMjFlNHo4MmhnVDhx?=
 =?utf-8?B?MWVFYVZhZUQxQjNpRzlvbjNpVlRBWHd4enRjU0ZqejJoNFFjUEVQOTNyMzBo?=
 =?utf-8?B?M1VpYVpLZTJsZzJwa0VtTWhYUCtIMnFsRjVMcHJ2RFBaNkpIb2VsZ2dDVzNu?=
 =?utf-8?B?U1N0VmRwbUFIdDFpbzZpdWRJMU9SeWFjakt1TkNZOXE5cnc2TC9TeXV2blhG?=
 =?utf-8?B?QzlhVE9OWWloSlovNlBIc251RDU2TCtVSzg3b3N1cE5BSWFDTUxJdDF6dzIx?=
 =?utf-8?B?WDJTRG1LeHJFSEN0MVVFbUpJRU9BQWJ5VVlGYTBkOHd0UUFkQkdURTRCRDN4?=
 =?utf-8?B?ZkkvOWZkaWZucUpBRFpDRGczTndkYVBUbFlWMTNEOGlPWXlZWHZmTmYwN1Iy?=
 =?utf-8?B?SE5IYW1OZVpQeTQ0VFpOTEFsbnZiMkoyOVJWdE96TGRHZDV0VEQ0cFA5UHVk?=
 =?utf-8?B?Uk02WlcydXVITWdGU2hqTjNwRVVud2ptcE9oS3E4VWhablpFa3hTNE9lMS9s?=
 =?utf-8?B?WUxqUjdLUmF2VWhqdVBBMlUrRXAzYU1aRDNrWlBlWGt4RG9YanpWR0crcVdO?=
 =?utf-8?B?Um5iM0Y3WHNQSlQ4c3dOTXh1Wi91bFlYWnVLTXE2NTllYlJYQllmSmlGNHpw?=
 =?utf-8?B?Tm15Z3EzVERzeHdtcnpwQ3VpeVpzNldFQlVoc1FMQkFBcHM3SGtPcG50Q2Na?=
 =?utf-8?B?UWRVajVjczk5SHdBU0tuSCtpcGxRSHFaMnNrbW1MdUxDK1NqUTI1c0pXR0Yw?=
 =?utf-8?B?UGh6TEp1MGp1UUZmaTNROEtxWlJTb0wxTE4ycUZ3NWY4N0NDcWZackpWeFY4?=
 =?utf-8?B?aGVWb0pRdkdvdFpNdFB6Y1p4UTJPRXpyY2NyTUEzNEJWbGdXTzJDbG5ycWRn?=
 =?utf-8?Q?Fyw2GP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0NSaThVM3lnd1p6M0owYUNnUDZoeGpsd3RPU29TaFpuNHJiSTduZWlBV1Bi?=
 =?utf-8?B?ODVqTmFnTjVIOVR0NXpvYWhCVmFZUkRldzRtU1lra014amxsWHBxQWR4VVVr?=
 =?utf-8?B?c3REMUljaFNjTHhZZWhrV1BPVllGT2h5UHB4SnNjTGQrd1dTd2RWaEJsRkt3?=
 =?utf-8?B?WlJRbjlJai9kNTB3M0hGUUpyd3BIYVQ3TksvMTM4MXBicVhMd003THdlTlpX?=
 =?utf-8?B?cTd3UDAramVCcjFsMndubTNKMlFmbktpM0FpY3d0c1VHdGVsQzdzOXdOM2dV?=
 =?utf-8?B?SlFGZnMvb0V0MWhYak1CWENQY3pmdGRIVitKbVBRVm5tNkRjRnl1SHIxYnpk?=
 =?utf-8?B?Z1pGOWJVZGNRYmNnUEw5dm9hN2pwT2pFWllpVlY2RkFYR2ExQStKSUxFblNK?=
 =?utf-8?B?RlUyVGpqbi9KeFMzbVhNcVVSQVRYaTlzam5jVU5xU3BQbmVScG45a1JNZFlm?=
 =?utf-8?B?SWZNemkvemlCODd4WUEzZTFJNHJEekZ1Y0dtVmlrc1V6WE55OGlHYXczQUpG?=
 =?utf-8?B?S1RDUjBmTnFZS1B4UlJhUUNoaC9TQmNZSjkwK0xaTHZaQXpZWXExNGduRWp6?=
 =?utf-8?B?YjkyUXRZZFA2T3JWVXNYRUNaWXhycDB5S0xWREx0Y2RtKytXdHQ3dmUxc25z?=
 =?utf-8?B?dEpNSWxFM0FYK09sUlpkcEdxQlFaRzlqcHVvWWNRVlpiamx4V2JCK05TQXdM?=
 =?utf-8?B?UGtaTnFJM05uVHpHM3lKT0RmTnp2SW9zZ2hTOUNKNFYwYTVWTkNNSVNIWE1s?=
 =?utf-8?B?c0RlU29zTXRraWc5d0lvS3dHSGVYclRlekl2aEpaY3FZekF1MFFydWFJM2p3?=
 =?utf-8?B?Rks2azJKcE5yVlJxbDVZNXpaNVU4QS9Samh1eWlndVJFNnZxbW1lQUkxN1BJ?=
 =?utf-8?B?a2FjQ2J5djBOV0ZXWWthUFl2OTRZM3hnTTQzVTgzaFdhdXRaTU8zbm5SS3Ni?=
 =?utf-8?B?aXBqK0RsQUp5clR5ZW1oZTIxajV4Mml4YXI3N2FlbDMrcEtIVXlScGp3VHhW?=
 =?utf-8?B?U2RMTXA0N0JaZEZiY2VFc1hyTmY0T0xVd1ppZ0FXaFhBOUpwNG1tQ05TbFBm?=
 =?utf-8?B?MzBFNmtmNXZnbDNVci9pcEdpQjFta0lEOUVvcjJGc0xXT1E5Q1ZQQjRXZkox?=
 =?utf-8?B?anNpWDV6bi9qaGFDRFJOeEI3bUxYS0JtTzBwZHlXYmt3Ui9tM0Q5KzNJK1A0?=
 =?utf-8?B?RUpaeFZ0Q2hZc0lLNHhFWFlYZVBEajg5M3YvdVl3MEJ5ZElna0taTzM5dlpM?=
 =?utf-8?B?VWlCSU9jV0kyWFJHQ2xPRSs2aW02Z0FqRWZrOXpiNTFJR3JZdmJTSWJnVVQr?=
 =?utf-8?B?cFVNVFIrQzRPZklGVmo4SW5HNEFYM3loaG5QNVA5Z1loV05sOXR5V0E0RE1Y?=
 =?utf-8?B?blp0TnBOckFMaTB5L0ZIN0Y5bkt1cHFjbm45T3pZSlc1RFpBNTNPUXR6L0Zj?=
 =?utf-8?B?M0tieFVBUVVMbjVJQks4dVVTbjBpSkdBbnRJdTZCMzAxQmxNa2Z6N0xmcjRu?=
 =?utf-8?B?OHFXOWhVTGRxaURiTGZwLytKYndIaHl4enBtby9MWjR4ZGsyRkk3aXp1V1d0?=
 =?utf-8?B?MlY2U29BUVRQWUorWitHT21YOEF3OGF1SSt6b0RmSkFkWUdlY2tXL2hZeG92?=
 =?utf-8?B?QlBYL2d6Mm9qalludFUzbDVsUXdLTFhKbFA1aE9CdHJEQ2NkeHh3M3FCWUNS?=
 =?utf-8?B?bXluWi9JbE1WRm5QcXJKNzZYOTVkYmgrTE10ME1TSkZzeERHd0ozYi9XU3dG?=
 =?utf-8?B?YjIrczNLblh3ZmIxM3hWeG1XUkhwVDZGbDZXa2dPU21TZnhxYzhrVEsvYXV3?=
 =?utf-8?B?Vzdwb1RyazdtYmlNSDF6bFpyWjFiV3kxU3ZuL3kvRW0vRjZESmgxVDBsQjBZ?=
 =?utf-8?B?aXczbW9XbXQ4R2lCbzNnQ1Z3bGd4L2liZE9Ba2dsc0JWKytzc2c5dk4wVk1n?=
 =?utf-8?B?OHFPai9oclh1TThsL2NUSitWMkJQTFhWd1UwcElETyt2SGpEcnpxcnVTMk1B?=
 =?utf-8?B?WDZJckt6b0wxMU9PcW5COVE3b0NuSmtsZi9ydWt4RnNxQ2lGb2FyaEFkNkJ1?=
 =?utf-8?B?Q3ZRYmxya0J6QWlKSXpFMlJUczZoR2VQVnVWam82SmxXUW9LdlkxcUc5Q3VE?=
 =?utf-8?B?bGZQczRoazROd0l2eU1Ga3M3dGk3MFZwOVdCVlRtRC9sZ2ZINDNTMW94bnRo?=
 =?utf-8?Q?575dM6NcG9HchJmIo8smhxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5309080BC7A89242B45995934EB2E574@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 602f35c2-78c9-41c2-dbe4-08de277ef3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:18:54.1305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSLIkUr9ipvK2MkFfdCH1NTO/It5AIbt9QdBNoFIFU55dK/xyqIYZzBjxGdo85MQ9X5kTdgWlRa1WRRGiCXkW6foz53Mf26CivKk/UBmzWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3981
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

SGkgVG9tIQ0KDQpPbiBXZWQsIDIwMjUtMTEtMTkgYXQgMDg6NTAgLTA2MDAsIFRvbSBSaW5pIHdy
b3RlOg0KPiBSZW1vdmUgc2V0dGluZyBvZiBmZHRfaGlnaCB0byB+MCwgd2hpY2ggZGlzYWJsZXMg
ZGV2aWNlIHRyZWUgcmVsb2NhdGlvbiwNCj4gZnJvbSB0aGUgZGVmYXVsdCBlbnZpcm9ubWVudC4g
RG9pbmcgc28gcHJldmVudHMgVS1Cb290IGZyb20gY29ycmVjdGluZw0KPiBwcm9ibGVtcyBzdWNo
IGFzIGhhdmluZyBhbiB1bmFsaWduZWQgZGV2aWNlIHRyZWUgYW5kIGxlYWRzIHRvIHZhcmlvdXMN
Cj4gZmFpbHVyZSBtb2RlcyBpbiB0aGUgT1MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUb20gUmlu
aSA8dHJpbmlAa29uc3Vsa28uY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGlu
IDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IElmIHRoZXJlIGlz
IHNvbWUgd2luZG93IG9mIG1lbW9yeSB0aGF0IG11c3QgYmUgdXNlZCBmb3Igd2hlcmUgdGhlIGRl
dmljZQ0KPiB0cmVlIGlzIHJlbG9jYXRlZCB0bywgYm9vdG1fbG93ICsgYm9vdG1fc2l6ZSAob3Ig
b2Z0ZW4ganVzdCBib290bV9zaXplKQ0KPiBvciBib290bV9tYXBzaXplIGFyZSB0aGUgY29ycmVj
dCB3YXkgZG8gdGhpcy4gUGxlYXNlIHNlZQ0KPiBkb2MvdXNhZ2UvZW52aXJvbm1lbnQucnN0IGZv
ciBtb3JlIGRldGFpbHMuDQo+IA0KPiBDYzogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIu
c3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IENjOiBIZWlrbyBTY2hvY2hlciA8aHNAbmFibGFkZXYu
Y29tPg0KPiBDYzogV2FsdGVyIFNjaHdlaXplciA8d2FsdGVyLnNjaHdlaXplckBzaWVtZW5zLmNv
bT4NCj4gLS0tDQo+IMKgYm9hcmQvc2llbWVucy9jYXByaWNvcm4vY2Fwcmljb3JuX2RlZmF1bHQu
ZW52IHwgMSAtDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ib2FyZC9zaWVtZW5zL2NhcHJpY29ybi9jYXByaWNvcm5fZGVmYXVsdC5lbnYgYi9i
b2FyZC9zaWVtZW5zL2NhcHJpY29ybi9jYXByaWNvcm5fZGVmYXVsdC5lbnYNCj4gaW5kZXggNGMy
NmU5ZDQzZWI1Li5jOGI1YjNkN2RhMzQgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3NpZW1lbnMvY2Fw
cmljb3JuL2NhcHJpY29ybl9kZWZhdWx0LmVudg0KPiArKysgYi9ib2FyZC9zaWVtZW5zL2NhcHJp
Y29ybi9jYXByaWNvcm5fZGVmYXVsdC5lbnYNCj4gQEAgLTExLDcgKzExLDYgQEAgY29uc29sZT10
dHlMUDINCj4gwqBkdGJfbmFtZV9kZWZhdWx0PWRlZmF1bHQNCj4gwqBldGhwcmltZT1ldGgxDQo+
IMKgZmR0X2FkZHI9MHg4MzAwMDAwMA0KPiAtZmR0X2hpZ2g9MHhmZmZmZmZmZmZmZmZmZmZmDQo+
IMKgZmxhc2hfc2VsZj1ydW4gbW1jX2Jvb3QNCj4gwqBmbGFzaF9zZWxmX3Rlc3Q9c2V0ZW52IHRl
c3RhcmdzIHRlc3QgbG9nbGV2ZWw9MyBzeXN0ZW1kLnVuaXQ9dGVzdC50YXJnZXQ7IHJ1biBtbWNf
Ym9vdA0KPiDCoGhvc3RuYW1lPWNhcHJpY29ybg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0K
U2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
