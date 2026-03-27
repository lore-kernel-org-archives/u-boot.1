Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF8210ED67F
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 14:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D9183C14;
	Fri, 27 Mar 2026 15:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NfXuDRY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F9C83DBF; Fri, 27 Mar 2026 15:46:20 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD1181E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijImuy8QPSWla/4bqyOUEcT/ci6K93n9C9KN3LJ3ItA/bhF9EPUoWUq2cN0gDb1lfAusI/uxu7uKlPmR6LZDERni8XqEMFJVOIdcyu1pFJRvPBs1MPklkLpm9v4sHA++jng+u7z0qOlMsJZav/ftbd2OK9DfcvpZJRGKJ7O0RA9235QeDNhWiaJk4LxCFh0m4zdQB27UH8zy0P3oQv79bzSpju1ndFoqdFQAgZsgbk8f06dR3Riui60G1txCIhCUbo1YVQLu/ggmgeq2MIFgwFAqdBOQbD3RjJ5DlRjUbL3oSVmNcSQBn3IrXPdnSdOOXG4Poh4LSOignKNwTSKq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/cgsKE0sBIYOoQz9sRkCvH2OzyoyTi6V6b/nubJoDc=;
 b=HCA/vKm8wboAtyTGm5MGi9bXm0Fs7+kYj5rOchfOA2wC3L9DNdyu8NWxzlwgtc+5pN0pf9w9B3df/8bdb4uV+x62CrkISM3gwa7+AQWOv3Qu6nBYuEXr9wY0ENb3WYKzASYuNN3wZ04xxCd4e/SGS4Byuhp2H/PW3sAhfZRbkdnsO6kH5OBCdpUBRJSBcydTonBFgJGIc3u9absDT5mZkT+J7ocVyvNozDiNi3YeZnlS9VkGDodmbUmFWGVtgi1P8KqXbo8pgLS6KemmoJLEuAxSDpLNOmL19wKEn1QBPV9/R1hh6KRfCM4aBAhLdIoDeNiJ0nJRi8btTJxqNgJDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/cgsKE0sBIYOoQz9sRkCvH2OzyoyTi6V6b/nubJoDc=;
 b=NfXuDRY1hvLTxLLX9haA65u7v7+Pl0AqaT6Zy52TazjdFq61u0+v9o7zyz8JpqazcDeB1TUGZLis3Y6P3oddDzTPxJex/17LaMcYurENmxiRato5kfAm9fHILZhC9owUIyDsRdGPKZoTUnsvVoDvQHKGX9s7/1DVrCFNT0q/YfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB8PR10MB3499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:137::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 14:46:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 14:46:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Heinrich
 Schuchardt <xypron.glpk@gmx.de>,  Ion Agorria <ion@agorria.com>,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Patrice Chotard
 <patrice.chotard@foss.st.com>,  Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/2] kbuild: Use relative paths in generated .incbin
 directives
