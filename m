Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BB1CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 09:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F17CE832BC;
	Wed, 22 Oct 2025 11:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W40Ehobc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D2C83303; Wed, 22 Oct 2025 11:28:21 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 412238323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 11:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRs+N8ijDa6Qo9JsMOoabmDigCEb+hUP9Lbn8MgGo0IiwunhCK+lp7+uCN/ykPD6EA/KTlVoCYV4r8IMa7LJ6O9mXvcCcE2kSkLctaPng2/q901dG3LLXI+hoV0jzAoQ737e2syaSkoNEbQzjVZtMAkKnMvKqZhnxwoqInbzcEv0QGqRjawvZzDJ4llwe6IF855h+bWBBHWjHZ7M8n4fswL4XWV6XRDgo/e/gZwHqq06M3Y9hTtM004TjLDpsl3n7flL0PUfvQ1N1RF8EkqsVFNpVvpav8HCi2gfOW19RqCXnN6+a4oqImcyceducbrB4JL133yWq6vK3ga5JdRrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+XEX364vMjJFgBTKnSMEFvtSny5xvMsObc1fFyK3lk=;
 b=vHE0hfD4ycIiCGr3BDp8r2B6nJ82TRx4T6HSMgMUKX3djK+JA25yTWBsqVVv7lj3VrIk50nprtvNd3ndtA+MRUmvde1UMPfFw5hkciv5xTWxjKHIzZ0N3KK4M//+hSkZALMnRpWA0K+2/qyaebKt7YWDVeLrjvy+53x8WX9cU7sNRNJRi7ZEsslBpN05b/GwmT5yewW18bAkBYHPdT0NqGYrutuV4D6w0NSqNG7VYRuBh1gXSJ71zVodJQhSfwRPSom032BST9UFc/B1nHK1xIHuG3LFsGhxczpj7myvcJK/UZftFhaHav6+oxS28V29v/veGqkycop4xSK0KxwGNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+XEX364vMjJFgBTKnSMEFvtSny5xvMsObc1fFyK3lk=;
 b=W40Ehobc1kKdvxs6tdtB7hBFqF/z4/72s9F+trv2DfiOLvxoVWWxaB2KN8NAiM8lG6ZipumIPPDCf92D0V8gBlmIOApOQw9ZmDl4cIgASmGm4Lj+6P2zq3XC9Jx2tjcUNVBB5wBIVJSSWFCSH7GdLnfNKe0ckWPX4Il/mW70ClY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7354.eurprd04.prod.outlook.com (2603:10a6:102:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 22 Oct
 2025 09:28:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 09:28:17 +0000
Message-ID: <0fb1e175-6e50-4f2a-a1e2-98ffe3108998@cherry.de>
Date: Wed, 22 Oct 2025 11:28:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] doc: askenv: Reword and remove return value
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251021202820.1272414-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: e2471f9b-c142-43a7-cb0f-08de114d54d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1c5dXRpQUpncXMwc3N3VlNGSzEyeEhHeGtiOVBIYThEQTBheXZNSTZaMzBl?=
 =?utf-8?B?T0dHRFBRSVRhdU45OWtRQzJ2SXh0bnAyY3FGdzJzY2ZGSEw1VHhHbmdTRkZy?=
 =?utf-8?B?OHphUmg3VGh5bUpwamFDaW5RN0g5WWszYzdWZkhWNUFrbXF3bGZQMTBNeDYy?=
 =?utf-8?B?cGpoeXBlaG1FTVJmalJNR1FqSm1rSEQ0UHU2d28xaVRQTjZNQnpCaHNTYXY1?=
 =?utf-8?B?b2dqVjFIenhxY1Jxb0hvTm04NlZQZHIyb0JqTVNMYUM0WFhqWVpZeW9RaVZH?=
 =?utf-8?B?akxvSGZHYm5OWkNPd3ljM2R2TGtWYjN5eS9tTTU5RXh0M0dsVU5POGxZbGdZ?=
 =?utf-8?B?ZnlXY0hBbncwQTl1MUp5eDZzMWh1RVh1dXNVeDNucW5MVjFwL1BmcDN2djNz?=
 =?utf-8?B?cUF3Q3I4Q09lWEhIaDVUNkJEYnI2TDI3YUp3REgwWHFPU3YrNk92bEZtc2NK?=
 =?utf-8?B?bEVZeC90QXRSYzhTekxzWXh5cUNUV2xRRDluY3FzeC9pRjE3bFM2Z0lVWWZW?=
 =?utf-8?B?R3ptQjN6eDErbUQ2aUZuWm1NUzlpaWFGYThhNjFYalpYNnRMTVdYSkRWc1Z1?=
 =?utf-8?B?ZGhqU043WEliQW1vTWZGQjNKNW1kOGhhc3cyd1diZUdacWpIM0Vxb0krM0dz?=
 =?utf-8?B?a1ZaM1VQYVl1dEUvelh3T2xrZ2Ryb3RKbXBlK0ZWS0Rqa21CWGV5YmhTb3NP?=
 =?utf-8?B?UlN0SUpSSGlMM244NUNyNm5YUkVOdFJnalpjcUc5anVZellJWWw4aVZMVU5m?=
 =?utf-8?B?SnBoNnovQUxyamYrODdDSk1PdmJBM1NOK092ZVc1OC9FaGtnbGVPYnYrNGRQ?=
 =?utf-8?B?SUl2bUxlYUs4elZ1eCswQjc1QWdmNS8zS2xUa2tCL1JXMXpzcTZGRlJLRGNa?=
 =?utf-8?B?eHh5a0V2M1VDR3B1NjE0cStZZi9qeTNnVXlyT1FNY3B0VGc2MUVPamwwbGo1?=
 =?utf-8?B?WlZrVUNGbXQ2dCt6WnNXU1NEVVUwM25pdWlxZllJcXlNbWRpeG1ZcklCNnlD?=
 =?utf-8?B?Tkc1SEJLSXJJWkdacWJuLzJRS2FMSGR3amdqSUVSODVQby9RU0hYUlB1NUJq?=
 =?utf-8?B?SnFzUHUxbkFRaWhkbXZuSVQyYVZLekQzL28vL0FSVjg3R3JvSU5QRW5uUita?=
 =?utf-8?B?NXdRTk01Uk1XNmNYWjd0c2ZkZFlUZWNSbGh2Q2RFdVExUnFzdGxPOFpzZTVD?=
 =?utf-8?B?eU5POWRXbGNXQ002c0tDeDFYL1hkYzVFVzc3UzFHb1FFcklPQno5c3J1M2pP?=
 =?utf-8?B?cTJ0WTdHck51WWZSR0NjU0ErQTljUTF5RHhnalR2RUI1ZVVmUmVDMjRNZEJ0?=
 =?utf-8?B?ajVoUG50aVlMaGVRRnpQbG9aTkNPTmdRTllneW12bzF1S3oyZnlBa1lRM2lJ?=
 =?utf-8?B?VlRCS1ZxUnZXczdJcnZPSFhKMlhNOXlmcngxMTlxdG0vVXptWUl6QWkvOG16?=
 =?utf-8?B?aXdCZTM2bHE5bDdnNmdGaXZiOCtwVDFMK0JQUERxc3lhNkF4N0RyUkYwR2tT?=
 =?utf-8?B?Rk03Qi9UUk5jYy9vWXJPemVtKytiKzMrM0pidkRKQnNJMnFNVHg1UUcySUhR?=
 =?utf-8?B?Q29NUEtLUUh3ZHNpcEd4ZW5zekYvcWFKZWNhTUx0MFpXdWtRenUrb2NuZTZP?=
 =?utf-8?B?d3lEbEFrWlJmUHBuaFc0czRNWmdGbDU3dXVmMUVseXIxMStWY2tSZGJLRGRC?=
 =?utf-8?B?MHZlcXU5SWdETXBTMlVBSHFoOUxMa2VteXFFVHc2bllhUXVyUXhaV3VIamFm?=
 =?utf-8?B?ZkNWMTJNbWRVUktVTUtzMFlUOEtKWGM0bUlCL3Q3Y2xPa1NkcTdRNlF2dlF5?=
 =?utf-8?B?dm53VGNzTHpBMHFFa1RmNFE2dE44cDFxMFlSaG1STGlZUTFYZVhpSjZWMDNB?=
 =?utf-8?B?WFVDSWt3djkxN0pRdU5JTnNsOFEvQUFPOFQyRCtMVlhKTTZpU2puMHBzR2RK?=
 =?utf-8?Q?Y3w8aQDHDwf9mzpH9+Qu2QxhQO2sn58r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0tPV080Q1lPSFZ4S1N4YjRUc3c4eUNnQXU5WlZHdVJ3SWNqTU1SWGl3Q3J3?=
 =?utf-8?B?V0FydVB3ZXliODBYMTYrZ1VnOTRzTkllcmg4VjJuVGpWMWhTNGNDYVNDeDQ5?=
 =?utf-8?B?ZnhWeUdqZEZmb2phL1dRSnNaeVhQTTU0TXZ0N1pQemUwb2xuT0RJc1NZQ2Vx?=
 =?utf-8?B?ck11U29oODBqZ1VlNFQ1blc2N0h1aWFudkk1QUVJbHpNTjJac0x1d0ZaMmF6?=
 =?utf-8?B?MEpiYTh5R2UrUHo1SUZrTlFMb3RqYWdhVUtNZ0lWOXpNSjlzaTV6NUhxYTlX?=
 =?utf-8?B?RGVWNE1qQkhkVEJaOXFtb0Z3WWRidkg1N2ZOV05GUWloVDRNU2l5azJIZ2Ni?=
 =?utf-8?B?eUU4WVUydVdBZHduU1prRUxUeC80WnhRVEF1eW93M3N5bWl1cHhTbHVudjN0?=
 =?utf-8?B?L2t3ajBtLzBvY3IyMlRZekIwUm1UNytWWTl6YTUwV1kycDZaZzlCVGlxVWox?=
 =?utf-8?B?NzlnUlhxTE9IZVJEc1NmM3VKNzFqSVpjOXh4TVRUTXBDS3pLbFF5Um5LdTRC?=
 =?utf-8?B?bTZJa2dvYkFIb2M4aVIrUjJWRWtyQXc1emk5bXl3elltZGVaZ2lnNmc1bDRL?=
 =?utf-8?B?SXhRVEIraW5UeGdRbUh5RnN4NjNLT2FSamhMc0FJejVZYW13U2NQMUdkK0Rs?=
 =?utf-8?B?aU5NdVdoZEZneGJ5bXBOcmg5Z0Urc2FKeHRUNnlTbCtpTkRNcURqMDUxTXVG?=
 =?utf-8?B?d3NHRUdOWnhLYXF0Y2hLM2Vra2VzbVBHNlVnanBHNHh5NEU1YmZvR1VpaCtN?=
 =?utf-8?B?L2ZCK1duZGpieVhnMzdpN2lUMC9Dc24vL3AxRHZ5YWUvUHVHUTN0TEs1TTc5?=
 =?utf-8?B?TG5uRmRTSGlZcllocVg2RnZDdDM4bnkwQ2ZJL1NNNmViTFBzVisxM1ZqcDZH?=
 =?utf-8?B?TFR1Snc2NFQvaGhvRFI5cFFXakhrOW93Z0QvK3NOc0lUaFpwbVE4cGRYY1dn?=
 =?utf-8?B?WEpzTTlSVDhSVTRZRjY0RTg3TlpiNGE3SE5aVmordEdleTdRVHNYaGtrc1BT?=
 =?utf-8?B?ejl3ZW1MVGw4TkNWbE5SWlpVakVZWU13QXJrQk51NkhITEc1cmVIeVgxUFF5?=
 =?utf-8?B?ODh0MmtnTnhYb1ZZQVNrSW5CZ01BdjlRSmJSNTZ3SXY3THBHWWtzamJsUnIv?=
 =?utf-8?B?MEV6dnkxZjRIYTEyS01ocTc0TTUzbGt1dWpndG5kbG5hdDBDSUx0L2UycG8z?=
 =?utf-8?B?NTVjNkVyNzhhTkYrNXVrdW80LzRycitDOHk5RzFJSDdOZ3lBQ2tQcDVrMytZ?=
 =?utf-8?B?b0M3RTZCRGVWR0lIWGVCM3Z5czlaL25TeDNWSFowVmlhWFE0a3g0cEZrcFV3?=
 =?utf-8?B?S0JKcmxXSVBkUE55VFA4b2hyazFLM2Erc0RYUlJTSWRweG83OUxpUWxqTm5N?=
 =?utf-8?B?UUY4Z1FVTDlWbjU3di85QlkzaE1OYlF0SW53UlVUYTdhdGkrUDlSTlplSUhH?=
 =?utf-8?B?bUhaNU0zemVoellWODgwL3dUdTdZYjdoUjUyNktLRjU4R3p2RS9YbVJON2RS?=
 =?utf-8?B?REppTjgzQWxqVHErT09OMzh5dUptME50VE1rSWRxM2Qxd3NkOE1jMzYyQ0o2?=
 =?utf-8?B?K2pvYm5WUlFWSXJnMEJyS1cwalI1Slh4TUtLVFNDRHdsdVorRXQyOStVbzZ0?=
 =?utf-8?B?U1lKcjBHZGVhZHVOcjZTUjJaVnJrSldiVnVHY2xydnZud2FvK21uTFdUZ0VW?=
 =?utf-8?B?UXVwd2JuSUt1SEhYaDJBdXJLM2QrZXN5N0FIWS82dGRGQi8yclBwKzIzaWJL?=
 =?utf-8?B?eG5MKzYwY0NpLzc3ODF4Uy9qdGpJeTBvRmx6YndtS2xTeXpnWVlzQmVZTHk1?=
 =?utf-8?B?Q3p6TWlORnJ6REFXUXQ2dEw2V2lYZnVOQ0ExK05TV1RVZDNza0RPbFkvcm1y?=
 =?utf-8?B?eHc4c1lKUG9rcTRCajRpRklUWTlkeDJ3NlV1NWU2Y3dSc0pPUlFHQXM3K2xt?=
 =?utf-8?B?cDRtR0dYaVNEWDlEbDNPT1N6Ulk3NDJvdHRLSm5Lb3U3RWVqbURwZUlacStJ?=
 =?utf-8?B?bmZiY3RKYTJuanljenJIa0VHZjlTbHdBelJlbWd1dEVTejcvRDB1eFQvT2pm?=
 =?utf-8?B?bW8xUHlsd0ZycFRveWJqNFpZc0pJdWRpOEJDcU9zKzR3MmIzSUpEa01NNy9J?=
 =?utf-8?B?UmdicUhmdlRob2NGdi9GcytzcDBKSmxTbUtmeDQ1cTR3cW9zaGdlZFpnemtR?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e2471f9b-c142-43a7-cb0f-08de114d54d4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 09:28:17.0322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE5H90c+WXsTeVyVBMALlMPDGVad7wAa7CozfvO7A4/aUwzc19/x6IYqo3pEr5PBfUS0jriWk0O4BcbPh3TNXmlJy18GYYun1qvFqH5jo9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7354
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

Hi Tom,

On 10/21/25 10:25 PM, Tom Rini wrote:
> With the addition of general text about how the return value is handled,
> remove the examples from the askenv documentation as they are all normal
> expected results.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   doc/usage/cmd/askenv.rst | 27 +++------------------------
>   1 file changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
> index e2b3c5379aea..a8867ce4d266 100644
> --- a/doc/usage/cmd/askenv.rst
> +++ b/doc/usage/cmd/askenv.rst
[...]
> -Return Value of askenv command, when used without any other arguments:
> -
> -::
> -
> -    => askenv;echo $?
> -    askenv - get environment variables from stdin
> -
> -    Usage:
> -    askenv name [message] [size]
> -        - display 'message' and get environment variable 'name' from stdin (max 'size' chars)
> -    1

Shouldn't that be -1 here to match the expected return value when the 
syntax is incorrect?

If it is 1, then it's a difference to the expected return value and thus 
should be documented below?

Cheers,
Quentin
