Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D55C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 05:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902EC82AE1;
	Wed, 16 Apr 2025 07:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RDiLSJMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8002D82B44; Wed, 16 Apr 2025 07:18:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CEA782AB1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXiGdhDUMPQNv0wI4hJw3TngX+tcWYvexWJc9PUZz3xJImmnuI1DmHGeHqitXVb9oMyflhfYGH7Xxd9ddwzjrnwi4T+Gck0rqjRX8q/NioSxf5ek7iAeMxkDlsWIioZtFtpNuLARH56xYlE84AwZoFg1+HVfL+L2QhFM000gzH937KXieVezh1QkUkL0vXjXxEHDJmhhIMvZzSXT80OLBrVb+qUIFzsIiFnyFuVK0yO7STFo2UajJZAGkw3JOCG/Oc4TSoaWTlSY6XY3cwNcYIuV7YLsigJCs1gDYXs7aadpBA4176kHc2ekxGElftbFqbLaeGeP4JvAlCCGmaBt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq0pd7Wg8JX020WyfR0x0L91NIr7Rh9t/0wyeg+YCsA=;
 b=jk5h9OqO15rrDjOcyjFUAAjFaObh5awmC2LbDzPzCFWjFn2FdB541fo5oX0F3/YHdbV0m+X0l9DQkKPI/09FruMPjoeZzvTTSNhf9CBjbI6OSJTInl/oj6TsfB64eJW/o92zGBMJpLpM5HM69Ckum64MM9/jp7H+rdTpAKhqmJ0+kDIw2nE4sJ+u/e9XBTJMmpyVYgbkrdcaDiJpFUFUQxxxD/pFmDLdNkhzO2nm8018vHG0booqx0OQz8nAgp1Lga+zUuyqeLPabeOmbM4nbydmOU+Hullj+MwJdYHyHlcqQdbvglozuGro4YVjcaGPeWfFGDJKvwVr7M1/wWDxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq0pd7Wg8JX020WyfR0x0L91NIr7Rh9t/0wyeg+YCsA=;
 b=RDiLSJMHrEeUu0zTyVs2eGhrF34g4WExLU5JHuP6qS3HIoBDVAjZefeLmX1f7F9TtVDpVdHiBGhaMPo6a2BigI4lLSlbzs6oBkYngbCjR9Ga8bgisVEX/vGPbzELGnXHFV84bmCey2NN7UAnqEw3KUEJbTNftVzVdt3j5eIZs9qQOC0UJGy8+NaErYq/K31w+YcCNfamJWgSPDysWrQNOWKmTeZ2QpnAWuo65pQ4H6qV53QyUDFRd4U/0BPc9JeQLuF4hiHGigZuyvmnPuL9cw6Uu4xBp+I0K6t9Rv28seQnRWah0yynYHUjqNRPDZdKZhf2UZtoLNjyTzMif+Hnvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by AS4P195MB1526.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 05:18:16 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 05:18:15 +0000
Message-ID: <a85a139c-44d1-4dbc-a2b6-68695d240539@phytec.de>
Date: Wed, 16 Apr 2025 07:18:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: common_fdt: Fix Label Issue
To: Tom Rini <trini@konsulko.com>
Cc: n-francis@ti.com, u-kumar1@ti.com, bb@ti.com, afd@ti.com,
 u-boot@lists.denx.de, upstream@lists.phytec.de, w.egorov@phytec.de
