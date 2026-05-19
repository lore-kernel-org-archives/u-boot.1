Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E10CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AEFC84825;
	Tue, 19 May 2026 14:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="Zkx6P6KM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4A48469F; Tue, 19 May 2026 11:42:00 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4DB8056B
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OypSM5W+/TDPT7u1NSvNuOcV3L5ZaJKE3n6OfTqa2G+iYyOFhtLNnKRmlYFO1rwx12f9sh0Z3eLaX8QhBjL/yS2/VOHIiMExy+iqg32FLinPissiJ2jQS+h85oT+8SbNUqBRDoZH3dsIxMOt1QkMwhtBJUG7CCRvi6e7X4X/QQFgNASPHreAX+Dkq14FyfVAJ0VogQeY6j9CGh6NcLkH3mHGOqwPINy6UXZ/udbk78Ln3yImLnfdDrUCZiOGWOPxAAh1t3qu734NblzMelfsSu59L0ZnZnfgyO8ISNox4uZaMcVZUMl+CpWUayf5O70AVxM3RqnH4QlPROVTC08x7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opJhFBjsHO9YCHaMvPdt+savuV0545ftXla5dSZFRv8=;
 b=lgfHkhqBi5dtoo+eO3wO32NIYJY7cQC83oQirw0nJ+OgxVKMzZKLP4Svq5eP7+MPqbtdAsMQpsaU8OVxyYZOYd5YpemH2RrSPVikbSkHrBi/KzYE8oYoU++MRtTtC6W0o+TW/iAV6WLzQFfQ8giQ/X81GzPTwAcYLL+vOOQwmP2aKdVgFVyGXSsPhRfQkD47zPR6wbHCOyoPgJC0ohtujpkH3yM+5RG5lwbDTjmmUOyeaJ8geZ5jFCjHxEyERWkyM8ddbXIiH2bqyJh6ZHglINVKqGhU1iUERbhZHvNwGa3FRHjKiMc5IqRFm1Ue70EvPPGY1AeCdNWgWk2zo45Eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opJhFBjsHO9YCHaMvPdt+savuV0545ftXla5dSZFRv8=;
 b=Zkx6P6KMjtEHKp7s0rbKn+iRs8gB2THVcYgpBf6Gn5d68Lc2SSs4oZvdkWOaonSUg0sR9wyDOUTRD8gBsbqYsyY62+wSJ4sETWKYO5O0aTP0HCahh0XKxFviRYApPHQ8TeLfrYISq4KVnAyasCLBONGxI6AmgMy+RsQBeJYbSj5Z6NWFVQb0a2qUMs4NSjMRCbNPGTHpmz7WQAUaLHky3iS8cwF4a7/NqBMfuWJvuqmNOmvj+pEUyhb28E7dZjzPODpG4VwohEzbHHcr+C3qsXkADO1f0ICdMvrX4b9kzRBbuJW29lhPiajo2QLcB3K7Rz1iDMJiPjosNEMrrLfdAA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV1P194MB2321.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:1f0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 09:41:56 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 09:41:56 +0000
