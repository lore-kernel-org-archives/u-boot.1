Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E782CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 21:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814C1846BD;
	Tue, 26 May 2026 23:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="STkVjy22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C270847C8; Tue, 26 May 2026 23:44:50 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C65A846B4
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 23:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9vCfi6aemjLTqR3p2eBQBDNywO9JFnkXagjrdNrJKh68k7jlBjTHyiZ9z90ip6mRUrhuQJlT+RlN00YrmM6pzbwTGImJGpM44UQLAAFnbz9Km/4iu7w7zn2O+5nAEBP+HaVU8r8v9LTVQgTJDmQuO+2IIoLLRRtz9TzpRKjPY9T+oDifri5cB/HNE+Atxm5apu++KuUtjKLY2kKiadT2wYXvobXDILMg9btggoDWy65orkR8lrXmKMmP1CovxhxBsMCDMrFkdX4huvnWftv4FHAySPkE+x1FsZnvLflY15Hxm80y6RrxU8wKPt07RP987/E0sh4ohYsCwNY084SHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/ltwLea6hfen9OWPRVu9tzX49i+grD/pMJvGw8vmp0=;
 b=IN9gPJMywZ7EwW1Vif2Cl1Q+wAtJtBzTdjkj/W2oxzRVGJBLCCi6ZfLnQROhpV6teYOB8XQFO/1gDeXIsCaY9aX8MVojEviMoIXkMhgKARHr0oNlRZ0rVcmjVDqDAAnwBsFiX49/gAYWVyRHgC3SnBAip/v1+M4TMwDUlC3ocJN/KZtvlVSIx+/HQCOln+G5IvW6H6BLZtQiFswJIAtTvO86vtUPuKUZZFO0Vsaxapwg7ZlKh0ORzX9PyJ4gKplW921iI4hnu5vayozaHAmIG8LPB4CYfKeuQmoTR1Iq2QBrzHhW+J0IbQhLO6NagvloUyL/FtafGRAPOJ9S/TpcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/ltwLea6hfen9OWPRVu9tzX49i+grD/pMJvGw8vmp0=;
 b=STkVjy22l3ubBKU4uFr9LQNvg0cCYZT7q4mpggLkGd6IyQXOVpAtb4nhVDbceKPc1q6lJ4B72htJ2rrsnEFciBWyhwVyBBQeXYoyHMbGQAV7v2oLuI9iA8j7O/sSw+AXOV2XGDHzvSWrXhypKpCSLe10yMI9ArJbILMhghqq2qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB9PR10MB7387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 21:44:45 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 21:44:45 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [RFC PATCH 5/9] linker_lists.h: drop _2 from section and symbol
 name prefix
