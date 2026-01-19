Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB59CD29C46
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE19839D5;
	Mon, 19 Jan 2026 17:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="C5chkUQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB2F83015; Mon, 19 Jan 2026 15:47:26 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8918003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 15:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKJ82CV/IYn8JSzYg0VOYOfWR5yg+ULDkc/LP9sH6kUnZET6KZpD7lXJT3FXEclf2HDkCX2kQEQXcn9GgwrqRqt4bXXoqDmD/h4+VBHiJMxj+FyuIvhDhIN9Ev4HqYOuxpL7XorLZpjQCvrHsxHUDN3tRS4Z70LSIrXRW75z0iUAbRDQN/4V22+pa/m9FaDM00OgP9BxQ93TjfqkBfjRWIIIgCGlN9NlpBodo3UoaGwNUDeIsIJ9XleE2y2T9vJ0av2lpX7K7qjUF5lasmz+Zrvslcp2RsXEvdEhIL9Ol7O4Grj645sn79LqoUTmj/dgmy0IdR4JjGzhlsu4bv+gDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pt51+RxHKqvQDCmXQuTayStp4g274MNkeVIlj4dJPgQ=;
 b=XlcCOST0wrf2tUABYyVVoQ9RK1Xu4XleM0KDxljFcxIs9BbQ8ys1yPKedeWVDeekVfiKzMDz0XeHr0Ctbn6PYiEJZ2i7yKbQSHBk2vpHxhsgn7TdsLPkfA+SnpfGlUXCIIGYv4QxJjbSW3xQEgG53A7zAqcNM6gCUh2TIOAZet3X3Zgbuicffm0YqB+i2t2qAedrnVcGWLxSKrkZ2s/rHEcLv+dQIZPXNtS3KLx2u/YbDDtjixi4NjXALCDW1fNUbHIRU14LvCB7dMMZNFkwPJuP3N7kfK7EL+5cOb0tVZb46Jg1aVCdSOB8Jif1H5tceSkxu4LcnZhQFSyZeqogpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt51+RxHKqvQDCmXQuTayStp4g274MNkeVIlj4dJPgQ=;
 b=C5chkUQNLD2XXOz3BCf7AC8Mi/chbx6ac97D5O15fJW4whzC3pAlbbjIt1yVGJJeFUmJ3orDLYE6PG48qrWo8sgBjQbqiLtTBB8oegUDXHla81Bm7ehfAWO4UcBfZ0A4pnwPMrdiFvX7pAjSEqA+grX1g8RshxXtiL8l1Qi7t4Nuv9pw92sjvXD01hDaK6iTB6fb83V08ky4odSD9CYz/WEnGAiX8DmVIIUUUf7WiUqpEajIA9vek+wySWp7VWkYY9PDaYCjQV+V+a7ieiyJ/RT/zHnEzfirZxhovYm38ujPvvjAzQd77o3zpNM98D/RdXQvMSBzgKmLxTWbDxXaTg==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS8P194MB1920.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:52f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.5; Mon, 19 Jan 2026 14:47:23 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%7]) with mapi id 15.20.9542.003; Mon, 19 Jan 2026
 14:47:23 +0000
