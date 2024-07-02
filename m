Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B646C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80848871B;
	Tue,  2 Jul 2024 15:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="hIF7A70X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73200883D9; Tue,  2 Jul 2024 11:42:47 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3899487702
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 11:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5I49SDiRgeR5ac7uEbQ3UGOsZc43jYDcrlvLNW4hP3Js9G3i8gtNAtqO4MkdNNmBRzAZ3U61tvUniy+jMbNMRzCvNcsWIdolQYCLnzxQrCf2hV8EC05iwa+SWUjHndqVsQmHjMcyCYAKNePYZBO9k1Sc1aVshQFqFgMMFbCwzYwJUspu86EvH0sGaSmvOqp0rR5cNFfOKPvzjwHKekEoZteZoGRXCxJsR/GKebRc0Fz7IDgnI0eUFZXOhOAFmDKc538Q05GUyktLHV/+83bafAMIk+25xgeIdQy4O4gzWiOJ4e1cR8whKLScqwH8Y0Ynoo6BpwIs8jFeuWSSrKZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXP0xiD1pQF+YZF8XQJmThRp3qtCPxeDUjv/nfS4Pek=;
 b=bvqVn+Ris5+FDBYkMPMTEEIkcZHU9cz/TkTA+46rZXiFAXn3ejcukRLondnlo2tTLAFALoEh1HT1U91X+WiLJSvRarl/c7PwvunvrqUr6hoxXC3rxga8+qPLR7Rqwtd0nxspHjdPUCnrzZfL0wj/ehs0Olcf5omllTQxPVes21der8kAKZHOmHxTb9W0WTE5fnKOCMcPGOU7humusVoWc4MRKLsTFBBUMjZkK86B/iaKEeSY+mKCOqM5jck9OdJ1bY1yJzouVoCz+ylNw/FFMYDpMTdBoLRBMh1EbWpR9PtzlDRAALLK/A2/uHgKNNr2M7CTL6L8Him4r6/+YN4/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXP0xiD1pQF+YZF8XQJmThRp3qtCPxeDUjv/nfS4Pek=;
 b=hIF7A70X1iGr3lpGqhbfduxB9dO3j8OdJx2Q73N1CgpiLOTHuiUlPD72R2i/kpu/yQjDD7YNoFgH9yugz/dPryGOf1ykjnlHT2zz3Dqfmf9RrTwV9ErVasMNHK5dY++RN40p2TEOUYTAXHGkrxNB4XFu//f4Y+f2tE2FMl2SR0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10219.eurprd08.prod.outlook.com (2603:10a6:800:1bf::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 09:42:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 09:42:41 +0000