Message-ID: <BESP194MB2805F890F3079CBD868672C0DA002@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 19 May 2026 11:41:54 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] timer: sp804: Fix dev_read_addr error check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::9) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <ab7762a4-928c-4991-800d-148c83a8f9fe@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV1P194MB2321:EE_
X-MS-Office365-Filtering-Correlation-Id: cb015bb5-005f-4bd5-05f5-08deb58addbf
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrOxZ+gpMXNOmppem/sH2ctbwVIhlh8FqAOlG1OyMNOFAeCsMImGUNLuT8up/6uR6jWyBX8VO0zSFRh61mrmjVsPbL7zLyBF3VYKLWkEaKhImha00O41nwTFBlFSE8rBKI1Xpk+ZqyzFZKJT9+W8oMTjP6z88LOM8z5ePFq8Gm+eeMqH+3UlRHzu6rSpTtHMsoDUsaMkioNASm8TXbksz4YXmTJr/KHTxpC+tb/qSATSj+BMQ+oMPlJsur/sr0YW4ZAOymCs8oJUJOe4NYRjYSd+VeZ0Tcnx4IYqsp4AxV7G/RzNp8FrHdX5xse0TRuwnKHnirqwltnVSGHH9dbu7XzszaPLvo63mYK1lUkHfzatOLL+pSlOLTQgg4Ueg4eAraulsYxgYxwTbjQbm2xlnR4W1IQ4uJCLbaDXw93NAckDxGvuhQkOY9O2n0Ie6N0YkSFzQvI2BhFuBSN1lOPsGwtoATsrAnLNx6LDrNxnhbitVu2+/FmzzpdpgDvY8CcgipVpN7zPQn23FLU++x6nGZklFI0zTUWq1VkcdKvlD/22lZK/JGlOmXpdkyBKI+ocatkjzxs9u+VpKa+5NjWqY2v3SrtAuBa6MDyCKzR4JqK+7bHkMU4bf7+YIWTVc3jlMdMAJqz62SUTYQdA2EzqK7BwJmTG6bwNTTByPGskIjjm6BhJW7qGMq1OJIGIW3izhqL50C+CVsrN3drcV5JD9FWbcpglDDbv91fkrCcJuLXAwxtkbJJnbk93BUJ1BN8VGFI=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|5072599009|5062599005|15080799012|51005399006|37011999003|8060799015|19110799012|41001999006|23021999003|55001999006|24021099003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHFNMWhqM29yM3R1T1RQYmRpL0N3MU02Z3NWOUlObFZDbktJWStqVFhyUzNP?=
 =?utf-8?B?d2NzbjdibkgvNS9Bb0E4QWlLenZNV01TcWRVWENpUWlzU3FYZytZMjBEZlYy?=
 =?utf-8?B?aFpvVU5IZXhEVHIwZVJ3M2dsenZBWHdyZTRzMVlSSHBDd3d2M0V2TGd2VVNZ?=
 =?utf-8?B?YXgyUzlCakNGbzVpRE5ETTdUNXQzNHZKMzZhMjhxbEVqL2VHMThFWFNiQ001?=
 =?utf-8?B?T09lVnFhRWp6TzJ6eThmdnZRSm9PR0JNcUttbjM0OHE5K2RSaVRzaXNaYmFp?=
 =?utf-8?B?eng3RWtjMmtxa1VhVjZCT2Z1U0cvM2NIczZVMy9jQnJoWG1DOFNCWG1yQXNz?=
 =?utf-8?B?QzgzOGRUL0tMcUJtYUZKSW55dHJtV0FVNmZxY1YvOFRsWUNGR3ZQelJ5TkFX?=
 =?utf-8?B?NjZpWlhYWUZIUUpHckhXVVBKR1ZmQWNOT2JmYXlxNlFhU2owSml1bk1aRHNE?=
 =?utf-8?B?QnR3ZEIybmE5VDkzdGJHRWZib2RXVmJrd2QvNnJRVTl1aDlNZ3h1SnkwUUpT?=
 =?utf-8?B?LzQ3dGE4L2RLcnZ5bkRiTVJRdnh5ZkhMUkFtOHZQMHB3YTlPbTA5ZUpIWmZ0?=
 =?utf-8?B?TEFVbS9IZTRIRG5lSm1UZ25GalVRNCtDdE1sSXRCYjVzL3AwVUZrV3NaRkhF?=
 =?utf-8?B?UWxDV3BaNmZsNGlYdkFBZ3NuSGgxbllFck9EQ3g0bUVsSVVVV2ZnbmR3bW5n?=
 =?utf-8?B?MDRnaDRTZWU0NjB3cm8vTEMweFRIUW5VTGpNR3BlRTZnTmd6RHRKcWd4dlE3?=
 =?utf-8?B?WEd6N1ZTckhHMXUzQzJvR0paMmtIYXh5Uk5zeFRUSWZQRy9BMjZoZHp4bGE3?=
 =?utf-8?B?TVVOOXFLZXNTRjduYXBBREhhRm9PVWUzaGgwVFA5akUzZURZRk9rRFMvaFJy?=
 =?utf-8?B?cjJ1eUNEMmdvR0FmM3lkdnlPVW90WXRBWEFITjg5SkFrRVRXaTY5bEVSMGhF?=
 =?utf-8?B?TnQ0OVRoUis0K3R2ZGNBQkFMSStaNHBtZWVHVUxxYUMvOGt1bWhQemF0ZXpB?=
 =?utf-8?B?aXQzanh4YVFPemRvRTZVOC9VdUtjR1RwSVpZMUpmSmJobVpZa2JDdmJpL0pH?=
 =?utf-8?B?eGxuVUkxZWk4a0JWMnJ3cnNpL1pZdTdhM2VBMkt3UlkyZEw2Z0l3bXh1bHlQ?=
 =?utf-8?B?R3phc1Y3Z1p1Nnl1NEdyUURrcWttMGx1emtUaTRKa0dxOC9LQVBnNVpWK2NL?=
 =?utf-8?B?eXM0YjlBalc2cUhGVmo0ZCtMYVVuMmo1cWtweTVXMjdBVjhWVU9IbEFBd2p0?=
 =?utf-8?B?MkRyL2RhbkFScjFXYjhKSmIwWm5PL05yKzQ1VVE0R05HbWRNVFd5WEpXS2ta?=
 =?utf-8?B?dXRJc0NObWdOTHdWQ3lGdS9jRk1TUzU5STV6Y3ZrSGZIS01Dc05Mamw0TWhQ?=
 =?utf-8?B?T0ZWOUJCZDhaODZ3elpHMVdNVFNQRVd2UU1uaDVoRjhudW51aU4xYzZxUHpX?=
 =?utf-8?B?UlNVQzdEZHIva0lPNkdoeGdXWmtZYTNMdVczQzdRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUU3SktML2R3MVR3TkpMUUloOXN1SDFuUDVtMUY5YzczZUVtaFg4QmhPQ0pY?=
 =?utf-8?B?dUhUL1Mwd3R0aDYwcEYvTkp1T280aGRSMHdaWHFqaThqdjUyelVyNkNTdFVL?=
 =?utf-8?B?Sy9Td3BZYnQ2SGN1MTgxMUZuUVBZNHAwcGoxYzBWb0JHWkxJMy9vczJ3QmVv?=
 =?utf-8?B?VmxwbllxUmdQSGEvWXZScm94aHB5ZVhUSXdkUXp2NGtuRktIWUxHYTdmQzJo?=
 =?utf-8?B?ZEVtOFJDZDlzUkJaTFVtWFAyMkt3Y05xSlRQSS8rZHMwTDRGRzkrV0l5cDc0?=
 =?utf-8?B?VVdoNmdISEJWTWxGcm9SaTRSNW50d0EyWk5ZZ3V1SGVUdVhTQnp0Zmg5TkJt?=
 =?utf-8?B?djU5aUlkUDh2eDF4d0JsL3ZsTVpNRXlzRERaSnFuQ3ZSQmMzejVrMVBFZ0tt?=
 =?utf-8?B?bHo1cmdmZ3dlaWJYT0N4TTlZMHVzL3JmOWVIOFlOTzlLOFVQcGdzL1VqTHhU?=
 =?utf-8?B?eUs3dkFmc3BIR3pNY0kzMjNIaENrcDBwNGp5RVNlTWxmWWx2TjFCVTE3cnZK?=
 =?utf-8?B?bmI5dmdxU3UrUU81RGFtUWs1MXhtQk5NM0VST2hqSDNTb1JtR1c2OG14Wjlh?=
 =?utf-8?B?RnBFSlFRamdCOHpDQi9LTTRYNWhmVzhPbzNyRmo0K3pkdjlQSUNHWFRHdVgr?=
 =?utf-8?B?eDJQeVhYWS9hSzRGUzNLUVJwOVAyMWMwYWl2elhldVlEdGtMWDdrWHFKTUU5?=
 =?utf-8?B?WXRaUzE2WU5BZDdEcll3WW40M1JaS0xXNnovWWRaYjZuaDNiam4yQzU4b3ZS?=
 =?utf-8?B?ZVM1NVRTdzdEUGYwZ3g3MmR5T2lGZDZvTjg3ZzFBY0dMeUNqOFozK29qQ1N1?=
 =?utf-8?B?YmZaV0h0bnJtWk5oT3FEV3drSjdQWnN1S1dVOXlxUnE4Z2lIanRrWXNBTmpX?=
 =?utf-8?B?d211ZmR3ZzlEaDNHTldoZmRKVWJMN1FYZGkvYTI2czkyL2pVNE85eGRlcTgv?=
 =?utf-8?B?bXJWSjYzc0N3Q3JQa1hzNHR4eFc3am1yNUNEY3FzRmZVd3AxNmRKUFJqYnhj?=
 =?utf-8?B?ZStubmNhR0JWUExEVUQyNWlkUmFwOG9ic21jMFFoa3ZINDBDcUxlVnpQNmcr?=
 =?utf-8?B?c3JmV0JMZFkraGhSUUhmNTJETkxldXZJUWxITUxjVG0yMmoybkNVa0tmdW9o?=
 =?utf-8?B?RGFFODRMeVUrelhscTNBUWpEMkM1ZGUybWtobGVMdHljZ1VKZHJsbGdzQUJw?=
 =?utf-8?B?RktHVHRwak92cFRyU2RkZTRsaldKVS9zdnBSK3FXK3c5a0xDUnVJOFpFK042?=
 =?utf-8?B?L29BNVppdEgwWXMrYmpWanZuOFZvQjNwMmcwTHNCOTh6YjA1WHdUWVM5UnlF?=
 =?utf-8?B?dUkrVUJ2bjZOdHl5Z1NHRHBmYlByU3NtOVRvbTljVCtNZWdmT0FzTGE4ZXc1?=
 =?utf-8?B?UCtRNStOU0taK2ZTZVpEd2ErK2RzQnlDdTlkRzVFeVRRcnM1WHprY1RjK21i?=
 =?utf-8?B?dnF2ZC9QcmZaSmhKYy9XbU5hWDhXbFVDZjdOSGNOZ1RYTjcxV1gzbWdBSGRF?=
 =?utf-8?B?S1hURWlNd1UwMC9nV05tbkpJT090dHRpbWZZRDI4Rk5FWHlSVnppOTRyTHVK?=
 =?utf-8?B?QzFvcEc4dG1sYm1aVkFub3dSZXNPRmd6aWtiMFc0elBCUTNFOGVFM0huTUlq?=
 =?utf-8?B?eU44WjRsQlVGblBZQks5Z3F3K3NOSWc1UitLeTZON1RTcy9Hc1lUUFlZaUVB?=
 =?utf-8?B?MHhKd2RVWWkweXQwbFJCNGdINUJJOUtyYjJlYXZuL1EvNXdMOGJ3RHVBUjB0?=
 =?utf-8?B?VW04UHhtcFhzWUxVWHl1RlFPVXdXVklhZ2lieTM0K0c5bG8zMnhybC9Pc2VW?=
 =?utf-8?B?L2JmbkdTSmcwTjBBazgzTVpaQkxubkJUT1NSWE5nYlVkeHh6RVJXM0RzaTZk?=
 =?utf-8?Q?1mSADsAzYjuqd?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cb015bb5-005f-4bd5-05f5-08deb58addbf
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:41:56.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P194MB2321
X-Mailman-Approved-At: Tue, 19 May 2026 14:56:05 +0200
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

dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
and not 0.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/timer/sp804_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/sp804_timer.c b/drivers/timer/sp804_timer.c
index 05532e3330c..d1a5fc8c5bf 100644
--- a/drivers/timer/sp804_timer.c
+++ b/drivers/timer/sp804_timer.c
@@ -44,7 +44,7 @@ static int sp804_clk_of_to_plat(struct udevice *dev)
 	struct sp804_timer_plat *plat = dev_get_plat(dev);
 
 	plat->base = dev_read_addr(dev);
-	if (!plat->base)
+	if (plat->base == FDT_ADDR_T_NONE)
 		return -ENOENT;
 
 	return 0;
-- 
2.43.0

