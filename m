Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A05E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 23:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E3383C19;
	Thu, 19 Feb 2026 00:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="r8l7P2RF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629FB83B99; Thu, 19 Feb 2026 00:02:42 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazolkn190130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d123::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B722E83A47
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 00:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOtKi8tU9MMd6DnEs/NRy+Q+k0JzfNtyEJA4iidee4EqQMWx3NCYK0E+1zWHJOWyGMkHRzFhGPUPKZdR72/IULKkDdEoXwO8lpLigoGlohXwVYtz7IXedw/0N71l0LxdL5CvRuD3CdCcJpGSmF848ybZDa5uKv+XXHHezpcuMEAcjMd6ST6YAqDnJUbgcW3KhdVul5zGBs5l92kGzHH5dwYlgBBzs7HGLesu00ys+pgakw+IruJ5ici7i3tF0khfI3nnVOk0fksrdegzbOPuDT88iSiUJ9t0VT6h52Ej14z7IcSucTUcjclBcfI1ZXu+qtWn2NN+9PfWIdU0ndtdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+PbGmLEMwOQ/7RNTRaJv12HPGpyURQzanTaemBGUe8=;
 b=RFjw0N8OdkkZZ5IXt7FSS03Q/b9/DTeGJXIuGx9aAX6Lyi9jRLayEKZ+YxR7u6LURZ1xwfFi8PmiAo6eBE2yuSrvDCMm/hl0FxFrTQbmNkDAKeT7m8ZMSUEgVzHPQw0UZtc9DHEd/QGuaFEUHG55eJ5YDn5iHIR5Lg/LcUPW55sEFjPF6yx+YnIlcXM/4UDWyuuF33q0G0habVXOWI3IHmH0jJ+lQBlqBh38ZVltZzTJz+iOHBblhUBr3rm7jobmiukyNBuIstoBmYIT8vGZjxOT4kNuull2ZRUPJSvKjRzd+GejKXGM30oxzJyG+Tn78UgjNH7x20kNLNShG6aBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+PbGmLEMwOQ/7RNTRaJv12HPGpyURQzanTaemBGUe8=;
 b=r8l7P2RF7kd/7r3A/ZONgp6IHW8PTZkLRUjlcTZVCIYzv4Yal9mjFfpPFwc/wj+4OiJfsxABS5gkW7xT3n2m8LDAgIMsAnvs/kI9UZy56zsHzOj4ORft6Zesoo/2ClJMLOiCIKwd+hrWhOx0MVXYnZ2wuXZyW20cP3DNlABb+1ch4UOuCklI4hbbipT57gxVTQ3KVBqTbCkuxn2ffjlsvDACYBxlhkDrOe/1Dg54btkyzT4v6WS7kqRGl3cHTdfH8Dvt3d7zI1uwsXpHIUf6oYY35n1aZtK7WCDVeiTnJb0SBjlx8/ymm0sJ0AFIdTiWp3xj23rvcKaZq6TbdVF4Gw==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by CO1PR19MB4952.namprd19.prod.outlook.com (2603:10b6:303:fa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 23:02:35 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::57b1:b92:26fc:c937]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::57b1:b92:26fc:c937%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 23:02:35 +0000