References: <20250407060711.3160366-1-d.schultz@phytec.de>
 <20250414225911.GA546803@bill-the-cat>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250414225911.GA546803@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|AS4P195MB1526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d40f218-8ad4-4f93-d262-08dd7ca6173b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjJGNlA0TUNxNlRHcHNVR3lmMnVBaGkrVlFVcXg0WXpLR3RhSnY4NmU4bVRG?=
 =?utf-8?B?cHpnaVF5Tm9aOVY5bktNR25QZTBwSU5FWldLQ0dvQnlqYVNGWFBUNThHdm1i?=
 =?utf-8?B?cHZyZmRCL21VblZJdzJEZEd5UUlERlE5YzIzTGZldVNSRkRnZCtHa2pveVI5?=
 =?utf-8?B?QTBJMit6MGh5NFVnN0ZKQ21yajlZTnBCOVFoOUx2aWgrcUUydy9Ubld5Nk9j?=
 =?utf-8?B?QWdFNHU1c1pJT1g3S0hKMFJEdXc1WGZBR1RiQkFHa21xcEZQa0p0U0M4YTVa?=
 =?utf-8?B?V0FRNXVzYVE0T2pxYUM5QTJHVjg0RjBMMFNObXUvK05oSWZZNWE5WDNUNERq?=
 =?utf-8?B?SXpSa3JjQklBWmpqOW5nUHN2RjhET084cWJ6SW0yR0RvSDZGeEN4dFNRWG1o?=
 =?utf-8?B?QTJjWG9sZVB0OTY1S1Qzb2JhUjVxUGk3QzNUZjFGUXYreDZhdDNEemUraEQ5?=
 =?utf-8?B?NmtnV1FnS01Vb2N1Y0FIdGtqNllsLytDYzlrWGhKK1pMSTZNbXFWOUxSZWow?=
 =?utf-8?B?WWZTdlhnUXllUU9zOU80V3NwV05NbThnZHFmcUhYNFJ3alZaa3F6RWNGZUVk?=
 =?utf-8?B?UXFPMVg5RWFBNVl0VGhFVjFQa3hUeEkzeUdkK2tRc3dBZjg5aElEQWQ0bzBj?=
 =?utf-8?B?TkM4TXhzVXdZdmpEcmhlbGhTZUxzODRTTC9DMW5iNFdXWFFneHIrR3IvUWh6?=
 =?utf-8?B?NDNJbVJ2dm0reHk0VWYwTTJFSFcyYlRDZHNsa1F6MXlwajVEdjJETTRQN2JW?=
 =?utf-8?B?K0hTZllYMDhYQXFnV21xQnVYbkN5YWRDN3JBY0ZYTE8xSm1lZ1NwK1p5R2JY?=
 =?utf-8?B?U2c2UGw3ZXAyRi9TeVBXZDg4UXp1SDVGdGd4cmtyRlFOK002bFo4UUkxVGZZ?=
 =?utf-8?B?YnhQYjBqbzI2cklWK2d6eWlhWWRiZzZZYm5Ndm9LNEF2MjhUT3d6K1VJZ0E4?=
 =?utf-8?B?VkFuSzBnV1p5QUlGbGg4a1c2ZnBUMDlmWEZVaXd4YU1QRVJUMVQrQWNBb0JI?=
 =?utf-8?B?WHl2MlBXS1V2UTQrdUlIS2hrUE5jNWNEK1NZVzJVYjN3K0VoTThiVXJMdXdS?=
 =?utf-8?B?cXdjZUJPR1RRMUZ3RTVEaEM1RmZZczdVR2pmNGFYYXZEaEI3UjRBWkhlZ2VE?=
 =?utf-8?B?NHllSzkzZkxBMVk5SVZwZFVzbGUzRnFMZUQ5cFdUUVp3RHlwelUwQzNURWhq?=
 =?utf-8?B?UXB4WC9tQStkTXR3b3l5emtSN1lyTTZDREJYZlI1RnNZS2VXL0gvUkVWWG1p?=
 =?utf-8?B?YStTeTlNMldvNGV6NFB3UzBBaEdKWXFwRW8xbFBwNzBLYlduVFR2WDRCOFVO?=
 =?utf-8?B?ZDRNYTFGcExZaFkyWHh2dkdyUEpUbnlmWXNva3U0NzVFa3lJeWZPQ1NLRG9M?=
 =?utf-8?B?S1duMkxUL0V4bVJ3TnhvTktUdnR6cGt3Qmg4NlRqYVh2RFBMK2p6eXd2RklX?=
 =?utf-8?B?WFRXMm8rZHlybWM1UjR1TnMvMnBwdC9uOVBuOGprbTRtNTh3UjdURS9GWlVJ?=
 =?utf-8?B?UkFYSjVPbmdEQW9FQlM2R0dUSlB0Z3MwMEhvc3A1T2ZEZ21LZmhaQnBuNExC?=
 =?utf-8?B?N0ZDcVNGdjVWY0JEQVlJVzZQQ1V4RHdQT2NtcHdsbkU4YlhJc3FHOXpxN0hu?=
 =?utf-8?B?clN1S0c0amtaaEtSUjE3djJXdm1rVlZTb2RTMlk3Tit1a1FQTXFFREtxckZQ?=
 =?utf-8?B?enVaZVdQU0lINmJURjJ4MnowWGZLaklIRUprNGdJbFU5RUFlVkwwc1pxaExj?=
 =?utf-8?B?TXJ2Q2dZbk9JRk83L0JyUlBXRGpaQ2M2M0FkZGxuWmxqODN5YnR5K2l3aCtT?=
 =?utf-8?Q?0XLUQHnP0Isi969mlm6K7SRiaaHfHaGeklez4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBWNzdqR3N2T0J2Ylh2bWc1Kys5dm1RdUJPL2FJWENRSVQyZS82T3pHYWRz?=
 =?utf-8?B?Yjd2TzdOdUVieDZPYyt4MzJORkxyUUw5MlBSbStsRFN6ZWlTTzhCM2lQQURo?=
 =?utf-8?B?Y1p4QU5SZEZQU3BleVdrekpxZFF3ZDV5LzhhYldETmYwZno3TERXdkFRNXBS?=
 =?utf-8?B?SzFOcjBDMk9naHRaejlPODdkUDBkZFUvaEJzdytVQ1BuQm9aY3AzelY2alJI?=
 =?utf-8?B?UTZhUTZyTklJYWxmOC96cHBrTDZWQTNGN1Axam1xaVR1bC9jbU5VdDJNRGFn?=
 =?utf-8?B?QWhxTFJwdkZXc0FPaGtGTkdQY3Vhb2F4VFVqRmtBUDdnMjUvczFjWVZCTnNu?=
 =?utf-8?B?OU50TjliQ1VUMVdKSTdqcG9YMWV5dWZMVFNhd29xaks4WndVMlFlTmhOSHRy?=
 =?utf-8?B?QktnWnhmSEhTWTF1QWNRZ1RlMFVIT1pyWVhldGxxbXI5R1VXSk4vVm43VFha?=
 =?utf-8?B?K3RYMjhkVVVIMy9jaXl4RHQrbUJPbzRtNjBLK3NRZWtNRlN3VTdiQllzSTh1?=
 =?utf-8?B?NkdCdHRaQUEvbWpGZytQQzU4OXUyV1FuMTlmTVA1d2IxNHV0Q3dreGVQalkw?=
 =?utf-8?B?MnRJaGplazE1Y1hNLytFb2RJcGdodGM1d1ZhdCswcWVFV01aRG9vR1BoSGhR?=
 =?utf-8?B?VzczWmpOaUFDRHBoNEZVMEhjOXF3OW1HWlJKOFI4aGVMeHRhTmhNN2RBaUpr?=
 =?utf-8?B?amZ6ak42eXRtMzRzWmJCdDMyYzh3YjZKRnM5eXFuRlEzWmFFd2QyYkViNVQ0?=
 =?utf-8?B?UmtkY2dtTVhsd1ZpdzhxQkdnNk8yQTdTYUtkWjE1Zk5WS1Zsekh1ZkVvbkJV?=
 =?utf-8?B?V2EvM0NSYjlWaGFQM053RFIxZzdJYUFBRU9MRkc1VkxjcUpuWlphZ2ZGcHIw?=
 =?utf-8?B?MU5PNlEvaG96NVNhZnVJQmNWU2U2RHA3L3RCVVdCbnJvNTdwSkc4OFZtalhR?=
 =?utf-8?B?WnNLZElsUzVTclNsTVlyanBzek9nMFZmcnhoMFhIVzBPZVErZjVlOWVlRGlR?=
 =?utf-8?B?cko5cEx3eWo4NmlmejBQUkNGNmhBT1BZR0JYdVJJdzJ1RjdTMENITHhuVGEr?=
 =?utf-8?B?KzVPeFlEc3JqZnZhQ1RwRDVTSzNtK1VoRXNlc0d0Y3VwNDRJdHcrZXNhL2hw?=
 =?utf-8?B?dTRIMWNSQ0tZU1RScFVrSXZKajNjS2NLaC96c3BQQThEdGVBd1hYQ1VzSTJN?=
 =?utf-8?B?eFNtUHJzcEY2VVY4SXNkVHordmtNK3BJbE5TNWpDaXBwUWx3dDhOZTJ2SlFE?=
 =?utf-8?B?c2M1Q21BL2RjL25YOGE0NktGQVhrcGJBc2xHTzBPa3JkTmduUzI0UnVOZzNv?=
 =?utf-8?B?MkgvUi9lUXRlUG5TZ3cwTzBIbkE4b0xFVVNNcjZYd2NQM1dnQWVKSHlmbTNv?=
 =?utf-8?B?WXhkZGhQaFB1T3JrTnYrV0UxWmNSOUJkRmVmbWtGUnRPYUNEN2NTV3pmZzk0?=
 =?utf-8?B?SzVQV1RBWlkxZGl4RG1xb01UL2RwQ0Q5c01sWGFDTE1WNEM3Z1kzeENrTmY3?=
 =?utf-8?B?UmdFbjZ4V3RyK0ZUQWVwVS9tbDZ2WFhtK0ZZb0cvaHNJNlc3ZjJ1ajM3NFFE?=
 =?utf-8?B?czc3MHFBMm5pdjdYempQUEh2d2RGVlhpZHdlZitOajBMN3p5RlRjT204UGdl?=
 =?utf-8?B?akFEdndGRUJsSUNzQUVXSVloN0VGbGxXYWRUK3hVc2xsajFydEh6eG9wQldH?=
 =?utf-8?B?dFVGd3Z3QnhkM2pKQUxsRlg3V3BUMERwaUNpUitFVWE5S3dFMm1YQTArTmZD?=
 =?utf-8?B?enFHSUxmT3hGZVRrRGx3MDVKRWMyWHhYRVNnb3ptUnFaL0lzWStQY0dNS1NY?=
 =?utf-8?B?SndxdkdtU3hmL3REOGpUTGFTUzZnS0xzVDFZZWFPaGJBc3ZVaWlZWFBERDFR?=
 =?utf-8?B?TklhZHNkRHBGS2ZVSklkbGE3Z1lqbmRadHhuVmR5TVgrbUxnU0REWEM3ZDB6?=
 =?utf-8?B?aHdOeUlmMzRjdnZhVHJLanluOXZpL2c4RUM4RW5iMkhGNlY0SXA1aDZHc05u?=
 =?utf-8?B?SnpscmEybTFDNENYR1ViY3dhM0pLT1VhMlRpMkJhSmJjamgwc3ZwZW9XTmwy?=
 =?utf-8?B?WUZPbUZSUTJEYmdZN0lraUgvaE9aYmxNeWhVaWR0NEUya2R0aXFZbFY1bFBY?=
 =?utf-8?B?T3JJKzM3NzVBd0oyVURwU2Y4RWhGRjVERzMyNUFuL3l4ZnlSNmpwa0FNRGZL?=
 =?utf-8?Q?k0aJpTTwcrQngnRSDYzLHSIgIj+6QWhvRNe/OQp7IdjK?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d40f218-8ad4-4f93-d262-08dd7ca6173b
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:18:15.7095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtFiVsxlLQb/2D1I0oKwG4Ic5S3oI0T8a6lOZx4eEYoJN40s/F0pVN+o6JoZIEZrVIX2TW3g6DZy0htrv6lYlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1526
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


On 4/15/25 00:59, Tom Rini wrote:
> On Sun, Apr 06, 2025 at 11:07:11PM -0700, Daniel Schultz wrote:
>> Labels are not allowed before declarations. Add a semicolon after the
>> label to introduce an empty statement. This will fix following error:
>>
>> arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
>> arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a statement and a declaration is not a statement
>>    156 |  struct fdt_memory carveout = {
>>        |  ^~~~~~
>> make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] Error 1
>> make: *** [Makefile:1919: arch/arm/mach-k3] Error 2
>>
>> Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>
>> I'm open to other suggestions! This is just the easiest way to fix this
>> compile error. BTW, master is fine since 096aa229a9e is only on next.
> Is this the only warning you get with Ubuntu 20.04's gcc? But I would
> also rather see Udit's suggestion on how to fix it rather than adding a
> ';' here as that looks like a stray character rather than an intentional
> but not always obvious fix. Thanks.

I agree. See patch [1] from yesterday which should be good to go.

- Daniel

1: https://lists.denx.de/pipermail/u-boot/2025-April/586915.html