In-Reply-To: <CAFLszTi-se65R5w99LSUT3BwgJbe9UrXzB7VoTVo3CSSVg9Pkw@mail.gmail.com>
 (Simon Glass's message of "Mon, 25 May 2026 09:02:50 -0600")
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-6-ravi@prevas.dk>
 <CAFLszTi-se65R5w99LSUT3BwgJbe9UrXzB7VoTVo3CSSVg9Pkw@mail.gmail.com>
Date: Tue, 26 May 2026 23:44:44 +0200
Message-ID: <874ijtg81f.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0001.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB9PR10MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fd70c2-7de9-4359-0b2d-08debb700083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|6133799003|3023799007|22082099003|56012099006|18002099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: io5iW4DLS9g/YbAgJ9JzJXEz5pvYRDoqEYYdh4k+T06wvvy78yRi7IMo9knFa65+ocMC+kJAYpfsILyeCiqY4+/BWEZ/gSjDZ5WwMIg0ojcsagfnLPGhk2ZvK063xfehD4pe/QnOp+FHEW5xYK3VGOrWgN8OQS9yYlHZmeKu2Ze5siz6qX7Wr7WKvXQbMPHuVc3KNxZp76qRm9lwZuSJCV2UYH6IJRjht6R7hFUh6i8/fnuRg9kXQhl4JwQ0By9XBkEFFeX8d79FdUHGo+mQhS5u3R2d9hGxurPpBbUKJNxOo2GBceCxmEQJW6ySca8n4PqQ8cT+U7u9pw4D/iUri6Gp7A321WcrCoqkiNuOu/Wmk6Iip+3nJqphra+FRMpk0PVA+frUPinA4hRQudjZM8nUDfJnkx3RnDIlaRIOnnzVNPdsq7sXfMNGMUx/hn+v3IOUS9IIdRAQac0a4MTJAH5XlX2Uz/BYyqRCFHgYLZOdXAOHHZ3ynbG0lcONPfwYJd0i+H0GAgDBL2kbQl9FA+2cWJbG10bE09o3IwBew7SqZJk/X6qJlVMaDdLC/fjgym+1gX0bSFCxszOiti9wxW6RZKW+QTknco8kTHdPh/ipA6iKhv8gjsK79uh9I71BwP7/6Kal7tTmfwHwWe3aaTcoXKnzjaDhR8F8bsOhd4XThzYw/Orfu0Jua/ybkqy+j1LQ++4rmvFgB3URwPly3Du0Hr28G5r9IPGxzURGjdkosCjXYyEG9WNptgOmtTzx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(6133799003)(3023799007)(22082099003)(56012099006)(18002099003)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydyqoHiqk49IMYA0sc2/Z5fB/14vjlyTqnzW/3MNWovnTIiEPgSUt7h5RGh1?=
 =?us-ascii?Q?AxJKFCHO1dffkSldOkQ7GR0vUMCyFH1d6xLxlJqm0v8hg/5V2TlhUMNNg5wX?=
 =?us-ascii?Q?VROHiHLoQxgCXkkNOnfqjUa5IngWhy5G1URim0LiDExDR7ARlw3fqhOzOlRv?=
 =?us-ascii?Q?BTeqEgjjkJwORKCZI+2sf7sjg6NIOjlJzYUAfiaQIDf/+sj3R1aJy4NoNH63?=
 =?us-ascii?Q?4rYylyLR/+EWOrSR7vSV9reNjpdhKogNsNedtdFjhzQ76ynEbnROxyv2lQT0?=
 =?us-ascii?Q?1mAoRRi9tkuCbtKrVarc1rWM7rGaPHz9tpHkgrH4va3wCyGRrWB+8SzSLRE6?=
 =?us-ascii?Q?LtMWynrGV/03iAqXdUge9vKPD+XmcT0ngq1eTXaFJaRdmG1+FLoOu53Qu8xw?=
 =?us-ascii?Q?B30MgpR1hnYgIl0Z4YHlCEtA/lprN1y1aqkCFdMF/tSZUKen4sNeQ74WPK0V?=
 =?us-ascii?Q?tRx9ugV3einbJgZ9jZtx003HVJ7HaX8GwOGGUy0vB6ktYYLDE2684VsA6ukw?=
 =?us-ascii?Q?mAL6ZQ6pypi3fSdW+XpjLZUtDz2Wyzhutgf6gH5FyaKkoJx/KR6JYfGsKRj+?=
 =?us-ascii?Q?2o3ePsXSu1zbUg9MCW8lbcbTNekzKKzcOhszKszh0fi14G5ObtcvRnrxN2Kc?=
 =?us-ascii?Q?XNVuD/ZOK+Dfabt/cNb+yZJh2WdPGbRN2tj3n28MoTxSNHR4+rNfBSSzwtsq?=
 =?us-ascii?Q?AjWyE6zQKJp2f3MGRMOaKLlBP32Fep3Qhf5njZYlCkJW+RVowH4znab8MamC?=
 =?us-ascii?Q?vgwDbefb7dRq206mGWFjVwKJCYrnc45EPbqwQutJDvrF70cwDtbEEj34+j1Y?=
 =?us-ascii?Q?9E/I/U9tR3O9V5zHCmzBO1Ak1OlOr2dOs5KsoylfPIZCKsVP8GUVbbD4awe3?=
 =?us-ascii?Q?U57t4Xt3xJDZWQwgFpWWQVs3e/+GKROB78cJrCJ9IgZVdj8G2S+Na/nBFvLk?=
 =?us-ascii?Q?KYp9Ep9ljRDjY6JDuMTWXxsWeuMPONB4EdgobfGa9aCg8ngTvdgpc6/QehlV?=
 =?us-ascii?Q?w3cpHisTWh1j5k07yyTI4dXC3nUE+rekpX6LmW1H/8RzK/mYtUlMfCqZYfmX?=
 =?us-ascii?Q?A4vYtj03wICNnL2mI0MREyTbdRSMtSf/llED1D28qnAtIq/alSFpDXG9Vuim?=
 =?us-ascii?Q?di7P4GJOnXLvLCCKIjUurTDQPOitwELhgcWqhcfFPV1988qYvHrjPhhETMxp?=
 =?us-ascii?Q?F5THgcRFCDJ5wgijNWfZhy6vjCD9SF5xJa7I4ajFB1HNiYX6El3JCeFB4wXy?=
 =?us-ascii?Q?tmWVBFkHpXQLnPwCWheQ0wU+anNsjTs578xVOx5E6N28b2/KPZVNVPriAIAo?=
 =?us-ascii?Q?/CRxHfd/TAkDRFUeIU+n0Xk1Wah9s4+iuCzk6w3TJdjRzNXdbgMVMgP6Elvp?=
 =?us-ascii?Q?qf4umYJAJnvct4G7+PzBuRYV5CzROeNX1492YG1XyKIH7Iycp/gX8m/hPN9r?=
 =?us-ascii?Q?uqViSN8gjdVk7kjY39yIEr9s/nCc2qEp1SuET+JuiSBit7yNk3PFeVQsaUny?=
 =?us-ascii?Q?XNqGQNF8bSpJz+t2gGN3p9anyrSxdJIB5OV2VnvaLDCdfQxEXTAlZ2PnN1eA?=
 =?us-ascii?Q?xqbJ6xRsaqdRoUFWX63mLaX2RYjHh64RLfNXJxShM3dKdC0yPdmCtkhGISMN?=
 =?us-ascii?Q?ZgNi9/pm0f8PHgbtE6U5k5Kn5zYcxScas4wgNwRc+Fepz6JJs+oZmE9nwUyq?=
 =?us-ascii?Q?O/1a0IZOoQKaHIsTWflAGt36IXXkFoWaYTmoajaMVLlRs2+7fzGe3fijV0ap?=
 =?us-ascii?Q?nQAlbin1VkwmYr90akpd9TJPr0KbYXo=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fd70c2-7de9-4359-0b2d-08debb700083
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:44:45.3526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6qhkVSLgu3gXKw0H9G5uBugfL6Ezmzag5avPGojIt3sVNola3BlALj9N9MJj5DKixdRldWzQSoJGRJVntTFvtKO3W2lpN7vdb9V44Xysm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7387
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

On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> linker_lists.h: drop _2 from section and symbol name prefix
>>
>> Since commit e2138cf1e60 ("linker_lists.h: drop never used ll_start,
>> ll_end macros"), which removed macros that would create
>> __u_boot_list_1 and __u_boot_list_3 sections, the first _2 in the
>> linker list section names doesn't serve any purpose and is in fact
>> just confusing. So remove it.
>>
>> There never seemed to be a reason for the symbol names to have that
>> _2, other than perhaps for consistency with the section those symbols
>> belonged to. Regardless, remove that as well.
>>
>> All linker scripts use a '__u_boot_list*' glob, so they will work just
>> the same without that common _2.
>>
>> Keep the _2_ part in the separator between list and entry names for
>> symbols, since that is called out in the documentation to allow one to
>> define sublists and iterate over those. I cannot find any current use
>> of that feature, but a later patch will make use of just that.
>>
>> [...]
>>
>> include/linker_lists.h | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>
>> diff --git a/include/linker_lists.h b/include/linker_lists.h
>> @@ -19,11 +19,11 @@
>> -#define ll_start_section_name(_list)        '__u_boot_list_2_'#_list'_1'
>> -#define ll_entry_section_name(_list, _name) '__u_boot_list_2_'#_list'_2_'#_name
>> -#define ll_end_section_name(_list)          '__u_boot_list_2_'#_list'_3'
>> +#define ll_start_section_name(_list)        '__u_boot_list_'#_list'_1'
>> +#define ll_entry_section_name(_list, _name) '__u_boot_list_'#_list'_2_'#_name
>> +#define ll_end_section_name(_list)          '__u_boot_list_'#_list'_3'
>
>>
>> -#define ll_entry_symbol_name(_list, _name) _u_boot_list_2_##_list##_2_##_name
>> +#define ll_entry_symbol_name(_list, _name) _u_boot_list_##_list##_2_##_name
>
> The linker scripts all use a '__u_boot_list*' glob, but several other
> places hard-code the old prefix and this patch does not update them:
>
> scripts/gen_ll_addressable_symbols.sh:14 greps for
>      '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*'
>   which is fed into the LTO keep-symbols build step (cmd_keep_syms_lto
> in the top-level Makefile). With the new names this matches nothing,
> so LTO builds silently lose the __ADDRESSABLE() guards.
>

> scripts/event_dump.py hard-codes
>      PREFIX_FULL = '_u_boot_list_2_evspy_info_2_'
>      PREFIX_SIMPLE = '_u_boot_list_2_evspy_info_simple_2_'
>   so the script (and test_event_dump.py) stop finding anything.
>
> test/py/conftest.py has
>      RE_UT_TEST_LIST =
> re.compile(r'[^a-zA-Z0-9_]_u_boot_list_2_ut_(.*)_2_(.*)\s*$')
>   which is how test.py enumerates ut subtests - this breaks test
> discovery for individual UT suites.

Ah yes, thanks. I wonder how I could miss those.

They are of course all trivial to update. But for the
gen_ll_addressable_symbols.sh script, I do wonder why the __ADDRESSABLE
wasn't just made part of the ll macros. It has since grown another
__stack_chk_guard, but that too should be able to just have its
ADDRESSABLE marking in the (ordinary C) TU that defines it.

Rasmus