Message-ID: <BESP194MB2805945B3C37DE7E15F9FB45DA88A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 19 Jan 2026 15:47:20 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] tools: Fix error handling in fit_config_get_hash_list
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::17) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <b04e5f85-0fc1-4fff-9a59-b99d58a79261@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS8P194MB1920:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d7794d-da4f-48bd-c453-08de5769a765
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/vW35cN/FPfX9pQBTcWOr6d18XNueeajm7GK/oQGQ3XaMnyntpsjTE5MNyaWQZcX01Oxf9hHVgKO3YK5tQK+7so+f/SEYHKO2eaA2B+MWQSEoF13SDUN8oOfNoEEALjMrDhaYwW7WzO6s7zBgnlLypRZ+PQEzHBAtDp5uMwLJX4U7Hdqt8lSPr6553S1WpnNNIGRICnkNoSuDGty/VraUiZejN6AIKkZ1ZGz09/oSgD7jQTGMfdD+GhwyMUNS7Sal9ifjZ0bN/jSn7US65KvS4cBMUWsUsYMMX/5pNKG5wyOy/kqhWfYTcVlcRf5frEcrVXIxWEjjMv/xav7KJ3lkswSt+/mSk34QILGsWN3ieLwoFIgDN28CjUJCFgAxKJOkCGWjaNhuPf5f2OYiuAAdmRrVNJw4eJbvzMO4SkE2uxm4tSpVHrr3V0G0/jq9x4Yr6U2qXroXo9wpj/PI7uI5ob9wQQG31Gbd0dJIhRQAI4uVgxRPPEAbT/5Qwy2Q2+DCpIskfWGuUE2FgOG4YOIVp4xnWTLdgMoy7eCEkRVkNFnBLXO5SbrdxjbmvXMN8ZFD0TkfEzfxfXhsTIKLMOcKmSv1kCfr7TE5WTnqmNoe/mmDklltxXEJFEuvTjyi3PCg43fehanw70htF6J+1DahXE6MjnMdh/GxBwfKnkNPnNbFgRKVPxZYbeexCNfdyWClu7RTk9oGxs6/1fMuherPNCHmxI3vA7Wnq9GPIyE/z00=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|51005399006|19110799012|23021999003|15080799012|461199028|5072599009|5062599005|41001999006|6090799003|40105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEpBcWNGSjl3STdibzIrRlBXQU41T2xJNFdVNGF6VlRvOWZ0VTlzdVlJNFls?=
 =?utf-8?B?VnlNMUlySlBGMWpUaktGTEpBanRCa3lpWk83S1ZSSWN3V05UclJmZG1wcUt3?=
 =?utf-8?B?U1ZoOWhCa3BjMHVRQ0hmaU1HNmFQWE5rY1d3RVc1OWEvVW9LcjRDeGh1eTdt?=
 =?utf-8?B?ODNDZmVma1pSQ1h2VUNZclBiRE8ySk9VV3BXS3FGSWpvUEFmVFhkdE5wcWdh?=
 =?utf-8?B?dTZKbWhkV01IMGZEY1dBRkxtZXNCQ2xRWFJJWTU1azZoS0MveW1VTDVNZzY0?=
 =?utf-8?B?Z0UxTlVZT3d5YXVDQk5Ea3F4NHREM1Y2cWszaTk4aVdGYUtDVzAyUXhrSjF0?=
 =?utf-8?B?VUdOenVkVGQ4OFkyRTdaaWQwZm9VZDYrMC9xYjZjY0NkTU43bXdSd2hjTjRa?=
 =?utf-8?B?ejI1UGs4Q21iMUJYU3o2K0NJVVRualpSL1pkeFgyaE4wRm9CWll4WS9TdUdG?=
 =?utf-8?B?L0diVXovSDA3b3RjTG9Oc2ZDc00wVEdaYVdldTllYWpwcXVVaHQ1SEJqOXJl?=
 =?utf-8?B?NEE2Wm9RWHNFdUdXbFh5K1NCRFVtY1orTHJiVmoxTWR0ZzF6dmtkRUtDbHZU?=
 =?utf-8?B?NWxrS2RvVkhVTDRueEFHNCt4dDF4cE44SyszMlhFZUsvNzBSQlUvc2M3VmMr?=
 =?utf-8?B?ZStGS1hlSEMvRWNyOFlrWHo5TU12aXR6U2NuNmdVcXRWTVVucEt5U0RBeU8x?=
 =?utf-8?B?MlFIbWx6MktSNHpxT0pVbW5zaGx4UytWNU1lTnJteTFrb0xVcFUyQXB5WlhK?=
 =?utf-8?B?R1dZOUlnMFZwNFM4Ym5zaTFreGw0MHJ1cko2N0RLYUtRSDVmZVJNOWhUa3RV?=
 =?utf-8?B?K2tVaVZlSWpGK0NKNEppQWUyUlByNDVGWmVnQTZhZGd2bnc5YmRiRk4rOFo3?=
 =?utf-8?B?b3lFRTBKeGFTRHFyaTA5ZFdVd1FOZEVNOUkxejRRWjAzckZoNlBRZ2lIUTVx?=
 =?utf-8?B?QXEzaUdiQThMVUxxMmNZWmpUZHgwODl6Uk45YVJJNkMzd0NVS0dHYzNtQ2N1?=
 =?utf-8?B?ckdPQzZRamJpMzdSV0prQ1hMSFZxb2FFN3piRTJKSHFRSzZ1My9wdHlWa1Bt?=
 =?utf-8?B?cytEZXpnMi9SS05WeFhMYXhLNVdDWURSa1dlMUlzUnFCSS9tZ3ozZ1BLY2JK?=
 =?utf-8?B?WGh0ZFRFK1BFcTJONTVDYlZmaTJucTc3T1NvaWs0Y2xhaXBhL1Y2Zi8zQzZL?=
 =?utf-8?B?bUQ3K01QVmUxVzRFRVVqckpPWjJsUHlSS3RhRzdCc0s3VGo0eWgvb2krc0dv?=
 =?utf-8?B?eVl5SmFETVdIaVpINDQrZVN5a0p3RVF0MXRIS3lPTUJKMWJVRWEvWmxmbmRi?=
 =?utf-8?B?czdPR0lWL0VteTlBdUVBWktOQmxLQjZPK1FOVkQ4U21ERzYrQWdpeGZDWGpt?=
 =?utf-8?B?VmFOZ1dKVjF1M0NqbDhQNjlZNGs1RWExS3RueXk3azdVbTUvejRtdGpyUEY2?=
 =?utf-8?B?ZlhoNzdEdzFDd2x6NXJaVnZpcHBjVUFUWkZHVXl0a01RL3BlSmRZd0t0bHoy?=
 =?utf-8?B?anJQalNHZUw2Ny9MeTdCNVZsdmZMRjlhaTE5cWhWQUhpSTlxRWlIbjlWT29R?=
 =?utf-8?B?N2tjdDl4ck9BNDlzc1dRZk1QWWdNR3hXdlptbVhuVTNzOGd3S24veUxhbGth?=
 =?utf-8?B?eUFRV09LdXoveW9kamZ5RTVQSFlnVVQ3dTRhN092eit6RUJpUDQveHlpQVFF?=
 =?utf-8?B?aGlOdWhhaTFRSzBnRDVTaUcrblYyU1B3NUdCZXBoRC9jM0d6dXpselRSL2Ir?=
 =?utf-8?Q?l9JH4zm1XmOXmUjnzQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDY2RFBGUDFwQ2M2ekhzQjJQdFlWK2hZYTJBcDZKRHhqZmIvSjhXcVJlUkE3?=
 =?utf-8?B?eTNQWWs0VmN2K1FubzhqU2NaRXhQSGZGbFhEd0dBbGh3SXdISm5lZDRsQlFF?=
 =?utf-8?B?WDBoemRpOFNuODhjcjdQRFBkNldFbHJuNWZDcHIvcUdNNHYxbkFpdUtMdVJK?=
 =?utf-8?B?TE53cURzMWY3OGN3VExXbWFCSWlDdm1Vam9VekNiY0xTL20xZ2NleFJkQjdi?=
 =?utf-8?B?RGE1RlNldFdVQkVESnBDcmtrYU1qRUVSb082V0xjWndsQmRiVERKMk05N1ZY?=
 =?utf-8?B?WWRiUk00TlZnT1ExNE5mTFl2c1RNNUIwSFIxWmo5M0E0bEhkN1VJVk54M3V3?=
 =?utf-8?B?WWI4Y0dyd2NIMXpYNXloSEZtSXhkaXR3N2tRUEFZZnZTSjhtOSs5Qi9FZU1Q?=
 =?utf-8?B?T1FwUXZMM3lkNWVJMmhaSzRIY3NPWm9CSVE3SUlsUlhaT083akp0WTZtMzIv?=
 =?utf-8?B?YmhCZWZoQ3g3cWRPd1pMUDl4blk0RWJ0d1lqWkdZZ3V4WEEySHlrbEpsenFv?=
 =?utf-8?B?cFZoS0dDU0hEbXBlK1NjZnRzZEZRNDhoWEtCWlJ3MWJiZ3Q5RW9qY0xhT0Rj?=
 =?utf-8?B?Z0JicEo2Smc0NmJoRWRpNVkyTWhWYytGSmtkaS9UYVVaL2lEL3hVUGdaUVRB?=
 =?utf-8?B?S29YNFF4eDh4QkZSVWtFM0s4emlkQStrMHRHYTIzV2lUak1HWFJyNGNMSEk3?=
 =?utf-8?B?SHl1dHBqL1VFYi8rUlRXdm1vMUFZVDV4UkVBN1JZcVlZUmYzNUx1Zkx0Mzdn?=
 =?utf-8?B?dEYxWHgrWFIwOU92dHF0RDRWSVVabXozbVYwUFNkcHdTTlgxKzdrdUVUT1lB?=
 =?utf-8?B?MUZybDEzSWIyaVBWTmRtUmJwRmhyVnFDWWlVTHFKQlhLb2RvRHFNY0wyZ1Jw?=
 =?utf-8?B?dDZEamgxNTlxMk9iK0pubitTakhnZzJ1U01sRXk2M0JqRlljdmVlWGRtWVJh?=
 =?utf-8?B?cDFDLy9KdkdkRnpmak9oTFVEWUs0TSs3MzJXdTdVV2Y4ajBtK3BteEI3K1VV?=
 =?utf-8?B?MGhTRWFFdC9Cak5wNC8raFBkWlAyd1g2ZXlhRkQxZEpDaDVqdklWUnd6Wm9Z?=
 =?utf-8?B?bzUzait4cWJXSkNzZjBKY2Q2Yk1HcndaQ01jaWJkY2t3Z1pvUUZmUVA1b1JP?=
 =?utf-8?B?L016SWxja1N0RFJHc3BxTm5MZW5wK0tpOVplMmdKUjg1eWp4U3VNZWZRcWxJ?=
 =?utf-8?B?eWQ2QTl2QUgwNm1rQmhtbWRXTEFHMVE2WU5JWHcrYU9ucXpadlNKMGhjVGNr?=
 =?utf-8?B?QTZBbEx4NDMyUFNjY0lraTYyQk9Dd01sbHFEWHluRERBNEt3MDJpSUJHT1pP?=
 =?utf-8?B?TnhJcUpLTlE4azVwbHRpTWY2NFlXUW9HSGo0bmdrbnBMOFArS2JYc2Z0d2sx?=
 =?utf-8?B?YXk5VVBjOGJ1eWNBVGxlcXBrQnJ0OWN0cUM1SXRtaHlQMGtJcUJ1MlY2M0xC?=
 =?utf-8?B?YWxVL2YvYWlEUUFock1ScUN0bmhmOHEzbFg2bGZLZ0FVaDFxdU5Objd6OGlN?=
 =?utf-8?B?bS9iMGVTWnpzRXFjMll5WVh0UmhLcDV6NWlGQmUxT3JlM1pka2ttR0hHbWND?=
 =?utf-8?B?K0JrUXRWb0VqaVZYSFJMS2gxMCtQRlhFV3cybWRiTFNyTXFBNUxsbFlYWDVl?=
 =?utf-8?B?aTNjYzhTN29EQ3JIVUxka1J1b21MeVVMYjZpQ1BOMStENThmeWF4aTg0N2M0?=
 =?utf-8?B?T2tjKzdMRmxMZHl1ckxZNThIcjdZVUd4ZnhqeTV6cWZXYWNzeHg2K2wrQzNx?=
 =?utf-8?B?YWhjMVkxYTZHcWZybWFIRmxKbkZCS2R5aXdMbU1JMnZSVW5sL01lKzBHR2lL?=
 =?utf-8?B?Nlh4M3kvRTVDYnozVE1zYzVHNDBvVjFWRXFQV0tvRjhlOWs0dFJWNHZ0bzBJ?=
 =?utf-8?Q?Zw6mk8C8Dj1CS?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-e7640.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d7794d-da4f-48bd-c453-08de5769a765
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:47:22.9488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB1920
X-Mailman-Approved-At: Mon, 19 Jan 2026 17:33:56 +0100
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

If an error occurs in fit_config_get_hash_list function,
one needs to free the node_inc string list.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 tools/image-host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 48d69191c92..635a75afe5c 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -924,19 +924,23 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
 				if (allow_missing)
 					continue;
 
+				strlist_free(node_inc);
 				return -ENOENT;
 			}
 
 			ret = fit_config_add_hash(fit, image_noffset, node_inc,
 						  conf_name, sig_name, iname);
-			if (ret < 0)
+			if (ret < 0) {
+				strlist_free(node_inc);
 				return ret;
+			}
 
 			image_count++;
 		}
 	}
 
 	if (!image_count) {
+		strlist_free(node_inc);
 		fprintf(stderr, "Failed to find any images for configuration '%s/%s'\n",
 			conf_name, sig_name);
 		return -ENOMSG;
@@ -945,6 +949,7 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
 	return 0;
 
 err_mem:
+	strlist_free(node_inc);
 	fprintf(stderr, "Out of memory processing configuration '%s/%s'\n", conf_name,
 		sig_name);
 	return -ENOMEM;
-- 
2.43.0

