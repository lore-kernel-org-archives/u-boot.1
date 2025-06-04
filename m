Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCD9C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 14:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32EE68091A;
	Wed,  4 Jun 2025 16:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PZAMvhpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC17481E25; Wed,  4 Jun 2025 16:27:35 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189998070C
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 16:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp5gi3lIwfByI6DkNygcmMijf0q2FWlVczS6+tOXRRhCxH/M6kWpvaeeP92/oSaQW4QC8LaVt6cnUHCJunqcPnC63yq/DnB2RNsRUz2xUwYRKO+YY+a/WJr6AVlOvQFZcTELS+MEnjPwUwWEkg6FYcE5DasEzYiVlzKkCUtAbemRo1T0izIsyIR3WSlQU/ZnbRwEy376vdNh8RyhoTbTbCp07yt8oFi+aIhxXW4t9yaPwIz92TDI0u8vJ7Lysy0t4hmg+8QxF6osaaQbQAwOYGTm8dZBdr8LziBgOs8LQ9DCMp4EKA2CAraUWSeMWM3p449Mzte1ghMsy5UYWpxwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00AUNZL6c0GngA+JiXFGVdgqzqfVS+1xVxwDiAVbHso=;
 b=G+pqEf3Ed/eGs8BZCB2w4N1kCzumgt8HoklcjH07HzlAKZJAN8AdfbpgSz49ycOOe+FNSKuLFPvz7RQ3gznmaj8f/g8CuJ901TBT5gi91c8GA6nJwVEgovXAlyoP7mH32OoNQXQ6xJeR/2ta3CrfdPrNYhCvCVTgTnPaMBYtSAn3pFb2BeZ/ofbPgf8Jrb8tegMprRnOwUX+FGFMQAnkjuzJfCDqVrFs7Q8+JLjZr1wE71LmUX0wz+z4cGBDtOifvLGTUd9HUM7i2p3SqtaoZTDP3kXqyad2kWwf1BSQtY0Tr+SBeeSCB7rTT7fvxzHr37AXu1rvjfBWUqiKaBFZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00AUNZL6c0GngA+JiXFGVdgqzqfVS+1xVxwDiAVbHso=;
 b=PZAMvhpwYSP9kgZZW0p4aYzrALqMNeqK+jE4vJg3r0MBiQBe9NYwGDzI9tsrt+DcVsrhrnhfQ7G2J7OeU6eD1Z19G7GCUQg4pNUmKjajrF8mXfVI0Laa3cRqUzUwvfJgNj0BGy9n4YjCP4QSoqS/f2N0IVFc4nJFGVM5tGmYDwJqO3tU0RZ0bk7HtNfNlw2ul3UKK5Z4VxjGqO/tDQodKZRoJ/E5n5CtQwAcKGLM9iGnTaX4ixvkL7klwKpit8Hn0o0nTn6ObNKqPrhwidr1PWImeh0Hp+H79cY3I8kdknzkkarHmYZPemgxIzMUCtjZ/ImpJ/Ny7DcJ33iddzKzPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB1972.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:9b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 14:27:29 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:27:29 +0000
