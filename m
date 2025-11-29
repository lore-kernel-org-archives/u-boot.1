Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43265CFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 14:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A62668367F;
	Sat, 29 Nov 2025 15:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="cNySDMen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC9E8367F; Sat, 29 Nov 2025 12:12:29 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazolkn19010021.outbound.protection.outlook.com
 [52.103.33.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9040832AD
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 12:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thMisbQDdLZjImtonrlWvZo2Mow4kHymgO/dyfexbvo+Gs5l60p/fqzuqi5tDQ8Zdimg5cqNv1szXMHdJhY7jrkMzK47Nl80wqHZ2vK3ESDueHB/zWCFTIk/U8+LccMMSoj7UOACUh+lMTzK+2k42u1spxVdaXG567hBS4ZW+dLCnV6qTNz+F1Lb/6DPCY04EGfHpcOwwaB32vyF36mFgW5Shu10IZStm2dZNk0qPYTIYSA4LumgAhE1Ho8Zqf9KwJPrR/q4UVvS1SjgtcFQ0nLbBYr6SgrOygzYCygA3R1ffoQLroQuYjRiIeIwyC2ZIzM0swM36fPOLlc7YG256w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX34xdVsy1Tduu6XYS/6ZaNmof5KzLakiNo2PZS37jk=;
 b=mfyJYELW+IKCvZ1NeAkSTQ570L4lQFqTgA98sIBp5eB52z8OqEhcsE3kZHgjwyDDiQ2zTHyJoYF1qnw4WBPdOAxLbGK2ch9GbdLy5H+DC+bfIj//yoWGPAb5IL0rw1eXC8lqr0UyVpdX8vpeliJKSn892/+e96Yq+JGBDhXaCf760gyVUFANV+AHnzEX8EB03T9/CvXeSerTFz0yFO88HWmGuTxRdYvGeMo60e9bxbyO5IkuFOQgT2HDDbfYDdFaMrsoqBCUL3V/jEeyyRh4UvgLF0N5UQlRo5Fv1lPWrg4MPhQRzu0m9Mxx7c5h00TS0Bdue8bvKFAQ9UJUt4driQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX34xdVsy1Tduu6XYS/6ZaNmof5KzLakiNo2PZS37jk=;
 b=cNySDMenobChtOkIMQr0N7j/4F6XhnsBAA8I0/mvN/vhBo/89bSdetfzQYASUh2/NW42lB6BZZHzTGYInxZjZmJvGlsgJSFjG9JwTG/1v+5Gr9Ja6ysbDKKWBA/lo/SctvkFAHjlD++rrzo2Fa3FbaNLTwCSNR8l8yE0smEDol/2NIKOjrjw2rk9teI4anvrC1p023wkQAUP58t20nTxZXc98N6f/N20eqkIAua+wUTiTHP3vcoQ7N7+6g2vLGo1PgYQnaDQlzF3mfYVVSjuZR+2wNzTMwu+Jgtff83bNVTIdkSyD5znm4PcqCH8l0zUpkAlF9I4iwjPRku7ENpmQg==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DBBP194MB1003.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:1e0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Sat, 29 Nov 2025 11:12:26 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 11:12:26 +0000
Message-ID: <BESP194MB28057D1468C08C867A8D8D76DADDA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 29 Nov 2025 12:12:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/erofs: Fix realloc error handling
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Huang Jianan <jnhuang95@gmail.com>
References: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <20251118213359.GA630712@bill-the-cat>
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
In-Reply-To: <20251118213359.GA630712@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0414.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::9) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <37f78c00-8579-4895-9bfb-973c48c93768@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DBBP194MB1003:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9f3caf-f632-4886-e961-08de2f382d8f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|6090799003|5072599009|15080799012|461199028|19110799012|41001999006|23021999003|8060799015|3412199025|440099028|40105399003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnBzR1A5OVhVOWxqYTdheUgrOXVTSVc0UGY5Z1ZBNWtwem9hMTFFcW43TDFK?=
 =?utf-8?B?YnR1NS9qQktBMFVoUWwzMXVvdk9ha2pWSzlVa1IxeW9qL0NIRWo4VWxxeEE1?=
 =?utf-8?B?S2trdmdEbndETnZmbjVLRWZEMzVtR0pXSTlSUGNoTHdPRzBNU05lNkdLeUVW?=
 =?utf-8?B?WjBzNng3UzRmKzNjcU1lL3BhQ1plSHdlYVkxNnRua0FGcW4xcFZGdjF6UGVp?=
 =?utf-8?B?NHgydmFDcFVsUmJ0TjN0c204OUVZVFdFeEJpYmhNSGw5OWJ0cTBEMG5sNEJq?=
 =?utf-8?B?QWtFa2ZuTjlDY295eDE3K05VSnVSSTkvUlBCdHFzdmtLeU1QZkhTZ0ZsRGsy?=
 =?utf-8?B?dVlVamZCbk9kL01jWUNIdU54N2FNL0p0K0d0a2tRdEtnL25Sd3dabDBiMFBh?=
 =?utf-8?B?ZUJoNlpTMFAvMS8vM0FPaVB3a0RPQXJRN05vWHQyYXoveDYvUXd5SlFqeTNk?=
 =?utf-8?B?d0RDcldYZTh5S3ZNRDd6N2hlNkN3OG94M1VVOWNneXhtd2YwaWxTdE93QWI4?=
 =?utf-8?B?NzZoY0lkVlg1eXpDQzNGby9pWjhHbXBQZ1dJODk2d1JXVGtlWkt6cUZUYVd1?=
 =?utf-8?B?eEZCc3pWeHVlWTdIRktPb29LTXRkQTlmZ3Azb0NXYU5FVkFuOWxYWHJzLy9v?=
 =?utf-8?B?UDRrZXpGaENnb094R0RwVmhZTkNlaENNMWVtdWhzZFhHZmRqZ1Z0bjRGZTdY?=
 =?utf-8?B?dHN1M1Z3eGk3N1dQc3ZOOTVFeWo5ZjNjUVRlOEY2YVVvL25MeEZCc29FMSt5?=
 =?utf-8?B?bkMyOUJackt5cDBXaFJQc1ZQQ3l3dkdtNks0QUtFZVhLMjJLeW9UWGlkeHNk?=
 =?utf-8?B?eXJSNGZCa0ZTNE1PYmxDTUVld1Uyb3dtK1VKRVZGVitqWFlzVXorOGNoNG9R?=
 =?utf-8?B?bTQ4SllNZzdVcDlZL24wVGp0OUh6dlZPU1JZOEhSMTNMaHRORGtwVG1jdXl6?=
 =?utf-8?B?UU1VQmN6QUhrdFNicnl4MEh3UlcvdkJOZHJMUjhMSWR5QWxPWms2WUsxK2NB?=
 =?utf-8?B?bTNqZXovaUM5bDQwSGNDMTVMZmEwZElmWWhrcUJCR1IxMWdYd0dHeGtxR2dI?=
 =?utf-8?B?V2FVdlVMclprcTZTUlpKZTZzbFNlZ0tDbjdhc0JZUFIzWVluVW9CRGFJMXYv?=
 =?utf-8?B?eVBUcmVzSk9kZENUeUNEVlhYRnJNeFdXbTYvMkVRMHNnMTQ1aW03OWVOejJQ?=
 =?utf-8?B?RDFoUkxiZHFmZEgwNTExMFdJQ0ozRDN0Z05TbjVzQUZRc3FWUUUxR0xBWWlK?=
 =?utf-8?B?RDRWWXFZTUdBL2R3NTYybVRXNFk5cHBsVUZuelZTdUFSRzZYNDcrSDBFeFk4?=
 =?utf-8?B?K1JrTm5CTDBLQktUL3hVQXgzc3VUK3U1dkxKeGs1NEtEY0MwOEFlalQ4bGNZ?=
 =?utf-8?B?WlpMWWVBUGhOdHMwTVNyNm95cjh0VXZHSVNIQ3IxK0RLQ0xIci9oemo3WW1K?=
 =?utf-8?B?WHEzSk5YcXJKbUZ3VzNFdy90QnNOZUpTZWNySTh4ODVud1NZaDQzM2YrdDYz?=
 =?utf-8?B?UUUzeXJNVlc0Nk9mWFh5UUp0aUJmZUN2dHM1RzJ3aC9CMFBvM1hOdjc0cW9i?=
 =?utf-8?B?UDJNeUdFZndGRGtGZnJqSWIxcTNFYnM5SGsraGw1aUwyT1JVUGdsMGhFZnJH?=
 =?utf-8?B?VVhnRE1Ub0EyWi80Q1RLcjVXQktacjVsOEhPazVGOU1ORU11QjRGL3RjWDh0?=
 =?utf-8?B?ZW1kcm1zZ1BBRGhIR3Fjc0lPWE5vaktaR2ZQTVlWNjhUYnI4T0t5WVV3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGhQMDB5amRQVVA0U0V6Z01OUFNoUUZZQkNDWHNvelptaEVLcFdlQmVvWXhz?=
 =?utf-8?B?eFRpcS9rYWVhMnRtejZRNFlRL3loVDBCS0tyaHY0VEQ4NjA5eENMbndSeWJ3?=
 =?utf-8?B?Z0N4Y2pXVFVReFlsWWVlbjQ0RW1OOWJ6RkRRNytyNW1rSWJBcEdiSmFVQ2x2?=
 =?utf-8?B?eEVqelpmUDNpUHdRRmdKbk8raGkrMlgvL0FxY3NRaENsdVNtVm9YNldsck0z?=
 =?utf-8?B?SktCeEM5ZmxOcnc0SjBBNmI2M3IyK0R3TmlaS0s4Y3NhV3BHajFFRS81NDdM?=
 =?utf-8?B?YkIwS214UWRja3lKVEtadzRUSWRnSGg5ZWYvcHk0Y0svaWtWeW9vbmVZRDJr?=
 =?utf-8?B?S2hHRnp1azFxZ2l5eVVSdHJML3V1Vk1lcCtyQmpSNG1yQ0MrV2dsMjJ1ejB0?=
 =?utf-8?B?OThnSHA4c3IrelZkdnhaR3dpWHpEaVJvT3J1N3R3S3Axb1ZrRWhPTjFoTjMr?=
 =?utf-8?B?eUdtR2VMTGZ6UXpJUzcvb0hRRDNVb052NC9yZkNEcGkxb1dhR2gzbXRVcFNL?=
 =?utf-8?B?SFJjeHBaRnIrMThqM0EyUGVnZGdJWHhoL1Z5YXJWRkEyL1ZkaWoyQWp2SThj?=
 =?utf-8?B?d3FuYlN0ckd1UERiS09NMktFK2RKTjVqNGdjOXlKbnhtV1JCQVo3OUw2MVU4?=
 =?utf-8?B?M2YyMnhwWTBnMEtuRi9LRWNjQjc3clJIbkQzWE1XSzZLRzNRRy8yRnJYTjE2?=
 =?utf-8?B?L1Uwc2owWnkwaXBJSnpQNzAvZTNZWHhEZ0tPdXU1NGw5QWl4dzhUb1Y5K0Ux?=
 =?utf-8?B?aDI1MnluRlhoa1RKTHBybFYrb2Iwbm83c0hiVWJZK1AvTVYzVmQvK1NFaDJu?=
 =?utf-8?B?cXNpL01RQzcxMXg5ckR4a1E2RHMxUUpOTnB6bnZXQkY5U3RWOEFoSjVvQUdk?=
 =?utf-8?B?aXJPdWdBVW8rMmM4eitJSlZuOFRMaUNMc3VDeC9Jc255R29PRVNhR3NrY1Fp?=
 =?utf-8?B?VUZuNmcwdUMyYm45VzhQbkVwZkF6ZC9rUDBBVHBDTnlzaUxhbkcrWUV5RW16?=
 =?utf-8?B?Lys5dExTOW1Pczg4TkxtK0JPWWNtTmNONGxQWGhZSVA0MktBc3RGMjlJMklF?=
 =?utf-8?B?RWFycDg2SlZiNnFrRmJFWGZIVVpHSUVDREdWTDJRMC8xTGJpZU9rYUE1bmJj?=
 =?utf-8?B?QlB6UjNlcnhlZzFZL1RKd1k3dmxRN1gyV29lZVdJT0ducGxyNk1hK3hmT3M1?=
 =?utf-8?B?djRvUnVwbzBCSStDOWgxeVhIekdzOW9pMmlNOXRSUk8vVlVsUjRHVXdaTy9i?=
 =?utf-8?B?cXZHdTd3NytvZUhRVWoydkNpbXZRRmQxdGdyLzhJckFBeHhVdDIxelRZbnZN?=
 =?utf-8?B?TVpsRXV0VGIzc1NZOUI3cDdQVWNJMnZyMjdQYjgwQXBaUENSQWk2WG1GZ1pa?=
 =?utf-8?B?VjVHaHhxVnVpbGJiZlllcTJKdFphMDlZeTFxSmNwQm4zQVdISFBvTGJLRWIv?=
 =?utf-8?B?VUI1V0dYN1F1T0lUTXo3N1c1Z1BTd09EdFI3elorRGpKOWlIMFBYWlFTSkJD?=
 =?utf-8?B?Y0ZzakE0WWVWellFWUltREpZWFdqQmcyL2ZjZzZ4SUZ1UTFXRkduZWpGTWVW?=
 =?utf-8?B?Nk5Ed05ramNBVTZQN0p1OTF6WmhobzFYUmVyVjZMeVFmcENscUtFNE82dzdZ?=
 =?utf-8?Q?WwAKZwcpftg2z3yyJwCdLTHFLKupTbxQyxDn+pf3FnZA=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9f3caf-f632-4886-e961-08de2f382d8f
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 11:12:26.5108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP194MB1003
X-Mailman-Approved-At: Sat, 29 Nov 2025 15:54:47 +0100
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