In-Reply-To: <CAFLszTj-SBhSsrrsDwS0qWeRysno+M9fGhcZL6i0N+tbzbREUg@mail.gmail.com>
 (Simon Glass's message of "Fri, 27 Mar 2026 06:44:30 -0600")
References: <20260326115500.955388-1-sjg@chromium.org>
 <20260326115500.955388-2-sjg@chromium.org> <87cy0plmh8.fsf@prevas.dk>
 <875x6hlg8k.fsf@prevas.dk>
 <CAFLszTj-SBhSsrrsDwS0qWeRysno+M9fGhcZL6i0N+tbzbREUg@mail.gmail.com>
Date: Fri, 27 Mar 2026 15:46:13 +0100
Message-ID: <871ph5l496.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F6D2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::653) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB8PR10MB3499:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a6c4e6-61d8-4a80-feb8-08de8c0f9898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fdbnolYJB8HtgPhVECs1T3mjSLYLvwpa6/ujQTP65RqRncH80d2UoAP2fgJ67M8jxRf9pb9fpdezEFbpLlTxVg4EFWRmAjgHyH233mMhGkJ+hCTyfPkLjetYIWEQ3h06VQaY2p6SXHPvK79OTRosKBGAHAAT39GjzbjUHaatlFwOTlQ5kjNPqzQiLnkE6MghoKKbxNwULKIMRlSJXl0o8SUX3n2827Kikg2OhLS1uWoFGZ6gb/ilySj1U06FaegA+xe33Be8cqv7FVUfPvktpW9JASgZsA2ZZ/EA4lJVctwvS6NlX2VMq5R1XMyd8KW31lsngMjATe5my4A/BrOyH9BK9gCSfWxAbaD0JarJ1D93xa+HPjSF1GbBIsG+C9I8pZyVziPffcBCCAekTSO1ozRBJRVFhga/59rXqwaTb02odaoIIAvEGyBArD7K7D6q2BU3Y2NQsutXBERqhe1fbcZu5JdVqHuu4slU+NuVE/c/8EwU4QPK3I0Nrj+zq0m+MU9PiaNhZjyqM4OKeOfn+64UmyOc0Fs6WA5y6qiSJJN8TKgkL4zcLuceoG4zguqteXTSwSZUB5LefUe25RkSJyu5o2DgPaJPN8FPiQxVZxB5i2vD1BrIcX4mBvJdQtHy80vrCd40sFKBaEul+NyQJE7PPh+ykNUN8Bz7dGu4CCuFBhUUcCfLVV/G1vJUvYNx/kireWsFoJAHCEZwep5HZ26pC6kYfmZpFUzBFCUCQjwZ0qdb4Z3DDyVJRaAurFgfIIYD1oa3Iy8oaJrKSb2NQRY/mCfoI1AI+X3o349gTPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o53XEGbKC+mAb5LMhwKdg1cE/0ut+FXY5udIqHPHLL5KmlD6WSjsNAV6KQNn?=
 =?us-ascii?Q?4m22O6qew+Vix/TC1KrY5wQoFMULOnRgvEYP+1RnnYxjrhmXRULrwum811Xy?=
 =?us-ascii?Q?qm5DXJOblrSrbdkGx10aeQMHtCok8dhRthWNGDy0nqPu8J8kdbalYI4rbPBN?=
 =?us-ascii?Q?5orlK0w7M4LRngz/mSS3CmIr7zDdX/6hdnoJ86mZn0K3J6VEcL/7U3ux0fm3?=
 =?us-ascii?Q?SdzSGioBl+lK53oMkWNvGgsAgu8V3uNn4ZPgAnznoTdxAS9XpGwgNAXXcEg7?=
 =?us-ascii?Q?w75UdygbsP38KTy+SrRB4vmtO7nR2qi88XA6HqJdeKPSRofSpuSWloDKwmaY?=
 =?us-ascii?Q?Lg3LWeaYmFk8mMArNbb2lzbYwOg5FmyeMMU0Yzw7BPM2XCOTxGskdz4GYjAu?=
 =?us-ascii?Q?+W034fzMD+4NeVx0UrJQ14H1dU0EU+uvTcclZ3/IO7jjKOavaqKgY6xgjg0w?=
 =?us-ascii?Q?cblKuw/j71HNfYTZFOtgcl61I1Cq0Ju6Vq7EdYkGoBph+PHeDm27eHu07xAC?=
 =?us-ascii?Q?6P4yajb9EFWIvQOfOMzPnvQome8UkeF+/ISP6/psy96qwOWtbIhrKlzZUJu7?=
 =?us-ascii?Q?Gc7fHNstTrOIMk0dg464a5k40gFLycc0CMzDW5xQqdtbZt5bDygagk6Lf9Mp?=
 =?us-ascii?Q?LcilrhVJ+uTDGh6mgFbKBBtt3usBESD4kj/v1xQ/mVWBtNcGffeQufmSh+dQ?=
 =?us-ascii?Q?13PfecRE3u38gm206opOv+foGPZfXTRvlq4ZLkWUJ5MS5FHdaGugSaoi2hqj?=
 =?us-ascii?Q?AaMGIkMwWz+ZRiCxuiCH2o8gIHMiizbg1p9AVzuX/h3rXRInU5T01jGY4ziB?=
 =?us-ascii?Q?VG+XmQYFkJ3KMLq4ugFBt6dgzr6CpFFwcPhtwXSyRqo0CsXtjsAcVsUl5vTu?=
 =?us-ascii?Q?iCVzQ7n+kTbqmmBIvKeFIaYyKSlnjdxDeqCcoV8toyjHd/cJ6b0e/is5fAVD?=
 =?us-ascii?Q?4wi+Sqcj3JuU0YfRoDaIKd6nKNJOgRLFlYn2RM3599UOp3VHu4FCfIwITR+u?=
 =?us-ascii?Q?JrUQVkgeShQvPCzO8LVJpWJZQhDSISOls7xMcrbZnUM7Y9NkkKu6eoFfY9eF?=
 =?us-ascii?Q?4X8LGV9+PwcSEcF99KACSjVNxQL6DXihAh+Og3u1TOyCHHvPo6dm7ilAk5Jr?=
 =?us-ascii?Q?Pmr+w0w5ZG39pVgs0nAlk0HH6GkGDE3G8cMG5KVh+UNsdviffP1YbOAvOLyZ?=
 =?us-ascii?Q?GCxflHudAphQFh/yZyLe2C3PX3HFVNar/uDYSEmiMj2af65IMNpp0TinMUKQ?=
 =?us-ascii?Q?plHK2d2otn4DO6kG87uzQAKdCwiDV7UmOOtQQAAhAuXVxqOTfYpYyZYetp6d?=
 =?us-ascii?Q?CBoqeq5zORIVKttu7MfCgy998/OywY0HDhS6404bMHWlD2QG9wjGQFSYQsM/?=
 =?us-ascii?Q?xjMddi6T/ffRCDlHkDyfQDwOGhuuTe1FM9tohAwuX+QTF/vESzbNMAgck+gI?=
 =?us-ascii?Q?cI/5Iurg1rsjJg51iHsP1yxmu1e4+czHJ7zcc72jThJQ6MWuXLGuS6T9G2zS?=
 =?us-ascii?Q?OOuMRQlR3nRF4ZUI+1gn2/95Gc6DRPDqRyNdHsQ+8YWEXFIjD99PjdazmPlg?=
 =?us-ascii?Q?jK+MS3ukwneg7bj4c9hnyymCEs70pQ/ggQAJHLR997sKDHQj7OWxHl/IXUvf?=
 =?us-ascii?Q?4LV+yo8g6XTA97xvBBGOvVhyNfteqJ4F0QJxSUKywfGo9t48ZToBLekfY648?=
 =?us-ascii?Q?vzMNeazC9vHQUJmdBXir8NCPzRN30Z8biCcJVUswPLrAfC5KhsxwU9QoY8/M?=
 =?us-ascii?Q?TT0Xc3hJWej/NixC/d1vEunEpstLbas=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a6c4e6-61d8-4a80-feb8-08de8c0f9898
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 14:46:14.7409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: At2KzWgv6NXQbSfpLrO4LJ53FisJlCRY5pDRDArvHUqPunoFCy1DdcQzObejiajKzgyECD9phoR7HfbgM8vjyeLPGCdSp6xf0Bl5thrYEgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3499
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