Message-ID: <dd3453b2-2ad6-473f-b419-88a7577fded9@genexis.eu>
Date: Tue, 2 Jul 2024 12:42:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpt: allow spaces in partition list
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>, u-boot@lists.denx.de
References: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThsS2oYVx3zxZhN6HSzHkA-NStydZfS=Jr25FpwRimJNA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszThsS2oYVx3zxZhN6HSzHkA-NStydZfS=Jr25FpwRimJNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10219:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d44f11c-10eb-49fb-ecd5-08dc9a7b50f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S054Yy9QWDdLbVBFbTdZeU9PUFJNSmJkc3lUekVJcXp3Q294ZEE4V2ZBTUox?=
 =?utf-8?B?bDh1a2ZhdjN2ZnlxZ3lWN3phMXEySkNIU2E4NDJ3VVN4Wk9qY2tSbzloem9K?=
 =?utf-8?B?cmF5MDliRGhvdUREQkJ2VHFyMm9pUGQ1SWtYRERQMjVMOGwxdjlEVTBBTHZa?=
 =?utf-8?B?L0hsQlRLckw1bUI2REpVVFZ4WWNGbUZacGFEOFBmZnByQjFlaDNmajdhWmFC?=
 =?utf-8?B?b0NWV2pjMGNoMGd4U1M0VGRNNWt6bjJTUjBoVFBUMUVDUXFuWjNIcnZtbzZv?=
 =?utf-8?B?cVB5ZlFxbUUzeStydHhxc0lTcHkycFI1S0dlbHdSbFJoUlp0NkFFRXhRaTlK?=
 =?utf-8?B?VkE3Q09lOFR1N2czTEcyTmRhazBIRmR3QXhXQ3BxVzgyV0E1T3BsR3RqTDdM?=
 =?utf-8?B?YVpYZU4yczJRb0NHTVZDRUxRZG40anhOVzlrRU5kSmRUTW5SWGRENjkwZTdH?=
 =?utf-8?B?R1VYL2s1Wi9DaVFXcFBqVng2S1pBL1EvcTNDR1dmRDZvU2dSdW9IZGFVWllP?=
 =?utf-8?B?dUxDbWRuVTVyMG1Ic0lwMDIxWUUzbnNWaTNBU3lCaUdoL0krdk9xbkN4bDcx?=
 =?utf-8?B?dmgxcWlqRHBqOXVCbTBwc1RCMWdMcTZ0bUVwODNYV2tLOUxIRnpmRDJXMTJY?=
 =?utf-8?B?ZEdySHFlSVV0SFZndzF2OHR5RkVVd2REbjkrcVZQMmdHQ0Q2Z1dBQUM5RWpv?=
 =?utf-8?B?dEUwOGpBUnZnUDdjVWNGaGlGSkNON1AwcmVFNVNvN01IV0p3SHo2S2hZZjZJ?=
 =?utf-8?B?RE9VQ041OTl5cTk1NkhDNlBTaEVEc0xPMHlRVlpUTjhLN2gvVmlLTUNFcVh6?=
 =?utf-8?B?cEIvVktIRUZtZzRjQzQ3dGF1anVaM2ljeEVoU3cyT1VxWWM2YnEyR1J5VFlu?=
 =?utf-8?B?SzBOWDdRTUd6dzdaU1grSWRaRFRkT09qTEFZc0ZvaHE0T3ZQQTd1WHh5em9R?=
 =?utf-8?B?OWNadmNnWDREdW9DTDFjOHZmQmltKzlIWjZCWktWWVhEQU9NbzlGekJRQWY0?=
 =?utf-8?B?VE8zK1hxS1VOcTk0bUtSbU1wQ3lqTkR0UjBQKzFpcjlMT0J5NFppek1wMFds?=
 =?utf-8?B?bUhaVXBPMUJaOENBcEtOdnkvMnJOclliRWNBWGRFMnkzc1kweWd5UHF3T2dw?=
 =?utf-8?B?bm9lcXF0NVBTd2RScWtSem9WdmIvMzlsM3BTcnlnTG1HR29qaFJTckRDQWk2?=
 =?utf-8?B?SkRyNW9zNjVkdmRLUzNGZU9hY2hRMDNYdXc4K0dINC9hVzdCNlNJeUo5YzJE?=
 =?utf-8?B?UzlXWExBZnB6V0s2b1VoMTlXUG1IeWRQZzRXNlV0U0VhZW1lV1RTVFBwS0tr?=
 =?utf-8?B?RTNCTjh3cG5sV1RQbCtoRW54M3Z1QnFZYmNxMXUxY1MzRDVvZkx3WnlCWFdj?=
 =?utf-8?B?N3NtWWdXUUtBRkhkT0F1aGdlWVkwaWMvQW9ZaU1hOGRZdHVDUkJJSFo3KytP?=
 =?utf-8?B?U1g1Wk1xQzFPNVFsaTgxajNWbjNMTVRCV1FrQkJBbGVXaU9BUDFaVjl1MDI5?=
 =?utf-8?B?R0xTTlYwdW1hN1czODJyNkJxNUFiR0d1Uy9INjd1clYzNTlIalNLK2hvMTdU?=
 =?utf-8?B?b3FBOGIrMDVsVlBkZjlsM2dZb1Bqa3BpWHNCK1lGaHlSSTNFaisweC9lRmRs?=
 =?utf-8?B?NXpXYUhmRGZmMFNaRmZVcGpHOFVEUURDV1dZNW5mY2ZINzR0YStzbmQ0eURR?=
 =?utf-8?B?VXRBK0UvTGpZTnB5b3hoSGo5U3c4V1NocGY0ODBnN2xnWGRGVTVyODJ1S3pm?=
 =?utf-8?B?VUpHR2tCZk42aE1zSFdnK2xMSGQ4S09rMnJmV0REVmRGV0xTbTRuSklRZkFz?=
 =?utf-8?B?aEJrK0k3VTlxMFRGMFdIdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElPaWZ0VFdLb3B5MksrY2R0bDV5MndDdmYvVzQwaTQxNGVpakxIc21jeTdC?=
 =?utf-8?B?c055eXF5R3FMMGQ2czM3TWFaZ3NpL2hHVjhRSk51TE03ajF1aG1URXlTM01Z?=
 =?utf-8?B?TjFLbEpvYVd1a0FQZXhucFRwdE9id1U5V2xab3ljZHpRQXIwbk1lM0RWamEr?=
 =?utf-8?B?Z0V5UDVqY05ta2lFTHR2THc2Zlh1SmJiRnZsWnZZUXhNS2VFemg2L3M5aWFy?=
 =?utf-8?B?bHhlRjloNllpSFdtSkVSZ1dyalErcTkxNEw1YzdraGZGcEN1MEt2c2dhVU55?=
 =?utf-8?B?SFB0NEMzeFhob1EzaDU5blZjSzg3RkRMSFNXS0l4eVY1Ui94NU9FWlhPRk1M?=
 =?utf-8?B?dGticTBVKzVPM01oV0tyZGszV0tXbHNQSy9NUURvdWMyWE1IcWRLT0twTGlk?=
 =?utf-8?B?TjYyc1hlMms1YTJ2WlVtNGNuUmtWNkdWSCtkdzJqSi9sYVhPdGlTWFZJQkpj?=
 =?utf-8?B?Wmx5OXJ0RkV2MGpMUTJKMFRwQnJvZkNVWWNQTHFhbVZ3cGM1a2ZZdExiMnhS?=
 =?utf-8?B?UUx1SmtlRTBqdHZncWZSZWNlU000YXgrN1RXckI4bU5JTCsyWUxDODRCc3hG?=
 =?utf-8?B?S1M4SUxGRUVORE5KWVdCRHNQeFBRNHlsS25pTU5HaWp4S0hjcTMySGJ6cm9I?=
 =?utf-8?B?TEU5OFk2OGpUUWs0VWRLK21UbHZSUWRFMFI3UFk2RjlWbkNrZzFXN2dxYWht?=
 =?utf-8?B?WWk5NnhSSFg4UjRvYS9HZFUvWVh5c2ZPR21FSDluaisvSURiVHhFZFRTL3l3?=
 =?utf-8?B?OVgydFBrcUYzd0xWSk4wOENnWnVZWHZ4ZjZVTElVcFMvazMzVXNodFVrRGZU?=
 =?utf-8?B?UHA3V1YvU282OVB6S2RpUVg5S3RSZEFlcWFOdnZycVRQSmVITVRTajhxaGky?=
 =?utf-8?B?K3E4T2lSWjlPOEdqcVdZMHA2dnpZbjBJczZreEs2VzUrcjdIMlJMOFE0clA1?=
 =?utf-8?B?UUZ3SGpFUjdPV2xsdVNUQllobWt5c0hFU0xrZytDbk9LZkhwb2ZURSt5RG5j?=
 =?utf-8?B?UTNJcGV0YmJ4eHhtS1pHNGFQeUNuMi9oWHMxUlpoNTAyN3NXendxOGQxOGE5?=
 =?utf-8?B?cFBXcDNNaHhrRjhsL1pyTEErWEJ5Q21CV1NQQzRXMFo4ZElWZlBmY0ZleGxM?=
 =?utf-8?B?S3VST1NyVWJUeE52MFBFS2RvdFV2ZGFuaGFqREFpeEowN3Z3V1pkdytuYUtv?=
 =?utf-8?B?bkdsR3dkWnVZeStmb2VSTUZmTTdyWTh3R240eHdVakhINnRzekVWY2FzR3du?=
 =?utf-8?B?blVETjFwSmtJdlNUL2o2ZUJGSCtXeHAydkkvanhiRkFRbTd3RWxvcDIyQ2dy?=
 =?utf-8?B?SS9wWWIySUpDNFNtT0VwWUh4M1FRWi80VVYyUmF2b0U5WklLdkkzcXEwTHl3?=
 =?utf-8?B?T0tTYURjb1pzS0oyd0VVTkh6YWNqQVAvWUdkNVNSd2F5N1RUR3I4WVNQNnVP?=
 =?utf-8?B?dXJxUllhUmhQTWhKSEdCTUNzeVRxYjcrNm9kQThJMjJSL1d5SkcvK2MxQkww?=
 =?utf-8?B?N1pmY2NCdkpXNUdoNmhQN0F4VHQyQWx4RjZJcEVRdXpuNTdibElNTmgzV1Rp?=
 =?utf-8?B?VDNiODhzdjR5RnBVVVJxc00xSC9ES2tHckIrRXJUcWVoZmRHUzZlbmtGKzBQ?=
 =?utf-8?B?UHFQSWJnTHgvVWFCeDJBbWw3bnFDWjJmK0JGOFIwV3ZLQmdZUitwcUhQSzFD?=
 =?utf-8?B?VUgybzg3ck5Qd0kvOWpzSnREeTl2d0sxd1R5SFFyNzZSV2ZQbnZvVzY5eUdC?=
 =?utf-8?B?NzdTWHFlVGNsNVI4aXZXa0FtNlZyODlWaTlJTlNRNlhLUThSSVFIQU5lbGN1?=
 =?utf-8?B?T1gwejRqWTRweFhPdnFWNG52NStqWE5JRFVSMVVoQ2NLR2V5ek1Ic21RbWRk?=
 =?utf-8?B?Tkk1dUJkK0VPc3ZHZ2ZtRlJrTldLNGUvS0djQStqbzVZcnFuOHRYMUEvQ2xp?=
 =?utf-8?B?KzZBd3NNVTFBSTBkR3U5ODJabTYvQTJ0WUJVZ2tQRGxkUkF0cjY5ejhPSzVF?=
 =?utf-8?B?cCtsM0dlcW81eFk0T3N4Q043YklVdGlhN0Z2RGQ5U3A1eFBtaVBpVlVUTVZG?=
 =?utf-8?B?Z1N2VE1Xa2J6cThEOFR2QTRQSUFMTnFQbTh0VElobnBoU1dXUytqZWozaHND?=
 =?utf-8?B?RmRBTXJyZlVIVnJCME5yVmd4REVFL1FPUkg5VC9USThoRDlITWNlbUh3R0Zj?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d44f11c-10eb-49fb-ecd5-08dc9a7b50f0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:42:41.2817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD4PCUBgKmeUnPj7weGmZTn+sKgLb4vTnCjJADLdKJTNvM2YZIYbZQH2jQ3gERpZATtYKhW8M4Ni1BIGiXAuwsERk6QopzZgF1XULoQRiNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10219
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:00:15 +0200
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