Date: Wed, 18 Feb 2026 17:02:27 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <SN6PR1901MB4654C67BCBEA987213F1922DA56AA@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20260213220927.GN2747538@bill-the-cat>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213220927.GN2747538@bill-the-cat>
X-ClientProxiedBy: SA1P222CA0032.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::13) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aZZFA5fqpaNK8Qqr@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|CO1PR19MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c6b181-a9f9-4fe7-3e20-08de6f41cd4b
X-MS-Exchange-SLBlob-MailProps: BG3AXrlrvvqUGicPe3cv7jfwYInysrE9/SC4y5eqSD/WxKWj7SliegjqHAMseDhAEyslBaQvgvW1omjggZv5EpUJ5otP0tc8Z3LbhB+ilfZZ0YlvYge6MXt8iSupLGu7PFypRKRyIh6hpqee3p5t+UcJFSbBmW5A3Z32P7lJ0qpTNSh7LDpn39KzZRiVfGd3x4AcSLwhFHjmz8KnN5okh3ml/CC21J+XXDljn1VYqLHu+13bN6MTkEbH2Xw3OhB786W+U1fIDBs85t1xKdWGYmx2GLKmFbjkaF+rOEaA6TV9P944bAXZGLg2Eep2d6+JixTAN813iq7MOcK1U8wNcrRmtzZfhrFhXCdpZWRVOPcJz2lpjeDkFTfRjMU3S9AVpj100NnvsR8P35ogZl9pcNbCphtzJB11OTMDJCfIjncOxsS+rno//zPjN5t920U+hWNn7JLenEpSfbTOZNEIcrbbRP9Tdl6Gizb5e6KZ/ZbspyuqJDkVj/tzaKQabBgwEk+FHqNuKCLjz5lQ7QwT+mvbHkEZ87FCSTovlZ6kXuY5EF4E5eI6jb+n8PQi9TN5bHfMWQPNogkFimxB65wzaXAtrAhYR1fPCdr26Y8dcfC4sW706UvA9NA8L86O+Ss4xqc21pSFBg9btOS/uv6Kl4ChRst0ThI0m42bC/nfys/p4XbWF2hJIcLUbIIFdnxp+jZUeH7wTgiCngzac6qtWzM8cgJYfVAAV8sclaNYlvHupsPZz3/7tCxi/B7wiAGoubG06UinO3RE2WDu+LYG6GRsI5m8OvvDFoPTGQOGAQ2HYDQEUIaHtA==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|39105399006|20031999003|23021999003|15080799012|41001999006|6090799003|461199028|5072599009|8060799015|40105399003|35041999009|440099028|10035399007|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUpNTnAwb3BtekNTYW1aNGtPMkNpaXB3ejBVZFhRUXZSbSt2MGs1VXY3TU5Y?=
 =?utf-8?B?QkdmcTVOSmhqNUorVFR0bjMrby9TRGlYdm1kS2lCbW16TytIN05BeXRjVlZB?=
 =?utf-8?B?RlhMVGdzaDdXQmRnR2N5VFVOVktIc0E5Wi8yWGc1MytLbSs2ek9aNklWQjV5?=
 =?utf-8?B?UUlIU0NORGxScXJ1bFFYZWs1Y1o5a3h4UmdwMElKSmJFZHpxeFpQb2xIZ1RP?=
 =?utf-8?B?anFOY2M3NDRpRjBYOFdzcmF0VUZDNzZYMDdSTUdiNFNnVDlRcjgweFMyQjBH?=
 =?utf-8?B?ajk5VExCQjUrVTJDUThULzhWL2M4WS9rMDB2RkdvYlNScDNDZ1BhcElCQ2FL?=
 =?utf-8?B?cFNOMmYvdnJWVVRHTTdZeXRhQXFQUjV6dllLZmY0NU1DejlsUEhZY2J3WlNn?=
 =?utf-8?B?R2UweXFKL2J1QkIwOFNKRnN3ZFBxR1JqK2FvTmd0WUFoZXk4VjlRN1h3Vzg0?=
 =?utf-8?B?M1B4ZDAvYnZlOUVEdWozdmlRZ3d4YTJGazdxVlZ2cjBrcGI2RUt2djN1eU1C?=
 =?utf-8?B?M1pWOEVsZ0ZxM1FnbkpDYTJDVS9sSVh2enhVVzBXWGNWNTBSSE1Gam0yRHVI?=
 =?utf-8?B?YTVwK2JjdjRKOTlHT0UxS2VsSW1mSEtwZDVPQnUvakoxczBidTNXMmc1ckEw?=
 =?utf-8?B?eHIvR0ZqUjU4S0xmbEEvT3habEJPNDBRWFB1YnB3enNwUW9KR2E2akhWQStW?=
 =?utf-8?B?eGR4LzJ5NTRwL0FIYmhUV2RRd3pNZVdkSC9BdXV2R0R2UUtWVUdtaE85dFM2?=
 =?utf-8?B?NWhiVk43Mkx6V25nZ2ZaTVpJZ1pIUVVnQTNENTBjUE53RTFUK29WaEhRWG1I?=
 =?utf-8?B?QXNBWW80eEk3bTRPMkV4anp4YXZOUFY3WUhIUUtNSFVKWWNySkM3cnlBTjZY?=
 =?utf-8?B?L2x0NUhuQm5BdENrQWRoM2ppTjg3OER1N3RxclVub0ZkY1hPMW9JbFJrQkV3?=
 =?utf-8?B?anpPSXRjeFdaYTU4WS9NcSs4ZWZqL25nVCttU2dPL3VXZkRsVVNabkVLMmgy?=
 =?utf-8?B?eVhzcWFLcWoySWM2dmthN2NnSU93ZG93THhaTDdFN0J4SytMQnR5dEkrREdD?=
 =?utf-8?B?OG9hd3Z1b1pLVXI1ZFBEdXlKTVZGRk1zTmc4YTR3WHVCeGVBTlZYTDhhc1RV?=
 =?utf-8?B?WmdYSDRGZTkyNjlKdDV4amVaQmJXTjU3ZTJkdHZ6K3FJWFUvL3A5anA4SVpH?=
 =?utf-8?B?VWdqMXlIS09WWklYb0dMUk1oaDg1L3NPaGJGTVN1cW9YS0tUMXFZTW1DdXBj?=
 =?utf-8?B?aGIzUFZEeE94UWloK0grU3dmYlh1OVVDL0Z3YUxPeUhFSk45VDJISTU5M3FE?=
 =?utf-8?B?MUVxSDk3T2tKZWxRSTZhdzlibEcyQTJOSTNsRWRQWkFhNmJrODBYOXRvdGpZ?=
 =?utf-8?B?ZURKRlZIZDk2Q2lGRUVVSnBSSDk4eUFzdzRXSExZVmc3V1IxWlQ3OTJ2MVEx?=
 =?utf-8?B?VGlYNFlVdGxnYlJZbjRidzZSdGpnTEJsMVgrTGFWTmRpRW52MEdNL2I0U2pW?=
 =?utf-8?B?Z0x6MTJ5YWplQ0wydE9zSzJia2lGdUc5Ui81eW9oQm9IREVhRkpRQXAxWFNC?=
 =?utf-8?B?eHpVcFJmaWhjV0JKemcvZTBuVUNiV3BuYVBYS2l2bmREOEU2WUhIL3I3Nld3?=
 =?utf-8?B?TjY5cDFaVlJyOXlUZkdqbldiMG5CTVlHVEx2dmRyMy8vREU3L1EwZ2kxVmRw?=
 =?utf-8?B?T3FkMHZvNTNPOVpEa0V5WTVPVHROYWE1RU9YdENNMUh1M2YxbFA0WHBnd0lC?=
 =?utf-8?B?WGJXbmUyL1BVMzR5WnpGWFVFckF6ZFJ6KzVXckN5cXFjNWd2RzllOUtnemlS?=
 =?utf-8?B?ZXZnK0FKa25yYlI2RjYwTm8yYXh2QUg1emVRaHU0bStnNXcwQmthQU02QWJ4?=
 =?utf-8?Q?dv/DwgwoUPOtJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklZWXNKb2FvRjJSUVZ0cyt2VEUrNlNaV1Y2K0w3a2trZVQzdnZtNlZQNmRB?=
 =?utf-8?B?blRsWWtKZ25CNkE0dmpMOHIvejVoYWY3eDlPMG50Z1NYNlM3U0YvZnF1VHE2?=
 =?utf-8?B?a1FRNkNjNzliMDIyRGdER2R4M1B0RmxJTnlHd0lmRU9HSStFckJicEZ3cUFr?=
 =?utf-8?B?OEJWRlJ4TUNVN1ZBbTN6d2dETjRJTzJscXMxOEdBRjlqTEdHRmE5TmYzRzEv?=
 =?utf-8?B?WU5jbkdmMTBkcGFlN3lTME5MaXB5TWJpclVES3hoeWRwMWVuRVZlMmlEN3Rr?=
 =?utf-8?B?TGs1b3pmQ2RQbG5ybGhYZ2ZtSy9Rai9SejcwdFZXZVRoQVBIRWN4TzdrSnU0?=
 =?utf-8?B?dmlaUWJ3dDRFdEVLdlM0bTQ4K1BxeVBDNEJSYlkvWTkyYkNaNDNXbHlaOUN5?=
 =?utf-8?B?YjU3bVdUN2FWSHpjWUpSY05CWVBvY0Q4L0JYSDJCS2RYNGJQcm9yZkZJSFk4?=
 =?utf-8?B?NjJ1UXFQdTA4WWZOcjFqV0NKRVlWR0lIRGFCNThkdTNpbUZsSExaVkc5NUU5?=
 =?utf-8?B?RGFrSWtiemptM1MrMGJjRnplb08yaFRCczRRZnE5Skw1dWpJVUFhYzRjcmh4?=
 =?utf-8?B?RkhZd0g4aXArcElldkFrV1pvSExBSFhYTUdhK0tsdXN5STNPL251NXhwejkv?=
 =?utf-8?B?enl4cGUvNGo5VE0zYWhTZXNmZlJjdllvamkzTTlldUFvRm1nbUU2TzdiOUxx?=
 =?utf-8?B?UE95M1E4VWxqNTViTDNLTERIK29HUjdYSkdIZU80K1NCd1Z2cXZSdFdxcS9l?=
 =?utf-8?B?bXhQcVNWVVM3c0x3SFAzclZscm9qWFRZWFdaWFMzSmdCYnQvQnRIYVZrYk51?=
 =?utf-8?B?SFpxb3kvUmppRnpPQnEzTmMyMFkvWXBoSmtibGxuYUpsOFN0VTRsNDBJV3Nk?=
 =?utf-8?B?bEc3eS9nSTEyOTFPQjNWVGNKSGo0TjBqOXBJY2dCTk41Qyt5b2NReWd5MVAr?=
 =?utf-8?B?K3BJdGtUdjhvZWoxV2Q0MXJnMStzdUExbm5CNFNTQitqK0tNSzlCSlVzU2dn?=
 =?utf-8?B?cXBQdmdVTUxMWkJ6U254bStYb2ZlYkY4bXVxQ2VnbWRTSXNiWWNDY1JJN3h1?=
 =?utf-8?B?M2dPYlBQaitWQ0g3ZzFvMEoydVhZbkJqYW5BYzdFUC9LNHFweisrQmlzSTJy?=
 =?utf-8?B?VGFaVU1QWFN2L09NYnpYaG1sT0duTW10K2YvaUdjQTd3R2dRNVRrc3ZvT3Y5?=
 =?utf-8?B?dnozV0pyWUlTdDJTaWZUdU1JV3VjcWRLdHhXT3FJYXFyWGNEWVBoRjM0dHVD?=
 =?utf-8?B?aXdVUXdOSW9TeDFpRTRoKzRzWW93cXl3T1RaUkNPdEt5YnpTdnplMEZKdCtD?=
 =?utf-8?B?ekl4NzlUelhHN1ZPcjlrMG1VVGpneXJQTFFUaEdHQ25BSVVFVytsL0hsSmJk?=
 =?utf-8?B?MTZtQlA2NWl3eWk1OGk5azlvenFsbXpkbTBYbzR0ZzVOU1VaVUozaGU1UFl2?=
 =?utf-8?B?dHRjcHl1K0xJSXJJSUFMVDlINW9mcXdYWitSL1FhZDcybWx6MVNET0FCWm1o?=
 =?utf-8?B?N0ppMytJeWo1YmdkSEdLYnBpM21EMTlEWWFMYzMvS09uMkNtRnYwek04clNa?=
 =?utf-8?B?cUJqOHR3eWdXZUpKcWlBTm4zbjM3WG5SUC82MG5QeE5XYzErMk5TRjNMZlF3?=
 =?utf-8?B?L3dLZ2tVT3VBZTN0NTd0QUpmT3NneldobHZZY2ZoUElXTVlISWo0SEZXaGdy?=
 =?utf-8?B?SVNuZGZTY085TjlGa0hTVlpienQwaS9ldGQrM21zL0k0TUxqRE1SbThjWStQ?=
 =?utf-8?B?ZldZUG9zT1JlMlErRFZPTDN2VmliNldZL3VveGlQRlZwSXdmRElUTmtXV0JO?=
 =?utf-8?B?d2hXMnMyV3BrQWZWWnlnSVBYRXJkS0RDTklNMzE5NFVoVnVPTjYvcWtVTC9x?=
 =?utf-8?B?bEZlZWZBMEFJcytreDFtYS85N0ZubTlZcExZWGNpZmE0V1E9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-6f20a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c6b181-a9f9-4fe7-3e20-08de6f41cd4b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 23:02:35.6859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4952