Hello Tom,

On 11/18/25 22:33, Tom Rini wrote:
> On Tue, Nov 11, 2025 at 01:49:30PM +0100, Francois Berder wrote:
> 
>> If realloc failed, raw was not freed and thus memory
>> was leaked.
>>
>> Signed-off-by: Francois Berder <fberder@outlook.fr>
>> ---
>>  fs/erofs/data.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 95b609d8ea8..b58ec6fcc66 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -319,12 +319,15 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>>  		}
>>  
>>  		if (map.m_plen > bufsize) {
>> +			char *tmp;
>> +
>>  			bufsize = map.m_plen;
>> -			raw = realloc(raw, bufsize);
>> -			if (!raw) {
>> +			tmp = realloc(raw, bufsize);
>> +			if (!tmp) {
>>  				ret = -ENOMEM;
>>  				break;
>>  			}
>> +			raw = tmp;
>>  		}
>>  
>>  		ret = z_erofs_read_one_data(inode, &map, raw,
> 
> I'm not sure how this changes anything? The function is currently
> (snipped for clarity):
> static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
> 			     erofs_off_t size, erofs_off_t offset)
> {
> [snip]
> 	char *raw = NULL;
> [snip]
> 		if (map.m_plen > bufsize) {
> 			bufsize = map.m_plen;
> 			raw = realloc(raw, bufsize);
> 			if (!raw) {
> 				ret = -ENOMEM;
> 				break;
> 			}
> 		}
> 
> 		ret = z_erofs_read_one_data(inode, &map, raw,
> 					    buffer + end - offset, skip, length,
> 					    trimmed);
> 		if (ret < 0)
> 			break;
> 	}
> 	if (raw)
> 		free(raw);
> 	return ret < 0 ? ret : 0;
> }
> 
> And per include/malloc.h, calling realloc with a null pointer is the
> same as calling malloc. So we had nothing previously allocated to free
> later when this failed. How did you find this particular issue? Thanks.
> 

I found this issue (and most bug fixes I submitted recently) by running
cppcheck and scan-build against u-boot source code and triaging warnings reported by these tools.

I think my fix should still be applied. Looking at z_erofs_map_blocks_iter and z_erofs_do_map_blocks, I cannot guarantee that map.m_plen does not increase during the loop execution. Hence, realloc could be called several times and we need to properly handle realloc failure.