Message-ID: <1853ec06-ee58-4593-915f-aa900eee6cac@phytec.de>
Date: Wed, 4 Jun 2025 17:27:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] bootstd: Add implementation for bootmeth rauc
To: Martin Schwan <m.schwan@phytec.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
 <20250604-wip-bootmeth-rauc-v3-1-f9fad913c57e@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250604-wip-bootmeth-rauc-v3-1-f9fad913c57e@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::48) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB1972:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a7e6ff-e241-4956-3c36-08dda373ef62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTh2Zld0MExtUEdzMnJaR1BnVkdlQ3Y4YTI0VTJ3UmpMdDVKbmRRWnVCNjZm?=
 =?utf-8?B?enFBTnFiRVdYWWRldXBndS9Tc24va2toWnJETzdiWStBZ1JNOWl4bHVQSDVN?=
 =?utf-8?B?QjU1LzhiVXZLTVllTGs3MDlITW1JTmJVa3ZmZENkeVpWT1h4WUxQV0NtRExT?=
 =?utf-8?B?QlZCdnVrR1p5YVBGSnJKa3hCK2JQZ0poQ3NSem13and6ZncxUHlSUm9sSXQz?=
 =?utf-8?B?VnZwTld3czZ5cGJEWjdNL2R6VXYrUGJDTFp2dzNwbXdFc0kyMzNybXMzYlF1?=
 =?utf-8?B?SXZKL09sNmpDUUhGSUYxQ3VXQjRKSTdQei84L0ZuMmdQelBNSFhqYWhnZURl?=
 =?utf-8?B?MjE2eVJqQ3lFUDZ1UWhLcmhWZ2NrWG8xQ253Q0tha1dRcDR4d25PdFVWc1R3?=
 =?utf-8?B?eVd3NGM2SHZETDJLZXJMMUUwWWFwWW5uVDRTTFd2Qm1ZM3pSelVQeEF6dk9h?=
 =?utf-8?B?U2ROaGRrWUVnRkxCMXVUb09JS1FjT1VOVnRaRWFTRGczTEMxVUJWbmhUZVB5?=
 =?utf-8?B?UzJGanA1eXBSMmZUckJ4d0Q1YU1lNzA1U3A0UjdSTGRkZnRUZmMrU1RPTWVQ?=
 =?utf-8?B?TG4za0hvbUh3RDY4bm9JUWNxSUlHcEljQTFlZWdRN3hNd0Y5T2tNeUUxQjg4?=
 =?utf-8?B?aWk0elFxNnh0MzJ2NWp0MGViNlVWN3RVVldTeHJPK3gwWkVhS28rR0JGcHJ0?=
 =?utf-8?B?eEErWGpSTHZiMzFoQ1FFbXNPNDhna2tJZGFucWdPQlJOa1owTnRhNWtDQXI0?=
 =?utf-8?B?ZUF4b2NUdlB3czBkZnZraGpaOUozcnFwRVdnT3JDQVZ4VUFkWTh5b1ZpeVdV?=
 =?utf-8?B?emZvckt1M1VlZGsxc1pLcG81YUNZcWVHTXQrZDMyRFhIUE00L2Z6VmNGRUtY?=
 =?utf-8?B?WVdIUW9vcld2MDcrdi9JOElCZGhiVlk2aTlJZDRiaUNTRGlncmtDbG02amh5?=
 =?utf-8?B?OHZlRUJ1ZlJuWnlDS3VPWGFHaWxTU0Z2c3lBK1BtVG9XNVRHTHdNY3VabzRj?=
 =?utf-8?B?QVlhdmdYNjN5MDVnYldGdTZ2SVMyTTk5bWdZY1g4QjdJOStXRzdlQllHOXRH?=
 =?utf-8?B?Z3NiMU9zMDYrSFl2V0h5NU5QWCtPU3dOOFlQWmRoaDdINGQyUFJJQWpJcVEy?=
 =?utf-8?B?SFR1R3BCdHVmMXhBM2RReFlEU1RsaHhyVWpDQytUQU9hc2dNK2ZQTU9xYlU2?=
 =?utf-8?B?Rm5sYkJEODM4TmJHdVRwZnpsMTRZOWN0SGV4Y1doNlNuSkxKTUNwU2dDQnBX?=
 =?utf-8?B?K1M3REZxRFNUZjR3WXNVekdCQTlZTTR3UWp0TyszZzBPVUdoa1VQUVRTTmFx?=
 =?utf-8?B?MXM5TE00WVFrSHUvbEorSnRmSlFnMDNGOHVQZzl5NDF4NkxtRSs3OHZtYnJv?=
 =?utf-8?B?NDlod2ZNV2tHUXg0cEtmd3VxVXJzUUIxWjlVamVBakFKbjRGT3ptaVprV1N2?=
 =?utf-8?B?Y3lPWnVJOHk4NUdGN0VGYW9oSmRGWDFRUHZMYXhMb3ZrL1lqNlZKc2dxMDA5?=
 =?utf-8?B?NVN6S2lBUXBXQ3R2NTV3NXM2UkRPa25wd2dmaitPYU0vL1hUa0RqK3l0NzZF?=
 =?utf-8?B?VWhkOEhJY1gxUlBNUTZJcVBMMXdNNzR2MGV3b0o2NnU3TTVWekpSM0ROUDhM?=
 =?utf-8?B?M0lLWUlqOU5Nc2dFcUd0UWRRWTZOMHpVc21LVE91WlRwSGtOcFNIZ0ZEQ3V2?=
 =?utf-8?B?WDZNYktlL2xrbW4xMXI5QnR0Rm04V3R6Sk1HWWRwQnBxb1czTG8vazZONldK?=
 =?utf-8?B?Y2pVRzdwczlBWkc3Q0s1YWJmbzU3Yk5KcEttejNadEdoOGFoQXczOWdZK0dh?=
 =?utf-8?Q?6/qWlLTEa4eG/TmdszOqrkH4rem7TOOQ6RWoE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktQbE81aUtWTXNlNXhQNnRCUkE2ZFg4bWkrdzJLUzQ4OEorY3c0QXRKaEZ2?=
 =?utf-8?B?ZnhXRUNVN29iT0tGMTY5bytvSmNGcWlrL3hPWTZ6QUNhd3VURjlMSDhFaW4w?=
 =?utf-8?B?QWNXSjZKRGVkdHZ0dzYrOS9WcWtLeWtKTUttS2xnbWpkOEhjMUJBcStkY3BY?=
 =?utf-8?B?Z3RvS1V2bjQraTF3NE9nSDVSZGhSVG5rZWpXbkVBWVFNSDRXMTBrMXJ0QnFI?=
 =?utf-8?B?ekpuWWNQci8zMHBUY2tTbEtWL2xOUUlLWWY4YStpMkdoYXZiSVBFS3lPeUE4?=
 =?utf-8?B?bWlIckN6aVZsQ2ZlWXRIaTVmdlpiT25aMm9xNXdXbGJOemJ5TnZvYjRGSzFp?=
 =?utf-8?B?RS9ZMzY0aUkybnRxV0VsdHZQRnRFb1pzak1jQnM1V3huT2JIMmlxTmtycEJz?=
 =?utf-8?B?N09nL3pBV0pZTFlIbXJYUmpqcjJOSEFtQzlNQ2VuQlVaUUlldWJHWWswYXRj?=
 =?utf-8?B?Nm02UDVRVUxGZzRkc0xBY3pGdERQdFpLZzhoRCtTZTlpNFp1UzFLNDhTUWwv?=
 =?utf-8?B?RVFCUTVlYWxIVm4vWnM5eCsxb2VmVStVeHdVeUNnZnVlWTEzZ2J5L09JS243?=
 =?utf-8?B?SVRzNFNNb2FyMGlaMUMwQ1VlN2NaSmpmK3NSYlZyQVBwYUpNaExsbWZVTGxk?=
 =?utf-8?B?VFB3RjZMZ21MUnd5Q3o2a1JtVHRxMVBFbEZuMSttTmpBS3ZYWHJPZjNCdW80?=
 =?utf-8?B?dXJWcGluZ3B3UXVYVEJpR3ZwZk1RbnBwMzNwV2ZtZWpyUmt4Yy9qdHZWbWFi?=
 =?utf-8?B?MysyYnFQdHp2UFVENkJJTktkdTV4N1NqWlZkSHltNU04N3ZobXpBWEhSRmV2?=
 =?utf-8?B?akFGWEtyUEwwcFh0UERmYzk0SjdoSzVBNmltZ0tPOGlEODd3YzgzaEh3Vm8v?=
 =?utf-8?B?TC9Fbk5JYzM0cXpkZFRkZlpveklWWXZaMWxyVTFPQ09BcGpKL0xHeXhvUjdv?=
 =?utf-8?B?WmZYenBSa29TK2xMdmk2clh1NWxiQmFEZFhHTWRBMDBrUlJITWg3d2tIMEcv?=
 =?utf-8?B?SlRBSlloN2s1OEt6TmdaeXNad0dSZnJHRVVVbjYwTFcxSHBtcjJWTk04MjVi?=
 =?utf-8?B?aXN2ai9oVTBKVTFJL05wcENjeTBPVXdXZHRhYmREQjJWUmhmWndsZTQvaUhU?=
 =?utf-8?B?cmVMVUhnQXVmc3RKdklSWFVuYjZ1ZHNIcnUyZVF3aUhaMXB1L1I5dFV3Unkv?=
 =?utf-8?B?YTVuQmlJa2ozallGZ2V4emtheUhwYytDSXFITnVqZkp6SDhUNE1jVEwwanFo?=
 =?utf-8?B?WVpQWW1LVXEraC9JM2NBUGxoL1A1cUQvOVJtMEwrTFh0cjduTzBlMFBBNmFH?=
 =?utf-8?B?L01GR3VFZzVVLy85VmdmUDI3Z0J3NFpLdlBzNkp1cTJod3hscVIwSnlBQ3Nr?=
 =?utf-8?B?dzJPWjM0dWdMTHpMY1VkMzZRcFdoY3oxWG9nUGkwdmtNTFBzaWNnb2dRVGhR?=
 =?utf-8?B?djVsd1o5VitYTVp3dUx1aU9yUDlZdXJKT2dqSWczQjgwRitaY2hEWGJySy9I?=
 =?utf-8?B?SFNHQ3F0QnNKbHk1WGtDenNUVkhHRXRINUg5Tlo1ZTVLUlpHcHVQa1VUOTNB?=
 =?utf-8?B?a3YvOC9YVFZIaTNVYkhHZjYrODNiRktOK0UzSFpiRElUMk5YbGg4eTVCRWN1?=
 =?utf-8?B?eGR5dUNyNHpxdHl1bzArVHEyUzQva2htUVVrKzNQRU9ZWlNTQ0lmRTZiQWo2?=
 =?utf-8?B?TnVzbGRMNlg4Y05kN0MzZ1R2RGJlMTM4ZHB0WkZOM09kRzVDZDYybEFuNGV3?=
 =?utf-8?B?ZjBzNjkxS1pxaEx4R05CdVBwamhIYllEUVFxZjJ3YmJMaGdvSmJmSTMyL3VQ?=
 =?utf-8?B?UnBTVTVqbFZmbXhYTHdaMU15MHpuL3QrUS9nU296eXUveHdCWGdyUVp6ckx0?=
 =?utf-8?B?TU9VMkhZOEdMZ3UvZUFIYzhrc0loTGcyTUw3bEVwWTFScC9zaWtZRlh3Nno1?=
 =?utf-8?B?dU0wcW9PNERxRkhvcjVLOS9iSjNSZHpWdkU4aFpMQjUrS2JuZjdjMHpBcmUw?=
 =?utf-8?B?bjU5VUtwVDFvTndaQjBBTGlvbFU4YWxOU29iUnBER1pRUi84cXV5MWNxaGU1?=
 =?utf-8?B?YnV6MExSYTNsUWpvNjFFcDhudTlKOU45NTBvcHh1Ump5UmY2ckNBV25JekVH?=
 =?utf-8?Q?0zBxvL+UHSIN90hhBsiDwGF7e?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a7e6ff-e241-4956-3c36-08dda373ef62
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:27:29.1747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GywsOzVy6HJSiJG6ebjMDP3z4jXj6PKlqQ+LDdkqI+luTon07i618cMJ+Y6NNGsXhtvKhyJ9Io01+Kk+itcmOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1972
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