On 27.06.2024 22:05, Simon Glass wrote:
> Hi Mikhail,
>
> On Thu, 27 Jun 2024 at 12:29, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> This allows spliting partition list to several lines in environment file
>>
>> ex:
>> --------------------
>> gpt_partition_list=
>>         name=boot1,size=5MiB,start=0x100000;
>>         name=boot2,size=5MiB;
>>         name=rootfs1,size=70MiB;
>>         name=rootfs2,size=70MiB;
>>         name=overlay1,size=20MiB;
>>         name=overlay2,size=20MiB;
>>         name=art,size=4MiB;
> Is this referring to a .env file, i.e. a text environment file? If so,
> I would hope that spaces at the start of a line would be automatically
> removed.

This is refer to a .env file, so starting space/tabs will be removed,
all '\n' will be replaced by spaces. Thus we will get a single line where
each partition divided from other with a single space (like below)

gpt_partition_list=name=boot1,size=5MiB,start=0x100000; name=boot2,size=5MiB; ...

>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  cmd/gpt.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/cmd/gpt.c b/cmd/gpt.c
>> index 7aaf1889a5a..2b29ab98ccc 100644
>> --- a/cmd/gpt.c
>> +++ b/cmd/gpt.c
>> @@ -117,6 +117,7 @@ static char *extract_val(const char *str, const char *key)
>>                 k = strsep(&v, "=");
>>                 if (!k)
>>                         break;
>> +               k += strspn(k, " \t");
>>                 if  (strcmp(k, key) == 0) {
>>                         new = strdup(v);
>>                         break;
>> @@ -151,6 +152,7 @@ static bool found_key(const char *str, const char *key)
>>                 k = strsep(&s, ",");
>>                 if (!k)
>>                         break;
>> +               k += strspn(k, " \t");
>>                 if  (strcmp(k, key) == 0) {
>>                         result = true;
>>                         break;
>> --
>> 2.43.0
>>
> Regards,
> Simon