On Fri, Mar 27 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On Fri, 27 Mar 2026 at 04:27, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> On Fri, Mar 27 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> > On Thu, Mar 26 2026, Simon Glass <sjg@chromium.org> wrote:
>> >
>> >> The generated .S files for fonts and splash screens use .incbin with the
>> >> full prerequisite path. When building with O= this bakes an absolute
>> >> path into the .S file. If the build directory is later used on a
>> >> different machine (e.g. in a container), the assembler cannot find the
>> >> source file.
>> >
>> > I must be missing something, because I can't see how this can be a
>> > problem, while all the other absolute paths to the source dir that go
>> > into files generated in the build directory is not. For example, there's
>> > a top-level "source -> /path/to/u-boot" symlink created, and as far as I
>> > can tell, all the .foo.o.cmd files end up full of such references as
>> > well, e.g. $BUILD/lib/.vsprintf.o.cmd contains
>> >
>> > source_lib/vsprintf.o := /path/to/u-boot/lib/vsprintf.c
>
>>
>> OK, I can sort-of reproduce, though I don't know if what I did is
>> representable for your use case. No containers involved, just moved the
>> source directory.
>>
>>   # original source dir
>>   $ cd /tmp/u-boot
>>   $ make O=/tmp/build sandbox_defconfig
>>   $ make O=/tmp/build -j7
>>   $ cd /tmp ; mv u-boot u-boot-new ; cd u-boot-new
>>   $ make O=/tmp/build -j7
>>
>> This breaks as you describe, but most files simply get rebuilt due to
>> their .cmd files containing stale references to /tmp/u-boot/. Which
>> suggests that the bug is really the lack of a .S.cmd file describing how
>> the .S file was created in the first place.
>>
>> This seems to be a better fix, which also causes the .S files to be
>> generated anew if one does some actual change to the rule:
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 7386353e0cc..b2441080e7e 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -526,8 +526,8 @@ cmd_S_ttf=                                          \
>>         echo '.balign 16';                              \
>>  ) > $@
>>
>> -$(obj)/%.S: $(src)/%.ttf
>> -       $(call cmd,S_ttf)
>> +$(obj)/%.S: $(src)/%.ttf FORCE
>> +       $(call if_changed,S_ttf)
>>
>>  # Splash logos
>>  # ---------------------------------------------------------------------------
>> @@ -547,8 +547,8 @@ cmd_S_splash=                                               \
>>         echo '.balign 16';                              \
>>  ) > $@
>>
>> -$(obj)/%.S: $(src)/%.bmp
>> -       $(call cmd,S_splash)
>> +$(obj)/%.S: $(src)/%.bmp FORCE
>> +       $(call if_changed,S_splash)
>>
>>  # EFI applications
>>  # A Makefile target *.efi is built as EFI application.
>>
>> See e.g. kernel commit a7f9241909 which did essentially the same change
>> to the .dtb -> .S rule back in 2018.
>>
>> It still makes sense to put these rules in a u-boot specific makefile,
>> but this should avoid the need for each font .o file to need those
>> AFLAGS changes.
>
> Sure, but it causes the font/logo .S files to be rebuilt on every make
> invocation. How did you test this?

I didn't really test it beyond what I wrote, and I saw that the .cmd
file got rewritten and the whole second build succeeded. I did not think
to run the build twice from the same, unmoved, source repo.

> It would be nice to use if_changed though. It needs the .cmd file to
> be loaded via -include, which only happens for files in the targets
> variable. The generated .S files are never added to targets, so cmd_$@
> is always empty and if_changed always rebuilds.

Ah, yes, I did look at the logic for which .cmd files got included, but
yes, I didn't really think about whether the new ones would be or think
to test whether they were.

> The kernel commit you referenced (a7f9241909) works for DTB because
> .dtb.o has a compound suffix with a matching intermediate_targets
> entry. We could follow the same convention, renaming to .ttf.o/.bmp.o
> and adding:
>
> targets += $(call intermediate_targets, .ttf.o, .ttf.S) \
>            $(call intermediate_targets, .bmp.o, .bmp.S)
>
> The pattern stem stays the same, so symbol names are unaffected. What
> do you think?

Yes, that definitely seems to be the right approach, because it follows
the existing pattern for .dtb -> .dtb.S -> .dtb.o and similar.

Rasmus