Am 04.06.25 um 15:15 schrieb Martin Schwan:
> Add a bootmeth driver which supports booting A/B system with RAUC as
> their update client.
> 
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>

Tested-by: Wadim Egorov <w.egorov@phytec.de>

phycore-am62x log: https://pastebin.ubuntu.com/p/Sh9rXqPbgX

> ---
>   boot/Kconfig         |  51 ++++++
>   boot/Makefile        |   1 +
>   boot/bootmeth_rauc.c | 432 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 484 insertions(+)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 30eb5b328d7ad8a73a2e84812dd7853b66039164..a610cf9faf99cd5480f94dcac89c3401cca394ae 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -855,6 +855,57 @@ config EXPO
>   	  The expo can be presented in graphics form using a vidconsole, or in
>   	  text form on a serial console.
>   
> +config BOOTMETH_RAUC
> +	bool "Bootdev support for RAUC A/B systems"
> +	default y if BOOTSTD_FULL
> +	depends on CMDLINE
> +	select BOOTMETH_GLOBAL
> +	select HUSH_PARSER
> +	help
> +	  Enables support for booting RAUC A/B systems from MMC devices. This
> +	  makes the bootdevs look for a 'boot.scr.uimg' or 'boot.scr' in the
> +	  respective boot partitions, describing how to boot the distro.
> +
> +if BOOTMETH_RAUC
> +
> +config BOOTMETH_RAUC_BOOT_ORDER
> +	string "RAUC boot order"
> +	default "A B"
> +	help
> +	  Sets the default boot order. This must be list of space-separated
> +	  strings naming the individual boot slots. Each entry in this string
> +	  should correspond to an existing slot on the target's flash device.
> +
> +config BOOTMETH_RAUC_PARTITIONS
> +	string "RAUC boot and root partitions indexes"
> +	default "1,2 3,4"
> +	help
> +	  Sets the partition indexes of boot and root slots. This must be a list
> +	  of comma-separated pair values, which in turn are separated by spaces.
> +	  The first value in pair is for the boot partition and second for the
> +	  root partition.
> +
> +config BOOTMETH_RAUC_DEFAULT_TRIES
> +	int "RAUC slot default tries"
> +	default 3
> +	help
> +	  Sets how many times a slot should be tried booting, before considering
> +	  it to be bad.
> +
> +config BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES
> +	bool "Reset slot tries when all RAUC slots have zero tries left"
> +	default y
> +	help
> +	  When all slots have zero tries left or no valid slot was found, reset
> +	  to the default boot order set by BOOTMETH_RAUC_BOOT_ORDER and set the
> +	  slot tries to their default value specified by
> +	  BOOTMETH_RAUC_DEFAULT_TRIES.
> +
> +	  This prevents a system from remaining in an unbootable state, after
> +	  all slot tries were decremented to zero.
> +
> +endif # BOOTMETH_RAUC
> +
>   config BOOTMETH_SANDBOX
>   	def_bool y
>   	depends on SANDBOX
> diff --git a/boot/Makefile b/boot/Makefile
> index 71dafaefa76bca7896741dd896829575bd9e8f10..46f27e71856c598a866424cb93ee01444ea6a19a 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
> +obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
>   obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..fc60e6e355dabef4d58bf1203997b41d99c536f9
> --- /dev/null
> +++ b/boot/bootmeth_rauc.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for distro boot with RAUC
> + *
> + * Copyright 2025 PHYTEC Messtechnik GmbH
> + * Written by Martin Schwan <m.schwan@phytec.de>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <blk.h>
> +#include <bootflow.h>
> +#include <bootmeth.h>
> +#include <bootstd.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <fs.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <string.h>
> +#include <asm/cache.h>
> +
> +/* Length of env var "BOOT_*_LEFT" */
> +#define BOOT_LEFT_LEN	(5 + 32 + 5)
> +
> +static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL };
> +
> +/**
> + * struct distro_rauc_slot - Slot information
> + *
> + * A slot describes the unit of a bootable system consisting of one or multiple
> + * partitions. This usually includes a root filesystem, kernel and potentially other
> + * files, like device trees and boot scripts for that particular distribution.
> + *
> + * @name	The slot name
> + * @boot_part	The boot partition number on disk
> + * @root_part	The root partition number on disk
> + */
> +struct distro_rauc_slot {
> +	char *name;
> +	int boot_part;
> +	int root_part;
> +};
> +
> +/**
> + * struct distro_rauc_priv - Private data
> + *
> + * @slots	All slots of the device in default order
> + * @boot_order	String of the current boot order containing the active slot names
> + */
> +struct distro_rauc_priv {
> +	struct distro_rauc_slot **slots;
> +};
> +
> +static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
> +					 const char *slot_name)
> +{
> +	int i;
> +
> +	for (i = 0; priv->slots[i]->name; i++) {
> +		if (!strcmp(priv->slots[i]->name, slot_name))
> +			return priv->slots[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
> +{
> +	/*
> +	 * This distro only works on whole MMC devices, as multiple partitions
> +	 * are needed for an A/B system.
> +	 */
> +	if (bootflow_iter_check_mmc(iter))
> +		return log_msg_ret("mmc", -EOPNOTSUPP);
> +	if (iter->part)
> +		return log_msg_ret("part", -EOPNOTSUPP);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_scan_boot_part(struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	char *boot_order;
> +	const char **boot_order_list;
> +	bool exists;
> +	int ret;
> +	int i;
> +	int j;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +
> +	priv = bflow->bootmeth_priv;
> +	if (!priv || !priv->slots)
> +		return log_msg_ret("priv", -EINVAL);
> +
> +	boot_order = env_get("BOOT_ORDER");
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i]; i++) {
> +		exists = false;
> +		for (j = 0; script_names[j]; j++) {
> +			const struct distro_rauc_slot *slot;
> +
> +			slot = get_slot(priv, boot_order_list[i]);
> +			if (!slot)
> +				return log_msg_ret("env", -ENOENT);
> +			ret = fs_set_blk_dev_with_part(desc, slot->boot_part);
> +			if (ret)
> +				return log_msg_ret("blk", ret);
> +			exists |= fs_exists(script_names[j]);
> +		}
> +		if (!exists)
> +			return log_msg_ret("fs", -ENOENT);
> +	}
> +	str_free_list(boot_order_list);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> +{
> +	struct distro_rauc_priv *priv;
> +	int ret;
> +	char *slot;
> +	int i;
> +	char *partitions;
> +	char *boot_order;
> +	const char *default_boot_order;
> +	const char **default_boot_order_list;
> +	char *boot_order_copy;
> +	char boot_left[BOOT_LEFT_LEN];
> +	char *parts;
> +
> +	/* Get RAUC variables or set their default values */
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order) {
> +		log_debug("BOOT_ORDER did not exist yet, setting default value\n");
> +		if (env_set("BOOT_ORDER", CONFIG_BOOTMETH_RAUC_BOOT_ORDER))
> +			return log_msg_ret("env", -EPERM);
> +		boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
> +	}
> +	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
> +	default_boot_order_list = str_to_list(default_boot_order);
> +	for (i = 0; default_boot_order_list[i]; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
> +		if (!env_get(boot_left)) {
> +			log_debug("%s did not exist yet, setting default value\n",
> +				  boot_left);
> +			if (env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES))
> +				return log_msg_ret("env", -EPERM);
> +		}
> +	}
> +	str_free_list(default_boot_order_list);
> +
> +	priv = calloc(1, sizeof(struct distro_rauc_priv));
> +	if (!priv)
> +		return log_msg_ret("buf", -ENOMEM);
> +	priv->slots = calloc(1, sizeof(struct distro_rauc_slot));
> +
> +	/* Copy default boot_order, so we can leave the original unmodified */
> +	boot_order_copy = strdup(default_boot_order);
> +	partitions = strdup(CONFIG_BOOTMETH_RAUC_PARTITIONS);
> +
> +	for (i = 1;
> +	     (parts = strsep(&partitions, " ")) &&
> +	     (slot = strsep(&boot_order_copy, " "));
> +	     i++) {
> +		struct distro_rauc_slot *s;
> +
> +		s = calloc(1, sizeof(struct distro_rauc_slot));
> +		s->name = strdup(slot);
> +		s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
> +		s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
> +		priv->slots = realloc(priv->slots, (i + 1) *
> +				      sizeof(struct distro_rauc_slot));
> +		priv->slots[i - 1] = s;
> +		priv->slots[i]->name = NULL;
> +	}
> +
> +	bflow->bootmeth_priv = priv;
> +
> +	ret = distro_rauc_scan_boot_part(bflow);
> +	if (ret < 0) {
> +		for (i = 0; priv->slots[i]->name; i++) {
> +			free(priv->slots[i]->name);
> +			free(priv->slots[i]);
> +		}
> +		free(priv);
> +		free(boot_order_copy);
> +		bflow->bootmeth_priv = NULL;
> +		return ret;
> +	}
> +
> +	bflow->state = BOOTFLOWST_READY;
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_read_file(struct udevice *dev, struct bootflow *bflow,
> +				 const char *file_path, ulong addr,
> +				 enum bootflow_img_t type, ulong *sizep)
> +{
> +	/*
> +	 * Reading individual files is not supported since we only operate on
> +	 * whole MMC devices (because we require multiple partitions).
> +	 */
> +	return log_msg_ret("Unsupported", -ENOSYS);
> +}
> +
> +static int distro_rauc_load_boot_script(struct bootflow *bflow,
> +					const struct distro_rauc_slot *slot)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	struct udevice *bootstd;
> +	const char *const *prefixes;
> +	int ret;
> +	int i;
> +	int j;
> +
> +	ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
> +	if (ret)
> +		return log_msg_ret("std", ret);
> +	prefixes = bootstd_get_prefixes(bootstd);
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	priv = bflow->bootmeth_priv;
> +	if (!priv || !priv->slots)
> +		return log_msg_ret("priv", -EINVAL);
> +
> +	bflow->part = slot->boot_part;
> +	if (!bflow->part)
> +		return log_msg_ret("part", -ENOENT);
> +
> +	ret = bootmeth_setup_fs(bflow, desc);
> +	if (ret)
> +		return log_msg_ret("set", ret);
> +
> +	for (i = 0; prefixes[i] && bflow->state != BOOTFLOWST_FILE; i++) {
> +		for (j = 0; script_names[j] && bflow->state != BOOTFLOWST_FILE; j++) {
> +			if (!bootmeth_try_file(bflow, desc, prefixes[i], script_names[j])) {
> +				log_debug("Found file '%s%s' in %s.part_%x\n",
> +					  prefixes[i], script_names[j],
> +					  bflow->dev->name, bflow->part);
> +				bflow->subdir = strdup(prefixes[i]);
> +			}
> +		}
> +	}
> +	if (bflow->state != BOOTFLOWST_FILE)
> +		return log_msg_ret("file", -ENOENT);
> +
> +	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
> +				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
> +	if (ret)
> +		return log_msg_ret("read", ret);
> +
> +	return 0;
> +}
> +
> +static int find_active_slot(char **slot_name, ulong *slot_tries)
> +{
> +	ulong tries;
> +	char boot_left[BOOT_LEFT_LEN];
> +	char *boot_order;
> +	const char **boot_order_list;
> +	bool slot_found = false;
> +	int ret;
> +	int i;
> +
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order)
> +		return log_msg_ret("env", -ENOENT);
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i] && !slot_found; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
> +		if (tries == ULONG_MAX)
> +			return log_msg_ret("env", -ENOENT);
> +
> +		if (tries) {
> +			ret = env_set_ulong(boot_left, tries - 1);
> +			if (ret)
> +				return log_msg_ret("env", ret);
> +			*slot_name = strdup(boot_order_list[i]);
> +			*slot_tries = tries;
> +			slot_found = true;
> +		}
> +	}
> +	str_free_list(boot_order_list);
> +
> +	if (!slot_found) {
> +		if (IS_ENABLED(CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES)) {
> +			log_warning("WARNING: No valid slot found\n");
> +			log_info("INFO: Resetting boot order and all slot tries\n");
> +			boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
> +			for (i = 0; boot_order_list[i]; i++) {
> +				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
> +				if (ret)
> +					return log_msg_ret("env", ret);
> +			}
> +			str_free_list(boot_order_list);
> +			ret = env_save();
> +			if (ret)
> +				return log_msg_ret("env", ret);
> +			do_reset(NULL, 0, 0, NULL);
> +		}
> +		log_err("ERROR: No valid slot found\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	const struct distro_rauc_slot *slot;
> +	char *boot_order;
> +	const char **boot_order_list;
> +	char *active_slot;
> +	ulong active_slot_tries;
> +	char raucargs[64];
> +	char boot_left[BOOT_LEFT_LEN];
> +	ulong addr;
> +	int ret = 0;
> +	int i;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	if (desc->uclass_id != UCLASS_MMC)
> +		return log_msg_ret("blk", -EINVAL);
> +	priv = bflow->bootmeth_priv;
> +
> +	/* Device info variables */
> +	ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	ret = env_set_hex("devnum", desc->devnum);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Find active, valid slot */
> +	ret = find_active_slot(&active_slot, &active_slot_tries);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Kernel command line arguments */
> +	sprintf(raucargs, "rauc.slot=%s", active_slot);
> +	ret = env_set("raucargs", raucargs);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Active slot info */
> +	slot = get_slot(priv, active_slot);
> +	if (!slot)
> +		return log_msg_ret("env", -ENOENT);
> +	ret = env_set_hex("distro_bootpart", slot->boot_part);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +	ret = env_set_hex("distro_rootpart", slot->root_part);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +	ret = env_save();
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Load distro boot script */
> +	ret = distro_rauc_load_boot_script(bflow, slot);
> +	if (ret)
> +		return log_msg_ret("load", ret);
> +
> +	log_info("INFO: Booting slot %s, %lu of %d tries left\n",
> +		 active_slot, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
> +
> +	log_debug("devtype: %s\n", env_get("devtype"));
> +	log_debug("devnum: %s\n", env_get("devnum"));
> +	log_debug("distro_bootpart: %s\n", env_get("distro_bootpart"));
> +	log_debug("distro_rootpart: %s\n", env_get("distro_rootpart"));
> +	log_debug("raucargs: %s\n", env_get("raucargs"));
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order)
> +		return log_msg_ret("env", -EPERM);
> +	log_debug("BOOT_ORDER: %s\n", boot_order);
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i]; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +		log_debug("%s: %s\n", boot_left, env_get(boot_left));
> +	}
> +	str_free_list(boot_order_list);
> +
> +	/* Run distro boot script */
> +	addr = map_to_sysmem(bflow->buf);
> +	ret = cmd_source_script(addr, NULL, NULL);
> +	if (ret)
> +		return log_msg_ret("boot", ret);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_bootmeth_bind(struct udevice *dev)
> +{
> +	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
> +
> +	plat->desc = "RAUC distro boot from MMC";
> +	plat->flags = BOOTMETHF_GLOBAL;
> +
> +	return 0;
> +}
> +
> +static struct bootmeth_ops distro_rauc_bootmeth_ops = {
> +	.check		= distro_rauc_check,
> +	.read_bootflow	= distro_rauc_read_bootflow,
> +	.read_file	= distro_rauc_read_file,
> +	.boot		= distro_rauc_boot,
> +};
> +
> +static const struct udevice_id distro_rauc_bootmeth_ids[] = {
> +	{ .compatible = "u-boot,distro-rauc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(bootmeth_rauc) = {
> +	.name		= "bootmeth_rauc",
> +	.id		= UCLASS_BOOTMETH,
> +	.of_match	= distro_rauc_bootmeth_ids,
> +	.ops		= &distro_rauc_bootmeth_ops,
> +	.bind		= distro_rauc_bootmeth_bind,
> +};
> 