X-Mailman-Approved-At: Thu, 19 Feb 2026 00:14:34 +0100
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

On Fri, Feb 13, 2026 at 04:09:27PM -0600, Tom Rini wrote:
> Latest Coverity Scan report, now that it's back up and so a little out
> of sync with the usual schedule.
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Fri, Feb 13, 2026 at 4:03 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
> 
>    - *New Defects Found:* 1
>    - 2 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 1 of 1 defect(s)
> 
> Defect Details
> 
> ** CID 328330:       Integer handling issues  (NO_EFFECT)
> /drivers/usb/dwc3/core.c: 106           in dwc3_core_soft_reset()
> 
> 
> _____________________________________________________________________________________________
> *** CID 328330:         Integer handling issues  (NO_EFFECT)
> /drivers/usb/dwc3/core.c: 106             in dwc3_core_soft_reset()
> 100     done:
> 101     	/*
> 102     	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
> 103     	 * is cleared, we must wait at least 50ms before accessing the PHY
> 104     	 * domain (synchronization delay).
> 105     	 */
> >>>     CID 328330:         Integer handling issues  (NO_EFFECT)
> >>>     This greater-than-or-equal-to-zero comparison of an unsigned value is always true. "dwc->revision >= 0U".
> 106     	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
> 107     		mdelay(50);
> 108
> 109     	return 0;
> 110     }
> 111
> 
> 
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=overview>
> 
> Best regards,
> 
> The Coverity Scan Admin Team
> 
> ----- End forwarded message -----
> 
> -- 
> Tom

I'm not *entirely* sure what to do to fix this issue, but it looks
like maybe the issue is that all we're trying to do here is make sure
that the version is DWC31_REVISION_180A or earlier, and this is done in
mainline by checking between revisions _ANY and revisions _180A
(instead of creating a new macro). Since the DWC31_REVISION_ANY is set
as 0 this means that condition will always evaluate as true. In this
case though that's fine, because all we really care about is if the
second condition of the macro is true (whether or not we are equal to
or less than revision _180A).

I copied this stuff directly out of the mainline Linux driver so as to
maintain some semblance of parity (and because I needed the stuff that
used this specific macro for gadget mode), however it looks like to stop
this Coverity error I need to create a new macro, possibly a
DWC3_VER_IS_AFTER() macro. Or is it simply fine to say that I
acknowledge the issue, but given the context don't think it's an issue
if the comparison to zero always returns true because it's just a reused
macro with two conditions and we only care about the second condition?

Thank you,
Chris
